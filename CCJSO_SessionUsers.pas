unit CCJSO_SessionUsers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ComCtrls, ToolWin, StdCtrls, ExtCtrls, ActnList,
  DB, ADODB;

type
  TfrmCCJSO_SessionUser = class(TForm)
    pnlCondition: TPanel;
    lblCndDatePeriod_with: TLabel;
    lblCndDatePeriod_toOn: TLabel;
    lblCnd_User: TLabel;
    dtCndBegin: TDateTimePicker;
    dtCndEnd: TDateTimePicker;
    edCnd_User: TEdit;
    btnCnd_User: TButton;
    pnlTool: TPanel;
    pnlTool_Show: TPanel;
    pnlTool_Bar: TPanel;
    toolBar: TToolBar;
    tbtnRefresh: TToolButton;
    tbtnClearCondition: TToolButton;
    pnlGrid: TPanel;
    GridJA: TDBGrid;
    aList: TActionList;
    aCondition: TAction;
    aCnd_ChooseUser: TAction;
    aRefresh: TAction;
    aClearCondition: TAction;
    aExit: TAction;
    spRegActiveUser: TADOStoredProc;
    dsRegActiveUser: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aClearConditionExecute(Sender: TObject);
    procedure aConditionExecute(Sender: TObject);
    procedure aCnd_ChooseUserExecute(Sender: TObject);
    procedure edCnd_UserDblClick(Sender: TObject);
    procedure GridJADrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    ISignActivate  : integer;
    NChooseUser    : integer;
    procedure ShowGets;
    procedure ExecCondition;
    procedure CreateCondition;
    procedure GridRefresh;
    function  GetStateClearCondition : boolean;
  public
    { Public declarations }
  end;

var
  frmCCJSO_SessionUser: TfrmCCJSO_SessionUser;

implementation

uses
  UMain, DateUtils, Util,
  UCCenterJournalNetZkz, UReference;

{$R *.dfm}

procedure TfrmCCJSO_SessionUser.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActivate := 0;
  dtCndBegin.Date  := date;
  dtCndEnd.Date    := date;
  NChooseUser      := 0;
end;

procedure TfrmCCJSO_SessionUser.FormActivate(Sender: TObject);
begin
  if ISignActivate = 0 then begin
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(318,self.Icon);
    { Форма активна }
    ISignActivate := 1;
    ExecCondition;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_SessionUser.ShowGets;
var
  SCaption : string;
begin
  if ISignActivate = 1 then begin
    { Количество записей }
    SCaption := VarToStr(spRegActiveUser.RecordCount);
    pnlTool_Show.Caption := SCaption; pnlTool_Show.Width := TextPixWidth(SCaption, pnlTool_Show.Font) + 20;
    { Доступ к очистке условий отбора }
    if GetStateClearCondition
      then aClearCondition.Enabled := false
      else aClearCondition.Enabled := true;
  end;
end;

procedure TfrmCCJSO_SessionUser.aExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJSO_SessionUser.aRefreshExecute(Sender: TObject);
begin
  GridRefresh;
  ShowGets;
end;

procedure TfrmCCJSO_SessionUser.aClearConditionExecute(Sender: TObject);
begin
  edCnd_User.Text := '';
  NChooseUser := 0;
  ExecCondition;
  ShowGets;
end;

procedure TfrmCCJSO_SessionUser.aConditionExecute(Sender: TObject);
begin
  if ISignActivate = 1 then begin
    ExecCondition;
  end;
end;

procedure TfrmCCJSO_SessionUser.aCnd_ChooseUserExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  DescrSelect := '';
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFReferenceUserAva);
   frmReference.SetReadOnly(cFReferenceYesReadOnly);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if length(DescrSelect) > 0 then begin
      NChooseUser := frmReference.GetRowIDSelect;
      edCnd_User.Text := DescrSelect;
    end;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJSO_SessionUser.edCnd_UserDblClick(Sender: TObject);
begin
  aCnd_ChooseUser.Execute;
end;

procedure TfrmCCJSO_SessionUser.GridJADrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TfrmCCJSO_SessionUser.ExecCondition;
var
  RN: int64;
begin
  if not spRegActiveUser.IsEmpty then RN := spRegActiveUser.FieldByName('NRN').AsInteger else RN := -1;
  if spRegActiveUser.Active then spRegActiveUser.Active := false;
  CreateCondition;
  spRegActiveUser.Active := true;
  spRegActiveUser.Locate('NRN', RN, []);
  ShowGets;
end;

procedure TfrmCCJSO_SessionUser.CreateCondition;
begin
  spRegActiveUser.Parameters.ParamValues['@USER']  := NChooseUser;
  spRegActiveUser.Parameters.ParamValues['@Begin'] := FormatDateTime('yyyy-mm-dd', dtCndBegin.Date);
  spRegActiveUser.Parameters.ParamValues['@End']   := FormatDateTime('yyyy-mm-dd', IncDay(dtCndEnd.Date,1));
end;

procedure TfrmCCJSO_SessionUser.GridRefresh;
var
  RN: int64;
begin
  if not spRegActiveUser.IsEmpty then RN := spRegActiveUser.FieldByName('NRN').AsInteger else RN := -1;
  spRegActiveUser.Requery;
  spRegActiveUser.Locate('NRN', RN, []);
end;

function  TfrmCCJSO_SessionUser.GetStateClearCondition : boolean;
var bResReturn : boolean;
begin
  if     (length(trim(edCnd_User.Text)) = 0)
     and (NChooseUser                   = 0)
  then bResReturn := true
  else bResReturn := false;
  result := bResReturn;
end;


end.
