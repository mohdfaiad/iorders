unit CCJSO_JRegError;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Grids, DBGrids, StdCtrls, ExtCtrls, DB, ADODB,
  ComCtrls, ToolWin;

type
  TfrmCCJSO_JRegError = class(TForm)
    pnlTop: TPanel;
    pnlGrid: TPanel;
    pnlErrMessage: TPanel;
    mErrMessage: TMemo;
    DBGRID: TDBGrid;
    aMain: TActionList;
    aMain_Close: TAction;
    qrspJRegError: TADOStoredProc;
    dsJRegError: TDataSource;
    pnlTop_Control: TPanel;
    pnlTop_Show: TPanel;
    aMain_ShowAllRegErr: TAction;
    tbrMain: TToolBar;
    tlbtnRegFailure: TToolButton;
    aMain_ShowCurrentOrderRegErr: TAction;
    SplitterGrid: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aMain_CloseExecute(Sender: TObject);
    procedure dsJRegErrorDataChange(Sender: TObject; Field: TField);
    procedure DBGRIDDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aMain_ShowAllRegErrExecute(Sender: TObject);
    procedure aMain_ShowCurrentOrderRegErrExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActive         : smallint;
    SOrder              : string;
    IModeShowRegFailure : smallint; { Режим отображения зарегистрированных сбоев }
    procedure ShowGets;
    procedure CreateCondition;
    procedure ExecCondition;
  public
    { Public declarations }
    procedure SetOrder(Order : string);
  end;

var
  frmCCJSO_JRegError: TfrmCCJSO_JRegError;

implementation

uses
  Util,
  UMAIN, UCCenterJournalNetZkz;

{$R *.dfm}

const
  cFShowCurrent = 0; { Показать зарегистрированные сбои выбранного заказа }
  cFShowAll     = 1; { Показать все зарегистрированные сбои }

procedure TfrmCCJSO_JRegError.FormCreate(Sender: TObject);
begin
  ISignActive := 0;
end;

procedure TfrmCCJSO_JRegError.FormActivate(Sender: TObject);
begin
  if ISignActive = 0 then begin
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(191,self.Icon);
    { Номер заказа }
    pnlTop_Show.Caption := 'Заказ ' + SOrder;
    { Форма активна }
    ISignActive := 1;
    IModeShowRegFailure    := cFShowCurrent;
    tlbtnRegFailure.Action := aMain_ShowAllRegErr;
    ExecCondition;
    DBGRID.SetFocus;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_JRegError.ShowGets;
begin
  if ISignActive = 1 then begin
    pnlTop_Control.Width := tlbtnRegFailure.Width + 7;
  end;
end;

procedure TfrmCCJSO_JRegError.SetOrder(Order : string); begin SOrder := Order; end;

procedure TfrmCCJSO_JRegError.CreateCondition;
begin
  if IModeShowRegFailure = cFShowCurrent
    then qrspJRegError.Parameters.ParamByName('@SOrder').Value := SOrder
  else if IModeShowRegFailure = cFShowAll
    then qrspJRegError.Parameters.ParamByName('@SOrder').Value := '';
end;

procedure TfrmCCJSO_JRegError.ExecCondition;
begin
  qrspJRegError.Active := false;
  CreateCondition;
  qrspJRegError.Active := true;
end;

procedure TfrmCCJSO_JRegError.aMain_CloseExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJSO_JRegError.dsJRegErrorDataChange(Sender: TObject; Field: TField);
begin
  mErrMessage.Text := DBGRID.DataSource.DataSet.FieldByName('SErrorMessage').AsString;
end;

procedure TfrmCCJSO_JRegError.DBGRIDDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCCJSO_JRegError.aMain_ShowAllRegErrExecute(Sender: TObject);
begin
  IModeShowRegFailure := cFShowAll;
  ExecCondition;
  tlbtnRegFailure.Action := aMain_ShowCurrentOrderRegErr;
  ShowGets;
end;

procedure TfrmCCJSO_JRegError.aMain_ShowCurrentOrderRegErrExecute(Sender: TObject);
begin
  IModeShowRegFailure := cFShowCurrent;
  ExecCondition;
  tlbtnRegFailure.Action := aMain_ShowAllRegErr;
  ShowGets;
end;

end.
