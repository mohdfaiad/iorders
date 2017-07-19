unit CC_BlackListJournal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ActnList, StdCtrls, ComCtrls, ToolWin, Grids, DBGrids,
  DB, ADODB;

type
  TfrmCC_BlackListJournal = class(TForm)
    pnlSearch: TPanel;
    pnlTool: TPanel;
    pnlGridMain: TPanel;
    splitGridMain: TSplitter;
    pnlGridSlave: TPanel;
    pnlGridSlave_Tool: TPanel;
    pnlSearch_Fields: TPanel;
    pnlSearch_Tool: TPanel;
    pnlTool_Control: TPanel;
    pnlGridSlave_Tool_Show: TPanel;
    pnlGridSlave_Tool_Control: TPanel;
    pnlTool_Show: TPanel;
    aList: TActionList;
    aClose: TAction;
    aSearchClear: TAction;
    tBarSearch: TToolBar;
    tbtnSearch_Clear: TToolButton;
    lblSearch_Phone: TLabel;
    edSearch_Phone: TEdit;
    lblSearch_Client: TLabel;
    edSearch_Client: TEdit;
    lblSearch_City: TLabel;
    edSearch_City: TEdit;
    GridMain: TDBGrid;
    GridSlave: TDBGrid;
    aSearchChangeFields: TAction;
    dsMain: TDataSource;
    spdsMain: TADOStoredProc;
    spdsSlave: TADOStoredProc;
    dsSlave: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aCloseExecute(Sender: TObject);
    procedure aSearchClearExecute(Sender: TObject);
    procedure aSearchChangeFieldsExecute(Sender: TObject);
    procedure dsMainDataChange(Sender: TObject; Field: TField);
    procedure GridMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridSlaveDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    ISignActive : integer;
    procedure ShowGets;
    procedure CreateConditionMain;
    procedure ExecConditionMain;
    procedure SetClearSearch;
    function GetSearchStateClear : boolean;
  public
    { Public declarations }
  end;

var
  frmCC_BlackListJournal: TfrmCC_BlackListJournal;

implementation

uses
  UMAIN, UCCenterJournalNetZkz, CCJSO_DM, Util;

{$R *.dfm}

procedure TfrmCC_BlackListJournal.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
end;

procedure TfrmCC_BlackListJournal.FormActivate(Sender: TObject);
begin
  if ISignActive = 0 then begin
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(354,self.Icon);
    { Данные }
    ExecConditionMain;
    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

function TfrmCC_BlackListJournal.GetSearchStateClear : boolean;
var
  bVal : boolean;
begin
  bVal := false;
  if    (length(edSearch_Phone.Text)  = 0)
    and (length(edSearch_Client.Text) = 0)
    and (length(edSearch_City.Text)   = 0)
  then bVal := true
  else bVal := false;
  result := bVal;
end;

procedure TfrmCC_BlackListJournal.SetClearSearch;
begin
  edSearch_Phone.Text  := '';
  edSearch_Client.Text := '';
  edSearch_City.Text   := '';
end;

procedure TfrmCC_BlackListJournal.CreateConditionMain;
begin
  spdsMain.Parameters.ParamByName('@Phone').Value  := edSearch_Phone.Text;
  spdsMain.Parameters.ParamByName('@Client').Value := edSearch_Client.Text;
  spdsMain.Parameters.ParamByName('@City').Value   := edSearch_City.Text;
end;

procedure TfrmCC_BlackListJournal.ExecConditionMain;
var
  RN : Integer;
begin
  if not spdsMain.IsEmpty then RN := spdsMain.FieldByName('NRN').AsInteger else RN := -1;
  spdsMain.Active := false;
  CreateConditionMain;
  spdsMain.Active := true;
  spdsMain.Locate('NRN', RN, []);
end;

procedure TfrmCC_BlackListJournal.ShowGets;
var
  SCaption : string;
begin
  if ISignActive = 1 then begin
    { Доступ к очистке условия отбора }
    if GetSearchStateClear then aSearchClear.Enabled := false else aSearchClear.Enabled := true;
    { Отображение количества позиций }
    SCaption := VarToStr(spdsMain.RecordCount);
    pnlTool_Show.Caption := SCaption;
    pnlTool_Show.Width := TextPixWidth(SCaption, pnlTool_Show.Font) + 20;
    SCaption := VarToStr(spdsSlave.RecordCount);
    pnlGridSlave_Tool_Show.Caption := SCaption;
    pnlGridSlave_Tool_Show.Width := TextPixWidth(SCaption, pnlGridSlave_Tool_Show.Font) + 20;
  end;
end;

procedure TfrmCC_BlackListJournal.aCloseExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCC_BlackListJournal.aSearchClearExecute(Sender: TObject);
begin
  SetClearSearch;
  ExecConditionMain;
  ShowGets;
end;

procedure TfrmCC_BlackListJournal.aSearchChangeFieldsExecute(Sender: TObject);
begin
  if ISignActive = 1 then begin
    { Формируем условие отбора }
    ExecConditionMain;
    ShowGets;
  end;
end;

procedure TfrmCC_BlackListJournal.dsMainDataChange(Sender: TObject; Field: TField);
begin
  if GridMain.DataSource.DataSet.IsEmpty then begin
    spdsSlave.Active := false;
    spdsSlave.Parameters.ParamByName('@PRN').Value := 0;
    spdsSlave.Active := true;
  end else begin
    spdsSlave.Active := false;
    spdsSlave.Parameters.ParamByName('@PRN').Value := GridMain.DataSource.DataSet.FieldByName('NRN').AsInteger;
    spdsSlave.Active := true;
  end;
end;

procedure TfrmCC_BlackListJournal.GridMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCC_BlackListJournal.GridSlaveDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

end.
