unit CCJS_RP_Pay;

{***********************************************************
 * © PgkSoft 05.06.2015
 * Журнал интернет заказов.
 * Отчет <Платежи>
 ***********************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ComCtrls, StdCtrls, ExtCtrls, ToolWin, DB, ADODB;

type
  TfrmCCJS_RP_Pay = class(TForm)
    pnlPage: TPanel;
    pageControl: TPageControl;
    tabParm: TTabSheet;
    grpbxPeriod: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    dtBegin: TDateTimePicker;
    dtEnd: TDateTimePicker;
    actionList: TActionList;
    aExcel: TAction;
    aClose: TAction;
    pnlControl: TPanel;
    pnlControl_Tool: TPanel;
    tollBar: TToolBar;
    tlbtnExcel: TToolButton;
    tlbtnClose: TToolButton;
    pnlControl_Show: TPanel;
    qrspPay: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aCloseExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActive    : integer;
    procedure ShowGets;
  public
    { Public declarations }
  end;

var
  frmCCJS_RP_Pay: TfrmCCJS_RP_Pay;

implementation

uses
  Util, ComObj, Excel97,
  UMain, UCCenterJournalNetZkz, ExDBGRID, DateUtils;

{$R *.dfm}

procedure TfrmCCJS_RP_Pay.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive  := 0;
  dtBegin.Date := Date;
  dtEnd.Date   := Date;
end;

procedure TfrmCCJS_RP_Pay.FormActivate(Sender: TObject);
begin
  if ISignActive = 0 then begin
    { Иконка окна }
    FCCenterJournalNetZkz.imgMain.GetIcon(270,self.Icon);
    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJS_RP_Pay.ShowGets;
begin
  if ISignActive = 1 then begin
  end;
end;

procedure TfrmCCJS_RP_Pay.aExcelExecute(Sender: TObject);
var
  vExcel               : OleVariant;
  vDD                  : OleVariant;
  WS                   : OleVariant;
  Cells                : OleVariant;
  I                    : integer;
  iExcelNumLine        : integer;
  fl_cnt               : integer;
  num_cnt              : integer;
  iInteriorColor       : integer;
  iHorizontalAlignment : integer;
  RecNumb              : integer;
  RecCount             : integer;
  SFontSize            : string;
begin
  SFontSize := '10';
  try
    pnlControl_Show.Caption := 'Запуск табличного процессора...';
    vExcel := CreateOLEObject('Excel.Application');
    vDD := vExcel.Workbooks.Add;
    WS := vDD.Sheets[1];
    pnlControl_Show.Caption := 'Формирование набора данных...';
    if qrspPay.Active then qrspPay.Active := false;
    qrspPay.Parameters.ParamValues['@SBegin'] := FormatDateTime('yyyy-mm-dd', dtBegin.Date);
    qrspPay.Parameters.ParamValues['@SEnd']   := FormatDateTime('yyyy-mm-dd', IncDay(dtEnd.Date,1));
    qrspPay.Open;
    RecCount := qrspPay.RecordCount;
    iExcelNumLine := 0;
    RecNumb := 0;
    { Заголовок отчета }
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Платежи по интернет-заказам';
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Дата формирования: ' + FormatDateTime('dd-mm-yyyy hh:nn:ss', Now);
    inc(iExcelNumLine);
    { Заголовок таблицы }
    inc(iExcelNumLine);
    fl_cnt := qrspPay.FieldCount;
    for I := 1 to fl_cnt do begin
      vExcel.ActiveCell[iExcelNumLine, I].Value := qrspPay.Fields[I - 1].FieldName;
      SetPropExcelCell(WS, i, iExcelNumLine, 0, xlCenter);
      vExcel.Cells[iExcelNumLine, I].Font.Size := SFontSize;
    end;
    { Вывод таблицы }
    qrspPay.First;
    while not qrspPay.Eof do begin
      inc(RecNumb);
      pnlControl_Show.Caption := 'Формирование отчета: '+VarToStr(RecNumb)+'/'+VarToStr(RecCount);
      inc(iExcelNumLine);
      for num_cnt := 1 to fl_cnt do begin
        vExcel.ActiveCell[iExcelNumLine, num_cnt].Value := qrspPay.Fields[num_cnt - 1].AsString;
        SetPropExcelCell(WS, num_cnt, iExcelNumLine, 0, xlLeft);
        vExcel.Cells[iExcelNumLine, num_cnt].Font.Size := SFontSize;
      end;
      qrspPay.Next;
    end;
    { Ширина колонок }
    vExcel.Columns[01].ColumnWidth := 05;  { № п/п }
    vExcel.Columns[02].ColumnWidth := 07;  { Заказ }
    vExcel.Columns[03].ColumnWidth := 17;  { Дата платежа }
    vExcel.Columns[04].ColumnWidth := 10;  { Номер платежа }
    vExcel.Columns[05].ColumnWidth := 10;  { Сумма }
    vExcel.Columns[06].ColumnWidth := 20;  { Назначение }
    vExcel.Columns[07].ColumnWidth := 17;  { Дата создания }
    { Перенос слов }
    WS.Range[CellName(01,4) + ':' + CellName(07,iExcelNumLine)].WrapText:=true;
    { Показываем }
    vExcel.Visible := True;
  except
    on E: Exception do begin
      if vExcel = varDispatch then vExcel.Quit;
    end;
  end;
  pnlControl_Show.Caption := '';
end;

procedure TfrmCCJS_RP_Pay.aCloseExecute(Sender: TObject);
begin
  self.Close;
end;

end.
