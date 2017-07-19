unit ExDBGRID;

interface

uses DBGrids, CheckLst, SysUtils, Windows;

function get_column_by_fieldname(tmp:string; grid:TDBGrid) : tColumn;
function GetCountCheckListBox(ListBox : TCheckListBox): integer;

procedure SetPropExcelCell(var MyWs : OleVariant; x : Integer ; y: Integer; iInteriorColor: integer; iHorizontalAlignment: integer);
procedure SetPropExcelFontSize(var MyWs: OleVariant; x1: Integer ; y1: Integer; x2: integer; y2: integer; SFontSize: string);
procedure MergeExcelCells(var MyWs : OleVariant; x1,y1,x2,y2 : integer);
procedure upoTryStrToCurr(var S: string);
function CellName(a, b: Integer): string;
function ufoTryStrToInt(const S: string): Boolean;
function ufoTryStrToCurr(const S: string): Boolean;
function GetComputerNetName: string;
function GetUserFromWindows: string;

implementation

uses Excel97;

function get_column_by_fieldname(tmp:string; grid:TDBGrid) : tColumn;
var
  i:integer;
begin
  for i:=0 to grid.Columns.count-1 do begin
    if tmp = grid.Columns[i].FieldName then begin
      result := grid.Columns[i];
      break;
    end;
  end;
end;

function GetCountCheckListBox(ListBox : TCheckListBox): integer;
var
  i            : integer;
  iCount_Check : integer;
begin
  iCount_Check := 0;
  for i := 0 to ListBox.Count-1 do if ListBox.Checked[i] then inc(iCount_Check);
  result := iCount_Check;
end;

function CellName(a, b: Integer): string;
begin
  if a <= 26 then Result := chr(a + $40)
             else Result := chr((a - 27) div 26 + $41) + chr((a - 1) mod 26 + $41);
  Result := Result + IntToStr(b);
end;

function ufoTryStrToInt(const S: string): Boolean;
var
  ISignType : integer;
  bVal      : boolean;
begin
  if length(trim(S)) <> 0 then bVal := TryStrToInt(S,ISignType) else bVal := true;
  Result := bVal;
end;

function ufoTryStrToCurr(const S: string): Boolean;
var
  NSignCurr : Currency;
  bVal      : boolean;
begin
  if length(trim(S)) <> 0 then bVal := TryStrToCurr(S,NSignCurr) else bVal := true;
  Result := bVal;
end;

{
  ƒетальный анализ символьного выражени€ типа Currency
  ќбычно вызываетс€ после ufoTryStrToCurr
}
procedure upoTryStrToCurr(var S: string);
var
  CountNotDigit : integer;
  iCkl          : integer;
  Coma          : char;
begin
  CountNotDigit := 0;
  for iCkl := 1 to length(S) do begin
    if not (S[iCkl] in ['0'..'9']) then begin
      inc(CountNotDigit);
      Coma := S[iCkl];
    end;
  end;
  if (CountNotDigit = 1) and (Coma in [',','.']) then begin
    if Coma  = ',' then S := StringReplace(S,',','.',[])
    else if Coma  = '.' then S := StringReplace(S,'.',',',[])
  end;
end;

{ ‘орматирование €чейки }
procedure SetPropExcelCell(var MyWs: OleVariant; x : Integer ; y: Integer; iInteriorColor: integer; iHorizontalAlignment: integer);
var
  cell : OleVariant;
begin
  cell := MyWS.Range[CellName(x,y) + ':' + CellName(x,y)];
  cell.Borders.LineStyle   := xlContinuous;
  cell.HorizontalAlignment := iHorizontalAlignment;
  cell.VerticalAlignment   := xlTop;
  cell.Interior.ColorIndex := iInteriorColor;
  //cell.WrapText := true;
end;

procedure SetPropExcelFontSize(var MyWs: OleVariant; x1: Integer ; y1: Integer; x2: integer; y2: integer; SFontSize: string);
var
  cells : OleVariant;
begin
  cells := MyWS.Range[CellName(x1,y1) + ':' + CellName(x2,y2)];
  cells.Select;
  cells.Font.Size := SFontSize;
  cells.Select;
end;

{ ќбъединений €чеек }
procedure MergeExcelCells(var MyWs : OleVariant; x1,y1,x2,y2 : integer);
var
  Cells : OleVariant;
begin
  Cells := MyWS.Range[CellName(x1,y1) + ':' + CellName(x2,y2)];
  Cells.Select;
  Cells.Merge;
end;

function GetComputerNetName: string;
var
  buffer: array[0..255] of char;
  size: dword;
begin
  size := 256;
  if GetComputerName(buffer, size)
    then Result := buffer
    else Result := ''
end;

function GetUserFromWindows: string;
var
  UserName : string;
  UserNameLen : Dword;
begin
  UserNameLen := 255;
  SetLength(userName, UserNameLen);
  if GetUserName(PChar(UserName), UserNameLen)
    then Result := Copy(UserName,1,UserNameLen - 1)
    else Result := 'Unknown';
end;

end.
