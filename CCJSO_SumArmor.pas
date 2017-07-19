unit CCJSO_SumArmor;

{ � PgkSoft. 20.02.2015 ����� "��������� ���������� ������������" }

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
  { ������������� }
  ISignActive := 0;
  dtCndBegin.Date := date;
  dtCndEnd.Date   := date;
end;

procedure TfrmCCJSO_SumArmor.FormActivate(Sender: TObject);
begin
  if ISignActive = 0 then begin
    { ������ ����� }
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
  { ������ }
  GroupShipping       : string;    { ��� �������� }
  OldGroupShipping    : string;
  StateArmour         : smallint;  { ��������� - ��������� ����� }
  OldStateArmour      : smallint;
  OldNameStateArmour  : string;
  SignClosed          : smallint;  { ��������� - ������� �������� ������ }
  OldSignClosed       : smallint;
  NSum                : real;
  { ��������� �������������� � ��������� ���������� }
  CountStateArmorPlan : integer;   { ���� �� ��������� ����� }
  SumStateArmorPlan   : real;
  CountPlan           : integer;   { ����� ���� �� ���� �������� }
  SumPlan             : real;
  CountAllPlan        : integer;   { ����� ���� �� ����� ������ ������ }
  SumAllPlan          : real;
  CountFactClear      : integer;
  SumFactClear        : real;
  CountFactSold       : integer;
  SumFactSold         : real;
  CountFactActive     : integer;
  SumFactActive       : real;
  CountShippingFact   : integer;   { ����� ���� �� ���� �������� }
  SumShippingFact     : real;
  CountAllFact        : integer;   { ����� ���� �� ����� ������ ������ }
  SumAllFact          : real;
  CountAllFactSold    : integer;   { ����� ����-������� �� ����� ������ ������ }
  SumAllFactsold      : real;

  { ����� �� ��������� ����� }
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
      { ������� }
      vExcel.ActiveCell[iExcelNumLine, 4] := '�������';       SetPropExcelCell(vExcelSheetOne, 4, iExcelNumLine, 0, xlRight);
      vExcel.ActiveCell[iExcelNumLine, 5] := CountFactSold;   SetPropExcelCell(vExcelSheetOne, 5, iExcelNumLine, 0, xlCenter);
      vExcel.ActiveCell[iExcelNumLine, 6] := SumFactSold;     SetPropExcelCell(vExcelSheetOne, 6, iExcelNumLine, 0, xlRight);
      { �������  }
      inc(iExcelNumLine);
                                                              SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlRight);
                                                              SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
                                                              SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlRight);
      vExcel.ActiveCell[iExcelNumLine, 4] := '�������';       SetPropExcelCell(vExcelSheetOne, 4, iExcelNumLine, 0, xlRight);
      vExcel.ActiveCell[iExcelNumLine, 5] := CountFactActive; SetPropExcelCell(vExcelSheetOne, 5, iExcelNumLine, 0, xlCenter);
      vExcel.ActiveCell[iExcelNumLine, 6] := SumFactActive;   SetPropExcelCell(vExcelSheetOne, 6, iExcelNumLine, 0, xlRight);
      { �������� }
      inc(iExcelNumLine);
                                                              SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlRight);
                                                              SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
                                                              SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlRight);
      vExcel.ActiveCell[iExcelNumLine, 4] := '��������';      SetPropExcelCell(vExcelSheetOne, 4, iExcelNumLine, 0, xlRight);
      vExcel.ActiveCell[iExcelNumLine, 5] := CountFactClear;  SetPropExcelCell(vExcelSheetOne, 5, iExcelNumLine, 0, xlCenter);
      vExcel.ActiveCell[iExcelNumLine, 6] := SumFactclear;    SetPropExcelCell(vExcelSheetOne, 6, iExcelNumLine, 0, xlRight);
    end;
    { ������������� ����� ��� ��������� ��������� }
    CountStateArmorPlan := 0;
    SumStateArmorPlan   := 0;
    { ������������� ����� ��� ��������� ��������� }
    CountFactClear      := 0;    { ���������� ������ }
    SumFactClear        := 0;
    CountFactSold       := 0;    { ��������� ������ }
    SumFactSold         := 0;
    CountFactActive     := 0;    { �������� ������ }
    SumFactActive       := 0;
  end;
  { ����� �� ���� �������� }
  procedure ResultsByShipping; begin
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := '�����';             SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 2] := CountPlan;           SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := SumPlan;             SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlRight);
    vExcel.ActiveCell[iExcelNumLine, 4] := '������� + �������'; SetPropExcelCell(vExcelSheetOne, 4, iExcelNumLine, 0, xlRight);
    vExcel.ActiveCell[iExcelNumLine, 5] := CountShippingFact;   SetPropExcelCell(vExcelSheetOne, 5, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 6] := SumShippingFact;     SetPropExcelCell(vExcelSheetOne, 6, iExcelNumLine, 0, xlRight);
    { ������������� �������� ����������� �� ������ ����� �������� }
    CountPlan := 0;
    SumPlan := 0;
    { ������������� �������� ����������� �� ������ ����� �������� }
    CountShippingFact := 0;
    SumShippingFact   := 0;
  end;

begin
  { ������������� }
  iExcelNumLine       := 0;
  { ������ }
  GroupShipping       := '';   { ��� �������� }
  OldGroupShipping    := '';
  StateArmour         := -1;   { ��������� ����� }
  OldStateArmour      := -1;
  SignClosed          := -1;   { ������� ���������� ����� }
  OldSignClosed       := -1;
  { �������������� � �������� ���������� }
  CountStateArmorPlan := 0;
  SumStateArmorPlan   := 0;
  CountPlan           := 0;
  SumPlan             := 0;
  CountAllPlan        := 0;
  SumAllPlan          := 0;
  CountFactClear      := 0;    { ���������� ������ }
  SumFactClear        := 0;
  CountFactSold       := 0;    { ��������� ������ }
  SumFactSold         := 0;
  CountFactActive     := 0;    { �������� ������ }
  SumFactActive       := 0;
  CountShippingFact   := 0;    { ����� ���� �� ���� �������� }
  SumShippingFact     := 0;
  CountAllFact        := 0;    { ����� ���� �� ����� ������ ������ }
  SumAllFact          := 0;
  CountAllFactSold    := 0;    { ����� ����-������� �� ����� ������ ������ }
  SumAllFactsold      := 0;
  try
    stbarParm_JSO.SimpleText := '������ ���������� ����������...';
    vExcel := CreateOLEObject('Excel.Application');
    vExcel.Visible := False;
    vExcelBook := vExcel.Workbooks.Add;
    vExcelSheetOne   := vExcelBook.Sheets[1]; vExcelSheetOne.Name   := '������ � ��������� ������';
//    vExcelSheetTwo   := vExcelBook.Sheets[2]; vExcelSheetTwo.Name   := '2';
//    vExcelSheetThree := vExcelBook.Sheets[3]; vExcelSheetThree.Name := '3';
    vExcelSheetOne.Activate;

    { ��������� }
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := '�� ������';                                           SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlRight);
    vExcel.ActiveCell[iExcelNumLine, 2] := '� ' + FormatDateTime('dd-mm-yyyy', dtCndBegin.Date);  SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := '�� ' + FormatDateTime('dd-mm-yyyy', dtCndEnd.Date);   SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 4] := FormatDateTime('dd-mm-yyyy hh:nn:ss', Now);            SetPropExcelCell(vExcelSheetOne, 4, iExcelNumLine, 0, xlRight);

    { ����������� ������ �� �������� ����������� � ������� ����� �������� ���� ������ }
    {*********************************************************************************}
    inc(iExcelNumLine);  inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := '������� �����';   SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 6, xlCenter);
    inc(iExcelNumLine);
    stbarParm_JSO.SimpleText := '������������ ������ ������ (�������� ����������)...';
    iNumbRec := 0;
    spdsPlan.Active := false;
    spdsPlan.Parameters.ParamValues['@SBegin']            := FormatDateTime('yyyy-mm-dd', dtCndBegin.Date);
    spdsPlan.Parameters.ParamValues['@SEnd']              := FormatDateTime('yyyy-mm-dd', dtCndEnd.Date+1);
    spdsPlan.Parameters.ParamValues['@SignGruopPharmacy'] := 0;
    spdsPlan.Parameters.ParamValues['@SignPharmacy']      := 0;
    spdsPlan.Active := true;
    spdsPlan.First;
                                                            SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 2] := '���-��';        SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := '�����';         SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlCenter);
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
    vExcel.ActiveCell[iExcelNumLine, 1] := '�����';      SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 35, xlRight);
    vExcel.ActiveCell[iExcelNumLine, 2] := CountAllPlan; SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 35, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := SumAllPlan;   SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 35, xlRight);

    { ����������� ������ �� �������� ����������� � ������� ����� �������� � ��������������� ������������ �� ���� ������ }
    {*******************************************************************************************************************}
    { ������������� }
    { ������ }
    GroupShipping       := '';   { ��� �������� }
    OldGroupShipping    := '';
    StateArmour         := -1;   { ��������� ����� }
    OldStateArmour      := -1;
    SignClosed          := -1;   { ������� ���������� ����� }
    OldSignClosed       := -1;
    { �������������� � �������� ���������� }
    CountStateArmorPlan := 0;
    SumStateArmorPlan   := 0;
    CountPlan           := 0;
    SumPlan             := 0;
    CountAllPlan        := 0;
    SumAllPlan          := 0;
    CountFactClear      := 0;    { ���������� ������ }
    SumFactClear        := 0;
    CountFactSold       := 0;    { ��������� ������ }
    SumFactSold         := 0;
    CountFactActive     := 0;    { �������� ������ }
    SumFactActive       := 0;
    CountShippingFact   := 0;    { ����� ���� �� ���� �������� }
    SumShippingFact     := 0;
    CountAllFact        := 0;    { ����� ���� �� ����� ������ ������ }
    SumAllFact          := 0;
    CountAllFactSold    := 0;    { ����� ����-������� �� ����� ������ ������ }
    SumAllFactsold      := 0;
    iNumbRec := 0;
    inc(iExcelNumLine);
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := '�������';    SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 6, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 2] := '����������'; SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := '�����';      SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlRight);
    stbarParm_JSO.SimpleText := '������������ ������ ������ (�������� ����������)...';
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
      { ��� �������� }
      GroupShipping := spdsPlanExt.FieldByName('SOrderShipping').AsString;
      { ���������� �������� }
      if spdsPlanExt.FieldByName('ISortSequence').AsInteger = 1 then begin
        GroupShipping := GroupShipping + ' (' + spdsPlanExt.FieldByName('SSignCourier').AsString + ')';
      end;
      { ��������� }
      if spdsPlanExt.FieldByName('ISortSequence').AsInteger = 2 then begin
        { ��� ������ � ��������� ������ - ������� ����� }
        if spdsPlanExt.FieldByName('NPharmacy').AsInteger = (-1) then begin
          GroupShipping := GroupShipping + ' (������� �����)';
        end else begin
          case spdsPlanExt.FieldByName('IMergeStateArmour').AsInteger of
            0: GroupShipping := GroupShipping + ' (������ ��� ����)';
            1: GroupShipping := GroupShipping + ' (������ ��� ����)';
            2: GroupShipping := GroupShipping + ' (������ ��� �������� ����)';
          else GroupShipping := GroupShipping + ' (������ ��� ����)';
          end;
        end;
      end;
      { ����� � ������ }
      if spdsPlanExt.FieldByName('ISortSequence').AsInteger = 3 then begin
        case spdsPlanExt.FieldByName('IMergeStateArmour').AsInteger of
          0: GroupShipping := GroupShipping + ' (������ ��� ����)';
          1: GroupShipping := GroupShipping + ' (������ ��� ����)';
          2: GroupShipping := GroupShipping + ' (������ ��� �������� ����)';
        else GroupShipping := GroupShipping + ' (������ ��� ����)';
        end;
      end;
      { ����� � ���� ���� }
      if spdsPlanExt.FieldByName('ISortSequence').AsInteger = 4 then begin
      end;
      { ����� ������ �� ���� �������� }
      if GroupShipping <> OldGroupShipping then begin
        { �� ��������� ��������� }
        if length(OldGroupShipping) <> 0 then begin
          { ����� �� ���� �������� }
          inc(iExcelNumLine);
          vExcel.ActiveCell[iExcelNumLine, 1] := OldGroupShipping;  SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlLeft);
          vExcel.ActiveCell[iExcelNumLine, 2] := CountPlan;         SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
          vExcel.ActiveCell[iExcelNumLine, 3] := SumPlan;           SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlRight);
          { ������������� ��� ���������� ���� �������� }
          CountPlan := 0;
          SumPlan   := 0;
        end;
        { ��������� ����� ������ �� ���� �������� }
        OldGroupShipping := GroupShipping;
      end;
      { ������� ����������� ��� �������� ���� �������� }
      inc(CountPlan);
      SumPlan := SumPlan + spdsPlanExt.FieldByName('NSumNetOrder').AsFloat;
      spdsPlanExt.Next;
    end; // while not spdsPlanExt.Eof do begin
    { ����� �� ���� �������� }
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := GroupShipping;   SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlLeft);
    vExcel.ActiveCell[iExcelNumLine, 2] := CountPlan;       SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := SumPlan;         SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlRight);
    { ����� ����� }
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := '�����';      SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 35, xlRight);
    vExcel.ActiveCell[iExcelNumLine, 2] := CountAllPlan; SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 35, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := SumAllPlan;   SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 35, xlRight);

    { ����������� ������ �� �������� � ����������� ����������� (������ � ��������� ������) }
    {**************************************************************************************}
    { ������������� }
    { ������ }
    GroupShipping       := '';   { ��� �������� }
    OldGroupShipping    := '';
    StateArmour         := -1;   { ��������� ����� }
    OldStateArmour      := -1;
    SignClosed          := -1;   { ������� ���������� ����� }
    OldSignClosed       := -1;
    { �������������� � �������� ���������� }
    CountStateArmorPlan := 0;
    SumStateArmorPlan   := 0;
    CountPlan           := 0;
    SumPlan             := 0;
    CountAllPlan        := 0;
    SumAllPlan          := 0;
    CountFactClear      := 0;    { ���������� ������ }
    SumFactClear        := 0;
    CountFactSold       := 0;    { ��������� ������ }
    SumFactSold         := 0;
    CountFactActive     := 0;    { �������� ������ }
    SumFactActive       := 0;
    CountShippingFact   := 0;    { ����� ���� �� ���� �������� }
    SumShippingFact     := 0;
    CountAllFact        := 0;    { ����� ���� �� ����� ������ ������ }
    SumAllFact          := 0;
    CountAllFactSold    := 0;    { ����� ����-������� �� ����� ������ ������ }
    SumAllFactsold      := 0;
    stbarParm_JSO.SimpleText := '������������ ������ ������ (������ � ��������� ������)...';
    iNumbRec := 0;
    spdsSumArmor.Active := false;
    spdsSumArmor.Parameters.ParamValues['@SBegin']            := FormatDateTime('yyyy-mm-dd', dtCndBegin.Date);
    spdsSumArmor.Parameters.ParamValues['@SEnd']              := FormatDateTime('yyyy-mm-dd', dtCndEnd.Date+1);
    spdsSumArmor.Parameters.ParamValues['@SignGruopPharmacy'] := 0;
    spdsSumArmor.Active := true;
    spdsSumArmor.First;
    inc(iExcelNumLine);  inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := '�������������� ������������';
        SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 6, xlLeft);
        SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 6, xlLeft);
        SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 6, xlLeft);
    while not spdsSumArmor.Eof do begin
      { �������� �������� ���������� �� ����� ������ ������ }
      inc(CountAllPlan);
      SumAllPlan := SumAllPlan + spdsSumArmor.FieldByName('NSumNetOrder').AsFloat;
      { ��� �������� }
      GroupShipping := spdsSumArmor.FieldByName('SOrderShipping').AsString;
      inc(iNumbRec);
      stbarParm_JSO.SimpleText := IntToStr(iNumbRec)+'/'+IntToStr(spdsSumArmor.RecordCount);
      { ����� ������ �� ���� �������� }
      if GroupShipping <> OldGroupShipping then begin
        { �� ��������� ��������� }
        if length(OldGroupShipping) <> 0 then begin
          { ����� �� ��������� ����� }
          ResultsByStateArmor;
          { ����� �� ���� �������� }
          ResultsByShipping;
          { �������������� ��������� �������� ��� ���������� ������ �������� �� �������� ����� � ������ �� ���� ��������}
          StateArmour    := -1;   { ��������� ����� }
          OldStateArmour := -1;
        end;
        { ��������� �� ����� �������� }
        inc(iExcelNumLine);
        vExcel.ActiveCell[iExcelNumLine, 1] := GroupShipping;   SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 19, xlCenter);
        vExcel.ActiveCell[iExcelNumLine, 2] := '����';          SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 15, xlCenter);
                                                                SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 15, xlCenter);
        vExcel.ActiveCell[iExcelNumLine, 4] := '����';          SetPropExcelCell(vExcelSheetOne, 4, iExcelNumLine, 8, xlCenter);
                                                                SetPropExcelCell(vExcelSheetOne, 5, iExcelNumLine, 8, xlCenter);
                                                                SetPropExcelCell(vExcelSheetOne, 6, iExcelNumLine, 8, xlCenter);
        inc(iExcelNumLine);
                                                                SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlCenter);
        vExcel.ActiveCell[iExcelNumLine, 2] := '���-��';        SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
        vExcel.ActiveCell[iExcelNumLine, 3] := '�����';         SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlCenter);
                                                                SetPropExcelCell(vExcelSheetOne, 4, iExcelNumLine, 0, xlCenter);
        vExcel.ActiveCell[iExcelNumLine, 5] := '���-��';        SetPropExcelCell(vExcelSheetOne, 5, iExcelNumLine, 0, xlCenter);
        vExcel.ActiveCell[iExcelNumLine, 6] := '�����';         SetPropExcelCell(vExcelSheetOne, 6, iExcelNumLine, 0, xlCenter);
        { ��������� ����� ������ �� ���� �������� }
        OldGroupShipping := GroupShipping;
      end; // ����� ������ �� ���� ��������
      { �������� ���������� �� ������ ��� �������� }
      inc(CountPlan);
      SumPlan := SumPlan + spdsSumArmor.FieldByName('NSumNetOrder').AsFloat;
      { ��������� ����� }
      StateArmour := spdsSumArmor.FieldByName('IMergeStateArmour').AsInteger;
      { ����� ��������� �� ��������� ����� }
      if StateArmour <> OldStateArmour then begin
        { �� ��������� ��������� }
        if OldStateArmour <> (-1) then begin
          { ����� �� ��������� ����� }
          ResultsByStateArmor;
        end;
        OldStateArmour     := StateArmour;
        OldNameStateArmour := spdsSumArmor.FieldByName('SMergeStateArmour').AsString;
      end;
      { ��������� ��������� �����: �������������� � ��������� ���������� }
      inc(CountStateArmorPlan);
      SumStateArmorPlan := SumStateArmorPlan + spdsSumArmor.FieldByName('NSumNetOrder').AsFloat;
      { ����������� ���������� �� ��������� ������� �������� ������ }
      case spdsSumArmor.FieldByName('IClosed').AsInteger of
        { �� ������������� }
       -1: begin
           end;
        { �������� }
        0: begin
             inc(CountFactActive);
             SumFactActive := SumFactActive + spdsSumArmor.FieldByName('NSumNetOrder').AsFloat;
             inc(CountShippingFact);
             SumShippingFact := SumShippingFact + spdsSumArmor.FieldByName('NSumNetOrder').AsFloat;
             inc(CountAllFact);
             SumAllFact := SumAllFact + spdsSumArmor.FieldByName('NSumNetOrder').AsFloat;
           end;
        { ���������� }
        1: begin
             inc(CountFactClear);
             SumFactClear := SumFactClear + spdsSumArmor.FieldByName('NSumNetOrder').AsFloat;
           end;
        { ��������� }
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
      { ��������� ������ ������ ������ }
      spdsSumArmor.Next;
    end; // while not spdsSumArmor.Eof do begin
    { ����� �� ��������� ����� }
    ResultsByStateArmor;
    { ����� �� ���� �������� }
    ResultsByShipping;
    { ����� �� ����� ������ ������ }
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := '�����';             SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 35, xlRight);
    vExcel.ActiveCell[iExcelNumLine, 2] := CountAllPlan;        SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 35, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := SumAllPlan;          SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 35, xlRight);
    vExcel.ActiveCell[iExcelNumLine, 4] := '������� + �������'; SetPropExcelCell(vExcelSheetOne, 4, iExcelNumLine, 35, xlRight);
    vExcel.ActiveCell[iExcelNumLine, 5] := CountAllFact;        SetPropExcelCell(vExcelSheetOne, 5, iExcelNumLine, 35, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 6] := SumAllFact;          SetPropExcelCell(vExcelSheetOne, 6, iExcelNumLine, 35, xlRight);
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 4] := '�������';        SetPropExcelCell(vExcelSheetOne, 4, iExcelNumLine, 4, xlRight);
    vExcel.ActiveCell[iExcelNumLine, 5] := CountAllFactSold; SetPropExcelCell(vExcelSheetOne, 5, iExcelNumLine, 4, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 6] := SumAllFactSold;   SetPropExcelCell(vExcelSheetOne, 6, iExcelNumLine, 4, xlRight);
    { ������ �������� }
    vExcelSheetOne.Columns[1].ColumnWidth := 35;
    vExcelSheetOne.Columns[2].ColumnWidth := 15;
    vExcelSheetOne.Columns[3].ColumnWidth := 15;
    vExcelSheetOne.Columns[4].ColumnWidth := 20;
    vExcelSheetOne.Columns[5].ColumnWidth := 15;
    vExcelSheetOne.Columns[6].ColumnWidth := 15;

    { ����������� ������ �� �������� ����������� - ������ ��� � ��������� ������ }
    {****************************************************************************}
    inc(iExcelNumLine);
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := '������ ��� ������� ������������ (����)';   SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 6, xlLeft);
    inc(iExcelNumLine);
    stbarParm_JSO.SimpleText := '������������ ������ ������ (��� ������ � ��������� ������ - �������� ����������)...';
    iNumbRec := 0;
    spdsPlan.Active := false;
    spdsPlan.Parameters.ParamValues['@SBegin']            := FormatDateTime('yyyy-mm-dd', dtCndBegin.Date);
    spdsPlan.Parameters.ParamValues['@SEnd']              := FormatDateTime('yyyy-mm-dd', dtCndEnd.Date+1);
    spdsPlan.Parameters.ParamValues['@SignGruopPharmacy'] := 0;
    spdsPlan.Parameters.ParamValues['@SignPharmacy']      := 2;
    spdsPlan.Active := true;
    spdsPlan.First;
                                                            SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 2] := '���-��';        SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := '�����';         SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlCenter);
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

    { ����������� ������ �� ����� - ������ ������������ (��� ������ � ��������� ������) }
    {***********************************************************************************}
    { ������������� }
    { ������ }
    GroupShipping       := '';   { ��� �������� }
    OldGroupShipping    := '';
    StateArmour         := -1;   { ��������� ����� }
    OldStateArmour      := -1;
    SignClosed          := -1;   { ������� ���������� ����� }
    OldSignClosed       := -1;
    { �������������� � �������� ���������� }
    CountStateArmorPlan := 0;
    SumStateArmorPlan   := 0;
    CountPlan           := 0;
    SumPlan             := 0;
    CountAllPlan        := 0;
    SumAllPlan          := 0;
    CountFactClear      := 0;    { ���������� ������ }
    SumFactClear        := 0;
    CountFactSold       := 0;    { ��������� ������ }
    SumFactSold         := 0;
    CountFactActive     := 0;    { �������� ������ }
    SumFactActive       := 0;
    CountShippingFact   := 0;    { ����� ���� �� ���� �������� }
    SumShippingFact     := 0;
    CountAllFact        := 0;    { ����� ���� �� ����� ������ ������ }
    SumAllFact          := 0;
    CountAllFactSold    := 0;    { ����� ����-������� �� ����� ������ ������ }
    SumAllFactsold      := 0;
    { ������� }
    inc(iExcelNumLine);
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := '������ ������������ (����)';   SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 6, xlLeft);
    inc(iExcelNumLine);
                                                      SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlLeft);
    vExcel.ActiveCell[iExcelNumLine, 2] := '���-��';  SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := '�����';   SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlCenter);
    stbarParm_JSO.SimpleText := '������������ ������ ������ (���� - ������ �����������)...';
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
      { ��� �������� }
      GroupShipping := spdsFactHand.FieldByName('STypeZakaz').AsString;
      case spdsFactHand.FieldByName('IClosed').AsInteger of
        0: begin
             GroupShipping := GroupShipping + ' (�������)';
             SumPlan := SumPlan + spdsFactHand.FieldByName('NSumOrder').AsFloat;
           end;
        1: begin
             GroupShipping := GroupShipping + ' (��������)';
             SumPlan := SumPlan + spdsFactHand.FieldByName('NSumOrder').AsFloat;
           end;
        2: begin
             GroupShipping := GroupShipping + ' (�������)';
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
             GroupShipping := GroupShipping + ' (�������)';
             SumPlan := SumPlan + spdsFactHand.FieldByName('NSumOrder').AsFloat;
           end;
      end;
      { ����� ������ �� ���� �������� }
      if GroupShipping <> OldGroupShipping then begin
        { �� ��������� ��������� }
        if length(OldGroupShipping) <> 0 then begin
          { ����� �� ���� �������� }
          inc(iExcelNumLine);
          vExcel.ActiveCell[iExcelNumLine, 1] := OldGroupShipping;  SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlLeft);
          vExcel.ActiveCell[iExcelNumLine, 2] := CountPlan;         SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
          vExcel.ActiveCell[iExcelNumLine, 3] := SumPlan;           SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlRight);
          { ������������� ��� ���������� ���� �������� }
          CountPlan := 0;
          SumPlan   := 0;
        end;
        { ��������� ����� ������ �� ���� �������� }
        OldGroupShipping := GroupShipping;
      end;
      inc(CountPlan);
      spdsFactHand.Next;
    end; // while not spdsFactHand.Eof do begin
    { ����� �� ���� �������� }
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1] := GroupShipping;  SetPropExcelCell(vExcelSheetOne, 1, iExcelNumLine, 0, xlLeft);
    vExcel.ActiveCell[iExcelNumLine, 2] := CountPlan;      SetPropExcelCell(vExcelSheetOne, 2, iExcelNumLine, 0, xlCenter);
    vExcel.ActiveCell[iExcelNumLine, 3] := SumPlan;        SetPropExcelCell(vExcelSheetOne, 3, iExcelNumLine, 0, xlRight);
    { ����� ������� }
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
