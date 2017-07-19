unit CCJSO_RefUser_Set;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CCJSO_RefUsers, UCCenterJournalNetZkz, ActnList, ExtCtrls,
  ToolWin, ComCtrls, StdCtrls, DB, ADODB;

type
  TfrmCCJSO_RefUser_Set = class(TForm)
    pnlControl: TPanel;
    pnlFields: TPanel;
    aList: TActionList;
    aSave: TAction;
    aExit: TAction;
    pnlControl_Tool: TPanel;
    pnlControl_Show: TPanel;
    tbarTool: TToolBar;
    tbtnTool_Save: TToolButton;
    tbtnTool_Exit: TToolButton;
    lblUserApp: TLabel;
    lblUserGamma: TLabel;
    edUserApp: TEdit;
    edUserGamma: TEdit;
    aSlUserGamma: TAction;
    btnSlUserGamma: TButton;
    aValFieldsChange: TAction;
    spRefUser_Update: TADOStoredProc;
    spRefUser_Insert: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aSlUserGammaExecute(Sender: TObject);
    procedure aValFieldsChangeExecute(Sender: TObject);
    procedure aSaveExecute(Sender: TObject);
  private
    { Private declarations }
    bSignActive : boolean;
    Mode        : integer;
    RecRefUsers : TRecRefUsers;
    RecSession  : TUserSession;
    procedure ShowGets;
    procedure RefUser_Update;
    procedure RefUser_Insert;
  public
    { Public declarations }
    procedure SetMode(Parm : integer);
    procedure SerRecRefUsers(Parm : TRecRefUsers);
    procedure SetRecSession(Parm : TUserSession);
  end;

const
  cFRefUserSet_Add  = 0;
  cFRefUserSet_Edit = 1;

var
  frmCCJSO_RefUser_Set: TfrmCCJSO_RefUser_Set;

implementation

uses UMAIN, UReference;

{$R *.dfm}

procedure TfrmCCJSO_RefUser_Set.FormCreate(Sender: TObject);
begin
  { Инициализация }
  bSignActive := false;
  Mode := cFRefUserSet_Add;
end;

procedure TfrmCCJSO_RefUser_Set.FormActivate(Sender: TObject);
begin
  if not bSignActive then begin
    { Иконка и заголовок формы }
    case Mode of
      cFRefUserSet_Add: begin
        FCCenterJournalNetZkz.imgMain.GetIcon(375,self.Icon);
        self.Caption := 'Пользователь приложения (добавление)'
      end;
      cFRefUserSet_Edit: begin
        FCCenterJournalNetZkz.imgMain.GetIcon(377,self.Icon);
        self.Caption := 'Пользователь приложения (исправление)'
      end;
    end;
    { Инициализация }
    if Mode = cFRefUserSet_Edit then begin
      edUserApp.Text := RecRefUsers.SUser;
      edUserGamma.Text := RecRefUsers.SEmploeeRU;
    end;
    { Форма активна }
    bSignActive := true;
    showGets;
  end;
end;

procedure TfrmCCJSO_RefUser_Set.ShowGets;
begin
  if bSignActive then begin
    { Подсветка пустых значений }
    if length(trim(edUserApp.Text)) = 0
      then edUserApp.Color := clYellow
      else edUserApp.Color := clWindow;
    { Управление доступом к действиям }
    if (length(trim(edUserApp.Text)) = 0)
      then aSave.Enabled := false
      else aSave.Enabled := true;
  end;
end;

procedure TfrmCCJSO_RefUser_Set.SetMode(Parm : integer); begin Mode := Parm; end;
procedure TfrmCCJSO_RefUser_Set.SerRecRefUsers(Parm : TRecRefUsers); begin RecRefUsers := Parm; end;
procedure TfrmCCJSO_RefUser_Set.SetRecSession(Parm : TUserSession); begin RecSession := Parm; end;

procedure TfrmCCJSO_RefUser_Set.RefUser_Update;
var
  IErr : integer;
  SErr : string;
begin
  IErr := 0;
  SErr := '';
  try
    spRefUser_Update.Parameters.ParamValues['@USER']     := RecSession.CurrentUser;
    spRefUser_Update.Parameters.ParamValues['@RN']       := RecRefUsers.NRN;
    spRefUser_Update.Parameters.ParamValues['@UserApp']  := edUserApp.Text;
    spRefUser_Update.Parameters.ParamValues['@Employee'] := RecRefUsers.NEmploee;
    spRefUser_Update.ExecProc;
    IErr := spRefUser_Update.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <>0 then begin
      SErr := spRefUser_Update.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end else begin
      self.Close;
    end;
  except
    on e:Exception do begin
      ShowMessage(e.Message);
    end;
  end;
end;

procedure TfrmCCJSO_RefUser_Set.RefUser_Insert;
var
  IErr : integer;
  SErr : string;
begin
  IErr := 0;
  SErr := '';
  try
    spRefUser_Insert.Parameters.ParamValues['@USER']     := RecSession.CurrentUser;
    spRefUser_Insert.Parameters.ParamValues['@UserApp']  := edUserApp.Text;
    spRefUser_Insert.Parameters.ParamValues['@Employee'] := RecRefUsers.NEmploee;
    spRefUser_Insert.ExecProc;
    IErr := spRefUser_Insert.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <>0 then begin
      SErr := spRefUser_Insert.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end else begin
      self.Close;
    end;
  except
    on e:Exception do begin
      ShowMessage(e.Message);
    end;
  end;
end;
procedure TfrmCCJSO_RefUser_Set.aSaveExecute(Sender: TObject);
begin
  if MessageDLG('Подтвердите выполнение действия.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  case Mode of
    cFRefUserSet_Add: begin
      RefUser_Insert;
    end;
    cFRefUserSet_Edit: begin
      RefUser_Update;
    end;
  end;
end;

procedure TfrmCCJSO_RefUser_Set.aExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJSO_RefUser_Set.aSlUserGammaExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  DescrSelect := '';
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFReferenceUserGamma);
   frmReference.SetReadOnly(cFReferenceYesReadOnly);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if length(DescrSelect) > 0 then begin
      edUserGamma.Text       := DescrSelect;
      RecRefUsers.SEmploeeRU := DescrSelect;
      RecRefUsers.NEmploee   := frmReference.GetRowIDSelect;
    end;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJSO_RefUser_Set.aValFieldsChangeExecute(Sender: TObject);
begin
  ShowGets;
end;

end.
