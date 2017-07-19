unit CCJSO_MyOrder;
{
  © PgkSoft 04.09.2015
  Журнал интернет заказов
  Механизм избранных заказов
  Подчиненный раздел «Управление избранными заказами»
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ComCtrls, ExtCtrls, DB, ADODB, ActnList, Grids, DBGrids,
  StdCtrls, Menus;

type
  TRetCondMyOrder = Record
    Order : integer;
    NUser : integer;
    SUser : string;
  end;

type
  TfrmCCJSO_MyOrder = class(TForm)
    pnlCond: TPanel;
    pnlTool: TPanel;
    pnlControl: TPanel;
    pnlControl_Bar: TPanel;
    pnlControl_Status: TPanel;
    StatusBar: TStatusBar;
    pnlGrid: TPanel;
    tlbarControl: TToolBar;
    pnlTool_Show: TPanel;
    pnlTool_Bar: TPanel;
    ToolBar: TToolBar;
    MainGrid: TDBGrid;
    ActionList: TActionList;
    dsMark: TDataSource;
    qrspMark: TADOStoredProc;
    aControl_Exit: TAction;
    aControl_CondOrder: TAction;
    aControl_CondUserOrders: TAction;
    tlbtnControl_CondOrder: TToolButton;
    tlbtnControl_CondUserOrders: TToolButton;
    tlbtnControl_Exit: TToolButton;
    lblCondUser: TLabel;
    edCondUser: TEdit;
    aCodition: TAction;
    aTool_RP_MarkOrders: TAction;
    tlbtnPM_Report: TToolButton;
    pmReport: TPopupMenu;
    pmiTool_RP_MarkOrders: TMenuItem;
    qrspRPMyOrders: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aControl_ExitExecute(Sender: TObject);
    procedure aControl_CondOrderExecute(Sender: TObject);
    procedure aControl_CondUserOrdersExecute(Sender: TObject);
    procedure MainGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aCoditionExecute(Sender: TObject);
    procedure aTool_RP_MarkOrdersExecute(Sender: TObject);
    procedure dsMarkDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    ISignActive     : smallint;
    ISignReturn     : smallint;
    USER            : integer;
    RetCondMyOrder  : TRetCondMyOrder;
    procedure ShowGets;
    procedure ExecCondition;
    procedure CreateCondition;
  public
    { Public declarations }
    procedure SetUser(Parm : integer);
    function GetSignReturn : smallint;
    function GetCondMyOrder : TRetCondMyOrder;
  end;

const
  cJSOMyOrder_ReturnExit           = 0;
  cJSOMyOrder_ReturnCondOrder      = 1;
  cJSOMyOrder_ReturnCondUserOrders = 2;
var
  frmCCJSO_MyOrder: TfrmCCJSO_MyOrder;

implementation

uses
  StrUtils, Util, ComObj, Excel97, DateUtils,
  Umain, UCCenterJournalNetZkz, ExDBGRID;

{$R *.dfm}

procedure TfrmCCJSO_MyOrder.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
  ISignReturn := cJSOMyOrder_ReturnExit;
  RetCondMyOrder.Order := 0;
  RetCondMyOrder.NUser := 0;
  RetCondMyOrder.SUser := '';
end;

procedure TfrmCCJSO_MyOrder.FormActivate(Sender: TObject);
begin
  if ISignActive = 0 then begin
    { Стартовая настройка свойств }
    { Иконка формы }
    //FCCenterJournalNetZkz.imgMain.GetIcon(310,self.Icon);
    { Форма активна }
    ISignActive := 1;
    ExecCondition;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_MyOrder.ShowGets;
var
  SCaption : string;
begin
  if ISignActive = 1 then begin
    SCaption := VarToStr(qrspMark.RecordCount);
    pnlTool_Show.Caption := SCaption;  pnlTool_Show.Width := TextPixWidth(SCaption, pnlTool_Show.Font) + 20;
    if qrspMark.IsEmpty then begin
      { Пустой набор данных }
      aControl_CondOrder.Enabled := false;
      aControl_CondUserOrders.Enabled := false;
      RetCondMyOrder.Order := 0;
      RetCondMyOrder.NUser := 0;
      RetCondMyOrder.SUser := '';
    end else begin
      { НЕ пустой набор данных }
      aControl_CondOrder.Enabled := true;
      aControl_CondUserOrders.Enabled := true;
    end;
  end;
end;

procedure TfrmCCJSO_MyOrder.SetUser(Parm : integer); begin USER := Parm;  end;
function TfrmCCJSO_MyOrder.GetSignReturn : smallint; begin result := ISignReturn; end;
function TfrmCCJSO_MyOrder.GetCondMyOrder : TRetCondMyOrder; begin result := RetCondMyOrder; end;

procedure TfrmCCJSO_MyOrder.ExecCondition;
var
  RN: Integer;
begin
  if not qrspMark.IsEmpty then RN := qrspMark.FieldByName('NRN').AsInteger else RN := -1;
  if qrspMark.Active then qrspMark.Active := false;
  CreateCondition;
  qrspMark.Active := true;
  qrspMark.Locate('NRN', RN, []);
end;

procedure TfrmCCJSO_MyOrder.CreateCondition;
var
  SUser : string;
begin
  SUser := '';
  if length(trim(edCondUser.Text)) <> 0 then SUser := edCondUser.Text;
  qrspMark.Parameters.ParamValues['@User'] := SUser;
end;

procedure TfrmCCJSO_MyOrder.aControl_ExitExecute(Sender: TObject);
begin
  ISignReturn := cJSOMyOrder_ReturnExit;
  self.Close;
end;

procedure TfrmCCJSO_MyOrder.aControl_CondOrderExecute(Sender: TObject);
begin
  ISignReturn := cJSOMyOrder_ReturnCondOrder;
  self.Close;
end;

procedure TfrmCCJSO_MyOrder.aControl_CondUserOrdersExecute(Sender: TObject);
begin
  ISignReturn := cJSOMyOrder_ReturnCondUserOrders;
  self.Close;
end;

procedure TfrmCCJSO_MyOrder.MainGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TfrmCCJSO_MyOrder.aCoditionExecute(Sender: TObject);
begin
  if ISignActive = 1 then begin
   { Формируем условие отбора }
   ExecCondition;
  end;
end;

procedure TfrmCCJSO_MyOrder.aTool_RP_MarkOrdersExecute(Sender: TObject);
var
  vExcel               : OleVariant;
  vDD                  : OleVariant;
  WS                   : OleVariant;
  Cells                : OleVariant;
  I                    : integer;
  iExcelNumLineStart   : integer;
  iExcelNumLine        : integer;
  fl_cnt               : integer;
  num_cnt              : integer;
  iInteriorColor       : integer;
  iHorizontalAlignment : integer;
  RecNumb              : integer;
  RecCount             : integer;
  SFontSize            : string;
  SUser                : string;
begin
  SFontSize := '10';
  try
    StatusBar.SimpleText := 'Запуск табличного процессора...';
    vExcel := CreateOLEObject('Excel.Application');
    vDD := vExcel.Workbooks.Add;
    WS := vDD.Sheets[1];
    iExcelNumLine := 0;
    { Заголовок отчета }
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Избранные заказы';
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Дата формирования: ' + FormatDateTime('dd-mm-yyyy hh:nn:ss', Now);
    inc(iExcelNumLine);
    StatusBar.SimpleText := 'Формирование набора данных...';
    if qrspRPMyOrders.Active then qrspRPMyOrders.Active := false;
    SUser := '';
    if length(trim(edCondUser.Text)) <> 0 then SUser := edCondUser.Text;
    qrspMark.Parameters.ParamValues['@User'] := SUser;
    qrspRPMyOrders.Open;
    RecCount := qrspRPMyOrders.RecordCount;
    RecNumb := 0;
    { Заголовок таблицы }
    inc(iExcelNumLine);
    iExcelNumLineStart := iExcelNumLine;
    fl_cnt := qrspRPMyOrders.FieldCount;
    for I := 1 to fl_cnt do begin
      vExcel.ActiveCell[iExcelNumLine, I].Value := qrspRPMyOrders.Fields[I - 1].FieldName;
      SetPropExcelCell(WS, i, iExcelNumLine, 19, xlCenter);
      vExcel.Cells[iExcelNumLine, I].Font.Size := SFontSize;
    end;
    { Вывод таблицы }
    qrspRPMyOrders.First;
    while not qrspRPMyOrders.Eof do begin
      inc(RecNumb);
      StatusBar.SimpleText := 'Формирование отчета: '+VarToStr(RecNumb)+'/'+VarToStr(RecCount);
      inc(iExcelNumLine);
      for num_cnt := 1 to fl_cnt do begin
        vExcel.ActiveCell[iExcelNumLine, num_cnt].Value := qrspRPMyOrders.Fields[num_cnt - 1].AsString;
        SetPropExcelCell(WS, num_cnt, iExcelNumLine, 0, xlLeft);
        vExcel.Cells[iExcelNumLine, num_cnt].Font.Size := SFontSize;
      end;
      qrspRPMyOrders.Next;
    end;
    { Ширина колонок }
    vExcel.Columns[01].ColumnWidth := 20;  { Исполнитель }
    vExcel.Columns[02].ColumnWidth := 10;  { Закреплено }
    vExcel.Columns[03].ColumnWidth := 20;  { Направлено от }
    vExcel.Columns[04].ColumnWidth := 07;  { Заказ }
    vExcel.Columns[05].ColumnWidth := 10;  { Дата заказа }
    vExcel.Columns[06].ColumnWidth := 20;  { Клиент }
    vExcel.Columns[07].ColumnWidth := 10;  { Сумма }
    { Перенос слов }
    WS.Range[CellName(01,iExcelNumLineStart) + ':' + CellName(fl_cnt,iExcelNumLine)].WrapText:=true;
    inc(iExcelNumLine);
    { Показываем }
    vExcel.Visible := True;
  except
    on E: Exception do begin
      if vExcel = varDispatch then vExcel.Quit;
    end;
  end;
  StatusBar.SimpleText := '';
end;

procedure TfrmCCJSO_MyOrder.dsMarkDataChange(Sender: TObject; Field: TField);
begin
  if qrspMark.IsEmpty then begin
    RetCondMyOrder.Order := 0;
    RetCondMyOrder.NUser := 0;
    RetCondMyOrder.SUser := '';
  end else begin
    RetCondMyOrder.Order := MainGrid.DataSource.DataSet.FieldByName('NOrder').AsInteger;
    RetCondMyOrder.NUser := MainGrid.DataSource.DataSet.FieldByName('NUSer').AsInteger;
    RetCondMyOrder.SUser := MainGrid.DataSource.DataSet.FieldByName('SUSer').AsString;
  end;
end;

end.
