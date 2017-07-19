unit CCJSO_OrderHeaderItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UCCenterJournalNetZkz, StdCtrls, ExtCtrls, ComCtrls, ToolWin,
  ActnList, DB, ADODB,
  CCJSO_DM, uActionCore, UtilsBase;

type
  TfrmCCJSO_OrderHeaderItem = class(TForm)
    pnlControl: TPanel;
    pnlControl_Tool: TPanel;
    Action: TActionList;
    aExit: TAction;
    tBarControl: TToolBar;
    btnControl_Exit: TToolButton;
    aSave: TAction;
    btnControl_Save: TToolButton;
    aSlOrderPayment: TAction;
    aSetAssemblingDate: TAction;
    aSlOrderStatus: TAction;
    aSlGroupPharm: TAction;
    aSlNameDriver: TAction;
    aValueChange: TAction;
    aUndo: TAction;
    ToolButton1: TToolButton;
    spHeaderUpdate: TADOStoredProc;
    aSlOrderShipping: TAction;
    aCalcCOD: TAction;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet4: TTabSheet;
    grpExecCourier: TGroupBox;
    lblSSignBell: TLabel;
    lblSSMSDate: TLabel;
    lblSPayDate: TLabel;
    lblSExport1CDate: TLabel;
    lblSGroupPharmName: TLabel;
    lblSMarkUser: TLabel;
    lblParentsList: TLabel;
    lblSlavesList: TLabel;
    lblSBlackListDate: TLabel;
    lblSStockDateBegin: TLabel;
    lblSPharmAssemblyDate: TLabel;
    edSSignBell: TEdit;
    edSSMSDate: TEdit;
    edSPayDate: TEdit;
    edSExport1CDate: TEdit;
    edSGroupPharmName: TEdit;
    edSDriverDate: TEdit;
    edSMarkUser: TEdit;
    edSMarkDate: TEdit;
    btnSlGroupPharm: TButton;
    edParentsList: TEdit;
    edSlavesList: TEdit;
    edSBlackListDate: TEdit;
    edSStockDateBegin: TEdit;
    edSPharmAssemblyDate: TEdit;
    lblOrderShipping: TLabel;
    edOrderShipping: TEdit;
    btnSlOrderShipping: TButton;
    lblOrderPayment: TLabel;
    edOrderPayment: TEdit;
    btnSlOrderPayment: TButton;
    lblApteka: TLabel;
    edApteka: TEdit;
    lblNOrderAmountCOD: TLabel;
    edNOrderAmountCOD: TEdit;
    btnCalcCOD: TButton;
    lblNCoolantSum: TLabel;
    edNCoolantSum: TEdit;
    lblSOrderComment: TLabel;
    edSOrderComment: TMemo;
    lblSOrderShipCity: TLabel;
    edSOrderShipCity: TEdit;
    lblOrderShipStreet: TLabel;
    edOrderShipStreet: TEdit;
    lblShipName: TLabel;
    edShipName: TEdit;
    lblOrderPhone: TLabel;
    edOrderPhone: TEdit;
    lblOrderEmail: TLabel;
    edOrderEmail: TEdit;
    GroupBox1: TGroupBox;
    lblSNPOST_StateName: TLabel;
    edSNPOST_StateName: TEdit;
    edSStatusName: TEdit;
    lblSStatusName: TLabel;
    btnSlOrderStatus: TButton;
    lblSCreateDate: TLabel;
    edSCreateDate: TEdit;
    lblSCloseDate: TLabel;
    edSCloseDate: TEdit;
    edSOrderStatusDate: TEdit;
    lblSDispatchDeclaration: TLabel;
    lblSDeclarationReturn: TLabel;
    edSDispatchDeclaration: TEdit;
    edSDeclarationReturn: TEdit;
    lblNOrderAmountShipping: TLabel;
    edNOrderAmountShipping: TEdit;
    lblSNPOST_StateDate: TLabel;
    edSNPOST_StateDate: TEdit;
    Label1: TLabel;
    lblUser: TLabel;
    edUser: TEdit;
    Label2: TLabel;
    lblSBallDAte: TLabel;
    edSBallDAte: TEdit;
    lblOrderAmount: TLabel;
    edOrderAmount: TEdit;
    lblSAssemblingDate: TLabel;
    edSAssemblingDate: TEdit;
    btnSetAssemblingDate: TButton;
    lblSNameDriver: TLabel;
    edSNameDriver: TEdit;
    btnSlNameDriver: TButton;
    edSNote: TMemo;
    lblSNote: TLabel;
    PanelHeader: TPanel;
    lblSOrderID: TLabel;
    edSOrderID: TEdit;
    Label3: TLabel;
    Edit1: TEdit;
    lblSOrderDt: TLabel;
    edSOrderDt: TEdit;
    Label4: TLabel;
    edTotalSum: TEdit;
    PanelState: TPanel;
    lbState: TLabel;
    lbHistoryComments: TLabel;
    edHistoryComments: TMemo;
    lbHistoryExecMsg: TLabel;
    edHistoryExecMsg: TMemo;
    lbMPhone: TLabel;
    edMPhone: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aSaveExecute(Sender: TObject);
    procedure aSlOrderPaymentExecute(Sender: TObject);
    procedure aSetAssemblingDateExecute(Sender: TObject);
    procedure aSlOrderStatusExecute(Sender: TObject);
    procedure aSlGroupPharmExecute(Sender: TObject);
    procedure aSlNameDriverExecute(Sender: TObject);
    procedure aValueChangeExecute(Sender: TObject);
    procedure edOrderPaymentDblClick(Sender: TObject);
    procedure edSAssemblingDateDblClick(Sender: TObject);
    procedure edSStatusNameDblClick(Sender: TObject);
    procedure edSGroupPharmNameDblClick(Sender: TObject);
    procedure edSNameDriverDblClick(Sender: TObject);
    procedure aUndoExecute(Sender: TObject);
    procedure edSDispatchDeclarationChange(Sender: TObject);
    procedure edSNoteChange(Sender: TObject);
    procedure aSlOrderShippingExecute(Sender: TObject);
    procedure edOrderShippingDblClick(Sender: TObject);
    procedure aCalcCODExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActive                      : integer;
    Mode                             : integer;
    RecSession                       : TUserSession;
    RecHeaderItemOld                 : TJSO_OrderHeaderItem;
    RecHeaderItemNew                 : TJSO_OrderHeaderItem;
    ParentsList                      : string;
    SlavesList                       : string;
    FExtComments                     : string;
    FTrySave                         : Boolean;
    FOnUpd: TActionDlgEvent;
    FActionResult: TActionResult;
    recHistInfo_StatusMakeCallClient : TJSORecHist_GetActionInfo;
    procedure ShowGets;
    procedure InitFields(GetAddFields: Boolean);
    procedure SetRecNew;
    procedure PropEditField(edField : TEdit;  SignReadOnly : boolean);
    procedure PropNotEditField(edField : TEdit);
    procedure ShowLableFieldEnable(lblField : TLabel);
    procedure ShowLableFieldNotEdit(lblField : TLabel);
    function  GetSignValueFieldChange  : boolean;
  public
    { Public declarations }
    procedure SetMode(Parm : integer);
    procedure SetRecHeaderItem(Parm : TJSO_OrderHeaderItem);
    procedure SetRecSession(Parm : TUserSession);
    procedure SetParentsList(Parm : string);
    procedure SetSlavesList(Parm : string);
    function ShowDialog(OnUpd: TActionDlgEvent): TActionResult;
    property ExtComments :string read FExtComments write FExtComments;
    property TrySave: Boolean read FTrySave;
  end;

const
  cModeJSOHeaderItem_Read = 0;
  cModeJSOHeaderItem_Edit = 1;
  cModeJSOHeaderItem_ActionEdit = 2;

var
  frmCCJSO_OrderHeaderItem: TfrmCCJSO_OrderHeaderItem;

implementation

uses
  UMAIN, Util, Ureference, CCJSO_SetFieldDate, ExDBGRID, CCJSO_CalcCDO, uDMJSO;

{$R *.dfm}

procedure TfrmCCJSO_OrderHeaderItem.FormCreate(Sender: TObject);
begin
  { Инициализация }
  FTrySave := False;
  ISignActive := 0;
  Mode := cModeJSOHeaderItem_Read;
  DM_CCJSO.InitRecHistInfo(recHistInfo_StatusMakeCallClient);
end;

procedure TfrmCCJSO_OrderHeaderItem.PropEditField(edField : TEdit; SignReadOnly : boolean);
begin
  edField.BevelKind   := bkFlat;
    //edField.Ctl3D       := false;
    //edField.BorderStyle := bsSingle;
  edField.ReadOnly    := SignReadOnly;
  edField.Color := clInfoBk;
end;

procedure TfrmCCJSO_OrderHeaderItem.PropNotEditField(edField : TEdit);
begin
  edField.BevelKind   := bkNone;
  //edField.Ctl3D       := True;
  //edField.BorderStyle := bsNone;
  edField.ReadOnly    := True;
  edField.Color       := clWindow;
  //edField.Height      := 19;
end;

procedure TfrmCCJSO_OrderHeaderItem.FormActivate(Sender: TObject);
var
  SErr : string;
  IErr : integer;
begin
  if ISignActive = 0 then begin
    SErr := '';
    IErr := 0;
    lbState.Caption := FExtComments;
    PanelState.Visible := lbState.Caption <> '';
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(151,self.Icon);
    { Инциализаия }
    RecHeaderItemNew := RecHeaderItemOld;
    InitFields(true);
    { Режим работы }
    if Mode <> cModeJSOHeaderItem_Read then begin
      self.Caption := 'Интернет заказ клиента РЕДАКТИРОВАТЬ';
      { Акцентируем поля, которые доступны для исправления }
      PropEditField(edNOrderAmountShipping,false);  ShowLableFieldEnable(lblNOrderAmountShipping);
      PropEditField(edNCoolantSum,false);           ShowLableFieldEnable(lblNCoolantSum);
      PropEditField(edOrderShipping,true);          ShowLableFieldEnable(lblOrderShipping);
      PropEditField(edOrderPayment,true);           ShowLableFieldEnable(lblOrderPayment);
      PropEditField(edSAssemblingDate,true);        ShowLableFieldEnable(lblSAssemblingDate);
      PropEditField(edSDispatchDeclaration,false);  ShowLableFieldEnable(lblSDispatchDeclaration);
      PropEditField(edSDeclarationReturn,false);    ShowLableFieldEnable(lblSDeclarationReturn);
      PropEditField(edSGroupPharmName,true);        ShowLableFieldEnable(lblSGroupPharmName);
      if Mode = cModeJSOHeaderItem_Edit then
      begin
        PropEditField(edSNameDriver,true);
        ShowLableFieldEnable(lblSNameDriver);
        PropEditField(edSStatusName,true);
        ShowLableFieldEnable(lblSStatusName);
        btnSlOrderStatus.Visible     := true;
        btnSlNameDriver.Visible      := true;
      end
      else
      begin
        PropNotEditField(edSNameDriver);
        ShowLableFieldNotEdit(lblSNameDriver);
        PropNotEditField(edSStatusName);
        ShowLableFieldNotEdit(lblSStatusName);
        btnSlOrderStatus.Visible     := false;
        btnSlNameDriver.Visible      := false;
      end;
      PropEditField(TEdit(edSNote),false);          ShowLableFieldEnable(lblSNote);
      if DM_CCJSO.GetSignCOD(RecSession.CurrentUser,RecHeaderItemOld.orderPayment) then begin
         PropEditField(edNOrderAmountCOD,false);
         ShowLableFieldEnable(lblNOrderAmountCOD);
      end;
    end else if Mode = cModeJSOHeaderItem_Read then begin
      self.Caption := 'Интернет заказ клиента ПРОСМОТР';
      btnSlOrderShipping.Visible   := false;
      btnSlOrderPayment.Visible    := false;
      btnSetAssemblingDate.Visible := false;
      btnSlOrderStatus.Visible     := false;
      btnSlGroupPharm.Visible      := false;
      btnSlNameDriver.Visible      := false;
      btnCalcCOD.Visible           := false;
    end;
    { Получаем данные о состоянии статуса }
    DM_CCJSO.JSOHistGetActionDateInfo(
                                      RecSession.CurrentUser,
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
    { Окно активно }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_OrderHeaderItem.ShowLableFieldEnable(lblField : TLabel);
var
  SCaption    : string;
  lblLeftOld  : integer;
  lblWidthOld : integer;
  lblLeftNew  : integer;
  lblWidthNew : integer;
begin
  //SCaption := lblField.Caption;
  //lblLeftOld := lblField.Left;
  //lblWidthOld := TextPixWidth(SCaption, lblField.Font);
  //lblField.Font.style := lblField.Font.style + [fsBold];
  //lblField.Font.Name := 'Arial Narrow';
  //lblWidthNew := TextPixWidth(SCaption, lblField.Font);
  //lblLeftNew := lblLeftOld - (lblWidthNew - lblWidthOld);
  //lblField.Left := lblLeftNew;
end;

procedure TfrmCCJSO_OrderHeaderItem.ShowLableFieldNotEdit(lblField : TLabel);
var
  SCaption    : string;
  lblLeftOld  : integer;
  lblWidthOld : integer;
  lblLeftNew  : integer;
  lblWidthNew : integer;
begin
  //SCaption := lblField.Caption;
  //lblLeftOld := lblField.Left;
  //lblWidthOld := TextPixWidth(SCaption, lblField.Font);
  //lblField.Font.Style := lblField.Font.style - [fsBold];
  //lblField.Font.Name := 'MS Sans Serif';
  //lblWidthNew := TextPixWidth(SCaption, lblField.Font);
  //lblLeftNew := lblLeftOld - (lblWidthNew - lblWidthOld);
  //lblField.Left := lblLeftNew;
end;

procedure TfrmCCJSO_OrderHeaderItem.ShowGets;
var
  SignBeSureToEnter_AssemblingDate : boolean;
begin
  if ISignActive = 1 then begin
    { Инициализация }
    SignBeSureToEnter_AssemblingDate := false;
    { Управление доступом к полям и кнопкам }
    if Mode = cModeJSOHeaderItem_Edit then begin
      { Управление доступом к редактированию суммы наложенного платежа }
      if DM_CCJSO.GetSignCOD(RecSession.CurrentUser,edOrderPayment.Text) then begin
         PropEditField(edNOrderAmountCOD,false);
         ShowLableFieldEnable(lblNOrderAmountCOD);
         if length(trim(edNOrderAmountCOD.Text)) = 0 then edNOrderAmountCOD.Color  := clYellow
                                                     else edNOrderAmountCOD.Color  := clWindow;
         btnCalcCOD.Visible := true;
      end else begin
         PropNotEditField(edNOrderAmountCOD);
         ShowLableFieldNotEdit(lblNOrderAmountCOD);
         btnCalcCOD.Visible := false;
      end;
      { Определение SignBeSureToEnter_AssemblingDate }
      if    (Pos(cOrderShipping_ExpressDelivery,RecHeaderItemNew.orderShipping)>0)
         or (Pos(cOrderShipping_NovaPoshta,RecHeaderItemNew.orderShipping)>0) then begin
        if     (length(RecHeaderItemNew.SAssemblingDate) = 0)
           and (
                   (RecHeaderItemNew.SStatusName = cStatus_MakeCallClient)
                or (recHistInfo_StatusMakeCallClient.NumbRegistered > 0)
               ) then begin SignBeSureToEnter_AssemblingDate := true;  edSAssemblingDate.Color := clYellow; end
                 else begin SignBeSureToEnter_AssemblingDate := false; edSAssemblingDate.Color := clInfoBk; end;
      end;
      if GetSignValueFieldChange then begin
        aSave.Enabled := true;
        aUndo.Enabled := true;
        { Уточнение доступа к действию aSave}
        if SignBeSureToEnter_AssemblingDate then aSave.Enabled := false
                                            else edSAssemblingDate.Color := clInfoBk;
      end else begin
        aSave.Enabled := false;
        aUndo.Enabled := false;
        { Уточнение доступа к отмене изменений }
        if     (DM_CCJSO.GetSignCOD(RecSession.CurrentUser,edOrderPayment.Text))
           and (
                   (length(trim(edNOrderAmountCOD.Text)) = 0)
                or (not ufoTryStrToCurr(edNOrderAmountCOD.Text))
               )
        then aUndo.Enabled := true;
      end;
    end else if Mode = cModeJSOHeaderItem_Read then begin
      aSave.Enabled := false;
      aUndo.Enabled := false;
    end;
  end;
end;

procedure TfrmCCJSO_OrderHeaderItem.SetMode(Parm : integer); begin Mode := Parm; end;
procedure TfrmCCJSO_OrderHeaderItem.SetRecHeaderItem(Parm : TJSO_OrderHeaderItem); begin RecHeaderItemOld := Parm; end;
procedure TfrmCCJSO_OrderHeaderItem.SetRecSession(Parm : TUserSession); begin RecSession := Parm; end;
procedure TfrmCCJSO_OrderHeaderItem.SetParentsList(Parm : string); begin ParentsList := Parm; end;
procedure TfrmCCJSO_OrderHeaderItem.SetSlavesList(Parm : string); begin SlavesList := Parm; end;

function TfrmCCJSO_OrderHeaderItem.GetSignValueFieldChange : boolean;
var
  bResReturn          : boolean;
begin
  bResReturn := true;
  if     (edOrderShipping.Text        = RecHeaderItemOld.orderShipping)
     and (edOrderPayment.Text         = RecHeaderItemOld.orderPayment)
     and (edSAssemblingDate.Text      = RecHeaderItemOld.SAssemblingDate)
     and (edSDispatchDeclaration.Text = RecHeaderItemOld.SDispatchDeclaration)
     and (edSDeclarationReturn.Text   = RecHeaderItemOld.SDeclarationReturn)
     and (edSStatusName.Text          = RecHeaderItemOld.SStatusName)
     and (edSGroupPharmName.Text      = RecHeaderItemOld.SGroupPharmName)
     and (edSNameDriver.Text          = RecHeaderItemOld.SNameDriver)
     and (edSNote.Text                = RecHeaderItemOld.SNote)
     and (StrToCurr(edOrderAmount.Text) = RecHeaderItemOld.orderAmount)
     and (
             (length(trim(edNOrderAmountShipping.Text)) = 0)
          or (not ufoTryStrToCurr(edNOrderAmountShipping.Text))
          or (
                  (ufoTryStrToCurr(edNOrderAmountShipping.Text))
              and (StrToCurr(edNOrderAmountShipping.Text) = RecHeaderItemOld.NOrderAmountShipping)
             )
         )
     and (
             (length(trim(edNCoolantSum.Text)) = 0)
          or (not ufoTryStrToCurr(edNCoolantSum.Text))
          or (
                  (ufoTryStrToCurr(edNCoolantSum.Text))
              and (StrToCurr(edNCoolantSum.Text) = RecHeaderItemOld.NCoolantSum)
             )
         )
     and (
             (length(trim(edNOrderAmountCOD.Text)) = 0)
          or (not ufoTryStrToCurr(edNOrderAmountCOD.Text))
          or (    (not DM_CCJSO.GetSignCOD(RecSession.CurrentUser,edOrderPayment.Text))
              and (length(trim(edNOrderAmountCOD.Text)) > 0)
              and (ufoTryStrToCurr(edNOrderAmountCOD.Text))
              and (StrToCurr(edNOrderAmountCOD.Text) = RecHeaderItemOld.NOrderAmountCOD)
             )
          or (
                  DM_CCJSO.GetSignCOD(RecSession.CurrentUser,edOrderPayment.Text)
              and (ufoTryStrToCurr(edNOrderAmountCOD.Text))
              and (StrToCurr(edNOrderAmountCOD.Text) = RecHeaderItemOld.NOrderAmountCOD)
             )
         )
  then bResReturn := false;
  result := bResReturn;
end;

procedure TfrmCCJSO_OrderHeaderItem.InitFields(GetAddFields: Boolean);
var
  vAddFields: TOrderHeaderHAddFields;
begin
  { Инциализаия - Реквизиты }
  edSOrderID.Text             := RecHeaderItemOld.SorderID;
  edSOrderDt.Text             := RecHeaderItemOld.SOrderDt;
  edSCreateDate.Text          := RecHeaderItemOld.SCreateDate;
  edSCloseDate.Text           := RecHeaderItemOld.SCloseDate;
  edApteka.Text               := RecHeaderItemOld.Apteka;
  edOrderAmount.Text          := CurrToStrF(RecHeaderItemOld.orderAmount, ffFixed, 2); { Сумма заказа }
  edNOrderAmountShipping.Text := CurrToStrF(RecHeaderItemOld.NOrderAmountShipping, ffFixed, 2); { +Сумма }
  edNOrderAmountCOD.Text      := CurrToStrF(RecHeaderItemOld.NOrderAmountCOD, ffFixed, 2); { Наложенный платеж }
  edNCoolantSum.Text          := CurrToStrF(RecHeaderItemOld.NCoolantSum, ffFixed, 2); { Хладоген сумма }
  edOrderShipping.Text        := RecHeaderItemOld.orderShipping;  { Вид доставки }
  edOrderPayment.Text         := RecHeaderItemOld.orderPayment;   { Вид оплаты }
  { Инциализаия - Клиент }
  edShipName.Text        := RecHeaderItemOld.orderShipName;
  edOrderPhone.Text      := RecHeaderItemOld.orderPhone;
  edMPhone.Text          := RecHeaderItemOld.MPhone;
  edOrderEmail.Text      := RecHeaderItemOld.orderEmail;
  edOrderShipStreet.Text := RecHeaderItemOld.orderShipStreet;
  edSOrderShipCity.Text  := RecHeaderItemOld.SOrderShipCity;  { город }
  edSOrderComment.Text   := RecHeaderItemOld.SOrderComment;   { Примечание (клиент) }
  { Инициализация - Новая Почта }
  edSNPOST_StateName.Text := RecHeaderItemOld.SNPOST_StateName;
  edSNPOST_StateDate.Text := RecHeaderItemOld.SNPOST_StateDate;
  { Инциализаия - исполнение курьер }
  edSSignBell.Text            := RecHeaderItemOld.SSignBell;             { Да - '' }
  edUser.Text                 := RecHeaderItemOld.SUser;
  edSBallDAte.Text            := RecHeaderItemOld.SBellDate;             { маркер времени звонка }
  edSSMSDate.Text             := RecHeaderItemOld.SSMSDate;              { маркер времени СМС }
  edSPayDate.Text             := RecHeaderItemOld.SPayDate;              { маркер времни платежа }
  edSAssemblingDate.Text      := RecHeaderItemOld.SAssemblingDate;       { маркер времени сборки }
  edSExport1CDate.Text        := RecHeaderItemOld.SExport1CDate;
  edSDispatchDeclaration.Text := RecHeaderItemOld.SDispatchDeclaration;  { № декларации - отправка}
  edSDeclarationReturn.Text   := RecHeaderItemOld.SDeclarationReturn;    { № декларации - возврат}
  edSStatusName.Text          := RecHeaderItemOld.SStatusName;           { Наименование статуса заказа }
  edSOrderStatusDate.Text     := RecHeaderItemOld.SOrderStatusDate;
  edSGroupPharmName.Text      := RecHeaderItemOld.SGroupPharmName;
  edSNameDriver.Text          := RecHeaderItemOld.SNameDriver;           { Водитель }
  edSDriverDate.Text          := RecHeaderItemOld.SDriverDate;           { Дата определения водителя }
  edSMarkUser.Text            := RecHeaderItemOld.SMarkDate;
  edSMarkDate.Text            := RecHeaderItemOld.SMarkUser;
  edSBlackListDate.Text       := RecHeaderItemOld.SBlackListDate;
  edSNote.Text                := RecHeaderItemOld.SNote;                 { примечание курьер }
  edParentsList.Text          := ParentsList;
  edSlavesList.Text           := SlavesList;
  edSStockDateBegin.Text      := RecHeaderItemOld.SStockDateBegin;
  edSPharmAssemblyDate.Text   := RecHeaderItemOld.SPharmAssemblyDate;
  if GetAddFields then
  begin
    vAddFields := dmJSO.GetOrderHAddFields(RecHeaderItemOld.orderID);
    edHistoryComments.Text := vAddFields.HistoryComments;
    edHistoryExecMsg.Text := vAddFields.HistoryExecMsg;
  end;  
end;

procedure TfrmCCJSO_OrderHeaderItem.SetRecNew;
begin
  { Реквизиты }
  RecHeaderItemNew.orderAmount          := StrToCurr(edOrderAmount.Text);
  if ufoTryStrToCurr(edNOrderAmountShipping.Text) and (length(trim(edNOrderAmountShipping.Text))>0) then RecHeaderItemNew.NOrderAmountShipping := StrToCurr(edNOrderAmountShipping.Text);
  if ufoTryStrToCurr(edNOrderAmountCOD.Text)      and (length(trim(edNOrderAmountCOD.Text))>0)      then RecHeaderItemNew.NOrderAmountCOD      := StrToCurr(edNOrderAmountCOD.Text);
  if ufoTryStrToCurr(edNCoolantSum.Text)          and (length(trim(edNCoolantSum.Text))>0)          then RecHeaderItemNew.NCoolantSum          := StrToCurr(edNCoolantSum.Text);
  RecHeaderItemNew.orderShipping        := edOrderShipping.Text;         { Вид доставки }
  RecHeaderItemNew.orderPayment         := edOrderPayment.Text;          { Вид оплаты }
  { Исполнение курьер }
  RecHeaderItemNew.SAssemblingDate      := edSAssemblingDate.Text;       { маркер времени сборки }
  RecHeaderItemNew.SDispatchDeclaration := edSDispatchDeclaration.Text;  { № декларации - отправка }
  RecHeaderItemNew.SDeclarationReturn   := edSDeclarationReturn.Text;    { № декларации - возврат }
  RecHeaderItemNew.SStatusName          := edSStatusName.Text;           { Наименование статуса заказа }
  RecHeaderItemNew.SGroupPharmName      := edSGroupPharmName.Text;
  RecHeaderItemNew.SNameDriver          := edSNameDriver.Text;           { Водитель }
  RecHeaderItemNew.SNote                := edSNote.Text;                 { примечание курьер }
end;

procedure TfrmCCJSO_OrderHeaderItem.aExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJSO_OrderHeaderItem.aSaveExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
//  if MessageDLG('Подтвердите выполнение действия.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  FTrySave := True;
  if Assigned(FOnUpd) then
  begin
    try
      FOnUpd(Self, FActionResult, RecHeaderItemNew);
      if FActionResult.IErr <> 0 then
        ShowError(FActionResult.ExecMsg)
      else
        ModalResult := mrOk;
    except
      on E: Exception do
      begin
        FActionResult.IErr := cDefError;
        FActionResult.ExecMsg := TrimRight(E.Message + ' ' + FActionResult.ExecMsg);
        ShowError(FActionResult.ExecMsg);
      end;
    end;
  end
  else
  begin
    IErr := 0;
    SErr := '';
    try
      spHeaderUpdate.Parameters.ParamValues['@USER']              := RecSession.CurrentUser;
      spHeaderUpdate.Parameters.ParamValues['@Order']             := RecHeaderItemNew.orderID;
      spHeaderUpdate.Parameters.ParamValues['@Shipping']          := RecHeaderItemNew.orderShipping;
      spHeaderUpdate.Parameters.ParamValues['@Payment']           := RecHeaderItemNew.orderPayment;
      spHeaderUpdate.Parameters.ParamValues['@ExpressInvoice']    := RecHeaderItemNew.SDispatchDeclaration;
      spHeaderUpdate.Parameters.ParamValues['@OrderStatus']       := RecHeaderItemNew.SStatusName;
      spHeaderUpdate.Parameters.ParamValues['@GroupPharm']        := RecHeaderItemNew.SGroupPharmName;
      spHeaderUpdate.Parameters.ParamValues['@NameDriver']        := RecHeaderItemNew.SNameDriver;
      spHeaderUpdate.Parameters.ParamValues['@Note']              := RecHeaderItemNew.SNote;
      spHeaderUpdate.Parameters.ParamValues['@COD']               := RecHeaderItemNew.NOrderAmountCOD;
      spHeaderUpdate.Parameters.ParamValues['@Amount']            := RecHeaderItemNew.orderAmount;
      spHeaderUpdate.Parameters.ParamValues['@AmountShipping']    := RecHeaderItemNew.NOrderAmountShipping;
      spHeaderUpdate.Parameters.ParamValues['@CoolantSum']        := RecHeaderItemNew.NCoolantSum;
      spHeaderUpdate.Parameters.ParamValues['@DeclarationReturn'] := RecHeaderItemNew.SDeclarationReturn;
      if length(trim(edSAssemblingDate.Text)) = 0
        then spHeaderUpdate.Parameters.ParamValues['@SAssemblingDate'] := ''
        else spHeaderUpdate.Parameters.ParamValues['@SAssemblingDate'] := FormatDateTime('yyyy/mm/dd hh:nn:ss', RecHeaderItemNew.DAssemblingDate);
      spHeaderUpdate.ExecProc;
      IErr := spHeaderUpdate.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr = 0 then Self.Close else begin
        SErr := spHeaderUpdate.Parameters.ParamValues['@SErr'];
        ShowMessage(SErr);
      end;
    except
      on e:Exception do begin
        ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
      end;
    end;
  end;
end;

procedure TfrmCCJSO_OrderHeaderItem.aSlOrderPaymentExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFRefPayment);
   frmReference.SetReadOnly(cFReferenceYesReadOnly);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if (length(DescrSelect) > 0) and (DescrSelect <> edOrderPayment.Text) then begin
      if (DescrSelect = RecHeaderItemOld.orderPayment) then begin
        edOrderPayment.Text := RecHeaderItemOld.orderPayment;
      end else begin
        edOrderPayment.Text := DescrSelect;
      end;
      SetRecNew;
      ShowGets;
    end;
   finally
    FreeAndNil(frmReference);
   end;
  except
  end;
end;

procedure TfrmCCJSO_OrderHeaderItem.aSetAssemblingDateExecute(Sender: TObject);
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

procedure TfrmCCJSO_OrderHeaderItem.aSlOrderStatusExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFReferenceOrderStatus);
   frmReference.SetReadOnly(cFReferenceNoReadOnly);
   frmReference.SetOrderShipping(RecHeaderItemNew.orderShipping);
   frmReference.SetOrderPayment(RecHeaderItemNew.orderPayment);
   frmReference.SetOrder(RecHeaderItemOld.orderID);
   frmReference.SetUser(RecSession.CurrentUser);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if (length(DescrSelect) > 0) and (DescrSelect <> edSStatusName.Text) then begin
      if (DescrSelect = RecHeaderItemOld.SStatusName) then begin
        edSStatusName.Text := RecHeaderItemOld.SStatusName;
        edSOrderStatusDate.Text := RecHeaderItemOld.SOrderStatusDate;
      end else begin
        edSStatusName.Text := DescrSelect;
        edSOrderStatusDate.Text := '';
      end;
      SetRecNew;
      ShowGets;
    end;
   finally
    FreeAndNil(frmReference);
   end;
  except
  end;
end;

procedure TfrmCCJSO_OrderHeaderItem.aSlGroupPharmExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  DescrSelect := '';
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFDicGroupPharm);
   frmReference.SetReadOnly(cFReferenceNoReadOnly);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if length(DescrSelect) > 0 then begin
      edSGroupPharmName.Text := DescrSelect;
      RecHeaderItemNew.NGeoGroupPharm := frmReference.GetRowIDSelect;
      SetRecNew;
      ShowGets;
    end;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJSO_OrderHeaderItem.aSlNameDriverExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  try
    frmReference := TfrmReference.Create(Self);
    frmReference.SetMode(cFReferenceModeSelect);
    frmReference.SetReferenceIndex(cFReferenceDrivers);
    frmReference.SetReadOnly(cFReferenceYesReadOnly);
    try
      frmReference.ShowModal;
      DescrSelect := frmReference.GetDescrSelect;
      if (DescrSelect = RecHeaderItemOld.SStatusName) then begin
        edSNameDriver.Text := RecHeaderItemOld.SNameDriver;
        edSDriverDate.Text := RecHeaderItemOld.SDriverDate;
      end else begin
        edSNameDriver.Text := DescrSelect;
        edSDriverDate.Text := '';
      end;
      SetRecNew;
      ShowGets;
    finally
      frmReference.Free;
    end;
  except
  end;
end;

procedure TfrmCCJSO_OrderHeaderItem.aValueChangeExecute(Sender: TObject);
var
  NameComponent : string;
  NumbCurr      : currency;
  TextOld       : string;
  TextNew       : string;
  SignTry       : boolean;
  COD           : currency;
  RuleCOD       : string;
  IErr          : integer;
  SErr          : string;
begin
  if Sender is TEdit then begin
    NameComponent := (Sender as TEdit).Name;
    TextOld       := (Sender as TEdit).Text;
    TextNew       := TextOld;
    SignTry       := false;
    if    (NameComponent = 'edNOrderAmountCOD')
       or (NameComponent = 'edNOrderAmountShipping')
       or (NameComponent = 'edNCoolantSum')           then begin
      (Sender as TEdit).Font.Color := clWindowText;
      if not ufoTryStrToCurr(TextOld) then begin
        { Выполняем детальный анализ и пытаемся откорректировать точку или запятую }
        upoTryStrToCurr(TextNew);
        if TextOld <> TextNew then begin
          (Sender as TEdit).Text := TextNew;
          (Sender as TEdit).SelLength:=0;
          (Sender as TEdit).SelLength := length((Sender as TEdit).Text);
        end else begin
          SignTry := true;
          (Sender as TEdit).Font.Color := clRed;
        end;
      end;
      { Дополнительный анализ на перерасчет суммы заказа и суммы наложки }
    end else if NameComponent = 'edOrderPayment' then begin
      { Изменение вида оплаты }
      if not DM_CCJSO.GetSignCOD(RecSession.CurrentUser,edOrderPayment.Text) then begin
        { Обнуляем сумму наложенного платежа }
        RecHeaderItemNew.NOrderAmountCOD := 0;
        edNOrderAmountCOD.Text := CurrToStrF(RecHeaderItemNew.NOrderAmountCOD, ffFixed, 2);
      end else begin
        { Если не определена сумма наложенного платежа, то вычисляем ее }
        if    (length(trim(edNOrderAmountCOD.Text)) = 0)
           or (not ufoTryStrToCurr(edNOrderAmountCOD.Text))
           or (StrToCurr(edNOrderAmountCOD.Text) = 0) then begin
          DM_CCJSO.CalcCDO(RecSession.CurrentUser,RecHeaderItemNew.orderAmount,COD,RuleCOD,IErr,SErr);
          if IErr = 0 then begin
            RecHeaderItemNew.NOrderAmountCOD := COD;
            edNOrderAmountCOD.Text := CurrToStrF(RecHeaderItemNew.NOrderAmountCOD, ffFixed, 2);
          end;
        end;
      end;
    end;
  end; { if Sender is TEdit then begin }
  SetRecNew;
  ShowGets;
end;

procedure TfrmCCJSO_OrderHeaderItem.edOrderPaymentDblClick(Sender: TObject);
begin
  if Mode <> cModeJSOHeaderItem_Read then aSlOrderPayment.Execute;
end;

procedure TfrmCCJSO_OrderHeaderItem.edSAssemblingDateDblClick(Sender: TObject);
begin
  if Mode <> cModeJSOHeaderItem_Read then aSetAssemblingDate.Execute;
end;

procedure TfrmCCJSO_OrderHeaderItem.edSStatusNameDblClick(Sender: TObject);
begin
  if Mode = cModeJSOHeaderItem_Edit then aSlOrderStatus.Execute;
end;

procedure TfrmCCJSO_OrderHeaderItem.edSGroupPharmNameDblClick(Sender: TObject);
begin
  if Mode <> cModeJSOHeaderItem_Read then aSlGroupPharm.Execute;
end;

procedure TfrmCCJSO_OrderHeaderItem.edSNameDriverDblClick(Sender: TObject);
begin
  if Mode = cModeJSOHeaderItem_Edit then aSlNameDriver.Execute;
end;

procedure TfrmCCJSO_OrderHeaderItem.aUndoExecute(Sender: TObject);
begin
  RecHeaderItemNew := RecHeaderItemOld;
  InitFields(false);
  ShowGets;
end;

procedure TfrmCCJSO_OrderHeaderItem.edSDispatchDeclarationChange(Sender: TObject);
begin
  SetRecNew;
  aValueChange.Execute;
end;

procedure TfrmCCJSO_OrderHeaderItem.edSNoteChange(Sender: TObject);
begin
  SetRecNew;
  aValueChange.Execute;
end;

procedure TfrmCCJSO_OrderHeaderItem.aSlOrderShippingExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFRefGenAutoShipping);
   frmReference.SetReadOnly(cFReferenceYesReadOnly);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if (length(DescrSelect) > 0) and (DescrSelect <> edOrderShipping.Text) then begin
      if (DescrSelect = RecHeaderItemOld.orderShipping) then begin
        edOrderShipping.Text := RecHeaderItemOld.orderShipping;
      end else begin
        edOrderShipping.Text := DescrSelect;
      end;
      SetRecNew;
      ShowGets;
    end;
   finally
    FreeAndNil(frmReference);
   end;
  except
  end;
end;

procedure TfrmCCJSO_OrderHeaderItem.edOrderShippingDblClick(Sender: TObject);
begin
  if Mode = cModeJSOHeaderItem_Edit then aSlOrderShipping.Execute;
end;

procedure TfrmCCJSO_OrderHeaderItem.aCalcCODExecute(Sender: TObject);
begin
  try
    frmCCJSO_CalcCDO := TfrmCCJSO_CalcCDO.Create(Self);
    frmCCJSO_CalcCDO.SetRecHeaderItem(RecHeaderItemOld);
    frmCCJSO_CalcCDO.SetRecSession(RecSession);
    try
      frmCCJSO_CalcCDO.ShowModal;
      if frmCCJSO_CalcCDO.GetSignExec then begin
        RecHeaderItemNew.NOrderAmountCOD := frmCCJSO_CalcCDO.GetCOD;
        edNOrderAmountCOD.Text := CurrToStr(RecHeaderItemNew.NOrderAmountCOD);
      end;
    finally
      FreeAndNil(frmCCJSO_CalcCDO);
    end;
  except
  end;
end;

function TfrmCCJSO_OrderHeaderItem.ShowDialog(OnUpd: TActionDlgEvent): TActionResult;
begin
  SetMode(cModeJSOHeaderItem_ActionEdit);
  FOnUpd := OnUpd;
  ShowModal;
  Result.IErr := FActionResult.IErr;
  Result.ExecMsg := FActionResult.ExecMsg;
end;

end.
