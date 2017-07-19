unit CCJSO_JournalAlert_Item;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,
  CCJSO_JournalAlert, ActnList, StdCtrls;

type
  TfrmCCJSO_JournalAlert_Item = class(TForm)
    pnlFields: TPanel;
    ActionList: TActionList;
    aExit: TAction;
    lblAlertDate: TLabel;
    lblAlertType: TLabel;
    lblReadDate: TLabel;
    lblExecDate: TLabel;
    lblEnumerator: TLabel;
    lblJList: TLabel;
    lblAlertUserType: TLabel;
    lblForShure: TLabel;
    lblContents: TLabel;
    edAlertDate: TEdit;
    edAlertType: TEdit;
    edReadDate: TEdit;
    edExecDate: TEdit;
    edEnumerator: TEdit;
    edJList: TEdit;
    edAlertUserType: TEdit;
    edForShure: TEdit;
    edContents: TMemo;
    lblFromWhom: TLabel;
    edFromWhom: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActivate  : integer;
    RecItem        : TJournalAlertItem;
  public
    { Public declarations }
    procedure SetRecItem(Parm : TJournalAlertItem);
  end;

var
  frmCCJSO_JournalAlert_Item: TfrmCCJSO_JournalAlert_Item;

implementation

uses
  UCCenterJournalNetZkz;

{$R *.dfm}

procedure TfrmCCJSO_JournalAlert_Item.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActivate := 0;
end;

procedure TfrmCCJSO_JournalAlert_Item.FormActivate(Sender: TObject);
begin
  if ISignActivate = 0 then begin
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(320,self.Icon);
    { Значения полей }
    edAlertDate.Text     := RecItem.SAlertDate;
    edAlertType.Text     := RecItem.SNameAlertType;
    edReadDate.Text      := RecItem.SReadDate;
    edExecDate.Text      := RecItem.SExecDate;
    edEnumerator.Text    := RecItem.SEnumerator;
    edJList.Text         := RecItem.SJList;
    edAlertUserType.Text := RecItem.SAlertUserType;
    edFromWhom.Text      := RecItem.SFromWhom;
    edContents.Text      := RecItem.SContents;
    if RecItem.BForShure then edForShure.Text := 'Да';
    { Форма активна }
    ISignActivate := 1;
  end;
end;

procedure TfrmCCJSO_JournalAlert_Item.SetRecItem(Parm : TJournalAlertItem); begin RecItem := Parm; end;

procedure TfrmCCJSO_JournalAlert_Item.aExitExecute(Sender: TObject);
begin
  self.Close;
end;

end.
