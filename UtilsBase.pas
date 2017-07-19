unit UtilsBase;

interface

uses
  Sysutils, Classes, Controls, Contnrs, Graphics, Windows, Messages,
  DateUtils, StrUtils, RTLConsts, Math, db, Variants, Dialogs;

//compare simple and array variants
function VarEqual(v1, v2: Variant): Boolean;

//can check vararray (1 dim only)
//Return True, if all variants in array = Null
function VarIsNullEx(v: Variant): Boolean;

function VarIsAssigned(Value: Variant): Boolean;
function VarToInt(AVariant: variant; DefaultValue: Integer = 0): Integer;
function VarToFloat(AVariant: Variant; DefaultValue: Double = 0): Double;
function VarToStrExt(AVariant: Variant; DefaultValue: string = 'Null'): string;
function IsValidFloat(Value: string): Boolean;
function IsMaxDouble(Value: Double): Boolean;

function VarDateTimeToStr(Value: Variant): string;

procedure DoError(AMessage: string);
procedure ShowError(AMessage: string);

implementation

function VarEqual(v1, v2: Variant): Boolean;
var
  l, h, i: Integer;
begin
  Result := False;
  if VarIsEmpty(v1) or VarIsEmpty(v2) then
    Exit;
  if VarIsArray(v1) then
  begin
    //comparing VarArray with Variant -> False
    if not VarIsArray(v2) then
      Exit;
    l := VarArrayLowBound(v1, 1);
    h := VarArrayHighBound(v1, 1);
    Assert((l = VarArrayLowBound(v2, 1)) and (h = VarArrayHighBound(v2, 1)),
      'VarEqual: Unequal variant''s bounds');
    for i := l to h do
    begin
      Result := VarEqual(v1[i], v2[i]);
      if not Result then
        Exit;
    end;
  end
  else
  begin
    Assert(not VarIsArray(v2), 'VarEqual: comparing Variant with VarArray');
    Result := (v1 = v2) and (not (VarIsNull(v1) or VarIsNull(v2)));
  end;
end;

function VarIsNullEx(v: Variant): Boolean;
var
  i: Integer;
begin
  if VarIsArray(v) then
  begin
    Result := False;
    for i := VarArrayLowBound(v, 1) to VarArrayHighBound(v, 1) do
      if not VarIsNull(v[i]) then
        Exit;
    Result := True;
  end
  else
    Result := VarIsNull(v);
end;

function VarIsAssigned(Value: Variant): Boolean;
begin
  Result := not(VarIsNull(Value) or VarIsEmpty(Value));
end;

function VarToInt(AVariant: Variant; DefaultValue: Integer = 0): Integer;
begin
  If VarIsAssigned(AVariant) then
    Result := AVariant
  else
    Result := DefaultValue;
end;

function VarToFloat(AVariant: Variant; DefaultValue: Double = 0): Double;
begin
  if VarToStr(AVariant) = '' then
    Result := DefaultValue
  else
    Result := AVariant;
end;

function VarToStrExt(AVariant: Variant; DefaultValue: string = 'Null'): string;
begin
  If VarIsAssigned(AVariant) then
    Result := AVariant
  else
    Result := DefaultValue;
end;

function IsValidFloat(Value: string): Boolean;
var
  Dummy: Double;
begin
  Result := TryStrToFloat(Value, Dummy);
end;

function IsMaxDouble(Value: Double): Boolean;
begin
  Result := Value > (MaxDouble / 1.00000001); // 'cause MaxDouble <> MaxDouble
end;

procedure DoError(AMessage: string);
begin
  raise Exception.Create(AMessage);
end;

procedure ShowError(AMessage: string);
begin
  MessageDlg(AMessage, mtError, [mbOk], 0);
end;

function VarDateTimeToStr(Value: Variant): string;
begin
  if VarIsAssigned(Value) then
    Result := FormatDateTime('dd.mm.yyyy hh:nn:ss', Value)
  else
    Result := '';
end;

end.
