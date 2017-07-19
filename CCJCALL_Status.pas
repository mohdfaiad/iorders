unit CCJCALL_Status;

{
  © PgkSoft 05.08.2015
  Журнал регистрации вызовов IP-телефонии
  Определение статуса пропущенного вызова
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, ToolWin, DB, ADODB, ActnList;

type
  TfrmCCJCALL_Status = class(TForm)
    pnlTop: TPanel;
    pnlTop_RN: TPanel;
    pnlTop_Phone: TPanel;
    pnlTop_CallDate: TPanel;
    pnlOrderStatus: TPanel;
    Label1: TLabel;
    edOrderStatus: TEdit;
    btnSlDrivers: TButton;
    pnlCheckNote: TPanel;
    pnlCheckNote_Count: TPanel;
    pnlCheckNote_Status: TPanel;
    pnlTool: TPanel;
    pnlTool_Bar: TPanel;
    tlbarControl: TToolBar;
    tlbtnOk: TToolButton;
    tlbtnExit: TToolButton;
    pnlTool_Show: TPanel;
    pnlNote: TPanel;
    mNote: TMemo;
    aMain: TActionList;
    aMain_Ok: TAction;
    aMain_Exit: TAction;
    aMain_SlOrderStatus: TAction;
    spSetStatus: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aMain_OkExecute(Sender: TObject);
    procedure aMain_ExitExecute(Sender: TObject);
    procedure aMain_SlOrderStatusExecute(Sender: TObject);
    procedure edOrderStatusChange(Sender: TObject);
  private
    { Private declarations }
    ISignActive   : integer;
    ISignExec     : integer;
    CodeAction    : string;
    NRN           : integer; { Регистрационный номер }
    NUSER         : integer;
    Phone         : string;
    SCallDate     : string;
    SNOTE         : string;
    SStatus       : string;
    NHist         : integer;
    procedure ShowGets;
  public
    { Public declarations }
    procedure SetCodeAction(Parm : string);
    procedure SetRN(Parm : integer);
    procedure SetPhone(Parm : string);
    procedure SetSCallDate(Parm : string);
    procedure SetUser(Parm : integer);
    procedure SetNote(Parm : string);
    procedure SetRNHist(Parm : integer);
    function  GetSignExec : integer;
    function  GetStatus : string;
  end;

var
  frmCCJCALL_Status: TfrmCCJCALL_Status;

implementation

uses
  Util,
  UMAIN, UCCenterJournalNetZkz, UReference;

{$R *.dfm}

procedure TfrmCCJCALL_Status.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
  ISignExec   := 0;
  CodeAction  := '';
  NRN         := 0;
  NUSER       := 0;
  Phone       := '';
  SCallDate   := '';
  SNOTE       := '';
  NHist       := 0;
end;

procedure TfrmCCJCALL_Status.FormActivate(Sender: TObject);
var
  SCaption : string;
begin
  if ISignActive = 0 then begin
    { Иконка окна }
    FCCenterJournalNetZkz.imgMain.GetIcon(115,self.Icon);
    { Отображаем реквизиты заказа }
    SCaption := 'Рег. № ' + VarToStr(NRN);
    pnlTop_RN.Caption := SCaption; pnlTop_RN.Width := TextPixWidth(SCaption, pnlTop_RN.Font) + 20;
    SCaption := 'Тел. ' + Phone;
    pnlTop_Phone.Caption := SCaption; pnlTop_Phone.Width := TextPixWidth(SCaption, pnlTop_Phone.Font) + 20;
    SCaption := SCallDate;
    pnlTop_CallDate.Caption := SCaption; pnlTop_CallDate.Width := TextPixWidth(SCaption, pnlTop_CallDate.Font) + 10;
    { Текущее значение примечания }
    mNote.Text := SNOTE;
    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJCALL_Status.ShowGets;
var
  SCaption : string;
begin
  if ISignActive = 1 then begin
    { Контроль на пустую строку }
    if length(edOrderStatus.Text) = 0 then begin
      aMain_Ok.Enabled := false;
      edOrderStatus.Color := TColor(clYellow);
    end else begin
      aMain_Ok.Enabled := true;
      edOrderStatus.Color := TColor(clWindow);
    end;
    { Количество символов в примечании }
    SCaption := VarToStr(length(mNote.Text));
    pnlCheckNote_Count.Caption := SCaption; pnlCheckNote_Count.Width := TextPixWidth(SCaption, pnlCheckNote_Count.Font) + 20;
  end;
end;

procedure TfrmCCJCALL_Status.SetCodeAction(Parm : string); begin CodeAction := parm; end;
procedure TfrmCCJCALL_Status.SetRN(Parm : integer); begin NRN := parm; end;
procedure TfrmCCJCALL_Status.SetPhone(Parm : string); begin Phone := parm; end;
procedure TfrmCCJCALL_Status.SetSCallDate(Parm : string); begin SCallDate := parm; end;
procedure TfrmCCJCALL_Status.SetUser(Parm : integer); begin NUSER := parm; end;
procedure TfrmCCJCALL_Status.SetNote(Parm : string); begin SNOTE := parm; end;
procedure TfrmCCJCALL_Status.SetRNHist(Parm : integer); begin NHist := parm; end;
function TfrmCCJCALL_Status.GetSignExec : integer; begin result := ISignExec; end;
function TfrmCCJCALL_Status.GetStatus : string; begin result := SStatus; end;

procedure TfrmCCJCALL_Status.aMain_OkExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if CodeAction = 'JCall_Status' then begin
    if MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
    try
      spSetStatus.Parameters.ParamValues['@PRN']            := NRN;
      spSetStatus.Parameters.ParamValues['@RN_HIST']        := NHist;
      spSetStatus.Parameters.ParamValues['@USER']           := NUSER;
      spSetStatus.Parameters.ParamValues['@Status']         := edOrderStatus.Text;
      spSetStatus.Parameters.ParamValues['@SNOTE']          := mNote.Text;
      spSetStatus.Parameters.ParamValues['@SignUpdJournal'] := 1;
      spSetStatus.ExecProc;
      IErr := spSetStatus.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr <> 0 then begin
        SErr := spSetStatus.Parameters.ParamValues['@SErr'];
        ShowMessage(SErr);
      end else begin
        ISignExec := 1;
        SStatus := edOrderStatus.Text;
        self.Close;
      end;
    except
      on e:Exception do begin
        ShowMessage(e.Message);
      end;
    end;
  end;
end;

procedure TfrmCCJCALL_Status.aMain_ExitExecute(Sender: TObject);
begin
  self.close;
end;

procedure TfrmCCJCALL_Status.aMain_SlOrderStatusExecute(Sender: TObject);
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

procedure TfrmCCJCALL_Status.edOrderStatusChange(Sender: TObject);
begin
  ShowGets;
end;

end.
