unit CCJSO_SumArmor;

{ © PgkSoft. 20.02.2015 Отчет "Суммарные показатели бронирования" }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, ExtCtrls, ActnList, DB, ADODB, ComObj;

type
  TfrmCCJSO_SumArmor = class(TForm)
    pgcMain: TPageControl;
    tabParm_JSO: TTabSheet;
    stbarParm_JSO: TStatusBar;
    pnlParm: TPanel;
    grbxParm_Period: TGroupBox;
    lblCndDatePeriod_with: TLabel;
    lblCndDatePeriod_toOn: TLabel;
    dtCndBegin: TDateTimePicker;
    dtCndEnd: TDateTimePicker;
    pnlTool: TPanel;
    pnlTool_Bar: TPanel;
    tlbarMain: TToolBar;
    tlbtnMain_Exec: TToolButton;
    tlbtnMain_Close: TToolButton;
    pnlTool_Show: TPanel;
    aMain: TActionList;
    aMain_Exec: TAction;
    aMain_Close: TAction;
    spdsSumArmor: TADOStoredProc;
    spdsPlan: TADOStoredProc;
    aMainGrupsPharmacy: TAction;
    tlbtnMain_GrupsPharmacy: TToolButton;
    spdsFactHand: TADOStoredProc;
    spdsPlanExt: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aMain_ExecExecute(Sender: TObject);
    procedure aMain_CloseExecute(Sender: TObject);
    procedure aMainGrupsPharmacyExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActive : integer;
    procedure ShowGets;
  public
    { Public declarations }
  end;

var
  frmCCJSO_SumArmor: TfrmCCJSO_SumArmor;

implementation

uses
  Util, Excel97,
  ExDBGRID,
  UMAIN, UCCenterJournalNetZkz;

{$R *.dfm}

procedure TfrmCCJSO_SumArmor.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
  dtCndBegin.Date := date;
  dtCndEnd.Date   := date;
end;

procedure TfrmCCJSO_SumArmor.FormActivate(Sender: TObject);
begin
  if ISignActive = 0 then begin
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(111,self.Icon);
    ISignActive := 1;
  end;
end;

procedure TfrmCCJSO_SumArmor.ShowGets;
begin
  if ISignActive = 1 then begin
  end;
end;

procedure TfrmCCJSO_SumArmor.aMain_ExecExecute(Sender: TObject);
var
  vExcel              : OleVariant;
  vExcelBook          : OleVariant;
  vExcelSheetOne      : OleVariant;
  vExcelSheetTwo      : OleVariant;
  vExcelSheetThree    : OleVariant;
  iNumbRec            : integer;
  iExcelNumLine       : integer;
  iNumeration         : integer;
  { Группы }
  GroupShipping       : string;    { Вид доставки }
  OldGroupShipping    : string;
  StateArmour         : smallint;  { Подгруппа - Состояние брони }
  OldStateArmour      : smallint;
  OldNameStateArmour  : string;
  SignClosed          : smallint;  { Подгруппа - Признак закрытия заказа }
  OldSignClosed       : smallint;
  NSum                : real;
  { Расчетные количественные и суммарные показатели }
  CountStateArmorPlan : integer;   { ПЛАН по состоянию брони }
  SumStateArmorPlan   : real;
  CountPlan           : integer;   { Всего ПЛАН по виду доставки }
  SumPlan             : real;
  CountAllPlan        : integer;   { Итого ПЛАН по всему набору данных }
  SumAllPlan          : real;
  CountFactClear      : integer;
  SumFactClear        : real;
  CountFactSold       : integer;
  SumFactSold         : real;
  CountFactActive     : integer;
  SumFactActive       : real;
  CountShippingFact   : integer;   { Всего ФАКТ по виду доставки }
  SumShippingFact     : real;
  CountAllFact        : integer;   { Итого ФАКТ по всему набору данных }
  SumAllFact          : real;
  CountAllFactSold    : integer;   { Итого ФАКТ-продано по всему набору данных }
  SumAllFactsold      : real;

  { Итоги по состоянию брони }
  procedure ResultsByStateArmor; begin
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := OldNameStateArmour;  SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlRight);
    vExcel.ActiveCell[iExcelNumLine, 2] := CountStateArmorPlan; SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := SumStateArmorPlan;   SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlRight);
    if OldStateArmour = 0 then begin
                                                                SetPropExcelCell(vExcelSheetOne, 4, iExcelNumLine, 0, xlCenter);
                                                                SetPropExcelCell(vExcelSheetOne, 5, iExcelNumLine, 0, xlCenter);
                                                                SetPropExcelCell(vExcelSheetOne, 6, iExcelNumLine, 0, xlCenter);
    end else begin
      { Продано }
      vExcel.ActiveCell[iExcelNumLine, 4] := 'Продано';       SetPropExcelCell(vExcelSheetOne, 4, iExcelNumLine, 0, xlRight);
      vExcel.ActiveCell[iExcelNumLine, 5] := CountFactSold;   SetPropExcelCell(vExcelSheetOne, 5, iExcelNumLine, 0, xlCenter);
      vExcel.ActiveCell[iExcelNumLine, 6] := SumFactSold;     SetPropExcelCell(vExcelSheetOne, 6, iExcelNumLine, 0, xlRight);
      { Активно  }
      inc(iExcelNumLine);
                                                              SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlRight);
                                                              SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
                                                              SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlRight);
      vExcel.ActiveCell[iExcelNumLine, 4] := 'Активно';       SetPropExcelCell(vExcelSheetOne, 4, iExcelNumLine, 0, xlRight);
      vExcel.ActiveCell[iExcelNumLine, 5] := CountFactActive; SetPropExcelCell(vExcelSheetOne, 5, iExcelNumLine, 0, xlCenter);
      vExcel.ActiveCell[iExcelNumLine, 6] := SumFactActive;   SetPropExcelCell(vExcelSheetOne, 6, iExcelNumLine, 0, xlRight);
      { Отменено }
      inc(iExcelNumLine);
                                                              SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlRight);
                                                              SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
                                                              SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlRight);
      vExcel.ActiveCell[iExcelNumLine, 4] := 'Отменено';      SetPropExcelCell(vExcelSheetOne, 4, iExcelNumLine, 0, xlRight);
      vExcel.ActiveCell[iExcelNumLine, 5] := CountFactClear;  SetPropExcelCell(vExcelSheetOne, 5, iExcelNumLine, 0, xlCenter);
      vExcel.ActiveCell[iExcelNumLine, 6] := SumFactclear;    SetPropExcelCell(vExcelSheetOne, 6, iExcelNumLine, 0, xlRight);
    end;
    { Инициализация ПЛАНа для следующей подгруппы }
    CountStateArmorPlan := 0;
    SumStateArmorPlan   := 0;
    { Инициализация ФАКТа для следующей подгруппы }
    CountFactClear      := 0;    { Отмененные заказы }
    SumFactClear        := 0;
    CountFactSold       := 0;    { Проданные заказы }
    SumFactSold         := 0;
    CountFactActive     := 0;    { Активные заказы }
    SumFactActive       := 0;
  end;
  { Итоги по виду доставки }
  procedure ResultsByShipping; begin
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := 'Всего';             SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 2] := CountPlan;           SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := SumPlan;             SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlRight);
    vExcel.ActiveCell[iExcelNumLine, 4] := 'Продано + активно'; SetPropExcelCell(vExcelSheetOne, 4, iExcelNumLine, 0, xlRight);
    vExcel.ActiveCell[iExcelNumLine, 5] := CountShippingFact;   SetPropExcelCell(vExcelSheetOne, 5, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 6] := SumShippingFact;     SetPropExcelCell(vExcelSheetOne, 6, iExcelNumLine, 0, xlRight);
    { Инициализация плановых показателей по группе видов доставки }
    CountPlan := 0;
    SumPlan := 0;
    { Инициализация плановых показателей по группе видов доставки }
    CountShippingFact := 0;
    SumShippingFact   := 0;
  end;

begin
  { Инициализация }
  iExcelNumLine       := 0;
  { Группы }
  GroupShipping       := '';   { Вид доставки }
  OldGroupShipping    := '';
  StateArmour         := -1;   { Состояние брони }
  OldStateArmour      := -1;
  SignClosed          := -1;   { Признак активности брони }
  OldSignClosed       := -1;
  { Количественные и сумарные показатели }
  CountStateArmorPlan := 0;
  SumStateArmorPlan   := 0;
  CountPlan           := 0;
  SumPlan             := 0;
  CountAllPlan        := 0;
  SumAllPlan          := 0;
  CountFactClear      := 0;    { Отмененные заказы }
  SumFactClear        := 0;
  CountFactSold       := 0;    { Проданные заказы }
  SumFactSold         := 0;
  CountFactActive     := 0;    { Активные заказы }
  SumFactActive       := 0;
  CountShippingFact   := 0;    { Всего ФАКТ по виду доставки }
  SumShippingFact     := 0;
  CountAllFact        := 0;    { Итого ФАКТ по всему набору данных }
  SumAllFact          := 0;
  CountAllFactSold    := 0;    { Итого ФАКТ-продано по всему набору данных }
  SumAllFactsold      := 0;
  try
    stbarParm_JSO.SimpleText := 'Запуск табличного процессора...';
    vExcel := CreateOLEObject('Excel.Application');
    vExcel.Visible := False;
    vExcelBook := vExcel.Workbooks.Add;
    vExcelSheetOne   := vExcelBook.Sheets[1]; vExcelSheetOne.Name   := 'Аптека в заголовке заказа';
//    vExcelSheetTwo   := vExcelBook.Sheets[2]; vExcelSheetTwo.Name   := '2';
//    vExcelSheetThree := vExcelBook.Sheets[3]; vExcelSheetThree.Name := '3';
    vExcelSheetOne.Activate;

    { Заголовок }
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := 'За период';                                           SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlRight);
    vExcel.ActiveCell[iExcelNumLine, 2] := 'с ' + FormatDateTime('dd-mm-yyyy', dtCndBegin.Date);  SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := 'по ' + FormatDateTime('dd-mm-yyyy', dtCndEnd.Date);   SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 4] := FormatDateTime('dd-mm-yyyy hh:nn:ss', Now);            SetPropExcelCell(vExcelSheetOne, 4, iExcelNumLine, 0, xlRight);

    { Формировани отчета по Плановым показателям в разрезе видов доставки весь период }
    {*********************************************************************************}
    inc(iExcelNumLine);  inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := 'Корзина ИТОГО';   SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 6, xlCenter);
    inc(iExcelNumLine);
    stbarParm_JSO.SimpleText := 'Формирование набора данных (плановые показатели)...';
    iNumbRec := 0;
    spdsPlan.Active := false;
    spdsPlan.Parameters.ParamValues['@SBegin']            := FormatDateTime('yyyy-mm-dd', dtCndBegin.Date);
    spdsPlan.Parameters.ParamValues['@SEnd']              := FormatDateTime('yyyy-mm-dd', dtCndEnd.Date+1);
    spdsPlan.Parameters.ParamValues['@SignGruopPharmacy'] := 0;
    spdsPlan.Parameters.ParamValues['@SignPharmacy']      := 0;
    spdsPlan.Active := true;
    spdsPlan.First;
                                                            SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 2] := 'Кол-во';        SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := 'Сумма';         SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlCenter);
    CountAllPlan := 0;
    SumAllPlan   := 0;
    while not spdsPlan.Eof do begin
      inc(iNumbRec);
      inc(iExcelNumLine);
      CountAllPlan := CountAllPlan + spdsPlan.FieldByName('NCountOrderShipping').AsInteger;
      SumAllPlan   := SumAllPlan + spdsPlan.FieldByName('NSumOrderShipping').AsFloat;
      stbarParm_JSO.SimpleText := IntToStr(iNumbRec)+'/'+IntToStr(spdsPlan.RecordCount);
      vExcel.ActiveCell[iExcelNumLine, 1] := spdsPlan.FieldByName('SOrderShipping').AsString;
        SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlRight);
      vExcel.ActiveCell[iExcelNumLine, 2] := spdsPlan.FieldByName('NCountOrderShipping').AsInteger;
        SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
      vExcel.ActiveCell[iExcelNumLine, 3] := spdsPlan.FieldByName('NSumOrderShipping').AsFloat;
        SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlRight);
      spdsPlan.Next;
    end; // while not spdsPlan.Eof do begin
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := 'ИТОГО';      SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 35, xlRight);
    vExcel.ActiveCell[iExcelNumLine, 2] := CountAllPlan; SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 35, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := SumAllPlan;   SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 35, xlRight);

    { Формировани отчета по Плановым показателям в разрезе видов доставки с дополнительными показателями за весь период }
    {*******************************************************************************************************************}
    { Инициализация }
    { Группы }
    GroupShipping       := '';   { Вид доставки }
    OldGroupShipping    := '';
    StateArmour         := -1;   { Состояние брони }
    OldStateArmour      := -1;
    SignClosed          := -1;   { Признак активности брони }
    OldSignClosed       := -1;
    { Количественные и сумарные показатели }
    CountStateArmorPlan := 0;
    SumStateArmorPlan   := 0;
    CountPlan           := 0;
    SumPlan             := 0;
    CountAllPlan        := 0;
    SumAllPlan          := 0;
    CountFactClear      := 0;    { Отмененные заказы }
    SumFactClear        := 0;
    CountFactSold       := 0;    { Проданные заказы }
    SumFactSold         := 0;
    CountFactActive     := 0;    { Активные заказы }
    SumFactActive       := 0;
    CountShippingFact   := 0;    { Всего ФАКТ по виду доставки }
    SumShippingFact     := 0;
    CountAllFact        := 0;    { Итого ФАКТ по всему набору данных }
    SumAllFact          := 0;
    CountAllFactSold    := 0;    { Итого ФАКТ-продано по всему набору данных }
    SumAllFactsold      := 0;
    iNumbRec := 0;
    inc(iExcelNumLine);
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := 'КОРЗИНА';    SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 6, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 2] := 'Количество'; SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := 'Сумма';      SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlRight);
    stbarParm_JSO.SimpleText := 'Формирование набора данных (плановые показатели)...';
    spdsPlanExt.Active := false;
    spdsPlanExt.Parameters.ParamValues['@SBegin']            := FormatDateTime('yyyy-mm-dd', dtCndBegin.Date);
    spdsPlanExt.Parameters.ParamValues['@SEnd']              := FormatDateTime('yyyy-mm-dd', dtCndEnd.Date+1);
    spdsPlanExt.Parameters.ParamValues['@SignGruopPharmacy'] := 0;
    spdsPlanExt.Active := true;
    spdsPlanExt.First;
    while not spdsPlanExt.Eof do begin
      inc(iNumbRec);
      inc(CountAllPlan);
      SumAllPlan   := SumAllPlan + spdsPlanExt.FieldByName('NSumNetOrder').AsFloat;
      stbarParm_JSO.SimpleText := IntToStr(iNumbRec)+'/'+IntToStr(spdsPlanExt.RecordCount);
      { Вид доставки }
      GroupShipping := spdsPlanExt.FieldByName('SOrderShipping').AsString;
      { Курьерская доставка }
      if spdsPlanExt.FieldByName('ISortSequence').AsInteger = 1 then begin
        GroupShipping := GroupShipping + ' (' + spdsPlanExt.FieldByName('SSignCourier').AsString + ')';
      end;
      { Самовывоз }
      if spdsPlanExt.FieldByName('ISortSequence').AsInteger = 2 then begin
        { Без аптеки в заголовке заказа - срочный заказ }
        if spdsPlanExt.FieldByName('NPharmacy').AsInteger = (-1) then begin
          GroupShipping := GroupShipping + ' (срочный заказ)';
        end else begin
          case spdsPlanExt.FieldByName('IMergeStateArmour').AsInteger of
            0: GroupShipping := GroupShipping + ' (аптеки где нету)';
            1: GroupShipping := GroupShipping + ' (аптеки где есть)';
            2: GroupShipping := GroupShipping + ' (аптеки где частично нету)';
          else GroupShipping := GroupShipping + ' (аптеки где нету)';
          end;
        end;
      end;
      { Бронь в аптеке }
      if spdsPlanExt.FieldByName('ISortSequence').AsInteger = 3 then begin
        case spdsPlanExt.FieldByName('IMergeStateArmour').AsInteger of
          0: GroupShipping := GroupShipping + ' (аптеки где нету)';
          1: GroupShipping := GroupShipping + ' (аптеки где есть)';
          2: GroupShipping := GroupShipping + ' (аптеки где частично нету)';
        else GroupShipping := GroupShipping + ' (аптеки где нету)';
        end;
      end;
      { Заказ в один клик }
      if spdsPlanExt.FieldByName('ISortSequence').AsInteger = 4 then begin
      end;
      { Новая группа по виду доставки }
      if GroupShipping <> OldGroupShipping then begin
        { Не начальное обращение }
        if length(OldGroupShipping) <> 0 then begin
          { Итоги по виду доставки }
          inc(iExcelNumLine);
          vExcel.ActiveCell[iExcelNumLine, 1] := OldGroupShipping;  SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlLeft);
          vExcel.ActiveCell[iExcelNumLine, 2] := CountPlan;         SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
          vExcel.ActiveCell[iExcelNumLine, 3] := SumPlan;           SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlRight);
          { Инициализация для следующего вида доставки }
          CountPlan := 0;
          SumPlan   := 0;
        end;
        { Фиксируем новую группу по виду доставки }
        OldGroupShipping := GroupShipping;
      end;
      { Подсчет показателей для текущего вида доставки }
      inc(CountPlan);
      SumPlan := SumPlan + spdsPlanExt.FieldByName('NSumNetOrder').AsFloat;
      spdsPlanExt.Next;
    end; // while not spdsPlanExt.Eof do begin
    { Итоги по виду доставки }
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := GroupShipping;   SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlLeft);
    vExcel.ActiveCell[iExcelNumLine, 2] := CountPlan;       SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := SumPlan;         SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlRight);
    { Общие итоги }
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := 'ИТОГО';      SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 35, xlRight);
    vExcel.ActiveCell[iExcelNumLine, 2] := CountAllPlan; SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 35, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := SumAllPlan;   SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 35, xlRight);

    { Формировани отчета по Плановым и фактическим показателям (аптека в заголовке заказа) }
    {**************************************************************************************}
    { Инициализация }
    { Группы }
    GroupShipping       := '';   { Вид доставки }
    OldGroupShipping    := '';
    StateArmour         := -1;   { Состояние брони }
    OldStateArmour      := -1;
    SignClosed          := -1;   { Признак активности брони }
    OldSignClosed       := -1;
    { Количественные и сумарные показатели }
    CountStateArmorPlan := 0;
    SumStateArmorPlan   := 0;
    CountPlan           := 0;
    SumPlan             := 0;
    CountAllPlan        := 0;
    SumAllPlan          := 0;
    CountFactClear      := 0;    { Отмененные заказы }
    SumFactClear        := 0;
    CountFactSold       := 0;    { Проданные заказы }
    SumFactSold         := 0;
    CountFactActive     := 0;    { Активные заказы }
    SumFactActive       := 0;
    CountShippingFact   := 0;    { Всего ФАКТ по виду доставки }
    SumShippingFact     := 0;
    CountAllFact        := 0;    { Итого ФАКТ по всему набору данных }
    SumAllFact          := 0;
    CountAllFactSold    := 0;    { Итого ФАКТ-продано по всему набору данных }
    SumAllFactsold      := 0;
    stbarParm_JSO.SimpleText := 'Формирование набора данных (аптека в заголовке заказа)...';
    iNumbRec := 0;
    spdsSumArmor.Active := false;
    spdsSumArmor.Parameters.ParamValues['@SBegin']            := FormatDateTime('yyyy-mm-dd', dtCndBegin.Date);
    spdsSumArmor.Parameters.ParamValues['@SEnd']              := FormatDateTime('yyyy-mm-dd', dtCndEnd.Date+1);
    spdsSumArmor.Parameters.ParamValues['@SignGruopPharmacy'] := 0;
    spdsSumArmor.Active := true;
    spdsSumArmor.First;
    inc(iExcelNumLine);  inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := 'Автоматическое бронирование';
        SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 6, xlLeft);
        SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 6, xlLeft);
        SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 6, xlLeft);
    while not spdsSumArmor.Eof do begin
      { Итоговые плановые показатели по всему набору данных }
      inc(CountAllPlan);
      SumAllPlan := SumAllPlan + spdsSumArmor.FieldByName('NSumNetOrder').AsFloat;
      { Вид доставки }
      GroupShipping := spdsSumArmor.FieldByName('SOrderShipping').AsString;
      inc(iNumbRec);
      stbarParm_JSO.SimpleText := IntToStr(iNumbRec)+'/'+IntToStr(spdsSumArmor.RecordCount);
      { Новая группа по виду доставки }
      if GroupShipping <> OldGroupShipping then begin
        { Не начальное обращение }
        if length(OldGroupShipping) <> 0 then begin
          { Итоги по состоянию брони }
          ResultsByStateArmor;
          { Итоги по виду доставки }
          ResultsByShipping;
          { Инициализируем стартовые значения для следующего обхода подгрупп по сотоянию брони в группе по виду досатвки}
          StateArmour    := -1;   { Состояние брони }
          OldStateArmour := -1;
        end;
        { Заголовок по видам доставки }
        inc(iExcelNumLine);
        vExcel.ActiveCell[iExcelNumLine, 1] := GroupShipping;   SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 19, xlCenter);
        vExcel.ActiveCell[iExcelNumLine, 2] := 'План';          SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 15, xlCenter);
                                                                SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 15, xlCenter);
        vExcel.ActiveCell[iExcelNumLine, 4] := 'Факт';          SetPropExcelCell(vExcelSheetOne, 4, iExcelNumLine, 8, xlCenter);
                                                                SetPropExcelCell(vExcelSheetOne, 5, iExcelNumLine, 8, xlCenter);
                                                                SetPropExcelCell(vExcelSheetOne, 6, iExcelNumLine, 8, xlCenter);
        inc(iExcelNumLine);
                                                                SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlCenter);
        vExcel.ActiveCell[iExcelNumLine, 2] := 'Кол-во';        SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
        vExcel.ActiveCell[iExcelNumLine, 3] := 'Сумма';         SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlCenter);
                                                                SetPropExcelCell(vExcelSheetOne, 4, iExcelNumLine, 0, xlCenter);
        vExcel.ActiveCell[iExcelNumLine, 5] := 'Кол-во';        SetPropExcelCell(vExcelSheetOne, 5, iExcelNumLine, 0, xlCenter);
        vExcel.ActiveCell[iExcelNumLine, 6] := 'Сумма';         SetPropExcelCell(vExcelSheetOne, 6, iExcelNumLine, 0, xlCenter);
        { Фиксируем новую группу по виду доставки }
        OldGroupShipping := GroupShipping;
      end; // Новая группа по виду доставки
      { Плановые показатели по группе вид доставки }
      inc(CountPlan);
      SumPlan := SumPlan + spdsSumArmor.FieldByName('NSumNetOrder').AsFloat;
      { Состояние брони }
      StateArmour := spdsSumArmor.FieldByName('IMergeStateArmour').AsInteger;
      { Новая подгруппа по состоянию брони }
      if StateArmour <> OldStateArmour then begin
        { Не начальное обращение }
        if OldStateArmour <> (-1) then begin
          { Итоги по состоянию брони }
          ResultsByStateArmor;
        end;
        OldStateArmour     := StateArmour;
        OldNameStateArmour := spdsSumArmor.FieldByName('SMergeStateArmour').AsString;
      end;
      { Подгруппа состояние брони: количественные и суммарные показатели }
      inc(CountStateArmorPlan);
      SumStateArmorPlan := SumStateArmorPlan + spdsSumArmor.FieldByName('NSumNetOrder').AsFloat;
      { Фактические показатели по подруппам признак закрытия заказа }
      case spdsSumArmor.FieldByName('IClosed').AsInteger of
        { Не забронировано }
       -1: begin
           end;
        { Активный }
        0: begin
             inc(CountFactActive);
             SumFactActive := SumFactActive + spdsSumArmor.FieldByName('NSumNetOrder').AsFloat;
             inc(CountShippingFact);
             SumShippingFact := SumShippingFact + spdsSumArmor.FieldByName('NSumNetOrder').AsFloat;
             inc(CountAllFact);
             SumAllFact := SumAllFact + spdsSumArmor.FieldByName('NSumNetOrder').AsFloat;
           end;
        { Отмененный }
        1: begin
             inc(CountFactClear);
             SumFactClear := SumFactClear + spdsSumArmor.FieldByName('NSumNetOrder').AsFloat;
           end;
        { Проданный }
        2: begin
             if spdsSumArmor.FieldByName('NSumCheck').AsFloat <> 0
               then NSum := spdsSumArmor.FieldByName('NSumCheck').AsFloat
               else NSum := spdsSumArmor.FieldByName('NSumNetOrder').AsFloat;
             inc(CountFactSold);     SumFactSold     := SumFactSold + NSum;
             inc(CountShippingFact); SumShippingFact := SumShippingFact + NSum;
             inc(CountAllFact);      SumAllFact      := SumAllFact + NSum;
             inc(CountAllFactSold);  SumAllFactSold  := SumAllFactSold + NSum;
           end;
      else begin end;
      end;
      { Сдедующая запись набора данных }
      spdsSumArmor.Next;
    end; // while not spdsSumArmor.Eof do begin
    { Итоги по состоянию брони }
    ResultsByStateArmor;
    { Итоги по виду доставки }
    ResultsByShipping;
    { Итоги по всему набору данных }
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := 'ИТОГО';             SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 35, xlRight);
    vExcel.ActiveCell[iExcelNumLine, 2] := CountAllPlan;        SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 35, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := SumAllPlan;          SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 35, xlRight);
    vExcel.ActiveCell[iExcelNumLine, 4] := 'Продано + активно'; SetPropExcelCell(vExcelSheetOne, 4, iExcelNumLine, 35, xlRight);
    vExcel.ActiveCell[iExcelNumLine, 5] := CountAllFact;        SetPropExcelCell(vExcelSheetOne, 5, iExcelNumLine, 35, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 6] := SumAllFact;          SetPropExcelCell(vExcelSheetOne, 6, iExcelNumLine, 35, xlRight);
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 4] := 'Продано';        SetPropExcelCell(vExcelSheetOne, 4, iExcelNumLine, 4, xlRight);
    vExcel.ActiveCell[iExcelNumLine, 5] := CountAllFactSold; SetPropExcelCell(vExcelSheetOne, 5, iExcelNumLine, 4, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 6] := SumAllFactSold;   SetPropExcelCell(vExcelSheetOne, 6, iExcelNumLine, 4, xlRight);
    { Ширина столбцов }
    vExcelSheetOne.Columns[1].ColumnWidth := 35;
    vExcelSheetOne.Columns[2].ColumnWidth := 15;
    vExcelSheetOne.Columns[3].ColumnWidth := 15;
    vExcelSheetOne.Columns[4].ColumnWidth := 20;
    vExcelSheetOne.Columns[5].ColumnWidth := 15;
    vExcelSheetOne.Columns[6].ColumnWidth := 15;

    { Формировани отчета по Плановым показателям - аптеки нет в заголовке заказа }
    {****************************************************************************}
    inc(iExcelNumLine);
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := 'Заказы для ручного бронирования (ПЛАН)';   SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 6, xlLeft);
    inc(iExcelNumLine);
    stbarParm_JSO.SimpleText := 'Формирование набора данных (без аптеки в заголовке заказа - плановые показатели)...';
    iNumbRec := 0;
    spdsPlan.Active := false;
    spdsPlan.Parameters.ParamValues['@SBegin']            := FormatDateTime('yyyy-mm-dd', dtCndBegin.Date);
    spdsPlan.Parameters.ParamValues['@SEnd']              := FormatDateTime('yyyy-mm-dd', dtCndEnd.Date+1);
    spdsPlan.Parameters.ParamValues['@SignGruopPharmacy'] := 0;
    spdsPlan.Parameters.ParamValues['@SignPharmacy']      := 2;
    spdsPlan.Active := true;
    spdsPlan.First;
                                                            SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 2] := 'Кол-во';        SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := 'Сумма';         SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlCenter);
    while not spdsPlan.Eof do begin
      inc(iNumbRec);
      inc(iExcelNumLine);
      stbarParm_JSO.SimpleText := IntToStr(iNumbRec)+'/'+IntToStr(spdsPlan.RecordCount);
      vExcel.ActiveCell[iExcelNumLine, 1] := spdsPlan.FieldByName('SOrderShipping').AsString;
        SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlRight);
      vExcel.ActiveCell[iExcelNumLine, 2] := spdsPlan.FieldByName('NCountOrderShipping').AsInteger;
        SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
      vExcel.ActiveCell[iExcelNumLine, 3] := spdsPlan.FieldByName('NSumOrderShipping').AsFloat;
        SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlRight);
      spdsPlan.Next;
    end; // while not spdsPlan.Eof do begin

    { Формировани отчета по ФАКТу - ручное бронирование (без аптеки в заголовке заказа) }
    {***********************************************************************************}
    { Инициализация }
    { Группы }
    GroupShipping       := '';   { Вид доставки }
    OldGroupShipping    := '';
    StateArmour         := -1;   { Состояние брони }
    OldStateArmour      := -1;
    SignClosed          := -1;   { Признак активности брони }
    OldSignClosed       := -1;
    { Количественные и сумарные показатели }
    CountStateArmorPlan := 0;
    SumStateArmorPlan   := 0;
    CountPlan           := 0;
    SumPlan             := 0;
    CountAllPlan        := 0;
    SumAllPlan          := 0;
    CountFactClear      := 0;    { Отмененные заказы }
    SumFactClear        := 0;
    CountFactSold       := 0;    { Проданные заказы }
    SumFactSold         := 0;
    CountFactActive     := 0;    { Активные заказы }
    SumFactActive       := 0;
    CountShippingFact   := 0;    { Всего ФАКТ по виду доставки }
    SumShippingFact     := 0;
    CountAllFact        := 0;    { Итого ФАКТ по всему набору данных }
    SumAllFact          := 0;
    CountAllFactSold    := 0;    { Итого ФАКТ-продано по всему набору данных }
    SumAllFactsold      := 0;
    { Поехали }
    inc(iExcelNumLine);
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := 'Ручное бронирование (ФАКТ)';   SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 6, xlLeft);
    inc(iExcelNumLine);
                                                      SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlLeft);
    vExcel.ActiveCell[iExcelNumLine, 2] := 'Кол-во';  SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := 'Сумма';   SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlCenter);
    stbarParm_JSO.SimpleText := 'Формирование набора данных (факт - ручное бронировние)...';
    iNumbRec := 0;
    spdsFactHand.Active := false;
    spdsFactHand.Parameters.ParamValues['@SBegin']            := FormatDateTime('yyyy-mm-dd', dtCndBegin.Date);
    spdsFactHand.Parameters.ParamValues['@SEnd']              := FormatDateTime('yyyy-mm-dd', dtCndEnd.Date+1);
    spdsFactHand.Parameters.ParamValues['@SignGruopPharmacy'] := 0;
    spdsFactHand.Active := true;
    spdsFactHand.First;
    while not spdsFactHand.Eof do begin
      inc(iNumbRec);
      stbarParm_JSO.SimpleText := IntToStr(iNumbRec)+'/'+IntToStr(spdsFactHand.RecordCount);
      { Вид доставки }
      GroupShipping := spdsFactHand.FieldByName('STypeZakaz').AsString;
      case spdsFactHand.FieldByName('IClosed').AsInteger of
        0: begin
             GroupShipping := GroupShipping + ' (активно)';
             SumPlan := SumPlan + spdsFactHand.FieldByName('NSumOrder').AsFloat;
           end;
        1: begin
             GroupShipping := GroupShipping + ' (отменено)';
             SumPlan := SumPlan + spdsFactHand.FieldByName('NSumOrder').AsFloat;
           end;
        2: begin
             GroupShipping := GroupShipping + ' (продано)';
             inc(CountAllPlan);
             if spdsFactHand.FieldByName('NSumCheck').AsFloat <> 0 then begin
               SumPlan := SumPlan + spdsFactHand.FieldByName('NSumCheck').AsFloat;
               SumAllPlan := SumAllPlan + spdsFactHand.FieldByName('NSumCheck').AsFloat;
             end else begin
               SumPlan := SumPlan + spdsFactHand.FieldByName('NSumOrder').AsFloat;
               SumAllPlan := SumAllPlan + spdsFactHand.FieldByName('NSumOrder').AsFloat;
             end;
           end;
      else begin
             GroupShipping := GroupShipping + ' (активно)';
             SumPlan := SumPlan + spdsFactHand.FieldByName('NSumOrder').AsFloat;
           end;
      end;
      { Новая группа по виду доставки }
      if GroupShipping <> OldGroupShipping then begin
        { Не начальное обращение }
        if length(OldGroupShipping) <> 0 then begin
          { Итоги по виду доставки }
          inc(iExcelNumLine);
          vExcel.ActiveCell[iExcelNumLine, 1] := OldGroupShipping;  SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlLeft);
          vExcel.ActiveCell[iExcelNumLine, 2] := CountPlan;         SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
          vExcel.ActiveCell[iExcelNumLine, 3] := SumPlan;           SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlRight);
          { Инициализация для следующего вида доставки }
          CountPlan := 0;
          SumPlan   := 0;
        end;
        { Фиксируем новую группу по виду доставки }
        OldGroupShipping := GroupShipping;
      end;
      inc(CountPlan);
      spdsFactHand.Next;
    end; // while not spdsFactHand.Eof do begin
    { Итоги по виду доставки }
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := GroupShipping;  SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlLeft);
    vExcel.ActiveCell[iExcelNumLine, 2] := CountPlan;      SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := SumPlan;        SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlRight);
    { Итоги продано }
    inc(iExcelNumLine);
  except
    on E: Exception do begin
      if vExcel = varDispatch then vExcel.Quit;
    end;
  end;
  vExcel.Visible := True;
  stbarParm_JSO.SimpleText := '';
end;

procedure TfrmCCJSO_SumArmor.aMain_CloseExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJSO_SumArmor.aMainGrupsPharmacyExecute(Sender: TObject);
begin
  //
end;

end.
