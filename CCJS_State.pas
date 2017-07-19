unit CCJS_State;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ActnList, ComCtrls, ToolWin, DB, ADODB,
  UCCenterJournalNetZkz, UtilsBase;

type
  TOrderStateMode = (
    cJSOStateOpen,  { Открытие интернет-заказа }
    cJSOStateClose, { Закрытие интернет-заказа }
    cJBOStateOpen,  { Открытие заказа по звонку }
    cJBOStateClose  { Закрытие заказа по звонку }
  );

  TOrderStateParam = record
    StateMode: TOrderStateMode;
    OrderHeader: TJSO_OrderHeaderItem;
    UserId: Integer;
    Foundation: string;
    OrderStatus: string;
    SendSMS: Boolean;
    SMSText: string;
    SMSType: Variant;
  end;

  TfrmCCJS_State = class(TForm)
    pnlTop: TPanel;
    pnlTop_Order: TPanel;
    pnlTop_Price: TPanel;
    pnlTop_Client: TPanel;
    pnlTool: TPanel;
    pnlTool_Bar: TPanel;
    pnlTool_Show: TPanel;
    pnlState: TPanel;
    Label1: TLabel;
    edFoundation: TEdit;
    btnSlFoundation: TButton;
    tlbarControl: TToolBar;
    tlbtnOk: TToolButton;
    tlbtnExit: TToolButton;
    aMain: TActionList;
    aMain_Ok: TAction;
    aMain_Exit: TAction;
    aMain_SlFoundation: TAction;
    spGetStateJSO: TADOStoredProc;
    spSetStateJSO: TADOStoredProc;
    aMain_SlOrderStatus: TAction;
    Label2: TLabel;
    edOrderStatus: TEdit;
    btnSlDrivers: TButton;
    spFindStatus: TADOStoredProc;
    spSetOrderStatus: TADOStoredProc;
    PanelSMS: TPanel;
    cbSendMessage: TCheckBox;
    edSMSText: TMemo;
    spOpenCloseOrder: TADOStoredProc;
    spOrderSMSText: TADOStoredProc;
    cbSendEmail: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aMain_OkExecute(Sender: TObject);
    procedure aMain_SlFoundationExecute(Sender: TObject);
    procedure aMain_ExitExecute(Sender: TObject);
    procedure edFoundationChange(Sender: TObject);
    procedure aMain_SlOrderStatusExecute(Sender: TObject);
    procedure edOrderStatusChange(Sender: TObject);
  private
    { Private declarations }
    ISignActive              : integer;
    //ModeAction               : integer;
    ISignAllowTheActionOrder : smallint;
    ISignAllowTheActionBell  : smallint;
//    NRN                      : integer; { Номер интернет-заказа или звонка}
//    NUSER                    : integer;
//    OrderPrice               : real;
//    OrderClient              : string;

//    OrderShipping            : string;
    FParams: TOrderStateParam;
    FOrderId: Integer;
    FCodeAction: string;
    FStateMode: TOrderStateMode;
    procedure ShowGets;
    procedure CheckStateOrder;
    procedure CheckStateBell;
    procedure InitParams(AParams: TOrderStateParam);
    procedure InitControls;
    function CheckControls: Boolean;
    function GetDefaultSMSText: string;
  public
    { Public declarations }
    {procedure SetModeAction(Action : integer);
    procedure SetRN(RN : integer);
    procedure SetPrice(Price : real);
    procedure SetClient(Client : string);
    procedure SetUser(IDUSER : integer);
    procedure SetOrderShipping(Parm : string);}
    class function Execute(AParams: TOrderStateParam; AOwner: TComponent): Integer;
  end;

var
  frmCCJS_State: TfrmCCJS_State;
//const
{  cJSOStateOpen  = 1;} { Открытие интернет-заказа }
{  cJSOStateClose = 2;} { Закрытие интернет-заказа }
{  cJBOStateOpen  = 3;} { Открытие заказа по звонку }
{  cJBOStateClose = 4;} { Закрытие заказа по звонку }

implementation

uses
  Util,
  UMain, UReference;

{$R *.dfm}

procedure TfrmCCJS_State.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
  //NRN := 0;
  //ModeAction := 0;
  ISignAllowTheActionOrder := 1;
  ISignAllowTheActionBell  := 1;
  //OrderShipping := '';
end;

class function TfrmCCJS_State.Execute(AParams: TOrderStateParam; AOwner: TComponent): Integer;
var
  vDlg: TfrmCCJS_State;
begin
  vDlg := TfrmCCJS_State.Create(AOwner);
  try
    vDlg.InitParams(AParams);
    vDlg.InitControls;
    Result := vDlg.ShowModal;
  finally
    FreeAndNil(vDlg);
  end;
end;

procedure TfrmCCJS_State.InitParams(AParams: TOrderStateParam);
begin
  FParams := AParams;
  FOrderId := FParams.OrderHeader.orderID;
  FStateMode := FParams.StateMode;
end;

function TfrmCCJS_State.GetDefaultSMSText: string;
var
  IErr: Integer;
  ErrMsg: string;
begin
  Result := '';
  if VarIsAssigned(FParams.SMSType) then
  begin
    try
      spOrderSMSText.Parameters.ParamByName('@OrderId').Value := FOrderId;
      spOrderSMSText.Parameters.ParamByName('@SMSType').Value := FParams.SMSType;
      spOrderSMSText.ExecProc;
      IErr := spOrderSMSText.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr = 0 then
        Result := spOrderSMSText.Parameters.ParamValues['@SMSText']
      else
      begin
        ErrMsg := spOrderSMSText.Parameters.ParamValues['@ErrMsg'];
      end;
    except
      on e:Exception do
        ErrMsg := e.Message;
    end;
  end;
end;

procedure TfrmCCJS_State.InitControls;
var
 SCaption: string;
begin
    { Отображаем реквизиты заказа }
    SCaption := 'Заказ № ' + VarToStr(FOrderId);
    pnlTop_Order.Caption := SCaption;
    pnlTop_Order.Width := TextPixWidth(SCaption, pnlTop_Order.Font) + 20;

    SCaption := 'Сумма ' + VarToStr(FParams.OrderHeader.orderAmount);
    pnlTop_Price.Caption := SCaption;
    pnlTop_Price.Width := TextPixWidth(SCaption, pnlTop_Price.Font) + 20;

    SCaption := FParams.OrderHeader.orderShipName;
    pnlTop_Client.Caption := SCaption;
    pnlTop_Client.Width := TextPixWidth(SCaption, pnlTop_Client.Font) + 10;

    if FParams.Foundation <> '' then
      edFoundation.Text := FParams.Foundation;
    if FParams.OrderStatus <> '' then
      edOrderStatus.Text := FParams.OrderStatus;

    cbSendMessage.Checked := False;
    cbSendEmail.Enabled := False;
    cbSendMessage.Enabled := FParams.SendSMS;
    cbSendEmail.Enabled := FParams.SendSMS;
    if FParams.SendSMS then
    begin
      if FParams.SMSText <> '' then
        edSMSText.Text := FParams.SMSText
      else
        edSMSText.Text := Self.GetDefaultSMSText;
    end
    else
      edSMSText.Clear;
    PanelSMS.Visible := FParams.SendSMS;

    if (not FParams.SendSMS) then
      Self.Height := Self.Height - 153
end;

procedure TfrmCCJS_State.FormActivate(Sender: TObject);
begin
  if ISignActive = 0 then begin
    { Инициализация }
    case FStateMode of
      cJSOStateOpen: begin
        FCodeAction := 'OpenOrder';
        self.Caption := 'Открытие интернет-заказа';
        FCCenterJournalNetZkz.imgMain.GetIcon(133,self.Icon)
      end;
      cJSOStateClose: begin
        FCodeAction := 'CloseOrder';
        self.Caption := 'Закрытие интернет-заказа';
        FCCenterJournalNetZkz.imgMain.GetIcon(134,self.Icon)
      end;
      cJBOStateOpen: begin
        FCodeAction := 'OpenBell';
        self.Caption := 'Открытие заказа по звонку';
        FCCenterJournalNetZkz.imgMain.GetIcon(133,self.Icon)
      end;
      cJBOStateClose: begin
        FCodeAction := 'CloseBell';
        self.Caption := 'Закрытие заказа по звонку';
        FCCenterJournalNetZkz.imgMain.GetIcon(134,self.Icon)
      end;
      else
      begin
        ShowMessage('Незарегистрированный режим работы');
        self.Close;
      end;
    end;


    { Форма активна }
    ISignActive := 1;
    { Контроль многопользовательского режима: Проверка состояния заказа  }
    CheckStateOrder;
    CheckStateBell;
    ShowGets;
  end;
end;

procedure TfrmCCJS_State.ShowGets;
begin
  if ISignActive = 1 then begin
    { Доступ к элементам управления }
    if (length(edFoundation.Text) = 0)
       or
       (
        (FStateMode = cJSOStateClose) and
        (length(edOrderStatus.Text) = 0)
       )
    then begin
      aMain_Ok.Enabled := false;
    end else begin
      aMain_Ok.Enabled := true;
    end;
    { Обязательные поля для ввода }
    if (length(edFoundation.Text) = 0) then edFoundation.Color := TColor(clYellow) else edFoundation.Color := TColor(clWindow);
    if (FStateMode = cJSOStateClose) and (length(edOrderStatus.Text) = 0)
      then edOrderStatus.Color := TColor(clYellow)
      else edOrderStatus.Color := TColor(clWindow);
  end;
end;

procedure TfrmCCJS_State.CheckStateOrder;
var
  IErr       : integer;
  SErr       : string;
  SCloseDate : string;
begin
  if (FStateMode = cJSOStateClose) or (FStateMode = cJSOStateOpen) then begin
    ISignAllowTheActionOrder := 1;
    spGetStateJSO.Parameters.ParamValues['@Order'] := FOrderId;
    spGetStateJSO.ExecProc;
    IErr := spGetStateJSO.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      SErr := spGetStateJSO.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
      ISignAllowTheActionOrder := 0;
      self.Close;
    end else begin
      SCloseDate := spGetStateJSO.Parameters.ParamValues['@SCloseDate'];
      if (FStateMode = cJSOStateClose) and (length(SCloseDate) <> 0) then begin
        ShowMessage('Интернет-заказ уже находится в состоянии <Закрыт>');
        ISignAllowTheActionOrder := 0;
        self.Close;
      end else
      if (FStateMode = cJSOStateOpen) and (length(SCloseDate) = 0) then begin
        ShowMessage('Интернет-заказ уже находится в состоянии <Открыт>');
        ISignAllowTheActionOrder := 0;
        self.Close;
      end;
    end;
  end;
end;

procedure TfrmCCJS_State.CheckStateBell;
begin
end;

{procedure TfrmCCJS_State.SetModeAction(Action : integer); begin ModeAction := Action; end;
procedure TfrmCCJS_State.SetRN(RN : integer); begin NRN := RN; end;
procedure TfrmCCJS_State.SetPrice(Price : real); begin OrderPrice := Price; end;
procedure TfrmCCJS_State.SetClient(Client : string); begin OrderClient := Client; end;
procedure TfrmCCJS_State.SetUser(IDUSER : integer); begin NUSER := IDUSER; end;
procedure TfrmCCJS_State.SetOrderShipping(Parm : string); begin OrderShipping := Parm; end;}

function TfrmCCJS_State.CheckControls: Boolean;
begin
  Result := True;
  if (cbSendMessage.Checked or cbSendEmail.Checked) and (Trim(edSMSText.Text) = '') then
  begin
    Result := False;
    MessageDlg('Не заполнен текст СМС', mtError, [mbOk], 0);
  end;
end;

procedure TfrmCCJS_State.aMain_OkExecute(Sender: TObject);
var
  IErr        : integer;
  SErr        : string;
begin
  CheckStateOrder;
  CheckStateBell;

  if (ISignAllowTheActionOrder = 1) and CheckControls then
  begin
    if MessageDLG('Подтвердите выполнение действия',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
    try
      spOpenCloseOrder.Parameters.ParamValues['@OrderId'] := FOrderId;
      spOpenCloseOrder.Parameters.ParamValues['@CodeAction'] := FCodeAction;
      spOpenCloseOrder.Parameters.ParamValues['@UserId'] := FParams.UserId;
      spOpenCloseOrder.Parameters.ParamValues['@Foundation'] := edFoundation.Text;
      spOpenCloseOrder.Parameters.ParamValues['@StatusName'] := edOrderStatus.Text;
      if cbSendMessage.Checked then
        spOpenCloseOrder.Parameters.ParamValues['@SendSMS'] := 1
      else
        spOpenCloseOrder.Parameters.ParamValues['@SendSMS'] := 0;

      if cbSendEmail.Checked then
        spOpenCloseOrder.Parameters.ParamValues['@SendEmail'] := 1
      else
        spOpenCloseOrder.Parameters.ParamValues['@SendEmail'] := 0;

      if VarIsAssigned(FParams.SMSType) then
        spOpenCloseOrder.Parameters.ParamValues['@SMSType'] := FParams.SMSType;
      spOpenCloseOrder.Parameters.ParamValues['@SMSText'] := edSMSText.Text;
      spOpenCloseOrder.Parameters.ParamValues['@Phone'] := FParams.OrderHeader.orderPhone;
      spOpenCloseOrder.Parameters.ParamValues['@EMail'] := FParams.OrderHeader.orderEmail;

      spOpenCloseOrder.ExecProc;
      IErr := spOpenCloseOrder.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr <> 0 then
      begin
        SErr := spOpenCloseOrder.Parameters.ParamValues['@ErrMsg'];
        ShowMessage(SErr);
      end
      else
        Self.Close;
    except
      on e:Exception do
        ShowMessage(e.Message);
    end;
  end;
end;

procedure TfrmCCJS_State.aMain_SlFoundationExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFReferenceActionFoundation);
   frmReference.SetOrderShipping(FParams.OrderHeader.orderShipping);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if length(DescrSelect) > 0 then edFoundation.Text := DescrSelect;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJS_State.aMain_ExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmCCJS_State.edFoundationChange(Sender: TObject);
var
  RnStatus : integer;
  IErr     : integer;
  SErr     : string;
begin
  { Поиск аналогичного наименования статуса заказа }
  RnStatus := 0;
  IErr     := 0;
  SErr     := '';
  if length(trim(edFoundation.text)) <> 0 then begin
    try
      spFindStatus.Parameters.ParamValues['@Descr'] := edFoundation.Text;
      spFindStatus.ExecProc;
      IErr := spFindStatus.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr = 0 then begin
        RnStatus := spFindStatus.Parameters.ParamValues['@NRN_OUT'];
      end else begin
        SErr := spFindStatus.Parameters.ParamValues['@SErr'];
        ShowMessage(SErr);
      end;
    except
      on e:Exception do begin
        ShowMessage(e.Message);
      end;
    end;
  end;
  if RnStatus <> 0 then edOrderStatus.Text := edFoundation.Text;
  ShowGets;
end;

procedure TfrmCCJS_State.aMain_SlOrderStatusExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFReferenceOrderStatus);
   frmReference.SetReadOnly(cFReferenceNoReadOnly);
   frmReference.SetOrderShipping(FParams.OrderHeader.orderShipping);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if length(DescrSelect) > 0 then edOrderStatus.Text := DescrSelect;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJS_State.edOrderStatusChange(Sender: TObject);
begin
  ShowGets;
end;

end.
