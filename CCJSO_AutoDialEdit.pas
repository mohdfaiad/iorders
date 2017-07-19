unit CCJSO_AutoDialEdit;

{
  © PgkSoft 29.06.2016
  Журнал регистрации автодозвонов
  Регистрационная карточка
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  CCJSO_AutoDial, StdCtrls, ExtCtrls, ActnList;

type
  TfrmCCJSO_AutoDialEdit = class(TForm)
    pnlFields: TPanel;
    lblSCreateDate: TLabel;
    lblSFullOrder: TLabel;
    lblSOrderDT: TLabel;
    lblSPhone: TLabel;
    lblSClient: TLabel;
    lblSAutoDialType: TLabel;
    lblICounter: TLabel;
    lblSNameFileRoot: TLabel;
    lblSAutoDialBegin: TLabel;
    lblSAutoDialEnd: TLabel;
    lblSAutoDialResult: TLabel;
    lblSFileExists: TLabel;
    lblNCheckCounter: TLabel;
    lblSCheckDate: TLabel;
    lblNRetryCounter: TLabel;
    edCreateDate: TEdit;
    edSFullOrder: TEdit;
    edSOrderDT: TEdit;
    edSPhone: TEdit;
    edSClient: TEdit;
    edSAutoDialType: TEdit;
    edICounter: TEdit;
    edSNameFileRoot: TEdit;
    edSAutoDialBegin: TEdit;
    edSAutoDialEnd: TEdit;
    edSAutoDialResult: TEdit;
    edSFileExists: TEdit;
    edNCheckCounter: TEdit;
    edSCheckDate: TEdit;
    edNRetryCounter: TEdit;
    aList: TActionList;
    aExit: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActive : boolean;
    RecItem     : TJSOAutoDial_Item;
    procedure ShowGets;
  public
    { Public declarations }
    procedure SetRecItem(Parm : TJSOAutoDial_Item);
  end;

var
  frmCCJSO_AutoDialEdit: TfrmCCJSO_AutoDialEdit;

implementation

uses UCCenterJournalNetZkz;

{$R *.dfm}

procedure TfrmCCJSO_AutoDialEdit.FormCreate(Sender: TObject);
begin
  ISignActive := false;
end;

procedure TfrmCCJSO_AutoDialEdit.FormActivate(Sender: TObject);
begin
  if not ISignActive then begin
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(370,self.Icon);
    { Инициализация }
    edCreateDate.Text      := RecItem.SCreateDate;
    edSFullOrder.Text      := RecItem.SFullOrder;
    edSOrderDT.Text        := RecItem.SOrderDT;
    edSPhone.Text          := RecItem.SPhone;
    edSClient.Text         := RecItem.SClient;
    edSAutoDialType.Text   := RecItem.SAutoDialType;
    edICounter.Text        := VarToStr(RecItem.ICounter);
    edSNameFileRoot.Text   := RecItem.SNameFileRoot;
    edSAutoDialBegin.Text  := RecItem.SAutoDialBegin;
    edSAutoDialEnd.Text    := RecItem.SAutoDialEnd;
    edSAutoDialResult.Text := RecItem.SAutoDialResult;
    edSFileExists.Text     := RecItem.SFileExists;
    edNCheckCounter.Text   := VarToStr(RecItem.NCheckCounter);
    edSCheckDate.Text      := RecItem.SCheckDate;
    edNRetryCounter.Text   := VarToStr(RecItem.NRetryCounter);
    { Форма активна }
    ISignActive := true;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_AutoDialEdit.ShowGets;
begin
  if ISignActive then begin
  end;
end;

procedure TfrmCCJSO_AutoDialEdit.SetRecItem(Parm : TJSOAutoDial_Item); begin RecItem := Parm; end;

procedure TfrmCCJSO_AutoDialEdit.aExitExecute(Sender: TObject);
begin
  Self.Close;
end;

end.
