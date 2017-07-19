unit CCJS_RP_JEMailBadArmor;

{****************************************************************
 * © PgkSoft 09.06.2015
 * Журнал интернет заказов.
 * Отчет <Журнал регистрации EMail по неотработанным заказам>
 ****************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ToolWin, ExtCtrls, ActnList, DB, ADODB;

type
  TfrmCCJS_RP_JEMailBadArmor = class(TForm)
    pnlControl: TPanel;
    pnlControl_Tool: TPanel;
    tollBar: TToolBar;
    tlbtnExcel: TToolButton;
    tlbtnClose: TToolButton;
    pnlControl_Show: TPanel;
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
    qrspJEMailBadArmor: TADOStoredProc;
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
  frmCCJS_RP_JEMailBadArmor: TfrmCCJS_RP_JEMailBadArmor;

implementation

uses
  Util,  ComObj, Excel97,
  UMain, UCCenterJournalNetZkz, ExDBGRID, DateUtils;

{$R *.dfm}

procedure TfrmCCJS_RP_JEMailBadArmor.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
  dtBegin.Date := Date;
  dtEnd.Date   := Date;
end;

procedure TfrmCCJS_RP_JEMailBadArmor.FormActivate(Sender: TObject);
begin
  if ISignActive = 0 then begin
    { Иконка окна }
    {FCCenterJournalNetZkz.imgMain.GetIcon(271,self.Icon);}
    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJS_RP_JEMailBadArmor.ShowGets;
begin
  if ISignActive = 1 then begin
  end;
end;


procedure TfrmCCJS_RP_JEMailBadArmor.aExcelExecute(Sender: TObject);
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
begin
  SFontSize := '10';
  try
    pnlControl_Show.Caption := 'Запуск табличного процессора...';
    vExcel := CreateOLEObject('Excel.Application');
    vDD := vExcel.Workbooks.Add;
    WS := vDD.Sheets[1];
    pnlControl_Show.Caption := 'Формирование набора данных...';
    if qrspJEMailBadArmor.Active then qrspJEMailBadArmor.Active := false;
    qrspJEMailBadArmor.Parameters.ParamValues['@SBegin'] := FormatDateTime('yyyy-mm-dd', dtBegin.Date);
    qrspJEMailBadArmor.Parameters.ParamValues['@SEnd']   := FormatDateTime('yyyy-mm-dd', IncDay(dtEnd.Date,1));
    qrspJEMailBadArmor.Open;
    RecCount := qrspJEMailBadArmor.RecordCount;
    iExcelNumLine := 0;
    RecNumb := 0;
    { Заголовок отчета }
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Журнал регистрации EMail по неотработанным заказам';
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Дата формирования: ' + FormatDateTime('dd-mm-yyyy hh:nn:ss', Now);
    inc(iExcelNumLine);
    { Заголовок таблицы }
    inc(iExcelNumLine);
    iExcelNumLineStart := iExcelNumLine;
    fl_cnt := qrspJEMailBadArmor.FieldCount;
    for I := 1 to fl_cnt do begin
      vExcel.ActiveCell[iExcelNumLine, I].Value := qrspJEMailBadArmor.Fields[I - 1].FieldName;
      SetPropExcelCell(WS, i, iExcelNumLine, 0, xlCenter);
      vExcel.Cells[iExcelNumLine, I].Font.Size := SFontSize;
    end;
    { Вывод таблицы }
    qrspJEMailBadArmor.First;
    while not qrspJEMailBadArmor.Eof do begin
      inc(RecNumb);
      pnlControl_Show.Caption := 'Формирование отчета: '+VarToStr(RecNumb)+'/'+VarToStr(RecCount);
      inc(iExcelNumLine);
      for num_cnt := 1 to fl_cnt do begin
        vExcel.ActiveCell[iExcelNumLine, num_cnt].Value := qrspJEMailBadArmor.Fields[num_cnt - 1].AsString;
        SetPropExcelCell(WS, num_cnt, iExcelNumLine, 0, xlLeft);
        vExcel.Cells[iExcelNumLine, num_cnt].Font.Size := SFontSize;
      end;
      qrspJEMailBadArmor.Next;
    end;
    { Ширина колонок }
    vExcel.Columns[01].ColumnWidth := 05;  { № п/п }
    vExcel.Columns[02].ColumnWidth := 07;  { Заказ }
    vExcel.Columns[03].ColumnWidth := 20;  { Дата сообщения }
    vExcel.Columns[04].ColumnWidth := 12;  { Количество сообщений }
    vExcel.Columns[05].ColumnWidth := 20;  { Дата закрытия заказа }
    vExcel.Columns[06].ColumnWidth := 25; { Тип плохового заказа }
    { Перенос слов }
    WS.Range[CellName(01,iExcelNumLineStart) + ':' + CellName(fl_cnt,iExcelNumLine)].WrapText:=true;
    { Показываем }
    vExcel.Visible := True;
  except
    on E: Exception do begin
      if vExcel = varDispatch then vExcel.Quit;
    end;
  end;
  pnlControl_Show.Caption := '';
end;

procedure TfrmCCJS_RP_JEMailBadArmor.aCloseExecute(Sender: TObject);
begin
  self.Close;
end;

end.
