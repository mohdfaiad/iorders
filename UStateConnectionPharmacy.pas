unit UStateConnectionPharmacy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ComCtrls, ToolWin, StdCtrls, ExtCtrls, DB,
  ActnList, ADODB;

type
  TfrmStateConnectionPharmacy = class(TForm)
    pnlTop: TPanel;
    pnlTop_Condition: TPanel;
    grbxCondition: TGroupBox;
    pnlTop_Control: TPanel;
    pnlTop_Control_ToolBar: TPanel;
    pnlTop_Control_Info: TPanel;
    TollBarMain: TToolBar;
    tlbtnRefresh: TToolButton;
    pnlGrid: TPanel;
    DBGrid: TDBGrid;
    dsState: TDataSource;
    lblCndPharmacy: TLabel;
    edPharmacy: TEdit;
    chbxBadConnection: TCheckBox;
    aMain: TActionList;
    aMain_Exit: TAction;
    qrspStateConnectionPharmacy: TADOStoredProc;
    procedure tlbtnRefreshClick(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edPharmacyChange(Sender: TObject);
    procedure chbxBadConnectionClick(Sender: TObject);
    procedure aMain_ExitExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActivate : integer;
    procedure ExecCondition;
    procedure ShowGets;
  public
    { Public declarations }
  end;

var
  frmStateConnectionPharmacy: TfrmStateConnectionPharmacy;

implementation

  uses UMAIN, UCCenterJournalNetZkz;

{$R *.dfm}

procedure TfrmStateConnectionPharmacy.ShowGets;
begin
  if ISignActivate = 1 then begin
    pnlTop_Control_Info.Caption := 'Всего аптек ' + VarToStr(qrspStateConnectionPharmacy.RecordCount)
  end;
end;

procedure TfrmStateConnectionPharmacy.tlbtnRefreshClick(Sender: TObject);
var
  RNOrderID: Integer;
begin
  if not qrspStateConnectionPharmacy.IsEmpty then RNOrderID := qrspStateConnectionPharmacy.FieldByName('NID_APTEKA').AsInteger else RNOrderID := -1;
  qrspStateConnectionPharmacy.Requery;
  qrspStateConnectionPharmacy.Locate('NID_APTEKA', RNOrderID, []);
  ShowGets;
end;

procedure TfrmStateConnectionPharmacy.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db         : TDBGrid;
  DiffMinute : integer;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  if not (gdSelected in State) then begin
    if Column.FieldName = 'DiffMinute' then begin
      DiffMinute := Column.Field.AsInteger;
      if DiffMinute <= 3 then begin
        db.Canvas.Brush.Color := TColor(clLime);
      end else
      if (DiffMinute > 3) and ((DiffMinute <= 5)) then begin
        db.Canvas.Brush.Color := TColor(clYellow);
      end else
      if (DiffMinute > 5) and ((DiffMinute <= 10)) then begin
        db.Canvas.Brush.Color := TColor($AAD2FF);
      end else
      if (DiffMinute > 10) then begin
        db.Canvas.Brush.Color := TColor(clRed);
        db.Canvas.Font.Color := TColor(clWhite);
      end;
    end;
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmStateConnectionPharmacy.FormCreate(Sender: TObject);
begin
  ISignActivate := 0;
  TollBarMain.Indent := TollBarMain.Width - tlbtnRefresh.Width - 10;
end;

procedure TfrmStateConnectionPharmacy.FormActivate(Sender: TObject);
begin
  if ISignActivate = 0 then begin
    ISignActivate := 1;
    ExecCondition;
    ShowGets;
  end;
end;

procedure TfrmStateConnectionPharmacy.ExecCondition;
var
  Pharmacy          : string;
  SignBadConnection : integer;
begin
  if chbxBadConnection.Checked then SignBadConnection := 1 else SignBadConnection := 0;
  if length(trim(edPharmacy.Text)) = 0 then Pharmacy := '' else Pharmacy := edPharmacy.Text;
  if qrspStateConnectionPharmacy.Active then qrspStateConnectionPharmacy.Active := false;
  qrspStateConnectionPharmacy.Parameters.ParamValues['@Pharmacy']          := Pharmacy;
  qrspStateConnectionPharmacy.Parameters.ParamValues['@SignBadConnection'] := SignBadConnection;
  qrspStateConnectionPharmacy.Active := true;
end;

procedure TfrmStateConnectionPharmacy.edPharmacyChange(Sender: TObject);
begin
  ExecCondition;
  ShowGets;
end;

procedure TfrmStateConnectionPharmacy.chbxBadConnectionClick(Sender: TObject);
begin
  ExecCondition;
  ShowGets;
end;

procedure TfrmStateConnectionPharmacy.aMain_ExitExecute(Sender: TObject);
begin
  self.Close;
end;

end.
