unit CCJAL_CreateUserMsg;

{***********************************************
 * © PgkSoft 05.10.2015
 * Журнал интернет заказов
 * Механизм <Центр уведомлений>
 * Создание пользовательского уведомления
 ***********************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ToolWin, ComCtrls, ActnList, DB, ADODB;

type
  TfrmCCJAL_CreateUserMsg = class(TForm)
    pnlTop: TPanel;
    pnlControl: TPanel;
    pnlControl_Tool: TPanel;
    pnlControl_Show: TPanel;
    pnlParm: TPanel;
    ActionList: TActionList;
    tbarControl: TToolBar;
    rgrpWhom: TRadioGroup;
    lblWhom: TLabel;
    lblTopic: TLabel;
    lblContent: TLabel;
    edWhom: TEdit;
    edTopic: TEdit;
    edContent: TMemo;
    aChooseUser: TAction;
    aChooseTopic: TAction;
    aCreate: TAction;
    aExit: TAction;
    tbtnControl_Create: TToolButton;
    tbtnControl_Exit: TToolButton;
    btnChooseUser: TButton;
    btnChooseTopic: TButton;
    spCreate: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure rgrpWhomClick(Sender: TObject);
    procedure edWhomChange(Sender: TObject);
    procedure edTopicChange(Sender: TObject);
    procedure edContentChange(Sender: TObject);
    procedure aChooseUserExecute(Sender: TObject);
    procedure aChooseTopicExecute(Sender: TObject);
    procedure edWhomDblClick(Sender: TObject);
    procedure edTopicDblClick(Sender: TObject);
    procedure aCreateExecute(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActivate  : integer;
    NUSER          : integer;
    SUSER          : string;
    NChooseUser    : integer;
    NChooseTopic   : integer;
    procedure ShowGets;
  public
    { Public declarations }
    procedure SetUser(NParm : integer; SParm : string);
  end;

var
  frmCCJAL_CreateUserMsg: TfrmCCJAL_CreateUserMsg;

implementation

uses
  UMain, UCCenterJournalNetZkz, UReference;

{$R *.dfm}

procedure TfrmCCJAL_CreateUserMsg.FormCreate(Sender: TObject);
begin
  ISignActivate := 0;
  NChooseUser   := 0;
  NChooseTopic  := 0;
end;

procedure TfrmCCJAL_CreateUserMsg.FormActivate(Sender: TObject);
begin
  if ISignActivate = 0 then begin
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(322,self.Icon);
    { Инициализация }
    pnlTop.Caption := 'От пользователя: ' + SUSER;
    { Форма активна }
    ISignActivate := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJAL_CreateUserMsg.ShowGets;
  procedure Whom(Enb : boolean); begin
   lblWhom.Enabled       := Enb;
   edWhom.Enabled        := Enb;
   aChooseUser.Enabled   := Enb;
   btnChooseUser.Enabled := Enb;
   if not Enb then begin
     edWhom.Text := '';
     NChooseUser := 0;
   end;
  end;
begin
  if ISignActivate = 1 then begin
    { Доступ к выбору конкретного пользователя }
    if rgrpWhom.ItemIndex = 0 then Whom(true) else Whom(False);
    { Доступ к созданию нового уведомления }
    if (
        (rgrpWhom.ItemIndex <> 0)
        and
        (
            (length(edContent.Text) = 0)
         or (length(edTopic.Text)   = 0)
        )
       )
       or
       (
        (rgrpWhom.ItemIndex = 0)
        and
        (
            (length(edContent.Text) = 0)
         or (length(edTopic.Text)   = 0)
         or (length(edWhom.Text)    = 0)
        )
       )
    then tbtnControl_Create.Enabled := false
    else tbtnControl_Create.Enabled := true;
  end;
end;

procedure TfrmCCJAL_CreateUserMsg.SetUser(NParm : integer; SParm : string);
begin
  NUSER := NParm;
  SUSER := SPArm;
end;

procedure TfrmCCJAL_CreateUserMsg.rgrpWhomClick(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJAL_CreateUserMsg.edWhomChange(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJAL_CreateUserMsg.edTopicChange(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJAL_CreateUserMsg.edContentChange(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJAL_CreateUserMsg.aChooseUserExecute(Sender: TObject);
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
      edWhom.Text := DescrSelect;
      NChooseUser := frmReference.GetRowIDSelect;
    end;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJAL_CreateUserMsg.aChooseTopicExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  DescrSelect := '';
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFRefAlertUserType);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if length(DescrSelect) > 0 then begin
      edTopic.Text := DescrSelect;
      NChooseTopic := frmReference.GetRowIDSelect;
    end;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJAL_CreateUserMsg.edWhomDblClick(Sender: TObject);
begin
  if aChooseUser.Enabled then aChooseUser.Execute;
end;

procedure TfrmCCJAL_CreateUserMsg.edTopicDblClick(Sender: TObject);
begin
  if aChooseTopic.Enabled then aChooseTopic.Execute;
end;

procedure TfrmCCJAL_CreateUserMsg.aCreateExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  IErr := 0;
  SErr := '';
  try
    spCreate.Parameters.ParamValues['@UserFrom']  := NUSER;
    if rgrpWhom.ItemIndex = 0 then spCreate.Parameters.ParamValues['@UserWhom']  := NChooseUser;
    spCreate.Parameters.ParamValues['@SignWhom']  := rgrpWhom.ItemIndex;
    spCreate.Parameters.ParamValues['@UserTopic'] := NChooseTopic;
    spCreate.Parameters.ParamValues['@Content']   := edContent.Text;
    spCreate.ExecProc;
    IErr := spCreate.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      SErr := spCreate.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end else self.Close;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TfrmCCJAL_CreateUserMsg.aExitExecute(Sender: TObject);
begin
  Self.Close;
end;

end.
