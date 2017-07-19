unit CCJFB_Status;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, ADODB, ActnList, StdCtrls, ComCtrls, ToolWin;

type
  TfrmCCJFB_Status = class(TForm)
    pnlTop: TPanel;
    pnlTop_Order: TPanel;
    pnlTop_Client: TPanel;
    pnlTop_PhoneEMail: TPanel;
    aMain: TActionList;
    aStatus_Ok: TAction;
    aMain_Exit: TAction;
    aStatus_SlOrderStatus: TAction;
    spSetStatus: TADOStoredProc;
    stbarMain: TStatusBar;
    pgcMain: TPageControl;
    tabStatus: TTabSheet;
    tabSendEmail: TTabSheet;
    tabMsgInfo: TTabSheet;
    pnlOrderStatus: TPanel;
    edOrderStatus: TEdit;
    btnSlDrivers: TButton;
    pnlCheckNote: TPanel;
    pnlCheckNote_Count: TPanel;
    pnlCheckNote_Status: TPanel;
    pnlNote: TPanel;
    mNote: TMemo;
    pnlToolStatus: TPanel;
    pnlToolStatus_Bar: TPanel;
    tlbarControl: TToolBar;
    tlbtnStatusOk: TToolButton;
    tlbtnStatusExit: TToolButton;
    pnlToolStatus_Show: TPanel;
    pnlToolInfoMsg: TPanel;
    pnlToolInfoMsg_Bar: TPanel;
    ToolBar1: TToolBar;
    tlbtnInfoMsgExit: TToolButton;
    pnlToolInfoMsg_Show: TPanel;
    pnlCheckInfoMsf: TPanel;
    pnlCheckInfoMsf_Count: TPanel;
    pnlCheckInfoMsf_Show: TPanel;
    pnlContentsMsg: TPanel;
    mContents: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aStatus_OkExecute(Sender: TObject);
    procedure aMain_ExitExecute(Sender: TObject);
    procedure aStatus_SlOrderStatusExecute(Sender: TObject);
    procedure mNoteChange(Sender: TObject);
    procedure edOrderStatusChange(Sender: TObject);
  private
    { Private declarations }
    ISignActive : integer;
    IMode       : smallint;
    NPRN        : integer; { Ссылка на родительский разделл - номер заказа}
    NUSER       : integer;
    IType       : smallint;
    Client      : string;
    Phone       : string;
    EMail       : string;
    Contents    : string;
    SNOTE       : string;
    NHist       : integer; { ссылка на открытую операцию в истрии }
    procedure ShowGets;
  public
    { Public declarations }
    procedure SetMode(Mode : smallint);
    procedure SetPRN(RN : integer);
    procedure SetType(TypeMsg : smallint);
    procedure SetClient(ClientMsg : string);
    procedure SetUser(IDUSER : integer);
    procedure SetPhone(PhoneClient : string);
    procedure SetEMail(EMailClient : string);
    procedure SetContents(ContentsEmail : string);
    procedure SetNote(Note : string);
    procedure SetRNHist(RN : integer);
  end;

const
  { Режимы работы }
  cJFBStatusMode_FeedBack  = 1; { Определение статуса обратного звонка }
  cJFBStatusMode_InfoMsg   = 2; { Содержание письма }
  cJFBStatusMode_StatusMsg = 3; { Определение статуса сообщения }
  cJFBStatusMode_SendEMail = 4; { Отправка письма }
  { Тип документа }
  cJFBType_FeedBack = 1; { Обратный звонок }
  cJFBType_Message  = 2; { Сообщение }

var
  frmCCJFB_Status: TfrmCCJFB_Status;

implementation

uses
  Util,
  UMAIN, UCCenterJournalNetZkz, UReference;

{$R *.dfm}

procedure TfrmCCJFB_Status.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
  NPRN        := 0;
  IMode       := 0;
  NUSER       := 0;
  IType       := 0;
  Client      := '';
  Phone       := '';
  EMail       := '';
  Contents    := '';
  SNOTE       := '';
end;

procedure TfrmCCJFB_Status.FormActivate(Sender: TObject);
var
  SCaption : string;
begin
  if ISignActive = 0 then begin
    { Иконка и заголовок окна }
    if      IMode = cJFBStatusMode_FeedBack then begin
      self.Caption := 'Определить статус обратного звонка';
      FCCenterJournalNetZkz.imgMain.GetIcon(115,self.Icon);
      pgcMain.ActivePage := tabStatus;
    end
    else if IMode = cJFBStatusMode_StatusMsg then begin
      self.Caption := 'Определить статус сообщения';
      FCCenterJournalNetZkz.imgMain.GetIcon(115,self.Icon);
      pgcMain.ActivePage := tabStatus;
    end
    else if IMode = cJFBStatusMode_InfoMsg then begin
      self.Caption := 'Содержание сообщения';
      FCCenterJournalNetZkz.imgMain.GetIcon(200,self.Icon);
    end
    else if IMode = cJFBStatusMode_SendEMail then begin
      self.Caption := 'Отправить письмо клиенту';
      FCCenterJournalNetZkz.imgMain.GetIcon(202,self.Icon);
      pgcMain.ActivePage := tabSendEmail;
    end;
    { Отображаем реквизиты заказа }
    if      IType = cJFBType_FeedBack then SCaption := 'Обратный звонок № ' + VarToStr(NPRN)
    else if IType = cJFBType_Message  then SCaption := 'Сообщение № ' + VarToStr(NPRN);
    pnlTop_Order.Caption := SCaption; pnlTop_Order.Width := TextPixWidth(SCaption, pnlTop_Order.Font) + 20;
    SCaption := 'Клиент: '+Client; pnlTop_Client.Caption := SCaption; pnlTop_Client.Width := TextPixWidth(SCaption, pnlTop_Client.Font) + 20;
    if      IType = cJFBType_FeedBack then SCaption := 'тел. ' + Phone
    else if IType = cJFBType_Message  then SCaption := 'EMail: ' + EMail;
    pnlTop_PhoneEMail.Caption := SCaption; pnlTop_PhoneEMail.Width := TextPixWidth(SCaption, pnlTop_PhoneEMail.Font) + 20;
    { Текущее значение примечания }
    mNote.Text := SNOTE;
    { Текущее содержание сообщения }
    mContents.Text := Contents;
    { Доступ к данным в зависимости от режима работы }
    if IMode = cJFBStatusMode_FeedBack then begin
      tabStatus.TabVisible    := true;
      tabSendEmail.TabVisible := false;
      tabMsgInfo.TabVisible   := false;
    end
    else if IMode = cJFBStatusMode_InfoMsg then begin
      tabStatus.TabVisible    := false;
      tabSendEmail.TabVisible := false;
      tabMsgInfo.TabVisible   := true;
    end
    else if IMode = cJFBStatusMode_StatusMsg then begin
      tabStatus.TabVisible    := true;
      tabSendEmail.TabVisible := false;
      tabMsgInfo.TabVisible   := true;
    end
    else if IMode = cJFBStatusMode_SendEMail then begin
      tabStatus.TabVisible    := false;
      tabSendEmail.TabVisible := true;
      tabMsgInfo.TabVisible   := true;
    end;
    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJFB_Status.ShowGets;
var
  SCaption : string;
begin
  if ISignActive = 1 then begin
    { Контроль на пустую строку }
    if length(edOrderStatus.Text) = 0 then begin
      aStatus_Ok.Enabled := false;
      edOrderStatus.Color := TColor(clYellow);
    end else begin
      aStatus_Ok.Enabled := true;
      edOrderStatus.Color := TColor(clWindow);
    end;
    { Количество символов в примечании }
    SCaption := VarToStr(length(mNote.Text));
    pnlCheckNote_Count.Caption := SCaption; pnlCheckNote_Count.Width := TextPixWidth(SCaption, pnlCheckNote_Count.Font) + 20;
    { Количество символов в содержании письма }
    SCaption := VarToStr(length(mContents.Text));
    pnlCheckInfoMsf_Count.Caption := SCaption; pnlCheckInfoMsf_Count.Width := TextPixWidth(SCaption, pnlCheckInfoMsf_Count.Font) + 20;
  end;
end;

procedure TfrmCCJFB_Status.SetMode(Mode : smallint); begin IMode := Mode; end;

procedure TfrmCCJFB_Status.SetPRN(RN : integer); begin NPRN := RN; end;

procedure TfrmCCJFB_Status.SetType(TypeMsg : smallint); begin IType := TypeMsg; end;

procedure TfrmCCJFB_Status.SetClient(ClientMsg : string); begin Client := ClientMsg; end;

procedure TfrmCCJFB_Status.SetUser(IDUSER : integer); begin NUSER := IDUSER; end;

procedure TfrmCCJFB_Status.SetPhone(PhoneClient : string); begin Phone := PhoneClient; end;

procedure TfrmCCJFB_Status.SetEMail(EMailClient : string); begin EMail := EMailClient; end;

procedure TfrmCCJFB_Status.SetNote(Note : string); begin SNOTE := Note; end;

procedure TfrmCCJFB_Status.SetContents(ContentsEmail : string); begin Contents := ContentsEmail; end;

procedure TfrmCCJFB_Status.SetRNHist(RN : integer); begin NHist := RN; end;

procedure TfrmCCJFB_Status.aStatus_OkExecute(Sender: TObject);
var
  IErr            : integer;
  SErr            : string;
begin
  if (IMode = cJFBStatusMode_FeedBack) or (IMode = cJFBStatusMode_StatusMsg) then begin
    try
      spSetStatus.Parameters.ParamValues['@PRN']     := NPRN;
      spSetStatus.Parameters.ParamValues['@RN_HIST'] := NHist;
      spSetStatus.Parameters.ParamValues['@USER']    := NUSER;
      spSetStatus.Parameters.ParamValues['@Status']  := edOrderStatus.Text;
      spSetStatus.Parameters.ParamValues['@SNOTE']   := mNote.Text;
      spSetStatus.ExecProc;
      IErr := spSetStatus.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr <> 0 then begin
        SErr := spSetStatus.Parameters.ParamValues['@SErr'];
        ShowMessage(SErr);
      end else self.Close;
    except
      on e:Exception do begin
        ShowMessage(e.Message);
      end;
    end;
  end
  else if IMode = cJFBStatusMode_SendEMail then begin
  end;
end;

procedure TfrmCCJFB_Status.aMain_ExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJFB_Status.aStatus_SlOrderStatusExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFReferenceOrderStatus);
   frmReference.SetReadOnly(cFReferenceNoReadOnly);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if length(DescrSelect) > 0 then edOrderStatus.Text := DescrSelect;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJFB_Status.mNoteChange(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJFB_Status.edOrderStatusChange(Sender: TObject);
begin
  ShowGets;
end;

end.
