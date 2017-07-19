unit CCJSO_RP_StateOrdersDeliveryPay;

{***********************************************************************
 * © PgkSoft 29.04.2015
 * Журнал интернет заказов
 * 1.	Состояние заказов по "наложенным платежам" за календарный период
 ***********************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  UCCenterJournalNetZkz, DB, ADODB;

type
  TfrmCCJSO_RP_StateOrdersDeliveryPay = class(TForm)
    pnlControl: TPanel;
    pnlControl_Tool: TPanel;
    tollBar: TToolBar;
    tlbtnExcel: TToolButton;
    tlbtnClose: TToolButton;
    pnlControl_Show: TPanel;
    pnlParm: TPanel;
    gbxParm: TGroupBox;
    aList: TActionList;
    aExcel: TAction;
    aClose: TAction;
    lblDateBegin: TLabel;
    lblDateEnd: TLabel;
    edDateBegin: TEdit;
    edDateEnd: TEdit;
    btnDateBegin: TButton;
    btnDateEnd: TButton;
    aSlDate: TAction;
    aFieldChange: TAction;
    qrspPay: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aCloseExecute(Sender: TObject);
    procedure aSlDateExecute(Sender: TObject);
    procedure aFieldChangeExecute(Sender: TObject);
  private
    { Private declarations }
    bSignActive  : boolean;
    RecSession   : TUserSession;
    DFormatSet   : TFormatSettings;
    procedure ShowGets;
  public
    { Public declarations }
    procedure SetRecSession(Parm : TUserSession);
  end;

var
  frmCCJSO_RP_StateOrdersDeliveryPay: TfrmCCJSO_RP_StateOrdersDeliveryPay;

implementation

uses
  UMain, CCJSO_SetFieldDate, ComObj, Excel97, ExDBGRID;

{$R *.dfm}

procedure TfrmCCJSO_RP_StateOrdersDeliveryPay.FormCreate(Sender: TObject);
begin
  { Инициализация }
  bSignActive := false;
  DFormatSet.DateSeparator := '-';
  DFormatSet.TimeSeparator := ':';
  DFormatSet.ShortDateFormat := 'dd-mm-yyyy';
  DFormatSet.ShortTimeFormat := 'hh24:mi:ss';
end;

procedure TfrmCCJSO_RP_StateOrdersDeliveryPay.FormActivate(Sender: TObject);
begin
  if not bSignActive then begin
    { Иконка окна }
    FCCenterJournalNetZkz.imgMain.GetIcon(369,self.Icon);
    { Форма активна }
    bSignActive := true;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_RP_StateOrdersDeliveryPay.ShowGets;
var
  DBegin : TDateTime;
  DEnd   : TDateTime;
begin
  if (length(edDateBegin.Text) > 0) and (length(edDateEnd.Text) > 0) then begin
    DBegin := StrToDateTime(edDateBegin.Text,DFormatSet);
    DEnd   := StrToDateTime(edDateEnd.Text,DFormatSet);
  end else begin
    DBegin := now;
    DEnd := DBegin;
  end;
  if bSignActive then begin
    { Доступ к команде формирования отчета }
    if   (length(edDateBegin.Text) = 0)
      or (length(edDateEnd.Text) = 0)
      or (DBegin >= DEnd)
      then aExcel.Enabled := false
      else aExcel.Enabled := true;
  end;
end;

procedure TfrmCCJSO_RP_StateOrdersDeliveryPay.SetRecSession(Parm : TUserSession); begin RecSession := Parm; end;

procedure TfrmCCJSO_RP_StateOrdersDeliveryPay.aExcelExecute(Sender: TObject);
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
  SumAll               : Currency;    { Сумма всего }
  SumRecd              : Currency;    { Сумма получено }
  CountRecd            : integer;     { Количество получено }
begin
  SFontSize := '10';
  SumAll    := 0;
  SumRecd   := 0;
  CountRecd := 0;
  try
    pnlControl_Show.Caption := 'Запуск табличного процессора...';
    vExcel := CreateOLEObject('Excel.Application');
    vDD := vExcel.Workbooks.Add;
    WS := vDD.Sheets[1];
    pnlControl_Show.Caption := 'Формирование набора данных...';
    Application.ProcessMessages;
    if qrspPay.Active then qrspPay.Active := false;
    qrspPay.Parameters.ParamValues['@SBegin'] := FormatDateTime('yyyy-mm-dd hh:nn:ss',StrToDateTime(edDateBegin.Text,DFormatSet));
    qrspPay.Parameters.ParamValues['@SEnd']   := FormatDateTime('yyyy-mm-dd hh:nn:ss',StrToDateTime(edDateEnd.Text,DFormatSet));
    qrspPay.Open;
    RecCount := qrspPay.RecordCount;
    iExcelNumLine := 0;
    RecNumb := 0;
    { Заголовок отчета }
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Состояние заказов по наложенным платежам';
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'За период с ' + edDateBegin.Text + '  по ' + edDateEnd.Text;
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
        { Уточняем свойства поля }
        if   (qrspPay.Fields[num_cnt - 1].FullName = 'Телефон')
          or (qrspPay.Fields[num_cnt - 1].FullName = 'Дата заказа')
          or (qrspPay.Fields[num_cnt - 1].FullName = 'Дата отправки')
          or (qrspPay.Fields[num_cnt - 1].FullName = 'Дата платежа')
          then vExcel.Cells[iExcelNumLine, num_cnt].NumberFormat := '@';
        if   (qrspPay.Fields[num_cnt - 1].FullName = 'Сумма заказа')
          or (qrspPay.Fields[num_cnt - 1].FullName = 'Сумма получено')
          then vExcel.Cells[iExcelNumLine, num_cnt].NumberFormat := '0.00';
        { Подсчет интегральных показателей }
        if qrspPay.Fields[num_cnt - 1].FullName = 'Сумма заказа' then SumAll := SumAll + qrspPay.Fields[num_cnt - 1].AsCurrency;
        if qrspPay.Fields[num_cnt - 1].FullName = 'Сумма получено' then
          if qrspPay.Fields[num_cnt - 1].AsCurrency > 0 then begin
            inc(CountRecd);
            SumRecd := SumRecd + qrspPay.Fields[num_cnt - 1].AsCurrency;
          end;
        { Отображаем }
        vExcel.ActiveCell[iExcelNumLine, num_cnt].Value := qrspPay.Fields[num_cnt - 1].AsString;
        SetPropExcelCell(WS, num_cnt, iExcelNumLine, 0, xlLeft);
        vExcel.Cells[iExcelNumLine, num_cnt].Font.Size := SFontSize;
      end;
      qrspPay.Next;
    end;
    { Ширина колонок }
    vExcel.Columns[01].ColumnWidth := 05;  { № п/п }
    vExcel.Columns[02].ColumnWidth := 08;  { Тип }
    vExcel.Columns[03].ColumnWidth := 08;  { Заказ }
    vExcel.Columns[04].ColumnWidth := 18;  { Дата заказа }
    vExcel.Columns[05].ColumnWidth := 18;  { Дата отправки }
    vExcel.Columns[06].ColumnWidth := 10;  { Сумма заказа }
    vExcel.Columns[07].ColumnWidth := 10;  { Сумма получено }
    vExcel.Columns[08].ColumnWidth := 10;  { Дата платежа }
    vExcel.Columns[09].ColumnWidth := 30;  { Клиент }
    vExcel.Columns[10].ColumnWidth := 18;  { Телефон }
    vExcel.Columns[11].ColumnWidth := 15;  { Дополнительные }
    vExcel.Columns[12].ColumnWidth := 15;  { Родительские }
    { Перенос слов }
    WS.Range[CellName(01,5) + ':' + CellName(12,iExcelNumLine)].WrapText:=true;
    { Итоги }
    inc(iExcelNumLine); inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'В пути';
    vExcel.ActiveCell[iExcelNumLine, 3].Value := VarToStr(RecNumb - CountRecd);
    vExcel.ActiveCell[iExcelNumLine, 4].Value := VarToStr(SumAll - SumRecd);
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Получено';
    vExcel.ActiveCell[iExcelNumLine, 3].Value := VarToStr(CountRecd);
    vExcel.ActiveCell[iExcelNumLine, 4].Value := VarToStr(SumRecd);
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Всего';
    vExcel.ActiveCell[iExcelNumLine, 3].Value := VarToStr(RecNumb);
    vExcel.ActiveCell[iExcelNumLine, 4].Value := VarToStr(SumAll);
    { Показываем }
    vExcel.Visible := True;
  except
    on E: Exception do begin
      if vExcel = varDispatch then vExcel.Quit;
    end;
  end;
  pnlControl_Show.Caption := '';end;

procedure TfrmCCJSO_RP_StateOrdersDeliveryPay.aCloseExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmCCJSO_RP_StateOrdersDeliveryPay.aSlDateExecute(Sender: TObject);
var
  EdText         : string;
  DVal           : TDateTime;
  WHeaderCaption : string;
  Tag            : integer;
begin
  Tag := 0;
  if      Sender is TAction then Tag := (Sender as TAction).ActionComponent.Tag
  else if Sender is TEdit   then Tag := (Sender as TEdit).Tag;
  case Tag of
    10: begin EdText := edDateBegin.Text;  WHeaderCaption := 'Дата начала' end;
    11: begin EdText := edDateEnd.Text;    WHeaderCaption := 'Дата окончания' end;
  end;
  if length(trim(EdText)) > 0 then begin
    DVal := StrToDateTime(EdText,DFormatSet);
  end else DVal := now;
  try
    frmCCJSO_SetFieldDate := TfrmCCJSO_SetFieldDate.Create(Self);
    frmCCJSO_SetFieldDate.SetMode(cFieldDate_Shared);
    frmCCJSO_SetFieldDate.SetUserSession(RecSession);
    frmCCJSO_SetFieldDate.SetTypeExec(cSFDTypeExec_Return);
    frmCCJSO_SetFieldDate.SetClear(true);
    frmCCJSO_SetFieldDate.SetDateShared(DVal,EdText,WHeaderCaption);
    try
      frmCCJSO_SetFieldDate.ShowModal;
      if frmCCJSO_SetFieldDate.GetOk then begin
        case Tag of
          10: edDateBegin.Text := frmCCJSO_SetFieldDate.GetSDate;
          11: edDateEnd.Text   := frmCCJSO_SetFieldDate.GetSDate;
        end;
      end;
    finally
      FreeAndNil(frmCCJSO_SetFieldDate);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
  ShowGets;
end;

procedure TfrmCCJSO_RP_StateOrdersDeliveryPay.aFieldChangeExecute(Sender: TObject);
begin
  ShowGets;
end;

end.
