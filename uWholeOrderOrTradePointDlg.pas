unit uWholeOrderOrTradePointDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, DBCtrls, DB, ADODB, UtilsBase, Variants;

type
  TWholeOrderOrTPointParams = record
    Caption: string;
    OrderId: Integer;
    TradePointId: Variant;
  end;

  TWholeOrderOrTradePointDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    rbWholeOrder: TRadioButton;
    rbTradePoint: TRadioButton;
    dsTradePoint: TDataSource;
    cbTradePoint: TDBLookupComboBox;
    qrTradePoint: TADOQuery;
    procedure OKBtnClick(Sender: TObject);
    procedure rbTradePointClick(Sender: TObject);
  private
    { Private declarations }
    FParams: ^TWholeOrderOrTPointParams;
    procedure InitControls;
    procedure SaveResults;
    function ValidValuesEntered: Boolean;
  public
    { Public declarations }
    class function Execute(var AParams: TWholeOrderOrTPointParams): Boolean;
  end;

var
  WholeOrderOrTradePointDlg: TWholeOrderOrTradePointDlg;

implementation

{$R *.dfm}

uses uMain;

class function TWholeOrderOrTradePointDlg.Execute(var AParams: TWholeOrderOrTPointParams): Boolean;
var
  B: Boolean;
begin
  with TWholeOrderOrTradePointDlg.Create(nil) do
  try
    FParams := @AParams;
    InitControls;

    Result := ShowModal = mrOk;
  finally
    Free;
  end;
end;

procedure TWholeOrderOrTradePointDlg.InitControls;
begin
  Self.Caption := FParams.Caption;
  rbWholeOrder.Checked := true;
  cbTradePoint.Enabled := rbTradePoint.Checked;
  qrTradePoint.Parameters.ParamByName('OrderId').Value := FParams.OrderId;
  if not qrTradePoint.Active then
    qrTradePoint.Open
  else
    qrTradePoint.Refresh;
  if qrTradePoint.RecordCount = 1 then
    cbTradePoint.KeyValue := qrTradePoint.FieldByName('id').Value;
end;

procedure TWholeOrderOrTradePointDlg.SaveResults;
begin
  FParams^.TradePointId := Null;
  if rbTradePoint.Checked then
    FParams^.TradePointId := cbTradePoint.KeyValue;
end;

function TWholeOrderOrTradePointDlg.ValidValuesEntered: Boolean;
begin
  Result := false;
  if rbTradePoint.Checked and VarIsNull(cbTradePoint.KeyValue) then
    DoError('Не задана аптека');
  Result := true;
end;

procedure TWholeOrderOrTradePointDlg.OKBtnClick(Sender: TObject);
begin
  if ValidValuesEntered then
  begin
    SaveResults;
    ModalResult := mrOk;
  end;
end;

procedure TWholeOrderOrTradePointDlg.rbTradePointClick(Sender: TObject);
begin
  cbTradePoint.Enabled := rbTradePoint.Checked;
end;

end.
