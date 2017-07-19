unit CCJRMO_Status;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, ExtCtrls, ActnList, DB, ADODB;

type
  TfrmCCJRMO_Status = class(TForm)
    pnlTop: TPanel;
    pnlTop_Order: TPanel;
    pnlTop_Price: TPanel;
    pnlTop_Client: TPanel;
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
    procedure mNoteChange(Sender: TObject);
  private
    { Private declarations }
    ISignActive   : integer;
    CodeAction    : string;
    NRN           : integer; { Номер интернет-заказа или звонка}
    NUSER         : integer;
    OrderPrice    : real;
    OrderClient   : string;
    SNOTE         : string;
    NHist         : integer;
    procedure ShowGets;
  public
    { Public declarations }
    procedure SetCodeAction(Parm : string);
    procedure SetRN(Parm : integer);
    procedure SetPrice(Parm : real);
    procedure SetClient(Parm : string);
    procedure SetUser(Parm : integer);
    procedure SetNote(Parm : string);
    procedure SetRNHist(Parm : integer);
  end;

var
  frmCCJRMO_Status: TfrmCCJRMO_Status;

implementation

uses
  Util,
  UMAIN, UCCenterJournalNetZkz, UReference;

{$R *.dfm}

procedure TfrmCCJRMO_Status.ShowGets;
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

procedure TfrmCCJRMO_Status.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
  NRN         := 0;
  NUSER       := 0;
  OrderPrice  := 0;
  OrderClient := '';
  SNOTE       := '';
end;

procedure TfrmCCJRMO_Status.FormActivate(Sender: TObject);
var
  SCaption : string;
begin
  if ISignActive = 0 then begin
    { Иконка окна }
    FCCenterJournalNetZkz.imgMain.GetIcon(115,self.Icon);
    { Отображаем реквизиты заказа }
    SCaption := 'Заказ № ' + VarToStr(NRN);
    pnlTop_Order.Caption := SCaption; pnlTop_Order.Width := TextPixWidth(SCaption, pnlTop_Order.Font) + 20;
    SCaption := 'Сумма ' + VarToStr(OrderPrice);
    pnlTop_Price.Caption := SCaption; pnlTop_Price.Width := TextPixWidth(SCaption, pnlTop_Price.Font) + 20;
    SCaption := OrderClient;
    pnlTop_Client.Caption := SCaption; pnlTop_Client.Width := TextPixWidth(SCaption, pnlTop_Client.Font) + 10;
    { Текущее значение примечания }
    mNote.Text := SNOTE;
    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJRMO_Status.SetCodeAction(Parm : string); begin CodeAction := Parm; end;
procedure TfrmCCJRMO_Status.SetRN(Parm : integer); begin NRN := Parm; end;
procedure TfrmCCJRMO_Status.SetPrice(Parm : real); begin OrderPrice := Parm; end;
procedure TfrmCCJRMO_Status.SetClient(Parm : string); begin OrderClient := Parm; end;
procedure TfrmCCJRMO_Status.SetUser(Parm : integer); begin NUSER := Parm; end;
procedure TfrmCCJRMO_Status.SetNote(Parm : string); begin SNOTE := Parm; end;
procedure TfrmCCJRMO_Status.SetRNHist(Parm : integer); begin NHist := Parm; end;

procedure TfrmCCJRMO_Status.aMain_OkExecute(Sender: TObject);
var
  IErr            : integer;
  SErr            : string;
begin
  if CodeAction = 'JRMO_State' then begin
    if MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
    try
      spSetStatus.Parameters.ParamValues['@PRN']            := NRN;
      spSetStatus.Parameters.ParamValues['@RN_HIST']        := NHist;
      spSetStatus.Parameters.ParamValues['@USER']           := NUSER;
      spSetStatus.Parameters.ParamValues['@Status']         := edOrderStatus.Text;
      spSetStatus.Parameters.ParamValues['@SNOTE']          := mNote.Text;
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
  end;
end;

procedure TfrmCCJRMO_Status.aMain_ExitExecute(Sender: TObject);
begin
  self.close;
end;

procedure TfrmCCJRMO_Status.aMain_SlOrderStatusExecute(Sender: TObject);
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

procedure TfrmCCJRMO_Status.edOrderStatusChange(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJRMO_Status.mNoteChange(Sender: TObject);
begin
  ShowGets;
end;

end.
