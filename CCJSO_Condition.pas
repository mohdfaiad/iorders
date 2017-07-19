unit CCJSO_Condition;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, ActnList, ToolWin, StdCtrls,
  UCCenterJournalNetZkz, Menus, uDMJSO, DBCtrls, UtilsBase;

type
  TfrmCCJSO_Condition = class(TForm)
    pnlControl: TPanel;
    pnlCondition: TPanel;
    pnlCondition_Tool: TPanel;
    pnlCondition_Show: TPanel;
    pgcCondirion: TPageControl;
    tabJournal: TTabSheet;
    tabOrder: TTabSheet;
    tabHistory: TTabSheet;
    Actions: TActionList;
    aControl_Ok: TAction;
    aControl_Clear: TAction;
    aControl_Close: TAction;
    tlbarControl: TToolBar;
    tlbtnControl_Ok: TToolButton;
    tlbtnControlClear: TToolButton;
    tlbtnControl_Close: TToolButton;
    grbxPeriod: TGroupBox;
    aValueFieldChange: TAction;
    grbxTitleOrder: TGroupBox;
    lblOrder: TLabel;
    edOrder: TEdit;
    lblState: TLabel;
    cmbxOrderState: TComboBox;
    lblPharmacy: TLabel;
    edPharmacy: TEdit;
    btnSlPharmacy: TButton;
    lblShipping: TLabel;
    edShipping: TEdit;
    btnSlShipping: TButton;
    lblSignNewOrder: TLabel;
    cmbxSignNewOrder: TComboBox;
    grbxClient: TGroupBox;
    lblAllNameClient: TLabel;
    lblPhoneClient: TLabel;
    lblAdresClient: TLabel;
    edAllNameClient: TEdit;
    btnSlAllNameClient: TButton;
    edPhoneClient: TEdit;
    btnClPhoneClient: TButton;
    edAdresClient: TEdit;
    btnSlAdresClient: TButton;
    aSlShipping: TAction;
    aSlAllNameClient: TAction;
    aSlPhoneClient: TAction;
    aSlAdresClient: TAction;
    aSlPharmacy: TAction;
    tabPay: TTabSheet;
    grbxGeoGroupPharm: TGroupBox;
    edGeoGroupPharm: TEdit;
    btnSLGeoGroupPharm: TButton;
    chbxGeoGroupPharmNotDefined: TCheckBox;
    aSlGeoGroupPharm: TAction;
    lblSignDefinedParm: TLabel;
    cmbxSignDefinedPharm: TComboBox;
    grbxMarkOrder: TGroupBox;
    cmbxMark: TComboBox;
    lblMarkOtherUser: TLabel;
    edMarkOtherUser: TEdit;
    btnSlMarkOtherUser: TButton;
    aSlMarkOtherUser: TAction;
    pnlOrderPeriod: TPanel;
    pnlOrderPeriod_Check: TPanel;
    pnlOrderPeriod_Periods: TPanel;
    lblKindCheckPeriod: TLabel;
    cmbxCheckPeriod: TComboBox;
    chbxCndAccountPeriod: TCheckBox;
    pgcPeriods: TPageControl;
    tabPeriod_Day: TTabSheet;
    tabPeriod_Date: TTabSheet;
    Label3: TLabel;
    Label4: TLabel;
    dtDateBegin: TDateTimePicker;
    dtTimeBegin: TDateTimePicker;
    dtTimeEnd: TDateTimePicker;
    dtDateEnd: TDateTimePicker;
    lblCndDatePeriod_with: TLabel;
    dtCndBegin: TDateTimePicker;
    lblCndDatePeriod_toOn: TLabel;
    dtCndEnd: TDateTimePicker;
    lblCity: TLabel;
    edCity: TEdit;
    btnCity: TButton;
    aSlCity: TAction;
    grbxNPOST: TGroupBox;
    lblSDispatchDeclaration: TLabel;
    lblSNPOST_StateName: TLabel;
    Label2: TLabel;
    dtDNPOST_StateBegin: TDateTimePicker;
    Label5: TLabel;
    dtDNPOST_StateEnd: TDateTimePicker;
    edSDispatchDeclaration: TEdit;
    edSNPOST_StateName: TEdit;
    chbxNPOST_SignStateDate: TCheckBox;
    aSlSNPOST_StateName: TAction;
    btnSlSNPOST_StateName: TButton;
    grbxPlanDateSend: TGroupBox;
    Label1: TLabel;
    cmbxSignPeriod_PDS: TComboBox;
    pnlPlanDateSend: TPanel;
    pnlPlanDateSend_Calendar: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    dtBeginDate_PDS: TDateTimePicker;
    dtEndDate_PDS: TDateTimePicker;
    pnlPlanDateSend_Time: TPanel;
    Label8: TLabel;
    dtBeginClockDate_PDS: TDateTimePicker;
    dtBeginClockTime_PDS: TDateTimePicker;
    Label9: TLabel;
    dtEndClockDate_PDS: TDateTimePicker;
    dtEndClockTime_PDS: TDateTimePicker;
    lblSignLink: TLabel;
    cmbxSignLink: TComboBox;
    lblPayment: TLabel;
    edPayment: TEdit;
    btnSlPayment: TButton;
    aSlPayment: TAction;
    pnlPay_Have: TPanel;
    lblPay_Have: TLabel;
    cmbxPay_Have: TComboBox;
    lblPay_BarCode: TLabel;
    edPay_BarCode: TEdit;
    pnlPayBetween: TPanel;
    pnlPayBetween_Sum: TPanel;
    lblPay_SumFrom: TLabel;
    lblPay_SumTo: TLabel;
    edPay_SumFrom: TEdit;
    edPay_SumTo: TEdit;
    lblPay_Sum: TLabel;
    pnlPayBetween_CreateDate: TPanel;
    lblPay_CreateDateBegin: TLabel;
    lblPay_CreateDateRnd: TLabel;
    lblPay_CreateDate: TLabel;
    edPay_CreateDateBegin: TEdit;
    edPay_CreateDateRnd: TEdit;
    pnlPayBetween_RedeliveryDate: TPanel;
    lblPay_RedeliveryDateBegin: TLabel;
    lblPay_RedeliveryDateEnd: TLabel;
    lblPay_RedeliveryDate: TLabel;
    edPay_RedeliveryDateBegin: TEdit;
    edPay_RedeliveryDateEnd: TEdit;
    pnlPayBetween_Date: TPanel;
    lblPay_DateBegin: TLabel;
    lblPay_DateEnd: TLabel;
    lblPay_Date: TLabel;
    edPay_DateBegin: TEdit;
    edPay_DateEnd: TEdit;
    aSlDate: TAction;
    btnPay_DateBegin: TButton;
    btnPay_DateEnd: TButton;
    dtnPay_RedeliveryDateBegin: TButton;
    dtnPay_RedeliveryDateEnd: TButton;
    btnPay_CreateDateBegin: TButton;
    btnPay_CreateDateRnd: TButton;
    aEdSum: TAction;
    tabNPostPay: TTabSheet;
    pmTab: TPopupMenu;
    aTabCheckJournal: TAction;
    aTabCheckOrder: TAction;
    aTabCheckHistory: TAction;
    aTabCheckPay: TAction;
    aTabCheckNPostPay: TAction;
    aTabCheck: TAction;
    pmiTabCheckJournal: TMenuItem;
    pmiTabCheckOrder: TMenuItem;
    pmiTabCheckHistory: TMenuItem;
    pmiTabCheckPay: TMenuItem;
    pmiTabCheckNPostPay: TMenuItem;
    Panel2: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    cmbxNPostPay_Have: TComboBox;
    edNPostPay_BarCode: TEdit;
    Panel1: TPanel;
    Panel3: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    edNPostPay_SumFrom: TEdit;
    edNPostPay_SumTo: TEdit;
    Panel4: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    edNPostPay_CreateDateBegin: TEdit;
    edNPostPay_CreateDateEnd: TEdit;
    btnNPostPay_CreateDateBegin: TButton;
    btnNPostPay_CreateDateEnd: TButton;
    Panel5: TPanel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    edNPostPay_RedeliveryDateBegin: TEdit;
    edNPostPay_RedeliveryDateEnd: TEdit;
    btnNPostPay_RedeliveryDateBegin: TButton;
    btnNPostPay_RedeliveryDateEnd: TButton;
    grbxStock: TGroupBox;
    cmbxSignStock: TComboBox;
    lblSStockDateBegin: TLabel;
    edSStockDateBegin: TEdit;
    lblSStockDateEnd: TLabel;
    edSStockDateEnd: TEdit;
    btnSStockDateBegin: TButton;
    btnSStockDateEnd: TButton;
    lcSrcSystem: TDBLookupComboBox;
    Label21: TLabel;
    Label22: TLabel;
    edExtId: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aControl_OkExecute(Sender: TObject);
    procedure aControl_ClearExecute(Sender: TObject);
    procedure aControl_CloseExecute(Sender: TObject);
    procedure aValueFieldChangeExecute(Sender: TObject);
    procedure aSlShippingExecute(Sender: TObject);
    procedure aSlAllNameClientExecute(Sender: TObject);
    procedure aSlPhoneClientExecute(Sender: TObject);
    procedure aSlAdresClientExecute(Sender: TObject);
    procedure aSlPharmacyExecute(Sender: TObject);
    procedure aSlGeoGroupPharmExecute(Sender: TObject);
    procedure chbxGeoGroupPharmNotDefinedClick(Sender: TObject);
    procedure aSlMarkOtherUserExecute(Sender: TObject);
    procedure aSlCityExecute(Sender: TObject);
    procedure aSlSNPOST_StateNameExecute(Sender: TObject);
    procedure cmbxSignLinkChange(Sender: TObject);
    procedure aSlPaymentExecute(Sender: TObject);
    procedure aSlDateExecute(Sender: TObject);
    procedure aEdSumExecute(Sender: TObject);
    procedure pgcCondirionChange(Sender: TObject);
    procedure aTabCheckExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActive       : smallint;
    SignOkCondition   : boolean;
    RecCondition      : TJSO_Condition;
    RecSession        : TUserSession;
    SignDSEmpty       : boolean;
    SignOrderClose    : boolean;
    ParentsList       : string;
    SlavesList        : string;
    RNAllNameClient   : integer; { RN-клиента из автосправочника }
    NMarkOtherUser    : integer; { RN-пользователя (исполнителя) избранных интернет-заказов }
    NPOST_StateID     : integer; { RN-состояние экспресс-накладной }
    //
    procedure ShowGets;
    procedure ShowGetsEnable_ActionLink(Item : integer);
    function GetSignValueFieldChange   : boolean;
    function GetStateConditionJournal  : boolean;
    function GetStateConditionOrder    : boolean;
    function GetStateConditionHistory  : boolean;
    function GetStateConditionPay      : boolean;
    function GetStateConditionNPostPay : boolean;
  public
    { Public declarations }
    procedure SetRecCondition(Parm : TJSO_Condition);
    procedure SetRecSession(Parm : TUserSession);
    procedure SetSignDSEmpty(Parm : boolean);
    procedure SetSignOrderClose(Parm : boolean);
    procedure SetParentsList(Parm : string);
    procedure SetSlavesList(Parm : string);
    function GetRecCondition : TJSO_Condition;
    function GetSignOkCondition   : boolean;
  end;

var
  frmCCJSO_Condition: TfrmCCJSO_Condition;

implementation

uses
  Util, DateUtils, ExDBGRID,
  UMAIN, UReference, CCJSO_SetFieldDate;

{$R *.dfm}

const
  sMsgSumTypeCurr = 'Сумма платежа имеет числовой формат';

procedure TfrmCCJSO_Condition.FormCreate(Sender: TObject);
begin
  { Инициализация }
  SignOkCondition := false;
  ISignActive      := 0;
  RNAllNameClient  := 0;
  SignDSEmpty      := true;
  SignOrderClose   := true;
  ParentsList      := '';
  SlavesList       := '';
  { Приводим закладки по виду контрольного периода даты создания заказа к более красивому виду }
  tabPeriod_Day.Caption    := '';
  tabPeriod_Date.Caption   := '';
  pgcPeriods.TabHeight     := 1;
  pgcPeriods.TabPosition   := tpLeft;
  grbxPeriod.Height        := 93;
  self.Height := self.Height - 20;
  { Убираем лишнее по согласованной дате доставки с клиентом }
  pnlPlanDateSend.Visible := false;
  grbxPlanDateSend.Height := grbxPlanDateSend.Height - pnlPlanDateSend.Height;
  self.Height := self.Height - pnlPlanDateSend.Height;
end;

procedure TfrmCCJSO_Condition.FormActivate(Sender: TObject);
begin
  if ISignActive = 0 then begin
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(179,self.Icon);
    { Стартовая закладка }
    pgcCondirion.ActivePage := tabJournal;
    { По умолчанию считается, что после создания формы запускаются все public set-процедуры }
    { Инициализация - Заголовок заказа }
    cmbxCheckPeriod.ItemIndex           := RecCondition.SignOrderPeriod;
    dtCndBegin.Date                     := RecCondition.BeginDate;
    dtCndEnd.Date                       := RecCondition.EndDate;
    dtDateBegin.Date                    := RecCondition.BeginClockDate;
    dtTimeBegin.Time                    := RecCondition.BeginClockTime;
    dtDateEnd.Date                      := RecCondition.EndClockDate;
    dtTimeEnd.Time                      := RecCondition.EndClockTime;
    chbxCndAccountPeriod.Checked        := RecCondition.SignAccountPeriod;
    edOrder.Text                        := RecCondition.SOrderID;
    edCity.Text                         := RecCondition.SCity;
    cmbxOrderState.ItemIndex            := RecCondition.OrderState;
    cmbxSignNewOrder.ItemIndex          := RecCondition.SignNewOrder;
    edPharmacy.Text                     := RecCondition.Pharmacy;
    edShipping.Text                     := RecCondition.Shipping;
    edPayment.Text                      := RecCondition.Payment;
    edAllNameClient.Text                := RecCondition.AllNameClient;
    edPhoneClient.Text                  := RecCondition.PhoneClient;
    edAdresClient.Text                  := RecCondition.AdresClient;
    edGeoGroupPharm.Text                := RecCondition.SGeoGroupPharm;
    chbxGeoGroupPharmNotDefined.Checked := RecCondition.SignGeoGroupPharmNotDefined;
    cmbxSignDefinedPharm.ItemIndex      := RecCondition.SignDefinedPharm;
    cmbxMark.ItemIndex                  := RecCondition.SignMark;
    edMarkOtherUser.Text                := RecCondition.SMarkOtherUser;
    NMarkOtherUser                      := RecCondition.NMarkOtherUser;
    edSDispatchDeclaration.Text         := RecCondition.SDispatchDeclaration;
    NPOST_StateID                       := RecCondition.NPOST_StateID;
    edSNPOST_StateName.Text             := RecCondition.SNPOST_StateName;
    dtDNPOST_StateBegin.Date            := RecCondition.DNPOST_StateBegin;
    dtDNPOST_StateEnd.Date              := RecCondition.DNPOST_StateEnd;
    chbxNPOST_SignStateDate.Checked     := RecCondition.NPOST_SignStateDate;
    cmbxSignPeriod_PDS.ItemIndex        := RecCondition.SignPeriod_PDS;
    dtBeginDate_PDS.Date                := RecCondition.BeginDate_PDS;
    dtEndDate_PDS.Date                  := RecCondition.EndDate_PDS;
    dtBeginClockDate_PDS.Date           := RecCondition.BeginClockDate_PDS;
    dtBeginClockTime_PDS.Time           := RecCondition.BeginClockTime_PDS;
    dtEndClockDate_PDS.Date             := RecCondition.EndClockDate_PDS;
    dtEndClockTime_PDS.Time             := RecCondition.EndClockTime_PDS;
    cmbxSignLink.ItemIndex              := RecCondition.SignLink;
    cmbxSignStock.ItemIndex             := RecCondition.SignStockDate;
    edSStockDateBegin.Text              := RecCondition.SStockDateBegin;
    edSStockDateEnd.Text                := RecCondition.SStockDateEnd;
    if Assigned(lcSrcSystem.ListSource) then
    begin
      if Assigned(lcSrcSystem.ListSource.DataSet) then
      begin
        lcSrcSystem.ListSource.DataSet.Active := false;
        lcSrcSystem.ListSource.DataSet.Active := true;
      end;
      if VarIsAssigned(RecCondition.SrcSystem) and lcSrcSystem.ListSource.DataSet.Locate('ExtSystem', RecCondition.SrcSystem, []) then
        lcSrcSystem.KeyValue := RecCondition.SrcSystem
      else
        lcSrcSystem.KeyValue := Null;
    end;
    edExtId.Text := RecCondition.ExtId;
    { Инициализация - Состав заказа }
    { Инициализация - История операций }
    { Инициализация - Платежи }
    cmbxPay_Have.ItemIndex          := RecCondition.HavePay;
    edPay_BarCode.Text              := RecCondition.BarCode;
    edPay_SumFrom.Text              := RecCondition.PaySumFrom;
    edPay_SumTo.Text                := RecCondition.PaySumTo;
    edPay_DateBegin.Text            := RecCondition.PayDateBegin;
    edPay_DateEnd.Text              := RecCondition.PayDateEnd;
    edPay_RedeliveryDateBegin.Text  := RecCondition.PayRedeliveryDateBegin;
    edPay_RedeliveryDateEnd.Text    := RecCondition.PayRedeliveryEnd;
    edPay_CreateDateBegin.Text      := RecCondition.PayCreateDateBegin;
    edPay_CreateDateRnd.Text        := RecCondition.PayCreateDateEnd;
    { Инициализация - Наложенные платежи }
    cmbxNPostPay_Have.ItemIndex          := RecCondition.NPostHavePay;
    edNPostPay_BarCode.Text              := RecCondition.NPostBarCode;
    edNPostPay_SumFrom.Text              := RecCondition.NPostPaySumFrom;
    edNPostPay_SumTo.Text                := RecCondition.NPostPaySumTo;
    edNPostPay_RedeliveryDateBegin.Text  := RecCondition.NPostPayRedeliveryDateBegin;
    edNPostPay_RedeliveryDateEnd.Text    := RecCondition.NPostPayRedeliveryEnd;
    edNPostPay_CreateDateBegin.Text      := RecCondition.NPostPayCreateDateBegin;
    edNPostPay_CreateDateEnd.Text        := RecCondition.NPostPayCreateDateEnd;
    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

(* Управление доступом к действиям aJSOLink_* *)
procedure TfrmCCJSO_Condition.ShowGetsEnable_ActionLink(Item : integer);
begin
  if SignDSEmpty then begin
    if cmbxSignLink.ItemIndex = cJSOSignLink_FindCurrentOrders then cmbxSignLink.ItemIndex := 0;
  end else begin
    if SignOrderClose then begin
      if cmbxSignLink.ItemIndex = cJSOSignLink_FindCurrentOrders then
        if (length(ParentsList) = 0) and (length(SlavesList) = 0) then cmbxSignLink.ItemIndex := 0;
    end else begin
      if cmbxSignLink.ItemIndex = cJSOSignLink_FindCurrentOrders then
        if (length(ParentsList) = 0) and (length(SlavesList) = 0) then cmbxSignLink.ItemIndex := 0;
    end;
  end;
  { Закрываем дествие aJSOLink_FindFavorites для большого периода }
  if cmbxSignLink.ItemIndex = cJSOSignLink_FindFavorites then
    if cmbxCheckPeriod.ItemIndex = 0 then begin { Календарный период }
      if (DaysBetween(dtCndEnd.Date,dtCndBegin.Date) > 60) or (not chbxCndAccountPeriod.Checked)
        then cmbxSignLink.ItemIndex := 0;
    end else if cmbxCheckPeriod.ItemIndex = 1 then begin { Период (дата + время) }
      if (DaysBetween(dtDateEnd.Date,dtDateBegin.Date) > 60) or (not chbxCndAccountPeriod.Checked)
        then cmbxSignLink.ItemIndex := 0;
    end;
end;

procedure TfrmCCJSO_Condition.ShowGets;
  procedure ShowTabPeriod(SignDay,SignDate : boolean); begin
    tabPeriod_Day.TabVisible    := SignDay;
    tabPeriod_Date.TabVisible   := SignDate;
  end;
  procedure ShowPnlPeriod_PDS(SignDay,SignDateTime : boolean); begin
    if (not SignDay) and (not SignDateTime) then begin
      pnlPlanDateSend_Calendar.Visible := SignDay;
      pnlPlanDateSend_Time.Visible := SignDateTime;
      if pnlPlanDateSend.Visible then begin
        pnlPlanDateSend.Visible := false;
        grbxPlanDateSend.Height := grbxPlanDateSend.Height - pnlPlanDateSend.Height;
        self.Height := self.Height - pnlPlanDateSend.Height;
      end;
    end else if SignDay then begin
      if not pnlPlanDateSend.Visible then begin
        self.Height := self.Height + pnlPlanDateSend.Height;
        grbxPlanDateSend.Height := grbxPlanDateSend.Height + pnlPlanDateSend.Height;
        pnlPlanDateSend.Visible := true;
      end;
      pnlPlanDateSend_Time.Visible := not SignDay;
      pnlPlanDateSend_Calendar.Align := alClient;
      pnlPlanDateSend_Calendar.Visible := SignDay;
    end else if SignDateTime then begin
      if not pnlPlanDateSend.Visible then begin
        self.Height := self.Height + pnlPlanDateSend.Height;
        grbxPlanDateSend.Height := grbxPlanDateSend.Height + pnlPlanDateSend.Height;
        pnlPlanDateSend.Visible := true;
      end;
      pnlPlanDateSend_Calendar.Visible := not SignDateTime;
      pnlPlanDateSend_Time.Align := alClient;
      pnlPlanDateSend_Time.Visible := SignDateTime;
    end;
  end;
begin
  if ISignActive = 1 then begin
    { Выбор вида контрольного периода даты заказа }
    case cmbxCheckPeriod.ItemIndex of
      0: ShowTabPeriod(true, false);
      1: ShowTabPeriod(false,true );
    end;
    { Выбор вида контрольного периода согласованной даты поставки с клиентом }
    case cmbxSignPeriod_PDS.ItemIndex of
      0: ShowPnlPeriod_PDS(false, false);
      1: ShowPnlPeriod_PDS(true, false);
      2: ShowPnlPeriod_PDS(false, true);
      3: ShowPnlPeriod_PDS(false, false);
    end;
    { Доступ к элементам управления }
    if GetSignValueFieldChange then aControl_Ok.Enabled := true else aControl_Ok.Enabled := false;
    if GetStateConditionJournal or GetStateConditionOrder or GetStateConditionHistory or GetStateConditionPay or GetStateConditionNPostPay
      then tlbtnControlClear.Enabled := true
      else tlbtnControlClear.Enabled := false;
    if cmbxMark.ItemIndex = 2 then begin
      edMarkOtherUser.Enabled := true;
      btnSlMarkOtherUser.Enabled := true;
      lblMarkOtherUser.Enabled := true;
    end else begin
      edMarkOtherUser.Text := '';
      edMarkOtherUser.Enabled := false;
      btnSlMarkOtherUser.Enabled := false;
      lblMarkOtherUser.Enabled := false;
    end;
    if chbxNPOST_SignStateDate.Checked then begin
      dtDNPOST_StateBegin.Enabled := true;
      dtDNPOST_StateEnd.Enabled := true;
    end else begin
      dtDNPOST_StateBegin.Enabled := false;
      dtDNPOST_StateEnd.Enabled := false;
    end;
    { Разрешение на условие поиска для связанных заказов }
    ShowGetsEnable_ActionLink(cmbxSignLink.ItemIndex);
  end;
end;

procedure TfrmCCJSO_Condition.SetRecCondition(Parm : TJSO_Condition); begin RecCondition := Parm; end;
procedure TfrmCCJSO_Condition.SetRecSession(Parm : TUserSession); begin RecSession := Parm; end;
procedure TfrmCCJSO_Condition.SetSignDSEmpty(Parm : Boolean); begin SignDSEmpty := Parm; end;
procedure TfrmCCJSO_Condition.SetSignOrderClose(Parm : boolean); begin SignOrderClose := Parm; end;
procedure TfrmCCJSO_Condition.SetParentsList(Parm : string); begin ParentsList := Parm; end;
procedure TfrmCCJSO_Condition.SetSlavesList(Parm : string); begin SlavesList := Parm; end;
function TfrmCCJSO_Condition.GetRecCondition : TJSO_Condition; begin result := RecCondition; end;
function TfrmCCJSO_Condition.GetSignOkCondition : boolean; begin result := SignOkCondition; end;

function TfrmCCJSO_Condition.GetSignValueFieldChange : boolean;
var bResReturn : boolean;
begin
  bResReturn := false;
  if { Реквизиты заказа }
       (dtCndBegin.Date <> RecCondition.BeginDate)
    or (dtCndEnd.Date   <> RecCondition.EndDate)
    or (cmbxCheckPeriod.ItemIndex <> RecCondition.SignOrderPeriod)
    or (dtDateBegin.Date <> RecCondition.BeginClockDate)
    or (dtTimeBegin.Time <> RecCondition.BeginClockTime)
    or (dtDateEnd.Date <> RecCondition.EndClockDate)
    or (dtTimeEnd.Time <> RecCondition.EndClockTime)
    or (chbxCndAccountPeriod.Checked <> RecCondition.SignAccountPeriod)
    or (edOrder.Text <> RecCondition.SOrderID)
    or (edCity.Text <> RecCondition.SCity)
    or (cmbxOrderState.ItemIndex <> RecCondition.OrderState)
    or (cmbxSignNewOrder.ItemIndex <> RecCondition.SignNewOrder)
    or (edPharmacy.Text <> RecCondition.Pharmacy)
    or (edShipping.Text <> RecCondition.Shipping)
    or (edPayment.Text <> RecCondition.Payment)
    or (edAllNameClient.Text <> RecCondition.AllNameClient)
    or (edPhoneClient.Text <> RecCondition.PhoneClient)
    or (edAdresClient.Text <> RecCondition.AdresClient)
    or (edGeoGroupPharm.Text <> RecCondition.SGeoGroupPharm)
    or (chbxGeoGroupPharmNotDefined.Checked <> RecCondition.SignGeoGroupPharmNotDefined)
    or (cmbxSignDefinedPharm.ItemIndex <> RecCondition.SignDefinedPharm)
    or (edSDispatchDeclaration.Text <> RecCondition.SDispatchDeclaration)
    or (edSNPOST_StateName.Text <> RecCondition.SNPOST_StateName)
    or (chbxNPOST_SignStateDate.Checked <> RecCondition.NPOST_SignStateDate)
    or (chbxNPOST_SignStateDate.Checked
        and
        (
         (dtDNPOST_StateBegin.Date <> RecCondition.DNPOST_StateBegin)
         or
         (dtDNPOST_StateEnd.Date <> RecCondition.DNPOST_StateEnd)
        )
       )
    or (cmbxMark.ItemIndex           <> RecCondition.SignMark)
    or (edMarkOtherUser.Text         <> RecCondition.SMarkOtherUser)
    or (cmbxSignPeriod_PDS.ItemIndex <> RecCondition.SignPeriod_PDS)
    or (cmbxSignStock.ItemIndex      <> RecCondition.SignStockDate)
    or (edSStockDateBegin.Text       <> RecCondition.SStockDateBegin)
    or (edSStockDateEnd.Text         <> RecCondition.SStockDateEnd)
    or ((cmbxSignPeriod_PDS.ItemIndex in [1,2])
        and
        (
            (dtBeginDate_PDS.Date      <> RecCondition.BeginDate_PDS)
         or (dtEndDate_PDS.Date        <> RecCondition.EndDate_PDS)
         or (dtBeginClockDate_PDS.Date <> RecCondition.BeginClockDate_PDS)
         or (dtBeginClockTime_PDS.Time <> RecCondition.BeginClockTime_PDS)
         or (dtEndClockDate_PDS.Date   <> RecCondition.EndClockDate_PDS)
         or (dtEndClockTime_PDS.Time   <> RecCondition.EndClockTime_PDS)
        )
       )
    or (cmbxSignLink.ItemIndex <> RecCondition.SignLink)
     { Платежи }
    or (cmbxPay_Have.ItemIndex          <> RecCondition.HavePay)
    or (edPay_BarCode.Text              <> RecCondition.BarCode)
    or (edPay_SumFrom.Text              <> RecCondition.PaySumFrom)
    or (edPay_SumTo.Text                <> RecCondition.PaySumTo)
    or (edPay_DateBegin.Text            <> RecCondition.PayDateBegin)
    or (edPay_DateEnd.Text              <> RecCondition.PayDateEnd)
    or (edPay_RedeliveryDateBegin.Text  <> RecCondition.PayRedeliveryDateBegin)
    or (edPay_RedeliveryDateEnd.Text    <> RecCondition.PayRedeliveryEnd)
    or (edPay_CreateDateBegin.Text      <> RecCondition.PayCreateDateBegin)
    or (edPay_CreateDateRnd.Text        <> RecCondition.PayCreateDateEnd)
     { Наложенные платежи }
    or (cmbxNPostPay_Have.ItemIndex          <> RecCondition.NPostHavePay)
    or (edNPostPay_BarCode.Text              <> RecCondition.NPostBarCode)
    or (edNPostPay_SumFrom.Text              <> RecCondition.NPostPaySumFrom)
    or (edNPostPay_SumTo.Text                <> RecCondition.NPostPaySumTo)
    or (edNPostPay_RedeliveryDateBegin.Text  <> RecCondition.NPostPayRedeliveryDateBegin)
    or (edNPostPay_RedeliveryDateEnd.Text    <> RecCondition.NPostPayRedeliveryEnd)
    or (edNPostPay_CreateDateBegin.Text      <> RecCondition.NPostPayCreateDateBegin)
    or (edNPostPay_CreateDateEnd.Text        <> RecCondition.NPostPayCreateDateEnd)
    or (lcSrcSystem.KeyValue                 <> RecCondition.SrcSystem)
    or (edExtId.Text                         <> RecCondition.ExtId)
  then bResReturn := true;
  result := bResReturn;
end;

function TfrmCCJSO_Condition.GetStateConditionJournal : boolean;
var bResReturn : boolean;
begin
  bResReturn := false;
  if   (length(trim(edOrder.Text)) > 0)
    or (length(trim(edCity.Text)) > 0)
    or (cmbxOrderState.ItemIndex <> 3)
    or (cmbxSignNewOrder.ItemIndex <> 0)
    or (length(trim(edPharmacy.Text)) > 0)
    or (cmbxSignDefinedPharm.ItemIndex <> 0)
    or (length(trim(edShipping.Text)) > 0)
    or (length(trim(edPayment.Text)) > 0)
    or (length(trim(edAllNameClient.Text)) > 0)
    or (length(trim(edPhoneClient.Text)) > 0)
    or (length(trim(edAdresClient.Text)) > 0)
    or (length(trim(edGeoGroupPharm.Text)) > 0)
    or (chbxGeoGroupPharmNotDefined.Checked)
    or (cmbxMark.ItemIndex <> 0)
    or (length(trim(edMarkOtherUser.Text)) > 0)
    or (length(trim(edSDispatchDeclaration.Text)) > 0)
    or (length(trim(edSNPOST_StateName.Text)) > 0)
    or chbxNPOST_SignStateDate.Checked
    or (cmbxSignPeriod_PDS.ItemIndex <> 0)
    or (cmbxSignLink.ItemIndex <> 0)
    or (cmbxSignStock.ItemIndex <> 0)
    or (length(trim(edExtId.Text)) > 0)
    or (VarIsAssigned(lcSrcSystem.KeyValue))
  then bResReturn := true;
  result := bResReturn;
end;

function TfrmCCJSO_Condition.GetStateConditionOrder   : boolean;
var bResReturn : boolean;
begin
  bResReturn := false;
  result := bResReturn;
end;

function TfrmCCJSO_Condition.GetStateConditionHistory : boolean;
var bResReturn : boolean;
begin
  bResReturn := false;
  result := bResReturn;
end;

function TfrmCCJSO_Condition.GetStateConditionPay : boolean;
var bResReturn : boolean;
begin
  bResReturn := false;
  if   (cmbxPay_Have.ItemIndex <> 0)
    or (length(trim(edPay_BarCode.Text)) > 0)
    or (length(trim(edPay_SumFrom.Text)) > 0)
    or (length(trim(edPay_SumTo.Text)) > 0)
    or (length(trim(edPay_DateBegin.Text)) > 0)
    or (length(trim(edPay_DateEnd.Text)) > 0)
    or (length(trim(edPay_RedeliveryDateBegin.Text)) > 0)
    or (length(trim(edPay_RedeliveryDateEnd.Text)) > 0)
    or (length(trim(edPay_CreateDateBegin.Text)) > 0)
    or (length(trim(edPay_CreateDateRnd.Text)) > 0)
  then bResReturn := true;
  result := bResReturn;
end;

function TfrmCCJSO_Condition.GetStateConditionNPostPay : boolean;
var bResReturn : boolean;
begin
  bResReturn := false;
  if   (cmbxNPostPay_Have.ItemIndex <> 0)
    or (length(trim(edNPostPay_BarCode.Text)) > 0)
    or (length(trim(edNPostPay_SumFrom.Text)) > 0)
    or (length(trim(edNPostPay_SumTo.Text)) > 0)
    or (length(trim(edNPostPay_RedeliveryDateBegin.Text)) > 0)
    or (length(trim(edNPostPay_RedeliveryDateEnd.Text)) > 0)
    or (length(trim(edNPostPay_CreateDateBegin.Text)) > 0)
    or (length(trim(edNPostPay_CreateDateEnd.Text)) > 0)
  then bResReturn := true;
  result := bResReturn;
end;

procedure TfrmCCJSO_Condition.aControl_OkExecute(Sender: TObject);
begin
  { Фиксируем параметры отбора }
  { Реквизиты заказа }
  RecCondition.SOrderID                    := trim(edOrder.Text);
  RecCondition.SCity                       := trim(edCity.Text);
  RecCondition.SignOrderPeriod             := cmbxCheckPeriod.ItemIndex;
  RecCondition.BeginDate                   := dtCndBegin.Date;
  RecCondition.EndDate                     := dtCndEnd.Date;
  RecCondition.BeginClockDate              := dtDateBegin.Date;
  RecCondition.BeginClockTime              := dtTimeBegin.Time;
  RecCondition.EndClockDate                := dtDateEnd.Date;
  RecCondition.EndClockTime                := dtTimeEnd.Time;
  RecCondition.SignAccountPeriod           := chbxCndAccountPeriod.Checked;
  RecCondition.OrderState                  := cmbxOrderState.ItemIndex;
  RecCondition.SignNewOrder                := cmbxSignNewOrder.ItemIndex;
  RecCondition.Pharmacy                    := trim(edPharmacy.Text);
  RecCondition.Shipping                    := trim(edShipping.Text);
  RecCondition.Payment                     := trim(edPayment.Text);
  RecCondition.AllNameClient               := trim(edAllNameClient.Text);
  RecCondition.PhoneClient                 := trim(edPhoneClient.Text);
  RecCondition.AdresClient                 := trim(edAdresClient.Text);
  RecCondition.SGeoGroupPharm              := trim(edGeoGroupPharm.Text);
  RecCondition.SignGeoGroupPharmNotDefined := chbxGeoGroupPharmNotDefined.Checked;
  RecCondition.SignDefinedPharm            := cmbxSignDefinedPharm.ItemIndex;
  RecCondition.SignMark                    := cmbxMark.ItemIndex;
  RecCondition.SMarkOtherUser              := edMarkOtherUser.Text;
  RecCondition.NMarkOtherUser              := NMarkOtherUser;
  RecCondition.SDispatchDeclaration        := edSDispatchDeclaration.Text;
  RecCondition.NPOST_StateID               := NPOST_StateID;
  RecCondition.SNPOST_StateName            := edSNPOST_StateName.Text;
  RecCondition.DNPOST_StateBegin           := dtDNPOST_StateBegin.Date;
  RecCondition.DNPOST_StateEnd             := dtDNPOST_StateEnd.Date;
  RecCondition.NPOST_SignStateDate         := chbxNPOST_SignStateDate.Checked;
  RecCondition.SignPeriod_PDS              := cmbxSignPeriod_PDS.ItemIndex;
  RecCondition.BeginDate_PDS               := dtBeginDate_PDS.Date;
  RecCondition.EndDate_PDS                 := dtEndDate_PDS.Date;
  RecCondition.BeginClockDate_PDS          := dtBeginClockDate_PDS.Date;
  RecCondition.BeginClockTime_PDS          := dtBeginClockTime_PDS.Time;
  RecCondition.EndClockDate_PDS            := dtEndClockDate_PDS.Date;
  RecCondition.EndClockTime_PDS            := dtEndClockTime_PDS.Time;
  RecCondition.ExtId                       := trim(edExtId.Text);
  RecCondition.SrcSystem                   := lcSrcSystem.KeyValue;
  { Если признак периода даты интернет заказа <период (дата + время)>,
    то для удобства визуального контроля, даты календарного периода
    устанавливаем как даты периода (дата + время) }
  if RecCondition.SignOrderPeriod = 1 then begin
    RecCondition.BeginDate := RecCondition.BeginClockDate;
    RecCondition.EndDate   := RecCondition.EndClockDate;
  end;
  RecCondition.SignLink        := cmbxSignLink.ItemIndex;
  RecCondition.SignStockDate   := cmbxSignStock.ItemIndex;
  RecCondition.SStockDateBegin := edSStockDateBegin.Text;
  RecCondition.SStockDateEnd   := edSStockDateEnd.Text;
  { Платежи }
  RecCondition.HavePay                 := cmbxPay_Have.ItemIndex;
  RecCondition.BarCode                 := edPay_BarCode.Text;
  RecCondition.PaySumFrom              := edPay_SumFrom.Text;
  RecCondition.PaySumTo                := edPay_SumTo.Text;
  RecCondition.PayDateBegin            := edPay_DateBegin.Text;
  RecCondition.PayDateEnd              := edPay_DateEnd.Text;
  RecCondition.PayRedeliveryDateBegin  := edPay_RedeliveryDateBegin.Text;
  RecCondition.PayRedeliveryEnd        := edPay_RedeliveryDateEnd.Text;
  RecCondition.PayCreateDateBegin      := edPay_CreateDateBegin.Text;
  RecCondition.PayCreateDateEnd        := edPay_CreateDateRnd.Text;
  { Наложенные платежи }
  RecCondition.NPostHavePay                 := cmbxNPostPay_Have.ItemIndex;
  RecCondition.NPostBarCode                 := edNPostPay_BarCode.Text;
  RecCondition.NPostPaySumFrom              := edNPostPay_SumFrom.Text;
  RecCondition.NPostPaySumTo                := edNPostPay_SumTo.Text;
  RecCondition.NPostPayRedeliveryDateBegin  := edNPostPay_RedeliveryDateBegin.Text;
  RecCondition.NPostPayRedeliveryEnd        := edNPostPay_RedeliveryDateEnd.Text;
  RecCondition.NPostPayCreateDateBegin      := edNPostPay_CreateDateBegin.Text;
  RecCondition.NPostPayCreateDateEnd        := edNPostPay_CreateDateEnd.Text;
  { Включаем признак ОК-отбора и выходим }
  SignOkCondition := true;
  self.Close;
end;

procedure TfrmCCJSO_Condition.aControl_ClearExecute(Sender: TObject);
begin
  { Заголовок заказа }
  chbxCndAccountPeriod.Checked        := true;
  edOrder.Text                        := '';
  edCity.Text                         := '';
  cmbxOrderState.ItemIndex            := 3;
  cmbxSignNewOrder.ItemIndex          := 0;
  edPharmacy.Text                     := '';
  RecCondition.NPharmacy              := 0;
  cmbxSignDefinedPharm.ItemIndex      := 0;
  edShipping.Text                     := '';
  edPayment.Text                      := '';
  edAllNameClient.Text                := '';
  edPhoneClient.Text                  := '';
  RecCondition.bSignRefPhone          := false;
  edAdresClient.Text                  := '';
  edGeoGroupPharm.Text                := '';
  RecCondition.NGeoGroupPharm         := 0;
  chbxGeoGroupPharmNotDefined.Checked := false;
  edSDispatchDeclaration.Text         := '';
  edSNPOST_StateName.Text             := '';
  NPOST_StateID                       := 0;
  dtDNPOST_StateBegin.Date            := RecCondition.DNPOST_StateBegin;
  dtDNPOST_StateEnd.Date              := RecCondition.DNPOST_StateEnd;
  chbxNPOST_SignStateDate.Checked     := false;
  cmbxSignPeriod_PDS.ItemIndex        := 0;
  cmbxMark.ItemIndex                  := 0;
  edMarkOtherUser.Text                := '';
  NMarkOtherUser                      := 0;
  cmbxSignLink.ItemIndex              := 0;
  cmbxSignStock.ItemIndex             := 0;
  edSStockDateBegin.Text              := '';
  edSStockDateEnd.Text                := '';
  edExtId.Text                        := '';
  lcSrcSystem.KeyValue                := Null;
  { RN-поля условия отбора }
  RNAllNameClient := 0;
  { Платежи }
  cmbxPay_Have.ItemIndex          := 0;
  edPay_BarCode.Text              := '';
  edPay_SumFrom.Text              := '';
  edPay_SumTo.Text                := '';
  edPay_DateBegin.Text            := '';
  edPay_DateEnd.Text              := '';
  edPay_RedeliveryDateBegin.Text  := '';
  edPay_RedeliveryDateEnd.Text    := '';
  edPay_CreateDateBegin.Text      := '';
  edPay_CreateDateRnd.Text        := '';
  { Наложенные платежи }
  cmbxNPostPay_Have.ItemIndex         := 0;
  edNPostPay_BarCode.Text             := '';
  edNPostPay_SumFrom.Text             := '';
  edNPostPay_SumTo.Text               := '';
  edNPostPay_RedeliveryDateBegin.Text := '';
  edNPostPay_RedeliveryDateEnd.Text   := '';
  edNPostPay_CreateDateBegin.Text     := '';
  edNPostPay_CreateDateEnd.Text       := '';
  ShowGets;
end;

procedure TfrmCCJSO_Condition.aControl_CloseExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJSO_Condition.aValueFieldChangeExecute(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJSO_Condition.aSlShippingExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  DescrSelect := '';
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFRefGenAutoShipping);
   frmReference.SetReadOnly(cFReferenceYesReadOnly);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if length(DescrSelect) > 0 then edShipping.Text := DescrSelect;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJSO_Condition.aSlAllNameClientExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  DescrSelect := '';
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFRefGenAutoShipName);
   frmReference.SetReadOnly(cFReferenceYesReadOnly);
   //frmReference.SetSignLargeDataSet(1);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    RNAllNameClient := frmReference.GetRowIDSelect;
    if length(DescrSelect) > 0 then edAllNameClient.Text := DescrSelect;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJSO_Condition.aSlPhoneClientExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  DescrSelect := '';
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFRefGenAutoPhoneClient);
   frmReference.SetReadOnly(cFReferenceYesReadOnly);
   frmReference.SetSignLargeDataSet(cFReferenceSignLargeDS);
   frmReference.SetSignSlaveSection(1);
   frmReference.SetPRN(RNAllNameClient);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if length(DescrSelect) > 0 then begin
      edPhoneClient.Text := DescrSelect;
      RecCondition.bSignRefPhone := true;
    end;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJSO_Condition.aSlAdresClientExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  DescrSelect := '';
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFRefGenAutoAdresClient);
   frmReference.SetReadOnly(cFReferenceYesReadOnly);
   //frmReference.SetSignLargeDataSet(1);
   frmReference.SetSignSlaveSection(1);
   frmReference.SetPRN(RNAllNameClient);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if length(DescrSelect) > 0 then edAdresClient.Text := DescrSelect;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJSO_Condition.aSlPharmacyExecute(Sender: TObject);
var
  DescrSelect : string;
  RNSelect    : integer;
begin
  DescrSelect := '';
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFReferencePharmacy);
   frmReference.SetReadOnly(cFReferenceYesReadOnly);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    RNSelect    := frmReference.GetRowIDSelect;
    if length(DescrSelect) > 0 then begin
      edPharmacy.Text := DescrSelect;
      RecCondition.NPharmacy := RNSelect;
    end;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJSO_Condition.aSlGeoGroupPharmExecute(Sender: TObject);
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
      edGeoGroupPharm.Text := DescrSelect;
      RecCondition.NGeoGroupPharm := frmReference.GetRowIDSelect;
      chbxGeoGroupPharmNotDefined.Checked := false;
    end;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJSO_Condition.chbxGeoGroupPharmNotDefinedClick(Sender: TObject);
begin
  if chbxGeoGroupPharmNotDefined.Checked then begin
    edGeoGroupPharm.Text := '';
    RecCondition.NGeoGroupPharm := 0;
  end;
  ShowGets;
end;

procedure TfrmCCJSO_Condition.aSlMarkOtherUserExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  DescrSelect := '';
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFReferenceUserBirdAva);
   frmReference.SetReadOnly(cFReferenceYesReadOnly);
   frmReference.SetSignUserBirdAvaExcludCurrent(1);
   frmReference.SetUser(RecCondition.USER);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if length(DescrSelect) > 0 then begin
      edMarkOtherUser.Text := DescrSelect;
      NMarkOtherUser       := frmReference.GetRowIDSelect;
    end;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJSO_Condition.aSlCityExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  DescrSelect := '';
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFJSOAutoRefCity);
   frmReference.SetReadOnly(cFReferenceYesReadOnly);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if length(DescrSelect) > 0 then edCity.Text := DescrSelect;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJSO_Condition.aSlSNPOST_StateNameExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  DescrSelect := '';
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFNPostRefDocumentStatuses);
   frmReference.SetReadOnly(cFReferenceYesReadOnly);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if length(DescrSelect) > 0 then begin
      edSNPOST_StateName.Text := DescrSelect;
      NPOST_StateID := frmReference.GetRowIDSelect;
    end;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJSO_Condition.cmbxSignLinkChange(Sender: TObject);
begin
  ShowGetsEnable_ActionLink(cmbxSignLink.ItemIndex);
  aValueFieldChange.Execute;
end;

procedure TfrmCCJSO_Condition.aSlPaymentExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  DescrSelect := '';
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFRefPayment);
   frmReference.SetReadOnly(cFReferenceYesReadOnly);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if length(DescrSelect) > 0 then edPayment.Text := DescrSelect;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJSO_Condition.aSlDateExecute(Sender: TObject);
var
  EdText         : string;
  DVal           : TDateTime;
  DFormatSet     : TFormatSettings;
  WHeaderCaption : string;
  Tag            : integer;
begin
  Tag := 0;
  if      Sender is TAction then Tag := (Sender as TAction).ActionComponent.Tag
  else if Sender is TEdit   then Tag := (Sender as TEdit).Tag;
  case Tag of
    10: begin EdText := edPay_DateBegin.Text;                 WHeaderCaption := 'Дата платежа (начало)' end;
    11: begin EdText := edPay_DateEnd.Text;                   WHeaderCaption := 'Дата платежа (окончание)' end;
    20: begin EdText := edPay_RedeliveryDateBegin.Text;       WHeaderCaption := 'Дата получения (начало)' end;
    21: begin EdText := edPay_RedeliveryDateEnd.Text;         WHeaderCaption := 'Дата получения (окончание)' end;
    30: begin EdText := edPay_CreateDateBegin.Text;           WHeaderCaption := 'Дата создания платежа (начало)' end;
    31: begin EdText := edPay_CreateDateRnd.Text;             WHeaderCaption := 'Дата создания поатежа (окончание)' end;
    40: begin EdText := edNPostPay_RedeliveryDateBegin.Text;  WHeaderCaption := 'Дата получения (начало)' end;
    41: begin EdText := edNPostPay_RedeliveryDateEnd.Text;    WHeaderCaption := 'Дата получения (окончание)' end;
    50: begin EdText := edNPostPay_CreateDateBegin.Text;      WHeaderCaption := 'Дата создания платежа (начало)' end;
    51: begin EdText := edNPostPay_CreateDateEnd.Text;        WHeaderCaption := 'Дата создания поатежа (окончание)' end;
    60: begin EdText := edSStockDateBegin.Text;               WHeaderCaption := 'Дата оформления заказа на складе (начало)' end;
    61: begin EdText := edSStockDateEnd.Text;                 WHeaderCaption := 'Дата оформления заказа на складе (окончание)' end;
  end;
  if length(trim(EdText)) > 0 then begin
    DFormatSet.DateSeparator := '-';
    DFormatSet.TimeSeparator := ':';
    DFormatSet.ShortDateFormat := 'dd-mm-yyyy';
    DFormatSet.ShortTimeFormat := 'hh24:mi:ss';
    DVal := StrToDateTime(EdText,DFormatSet);
  end else DVal := now;
  try
    frmCCJSO_SetFieldDate := TfrmCCJSO_SetFieldDate.Create(Self);
    frmCCJSO_SetFieldDate.SetMode(cFieldDate_Shared);
    frmCCJSO_SetFieldDate.SetUserSession(RecSession);
    frmCCJSO_SetFieldDate.SetTypeExec(cSFDTypeExec_Return);
    frmCCJSO_SetFieldDate.SetClear(true);
    frmCCJSO_SetFieldDate.SetDateShared(DVal,EdText,WHeaderCaption);
    try
      frmCCJSO_SetFieldDate.ShowModal;
      if frmCCJSO_SetFieldDate.GetOk then begin
        case Tag of
          10: edPay_DateBegin.Text                := frmCCJSO_SetFieldDate.GetSDate;
          11: edPay_DateEnd.Text                  := frmCCJSO_SetFieldDate.GetSDate;
          20: edPay_RedeliveryDateBegin.Text      := frmCCJSO_SetFieldDate.GetSDate;
          21: edPay_RedeliveryDateEnd.Text        := frmCCJSO_SetFieldDate.GetSDate;
          30: edPay_CreateDateBegin.Text          := frmCCJSO_SetFieldDate.GetSDate;
          31: edPay_CreateDateRnd.Text            := frmCCJSO_SetFieldDate.GetSDate;
          40: edNPostPay_RedeliveryDateBegin.Text := frmCCJSO_SetFieldDate.GetSDate;
          41: edNPostPay_RedeliveryDateEnd.Text   := frmCCJSO_SetFieldDate.GetSDate;
          50: edNPostPay_CreateDateBegin.Text     := frmCCJSO_SetFieldDate.GetSDate;
          51: edNPostPay_CreateDateEnd.Text       := frmCCJSO_SetFieldDate.GetSDate;
          60: edSStockDateBegin.Text              := frmCCJSO_SetFieldDate.GetSDate;
          61: edSStockDateEnd.Text                := frmCCJSO_SetFieldDate.GetSDate;
        end;
      end;
    finally
      FreeAndNil(frmCCJSO_SetFieldDate);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
  ShowGets;
end;

procedure TfrmCCJSO_Condition.aEdSumExecute(Sender: TObject);
var
  EdText : string;
begin
  EdText := '';
  if not ufoTryStrToCurr((Sender as TEdit).Text) then begin
    ShowMessage(sMsgSumTypeCurr);
    (Sender as TEdit).SetFocus;
  end;
  ShowGets;
end;

procedure TfrmCCJSO_Condition.pgcCondirionChange(Sender: TObject);
begin
  if      pgcCondirion.ActivePage = TabJournal  then aTabCheckJournal.Checked  := true
  else if pgcCondirion.ActivePage = TabOrder    then aTabCheckOrder.Checked    := true
  else if pgcCondirion.ActivePage = TabHistory  then aTabCheckHistory.Checked  := true
  else if pgcCondirion.ActivePage = TabPay      then aTabCheckPay.Checked      := true
  else if pgcCondirion.ActivePage = TabNPostPay then aTabCheckNPostPay.Checked := true;
end;

procedure TfrmCCJSO_Condition.aTabCheckExecute(Sender: TObject);
begin
  if      aTabCheckJournal.Checked  then pgcCondirion.ActivePage := TabJournal
  else if aTabCheckOrder.Checked    then pgcCondirion.ActivePage := TabOrder
  else if aTabCheckHistory.Checked  then pgcCondirion.ActivePage := TabHistory
  else if aTabCheckPay.Checked      then pgcCondirion.ActivePage := TabPay
  else if aTabCheckNPostPay.Checked then pgcCondirion.ActivePage := TabNPostPay;
end;

end.
