unit CCJSO_DM;

interface

uses
  SysUtils, Classes, UMAIN, DB, ADODB,
  {--}
  UCCenterJournalNetZkz;

type TJSORecHist = record
  NRN                 : integer;
  NPRN                : integer;
  SUnitCode           : string;
  SUnitName           : string;
  SUnitTable          : string;
  SActionCode         : string;
  SActionName         : string;
  NUSER               : integer;
  SUser               : string;
  DBeginDate          : TDateTime;
  SBeginDate          : string;
  DEndDate            : TDateTime;
  SEndDate            : string;
  NOrder              : integer;
  NBell               : integer;
  SActionFoundation   : string;
  SDriver             : string;
  NDriver             : integer;
  SNOTE               : string;
  IAllowBeOpen        : integer;
  WaitingTimeMinute   : integer;
end;

type TJSORecHist_GetActionInfo = record
  NumbRegistered : integer;
  ActionNote     : string;
  SActionDate    : string;
end;

type
  TDM_CCJSO = class(TDataModule)
    spJSOParentsList: TADOStoredProc;
    spJSOSlavesList: TADOStoredProc;
    spGetMainParentOrder: TADOStoredProc;
    spClearLinkParents: TADOStoredProc;
    spClearLinkSlaves: TADOStoredProc;
    spdsLinkOrdersList: TADOStoredProc;
    spSelectList_Insert: TADOStoredProc;
    spSelectList_Clear: TADOStoredProc;
    spdsGetHeader: TADOStoredProc;
    spdsSelectList: TADOStoredProc;
    spBlackListInsert: TADOStoredProc;
    spBlackListClose: TADOStoredProc;
    spGetParm: TADOStoredProc;
    spJSOHistGetActionDateInfo: TADOStoredProc;
    spException: TADOStoredProc;
    spGetSignCOD: TADOStoredProc;
    spCalcCDO: TADOStoredProc;
    spJSOCreateListSelectBetweenDate: TADOStoredProc;
    spItemDel: TADOStoredProc;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    UserParmApteka911PrefixNumberOrder   : string;
    UserParmIAptekaPrefixNumberOrder     : string;
    UserParmManualPrefixNumberOrder      : string;
    UserParmTradePointPrefixNumberOrder  : string;
    UserParmCodeDetailsPrePaymentCourier : string;
    procedure GetUserParm(Parm : string; USER : integer; var TypeCode : string; var SVal : string; var IErr : integer; var SErr : string);
  public
    { Public declarations }
    procedure JSOParentsList(NUser : integer; OrderID : integer; var ParentsList : string; var IErr : integer; var SErr : string);
    procedure JSOSlavesList(NUser : integer; OrderID : integer; var SlavesList : string; var IErr : integer; var SErr : string);
    procedure JSOGetMainParentOrder(NUser : integer; OrderID : integer; var MainParentOrder : integer; var IErr : integer; var SErr : string);
    procedure JSOClearLinkParents(NUser : integer; OrderID : integer; Mode : boolean; var IErr : integer; var SErr : string);
    procedure JSOClearLinkSlaves(NUser : integer; OrderID : integer; Mode : boolean; var IErr : integer; var SErr : string);
    procedure SLInert(IdAction : longint; UnitCode : string; PRN : integer; BigPRN : longint; USER : integer; var IErr : integer; var SErr : string);
    procedure SLClear(IdAction : longint; var IErr : integer; var SErr : string);
    procedure GetRecHeader(Order : integer; var RecHeader : TJSO_OrderHeaderItem; var IErr : integer; var SErr : string);
    procedure BlackListInsert(User : integer; Order : integer; Note : string; var IErr : integer; var SErr : string);
    procedure BlackListClose(User : integer; Order : integer; Note : string; var IErr : integer; var SErr : string);
    procedure InitParmCustomerOrders(USER : integer);
    procedure GetVersion(USER : integer; var TypeCode : string; var SVal : string; var IErr : integer; var SErr : string);
    procedure JSOHistGetActionDateInfo(USER : integer; Order : integer; ActionCode : string; Mode : boolean; FindNote : string; var NumbRegistered : integer; var SActionDate : string; var Note : string; var IErr : integer; var SErr : string);
    procedure InitRecHistInfo(var RecHistInfo : TJSORecHist_GetActionInfo);
    procedure RegException(SignRaisError : smallint; NameProc : string; ErrorNumber : integer; ErrorMessage : string; NUSER : integer; StepNote : string; AllNote : string);
    procedure CalcCDO(USER : integer; Amount : double; var COD : currency; var RuleCalc : string; var IErr : integer; var SErr : string);
    procedure JSOCreateListSelectBetweenDate(NUser : integer; IDENT : longint; DateBegin : string; DateEnd : string);
    function  GetSignCOD(USER : integer; Payment : string) : boolean;
    function  GetDFormatSet : TFormatSettings;
    function  GetPrefNumbOrderApteka911       : string;
    function  GetPrefNumbOrderIApteka         : string;
    function  GetPrefNumbOrderManual          : string;
    function  GetPrefNumbOrderTradePoint      : string;
    function  GetCodeDetailsPrePaymentCourier : string;
  end;

const
  cModeHistGetActionDateInfo_First = false;
  cModeHistGetActionDateInfo_Last  = true;
const
  cStatus_GoodsReady          = 'Заказ собран и готов к отправке';
  cStatus_DidNotGetThrough    = 'Недозвон';
  cStatus_MakeCallClient      = 'Выполнен звонок клиенту';
  cStatus_AgreedDTAofDelivery = 'По заказу согласованна дата, время и адрес доставки';
const
  cOrderShipping_ExpressDelivery = 'Курьерская доставка';
  cOrderShipping_NovaPoshta      = 'Новая почта';

var
  DM_CCJSO: TDM_CCJSO;
var
  JSORecHist : TJSORecHist;

implementation

uses Dialogs;

{$R *.dfm}


procedure TDM_CCJSO.DataModuleCreate(Sender: TObject);
begin
  { Инициализация пользовательских параметров }
  UserParmApteka911PrefixNumberOrder  := '';
  UserParmIAptekaPrefixNumberOrder    := '';
  UserParmManualPrefixNumberOrder     := '';
  UserParmTradePointPrefixNumberOrder := '';
end;

procedure TDM_CCJSO.JSOParentsList(NUser : integer; OrderID : integer; var ParentsList : string; var IErr : integer; var SErr : string);
begin
  IErr := 0;
  SErr := '';
  ParentsList := '';
  try
    spJSOParentsList.Parameters.ParamValues['@USER']    := NUser;
    spJSOParentsList.Parameters.ParamValues['@OrderID'] := OrderID;
    spJSOParentsList.ExecProc;
    IErr := spJSOParentsList.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      ParentsList := spJSOParentsList.Parameters.ParamValues['@ParentsList'];
    end else begin
      SErr := spJSOParentsList.Parameters.ParamValues['@SErr'];
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
    end;
  end;
end;

procedure TDM_CCJSO.JSOSlavesList(NUser : integer; OrderID : integer; var SlavesList : string; var IErr : integer; var SErr : string);
begin
  IErr := 0;
  SErr := '';
  SlavesList := '';
  try
    spJSOSlavesList.Parameters.ParamValues['@USER']    := NUser;
    spJSOSlavesList.Parameters.ParamValues['@OrderID'] := OrderID;
    spJSOSlavesList.ExecProc;
    IErr := spJSOSlavesList.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      SlavesList := spJSOSlavesList.Parameters.ParamValues['@SlavesList'];
    end else begin
      SErr := spJSOSlavesList.Parameters.ParamValues['@SErr'];
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
    end;
  end;
end;

procedure TDM_CCJSO.JSOGetMainParentOrder(NUser : integer; OrderID : integer; var MainParentOrder : integer; var IErr : integer; var SErr : string);
begin
  IErr := 0;
  SErr := '';
  MainParentOrder := 0;
  try
    spGetMainParentOrder.Parameters.ParamValues['@USER']  := NUser;
    spGetMainParentOrder.Parameters.ParamValues['@Order'] := OrderID;
    spGetMainParentOrder.ExecProc;
    IErr := spGetMainParentOrder.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      MainParentOrder := spGetMainParentOrder.Parameters.ParamValues['@MainParentOrder'];
    end else begin
      SErr := spGetMainParentOrder.Parameters.ParamValues['@SErr'];
      MainParentOrder := -1;
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
      MainParentOrder := -1;
    end;
  end;
end;

procedure TDM_CCJSO.JSOClearLinkParents(NUser : integer; OrderID : integer; Mode : boolean; var IErr : integer; var SErr : string);
begin
  IErr := 0;
  SErr := '';
  try
    spClearLinkParents.Parameters.ParamValues['@USER']  := NUser;
    spClearLinkParents.Parameters.ParamValues['@Order'] := OrderID;
    spClearLinkParents.Parameters.ParamValues['@Mode']  := Mode;
    spClearLinkParents.ExecProc;
    IErr := spClearLinkParents.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
    end else begin
      SErr := spClearLinkParents.Parameters.ParamValues['@SErr'];
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
    end;
  end;
end;

procedure TDM_CCJSO.JSOClearLinkSlaves(NUser : integer; OrderID : integer; Mode : boolean; var IErr : integer; var SErr : string);
begin
  IErr := 0;
  SErr := '';
  try
    spClearLinkSlaves.Parameters.ParamValues['@USER']  := NUser;
    spClearLinkSlaves.Parameters.ParamValues['@Order'] := OrderID;
    spClearLinkSlaves.Parameters.ParamValues['@Mode']  := Mode;
    spClearLinkSlaves.ExecProc;
    IErr := spClearLinkSlaves.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
    end else begin
      SErr := spClearLinkSlaves.Parameters.ParamValues['@SErr'];
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
    end;
  end;
end;

procedure TDM_CCJSO.SLInert(IdAction : longint; UnitCode : string; PRN : integer; BigPRN : longint; USER : integer; var IErr : integer; var SErr : string);
begin
  IErr := 0;
  SErr := '';
  try
    spSelectList_Insert.Parameters.ParamValues['@IDENT']     := IdAction;
    spSelectList_Insert.Parameters.ParamValues['@SUnitCode'] := UnitCode;
    spSelectList_Insert.Parameters.ParamValues['@PRN']       := PRN;
    spSelectList_Insert.Parameters.ParamValues['@BigPRN']    := BigPRN;
    spSelectList_Insert.Parameters.ParamValues['@USER']      := USER;
    spSelectList_Insert.ExecProc;
    IErr := spSelectList_Clear.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then SErr := spSelectList_Clear.Parameters.ParamValues['@SErr'];
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
    end;
  end;
end;

procedure TDM_CCJSO.SLClear(IdAction : longint; var IErr : integer; var SErr : string);
begin
  IErr := 0;
  SErr := '';
  try
    spSelectList_Clear.Parameters.ParamValues['@IDENT'] := IdAction;
    spSelectList_Clear.ExecProc;
    IErr := spSelectList_Clear.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then SErr := spSelectList_Clear.Parameters.ParamValues['@SErr'];
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
    end;
  end;
end;

procedure TDM_CCJSO.GetRecHeader(Order : integer; var RecHeader : TJSO_OrderHeaderItem; var IErr : integer; var SErr : string);
begin
  try
    if spdsGetHeader.Active then spdsGetHeader.Active := False;
    spdsGetHeader.Parameters.ParamValues['@Order'] := Order;
    spdsGetHeader.Open;
    spdsGetHeader.First;
    while not spdsGetHeader.Eof do begin
      RecHeader.orderID              := spdsGetHeader.FieldByName('orderID').AsInteger;
      RecHeader.SorderID             := spdsGetHeader.FieldByName('SorderID').AsString;
      //RecHeader.LinkIdDocBell        := spdsGetHeader.FieldByName('LinkIdDocBell').AsInteger;  { Связь со звонком }
      //RecHeader.ISignBell            := spdsGetHeader.FieldByName('ISignBell').AsInteger;      { Признак, что звонили }
      RecHeader.SSignBell            := spdsGetHeader.FieldByName('SSignBell').AsString;       { Да - '' }
      RecHeader.orderAmount          := spdsGetHeader.FieldByName('orderAmount').AsCurrency;   { Сумма заказа }
      RecHeader.NOrderAmountShipping := spdsGetHeader.FieldByName('NOrderAmountShipping').AsCurrency;   { + Сумма }
      RecHeader.orderCurrency        := spdsGetHeader.FieldByName('orderCurrency').AsString;   { Валюта }
      RecHeader.orderShipping        := spdsGetHeader.FieldByName('orderShipping').AsString;   { Вид доставки }
      RecHeader.orderPayment         := spdsGetHeader.FieldByName('orderPayment').AsString;    { Вид оплаты }
      RecHeader.orderEmail           := spdsGetHeader.FieldByName('orderEmail').AsString;
      RecHeader.orderPhone           := spdsGetHeader.FieldByName('orderPhone').AsString;
      RecHeader.orderShipName        := spdsGetHeader.FieldByName('orderShipName').AsString;
      RecHeader.orderShipStreet      := spdsGetHeader.FieldByName('orderShipStreet').AsString;
      RecHeader.SOrderDt             := spdsGetHeader.FieldByName('SOrderDt').AsString;
      RecHeader.aptekaID             := spdsGetHeader.FieldByName('aptekaID').AsString;
      RecHeader.ID_IPA_DhRes         := spdsGetHeader.FieldByName('ID_IPA_DhRes').AsString;
      RecHeader.IStateArmour         := spdsGetHeader.FieldByName('IStateArmour').AsInteger;   { f_jso_GetNameStateArmor - 0 - Не забронировано, 1 - Забронировано, 2 - Частично забронировано }
      RecHeader.SCreateDate          := spdsGetHeader.FieldByName('SCreateDate').AsString;
      RecHeader.Apteka               := spdsGetHeader.FieldByName('Apteka').AsString;
      RecHeader.NUser                := spdsGetHeader.FieldByName('NUser').AsInteger;
      RecHeader.SUser                := spdsGetHeader.FieldByName('SUser').AsString;
      RecHeader.SBellDate            := spdsGetHeader.FieldByName('SSMSDate').AsString;              { маркер времени звонка }
      RecHeader.SSMSDate             := spdsGetHeader.FieldByName('SSMSDate').AsString;              { маркер времени СМС }
      RecHeader.SPayDate             := spdsGetHeader.FieldByName('SPayDate').AsString;              { маркер времни платежа }
      RecHeader.SAssemblingDate      := spdsGetHeader.FieldByName('SAssemblingDate').AsString;       { маркер времени сборки }
      RecHeader.DAssemblingDate      := spdsGetHeader.FieldByName('DAssemblingDate').AsDateTime;     { маркер времени сборки }
      RecHeader.SDispatchDeclaration := spdsGetHeader.FieldByName('SDispatchDeclaration').AsString;  { № декларации }
      RecHeader.SNote                := spdsGetHeader.FieldByName('SNote').AsString;                 { примечание курьер }
      RecHeader.SCloseDate           := spdsGetHeader.FieldByName('SCloseDate').AsString;
      RecHeader.IStateConnection     := spdsGetHeader.FieldByName('IStateConnection').AsInteger;     { 2 - нет связи с аптекой - фиксируется при резервировании }
      RecHeader.SOrderStatus         := spdsGetHeader.FieldByName('SOrderStatus').AsString;          { дата + статус }
      RecHeader.SOrderComment        := spdsGetHeader.FieldByName('SOrderComment').AsString;         { Примечание (клиент) }
      RecHeader.SExport1CDate        := spdsGetHeader.FieldByName('SExport1CDate').AsString;
      RecHeader.ISignNew             := spdsGetHeader.FieldByName('ISignNew').AsInteger;             { Признак нового заказа 0 - сброшено (заказ не требует ручной обработки), 1 - новый заказа, 2 - заказ обработан }
      RecHeader.SStatusName          := spdsGetHeader.FieldByName('SStatusName').AsString;           { Наименование статуса заказа }
      RecHeader.NGeoGroupPharm       := spdsGetHeader.FieldByName('NGeoGroupPharm').AsInteger;
      RecHeader.SGroupPharmName      := spdsGetHeader.FieldByName('SGroupPharmName').AsString;
      RecHeader.NMarkRN              := spdsGetHeader.FieldByName('NMarkRN').AsInteger;              { ссылка t_jso_MyOrder }
      RecHeader.SMarkDate            := spdsGetHeader.FieldByName('SMarkDate').AsString;
      RecHeader.NMarkUser            := spdsGetHeader.FieldByName('NMarkUser').AsInteger;
      RecHeader.SMarkUser            := spdsGetHeader.FieldByName('SMarkUser').AsString;
      RecHeader.SOrderShipCity       := spdsGetHeader.FieldByName('SOrderShipCity').AsString;        { город }
      RecHeader.SOrderStatusDate     := spdsGetHeader.FieldByName('SOrderStatusDate').AsString;
      RecHeader.SNameDriver          := '';
      RecHeader.SDriverDate          := '';
      RecHeader.SNPOST_StateName     := spdsGetHeader.FieldByName('SNPOST_StateName').AsString;
      RecHeader.SNPOST_StateDate     := spdsGetHeader.FieldByName('SNPOST_StateDate').AsString;
      RecHeader.NParentOrderID       := spdsGetHeader.FieldByName('NParentOrderID').AsInteger;
      spdsGetHeader.Next;
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
    end;
  end;
end;

procedure TDM_CCJSO.BlackListInsert(User : integer; Order : integer; Note : string; var IErr : integer; var SErr : string);
begin
  IErr := 0;
  SErr := '';
  try
    spBlackListInsert.Parameters.ParamValues['@USER'] := User;
    spBlackListInsert.Parameters.ParamValues['@Order'] := Order;
    spBlackListInsert.Parameters.ParamValues['@Note'] := Note;
    spBlackListInsert.ExecProc;
    IErr := spBlackListInsert.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
       SErr := spBlackListInsert.Parameters.ParamValues['@SErr'];
       ShowMessage(SErr);
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      ShowMessage(SErr);
      IErr := -1;
    end;
  end;
end;

procedure TDM_CCJSO.BlackListClose(User : integer; Order : integer; Note : string; var IErr : integer; var SErr : string);
begin
  IErr := 0;
  SErr := '';
  try
    spBlackListClose.Parameters.ParamValues['@USER'] := User;
    spBlackListClose.Parameters.ParamValues['@Order'] := Order;
    spBlackListClose.Parameters.ParamValues['@Note'] := Note;
    spBlackListClose.ExecProc;
    IErr := spBlackListClose.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
       SErr := spBlackListClose.Parameters.ParamValues['@SErr'];
       ShowMessage(SErr);
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      ShowMessage(SErr);
      IErr := -1;
    end;
  end;
end;

procedure TDM_CCJSO.GetUserParm(Parm : string; USER : integer; var TypeCode : string; var SVal : string; var IErr : integer; var SErr : string);
begin
  try
    spGetParm.Parameters.ParamValues['@CodeParm'] := Parm;
    spGetParm.Parameters.ParamValues['@USER'] := USER;
    spGetParm.ExecProc;
    IErr := spGetParm.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      TypeCode := spGetParm.Parameters.ParamValues['@TypeCode'];
      SVal := spGetParm.Parameters.ParamValues['@SVal'];
    end else begin
      SErr := spGetParm.Parameters.ParamValues['@SErr'];
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
    end;
  end;
end;

procedure TDM_CCJSO.InitParmCustomerorders(USER : integer);
var
  TypeCode : string;
  IErr     : integer;
  SErr     : string;
begin
  GetUserParm('JSO_PrefixNumberOrder',User,TypeCode,UserParmApteka911PrefixNumberOrder,IErr,SErr);
  GetUserParm('IPharm_PrefixNumberOrder',User,TypeCode,UserParmIAptekaPrefixNumberOrder,IErr,SErr);
  GetUserParm('Manual_PrefixNumberOrder',User,TypeCode,UserParmManualPrefixNumberOrder,IErr,SErr);
  GetUserParm('PharmPoint_PrefixNumberOrder',User,TypeCode,UserParmTradePointPrefixNumberOrder,IErr,SErr);
  GetUserParm('Code_Details_PrePayment_Courier',User,TypeCode,UserParmCodeDetailsPrePaymentCourier,IErr,SErr);
end;

procedure TDM_CCJSO.GetVersion(USER : integer; var TypeCode : string; var SVal : string; var IErr : integer; var SErr : string);
begin
  try
    spGetParm.Parameters.ParamValues['@CodeParm'] := 'JSO_VersionDateTime';
    spGetParm.Parameters.ParamValues['@USER'] := USER;
    spGetParm.ExecProc;
    IErr := spGetParm.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      TypeCode := spGetParm.Parameters.ParamValues['@TypeCode'];
      SVal := spGetParm.Parameters.ParamValues['@SVal'];
    end else begin
      SErr := spGetParm.Parameters.ParamValues['@SErr'];
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
    end;
  end;
end;

procedure TDM_CCJSO.JSOHistGetActionDateInfo(USER : integer; Order : integer; ActionCode : string; Mode : boolean; FindNote : string; var NumbRegistered : integer; var SActionDate : string; var Note : string; var IErr : integer; var SErr : string);
begin
  IErr := 0;
  SErr := '';
  try
    spJSOHistGetActionDateInfo.Parameters.ParamValues['@USER']        := USER;
    spJSOHistGetActionDateInfo.Parameters.ParamValues['@Order']       := Order;
    spJSOHistGetActionDateInfo.Parameters.ParamValues['@ActionCode']  := ActionCode;
    spJSOHistGetActionDateInfo.Parameters.ParamValues['@Mode']        := Mode;
    spJSOHistGetActionDateInfo.Parameters.ParamValues['@FindNote']    := FindNote;
    spJSOHistGetActionDateInfo.ExecProc;
    IErr := spJSOHistGetActionDateInfo.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      NumbRegistered := spJSOHistGetActionDateInfo.Parameters.ParamValues['@NumbRegistered'];
      SActionDate    := spJSOHistGetActionDateInfo.Parameters.ParamValues['@SActionDate'];
      Note           := spJSOHistGetActionDateInfo.Parameters.ParamValues['@Note'];
    end else begin
      SErr := spJSOHistGetActionDateInfo.Parameters.ParamValues['@SErr'];
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
    end;
  end;
end;

procedure TDM_CCJSO.RegException(SignRaisError : smallint; NameProc : string; ErrorNumber : integer; ErrorMessage : string; NUSER : integer; StepNote : string; AllNote : string);
var
  IErr : integer;
  SErr : string;
begin
  IErr := 0;
  SErr := '';
  try
    spException.Parameters.ParamValues['@SignRaisError'] := SignRaisError;
    spException.Parameters.ParamValues['@NameProc']      := NameProc;
    spException.Parameters.ParamValues['@ErrorNumber']   := ErrorNumber;
    spException.Parameters.ParamValues['@ErrorMessage']  := ErrorMessage;
    spException.Parameters.ParamValues['@NUSER']         := NUSER;
    spException.Parameters.ParamValues['@StepNote']      := StepNote;
    spException.Parameters.ParamValues['@AllNote']       := AllNote;
    spException.ExecProc;
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
    end;
  end;
end;

procedure TDM_CCJSO.InitRecHistInfo(var RecHistInfo : TJSORecHist_GetActionInfo);
begin
  RecHistInfo.NumbRegistered := 0;
  RecHistInfo.ActionNote     := '';
  RecHistInfo.SActionDate    := '';
end;

procedure TDM_CCJSO.CalcCDO(USER : integer; Amount : double; var COD : currency; var RuleCalc : string; var IErr : integer; var SErr : string);
begin
  IErr := 0;
  SErr := '';
  try
    spCalcCDO.Parameters.ParamValues['@USER']   := USER;
    spCalcCDO.Parameters.ParamValues['@Amount'] := Amount;
    spCalcCDO.ExecProc;
    IErr := spCalcCDO.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      COD := spCalcCDO.Parameters.ParamValues['@COD'];
      RuleCalc := spCalcCDO.Parameters.ParamValues['@RULE'];
    end else begin
      SErr := spCalcCDO.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      ShowMessage(SErr);
      IErr := -1;
    end;
  end;
end;

procedure TDM_CCJSO.JSOCreateListSelectBetweenDate(NUser : integer; IDENT : longint; DateBegin : string; DateEnd : string);
var
  IErr : integer;
  SErr : string;
begin
  IErr    := 0;
  SErr    := '';
  try
    spJSOCreateListSelectBetweenDate.Parameters.ParamValues['@USER']  := NUser;
    spJSOCreateListSelectBetweenDate.Parameters.ParamValues['@IDENT'] := IDENT;
    spJSOCreateListSelectBetweenDate.Parameters.ParamValues['@Begin'] := DateBegin;
    spJSOCreateListSelectBetweenDate.Parameters.ParamValues['@End']   := DateEnd;
    spJSOCreateListSelectBetweenDate.ExecProc;
    IErr := spJSOCreateListSelectBetweenDate.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      SErr := spJSOCreateListSelectBetweenDate.Parameters.ParamValues['@SErr'];
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
    end;
  end;
end;

function TDM_CCJSO.GetSignCOD(USER : integer; Payment : string) : boolean;
var
  SignCOD : boolean;
  IErr    : integer;
  SErr    : string;
begin
  IErr    := 0;
  SErr    := '';
  SignCOD := false;
  try
    spGetSignCOD.Parameters.ParamValues['@USER']    := USER;
    spGetSignCOD.Parameters.ParamValues['@Payment'] := Payment;
    spGetSignCOD.ExecProc;
    IErr := spGetSignCOD.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      SignCOD := spGetSignCOD.Parameters.ParamValues['@SignCOD'];
    end else begin
      SErr := spGetSignCOD.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      ShowMessage(SErr);
      IErr := -1;
    end;
  end;
  result := SignCOD;
end;

function TDM_CCJSO.GetDFormatSet : TFormatSettings;
var
  DFormatSet : TFormatSettings;
begin
  DFormatSet.DateSeparator   := '-';
  DFormatSet.TimeSeparator   := ':';
  DFormatSet.ShortDateFormat := 'dd-mm-yyyy';
  DFormatSet.ShortTimeFormat := 'hh24:mi:ss';
  result := DFormatSet;
end;

function TDM_CCJSO.GetPrefNumbOrderApteka911  : string;      begin result := UserParmApteka911PrefixNumberOrder; end;
function TDM_CCJSO.GetPrefNumbOrderIApteka    : string;      begin result := UserParmIAptekaPrefixNumberOrder; end;
function TDM_CCJSO.GetPrefNumbOrderManual     : string;      begin result := UserParmManualPrefixNumberOrder; end;
function TDM_CCJSO.GetPrefNumbOrderTradePoint : string;      begin result := UserParmTradePointPrefixNumberOrder; end;
function TDM_CCJSO.GetCodeDetailsPrePaymentCourier : string; begin result := UserParmCodeDetailsPrePaymentCourier; end;

end.
