unit uSprItemDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, DB, UtilsBase, TypInfo;

type
  TSprItemDlg = class;
  TItemDlgClass = class of TSprItemDlg;
  TItemDlgState = (idsBrowse, idsEdit);

  TCtrlMapItem = class(TCollectionItem)
  private
    FControl: TControl;
    FField: TField;
  public
    property Control: TControl read FControl write FControl;
    property Field: TField read FField write FField;
  end;

  TCtrlMap = class(TOwnedCollection)
  private
    FDataSet: TDataSet;
  public
    constructor Create(ADataSet: TDataSet; AOwner: TPersistent;
      AClass: TCollectionItemClass);
    function Find(const AName: string): TCtrlMapItem;
    function IndexOf(const AName: string): Integer;
    property DataSet: TDataSet read FDataSet;
  end;

  TSprItemDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure Initialize;
  protected
    FMap: TCtrlMap;
    FDataSet: TDataSet;
    FState: TItemDlgState;
    procedure OwnInitialize; virtual;
    procedure UpdControls; virtual;
    procedure SetCtrlsEnabled(Value: Boolean); virtual;
  public
    { Public declarations }
    class function Execute(ADataSet: TDataSet; AClass: TItemDlgClass; AState: TItemDlgState): Boolean;
    procedure LoadData;
    procedure AddMap(FieldName: string; Control: TControl);
    property DataSet: TDataSet read FDataSet;
  end;

var
  SprItemDlg: TSprItemDlg;

implementation

{$R *.dfm}

constructor TCtrlMap.Create(ADataSet: TDataSet; AOwner: TPersistent;
  AClass: TCollectionItemClass);
begin
  inherited Create(AOwner, AClass);
  FDataSet := ADataSet;
end;

function TCtrlMap.IndexOf(const AName: string): Integer;
begin
  for Result := 0 to Count - 1 do
    if AnsiCompareText(TCtrlMapItem(Items[Result]).Field.FieldName, AName) = 0 then Exit;
  Result := -1;
end;

function TCtrlMap.Find(const AName: string): TCtrlMapItem;
var
  I: Integer;
begin
  I := IndexOf(AName);
  if I < 0 then Result := nil else Result := TCtrlMapItem(Items[I]);
end;

class function TSprItemDlg.Execute(ADataSet: TDataSet; AClass: TItemDlgClass; AState: TItemDlgState): Boolean;
begin
  with AClass.Create(nil) do
  try
    FDataSet := ADataSet;
    FState := AState;
    try
      Initialize;
      LoadData;
      UpdControls;

      Result := ShowModal = mrOk;
    except
      on E: Exception do
      begin
        ShowError(E.Message);
        Result := false;
      end;
    end;
  finally
    Free;
  end;
end;

procedure TSprItemDlg.Initialize;
begin
  FMap := TCtrlMap.Create(FDataSet, Self, TCtrlMapItem);
  OKBtn.Enabled := false;
  if FState = idsBrowse then
    Self.Caption := Self.Caption + ' ÏÐÎÑÌÎÒÐ'
  else  
  if FState = idsEdit then
    Self.Caption := Self.Caption + ' ÐÅÄÀÊÒÈÐÎÂÀÍÈÅ';
  OwnInitialize;
end;

procedure TSprItemDlg.OwnInitialize;
begin
  // Empty
end;

procedure TSprItemDlg.UpdControls;
begin
  SetCtrlsEnabled(FState = idsEdit);
end;

procedure TSprItemDlg.SetCtrlsEnabled(Value: Boolean);
var
  I: Integer;
  vItem: TCtrlMapItem;
begin
  for I := 0 to FMap.Count - 1 do
  begin
    vItem := TCtrlMapItem(FMap.Items[I]);
    if IsPublishedProp(vItem.Control, 'ReadOnly') then
      SetPropValue(vItem.Control, 'ReadOnly', not Value or vItem.Field.ReadOnly)
    else
      vItem.Control.Enabled := Value and not vItem.Field.ReadOnly;

    if Value then
    begin
      if IsPublishedProp(vItem.Control, 'Color') then
      begin
        if vItem.Field.ReadOnly then
          SetOrdProp(vItem.Control, 'Color', clBtnFace)
        else
          SetOrdProp(vItem.Control, 'Color', clWindow);
      end;
    end;
  end;    
end;

procedure TSprItemDlg.FormDestroy(Sender: TObject);
begin
  if Assigned(FMap) then
    FreeAndNil(FMap);
end;

procedure TSprItemDlg.LoadData;
var
  I: Integer;
  vItem: TCtrlMapItem;
begin
  for I := 0 to FMap.Count - 1 do
  begin
    vItem := TCtrlMapItem(FMap.Items[I]);
    if vItem.Control is TEdit then
      TEdit(vItem.Control).Text := vItem.Field.AsString
    else
    if vItem.Control is TMemo then
      TMemo(vItem.Control).Text := vItem.Field.AsString;
  end;
end;

procedure TSprItemDlg.AddMap(FieldName: string; Control: TControl);
var
  vItem: TCtrlMapItem;
  vField: TField;
begin
  if not Assigned(DataSet) then
    raise Exception.Create('DataSet íå îïðåäåëåí');

  vField := DataSet.FindField(FieldName);
  if not Assigned(vField) then
    raise Exception.Create('Ïîëå ' + FieldName + ' íå íàéäåíî');

  vItem := TCtrlMapItem(FMap.Add);
  vItem.Field := vField;
  vItem.Control := Control;
end;

end.
