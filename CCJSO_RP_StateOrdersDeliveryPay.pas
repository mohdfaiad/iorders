unit CCJSO_RP_StateOrdersDeliveryPay;

{***********************************************************************
 * � PgkSoft 29.04.2015
 * ������ �������� �������
 * 1.	��������� ������� �� "���������� ��������" �� ����������� ������
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
  { ������������� }
  bSignActive := false;
  DFormatSet.DateSeparator := '-';
  DFormatSet.TimeSeparator := ':';
  DFormatSet.ShortDateFormat := 'dd-mm-yyyy';
  DFormatSet.ShortTimeFormat := 'hh24:mi:ss';
end;

procedure TfrmCCJSO_RP_StateOrdersDeliveryPay.FormActivate(Sender: TObject);
begin
  if not bSignActive then begin
    { ������ ���� }
    FCCenterJournalNetZkz.imgMain.GetIcon(369,self.Icon);
    { ����� ������� }
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
    { ������ � ������� ������������ ������ }
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
  SumAll               : Currency;    { ����� ����� }
  SumRecd              : Currency;    { ����� �������� }
  CountRecd            : integer;     { ���������� �������� }
begin
  SFontSize := '10';
  SumAll    := 0;
  SumRecd   := 0;
  CountRecd := 0;
  try
    pnlControl_Show.Caption := '������ ���������� ����������...';
    vExcel := CreateOLEObject('Excel.Application');
    vDD := vExcel.Workbooks.Add;
    WS := vDD.Sheets[1];
    pnlControl_Show.Caption := '������������ ������ ������...';
    Application.ProcessMessages;
    if qrspPay.Active then qrspPay.Active := false;
    qrspPay.Parameters.ParamValues['@SBegin'] := FormatDateTime('yyyy-mm-dd hh:nn:ss',StrToDateTime(edDateBegin.Text,DFormatSet));
    qrspPay.Parameters.ParamValues['@SEnd']   := FormatDateTime('yyyy-mm-dd hh:nn:ss',StrToDateTime(edDateEnd.Text,DFormatSet));
    qrspPay.Open;
    RecCount := qrspPay.RecordCount;
    iExcelNumLine := 0;
    RecNumb := 0;
    { ��������� ������ }
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := '��������� ������� �� ���������� ��������';
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := '�� ������ � ' + edDateBegin.Text + '  �� ' + edDateEnd.Text;
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := '���� ������������: ' + FormatDateTime('dd-mm-yyyy hh:nn:ss', Now);
    inc(iExcelNumLine);
    { ��������� ������� }
    inc(iExcelNumLine);
    fl_cnt := qrspPay.FieldCount;
    for I := 1 to fl_cnt do begin
      vExcel.ActiveCell[iExcelNumLine, I].Value := qrspPay.Fields[I - 1].FieldName;
      SetPropExcelCell(WS, i, iExcelNumLine, 0, xlCenter);
      vExcel.Cells[iExcelNumLine, I].Font.Size := SFontSize;
    end;
    { ����� ������� }
    qrspPay.First;
    while not qrspPay.Eof do begin
      inc(RecNumb);
      pnlControl_Show.Caption := '������������ ������: '+VarToStr(RecNumb)+'/'+VarToStr(RecCount);
      inc(iExcelNumLine);
      for num_cnt := 1 to fl_cnt do begin
        { �������� �������� ���� }
        if   (qrspPay.Fields[num_cnt - 1].FullName = '�������')
          or (qrspPay.Fields[num_cnt - 1].FullName = '���� ������')
          or (qrspPay.Fields[num_cnt - 1].FullName = '���� ��������')
          or (qrspPay.Fields[num_cnt - 1].FullName = '���� �������')
          then vExcel.Cells[iExcelNumLine, num_cnt].NumberFormat := '@';
        if   (qrspPay.Fields[num_cnt - 1].FullName = '����� ������')
          or (qrspPay.Fields[num_cnt - 1].FullName = '����� ��������')
          then vExcel.Cells[iExcelNumLine, num_cnt].NumberFormat := '0.00';
        { ������� ������������ ����������� }
        if qrspPay.Fields[num_cnt - 1].FullName = '����� ������' then SumAll := SumAll + qrspPay.Fields[num_cnt - 1].AsCurrency;
        if qrspPay.Fields[num_cnt - 1].FullName = '����� ��������' then
          if qrspPay.Fields[num_cnt - 1].AsCurrency > 0 then begin
            inc(CountRecd);
            SumRecd := SumRecd + qrspPay.Fields[num_cnt - 1].AsCurrency;
          end;
        { ���������� }
        vExcel.ActiveCell[iExcelNumLine, num_cnt].Value := qrspPay.Fields[num_cnt - 1].AsString;
        SetPropExcelCell(WS, num_cnt, iExcelNumLine, 0, xlLeft);
        vExcel.Cells[iExcelNumLine, num_cnt].Font.Size := SFontSize;
      end;
      qrspPay.Next;
    end;
    { ������ ������� }
    vExcel.Columns[01].ColumnWidth := 05;  { � �/� }
    vExcel.Columns[02].ColumnWidth := 08;  { ��� }
    vExcel.Columns[03].ColumnWidth := 08;  { ����� }
    vExcel.Columns[04].ColumnWidth := 18;  { ���� ������ }
    vExcel.Columns[05].ColumnWidth := 18;  { ���� �������� }
    vExcel.Columns[06].ColumnWidth := 10;  { ����� ������ }
    vExcel.Columns[07].ColumnWidth := 10;  { ����� �������� }
    vExcel.Columns[08].ColumnWidth := 10;  { ���� ������� }
    vExcel.Columns[09].ColumnWidth := 30;  { ������ }
    vExcel.Columns[10].ColumnWidth := 18;  { ������� }
    vExcel.Columns[11].ColumnWidth := 15;  { �������������� }
    vExcel.Columns[12].ColumnWidth := 15;  { ������������ }
    { ������� ���� }
    WS.Range[CellName(01,5) + ':' + CellName(12,iExcelNumLine)].WrapText:=true;
    { ����� }
    inc(iExcelNumLine); inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := '� ����';
    vExcel.ActiveCell[iExcelNumLine, 3].Value := VarToStr(RecNumb - CountRecd);
    vExcel.ActiveCell[iExcelNumLine, 4].Value := VarToStr(SumAll - SumRecd);
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := '��������';
    vExcel.ActiveCell[iExcelNumLine, 3].Value := VarToStr(CountRecd);
    vExcel.ActiveCell[iExcelNumLine, 4].Value := VarToStr(SumRecd);
    inc(iExcelNumLine);
    vExcel.ActiveCell[iExcelNumLine, 1].Value := '�����';
    vExcel.ActiveCell[iExcelNumLine, 3].Value := VarToStr(RecNumb);
    vExcel.ActiveCell[iExcelNumLine, 4].Value := VarToStr(SumAll);
    { ���������� }
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
    10: begin EdText := edDateBegin.Text;  WHeaderCaption := '���� ������' end;
    11: begin EdText := edDateEnd.Text;    WHeaderCaption := '���� ���������' end;
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
      ShowMessage('���� ��� ���������� ��������.' + chr(10) + e.Message);
    end;
  end;
  ShowGets;
end;

procedure TfrmCCJSO_RP_StateOrdersDeliveryPay.aFieldChangeExecute(Sender: TObject);
begin
  ShowGets;
end;

end.
