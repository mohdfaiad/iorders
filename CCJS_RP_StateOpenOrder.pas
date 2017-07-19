unit CCJS_RP_StateOpenOrder;

{***********************************************************
 * © PgkSoft 21.05.2015
 * Журнал интернет заказов.
 * Отчет <Состояние открытых заказов>
 * Основание действия (операции).
 ***********************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ComCtrls, ExtCtrls, StdCtrls, ToolWin, DB, ADODB, Excel97, ComObj;

type
  TfrmCCJS_RP_StateOpenOrder = class(TForm)
    pnlPage: TPanel;
    pageControl: TPageControl;
    tabParm: TTabSheet;
    actionList: TActionList;
    aExcel: TAction;
    aClose: TAction;
    pnlControl: TPanel;
    pnlControl_Tool: TPanel;
    tollBar: TToolBar;
    tlbtnExcel: TToolButton;
    tlbtnClose: TToolButton;
    pnlControl_Show: TPanel;
    grpbxPeriod: TGroupBox;
    Label1: TLabel;
    dtBegin: TDateTimePicker;
    Label2: TLabel;
    dtEnd: TDateTimePicker;
    qrspStateOpenOrder: TADOStoredProc;
    grpbxLastDateAction: TGroupBox;
    DateLastAction: TDateTimePicker;
    TimeLastAction: TDateTimePicker;
    grpbxStatus: TGroupBox;
    lblStatusDateFormation: TLabel;
    edStatusDateFormation: TEdit;
    btnStatusDateFormation: TButton;
    lblStatusDateBell: TLabel;
    edStatusDateBell: TEdit;
    btnStatusDateBell: TButton;
    lblStatusBeginPicking: TLabel;
    edStatusBeginPicking: TEdit;
    btnStatusBeginPicking: TButton;
    lblStatusEndPicking: TLabel;
    edStatusEndPicking: TEdit;
    btnStatusEndPicking: TButton;
    lblStatusReadySend: TLabel;
    edStatusReadySend: TEdit;
    btnStatusReadySend: TButton;
    aSLStatus_DateFormation: TAction;
    aSLStatus_DateBell: TAction;
    aSLStatus_BeginPicking: TAction;
    aSLStatus_EndPicking: TAction;
    aSLStatus_ReadySend: TAction;
    spFindStatus: TADOStoredProc;
    pnl: TPanel;
    lblOrderState: TLabel;
    cmbxOrderState: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aCloseExecute(Sender: TObject);
    procedure aSLStatus_DateFormationExecute(Sender: TObject);
    procedure aSLStatus_DateBellExecute(Sender: TObject);
    procedure aSLStatus_BeginPickingExecute(Sender: TObject);
    procedure aSLStatus_EndPickingExecute(Sender: TObject);
    procedure aSLStatus_ReadySendExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActive    : integer;
    procedure ShowGets;
    procedure SelectStatus(ItemEdit : string);
  public
    { Public declarations }
  end;

var
  frmCCJS_RP_StateOpenOrder: TfrmCCJS_RP_StateOpenOrder;

implementation

uses
  Util,
  UMain, UCCenterJournalNetZkz, ExDBGRID, DateUtils, UReference;

{$R *.dfm}

procedure TfrmCCJS_RP_StateOpenOrder.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive  := 0;
  dtBegin.Date        := Date;
  dtEnd.Date          := Date;
  DateLastAction.Date := Date;
  TimeLastAction.Time := Time;
end;

procedure TfrmCCJS_RP_StateOpenOrder.FormActivate(Sender: TObject);
begin
  if ISignActive = 0 then begin
    { Иконка окна }
    FCCenterJournalNetZkz.imgMain.GetIcon(111,self.Icon);
    { Стандартные статусы }
    edStatusDateFormation.Text := 'Заказ обработан';
    edStatusDateBell.Text      := 'Выполнен звонок клиенту';
    edStatusBeginPicking.Text  := 'Заказ в процессе сборки';
    edStatusEndPicking.Text    := 'Товар готов к отправке';
    edStatusReadySend.Text     := 'Товар готов к отправке';
    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJS_RP_StateOpenOrder.ShowGets;
begin
  if ISignActive = 1 then begin
  end;
end;

procedure TfrmCCJS_RP_StateOpenOrder.aExcelExecute(Sender: TObject);
var
  vExcel               : OleVariant;
  vDD                  : OleVariant;
  WS                   : OleVariant;
  Cells                : OleVariant;
  I                    : integer;
  iExcelNumLine        : integer;
  iBeginTableNumLine   : integer;
  fl_cnt               : integer;
  num_cnt              : integer;
  iInteriorColor       : integer;
  iHorizontalAlignment : integer;
  RecNumb              : integer;
  RecCount             : integer;
  SFontSize            : string;

  function CheckStatus(Status : string) : boolean;
  var bRes : boolean;
  begin
    spFindStatus.Parameters.ParamValues['@Descr'] := Status;
    spFindStatus.ExecProc;
    if spFindStatus.Parameters.ParamValues['@NRN_OUT'] <> 0 then bRes := true else begin
      bRes := false;
      ShowMessage('!!! Наменование статуса <'+Status+'> не найдено.');
    end;
    result := bRes;
  end;

begin
  { Проверка наличия статусов }
  if not CheckStatus(edStatusDateFormation.Text) then exit;
  if not CheckStatus(edStatusDateBell.Text)      then exit;
  if not CheckStatus(edStatusBeginPicking.Text)  then exit;
  if not CheckStatus(edStatusEndPicking.Text)    then exit;
  if not CheckStatus(edStatusReadySend.Text)     then exit;
  SFontSize := '10';
  iInteriorColor := 0;
  try
    { Запуск табличного процессора }
    pnlControl_Show.Caption := 'Запуск табличного процессора...';
    vExcel := CreateOLEObject('Excel.Application');
    vDD := vExcel.Workbooks.Add;
    WS := vDD.Sheets[1];
    WS.PageSetup.Orientation := xlLandscape;
    { Формирование набора данных }
    pnlControl_Show.Caption := 'Формирование набора данных...';
    if qrspStateOpenOrder.Active then qrspStateOpenOrder.Active := false;
    qrspStateOpenOrder.Parameters.ParamValues['@SBegin']     := FormatDateTime('yyyy-mm-dd', dtBegin.Date);
    qrspStateOpenOrder.Parameters.ParamValues['@SEnd']       := FormatDateTime('yyyy-mm-dd', IncDay(dtEnd.Date,1));
    qrspStateOpenOrder.Parameters.ParamValues['@SActionEnd'] := FormatDateTime('yyyy-mm-dd', DateLastAction.Date) + ' ' + FormatDateTime('hh:nn:ss', TimeLastAction.Time);
    qrspStateOpenOrder.Parameters.ParamValues['@StatusDateFormation'] := edStatusDateFormation.Text;
    qrspStateOpenOrder.Parameters.ParamValues['@StatusDateBell']      := edStatusDateBell.Text;
    qrspStateOpenOrder.Parameters.ParamValues['@StatusBeginPicking']  := edStatusBeginPicking.Text;
    qrspStateOpenOrder.Parameters.ParamValues['@StatusEndPicking']    := edStatusEndPicking.Text;
    qrspStateOpenOrder.Parameters.ParamValues['@StatusReadySend']     := edStatusReadySend.Text;
    qrspStateOpenOrder.Parameters.ParamValues['@SignOrderState']      := cmbxOrderState.ItemIndex;
    qrspStateOpenOrder.Open;
    RecCount := qrspStateOpenOrder.RecordCount;
    iExcelNumLine := 0;
    RecNumb := 0;
    { Заголовок отчета }
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'СОСТОЯНИЕ ОТКРЫТЫХ ЗАКАЗОВ';
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Дата формирования:' + FormatDateTime('dd-mm-yyyy hh:nn:ss', Now);
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Дата последнего дествия:' + FormatDateTime('dd-mm-yyyy', DateLastAction.Date) + ' ' + FormatDateTime('hh:nn:ss', TimeLastAction.Time);
    inc(iExcelNumLine);
    { Статусы }
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'СТАТУСЫ';
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Дата формирования заказа:';
    vExcel.ActiveCell[iExcelNumLine, 4].Value := edStatusDateFormation.Text;
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Время звонка:';
    vExcel.ActiveCell[iExcelNumLine, 4].Value := edStatusDateBell.Text;
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Время сбора всего заказа (Начало):';
    vExcel.ActiveCell[iExcelNumLine, 4].Value := edStatusBeginPicking.Text;
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Время сбора всего заказа (Окончание):';
    vExcel.ActiveCell[iExcelNumLine, 4].Value := edStatusEndPicking.Text;
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Время отправки заказа покупателю:';
    vExcel.ActiveCell[iExcelNumLine, 4].Value := edStatusReadySend.Text;
    inc(iExcelNumLine);
    { Заголовок таблицы }
    inc(iExcelNumLine);
    iBeginTableNumLine := iExcelNumLine;
    fl_cnt := qrspStateOpenOrder.FieldCount;
    for I := 1 to fl_cnt do begin
      vExcel.ActiveCell[iExcelNumLine, I].Value := qrspStateOpenOrder.Fields[I - 1].FieldName;
      SetPropExcelCell(WS, i, iExcelNumLine, 0, xlCenter);
      vExcel.Cells[iExcelNumLine, I].Font.Size := SFontSize;
    end;
    { Вывод таблицы }
    qrspStateOpenOrder.First;
    while not qrspStateOpenOrder.Eof do begin
      inc(RecNumb);
      pnlControl_Show.Caption := 'Формирование отчета: '+VarToStr(RecNumb)+'/'+VarToStr(RecCount);
      inc(iExcelNumLine);
      if length(qrspStateOpenOrder.FieldByName('Дата закрытия заказа').AsString) = 0
        then iInteriorColor := 0
        else iInteriorColor := 19;
      for num_cnt := 1 to fl_cnt do begin
        vExcel.ActiveCell[iExcelNumLine, num_cnt].Value := qrspStateOpenOrder.Fields[num_cnt - 1].AsString;
        SetPropExcelCell(WS, num_cnt, iExcelNumLine, iInteriorColor, xlLeft);
        vExcel.Cells[iExcelNumLine, num_cnt].Font.Size := SFontSize;
      end;
      qrspStateOpenOrder.Next;
    end;
    { Ширина колонок }
    vExcel.Columns[01].ColumnWidth := 05;  { № п/п }
    vExcel.Columns[02].ColumnWidth := 20;  { Вид доставки }
    vExcel.Columns[03].ColumnWidth := 10;  { Заказ }
    vExcel.Columns[04].ColumnWidth := 10;  { Сумма }
    vExcel.Columns[05].ColumnWidth := 17;  { Дата заказа }
    vExcel.Columns[06].ColumnWidth := 30;  { Наименование последнего действия }
    vExcel.Columns[07].ColumnWidth := 17;  { Дата последнего действия }
    vExcel.Columns[08].ColumnWidth := 20;  { Пользователь }
    vExcel.Columns[09].ColumnWidth := 20;  { Наименование последнего статуса }
    vExcel.Columns[10].ColumnWidth := 17;  { Дата последнего статуса }
    vExcel.Columns[11].ColumnWidth := 20;  { Пользователь }
    vExcel.Columns[12].ColumnWidth := 17;  { Дата экспорта в 1С }
    vExcel.Columns[13].ColumnWidth := 14;  { Время формирования заказа }
    vExcel.Columns[14].ColumnWidth := 14;  { Время 1-го звонка }
    vExcel.Columns[15].ColumnWidth := 14;  { Время последнего звонка }
    vExcel.Columns[16].ColumnWidth := 14;  { Время начала сбора всего товара }
    vExcel.Columns[17].ColumnWidth := 14;  { Время сбора всего товара }
    vExcel.Columns[18].ColumnWidth := 17;  { Дата оплаты заказа }
    vExcel.Columns[19].ColumnWidth := 14;  { Время оплаты заказа }
    vExcel.Columns[20].ColumnWidth := 17;  { Дата отправки заказа }
    vExcel.Columns[21].ColumnWidth := 14;  { Время отправки заказа }
    vExcel.Columns[22].ColumnWidth := 17;  { Дата закрытия заказа }
    { Перенос слов }
    WS.Range[CellName(1,iBeginTableNumLine) + ':' + CellName(fl_cnt,iExcelNumLine)].WrapText:=true;
    { Показываем }
    vExcel.Visible := True;
  except
    on E: Exception do begin
      if vExcel = varDispatch then vExcel.Quit;
    end;
  end;
  pnlControl_Show.Caption := '';
end;

procedure TfrmCCJS_RP_StateOpenOrder.aCloseExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJS_RP_StateOpenOrder.SelectStatus(ItemEdit : string);
var
  DescrSelect : string;
begin
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFReferenceOrderStatus);
   frmReference.SetReadOnly(cFReferenceNoReadOnly);
   frmReference.SetOrderShipping('');
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if length(DescrSelect) > 0 then begin
      if      ItemEdit = 'DateFormation' then edStatusDateFormation.Text := DescrSelect
      else if ItemEdit = 'DateBell'      then edStatusDateBell.Text      := DescrSelect
      else if ItemEdit = 'BeginPicking'  then edStatusBeginPicking.Text  := DescrSelect
      else if ItemEdit = 'EndPicking'    then edStatusEndPicking.Text    := DescrSelect
      else if ItemEdit = 'ReadySend'     then edStatusReadySend.Text     := DescrSelect;
    end;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJS_RP_StateOpenOrder.aSLStatus_DateFormationExecute(Sender: TObject);
begin
  SelectStatus('DateFormation');
end;

procedure TfrmCCJS_RP_StateOpenOrder.aSLStatus_DateBellExecute(Sender: TObject);
begin
  SelectStatus('DateBell');
end;

procedure TfrmCCJS_RP_StateOpenOrder.aSLStatus_BeginPickingExecute(Sender: TObject);
begin
  SelectStatus('BeginPicking');
end;

procedure TfrmCCJS_RP_StateOpenOrder.aSLStatus_EndPickingExecute(Sender: TObject);
begin
  SelectStatus('EndPicking');
end;

procedure TfrmCCJS_RP_StateOpenOrder.aSLStatus_ReadySendExecute(Sender: TObject);
begin
  SelectStatus('ReadySend');
end;

end.
