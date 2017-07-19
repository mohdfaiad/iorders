unit CCJSO_RefStatusSequence_Create;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  UCCenterJournalNetZkz, ExtCtrls, StdCtrls, ActnList, ToolWin, ComCtrls,
  DB, ADODB;

type
  TRecRefStatusSequence = record
    RN            : integer;
    SeqStatusName : string;
  end;

type
  TfrmCCJSO_RefStatusSequence_Create = class(TForm)
    pnlControl: TPanel;
    pnlFields: TPanel;
    lblSeqStatusName: TLabel;
    edSeqStatusName: TEdit;
    pnlControl_Tool: TPanel;
    pnlControl_Show: TPanel;
    tbarControl: TToolBar;
    aList: TActionList;
    aSave: TAction;
    aExit: TAction;
    tbtbControl_Save: TToolButton;
    tbtbControl_Exit: TToolButton;
    spInsert: TADOStoredProc;
    spUpdate: TADOStoredProc;
    spMultiPly: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aSaveExecute(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure edSeqStatusNameChange(Sender: TObject);
  private
    { Private declarations }
    bSignActive : boolean;
    Mode        : integer;
    RecSession  : TUserSession;
    RecItem     : TRecRefStatusSequence;
    procedure ShowGets;
    procedure ItemInsert(var IErr : integer; var SErr : string);
    procedure ItemUpdate(var IErr : integer; var SErr : string);
    procedure ItemMultiPly(var IErr : integer; var SErr : string);
  public
    { Public declarations }
    procedure SetRecSession(Parm : TUserSession);
    procedure SetMode(Parm : integer);
    procedure SetRecItem(Parm : TRecRefStatusSequence);
  end;


const
  cRefStatusSequenceCreate_Insert = 1;
  cRefStatusSequenceCreate_Update = 2;
  cRefStatusSequenceCreate_MultiPly = 3;

var
  frmCCJSO_RefStatusSequence_Create: TfrmCCJSO_RefStatusSequence_Create;

implementation

uses
  UMAIN;

const
  cFormCaption = 'Последовательность статусов заказов ';

{$R *.dfm}

procedure TfrmCCJSO_RefStatusSequence_Create.FormCreate(Sender: TObject);
begin
  { Инициализация }
  bSignActive := false;
  Mode := 0;
end;

procedure TfrmCCJSO_RefStatusSequence_Create.FormActivate(Sender: TObject);
begin
  if not bSignActive then begin
    case Mode of
      cRefStatusSequenceCreate_Insert: begin
        self.Caption := cFormCaption + '(добавить)';
        FCCenterJournalNetZkz.imgMain.GetIcon(27,self.Icon);
      end;
      cRefStatusSequenceCreate_Update: begin
        self.Caption := cFormCaption + '(исправить)';
        FCCenterJournalNetZkz.imgMain.GetIcon(229,self.Icon);
        edSeqStatusName.Text := RecItem.SeqStatusName;
      end;
      cRefStatusSequenceCreate_MultiPly: begin
        self.Caption := cFormCaption + '(размножить)';
        FCCenterJournalNetZkz.imgMain.GetIcon(373,self.Icon);
        edSeqStatusName.Text := RecItem.SeqStatusName;
      end;
    end;
    { Форма активна }
    bSignActive := true;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_RefStatusSequence_Create.ShowGets;
begin
  if bSignActive then begin
    { Пустое значение }
    if length(trim(edSeqStatusName.Text)) = 0
      then edSeqStatusName.Color := clYellow
      else edSeqStatusName.Color := clWindow;
    { Доступ к сохранению }
    if    (length(trim(edSeqStatusName.Text)) = 0)
       or (trim(edSeqStatusName.Text) = RecItem.SeqStatusName)
      then aSave.Enabled := false
      else aSave.Enabled := true;
  end;
end;

procedure TfrmCCJSO_RefStatusSequence_Create.SetRecSession(Parm : TUserSession); begin RecSession := Parm; end;
procedure TfrmCCJSO_RefStatusSequence_Create.SetMode(Parm : integer); begin Mode := Parm; end;
procedure TfrmCCJSO_RefStatusSequence_Create.SetRecItem(Parm : TRecRefStatusSequence); begin recItem := Parm; end;

procedure TfrmCCJSO_RefStatusSequence_Create.aSaveExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if MessageDLG('Подтвердите выполнение действия',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  IErr := 0;
  SErr := '';
  case Mode of
    cRefStatusSequenceCreate_Insert:   ItemInsert(IErr,SErr);
    cRefStatusSequenceCreate_Update:   ItemUpdate(IErr,SErr);
    cRefStatusSequenceCreate_MultiPly: ItemMultiPly(IErr,SErr);
  end;
  if IErr = 0 then self.Close;
  ShowGets;
end;

procedure TfrmCCJSO_RefStatusSequence_Create.ItemInsert(var IErr : integer; var SErr : string);
begin
  try
    spInsert.Parameters.ParamValues['@USER'] := RecSession.CurrentUser;
    spInsert.Parameters.ParamValues['@Descr'] := edSeqStatusName.Text;
    spInsert.ExecProc;
    IErr := spInsert.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      if (IErr = 2601) or (IErr = 2627)
        then SErr := 'Дублирование данных. Наименование <' + edSeqStatusName.Text + '> уже существует'
        else SErr := spInsert.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  except
    on e:Exception do
      begin
        ShowMessage(e.Message);
      end;
  end;
end;

procedure TfrmCCJSO_RefStatusSequence_Create.ItemUpdate(var IErr : integer; var SErr : string);
begin
  try
    spUpdate.Parameters.ParamValues['@USER'] := RecSession.CurrentUser;
    spUpdate.Parameters.ParamValues['@Descr'] := edSeqStatusName.Text;
    spUpdate.Parameters.ParamValues['@NRN'] := RecItem.RN;
    spUpdate.ExecProc;
    IErr := spUpdate.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      if (IErr = 2601) or (IErr = 2627)
        then SErr := 'Дублирование данных. Наименование <' + edSeqStatusName.Text + '> уже существует'
        else SErr := spUpdate.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  except
    on e:Exception do
      begin
        ShowMessage(e.Message);
      end;
  end;
end;

procedure TfrmCCJSO_RefStatusSequence_Create.ItemMultiPly(var IErr : integer; var SErr : string);
begin
  try
    spMultiPly.Parameters.ParamValues['@USER'] := RecSession.CurrentUser;
    spMultiPly.Parameters.ParamValues['@Descr'] := edSeqStatusName.Text;
    spMultiPly.Parameters.ParamValues['@BaseRN'] := RecItem.RN;
    spMultiPly.ExecProc;
    IErr := spMultiPly.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      if (IErr = 2601) or (IErr = 2627)
        then SErr := 'Дублирование данных. Наименование <' + edSeqStatusName.Text + '> уже существует'
        else SErr := spMultiPly.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  except
    on e:Exception do
      begin
        ShowMessage(e.Message);
      end;
  end;
end;

procedure TfrmCCJSO_RefStatusSequence_Create.aExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJSO_RefStatusSequence_Create.edSeqStatusNameChange(Sender: TObject);
begin
  ShowGets;
end;

end.
