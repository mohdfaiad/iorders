unit CCJS_JournalRegLoadOrders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ComCtrls, ToolWin, StdCtrls, Grids, DBGrids, ExtCtrls,
  DB, ADODB;

type
  TfrmCCJS_JournalRegLoadOrders = class(TForm)
    pnlStatusBar: TPanel;
    stbrMain: TStatusBar;
    pnlCondition: TPanel;
    grbxCondition: TGroupBox;
    pnlTop: TPanel;
    pnlGrid: TPanel;
    DBGridMain: TDBGrid;
    pnlTop_Right: TPanel;
    pnlTop_ToolBar: TPanel;
    lblCndDatePeriod_with: TLabel;
    dtCndBegin: TDateTimePicker;
    lblCndDatePeriod_toOn: TLabel;
    dtCndEnd: TDateTimePicker;
    chbxCndOnlyLoadOrders: TCheckBox;
    tlbrMain: TToolBar;
    toolbtn_MainGridRefresh: TToolButton;
    ActionListMain: TActionList;
    aMain_MainGridRefresh: TAction;
    dsMain: TDataSource;
    spdsRegLoadOrderSite: TADOStoredProc;
    aMain_Close: TAction;
    toolbtn_MainClose: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aMain_MainGridRefreshExecute(Sender: TObject);
    procedure dtCndBeginChange(Sender: TObject);
    procedure dtCndEndChange(Sender: TObject);
    procedure chbxCndOnlyLoadOrdersClick(Sender: TObject);
    procedure aMain_CloseExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActive : integer;
    procedure ShowGets;
    procedure CreateConditionGridMain;
    procedure ExecConditionGridMain;
    procedure GridMainRefresh;
  public
    { Public declarations }
  end;

var
  frmCCJS_JournalRegLoadOrders: TfrmCCJS_JournalRegLoadOrders;

implementation

uses Umain, UCCenterJournalNetZkz, DateUtils;

{$R *.dfm}

procedure TfrmCCJS_JournalRegLoadOrders.GridMainRefresh;
var
  NRN: Integer;
begin
  if not spdsRegLoadOrderSite.IsEmpty then NRN := spdsRegLoadOrderSite.FieldByName('NRN').AsInteger else NRN := -1;
  spdsRegLoadOrderSite.Requery;
  spdsRegLoadOrderSite.Locate('NRN', NRN, []);
end; (* TFCCenterJournalNetZkz.GridMainRefresh *)

procedure TfrmCCJS_JournalRegLoadOrders.ExecConditionGridMain;
begin
  spdsRegLoadOrderSite.Active := false;
  CreateConditionGridMain;
  spdsRegLoadOrderSite.Active := true;
end;

procedure TfrmCCJS_JournalRegLoadOrders.CreateConditionGridMain;
var
  ISignConditionNote : int64;
begin
  spdsRegLoadOrderSite.Parameters.ParamByName('@BeginDate').Value          := dtCndBegin.Date;
  spdsRegLoadOrderSite.Parameters.ParamByName('@EndDate').Value            := dtCndEnd.Date;
  if chbxCndOnlyLoadOrders.Checked then ISignConditionNote := 1 else ISignConditionNote := 0;
  spdsRegLoadOrderSite.Parameters.ParamByName('@ISignConditionNote').Value := ISignConditionNote;
end;

procedure TfrmCCJS_JournalRegLoadOrders.ShowGets;
begin
  if ISignActive = 1 then begin
  end;
end;

procedure TfrmCCJS_JournalRegLoadOrders.FormCreate(Sender: TObject);
begin
  ISignActive := 0;
  dtCndBegin.Date  := IncDay(date,-1);
  dtCndEnd.Date    := date;
  aMain_MainGridRefresh.Enabled := true;
  toolbtn_MainGridRefresh.Enabled := true;
end;

procedure TfrmCCJS_JournalRegLoadOrders.FormActivate(Sender: TObject);
begin
  if ISignActive = 0 then begin
    ExecConditionGridMain;
    ShowGets;
    ISignActive := 1;
  end;
end;

procedure TfrmCCJS_JournalRegLoadOrders.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TfrmCCJS_JournalRegLoadOrders.aMain_MainGridRefreshExecute(Sender: TObject);
begin
  GridMainRefresh;
  ShowGets;
end;

procedure TfrmCCJS_JournalRegLoadOrders.dtCndBeginChange(Sender: TObject);
begin
  ExecConditionGridMain;
  ShowGets;
end;

procedure TfrmCCJS_JournalRegLoadOrders.dtCndEndChange(Sender: TObject);
begin
  ExecConditionGridMain;
  ShowGets;
end;

procedure TfrmCCJS_JournalRegLoadOrders.chbxCndOnlyLoadOrdersClick(Sender: TObject);
begin
  ExecConditionGridMain;
  ShowGets;
end;

procedure TfrmCCJS_JournalRegLoadOrders.aMain_CloseExecute(Sender: TObject);
begin
  self.Close;
end;

end.
