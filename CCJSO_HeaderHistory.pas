unit CCJSO_HeaderHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  CCJSO_DM, ExtCtrls, ActnList, ComCtrls, ToolWin, StdCtrls;

type
  TfrmCCJSO_HeaderHistory = class(TForm)
    pnlHeader: TPanel;
    pnlControl: TPanel;
    pnlControl_Tool: TPanel;
    pnlControl_Show: TPanel;
    pnlRecord: TPanel;
    aList: TActionList;
    aExit: TAction;
    rbarControl: TToolBar;
    tbtnControl_Exit: TToolButton;
    lblSActionName: TLabel;
    lblSActionCode: TLabel;
    lblSUser: TLabel;
    lblSBeginDate: TLabel;
    lblSEndDate: TLabel;
    lblSActionFoundation: TLabel;
    lblSDriver: TLabel;
    lblIAllowBeOpen: TLabel;
    lblWaitingTimeMinute: TLabel;
    lblSNOTE: TLabel;
    edSActionName: TEdit;
    edSActionCode: TEdit;
    edSUser: TEdit;
    edSBeginDate: TEdit;
    edSEndDate: TEdit;
    edSActionFoundation: TEdit;
    edSDriver: TEdit;
    edIAllowBeOpen: TEdit;
    edWaitingTimeMinute: TEdit;
    edSNOTE: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActive  : integer;
    RecHist      : TJSORecHist;
    procedure ShowGets;
    procedure InitFields;
  public
    { Public declarations }
    procedure SetRec(Parm : TJSORecHist);
  end;

var
  frmCCJSO_HeaderHistory: TfrmCCJSO_HeaderHistory;

implementation

uses UCCenterJournalNetZkz;

{$R *.dfm}

procedure TfrmCCJSO_HeaderHistory.FormCreate(Sender: TObject);
begin
  ISignActive := 0;
end;

procedure TfrmCCJSO_HeaderHistory.FormActivate(Sender: TObject);
begin
  if ISignActive = 0 then begin
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(367,self.Icon);
    pnlHeader.Caption := ' Заказ № ' + IntToStr(RecHist.NOrder);
    InitFields;
    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_HeaderHistory.ShowGets;
begin
  if ISignActive = 1 then begin
  end;
end;

procedure TfrmCCJSO_HeaderHistory.SetRec(Parm : TJSORecHist); begin RecHist := Parm; end;

procedure TfrmCCJSO_HeaderHistory.InitFields;
begin
  edSActionCode.Text       := RecHist.SActionCode;
  edSActionName.Text       := RecHist.SActionName;
  edSUser.Text             := RecHist.SUser;
  edSBeginDate.Text        := RecHist.SBeginDate;
  edSEndDate.Text          := RecHist.SEndDate;
  edSActionFoundation.Text := RecHist.SActionFoundation;
  edSDriver.Text           := RecHist.SDriver;
  edSNOTE.Text             := RecHist.SNOTE;
  edIAllowBeOpen.Text      := IntToStr(RecHist.IAllowBeOpen);
  edWaitingTimeMinute.Text := IntToStr(RecHist.WaitingTimeMinute);
end;

procedure TfrmCCJSO_HeaderHistory.aExitExecute(Sender: TObject);
begin
  Self.Close;
end;

end.
