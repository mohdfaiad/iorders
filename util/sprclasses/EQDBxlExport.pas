unit EQDBxlExport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, db,
  Variants, comobj, Clipbrd, DDEMan, DDEML, Math, TypInfo,
  Grids, DBGrids;

const
  CaptionSize = 1;

type
  TXlsManagerKind = (xmkUnknown, xmkExel, xmkOpenOffice);

  TExporter = class;
  TExportEvent = procedure(Exporter: TExporter) of object;

  TEQDBxlExport = class(TComponent)
  private
    FCustomFit: boolean;
    FDBGrid: TDbGrid;
    FDataSet: TDataSet;
    FSheetName: string;
    FRowOffset: Integer;
    FColOffset: Integer;
    FOnBeforeExport: TExportEvent;
    FOnAfterExport: TExportEvent;
    procedure InitSettings;
    procedure DoBeforeExport(Exporter: TExporter); virtual;
    procedure DoAfterExport(Exporter: TExporter); virtual;
  public
    procedure StartExport;
  published
    property CustomFit: Boolean read FCustomFit write FCustomFit;
    property DBGrid: TDBGrid read FDBGrid write FDBGrid;
    property DataSet: TDataSet read FDataSet write FDataSet;
    property SheetName: string read FSheetName write FSheetName;
    property ColOffset: Integer read FColOffset write FColOffset;
    property RowOffset: Integer read FRowOffset write FRowOffset;
    property OnAfterExport: TExportEvent read FOnAfterExport write FOnAfterExport;
    property OnBeforeExport: TExportEvent read FOnBeforeExport write FOnBeforeExport;
  end;

  TExporter = class(TObject)
  private
    FFieldList: TStringList;
    FEQDBxlExport: TEQDBxlExport;
    procedure PrepareFieldsFromDataSet;
    procedure PrepareFieldsFromGrid;
    procedure AddField(Field: TField; Caption: string = '');
    procedure SaveFieldCaptions;
  protected
    FCurrentExportedRecord: integer;
    FOleExporter: Variant;
    procedure PrepareOleExporter; virtual; abstract;
    procedure SaveCurrentRecord; virtual; abstract;
    procedure CommitData; virtual; abstract;
    procedure AddFieldCaption(FieldCaption: string); virtual; abstract;
    procedure FormatStringColumn(ColumnIdx: integer); virtual;
    procedure BeforeExecute; virtual;
    procedure PrepareFields; virtual;
    function DataRange: TRect;
  public
    class function CreateExporter: TExporter;
    constructor Create(OleExporter: Variant);
    destructor Destroy; override;
    procedure Execute(EQDBxlExport: TEQDBxlExport);
  end;

  TExelExporter = class(TExporter)
  private
    FExportData: string;
    FSheet: Variant;
    FFieldCaptions: string;
    function CurrentRecordToString: string;
    procedure AppendValue(var SourceStr: string;
      const AdditionStr: string);
  protected
    procedure PrepareOleExporter; override;
    procedure SaveCurrentRecord; override;
    procedure CommitData; override;
    procedure FormatStringColumn(ColumnIdx: integer); override;
    procedure AddFieldCaption(FieldCaption: string); override;
    procedure PrepareFields; override;
  public
    destructor Destroy; override;
  end;

  TOpenOfficeExporter = class(TExporter)
  private
    FDesktop: Variant;
    FDocument: Variant;
    FSheet: Variant;
    FRange: Variant;
    FFieldIdx: integer;   // used as an external variable for AddFieldCaption
    function PointToRange(x, y: integer): string;
  protected
    procedure PrepareOleExporter; override;
    procedure SaveCurrentRecord; override;
    procedure CommitData; override;
    procedure BeforeExecute; override;
    procedure AddFieldCaption(FieldCaption: string); override;
  end;

  TxlDdeClient = class(TDDEClientConv)
  public
    function xlPokeData(const Item: string; Data: PChar): Boolean;
  end;
  
  procedure CreateOleXlsManager(out XlsManager: Variant; out XlsManagerKind: TXlsManagerKind);
  function xlColl(x: Integer): string;
  function xlCell(x, y: Integer): string;

const //from excel2000;
  xlR1C1 = $FFFFEFCA;
  xlContinuous = 1;

implementation

procedure CreateOleXlsManager(out XlsManager: Variant; out XlsManagerKind: TXlsManagerKind);
var
  FirstAttempt: boolean;
begin
  XlsManager := varNull;
  XlsManagerKind := xmkUnknown;
  FirstAttempt := True;
  while True do
  begin
    try
      if FirstAttempt then
      begin
        XlsManager := CreateOleObject('Excel.Application');
        XlsManagerKind := xmkExel;
      end
      else
      begin
        XlsManager := CreateOleObject('com.sun.star.ServiceManager');
        XlsManagerKind := xmkOpenOffice;
      end;
      Break;
    except
      on e: EOleSysError do
      begin
        if e.ErrorCode = -2147221005 then // Инициализация провалилась
        begin
          if FirstAttempt then
            FirstAttempt := False
          else
          begin
            MessageDlg('Ни Exel ни OpenOffice не найдены.',
              mtInformation, [mbOK], 0);
            Exit;  // ни экселя ни ОпенОфиcа не найдено - тихо выйти
          end;
        end
        else
          raise;
      end;
    end;
  end;
end;


{ TxlDDEClient }

function TxlDdeClient.xlPokeData(const Item: string; Data: PChar): Boolean;
var
  hszDat: HDDEData;
  hdata: HDDEData;
  hszItem: HSZ;
begin
  Result := False;
  if (Conv = 0) or WaitStat then Exit;
  hszItem := DdeCreateStringHandle(ddeMgr.DdeInstId, PChar(Item), CP_WINANSI);
  if hszItem = 0 then Exit;
  hszDat := DdeCreateDataHandle(ddeMgr.DdeInstId, Data, StrLen(Data) + 1,
    0, hszItem, CF_TEXT, 0);
  if hszDat <> 0 then begin
    hdata := DdeClientTransaction(Pointer(hszDat), DWORD(-1), Conv, hszItem, CF_TEXT, XTYP_POKE, 10000, nil);
    Result := hdata <> 0;
  end;
  DdeFreeStringHandle(ddeMgr.DdeInstId, hszItem);
end;

function xlColl(x: Integer): string;
begin
  Result := '';
  while x > 0 do begin
    Dec(x);
    Result := Chr(Ord('A') + x mod 24) + result;
    x := x div 24;
  end;
  if Result = '' then
    Result := 'A';
end;

function xlCell(x, y: Integer): string;
begin
  Result := xlColl(x) + IntToStr(y);
end;

procedure TEQDBxlExport.DoBeforeExport(Exporter: TExporter);
begin
  if Assigned(FOnBeforeExport) then
    FOnBeforeExport(Exporter);
end;

procedure TEQDBxlExport.DoAfterExport(Exporter: TExporter);
begin
  if Assigned(FOnAfterExport) then
    FOnAfterExport(Exporter);
end;

procedure TEQDBxlExport.InitSettings;
begin
  if not Assigned(DataSet) then
    raise Exception.Create('DBxlExport requires dataset.');
  if not DataSet.Active then
    raise Exception.Create('Dataset for this component must bee active.');
  if Trim(SheetName) = '' then
    SheetName := 'Лист 1';
end;

procedure TEQDBxlExport.StartExport;
var
  Exporter: TExporter;
  OldCursor: TCursor;
begin
  InitSettings;
  Exporter := TExporter.CreateExporter;
  if not Assigned(Exporter) then
    Exit;

  OldCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    DoBeforeExport(Exporter);
    Exporter.Execute(Self);
  finally
    DoAfterExport(Exporter);
    Screen.Cursor := OldCursor;
    Exporter.Free;
  end;
end;

{ TExporter }

procedure TExporter.AddField(Field: TField; Caption: string);
var
  FieldCaption: string;
begin
  if Caption <> '' then
    FieldCaption := Caption
  else
    if Field.DisplayLabel <> '' then
      FieldCaption := Field.DisplayLabel
    else
      FieldCaption := Field.FieldName;
   FFieldList.AddObject(FieldCaption, Field);
end;

procedure TExporter.BeforeExecute;
begin
  PrepareOleExporter;
  PrepareFields;
  FEQDBxlExport.DataSet.DisableControls;
  FEQDBxlExport.DataSet.First;
end;

constructor TExporter.Create(OleExporter: Variant);
begin
  inherited Create();
  FOleExporter := OleExporter;
  FFieldList := TStringList.Create;
end;

class function TExporter.CreateExporter: TExporter;
var
  OleExporter: Variant;
  ManagerKind: TXlsManagerKind;
begin
  Result := nil;  // make the compiler happy
  CreateOleXlsManager(OleExporter, ManagerKind);
  case ManagerKind of
    xmkExel:
      Result := TExelExporter.Create(OleExporter);
    xmkOpenOffice:
      Result := TOpenOfficeExporter.Create(OleExporter);
  else
    Assert(False, 'CreateOleXlsManager returned unknown ManagerKind: '
      + GetEnumName(TypeInfo(TXlsManagerKind), Integer(ManagerKind)));
  end;
end;

function TExporter.DataRange: TRect;
begin
  Result.Left := 1 + FEQDBxlExport.ColOffset;
  Result.Top := 1 + FEQDBxlExport.RowOffset;
  Result.Right := FFieldList.Count + FEQDBxlExport.ColOffset;
  Result.Bottom := FEQDBxlExport.DataSet.RecordCount + CaptionSize + FEQDBxlExport.RowOffset;
end;

destructor TExporter.Destroy;
begin
  FFieldList.Free;
  inherited;
end;

procedure TExporter.Execute(EQDBxlExport: TEQDBxlExport);
var
  TmpBookmark: TBookmark;
begin
  FEQDBxlExport := EQDBxlExport;
  FCurrentExportedRecord := 1;
  TmpBookmark := FEQDBxlExport.DataSet.GetBookmark;
  BeforeExecute;
  SaveFieldCaptions;
  try
    while not FEQDBxlExport.DataSet.Eof do
    begin
      // reformat record fields in csv
      SaveCurrentRecord;
      Inc(FCurrentExportedRecord);
      FEQDBxlExport.DataSet.Next;
    end;
    CommitData;
  finally
    FEQDBxlExport.DataSet.GotoBookmark(TmpBookmark);
    FEQDBxlExport.DataSet.FreeBookmark(TmpBookmark);
    FEQDBxlExport.DataSet.EnableControls;
  end;
end;

procedure TExporter.FormatStringColumn(ColumnIdx: integer);
begin
 // do nothing here
end;

procedure TExporter.PrepareFields;
begin
  if Assigned(FEQDBxlExport.DBGrid) then
    PrepareFieldsFromGrid
  else
    PrepareFieldsFromDataSet;
end;

procedure TExporter.PrepareFieldsFromDataSet;
var
  i, CurrentExportFieldIdx: integer;
begin
  CurrentExportFieldIdx := 0;
  for i := 0 to Pred(FEQDBxlExport.DataSet.Fields.Count) do
    if FEQDBxlExport.DataSet.Fields[i].Visible then
    begin
      AddField(FEQDBxlExport.DataSet.Fields[i]);

      {исправление конверсии '1/5' в '1 января'
      другие типы не обрабатываем что бы не превращать RecNo в '123.12'}
      if FEQDBxlExport.DataSet.Fields[CurrentExportFieldIdx].DataType = ftString then
        FormatStringColumn(CurrentExportFieldIdx + 1);
      Inc(CurrentExportFieldIdx);
    end;
end;

procedure TExporter.PrepareFieldsFromGrid;
var
  i, j: integer;
begin
  for i := 0 to FEQDBxlExport.DBGrid.Columns.Count - 1 do
  begin
    if FEQDBxlExport.DBGrid.Columns[i].Visible then
      AddField(FEQDBxlExport.DBGrid.Columns[i].Field, FEQDBxlExport.DBGrid.Columns[i].Title.Caption);
  end;
end;

procedure TExporter.SaveFieldCaptions;
var
  i: integer;
begin
  for i := 0 to FFieldList.Count - 1 do
    AddFieldCaption(FFieldList[i]);
end;

{ TExelExporter }

procedure TExelExporter.AddFieldCaption(FieldCaption: string);
begin
  AppendValue(FFieldCaptions, FieldCaption);
end;

procedure TExelExporter.AppendValue(var SourceStr: string;
  const AdditionStr: string);
begin
  SourceStr := SourceStr + AdditionStr + #9;
end;

procedure TExelExporter.CommitData;
var
  IRange: OLEVariant;
  i: integer;
begin
  FFieldCaptions := FFieldCaptions + #10;
  IRange := FOleExporter.Range[
    xlCell(DataRange.Left, DataRange.Top),
    xlCell(DataRange.Right, DataRange.Bottom)];
  with TxlDdeClient.Create(FEQDBxlExport) do
  try
    if SetLink('EXCEL', FOleExporter.ActiveSheet.Name) then
      xlPokeData(IRange.Address[ReferenceStyle := xlR1C1],
        PChar(FFieldCaptions + FExportData));
  finally
    Free;
  end;
  // free dinamicly allocated memory
  FExportData := '';
  FOleExporter.Range[
    xlCell(DataRange.Left, DataRange.Top),
    xlCell(DataRange.Right, DataRange.Top + CaptionSize - 1)].Select;
  FOleExporter.Selection.Interior.ColorIndex := 15;
  FOleExporter.Selection.Borders.LineStyle := xlContinuous;

  for i := 1 to FFieldList.Count do
    if not FEQDBxlExport.CustomFit then
      FOleExporter.Columns[xlColl(i)].AutoFit;
end;

function TExelExporter.CurrentRecordToString: string;
var
  i: integer;
  CurrentFieldValue: string;
begin
  Result := '';
  for i := 0 to Pred(FFieldList.Count) do begin
    CurrentFieldValue :=
      StringReplace(TField(FFieldList.Objects[i]).AsString, '"', '""', [rfReplaceAll]);
    CurrentFieldValue :=
      StringReplace(CurrentFieldValue, #13#10, '    ', [rfReplaceAll]);
    if (CurrentFieldValue = '') or (CurrentFieldValue[1] = '=') then
      CurrentFieldValue := '"' + CurrentFieldValue + '"'#9
    else
      CurrentFieldValue := CurrentFieldValue + #9;
    Result := Result + CurrentFieldValue;
  end;
  Result := Result + #10;
end;

destructor TExelExporter.Destroy;
begin
  FOleExporter.Range['A1'].Select;
  FOleExporter.Visible := True;
  inherited;
end;

procedure TExelExporter.FormatStringColumn(ColumnIdx: integer);
begin
  FOleExporter.Columns[xlColl(ColumnIdx)].NumberFormat := '@';
end;

procedure TExelExporter.PrepareFields;
begin
  FFieldCaptions := '';
  inherited;
end;

procedure TExelExporter.PrepareOleExporter;
begin
  FOleExporter.Visible := False;
  FOleExporter.Workbooks.Add(1);
  FOleExporter.ActiveSheet.Name := FEQDBxlExport.SheetName;
  FSheet := FOleExporter.ActiveSheet;
end;

procedure TExelExporter.SaveCurrentRecord;
begin
  FExportData := FExportData + CurrentRecordToString;
end;

{ TOpenOfficeExporter }

procedure TOpenOfficeExporter.AddFieldCaption(FieldCaption: string);
begin
  FRange[FFieldIdx, 1] := FieldCaption;
  inc(FFieldIdx);
end;

procedure TOpenOfficeExporter.BeforeExecute;
begin
  FFieldIdx := 1;
  FEQDBxlExport.DataSet.Last;  // make all records fetched
  inherited;
  FRange := VarArrayCreate([1, FFieldList.Count, 1,
    FEQDBxlExport.DataSet.RecordCount + CaptionSize], varVariant);
end;

procedure TOpenOfficeExporter.CommitData;
var
  i: integer;
  Cell: Variant;
begin
  FSheet.GetCellRangeByName(
    PointToRange(DataRange.Left, DataRange.Top) + ':' +
    PointToRange(DataRange.Right, DataRange.Bottom)
    ).SetDataArray(FRange);
  for i := 1 to FFieldList.Count do
  begin
    Cell := FSheet.getCellByPosition(i - 1, 0);
    Cell.getColumns.getByIndex(0).OptimalWidth := True;
    Cell.CellBackColor := TColor($D0D0D0);
  end;
end;

function TOpenOfficeExporter.PointToRange(x, y: integer): string;
const
  Letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
  s1, s2: string;
  k: integer;
begin
  repeat
    k := x mod 27;
    s1 := Letters[k] + s1;
    k := x div 26;
  until k <= x;
  s2 := IntToStr(y);
  Result := s1 + s2
end;

procedure TOpenOfficeExporter.PrepareOleExporter;
begin
  FDesktop := FOleExporter.createInstance('com.sun.star.frame.Desktop');
  FDocument := FDesktop.LoadComponentFromURL('private:factory/scalc', '_blank', 0,
    VarArrayCreate([0, - 1], varVariant));
  FSheet := FDocument.GetSheets.getByIndex(0);
end;

procedure TOpenOfficeExporter.SaveCurrentRecord;
var
  i: integer;
  Value: Variant;
  Field: TField;
begin
  for i := 0 to FFieldList.Count - 1 do
  begin
    Field := TField(FFieldList.Objects[i]);
    Value := Field.Value;
    if VarIsNull(Value) or VarIsEmpty(Value) then
      Value := ''
    else
    if Field.DataType = ftDate then
      Value := DateToStr(Value)
    else
    if Field.DataType = ftDateTime then
      Value := DateTimeToStr(Value);
    FRange[i + 1, FCurrentExportedRecord + CaptionSize] := Value;
  end;
end;

end.
