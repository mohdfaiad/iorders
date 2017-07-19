unit CCJSO_RP_ConsolidatedNetOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ComCtrls, StdCtrls, ToolWin, ExtCtrls;

type
  TfrmCCJSO_RP_ConsolidatedNetOrder = class(TForm)
    actionList: TActionList;
    aExcel: TAction;
    aClose: TAction;
    pnlControl: TPanel;
    pnlControl_Tool: TPanel;
    tollBar: TToolBar;
    tlbtnExcel: TToolButton;
    tlbtnClose: TToolButton;
    pnlControl_Show: TPanel;
    pnlPage: TPanel;
    pageControl: TPageControl;
    tabParm: TTabSheet;
    grpbxPeriod: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    dtBegin: TDateTimePicker;
    dtEnd: TDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aCloseExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActive    : integer;
    procedure ShowGets;
  public
    { Public declarations }
  end;

var
  frmCCJSO_RP_ConsolidatedNetOrder: TfrmCCJSO_RP_ConsolidatedNetOrder;

implementation

uses
  Util, ComObj, Excel97,
  UMain, UCCenterJournalNetZkz, ExDBGRID, DateUtils;

{$R *.dfm}

procedure TfrmCCJSO_RP_ConsolidatedNetOrder.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
  dtBegin.Date := Date;
  dtEnd.Date   := Date;
end;

procedure TfrmCCJSO_RP_ConsolidatedNetOrder.FormActivate(Sender: TObject);
begin
  if ISignActive = 0 then begin
    { Иконка окна }
    FCCenterJournalNetZkz.imgMain.GetIcon(332,self.Icon);
    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_RP_ConsolidatedNetOrder.ShowGets;
begin
  if ISignActive = 0 then begin
  end;
end;

procedure TfrmCCJSO_RP_ConsolidatedNetOrder.aExcelExecute(Sender: TObject);
begin
  //
end;

procedure TfrmCCJSO_RP_ConsolidatedNetOrder.aCloseExecute(Sender: TObject);
begin
  Self.Close;
end;

end.
