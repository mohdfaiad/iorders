unit uSprQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Grids, DBGrids, StrUtils, ImgList, uSprFilter,
  uSprJoin, Math, Buttons, uSprOrder;

type

  TsprDateFormat = (dfDate, dfMonth);
  TsprQuery = class;

  TEnabledMethod = function(DataSet: TsprQuery): Boolean of Object;
  TActionExecMethod = procedure(DataSet: TsprQuery) of Object;

  TQueryAction = class(TCollectionItem)
  private
    FEnabled: TEnabledMethod;
    FOnExecute: TActionExecMethod;
    FCaption: string;
    FName: string;
    FConfirmation: string;
  public
    property Enabled: TEnabledMethod read FEnabled write FEnabled;
    property OnExecute: TActionExecMethod read FOnExecute write FOnExecute;
    property Caption: string read FCaption write FCaption;
    property Name: string read FName write FName;
    property Confirmation: string read FConfirmation write FConfirmation;
  end;

  TQueryActions = class(TOwnedCollection)
  public
    function Find(const AName: string): TQueryAction;
    function IndexOf(const AName: string): Integer;
  end;


  TsprQuery = class(TADOQuery)
  private
    FStartDate: TDateTime;
    FEndDate: TDateTime;
    FOrder: TsprOrder;
    FFilters: TsprFilters;
    FJoins: TStringList;
    FSQLTemplate: TStrings;
    //FFieldsStr: string;
    //FJoinStr: string;
    //FOrderByStr: string;
    FAutoOpen: Boolean;
    FDebug: Boolean;
    FDateFieldName: string;
    FBaseTable: string;
    FItemDlgClassName: string;
    FDateFilterEnabled: Boolean;
    FReadOnly: Boolean;
    FActions: TQueryActions;
    function GetSQLTemplate: TStrings;
    procedure SetSQLTemplate(const Value: TStrings);
    function FindMacro(const Value: string; ASQL: TStrings): Integer;
    procedure ProcessFilters(ASQL: TStrings);
    procedure ProcessOrder(ASQL: TStrings);
    procedure ProcessJoins(ASQL: TStrings);
    procedure ProcessJoin(AJoin: TsprJoin; AAlias: string);
   // procedure SetOrderByStr(const Value: string);
  protected
    //procedure ConditionChanged(Sender: TObject);
    procedure DoBeforeOpen; override;
    procedure DoBeforeRefresh; override;
    procedure BuildSQL;
    function ParamExists(ParamName: string): Boolean;
    procedure SetStartDate(const Value: TDateTime); virtual;
    procedure SetEndDate(const Value: TDateTime); virtual;
    procedure DisableContextParam(AParamName: string);
    procedure DisableDateFilter; virtual;
    procedure SetDateFilter; virtual;
    procedure SetContextFilter(FilterName, AExpression: string);
    procedure DisableContextFilter(FilterName: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CanFilterDate: Boolean; virtual;
    procedure ReOpen;
    procedure DSOpen;
//    function GetDateFieldName: string; virtual;
    property DateFieldName: string read FDateFieldName write FDateFieldName;
    property ItemDlgClassName: string read FItemDlgClassName write FItemDlgClassName;
    function GetDateFormat: TsprDateFormat; virtual;
    function AddField(FieldName: string; DisplayLabel: string;
      FieldType: TFieldType; TableAlias: string = '';
      Visible: Boolean = True): TField;
    function AddLookupField(FieldName: string; DisplayLabel: string; FieldType: TFieldType; LookupDataSet: TDataSet;
      KeyFields: string; LookupKeyFields: string; LookupResultField: string): TField;
    function GetDescription: string;
    procedure RevertToDefault;
    procedure AddFilter(FilterName, AExpression, AGroupName: string);
    procedure DisableFilter(FilterName: string);
    function AddAction(Name: string; Caption: string; OnExecute: TActionExecMethod): TQueryAction;
    property  Actions: TQueryActions read FActions write FActions;
  published
    //property OrderBy: string read FOrderByStr write SetOrderByStr;
    property SQLTemplate: TStrings read GetSQLTemplate write SetSQLTemplate;
    property Order: TsprOrder read FOrder;
    property Debug: Boolean read FDebug write FDebug;
    property Filters: TsprFilters read FFilters;
    property StartDate: TDateTime read FStartDate write SetStartDate;
    property EndDate: TDateTime read FEndDate write SetEndDate;
    property BaseTable: string read FBaseTable write FBaseTable;
    property DateFilterEnabled: Boolean read FDateFilterEnabled write FDateFilterEnabled;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
  end;

  function SQLStartDateTimeToStr(Value: TDateTime): string;
  function SQLEndDateTimeToStr(Value: TDateTime): string;

  function CreateField(DataSet: TDataSet; FieldName: string;
     DisplayLabel: string; FieldType: TFieldType; Origin: string; AVisible: Boolean = True): TField;

  procedure SetFieldsFormat(DataSet: TDataSet);
  function AsString(DataSet: TDataSet; FieldName: string): string;
type
  TsprDSCreateMethod = function: TsprQuery of object;
  
  const
    clrf = #13#10;
    sprDateTimeFieldFormat = 'dd.mm.yyyy hh:nn:ss';
    sprDateFieldFormat = 'dd.mm.yyyy';
    sprPriceFieldFormat = '0.00';

implementation

uses DateUtils;

function SQLStartDateTimeToStr(Value: TDateTime): string;
begin
  Result := '''' + FormatDateTime('yyyy-mm-dd', Value) + ' 00:00:00''';
end;

function SQLEndDateTimeToStr(Value: TDateTime): string;
begin
  Result := '''' + FormatDateTime('yyyy-mm-dd', Value) + ' 23:59:59''';
end;

function CreateField(DataSet: TDataSet; FieldName: string;
  DisplayLabel: string; FieldType: TFieldType; Origin: string;
  AVisible: Boolean = True): TField;
begin
  Result := DataSet.FindField(FieldName);
  if nil = Result then
    case FieldType of
      ftDate:
      begin
        Result := TDateField.Create(DataSet);
      end;

      ftDateTime:
      begin
        Result := TDateTimeField.Create(DataSet);
      end;

      ftFloat:
      begin
        Result := TFloatField.Create(DataSet);
      end;

      ftString:
      begin
        Result := TStringField.Create(DataSet);
        Result.DisplayWidth := 25;
      end;

      ftWideString:
      begin
        Result := TWideStringField.Create(DataSet);
        Result.DisplayWidth := 25;
      end;

      ftInteger:
      begin
        Result := TIntegerField.Create(DataSet);
      end;

      ftSmallInt:
      begin
        Result := TSmallIntField.Create(DataSet);
      end;

      ftBCD:
      begin
        Result := TBCDField.Create(DataSet);
      end;

      else
        Result := nil;
    end;
  if nil <> Result then
  begin
    Result.FieldName := FieldName;
    Result.DisplayLabel := DisplayLabel;
    Result.DataSet := DataSet;
    Result.Origin := Origin;
    Result.Visible := AVisible;
  end;
end;

function TsprQuery.AddField(FieldName: string; DisplayLabel: string;
  FieldType: TFieldType; TableAlias: string = ''; Visible: Boolean = True): TField;
begin
  Result := CreateField(Self,
    FieldName,
    DisplayLabel,
    FieldType,
    IfThen(TableAlias = '', BaseTable, TableAlias) +
    '.' + FieldName,
    Visible);
end;

function TsprQuery.AddLookupField(FieldName: string; DisplayLabel: string; FieldType: TFieldType;
   LookupDataSet: TDataSet; KeyFields: string; LookupKeyFields: string; LookupResultField: string): TField;
begin
  Result := AddField(FieldName,
    DisplayLabel,
    FieldType);
  Result.Lookup    := true;
  Result.FieldKind := fkLookup;
  Result.KeyFields := KeyFields;
  Result.LookupDataSet := LookupDataSet;
  Result.LookupKeyFields := LookupKeyFields;
  Result.LookupResultField := LookupResultField;
    //'dbo.ava_apteks,id_gamma,names,left';
end;

function TsprQuery.GetSQLTemplate: TStrings;
begin
  Result := FSQLTemplate;
end;

procedure TsprQuery.SetSQLTemplate(const Value: TStrings);
begin
  FSQLTemplate.Assign(Value);
end;

constructor TsprQuery.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FReadOnly := True;
  CursorType := ctKeySet;
  FSQLTemplate := TStringList.Create;
  FOrder := TsprOrder.Create(Self);
  FFilters := TsprFilters.Create(Self);
  FJoins := TStringList.Create;
  FDebug := False;
  //FOrderByStr := '';
  FAutoOpen := false;
  FDateFieldName := 'ReleaseDate';
  Self.CommandTimeout := 100;
  FDateFilterEnabled := True;
  FActions := TQueryActions.Create(Self, TQueryAction);
end;

destructor TsprQuery.Destroy;
begin
  Close;
  FreeAndNil(FJoins);
  FreeAndNil(FOrder);
  FreeAndNil(FFilters);
  FreeAndNil(FSQLTemplate);
  FreeAndNil(FActions);
  inherited Destroy;
end;

{
procedure TsprQuery.SetOrderByStr(const Value: string);
begin
  if Value <> FOrderByStr then
  begin
    FOrderByStr := Value;
    BuildSQL;
    //if FAutoOpen then

  end;
end; }

procedure TsprQuery.DoBeforeOpen;
begin
  inherited;
  BuildSQL;
end;

procedure TsprQuery.DoBeforeRefresh;
begin
  inherited;
  //BuildSQL;
end;

function TsprQuery.FindMacro(const Value: string; ASQL: TStrings): Integer;
var
  I: Integer;
  S: string;
begin
  Result := -1;
  for I := 0 to ASQL.Count - 1 do
  begin
    S := ASQL[I];
    if Pos(AnsiUpperCase(Value), AnsiUpperCase(S)) > 0 then
    begin
      Result := I;
      break;
    end;
  end;
end;

procedure TsprQuery.ProcessJoin(AJoin: TsprJoin; AAlias: string);
var
  vStr: string;
begin
  vStr := Format('%s join %s %s %s on %s.%s = %s', [
    AJoin.Kind,
    AJoin.Table,
    AAlias,
    AJoin.Options,
    AAlias,
    AJoin.FieldLeft,
    AJoin.FieldRight
  ]);
  FJoins.Add(vStr);
end;

procedure TsprQuery.ProcessFilters(ASQL: TStrings);
var
  idxWhere: Integer;
  idxWhereValue: Integer;
  vFilter: TsprFilter;
  vIncludeCombineOperator: Boolean;
  I: Integer;
  S, vWhereStr: string;
begin
  vWhereStr := '';
  idxWhere := -1;
  idxWhereValue := FindMacro('&WHEREVALUE', ASQL);
  if idxWhereValue < 0 then
    idxWhere := FindMacro('&WHERE', ASQL);

  if (idxWhere >= 0) or (idxWhereValue >= 0) then
  begin
    vIncludeCombineOperator := idxWhereValue >= 0;

    for I := 0 to FFilters.Count - 1 do
    begin
      vFilter := FFilters.Items[I];
      if vFilter.Enabled then
      begin
        S := vFilter.GetAsString(vIncludeCombineOperator);
        if S <> '' then
        begin
          vWhereStr := vWhereStr + ' ' + S + clrf;
          vIncludeCombineOperator := True;
          if vFilter.Join.Table <> '' then
            ProcessJoin(vFilter.Join, vFilter.GetJoinAlias);
        end;
      end;
    end;


    if (idxWhere >= 0) then
    begin
      if vWhereStr <> '' then
        vWhereStr := 'where ' + vWhereStr;

      ASQL[idxWhere] := AnsiReplaceText(ASQL[idxWhere], '&WHERE', vWhereStr);
    end
    else
      ASQL[idxWhereValue] := AnsiReplaceText(ASQL[idxWhereValue], '&WHEREVALUE', vWhereStr);

  end;
end;

procedure TsprQuery.ProcessOrder(ASQL: TStrings);
var
  I: Integer;
  vSQL: TStringList;

  S, vOrderStr: string;
  vOrderItem: TsprOrderItem;
  idxOrder: Integer;
begin
  vOrderStr := '';
  idxOrder := FindMacro('&ORDER', ASQL);
  if idxOrder >= 0 then
  begin
    for I := 0 to FOrder.Count - 1 do
    begin
      vOrderItem := FOrder.Items[I];
      S := vOrderItem.GetAsString;
      if S <> '' then
      begin
        vOrderStr := vOrderStr + ', ' + S;
        if vOrderItem.Join.Table <> '' then
          ProcessJoin(vOrderItem.Join, vOrderItem.GetJoinAlias);
      end;
    end;

    if vOrderStr <> '' then
      vOrderStr := 'order by ' + Copy(vOrderStr, 2, Length(vOrderStr) - 1);

    ASQL[idxOrder] := AnsiReplaceText(ASQL[idxOrder], '&ORDER', vOrderStr);
  end;
end;

procedure TsprQuery.ProcessJoins(ASQL: TStrings);
var
  idxJoin: Integer;
  vJoinStr: string;
  I: Integer;
begin
  vJoinStr := '';
  idxJoin := FindMacro('&JOINS', ASQL);
  if idxJoin >= 0 then
  begin
    for I := 0 to FJoins.Count - 1 do
      vJoinStr := vJoinStr + FJoins[I] + clrf;


    ASQL[idxJoin] := AnsiReplaceText(ASQL[idxJoin], '&JOINS', vJoinStr);
  end;
end;

procedure TsprQuery.BuildSQL;
var
  I: Integer;
  vSQL: TStringList;

  vOrderStr: string;
  vJoinStr: string;
  vAlias: string;
  vOrderItem: TsprOrderItem;
  idxOrder: Integer;
  idxJoin: Integer;
begin
  FJoins.Clear;
  vSQL := TStringList.Create;
  try
    vSQL.Assign(FSQLTemplate);
    Self.ProcessFilters(vSQL);
    Self.ProcessOrder(vSQL);
    Self.ProcessJoins(vSQL);

    if FDebug then
      ShowMessage(vSQL.Text);
    SQL.Assign(vSQL);
  finally
    vSQL.Free;
  end;
end;

function TsprQuery.ParamExists(ParamName: string): Boolean;
begin
  Result := Self.Parameters.FindParam(ParamName) <> nil;
end;

function TsprQuery.CanFilterDate: Boolean;
begin
  Result :=
    FDateFilterEnabled and (
    (ParamExists('StartDate') and ParamExists('EndDate'))
    or (
     Assigned(Self.FindField(FDateFieldName))
    //(not isDetail) and (PropertyExists(GetDatePropertyName))
    ));
end;

{
function TsprQuery.GetDateFieldName: string;
begin
  Result := 'ReleaseDate';
end;}

function TsprQuery.GetDateFormat: TsprDateFormat;
begin
  Result := dfDate;
end;

procedure TsprQuery.DisableContextParam(AParamName: string);
var
  Param: TParameter;
  Filter: TsprFilter;
begin
  Param := Parameters.FindParam(AParamName);
  if Assigned(Param) then
    Param.Value := Unassigned
  else
  begin
    Filter := Filters.FindByName(AParamName);
    if Assigned(Filter) then
      Filter.Enabled := False;
  end;
end;

procedure TsprQuery.SetStartDate(const Value: TDateTime);
begin
  if GetDateFormat = dfMonth then
    FStartDate := StartOfTheMonth(Value)
  else
    FStartDate := Value;

  if CanFilterDate then
    SetDateFilter
  else
    DisableDateFilter;
  //ContextChanged;
end;

procedure TsprQuery.SetEndDate(const Value: TDateTime);
begin
  if GetDateFormat = dfMonth then
    FEndDate := EndOfTheMonth(Value)
  else
    FEndDate := Value;

  if CanFilterDate then
    SetDateFilter
  else
    DisableDateFilter;
  //ContextChanged;
end;

procedure TsprQuery.SetContextFilter(FilterName, AExpression: string);
var
  f: TsprFilter;
begin
  f := Filters.GetFilterByName(FilterName);
  f.GroupName := 'ContextFilters';
  f.Expression := AExpression;
  f.Enabled := AExpression <> sprNoFilter;
end;

procedure TsprQuery.AddFilter(FilterName, AExpression, AGroupName: string);
var
  f: TsprFilter;
begin
  f := Filters.GetFilterByName(FilterName);
  f.GroupName := AGroupName;
  f.Expression := AExpression;
  f.Enabled := AExpression <> sprNoFilter;
end;

procedure TsprQuery.DisableFilter(FilterName: string);
var
  Filter: TsprFilter;
begin
  Filter := Filters.FindByName(FilterName);
  if Assigned(Filter) then
    Filter.Enabled := False;
end;

procedure TsprQuery.DisableContextFilter(FilterName: string);
var
  Filter: TsprFilter;
begin
  Filter := Filters.FindByName(FilterName);
  if Assigned(Filter) then
    Filter.Enabled := False;
end;

procedure TsprQuery.SetDateFilter;
var
  StartParam, EndParam: TParameter;
  vField: TField;
  vFilterFieldName: string;
begin
  StartParam := Parameters.FindParam('StartDate');
  EndParam := Parameters.FindParam('EndDate');
  if Assigned(StartParam) and Assigned(EndParam) then
  begin
    StartParam.Value := FStartDate;
    EndParam.Value := FEndDate;
  end else
    if Assigned(StartParam) or Assigned(EndParam) then
      raise Exception.Create(
        'Вы должны определить StartDate и EndDate параметры')
    else
    begin
      if CanFilterDate then
      begin
        vField := Self.FindField(FDateFieldName);
        if Assigned(vField) then
        begin
          if vField.Origin <> '' then
            vFilterFieldName := vField.Origin
          else
            vFilterFieldName := FDateFieldName;

          SetContextFilter('ReleaseDate',
            Format('(%s BETWEEN %s AND %s)', [
              vFilterFieldName,
              SQLStartDateTimeToStr(FStartDate),
              SQLEndDateTimeToStr(FEndDate)]));
        end
      end
      else
        DisableDateFilter;
   end;
end;

procedure TsprQuery.DisableDateFilter;
begin
  DisableContextParam('StartDate');
  DisableContextParam('EndDate');
  DisableContextFilter('ReleaseDate');
end;

procedure TsprQuery.ReOpen;
begin
  Screen.Cursor := crHourGlass;
  try
    Active := False;
    Active := True;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TsprQuery.DSOpen;
begin
  Screen.Cursor := crHourGlass;
  try

    Active := True;
  finally
    Screen.Cursor := crDefault;
  end;

end;

function TsprQuery.GetDescription: string;
var
  I: Integer;
  S, vDirection: string;
begin
  Result := Self.SQL.Text;
  if Self.Parameters.Count > 0 then
  begin
    Result := Result + clrf + '------------------------' + clrf;
    for I := 0 to Parameters.Count - 1 do
    begin
      case Parameters[I].Direction of
        pdUnknown: vDirection := 'pdUnknown';
        pdInput: vDirection := 'pdInput';
        pdOutput: vDirection := 'pdOutput';
        pdInputOutput: vDirection := 'pdInputOutput';
        pdReturnValue: vDirection := 'pdReturnValue';
      end;

      S := Format('%s %s = %s', [vDirection, Parameters[I].Name, VarToStr(Parameters[I].Value)]);
      Result := Result + clrf + S;
    end;
  end;
end;

procedure TsprQuery.RevertToDefault;
begin
  Active := False;
  Self.Order.Clear;
  Self.Filters.Clear;
end;

procedure SetFieldsFormat(DataSet: TDataSet);
var
  I: Integer;
begin
  for I := 0 to DataSet.Fields.Count - 1 do
    if DataSet.Fields[I] is TDateTimeField then
      TDateTimeField(DataSet.Fields[I]).DisplayFormat := sprDateTimeFieldFormat
    else
    if DataSet.Fields[I] is TDateField then
      TDateField(DataSet.Fields[I]).DisplayFormat := sprDateFieldFormat;
end;

function AsString(DataSet: TDataSet; FieldName: string): string;
begin
  Result := DataSet.FieldByName(FieldName).DisplayText;
end;

function TQueryActions.IndexOf(const AName: string): Integer;
begin
  for Result := 0 to Count - 1 do
    if AnsiCompareText(TQueryAction(Items[Result]).Name, AName) = 0 then Exit;
  Result := -1;
end;

function TQueryActions.Find(const AName: string): TQueryAction;
var
  I: Integer;
begin
  I := IndexOf(AName);
  if I < 0 then Result := nil else Result := TQueryAction(Items[I]);
end;

function TsprQuery.AddAction(Name: string; Caption: string; OnExecute: TActionExecMethod): TQueryAction;
begin
  Result := TQueryAction(FActions.Add);
  Result.Name := Name;
  Result.Caption := Caption;
  Result.OnExecute := OnExecute;
end;

end.
