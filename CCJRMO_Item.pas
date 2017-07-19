unit CCJRMO_Item;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ExtCtrls, ComCtrls, ToolWin, StdCtrls, DB, ADODB,
  UCCenterJournalNetZkz;

type
  TfrmCCJRMO_Item = class(TForm)
    pnlTool: TPanel;
    pnlTool_Control: TPanel;
    tlbrControl: TToolBar;
    tlbtnControl_OK: TToolButton;
    tlbtnControl_Exit: TToolButton;
    pnlTool_Show: TPanel;
    pnlFields: TPanel;
    lblArtCode: TLabel;
    lblArtName: TLabel;
    lblQuantity: TLabel;
    lblCena: TLabel;
    aMain: TActionList;
    aMain_Add: TAction;
    aMain_Upd: TAction;
    aMain_Exit: TAction;
    edArtCode: TEdit;
    btnSlArtCode: TButton;
    aSLNomenclature: TAction;
    edArtName: TEdit;
    edQuantity: TEdit;
    edCena: TEdit;
    btnSlArtName: TButton;
    spItemInsert: TADOStoredProc;
    spItemUpdate: TADOStoredProc;
    spItemExists: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aMain_AddExecute(Sender: TObject);
    procedure aMain_UpdExecute(Sender: TObject);
    procedure aMain_ExitExecute(Sender: TObject);
    procedure aSLNomenclatureExecute(Sender: TObject);
    procedure edArtCodeChange(Sender: TObject);
    procedure edArtNameChange(Sender: TObject);
    procedure edCenaChange(Sender: TObject);
    procedure edQuantityChange(Sender: TObject);
    procedure edArtCodeDblClick(Sender: TObject);
    procedure edArtNameDblClick(Sender: TObject);
  private
    { Private declarations }
    ISignActive     : integer;
    Mode            : integer;
    CodeAction      : string;
    Order           : integer;
    NUSER           : integer;
    NHistory        : integer;
    RecItem         : TJRMO_Item;
    SignFindItem    : smallint;
    slArtCode       : string;
    slArtName       : string;
    slPrice         : string;
    SignManualPrice : smallint;
    procedure ShowGets;
    procedure SetControlOK(SignEnabled : boolean);
    procedure SetFields(SignEnabled : boolean);
  public
    { Public declarations }
    procedure SetMode(Parm : integer);
    procedure SetAction(Parm : string);
    procedure SetOrder(Parm : integer);
    procedure SetUSER(Parm : integer);
    procedure SetNHistory(Parm : integer);
    procedure SetRecItem(Parm : TJRMO_Item);
  end;

const
  cFJRMOItemModeAdd = 0; { Режим работы: Добавление }
  cFJRMOItemModeUpd = 1; { Режим работы: Исправление }

  var
  frmCCJRMO_Item: TfrmCCJRMO_Item;

implementation

uses
  Util,
  UMAIN, ExDBGRID, DateUtils, UReference, CCJS_Nomenclature;

const
  sMsgSumTypeCurr = 'Цена товарной позиции имеет числовой формат';
  sMsgQuantityTypeInt = 'Количество товарной позиции имеет целочисленный формат';
  sMsgNotFindItem = 'Товарная позиция не найдена';

{$R *.dfm}

procedure TfrmCCJRMO_Item.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
  Mode  := cFJRMOItemModeAdd;
  SignFindItem := -1;
  SignManualPrice := 0;
end;

procedure TfrmCCJRMO_Item.FormActivate(Sender: TObject);
begin
  if ISignActive = 0 then begin
    { Наименование формы и управление}
    if Mode = cFJRMOItemModeAdd then begin
      self.Caption := 'Товарная позиция (добавить)';
      tlbtnControl_OK.Action := aMain_Add;
    end else if Mode = cFJRMOItemModeUpd then begin
      self.Caption := 'Товарная позиция (исправить)';
      tlbtnControl_OK.Action := aMain_Upd;
      { Проверка наличия платежа }
      spItemExists.Parameters.ParamValues['@RN'] := RecItem.RN;
      spItemExists.ExecProc;
      if spItemExists.Parameters.ParamValues['@RETURN_VALUE'] = 0 then begin
        SetFields(false);
        SignFindItem := 0;
        ShowMessage(sMsgNotFindItem);
        pnlTool_Show.Caption := sMsgNotFindItem;
        aMain_Add.Enabled := false;
        aMain_Upd.Enabled := false;
        aSLNomenclature.Enabled := false;
      end else begin
        SignFindItem := 1;
        aSLNomenclature.Enabled := false;
        { Заполняем поля }
        edArtCode.Text  := IntToStr(RecItem.ArtCode);
        edArtName.Text  := RecItem.ArtName;
        edQuantity.Text := IntToStr(RecItem.Quantity);
        edCena.Text     := CurrencyToStr(RecItem.Cena);
      end;
    end;
    { Проверка наличия платежа }
    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJRMO_Item.SetFields(SignEnabled : boolean);
begin
  edArtCode.Enabled  := SignEnabled;
  edArtName.Enabled  := SignEnabled;
  edQuantity.Enabled := SignEnabled;
  edCena.Enabled     := SignEnabled;
end;

procedure TfrmCCJRMO_Item.SetMode(Parm : integer); begin Mode := Parm; end;
procedure TfrmCCJRMO_Item.SetAction(Parm : string); begin CodeAction := Parm; end;
procedure TfrmCCJRMO_Item.SetOrder(Parm : integer); begin Order := Parm; end;
procedure TfrmCCJRMO_Item.SetUSER(Parm : integer); begin NUSER := Parm; end;
procedure TfrmCCJRMO_Item.SetNHistory(Parm : integer); begin NHistory := Parm; end;
procedure TfrmCCJRMO_Item.SetRecItem(Parm : TJRMO_Item); begin RecItem := Parm; end;

procedure TfrmCCJRMO_Item.SetControlOK(SignEnabled : boolean);
begin
  if Mode = cFJRMOItemModeAdd then begin
    aMain_Add.Enabled := SignEnabled;
    aMain_Upd.Enabled := false;
  end else if Mode = cFJRMOItemModeUpd then begin
    aMain_Add.Enabled := false;
    aMain_Upd.Enabled := SignEnabled;
  end;
end;

procedure TfrmCCJRMO_Item.ShowGets;
begin
  if ISignActive = 1 then begin
    { Контроль на пустые строки }
    if length(trim(edArtCode.Text)) = 0 then begin
      edArtCode.Color := TColor(clYellow);
    end else begin
      edArtCode.Color := TColor(clWindow);
    end;
    if length(trim(edArtName.Text)) = 0 then begin
      edArtName.Color := TColor(clYellow);
    end else begin
      edArtName.Color := TColor(clWindow);
    end;
    if length(trim(edQuantity.Text)) = 0 then begin
      edQuantity.Color := TColor(clYellow);
    end else begin
      edQuantity.Color := TColor(clWindow);
    end;
    if length(trim(edCena.Text)) = 0 then begin
      edCena.Color := TColor(clYellow);
    end else begin
      edCena.Color := TColor(clWindow);
    end;
    { Доступ к элементам управления }
    if   (length(trim(edArtCode.Text)) = 0)
      or (length(trim(edArtName.Text)) = 0)
      or (
          (length(trim(edCena.Text)) = 0)
          or
          (
           (length(trim(edCena.Text)) <> 0)
           and
           (not ufoTryStrToCurr(edCena.Text))
          )
         )
      or (
          (length(trim(edQuantity.Text)) = 0)
          or
          (
           (length(trim(edQuantity.Text)) <> 0)
           and
           (
            (not ufoTryStrToInt(edQuantity.Text))
            or
            (StrToInt(edQuantity.Text) < 0)
           )
          )
         )
      or (
          (Mode = cFJRMOItemModeUpd)
          and
          (
           (SignFindItem = 0)
           or
           (
            (edArtCode.Text = IntToStr(RecItem.ArtCode))
            and
            (edArtName.Text = RecItem.ArtName)
            and
            (edQuantity.Text = IntToStr(RecItem.Quantity))
            and
            (edCena.Text = CurrencyToStr(RecItem.Cena))
           )
          )
         )
    then SetControlOK(false)
    else SetControlOK(true);
  end;
end;

procedure TfrmCCJRMO_Item.aMain_AddExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  if Mode = cFJRMOItemModeAdd then begin
    try
      spItemInsert.Parameters.ParamValues['@USER']            := NUSER;
      spItemInsert.Parameters.ParamValues['@NHistory']        := NHistory;
      spItemInsert.Parameters.ParamValues['@PRN']             := Order;
      spItemInsert.Parameters.ParamValues['@ArtCode']         := StrToInt(edArtCode.Text);
      spItemInsert.Parameters.ParamValues['@Cena']            := StrToCurr(edCena.Text);
      spItemInsert.Parameters.ParamValues['@Quantity']        := StrToInt(edQuantity.Text);
      spItemInsert.Parameters.ParamValues['@SignManualPrice'] := SignManualPrice;
      spItemInsert.ExecProc;
      IErr := spItemInsert.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr <> 0 then begin
        SErr := spItemInsert.Parameters.ParamValues['@SErr'];
        ShowMessage(SErr);
      end;
        except
          on e:Exception do begin
            ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
          end;
    end;
    self.Close;
  end;
end;

procedure TfrmCCJRMO_Item.aMain_UpdExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  if Mode = cFJRMOItemModeUpd then begin
    try
      spItemUpdate.Parameters.ParamValues['@USER']            := NUSER;
      spItemUpdate.Parameters.ParamValues['@NHistory']        := NHistory;
      spItemUpdate.Parameters.ParamValues['@NRN']             := RecItem.RN;
      spItemUpdate.Parameters.ParamValues['@Quantity']        := StrToInt(edQuantity.Text);
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
    self.Close;
  end;
end;

procedure TfrmCCJRMO_Item.aMain_ExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJRMO_Item.aSLNomenclatureExecute(Sender: TObject);
begin
  try
    frmCCJS_Nomenclature := TfrmCCJS_Nomenclature.Create(Self);
    try
      frmCCJS_Nomenclature.ShowModal;
      slArtCode := frmCCJS_Nomenclature.GetArtCode;
      slArtName := frmCCJS_Nomenclature.GetArtName;
      slPrice   := frmCCJS_Nomenclature.GetPrice;
      if (length(slArtCode)) <> 0 and (length(slArtName)) then begin
        edArtCode.Text := slArtCode;
        edArtName.Text := slArtName;
        edCena.Text    := slPrice;
        if (length(slPrice)) = 0 then begin
          SignManualPrice := 1;
          edCena.ReadOnly := false;
        end else begin
          SignManualPrice := 0;
          edCena.ReadOnly := true;
        end;
      end;
    finally
      frmCCJS_Nomenclature.Free;
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TfrmCCJRMO_Item.edArtCodeChange(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJRMO_Item.edArtNameChange(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJRMO_Item.edCenaChange(Sender: TObject);
begin
  if not ufoTryStrToCurr(edCena.Text) then ShowMessage(sMsgSumTypeCurr);
  ShowGets;
end;

procedure TfrmCCJRMO_Item.edQuantityChange(Sender: TObject);
begin
  if not ufoTryStrToInt(edQuantity.Text) then ShowMessage(sMsgQuantityTypeInt);
  ShowGets;
end;

procedure TfrmCCJRMO_Item.edArtCodeDblClick(Sender: TObject);
begin
  if Mode = cFJRMOItemModeAdd then aSLNomenclature.Execute;
end;

procedure TfrmCCJRMO_Item.edArtNameDblClick(Sender: TObject);
begin
  if Mode = cFJRMOItemModeAdd then aSLNomenclature.Execute;
end;

end.
