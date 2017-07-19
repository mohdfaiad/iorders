unit CCJS_ComeBack;

{
  © PgkSoft 28.04.2015
  Журнал интернет заказов.
  Отображение наличия и состояни возвратных накладных.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ToolWin, ComCtrls, ActnList, Grids, DBGrids, DB, ADODB;

type
  TfrmCCJS_ComeBack = class(TForm)
    pnlHeader: TPanel;
    pnlHeader_Order: TPanel;
    pnlHeader_Pharmacy: TPanel;
    pnlHeader_Client: TPanel;
    pnlTop: TPanel;
    pnlTop_Show: TPanel;
    pnlTop_Tool: TPanel;
    pnlMainGrid: TPanel;
    SplitterGrid: TSplitter;
    pnlControl: TPanel;
    pnlControl_Show: TPanel;
    pnlControl_Tool: TPanel;
    pnlSlaveGrid: TPanel;
    tlbrControl: TToolBar;
    MainGrid: TDBGrid;
    SlaveGrid: TDBGrid;
    Action: TActionList;
    aControl_Exit: TAction;
    ToolButton1: TToolButton;
    qrspJMoves: TADOStoredProc;
    dsJMoves: TDataSource;
    qrspRTovar: TADOStoredProc;
    dsRTovar: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aControl_ExitExecute(Sender: TObject);
    procedure MainGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dsJMovesDataChange(Sender: TObject; Field: TField);
    procedure SlaveGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    ISignActive : integer;
    SPharmacy   : string;
    NPharmacy   : integer;
    Order       : integer;
    SClient     : string;
    SOrder      : string;
    procedure ShowGets;
    procedure MainCreateCondition;
    procedure MainExecCondition;
  public
    { Public declarations }
    procedure SetNamePharmcy(Parm : string);
    procedure SetNPharmcy(Parm : integer);
    procedure SetOrder(Parm : integer);
    procedure SetClient(Parm : string);
  end;

var
  frmCCJS_ComeBack: TfrmCCJS_ComeBack;

implementation

uses
  Util,
  UMain, UCCenterJournalNetZkz;

{$R *.dfm}

procedure TfrmCCJS_ComeBack.FormCreate(Sender: TObject);
begin
  ISignActive := 0;
end;

procedure TfrmCCJS_ComeBack.FormActivate(Sender: TObject);
var
  SCaption : string;
begin
  if ISignActive = 0 then begin
    { Иконка окна }
    FCCenterJournalNetZkz.imgMain.GetIcon(230,self.Icon);
    { Отображаем реквизиты заказа }
    SOrder := VarToStr(Order);
    SCaption := 'Заказ № ' + SOrder;
    pnlHeader_Order.Caption := SCaption; pnlHeader_Order.Width := TextPixWidth(SCaption, pnlHeader_Order.Font) + 20;
    if NPharmacy <> 0 then begin
      SCaption := SPharmacy;
      pnlHeader_Pharmacy.Caption := SCaption; pnlHeader_Pharmacy.Width := TextPixWidth(SCaption, pnlHeader_Pharmacy.Font) + 20;
    end else begin
      pnlHeader_Pharmacy.Font.Color := clRed;
      SCaption := 'Аптека не определена';
      pnlHeader_Pharmacy.Caption := SCaption; pnlHeader_Pharmacy.Width := TextPixWidth(SCaption, pnlHeader_Pharmacy.Font) + 20;
    end;
    SCaption := SClient;
    pnlHeader_Client.Caption := SCaption; pnlHeader_Client.Width := TextPixWidth(SCaption, pnlHeader_Client.Font) + 20;
    { Получаем данные }
    MainExecCondition;
    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJS_ComeBack.ShowGets;
var
  SCaption : string;
begin
  if ISignActive = 1 then begin
    { Отражаем кол-во строк }
    SCaption := VarToStr(qrspJMoves.RecordCount);
    pnlTop_Show.Caption := SCaption; pnlTop_Show.Width := TextPixWidth(SCaption, pnlTop_Show.Font) + 30;
  end;
end;

procedure TfrmCCJS_ComeBack.SetNamePharmcy(Parm : string); begin SPharmacy := Parm; end;
procedure TfrmCCJS_ComeBack.SetNPharmcy(Parm : integer); begin NPharmacy := Parm; end;
procedure TfrmCCJS_ComeBack.SetOrder(Parm : integer); begin Order := Parm; end;
procedure TfrmCCJS_ComeBack.SetClient(Parm : string); begin SClient := Parm; end;

procedure TfrmCCJS_ComeBack.aControl_ExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJS_ComeBack.MainCreateCondition;
begin
  qrspJMoves.Parameters.ParamValues['@Pharmacy'] := NPharmacy;
end;

procedure TfrmCCJS_ComeBack.MainExecCondition;
var
  RN: Integer;
begin
  if not qrspJMoves.IsEmpty then RN := qrspJMoves.FieldByName('NRN').AsInteger else RN := -1;
  if qrspJMoves.Active then qrspJMoves.Active := false;
  MainCreateCondition;
  qrspJMoves.Active := true;
  qrspJMoves.Locate('NRN', RN, []);
  ShowGets;
end;

procedure TfrmCCJS_ComeBack.MainGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db : TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    { Текущую строку выделяем жирным шрифтом }
    db.Canvas.Font.Style := [fsBold];
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCCJS_ComeBack.dsJMovesDataChange(Sender: TObject; Field: TField);
begin
  qrspRTovar.Active := false;
  qrspRTovar.Parameters.ParamByName('@Pharmacy').Value := MainGrid.DataSource.DataSet.FieldByName('NPharmacy').AsInteger;
  qrspRTovar.Parameters.ParamByName('@SDocNumb').Value := MainGrid.DataSource.DataSet.FieldByName('SDocNumb').AsString;
  qrspRTovar.Parameters.ParamByName('@SDocDate').Value := MainGrid.DataSource.DataSet.FieldByName('SDocDate').AsString;
  qrspRTovar.Active := true;
end;

procedure TfrmCCJS_ComeBack.SlaveGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db : TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    { Текущую строку выделяем жирным шрифтом }
    db.Canvas.Font.Style := [fsBold];
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

end.
