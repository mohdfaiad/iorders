unit CCJSO_VersionContent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, ADODB, Grids, DBGrids, ActnList;

type
  TfrmCCJSO_VersionContent = class(TForm)
    pnlControl: TPanel;
    pnlControl_Show: TPanel;
    pnlControl_Find: TPanel;
    pnlVers: TPanel;
    pnlVersCatalog: TPanel;
    splitVers_Catalog: TSplitter;
    pnlVersContent: TPanel;
    pnlVersContent_List: TPanel;
    splitVersContent_List: TSplitter;
    pnlVersContent_Note: TPanel;
    lblCndContents: TLabel;
    edCndContents: TEdit;
    pnlVersCatalogControl: TPanel;
    pnlVersCatalogGrid: TPanel;
    GridCatalog: TDBGrid;
    spdsCatalog: TADOStoredProc;
    dsCatalog: TDataSource;
    spdsVersionContentList: TADOStoredProc;
    dsVersionContentList: TDataSource;
    GridContentList: TDBGrid;
    edContent: TMemo;
    aList: TActionList;
    aExit: TAction;
    aRefreshCatalog: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edCndContentsChange(Sender: TObject);
    procedure dsCatalogDataChange(Sender: TObject; Field: TField);
    procedure dsVersionContentListDataChange(Sender: TObject; Field: TField);
    procedure aExitExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure splitVers_CatalogMoved(Sender: TObject);
    procedure aRefreshCatalogExecute(Sender: TObject);
    procedure GridCatalogDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridContentListDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Private declarations }
    ISignActive : integer;
    procedure ShowGets;
    procedure CreateConditionCatalog;
    procedure ExecConditionCatalog;
    procedure ReCalcWidthShortContent;
  public
    { Public declarations }
  end;

var
  frmCCJSO_VersionContent: TfrmCCJSO_VersionContent;

implementation

uses
  UMain, UCCenterJournalNetZkz, ExDBGRID;

{$R *.dfm}

procedure TfrmCCJSO_VersionContent.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
end;

procedure TfrmCCJSO_VersionContent.FormActivate(Sender: TObject);
begin
  { Иконка формы }
  FCCenterJournalNetZkz.imgMain.GetIcon(355,self.Icon);
  { Грузим данные }
  ExecConditionCatalog;
  { Форма активна }
  ISignActive := 1;
  ShowGets;
end;

procedure TfrmCCJSO_VersionContent.ShowGets;
begin
  if ISignActive = 1 then begin
  end;
end;

procedure TfrmCCJSO_VersionContent.ReCalcWidthShortContent;
begin
  get_column_by_fieldname('SShortContent',GridContentList).Width := pnlVersContent_List.Width - 30;
end;

procedure TfrmCCJSO_VersionContent.CreateConditionCatalog;
begin
  spdsCatalog.Parameters.ParamByName('@Contents').Value  := edCndContents.Text;
end;

procedure TfrmCCJSO_VersionContent.ExecConditionCatalog;
var
  RN : Integer;
begin
  if not spdsCatalog.IsEmpty then RN := spdsCatalog.FieldByName('NRN').AsInteger else RN := -1;
  spdsCatalog.Active := false;
  CreateConditionCatalog;
  spdsCatalog.Active := true;
  spdsCatalog.Locate('NRN', RN, []);
end;

procedure TfrmCCJSO_VersionContent.edCndContentsChange(Sender: TObject);
begin
  ExecConditionCatalog;
end;

procedure TfrmCCJSO_VersionContent.dsCatalogDataChange(Sender: TObject; Field: TField);
begin
  if GridCatalog.DataSource.DataSet.IsEmpty then begin
    spdsVersionContentList.Active := false;
    spdsVersionContentList.Parameters.ParamByName('@PRN').Value      := 0;
    spdsVersionContentList.Parameters.ParamByName('@Contents').Value := edCndContents.Text;
    spdsVersionContentList.Active := true;
  end else begin
    spdsVersionContentList.Active := false;
    spdsVersionContentList.Parameters.ParamByName('@PRN').Value      := GridCatalog.DataSource.DataSet.FieldByName('NRN').AsInteger;
    spdsVersionContentList.Parameters.ParamByName('@Contents').Value := edCndContents.Text;
    spdsVersionContentList.Active := true;
  end;
end;

procedure TfrmCCJSO_VersionContent.dsVersionContentListDataChange(Sender: TObject; Field: TField);
begin
  edContent.Text := GridContentList.DataSource.DataSet.FieldByName('SContent').AsString;
end;

procedure TfrmCCJSO_VersionContent.aExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJSO_VersionContent.FormResize(Sender: TObject);
begin
  ReCalcWidthShortContent;
end;

procedure TfrmCCJSO_VersionContent.splitVers_CatalogMoved(Sender: TObject);
begin
  ReCalcWidthShortContent;
end;

procedure TfrmCCJSO_VersionContent.aRefreshCatalogExecute(Sender: TObject);
var
  RN : Integer;
begin
  if not spdsCatalog.IsEmpty then RN := spdsCatalog.FieldByName('NRN').AsInteger else RN := -1;
  spdsCatalog.Requery;
  spdsCatalog.Locate('NRN', RN, []);
end;

procedure TfrmCCJSO_VersionContent.GridCatalogDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if db.DataSource.DataSet.FieldByName('IKindDevelop').AsInteger = 3 then begin
    db.Canvas.Font.Color := TColor(clBlue);
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCCJSO_VersionContent.GridContentListDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if not db.DataSource.DataSet.FieldByName('bDeveloped').AsBoolean then begin
    db.Canvas.Font.Color := TColor(clRed);
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

end.
