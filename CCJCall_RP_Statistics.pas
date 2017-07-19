unit CCJCall_RP_Statistics;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, StdCtrls, ComCtrls, ToolWin, ExtCtrls, DB, ADODB,
  Excel97, ComObj;

type
  TfrmCCJCall_RP_Statistics = class(TForm)
    pnlControl: TPanel;
    pnlControl_Tool: TPanel;
    tlbrControl: TToolBar;
    tlbtnControl_Excel: TToolButton;
    ToolButton1: TToolButton;
    pnlControl_Show: TPanel;
    pnlParm: TPanel;
    pgParm: TPageControl;
    tabParm: TTabSheet;
    pnlPeriod: TPanel;
    pnlPeriod_Check: TPanel;
    lbl: TLabel;
    cmbxCheckPeriod: TComboBox;
    pnlPeriod_Periods: TPanel;
    pgcPeriods: TPageControl;
    tabPeriod_Day: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    dtDayBegin: TDateTimePicker;
    dtDayEnd: TDateTimePicker;
    tabPeriod_Date: TTabSheet;
    Label3: TLabel;
    Label4: TLabel;
    dtDateBegin: TDateTimePicker;
    dtTimeBegin: TDateTimePicker;
    dtTimeEnd: TDateTimePicker;
    dtDateEnd: TDateTimePicker;
    aList: TActionList;
    aExcel: TAction;
    aExit: TAction;
    spLoad: TADOStoredProc;
    spClear: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmbxCheckPeriodChange(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActive    : smallint;
    USER           : integer;
    IdUserAction   : longint;
    procedure ShowGets;
  public
    { Public declarations }
    procedure SetUSER(Parm : integer);
  end;

var
  frmCCJCall_RP_Statistics: TfrmCCJCall_RP_Statistics;

implementation

uses
  Util,
  UMain, UCCenterJournalNetZkz, ExDBGRID, DateUtils, UReference;

{$R *.dfm}

procedure TfrmCCJCall_RP_Statistics.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
  dtDayBegin.Date := Date;
  dtDayEnd.Date   := Date;
  dtDateBegin.Date := Date;
  dtTimeBegin.Time := EncodeTime(0, 0, 0, 0);
  dtDateEnd.Date := Date;
  dtTimeEnd.Time := Time;
end;

procedure TfrmCCJCall_RP_Statistics.FormActivate(Sender: TObject);
begin
  if ISignActive = 0 then begin
    { Иконка окна }
    //FCCenterJournalNetZkz.imgMain.GetIcon(294,self.Icon);
    { Приводим закладки к более красивому виду }
    tabPeriod_Day.Caption    := '';
    tabPeriod_Date.Caption   := '';
    pgcPeriods.TabHeight     := 1;
    pgcPeriods.TabPosition   := tpLeft;
    pnlPeriod.Height         := 72;
    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJCall_RP_Statistics.SetUSER(Parm : integer); begin USER := Parm; end;

procedure TfrmCCJCall_RP_Statistics.ShowGets;
  procedure ShowTabPeriod(SignDay,SignDate : boolean); begin
    tabPeriod_Day.TabVisible    := SignDay;
    tabPeriod_Date.TabVisible   := SignDate;
  end;
begin
  if ISignActive = 1 then begin
    { Выбор вида контрольного периода }
    case cmbxCheckPeriod.ItemIndex of
      0: ShowTabPeriod(true, false);
      1: ShowTabPeriod(false,true );
    end;
  end;
end;

procedure TfrmCCJCall_RP_Statistics.cmbxCheckPeriodChange(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJCall_RP_Statistics.aExcelExecute(Sender: TObject);
var
  Step           : smallint;
  BeginDate      : string;
  EndDate        : string;
  ShowBeginDate  : string;
  ShowEndDate    : string;
  IErr           : integer;
  SErr           : string;
  {***}
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
  Step := 0;
  IErr := 0;
  SErr := '';
  if cmbxCheckPeriod.ItemIndex = 0 then begin
    BeginDate     := FormatDateTime('yyyy-mm-dd', dtDayBegin.Date);
    EndDate       := FormatDateTime('yyyy-mm-dd', IncDay(dtDayEnd.Date,1));
    ShowBeginDate := FormatDateTime('dd.mm.yyyy', dtDayBegin.Date);
    ShowEndDate   := FormatDateTime('dd.mm.yyyy', dtDayEnd.Date);
  end else if cmbxCheckPeriod.ItemIndex = 1 then begin
    BeginDate     := FormatDateTime('yyyy-mm-dd', dtDateBegin.Date) + ' ' + FormatDateTime('hh:nn:ss', dtTimeBegin.Time);
    EndDate       := FormatDateTime('yyyy-mm-dd', dtDateEnd.Date) + ' ' + FormatDateTime('hh:nn:ss', dtTimeEnd.Time);
    ShowBeginDate := FormatDateTime('dd.mm.yyyy', dtDateBegin.Date) + ' ' + FormatDateTime('hh:nn:ss', dtTimeBegin.Time);
    ShowEndDate   := FormatDateTime('dd.mm.yyyy', dtDateEnd.Date) + ' ' + FormatDateTime('hh:nn:ss', dtTimeEnd.Time);
  end;
  { Генерим идентификатор процесса }
  IdUserAction := FCCenterJournalNetZkz.GetIdUserAction;
  { Загрузка данных }
  try
    FCCenterJournalNetZkz.stbarOne.SimpleText := 'Загрузка данных...';
    pnlControl_Show.Caption := 'Загрузка данных...';
    spLoad.Parameters.ParamValues['@IDENT']  := IdUserAction;
    spLoad.Parameters.ParamValues['@User']   := USER;
    spLoad.Parameters.ParamValues['@SBegin'] := BeginDate;
    spLoad.Parameters.ParamValues['@SEnd']   := EndDate;
    spLoad.ExecProc;
    IErr := spLoad.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      SErr := spLoad.Parameters.ParamValues['@SErr'];
      ShowMessage('Сбой при загрузке данных.' + chr(10) + SErr);
    end else Inc(Step);
  except
    on e:Exception do begin
      ShowMessage('Сбой при загрузке данных.' + chr(10) + e.Message);
    end;
  end;
  FCCenterJournalNetZkz.stbarOne.SimpleText := '';
  pnlControl_Show.Caption := '';
  { После успешной загрузки данных начинаем формировать статистику вызовов }
  if Step = 1 then begin
    { Инициализация }
    SFontSize := '10';
    iInteriorColor := 0;
    iExcelNumLine := 0;
    RecNumb := 0;
    try
      { Запуск табличного процессора }
      FCCenterJournalNetZkz.stbarOne.SimpleText := 'Запуск табличного процессора...';
      pnlControl_Show.Caption := 'Запуск табличного процессора...';
      vExcel := CreateOLEObject('Excel.Application');
      vDD := vExcel.Workbooks.Add;
      WS := vDD.Sheets[1];
      { Заголовок отчета }
      inc(iExcelNumLine);
      vExcel.ActiveCell[iExcelNumLine, 1].Value := 'Отдел курьерской доставки. Статистика вызовов. ' + FormatDateTime('dd.mm.yyyy hh:nn:ss', Now);
      inc(iExcelNumLine);
      vExcel.ActiveCell[iExcelNumLine, 1].Value := 'За период:  с  ' + ShowBeginDate + '  по  ' + ShowEndDate;
      inc(iExcelNumLine);

      { Показываем }
      FCCenterJournalNetZkz.stbarOne.SimpleText := 'Отчет сформирован...';
      pnlControl_Show.Caption := 'Отчет сформирован...';
      vExcel.Visible := True;
    except
      on E: Exception do begin
        if vExcel = varDispatch then vExcel.Quit;
      end;
    end;
  end;
  { Чистим таблицу времени выполнения }
  FCCenterJournalNetZkz.stbarOne.SimpleText := 'Очистка данных...';
  try
    spClear.Parameters.ParamValues['@IDENT']  := IdUserAction;
    spClear.Parameters.ParamValues['@User']   := USER;
    spClear.ExecProc;
  except
    on e:Exception do begin
      ShowMessage('Сбой при очистке данных.' + chr(10) + e.Message);
    end;
  end;
  FCCenterJournalNetZkz.stbarOne.SimpleText := '';
  pnlControl_Show.Caption := '';
end;

procedure TfrmCCJCall_RP_Statistics.aExitExecute(Sender: TObject);
begin
  self.Close;
end;

end.
