unit CCJSO_RefUsers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UCCenterJournalNetZkz, Grids, DBGrids, ComCtrls, ExtCtrls,
  ActnList, StdCtrls, ToolWin, DB, ADODB, Menus;

  type TRecRefUsers = record
    NRN            : integer;
    SUSERS         : string;
    SUser          : string;
    NUpdateBase    : real;
    SPasw          : string;
    IPr_User_ID    : integer;
    IFlag_Kol      : integer;
    NUser_Role     : real;
    NUser_Role1    : real;
    NUser_Role_Voz : integer;
    NEmploee       : integer;
    SEmploeeRU     : string;
    SEmploeeUA     : string;
    SCheckDate     : string;
  end;

type
  TfrmCCJSO_RefUsers = class(TForm)
    pnlCond: TPanel;
    pnlcond_Tool: TPanel;
    pnlCond_Parm: TPanel;
    pnlControl: TPanel;
    pnlControl_Show: TPanel;
    pnlControl_Tool: TPanel;
    pnlStatus: TPanel;
    statusBar: TStatusBar;
    pnlGrid: TPanel;
    MainGrid: TDBGrid;
    aList: TActionList;
    aExit: TAction;
    aUserAdd: TAction;
    aUserEdit: TAction;
    aUserPasw: TAction;
    aUserDel: TAction;
    aClearCond: TAction;
    TollBar: TToolBar;
    tbtnUserAdd: TToolButton;
    tbtnUserEdit: TToolButton;
    tbtnUserPasw: TToolButton;
    tbtnUserDel: TToolButton;
    tBarCond: TToolBar;
    tbtnCondClear: TToolButton;
    lblCondUser: TLabel;
    edCondUser: TEdit;
    qrspMain: TADOStoredProc;
    dsMain: TDataSource;
    pmMain: TPopupMenu;
    pmiMain_UserAdd: TMenuItem;
    pmiMain_UserEdit: TMenuItem;
    pmiMain_UserPasw: TMenuItem;
    pmiMain_UserDel: TMenuItem;
    pmiMain_Delemiter: TMenuItem;
    pmiMain_ClearCond: TMenuItem;
    aRefresh: TAction;
    aCondChangeFields: TAction;
    pmiMain_Refresh: TMenuItem;
    tbtnRefresh: TToolButton;
    pnlLocate: TPanel;
    spRefUser_Delete: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aUserAddExecute(Sender: TObject);
    procedure aUserEditExecute(Sender: TObject);
    procedure aUserPaswExecute(Sender: TObject);
    procedure aClearCondExecute(Sender: TObject);
    procedure aUserDelExecute(Sender: TObject);
    procedure MainGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aRefreshExecute(Sender: TObject);
    procedure aCondChangeFieldsExecute(Sender: TObject);
    procedure MainGridDblClick(Sender: TObject);
    procedure MainGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MainGridKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    bSignActive : boolean;
    RecSession  : TUserSession;
    RecRefUsers : TRecRefUsers;
    LocateName  : string;
    procedure ShowGets;
    procedure ExecConditionQRMain;
    procedure CreateConditionQRMain;
    procedure RefreshQRMain;
    procedure SetClearCondition;
    procedure SetRecItem;
    function  GetStateClearMainCondition : boolean;
  public
    { Public declarations }
    procedure SetRecSession(Parm : TUserSession);
  end;

var
  frmCCJSO_RefUsers: TfrmCCJSO_RefUsers;

implementation

uses
  UMAIN, Util, CCJSO_RefUser_Set;

{$R *.dfm}

procedure TfrmCCJSO_RefUsers.FormCreate(Sender: TObject);
begin
  { Инициализация }
  bSignActive       := false;
  LocateName        := '';
  pnlLocate.Visible := false;
end;

procedure TfrmCCJSO_RefUsers.FormActivate(Sender: TObject);
begin
  if not bSignActive then begin
    { Инциализация }
    ExecConditionQRMain;
    MainGrid.SetFocus;
    { Форма активна }
    bSignActive := true;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_RefUsers.ShowGets;
var
  SCaption : string;
begin
  if bSignActive then begin
    { Доступ к очистке условий отбора }
    if GetStateClearMainCondition
      then aClearCond.Enabled := false
      else aClearCond.Enabled := true;
    { Доступ к действиям по формированию данных }
    if not qrspMain.IsEmpty then begin
      aUserEdit.Enabled :=  true;
      aUserPasw.Enabled :=  true;
      aUserDel.Enabled  :=  true;
    end else begin
      aUserEdit.Enabled :=  false;
      aUserPasw.Enabled :=  false;
      aUserDel.Enabled  :=  false;
    end;
    { Количество записей }
    SCaption := VarToStr(qrspMain.RecordCount);
    pnlControl_Show.Caption := SCaption;
    pnlControl_Show.Width := TextPixWidth(SCaption, pnlControl_Show.Font) + 20;
  end;
end;

procedure TfrmCCJSO_RefUsers.SetRecSession(Parm : TUserSession); begin RecSession := Parm; end;

procedure TfrmCCJSO_RefUsers.ExecConditionQRMain;
var
  RN: Integer;
begin
  if not qrspMain.IsEmpty then RN := qrspMain.FieldByName('NRN').AsInteger else RN := -1;
  qrspMain.Active := false;
  CreateConditionQRMain;
  qrspMain.Active := true;
  qrspMain.Locate('NRN', RN, []);
end;

procedure TfrmCCJSO_RefUsers.CreateConditionQRMain;
begin
  qrspMain.Parameters.ParamValues['@User'] := edCondUser.Text;
end;

procedure TfrmCCJSO_RefUsers.RefreshQRMain;
var
  RN: Integer;
begin
  if not qrspMain.IsEmpty then RN := qrspMain.FieldByName('NRN').AsInteger else RN := -1;
  qrspMain.Requery;
  qrspMain.Locate('NRN', RN, []);
end;

function  TfrmCCJSO_RefUsers.GetStateClearMainCondition : boolean;
var bResReturn : boolean;
begin
  if     (length(trim(edCondUser.Text)) = 0)
  then bResReturn := true
  else bResReturn := false;
  result := bResReturn;
end;

procedure TfrmCCJSO_RefUsers.SetClearCondition;
begin
  edCondUser.Text := '';
end;

procedure TfrmCCJSO_RefUsers.SetRecItem;
begin
  with RecRefUsers do begin
    NRN            := MainGrid.DataSource.DataSet.FieldByName('NRN').AsInteger;
    SUSERS         := MainGrid.DataSource.DataSet.FieldByName('SUSERS').AsString;
    SUser          := MainGrid.DataSource.DataSet.FieldByName('SUser').AsString;
    NUpdateBase    := MainGrid.DataSource.DataSet.FieldByName('NUpdateBase').AsFloat;
    SPasw          := MainGrid.DataSource.DataSet.FieldByName('SPasw').AsString;
    IPr_User_ID    := MainGrid.DataSource.DataSet.FieldByName('IPr_User_ID').AsInteger;
    IFlag_Kol      := MainGrid.DataSource.DataSet.FieldByName('IFlag_Kol').AsInteger;
    NUser_Role     := MainGrid.DataSource.DataSet.FieldByName('NUser_Role').AsFloat;
    NUser_Role1    := MainGrid.DataSource.DataSet.FieldByName('NUser_Role1').AsFloat;
    NUser_Role_Voz := MainGrid.DataSource.DataSet.FieldByName('NUser_Role_Voz').AsInteger;
    NEmploee       := MainGrid.DataSource.DataSet.FieldByName('NEmploee').AsInteger;
    SEmploeeRU     := MainGrid.DataSource.DataSet.FieldByName('SEmploeeRU').AsString;
    SEmploeeUA     := MainGrid.DataSource.DataSet.FieldByName('SEmploeeUA').AsString;
    SCheckDate     := MainGrid.DataSource.DataSet.FieldByName('SCheckDate').AsString;
  end;
end;

procedure TfrmCCJSO_RefUsers.aExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJSO_RefUsers.aUserAddExecute(Sender: TObject);
begin
  try
    SetRecItem;
    frmCCJSO_RefUser_Set := TfrmCCJSO_RefUser_Set.Create(Self);
    frmCCJSO_RefUser_Set.SetRecSession(RecSession);
    frmCCJSO_RefUser_Set.SetMode(cFRefUserSet_Add);
    try
      frmCCJSO_RefUser_Set.ShowModal;
      ShowGets;
    finally
      frmCCJSO_RefUser_Set.Free;
    end;
    RefreshQRMain;
    ShowGets;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TfrmCCJSO_RefUsers.aUserEditExecute(Sender: TObject);
begin
  try
    SetRecItem;
    frmCCJSO_RefUser_Set := TfrmCCJSO_RefUser_Set.Create(Self);
    frmCCJSO_RefUser_Set.SetRecSession(RecSession);
    frmCCJSO_RefUser_Set.SetMode(cFRefUserSet_Edit);
    frmCCJSO_RefUser_Set.SerRecRefUsers(RecRefUsers);
    try
      frmCCJSO_RefUser_Set.ShowModal;
      ShowGets;
    finally
      frmCCJSO_RefUser_Set.Free;
    end;
    RefreshQRMain;
    ShowGets;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TfrmCCJSO_RefUsers.aUserPaswExecute(Sender: TObject);
begin
//
end;

procedure TfrmCCJSO_RefUsers.aClearCondExecute(Sender: TObject);
begin
  SetClearCondition;
  ExecConditionQRMain;
  ShowGets;
end;

procedure TfrmCCJSO_RefUsers.aUserDelExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if MessageDLG('Подтвердите выполнение действия.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  IErr := 0;
  SErr := '';
  try
    SetRecItem;
    spRefUser_Delete.Parameters.ParamValues['@USER'] := RecSession.CurrentUser;
    spRefUser_Delete.Parameters.ParamValues['@RN']   := RecRefUsers.NRN;
    spRefUser_Delete.ExecProc;
    IErr := spRefUser_Delete.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <>0 then begin
      SErr := spRefUser_Delete.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  except
    on e:Exception do begin
      ShowMessage(e.Message);
    end;
  end;
  RefreshQRMain;
  ShowGets;
end;

procedure TfrmCCJSO_RefUsers.MainGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TfrmCCJSO_RefUsers.aRefreshExecute(Sender: TObject);
begin
  RefreshQRMain;
  ShowGets;
end;

procedure TfrmCCJSO_RefUsers.aCondChangeFieldsExecute(Sender: TObject);
begin
  if bSignActive then begin
    ExecConditionQRMain;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_RefUsers.MainGridDblClick(Sender: TObject);
begin
  if not qrspMain.IsEmpty then begin
    aUserEdit.Execute;
  end;
end;

procedure TfrmCCJSO_RefUsers.MainGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key in [27,37,38,39,40,13] then begin
    LocateName := '';
    pnlLocate.Visible := false;
  end;
end;

procedure TfrmCCJSO_RefUsers.MainGridKeyPress(Sender: TObject; var Key: Char);
var
  S : String;
begin
  S := AnsiUpperCase(LocateName + Key);
  if MainGrid.DataSource.DataSet.Locate('SUser',AnsiLowerCase(S),[loCaseInsensitive,loPartialKey]) then begin
    LocateName := S;
    pnlLocate.Width := TextPixWidth(LocateName, pnlLocate.Font) + 40;
    pnlLocate.Caption := LocateName;
    pnlLocate.Left := MainGrid.Width - pnlLocate.Width - 30;
    pnlLocate.Visible := true;
  end;
end;

end.
