unit uActionDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, DB, ADODB, DBCtrls, Dialogs, Variants,
  UCCenterJournalNetZkz, uActionCore, Messages;

type
  TSetParamProc = procedure(Value: Variant) of Object;

  TParamObj = class(TObject)
  private
    FLookup: TDBLookupControl;
    FSetParam: TSetParamProc;
    FNullValue: Variant;
  public
    property Lookup: TDBLookupControl read FLookup write FLookup;
    property SetParam: TSetParamProc read FSetParam write FSetParam;
    property NullValue: Variant read FNullValue write FNullValue;
  end;

  TActionDlg = class(TForm)
    dsResStatus: TDataSource;
    dsSrcStatus: TDataSource;
    dsAction: TDataSource;
    dsSrcBasis: TDataSource;
    dsResBasis: TDataSource;
    PanelOrderItem: TPanel;
    pnlTop_Order: TPanel;
    pnlTop_Price: TPanel;
    pnlTop_Client: TPanel;
    PanelSMS: TPanel;
    cbSendMessage: TCheckBox;
    edSMSText: TMemo;
    cbSendEmail: TCheckBox;
    Panel1: TPanel;
    Label1: TLabel;
    lcSrcStatus: TDBLookupComboBox;
    Label2: TLabel;
    Label3: TLabel;
    lcSrcBasis: TDBLookupComboBox;
    Label5: TLabel;
    lcResBasis: TDBLookupComboBox;
    Label4: TLabel;
    lcResStatus: TDBLookupComboBox;
    Label6: TLabel;
    edComments: TMemo;
    Panel2: TPanel;
    OKBtn: TButton;
    CancelBtn: TButton;
    lbAction: TDBLookupListBox;
    ExecTimer: TTimer;
    LabelAction: TLabel;
    PanelAddFields: TPanel;
    lbHistoryComments: TLabel;
    edHistoryComments: TMemo;
    lblSNote: TLabel;
    edSNote: TMemo;
    lbHistoryExecMsg: TLabel;
    edHistoryExecMsg: TMemo;
    Bevel1: TBevel;
    procedure lcResStatusCloseUp(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lcSrcBasisCloseUp(Sender: TObject);
    procedure lcResBasisCloseUp(Sender: TObject);
    procedure lbActionClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ExecTimerTimer(Sender: TObject);
  private
    { Private declarations }
    FActionType: Integer;
    FOrderId: Integer;
    FBPId: Integer;
    FInitActionCode: string;
    FActionCode: string;
    FSrcBasisId: Integer;
    FSrcStatusId: Integer;
    FResBasisId: Integer;
    FResStatusId: Integer;
    FUserId: Integer;
    FOrderItem: TJSO_OrderHeaderItem;
    FSpecItem: TJSO_ItemOrder;
    FSubItemId: Integer;
    FUserSession: TUserSession;
    FActionCore: TActionCore;
    FParamList: TStringList;
    FInitProcess: Boolean;
    FDoExec: Boolean;
    FReserveType: TReserveType;
    FSMSEnabled: Boolean;
    FNotShowCheckError: Boolean;
    procedure InitControls;
    procedure InitSrcStatus;
    procedure Inititialize;
    procedure SetParam(Value: Variant; ParamName: string);
    procedure SetAction(Value: Variant);
    procedure SetSrcBasis(Value: Variant);
    procedure SetResBasis(Value: Variant);
    procedure SetResStatus(Value: Variant);
    procedure UpdResStatus;
    procedure UpdSrcBasis;
    procedure UpdResBasis;
    procedure SetParamEnabled(ParamName: string; Value: Boolean);
    function CheckValues(var ErrMsg: string): Boolean;
    procedure UpdSMSControls;
    procedure UpdActionCore;
    procedure EnableCtrls(Value: Boolean);
    class function InnerExecute(AOrderId: Integer; ABPId: Integer; UserId: Integer;
      OrderItem: TJSO_OrderHeaderItem; UserSession: TUserSession;
      SpecItem: TJSO_ItemOrder; SubItemId: Integer;
      ActionCode: string; SrcBasisId: Variant; ResBasisId: Variant;
      DoExec: Boolean; ReserveType: TReserveType = rtNone): Boolean; overload;
  public
    { Public declarations }
    class function Execute(AOrderId: Integer; ABPId: Integer; UserId: Integer;
      OrderItem: TJSO_OrderHeaderItem; UserSession: TUserSession;
      SpecItem: TJSO_ItemOrder; SubItemId: Integer): Boolean; overload;
    class function Execute(AOrderId: Integer; ABPId: Integer; UserId: Integer;
      OrderItem: TJSO_OrderHeaderItem; UserSession: TUserSession;
      SpecItem: TJSO_ItemOrder; SubItemId: Integer;
       ActionCode: string; SrcBasisId: Variant; ResBasisId: Variant;
       ReserveType: TReserveType = rtNone): Boolean; overload;
  end;

var
  ActionDlg: TActionDlg;

implementation

{$R *.dfm}

uses UMain, uDMJSO, UtilsBase, uSprJoin, uSprQuery, Math, Util;

class function TActionDlg.Execute(AOrderId: Integer; ABPId: Integer; UserId: Integer;
      OrderItem: TJSO_OrderHeaderItem; UserSession: TUserSession; SpecItem: TJSO_ItemOrder; SubItemId: Integer): Boolean;
begin
  Result := InnerExecute(AOrderId, ABPId, UserId,
      OrderItem, UserSession,
      SpecItem, SubItemId,
      '', 0, 0, false);
end;

class function TActionDlg.Execute(AOrderId: Integer; ABPId: Integer; UserId: Integer;
      OrderItem: TJSO_OrderHeaderItem; UserSession: TUserSession;
      SpecItem: TJSO_ItemOrder; SubItemId: Integer;
      ActionCode: string; SrcBasisId: Variant; ResBasisId: Variant;
      ReserveType: TReserveType = rtNone): Boolean;
begin
  Result := InnerExecute(AOrderId, ABPId, UserId,
      OrderItem, UserSession,
      SpecItem, SubItemId,
      ActionCode, SrcBasisId, ResBasisId, true, ReserveType);
end;

class function TActionDlg.InnerExecute(AOrderId: Integer; ABPId: Integer; UserId: Integer;
      OrderItem: TJSO_OrderHeaderItem; UserSession: TUserSession;
      SpecItem: TJSO_ItemOrder; SubItemId: Integer;
      ActionCode: string; SrcBasisId: Variant; ResBasisId: Variant; DoExec: Boolean;
      ReserveType: TReserveType = rtNone): Boolean;
begin
  with TActionDlg.Create(nil) do
  try
    FInitProcess := False;
    FOrderId := AOrderId;
    FBPId := ABPId;
    FUserId := UserId;
    FOrderItem := OrderItem;
    FSpecItem := SpecItem;
    FSubItemId := SubItemId;
    FUserSession := UserSession;
    FInitActionCode := ActionCode;
    FActionCode := '';
    FActionType := 0;
    FSrcBasisId := SrcBasisId;
    FResBasisId := ResBasisId;
    FSrcStatusId := 0;
    FResStatusId := 0;
    FReserveType := ReserveType;
    FDoExec := DoExec;
    FNotShowCheckError := FDoExec;
    try
      Inititialize;
      InitSrcStatus;
      InitControls;

      Result := ShowModal = mrOk;
    except
      on E: Exception do
      begin
        ShowError(E.Message);
        Result := false;
      end;
    end;
  finally
    Free;
  end;
end;

procedure TActionDlg.Inititialize;

  procedure AddParam(Name: string; Lookup: TDBLookupControl; Proc: TSetParamProc; NullValue: Variant);
  var
    vObj: TParamObj;
  begin
    vObj := TParamObj.Create;
    vObj.Lookup := Lookup;
    vObj.SetParam := Proc;
    vObj.NullValue := NullValue;
    FParamList.AddObject(Name, vObj);
  end;

var
  vAddFields: TOrderHeaderHAddFields;
begin
  edSMSText.Clear;
  FSMSEnabled := False;
  ExecTimer.Enabled := False;
  LabelAction.Caption := '';
  FActionCore := TActionCore.Create(Self, Form1.ADOC_STAT, FUserId, FOrderItem, FUserSession);
  FActionCore.SpecItem := FSpecItem;
  FActionCore.SubItemId := FSubItemId;
  FActionCore.ReserveType := FReserveType;
  FParamList := TStringList.Create;
  AddParam('Action', lbAction, Self.SetAction, '');
  AddParam('SrcBasis', lcSrcBasis, Self.SetSrcBasis, 0);
  AddParam('ResBasis', lcResBasis, Self.SetResBasis, 0);
  AddParam('ResStatus', lcResStatus, Self.SetResStatus, 0);
  AddParam('SrcStatus', lcSrcStatus, nil, 0);
  vAddFields := dmJSO.GetOrderHAddFields(FOrderID);
  edHistoryComments.Text := vAddFields.HistoryComments;
  edHistoryExecMsg.Text := vAddFields.HistoryExecMsg;
  edSNote.Text := FOrderItem.SNote;
end;

procedure TActionDlg.SetParam(Value: Variant; ParamName: string);
var
  vIdx: Integer;
  vParam: TParamObj;
  vLC: TDBLookupComboBox;
  vLB: TDBLookupListBox;
begin
  vIdx := FParamList.IndexOf(ParamName);
  if vIdx = - 1 then
    raise Exception.Create('Не найден параметр ' + ParamName);

  vLC := nil;
  vLB := nil;

  vParam := TParamObj(FParamList.Objects[vIdx]);
  if vParam.Lookup is TDBLookupComboBox then
    vLC := TDBLookupComboBox(vParam.Lookup);
  if vParam.Lookup is TDBLookupListBox then
    vLB := TDBLookupListBox(vParam.Lookup);

  if Assigned(vLC) then
  begin
    if not VarIsAssigned(Value) or
       (not vLC.ListSource.DataSet.Locate(vLC.KeyField, Value, []))
    then
    begin
      vLC.KeyValue := Null;
      if Assigned(vParam.SetParam) then
        vParam.SetParam(vParam.NullValue);
    end
    else
    begin
      vLC.KeyValue := Value;
      if Assigned(vParam.SetParam) then
        vParam.SetParam(Value);
    end;
  end
  else
  if Assigned(vLB) then
  begin
    if not VarIsAssigned(Value) or
       (not vLB.ListSource.DataSet.Locate(vLB.KeyField, Value, []))
    then
    begin
      vLB.KeyValue := Null;
      if Assigned(vParam.SetParam) then
        vParam.SetParam(vParam.NullValue);
    end
    else
    begin
      vLB.KeyValue := Value;
      if Assigned(vParam.SetParam) then
        vParam.SetParam(Value);
    end;
  end
end;

procedure TActionDlg.SetParamEnabled(ParamName: string; Value: Boolean);
var
  vIdx: Integer;
  vParam: TParamObj;
  vLC: TDBLookupComboBox;
  vLB: TDBLookupListBox;
begin
  vIdx := FParamList.IndexOf(ParamName);
  if vIdx = - 1 then
    raise Exception.Create('Не найден параметр ' + ParamName);
  vParam := TParamObj(FParamList.Objects[vIdx]);
  vParam.Lookup.Enabled := Value;

  if vParam.Lookup is TDBLookupComboBox then
    vLC := TDBLookupComboBox(vParam.Lookup);
  if vParam.Lookup is TDBLookupListBox then
    vLB := TDBLookupListBox(vParam.Lookup);

  if Assigned(vLC) then
  begin
    if Value then
      vLC.Color := clWindow
    else
      vLC.Color := clBtnFace;
  end else
  if Assigned(vLB) then
  begin
    if Value then
      vLB.Color := clWindow
    else
      vLB.Color := clBtnFace;
  end;
end;

procedure TActionDlg.InitSrcStatus;
begin
  FSrcStatusId := FActionCore.GetLastOrderStatus(FOrderId);
  {spGetLastOrderStatus.Parameters.ParamValues['@OrderId'] := FOrderId;
  spGetLastOrderStatus.ExecProc;
  vIErr := spGetLastOrderStatus.Parameters.ParamValues['@RETURN_VALUE'];
  if vIErr <> 0 then
  begin
    vErrMsg := spGetLastOrderStatus.Parameters.ParamValues['@ErrMsg'];
    raise Exception.Create(vErrMsg);
  end
  else
    FSrcStatusId := spGetLastOrderStatus.Parameters.ParamValues['@StatusId']; }
end;

procedure TActionDlg.InitControls;
var
  vCaption: string;
begin
  //dmJSO.Debug := true;
  FInitProcess := true;
  try
    vCaption := 'Заказ № ' + IntToStr(FOrderId);
    pnlTop_Order.Caption := vCaption;
    pnlTop_Order.Width := TextPixWidth(vCaption, pnlTop_Order.Font) + 20;

    vCaption := 'Сумма ' + VarToStr(FOrderItem.orderAmount);
    pnlTop_Price.Caption := vCaption;
    pnlTop_Price.Width := TextPixWidth(vCaption, pnlTop_Price.Font) + 20;

    vCaption := FOrderItem.orderShipName;
    pnlTop_Client.Caption := vCaption;
    pnlTop_Client.Width := TextPixWidth(vCaption, pnlTop_Client.Font) + 10;

    SetParamEnabled('SrcStatus', False);
    SetParamEnabled('ResStatus', False);

    dsSrcStatus.DataSet := dmJSO.GetActionSrcOrderStatus(nil, FSrcStatusId);
    if dsSrcStatus.DataSet.RecordCount = 1 then
    begin
      lcSrcStatus.KeyValue := dsSrcStatus.DataSet.FieldByName(lcSrcStatus.KeyField).Value;
    end;

    dsAction.DataSet := dmJSO.GetOrderActions(nil, FBpId, FSrcStatusId, true, FUserId);
    if dsAction.DataSet.RecordCount = 1 then
      FInitActionCode := dsAction.DataSet.FieldByName(lbAction.KeyField).AsString;
    if FInitActionCode <> '' then
      SetParam(FInitActionCode, 'Action');

    dsSrcBasis.DataSet := dmJSO.GetOrderSrcBasis(nil, FBpId, FSrcStatusId, FActionCode, true);
    if dsSrcBasis.DataSet.RecordCount = 1 then
      FSrcBasisId := dsSrcBasis.DataSet.FieldByName(lcSrcBasis.KeyField).AsInteger;
    if FSrcBasisId <> 0 then
      SetParam(FSrcBasisId, 'SrcBasis');

    dsResBasis.DataSet := dmJSO.GetOrderResBasis(nil, FBpId, FSrcStatusId, FActionCode, FSrcBasisId, true);
    if dsResBasis.DataSet.RecordCount = 1 then
      FResBasisId := dsResBasis.DataSet.FieldByName(lcResBasis.KeyField).AsInteger
    else
    if dsResBasis.DataSet.RecordCount = 2 then
    begin
      dsResBasis.DataSet.First;
      FResBasisId :=  dsResBasis.DataSet.FieldByName(lcResBasis.KeyField).Value;
    end;  
    if FResBasisId <> 0 then
      SetParam(FResBasisId, 'ResBasis');

    dsResStatus.DataSet := dmJSO.GetActionResOrderStatus(nil, FBpId, FActionCode,
      FSrcStatusId, FSrcBasisId, FResBasisId, true);
    if dsResStatus.DataSet.RecordCount = 1 then
      FResStatusId := dsResStatus.DataSet.FieldByName(lcResStatus.KeyField).AsInteger;
    if FResStatusId <> 0 then
      SetParam(FResStatusId, 'ResStatus');

    UpdSMSControls;
    if (not PanelSMS.Visible) then
      Self.Height := Self.Height - 76;
    if FDoExec then
      EnableCtrls(False);
  finally
    FInitProcess := false;
  end;
end;

procedure TActionDlg.SetAction(Value: Variant);
var
  vValue: string;
begin
  vValue := VarToStrExt(Value, '');
  if FActionCode <> vValue then
  begin
    FActionCode := vValue;
    if (dsAction.DataSet.FieldByName(lbAction.KeyField).Value = vValue) or
       (dsAction.DataSet.Locate(lbAction.KeyField, vValue, [])) then
      FActionType := dsAction.DataSet.FieldByName('TypeAction').AsInteger;
    if not FInitProcess then
    begin
      UpdSrcBasis;
      UpdResBasis;
      UpdResStatus;
    end;
  end;
  //SetParamEnabled('ResBasis', FActionType > 0);
  UpdSMSControls;
end;

procedure TActionDlg.SetSrcBasis(Value: Variant);
var
  vValue: Integer;
begin
  vValue := VarToInt(Value, 0);
  if FSrcBasisId <> vValue then
  begin
    FSrcBasisId := vValue;
    if not FInitProcess then
    begin
      UpdResBasis;
      UpdResStatus;
    end;
  end;
end;

procedure TActionDlg.SetResBasis(Value: Variant);
var
  vValue: Integer;
begin
  vValue := VarToInt(Value, 0);
  if FResBasisId <> vValue then
  begin
    FResBasisId := vValue;
    if not FInitProcess then
    begin
      UpdResStatus;
    end;
  end;
end;

procedure TActionDlg.SetResStatus(Value: Variant);
var
  vValue: Integer;
begin
  vValue := VarToInt(Value, 0);
  if FResStatusId <> vValue then
  begin
    FResStatusId := vValue;
  end;
end;

procedure TActionDlg.lcResStatusCloseUp(Sender: TObject);
begin
  SetResStatus(lcResStatus.KeyValue);
end;

procedure TActionDlg.UpdSrcBasis;
var
  vValue: Variant;
begin
  vValue := lcSrcBasis.KeyValue;
  dmJSO.GetOrderSrcBasis(TsprQuery(dsSrcBasis.DataSet), FBpId, FSrcStatusId, FActionCode);
  if dsSrcBasis.DataSet.RecordCount = 1 then
  begin
    lcSrcBasis.KeyValue := dsSrcBasis.DataSet.FieldByName(lcSrcBasis.KeyField).Value;
    SetSrcBasis(lcSrcBasis.KeyValue)
  end
  else
  begin
    if (not VarIsAssigned(vValue)) or (not dsSrcBasis.DataSet.Locate(lcSrcBasis.KeyField, vValue, [])) then
    begin
      lcSrcBasis.KeyValue := Null;
      SetSrcBasis(0);
    end;
  end;
end;

procedure TActionDlg.UpdResBasis;
var
  vValue: Variant;
begin
  vValue := lcResBasis.KeyValue;
  dmJSO.GetOrderResBasis(TsprQuery(dsResBasis.DataSet), FBpId, FSrcStatusId, FActionCode, FSrcBasisId);
  if dsResBasis.DataSet.RecordCount = 1 then
  begin
    lcResBasis.KeyValue := dsResBasis.DataSet.FieldByName(lcResBasis.KeyField).Value;
    SetResBasis(lcResBasis.KeyValue)
  end
  else
  if dsResBasis.DataSet.RecordCount = 2 then
  begin
    dsResBasis.DataSet.First;
    lcResBasis.KeyValue := dsResBasis.DataSet.FieldByName(lcResBasis.KeyField).Value;
    SetResBasis(lcResBasis.KeyValue)
  end
  else
  begin
    if (not VarIsAssigned(vValue)) or (not dsResBasis.DataSet.Locate(lcResBasis.KeyField, vValue, [])) then
    begin
      lcResBasis.KeyValue := Null;
      SetResBasis(0);
    end
  end;
end;

procedure TActionDlg.UpdResStatus;
var
  vValue: Variant;
begin
  vValue := lcResStatus.KeyValue;
  dmJSO.GetActionResOrderStatus(TsprQuery(dsResStatus.DataSet), FBpId, FActionCode, FSrcStatusId, FSrcBasisId, FResBasisId);
  if dsResStatus.DataSet.RecordCount = 1 then
  begin
    lcResStatus.KeyValue := dsResStatus.DataSet.FieldByName(lcResStatus.KeyField).Value;
    SetResStatus(lcResStatus.KeyValue)
  end
  else
  begin
    if (not VarIsAssigned(vValue)) or (not dsResStatus.DataSet.Locate(lcResStatus.KeyField, vValue, [])) then
    begin
      lcResStatus.KeyValue := Null;
      SetResStatus(0);
    end;
  end;
end;

function TActionDlg.CheckValues(var ErrMsg: string): Boolean;
begin
  ErrMsg := '';
  if FOrderId = 0 then
    ErrMsg := 'Не задан номер заказа'
  else
  if FBPId = 0 then
    ErrMsg := 'Не задан бизнес процесс'
  else
  if FActionCode = '' then
    ErrMsg := 'Не задано действие'
  else
  if FUserId = 0 then
    ErrMsg := 'Не задан пользователь'
  else
  if FSrcBasisId = 0 then
    ErrMsg := 'Не задано основание действия'
  else
  if (FActionType > 0) and (FResBasisId = 0) then
    ErrMsg := 'Не задано основание результата';

  Result := ErrMsg = '';
{  if not Result then
    Exit;

  Result := not((FResStatusId = 0) and
     (MessageDlg('Конечный статус НЕ задан. Подтвердите действие?', mtConfirmation, [mbOk, mbCancel], 0) <> mrOk));}
end;

procedure TActionDlg.OKBtnClick(Sender: TObject);
var
  vErrMsg: string;
  vHistoryId: Integer;
begin
  ExecTimer.Enabled := False;
  if not CheckValues(vErrMsg) and (vErrMsg <> '') then
  begin
    if not FNotShowCheckError then
      ShowError(vErrMsg);
    EnableCtrls(True);
    FNotShowCheckError := False;
    Exit;
    //raise Exception.Create(vErrMsg);
  end;
  
  FNotShowCheckError := False;
  EnableCtrls(False);
  LabelAction.Caption := 'Выполняется: ' + lbAction.SelectedItem;
  Self.Repaint;
  try
    try
      UpdActionCore;
      vHistoryId := FActionCore.StartOrderAction(FOrderId, FActionCode, FSrcStatusId, FSrcBasisId, edComments.Text);
      OKBtn.Enabled := False;
      CancelBtn.Enabled := False;
      try
        FActionCore.SafeExecuteAction(FActionCode, FActionType, FResBasisId);
        if FActionCore.ActionState <> asCancel then
        begin
          SetParam(FActionCore.ActionResult.ResBasisId, 'ResBasis');
          if FActionCore.ActionResult.IErr <> 0 then
          begin
            if (FActionType <= 2) or (FActionCore.ErrType = etInternalErr) then
              ShowError(FActionCore.ActionResult.ExecMsg)
          end
          else
          begin
            if (FResStatusId = 0) then
              ShowError('Сбой при выполнении операции.' + chr(10) + 'Конечный статус НЕ задан');
          end;
        end;  
        FActionCore.EndOrderAction(FOrderId, vHistoryId, FResStatusId, FResBasisId, FActionCore.ActionResult.IErr,
          FActionCore.ActionResult.ExecMsg);
      except
         on E: Exception do
         begin
           ShowError('Сбой при выполнении операции.' + chr(10) + E.Message);
           FActionCore.EndOrderAction(FOrderId, vHistoryId, FSrcStatusId, cErrBasis, IfThen(FActionCore.ActionResult.IErr = 0, FActionCore.ActionResult.IErr, cDefError),
              E.Message + ' ' + FActionCore.ActionResult.ExecMsg);
         end;
      end;
    except
       on E:Exception do
         ShowError('Сбой при выполнении операции.' + chr(10) + E.Message);
    end;
  finally
    LabelAction.Caption := '';
    EnableCtrls(True);
  end;
  ModalResult := mrOk;
end;

procedure TActionDlg.FormDestroy(Sender: TObject);
var
  I: Integer;
  vDS: TDataSet;
begin
  if Assigned(FActionCore) then
    FreeAndNil(FActionCore);
  if Assigned(FParamList) then
  begin
    for I := 0 to FParamList.Count - 1 do
      FParamList.Objects[I].Free;

    FParamList.Clear;
    FreeAndNil(FParamList);
  end;

  for I := 0 to Self.ComponentCount - 1 do
    if (Self.Components[I] is TDataSource) then
    begin
      vDS := TDataSource(Self.Components[I]).DataSet;
      if Assigned(vDS) then
      begin
        FreeAndNil(vDS);
      end;
    end;
end;

procedure TActionDlg.lcSrcBasisCloseUp(Sender: TObject);
begin
  SetSrcBasis(lcSrcBasis.KeyValue);
end;

procedure TActionDlg.lcResBasisCloseUp(Sender: TObject);
begin
  if lcResBasis.KeyValue = cErrBasis then
    lcResBasis.KeyValue := Null;
  SetResBasis(lcResBasis.KeyValue);
end;

procedure TActionDlg.UpdActionCore;
begin
  FActionCore.SendSMS := cbSendMessage.Checked;
  FActionCore.SendEmail := cbSendEmail.Checked;
  FActionCore.SMSTExt := edSMSText.Text;
end;

procedure TActionDlg.UpdSMSControls;
var
  vOrderShipment: string;
  vSendSMS: Boolean;
begin
  vOrderShipment := Trim(AnsiUpperCase(FOrderItem.orderShipping));
  PanelSMS.Visible := True;//((vOrderShipment = 'НОВАЯ ПОЧТА') or (vOrderShipment = 'НОВА ПОШТА'));

  if PanelSMS.Visible then
  begin
    cbSendMessage.Checked := False;
    cbSendEmail.Enabled := False;
    vSendSMS := (FActionCode = 'CloseOrder') or (FActionCode = 'OpenOrder');
    cbSendMessage.Enabled := vSendSMS;
    cbSendEmail.Enabled := vSendSMS;
    FSMSEnabled := vSendSMS;
    if vSendSMS then
    begin
      if edSMSText.Text = '' then
        edSMSText.Text := FActionCore.GetDefaultSMSText(FOrderId, 3);
    end
    else
      edSMSText.Clear;
  end;
end;

procedure TActionDlg.lbActionClick(Sender: TObject);
begin
  SetAction(lbAction.KeyValue);
end;

procedure TActionDlg.FormShow(Sender: TObject);
var
  vResult: TModalResult;
begin
  ExecTimer.Enabled := FDoExec;
{  if FDoExec then
  begin
    OKBtnClick(Self);
    vResult := ModalResult;
    PostMessage(Handle, WM_CLOSE, 0, 0);
    ModalResult := vResult;
  end;}
end;

procedure TActionDlg.ExecTimerTimer(Sender: TObject);
begin
  OKBtnClick(Self);
end;

procedure TActionDlg.EnableCtrls(Value: Boolean);
begin
  lbAction.Enabled := Value;
  lcSrcBasis.Enabled := Value;
  lcResBasis.Enabled := Value;
  edComments.Enabled := Value;
  OkBtn.Enabled := Value;
  CancelBtn.Enabled := Value;
  cbSendMessage.Enabled := Value and FSMSEnabled;
  cbSendEmail.Enabled := Value and FSMSEnabled;
  edSMSText.Enabled := Value and FSMSEnabled;
end;

end.
