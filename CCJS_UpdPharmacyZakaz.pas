unit CCJS_UpdPharmacyZakaz;
{ © PgkSoft. 26.09.2014
  Замена аптеки в незабронированном заказе
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, Grids, DBGrids, ActnList, DB, ADODB,
  StdCtrls, Menus, ToolWin, uSprQuery, uDMJSO, uActionCore, UtilsBase;

type
  TfrmCCJS_UpdPharmacyZakaz = class(TForm)
    pnlHeading: TPanel;
    pnlHZakaz: TPanel;
    pnlHZSum: TPanel;
    pnlHZHShipName: TPanel;
    pnlHZShipStreet: TPanel;
    pnlStatus: TPanel;
    StatusBarMain: TStatusBar;
    pnlControl: TPanel;
    pnlControl_Right: TPanel;
    pnlControl_Left: TPanel;
    pnlGridMain: TPanel;
    DBGridMain: TDBGrid;
    SplitterGridMain: TSplitter;
    pnlMainControl: TPanel;
    pnlMainControl_Right: TPanel;
    pnlMainControl_Left: TPanel;
    pnlSlaveControl: TPanel;
    pnlSlaveControl_Right: TPanel;
    pnlSlaveControl_Left: TPanel;
    pnlGridSlave: TPanel;
    DBGridSlave: TDBGrid;
    qrspMain: TADOStoredProc;
    dsMain: TDataSource;
    ActionListMain: TActionList;
    qrspSlave: TADOStoredProc;
    dsSlave: TDataSource;
    chbxOnlyCount: TCheckBox;
    aPickPharmacy: TAction;
    pmSlave: TPopupMenu;
    pmiSlave_PickPharmacy: TMenuItem;
    toolBarControl: TToolBar;
    tlbtnPickPharmacy: TToolButton;
    ToolButton1: TToolButton;
    aExit: TAction;
    spUpdPharmacyZakaz: TADOStoredProc;
    spSetKoefItemOrder: TADOStoredProc;
    tlbrSlave: TToolBar;
    tlbtnCheck: TToolButton;
    aSlave_Check: TAction;
    N1: TMenuItem;
    pnlLocate: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dsMainDataChange(Sender: TObject; Field: TField);
    procedure chbxOnlyCountClick(Sender: TObject);
    procedure aPickPharmacyExecute(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure DBGridMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridSlaveDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aSlave_CheckExecute(Sender: TObject);
    procedure DBGridSlaveKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridSlaveKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    LocatePharmacy : string;
    ISign_Active   : integer;
    NomerZakaza    : integer;
    OldPharmacy    : string;
    SPharmacyNew   : string;
    NPharmacyNew   : integer;
    NUSER          : integer;
    FOnAction: TUpdPharmEvent;
    FActionResult: TActionResult;
    procedure ShowGets;
    procedure InitStatusBar;
    procedure CreateConditionSlave;
  public
    { Public declarations }
    procedure SetUser(Parm : integer);
    function GetSPharmacyNew : string;
    function GetNPharmacyNew : integer;
    function ShowDialog(OnAction: TUpdPharmEvent): TActionResult;
  end;

var
  frmCCJS_UpdPharmacyZakaz: TfrmCCJS_UpdPharmacyZakaz;

implementation

uses Umain, UCCenterJournalNetZkz, Util, StrUtils, ExDBGRID;

{$R *.dfm}

procedure TfrmCCJS_UpdPharmacyZakaz.CreateConditionSlave;
var
  ISignMeas : integer;
begin
  ISignMeas := DBGridMain.DataSource.DataSet.FieldByName('ISignMeas').AsInteger;
  qrspSlave.Parameters.ParamValues['@ItemCode'] := DBGridMain.DataSource.DataSet.FieldByName('NArtCode').AsInteger;
  if ISignMeas = 0 then begin
    { Ед.изм. - Упаковка }
    qrspSlave.Parameters.ParamValues['@itemQuantity'] := DBGridMain.DataSource.DataSet.FieldByName('NArtCount').AsInteger *
                                                         DBGridMain.DataSource.DataSet.FieldByName('NKoef_Opt').AsInteger;
  end else if ISignMeas = 1 then begin
    { Ед.изм. - Штука }
    qrspSlave.Parameters.ParamValues['@itemQuantity'] := DBGridMain.DataSource.DataSet.FieldByName('NArtCount').AsInteger;
  end else begin
    { По умолчанию штуки }
    qrspSlave.Parameters.ParamValues['@itemQuantity'] := DBGridMain.DataSource.DataSet.FieldByName('NArtCount').AsInteger;
  end;
  if chbxOnlyCount.Checked
    then qrspSlave.Parameters.ParamValues['@OnlyCount'] := 1
    else qrspSlave.Parameters.ParamValues['@OnlyCount'] := 0;
end;

procedure TfrmCCJS_UpdPharmacyZakaz.InitStatusBar;
begin
  StatusBarMain.SimpleText := 'АртКод = ' + VarToStr(DBGridMain.DataSource.DataSet.FieldByName('NArtCode').AsInteger) + ', ' +
                              DBGridMain.DataSource.DataSet.FieldByName('SArtName').AsString + ', ' +
                              'Цена = ' + VarToStr(DBGridMain.DataSource.DataSet.FieldByName('NArtPrice').Asfloat);
end;

procedure TfrmCCJS_UpdPharmacyZakaz.ShowGets;
begin
  InitStatusBar;
  pnlMainControl_Right.Caption := 'Позиций в заказе ' + VarToStr(qrspMain.RecordCount) + DupeString(' ',3);
  pnlSlaveControl_Right.Caption := 'Выбрано аптек: ' + VarToStr(qrspSlave.RecordCount) + DupeString(' ',3);
  if DBGridSlave.DataSource.DataSet.IsEmpty then begin
    aPickPharmacy.Enabled := false;
  end else begin
    aPickPharmacy.Enabled := true;
  end;
end;

procedure TfrmCCJS_UpdPharmacyZakaz.FormCreate(Sender: TObject);
begin
  ISign_Active := 0;
  LocatePharmacy := '';
  pnlLocate.Visible := false;
  if FCCenterJournalNetZkz.dbGridMain.DataSource.DataSet.IsEmpty then begin
    NomerZakaza := 0;
    OldPharmacy := '';
  end else begin
    NomerZakaza := FCCenterJournalNetZkz.DBGridMain.DataSource.DataSet.FieldByName('orderID').AsInteger;
    OldPharmacy := FCCenterJournalNetZkz.DBGridMain.DataSource.DataSet.FieldByName('apteka').AsString;
  end;
  SPharmacyNew := '';
  NPharmacyNew := 0;
end;

procedure TfrmCCJS_UpdPharmacyZakaz.FormActivate(Sender: TObject);
var
  SCaption  : string;
  SSignMeas : string;
begin
  if ISign_Active = 0 then begin
    { Панель заголовка }
    SCaption := 'Заказ №: ' + VarToStr(NomerZakaza) + ' от ' + AsString(FCCenterJournalNetZkz.DBGridMain.DataSource.DataSet, 'OrderDt');
    pnlHZakaz.Caption := SCaption;  pnlHZakaz.Width := TextPixWidth(SCaption, pnlHZakaz.Font) + 10;
    SCaption := ' Сумма: ' + VarToStr(FCCenterJournalNetZkz.DBGridMain.DataSource.DataSet.FieldByName('orderAmount').AsFloat);
    pnlHZSum.Caption := SCaption;  pnlHZSum.Width := TextPixWidth(SCaption, pnlHZSum.Font) + 10;
    SCaption := ' Клиент: ' + FCCenterJournalNetZkz.DBGridMain.DataSource.DataSet.FieldByName('orderShipName').AsString;
    pnlHZHShipName.Caption := SCaption;  pnlHZHShipName.Width := TextPixWidth(SCaption, pnlHZHShipName.Font) + 10;
    SCaption := ' Адрес: ' + FCCenterJournalNetZkz.DBGridMain.DataSource.DataSet.FieldByName('orderShipStreet').AsString;
    pnlHZShipStreet.Caption := SCaption;
    StatusBarMain.SimpleText := 'Определение коэффициентов...';
    try
      spSetKoefItemOrder.Parameters.ParamByName('@Order').Value := NomerZakaza;
      spSetKoefItemOrder.ExecProc;
    except
      on e:Exception do begin end;
    end;
    { Загрузка данных }
    if FCCenterJournalNetZkz.dbGridMain.DataSource.DataSet.IsEmpty then
      begin
        qrspMain.Active := false;
        qrspMain.Parameters.ParamByName('@PRN').Value := 0;
        qrspMain.Active := true;
      end
    else
      begin
        qrspMain.Active := false;
        qrspMain.Parameters.ParamByName('@PRN').Value := NomerZakaza;
        qrspMain.Active := true;
      end;
    { Уточнение заголовка столбцов по единице измерения }
    SSignMeas := DBGridMain.DataSource.DataSet.FieldByName('SSignMeas').AsString;
    get_column_by_fieldname('NArtPrice',DBGridMain).Title.Caption := 'Цена сайта ('+SSignMeas+')';
    { Окно стало активным }
    ISign_Active := 1;
    ShowGets;
  end;
end;

function TfrmCCJS_UpdPharmacyZakaz.GetSPharmacyNew : string;  begin result := SPharmacyNew; end;
function TfrmCCJS_UpdPharmacyZakaz.GetNPharmacyNew : integer; begin result := NPharmacyNew; end;
procedure TfrmCCJS_UpdPharmacyZakaz.SetUser(Parm : integer); begin NUSER := Parm; end;

procedure TfrmCCJS_UpdPharmacyZakaz.dsMainDataChange(Sender: TObject; Field: TField);
begin
  { Получаем список аптек }
  qrspSlave.Active := false;
  CreateConditionSlave;
  qrspSlave.Active := true;
  ShowGets;
  if pnlLocate.Visible then
    DBGridSlave.DataSource.DataSet.Locate('SAptekaName',AnsiLowerCase(LocatePharmacy),[loCaseInsensitive,loPartialKey]);
end;

procedure TfrmCCJS_UpdPharmacyZakaz.chbxOnlyCountClick(Sender: TObject);
begin
  { Получаем список аптек }
  qrspSlave.Active := false;
  CreateConditionSlave;
  qrspSlave.Active := true;
  ShowGets;
end;

{ Выбрать аптеку }
procedure TfrmCCJS_UpdPharmacyZakaz.aPickPharmacyExecute(Sender: TObject);
begin
  if MessageDLG('Подтвердите выбор аптеки.',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
    if Assigned(FOnAction) then
    begin
      TActionCore.Clear_ActionResult(FActionResult);
      try
        FOnAction(NomerZakaza, NUSER, DBGridSlave.DataSource.DataSet.FieldByName('NAptekaID').AsInteger, FActionResult);
        if FActionResult.IErr <> 0 then
          ShowError(FActionResult.ExecMsg)
        else
          ModalResult := mrOk;
      except
        on E: Exception do
        begin
          FActionResult.IErr := cDefError;
          FActionResult.ExecMsg := TrimRight(E.Message + ' ' + FActionResult.ExecMsg);
          ShowError(FActionResult.ExecMsg);
        end;
      end
    end  
    else
    begin
      try
        spUpdPharmacyZakaz.Parameters.ParamValues['@orderID']    := NomerZakaza;
        spUpdPharmacyZakaz.Parameters.ParamValues['@IDPharmacy'] := DBGridSlave.DataSource.DataSet.FieldByName('NAptekaID').AsInteger;
        spUpdPharmacyZakaz.Parameters.ParamValues['@USER'] := NUSER;
        spUpdPharmacyZakaz.ExecProc;
        SPharmacyNew := DBGridSlave.DataSource.DataSet.FieldByName('SAptekaName').AsString;
        NPharmacyNew := DBGridSlave.DataSource.DataSet.FieldByName('NAptekaID').AsInteger;
        self.Close;
      except
        on e:Exception do
          begin
            ShowMessage('Сбой при исправлении аптеки. Попробуйте еще раз');
          end;
      end;
    end;
  end;
end;

{ Закрыть }
procedure TfrmCCJS_UpdPharmacyZakaz.aExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJS_UpdPharmacyZakaz.DBGridMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TfrmCCJS_UpdPharmacyZakaz.DBGridSlaveDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
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

procedure TfrmCCJS_UpdPharmacyZakaz.aSlave_CheckExecute(Sender: TObject);
begin
  StatusBarMain.SimpleText := 'Проверка количества остатков в резерве...';
  { Проверяем наличие }
  dmJSO.ShowGoodsPharmState(DBGridMain.DataSource.DataSet.FieldByName('NArtCode').AsInteger,
    DBGridSlave.DataSource.DataSet.FieldByName('NAptekaID').AsInteger,
    'Наличие <' + DBGridMain.DataSource.DataSet.FieldByName('SArtName').AsString + '> в аптеке <' + DBGridSlave.DataSource.DataSet.FieldByName('SAptekaName').AsString + '>'
  );
  ShowGets;
end;

procedure TfrmCCJS_UpdPharmacyZakaz.DBGridSlaveKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key in [27,37,38,39,40,13] then begin
    LocatePharmacy := '';
    pnlLocate.Visible := false;
  end;
end;

procedure TfrmCCJS_UpdPharmacyZakaz.DBGridSlaveKeyPress(Sender: TObject; var Key: Char);
var
  S : String;
begin
  S := AnsiUpperCase(LocatePharmacy + Key);
  if DBGridSlave.DataSource.DataSet.Locate('SAptekaName',AnsiLowerCase(S),[loCaseInsensitive,loPartialKey]) then begin
    LocatePharmacy := S;
    pnlLocate.Top := DBGridSlave.Height - pnlLocate.Height - 3;
    pnlLocate.Visible := true;
    pnlLocate.Caption := LocatePharmacy;
    pnlLocate.Width := TextPixWidth(LocatePharmacy, pnlLocate.Font) + 20;
  end;
end;

procedure TfrmCCJS_UpdPharmacyZakaz.FormResize(Sender: TObject);
begin
  pnlLocate.Top := DBGridSlave.Height - pnlLocate.Height - 3;
end;

function TfrmCCJS_UpdPharmacyZakaz.ShowDialog(OnAction: TUpdPharmEvent): TActionResult;
begin
  FOnAction := OnAction;
  ShowModal;
  Result.IErr := FActionResult.IErr;
  Result.ExecMsg := FActionResult.ExecMsg;
end;

end.
