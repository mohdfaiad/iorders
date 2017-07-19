unit uSprOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Grids, DBGrids, StrUtils, ImgList,
  uSprJoin, Math, Buttons;

type

  TsprOrderItem = class(TCollectionItem)
  private
    FDesc: Boolean;
    FFieldName: string;
    FCaption: string;
    FOrder: string;
    FJoin: TsprJoin;
    procedure SetFieldName(const Value: string);
    procedure Clear;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    function GetAsString: string;
    function GetJoinAlias: string;
    property Join: TsprJoin read FJoin;
    property Order: string read FOrder;
  published
    property FieldName: string read FFieldName write
      SetFieldName;
    property Desc: Boolean read FDesc write FDesc;
    property Caption: string read FCaption;
  end;

  TsprOrder = class(TOwnedCollection)
  protected
    function GetItem(Index: Integer): TsprOrderItem;
    //procedure SetItem(Index: Integer; AObject: TsprOrderItem);
    procedure SetAsString(const Value: string);
  public
    constructor Create(Owner: TPersistent);
    destructor Destroy; override;

    property Items[Index: Integer]: TsprOrderItem read GetItem;// write SetItem; default;
    //Find existing item by PropertyName
    function Find(FieldName: string): TsprOrderItem;
    //Find or Create filter by Property Name
    function Add(FieldName: string; Desc: Boolean = False): TsprOrderItem;
    function Remove(FieldName: string): Integer;
    //procedure Clear; reintroduce;
    procedure By(FieldNames: string; InvertExistingOrder: Boolean = True);
  end;


implementation

constructor TsprOrderItem.Create(Collection: TCollection);
begin
  inherited;
  FJoin := TsprJoin.Create;
  FDesc := False;
end;

destructor TsprOrderItem.Destroy;
begin
  FJoin.Free;
  inherited;
end;

procedure TsprOrderItem.Clear;
begin
  FJoin.Clear;
  FFieldName := '';
  FOrder := '';
  FCaption := '';
end;

procedure TsprOrderItem.SetFieldName(const Value: string);
var
  vDS: TDataSet;
  vField: TField;
  vStr: string;
  L: TStringList;
begin
  if FFieldName = Value then
    Exit;

  vDS := TDataSet(Collection.Owner);
  vField := vDS.FindField(Value);
  Clear;

  if Assigned(vField) then
  begin
    if vField.FieldKind in [fkCalculated] then
      Exit;

    FFieldName := Value;
    FCaption := vField.DisplayLabel;
    if vField.Origin <> '' then
      vStr := vField.Origin
    else
      vStr := vField.FieldName;

    FJoin.ProcessField(vField, vStr, GetJoinAlias, FOrder);
  end;
end;

function TsprOrderItem.GetJoinAlias: string;
begin
  Result := 'spr_order' + IntToStr(Self.ID);
end;

function TsprOrderItem.GetAsString: string;
begin
  Result := '';
  if FieldName <> '' then
  begin
    if Desc then
      Result := Order + ' desc'
    else
      Result := Order;
  end;
end;
//********************************

constructor TsprOrder.Create(Owner: TPersistent);
begin
  inherited Create(Owner, TsprOrderItem);
end;

destructor TsprOrder.Destroy;
begin
  inherited;
end;


function TsprOrder.Find(FieldName: string): TsprOrderItem;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    Result := Items[i];
    if SameText(Result.FieldName, FieldName) then
      Exit;
  end;
  Result := nil;
end;

function TsprOrder.GetItem(Index: Integer): TsprOrderItem;
begin
  Result := TsprOrderItem(inherited GetItem(Index));
end;

function TsprOrder.Remove(FieldName: string): Integer;
var
  Item: TsprOrderItem;
begin
  Item := Find(FieldName);
  if Item = nil then
    Result := -1
  else
  begin
    Result := Item.Index;
    Item.Free;
  end;
end;

function TsprOrder.Add(FieldName: string; Desc: Boolean = False): TsprOrderItem;
begin
  Result := (inherited Add as TsprOrderItem);
  Result.FieldName := FieldName;
  Result.Desc := Desc;
end;

procedure TsprOrder.SetAsString(const Value: string);
var
  i: Integer;
  s: string;
begin
  Clear;
  try
    s := '';
    for i := 1 to Length(Value) do
      if Value[i] in [',', ';'] then
      begin
        Add(s);
        s := '';
      end
      else
        s := s + Value[i];
    if s <> '' then
      Add(s);
  except
    Clear;
    raise;
  end
end;

procedure TsprOrder.By(FieldNames: string; InvertExistingOrder: Boolean = True);

  procedure SetupOrder(FieldName: string);
  var
    OrderItem: TsprOrderItem;
  begin
    OrderItem := Find(FieldName);
    if OrderItem <> nil then
    begin
      if InvertExistingOrder then
        OrderItem.Desc := not OrderItem.Desc;
    end
    else
      SetAsString(FieldName);
  end;

begin
  SetupOrder(FieldNames);
end;


end.
 