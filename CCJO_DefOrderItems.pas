unit CCJO_DefOrderItems;

{
  © PgkSoft 03.11.2016
  Универсальная форма: Формирование товарных позиций заказа
  Поддерживает два режима работы:
    1 - Подбор товарной позиции, (может определяться с различных форм)
    2 - Подбор товарных позиций заказа (отдельное регистрационное действие)
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Math,
  {--}
  UCCenterJournalNetZkz, ActnList, ExtCtrls, ComCtrls, ToolWin, StdCtrls,
  Grids, DBGrids, JOPH_DM, Menus, uDMJSO;

  { Условия отбора номенклатуры сети ТТ }
  type TCondMainNom = record
    ItemCode                  : string;
    ItemName                  : string;
    SignLinkMaster            : boolean;
    SignLinkMasterSlaveItems  : boolean;
  end;

type
  TfrmCCJO_DefOrderItems = class(TForm)
    aList: TActionList;
    aExit: TAction;
    pnlOrderHeader: TPanel;
    pnlMain: TPanel;
    splitMain: TSplitter;
    pnlState: TPanel;
    pnlSlave: TPanel;
    stBar: TStatusBar;
    pnlMainNom: TPanel;
    SplitMainNom: TSplitter;
    pnlMainItem: TPanel;
    pnlHZakaz: TPanel;
    pnlHZSum: TPanel;
    pnlHZHShipName: TPanel;
    pnlHZHPhone: TPanel;
    pnlHZShipStreet: TPanel;
    pnlMainNomTool: TPanel;
    bvlMainNomTool: TBevel;
    pnlMainNomTool_Cond: TPanel;
    pnlMainNomTool_CondField: TPanel;
    pnlMainNomTool_CondControl: TPanel;
    tbarMainNomTool_Cond: TToolBar;
    pnlMainNomTool_Control: TPanel;
    tbarMainNom_DefOrder: TToolBar;
    aMainNomCond_Find: TAction;
    aMainNomCond_Clear: TAction;
    tbtnMainNomCond_Find: TToolButton;
    tbtnMainNomCond_Clear: TToolButton;
    lblMainNomCond_ItemCode: TLabel;
    edMainNomCond_ItemCode: TEdit;
    lblMainNomCond_ItemName: TLabel;
    edMainNomCond_ItemName: TEdit;
    pnlMainItemTool: TPanel;
    bvlMainItemTool: TBevel;
    pnlMainItemTool_Control: TPanel;
    tbarMainItem: TToolBar;
    aMainNomToOrder: TAction;
    tbtnMainNom_AddToOrder: TToolButton;
    aMainNomSelectItem: TAction;
    tbarMainNom_SelectItem: TToolBar;
    tbtnMainNom_Select: TToolButton;
    tbarMainNom: TToolBar;
    aMainNom_MasterItem: TAction;
    aMainNom_MasterSlaveItems: TAction;
    tbtnMainNom_MasterItem: TToolButton;
    tbtnMainNom_MasterSlaveItems: TToolButton;
    pnlMainNomShow: TPanel;
    pnlMainNomShow_CountRec: TPanel;
    pnlMainNomShow_Name: TPanel;
    pnlMainItemShow: TPanel;
    pnlMainItemShow_CountRec: TPanel;
    pnlMainItemShow_Name: TPanel;
    pnlControl: TPanel;
    pnlSlaveTool: TPanel;
    pnlSlaveTool_Show: TPanel;
    pnlSlaveTool_Control: TPanel;
    pnlControl_Tool: TPanel;
    tbarControl: TToolBar;
    pnlControl_Show: TPanel;
    pnlSlaveTool_CondTool: TPanel;
    tbarSlaveCondTool: TToolBar;
    pnlSlaveTool_CondFields: TPanel;
    GridMainNom: TDBGrid;
    tmrRunTheBoot: TTimer;
    aMaimNom_CondChange: TAction;
    pgGridSlave: TPageControl;
    tabGridSlave_IPA: TTabSheet;
    tabGridSlave_Term: TTabSheet;
    pmMainNom: TPopupMenu;
    pmiMainNom_Ok: TMenuItem;
    pmiMainNom_Delemiter01: TMenuItem;
    pmiMainNom_CondFind: TMenuItem;
    pmiMainNom_MasterItem: TMenuItem;
    pmiMainNom_MasterSlaveItem: TMenuItem;
    pmiMainNom_CondClear: TMenuItem;
    pnlLocateMainNom: TPanel;
    GridItemIPA: TDBGrid;
    GridTermItemIPA: TDBGrid;
    aItemIPACond_OnlyCountForAllItem: TAction;
    aItemIPACond_OnlyCountSLItem: TAction;
    aItemIPACond_OnlyItemOnAllPharmacy: TAction;
    aItemIPACond_AllPharmacy: TAction;
    aItemIPACond_Sales: TAction;
    aItemIPACond_SetListPharm: TAction;
    tbtnSlaveCondTool_SetListPharm: TToolButton;
    pmSetListPharm: TPopupMenu;
    pmiSetListPharm_OnlyCountSLItem: TMenuItem;
    pmiSetListPharm_OnlyItemOnAllPharmacy: TMenuItem;
    pmiSetListPharm_OnlyCountForAllItem: TMenuItem;
    pmiSetListPharm_Delemiter: TMenuItem;
    pmiSetListPharm_AllPharmacy: TMenuItem;
    tbtnSlaveCondTool_Sales: TToolButton;
    aItemIPACond: TAction;
    pnlSlaveTool_CondFields_CountItem: TPanel;
    aItemIPACond_Clear: TAction;
    tbarSlaveCondClear: TToolBar;
    tbtnSlaveCondClear: TToolButton;
    pnlSlaveTool_CondFields_CountItem_Field: TPanel;
    lblSlaveCond_ItemCount: TLabel;
    edSlaveCond_ItemCount: TEdit;
    pnlSlaveTool_CondFields_CountItem_Comment: TPanel;
    pnlSlaveTool_CondFieldsOther: TPanel;
    lblSlaveCond_Pharmacy: TLabel;
    edSlaveCond_Pharmacy: TEdit;
    btnSlaveCond_Pharmacy: TButton;
    aItemIPACond_SlReference: TAction;
    edCountItemComment: TEdit;
    pnlSlaveTool_DefItem: TPanel;
    tbarSlaveTool_DefItem: TToolBar;
    aItemIPA_CheckPharmacy: TAction;
    tbtnSlaveTool_CheckPharmacy: TToolButton;
    aSaveOrder: TAction;
    tbtnControl_SaveOrder: TToolButton;
    tbtnControl_NetNomSelectItem: TToolButton;
    tbtnControl_Exis: TToolButton;
    aMainNomSelectItemWithPharm: TAction;
    tbtnControl_NetNomSlItemWithPharm: TToolButton;
    N1: TMenuItem;
    ToolButton1: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aMainNomCond_FindExecute(Sender: TObject);
    procedure aMainNomCond_ClearExecute(Sender: TObject);
    procedure splitMainMoved(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SplitMainNomMoved(Sender: TObject);
    procedure aMainNomToOrderExecute(Sender: TObject);
    procedure aMainNomSelectItemExecute(Sender: TObject);
    procedure aMainNom_MasterItemExecute(Sender: TObject);
    procedure aMainNom_MasterSlaveItemsExecute(Sender: TObject);
    procedure GridMainNomDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridMainNomTitleClick(Column: TColumn);
    procedure tmrRunTheBootTimer(Sender: TObject);
    procedure aMaimNom_CondChangeExecute(Sender: TObject);
    procedure GridMainNomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridMainNomKeyPress(Sender: TObject; var Key: Char);
    procedure GridItemIPADrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridItemIPATitleClick(Column: TColumn);
    procedure GridMainNomEnter(Sender: TObject);
    procedure GridTermItemIPADrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridTermItemIPATitleClick(Column: TColumn);
    procedure pgGridSlaveChange(Sender: TObject);
    procedure aItemIPACond_SetListPharmExecute(Sender: TObject);
    procedure aItemIPACondExecute(Sender: TObject);
    procedure aItemIPACond_ClearExecute(Sender: TObject);
    procedure edSlaveCond_PharmacyKeyPress(Sender: TObject; var Key: Char);
    procedure aItemIPACond_SlReferenceExecute(Sender: TObject);
    procedure aItemIPA_CheckPharmacyExecute(Sender: TObject);
    procedure aSaveOrderExecute(Sender: TObject);
    procedure aMainNomSelectItemWithPharmExecute(Sender: TObject);
  private
    { Private declarations }
    SignActive                : boolean;
    SignInit                  : boolean;
    Mode                      : integer;
    Source                    : string;
    IDENT                     : int64;
    RecJSOHeader              : TJSO_OrderHeaderItem;
    RecJSOItem                : TJSO_ItemOrder;
    RecJOPHHeader             : TJOPH_Header;
    RecRemnItemIPA            : TRemnItemIPA;
    RecNetTermItem            : TNetTermItem;
    UserSession               : TUserSession;
    KoefShowSplitMain         : real;
    KoefShowSplitMainNom      : real;
    RecCondMainNomOld         : TCondMainNom;
    RecCondMainNomNew         : TCondMainNom;
    SignGrid                  : integer;
    SortField                 : string;
    SortDirection             : boolean;
    SPharmacy                 : string;
    NPharmacy                 : integer;
    ItemIPASortField          : string;
    ItemIPASortDirection      : boolean;
    TermIPASortField          : string;
    TermIPASortDirection      : boolean;
    SignLinkMaster            : boolean;
    SignLinkMasterSlaveItems  : boolean;
    SimpleText                : string;
    LocateMainNom             : string;
    LocateItemPharmacy        : string;
    AccountMonthSales         : integer;
    SignSelectItem            : boolean;
    RecSelectItem             : TNetNomenclature;
    procedure SetKoefSplitMain;
    procedure SetKoefSplitMainNom;
    procedure ShowResize;
    procedure ExecConditionMainNom;
    procedure CreateConditionMainNom(CurrentArtCode : integer);
    procedure SetClearConditionMainNom;
    procedure SetRecCondMainNomNew;
    procedure SetRecCondMainNomEquallyOldNew;
    procedure SetRecCondMainNomEquallyNewOld;
    procedure ShowCountItemComment(SItemCount : string);
    procedure ReShowPnlLocateMainNom;
    procedure SetSelectItem;
    procedure DefRecRemnItemIPA;
    procedure DefRecNetTermItem;
    function  GetStateConditionMainNom : boolean;
    function  GetRecCondMainNomNotEqually : boolean;
  public
    { Определение входных данных }
    procedure SetMode(Parm : integer);
    procedure SetUserSession(Parm : TUserSession);
    procedure SetSource(Parm : string);
    procedure SetRecJOPHHeader(Parm : TJOPH_Header);
    procedure SetRecJSOHeader(Parm : TJSO_OrderHeaderItem);
    procedure SetRecJSOItem(Parm : TJSO_ItemOrder);
    procedure ShowRemnIPAColumnSales;
    { Обработка в JOPH_DM }
    procedure ShowGets;
    function  GetIDENT : int64;
    function  GetItemIPASignGrid  : integer;
    function  GetItemIPASortField : string;
    function  GetItemIPASortDirection : boolean;
    function  GetItemIPAItemCode : integer;
    function  GetItemIPAItemQuantity : integer;
    function  GetItemIPAOnlyCount : boolean;
    function  GetItemIPAOnlyCountForAllItem : boolean;
    function  GetItemIPAOnlyItemOnAllPharmacy : boolean;
    function  GetItemIPASPharmacy : string;
    function  GetItemIPANPharmacy : integer;
    function  GetItemIPAAccountMonth : smallint;
    function  GetTermIPASortField : string;
    function  GetTermIPASortDirection : boolean;
    function  GetGignTerm : boolean;
    function  SignOnlyCurrentTerm : boolean;
    function  GetPrimaryArtCode : integer;
    function  GetSignSelectItem : boolean;
    function  GetRecSelectItem : TNetNomenclature;
    function  GetRecRemnItemIPA : TRemnItemIPA;
    function  GetRecNetTermItem : TNetTermItem;
  end;

const
  cDefOrderItems_Mode_SelectItem      = 1;
  cDefOrderItems_Mode_DefItems        = 2;
  cDefOrderItems_Mode_NewOrder        = 3;
  cDefOrderItems_Mode_MultiplyOrder   = 4;
  cDefOrderItems_Mode_Remains         = 5;
  cDefOrderItems_Source_911           = 'Apteka911';
  cDefOrderItems_Source_iApteka       = 'iApteka';
  cDefOrderItems_Source_Manual        = 'Ручной';
  cDefOrderItems_Source_TT            = 'TT';
var
  frmCCJO_DefOrderItems: TfrmCCJO_DefOrderItems;

implementation

uses StrUtils,
     {--}
     ExDBGRID, Util, UReference;

{$R *.dfm}

procedure TfrmCCJO_DefOrderItems.FormCreate(Sender: TObject);
begin
  { Инициализация }
  SignActive                 := false;
  Mode                       := 0;
  SignGrid                   := 0;
  Source                     := '';
  KoefShowSplitMain          := 0.5;
  KoefShowSplitMainNom       := 0.5;
  SortField                  := '';
  SortDirection              := false;
  SPharmacy                  := '';
  NPharmacy                  := 0;
  ItemIPASortField           := '';
  ItemIPASortDirection       := false;
  TermIPASortField           := '';
  TermIPASortDirection       := false;
  IDENT                      := 0;
  SetClearConditionMainNom;
  pnlLocateMainNom.Visible   := false;
  pnlLocatemainNom.Parent    := GridMainNom;
  AccountMonthSales          := 2;
  edSlaveCond_ItemCount.Text := '1';
  SignSelectItem             := false;
  SignInit                   := false;
end;

procedure TfrmCCJO_DefOrderItems.FormActivate(Sender: TObject);
var
  SCaption  : string;
  ItemCount : integer;
begin
  if not SignActive then begin
    { Настройка под режим работы }
    case Mode of
      cDefOrderItems_Mode_SelectItem,cDefOrderItems_Mode_Remains : begin
        pmiMainNom_Ok.Action := aMainNomSelectItem;
        tbarMainNom_SelectItem.Visible := true;
        tbarMainNom_DefOrder.Visible := false;
        pnlMainNomTool_Control.Width := tbarMainNom_SelectItem.Width + tbarMainNom.ButtonCount * tbarMainNom.ButtonWidth + 5;
        pnlMainItem.Visible := false;
        SplitMainNom.Enabled := false;
        SplitMainNom.Visible := false;
        pnlMainNom.Align     := alClient;
        get_column_by_fieldname('NArtCode',GridMainNom).Width      := 80;
        get_column_by_fieldname('SNomenclature',GridMainNom).Width := 500;
        aItemIPACond_OnlyCountForAllItem.Enabled := false;
        aItemIPACond_OnlyItemOnAllPharmacy.Enabled := false;
        aSaveOrder.Visible := false;
        if Mode = cDefOrderItems_Mode_Remains then begin
          self.Caption := 'Наличие товара в торговой сети';
          FCCenterJournalNetZkz.imgMain.GetIcon(394,self.Icon);
          pnlOrderHeader.Visible := false;
          pnlControl.Visible     := false;
          tbarMainNom_SelectItem.Visible := false;
          tbarMainNom_DefOrder.Visible := false;
          pnlMainNomTool_Control.Width := tbarMainNom.ButtonCount * tbarMainNom.ButtonWidth + 5;
        end else if Mode = cDefOrderItems_Mode_SelectItem then begin
          self.Caption := 'Подбор товарной позиции';
          pnlControl_Tool.Width := tbtnControl_NetNomSelectItem.Width + tbtnControl_NetNomSlItemWithPharm.Width + tbtnControl_Exis.Width + 10;
          if Source = cDefOrderItems_Source_911 then ItemCount := RecJSOItem.itemQuantity;
          edSlaveCond_ItemCount.Text := IntToStr(ItemCount);
          SignInit := true;
        end;
      end;
      cDefOrderItems_Mode_DefItems,cDefOrderItems_Mode_NewOrder,cDefOrderItems_Mode_MultiplyOrder : begin
        self.Caption := 'Подбор товарных позиций заказа';
        pmiMainNom_Ok.Action := aMainNomToOrder;
        FCCenterJournalNetZkz.imgMain.GetIcon(391,self.Icon);
        aMainNomSelectItem.Visible := false;
        aMainNomSelectItemWithPharm.Visible := false;
        tbarMainNom_SelectItem.Visible := false;
        tbarMainNom_DefOrder.Visible := true;
        pnlMainNomTool_Control.Width := tbarMainNom_DefOrder.Width + tbarMainNom.ButtonCount * tbarMainNom.ButtonWidth + 5;
        pnlControl_Tool.Width := tbtnControl_SaveOrder.Width + tbtnControl_Exis.Width + 10;
      end;
    else
      ShowMessage('Не определен режим работы');
      self.Close;
    end;
    if Source = cDefOrderItems_Source_911 then begin
      { Отображаем реквизиты заказа }
      SCaption := 'Заказ №: ' + RecJSOHeader.SorderID + ' от ' + RecJSOHeader.SOrderDt;
      pnlHZakaz.Caption := SCaption;  pnlHZakaz.Width := TextPixWidth(SCaption, pnlHZakaz.Font) + 10;
      SCaption := ' Сумма: ' + VarToStr(RecJSOHeader.orderAmount);
      pnlHZSum.Caption := SCaption;  pnlHZSum.Width := TextPixWidth(SCaption, pnlHZSum.Font) + 10;
      SCaption := ' Клиент: ' + RecJSOHeader.orderShipName;
      pnlHZHShipName.Caption := SCaption;  pnlHZHShipName.Width := TextPixWidth(SCaption, pnlHZHShipName.Font) + 10;
      SCaption := RecJSOHeader.orderPhone;
      pnlHZHPhone.Caption := SCaption; pnlHZHPhone.Width := TextPixWidth(SCaption, pnlHZHPhone.Font) + 20;
      SCaption := ' Адрес: ' + RecJSOHeader.orderShipStreet;
      pnlHZShipStreet.Caption := SCaption;
    end;
    pnlMainNomTool_CondControl.Width := tbarMainNomTool_Cond.ButtonCount * tbarMainNomTool_Cond.ButtonWidth + 5;
    { При начальной закрываем действия }
    aMainNomToOrder.Enabled             := false;
    aMainNomSelectItem.Enabled          := false;
    aMainNomSelectItemWithPharm.Enabled := false;
    aMainNom_MasterItem.Enabled         := false;
    aMainNom_MasterSlaveItems.Enabled   := false;
    aMainNomCond_Find.Enabled           := false;
    aMainNomCond_Clear.Enabled          := false;
    { Стартовые закладки }
    pgGridSlave.ActivePage := tabGridSlave_IPA;
    { Инициализация строки описания количества выбранных упаковок }
    ShowCountItemComment('');
    { Панели отображения поиска }
    ReShowPnlLocateMainNom;
    { По умолчанию действия по отбору списка аптек отключены }
    aItemIPACond_AllPharmacy.Checked := true;
    { Форма активна }
    SignActive := true;
    if DMJOPH.qrspNetNomenclature.Active then DMJOPH.qrspNetNomenclature.Active := false;
    if DMJOPH.qrspRemnItemIPA.Active then DMJOPH.qrspRemnItemIPA.Active := false;
    if DMJOPH.qrspNetTermItem.Active then DMJOPH.qrspNetTermItem.Active := false;
    GridMainNom.SetFocus;
    ShowGets;
  end;
end;

procedure TfrmCCJO_DefOrderItems.SetKoefSplitMain;
begin
  KoefShowSplitMain := pnlMain.Height / (pnlMain.Height + pnlSlave.Height);
end;

procedure TfrmCCJO_DefOrderItems.SetKoefSplitMainNom;
begin
  KoefShowSplitMainNom := pnlMainNom.Width / (pnlMainNom.Width + pnlMainItem.Width);
end;

procedure TfrmCCJO_DefOrderItems.ShowResize;
begin
  pnlMain.Height := round((pnlMain.Height + pnlSlave.Height) * KoefShowSplitMain);
  pnlMainNom.Width := round((pnlMainNom.Width + pnlMainItem.Width) * KoefShowSplitMainNom);
end;

procedure TfrmCCJO_DefOrderItems.ShowGets;
var
  SCaption      : string;
  SNomenclature : string;
begin
  if SignActive then begin
    if DMJOPH.qrspNetNomenclature.Active then begin
      { Количество записей номенклатуры ТТ}
      SCaption := VarToStr(DMJOPH.qrspNetNomenclature.RecordCount);
      pnlMainNomShow_CountRec.Caption  := SCaption; pnlMainNomShow_CountRec.Width := TextPixWidth(SCaption, pnlMainNomShow_CountRec.Font) + 20;
      (*************************************************************************
       * Доступ к элементам управления в зависисмотси от активного main-грида
       *************************************************************************)
      if SignGrid = cDefOrderItems_GridMainNom then begin
        { Управление доступом при отсутствии данных в представлении <Номенклатура сети ТТ> }
        if not DMJOPH.qrspNetNomenclature.IsEmpty then begin
          aMainNomToOrder.Enabled             := true;
          aMainNomSelectItem.Enabled          := true;
          aMainNomSelectItemWithPharm.Enabled := true;
          aMainNom_MasterItem.Enabled         := true;
          aMainNom_MasterSlaveItems.Enabled   := true;
          { Уточнение доступа к выбору товарной позиции }
          if Mode = cDefOrderItems_Mode_SelectItem then begin
            if (
                   (not ufoTryStrToInt(edSlaveCond_ItemCount.Text))
                or (length(trim(edSlaveCond_ItemCount.Text)) = 0)
               )
            then begin
              aMainNomSelectItem.Enabled          := false;
              aMainNomSelectItemWithPharm.Enabled := false;
            end else begin
              { Дополнительное уточнение доступа для выбора товарной позиции с привязкой к торговой точке }
              if (pgGridSlave.ActivePage = tabGridSlave_IPA) and DMJOPH.qrspRemnItemIPA.Active then begin
                if DMJOPH.qrspRemnItemIPA.IsEmpty then aMainNomSelectItemWithPharm.Enabled := false;
              end else if (pgGridSlave.ActivePage = tabGridSlave_Term) and DMJOPH.qrspNetTermItem.Active then begin
                if DMJOPH.qrspNetTermItem.IsEmpty then aMainNomSelectItemWithPharm.Enabled := false;
              end;
            end;
          end;
          { Строка статуса }
          SNomenclature := GridMainNom.DataSource.DataSet.FieldByName('SNomenclature').AsString;
          SNomenclature := IfThen(length(SNomenclature)<40,SNomenclature,copy(SNomenclature,1,40)+'...');
          SCaption := GridMainNom.DataSource.DataSet.FieldByName('NArtCode').AsString
                      + ' (' + SNomenclature + ')  '
                      + 'Всего: на ТТ - ' + GridMainNom.DataSource.DataSet.FieldByName('NOstatAptek').AsString + ', '
                      + ' на складе - ' + GridMainNom.DataSource.DataSet.FieldByName('NTotalRemnSklad').AsString;
          if GridMainNom.DataSource.DataSet.FieldByName('NMakeFrom').AsInteger > 0 then begin
            SCaption := SCaption + ', Ведущий арткод ' + IntToStr(GetPrimaryArtCode);
          end;
          stBar.Panels[0].Text := SCaption;
          stBar.Refresh;
          if Mode in [cDefOrderItems_Mode_SelectItem,cDefOrderItems_Mode_Remains] then begin
            aItemIPACond_OnlyCountForAllItem.Enabled := false;
            aItemIPACond_OnlyItemOnAllPharmacy.Enabled := false;
          end;
          if pgGridSlave.ActivePage = tabGridSlave_IPA then begin
            aItemIPACond_Sales.Enabled := true;
          end else if pgGridSlave.ActivePage = tabGridSlave_Term then begin
            aItemIPACond_Sales.Enabled := false;
          end;
          ShowCountItemComment(edSlaveCond_ItemCount.Text);
          { Доступ к проверке наличия на торговой точке }
          if pgGridSlave.ActivePage = tabGridSlave_IPA then begin
            if DMJOPH.qrspRemnItemIPA.IsEmpty then aItemIPA_CheckPharmacy.Enabled := false
                                              else aItemIPA_CheckPharmacy.Enabled := true;
          end else if pgGridSlave.ActivePage = tabGridSlave_term then begin
            if DMJOPH.qrspNetTermItem.IsEmpty then aItemIPA_CheckPharmacy.Enabled := false
                                              else aItemIPA_CheckPharmacy.Enabled := true;
          end;
        end else begin { DMJOPH.qrspNetNomenclature.IsEmpty }
          ShowCountItemComment('');
          stBar.Panels[0].Text := '';
          stBar.Refresh;
          aMainNomToOrder.Enabled             := false;
          aMainNomSelectItem.Enabled          := false;
          aMainNomSelectItemWithPharm.Enabled := false;
          aMainNom_MasterItem.Enabled         := false;
          aMainNom_MasterSlaveItems.Enabled   := false;
          aItemIPA_CheckPharmacy.Enabled      := false;
          { Элементы управления поиска остаков на торговых точках }
          tbtnSlaveCondTool_SetListPharm.Enabled := false;
          tbtnSlaveCondTool_Sales.Enabled := false;
        end;
      end else if SignGrid = cDefOrderItems_GridOrder then begin
        {--}
      end;
    end else begin
      { При первом проходе включаем таймер для первоначальной загрузки данных }
      tmrRunTheBoot.Enabled := true;
      SimpleText := 'Загрузка данных...';
    end;
    { Управление доступок к очистке условия отбора номенклатуры сети }
    if GetStateConditionMainNom then aMainNomCond_Clear.Enabled := true
                                else aMainNomCond_Clear.Enabled := false;
    { Управление доступом к действию <Отоборать по условию> для условия отбора номенклатуры сети }
    if GetRecCondMainNomNotEqually then aMainNomCond_Find.Enabled  := true
                                   else aMainNomCond_Find.Enabled  := false;
    { Доступ к полю определения количества товарной позиции }
    if aItemIPACond_AllPharmacy.Checked then begin
      edSlaveCond_ItemCount.Enabled  := false;
      lblSlaveCond_ItemCount.Enabled := false;
    end else begin
      edSlaveCond_ItemCount.Enabled  := true;
      lblSlaveCond_ItemCount.Enabled := true;
    end;
    { Количество строк в подчиненном разделе }
    if (pgGridSlave.ActivePage = tabGridSlave_Term) and (not DMJOPH.qrspNetTermItem.IsEmpty) then begin
      SCaption := VarToStr(DMJOPH.qrspNetTermItem.RecordCount);
      pnlSlaveTool_Show.Caption  := SCaption; pnlSlaveTool_Show.Width := TextPixWidth(SCaption, pnlSlaveTool_Show.Font) + 20;
    end else if (pgGridSlave.ActivePage = tabGridSlave_IPA) and (not DMJOPH.qrspRemnItemIPA.IsEmpty) then begin
      SCaption := VarToStr(DMJOPH.qrspRemnItemIPA.RecordCount);
      pnlSlaveTool_Show.Caption  := SCaption; pnlSlaveTool_Show.Width := TextPixWidth(SCaption, pnlSlaveTool_Show.Font) + 20;
    end;
  end;
end;

procedure TfrmCCJO_DefOrderItems.ExecConditionMainNom;
var
  RN: Integer;
begin
  if not DMJOPH.qrspNetNomenclature.IsEmpty then RN := DMJOPH.qrspNetNomenclature.FieldByName('NArtCode').AsInteger else RN := -1;
  DMJOPH.qrspNetNomenclature.Active := false;
  CreateConditionMainNom(RN);
  DMJOPH.qrspNetNomenclature.Active := true;
  DMJOPH.qrspNetNomenclature.Locate('NArtCode', RN, []);
end;

procedure TfrmCCJO_DefOrderItems.CreateConditionMainNom(CurrentArtCode : integer);
begin
  if length(trim(edMainNomCond_ItemCode.Text)) = 0
    then DMJOPH.qrspNetNomenclature.Parameters.ParamValues['@ArtCode'] := -1
    else DMJOPH.qrspNetNomenclature.Parameters.ParamValues['@ArtCode'] := StrToInt(edMainNomCond_ItemCode.Text);
  if length(trim(edMainNomCond_ItemName.Text)) = 0
    then DMJOPH.qrspNetNomenclature.Parameters.ParamValues['@ArtName'] := ''
    else DMJOPH.qrspNetNomenclature.Parameters.ParamValues['@ArtName'] := edMainNomCond_ItemName.Text;
  if (SignLinkMaster or SignLinkMasterSlaveItems) then begin
    DMJOPH.qrspNetNomenclature.Parameters.ParamValues['@CurrentArtCode']           := CurrentArtCode;
    DMJOPH.qrspNetNomenclature.Parameters.ParamValues['@SignLinkMaster']           := SignLinkMaster;
    DMJOPH.qrspNetNomenclature.Parameters.ParamValues['@SignLinkMasterSlaveItems'] := SignLinkMasterSlaveItems;
  end else begin
    DMJOPH.qrspNetNomenclature.Parameters.ParamValues['@CurrentArtCode']           := -1;
    DMJOPH.qrspNetNomenclature.Parameters.ParamValues['@SignLinkMaster']           := false;
    DMJOPH.qrspNetNomenclature.Parameters.ParamValues['@SignLinkMasterSlaveItems'] := false;
  end;
  DMJOPH.qrspNetNomenclature.Parameters.ParamValues['@OrderBy']   := SortField;
  DMJOPH.qrspNetNomenclature.Parameters.ParamValues['@Direction'] := SortDirection;
end;

procedure TfrmCCJO_DefOrderItems.SetClearConditionMainNom;
begin
  edMainNomCond_ItemCode.Text       := '';
  edMainNomCond_ItemName.Text       := '';
  SignLinkMaster                    := false;
  SignLinkMasterSlaveItems          := false;
  aMainNom_MasterItem.Checked       := SignLinkMaster;
  aMainNom_MasterSlaveItems.Checked := SignLinkMasterSlaveItems;
  {--}
  RecCondMainNomOld.ItemCode                 := edMainNomCond_ItemCode.Text;
  RecCondMainNomOld.ItemName                 := edMainNomCond_ItemName.Text;
  RecCondMainNomOld.SignLinkMaster           := SignLinkMaster;
  RecCondMainNomOld.SignLinkMasterSlaveItems := SignLinkMasterSlaveItems;
  SetRecCondMainNomEquallyNewOld;
end;

procedure TfrmCCJO_DefOrderItems.SetRecCondMainNomNew;
begin
  RecCondMainNomNew.ItemCode                 := edMainNomCond_ItemCode.Text;
  RecCondMainNomNew.ItemName                 := edMainNomCond_ItemName.Text;
  RecCondMainNomNew.SignLinkMaster           := SignLinkMaster;
  RecCondMainNomNew.SignLinkMasterSlaveItems := SignLinkMasterSlaveItems;
end;

procedure TfrmCCJO_DefOrderItems.SetRecCondMainNomEquallyOldNew;
begin
  RecCondMainNomOld.ItemCode                 := RecCondMainNomNew.ItemCode;
  RecCondMainNomOld.ItemName                 := RecCondMainNomNew.ItemName;
  RecCondMainNomOld.SignLinkMaster           := RecCondMainNomNew.SignLinkMaster;
  RecCondMainNomOld.SignLinkMasterSlaveItems := RecCondMainNomNew.SignLinkMasterSlaveItems;
end;

procedure TfrmCCJO_DefOrderItems.SetRecCondMainNomEquallyNewOld;
begin
  RecCondMainNomNew.ItemCode                 := RecCondMainNomOld.ItemCode;
  RecCondMainNomNew.ItemName                 := RecCondMainNomOld.ItemName;
  RecCondMainNomNew.SignLinkMaster           := RecCondMainNomOld.SignLinkMaster;
  RecCondMainNomNew.SignLinkMasterSlaveItems := RecCondMainNomOld.SignLinkMasterSlaveItems;
end;

function  TfrmCCJO_DefOrderItems.GetStateConditionMainNom : boolean;
var
  bResult : boolean;
begin
  bResult := true;
  if     (
             (length(trim(edMainNomCond_ItemCode.Text)) = 0)
          or (not ufoTryStrToInt(edMainNomCond_ItemCode.Text))
         )
     and (length(trim(edMainNomCond_ItemName.Text)) = 0)
     and (not SignLinkMaster)
     and (not SignLinkMasterSlaveItems)
  then bResult := false;
  result := bResult;
end;

function  TfrmCCJO_DefOrderItems.GetRecCondMainNomNotEqually : boolean;
var
  bResult : boolean;
begin
  bResult := true;
  if     (RecCondMainNomOld.ItemCode                 = RecCondMainNomNew.ItemCode)
     and (RecCondMainNomOld.ItemName                 = RecCondMainNomNew.ItemName)
     and (RecCondMainNomOld.SignLinkMaster           = RecCondMainNomNew.SignLinkMaster)
     and (RecCondMainNomOld.SignLinkMasterSlaveItems = RecCondMainNomNew.SignLinkMasterSlaveItems)
  then bResult := false;
  result := bResult;
end;

procedure TfrmCCJO_DefOrderItems.ReShowPnlLocateMainNom;
begin
  pnlLocateMainNom.Width := TextPixWidth(LocateMainNom, pnlLocateMainNom.Font) + 20;
  pnlLocateMainNom.Top := GridMainNom.Height - pnlLocateMainNom.Height - 3;
  pnlLocateMainNom.Left := GridMainNom.Width - pnlLocateMainNom.Width - 20;
end;

procedure TfrmCCJO_DefOrderItems.ShowRemnIPAColumnSales;
begin
  { Управление видимостью атрибута }
  if aItemIPACond_Sales.Checked then begin
    get_column_by_fieldname('NSumKol',GridItemIPA).Visible := true;
    aItemIPACond_Sales.ImageIndex := 356;
  end else begin
    get_column_by_fieldname('NSumKol',GridItemIPA).Visible := false;
    aItemIPACond_Sales.ImageIndex := 358;
  end;
end;

procedure TfrmCCJO_DefOrderItems.SetMode(Parm : integer); begin Mode := Parm; end;
procedure TfrmCCJO_DefOrderItems.SetUserSession(Parm : TUserSession); begin UserSession := Parm; end;
procedure TfrmCCJO_DefOrderItems.SetSource(Parm : string); begin Source := Parm; end;
procedure TfrmCCJO_DefOrderItems.SetRecJSOHeader(Parm : TJSO_OrderHeaderItem); begin RecJSOHeader := Parm; end;
procedure TfrmCCJO_DefOrderItems.SetRecJSOItem(Parm : TJSO_ItemOrder); begin RecJSOItem := Parm; end;
procedure TfrmCCJO_DefOrderItems.SetRecJOPHHeader(Parm : TJOPH_Header); begin RecJOPHHeader := Parm; end;
{--}
function  TfrmCCJO_DefOrderItems.GetItemIPASignGrid : integer; begin result := SignGrid; end;
function  TfrmCCJO_DefOrderItems.GetIDENT : int64; begin result := IDENT; end;
function  TfrmCCJO_DefOrderItems.GetItemIPASortField : string; begin result := ItemIPASortField; end;
function  TfrmCCJO_DefOrderItems.GetItemIPASortDirection : boolean; begin result := ItemIPASortDirection; end;
function  TfrmCCJO_DefOrderItems.GetItemIPAItemCode : integer; begin
  if      SignGrid = cDefOrderItems_GridMainNom then result := GridMainNom.DataSource.DataSet.FieldByName('NArtCode').AsInteger
  else if SignGrid = cDefOrderItems_GridOrder   then result := 0;
end;
function  TfrmCCJO_DefOrderItems.GetItemIPAItemQuantity : integer; begin
  if      SignGrid = cDefOrderItems_GridMainNom then begin
    if (not ufoTryStrToInt(edSlaveCond_ItemCount.Text)) or (length(trim(edSlaveCond_ItemCount.Text)) = 0)
      then result := 0
      else result := StrToInt(edSlaveCond_ItemCount.Text);
  end else if SignGrid = cDefOrderItems_GridOrder   then result := 0;
end;
function  TfrmCCJO_DefOrderItems.GetItemIPAOnlyCount : boolean; begin result := aItemIPACond_OnlyCountSLItem.Checked; end;
function  TfrmCCJO_DefOrderItems.GetItemIPAOnlyCountForAllItem : boolean; begin result := aItemIPACond_OnlyCountForAllItem.Checked; end;
function  TfrmCCJO_DefOrderItems.GetItemIPAOnlyItemOnAllPharmacy : boolean; begin result := aItemIPACond_OnlyItemOnAllPharmacy.Checked; end;
function  TfrmCCJO_DefOrderItems.GetItemIPASPharmacy : string; begin result := SPharmacy; end;
function  TfrmCCJO_DefOrderItems.GetItemIPANPharmacy : integer; begin result := NPharmacy; end;
function  TfrmCCJO_DefOrderItems.GetItemIPAAccountMonth : smallint; begin if aItemIPACond_Sales.Checked then result := AccountMonthSales else result := 0; end;
function  TfrmCCJO_DefOrderItems.GetTermIPASortField : string; begin result := TermIPASortField; end;
function  TfrmCCJO_DefOrderItems.GetTermIPASortDirection : boolean; begin result := TermIPASortDirection; end;
function  TfrmCCJO_DefOrderItems.GetGignTerm : boolean; begin
  if      SignGrid = cDefOrderItems_GridMainNom then result := GridMainNom.DataSource.DataSet.FieldByName('NMakeFrom').AsInteger <> 0
  else if SignGrid = cDefOrderItems_GridOrder   then result := false;
end;
function  TfrmCCJO_DefOrderItems.SignOnlyCurrentTerm : boolean; begin
  if      SignGrid = cDefOrderItems_GridMainNom then result := false
  else if SignGrid = cDefOrderItems_GridOrder   then result := false;
end;
function  TfrmCCJO_DefOrderItems.GetPrimaryArtCode : integer;
var
  PrimaryArtCode : integer;
begin
  PrimaryArtCode := 0;
  if SignGrid = cDefOrderItems_GridMainNom then begin
    if GridMainNom.DataSource.DataSet.FieldByName('NMakeFrom').AsInteger = 0
      then PrimaryArtCode := GetItemIPAItemCode
      else PrimaryArtCode := DMJOPH.GetPrimaryArtCode(GetItemIPAItemCode,UserSession.CurrentUser,0);
  end else if SignGrid = cDefOrderItems_GridOrder   then begin
    PrimaryArtCode := 0;
  end;
  result := PrimaryArtCode;
end;
function TfrmCCJO_DefOrderItems.GetSignSelectItem : boolean; begin result := SignSelectItem; end;
function TfrmCCJO_DefOrderItems.GetRecSelectItem : TNetNomenclature; begin  result := RecSelectItem; end;
function TfrmCCJO_DefOrderItems.GetRecRemnItemIPA : TRemnItemIPA; begin result := RecRemnItemIPA; end;
function TfrmCCJO_DefOrderItems.GetRecNetTermItem : TNetTermItem; begin result := RecNetTermItem; end;

procedure TfrmCCJO_DefOrderItems.ShowCountItemComment(SItemCount : string);
var
  KoefPack  : integer;
  ItemCount : integer;
  SCaption  : string;
  CountPack : integer;
  {--}
  { 28.11.2016 Сейчас по умолчанию везде штуки. Лень делать анализ, если единица измерения задана в упаковках }  
  procedure ShowCaption; begin
    if length(SCaption) = 0 then begin
      edCountItemComment.text := '';
      pnlSlaveTool_CondFields_CountItem.Width := pnlSlaveTool_CondFields_CountItem_Field.Width + 10;
    end else begin
      edCountItemComment.text := SCaption;
      pnlSlaveTool_CondFields_CountItem.Width := pnlSlaveTool_CondFields_CountItem_Field.Width + TextPixWidth(SCaption, edCountItemComment.Font) + 10;
    end;
  end;
  {--}
begin
  SCaption := '';
  if SignGrid = cDefOrderItems_GridMainNom then begin
    KoefPack := GridMainNom.DataSource.DataSet.FieldByName('NKoefUpack').AsInteger;
    if KoefPack > 1 then begin
      ItemCount := StrToInt(SItemCount);
      if ItemCount < KoefPack then begin
        ShowCaption;
      end else begin
        CountPack := floor(ItemCount/KoefPack);
        SCaption := IntToStr(CountPack) + 'упак. ' + IfThen(CountPack*KoefPack <> ItemCount,IntToStr(ItemCount-CountPack*KoefPack)+'шт.','');
        ShowCaption;
      end;
    end else begin
      ShowCaption;
    end;
  end else if SignGrid = cDefOrderItems_GridOrder then begin
    {--}
  end;
end;

procedure TfrmCCJO_DefOrderItems.SetSelectItem;
begin
  RecSelectItem.NArtCode         := GridMainNom.DataSource.DataSet.FieldByName('NArtCode').AsInteger;
  RecSelectItem.SArtCode         := GridMainNom.DataSource.DataSet.FieldByName('SArtCode').AsString;
  RecSelectItem.SNomenclature    := GridMainNom.DataSource.DataSet.FieldByName('SNomenclature').AsString;
  RecSelectItem.SNamesSite       := GridMainNom.DataSource.DataSet.FieldByName('SNamesSite').AsString;
  RecSelectItem.SManufacturer    := GridMainNom.DataSource.DataSet.FieldByName('SManufacturer').AsString;
  RecSelectItem.NKoefUpack       := GridMainNom.DataSource.DataSet.FieldByName('NKoefUpack').AsInteger;
  RecSelectItem.NGrantedInCheck  := GridMainNom.DataSource.DataSet.FieldByName('NGrantedInCheck').AsInteger;
  RecSelectItem.BNoRecipt        := GridMainNom.DataSource.DataSet.FieldByName('BNoRecipt').AsInteger = 1;
  RecSelectItem.BTypeKeep        := GridMainNom.DataSource.DataSet.FieldByName('BTypeKeep').AsInteger = 1;
  RecSelectItem.NMakeFrom        := GridMainNom.DataSource.DataSet.FieldByName('NMakeFrom').AsInteger;
  RecSelectItem.NOstatAptek      := GridMainNom.DataSource.DataSet.FieldByName('NOstatAptek').AsInteger;
  RecSelectItem.NOstatAptekReal  := GridMainNom.DataSource.DataSet.FieldByName('NOstatAptekReal').AsInteger;
  RecSelectItem.NRemnSklad       := GridMainNom.DataSource.DataSet.FieldByName('NRemnSklad').AsInteger;
  RecSelectItem.NTotalRemnSklad  := GridMainNom.DataSource.DataSet.FieldByName('NTotalRemnSklad').AsInteger;
  RecSelectItem.NCenaSite        := GridMainNom.DataSource.DataSet.FieldByName('NCenaSite').AsCurrency;
  RecSelectItem.NCenaIApteka     := GridMainNom.DataSource.DataSet.FieldByName('NCenaIApteka').AsCurrency;
  RecSelectItem.NCenaOpt         := GridMainNom.DataSource.DataSet.FieldByName('NCenaOpt').AsCurrency;
  {--}
  RecSelectItem.ItemCount        := StrToInt(edSlaveCond_ItemCount.Text);
end;

procedure TfrmCCJO_DefOrderItems.DefRecRemnItemIPA; begin
  RecRemnItemIPA.NArtCode      := GridItemIPA.DataSource.DataSet.FieldByName('NArtCode').AsInteger;
  RecRemnItemIPA.NAptekaOstat  := GridItemIPA.DataSource.DataSet.FieldByName('NAptekaOstat').AsInteger;
  RecRemnItemIPA.NAptekaCena   := GridItemIPA.DataSource.DataSet.FieldByName('NAptekaCena').AsCurrency;
  RecRemnItemIPA.SAptekaName   := GridItemIPA.DataSource.DataSet.FieldByName('SAptekaName').AsString;
  RecRemnItemIPA.NAptekaID     := GridItemIPA.DataSource.DataSet.FieldByName('NAptekaID').AsInteger;
  RecRemnItemIPA.SAptekaPhone  := GridItemIPA.DataSource.DataSet.FieldByName('SAptekaPhone').AsString;
  RecRemnItemIPA.SAptekaIP     := GridItemIPA.DataSource.DataSet.FieldByName('SAptekaIP').AsString;
  RecRemnItemIPA.SAptekaAdress := GridItemIPA.DataSource.DataSet.FieldByName('SAptekaAdress').AsString;
  RecRemnItemIPA.DiffMinute    := GridItemIPA.DataSource.DataSet.FieldByName('DiffMinute').AsInteger;
	RecRemnItemIPA.NSumKol       := GridItemIPA.DataSource.DataSet.FieldByName('NSumKol').AsInteger;
end;

procedure TfrmCCJO_DefOrderItems.DefRecNetTermItem; begin
  RecNetTermItem.NArtCode      := GridTermItemIPA.DataSource.DataSet.FieldByName('NArtCode').AsInteger;
  RecNetTermItem.NAptekaOstat  := GridTermItemIPA.DataSource.DataSet.FieldByName('NAptekaOstat').AsInteger;
  RecNetTermItem.NAptekaCena   := GridTermItemIPA.DataSource.DataSet.FieldByName('NAptekaCena').AsCurrency;;
  RecNetTermItem.SAptekaName   := GridTermItemIPA.DataSource.DataSet.FieldByName('SAptekaName').AsString;
  RecNetTermItem.NAptekaID     := GridTermItemIPA.DataSource.DataSet.FieldByName('NAptekaID').AsInteger;
  RecNetTermItem.SAptekaPhone  := GridTermItemIPA.DataSource.DataSet.FieldByName('SAptekaPhone').AsString;
  RecNetTermItem.SAptekaIP     := GridTermItemIPA.DataSource.DataSet.FieldByName('SAptekaIP').AsString;
  RecNetTermItem.SAptekaAdress := GridTermItemIPA.DataSource.DataSet.FieldByName('SAptekaAdress').AsString;
  RecNetTermItem.DiffMinute    := GridTermItemIPA.DataSource.DataSet.FieldByName('DiffMinute').AsInteger;
  RecNetTermItem.NArtCodeTerm  := GridTermItemIPA.DataSource.DataSet.FieldByName('NArtCodeTerm').AsInteger;
  RecNetTermItem.SArtNameTerm  := GridTermItemIPA.DataSource.DataSet.FieldByName('SArtNameTerm').AsString;
  RecNetTermItem.ISignTerm     := GridTermItemIPA.DataSource.DataSet.FieldByName('ISignTerm').AsInteger;
end;

(**************************
 * Обработка событий
 **************************)

procedure TfrmCCJO_DefOrderItems.aExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJO_DefOrderItems.aMainNomCond_FindExecute(Sender: TObject);
begin
  if length(trim(edMainNomCond_ItemCode.Text)) > 0 then begin
    SignLinkMaster                              := false;
    SignLinkMasterSlaveItems                    := false;
    RecCondMainNomNew.SignLinkMaster            := SignLinkMaster;
    RecCondMainNomNew.SignLinkMasterSlaveItems  := SignLinkMasterSlaveItems;
    aMainNom_MasterItem.Checked                 := SignLinkMaster;
    aMainNom_MasterSlaveItems.Checked           := SignLinkMasterSlaveItems;
  end;
  SetRecCondMainNomEquallyOldNew;
  stBar.Panels[0].Text := 'Поиск данных...';
  stBar.Refresh;
  ExecConditionMainNom;
  ShowGets;
end;

procedure TfrmCCJO_DefOrderItems.aMainNomCond_ClearExecute(Sender: TObject);
begin
  SetClearConditionMainNom;
  if not GetStateConditionMainNom then begin
    stBar.Panels[0].Text := 'Загрузка данных...';
    stBar.Refresh;
    ExecConditionMainNom;
    ShowGets;
  end;
end;

procedure TfrmCCJO_DefOrderItems.splitMainMoved(Sender: TObject);
begin
  SetKoefSplitMain;
  ReShowPnlLocateMainNom;
end;

procedure TfrmCCJO_DefOrderItems.FormResize(Sender: TObject);
begin
  ShowResize;
  { Прорисовка дополнительных элементов }
  ReShowPnlLocateMainNom;
end;

procedure TfrmCCJO_DefOrderItems.SplitMainNomMoved(Sender: TObject);
begin
  SetKoefSplitMainNom;
  ReShowPnlLocateMainNom;
end;

procedure TfrmCCJO_DefOrderItems.aMainNomToOrderExecute(Sender: TObject);
begin
//
end;

procedure TfrmCCJO_DefOrderItems.aMainNomSelectItemExecute(Sender: TObject);
begin
  if MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  SetSelectItem;
  RecSelectItem.SignPharm := cDefOrderItems_SelectItem_WithoutPharm;
  SignSelectItem := true;
  Self.Close;
end;

procedure TfrmCCJO_DefOrderItems.aMainNom_MasterItemExecute(Sender: TObject);
begin
  if aMainNom_MasterItem.Checked then begin
    edMainNomCond_ItemCode.Text       := '';
    SignLinkMaster                    := true;
    SignLinkMasterSlaveItems          := false;
    aMainNom_MasterSlaveItems.Checked := SignLinkMasterSlaveItems;
  end else begin
    SignLinkMaster := false;
  end;
  SetRecCondMainNomNew;
  SetRecCondMainNomEquallyOldNew;
  SimpleText := 'Поиск данных...';
  tmrRunTheBoot.Enabled := true;
end;

procedure TfrmCCJO_DefOrderItems.aMainNom_MasterSlaveItemsExecute(Sender: TObject);
begin
  if aMainNom_MasterSlaveItems.Checked then begin
    edMainNomCond_ItemCode.Text := '';
    SignLinkMasterSlaveItems    := true;
    SignLinkMaster              := false;
    aMainNom_MasterItem.Checked := SignLinkMaster;
  end else begin
    SignLinkMasterSlaveItems := false;
  end;
  SetRecCondMainNomNew;
  SetRecCondMainNomEquallyOldNew;
  SimpleText := 'Поиск данных...';
  tmrRunTheBoot.Enabled := true;
end;

procedure TfrmCCJO_DefOrderItems.GridMainNomDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  if not (gdSelected in State) then begin
    { Сроковые позиции }
    if db.DataSource.DataSet.FieldByName('NMakeFrom').AsInteger > 0 then begin
      if Column.FieldName = 'NArtCode' then begin
        db.Canvas.Brush.Color := TColor($80FFFF); { светло-желтый }
        db.Canvas.Font.Color  := TColor(clWindowText);
      end;
    end;
    { Нулевые остатки на складе или в сети }
    if (Column.FieldName = 'NOstatAptek') and (db.DataSource.DataSet.FieldByName('NOstatAptek').AsInteger = 0) then begin
      db.Canvas.Brush.Color := TColor($B3B3FF); { светло-красный }
      db.Canvas.Font.Color  := TColor(clWhite);
    end;
    if (Column.FieldName = 'NRemnSklad') and (db.DataSource.DataSet.FieldByName('NRemnSklad').AsInteger = 0) then begin
      db.Canvas.Brush.Color := TColor($B3B3FF); { светло-красный }
      db.Canvas.Font.Color  := TColor(clWhite);
    end;
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCCJO_DefOrderItems.GridMainNomTitleClick(Column: TColumn);
var
  iCkl : integer;
begin
  if    (Column.FieldName = 'NArtCode')
     or (Column.FieldName = 'SNomenclature') then begin
    stBar.Panels[0].Text := 'Сортировка по ' +  IfThen(Column.FieldName = 'NArtCode', 'арткоду',
                                                       IfThen(Column.FieldName = 'SNomenclature','наименованию','')
                                                      ) + '...';
    stBar.Refresh;
    if Column.Title.Font.Color = clWindowText then begin
      { Восстанавливаем прорисовку по умолчанию }
      for iCkl := 0 to GridMainNom.Columns.count - 1 do begin
        if GridMainNom.Columns[iCkl].Title.Font.Color <> clWindowText then begin
          GridMainNom.Columns[iCkl].Title.Font.Color := clWindowText;
          GridMainNom.Columns[iCkl].Title.Font.Style := [];
          GridMainNom.Columns[iCkl].Title.Caption := copy(GridMainNom.Columns[iCkl].Title.Caption,2,length(GridMainNom.Columns[iCkl].Title.Caption)-1);
        end;
      end;
      { Для выбранного столбца включаем сортировку по возрастанию }
      Column.Title.Font.Color := clBlue;
      Column.Title.Font.Style := [fsBold];
      Column.Title.Caption := chr(24)+Column.Title.Caption;
      SortField := Column.FieldName;
      SortDirection := false;
      ExecConditionMainNom;
    end
    else if Column.Title.Font.Color = clBlue then begin
      { Для выбранного столбца переключаем на сортировку по убыванию }
      Column.Title.Font.Color := clFuchsia;
      Column.Title.Font.Style := [fsBold];
      Column.Title.Caption := '!'+copy(Column.Title.Caption,2,length(Column.Title.Caption)-1);
      SortField := Column.FieldName;
      SortDirection := true;
      ExecConditionMainNom;
    end
    else if Column.Title.Font.Color = clFuchsia then begin
      { Для выбранного столбца переключаем на сортировку по возрастанию }
      Column.Title.Font.Color := clBlue;
      Column.Title.Font.Style := [fsBold];
      Column.Title.Caption := chr(24)+copy(Column.Title.Caption,2,length(Column.Title.Caption)-1);
      SortField := Column.FieldName;
      SortDirection := false;
      ExecConditionMainNom;
    end;
  end;
  ShowGets;
end;

procedure TfrmCCJO_DefOrderItems.tmrRunTheBootTimer(Sender: TObject);
begin
  stBar.Panels[0].Text := SimpleText;
  stBar.Refresh;
  ExecConditionMainNom;
  tmrRunTheBoot.Enabled := false;
  if SignInit then begin
    SignInit := not SignInit;
    if Source = cDefOrderItems_Source_911 then DMJOPH.qrspNetNomenclature.Locate('NArtCode', RecJSOItem.itemCode, []);
  end;
  ShowGets;
end;

procedure TfrmCCJO_DefOrderItems.aMaimNom_CondChangeExecute(Sender: TObject);
begin
  SetRecCondMainNomNew;
  if (Sender as TEdit).Name = 'edMainNomCond_ItemCode' then begin
    (Sender as TEdit).Font.Color := clWindowText;
    if not ufoTryStrToInt((Sender as TEdit).Text) then (Sender as TEdit).Font.Color := clRed;
  end;
  ShowGets;
end;

procedure TfrmCCJO_DefOrderItems.GridMainNomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key in [27,37,38,39,40,13] then begin
    LocateMainNom := '';
    pnlLocateMainNom.Visible := false;
  end;
end;

procedure TfrmCCJO_DefOrderItems.GridMainNomKeyPress(Sender: TObject; var Key: Char);
var
  S : String;
begin
  S := AnsiUpperCase(LocateMainNom + Key);
  if GridMainNom.DataSource.DataSet.Locate('SArtCode',AnsiLowerCase(S),[loCaseInsensitive,loPartialKey]) then begin
    LocateMainNom := S;
    pnlLocateMainNom.Visible := true;
    pnlLocateMainNom.Caption := LocateMainNom;
    ReShowPnlLocateMainNom;
  end;
end;

procedure TfrmCCJO_DefOrderItems.GridItemIPADrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db         : TDBGrid;
  DiffMinute : integer;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  if not (gdSelected in State) then begin
    if Column.FieldName = 'DiffMinute' then begin
      DiffMinute := Column.Field.AsInteger;
      if DiffMinute <= 3 then begin
        db.Canvas.Brush.Color := TColor(clLime);
      end else
      if (DiffMinute > 3) and ((DiffMinute <= 5)) then begin
        db.Canvas.Brush.Color := TColor(clYellow);
      end else
      if (DiffMinute > 5) and ((DiffMinute <= 10)) then begin
        db.Canvas.Brush.Color := TColor($AAD2FF);
      end else
      if (DiffMinute > 10) then begin
        db.Canvas.Brush.Color := TColor(clRed);
        db.Canvas.Font.Color := TColor(clWhite);
      end;
    end;
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCCJO_DefOrderItems.GridItemIPATitleClick(Column: TColumn);
var
  iCkl : integer;
begin
  { Контроль на разрешенные поля сортировки }
  if    (Column.FieldName = 'NArtCode')
     or (Column.FieldName = 'NAptekaOstat')
     or (Column.FieldName = 'NAptekaCena')
     or (Column.FieldName = 'NSumKol')
     or (Column.FieldName = 'SAptekaName')  then begin
    { Собственно управление сортировкой }
    if Column.Title.Font.Color = clWindowText then begin
      { Восстанавливаем прорисовку по умолчанию }
      for iCkl := 0 to GridItemIPA.Columns.count - 1 do begin
        if GridItemIPA.Columns[iCkl].Title.Font.Color <> clWindowText then begin
          GridItemIPA.Columns[iCkl].Title.Font.Color := clWindowText;
          GridItemIPA.Columns[iCkl].Title.Font.Style := [];
          GridItemIPA.Columns[iCkl].Title.Caption := copy(GridItemIPA.Columns[iCkl].Title.Caption,2,length(GridItemIPA.Columns[iCkl].Title.Caption)-1);
        end;
      end;
      { Для выбранного столбца включаем сортировку по возрастанию }
      Column.Title.Font.Color := clBlue;
      Column.Title.Font.Style := [fsBold];
      Column.Title.Caption := chr(24)+Column.Title.Caption;
      ItemIPASortField := Column.FieldName;
      ItemIPASortDirection := false;
      DMJOPH.ExecConditionRemnItemIPA(
                                      GetItemIPASignGrid,
                                      GetItemIPASortField,
                                      GetItemIPASortDirection,
                                      GetIDENT,
                                      GetItemIPAItemCode,
                                      GetItemIPAItemQuantity,
                                      GetItemIPAOnlyCount,
                                      GetItemIPAOnlyCountForAllItem,
                                      GetItemIPAOnlyItemOnAllPharmacy,
                                      GetItemIPASPharmacy,
                                      GetItemIPANPharmacy,
                                      GetItemIPAAccountMonth
                                     );
    end else if Column.Title.Font.Color = clBlue then begin
      { Для выбранного столбца переключаем на сортировку по убыванию }
      Column.Title.Font.Color := clFuchsia;
      Column.Title.Font.Style := [fsBold];
      Column.Title.Caption := '!'+copy(Column.Title.Caption,2,length(Column.Title.Caption)-1);
      ItemIPASortField := Column.FieldName;
      ItemIPASortDirection := true;
      DMJOPH.ExecConditionRemnItemIPA(
                                      GetItemIPASignGrid,
                                      GetItemIPASortField,
                                      GetItemIPASortDirection,
                                      GetIDENT,
                                      GetItemIPAItemCode,
                                      GetItemIPAItemQuantity,
                                      GetItemIPAOnlyCount,
                                      GetItemIPAOnlyCountForAllItem,
                                      GetItemIPAOnlyItemOnAllPharmacy,
                                      GetItemIPASPharmacy,
                                      GetItemIPANPharmacy,
                                      GetItemIPAAccountMonth
                                     );
    end else if Column.Title.Font.Color = clFuchsia then begin
      { Для выбранного столбца переключаем на сортировку по возрастанию }
      Column.Title.Font.Color := clBlue;
      Column.Title.Font.Style := [fsBold];
      Column.Title.Caption := chr(24)+copy(Column.Title.Caption,2,length(Column.Title.Caption)-1);
      ItemIPASortField := Column.FieldName;
      ItemIPASortDirection := false;
      DMJOPH.ExecConditionRemnItemIPA(
                                      GetItemIPASignGrid,
                                      GetItemIPASortField,
                                      GetItemIPASortDirection,
                                      GetIDENT,
                                      GetItemIPAItemCode,
                                      GetItemIPAItemQuantity,
                                      GetItemIPAOnlyCount,
                                      GetItemIPAOnlyCountForAllItem,
                                      GetItemIPAOnlyItemOnAllPharmacy,
                                      GetItemIPASPharmacy,
                                      GetItemIPANPharmacy,
                                      GetItemIPAAccountMonth
                                     );
    end;
  end;
end;

procedure TfrmCCJO_DefOrderItems.GridMainNomEnter(Sender: TObject);
begin
  SignGrid := cDefOrderItems_GridMainNom;
  ShowGets;
end;

procedure TfrmCCJO_DefOrderItems.GridTermItemIPADrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db         : TDBGrid;
  DiffMinute : integer;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  if not (gdSelected in State) then begin
    if Column.FieldName = 'DiffMinute' then begin
      DiffMinute := Column.Field.AsInteger;
      if DiffMinute <= 3 then begin
        db.Canvas.Brush.Color := TColor(clLime);
      end else
      if (DiffMinute > 3) and ((DiffMinute <= 5)) then begin
        db.Canvas.Brush.Color := TColor(clYellow);
      end else
      if (DiffMinute > 5) and ((DiffMinute <= 10)) then begin
        db.Canvas.Brush.Color := TColor($AAD2FF);
      end else
      if (DiffMinute > 10) then begin
        db.Canvas.Brush.Color := TColor(clRed);
        db.Canvas.Font.Color := TColor(clWhite);
      end;
    end;
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCCJO_DefOrderItems.GridTermItemIPATitleClick(Column: TColumn);
var
  iCkl : integer;
begin
  { Контроль на разрешенные поля сортировки }
  if    (Column.FieldName = 'SAptekaName')
     or (Column.FieldName = 'NArtCodeTerm')
     or (Column.FieldName = 'SArtNameTerm')
     or (Column.FieldName = 'NAptekaOstat')
     or (Column.FieldName = 'NAptekaCena') then begin
    { Собственно управление сортировкой }
    if Column.Title.Font.Color = clWindowText then begin
      { Восстанавливаем прорисовку по умолчанию }
      for iCkl := 0 to GridTermItemIPA.Columns.count - 1 do begin
        if GridTermItemIPA.Columns[iCkl].Title.Font.Color <> clWindowText then begin
          GridTermItemIPA.Columns[iCkl].Title.Font.Color := clWindowText;
          GridTermItemIPA.Columns[iCkl].Title.Font.Style := [];
          GridTermItemIPA.Columns[iCkl].Title.Caption := copy(GridTermItemIPA.Columns[iCkl].Title.Caption,2,length(GridTermItemIPA.Columns[iCkl].Title.Caption)-1);
        end;
      end;
      { Для выбранного столбца включаем сортировку по возрастанию }
      Column.Title.Font.Color := clBlue;
      Column.Title.Font.Style := [fsBold];
      Column.Title.Caption := chr(24)+Column.Title.Caption;
      TermIPASortField := Column.FieldName;
      TermIPASortDirection := false;
      DMJOPH.ExecConditionNetTermItem(
                                      GetItemIPASignGrid,
                                      GetTermIPASortField,
                                      GetTermIPASortDirection,
                                      GetItemIPAItemCode,
                                      GetPrimaryArtCode,
                                      GetItemIPAItemQuantity,
                                      GetItemIPAOnlyCount,
                                      GetItemIPASPharmacy,
                                      GetItemIPANPharmacy,
                                      GetGignTerm,
                                      SignOnlyCurrentTerm
                                     );
    end else if Column.Title.Font.Color = clBlue then begin
      { Для выбранного столбца переключаем на сортировку по убыванию }
      Column.Title.Font.Color := clFuchsia;
      Column.Title.Font.Style := [fsBold];
      Column.Title.Caption := '!'+copy(Column.Title.Caption,2,length(Column.Title.Caption)-1);
      TermIPASortField := Column.FieldName;
      TermIPASortDirection := true;
      DMJOPH.ExecConditionNetTermItem(
                                      GetItemIPASignGrid,
                                      GetTermIPASortField,
                                      GetTermIPASortDirection,
                                      GetItemIPAItemCode,
                                      GetPrimaryArtCode,
                                      GetItemIPAItemQuantity,
                                      GetItemIPAOnlyCount,
                                      GetItemIPASPharmacy,
                                      GetItemIPANPharmacy,
                                      GetGignTerm,
                                      SignOnlyCurrentTerm
                                     );
    end else if Column.Title.Font.Color = clFuchsia then begin
      { Для выбранного столбца переключаем на сортировку по возрастанию }
      Column.Title.Font.Color := clBlue;
      Column.Title.Font.Style := [fsBold];
      Column.Title.Caption := chr(24)+copy(Column.Title.Caption,2,length(Column.Title.Caption)-1);
      TermIPASortField := Column.FieldName;
      TermIPASortDirection := false;
      DMJOPH.ExecConditionNetTermItem(
                                      GetItemIPASignGrid,
                                      GetTermIPASortField,
                                      GetTermIPASortDirection,
                                      GetItemIPAItemCode,
                                      GetPrimaryArtCode,
                                      GetItemIPAItemQuantity,
                                      GetItemIPAOnlyCount,
                                      GetItemIPASPharmacy,
                                      GetItemIPANPharmacy,
                                      GetGignTerm,
                                      SignOnlyCurrentTerm
                                     );
    end;
  end;
end;

procedure TfrmCCJO_DefOrderItems.pgGridSlaveChange(Sender: TObject);
begin
  FCCenterJournalNetZkz.UserActive;
  if pgGridSlave.ActivePage = tabGridSlave_IPA then begin
    DMJOPH.ExecConditionRemnItemIPA(
                                    GetItemIPASignGrid,
                                    GetItemIPASortField,
                                    GetItemIPASortDirection,
                                    GetIDENT,
                                    GetItemIPAItemCode,
                                    GetItemIPAItemQuantity,
                                    GetItemIPAOnlyCount,
                                    GetItemIPAOnlyCountForAllItem,
                                    GetItemIPAOnlyItemOnAllPharmacy,
                                    GetItemIPASPharmacy,
                                    GetItemIPANPharmacy,
                                    GetItemIPAAccountMonth
                                   );
    GridItemIPA.SetFocus;
  end else
  if pgGridSlave.ActivePage = tabGridSlave_Term then begin
    if length(GetTermIPASortField) = 0 then begin
      { Первичная инициализация через определени сортировки по умолчанию }
      GridTermItemIPA.OnTitleClick(get_column_by_fieldname('SAptekaName',GridTermItemIPA));
    end else begin
      DMJOPH.ExecConditionNetTermItem(
                                      GetItemIPASignGrid,
                                      GetTermIPASortField,
                                      GetTermIPASortDirection,
                                      GetItemIPAItemCode,
                                      GetPrimaryArtCode,
                                      GetItemIPAItemQuantity,
                                      GetItemIPAOnlyCount,
                                      GetItemIPASPharmacy,
                                      GetItemIPANPharmacy,
                                      GetGignTerm,
                                      SignOnlyCurrentTerm
                                     );
    end;
    GridTermItemIPA.SetFocus;
  end;
  ShowGets;
end;

procedure TfrmCCJO_DefOrderItems.aItemIPACond_SetListPharmExecute(Sender: TObject);
begin
  { Заглушка }
end;

procedure TfrmCCJO_DefOrderItems.aItemIPACondExecute(Sender: TObject);
begin
  if Sender is TEdit then begin
    if (Sender as TEdit).Name = 'edSlaveCond_ItemCount' then begin
      if (not ufoTryStrToInt((Sender as TEdit).Text)) or (length(trim((Sender as TEdit).Text)) = 0) then begin
        (Sender as TEdit).Font.Color := clRed;
      end else begin
        (Sender as TEdit).Font.Color := clWindowText;
      end;
    end;
  end;
  SPharmacy := edSlaveCond_Pharmacy.Text;
  if pgGridSlave.ActivePage.Name = 'tabGridSlave_IPA' then begin
    { Получаем список аптек }
    DMJOPH.ExecConditionRemnItemIPA(
                                    GetItemIPASignGrid,
                                    GetItemIPASortField,
                                    GetItemIPASortDirection,
                                    GetIDENT,
                                    GetItemIPAItemCode,
                                    GetItemIPAItemQuantity,
                                    GetItemIPAOnlyCount,
                                    GetItemIPAOnlyCountForAllItem,
                                    GetItemIPAOnlyItemOnAllPharmacy,
                                    GetItemIPASPharmacy,
                                    GetItemIPANPharmacy,
                                    GetItemIPAAccountMonth
                                   );
    ShowRemnIPAColumnSales;
  end else if pgGridSlave.ActivePage.Name = 'tabGridSlave_Term' then begin
    DMJOPH.ExecConditionNetTermItem(
                                    GetItemIPASignGrid,
                                    GetTermIPASortField,
                                    GetTermIPASortDirection,
                                    GetItemIPAItemCode,
                                    GetPrimaryArtCode,
                                    GetItemIPAItemQuantity,
                                    GetItemIPAOnlyCount,
                                    GetItemIPASPharmacy,
                                    GetItemIPANPharmacy,
                                    GetGignTerm,
                                    SignOnlyCurrentTerm
                                   );
  end;
  ShowGets;
(*
  { Отработка поиска по аптеке }
  if pnlLocate.Visible then
    DBGridItemIPA.DataSource.DataSet.Locate('SAptekaName',AnsiLowerCase(LocatePharmacy),[loCaseInsensitive,loPartialKey]);
*)
end;

procedure TfrmCCJO_DefOrderItems.aItemIPACond_ClearExecute(Sender: TObject);
begin
  aItemIPACond_AllPharmacy.Checked := true;
  NPharmacy := 0;
  SPharmacy := '';
  edSlaveCond_Pharmacy.Text := '';
  edSlaveCond_ItemCount.Text := '1';
  aItemIPACond_Sales.Checked := false;
end;

procedure TfrmCCJO_DefOrderItems.edSlaveCond_PharmacyKeyPress(Sender: TObject; var Key: Char);
begin
  NPharmacy := 0;
end;

procedure TfrmCCJO_DefOrderItems.aItemIPACond_SlReferenceExecute(Sender: TObject);
var
  RefIndex    : integer;
  SignLargeDS : smallint;
  Tag         : integer;
  ScreenPos   : TPoint;   { вычисляемый правый нижний угол окна справочника }
  DescrSelect : string;
  RNSelect    : integer;
begin
  FCCenterJournalNetZkz.UserActive;
  DescrSelect := '';
  RNSelect    := 0;
  Tag         := 0;
  RefIndex    := 0;
  SignLargeDS := cFReferenceSignSmallDS;
  if      Sender is TAction then Tag := (Sender as TAction).ActionComponent.Tag
  else if Sender is TEdit   then Tag := (Sender as TEdit).Tag;
  case Tag of
    15: begin
          RefIndex := cFReferencePharmacy;
          ScreenPos := Point(edSlaveCond_Pharmacy.ClientOrigin.X + edSlaveCond_Pharmacy.Width, edSlaveCond_Pharmacy.ClientOrigin.Y + edSlaveCond_Pharmacy.Height);
    end;
  end;
  ScreenPos := Point(ScreenPos.X-5,ScreenPos.Y-5);
  try
    frmReference := TfrmReference.Create(Self);
    frmReference.SetMode(cFReferenceModeSelect);
    frmReference.SetReferenceIndex(RefIndex);
    frmReference.SetReadOnly(cFReferenceYesReadOnly);
    frmReference.SetSignLargeDataSet(SignLargeDS);
    //frmReference.SetScreenPos(ScreenPos);
    try
      frmReference.ShowModal;
      DescrSelect := frmReference.GetDescrSelect;
      RNSelect    := frmReference.GetRowIDSelect;
    finally
      FreeAndNil(frmReference);
    end;
  except
  end;
  if length(DescrSelect) > 0 then begin
    case Tag of
      15: begin
        NPharmacy := RNSelect;
        SPharmacy := DescrSelect;
        edSlaveCond_Pharmacy.Text := SPharmacy;
      end;
    end;
  end;
end;

procedure TfrmCCJO_DefOrderItems.aItemIPA_CheckPharmacyExecute(Sender: TObject);
begin
  stBar.Panels[0].Text := 'Проверка количества остатков в резерве...';
  stBar.Refresh;
  if SignGrid = cDefOrderItems_GridMainNom then
  begin
    if pgGridSlave.ActivePage = tabGridSlave_IPA then
    begin
      dmJSO.ShowGoodsPharmState(GridMainNom.DataSource.DataSet.FieldByName('NArtCode').AsInteger,
        GridItemIPA.DataSource.DataSet.FieldByName('NAptekaID').AsInteger,
       'Наличие <' + GridMainNom.DataSource.DataSet.FieldByName('SNomenclature').AsString + '> в аптеке <' + GridItemIPA.DataSource.DataSet.FieldByName('SAptekaName').AsString + '>'
      );
    end
    else
    if pgGridSlave.ActivePage = tabGridSlave_term then
    begin
      dmJSO.ShowGoodsPharmState(GridTermItemIPA.DataSource.DataSet.FieldByName('NArtCodeTerm').AsInteger,
        GridTermItemIPA.DataSource.DataSet.FieldByName('NAptekaID').AsInteger,
       'Наличие <' + GridTermItemIPA.DataSource.DataSet.FieldByName('SNomenclature').AsString + '> в аптеке <' + GridTermItemIPA.DataSource.DataSet.FieldByName('SAptekaName').AsString + '>'
      );
    end;
  end
  else
  if SignGrid = cDefOrderItems_GridOrder then
  begin
  end;
  ShowGets;
end;

procedure TfrmCCJO_DefOrderItems.aSaveOrderExecute(Sender: TObject);
begin
//
end;

procedure TfrmCCJO_DefOrderItems.aMainNomSelectItemWithPharmExecute(Sender: TObject);
begin
  if MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  SetSelectItem;
  if pgGridSlave.ActivePage = tabGridSlave_IPA then begin
    RecSelectItem.SignPharm := cDefOrderItems_SelectItem_WithPharmItem;
    DefRecRemnItemIPA;
  end else if pgGridSlave.ActivePage = tabGridSlave_Term then begin
    RecSelectItem.SignPharm := cDefOrderItems_SelectItem_WithPharmTerm;
    DefRecNetTermItem;
  end;
  SignSelectItem := true;
  Self.Close;
end;

end.
