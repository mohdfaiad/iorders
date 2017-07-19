unit uDMJSO;

interface

uses
  SysUtils, Classes, DB, ADODB, uSprJoin, uSprQuery, Variants, Dialogs,
  UtilsBase, Forms, Controls, Messages;

type

  TOrderHeaderAddFields = record
    Note: string;
    Comments: string;
  end;

  TOrderHeaderHAddFields = record
    HistoryComments: string;
    HistoryExecMsg: string;
  end;

  TdmJSO = class(TDataModule)
    dsJSOPayTransaction: TDataSource;
    qrspPayTransaction: TADOStoredProc;
    qrspPayTransactionid: TLargeintField;
    qrspPayTransactionExtId: TIntegerField;
    qrspPayTransactionExtPaySystem: TIntegerField;
    qrspPayTransactionSExtPaySystem: TStringField;
    qrspPayTransactionExtSystem: TIntegerField;
    qrspPayTransactionSExtSystem: TStringField;
    qrspPayTransactionExtOrderId: TIntegerField;
    qrspPayTransactionExtPaySysId: TIntegerField;
    qrspPayTransactionExtType: TStringField;
    qrspPayTransactionExtTypeName: TStringField;
    qrspPayTransactionExtStatus: TStringField;
    qrspPayTransactionExtStatusName: TStringField;
    qrspPayTransactionExtAmountBase: TBCDField;
    qrspPayTransactionExtCurr: TStringField;
    qrspPayTransactionExtDateIns: TDateTimeField;
    qrspPayTransactionDateIns: TDateTimeField;
    qrspPayTransactionExtDateUpd: TDateTimeField;
    qrspPayTransactionSignProcessed: TStringField;
    qrspPayTransactionSignProcessedName: TStringField;
    qrspPayTransactionDateExec: TDateTimeField;
    qrspPayTransactionIErr: TIntegerField;
    qrspPayTransactionMsgExec: TStringField;
    qrspPayTransactionPhase: TIntegerField;
    qrExtSystem: TADOQuery;
    qrExtSystemExtSystem: TBCDField;
    qrExtSystemName: TStringField;
    qrExtSystemPrefix: TStringField;
    dsExtSystem: TDataSource;
    qrPayTransStatus: TADOQuery;
    qrPayTransStatusid: TBCDField;
    qrPayTransStatusName: TStringField;
    qrPayTransStatusCode: TStringField;
    qrPayTransStatusFullName: TStringField;
    dsPayTransStatus: TDataSource;
    spAddIntoQueue: TADOStoredProc;
    spCloseQueue: TADOStoredProc;
    spLastOrderOpenAction: TADOStoredProc;
    qrOrderAddFields: TADOQuery;
    qrOrderHAddFields: TADOQuery;
    spCanDoOrderAction: TADOStoredProc;
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FqrPharmReserve: TsprQuery;
    FqrPharmReserveSpec: TsprQuery;
    FqrPayTransaction: TsprQuery;
    FqrQueue: TsprQuery;
    FqrOrderHistory: TsprQuery;
    FqrConds: TsprQuery;
    FqrClient: TsprQuery;
    FqrAppealType: TsprQuery;
    FqrAppealState: TsprQuery;
    FqrAppealMethod: TsprQuery;
    FqrClientType: TsprQuery;
    FDebug: Boolean;
    FUserId: Integer;
    function GetPharmReserve: TsprQuery;
    function GetPharmReserveSpec: TsprQuery;
    function GetPayTransaction: TsprQuery;
    function GetQueue: TsprQuery;
    function GetConds: TsprQuery;
    function InnerGetOrderHistory: TsprQuery;
    function CreateOrderHistory: TsprQuery;
    function CreateQrQueue: TsprQuery;
    function CreateActionResOrderStatus: TsprQuery;
    procedure BPSpecBasisAfterInsert(DataSet: TDataSet);
    function CreateProc(ACompName: string; AProcName: string): TADOStoredProc;
    function CreateCommonDict(ADict: Integer): TsprQuery;
  public
    { Public declarations }
    procedure ExecConditionPayTransaction(OrderId: Integer);
    procedure ExecPharmReserveSpec;
    procedure AddOrderIntoReserveQueue(OrderId: Integer; UserId: Integer;
      ExtSystem: Integer; orderPayment: string);
    procedure AddOrderIntoSyncStatusPay(OrderId: Integer; UserId: Integer;
      ExtSystem: Integer; orderPayment: string);
    procedure RemoveOrderFromReserveQueue(OrderId: Integer; UserId: Integer);
    function GetOrderQueue(OrderId: Integer; AActive: Boolean): TsprQuery;
    function GetOrderHistory(OrderId: Integer; AActive: Boolean): TsprQuery;
    function CreateOrderStatus: TsprQuery;
    function CreateActions: TsprQuery;
    function CreateActionBasis: TsprQuery;
    function GetActionSrcOrderStatus(Query: TsprQuery; SrcStatusId: Integer; AActive: Boolean = true): TsprQuery;
    function GetActionResOrderStatus(Query: TsprQuery; BpId: Integer; ActionCode: string;
      SrcStatusId: Integer; SrcBasisId: Integer; ResBasisId: Integer;
      AActive: Boolean = true): TsprQuery;
    function GetOrderActions(Query: TsprQuery; BpId: Integer; SrcStatusId: Integer; AActive: Boolean = true; UserId: Integer = 0): TsprQuery;
    function GetOrderSrcBasis(Query: TsprQuery; BpId: Integer; SrcStatusId: Integer;
      ActionCode: string; AActive: Boolean = true): TsprQuery;
    function GetOrderResBasis(Query: TsprQuery; BpId: Integer; SrcStatusId: Integer;
      ActionCode: string; SrcBasisId: Integer; AActive: Boolean = true): TsprQuery;
    function CanDoOrderAction(OrderId: Integer; var ErrMsg: string): Boolean; overload;
    function CreateBP: TsprQuery;
    function CreateBPSpec(BP: TDataSet; SrcStatus: TDataSet; ResStatus: TDataSet; Actions: TDataSet): TsprQuery;
    function CreateBPSpecBasis(SrcBasis: TDataSet; ResBasis: TDataSet): TsprQuery;
    function GetOrderAddFields(OrderId: Integer): TOrderHeaderAddFields;
    function GetOrderHAddFields(OrderId: Integer): TOrderHeaderHAddFields;
    procedure ShowGoodsPharmState(ItemCode: Integer; AptekaId: Integer; Caption: string);
    function CanEndErrorOrderHistory(DataSet: TsprQuery): Boolean;
    procedure EndErrorOrderHistory(DataSet: TsprQuery);
    procedure DeleteBPSpec(DataSet: TsprQuery);
    function CanDeleteBPSpec(DataSet: TsprQuery): Boolean;
    function CreateUsers: TsprQuery;
    function CreateConditions: TsprQuery;
    function GetCondSQL(CondId: Integer; Aliase: string; PriorityFName: string = 'StatusPriority'): string;
    function CanDoOrderAction(AOrderId: Integer; ActionCode: string; var ErrMsg: string): Boolean; overload;
    function CreateAppealType: TsprQuery;
    function CreateAppealMethod: TsprQuery;
    function CreateAppealState: TsprQuery;
    function CreateClientType: TsprQuery;
    function GetAppealType(AActive: Boolean = true): TsprQuery;
    function GetAppealMethod(AActive: Boolean = true): TsprQuery;
    function GetAppealState(AActive: Boolean = true): TsprQuery;
    function GetClientType(AActive: Boolean = true): TsprQuery;
    function GetClient(Phone: String): TsprQuery;
    function CreateClient(IsRef: Boolean; ClientType: TDataSet): TsprQuery;
    function CreateAppeal: TsprQuery;
    function GetAppeal(var DS: TsprQuery; Phone: String; DoSetPhone: Boolean): TsprQuery;
    function CreateIPTelMap: TsprQuery;
    procedure SetIPTelActive(DataSet: TsprQuery);
    function CanSetIPTelActive(DataSet: TsprQuery): Boolean;
    procedure UpdClient(Phone: string; AName: string; AppealType: Variant;
      AContent: string; UserId: Integer; var AppealId: Integer);
    class function IsSystemUser(UserId: Integer): Boolean;
    property qrPharmReserve: TsprQuery read GetPharmReserve;
    property qrPharmReserveSpec: TsprQuery read GetPharmReserveSpec;
    property qrPayTransaction: TsprQuery read GetPayTransaction;
    property qrQueue: TsprQuery read GetQueue;
    property qrConds: TsprQuery read GetConds;
    property Debug: Boolean read FDebug write FDebug;
    property UserId: Integer read FUserId write FUserId;
  end;

const
  WM_FilterOrdersEvent = WM_USER + 103;
  
var
  dmJSO: TdmJSO;

implementation

uses UMAIN, uActionCore;

{$R *.dfm}

procedure TdmJSO.ExecConditionPayTransaction(OrderId: Integer);
begin
  try
    Forms.Screen.Cursor := crHourGlass;
    qrspPayTransaction.Active := false;
    qrspPayTransaction.Parameters.ParamByName('@OrderId').Value := OrderId;
    qrspPayTransaction.Active := true;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TdmJSO.GetPayTransaction: TsprQuery;
var
  F: TField;
begin
  if not Assigned(FqrPayTransaction) then
  begin
    FqrPayTransaction := TsprQuery.Create(Self);
    FqrPayTransaction.Connection := Form1.ADOC_STAT;
    //FqrPayTransaction.Debug := True;
    FqrPayTransaction.BaseTable := 'dbo.v_jso_PayTransaction';
    FqrPayTransaction.SQLTemplate.Text :=
      'use WorkWith_Gamma ' + clrf +
      'select t.* ' + clrf +
      ' from dbo.v_jso_PayTransaction t with (nolock) ' + clrf +
      '&Joins' + clrf +
      '&Where' + clrf +
      '&Order';
    F := FqrPayTransaction.AddField('ExtId', 'ID Внеш.', ftInteger, 't');
    F.DisplayWidth := 10;
    F := FqrPayTransaction.AddField('orderName', 'ОБЩ. номер', ftString, 't');
    F.DisplayWidth := 10;
    F := FqrPayTransaction.AddField('orderId', 'ЗАКАЗ', ftInteger, 't');
    F.DisplayWidth := 10;
    F := FqrPayTransaction.AddField('ExtPaySysId', 'ID плат. сист.', ftInteger, 't');
    F.DisplayWidth := 10;
    F := FqrPayTransaction.AddField('SSrcSystem', 'САЙТ', ftString, 't');
    F.DisplayWidth := 15;
    F := FqrPayTransaction.AddField('ExtTypeName', 'Тип транз.', ftString, 't');
    F.DisplayWidth := 15;
    F := FqrPayTransaction.AddField('ExtStatusName', 'Статус транз.', ftString, 't');
    F.DisplayWidth := 15;
    F := FqrPayTransaction.AddField('ExtAmountBase', 'Сумма транз.', ftBCD, 't');
    F.DisplayWidth := 10;
    TBCDField(F).DisplayFormat := sprPriceFieldFormat;
    F := FqrPayTransaction.AddField('ExtDateIns', 'Дата Внеш.', ftDateTime, 't');
    TDateTimeField(F).DisplayFormat := sprDateTimeFieldFormat;
    F := FqrPayTransaction.AddField('DateIns', 'Дата', ftDateTime, 't');
    TDateTimeField(F).DisplayFormat := sprDateTimeFieldFormat;
    F := FqrPayTransaction.AddField('SignProcessedName', 'Статус', ftString, 't');
    F.DisplayWidth := 8;
    F := FqrPayTransaction.AddField('DateExec', 'Дата оброб.', ftDateTime, 't');
    TDateTimeField(F).DisplayFormat := sprDateTimeFieldFormat;
    F := FqrPayTransaction.AddField('IErr', 'ID Ошиб.', ftInteger, 't');
    F.DisplayWidth := 8;
    F := FqrPayTransaction.AddField('MsgExec', 'Примечание обработки', ftString, 't');
    TStringField(F).Size := 1000;
    F.DisplayWidth := 25;
    F := FqrPayTransaction.AddField('orderShipName', 'Клиент', ftString, 't');
    F.DisplayWidth := 15;
    F := FqrPayTransaction.AddField('orderPhone', 'Телефон', ftString, 't');
    F.DisplayWidth := 15;
    F := FqrPayTransaction.AddField('orderAmount', 'Сумма', ftBCD, 't');
    F.DisplayWidth := 10;
    TBCDField(F).DisplayFormat := sprPriceFieldFormat;
    F := FqrPayTransaction.AddField('NOrderAmountShipping', 'Сумма+', ftBCD, 't');
    F.DisplayWidth := 8;
    TBCDField(F).DisplayFormat := sprPriceFieldFormat;
    F := FqrPayTransaction.AddField('NOrderAmountCOD', 'Налож. платеж', ftBCD, 't');
    F.DisplayWidth := 8;
    TBCDField(F).DisplayFormat := sprPriceFieldFormat;
    F := FqrPayTransaction.AddField('NCoolantSum', 'Хладоген', ftBCD, 't');
    F.DisplayWidth := 8;
    TBCDField(F).DisplayFormat := sprPriceFieldFormat;
    F := FqrPayTransaction.AddField('ExtType', 'Тип тран. внеш.', ftString, 't');
    F.DisplayWidth := 10;
    F := FqrPayTransaction.AddField('ExtStatus', 'Статус тран. внеш.', ftString, 't');
    F.DisplayWidth := 10;
    F := FqrPayTransaction.AddField('phase', 'phase', ftInteger, 'dh');
    F.Visible := false;
    FqrPayTransaction.DateFieldName := 'DateIns';
    FqrPayTransaction.Order.By('ExtId');
    FqrPayTransaction.Order.By('ExtId');
  end;
  FqrPayTransaction.Debug := FDebug;
  Result := FqrPayTransaction;
end;

function TdmJSO.GetPharmReserve: TsprQuery;
var
  F: TField;
begin
  if not Assigned(FqrPharmReserve) then
  begin
    FqrPharmReserve := TsprQuery.Create(Self);
    FqrPharmReserve.Connection := Form1.ADOC_STAT;
    //FqrPharmReserve.Debug := True;
    FqrPharmReserve.BaseTable := 'dbo.v_jso_PharmReserve';
    FqrPharmReserve.SQLTemplate.Text :=
      'use WorkWith_Gamma ' + clrf +
      'select dh.*, case when dh.closed = 0 then 0 when dh.closed = 1 then 1 else 7 end phase' + clrf +
      ' from dbo.v_jso_PharmReserve dh with (nolock) ' + clrf +
      '&Joins' + clrf +
      '&Where' + clrf +
      '&Order';
    FqrPharmReserve.AddField('pharmOrderId', 'Заказ', ftInteger, 'dh');
    F := FqrPharmReserve.AddField('idres', 'idres', ftInteger, 'dh');
    F.Visible := false;
    F := FqrPharmReserve.AddField('date_res', 'Дата', ftDateTime, 'dh');
    TDateTimeField(F).DisplayFormat := sprDateTimeFieldFormat;
    F := FqrPharmReserve.AddField('phone', 'Телефон', ftString, 'dh');
    F.DisplayWidth := 20;
    F := FqrPharmReserve.AddField('fio', 'ФИО', ftString, 'dh');
    F.DisplayWidth := 30;
    F := FqrPharmReserve.AddField('date_close', 'Дата закр.', ftDateTime, 'dh');
    TDateTimeField(F).DisplayFormat := sprDateTimeFieldFormat;
    F := FqrPharmReserve.AddField('aptekaFromName', 'ТТ инициатор', ftString, 'dh');
    TStringField(F).Size := 100;
    TStringField(F).DisplayWidth := 30;
    F := FqrPharmReserve.AddField('aptekaName', 'ТТ', ftString, 'dh');
    F.Size := 100;
    F.DisplayWidth := 30;
    F := FqrPharmReserve.AddField('id_apteka', 'id_apteka', ftInteger, 'dh');
    F.Visible := false;
    F := FqrPharmReserve.AddField('id_apteka_from', 'id_apteka_from', ftInteger, 'dh');
    F.Visible := false;
    F := FqrPharmReserve.AddField('closed', 'closed', ftInteger, 'dh');
    F.Visible := false;
    FqrPharmReserve.AddField('closedName', 'Основание', ftString, 'dh');
    F := FqrPharmReserve.AddField('phase', 'phase', ftInteger, 'dh');
    F.Visible := false;
    FqrPharmReserve.DateFieldName := 'date_res';
    FqrPharmReserve.Order.By('pharmOrderId');
  end;
  FqrPharmReserve.Debug := FDebug;
  Result := FqrPharmReserve;
end;

function TdmJSO.GetPharmReserveSpec: TsprQuery;
var
  F: TField;
begin
  if not Assigned(FqrPharmReserveSpec) then
  begin
    FqrPharmReserveSpec := TsprQuery.Create(Self);
    FqrPharmReserveSpec.Connection := Form1.ADOC_STAT;
    //  FqrPharmReserveSpec.Debug := True;
    FqrPharmReserveSpec.BaseTable := 'dbo.v_jso_PharmReserveSpec';
    FqrPharmReserveSpec.SQLTemplate.Text :=
      'use WorkWith_Gamma ' + clrf +
      'select dt.*' + clrf +
      '  from dbo.v_jso_PharmReserveSpec dt with (nolock) ' + clrf +
      '&Joins' + clrf +
      ' where dt.idres = :idres' + clrf +
      '   and dt.id_apteka = :id_apteka' + clrf +
      '&WhereValue' + clrf +
      '&Order';
    FqrPharmReserveSpec.AddField('idres', 'idres', ftInteger, 'dt', false);
    FqrPharmReserveSpec.AddField('id_apteka', 'id_apteka', ftInteger, 'dt', false);
    FqrPharmReserveSpec.AddField('art_code', 'Арт. код', ftInteger, 'dt');
    F := FqrPharmReserveSpec.AddField('goodsName', 'Наименование', ftWideString, 'dt');
    F.Size := 150;
    F.DisplayWidth := 40;
    FqrPharmReserveSpec.AddField('kol', 'Кол-во', ftSmallInt, 'dt');
    F := FqrPharmReserveSpec.AddField('cena', 'Цена', ftBCD, 'dt');
    TBCDField(F).DisplayFormat := sprPriceFieldFormat;
    F := FqrPharmReserveSpec.AddField('aptekaName', 'ТТ', ftString, 'dt');
    F.Size := 100;
    F.DisplayWidth := 30;
    FqrPharmReserveSpec.AddField('row_id', 'ID', ftInteger, 'dt');
    FqrPharmReserveSpec.Order.By('art_code');
    FqrPharmReserveSpec.Parameters.CreateParameter('idres', ftInteger, pdInput, -1, null);
    FqrPharmReserveSpec.Parameters.CreateParameter('id_apteka', ftInteger, pdInput, -1, null);
  end;
  FqrPharmReserveSpec.Debug := FDebug;
  Result := FqrPharmReserveSpec;
end;

procedure TdmJSO.ExecPharmReserveSpec;
begin
  if not Assigned(FqrPharmReserve) or not Assigned(FqrPharmReserveSpec) then
      Exit;

  Screen.Cursor := crHourGlass;
  try
    FqrPharmReserveSpec.Active := False;
    if FqrPharmReserve.IsEmpty then
    begin
      FqrPharmReserveSpec.Parameters.ParamByName('idres').Value := 0;
      FqrPharmReserveSpec.Parameters.ParamByName('id_apteka').Value := 0;
    end
    else
    begin
      FqrPharmReserveSpec.Parameters.ParamByName('idres').Value := FqrPharmReserve.FieldByName('idres').AsInteger;
      FqrPharmReserveSpec.Parameters.ParamByName('id_apteka').Value := FqrPharmReserve.FieldByName('id_apteka').AsInteger;
      FqrPharmReserveSpec.Active := True;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TdmJSO.DataModuleDestroy(Sender: TObject);

  procedure FreeObj(Obj: TObject);
  begin
    if Assigned(Obj) then
      FreeAndNil(Obj);
  end;
begin
  if Assigned(FqrPharmReserve) then
    FreeAndNil(FqrPharmReserve);
  if Assigned(FqrPharmReserveSpec) then
    FreeAndNil(FqrPharmReserveSpec);
  if Assigned(FqrPayTransaction) then
    FreeAndNil(FqrPayTransaction);

  if Assigned(FqrQueue) then
    FreeAndNil(FqrQueue);
  if Assigned(FqrOrderHistory) then
    FreeAndNil(FqrOrderHistory);
  if Assigned(FqrConds) then
    FreeAndNil(FqrConds);
  if Assigned(FqrClient) then
    FreeAndNil(FqrClient);

  FreeObj(FqrAppealType);
  FreeObj(FqrAppealState);
  FreeObj(FqrAppealMethod);
  FreeObj(FqrClientType);
end;

procedure TdmJSO.AddOrderIntoReserveQueue(OrderId: Integer; UserId: Integer; ExtSystem: Integer; orderPayment: string);
var
  IErr : integer;
  QueueId: Variant;
  ErrMsg : string;
  I: Integer;
begin
  ErrMsg := '';
  try
    spAddIntoQueue.Parameters.ParamValues['@DoCheckAlreadyInQueue']  := OrderId;
    spAddIntoQueue.Parameters.ParamValues['@UserIns']  := UserId;
    spAddIntoQueue.Parameters.ParamValues['@ObjId']  := OrderId;
    spAddIntoQueue.Parameters.ParamValues['@TypeObj'] := 1;
    spAddIntoQueue.Parameters.ParamValues['@Action']  := 'p_jso_QueueOrderReserve';
    //Таблекти и PayMaster статус статус перед бронированием [Заказ в процессе сборки]
    if (ExtSystem = 2) or (AnsiUpperCase(Trim(orderPayment)) = 'PAYMASTER') then
      spAddIntoQueue.Parameters.ParamValues['@ObjStatusId']  := 65
    else
      spAddIntoQueue.Parameters.ParamValues['@ObjStatusId']  := 0;
    spAddIntoQueue.Parameters.ParamValues['@Param1']  := 'DO_CHECK_STATE';
    for I := 2 to 10 do
      spAddIntoQueue.Parameters.ParamValues['@Param' + IntToStr(I)] := Null;
    spAddIntoQueue.ExecProc;
    IErr := spAddIntoQueue.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then
    begin
      ErrMsg := spAddIntoQueue.Parameters.ParamValues['@ErrMsg'];
      ShowMessage(ErrMsg);
    end
    else
    begin
      QueueId := spAddIntoQueue.Parameters.ParamValues['@QueueId'];
      ShowMessage('Заказ поставлен в очередь на бронирование. Очередь #' + VarToStr(QueueId));
    end;
  except
    on e:Exception do begin
      ShowMessage(e.Message);
    end;
  end;
end;

procedure TdmJSO.AddOrderIntoSyncStatusPay(OrderId: Integer; UserId: Integer;
  ExtSystem: Integer; orderPayment: string);
var
  IErr : integer;
  QueueId: Variant;
  ErrMsg : string;
  I: Integer;
begin
  ErrMsg := '';
  try
    spAddIntoQueue.Parameters.ParamValues['@DoCheckAlreadyInQueue']  := OrderId;
    spAddIntoQueue.Parameters.ParamValues['@UserIns']  := UserId;
    spAddIntoQueue.Parameters.ParamValues['@ObjId']  := OrderId;
    spAddIntoQueue.Parameters.ParamValues['@TypeObj'] := 1;
    spAddIntoQueue.Parameters.ParamValues['@Action']  := 'p_jso_QueueSyncStatus_PAY';
    spAddIntoQueue.Parameters.ParamValues['@ObjStatusId']  := 192;
    for I := 1 to 10 do
      spAddIntoQueue.Parameters.ParamValues['@Param' + IntToStr(I)] := Null;
    spAddIntoQueue.ExecProc;
    IErr := spAddIntoQueue.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then
    begin
      ErrMsg := spAddIntoQueue.Parameters.ParamValues['@ErrMsg'];
      ShowMessage(ErrMsg);
    end
    else
    begin
      QueueId := spAddIntoQueue.Parameters.ParamValues['@QueueId'];
      ShowMessage('Заказ поставлен в очередь на синхронизацию статуса ОПЛАТЫ. Очередь #' + VarToStr(QueueId));
    end;
  except
    on e:Exception do begin
      ShowMessage(e.Message);
    end;
  end;
end;


procedure TdmJSO.RemoveOrderFromReserveQueue(OrderId: Integer; UserId: Integer);
var
  IErr : integer;
  ErrMsg : string;
begin
  ErrMsg := '';
  try
    spCloseQueue.Parameters.ParamValues['@DoCheckExecuting']  := 1;
    spCloseQueue.Parameters.ParamValues['@UserId']  := UserId;
    spCloseQueue.Parameters.ParamValues['@ObjId']  := OrderId;
    spCloseQueue.Parameters.ParamValues['@TypeObj'] := 1;
    spCloseQueue.Parameters.ParamValues['@Action']  := 'p_jso_QueueOrderReserve';
    spCloseQueue.ExecProc;
    IErr := spCloseQueue.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then
    begin
      ErrMsg := spCloseQueue.Parameters.ParamValues['@ErrMsg'];
      ShowMessage(ErrMsg);
    end
    else
    begin
      ShowMessage('Заказ удален из очереди на бронирование');
    end;

  except
    on e:Exception do begin
      ShowMessage(e.Message);
    end;
  end;
end;

function TdmJSO.CreateQrQueue: TsprQuery;
var
  F: TField;
  I: Integer;
begin
  Result := TsprQuery.Create(Self);
  Result.Connection := Form1.ADOC_STAT;
  Result.BaseTable := 'dbo.v_jso_Queue';
  Result.SQLTemplate.Text :=
      'use WorkWith_Gamma ' + clrf +
      'select q.* ' + clrf +
      ' from dbo.v_jso_Queue q with (nolock) ' + clrf +
      '&Joins' + clrf +
      '&Where' + clrf +
      '&Order';
  F := Result.AddField('Id', 'ID', ftInteger, 'q');
  F.DisplayWidth := 10;
  F := Result.AddField('ObjId', '#Объект', ftInteger, 'q');
  F.DisplayWidth := 10;
  F := Result.AddField('TypeObjName', 'Тип объекта', ftString, 'q');
  F.DisplayWidth := 15;
  F := Result.AddField('ActionName', 'Действие', ftString, 'q');
  F.DisplayWidth := 20;
  F := Result.AddField('ProcessId', 'Процесс', ftInteger, 'q');
  F.DisplayWidth := 10;
  F := Result.AddField('DateIns', 'Дата созд.', ftDateTime, 'q');
  TDateTimeField(F).DisplayFormat := sprDateTimeFieldFormat;
  F := Result.AddField('DateBegin', 'Дата нач.', ftDateTime, 'q');
  TDateTimeField(F).DisplayFormat := sprDateTimeFieldFormat;
  F := Result.AddField('DateEnd', 'Дата кон.', ftDateTime, 'q');
  TDateTimeField(F).DisplayFormat := sprDateTimeFieldFormat;
  F := Result.AddField('IErr', '#Ошибка', ftInteger, 'q');
  F.DisplayWidth := 10;
  F := Result.AddField('ErrMsg', 'Примечание', ftString, 'q');
  F.Size := 255;
  F.DisplayWidth := 25;
  F := Result.AddField('UserIns', 'UserIns', ftInteger, 'q');
  F.Visible := false;
  F := Result.AddField('UserUpd', 'UserUpd', ftInteger, 'q');
  F.Visible := false;
  F := Result.AddField('DateUpd', 'Дата изм.', ftDateTime, 'q');
  TDateTimeField(F).DisplayFormat := sprDateTimeFieldFormat;
  F := Result.AddField('UserInsName', 'Пользов. созд.', ftString, 'q');
  F.Size := 100;
  F.DisplayWidth := 15;
  F := Result.AddField('UserUpdName', 'Пользов. изм.', ftString, 'q');
  F.Size := 100;
  F.DisplayWidth := 15;
  F := Result.AddField('TypeObj', '#Тип', ftInteger, 'q');
  F.DisplayWidth := 10;
  F := Result.AddField('Action', '#Действие', ftString, 'q');
  F.DisplayWidth := 10;
  for I := 1 to 10 do
  begin
    F := Result.AddField('Param' + IntToStr(I), 'Параметр ' + IntToStr(I), ftString, 'q');
    F.Size := 100;
    F.DisplayWidth := 10;
  end;
  F := Result.AddField('Phase', 'Phase', ftInteger, 'q');
  F.DisplayWidth := 10;
  F.Visible := false;
end;

function TdmJSO.GetQueue: TsprQuery;
begin
  if not Assigned(FqrQueue) then
    FqrQueue := CreateQrQueue;
  FqrQueue.Debug := FDebug;
  Result := FqrQueue;
end;

function TdmJSO.GetOrderQueue(OrderId: Integer; AActive: Boolean): TsprQuery;
begin
  Result := GetQueue;
  Result.Active := False;
  Result.AddFilter('OrderFilter', 'q.TypeObj = 1 AND q.ObjId = ' + IntToStr(OrderId), 'SlaveGroup');
  Result.Active := AActive;
end;

function TdmJSO.CanEndErrorOrderHistory(DataSet: TsprQuery): Boolean;
begin
  Result := DataSet.Active and (DataSet.RecordCount > 0)
    and (not VarIsAssigned(DataSet.FieldByName('EndDate').Value));
end;

procedure TdmJSO.EndErrorOrderHistory(DataSet: TsprQuery);
var
  vCore: TActionCore;
begin
  vCore := TActionCore.Create(Self);
  try
    vCore.Connection := Form1.ADOC_STAT;
    vCore.UserId := Self.UserId;
    vCore.EndErrorOrderAction(DataSet.FieldByName('OrderId').AsInteger, DataSet.FieldByName('ID').AsInteger);
  finally
    vCore.Free;
  end;
end;

function TdmJSO.CreateOrderHistory: TsprQuery;
var
  F: TField;
  A: TQueryAction;
begin
  Result := TsprQuery.Create(Self);
  Result.Connection := Form1.ADOC_STAT;
  Result.BaseTable := 'dbo.v_jso_OrderHistory';
  Result.SQLTemplate.Text :=
      'use WorkWith_Gamma ' + clrf +
      'select h.* ' + clrf +
      ' from dbo.v_jso_OrderHistory h with (nolock) ' + clrf +
      '&Joins' + clrf +
      '&Where' + clrf +
      '&Order';
  F := Result.AddField('StartDate', 'Дата нач.', ftDateTime, 'h');
  TDateTimeField(F).DisplayFormat := sprDateTimeFieldFormat;
  F.DisplayWidth := 18;
  F := Result.AddField('EndDate', 'Дата кон.', ftDateTime, 'h');
  TDateTimeField(F).DisplayFormat := sprDateTimeFieldFormat;
  F.DisplayWidth := 18;
  F := Result.AddField('UserInsName', 'Оператор', ftString, 'h');
  F.Size := 60;
  F.DisplayWidth := 10;
  F := Result.AddField('ActionName', 'Действие', ftString, 'h');
  F.Size := 240;
  F.DisplayWidth := 18;
  F := Result.AddField('SrcStatusName', 'ИСХ. СТАТУС', ftString, 'h');
  F.Size := 100;
  F.DisplayWidth := 18;
  F := Result.AddField('ResStatusName', 'РЕЗ. СТАТУС', ftString, 'h');
  F.Size := 100;
  F.DisplayWidth := 18;
  F := Result.AddField('SrcBasisName', 'Основание действия', ftString, 'h');
  F.Size := 100;
  F.DisplayWidth := 18;
  F := Result.AddField('ResBasisName', 'Результат действия', ftString, 'h');
  F.Size := 100;
  F.DisplayWidth := 18;
  F := Result.AddField('Comments', 'Комментарий', ftString, 'h');
  F.Size := 1000;
  F.DisplayWidth := 25;
  F := Result.AddField('ExecMsg', 'Примечание[системное]', ftString, 'q');
  F.Size := 1000;
  F.DisplayWidth := 25;
  F := Result.AddField('IErr', '#Ошибка', ftInteger, 'h');
  F.DisplayWidth := 10;
  F := Result.AddField('Id', 'ID', ftInteger, 'h');
  F.DisplayWidth := 10;
  F := Result.AddField('ActionCode', 'Код действия', ftString, 'h');
  F.Size := 50;
  F.DisplayWidth := 15;

  F := Result.AddField('OrderId', '#Заказ', ftInteger, 'h');
  F.DisplayWidth := 10;
  F.Visible := False;
  F := Result.AddField('SrcStatusId', '#Исх. статус', ftInteger, 'h');
  F.DisplayWidth := 8;
  F.Visible := False;
  F := Result.AddField('ResStatusId', '#Рез. статус', ftInteger, 'h');
  F.DisplayWidth := 8;
  F.Visible := False;
  F := Result.AddField('InsDate', 'Дата созд.', ftDateTime, 'h');
  TDateTimeField(F).DisplayFormat := sprDateTimeFieldFormat;
  F.Visible := False;
  F := Result.AddField('UserIns', '#Польз. созд.', ftInteger, 'h');
  F.DisplayWidth := 8;
  F.Visible := False;
  F := Result.AddField('UserUpd', '#Польз. изм.', ftInteger, 'h');
  F.DisplayWidth := 8;
  F.Visible := False;
  F := Result.AddField('SrcBasisId', '#Основ. опер.', ftInteger, 'h');
  F.DisplayWidth := 8;
  F.Visible := False;
  F := Result.AddField('ResBasisId', '#Основ. рез.', ftInteger, 'h');
  F.DisplayWidth := 8;
  F.Visible := False;
  F := Result.AddField('SignAuto', 'Авт.', ftInteger, 'h');
  F.DisplayWidth := 8;
  F.Visible := False;
  F := Result.AddField('Phase', 'Phase', ftInteger, 'q');
  F.DisplayWidth := 10;
  F.Visible := false;
  Result.ItemDlgClassName := 'TOrderHistoryDlg';
  A := Result.AddAction('aEndErrorOrderHistory', 'Завершить действие', Self.EndErrorOrderHistory);
  A.Enabled := CanEndErrorOrderHistory;
end;

function TdmJSO.InnerGetOrderHistory: TsprQuery;
begin
  if not Assigned(FqrOrderHistory) then
  begin
    FqrOrderHistory := CreateOrderHistory;
  end;
  FqrOrderHistory.Debug := FDebug;
  Result := FqrOrderHistory;
end;

function TdmJSO.GetOrderHistory(OrderId: Integer; AActive: Boolean): TsprQuery;
begin
  Result := InnerGetOrderHistory;
  Result.Order.By('Id');
  Result.Order.By('Id');
  Result.Active := False;
  Result.AddFilter('OrderFilter', 'h.OrderId = ' + IntToStr(OrderId), 'SlaveGroup');
  Result.Active := AActive;
end;

function TdmJSO.CreateOrderStatus: TsprQuery;
var
  F: TField;
begin
  Result := TsprQuery.Create(Self);
  Result.Connection := Form1.ADOC_STAT;
  Result.BaseTable := 'dbo.t_jso_OrderStatus';
  Result.SQLTemplate.Text :=
      'use WorkWith_Gamma ' + clrf +
      'select s.* ' + clrf +
      ' from dbo.t_jso_OrderStatus s with (nolock) ' + clrf +
      '&Joins' + clrf +
      '&Where' + clrf +
      '&Order';
  F := Result.AddField('row_id', 'ID', ftInteger, 's');
  F.DisplayWidth := 10;
  F := Result.AddField('name', 'Наименование', ftString, 's');
  F.Size := 100;
  F.DisplayWidth := 30;
  Result.Order.By('name');
end;

function TdmJSO.CreateActionResOrderStatus: TsprQuery;
begin
  Result := CreateOrderStatus;
  Result.SQLTemplate.Text :=
      'use WorkWith_Gamma ' + clrf +
      'select distinct s.row_id, s.name ' + clrf +
      '  from dbo.v_jso_BPSpec bs with(nolock) ' + clrf +
      '         join dbo.t_jso_OrderStatus s with(nolock) on bs.ResStatusId = s.row_id ' + clrf +
      '&Joins' + clrf +
      ' where bs.BPId = :BPId ' + clrf +
      '   and bs.ActionCode = :ActionCode ' + clrf +
      '   and bs.SrcStatusId = :SrcStatusId ' + clrf +
      '   and bs.SrcBasisId = :SrcBasisId ' + clrf +
      '   and bs.ResBasisId = :ResBasisId ' + clrf +
      '&WhereValue' + clrf +
      '&Order';
  Result.FieldByName('row_id').Origin := 's.ResStatusId';
  Result.FieldByName('row_id').Origin := 's.ResStatusId';
  Result.Parameters.CreateParameter('BPId', ftInteger, pdInput, 0, 0);
  Result.Parameters.CreateParameter('ActionCode', ftString, pdInput, 50, '-');
  Result.Parameters.CreateParameter('SrcStatusId', ftInteger, pdInput, 0, 0);
  Result.Parameters.CreateParameter('SrcBasisId', ftInteger, pdInput, 0, 0);
  Result.Parameters.CreateParameter('ResBasisId', ftInteger, pdInput, 0, 0);
  Result.Debug := FDebug;
end;

function TdmJSO.GetActionSrcOrderStatus(Query: TsprQuery; SrcStatusId: Integer; AActive: Boolean): TsprQuery;
begin
  if not Assigned(Query) then
  begin
    Result := CreateOrderStatus;
    Result.SQLTemplate.Text :=
      'use WorkWith_Gamma ' + clrf +
      'select s.* ' + clrf +
      ' from dbo.t_jso_OrderStatus s with (nolock) ' + clrf +
      '&Joins' + clrf +
      ' where s.row_id = :SrcStatusId ' + clrf +
      '&WhereValue' + clrf +
      '&Order';
    Result.Parameters.CreateParameter('SrcStatusId', ftInteger, pdInput, 0, 0);
  end else
    Result := Query;
  Result.Debug := FDebug;
  Result.Active := false;
  Result.Parameters.ParamByName('SrcStatusId').Value := SrcStatusId;
  Result.Active := AActive;
end;

function TdmJSO.GetActionResOrderStatus(Query: TsprQuery; BpId: Integer; ActionCode: string;
  SrcStatusId: Integer; SrcBasisId: Integer; ResBasisId: Integer;
  AActive: Boolean): TsprQuery;
begin
  if not Assigned(Query) then
    Result := CreateActionResOrderStatus
  else
    Result := Query;
  Result.Debug := FDebug;
  Result.Active := false;
  Result.Parameters.ParamByName('BPId').Value := BpId;
  Result.Parameters.ParamByName('ActionCode').Value := ActionCode;
  Result.Parameters.ParamByName('SrcStatusId').Value := SrcStatusId;
  Result.Parameters.ParamByName('SrcBasisId').Value := SrcBasisId;
  Result.Parameters.ParamByName('ResBasisId').Value := ResBasisId;
  Result.Active := AActive;
end;

function TdmJSO.CreateActions: TsprQuery;
var
  F: TField;
begin
  Result := TsprQuery.Create(Self);
  Result.Connection := Form1.ADOC_STAT;
  Result.BaseTable := 'dbo.t_UserUnitAction';
  Result.SQLTemplate.Text :=
      'use WorkWith_Gamma ' + clrf +
      'select a.* ' + clrf +
      ' from dbo.t_UserUnitAction a with (nolock) ' + clrf +
      '&Joins' + clrf +
      '&Where' + clrf +
      '&Order';
  F := Result.AddField('rn', 'ID', ftInteger, 'a');
  F.DisplayWidth := 10;
  F := Result.AddField('Name', 'Наименование', ftString, 'a');
  F.Size := 100;
  F.DisplayWidth := 30;
  F := Result.AddField('ActionCode', 'Код', ftString, 'a');
  F.Size := 50;
  F.DisplayWidth := 30;
  Result.Order.By('name');
  Result.Debug := FDebug;
end;

class function TdmJSO.IsSystemUser(UserId: Integer): Boolean;
begin
  Result := UserId = 311;
end;

function TdmJSO.GetOrderActions(Query: TsprQuery; BpId: Integer; SrcStatusId: Integer;
  AActive: Boolean = true; UserId: Integer = 0): TsprQuery;
var
  F: TField;
begin
  if not Assigned(Query) then
  begin
    Result := CreateActions;
    if IsSystemUser(UserId) then
      Result.SQLTemplate.Text :=
        'use WorkWith_Gamma ' + clrf +
        'select a.* ' + clrf +
        ' from ( ' + clrf +
        '   select a.rn, a.Name, a.ActionCode, bs.TypeAction, min(bs.Priority) Priority ' + clrf +
        '     from dbo.v_jso_BPSpec bs with(nolock) ' + clrf +
        '            join dbo.t_UserUnitAction a with(nolock) on bs.ActionCode = a.ActionCode ' + clrf +
        '    where bs.BPId = :BPId ' + clrf +
        '      and bs.SrcStatusId = :SrcStatusId ' + clrf +
        '   group by a.rn, a.Name, a.ActionCode, bs.TypeAction) a ' + clrf +
        '&Joins' + clrf +
        '&Where' + clrf +
        '&Order'
    else
      Result.SQLTemplate.Text :=
        'use WorkWith_Gamma ' + clrf +
        'select a.* ' + clrf +
        ' from ( ' + clrf +
        '   select a.rn, a.Name, a.ActionCode, bs.TypeAction, min(bs.Priority) Priority ' + clrf +
        '     from dbo.v_jso_BPSpec bs with(nolock) ' + clrf +
        '            join dbo.t_UserUnitAction a with(nolock) on bs.ActionCode = a.ActionCode ' + clrf +
        '    where bs.BPId = :BPId ' + clrf +
        '      and bs.SrcStatusId = :SrcStatusId ' + clrf +
        '      and isnull(bs.SignSystem, 0) = 0 ' + clrf +
        '   group by a.rn, a.Name, a.ActionCode, bs.TypeAction) a ' + clrf +
        '&Joins' + clrf +
        '&Where' + clrf +
        '&Order';
    F := Result.AddField('TypeAction', 'Тип действ.', ftInteger, 'a');
    F.DisplayWidth := 10;
    F := Result.AddField('Priority', 'Приоритет', ftInteger, 'a');
    F.DisplayWidth := 10;
    Result.Parameters.CreateParameter('BpId', ftInteger, pdInput, 0, 0);
    Result.Parameters.CreateParameter('SrcStatusId', ftInteger, pdInput, 0, 0);
  end else
    Result := Query;
  Result.Debug := FDebug;
  Result.Order.By('Priority');
  Result.Active := false;
  Result.Parameters.ParamByName('SrcStatusId').Value := SrcStatusId;
  Result.Parameters.ParamByName('BpId').Value := BpId;
  Result.Active := AActive;
end;

function TdmJSO.CreateActionBasis: TsprQuery;
var
  F: TField;
begin
  Result := TsprQuery.Create(Self);
  Result.Connection := Form1.ADOC_STAT;
  Result.BaseTable := 'dbo.t_jzs_ActionFoundation';
  Result.SQLTemplate.Text :=
      'use WorkWith_Gamma ' + clrf +
      'select b.* ' + clrf +
      ' from dbo.t_jzs_ActionFoundation b with(nolock) ' + clrf +
      '&Joins' + clrf +
      '&Where' + clrf +
      '&Order';
  F := Result.AddField('row_id', 'ID', ftInteger, 'b');
  F.DisplayWidth := 10;
  F := Result.AddField('name', 'Наименование', ftString, 'b');
  F.Size := 100;
  F.DisplayWidth := 30;
  Result.Order.By('name');
  Result.Debug := FDebug;
end;

function TdmJSO.GetOrderSrcBasis(Query: TsprQuery; BpId: Integer; SrcStatusId: Integer;
  ActionCode: string; AActive: Boolean): TsprQuery;
begin
  if not Assigned(Query) then
  begin
    Result := CreateActionBasis;
    //Result.Debug := true;
    Result.SQLTemplate.Text :=
      'use WorkWith_Gamma ' + clrf +
      'select distinct b.row_id, b.name ' + clrf +
      ' from dbo.v_jso_BPSpec bs with(nolock) ' + clrf +
      '        join dbo.t_jzs_ActionFoundation b with(nolock) on bs.SrcBasisId = b.row_id' + clrf +
      '&Joins' + clrf +
      ' where bs.BPId = :BPId ' + clrf +
      '   and bs.SrcStatusId = :SrcStatusId ' + clrf +
      '   and bs.ActionCode = :ActionCode ' + clrf +
      '&WhereValue' + clrf +
      '&Order';
    Result.Parameters.CreateParameter('BpId', ftInteger, pdInput, 0, 0);
    Result.Parameters.CreateParameter('SrcStatusId', ftInteger, pdInput, 0, 0);
    Result.Parameters.CreateParameter('ActionCode', ftString, pdInput, 50, '-');
  end else
    Result := Query;
  Result.Debug := FDebug;
  Result.Active := false;
  Result.Parameters.ParamByName('SrcStatusId').Value := SrcStatusId;
  Result.Parameters.ParamByName('BpId').Value := BpId;
  Result.Parameters.ParamByName('ActionCode').Value := ActionCode;
  Result.Active := AActive;
end;

function TdmJSO.GetOrderResBasis(Query: TsprQuery; BpId: Integer; SrcStatusId: Integer;
  ActionCode: string; SrcBasisId: Integer; AActive: Boolean = true): TsprQuery;
var
  F: TField;  
begin
  if not Assigned(Query) then
  begin
    Result := CreateActionBasis;
    //Result.Debug := true;
    Result.SQLTemplate.Text :=
      'use WorkWith_Gamma ' + clrf +
      'select distinct b.row_id, b.name, bs.ResBasisPriority ' + clrf +
      ' from dbo.v_jso_BPSpec bs with(nolock) ' + clrf +
      '        join dbo.t_jzs_ActionFoundation b with(nolock) on bs.ResBasisId = b.row_id' + clrf +
      '&Joins' + clrf +
      ' where bs.BPId = :BPId ' + clrf +
      '   and bs.SrcStatusId = :SrcStatusId ' + clrf +
      '   and bs.ActionCode = :ActionCode ' + clrf +
      '   and bs.SrcBasisId = :SrcBasisId ' + clrf +
      '&WhereValue' + clrf +
      '&Order';
    F := Result.AddField('ResBasisPriority', 'Приоритет', ftInteger, 'bs');
    F.DisplayWidth := 10;
    Result.Parameters.CreateParameter('BpId', ftInteger, pdInput, 0, 0);
    Result.Parameters.CreateParameter('SrcStatusId', ftInteger, pdInput, 0, 0);
    Result.Parameters.CreateParameter('ActionCode', ftString, pdInput, 50, '-');
    Result.Parameters.CreateParameter('SrcBasisId', ftInteger, pdInput, 0, 0);
    Result.Order.By('ResBasisPriority');
  end else
    Result := Query;
  Result.Debug := FDebug;
  Result.Active := false;
  Result.Parameters.ParamByName('SrcStatusId').Value := SrcStatusId;
  Result.Parameters.ParamByName('BpId').Value := BpId;
  Result.Parameters.ParamByName('ActionCode').Value := ActionCode;
  Result.Parameters.ParamByName('SrcBasisId').Value := SrcBasisId;
  Result.Active := AActive;
end;

function TdmJSO.CreateBP: TsprQuery;
var
  F: TField;
begin
  Result := TsprQuery.Create(Self);
  Result.Connection := Form1.ADOC_STAT;
  Result.BaseTable := 'dbo.v_jso_BP';
  Result.SQLTemplate.Text :=
      'use WorkWith_Gamma ' + clrf +
      'select b.* ' + clrf +
      ' from dbo.v_jso_BP b with (nolock) ' + clrf +
      '&Joins' + clrf +
      '&Where' + clrf +
      '&Order';
  F := Result.AddField('ID', 'ID', ftInteger, 'b');
  F.DisplayWidth := 10;
  F := Result.AddField('Name', 'Наименование', ftString, 'b');
  F.Size := 100;
  F.DisplayWidth := 50;
  Result.Debug := FDebug;
end;

function TdmJSO.CreateBPSpec(BP: TDataSet; SrcStatus: TDataSet; ResStatus: TDataSet; Actions: TDataSet): TsprQuery;
var
  F: TField;
  A: TQueryAction;
begin
  Result := TsprQuery.Create(Self);
  Result.Connection := Form1.ADOC_STAT;
  Result.BaseTable := 'dbo.t_jso_BPSpec';
  Result.SQLTemplate.Text :=
      'select s.* ' + clrf +
      ' from dbo.t_jso_BPSpec s ' + clrf +
      '&Joins' + clrf +
      '&Where' + clrf +
      '&Order';
  F := Result.AddField('ID', 'ID', ftInteger, 's');
  F.DisplayWidth := 10;
  F.ReadOnly := True;
  F := Result.AddField('BpId', '#БП', ftInteger, 's');
  F.DisplayWidth := 10;
//  F.ReadOnly := True;
  
  F := Result.AddLookupField('BpName', 'БП', ftString, BP, 'BpId', 'id', 'Name');
  F.Size := 100;
  F.DisplayWidth := 15;
  F.LookupCache := true;
  F.Origin := 'dbo.v_jso_BP,id,name,left,with (nolock)';

  F := Result.AddLookupField('SrcStatus', 'ИСХ. СТАТУС', ftString, SrcStatus, 'SrcStatusId', 'row_id', 'Name');
  F.Size := 100;
  F.LookupCache := true;
  F.DisplayWidth := 25;
  F.Origin := 'dbo.t_jso_OrderStatus,row_id,name,left,with (nolock)';

  F := Result.AddLookupField('ActionName', 'Действие', ftString, Actions, 'ActionCode', 'ActionCode', 'Name');
  F.Size := 100;
  F.DisplayWidth := 25;
  F.LookupCache := true;
  F.Origin := 'dbo.t_UserUnitAction,ActionCode,name,left,with (nolock)';

  F := Result.AddLookupField('ResStatus', 'РЕЗ. СТАТУС', ftString, ResStatus, 'ResStatusId', 'row_id', 'Name');
  F.Size := 100;
  F.DisplayWidth := 25;
  F.LookupCache := true;
  F.Origin := 'dbo.t_jso_OrderStatus,row_id,name,left,with (nolock)';

  F := Result.AddField('TimeLimit', 'Лимит', ftInteger, 's');
  F.DisplayWidth := 8;

  F := Result.AddField('Priority', 'Приоритет', ftInteger, 's');
  F.DisplayWidth := 8;

  F := Result.AddField('TypeAction', 'Тип обраб.', ftInteger, 's');
  F.DisplayWidth := 8;

  F := Result.AddField('SrcStatusId', '#ИСХ. СТАТУС', ftInteger, 's');
  F.DisplayWidth := 10;
  //F.ReadOnly := True;

  F := Result.AddField('ActionCode', 'Действие Код', ftString, 's');
  F.Size := 50;
  F.DisplayWidth := 25;
  //F.ReadOnly := True;
  
  F := Result.AddField('ResStatusId', '#РЕЗ. СТАТУС', ftInteger, 's');
  F.DisplayWidth := 10;
  //F.ReadOnly := True;

  F := Result.AddField('SignSystem', 'Систем.', ftSmallInt, 's');
  F.DisplayWidth := 5;

  Result.Debug := FDebug;
  A := Result.AddAction('aDeleteBPSpec', 'Удалить карту', Self.DeleteBPSpec);
  A.Enabled := CanDeleteBPSpec;
end;

function TdmJSO.CreateBPSpecBasis(SrcBasis: TDataSet; ResBasis: TDataSet): TsprQuery;
var
  F: TField;
begin
  Result := TsprQuery.Create(Self);
  Result.Connection := Form1.ADOC_STAT;
  Result.BaseTable := 'dbo.t_jso_BPSpecBasis';
  Result.SQLTemplate.Text :=
      'select s.* ' + clrf +
      ' from dbo.t_jso_BPSpecBasis s ' + clrf +
      '&Joins' + clrf +
      ' where s.BPSpecId = :BPSpecId ' + clrf +
      '&WhereValue' + clrf +
      '&Order';
  Result.Parameters.CreateParameter('BPSpecId', ftInteger, pdInput, 0, 0);
  Result.AfterInsert := BPSpecBasisAfterInsert;
  F := Result.AddField('ID', 'ID', ftInteger, 's');
  F.DisplayWidth := 10;
  F.ReadOnly := True;

  F := Result.AddField('BpSpecId', '#Карта статусов', ftInteger, 's');
  F.DisplayWidth := 10;

  F := Result.AddLookupField('SrcBasis', 'Основание', ftString, SrcBasis, 'SrcBasisId', 'row_id', 'Name');
  F.Size := 100;
  F.DisplayWidth := 30;
  F.LookupCache := true;
  F.Origin := 'dbo.t_jzs_ActionFoundation,row_id,name,left,with (nolock)';

  F := Result.AddLookupField('ResBasis', 'Результат', ftString, ResBasis, 'ResBasisId', 'row_id', 'Name');
  F.Size := 100;
  F.DisplayWidth := 30;
  F.LookupCache := true;
  F.Origin := 'dbo.t_jzs_ActionFoundation,row_id,name,left,with (nolock)';

  F := Result.AddField('SrcBasisId', '#Основание', ftInteger, 's');
  F.DisplayWidth := 10;

  F := Result.AddField('ResBasisId', '#Результат', ftInteger, 's');
  F.DisplayWidth := 10;

  Result.Debug := FDebug;
end;

procedure TdmJSO.BPSpecBasisAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('BpSpecId').Value := TADOQuery(DataSet).Parameters.ParamValues['BPSpecId'];
  DataSet.FieldByName('SrcBasisId').Value := 67;
  DataSet.FieldByName('ResBasisId').Value := 67;
end;

function TdmJSO.CanDoOrderAction(OrderId: Integer; var ErrMsg: string): Boolean;
var
  IErr : integer;
  vHistoryId: integer;
begin
  ErrMsg := '';
  Result := False;
  try
    spLastOrderOpenAction.Parameters.ParamValues['@OrderId']  := OrderId;
    spLastOrderOpenAction.ExecProc;
    IErr := spLastOrderOpenAction.Parameters.ParamValues['@RETURN_VALUE'];
    vHistoryId := spLastOrderOpenAction.Parameters.ParamValues['@HistoryId'];
    if IErr <> 0 then
      ErrMsg := spLastOrderOpenAction.Parameters.ParamValues['@ErrMsg']
    else
    begin
      Result := vHistoryId = 0;
      if not Result then
        ErrMsg := 'Заказ в ОБРАБОТКЕ.';
    end;

  except
    on e:Exception do begin
      ErrMsg := e.Message;
    end;
  end;

end;

function TdmJSO.GetOrderAddFields(OrderId: Integer): TOrderHeaderAddFields;
begin
  qrOrderAddFields.Active := False;
  qrOrderAddFields.Parameters.ParamValues['OrderId'] := OrderId;
  qrOrderAddFields.Active := True;
  Result.Note := '';
  Result.Comments := '';
  if not qrOrderAddFields.IsEmpty then
  begin
    Result.Note := qrOrderAddFields.FieldByName('SNote').AsString;
    Result.Comments := qrOrderAddFields.FieldByName('SOrderComment').AsString;
  end;
  qrOrderAddFields.Active := False;
end;

function TdmJSO.GetOrderHAddFields(OrderId: Integer): TOrderHeaderHAddFields;
begin
  qrOrderHAddFields.Active := False;
  qrOrderHAddFields.Parameters.ParamValues['OrderId'] := OrderId;
  qrOrderHAddFields.Active := True;
  Result.HistoryComments := '';
  Result.HistoryExecMsg := '';
  if not qrOrderHAddFields.IsEmpty then
  begin
    Result.HistoryComments := qrOrderHAddFields.FieldByName('HComments').AsString;
    Result.HistoryExecMsg := qrOrderHAddFields.FieldByName('HExecMsg').AsString;
  end;
  qrOrderHAddFields.Active := False;
end;


function TdmJSO.CreateProc(ACompName: string; AProcName: string): TADOStoredProc;
begin
  Result := TADOStoredProc.Create(Self);
  with Result do
  begin
    Name := ACompName;
    Connection := Form1.ADOC_STAT;
    ProcedureName := AProcName;
    Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, 0, null);
    CommandTimeout := 100;
  end;
end;

procedure TdmJSO.ShowGoodsPharmState(ItemCode: Integer; AptekaId: Integer; Caption: string);
var
  vProc: TADOStoredProc;
  P: TParameter;
  vIErr: Integer;
  vExecMsg: string;
begin
  vProc := CreateProc('spCheckGoodsState', 'p_jso_CheckGoodsState');
  try
    try
      with vProc do
      begin
        CommandTimeout := 300;
        Parameters.CreateParameter('@ItemCode', ftInteger, pdInput, 0, ItemCode);
        Parameters.CreateParameter('@AptekaId', ftInteger, pdInput, 0, AptekaId);
        Parameters.CreateParameter('@Qty', ftInteger, pdInputOutput, 0, null);
        Parameters.CreateParameter('@QtyReserved', ftInteger, pdInputOutput, 0, null);
        Parameters.CreateParameter('@QtyCanReturn', ftInteger, pdInputOutput, 0, null);
        P := Parameters.CreateParameter('@AvgPrice', ftBCD, pdInputOutput, 0, null);
        P.Precision := 18;
        P.NumericScale := 2;
        Parameters.CreateParameter('@ExecMsg', ftString, pdInputOutput, 1000, null);
      end;
      vProc.ExecProc;
      vIErr   := vProc.Parameters.ParamValues['@RETURN_VALUE'];
      vExecMsg := vProc.Parameters.ParamValues['@ExecMsg'];
      if vIErr <> 0 then
        ShowError('Сбой при проверке наличия товара в аптеке:' + chr(10) + vExecMsg)
      else
      begin
        ShowMessage(Caption + chr(10) +
                    'Остаток = ' + VarToStr(vProc.Parameters.ParamValues['@Qty']) + chr(10) +
                    'В резерве = ' + VarToStr(vProc.Parameters.ParamValues['@QtyReserved']) + chr(10) +
                    'Средняя цена = ' + VarToStr(vProc.Parameters.ParamValues['@AvgPrice']) + chr(10) +
                    'Дост. к возврату = ' + VarToStr(vProc.Parameters.ParamValues['@QtyCanReturn']) + chr(10) +
                    vExecMsg
                   );
      end;
    except
      on E: Exception do
        ShowError('Сбой при проверке наличия товара в аптеке:' + chr(10) + E.Message);
    end;
  finally
    if Assigned(vProc) then
      vProc.Free;
  end;
end;

function TdmJSO.CreateUsers: TsprQuery;
var
  F: TField;
begin
  Result := TsprQuery.Create(Self);
  Result.Connection := Form1.ADOC_STAT;
  Result.BaseTable := 'dbo.ava_user_stat';
  Result.SQLTemplate.Text :=
      'use WorkWith_Gamma ' + clrf +
      'select u.* ' + clrf +
      ' from dbo.ava_user_stat u with (nolock) ' + clrf +
      '&Joins' + clrf +
      '&Where' + clrf +
      '&Order';
  F := Result.AddField('Name_User', 'Наименование', ftString, 'u');
  F.Size := 100;
  F.DisplayWidth := 50;
  F := Result.AddField('row_id', 'ID', ftInteger, 'u');
  F.DisplayWidth := 10;
  Result.Order.By('Name_User');
  Result.Debug := FDebug;
end;

function TdmJSO.CreateConditions: TsprQuery;
var
  F: TField;
begin
  Result := TsprQuery.Create(Self);
  Result.Connection := Form1.ADOC_STAT;
  Result.BaseTable := 'dbo.v_jso_CondMap';
  Result.SQLTemplate.Text :=
      'use WorkWith_Gamma ' + clrf +
      'select m.* ' + clrf +
      ' from dbo.v_jso_CondMap m with (nolock) ' + clrf +
      '&Joins' + clrf +
      '&Where' + clrf +
      '&Order';
  F := Result.AddField('Name', 'Наименование', ftString, 'm');
  F.Size := 100;
  F.DisplayWidth := 50;
  F := Result.AddField('ID', 'ID', ftInteger, 'm');
  F.DisplayWidth := 10;
  F := Result.AddField('ID', 'ID', ftInteger, 'm');
  F.DisplayWidth := 10;
  F := Result.AddField('Priority', 'ID', ftBCD, 'm');
  F.DisplayWidth := 10;
  F.Visible := False;

  Result.Order.By('Priority');
  Result.Debug := FDebug;
end;

function TdmJSO.GetConds: TsprQuery;
begin
  if not Assigned(FqrConds) then
    FqrConds := CreateConditions;
  FqrConds.Debug := FDebug;
  Result := FqrConds;
end;

function TdmJSO.GetCondSQL(CondId: Integer; Aliase: string; PriorityFName: string = 'StatusPriority'): string;
var
  vProc: TADOStoredProc;
  vIErr: Integer;
  vExecMsg: string;
begin
  Result := '';
  vProc := CreateProc('spGetSQLCond', 'p_jso_GetSQLCond');
  try
    try
      with vProc do
      begin
        Parameters.CreateParameter('@CondId', ftInteger, pdInput, 0, CondId);
        Parameters.CreateParameter('@Alias', ftString, pdInput, 10, Aliase);
        Parameters.CreateParameter('@SQLCond', ftString, pdInputOutput, 2000, null);
        Parameters.CreateParameter('@ExecMsg', ftString, pdInputOutput, 1000, null);
        Parameters.CreateParameter('@PriorityFName', ftString, pdInput, 100, PriorityFName);
      end;
      vProc.ExecProc;
      vIErr   := vProc.Parameters.ParamValues['@RETURN_VALUE'];
      vExecMsg := vProc.Parameters.ParamValues['@ExecMsg'];
      if vIErr <> 0 then
        ShowError('Сбой формирования условия отбора:' + chr(10) + vExecMsg)
      else
        Result := vProc.Parameters.ParamValues['@SQLCond']
    except
      on E: Exception do
        ShowError('Сбой формирования условия отбора:' + chr(10) + E.Message);
    end;
  finally
    if Assigned(vProc) then
      vProc.Free;
  end;
end;

function TdmJSO.CanDoOrderAction(AOrderId: Integer; ActionCode: string;
  var ErrMsg: string): Boolean;
var
  IErr : integer;
  vHistoryId: integer;
begin
  ErrMsg := '';
  Result := False;
  try
    spCanDoOrderAction.Parameters.ParamValues['@OrderId']  := AOrderId;
    spCanDoOrderAction.Parameters.ParamValues['@ActionCode']  := ActionCode;
    spCanDoOrderAction.ExecProc;
    IErr := spCanDoOrderAction.Parameters.ParamValues['@RETURN_VALUE'];
    vHistoryId := spCanDoOrderAction.Parameters.ParamValues['@HistoryId'];
    if IErr <> 0 then
      ErrMsg := spCanDoOrderAction.Parameters.ParamValues['@ErrMsg']
    else
    begin
      Result := vHistoryId = 0;
      if not Result then
        ErrMsg := 'Заказ в ОБРАБОТКЕ.';
    end;
  except
    on e:Exception do begin
      ErrMsg := e.Message;
    end;
  end;
end;

procedure TdmJSO.DeleteBPSpec(DataSet: TsprQuery);
var
  vProc: TADOStoredProc;
  vIErr: Integer;
  vErrMsg: string;
begin
  if MessageDlg('Удалить карту ID=' + DataSet.FieldByName('ID').AsString +
    '?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    exit;
  vProc := CreateProc('spDelBPSpec', 'p_jso_BPSpecDel');
  try
    try
      with vProc do
      begin
        Parameters.CreateParameter('@BPSpec', ftInteger, pdInput, 0, DataSet.FieldByName('ID').AsInteger);
        Parameters.CreateParameter('@ErrMsg', ftString, pdInputOutput, 1000, null);
      end;
      vProc.ExecProc;
      vIErr   := vProc.Parameters.ParamValues['@RETURN_VALUE'];
      if vIErr <> 0 then
      begin
        vErrMsg := VarToStr(vProc.Parameters.ParamValues['@ErrMsg']);
        ShowError('Ошибка:' + chr(10) + vErrMsg);
      end;
    except
      on E: Exception do
        ShowError('Ошибка:' + chr(10) + E.Message);
    end;
  finally
    if Assigned(vProc) then
      vProc.Free;
  end;
end;

function TdmJSO.CanDeleteBPSpec(DataSet: TsprQuery): Boolean;
begin
  Result := DataSet.Active and (DataSet.RecordCount > 0);
end;

function TdmJSO.CreateCommonDict(ADict: Integer): TsprQuery;
var
  F: TField;
begin
  Result := TsprQuery.Create(Self);
  Result.Connection := Form1.ADOC_STAT;
  Result.BaseTable := 'dbo.t_DictContent';
  Result.SQLTemplate.Text :=
      'use WorkWith_Gamma ' + clrf +
      'select dc.* ' + clrf +
      '  from dbo.t_DictContent dc with (nolock) ' + clrf +
      '&Joins' + clrf +
      ' where dc.DictId = :Dict_ID ' + clrf +
      '&WhereValue' + clrf +
      '&Order';
  F := Result.AddField('ID', '#', ftInteger, 'dc');
  F.DisplayWidth := 10;
  F := Result.AddField('ValueNum', 'Id', ftBCD, 'dc');
  F.DisplayWidth := 10;
  F := Result.AddField('ValueStr', 'Наименование', ftString, 'dc');
  F.Size := 100;
  F.DisplayWidth := 50;
  Result.Parameters.CreateParameter('Dict_ID', ftInteger, pdInput, 0, 0);
  Result.Parameters.ParamValues['Dict_ID'] := ADict;
  Result.Order.By('ValueNum');
  Result.Debug := FDebug;
end;

function TdmJSO.CreateAppealType: TsprQuery;
begin
  Result := CreateCommonDict(9);
end;

function TdmJSO.CreateAppealMethod: TsprQuery;
begin
  Result := CreateCommonDict(10);
end;

function TdmJSO.CreateAppealState: TsprQuery;
begin
  Result := CreateCommonDict(11);
end;

function TdmJSO.CreateClientType: TsprQuery;
begin
  Result := CreateCommonDict(8);
end;

function TdmJSO.CreateClient(IsRef: Boolean; ClientType: TDataSet): TsprQuery;
var
  F: TField;
begin
  Result := TsprQuery.Create(Self);
  Result.Connection := Form1.ADOC_STAT;
  Result.BaseTable := 'dbo.t_Client';
  if IsRef then
    Result.SQLTemplate.Text :=
       'use WorkWith_Gamma ' + clrf +
       'select c.*, ui.Name_User as UserInsName, uu.Name_User as UserUpdName, ' + clrf +
       '       (select count(*) from dbo.t_jso_Appeal with(nolock) where mphone = c.MPhone) AppealCnt ' + clrf +
       '  from dbo.t_Client c with (nolock) ' + clrf +
       '       left join dbo.ava_user_stat ui with(nolock) on c.UserIns = ui.row_id ' + clrf +
       '       left join dbo.ava_user_stat uu with(nolock) on c.UserUpd = uu.row_id ' + clrf +
       '&Joins' + clrf +
       '&Where' + clrf +
       '&Order'
  else
  begin
    Result.SQLTemplate.Text :=
       'use WorkWith_Gamma ' + clrf +
       'select c.* ' + clrf +
       '  from dbo.t_Client c with (nolock) ' + clrf +
       '&Joins' + clrf +
       ' where c.MPhone = isnull(:MPhone, c.MPhone)' + clrf +
       '&WhereValue' + clrf +
       '&Order';
  end;


  if isRef then
  begin
    F := Result.AddField('MPhone', 'ТЕЛЕФОН', ftString, 'c');
    F.Size := 10;
    F.DisplayWidth := 12;
    F.ReadOnly := True;
  end;
  F := Result.AddField('Name', 'Наименование', ftString, 'c');
  F.Size := 255;
  F.DisplayWidth := 20;
  F := Result.AddField('TypeId', 'TypeId', ftInteger, 'c');
  F.Visible := false;
  if Assigned(ClientType) then
  begin
    F := Result.AddLookupField('TypeName', 'Тип', ftString, ClientType, 'TypeId', 'ValueNum', 'ValueStr');
    F.Size := 100;
    F.DisplayWidth := 10;
    F.LookupCache := true;
    F.Origin := 'dbo.v_ClientType,id,name,left,with (nolock)';
  end;
  if not IsRef then
    Result.Parameters.CreateParameter('MPhone', ftString, pdInput, 10, null);
  if isRef then
  begin
    F := Result.AddField('Comments', 'Примечание', ftString, 'c');
    F.Size := 255;
    F.DisplayWidth := 20;

    F := Result.AddField('InsDate', 'Дата созд.', ftDateTime, 'c');
    TDateTimeField(F).DisplayFormat := sprDateTimeFieldFormat;
    F.ReadOnly := True;

    F := Result.AddField('UserInsName', 'Создал', ftString, 'ui');
    F.Origin := 'ui.Name_User';
    F.DisplayWidth := 10;
    F.ReadOnly := True;

    F := Result.AddField('UpdDate', 'Дата изм.', ftDateTime, 'c');
    TDateTimeField(F).DisplayFormat := sprDateTimeFieldFormat;
    F.ReadOnly := True;

    F := Result.AddField('UserUpdName', 'Изменил', ftString, 'uu');
    F.Origin := 'uu.Name_User';
    F.DisplayWidth := 10;
    F.ReadOnly := True;

    F := Result.AddField('AppealCnt', 'Обращений', ftInteger, 'c');
    F.ReadOnly := True;
    F.DisplayWidth := 10;
    F.Origin := '(select count(*) from dbo.t_jso_Appeal with(nolock) where mphone = c.MPhone)';
  end;
  F := Result.AddField('ID', 'Id', ftInteger, 'c');
  F.ReadOnly := True;
  F.DisplayWidth := 10;
  Result.Debug := FDebug;
end;

function TdmJSO.GetClient(Phone: string): TsprQuery;
begin
  if not Assigned(FqrClient) then
    FqrClient := CreateClient(False, nil);
  Result := FqrClient;
  Result.Active := False;
  Result.Parameters.ParamValues['MPhone'] := Phone;
  Result.Active := True;
end;

function TdmJSO.GetAppealType(AActive: Boolean = true): TsprQuery;
begin
  if not Assigned(FqrAppealType) then
    FqrAppealType := CreateAppealType;
  Result := FqrAppealType;
  Result.Active := AActive;
end;

function TdmJSO.GetAppealMethod(AActive: Boolean = true): TsprQuery;
begin
  if not Assigned(FqrAppealMethod) then
    FqrAppealMethod := CreateAppealMethod;
  Result := FqrAppealMethod;
  Result.Active := AActive;
end;

function TdmJSO.GetAppealState(AActive: Boolean = true): TsprQuery;
begin
  if not Assigned(FqrAppealState) then
    FqrAppealState := CreateAppealState;
  Result := FqrAppealState;
  FDebug := True;
  Result.Active := AActive;
end;

function TdmJSO.GetClientType(AActive: Boolean = true): TsprQuery;
begin
  if not Assigned(FqrClientType) then
    FqrClientType := CreateClientType;
  Result := FqrClientType;
  Result.Active := AActive;
end;

procedure TdmJSO.UpdClient(Phone: string; AName: string; AppealType: Variant;
  AContent: string; UserId: Integer; var AppealId: Integer);
var
  vProc: TADOStoredProc;
  vIErr: Integer;
  vErrMsg: string;
begin
  if (trim(Phone) = '') then
    exit;
  //or ((trim(AName) = '') and (trim(AContent) = '')) then

  vProc := CreateProc('spUpdClient', 'p_jso_UpdClient');
  try
    try
      with vProc do
      begin
        Parameters.CreateParameter('@Phone', ftString, pdInput, 10, Phone);
        Parameters.CreateParameter('@Name', ftString, pdInput, 255, AName);
        Parameters.CreateParameter('@AppealType', ftInteger, pdInput, 0, AppealType);
        Parameters.CreateParameter('@Content', ftString, pdInput, 4000, aContent);
        Parameters.CreateParameter('@UserId', ftInteger, pdInput, 0, UserId);
        Parameters.CreateParameter('@ClientId', ftInteger, pdInputOutput, 0, null);
        Parameters.CreateParameter('@AppealId', ftInteger, pdInputOutput, 0, null);
        Parameters.CreateParameter('@ErrMsg', ftString, pdInputOutput, 1000, null);
        Parameters.CreateParameter('@inAppealId', ftInteger, pdInput, 0, AppealId);
      end;
      vProc.ExecProc;
      vIErr   := vProc.Parameters.ParamValues['@RETURN_VALUE'];
      if vIErr <> 0 then
      begin
        vErrMsg := VarToStr(vProc.Parameters.ParamValues['@ErrMsg']);
        ShowError('Ошибка:' + chr(10) + vErrMsg);
      end else
        AppealId := vProc.Parameters.ParamValues['@AppealId'];
    except
      on E: Exception do
        ShowError('Ошибка:' + chr(10) + E.Message);
    end;
  finally
    if Assigned(vProc) then
      vProc.Free;
  end;
end;

function TdmJSO.CreateIPTelMap: TsprQuery;
var
  F: TField;
  A: TQueryAction;
begin
  Result := TsprQuery.Create(Self);
  Result.Connection := Form1.ADOC_STAT;
  Result.BaseTable := 'dbo.t_IPTelMap';
  Result.SQLTemplate.Text :=
       //'use WorkWith_Gamma ' + clrf +
       'select m.*, case when m.MDate is not null then 7 else 0 end Phase' + clrf +
       '  from dbo.t_IPTelMap m with (nolock) ' + clrf +
       '&Joins' + clrf +
       '&Where' + clrf +
       '&Order';

  F := Result.AddField('CallerId', 'ТЕЛЕФОН', ftInteger, 'm');
  F.DisplayWidth := 10;
  F := Result.AddField('MDate', 'Дата откл.', ftDateTime, 'm');
  TDateTimeField(F).DisplayFormat := sprDateTimeFieldFormat;
  F.ReadOnly := True;
  F := Result.AddField('HostIP', 'IP адрес', ftString, 'm');
  F.Size := 50;
  F.DisplayWidth := 15;
  F := Result.AddField('HostName', 'Имя комп.', ftString, 'm');
  F.Size := 50;
  F.DisplayWidth := 15;
  F := Result.AddField('Channel', 'Канал', ftString, 'm');
  F.Size := 100;
  F.DisplayWidth := 10;
  F := Result.AddField('Comment', 'Примечание', ftString, 'm');
  F.Size := 255;
  F.DisplayWidth := 40;

  F := Result.AddField('Phase', 'Дост.', ftInteger, 'm');
  F.DisplayWidth := 8;
  F.ReadOnly := True;
  F.Visible := False;
  F.Origin := '(case when m.MDate is not null then 7 else 0 end)';
  A := Result.AddAction('aSetActive', 'Активировать/Деактивировать', SetIPTelActive);
  A.Enabled := CanSetIPTelActive;
  Result.Debug := FDebug;
end;

procedure TdmJSO.SetIPTelActive(DataSet: TsprQuery);
begin
  DataSet.CheckBrowseMode;
  DataSet.Edit;
  try
    DataSet.FieldByName('MDate').ReadOnly := False;
    if VarIsAssigned(DataSet.FieldByName('Mdate').Value) then
      DataSet.FieldByName('Mdate').Value := null
    else
      DataSet.FieldByName('Mdate').Value := Now;
    DataSet.Post;
  finally
    DataSet.FieldByName('MDate').ReadOnly := True;
  end;
end;

function TdmJSO.CanSetIPTelActive(DataSet: TsprQuery): Boolean;
begin
  Result := DataSet.Active and (DataSet.RecordCount > 0);
end;

function TdmJSO.CreateAppeal: TsprQuery;
var
  F: TField;
begin
  Result := TsprQuery.Create(Self);
  Result.Connection := Form1.ADOC_STAT;
  Result.BaseTable := 'dbo.v_jso_Appeal';
  Result.SQLTemplate.Text :=
       'use WorkWith_Gamma ' + clrf +
       'select a.* ' + clrf +
       '  from dbo.v_jso_Appeal a with (nolock) ' + clrf +
       '&Joins' + clrf +
       '&Where' + clrf +
       '&Order';

  F := Result.AddField('InsDate', 'Дата созд.', ftDateTime, 'a');
  TDateTimeField(F).DisplayFormat := sprDateTimeFieldFormat;
  F := Result.AddField('MPhone', 'ТЕЛЕФОН', ftString, 'a');
  F.Size := 10;
  F.DisplayWidth := 12;

  F := Result.AddField('TypeId', '#Тип', ftInteger, 'a');
  F.Visible := False;
  F := Result.AddField('MethodId', '#Метод', ftInteger, 'a');
  F.Visible := False;
  F := Result.AddField('StateId', '#Сост.', ftInteger, 'a');
  F.Visible := False;
  F := Result.AddField('UserIns', '#Создал', ftInteger, 'a');
  F.Visible := False;


  F := Result.AddField('AppealType', 'Тип', ftString, 'a');
  F.Size := 50;
  F.DisplayWidth := 10;
  F := Result.AddField('Content', 'Содержание', ftString, 'a');
  F.Size := 255;
  F.DisplayWidth := 30;
  F := Result.AddField('ClientName', 'Клиент', ftString, 'a');
  F.Size := 255;
  F.DisplayWidth := 15;
  F := Result.AddField('UserInsName', 'Создал', ftString, 'a');
  F.Size := 50;
  F.DisplayWidth := 10;
  F := Result.AddField('AppealMethod', 'Метод', ftString, 'a');
  F.Size := 50;
  F.DisplayWidth := 10;
  F := Result.AddField('AppealState', 'Состояние', ftString, 'a');
  F.Size := 50;
  F := Result.AddField('UserIns', '#Создал', ftInteger, 'a');
  F.Visible := False;
  F.DisplayWidth := 10;
  
  Result.DateFieldName := 'InsDate';
  Result.Order.By('InsDate');
  Result.Order.By('InsDate');
  Result.Debug := FDebug;
end;

function TdmJSO.GetAppeal(var DS: TsprQuery; Phone: String; DoSetPhone: Boolean): TsprQuery;
begin
  if not Assigned(DS) then
  begin
    DS := Self.CreateAppeal;
    DS.SQLTemplate.Text :=
       'use WorkWith_Gamma ' + clrf +
       'select a.* ' + clrf +
       '  from dbo.v_jso_Appeal a with (nolock) ' + clrf +
       '&Joins' + clrf +
       'where a.MPhone = :MPhone ' + clrf +
       '&WhereValue' + clrf +
       '&Order';
     DS.Parameters.CreateParameter('MPhone', ftString, pdInput, 10, null);
  end;
  if DoSetPhone then
  begin
    DS.Active := False;
    DS.Parameters.ParamValues['MPhone'] := Phone;
    DS.Active := True;
  end;
end;

end.
