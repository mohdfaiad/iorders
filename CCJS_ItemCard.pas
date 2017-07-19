unit CCJS_ItemCard;

interface

uses
  UCCenterJournalNetZkz,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, ActnList, ToolWin, Grids, DBGrids,
  DB, ADODB, StrUtils, JOPH_DM, uActionCore, UtilsBase;

type
  TfrmCCJS_ItemCard = class(TForm)
    pnlTop: TPanel;
    pnlTop_Order: TPanel;
    pnlTop_OrderShipping: TPanel;
    pnlPage: TPanel;
    pageControl: TPageControl;
    pnlControl: TPanel;
    pnlControl_Tool: TPanel;
    pnlControl_Show: TPanel;
    tabItem: TTabSheet;
    tabDistribute: TTabSheet;
    tabTerm: TTabSheet;
    pnlTabItem: TPanel;
    pnlTabDistribute: TPanel;
    pnlTabTerm: TPanel;
    pnlTop_Client: TPanel;
    tabParts: TTabSheet;
    pnlTabParts: TPanel;
    pnlAction: TPanel;
    lblItemCode: TLabel;
    lblItemName: TLabel;
    lblItemQuantity: TLabel;
    lblItemPrice: TLabel;
    lblKoef_Opt: TLabel;
    lblSNameMeas: TLabel;
    lblSPharmacy: TLabel;
    lblItemCountInPresence: TLabel;
    lblPricePfarmacy: TLabel;
    lblSignModeReserve: TLabel;
    lblCalcPriceWithKoef: TLabel;
    edSignModeReserve: TEdit;
    edItemCode: TEdit;
    edItemName: TEdit;
    edItemQuantity: TEdit;
    edItemPrice: TEdit;
    edSNameMeas: TEdit;
    edKoef_Opt: TEdit;
    edSPharmacy: TEdit;
    edCountInPresence: TEdit;
    edPricePfarmacy: TEdit;
    edCalcPriceWithKoef: TEdit;
    ActionList: TActionList;
    lblSArmourDate: TLabel;
    edSArmourDate: TEdit;
    lblSArmourDateClose: TLabel;
    edSArmourDateClose: TEdit;
    lblSCheckDate: TLabel;
    edSCheckDate: TEdit;
    lblSCheckNote: TLabel;
    edSCheckNote: TEdit;
    aControl_Save: TAction;
    aControl_Close: TAction;
    toolbarControl: TToolBar;
    tlbtnControl_Save: TToolButton;
    tlbtnControl_Close: TToolButton;
    pnlTabDistribute_Top: TPanel;
    pnlTabDistribute_Top_Show: TPanel;
    pnlTabDistribute_Top_Tool: TPanel;
    toolbarDistribute: TToolBar;
    pnlTabDistribute_Grid: TPanel;
    GridDistribute: TDBGrid;
    pnlTabDistribute_Header: TPanel;
    pnlTabDistribute_Header_Count: TPanel;
    pnlTabDistribute_Header_Price: TPanel;
    pnlTabDistribute_Header_Koef: TPanel;
    qrspDistribute: TADOStoredProc;
    dsDistribute: TDataSource;
    aSLNomenclature: TAction;
    btnSlArtCode: TButton;
    spItemUpdate: TADOStoredProc;
    spGetPackingCoefficient: TADOStoredProc;
    spItemCardVerifyUnique: TADOStoredProc;
    spItemInert: TADOStoredProc;
    spAddItemUpdate: TADOStoredProc;
    lbState: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aControl_SaveExecute(Sender: TObject);
    procedure GridDistributeDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aControl_CloseExecute(Sender: TObject);
    procedure aSLNomenclatureExecute(Sender: TObject);
    procedure edItemQuantityChange(Sender: TObject);
    procedure edItemCodeChange(Sender: TObject);
  private
    ISignActive              : integer;
    { Входные параметры }
    ModeAction               : smallint;
    FExtComments             : string;
    FTrySave                 : Boolean;
    RecSession               : TUserSession;
    RecRegAction             : TRegAction;
    RecJSOHeader             : TJSO_OrderHeaderItem;
    RecItemOld               : TJSO_ItemOrder;
    RecItemNew               : TJSO_ItemOrder;
    RecSelectItem            : TNetNomenclature;
    RecRemnItemIPA           : TRemnItemIPA;
    RecNetTermItem           : TNetTermItem;
    NUSER                    : integer;
    OrderShipping            : string;
    Client                   : string;
    FOnUpd: TActionSpecEvent;
    FOnIns: TActionSpecEvent;
    FActionResult: TActionResult;
    procedure ShowGets;
    procedure ExecConditionDistribute;
    procedure CheckField(SignEnabled : boolean);
    procedure TuneField(edField : TEdit);
    procedure PropEditField(edField : TEdit;  SignReadOnly : boolean);
    procedure PropNotEditField(edField : TEdit);
    procedure ShowLableFieldEnable(lblField : TLabel);
    procedure ShowLableFieldNotEdit(lblField : TLabel);
    function  GetSignValueFieldChange : boolean;
  public
    procedure SetModeAction(Parm : smallint);
    procedure SetRecItem(Parm : TJSO_ItemOrder);
    procedure SetUser(Parm : integer);
    procedure SetOrderShipping(Parm : string);
    procedure SetClient(Parm : string);
    procedure SetRecSession(Parm : TUserSession);
    procedure SetRegAction(Parm : TRegAction);
    procedure SetRecJSOHeader(Parm : TJSO_OrderHeaderItem);
    function ShowDialog(OnUpd, OnIns: TActionSpecEvent): TActionResult;
    property ExtComments: string read FExtComments write FExtComments;
    property TrySave: Boolean read FTrySave;
  end;

const
  { Режим работы }
  cJSOItemCard_Upd  = 0;
  cJSOItemCard_Add  = 1;
  cJSOItemCard_Read = 2;

var
  frmCCJS_ItemCard: TfrmCCJS_ItemCard;

implementation

uses
  Util,
  UMain, ExDBGRID, UReference, CCJS_Nomenclature, CCJO_DefOrderItems;

const
  sMsgQuantityTypeInt = 'Количество товарной позиции имеет целочисленный формат';
  sMsgErrDeffKoefUpack = 'Сбой при определении коэффициента упаковки.';

{$R *.dfm}

procedure TfrmCCJS_ItemCard.ExecConditionDistribute;
begin
  qrspDistribute.Active := false;
  qrspDistribute.Parameters.ParamByName('@itemID').Value    := RecItemOld.itemID;
  qrspDistribute.Parameters.ParamByName('@TypeTable').Value := RecItemOld.STypeTable;
  qrspDistribute.Active := true;
end;

procedure TfrmCCJS_ItemCard.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
  { Режим работы по умолчанию }
  ModeAction := cJSOItemCard_Read;
  FTrySave := False;
end;

procedure TfrmCCJS_ItemCard.FormActivate(Sender: TObject);
var
  SCaption : string;
begin
  if ISignActive = 0 then begin
    { Стартовая закладка }
    pageControl.ActivePage := tabItem;
    { Отражаем реквизиты заказа }
    SCaption := 'Заказ № ' + VarToStr(RecItemOld.orderID);
    pnlTop_Order.Caption := SCaption; pnlTop_Order.Width := TextPixWidth(SCaption, pnlTop_Order.Font) + 20;
    SCaption := RecJSOHeader.OrderShipping;
    pnlTop_OrderShipping.Caption := SCaption; pnlTop_OrderShipping.Width := TextPixWidth(SCaption, pnlTop_OrderShipping.Font) + 20;
    SCaption := RecJSOHeader.orderShipName;
    pnlTop_Client.Caption := SCaption; pnlTop_Client.Width := TextPixWidth(SCaption, pnlTop_Client.Font) + 10;
    aSLNomenclature.Enabled   := false;
    { Инициализация полей }
    if ModeAction = cJSOItemCard_Add then begin
      RecItemOld.itemQuantity := 1;
      RecItemOld.SignMeas     := 1;    { единица измерения по умолчанию }
      RecItemOld.SNameMeas    := 'шт';
    end;
    RecItemNew := RecItemOld;
    if ModeAction in [cJSOItemCard_Upd,cJSOItemCard_Read] then begin
      if      RecItemOld.SignModeReserve = 1 then edSignModeReserve.Text := 'бронирование'
      else if RecItemOld.SignModeReserve = 2 then edSignModeReserve.Text := 'возврат'
      else if RecItemOld.SignModeReserve = 3 then edSignModeReserve.Text := 'бронирование/возврат'
      else edSignModeReserve.Text := '';
      edItemCode.Text          := VarToStr(RecItemOld.itemCode);
      edItemName.Text          := RecItemOld.itemName;
      edItemQuantity.Text      := VarToStr(RecItemOld.itemQuantity);
      edItemPrice.Text         := VarToStr(RecItemOld.itemPrice);
      edSNameMeas.Text         := RecItemOld.SNameMeas;
      edKoef_Opt.Text          := VarToStr(RecItemOld.Koef_Opt);
      edSPharmacy.Text         := RecItemOld.SPharmacy;
      edCountInPresence.Text   := VarToStr(RecItemOld.itemCountInPresence);
      edPricePfarmacy.Text     := VarToStr(RecItemOld.PricePharmacy);
      edCalcPriceWithKoef.Text := VarToStr(RecItemOld.CalcPriceWithKoef);
      edSArmourDate.Text       := RecItemOld.SArmourDate;
      edSArmourDateClose.Text  := RecItemOld.SArmourDateClose;
      edSCheckDate.Text        := RecItemOld.SCheckDate;
      edSCheckNote.Text        := RecItemOld.SCheckNote;
    end;
    { Остальные при старте прячем. В ShowGets - анализ на видимость }
    tabDistribute.TabVisible := false;
    tabTerm.TabVisible       := false;
    tabParts.TabVisible      := false;
    { Дополнительный анализ на открытие закладки }
    if RecItemOld.SignDistribute = 1 then begin
      tabDistribute.TabVisible := true;
      ExecConditionDistribute;
    end;
    if RecItemOld.SignArmorTerm = 1 then begin
      tabTerm.TabVisible := true;
    end;
    if RecItemOld.SignDivideParts = 1 then begin
      tabParts.TabVisible := true;
    end;
    { Первичная настройка доступа к элементам управления }
    lbState.Caption :=  FExtComments;
    if ModeAction = cJSOItemCard_Read then begin
      Self.Caption := Self.Caption + ' ' + 'ПРОСМОТР';
      aControl_Save.Enabled := false;
      tabItem.ImageIndex := 390;
    end else if ModeAction = cJSOItemCard_Add then begin
      Self.Caption := Self.Caption + ' ' + 'ДОБАВЛЕНИЕ';
      aControl_Save.Enabled := true;
      tabItem.ImageIndex := 273;
      CheckField(true);
    end else if ModeAction = cJSOItemCard_Upd then begin
      Self.Caption := Self.Caption + ' ' + 'РЕДАКТИРОВАНИЕ';
      aControl_Save.Enabled := true;
      tabItem.ImageIndex := 275;
      CheckField(true);
    end else begin
      Self.Caption := Self.Caption + ' ' + 'ПРОСМОТР';
      aControl_Save.Enabled := false;
      tabItem.ImageIndex := 390;
    end;
    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJS_ItemCard.TuneField(edField : TEdit);
begin
  if edField.ReadOnly then
    edField.Color := clBtnFace
  else
    edField.Color := clWindow;
end;

procedure TfrmCCJS_ItemCard.CheckField(SignEnabled : boolean);
begin
  if SignEnabled then begin
    PropEditField(edItemCode,false);  ShowLableFieldEnable(lblItemCode);
    edItemCode.ReadOnly := true;
    PropEditField(edItemQuantity,false);  ShowLableFieldEnable(lblItemQuantity);
    aSLNomenclature.Enabled := true;
    if aSLNomenclature.Enabled then
      edItemCode.Color := clWindow;
  end;
end;

procedure TfrmCCJS_ItemCard.ShowGets;
var
  SCaption  : string;
begin
  if ISignActive = 1 then begin
    if RecItemOld.SignDistribute = 1 then begin
      { Отображаем количество записей }
      SCaption := VarToStr(qrspDistribute.RecordCount);
      pnlTabDistribute_Top_Show.Caption := SCaption;
      pnlTabDistribute_Top_Show.Width := TextPixWidth(SCaption, pnlTabDistribute_Top_Show.Font) + 20;
    end;
    { Доступ к элементам управления }
    if  GetSignValueFieldChange then aControl_Save.Enabled := true
                                else aControl_Save.Enabled := false;
  end;
end;

function TfrmCCJS_ItemCard.GetSignValueFieldChange : boolean;
var
  bResReturn : boolean;
begin
  bResReturn := true;
  if     (RecItemNew.itemCode     = RecItemOld.itemCode    )
     and (RecItemNew.itemQuantity = RecItemOld.itemQuantity)
     and (RecItemNew.aptekaID = RecItemOld.aptekaID)
  then bResReturn := false;
  result := bResReturn;
end;

procedure TfrmCCJS_ItemCard.SetModeAction(Parm : smallint); begin ModeAction := Parm; end;
procedure TfrmCCJS_ItemCard.SetRecItem(Parm : TJSO_ItemOrder); begin RecItemOld := Parm; end;
procedure TfrmCCJS_ItemCard.SetUser(Parm : integer); begin NUSER := Parm; end;
procedure TfrmCCJS_ItemCard.SetOrderShipping(Parm : string); begin OrderShipping := Parm; end;
procedure TfrmCCJS_ItemCard.SetClient(Parm : string); begin Client := Parm; end;
procedure TfrmCCJS_ItemCard.SetRecSession(Parm : TUserSession); begin RecSession := Parm; end;
procedure TfrmCCJS_ItemCard.SetRegAction(Parm : TRegAction); begin RecRegAction := Parm; end;
procedure TfrmCCJS_ItemCard.SetRecJSOHeader(Parm : TJSO_OrderHeaderItem); begin RecJSOHeader := Parm; end;

procedure TfrmCCJS_ItemCard.PropEditField(edField : TEdit; SignReadOnly : boolean);
begin
  edField.BevelKind   := bkNone;
  edField.Ctl3D       := false;
  edField.BorderStyle := bsSingle;
  edField.ReadOnly    := SignReadOnly;
  edField.TabStop     := true;
  TuneField(edField);
end;

procedure TfrmCCJS_ItemCard.PropNotEditField(edField : TEdit);
begin
  edField.BevelKind   := bkFlat;
  edField.Ctl3D       := True;
  edField.BorderStyle := bsNone;
  edField.ReadOnly    := True;
  edField.Color       := clWindow;
  edField.Height      := 19;
  TuneField(edField);
end;

procedure TfrmCCJS_ItemCard.ShowLableFieldEnable(lblField : TLabel);
var
  SCaption    : string;
  lblLeftOld  : integer;
  lblWidthOld : integer;
  lblLeftNew  : integer;
  lblWidthNew : integer;
begin
  SCaption := lblField.Caption;
  lblLeftOld := lblField.Left;
  lblWidthOld := TextPixWidth(SCaption, lblField.Font);
  lblField.Font.style := [fsBold];
  lblField.Font.Name := 'Arial Narrow';
  lblWidthNew := TextPixWidth(SCaption, lblField.Font);
  lblLeftNew := lblLeftOld - (lblWidthNew - lblWidthOld);
  lblField.Left := lblLeftNew;
end;

procedure TfrmCCJS_ItemCard.ShowLableFieldNotEdit(lblField : TLabel);
var
  SCaption    : string;
  lblLeftOld  : integer;
  lblWidthOld : integer;
  lblLeftNew  : integer;
  lblWidthNew : integer;
begin
  SCaption := lblField.Caption;
  lblLeftOld := lblField.Left;
  lblWidthOld := TextPixWidth(SCaption, lblField.Font);
  lblField.Font.Style := [];
  lblField.Font.Name := 'MS Sans Serif';
  lblWidthNew := TextPixWidth(SCaption, lblField.Font);
  lblLeftNew := lblLeftOld - (lblWidthNew - lblWidthOld);
  lblField.Left := lblLeftNew;
end;

{***************************
 * Обработка действий
 ***************************}
procedure TfrmCCJS_ItemCard.aControl_SaveExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
  RecUpd: TJSO_ItemOrder;
begin
  if MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  FTrySave := True;
  if (ModeAction = cJSOItemCard_Upd) and (RecItemOld.STypeTable = csOrderItemTypeTable_Main) then begin
    if Assigned(FOnUpd) then
    begin
      try
        RecUpd.orderID := RecItemOld.orderID;
        RecUpd.itemID := RecItemOld.itemID;
        RecUpd.itemCode := StrToInt(edItemCode.Text);
        RecUpd.itemName := edItemName.Text;
        RecUpd.itemQuantity := StrToInt(edItemQuantity.Text);
        RecUpd.itemPrice := StrToCurr(edItemPrice.Text);
        RecUpd.aptekaID := RecItemNew.aptekaID;
        RecUpd.itemCountInPresence := RecItemNew.itemCountInPresence;
        RecUpd.PricePharmacy := RecItemNew.PricePharmacy;
        RecUpd.Koef_Opt := StrToInt(edKoef_Opt.Text);

        FOnUpd(Self, FActionResult, RecUpd, true);
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
      end;
    end
    else
    begin
      try
        spItemUpdate.Parameters.ParamValues['@USER']                := NUSER;
        spItemUpdate.Parameters.ParamValues['@Order']               := RecItemOld.orderID;
        spItemUpdate.Parameters.ParamValues['@RN']                  := RecItemOld.itemID;
        spItemUpdate.Parameters.ParamValues['@ArtCodeOld']          := RecItemOld.itemCode;
        spItemUpdate.Parameters.ParamValues['@ArtNameOld']          := RecItemOld.itemName;
        spItemUpdate.Parameters.ParamValues['@ArtPriceOld']         := RecItemOld.itemPrice;
        spItemUpdate.Parameters.ParamValues['@ArtQuantityOld']      := RecItemOld.itemQuantity;
        spItemUpdate.Parameters.ParamValues['@ArtCodeNew']          := StrToInt(edItemCode.Text);
        spItemUpdate.Parameters.ParamValues['@ArtNameNew']          := edItemName.Text;
        spItemUpdate.Parameters.ParamValues['@ArtPriceNew']         := StrToCurr(edItemPrice.Text);
        spItemUpdate.Parameters.ParamValues['@ArtQuantityNew']      := StrToInt(edItemQuantity.Text);
        spItemUpdate.Parameters.ParamValues['@KoefUpack']           := StrToInt(edKoef_Opt.Text);
        spItemUpdate.Parameters.ParamValues['@AptekaID']            := RecItemNew.aptekaID;
        spItemUpdate.Parameters.ParamValues['@ItemCountInPresence'] := RecItemNew.itemCountInPresence;
        spItemUpdate.Parameters.ParamValues['@PricePharmacy']       := RecItemNew.PricePharmacy;
        spItemUpdate.ExecProc;
        IErr := spItemUpdate.Parameters.ParamValues['@RETURN_VALUE'];
        if IErr <> 0 then begin
          SErr := spItemUpdate.Parameters.ParamValues['@SErr'];
          ShowMessage(SErr);
        end;
      except
            on e:Exception do begin
              ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
            end;
      end;
    end
  end else if (ModeAction = cJSOItemCard_Upd) and (RecItemOld.STypeTable = csOrderItemTypeTable_Add) then begin
    if Assigned(FOnUpd) then
    begin
      try
        RecUpd.orderID := RecItemOld.orderID;
        RecUpd.itemID := RecItemOld.itemID;
        RecUpd.itemCode := StrToInt(edItemCode.Text);
        RecUpd.itemName := edItemName.Text;
        RecUpd.itemQuantity := StrToInt(edItemQuantity.Text);
        RecUpd.itemPrice := StrToCurr(edItemPrice.Text);
        RecUpd.aptekaID := RecItemNew.aptekaID;
        RecUpd.itemCountInPresence := RecItemNew.itemCountInPresence;
        RecUpd.PricePharmacy := RecItemNew.PricePharmacy;
        RecUpd.Koef_Opt := StrToInt(edKoef_Opt.Text);

        FOnUpd(Self, FActionResult, RecUpd, false);
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
      end;
    end
    else
    begin
      try
        spAddItemUpdate.Parameters.ParamValues['@USER']                := NUSER;
        spAddItemUpdate.Parameters.ParamValues['@Order']               := RecItemOld.orderID;
        spAddItemUpdate.Parameters.ParamValues['@RN']                  := RecItemOld.itemID;
        spAddItemUpdate.Parameters.ParamValues['@ArtCodeOld']          := RecItemOld.itemCode;
        spAddItemUpdate.Parameters.ParamValues['@ArtNameOld']          := RecItemOld.itemName;
        spAddItemUpdate.Parameters.ParamValues['@ArtPriceOld']         := RecItemOld.itemPrice;
        spAddItemUpdate.Parameters.ParamValues['@ArtQuantityOld']      := RecItemOld.itemQuantity;
        spAddItemUpdate.Parameters.ParamValues['@ArtCodeNew']          := StrToInt(edItemCode.Text);
        spAddItemUpdate.Parameters.ParamValues['@ArtNameNew']          := edItemName.Text;
        spAddItemUpdate.Parameters.ParamValues['@ArtPriceNew']         := StrToCurr(edItemPrice.Text);
        spAddItemUpdate.Parameters.ParamValues['@ArtQuantityNew']      := StrToInt(edItemQuantity.Text);
        spAddItemUpdate.Parameters.ParamValues['@KoefUpack']           := StrToInt(edKoef_Opt.Text);
        spAddItemUpdate.Parameters.ParamValues['@AptekaID']            := RecItemNew.aptekaID;
        spAddItemUpdate.Parameters.ParamValues['@ItemCountInPresence'] := RecItemNew.itemCountInPresence;
        spAddItemUpdate.Parameters.ParamValues['@PricePharmacy']       := RecItemNew.PricePharmacy;
        spAddItemUpdate.ExecProc;
        IErr := spAddItemUpdate.Parameters.ParamValues['@RETURN_VALUE'];
        if IErr <> 0 then begin
          SErr := spAddItemUpdate.Parameters.ParamValues['@SErr'];
          ShowMessage(SErr);
        end;
       except
            on e:Exception do begin
              ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
            end;
       end;
    end
  end else if ModeAction = cJSOItemCard_Add then begin
    if Assigned(FOnIns) then
    begin
      try
        RecItemNew.orderID := RecJSOHeader.orderID;
        FOnIns(Self, FActionResult, RecItemNew, false);
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
      end;
    end
    else
    begin
      try
        spItemInert.Parameters.ParamValues['@USER']                := NUSER;
        spItemInert.Parameters.ParamValues['@Order']               := RecJSOHeader.orderID;
        spItemInert.Parameters.ParamValues['@RNHIST']              := RecRegAction.RN;
        spItemInert.Parameters.ParamValues['@ArtCode']             := RecItemNew.itemCode;
        spItemInert.Parameters.ParamValues['@ArtName']             := RecItemNew.itemName;
        spItemInert.Parameters.ParamValues['@SignMeas']            := RecItemNew.SignMeas;
        spItemInert.Parameters.ParamValues['@ArtPrice']            := RecItemNew.itemPrice;
        spItemInert.Parameters.ParamValues['@ArtQuantity']         := RecItemNew.itemQuantity;
        spItemInert.Parameters.ParamValues['@KoefUpack']           := RecItemNew.Koef_Opt;
        spItemInert.Parameters.ParamValues['@AptekaID']            := RecItemNew.aptekaID;
        spItemInert.Parameters.ParamValues['@ItemCountInPresence'] := RecItemNew.itemCountInPresence;
        spItemInert.Parameters.ParamValues['@PricePharmacy']       := RecItemNew.PricePharmacy;
        spItemInert.ExecProc;
        IErr := spItemInert.Parameters.ParamValues['@RETURN_VALUE'];
        if IErr <> 0 then begin
          SErr := spItemInert.Parameters.ParamValues['@SErr'];
          ShowMessage(SErr);
        end;
      except
            on e:Exception do begin
              ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
            end;
      end;
    end;
  end;
  self.Close;
end;

procedure TfrmCCJS_ItemCard.GridDistributeDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db        : TDBGrid;
  dr        : TRect;
  sr        : TRect;
  imgWidth  : integer;
  imgHeight : integer;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if not (gdSelected in State) then begin
    { Позиция заказа, которая бронируется с использованием срокового товара }
    if db.DataSource.DataSet.FieldByName('NitemCodeTerm').AsInteger <> 0 then begin
      db.Canvas.Brush.Color := TColor($D3EFFE); { светло-коричневый }
    end;
    { Забронированные субпозиции }
    if Length(db.DataSource.DataSet.FieldByName('SArmourDate').AsString) <> 0 then begin
      (*
      db.Canvas.Brush.Color := TColor($CACACA); { Светло-серый }
      db.Canvas.Font.Color := TColor(clWindowText);
      *)
    end;
  end;
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  { Прорисовка img в столбце - признак резервирования }
  if Column.FieldName = 'ISIgnModeReserve' then begin
    db.Canvas.FillRect(Rect);
    Column.Title.Caption := '';
    try
      if (Column.Field.AsInteger = 1) then begin
        imgWidth  := FCCenterJournalNetZkz.imgArmor.Width;
        imgHeight := FCCenterJournalNetZkz.imgArmor.Height;
      end
      else if (Column.Field.AsInteger = 2) then begin
        imgWidth  := FCCenterJournalNetZkz.imgComeBack.Width;
        imgHeight := FCCenterJournalNetZkz.imgComeBack.Height;
      end;
      dr      := Rect;
      dr.Left := dr.Left + 2;
      {
      dr.Top  := dr.Top  + 2;
      }
      dr.Right  := dR.Left + imgWidth;
      dr.Bottom := dR.Top  + imgHeight;
      sR.Left   := 0;
      sR.Top    := 0;
      sR.Right  := imgWidth;
      sR.Bottom := imgHeight;
      if      (Column.Field.AsInteger = 1) then db.Canvas.CopyRect(dR,FCCenterJournalNetZkz.imgArmor.Canvas,sR)
      else if (Column.Field.AsInteger = 2) then db.Canvas.CopyRect(dR,FCCenterJournalNetZkz.imgComeBack.Canvas,sR);
    except
    end;
  end;
end;

procedure TfrmCCJS_ItemCard.aControl_CloseExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJS_ItemCard.aSLNomenclatureExecute(Sender: TObject);
const
  KoefPricePackingAsPieces = 100;
var
  IErr      : integer;
  SErr      : string;
  {--}
  procedure SetPharmAttributes(SPharmacy : string; CountInPresence: integer; PricePfarmacy : currency; CalcPriceWithKoef : currency); begin
    edSPharmacy.Text := SPharmacy;
    edCountInPresence.Text := ifthen(CountInPresence = 0,'',IntToStr(CountInPresence));
    edPricePfarmacy.Text := ifthen(PricePfarmacy = 0,'',CurrToStr(PricePfarmacy));
    edCalcPriceWithKoef.Text := ifthen(CalcPriceWithKoef = 0,'',CurrToStr(CalcPriceWithKoef));
  end;
  {--}
begin
  if aSLNomenclature.Enabled then begin
    try
      frmCCJO_DefOrderItems := TfrmCCJO_DefOrderItems.Create(Self);
      frmCCJO_DefOrderItems.SetMode(cDefOrderItems_Mode_SelectItem);
      frmCCJO_DefOrderItems.SetSource(cDefOrderItems_Source_911);
      frmCCJO_DefOrderItems.SetUserSession(RecSession);
      frmCCJO_DefOrderItems.SetRecJSOHeader(RecJSOHeader);
      frmCCJO_DefOrderItems.SetRecJSOItem(RecItemNew);
      try
        frmCCJO_DefOrderItems.ShowModal;
        if frmCCJO_DefOrderItems.GetSignSelectItem then begin
          RecSelectItem := frmCCJO_DefOrderItems.GetRecSelectItem;
          IErr := 0;
          SErr := '';
          if (
              (ModeAction = cJSOItemCard_Upd) and (RecSelectItem.NArtCode <> RecItemOld.itemCode)
             )
             or
             (
              (ModeAction = cJSOItemCard_Add)
             ) then begin
            { Проверка уникальности товарной позиции заказа }
            try
              spItemCardVerifyUnique.Parameters.ParamValues['@IDENT']   := RecSession.IDENT;
              spItemCardVerifyUnique.Parameters.ParamValues['@USER']    := NUSER;
              spItemCardVerifyUnique.Parameters.ParamValues['@Order']   := RecJSOHeader.orderID;
              spItemCardVerifyUnique.Parameters.ParamValues['@ArtCode'] := RecSelectItem.NArtCode;
              spItemCardVerifyUnique.ExecProc;
              IErr := spItemCardVerifyUnique.Parameters.ParamValues['@RETURN_VALUE'];
              if IErr <> 0 then begin
                SErr := spItemCardVerifyUnique.Parameters.ParamValues['@SErr'];
                ShowMessage(SErr);
              end;
            except
              on e:Exception do begin
                IErr := -1;
                ShowMessage(sMsgErrDeffKoefUpack + chr(10) + e.Message);
              end;
            end;
          end;
          if IErr = 0 then begin
            RecItemNew.itemCode     := RecSelectItem.NArtCode;
            RecItemNew.itemName     := RecSelectItem.SNomenclature;
            RecItemNew.itemPrice    := RecSelectItem.NCenaSite;
            RecItemNew.itemQuantity := RecSelectItem.ItemCount;
            RecItemNew.Koef_Opt     := RecSelectItem.NKoefUpack;
            RecItemNew.itemPrice    := RecSelectItem.NCenaSite;
            edKoef_Opt.Text     := IntToStr(RecItemNew.Koef_Opt);
            edItemCode.Text     := IntToStr(RecItemNew.itemCode);
            edItemName.Text     := RecItemNew.itemName;
            edItemQuantity.Text := IntToStr(RecItemNew.itemQuantity);
            edSNameMeas.Text    := RecItemNew.SNameMeas;
            { Уточняем цену }
            if RecItemNew.SignMeas = 0 then begin
              { Единица измерения - упаковка }
              if RecItemNew.Koef_Opt >= KoefPricePackingAsPieces then begin
                { Цена за единицу }
                edItemPrice.Text := CurrToStr(RecItemNew.itemPrice);
              end else begin
                { Цена за упаковку }
                RecItemNew.itemPrice := RecItemNew.Koef_Opt * RecItemNew.itemPrice;
                edItemPrice.Text := CurrToStr(RecItemNew.itemPrice);
              end;
            end else begin
              edItemPrice.Text := CurrToStr(RecItemNew.itemPrice);
            end;
            case RecSelectItem.SignPharm of
              cDefOrderItems_SelectItem_WithPharmItem: begin
                RecRemnItemIPA := frmCCJO_DefOrderItems.GetRecRemnItemIPA;
                RecItemNew.aptekaID            := RecRemnItemIPA.NAptekaID;
                RecItemNew.SPharmacy           := RecRemnItemIPA.SAptekaName;
                RecItemNew.itemCountInPresence := RecRemnItemIPA.NAptekaOstat;
                RecItemNew.PricePharmacy       := RecRemnItemIPA.NAptekaCena;
                RecItemNew.CalcPriceWithKoef   := RecRemnItemIPA.NAptekaCena * RecItemNew.Koef_Opt;
                SetPharmAttributes(
                                   RecItemNew.SPharmacy,
                                   Round(RecItemNew.itemCountInPresence),
                                   RecItemNew.PricePharmacy,
                                   RecItemNew.CalcPriceWithKoef
                                  );
              end;
              cDefOrderItems_SelectItem_WithPharmTerm: begin
                RecNetTermItem := frmCCJO_DefOrderItems.GetRecNetTermItem;
                RecItemNew.aptekaID            := RecNetTermItem.NAptekaID;
                RecItemNew.SPharmacy           := RecNetTermItem.SAptekaName;
                RecItemNew.itemCountInPresence := RecNetTermItem.NAptekaOstat;
                RecItemNew.PricePharmacy       := RecNetTermItem.NAptekaCena;
                RecItemNew.CalcPriceWithKoef   := RecNetTermItem.NAptekaCena * RecItemNew.Koef_Opt;
                SetPharmAttributes(
                                   RecItemNew.SPharmacy,
                                   Round(RecItemNew.itemCountInPresence),
                                   RecItemNew.PricePharmacy,
                                   RecItemNew.CalcPriceWithKoef
                                  );
              end;
              else begin
                RecItemNew.aptekaID            := 0;
                RecItemNew.SPharmacy           := '';
                RecItemNew.itemCountInPresence := 0;
                RecItemNew.PricePharmacy       := 0;
                RecItemNew.CalcPriceWithKoef   := 0;
                SetPharmAttributes(
                                   RecItemNew.SPharmacy,
                                   Round(RecItemNew.itemCountInPresence),
                                   RecItemNew.PricePharmacy,
                                   RecItemNew.CalcPriceWithKoef
                                  );
              end;
            end;
          end;
        end; { Выбрали товарную позицию }
      finally
        FreeAndNil(frmCCJO_DefOrderItems);
      end;
    except
    end;
  end;
  ShowGets;
end;

procedure TfrmCCJS_ItemCard.edItemQuantityChange(Sender: TObject);
begin
  if (not ufoTryStrToInt(edItemQuantity.Text)) or (length(trim(edItemQuantity.Text)) = 0) then begin
    (Sender as TEdit).Font.Color := clRed;
  end else begin
    RecItemNew.itemQuantity := StrToInt(edItemQuantity.Text);
    edItemQuantity.Font.Color := clWindowText;
  end;
  ShowGets;
end;

procedure TfrmCCJS_ItemCard.edItemCodeChange(Sender: TObject);
begin
  RecItemNew.itemCode := StrToInt(edItemCode.Text);
  ShowGets;
end;

function TfrmCCJS_ItemCard.ShowDialog(OnUpd, OnIns: TActionSpecEvent): TActionResult;
begin
  FOnIns := OnIns;
  FOnUpd := OnUpd;
  ShowModal;
  Result.IErr := FActionResult.IErr;
  Result.ExecMsg := FActionResult.ExecMsg;
end;

end.
