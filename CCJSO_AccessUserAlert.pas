unit CCJSO_AccessUserAlert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, ToolWin, ComCtrls, ExtCtrls, CheckLst,
  ActnList;

type
  TfrmCCJSO_AccessUserAlert = class(TForm)
    pnlControl: TPanel;
    pnlControl_Tool: TPanel;
    pnlControl_Show: TPanel;
    tbarControl: TToolBar;
    pnlMain: TPanel;
    lblCheckShowAlert: TLabel;
    spDSRefAlertType: TADOStoredProc;
    spAlertTypeAccessCheck: TADOStoredProc;
    chListBox: TCheckListBox;
    aList: TActionList;
    aExit: TAction;
    aSaveSet: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    spSelectList_Insert: TADOStoredProc;
    spSelectList_Clear: TADOStoredProc;
    spAlertTypeSetAccess: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aSaveSetExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActivate  : integer;
    IdUserAction   : longint;
    NUSER          : integer;
    procedure ShowGets;
  public
    { Public declarations }
    procedure SetUser(Parm : integer);
  end;

var
  frmCCJSO_AccessUserAlert: TfrmCCJSO_AccessUserAlert;

implementation

uses UMain, UCCenterJournalNetZkz;

{$R *.dfm}

procedure TfrmCCJSO_AccessUserAlert.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActivate := 0;
end;

procedure TfrmCCJSO_AccessUserAlert.FormActivate(Sender: TObject);
var
  CheckAccess : integer;
begin
  if ISignActivate = 0 then begin
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(330,self.Icon);
    { Уникальный идентификатор действия }
    IdUserAction := FCCenterJournalNetZkz.GetIdUserAction;
    { Формируем список типов уведомлений }
    try
      chListBox.Clear;
      if spDSRefAlertType.Active then spDSRefAlertType.Active := false;
      spDSRefAlertType.Parameters.ParamValues['@Descr'] := '';
      spDSRefAlertType.Open;
      spDSRefAlertType.First;
      while not spDSRefAlertType.Eof do begin
        chListBox.Items.AddObject
         (
          spDSRefAlertType.FieldByName('Descr').AsString,
          TObject(spDSRefAlertType.FieldByName('row_id').AsInteger)
         );
        { Смотрим наличие доступа к показу уведомления }
        CheckAccess := 0;
        spAlertTypeAccessCheck.Parameters.ParamValues['@AlertType'] := spDSRefAlertType.FieldByName('row_id').AsInteger;
        spAlertTypeAccessCheck.Parameters.ParamValues['@USER'] := NUSER;
        spAlertTypeAccessCheck.ExecProc;
        CheckAccess := spAlertTypeAccessCheck.Parameters.ParamValues['@Check'];
        if CheckAccess = 1 then begin
          chListBox.Checked[chListBox.Count-1] := true;
        end;
        spDSRefAlertType.Next;
      end;
    except
      on e:Exception do begin
        ShowMessage('Сбой при загрузке прав доступа.' + chr(10) + e.Message);
      end;
    end;
    { Форма активна }
    ISignActivate := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_AccessUserAlert.ShowGets;
begin
  if ISignActivate = 1 then begin
  end;
end;

procedure TfrmCCJSO_AccessUserAlert.SetUser(Parm : integer); begin NUSER := Parm; end;

procedure TfrmCCJSO_AccessUserAlert.aExitExecute(Sender: TObject);
begin
  { Чистим список выбранных типов уведоилений }
  spSelectList_Clear.Parameters.ParamValues['@IDENT'] := IdUserAction;
  spSelectList_Clear.ExecProc;
  Self.Close;
end;

procedure TfrmCCJSO_AccessUserAlert.aSaveSetExecute(Sender: TObject);
var
  iListBoxItems        : integer;
begin
  try
    { Фиксируем выбранные типы уведомлений }
    spDSRefAlertType.First;
    while not spDSRefAlertType.Eof do begin
      iListBoxItems := chListBox.Items.IndexOfObject( TObject(spDSRefAlertType.FieldByName('row_id').AsInteger) );
      if chListBox.Checked[iListBoxItems] then begin
        spSelectList_Insert.Parameters.ParamValues['@IDENT']     := IdUserAction;
        spSelectList_Insert.Parameters.ParamValues['@SUnitCode'] := 'JSO_RefAlertType';
        spSelectList_Insert.Parameters.ParamValues['@PRN']       := spDSRefAlertType.FieldByName('row_id').AsInteger;
        spSelectList_Insert.Parameters.ParamValues['@BigPRN']    := 0;
        spSelectList_Insert.Parameters.ParamValues['@USER']      := NUSER;
        spSelectList_Insert.ExecProc;
      end;
      spDSRefAlertType.Next;
    end;
    { Установка доступа к раздаче уведомлений пользователю }
    spAlertTypeSetAccess.Parameters.ParamValues['@IDENT'] := IdUserAction;
    spAlertTypeSetAccess.Parameters.ParamValues['@USER']  := NUSER;
    spAlertTypeSetAccess.ExecProc;
    { Чистим список выбранных типов уведоилений }
    spSelectList_Clear.Parameters.ParamValues['@IDENT'] := IdUserAction;
    spSelectList_Clear.ExecProc;
    Self.Close;
  except
    on e:Exception do begin
      ShowMessage('Сбой при формировании списка групп аптек.' + chr(10) + e.Message);
    end;
  end;
end;

end.
