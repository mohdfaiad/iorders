unit uSprGridFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, uSprQuery, Grids, DBGrids, Buttons,
  DB, uSprFilter, StrUtils, Math, uSprOrder, ImgList, Menus, ToolWin,
  UtilsBase, EQDBxlExport, ClipBrd;

type
  TsprGridFrm = class;
  TsprGridFrmClass = class of TsprGridFrm;

  TsprGridFrm = class(TFrame)
    PanelTop: TPanel;
    PanelPeriod: TPanel;
    lbPeriod: TLabel;
    edStartDate: TDateTimePicker;
    lbPeriod1: TLabel;
    edEndDate: TDateTimePicker;
    Grid: TDBGrid;
    PanelFastFilter: TPanel;
    cbOper: TComboBox;
    FastFilterEdit: TEdit;
    btnFastFilterClear: TSpeedButton;
    cbFieldList: TComboBox;
    ActionImages: TImageList;
    Bevel1: TBevel;
    PanelActions: TPanel;
    pmActions: TPopupMenu;
    ToolBar1: TToolBar;
    tbRefresh: TToolButton;
    tbAction: TToolButton;
    tbSeparator1: TToolButton;
    procedure GridTitleClick(Column: TColumn);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnFastFilterClearClick(Sender: TObject);
    procedure FastFilterEditDblClick(Sender: TObject);
    procedure FastFilterEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRefreshClick(Sender: TObject);
    procedure GridColEnter(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure pmActionsPopup(Sender: TObject);
    procedure tbRefreshClick(Sender: TObject);
    procedure btnXLSClick(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FDataSet: TsprQuery;
    FDataSource: TDataSource;
    FFastFiltering: Boolean;
    FRefreshing: Boolean;
    procedure SetDataSet(Value: TsprQuery);
    procedure InnerInitialize;
    procedure InitFastFilter;
    procedure UpdFastFilter(FieldName: string = '');
    procedure ApplyFastFilter(Accumulate: Boolean = False);
    procedure ClearFastFilter;
    procedure PhaseDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure pmActionItemClick(Sender: TObject);
    procedure DlgOnShow(Sender: TObject);
  protected
    FSelectState: Boolean;
    procedure SetContext; virtual;
  public
    { Public declarations }
    procedure Initialize; virtual;
    procedure RefreshData;
    constructor Create(AOwner: TComponent); override;
    class function Select(FrameClass: TsprGridFrmClass; DS: TsprQuery;
      KeyField: string; ValueField: string;
      var KeyValue: Variant; var Value: Variant): Boolean;
    property DataSet: TsprQuery Read FDataSet Write SetDataSet;
    property DataSource: TDataSource read FDataSource;
  end;

  type THackDBGrid = class(TCustomDBGrid);

  function ShiftDown : Boolean;

implementation

{$R *.dfm}

uses uSprItemDlg, uSprCommonDlg;

procedure TsprGridFrm.SetDataSet(Value: TsprQuery);
var
  I: Integer;
  vItem: TMenuItem;
  vAction: TQueryAction;
begin
  if FDataSet <> Value then
  begin
    FDataSet := Value;
    InnerInitialize;
    pmActions.Items.Clear;
    tbAction.Visible := Assigned(FDataSet);
    tbSeparator1.Visible := tbAction.Visible;
    if Assigned(FDataSet) then
    begin
      if FDataSet.Actions.Count > 0 then
      begin
        for I := 0 to FDataSet.Actions.Count - 1 do
        begin
          vItem := TMenuItem.Create(pmActions);
          pmActions.Items.Add(vItem);
          vAction := TQueryAction(FDataSet.Actions.Items[I]);
          vItem.Caption := vAction.Caption;
          vItem.Tag := Integer(vAction);
          vItem.OnClick := pmActionItemClick;
        end;
      end;
      vItem := TMenuItem.Create(pmActions);
      pmActions.Items.Add(vItem);
      vItem.Caption := '-';
      vItem.Tag := -1;

      vItem := TMenuItem.Create(pmActions);
      pmActions.Items.Add(vItem);
      vItem.Caption := 'Экспорт в XLS';
      vItem.Tag := -2;
      vItem.OnClick := btnXLSClick;
    end;
  end;
end;

procedure TsprGridFrm.Initialize;
begin
 {}
end;

procedure TsprGridFrm.InnerInitialize;
begin
  if not Assigned(FDataSource) then
    FDataSource := TDataSource.Create(Self);
    
  tbRefresh.Enabled := Assigned(FDataSet);
  if Assigned(FDataSet) then
  begin
    FDataSource.DataSet  := FDataSet;
    Grid.DataSource      := FDataSource;
    edStartDate.DateTime := Now;
    edEndDate.DateTime   := Now;
    PanelPeriod.Visible := FDataSet.CanFilterDate;
    InitFastFilter;
    SetContext;
  end
  else
  begin
    FDataSource.DataSet   := nil;
  end;
  Initialize;
end;

procedure TsprGridFrm.InitFastFilter;
var
  I: Integer;
begin
  cbFieldList.Items.Clear;
  if not Assigned(FDataSet) then
    Exit;
  for I := 0 to FDataSet.Fields.Count - 1 do
  begin
    if FDataSet.Fields[I].Visible and not (FDataSet.Fields[I].DataType in [ftTime]{, ftDate, ftDateTime]}) then
      cbFieldList.Items.AddObject(FDataSet.Fields[I].DisplayLabel, FDataSet.Fields[I]);
  end;
  if Assigned(Grid.SelectedField) then
    UpdFastFilter(Grid.SelectedField.FieldName)
  else
    UpdFastFilter;
end;

procedure TsprGridFrm.UpdFastFilter(FieldName: string);
var
  I: Integer;
begin
  if (FieldName = '') and (cbFieldList.Items.Count > 0) then
    cbFieldList.ItemIndex := 0
  else
  begin
    cbFieldList.ItemIndex := 0;
    for I := 0 to cbFieldList.Items.Count - 1 do
    begin
      if SameText(TFIeld(cbFieldList.Items.Objects[I]).FieldName, FieldName) then
      begin
        cbFieldList.ItemIndex := I;
        break;
      end;
    end;
  end;
end;

procedure TsprGridFrm.GridTitleClick(Column: TColumn);
var
  vFieldName: string;
  vTitle: string;
begin
  vFieldName := Column.FieldName;
  vTitle := Column.Title.Caption;
  FDataSet.Order.By(Column.FieldName);

  FDataSet.Active := False;
  FDataSet.Active := True;

  Grid.Invalidate;
end;

procedure TsprGridFrm.GridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  vItem: TsprOrderItem;
  vBold: Boolean;
  vGrid: TDBGrid;
begin
  vGrid := TDBGrid(Sender);
  if (dgEditing in vGrid.Options) and Column.Field.ReadOnly then
    Column.Color := clBtnFace;

  vItem := FDataSet.Order.Find(Column.FieldName);
  vBold := False;
  if Assigned(vItem) then
  begin
   if vItem.Desc then
    begin
      Column.Title.Font.Color := clBlue;
      Column.Title.Font.Style := Column.Title.Font.Style + [fsBold];
      vBold := True;
    end
    else
    begin
      Column.Title.Font.Color := clMaroon;
      Column.Title.Font.Style := Column.Title.Font.Style + [fsBold];
      vBold := True;
    end;
  end;

  PhaseDrawColumnCell(Sender, Rect, DataCol, Column, State);
  if (THackDBGrid(Sender).DataLink.ActiveRecord + 1 = THackDBGrid(Sender).Row)
     or (gdFocused in State) or (gdSelected in State) then
  begin
    vGrid.Canvas.Brush.Color := clHighLight;
    vGrid.Canvas.Font.Style := vGrid.Canvas.Font.Style + [fsBold];
    vGrid.Canvas.Font.Color := clHighLightText;
  end;
  {if Column.Field = TDBGrid(Sender).SelectedField then
    Column.Title.Font.Style := Column.Title.Font.Style + [fsBold]
  else
    if not vBold then
      Column.Title.Font.Style := Column.Title.Font.Style - [fsBold];}


  TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);   
end;

procedure TsprGridFrm.ApplyFastFilter(Accumulate: Boolean = False);
var
  vField: TField;

  function GetComparisionOperator: TsprFilterComparisonOperator;
  begin
    case cbOper.ItemIndex of
      0: Result := '=';
      1: Result := '!=';
      2: Result := 'LIKE';
      3: Result := 'NOT LIKE';
      4: Result := '>';
      5: Result := '>=';
      6: Result := '<';
      7: Result := '<=';
    end;
  end;

  function GetFilterValue(AField: TField): Variant;
  var
    Tmp: Double;
  begin
    if AField.DataType  = ftBoolean then
      Result := IfThen(AnsiSameText(FastFilterEdit.Text, 'нет'), 0, 1)
    else
    begin
      if (AField.DataType in
         [ftSmallint, ftWord, ftInteger, ftLargeInt, ftAutoInc, ftFloat, ftCurrency, ftBCD, ftFMTBcd])
         and TryStrToFloat(FastFilterEdit.Text, Tmp) then
        Result := Tmp
      else
        Result := FastFilterEdit.Text;
    end;
  end;
begin
  FFastFiltering := True;
  try
    if AnsiUpperCase(Trim(FastFilterEdit.Text)) = 'SQL' then
    begin
      ShowMessage(FDataSet.GetDescription);
      Exit;
    end;

    if cbFieldList.Items.Count = 0 then
      Exit;

    vField := TField(cbFieldList.Items.Objects[cbFieldList.ItemIndex]);
    if Assigned(vField) then
    begin
      if not(Accumulate) then
        FDataSet.Filters.Clear('FastFilters');
      FDataSet.Filters.AddCaptionFilter(vField.FieldName, GetFilterValue(vField), GetComparisionOperator, 'FastFilters');
      //FDataSet.Active := False;
      //FDataSet.Active := True;
      if not FRefreshing then
        RefreshData;
    end;
  finally
    FFastFiltering := False;
  end;
end;

procedure TsprGridFrm.ClearFastFilter;
begin
  FFastFiltering := True;
  try
    FastFilterEdit.Clear;
    if Assigned(FDataSet) then
    begin
      FDataSet.Filters.Clear('FastFilters');
      //FDataSet.Active := False;
      //FDataSet.Active := True;
      if not FRefreshing then
        RefreshData;
    end;
  finally
    FFastFiltering := False;
  end;
end;

procedure TsprGridFrm.btnFastFilterClearClick(Sender: TObject);
begin
  ClearFastFilter;
end;

procedure TsprGridFrm.FastFilterEditDblClick(Sender: TObject);
begin
  ApplyFastFilter(false);
end;

procedure TsprGridFrm.FastFilterEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: ApplyFastFilter(true);
    VK_ESCAPE: (Sender as TEdit).Text := '';
  end;
end;

procedure TsprGridFrm.SetContext;
var
  vStartDate: TDateTime;
  vEndDate: TDateTime;
  vDate: TDateTime;
begin
  vStartDate := edStartDate.DateTime;
  vEndDate := edEndDate.DateTime;
  if vStartDate > vEndDate then
  begin
    edStartDate.DateTime := vEndDate;
    edEndDate.DateTime := vStartDate;
    vDate := vStartDate;
    vStartDate := vEndDate;
    vEndDate := vDate;
  end;
  if Assigned(FDataSet) then
  begin
    FDataSet.StartDate := vStartDate;
    FDataSet.EndDate := vEndDate;
  end;
end;

function ShiftDown : Boolean;
var
  State : TKeyboardState;
begin
  GetKeyboardState(State);
  Result := ((State[vk_Shift] and 128) <> 0);
end;

procedure TsprGridFrm.RefreshData;
begin
  if not Assigned(FDataSet) then
    Exit;

  FRefreshing := True;
  try
    try
      Screen.Cursor := crHourGlass;
      if ShiftDown then
        FDataSet.RevertToDefault;
      SetContext;
      if not FFastFiltering then
      begin
        if FastFilterEdit.Text = '' then
          Self.ClearFastFilter
        else
          Self.ApplyFastFilter(True);
      end;    
      FDataSet.ReOpen;
    finally
      Screen.Cursor := crDefault;
    end;
  finally
    FRefreshing := False;
  end;
end;

procedure TsprGridFrm.btnRefreshClick(Sender: TObject);
begin
  RefreshData;
end;

procedure TsprGridFrm.GridColEnter(Sender: TObject);
begin
  if Assigned(Grid.SelectedField) then
    UpdFastFilter(Grid.SelectedField.FieldName)
  else
    UpdFastFilter();
end;

procedure TsprGridFrm.PhaseDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  vField: TField;
  vGrid: TDBGrid;
  vPhase: Integer;
begin
  if (Sender is TDBGrid) and (not (gdSelected in State)) then 
  begin
    vGrid := TDBGrid(Sender);
    if Assigned(vGrid.DataSource) and Assigned(vGrid.DataSource.DataSet) then
      vField :=  vGrid.DataSource.DataSet.FindField('Phase');
    if Assigned(vField) then
    begin
      vPhase := vField.AsInteger;
      if vPhase = 7 then
        vGrid.Canvas.Brush.Color := TColor($D3D3D3)
      else if vPhase = 1 then
        vGrid.Canvas.Brush.Color := TColor($80FFFF)
      else if vPhase = 4 then
        vGrid.Canvas.Brush.Color := TColor(clSkyBlue)
      else if vPhase = -1 then
        vGrid.Canvas.Brush.Color := TColor($D8B0FF);
    end;
    vGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TsprGridFrm.GridDblClick(Sender: TObject);
var
  vClass: TClass;
begin
  if Assigned(FDataSet) and (FDataSet.RecordCount > 0) and (FDataSet.ItemDlgClassName <> '') then
  begin
    vClass := GetClass(FDataSet.ItemDlgClassName);
    if Assigned(vClass) then
    begin
      if FDataSet.ReadOnly then
        TItemDlgClass(vClass).Execute(FDataSet, TItemDlgClass(vClass), idsBrowse)
      else
        TItemDlgClass(vClass).Execute(FDataSet, TItemDlgClass(vClass), idsEdit);
    end;
  end;
end;

procedure TsprGridFrm.pmActionItemClick(Sender: TObject);
var
  vAction: TQueryAction;
begin
  if Sender is TMenuItem then
  begin
    vAction := TQueryAction(TMenuItem(Sender).Tag);
    vAction.OnExecute(FDataSet);
    RefreshData;
  end;
end;

procedure TsprGridFrm.pmActionsPopup(Sender: TObject);
var
  I: Integer;
  vAction: TQueryAction;
begin
  for I := 0 to pmActions.Items.Count - 1 do
  begin
    if pmActions.Items[I].Tag = -1 then
      continue
    else
    if pmActions.Items[I].Tag = -2 then
      pmActions.Items[I].Enabled := Assigned(FDataSet) and (FDataSet.RecordCount > 0)
    else
    begin
      vAction := TQueryAction(pmActions.Items[I].Tag);
      if Assigned(vAction.Enabled) then
        pmActions.Items[I].Enabled := vAction.Enabled(FDataSet);
    end;    
  end;
end;

procedure TsprGridFrm.tbRefreshClick(Sender: TObject);
begin
  RefreshData;
end;

constructor TsprGridFrm.Create(AOwner: TComponent);
begin
  inherited;
  FSelectState := False;
end;

class function TsprGridFrm.Select(FrameClass: TsprGridFrmClass; DS: TsprQuery;
  KeyField: string; ValueField: string;
  var KeyValue: Variant; var Value: Variant): Boolean;
var
  vDlg: TSprCommonDlg;
  vFrame: TsprGridFrm;
begin
  if not Assigned(DS) then
    ShowError('Не задан DataSet');
  vDlg := TSprCommonDlg.Create(nil);
  try
    vDlg.Caption := 'Выбор значения';
    vFrame := FrameClass.Create(vDlg);
    vFrame.Name := 'MainFrame';
    vFrame.Parent := vDlg;
    vFrame.Align := alClient;
    vFrame.DataSet := DS;
    vDlg.Width := 600;
    vDlg.Height := 400;
    vDlg.OKBtn.Default := False;
    if VarIsAssigned(KeyValue) and DS.Locate(KeyField, KeyValue, []) then
      Value := DS.FieldByName(ValueField).Value
    else
    begin
      DS.First;
      KeyValue := Unassigned;
      Value := Unassigned;
    end;
    vDlg.OKBtn.Caption := 'Выбрать';
    vFrame.FSelectState := True;
    vFrame.UpdFastFilter(ValueField);
    vDlg.OnShow := vFrame.DlgOnShow;
    Result := vDlg.ShowModal = mrOk;
    if Result then
    begin
      KeyValue := DS.FieldByName(KeyField).Value;
      Value := DS.FieldByName(ValueField).Value;
    end;
  finally
    FreeAndNil(vDlg);
  end;
end;

procedure TsprGridFrm.DlgOnShow(Sender: TObject);
var
  vComp: TComponent;
begin
  if Sender is TComponent then
  begin
    vComp := TComponent(Sender).FindComponent('MainFrame');
    if Assigned(vComp) and (vComp is TsprGridFrm) then
      TsprGridFrm(vComp).FastFilterEdit.SetFocus;
  end;
end;

procedure TsprGridFrm.btnXLSClick(Sender: TObject);
var
  vExporter: TEQDBxlExport;
begin
  if Assigned(FDataSet) and (FDataSet.RecordCount > 0) then
  begin
    vExporter := TEQDBxlExport.Create(nil);
    try
      vExporter.DataSet := FDataSet;
      vExporter.DBGrid := Grid;
      vExporter.StartExport;
    finally
      vExporter.Free;
    end;
  end;
end;

procedure TsprGridFrm.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
const
  KEY_C = 67;
begin
  if Assigned(FDataSet) and (FDataSet.RecordCount > 0) and (Assigned(Grid.SelectedField)) and
     (not (dgEditing in Grid.Options)) then
  begin
    if (ssCtrl in Shift) and (Key = KEY_C) then begin
      Key := 0;
      ClipBoard.AsText := Grid.SelectedField.AsString;
    end
  end;
end;

end.
