unit UCCenterJournalNetZkz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, Grids, DBGrids, StdCtrls, Buttons, DB, ADODB,
  Menus, ToolWin, ImgList, ActnList, ComObj, Excel97, IdBaseComponent,
  IdComponent, IdIPWatch, AppEvnts, dbcgrids, UtilsBase,
  {---}
  uSprGridFrm, uSprQuery, DBCtrls, uPayTransStatusGrid, uBPSpecRef, Sockets,
  uAlertCore, EQDBxlExport, uDMJSO, WinSock;

const
  {
   16-02-2016 18:00:00, 10-03-2016 16:00:00, 12-03-2016 15:00:00, 25-03-2016 17:00:00, 29-03-2016 16:00:00, 11-04-2016 09:00:00, 05-05-2016 13:00:00, 18-05-2016 16:00:00
   26-05-2016 16:00:00, 01-07-2016 10:00:00, 01-07-2016 17:00:00, 15-07-2016 15:00:00, 19-08-2016 16:00:00, 26-08-2016 18:00:00, 01-09-2016 16:00:00, 08-09-2016 18:00:00
   21-09-2016 18:00:00, 23-09-2016 18:00:00, 26-09-2016 10:30:00, 13-10-2016 11:00:00
  }
  cJSOCurrentVertion = '09-12-2016 16:00:00';
type
  TMainFilterState = (mfsOrderId, mfsCond, mfsNone, mfsArtCode);

  { Управление боковой панелью }
  type TControlPanelSide = record
    ISignOldActivePnlSide : boolean;
    ISignActiveNtfCenter  : byte;
    ISIgnActiveOrdPlan    : byte;
    ControlMouseEnter     : TControl;
    ControlMouseLeave     : TControl;
    TagEnter              : integer;
    TagLeave              : integer;
  end;

  { Пользовательская сессия }
  type TUserSession = record
    RN              : longint;
    IDENT           : longint;
    LocalIP         : string;
    ComputerNetName : string;
    UserFromWindows : string;
    CurrentUser     : integer;
    CurrentNameUser : string;
  end;

  { Пользовательские действия }
  type TRegAction = record
    State       : integer;
    RN          : integer;
    ActionCode  : string;
    PRN         : integer;
    NUSER       : integer;
    SUSER       : string;
    BeginDate   : TDateTime;
    SBeginDate  : string;
    EndDate     : TDateTime;
    SEndDate    : string;
    Order       : integer;
    Bell        : integer;
    Note        : string;
  end;

  { Заголовок заказа - за основу берем представление v_CallCenter_Journal_Site}
  type TJSO_OrderHeaderItem = record
    orderID              : integer;
    SorderID             : string;
    SSignBell            : string;   { Да - '' }
    orderAmount          : currency; { Сумма заказа }
    NOrderAmountShipping : currency; { + Сумма }
    NOrderAmountCOD      : currency; { Наложенный платеж }
    NCoolantSum          : currency; { Хладоген сумма }
    orderCurrency        : string;   { Валюта }
    orderShipping        : string;   { Вид доставки }
    orderPayment         : string;   { Вид оплаты }
    orderEmail           : string;   {  }
    orderPhone           : string;
    MPhone               : string;
    orderShipName        : string;
    orderShipStreet      : string;
    SOrderDt             : string;
    aptekaID             : string;
    ID_IPA_DhRes         : string;
    IStateArmour         : integer;  { f_jso_GetNameStateArmor - 0 - Не забронировано, 1 - Забронировано, 2 - Частично забронировано }
    SCreateDate          : string;
    Apteka               : string;
    NUser                : integer;
    SUser                : string;
    SBellDate            : string;   { маркер времени звонка }
    SSMSDate             : string;   { маркер времени СМС }
    SPayDate             : string;   { маркер времни платежа }
    SAssemblingDate      : string;   { маркер времени сборки }
    DAssemblingDate      : TDatetime;
    SDispatchDeclaration : string;   { № декларации - отправка }
    SDeclarationReturn   : string;   { № декларации - возврат }
    SNote                : string;   { примечание курьер }
    SCloseDate           : string;
    IStateConnection     : integer;  { 2 - нет связи с аптекой - фиксируется при резервировании }
    SOrderStatus         : string;   { дата + статус }
    SOrderComment        : string;   { Примечание (клиент) }
    SExport1CDate        : string;
    ISignNew             : integer;  { Признак нового заказа 0 - сброшено (заказ не требует ручной обработки), 1 - новый заказа, 2 - заказ обработан }
    SStatusName          : string;   { Наименование статуса заказа }
    NGeoGroupPharm       : integer;
    SGroupPharmName      : string;
    NMarkRN              : integer;  { ссылка t_jso_MyOrder }
    SMarkDate            : string;
    NMarkUser            : integer;
    SMarkUser            : string;
    SOrderShipCity       : string;   { город }
    SOrderStatusDate     : string;
    SNameDriver          : string;   { Водитель }
    SDriverDate          : string;   { Дата определения водителя }
    SNPOST_StateName     : string;
    SNPOST_StateDate     : string;
    NParentOrderID       : integer;
    SBlackListDate       : string;
    SStockDateBegin      : string;
    SPharmAssemblyDate   : string;
    NPharmAssemblyUser   : integer;
    orderName            : string;
    SrcSystemName        : string;
    SrcSysPrefix         : string;
    ExtSysPrefix         : string;
    ExecSign             : integer;
  end;

  { Товарные позиции заказа }
  type TJSO_ItemOrder = record
    itemID               : integer;
    orderID	             : integer;
    itemCode	           : integer;
    itemName	           : string;
    itemQuantity	       : integer;
    itemPrice	           : real;
    SArmourDate	         : string;
    aptekaID	           : integer;
    SPharmacy            : string;
    ID_IPA_DhRes	       : integer;
    ID_IPA_DtRes	       : integer;
    SArmourDateClose	   : string;
    SCheckDate	         : string;
    itemCountInPresence	 : real;
    TypeNote	           : smallint;
    SCheckNote           : string;
    PricePharmacy	       : real;
    Koef_Opt	           : integer;
    CalcPriceWithKoef    : real;
    NUSER	               : integer;
    SUSER                : string;
    SignDistribute       : smallint;
    SignArmorTerm	       : smallint;
    SignDivideParts      : smallint;
    itemRemnTerm	       : integer;
    StateArmour	         : integer;
    SignMeas	           : integer;
    SNameMeas            : string;
    SignModeReserve	     : smallint;
    ID_IPA_JMoves	       : integer;
    ID_IPA_rTovar	       : integer;
    STypeTable           : string;
  end;

  { Платеж по интернет заказу }
  type TJSO_Pay = record
    TypeUnion       : string;
    RN              : integer;    { PRIMARY KEY записи для исправления }
    Order           : integer;    { Номер заказа }
    Document93      : integer;    { = 0, binary(16), Ссылка на s2014.gamma_83n.dbo._Document93 }
    DocNumb         : string;     { Номер документа }
    DocSumPay       : Currency;   { Сумма по документу }
    BarCode         : string;     { Штрих-код }
    DocDate         : TDateTime;  { Дата документа }
    SDocDate        : string;
    DocNote         : string;     { Назначение }
    CreateDate      : string;     { Дата создания (обновления) }
    DRedeliveryDate : TDateTime;  { Дата получения }
    SRedeliveryDate : string;     { Дата получения }
  end;

  { Товарная позиция журнала редких лекарств }
  type TJRMO_Item = record
    RN         : integer;       { PRIMARY KEY записи для исправления }
    PRN        : integer;       { Ссылка на родительскую таблицу - заголовок заказа }
    ArtCode    : integer;
    ArtName    : string;
    Quantity   : integer;       { Количество }
    Cena       : Currency;
    CreateDate : string;        { Дата создания (обновления) }
  end;

  { Условия отбора - журнал интернет заказов }
  type TJSO_Condition = record
    USER                         : integer;
    { Order Header }
    SignOrderPeriod              : smallint;   { ext - вид контрольного периода интернет заказа }
    BeginDate                    : TDateTime;
    EndDate                      : TDateTime;
    BeginClockDate               : TDateTime;  { ext }
    EndClockDate                 : TDateTime;  { ext }
    BeginClockTime               : TDateTime;  { ext }
    EndClockTime                 : TDateTime;  { ext }
    SignAccountPeriod            : boolean;
    SOrderID                     : string;     { ext }
    SCity                        : string;     { ext }
    OrderState                   : integer;
    SignNewOrder                 : smallint;   { ext }
    Pharmacy                     : string;
    NPharmacy                    : integer;
    Shipping                     : string;
    Payment                      : string;
    AllNameClient                : string;
    PhoneClient                  : string;
    bSignRefPhone                : boolean;
    AdresClient                  : string;
    SGeoGroupPharm               : string;     { ext }
    NGeoGroupPharm               : integer;    { ext }
    SignGeoGroupPharmNotDefined  : boolean;    { ext }
    SignDefinedPharm             : smallint;   { ext }
    SignMark                     : smallint;   { ext }
    NMarkOtherUser               : integer;    { ext }
    SMarkOtherUser               : string;     { ext }
    SDispatchDeclaration         : string;     { ext }
    NPOST_StateID                : integer;    { ext }
    SNPOST_StateName             : string;     { ext }
    DNPOST_StateBegin            : TDateTime;  { ext }
    DNPOST_StateEnd              : TDateTime;  { ext }
    NPOST_SignStateDate          : boolean;    { ext }
    SignPeriod_PDS               : smallint;   { PDS - PlanDateSend
                                                 Исп. поле AssemblingDate
                                                 ext - вид контрольного периода плановой даты отправки:
                                                         0 - все
                                                         1 - Кадендарный период
                                                         2 - Период (дата + время)
                                                         3 - Не определен }
    BeginDate_PDS                : TDateTime;  { ext }
    EndDate_PDS                  : TDateTime;  { ext }
    BeginClockDate_PDS           : TDateTime;  { ext }
    BeginClockTime_PDS           : TDateTime;  { ext }
    EndClockDate_PDS             : TDateTime;  { ext }
    EndClockTime_PDS             : TDateTime;  { ext }
    SignLink                     : smallint;   { ext:
                                                 0 - Все
                                                 1 - Для текущего заказа показать связанные заказы
                                                 2 - Показать все главные заказы у которых есть дополнительные заказы
                                               }
    SignStockDate                : smallint;   { ext
                                                 0 - Все
                                                 1 - Заказ на складе не оформлялся
                                                 2 - Оформлен заказ на складе
                                               }
    SStockDateBegin              : string;     { ext Оформлен заказ на складе с }
    SStockDateEnd                : string;     { ext Оформлен заказ на складе по}
    { Headings Order }
    SignTypeKeep                 : smallint;   { ext - признак условий хранения }
    { History }
    NameAction                   : string;
    RNAction                     : integer;
    { Pay }
    HavePay                      : integer;
    BarCode                      : string;
    PaySumFrom                   : string;
    PaySumTo                     : string;
    PayDateBegin                 : string;
    PayDateEnd                   : string;
    PayRedeliveryDateBegin       : string;
    PayRedeliveryEnd             : string;
    PayCreateDateBegin           : string;
    PayCreateDateEnd             : string;
    { NPostPay }
    NPostHavePay                 : integer;
    NPostBarCode                 : string;
    NPostPaySumFrom              : string;
    NPostPaySumTo                : string;
    NPostPayRedeliveryDateBegin  : string;
    NPostPayRedeliveryEnd        : string;
    NPostPayCreateDateBegin      : string;
    NPostPayCreateDateEnd        : string;
    SrcSystem                    : Variant;
    ExtId                        : string;
    OperatorId                   : Variant;
  end;
  type PJSO_Condition = ^TJSO_Condition;

  type TMainFilter = record
    OrderId: string;
    CondId: Variant;
    ArtCode: string;
  end;

//Sprint Chepygina Olena  
  TActionParams = record
    UserId: Integer;
    ProcessId: Variant;
    OrderId: Variant;
    TradePointId: Variant;
  end;
  TActionMethod = procedure(AParams: TActionParams; var IErr: Integer; var SErr: string) of object;
  TActionPrepareMethod = function(var AParams: TActionParams): Boolean of object;

const
  { Сообщение для события активации всплывающего окна оповещения }
  WM_AlertEvent = WM_USER + 101;


type
  //Тип бронирования
  TReserveType = (rtNone, rtAll, rtItem, rtSubItem);

  TFCCenterJournalNetZkz = class(TForm)
    dsMain: TDataSource;
    qrMain: TADOQuery;
    dsSlave: TDataSource;
    pmDBGridMain: TPopupMenu;
    pmiDBGridMain_Load: TMenuItem;
    tmrRefresh: TTimer;
    tmrCheckRefresh: TTimer;
    pmiDBGridMain_CurrentAmount: TMenuItem;
    imgMain: TImageList;
    pmToolBar: TPopupMenu;
    pmiToolBar_ShowCption: TMenuItem;
    qrspSlave: TADOStoredProc;
    adospRefresh: TADOStoredProc;
    pmDBGridSlave: TPopupMenu;
    pmiDBGridSlave_SlPharmacy: TMenuItem;
    spGetIdent: TADOStoredProc;
    aJSO: TActionList;
    aMain_UpdPharmacy: TAction;
    pmiDBGridMain_UpdPharmacy: TMenuItem;
    aMain_RP_Zakaz: TAction;
    aMain_RecalcZakaz: TAction;
    pmiDBGridMain_RecalcZakaz: TMenuItem;
    spArmour: TADOStoredProc;
    spReservingOrderOnPharmacies: TADOStoredProc;
    aClipBoard_SOrderDt: TAction;
    spRecalcZakaz: TADOStoredProc;
    pmiDBGridMain_SubMenu_ClipBoard: TMenuItem;
    aClipBoard_Apteka: TAction;
    aClipBoard_OrderAmount: TAction;
    aClipBoard_OrderShipName: TAction;
    aClipBoard_orderPhone: TAction;
    aClipBoard_OrderEMail: TAction;
    aClipBoard_OrderShipStreet: TAction;
    pmiDBGridMain_SubMenu_ClipBoard_Apteka: TMenuItem;
    pmiDBGridMain_SubMenu_ClipBoard_OrderAmount: TMenuItem;
    pmiDBGridMain_SubMenu_OrderEMail: TMenuItem;
    pmiDBGridMain_SubMenu_ClipBoard_orderPhone: TMenuItem;
    pmiDBGridMain_SubMenu_ClipBoard_OrderShipName: TMenuItem;
    pmiDBGridMain_SubMenu_ClipBoard_OrderShipStreet: TMenuItem;
    pmiDBGridMain_SubMenu_ClipBoard_SOrderDT: TMenuItem;
    aClipBoard_AllZakaz: TAction;
    pmiDBGridMain_SubMenu_ClipBoard_AllZakaz: TMenuItem;
    aMain_JournalLoadZakaz: TAction;
    aMain_ConnectionPharmacy: TAction;
    spSetStateArmour: TADOStoredProc;
    aMain_SignBell: TAction;
    pmiDBGridMain_SignBell: TMenuItem;
    spSetSignBellUser: TADOStoredProc;
    pmMainReports: TPopupMenu;
    pmiMainReports_Zakaz: TMenuItem;
    aMain_RP_AllJournal: TAction;
    pmiMainReports_AllJournal: TMenuItem;
    spRegActionOpen: TADOStoredProc;
    spRegActionClose: TADOStoredProc;
    spGetActionState: TADOStoredProc;
    aMain_MarkDateBell: TAction;
    aMain_MarkDateSMS: TAction;
    aMain_MarkDatePay: TAction;
    aMain_MarkDateAssembling: TAction;
    aMain_MarkDispatchDeclaration: TAction;
    aMain_MarkNote: TAction;
    pmiDBGridMain_Delimiter02: TMenuItem;
    pmiDBGridMain_MarkDateBell: TMenuItem;
    pmiDBGridMain_MarkDateSMS: TMenuItem;
    pmiDBGridMain_MarkDatePay: TMenuItem;
    pmiDBGridMain_PlanDateSend: TMenuItem;
    pmiDBGridMain_MarkDispatchDeclaration: TMenuItem;
    pmiDBGridMain_MarkNote: TMenuItem;
    spSetMarkDate: TADOStoredProc;
    dsJSOHistory: TDataSource;
    qrspJSOHistory: TADOStoredProc;
    aMain_OrderClose: TAction;
    aMain_OrderOpen: TAction;
    pmiDBGridMain_State: TMenuItem;
    aMain_ExportOrder1C: TAction;
    pmiDBGridMain_ExportOrder1C: TMenuItem;
    spJSOExportOrder1C: TADOStoredProc;
    spExistActionHistory: TADOStoredProc;
    aJRMO: TActionList;
    dsJRMOMain: TDataSource;
    qrspJRMOMain: TADOStoredProc;
    aJRMOMain_OrderClose: TAction;
    aJRMOMain_OrderOpen: TAction;
    aJRMOMain_Refresh: TAction;
    aJRMOMain_ClearCondition: TAction;
    pmJRMO_Report: TPopupMenu;
    pmJRMO_EXT: TPopupMenu;
    aJRMOMain_RP_Journal: TAction;
    pmiJRMO_RP_Journal: TMenuItem;
    aJRMOMain_MarkDateBell: TAction;
    aJRMOMain_MarkDateSMS: TAction;
    aJRMOMain_MarkNote: TAction;
    pmiJRMO_EXT_MarkDateBell: TMenuItem;
    pmiJRMO_EXT_MarkDateSMS: TMenuItem;
    pmiJRMO_EXT_MarkNote: TMenuItem;
    pmJRMOMain: TPopupMenu;
    pmiJRMOMain_State: TMenuItem;
    pmiJRMOMain_Refresh: TMenuItem;
    pmiJRMOMain_ClearCondition: TMenuItem;
    pmiJRMOMain_Report: TMenuItem;
    pmiJRMOMain_RP_Journal: TMenuItem;
    pmiJRMOMain_Delemiter01: TMenuItem;
    pmiJRMOMain_MarkDateBell: TMenuItem;
    pmiJRMOMain_MarkDateSMS: TMenuItem;
    pmiJRMOMain_MarkNote: TMenuItem;
    dsJRMOHist: TDataSource;
    qrspJRMOHist: TADOStoredProc;
    spJRMOActionOpen: TADOStoredProc;
    spJRMOActionClose: TADOStoredProc;
    spJRMOGetActionState: TADOStoredProc;
    spGenIdAction: TADOStoredProc;
    aMain_SetDriver: TAction;
    pmiDBGridMain_SetDriver: TMenuItem;
    aJSOSlave_Parts: TAction;
    pmiDBGridSlave_Parts: TMenuItem;
    aMain_OrderStatus: TAction;
    pmiDBGridMain_OrderStatus: TMenuItem;
    aJSOSlave_Term: TAction;
    pmiDBGridSlave_Term: TMenuItem;
    aJSOCndHist_SLNameAction: TAction;
    pmiDBGridMain_SubMenu_ClipBoard_Delemiter01: TMenuItem;
    aJFB: TActionList;
    aJFBMain_Close: TAction;
    aJFBMain_Open: TAction;
    aJFBMain_Refresh: TAction;
    aJFBMain_ClearCondition: TAction;
    aJFBMain_RP_AllJournal: TAction;
    aJFBMain_Info: TAction;
    aJFBMain_Status: TAction;
    aJFBMain_SendEMail: TAction;
    pmJFBMain: TPopupMenu;
    pmiJFBMain_State: TMenuItem;
    pmiJFBMain_Status: TMenuItem;
    pmiJFBMain_Info: TMenuItem;
    pmiJFBMain_SendEmail: TMenuItem;
    pmiJFBMain_RP_AllJournal: TMenuItem;
    pmiJFBMain_Delemiter01: TMenuItem;
    pmiJFBMain_Refresh: TMenuItem;
    pmiJFBMain_ClearCondition: TMenuItem;
    dsJFBMain: TDataSource;
    qrspJFBMain: TADOStoredProc;
    aJFBMain_ChangeCondition: TAction;
    dsJFBHist: TDataSource;
    qrspJFBHist: TADOStoredProc;
    aEXT: TActionList;
    spJFBActionOpen: TADOStoredProc;
    spJFBActionClose: TADOStoredProc;
    spJFBActionGetState: TADOStoredProc;
    aMain_RP_QuantIndicatorsUserExperience: TAction;
    pmiMainReports_QuantIndicatorsUserExperience: TMenuItem;
    aJSOHist_ForcedFlosure: TAction;
    spAllowActionClose: TADOStoredProc;
    aMain_Condition: TAction;
    aJSOValueFieldChange: TAction;
    spJSOSetOrderProcessed: TADOStoredProc;
    aMain_JRegError: TAction;
    aMain_RP_SumArmor: TAction;
    pmiMainReports_SumArmor: TMenuItem;
    aMain_jso_ArmorCheck: TAction;
    aMain_jso_ArmorExec: TAction;
    aMain_jso_ArmorExecAll: TAction;
    aMain_BalanceUserCard: TAction;
    spSetModeReserve: TADOStoredProc;
    qrspJSOPositionDistribute: TADOStoredProc;
    dsJSOPositionDistribute: TDataSource;
    spGetItemDistributeCount: TADOStoredProc;
    aJSOSlave_InfoInvoice: TAction;
    pmiDBGridSlave_InfoInvoice: TMenuItem;
    spSetGroupModeReserve: TADOStoredProc;
    aJSOSlave_ItemReserve: TAction;
    aJSOSlave_OrderReserve: TAction;
    pmSlaveRes: TPopupMenu;
    pmiSlaveRes_ItemReserve: TMenuItem;
    pmiSlaveRes_OrderRsereve: TMenuItem;
    aJSOSlave_NewItem: TAction;
    aJSOSlave_UpdItem: TAction;
    aJSOSlave_DelItem: TAction;
    aJSOSlave_ItemRemains: TAction;
    aJSOSlave_OrderRemains: TAction;
    pmiSlaveRes_Delemiter: TMenuItem;
    pmiSlaveRes_ItemRemains: TMenuItem;
    pmiSlaveRes_OrderRemains: TMenuItem;
    pmSlaveItem: TPopupMenu;
    pmiSlaveItem_New: TMenuItem;
    pmiSlaveItem_Upd: TMenuItem;
    pmiSlaveItem_Del: TMenuItem;
    pmiDBGridSlave_Reserve: TMenuItem;
    pmiDBGridSlave_Reserve_Item: TMenuItem;
    pmiDBGridSlave_Reserve_Order: TMenuItem;
    pmiDBGridSlave_Reserve_Delemiter: TMenuItem;
    pmiDBGridSlave_ItemRemains: TMenuItem;
    pmiDBGridSlave_OrderRemains: TMenuItem;
    pmiDBGridSlave_SetItem: TMenuItem;
    pmiDBGridSlave_SetItem_New: TMenuItem;
    pmiDBGridSlave_SetItem_Upd: TMenuItem;
    pmiDBGridSlave_SetItem_Del: TMenuItem;
    aJSOSlave_SubItemReserve: TAction;
    spRegChangeOrder_Insert: TADOStoredProc;
    aMain_RP_StateOpenOrder: TAction;
    pmiMainReports_StateOpenOrder: TMenuItem;
    aJRMOMain_Status: TAction;
    pmiJRMOMain_Status: TMenuItem;
    aJSOSlave_ClearArmor: TAction;
    aJSOSlave_CloseArmor: TAction;
    pmiSlaveRes__CloseArmor: TMenuItem;
    pmiSlaveRes_ClearArmor: TMenuItem;
    pmiDBGridSlave_CloseArmor: TMenuItem;
    pmiDBGridSlave_ClearArmor: TMenuItem;
    pmiDBGridSlave_Reserve_Delemiter2: TMenuItem;
    pmiSlaveRes_Delemiter2: TMenuItem;
    aJRMOMain_RP_Order: TAction;
    pmiJRMO_RP_Order: TMenuItem;
    pmiJRMOMain_RP_Order: TMenuItem;
    qrspJSOPay: TADOStoredProc;
    dsJSOPay: TDataSource;
    aMain_RP_Pay: TAction;
    aMain_RP_JEMailBadArmor: TAction;
    pmiMainReports_Delemiter: TMenuItem;
    pmiMainReports_Pay: TMenuItem;
    pmiMainReports_JEMailBadArmor: TMenuItem;
    tmrJournalAlert: TTimer;
    aMain_GroupPharm: TAction;
    pmiDBGridMain_Ext: TMenuItem;
    pmiDBGridMain_GroupPharm: TMenuItem;
    aMain_RP_Courier: TAction;
    pmiMainReports_Courier: TMenuItem;
    spSetGeoGroupParm: TADOStoredProc;
    spGenIdUserAction: TADOStoredProc;
    dsJSOCheck: TDataSource;
    qrspJSOCheck: TADOStoredProc;
    aJSOPay_Add: TAction;
    aJSOPay_Edit: TAction;
    aJSOPay_Del: TAction;
    spPayDelete: TADOStoredProc;
    aJRMOSlaveItem_Ins: TAction;
    aJRMOSlaveItem_Upd: TAction;
    aJRMOSlaveItem_Del: TAction;
    qrspJRMOItem: TADOStoredProc;
    dsJRMOItem: TDataSource;
    spJRMOItemDel: TADOStoredProc;
    aJRMOCondValueFieldChange: TAction;
    aJRMOCondHist_SLNameAction: TAction;
    aJCall: TActionList;
    aJCallMain_Close: TAction;
    aJCallMain_Open: TAction;
    aJCallMain_Refresh: TAction;
    aJCallMain_ClearCondition: TAction;
    aJCallMain_Status: TAction;
    aJCallMain_ChangeCondition: TAction;
    aJCallMain_ItemEdit: TAction;
    pmJCallMain: TPopupMenu;
    pmiJCall_State: TMenuItem;
    pmiJCall_ItemEdit: TMenuItem;
    pmiJCall_Status: TMenuItem;
    pmiJCall_Delemiter01: TMenuItem;
    pmiJCall_Refresh: TMenuItem;
    pmiJCall_ClearCondition: TMenuItem;
    dsJCallMain: TDataSource;
    qrspJCallMain: TADOStoredProc;
    dsJCall_Hist: TDataSource;
    dsJCall_Enumerator: TDataSource;
    qrspJCall_Hist: TADOStoredProc;
    qrspJCall_Enumerator: TADOStoredProc;
    spJCallGetActionState: TADOStoredProc;
    spJCallActionOpen: TADOStoredProc;
    spJCallActionClose: TADOStoredProc;
    spJCallSetState: TADOStoredProc;
    pmJCall_Report: TPopupMenu;
    aJCall_RP_Statistics: TAction;
    pmiJCall_RP_Statistics: TMenuItem;
    pnlStatus: TPanel;
    pnlOne: TPanel;
    pnlOne_Pages: TPanel;
    spliterOne: TSplitter;
    pnlOneSide: TPanel;
    pgcJSO_JBO: TPageControl;
    tabJSO: TTabSheet;
    spltMainSlave: TSplitter;
    pnlTop: TPanel;
    pnlTop_Condition: TPanel;
    pnlTop_Right: TPanel;
    pnlMain: TPanel;
    pnlMain_ToolBar: TPanel;
    toolbrMainGrid: TToolBar;
    tlbtnDBGridMain_DefState: TToolButton;
    tlbtnDBGridMain_CurrentAmount: TToolButton;
    tlbtnDBGridMain_LinkBell: TToolButton;
    tlbtnDBGridMain_Reports: TToolButton;
    tlbtnDBGridMain_Refresh: TToolButton;
    tlbtnDBGridMain_ConnectionPharmacy: TToolButton;
    pnlMainGrid: TPanel;
    DBGridMain: TDBGrid;
    pnlLocate: TPanel;
    pgcSlave: TPageControl;
    tabSlave_Order: TTabSheet;
    pnlSlave_Order: TPanel;
    pnlSlave_Order_ToolBar: TPanel;
    toolbrSlaveGrid: TToolBar;
    tlbtnDBGridSlave_SlPharmacy: TToolButton;
    tlbtnDBGridSlave_Reserve: TToolButton;
    tlbtnDBGridSlave_SetItemOrder: TToolButton;
    tlbtnDBGridSlave_Parts: TToolButton;
    tlbtnDBGridSlave_Term: TToolButton;
    tlbtnDBGridSlave_InfoInvoice: TToolButton;
    pnlSlave_Order_Right: TPanel;
    pnlSlave_Order_Center: TPanel;
    pnlSlave_OrderGrid: TPanel;
    splitOrderDistribute: TSplitter;
    pnlSlave_OrderGrid_Order: TPanel;
    DBGridSlave: TDBGrid;
    pnlSlave_OrderGrid_Distrib: TPanel;
    pnlSlave_OrderGrid_DistribHeader: TPanel;
    pnlSlave_OrderGrid_DistribHeaderCount: TPanel;
    pnlSlave_OrderGrid_DistribHeaderPrice: TPanel;
    pnlSlave_OrderGrid_DistribHeaderKoef: TPanel;
    pnlSlave_OrderGrid_DistribControl: TPanel;
    pnlSlave_OrderGrid_DistribControlShow: TPanel;
    pnlSlave_OrderGrid_DistribControlTool: TPanel;
    toolbrSlaveGridDistrib: TToolBar;
    tlbtnDBGridSlaveDistrib_InfoInvoice: TToolButton;
    tlbtnDBGridSlaveDistrib_SubItemReserve: TToolButton;
    DBGridSlaveDistrib: TDBGrid;
    tabSlave_History: TTabSheet;
    pnlSlave_History: TPanel;
    pnlSlave_History_Show: TPanel;
    pnlSlave_History_ToolBar: TPanel;
    toolbrJSO_Hist: TToolBar;
    tlbtnJSOHist_ForcedFlosure: TToolButton;
    pnlSlave_HistoryGrid: TPanel;
    JSOGridHistory: TDBGrid;
    tabSlave_Pay: TTabSheet;
    pnlSlave_Pay: TPanel;
    pnlSlave_Pay_Show: TPanel;
    pnlSlave_Pay_Tool: TPanel;
    toolbrJSO_Pay: TToolBar;
    tlbrJSO_Pay_Add: TToolButton;
    tlbrJSO_Pay_Edit: TToolButton;
    tlbrJSO_Pay_Del: TToolButton;
    pnlSlave_PayGrid: TPanel;
    splitSlave_Pay: TSplitter;
    pnlSlave_PayGrid_Pay: TPanel;
    JSOGridPay: TDBGrid;
    pnlSlave_PayGrid_Check: TPanel;
    pnlSlave_CheckControl: TPanel;
    pnlSlave_CheckControl_Show: TPanel;
    pnlSlave_CheckControl_Tool: TPanel;
    gridSlave_Check: TDBGrid;
    tabJRMO: TTabSheet;
    splitJRMOMain: TSplitter;
    pnlJRMOCondition: TPanel;
    pgcJRMOCondition: TPageControl;
    tabJRMOCondition_Order: TTabSheet;
    lblCndJRMO_PeriodWith: TLabel;
    lblCndJRMO_PeriodTo: TLabel;
    lblCndJRMO_ArtCode: TLabel;
    lblCndJRMO_ArtName: TLabel;
    lblCndJRMO_Client: TLabel;
    lblCndJRMO_Phone: TLabel;
    lblCndJRMO_State: TLabel;
    dtCndJRMOBegin: TDateTimePicker;
    dtCndJRMOEnd: TDateTimePicker;
    edCndJRMOArtCode: TEdit;
    edCndJRMOArtName: TEdit;
    edCndJRMOClient: TEdit;
    edCndJRMOPhone: TEdit;
    cmbxCndJRMOState: TComboBox;
    tabJRMOCondition_History: TTabSheet;
    lblCndJRMOHist_NameOperation: TLabel;
    edCndJRMOHist_NameOperation: TEdit;
    btnSlJRMODrivers: TButton;
    pnlJRMOMainControl: TPanel;
    pnlJRMOMainControl_Show: TPanel;
    pnlJRMOMainControl_Tool: TPanel;
    tlbarJRMOMain: TToolBar;
    tlbtnJRMOMain_State: TToolButton;
    tlbtnJRMOMain_Status: TToolButton;
    tlbtnJRMOMain_EXT: TToolButton;
    tlbtnJRMOMain_Report: TToolButton;
    tlbtnJRMOMain_ClearCondition: TToolButton;
    tlbtnJRMOMain_Refresh: TToolButton;
    pnlJRMOMainGrid: TPanel;
    JRMOGridMain: TDBGrid;
    pnlJRMOSlaveGrid: TPanel;
    pgcJRMOSlave: TPageControl;
    tabJRMOSlave_Armour: TTabSheet;
    pnlJRMOSlave_Armour_Control: TPanel;
    pnlJRMOSlave_Armour_Control_Show: TPanel;
    pnlJRMOSlave_Armour_Control_Tool: TPanel;
    tlbarJRMOSlaveItem: TToolBar;
    tlbtnJRMOSlaveItem_Ins: TToolButton;
    tlbtnJRMOSlaveItem_Upd: TToolButton;
    tlbtnJRMOSlaveItem_Del: TToolButton;
    pnlJRMOSlave_Armour_Grid: TPanel;
    JRMOGridSlaveItem: TDBGrid;
    tabJRMOSlave_HIST: TTabSheet;
    pnlJRMOSlaveControl_Hist: TPanel;
    pnlJRMOSlaveControl_Hist_Show: TPanel;
    pnlJRMOSlaveControl_Hist_Tool: TPanel;
    tlbarJRMOSlave_Hist: TToolBar;
    JRMOGridHist: TDBGrid;
    tabJFB: TTabSheet;
    splitJFBMain: TSplitter;
    pnlJFBCondition: TPanel;
    pgcJFBCondition: TPageControl;
    tabJFBCondition_Doc: TTabSheet;
    lblJFBCndBegin: TLabel;
    lblJFBCndEnd: TLabel;
    lblJFBCnd_Client: TLabel;
    lblJFBCnd_Phone: TLabel;
    lblJFBCnd_EMail: TLabel;
    lblJFBCnd_Msg: TLabel;
    dtCndJFBBegin: TDateTimePicker;
    dtCndJFBEnd: TDateTimePicker;
    edJFBCnd_Client: TEdit;
    edJFBCnd_Phone: TEdit;
    edJFBCnd_EMail: TEdit;
    edJFBCnd_Msg: TEdit;
    tabJFBCondition_Hist: TTabSheet;
    pnlJFBMainControl: TPanel;
    pnlJFBMainControl_Show: TPanel;
    pnlJFBMainControl_Tool: TPanel;
    tlbarJFBMain: TToolBar;
    tlbtnJFBMain_State: TToolButton;
    tlbtnJFBMain_Status: TToolButton;
    tlbtnJFBMain_Info: TToolButton;
    tlbtnJFBMain_SendEmail: TToolButton;
    tlbtnJFBMain_Refresh: TToolButton;
    tlbtnJFBMain_ClearCondition: TToolButton;
    tlbtnJFBMain_RP_AllJournal: TToolButton;
    pnlJFBMainGrid: TPanel;
    JFBGridMain: TDBGrid;
    pnlJFBSlaveGrid: TPanel;
    pgcJFBSlave: TPageControl;
    tabJFBSlave_Hist: TTabSheet;
    JFBGridHist: TDBGrid;
    tabJCall: TTabSheet;
    splitJCallMain: TSplitter;
    pnlJCallCondition: TPanel;
    pgcJCallCondition: TPageControl;
    tabJCallCondition_Doc: TTabSheet;
    lblJCallCndBegin: TLabel;
    lblJCallCndEnd: TLabel;
    lblJCallCnd_Phone: TLabel;
    lblJCallCnd_Client: TLabel;
    dtCndJCallBegin: TDateTimePicker;
    dtCndJCallEnd: TDateTimePicker;
    edJCallCnd_Phone: TEdit;
    edJCallCnd_Client: TEdit;
    tabJCallCondition_Hist: TTabSheet;
    pnlJCallMain: TPanel;
    pnlJCallMain_Show: TPanel;
    pnlJCallMain_Tool: TPanel;
    tlbarJCallMain: TToolBar;
    tlbtnJCallMain_State: TToolButton;
    tlbtnJCallMain_Status: TToolButton;
    tlbtnJCallMain_Refresh: TToolButton;
    tlbtnJCallMain_ClearCondition: TToolButton;
    tlbtnJCallMain_Report: TToolButton;
    pnlJCallGridMain: TPanel;
    JCallGridMain: TDBGrid;
    pnlJCallSlave: TPanel;
    pgcJCallSlave: TPageControl;
    tabJCallSlave_Hist: TTabSheet;
    pnlJCallSlaveGrid_Hist: TPanel;
    JCallGridSlave_Hist: TDBGrid;
    tabJCallSlave_Enumerator: TTabSheet;
    pnlJCallSlaveGrid_Enumerator: TPanel;
    JCallGridSlave_Enumerator: TDBGrid;
    pnlStatus_Simple: TPanel;
    pnlStatus_Tool: TPanel;
    stbarOne: TStatusBar;
    aAlarmMsg: TAction;
    aAlarmOrdersPlan: TAction;
    tlbarAlert: TToolBar;                 { Нижний правый угол }
    tlbtnAlarm_Msg: TToolButton;
    tlbtnAlarm_OrdersPlan: TToolButton;
    aJSOMark: TAction;
    aJSOMarkClear: TAction;
    aJSOMarkFiltr: TAction;
    aJSOMarkForOthers: TAction;
    aJSOMarkSetting: TAction;
    aAlarmJSOMarkSetting: TAction;
    spJSOMark: TADOStoredProc;
    spJSOMarkClear: TADOStoredProc;
    spUserBegin: TADOStoredProc;
    spUserClose: TADOStoredProc;
    spUserActive: TADOStoredProc;
    LoacalIdIPWatch: TIdIPWatch;
    spJSOMarkForOthers: TADOStoredProc;
    pnlOneSide_NtfCenter: TPanel;
    splitOneSide: TSplitter;
    pnlOneSide_OrdPlan: TPanel;
    pnlOneSide_Tool: TPanel;
    pnlOneSide_Tool_Show: TPanel;
    pnlOneSide_Tool_Control: TPanel;
    toolbarOneSide: TToolBar;
    aOneSide_Close: TAction;
    toolbarOneSideAlert: TToolBar;
    tlbtnOneSideAlert_AlarmMsg: TToolButton;
    tlbtnOneSideAlert_OrdersPlan: TToolButton;
    pmiDBGridMain_AlarmOrderPlan: TMenuItem;
    pnlOneSide_NtfCenter_Top: TPanel;
    AppEventsNtfCenter: TApplicationEvents;
    pnlOneSide_NtfCenter_Top_Tool: TPanel;
    pnlOneSide_NtfCenter_Top_Show: TPanel;
    tlbtnOneSide_Close: TToolButton;
    aNtfCenter_History: TAction;
    pnlMain_Control: TPanel;
    pnlMain_Control_Show: TPanel;
    pnlMain_Control_MyOrder: TPanel;
    pnlMain_Control_MyOrder_Tool: TPanel;
    toolbarMark: TToolBar;
    tlbtnJSOMark: TToolButton;
    tlbtnJSOMarkFiltr: TToolButton;
    tlbtnJSOMarkForOthers: TToolButton;
    tlbtnJSOMarkSetting: TToolButton;
    pnlMain_Control_MyOrder_User: TPanel;
    pnlMain_Control_MyOrder_User_Img: TPanel;
    imgMarkOtherUser: TImage;
    pnlMain_Control_MyOrder_User_Name: TPanel;
    pmiDBGridMain_MyOrders: TMenuItem;
    pmiDBGridMain_MyOrders_Mark: TMenuItem;
    pmiDBGridMain_MyOrders_MarkFiltr: TMenuItem;
    pmiDBGridMain_MyOrders_MarkForOthers: TMenuItem;
    pmiDBGridMain_MyOrders_MarkSetting: TMenuItem;
    pnlImage: TPanel;
    imgArmor: TImage;
    imgComeBack: TImage;
    imgDistrToPharm: TImage;
    imgReserve: TImage;
    imgTypeKeep: TImage;
    spSetDateExport1C: TADOStoredProc;
    spDSJournalAlert: TADOStoredProc;
    ScrBoxAlert: TScrollBox;
    pnlOneSide_OrdPlan_Header: TPanel;
    aSessionUser: TAction;
    tlbtnOneSideAlert_SessionUser: TToolButton;
    aClipBoard_OrderNoteCourier: TAction;
    pmiDBGridMain_OrderNoteCourier: TMenuItem;
    tlbtnOneSideAlert_History: TToolButton;
    aUserMadeNotification: TAction;
    tlbtnOneSideAlert_UserMadeNotification: TToolButton;
    pmiJRMOMain_Delemiter02: TMenuItem;
    pmiJRMOMain_AlarmCenter: TMenuItem;
    pmiJRMOMain_SessionUser: TMenuItem;
    pmiJRMOMain_UserNotification: TMenuItem;
    pmiJRMOMain_AlarmCenter_History: TMenuItem;
    pmiJRMOMain_AlarmMsg: TMenuItem;
    pmiJRMOMain_AlarmOrdersPlan: TMenuItem;
    pmiJFBMain_Delemiter02: TMenuItem;
    pmiJFBMain_AlarmCenter: TMenuItem;
    pmiJFBMain_SessionUser: TMenuItem;
    pmiJFBMain_UserNotification: TMenuItem;
    pmiJFBMain_AlarmCenter_History: TMenuItem;
    pmiJFBMain_AlarmMsg: TMenuItem;
    pmiJFBMain_AlarmOrdersPlan: TMenuItem;
    pmiJCall_Delemiter02: TMenuItem;
    pmiJCall_AlarmCenter: TMenuItem;
    pmiJCall_SessionUser: TMenuItem;
    pmiJCall_UserNotofication: TMenuItem;
    pmiJCall_AlarmCenter_History: TMenuItem;
    pmiJCall_AlarmMsg: TMenuItem;
    pmiJCall_AlarmOrdersPlan: TMenuItem;
    pnlOneSide_NtfCenter_State: TPanel;
    pnlAlert01: TPanel;
    pnlAlert02: TPanel;
    pnlAlert03: TPanel;
    pnlAlert04: TPanel;
    pnlAlert05: TPanel;
    pnlAlert06: TPanel;
    pnlAlert07: TPanel;
    pnlAlert08: TPanel;
    pnlAlert09: TPanel;
    pnlAlert10: TPanel;
    aControl_AlertRead01: TAction;
    aControl_AlertRead02: TAction;
    aControl_AlertRead03: TAction;
    aControl_AlertRead04: TAction;
    aControl_AlertRead05: TAction;
    aControl_AlertRead06: TAction;
    aControl_AlertRead07: TAction;
    aControl_AlertRead08: TAction;
    aControl_AlertRead09: TAction;
    aControl_AlertRead10: TAction;
    {--}
    pnlAlert01Control: TPanel;
    pnlAlert01Control_Tool: TPanel;
    tlbarAlert01Control: TToolBar;
    tlbtnAlert01Control_Read: TToolButton;
    pnlAlert01Control_Show: TPanel;
    pnlAlert01Main: TPanel;
    pnlAlert01Main_Img: TPanel;
    imgAlert01EventType: TImage;
    pnlAlert01Main_Msg: TPanel;
    pnlAlert01Main_Msg_Date: TPanel;
    edAlert01Date: TMemo;
    pnlAlert01Main_Msg_Type: TPanel;
    edAlert01Type: TMemo;
    pnlAlert01Main_Msg_Content: TPanel;
    edAlert01Content: TMemo;
    {--}
    pnlAlert02Control: TPanel;
    pnlAlert02Control_Tool: TPanel;
    tlbarAlert02Control: TToolBar;
    tlbtnAlert02Control_Read: TToolButton;
    pnlAlert02Control_Show: TPanel;
    pnlAlert02Main: TPanel;
    pnlAlert02Main_Img: TPanel;
    imgAlert02EventType: TImage;
    pnlAlert02Main_Msg: TPanel;
    pnlAlert02Main_Msg_Date: TPanel;
    edAlert02Date: TMemo;
    pnlAlert02Main_Msg_Type: TPanel;
    edAlert02Type: TMemo;
    pnlAlert02Main_Msg_Content: TPanel;
    edAlert02Content: TMemo;
    {--}
    pnlAlert03Control: TPanel;
    pnlAlert03Control_Tool: TPanel;
    tlbarAlert03Control: TToolBar;
    tlbtnAlert03Control_Read: TToolButton;
    pnlAlert03Control_Show: TPanel;
    pnlAlert03Main: TPanel;
    pnlAlert03Main_Img: TPanel;
    imgAlert03EventType: TImage;
    pnlAlert03Main_Msg: TPanel;
    pnlAlert03Main_Msg_Date: TPanel;
    edAlert03Date: TMemo;
    pnlAlert03Main_Msg_Type: TPanel;
    edAlert03Type: TMemo;
    pnlAlert03Main_Msg_Content: TPanel;
    edAlert03Content: TMemo;
    {--}
    pnlAlert04Control: TPanel;
    pnlAlert04Control_Tool: TPanel;
    tlbarAlert04Control: TToolBar;
    tlbtnAlert04Control_Read: TToolButton;
    pnlAlert04Control_Show: TPanel;
    pnlAlert04Main: TPanel;
    pnlAlert04Main_Img: TPanel;
    imgAlert04EventType: TImage;
    pnlAlert04Main_Msg: TPanel;
    pnlAlert04Main_Msg_Date: TPanel;
    edAlert04Date: TMemo;
    pnlAlert04Main_Msg_Type: TPanel;
    edAlert04Type: TMemo;
    pnlAlert04Main_Msg_Content: TPanel;
    edAlert04Content: TMemo;
    {--}
    pnlAlert05Control: TPanel;
    pnlAlert05Control_Tool: TPanel;
    tlbarAlert05Control: TToolBar;
    tlbtnAlert05Control_Read: TToolButton;
    pnlAlert05Control_Show: TPanel;
    pnlAlert05Main: TPanel;
    pnlAlert05Main_Img: TPanel;
    imgAlert05EventType: TImage;
    pnlAlert05Main_Msg: TPanel;
    pnlAlert05Main_Msg_Date: TPanel;
    edAlert05Date: TMemo;
    pnlAlert05Main_Msg_Type: TPanel;
    edAlert05Type: TMemo;
    pnlAlert05Main_Msg_Content: TPanel;
    edAlert05Content: TMemo;
    {--}
    pnlAlert06Control: TPanel;
    pnlAlert06Control_Tool: TPanel;
    tlbarAlert06Control: TToolBar;
    tlbtnAlert06Control_Read: TToolButton;
    pnlAlert06Control_Show: TPanel;
    pnlAlert06Main: TPanel;
    pnlAlert06Main_Img: TPanel;
    imgAlert06EventType: TImage;
    pnlAlert06Main_Msg: TPanel;
    pnlAlert06Main_Msg_Date: TPanel;
    edAlert06Date: TMemo;
    pnlAlert06Main_Msg_Type: TPanel;
    edAlert06Type: TMemo;
    pnlAlert06Main_Msg_Content: TPanel;
    edAlert06Content: TMemo;
    {--}
    pnlAlert07Control: TPanel;
    pnlAlert07Control_Tool: TPanel;
    tlbarAlert07Control: TToolBar;
    tlbtnAlert07Control_Read: TToolButton;
    pnlAlert07Control_Show: TPanel;
    pnlAlert07Main: TPanel;
    pnlAlert07Main_Img: TPanel;
    imgAlert07EventType: TImage;
    pnlAlert07Main_Msg: TPanel;
    pnlAlert07Main_Msg_Date: TPanel;
    edAlert07Date: TMemo;
    pnlAlert07Main_Msg_Type: TPanel;
    edAlert07Type: TMemo;
    pnlAlert07Main_Msg_Content: TPanel;
    edAlert07Content: TMemo;
    {--}
    pnlAlert08Control: TPanel;
    pnlAlert08Control_Tool: TPanel;
    tlbarAlert08Control: TToolBar;
    tlbtnAlert08Control_Read: TToolButton;
    pnlAlert08Control_Show: TPanel;
    pnlAlert08Main: TPanel;
    pnlAlert08Main_Img: TPanel;
    imgAlert08EventType: TImage;
    pnlAlert08Main_Msg: TPanel;
    pnlAlert08Main_Msg_Date: TPanel;
    edAlert08Date: TMemo;
    pnlAlert08Main_Msg_Type: TPanel;
    edAlert08Type: TMemo;
    pnlAlert08Main_Msg_Content: TPanel;
    edAlert08Content: TMemo;
    {--}
    pnlAlert09Control: TPanel;
    pnlAlert09Control_Tool: TPanel;
    tlbarAlert09Control: TToolBar;
    tlbtnAlert09Control_Read: TToolButton;
    pnlAlert09Control_Show: TPanel;
    pnlAlert09Main: TPanel;
    pnlAlert09Main_Img: TPanel;
    imgAlert09EventType: TImage;
    pnlAlert09Main_Msg: TPanel;
    pnlAlert09Main_Msg_Date: TPanel;
    edAlert09Date: TMemo;
    pnlAlert09Main_Msg_Type: TPanel;
    edAlert09Type: TMemo;
    pnlAlert09Main_Msg_Content: TPanel;
    edAlert09Content: TMemo;
    {--}
    pnlAlert10Control: TPanel;
    pnlAlert10Control_Tool: TPanel;
    tlbarAlert10Control: TToolBar;
    tlbtnAlert10Control_Read: TToolButton;
    pnlAlert10Control_Show: TPanel;
    pnlAlert10Main: TPanel;
    pnlAlert10Main_Img: TPanel;
    imgAlert10EventType: TImage;
    pnlAlert10Main_Msg: TPanel;
    pnlAlert10Main_Msg_Date: TPanel;
    edAlert10Date: TMemo;
    pnlAlert10Main_Msg_Type: TPanel;
    edAlert10Type: TMemo;
    pnlAlert10Main_Msg_Content: TPanel;
    edAlert10Content: TMemo;
    spSetUserRead: TADOStoredProc;
    aAlertAll: TAction;
    tlbtnOneSideAlert_All: TToolButton;
    pmiJRMOMain_AlertAll: TMenuItem;
    pmiJFBMain_AlertAll: TMenuItem;
    pmiJCall_AlertAll: TMenuItem;
    spGetFactorNumber: TADOStoredProc;
    aMain_OrderHeaderItem_Upd: TAction;
    pmiDBGridMain_OrderHeaderItem_Upd: TMenuItem;
    spJSOGetDriver: TADOStoredProc;
    tabSlave_NPost: TTabSheet;
    spAlertTypeAccessCheck: TADOStoredProc;
    pnlSlave_NPostControl: TPanel;
    pnlSlave_NPostControl_Show: TPanel;
    pnlSlave_NPostControl_Tool: TPanel;
    pnlSlave_NPostGrid: TPanel;
    toolbrJSO_NPost: TToolBar;
    JSOGridNPost: TDBGrid;
    qrspJSONPost: TADOStoredProc;
    dsJSONPost: TDataSource;
    spNPostActualKey: TADOStoredProc;
    aJSOSlaveNPost_HistStateDate: TAction;
    pmJSONPost: TPopupMenu;
    pmiJSONPost_HistStateDate: TMenuItem;
    aMain_RP_NPostOverdue: TAction;
    pmiMainReports_NPostOverdue: TMenuItem;
    pnlTop_Condition_Main: TPanel;
    pgctrlCondition: TPageControl;
    tabJournal: TTabSheet;
    lblCndDatePeriod_with: TLabel;
    lblCndApteka: TLabel;
    lblCndOrderShipping: TLabel;
    lblCndShipName: TLabel;
    lblCndPhone: TLabel;
    lblCndDatePeriod_toOn: TLabel;
    lblCndAptAdress: TLabel;
    lblCndState: TLabel;
    dtCndBegin: TDateTimePicker;
    dtCndEnd: TDateTimePicker;
    chbxCndAccountPeriod: TCheckBox;
    edCndApteka: TEdit;
    edCndOrderShipping: TEdit;
    edCndShipName: TEdit;
    edCndPhone: TEdit;
    edAptAdress: TEdit;
    cmbxCndState: TComboBox;
    tabZakaz: TTabSheet;
    lblCndArtCode: TLabel;
    lblCndItemName: TLabel;
    lblCndAmountDate_With: TLabel;
    lblCndAmountDate_toOn: TLabel;
    edCndArtCode: TEdit;
    edCndItemName: TEdit;
    dtCndAmountDateBegin: TDateTimePicker;
    dtCndAmountDateEnd: TDateTimePicker;
    chbxCndAmountPeriod: TCheckBox;
    chbxCndNotAmount: TCheckBox;
    edColor: TEdit;
    tabJSO_History: TTabSheet;
    lblJSOCndHistNameOperation: TLabel;
    edJSOCndHist_NameOperation: TEdit;
    btnSlDrivers: TButton;
    tabJSO_Pay: TTabSheet;
    lblJSOCndPay_Have: TLabel;
    cmbxJSOCndPay_Have: TComboBox;
    aMain_RP_ConsolidatedNetOrder: TAction;
    pmiMainReports_ConsolidatedNetOrder: TMenuItem;
    aMain_PlanDateSend: TAction;
    imgMainDisable: TImageList;
    aMain_RP_PayCashOnDelivery: TAction;
    pmiMainReports_PayCashOnDelivery: TMenuItem;
    aCopyRight: TAction;
    pnlTop_Condition_Main_Control: TPanel;
    tbarJSOCond01: TToolBar;
    aMain_ConditionClear: TAction;
    tbtnJSOCond_MakeCond: TToolButton;
    tbarJSOCond02: TToolBar;
    tbtnJSOCond_ClearCond: TToolButton;
    pnlTop_Condition_Main_Control_BorderTop: TPanel;
    pmJSO: TPopupMenu;
    pnlMain_ToolBar_JSO: TPanel;
    tbarJSOLink: TToolBar;
    tbtnJSOLink_AddToOrder: TToolButton;
    tbtnJSOLink_AddToMainRequest: TToolButton;
    tbtnJSOLink_ClearAllUp: TToolButton;
    tbtnJSOLink_ClearAllDown: TToolButton;
    tbtnJSOLink_ClearOneUp: TToolButton;
    tbtnJSOLink_ClearOneDown: TToolButton;
    tbarJSOBlackList: TToolBar;
    tbtnJSOBlackList: TToolButton;
    tbtnJSOBlackList_Add: TToolButton;
    tbtnJSOBlackList_close: TToolButton;
    aJSOLink_AddToOrder: TAction;
    aJSOLink_AddToMainRequest: TAction;
    aJSOLink_ClearAllUp: TAction;
    aJSOLink_ClearAllDown: TAction;
    aJSOLink_ClearOneUp: TAction;
    aJSOLink_ClearOneDown: TAction;
    aJSOBlackList: TAction;
    aJSOBlackList_Close: TAction;
    aJSOBlackList_Add: TAction;
    pmiJSO_HeaderItem: TMenuItem;
    aMain_OrderHeaderItem_Info: TAction;
    pmiJSO_ExtraAttr: TMenuItem;
    pmiJSOExtraAttr_Status: TMenuItem;
    pmiJSOExtraAttr_GroupPharm: TMenuItem;
    pmiJSOExtraAttr_Recalc: TMenuItem;
    pmiJSOExtraAttr_PlanDateSend: TMenuItem;
    pmiJSOExtraAttr_Declaration: TMenuItem;
    pmiJSOExtraAttr_SetDriver: TMenuItem;
    pmiJSOExtraAttr_Note: TMenuItem;
    pmiJSOExtraAttr_SignBell: TMenuItem;
    pmiJSOExtraAttr_MarkDateBell: TMenuItem;
    pmiJSOExtraAttr_markDateSMS: TMenuItem;
    pmiJSOExtraAttr_MarkDatePay: TMenuItem;
    pmiJSO_Link: TMenuItem;
    pmiJSOLink_AddToOrder: TMenuItem;
    pmiJSOLink_AddToMainRequest: TMenuItem;
    pmiJSOLink_ClearAllUp: TMenuItem;
    pmiJSOLink_ClearOneUp: TMenuItem;
    pmiJSOLink_ClearAllDown: TMenuItem;
    pmiJSOLink_Delemiter01: TMenuItem;
    pmiJSOLink_Delemiter02: TMenuItem;
    pmiJSOLink_ClearOneDown: TMenuItem;
    pmiJSO_Favorites: TMenuItem;
    pmiJSOFavorites: TMenuItem;
    pmiJSOFavorites_Filtr: TMenuItem;
    pmiJSOFavorites_ForOrders: TMenuItem;
    pmiJSOFavorites_Setting: TMenuItem;
    pmiJSOBlackList: TMenuItem;
    pmiJSOBlackList_Journal: TMenuItem;
    pmiJSOBlackList_Add: TMenuItem;
    pmiJSOBlackList_Close: TMenuItem;
    pmiJSO_Export1C: TMenuItem;
    pmiDBGridMainLink: TMenuItem;
    pmiDBGridMainLink_ClearOneDown: TMenuItem;
    pmiDBGridMainLink_ClearAllDown: TMenuItem;
    pmiDBGridMainLink_Delemiter02: TMenuItem;
    pmiDBGridMainLink_ClearOneUp: TMenuItem;
    pmiDBGridMainLink_ClearAllUp: TMenuItem;
    pmiDBGridMainLink_Delemiter01: TMenuItem;
    pmiDBGridMainLink_AddToMainRequest: TMenuItem;
    pmiDBGridMainLink_AddToOrder: TMenuItem;
    pmiDBGridMain_BlackList: TMenuItem;
    pmiDBGridMainBlackList_Close: TMenuItem;
    pmiDBGridMainBlackList_Add: TMenuItem;
    pnlSlave_Order_InfoLink: TPanel;
    aJSOLink_FindCurrentOrders: TAction;
    aJSOLink_FindFavorites: TAction;
    tbtnJSOLink_FindCurrentOrders: TToolButton;
    tbtnJSOLink_FindFavorites: TToolButton;
    pmiJSOLink_FindCurrentOrders: TMenuItem;
    pmiJSOLink_FindFavorites: TMenuItem;
    pmiDBGridMainLink_FindCurrentOrders: TMenuItem;
    pmiDBGridMainLink_FindFavorites: TMenuItem;
    aControl_AlertReadAll: TAction;
    aJSOPay_ShowCheck: TAction;
    ToolButton1: TToolButton;
    aJSOHist_Header: TAction;
    ToolButton2: TToolButton;
    pmJSOHist: TPopupMenu;
    pmiJSOHist_ForcedFlosure: TMenuItem;
    pmiJSOHist_Header: TMenuItem;
    lblJSOCndPay_EN: TLabel;
    edJSOCndPay_SDispatchDeclaration: TEdit;
    lblJSOCndPay_BarCode: TLabel;
    edJSOCndPay_BarCode: TEdit;
    tabSlave_NPostPay: TTabSheet;
    pnlSlave_NPostPayControl: TPanel;
    pnlSlave_NPostPayControl_Show: TPanel;
    pnlSlave_NPostPayControl_Tool: TPanel;
    pnlSlave_NPostPayGrid: TPanel;
    JSOGridNPostPay: TDBGrid;
    qrspJSONPostPay: TADOStoredProc;
    dsJSONPostPay: TDataSource;
    aMain_RP_StateOrdersDeliveryPay: TAction;
    pmiMainReports_StateOrdersDeliveryPay: TMenuItem;
    aMainJSO_AutoDial: TAction;
    aOptions: TAction;
    pmJSOptions: TPopupMenu;
    aSetUserShowAlert: TAction;
    pmJSOptions_SetUserShowAlert: TMenuItem;
    pmJSOptions_Reference: TMenuItem;
    aReference: TAction;
    aRefOrderStatus: TAction;
    pmJSOptions_Reference_OrderStatus: TMenuItem;
    aSubMenu: TAction;
    aRefStatusSequence: TAction;
    pmiJSOptions_Reference_StatusSequence: TMenuItem;
    aMainUsersApp: TAction;
    pmJSOptions_UserApp: TMenuItem;
    aAutoGenRefNomencl: TAction;
    pmiJSOptions_Reference_AutoGenRefNomencl: TMenuItem;
    aJournalSMS: TAction;
    aSendNotificationClient: TAction;
    pmiJSO_Delemiter01: TMenuItem;
    pmiJSO_SendNotificationClient: TMenuItem;
    pmiDBGridMain_SendNotificationClient: TMenuItem;
    tbarJSOExt: TToolBar;
    tbtnJSOExt_SendNotificationClient: TToolButton;
    aJSO_CondSlReference: TAction;
    btnJSO_CondPhone: TButton;
    btnJSO_CondPharmacy: TButton;
    aJSO_CondSlNomenclature: TAction;
    btnCndArtCode: TButton;
    btnCndItemName: TButton;
    aQueue: TAction;
    imgSignEnable: TImage;
    imgSignDisable: TImage;
    aJSOSlave_DefOrderItems: TAction;
    tlbtnDBGridSlave_DefOrderItem: TToolButton;
    pmiDBGridSlave_DefOrderItem: TMenuItem;
    aRemains: TAction;
    N1: TMenuItem;
    pmiArmor: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    tabSlave_PayTransaction: TTabSheet;
    pnlSlave_TransactControl: TPanel;
    pnlSlave_TransactControl_Show: TPanel;
    pnlSlave_TransactionControl_Tool: TPanel;
    pnlSlave_TransactionGrid: TPanel;
    JSOGridTransaction: TDBGrid;
    tabPharmReserve: TTabSheet;
    PharmReserveGrid: TsprGridFrm;
    pcPharmReserveDetails: TPageControl;
    tsSpec: TTabSheet;
    PharmReserveSpecGrid: TsprGridFrm;
    SplitterPharmReserve: TSplitter;
    tabPayTransaction: TTabSheet;
    PayTransStatusGrid1: TPayTransStatusGrid;
    aCloseReservingQueue: TAction;
    miCloseReservingClose: TMenuItem;
    tabSlave_Queue: TTabSheet;
    GridOrderQueue: TsprGridFrm;
    tabSlave_OrderHistory: TTabSheet;
    GridOrderHistory: TsprGridFrm;
    tbAction: TToolButton;
    aAction: TAction;
    ToolButton3: TToolButton;
    aBPSpecRef: TAction;
    ToolButton4: TToolButton;
    miSQL: TMenuItem;
    N5: TMenuItem;
    MainMenu1: TMainMenu;
    miSys: TMenuItem;
    miExit: TMenuItem;
    miJournals: TMenuItem;
    miJBlackList: TMenuItem;
    miJAutoDial: TMenuItem;
    miJSMS: TMenuItem;
    miJLoadZakaz: TMenuItem;
    miJRegErr: TMenuItem;
    miRefs: TMenuItem;
    miPharmConnect: TMenuItem;
    N11: TMenuItem;
    N6: TMenuItem;
    N10: TMenuItem;
    N9: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N15: TMenuItem;
    N14: TMenuItem;
    miNotifications: TMenuItem;
    miNotifActive: TMenuItem;
    miNotifHistory: TMenuItem;
    miNotifAll: TMenuItem;
    miCreateUserNotif: TMenuItem;
    miUserSession: TMenuItem;
    N8: TMenuItem;
    N7: TMenuItem;
    miReports: TMenuItem;
    miR1: TMenuItem;
    miR2: TMenuItem;
    miR3: TMenuItem;
    miR4: TMenuItem;
    miR5: TMenuItem;
    miR6: TMenuItem;
    miR7: TMenuItem;
    miR8: TMenuItem;
    miR9: TMenuItem;
    N4: TMenuItem;
    miR10: TMenuItem;
    miR11: TMenuItem;
    miOptions: TMenuItem;
    miBPSpecRef: TMenuItem;
    aMain_Refresh: TAction;
    aSyncStatusPay: TAction;
    miSync: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    qrMainorderID: TIntegerField;
    qrMainSSignBell: TStringField;
    qrMainorderAmount: TBCDField;
    qrMainorderCurrency: TStringField;
    qrMainorderShipping: TStringField;
    qrMainorderPayment: TStringField;
    qrMainorderEmail: TStringField;
    qrMainorderPhone: TStringField;
    qrMainorderShipName: TStringField;
    qrMainorderShipStreet: TStringField;
    qrMainorderDt: TDateTimeField;
    qrMainaptekaID: TIntegerField;
    qrMainID_IPA_DhRes: TIntegerField;
    qrMainIStateArmour: TIntegerField;
    qrMainCreateDate: TDateTimeField;
    qrMainApteka: TStringField;
    qrMainNUser: TIntegerField;
    qrMainSUser: TStringField;
    qrMainDBellDate: TDateTimeField;
    qrMainDSMSDate: TDateTimeField;
    qrMainDPayDate: TDateTimeField;
    qrMainDAssemblingDate: TDateTimeField;
    qrMainSDispatchDeclaration: TStringField;
    qrMainSNote: TStringField;
    qrMainDCloseDate: TDateTimeField;
    qrMainIStateConnection: TIntegerField;
    qrMainDOrderStatus: TIntegerField;
    qrMainSOrderStatus: TStringField;
    qrMainSOrderComment: TStringField;
    qrMainSExport1CDate: TStringField;
    qrMainISignNew: TSmallintField;
    qrMainSStatusName: TStringField;
    qrMainNGeoGroupPharm: TIntegerField;
    qrMainSGroupPharmName: TStringField;
    qrMainNMarkRN: TIntegerField;
    qrMainDMarkDate: TDateTimeField;
    qrMainNMarkUser: TIntegerField;
    qrMainSMarkUser: TStringField;
    qrMainSOrderShipCity: TStringField;
    qrMainNOrderAmountShipping: TBCDField;
    qrMainNPOST_StateID: TIntegerField;
    qrMainDNPOST_StateDate: TDateTimeField;
    qrMainSNPOST_StateName: TStringField;
    qrMainNParentOrderID: TIntegerField;
    qrMainDBlackListDate: TDateTimeField;
    qrMainDDateReceived: TDateTimeField;
    qrMainDChildDateReceived: TDateTimeField;
    qrMainDStockDateBegin: TDateTimeField;
    qrMainDPharmAssemblyDate: TDateTimeField;
    qrMainNPharmAssemblyUser: TIntegerField;
    qrMainNOrderAmountCOD: TBCDField;
    qrMainNCoolantSum: TBCDField;
    qrMainSDeclarationReturn: TStringField;
    qrMainExtId: TStringField;
    qrMainExtSystem: TIntegerField;
    qrMainExtSystemName: TStringField;
    qrMainSrcId: TStringField;
    qrMainSrcSystem: TIntegerField;
    qrMainOrderName: TStringField;
    qrMainSrcSystemName: TStringField;
    qrMainSrcSysPrefix: TStringField;
    qrMainExtSysPrefix: TStringField;
    qrMainStatus_App: TIntegerField;
    qrMainBPId: TIntegerField;
    qrMainDOrderStatusDate: TDateTimeField;
    lbUserFilter: TLabel;
    edUserFilter: TEdit;
    btnUserFilter: TButton;
    lblOrder: TLabel;
    edOrder: TEdit;
    lbCond: TLabel;
    cbCond: TDBLookupComboBox;
    Label1: TLabel;
    dsConds: TDataSource;
    qrMainExecSign: TIntegerField;
    miCheckReserve: TMenuItem;
    aCheckReserve: TAction;
    miSlaveCheckReserve: TMenuItem;
    tbSyncReserve: TToolButton;
    ToolButton5: TToolButton;
    ADOStoredProc1: TADOStoredProc;
    miJournalXLS: TMenuItem;
    qrMainMPhone: TStringField;
    aClipBoard_MPhone: TAction;
    N18: TMenuItem;
    miIP: TMenuItem;
    aClientRef: TAction;
    N19: TMenuItem;
    edArtCode: TEdit;
    Label2: TLabel;
    miIPTelMapRef: TMenuItem;
    miAppeal: TMenuItem;
    aFilterOrdersByPhone: TAction;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    CreateAAAAAAAAAAAAA: TMenuItem;
    {---}
    procedure pnlMouseEnter(Sender: TObject);
    procedure pnlMouseExit(Sender: TObject);
    {---}
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure spltMainSlaveMoved(Sender: TObject);
    procedure dsMainDataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure pmiDBGridMain_LoadClick(Sender: TObject);
    procedure pmiDBGridMain_RefreshClick(Sender: TObject);
    procedure tmrRefreshTimer(Sender: TObject);
    procedure tmrCheckRefreshTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pmiToolBar_ShowCptionClick(Sender: TObject);
    procedure tlbtnDBGridSlave_SlPharmacyClick(Sender: TObject);
    procedure dsSlaveDataChange(Sender: TObject; Field: TField);
    procedure aMain_UpdPharmacyExecute(Sender: TObject);
    procedure aMain_RP_ZakazExecute(Sender: TObject);
    procedure aMain_RecalcZakazExecute(Sender: TObject);
    procedure aClipBoard_SOrderDtExecute(Sender: TObject);
    procedure aClipBoard_AptekaExecute(Sender: TObject);
    procedure aClipBoard_OrderAmountExecute(Sender: TObject);
    procedure aClipBoard_OrderShipNameExecute(Sender: TObject);
    procedure aClipBoard_orderPhoneExecute(Sender: TObject);
    procedure aClipBoard_OrderEMailExecute(Sender: TObject);
    procedure aClipBoard_OrderShipStreetExecute(Sender: TObject);
    procedure aClipBoard_AllZakazExecute(Sender: TObject);
    procedure aMain_JournalLoadZakazExecute(Sender: TObject);
    procedure DBGridSlaveDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure pgcJSO_JBOChange(Sender: TObject);
    procedure aMain_ExecBellExecute(Sender: TObject);
    procedure aMain_ConnectionPharmacyExecute(Sender: TObject);
    procedure aMain_SignBellExecute(Sender: TObject);
    procedure aMain_RP_AllJournalExecute(Sender: TObject);
    procedure DBGridMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridMainKeyPress(Sender: TObject; var Key: Char);
    procedure aMain_MarkDateBellExecute(Sender: TObject);
    procedure aMain_MarkDateSMSExecute(Sender: TObject);
    procedure aMain_MarkDatePayExecute(Sender: TObject);
    procedure aMain_MarkDateAssemblingExecute(Sender: TObject);
    procedure aMain_MarkDispatchDeclarationExecute(Sender: TObject);
    procedure aMain_MarkNoteExecute(Sender: TObject);
    procedure DBGridMainTitleClick(Column: TColumn);
    procedure pgcSlaveChange(Sender: TObject);
    procedure pmReference_ActionFoundationClick(Sender: TObject);
    procedure aMain_OrderCloseExecute(Sender: TObject);
    procedure aMain_OrderOpenExecute(Sender: TObject);
    procedure aMain_ExportOrder1CExecute(Sender: TObject);
    procedure splitJRMOMainMoved(Sender: TObject);
    procedure dsJRMOMainDataChange(Sender: TObject; Field: TField);
    procedure JRMOGridMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aJRMOMain_OrderCloseExecute(Sender: TObject);
    procedure aJRMOMain_OrderOpenExecute(Sender: TObject);
    procedure aJRMOMain_RefreshExecute(Sender: TObject);
    procedure aJRMOMain_ClearConditionExecute(Sender: TObject);
    procedure aJRMOMain_RP_JournalExecute(Sender: TObject);
    procedure aJRMOMain_MarkDateBellExecute(Sender: TObject);
    procedure aJRMOMain_MarkDateSMSExecute(Sender: TObject);
    procedure aJRMOMain_MarkNoteExecute(Sender: TObject);
    procedure dsJRMOHistDataChange(Sender: TObject; Field: TField);
    procedure aMain_SetDriverExecute(Sender: TObject);
    procedure aJSOSlave_PartsExecute(Sender: TObject);
    procedure aMain_OrderStatusExecute(Sender: TObject);
    procedure aJSOSlave_TermExecute(Sender: TObject);
    procedure aJSOCndHist_SLNameActionExecute(Sender: TObject);
    procedure aJFBMain_CloseExecute(Sender: TObject);
    procedure aJFBMain_OpenExecute(Sender: TObject);
    procedure aJFBMain_RefreshExecute(Sender: TObject);
    procedure aJFBMain_ClearConditionExecute(Sender: TObject);
    procedure aJFBMain_RP_AllJournalExecute(Sender: TObject);
    procedure aJFBMain_InfoExecute(Sender: TObject);
    procedure aJFBMain_StatusExecute(Sender: TObject);
    procedure aJFBMain_SendEMailExecute(Sender: TObject);
    procedure splitJFBMainMoved(Sender: TObject);
    procedure aJFBMain_ChangeConditionExecute(Sender: TObject);
    procedure JFBGridMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure JFBGridHistDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dsJFBMainDataChange(Sender: TObject; Field: TField);
    procedure aMain_RP_QuantIndicatorsUserExperienceExecute(Sender: TObject);
    procedure aJSOHist_ForcedFlosureExecute(Sender: TObject);
    procedure JSOGridHistoryDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dsJSOHistoryDataChange(Sender: TObject; Field: TField);
    procedure aMain_ConditionExecute(Sender: TObject);
    procedure aJSOValueFieldChangeExecute(Sender: TObject);
    procedure aMain_JRegErrorExecute(Sender: TObject);
    procedure aMain_RP_SumArmorExecute(Sender: TObject);
    procedure aMain_jso_ArmorCheckExecute(Sender: TObject);
    procedure aMain_jso_ArmorExecExecute(Sender: TObject);
    procedure aJSOSlave_ArmorItemExecExecute(Sender: TObject);
    procedure aJSOSlave_ArmorAllExecExecute(Sender: TObject);
    procedure aJSOSlave_ArmorItemCheckExecute(Sender: TObject);
    procedure aJSOSlave_ArmorAllCheckExecute(Sender: TObject);
    procedure aMain_jso_ArmorExecAllExecute(Sender: TObject);
    procedure aMain_BalanceUserCardExecute(Sender: TObject);
    procedure dsJSOPositionDistributeDataChange(Sender: TObject; Field: TField);
    procedure DBGridSlaveDistribDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aJSOSlave_InfoInvoiceExecute(Sender: TObject);
    procedure aJSOSlave_ItemReserveExecute(Sender: TObject);
    procedure aJSOSlave_OrderReserveExecute(Sender: TObject);
    procedure aJSOSlave_NewItemExecute(Sender: TObject);
    procedure aJSOSlave_UpdItemExecute(Sender: TObject);
    procedure aJSOSlave_DelItemExecute(Sender: TObject);
    procedure aJSOSlave_ItemRemainsExecute(Sender: TObject);
    procedure aJSOSlave_OrderRemainsExecute(Sender: TObject);
    procedure aJSOSlave_SubItemReserveExecute(Sender: TObject);
    procedure aMain_RP_StateOpenOrderExecute(Sender: TObject);
    procedure aJRMOMain_StatusExecute(Sender: TObject);
    procedure aJSOSlave_ClearArmorExecute(Sender: TObject);
    procedure aJSOSlave_CloseArmorExecute(Sender: TObject);
    procedure aJRMOMain_RP_OrderExecute(Sender: TObject);
    procedure JSOGridPayDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aMain_RP_PayExecute(Sender: TObject);
    procedure aMain_RP_JEMailBadArmorExecute(Sender: TObject);
    procedure tmrJournalAlertTimer(Sender: TObject);
    procedure aMain_GroupPharmExecute(Sender: TObject);
    procedure aMain_RP_CourierExecute(Sender: TObject);
    procedure dsJSOPayDataChange(Sender: TObject; Field: TField);
    procedure gridSlave_CheckDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aJSOPay_AddExecute(Sender: TObject);
    procedure aJSOPay_EditExecute(Sender: TObject);
    procedure aJSOPay_DelExecute(Sender: TObject);
    procedure aJRMOSlaveItem_InsExecute(Sender: TObject);
    procedure aJRMOSlaveItem_UpdExecute(Sender: TObject);
    procedure aJRMOSlaveItem_DelExecute(Sender: TObject);
    procedure JRMOGridSlaveItemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure pgcJRMOSlaveChange(Sender: TObject);
    procedure aJRMOCondValueFieldChangeExecute(Sender: TObject);
    procedure aJRMOCondHist_SLNameActionExecute(Sender: TObject);
    procedure splitJCallMainMoved(Sender: TObject);
    procedure aJCallMain_CloseExecute(Sender: TObject);
    procedure aJCallMain_OpenExecute(Sender: TObject);
    procedure aJCallMain_RefreshExecute(Sender: TObject);
    procedure aJCallMain_ClearConditionExecute(Sender: TObject);
    procedure aJCallMain_StatusExecute(Sender: TObject);
    procedure aJCallMain_ChangeConditionExecute(Sender: TObject);
    procedure aJCallMain_ItemEditExecute(Sender: TObject);
    procedure JCallGridMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure JCallGridSlave_HistDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure JCallGridSlave_EnumeratorDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dsJCallMainDataChange(Sender: TObject; Field: TField);
    procedure pgcJCallSlaveChange(Sender: TObject);
    procedure aJCall_RP_StatisticsExecute(Sender: TObject);
    procedure aAlarmMsgExecute(Sender: TObject);
    procedure spliterOneMoved(Sender: TObject);
    procedure aAlarmOrdersPlanExecute(Sender: TObject);
    procedure aJSOMarkExecute(Sender: TObject);
    procedure aJSOMarkClearExecute(Sender: TObject);
    procedure aJSOMarkFiltrExecute(Sender: TObject);
    procedure aJSOMarkForOthersExecute(Sender: TObject);
    procedure aJSOMarkSettingExecute(Sender: TObject);
    procedure aAlarmJSOMarkSettingExecute(Sender: TObject);
    procedure aOneSide_CloseExecute(Sender: TObject);
    procedure AppEventsNtfCenterIdle(Sender: TObject; var Done: Boolean);
    procedure splitOneSideMoved(Sender: TObject);
    procedure aSessionUserExecute(Sender: TObject);
    procedure aClipBoard_OrderNoteCourierExecute(Sender: TObject);
    procedure aNtfCenter_HistoryExecute(Sender: TObject);
    procedure aUserMadeNotificationExecute(Sender: TObject);
    procedure aControl_AlertRead01Execute(Sender: TObject);
    procedure aControl_AlertRead02Execute(Sender: TObject);
    procedure aControl_AlertRead03Execute(Sender: TObject);
    procedure aControl_AlertRead04Execute(Sender: TObject);
    procedure aControl_AlertRead05Execute(Sender: TObject);
    procedure aControl_AlertRead06Execute(Sender: TObject);
    procedure aControl_AlertRead07Execute(Sender: TObject);
    procedure aControl_AlertRead08Execute(Sender: TObject);
    procedure aControl_AlertRead09Execute(Sender: TObject);
    procedure aControl_AlertRead10Execute(Sender: TObject);
    procedure aAlertAllExecute(Sender: TObject);
    procedure aMain_OrderHeaderItem_UpdExecute(Sender: TObject);
    procedure DBGridMainDblClick(Sender: TObject);
    procedure JSOGridNPostDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aJSOSlaveNPost_HistStateDateExecute(Sender: TObject);
    procedure aMain_RP_NPostOverdueExecute(Sender: TObject);
    procedure aMain_RP_ConsolidatedNetOrderExecute(Sender: TObject);
    procedure aMain_PlanDateSendExecute(Sender: TObject);
    procedure aMain_RP_PayCashOnDeliveryExecute(Sender: TObject);
    procedure aCopyRightExecute(Sender: TObject);
    procedure aMain_ConditionClearExecute(Sender: TObject);
    procedure aJSOLink_AddToOrderExecute(Sender: TObject);
    procedure aJSOLink_AddToMainRequestExecute(Sender: TObject);
    procedure aJSOLink_ClearAllUpExecute(Sender: TObject);
    procedure aJSOLink_ClearAllDownExecute(Sender: TObject);
    procedure aJSOLink_ClearOneUpExecute(Sender: TObject);
    procedure aJSOLink_ClearOneDownExecute(Sender: TObject);
    procedure aJSOBlackList_AddExecute(Sender: TObject);
    procedure aJSOBlackList_CloseExecute(Sender: TObject);
    procedure aJSOBlackListExecute(Sender: TObject);
    procedure aMain_OrderHeaderItem_InfoExecute(Sender: TObject);
    procedure aJSOLink_FindCurrentOrdersExecute(Sender: TObject);
    procedure aJSOLink_FindFavoritesExecute(Sender: TObject);
    procedure aControl_AlertReadAllExecute(Sender: TObject);
    procedure JSOGridPayDblClick(Sender: TObject);
    procedure aJSOPay_ShowCheckExecute(Sender: TObject);
    procedure aJSOHist_HeaderExecute(Sender: TObject);
    procedure JSOGridNPostPayDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aMain_RP_StateOrdersDeliveryPayExecute(Sender: TObject);
    procedure aMainJSO_AutoDialExecute(Sender: TObject);
    procedure aSetUserShowAlertExecute(Sender: TObject);
    procedure aRefOrderStatusExecute(Sender: TObject);
    procedure aSubMenuExecute(Sender: TObject);
    procedure aRefStatusSequenceExecute(Sender: TObject);
    procedure aMainUsersAppExecute(Sender: TObject);
    procedure aAutoGenRefNomenclExecute(Sender: TObject);
    procedure aJournalSMSExecute(Sender: TObject);
    procedure aSendNotificationClientExecute(Sender: TObject);
    procedure edCndPhoneKeyPress(Sender: TObject; var Key: Char);
    procedure aJSO_CondSlReferenceExecute(Sender: TObject);
    procedure edCndAptekaKeyPress(Sender: TObject; var Key: Char);
    procedure aJSO_CondSlNomenclatureExecute(Sender: TObject);
    procedure aJSOSlave_DefOrderItemsExecute(Sender: TObject);
    procedure aRemainsExecute(Sender: TObject);
    procedure JSOGridTransactionDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure aCloseReservingQueueExecute(Sender: TObject);
    procedure aActionExecute(Sender: TObject);
    procedure aBPSpecRefExecute(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure miSQLClick(Sender: TObject);
    procedure aMain_RefreshExecute(Sender: TObject);
    procedure aSyncStatusPayExecute(Sender: TObject);
    procedure btnUserFilterClick(Sender: TObject);
    procedure edOrderKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbCondCloseUp(Sender: TObject);
    procedure JSOControlKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure JSODateCloseUp(Sender: TObject);
    procedure aCheckReserveExecute(Sender: TObject);
    procedure miJournalXLSClick(Sender: TObject);
    procedure aClipBoard_MPhoneExecute(Sender: TObject);
    procedure miIPClick(Sender: TObject);
    procedure aClientRefExecute(Sender: TObject);
    procedure edArtCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure miIPTelMapRefClick(Sender: TObject);
    procedure miAppealClick(Sender: TObject);
    procedure aFilterOrdersByPhoneExecute(Sender: TObject);
  private
    { Private declarations }
    ISign_Active                : integer;   // признак завершения события OnActivate [in (0,1)]
    UserSession                 : TUserSession;
    JSOCondIdent                : longint;
    ControlPanelSide            : TControlPanelSide;
    IEnabledAlertWindow         : boolean;   // вкл/выкл режима показа всплывающих окон
    BStateFlashWindow           : boolean;
    IJRMOSign_Active            : integer;
    IJFBSign_Active             : integer;
    IJCallSign_Active           : integer;
    IOldState_ThreadLoad        : integer;   // предыдущее состояние обновления (загрузки) данных в потоке [in (-1,0,1)]
    ISign_ResThreadLoad         : integer;   // признак результата выполнения обновления (загрузки) данных в потоке [in (0,1)]
    NKoefSplitOneSide           : real;
    NKoefSplitNtfCenter         : real;
    NKoefShowSplit              : real;      // коеффициент пересчета взаимного размещения master и slave гридов для интернет-заказов
    NKoefJRMOShowSplit          : real;
    NKoefJFBShowSplit           : real;
    NKoefJCallShowSplit         : real;
    DLastRefresh                : tdatetime; // Дата последнего обновления
    NameParmXML                 : string;    // Имя файла или значение поля таблицы БД, где храняться параметры классов в XML-формате
    ISignKeepParmXNL            : integer;   // Признак места хранения праметров класса в XML-формате
    JSOHeaderItem               : TJSO_OrderHeaderItem;
    JSORecItem                  : TJSO_ItemOrder;
    JSORecPay                   : TJSO_Pay;
    JRMORecItem                 : TJRMO_Item;
    LocateOrder                 : string;
    MainSortField               : string;
    JSOHist_RNUserAction        : integer;
    JRMOHist_RNUserAction       : integer;
    IJSOSignMassChangeCondition : smallint;
    ParentsList                 : string;
    SlavesList                  : string;
    JSOParentOrder              : integer;
    Width_pnlSlave_PayGrid_Pay  : integer;
    imgSignGrid                 : TImage;
    { Поля расширенного условия отбора журнала интернет-заказов }
    JSOCondRec                  : TJSO_Condition;
    FOrderHeaderDS: TDataSet;
    {---}
    FMainFilter  : TMainFilter;
    FMainFilterState: TMainFilterState;
    FIP: string;
    FCompName: string;
    function  ControlAtMouse: TControl;
    function  FindParentTagFive(Obj : TControl) : TControl;
    {---}
    //procedure ShowVersion;
    procedure wmAlertEvent(var msg : TMessage); message WM_AlertEvent;
    procedure wmFilterOrdersEvent(var msg : TMessage); message WM_FilterOrdersEvent;
    procedure AlertSetUserRead(NRN : int64);
    procedure DoAction(AActionCode: string;
      ActionExecuteMethod: TActionMethod; ActionPrepareMethod: TActionPrepareMethod; AfterActionExecute: TActionMethod);
    procedure JSOArmor;
    procedure UserBegin;
    procedure UserClose;
    procedure ShowPanelSide(TypePanel : byte);
    procedure PanelSideClear;
    procedure ShowGets;
    procedure ShowGetsEnable_ActionLink(SignDSEmpty : boolean; SignOrderClose : boolean);
    procedure JRMOShowGets;
    procedure JFBShowGets;
    procedure JCallShowGets;
    procedure ShowGetsSlave;
    procedure ShowGetsSlaveDistribute;
    procedure JSOShowGetsSlave_Hist;
    procedure JSOSetRecHist;
    procedure JSOSetRecPay;
    procedure ShowSpliterOneMoved;
    procedure SetKoefSplitOneSide;
    procedure SetKoefSplitNtfCenter;
    procedure SetKoefShowSplit;
    procedure SetKoefJRMOShowSplit;
    procedure SetKoefJFBShowSplit;
    procedure SetKoefJCallShowSplit;
    procedure ShowResize;
    procedure ExecConditionQRMain;
    procedure ExecConditionJSOPay;
    procedure ExecConditionJSOCheck;
    procedure ExecConditionJSONPost;
    procedure ExecConditionJSONPostPay;
    procedure ExecConditionJRMOMain;
    procedure ExecConditionJCallMain;
    procedure ExecConditionJRMOItem;
    procedure ExecConditionJRMOHist;
    procedure ExecConditionJFBMain;
    procedure ExecConditionJCallHist;
    procedure ExecConditionJCallEnumerator;
    procedure CreateConditionQRMain;
    procedure CreateConditionJRMOMain;
    procedure CreateConditionJFBMain;
    procedure CreateConditionJCallMain;
    procedure JSOSaveCondition;
    procedure ShowStatuBarStandart;
    procedure SetClearCondition;
    procedure JRMOSetClearCondition;
    procedure JFBSetClearCondition;
    procedure JCallSetClearCondition;
    procedure FullLoad(ISignThreadLoad : integer);
    procedure ReservingOfOrders( ISignPeriod : integer;
                                 ISignExec              : integer;
                                 ISignExecOnlyCurrent   : integer;
                                 IDCurren               : integer;
                                 ISignExecOrderShipping : integer;
                                 GenIDAction            : integer
                               );
    procedure GridMainRefresh;
    procedure GridSlaveRefresh;
    procedure JSOGridSlaveHistRefresh;
    procedure JSODisableDistribute;
    procedure JSOEnableDistribute;
    procedure JRMOGridMainRefresh;
    procedure JFBGridMainRefresh;
    procedure JCallGridMainRefresh;
    procedure SetStateAllControlSlave(bState : boolean);
    procedure SetStateAllControlSlaveHist(bState : boolean);
    procedure SetStateAllControlSlavePay(bState : boolean);
    procedure JRMOSetStateAllControlSlaveItem(bState : boolean);
    procedure SetStateForcedFlosure;
    procedure RecalcZakaz;
    procedure RegActionOpen(var IErr : integer; var SErr : string);
    procedure RegActionState(var IErr : integer; var SErr : string);
    procedure ExistActionState(var IErr : integer; var SErr : string);
    procedure RegActionClose;
    procedure JRMORegActionOpen(var IErr : integer; var SErr : string);
    procedure JRMORegActionState(var IErr : integer; var SErr : string);
    procedure JRMORegActionClose;
    procedure JFBRegActionOpen(var IErr : integer; var SErr : string);
    procedure JFBRegActionState(var IErr : integer; var SErr : string);
    procedure JFBRegActionClose;
    procedure JCallRegActionState(var IErr : integer; var SErr : string);
    procedure JCallRegActionOpen(var IErr : integer; var SErr : string);
    procedure JCallRegActionClose;
    procedure JSOSetOrderProcessed(Order : integer; IDUSER : integer);
    procedure JSOAssignHeaderItem;
    procedure JSOAssignRecItem;
    procedure JSOShowPayGridCheck;
    function  GetKoefSplitOneSide : real;
    function  GetKoefSplitNtfCenter : real;
    function  GetKoefShowSplit : real;
    function  GetKoefJRMOShowSplit : real;
    function  GetKoefJFBShowSplit : real;
    function  GetKoefJCallShowSplit : real;
    function  GetStateClearMainCondition : boolean;
    function  GetStateClearSlaveCondition : boolean;
    function  GetStateClearHistCondition : boolean;
    function  GetStateClearPayCondition : boolean;
    function  GetStateClearNPostPayCondition : boolean;
    function  JRMOGetStateClearMainCondition : boolean;
    function  JFBGetStateClearMainCondition : boolean;
    function  JCallGetStateClearMainCondition : boolean;
    function  GenId : integer;
    function  GetJSOItemDistributeCount : integer;
    function  GetAccessUserAlertType(AlertType : integer) : boolean;

//Sprint Chepygina Olena
    procedure DefPrepareAction(var AParams: TActionParams);
    procedure JSO_ActionExecute(AStoredProcName: string; AParams: TActionParams; var IErr: Integer; var SErr: string);
    function JSO_Prepare_WholeOrderOrTPoint_Action(DlgCaption: string; var AParams: TActionParams): Boolean;

    procedure JSO_CloseArmorExecute(AParams: TActionParams; var IErr: Integer; var SErr: string);
    procedure JSO_ClearArmorExecute(AParams: TActionParams; var IErr: Integer; var SErr: string);

    function JSO_PrepareCloseArmor(var AParams: TActionParams): Boolean;
    function JSO_PrepareClearArmor(var AParams: TActionParams): Boolean;

    procedure JSO_AfterSlaveActionExecute(AParams: TActionParams; var IErr: Integer; var SErr: string);
    procedure InitPharmReserve;
    procedure InitPayTransaction;
    procedure InitOrderQueue;
    procedure InitOrderHistory;
    procedure PharmReserveDataChange(Sender: TObject; Field: TField);
    procedure ExecHistoryOrderAction(ActionName: string; ConfirmMessage: string;
      ReserveType: TReserveType = rtNone; IsOrderSpecAction: Boolean = false);
    function IsActionOrder: Boolean;
    function CanEditOrder(ActionCode: string; var ErrMsg: string): Boolean;
    procedure ClearMainFilter(DoClearFilterState: Boolean = True);
    procedure SaveMainFilter;
    procedure ReBuildJSOCond;
    function GetIP: string;
    function GetCompName: string;
    procedure ApplyMOrderFilter;
    procedure ApplyMArtCodeFilter;
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
    //procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
    //procedure ApplicationActivate(Sender: TObject);
  protected
   // procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    SIDENT                      : string;
    RegAction                   : TRegAction;
    IState_ThreadLoad           : integer; { состояние обновления (загрузки) данных в потоке [in (-1,0,1)] }
    SignStateStreamActiveAction : integer; { Состояние потока обработки активности пользовательских действий.
                                             0 - не выполняется (завершен)
                                             1 - выполняется (завершен)
                                           }
    procedure UserActive;
    procedure ExistAction(var IErr : integer; var SErr : string);
    procedure SetModeReserve(ModeReserve : smallint; SignUnit : smallint; Order : integer; ArtCode : integer);
    procedure SetGroupModeReserve(ModeReserve : smallint; SignUnit : smallint; Order : integer);
    procedure JSOGetDriver(var SNameDriver,SDateDriver : string);
    procedure PhaseDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);

    function  GetIdUserAction : longint;
    function  GetJSOFactorNumber(KoefOpt, SignMeas : integer) : integer;
    property OrderHeaderDS: TDataSet read FOrderHeaderDS;
  end;

  (* Потоковая обработка загрузки данных *)
  TThreadLoad = class(TThread)
  private
  protected
    procedure Execute; override;
  public
    destructor Destroy; override;
  end;

  { Механизм оповещений }
  {
  TAlertWindowEventType  = (awetFeedBack, awetRMedication, awetMissedCall, awetPay, awetPayCheck, awetError, awetUser, awetPharmacy, awetNewPost, awetCall);
  TAlertWindowShowMethod = (fmAAWShowLeftToRight,fmAAWShowCenter,fmAAWShowTopDown);
  TAlertWindowFadeMethod = (fmAAWFadeTimer, fmAAWFadeRightToLeft, fmAAWFadeCenter, fmAAWFadeDowmUp);
  PAlertPopupWindowOptions = ^TAlertPopupWindowOptions;
  TAlertPopupWindowOptions = record
    NRN_AlertUser : int64;
    Enumereator   : byte;
    EventTime     : TDateTime;
    EventType     : TAlertWindowEventType;
    WShowMetod    : TAlertWindowShowMethod;
    WFadeMetod    : TAlertWindowFadeMethod;
    WColor        : TColor;
    TextColor     : TColor;
    AlertMessage  : string;
    AlertType     : string;
    AlertUser     : string;
    AlertTypeUser : string;
    IconIndex     : integer;
  end;
  TAlertPopupWindowControl = class
    private
      AWList : TList;
      procedure UpdateWindowPos(PWH : HWND);
    public
      procedure RegisterAlertPopupWindow(PWH: HWND);
      procedure UnRegisterAlertPopupWindow(PWH: HWND);
      constructor Create;
      destructor  Destroy;
  end;    }
  TAlertPanel = class
    private
      APList : TList;
      procedure ShowPanels;
      procedure APList_FreePAOptions;
    public
      procedure RegisterPanel(PAOptions: PAlertPopupWindowOptions);
      constructor Create;
      destructor  Destroy;
  end;

  function GetComputerName: string;

const
  { Разделы }
  cFSection_SiteApteka911 = 1;
  cFSection_OrderClients  = 2;
  { Вид доставки }
  SSign_Armour = 'Бронь в аптеке';
  { Состояние заказа }
  csStateClose = 1;
  csStateOpen  = 0;
  { Доступные (разрешенные) значения признаков (симофоров) для SQL-процедуры <udo_p_jzs_amount> }
  { @ISignPeriod  int - признак учета периода даты заказа }
  csNotUseDocPeriod  = 0; { не учитывать }
  csUseDocPeriod     = 1; { учитывать    }
  { @ISignExec int - что бронировать }
  csExecFull    = 0; { по всем заказам с учетом @ISignPeriod }
  csExecOnlyNew = 1; { только для новых заказов }
  { @SignExecOnlyCurrent int - признак выполнения бронирования только для текущего заказа }
  csExecUseCurrent    = 1; { только для текущего закзаа }
  csExecNotUseCurrent = 0; { для всех заказов с учетом ISignExec }
  { @SignExecOrderShipping int - признак выполнения бронирования в зависимости от значения поля orderShipping }
  csExecShippingArmor    = 1; { выполнять только для значения orderShipping = 'Бронь в аптеке' }
  csExecShippingAnyValue = 0; { выполнять для любого значения поля orderShipping }
  { Для установки режимов резервирования }
  csModeReserve_Clear    = 0; { очистить     }
  csModeReserve_Armor    = 1; { бронирование }
  csModeReserve_ComeBack = 2; { автовозврат  }
  csUnitReserve_CCPP     = 1; { CallCenter_PickPharmacy }
  csUnitReserve_CCZS     = 2; { CallCenter_Zakaz_Site }
  csUnitReserve_PPDi     = 3; { t_jsz_PickPositionDistribute }
  { Типы таблиц в ведущем представлении товарных позиций заказа }
  csOrderItemTypeTable_Main = 'MAIN';
  csOrderItemTypeTable_Add  = 'ADDED';
  { Номера в imgMain для тпов уведомлений }
  cImgMain_FeedBack         = 195;
  cImgMain_FeedBackOld      = 321;
  cImgMain_RareMedication   = 176;
  cImgMain_MissedCall       = 291;
  cImgMain_NewPay           = 270;
  cImgMain_NewCheckoutCheck = 317;
  cImgMain_User             = 322;
  cImgMain_Error            = 206;
  cImgMain_Pharmacy         = 325;
  cImgMain_NewPost          = 328;
  cImgMain_Call             = 131;
  { JSO - условия отбора }
  cJSOSignLink_FindCurrentOrders = 1;
  cJSOSignLink_FindFavorites     = 2;
  { JSO - метод очистки связей между заказами }
  cJSOLinkClear_AllParents = false;
  cJSOLinkClear_NextParent = true;
  cJSOLinkClear_AllSlaves  = false;
  cJSOLinkClear_NextSlave  = true;
  { Тип объединения платежей: см. pDS_jso_OrderPay }
  cJSOPayTypeUnion_Main    = 'MAIN';
  cJSOPayTypeUnion_Link    = 'LINK';
  { Статусы }
  cStatusCompleted            = 89; //Выполнен
  cStatusOrderIsPaid          = 90; //'Заказ оплачен'
  cStasusReservePeriodExpired = 91; //'Период резервирования истек' Отмененная бронь - автоматически закрыта
  cStasusCanceledReservations = 32; //'Отмененная бронь'           Отмененная бронь - принудительно закрыта
  cStatusSoldReservations    = 31; //Проданная бронь
  cStatusCanceled            = 47; //Закрыт/отменен

var
  FCCenterJournalNetZkz   : TFCCenterJournalNetZkz;
  AlertPopupWindowControl : TAlertPopupWindowControl;
  AlertPanel              : TAlertPanel;

implementation

uses Types, Umain, DateUtils, StrUtils, IdGlobal, ClipBrd, Util,
  CCJS_PickPharmacy, CCJS_UpdPharmacyZakaz, CCJS_JournalRegLoadOrders, UStateConnectionPharmacy,
  CCJS_MarkDispatchDeclaration, CCJS_MarkNote,
  UReference, ExDBGRID, CCJS_State,
  CCJS_SetDrivers, CCJS_PartsPosition, CCJS_OrderStatus, CCJS_ArtCodeTerm,
  CCJFB_Status, CCJS_RP_QuantIndicatorsUserExperience, CCJSO_Condition,
  CCJSO_JRegError, CCJSO_SumArmor, CCJS_ComeBack, CCJS_RP_Order,
  CCJS_ItemCard, CCJS_RP_StateOpenOrder, CCJRMO_Status, CCJS_RP_Pay,
  CCJS_RP_JEMailBadArmor, CCJS_RP_Courier, CCJS_Pay, CCJRMO_Item,
  CCJRMO_State, CCJCALL_Status, CCJCall_RP_Statistics, CCJSO_MyOrder,
  DepED_WAlert, CCJSO_JournalAlert, CCJAL_CreateUserMsg,
  CCJSO_SessionUsers, CCSJO_AlertContents, CCJSO_OrderHeaderItem,
  CCJSO_NPost_StateDate, CCJSO_NPostOverdue, CCJSO_RP_ConsolidatedNetOrder,
  CCJSO_SetFieldDate, CCJSO_RP_PayCashOnDelivery, CCJSO_Version,        //???CCJSO_Version
  CCJSO_SetLink, CCJSO_BlackListControl, CC_BlackListJournal, CCJSO_DM,
  CCJSO_HeaderHistory, CCJSO_RP_StateOrdersDeliveryPay, CCJSO_AutoDial,
  CCJSO_AccessUserAlert, CCJSO_RefStatusSequence, CCJSO_RefUsers,
  CCJSO_AutoGenRefNomencl, CCJSO_JournalMsgClient,
  CCJSO_ClientNotice_PayDetails, CCJO_DefOrderItems,
  uWholeOrderOrTradePointDlg, uActionDlg, uActionCore,
  ufrmAlert, ufmCommonAlert, ufrmCallClientAlert, uClientRef, uIPTelMapRef,
  uSprRef; { tlXMLClass }

const
  cPnlSide_NtfCenter = 0;
  cPnlSide_OrdPlan   = 1;
  {--}
  cObjAlertSlaveTag = 10500;
  cObjAlertMainTag  = 5;
  {--}
  cCondPanelCheck_Header = 'Header';
  cCondPanelCheck_Item   = 'Item';
  cCondPanelCheck_Hist   = 'Hist';
  cCondPanelCheck_Pay    = 'Pay';

{$R *.dfm}

{ BEGIN description TThreadLoad }

procedure TThreadLoad.Execute;
begin
  FCCenterJournalNetZkz.pmiDBGridMain_Load.Enabled := false;
  FreeOnTerminate := True;
  if (FCCenterJournalNetZkz.IState_ThreadLoad = 0) or (FCCenterJournalNetZkz.IState_ThreadLoad = -1) then begin
    FCCenterJournalNetZkz.IState_ThreadLoad := 1;
    FCCenterJournalNetZkz.FullLoad(1);
  end;
end;

destructor TThreadLoad.Destroy;
begin
  inherited Destroy;
  FCCenterJournalNetZkz.pmiDBGridMain_Load.Enabled := true;
  FCCenterJournalNetZkz.IState_ThreadLoad := 0;
end;

{ END description TThreadLoad }

{ BEGIN description TAlertPopupWindowControl }
{
constructor TAlertPopupWindowControl.Create;
begin
  AWList := TList.Create;
end;

procedure TAlertPopupWindowControl.RegisterAlertPopupWindow(PWH: HWND);
var
  IndexAW : integer;
begin
  IndexAW := AWList.IndexOf(Pointer(PWH));
  if IndexAW < 0 then
    AWList.Add(Pointer(PWH));
  UpdateWindowPos(PWH);
end;

procedure TAlertPopupWindowControl.UnRegisterAlertPopupWindow(PWH: HWND);
var
  IndexAW : integer;
begin
  IndexAW := AWList.IndexOf(Pointer(PWH));
  if IndexAW >= 0 then begin
    AWList.Remove(Pointer(PWH));
    UpdateWindowPos(PWH);
  end;
end;

destructor TAlertPopupWindowControl.Destroy;
begin
  AWList.Free;
end;

procedure TAlertPopupWindowControl.UpdateWindowPos(PWH : HWND);
const
  IndentY = 100;
var
  rAW     : TRect;
  TopAW   : integer;
  LeftAW  : integer;
  i       : integer;
  BErr    : boolean;
  ScreenY : integer;
  ScreenX : integer;
begin
  ScreenY := screen.WorkAreaHeight-100;
  ScreenX := screen.WorkAreaWidth;
  TopAW  := ScreenY - IndentY - 2;
  for i := 0 to AWList.Count - 1 do begin
    GetWindowRect(HWND(AWList[i]),rAW);
    LeftAW := ScreenX - (rAW.Right-rAW.Left) - 2;
    BErr := SetWindowPos(HWND(AWList[i]), HWND_TOPMOST, LeftAW, TopAW, rAW.Right-rAW.Left, rAW.Bottom-rAW.Top, SWP_SHOWWINDOW or SWP_NOACTIVATE);
    (*
    case TfrmDepED_WAlert(popupList[i]).AlertWOptions.WShowMetod of
      fmAAWShowLeftToRight : AnimateWindow(HWND(popupList[i]), 300, AW_SLIDE or AW_HOR_POSITIVE ); //слева на право
      fmAAWShowCenter      : AnimateWindow(HWND(popupList[i]), 300, AW_SLIDE or AW_CENTER );
      fmAAWShowTopDown     : AnimateWindow(HWND(popupList[i]), 300, AW_SLIDE or AW_VER_POSITIVE ); //сверху вниз
    else
      AnimateWindow(HWND(popupList[i]), 300, AW_SLIDE or AW_HOR_POSITIVE );  // слева на право
    end;
    *)
    TopAW := TopAW - (rAW.Bottom  - rAW.Top) - 2;
  end;
end;
}
{ END description TAlertPopupWindowControl }

{ BEGIN description TAlertPanel }

constructor TAlertPanel.Create;
begin
  APList := TList.Create;
end;

procedure TAlertPanel.RegisterPanel(PAOptions: PAlertPopupWindowOptions);
var
  IndexLP : integer;
begin
  IndexLP := APList.IndexOf(PAlertPopupWindowOptions(PAOptions));
  if IndexLP < 0 then
    APList.Add(PAlertPopupWindowOptions(PAOptions));
end;

procedure TAlertPanel.APList_FreePAOptions;
var
  iLP : integer;
begin
  FCCenterJournalNetZkz.tlbtnAlert01Control_Read.Enabled := false;
  FCCenterJournalNetZkz.tlbtnAlert02Control_Read.Enabled := false;
  FCCenterJournalNetZkz.tlbtnAlert03Control_Read.Enabled := false;
  FCCenterJournalNetZkz.tlbtnAlert04Control_Read.Enabled := false;
  FCCenterJournalNetZkz.tlbtnAlert05Control_Read.Enabled := false;
  FCCenterJournalNetZkz.tlbtnAlert06Control_Read.Enabled := false;
  FCCenterJournalNetZkz.tlbtnAlert07Control_Read.Enabled := false;
  FCCenterJournalNetZkz.tlbtnAlert08Control_Read.Enabled := false;
  FCCenterJournalNetZkz.tlbtnAlert09Control_Read.Enabled := false;
  FCCenterJournalNetZkz.tlbtnAlert10Control_Read.Enabled := false;
  for iLP := 0 to APList.Count - 1 do begin
    dispose(PAlertPopupWindowOptions(APList[iLP]));
  end;
  APList.Clear;
end;

procedure TAlertPanel.ShowPanels;
var
  iLP      : integer;
  iPanel   : integer;
  POptions : PAlertPopupWindowOptions;
  vList: TStringList;
  {--}
  procedure ShowAlert(
                      imgET      : TImage;
                      edDate     : TMemo;
                      edType     : TMemo;
                      edContent  : TMemo;
                      ToolBtn    : TToolButton;
                      AlertPanel : TPanel
                     );
  begin
    imgET.Picture.Graphic := nil;
    FCCenterJournalNetZkz.imgMain.GetBitmap(POptions^.IconIndex,imgET.Picture.Bitmap); imgET.Repaint;
    edDate.Font.Size := 10;
    edType.Font.Size := 8;
    edType.Font.Style := [];
    ToolBtn.Enabled := true;
    if POptions^.EventType = awetUser then
    begin
      edDate.Text := FormatDateTime('dd-mm-yyyy hh:nn:ss', POptions^.EventTime) + '  ' + POptions^.AlertUser;
      edType.Text := POptions^.AlertType + ' (' + POptions^.AlertTypeUser + ')';
      edContent.Text := POptions^.AlertMessage;
    end else
    if POptions^.EventType = awetCall then
    begin
      edDate.Text := POptions^.AlertType + ' ' + FormatDateTime('dd-mm-yyyy hh:nn:ss', POptions^.EventTime);
      vList := TStringList.Create;
      try
        vList.Delimiter := '&';
        vList.DelimitedText := POptions^.AlertMessage;
        edType.Font.Style := [fsBold];
        edType.Text := vList.Strings[0];
        vList.Delete(0);
        edContent.Clear;
        edContent.Lines.AddStrings(vList);
      finally
        vList.Free;
      end;
      edDate.Font.Size := 8;
      edType.Font.Size := 6;
      ToolBtn.Enabled := false;
      ToolBtn.Visible := false;
    end
    else
    begin
      edDate.Text := FormatDateTime('dd-mm-yyyy hh:nn:ss', POptions^.EventTime);
      edType.Text := POptions^.AlertType;
      edContent.Text := POptions^.AlertMessage;
    end;
    //edContent.Text := POptions^.AlertMessage;

    AlertPanel.Visible := true;
  end;
begin
  if APList.Count = 0 then begin
    FCCenterJournalNetZkz.pnlOneSide_NtfCenter_State.Caption := 'Новых уведомлений нет';
    FCCenterJournalNetZkz.pnlAlert10.Visible := false;
    FCCenterJournalNetZkz.pnlAlert09.Visible := false;
    FCCenterJournalNetZkz.pnlAlert08.Visible := false;
    FCCenterJournalNetZkz.pnlAlert07.Visible := false;
    FCCenterJournalNetZkz.pnlAlert06.Visible := false;
    FCCenterJournalNetZkz.pnlAlert05.Visible := false;
    FCCenterJournalNetZkz.pnlAlert04.Visible := false;
    FCCenterJournalNetZkz.pnlAlert03.Visible := false;
    FCCenterJournalNetZkz.pnlAlert02.Visible := false;
    FCCenterJournalNetZkz.pnlAlert01.Visible := false;
  end else begin
    FCCenterJournalNetZkz.pnlOneSide_NtfCenter_State.Caption := 'Активных уведомлений: ' + IntToStr(APList.Count);
    for iLP := 0 to APList.Count - 1 do begin
      iPanel := iLP + 1;
      POptions := PAlertPopupWindowOptions(APList[iLP]);
      case iPanel of
        01: ShowAlert(
                      FCCenterJournalNetZkz.imgAlert01EventType,
                      FCCenterJournalNetZkz.edAlert01Date,
                      FCCenterJournalNetZkz.edAlert01Type,
                      FCCenterJournalNetZkz.edAlert01Content,
                      FCCenterJournalNetZkz.tlbtnAlert01Control_Read,
                      FCCenterJournalNetZkz.pnlAlert01
                     );
        02: ShowAlert(
                      FCCenterJournalNetZkz.imgAlert02EventType,
                      FCCenterJournalNetZkz.edAlert02Date,
                      FCCenterJournalNetZkz.edAlert02Type,
                      FCCenterJournalNetZkz.edAlert02Content,
                      FCCenterJournalNetZkz.tlbtnAlert02Control_Read,
                      FCCenterJournalNetZkz.pnlAlert02
                     );
        03: ShowAlert(
                      FCCenterJournalNetZkz.imgAlert03EventType,
                      FCCenterJournalNetZkz.edAlert03Date,
                      FCCenterJournalNetZkz.edAlert03Type,
                      FCCenterJournalNetZkz.edAlert03Content,
                      FCCenterJournalNetZkz.tlbtnAlert03Control_Read,
                      FCCenterJournalNetZkz.pnlAlert03
                     );
        04: ShowAlert(
                      FCCenterJournalNetZkz.imgAlert04EventType,
                      FCCenterJournalNetZkz.edAlert04Date,
                      FCCenterJournalNetZkz.edAlert04Type,
                      FCCenterJournalNetZkz.edAlert04Content,
                      FCCenterJournalNetZkz.tlbtnAlert04Control_Read,
                      FCCenterJournalNetZkz.pnlAlert04
                     );
        05: ShowAlert(
                      FCCenterJournalNetZkz.imgAlert05EventType,
                      FCCenterJournalNetZkz.edAlert05Date,
                      FCCenterJournalNetZkz.edAlert05Type,
                      FCCenterJournalNetZkz.edAlert05Content,
                      FCCenterJournalNetZkz.tlbtnAlert05Control_Read,
                      FCCenterJournalNetZkz.pnlAlert05
                     );
        06: ShowAlert(
                      FCCenterJournalNetZkz.imgAlert06EventType,
                      FCCenterJournalNetZkz.edAlert06Date,
                      FCCenterJournalNetZkz.edAlert06Type,
                      FCCenterJournalNetZkz.edAlert06Content,
                      FCCenterJournalNetZkz.tlbtnAlert06Control_Read,
                      FCCenterJournalNetZkz.pnlAlert06
                     );
        07: ShowAlert(
                      FCCenterJournalNetZkz.imgAlert07EventType,
                      FCCenterJournalNetZkz.edAlert07Date,
                      FCCenterJournalNetZkz.edAlert07Type,
                      FCCenterJournalNetZkz.edAlert07Content,
                      FCCenterJournalNetZkz.tlbtnAlert07Control_Read,
                      FCCenterJournalNetZkz.pnlAlert07
                     );
        08: ShowAlert(
                      FCCenterJournalNetZkz.imgAlert08EventType,
                      FCCenterJournalNetZkz.edAlert08Date,
                      FCCenterJournalNetZkz.edAlert08Type,
                      FCCenterJournalNetZkz.edAlert08Content,
                      FCCenterJournalNetZkz.tlbtnAlert08Control_Read,
                      FCCenterJournalNetZkz.pnlAlert08
                     );
        09: ShowAlert(
                      FCCenterJournalNetZkz.imgAlert09EventType,
                      FCCenterJournalNetZkz.edAlert09Date,
                      FCCenterJournalNetZkz.edAlert09Type,
                      FCCenterJournalNetZkz.edAlert09Content,
                      FCCenterJournalNetZkz.tlbtnAlert09Control_Read,
                      FCCenterJournalNetZkz.pnlAlert09
                     );
        10: ShowAlert(
                      FCCenterJournalNetZkz.imgAlert10EventType,
                      FCCenterJournalNetZkz.edAlert10Date,
                      FCCenterJournalNetZkz.edAlert10Type,
                      FCCenterJournalNetZkz.edAlert10Content,
                      FCCenterJournalNetZkz.tlbtnAlert10Control_Read,
                      FCCenterJournalNetZkz.pnlAlert10
                     );
      end;
      Application.ProcessMessages;
    end; { for iLP := 0 to APList.Count - 1 do }
    for iPanel := 10 downto APList.Count+1 do begin
      case iPanel of
        10: FCCenterJournalNetZkz.pnlAlert10.Visible := false;
        09: FCCenterJournalNetZkz.pnlAlert09.Visible := false;
        08: FCCenterJournalNetZkz.pnlAlert08.Visible := false;
        07: FCCenterJournalNetZkz.pnlAlert07.Visible := false;
        06: FCCenterJournalNetZkz.pnlAlert06.Visible := false;
        05: FCCenterJournalNetZkz.pnlAlert05.Visible := false;
        04: FCCenterJournalNetZkz.pnlAlert04.Visible := false;
        03: FCCenterJournalNetZkz.pnlAlert03.Visible := false;
        02: FCCenterJournalNetZkz.pnlAlert02.Visible := false;
        01: FCCenterJournalNetZkz.pnlAlert01.Visible := false;
      end;
    end;
  end;
end;

destructor TAlertPanel.Destroy;
begin
  APList_FreePAOptions;
  APList.Free;
end;

{ END   description TAlertPanel }

{ BEGIN description TFCCenterJournalNetZkz }

function TFCCenterJournalNetZkz.GenID : integer;
var
  IErr       : integer;
  SErr       : string;
  iResReturn : integer;
begin
  iResReturn := 0;
  spGenIdAction.Parameters.ParamValues['@USER'] := Form1.id_user;
  spGenIdAction.ExecProc;
  iResReturn := spGenIdAction.Parameters.ParamValues['@NRN'];
  IErr := spGenIdAction.Parameters.ParamValues['@RETURN_VALUE'];
  if IErr <> 0 then begin
    iResReturn := 0;
    SErr := spGenIdAction.Parameters.ParamValues['@SErr'];
    ShowMessage(SErr);
  end;
  result := iResReturn;
end;

procedure TFCCenterJournalNetZkz.wmAlertEvent(var msg : TMessage);
begin
  if PAlertPopupWindowOptions(msg.LParam).EventType = awetCall then
      TfmCommonAlert.Execute(PAlertPopupWindowOptions(msg.LParam),
      Form1.ADOC_STAT,
      imgMain,
      TfrmCallClientAlert,
      UserSession.CurrentUser,
      g_AlertManager)

    {TfmCommonAlert.Create(PAlertPopupWindowOptions(msg.LParam),
      AlertPopupWindowControl,
      Form1.ADOC_STAT,
      imgMain,
      TfrmCallClientAlert,
      UserSession.CurrentUser)}
  else
    TfrmDepED_WAlert.Create(PAlertPopupWindowOptions(msg.LParam));
end;

procedure TFCCenterJournalNetZkz.GridMainRefresh;
var
  RNOrderID: Integer;
begin
  if not qrMain.Active then qrMain.Active := true;
  if not qrMain.IsEmpty then RNOrderID := qrMain.FieldByName('orderID').AsInteger else RNOrderID := -1;
  Screen.Cursor := crHourGlass;
  try
    qrMain.Requery;
    qrMain.Locate('orderID', RNOrderID, []);
  finally
    Screen.Cursor := crDefault;
  end;
end; (* TFCCenterJournalNetZkz.GridMainRefresh *)

procedure TFCCenterJournalNetZkz.GridSlaveRefresh;
var
  RNOrderID: Integer;
begin
  if not qrspSlave.IsEmpty then RNOrderID := qrspSlave.FieldByName('NRN').AsInteger else RNOrderID := -1;
  qrspSlave.Requery;
  qrspSlave.Locate('NRN', RNOrderID, []);
  ShowGets;
end; (* TFCCenterJournalNetZkz.GridMainRefresh *)

procedure TFCCenterJournalNetZkz.JSOGridSlaveHistRefresh;
var
  RNOrderID: Integer;
begin
  if not qrspJSOHistory.IsEmpty then RNOrderID := qrspJSOHistory.FieldByName('NRN').AsInteger else RNOrderID := -1;
  qrspJSOHistory.Requery;
  qrspJSOHistory.Locate('NRN', RNOrderID, []);
  ShowGets;
end;

(* Бронирование заказов *)
procedure TFCCenterJournalNetZkz.ReservingOfOrders
(
 ISignPeriod            : integer;
 ISignExec              : integer;
 ISignExecOnlyCurrent   : integer;
 IDCurren               : integer;
 ISignExecOrderShipping : integer;
 GenIDAction            : integer
);
var
  ISignReturn : integer;
  SErrMsg     : string;
begin
  (* Проверка входных параметров *)
  if not ((ISignPeriod = 0) or (ISignPeriod = 1)) then ISignPeriod := 1;
  if not ((ISignExec = 0)   or (ISignExec = 1))   then ISignExec   := 1;
  //
  //(*
  //stbarOne.SimpleText := 'Резервирование заказов...';
  spArmour.Parameters.ParamValues['@DBeginDate']            := dtCndBegin.Date;
  spArmour.Parameters.ParamValues['@DEndDate']              := dtCndEnd.Date;
  spArmour.Parameters.ParamValues['@ISignPeriod']           := ISignPeriod;
  spArmour.Parameters.ParamValues['@ISignExec']             := ISignExec;
  spArmour.Parameters.ParamValues['@SignExecOnlyCurrent']   := ISignExecOnlyCurrent;
  spArmour.Parameters.ParamValues['@IDCurrent']             := IDCurren;
  spArmour.Parameters.ParamValues['@SignExecOrderShipping'] := ISignExecOrderShipping;
  spArmour.Parameters.ParamValues['@IDUser']                := (-1)*Form1.id_user;
  spArmour.Parameters.ParamValues['@GenID']                 := GenIDAction;
  try
    spArmour.ExecProc;
    ISignReturn := spArmour.Parameters.ParamValues['@RETURN_VALUE'];
    if ISignReturn <> 0 then
      begin
        SErrMsg := spArmour.Parameters.ParamValues['@ErrMsg'];
        ShowMessage(SErrMsg);
      end;
  except
    on e:Exception do
      begin
        ShowMessage('Сбой при выполнении автоматического бронирования. Попробуйте еще раз' +
                    chr(10) + e.Message
                   );
      end;
  end;
  //*)
end; (* TFCCenterJournalNetZkz.ReservingOfOrders *)

(* Загрузить все *)
// ISignThreadLoad = 1 - режим автоматического обновления в потоке по таймеру
// ISignThreadLoad = 0 - отработка команды(кнопки) <Загрузить все>
procedure TFCCenterJournalNetZkz.FullLoad(ISignThreadLoad : integer);
var
  IResRefresh : integer;
  IGenID      : integer;
begin
  ISign_ResThreadLoad := 0;
  { Уникальный номер процесса }
  IGenID := GenID;
  if IGenID = 0 then exit;
  //stbarOne.SimpleText := 'Обновление данных...';
  adospRefresh.Parameters.ParamValues['@ID_USER'] := form1.id_user;
  adospRefresh.Parameters.ParamValues['@GenID']   := IGenID;
  try
    IResRefresh := 0;
    adospRefresh.ExecProc;
    IResRefresh := adospRefresh.Parameters.ParamValues['@RETURN_VALUE'];
    DLastRefresh := now;
  except
    on e:Exception do
      begin
        IResRefresh := 0;
        ShowMessage('Сбой загрузке новых заказов. Попробуйте еще раз.' +
                    chr(10) + e.Message
                    );
      end;
  end;
  (* Есть новые заказы
     IResRefresh = 10 - есть новые заказы
     IResRefresh = 11 - есть новые заказы и в них значение поля orderShipping(Вид доставки) = Бронь в аптеке
  *)
  if (IResRefresh = 10) or (IResRefresh = 11) then
    ISign_ResThreadLoad := 1; // Взводим признак наличия новых заказов
  { Автоматическое бронирование заказов }
  if ISign_ResThreadLoad = 1 then begin
    { Отработка команды(кнопки) <Загрузить все> }
    if      ISignThreadLoad = 0 then ReservingOfOrders( csNotUseDocPeriod,
                                                        csExecOnlyNew,
                                                        csExecNotUseCurrent,
                                                        0,
                                                        csExecShippingArmor,
                                                        IGenID
                                                      )
    { Режим автоматического обновления в потоке по таймеру }
    else if ISignThreadLoad = 1 then ReservingOfOrders( csNotUseDocPeriod,
                                                        csExecOnlyNew,
                                                        csExecNotUseCurrent,
                                                        0,
                                                        csExecShippingArmor,
                                                        IGenID
                                                      );
  end;
end;

(* Состояние условия отбора для main-раздела *)
function TFCCenterJournalNetZkz.GetStateClearMainCondition : boolean;
var bResReturn : boolean;
begin
  if     (length(trim(edCndApteka.Text))                       = 0)
     and (cmbxCndState.ItemIndex                               = 3)
     and (length(trim(edCndOrderShipping.Text))                = 0)
     and (length(trim(edCndShipName.Text))                     = 0)
     and (length(trim(edCndPhone.Text))                        = 0)
     and (length(trim(edAptAdress.Text))                       = 0)
     and (length(trim(edJSOCndPay_SDispatchDeclaration.Text))  = 0) { ВНИМАНИЕ - в закладке ПЛАТЕЖИ }
    { Поля расширенного условия отбора журнала интернет-заказов }
     and (length(trim(JSOCondRec.SOrderID))              = 0)
     and (length(trim(JSOCondRec.ExtID))                 = 0)
     and (length(trim(JSOCondRec.SCity))                 = 0)
     and (length(trim(JSOCondRec.Payment))               = 0)
     and (JSOCondRec.SignNewOrder                        = 0)
     and (JSOCondRec.NGeoGroupPharm                      = 0)
     and (not JSOCondRec.SignGeoGroupPharmNotDefined )
     and (JSOCondRec.SignDefinedPharm                    = 0)
     and (JSOCondRec.SignMark                            = 0)
     and (JSOCondRec.NPOST_StateID                       = 0)
     and (not JSOCondRec.NPOST_SignStateDate                )
     and (JSOCondRec.SignPeriod_PDS                      = 0)
     and (JSOCondRec.SignLink                            = 0)
     and (JSOCondRec.SignStockDate                       = 0)
     and (length(trim(JSOCondRec.SStockDateBegin))       = 0)
     and (length(trim(JSOCondRec.SStockDateEnd))         = 0)
     and not VarIsAssigned(JSOCondRec.SrcSystem)
     and (length(trim(edOrder.Text))                     = 0)
     and not VarIsAssigned(cbCond.KeyValue)
  then bResReturn := true
  else bResReturn := false;
  result := bResReturn;
end; (* TFCCenterJournalNetZkz.GetStateClearMainCondition *)

function TFCCenterJournalNetZkz.GetStateClearPayCondition : boolean;
var bResReturn : boolean;
begin
  if     (cmbxJSOCndPay_Have.ItemIndex                     = 0)
     and (length(trim(edJSOCndPay_BarCode.Text))           = 0)
     { Поля расширенного условия отбора }
     and (length(trim(JSOCondRec.PaySumFrom))              = 0)
     and (length(trim(JSOCondRec.PaySumTo))                = 0)
     and (length(trim(JSOCondRec.PayDateBegin))            = 0)
     and (length(trim(JSOCondRec.PayDateEnd))              = 0)
     and (length(trim(JSOCondRec.PayRedeliveryDateBegin))  = 0)
     and (length(trim(JSOCondRec.PayRedeliveryEnd))        = 0)
     and (length(trim(JSOCondRec.PayCreateDateBegin))      = 0)
     and (length(trim(JSOCondRec.PayCreateDateEnd))        = 0)
  then bResReturn := true
  else bResReturn := false;
  result := bResReturn;
end;

function TFCCenterJournalNetZkz.GetStateClearNPostPayCondition : boolean;
var bResReturn : boolean;
begin
  if     (JSOCondRec.NPostHavePay                               = 0)
     and (length(trim(JSOCondRec.NPostBarCode))                 = 0)
     { Поля расширенного условия отбора }
     and (length(trim(JSOCondRec.NPostPaySumFrom))              = 0)
     and (length(trim(JSOCondRec.NPostPaySumTo))                = 0)
     and (length(trim(JSOCondRec.NPostPayRedeliveryDateBegin))  = 0)
     and (length(trim(JSOCondRec.NPostPayRedeliveryEnd))        = 0)
     and (length(trim(JSOCondRec.NPostPayCreateDateBegin))      = 0)
     and (length(trim(JSOCondRec.NPostPayCreateDateEnd))        = 0)
  then bResReturn := true
  else bResReturn := false;
  result := bResReturn;
end;

(* Состояние условия отбора для slave-раздела *)
function TFCCenterJournalNetZkz.GetStateClearSlaveCondition : boolean;
var bResReturn : boolean;
begin
  if     not chbxCndAmountPeriod.Checked
     and not chbxCndNotAmount.Checked
     and (length(trim(edCndArtCode.Text))  = 0)
     and (length(trim(edCndItemName.Text)) = 0)
  then bResReturn := true
  else bResReturn := false;
  result := bResReturn;
end; (* TFCCenterJournalNetZkz.GetStateClearMainCondition *)

(* Состояние условия отбора для истории операций *)
function TFCCenterJournalNetZkz.GetStateClearHistCondition : boolean;
var bResReturn : boolean;
begin
  if (length(trim(edJSOCndHist_NameOperation.Text))  = 0) and (length(trim(edUserFilter.Text))  = 0)
  then bResReturn := true
  else bResReturn := false;
  result := bResReturn;
end; (* TFCCenterJournalNetZkz.GetStateClearHistCondition *)

{ Очистка условия отбора - интернет заказы }
procedure TFCCenterJournalNetZkz.SetClearCondition;
begin
  { Заказы }
  chbxCndAccountPeriod.Checked          := true;
  cmbxCndState.ItemIndex                := 3;
  edCndApteka.Text                      := '';
  JSOCondRec.NPharmacy                  := 0;
  edCndOrderShipping.Text               := '';
  edCndShipName.Text                    := '';
  edCndPhone.Text                       := '';
  JSOCondRec.bSignRefPhone              := false;
  edAptAdress.Text                      := '';
  edJSOCndPay_SDispatchDeclaration.Text := ''; { ВНИМАНИЕ - поле находится в закладке платежи }
    JSOCondRec.SOrderID                    := '';      { ext }
    JSOCondRec.SCity                       := '';      { ext }
    JSOCondRec.Payment                     := '';      { ext }
    JSOCondRec.SignNewOrder                := 0;       { ext }
    JSOCondRec.SGeoGroupPharm              := '';      { ext }
    JSOCondRec.NGeoGroupPharm              := 0;       { ext }
    JSOCondRec.SignGeoGroupPharmNotDefined := false;   { ext }
    JSOCondRec.SignDefinedPharm            := 0;       { ext }
    JSOCondRec.SignMark                    := 0;       { ext }
    JSOCondRec.NMarkOtherUser              := 0;       { ext }
    JSOCondRec.SMarkOtherUser              := '';      { ext }
    JSOCondRec.NPOST_StateID               := 0;       { ext }
    JSOCondRec.SNPOST_StateName            := '';      { ext }
    JSOCondRec.NPOST_SignStateDate         := false;   { ext }
    //JSOCondRec.DNPOST_StateBegin                     { ext }
    //JSOCondRec.DNPOST_StateEnd                       { ext }
    JSOCondRec.SignPeriod_PDS              := 0;       { ext }
    JSOCondRec.SignLink                    := 0;       { ext }
    JSOCondRec.SignStockDate               := 0;       { ext }
    JSOCondRec.SStockDateBegin             := '';      { ext }
    JSOCondRec.SStockDateEnd               := '';      { ext }
    JSOCondRec.SrcSystem                   := Null;
    JSOCondRec.ExtId                       := '';
  { Состав Заказа }
  chbxCndAmountPeriod.Checked  := false;
  chbxCndNotAmount.Checked     := false;
  edCndArtCode.Text            := '';
  edCndItemName.Text           := '';
  { История }
  edJSOCndHist_NameOperation.Text := '';
  JSOHist_RNUserAction := 0;
  { Платежи }
  cmbxJSOCndPay_Have.ItemIndex          := 0;
  edJSOCndPay_BarCode.Text              := '';
  { Расширенные условия отбора }
  JSOCondRec.PaySumFrom                 := '';
  JSOCondRec.PaySumTo                   := '';
  JSOCondRec.PayDateBegin               := '';
  JSOCondRec.PayDateEnd                 := '';
  JSOCondRec.PayRedeliveryDateBegin     := '';
  JSOCondRec.PayRedeliveryEnd           := '';
  JSOCondRec.PayCreateDateBegin         := '';
  JSOCondRec.PayCreateDateEnd           := '';
  { Наложенные платежи }
  JSOCondRec.NPostHavePay                    := 0;
  JSOCondRec.NPostBarCode                    := '';
  JSOCondRec.NPostPaySumFrom                 := '';
  JSOCondRec.NPostPaySumTo                   := '';
  JSOCondRec.NPostPayRedeliveryDateBegin     := '';
  JSOCondRec.NPostPayRedeliveryEnd           := '';
  JSOCondRec.NPostPayCreateDateBegin         := '';
  JSOCondRec.NPostPayCreateDateEnd           := '';
  JSOCondRec.OperatorId := Unassigned;
  edUserFilter.Text := '';
  FMainFilterState := mfsNone; 
  ClearMainFilter;
end; (* TFCCenterJournalNetZkz.SetClearCondition; *)

procedure TFCCenterJournalNetZkz.JRMOSetClearCondition;
begin
  { Заказы редких лекарств }
  edCndJRMOArtCode.Text            := '';
  edCndJRMOArtName.Text            := '';
  edCndJRMOClient.Text             := '';
  edCndJRMOPhone.Text              := '';
  edCndJRMOHist_NameOperation.Text := '';
  JRMOHist_RNUserAction            := 0;
  cmbxCndJRMOState.ItemIndex       := 0;
end;

procedure TFCCenterJournalNetZkz.JFBSetClearCondition;
begin
  { Заказы обратных звонков и сообщений }
  edJFBCnd_Client.Text := '';
  edJFBCnd_Phone.Text  := '';
  edJFBCnd_EMail.Text  := '';
  edJFBCnd_Msg.Text    := '';
end;

procedure TFCCenterJournalNetZkz.JCallSetClearCondition;
begin
  { Заказы обратных звонков и сообщений }
  edJCallCnd_Client.Text := '';
  edJCallCnd_Phone.Text  := '';
end;

{ Массовое управление доступом к элементам управления Slave-грида состав интернет-заказы}
procedure TFCCenterJournalNetZkz.SetStateAllControlSlave(bState : boolean);
begin
  { Выбор аптеки }
  pmiDBGridSlave_SlPharmacy.Enabled   := bState;
  tlbtnDBGridSlave_SlPharmacy.Enabled := bState;
  { Резервирование }
  aJSOSlave_ItemReserve.Enabled       := bState;
  aJSOSlave_OrderReserve.Enabled      := bState;
//  aJSOSlave_ClearArmor.Enabled        := bState;
//  aJSOSlave_CloseArmor.Enabled        := bState;
  { Товарная позиция }
  aJSOSlave_NewItem.Enabled           := bState;
  aJSOSlave_UpdItem.Enabled           := bState;
  aJSOSlave_DelItem.Enabled           := bState;
  { Отражение субразделов }
  aJSOSlave_Parts.Enabled             := bState;
  aJSOSlave_Term.Enabled              := bState;
end; { TFCCenterJournalNetZkz.SetStateAllControlSlave }

{ Массовое управление доступом к элементам управления Slave-грида история операций интернет-заказов}
procedure TFCCenterJournalNetZkz.SetStateAllControlSlaveHist(bState : boolean);
begin
  aJSOHist_ForcedFlosure.Enabled := bState;
end;


procedure TFCCenterJournalNetZkz.SetStateAllControlSlavePay(bState : boolean);
var
  NGroupPharm : integer;
begin
  NGroupPharm := OrderHeaderDS.FieldByName('NGeoGroupPharm').AsInteger;
  if NGroupPharm = 4 then begin
    aJSOPay_Add.Enabled  := bState;
    aJSOPay_Edit.Enabled := bState;
    aJSOPay_Del.Enabled  := bState;
    if qrspJSOPay.Active then begin
      if qrspJSOPay.IsEmpty then begin
        aJSOPay_Edit.Enabled := false;
        aJSOPay_Del.Enabled  := false;
        get_column_by_fieldname('NOrder',JSOGridPay).Visible := false;
      end else begin
        if (Length(ParentsList) <> 0) or (Length(SlavesList) <> 0) then begin
          if JSOGridPay.DataSource.DataSet.FieldByName('TypeRecPay').AsString = cJSOPayTypeUnion_Link then begin
            aJSOPay_Add.Enabled  := false;
            aJSOPay_Edit.Enabled := false;
            aJSOPay_Del.Enabled  := false;
            get_column_by_fieldname('NOrder',JSOGridPay).Visible := true;
          end else begin
            get_column_by_fieldname('NOrder',JSOGridPay).Visible := false;
          end;
        end;
      end;
    end;
  end else begin
    aJSOPay_Add.Enabled  := false;
    aJSOPay_Edit.Enabled := false;
    aJSOPay_Del.Enabled  := false;
    if (Length(ParentsList) <> 0) or (Length(SlavesList) <> 0) then begin
      if qrspJSOPay.Active then begin
        if not qrspJSOPay.IsEmpty then begin
          if JSOGridPay.DataSource.DataSet.FieldByName('TypeRecPay').AsString = cJSOPayTypeUnion_Link then begin
            get_column_by_fieldname('NOrder',JSOGridPay).Visible := true;
          end else begin
            get_column_by_fieldname('NOrder',JSOGridPay).Visible := false;
          end;
        end else begin
          get_column_by_fieldname('NOrder',JSOGridPay).Visible := false;
        end;
      end;
    end else begin
      get_column_by_fieldname('NOrder',JSOGridPay).Visible := false;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.JRMOSetStateAllControlSlaveItem(bState : boolean);
begin
  if qrspJRMOItem.Active then begin
    if qrspJRMOMain.IsEmpty then begin
      aJRMOSlaveItem_Ins.Enabled := false;
      aJRMOSlaveItem_Upd.Enabled := false;
      aJRMOSlaveItem_Del.Enabled := false;
    end else begin
      if qrspJRMOItem.IsEmpty then begin
        aJRMOSlaveItem_Ins.Enabled := bState;
        aJRMOSlaveItem_Upd.Enabled := false;
        aJRMOSlaveItem_Del.Enabled := false;
      end else begin
        aJRMOSlaveItem_Ins.Enabled := bState;
        aJRMOSlaveItem_Upd.Enabled := bState;
        aJRMOSlaveItem_Del.Enabled := bState;
      end;
    end;
  end else begin
    aJRMOSlaveItem_Ins.Enabled := false;
    aJRMOSlaveItem_Upd.Enabled := false;
    aJRMOSlaveItem_Del.Enabled := false;
  end;
end;

procedure TFCCenterJournalNetZkz.SetStateForcedFlosure;
var
  IErr            : integer;
  SignStateAction : smallint;
begin
  if qrspJSOHistory.Active then begin
    { Доступ к принудительному закрытию действия }
    if length(JSOGridHistory.DataSource.DataSet.FieldByName('SEndDate').AsString) = 0 then begin
      spAllowActionClose.Parameters.ParamValues['@Mode']   := 0; { Режим проверки }
      spAllowActionClose.Parameters.ParamValues['@RNHist'] := JSOGridHistory.DataSource.DataSet.FieldByName('NRN').AsInteger;
      spAllowActionClose.Parameters.ParamValues['@NUSER']  := Form1.id_user;
      spAllowActionClose.ExecProc;
      IErr := spAllowActionClose.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr = 0 then begin
        SignStateAction := spAllowActionClose.Parameters.ParamValues['@SignState'];
        if SignStateAction = 1
          then aJSOHist_ForcedFlosure.Enabled := true
          else aJSOHist_ForcedFlosure.Enabled := false;
      end else aJSOHist_ForcedFlosure.Enabled := false;
    end;
  end else aJSOHist_ForcedFlosure.Enabled := false;
end;

(* Управление доступом к действиям aJSOLink_* *)
procedure TFCCenterJournalNetZkz.ShowGetsEnable_ActionLink(SignDSEmpty : boolean; SignOrderClose : boolean);
begin
  if SignDSEmpty then begin
    aJSOLink_AddToOrder.Enabled        := false;
    aJSOLink_AddToMainRequest.Enabled  := false;
    aJSOLink_ClearAllUp.Enabled        := false;
    aJSOLink_ClearAllDown.Enabled      := false;
    aJSOLink_ClearOneUp.Enabled        := false;
    aJSOLink_ClearOneDown.Enabled      := false;
    aJSOLink_FindCurrentOrders.Enabled := false;
  end else begin
    if SignOrderClose then begin
      aJSOLink_AddToOrder.Enabled        := false;
      aJSOLink_AddToMainRequest.Enabled  := false;
      aJSOLink_ClearAllUp.Enabled        := false;
      aJSOLink_ClearAllDown.Enabled      := false;
      aJSOLink_ClearOneUp.Enabled        := false;
      aJSOLink_ClearOneDown.Enabled      := false;
      if (length(ParentsList) <> 0) or (length(SlavesList) <> 0)
        then aJSOLink_FindCurrentOrders.Enabled := true
        else aJSOLink_FindCurrentOrders.Enabled := false;
    end else begin
      aJSOLink_AddToOrder.Enabled        := true;
      aJSOLink_AddToMainRequest.Enabled  := true;
      if length(ParentsList) <> 0 then begin
        aJSOLink_ClearAllUp.Enabled := true;
        aJSOLink_ClearOneUp.Enabled := true;
      end else begin
        aJSOLink_ClearAllUp.Enabled := false;
        aJSOLink_ClearOneUp.Enabled := false;
      end;
      if length(SlavesList) <> 0 then begin
        aJSOLink_ClearAllDown.Enabled := true;
        aJSOLink_ClearOneDown.Enabled := true;
      end else begin
        aJSOLink_ClearAllDown.Enabled := false;
        aJSOLink_ClearOneDown.Enabled := false;
      end;
      if (length(ParentsList) <> 0) or (length(SlavesList) <> 0)
        then aJSOLink_FindCurrentOrders.Enabled := true
        else aJSOLink_FindCurrentOrders.Enabled := false;
    end;
  end;
  { Закрываем дествие aJSOLink_FindFavorites для большого периода }
  if (DaysBetween(dtCndEnd.Date,dtCndBegin.Date) > 60) or (not chbxCndAccountPeriod.Checked)
    then aJSOLink_FindFavorites.Enabled := false
    else aJSOLink_FindFavorites.Enabled := true;
end;

(* Полный анализ и установка доступности, видимости полей и т.п.       *)
(* Как правило, нужно вызывать в конце каждой обработки любого события *)
procedure TFCCenterJournalNetZkz.ShowGets;
var
  StateArmour         : integer;
  IdDocBell           : integer;
  SignState           : integer;
  SCaption            : string;
  ICaption            : integer;
  SGroupPharm         : string;
  SErr                : string;
  IErr                : integer;
  EN_NPost            : string;
  EN_State            : string;
  InfoLink            : string;
  SNameDriver         : string;
  SDateDriver         : string;
  SDateReceived       : string;
  SChildDateReceived  : string;
  orderPayment        : string;
  IsOrderPaySysPaid   : Boolean;
  vIsActionOrder      : Boolean;
  B, B1: Boolean;
begin
  aBPSpecRef.Enabled := Form1.id_user = 311;
  { Статус-строка }
  //ShowStatuBarStandart;
  { Доступ к периоду даты заказа в зависимости от вида контрольного периода }
  if JSOCondRec.SignOrderPeriod = 0 then begin
    dtCndBegin.Enabled := true;
    dtCndEnd.Enabled   := true;
  end else begin
    dtCndBegin.Enabled := false;
    dtCndEnd.Enabled   := false;
  end;
  { Доступ к очистке условия отбора }
  if    GetStateClearMainCondition
    and GetStateClearSlaveCondition
    and GetStateClearHistCondition
    and GetStateClearPayCondition
    and GetStateClearNPostPayCondition then begin
    aMain_ConditionClear.Enabled := false;
  end else begin
    aMain_ConditionClear.Enabled := true;
  end;
  vIsActionOrder := IsActionOrder;
  //************************* Меняем горячие клавиши ********************
  if (trim(OrderHeaderDS.FieldByName('OrderShipping').AsString) = 'Курьерская доставка') or
     (trim(OrderHeaderDS.FieldByName('OrderShipping').AsString) = 'Новая почта') or
     (OrderHeaderDS.FieldByName('ExecSign').AsInteger = 1) 
  then
  begin
    aMain_OrderStatus.ShortCut := 0;
    aAction.ShortCut := ShortCut(VK_F3,[]);
  end else
  begin
    aMain_OrderStatus.ShortCut := ShortCut(VK_F3,[]);
    aAction.ShortCut := 0;
  end;

  { Примечание: вообще-то в этом поле NULL. Delphi интерпретирует в ноль }
  if OrderHeaderDS.FieldByName('aptekaID').AsInteger = 0 then begin
    { Видимость закладки Платежи }
    tabSlave_Pay.TabVisible := true;
    { Видимость закладки НОВАЯ ПОЧТА }
    EN_State := '';
    EN_NPost := OrderHeaderDS.FieldByName('SDispatchDeclaration').AsString;
    if OrderHeaderDS.FieldByName('NPOST_StateID').AsInteger > 0 then begin
      EN_State := ', ' +
                  OrderHeaderDS.FieldByName('SNPOST_StateName').AsString + ' ' +
                  AsString(OrderHeaderDS, 'DNPOST_StateDate');
    end;
    if length(EN_NPost) <> 0 then begin
      tabSlave_NPost.TabVisible := true;
      tabSlave_NPost.Caption := 'Новая почта (' + EN_NPost + EN_State + ')';
      if qrspJSONpost.IsEmpty
        then aJSOSlaveNPost_HistStateDate.Enabled := false
        else aJSOSlaveNPost_HistStateDate.Enabled := true;
    end else tabSlave_NPost.TabVisible := false;
    { Видимость закладки НОВАЯ ПОЧТА - наложенные платежи }
    SDateReceived := AsString(OrderHeaderDS, 'DDateReceived');
    SChildDateReceived := AsString(OrderHeaderDS, 'DChildDateReceived');
    if length(SDateReceived) > 0 then begin
      tabSlave_NPostPay.TabVisible := true;
      tabSlave_NPostPay.Caption := 'Новая почта (наложенные платежи). Оплачено: ' + SDateReceived + ', Получено: ' + SChildDateReceived
    end else tabSlave_NPostPay.TabVisible := false;
    { Видимость поля Аптека, ISIgnModeReserve, ISignDistribute, SDistributeCount  в slave-таблице }
    get_column_by_fieldname('SApteka',DBGridSlave).Visible := true;
    get_column_by_fieldname('ISIgnModeReserve',DBGridSlave).Visible := true;
    get_column_by_fieldname('ISignDistribute',DBGridSlave).Visible := true;
    get_column_by_fieldname('SDistributeCount',DBGridSlave).Visible := true;
    get_column_by_fieldname('NitemArmourQuantity',DBGridSlave).Visible := false;
    get_column_by_fieldname('NitemArmourAllQty',DBGridSlave).Visible := false;
    get_column_by_fieldname('NNotArmourQty',DBGridSlave).Visible := false;
    get_column_by_fieldname('NitemArmAddQty',DBGridSlave).Visible := false;
    { Нельзя привязать заказ к аптеке }
    aMain_UpdPharmacy.Enabled := false;
    { Недоступна команда бронирования 1-го типа }
    aMain_jso_ArmorCheck.Enabled := false;
    aMain_jso_ArmorExec.Enabled := false;
    { Доступ к определению группы аптек }
    aMain_GroupPharm.Enabled := not vIsActionOrder;
    { Отправка уведомлений клиентам }
    aSendNotificationClient.Enabled := true;
    { Синхронизация статуса оплаты }
    aSyncStatusPay.Enabled := false;
  end else begin
    { Видимость закладки Платежи }
    tabSlave_Pay.TabVisible := false;
    { Видимость закладки НОВАЯ ПОЧТА }
    tabSlave_NPost.TabVisible := false;
    tabSlave_NPostPay.TabVisible := false;
    { Видимость поля Аптека, ISIgnModeReserve в slave-таблице }
    get_column_by_fieldname('SApteka',DBGridSlave).Visible := false;
    get_column_by_fieldname('ISIgnModeReserve',DBGridSlave).Visible := false;
    get_column_by_fieldname('ISignDistribute',DBGridSlave).Visible := false;
    get_column_by_fieldname('SDistributeCount',DBGridSlave).Visible := false;
    { Доступна команда бронирования 1-го типа }
    aMain_jso_ArmorCheck.Enabled := true;
    aMain_jso_ArmorExec.Enabled := true;
    { В зависимости от наличия брони на заказе }
    if OrderHeaderDS.FieldByName('ID_IPA_DhRes').AsInteger = 0 then begin
      aMain_UpdPharmacy.Enabled := true;
    end else begin
      aMain_UpdPharmacy.Enabled := false;
    end;
    { В зависимости от состояния заказа }
    StateArmour := OrderHeaderDS.FieldByName('IStateArmour').AsInteger;
    if (StateArmour = 0) or (StateArmour = 3) then begin
      tlbtnDBGridMain_CurrentAmount.Action := aMain_jso_ArmorExec;
      pmiDBGridMain_CurrentAmount.Action   := aMain_jso_ArmorExec;
    end else begin
      tlbtnDBGridMain_CurrentAmount.Action := aMain_jso_ArmorCheck;
      pmiDBGridMain_CurrentAmount.Action   := aMain_jso_ArmorCheck;
    end;
    { Доступ к определению группы аптек }
    aMain_GroupPharm.Enabled := false;
    { Отправка уведомлений клиентам }
    aSendNotificationClient.Enabled := false;
  end;
  B1 := (OrderHeaderDS.FieldByName('SrcSystem').AsInteger = 4);
  B :=  B1 or
         (OrderHeaderDS.FieldByName('ExecSign').AsInteger = 1);
  get_column_by_fieldname('NitemArmourQuantity',DBGridSlave).Visible := B1;
  get_column_by_fieldname('NitemArmourAllQty',DBGridSlave).Visible := B;
  get_column_by_fieldname('NNotArmourQty',DBGridSlave).Visible := B;
  get_column_by_fieldname('NitemArmAddQty',DBGridSlave).Visible := B1;
  get_column_by_fieldname('NitemArmourQuantity',DBGridSlaveDistrib).Visible := B;
  get_column_by_fieldname('NNotArmourQty',DBGridSlaveDistrib).Visible := B;

  //Транзакции
  orderPayment := OrderHeaderDS.FieldByName('orderPayment').AsString;

  //Заказ оплачиваем ч/з платежную систему на сайте
  IsOrderPaySysPaid := (AnsiUpperCase(Trim(orderPayment)) = 'PAYMASTER');

  tabSlave_PayTransaction.TabVisible := IsOrderPaySysPaid;

  { Доступ к элементам меню и кнопкам если GRID не пустой}
  if not qrMain.IsEmpty then begin { main-grid не пустой }

    { Определяем состояние заказа: открыт или закрыт }
    aAction.Enabled := true;
    aMain_OrderClose.Enabled := true;
    aMain_OrderOpen.Enabled := true;
    aFilterOrdersByPhone.Enabled := true;
    if not VarIsAssigned(OrderHeaderDS.FieldByName('DCloseDate').Value) then
    begin
      SignState := csStateOpen;
      tlbtnDBGridMain_DefState.Action := aMain_OrderClose;
      pmiDBGridMain_State.Action := aMain_OrderClose;
    end else
    begin
      SignState := csStateClose;
      tlbtnDBGridMain_DefState.Action := aMain_OrderOpen;
      pmiDBGridMain_State.Action := aMain_OrderOpen;
    end;
    aJSOSlave_ClearArmor.Enabled := (SignState = csStateOpen);
    aJSOSlave_CloseArmor.Enabled := aJSOSlave_ClearArmor.Enabled;
    aCheckReserve.Enabled := aJSOSlave_ClearArmor.Enabled;
    aMain_OrderHeaderItem_Upd.Enabled := true;
    aMain_OrderHeaderItem_Info.Enabled := true;

    { Отображаем водителя и связанные заказы }
    InfoLink := '';
    JSOGetDriver(SNameDriver,SDateDriver);
    if length(SNameDriver) <> 0 then InfoLink := 'Водитель:  ' + SNameDriver + '; ';
    { Определяем списки родительских и дополнительных заказов }
    ParentsList := '';
    SlavesList  := '';
    if OrderHeaderDS.FieldByName('NParentOrderID').AsInteger <> 0 then begin
      { Получаем вышестоящие заказы }
      DM_CCJSO.JSOParentsList(
                              UserSession.CurrentUser,
                              OrderHeaderDS.FieldByName('orderID').AsInteger,
                              ParentsList, IErr, SErr
                             );
      if length(ParentsList) <> 0 then begin
        if length(InfoLink) <> 0 then begin
          InfoLink := InfoLink + ' Родительские заказы: ' + ParentsList + ' ';
        end else begin
          InfoLink := 'Родительские заказы: ' + ParentsList + ' ';
        end;
      end;
    end;
    { Получаем нижестоящие заказы }
    DM_CCJSO.JSOSlavesList(
                            UserSession.CurrentUser,
                            OrderHeaderDS.FieldByName('orderID').AsInteger,
                            SlavesList, IErr, SErr
                           );
    if length(SlavesList) <> 0 then begin
      if length(InfoLink) <> 0 then begin
        InfoLink := InfoLink + ' Дополнительные заказы: ' + SlavesList + ' ';
      end else begin
        InfoLink := 'Дополнительные заказы: ' + SlavesList + ' ';
      end;
    end;
    pnlSlave_Order_InfoLink.Caption := InfoLink;

    if (SignState = csStateOpen) {and (not IsOrderPaySysPaid)} then  { Заказ открыт }
    begin
      aMain_RP_Zakaz.Enabled := true;
      aMain_RecalcZakaz.Enabled := true;
      ShowGetsEnable_ActionLink(false,false);
      { Черный список }
      if not VarIsAssigned(OrderHeaderDS.FieldByName('DBlackListDate').Value) then begin
        aJSOBlackList_Add.Enabled   := true;
        aJSOBlackList_Close.Enabled := false;
      end else begin
        aJSOBlackList_Add.Enabled   := false;
        aJSOBlackList_Close.Enabled := true;
      end;
      {Закрытие брони}
      aJSOSlave_ClearArmor.Enabled := true;
      aJSOSlave_CloseArmor.Enabled := true;
      aCheckReserve.Enabled := true;
      { Синхронизация статуса оплаты }
      aSyncStatusPay.Enabled := IsOrderPaySysPaid;
      { Управление доступом к элементам управления Slave-грида }
      if qrspSlave.RecordCount = 0 then begin { slave-grid пустой }
        { Отключаем доступ к элементам управления Slave-грида }
        SetStateAllControlSlave(false);
      end else begin { slave-grid не пустой }
        { Дополнительный контроль доступа к элементам управления Slave-грида }
        if (OrderHeaderDS.FieldByName('aptekaID').AsInteger = 0) and (OrderHeaderDS.FieldByName('BPId').AsInteger in [1, 2]) then begin
          SetStateAllControlSlave(true);
          { Доступ к экспорту заказа в 1С }
          aMain_ExportOrder1C.Enabled := true;
          { Доступ к определению водителя по доставке заказа }
          aMain_SetDriver.Enabled := true;
        end else begin
          SetStateAllControlSlave(false);
          { Доступ к экспорту заказа в 1С }
          aMain_ExportOrder1C.Enabled := false;
          { Доступ к определению водителя по доставке заказа }
          aMain_SetDriver.Enabled := false;
        end;
        { Уточнение доступа к <Товар по частям> }
        if DBGridSlave.DataSource.DataSet.FieldByName('ISignDivideParts').AsInteger = 1
          then aJSOSlave_Parts.Enabled := true
          else aJSOSlave_Parts.Enabled := false;
        { Уточнение доступа к <Сроковый товар> }
        if DBGridSlave.DataSource.DataSet.FieldByName('ISignArmorTerm').AsInteger = 1
          then aJSOSlave_Term.Enabled := true
          else aJSOSlave_Term.Enabled := false
        { Уточнение доступа к действиям по товарной позиции }
      end; { Управление доступом к элементам управления Slave-грида }

      { Управление доступом к редактированию заголовком заказа }
      if    (OrderHeaderDS.FieldByName('aptekaID').AsInteger = 0)
        and not VarIsAssigned(OrderHeaderDS.FieldByName('DCloseDate').Value) then begin
        pmiJSO_HeaderItem.Action := aMain_OrderHeaderItem_Upd;
        pmiDBGridMain_OrderHeaderItem_Upd.Action := aMain_OrderHeaderItem_Upd;
      end else begin
        pmiJSO_HeaderItem.Action := aMain_OrderHeaderItem_Info;
        pmiDBGridMain_OrderHeaderItem_Upd.Action := aMain_OrderHeaderItem_Info;
      end;


      { Признак наличия звонка }
      aMain_SignBell.Enabled := true;//not vIsActionOrder;
      { Доступ к маркерам даты}
      if not VarIsAssigned(OrderHeaderDS.FieldByName('DBellDate').Value)
        then aMain_MarkDateBell.Enabled := not vIsActionOrder
        else aMain_MarkDateBell.Enabled := false;
      if not VarIsAssigned(OrderHeaderDS.FieldByName('DSMSDate').Value)
        then aMain_MarkDateSMS.Enabled := not vIsActionOrder
        else aMain_MarkDateSMS.Enabled := false;
      if not VarIsAssigned(OrderHeaderDS.FieldByName('DPayDate').Value)
        then aMain_MarkDatePay.Enabled := not vIsActionOrder
        else aMain_MarkDatePay.Enabled := false;
      {if length(OrderHeaderDS.FieldByName('SAssemblingDate').AsString) = 0
        then aMain_MarkDateAssembling.Enabled := true
        else aMain_MarkDateAssembling.Enabled := false;}
      aMain_MarkDateAssembling.Enabled := not vIsActionOrder and
        not VarIsAssigned(OrderHeaderDS.FieldByName('DAssemblingDate').Value);

      { Доступ к остальным маркерам }
      aMain_PlanDateSend.Enabled := not vIsActionOrder;
      aMain_MarkDispatchDeclaration.Enabled := not vIsActionOrder;
      aMain_MarkNote.Enabled := not vIsActionOrder;
      { Доступ к определению статуса заказа }
      aMain_OrderStatus.Enabled := not vIsActionOrder;
      { ИСТОРИЯ ОПЕРАЦИЙ Управление доступом к элементам управления Slave-грида }
      if qrspJSOHistory.Active then begin
        if qrspJSOHistory.RecordCount = 0 then begin { история операций slave-grid пустой }
          { Отключаем доступ к элементам управления Slave-грида }
          SetStateAllControlSlaveHist(false);
        end else begin { slave-grid не пустой }
          SetStateAllControlSlaveHist(false);
          { Уточняем доступ к принудительному закрытию действия }
          SetStateForcedFlosure;
        end; { ИСТОРИЯ ОПЕРАЦИЙ Управление доступом к элементам управления Slave-грида }
      end;
      { Управление панелями механизма <Мои заказы> }
      pnlMain_Control_MyOrder_Tool.Visible := true;
      if OrderHeaderDS.FieldByName('aptekaID').AsInteger = 0 then begin
        { Без аптеки в заголовке заказа }
        if not VarIsAssigned(OrderHeaderDS.FieldByName('DMarkDate').Value) then begin
          { Заказ не избран }
          pnlMain_Control_MyOrder_User.Visible := false;
          pnlMain_Control_MyOrder.Width := pnlMain_Control_MyOrder_Tool.Width;
          aJSOMark.Enabled := true;
          tlbtnJSOMark.Action := aJSOMark;
          pmiDBGridMain_MyOrders_Mark.Action := aJSOMark;
          aJSOMarkForOthers.Enabled := false;
          pnlMain_Control.Width := pnlMain_Control_MyOrder.Width + pnlMain_Control_Show.Width;
        end else begin
          { Избранный заказ }
          if RegAction.NUSER = OrderHeaderDS.FieldByName('NMarkUser').AsInteger then begin
            { Мой заказ }
            pnlMain_Control_MyOrder_User.Visible := false;
            pnlMain_Control_MyOrder.Width := pnlMain_Control_MyOrder_Tool.Width;
            aJSOMark.Enabled := true;
            tlbtnJSOMark.Action := aJSOMarkClear;
            pmiDBGridMain_MyOrders_Mark.Action := aJSOMarkClear;
            aJSOMarkForOthers.Enabled := true;
            pnlMain_Control.Width := pnlMain_Control_MyOrder.Width + pnlMain_Control_Show.Width;
          end else begin
            { Чужой заказ }
            pnlMain_Control_MyOrder.Width := pnlMain_Control_MyOrder_Tool.Width;
            aJSOMark.Enabled := false;
            tlbtnJSOMark.Action := aJSOMark;
            pmiDBGridMain_MyOrders_Mark.Action := aJSOMark;
            aJSOMarkForOthers.Enabled := false;
            SCaption := OrderHeaderDS.FieldByName('SMarkUser').AsString;
            ICaption := TextPixWidth(SCaption, pnlMain_Control_MyOrder_User_Name.Font) + 5;
            pnlMain_Control.Width :=   pnlMain_Control_MyOrder_Tool.Width + ICaption
                                     + pnlMain_Control_MyOrder_User_Img.Width
                                     + pnlMain_Control_Show.Width;
            pnlMain_Control_MyOrder.Width :=    pnlMain_Control_MyOrder_Tool.Width + ICaption
                                              + pnlMain_Control_MyOrder_User_Img.Width;
            pnlMain_Control_MyOrder_User.Width := ICaption + pnlMain_Control_MyOrder_User_Img.Width;
            pnlMain_Control_MyOrder_User_Name.Caption  := SCaption;
            pnlMain_Control_MyOrder_User.Visible := true;
          end;
        end;
      end else begin
        { Аптека в заголовке заказа - Управление панелями механизма <Мои заказы> }
        pnlMain_Control_MyOrder_User.Visible := false;
        pnlMain_Control_MyOrder.Width := pnlMain_Control_MyOrder_Tool.Width;
        aJSOMark.Enabled := false;
        tlbtnJSOMark.Action := aJSOMark;
        pmiDBGridMain_MyOrders_Mark.Action := aJSOMark;
        aJSOMarkForOthers.Enabled := false;
        pnlMain_Control.Width := pnlMain_Control_MyOrder.Width + pnlMain_Control_Show.Width;
      end;

    end else begin { Заказ закрыт  }

      aMain_RP_Zakaz.Enabled := true;
      { Отключаем доступ к управлению }
      aMain_jso_ArmorCheck.Enabled := false;
      aMain_jso_ArmorExec.Enabled := false;
      aMain_UpdPharmacy.Enabled := false;
      aMain_RecalcZakaz.Enabled := false;
      aSyncStatusPay.Enabled := false;
      ShowGetsEnable_ActionLink(false,true);
      //Закрытие брони
      aJSOSlave_ClearArmor.Enabled := false;
      aJSOSlave_CloseArmor.Enabled := false;
      aCheckReserve.Enabled := false;
      { Черный список }
      aJSOBlackList_Add.Enabled   := false;
      aJSOBlackList_Close.Enabled := false;
      { Признак, что звонили }
      aMain_SignBell.Enabled := false;
      { Управление доступом к редактированию заголовком заказа }
      pmiJSO_HeaderItem.Action := aMain_OrderHeaderItem_Info;
      pmiDBGridMain_OrderHeaderItem_Upd.Action := aMain_OrderHeaderItem_Info;
      { Доступ к маркерам }
      aMain_MarkDateBell.Enabled       := false;
      aMain_MarkDateSMS.Enabled        := false;
      aMain_MarkDatePay.Enabled        := false;
      aMain_MarkDateAssembling.Enabled := false;
      aMain_PlanDateSend.Enabled       := false;
      aMain_MarkDispatchDeclaration.Enabled := false;
      aMain_MarkNote.Enabled := false;
      { Черный список }
      aJSOBlackList_Add.Enabled   := false;
      aJSOBlackList_Close.Enabled := false;
      { Доступ к экспорту заказа в 1С }
      aMain_ExportOrder1C.Enabled := false;
      { Доступ к определению водителя по доставке заказа }
      aMain_SetDriver.Enabled := false;
      { Отключаем доступ к элементам управления Slave-грида }
      SetStateAllControlSlave(false);
      SetStateAllControlSlaveHist(false);
      { Уточняем доступ к принудительному закрытию действия }
      SetStateForcedFlosure;
      { Уточнение доступа к <Товар по частям> }
      if DBGridSlave.DataSource.DataSet.FieldByName('ISignDivideParts').AsInteger = 1
        then aJSOSlave_Parts.Enabled := true
        else aJSOSlave_Parts.Enabled := false;
      { Уточнение доступа к <Сроковый товар> }
      if DBGridSlave.DataSource.DataSet.FieldByName('ISignArmorTerm').AsInteger = 1
        then aJSOSlave_Term.Enabled := true
        else aJSOSlave_Term.Enabled := false;
      { Доступ к определению статуса заказа }
      aMain_OrderStatus.Enabled := false;
      { Управление панелями механизма <Мои заказы> }
      pnlMain_Control_MyOrder_Tool.Visible := true;
      if OrderHeaderDS.FieldByName('aptekaID').AsInteger = 0 then begin
        { Без аптеки в заголовке заказа }
        if not VarIsAssigned(OrderHeaderDS.FieldByName('DMarkDate').Value) then begin
          { Заказ не избран }
          pnlMain_Control_MyOrder_User.Visible := false;
          pnlMain_Control_MyOrder.Width := pnlMain_Control_MyOrder_Tool.Width;
          aJSOMark.Enabled := false;
          tlbtnJSOMark.Action := aJSOMark;
          pmiDBGridMain_MyOrders_Mark.Action := aJSOMark;
          aJSOMarkForOthers.Enabled := false;
          pnlMain_Control.Width := pnlMain_Control_MyOrder.Width + pnlMain_Control_Show.Width;
        end else begin
          { Избранный заказ }
          if RegAction.NUSER = OrderHeaderDS.FieldByName('NMarkUser').AsInteger then begin
            { Мой заказ }
            pnlMain_Control_MyOrder_User.Visible := false;
            pnlMain_Control_MyOrder.Width := pnlMain_Control_MyOrder_Tool.Width;
            aJSOMark.Enabled := false;
            tlbtnJSOMark.Action := aJSOMarkClear;
            pmiDBGridMain_MyOrders_Mark.Action := aJSOMarkClear;
            aJSOMarkForOthers.Enabled := true;
            pnlMain_Control.Width := pnlMain_Control_MyOrder.Width + pnlMain_Control_Show.Width;
          end else begin
            { Чужой заказ }
            pnlMain_Control_MyOrder.Width := pnlMain_Control_MyOrder_Tool.Width;
            aJSOMark.Enabled := false;
            tlbtnJSOMark.Action := aJSOMark;
            pmiDBGridMain_MyOrders_Mark.Action := aJSOMark;
            aJSOMarkForOthers.Enabled := false;
            SCaption := OrderHeaderDS.FieldByName('SMarkUser').AsString;
            ICaption := TextPixWidth(SCaption, pnlMain_Control_MyOrder_User_Name.Font) + 5;
            pnlMain_Control.Width :=   pnlMain_Control_MyOrder_Tool.Width + ICaption
                                     + pnlMain_Control_MyOrder_User_Img.Width
                                     + pnlMain_Control_Show.Width;
            pnlMain_Control_MyOrder.Width :=    pnlMain_Control_MyOrder_Tool.Width + ICaption
                                              + pnlMain_Control_MyOrder_User_Img.Width;
            pnlMain_Control_MyOrder_User.Width := ICaption + pnlMain_Control_MyOrder_User_Img.Width;
            pnlMain_Control_MyOrder_User_Name.Caption  := SCaption;
            pnlMain_Control_MyOrder_User.Visible := true;
          end;
        end;
      end else begin
        { Аптека в заголовке заказа - Управление панелями механизма <Мои заказы> }
        pnlMain_Control_MyOrder_User.Visible := false;
        pnlMain_Control_MyOrder.Width := pnlMain_Control_MyOrder_Tool.Width;
        aJSOMark.Enabled := false;
        tlbtnJSOMark.Action := aJSOMark;
        pmiDBGridMain_MyOrders_Mark.Action := aJSOMark;
        aJSOMarkForOthers.Enabled := false;
        pnlMain_Control.Width := pnlMain_Control_MyOrder.Width + pnlMain_Control_Show.Width;
      end;

    end;

    if OrderHeaderDS.FieldByName('aptekaID').AsInteger = 0 then begin
      { Доступ к командам формирования платежей }
      SetStateAllControlSlavePay(true);
    end else begin
      { Доступ к командам формирования платежей }
      SetStateAllControlSlavePay(false);
    end;

  end else begin { main-grid пустой }

    aMain_jso_ArmorCheck.Enabled := false;
    aMain_jso_ArmorExec.Enabled := false;
    aMain_UpdPharmacy.Enabled := false;
    aMain_RP_Zakaz.Enabled := false;
    aMain_SignBell.Enabled := false;
    aMain_OrderHeaderItem_Upd.Enabled := false;
    aMain_OrderHeaderItem_Info.Enabled := false;
    {--}
    ParentsList := '';
    SlavesList  := '';
    ShowGetsEnable_ActionLink(true,true);
    InfoLink := '';
    pnlSlave_Order_InfoLink.Caption := InfoLink;
    { Доступ к маркерам даты}
    aMain_MarkDateBell.Enabled       := false;
    aMain_MarkDateSMS.Enabled        := false;
    aMain_MarkDatePay.Enabled        := false;
    aMain_MarkDateAssembling.Enabled := false;
    aMain_PlanDateSend.Enabled       := false;
    { Черный список }
    aJSOBlackList_Add.Enabled   := false;
    aJSOBlackList_Close.Enabled := false;
    { Доступ к действиям состояния заказа }
    aAction.Enabled := false;
    aMain_OrderClose.Enabled := false;
    aMain_OrderOpen.Enabled := false;
    aFilterOrdersByPhone.Enabled := false;
    { Доступ к экспорту заказа в 1С }
    aMain_ExportOrder1C.Enabled := false;
    { Доступ к определению водителя по доставке заказа }
    aMain_SetDriver.Enabled := false;
    { Доступ к определению статуса заказа }
    aMain_OrderStatus.Enabled := false;
    { Отключаем доступ к элементам управления Slave-грида }
    SetStateAllControlSlave(false);
    SetStateAllControlSlaveHist(false);
    SetStateAllControlSlavePay(false);
    { Не показываем панели управления механизма <Мои заказы> }
    pnlMain_Control_MyOrder_Tool.Visible := false;
    pnlMain_Control_MyOrder_User.Visible := false;
    pnlMain_Control_MyOrder.Width := 20;
    { Дополнительные команды }
    aSendNotificationClient.Enabled := false;
  end;

  { Вкл/выкл надписей на кнопках }
  toolbrMainGrid.ShowCaptions  := pmiToolBar_ShowCption.Checked;
  toolbrMainGrid.Flat          := pmiToolBar_ShowCption.Checked;
  toolbrSlaveGrid.ShowCaptions := pmiToolBar_ShowCption.Checked;
  toolbrSlaveGrid.Flat         := pmiToolBar_ShowCption.Checked;
  toolbrJSO_Hist.ShowCaptions  := pmiToolBar_ShowCption.Checked;
  toolbrJSO_Hist.Flat          := pmiToolBar_ShowCption.Checked;
  if pmiToolBar_ShowCption.Checked then begin
    pnlMain.Height          := 26;
    pnlSlave_Order.Height   := 26;
    pnlSlave_History.Height := 26;
  end else begin
    pnlMain.Height          := 30;
    pnlSlave_Order.Height   := 30;
    pnlSlave_History.Height := 30;
  end;
  { Отображение количества товарных позиций в заказе }
  SCaption := 'Позиций в заказе: ' + VarToStr(qrspSlave.RecordCount);
  pnlSlave_Order_Right.Caption := SCaption;
  pnlSlave_Order_Right.Width := TextPixWidth(SCaption, pnlSlave_Order_Right.Font) + 20;
  { Количество операций в истории }
  if qrspJSOHistory.Active then begin
    SCaption := 'Операций: ' + VarToStr(qrspJSOHistory.RecordCount);
    pnlSlave_History_Show.Caption := SCaption;
    pnlSlave_History_Show.Width := TextPixWidth(SCaption, pnlSlave_History_Show.Font) + 20;
  end;
  { Количество платежей }
  if qrspJSOPay.Active then begin
    SCaption := 'Платежей: ' + VarToStr(qrspJSOPay.RecordCount);
    pnlSlave_Pay_Show.Caption := SCaption;
    pnlSlave_Pay_Show.Width := TextPixWidth(SCaption, pnlSlave_Pay_Show.Font) + 20;
  end;
  { Количество зарегистрированных изменений состояний ЕН }
  if qrspJSONPost.Active then begin
    SCaption := VarToStr(qrspJSONPost.RecordCount);
    pnlSlave_NPostControl_Show.Caption := SCaption;
    pnlSlave_NPostControl_Show.Width := TextPixWidth(SCaption, pnlSlave_NPostControl_Show.Font) + 20;
  end;
  { Количество отобранных заказов }
  SCaption := 'Заказов: ' + VarToStr(qrMain.RecordCount);
  pnlMain_Control_Show.Caption  := SCaption; pnlMain_Control_Show.Width := TextPixWidth(SCaption, pnlMain_Control_Show.Font) + 10;
  { Красиво размещаем панели }
  pnlMain_Control_MyOrder.Align := alLeft;
  pnlMain_Control_Show.Left := pnlMain_Control.Width - pnlMain_Control_Show.Width;
  pnlMain_Control_MyOrder.Align := alRight;
  {--}
  SCaption := '';
  ICaption := 0;
  { Отображение группы аптеки }
  SGroupPharm := OrderHeaderDS.FieldByName('SGroupPharmName').AsString;
  if length(SGroupPharm) > 0 then begin
    SCaption := 'Группа: ' + SGroupPharm;
    ICaption := 20;
  end;
  { Отображение, что заказ собран на торговой точке }
  if VarIsAssigned(OrderHeaderDS.FieldByName('DPharmAssemblyDate').Value) then
  begin
    SCaption := trim(SCaption + '  Собран на ТТ ' + AsString(OrderHeaderDS, 'DPharmAssemblyDate'));
    ICaption := 20;
  end;
  pnlSlave_Order_Center.Caption  := SCaption; pnlSlave_Order_Center.Width := TextPixWidth(SCaption, pnlSlave_Order_Center.Font) + ICaption;

end; (* TFCCenterJournalNetZkz.ShowGets *)

procedure TFCCenterJournalNetZkz.JRMOShowGets;
var
  SignState : integer;
begin
  if IJRMOSign_Active = 1 then begin

    { Доступ к элементам меню и кнопкам если GRID не пустой}
    if not qrspJRMOMain.IsEmpty then begin { main-grid не пустой }

      { Доступ к действиям состояния заказа }
      aJRMOMain_OrderClose.Enabled := true;
      aJRMOMain_OrderOpen.Enabled := true;
      { Доступ к определению статуса заказа }
      aJRMOMain_Status.Enabled := true;
      { Доступ к действиям панели инструментов товарных позиций заказа }
      JRMOSetStateAllControlSlaveItem(True);

      { Управление действиями по сотоянию заказа }
      if length(JRMOGridMain.DataSource.DataSet.FieldByName('SCloseDate').AsString) = 0 then begin
        SignState := csStateOpen;
        tlbtnJRMOMain_State.Action := aJRMOMain_OrderClose;
        pmiJRMOMain_State.Action   := aJRMOMain_OrderClose;
      end else begin
        SignState := csStateClose;
        tlbtnJRMOMain_State.Action := aJRMOMain_OrderOpen;
        pmiJRMOMain_State.Action   := aJRMOMain_OrderOpen;
      end;

      { Управление доступом для закрытого заказа }
      if SignState = csStateClose then begin
        { Доступ к определению статуса заказа }
        aJRMOMain_Status.Enabled := False;
        { Доступ к действиям панели инструментов товарных позиций заказа }
        JRMOSetStateAllControlSlaveItem(False);
      end;

    end else begin { пустой main-grid }

      { Доступ к действиям состояния заказа }
      aJRMOMain_OrderClose.Enabled := False;
      aJRMOMain_OrderOpen.Enabled := False;
      { Доступ к определению статуса заказа }
      aJRMOMain_Status.Enabled := False;
      { Доступ к действиям панели инструментов товарных позиций заказа }
      JRMOSetStateAllControlSlaveItem(False);

    end;

    { Вкл/выкл надписей на кнопках }
    tlbarJRMOMain.ShowCaptions       := pmiToolBar_ShowCption.Checked;
    tlbarJRMOMain.Flat               := pmiToolBar_ShowCption.Checked;
    tlbarJRMOSlaveItem.ShowCaptions  := pmiToolBar_ShowCption.Checked;
    tlbarJRMOSlaveItem.Flat          := pmiToolBar_ShowCption.Checked;
    {tlbarJRMOSlave_Hist.ShowCaptions := pmiToolBar_ShowCption.Checked;}
    {tlbarJRMOSlave_Hist.Flat         := pmiToolBar_ShowCption.Checked;}
    if pmiToolBar_ShowCption.Checked then begin
      pnlJRMOMainControl.Height := 26;
      pnlJRMOSlave_Armour_Control.Height := 26;
      {pnlJRMOSlaveControl_Hist.Height := 26;}
    end else begin
      pnlJRMOMainControl.Height := 30;
      pnlJRMOSlave_Armour_Control.Height := 30;
      {pnlJRMOSlaveControl_Hist.Height := 30;}
    end;
    { Отображение количества записей }
    pnlJRMOMainControl_Show.Caption  := 'Заказов: ' + VarToStr(qrspJRMOMain.RecordCount);
    if qrspJRMOHist.Active then
      pnlJRMOSlaveControl_Hist_Show.Caption  := 'Операций: ' + VarToStr(qrspJRMOHist.RecordCount);
    { Доступ к очистке условия отбора }
    if JRMOGetStateClearMainCondition
      then aJRMOMain_ClearCondition.Enabled := false
      else aJRMOMain_ClearCondition.Enabled := true;

  end;
end;

procedure TFCCenterJournalNetZkz.JFBShowGets;
var
  INumbTypeMessage : smallint;
begin
  if IJFBSign_Active = 1 then begin
    { Вкл/выкл надписей на конопках }
    tlbarJFBMain.ShowCaptions  := pmiToolBar_ShowCption.Checked;
    tlbarJFBMain.Flat          := pmiToolBar_ShowCption.Checked;
    {tlbarJFBSlave_Hist.ShowCaptions := pmiToolBar_ShowCption.Checked;}
    {tlbarJFBSlave_Hist.Flat         := pmiToolBar_ShowCption.Checked;}
    if pmiToolBar_ShowCption.Checked
      then begin pnlJFBMainControl.Height := 26; {pnlJFBSlaveControl_Hist.Height := 26;} end
      else begin pnlJFBMainControl.Height := 30; {pnlJFBSlaveControl_Hist.Height := 30;} end;
    { Отображение количества записей }
    pnlJFBMainControl_Show.Caption  := 'Обращений: ' + VarToStr(qrspJFBMain.RecordCount);
    { Доступ к очистке условия отбора }
    if JFBGetStateClearMainCondition
      then aJFBMain_ClearCondition.Enabled := false
      else aJFBMain_ClearCondition.Enabled := true;
    { Доступ к элементам управления обработки сообщения}
    INumbTypeMessage := JFBGridMain.DataSource.DataSet.FieldByName('INumbTypeMessage').AsInteger;
    if INumbTypeMessage = 2 then begin
      aJFBMain_Info.Enabled      := true;
      aJFBMain_SendEMail.Enabled := true;
    end else begin
      aJFBMain_Info.Enabled      := false;
      aJFBMain_SendEMail.Enabled := false;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.JCallShowGets;
var
  SignState : integer;
begin
  if IJCallSign_Active = 1 then begin
    { Вкл/выкл надписей на конопках }
    tlbarJCallMain.ShowCaptions  := pmiToolBar_ShowCption.Checked;
    tlbarJCallMain.Flat          := pmiToolBar_ShowCption.Checked;
    {tlbarJFBSlave_Hist.ShowCaptions := pmiToolBar_ShowCption.Checked;}
    {tlbarJFBSlave_Hist.Flat         := pmiToolBar_ShowCption.Checked;}
    if pmiToolBar_ShowCption.Checked
      then begin pnlJCallMain_Tool.Height := 26; {pnlJFBSlaveControl_Hist.Height := 26;} end
      else begin pnlJCallMain_Tool.Height := 30; {pnlJFBSlaveControl_Hist.Height := 30;} end;
    { Отображение количества записей }
    pnlJCallMain_Show.Caption  := 'Вызовов: ' + VarToStr(qrspJCallMain.RecordCount);
    { Доступ к очистке условия отбора }
    if JCallGetStateClearMainCondition
      then aJCallMain_ClearCondition.Enabled := false
      else aJCallMain_ClearCondition.Enabled := true;

    { Доступ к элементам меню и кнопкам если GRID не пустой}
    if not qrspJCallMain.IsEmpty then begin { main-grid не пустой }

      aJCallMain_Close.Enabled    := true;
      aJCallMain_Open.Enabled     := true;
      aJCallMain_Status.Enabled   := true;
      aJCallMain_ItemEdit.Enabled := true;

      { Управление действиями по состоянию вызова }
      if length(JCallGridMain.DataSource.DataSet.FieldByName('SCloseDate').AsString) = 0 then begin
        SignState := csStateOpen;
        tlbtnJCallMain_State.Action := aJCallMain_Close;
        pmiJCall_State.Action   := aJCallMain_Close;
        { Уточнение доступа в зависимости от наличия статуса }
        if length(JCallGridMain.DataSource.DataSet.FieldByName('SStatus').AsString) = 0 then begin
          aJCallMain_Close.Enabled := false;
        end else begin
          aJCallMain_Close.Enabled := true;
        end;
      end else begin
        SignState := csStateClose;
        tlbtnJCallMain_State.Action := aJCallMain_Open;
        pmiJCall_State.Action   := aJCallMain_Open;
      end;

      { Управление доступом для закрытого вызова }
      if SignState = csStateClose then begin
        { Доступ к определению статуса вызова }
        aJCallMain_Status.Enabled := False;
      end;

    end else begin { main-grid не пустой }

      aJCallMain_Close.Enabled    := false;
      aJCallMain_Open.Enabled     := false;
      aJCallMain_Status.Enabled   := false;
      aJCallMain_ItemEdit.Enabled := false;

    end;

  end;
end;

function TFCCenterJournalNetZkz.JRMOGetStateClearMainCondition : boolean;
var bResReturn : boolean;
begin
  if     (length(trim(edCndJRMOArtCode.Text))            = 0)
     and (length(trim(edCndJRMOArtName.Text))            = 0)
     and (length(trim(edCndJRMOClient.Text))             = 0)
     and (length(trim(edCndJRMOPhone.Text))              = 0)
     and (length(trim(edCndJRMOHist_NameOperation.Text)) = 0)
     and (cmbxCndJRMOState.ItemIndex                     = 0)
  then bResReturn := true
  else bResReturn := false;
  result := bResReturn;
end;

function TFCCenterJournalNetZkz.JFBGetStateClearMainCondition : boolean;
var bResReturn : boolean;
begin
  if     (length(trim(edJFBCnd_Client.Text)) = 0)
     and (length(trim(edJFBCnd_Phone.Text))  = 0)
     and (length(trim(edJFBCnd_EMail.Text))  = 0)
     and (length(trim(edJFBCnd_Msg.Text))    = 0)
  then bResReturn := true
  else bResReturn := false;
  result := bResReturn;
end;

function TFCCenterJournalNetZkz.JCallGetStateClearMainCondition : boolean;
var bResReturn : boolean;
begin
  if     (length(trim(edJCallCnd_Client.Text)) = 0)
     and (length(trim(edJCallCnd_Phone.Text))  = 0)
  then bResReturn := true
  else bResReturn := false;
  result := bResReturn;
end;

procedure TFCCenterJournalNetZkz.ShowGetsSlave;
begin
  { Дополнительное управление доступом к элементам управления Slave-грида }
  if OrderHeaderDS.FieldByName('aptekaID').AsInteger = 0 then begin
    aJSOSlave_ItemReserve.Enabled  := true;
    aJSOSlave_OrderReserve.Enabled := true
  end else begin
    aJSOSlave_ItemReserve.Enabled  := false;
    aJSOSlave_OrderReserve.Enabled := false;
  end;
  { Уточнение доступа к <Товар по частям> }
  if DBGridSlave.DataSource.DataSet.FieldByName('ISignDivideParts').AsInteger = 1
    then aJSOSlave_Parts.Enabled := true
    else aJSOSlave_Parts.Enabled := false;
  { Уточнение доступа к <Сроковый товар> }
  if DBGridSlave.DataSource.DataSet.FieldByName('ISignArmorTerm').AsInteger = 1
    then aJSOSlave_Term.Enabled := true
    else aJSOSlave_Term.Enabled := false;
  { Уточнение доступа к возвратным накладным }
  if (
      (DBGridSlave.DataSource.DataSet.FieldByName('ISignModeReserve').AsInteger = 2)
      and
      (DBGridSlave.DataSource.DataSet.FieldByName('NApteka').AsInteger <> 0)
     )
     or
     (
      (DBGridSlave.DataSource.DataSet.FieldByName('ISignDistribute').AsInteger = 1)
      and
      (DBGridSlaveDistrib.DataSource.DataSet.FieldByName('ISignModeReserve').AsInteger = 2)
     )
     or
     (
      DBGridSlave.DataSource.DataSet.FieldByName('ISignModeReserve').AsInteger = 3
     )
  then aJSOSlave_InfoInvoice.Enabled := true
  else begin
    aJSOSlave_InfoInvoice.Enabled := false;
  end;
end; { TFCCenterJournalNetZkz.ShowGetsSlave; }

procedure TFCCenterJournalNetZkz.ShowGetsSlaveDistribute;
begin
  { Уточнение доступа к возвратным накладным }
  if (
      (DBGridSlave.DataSource.DataSet.FieldByName('ISignDistribute').AsInteger = 1)
      and
      (
       (DBGridSlave.DataSource.DataSet.FieldByName('ISignModeReserve').AsInteger = 2)
       or
       (DBGridSlave.DataSource.DataSet.FieldByName('ISignModeReserve').AsInteger = 3)
      )
     ) then begin
    if DBGridSlaveDistrib.DataSource.DataSet.FieldByName('ISignModeReserve').AsInteger = 2
      then aJSOSlave_InfoInvoice.Enabled := true
      else aJSOSlave_InfoInvoice.Enabled := false;
  end;
end;

{ ИСТОРИЯ ОПЕРАЦИЙ Управление доступом к элементам управления Slave-грида }
procedure TFCCenterJournalNetZkz.JSOShowGetsSlave_Hist;
begin
  if qrspJSOHistory.Active then begin
    if qrspJSOHistory.RecordCount = 0 then begin { история операций slave-grid пустой }
      { Отключаем доступ к элементам управления Slave-грида }
      SetStateAllControlSlaveHist(false);
    end else begin { slave-grid не пустой }
      SetStateAllControlSlaveHist(false);
      { Уточняем доступ к принудительному закрытию действия }
      SetStateForcedFlosure;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.JSOSetRecHist;
begin
  JSORecHist.NRN                 := JSOGridHistory.DataSource.DataSet.FieldByName('NRN').AsInteger;
  JSORecHist.NPRN                := JSOGridHistory.DataSource.DataSet.FieldByName('NPRN').AsInteger;
  JSORecHist.SUnitCode           := JSOGridHistory.DataSource.DataSet.FieldByName('SUnitCode').AsString;
  JSORecHist.SUnitName           := JSOGridHistory.DataSource.DataSet.FieldByName('SUnitName').AsString;
  JSORecHist.SUnitTable          := JSOGridHistory.DataSource.DataSet.FieldByName('SUnitTable').AsString;
  JSORecHist.SActionCode         := JSOGridHistory.DataSource.DataSet.FieldByName('SActionCode').AsString;
  JSORecHist.SActionName         := JSOGridHistory.DataSource.DataSet.FieldByName('SActionName').AsString;
  JSORecHist.NUSER               := JSOGridHistory.DataSource.DataSet.FieldByName('NUSER').AsInteger;
  JSORecHist.SUser               := JSOGridHistory.DataSource.DataSet.FieldByName('SUser').AsString;
  JSORecHist.DBeginDate          := JSOGridHistory.DataSource.DataSet.FieldByName('DBeginDate').AsDateTime;
  JSORecHist.SBeginDate          := JSOGridHistory.DataSource.DataSet.FieldByName('SBeginDate').AsString;
  JSORecHist.DEndDate            := JSOGridHistory.DataSource.DataSet.FieldByName('DEndDate').AsDateTime;
  JSORecHist.SEndDate            := JSOGridHistory.DataSource.DataSet.FieldByName('SEndDate').AsString;
  JSORecHist.NOrder              := JSOGridHistory.DataSource.DataSet.FieldByName('NOrder').AsInteger;
  JSORecHist.NBell               := JSOGridHistory.DataSource.DataSet.FieldByName('NBell').AsInteger;
  JSORecHist.SActionFoundation   := JSOGridHistory.DataSource.DataSet.FieldByName('SActionFoundation').AsString;
  JSORecHist.SDriver             := JSOGridHistory.DataSource.DataSet.FieldByName('SDriver').AsString;
  JSORecHist.NDriver             := JSOGridHistory.DataSource.DataSet.FieldByName('NDriver').AsInteger;
  JSORecHist.SNOTE               := JSOGridHistory.DataSource.DataSet.FieldByName('SNOTE').AsString;
  JSORecHist.IAllowBeOpen        := JSOGridHistory.DataSource.DataSet.FieldByName('IAllowBeOpen').AsInteger;
  JSORecHist.WaitingTimeMinute   := JSOGridHistory.DataSource.DataSet.FieldByName('WaitingTimeMinute').AsInteger;
end;

procedure TFCCenterJournalNetZkz.JSOSetRecPay;
begin
  JSORecPay.TypeUnion       := JSOGridPay.DataSource.DataSet.FieldByName('TypeRecPay').AsString;
  JSORecPay.RN              := JSOGridPay.DataSource.DataSet.FieldByName('NRN').AsInteger;
  JSORecPay.Order           := RegAction.Order;
  JSORecPay.Document93      := 0;
  JSORecPay.DocNumb         := JSOGridPay.DataSource.DataSet.FieldByName('SDocNumb').AsString;
  JSORecPay.DocSumPay       := JSOGridPay.DataSource.DataSet.FieldByName('NDocSumPay').AsCurrency;
  JSORecPay.DocDate         := JSOGridPay.DataSource.DataSet.FieldByName('DNormDocDate').AsDateTime;
  JSORecPay.SDocDate        := JSOGridPay.DataSource.DataSet.FieldByName('SNormDocDate').AsString;
  JSORecPay.DocNote         := JSOGridPay.DataSource.DataSet.FieldByName('SDocNote').AsString;
  JSORecPay.CreateDate      := FormatDateTime('yyyy-mm-dd hh:nn:ss', JSOGridPay.DataSource.DataSet.FieldByName('DCreateDate').AsDateTime);
  JSORecPay.BarCode         := JSOGridPay.DataSource.DataSet.FieldByName('SBarCode').AsString;
  JSORecPay.DRedeliveryDate := JSOGridPay.DataSource.DataSet.FieldByName('DRedeliveryDate').AsDateTime;
  JSORecPay.SRedeliveryDate := JSOGridPay.DataSource.DataSet.FieldByName('SRedeliveryDate').AsString;
end;

procedure TFCCenterJournalNetZkz.JSODisableDistribute;
begin
  pnlSlave_OrderGrid_Distrib.Visible := false;
  pnlSlave_OrderGrid_Order.Width := pnlSlave_OrderGrid.Width;
end;

function TFCCenterJournalNetZkz.GetJSOItemDistributeCount : integer;
var
  ItemDistribCount : integer;
begin
  ItemDistribCount := 0;
  try
    spGetItemDistributeCount.Parameters.ParamValues['@RN'] := DBGridSlave.DataSource.DataSet.FieldByName('NRN').AsInteger;
    spGetItemDistributeCount.ExecProc;
    ItemDistribCount := spGetItemDistributeCount.Parameters.ParamValues['@Count'];
  except
    on e:Exception do
      begin
        ShowMessage('Сбой при определении количества товара, распределенного по аптекам'+chr(10)+e.Message);
      end;
  end;
  result := ItemDistribCount;
end;

function TFCCenterJournalNetZkz.GetAccessUserAlertType(AlertType : integer) : boolean;
var
  CheckAccess : integer;
begin
  CheckAccess := 0;
  try
    spAlertTypeAccessCheck.Parameters.ParamValues['@AlertType'] := AlertType;
    spAlertTypeAccessCheck.Parameters.ParamValues['@USER'] := UserSession.CurrentUser;
    spAlertTypeAccessCheck.ExecProc;
    CheckAccess := spAlertTypeAccessCheck.Parameters.ParamValues['@Check'];
  except
    on e:Exception do begin
      CheckAccess := 0;
      ShowMessage('Сбой при определении прав доступа.' + chr(10) + e.Message);
    end;
  end;
  if CheckAccess = 0 then result := false else result := true;
end;

function TFCCenterJournalNetZkz.GetJSOFactorNumber(KoefOpt, SignMeas : integer) : integer;
var
  FactorNumber : integer;
begin
  FactorNumber := 1;
  try
    spGetFactorNumber.Parameters.ParamValues['@Koef_Opt'] := KoefOpt;
    spGetFactorNumber.Parameters.ParamValues['@SignMeas'] := SignMeas;
    spGetFactorNumber.ExecProc;
    FactorNumber := spGetFactorNumber.Parameters.ParamValues['@FactorNumber'];
  except
    on e:Exception do
      begin
        ShowMessage('Сбой при определении множителя количества'+chr(10)+e.Message);
      end;
  end;
  result := FactorNumber;
end;

procedure TFCCenterJournalNetZkz.JSOEnableDistribute;
var
  SCaption  : string;
  NKoefBox  : integer;
  NArtCount : integer;
  SignMeas  : integer;
  SSignMeas : string;
  SPack     : string;
begin
  pnlSlave_OrderGrid_Order.Width :=   get_column_by_fieldname('NArtCode',DBGridSlave).Width
                                    + get_column_by_fieldname('ISignModeReserve',DBGridSlave).Width
                                    + get_column_by_fieldname('ISignDistribute',DBGridSlave).Width
                                    + get_column_by_fieldname('SDistributeCount',DBGridSlave).Width
                                    + get_column_by_fieldname('SNomenclature',DBGridSlave).Width + 40;
  pnlSlave_OrderGrid_Distrib.Visible := true;
  NKoefBox  := DBGridSlave.DataSource.DataSet.FieldByName('NKoef_Opt').AsInteger;
  NArtCount := DBGridSlave.DataSource.DataSet.FieldByName('NArtCount').AsInteger;
  SignMeas  := DBGridSlave.DataSource.DataSet.FieldByName('ISignMeas').AsInteger;
  SSignMeas := DBGridSlave.DataSource.DataSet.FieldByName('SSignMeas').AsString;
  { Отображаем всего распределенного по торговым точкам количества из общего количества в позиции заказа }
  if GetJSOItemDistributeCount = (NArtCount * GetJSOFactorNumber(NKoefBox,SignMeas))
    then pnlSlave_OrderGrid_DistribHeaderCount.Font.Color := clWindowText
    else pnlSlave_OrderGrid_DistribHeaderCount.Font.Color := clRed;
  { Количество упаковок под заказ }
  SPack := '';
  if SignMeas = 0 then SPack := IntToStr(NArtCount)
  else if SignMeas = 1 then SPack := VarToStr(Round((NArtCount/NKoefBox)*100)/100);
  SCaption := 'Распределено: ' + VarToStr(GetJSOItemDistributeCount) + 'шт. из ' +
                                 IntToStr(NArtCount * GetJSOFactorNumber(NKoefBox,SignMeas)) + 'шт. ' +
                                 '('+SPack+'упак.)';
  pnlSlave_OrderGrid_DistribHeaderCount.Caption := SCaption;  pnlSlave_OrderGrid_DistribHeaderCount.Width := TextPixWidth(SCaption, pnlSlave_OrderGrid_DistribHeaderCount.Font) + 20;
  { Отображаем цену на сайте в зависимости от признака единицы измерения }
  if SignMeas = 0 then begin
    SCaption := 'Цена упаковки на сайте: '+DBGridSlave.DataSource.DataSet.FieldByName('NArtPrice').AsString;
  end else if SignMeas = 1 then begin
    SCaption := 'Цена штуки на сайте: '+DBGridSlave.DataSource.DataSet.FieldByName('NArtPrice').AsString;
  end;
  pnlSlave_OrderGrid_DistribHeaderPrice.Caption := SCaption;  pnlSlave_OrderGrid_DistribHeaderPrice.Width := TextPixWidth(SCaption, pnlSlave_OrderGrid_DistribHeaderPrice.Font) + 20;
  SCaption := 'Коэфициент (кол-во шт. в упаковке): '+DBGridSlave.DataSource.DataSet.FieldByName('NKoef_Opt').AsString;
  pnlSlave_OrderGrid_DistribHeaderKoef.Caption := SCaption;  pnlSlave_OrderGrid_DistribHeaderKoef.Width := TextPixWidth(SCaption, pnlSlave_OrderGrid_DistribHeaderKoef.Font) + 20;
  { Уточнение заголовка столбцов по единице измерения }
  get_column_by_fieldname('NArtPrice',DBGridSlaveDistrib).Title.Caption := 'Цена САЙТ ('+SSignMeas+')';
  { Отображаем количество записей }
  SCaption := VarToStr(qrspJSOPositionDistribute.RecordCount);
  pnlSlave_OrderGrid_DistribControlShow.Caption := SCaption;
  pnlSlave_OrderGrid_DistribControlShow.Width := TextPixWidth(SCaption, pnlSlave_OrderGrid_DistribControlShow.Font) + 20;
end;

Procedure TFCCenterJournalNetZkz.ShowStatuBarStandart;
var SStatusText : string;
begin
  SStatusText := '';
  if OrderHeaderDS.IsEmpty then SStatusText := ''
  else
    begin
      SStatusText :=
        VarToStr(OrderHeaderDS.FieldByName('orderDt').AsDateTime) + ' ' +
        OrderHeaderDS.FieldByName('Apteka').AsString;
    end;
  stbarOne.SimpleText := SStatusText;
end; (* TFCCenterJournalNetZkz.ShowStatuBarStandart *)

(* Основной отклик по событиям полей grpbxCondition - условия отбора*)
Procedure TFCCenterJournalNetZkz.ExecConditionQRMain;
var
  RNOrderID: Integer;
begin
  if not qrMain.IsEmpty then RNOrderID := qrMain.FieldByName('orderID').AsInteger else RNOrderID := -1;
  Screen.Cursor := crHourGlass;
  try
    qrMain.Active := false;
    CreateConditionQRMain;
    qrMain.Active := true;
  finally
    Screen.Cursor := crDefault;
  end;
  qrMain.Locate('orderID', RNOrderID, []);
end; (* TFCCenterJournalNetZkz.ExecConditionQRMain *)

procedure TFCCenterJournalNetZkz.ExecConditionJSOCheck;
begin
  if qrspJSOPay.IsEmpty then begin
    qrspJSOCheck.Active := false;
    qrspJSOCheck.Parameters.ParamByName('@OrderPay').Value := 0;
    qrspJSOCheck.Active := true;
  end else begin
    qrspJSOCheck.Active := false;
    qrspJSOCheck.Parameters.ParamByName('@OrderPay').Value := JSOGridPay.DataSource.DataSet.FieldByName('NRN').AsInteger;
    qrspJSOCheck.Active := true;
  end;
end;

procedure TFCCenterJournalNetZkz.ExecConditionJSOPay;
begin
  if OrderHeaderDS.IsEmpty then begin
    qrspJSOPay.Active := false;
    qrspJSOPay.Parameters.ParamByName('@Order').Value := 0;
    qrspJSOPay.Active := true;
  end else begin
    qrspJSOPay.Active := false;
    qrspJSOPay.Parameters.ParamByName('@Order').Value := OrderHeaderDS.FieldByName('orderID').AsInteger;
    qrspJSOPay.Active := true;
  end;
end;

procedure TFCCenterJournalNetZkz.ExecConditionJSONPost;
begin
  if OrderHeaderDS.IsEmpty then begin
    qrspJSONPost.Active := false;
    qrspJSONPost.Parameters.ParamByName('@Order').Value := 0;
    qrspJSONPost.Active := true;
  end else begin
    qrspJSONPost.Active := false;
    qrspJSONPost.Parameters.ParamByName('@Order').Value := OrderHeaderDS.FieldByName('orderID').AsInteger;
    qrspJSONPost.Active := true;
  end;
end;

procedure TFCCenterJournalNetZkz.ExecConditionJSONPostPay;
begin
  if OrderHeaderDS.IsEmpty then begin
    qrspJSONPostPay.Active := false;
    qrspJSONPostPay.Parameters.ParamByName('@Order').Value := 0;
    qrspJSONPostPay.Active := true;
  end else begin
    qrspJSONPostPay.Active := false;
    qrspJSONPostPay.Parameters.ParamByName('@Order').Value := OrderHeaderDS.FieldByName('orderID').AsInteger;
    qrspJSONPostPay.Active := true;
  end;
end;

procedure TFCCenterJournalNetZkz.JFBGridMainRefresh;
var
  RNOrderID: Integer;
begin
  if not qrspJFBMain.IsEmpty then RNOrderID := qrspJFBMain.FieldByName('NRN').AsInteger else RNOrderID := -1;
  qrspJFBMain.Requery;
  qrspJFBMain.Locate('NRN', RNOrderID, []);
end; (* TFCCenterJournalNetZkz.JFBGridMainRefresh *)

procedure TFCCenterJournalNetZkz.JCallGridMainRefresh;
var
  RNOrderID: Integer;
begin
  if not qrspJCallMain.IsEmpty then RNOrderID := qrspJCallMain.FieldByName('NRN').AsInteger else RNOrderID := -1;
  qrspJCallMain.Requery;
  qrspJCallMain.Locate('NRN', RNOrderID, []);
end; (* TFCCenterJournalNetZkz.JCallGridMainRefresh *)

(* Создание условия отбора по событиям полей grpbxCondition *)
Procedure TFCCenterJournalNetZkz.CreateConditionQRMain;
var
  StrSelect               : string;
  StrMainCondition        : string;
  StrSlOrder              : string;
  StrSlCondition          : string;
  StrSlSlaveCondition     : string;
  StrSlHistCondition      : string;
  StrSlPayCondition       : string;
  StrSlNPostPayCondition  : string;
  OrderBegin              : string;
  OrderEnd                : string;
  PlanDateSendBegin       : string;
  PlanDateSendEnd         : string;
  DFormatSet              : TFormatSettings;
  SPayDate                : string;
  SStockDate              : string;
  SIDPharmacy             : string;
  SIDENT                  : string;
  IErr                    : integer;
  SErr                    : string;
begin
  { Инициализация }
  StrSelect               := '';
  StrSlOrder              := '';
  StrSlCondition          := '';
  StrSlSlaveCondition     := '';
  StrSlHistCondition      := '';
  StrSlPayCondition       := '';
  StrSlNPostPayCondition  := '';
  StrMainCondition        := '';

  DFormatSet.DateSeparator := '-';
  DFormatSet.TimeSeparator := ':';
  DFormatSet.ShortDateFormat := 'dd-mm-yyyy';
  DFormatSet.ShortTimeFormat := 'hh24:mi:ss';

  StrSelect := 'declare @OrderDtBegin datetime, @OrderDtEnd datetime; ' + chr(10);
  if JSOCondRec.SignOrderPeriod = 0 then begin
    OrderBegin := FormatDateTime('yyyy-mm-dd', dtCndBegin.Date);
    OrderEnd   := FormatDateTime('yyyy-mm-dd', IncDay(dtCndEnd.Date,1));
  end else begin
    OrderBegin := FormatDateTime('yyyy-mm-dd', JSOCondRec.BeginClockDate) + ' ' + FormatDateTime('hh:nn:ss', JSOCondRec.BeginClockTime);
    OrderEnd   := FormatDateTime('yyyy-mm-dd', JSOCondRec.EndClockDate) + ' ' + FormatDateTime('hh:nn:ss', JSOCondRec.EndClockTime);
  end;
  StrSelect := StrSelect +
               'set @OrderDtBegin = ''' + OrderBegin + '''; ';
  StrSelect := StrSelect +
               'set @OrderDtEnd = ''' + OrderEnd + '''; ';

  if (JSOCondRec.NPharmacy > 0) or (length(edCndArtCode.Text) > 0) then begin
    { Формируем список выбранных заказов }
    if JSOCondIdent <> 0 then begin
      DM_CCJSO.SLClear(JSOCondIdent,IErr,SErr);
    end;
    JSOCondIdent := GetIdUserAction;
    SIDENT := VarToStr(JSOCondIdent);
    DM_CCJSO.JSOCreateListSelectBetweenDate(UserSession.CurrentUser,JSOCondIdent,OrderBegin,OrderEnd);
  end;
  StrSelect := StrSelect +
               'select ccjs.* '+
               'from WorkWith_Gamma.dbo.v_Orders_Site ccjs with (nolock) ';
  if Length(MainSortField) = 0 then StrSlOrder := '' else StrSlOrder := ' order by ccjs.' + MainSortField;
  StrSlCondition := 'where 1 = 1 ';

  //Rozetka.UA видит только DBSERVER-SQL5
  if (Form1.id_user <> 311) and (Self.FMainFilterState <> mfsArtCode) then
    StrSlCondition := StrSlCondition + ' and (isnull(ccjs.SrcSystem, 0) <> 4)';

  if Self.FMainFilterState <> mfsNone then
  begin
    qrMain.SQL.Clear;
    if Length(FMainFilter.OrderId) > 0 then
       StrMainCondition := StrMainCondition +
                        ' and ((ccjs.orderId = ' + FMainFilter.OrderId + ') or' +
                        ' (ccjs.SrcId = ' + FMainFilter.OrderId + ') or' +
                        ' (ccjs.MPhone = ''' + FMainFilter.OrderId + '''))' + chr(10);

      {StrMainCondition := StrMainCondition +
                        ' and ((ccjs.OrderName like ' + '''%' + FMainFilter.OrderId + '%'') or' +
                        ' (ccjs.ExtId like ' + '''%' + FMainFilter.OrderId + '%''))' + chr(10);  }

    if VarIsAssigned(FMainFilter.CondId) then
      StrMainCondition := dmJSO.GetCondSQL(FMainFilter.CondId, 'ccjs');

    if Length(FMainFilter.ArtCode) > 0 then
       StrMainCondition := StrMainCondition +
       Format(
       ' and (ccjs.orderDT between dateadd(day, -30, @orderDtEnd) and @OrderDtEnd) ' + chr(10) +
       ' and ccjs.orderId in ( '  + chr(10) +
       '  select distinct NPRN as OrderId from dbo.v_CallCenter_Zakaz_Site os with(nolock) where os.NArtCode = %s ' + chr(10) +
       '  union all ' + chr(10) +
       '  select distinct os.OrderId from dbo.t_jsz_OrderPositionDistribute d with(nolock) ' + chr(10) +
       '    join dbo.CallCenter_Zakaz_Site os with(nolock) on d.prn = os.itemId  ' + chr(10) +
       '   where d.itemCodeTerm = %s ' + chr(10) +
       '  union all ' + chr(10) +
       '  select distinct os.OrderId from dbo.t_jso_ArtCodeTerm d with(nolock) ' + chr(10) +
       '    join dbo.CallCenter_Zakaz_Site os with(nolock) on d.PRN = os.itemId ' + chr(10) +
       '   where d.itemCode = %s ' + chr(10) +
       '  union all ' + chr(10) +
       '  select distinct os.orderID  from dbo.t_jso_AddPosition_Distribute d with(nolock) ' + chr(10) +
       '    join dbo.t_jso_AddPosition os with(nolock) on d.prn = os.itemID ' + chr(10) +
       '   where d.itemCodeTerm = %s) '  + chr(10), [FMainFilter.ArtCode, FMainFilter.ArtCode, FMainFilter.ArtCode, FMainFilter.ArtCode]);

    if StrMainCondition <> '' then
    begin
      qrMain.SQL.Add(StrSelect + StrSlCondition + StrMainCondition + StrSlOrder);
      Exit;
    end;  
  end;
  
  {--* JSOMainCondition *--}
  if chbxCndAccountPeriod.Checked then begin
    StrSlCondition := StrSlCondition +
                      ' and (ccjs.orderDT between @OrderDtBegin and @OrderDtEnd)' + chr(10);
  end;
  if cmbxCndState.ItemIndex = 3 then { Актуальные интернет-заказы }
      StrSlCondition := StrSlCondition +
                        ' and (isnull(Status_App, 0) = 0)';

  if not GetStateClearMainCondition then begin
    if JSOCondRec.SignLink = cJSOSignLink_FindCurrentOrders then
      StrSlCondition := StrSlCondition +
                        ' and (' +
                             ' ccjs.OrderID = ' + IntToStr(JSOParentOrder) +
                             ' or ' +
                             ' ccjs.OrderID in (select tlp.orderID from WorkWith_Gamma.dbo.fDS_jso_LinkParentsList(' + IntToStr(JSOParentOrder) + ') as tlp )' +
                             ' or ' +
                             ' ccjs.OrderID in (select tls.orderID from WorkWith_Gamma.dbo.fDS_jso_LinkSlavesList(' + IntToStr(JSOParentOrder) +' ) as tls )' +
                             ' ) ';
    if JSOCondRec.SignLink = cJSOSignLink_FindFavorites then
      StrSlCondition := StrSlCondition +
                        ' and (' +
                             ' ccjs.NParentOrderID is null ' +
                             ' and ' +
                             ' len(WorkWith_Gamma.dbo.f_jso_SlavesList(ccjs.OrderID)) > 0' +
                             ') ';
    if cmbxCndState.ItemIndex = 1 then { Открытые интернет-заказы }
      StrSlCondition := StrSlCondition +
                        ' and (len(isnull(ccjs.SCloseDate,'''')) = 0)';
    if cmbxCndState.ItemIndex = 2 then { Закрытые интернет-заказы }
      StrSlCondition := StrSlCondition +
                        ' and (len(isnull(ccjs.SCloseDate,'''')) <> 0)';

    if JSOCondRec.SignNewOrder > 0 then
      StrSlCondition := StrSlCondition +
                        ' and (ccjs.ISignNew = ' + IntToStr(JSOCondRec.SignNewOrder) + ')' + chr(10);
    if length(trim(edCndApteka.Text)) > 0 then
      if JSOCondRec.NPharmacy > 0 then begin
        SIDPharmacy := IntToStr(JSOCondRec.NPharmacy);
        StrSlCondition := StrSlCondition +
                          ' and (' + chr(10) +
                          '         ccjs.aptekaID = ' + SIDPharmacy + chr(10) +
                          '      or ccjs.orderID in (' + chr(10) +
                          '                          select t_zs.orderID from WorkWith_Gamma.dbo.CallCenter_Zakaz_Site t_zs with (nolock)' +
                          '                          where t_zs.orderID in (select sl.PRN from WorkWith_Gamma.dbo.t_SelectList as sl with (nolock)' +
                          '                                                 where sl.IDENT = ' + SIDENT + ')' +
                          '                                                   and t_zs.aptekaID = ' + SIDPharmacy + chr(10) +
                          '                         )' + chr(10) +
                          '      or ccjs.orderID in (' + chr(10) +
                          '                          select t_zs.orderID from WorkWith_Gamma.dbo.CallCenter_Zakaz_Site as t_zs with (nolock)' + chr(10) +
                          '                            join WorkWith_Gamma.dbo.t_jsz_OrderPositionDistribute as tdst with (nolock) on tdst.PRN = t_zs.itemID' + chr(10) +
                          '                          where t_zs.orderID in (select sl.PRN from WorkWith_Gamma.dbo.t_SelectList as sl with (nolock) where sl.IDENT = ' + SIDENT + ')' + chr(10) +
                          '                            and tdst.AptekaID = ' + SIDPharmacy + chr(10) +
                          '                         )' + chr(10) +
                          '      or ccjs.orderID in (' + chr(10) +
                          '                          select t_adp.orderID from WorkWith_Gamma.dbo.t_jso_AddPosition t_adp with (nolock)' +
                          '                          where t_adp.orderID in (select sl.PRN from WorkWith_Gamma.dbo.t_SelectList as sl with (nolock)' +
                          '                                                  where sl.IDENT = ' + SIDENT + ')' +
                          '                                                    and t_adp.aptekaID = ' + SIDPharmacy + chr(10) +
                          '                         )' + chr(10) +
                          '      or ccjs.orderID in (' + chr(10) +
                          '                          select t_adp.orderID from WorkWith_Gamma.dbo.t_jso_AddPosition as t_adp with (nolock)' + chr(10) +
                          '                            join WorkWith_Gamma.dbo.t_jso_AddPosition_Distribute as t_adpdst with (nolock) on t_adpdst.PRN = t_adp.itemID' + chr(10) +
                          '                          where t_adp.orderID in (select sl.PRN from WorkWith_Gamma.dbo.t_SelectList as sl with (nolock) where sl.IDENT = ' + SIDENT + ')' + chr(10) +
                          '                            and t_adpdst.AptekaID = ' + SIDPharmacy + chr(10) +
                          '                         )' + chr(10) +
                          '     )' + chr(10);
      end;
    if length(trim(edCndOrderShipping.Text)) > 0 then
      StrSlCondition := StrSlCondition +
                        ' and (ccjs.orderShipping like ' + '''%' + edCndOrderShipping.Text + '%'')';
    if length(trim(JSOCondRec.Payment)) > 0 then
      StrSlCondition := StrSlCondition +
                        ' and (ccjs.orderPayment like ' + '''%' + JSOCondRec.Payment + '%'')';
    if length(trim(edCndShipName.Text)) > 0 then
      StrSlCondition := StrSlCondition +
                        ' and (ccjs.orderShipName like ' + '''%' + edCndShipName.Text + '%'')';
    if length(trim(edCndPhone.Text)) > 0 then
      if JSOCondRec.bSignRefPhone then StrSlCondition := StrSlCondition + ' and (ccjs.orderPhone = ' + '''' + edCndPhone.Text + ''')' + chr(10)
                                  else StrSlCondition := StrSlCondition + ' and ccjs.orderPhone like ' + '''%' + edCndPhone.Text + '%'')' + chr(10);

    if length(trim(edAptAdress.Text)) > 0 then
      StrSlCondition := StrSlCondition +
                        ' and (ccjs.orderShipStreet like ' + '''%' + edAptAdress.Text + '%'')' + chr(10);
{    if length(JSOCondRec.SOrderID) > 0 then
      StrSlCondition := StrSlCondition +
                        ' and ((ccjs.OrderName like ' + '''%' + JSOCondRec.SOrderID + '%'') or' +
                        ' (ccjs.ExtId like ' + '''%' + JSOCondRec.SOrderID + '%''))' + chr(10);  }
    if length(JSOCondRec.SOrderID) > 0 then
       StrMainCondition := StrMainCondition +
                        ' and ((ccjs.orderId = ' + FMainFilter.OrderId + ') or' +
                        ' (ccjs.SrcId = ' + FMainFilter.OrderId + ') or' +
                        ' (ccjs.MPhone = ' + FMainFilter.OrderId + '))' + chr(10);
    if length(JSOCondRec.SCity) > 0 then
      StrSlCondition := StrSlCondition +
                        ' and (ccjs.SOrderShipCity like ' + '''%' + JSOCondRec.SCity + '%'')' + chr(10);
    if JSOCondRec.NGeoGroupPharm <> 0 then
      StrSlCondition := StrSlCondition +
                        ' and (ccjs.NGeoGroupPharm = ' + IntToStr(JSOCondRec.NGeoGroupPharm) + ')' + chr(10);
    if JSOCondRec.SignGeoGroupPharmNotDefined then
      StrSlCondition := StrSlCondition +
                        ' and (ccjs.NGeoGroupPharm is null) ';
    if JSOCondRec.SignDefinedPharm = 1 then
      StrSlCondition := StrSlCondition +
                        ' and (ccjs.aptekaID is not null) ';
    if JSOCondRec.SignDefinedPharm = 2 then
      StrSlCondition := StrSlCondition +
                        ' and (ccjs.aptekaID is null) ';
    if JSOCondRec.SignMark = 1 then
      StrSlCondition := StrSlCondition +
                        ' and (ccjs.NMarkUser = ' + IntToStr(JSOCondRec.USER) + ')' + chr(10);
    if (JSOCondRec.SignMark = 2) and (JSOCondRec.NMarkOtherUser = 0) then
      StrSlCondition := StrSlCondition +
                        ' and (ccjs.NMarkUser not in (' + IntToStr(JSOCondRec.USER) + ')) + chr(10)';
    if (JSOCondRec.SignMark = 2) and (JSOCondRec.NMarkOtherUser <> 0) then
      StrSlCondition := StrSlCondition +
                        ' and (ccjs.NMarkUser = ' + IntToStr(JSOCondRec.NMarkOtherUser) + ')' + chr(10);
    if length(edJSOCndPay_SDispatchDeclaration.Text) > 0 then
      StrSlCondition := StrSlCondition +
                        ' and (ccjs.SDispatchDeclaration like ' + '''%' + edJSOCndPay_SDispatchDeclaration.Text + '%'')' + chr(10);
    if JSOCondRec.NPOST_StateID > 0 then
      StrSlCondition := StrSlCondition +
                        ' and (ccjs.NPOST_StateID like ' + '''%' + IntToStr(JSOCondRec.NPOST_StateID) + '%'')' + chr(10);
    if JSOCondRec.NPOST_SignStateDate then
      StrSlCondition := StrSlCondition +
                        ' and (ccjs.DNPOST_StateDate between ''' + FormatDateTime('yyyy-mm-dd', JSOCondRec.DNPOST_StateBegin) + ''' and ''' + FormatDateTime('yyyy-mm-dd', IncDay(JSOCondRec.DNPOST_StateEnd,1)) + ''')' + chr(10);
    if JSOCondRec.SignPeriod_PDS <> 0 then begin
      case JSOCondRec.SignPeriod_PDS of
       1: begin
            PlanDateSendBegin := FormatDateTime('yyyy-mm-dd', JSOCondRec.BeginDate_PDS);
            PlanDateSendEnd   := FormatDateTime('yyyy-mm-dd', IncDay(JSOCondRec.EndDate_PDS,1));
          end;
       2: begin
            PlanDateSendBegin := FormatDateTime('yyyy-mm-dd', JSOCondRec.BeginClockDate_PDS) + ' ' + FormatDateTime('hh:nn:ss', JSOCondRec.BeginClockTime_PDS);
            PlanDateSendEnd   := FormatDateTime('yyyy-mm-dd', JSOCondRec.EndClockDate_PDS) + ' ' + FormatDateTime('hh:nn:ss', JSOCondRec.EndClockTime_PDS);
          end;
       3: begin
          end;
      end;
      if JSOCondRec.SignPeriod_PDS in [1,2] then
        StrSlCondition := StrSlCondition +
                          ' and (ccjs.DAssemblingDate between ''' + PlanDateSendBegin + ''' and ''' + PlanDateSendEnd + ''')' + chr(10)
      else if JSOCondRec.SignPeriod_PDS in [3] then
        StrSlCondition := StrSlCondition + ' and (ccjs.DAssemblingDate is null) ' + chr(10);
    end;
    if JSOCondRec.SignStockDate = 1 then
      StrSlCondition := StrSlCondition + ' and (ccjs.DStockDateBegin is null) ';
    if JSOCondRec.SignStockDate = 2 then
      StrSlCondition := StrSlCondition + ' and (ccjs.DStockDateBegin is not null) ';
    if length(trim(JSOCondRec.SStockDateBegin)) > 0 then begin
      SStockDate := FormatDateTime('yyyy-mm-dd hh:nn:ss',StrToDateTime(JSOCondRec.SStockDateBegin,DFormatSet));
      StrSlCondition := StrSlCondition + ' and (ccjs.DStockDateBegin >= ''' + SStockDate + ''')' + chr(10);
    end;
    if length(trim(JSOCondRec.SStockDateEnd)) > 0 then begin
      SStockDate := FormatDateTime('yyyy-mm-dd hh:nn:ss',StrToDateTime(JSOCondRec.SStockDateEnd,DFormatSet));
      StrSlCondition := StrSlCondition + ' and (ccjs.DStockDateBegin <= ''' + SStockDate + ''')' + chr(10);
    end;
    if length(JSOCondRec.ExtId) > 0 then
      StrSlCondition := StrSlCondition +
                        ' and (ccjs.ExtId like ' + '''%' + JSOCondRec.ExtId + '%'')' + chr(10);
    if VarIsAssigned(JSOCondRec.SrcSystem) then
      StrSlCondition := StrSlCondition +
                        ' and (ccjs.SrcSystem = ' + VarToStr(JSOCondRec.SrcSystem) + ')' + chr(10);
  end; { if not GetStateClearMainCondition begin }

  {--* JSOSlaveCondition *--}

  StrSlSlaveCondition := '';
  if not GetStateClearSlaveCondition then begin
    StrSlSlaveCondition := ' and ('#10 +
                           '      ccjs.orderID in ('#10 +
                           '                        select vcczs.NPRN from '#10 +
                           '                          WorkWith_Gamma.dbo.v_CallCenter_Zakaz_Site vcczs with (nolock) '#10;
    if length(trim(edCndArtCode.Text)) > 0
      then StrSlSlaveCondition := StrSlSlaveCondition +
                           '                          , WorkWith_Gamma.dbo.t_SelectList as sl with (nolock) '#10 +
					                 '                        where sl.IDENT = ' + SIDENT + chr(10) +
					                 '                          and vcczs.NPRN = sl.PRN '#10
			else StrSlSlaveCondition := StrSlSlaveCondition +
                           '                        where 1 = 1 '#10;
    if chbxCndAmountPeriod.Checked then
      StrSlSlaveCondition := StrSlSlaveCondition +
                                                   ' and vcczs.DArmourDate between ''' + FormatDateTime('yyyy-mm-dd', dtCndAmountDateBegin.Date) + '''' +
                                                   ' and ''' + FormatDateTime('yyyy-mm-dd', IncDay(dtCndAmountDateEnd.Date,1)) + ''''#10;
    if chbxCndNotAmount.Checked then
      StrSlSlaveCondition := StrSlSlaveCondition +
                                                   ' and isnull(vcczs.DArmourDate,0) = 0 '#10;
    if length(trim(edCndArtCode.Text)) > 0 then
      StrSlSlaveCondition := StrSlSlaveCondition +
                                                   ' and ('#10 +
                                                   '         vcczs.NArtCode = ' + edCndArtCode.Text + chr(10) +
                                                   '      or exists(select jsotrm.* from WorkWith_Gamma.dbo.t_jso_ArtCodeTerm as jsotrm with (nolock) where jsotrm.PRN = vcczs.NRN and jsotrm.itemCode = ' + edCndArtCode.Text + ')'#10 +
                                                   '      or exists(select jsodis.* from WorkWith_Gamma.dbo.t_jsz_OrderPositionDistribute as jsodis with (nolock) where jsodis.PRN = vcczs.NRN and jsodis.itemCodeTerm = ' + edCndArtCode.Text + ' and vcczs.STypeTable = ''' + csOrderItemTypeTable_Main + ''')'#10 +
                                                   '      or exists(select t_adpds.* from WorkWith_Gamma.dbo.t_jso_AddPosition_Distribute as t_adpds with (nolock) where t_adpds.PRN = vcczs.NRN and t_adpds.itemCodeTerm = ' + edCndArtCode.Text + ' and vcczs.STypeTable = ''' + csOrderItemTypeTable_Add + ''')'#10 +
                                                   '     )'#10;
    StrSlSlaveCondition := StrSlSlaveCondition + ')'#10;
    StrSlSlaveCondition := StrSlSlaveCondition +
                                ')'#10;
  end; { not GetStateClearSlaveCondition }

  {--* JSOHistCondition *--}

  if not GetStateClearHistCondition then begin
    if length(trim(edJSOCndHist_NameOperation.Text)) > 0 then
    begin
      StrSlHistCondition := ' and ccjs.orderID in ' +
                           '  ( '+
                           '   select vruua.NOrder from WorkWith_Gamma.dbo.v_RegUserUnitAction vruua with (nolock) ' +
					                 '   where 1 = 1 ';
      StrSlHistCondition := StrSlHistCondition +
                            ' and vruua.NPRN = ' + IntToStr(JSOHist_RNUserAction);
      StrSlHistCondition := StrSlHistCondition + ')';
    end;
    
    if VarIsAssigned(JSOCondRec.OperatorId) then
    StrSlHistCondition := StrSlHistCondition +
     Format(' and exists(select * from dbo.t_jso_OrderHistory with(nolock) where orderId = ccjs.orderID and %s in (UserIns, UserUpd)) ', [VarToStr(JSOCondRec.OperatorId)]);
  end; { not GetStateClearHistCondition }

  {--* JSOPayCondition *--}

  if not GetStateClearPayCondition then begin
    if cmbxJSOCndPay_Have.ItemIndex = 1 then { Есть платежи }
      StrSlPayCondition := StrSlPayCondition + ' and exists(select op.RN from WorkWith_Gamma.dbo.t_jso_OrderPay op with (nolock) where op.[Order] = ccjs.orderID) ';
    if cmbxJSOCndPay_Have.ItemIndex = 2 then { Есть платежи }
      StrSlPayCondition := StrSlPayCondition + ' and not exists(select op.RN from WorkWith_Gamma.dbo.t_jso_OrderPay op with (nolock) where op.[Order] = ccjs.orderID) ';
    StrSlPayCondition := StrSlPayCondition +
                         ' and ccjs.orderID in ' +
                         '  ( '+
                         '   select vpay.NOrder from WorkWith_Gamma.dbo.v_jso_OrderPay vpay with (nolock) ' +
					               '   where 1 = 1 ';
    if length(trim(edJSOCndPay_BarCode.Text)) > 0 then
      StrSlPayCondition := StrSlPayCondition +
                            ' and vpay.SBarCode like ' + '''%' + edJSOCndPay_BarCode.Text + '%''';
    if length(trim(JSOCondRec.PaySumFrom)) > 0 then
      StrSlPayCondition := StrSlPayCondition +
                            ' and vpay.NDocSumPay >= ' + JSOCondRec.PaySumFrom;
    if length(trim(JSOCondRec.PaySumTo)) > 0 then
      StrSlPayCondition := StrSlPayCondition +
                            ' and vpay.NDocSumPay <= ' + JSOCondRec.PaySumTo;
    if length(trim(JSOCondRec.PayDateBegin)) > 0 then begin
      SPayDate := FormatDateTime('yyyy-mm-dd hh:nn:ss',StrToDateTime(JSOCondRec.PayDateBegin,DFormatSet));
      StrSlPayCondition := StrSlPayCondition +
                            ' and vpay.DNormDocDate >= ''' + SPayDate + '''';
    end;
    if length(trim(JSOCondRec.PayDateEnd)) > 0 then begin
      SPayDate := FormatDateTime('yyyy-mm-dd hh:nn:ss',StrToDateTime(JSOCondRec.PayDateEnd,DFormatSet));
      StrSlPayCondition := StrSlPayCondition +
                            ' and vpay.DNormDocDate <= ''' + SPayDate + '''';
    end;
    if length(trim(JSOCondRec.PayRedeliveryDateBegin)) > 0 then begin
      SPayDate := FormatDateTime('yyyy-mm-dd hh:nn:ss',StrToDateTime(JSOCondRec.PayRedeliveryDateBegin,DFormatSet));
      StrSlPayCondition := StrSlPayCondition +
                            ' and vpay.DRedeliveryDate >= ''' + SPayDate + '''';
    end;
    if length(trim(JSOCondRec.PayRedeliveryEnd)) > 0 then begin
      SPayDate := FormatDateTime('yyyy-mm-dd hh:nn:ss',StrToDateTime(JSOCondRec.PayRedeliveryEnd,DFormatSet));
      StrSlPayCondition := StrSlPayCondition +
                            ' and vpay.DRedeliveryDate <= ''' + SPayDate + '''';
    end;
    if length(trim(JSOCondRec.PayCreateDateBegin)) > 0 then begin
      SPayDate := FormatDateTime('yyyy-mm-dd hh:nn:ss',StrToDateTime(JSOCondRec.PayCreateDateBegin,DFormatSet));
      StrSlPayCondition := StrSlPayCondition +
                            ' and vpay.DCreateDate >= ''' + SPayDate + '''';
    end;
    if length(trim(JSOCondRec.PayCreateDateEnd)) > 0 then begin
      SPayDate := FormatDateTime('yyyy-mm-dd hh:nn:ss',StrToDateTime(JSOCondRec.PayCreateDateEnd,DFormatSet));
      StrSlPayCondition := StrSlPayCondition +
                            ' and vpay.DCreateDate <= ''' + SPayDate + '''';
    end;
    StrSlPayCondition := StrSlPayCondition + ')';
  end; { not GetStateClearPayCondition }

  {--* JSONPostPayCondition *--}

  if not GetStateClearNPostPayCondition then begin
    if JSOCondRec.NPostHavePay = 1 then { Есть платежи }
      StrSlNPostPayCondition := StrSlNPostPayCondition + ' and exists(select cshd.RN from WorkWith_Gamma.dbo.t_jso_NPostCashDelivery cshd with (nolock) where cshd.PRN = ccjs.orderID) ';
    if cmbxJSOCndPay_Have.ItemIndex = 2 then { нет платежей }
      StrSlNPostPayCondition := StrSlNPostPayCondition + ' and not exists(select cshd.RN from WorkWith_Gamma.dbo.t_jso_NPostCashDelivery cshd with (nolock) where cshd.PRN = ccjs.orderID) ';
    StrSlNPostPayCondition := StrSlNPostPayCondition +
                         ' and ccjs.orderID in ' +
                         '  ( '+
                         '   select vnp.NPRN from WorkWith_Gamma.dbo.v_jso_NPostCachDelivery vnp with (nolock) ' +
					               '   where 1 = 1 ';
    if length(trim(JSOCondRec.NPostBarCode)) > 0 then
      StrSlNPostPayCondition := StrSlNPostPayCondition +
                            ' and vnp.SChildBarCode like ' + '''%' + JSOCondRec.NPostBarCode + '%''';
    if length(trim(JSOCondRec.NPostPaySumFrom)) > 0 then
      StrSlNPostPayCondition := StrSlNPostPayCondition +
                            ' and vnp.CRedeliverySum >= ' + JSOCondRec.NPostPaySumFrom;
    if length(trim(JSOCondRec.NPostPaySumTo)) > 0 then
      StrSlNPostPayCondition := StrSlNPostPayCondition +
                            ' and vnp.CRedeliverySum <= ' + JSOCondRec.NPostPaySumTo;
    if length(trim(JSOCondRec.NPostPayRedeliveryDateBegin)) > 0 then begin
      SPayDate := FormatDateTime('yyyy-mm-dd hh:nn:ss',StrToDateTime(JSOCondRec.NPostPayRedeliveryDateBegin,DFormatSet));
      StrSlNPostPayCondition := StrSlNPostPayCondition +
                            ' and vnp.DChildDateReceived >= ''' + SPayDate + '''';
    end;
    if length(trim(JSOCondRec.NPostPayRedeliveryEnd)) > 0 then begin
      SPayDate := FormatDateTime('yyyy-mm-dd hh:nn:ss',StrToDateTime(JSOCondRec.NPostPayRedeliveryEnd,DFormatSet));
      StrSlNPostPayCondition := StrSlNPostPayCondition +
                            ' and vnp.DChildDateReceived <= ''' + SPayDate + '''';
    end;
    if length(trim(JSOCondRec.NPostPayCreateDateBegin)) > 0 then begin
      SPayDate := FormatDateTime('yyyy-mm-dd hh:nn:ss',StrToDateTime(JSOCondRec.NPostPayCreateDateBegin,DFormatSet));
      StrSlNPostPayCondition := StrSlNPostPayCondition +
                            ' and vnp.DCreateDate >= ''' + SPayDate + '''';
    end;
    if length(trim(JSOCondRec.NPostPayCreateDateEnd)) > 0 then begin
      SPayDate := FormatDateTime('yyyy-mm-dd hh:nn:ss',StrToDateTime(JSOCondRec.NPostPayCreateDateEnd,DFormatSet));
      StrSlNPostPayCondition := StrSlNPostPayCondition +
                            ' and vnp.DCreateDate <= ''' + SPayDate + '''';
    end;
    StrSlNPostPayCondition := StrSlNPostPayCondition + ')';
  end; { not GetStateClearNPostPayCondition }

  qrMain.SQL.Clear;
  qrMain.SQL.Add(StrSelect + StrSlCondition + StrSlSlaveCondition + StrSlHistCondition + StrSlPayCondition + StrSlNPostPayCondition + StrSlOrder);
  //qrMain.SQL.SaveToFile('d:\pgksoft\sql.txt');
end; (* TFCCenterJournalNetZkz.CreateConditionQRMain *)

procedure TFCCenterJournalNetZkz.JRMOGridMainRefresh;
var
  RNOrderID: Integer;
begin
  if not qrspJRMOMain.IsEmpty then RNOrderID := qrspJRMOMain.FieldByName('NOrderID').AsInteger else RNOrderID := -1;
  qrspJRMOMain.Requery;
  qrspJRMOMain.Locate('NOrderID', RNOrderID, []);
end; (* TFCCenterJournalNetZkz.GridMainRefresh *)

Procedure TFCCenterJournalNetZkz.CreateConditionJRMOMain;
var
  SArtCode  : string;
  SArtName  : string;
  SClient   : string;
  SPhone    : string;
begin
  if length(trim(edCndJRMOArtCode.Text)) = 0 then SArtCode  := '' else SArtCode := edCndJRMOArtCode.Text;
  if length(trim(edCndJRMOArtName.Text)) = 0 then SArtName  := '' else SArtName := edCndJRMOArtName.Text;
  if length(trim(edCndJRMOClient.Text)) = 0  then SClient   := '' else SClient  := edCndJRMOClient.Text;
  if length(trim(edCndJRMOPhone.Text)) = 0   then SPhone    := '' else SPhone   := edCndJRMOPhone.Text;
  qrspJRMOMain.Parameters.ParamValues['@SBegin']  := FormatDateTime('yyyy-mm-dd', dtCndJRMOBegin.Date);
  qrspJRMOMain.Parameters.ParamValues['@SEnd']    := FormatDateTime('yyyy-mm-dd', IncDay(dtCndJRMOEnd.Date,1));
  qrspJRMOMain.Parameters.ParamValues['@ArtCode'] := SArtCode;
  qrspJRMOMain.Parameters.ParamValues['@ArtName'] := SArtName;
  qrspJRMOMain.Parameters.ParamValues['@Client']  := SClient;
  qrspJRMOMain.Parameters.ParamValues['@Phone']   := SPhone;
  qrspJRMOMain.Parameters.ParamValues['@Action']  := JRMOHist_RNUserAction;
  qrspJRMOMain.Parameters.ParamValues['@State']   := cmbxCndJRMOState.ItemIndex;
end;

Procedure TFCCenterJournalNetZkz.CreateConditionJFBMain;
var
  IType    : smallint;
  SAllNAme : string;
  SPhone   : string;
  SEMail   : string;
  SMessage : string;
begin
  IType    := 0;
  SAllNAme := '';
  SPhone   := '';
  SEMail   := '';
  SMessage := '';
  if length(trim(edJFBCnd_Client.Text)) <> 0 then SAllNAme := edJFBCnd_Client.Text;
  if length(trim(edJFBCnd_Phone.Text))  <> 0 then SPhone   := edJFBCnd_Phone.Text;
  if length(trim(edJFBCnd_EMail.Text))  <> 0 then SEMail   := edJFBCnd_EMail.Text;
  if length(trim(edJFBCnd_Msg.Text))    <> 0 then SMessage := edJFBCnd_Msg.Text;
  qrspJFBMain.Parameters.ParamValues['@SBegin']  := FormatDateTime('yyyy-mm-dd', dtCndJFBBegin.Date);
  qrspJFBMain.Parameters.ParamValues['@SEnd']    := FormatDateTime('yyyy-mm-dd', IncDay(dtCndJFBEnd.Date,1));
  qrspJFBMain.Parameters.ParamValues['@Type']    := IType;
  qrspJFBMain.Parameters.ParamValues['@AllNAme'] := SAllNAme;
  qrspJFBMain.Parameters.ParamValues['@Phone']   := SPhone;
  qrspJFBMain.Parameters.ParamValues['@EMail']   := SEMail;
  qrspJFBMain.Parameters.ParamValues['@Message'] := SMessage;
end;

Procedure TFCCenterJournalNetZkz.CreateConditionJCallMain;
var
  SAllNAme : string;
  SPhone   : string;
begin
  SAllNAme := '';
  SPhone   := '';
  if length(trim(edJCallCnd_Client.Text)) <> 0 then SAllNAme := edJCallCnd_Client.Text;
  if length(trim(edJCallCnd_Phone.Text))  <> 0 then SPhone   := edJCallCnd_Phone.Text;
  qrspJCallMain.Parameters.ParamValues['@SBegin'] := FormatDateTime('yyyy-mm-dd', dtCndJCallBegin.Date);
  qrspJCallMain.Parameters.ParamValues['@SEnd']   := FormatDateTime('yyyy-mm-dd', IncDay(dtCndJCallEnd.Date,1));
  qrspJCallMain.Parameters.ParamValues['@Client'] := SAllNAme;
  qrspJCallMain.Parameters.ParamValues['@Phone']  := SPhone;
  qrspJCallMain.Parameters.ParamValues['@Action'] := 0;
  qrspJCallMain.Parameters.ParamValues['@State']  := 0;
end;

Procedure TFCCenterJournalNetZkz.ExecConditionJRMOMain;
var
  RNOrderID: Integer;
begin
  if not qrspJRMOMain.IsEmpty then RNOrderID := qrspJRMOMain.FieldByName('NOrderID').AsInteger else RNOrderID := -1;
  qrspJRMOMain.Active := false;
  CreateConditionJRMOMain;
  qrspJRMOMain.Active := true;
  qrspJRMOMain.Locate('NOrderID', RNOrderID, []);
  JRMOShowGets;
end;

Procedure TFCCenterJournalNetZkz.ExecConditionJCallMain;
var
  RNOrderID: Integer;
begin
  if not qrspJCallMain.IsEmpty then RNOrderID := qrspJCallMain.FieldByName('NRN').AsInteger else RNOrderID := -1;
  qrspJCallMain.Active := false;
  CreateConditionJCallMain;
  qrspJCallMain.Active := true;
  qrspJCallMain.Locate('NRN', RNOrderID, []);
  JCallShowGets;
end;

procedure TFCCenterJournalNetZkz.ExecConditionJRMOItem;
begin
  if JRMOGridMain.DataSource.DataSet.IsEmpty then begin
    qrspJRMOItem.Active := false;
    qrspJRMOItem.Parameters.ParamByName('@PRN').Value := 0;
    qrspJRMOItem.Active := true;
  end else begin
    qrspJRMOItem.Active := false;
    qrspJRMOItem.Parameters.ParamByName('@PRN').Value := JRMOGridMain.DataSource.DataSet.FieldByName('NOrderID').AsInteger;
    qrspJRMOItem.Active := true;
  end;
end;

procedure TFCCenterJournalNetZkz.ExecConditionJRMOHist;
begin
  if JRMOGridMain.DataSource.DataSet.IsEmpty then begin
    qrspJRMOHist.Active := false;
    qrspJRMOHist.Parameters.ParamByName('@PRN').Value := 0;
    qrspJRMOHist.Active := true;
  end else begin
    qrspJRMOHist.Active := false;
    qrspJRMOHist.Parameters.ParamByName('@PRN').Value := JRMOGridMain.DataSource.DataSet.FieldByName('NorderID').AsInteger;
    qrspJRMOHist.Active := true;
  end;
end;

Procedure TFCCenterJournalNetZkz.ExecConditionJFBMain;
var
  RNOrderID: Integer;
begin
  if not qrspJFBMain.IsEmpty then RNOrderID := qrspJFBMain.FieldByName('NRN').AsInteger else RNOrderID := -1;
  qrspJFBMain.Active := false;
  CreateConditionJFBMain;
  qrspJFBMain.Active := true;
  qrspJFBMain.Locate('NRN', RNOrderID, []);
  JFBShowGets;
end;

procedure TFCCenterJournalNetZkz.ExecConditionJCallHist;
begin
  if JCallGridMain.DataSource.DataSet.IsEmpty then begin
    qrspJCall_Hist.Active := false;
    qrspJCall_Hist.Parameters.ParamByName('@PRN').Value := 0;
    qrspJCall_Hist.Active := true;
  end else begin
    qrspJCall_Hist.Active := false;
    qrspJCall_Hist.Parameters.ParamByName('@PRN').Value := JCallGridMain.DataSource.DataSet.FieldByName('NRN').AsInteger;
    qrspJCall_Hist.Active := true;
  end;
end;

procedure TFCCenterJournalNetZkz.ExecConditionJCallEnumerator;
begin
  if JCallGridMain.DataSource.DataSet.IsEmpty then begin
    qrspJCall_Enumerator.Active := false;
    qrspJCall_Enumerator.Parameters.ParamByName('@PRN').Value := 0;
    qrspJCall_Enumerator.Active := true;
  end else begin
    qrspJCall_Enumerator.Active := false;
    qrspJCall_Enumerator.Parameters.ParamByName('@PRN').Value := JCallGridMain.DataSource.DataSet.FieldByName('NRN').AsInteger;
    qrspJCall_Enumerator.Active := true;
  end;
end;

(* Корректировка высоты и ширины диалоговых элементов при обработке события FormResize *)
Procedure TFCCenterJournalNetZkz.ShowResize;
begin
  (* Перерасчет относительного размера гридов Main и Slave *)
  pnlMainGrid.Height := round(GetKoefShowSplit * FCCenterJournalNetZkz.Height) - pnlMainGrid.Top;
  pnlJRMOMainGrid.Height := round(GetKoefJRMOShowSplit * FCCenterJournalNetZkz.Height) - pnlJRMOMainGrid.Top;
  pnlJFBMainGrid.Height := round(GetKoefJFBShowSplit * FCCenterJournalNetZkz.Height) - pnlJFBMainGrid.Top;
  pnlJCallGridMain.Height := round(GetKoefJCallShowSplit * FCCenterJournalNetZkz.Height) - pnlJCallGridMain.Top;
  { Боковая панель }
  if pnlOneSide.Visible and spliterOne.Visible then begin
    pnlOneSide.Width := round(FCCenterJournalNetZkz.Width/GetKoefSplitOneSide);
    ShowSpliterOneMoved;
  end;
  { Перерисовка дополнительных элементов }
  { Панель отображения номера заказа при его поиске через набор на клавиаторе }
  if pnlLocate.Visible then pnlLocate.Top := DBGridMain.Height - pnlLocate.Height - 3;
end; (* TFCCenterJournalNetZkz.ShowResize *)

(* Расчет коэффициента  *)
procedure TFCCenterJournalNetZkz.SetKoefSplitOneSide;
begin
  NKoefSplitOneSide := FCCenterJournalNetZkz.Width / pnlOneSide.Width ;
end;

procedure TFCCenterJournalNetZkz.SetKoefSplitNtfCenter;
begin
  NKoefSplitNtfCenter := (pnlOneSide.Height-pnlOneSide_Tool.Height) / pnlOneSide_NtfCenter.Height ;
end;

procedure TFCCenterJournalNetZkz.SetKoefShowSplit;
begin
  NKoefShowSplit := spltMainSlave.Top / FCCenterJournalNetZkz.Height ;
  { Перерисовка дополнительных элементов }
  if pnlLocate.Visible then pnlLocate.Top := DBGridMain.Height - pnlLocate.Height - 3;
end; (* TFCCenterJournalNetZkz.SetKoefShowSplit *)

procedure TFCCenterJournalNetZkz.SetKoefJRMOShowSplit;
begin
  NKoefJRMOShowSplit := splitJRMOMain.Top / FCCenterJournalNetZkz.Height ;
end;

procedure TFCCenterJournalNetZkz.SetKoefJFBShowSplit;
begin
  NKoefJFBShowSplit := splitJFBMain.Top / FCCenterJournalNetZkz.Height ;
end;

procedure TFCCenterJournalNetZkz.SetKoefJCallShowSplit;
begin
  NKoefJCallShowSplit := splitJCallMain.Top / FCCenterJournalNetZkz.Height ;
end;

function TFCCenterJournalNetZkz.GetKoefSplitOneSide : real; begin result := NKoefSplitOneSide; end;
function TFCCenterJournalNetZkz.GetKoefSplitNtfCenter : real; begin result := NKoefSplitNtfCenter; end;
function TFCCenterJournalNetZkz.GetKoefShowSplit : real; begin result := NKoefShowSplit; end;
function TFCCenterJournalNetZkz.GetKoefJRMOShowSplit : real; begin result := NKoefJRMOShowSplit; end;
function TFCCenterJournalNetZkz.GetKoefJFBShowSplit : real; begin result := NKoefJFBShowSplit; end;
function TFCCenterJournalNetZkz.GetKoefJCallShowSplit : real; begin result := NKoefJCallShowSplit; end;

procedure TFCCenterJournalNetZkz.FormResize(Sender: TObject);
begin
  ShowResize;
end; (* TFCCenterJournalNetZkz.FormResize *)

{ Управление признаком нового заказа }
procedure TFCCenterJournalNetZkz.JSOSetOrderProcessed(Order : integer; IDUSER : integer);
var
  IErr : integer;
  SErr : string;
begin
  IErr := 0;
  SErr := '';
    try
      spJSOSetOrderProcessed.Parameters.ParamValues['@Order']   := Order;
      spJSOSetOrderProcessed.Parameters.ParamValues['@ID_USER'] := IDUSER;
      spJSOSetOrderProcessed.ExecProc;
      IErr := spJSOSetOrderProcessed.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr <> 0 then begin
        SErr := spJSOSetOrderProcessed.Parameters.ParamValues['@SErr'];
      end;
    except
      on e:Exception do begin
      end;
    end;
end;

procedure TFCCenterJournalNetZkz.UserBegin;
var
  IErr : integer;
  SErr : string;
begin
  try
    spUserBegin.Parameters.ParamValues['@IDENT']           := UserSession.IDENT;
    spUserBegin.Parameters.ParamValues['@USER']            := RegAction.NUSER;
    spUserBegin.Parameters.ParamValues['@LocalIP']         := UserSession.LocalIP;
    spUserBegin.Parameters.ParamValues['@ComputerNetName'] := UserSession.ComputerNetName;
    spUserBegin.Parameters.ParamValues['@UserFromWindows'] := UserSession.UserFromWindows;
    spUserBegin.ExecProc;
    IErr := spUserBegin.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      SErr := spUserBegin.Parameters.ParamValues['@SErr'];
      ShowMessage('Сбой при регистрации активного пользователя.' + chr(10) + SErr);
    end else begin
      UserSession.RN := spUserBegin.Parameters.ParamValues['@RN'];
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при регистрации активного пользователя.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.UserActive;
var
  IErr : integer;
  SErr : string;
begin
  try
    spUserActive.Parameters.ParamValues['@RN']    := UserSession.RN;
    spUserActive.Parameters.ParamValues['@IDENT'] := UserSession.IDENT;
    spUserActive.Parameters.ParamValues['@USER']  := RegAction.NUSER;
    spUserActive.ExecProc;
  except
    on e:Exception do begin
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.UserClose;
var
  IErr : integer;
  SErr : string;
begin
  try
    spUserClose.Parameters.ParamValues['@RN']         := UserSession.RN;
    spUserClose.Parameters.ParamValues['@IDENT']      := UserSession.IDENT;
    spUserClose.Parameters.ParamValues['@USER']       := RegAction.NUSER;
    spUserClose.Parameters.ParamValues['@SignForced'] := 0;
    spUserClose.ExecProc;
    IErr := spUserClose.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      SErr := spUserClose.Parameters.ParamValues['@SErr'];
      ShowMessage('Сбой при закрытии активного пользователя.' + chr(10) + SErr);
    end else begin
      UserSession.RN := spUserBegin.Parameters.ParamValues['@RN'];
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при закрытии активного пользователя.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.FormCreate(Sender: TObject);
var
  vCol: TColumn;
  style: cardinal;
begin
  Application.OnMessage := AppMessage;
//  Application.OnActivate := ApplicationActivate;
  (* Инициализация данных *)
  FOrderHeaderDS := qrMain;
  FIP := Self.GetIP;
  FCompName := Self.GetCompName;
  style := GetWindowLong(edOrder.Handle, GWL_STYLE);
  SetWindowLong(edOrder.Handle, GWL_STYLE, style + ES_NUMBER);

  uSprQuery.SetFieldsFormat(FOrderHeaderDS);

  dsConds.DataSet := dmJSO.qrConds;
  dmJSO.qrConds.Active := True;

  with ControlPanelSide do begin
    ControlMouseEnter := self;
    ControlMouseLeave := self;
    TagEnter := 0;
    TagLeave := 0;
  end;
  AlertPopupWindowControl := TAlertPopupWindowControl.Create;
  AlertPanel              := TAlertPanel.Create;
  IEnabledalertWindow := true;
  BStateFlashWindow   := false;
  {---}
  ISignKeepParmXNL                   := 0; { csKeepParmXMLFile }
  NameParmXML                        := ExtractFilePath(Application.ExeName) + 'FCCenterJournalNetZkz.xml';
  NKoefSplitOneSide                  := 6;
  NKoefSplitNtfCenter                := 2;
  NKoefShowSplit                     := 0.65;
  NKoefJRMOShowSplit                 := 0.7;
  NKoefJFBShowSplit                  := 0.7;
  NKoefJCallShowSplit                := 0.7;
  ISign_Active                       := 0;
  IJRMOSign_Active                   := 0;
  IJFBSign_Active                    := 0;
  IJCallSign_Active                  := 0;
  ISign_ResThreadLoad                := 0;
  IState_ThreadLoad                  := -1;
  IOldState_ThreadLoad               := IState_ThreadLoad;
  DLastRefresh                       := 0;
  { Условия отбора }
  dtCndBegin.Date                    := date;
  dtCndEnd.Date                      := date;
  dtCndAmountDateBegin.Date          := IncDay(date,-1);
  dtCndAmountDateEnd.Date            := date;
  dtCndJRMOBegin.Date                := date;
  dtCndJRMOEnd.Date                  := date;
  dtCndJFBBegin.Date                 := date;
  dtCndJFBEnd.Date                   := date;
  dtCndJCallBegin.Date               := date;
  dtCndJCallEnd.Date                 := date;
  { JSO - Поля расширенного отбора }
  JSOCondRec.USER                        := Form1.id_user;
  JSOCondRec.SignOrderPeriod             := 0;  { Вид контрольного периода даты заказа }
  JSOCondRec.BeginClockDate              := Date;
  JSOCondRec.BeginClockTime              := EncodeTime(0, 0, 0, 0);
  JSOCondRec.EndClockDate                := Date;
  JSOCondRec.EndClockTime                := Time;
  JSOCondRec.SOrderID                    := '';
  JSOCondRec.Payment                     := '';
  JSOCondRec.SCity                       := '';
  JSOCondRec.SignNewOrder                := 0;
  JSOCondRec.SGeoGroupPharm              := '';
  JSOCondRec.NGeoGroupPharm              := 0;
  JSOCondRec.SignGeoGroupPharmNotDefined := false;
  JSOCondRec.SignDefinedPharm            := 0;
  JSOCondRec.SignMark                    := 0;
  JSOCondRec.NMarkOtherUser              := 0;
  JSOCondRec.SMarkOtherUser              := '';
  JSOCondRec.NPOST_StateID               := 0;
  JSOCondRec.SNPOST_StateName            := '';
  JSOCondRec.NPOST_SignStateDate         := false;
  JSOCondRec.DNPOST_StateBegin           := date;
  JSOCondRec.DNPOST_StateEnd             := date;
  JSOCondRec.SignPeriod_PDS              := 0;
  JSOCondRec.BeginDate_PDS               := Date;
  JSOCondRec.EndDate_PDS                 := Date;
  JSOCondRec.BeginClockDate_PDS          := Date;
  JSOCondRec.BeginClockTime_PDS          := EncodeTime(0, 0, 0, 0);
  JSOCondRec.EndClockDate_PDS            := Date;
  JSOCondRec.EndClockTime_PDS            := Time;
  JSOCondRec.SignLink                    := 0;
  JSOCondRec.SignStockDate               := 0;
  JSOCondRec.SStockDateBegin             := '';
  JSOCondRec.SStockDateEnd               := '';
  JSOCondRec.PaySumFrom                  := '';
  JSOCondRec.PaySumTo                    := '';
  JSOCondRec.PayDateBegin                := '';
  JSOCondRec.PayDateEnd                  := '';
  JSOCondRec.PayRedeliveryDateBegin      := '';
  JSOCondRec.PayRedeliveryEnd            := '';
  JSOCondRec.PayCreateDateBegin          := '';
  JSOCondRec.PayCreateDateEnd            := '';
  JSOCondRec.NPostHavePay                := 0;
  JSOCondRec.NPostBarCode                := '';
  JSOCondRec.NPostPaySumFrom             := '';
  JSOCondRec.NPostPaySumTo               := '';
  JSOCondRec.NPostPayRedeliveryDateBegin := '';
  JSOCondRec.NPostPayRedeliveryEnd       := '';
  JSOCondRec.NPostPayCreateDateBegin     := '';
  JSOCondRec.NPostPayCreateDateEnd       := '';
  LocateOrder                        := '';
  pnlLocate.Visible                  := false;
  RegAction.NUSER                    := Form1.id_user;
  dmJSO.UserId                       := RegAction.NUSER; 
  RegAction.RN                       := 0;
  SignStateStreamActiveAction        := 0;
  //Сортировка
  vCol := DBGridMain.Columns[0];
  if Assigned(vCol) then
  begin
    MainSortField := vCol.FieldName + ' desc ';
    vCol.Title.Font.Color := clFuchsia;
    vCol.Title.Font.Style := [fsBold];
    vCol.Title.Caption := '!'+copy(vCol.Title.Caption,2,length(vCol.Title.Caption)-1);
  end
  else
    MainSortField := '';
  edColor.Visible                    := false;
  cmbxCndState.ItemIndex             := 3;
  cmbxJSOCndPay_Have.ItemIndex       := 0;
  tmrJournalAlert.Enabled            := false;
  IJSOSignMassChangeCondition        := 0;
  JSOHist_RNUserAction               := 0;
  JRMOHist_RNUserAction              := 0;
  { Картинки-признаки для гридов }
  imgMain.GetBitmap(222,imgArmor.Picture.Bitmap);          imgArmor.Repaint;
  imgMain.GetBitmap(220, imgComeBack.Picture.Bitmap);      imgComeBack.Repaint;
  imgMain.GetBitmap(224, imgReserve.Picture.Bitmap);       imgReserve.Repaint;
  imgMain.GetBitmap(223, imgDistrToPharm.Picture.Bitmap);  imgDistrToPharm.Repaint;
  imgMain.GetBitmap(269, imgTypeKeep.Picture.Bitmap);      imgTypeKeep.Repaint;
  imgMain.GetBitmap(356, imgSignEnable.Picture.Bitmap);    imgSignEnable.Repaint;
  imgMain.GetBitmap(358, imgSignDisable.Picture.Bitmap);   imgSignDisable.Repaint;
  { Внимание !!! с 04.10.2014 закрузка выполняется путем выполнения задачи в MS SQL SERVER }
  { Программный код не удаляю. Просто отключаем таймеры и закрываю ручную загрузку }
  tmrRefresh.Enabled           := false;
  tmrCheckRefresh.Enabled      := false;
  { Видимость полей }
  { get_column_by_fieldname('orderPayment',DBGridMain).Visible := false; }
  get_column_by_fieldname('orderCurrency',DBGridMain).Visible := false;
  { Отключаем боковую панель }
  pnlOneSide.Visible := false;
  spliterOne.Visible  := false;
  { Инициализация управления боковой панелью }
  ControlPanelSide.ISignOldActivePnlSide := false;
  ControlPanelSide.ISignActiveNtfCenter  := 0;
  ControlPanelSide.ISIgnActiveOrdPlan    := 0;
  { Регистрация активного пользователя }
  LoacalIdIPWatch.Active := True;
  UserSession.LocalIP := LoacalIdIPWatch.LocalIP;
  LoacalIdIPWatch.Active := False;
  UserSession.IDENT := GetIdUserAction;
  UserSession.RN := 0;
  UserSession.ComputerNetName := GetComputerNetName;
  UserSession.UserFromWindows := GetUserFromWindows;
  UserSession.CurrentUser := Form1.id_user;
  UserSession.CurrentNameUser := Form1.user_name;
  UserBegin;
end; (* TFCCenterJournalNetZkz.FormCreate *)

procedure TFCCenterJournalNetZkz.spltMainSlaveMoved(Sender: TObject);
begin
  SetKoefShowSplit;
end; (* TFCCenterJournalNetZkz.spltMainSlaveMoved *)

procedure TFCCenterJournalNetZkz.dsMainDataChange(Sender: TObject; Field: TField);
begin
  if pgcSlave.ActivePage = tabSlave_Order then begin
    if OrderHeaderDS.IsEmpty then begin
      qrspSlave.Active := false;
      qrspSlave.Parameters.ParamByName('@PRN').Value := 0;
      qrspSlave.Active := true;
    end else begin
      qrspSlave.Active := false;
      qrspSlave.Parameters.ParamByName('@PRN').Value := OrderHeaderDS.FieldByName('orderID').AsInteger;
      qrspSlave.Active := true;
    end;
  end else
  if pgcSlave.ActivePage = tabSlave_History then begin
    if OrderHeaderDS.IsEmpty then begin
      qrspJSOHistory.Active := false;
      qrspJSOHistory.Parameters.ParamByName('@Order').Value := 0;
      qrspJSOHistory.Active := true;
    end else begin
      qrspJSOHistory.Active := false;
      qrspJSOHistory.Parameters.ParamByName('@Order').Value := OrderHeaderDS.FieldByName('orderID').AsInteger;
      qrspJSOHistory.Active := true;
    end;
  end else
  if pgcSlave.ActivePage = tabSlave_Pay then begin
    ExecConditionJSOPay;
    if aJSOPay_ShowCheck.Checked then ExecConditionJSOCheck;
  end else
  if pgcSlave.ActivePage = tabSlave_NPost then begin
    ExecConditionJSONPost;
  end;
  if pgcSlave.ActivePage = tabSlave_NPostPay then begin
    ExecConditionJSONPostPay;
  end;
  if pgcSlave.ActivePage = tabSlave_PayTransaction then
  begin
    dmJSO.ExecConditionPayTransaction(OrderHeaderDS.FieldByName('orderID').AsInteger);
  end;
  if pgcSlave.ActivePage = tabSlave_Queue then
  begin
    dmJSO.GetOrderQueue(OrderHeaderDS.FieldByName('orderID').AsInteger, true);
  end;
  if pgcSlave.ActivePage = tabSlave_OrderHistory then
  begin
    dmJSO.GetOrderHistory(OrderHeaderDS.FieldByName('orderID').AsInteger, true);
  end;
  ShowGets;
end; (* TFCCenterJournalNetZkz.dsMainDataChange *)

procedure TFCCenterJournalNetZkz.FormClose(Sender: TObject; var Action: TCloseAction);
var
  IErr : integer;
  SErr : string;
begin
  action := caFree;
  // Запрет на закрытие формы
  if IState_ThreadLoad = 1 then begin
    action := caNone;
    ShowMessage('Выполняется обновление данных. Закрытие формы временно запрещено.');
  end else if AlertPopupWindowControl.AWList.Count > 0 then begin
    action := caNone;
    ShowMessage('Закройте всплывающие окна центра уведомлений.');
  end else begin
    { Чистим данные по всплывающим окнам центра уведомлений }
    AlertPopupWindowControl.Destroy();
    { Чистим данные по панелям центра уведомлений }
    AlertPanel.Destroy();
    { Чистим списки выбранных записей раздела }
    if JSOCondIdent > 0 then begin
      DM_CCJSO.SLClear(JSOCondIdent,IErr,SErr);
    end;
    { Закрываем сессию пользователя }
    UserClose;
    { Теперь форму можно закрыть }
    action := caFree;
  end;
  { Сохраняем параметры диалога }
  {
  SavePropClassToXML
   (
    FCCenterJournalNetZkz,
    NameParmXML,
    ISignKeepParmXNL,
    Form1.ADOC_STAT
   );
   }
end;

procedure TFCCenterJournalNetZkz.FormActivate(Sender: TObject);
var
  iCkl     : integer;
  TypeCode : string;
  IErr     : integer;
  SErr     : string;
begin
  if ISign_Active = 0 then begin
    Self.Caption := Self.Caption + ' [' + Self.FIP + ']' + '[' + Self.FCompName + ']';
    //btnJSOCondExt.Caption := 'Расширенные' + #13#10 + 'условия' + #13#10 + 'отбора';
    //ShowVersion;
    JSOCondIdent := 0;
    { Инициализация пользовательских параметров }
    DM_CCJSO.InitParmCustomerOrders(UserSession.CurrentUser);
    { Страницы по умолчанию }
    pgcJSO_JBO.ActivePage := tabJSO;
    pgcSlave.ActivePage := tabSlave_Order;
    pgctrlCondition.ActivePage := tabJournal;
    pgcJRMOCondition.ActivePage  := tabJRMOCondition_Order;
    pgcJRMOSlave.ActivePage := tabJRMOSlave_Armour;
    pgcJFBCondition.ActivePage := tabJFBCondition_Doc;
    pgcJCallCondition.ActivePage := tabJCallCondition_Doc;
    pgcJCallSlave.ActivePage :=  tabJCallSlave_Enumerator;
    Width_pnlSlave_PayGrid_Pay := pnlSlave_PayGrid_Pay.Width;
    { Определение высоты гридов }
    ShowResize;
    { Журнал интернет заказов }
    qrMain.Active := false;
    CreateConditionQRMain;
    qrMain.Active := true;
    { Генерим уникальный идентификатор пользовательского процесса }
    spGetIdent.ExecProc;
    SIDENT := spGetIdent.Parameters.ParamValues['@IDENT'];
    { Инициализация условий отбора журнала интернет заказов }
    JSOCondRec.bSignRefPhone := false;
    JSOCondRec.NPharmacy     := 0;
    { Сохраняем значения полей условия отбора журнала интернет заказов}
    JSOSaveCondition;

    { Активация формы завершилась }
    ISign_Active := 1;
    { Запускаем механизм уведомлений (центр оповещений) }
    AlertPanel.ShowPanels;
    pnlAlert01.BorderStyle := bsNone;
      edAlert01Date.BorderStyle    := bsNone;
      edAlert01Type.BorderStyle    := bsNone;
      edAlert01Content.BorderStyle := bsNone;
    pnlAlert02.BorderStyle := bsNone;
      edAlert02Date.BorderStyle    := bsNone;
      edAlert02Type.BorderStyle    := bsNone;
      edAlert02Content.BorderStyle := bsNone;
    pnlAlert03.BorderStyle := bsNone;
      edAlert03Date.BorderStyle    := bsNone;
      edAlert03Type.BorderStyle    := bsNone;
      edAlert03Content.BorderStyle := bsNone;
    pnlAlert04.BorderStyle := bsNone;
      edAlert04Date.BorderStyle    := bsNone;
      edAlert04Type.BorderStyle    := bsNone;
      edAlert04Content.BorderStyle := bsNone;
    pnlAlert05.BorderStyle := bsNone;
      edAlert05Date.BorderStyle    := bsNone;
      edAlert05Type.BorderStyle    := bsNone;
      edAlert05Content.BorderStyle := bsNone;
    pnlAlert06.BorderStyle := bsNone;
      edAlert06Date.BorderStyle    := bsNone;
      edAlert06Type.BorderStyle    := bsNone;
      edAlert06Content.BorderStyle := bsNone;
    pnlAlert07.BorderStyle := bsNone;
      edAlert07Date.BorderStyle    := bsNone;
      edAlert07Type.BorderStyle    := bsNone;
      edAlert07Content.BorderStyle := bsNone;
    pnlAlert08.BorderStyle := bsNone;
      edAlert08Date.BorderStyle    := bsNone;
      edAlert08Type.BorderStyle    := bsNone;
      edAlert08Content.BorderStyle := bsNone;
    pnlAlert09.BorderStyle := bsNone;
      edAlert09Date.BorderStyle    := bsNone;
      edAlert09Type.BorderStyle    := bsNone;
      edAlert09Content.BorderStyle := bsNone;
    pnlAlert10.BorderStyle := bsNone;
      edAlert10Date.BorderStyle    := bsNone;
      edAlert10Type.BorderStyle    := bsNone;
      edAlert10Content.BorderStyle := bsNone;
    { Прорисовываем состояния элементов управления}
    ShowGets;
    JRMOShowGets;
    JFBShowGets;
    { Контроль периода действия ключа НОВАЯ ПОЧТА }
    spNPostActualKey.ExecProc;
    IErr := spNPostActualKey.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      SErr := spNPostActualKey.Parameters.ParamValues['@SErr'];
      ShowMessage('SErr');
    end;
    { Сразу смотрим наличие новых уведомлений }
    tmrJournalAlertTimer(nil);
    tmrJournalAlert.Enabled := true;
  end;
end;

procedure TFCCenterJournalNetZkz.RegActionState(var IErr : integer; var SErr : string);
begin
  spGetActionState.Parameters.ParamValues['@ActionCode'] := RegAction.ActionCode;
  spGetActionState.Parameters.ParamValues['@Order']      := RegAction.Order;
  spGetActionState.Parameters.ParamValues['@Bell']       := RegAction.Bell;
  spGetActionState.ExecProc;
  IErr := spGetActionState.Parameters.ParamValues['@RETURN_VALUE'];
  SErr := spGetActionState.Parameters.ParamValues['@SErr'];
  RegAction.State      := spGetActionState.Parameters.ParamValues['@ActionState'];
  RegAction.RN         := spGetActionState.Parameters.ParamValues['@NRN'];
  RegAction.SUSER      := spGetActionState.Parameters.ParamValues['@SUSER'];
  RegAction.SBeginDate := spGetActionState.Parameters.ParamValues['@SBeginDate'];
end;

procedure TFCCenterJournalNetZkz.ExistActionState(var IErr : integer; var SErr : string);
begin
  spExistActionHistory.Parameters.ParamValues['@ActionCode'] := RegAction.ActionCode;
  spExistActionHistory.Parameters.ParamValues['@Order']      := RegAction.Order;
  spExistActionHistory.Parameters.ParamValues['@Bell']       := RegAction.Bell;
  spExistActionHistory.ExecProc;
  IErr := spExistActionHistory.Parameters.ParamValues['@RETURN_VALUE'];
  SErr := spExistActionHistory.Parameters.ParamValues['@SErr'];
  RegAction.State      := spExistActionHistory.Parameters.ParamValues['@ActionState'];
  RegAction.RN         := spExistActionHistory.Parameters.ParamValues['@NRN'];
  RegAction.SUSER      := spExistActionHistory.Parameters.ParamValues['@SUSER'];
  RegAction.SBeginDate := spExistActionHistory.Parameters.ParamValues['@SBeginDate'];
end;

procedure TFCCenterJournalNetZkz.ExistAction(var IErr : integer; var SErr : string);
begin
  IErr := 0;
  SErr := '';
  ExistActionState(IErr,SErr);
  if IErr = 0 then begin
    if RegAction.State <> 0 then begin
      IErr := -7;
      SErr := 'Действие уже выполнялось.' + chr(10) +
              'Пользователь: ' + RegAction.SUSER + chr(10) +
              'Дата операции: ' + RegAction.SBeginDate + chr(10)+
              'Подтвердите определение нового водителя для заказа';
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.RegActionOpen(var IErr : integer; var SErr : string);
begin
  RegAction.BeginDate := now;
  spRegActionOpen.Parameters.ParamValues['@ActionCode'] := RegAction.ActionCode;
  spRegActionOpen.Parameters.ParamValues['@NUSER']      := RegAction.NUSER;
  spRegActionOpen.Parameters.ParamValues['@Order']      := RegAction.Order;
  spRegActionOpen.Parameters.ParamValues['@Bell']       := RegAction.Bell;
  spRegActionOpen.Parameters.ParamValues['@SBeginDate'] := FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz',RegAction.BeginDate);
  spRegActionOpen.ExecProc;
  IErr := spRegActionOpen.Parameters.ParamValues['@RETURN_VALUE'];
  if spRegActionOpen.Parameters.ParamValues['@SErr'] = null
    then SErr := ''
    else SErr := spRegActionOpen.Parameters.ParamValues['@SErr'];
  RegAction.RN := spRegActionOpen.Parameters.ParamValues['@NRN'];
end;

procedure TFCCenterJournalNetZkz.RegActionClose;
var
  IErr : integer;
  SErr : string;
begin
  spRegActionClose.Parameters.ParamValues['@ActionCode'] := RegAction.ActionCode;
  spRegActionClose.Parameters.ParamValues['@NUSER']      := RegAction.NUSER;
  spRegActionClose.Parameters.ParamValues['@SBeginDate'] := FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz',RegAction.BeginDate);
  spRegActionClose.Parameters.ParamValues['@Order']      := RegAction.Order;
  spRegActionClose.Parameters.ParamValues['@Bell']       := RegAction.Bell;
  spRegActionClose.ExecProc;
  IErr := spRegActionClose.Parameters.ParamValues['@RETURN_VALUE'];
  SErr := spRegActionClose.Parameters.ParamValues['@SErr'];
  if IErr <> 0 then ShowMessage(SErr);
  RegAction.RN := 0;
end;

procedure TFCCenterJournalNetZkz.JRMORegActionOpen(var IErr : integer; var SErr : string);
begin
  RegAction.BeginDate := now;
  spJRMOActionOpen.Parameters.ParamValues['@PRN']        := RegAction.Order;
  spJRMOActionOpen.Parameters.ParamValues['@ActionCode'] := RegAction.ActionCode;
  spJRMOActionOpen.Parameters.ParamValues['@NUSER']      := RegAction.NUSER;
  spJRMOActionOpen.Parameters.ParamValues['@SBeginDate'] := FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz',RegAction.BeginDate);
  spJRMOActionOpen.ExecProc;
  IErr := spJRMOActionOpen.Parameters.ParamValues['@RETURN_VALUE'];
  if spJRMOActionOpen.Parameters.ParamValues['@SErr'] = null
    then SErr := ''
    else SErr := spJRMOActionOpen.Parameters.ParamValues['@SErr'];
  RegAction.RN := spJRMOActionOpen.Parameters.ParamValues['@NRN'];
end;

procedure TFCCenterJournalNetZkz.JRMORegActionState(var IErr : integer; var SErr : string);
begin
  spJRMOGetActionState.Parameters.ParamValues['@ActionCode'] := RegAction.ActionCode;
  spJRMOGetActionState.Parameters.ParamValues['@PRN']        := RegAction.Order;
  spJRMOGetActionState.ExecProc;
  IErr := spJRMOGetActionState.Parameters.ParamValues['@RETURN_VALUE'];
  SErr := spJRMOGetActionState.Parameters.ParamValues['@SErr'];
  RegAction.State      := spJRMOGetActionState.Parameters.ParamValues['@ActionState'];
  RegAction.RN         := spJRMOGetActionState.Parameters.ParamValues['@NRN'];
  RegAction.SUSER      := spJRMOGetActionState.Parameters.ParamValues['@SUSER'];
  RegAction.SBeginDate := spJRMOGetActionState.Parameters.ParamValues['@SBeginDate'];
end;

procedure TFCCenterJournalNetZkz.JRMORegActionClose;
var
  IErr : integer;
  SErr : string;
begin
  spJRMOActionClose.Parameters.ParamValues['@RN']         := RegAction.RN;
  spJRMOActionClose.Parameters.ParamValues['@PRN']        := RegAction.Order;
  spJRMOActionClose.Parameters.ParamValues['@ActionCode'] := RegAction.ActionCode;
  spJRMOActionClose.Parameters.ParamValues['@NUSER']      := RegAction.NUSER;
  spJRMOActionClose.Parameters.ParamValues['@SBeginDate'] := FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz',RegAction.BeginDate);
  spJRMOActionClose.ExecProc;
  IErr := spJRMOActionClose.Parameters.ParamValues['@RETURN_VALUE'];
  SErr := spJRMOActionClose.Parameters.ParamValues['@SErr'];
  if IErr <> 0 then ShowMessage(SErr);
  RegAction.RN := 0;
end;

procedure TFCCenterJournalNetZkz.JFBRegActionOpen(var IErr : integer; var SErr : string);
begin
  RegAction.BeginDate := now;
  spJFBActionOpen.Parameters.ParamValues['@PRN']        := RegAction.Order;
  spJFBActionOpen.Parameters.ParamValues['@ActionCode'] := RegAction.ActionCode;
  spJFBActionOpen.Parameters.ParamValues['@NUSER']      := RegAction.NUSER;
  spJFBActionOpen.Parameters.ParamValues['@SBeginDate'] := FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz',RegAction.BeginDate);
  spJFBActionOpen.ExecProc;
  IErr := spJFBActionOpen.Parameters.ParamValues['@RETURN_VALUE'];
  if spJFBActionOpen.Parameters.ParamValues['@SErr'] = null
    then SErr := ''
    else SErr := spJFBActionOpen.Parameters.ParamValues['@SErr'];
  RegAction.RN := spJFBActionOpen.Parameters.ParamValues['@NRN'];
end;

procedure TFCCenterJournalNetZkz.JFBRegActionState(var IErr : integer; var SErr : string);
begin
  spJFBActionGetState.Parameters.ParamValues['@ActionCode'] := RegAction.ActionCode;
  spJFBActionGetState.Parameters.ParamValues['@PRN']        := RegAction.Order;
  spJFBActionGetState.ExecProc;
  IErr := spJFBActionGetState.Parameters.ParamValues['@RETURN_VALUE'];
  SErr := spJFBActionGetState.Parameters.ParamValues['@SErr'];
  RegAction.State      := spJFBActionGetState.Parameters.ParamValues['@ActionState'];
  RegAction.RN         := spJFBActionGetState.Parameters.ParamValues['@NRN'];
  RegAction.SUSER      := spJFBActionGetState.Parameters.ParamValues['@SUSER'];
  RegAction.SBeginDate := spJFBActionGetState.Parameters.ParamValues['@SBeginDate'];
end;

procedure TFCCenterJournalNetZkz.JFBRegActionClose;
var
  IErr : integer;
  SErr : string;
begin
  spJFBActionClose.Parameters.ParamValues['@RN']         := RegAction.RN;
  spJFBActionClose.Parameters.ParamValues['@PRN']        := RegAction.Order;
  spJFBActionClose.Parameters.ParamValues['@ActionCode'] := RegAction.ActionCode;
  spJFBActionClose.Parameters.ParamValues['@NUSER']      := RegAction.NUSER;
  spJFBActionClose.Parameters.ParamValues['@SBeginDate'] := FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz',RegAction.BeginDate);
  spJFBActionClose.ExecProc;
  IErr := spJFBActionClose.Parameters.ParamValues['@RETURN_VALUE'];
  SErr := spJFBActionClose.Parameters.ParamValues['@SErr'];
  if IErr <> 0 then ShowMessage(SErr);
  RegAction.RN := 0;
end;

procedure TFCCenterJournalNetZkz.JCallRegActionState(var IErr : integer; var SErr : string);
begin
  spJCallGetActionState.Parameters.ParamValues['@ActionCode'] := RegAction.ActionCode;
  spJCallGetActionState.Parameters.ParamValues['@PRN']        := RegAction.Order;
  spJCallGetActionState.ExecProc;
  IErr := spJCallGetActionState.Parameters.ParamValues['@RETURN_VALUE'];
  SErr := spJCallGetActionState.Parameters.ParamValues['@SErr'];
  RegAction.State      := spJCallGetActionState.Parameters.ParamValues['@ActionState'];
  RegAction.RN         := spJCallGetActionState.Parameters.ParamValues['@NRN'];
  RegAction.SUSER      := spJCallGetActionState.Parameters.ParamValues['@SUSER'];
  RegAction.SBeginDate := spJCallGetActionState.Parameters.ParamValues['@SBeginDate'];
end;

procedure TFCCenterJournalNetZkz.JCallRegActionOpen(var IErr : integer; var SErr : string);
begin
  RegAction.BeginDate := now;
  spJCallActionOpen.Parameters.ParamValues['@PRN']        := RegAction.Order;
  spJCallActionOpen.Parameters.ParamValues['@ActionCode'] := RegAction.ActionCode;
  spJCallActionOpen.Parameters.ParamValues['@NUSER']      := RegAction.NUSER;
  spJCallActionOpen.Parameters.ParamValues['@Note']       := RegAction.Note;
  spJCallActionOpen.Parameters.ParamValues['@SBeginDate'] := FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz',RegAction.BeginDate);
  spJCallActionOpen.ExecProc;
  IErr := spJCallActionOpen.Parameters.ParamValues['@RETURN_VALUE'];
  if spJCallActionOpen.Parameters.ParamValues['@SErr'] = null
    then SErr := ''
    else SErr := spJCallActionOpen.Parameters.ParamValues['@SErr'];
  RegAction.RN := spJCallActionOpen.Parameters.ParamValues['@NRN'];
end;

procedure TFCCenterJournalNetZkz.JCallRegActionClose;
var
  IErr : integer;
  SErr : string;
begin
  spJCallActionClose.Parameters.ParamValues['@RN']         := RegAction.RN;
  spJCallActionClose.Parameters.ParamValues['@PRN']        := RegAction.Order;
  spJCallActionClose.Parameters.ParamValues['@ActionCode'] := RegAction.ActionCode;
  spJCallActionClose.Parameters.ParamValues['@NUSER']      := RegAction.NUSER;
  spJCallActionClose.Parameters.ParamValues['@Note']       := RegAction.Note;
  spJCallActionClose.Parameters.ParamValues['@SBeginDate'] := FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz',RegAction.BeginDate);
  spJCallActionClose.Parameters.ParamValues['@SEndDate']   := FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz',RegAction.EndDate);
  spJCallActionClose.ExecProc;
  IErr := spJCallActionClose.Parameters.ParamValues['@RETURN_VALUE'];
  SErr := spJCallActionClose.Parameters.ParamValues['@SErr'];
  if IErr <> 0 then ShowMessage(SErr);
  RegAction.RN := 0;
end;

(* Загрузить все - полное обновление данных *)
procedure TFCCenterJournalNetZkz.pmiDBGridMain_LoadClick(Sender: TObject);
begin
{
  if MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  FullLoad(0);
  (* Если есть новые заказы *)
  if ISign_ResThreadLoad = 1 then
    begin
      ISign_ResThreadLoad := 0;
      GridMainRefresh;
      ShowGets;
    end;
  ShowGets;}
end; (* TFCCenterJournalNetZkz.pmiDBGridMain_LoadClick *)

(* Обновить *)
procedure TFCCenterJournalNetZkz.pmiDBGridMain_RefreshClick(Sender: TObject);
begin
end;

(* Загрузить все                                                       *)
procedure TFCCenterJournalNetZkz.tmrRefreshTimer(Sender: TObject);
var
  ThreadLoad: TThreadLoad;
begin
  (* Начинаем выполнять, только когда форма активна *)
  if ISign_Active = 1 then
    begin
      try
        tmrRefresh.Enabled := false;
        { Внимание !!! с 04.10.214 загрузка выполняется путем выполнения задачи в MS SQL SERVER}
        { См. p_AutoLoadZakazSite }
        {ThreadLoad := TThreadLoad.Create(False);}
      finally
        // После первого срабатывания ставим через каждые 15 минут
        tmrRefresh.Enabled := false;
        {
        tmrRefresh.Interval := 900000;
        tmrRefresh.Enabled := true;
        }
      end;
    end;
end;

(* Периодический контроль результатов загрузки (обновления) данных *)
procedure TFCCenterJournalNetZkz.tmrCheckRefreshTimer(Sender: TObject);
begin
  (* Начинаем выполнять, только когда форма активна *)
  if ISign_Active = 1 then
    begin
      if IState_ThreadLoad <> IOldState_ThreadLoad then
        case IState_ThreadLoad of
          -1: begin // форма только что открыта
                IOldState_ThreadLoad := IState_ThreadLoad;
              end;
          0:  begin // загрузка данных выполнена
                if IOldState_ThreadLoad = 1 then begin
                  IOldState_ThreadLoad := IState_ThreadLoad;
                  if ISign_ResThreadLoad = 1 then begin
                    ISign_ResThreadLoad := 0;
                    GridMainRefresh;
                  end;
                  ShowGets;
                end;
              end;
          1:  begin // стартовала загрузка данных
                IOldState_ThreadLoad := IState_ThreadLoad;
              end;
        end;
    end;
end;

procedure TFCCenterJournalNetZkz.FormShow(Sender: TObject);
begin
  if ISign_Active = 0 then begin
    { Загрузка параметров диалога }
    {
    LoadPropClassToXML
     (
      FCCenterJournalNetZkz,
      NameParmXML,
      ISignKeepParmXNL,
      Form1.ADOC_STAT
     );
     }
  end;
end;

procedure TFCCenterJournalNetZkz.pmiToolBar_ShowCptionClick(Sender: TObject);
begin
  pmiToolBar_ShowCption.Checked := not pmiToolBar_ShowCption.Checked;
  ShowGets;
  JRMOShowGets;
  JFBShowGets;
end;

{ Выбор Аптеки для позиции товара }
procedure TFCCenterJournalNetZkz.tlbtnDBGridSlave_SlPharmacyClick(Sender: TObject);
begin
  UserActive;
  ExecHistoryOrderAction('SelectPharmacyAllPosition',
    '');
end;

procedure TFCCenterJournalNetZkz.dsSlaveDataChange(Sender: TObject; Field: TField);
var
  ISignDistibute : smallint;
begin
  ISignDistibute := DBGridSlave.DataSource.DataSet.FieldByName('ISignDistribute').AsInteger;
  if ISignDistibute = 1 then begin
    qrspJSOPositionDistribute.Active := false;
    qrspJSOPositionDistribute.Parameters.ParamByName('@itemID').Value    := DBGridSlave.DataSource.DataSet.FieldByName('NRN').AsInteger;
    qrspJSOPositionDistribute.Parameters.ParamByName('@TypeTable').Value := DBGridSlave.DataSource.DataSet.FieldByName('STypeTable').AsString;
    qrspJSOPositionDistribute.Active := true;
    JSOEnableDistribute;
  end else begin
    JSODisableDistribute;
  end;
  ShowGetsSlave;
end;

{ Заменить аптеку }
procedure TFCCenterJournalNetZkz.aMain_UpdPharmacyExecute(Sender: TObject);
var
  IErr         : integer;
  SErr         : string;
  SPharmacyOld : string;
  NPharmacyOld : integer;
  SPharmacyNew : string;
  NPharmacyNew : integer;
begin
  UserActive;
  if IsActionOrder then
    begin
      if CanEditOrder('ReplacePharmacy', SErr) then
        Self.ExecHistoryOrderAction('ReplacePharmacy', '')
      else
        ShowError(SErr);
    end
  else
  begin
    { Начальная инициализация действия }
    RegAction.ActionCode := 'ReplacePharmacy';
    RegAction.Order      := OrderHeaderDS.FieldByName('orderID').AsInteger;
    RegAction.Bell       := 0;
    { Проверяем состояние действия }
    RegActionState(IErr,SErr);
    if IErr = 0 then begin
      { Если открытое действие не зарегистрировано, то выполняем действие }
      if RegAction.State = 0 then begin
        { Регистрируем действие пользователя }
        RegActionOpen(IErr,SErr);
        if IErr = 0 then begin
          try
           SPharmacyOld := OrderHeaderDS.FieldByName('apteka').AsString;
           NPharmacyOld := OrderHeaderDS.FieldByName('aptekaID').AsInteger;
           SPharmacyNew := '';
           NPharmacyNew := 0;
           frmCCJS_UpdPharmacyZakaz := TfrmCCJS_UpdPharmacyZakaz.Create(Self);
           frmCCJS_UpdPharmacyZakaz.SetUser(Form1.id_user);
           try
            frmCCJS_UpdPharmacyZakaz.ShowModal;
           finally
            { Смотрим новую аптеку }
            SPharmacyNew := frmCCJS_UpdPharmacyZakaz.GetSPharmacyNew;
            NPharmacyNew := frmCCJS_UpdPharmacyZakaz.GetNPharmacyNew;
            FreeAndNil(frmCCJS_UpdPharmacyZakaz);
            { Если выбрана другая аптека, то регистрируем смену аптеки }
            if (NPharmacyNew <> 0) and (NPharmacyNew <> NPharmacyOld) then begin
              try
                spRegChangeOrder_Insert.Parameters.ParamValues['@PRN']          := RegAction.RN;
                spRegChangeOrder_Insert.Parameters.ParamValues['@SPharmacyOld'] := SPharmacyOld;
                spRegChangeOrder_Insert.Parameters.ParamValues['@NPharmacyOld'] := NPharmacyOld;
                spRegChangeOrder_Insert.Parameters.ParamValues['@SPharmacyNew'] := SPharmacyNew;
                spRegChangeOrder_Insert.Parameters.ParamValues['@NPharmacyNew'] := NPharmacyNew;
                spRegChangeOrder_Insert.Parameters.ParamValues['@OldArtCode']   := 0;
                spRegChangeOrder_Insert.Parameters.ParamValues['@NewArtCode']   := 0;
                spRegChangeOrder_Insert.Parameters.ParamValues['@OldQuantity']  := 0;
                spRegChangeOrder_Insert.Parameters.ParamValues['@NewQuantity']  := 0;
                spRegChangeOrder_Insert.Parameters.ParamValues['@USER']         := Form1.id_user;
                spRegChangeOrder_Insert.ExecProc;
              except
                on e:Exception do begin
                  ShowMessage('Сбой при регистрации изменения атрибутов заказа.' + chr(10) + e.Message);
                end;
              end;
            end;
            RegActionClose;
            JSOSetOrderProcessed(RegAction.Order,RegAction.NUSER);
            GridMainRefresh;
            ShowGets
           end;
          except
            on e:Exception do begin
              ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
              RegActionClose;
              JSOSetOrderProcessed(RegAction.Order,RegAction.NUSER);
            end;
          end;
        end else begin
          ShowMessage('IErr = ' + VarToStr(IErr) + chr(10) + SErr);
        end;
      end else begin
        ShowMessage('Операция запрещена.' + chr(10) +
                    'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                    'Дата начала операции: ' + RegAction.SBeginDate
                   );
      end;
    end else ShowMessage(SErr);
  end;
end;

{ Печать заказа }
procedure TFCCenterJournalNetZkz.aMain_RP_ZakazExecute(Sender: TObject);
var
  NSum : Currency;
begin
  UserActive;
  JSOAssignHeaderItem;
  try
    frmCCJS_RP_Order := TfrmCCJS_RP_Order.Create(Self);
    frmCCJS_RP_Order.SetRecHeaderItem(JSOHeaderItem);
    frmCCJS_RP_Order.SetRecSession(UserSession);
    if (length(ParentsList) <> 0) or (length(SlavesList) <> 0) then frmCCJS_RP_Order.SetOrdersListLink(true);
    try
      frmCCJS_RP_Order.ShowModal;
    finally
      FreeAndNil(frmCCJS_RP_Order);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

{ Пересчет суммы заказа }
procedure TFCCenterJournalNetZkz.aMain_RecalcZakazExecute(Sender: TObject);
begin
  if MessageDLG('Подтвердите пересчет суммы заказа',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
    RecalcZakaz;
    { Установка состояния наличия брони в позициях заказа }
    try
      spSetStateArmour.Parameters.ParamValues['@OrderID'] := OrderHeaderDS.FieldByName('orderID').AsInteger;
      spSetStateArmour.ExecProc;
    except on E: Exception do begin ShowMessage(e.Message); end;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.RecalcZakaz;
var
 IErr : integer;
 SErr : string;
begin
  UserActive;
  try
    spRecalcZakaz.Parameters.ParamValues['@OrderID'] := OrderHeaderDS.FieldByName('orderID').AsInteger;
    spRecalcZakaz.ExecProc;
    IErr := spRecalcZakaz.Parameters.ParamValues['@RETURN_VALUE'];
    SErr := spRecalcZakaz.Parameters.ParamValues['@SErr'];
    if IErr <> 0 then ShowMessage(SErr);
  except
    on E: Exception do begin
      ShowMessage('Сбой при пересчете суммы заказа.' + chr(10) + e.Message);
    end;
  end;
  GridMainRefresh;
end;

procedure TFCCenterJournalNetZkz.aClipBoard_SOrderDtExecute(Sender: TObject);
begin
  ClipBoard.AsText := AsString(OrderHeaderDS, 'OrderDt');
end;

procedure TFCCenterJournalNetZkz.aClipBoard_AptekaExecute(Sender: TObject);
begin
  ClipBoard.AsText := OrderHeaderDS.FieldByName('Apteka').AsString;
end;

procedure TFCCenterJournalNetZkz.aClipBoard_OrderAmountExecute(Sender: TObject);
begin
  ClipBoard.AsText := OrderHeaderDS.FieldByName('OrderAmount').AsString;
end;

procedure TFCCenterJournalNetZkz.aClipBoard_OrderShipNameExecute(Sender: TObject);
begin
  ClipBoard.AsText := OrderHeaderDS.FieldByName('OrderShipName').AsString;
end;

procedure TFCCenterJournalNetZkz.aClipBoard_orderPhoneExecute(Sender: TObject);
begin
  ClipBoard.AsText := OrderHeaderDS.FieldByName('orderPhone').AsString;
end;

procedure TFCCenterJournalNetZkz.aClipBoard_OrderEMailExecute(Sender: TObject);
begin
  ClipBoard.AsText := OrderHeaderDS.FieldByName('OrderEMail').AsString;
end;

procedure TFCCenterJournalNetZkz.aClipBoard_OrderShipStreetExecute(Sender: TObject);
begin
  ClipBoard.AsText := OrderHeaderDS.FieldByName('OrderShipStreet').AsString;
end;

procedure TFCCenterJournalNetZkz.aClipBoard_AllZakazExecute(Sender: TObject);
begin
   ClipBoard.AsText := AsString(OrderHeaderDS, 'OrderDt') + '; ' +
                       OrderHeaderDS.FieldByName('Apteka').AsString + '; ' +
                       OrderHeaderDS.FieldByName('OrderAmount').AsString + '; ' +
                       OrderHeaderDS.FieldByName('OrderShipName').AsString + '; ' +
                       OrderHeaderDS.FieldByName('orderPhone').AsString + '; ' +
                       OrderHeaderDS.FieldByName('OrderEMail').AsString + '; ' +
                       OrderHeaderDS.FieldByName('OrderShipStreet').AsString + '; ' +
                       OrderHeaderDS.FieldByName('SNote').AsString + '; ' +
                       OrderHeaderDS.FieldByName('MPhone').AsString + '; ';
end;

procedure TFCCenterJournalNetZkz.aMain_JournalLoadZakazExecute(Sender: TObject);
begin
  UserActive;
  if pgcJSO_JBO.ActivePage.Name = 'tabJSO' then begin
    try
      frmCCJS_JournalRegLoadOrders := TfrmCCJS_JournalRegLoadOrders.Create(Self);
    try
      frmCCJS_JournalRegLoadOrders.ShowModal;
    finally
      FreeAndNil(frmCCJS_JournalRegLoadOrders);
      GridSlaveRefresh;
      GridMainRefresh;
    end;
    except
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.DBGridSlaveDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db               : TDBGrid;
  dr               : TRect;
  sr               : TRect;
  imgWidth         : integer;
  imgHeight        : integer;
  NDistributeCount : integer;
  NArtCount        : integer;
  NKoef_Opt        : integer;
  SignMeas         : integer;

  procedure InnerDrawQty(AFieldName: string);
  begin
    if Column.FieldName = AFieldName then
    begin
      if db.DataSource.DataSet.FieldByName('NitemArmourAllQty').AsInteger <
         db.DataSource.DataSet.FieldByName('NArtCount').AsInteger then
      begin
        db.Canvas.Font.Color := TColor(clBlue);
        db.Canvas.Font.Style := [fsBold];
      end
      else
      if db.DataSource.DataSet.FieldByName('NitemArmourAllQty').AsInteger >
         db.DataSource.DataSet.FieldByName('NArtCount').AsInteger then
      begin
        db.Canvas.Font.Color := TColor(clRed);
        db.Canvas.Font.Style := [fsBold];
      end
    end;
  end;

begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if not (gdSelected in State) then begin
    { Позицию заказа, которая распределена по аптекам выделяем другим фоном }
    Case db.DataSource.DataSet.FieldByName('ISignDistribute').AsInteger of
      1: begin
           db.Canvas.Brush.Color := TColor($B0B000); { брюзовый }
           db.Canvas.Font.Color := TColor($80FFFF); { светло-желтый }
         end;
    end;
    { Позиция заказа, которая разделена на несколько частей }
    if db.DataSource.DataSet.FieldByName('ISignDivideParts').AsInteger = 1 then begin
      db.Canvas.Brush.Color := TColor($FFD9FF); { светло-сиреневый }
    end;
    { Позиция заказа, которая бронируется с использованием срокового товара }
    if db.DataSource.DataSet.FieldByName('ISignArmorTerm').AsInteger = 1 then begin
      db.Canvas.Brush.Color := TColor($D3EFFE); { светло-коричневый }
      { Состояние бронирования }
      case db.DataSource.DataSet.FieldByName('IStateArmour').AsInteger of
        2: db.Canvas.Font.Color := TColor(clBlue);
        3: db.Canvas.Font.Color := TColor(clRed);
      end;
    end;
    { Подкраска новых товарных позиций }
    if (db.DataSource.DataSet.FieldByName('STypeTable').AsString = csOrderItemTypeTable_Add) or
       (db.DataSource.DataSet.FieldByName('SignAdd').AsInteger = 1) then
    begin
      if (Column.FieldName = 'SNomenclature') then begin
        db.Canvas.Brush.Color := TColor($FFCCCC); { светло-фиолетовый }
        db.Canvas.Font.Color  := clWindowText;
      end;
    end;
  end;
  { Для неполностью распределенной позиции соответствующий атрибут отображаем красным }
  if (Column.FieldName = 'SDistributeCount') then
    if db.DataSource.DataSet.FieldByName('ISignDistribute').AsInteger = 1 then begin
      NDistributeCount := db.DataSource.DataSet.FieldByName('NDistributeCount').AsInteger;
      NArtCount        := db.DataSource.DataSet.FieldByName('NArtCount').AsInteger;
      NKoef_Opt        := db.DataSource.DataSet.FieldByName('NKoef_Opt').AsInteger;
      SignMeas         := db.DataSource.DataSet.FieldByName('ISignMeas').AsInteger;
      if NDistributeCount < (NArtCount * GetJSOFactorNumber(NKoef_Opt,SignMeas)) then begin
        {db.Canvas.Brush.Color := TColor(clRed);}
        db.Canvas.Font.Color := TColor(clRed);
      end;
    end;
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  if OrderHeaderDS.FieldByName('ExecSign').AsInteger = 1 then
  begin
    if Column.FieldName = 'NNotArmourQty' then
    begin
      if db.DataSource.DataSet.FieldByName('NNotArmourQty').AsInteger > 0 then
      begin
        db.Canvas.Font.Color := TColor(clBlue);
        db.Canvas.Font.Style := [fsBold];
      end
      else
      if db.DataSource.DataSet.FieldByName('NNotArmourQty').AsInteger < 0 then
      begin
        db.Canvas.Font.Color := TColor(clRed);
        db.Canvas.Font.Style := [fsBold];
      end
    end;
    InnerDrawQty('NitemArmourAllQty');
    InnerDrawQty('SArtCount');
    InnerDrawQty('NitemArmAddQty');
    {
    if Column.FieldName = 'NitemArmourAllQty' then
    begin
      if db.DataSource.DataSet.FieldByName('NitemArmourAllQty').AsInteger <
         db.DataSource.DataSet.FieldByName('NArtCount').AsInteger then
      begin
        db.Canvas.Font.Color := TColor(clBlue);
        db.Canvas.Font.Style := [fsBold];
      end
      else
      if db.DataSource.DataSet.FieldByName('NitemArmourAllQty').AsInteger >
         db.DataSource.DataSet.FieldByName('NArtCount').AsInteger then
      begin
        db.Canvas.Font.Color := TColor(clRed);
        db.Canvas.Font.Style := [fsBold];
      end
    end;
    if Column.FieldName = 'SArtCount' then
    begin
      if db.DataSource.DataSet.FieldByName('NitemArmourAllQty').AsInteger <
         db.DataSource.DataSet.FieldByName('NArtCount').AsInteger then
      begin
        db.Canvas.Font.Color := TColor(clBlue);
        db.Canvas.Font.Style := [fsBold];
      end
      else
      if db.DataSource.DataSet.FieldByName('NitemArmourAllQty').AsInteger >
         db.DataSource.DataSet.FieldByName('NArtCount').AsInteger then
      begin
        db.Canvas.Font.Color := TColor(clRed);
        db.Canvas.Font.Style := [fsBold];
      end
    end; }
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  { Прорисовка img в столбце - признак резервирования}
  if Column.FieldName = 'ISIgnModeReserve' then begin
    db.Canvas.FillRect(Rect);
    Column.Title.Caption := '';
    try
      if (Column.Field.AsInteger = 1) then begin
        imgWidth  := imgArmor.Width;
        imgHeight := imgArmor.Height;
      end
      else if (Column.Field.AsInteger = 2) then begin
        imgWidth  := imgComeBack.Width;
        imgHeight := imgComeBack.Height;
      end
      else if (Column.Field.AsInteger = 3) then begin
        imgWidth  := imgReserve.Width;
        imgHeight := imgReserve.Height;
      end;
      dr      := Rect;
      dr.Left := dr.Left + 2;
      {
      dr.Top  := dr.Top  + 2;
      }
      dr.Right  := dR.Left + imgWidth;
      dr.Bottom := dR.Top  + imgHeight;
      sR.Left   := 0;
      sR.Top    := 0;
      sR.Right  := imgWidth;
      sR.Bottom := imgHeight;
      if      (Column.Field.AsInteger = 1) then db.Canvas.CopyRect(dR,imgArmor.Canvas,sR)
      else if (Column.Field.AsInteger = 2) then db.Canvas.CopyRect(dR,imgComeBack.Canvas,sR)
      else if (Column.Field.AsInteger = 3) then db.Canvas.CopyRect(dR,imgReserve.Canvas,sR)
    except
    end;
  end;
  { Прорисовка img в столбце - признак распределения по аптекам }
  if Column.FieldName = 'ISignDistribute' then begin
    db.Canvas.FillRect(Rect);
    Column.Title.Caption := '';
    try
      if (Column.Field.AsInteger = 1) then begin
        imgWidth  := FCCenterJournalNetZkz.imgDistrToPharm.Width;
        imgHeight := FCCenterJournalNetZkz.imgDistrToPharm.Height;
      end;
      dr      := Rect;
      dr.Left := dr.Left + 2;
      {
      dr.Top  := dr.Top  + 2;
      }
      dr.Right  := dR.Left + imgWidth;
      dr.Bottom := dR.Top  + imgHeight;
      sR.Left   := 0;
      sR.Top    := 0;
      sR.Right  := imgWidth;
      sR.Bottom := imgHeight;
      if (Column.Field.AsInteger = 1) then db.Canvas.CopyRect(dR,FCCenterJournalNetZkz.imgDistrToPharm.Canvas,sR)
    except
    end;
  end;
  { Прорисовка img в столбце - признак специального режима хранения }
  if Column.FieldName = 'ITypeKeep' then begin
    db.Canvas.FillRect(Rect);
    Column.Title.Caption := '';
    try
      if (Column.Field.AsInteger = 1) then begin
        imgWidth  := FCCenterJournalNetZkz.imgTypeKeep.Width;
        imgHeight := FCCenterJournalNetZkz.imgTypeKeep.Height;
      end;
      dr      := Rect;
      dr.Left := dr.Left + 2;
      {
      dr.Top  := dr.Top  + 2;
      }
      dr.Right  := dR.Left + imgWidth;
      dr.Bottom := dR.Top  + imgHeight;
      sR.Left   := 0;
      sR.Top    := 0;
      sR.Right  := imgWidth;
      sR.Bottom := imgHeight;
      if (Column.Field.AsInteger = 1) then db.Canvas.CopyRect(dR,FCCenterJournalNetZkz.imgTypeKeep.Canvas,sR)
    except
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.DBGridMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db                 : TDBGrid;
  SDateReceived      : string;
  SChildDateReceived : string;
  vStatus            : Integer;
  vDS                : TDataSet;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  vDS := db.DataSource.DataSet;
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
    if vDS.FieldByName('aptekaID').AsInteger = 0 then begin
    end else begin
      Case vDS.FieldByName('IStateArmour').AsInteger of
        0: db.Canvas.Font.Color := TColor(clRed);    { не забронировано }
        //2: db.Canvas.Font.Color := TColor($80FFFF); { частично забронировано } { светло-желтый }
        3: db.Canvas.Font.Color := TColor(clRed);    { не забронировано }
      end;
    end;
  end;
  if not (gdSelected in State) then begin
    if vDS.FieldByName('aptekaID').AsInteger = 0 then begin
      if VarIsAssigned(vDS.FieldByName('DCloseDate').Value) then
      begin
        { Закрытые интернет заказы. Аптеки нет в заголовке заказа }
        db.Canvas.Brush.Color := TColor($D3D3D3);
      end
      else
      begin
        { Открытые интернет заказы. Аптеки нет в заголовке заказа }
        if (copy(vDS.FieldByName('orderShipStreet').AsString,1,14) = 'Срочный заказ:')
           or (vDS.FieldByName('NOrderAmountShipping').AsCurrency = 150) then begin
          { Срочный заказа }
          db.Canvas.Brush.Color := TColor(clFuchsia);
          db.Canvas.Font.Color  := TColor(clWhite);
        end;
        if length(vDS.FieldByName('SExport1CDate').AsString) <> 0 then begin
          { Выделяем эекспорт 1С }
          if (Column.FieldName = 'SExport1CDate') then begin
            db.Canvas.Brush.Color := TColor($80FF80);
            db.Canvas.Font.Color  := TColor(clWindowText);
          end;
        end;
      end;
    end else begin
      Case vDS.FieldByName('IStateArmour').AsInteger of
        0: db.Canvas.Font.Color := TColor(clRed);  { не определено }
        2: db.Canvas.Font.Color := TColor(clBlue); { частично забронировано }
        3: db.Canvas.Font.Color := TColor(clRed);  { не забронировано }
      end;
    end;
    if  VarIsAssigned(OrderHeaderDS.FieldByName('DCloseDate').Value) then
    begin
      { Закрытые интернет заказы }
      db.Canvas.Brush.Color := TColor($D3D3D3);
      if (Column.FieldName = 'SOrderStatus') then begin
        vStatus := vDS.FieldByName('DOrderStatus').AsInteger;
        if (vStatus = cStatusSoldReservations) or (vStatus = cStatusOrderIsPaid) or (vStatus = cStatusCompleted) then begin
          db.Canvas.Brush.Color := TColor($CEFFCE); { светло-зеленый }
          db.Canvas.Font.Color  := TColor(clWindowText);
        end;
        if (vStatus = cStasusCanceledReservations) or (vStatus = cStasusReservePeriodExpired) or (vStatus = cStatusCanceled) then begin
          db.Canvas.Brush.Color := TColor($D8B0FF); { светло-красный }
          db.Canvas.Font.Color  := TColor(clWindowText);
        end;
      end;
    end
    else
    begin
      { Не было связи с аптекой }
      if vDS.FieldByName('IStateConnection').AsInteger = 2 then
      begin
        db.Canvas.Font.Color := TColor(clWhite);
        db.Canvas.Brush.Color := TColor($8080FF);;
      end;
    end;
    { Черный список }
    if VarIsAssigned(vDS.FieldByName('DBlackListDate').Value) then
    begin
      if Column.FieldName = 'orderPhone' then
      begin
        db.Canvas.Brush.Color := TColor($404080);
        db.Canvas.Font.Color  := TColor(clYellow);
      end;
    end;
    if Column.FieldName = 'orderShipping' then
      if (trim(Column.Field.AsString) = 'Курьерская доставка') then
      begin
        db.Canvas.Brush.Color := TColor($80FFFF); { светло-желтый }
        db.Canvas.Font.Color  := TColor(clWindowText);
      end
      else if AnsiUpperCase((trim(Column.Field.AsString))) = 'НОВАЯ ПОЧТА' then
      begin
        db.Canvas.Brush.Color := TColor($FFFF9D); { светло-бирюзовый }
        db.Canvas.Font.Color  := TColor(clWindowText);
      end;
    if (Column.FieldName = 'orderID') then
    begin
      { Новые заказы }
      if vDS.FieldByName('ISignNew').AsInteger = 1 then
      begin
        if (Trim(AnsiUpperCase(vDS.FieldByName('orderPayment').AsString)) = 'PAYMASTER') or
           (vDS.FieldByName('SrcSystem').Value = 4) then
        begin
          db.Canvas.Brush.Color := TColor($80FFFF);
          db.Canvas.Font.Color := TColor(clBlue);
        end  
        else
        begin
          db.Canvas.Brush.Color := TColor(clRed);
          db.Canvas.Font.Color := TColor(clAqua);
        end;
      end else
      { Заказано на складе }
      if not VarIsNull(vDS.FieldByName('DStockDateBegin').Value) then
      begin
        db.Canvas.Brush.Color := TColor(clBlue);
        db.Canvas.Font.Color := TColor(clWhite);
      end;
    end;
    { Наложенные платежи }
    if (Column.FieldName = 'SDispatchDeclaration') then begin
      SDateReceived := AsString(vDS, 'DDateReceived');
      SChildDateReceived := AsString(vDS, 'DChildDateReceived');
      if      (length(SDateReceived) > 0) and (length(SChildDateReceived) = 0) then db.Canvas.Brush.Color := TColor($80FFFF)  { светло-желтый }
      else if (length(SDateReceived) > 0) and (length(SChildDateReceived) > 0) then db.Canvas.Brush.Color := TColor($B1FF64); { светло-зеленый }
    end;
    { PayMaster }
    if (Column.FieldName = 'orderPayment') then
    begin
      if Trim(AnsiUpperCase(vDS.FieldByName('orderPayment').AsString)) = 'PAYMASTER' then
        db.Canvas.Brush.Color := TColor($D8B0FF); //розовый
    end;
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFCCenterJournalNetZkz.PhaseDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  vField: TField;
  vGrid: TDBGrid;
  vPhase: Integer;
begin
  if (Sender is TDBGrid) and (not (gdSelected in State)) then 
  begin
    vGrid := TDBGrid(Sender);
    if Assigned(vGrid.DataSource) and Assigned(vGrid.DataSource.DataSet) then
      vField :=  vGrid.DataSource.DataSet.FieldByName('Phase');
    if Assigned(vField) then
    begin
      vPhase := vField.AsInteger;
      if vPhase = 7 then
        vGrid.Canvas.Brush.Color := TColor($D3D3D3)
      else if vPhase = 1 then
        vGrid.Canvas.Brush.Color := TColor($80FFFF);
    end;
    vGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TFCCenterJournalNetZkz.pgcJSO_JBOChange(Sender: TObject);
begin
  UserActive;
  if pgcJSO_JBO.ActivePage.Name = 'tabJSO' then begin
    GridMainRefresh;
    DBGridMain.SetFocus;
    ShowGets;
  end
  else if pgcJSO_JBO.ActivePage.Name = 'tabJRMO' then begin
    if IJRMOSign_Active = 0 then begin
      IJRMOSign_Active := 1;
      qrspJRMOMain.Active := false;
      CreateConditionJRMOMain;
      qrspJRMOMain.Active := true;
    end;
    JRMOGridMainRefresh;
    JRMOGridMain.SetFocus;
    JRMOShowGets;
  end
  else if pgcJSO_JBO.ActivePage.Name = 'tabJFB' then begin
    if IJFBSign_Active = 0 then begin
      IJFBSign_Active := 1;
      qrspJFBMain.Active := false;
      CreateConditionJFBMain;
      qrspJFBMain.Active := true;
    end;
    JFBGridMainRefresh;
    JFBGridMain.SetFocus;
    JFBShowGets;
  end
  else if pgcJSO_JBO.ActivePage.Name = 'tabJCall' then begin
    if IJCallSign_Active = 0 then begin
      IJCallSign_Active := 1;
      qrspJCallMain.Active := false;
      CreateConditionJCallMain;
      qrspJCallMain.Active := true;
    end;
    JCallGridMainRefresh;
    JCallGridMain.SetFocus;
    JCallShowGets;
  end
  else
  if pgcJSO_JBO.ActivePage.Name = 'tabPharmReserve' then
    InitPharmReserve
  else
  if pgcJSO_JBO.ActivePage.Name = 'tabPayTransaction' then
    InitPayTransaction;
end;

procedure TFCCenterJournalNetZkz.InitPharmReserve;
var
  vDS, vDSSpec: TsprQuery;
begin
  vDS := dmJSO.qrPharmReserve;
  vDSSpec := dmJSO.qrPharmReserveSpec;
  if not Assigned(PharmReserveGrid.DataSet) then
  begin
    PharmReserveGrid.DataSet := vDS;
    PharmReserveGrid.DataSource.OnDataChange := PharmReserveDataChange;
    PharmReserveSpecGrid.DataSet := vDSSpec;
    vDS.Active := True;
  end;
end;

procedure TFCCenterJournalNetZkz.InitPayTransaction;
var
  vDS: TsprQuery;
begin
  vDS := dmJSO.qrPayTransaction;
  if not Assigned(PayTransStatusGrid1.DataSet) then
  begin
    PayTransStatusGrid1.DataSet := vDS;
    PayTransStatusGrid1.RefreshData;
  end;
end;

procedure TFCCenterJournalNetZkz.InitOrderQueue;
var
  vDS: TsprQuery;
  vOrderId: Integer;
begin
  vOrderId := OrderHeaderDS.FieldByName('orderID').AsInteger;
  vDS := dmJSO.GetOrderQueue(vOrderId, true);
  if not Assigned(GridOrderQueue.DataSet) then
  begin
    GridOrderQueue.DataSet := vDS;
    //GridOrderQueue.RefreshData;
  end;
end;

procedure TFCCenterJournalNetZkz.InitOrderHistory;
var
  vDS: TsprQuery;
  vOrderId: Integer;
begin
  vOrderId := OrderHeaderDS.FieldByName('orderID').AsInteger;
  vDS := dmJSO.GetOrderHistory(vOrderId, true);
  if not Assigned(GridOrderHistory.DataSet) then
  begin
    GridOrderHistory.DataSet := vDS;
    //GridOrderQueue.RefreshData;
  end;
end;

procedure TFCCenterJournalNetZkz.PharmReserveDataChange(Sender: TObject; Field: TField);
begin
  if pcPharmReserveDetails.ActivePage = tsSpec then
  begin
    Self.Cursor := crHourGlass;
    try
      dmJSO.ExecPharmReserveSpec;
    finally
      Self.Cursor := crDefault;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aMain_ExecBellExecute(Sender: TObject);
begin
  //
end;

procedure TFCCenterJournalNetZkz.aMain_ConnectionPharmacyExecute(Sender: TObject);
begin
  UserActive;
  try
   frmStateConnectionPharmacy := TfrmStateConnectionPharmacy.Create(Self);
   try
    frmStateConnectionPharmacy.ShowModal;
   finally
    FreeAndNil(frmStateConnectionPharmacy);
   end;
  except
  end;
end;

procedure TFCCenterJournalNetZkz.aMain_SignBellExecute(Sender: TObject);
var
  IErr : integer;
  vErrMsg : string;
begin
  UserActive;
  if pgcJSO_JBO.ActivePage.Name = 'tabJSO' then
  begin
    if IsActionOrder then
    begin
      if CanEditOrder('SetOwnOrder', vErrMsg) then
        Self.ExecHistoryOrderAction('SetOwnOrder', '')
      else
        ShowError(vErrMsg);
    end
    else
    begin
      spSetSignBellUser.Parameters.ParamValues['@Order'] := OrderHeaderDS.FieldByName('orderID').AsInteger;;
      spSetSignBellUser.Parameters.ParamValues['@USER']  := Form1.id_user;
      spSetSignBellUser.ExecProc;
      IErr := spSetSignBellUser.Parameters.ParamValues['@RETURN_VALUE'];
      vErrMsg := spSetSignBellUser.Parameters.ParamValues['@SErr'];
      if IErr <> 0 then ShowMessage(vErrMsg);
      GridMainRefresh;
    end;
  end;
  {
  if pgcJSO_JBO.ActivePage.Name = 'tabJSO' then begin
    spSetSignBellUser.Parameters.ParamValues['@Order'] := OrderHeaderDS.FieldByName('orderID').AsInteger;;
    spSetSignBellUser.Parameters.ParamValues['@USER']  := Form1.id_user;
    spSetSignBellUser.ExecProc;
    IErr := spSetSignBellUser.Parameters.ParamValues['@RETURN_VALUE'];
    SErr := spSetSignBellUser.Parameters.ParamValues['@SErr'];
    if IErr <> 0 then ShowMessage(SErr);
    GridMainRefresh;
  end;}
end;

procedure TFCCenterJournalNetZkz.aMain_RP_AllJournalExecute(Sender: TObject);
var
  vExcel, vDD, WS: OleVariant;
  I, fl_cnt, num_cnt: integer;
begin
  UserActive;
  DBGridMain.Visible := False;
  DBGridSlave.Visible := False;
  try
    vExcel := CreateOLEObject('Excel.Application');
    vDD := vExcel.Workbooks.Add;
    WS := vDD.Sheets[1];
    fl_cnt := qrMain.FieldCount;
    for I := 1 to fl_cnt do begin
      vExcel.ActiveCell[1, I].Value := qrMain.Fields[I - 1].FieldName;
      MyBorder(WS, I, 1);
    end;
    I := 2;
    qrMain.First;
    while not qrMain.Eof do begin
      for num_cnt := 1 to fl_cnt do begin
        vExcel.ActiveCell[I, num_cnt].Value := qrMain.Fields[num_cnt - 1].AsString;
        MyBorder(WS, num_cnt, I);
      end;
      I := I + 1;
      qrMain.Next;
    end;
    vExcel.Columns[1].ColumnWidth := 10;
    vExcel.Columns[2].ColumnWidth := 50;
    vExcel.Columns[3].ColumnWidth := 10;
    vExcel.Columns[4].ColumnWidth := 10;
    vExcel.Columns[5].ColumnWidth := 10;
    vExcel.Columns[6].ColumnWidth := 20;
    vExcel.Range['A1:V1'].Columns.EntireColumn.AutoFit;
    vExcel.Visible := True;
  except
    on E: Exception do begin
      if vExcel = varDispatch then vExcel.Quit;
    end;
  end;
  DBGridMain.Visible := True;
  DBGridSlave.Visible := True;
end;

procedure TFCCenterJournalNetZkz.DBGridMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key in [27,37,38,39,40,13] then begin
    LocateOrder := '';
    pnlLocate.Visible := false;
  end;
end;

procedure TFCCenterJournalNetZkz.DBGridMainKeyPress(Sender: TObject; var Key: Char);
var
  S : String;
begin
  S := AnsiUpperCase(LocateOrder + Key);
  if OrderHeaderDS.Locate('orderName',AnsiLowerCase(S),[loCaseInsensitive,loPartialKey]) then begin
    LocateOrder := S;
    pnlLocate.Top := DBGridMain.Height - pnlLocate.Height - 3;
    pnlLocate.Visible := true;
    pnlLocate.Caption := LocateOrder;
  end;
end;

procedure TFCCenterJournalNetZkz.aMain_MarkDateBellExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  IErr := 0;
  if MessageDLG('Подтвердите выполнение действия',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  { Начальная инициализация действия }
  RegAction.ActionCode := 'SetMarkBellDate';
  RegAction.Order      := OrderHeaderDS.FieldByName('orderID').AsInteger;
  RegAction.Bell       := 0;
  { Проверяем состояние действия }
  RegActionState(IErr,SErr);
  if IErr = 0 then begin
    { Если открытое действие не зарегистрировано, то выполняем действие }
    if RegAction.State = 0 then begin
      { Регистрируем действие пользователя }
      RegActionOpen(IErr,SErr);
      if IErr = 0 then begin
        try
          spSetMarkDate.Parameters.ParamValues['@Order']    := OrderHeaderDS.FieldByName('orderID').AsInteger;
          spSetMarkDate.Parameters.ParamValues['@TypeMark'] := 1;
          spSetMarkDate.ExecProc;
          IErr := spSetMarkDate.Parameters.ParamValues['@RETURN_VALUE'];
          SErr := spSetMarkDate.Parameters.ParamValues['@SErr'];
          if IErr <> 0 then ShowMessage(SErr);
          RegActionClose;
        except
          on e:Exception do
            begin
              RegActionClose;
              ShowMessage('Сбой при выполнении действия. Попробуйте еще раз' + chr(10) + e.Message);
            end;
        end;
      end else begin
        ShowMessage('IErr = ' + VarToStr(IErr) + chr(10) + SErr);
      end;
    end else begin
      ShowMessage('Операция запрещена.' + chr(10) +
                  'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                  'Дата начала операции: ' + RegAction.SBeginDate
                 );
    end;
  end else ShowMessage(SErr);
  GridMainRefresh;
end;

procedure TFCCenterJournalNetZkz.aMain_MarkDateSMSExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  IErr := 0;
  if MessageDLG('Подтвердите выполнение действия',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  { Начальная инициализация действия }
  RegAction.ActionCode := 'SetMarkSMSDate';
  RegAction.Order      := OrderHeaderDS.FieldByName('orderID').AsInteger;
  RegAction.Bell       := 0;
  { Проверяем состояние действия }
  RegActionState(IErr,SErr);
  if IErr = 0 then begin
    { Если открытое действие не зарегистрировано, то выполняем действие }
    if RegAction.State = 0 then begin
      { Регистрируем действие пользователя }
      RegActionOpen(IErr,SErr);
      if IErr = 0 then begin
        try
          spSetMarkDate.Parameters.ParamValues['@Order']    := OrderHeaderDS.FieldByName('orderID').AsInteger;
          spSetMarkDate.Parameters.ParamValues['@TypeMark'] := 2;
          spSetMarkDate.ExecProc;
          IErr := spSetMarkDate.Parameters.ParamValues['@RETURN_VALUE'];
          SErr := spSetMarkDate.Parameters.ParamValues['@SErr'];
          if IErr <> 0 then ShowMessage(SErr);
          RegActionClose;
        except
          on e:Exception do
            begin
              RegActionClose;
              ShowMessage('Сбой при выполнении действия. Попробуйте еще раз' + chr(10) + e.Message);
            end;
        end;
      end else begin
        ShowMessage('IErr = ' + VarToStr(IErr) + chr(10) + SErr);
      end;
    end else begin
      ShowMessage('Операция запрещена.' + chr(10) +
                  'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                  'Дата начала операции: ' + RegAction.SBeginDate
                 );
    end;
  end else ShowMessage(SErr);
  GridMainRefresh;
end;

procedure TFCCenterJournalNetZkz.aMain_MarkDatePayExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  IErr := 0;
  if MessageDLG('Подтвердите выполнение действия',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  { Начальная инициализация действия }
  RegAction.ActionCode := 'SetMarkPayDate';
  RegAction.Order      := OrderHeaderDS.FieldByName('orderID').AsInteger;
  RegAction.Bell       := 0;
  { Проверяем состояние действия }
  RegActionState(IErr,SErr);
  if IErr = 0 then begin
    { Если открытое действие не зарегистрировано, то выполняем действие }
    if RegAction.State = 0 then begin
      { Регистрируем действие пользователя }
      RegActionOpen(IErr,SErr);
      if IErr = 0 then begin
        try
          spSetMarkDate.Parameters.ParamValues['@Order']    := OrderHeaderDS.FieldByName('orderID').AsInteger;
          spSetMarkDate.Parameters.ParamValues['@TypeMark'] := 3;
          spSetMarkDate.ExecProc;
          IErr := spSetMarkDate.Parameters.ParamValues['@RETURN_VALUE'];
          SErr := spSetMarkDate.Parameters.ParamValues['@SErr'];
          if IErr <> 0 then ShowMessage(SErr);
          RegActionClose;
        except
          on e:Exception do
            begin
              RegActionClose;
              ShowMessage('Сбой при выполнении действия. Попробуйте еще раз' + chr(10) + e.Message);
            end;
        end;
      end else begin
        ShowMessage('IErr = ' + VarToStr(IErr) + chr(10) + SErr);
      end;
    end else begin
      ShowMessage('Операция запрещена.' + chr(10) +
                  'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                  'Дата начала операции: ' + RegAction.SBeginDate
                 );
    end;
  end else ShowMessage(SErr);
  GridMainRefresh;
end;

procedure TFCCenterJournalNetZkz.aMain_MarkDateAssemblingExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  IErr := 0;
  if MessageDLG('Подтвердите выполнение действия',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  { Начальная инициализация действия }
  RegAction.ActionCode := 'SetMarkAssemblingDate';
  RegAction.Order      := OrderHeaderDS.FieldByName('orderID').AsInteger;
  RegAction.Bell       := 0;
  { Проверяем состояние действия }
  RegActionState(IErr,SErr);
  if IErr = 0 then begin
    { Если открытое действие не зарегистрировано, то выполняем действие }
    if RegAction.State = 0 then begin
      { Регистрируем действие пользователя }
      RegActionOpen(IErr,SErr);
      if IErr = 0 then begin
        try
          spSetMarkDate.Parameters.ParamValues['@Order']    := OrderHeaderDS.FieldByName('orderID').AsInteger;
          spSetMarkDate.Parameters.ParamValues['@TypeMark'] := 4;
          spSetMarkDate.ExecProc;
          IErr := spSetMarkDate.Parameters.ParamValues['@RETURN_VALUE'];
          SErr := spSetMarkDate.Parameters.ParamValues['@SErr'];
          if IErr <> 0 then ShowMessage(SErr);
          RegActionClose;
        except
          on e:Exception do
            begin
              RegActionClose;
              ShowMessage('Сбой при выполнении действия. Попробуйте еще раз' + chr(10) + e.Message);
            end;
        end;
      end else begin
        ShowMessage('IErr = ' + VarToStr(IErr) + chr(10) + SErr);
      end;
    end else begin
      ShowMessage('Операция запрещена.' + chr(10) +
                  'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                  'Дата начала операции: ' + RegAction.SBeginDate
                 );
    end;
  end else ShowMessage(SErr);
  GridMainRefresh;
end;

procedure TFCCenterJournalNetZkz.aMain_MarkDispatchDeclarationExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  { Начальная инициализация действия }
  RegAction.ActionCode := 'SetMarkDispatchDeclaration';
  RegAction.Order      := OrderHeaderDS.FieldByName('orderID').AsInteger;
  RegAction.Bell       := 0;
  { Проверяем состояние действия }
  RegActionState(IErr,SErr);
  if IErr = 0 then begin
    { Если открытое действие не зарегистрировано, то выполняем действие }
    if RegAction.State = 0 then begin
      { Регистрируем действие пользователя }
      RegActionOpen(IErr,SErr);
      if IErr = 0 then begin
        try
         frmCCJS_MarkDispatchDeclaration := TfrmCCJS_MarkDispatchDeclaration.Create(Self);
         try
          frmCCJS_MarkDispatchDeclaration.ShowModal;
         finally
          FreeAndNil(frmCCJS_MarkDispatchDeclaration);
          RegActionClose;
          JSOSetOrderProcessed(RegAction.Order,RegAction.NUSER);
          GridSlaveRefresh;
          GridMainRefresh;
         end;
        except
          on e:Exception do begin
            ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
            RegActionClose;
            JSOSetOrderProcessed(RegAction.Order,RegAction.NUSER);
          end;
        end;
      end else begin
        ShowMessage('IErr = ' + VarToStr(IErr) + chr(10) + SErr);
      end;
    end else begin
      ShowMessage('Операция запрещена.' + chr(10) +
                  'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                  'Дата начала операции: ' + RegAction.SBeginDate
                 );
    end;
  end else ShowMessage(SErr);
  GridMainRefresh;
end;

procedure TFCCenterJournalNetZkz.aMain_MarkNoteExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  { Начальная инициализация действия }
  RegAction.ActionCode := 'SetMarkNote';
  RegAction.Order      := OrderHeaderDS.FieldByName('orderID').AsInteger;
  RegAction.Bell       := 0;
  { Проверяем состояние действия }
  RegActionState(IErr,SErr);
  if IErr = 0 then begin
    { Если открытое действие не зарегистрировано, то выполняем действие }
    if RegAction.State = 0 then begin
      { Регистрируем действие пользователя }
      RegActionOpen(IErr,SErr);
      if IErr = 0 then begin
        try
         frmCCJS_MarkNote := TfrmCCJS_MarkNote.Create(Self);
         try
          frmCCJS_MarkNote.ShowModal;
         finally
          FreeAndNil(frmCCJS_MarkNote);
          RegActionClose;
          JSOSetOrderProcessed(RegAction.Order,RegAction.NUSER);
          GridSlaveRefresh;
          GridMainRefresh;
         end;
        except
          on e:Exception do begin
            ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
            RegActionClose;
            JSOSetOrderProcessed(RegAction.Order,RegAction.NUSER);
          end;
        end;
      end else begin
        ShowMessage('IErr = ' + VarToStr(IErr) + chr(10) + SErr);
      end;
    end else begin
      ShowMessage('Операция запрещена.' + chr(10) +
                  'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                  'Дата начала операции: ' + RegAction.SBeginDate
                 );
    end;
  end else ShowMessage(SErr);
  GridMainRefresh;
end;

procedure TFCCenterJournalNetZkz.DBGridMainTitleClick(Column: TColumn);
var
  iCkl : integer;
begin
  if Column.Title.Font.Color = clWindowText then begin
    { Восстанавливаем прорисовку по умолчанию }
    for iCkl := 0 to DBGridMain.Columns.count - 1 do begin
      if DBGridMain.Columns[iCkl].Title.Font.Color <> clWindowText then begin
        DBGridMain.Columns[iCkl].Title.Font.Color := clWindowText;
        DBGridMain.Columns[iCkl].Title.Font.Style := [];
        DBGridMain.Columns[iCkl].Title.Caption := copy(DBGridMain.Columns[iCkl].Title.Caption,2,length(DBGridMain.Columns[iCkl].Title.Caption)-1);
      end;
    end;
    { Для выбранного столбца включаем сортировку по возрастанию }
    Column.Title.Font.Color := clBlue;
    Column.Title.Font.Style := [fsBold];
    Column.Title.Caption := chr(24)+Column.Title.Caption;
    MainSortField := Column.FieldName + ' ';
    ExecConditionQRMain;
  end
  else if Column.Title.Font.Color = clBlue then begin
    { Для выбранного столбца включаем сортировку по убыванию }
    Column.Title.Font.Color := clFuchsia;
    Column.Title.Font.Style := [fsBold];
    Column.Title.Caption := '!'+copy(Column.Title.Caption,2,length(Column.Title.Caption)-1);
    MainSortField := Column.FieldName + ' desc ';
    ExecConditionQRMain;
  end
  else if Column.Title.Font.Color = clFuchsia then begin
    { Для выбранного столбца отключаем сортировку }
    Column.Title.Font.Color := clWindowText;
    Column.Title.Font.Style := [];
    Column.Title.Caption := copy(Column.Title.Caption,2,length(Column.Title.Caption)-1);
    MainSortField := '';
    ExecConditionQRMain;
  end;
  ShowGets;
end;

procedure TFCCenterJournalNetZkz.JSOShowPayGridCheck;
begin
  if aJSOPay_ShowCheck.Checked then begin
    pnlSlave_PayGrid_Pay.Align := alLeft;
    pnlSlave_PayGrid_Pay.Width := Width_pnlSlave_PayGrid_Pay;
    splitSlave_Pay.Left := Width_pnlSlave_PayGrid_Pay;
    splitSlave_Pay.Enabled := true;
    pnlSlave_PayGrid_Check.Visible := true;
  end else begin
    Width_pnlSlave_PayGrid_Pay := pnlSlave_PayGrid_Pay.Width;
    pnlSlave_PayGrid_Check.Visible := False;
    pnlSlave_PayGrid_Pay.Align := alClient;
    splitSlave_Pay.Enabled := false;
  end;
end;

procedure TFCCenterJournalNetZkz.pgcSlaveChange(Sender: TObject);
begin
  UserActive;
  if pgcSlave.ActivePage = tabSlave_Order then begin
    if OrderHeaderDS.IsEmpty then begin
      qrspSlave.Active := false;
      qrspSlave.Parameters.ParamByName('@PRN').Value := 0;
      qrspSlave.Active := true;
    end else begin
      qrspSlave.Active := false;
      qrspSlave.Parameters.ParamByName('@PRN').Value := OrderHeaderDS.FieldByName('orderID').AsInteger;
      qrspSlave.Active := true;
    end;
  end else
  if pgcSlave.ActivePage = tabSlave_History then begin
    if OrderHeaderDS.IsEmpty then begin
      qrspJSOHistory.Active := false;
      qrspJSOHistory.Parameters.ParamByName('@Order').Value := 0;
      qrspJSOHistory.Active := true;
    end else begin
      qrspJSOHistory.Active := false;
      qrspJSOHistory.Parameters.ParamByName('@Order').Value := OrderHeaderDS.FieldByName('orderID').AsInteger;
      qrspJSOHistory.Active := true;
    end;
  end else
  if pgcSlave.ActivePage = tabSlave_Pay then begin
    JSOShowPayGridCheck;
    ExecConditionJSOPay;
    if aJSOPay_ShowCheck.Checked then begin
      ExecConditionJSOCheck;
    end;
  end else
  if pgcSlave.ActivePage = tabSlave_NPost then begin
    ExecConditionJSONPost;
  end;
  if pgcSlave.ActivePage = tabSlave_NPostPay then begin
    ExecConditionJSONPostPay;
  end;
  if pgcSlave.ActivePage = tabSlave_PayTransaction then
  begin
    dmJSO.ExecConditionPayTransaction(OrderHeaderDS.FieldByName('orderID').AsInteger);
  end;
  if pgcSlave.ActivePage = tabSlave_Queue then
    InitOrderQueue;
  if pgcSlave.ActivePage = tabSlave_OrderHistory then
    InitOrderHistory;
  ShowGets;
end;

procedure TFCCenterJournalNetZkz.pmReference_ActionFoundationClick(Sender: TObject);
begin
  UserActive;
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeShow);
   frmReference.SetReferenceIndex(cFReferenceActionFoundation);
   try
    frmReference.ShowModal;
   finally
    FreeAndNil(frmReference);
   end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aMain_OrderCloseExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
  vParams: TOrderStateParam;
  vOrderShipment: string;
begin
  UserActive;
  if IsActionOrder then
    ExecHistoryOrderAction('CloseOrder',
      '')
  else
  begin
    { Начальная инициализация действия }
    RegAction.ActionCode := 'CloseOrder';
    RegAction.Order      := OrderHeaderDS.FieldByName('orderID').AsInteger;
    RegAction.Bell       := 0;
    { Проверяем состояние действия }
    RegActionState(IErr,SErr);
    if IErr = 0 then begin
      { Если открытое действие не зарегистрировано, то выполняем действие }
      if RegAction.State = 0 then begin
        try
          JSOAssignHeaderItem;
          vParams.OrderHeader := Self.JSOHeaderItem;
          vParams.StateMode := cJSOStateClose;
          vParams.UserId := RegAction.NUSER;
          vOrderShipment := Trim(AnsiUpperCase(Self.JSOHeaderItem.orderShipping));
          vParams.SendSMS :=
          (vOrderShipment = 'НОВАЯ ПОЧТА') or (vOrderShipment = 'НОВА ПОШТА');
          vParams.SMSType := 3;
          TfrmCCJS_State.Execute(vParams, Self);
          {frmCCJS_State := TfrmCCJS_State.Create(Self);
          frmCCJS_State.SetModeAction(cJSOStateClose);
          frmCCJS_State.SetRN(OrderHeaderDS.FieldByName('orderID').AsInteger);
          frmCCJS_State.SetPrice(OrderHeaderDS.FieldByName('orderAmount').AsFloat);
          frmCCJS_State.SetClient(OrderHeaderDS.FieldByName('orderShipName').AsString);
          frmCCJS_State.SetUser(RegAction.NUSER);
          frmCCJS_State.SetOrderShipping(trim(OrderHeaderDS.FieldByName('orderShipping').AsString));
          try
            frmCCJS_State.ShowModal;
          finally
            FreeAndNil(frmCCJS_State);
          end;}
        except
          on e:Exception do begin
            ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
          end;
        end;

        GridMainRefresh;
      end else begin
        ShowMessage('Операция запрещена.' + chr(10) +
                    'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                    'Дата начала операции: ' + RegAction.SBeginDate
                   );
      end;
    end else ShowMessage(SErr);
  end;
end;

procedure TFCCenterJournalNetZkz.aMain_OrderOpenExecute(Sender: TObject);
var
  vParams: TOrderStateParam;
begin
  UserActive;
  if IsActionOrder then
    ExecHistoryOrderAction('OpenOrder',
      '')
  else
  begin
    try
     {frmCCJS_State := TfrmCCJS_State.Create(Self);
     frmCCJS_State.SetModeAction(cJSOStateOpen);
     frmCCJS_State.SetRN(OrderHeaderDS.FieldByName('orderID').AsInteger);
     frmCCJS_State.SetPrice(OrderHeaderDS.FieldByName('orderAmount').AsFloat);
     frmCCJS_State.SetClient(OrderHeaderDS.FieldByName('orderShipName').AsString);
     frmCCJS_State.SetUser(RegAction.NUSER);
     frmCCJS_State.SetOrderShipping(trim(OrderHeaderDS.FieldByName('orderShipping').AsString));
     try
      frmCCJS_State.ShowModal;
     finally
      FreeAndNil(frmCCJS_State);
     end;}
      JSOAssignHeaderItem;
      vParams.OrderHeader := Self.JSOHeaderItem;
      vParams.StateMode := cJSOStateOpen;
      vParams.UserId := RegAction.NUSER;
      vParams.SendSMS := false;
      TfrmCCJS_State.Execute(vParams, Self);
    except
      on e:Exception do begin
        ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
      end;
    end;
    GridMainRefresh;
  end;  
end;

procedure TFCCenterJournalNetZkz.aMain_ExportOrder1CExecute(Sender: TObject);
begin
  UserActive;
  ExecHistoryOrderAction('ExportOrderIn1C',
    'Подтвердите выполнение действия');
end;

procedure TFCCenterJournalNetZkz.splitJRMOMainMoved(Sender: TObject);
begin
  SetKoefJRMOShowSplit;
end;

procedure TFCCenterJournalNetZkz.dsJRMOMainDataChange(Sender: TObject; Field: TField);
begin
  if pgcJRMOSlave.ActivePage = tabJRMOSlave_HIST then begin
    ExecConditionJRMOHist;
  end else
  if pgcJRMOSlave.ActivePage = tabJRMOSlave_Armour then begin
    ExecConditionJRMOItem;
  end;
  JRMOShowGets;
end;

procedure TFCCenterJournalNetZkz.JRMOGridMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  if not (gdSelected in State) then begin
    if length(db.DataSource.DataSet.FieldByName('SCloseDate').AsString) <> 0 then begin
      { Закрытые заказы редких лекарств }
      db.Canvas.Brush.Color := TColor($D3D3D3);
    end;
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFCCenterJournalNetZkz.aJRMOMain_OrderCloseExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  { Начальная инициализация действия }
  RegAction.ActionCode := 'JRMO_Close';
  RegAction.Order      := JRMOGridMain.DataSource.DataSet.FieldByName('NOrderID').AsInteger;
  RegAction.Bell       := 0;
  { Проверяем состояние действия }
  JRMORegActionState(IErr,SErr);
  if IErr = 0 then begin
    { Если открытое действие не зарегистрировано, то выполняем действие }
    if RegAction.State = 0 then begin
      try
        frmCCJRMO_State := TfrmCCJRMO_State.Create(Self);
        frmCCJRMO_State.SetMode(cJRMOStateClose);
        frmCCJRMO_State.SetRN(RegAction.Order);
        frmCCJRMO_State.SetPrice(JRMOGridMain.DataSource.DataSet.FieldByName('NItemPrice').AsFloat);
        frmCCJRMO_State.SetClient(JRMOGridMain.DataSource.DataSet.FieldByName('SOrderShipName').AsString);
        frmCCJRMO_State.SetUser(RegAction.NUSER);
        try
          frmCCJRMO_State.ShowModal;
        finally
          FreeAndNil(frmCCJRMO_State);
        end;
      except
        on e:Exception do begin
          ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
        end;
      end;
      JRMOGridMainRefresh;
    end else begin
      ShowMessage('Операция запрещена.' + chr(10) +
                  'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                  'Дата начала операции: ' + RegAction.SBeginDate
                 );
    end;
  end else ShowMessage(SErr);
end;

procedure TFCCenterJournalNetZkz.aJRMOMain_OrderOpenExecute(Sender: TObject);
begin
  UserActive;
  try
   frmCCJRMO_State := TfrmCCJRMO_State.Create(Self);
   frmCCJRMO_State.SetMode(cJRMOStateOpen);
   frmCCJRMO_State.SetRN(JRMOGridMain.DataSource.DataSet.FieldByName('NOrderID').AsInteger);
   frmCCJRMO_State.SetPrice(JRMOGridMain.DataSource.DataSet.FieldByName('NItemPrice').AsFloat);
   frmCCJRMO_State.SetClient(JRMOGridMain.DataSource.DataSet.FieldByName('SOrderShipName').AsString);
   frmCCJRMO_State.SetUser(RegAction.NUSER);
   try
    frmCCJRMO_State.ShowModal;
   finally
    FreeAndNil(frmCCJRMO_State);
   end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
  JRMOGridMainRefresh;
end;

procedure TFCCenterJournalNetZkz.aJRMOMain_RefreshExecute(Sender: TObject);
begin
  if pgcJSO_JBO.ActivePage.Name = 'tabJRMO' then begin
    JRMOGridMainRefresh;
    JRMOShowGets;
  end;
end;

procedure TFCCenterJournalNetZkz.aJRMOMain_ClearConditionExecute(Sender: TObject);
begin
  JRMOSetClearCondition;
  aJRMOCondValueFieldChange.Execute;
  pgcJRMOCondition.ActivePage := tabJRMOCondition_Order;
  JRMOShowGets;
end;

procedure TFCCenterJournalNetZkz.aJRMOMain_RP_JournalExecute(Sender: TObject);
begin
  Form1.DBGridToExcel(JRMOGridMain);
end;

procedure TFCCenterJournalNetZkz.aJRMOMain_MarkDateBellExecute(Sender: TObject);
begin
  //
end;

procedure TFCCenterJournalNetZkz.aJRMOMain_MarkDateSMSExecute(Sender: TObject);
begin
  //
end;

procedure TFCCenterJournalNetZkz.aJRMOMain_MarkNoteExecute(Sender: TObject);
begin
  //
end;

procedure TFCCenterJournalNetZkz.dsJRMOHistDataChange(Sender: TObject; Field: TField);
begin
  //
end;

procedure TFCCenterJournalNetZkz.aMain_SetDriverExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  { Начальная инициализация действия }
  RegAction.ActionCode := 'SetOrderDrivers';
  RegAction.Order      := OrderHeaderDS.FieldByName('orderID').AsInteger;
  RegAction.Bell       := 0;
  { Проверка наличия операции в истории }
  ExistActionState(IErr,SErr);
  if IErr = 0 then begin
    { Если действие зарегистрировано в истории }
    if RegAction.State <> 0 then
      if MessageDLG(
                    'Действие уже выполнялось.' + chr(10) +
                    'Пользователь: ' + RegAction.SUSER + chr(10) +
                    'Дата операции: ' + RegAction.SBeginDate + chr(10)+
                    'Подтвердите определение нового водителя для заказа',
                    mtConfirmation,[mbYes,mbNo],0
                   ) = mrNo then exit;
    { Проверяем состояние действия }
    RegActionState(IErr,SErr);
    if IErr = 0 then begin
      { Если открытое действие не зарегистрировано, то выполняем действие }
      if RegAction.State = 0 then begin
        try
         frmCCJS_SetDrivers := TfrmCCJS_SetDrivers.Create(Self);
         frmCCJS_SetDrivers.SetCodeAction(RegAction.ActionCode);
         frmCCJS_SetDrivers.SetRN(OrderHeaderDS.FieldByName('orderID').AsInteger);
         frmCCJS_SetDrivers.SetPrice(OrderHeaderDS.FieldByName('orderAmount').AsFloat);
         frmCCJS_SetDrivers.SetClient(OrderHeaderDS.FieldByName('orderShipName').AsString);
         frmCCJS_SetDrivers.SetUser(RegAction.NUSER);
         try
          frmCCJS_SetDrivers.ShowModal;
         finally
          FreeAndNil(frmCCJS_SetDrivers);
         end;
        except
          on e:Exception do begin
            ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
          end;
        end;
        GridMainRefresh;
      end else begin
        ShowMessage('Операция запрещена.' + chr(10) +
                    'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                    'Дата начала операции: ' + RegAction.SBeginDate
                   );
      end;
    end else ShowMessage(SErr);
  end else ShowMessage(SErr);
end;

procedure TFCCenterJournalNetZkz.aJSOSlave_PartsExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJS_PartsPosition := TfrmCCJS_PartsPosition.Create(Self);
    frmCCJS_PartsPosition.SetModeParts(cFModeParts_JSO);
    frmCCJS_PartsPosition.SetOrder(OrderHeaderDS.FieldByName('orderID').AsInteger);
    frmCCJS_PartsPosition.SetRN(DBGridSlave.DataSource.DataSet.FieldByName('NRN').AsInteger);
    frmCCJS_PartsPosition.SetPrice(OrderHeaderDS.FieldByName('orderAmount').AsFloat);
    frmCCJS_PartsPosition.SetClient(OrderHeaderDS.FieldByName('orderShipName').AsString);
    frmCCJS_PartsPosition.SetUser(RegAction.NUSER);
    frmCCJS_PartsPosition.SetArtCode(DBGridSlave.DataSource.DataSet.FieldByName('NArtCode').AsInteger);
    frmCCJS_PartsPosition.SetArtName(DBGridSlave.DataSource.DataSet.FieldByName('SArtName').AsString);
    try
     frmCCJS_PartsPosition.ShowModal;
    finally
     FreeAndNil(frmCCJS_PartsPosition);
    end;
    except
      on e:Exception do begin
        ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
      end;
  end;
end;

procedure TFCCenterJournalNetZkz.aMain_OrderStatusExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  JSOAssignHeaderItem;
  if pgcJSO_JBO.ActivePage.Name = 'tabJSO' then begin
    { Начальная инициализация действия }
    RegAction.ActionCode := 'SetCurrentOrderStatus';
    RegAction.Order      := OrderHeaderDS.FieldByName('orderID').AsInteger;
    RegAction.Bell       := 0;
    { Проверяем состояние действия }
    RegActionState(IErr,SErr);
    if IErr = 0 then begin
      { Если открытое действие не зарегистрировано, то выполняем действие }
      if RegAction.State = 0 then begin
        try
         frmCCJS_OrderStatus := TfrmCCJS_OrderStatus.Create(Self);
         frmCCJS_OrderStatus.SetCodeAction(RegAction.ActionCode);
         frmCCJS_OrderStatus.SetRN(OrderHeaderDS.FieldByName('orderID').AsInteger);
         frmCCJS_OrderStatus.SetPrice(OrderHeaderDS.FieldByName('orderAmount').AsFloat);
         frmCCJS_OrderStatus.SetClient(OrderHeaderDS.FieldByName('orderShipName').AsString);
         frmCCJS_OrderStatus.SetUser(RegAction.NUSER);
         frmCCJS_OrderStatus.SetNote(OrderHeaderDS.FieldByName('SNote').AsString);
         frmCCJS_OrderStatus.SetOrderShipping(trim(OrderHeaderDS.FieldByName('orderShipping').AsString));
         frmCCJS_OrderStatus.SetRecHeaderItem(JSOHeaderItem);
         frmCCJS_OrderStatus.SetRecSession(UserSession);
         try
          frmCCJS_OrderStatus.ShowModal;
         finally
          FreeAndNil(frmCCJS_OrderStatus);
         end;
        except
          on e:Exception do begin
            ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
          end;
        end;
        GridMainRefresh;
      end else begin
        ShowMessage('Операция запрещена.' + chr(10) +
                    'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                    'Дата начала операции: ' + RegAction.SBeginDate
                   );
      end;
    end else ShowMessage(SErr);
  end;
end;

procedure TFCCenterJournalNetZkz.aJSOSlave_TermExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJS_ArtCodeTerm := TfrmCCJS_ArtCodeTerm.Create(Self);
    frmCCJS_ArtCodeTerm.SetModeTerm(cFModeTerm_JSO);
    frmCCJS_ArtCodeTerm.SetOrder(OrderHeaderDS.FieldByName('orderID').AsInteger);
    frmCCJS_ArtCodeTerm.SetRN(DBGridSlave.DataSource.DataSet.FieldByName('NRN').AsInteger);
    frmCCJS_ArtCodeTerm.SetPrice(OrderHeaderDS.FieldByName('orderAmount').AsFloat);
    frmCCJS_ArtCodeTerm.SetClient(OrderHeaderDS.FieldByName('orderShipName').AsString);
    frmCCJS_ArtCodeTerm.SetUser(RegAction.NUSER);
    frmCCJS_ArtCodeTerm.SetArtCode(DBGridSlave.DataSource.DataSet.FieldByName('NArtCode').AsInteger);
    frmCCJS_ArtCodeTerm.SetArtName(DBGridSlave.DataSource.DataSet.FieldByName('SArtName').AsString);
    frmCCJS_ArtCodeTerm.SetRemnTerm(DBGridSlave.DataSource.DataSet.FieldByName('NitemRemnTerm').AsInteger);
    try
     frmCCJS_ArtCodeTerm.ShowModal;
    finally
     FreeAndNil(frmCCJS_ArtCodeTerm);
    end;
    except
      on e:Exception do begin
        ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
      end;
  end;
end;

procedure TFCCenterJournalNetZkz.aJSOCndHist_SLNameActionExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  UserActive;
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFReferenceJSOUserActions);
   frmReference.SetReadOnly(cFReferenceYesReadOnly);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    JSOHist_RNUserAction := frmReference.GetRowIDSelect;
    if length(DescrSelect) > 0 then edJSOCndHist_NameOperation.Text := DescrSelect;
   finally
    FreeAndNil(frmReference);
   end;
  except
  end;
end;

procedure TFCCenterJournalNetZkz.aJFBMain_CloseExecute(Sender: TObject);
begin
  //
end;

procedure TFCCenterJournalNetZkz.aJFBMain_OpenExecute(Sender: TObject);
begin
  //
end;

procedure TFCCenterJournalNetZkz.aJFBMain_RefreshExecute(Sender: TObject);
begin
  if pgcJSO_JBO.ActivePage.Name = 'tabJFB' then begin
    JFBGridMainRefresh;
    JFBShowGets;
  end;
end;

procedure TFCCenterJournalNetZkz.aJFBMain_ClearConditionExecute(Sender: TObject);
begin
  JFBSetClearCondition;
  pgcJFBCondition.ActivePage := tabJFBCondition_Doc;
  JFBShowGets;
end;

procedure TFCCenterJournalNetZkz.aJFBMain_RP_AllJournalExecute(Sender: TObject);
begin
  Form1.DBGridToExcel(JFBGridMain);
end;

procedure TFCCenterJournalNetZkz.aJFBMain_InfoExecute(Sender: TObject);
var
  IType : smallint;
begin
  UserActive;
  if pgcJSO_JBO.ActivePage.Name = 'tabJFB' then begin
    try
      frmCCJFB_Status := TfrmCCJFB_Status.Create(Self);
      IType := JFBGridMain.DataSource.DataSet.FieldByName('INumbTypeMessage').AsInteger;
      frmCCJFB_Status.SetMode(cJFBStatusMode_InfoMsg);
      frmCCJFB_Status.SetPRN(JFBGridMain.DataSource.DataSet.FieldByName('NRN').AsInteger);
      frmCCJFB_Status.SetType(IType);
      frmCCJFB_Status.SetClient(JFBGridMain.DataSource.DataSet.FieldByName('SAllName').AsString);
      frmCCJFB_Status.SetUser(RegAction.NUSER);
      frmCCJFB_Status.SetPhone(JFBGridMain.DataSource.DataSet.FieldByName('SPhone').AsString);
      frmCCJFB_Status.SetEMail(JFBGridMain.DataSource.DataSet.FieldByName('SEmail').AsString);
      frmCCJFB_Status.SetContents(JFBGridMain.DataSource.DataSet.FieldByName('SMessage').AsString);
      frmCCJFB_Status.SetNote(JFBGridMain.DataSource.DataSet.FieldByName('SComment').AsString);
      try
        frmCCJFB_Status.ShowModal;
      finally
        FreeAndNil(frmCCJFB_Status);
      end;
    except
      on e:Exception do begin
        ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
      end;
    end;
    JFBGridMainRefresh;
    JFBShowGets;
  end;
end;

procedure TFCCenterJournalNetZkz.aJFBMain_StatusExecute(Sender: TObject);
var
  IType : smallint;
  IErr  : integer;
  SErr  : string;
begin
  UserActive;
  if pgcJSO_JBO.ActivePage.Name = 'tabJFB' then begin
    IErr := 0;
    SErr := '';
    { Начальная инициализация действия }
    RegAction.ActionCode := 'JFB_State';
    RegAction.Order      := JFBGridMain.DataSource.DataSet.FieldByName('NRN').AsInteger;
    RegAction.Bell       := 0;
    { Проверяем состояние действия }
    JFBRegActionState(IErr,SErr);
    if IErr = 0 then begin
      { Если открытое действие не зарегистрировано, то выполняем действие }
      if RegAction.State = 0 then begin
        { Регистрируем действие пользователя }
        JFBRegActionOpen(IErr,SErr);
        if IErr = 0 then begin
          try
            frmCCJFB_Status := TfrmCCJFB_Status.Create(Self);
            IType := JFBGridMain.DataSource.DataSet.FieldByName('INumbTypeMessage').AsInteger;
            if      IType = cJFBType_FeedBack then frmCCJFB_Status.SetMode(cJFBStatusMode_FeedBack)
            else if IType = cJFBType_Message  then frmCCJFB_Status.SetMode(cJFBStatusMode_StatusMsg);
            frmCCJFB_Status.SetPRN(JFBGridMain.DataSource.DataSet.FieldByName('NRN').AsInteger);
            frmCCJFB_Status.SetType(IType);
            frmCCJFB_Status.SetClient(JFBGridMain.DataSource.DataSet.FieldByName('SAllName').AsString);
            frmCCJFB_Status.SetUser(RegAction.NUSER);
            frmCCJFB_Status.SetPhone(JFBGridMain.DataSource.DataSet.FieldByName('SPhone').AsString);
            frmCCJFB_Status.SetEMail(JFBGridMain.DataSource.DataSet.FieldByName('SEmail').AsString);
            frmCCJFB_Status.SetContents(JFBGridMain.DataSource.DataSet.FieldByName('SMessage').AsString);
            frmCCJFB_Status.SetNote(JFBGridMain.DataSource.DataSet.FieldByName('SComment').AsString);
            frmCCJFB_Status.SetRNHist(RegAction.RN);
            try
              frmCCJFB_Status.ShowModal;
            finally
              FreeAndNil(frmCCJFB_Status);
              JFBRegActionClose;
            end;
          except
            on e:Exception do begin
              ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
              JFBRegActionClose;
            end;
          end;
        end else begin
          ShowMessage('IErr = ' + VarToStr(IErr) + chr(10) + SErr);
        end;
      end else begin
        ShowMessage('Операция запрещена.' + chr(10) +
                    'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                    'Дата начала операции: ' + RegAction.SBeginDate
                   );
      end;
    end else ShowMessage(SErr);
    JFBGridMainRefresh;
    JFBShowGets;
  end;
end;

procedure TFCCenterJournalNetZkz.aJFBMain_SendEMailExecute(Sender: TObject);
begin
  //
end;

procedure TFCCenterJournalNetZkz.splitJFBMainMoved(Sender: TObject);
begin
  SetKoefJFBShowSplit;
end;

procedure TFCCenterJournalNetZkz.aJFBMain_ChangeConditionExecute(Sender: TObject);
begin
  ExecConditionJFBMain;
end;

procedure TFCCenterJournalNetZkz.JFBGridMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  if not (gdSelected in State) then begin
    if length(db.DataSource.DataSet.FieldByName('SCloseDate').AsString) <> 0 then begin
      { Закрытые документы раздела }
      db.Canvas.Brush.Color := TColor(clSilver);
    end;
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFCCenterJournalNetZkz.JFBGridHistDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFCCenterJournalNetZkz.dsJFBMainDataChange(Sender: TObject; Field: TField);
begin
  if pgcJFBSlave.ActivePage = tabJFBSlave_HIST then begin
    if JFBGridMain.DataSource.DataSet.IsEmpty then begin
      qrspJFBHist.Active := false;
      qrspJFBHist.Parameters.ParamByName('@NRNMain').Value := 0;
      qrspJFBHist.Active := true;
    end else begin
      qrspJFBHist.Active := false;
      qrspJFBHist.Parameters.ParamByName('@NRNMain').Value := JFBGridMain.DataSource.DataSet.FieldByName('NRN').AsInteger;
      qrspJFBHist.Active := true;
    end;
  end;
  JFBShowGets;
end;

procedure TFCCenterJournalNetZkz.aMain_RP_QuantIndicatorsUserExperienceExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJS_RP_QuantIndicatorsUserExperience := TfrmCCJS_RP_QuantIndicatorsUserExperience.Create(Self);
    try
      frmCCJS_RP_QuantIndicatorsUserExperience.ShowModal;
    finally
      FreeAndNil(frmCCJS_RP_QuantIndicatorsUserExperience);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aJSOHist_ForcedFlosureExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
    spAllowActionClose.Parameters.ParamValues['@Mode']   := 1; { Режим принудительного закрытия действия }
    spAllowActionClose.Parameters.ParamValues['@RNHist'] := JSOGridHistory.DataSource.DataSet.FieldByName('NRN').AsInteger;
    spAllowActionClose.Parameters.ParamValues['@NUSER']  := Form1.id_user;
    spAllowActionClose.ExecProc;
    IErr := spAllowActionClose.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      SErr := spAllowActionClose.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  JSOGridSlaveHistRefresh;
end;

procedure TFCCenterJournalNetZkz.JSOGridHistoryDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFCCenterJournalNetZkz.dsJSOHistoryDataChange(Sender: TObject; Field: TField);
begin
  JSOShowGetsSlave_Hist;
end;

procedure TFCCenterJournalNetZkz.aMain_ConditionExecute(Sender: TObject);
var
  SignOkCondition    : boolean;
  NumbImgOrderPeriod : integer;
begin
  UserActive;
  { Сохраняем значения полей условия отбора }
  JSOSaveCondition;
  if pgcJSO_JBO.ActivePage.Name = 'tabJSO' then begin
    SignOkCondition := false;
    try
      frmCCJSO_Condition := TfrmCCJSO_Condition.Create(Self);
      frmCCJSO_Condition.SetRecCondition(JSOCondRec);
      frmCCJSO_Condition.SetSignDSEmpty(iif(qrMain.IsEmpty,true,false));
      frmCCJSO_Condition.SetSignOrderClose(iif(not VarIsAssigned(OrderHeaderDS.FieldByName('DCloseDate').Value),false,true));
      frmCCJSO_Condition.SetParentsList(ParentsList);
      frmCCJSO_Condition.SetSlavesList(SlavesList);
      try
        frmCCJSO_Condition.ShowModal;
        SignOkCondition := frmCCJSO_Condition.GetSignOkCondition;
        if SignOkCondition then begin
          { Присваиваем значения полям }
          IJSOSignMassChangeCondition := 1;
          SetClearCondition;
          JSOCondRec := frmCCJSO_Condition.GetRecCondition;
          { Реквизиты заказа }
          dtCndBegin.Date                       := JSOCondRec.BeginDate;
          dtCndEnd.Date                         := JSOCondRec.EndDate;
          chbxCndAccountPeriod.Checked          := JSOCondRec.SignAccountPeriod;
          cmbxCndState.ItemIndex                := JSOCondRec.OrderState;
          edCndApteka.Text                      := JSOCondRec.Pharmacy;
          edCndOrderShipping.Text               := JSOCondRec.Shipping;
          edCndShipName.Text                    := JSOCondRec.AllNameClient;
          edCndPhone.Text                       := JSOCondRec.PhoneClient;
          edAptAdress.Text                      := JSOCondRec.AdresClient;
          edJSOCndPay_SDispatchDeclaration.Text := JSOCondRec.SDispatchDeclaration;
          { История операций }
          edJSOCndHist_NameOperation.Text := JSOCondRec.NameAction;
          JSOHist_RNUserAction := JSOCondRec.RNAction;
          { Платежи }
          cmbxJSOCndPay_Have.ItemIndex := JSOCondRec.HavePay;
          edJSOCndPay_BarCode.Text     := JSOCondRec.BarCode;
        end;
      finally
        FreeAndNil(frmCCJSO_Condition);
      end;
      if SignOkCondition then begin
        IJSOSignMassChangeCondition := 0;
        ExecConditionQRMain;
        ShowGets;
      end;
    except
      on e:Exception do begin
        ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
      end;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.JSOSaveCondition;
begin
  { Order Header }
  {==============}
  JSOCondRec.BeginDate         := dtCndBegin.Date;
  JSOCondRec.EndDate           := dtCndEnd.Date;
  JSOCondRec.SignAccountPeriod := chbxCndAccountPeriod.Checked;
  (* JSOCondRec.SOrderID { exp } <---------- *)
  (* JSOCondRec.SCity    { exp } <---------- *)
  JSOCondRec.OrderState        := cmbxCndState.ItemIndex;
  (* JSOCondRec.SignNewOrder { exp } <---------- *)
  JSOCondRec.Pharmacy             := edCndApteka.Text;
  JSOCondRec.Shipping             := edCndOrderShipping.Text;
  JSOCondRec.AllNameClient        := edCndShipName.Text;
  JSOCondRec.PhoneClient          := edCndPhone.Text;
  JSOCondRec.AdresClient          := edAptAdress.Text;
  JSOCondRec.SDispatchDeclaration := edJSOCndPay_SDispatchDeclaration.Text;
  (* JSOCondRec.SGeoGroupPharm              { ext } *)
  (* JSOCondRec.NGeoGroupPharm              { ext } *)
  (* JSOCondRec.SignGeoGroupPharmNotDefined { ext } *)
  (* JSOCondRec.SignDefinedPharm            { ext } *)
  (* JSOCondRec.SignMark                    { ext } *)
  (* JSOCondRec.NMarkOtherUser              { ext } *)
  (* JSOCondRec.SMarkOtherUser              { ext } *)
  { Headings Order }
  {================}
  (* SignTypeKeep { exp } <---------- *)
  { History }
  JSOCondRec.NameAction        := edJSOCndHist_NameOperation.Text;
  JSOCondRec.RNAction          := JSOHist_RNUserAction;
  { Pay }
  {=====}
  JSOCondRec.HavePay           := cmbxJSOCndPay_Have.ItemIndex;
  JSOCondRec.BarCode           := edJSOCndPay_BarCode.Text;
  ClearMainFilter;
end;

procedure TFCCenterJournalNetZkz.ReBuildJSOCond;
begin
  if ISign_Active = 1 then begin
    if IJSOSignMassChangeCondition = 0 then begin
      { Сохраняем значения полей условия отбора }
      JSOSaveCondition;
      { Формируем условие отбора }
      ExecConditionQRMain;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aJSOValueFieldChangeExecute(Sender: TObject);
begin
  ReBuildJSOCond;
end;

procedure TFCCenterJournalNetZkz.aMain_JRegErrorExecute(Sender: TObject);
begin
  UserActive;
  if pgcJSO_JBO.ActivePage.Name = 'tabJSO' then begin
    try
      frmCCJSO_JRegError := TfrmCCJSO_JRegError.Create(Self);
      frmCCJSO_JRegError.SetOrder(OrderHeaderDS.FieldByName('orderID').AsString);
      try
        frmCCJSO_JRegError.ShowModal;
      finally
        FreeAndNil(frmCCJSO_JRegError);
      end;
    except
      on e:Exception do begin
        ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
      end;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aMain_RP_SumArmorExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJSO_SumArmor := TfrmCCJSO_SumArmor.Create(Self);
    try
      frmCCJSO_SumArmor.ShowModal;
    finally
      FreeAndNil(frmCCJSO_SumArmor);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.JSOArmor;
var
  MsgCurrent : string;
  IGenID     : integer;
  IErr       : integer;
  SErr       : string;
begin
  if not qrMain.IsEmpty then
  begin
    MsgCurrent := 'Дата заказа: ' + AsString(OrderHeaderDS, 'OrderDt') + chr(10) +
                  'Аптека: '      + OrderHeaderDS.FieldByName('Apteka').AsString + chr(10) +
                  'Клиент: '      + OrderHeaderDS.FieldByName('orderShipName').AsString;
    MsgCurrent := 'Поставить в очередь на резервирование?' + chr(10) + MsgCurrent;
    if IsActionOrder then
        ExecHistoryOrderAction('JOPH_SetInQueue', MsgCurrent)
    else
    begin
      { Начальная инициализация действия }
      RegAction.ActionCode := 'OrderArmour';
      RegAction.Order      := OrderHeaderDS.FieldByName('orderID').AsInteger;
      RegAction.Bell       := 0;

      if MessageDLG(MsgCurrent,mtConfirmation,[mbYes,mbNo],0) = mrYes then
      begin
        dmJSO.AddOrderIntoReserveQueue(OrderHeaderDS.FieldByName('orderID').AsInteger,
          Form1.id_user,
          OrderHeaderDS.FieldByName('ExtSystem').AsInteger,
          OrderHeaderDS.FieldByName('orderPayment').AsString);
      end;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aMain_jso_ArmorCheckExecute(Sender: TObject);
begin
  UserActive;
  JSOArmor;
end;

procedure TFCCenterJournalNetZkz.aMain_jso_ArmorExecExecute(Sender: TObject);
begin
  UserActive;
  JSOArmor;
end;

procedure TFCCenterJournalNetZkz.aJSOSlave_ArmorItemExecExecute(Sender: TObject);
begin
  //
end;

procedure TFCCenterJournalNetZkz.aJSOSlave_ArmorAllExecExecute(Sender: TObject);
begin
  //
end;

procedure TFCCenterJournalNetZkz.aJSOSlave_ArmorItemCheckExecute(Sender: TObject);
begin
  //
end;

procedure TFCCenterJournalNetZkz.aJSOSlave_ArmorAllCheckExecute(Sender: TObject);
begin
  //
end;

procedure TFCCenterJournalNetZkz.aMain_jso_ArmorExecAllExecute(Sender: TObject);
var
  IGenID : integer;
begin
  UserActive;
  if MessageDLG('Подтвердите массовое Резервирование заказов ?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
    begin
      { Уникальный номер процесса }
      IGenID := GenID;
      if IGenID = 0 then exit;
      ReservingOfOrders(iif(chbxCndAccountPeriod.Checked,csUseDocPeriod,csNotUseDocPeriod),
                        csExecFull,
                        csExecNotUseCurrent,
                        0,
                        csExecShippingArmor,
                        IGenID
                       );
      GridMainRefresh;
      ShowGets;
    end;
end;

procedure TFCCenterJournalNetZkz.aMain_BalanceUserCardExecute(Sender: TObject);
begin
  //
end;

procedure TFCCenterJournalNetZkz.SetModeReserve(ModeReserve : smallint; SignUnit : smallint; Order : integer; ArtCode : integer);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  IErr := 0;
  SErr := '';
  try
    spSetModeReserve.Parameters.ParamValues['@IDENT']           := SIDENT;
    spSetModeReserve.Parameters.ParamValues['@SignModeReserve'] := ModeReserve;
    spSetModeReserve.Parameters.ParamValues['@SignUnit']        := SignUnit;
    spSetModeReserve.Parameters.ParamValues['@NUSER']           := Form1.id_user;
    spSetModeReserve.Parameters.ParamValues['@Order']           := Order;
    spSetModeReserve.Parameters.ParamValues['@ArtCode']         := ArtCode;
    spSetModeReserve.ExecProc;
    IErr := spSetModeReserve.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      SErr := spSetModeReserve.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.SetGroupModeReserve(ModeReserve : smallint; SignUnit : smallint; Order : integer);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  try
    spSetGroupModeReserve.Parameters.ParamValues['@IDENT']           := SIDENT;
    spSetGroupModeReserve.Parameters.ParamValues['@SignModeReserve'] := ModeReserve;
    spSetGroupModeReserve.Parameters.ParamValues['@SignUnit']        := SignUnit;
    spSetGroupModeReserve.Parameters.ParamValues['@NUSER']           := Form1.id_user;
    spSetGroupModeReserve.Parameters.ParamValues['@Order']           := Order;
    spSetGroupModeReserve.ExecProc;
    IErr := spSetGroupModeReserve.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      SErr := spSetGroupModeReserve.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

function TFCCenterJournalNetZkz.GetIdUserAction : longint; begin
  spGenIdUserAction.ExecProc;
  result := spGenIdUserAction.Parameters.ParamValues['@IDUserAction'];
end;

procedure TFCCenterJournalNetZkz.dsJSOPositionDistributeDataChange(Sender: TObject; Field: TField);
begin
  ShowGetsSlaveDistribute;
end;

procedure TFCCenterJournalNetZkz.DBGridSlaveDistribDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db        : TDBGrid;
  dr        : TRect;
  sr        : TRect;
  imgWidth  : integer;
  imgHeight : integer;

  procedure InnerDrawQty(AFieldName: string);
  begin
    if Column.FieldName = AFieldName then
    begin
      if db.DataSource.DataSet.FieldByName('NitemArmourQuantity').AsInteger <
         db.DataSource.DataSet.FieldByName('NitemQuantity').AsInteger then
      begin
        db.Canvas.Font.Color := TColor(clBlue);
        db.Canvas.Font.Style := [fsBold];
      end
      else
      if db.DataSource.DataSet.FieldByName('NitemArmourQuantity').AsInteger >
         db.DataSource.DataSet.FieldByName('NitemQuantity').AsInteger then
      begin
        db.Canvas.Font.Color := TColor(clRed);
        db.Canvas.Font.Style := [fsBold];
      end
    end;
  end;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if not (gdSelected in State) then begin
    { Позиция заказа, которая бронируется с использованием срокового товара }
    if db.DataSource.DataSet.FieldByName('NitemCodeTerm').AsInteger <> 0 then begin
      db.Canvas.Brush.Color := TColor($D3EFFE); { светло-коричневый }
    end;
    { Забронированные субпозиции }
    if Length(db.DataSource.DataSet.FieldByName('SArmourDate').AsString) <> 0 then begin
      (*
      db.Canvas.Brush.Color := TColor($CACACA); { Светло-серый }
      db.Canvas.Font.Color := TColor(clWindowText);
      *)
    end;
  end;
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  if OrderHeaderDS.FieldByName('ExecSign').AsInteger = 1 then
  begin
    if Column.FieldName = 'NNotArmourQty' then
    begin
      if db.DataSource.DataSet.FieldByName('NNotArmourQty').AsInteger > 0 then
      begin
        db.Canvas.Font.Color := TColor(clBlue);
        db.Canvas.Font.Style := [fsBold];
      end
      else
      if db.DataSource.DataSet.FieldByName('NNotArmourQty').AsInteger < 0 then
      begin
        db.Canvas.Font.Color := TColor(clRed);
        db.Canvas.Font.Style := [fsBold];
      end
    end;
    InnerDrawQty('NitemArmourQuantity');
    InnerDrawQty('NitemQuantity');
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  { Прорисовка img в столбце - признак резервирования }
  if Column.FieldName = 'ISIgnModeReserve' then begin
    db.Canvas.FillRect(Rect);
    Column.Title.Caption := '';
    try
      if (Column.Field.AsInteger = 1) then begin
        imgWidth  := FCCenterJournalNetZkz.imgArmor.Width;
        imgHeight := FCCenterJournalNetZkz.imgArmor.Height;
      end
      else if (Column.Field.AsInteger = 2) then begin
        imgWidth  := FCCenterJournalNetZkz.imgComeBack.Width;
        imgHeight := FCCenterJournalNetZkz.imgComeBack.Height;
      end;
      dr      := Rect;
      dr.Left := dr.Left + 2;
      {
      dr.Top  := dr.Top  + 2;
      }
      dr.Right  := dR.Left + imgWidth;
      dr.Bottom := dR.Top  + imgHeight;
      sR.Left   := 0;
      sR.Top    := 0;
      sR.Right  := imgWidth;
      sR.Bottom := imgHeight;
      if      (Column.Field.AsInteger = 1) then db.Canvas.CopyRect(dR,FCCenterJournalNetZkz.imgArmor.Canvas,sR)
      else if (Column.Field.AsInteger = 2) then db.Canvas.CopyRect(dR,FCCenterJournalNetZkz.imgComeBack.Canvas,sR);
    except
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aJSOSlave_InfoInvoiceExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJS_ComeBack := TfrmCCJS_ComeBack.Create(Self);
    if DBGridSlave.DataSource.DataSet.FieldByName('ISignDistribute').AsInteger = 1 then begin
      frmCCJS_ComeBack.SetNamePharmcy(DBGridSlaveDistrib.DataSource.DataSet.FieldByName('SApteka').AsString);
      frmCCJS_ComeBack.SetNPharmcy(DBGridSlaveDistrib.DataSource.DataSet.FieldByName('NAptekaID').AsInteger);
    end else
    if DBGridSlave.DataSource.DataSet.FieldByName('ISignDistribute').AsInteger = 0 then begin
      frmCCJS_ComeBack.SetNamePharmcy(DBGridSlave.DataSource.DataSet.FieldByName('SApteka').AsString);
      frmCCJS_ComeBack.SetNPharmcy(DBGridSlave.DataSource.DataSet.FieldByName('NApteka').AsInteger);
    end else begin
      frmCCJS_ComeBack.SetNamePharmcy('');
      frmCCJS_ComeBack.SetNPharmcy(0);
    end;
    frmCCJS_ComeBack.SetOrder(OrderHeaderDS.FieldByName('orderID').AsInteger);
    frmCCJS_ComeBack.SetClient(OrderHeaderDS.FieldByName('orderShipName').AsString);
    try
      frmCCJS_ComeBack.ShowModal;
    finally
      FreeAndNil(frmCCJS_ComeBack);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aJSOSlave_ItemReserveExecute(Sender: TObject);
begin
  UserActive;
  ExecHistoryOrderAction('OrderArmourDeliveryCourier',
    'Подтвердите выполнение операции [Резервирование (проверка) позиции заказа]',
    rtItem,
    true);
end;

procedure TFCCenterJournalNetZkz.aJSOSlave_OrderReserveExecute(Sender: TObject);
begin
  UserActive;
  ExecHistoryOrderAction('OrderArmourDeliveryCourier',
    'Подтвердите выполнение операции [Резервирование (проверка) заказа по всем позициям]',
    rtAll,
    true);
end;

procedure TFCCenterJournalNetZkz.JSOGetDriver(var SNameDriver,SDateDriver : string);
const
  MsgHeaderErr = 'Сбой при определении водителя заказа';
var
  SErr : string;
  IErr : integer;
begin
  try
    spJSOGetDriver.Parameters.ParamValues['@Order'] := OrderHeaderDS.FieldByName('orderID').AsInteger;
    spJSOGetDriver.Parameters.ParamValues['@USER']  := UserSession.CurrentUser;
    spJSOGetDriver.ExecProc;
    IErr := spJSOGetDriver.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      SNameDriver := spJSOGetDriver.Parameters.ParamValues['@SNameDriver'];
      SDateDriver := spJSOGetDriver.Parameters.ParamValues['@SDateDriver'];
    end else begin
      SErr := spJSOGetDriver.Parameters.ParamValues['@SErr'];
      ShowMessage(MsgHeaderErr+chr(10)+SErr);
    end;
  except
    on e:Exception do
      begin
        SNameDriver := '';
        SDateDriver := '';
        ShowMessage(MsgHeaderErr+chr(10)+e.Message);
      end;
  end;
end;

procedure TFCCenterJournalNetZkz.JSOAssignHeaderItem;
var
  SNameDriver, SDateDriver : string;
  vOrderHeaderAddFields:  TOrderHeaderAddFields;
begin
  { Получаем водителя заказа }
  JSOGetDriver(SNameDriver,SDateDriver);
  vOrderHeaderAddFields := dmJSO.GetOrderAddFields(OrderHeaderDS.FieldByName('orderID').AsInteger);
  { Формируем запись }
  JSOHeaderItem.orderID              := OrderHeaderDS.FieldByName('orderID').AsInteger;
  JSOHeaderItem.SorderID             := OrderHeaderDS.FieldByName('orderID').AsString;
  JSOHeaderItem.SSignBell            := OrderHeaderDS.FieldByName('SSignBell').AsString;       { Да - '' }
  JSOHeaderItem.orderAmount          := OrderHeaderDS.FieldByName('orderAmount').AsCurrency;   { Сумма заказа }
  JSOHeaderItem.NOrderAmountShipping := OrderHeaderDS.FieldByName('NOrderAmountShipping').AsCurrency;   { + Сумма }
  JSOHeaderItem.NOrderAmountCOD      := OrderHeaderDS.FieldByName('NOrderAmountCOD').AsCurrency;   { Наложенный платеж }
  JSOHeaderItem.NCoolantSum          := OrderHeaderDS.FieldByName('NCoolantSum').AsCurrency;   { Хладоген сумма }
  JSOHeaderItem.orderCurrency        := OrderHeaderDS.FieldByName('orderCurrency').AsString;   { Валюта }
  JSOHeaderItem.orderShipping        := OrderHeaderDS.FieldByName('orderShipping').AsString;   { Вид доставки }
  JSOHeaderItem.orderPayment         := OrderHeaderDS.FieldByName('orderPayment').AsString;    { Вид оплаты }
  JSOHeaderItem.orderEmail           := OrderHeaderDS.FieldByName('orderEmail').AsString;
  JSOHeaderItem.orderPhone           := OrderHeaderDS.FieldByName('orderPhone').AsString;
  JSOHeaderItem.MPhone               := OrderHeaderDS.FieldByName('MPhone').AsString;  
  JSOHeaderItem.orderShipName        := OrderHeaderDS.FieldByName('orderShipName').AsString;
  JSOHeaderItem.orderShipStreet      := OrderHeaderDS.FieldByName('orderShipStreet').AsString;
  JSOHeaderItem.SOrderDt             := AsString(OrderHeaderDS, 'OrderDt');
  JSOHeaderItem.aptekaID             := OrderHeaderDS.FieldByName('aptekaID').AsString;
  JSOHeaderItem.ID_IPA_DhRes         := OrderHeaderDS.FieldByName('ID_IPA_DhRes').AsString;
  JSOHeaderItem.IStateArmour         := OrderHeaderDS.FieldByName('IStateArmour').AsInteger;   { f_jso_GetNameStateArmor - 0 - Не забронировано, 1 - Забронировано, 2 - Частично забронировано }
  JSOHeaderItem.SCreateDate          := AsString(OrderHeaderDS, 'CreateDate');
  JSOHeaderItem.Apteka               := OrderHeaderDS.FieldByName('Apteka').AsString;
  JSOHeaderItem.NUser                := OrderHeaderDS.FieldByName('NUser').AsInteger;
  JSOHeaderItem.SUser                := OrderHeaderDS.FieldByName('SUser').AsString;
  JSOHeaderItem.SBellDate            := AsString(OrderHeaderDS, 'DBellDate');              { маркер времени звонка }
  JSOHeaderItem.SSMSDate             := AsString(OrderHeaderDS, 'DSMSDate');              { маркер времени СМС }
  JSOHeaderItem.SPayDate             := AsString(OrderHeaderDS, 'DPayDate');              { маркер времни платежа }
  JSOHeaderItem.SAssemblingDate      := AsString(OrderHeaderDS, 'DAssemblingDate');       { маркер времени сборки }
  JSOHeaderItem.DAssemblingDate      := OrderHeaderDS.FieldByName('DAssemblingDate').AsDateTime;     { маркер времени сборки }
  JSOHeaderItem.SDispatchDeclaration := OrderHeaderDS.FieldByName('SDispatchDeclaration').AsString;  { № декларации (отправка) }
  JSOHeaderItem.SDeclarationReturn   := OrderHeaderDS.FieldByName('SDeclarationReturn').AsString;    { № декларации (возврат) }
  JSOHeaderItem.SNote                := vOrderHeaderAddFields.Note;                 { примечание курьер }
  JSOHeaderItem.SCloseDate           := AsString(OrderHeaderDS, 'DCloseDate');
  JSOHeaderItem.IStateConnection     := OrderHeaderDS.FieldByName('IStateConnection').AsInteger;     { 2 - нет связи с аптекой - фиксируется при резервировании }
  JSOHeaderItem.SOrderStatus         := OrderHeaderDS.FieldByName('SOrderStatus').AsString;          { дата + статус }
  JSOHeaderItem.SOrderComment        := vOrderHeaderAddFields.Comments;         { Примечание (клиент) }
  JSOHeaderItem.SExport1CDate        := OrderHeaderDS.FieldByName('SExport1CDate').AsString;
  JSOHeaderItem.ISignNew             := OrderHeaderDS.FieldByName('ISignNew').AsInteger;             { Признак нового заказа 0 - сброшено (заказ не требует ручной обработки), 1 - новый заказа, 2 - заказ обработан }
  JSOHeaderItem.SStatusName          := OrderHeaderDS.FieldByName('SStatusName').AsString;           { Наименование статуса заказа }
  JSOHeaderItem.NGeoGroupPharm       := OrderHeaderDS.FieldByName('NGeoGroupPharm').AsInteger;
  JSOHeaderItem.SGroupPharmName      := OrderHeaderDS.FieldByName('SGroupPharmName').AsString;
  JSOHeaderItem.NMarkRN              := OrderHeaderDS.FieldByName('NMarkRN').AsInteger;              { ссылка t_jso_MyOrder }
  JSOHeaderItem.SMarkDate            := AsString(OrderHeaderDS, 'DMarkDate');
  JSOHeaderItem.NMarkUser            := OrderHeaderDS.FieldByName('NMarkUser').AsInteger;
  JSOHeaderItem.SMarkUser            := OrderHeaderDS.FieldByName('SMarkUser').AsString;
  JSOHeaderItem.SOrderShipCity       := OrderHeaderDS.FieldByName('SOrderShipCity').AsString;        { город }
  JSOHeaderItem.SOrderStatusDate     := AsString(OrderHeaderDS, 'DOrderStatusDate');
  JSOHeaderItem.SNameDriver          := SNameDriver;
  JSOHeaderItem.SDriverDate          := SDateDriver;
  JSOHeaderItem.SNPOST_StateName     := OrderHeaderDS.FieldByName('SNPOST_StateName').AsString;
  JSOHeaderItem.SNPOST_StateDate     := AsString(OrderHeaderDS, 'DNPOST_StateDate');
  JSOHeaderItem.NParentOrderID       := OrderHeaderDS.FieldByName('NParentOrderID').AsInteger;
  JSOHeaderItem.SBlackListDate       := AsString(OrderHeaderDS, 'DBlackListDate');
  JSOHeaderItem.SStockDateBegin      := AsString(OrderHeaderDS, 'DStockDateBegin');
  JSOHeaderItem.orderName            := OrderHeaderDS.FieldByName('orderName').AsString;
  JSOHeaderItem.SrcSystemName        := OrderHeaderDS.FieldByName('SrcSystemName').AsString;
  JSOHeaderItem.SrcSysPrefix         := OrderHeaderDS.FieldByName('SrcSysPrefix').AsString;
  JSOHeaderItem.ExtSysPrefix         := OrderHeaderDS.FieldByName('ExtSysPrefix').AsString;
  JSOHeaderItem.SPharmAssemblyDate   := AsString(OrderHeaderDS, 'DPharmAssemblyDate');
  JSOHeaderItem.ExecSign             := OrderHeaderDS.FieldByName('ExecSign').AsInteger;
end;

procedure TFCCenterJournalNetZkz.JSOAssignRecItem;
begin
  JSORecItem.itemID               := DBGridSlave.DataSource.DataSet.FieldByName('NRN').AsInteger;
  JSORecItem.orderID              := DBGridSlave.DataSource.DataSet.FieldByName('NPRN').AsInteger;
  JSORecItem.itemCode             := DBGridSlave.DataSource.DataSet.FieldByName('NArtCode').AsInteger;
  JSORecItem.itemName             := DBGridSlave.DataSource.DataSet.FieldByName('SArtName').AsString;
  JSORecItem.itemQuantity         := DBGridSlave.DataSource.DataSet.FieldByName('NArtCount').AsInteger;
  JSORecItem.itemPrice            := DBGridSlave.DataSource.DataSet.FieldByName('NArtPrice').AsFloat;
  JSORecItem.SArmourDate          := DBGridSlave.DataSource.DataSet.FieldByName('SArmourDate').AsString;
  JSORecItem.aptekaID             := DBGridSlave.DataSource.DataSet.FieldByName('NApteka').AsInteger;
  JSORecItem.SPharmacy            := DBGridSlave.DataSource.DataSet.FieldByName('SApteka').AsString;
  JSORecItem.ID_IPA_DhRes         := DBGridSlave.DataSource.DataSet.FieldByName('NIPA_DhRes').AsInteger;
  JSORecItem.ID_IPA_DtRes         := DBGridSlave.DataSource.DataSet.FieldByName('NIPA_DtRes').AsInteger;
  JSORecItem.SArmourDateClose     := DBGridSlave.DataSource.DataSet.FieldByName('SArmourDateClose').AsString;
  JSORecItem.SCheckDate           := DBGridSlave.DataSource.DataSet.FieldByName('SCheckDate').AsString;
  JSORecItem.itemCountInPresence  := DBGridSlave.DataSource.DataSet.FieldByName('NIPA_ArtPresenceCount').AsFloat;
  JSORecItem.TypeNote             := DBGridSlave.DataSource.DataSet.FieldByName('ITypeNote').AsInteger;
  JSORecItem.SCheckNote           := DBGridSlave.DataSource.DataSet.FieldByName('SCheckNote').AsString;
  JSORecItem.PricePharmacy        := DBGridSlave.DataSource.DataSet.FieldByName('NPricePharmacy').AsFloat;
  JSORecItem.Koef_Opt             := DBGridSlave.DataSource.DataSet.FieldByName('NKoef_Opt').AsInteger;
  JSORecItem.CalcPriceWithKoef    := DBGridSlave.DataSource.DataSet.FieldByName('NCalcPriceWithKoef').AsFloat;
  JSORecItem.NUSER                := DBGridSlave.DataSource.DataSet.FieldByName('NUser').AsInteger;
  JSORecItem.SUSER                := DBGridSlave.DataSource.DataSet.FieldByName('SUser').AsString;
  JSORecItem.SignDistribute       := DBGridSlave.DataSource.DataSet.FieldByName('ISignDistribute').AsInteger;
  JSORecItem.SignArmorTerm        := DBGridSlave.DataSource.DataSet.FieldByName('ISignArmorTerm').AsInteger;
  JSORecItem.SignDivideParts      := DBGridSlave.DataSource.DataSet.FieldByName('ISignDivideParts').AsInteger;
  JSORecItem.itemRemnTerm         := DBGridSlave.DataSource.DataSet.FieldByName('NitemRemnTerm').AsInteger;
  JSORecItem.StateArmour          := DBGridSlave.DataSource.DataSet.FieldByName('IStateArmour').AsInteger;
  JSORecItem.SignMeas             := DBGridSlave.DataSource.DataSet.FieldByName('ISignMeas').AsInteger;
  JSORecItem.SNameMeas            := DBGridSlave.DataSource.DataSet.FieldByName('SSignMeas').AsString;
  JSORecItem.SignModeReserve      := DBGridSlave.DataSource.DataSet.FieldByName('ISIgnModeReserve').AsInteger;
  JSORecItem.ID_IPA_JMoves        := DBGridSlave.DataSource.DataSet.FieldByName('NIPA_JMoves').AsInteger;
  JSORecItem.ID_IPA_rTovar        := DBGridSlave.DataSource.DataSet.FieldByName('NIPA_rTovar').AsInteger;
  JSORecItem.STypeTable           := DBGridSlave.DataSource.DataSet.FieldByName('STypeTable').AsString;
end;

procedure TFCCenterJournalNetZkz.aJSOSlave_NewItemExecute(Sender: TObject);
begin
  UserActive;
  ExecHistoryOrderAction('JSO_AddItemCodeCard',
    '',
    rtNone);
end;

procedure TFCCenterJournalNetZkz.aJSOSlave_UpdItemExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  SErr := '';
  UserActive;
  if Self.IsActionOrder then
  begin
    //Если статус позволяет редактирование и нет незавершенных действий открываем в режиме редактирования,
    //иначе открываем в режиме просмотра
    if CanEditOrder('JSO_UpdItemSpec', SErr) then
      ExecHistoryOrderAction('JSO_UpdItemSpec',
        '',
        rtNone)
    else
    begin
      JSOAssignHeaderItem;
      JSOAssignRecItem;
      frmCCJS_ItemCard := TfrmCCJS_ItemCard.Create(Self);
      try
        frmCCJS_ItemCard.SetRecSession(UserSession);
        frmCCJS_ItemCard.SetRecItem(JSORecItem);
        frmCCJS_ItemCard.SetUser(Form1.id_user);
        frmCCJS_ItemCard.SetOrderShipping(OrderHeaderDS.FieldByName('orderShipping').AsString);
        frmCCJS_ItemCard.SetClient(OrderHeaderDS.FieldByName('orderShipName').AsString);
        frmCCJS_ItemCard.SetRecJSOHeader(JSOHeaderItem);
        frmCCJS_ItemCard.SetModeAction(cJSOItemCard_Read);
        if SErr <> '' then
          frmCCJS_ItemCard.ExtComments := SErr + ' Возможен только ПРОСМОТР.';
        frmCCJS_ItemCard.ShowModal;
      finally
        FreeAndNil(frmCCJS_ItemCard);
      end;
    end;
  end
  else
  begin
    { Начальная инициализация действия }
    RegAction.ActionCode := 'JSO_WriteItemCodeCard';
    RegAction.Order      := OrderHeaderDS.FieldByName('orderID').AsInteger;
    RegAction.Bell       := 0;
    { Проверяем состояние действия }
    RegActionState(IErr,SErr);
    if IErr = 0 then begin
      { Если открытое действие не зарегистрировано, то выполняем действие }
      if RegAction.State = 0 then begin
        { Регистрируем действие пользователя }
        RegActionOpen(IErr,SErr);
        if IErr = 0 then begin
          try
            JSOAssignHeaderItem;
            JSOAssignRecItem;
            frmCCJS_ItemCard := TfrmCCJS_ItemCard.Create(Self);
            frmCCJS_ItemCard.SetRecSession(UserSession);
            frmCCJS_ItemCard.SetRecItem(JSORecItem);
            frmCCJS_ItemCard.SetUser(Form1.id_user);
            frmCCJS_ItemCard.SetOrderShipping(OrderHeaderDS.FieldByName('orderShipping').AsString);
            frmCCJS_ItemCard.SetClient(OrderHeaderDS.FieldByName('orderShipName').AsString);
            frmCCJS_ItemCard.SetRecJSOHeader(JSOHeaderItem);
            { Не забронировано и заказ открыт - включаем режим исправления}
            if    (not VarIsAssigned(OrderHeaderDS.FieldByName('DCloseDate').Value))
              and (
                       (JSORecItem.ID_IPA_DhRes = 0)
                   and (JSORecItem.ID_IPA_DtRes = 0)
                   and (JSORecItem.ID_IPA_JMoves = 0)
                   and (JSORecItem.ID_IPA_rTovar = 0)
                   )
              and (JSORecItem.SignDistribute = 0)
              and (JSORecItem.SignArmorTerm = 0)
            then frmCCJS_ItemCard.SetModeAction(cJSOItemCard_Upd);
            try
              frmCCJS_ItemCard.ShowModal;
              RegActionClose;
              JSOSetOrderProcessed(RegAction.Order,RegAction.NUSER);
              GridSlaveRefresh;
              GridMainRefresh;
            finally
              FreeAndNil(frmCCJS_ItemCard);
              RegActionClose;
              JSOSetOrderProcessed(RegAction.Order,RegAction.NUSER);
            end;
          except
            on e:Exception do begin
              ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
            end;
          end;
          GridSlaveRefresh;
        end else begin
          ShowMessage('IErr = ' + VarToStr(IErr) + chr(10) + SErr);
        end;
      end else begin
        ShowMessage('Операция запрещена.' + chr(10) +
                    'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                    'Дата начала операции: ' + RegAction.SBeginDate
                   );
      end;
    end else ShowMessage(SErr);
  end;
end;

procedure TFCCenterJournalNetZkz.aJSOSlave_DelItemExecute(Sender: TObject);
begin
  UserActive;
  ExecHistoryOrderAction('JSO_DelItemCodeCard',
    '',
    rtNone);
end;

procedure TFCCenterJournalNetZkz.aJSOSlave_ItemRemainsExecute(Sender: TObject);
var
  IErr      : integer;
  ErrMsg    : string;
  Ostatok   : integer;
  ResCount  : integer;
  ItemPrice : real;
  NAptekaID : integer;
  SApteka   : string;
  SItemName : string;
begin
  UserActive;
  { Вытаскиваем код аптеки }
  if OrderHeaderDS.FieldByName('aptekaID').AsInteger = 0 then begin
    { Смотрим аптеку в позиции заказа }
    NAptekaID := DBGridSlave.DataSource.DataSet.FieldByName('NApteka').AsInteger;
    if NAptekaID <> 0 then begin
      SApteka   := DBGridSlave.DataSource.DataSet.FieldByName('SApteka').AsString;
    end else begin
      ShowMessage('В выбранной позиции заказа аптека не определена');
      ShowGets;
      exit;
    end;
  end else begin
    { Смотрим аптеку в заголовке заказа }
    NAptekaID := OrderHeaderDS.FieldByName('aptekaID').AsInteger;
    SApteka   := OrderHeaderDS.FieldByName('apteka').AsString;
  end;
  SItemName := DBGridSlave.DataSource.DataSet.FieldByName('SArtName').AsString;
  { Проверяем наличие }
  dmJSO.ShowGoodsPharmState(DBGridSlave.DataSource.DataSet.FieldByName('NArtCode').AsInteger,
    NAptekaID,
    'Наличие <' + SItemName + '> в аптеке <' + SApteka + '>'
  );
  ShowGets;
end;

procedure TFCCenterJournalNetZkz.aJSOSlave_OrderRemainsExecute(Sender: TObject);
begin
  UserActive;
end;

procedure TFCCenterJournalNetZkz.aJSOSlave_SubItemReserveExecute(Sender: TObject);
begin
  UserActive;
  ExecHistoryOrderAction('OrderArmourDeliveryCourier',
    'Подтвердите выполнение операции [Резервирование (проверка) субпозиции заказа]',
    rtSubItem,
    true);
end;

procedure TFCCenterJournalNetZkz.aMain_RP_StateOpenOrderExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJS_RP_StateOpenOrder := TfrmCCJS_RP_StateOpenOrder.Create(Self);
    try
      frmCCJS_RP_StateOpenOrder.ShowModal;
    finally
      FreeAndNil(frmCCJS_RP_StateOpenOrder);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aJRMOMain_StatusExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  if pgcJSO_JBO.ActivePage.Name = 'tabJRMO' then begin
    IErr := 0;
    SErr := '';
    { Начальная инициализация действия }
    RegAction.ActionCode := 'JRMO_State';
    RegAction.Order      := JRMOGridMain.DataSource.DataSet.FieldByName('NorderID').AsInteger;
    RegAction.Bell       := 0;
    { Проверяем состояние действия }
    JRMORegActionState(IErr,SErr);
    if IErr = 0 then begin
      { Если открытое действие не зарегистрировано, то выполняем действие }
      if RegAction.State = 0 then begin
        { Регистрируем действие пользователя }
        JRMORegActionOpen(IErr,SErr);
        if IErr = 0 then begin
          try
            frmCCJRMO_Status := TfrmCCJRMO_Status.Create(Self);
            frmCCJRMO_Status.SetCodeAction(RegAction.ActionCode);
            frmCCJRMO_Status.SetRN(RegAction.Order);
            frmCCJRMO_Status.SetPrice(JRMOGridMain.DataSource.DataSet.FieldByName('NItemPrice').AsFloat);
            frmCCJRMO_Status.SetClient(JRMOGridMain.DataSource.DataSet.FieldByName('SOrderShipName').AsString);
            frmCCJRMO_Status.SetUser(RegAction.NUSER);
            frmCCJRMO_Status.SetNote(JRMOGridMain.DataSource.DataSet.FieldByName('SNote').AsString);
            frmCCJRMO_Status.SetRNHist(RegAction.RN);
            try
              frmCCJRMO_Status.ShowModal;
            finally
              FreeAndNil(frmCCJRMO_Status);
              JRMORegActionClose;
            end;
          except
            on e:Exception do begin
              ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
              JRMORegActionClose;
            end;
          end;
        end else begin
          ShowMessage('IErr = ' + VarToStr(IErr) + chr(10) + SErr);
        end;
      end else begin
        ShowMessage('Операция запрещена.' + chr(10) +
                    'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                    'Дата начала операции: ' + RegAction.SBeginDate
                   );
      end;
    end else ShowMessage(SErr);
    JRMOGridMainRefresh;
    JRMOShowGets;
  end;
end;

//выполнение действия с записью в историю
procedure TFCCenterJournalNetZkz.DefPrepareAction(var AParams: TActionParams);
begin
  AParams.OrderId := RegAction.Order;
  AParams.UserId := Form1.id_user;
  AParams.ProcessId := null;
  AParams.TradePointId := null;
end;

procedure TFCCenterJournalNetZkz.DoAction(AActionCode: string;
  ActionExecuteMethod: TActionMethod; ActionPrepareMethod: TActionPrepareMethod;
  AfterActionExecute: TActionMethod);
var
  IErr       : integer;
  SErr       : string;
  DS: TDataSet;
  vParams: TActionParams;
begin
  if Assigned(ActionExecuteMethod) and (not qrMain.IsEmpty) then
  begin
    DS := OrderHeaderDS;

    { Начальная инициализация действия }
    RegAction.ActionCode :=  AActionCode;
    RegAction.Order      := DS.FieldByName('orderID').AsInteger;
    RegAction.Bell       := 0;

    if not Assigned(ActionPrepareMethod) or ActionPrepareMethod(vParams) then
    begin
      { Проверяем состояние действия }
      RegActionState(IErr,SErr);
      if IErr = 0 then
      begin
        { Если открытое действие не зарегистрировано, то выполняем действие }
        if RegAction.State = 0 then
        begin
          { Регистрируем действие пользователя }
          RegActionOpen(IErr,SErr);
          if IErr = 0 then
          begin
            try
              ActionExecuteMethod(vParams, IErr, SErr);
              if IErr <> 0 then
                ShowMessage(SErr);
            except
              on e:Exception do
              begin
                ShowMessage('Сбой при выполнении операции. Попробуйте еще раз' +
                              chr(10) + e.Message
                            );
              end;
            end;
            RegActionClose;
            if Assigned(AfterActionExecute) then
              AfterActionExecute(vParams, IErr, SErr);
          end
          else
          begin
            ShowMessage('IErr = ' + VarToStr(IErr) + chr(10) + SErr);
          end;
        end
        else
        begin
          ShowMessage('Операция запрещена.' + chr(10) +
                      'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                      'Дата начала операции: ' + RegAction.SBeginDate
                     );
        end;
      end else ShowMessage(SErr);
    end;

  end;
end;

procedure TFCCenterJournalNetZkz.JSO_ActionExecute(AStoredProcName: string;
  AParams: TActionParams; var IErr: Integer; var SErr: string);
var
  vProc: TADOStoredProc;
begin
  vProc := TADOStoredProc.Create(nil);
  try
    vProc.Connection := Form1.ADOC_STAT;
    vProc.Name := 'spDoAction';
    vProc.ProcedureName := AStoredProcName;
    vProc.Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, 0, 0);
    vProc.Parameters.CreateParameter('@UserId', ftInteger, pdInput, 0, AParams.UserId); //(-1)*Form1.id_user
    vProc.Parameters.CreateParameter('@ProcessId', ftInteger, pdInput, 0, AParams.ProcessId);
    vProc.Parameters.CreateParameter('@OrderId', ftInteger, pdInput, 0, AParams.OrderId);
    vProc.Parameters.CreateParameter('@AptekaId', ftInteger, pdInput, 0, AParams.TradePointId);
    vProc.Parameters.CreateParameter('@ErrMsg', ftString, pdReturnValue, 1000, null);
    vProc.ExecProc;
    IErr := vProc.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then
      SErr := vProc.Parameters.ParamValues['@ErrMsg'];
    {IErr := -1;
    SErr := 'Тестирование диалога';}
  finally
    vProc.Free;
  end;
end;

function TFCCenterJournalNetZkz.JSO_Prepare_WholeOrderOrTPoint_Action(DlgCaption: string;
  var AParams: TActionParams): Boolean;
var
  vParams: TWholeOrderOrTPointParams;
begin
  Self.DefPrepareAction(AParams);
  vParams.OrderId := AParams.OrderId;
  vParams.Caption := DlgCaption;
  Result := TWholeOrderOrTradePointDlg.Execute(vParams);
  if Result then
    AParams.TradePointId := vParams.TradePointId;
end;

//Снятие брони
procedure TFCCenterJournalNetZkz.JSO_CloseArmorExecute(AParams: TActionParams; var IErr: Integer; var SErr: string);
begin
  JSO_ActionExecute('p_jso_CloseOrderReserve', AParams, IErr, SErr);
end;

function TFCCenterJournalNetZkz.JSO_PrepareCloseArmor(var AParams: TActionParams): Boolean;
begin
  Result := JSO_Prepare_WholeOrderOrTPoint_Action('Отменить/закрыть бронь', AParams);
end;

procedure TFCCenterJournalNetZkz.JSO_AfterSlaveActionExecute(AParams: TActionParams; var IErr: Integer; var SErr: string);
begin
  GridSlaveRefresh;
  GridMainRefresh;
end;

procedure TFCCenterJournalNetZkz.aJSOSlave_CloseArmorExecute(Sender: TObject);
begin
  if IsActionOrder then
    ExecHistoryOrderAction('JSO_CloseOrderReserve',
      '')
  else
    Self.DoAction('JSO_CloseOrderReserve', JSO_CloseArmorExecute, JSO_PrepareCloseArmor, JSO_AfterSlaveActionExecute);
end;

//очистка позиций (очистка признаков бронирования)
procedure TFCCenterJournalNetZkz.JSO_ClearArmorExecute(AParams: TActionParams; var IErr: Integer; var SErr: string);
begin
  JSO_ActionExecute('p_jso_ClearOrderReserve', AParams, IErr, SErr);
end;

function TFCCenterJournalNetZkz.JSO_PrepareClearArmor(var AParams: TActionParams): Boolean;
begin
  Result := JSO_Prepare_WholeOrderOrTPoint_Action('Очистить позиции', AParams);
end;

procedure TFCCenterJournalNetZkz.aJSOSlave_ClearArmorExecute(Sender: TObject);
begin
  if IsActionOrder then
    ExecHistoryOrderAction('JSO_ClearOrderReserve',
    '')
  else
    Self.DoAction('JSO_ClearOrderReserve', JSO_ClearArmorExecute, JSO_PrepareClearArmor, JSO_AfterSlaveActionExecute);
end;

//------------------------------------------------------
procedure TFCCenterJournalNetZkz.aJRMOMain_RP_OrderExecute(Sender: TObject);
var
  vExcel               : OleVariant;
  vDD                  : OleVariant;
  WS                   : OleVariant;
  I                    : integer;
  iExcelNumLine        : integer;
  fl_cnt               : integer;
  num_cnt              : integer;
  iInteriorColor       : integer;
  iHorizontalAlignment : integer;
  SFontSize            : string;
  { Вывод поля заказа }
  procedure ExcelFiledOrder(HeaderField : string; NameField : string); begin
    vExcel.ActiveCell[iExcelNumLine, 1].Value := HeaderField;
    SetPropExcelCell(WS, 1, iExcelNumLine, 0, xlLeft);
    vExcel.Cells[iExcelNumLine, 1].Font.Size := SFontSize;
    vExcel.ActiveCell[iExcelNumLine, 2].Value := JRMOGridMain.DataSource.DataSet.FieldByName(NameField).AsString;
    SetPropExcelCell(WS, 2, iExcelNumLine, 0, xlLeft);
    vExcel.Cells[iExcelNumLine, 2].Font.Size := SFontSize;
  end;
begin
  UserActive;
  SFontSize := '10';
  try
    { Запуск табличного процессора... }
    vExcel := CreateOLEObject('Excel.Application');
    vDD := vExcel.Workbooks.Add;
    WS := vDD.Sheets[1];
    { Формируем отчетик }
    iExcelNumLine := 1;
    { Заголовок }
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Заказ редких лекарств';
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Дата формирования: ' + FormatDateTime('dd-mm-yyyy hh:nn:ss', Now);
    inc(iExcelNumLine);
    { Данные }
    inc(iExcelNumLine); ExcelFiledOrder('Номер','NOrderID');
    inc(iExcelNumLine); ExcelFiledOrder('Дата','SOrderDT');
    inc(iExcelNumLine); ExcelFiledOrder('Код','SItemCode');
    inc(iExcelNumLine); ExcelFiledOrder('Наименование','SItemName');
    inc(iExcelNumLine); ExcelFiledOrder('Цена','NItemPrice');
    inc(iExcelNumLine); ExcelFiledOrder('Клиент','SOrderShipName');
    inc(iExcelNumLine); ExcelFiledOrder('Телефон','SOrderPhone');
    inc(iExcelNumLine); ExcelFiledOrder('Примечание','SOrderComment');
    inc(iExcelNumLine); ExcelFiledOrder('EMail','SOrderEMail');
    { Ширина столбцов }
    vExcel.Columns[01].ColumnWidth := 20;
    vExcel.Columns[02].ColumnWidth := 50;
    { Включаем перенос слов }
    { Перенос слов }
    WS.Range[CellName(01,04) + ':' + CellName(02,iExcelNumLine)].WrapText:=true;
    { Показываем }
    vExcel.Visible := True;
  except
    on E: Exception do begin
      if vExcel = varDispatch then vExcel.Quit;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.JSOGridPayDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
    if db.DataSource.DataSet.FieldByName('TypeRecPay').AsString = cJSOPayTypeUnion_Link then begin
      if db.Focused then begin
        db.Canvas.Font.Color := clSilver
      end else begin
        db.Canvas.Font.Color := clGray;
      end;
    end;
  end else begin
    if db.DataSource.DataSet.FieldByName('TypeRecPay').AsString = cJSOPayTypeUnion_Link then begin
      db.Canvas.Font.Color := clBlue;
    end;
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFCCenterJournalNetZkz.aMain_RP_PayExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJS_RP_Pay := TfrmCCJS_RP_Pay.Create(Self);
    try
      frmCCJS_RP_Pay.ShowModal;
    finally
      FreeAndNil(frmCCJS_RP_Pay);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aMain_RP_JEMailBadArmorExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJS_RP_JEMailBadArmor := TfrmCCJS_RP_JEMailBadArmor.Create(Self);
    try
      frmCCJS_RP_JEMailBadArmor.ShowModal;
    finally
      FreeAndNil(frmCCJS_RP_JEMailBadArmor);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.tmrJournalAlertTimer(Sender: TObject);
var
  PAlertWOptions     : PAlertPopupWindowOptions;
  AWOptions          : TAlertPopupWindowOptions;
  WColor             : TColor;
  CodeAlertType      : string;
  NAlertType         : integer;
  ISignErrAlertType  : boolean;
  AlertCount         : integer;
  {--}
  procedure SetOptions; begin
    new(PAlertWOptions);
    PAlertWOptions.NRN_AlertUser := AWOptions.NRN_AlertUser;
    PAlertWOptions.Enumereator   := AWOptions.Enumereator;
    PAlertWOptions.EventTime     := AWOptions.EventTime;
    PAlertWOptions.EventType     := AWOptions.EventType;
    PAlertWOptions.WShowMetod    := TAlertWindowShowMethod(random(3));
    PAlertWOptions.WFadeMetod    := TAlertWindowFadeMethod(random(4));
    PAlertWOptions.WColor        := AWOptions.WColor;
    PAlertWOptions.TextColor     := clBlack;
    PAlertWOptions.AlertMessage  := AWOptions.AlertMessage;
    PAlertWOptions.AlertType     := AWOptions.AlertType;
    PAlertWOptions.AlertUser     := AWOptions.AlertUser;
    PAlertWOptions.AlertTypeUser := AWOptions.AlertTypeUser;
    PAlertWOptions.IconIndex     := AWOptions.IconIndex;
  end; { procedure SetOptions }
begin
  tmrJournalAlert.Enabled := false;
  try
    if IEnabledalertWindow then begin
      if spDSJournalAlert.Active then spDSJournalAlert.Active := false;
      spDSJournalAlert.Parameters.ParamValues['@USER']                := RegAction.NUSER;
      spDSJournalAlert.Parameters.ParamValues['@AlertBegin']          := FormatDateTime('yyyy-mm-dd', now());
      spDSJournalAlert.Parameters.ParamValues['@AlertEnd']            := FormatDateTime('yyyy-mm-dd', IncDay(now(),1));
      spDSJournalAlert.Parameters.ParamValues['@SignNotRead']         := 1;
      spDSJournalAlert.Parameters.ParamValues['@SignCheckEnumerator'] := 0;
      spDSJournalAlert.Parameters.ParamValues['@SignCheckExec']       := 1;
      spDSJournalAlert.Parameters.ParamValues['@AlertType']       := 0;
      spDSJournalAlert.Parameters.ParamValues['@IP']       := Self.FIp;
      spDSJournalAlert.Parameters.ParamValues['@CompName'] := Self.FCompName;
      spDSJournalAlert.Open;
      AlertCount := spDSJournalAlert.RecordCount;
      if (AlertCount > 0) and (not Application.Active) then FlashWindow(Application.Handle, True);
      AlertPanel.APList_FreePAOptions;
      spDSJournalAlert.First;
      while not spDSJournalAlert.Eof do begin
        ISignErrAlertType := false;
        AWOptions.EventTime     := spDSJournalAlert.FieldByName('DAlertDate').AsDateTime;
        AWOptions.AlertMessage  := spDSJournalAlert.FieldByName('SContents').AsString;
        AWOptions.AlertType     := spDSJournalAlert.FieldByName('SNameAlertType').AsString;
        AWOptions.NRN_AlertUser := spDSJournalAlert.FieldByName('NRN_AlertUser').AsInteger;
        AWOptions.Enumereator   := spDSJournalAlert.FieldByName('IEnumerator').AsInteger;
        AWOptions.Content       := spDSJournalAlert.FieldByName('SJList').AsString;
        AWOptions.AlertUser     := '';
        AWOptions.AlertTypeUser := '';
        CodeAlertType := spDSJournalAlert.FieldByName('SCodeAlertType').AsString;
        NAlertType    := spDSJournalAlert.FieldByName('NAlertType').AsInteger;
        if (CodeAlertType = 'FeedBack') and GetAccessUserAlertType(NAlertType) then begin
          AWOptions.EventType := awetFeedBack;
          AWOptions.WColor    := TColor($0EEFEF);
          AWOptions.IconIndex := cImgMain_FeedBack;
        end else
        if (CodeAlertType = 'RareMedication') and GetAccessUserAlertType(NAlertType) then begin
          AWOptions.EventType := awetRMedication;
          AWOptions.WColor    := TColor($0EEFEF);
          AWOptions.IconIndex := cImgMain_RareMedication;
        end else
        if (CodeAlertType = 'MissedCall') and GetAccessUserAlertType(NAlertType) then begin
          AWOptions.EventType := awetMissedCall;
          AWOptions.WColor    := TColor($0EEFEF);
          AWOptions.IconIndex := cImgMain_MissedCall;
        end else
        if (CodeAlertType = 'NewPay') and GetAccessUserAlertType(NAlertType) then begin
          AWOptions.EventType := awetPay;
          AWOptions.WColor    := clLime;
          AWOptions.IconIndex := cImgMain_NewPay;
        end else
        if (CodeAlertType = 'NewCheckoutCheck') and GetAccessUserAlertType(NAlertType) then begin
          AWOptions.EventType := awetPayCheck;
          AWOptions.WColor    := clLime;
          AWOptions.IconIndex := cImgMain_NewCheckoutCheck;
        end else
        if (CodeAlertType = 'User') and GetAccessUserAlertType(NAlertType) then begin
          AWOptions.EventType     := awetUser;
          AWOptions.WColor        := clAqua;
          AWOptions.IconIndex     := cImgMain_User;
          AWOptions.AlertUser     := spDSJournalAlert.FieldByName('SFromWhom').AsString;
          AWOptions.AlertTypeUser := spDSJournalAlert.FieldByName('SAlertUserType').AsString;
        end else
        if (CodeAlertType = 'Call') then begin
          AWOptions.EventType := awetCall;
          AWOptions.WColor    := clSkyBlue;
          AWOptions.IconIndex := cImgMain_Call;
        end else
        if (CodeAlertType = 'Error') and GetAccessUserAlertType(NAlertType) then begin
          AWOptions.EventType := awetError;
          AWOptions.WColor    := TColor($8080FF);
          AWOptions.IconIndex := cImgMain_Error;
        end else
        if (CodeAlertType = 'Pharmacy') and GetAccessUserAlertType(NAlertType) then begin
          AWOptions.EventType := awetPharmacy;
          AWOptions.WColor    := TColor($D8FFB0);
          AWOptions.IconIndex := cImgMain_Pharmacy;
        end else
        if (CodeAlertType = 'NewPost') and GetAccessUserAlertType(NAlertType) then begin
          AWOptions.EventType := awetNewPost;
          AWOptions.WColor    := TColor($FFBFFF);
          AWOptions.IconIndex := cImgMain_NewPost;
        end else
        if (CodeAlertType = 'FeedBackOld') and GetAccessUserAlertType(NAlertType) then begin
          AWOptions.EventType := awetFeedBack;
          AWOptions.WColor    := TColor($0EEFEF);
          AWOptions.IconIndex := cImgMain_FeedBackOld;
        end else ISignErrAlertType := true;
        if not ISignErrAlertType then begin
          if (CodeAlertType = 'Call') or Application.Active then begin
            if spDSJournalAlert.FieldByName('IEnumerator').AsInteger < spDSJournalAlert.FieldByName('IShowNumber').AsInteger then begin
              { Формируем параметры всплывающего окна }
              SetOptions;
              { Сообщение на запуск всплывающего окна оповещения }
              SendMessage(self.Handle,WM_AlertEvent,integer(AWOptions.EventType), integer(PAlertWOptions));
              Application.ProcessMessages;
            end;
          end;
          { Формируем список панелей оповещения }
          SetOptions;
          AlertPanel.RegisterPanel(PAlertWOptions);
        end;
        spDSJournalAlert.Next;
      end; { while not spDSJournalAlert.Eof do }
      { Принимаем решение по отображению боковой панели центра уведомлений }
      if (not Application.Active) then
        if (AlertPanel.APList.Count > 0) then begin
          if (ControlPanelSide.ISignActiveNtfCenter = 0) then ShowPanelSide(cPnlSide_NtfCenter);
        end else begin
          if (ControlPanelSide.ISignActiveNtfCenter = 1) then ShowPanelSide(cPnlSide_NtfCenter);
        end;
      AlertPanel.ShowPanels;
    end; { if IEnabledalertWindow then }
  except
    on e:Exception do
      begin
      end;
  end;
  tmrJournalAlert.Enabled := true;
end;

procedure TFCCenterJournalNetZkz.aMain_GroupPharmExecute(Sender: TObject);
var
  DescrSelect : string;
  IErr        : integer;
  SErr        : string;
begin
  UserActive;
  if pgcJSO_JBO.ActivePage.Name = 'tabJSO' then begin
    IErr := 0;
    SErr := '';
    try
      frmReference := TfrmReference.Create(Self);
      frmReference.SetMode(cFReferenceModeSelect);
      frmReference.SetReferenceIndex(cFDicGroupPharm);
      frmReference.SetOrderShipping('');
      try
        frmReference.ShowModal;
        DescrSelect := frmReference.GetDescrSelect;
        if length(DescrSelect) > 0 then begin
          try
            spSetGeoGroupParm.Parameters.ParamValues['@Order'] := OrderHeaderDS.FieldByName('orderID').AsInteger;
            spSetGeoGroupParm.Parameters.ParamValues['@GeoGroupPharm'] := DescrSelect;
            spSetGeoGroupParm.Parameters.ParamValues['@ActionCode'] := 'JSO_SetGeoGroupPharmacy';
            spSetGeoGroupParm.Parameters.ParamValues['@USER'] := Form1.id_user;
            spSetGeoGroupParm.ExecProc;
            IErr := spSetGeoGroupParm.Parameters.ParamValues['@RETURN_VALUE'];
            if IErr <> 0 then begin
              SErr := spSetGeoGroupParm.Parameters.ParamValues['@SErr'];
              ShowMessage(SErr);
            end;
          except
            on e:Exception do begin
              ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
            end;
          end;
        end;
      finally
        FreeAndNil(frmReference);
      end;
    except
    end;
    GridMainRefresh;
  end;
end;

procedure TFCCenterJournalNetZkz.aMain_RP_CourierExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJS_RP_Courier := TfrmCCJS_RP_Courier.Create(Self);
    try
      frmCCJS_RP_Courier.ShowModal;
    finally
      FreeAndNil(frmCCJS_RP_Courier);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.dsJSOPayDataChange(Sender: TObject; Field: TField);
begin
  if aJSOPay_ShowCheck.Checked then ExecConditionJSOCheck;
end;

procedure TFCCenterJournalNetZkz.gridSlave_CheckDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFCCenterJournalNetZkz.aJSOPay_AddExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  { Начальная инициализация действия }
  RegAction.ActionCode := 'JSO_Pay_Insert';
  RegAction.Order      := OrderHeaderDS.FieldByName('orderID').AsInteger;
  RegAction.Bell       := 0;
  { Проверяем состояние действия }
  RegActionState(IErr,SErr);
  if IErr = 0 then begin
    { Если открытое действие не зарегистрировано, то выполняем действие }
    if RegAction.State = 0 then begin
      { Регистрируем действие пользователя }
      RegActionOpen(IErr,SErr);
      if IErr = 0 then begin
        try
          frmCCJS_Pay := TfrmCCJS_Pay.Create(Self);
          frmCCJS_Pay.SetMode(cFJSOPayModeAdd);
          frmCCJS_Pay.SetAction(RegAction.ActionCode);
          frmCCJS_Pay.SetOrder(RegAction.Order);
          frmCCJS_Pay.SetUSER(RegAction.NUSER);
          frmCCJS_Pay.SetNHistory(RegAction.RN);
          try
            frmCCJS_Pay.ShowModal;
          finally
            FreeAndNil(frmCCJS_Pay);
            RegActionClose;
            ExecConditionJSOPay;
            ShowGets;
          end;
        except
          on e:Exception do begin
            ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
            RegActionClose;
            ExecConditionJSOPay;
            ShowGets;
          end;
        end;
      end else begin
        ShowMessage('IErr = ' + VarToStr(IErr) + chr(10) + SErr);
      end;
    end else begin
      ShowMessage('Операция запрещена.' + chr(10) +
                  'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                  'Дата начала операции: ' + RegAction.SBeginDate
                 );
    end;
  end else ShowMessage(SErr);
end;

procedure TFCCenterJournalNetZkz.aJSOPay_EditExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  { Начальная инициализация действия }
  RegAction.ActionCode := 'JSO_Pay_Update';
  RegAction.Order      := OrderHeaderDS.FieldByName('orderID').AsInteger;
  RegAction.Bell       := 0;
  { Проверяем состояние действия }
  RegActionState(IErr,SErr);
  if IErr = 0 then begin
    { Если открытое действие не зарегистрировано, то выполняем действие }
    if RegAction.State = 0 then begin
      { Регистрируем действие пользователя }
      RegActionOpen(IErr,SErr);
      if IErr = 0 then begin
        try
          frmCCJS_Pay := TfrmCCJS_Pay.Create(Self);
          frmCCJS_Pay.SetMode(cFJSOPayModeUpd);
          frmCCJS_Pay.SetAction(RegAction.ActionCode);
          frmCCJS_Pay.SetOrder(RegAction.Order);
          frmCCJS_Pay.SetUSER(RegAction.NUSER);
          frmCCJS_Pay.SetNHistory(RegAction.RN);
          JSOSetRecPay;
          frmCCJS_Pay.SetRecPay(JSORecPay);
          try
            frmCCJS_Pay.ShowModal;
          finally
            FreeAndNil(frmCCJS_Pay);
            RegActionClose;
            ExecConditionJSOPay;
            ShowGets;
          end;
        except
          on e:Exception do begin
            ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
            RegActionClose;
            ExecConditionJSOPay;
            ShowGets;
          end;
        end;
      end else begin
        ShowMessage('IErr = ' + VarToStr(IErr) + chr(10) + SErr);
      end;
    end else begin
      ShowMessage('Операция запрещена.' + chr(10) +
                  'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                  'Дата начала операции: ' + RegAction.SBeginDate
                 );
    end;
  end else ShowMessage(SErr);
end;

procedure TFCCenterJournalNetZkz.aJSOPay_DelExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  if MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  { Начальная инициализация действия }
  RegAction.ActionCode := 'JSO_Pay_Delete';
  RegAction.Order      := OrderHeaderDS.FieldByName('orderID').AsInteger;
  RegAction.Bell       := 0;
  { Проверяем состояние действия }
  RegActionState(IErr,SErr);
  if IErr = 0 then begin
    { Если открытое действие не зарегистрировано, то выполняем действие }
    if RegAction.State = 0 then begin
      { Регистрируем действие пользователя }
      RegActionOpen(IErr,SErr);
      if IErr = 0 then begin
        try
          spPayDelete.Parameters.ParamValues['@RN']       := JSOGridPay.DataSource.DataSet.FieldByName('NRN').AsInteger;
          spPayDelete.Parameters.ParamValues['@USER']     := RegAction.NUSER;
          spPayDelete.Parameters.ParamValues['@NHistory'] := RegAction.RN;
          spPayDelete.ExecProc;
          IErr := spPayDelete.Parameters.ParamValues['@RETURN_VALUE'];
          if IErr <> 0 then begin
            SErr := spPayDelete.Parameters.ParamValues['@SErr'];
            ShowMessage(SErr);
          end;
            except
              on e:Exception do begin
                ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
              end;
        end;
        RegActionClose;
      end else begin
        ShowMessage('IErr = ' + VarToStr(IErr) + chr(10) + SErr);
      end;
    end else begin
      ShowMessage('Операция запрещена.' + chr(10) +
                  'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                  'Дата начала операции: ' + RegAction.SBeginDate
                 );
    end;
  end else ShowMessage(SErr);

  ExecConditionJSOPay;
  ShowGets;
end;

procedure TFCCenterJournalNetZkz.aJRMOSlaveItem_InsExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  { Начальная инициализация действия }
  RegAction.ActionCode := 'JRMO_Item_Insert';
  RegAction.Order      := JRMOGridMain.DataSource.DataSet.FieldByName('NOrderID').AsInteger;
  RegAction.Bell       := 0;
  { Проверяем состояние действия }
  JRMORegActionState(IErr,SErr);
  if IErr = 0 then begin
    { Если открытое действие не зарегистрировано, то выполняем действие }
    if RegAction.State = 0 then begin
      { Регистрируем действие пользователя }
      JRMORegActionOpen(IErr,SErr);
      if IErr = 0 then begin
        try
          frmCCJRMO_Item := TfrmCCJRMO_Item.Create(Self);
          frmCCJRMO_Item.SetMode(cFJRMOItemModeAdd);
          frmCCJRMO_Item.SetAction(RegAction.ActionCode);
          frmCCJRMO_Item.SetOrder(RegAction.Order);
          frmCCJRMO_Item.SetUSER(RegAction.NUSER);
          frmCCJRMO_Item.SetNHistory(RegAction.RN);
          try
            frmCCJRMO_Item.ShowModal;
          finally
            FreeAndNil(frmCCJRMO_Item);
            JRMORegActionClose;
            ExecConditionJRMOItem;
            JRMOShowGets;
          end;
        except
          on e:Exception do begin
            ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
            JRMORegActionClose;
            ExecConditionJRMOItem;
            JRMOShowGets;
          end;
        end;
      end else begin
        ShowMessage('IErr = ' + VarToStr(IErr) + chr(10) + SErr);
      end;
    end else begin
      ShowMessage('Операция запрещена.' + chr(10) +
                  'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                  'Дата начала операции: ' + RegAction.SBeginDate
                 );
    end;
  end else ShowMessage(SErr);
end;

procedure TFCCenterJournalNetZkz.aJRMOSlaveItem_UpdExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;;
  { Начальная инициализация действия }
  RegAction.ActionCode := 'JRMO_Item_Update';
  RegAction.Order      := JRMOGridMain.DataSource.DataSet.FieldByName('NOrderID').AsInteger;
  RegAction.Bell       := 0;
  { Проверяем состояние действия }
  JRMORegActionState(IErr,SErr);
  if IErr = 0 then begin
    { Если открытое действие не зарегистрировано, то выполняем действие }
    if RegAction.State = 0 then begin
      { Регистрируем действие пользователя }
      JRMORegActionOpen(IErr,SErr);
      if IErr = 0 then begin
        try
          frmCCJRMO_Item := TfrmCCJRMO_Item.Create(Self);
          frmCCJRMO_Item.SetMode(cFJRMOItemModeUpd);
          frmCCJRMO_Item.SetAction(RegAction.ActionCode);
          frmCCJRMO_Item.SetOrder(RegAction.Order);
          frmCCJRMO_Item.SetUSER(RegAction.NUSER);
          frmCCJRMO_Item.SetNHistory(RegAction.RN);
          JRMORecItem.RN         := JRMOGridSlaveItem.DataSource.DataSet.FieldByName('NRN').AsInteger;
          JRMORecItem.PRN        := RegAction.Order;
          JRMORecItem.ArtCode    := JRMOGridSlaveItem.DataSource.DataSet.FieldByName('NArtCode').AsInteger;
          JRMORecItem.ArtName    := JRMOGridSlaveItem.DataSource.DataSet.FieldByName('SArtName').AsString;
          JRMORecItem.Quantity   := JRMOGridSlaveItem.DataSource.DataSet.FieldByName('NQuantity').AsInteger;
          JRMORecItem.Cena       := JRMOGridSlaveItem.DataSource.DataSet.FieldByName('NCena').AsCurrency;
          JRMORecItem.CreateDate := FormatDateTime('yyyy-mm-dd hh:nn:ss', JRMOGridSlaveItem.DataSource.DataSet.FieldByName('DDateCreate').AsDateTime);
          frmCCJRMO_Item.SetRecItem(JRMORecItem);
          try
            frmCCJRMO_Item.ShowModal;
          finally
            FreeAndNil(frmCCJRMO_Item);
            JRMORegActionClose;
            ExecConditionJRMOItem;
            JRMOShowGets;
          end;
        except
          on e:Exception do begin
            ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
            JRMORegActionClose;
            ExecConditionJRMOItem;
            JRMOShowGets;
          end;
        end;
      end else begin
        ShowMessage('IErr = ' + VarToStr(IErr) + chr(10) + SErr);
      end;
    end else begin
      ShowMessage('Операция запрещена.' + chr(10) +
                  'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                  'Дата начала операции: ' + RegAction.SBeginDate
                 );
    end;
  end else ShowMessage(SErr);
end;

procedure TFCCenterJournalNetZkz.aJRMOSlaveItem_DelExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  if MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  { Начальная инициализация действия }
  RegAction.ActionCode := 'JRMO_Item_Delete';
  RegAction.Order      := JRMOGridMain.DataSource.DataSet.FieldByName('NOrderID').AsInteger;
  RegAction.Bell       := 0;
  { Проверяем состояние действия }
  JRMORegActionState(IErr,SErr);
  if IErr = 0 then begin
    { Если открытое действие не зарегистрировано, то выполняем действие }
    if RegAction.State = 0 then begin
      { Регистрируем действие пользователя }
      JRMORegActionOpen(IErr,SErr);
      if IErr = 0 then begin
        try
          spJRMOItemDel.Parameters.ParamValues['@RN']       := JRMOGridSlaveItem.DataSource.DataSet.FieldByName('NRN').AsInteger;
          spJRMOItemDel.Parameters.ParamValues['@USER']     := RegAction.NUSER;
          spJRMOItemDel.Parameters.ParamValues['@NHistory'] := RegAction.RN;
          spJRMOItemDel.ExecProc;
          IErr := spJRMOItemDel.Parameters.ParamValues['@RETURN_VALUE'];
          if IErr <> 0 then begin
            SErr := spJRMOItemDel.Parameters.ParamValues['@SErr'];
            ShowMessage(SErr);
          end;
            except
              on e:Exception do begin
                ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
              end;
        end;
        JRMORegActionClose;
      end else begin
        ShowMessage('IErr = ' + VarToStr(IErr) + chr(10) + SErr);
      end;
    end else begin
      ShowMessage('Операция запрещена.' + chr(10) +
                  'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                  'Дата начала операции: ' + RegAction.SBeginDate
                 );
    end;
  end else ShowMessage(SErr);

  ExecConditionJRMOItem;
  JRMOShowGets;
end;

procedure TFCCenterJournalNetZkz.JRMOGridSlaveItemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFCCenterJournalNetZkz.pgcJRMOSlaveChange(Sender: TObject);
begin
  UserActive;
  if pgcJRMOSlave.ActivePage = tabJRMOSlave_HIST then begin
    ExecConditionJRMOHist;
  end else
  if pgcJRMOSlave.ActivePage = tabJRMOSlave_Armour then begin
    ExecConditionJRMOItem;
  end;
  JRMOShowGets;
end;

procedure TFCCenterJournalNetZkz.aJRMOCondValueFieldChangeExecute(Sender: TObject);
begin
  if ISign_Active = 1 then begin
    ExecConditionJRMOMain;
  end;
end;

procedure TFCCenterJournalNetZkz.aJRMOCondHist_SLNameActionExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  UserActive;
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFReferenceJRMOUserActions);
   frmReference.SetReadOnly(cFReferenceYesReadOnly);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    JRMOHist_RNUserAction := frmReference.GetRowIDSelect;
    if length(DescrSelect) > 0 then edCndJRMOHist_NameOperation.Text := DescrSelect;
   finally
    FreeAndNil(frmReference);
   end;
  except
  end;
end;

procedure TFCCenterJournalNetZkz.splitJCallMainMoved(Sender: TObject);
begin
  SetKoefJCallShowSplit;
end;

procedure TFCCenterJournalNetZkz.aJCallMain_CloseExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  if MessageDLG('Подтвердите закрытие вызова.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  try
    spJCallSetState.Parameters.ParamValues['@RN']         := JCallGridMain.DataSource.DataSet.FieldByName('NRN').AsInteger;
    spJCallSetState.Parameters.ParamValues['@USER']       := RegAction.NUSER;
    spJCallSetState.Parameters.ParamValues['@CodeAction'] := 'JCall_Close';
    spJCallSetState.ExecProc;
    IErr := spJCallSetState.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      SErr := spJCallSetState.Parameters.ParamValues['@SErr'];
      ShowMessage('Сбой при выполнении операции.' + chr(10) + SErr);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
  JCallGridMainRefresh;
  JCallShowGets;
end;

procedure TFCCenterJournalNetZkz.aJCallMain_OpenExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  if MessageDLG('Подтвердите открытие вызова.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  try
    spJCallSetState.Parameters.ParamValues['@RN']         := JCallGridMain.DataSource.DataSet.FieldByName('NRN').AsInteger;
    spJCallSetState.Parameters.ParamValues['@USER']       := RegAction.NUSER;
    spJCallSetState.Parameters.ParamValues['@CodeAction'] := 'JCall_Open';
    spJCallSetState.ExecProc;
    IErr := spJCallSetState.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      SErr := spJCallSetState.Parameters.ParamValues['@SErr'];
      ShowMessage('Сбой при выполнении операции.' + chr(10) + SErr);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
  JCallGridMainRefresh;
  JCallShowGets;
end;

procedure TFCCenterJournalNetZkz.aJCallMain_RefreshExecute(Sender: TObject);
begin
  UserActive;
  if pgcJSO_JBO.ActivePage.Name = 'tabJCall' then begin
    JCallGridMainRefresh;
    JCallShowGets;
  end;
end;

procedure TFCCenterJournalNetZkz.aJCallMain_ClearConditionExecute(Sender: TObject);
begin
  UserActive;
  JCallSetClearCondition;
  pgcJCallCondition.ActivePage := tabJCallCondition_Doc;
  JCallShowGets;
end;

procedure TFCCenterJournalNetZkz.aJCallMain_StatusExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  if pgcJSO_JBO.ActivePage.Name = 'tabJCall' then begin
    IErr := 0;
    SErr := '';
    { Начальная инициализация действия }
    RegAction.ActionCode := 'JCall_Status';
    RegAction.Order      := JCallGridMain.DataSource.DataSet.FieldByName('NRN').AsInteger;
    RegAction.Bell       := 0;
    RegAction.Note       := '';
    { Проверяем состояние действия }
    JCallRegActionState(IErr,SErr);
    if IErr = 0 then begin
      { Если открытое действие не зарегистрировано, то выполняем действие }
      if RegAction.State = 0 then begin
        { Регистрируем действие пользователя }
        JCallRegActionOpen(IErr,SErr);
        if IErr = 0 then begin
          try
            frmCCJCall_Status := TfrmCCJCall_Status.Create(Self);
            frmCCJCall_Status.SetCodeAction(RegAction.ActionCode);
            frmCCJCall_Status.SetRN(RegAction.Order);
            frmCCJCall_Status.SetUser(RegAction.NUSER);
            frmCCJCall_Status.SetNote(JCallGridMain.DataSource.DataSet.FieldByName('SNote').AsString);
            frmCCJCall_Status.SetPhone(JCallGridMain.DataSource.DataSet.FieldByName('SPhone').AsString);
            frmCCJCall_Status.SetSCallDate(JCallGridMain.DataSource.DataSet.FieldByName('SCallDate').AsString);
            frmCCJCall_Status.SetRNHist(RegAction.RN);
            try
              frmCCJCall_Status.ShowModal;
            finally
              if frmCCJCall_Status.GetSignExec = 1 then begin
                RegAction.Note := frmCCJCall_Status.GetStatus;
              end;
              FreeAndNil(frmCCJCall_Status);
              RegAction.EndDate := now;
              JCallRegActionClose;
            end;
          except
            on e:Exception do begin
              ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
              RegAction.EndDate := now;
              JCallRegActionClose;
            end;
          end;
        end else begin
          ShowMessage('IErr = ' + VarToStr(IErr) + chr(10) + SErr);
        end;
      end else begin
        ShowMessage('Операция запрещена.' + chr(10) +
                    'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                    'Дата начала операции: ' + RegAction.SBeginDate
                   );
      end;
    end else ShowMessage(SErr);
    JCallGridMainRefresh;
    JCallShowGets;
  end;
end;

procedure TFCCenterJournalNetZkz.aJCallMain_ChangeConditionExecute(Sender: TObject);
begin
  UserActive;
  ExecConditionJCallMain;
end;

procedure TFCCenterJournalNetZkz.aJCallMain_ItemEditExecute(Sender: TObject);
begin
  UserActive;
end;

procedure TFCCenterJournalNetZkz.JCallGridMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  if not (gdSelected in State) then begin
    if length(db.DataSource.DataSet.FieldByName('SCloseDate').AsString) <> 0 then begin
      { Закрытые документы раздела }
      db.Canvas.Brush.Color := TColor($D3D3D3);
    end;
    if db.DataSource.DataSet.FieldByName('ISignNew').AsInteger = 0 then begin
      { Новые входящие }
      if (Column.FieldName = 'SSignNew') then begin
        db.Canvas.Brush.Color := TColor(clRed);
        db.Canvas.Font.Color := TColor(clAqua);
      end;
    end;
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFCCenterJournalNetZkz.JCallGridSlave_HistDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFCCenterJournalNetZkz.JCallGridSlave_EnumeratorDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  if not (gdSelected in State) then begin
    if db.DataSource.DataSet.FieldByName('SSignNew').AsString = 'Да' then begin
      { Новые входящие }
      if (Column.FieldName = 'SSignNew') then begin
        db.Canvas.Brush.Color := TColor(clRed);
        db.Canvas.Font.Color := TColor(clAqua);
      end;
    end;
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFCCenterJournalNetZkz.dsJCallMainDataChange(Sender: TObject; Field: TField);
begin
  if pgcJCallSlave.ActivePage = tabJCallSlave_Hist then begin
    ExecConditionJCallHist;
  end else
  if pgcJCallSlave.ActivePage = tabJCallSlave_Enumerator then begin
    ExecConditionJCallEnumerator;
  end;
  JCallShowGets;
end;

procedure TFCCenterJournalNetZkz.pgcJCallSlaveChange(Sender: TObject);
begin
  UserActive;
  if pgcJCallSlave.ActivePage = tabJCallSlave_Hist then begin
    ExecConditionJCallHist;
  end else
  if pgcJCallSlave.ActivePage = tabJCallSlave_Enumerator then begin
    ExecConditionJCallEnumerator;
  end;
  JCallShowGets;
end;

procedure TFCCenterJournalNetZkz.aJCall_RP_StatisticsExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJCall_RP_Statistics := TfrmCCJCall_RP_Statistics.Create(Self);
    try
      frmCCJCall_RP_Statistics.ShowModal;
      frmCCJCall_RP_Statistics.SetUSER(RegAction.NUSER);
    finally
      FreeAndNil(frmCCJCall_RP_Statistics);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.ShowSpliterOneMoved;
var
  ISignDistibute : integer;
begin
  if pgcJSO_JBO.ActivePage.Name = 'tabJSO' then begin
    ISignDistibute := DBGridSlave.DataSource.DataSet.FieldByName('ISignDistribute').AsInteger;
    if ISignDistibute = 1 then begin
      JSOEnableDistribute;
    end else begin
      JSODisableDistribute;
    end;
    ShowGets;
  end
  else if pgcJSO_JBO.ActivePage.Name = 'tabJRMO' then begin
    JRMOShowGets;
  end
  else if pgcJSO_JBO.ActivePage.Name = 'tabJFB' then begin
    JFBShowGets;
  end
  else if pgcJSO_JBO.ActivePage.Name = 'tabJCall' then begin
    JCallShowGets;
  end;
end;

procedure TFCCenterJournalNetZkz.PanelSideClear;
begin
  { Отключаем боковую панель }
  pnlOneSide.Visible := not pnlOneSide.Visible;
  spliterOne.Visible := not spliterOne.Visible;
  ControlPanelSide.ISignOldActivePnlSide := pnlOneSide.Visible;
  ControlPanelSide.ISignActiveNtfCenter := 0;
  ControlPanelSide.ISIgnActiveOrdPlan   := 0;
end;

procedure TFCCenterJournalNetZkz.ShowPanelSide(TypePanel : byte);
begin
  if ControlPanelSide.ISignOldActivePnlSide then begin
    { Боковая панель была включена }
    if (ControlPanelSide.ISignActiveNtfCenter = 1) and (ControlPanelSide.ISignActiveOrdPlan = 1) then begin
      { Обе базовые панели включены. Следовательно одну отключаем. }
      case TypePanel of
        cPnlSide_NtfCenter: begin
          { Отключаем базовую панель - Центр уведомлений  }
          ControlPanelSide.ISignActiveNtfCenter := 0;
          pnlOneSide_NtfCenter.Visible := false;
          splitOneSide.Visible := false;
          pnlOneSide_OrdPlan.Align := alClient;
        end;
        cPnlSide_OrdPlan: begin
          { Отключаем базовую панель - Планирование обработки заказов  }
          ControlPanelSide.ISignActiveOrdPlan := 0;
          pnlOneSide_OrdPlan.Visible := false;
          splitOneSide.Visible := false;
          pnlOneSide_NtfCenter.Align := alClient;
        end;
      end;
    end
    else if (ControlPanelSide.ISignActiveNtfCenter = 1) and (ControlPanelSide.ISignActiveOrdPlan = 0) then begin
      { Включена одна базовая панель - Центр уведомлений }
      case TypePanel of
        cPnlSide_NtfCenter: begin
          { Отключаем боковую панель }
          PanelSideClear;
        end;
        cPnlSide_OrdPlan: begin
          { Включаем базовую панель - Планирование обработки заказов }
          pnlOneSide_NtfCenter.Align := alTop;
          pnlOneSide_NtfCenter.Height := round(pnlOneSide.Height/GetKoefSplitNtfCenter);
          splitOneSide.Visible := true;
          splitOneSide.Top := pnlOneSide_NtfCenter.Height;
          pnlOneSide_OrdPlan.Visible := true;
          pnlOneSide_OrdPlan.Align := alClient;
          ControlPanelSide.ISignActiveOrdPlan := 1;
        end;
      end;
    end
    else if (ControlPanelSide.ISignActiveNtfCenter = 0) and (ControlPanelSide.ISignActiveOrdPlan = 1) then begin
      { Включена одна базовая панель - Планирование обработки заказов }
      case TypePanel of
        cPnlSide_NtfCenter: begin
          { Включаем базовую панель - Центр уведомлений }
          pnlOneSide_OrdPlan.Align := alBottom;
          pnlOneSide_OrdPlan.Height := round(pnlOneSide.Height/GetKoefSplitNtfCenter) - 5;
          pnlOneSide_NtfCenter.Visible := true;
          pnlOneSide_NtfCenter.Align := alTop;
          pnlOneSide_NtfCenter.Height := round(pnlOneSide.Height/GetKoefSplitNtfCenter);
          splitOneSide.Visible := true;
          splitOneSide.Top := pnlOneSide_NtfCenter.Height;
          ControlPanelSide.ISignActiveNtfCenter := 1;
          pnlOneSide_OrdPlan.Align := alClient;
        end;
        cPnlSide_OrdPlan: begin
          { Отключаем боковую панель }
          PanelSideClear;
        end;
      end;
    end;
  end
  else if not ControlPanelSide.ISignOldActivePnlSide then begin
    { Боковая панель была отключена }
    pnlOneSide.Visible := not pnlOneSide.Visible;
    spliterOne.Visible  := not spliterOne.Visible;
    ControlPanelSide.ISignOldActivePnlSide := pnlOneSide.Visible;
    case TypePanel of
      cPnlSide_NtfCenter: begin
        { Управляем отображением базовых панелей }
        ControlPanelSide.ISignActiveNtfCenter := 1;
        ControlPanelSide.ISignActiveOrdPlan := 0;
        pnlOneSide_NtfCenter.Visible := true;
        pnlOneSide_OrdPlan.Visible := false;
        splitOneSide.Visible := false;
        pnlOneSide_NtfCenter.Align := alClient;
      end;
      cPnlSide_OrdPlan: begin
        { Управляем отображением базовых панелей }
        ControlPanelSide.ISignActiveOrdPlan := 1;
        ControlPanelSide.ISignActiveNtfCenter := 0;
        pnlOneSide_OrdPlan.Visible := true;
        pnlOneSide_NtfCenter.Visible := false;
        splitOneSide.Visible := false;
        pnlOneSide_OrdPlan.Align := alClient;
      end;
    end;
  end;
  if pnlOneSide.Visible and spliterOne.Visible then begin
    pnlOneSide.Width := round(FCCenterJournalNetZkz.Width/GetKoefSplitOneSide);
  end;
  ShowSpliterOneMoved;
end;

procedure TFCCenterJournalNetZkz.aAlarmMsgExecute(Sender: TObject);
begin
  UserActive;
  ShowPanelSide(cPnlSide_NtfCenter);
end;

procedure TFCCenterJournalNetZkz.spliterOneMoved(Sender: TObject);
begin
  ShowSpliterOneMoved;
  SetKoefSplitOneSide;
end;

procedure TFCCenterJournalNetZkz.aAlarmOrdersPlanExecute(Sender: TObject);
begin
  UserActive;
  ShowPanelSide(cPnlSide_OrdPlan);
end;

procedure TFCCenterJournalNetZkz.aJSOMarkExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  { Начальная инициализация действия }
  RegAction.ActionCode := 'JSO_Mark';
  RegAction.Order      := OrderHeaderDS.FieldByName('orderID').AsInteger;
  RegAction.Bell       := 0;
  { Проверяем состояние действия }
  RegActionState(IErr,SErr);
  if IErr = 0 then begin
    { Если открытое действие не зарегистрировано, то выполняем действие }
    if RegAction.State = 0 then begin
      try
        spJSOMark.Parameters.ParamValues['@Order'] := RegAction.Order;
        spJSOMark.Parameters.ParamValues['@User']  := RegAction.NUSER;
        spJSOMark.ExecProc;
        IErr := spJSOMark.Parameters.ParamValues['@RETURN_VALUE'];
        if IErr <> 0 then begin
          SErr := spJSOMark.Parameters.ParamValues['@SErr'];
          ShowMessage('Сбой при выполнении операции.' + chr(10) + SErr);
        end;
      except
        on e:Exception do begin
          ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
        end;
      end;
    end else begin
      ShowMessage('Операция запрещена.' + chr(10) +
                  'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                  'Дата начала операции: ' + RegAction.SBeginDate
                 );
    end;
  end else ShowMessage(SErr);
  GridMainRefresh;
  ShowGets;
end;

procedure TFCCenterJournalNetZkz.aJSOMarkClearExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  if MessageDLG('Подтвердите очистку признака <избранный заказ>.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  { Начальная инициализация действия }
  RegAction.ActionCode := 'JSO_MarkClear';
  RegAction.Order      := OrderHeaderDS.FieldByName('orderID').AsInteger;
  RegAction.Bell       := 0;
  { Проверяем состояние действия }
  RegActionState(IErr,SErr);
  if IErr = 0 then begin
    { Если открытое действие не зарегистрировано, то выполняем действие }
    if RegAction.State = 0 then begin
      try
        spJSOMarkClear.Parameters.ParamValues['@MarkRN'] := OrderHeaderDS.FieldByName('NMarkRN').AsInteger;
        spJSOMarkClear.Parameters.ParamValues['@Order']  := RegAction.Order;
        spJSOMarkClear.Parameters.ParamValues['@User']   := RegAction.NUSER;
        spJSOMarkClear.ExecProc;
        IErr := spJSOMarkClear.Parameters.ParamValues['@RETURN_VALUE'];
        if IErr <> 0 then begin
          SErr := spJSOMarkClear.Parameters.ParamValues['@SErr'];
          ShowMessage('Сбой при выполнении операции.' + chr(10) + SErr);
        end;
      except
        on e:Exception do begin
          ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
        end;
      end;
    end else begin
      ShowMessage('Операция запрещена.' + chr(10) +
                  'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                  'Дата начала операции: ' + RegAction.SBeginDate
                 );
    end;
  end else ShowMessage(SErr);
  GridMainRefresh;
  ShowGets;
end;

procedure TFCCenterJournalNetZkz.aJSOMarkFiltrExecute(Sender: TObject);
begin
  UserActive;
  SetClearCondition;
  pgctrlCondition.ActivePage := tabJournal;
  JSOCondRec.SignMark          := 1;     { Мои заказы }
  cmbxCndState.ItemIndex       := 1;     { Открытые заказы }
  chbxCndAccountPeriod.Checked := false; { За весь период }
  ExecConditionQRMain;
  ShowGets;
end;

procedure TFCCenterJournalNetZkz.aJSOMarkForOthersExecute(Sender: TObject);
var
  IErr           : integer;
  SErr           : string;
  DescrSelect    : string;
  NMarkOtherUser : integer;
begin
  UserActive;
  NMarkOtherUser := 0;
  DescrSelect := '';
  { Начальная инициализация действия }
  RegAction.ActionCode := 'JSO_MarkForOthers';
  RegAction.Order      := OrderHeaderDS.FieldByName('orderID').AsInteger;
  RegAction.Bell       := 0;
  { Проверяем состояние действия }
  RegActionState(IErr,SErr);
  if IErr = 0 then begin
    { Если открытое действие не зарегистрировано, то выполняем действие }
    if RegAction.State = 0 then begin
      DescrSelect := '';
      try
        frmReference := TfrmReference.Create(Self);
        frmReference.SetMode(cFReferenceModeSelect);
        frmReference.SetReferenceIndex(cFReferenceUserBirdAva);
        frmReference.SetReadOnly(cFReferenceYesReadOnly);
        frmReference.SetSignUserBirdAvaExcludCurrent(1);
        frmReference.SetUser(RegAction.NUSER);
        try
          frmReference.ShowModal;
          DescrSelect := frmReference.GetDescrSelect;
          if length(DescrSelect) > 0 then begin
            NMarkOtherUser := frmReference.GetRowIDSelect;
          end;
        finally
          FreeAndNil(frmReference);
        end;
      except
      end;
      if NMarkOtherUser <> 0 then begin
        if MessageDLG('Подтвердите передачу заказа на исполнение пользователю ' + DescrSelect,mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
          try
            spJSOMarkForOthers.Parameters.ParamValues['@MarkRN']    := OrderHeaderDS.FieldByName('NMarkRN').AsInteger;
            spJSOMarkForOthers.Parameters.ParamValues['@Order']     := RegAction.Order;
            spJSOMarkForOthers.Parameters.ParamValues['@User']      := RegAction.NUSER;
            spJSOMarkForOthers.Parameters.ParamValues['@OtherUser'] := NMarkOtherUser;
            spJSOMarkForOthers.ExecProc;
            IErr := spJSOMarkForOthers.Parameters.ParamValues['@RETURN_VALUE'];
            if IErr <> 0 then begin
              SErr := spJSOMarkForOthers.Parameters.ParamValues['@SErr'];
              ShowMessage('Сбой при выполнении операции.' + chr(10) + SErr);
            end;
          except
            on e:Exception do begin
              ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
            end;
          end;
        end;
      end;
    end else begin
      ShowMessage('Операция запрещена.' + chr(10) +
                  'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                  'Дата начала операции: ' + RegAction.SBeginDate
                 );
    end;
  end else ShowMessage(SErr);
  GridMainRefresh;
  ShowGets;
end;

procedure TFCCenterJournalNetZkz.aJSOMarkSettingExecute(Sender: TObject);
var
  ISignReturn    : smallint;
  RetCondMyOrder : TRetCondMyOrder;
begin
  UserActive;
  try
    frmCCJSO_MyOrder := TfrmCCJSO_MyOrder.Create(Self);
    frmCCJSO_MyOrder.SetUser(RegAction.NUSER);
    try
      frmCCJSO_MyOrder.ShowModal;
      ISignReturn := frmCCJSO_MyOrder.GetSignReturn;
      case ISignReturn of
        cJSOMyOrder_ReturnExit: begin
        end;
        cJSOMyOrder_ReturnCondOrder: begin
          RetCondMyOrder := frmCCJSO_MyOrder.GetCondMyOrder;
          SetClearCondition;
          pgctrlCondition.ActivePage := tabJournal;
          JSOCondRec.SOrderID := IntToStr(RetCondMyOrder.Order);
          chbxCndAccountPeriod.Checked := false; { За весь период }
          ExecConditionQRMain;
          ShowGets;
        end;
        cJSOMyOrder_ReturnCondUserOrders: begin
          RetCondMyOrder := frmCCJSO_MyOrder.GetCondMyOrder;
          SetClearCondition;
          pgctrlCondition.ActivePage := tabJournal;
          JSOCondRec.SignMark          := 2;     { Другие }
          cmbxCndState.ItemIndex       := 1;     { Открытые заказы }
          chbxCndAccountPeriod.Checked := false; { За весь период }
          JSOCondRec.SMarkOtherUser    := RetCondMyOrder.SUser;
          JSOCondRec.NMarkOtherUser    := RetCondMyOrder.NUser;
          ExecConditionQRMain;
          ShowGets;
        end;
      end;
    finally
      FreeAndNil(frmCCJSO_MyOrder);
    end;
  except
  end;
end;

procedure TFCCenterJournalNetZkz.aAlarmJSOMarkSettingExecute(Sender: TObject);
begin
  UserActive;
end;

procedure TFCCenterJournalNetZkz.aOneSide_CloseExecute(Sender: TObject);
begin
  PanelSideClear;
  ShowSpliterOneMoved;
end;

function TFCCenterJournalNetZkz.ControlAtMouse: TControl;
var
 P: TPoint;
begin
 GetCursorPos(P);
 Result := FindDragTarget(P, True);
end;

function TFCCenterJournalNetZkz.FindParentTagFive(Obj : TControl) : TControl;
var
  ParentTagFive : TControl;
  ObjOld        : TControl;
  ObjNew        : TControl;
begin
  ParentTagFive := nil;
  ObjOld := Obj;
  ObjNew := Obj;
  if Assigned(ObjOld) then begin
    if ObjOld.Tag = cObjAlertMainTag then begin
      ParentTagFive := ObjOld;
    end else begin
      while(not Assigned(ParentTagFive)) do begin
        ObjNew := ObjOld.Parent;
        if Assigned(ObjNew) then begin
          if      ObjNew.Tag = cObjAlertMainTag  then ParentTagFive := ObjNew
          else if ObjNew.Tag = cObjAlertSlaveTag then ObjOld := ObjNew
          else break;
        end else break;
      end;
    end;
  end;
  Result := ParentTagFive;
end;

procedure TFCCenterJournalNetZkz.pnlMouseEnter(Sender: TObject);
begin
  if ControlPanelSide.ControlMouseEnter.Tag = 5 then begin
    TPanel(ControlPanelSide.ControlMouseEnter).BorderStyle := bsSingle;
    //TPanel(ControlMouseEnter).Color := TColor($FEC2C9);
  end;
end;

procedure TFCCenterJournalNetZkz.pnlMouseExit(Sender: TObject);
begin
  if ControlPanelSide.ControlMouseLeave.Tag = 5 then begin
    TPanel(ControlPanelSide.ControlMouseLeave).BorderStyle := bsNone;
    //TPanel(ControlMouseLeave).Color := clBtnFace;
  end;
end;

procedure TFCCenterJournalNetZkz.AppEventsNtfCenterIdle(Sender: TObject; var Done: Boolean);
var
  CurrentControl : TControl;
  ParentTagFive  : TControl;
begin
  CurrentControl := ControlAtMouse;
  if Assigned(CurrentControl) then begin
    if (CurrentControl.Tag = cObjAlertMainTag) or (CurrentControl.Tag = cObjAlertSlaveTag) then begin
      { Ищем TComponenet с Tag = cObjAlertMainTag }
      ParentTagFive := FindParentTagFive(CurrentControl);
      if Assigned(ParentTagFive) then begin
        if ParentTagFive.Name <> ControlPanelSide.ControlMouseEnter.Name then begin
          ControlPanelSide.ControlMouseLeave := ControlPanelSide.ControlMouseEnter;
          ControlPanelSide.ControlMouseEnter := ParentTagFive;
          ControlPanelSide.TagLeave := ControlPanelSide.TagEnter;
          ControlPanelSide.TagEnter := cObjAlertMainTag;
          if ControlPanelSide.ControlMouseLeave.Tag = cObjAlertMainTag then TPanel(ControlPanelSide.ControlMouseLeave).OnExit(nil);
          TPanel(ControlPanelSide.ControlMouseEnter).OnEnter(nil);
        end;
      end;
    end else begin
      ControlPanelSide.ControlMouseLeave := ControlPanelSide.ControlMouseEnter;
      ControlPanelSide.ControlMouseEnter := CurrentControl;
      ControlPanelSide.TagLeave := ControlPanelSide.TagEnter;
      ControlPanelSide.TagEnter := 0;
      try
        if Assigned(ControlPanelSide.ControlMouseLeave) then
          if ControlPanelSide.TagLeave = cObjAlertMainTag
            then TPanel(ControlPanelSide.ControlMouseLeave).OnExit(nil);
      except
      end;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.splitOneSideMoved(Sender: TObject);
begin
  SetKoefSplitNtfCenter;
end;

procedure TFCCenterJournalNetZkz.aSessionUserExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJSO_SessionUser := TfrmCCJSO_SessionUser.Create(Self);
    try
      frmCCJSO_SessionUser.ShowModal;
    finally
      FreeAndNil(frmCCJSO_SessionUser);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aClipBoard_OrderNoteCourierExecute(Sender: TObject);
begin
  ClipBoard.AsText := OrderHeaderDS.FieldByName('SNote').AsString;
end;

procedure TFCCenterJournalNetZkz.aNtfCenter_HistoryExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJSO_JournalAlert := TfrmCCJSO_JournalAlert.Create(Self);
    frmCCJSO_JournalAlert.SetUser(UserSession.CurrentUser);
    frmCCJSO_JournalAlert.SetSUser(UserSession.CurrentNameUser);
    frmCCJSO_JournalAlert.IP := UserSession.LocalIP;
    try
      frmCCJSO_JournalAlert.ShowModal;
    finally
      FreeAndNil(frmCCJSO_JournalAlert);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aUserMadeNotificationExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJAL_CreateUserMsg := TfrmCCJAL_CreateUserMsg.Create(Self);
    frmCCJAL_CreateUserMsg.SetUser(UserSession.CurrentUser, UserSession.CurrentNameUser);
    try
      frmCCJAL_CreateUserMsg.ShowModal;
    finally
      FreeAndNil(frmCCJAL_CreateUserMsg);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.AlertSetUserRead(NRN : int64);
begin
  try
    spSetUserRead.Parameters.ParamValues['@NRN'] := NRN;
    spSetUserRead.ExecProc;
  except
    on e:Exception do
      begin
      end;
  end;
end;

procedure TFCCenterJournalNetZkz.aControl_AlertRead01Execute(Sender: TObject);
begin
  if AlertPanel.APList.Count >= 1 then begin
    AlertSetUserRead(PAlertPopupWindowOptions(AlertPanel.APList[0])^.NRN_AlertUser);
  end;
end;

procedure TFCCenterJournalNetZkz.aControl_AlertRead02Execute(Sender: TObject);
begin
  if AlertPanel.APList.Count >= 2 then begin
    AlertSetUserRead(PAlertPopupWindowOptions(AlertPanel.APList[1])^.NRN_AlertUser);
  end;
end;

procedure TFCCenterJournalNetZkz.aControl_AlertRead03Execute(Sender: TObject);
begin
  if AlertPanel.APList.Count >= 3 then begin
    AlertSetUserRead(PAlertPopupWindowOptions(AlertPanel.APList[2])^.NRN_AlertUser);
  end;
end;

procedure TFCCenterJournalNetZkz.aControl_AlertRead04Execute(Sender: TObject);
begin
  if AlertPanel.APList.Count >= 4 then begin
    AlertSetUserRead(PAlertPopupWindowOptions(AlertPanel.APList[3])^.NRN_AlertUser);
  end;
end;

procedure TFCCenterJournalNetZkz.aControl_AlertRead05Execute(Sender: TObject);
begin
  if AlertPanel.APList.Count >= 5 then begin
    AlertSetUserRead(PAlertPopupWindowOptions(AlertPanel.APList[4])^.NRN_AlertUser);
  end;
end;

procedure TFCCenterJournalNetZkz.aControl_AlertRead06Execute(Sender: TObject);
begin
  if AlertPanel.APList.Count >= 6 then begin
    AlertSetUserRead(PAlertPopupWindowOptions(AlertPanel.APList[5])^.NRN_AlertUser);
  end;
end;

procedure TFCCenterJournalNetZkz.aControl_AlertRead07Execute(Sender: TObject);
begin
  if AlertPanel.APList.Count >= 7 then begin
    AlertSetUserRead(PAlertPopupWindowOptions(AlertPanel.APList[6])^.NRN_AlertUser);
  end;
end;

procedure TFCCenterJournalNetZkz.aControl_AlertRead08Execute(Sender: TObject);
begin
  if AlertPanel.APList.Count >= 8 then begin
    AlertSetUserRead(PAlertPopupWindowOptions(AlertPanel.APList[7])^.NRN_AlertUser);
  end;
end;

procedure TFCCenterJournalNetZkz.aControl_AlertRead09Execute(Sender: TObject);
begin
  if AlertPanel.APList.Count >= 9 then begin
    AlertSetUserRead(PAlertPopupWindowOptions(AlertPanel.APList[8])^.NRN_AlertUser);
  end;
end;

procedure TFCCenterJournalNetZkz.aControl_AlertRead10Execute(Sender: TObject);
begin
  if AlertPanel.APList.Count >= 10 then begin
    AlertSetUserRead(PAlertPopupWindowOptions(AlertPanel.APList[9])^.NRN_AlertUser);
  end;
end;

procedure TFCCenterJournalNetZkz.aAlertAllExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCSJO_AlertContents := TfrmCCSJO_AlertContents.Create(Self);
    try
      frmCCSJO_AlertContents.ShowModal;
      frmCCSJO_AlertContents.SetRecSession(UserSession);
    finally
      FreeAndNil(frmCCSJO_AlertContents);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aMain_OrderHeaderItem_UpdExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
  vErrMsg : string;
  Mode : integer;

  { Для режима чтение }
  procedure HeaderItemModeRead(Comments: string = ''); begin
    frmCCJSO_OrderHeaderItem := TfrmCCJSO_OrderHeaderItem.Create(Self);
    frmCCJSO_OrderHeaderItem.SetRecSession(UserSession);
    frmCCJSO_OrderHeaderItem.SetRecHeaderItem(JSOHeaderItem);
    frmCCJSO_OrderHeaderItem.SetMode(Mode);
    frmCCJSO_OrderHeaderItem.SetParentsList(ParentsList);
    frmCCJSO_OrderHeaderItem.SetSlavesList(SlavesList);
    frmCCJSO_OrderHeaderItem.ExtComments := Comments;
    try
      frmCCJSO_OrderHeaderItem.ShowModal;
    finally
      FreeAndNil(frmCCJSO_OrderHeaderItem);
    end;
  end; { ModeRead }
begin
  SErr := '';
  vErrMsg := '';
  UserActive;
  if not qrMain.IsEmpty then begin
    if IsActionOrder then
    begin
      //Если статус позволяет редактирование и нет незавершенных действий открываем в режиме редактирования,
      //иначе открываем в режиме просмотра
      if CanEditOrder('JSO_OrderHeaderUpd', vErrMsg) then
        ExecHistoryOrderAction('JSO_OrderHeaderUpd',
          '')
      else
      begin
        Mode := cModeJSOHeaderItem_Read;
        if vErrMsg <> '' then
          vErrMsg := vErrMsg + ' Возможен только ПРОСМОТР.';
        JSOAssignHeaderItem;
        { Уточняем список родительских и дополнительных заказов }
        DM_CCJSO.JSOParentsList(UserSession.CurrentUser, JSOHeaderItem.orderID, ParentsList, IErr, SErr);
        DM_CCJSO.JSOSlavesList(UserSession.CurrentUser, JSOHeaderItem.orderID, SlavesList, IErr, SErr);
        HeaderItemModeRead(vErrMsg);
      end
    end
    else
    begin
      { Начальная инициализация действия }
      RegAction.ActionCode := 'JSO_HeaderEdit';
      RegAction.Order      := OrderHeaderDS.FieldByName('orderID').AsInteger;
      RegAction.Bell       := 0;
      try
        { Определяем текущие значения записи }
        JSOAssignHeaderItem;
        { Уточняем список родительских и дополнительных заказов }
        DM_CCJSO.JSOParentsList(UserSession.CurrentUser, JSOHeaderItem.orderID, ParentsList, IErr, SErr);
        DM_CCJSO.JSOSlavesList(UserSession.CurrentUser, JSOHeaderItem.orderID, SlavesList, IErr, SErr);
        { Определение режима работы }
        if    (length(trim(JSOHeaderItem.aptekaID)) = 0)
          and (length(trim(JSOHeaderItem.SCloseDate)) = 0)
          then Mode := cModeJSOHeaderItem_Edit
          else Mode := cModeJSOHeaderItem_Read;
        if Mode = cModeJSOHeaderItem_Read then begin
          { Режим работы - чтение }
          HeaderItemModeRead;
        end else begin
          { Режим работы - исправление }
          { Проверяем состояние действия }
          RegActionState(IErr,SErr);
          if IErr = 0 then begin
            { Если открытое действие не зарегистрировано, то выполняем действие }
            if RegAction.State = 0 then begin
              { Регистрируем действие пользователя }
              RegActionOpen(IErr,SErr);
              if IErr = 0 then begin
                try
                  frmCCJSO_OrderHeaderItem := TfrmCCJSO_OrderHeaderItem.Create(Self);
                  frmCCJSO_OrderHeaderItem.SetRecSession(UserSession);
                  frmCCJSO_OrderHeaderItem.SetRecHeaderItem(JSOHeaderItem);
                  frmCCJSO_OrderHeaderItem.SetMode(Mode);
                  frmCCJSO_OrderHeaderItem.SetParentsList(ParentsList);
                  frmCCJSO_OrderHeaderItem.SetSlavesList(SlavesList);
                  try
                    frmCCJSO_OrderHeaderItem.ShowModal;
                  finally
                    FreeAndNil(frmCCJSO_OrderHeaderItem);
                    RegActionClose;
                  end;
                except
                  on e:Exception do begin
                    ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
                    RegActionClose;
                  end;
                end;
              end else begin
                ShowMessage('IErr = ' + VarToStr(IErr) + chr(10) + SErr);
              end;
            end else begin
              ShowMessage('Исправление невозможно. Заказ будет открыт в режиме чтения.' + chr(10) +
                          'Заказ обрабатывается пользователем: ' + RegAction.SUSER + chr(10) +
                          'Дата начала операции: ' + RegAction.SBeginDate
                         );
              Mode := cModeJSOHeaderItem_Read;
              HeaderItemModeRead;
            end;
          end else ShowMessage(SErr);
        end;
        GridMainRefresh;
        ShowGets;
      except
        on e:Exception do begin
          ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
        end;
      end;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.DBGridMainDblClick(Sender: TObject);
begin
  UserActive;
  if not qrMain.IsEmpty then begin
    aMain_OrderHeaderItem_Upd.Execute;
  end;
end;

procedure TFCCenterJournalNetZkz.JSOGridNPostDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  if not (gdSelected in State) then begin
    if db.DataSource.DataSet.FieldByName('ISignHistLastDateUpdate').AsInteger = 1 then begin
      { Есть история даты изменения состояния }
      if (Column.FieldName = 'SStateName') then begin
        db.Canvas.Brush.Color := TColor($C4FFFF);
      end;
    end;
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFCCenterJournalNetZkz.aJSOSlaveNPost_HistStateDateExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  if not qrspJSONPost.IsEmpty then begin
    try
      frmCCJSO_NPost_StateDate := TfrmCCJSO_NPost_StateDate.Create(Self);
      frmCCJSO_NPost_StateDate.SetStateName(JSOGridNPost.DataSource.DataSet.FieldByName('SStateName').AsString);
      frmCCJSO_NPost_StateDate.SetStateDate(JSOGridNPost.DataSource.DataSet.FieldByName('SDateLastUpdatedStatus').AsString);
      frmCCJSO_NPost_StateDate.SetRN(JSOGridNPost.DataSource.DataSet.FieldByName('NRN').AsInteger);
      try
        frmCCJSO_NPost_StateDate.ShowModal;
      finally
        FreeAndNil(frmCCJSO_NPost_StateDate);
      end;
    except
      on e:Exception do begin
        ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
      end;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aMain_RP_NPostOverdueExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  try
    frmCCJSO_NPostOverdue := TfrmCCJSO_NPostOverdue.Create(Self);
    try
      frmCCJSO_NPostOverdue.ShowModal;
    finally
      FreeAndNil(frmCCJSO_NPostOverdue);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aMain_RP_ConsolidatedNetOrderExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJSO_RP_ConsolidatedNetOrder := TfrmCCJSO_RP_ConsolidatedNetOrder.Create(Self);
    try
      frmCCJSO_RP_ConsolidatedNetOrder.ShowModal;
    finally
      FreeAndNil(frmCCJSO_RP_ConsolidatedNetOrder);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aMain_PlanDateSendExecute(Sender: TObject);
begin
  { вместо aMain_MarkDateAssembling }
  UserActive;
  JSOAssignHeaderItem;
  try
    frmCCJSO_SetFieldDate := TfrmCCJSO_SetFieldDate.Create(Self);
    frmCCJSO_SetFieldDate.SetMode(cFieldDate_Assembling);
    frmCCJSO_SetFieldDate.SetRecHeaderItem(JSOHeaderItem);
    frmCCJSO_SetFieldDate.SetUserSession(UserSession);
    frmCCJSO_SetFieldDate.SetTypeExec(cSFDTypeExec_Update);
    try
      frmCCJSO_SetFieldDate.ShowModal;
      GridMainRefresh;
      ShowGets;
    finally
      FreeAndNil(frmCCJSO_SetFieldDate);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aMain_RP_PayCashOnDeliveryExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJSO_RP_PayCashOnDelivery := TfrmCCJSO_RP_PayCashOnDelivery.Create(Self);
    try
      frmCCJSO_RP_PayCashOnDelivery.ShowModal;
    finally
      FreeAndNil(frmCCJSO_RP_PayCashOnDelivery);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aCopyRightExecute(Sender: TObject);
begin
  { О программе }
  UserActive;
  try
    frmCCJSO_Version := TfrmCCJSO_Version.Create(Self);
    try
      frmCCJSO_Version.ShowModal;
      frmCCJSO_Version.SetUserSession(UserSession);
    finally
      FreeAndNil(frmCCJSO_Version);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

(* Очистить условие отбора *)
procedure TFCCenterJournalNetZkz.aMain_ConditionClearExecute(Sender: TObject);
var
 IErr : integer;
 SErr : string;
begin
  IJSOSignMassChangeCondition := 1;
  try
    SetClearCondition;
    if JSOCondIdent <> 0 then begin
      DM_CCJSO.SLClear(JSOCondIdent,IErr,SErr);
      JSOCondIdent := 0;
    end;
    pgctrlCondition.ActivePage := tabJournal;
    ExecConditionQRMain;
    ShowGets;
  finally
    IJSOSignMassChangeCondition := 0;
  end;
end;

procedure TFCCenterJournalNetZkz.aJSOLink_AddToOrderExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  if not qrMain.IsEmpty then begin
    try
      JSOAssignHeaderItem;  { Определяем текущие значения записи }
      DM_CCJSO.JSOParentsList(UserSession.CurrentUser, JSOHeaderItem.orderID, ParentsList, IErr, SErr);
      DM_CCJSO.JSOSlavesList(UserSession.CurrentUser, JSOHeaderItem.orderID, SlavesList, IErr, SErr);
      frmCCJSO_SetLink := TfrmCCJSO_SetLink.Create(Self);
      frmCCJSO_SetLink.SetUserSession(UserSession);
      frmCCJSO_SetLink.SetRecHeaderItem(JSOHeaderItem);
      frmCCJSO_SetLink.SetMode(cJSOLinkMode_AddToOrder);
      frmCCJSO_SetLink.SetLinkList(ParentsList, SlavesList);
      try
        frmCCJSO_SetLink.ShowModal;
      finally
        FreeAndNil(frmCCJSO_SetLink);
      end;
    except
      on e:Exception do begin
        ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
      end;
    end;
    GridMainRefresh;
    ShowGets;
  end;
end;

procedure TFCCenterJournalNetZkz.aJSOLink_AddToMainRequestExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  if not qrMain.IsEmpty then begin
    try
      JSOAssignHeaderItem; { Определяем текущие значения записи }
      DM_CCJSO.JSOParentsList(UserSession.CurrentUser, JSOHeaderItem.orderID, ParentsList, IErr, SErr);
      DM_CCJSO.JSOSlavesList(UserSession.CurrentUser, JSOHeaderItem.orderID, SlavesList, IErr, SErr);
      frmCCJSO_SetLink := TfrmCCJSO_SetLink.Create(Self);
      frmCCJSO_SetLink.SetUserSession(UserSession);
      frmCCJSO_SetLink.SetRecHeaderItem(JSOHeaderItem);
      frmCCJSO_SetLink.SetMode(cJSOLinkMode_AddToMainRequest);
      frmCCJSO_SetLink.SetLinkList(ParentsList, SlavesList);
      try
        frmCCJSO_SetLink.ShowModal;
      finally
        FreeAndNil(frmCCJSO_SetLink);
      end;
    except
      on e:Exception do begin
        ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
      end;
    end;
    GridMainRefresh;
    ShowGets;
  end;
end;

procedure TFCCenterJournalNetZkz.aJSOLink_ClearAllUpExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  if not qrMain.IsEmpty then begin
    if MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
    try
      JSOAssignHeaderItem; { Определяем текущие значения записи }
      DM_CCJSO.JSOClearLinkParents(UserSession.CurrentUser,JSOHeaderItem.orderID,cJSOLinkClear_AllParents,IErr,SErr);
    except
      on e:Exception do begin
        ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
      end;
    end;
    GridMainRefresh;
    ShowGets;
  end;
end;

procedure TFCCenterJournalNetZkz.aJSOLink_ClearAllDownExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  if not qrMain.IsEmpty then begin
    if MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
    try
      JSOAssignHeaderItem; { Определяем текущие значения записи }
      DM_CCJSO.JSOClearLinkSlaves(UserSession.CurrentUser,JSOHeaderItem.orderID,cJSOLinkClear_AllSlaves,IErr,SErr);
    except
      on e:Exception do begin
        ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
      end;
    end;
    GridMainRefresh;
    ShowGets;
  end;
end;

procedure TFCCenterJournalNetZkz.aJSOLink_ClearOneUpExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  if not qrMain.IsEmpty then begin
    if MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
    try
      JSOAssignHeaderItem; { Определяем текущие значения записи }
      DM_CCJSO.JSOClearLinkParents(UserSession.CurrentUser,JSOHeaderItem.orderID,cJSOLinkClear_NextParent,IErr,SErr);
    except
      on e:Exception do begin
        ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
      end;
    end;
    GridMainRefresh;
    ShowGets;
  end;
end;

procedure TFCCenterJournalNetZkz.aJSOLink_ClearOneDownExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  if not qrMain.IsEmpty then begin
    if MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
    try
      JSOAssignHeaderItem; { Определяем текущие значения записи }
      DM_CCJSO.JSOClearLinkSlaves(UserSession.CurrentUser,JSOHeaderItem.orderID,cJSOLinkClear_NextSlave,IErr,SErr);
    except
      on e:Exception do begin
        ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
      end;
    end;
    GridMainRefresh;
    ShowGets;
  end;
end;

procedure TFCCenterJournalNetZkz.aJSOBlackList_AddExecute(Sender: TObject);
begin
  UserActive;
  if IsActionOrder then
    ExecHistoryOrderAction('JSO_AddBlackLIst',
      '')
  else
  begin
    try
      { Определяем текущие значения записи }
      JSOAssignHeaderItem;
      { Для режима чтение }
      frmCCJSO_BlackListControl := TfrmCCJSO_BlackListControl.Create(Self);
      frmCCJSO_BlackListControl.SetRecSession(UserSession);
      frmCCJSO_BlackListControl.SetRecHeaderItem(JSOHeaderItem);
      frmCCJSO_BlackListControl.SetMode(cBlackListMode_Open);
      try
        frmCCJSO_BlackListControl.ShowModal;
        GridMainRefresh;
        ShowGets;
      finally
        FreeAndNil(frmCCJSO_BlackListControl);
      end;
    except
      on e:Exception do begin
        ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
      end;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aJSOBlackList_CloseExecute(Sender: TObject);
begin
  UserActive;
  if IsActionOrder then
    ExecHistoryOrderAction('JSO_CloseBlackList',
      '')
  else
  begin
    try
      { Определяем текущие значения записи }
      JSOAssignHeaderItem;
      { Для режима чтение }
      frmCCJSO_BlackListControl := TfrmCCJSO_BlackListControl.Create(Self);
      frmCCJSO_BlackListControl.SetRecSession(UserSession);
      frmCCJSO_BlackListControl.SetRecHeaderItem(JSOHeaderItem);
      frmCCJSO_BlackListControl.SetMode(cBlackListMode_Close);
      try
        frmCCJSO_BlackListControl.ShowModal;
        GridMainRefresh;
        ShowGets;
      finally
        FreeAndNil(frmCCJSO_BlackListControl);
      end;
    except
      on e:Exception do begin
        ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
      end;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aJSOBlackListExecute(Sender: TObject);
begin
  UserActive;
  try
    { Определяем текущие значения записи }
    JSOAssignHeaderItem;
    frmCC_BlackListJournal := TfrmCC_BlackListJournal.Create(Self);
    try
      frmCC_BlackListJournal.ShowModal;
      GridMainRefresh;
      ShowGets;
    finally
      FreeAndNil(frmCC_BlackListJournal);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aMain_OrderHeaderItem_InfoExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
  Mode : integer;
begin
  UserActive;
  if not qrMain.IsEmpty then begin
    { Начальная инициализация действия }
    RegAction.ActionCode := 'JSO_HeaderEdit';
    RegAction.Order      := OrderHeaderDS.FieldByName('orderID').AsInteger;
    RegAction.Bell       := 0;
    try
      { Определяем текущие значения записи }
      JSOAssignHeaderItem;
      { Уточняем список родительских и дополнительных заказов }
      DM_CCJSO.JSOParentsList(UserSession.CurrentUser, JSOHeaderItem.orderID, ParentsList, IErr, SErr);
      DM_CCJSO.JSOSlavesList(UserSession.CurrentUser, JSOHeaderItem.orderID, SlavesList, IErr, SErr);
      { Для режима чтение }
      frmCCJSO_OrderHeaderItem := TfrmCCJSO_OrderHeaderItem.Create(Self);
      frmCCJSO_OrderHeaderItem.SetRecSession(UserSession);
      frmCCJSO_OrderHeaderItem.SetRecHeaderItem(JSOHeaderItem);
      frmCCJSO_OrderHeaderItem.SetMode(cModeJSOHeaderItem_Read);
      frmCCJSO_OrderHeaderItem.SetParentsList(ParentsList);
      frmCCJSO_OrderHeaderItem.SetSlavesList(SlavesList);
      try
        frmCCJSO_OrderHeaderItem.ShowModal;
      finally
        FreeAndNil(frmCCJSO_OrderHeaderItem);
      end;
    except
      on e:Exception do begin
        ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
      end;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aJSOLink_FindCurrentOrdersExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  UserActive;
  JSOAssignHeaderItem;
  { Определяем основной родительский заказ }
  if JSOHeaderItem.NParentOrderID = 0 then begin
    JSOParentOrder := JSOHeaderItem.OrderID;
  end else begin
    DM_CCJSO.JSOGetMainParentOrder(UserSession.CurrentUser, JSOHeaderItem.OrderID, JSOParentOrder, IErr, SErr );
  end;
  { Формируем условие отбора }
  SetClearCondition;
  JSOCondRec.SignLink          := cJSOSignLink_FindCurrentOrders;
  chbxCndAccountPeriod.Checked := false;
  ExecConditionQRMain;
  ShowGets;
end;

procedure TFCCenterJournalNetZkz.aJSOLink_FindFavoritesExecute(Sender: TObject);
begin
  UserActive;
  JSOAssignHeaderItem;
  { Формируем условие отбора }
  SetClearCondition;
  JSOCondRec.SignLink := cJSOSignLink_FindFavorites;
  ExecConditionQRMain;
  ShowGets;
end;

procedure TFCCenterJournalNetZkz.aControl_AlertReadAllExecute(Sender: TObject);
begin
//
end;

procedure TFCCenterJournalNetZkz.JSOGridPayDblClick(Sender: TObject);
begin
  if aJSOPay_Edit.Enabled then begin
    aJSOPay_Edit.Execute;
  end;
end;

procedure TFCCenterJournalNetZkz.aJSOPay_ShowCheckExecute(Sender: TObject);
begin
  JSOShowPayGridCheck;
  if aJSOPay_ShowCheck.Checked then begin
    aJSOPay_ShowCheck.ImageIndex := 364;
  end else begin
    aJSOPay_ShowCheck.ImageIndex := 361;
  end;
end;

procedure TFCCenterJournalNetZkz.aJSOHist_HeaderExecute(Sender: TObject);
begin
  UserActive;
  if not qrspJSOHistory.IsEmpty then begin
    try
      { Определяем текущие значения записи }
      JSOSetRecHist;
      { Для режима чтение }
      frmCCJSO_HeaderHistory := TfrmCCJSO_HeaderHistory.Create(Self);
      frmCCJSO_HeaderHistory.SetRec(JSORecHist);
      try
        frmCCJSO_HeaderHistory.ShowModal;
      finally
        FreeAndNil(frmCCJSO_HeaderHistory);
      end;
    except
      on e:Exception do begin
        ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
      end;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.JSOGridNPostPayDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFCCenterJournalNetZkz.aMain_RP_StateOrdersDeliveryPayExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJSO_RP_StateOrdersDeliveryPay := TfrmCCJSO_RP_StateOrdersDeliveryPay.Create(Self);
    frmCCJSO_RP_StateOrdersDeliveryPay.SetRecSession(UserSession);
    try
      frmCCJSO_RP_StateOrdersDeliveryPay.ShowModal;
    finally
      FreeAndNil(frmCCJSO_RP_StateOrdersDeliveryPay);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aMainJSO_AutoDialExecute(Sender: TObject);
var
  NumbRegistered : integer;
  ActionNote     : string;
  SActionDate    : string;
  IErr           : integer;
  SErr           : string;
  CurrentDate    : string;
begin
  UserActive;
  JSOAssignHeaderItem;
  try
    CurrentDate := FormatDateTime('dd-mm-yyyy hh:nn:ss',date);
    frmCCJSO_AutoDial := TfrmCCJSO_AutoDial.Create(Self);
    frmCCJSO_AutoDial.SetRecSession(UserSession);
    frmCCJSO_AutoDial.SetPrefix(DM_CCJSO.GetPrefNumbOrderApteka911);
    { Смотрим наличие 2-х недозвонов у текущего заказа }
    if JSOHeaderItem.orderID > 0 then begin
      DM_CCJSO.JSOHistGetActionDateInfo(
                                        UserSession.CurrentUser,
                                        JSOHeaderItem.orderID,
                                        'SetCurrentOrderStatus',
                                        cModeHistGetActionDateInfo_Last,
                                        cStatus_DidNotGetThrough,
                                        NumbRegistered,
                                        SActionDate,
                                        ActionNote,
                                        IErr,
                                        SErr
                                       );
      if NumbRegistered >= 2
        then frmCCJSO_AutoDial.SetOrder(JSOHeaderItem.orderID)
        else begin
               frmCCJSO_AutoDial.SetOrder(0);
               frmCCJSO_AutoDial.SetCndDateBegin(CurrentDate);
             end;
    end else begin
      frmCCJSO_AutoDial.SetOrder(0);
      frmCCJSO_AutoDial.SetCndDateBegin(CurrentDate);
    end;
    try
      frmCCJSO_AutoDial.ShowModal;
    finally
      FreeAndNil(frmCCJSO_AutoDial);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aSetUserShowAlertExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJSO_AccessUserAlert := TfrmCCJSO_AccessUserAlert.Create(Self);
    frmCCJSO_AccessUserAlert.SetUser(UserSession.CurrentUser);
    try
      frmCCJSO_AccessUserAlert.ShowModal;
    finally
      FreeAndNil(frmCCJSO_AccessUserAlert);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
 end;
end;

procedure TFCCenterJournalNetZkz.aRefOrderStatusExecute(Sender: TObject);
begin
  UserActive;
  try
    frmReference := TfrmReference.Create(Self);
    frmReference.SetMode(cFReferenceModeShow);
    frmReference.SetReferenceIndex(cFReferenceOrderStatus);
    frmReference.SetReadOnly(cFReferenceNoReadOnly);
    try
      frmReference.ShowModal;
      ShowGets;
    finally
      frmReference.Free;
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aSubMenuExecute(Sender: TObject);
begin
//
end;

procedure TFCCenterJournalNetZkz.aRefStatusSequenceExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJSO_RefStatusSequence := TfrmCCJSO_RefStatusSequence.Create(Self);
    frmCCJSO_RefStatusSequence.SetRecSession(UserSession);
    frmCCJSO_RefStatusSequence.SetMode(cRefStatusSeqMode_Show);
    try
      frmCCJSO_RefStatusSequence.ShowModal;
      ShowGets;
    finally
      frmCCJSO_RefStatusSequence.Free;
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aMainUsersAppExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJSO_RefUsers := TfrmCCJSO_RefUsers.Create(Self);
    frmCCJSO_RefUsers.SetRecSession(UserSession);
    try
      frmCCJSO_RefUsers.ShowModal;
      ShowGets;
    finally
      frmCCJSO_RefUsers.Free;
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aAutoGenRefNomenclExecute(Sender: TObject);
begin
  UserActive;
  try
    frmAutoGenRefNomencl := TfrmAutoGenRefNomencl.Create(Self);
    frmAutoGenRefNomencl.SetRecSession(UserSession);
    frmAutoGenRefNomencl.SetMode(cFAutoGenRefNomMode_Show);
    try
      frmAutoGenRefNomencl.ShowModal;
    finally
      FreeAndNil(frmAutoGenRefNomencl);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aJournalSMSExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJSO_JournalMsgClient := TfrmCCJSO_JournalMsgClient.Create(Self);
    frmCCJSO_JournalMsgClient.SetRecSession(UserSession);
    try
      frmCCJSO_JournalMsgClient.ShowModal;
    finally
      FreeAndNil(frmCCJSO_JournalMsgClient);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aSendNotificationClientExecute(Sender: TObject);
begin
  UserActive;
  if IsActionOrder then
    ExecHistoryOrderAction('JSO_SendOrderAttr',
        '')
  else
  begin
    try
      JSOAssignHeaderItem;
      frmCCJSO_ClientNotice_PayDetails := TfrmCCJSO_ClientNotice_PayDetails.Create(Self);
      frmCCJSO_ClientNotice_PayDetails.SetRecSession(UserSession);
      frmCCJSO_ClientNotice_PayDetails.SetRecHeaderItem(JSOHeaderItem);
      frmCCJSO_ClientNotice_PayDetails.SetSection(cFSection_SiteApteka911);
      try
        frmCCJSO_ClientNotice_PayDetails.ShowModal;
      finally
        FreeAndNil(frmCCJSO_ClientNotice_PayDetails);
      end;
    except
      on e:Exception do begin
        ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
      end;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.edCndPhoneKeyPress(Sender: TObject; var Key: Char);
begin
  JSOCondRec.bSignRefPhone := false;
end;

procedure TFCCenterJournalNetZkz.aJSO_CondSlReferenceExecute(Sender: TObject);
var
  RefIndex    : integer;
  SignLargeDS : smallint;
  Tag         : integer;
  ScreenPos   : TPoint;   { вычисляемый правый нижний угол окна справочника }
  DescrSelect : string;
  RNSelect    : integer;
begin
  UserActive;
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
          ScreenPos := Point(edCndApteka.ClientOrigin.X + edCndApteka.Width, edCndApteka.ClientOrigin.Y + edCndApteka.Height);
    end;
    17: begin
          RefIndex := cFRefGenAutoPhoneClient;
          SignLargeDS := cFReferenceSignLargeDS;
          ScreenPos := Point(edCndPhone.ClientOrigin.X + edCndPhone.Width, edCndPhone.ClientOrigin.Y + edCndPhone.Height);
    end;
  end;
  ScreenPos := Point(ScreenPos.X-5,ScreenPos.Y-5);
  try
    frmReference := TfrmReference.Create(Self);
    frmReference.SetMode(cFReferenceModeSelect);
    frmReference.SetReferenceIndex(RefIndex);
    frmReference.SetReadOnly(cFReferenceYesReadOnly);
    frmReference.SetSignLargeDataSet(SignLargeDS);
    frmReference.SetScreenPos(ScreenPos);
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
        JSOCondRec.NPharmacy := RNSelect;
        edCndApteka.Text := DescrSelect;
      end;
      17: begin
        JSOCondRec.bSignRefPhone := true;
        edCndPhone.Text := DescrSelect;
      end;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.edCndAptekaKeyPress(Sender: TObject; var Key: Char);
begin
  JSOCondRec.NPharmacy := 0;
end;

procedure TFCCenterJournalNetZkz.aJSO_CondSlNomenclatureExecute(Sender: TObject);
var
  Tag         : integer;
  ScreenPos   : TPoint;   { вычисляемый правый нижний угол окна справочника }
  DescrSelect : string;
  RNSelect    : integer;
begin
  UserActive;
  DescrSelect := '';
  RNSelect    := 0;
  Tag         := 0;
  if      Sender is TAction then Tag := (Sender as TAction).ActionComponent.Tag
  else if Sender is TEdit   then Tag := (Sender as TEdit).Tag;
  case Tag of
    21: ScreenPos := Point(edCndArtCode.ClientOrigin.X + 15,edCndArtCode.ClientOrigin.Y + edCndArtCode.Height + 10);
    22: ScreenPos := Point(edCndItemName.ClientOrigin.X + 15,edCndItemName.ClientOrigin.Y + edCndItemName.Height + 10);
  end;
  try
    frmAutoGenRefNomencl := TfrmAutoGenRefNomencl.Create(Self);
    frmAutoGenRefNomencl.SetMode(cFAutoGenRefNomMode_Select);
    frmAutoGenRefNomencl.SetRecSession(UserSession);
    frmAutoGenRefNomencl.SetScreenPos(ScreenPos);
    try
      frmAutoGenRefNomencl.ShowModal;
      if frmAutoGenRefNomencl.GetSignSelect then begin
        DescrSelect := frmAutoGenRefNomencl.GetArtName;
        RNSelect    := frmAutoGenRefNomencl.GetArtCode;
        edCndArtCode.Text := IntToStr(RNSelect);
        edCndItemName.Text := DescrSelect;
      end;
    finally
      FreeAndNil(frmAutoGenRefNomencl);
    end;
  except
  end;
end;

procedure TFCCenterJournalNetZkz.aJSOSlave_DefOrderItemsExecute(Sender: TObject);
begin
  UserActive;
  JSOAssignHeaderItem;
  try
    frmCCJO_DefOrderItems := TfrmCCJO_DefOrderItems.Create(Self);
    frmCCJO_DefOrderItems.SetMode(cDefOrderItems_Mode_DefItems);
    frmCCJO_DefOrderItems.SetSource(cDefOrderItems_Source_911);
    frmCCJO_DefOrderItems.SetUserSession(UserSession);
    frmCCJO_DefOrderItems.SetRecJSOHeader(JSOHeaderItem);
    try
      frmCCJO_DefOrderItems.ShowModal;
    finally
      FreeAndNil(frmCCJO_DefOrderItems);
    end;
  except
  end;
end;

procedure TFCCenterJournalNetZkz.aRemainsExecute(Sender: TObject);
begin
  UserActive;
  try
    frmCCJO_DefOrderItems := TfrmCCJO_DefOrderItems.Create(Self);
    frmCCJO_DefOrderItems.SetMode(cDefOrderItems_Mode_Remains);
    frmCCJO_DefOrderItems.SetUserSession(UserSession);
    try
      frmCCJO_DefOrderItems.ShowModal;
    finally
      FreeAndNil(frmCCJO_DefOrderItems);
    end;
  except
  end;
end;

procedure TFCCenterJournalNetZkz.JSOGridTransactionDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  Self.PhaseDrawColumnCell(Sender, Rect, DataCol, Column, State);
end;

procedure TFCCenterJournalNetZkz.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F5 then
  begin
    if pgcJSO_JBO.ActivePage = tabPharmReserve then
      PharmReserveGrid.RefreshData;
  end;
end;

procedure TFCCenterJournalNetZkz.aCloseReservingQueueExecute(
  Sender: TObject);
var
  MsgCurrent : string;
  IGenID     : integer;
  IErr       : integer;
  SErr       : string;
begin
  if not qrMain.IsEmpty then
  begin
    { Начальная инициализация действия }
    MsgCurrent := 'Дата заказа: ' + AsString(OrderHeaderDS, 'OrderDt') + chr(10) +
                  'Аптека: '      + OrderHeaderDS.FieldByName('Apteka').AsString + chr(10) +
                  'Клиент: '      + OrderHeaderDS.FieldByName('orderShipName').AsString;
    if MessageDLG('Убрать из очереди на резервирования?' + chr(10) + MsgCurrent, mtConfirmation, [mbYes,mbNo], 0) = mrYes then
    begin
      dmJSO.RemoveOrderFromReserveQueue(OrderHeaderDS.FieldByName('orderID').AsInteger,
        Form1.id_user);
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aActionExecute(Sender: TObject);
var
  vOrder: Integer;
  vBpId: Integer;
  vSubItemId: Integer;
begin
  if not qrMain.IsEmpty then
  begin
    vOrder := OrderHeaderDS.FieldByName('orderID').AsInteger;
    vBPId := OrderHeaderDS.FieldByName('BpId').AsInteger;
    JSOAssignHeaderItem;
    JSOAssignRecItem;
    if not pnlSlave_OrderGrid_Distrib.Visible then
      vSubItemId := 0
    else
      vSubItemId := DBGridSlaveDistrib.DataSource.DataSet.FieldByName('NRN').AsInteger;
    if TActionDlg.Execute(vOrder, vBPId, RegAction.NUser, JSOHeaderItem, UserSession, JSORecItem, vSubItemId) then
    begin
      GridSlaveRefresh;
      GridMainRefresh;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.aBPSpecRefExecute(Sender: TObject);
var
  vDlg: TfmBPSpecRef;
begin
  vDlg := TfmBPSpecRef.Create(Self);
  try
    vDlg.ShowModal;
  finally
    vDlg.Free;
  end;
end;

procedure TFCCenterJournalNetZkz.miExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFCCenterJournalNetZkz.miSQLClick(Sender: TObject);
begin
  ShowMessage(qrMain.SQL.Text);
end;

procedure TFCCenterJournalNetZkz.aMain_RefreshExecute(Sender: TObject);
begin
  if pgcJSO_JBO.ActivePage.Name = 'tabJSO' then begin
    { Версия }
    //ShowVersion;
    { Обновляем данные }
    GridMainRefresh;
    ShowGets;
  end;
end;

procedure TFCCenterJournalNetZkz.aSyncStatusPayExecute(Sender: TObject);
begin
  if (AnsiUpperCase(Trim(OrderHeaderDS.FieldByName('orderPayment').AsString)) = 'PAYMASTER') then
    dmJSO.AddOrderIntoSyncStatusPay(OrderHeaderDS.FieldByName('orderID').AsInteger,
          Form1.id_user,
          OrderHeaderDS.FieldByName('ExtSystem').AsInteger,
          OrderHeaderDS.FieldByName('orderPayment').AsString)
  else
    UtilsBase.ShowError('Нет синхронизация статуса оплаты для заказов с типом оплаты ' +
      OrderHeaderDS.FieldByName('orderPayment').AsString);
end;

{ Sprint }
function TFCCenterJournalNetZkz.IsActionOrder: Boolean;
var
  vBpId: Integer;
  vExecSign: Integer;
begin
  Result := False;
  if not qrMain.IsEmpty then
  begin
    vBPId := OrderHeaderDS.FieldByName('BpId').AsInteger;
    vExecSign := OrderHeaderDS.FieldByName('ExecSign').AsInteger;
    Result := (vBPId in [1, 2, 3, 5]) or ((vBPId = 4) and (vExecSign = 1));
  end;
end;

//Выполнение Action ч/з механизм Действия (с записью в историю)
procedure TFCCenterJournalNetZkz.ExecHistoryOrderAction(ActionName: string;
   ConfirmMessage: string; ReserveType: TReserveType = rtNone;
   IsOrderSpecAction: Boolean = false);
var
  vOrder: Integer;
  vBpId: Integer;
  vSubItemId: Integer;
  vSrcBasis: Integer;
  vResBasis: Integer;
begin
  vSrcBasis := TActionCore.GetActionDefSrcBasis(ActionName);
  vResBasis := TActionCore.GetActionDefResBasis(ActionName);

  if not qrMain.IsEmpty and
     ((ConfirmMessage = '') or
     (MessageDLG(ConfirmMessage, mtConfirmation, [mbYes, mbNo], 0) = mrYes)) then
  begin
    vOrder := OrderHeaderDS.FieldByName('orderID').AsInteger;
    vBPId := OrderHeaderDS.FieldByName('BpId').AsInteger;
    JSOAssignHeaderItem;
    JSOAssignRecItem;
    if not pnlSlave_OrderGrid_Distrib.Visible then
      vSubItemId := 0
    else
      vSubItemId := DBGridSlaveDistrib.DataSource.DataSet.FieldByName('NRN').AsInteger;
    if TActionDlg.Execute(vOrder, vBPId, RegAction.NUser, JSOHeaderItem, UserSession, JSORecItem, vSubItemId,
      ActionName, vSrcBasis, vResBasis, ReserveType) then
    begin
      GridSlaveRefresh;
      if not IsOrderSpecAction then
        GridMainRefresh;
    end;
  end;
end;

function TFCCenterJournalNetZkz.CanEditOrder(ActionCode: string; var ErrMsg: string): Boolean;
var
  vOrder: Integer;
begin
  ErrMsg := '';
  vOrder := OrderHeaderDS.FieldByName('orderID').AsInteger;
  Result := dmJSO.CanDoOrderAction(vOrder, ActionCode, ErrMsg);
end;

procedure TFCCenterJournalNetZkz.btnUserFilterClick(Sender: TObject);
var
  vDS: TsprQuery;
  vKeyValue: Variant;
  vValue: Variant;
begin
  vDS := dmJSO.CreateUsers;
  try
    vDS.Active := true;
    vKeyValue := JSOCondRec.OperatorId;
    if TsprGridFrm.Select(TsprGridFrm, vDS, 'row_id', 'Name_User', vKeyValue, vValue) then
    begin
      JSOCondRec.OperatorId := vKeyValue;
      edUserFilter.Text := VarToStr(vValue);
    end;
  finally
    vDS.Free;
  end;
end;

procedure TFCCenterJournalNetZkz.ApplyMOrderFilter;
begin
  FMainFilterState := mfsOrderId;
  if Length(Trim(edOrder.Text)) = 0 then
  begin
    ClearMainFilter(True);
    ExecConditionQRMain;
  end
  else
  begin
    ClearMainFilter(False);
    if Length(Trim(edOrder.Text)) < 5 then
      ShowError('Фильтр по номеру заказа должен содержать более 5 цифр')
    else
    begin
      SaveMainFilter;
      ExecConditionQRMain;
    end;
  end;
end;

procedure TFCCenterJournalNetZkz.edOrderKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    ApplyMOrderFilter;
end;

procedure TFCCenterJournalNetZkz.ClearMainFilter(DoClearFilterState: Boolean = True);
begin
  if DoClearFilterState then
    FMainFilterState := mfsNone;

  if FMainFilterState <> mfsOrderId then
  begin
    edOrder.Text := '';
    FMainFilter.OrderId := '';
  end;
  if FMainFilterState <> mfsCond then
  begin
    cbCond.KeyValue := Null;
    FMainFilter.CondId := Unassigned;
  end;
  if FMainFilterState <> mfsArtCode then
  begin
    edArtCode.Text := '';
    FMainFilter.ArtCode := '';
  end;
end;

procedure TFCCenterJournalNetZkz.SaveMainFilter;
begin
  FMainFilter.OrderId := trim(edOrder.Text);
  FMainFilter.CondId := cbCond.KeyValue;
  FMainFilter.ArtCode := trim(edArtCode.Text);
end;

procedure TFCCenterJournalNetZkz.cbCondCloseUp(Sender: TObject);
begin
  FMainFilterState := mfsCond;
  ClearMainFilter(False);
  if VarIsAssigned(cbCond.KeyValue) then
  begin
    SaveMainFilter;
    ExecConditionQRMain;
  end;
end;

procedure TFCCenterJournalNetZkz.JSOControlKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    Self.ReBuildJSOCond;
end;

procedure TFCCenterJournalNetZkz.JSODateCloseUp(Sender: TObject);
begin
  Self.ReBuildJSOCond;
end;

procedure TFCCenterJournalNetZkz.aCheckReserveExecute(Sender: TObject);
begin
  if IsActionOrder then
    ExecHistoryOrderAction('JSO_CheckReserve', '');
end;

procedure TFCCenterJournalNetZkz.miJournalXLSClick(Sender: TObject);
var
  vExporter: TEQDBxlExport;
begin
  vExporter := TEQDBxlExport.Create(nil);
  try
    vExporter.DataSet := qrspJCallMain;
    vExporter.DBGrid := JCallGridMain;
    vExporter.StartExport;
  finally
    vExporter.Free;
  end;
end;

procedure TFCCenterJournalNetZkz.wmFilterOrdersEvent(var msg : TMessage);
var
 IErr : integer;
 SErr : string;
 vPCond: PJSO_Condition;
 vCond: TJSO_Condition;
begin
  IJSOSignMassChangeCondition := 1;
  try
    SetClearCondition;
    if JSOCondIdent <> 0 then begin
      DM_CCJSO.SLClear(JSOCondIdent,IErr,SErr);
      JSOCondIdent := 0;
    end;
    pgctrlCondition.ActivePage := tabJournal;
    vPCond :=  PJSO_Condition(msg.LParam);
    vCond := vPCond^;
    dispose(vPCond);
    edOrder.Text := vCond.SOrderID;
    Self.ApplyMOrderFilter;
    IJSOSignMassChangeCondition := 0;
    ShowGets;
  finally
    IJSOSignMassChangeCondition := 0;
  end;
end;

function TFCCenterJournalNetZkz.GetIP: string;
var
  s: string;
  L: TStringList;
  I, J: Integer;
const
  vMask: array[0..1] of string = ('.104.', '.107.');
begin
  s := Util.GetLocalIPs(',');
  L := TStringList.Create;
  L.CommaText := s;
  Result := '';
  for J := 0 to Length(vMask) - 1 do
  begin
    for I := 0 to L.Count - 1 do
      if pos(vMask[J], L.Strings[I]) > 0 then
      begin
        Result := L.Strings[I];
        break;
      end;
    if Result = '' then
      break;
  end;
  if Result = '' then
    Result := UserSession.LocalIP;
  if Result = '' then
    Result := LoacalIdIPWatch.LocalIP;  
end;

procedure TFCCenterJournalNetZkz.aClipBoard_MPhoneExecute(Sender: TObject);
begin
  ClipBoard.AsText := OrderHeaderDS.FieldByName('MPhone').AsString;
end;

procedure TFCCenterJournalNetZkz.miIPClick(Sender: TObject);
begin
  ShowMessage(Util.GetLocalIPs(#13#10));
end;

procedure TFCCenterJournalNetZkz.aClientRefExecute(Sender: TObject);
var
  vDlg: TfmClientRef;
begin
  vDlg := TfmClientRef.Create(Self);
  try
    vDlg.ShowModal;
  finally
    vDlg.Free;
  end;
end;

procedure TFCCenterJournalNetZkz.edArtCodeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    ApplyMArtCodeFilter;
end;

procedure TFCCenterJournalNetZkz.ApplyMArtCodeFilter;
begin
  FMainFilterState := mfsArtCode;
  if Length(Trim(edArtCode.Text)) = 0 then
  begin
    ClearMainFilter(True);
    ExecConditionQRMain;
  end
  else
  begin
    ClearMainFilter(False);
    SaveMainFilter;
    ExecConditionQRMain;
  end;
end;

function TFCCenterJournalNetZkz.GetCompName: string;
begin
  Result := GetComputerName;
end;

function GetComputerName: string;

  function GetEnvVarValue(const VarName: string): string;
  var
    BufSize: Integer;
  begin
    // Get required buffer size (inc. terminal #0)
    BufSize := GetEnvironmentVariable(PChar(VarName), nil, 0);
    if BufSize > 0 then
    begin
      // Read env var value into result string
      SetLength(Result, BufSize - 1);
      GetEnvironmentVariable(PChar(VarName),
        PChar(Result), BufSize);
    end
    else
      // No such environment variable
      Result := '';
  end;
begin
  Result := GetEnvVarValue('CLIENTNAME');
  if Result = '' then
    Result := GetEnvVarValue('COMPUTERNAME');
end;

procedure TFCCenterJournalNetZkz.miIPTelMapRefClick(Sender: TObject);
var
  vDlg: TfmIPTelMapRef;
begin
  vDlg := TfmIPTelMapRef.Create(Self);
  try
    vDlg.ShowModal;
  finally
    vDlg.Free;
  end;
end;

procedure TFCCenterJournalNetZkz.miAppealClick(Sender: TObject);
var
  vDlg: TfmSprRef;
begin
  vDlg := TfmSprRef.Create(Self, TsprGridFrm, dmJSO.CreateAppeal, 'Обращения', False);
  try
    vDlg.ShowModal;
  finally
    vDlg.Free;
  end;
end;

procedure TFCCenterJournalNetZkz.aFilterOrdersByPhoneExecute(
  Sender: TObject);
var
  vCond: TJSO_Condition;
  vPCond: PJSO_Condition;
begin
  inherited;
  new(vPCond);
  vPCond.SOrderId := OrderHeaderDS.FieldByName('MPhone').AsString;
{  vCond.MPhone := FPhone;
  vCond.SignAccountPeriod := False; }
  SendMessage(FCCenterJournalNetZkz.Handle, WM_FilterOrdersEvent, 0, Integer(vPCond));
  Application.ProcessMessages;
end;

procedure TFCCenterJournalNetZkz.AppMessage(var Msg: TMsg; var Handled:Boolean);
var
  i: SmallInt;
begin
  if Msg.Message = WM_MOUSEWHEEL then
  begin
    Msg.Message := WM_KEYDOWN;
    Msg.lParam := 0;
    i := HiWord(Msg.wParam);
    if i > 0 then
      Msg.wParam := VK_UP
    else
      Msg.wParam := VK_DOWN;
    Handled := False;
  end;
end;

{procedure TFCCenterJournalNetZkz.WMSysCommand(var Msg: TWMSysCommand);
begin
  if Msg.CmdType = SC_MINIMIZE then
    ShowWindow(Handle, SW_MINIMIZE)
  else
    inherited;
end;

procedure TFCCenterJournalNetZkz.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    ExStyle := ExStyle or WS_EX_APPWINDOW;
    WndParent := GetDesktopWindow;
  end;
end;

procedure TFCCenterJournalNetZkz.ApplicationActivate(Sender: TObject);
var
  TopWindow: HWND;
  I: Integer;
begin
  TopWindow := 0;
  for I := 0 to Screen.FormCount - 1 do
  begin
    Screen.Forms[I].BringToFront;
    if fsModal in Screen.Forms[I].FormState then
      TopWindow := Screen.Forms[I].Handle;
  end;
  Application.RestoreTopMosts;
  if TopWindow = 0 then
    Application.BringToFront
  else
    SetForegroundWindow(TopWindow);
end; }

end.
