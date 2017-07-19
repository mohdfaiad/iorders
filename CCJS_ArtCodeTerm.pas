unit CCJS_ArtCodeTerm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ActnList, ExtCtrls, Grids, DBGrids;

type
  TfrmCCJS_ArtCodeTerm = class(TForm)
    pnlTop: TPanel;
    pnlTop_Order: TPanel;
    pnlTop_Price: TPanel;
    pnlTop_Client: TPanel;
    pnlTop_ArtCode: TPanel;
    pnlTop_ArtName: TPanel;
    pnlControl: TPanel;
    pnlControl_Show: TPanel;
    pnlControl_Tool: TPanel;
    ActionMain: TActionList;
    aMain_Exit: TAction;
    dsTerm: TDataSource;
    qrspJSOTerm: TADOStoredProc;
    pnlTop_RemnTerm: TPanel;
    DBGrid: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aMain_ExitExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActive  : integer;
    ModeTerm     : integer;
    OrderID      : integer; { Номер интернет-заказа или звонка}
    NRN          : integer; { Родительская ссылка }
    NUSER        : integer;
    OrderPrice   : real;
    OrderClient  : string;
    ArtCode      : integer;
    ArtName      : string;
    itemRemnTerm : integer; { Остаток распределения для базовой позиции }
    qrspADO      : TADOStoredProc;
    procedure ShowGets;
    procedure ExecCondition(QRSP : TADOStoredProc);
    procedure CreateCondition(QRSP : TADOStoredProc);
  public
    { Public declarations }
    procedure SetModeTerm(Mode : integer);
    procedure SetOrder(Order : integer);
    procedure SetRN(RN : integer);
    procedure SetPrice(Price : real);
    procedure SetClient(Client : string);
    procedure SetUser(IDUSER : integer);
    procedure SetArtCode(Code : integer);
    procedure SetArtName(Name : string);
    procedure SetRemnTerm(RemnTerm : integer);
  end;

  const
  cFModeTerm_JSO = 1; { Журнал интернет-заказов }

var
  frmCCJS_ArtCodeTerm: TfrmCCJS_ArtCodeTerm;

implementation

uses
  Util,
  UMain, UCCenterJournalNetZkz;

{$R *.dfm}

procedure TfrmCCJS_ArtCodeTerm.FormCreate(Sender: TObject);
begin
  ISignActive := 0;
end;

procedure TfrmCCJS_ArtCodeTerm.FormActivate(Sender: TObject);
var
  SCaption : string;
begin
  if ISignActive = 0 then begin
    { Иконка окна }
    FCCenterJournalNetZkz.imgMain.GetIcon(194,self.Icon);
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
    SCaption := 'Остаток для бронирования: '+IntToStr(itemRemnTerm);
    pnlTop_RemnTerm.Caption := SCaption; pnlTop_RemnTerm.Width := TextPixWidth(SCaption, pnlTop_RemnTerm.Font) + 20;
    ISignActive := 1;
    { Подставляем набор данных }
    case ModeTerm of
      cFModeTerm_JSO: begin
        self.Caption := 'Интернет заказы. Сроковый товар';
        dsTerm.DataSet := qrspJSOterm;
        qrspADO := qrspJSOterm;
        ExecCondition(qrspADO);
      end;
    end;
  end;
end;

procedure TfrmCCJS_ArtCodeTerm.ShowGets;
var
  SCaption : string;
begin
  if ISignActive = 1 then begin
    //SCaption := 'В одном чеке не может быть больше ' + DBGrid.DataSource.DataSet.FieldByName('NCheckKol').AsString + ' шт.';
    //pnlControl_Show.Caption := SCaption; pnlControl_Show.Width := TextPixWidth(SCaption, pnlControl_Show.Font) + 20
  end;
end;

procedure TfrmCCJS_ArtCodeTerm.SetModeTerm(Mode : integer);
begin
  ModeTerm := Mode;
end;

procedure TfrmCCJS_ArtCodeTerm.SetOrder(Order : integer);
begin
  OrderID := Order;
end;

procedure TfrmCCJS_ArtCodeTerm.SetRN(RN : integer);
begin
  NRN := RN;
end;

procedure TfrmCCJS_ArtCodeTerm.SetPrice(Price : real);
begin
  OrderPrice := Price;
end;

procedure TfrmCCJS_ArtCodeTerm.SetClient(Client : string);
begin
  OrderClient := Client;
end;

procedure TfrmCCJS_ArtCodeTerm.SetUser(IDUSER : integer);
begin
  NUSER := IDUSER;
end;

procedure TfrmCCJS_ArtCodeTerm.SetArtCode(Code : integer);
begin
  ArtCode := Code;
end;

procedure TfrmCCJS_ArtCodeTerm.SetArtName(Name : string);
begin
  ArtName := Name;
end;

procedure TfrmCCJS_ArtCodeTerm.SetRemnTerm(RemnTerm : integer);
begin
  itemRemnTerm := RemnTerm;
end;

procedure TfrmCCJS_ArtCodeTerm.ExecCondition(QRSP : TADOStoredProc);
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

procedure TfrmCCJS_ArtCodeTerm.CreateCondition(QRSP : TADOStoredProc);
begin
  QRSP.Parameters.ParamValues['@NRN'] := NRN;
end;

procedure TfrmCCJS_ArtCodeTerm.aMain_ExitExecute(Sender: TObject);
begin
  Self.Close;
end;

end.
