unit CCJS_OrderStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, ActnList, ExtCtrls, DB, ADODB,
  CCJSO_DM, UCCenterJournalNetZkz;

type
  TfrmCCJS_OrderStatus = class(TForm)
    pnlTop: TPanel;
    pnlTop_Order: TPanel;
    pnlTop_Price: TPanel;
    pnlTop_Client: TPanel;
    aMain: TActionList;
    aMain_Ok: TAction;
    aMain_Exit: TAction;
    aMain_SlOrderStatus: TAction;
    pnlTool: TPanel;
    pnlTool_Bar: TPanel;
    tlbarControl: TToolBar;
    tlbtnOk: TToolButton;
    tlbtnExit: TToolButton;
    pnlTool_Show: TPanel;
    pnlNote: TPanel;
    mNote: TMemo;
    spSetOrderStatus: TADOStoredProc;
    pnlCheckNote: TPanel;
    pnlCheckNote_Count: TPanel;
    pnlCheckNote_Status: TPanel;
    pnlFields: TPanel;
    pnlOrderStatus: TPanel;
    lblOrderStatus: TLabel;
    edOrderStatus: TEdit;
    btnSlDrivers: TButton;
    pnlAssemblingDate: TPanel;
    lblSAssemblingDate: TLabel;
    edSAssemblingDate: TEdit;
    btnSetAssemblingDate: TButton;
    aSetAssemblingDate: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aMain_OkExecute(Sender: TObject);
    procedure aMain_ExitExecute(Sender: TObject);
    procedure aMain_SlOrderStatusExecute(Sender: TObject);
    procedure edOrderStatusChange(Sender: TObject);
    procedure mNoteChange(Sender: TObject);
    procedure aSetAssemblingDateExecute(Sender: TObject);
    procedure edSAssemblingDateChange(Sender: TObject);
  private
    { Private declarations }
    ISignActive                      : integer;
    CodeAction                       : string;
    RecSession                       : TUserSession;
    NRN                              : integer; { Номер интернет-заказа или звонка}
    NUSER                            : integer;
    OrderPrice                       : real;
    OrderClient                      : string;
    SNOTE                            : string;
    OrderShipping                    : string;
    RecHeaderItemOld                 : TJSO_OrderHeaderItem;
    RecHeaderItemNew                 : TJSO_OrderHeaderItem;
    recHistInfo_StatusMakeCallClient : TJSORecHist_GetActionInfo;
    procedure ShowGets;
    procedure SetRecNew;
  public
    { Public declarations }
    procedure SetCodeAction(Action : string);
    procedure SetRN(RN : integer);
    procedure SetPrice(Price : real);
    procedure SetClient(Client : string);
    procedure SetUser(IDUSER : integer);
    procedure SetNote(Note : string);
    procedure SetOrderShipping(Parm : string);
    procedure SetRecHeaderItem(Parm : TJSO_OrderHeaderItem);
    procedure SetRecSession(Parm : TUserSession);
  end;

var
  frmCCJS_OrderStatus: TfrmCCJS_OrderStatus;

implementation

uses
  Util,
  UMAIN, UReference, CCJSO_SetFieldDate;

{$R *.dfm}

procedure TfrmCCJS_OrderStatus.ShowGets;
var
  SCaption                         : string;
  SignBeSureToEnter_AssemblingDate : boolean;
begin
  if ISignActive = 1 then begin
    { Определение SignBeSureToEnter_AssemblingDate }
    if    (Pos(cOrderShipping_ExpressDelivery,RecHeaderItemOld.orderShipping)>0)
       or (Pos(cOrderShipping_NovaPoshta,RecHeaderItemOld.orderShipping)>0) then begin
      if (RecHeaderItemNew.SStatusName = cStatus_MakeCallClient)
         or
         (
              (length(RecHeaderItemNew.SStatusName) > 0)
          and (RecHeaderItemNew.SStatusName <> cStatus_MakeCallClient)
          and (recHistInfo_StatusMakeCallClient.NumbRegistered > 0)
         )
         or
         (
          (recHistInfo_StatusMakeCallClient.NumbRegistered > 0)
          and
          (length(RecHeaderItemNew.SStatusName) = 0)
         )
        then SignBeSureToEnter_AssemblingDate := true
        else SignBeSureToEnter_AssemblingDate := false;
    end;
    if SignBeSureToEnter_AssemblingDate then begin
      pnlAssemblingDate.Visible := true;
      pnlFields.Height := pnlOrderStatus.Height + pnlAssemblingDate.Height;
    end else begin
      pnlAssemblingDate.Visible := false;
      pnlFields.Height := pnlOrderStatus.Height;
    end;
    { Контроль на пустую строку }
    if length(edOrderStatus.Text) = 0 then edOrderStatus.Color := TColor(clYellow)
                                      else edOrderStatus.Color := TColor(clWindow);
    if length(edSAssemblingDate.Text) = 0 then edSAssemblingDate.Color := TColor(clYellow)
                                          else edSAssemblingDate.Color := TColor(clWindow);
    { Доступ к сохранению результатов }
    if   (length(edOrderStatus.Text) = 0)
      or (SignBeSureToEnter_AssemblingDate
          and
          (length(edSAssemblingDate.Text) = 0)
         )
    then tlbtnOk.Enabled := false
    else tlbtnOk.Enabled := true;
    { Количество символов в примечании }
    SCaption := VarToStr(length(mNote.Text));
    pnlCheckNote_Count.Caption := SCaption; pnlCheckNote_Count.Width := TextPixWidth(SCaption, pnlCheckNote_Count.Font) + 20;
  end;
end;

procedure TfrmCCJS_OrderStatus.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
  NRN := 0;
  OrderShipping := '';
  DM_CCJSO.InitRecHistInfo(recHistInfo_StatusMakeCallClient);
end;

procedure TfrmCCJS_OrderStatus.FormActivate(Sender: TObject);
var
  SCaption : string;
  IErr     : integer;
  SErr     : string;
begin
  if ISignActive = 0 then begin
    { Иконка окна }
    FCCenterJournalNetZkz.imgMain.GetIcon(115,self.Icon);
    { Инциализация }
    RecHeaderItemNew := RecHeaderItemOld;
    edSAssemblingDate.Text := RecHeaderItemNew.SAssemblingDate;
    { Получаем данные о состоянии статуса }
    DM_CCJSO.JSOHistGetActionDateInfo(
                                      NUSER,
                                      RecHeaderItemOld.orderID,
                                      'SetCurrentOrderStatus',
                                      cModeHistGetActionDateInfo_Last,
                                      cStatus_MakeCallClient,
                                      recHistInfo_StatusMakeCallClient.NumbRegistered,
                                      recHistInfo_StatusMakeCallClient.SActionDate,
                                      recHistInfo_StatusMakeCallClient.ActionNote,
                                      IErr,
                                      SErr
                                     );
    { Отображаем реквизиты заказа }
    SCaption := 'Заказ № ' + VarToStr(NRN);
    pnlTop_Order.Caption := SCaption; pnlTop_Order.Width := TextPixWidth(SCaption, pnlTop_Order.Font) + 20;
    SCaption := 'Сумма ' + VarToStr(OrderPrice);
    pnlTop_Price.Caption := SCaption; pnlTop_Price.Width := TextPixWidth(SCaption, pnlTop_Price.Font) + 20;
    SCaption := OrderClient;
    pnlTop_Client.Caption := SCaption; pnlTop_Client.Width := TextPixWidth(SCaption, pnlTop_Client.Font) + 10;
    { Текущее значение примечания }
    mNote.Text := SNOTE;
    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJS_OrderStatus.SetCodeAction(Action : string); begin CodeAction := Action; end;
procedure TfrmCCJS_OrderStatus.SetRN(RN : integer); begin NRN := RN; end;
procedure TfrmCCJS_OrderStatus.SetPrice(Price : real); begin OrderPrice := Price; end;
procedure TfrmCCJS_OrderStatus.SetClient(Client : string); begin OrderClient := Client; end;
procedure TfrmCCJS_OrderStatus.SetUser(IDUSER : integer); begin NUSER := IDUSER; end;
procedure TfrmCCJS_OrderStatus.SetNote(Note : string); begin SNOTE := Note; end;
procedure TfrmCCJS_OrderStatus.SetOrderShipping(Parm : string); begin OrderShipping := Parm; end;
procedure TfrmCCJS_OrderStatus.SetRecHeaderItem(Parm : TJSO_OrderHeaderItem); begin RecHeaderItemOld := Parm; end;
procedure TfrmCCJS_OrderStatus.SetRecSession(Parm : TUserSession); begin RecSession := Parm; end;

procedure TfrmCCJS_OrderStatus.SetRecNew;
begin
  RecHeaderItemNew.SAssemblingDate := edSAssemblingDate.Text;       { маркер времени сборки }
  RecHeaderItemNew.SStatusName     := edOrderStatus.Text;           { Наименование статуса заказа }
end;

procedure TfrmCCJS_OrderStatus.aMain_OkExecute(Sender: TObject);
var
  IErr            : integer;
  SErr            : string;
begin
  if CodeAction = 'SetCurrentOrderStatus' then begin
    try
      spSetOrderStatus.Parameters.ParamValues['@Order']      := NRN;
      spSetOrderStatus.Parameters.ParamValues['@CodeAction'] := CodeAction;
      spSetOrderStatus.Parameters.ParamValues['@USER']       := NUSER;
      spSetOrderStatus.Parameters.ParamValues['@Status']     := edOrderStatus.Text;
      spSetOrderStatus.Parameters.ParamValues['@SNOTE']      := mNote.Text;
      if length(trim(edSAssemblingDate.Text)) = 0 then spSetOrderStatus.Parameters.ParamValues['@SAssemblingDate'] := '' else begin
        if RecHeaderItemNew.SAssemblingDate <> RecHeaderItemOld.SAssemblingDate
          then spSetOrderStatus.Parameters.ParamValues['@SAssemblingDate'] := FormatDateTime('yyyy/mm/dd hh:nn:ss', RecHeaderItemNew.DAssemblingDate)
          else spSetOrderStatus.Parameters.ParamValues['@SAssemblingDate'] := '';
      end;
      spSetOrderStatus.Parameters.ParamValues['@SignUpdJournal']  := 1;
      spSetOrderStatus.Parameters.ParamValues['@SignCheckClose']  := 1;
      spSetOrderStatus.ExecProc;
      IErr := spSetOrderStatus.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr <> 0 then begin
        SErr := spSetOrderStatus.Parameters.ParamValues['@SErr'];
        ShowMessage(SErr);
      end else begin
        self.Close;
      end;
    except
      on e:Exception do begin
        ShowMessage(e.Message);
      end;
    end;
  end
  else if CodeAction = 'SetCurrentBellStatus' then begin
  end else begin
    ShowMessage('Попытка обработки незарегистрированного кода операции.' + chr(10) +
                'CodeAction = ' + CodeAction
               );
  end;
end;

procedure TfrmCCJS_OrderStatus.aMain_ExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmCCJS_OrderStatus.aMain_SlOrderStatusExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFReferenceOrderStatus);
   frmReference.SetReadOnly(cFReferenceNoReadOnly);
   frmReference.SetOrderShipping(OrderShipping);
   frmReference.SetOrderPayment(RecHeaderItemOld.orderPayment);
   frmReference.SetOrder(RecHeaderItemOld.orderID);
   frmReference.SetUser(RecSession.CurrentUser);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if length(DescrSelect) > 0 then edOrderStatus.Text := DescrSelect;
    SetRecNew;
    ShowGets;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJS_OrderStatus.edOrderStatusChange(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJS_OrderStatus.mNoteChange(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJS_OrderStatus.aSetAssemblingDateExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  try
    frmCCJSO_SetFieldDate := TfrmCCJSO_SetFieldDate.Create(Self);
    frmCCJSO_SetFieldDate.SetMode(cFieldDate_Assembling);
    frmCCJSO_SetFieldDate.SetRecHeaderItem(RecHeaderItemNew);
    frmCCJSO_SetFieldDate.SetUserSession(RecSession);
    frmCCJSO_SetFieldDate.SetTypeExec(cSFDTypeExec_Return);
    try
      frmCCJSO_SetFieldDate.ShowModal;
      if frmCCJSO_SetFieldDate.GetOk then begin
        DescrSelect := frmCCJSO_SetFieldDate.GetSDate;
        RecHeaderItemNew.DAssemblingDate := frmCCJSO_SetFieldDate.GetDDate;
        edSAssemblingDate.Text := DescrSelect;
        SetRecNew;
        ShowGets;
      end;
    finally
      FreeAndNil(frmCCJSO_SetFieldDate);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TfrmCCJS_OrderStatus.edSAssemblingDateChange(Sender: TObject);
begin
  ShowGets;
end;

end.
