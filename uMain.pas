unit uMain;

interface

uses
  SysUtils, Classes, DB, ADODB, Windows, MEssages, Dialogs, Util, Excel97,
  Grids, DBGrids, ComCtrls, ComObj;

type
  TForm1 = class(TDataModule)
    ADOC_STAT: TADOConnection;
    spY_GetServerDate: TADOStoredProc;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function GetServerDate: TDateTime;
  public
    { Public declarations }
    user_name: string;
    id_user  : Integer;
    id_role  : Integer;
    flag_kol : Integer;

    procedure DBGridToExcel(db: TDBGrid; Caption: String = ''; IsBorder: Byte = 0);
  end;

  function CellName(a : Integer ; b: Integer): string;
  procedure MyBorder(var MyWs: OleVariant; x: Integer; y: Integer);


var
  Form1: TForm1;

implementation

uses UEnterPassw;

{$R *.dfm}

procedure TForm1.DataModuleCreate(Sender: TObject);
begin
  DecimalSeparator := '.';
  user_name := FEnterpassw.user_name;
  id_user   := FEnterpassw.id_user;
  id_role   := FEnterpassw.id_role;
  flag_kol  := FEnterpassw.flag_kol;

  try
    ADOC_STAT.Connected := true;
   //ADOCO_EKKA_NET.Connected:=False;
    //ADOCO_EKKA_NET.Connected:=True;
  except
    ShowMessage('Нет соединения ADO WorkWith_Gamma');
  end;
  Util.SetTime(GetServerDate);
end;

function TForm1.GetServerDate:TDateTime;
begin
  try
    spY_GetServerDate.Active := False;
    spY_GetServerDate.Open;
    Result := spY_GetServerDate.FieldByName('DT').AsDateTime;
  except
    Result := Now;
  end;
end;

function CellName(a, b: Integer): string;
begin
  if a <= 26 then Result := chr(a + $40) else
    Result := chr((a - 27) div 26 + $41) + chr((a - 1) mod 26 + $41);
  Result := Result + IntToStr(b);
end;

procedure MyBorder(var MyWs: OleVariant; x : Integer ; y: Integer);
var
  a: string;
  cell: OleVariant;
  ls: integer;
begin
  ls := xlContinuous; // переменная для  Borders
  a := CellName(x,y) + ':' + CellName(x,y);
  cell := MyWS.Range[a];
  Cell.Borders[xlEdgeTop].LineStyle := ls;
  Cell.Borders[xlEdgeBottom].LineStyle := LS;
  Cell.Borders[xlEdgeLeft].LineStyle := LS;
  Cell.Borders[xlEdgeRight].LineStyle := LS;
end;

function GetColByNum(N: Integer): string;
begin
  Result := Chr(N + 64);
end;

procedure TForm1.DBGridToExcel(db: TDBGrid; Caption: String = ''; IsBorder: Byte = 0);
var
  Exl: Variant;
  ds: TDataSet;
  rs,i,j :Integer;
begin
  if db = nil then
    Exit;
  ds := db.DataSource.DataSet;
  if ds = nil then
    Exit;
  Exl := CreateOleObject('Excel.Application');
  try
   Exl.Visible := True;
   Exl.DisplayAlerts := False;
   Exl.Workbooks.Add;
   Exl.WorkBooks[1].Sheets[1].Activate;
   rs := ds.RecordCount;
   for i := 0 to db.Columns.Count-1 do
   begin
     Exl.WorkBooks[1].Sheets[1].Cells[3, i + 1] := db.Columns[i].Title.Caption;
     Exl.WorkBooks[1].Sheets[1].Cells[3, i + 1].Font.Bold := True;
     for j := 1 to rs do
     begin
       if j = 1 then ds.First else ds.Next;
       Exl.WorkBooks[1].Sheets[1].Cells[3 + j, i + 1] := ds.FieldByName(db.Columns[i].FieldName).AsString;
     end;
   end;

   Exl.WorkBooks[1].Sheets[1].Range['A3:'+GetColByNum(db.Columns.Count) + IntToStr(rs + 3)].Borders.LineStyle := 1;
   Exl.WorkBooks[1].Sheets[1].Range['A3:'+GetColByNum(db.Columns.Count) + IntToStr(rs + 3)].Borders.Weight := 2;
   Exl.WorkBooks[1].Sheets[1].Range['A3:'+GetColByNum(db.Columns.Count) + IntToStr(rs + 3)].Borders.ColorIndex := 1;

   Exl.WorkBooks[1].Sheets[1].Columns['A:IV'].EntireColumn.AutoFit;

   Exl.WorkBooks[1].Sheets[1].Cells[1, 1] := Caption;
   Exl.WorkBooks[1].Sheets[1].Cells[1, 1].Font.Bold := True;
  except
   Exl.WorkBooks.Close;
  end;
end;




end.
