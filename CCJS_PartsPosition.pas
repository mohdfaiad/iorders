unit CCJS_PartsPosition;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, ADODB, ActnList, Grids, DBGrids;

type
  TfrmCCJS_PartsPosition = class(TForm)
    pnlTop: TPanel;
    pnlTop_Order: TPanel;
    pnlTop_Price: TPanel;
    pnlTop_Client: TPanel;
    dsParts: TDataSource;
    qrspJSOParts: TADOStoredProc;
    pnlTop_ArtCode: TPanel;
    pnlTop_ArtName: TPanel;
    ActionMain: TActionList;
    aMain_Exit: TAction;
    pnlGrid: TPanel;
    DBGrid: TDBGrid;
    pnlControl: TPanel;
    pnlControl_Show: TPanel;
    pnlControl_Tool: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aMain_ExitExecute(Sender: TObject);
    procedure dsPartsDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    ISignActive  : integer;
    ModeParts    : integer;
    OrderID      : integer; { Номер интернет-заказа или звонка}
    NRN          : integer; { Родительская ссылка }
    NUSER        : integer;
    OrderPrice   : real;
    OrderClient  : string;
    ArtCode      : integer;
    ArtName      : string;
    qrspADO      : TADOStoredProc;
    procedure ShowGets;
    procedure ExecCondition(QRSP : TADOStoredProc);
    procedure CreateCondition(QRSP : TADOStoredProc);
  public
    { Public declarations }
    procedure SetModeParts(Mode : integer);
    procedure SetOrder(Order : integer);
    procedure SetRN(RN : integer);
    procedure SetPrice(Price : real);
    procedure SetClient(Client : string);
    procedure SetUser(IDUSER : integer);
    procedure SetArtCode(Code : integer);
    procedure SetArtName(Name : string);
  end;

const
  cFModeParts_JSO    = 0; { Журнал интернет-заказов }

var
  frmCCJS_PartsPosition: TfrmCCJS_PartsPosition;

implementation

uses
  Util,
  UMain, UCCenterJournalNetZkz;

{$R *.dfm}

procedure TfrmCCJS_PartsPosition.FormCreate(Sender: TObject);
begin
  ISignActive := 0;
end;

procedure TfrmCCJS_PartsPosition.FormActivate(Sender: TObject);
var
  SCaption : string;
begin
  if ISignActive = 0 then begin
    { Иконка окна }
    FCCenterJournalNetZkz.imgMain.GetIcon(183,self.Icon);
    { Отображаем реквизиты заказа }
    SCaption := 'Заказ № ' + VarToStr(OrderID);
    pnlTop_Order.Caption := SCaption; pnlTop_Order.Width := TextPixWidth(SCaption, pnlTop_Order.Font) + 20;
    SCaption := 'Сумма ' + VarToStr(OrderPrice);
    pnlTop_Price.Caption := SCaption; pnlTop_Price.Width := TextPixWidth(SCaption, pnlTop_Price.Font) + 20;
    SCaption := OrderClient;
    pnlTop_Client.Caption := SCaption; pnlTop_Client.Width := TextPixWidth(SCaption, pnlTop_Client.Font) + 20;
    SCaption := 'АртКод ' + VarToStr(ArtCode);
    pnlTop_ArtCode.Caption := SCaption; pnlTop_ArtCode.Width := TextPixWidth(SCaption, pnlTop_ArtCode.Font) + 20;
    SCaption := ArtName;
    pnlTop_ArtName.Caption := SCaption; pnlTop_ArtName.Width := TextPixWidth(SCaption, pnlTop_ArtName.Font) + 20;
    ISignActive := 1;
    { Подставляем набор данных }
    case ModeParts of
      cFModeParts_JSO: begin
        self.Caption := 'Интернет заказы. Товар по частям';
        dsParts.DataSet := qrspJSOParts;
        qrspADO := qrspJSOParts;
        ExecCondition(qrspADO);
      end;
    end;
  end;
end;

procedure TfrmCCJS_PartsPosition.ShowGets;
var
  SCaption : string;
begin
  if ISignActive = 1 then begin
    SCaption := 'В одном чеке не может быть больше ' + DBGrid.DataSource.DataSet.FieldByName('NCheckKol').AsString + ' шт.';
    pnlControl_Show.Caption := SCaption; pnlControl_Show.Width := TextPixWidth(SCaption, pnlControl_Show.Font) + 20
  end;
end;

procedure TfrmCCJS_PartsPosition.SetModeParts(Mode : integer);
begin
  ModeParts := Mode;
end;

procedure TfrmCCJS_PartsPosition.SetOrder(Order : integer);
begin
  OrderID := Order;
end;

procedure TfrmCCJS_PartsPosition.SetRN(RN : integer);
begin
  NRN := RN;
end;

procedure TfrmCCJS_PartsPosition.SetPrice(Price : real);
begin
  OrderPrice := Price;
end;

procedure TfrmCCJS_PartsPosition.SetClient(Client : string);
begin
  OrderClient := Client;
end;

procedure TfrmCCJS_PartsPosition.SetUser(IDUSER : integer);
begin
  NUSER := IDUSER;
end;

procedure TfrmCCJS_PartsPosition.SetArtCode(Code : integer);
begin
  ArtCode := Code;
end;

procedure TfrmCCJS_PartsPosition.SetArtName(Name : string);
begin
  ArtName := Name;
end;

procedure TfrmCCJS_PartsPosition.ExecCondition(QRSP : TADOStoredProc);
var
  RNOrderID: Integer;
begin
  if not QRSP.IsEmpty then RNOrderID := QRSP.FieldByName('NRN').AsInteger else RNOrderID := -1;
  if QRSP.Active then QRSP.Active := false;
  CreateCondition(QRSP);
  QRSP.Active := true;
  QRSP.Locate('NRN', RNOrderID, []);
  ShowGets;
end;

procedure TfrmCCJS_PartsPosition.CreateCondition(QRSP : TADOStoredProc);
begin
  QRSP.Parameters.ParamValues['@NRN'] := NRN;
end;

procedure TfrmCCJS_PartsPosition.aMain_ExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmCCJS_PartsPosition.dsPartsDataChange(Sender: TObject; Field: TField);
begin
  ShowGets;
end;

end.
