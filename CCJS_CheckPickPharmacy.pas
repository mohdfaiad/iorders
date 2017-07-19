unit CCJS_CheckPickPharmacy;

(****************************************************************************
 * © PgkSoft 24.03.2015
 * Механизм выбора (пожбора) аптеки для курьерской доставки
 * Обработка результатов анализа состояния остатков на аптеке, в
 * том числе срокового товара.
 * Окончательный выбор (подбор аптеки)
 ****************************************************************************)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, ActnList, DB, ADODB,
  StdCtrls;

type
  TfrmCCJS_CheckPickPharmacy = class(TForm)
    statusBar: TStatusBar;
    pnlHeader: TPanel;
    pnlTool: TPanel;
    pnlTool_Show: TPanel;
    pnlTool_Bar: TPanel;
    pnlControl: TPanel;
    pnlControl_Bar: TPanel;
    pnlControl_Show: TPanel;
    pnlGrid: TPanel;
    gMain: TDBGrid;
    aList: TActionList;
    tlbarControl: TToolBar;
    aControl_Close: TAction;
    tlbtnControl_Close: TToolButton;
    dsCheck: TDataSource;
    qrspCheck: TADOStoredProc;
    spAutoNumberReserve: TADOStoredProc;
    pnlHeader_Pharmacy: TPanel;
    aControl_Select: TAction;
    tlbtnControl_Select: TToolButton;
    tlbarTool: TToolBar;
    aTool_SelectItem: TAction;
    tlbtnTool_SelectItemReserve: TToolButton;
    spSetNumberToReserve: TADOStoredProc;
    pnlTool_Fields: TPanel;
    aTool_ClearSelectItem: TAction;
    spSetPharmacy: TADOStoredProc;
    aControl_AddPharmacy: TAction;
    pnlTool_Fields_01: TPanel;
    pnlTool_Fields_02: TPanel;
    lblNumberToReserve: TLabel;
    cmbxNumberToReserve: TComboBox;
    tlbarTool_Fields: TToolBar;
    aTool_Fileds_OK: TAction;
    tlbtnTool_Fields_OK: TToolButton;
    spCountOtherDistrib: TADOStoredProc;
    spAddPharmacy: TADOStoredProc;
    spGetPickItemDistributePosCount: TADOStoredProc;
    spSumReserve: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aControl_CloseExecute(Sender: TObject);
    procedure gMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dsCheckDataChange(Sender: TObject; Field: TField);
    procedure aControl_SelectExecute(Sender: TObject);
    procedure aTool_SelectItemExecute(Sender: TObject);
    procedure aTool_ClearSelectItemExecute(Sender: TObject);
    procedure aControl_AddPharmacyExecute(Sender: TObject);
    procedure aTool_Fileds_OKExecute(Sender: TObject);
  private
    { Private declarations }
    ISign_Activate     : integer;
    Mode               : integer;  { Режим работы }
    PRN                : integer;
    BigIdAction        : int64;    { Уникальный идентификатор процесса }
    IDUSER             : integer;
    ItemCode           : integer;
    Pharmacy           : integer;
    NamePharmacy       : string;
    SIDENT             : string;
    Order              : integer;
    ModeReserve        : smallint;
    procedure ShowGets;
    procedure CreateCondition;
    procedure ExecCondition;
    procedure GridRefresh;
    procedure InitStatusBar;
  public
    { Public declarations }
    procedure SetMode(cFMode : integer);
    procedure SetPRN(Param : integer);
    procedure SetBigIdAction(IdAction : int64);
    procedure SetUSER(Param : integer);
    procedure SetItemCode(Param : integer);
    procedure SetPharmacy(Param : integer);
    procedure SetNamePharmacy(Param : string);
    procedure SetOrder(Param : integer);
    procedure SetSIDENT(Param : string);
    procedure SetModeReserve(Param : smallint);
    function  GetCountOtherDistrib: integer;
    function  GetPickItemDistributePosCount(ArtCodeTerm : integer): integer;
    function  GetSumReserve: integer;
  end;

const
  { Режимы работы }
  cFCCJS_CheckPP_ArtCode_Distribute = 0; { Для выбранной (текущей) товарной позиции при ее распределении по аптекам }
  cFCCJS_CheckPP_ArtCode_Pharmacy   = 1; { Для выбранной (текущей) товарной позиции }
  cFCCJS_CheckPP_Order_Pharmacy     = 2; { Для всех позиций заказа }

var
  frmCCJS_CheckPickPharmacy: TfrmCCJS_CheckPickPharmacy;

implementation

uses UTIL, Umain, ExDBGRID, UCCenterJournalNetZkz, CCJS_PickPharmacy;

{$R *.dfm}

procedure TfrmCCJS_CheckPickPharmacy.FormCreate(Sender: TObject);
begin
  ISign_Activate := 0;
  ModeReserve    := 0;
  PRN            := 0;
  Pharmacy       := 0;
  Order          := 0;
  IDUSER         := 0;
  Mode           := -1;
end;

procedure TfrmCCJS_CheckPickPharmacy.FormActivate(Sender: TObject);
var
  IErr     : integer;
  SErr     : string;
  SCaption : string;
begin
  if ISign_Activate = 0 then begin
    cmbxNumberToReserve.Clear;
    { Заголовок}
    SCaption := 'Аптека  ' + NamePharmacy;
    pnlHeader_Pharmacy.Caption := SCaption;
    { pnlHeader_Pharmacy.Width := TextPixWidth(SCaption, pnlHeader_Pharmacy.Font) + 20; }
    { Иконка формы }
    if Mode = cFCCJS_CheckPP_ArtCode_Distribute then begin
      pnlTool_Bar.Visible := false;
      pnlTool_Fields_01.Visible := true;
      pnlTool_Fields_02.Visible := true;
      FCCenterJournalNetZkz.imgMain.GetIcon(101,self.Icon);
      self.Caption := 'Добавить аптеку';
      tlbtnControl_Select.Action := aControl_AddPharmacy;
    end
    else if Mode = cFCCJS_CheckPP_ArtCode_Pharmacy then begin
      pnlTool_Bar.Visible := true;
      pnlTool_Fields_01.Visible := false;
      pnlTool_Fields_02.Visible := false;
      FCCenterJournalNetZkz.imgMain.GetIcon(102,self.Icon);
      self.Caption := 'Выбрать аптеку';
      tlbtnControl_Select.Action := aControl_Select;
    end
    else if Mode = cFCCJS_CheckPP_Order_Pharmacy then begin
      pnlTool_Bar.Visible := true;
      pnlTool_Fields_01.Visible := false;
      pnlTool_Fields_02.Visible := false;
      FCCenterJournalNetZkz.imgMain.GetIcon(102,self.Icon);
      self.Caption := 'Выбрать аптеку для всех позиций заказа';
      tlbtnControl_Select.Action := aControl_Select;
    end
    else begin
      pnlTool_Bar.Visible := false;
      pnlTool_Fields_01.Visible := false;
      pnlTool_Fields_02.Visible := false;
      FCCenterJournalNetZkz.imgMain.GetIcon(108,self.Icon);
      self.Caption := 'Добавить аптеку';
      aControl_Select.Enabled := false;
      aControl_AddPharmacy.Enabled := false;
    end;

    if (Mode = cFCCJS_CheckPP_ArtCode_Pharmacy) or (Mode = cFCCJS_CheckPP_Order_Pharmacy) then begin
      statusBar.SimpleText := 'Определяем количество для резервирования...';
      { Автоматическое проставление количества }
      IErr := 0;
      SErr := '';
      try
        spAutoNumberReserve.Parameters.ParamValues['@NIdentPharmacy'] := BigIdAction;
        spAutoNumberReserve.Parameters.ParamValues['@SIDENT'] := SIDENT;
        spAutoNumberReserve.Parameters.ParamValues['@Order'] := Order;
        spAutoNumberReserve.Parameters.ParamValues['@IDUser'] := IDUSER;
        spAutoNumberReserve.ExecProc;
        IErr := spAutoNumberReserve.Parameters.ParamValues['@RETURN_VALUE'];
        if IErr <> 0 then begin
          SErr := spAutoNumberReserve.Parameters.ParamValues['@SErr'];
          ShowMessage('Сбой при определении количества для резервирования.' + chr(10) + SErr);
        end;
      except
        on e:Exception do begin
          ShowMessage('Сбой при определении количества для резервирования.' + chr(10) + e.Message);
        end;
      end;
    end
    else if (Mode = cFCCJS_CheckPP_ArtCode_Distribute) then begin
    end;
    ExecCondition;
    ISign_Activate := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJS_CheckPickPharmacy.InitStatusBar;
var
  MsgInit : string;
begin
  MsgInit := 'АртКод ' + gMain.DataSource.DataSet.FieldByName('NArtCode').AsString;
  if gMain.DataSource.DataSet.FieldByName('ISignTerm').AsInteger = 1 then begin
    MsgInit := MsgInit + ', ' + 'сроковый АртКод ' + gMain.DataSource.DataSet.FieldByName('NArtCodeTerm').AsString;
  end;
  statusBar.SimpleText := MsgInit;
end;

procedure TfrmCCJS_CheckPickPharmacy.ShowGets;
var
  SCaption : string;
begin
  if ISign_Activate = 1 then begin
    InitStatusBar;
    { Количество строк }
    SCaption := VarToStr(qrspCheck.RecordCount);
    pnlTool_Show.Caption := SCaption;
    pnlTool_Show.Width := TextPixWidth(SCaption, pnlTool_Show.Font) + 40;
    { Доступ к действиям }
    if GetSumReserve = 0 then begin
      aControl_Select.Enabled := false;
      aControl_AddPharmacy.Enabled := false;
    end else begin
      aControl_Select.Enabled := true;
      aControl_AddPharmacy.Enabled := true;
    end;
  end;
end;

procedure TfrmCCJS_CheckPickPharmacy.SetMode(cFMode : integer); begin Mode := cFMode; end;
procedure TfrmCCJS_CheckPickPharmacy.SetPRN(Param : integer); begin PRN := Param; end;
procedure TfrmCCJS_CheckPickPharmacy.SetBigIdAction(IdAction : int64); begin BigIdAction := IdAction; end;
procedure TfrmCCJS_CheckPickPharmacy.SetUSER(Param : integer); begin IDUSER := Param; end;
procedure TfrmCCJS_CheckPickPharmacy.SetItemCode(Param : integer); begin ItemCode := Param; end;
procedure TfrmCCJS_CheckPickPharmacy.SetPharmacy(Param : integer); begin Pharmacy := Param; end;
procedure TfrmCCJS_CheckPickPharmacy.SetOrder(Param : integer); begin Order := Param; end;
procedure TfrmCCJS_CheckPickPharmacy.SetSIDENT(Param : string); begin SIDENT := Param; end;
procedure TfrmCCJS_CheckPickPharmacy.SetNamePharmacy(Param : string); begin NamePharmacy := Param; end;
procedure TfrmCCJS_CheckPickPharmacy.SetModeReserve(Param : smallint); begin ModeReserve := Param; end;

function TfrmCCJS_CheckPickPharmacy.GetCountOtherDistrib: integer;
var
  CountOtherDistrib : integer;
begin
  CountOtherDistrib := 0;
  try
    spCountOtherDistrib.Parameters.ParamValues['@NIdentPharmacy'] := BigIdAction;
    spCountOtherDistrib.Parameters.ParamValues['@NRN'] := gMain.DataSource.DataSet.FieldByName('NRN').AsInteger;
    spCountOtherDistrib.ExecProc;
    CountOtherDistrib := spCountOtherDistrib.Parameters.ParamValues['@CountOtherDistrib'];
  except
    on e:Exception do
      begin
        CountOtherDistrib := 987654321;
        ShowMessage('Сбой при расчета количества для резервирования в других позициях'+chr(10)+e.Message);
      end;
  end;
  result := CountOtherDistrib;
end;

function TfrmCCJS_CheckPickPharmacy.GetPickItemDistributePosCount(ArtCodeTerm : integer): integer;
var
  PosCount : integer;
begin
  PosCount := 0;
  try
    spGetPickItemDistributePosCount.Parameters.ParamValues['@RN']          := PRN;
    spGetPickItemDistributePosCount.Parameters.ParamValues['@IDENT']       := SIDENT;
    spGetPickItemDistributePosCount.Parameters.ParamValues['@Pharmacy']    := Pharmacy;
    spGetPickItemDistributePosCount.Parameters.ParamValues['@TermArtCode'] := ArtCodeTerm;
    spGetPickItemDistributePosCount.ExecProc;
    PosCount := spGetPickItemDistributePosCount.Parameters.ParamValues['@Count'];
  except
    on e:Exception do
      begin
        ShowMessage('Сбой при определении количества товара, распределенного по аптекам'+chr(10)+e.Message);
      end;
  end;
  result := PosCount;
end;

function TfrmCCJS_CheckPickPharmacy.GetSumReserve: integer;
Var
  SumReserve : integer;
begin
  SumReserve := 0;
  try
    spSumReserve.Parameters.ParamValues['@NIdentPharmacy'] := BigIdAction;
    spSumReserve.ExecProc;
    SumReserve := spSumReserve.Parameters.ParamValues['@SumReserve'];
  except
    on e:Exception do
      begin
        ShowMessage('Сбой при расчете суммы количества для резервирования'+chr(10)+e.Message);
      end;
  end;
  result := SumReserve;
end;

procedure TfrmCCJS_CheckPickPharmacy.ExecCondition;
var
  RNOrderID: Integer;
begin
  if not qrspCheck.IsEmpty then RNOrderID := qrspCheck.FieldByName('NArtCodeTerm').AsInteger else RNOrderID := -1;
  if qrspCheck.Active then qrspCheck.Active := false;
  CreateCondition;
  qrspCheck.Active := true;
  qrspCheck.Locate('NArtCodeTerm', RNOrderID, []);
  ShowGets;
end;

procedure TfrmCCJS_CheckPickPharmacy.CreateCondition;
begin
  qrspCheck.Parameters.ParamValues['@NIdentPharmacy'] := BigIdAction;
  qrspCheck.Parameters.ParamValues['@SIDENT']         := SIDENT;
  qrspCheck.Parameters.ParamValues['@Order']          := Order;
end;

procedure TfrmCCJS_CheckPickPharmacy.GridRefresh;
var
  RN: Integer;
begin
  if not qrspCheck.IsEmpty then RN := qrspCheck.FieldByName('NRN').AsInteger else RN := -1;
  qrspCheck.Requery;
  qrspCheck.Locate('NRN', RN, []);
end;

procedure TfrmCCJS_CheckPickPharmacy.aControl_CloseExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJS_CheckPickPharmacy.gMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db              : TDBGrid;
  NRemn           : integer;
  NArmour         : integer;
  NCountItemOrder : integer;
  NumberToReserve : integer;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  NRemn           := db.DataSource.DataSet.FieldByName('NRemn').AsInteger;
  NArmour         := db.DataSource.DataSet.FieldByName('NArmour').AsInteger;
  NCountItemOrder := db.DataSource.DataSet.FieldByName('NCountItemOrder').AsInteger;
  NumberToReserve := db.DataSource.DataSet.FieldByName('NumberToReserve').AsInteger;
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  if not (gdSelected in State) then begin
    { Сроковый товар }
    if db.DataSource.DataSet.FieldByName('ISignTerm').AsInteger = 1 then begin
      db.Canvas.Brush.Color := TColor($D3EFFE); { светло-коричневый }
    end;
    { Выделение поля для редактирования }
    if Column.FieldName = 'NumberToReserve' then begin
      { Подкрашиваются только строки, в которых нужно определить значение }
      if (Mode = cFCCJS_CheckPP_ArtCode_Pharmacy) or (Mode = cFCCJS_CheckPP_Order_Pharmacy) then begin
        if (
                (gMain.DataSource.DataSet.FieldByName('NCountArtCode').AsInteger = 1)
            and (gMain.DataSource.DataSet.FieldByName('NEnoughArtCode').AsInteger = 1)
           )
           or
           (
                (gMain.DataSource.DataSet.FieldByName('NCountArtCode').AsInteger > 1)
            and (gMain.DataSource.DataSet.FieldByName('NEnoughArtCode').AsInteger = 1)
           )
           or
           (gMain.DataSource.DataSet.FieldByName('NEnoughArtCode').AsInteger = 0)
        then begin
          {}
        end else begin
          { Доступны товарные позиции с возможностью выбора по несколькими арткодами и достаточным количеством }
          if gMain.DataSource.DataSet.FieldByName('NCountDefinedArtCode').AsInteger = 0
            then db.Canvas.Brush.Color := TColor($80FFFF); { светло-желтый };
        end;
      end
      else if (Mode = cFCCJS_CheckPP_ArtCode_Distribute) then begin
        db.Canvas.Brush.Color := TColor($80FFFF); { светло-желтый }
      end;
    end;
    if (NRemn - NArmour) < NCountItemOrder then begin
      { не хватает остатков для резервирования }
      db.Canvas.Font.Color := TColor(clRed);
    end else begin
      { Хватает остатков для резервирования }
      if NumberToReserve = 0 then begin
        db.Canvas.Font.Color := TColor(clGreen);
      end
      else if NumberToReserve < NCountItemOrder then begin
        db.Canvas.Font.Color := TColor(clBlue);
      end;
    end;
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCCJS_CheckPickPharmacy.dsCheckDataChange(Sender: TObject; Field: TField);
var
  iCkl                    : integer;
  PickItemDistributeCount : integer;
  CountOtherDistrib       : integer;
  NumberToReserve         : integer;
  NRemn                   : integer;
  NArmour                 : integer;
  NCountItemOrder         : integer;
  DistribPosCount         : integer;
  ArtCodeTerm             : integer;
  ArtCode                 : integer;
begin
  tlbtnTool_SelectItemReserve.Action := aTool_SelectItem;
  pnlTool_Bar.Width := tlbtnTool_SelectItemReserve.Width + 10;
  if (not qrspCheck.IsEmpty) then begin
    { Для каждой товарной позиции управление доступом к определению значения NumberToReserve}
    if (Mode = cFCCJS_CheckPP_ArtCode_Pharmacy) or (Mode = cFCCJS_CheckPP_Order_Pharmacy) then begin
      if (
              (gMain.DataSource.DataSet.FieldByName('NCountArtCode').AsInteger = 1)
          and (gMain.DataSource.DataSet.FieldByName('NEnoughArtCode').AsInteger = 1)
         )
         or
         (
              (gMain.DataSource.DataSet.FieldByName('NCountArtCode').AsInteger > 1)
          and (gMain.DataSource.DataSet.FieldByName('NEnoughArtCode').AsInteger = 1)
         )
         or
         (gMain.DataSource.DataSet.FieldByName('NEnoughArtCode').AsInteger = 0)
      then begin
        aTool_SelectItem.Enabled := false;
        aTool_ClearSelectItem.Enabled := false;
      end else begin
        { Доступны товарные позиции с возможностью выбора по несколькими арткодами и достаточным количеством }
        if gMain.DataSource.DataSet.FieldByName('NCountDefinedArtCode').AsInteger = 0 then begin
          aTool_SelectItem.Enabled := true;
          aTool_ClearSelectItem.Enabled := false;
        end else begin
          if gMain.DataSource.DataSet.FieldByName('NumberToReserve').AsInteger = gMain.DataSource.DataSet.FieldByName('NCountItemOrder').AsInteger then begin
            tlbtnTool_SelectItemReserve.Action := aTool_ClearSelectItem;
            pnlTool_Bar.Width := tlbtnTool_SelectItemReserve.Width + 10;
            aTool_SelectItem.Enabled := false;
            aTool_ClearSelectItem.Enabled := true;
          end else begin
            aTool_SelectItem.Enabled := false;
            aTool_ClearSelectItem.Enabled := false;
          end;
        end;
      end;
    end
    else if (Mode = cFCCJS_CheckPP_ArtCode_Distribute) then begin
      ArtCode     := gMain.DataSource.DataSet.FieldByName('NArtCode').AsInteger;
      ArtCodeTerm := gMain.DataSource.DataSet.FieldByName('NArtCodeTerm').AsInteger;
      if ArtCode = ArtCodeTerm then ArtCodeTerm := 0;
      PickItemDistributeCount := TfrmCCJS_PickPharmacy(Owner).GetPickItemDistributeCount;
      CountOtherDistrib       := GetCountOtherDistrib;
      DistribPosCount         := GetPickItemDistributePosCount(ArtCodeTerm);
      NRemn                   := gMain.DataSource.DataSet.FieldByName('NRemn').AsInteger;
      NArmour                 := gMain.DataSource.DataSet.FieldByName('NArmour').AsInteger;
      NCountItemOrder         := gMain.DataSource.DataSet.FieldByName('NCountItemOrder').AsInteger;
      if (NRemn-NArmour-DistribPosCount) > ((NCountItemOrder-PickItemDistributeCount) - CountOtherDistrib)
        then NumberToReserve := (NCountItemOrder-PickItemDistributeCount) - CountOtherDistrib
        else NumberToReserve := (NRemn-NArmour-DistribPosCount);
      if NumberToReserve <= 0 then begin
        tlbtnTool_Fields_OK.Enabled := false;
        NumberToReserve := 0;
      end else tlbtnTool_Fields_OK.Enabled := true;
      { Расчет (автозаполнение) доступного количества для текущей позиции }
      cmbxNumberToReserve.Clear;
      for iCkl := 0  to NumberToReserve do begin
        cmbxNumberToReserve.Items.Add(IntToStr(iCkl));
      end;
      cmbxNumberToReserve.ItemIndex := cmbxNumberToReserve.Items.Count-1;
    end;
  end else begin
    aTool_SelectItem.Enabled := false;
  end;
  ShowGets;
end;

procedure TfrmCCJS_CheckPickPharmacy.aControl_SelectExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if (MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo) then exit;
  try
    spSetPharmacy.Parameters.ParamValues['@NIdentPharmacy'] := BigIdAction;
    spSetPharmacy.Parameters.ParamValues['@IDUser'] := IDUSER;
    spSetPharmacy.Parameters.ParamValues['@Pharmacy'] := Pharmacy;
    spSetPharmacy.Parameters.ParamValues['@SIDENT'] := SIDENT;
    spSetPharmacy.Parameters.ParamValues['@Order'] := Order;
    spSetPharmacy.ExecProc;
    IErr := spSetPharmacy.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      SErr := spSetPharmacy.Parameters.ParamValues['@SErr'];
      ShowMessage('Сбой при сохранении результатов выбора аптеки.' + chr(10) + SErr);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при сохранении результатов выбора аптеки.' + chr(10) + e.Message);
    end;
  end;
  self.Close;
end;

procedure TfrmCCJS_CheckPickPharmacy.aTool_SelectItemExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if (MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo) then exit;
  if (Mode = cFCCJS_CheckPP_ArtCode_Pharmacy) or (Mode = cFCCJS_CheckPP_Order_Pharmacy) then begin
    try
      spSetNumberToReserve.Parameters.ParamValues['@RN'] := gMain.DataSource.DataSet.FieldByName('NRN').AsInteger;
      spSetNumberToReserve.Parameters.ParamValues['@NumberToReserve'] := gMain.DataSource.DataSet.FieldByName('NCountItemOrder').AsInteger;
      spSetNumberToReserve.Parameters.ParamValues['@IDUser'] := IDUSER;
      spSetNumberToReserve.ExecProc;
      IErr := spSetNumberToReserve.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr <> 0 then begin
        SErr := spSetNumberToReserve.Parameters.ParamValues['@SErr'];
        ShowMessage('Сбой при определении количества для резервирования.' + chr(10) + SErr);
      end;
    except
      on e:Exception do begin
        ShowMessage('Сбой при определении количества для резервирования.' + chr(10) + e.Message);
      end;
    end;
  end;
  GridRefresh;
end;

procedure TfrmCCJS_CheckPickPharmacy.aTool_ClearSelectItemExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if (MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo) then exit;
  if (Mode = cFCCJS_CheckPP_ArtCode_Pharmacy) or (Mode = cFCCJS_CheckPP_Order_Pharmacy) then begin
    try
      spSetNumberToReserve.Parameters.ParamValues['@RN'] := gMain.DataSource.DataSet.FieldByName('NRN').AsInteger;
      spSetNumberToReserve.Parameters.ParamValues['@NumberToReserve'] := 0;
      spSetNumberToReserve.Parameters.ParamValues['@IDUser'] := IDUSER;
      spSetNumberToReserve.ExecProc;
      IErr := spSetNumberToReserve.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr <> 0 then begin
        SErr := spSetNumberToReserve.Parameters.ParamValues['@SErr'];
        ShowMessage('Сбой при определении количества для резервирования.' + chr(10) + SErr);
      end;
    except
      on e:Exception do begin
        ShowMessage('Сбой при определении количества для резервирования.' + chr(10) + e.Message);
      end;
    end;
  end;
  GridRefresh;
end;

procedure TfrmCCJS_CheckPickPharmacy.aControl_AddPharmacyExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if (MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo) then exit;
  try
    spAddPharmacy.Parameters.ParamValues['@NIdentPharmacy'] := BigIdAction;
    spAddPharmacy.Parameters.ParamValues['@PRN'] := PRN;
    spAddPharmacy.Parameters.ParamValues['@ISignModeReserve'] := ModeReserve;
    spAddPharmacy.Parameters.ParamValues['@IDUser'] := IDUSER;
    spAddPharmacy.Parameters.ParamValues['@Pharmacy'] := Pharmacy;
    spAddPharmacy.Parameters.ParamValues['@SIDENT'] := SIDENT;
    spAddPharmacy.Parameters.ParamValues['@Order'] := Order;
    spAddPharmacy.ExecProc;
    IErr := spAddPharmacy.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      SErr := spAddPharmacy.Parameters.ParamValues['@SErr'];
      ShowMessage('Сбой при сохранении результатов выбора аптеки.' + chr(10) + SErr);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при сохранении результатов выбора аптеки.' + chr(10) + e.Message);
    end;
  end;
  self.Close;
end;

procedure TfrmCCJS_CheckPickPharmacy.aTool_Fileds_OKExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if (MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo) then exit;
  try
    spSetNumberToReserve.Parameters.ParamValues['@RN'] := gMain.DataSource.DataSet.FieldByName('NRN').AsInteger;
    spSetNumberToReserve.Parameters.ParamValues['@NumberToReserve'] := cmbxNumberToReserve.ItemIndex;
    spSetNumberToReserve.Parameters.ParamValues['@IDUser'] := IDUSER;
    spSetNumberToReserve.ExecProc;
    IErr := spSetNumberToReserve.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      SErr := spSetNumberToReserve.Parameters.ParamValues['@SErr'];
      ShowMessage('Сбой при определении количества для резервирования.' + chr(10) + SErr);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при определении количества для резервирования.' + chr(10) + e.Message);
    end;
  end;
  GridRefresh;
  ShowGets;
end;

end.

