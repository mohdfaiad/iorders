unit CCJSO_Version;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ActnList, DB, ADODB,
  UCCenterJournalNetZkz, ToolWin, ComCtrls;

type
  TfrmCCJSO_Version = class(TForm)
    pnlName: TPanel;
    pnlVersion: TPanel;
    aList: TActionList;
    aExit: TAction;
    pnlAlarm: TPanel;
    pnlVersionTool: TPanel;
    pnlVersionShow: TPanel;
    tbarVersion: TToolBar;
    aContents: TAction;
    tbtnVersion_Contents: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aContentsExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActive : integer;
    UserSession : TUserSession;
    NewVersion  : string;
    procedure ShowGets;
    function  GetSignCorrectVersion : boolean;
  public
    { Public declarations }
    procedure SetUserSession(Parm : TUserSession);
  end;

var
  frmCCJSO_Version: TfrmCCJSO_Version;

implementation

uses
  UMain, CCJSO_DM, CCJSO_VersionContent;

{$R *.dfm}

procedure TfrmCCJSO_Version.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
end;

procedure TfrmCCJSO_Version.FormActivate(Sender: TObject);
begin
 if ISignActive = 0 then begin
   { Иконка формы }
   FCCenterJournalNetZkz.imgMain.GetIcon(337,self.Icon);
   pnlVersionShow.Caption := 'Версия от ' + cJSOCurrentVertion;
   { Проверка актуальной версии }
   if not GetSignCorrectVersion then begin
     pnlAlarm.Visible := true;
     pnlAlarm.Caption := 'Новая версия от ' + NewVersion;
   end else pnlAlarm.Visible := false;
   { Форма активна }
   ISignActive := 1;
   ShowGets;
 end;
end;

procedure TfrmCCJSO_Version.SetUserSession(Parm : TUserSession); begin UserSession := Parm; end;

function TfrmCCJSO_Version.GetSignCorrectVersion : boolean;
var
  bRet : boolean;
  IErr : integer;
  SVal : string;
begin
  bRet := true;
  try
    DM_CCJSO.spGetParm.Parameters.ParamValues['@CodeParm'] := 'JSO_VersionDateTime';
    DM_CCJSO.spGetParm.Parameters.ParamValues['@USER'] := UserSession.CurrentUser;
    DM_CCJSO.spGetParm.ExecProc;
    IErr := DM_CCJSO.spGetParm.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      SVal := DM_CCJSO.spGetParm.Parameters.ParamValues['@SVal'];
      NewVersion := SVal;
      if SVal <> cJSOCurrentVertion then bRet := false;
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
  result := bRet;
end;

procedure TfrmCCJSO_Version.ShowGets;
begin
  if ISignActive = 0 then begin
  end;
end;

procedure TfrmCCJSO_Version.aExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmCCJSO_Version.aContentsExecute(Sender: TObject);
begin
  try
    frmCCJSO_VersionContent := TfrmCCJSO_VersionContent.Create(Self);
    try
      frmCCJSO_VersionContent.ShowModal;
    finally
      FreeAndNil(frmCCJSO_VersionContent);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

end.
