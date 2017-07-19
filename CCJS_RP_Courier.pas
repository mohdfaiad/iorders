unit CCJS_RP_Courier;

{********************************************
 * © PgkSoft 16.06.2015
 * Журнал интернет заказов.
 * Отчет <Состояние курьерской доставки>
 ********************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Excel97, ComObj, ActnList, ComCtrls, ExtCtrls, StdCtrls, ToolWin,
  CheckLst, DB, ADODB, Mask;

type
  TfrmCCJS_RP_Courier = class(TForm)
    pnlParm: TPanel;
    pnlControl: TPanel;
    pgParm: TPageControl;
    tabParm: TTabSheet;
    aList: TActionList;
    pnlControl_Tool: TPanel;
    pnlControl_Show: TPanel;
    aExcel: TAction;
    aExit: TAction;
    tlbrControl: TToolBar;
    tlbtnControl_Excel: TToolButton;
    ToolButton1: TToolButton;
    grbxPharmGroup: TGroupBox;
    pnlPharmGroup_Control: TPanel;
    pnlPharmGroup_List: TPanel;
    chListBoxGroupPharm: TCheckListBox;
    tlbrPharmGroup: TToolBar;
    aListToll_AllPharm: TAction;
    aListToll_ClearSelectGroup: TAction;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    pnlPharmGroup_Control_Show: TPanel;
    pDSGroupCount: TADOStoredProc;
    pnlPeriod: TPanel;
    pnlPeriod_Check: TPanel;
    pnlPeriod_Periods: TPanel;
    cmbxCheckPeriod: TComboBox;
    lbl: TLabel;
    pgcPeriods: TPageControl;
    tabPeriod_Day: TTabSheet;
    Label1: TLabel;
    dtDayBegin: TDateTimePicker;
    Label2: TLabel;
    dtDayEnd: TDateTimePicker;
    tabPeriod_Date: TTabSheet;
    tabPeriod_Orders: TTabSheet;
    dtDateBegin: TDateTimePicker;
    dtTimeBegin: TDateTimePicker;
    Label3: TLabel;
    dtTimeEnd: TDateTimePicker;
    dtDateEnd: TDateTimePicker;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edOrderBegin: TEdit;
    edOrderEnd: TEdit;
    spSelectList_Insert: TADOStoredProc;
    spSelectList_Clear: TADOStoredProc;
    spDS_RP_Courier: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aListToll_AllPharmExecute(Sender: TObject);
    procedure aListToll_ClearSelectGroupExecute(Sender: TObject);
    procedure dtDayBeginChange(Sender: TObject);
    procedure dtDayEndChange(Sender: TObject);
    procedure chListBoxGroupPharmClickCheck(Sender: TObject);
    procedure cmbxCheckPeriodChange(Sender: TObject);
    procedure edOrderBeginChange(Sender: TObject);
    procedure edOrderEndChange(Sender: TObject);
    procedure edOrderBeginExit(Sender: TObject);
    procedure edOrderEndExit(Sender: TObject);
    procedure dtDateBeginChange(Sender: TObject);
    procedure dtTimeBeginChange(Sender: TObject);
    procedure dtDateEndChange(Sender: TObject);
    procedure dtTimeEndChange(Sender: TObject);
  private
    { Private declarations }
    { Private declarations }
    ISignActive              : smallint;
    IdUserAction             : longint;
    NSumCountOrderGroupPharm : integer;
    procedure ShowGets;
    procedure CreateListGroupPharm;
  public
    { Public declarations }
  end;

var
  frmCCJS_RP_Courier: TfrmCCJS_RP_Courier;

implementation

uses
  Util,
  UMain, UCCenterJournalNetZkz, ExDBGRID, DateUtils, UReference;

const
  sMsgOrderTypeInt = 'Номер заказа имеет числовой формат';

{$R *.dfm}

procedure TfrmCCJS_RP_Courier.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive  := 0;
  NSumCountOrderGroupPharm := 0;
  dtDayBegin.Date := Date;
  dtDayEnd.Date   := Date;
  dtDateBegin.Date := Date;
  dtTimeBegin.Time := EncodeTime(0, 0, 0, 0);
  dtDateEnd.Date := Date;
  dtTimeEnd.Time := Time;
end;

procedure TfrmCCJS_RP_Courier.FormActivate(Sender: TObject);
begin
  if ISignActive = 0 then begin
    { Иконка окна }
    FCCenterJournalNetZkz.imgMain.GetIcon(284,self.Icon);
    { Приводим закладки к более красивому виду }
    tabPeriod_Day.Caption    := '';
    tabPeriod_Date.Caption   := '';
    tabPeriod_Orders.Caption := '';
    pgcPeriods.TabHeight     := 1;
    pgcPeriods.TabPosition   := tpLeft;
    pnlPeriod.Height         := 72;

    { Создаем список }
    CreateListGroupPharm;
    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJS_RP_Courier.ShowGets;
  procedure ShowTabPeriod(SignDay,SignDate,SignOrder : boolean); begin
    tabPeriod_Day.TabVisible    := SignDay;
    tabPeriod_Date.TabVisible   := SignDate;
    tabPeriod_Orders.TabVisible := SignOrder;
  end;
begin
  if ISignActive = 1 then begin
    { Доступ к элементам управления }
    if aListToll_AllPharm.Checked then begin
      chListBoxGroupPharm.Enabled := false;
      aExcel.Enabled := true;
      aListToll_ClearSelectGroup.Enabled := false;
    end else begin
      chListBoxGroupPharm.Enabled := true;
      if GetCountCheckListBox(chListBoxGroupPharm) = 0 then begin
        aExcel.Enabled := false;
        aListToll_ClearSelectGroup.Enabled := false;
      end else begin
        aExcel.Enabled := true;
        aListToll_ClearSelectGroup.Enabled := true;
      end;
    end;
    if chListBoxGroupPharm.Count = 0 then aExcel.Enabled := false;
    { Выбор вида контрольного периода }
    case cmbxCheckPeriod.ItemIndex of
      0: ShowTabPeriod(true, false,false);
      1: ShowTabPeriod(false,true, false);
      2: ShowTabPeriod(false,false,true);
    end;
    { Отображение количества заказов }
    pnlPharmGroup_Control_Show.Caption := 'Всего заказов: ' + VarToStr(NSumCountOrderGroupPharm);
  end;
end;

procedure TfrmCCJS_RP_Courier.aExcelExecute(Sender: TObject);
var
  iListBoxItems        : integer;
  BeginDate            : string;
  EndDate              : string;
  OrderBegin           : integer;
  OrderEnd             : integer;
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
begin
  { Формируем список групп аптек }
  IdUserAction := FCCenterJournalNetZkz.GetIdUserAction;
  if aListToll_AllPharm.Checked then begin
    { Все группы }
    pDSGroupCount.First;
    while not pDSGroupCount.Eof do begin
      spSelectList_Insert.Parameters.ParamValues['@IDENT']     := IdUserAction;
      spSelectList_Insert.Parameters.ParamValues['@SUnitCode'] := 'DicGroupPharm';
      spSelectList_Insert.Parameters.ParamValues['@PRN']       := pDSGroupCount.FieldByName('NGeoGroupPharm').AsInteger;
      spSelectList_Insert.Parameters.ParamValues['@BigPRN']    := 0;
      spSelectList_Insert.Parameters.ParamValues['@USER']      := Form1.id_user;
      spSelectList_Insert.ExecProc;
      pDSGroupCount.Next;
    end;
  end else begin
    { Выбранные группы }
    pDSGroupCount.First;
    while not pDSGroupCount.Eof do begin
      iListBoxItems := chListBoxGroupPharm.Items.IndexOfObject( TObject(pDSGroupCount.FieldByName('NGeoGroupPharm').AsInteger) );
      if chListBoxGroupPharm.Checked[iListBoxItems] then begin
        spSelectList_Insert.Parameters.ParamValues['@IDENT']     := IdUserAction;
        spSelectList_Insert.Parameters.ParamValues['@SUnitCode'] := 'DicGroupPharm';
        spSelectList_Insert.Parameters.ParamValues['@PRN']       := pDSGroupCount.FieldByName('NGeoGroupPharm').AsInteger;
        spSelectList_Insert.Parameters.ParamValues['@BigPRN']    := 0;
        spSelectList_Insert.Parameters.ParamValues['@USER']      := Form1.id_user;
        spSelectList_Insert.ExecProc;
      end;
      pDSGroupCount.Next;
    end;
  end;

  SFontSize := '10';
  iInteriorColor := 0;
  if cmbxCheckPeriod.ItemIndex = 0 then begin
    BeginDate  := FormatDateTime('yyyy-mm-dd', dtDayBegin.Date);
    EndDate    := FormatDateTime('yyyy-mm-dd', IncDay(dtDayEnd.Date,1));
    OrderBegin := 0;
    OrderEnd   := 0;
  end else if cmbxCheckPeriod.ItemIndex = 1 then begin
    BeginDate := FormatDateTime('yyyy-mm-dd', dtDateBegin.Date) + ' ' + FormatDateTime('hh:nn:ss', dtTimeBegin.Time);
    EndDate   := FormatDateTime('yyyy-mm-dd', dtDateEnd.Date) + ' ' + FormatDateTime('hh:nn:ss', dtTimeEnd.Time);
    OrderBegin := 0;
    OrderEnd   := 0;
  end else if cmbxCheckPeriod.ItemIndex = 2 then begin
    BeginDate := FormatDateTime('yyyy-mm-dd', dtDayBegin.Date);
    EndDate   := FormatDateTime('yyyy-mm-dd', IncDay(dtDayEnd.Date,1));
    OrderBegin := StrToInt(edOrderBegin.Text);
    OrderEnd   := StrToInt(edOrderEnd.Text);
  end;
  try
    { Запуск табличного процессора }
    pnlControl_Show.Caption := 'Запуск табличного процессора...';
    vExcel := CreateOLEObject('Excel.Application');
    vDD := vExcel.Workbooks.Add;
    WS := vDD.Sheets[1];
    { Формирование набора данных }
    pnlControl_Show.Caption := 'Формирование набора данных...';
    if spDS_RP_Courier.Active then spDS_RP_Courier.Active := false;
    spDS_RP_Courier.Parameters.ParamValues['@IDENT']           := IdUserAction;
    spDS_RP_Courier.Parameters.ParamValues['@KindCheckPeriod'] := cmbxCheckPeriod.ItemIndex;
    spDS_RP_Courier.Parameters.ParamValues['@SBegin']     := BeginDate;
    spDS_RP_Courier.Parameters.ParamValues['@SEnd']       := EndDate;
    spDS_RP_Courier.Parameters.ParamValues['@OrderBegin'] := OrderBegin;
    spDS_RP_Courier.Parameters.ParamValues['@OrderEnd']   := OrderEnd;
    spDS_RP_Courier.Open;
    RecCount := spDS_RP_Courier.RecordCount;
    iExcelNumLine := 0;
    RecNumb := 0;
    { Заголовок таблицы }
    inc(iExcelNumLine);
    iBeginTableNumLine := iExcelNumLine;
    fl_cnt := spDS_RP_Courier.FieldCount;
    for I := 1 to fl_cnt do begin
      vExcel.ActiveCell[iExcelNumLine, I].Value := spDS_RP_Courier.Fields[I - 1].FieldName;
      SetPropExcelCell(WS, i, iExcelNumLine, 0, xlCenter);
      vExcel.Cells[iExcelNumLine, I].Font.Size := SFontSize;
    end;
    { Вывод таблицы }
    spDS_RP_Courier.First;
    while not spDS_RP_Courier.Eof do begin
      inc(RecNumb);
      pnlControl_Show.Caption := 'Формирование отчета: '+VarToStr(RecNumb)+'/'+VarToStr(RecCount);
      inc(iExcelNumLine);
      for num_cnt := 1 to fl_cnt do begin
        vExcel.ActiveCell[iExcelNumLine, num_cnt].Value := spDS_RP_Courier.Fields[num_cnt - 1].AsString;
        SetPropExcelCell(WS, num_cnt, iExcelNumLine, iInteriorColor, xlLeft);
        vExcel.Cells[iExcelNumLine, num_cnt].Font.Size := SFontSize;
      end;
      spDS_RP_Courier.Next;
    end;
    { Ширина колонок }
    vExcel.Columns[01].ColumnWidth := 15;  {  }
    vExcel.Columns[02].ColumnWidth := 15;  {  }
    vExcel.Columns[03].ColumnWidth := 15;  {  }
    vExcel.Columns[04].ColumnWidth := 15;  {  }
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

  { Чистим список выбранных групп }
  spSelectList_Clear.Parameters.ParamValues['@IDENT'] := IdUserAction;
  spSelectList_Clear.ExecProc;
end;

procedure TfrmCCJS_RP_Courier.aExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmCCJS_RP_Courier.aListToll_AllPharmExecute(Sender: TObject);
begin
  if aListToll_AllPharm.Checked
    then aListToll_AllPharm.ImageIndex := 36
    else aListToll_AllPharm.ImageIndex := -1;
  ShowGets;
end;

procedure TfrmCCJS_RP_Courier.CreateListGroupPharm;
var
  OrderBegin : integer;
  OrderEnd   : integer;
begin
  case cmbxCheckPeriod.ItemIndex of
    0: { Календарный период }
    begin
      { Проверка непротиворечивости дат }
      {if dtDayBegin.Date > dtDayEnd.Date then exit; }
      pnlControl_Show.Caption := 'Создание списка групп аптек...';
      NSumCountOrderGroupPharm := 0;
      try
        chListBoxGroupPharm.Clear;
        if pDSGroupCount.Active then pDSGroupCount.Active := false;
        pDSGroupCount.Parameters.ParamValues['@KindCheckPeriod'] := 0;
        pDSGroupCount.Parameters.ParamValues['@SBegin'] := FormatDateTime('yyyy-mm-dd', dtDayBegin.Date);
        pDSGroupCount.Parameters.ParamValues['@SEnd']   := FormatDateTime('yyyy-mm-dd', IncDay(dtDayEnd.Date,1));
        pDSGroupCount.Parameters.ParamValues['@OrderBegin'] := 0;
        pDSGroupCount.Parameters.ParamValues['@OrderEnd'] := 0;
        pDSGroupCount.Open;
        pDSGroupCount.First;
        while not pDSGroupCount.Eof do begin
          NSumCountOrderGroupPharm := NSumCountOrderGroupPharm + pDSGroupCount.FieldByName('NCountOrder').AsInteger;
          chListBoxGroupPharm.Items.AddObject
           (
            pDSGroupCount.FieldByName('SGroupPharmName').AsString + ' - ' + pDSGroupCount.FieldByName('NCountOrder').AsString,
            TObject(pDSGroupCount.FieldByName('NGeoGroupPharm').AsInteger)
           );
          pDSGroupCount.Next;
        end;
      except
        on e:Exception do begin
          ShowMessage('Сбой при формировании списка групп аптек.' + chr(10) + e.Message);
        end;
      end;
      pnlControl_Show.Caption := '';
    end;
    1: { Период (дата + время) }
    begin
      { Проверка непротиворечивости дат }
      (*if dtDateBegin.Date > dtDateEnd.Date then exit
      else if (dtDateBegin.Date = dtDateEnd.Date) and (dtTimeBegin.Time > dtTimeEnd.Time) then exit;*)
      pnlControl_Show.Caption := 'Создание списка групп аптек...';
      NSumCountOrderGroupPharm := 0;
      try
        chListBoxGroupPharm.Clear;
        if pDSGroupCount.Active then pDSGroupCount.Active := false;
        pDSGroupCount.Parameters.ParamValues['@KindCheckPeriod'] := 1;
        pDSGroupCount.Parameters.ParamValues['@SBegin'] := FormatDateTime('yyyy-mm-dd', dtDateBegin.Date) + ' ' + FormatDateTime('hh:nn:ss', dtTimeBegin.Time);
        pDSGroupCount.Parameters.ParamValues['@SEnd']   := FormatDateTime('yyyy-mm-dd', dtDateEnd.Date) + ' ' + FormatDateTime('hh:nn:ss', dtTimeEnd.Time);
        pDSGroupCount.Parameters.ParamValues['@OrderBegin'] := 0;
        pDSGroupCount.Parameters.ParamValues['@OrderEnd'] := 0;
        pDSGroupCount.Open;
        pDSGroupCount.First;
        while not pDSGroupCount.Eof do begin
          NSumCountOrderGroupPharm := NSumCountOrderGroupPharm + pDSGroupCount.FieldByName('NCountOrder').AsInteger;
          chListBoxGroupPharm.Items.AddObject
           (
            pDSGroupCount.FieldByName('SGroupPharmName').AsString + ' - ' + pDSGroupCount.FieldByName('NCountOrder').AsString,
            TObject(pDSGroupCount.FieldByName('NGeoGroupPharm').AsInteger)
           );
          pDSGroupCount.Next;
        end;
      except
        on e:Exception do begin
          ShowMessage('Сбой при формировании списка групп аптек.' + chr(10) + e.Message);
        end;
      end;
      pnlControl_Show.Caption := '';
    end;
    2: { Период по заказам }
    begin
      { Проверка непротиворечивости номеров заказов }
      OrderBegin := 0;
      OrderEnd   := 0;
      if    (length(trim(edOrderBegin.Text)) > 0)
        and (length(trim(edOrderEnd.Text)) > 0)
        and ufoTryStrToInt(edOrderBegin.Text)
        and ufoTryStrToInt(edOrderEnd.Text)
      then begin
        OrderBegin := StrToInt(edOrderBegin.Text);
        OrderEnd   := StrToInt(edOrderEnd.Text);
      end;
      (*if (length(trim(edOrderBegin.Text)) = 0) or (length(trim(edOrderEnd.Text)) = 0) then exit;
      if (not ufoTryStrToInt(edOrderBegin.Text)) or (not ufoTryStrToInt(edOrderEnd.Text)) then exit;
      if StrToInt(edOrderBegin.Text) > StrToInt(edOrderEnd.Text) then exit;*)
      pnlControl_Show.Caption := 'Создание списка групп аптек...';
      NSumCountOrderGroupPharm := 0;
      try
        chListBoxGroupPharm.Clear;
        if pDSGroupCount.Active then pDSGroupCount.Active := false;
        pDSGroupCount.Parameters.ParamValues['@KindCheckPeriod'] := 2;
        pDSGroupCount.Parameters.ParamValues['@SBegin'] := FormatDateTime('yyyy-mm-dd', Date);
        pDSGroupCount.Parameters.ParamValues['@SEnd']   := FormatDateTime('yyyy-mm-dd', IncDay(Date,1));
        pDSGroupCount.Parameters.ParamValues['@OrderBegin'] := OrderBegin;
        pDSGroupCount.Parameters.ParamValues['@OrderEnd'] := OrderEnd;
        pDSGroupCount.Open;
        pDSGroupCount.First;
        while not pDSGroupCount.Eof do begin
          NSumCountOrderGroupPharm := NSumCountOrderGroupPharm + pDSGroupCount.FieldByName('NCountOrder').AsInteger;
          chListBoxGroupPharm.Items.AddObject
           (
            pDSGroupCount.FieldByName('SGroupPharmName').AsString + ' - ' + pDSGroupCount.FieldByName('NCountOrder').AsString,
            TObject(pDSGroupCount.FieldByName('NGeoGroupPharm').AsInteger)
           );
          pDSGroupCount.Next;
        end;
      except
        on e:Exception do begin
          ShowMessage('Сбой при формировании списка групп аптек.' + chr(10) + e.Message);
        end;
      end;
      pnlControl_Show.Caption := '';
    end;
  end;
end;

procedure TfrmCCJS_RP_Courier.aListToll_ClearSelectGroupExecute(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to chListBoxGroupPharm.Count-1 do chListBoxGroupPharm.Checked[i] := false;
  ShowGets;
end;

procedure TfrmCCJS_RP_Courier.dtDayBeginChange(Sender: TObject);
begin
  CreateListGroupPharm;
  ShowGets;
end;

procedure TfrmCCJS_RP_Courier.dtDayEndChange(Sender: TObject);
begin
  CreateListGroupPharm;
  ShowGets;
end;

procedure TfrmCCJS_RP_Courier.chListBoxGroupPharmClickCheck(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJS_RP_Courier.cmbxCheckPeriodChange(Sender: TObject);
begin
  ShowGets;
  CreateListGroupPharm;
  ShowGets;
end;

procedure TfrmCCJS_RP_Courier.edOrderBeginChange(Sender: TObject);
begin
  if not ufoTryStrToInt(edOrderBegin.Text) then ShowMessage(sMsgOrderTypeInt) else begin
    CreateListGroupPharm;
    ShowGets;
  end;
end;

procedure TfrmCCJS_RP_Courier.edOrderEndChange(Sender: TObject);
begin
  if not ufoTryStrToInt(edOrderEnd.Text) then ShowMessage(sMsgOrderTypeInt) else begin
    CreateListGroupPharm;
    ShowGets;
  end;
end;

procedure TfrmCCJS_RP_Courier.edOrderBeginExit(Sender: TObject);
begin
  if not ufoTryStrToInt(edOrderBegin.Text) then begin
    ShowMessage(sMsgOrderTypeInt);
    edOrderBegin.SetFocus;
  end else begin
    CreateListGroupPharm;
    ShowGets;
  end;
end;

procedure TfrmCCJS_RP_Courier.edOrderEndExit(Sender: TObject);
begin
  if not ufoTryStrToInt(edOrderEnd.Text) then begin
    ShowMessage(sMsgOrderTypeInt);
    edOrderEnd.SetFocus;
  end else begin
    CreateListGroupPharm;
    ShowGets;
  end;
end;

procedure TfrmCCJS_RP_Courier.dtDateBeginChange(Sender: TObject);
begin
  CreateListGroupPharm;
  ShowGets;
end;

procedure TfrmCCJS_RP_Courier.dtTimeBeginChange(Sender: TObject);
begin
  CreateListGroupPharm;
  ShowGets;
end;

procedure TfrmCCJS_RP_Courier.dtDateEndChange(Sender: TObject);
begin
  CreateListGroupPharm;
  ShowGets;
end;

procedure TfrmCCJS_RP_Courier.dtTimeEndChange(Sender: TObject);
begin
  CreateListGroupPharm;
  ShowGets;
end;

end.
