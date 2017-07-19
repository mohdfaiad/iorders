unit uSprFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Grids, DBGrids, StrUtils, ImgList, uSprJoin;

type
  TsprFilterComparisonOperator = type string;

  TsprFilter = class(TCollectionItem)
  private
    FName: string;
    FGroupName: string;
    FFieldName: string;
    FFilterFieldName: string;
    FExpression: string;
    FCombineOperator: string;
    FComparisionOperator: TsprFilterComparisonOperator;
    FValue: Variant;
    FEnabled: Boolean;
    //FDesc: Boolean;
    //FOrder: string;
    FJoin: TsprJoin;
    //procedure SetFieldName(const Value: string);
    procedure Clear;
    function CheckRename(const NewName: string): Boolean;
    procedure SetName(const Value: string);
    procedure SetExpression(const Value: string);
  public
    procedure Init(AFieldName: string; AFilterValue: Variant;
      AFilterComparisionOperator: TsprFilterComparisonOperator; AFilterGroup: string);
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    function GetAsString(IncludeCombineOperator: Boolean = True): string;
    function GetJoinAlias: string;
    property Join: TsprJoin read FJoin;
    property GroupName: string read FGroupName write FGroupName;
    property Enabled: Boolean read FEnabled write FEnabled;
    property Name: string read FName write SetName;
    property Expression: string read FExpression write SetExpression;
    //property FieldName: string read FFieldName write
    //  SetFieldName;
    //property Desc: Boolean read FDesc write FDesc;
  end;

  TsprFilters = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TsprFilter;
  public
    constructor Create(Owner: TPersistent);
    destructor Destroy; override;
    function Add: TsprFilter;
    procedure Clear(AFilterGroup: string = '');
    procedure AddCaptionFilter(FieldName: string; FilterValue: Variant;
      FilterComparisionOperator: TsprFilterComparisonOperator; FilterGroup: string);
    function FindByName(FilterName: string): TsprFilter;
    function GetFilterByName(FilterName: string): TsprFilter;
    property Items[Index: Integer]: TsprFilter read GetItem; default;
  end;

  const
    sprNoFilter = '1 = 0';

implementation

constructor TsprFilter.Create(Collection: TCollection);
begin
  inherited;
  FJoin := TsprJoin.Create;
  FEnabled := False;
  Clear;
end;

destructor TsprFilter.Destroy;
begin
  FJoin.Free;
  inherited;
end;

procedure TsprFilter.Clear;
begin
  FJoin.Clear;
  FEnabled := False;
  FFieldName := '';
  FFilterFieldName := '';
  FValue := Null;
  FExpression := '';
  FCombineOperator := 'and';
end;

function TsprFilter.CheckRename(const NewName: string): Boolean;
var
  f: TsprFilter;
begin
  f := TsprFilters(Collection).FindByName(NewName);
  Result := (f = nil) or (f = Self);
end;

procedure TsprFilter.SetName(const Value: string);
begin
  if not CheckRename(Value) then
    raise Exception.Create(Format('Фильтр с именем ''%s'' уже существует!',
      [Value]));
  FName := Value;
end;

procedure TsprFilter.SetExpression(const Value: string);
begin
  FExpression := Value;
end;

function TsprFilter.GetJoinAlias: string;
begin
  Result := 'spr_f' + IntToStr(Self.ID);
end;

procedure TsprFilter.Init(AFieldName: string; AFilterValue: Variant;
  AFilterComparisionOperator: TsprFilterComparisonOperator; AFilterGroup: string);
var
  vDS: TDataSet;
  vField: TField;
  vStr: string;
  L: TStringList;
  vFieldValueStr: string;
  vLength: Integer;
  I: Integer;
const
  Asterisks = ['*', '%'];
begin
  Clear;

  vDS := TDataSet(Collection.Owner);
  vField := vDS.FindField(AFieldName);
  if Assigned(vField) then
  begin
    if vField.FieldKind in [fkCalculated] then
      Exit;

    FFieldName := vField.FieldName;
    FGroupName := AFilterGroup;
    FComparisionOperator := AFilterComparisionOperator;
    FEnabled := True;

    if vField.Origin <> '' then
      vStr := vField.Origin
    else
      vStr := vField.FieldName;

    if vField.DataType in [ftDateTime] then
      vStr := Format('format(%s, ''dd.MM.yyyy HH:mm:ss'')', [vStr])
    else
      if vField.DataType in [ftDate] then
        vStr := Format('format(%s, ''dd.MM.yyyy'')', [vStr]);

    FJoin.ProcessField(vField, vStr, GetJoinAlias, FFilterFieldName);

    if Pos(FComparisionOperator, 'LIKE') > 0  then
    begin
      vFieldValueStr := VarToStr(AFilterValue);
      vLength := Length(vFieldValueStr);
      FEnabled := vLength > 0;

      if FEnabled and
         (((vFieldValueStr[1] in Asterisks) and (vFieldValueStr[vLength] in Asterisks)) or
         ((vFieldValueStr[1] in Asterisks) and not (vFieldValueStr[vLength] in Asterisks)) or
         (not (vFieldValueStr[1] in Asterisks) and (vFieldValueStr[vLength] in Asterisks))) then
        FValue := '''' + StringReplace(VarToStr(AFilterValue), '*', '%', [rfReplaceAll, rfIgnoreCase]) + ''''
      else
      begin
        FValue := StringReplace(VarToStr(AFilterValue), '*', '%', [rfReplaceAll, rfIgnoreCase]);
        FValue := '''%' + FValue + '%''';
      end;
    end
    else
    begin
      FValue := AFilterValue;
      if VarIsNull(FValue) or VarIsEmpty(FValue) or (AnsiUpperCase(FValue) = 'NULL') or (VarToStr(FValue) = '') then
      begin
        FValue := 'NULL';
        if FComparisionOperator = '=' then
          FComparisionOperator := 'is'
        else
        begin
          if FComparisionOperator = '!=' then
            FComparisionOperator := 'is not'
          else
            FEnabled := False;
        end;
      end
      else
      if vField.DataType in [ftDate, ftTime, ftDateTime, ftString, ftWideString] then
        FValue := '''' + VarToStr(AFilterValue) + ''''
      else
        FValue := AFilterValue;
    end;

  end;
end;

function TsprFilter.GetAsString(IncludeCombineOperator: Boolean = True): string;
begin
  Result := '';
  if FExpression <> '' then
    Result := FExpression
  else
    if FFilterFieldName <> '' then
    begin
      Result := Format('(%s %s %s)', [
        FFilterFieldName,
        FComparisionOperator,
        FValue
      ]);
    end;

  if IncludeCombineOperator and (Result <> '') then
    Result := FCombineOperator + ' ' + Result;
end;

//*********************************************************
constructor TsprFilters.Create(Owner: TPersistent);
begin
  inherited Create(Owner, TsprFilter);
end;

destructor TsprFilters.Destroy;
begin
  inherited;
end;

function TsprFilters.Add: TsprFilter;
begin
  Result := TsprFilter(inherited Add);
end;

procedure TsprFilters.AddCaptionFilter(FieldName: string; FilterValue: Variant;
  FilterComparisionOperator: TsprFilterComparisonOperator; FilterGroup: string);
var
  vFilter: TsprFilter;
begin
  vFilter := Add;
  vFilter.Init(FieldName, FilterValue,
    FilterComparisionOperator, FilterGroup);
end;

function TsprFilters.GetItem(Index: Integer): TsprFilter;
begin
  Result := TsprFilter(inherited GetItem(Index));
end;

procedure TsprFilters.Clear(AFilterGroup: string = '');
var
  I: Integer;
begin
  I := 0;
  while I < Count do
  begin
    if (AFilterGroup = '') or SameText(Self.Items[I].GroupName, AFilterGroup) then
      Items[I].Free
    else
      Inc(I);
  end;
end;

function TsprFilters.FindByName(FilterName: string): TsprFilter;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if SameText(Items[i].Name, FilterName) then
    begin
      Result := Items[i];
      Exit;
    end;
  Result := nil;
end;

function TsprFilters.GetFilterByName(FilterName: string): TsprFilter;
begin
  Result := FindByName(FilterName);
  if Result = nil then
  begin
    Result := Add as TsprFilter;
    Result.Name := FilterName;
  end;
end;

end.
