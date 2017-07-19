unit CCJSO_NPost_StateDate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ExtCtrls, DB, ADODB, Grids, DBGrids, ComCtrls, ToolWin;

type
  TfrmCCJSO_NPost_StateDate = class(TForm)
    pnlAttr: TPanel;
    pnlAttr_StateName: TPanel;
    pnlAttr_StateDate: TPanel;
    pnlTool: TPanel;
    pnlTool_Show: TPanel;
    pnlTool_Bar: TPanel;
    pnlControl: TPanel;
    pnlControl_Tool: TPanel;
    pnlControl_Show: TPanel;
    aList: TActionList;
    aExit: TAction;
    toolbrControl: TToolBar;
    ToolButton1: TToolButton;
    pnlGRID: TPanel;
    DBGrid: TDBGrid;
    qrspHistStateDate: TADOStoredProc;
    dsHistStateDate: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    ISign_Activate   : integer;
    StateName        : string;
    StateDate        : string;
    RN               : integer;
    procedure ShowGets;
  public
    { Public declarations }
    procedure SetStateName(Parm : string);
    procedure SetStateDate(Parm : string);
    procedure SetRN(Parm : integer);
  end;

var
  frmCCJSO_NPost_StateDate: TfrmCCJSO_NPost_StateDate;

implementation

uses Util,
     UMAIN,UCCenterJournalNetZkz;

{$R *.dfm}

procedure TfrmCCJSO_NPost_StateDate.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISign_Activate := 0;
  StateName := '';
  StateDate := '';
  RN        := 0;
end;

procedure TfrmCCJSO_NPost_StateDate.FormActivate(Sender: TObject);
begin
  if ISign_Activate = 0 then begin
    { Инициализация }
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(331,self.Icon);
    { Отображение атрибутов экспресс-накладной }
    pnlAttr_StateName.Caption := StateName;
    pnlAttr_StateName.Width := TextPixWidth(StateName, pnlAttr_StateName.Font) + 30;
    pnlAttr_StateDate.Caption := StateDate;
    { Набор данных }
    qrspHistStateDate.Active := false;
    qrspHistStateDate.Parameters.ParamValues['@RN'] := RN;
    qrspHistStateDate.Active := true;
    { Форма активна }
    ISign_Activate := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_NPost_StateDate.SetStateName(Parm : string); begin StateName := Parm; end;
procedure TfrmCCJSO_NPost_StateDate.SetStateDate(Parm : string); begin StateDate := Parm; end;
procedure TfrmCCJSO_NPost_StateDate.SetRN(Parm : integer); begin RN := Parm; end;

procedure TfrmCCJSO_NPost_StateDate.ShowGets;
var
  SCaption : string;
begin
  if ISign_Activate = 1 then begin
    { Количество записей }
    SCaption := VarToStr(qrspHistStateDate.RecordCount);
    pnlTool_Show.Caption := SCaption;
    pnlTool_Show.Width := TextPixWidth(SCaption, pnlTool_Show.Font) + 20;
  end;
end;

procedure TfrmCCJSO_NPost_StateDate.aExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmCCJSO_NPost_StateDate.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

end.
