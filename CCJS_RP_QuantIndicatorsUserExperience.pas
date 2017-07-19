unit CCJS_RP_QuantIndicatorsUserExperience;

{ © PgkSoft. 26.01.2015 }
{ Отчет количественные показатели работы пользователей (quantitative indicators of user experience) }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ComCtrls, ToolWin, ExtCtrls, StdCtrls, DB, ADODB, ComObj;

type
  TfrmCCJS_RP_QuantIndicatorsUserExperience = class(TForm)
    pgcMain: TPageControl;
    aMain: TActionList;
    aMain_Exec: TAction;
    aMain_Close: TAction;
    pnlTool: TPanel;
    pnlTool_Bar: TPanel;
    pnlTool_Show: TPanel;
    tlbarMain: TToolBar;
    tlbtnMain_Exec: TToolButton;
    tlbtnMain_Close: TToolButton;
    tabParm_JSO: TTabSheet;
    stbarParm_JSO: TStatusBar;
    pnlParm: TPanel;
    grbxParm_Period: TGroupBox;
    lblCndDatePeriod_with: TLabel;
    dtCndBegin: TDateTimePicker;
    lblCndDatePeriod_toOn: TLabel;
    dtCndEnd: TDateTimePicker;
    grbxParm_Estimates: TGroupBox;
    chbxJSO_SignBell: TCheckBox;
    chbxJSO_MarkerBell: TCheckBox;
    chbxJSO_Status: TCheckBox;
    spDS_RP_CountSignBell: TADOStoredProc;
    spDS_RP_CountMarkerBellDate: TADOStoredProc;
    spDS_RP_CountActionOrderStatus: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aMain_ExecExecute(Sender: TObject);
    procedure aMain_CloseExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActive : integer;
    procedure ShowGets;
  public
    { Public declarations }
  end;

var
  frmCCJS_RP_QuantIndicatorsUserExperience: TfrmCCJS_RP_QuantIndicatorsUserExperience;

implementation

uses
  Util, Excel97,
  ExDBGRID,
  UMAIN, UCCenterJournalNetZkz;

{$R *.dfm}

procedure TfrmCCJS_RP_QuantIndicatorsUserExperience.ShowGets;
begin
  if ISignActive = 1 then begin
  end;
end;

procedure TfrmCCJS_RP_QuantIndicatorsUserExperience.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
  dtCndBegin.Date := date;
  dtCndEnd.Date   := date;
end;

procedure TfrmCCJS_RP_QuantIndicatorsUserExperience.FormActivate(Sender: TObject);
begin
  if ISignActive = 0 then begin
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(111,self.Icon);
    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJS_RP_QuantIndicatorsUserExperience.aMain_ExecExecute(Sender: TObject);
var
  vExcel              : OleVariant;
  vExcelBook          : OleVariant;
  vExcelSheetOne      : OleVariant;
  vExcelSheetTwo      : OleVariant;
  vExcelSheetThree    : OleVariant;
  iNumbRec            : integer;
  iExcelNumLine       : integer;
  iNumeration         : integer;
begin
  iExcelNumLine := 0;
  try
    stbarParm_JSO.SimpleText := 'Запуск табличного процессора...';
    vExcel := CreateOLEObject('Excel.Application');
    vExcel.Visible := False;
    vExcelBook := vExcel.Workbooks.Add;
    vExcelSheetOne   := vExcelBook.Sheets[1]; vExcelSheetOne.Name   := 'Интернет-заказы';
    vExcelSheetTwo   := vExcelBook.Sheets[2]; vExcelSheetTwo.Name   := '2';
    vExcelSheetThree := vExcelBook.Sheets[3]; vExcelSheetThree.Name := '3';
    vExcelSheetOne.Activate;
    if chbxJSO_SignBell.Checked then begin
      iNumbRec := 0;
      stbarParm_JSO.SimpleText := 'Количественных показатели по признаку звонка...';
      spDS_RP_CountSignBell.Active := false;
      spDS_RP_CountSignBell.Parameters.ParamValues['@SBegin'] := FormatDateTime('yyyy-mm-dd', dtCndBegin.Date);
      spDS_RP_CountSignBell.Parameters.ParamValues['@SEnd']   := FormatDateTime('yyyy-mm-dd', dtCndEnd.Date+1);
      spDS_RP_CountSignBell.Active := true;
      spDS_RP_CountSignBell.First;
      inc(iExcelNumLine);
      vExcel.ActiveCell[iExcelNumLine, 1] := 'Признак звонка'; SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 6, xlLeft);
      vExcel.ActiveCell[iExcelNumLine, 2] := '';               SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 6, xlRight);
      while not spDS_RP_CountSignBell.Eof do begin
        inc(iNumbRec);
        inc(iExcelNumLine);
        vExcel.ActiveCell[iExcelNumLine, 1] := spDS_RP_CountSignBell.FieldByName('SUSER').AsString;   SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlLeft);
        vExcel.ActiveCell[iExcelNumLine, 2] := spDS_RP_CountSignBell.FieldByName('ICount').AsString;  SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlRight);
        spDS_RP_CountSignBell.Next;
      end;
    end;
    if chbxJSO_MarkerBell.Checked then begin
      iNumbRec := 0;
      stbarParm_JSO.SimpleText := 'Количественные показатели по маркеру даты звонка...';
      spDS_RP_CountMarkerBellDate.Active := false;
      spDS_RP_CountMarkerBellDate.Parameters.ParamValues['@SBegin'] := FormatDateTime('yyyy-mm-dd', dtCndBegin.Date);
      spDS_RP_CountMarkerBellDate.Parameters.ParamValues['@SEnd']   := FormatDateTime('yyyy-mm-dd', dtCndEnd.Date+1);
      spDS_RP_CountMarkerBellDate.Active := true;
      spDS_RP_CountMarkerBellDate.First;
      inc(iExcelNumLine);  inc(iExcelNumLine);
      vExcel.ActiveCell[iExcelNumLine, 1] := 'Маркер даты звонка'; SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 6, xlLeft);
      vExcel.ActiveCell[iExcelNumLine, 2] := '';                   SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 6, xlRight);
      while not spDS_RP_CountMarkerBellDate.Eof do begin
        inc(iNumbRec);
        inc(iExcelNumLine);
        vExcel.ActiveCell[iExcelNumLine, 1] := spDS_RP_CountMarkerBellDate.FieldByName('SUSER').AsString;   SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlLeft);
        vExcel.ActiveCell[iExcelNumLine, 2] := spDS_RP_CountMarkerBellDate.FieldByName('ICount').AsString;  SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlRight);
        spDS_RP_CountMarkerBellDate.Next;
      end;
    end;
    if chbxJSO_Status.Checked then begin
      iNumbRec := 0;
      stbarParm_JSO.SimpleText := 'Количественные показатели по статусу заказа...';
      spDS_RP_CountActionOrderStatus.Active := false;
      spDS_RP_CountActionOrderStatus.Parameters.ParamValues['@SBegin'] := FormatDateTime('yyyy-mm-dd', dtCndBegin.Date);
      spDS_RP_CountActionOrderStatus.Parameters.ParamValues['@SEnd']   := FormatDateTime('yyyy-mm-dd', dtCndEnd.Date+1);
      spDS_RP_CountActionOrderStatus.Active := true;
      spDS_RP_CountActionOrderStatus.First;
      inc(iExcelNumLine);  inc(iExcelNumLine);
      vExcel.ActiveCell[iExcelNumLine, 1] := 'Статус заказа'; SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 6, xlLeft);
      vExcel.ActiveCell[iExcelNumLine, 2] := '';              SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 6, xlRight);
      while not spDS_RP_CountActionOrderStatus.Eof do begin
        inc(iNumbRec);
        inc(iExcelNumLine);
        vExcel.ActiveCell[iExcelNumLine, 1] := spDS_RP_CountActionOrderStatus.FieldByName('SUSER').AsString;   SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlLeft);
        vExcel.ActiveCell[iExcelNumLine, 2] := spDS_RP_CountActionOrderStatus.FieldByName('ICount').AsString;  SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlRight);
        spDS_RP_CountActionOrderStatus.Next;
      end;
    end;
    { Ширина столбцов }
    vExcelSheetOne.Columns[1].ColumnWidth := 70;
    vExcelSheetOne.Columns[2].ColumnWidth := 10;
  except
    on E: Exception do begin
      if vExcel = varDispatch then vExcel.Quit;
    end;
  end;
  vExcel.Visible := True;
  stbarParm_JSO.SimpleText := '';
end;

procedure TfrmCCJS_RP_QuantIndicatorsUserExperience.aMain_CloseExecute(Sender: TObject);
begin
  self.Close;
end;

end.
