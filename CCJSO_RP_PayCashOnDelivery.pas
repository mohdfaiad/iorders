unit CCJSO_RP_PayCashOnDelivery;

{**************************************************************
 * � PgkSoft 10.02.2016
 * ������ �������� �������.
 * �����: ���������� ������� (������ ��������� ��� ���������)
 **************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, ActnList, StdCtrls, ToolWin, DB, ADODB,
  UCCenterJournalNetZkz;

type
  TfrmCCJSO_RP_PayCashOnDelivery = class(TForm)
    pnlControl: TPanel;
    pnlControl_Tool: TPanel;
    pnlControl_Show: TPanel;
    pnlPage: TPanel;
    aList: TActionList;
    aOK: TAction;
    aExit: TAction;
    tbarControl: TToolBar;
    pnlPage_TypePeriod: TPanel;
    lblTypePeriod: TLabel;
    cmbxCheckPeriod: TComboBox;
    pnlPage_Period: TPanel;
    pnlPage_Period_Tool: TPanel;
    pnlPage_Period_Self: TPanel;
    Label8: TLabel;
    dtBeginDate: TDateTimePicker;
    dtBeginTime: TDateTimePicker;
    Label9: TLabel;
    dtEndDate: TDateTimePicker;
    dtEndTime: TDateTimePicker;
    aCheckPeriod_OnlyDate: TAction;
    aCheckPeriod_DateTime: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    tbarCheckPeriod: TToolBar;
    tbtnCheckPeriod_OnlyDate: TToolButton;
    tbtnCheckPeriod_DateTime: TToolButton;
    spReport: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aOKExecute(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aCheckPeriod_OnlyDateExecute(Sender: TObject);
    procedure aCheckPeriod_DateTimeExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActive    : integer;
    RecSession     : TUserSession;
    procedure ShowGets;
  public
    { Public declarations }
    procedure SetRecSession(Parm : TUserSession);
  end;

var
  frmCCJSO_RP_PayCashOnDelivery: TfrmCCJSO_RP_PayCashOnDelivery;

implementation

uses
  Util, ComObj, Excel97,
  UMain, ExDBGRID, DateUtils;

{$R *.dfm}

procedure TfrmCCJSO_RP_PayCashOnDelivery.FormCreate(Sender: TObject);
begin
  { ������������� }
  ISignActive := 0;
end;

procedure TfrmCCJSO_RP_PayCashOnDelivery.SetRecSession(Parm : TUserSession); begin RecSession := Parm; end;

procedure TfrmCCJSO_RP_PayCashOnDelivery.FormActivate(Sender: TObject);
begin
  if ISignActive = 0 then begin
    { ������������� }
    dtBeginDate.Date := Date;
    dtBeginTime.Time := EncodeTime(0, 0, 0, 0);
    dtEndDate.Date   := Date;
    dtEndTime.Time   := EncodeTime(0, 0, 0, 0);
    { ����� ������� }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_RP_PayCashOnDelivery.ShowGets;
begin
  if ISignActive = 1 then begin
    { ������ � ������� }
    if aCheckPeriod_OnlyDate.Checked then begin
      dtBeginTime.Enabled := false;
      dtEndTime.Enabled   := false;
    end else begin
    end;
  end;
end;

procedure TfrmCCJSO_RP_PayCashOnDelivery.aOKExecute(Sender: TObject);
var
  vExcel               : OleVariant;
  vDD                  : OleVariant;
  WS                   : OleVariant;
  Cells                : OleVariant;
  I                    : integer;
  iExcelNumLine        : integer;
  iTableNumLine        : integer;
  fl_cnt               : integer;
  num_cnt              : integer;
  iInteriorColor       : integer;
  iHorizontalAlignment : integer;
  RecNumb              : integer;
  RecCount             : integer;
  SFontSize            : string;
  SBegin               : string;
  SEnd                 : string;
begin
  SFontSize := '10';
  try
    pnlControl_Show.Caption := '������ ���������� ����������...';
    vExcel := CreateOLEObject('Excel.Application');
    vDD := vExcel.Workbooks.Add;
    WS := vDD.Sheets[1];
    { �������������� ���������� }
    WS.PageSetup.Orientation := xlLandscape;
    pnlControl_Show.Caption := '������������ ������ ������...';
    if spReport.Active then spReport.Active := false;
    spReport.Parameters.ParamValues['@TypeReportPeriod'] := cmbxCheckPeriod.ItemIndex;
    spReport.Parameters.ParamValues['@USER']             := RecSession.CurrentUser;
    if aCheckPeriod_OnlyDate.Checked then begin
      spReport.Parameters.ParamValues['@SBegin'] := FormatDateTime('yyyy/mm/dd', dtBeginDate.Date);
      spReport.Parameters.ParamValues['@SEnd']   := FormatDateTime('yyyy/mm/dd', IncDay(dtEndDate.Date,1));
      SBegin := FormatDateTime('dd-mm-yyyy', dtBeginDate.Date);
      SEnd   := FormatDateTime('dd-mm-yyyy', dtEndDate.Date);
    end else begin
      spReport.Parameters.ParamValues['@SBegin'] := FormatDateTime('yyyy/mm/dd', dtBeginDate.Date) + ' ' + FormatDateTime('hh:nn:ss', dtBeginTime.Time);
      spReport.Parameters.ParamValues['@SEnd']   := FormatDateTime('yyyy/mm/dd', dtEndDate.Date) + ' ' + FormatDateTime('hh:nn:ss', dtEndTime.Time);
      SBegin := FormatDateTime('dd-mm-yyyy', dtBeginDate.Date) + ' ' + FormatDateTime('hh:nn:ss', dtBeginTime.Time);
      SEnd   := FormatDateTime('dd-mm-yyyy', dtEndDate.Date) + ' ' + FormatDateTime('hh:nn:ss', dtEndTime.Time);
    end;
    spReport.Open;
    RecCount := spReport.RecordCount;
    iExcelNumLine := 0;
    RecNumb := 0;
    { ��������� ������ }
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := '���������� ������� (������ ��������� ��� ���������)';
    inc(iExcelNumLine);
    if cmbxCheckPeriod.ItemIndex = 0
      then vExcel.ActiveCell[iExcelNumLine, 1].Value := '�� ����������� ������'
      else vExcel.ActiveCell[iExcelNumLine, 1].Value := '�� ���� ����������� �������';
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := '� ' + SBegin + '  �� ' + SEnd;
    inc(iExcelNumLine);
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := '���� ������������: ' + FormatDateTime('dd-mm-yyyy hh:nn:ss', Now);
    inc(iExcelNumLine);
    { ��������� ������� }
    inc(iExcelNumLine);  iTableNumLine := iExcelNumLine;
    fl_cnt := spReport.FieldCount;
    for I := 1 to fl_cnt do begin
      vExcel.ActiveCell[iExcelNumLine, I].Value := spReport.Fields[I - 1].FieldName;
      SetPropExcelCell(WS, i, iExcelNumLine, 0, xlCenter);
      vExcel.Cells[iExcelNumLine, I].Font.Size := SFontSize;
    end;
    { ����� ������� }
    spReport.First;
    while not spReport.Eof do begin
      inc(RecNumb);
      pnlControl_Show.Caption := '������������ ������: '+VarToStr(RecNumb)+'/'+VarToStr(RecCount);
      inc(iExcelNumLine);
      for num_cnt := 1 to fl_cnt do begin
        if   (spReport.Fields[num_cnt - 1].FullName = '����� �������')
          or (spReport.Fields[num_cnt - 1].FullName = '�����-���')
          then vExcel.Cells[iExcelNumLine, num_cnt].NumberFormat := '@';
        if (spReport.Fields[num_cnt - 1].FullName = '�����')
          then vExcel.Cells[iExcelNumLine, num_cnt].NumberFormat := '0.00';
        vExcel.ActiveCell[iExcelNumLine, num_cnt].Value := spReport.Fields[num_cnt - 1].AsString;
        SetPropExcelCell(WS, num_cnt, iExcelNumLine, 0, xlLeft);
        vExcel.Cells[iExcelNumLine, num_cnt].Font.Size := SFontSize;
      end;
      spReport.Next;
    end;
    { ������ ������� }
    vExcel.Columns[01].ColumnWidth := 05;  { � �/� }
    vExcel.Columns[02].ColumnWidth := 08;  { ����� }
    vExcel.Columns[03].ColumnWidth := 17;  { ���� ������ }
    vExcel.Columns[04].ColumnWidth := 15;  { ��� �������� }
    vExcel.Columns[05].ColumnWidth := 18;  { ����� ������� }
    vExcel.Columns[06].ColumnWidth := 17;  { ���� ������� }
    vExcel.Columns[07].ColumnWidth := 10;  { ����� }
    vExcel.Columns[08].ColumnWidth := 18;  { �����-��� }
    vExcel.Columns[09].ColumnWidth := 20;  { ���������� }
    vExcel.Columns[10].ColumnWidth := 17;  { ���� �������� }
    vExcel.Columns[11].ColumnWidth := 15;  { ������������ ������ }
    vExcel.Columns[12].ColumnWidth := 15;  { ����������� ������ }
    { ������� ���� }
    WS.Range[CellName(01,iTableNumLine) + ':' + CellName(fl_cnt,iExcelNumLine)].WrapText:=true;
    { ���������� }
    vExcel.Visible := True;
  except
    on E: Exception do begin
      if vExcel = varDispatch then vExcel.Quit;
    end;
  end;
  pnlControl_Show.Caption := '';
end;

procedure TfrmCCJSO_RP_PayCashOnDelivery.aExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmCCJSO_RP_PayCashOnDelivery.aCheckPeriod_OnlyDateExecute(Sender: TObject);
begin
  { �������� ����� }
  dtBeginTime.Time := EncodeTime(0, 0, 0, 0);
  dtEndTime.Time   := EncodeTime(0, 0, 0, 0);
  ShowGets;
end;

procedure TfrmCCJSO_RP_PayCashOnDelivery.aCheckPeriod_DateTimeExecute(Sender: TObject);
begin
  { ������������� }
  dtEndTime.Time   := Time;
  ShowGets;
end;

end.
