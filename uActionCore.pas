unit uActionCore;

interface

uses
  SysUtils, Classes, DB, ADODB, uSprJoin, uSprQuery, Variants, Dialogs,
  UCCenterJournalNetZkz, TypInfo, Math, Controls, UtilsBase;

type
  TActionResult = record
    ResBasisId: Integer;
    IErr: Integer;
    ExecMsg: string;
  end;
  TBlackListAction = (blIns, blClose);
  
  TActionEvent = procedure(Sender: TObject; var ActionResult: TActionResult) of object;
  TActionDlgEvent = procedure(Sender: TObject; var ActionResult: TActionResult; AOrderItem: TJSO_OrderHeaderItem) of object;
  TActionSpecEvent = procedure(Sender: TObject; var ActionResult: TActionResult; ASpecItem: TJSO_ItemOrder; SignMain: Boolean) of object;
  TBlackListEvent = procedure(AOrderId: Integer; UserId: Integer; Comments: string; AAction: TBlackListAction; var ActionResult: TActionResult) of object;
  TUpdPharmEvent = procedure(AOrderId: Integer; UserId: Integer; AptekaId: Integer; var ActionResult: TActionResult) of object;
  TReserveEvent = procedure(var ActionResult: TActionResult; ReserveType: TReserveType) of object;
  TErrType = (etInternalErr, etActionErr);
  TActionState = (asStart, asCancel, asEnd);


  TActionCore = class(TComponent)
  private
    FConnection: TADOConnection;
    FUserId: Integer;
    FspGetLastOrderStatus: TADOStoredProc;
    FspStartOrderAction: TADOStoredProc;
    FspEndOrderAction: TADOStoredProc;
    FspSetOrderProcessed: TADOStoredProc;
    FActions: TStringList;
    FOrderItem: TJSO_OrderHeaderItem;
    FSpecItem: TJSO_ItemOrder;
    FSubItemId: Integer;
    FActionResult: TActionResult;
    FOnSelectPharmacy: TActionEvent;
    FOnCloseOrder: TActionEvent;
    FOnOpenOrder: TActionEvent;
    FOnOrderHeaderUpd: TActionEvent;
    FOnOrderSpecIns: TActionEvent;
    FOnOrderSpecUpd: TActionEvent;
    FOnOrderSpecDel: TActionEvent;
    FOnOrderReserve: TActionEvent;
    FOnCloseReserve: TActionEvent;
    FOnClearReserve: TActionEvent;
    FOnExportOrder1C: TActionEvent;
    FOnSendPaymentDetails: TActionEvent;
    FOnInsBlackList: TActionEvent;
    FOnCloseBlackList: TActionEvent;
    FOnCallClient: TActionEvent;
    FOnCheckReserve: TActionEvent;
    FOnUpdSpecByReserve: TActionEvent;
    FOnSetOwnOrder: TActionEvent;
    FOnUpdPharm: TActionEvent;
    FOnOrderInBP4: TActionEvent;
    //FOnItemReserve: TActionEvent;
    FActionCode: string;
    FSendSMS: Boolean;
    FSendEmail: Boolean;
    FSMSTExt: string;
    FUserSession: TUserSession;
    FErrType: TErrType;
    FReserveType: TReserveType;
    FActionState: TActionState;
    FSrcBasisId: Integer;
    function CreateProc(ACompName: string; AProcName: string): TADOStoredProc;
  protected
    procedure InitActions;
    procedure ClearActionResult(var ActionResult: TActionResult);
    procedure aSelectPharmacy(Sender: TObject; var ActionResult: TActionResult);
    procedure aSetOrderState(Sender: TObject; var ActionResult: TActionResult);
    procedure aSendOrderSMSEmail(Sender: TObject; var ActionResult: TActionResult);
    procedure aCloseOpenOrder(Sender: TObject; var ActionResult: TActionResult);
    procedure aOrderHeaderUpd(Sender: TObject; var ActionResult: TActionResult);
    procedure aItemSpecIns(Sender: TObject; var ActionResult: TActionResult);
    procedure aItemSpecUpd(Sender: TObject; var ActionResult: TActionResult);
    procedure aItemSpecDel(Sender: TObject; var ActionResult: TActionResult);
    procedure aOrderReserve(Sender: TObject; var ActionResult: TActionResult);
    procedure aCloseReserve(Sender: TObject; var ActionResult: TActionResult);
    procedure aClearReserve(Sender: TObject; var ActionResult: TActionResult);
    procedure aExportOrder1C(Sender: TObject; var ActionResult: TActionResult);
    procedure aSendPaymentDetails(Sender: TObject; var ActionResult: TActionResult);
    procedure aInsBlackList(Sender: TObject; var ActionResult: TActionResult);
    procedure aCloseBlackList(Sender: TObject; var ActionResult: TActionResult);
    procedure aCallClient(Sender: TObject; var ActionResult: TActionResult);
    procedure aSetOwnOrder(Sender: TObject; var ActionResult: TActionResult);
    procedure aCheckReserve(Sender: TObject; var ActionResult: TActionResult);
    procedure aUpdSpecByReserve(Sender: TObject; var ActionResult: TActionResult);
    procedure aUpdOrderPharm(Sender: TObject; var ActionResult: TActionResult);
    procedure aOrderInBP4(Sender: TObject; var ActionResult: TActionResult);
    //procedure aItemReserve(Sender: TObject; var ActionResult: TActionResult);

    procedure DoOrderHeaderUpd(Sender: TObject; var ActionResult: TActionResult; AOrderItem: TJSO_OrderHeaderItem);
    procedure DoSpecIns(Sender: TObject; var ActionResult: TActionResult; ASpecItem: TJSO_ItemOrder; SignMain: Boolean);
    procedure DoSpecUpd(Sender: TObject; var ActionResult: TActionResult; ASpecItem: TJSO_ItemOrder; SignMain: Boolean);
    procedure _DoOrderReserve(var ActionResult: TActionResult; ReserveType: TReserveType);
    procedure _DoCommonAction(AStoredProcName: string; AParams: TActionParams; var ActionResult: TActionResult);
    procedure DoCommonAction(AStoredProcName: string; AParams: TActionParams; var ActionResult: TActionResult; DoDefineResBasisId: boolean = false);
    procedure DefPrepareAction(var AParams: TActionParams);
    function PrepareWholeOrderOrTPointAction(DlgCaption: string; var AParams: TActionParams): Boolean;
    function ActionIsDone(ActionCode: string; AOrderId: Integer;
      var UserName: Variant; var StartDate: Variant): Boolean;
    procedure DoExportOrder1C(AOrderId: Integer);
    procedure SetExportOrder1CDate(AOrderId: Integer; UserId: Integer; ProcessId: Integer);
    procedure ExecBlackListAction(AOrderId: Integer; UserId: Integer; Comments: string; AAction: TBlackListAction;
      var ActionResult: TActionResult);
    procedure DoBlackListAction(Sender: TObject; var ActionResult: TActionResult; AAction: TBlackListAction);
    procedure DoUpdPharm(AOrderId: Integer; UserId: Integer; AptekaId: Integer;
      var ActionResult: TActionResult);
    procedure AddIntoQueue(AOrderId: Integer; UserId: Integer; ABasisId: Integer; ACaption: string;
      var ActionResult: TActionResult);
  public
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; AConnection: TADOConnection; UserId: Integer;
      OrderItem: TJSO_OrderHeaderItem; UserSession: TUserSession); overload;
    destructor Destroy; override;
    class procedure Clear_ActionResult(var ActionResult: TActionResult);
    function GetLastOrderStatus(AOrderId: Integer): Integer;
    function StartOrderAction(AOrderId: Integer; AActionCode: string;
      SrcStatusId: Integer; SrcBasisId: Integer; Comments: string): Integer;
    procedure EndOrderAction(AOrderId: Integer; AHistoryId: Integer;
      ResStatusId: Integer; ResBasisId: Integer; IErr: Integer; ExecMsg: string);
    procedure EndErrorOrderAction(AOrderId: Integer; AHistoryId: Integer);
    procedure SetOrderProcessed(AOrderId: Integer);

    procedure ExecuteAction(ActionCode: string; TypeAction: Integer; ResBasisId: Integer);
    procedure SafeExecuteAction(ActionCode: string; TypeAction: Integer; ResBasisId: Integer);
    procedure DoOrderReserve(var ActionResult: TActionResult; ReserveType: TReserveType);
    function GetDefaultSMSText(AOrderId: Integer; SMSType: Integer): string;
    class function GetActionDefSrcBasis(ActionName: string): Integer;
    class function GetActionDefResBasis(ActionName: string): Integer;

    property Connection: TADOConnection read FConnection write FConnection;
    property UserId: Integer read FUserId write FUserId;
    property OrderItem: TJSO_OrderHeaderItem read FOrderItem write FOrderItem;
    property UserSession: TUserSession read FUserSession write FUserSession;
    property ActionResult: TActionResult read FActionResult;
    property SendSMS: Boolean read FSendSMS write FSendSMS;
    property SendEmail: Boolean read FSendEmail write FSendEmail;
    property SMSTExt: string read FSMSTExt write FSMSTExt;
    property SpecItem: TJSO_ItemOrder read FSpecItem write FSpecItem;
    property SubItemId: Integer read FSubItemId write FSubItemId;
  published
    property OnSelectPharmacy: TActionEvent read FOnSelectPharmacy write FOnSelectPharmacy;
    property OnCloseOrder: TActionEvent read FOnCloseOrder write FOnCloseOrder;
    property OnOpenOrder: TActionEvent read FOnOpenOrder write FOnOpenOrder;
    property OnOrderHeaderUpd: TActionEvent read FOnOrderHeaderUpd write FOnOrderHeaderUpd;
    property OnOrderSpecIns: TActionEvent read FOnOrderSpecIns write FOnOrderSpecIns;
    property OnOrderSpecUpd: TActionEvent read FOnOrderSpecUpd write FOnOrderSpecUpd;
    property OnOrderSpecDel: TActionEvent read FOnOrderSpecDel write FOnOrderSpecDel;
    property OnOrderReserve: TActionEvent read FOnOrderReserve write FOnOrderReserve;
    //property OnItemReserve: TActionEvent read FOnItemReserve write FOnItemReserve;
    property OnCloseReserve: TActionEvent read FOnCloseReserve write FOnCloseReserve;
    property OnClearReserve: TActionEvent read FOnClearReserve write FOnClearReserve;
    property OnExportOrder1C: TActionEvent read FOnExportOrder1C write FOnExportOrder1C;
    property OnSendPaymentDetails: TActionEvent read FOnSendPaymentDetails write FOnSendPaymentDetails;
    property OnInsBlackList: TActionEvent read FOnInsBlackList write FOnInsBlackList;
    property OnCloseBlackList: TActionEvent read FOnCloseBlackList write FOnCloseBlackList;
    property ReserveType: TReserveType read FReserveType write FReserveType;
    property OnCallClient: TActionEvent read FOnCallClient write FOnCallClient;
    property OnCheckReserve: TActionEvent read FOnCheckReserve write FOnCheckReserve;
    property OnUpdSpecByReserve: TActionEvent read FOnUpdSpecByReserve write FOnUpdSpecByReserve;
    property OnSetOwnOrder: TActionEvent read FOnSetOwnOrder write FOnSetOwnOrder;
    property OnUpdPharm: TActionEvent read FOnUpdPharm write FOnUpdPharm;
    property OnOrderInBP4: TActionEvent read FOnOrderInBP4 write FOnOrderInBP4;
    property ErrType: TErrType read FErrType;
    property ActionState: TActionState read FActionState;
  end;

const
  cErrBasis: integer = 68;
  cDefBasis: integer = 67;
  cReserveBasis: integer = 103;
  cAccPolicyBasis: integer = 86;
  cDefError: integer = -1000;
  cAlignStatus: integer = 201; 


implementation

uses CCJS_PickPharmacy, CCJSO_OrderHeaderItem, CCJSO_DM, CCJS_ItemCard, uOrderReserveDlg,
  uWholeOrderOrTradePointDlg, CCJSO_ClientNotice_PayDetails, CCJSO_BlackListControl,
  CCJS_UpdPharmacyZakaz;

procedure TActionCore.InitActions;
begin
  Self.OnSelectPharmacy := aSelectPharmacy;
  Self.OnCloseOrder := aCloseOpenOrder;
  Self.OnOpenOrder := aCloseOpenOrder;
  Self.OnOrderHeaderUpd := aOrderHeaderUpd;
  Self.OnOrderSpecIns := aItemSpecIns;
  Self.OnOrderSpecUpd := aItemSpecUpd;
  Self.OnOrderSpecDel := aItemSpecDel;
  Self.OnOrderReserve := aOrderReserve;
  Self.OnCloseReserve := aCloseReserve;
  Self.OnClearReserve := aClearReserve;
  Self.OnExportOrder1C := aExportOrder1C;
  Self.OnSendPaymentDetails := aSendPaymentDetails;
  Self.OnInsBlackList := aInsBlackList;
  Self.OnCloseBlackList := aCloseBlackList;
  Self.OnCallClient := aCallClient;
  Self.OnCheckReserve := aCheckReserve;
  Self.OnUpdSpecByReserve := aUpdSpecByReserve;
  Self.OnSetOwnOrder := aSetOwnOrder;
  Self.OnUpdPharm := aUpdOrderPharm;
  Self.OnOrderInBP4 := aOrderInBP4;

 // Self.OnItemReserve := aItemReserve;
  FActions.Add('SelectPharmacyAllPosition=OnSelectPharmacy');
  FActions.Add('CloseOrder=OnCloseOrder');
  FActions.Add('OpenOrder=OnOpenOrder');
  FActions.Add('JSO_OrderHeaderUpd=OnOrderHeaderUpd');
  FActions.Add('JSO_AddItemCodeCard=OnOrderSpecIns');
  FActions.Add('JSO_UpdItemSpec=OnOrderSpecUpd');
  FActions.Add('JSO_DelItemCodeCard=OnOrderSpecDel');
  FActions.Add('OrderArmourDeliveryCourier=OnOrderReserve');
  FActions.Add('JSO_CloseOrderReserve=OnCloseReserve');
  FActions.Add('JSO_ClearOrderReserve=OnClearReserve');
  FActions.Add('ExportOrderIn1C=OnExportOrder1C');
  FActions.Add('JSO_SendOrderAttr=OnSendPaymentDetails');
  FActions.Add('JSO_AddBlackLIst=OnInsBlackList');
  FActions.Add('JSO_CloseBlackList=OnCloseBlackList');
  FActions.Add('JSO_CallClient=OnCallClient');
  FActions.Add('JOPH_SetInQueue=OnOrderReserve');
  FActions.Add('JSO_CheckReserve=OnCheckReserve');
  FActions.Add('JSO_UpdSpecByReserve=OnUpdSpecByReserve');
  FActions.Add('SetOwnOrder=OnSetOwnOrder');
  FActions.Add('ReplacePharmacy=OnUpdPharm');
  FActions.Add('OrderIntoBP4=OnOrderInBP4');
  //FActions.Add('ItemArmourDeliveryCourier=OnItemReserve');
end;

procedure TActionCore.ExecuteAction(ActionCode: string; TypeAction: Integer; ResBasisId: Integer);
var
  Idx: Integer;
  vActionName: string;
  vMethod: TMethod;
  vEvent: TActionEvent;
begin
  FErrType := etInternalErr;
  FActionCode := ActionCode;
  ClearActionResult(FActionResult);
  if TypeAction = 1 then
  begin
    FActionResult.ResBasisId := ResBasisId;
    Exit;
  end;
  if TypeAction >= 2 then
    FActionResult.ResBasisId := ResBasisId;
  
  Idx := FActions.IndexOfName(ActionCode);
  if Idx >= 0 then
  begin
    vActionName := FActions.ValueFromIndex[Idx];
    vMethod := GetMethodProp(Self, vActionName);
    if vMethod.code <> Nil then
    begin
      vEvent := TActionEvent(vMethod);
      vEvent(Self, FActionResult);
    end
    else
      raise Exception.Create('Не найден метод ' + vActionName);
  end else
    raise Exception.Create('Не описан метод ' + ActionCode);
end;

procedure TActionCore.SafeExecuteAction(ActionCode: string; TypeAction: Integer; ResBasisId: Integer);
begin
  try
    ExecuteAction(ActionCode, TypeAction, ResBasisId);
  except
    on E: Exception do
    begin
      FActionResult.ResBasisId := cErrBasis;
      if FActionResult.IErr = 0 then
        FActionResult.IErr := cDefError;
      FActionResult.ExecMsg := TrimRight(E.Message + ' ' + FActionResult.ExecMsg);
    end;
  end;
end;

constructor TActionCore.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FReserveType := rtNone;
  FActions := TStringList.Create;
  InitActions;
end;

constructor TActionCore.Create(AOwner: TComponent; AConnection: TADOConnection;
  UserId: Integer; OrderItem: TJSO_OrderHeaderItem; UserSession: TUserSession);
begin
  Create(AOwner);
  FConnection := AConnection;
  FUserId := UserId;
  FOrderItem := OrderItem;
  FUserSession := UserSession;
end;

destructor TActionCore.Destroy;
begin
  if Assigned(FspGetLastOrderStatus) then
    FreeAndNil(FspGetLastOrderStatus);
  if Assigned(FspStartOrderAction) then
    FreeAndNil(FspStartOrderAction);
  if Assigned(FspEndOrderAction) then
    FreeAndNil(FspEndOrderAction);
  if Assigned(FspSetOrderProcessed) then
    FreeAndNil(FspSetOrderProcessed);

  if Assigned(FActions) then
    FreeAndNil(FActions);
  inherited;
end;


function TActionCore.GetLastOrderStatus(AOrderId: Integer): Integer;
var
  vIErr: Integer;
  vErrMsg: string;
begin
  Result := 0;
  if not Assigned(FspGetLastOrderStatus) then
  begin
    FspGetLastOrderStatus := TADOStoredProc.Create(Self);
    with FspGetLastOrderStatus do
    begin
      Name := 'spGetLastOrderStatus';
      Connection := FConnection;
      ProcedureName := 'p_jso_GetOrderLastStatus';
      Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, 0, null);
      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, null);
      Parameters.CreateParameter('@StatusId', ftInteger, pdInputOutput, 0, null);
      Parameters.CreateParameter('@ErrMsg', ftString, pdInputOutput, 1000, null);
    end;
  end;
  FspGetLastOrderStatus.Parameters.ParamValues['@OrderId'] := AOrderId;
  FspGetLastOrderStatus.ExecProc;
  vIErr := FspGetLastOrderStatus.Parameters.ParamValues['@RETURN_VALUE'];
  if vIErr <> 0 then
  begin
    vErrMsg := FspGetLastOrderStatus.Parameters.ParamValues['@ErrMsg'];
    raise Exception.Create(vErrMsg);
  end
  else
    Result := FspGetLastOrderStatus.Parameters.ParamValues['@StatusId'];
end;

function TActionCore.StartOrderAction(AOrderId: Integer; AActionCode: string;
  SrcStatusId: Integer; SrcBasisId: Integer; Comments: string): Integer;
var
  vIErr: Integer;
  vErrMsg: string;
begin
  Result := 0;
  FActionState := asStart;
  FSrcBasisId := SrcBasisId;
  if not Assigned(FspStartOrderAction) then
  begin
    FspStartOrderAction := TADOStoredProc.Create(Self);
    with FspStartOrderAction do
    begin
      Name := 'spStartOrderAction';
      Connection := FConnection;
      ProcedureName := 'p_jso_StartOrderAction';
      Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, 0, null);
      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, null);
      Parameters.CreateParameter('@ActionCode', ftString, pdInput, 50, null);
      Parameters.CreateParameter('@SrcStatusId', ftInteger, pdInput, 0, null);
      Parameters.CreateParameter('@StartDate', ftDateTime, pdInput, 0, null);
      Parameters.CreateParameter('@SrcBasisId', ftInteger, pdInput, 0, null);
      Parameters.CreateParameter('@UserId', ftInteger, pdInput, 0, null);
      Parameters.CreateParameter('@Comments', ftString, pdInput, 1000, null);
      Parameters.CreateParameter('@HistoryId', ftInteger, pdInputOutput, 0, null);
      Parameters.CreateParameter('@ErrMsg', ftString, pdInputOutput, 1000, null);
    end;
  end;
  with FspStartOrderAction do
  begin
    Parameters.ParamValues['@OrderId'] := AOrderId;
    Parameters.ParamValues['@ActionCode'] := AActionCode;
    Parameters.ParamValues['@SrcStatusId'] := SrcStatusId;
    Parameters.ParamValues['@SrcBasisId'] := SrcBasisId;
    Parameters.ParamValues['@UserId'] := FUserId;
    Parameters.ParamValues['@Comments'] := Comments;
    ExecProc;
    vIErr := Parameters.ParamValues['@RETURN_VALUE'];
    if vIErr <> 0 then
    begin
      vErrMsg := Parameters.ParamValues['@ErrMsg'];
      raise Exception.Create(vErrMsg);
    end
    else
      Result := Parameters.ParamValues['@HistoryId'];
  end;
end;

procedure TActionCore.EndOrderAction(AOrderId: Integer; AHistoryId: Integer;
  ResStatusId: Integer; ResBasisId: Integer; IErr: Integer; ExecMsg: string);
var
  vIErr: Integer;
  vErrMsg: string;
begin
  try
    if not Assigned(FspEndOrderAction) then
    begin
      FspEndOrderAction := TADOStoredProc.Create(Self);
      with FspEndOrderAction do
      begin
        Name := 'spEndOrderAction';
        Connection := FConnection;
        ProcedureName := 'p_jso_EndOrderAction';
        Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, 0, null);
        Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, null);
        Parameters.CreateParameter('@HistoryId', ftInteger, pdInput, 0, null);
        Parameters.CreateParameter('@ResBasisId', ftInteger, pdInput, 0, null);
        Parameters.CreateParameter('@ResStatusId', ftInteger, pdInput, 0, null);
        Parameters.CreateParameter('@EndDate', ftDateTime, pdInput, 0, null);
        Parameters.CreateParameter('@UserUpd', ftInteger, pdInput, 0, null);
        Parameters.CreateParameter('@IErr', ftInteger, pdInput, 0, null);
        Parameters.CreateParameter('@ExecMsg', ftString, pdInput, 1000, null);
        Parameters.CreateParameter('@ErrMsg', ftString, pdInputOutput, 1000, null);
        Parameters.CreateParameter('@DoCancel', ftBoolean, pdInput, 0, False);
      end;
    end;
    with FspEndOrderAction do
    begin
      Parameters.ParamValues['@OrderId'] := AOrderId;
      Parameters.ParamValues['@HistoryId'] := AHistoryId;
      Parameters.ParamValues['@ResBasisId'] := ResBasisId;
      Parameters.ParamValues['@ResStatusId'] := ResStatusId;
      Parameters.ParamValues['@UserUpd'] := FUserId;
      Parameters.ParamValues['@IErr'] := IErr;
      Parameters.ParamValues['@ExecMsg'] := ExecMsg;
      Parameters.ParamValues['@DoCancel'] := FActionState = asCancel;
      ExecProc;
      vIErr := Parameters.ParamValues['@RETURN_VALUE'];
      if vIErr <> 0 then
      begin
        vErrMsg := Parameters.ParamValues['@ErrMsg'];
        raise Exception.Create(vErrMsg);
      end;
    end;
  finally
    FActionState := asEnd;
  end;
end;

procedure TActionCore.EndErrorOrderAction(AOrderId: Integer; AHistoryId: Integer);
var
  vProc: TADOStoredProc;
  vIErr: Integer;
begin
  vProc := CreateProc('spEndErrorOrderAction', 'p_jso_EndErrorOrderAction');
  try
    with vProc do
    begin
      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, AOrderId);
      Parameters.CreateParameter('@HistoryId', ftInteger, pdInput, 0, AHistoryId);
      Parameters.CreateParameter('@EndDate', ftDateTime, pdInput, 0, null);
      Parameters.CreateParameter('@UserId', ftInteger, pdInput, 0, FUserId);
      Parameters.CreateParameter('@ErrMsg', ftString, pdInputOutput, 1000, null);
    end;
    vProc.ExecProc;
    vIErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    if vIErr <> 0 then
      ShowError(vProc.Parameters.ParamValues['@ErrMsg']);
  finally
    if Assigned(vProc) then
      vProc.Free;
  end;
end;

procedure TActionCore.SetOrderProcessed(AOrderId: Integer);
var
  vIErr: Integer;
  vErrMsg: string;
begin
  FErrType := etActionErr;
  if not Assigned(FspSetOrderProcessed) then
  begin
    FspSetOrderProcessed := TADOStoredProc.Create(Self);
    with FspSetOrderProcessed do
    begin
      Name := 'spSetOrderProcessed';
      Connection := FConnection;
      ProcedureName := 'p_jso_SetOrderProcessed';
      Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, 0, null);
      Parameters.CreateParameter('@Order', ftInteger, pdInput, 0, null);
      Parameters.CreateParameter('@ID_USER', ftInteger, pdInput, 0, null);
      Parameters.CreateParameter('@SErr', ftString, pdInputOutput, 4000, null);
    end;
  end;
  try
    with FspSetOrderProcessed do
    begin
      Parameters.ParamValues['@Order'] := AOrderId;
      Parameters.ParamValues['@ID_USER'] := FUserId;
      ExecProc;
      vIErr := Parameters.ParamValues['@RETURN_VALUE'];
      if vIErr <> 0 then
      begin
        vErrMsg := Parameters.ParamValues['@SErr'];
      end;
    end;
  except
    on e:Exception do
    begin
    end;
  end;
end;

class procedure TActionCore.Clear_ActionResult(var ActionResult: TActionResult);
begin
  ActionResult.IErr := 0;
  ActionResult.ExecMsg := '';
  ActionResult.ResBasisId := cDefBasis;
end;

procedure TActionCore.ClearActionResult(var ActionResult: TActionResult);
begin
  Clear_ActionResult(ActionResult);
end;

procedure TActionCore.aSelectPharmacy(Sender: TObject; var ActionResult: TActionResult);
var
  frmCCJS_PickPharmacy: TfrmCCJS_PickPharmacy;
begin
  FErrType := etActionErr;
  try
    frmCCJS_PickPharmacy := TfrmCCJS_PickPharmacy.Create(Self);
    try
      frmCCJS_PickPharmacy.SetRecHeaderItem(FOrderItem);
      if FOrderItem.ExecSign = 1 then
        frmCCJS_PickPharmacy.ShowDialog(DoOrderReserve)
      else
        frmCCJS_PickPharmacy.ShowModal;
    finally
      FreeAndNil(frmCCJS_PickPharmacy);
      SetOrderProcessed(FOrderItem.orderID);
    end
  except
    SetOrderProcessed(FOrderItem.orderID);
    raise;
  end;
end;

function TActionCore.GetDefaultSMSText(AOrderId: Integer; SMSType: Integer): string;
var
  vProc: TADOStoredProc;
  IErr: Integer;
begin
  Result := '';
  vProc := TADOStoredProc.Create(Self);
  try
    with vProc do
    begin
      Name := 'spOrderSMSText';
      Connection := FConnection;
      ProcedureName := 'p_OrderSMSText';
      Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, 0, null);
      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, AOrderId);
      Parameters.CreateParameter('@SMSType', ftInteger, pdInput, 0, SMSType);
      Parameters.CreateParameter('@SMSText', ftString, pdReturnValue, 4000, null);
      Parameters.CreateParameter('@ErrMsg', ftString, pdInputOutput, 1000, null);
    end;
    vProc.ExecProc;
    IErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then
      Result := vProc.Parameters.ParamValues['@SMSText']
  finally
    vProc.Free;
  end;
end;

function TActionCore.CreateProc(ACompName: string; AProcName: string): TADOStoredProc;
begin
  Result := TADOStoredProc.Create(Self);
  with Result do
  begin
    Name := ACompName;
    Connection := FConnection;
    ProcedureName := AProcName;
    Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, 0, null);
    CommandTimeout := 100;
  end;
end;

procedure TActionCore.aSetOrderState(Sender: TObject; var ActionResult: TActionResult);
var
  vProc: TADOStoredProc;
begin
  FErrType := etActionErr;
  vProc := CreateProc('spSetOrderState', 'p_jso_SetOrderState');
  try
    with vProc do
    begin
      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, FOrderItem.orderID);
      Parameters.CreateParameter('@CodeAction', ftString, pdInput, 80, FActionCode);
      Parameters.CreateParameter('@UserId', ftInteger, pdInput, 0, FUserId);
      Parameters.CreateParameter('@ErrMsg', ftString, pdInputOutput, 1000, null);
    end;
    vProc.ExecProc;
    ActionResult.IErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    if ActionResult.IErr <> 0 then
      ActionResult.ExecMsg := vProc.Parameters.ParamValues['@ErrMsg']
  finally
    if Assigned(vProc) then
      vProc.Free;
  end;
end;

procedure TActionCore.aSendOrderSMSEmail(Sender: TObject; var ActionResult: TActionResult);
var
  vProc: TADOStoredProc;
begin
  FErrType := etActionErr;
  vProc := CreateProc('spSendOrderSMSEmail', 'p_jso_SendOrderSMSEmail');
  try
    with vProc do
    begin
      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, FOrderItem.orderID);
      Parameters.CreateParameter('@UserId', ftInteger, pdInput, 0, FUserId);
      Parameters.CreateParameter('@SendSMS', ftBoolean, pdInput, 0, FSendSMS);
      Parameters.CreateParameter('@SendEmail', ftBoolean, pdInput, 0, FSendEmail);
      Parameters.CreateParameter('@SMSText', ftString, pdInput, 2000, FSMSText);
      Parameters.CreateParameter('@Phone', ftString, pdInput, 160, FOrderItem.orderPhone);
      Parameters.CreateParameter('@EMail', ftString, pdInput, 160, FOrderItem.orderEmail);
      Parameters.CreateParameter('@ErrMsg', ftString, pdInputOutput, 1000, null);
    end;
    vProc.ExecProc;
    ActionResult.IErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    if ActionResult.IErr <> 0 then
      ActionResult.ExecMsg := vProc.Parameters.ParamValues['@ErrMsg']
  finally
    if Assigned(vProc) then
      vProc.Free;
  end;
end;

procedure TActionCore.aCloseOpenOrder(Sender: TObject; var ActionResult: TActionResult);
begin
  //Закрываем заказ
  FErrType := etActionErr;
  try
    aSetOrderState(Sender, ActionResult);
  except
    on E: Exception do begin
      ActionResult.IErr := cDefError;
      ActionResult.ExecMsg := TrimRight(E.Message + ' ' + ActionResult.ExecMsg);
    end;
  end;

  //Посылаем СМС, если заказ закрыли
  if ActionResult.IErr <> 0 then
    ActionResult.ResBasisId := cErrBasis
  else
    aSendOrderSMSEmail(Sender, ActionResult);
end;

procedure TActionCore.DoOrderHeaderUpd(Sender: TObject; var ActionResult: TActionResult; AOrderItem: TJSO_OrderHeaderItem);
var
  vProc: TADOStoredProc;
begin
  ClearActionResult(ActionResult);
  vProc := CreateProc('spOrderHeaderUpd', 'p_jso_OrderHeaderUpd');
  try
    with vProc do
    begin
      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, AOrderItem.orderID);
      Parameters.CreateParameter('@UserId', ftInteger, pdInput, 0, FUserId);

      Parameters.CreateParameter('@ErrMsg', ftString, pdInputOutput, 1000, null);
      Parameters.CreateParameter('@ExecMsg', ftString, pdInputOutput, 1000, null);

      Parameters.CreateParameter('@Payment', ftString, pdInput, 160, AOrderItem.orderPayment);
      if length(trim(AOrderItem.SAssemblingDate)) = 0 then
        Parameters.CreateParameter('@SAssemblingDate', ftString, pdInput, 30, '')
      else
        Parameters.CreateParameter('@SAssemblingDate', ftString, pdInput, 30, FormatDateTime('yyyy/mm/dd hh:nn:ss', AOrderItem.DAssemblingDate));
      Parameters.CreateParameter('@ExpressInvoice', ftString, pdInput, 30, AOrderItem.SDispatchDeclaration);
      Parameters.CreateParameter('@GroupPharm', ftString, pdInput, 160, AOrderItem.SGroupPharmName);
      Parameters.CreateParameter('@Note', ftString, pdInput, 500, AOrderItem.SNote);
      Parameters.CreateParameter('@Shipping', ftString, pdInput, 160, AOrderItem.orderShipping);
      Parameters.CreateParameter('@AmountCOD', ftBCD, pdInput, 0, AOrderItem.NOrderAmountCOD);
      Parameters.CreateParameter('@Amount', ftBCD, pdInput, 0, AOrderItem.orderAmount);
      Parameters.CreateParameter('@AmountShipping', ftBCD, pdInput, 0, AOrderItem.NOrderAmountShipping);
      Parameters.CreateParameter('@CoolantSum', ftBCD, pdInput, 0, AOrderItem.NCoolantSum);
      Parameters.CreateParameter('@DeclarationReturn', ftString, pdInput, 30, AOrderItem.SDeclarationReturn);
    end;
    vProc.ExecProc;
    ActionResult.IErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    if ActionResult.IErr <> 0 then
      ActionResult.ExecMsg := vProc.Parameters.ParamValues['@ErrMsg']
    else
     ActionResult.ExecMsg := vProc.Parameters.ParamValues['@ExecMsg']
  finally
    if Assigned(vProc) then
      vProc.Free;
  end;
end;

procedure TActionCore.aOrderHeaderUpd(Sender: TObject; var ActionResult: TActionResult);
var
  vParentsList: string;
  vSlavesList: string;
  vIErr: Integer;
  vErrMsg: string;
  vActionResult: TActionResult;
  frmCCJSO_OrderHeaderItem: TfrmCCJSO_OrderHeaderItem;
begin
  FErrType := etActionErr;
  DM_CCJSO.JSOParentsList(FUserId, FOrderItem.orderID, vParentsList, vIErr, vErrMsg);
  DM_CCJSO.JSOSlavesList(FUserId, FOrderItem.orderID, vSlavesList, vIErr, vErrMsg);
  frmCCJSO_OrderHeaderItem := TfrmCCJSO_OrderHeaderItem.Create(Self);
  try
    frmCCJSO_OrderHeaderItem.SetRecSession(FUserSession);
    frmCCJSO_OrderHeaderItem.SetRecHeaderItem(FOrderItem);
    frmCCJSO_OrderHeaderItem.SetMode(cModeJSOHeaderItem_ActionEdit);
    frmCCJSO_OrderHeaderItem.SetParentsList(vParentsList);
    frmCCJSO_OrderHeaderItem.SetSlavesList(vSlavesList);
    vActionResult := frmCCJSO_OrderHeaderItem.ShowDialog(DoOrderHeaderUpd);
    if not frmCCJSO_OrderHeaderItem.TrySave then
      FActionState := asCancel;
    ActionResult.IErr := vActionResult.IErr;
    ActionResult.ExecMsg := vActionResult.ExecMsg;
    if ActionResult.IErr <> 0 then
       ActionResult.ResBasisId := cErrBasis
  finally
    FreeAndNil(frmCCJSO_OrderHeaderItem);
  end;
end;

procedure TActionCore.DoSpecUpd(Sender: TObject; var ActionResult: TActionResult; ASpecItem: TJSO_ItemOrder; SignMain: Boolean);
var
  vProc: TADOStoredProc;
begin
  ClearActionResult(ActionResult);
  vProc := CreateProc('spSpecUpd', 'p_jso_UpdSpec');
  try
    with vProc do
    begin
      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, ASpecItem.orderID);
      Parameters.CreateParameter('@UserId', ftInteger, pdInput, 0, FUserId);
      Parameters.CreateParameter('@Id', ftInteger, pdInput, 0, ASpecItem.itemID);
      Parameters.CreateParameter('@ArtCode', ftInteger, pdInput, 0, ASpecItem.itemCode);
      Parameters.CreateParameter('@ArtName', ftString, pdInput, 160, ASpecItem.itemName);
      Parameters.CreateParameter('@Price', ftBCD, pdInput, 0, ASpecItem.itemPrice);
      Parameters.CreateParameter('@Quantity', ftInteger, pdInput, 0, ASpecItem.itemQuantity);
      Parameters.CreateParameter('@KoefUpack', ftInteger, pdInput, 0, ASpecItem.Koef_Opt);
      Parameters.CreateParameter('@SignMain', ftBoolean, pdInput, 0, SignMain);

      Parameters.CreateParameter('@ErrMsg', ftString, pdInputOutput, 1000, null);
      Parameters.CreateParameter('@ExecMsg', ftString, pdInputOutput, 1000, null);

      Parameters.CreateParameter('@AptekaID', ftInteger, pdInput, 0, ASpecItem.aptekaID);
      Parameters.CreateParameter('@ItemCountInPresence', ftBCD, pdInput, 0, ASpecItem.itemCountInPresence);
      Parameters.CreateParameter('@PricePharmacy', ftBCD, pdInput, 0, ASpecItem.PricePharmacy);
    end;
    vProc.ExecProc;
    ActionResult.IErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    if ActionResult.IErr <> 0 then
      ActionResult.ExecMsg := vProc.Parameters.ParamValues['@ErrMsg']
    else
     ActionResult.ExecMsg := vProc.Parameters.ParamValues['@ExecMsg'];
  finally
    if Assigned(vProc) then
      vProc.Free;
  end;
end;

procedure TActionCore.DoSpecIns(Sender: TObject; var ActionResult: TActionResult; ASpecItem: TJSO_ItemOrder; SignMain: Boolean);
var
  vProc: TADOStoredProc;
begin
  ClearActionResult(ActionResult);
  //if FOrderItem.ExecSign = 1 then
  vProc := CreateProc('spSpecIns', 'p_jso_Ins_Spec');
  //else
  //  vProc := CreateProc('spSpecIns', 'p_jso_InsSpec');
  try
    with vProc do
    begin
      Parameters.CreateParameter('@ErrMsg', ftString, pdInputOutput, 1000, null);
      Parameters.CreateParameter('@ExecMsg', ftString, pdInputOutput, 1000, null);
      Parameters.CreateParameter('@Id', ftInteger, pdInputOutput, 0, null);

      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, ASpecItem.orderID);
      Parameters.CreateParameter('@UserId', ftInteger, pdInput, 0, FUserId);
      Parameters.CreateParameter('@ArtCode', ftInteger, pdInput, 0, ASpecItem.itemCode);
      Parameters.CreateParameter('@ArtName', ftString, pdInput, 160, ASpecItem.itemName);
      Parameters.CreateParameter('@SignMeas', ftInteger, pdInput, 0, ASpecItem.SignMeas);
      Parameters.CreateParameter('@Price', ftBCD, pdInput, 0, ASpecItem.itemPrice);
      Parameters.CreateParameter('@Quantity', ftInteger, pdInput, 0, ASpecItem.itemQuantity);
      Parameters.CreateParameter('@KoefUpack', ftInteger, pdInput, 0, ASpecItem.Koef_Opt);
      Parameters.CreateParameter('@AptekaID', ftInteger, pdInput, 0, ASpecItem.aptekaID);
      Parameters.CreateParameter('@ItemCountInPresence', ftBCD, pdInput, 0, ASpecItem.itemCountInPresence);
      Parameters.CreateParameter('@PricePharmacy', ftBCD, pdInput, 0, ASpecItem.PricePharmacy);
    end;
    vProc.ExecProc;
    ActionResult.IErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    if ActionResult.IErr <> 0 then
      ActionResult.ExecMsg := vProc.Parameters.ParamValues['@ErrMsg']
    else
      ActionResult.ExecMsg := vProc.Parameters.ParamValues['@ExecMsg'];

  finally
    if Assigned(vProc) then
      vProc.Free;
  end;
end;

procedure TActionCore.aItemSpecIns(Sender: TObject; var ActionResult: TActionResult);
var
  vActionResult: TActionResult;
  frmCCJS_ItemCard: TfrmCCJS_ItemCard;
begin
  FErrType := etActionErr;
  frmCCJS_ItemCard := TfrmCCJS_ItemCard.Create(Self);
  try
    frmCCJS_ItemCard.SetRecSession(FUserSession);
    frmCCJS_ItemCard.SetUser(FUserId);
    frmCCJS_ItemCard.SetRecJSOHeader(FOrderItem);
    frmCCJS_ItemCard.SetModeAction(cJSOItemCard_Add);
    vActionResult := frmCCJS_ItemCard.ShowDialog(DoSpecUpd, DoSpecIns);
    ActionResult.IErr := vActionResult.IErr;
    ActionResult.ExecMsg := vActionResult.ExecMsg;
    if ActionResult.IErr <> 0 then
       ActionResult.ResBasisId := cErrBasis
  finally
    FreeAndNil(frmCCJS_ItemCard);
  end;
end;

procedure TActionCore.aItemSpecUpd(Sender: TObject; var ActionResult: TActionResult);
var
  vActionResult: TActionResult;
  frmCCJS_ItemCard: TfrmCCJS_ItemCard;
begin
  FErrType := etActionErr;
  frmCCJS_ItemCard := TfrmCCJS_ItemCard.Create(Self);
  try
    frmCCJS_ItemCard.SetRecSession(FUserSession);
    frmCCJS_ItemCard.SetUser(FUserId);
    frmCCJS_ItemCard.SetRecJSOHeader(FOrderItem);
    frmCCJS_ItemCard.SetRecItem(FSpecItem);
    if (length(FOrderItem.SCloseDate) = 0)
            and (
                     (FSpecItem.ID_IPA_DhRes = 0)
                 and (FSpecItem.ID_IPA_DtRes = 0)
                 and (FSpecItem.ID_IPA_JMoves = 0)
                 and (FSpecItem.ID_IPA_rTovar = 0)
                 )
            and (FSpecItem.SignDistribute = 0)
            and (FSpecItem.SignArmorTerm = 0)
          then frmCCJS_ItemCard.SetModeAction(cJSOItemCard_Upd);
    vActionResult := frmCCJS_ItemCard.ShowDialog(DoSpecUpd, DoSpecIns);
    if not frmCCJS_ItemCard.TrySave then
      FActionState := asCancel;
    ActionResult.IErr := vActionResult.IErr;
    ActionResult.ExecMsg := vActionResult.ExecMsg;
    if ActionResult.IErr <> 0 then
       ActionResult.ResBasisId := cErrBasis
  finally
    FreeAndNil(frmCCJS_ItemCard);
  end;
end;

procedure TActionCore.aItemSpecDel(Sender: TObject; var ActionResult: TActionResult);
var
  vProc: TADOStoredProc;
begin
  if (MessageDlg('Удалить товарную позицию?' + clrf +
        'АртКод = ' + IntToStr(FSpecItem.itemCode) + clrf +
       'Наименование = ' + FSpecItem.itemName, mtConfirmation, [mbOk, mbCancel], 0) <> mrOk) then
    raise Exception.Create('Операция отменена пользователем');
  ClearActionResult(ActionResult);
  vProc := CreateProc('spSpecDel', 'p_jso_DelSpec');
  try
    with vProc do
    begin
      Parameters.CreateParameter('@UserId', ftInteger, pdInput, 0, FUserId);
      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, FSpecItem.orderID);
      Parameters.CreateParameter('@ItemId', ftInteger, pdInput, 0, FSpecItem.itemID);
      Parameters.CreateParameter('@TypeTable', ftString, pdInput, 10, FSpecItem.STypeTable);
      Parameters.CreateParameter('@ErrMsg', ftString, pdInputOutput, 1000, null);
      Parameters.CreateParameter('@ExecMsg', ftString, pdInputOutput, 1000, null);
    end;
    vProc.ExecProc;
    ActionResult.IErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    if ActionResult.IErr <> 0 then
      ActionResult.ExecMsg := vProc.Parameters.ParamValues['@ErrMsg']
    else
      ActionResult.ExecMsg := vProc.Parameters.ParamValues['@ExecMsg'];
    if ActionResult.IErr <> 0 then
      ActionResult.ResBasisId := cErrBasis
  finally
    if Assigned(vProc) then
      vProc.Free;
  end;
end;

procedure TActionCore._DoOrderReserve(var ActionResult: TActionResult; ReserveType: TReserveType);
var
  vProc: TADOStoredProc;
begin
  ClearActionResult(ActionResult);
  vProc := CreateProc('spOrderReserve', 'p_jso_ReserveExpressDilivery');
  try
    with vProc do
    begin
      CommandTimeout := 200;
      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, FSpecItem.orderID);
      if ReserveType = rtAll then
        Parameters.CreateParameter('@ItemCode', ftInteger, pdInput, 0, 0)
      else
        Parameters.CreateParameter('@ItemCode', ftInteger, pdInput, 0, FSpecItem.itemCode);
      if ReserveType = rtSubItem then
        Parameters.CreateParameter('@SubItem', ftInteger, pdInput, 0, FSubItemId)
      else
        Parameters.CreateParameter('@SubItem', ftInteger, pdInput, 0, 0);
      Parameters.CreateParameter('@IDUser', ftInteger, pdInput, 0, -FUserId);
      Parameters.CreateParameter('@SErr', ftString, pdInputOutput, 4000, null);
      Parameters.CreateParameter('@TypeTable', ftString, pdInput, 10, FSpecItem.STypeTable);
    end;
    vProc.ExecProc;
    ActionResult.IErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    if ActionResult.IErr <> 0 then
    begin
      ActionResult.ExecMsg := vProc.Parameters.ParamValues['@SErr'];
      if Length(ActionResult.ExecMsg) > 1000 then
        ActionResult.ExecMsg := Copy(ActionResult.ExecMsg, 1, 1000);
    end
    else
    begin
      if ReserveType = rtAll then
        ActionResult.ExecMsg := 'Резерв. всего заказа'
      else if ReserveType = rtItem then
        ActionResult.ExecMsg := Format('Резерв. поз. ID=%d АртКод=%d Наим.=%s Тип=%s', [FSpecItem.itemId, FSpecItem.itemCode, FSpecItem.itemName, FSpecItem.STypeTable])
      else if ReserveType = rtSubItem then
        ActionResult.ExecMsg := Format('Резерв. суб. поз. ID=%d АртКод=%d Наим.=%s Тип=%s', [FSubItemId, FSpecItem.itemCode, FSpecItem.itemName, FSpecItem.STypeTable]);
    end;
    if ActionResult.IErr <> 0 then
      ActionResult.ResBasisId := cErrBasis
  finally
    if Assigned(vProc) then
      vProc.Free;
  end;
end;

procedure TActionCore.DoOrderReserve(var ActionResult: TActionResult; ReserveType: TReserveType);
var
  vProc: TADOStoredProc;
begin
  ClearActionResult(ActionResult);
  vProc := CreateProc('spOrderReserve2', 'p_jso_ReserveExpressDilivery2');
  try
    with vProc do
    begin
      CommandTimeout := 200;
      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, FSpecItem.orderID);

      if ReserveType = rtAll then
        Parameters.CreateParameter('@Id', ftInteger, pdInput, 0, 0)
      else
        Parameters.CreateParameter('@Id', ftInteger, pdInput, 0, FSpecItem.itemID);
      if ReserveType = rtSubItem then
        Parameters.CreateParameter('@SubItem', ftInteger, pdInput, 0, FSubItemId)
      else
        Parameters.CreateParameter('@SubItem', ftInteger, pdInput, 0, 0);
      Parameters.CreateParameter('@IDUser', ftInteger, pdInput, 0, -FUserId);
      Parameters.CreateParameter('@ErrMsg', ftString, pdInputOutput, 1000, null);
    end;
    vProc.ExecProc;
    ActionResult.IErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    if ActionResult.IErr <> 0 then
    begin
      ActionResult.ExecMsg := vProc.Parameters.ParamValues['@ErrMsg'];
      if Length(ActionResult.ExecMsg) > 1000 then
        ActionResult.ExecMsg := Copy(ActionResult.ExecMsg, 1, 1000);
    end
    else
    begin
      if ReserveType = rtAll then
        ActionResult.ExecMsg := 'Резерв. всего заказа'
      else if ReserveType = rtItem then
        ActionResult.ExecMsg := Format('Резерв. поз. ID=%d АртКод=%d Наим.=%s', [FSpecItem.itemId, FSpecItem.itemCode, FSpecItem.itemName])
      else if ReserveType = rtSubItem then
        ActionResult.ExecMsg := Format('Резерв. суб. поз. ID=%d АртКод=%d Наим.=%s', [FSubItemId, FSpecItem.itemCode, FSpecItem.itemName]);
    end;
    if ActionResult.IErr <> 0 then
      ActionResult.ResBasisId := cErrBasis
  finally
    if Assigned(vProc) then
      vProc.Free;
  end;
end;

procedure TActionCore.aOrderReserve(Sender: TObject; var ActionResult: TActionResult);
var
  vReserveType: TReserveType;
begin
  if FOrderItem.ExecSign <> 1 then
  begin
    if FReserveType = rtNone then
    begin
      if TfmOrderReserveDlg.Execute(FOrderItem, FSpecItem, FSubItemId, vReserveType) then
        _DoOrderReserve(ActionResult, vReserveType)
      else
        raise Exception.Create('Операция отменена пользователем');
    end
    else
      _DoOrderReserve(ActionResult, FReserveType);
  end
  else
  begin
    if Length(FOrderItem.aptekaID) > 0 then
      AddIntoQueue(FOrderItem.orderID, FUserId, Self.FSrcBasisId, 'Заказ поставлен в очередь.', ActionResult)
    else
    begin
      if FReserveType = rtNone then
      begin
        if TfmOrderReserveDlg.Execute(FOrderItem, FSpecItem, FSubItemId, vReserveType) then
          DoOrderReserve(ActionResult, vReserveType)
        else
          raise Exception.Create('Операция отменена пользователем');
      end
      else
        DoOrderReserve(ActionResult, FReserveType);
    end;
  end;
end;

{procedure TActionCore.aItemReserve(Sender: TObject; var ActionResult: TActionResult);
begin
  DoOrderReserve(ActionResult, false);
end;}

procedure TActionCore._DoCommonAction(AStoredProcName: string; AParams: TActionParams; var ActionResult: TActionResult);
var
  vProc: TADOStoredProc;
begin
  vProc := CreateProc('spDoAction', AStoredProcName);
  try
    with vProc do
    begin
      Parameters.CreateParameter('@UserId', ftInteger, pdInput, 0, AParams.UserId); //(-1)*Form1.id_user
      Parameters.CreateParameter('@ProcessId', ftInteger, pdInput, 0, AParams.ProcessId);
      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, AParams.OrderId);
      Parameters.CreateParameter('@AptekaId', ftInteger, pdInput, 0, AParams.TradePointId);
      Parameters.CreateParameter('@ErrMsg', ftString, pdReturnValue, 1000, null);
    end;
    vProc.ExecProc;
    ActionResult.IErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    if ActionResult.IErr <> 0 then
    begin
      ActionResult.ExecMsg := vProc.Parameters.ParamValues['@ErrMsg'];
      ActionResult.ResBasisId := cErrBasis;
    end;
  finally
    vProc.Free;
  end;
end;

procedure TActionCore.DoCommonAction(AStoredProcName: string; AParams: TActionParams; var ActionResult: TActionResult;
  DoDefineResBasisId: boolean = false);
var
  vProc: TADOStoredProc;
begin
  vProc := CreateProc('spDoAction', AStoredProcName);
  try
    with vProc do
    begin
      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, AParams.OrderId);
      Parameters.CreateParameter('@AptekaId', ftInteger, pdInput, 0, AParams.TradePointId);
      Parameters.CreateParameter('@UserId', ftInteger, pdInput, 0, AParams.UserId); //(-1)*Form1.id_user
      Parameters.CreateParameter('@ErrMsg', ftString, pdReturnValue, 1000, null);
      if DoDefineResBasisId then
        Parameters.CreateParameter('@ResBasisId', ftInteger, pdReturnValue, 0, null);
    end;
    vProc.ExecProc;
    if DoDefineResBasisId then
      ActionResult.ResBasisId := vProc.Parameters.ParamValues['@ResBasisId'];
    ActionResult.IErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    ActionResult.ExecMsg := vProc.Parameters.ParamValues['@ErrMsg'];
    if (ActionResult.IErr <> 0) and (ActionResult.ResBasisId = 0) then
    begin
      ActionResult.ResBasisId := cErrBasis;
    end;
  finally
    vProc.Free;
  end;
end;

procedure TActionCore.DefPrepareAction(var AParams: TActionParams);
begin
  AParams.OrderId := FOrderItem.orderID;
  AParams.UserId := FUserId;
  AParams.ProcessId := null;
  AParams.TradePointId := null;
end;

function TActionCore.PrepareWholeOrderOrTPointAction(DlgCaption: string; var AParams: TActionParams): Boolean;
var
  vParams: TWholeOrderOrTPointParams;
begin
  DefPrepareAction(AParams);

  vParams.OrderId := AParams.OrderId;
  vParams.Caption := DlgCaption;
  Result := TWholeOrderOrTradePointDlg.Execute(vParams);
  if Result then
    AParams.TradePointId := vParams.TradePointId;
end;

procedure TActionCore.aCloseReserve(Sender: TObject; var ActionResult: TActionResult);
var
  vParams: TActionParams;
begin
  if PrepareWholeOrderOrTPointAction('Отменить/закрыть бронь', vParams) then
  begin
    if Self.FOrderItem.ExecSign <> 1 then
      _DoCommonAction('p_jso_CloseOrderReserve', vParams,  ActionResult)
    else
      DoCommonAction('p_jso_CloseOrder_Reserve', vParams,  ActionResult, true)
  end
  else
    raise Exception.Create('Операция отменена пользователем');
end;

procedure TActionCore.aClearReserve(Sender: TObject; var ActionResult: TActionResult);
var
  vParams: TActionParams;
begin
  if PrepareWholeOrderOrTPointAction('Очистить позиции', vParams) then
  begin
    if Self.FOrderItem.ExecSign <> 1 then
      _DoCommonAction('p_jso_ClearOrderReserve', vParams,  ActionResult)
    else
      DoCommonAction('p_jso_Clear_OrderReserve', vParams,  ActionResult);
  end
  else
    raise Exception.Create('Операция отменена пользователем');
end;

function TActionCore.ActionIsDone(ActionCode: string; AOrderId: Integer;
  var UserName: Variant; var StartDate: Variant): Boolean;
var
  vProc: TADOStoredProc;
  vIErr: Integer;
begin
  vProc := CreateProc('spActionIsDone', 'p_jso_OrderActionIsDone');
  try
    with vProc do
    begin
      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, AOrderId);
      Parameters.CreateParameter('@ActionCode', ftString, pdInput, 50, ActionCode);
      Parameters.CreateParameter('@HistoryId', ftInteger, pdReturnValue, 0, null);
      Parameters.CreateParameter('@UserId', ftInteger, pdReturnValue, 0, null);
      Parameters.CreateParameter('@UserName', ftString, pdReturnValue, 100, null);
      Parameters.CreateParameter('@StartDate', ftDateTime, pdReturnValue, 0, null);
      Parameters.CreateParameter('@EndDate', ftDateTime, pdReturnValue, 0, null);
      Parameters.CreateParameter('@ErrMsg', ftString, pdReturnValue, 1000, null);
    end;
    vProc.ExecProc;
    vIErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    if vIErr <> 0 then
      raise Exception.Create(vProc.Parameters.ParamValues['@ErrMsg']);
    Result := vProc.Parameters.ParamValues['@HistoryId'] <> 0;
    UserName := vProc.Parameters.ParamValues['@UserName'];
    StartDate := vProc.Parameters.ParamValues['@StartDate'];
  finally
    vProc.Free;
  end;
end;

procedure TActionCore.DoExportOrder1C(AOrderId: Integer);
var
  vProc: TADOStoredProc;
begin
  vProc := TADOStoredProc.Create(Self);
  try
    with vProc do
    begin
      Name := 'spExportOrder1C';
      Connection := FConnection;
      ProcedureName := 'call_center_create_zakaz_1c';
      Parameters.CreateParameter('@id_zakaz', ftInteger, pdInput, 0, AOrderId);
    end;
    vProc.ExecProc;
  finally
    vProc.Free;
  end;
end;

procedure TActionCore.SetExportOrder1CDate(AOrderId: Integer; UserId: Integer; ProcessId: Integer);
var
  vProc: TADOStoredProc;
  vIErr: Integer;
begin
  vProc := CreateProc('spSetDateExport1C', 'p_jso_SetDateExport1C');
  try
    with vProc do
    begin
      Parameters.CreateParameter('@IDENT', ftLargeint, pdInput, 0, ProcessId);
      Parameters.CreateParameter('@USER', ftInteger, pdInput, 0, UserId);
      Parameters.CreateParameter('@Order', ftInteger, pdInput, 0, AOrderId);
      Parameters.CreateParameter('@SErr', ftString, pdReturnValue, 4000, null);
    end;
    vProc.ExecProc;
    vIErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    if vIErr <> 0 then
      raise Exception.Create(vProc.Parameters.ParamValues['@SErr']);
  finally
    vProc.Free;
  end;
end;

procedure TActionCore.aExportOrder1C(Sender: TObject; var ActionResult: TActionResult);
var
  vUserName: Variant;
  vStartDate: Variant;
begin
  if ActionIsDone('ExportOrderIn1C', FOrderItem.orderID, vUserName, vStartDate) and
     (MessageDLG(
                    'Действие уже выполнялось.' + chr(10) +
                    'Пользователь: ' + VarToStr(vUserName) + chr(10) +
                    'Дата действия: ' + VarToStr(vStartDate) + chr(10)+
                    'Подтвердите повторный экспорт заказа в 1С.',
                    mtConfirmation,[mbYes,mbNo],0
                   ) = mrNo) then
    raise Exception.Create('Операция отменена пользователем');
  DoExportOrder1C(FOrderItem.orderID);
  SetExportOrder1CDate(FOrderItem.orderID, FUserId, FUserSession.IDENT);
  SetOrderProcessed(FOrderItem.orderID);
end;

procedure TActionCore.aSendPaymentDetails(Sender: TObject; var ActionResult: TActionResult);
var
  vActionResult: TActionResult;
  vDlg: TfrmCCJSO_ClientNotice_PayDetails;
begin
  FErrType := etActionErr;
  vDlg := TfrmCCJSO_ClientNotice_PayDetails.Create(Self);
  try
    vDlg.SetRecSession(FUserSession);
    vDlg.SetRecHeaderItem(FOrderItem);
    vDlg.SetSection(cFSection_SiteApteka911);
    try
      vActionResult := vDlg.ShowDialog;
      ActionResult.IErr := vActionResult.IErr;
      ActionResult.ExecMsg := vActionResult.ExecMsg;
      if ActionResult.IErr <> 0 then
         ActionResult.ResBasisId := cErrBasis
    finally
      FreeAndNil(vDlg);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TActionCore.ExecBlackListAction(AOrderId: Integer; UserId: Integer; Comments: string;
  AAction: TBlackListAction; var ActionResult: TActionResult);
var
  vProc: TADOStoredProc;
  vName: string;
begin
  ClearActionResult(ActionResult);
  if AAction = blIns then
    vName := 'p_jso_BlackListIns'
  else
  if AAction = blClose then
    vName := 'p_jso_BlackListClose'
  else
    raise Exception.Create('Действие не реализовано');

  vProc := CreateProc('spBlackListAction', vName);
  try
    with vProc do
    begin
      Parameters.CreateParameter('@UserId', ftInteger, pdInput, 0, UserId);
      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, AOrderId);
      Parameters.CreateParameter('@Comments', ftString, pdInput, 500, Comments);
      Parameters.CreateParameter('@ErrMsg', ftString, pdReturnValue, 1000, null);
    end;
    vProc.ExecProc;
    ActionResult.IErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    if ActionResult.IErr <> 0 then
    begin
      ActionResult.ExecMsg := vProc.Parameters.ParamValues['@ErrMsg'];
      ActionResult.ResBasisId := cErrBasis;
    end;
  finally
    vProc.Free;
  end;
end;

procedure TActionCore.DoUpdPharm(AOrderId: Integer; UserId: Integer; AptekaId: Integer;
  var ActionResult: TActionResult);
var
  vProc: TADOStoredProc;
begin
  ClearActionResult(ActionResult);
  vProc := CreateProc('spUpdOrderAptekaId', 'p_jso_UpdOrderAptekaId');
  try
    with vProc do
    begin
      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, AOrderId);
      Parameters.CreateParameter('@AptekaId', ftInteger, pdInput, 0, AptekaId);
      Parameters.CreateParameter('@UserId', ftInteger, pdInput, 0, UserId);
      Parameters.CreateParameter('@ExecMsg', ftString, pdReturnValue, 1000, null);
    end;
    vProc.ExecProc;
    ActionResult.IErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    if ActionResult.IErr <> 0 then
    begin
      ActionResult.ResBasisId := cErrBasis;
    end;
    ActionResult.ExecMsg := vProc.Parameters.ParamValues['@ExecMsg'];
  finally
    vProc.Free;
  end;
end;

procedure TActionCore.DoBlackListAction(Sender: TObject; var ActionResult: TActionResult; AAction: TBlackListAction);
var
  vDlg: TfrmCCJSO_BlackListControl;
  vActionResult: TActionResult;
begin
  FErrType := etActionErr;
  vDlg := TfrmCCJSO_BlackListControl.Create(Self);
  try
    vDlg.SetRecSession(FUserSession);
    vDlg.SetRecHeaderItem(FOrderItem);
    if AAction = blIns then
      vDlg.SetMode(cBlackListMode_Open)
    else
    if AAction = blClose then
      vDlg.SetMode(cBlackListMode_Close)
    else
      raise Exception.Create('Действие не реализовано');

    vActionResult := vDlg.ShowDialog(ExecBlackListAction);
    ActionResult.IErr := vActionResult.IErr;
    ActionResult.ExecMsg := vActionResult.ExecMsg;
    if ActionResult.IErr <> 0 then
      ActionResult.ResBasisId := cErrBasis
  finally
    FreeAndNil(vDlg);
  end;
end;

procedure TActionCore.aInsBlackList(Sender: TObject; var ActionResult: TActionResult);
begin
  DoBlackListAction(Sender, ActionResult, blIns);
end;

procedure TActionCore.aCloseBlackList(Sender: TObject; var ActionResult: TActionResult);
begin
  DoBlackListAction(Sender, ActionResult, blClose);
end;

class function TActionCore.GetActionDefSrcBasis(ActionName: string): Integer;
begin
  if ActionName = 'ExportOrderIn1C' then
    Result := cAccPolicyBasis
  else
  if ActionName = 'CloseOrder' then
    Result := 0
  else
  if ActionName = 'OpenOrder' then
    Result := 0
  else
  if ActionName = 'JOPH_SetInQueue' then
    Result := cReserveBasis
  else
    Result := cDefBasis;
end;

class function TActionCore.GetActionDefResBasis(ActionName: string): Integer;
begin
  Result := TActionCore.GetActionDefSrcBasis(ActionName);
end;

procedure TActionCore.aCallClient(Sender: TObject; var ActionResult: TActionResult);
var
  vProc: TADOStoredProc;
begin
  FErrType := etActionErr;
  vProc := CreateProc('spCallClient', 'p_jso_CallClient');
  try
    with vProc do
    begin
      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, FOrderItem.orderID);
      Parameters.CreateParameter('@UserId', ftInteger, pdInput, 0, FUserId);
      Parameters.CreateParameter('@ErrMsg', ftString, pdInputOutput, 1000, null);
      Parameters.CreateParameter('@CallDate', ftDateTime, pdInput, 0, null);
    end;
    vProc.ExecProc;
    ActionResult.IErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    if ActionResult.IErr <> 0 then
    begin
      ActionResult.ExecMsg := vProc.Parameters.ParamValues['@ErrMsg'];
      ActionResult.ResBasisId := cErrBasis
    end;
  finally
    if Assigned(vProc) then
      vProc.Free;
  end;
end;

procedure TActionCore.aSetOwnOrder(Sender: TObject; var ActionResult: TActionResult);
var
  vProc: TADOStoredProc;
begin
  FErrType := etActionErr;
  vProc := CreateProc('spSetOwnOrders', 'p_jzs_SetOwnOrder');
  try
    with vProc do
    begin
      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, FOrderItem.orderID);
      Parameters.CreateParameter('@UserId', ftInteger, pdInput, 0, FUserId);
      Parameters.CreateParameter('@ErrMsg', ftString, pdInputOutput, 1000, null);
    end;
    vProc.ExecProc;
    ActionResult.IErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    if ActionResult.IErr <> 0 then
    begin
      ActionResult.ExecMsg := vProc.Parameters.ParamValues['@ErrMsg'];
      ActionResult.ResBasisId := cErrBasis
    end;
  finally
    if Assigned(vProc) then
      vProc.Free;
  end;
end;


procedure TActionCore.AddIntoQueue(AOrderId: Integer; UserId: Integer; ABasisId: Integer; ACaption: string;
  var ActionResult: TActionResult);
var
  vProc: TADOStoredProc;
  vQueueId: Variant;
begin
  FErrType := etActionErr;
  vProc := CreateProc('spAddIntoQueue', 'p_jso_AddOrderIntoQueue');
  try
    with vProc do
    begin
      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, AOrderId);
      Parameters.CreateParameter('@SrcBasisId', ftInteger, pdInput, 0, ABasisId);
      Parameters.CreateParameter('@UserId', ftInteger, pdInput, 0, UserId);
      Parameters.CreateParameter('@QueueId', ftInteger, pdInputOutput, 0, null);
      Parameters.CreateParameter('@ErrMsg', ftString, pdInputOutput, 1000, null);
    end;
    vProc.ExecProc;
    ActionResult.IErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    if ActionResult.IErr <> 0 then
    begin
      ActionResult.ExecMsg := vProc.Parameters.ParamValues['@ErrMsg'];
      ActionResult.ResBasisId := cErrBasis
    end
    else
    begin
      vQueueId := vProc.Parameters.ParamValues['@QueueId'];
      ActionResult.ExecMsg := ACaption + ' Очередь #' + VarToStr(vQueueId);
      //ShowMessage(ActionResult.ExecMsg);
    end;
  finally
    if Assigned(vProc) then
      vProc.Free;
  end;
end;

procedure TActionCore.aCheckReserve(Sender: TObject; var ActionResult: TActionResult);
var
  vParams: TActionParams;
begin
  FErrType := etActionErr;
  if FOrderItem.ExecSign <> 1 then
    raise Exception.Create('Операция не реализована для данного типа заказа');

  if PrepareWholeOrderOrTPointAction('Проверка состояния брони', vParams) then
  begin
    if Length(FOrderItem.aptekaID) > 0 then
      DoCommonAction('p_jso_OrderCheck_Reserve', vParams,  ActionResult, true)
    else
      DoCommonAction('p_jso_OrderCheck_Reserve2', vParams,  ActionResult, true)
  end
  else
    raise Exception.Create('Операция отменена пользователем');
end;

procedure TActionCore.aUpdSpecByReserve(Sender: TObject; var ActionResult: TActionResult);
var
  vParams: TActionParams;
begin
  FErrType := etActionErr;
  if PrepareWholeOrderOrTPointAction('Установка кол-ва в соотв. с броней', vParams) then
    DoCommonAction('p_jso_OrderUpd_ByReserve', vParams,  ActionResult, true)
  else
    raise Exception.Create('Операция отменена пользователем');
end;

procedure TActionCore.aUpdOrderPharm(Sender: TObject; var ActionResult: TActionResult);
var
  vIErr: Integer;
  vErrMsg: string;
  vActionResult: TActionResult;
  frmCCJS_UpdPharmacyZakaz: TfrmCCJS_UpdPharmacyZakaz;
begin
  FErrType := etActionErr;
  frmCCJS_UpdPharmacyZakaz := TfrmCCJS_UpdPharmacyZakaz.Create(Self);
  try
    frmCCJS_UpdPharmacyZakaz.SetUser(FUserId);
    vActionResult := frmCCJS_UpdPharmacyZakaz.ShowDialog(DoUpdPharm);
    ActionResult.IErr := vActionResult.IErr;
    ActionResult.ExecMsg := vActionResult.ExecMsg;
    if ActionResult.IErr <> 0 then
      ActionResult.ResBasisId := cErrBasis
  finally
    FreeAndNil(frmCCJSO_OrderHeaderItem);
  end;
end;

procedure TActionCore.aOrderInBP4(Sender: TObject; var ActionResult: TActionResult);
var
  vProc: TADOStoredProc;
begin
  FErrType := etActionErr;
  vProc := CreateProc('spOrderInBP4', 'p_jso_OrderIntoBp4');
  try
    with vProc do
    begin
      Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, FOrderItem.orderID);
      Parameters.CreateParameter('@UserId', ftInteger, pdInput, 0, FUserId);
      Parameters.CreateParameter('@ErrMsg', ftString, pdInputOutput, 1000, null);
    end;
    vProc.ExecProc;
    ActionResult.IErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    if ActionResult.IErr <> 0 then
    begin
      ActionResult.ExecMsg := vProc.Parameters.ParamValues['@ErrMsg'];
      ActionResult.ResBasisId := cErrBasis
    end;
  finally
    if Assigned(vProc) then
      vProc.Free;
  end;
end;

end.
