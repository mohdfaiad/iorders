unit uOrderReserveDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, UCCenterJournalNetZkz, uActionCore, UtilsBase;

type

  TfmOrderReserveDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    rbAll: TRadioButton;
    rbItem: TRadioButton;
    rbSubItem: TRadioButton;
    lbItem: TLabel;
    lbSubItem: TLabel;
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
    FOrderItem: TJSO_OrderHeaderItem;
    FSpecItem: TJSO_ItemOrder;
    FSubItemId: Integer;
    FReserveType: TReserveType;
    procedure InitControls;
  public
    { Public declarations }
    class function Execute(OrderItem: TJSO_OrderHeaderItem;
      SpecItem: TJSO_ItemOrder; SubItemId: Integer; var ReserveType: TReserveType): Boolean;
  end;

var
  fmOrderReserveDlg: TfmOrderReserveDlg;

implementation

{$R *.dfm}

class function TfmOrderReserveDlg.Execute(OrderItem: TJSO_OrderHeaderItem;
  SpecItem: TJSO_ItemOrder; SubItemId: Integer; var ReserveType: TReserveType): Boolean;
begin
  with TfmOrderReserveDlg.Create(nil) do
  try
    FOrderItem := OrderItem;
    FSpecItem := SpecItem;
    FSubItemId := SubItemId;
    try
      InitControls;

      Result := ShowModal = mrOk;
      ReserveType := FReserveType;
    except
      on E: Exception do
      begin
        ShowError(E.Message);
        Result := false;
      end;
    end;
  finally
    Free;
  end;
end;

procedure TfmOrderReserveDlg.InitControls;
var
  vName: string;
begin
  rbSubItem.Visible := FSubItemId <> 0;
  lbSubItem.Visible := rbSubItem.Visible;
  if length(FSpecItem.itemName) > 40 then
    vName := Copy(FSpecItem.itemName, 1, 40) + '...'
  else
    vName := FSpecItem.itemName;
  lbItem.Caption := Format('AртКод: %d, Наименование: %s', [FSpecItem.itemCode, vName]);
  lbSubItem.Caption := Format('ID: %d', [FSubItemId]);
  if not rbSubItem.Visible then
    Self.Height := 175;
end;

procedure TfmOrderReserveDlg.OKBtnClick(Sender: TObject);
begin
  if rbItem.Checked then
    FReserveType := rtItem
  else if rbSubItem.Checked then
    FReserveType := rtSubItem
  else
    FReserveType := rtAll;
end;

end.
