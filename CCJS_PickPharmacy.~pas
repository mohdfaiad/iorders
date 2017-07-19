unit CCJS_PickPharmacy;

{*******************************************************
 * © PgkSoft 22.09.2014
 * Журнал интернет заказов
 * Механизм выбора (подбор аптеки) для заказов без
 * аптеки в заголовке (курьерская доставка и т.п.)
 *******************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DB, ADODB, Grids, DBGrids, ExtCtrls, ToolWin, StdCtrls,
  ActnList, Menus,
  {--}
  UCCenterJournalNetZkz, uSprQuery, uDMJSO, uActionCore;

type
  TfrmCCJS_PickPharmacy = class(TForm)
    pnlTop: TPanel;
    pnlGridMain: TPanel;
    pnlTop_Heading: TPanel;
    pnlTop_Count: TPanel;
    qrspZakaz: TADOStoredProc;
    dsZakaz: TDataSource;
    spDeletePickPharmacy: TADOStoredProc;
    pnlIPA: TPanel;
    pnlIPA_Control: TPanel;
    pnlIPA_Count: TPanel;
    pnlGridIPA: TPanel;
    dsItemIPA: TDataSource;
    pnlStatus: TPanel;
    stbarPickPharmacy: TStatusBar;
    pnlControl: TPanel;
    splitGrid: TSplitter;
    pnlControl_Bar: TPanel;
    pnlControl_Show: TPanel;
    toolbarControl: TToolBar;
    tlbtnControl_SaveExit: TToolButton;
    tlbtnControl_SaveExitAmuont: TToolButton;
    tlbtnControl_Exit: TToolButton;
    toolbarSlave: TToolBar;
    tlbtnSlave_Pick: TToolButton;
    ActionListMain: TActionList;
    aControl_SaveExit: TAction;
    aControl_saveExitAmount: TAction;
    aControl_Exit: TAction;
    aSlave_PickPharmacy: TAction;
    pmSlave: TPopupMenu;
    pmiSlave_PickPharmacy: TMenuItem;
    pnlHeading: TPanel;
    pnlHZakaz: TPanel;
    pnlHZSum: TPanel;
    pnlHZHShipName: TPanel;
    pnlHZShipStreet: TPanel;
    toolbarMain: TToolBar;
    aMain_DistributeEnabled: TAction;
    tlbtnMain_Distribute: TToolButton;
    pmMain: TPopupMenu;
    pmiMain_Distribute: TMenuItem;
    qrspItemIPA: TADOStoredProc;
    spPickPharmacyUpdate: TADOStoredProc;
    aMain_ClearPick: TAction;
    spSavePickPharmacy: TADOStoredProc;
    spClearPickPharmacy: TADOStoredProc;
    spPickSetDistribute: TADOStoredProc;
    pnlGridMain_Order: TPanel;
    DBGridZakaz: TDBGrid;
    splitPickOrderDistribute: TSplitter;
    pnlGridMain_Distribute: TPanel;
    pnlGridMain_Distribute_Header: TPanel;
    DBGridDistribPharm: TDBGrid;
    spCreatePickPharmacy: TADOStoredProc;
    qrspPickPositionDistribute: TADOStoredProc;
    dsPickPositionDistribute: TDataSource;
    spGetPickItemDistributeCount: TADOStoredProc;
    pnlGridMain_Distribute_HeaderKoef: TPanel;
    pnlGridMain_Distribute_HeaderPrice: TPanel;
    pnlGridMain_Distribute_HeaderCount: TPanel;
    aSlave_CheckPharmacy: TAction;
    tlbtnSlave_CheckPfarmacy: TToolButton;
    pmiSlave_CheckPharmacy: TMenuItem;
    pgGridSlave: TPageControl;
    tabGridSlave_IPA: TTabSheet;
    tabGridSlave_Sklad: TTabSheet;
    DBGridItemIPA: TDBGrid;
    qrspOstSklad: TADOStoredProc;
    dsOstSklad: TDataSource;
    DBGridOstSklad: TDBGrid;
    pnlLocate: TPanel;
    aMain_DistributeDesabled: TAction;
    tlbtnMain_ClearPick: TToolButton;
    aMain_SetModeArmor: TAction;
    aMain_SetModeComeBack: TAction;
    aMain_ClearMode: TAction;
    pmModeRes: TPopupMenu;
    pmiModeRes_SetModeArmor: TMenuItem;
    pmiModeRes_SetModeComeBack: TMenuItem;
    pmiModeRes_ClearMode: TMenuItem;
    tlbtnMain_SetMode: TToolButton;
    pmiMain_ModeRes: TMenuItem;
    pmiMain_ModeRes_SetModeArmor: TMenuItem;
    pmiMain_ModeRes_SetModeComeBack: TMenuItem;
    pmiMain_ModeRes_ClearMode: TMenuItem;
    pnlIPA_Condition: TPanel;
    aCondition_IPA: TAction;
    aSlave_PickWarehouse: TAction;
    aSlave_AddPharmacy: TAction;
    aSlave_AddWarehouse: TAction;
    pnlGridMain_Distribute_Control: TPanel;
    pnlGridMain_Distribute_Control_Show: TPanel;
    pnlGridMain_Distribute_Control_Bar: TPanel;
    toolbarDistributeFarmacy: TToolBar;
    aDistrib_ClearPick: TAction;
    tlbtnDistrib_ClearPick: TToolButton;
    aDistrib_SetModeArmor: TAction;
    aDistrib_SetModeComeBack: TAction;
    aDistrib_ClearMode: TAction;
    tlbtnDistrib_ModeRes: TToolButton;
    pmDistribModeRes: TPopupMenu;
    pmiDistribModeRes_SetModeArmor: TMenuItem;
    pmiDistribModeRes_SetModeComeBack: TMenuItem;
    pmiDistribModeRes_ClearMode: TMenuItem;
    pmiMain_ClearPick: TMenuItem;
    pmDistrib: TPopupMenu;
    pmiDistrib_ClearPick: TMenuItem;
    pmiDistrib_ModeRes: TMenuItem;
    pmiDistrib_ModeRes_SetModeArmor: TMenuItem;
    pmiDistrib_ModeRes_SetModeComeBack: TMenuItem;
    pmiDistrib_ModeRes_ClearMode: TMenuItem;
    spGenBigIdAction: TADOStoredProc;
    aSlave_OrderPickPharmacy: TAction;
    tlbtnSlave_OrderPickPharmacy: TToolButton;
    spCheckPickPharmacy: TADOStoredProc;
    spClearRunTimeBase: TADOStoredProc;
    tabGridSlave_Term: TTabSheet;
    DBGridTerm: TDBGrid;
    dsItemTerm: TDataSource;
    qrspItemTerm: TADOStoredProc;
    tlbtnMain_AddPos: TToolButton;
    tlbtnMain_UpdPos: TToolButton;
    spDistribSetMode: TADOStoredProc;
    spPickPosDistribClear: TADOStoredProc;
    aMain_Refresh: TAction;
    aDistrib_Refresh: TAction;
    pmiMain_Refresh: TMenuItem;
    pmiDistrib_Refresh: TMenuItem;
    spDistribReservedCount: TADOStoredProc;
    aMain_AddPos: TAction;
    aMain_UpdPos: TAction;
    aMain_DelPos: TAction;
    tlbtnMain_DelPos: TToolButton;
    tlbtnMain_DividerAUD: TToolButton;
    pmiMain_Delemiter01: TMenuItem;
    pmiMain_Delemiter02: TMenuItem;
    pmiMain_AddPos: TMenuItem;
    pmiMain_UpdPos: TMenuItem;
    pmiMain_DelPos: TMenuItem;
    pmiModeRes_Delemiter: TMenuItem;
    aMain_GroupSetModeArmor: TAction;
    aMain_GroupSetModeComeBack: TAction;
    aMain_GroupClearMode: TAction;
    pmiModeRes_GroupSetModeArmor: TMenuItem;
    pmiModeRes_GroupSetModeComeBack: TMenuItem;
    pmiModeRes_GroupClearMode: TMenuItem;
    pmiMain_ModeRes_Delemiter: TMenuItem;
    pmiMain_ModeRes_GroupSetModeArmor: TMenuItem;
    pmiMain_ModeRes_GroupSetModeComeBack: TMenuItem;
    pmiMain_ModeRes_GroupClearMode: TMenuItem;
    aCondition_OnlyCountForAllItem: TAction;
    aCondition_OnlyCountSLItem: TAction;
    aCondition_OnlyItemOnAllPharmacy: TAction;
    pnlIPA_Condition_Tool: TPanel;
    toolbarCondition: TToolBar;
    tlbtnCondition_IPA: TToolButton;
    pmCondListPharm: TPopupMenu;
    pmiCLP_OnlyCountForAllItem: TMenuItem;
    pmiCLP_OnlyCountSLItem: TMenuItem;
    pmiCLP_OnlyItemOnAllPharmacy: TMenuItem;
    aCondition_Sales: TAction;
    tlbtnCondition_Sales: TToolButton;
    pnlIPA_Condition_Tool_Fields: TPanel;
    aCondition_AllPharmacy: TAction;
    pmiCLP_Delemiter: TMenuItem;
    pmiCLP_AllPharmacy: TMenuItem;
    pnlHZHPhone: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dsZakazDataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure aControl_SaveExitExecute(Sender: TObject);
    procedure aControl_saveExitAmountExecute(Sender: TObject);
    procedure aControl_ExitExecute(Sender: TObject);
    procedure aSlave_PickPharmacyExecute(Sender: TObject);
    procedure aMain_DistributeEnabledExecute(Sender: TObject);
    procedure aMain_ClearPickExecute(Sender: TObject);
    procedure aMain_AllClearPickExecute(Sender: TObject);
    procedure DBGridZakazDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridItemIPADrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aSlave_CheckPharmacyExecute(Sender: TObject);
    procedure DBGridDistribPharmDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure pgGridSlaveChange(Sender: TObject);
    procedure DBGridItemIPAKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridItemIPAKeyPress(Sender: TObject; var Key: Char);
    procedure aMain_DistributeDesabledExecute(Sender: TObject);
    procedure aMain_SetModeArmorExecute(Sender: TObject);
    procedure aMain_SetModeComeBackExecute(Sender: TObject);
    procedure aMain_ClearModeExecute(Sender: TObject);
    procedure aCondition_IPAExecute(Sender: TObject);
    procedure aSlave_PickWarehouseExecute(Sender: TObject);
    procedure aSlave_AddPharmacyExecute(Sender: TObject);
    procedure aSlave_AddWarehouseExecute(Sender: TObject);
    procedure aDistrib_ClearPickExecute(Sender: TObject);
    procedure aDistrib_SetModeArmorExecute(Sender: TObject);
    procedure aDistrib_SetModeComeBackExecute(Sender: TObject);
    procedure aDistrib_ClearModeExecute(Sender: TObject);
    procedure dsPickPositionDistributeDataChange(Sender: TObject; Field: TField);
    procedure aSlave_OrderPickPharmacyExecute(Sender: TObject);
    procedure DBGridTermDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aMain_RefreshExecute(Sender: TObject);
    procedure aDistrib_RefreshExecute(Sender: TObject);
    procedure aMain_AddPosExecute(Sender: TObject);
    procedure aMain_UpdPosExecute(Sender: TObject);
    procedure aMain_DelPosExecute(Sender: TObject);
    procedure aMain_GroupSetModeArmorExecute(Sender: TObject);
    procedure aMain_GroupSetModeComeBackExecute(Sender: TObject);
    procedure aMain_GroupClearModeExecute(Sender: TObject);
  private
    { Private declarations }
    ISign_Active       : integer;
    NomerZakaza        : integer;
    SIDENT             : string;
    IDUSER             : integer;
    LocatePharmacy     : string;
    BigIdAction        : int64;
    RecHeaderItem      : TJSO_OrderHeaderItem;
    FOnReserve: TReserveEvent;
    FExecSign: Integer;
    procedure ShowGets;
    procedure InitStatusBar;
    procedure CreateConditionSlave;
    procedure CreateConditionTerm;
    procedure CreateConditionSklad;
    procedure CreateConditionDistribute;
    procedure GridMainRefresh;
    procedure ExecConditionItemIPA;
    procedure ExecConditionTermIPA;
    procedure SetModePosDistribute(Mode : smallint);
    function  GenBigIDAction: integer;
    function  GetDistribCountResSubPos: integer;
  public
    { Public declarations }
    procedure SetRecHeaderItem(Parm : TJSO_OrderHeaderItem);
    function  GetPickItemDistributeCount: integer;
    function ShowDialog(OnReserve: TReserveEvent): TActionResult;
  end;

var
  frmCCJS_PickPharmacy: TfrmCCJS_PickPharmacy;

implementation

uses StrUtils, Util, Umain, ExDBGRID,
  CCJS_CheckPickPharmacy;

{$R *.dfm}

procedure TfrmCCJS_PickPharmacy.SetRecHeaderItem(Parm : TJSO_OrderHeaderItem);
begin
  RecHeaderItem := Parm;
  FExecSign := Parm.ExecSign;
end;

procedure TfrmCCJS_PickPharmacy.GridMainRefresh;
var
  RNOrderID: Integer;
begin
  if not qrspZakaz.IsEmpty then RNOrderID := qrspZakaz.FieldByName('NRN').AsInteger else RNOrderID := -1;
  qrspZakaz.Requery;
  qrspZakaz.Locate('NRN', RNOrderID, []);
end; (* TFCCenterJournalNetZkz.GridMainRefresh *)

procedure TfrmCCJS_PickPharmacy.ExecConditionItemIPA;
var
  RN: Integer;
begin
  if not qrspItemIPA.IsEmpty then RN := qrspItemIPA.FieldByName('NAptekaID').AsInteger else RN := -1;
  qrspItemIPA.Active := false;
  CreateConditionSlave;
  qrspItemIPA.Active := true;
  qrspItemIPA.Locate('NAptekaID', RN, []);
end;

procedure TfrmCCJS_PickPharmacy.ExecConditionTermIPA;
var
  RN: Integer;
begin
  if not qrspItemTerm.IsEmpty then RN := qrspItemTerm.FieldByName('NAptekaID').AsInteger else RN := -1;
  qrspItemTerm.Active := false;
  CreateConditionTerm;
  qrspItemTerm.Active := true;
  qrspItemTerm.Locate('NAptekaID', RN, []);
end;

procedure TfrmCCJS_PickPharmacy.CreateConditionSlave;
var
  ISignMeas : integer;
begin
  ISignMeas := DBGridZakaz.DataSource.DataSet.FieldByName('ISignMeas').AsInteger;
  qrspItemIPA.Parameters.ParamValues['@ItemCode'] := DBGridZakaz.DataSource.DataSet.FieldByName('NArtCode').AsInteger;
  if ISignMeas = 0 then begin
    { Ед.изм. - Упаковка }
    qrspItemIPA.Parameters.ParamValues['@itemQuantity'] := DBGridZakaz.DataSource.DataSet.FieldByName('NArtCount').AsInteger *
                                                           DBGridZakaz.DataSource.DataSet.FieldByName('NKoef_Otp').AsInteger;
  end else if ISignMeas = 1 then begin
    { Ед.изм. - Штука }
    qrspItemIPA.Parameters.ParamValues['@itemQuantity'] := DBGridZakaz.DataSource.DataSet.FieldByName('NArtCount').AsInteger;
  end else begin
    { По умолчанию штуки }
    qrspItemIPA.Parameters.ParamValues['@itemQuantity'] := DBGridZakaz.DataSource.DataSet.FieldByName('NArtCount').AsInteger;
  end;
  if aCondition_OnlyCountSLItem.Checked
    then qrspItemIPA.Parameters.ParamValues['@OnlyCount'] := 1
    else qrspItemIPA.Parameters.ParamValues['@OnlyCount'] := 0;
  if aCondition_OnlyCountForAllItem.Checked
    then qrspItemIPA.Parameters.ParamValues['@OnlyCountForAllItem'] := 1
    else qrspItemIPA.Parameters.ParamValues['@OnlyCountForAllItem'] := 0;
  if aCondition_OnlyItemOnAllPharmacy.Checked
    then qrspItemIPA.Parameters.ParamValues['@OnlyItemOnAllPharmacy'] := 1
    else qrspItemIPA.Parameters.ParamValues['@OnlyItemOnAllPharmacy'] := 0;
  if aCondition_Sales.Checked then begin
    qrspItemIPA.Parameters.ParamValues['@OrderBy']      := 'NSumKol';
    qrspItemIPA.Parameters.ParamValues['@AccountMonth'] := 3;
  end else begin
    qrspItemIPA.Parameters.ParamValues['@OrderBy'] := 'SAptekaName';
    qrspItemIPA.Parameters.ParamValues['@AccountMonth'] := 0;
  end;
  qrspItemIPA.Parameters.ParamValues['@IDENT'] := SIDENT;
  qrspItemIPA.Parameters.ParamValues['@Order'] := DBGridZakaz.DataSource.DataSet.FieldByName('NPRN').AsInteger;
end;

procedure TfrmCCJS_PickPharmacy.CreateConditionSklad;
begin
  qrspOstSklad.Parameters.ParamValues['@ItemCode'] := DBGridZakaz.DataSource.DataSet.FieldByName('NArtCode').AsInteger;
end;

procedure TfrmCCJS_PickPharmacy.CreateConditionTerm;
begin
  qrspItemTerm.Parameters.ParamValues['@ItemCode'] := DBGridZakaz.DataSource.DataSet.FieldByName('NArtCode').AsInteger;
end;

procedure TfrmCCJS_PickPharmacy.CreateConditionDistribute;
begin
  qrspPickPositionDistribute.Parameters.ParamValues['@IDENT']  := SIDENT;
  qrspPickPositionDistribute.Parameters.ParamValues['@itemID'] := DBGridZakaz.DataSource.DataSet.FieldByName('NRN').AsInteger;
end;

procedure TfrmCCJS_PickPharmacy.InitStatusBar;
begin
  stbarPickPharmacy.SimpleText := 'АртКод = ' + VarToStr(DBGridZakaz.DataSource.DataSet.FieldByName('NArtCode').AsInteger) + ', ' +
                                  DBGridZakaz.DataSource.DataSet.FieldByName('SArtName').AsString + ', ' +
                                  'Цена = ' + VarToStr(DBGridZakaz.DataSource.DataSet.FieldByName('NArtPrice').Asfloat);
end;

function TfrmCCJS_PickPharmacy.GetPickItemDistributeCount: integer;
var
  ItemDistribCount : integer;
begin
  ItemDistribCount := 0;
  try
    spGetPickItemDistributeCount.Parameters.ParamValues['@IDENT'] := SIDENT;
    spGetPickItemDistributeCount.Parameters.ParamValues['@RN']    := DBGridZakaz.DataSource.DataSet.FieldByName('NRN').AsInteger;
    spGetPickItemDistributeCount.ExecProc;
    ItemDistribCount := spGetPickItemDistributeCount.Parameters.ParamValues['@Count'];
  except
    on e:Exception do
      begin
        ShowMessage('Сбой при определении количества товара, распределенного по аптекам'+chr(10)+e.Message);
      end;
  end;
  result := ItemDistribCount;
end;

function TfrmCCJS_PickPharmacy.GenBigIDAction: integer;
var
  IErr : integer;
  SErr : string;
begin
  IErr := 0;
  SErr := '';
  BigIDAction := 0;
  try
    spGenBigIdAction.Parameters.ParamValues['@USER'] := IDUSER;
    spGenBigIdAction.ExecProc;
    IErr := spGenBigIdAction.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      BigIDAction := spGenBigIdAction.Parameters.ParamValues['@NRN'];
    end else begin
      SErr := spGenBigIdAction.Parameters.ParamValues['@SErr'];
      ShowMessage('Сбой при определении уникального номера процесса.'+chr(10)+SErr);
    end;
  except
    on e:Exception do
      begin
        ShowMessage('Сбой при определении уникального номера процесса.'+chr(10)+e.Message);
      end;
  end;
  result := IErr;
end;

function TfrmCCJS_PickPharmacy.GetDistribCountResSubPos: integer;
var
  CountResSubPos : integer;
begin
  CountResSubPos := 0;
  try
    spDistribReservedCount.Parameters.ParamValues['@NPRN'] := DBGridZakaz.DataSource.DataSet.FieldByName('NRN').AsInteger;
    spDistribReservedCount.Parameters.ParamValues['@SIDENT'] := SIDENT;
    spDistribReservedCount.ExecProc;
    CountResSubPos := spDistribReservedCount.Parameters.ParamValues['@CountResSubPos'];
  except
    on e:Exception do
      begin
        ShowMessage('Сбой при определении количества зарезервированных субпозиций.'+chr(10)+e.Message);
      end;
  end;
  result := CountResSubPos;
end;

procedure TfrmCCJS_PickPharmacy.SetModePosDistribute(Mode : smallint);
const
  HeaderMsg = 'Сбой при установке режима резервирования.';
var
  IErr : integer;
  SErr : string;
begin
  IErr := 0;
  SErr := '';
  try
    spDistribSetMode.Parameters.ParamValues['@SignModeReserve'] := Mode;
    spDistribSetMode.Parameters.ParamValues['@IDUser'] := IDUSER;
    spDistribSetMode.Parameters.ParamValues['@NRN'] := DBGridDistribPharm.DataSource.DataSet.FieldByName('NRN').AsInteger;
    spDistribSetMode.Parameters.ParamValues['@NPRN'] := DBGridDistribPharm.DataSource.DataSet.FieldByName('NPRN').AsInteger;
    spDistribSetMode.Parameters.ParamValues['@SIDENT'] := SIDENT;
    spDistribSetMode.ExecProc;
    IErr := spDistribSetMode.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <>0 then begin
      SErr := spDistribSetMode.Parameters.ParamValues['@SErr'];
      ShowMessage(HeaderMsg+chr(10)+SErr);
    end;
  except
    on e:Exception do
      begin
        ShowMessage(HeaderMsg+chr(10)+e.Message);
      end;
  end;
end;

procedure TfrmCCJS_PickPharmacy.ShowGets;
var
  ISignDistibute : integer;
  SCaption       : string;
  NKoefBox       : integer;
  NArtCount      : integer;
  SignMeas       : integer;
  SPack          : string;
  CountResSubPos : integer;
begin
  if ISign_Active = 1 then begin

    InitStatusBar;

    { Отображаем количество отобранных записей }
    pnlTop_Count.Caption := 'Позиций в заказе: ' + VarToStr(qrspZakaz.RecordCount) + DupeString(' ',3);
    if pgGridSlave.ActivePage.Name = 'tabGridSlave_IPA' then begin
      pnlIPA_Count.Caption := 'Выбрано аптек: ' + VarToStr(qrspItemIPA.RecordCount) + DupeString(' ',3);
      tlbtnCondition_IPA.Visible   := true;
      tlbtnCondition_Sales.Visible := true;
    end
    else if pgGridSlave.ActivePage.Name = 'tabGridSlave_Sklad' then begin
      pnlIPA_Count.Caption := '';
      tlbtnCondition_IPA.Visible   := false;
      tlbtnCondition_Sales.Visible := false;
    end
    else if pgGridSlave.ActivePage.Name = 'tabGridSlave_Term' then begin
      pnlIPA_Count.Caption := 'Выбрано аптек: ' + VarToStr(qrspItemTerm.RecordCount) + DupeString(' ',3);
      tlbtnCondition_IPA.Visible   := false;
      tlbtnCondition_Sales.Visible := false;
    end;

    if (not qrspZakaz.IsEmpty) then begin

      ISignDistibute := DBGridZakaz.DataSource.DataSet.FieldByName('NSignDistribute').AsInteger;

      { Зарезервированная позиция }
      if (Length(DBGridZakaz.DataSource.DataSet.FieldByName('SArmourDate').AsString) <> 0) then begin

        { Доступ к действиям для зарезервированных позиций }
        aMain_DistributeEnabled.Enabled := false;
        aMain_DistributeDesabled.Enabled := false;
        aMain_ClearPick.Enabled := false;
        aMain_SetModeArmor.Enabled := false;
        aMain_SetModeComeBack.Enabled := false;
        aMain_ClearMode.Enabled := false;
        //
        aSlave_PickPharmacy.Enabled := false;
        aSlave_OrderPickPharmacy.Enabled := false;
        aSlave_PickWarehouse.Enabled := false;
        aSlave_CheckPharmacy.Enabled := false;
        aSlave_AddPharmacy.Enabled := false;
        aSlave_AddWarehouse.Enabled := false;

        { Управление отображением подраздела распределения по аптекам }
        Case ISignDistibute of

          0: begin { откл. распределение по аптекам }

               pnlGridMain_Order.Width := pnlGridMain.Width;
               pnlGridMain_Distribute.Visible := false;
               tlbtnMain_Distribute.Action := aMain_DistributeEnabled;
               pmiMain_Distribute.Action   := aMain_DistributeEnabled;
               if pgGridSlave.ActivePage.Name = 'tabGridSlave_IPA'  then begin
                 aSlave_CheckPharmacy.Visible := true;
                 aCondition_IPA.Visible := true;
                 tlbtnSlave_Pick.Action := aSlave_PickPharmacy;
                 pmiSlave_PickPharmacy.Action := aSlave_PickPharmacy;;
                 aSlave_OrderPickPharmacy.Visible := true;
               end
               else if pgGridSlave.ActivePage.Name = 'tabGridSlave_Sklad' then begin
                 aSlave_CheckPharmacy.Visible := false;
                 aCondition_IPA.Visible := false;
                 tlbtnSlave_Pick.Action  := aSlave_PickWarehouse;
                 pmiSlave_PickPharmacy.Action := aSlave_PickWarehouse;
                 aSlave_OrderPickPharmacy.Visible := false;
               end
               else if pgGridSlave.ActivePage.Name = 'tabGridSlave_Term'  then begin
                 aSlave_CheckPharmacy.Visible := true;
                 aCondition_IPA.Visible := false;
                 tlbtnSlave_Pick.Action := aSlave_PickPharmacy;
                 pmiSlave_PickPharmacy.Action := aSlave_PickPharmacy;
                 aSlave_OrderPickPharmacy.Visible := true;
               end;
             end;

          1: begin { вкл. распределение по аптекам }

               NKoefBox  := DBGridZakaz.DataSource.DataSet.FieldByName('NKoef_Otp').AsInteger;
               NArtCount := DBGridZakaz.DataSource.DataSet.FieldByName('NArtCount').AsInteger;
               aSlave_OrderPickPharmacy.Visible := false;
               aMain_ClearPick.Enabled := false;
               pnlGridMain_Order.Width :=   get_column_by_fieldname('NArtCode',DBGridZakaz).Width
                                          + get_column_by_fieldname('ISignModeReserve',DBGridZakaz).Width
                                          + get_column_by_fieldname('NSignDistribute',DBGridZakaz).Width
                                          + get_column_by_fieldname('SArtName',DBGridZakaz).Width + 40;
               pnlGridMain_Distribute.Visible := true;
               tlbtnMain_Distribute.Action := aMain_DistributeDesabled;
               pmiMain_Distribute.Action   := aMain_DistributeDesabled;
               if pgGridSlave.ActivePage.Name = 'tabGridSlave_IPA' then begin
                 aSlave_CheckPharmacy.Visible := true;
                 aCondition_IPA.Visible := true;
                 tlbtnSlave_Pick.Action := aSlave_AddPharmacy;
                 pmiSlave_PickPharmacy.Action := aSlave_AddPharmacy;
               end
               else if pgGridSlave.ActivePage.Name = 'tabGridSlave_Sklad' then begin
                 aSlave_CheckPharmacy.Visible := false;
                 aCondition_IPA.Visible := false;
                 tlbtnSlave_Pick.Action  := aSlave_AddWarehouse;
                 pmiSlave_PickPharmacy.Action := aSlave_AddWarehouse;
               end
               else if pgGridSlave.ActivePage.Name = 'tabGridSlave_Term'  then begin
                 aSlave_CheckPharmacy.Visible := true;
                 aCondition_IPA.Visible := false;
                 tlbtnSlave_Pick.Action := aSlave_AddPharmacy;
                 pmiSlave_PickPharmacy.Action := aSlave_AddPharmacy;
               end;
               { Отображаем всего распределенного по торговым точкам количества из общего количества в позиции заказа }
               NKoefBox  := DBGridZakaz.DataSource.DataSet.FieldByName('NKoef_Otp').AsInteger;
               NArtCount := DBGridZakaz.DataSource.DataSet.FieldByName('NArtCount').AsInteger;
               SignMeas  := DBGridZakaz.DataSource.DataSet.FieldByName('ISignMeas').AsInteger;
               if GetPickItemDistributeCount = (NArtCount * FCCenterJournalNetZkz.GetJSOFactorNumber(NKoefBox,SignMeas))
                 then pnlGridMain_Distribute_HeaderCount.Font.Color := clWindowText
                 else pnlGridMain_Distribute_HeaderCount.Font.Color := clRed;
               { Количество упаковок под заказ }
               SPack := '';
               if SignMeas = 0 then SPack := IntToStr(NArtCount)
               else if SignMeas = 1 then SPack := VarToStr(Round((NArtCount/NKoefBox)*100)/100);
               SCaption := 'Распределено: ' + VarToStr(GetPickItemDistributeCount) + 'шт. из ' +
                                              IntToStr(NArtCount * FCCenterJournalNetZkz.GetJSOFactorNumber(NKoefBox,SignMeas)) + 'шт. ' +
                                              '('+SPack+'упак.)';
               pnlGridMain_Distribute_HeaderCount.Caption := SCaption;  pnlGridMain_Distribute_HeaderCount.Width := TextPixWidth(SCaption, pnlGridMain_Distribute_HeaderCount.Font) + 20;
               { Отображаем цену на сайте в зависимости от признака единицы измерения }
               SCaption := '';
               if SignMeas = 0 then begin
                 SCaption := 'Цена упаковки на сайте: '+DBGridZakaz.DataSource.DataSet.FieldByName('NArtPrice').AsString;
               end else if SignMeas = 1 then begin
                 SCaption := 'Цена штуки на сайте: '+DBGridZakaz.DataSource.DataSet.FieldByName('NArtPrice').AsString;
               end;
               pnlGridMain_Distribute_HeaderPrice.Caption := SCaption;  pnlGridMain_Distribute_HeaderPrice.Width := TextPixWidth(SCaption, pnlGridMain_Distribute_HeaderPrice.Font) + 20;
               SCaption := 'Коэфициент (кол-во шт. в упаковке): '+DBGridZakaz.DataSource.DataSet.FieldByName('NKoef_Otp').AsString;
               pnlGridMain_Distribute_HeaderKoef.Caption := SCaption;  pnlGridMain_Distribute_HeaderKoef.Width := TextPixWidth(SCaption, pnlGridMain_Distribute_HeaderKoef.Font) + 20;
               { Управление доступом к элементам управления в подчиненном разделе - распределение по аптекам }
               aDistrib_ClearPick.Enabled       := false;
               aDistrib_SetModeArmor.Enabled    := false;
               aDistrib_SetModeComeBack.Enabled := false;
               aDistrib_ClearMode.Enabled       := false;
             end;
        end;

      { Не зарезервированная позиция }
      end else begin

        { Позиция заказа не зарезервирована - управление доступом }
        aSlave_PickPharmacy.Enabled := true;
        aSlave_OrderPickPharmacy.Enabled := true;
        aSlave_PickWarehouse.Enabled := true;
        aSlave_CheckPharmacy.Enabled := true;
        aSlave_AddPharmacy.Enabled := true;
        aSlave_AddWarehouse.Enabled := true;

        { Доступ к main-действию <выбрать аптеку> }
        if (Length(DBGridZakaz.DataSource.DataSet.FieldByName('SApteka').AsString) = 0) then begin

          aMain_DistributeEnabled.Enabled := true;
          aMain_DistributeDesabled.Enabled := true;

          { Уточнение доступа к действиям установки режима резервирования }
          case DBGridZakaz.DataSource.DataSet.FieldByName('ISignModeReserve').AsInteger of
            1: begin
                 aMain_SetModeArmor.Enabled := false;
                 aMain_SetModeComeBack.Enabled := true;
                 aMain_ClearMode.Enabled := true;
               end;
            2: begin
                 aMain_SetModeArmor.Enabled := true;
                 aMain_SetModeComeBack.Enabled := false;
                 aMain_ClearMode.Enabled := true;
               end;
            0: begin
                 aMain_SetModeArmor.Enabled := true;
                 aMain_SetModeComeBack.Enabled := true;
                 aMain_ClearMode.Enabled := false;
               end;
          end;

          Case ISignDistibute of

            0: begin { откл. распределение по аптекам }

                 { Прячем подраздел по субпозициям }
                 pnlGridMain_Order.Width := pnlGridMain.Width;
                 pnlGridMain_Distribute.Visible := false;
                 tlbtnMain_Distribute.Action := aMain_DistributeEnabled;
                 pmiMain_Distribute.Action   := aMain_DistributeEnabled;
                 { Настройка элементов управления по выбору аптеки в зависимости от актичной закладки }
                 if pgGridSlave.ActivePage.Name = 'tabGridSlave_IPA'  then begin
                   aSlave_CheckPharmacy.Visible := true;
                   aCondition_IPA.Visible := true;
                   tlbtnSlave_Pick.Action := aSlave_PickPharmacy;
                   pmiSlave_PickPharmacy.Action := aSlave_PickPharmacy;
                   aSlave_OrderPickPharmacy.Visible := true;
                   if qrspItemIPA.IsEmpty then begin
                     aSlave_PickPharmacy.Enabled      := false;
                     aSlave_OrderPickPharmacy.Enabled := false;
                     aSlave_CheckPharmacy.Enabled     := false;
                   end else begin
                     aSlave_PickPharmacy.Enabled      := true;
                     aSlave_OrderPickPharmacy.Enabled := true;
                     aSlave_CheckPharmacy.Enabled     := true;
                   end;
                 end
                 else if pgGridSlave.ActivePage.Name = 'tabGridSlave_Sklad' then begin
                   aSlave_CheckPharmacy.Visible := false;
                   aCondition_IPA.Visible := false;
                   tlbtnSlave_Pick.Action  := aSlave_PickWarehouse;
                   pmiSlave_PickPharmacy.Action := aSlave_PickWarehouse;
                   aSlave_OrderPickPharmacy.Visible := false;
                   if qrspOstSklad.IsEmpty then begin
                     aSlave_PickWarehouse.Enabled      := false;
                   end else begin
                     aSlave_PickWarehouse.Enabled      := true;
                   end;
                 end
                 else if pgGridSlave.ActivePage.Name = 'tabGridSlave_Term'  then begin
                   aSlave_CheckPharmacy.Visible := true;
                   aCondition_IPA.Visible := false;
                   tlbtnSlave_Pick.Action := aSlave_PickPharmacy;
                   pmiSlave_PickPharmacy.Action := aSlave_PickPharmacy;
                   aSlave_OrderPickPharmacy.Visible := true;
                   if qrspItemTerm.IsEmpty then begin
                     aSlave_PickPharmacy.Enabled      := false;
                     aSlave_OrderPickPharmacy.Enabled := false;
                     aSlave_CheckPharmacy.Enabled     := false;
                   end else begin
                     aSlave_PickPharmacy.Enabled      := true;
                     aSlave_OrderPickPharmacy.Enabled := true;
                     aSlave_CheckPharmacy.Enabled     := true;
                   end;
                 end;
                 { Доступ к main-действию <очистить выбор аптеки> }
                 if (Length(DBGridZakaz.DataSource.DataSet.FieldByName('SApteka').AsString) <> 0)
                   then aMain_ClearPick.Enabled := true
                   else aMain_ClearPick.Enabled := false;
               end;

            1: begin { вкл. распределение по аптекам }

                 NKoefBox  := DBGridZakaz.DataSource.DataSet.FieldByName('NKoef_Otp').AsInteger;
                 NArtCount := DBGridZakaz.DataSource.DataSet.FieldByName('NArtCount').AsInteger;
                 SignMeas  := DBGridZakaz.DataSource.DataSet.FieldByName('ISignMeas').AsInteger;
                 aSlave_OrderPickPharmacy.Visible := false;
                 aMain_ClearPick.Enabled := false;
                 pnlGridMain_Order.Width :=   get_column_by_fieldname('NArtCode',DBGridZakaz).Width
                                            + get_column_by_fieldname('ISignModeReserve',DBGridZakaz).Width
                                            + get_column_by_fieldname('NSignDistribute',DBGridZakaz).Width
                                            + get_column_by_fieldname('SArtName',DBGridZakaz).Width + 40;
                 pnlGridMain_Distribute.Visible := true;
                 tlbtnMain_Distribute.Action := aMain_DistributeDesabled;
                 pmiMain_Distribute.Action   := aMain_DistributeDesabled;
                 { Уточнение доступа к действиям в зависимости от наличие зарезервированных субпозиций }
                 CountResSubPos := GetDistribCountResSubPos;
                 if CountResSubPos > 0 then aMain_DistributeDesabled.Enabled := false
                                       else aMain_DistributeDesabled.Enabled := true;
                 if (CountResSubPos = qrspPickPositionDistribute.RecordCount) and (CountResSubPos > 0) then begin
                   aMain_SetModeArmor.Enabled    := false;
                   aMain_SetModeComeBack.Enabled := false;
                   aMain_ClearMode.Enabled       := false;
                 end else begin
                   case DBGridZakaz.DataSource.DataSet.FieldByName('ISignModeReserve').AsInteger of
                     1: begin
                          aMain_SetModeArmor.Enabled := false;
                          aMain_SetModeComeBack.Enabled := true;
                          aMain_ClearMode.Enabled := true;
                        end;
                     2: begin
                          aMain_SetModeArmor.Enabled := true;
                          aMain_SetModeComeBack.Enabled := false;
                          aMain_ClearMode.Enabled := true;
                        end;
                     3: begin
                          aMain_SetModeArmor.Enabled := true;
                          aMain_SetModeComeBack.Enabled := true;
                          aMain_ClearMode.Enabled := true;
                        end;
                     0: begin
                          aMain_SetModeArmor.Enabled := true;
                          aMain_SetModeComeBack.Enabled := true;
                          aMain_ClearMode.Enabled := false;
                        end;
                   end;
                 end;
                 if pgGridSlave.ActivePage.Name = 'tabGridSlave_IPA' then begin
                   aSlave_CheckPharmacy.Visible := true;
                   aCondition_IPA.Visible := true;
                   tlbtnSlave_Pick.Action := aSlave_AddPharmacy;
                   pmiSlave_PickPharmacy.Action := aSlave_AddPharmacy;
                   if qrspItemIPA.IsEmpty then begin
                     aSlave_AddPharmacy.Enabled       := false;
                     aSlave_OrderPickPharmacy.Enabled := false;
                     aSlave_CheckPharmacy.Enabled     := false;
                   end else begin
                     aSlave_AddPharmacy.Enabled       := true;
                     aSlave_OrderPickPharmacy.Enabled := true;
                     aSlave_CheckPharmacy.Enabled     := true;
                     if GetPickItemDistributeCount >= NArtCount * NKoefBox then aSlave_AddPharmacy.Enabled := false;
                   end;
                 end
                 else if pgGridSlave.ActivePage.Name = 'tabGridSlave_Sklad' then begin
                   aSlave_CheckPharmacy.Visible := false;
                   aCondition_IPA.Visible := false;
                   tlbtnSlave_Pick.Action  := aSlave_AddWarehouse;
                   pmiSlave_PickPharmacy.Action := aSlave_AddWarehouse;
                   if qrspOstSklad.IsEmpty then begin
                     aSlave_PickWarehouse.Enabled := false;
                   end else begin
                     aSlave_PickWarehouse.Enabled := true;
                     if GetPickItemDistributeCount >= NArtCount * NKoefBox then aSlave_PickWarehouse.Enabled := false;
                   end;
                 end
                 else if pgGridSlave.ActivePage.Name = 'tabGridSlave_Term'  then begin
                   aSlave_CheckPharmacy.Visible := true;
                   aCondition_IPA.Visible := false;
                   tlbtnSlave_Pick.Action := aSlave_AddPharmacy;
                   pmiSlave_PickPharmacy.Action := aSlave_AddPharmacy;
                   if qrspItemTerm.IsEmpty then begin
                     aSlave_AddPharmacy.Enabled       := false;
                     aSlave_OrderPickPharmacy.Enabled := false;
                     aSlave_CheckPharmacy.Enabled     := false;
                   end else begin
                     aSlave_AddPharmacy.Enabled       := true;
                     aSlave_OrderPickPharmacy.Enabled := true;
                     aSlave_CheckPharmacy.Enabled     := true;
                     if GetPickItemDistributeCount >= NArtCount * NKoefBox then aSlave_AddPharmacy.Enabled := false;
                   end;
                 end;
                 { Отображаем сумму распределенного количества из общего количества препарата (позиции заказа) }
                 if GetPickItemDistributeCount = (NArtCount * FCCenterJournalNetZkz.GetJSOFactorNumber(NKoefBox,SignMeas))
                   then pnlGridMain_Distribute_HeaderCount.Font.Color := clWindowText
                   else pnlGridMain_Distribute_HeaderCount.Font.Color := clRed;
                 { Количество упаковок под заказ }
                 SPack := '';
                 if SignMeas = 0 then SPack := IntToStr(NArtCount)
                 else if SignMeas = 1 then SPack := VarToStr(Round((NArtCount/NKoefBox)*100)/100);
                 SCaption := 'Распределено: ' + VarToStr(GetPickItemDistributeCount) + 'шт. из ' +
                                                IntToStr(NArtCount * FCCenterJournalNetZkz.GetJSOFactorNumber(NKoefBox,SignMeas)) + 'шт. ' +
                                                '('+SPack+'упак.)';
                 pnlGridMain_Distribute_HeaderCount.Caption := SCaption;  pnlGridMain_Distribute_HeaderCount.Width := TextPixWidth(SCaption, pnlGridMain_Distribute_HeaderCount.Font) + 20;
                 { Отображаем цену на сайте в зависимости от признака единицы измерения }
                 SCaption := '';
                 if SignMeas = 0 then begin
                   SCaption := 'Цена упаковки на сайте: '+DBGridZakaz.DataSource.DataSet.FieldByName('NArtPrice').AsString;
                 end else if SignMeas = 1 then begin
                   SCaption := 'Цена штуки на сайте: '+DBGridZakaz.DataSource.DataSet.FieldByName('NArtPrice').AsString;
                 end;
                 pnlGridMain_Distribute_HeaderPrice.Caption := SCaption;  pnlGridMain_Distribute_HeaderPrice.Width := TextPixWidth(SCaption, pnlGridMain_Distribute_HeaderPrice.Font) + 20;
                 SCaption := 'Коэфициент (кол-во шт. в упаковке): '+DBGridZakaz.DataSource.DataSet.FieldByName('NKoef_Otp').AsString;
                 pnlGridMain_Distribute_HeaderKoef.Caption := SCaption;  pnlGridMain_Distribute_HeaderKoef.Width := TextPixWidth(SCaption, pnlGridMain_Distribute_HeaderKoef.Font) + 20;
                 { Отображаем количество записей }
                 SCaption := VarToStr(qrspPickPositionDistribute.RecordCount);
                 pnlGridMain_Distribute_Control_Show.Caption := SCaption;
                 pnlGridMain_Distribute_Control_Show.Width := TextPixWidth(SCaption, pnlGridMain_Distribute_Control_Show.Font) + 20;
                 { Управление доступом к элементам управления в подчиненном разделе - распределение по аптекам }
                 if qrspPickPositionDistribute.Active then begin
                   { Не пустой набор данных }
                   if not qrspPickPositionDistribute.IsEmpty then begin
                     if (Length(DBGridDistribPharm.DataSource.DataSet.FieldByName('SArmourDate').AsString) <> 0) then begin
                       { Субпозиция забронирована }
                       aDistrib_ClearPick.Enabled       := false;
                       aDistrib_SetModeArmor.Enabled    := false;
                       aDistrib_SetModeComeBack.Enabled := false;
                       aDistrib_ClearMode.Enabled       := false;
                     end else begin
                       { Субпозиция не забронирована }
                       aDistrib_ClearPick.Enabled       := true;
                       aDistrib_SetModeArmor.Enabled    := true;
                       aDistrib_SetModeComeBack.Enabled := true;
                       aDistrib_ClearMode.Enabled       := true;
                       { Уточнение доступа к действиям установки режима резервирования }
                       case DBGridDistribPharm.DataSource.DataSet.FieldByName('ISignModeReserve').AsInteger of
                         1: begin
                              aDistrib_SetModeArmor.Enabled := false;
                              aDistrib_SetModeComeBack.Enabled := true;
                              aDistrib_ClearMode.Enabled := true;
                            end;
                         2: begin
                              aDistrib_SetModeArmor.Enabled := true;
                              aDistrib_SetModeComeBack.Enabled := false;
                              aDistrib_ClearMode.Enabled := true;
                            end;
                         0: begin
                              aDistrib_SetModeArmor.Enabled := true;
                              aDistrib_SetModeComeBack.Enabled := true;
                              aDistrib_ClearMode.Enabled := false;
                            end;
                       end;
                     end;
                   end else begin
                     aDistrib_ClearPick.Enabled       := false;
                     aDistrib_SetModeArmor.Enabled    := false;
                     aDistrib_SetModeComeBack.Enabled := false;
                     aDistrib_ClearMode.Enabled       := false;
                   end;
                 end else begin
                   aDistrib_ClearPick.Enabled := false;
                   aDistrib_SetModeArmor.Enabled := false;
                   aDistrib_SetModeComeBack.Enabled := false;
                   aDistrib_ClearMode.Enabled := false;
                 end;
               end;
          end;

        end else begin { Определена аптека для данной товарной позиции }

          { Закрываем доступ к распределению по аптекам }
          aMain_DistributeEnabled.Enabled := false;
          aMain_DistributeDesabled.Enabled := false;
          { Открываем доступ к очистке выбора аптеки }
          aMain_ClearPick.Enabled := true;
          { Прячем подраздел по субпозициям }
          pnlGridMain_Order.Width := pnlGridMain.Width;
          pnlGridMain_Distribute.Visible := false;
          tlbtnMain_Distribute.Action := aMain_DistributeEnabled;
          pmiMain_Distribute.Action   := aMain_DistributeEnabled;
          { Настройка элементов управления по выбору аптеки в зависимости от актичной закладки }
          if pgGridSlave.ActivePage.Name = 'tabGridSlave_IPA'  then begin
            aSlave_CheckPharmacy.Visible := true;
            aCondition_IPA.Visible := true;
            tlbtnSlave_Pick.Action := aSlave_PickPharmacy;
            pmiSlave_PickPharmacy.Action := aSlave_PickPharmacy;
            aSlave_OrderPickPharmacy.Visible := true;
            if qrspItemIPA.IsEmpty then begin
              aSlave_PickPharmacy.Enabled      := false;
              aSlave_OrderPickPharmacy.Enabled := false;
              aSlave_CheckPharmacy.Enabled     := false;
            end else begin
              aSlave_PickPharmacy.Enabled      := true;
              aSlave_OrderPickPharmacy.Enabled := true;
              aSlave_CheckPharmacy.Enabled     := true;
            end;
          end
          else if pgGridSlave.ActivePage.Name = 'tabGridSlave_Sklad' then begin
            aSlave_CheckPharmacy.Visible := false;
            aCondition_IPA.Visible := false;
            tlbtnSlave_Pick.Action  := aSlave_PickWarehouse;
            pmiSlave_PickPharmacy.Action := aSlave_PickWarehouse;
            aSlave_OrderPickPharmacy.Visible := false;
            if qrspOstSklad.IsEmpty then begin
              aSlave_PickWarehouse.Enabled      := false;
            end else begin
              aSlave_PickWarehouse.Enabled      := true;
            end;
          end
          else if pgGridSlave.ActivePage.Name = 'tabGridSlave_Term'  then begin
            aSlave_CheckPharmacy.Visible := true;
            aCondition_IPA.Visible := false;
            tlbtnSlave_Pick.Action := aSlave_PickPharmacy;
            pmiSlave_PickPharmacy.Action := aSlave_PickPharmacy;
            aSlave_OrderPickPharmacy.Visible := true;
            if qrspItemTerm.IsEmpty then begin
              aSlave_PickPharmacy.Enabled      := false;
              aSlave_OrderPickPharmacy.Enabled := false;
              aSlave_CheckPharmacy.Enabled     := false;
            end else begin
              aSlave_PickPharmacy.Enabled      := true;
              aSlave_OrderPickPharmacy.Enabled := true;
              aSlave_CheckPharmacy.Enabled     := true;
            end;
          end;

        end; // if (Length(DBGridZakaz.DataSource.DataSet.FieldByName('SApteka').AsString) = 0) then begin

      end;

    end else begin
      { qrspZakaz.IsEmpty }

      pnlGridMain_Order.Width := pnlGridMain.Width;
      pnlGridMain_Distribute.Visible := false;
      aMain_DistributeEnabled.Enabled := false;
      aMain_DistributeDesabled.Enabled := false;
      aMain_ClearPick.Enabled := false;
      aMain_SetModeArmor.Enabled := false;
      aMain_SetModeComeBack.Enabled := false;
      aMain_ClearMode.Enabled := false;
      //
      aSlave_PickPharmacy.Enabled := false;
      aSlave_OrderPickPharmacy.Enabled := false;
      aSlave_PickWarehouse.Enabled := false;
      aSlave_CheckPharmacy.Enabled := false;
      aSlave_AddPharmacy.Enabled := false;
      aSlave_AddWarehouse.Enabled := false;

    end;
    { Нормировка размера }
    pnlIPA_Control.Width   := toolbarSlave.Width+3;
  end;
end;

procedure TfrmCCJS_PickPharmacy.FormCreate(Sender: TObject);
begin
  ISign_Active := 0;
  SIDENT := FCCenterJournalNetZkz.SIDENT;
  IDUSER := FCCenterJournalNetZkz.RegAction.NUSER;
  aSlave_PickPharmacy.ShortCut := 32;
  LocatePharmacy := '';
  pnlLocate.Visible := false;
  if FCCenterJournalNetZkz.dbGridMain.DataSource.DataSet.IsEmpty then NomerZakaza := 0
  else NomerZakaza := FCCenterJournalNetZkz.DBGridMain.DataSource.DataSet.FieldByName('orderID').AsInteger;
  { Красиво все отображаем при загрзке }
  pnlGridMain_Order.Width := pnlGridMain.Width;
  pnlGridMain_Distribute.Visible := false;
end;

procedure TfrmCCJS_PickPharmacy.FormActivate(Sender: TObject);
const
  HeaderSErr = 'Сбой при создании буферной копии заказа.';
var
  SCaption  : string;
  SErr      : string;
  IErr      : integer;
  SSignMeas : string;
begin
  if ISign_Active = 0 then begin
    { Страницы по умолчанию }
    pgGridSlave.ActivePage := tabGridSlave_IPA;
    { Создание буферной копии заказа }
    SErr := '';
    IErr := 0;
    try
      stbarPickPharmacy.SimpleText := 'Загрузка позиций заказа и определение коэффициентов расчета цены...';
      spCreatePickPharmacy.Parameters.ParamValues['@IDENT']   := SIDENT;
      spCreatePickPharmacy.Parameters.ParamValues['@orderID'] := NomerZakaza;
      spCreatePickPharmacy.Parameters.ParamValues['@NUSER']   := Form1.id_user;
      spCreatePickPharmacy.ExecProc;
      IErr := spCreatePickPharmacy.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr <> 0 then begin
        SErr := spCreatePickPharmacy.Parameters.ParamValues['@SErr'];
        ShowMessage(HeaderSErr+chr(10)+SErr);
        self.Close;
      end;
    except
      on e:Exception do
        begin
          ShowMessage(HeaderSErr+chr(10)+e.Message);
          self.Close;
        end;
    end;
    { Активируем набор данных буферного раздела }
    qrspZakaz.Active := false;
    qrspZakaz.Parameters.ParamValues['@IDENT'] := SIDENT;
    qrspZakaz.Active := true;
    { Управление видимостью атрибута }
    if aCondition_Sales.Checked then begin
      get_column_by_fieldname('NSumKol',DBGridItemIPA).Visible := true;
      aCondition_Sales.ImageIndex := 36;
    end else begin
      get_column_by_fieldname('NSumKol',DBGridItemIPA).Visible := false;
      aCondition_Sales.ImageIndex := 238;
    end;
    { По умолчанию действия по отбору списка аптек отключены }
    aCondition_AllPharmacy.Checked := true;
    { Форма активна }
    ISign_Active := 1;
    { Отображаем реквизиты заказа }
    SCaption := 'Заказ №: ' + VarToStr(NomerZakaza) + ' от ' + AsString(FCCenterJournalNetZkz.DBGridMain.DataSource.DataSet, 'OrderDt');
    pnlHZakaz.Caption := SCaption;  pnlHZakaz.Width := TextPixWidth(SCaption, pnlHZakaz.Font) + 10;
    SCaption := ' Сумма: ' + VarToStr(FCCenterJournalNetZkz.DBGridMain.DataSource.DataSet.FieldByName('orderAmount').AsFloat);
    pnlHZSum.Caption := SCaption;  pnlHZSum.Width := TextPixWidth(SCaption, pnlHZSum.Font) + 10;
    SCaption := ' Клиент: ' + FCCenterJournalNetZkz.DBGridMain.DataSource.DataSet.FieldByName('orderShipName').AsString;
    pnlHZHShipName.Caption := SCaption;  pnlHZHShipName.Width := TextPixWidth(SCaption, pnlHZHShipName.Font) + 10;
    SCaption := RecHeaderItem.orderPhone;
    pnlHZHPhone.Caption := SCaption; pnlHZHPhone.Width := TextPixWidth(SCaption, pnlHZHPhone.Font) + 20;
    SCaption := ' Адрес: ' + FCCenterJournalNetZkz.DBGridMain.DataSource.DataSet.FieldByName('orderShipStreet').AsString;
    pnlHZShipStreet.Caption := SCaption;
    { Уточнение заголовка столбцов по единице измерения }
    SSignMeas := DBGridZakaz.DataSource.DataSet.FieldByName('SSignMeas').AsString;
    get_column_by_fieldname('NArtPrice',DBGridZakaz).Title.Caption := 'Цена ('+SSignMeas+')';
    get_column_by_fieldname('NItemPrice',DBGridDistribPharm).Title.Caption := 'Цена сайта ('+SSignMeas+')';
    { Страницы по умолчанию }
    pgGridSlave.ActivePage := tabGridSlave_IPA;
    ShowGets;
  end;
end;

procedure TfrmCCJS_PickPharmacy.dsZakazDataChange(Sender: TObject; Field: TField);
begin
  if pgGridSlave.ActivePage.Name = 'tabGridSlave_IPA' then begin
    { Получаем список аптек }
    ExecConditionItemIPA;
    { Отработка поиска по аптекек }
    if pnlLocate.Visible then
      DBGridItemIPA.DataSource.DataSet.Locate('SAptekaName',AnsiLowerCase(LocatePharmacy),[loCaseInsensitive,loPartialKey]);
  end
  else if pgGridSlave.ActivePage.Name = 'tabGridSlave_Sklad' then begin
    { Получаем количество на складе }
    qrspOstSklad.Active := false;
    CreateConditionSklad;
    qrspOstSklad.Active := true;
  end
  else if pgGridSlave.ActivePage.Name = 'tabGridSlave_Term' then begin
    { Получаем список аптек по сроковому товару }
    ExecConditionTermIPA;
  end;
  { Получаем список распределения по аптекам }
  if DBGridZakaz.DataSource.DataSet.FieldByName('NSignDistribute').AsInteger = 1 then begin
    qrspPickPositionDistribute.Active := false;
    CreateConditionDistribute;
    qrspPickPositionDistribute.Active := true;
  end;
  ShowGets;
end;

procedure TfrmCCJS_PickPharmacy.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
  spDeletePickPharmacy.Parameters.ParamValues['@IDENT'] := SIDENT;
  spDeletePickPharmacy.ExecProc;
end;

procedure TfrmCCJS_PickPharmacy.FormResize(Sender: TObject);
begin
  ShowGets;
  { Прорисовка дополнительных элементов }
  pnlLocate.Top := DBGridItemIPA.Height - pnlLocate.Height - 3;
end;

{ Сохранить и выйти }
procedure TfrmCCJS_PickPharmacy.aControl_SaveExitExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  IErr := 0;
  SErr := '';
  //if MessageDLG('Подтвердите выполнение операции <' + aControl_SaveExit.Caption + '>.',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
    try
      stbarPickPharmacy.SimpleText := 'Сохранение результатов подбора аптек...';
      spSavePickPharmacy.Parameters.ParamValues['@USERIDENT'] := SIDENT;
      spSavePickPharmacy.Parameters.ParamValues['@USERorderID'] := DBGridZakaz.DataSource.DataSet.FieldByName('NPRN').AsInteger;
      spSavePickPharmacy.ExecProc;
      IErr := spSavePickPharmacy.Parameters.ParamValues['@RETURN_VALUE'];
      SErr := spSavePickPharmacy.Parameters.ParamValues['@SErrMsg'];
      if IErr <> 0 then ShowMessage(SErr);
    except
      on e:Exception do
        begin
          ShowMessage('Сбой при сохранении выбора аптеки. Попробуйте еще раз' + chr(10) + SErr);
        end;
    end;
    self.Close;
  //end;
end;

{ Сохранить, выйти и забронировать }
procedure TfrmCCJS_PickPharmacy.aControl_saveExitAmountExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
  vActionResult: TActionResult;
begin
  IErr := 0;
  SErr := '';
  //if MessageDLG('Подтвердите выполнение операции <' + aControl_saveExitAmount.Caption + '>.',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
    try
      stbarPickPharmacy.SimpleText := 'Сохранение результатов подбора аптек...';
      spSavePickPharmacy.Parameters.ParamValues['@USERIDENT'] := SIDENT;
      spSavePickPharmacy.Parameters.ParamValues['@USERorderID'] := DBGridZakaz.DataSource.DataSet.FieldByName('NPRN').AsInteger;
      spSavePickPharmacy.ExecProc;
      IErr := spSavePickPharmacy.Parameters.ParamValues['@RETURN_VALUE'];
      SErr := spSavePickPharmacy.Parameters.ParamValues['@SErrMsg'];
      if IErr = 0 then begin
        stbarPickPharmacy.SimpleText := 'Бронирование (проверка) заказа по всем позициям...';
        try
          stbarPickPharmacy.SimpleText := 'Бронирование (проверка) заказа по всем позициям...';
          if not Assigned(FOnReserve) then
          begin
            FCCenterJournalNetZkz.spReservingOrderOnPharmacies.Parameters.ParamValues['@OrderID']  := DBGridZakaz.DataSource.DataSet.FieldByName('NPRN').AsInteger;
            FCCenterJournalNetZkz.spReservingOrderOnPharmacies.Parameters.ParamValues['@itemCode'] := 0;
            FCCenterJournalNetZkz.spReservingOrderOnPharmacies.Parameters.ParamValues['@SubItem']  := 0;
            FCCenterJournalNetZkz.spReservingOrderOnPharmacies.Parameters.ParamValues['@IDUser']   := (-1)*Form1.id_user;
            FCCenterJournalNetZkz.spReservingOrderOnPharmacies.ExecProc;
            IErr := FCCenterJournalNetZkz.spReservingOrderOnPharmacies.Parameters.ParamValues['@RETURN_VALUE'];
            SErr := FCCenterJournalNetZkz.spReservingOrderOnPharmacies.Parameters.ParamValues['@SErr'];
            if IErr < 0 then ShowMessage(SErr);
          end
          else
          begin
            FOnReserve(vActionResult, rtAll);
            if vActionResult.IErr <> 0 then
              ShowMessage(vActionResult.ExecMsg)
          end;
        except
        on e:Exception do
          begin
            ShowMessage('Сбой при выполнении операции <Бронирование (проверка) заказа по всем позициям>. Попробуйте еще раз');
          end;
        end;
      end else ShowMessage(SErr);
    except
      on e:Exception do
        begin
          ShowMessage('Сбой при сохранении выбора аптеки. Попробуйте еще раз' + chr(10) + SErr);
        end;
    end;
    self.Close;
  //end;
end;

{ Закрыть }
procedure TfrmCCJS_PickPharmacy.aControl_ExitExecute(Sender: TObject);
begin
  self.Close;
end;

{ Выбор аптеки для основной позиции заказа }
procedure TfrmCCJS_PickPharmacy.aSlave_PickPharmacyExecute(Sender: TObject);
var
  Pharmacy     : integer;
  NamePharmacy : string;
  IErr         : integer;
  SErr         : string;
begin
  IErr := 0;
  SErr := '';
  if pgGridSlave.ActivePage.Name = 'tabGridSlave_IPA' then begin
    Pharmacy := DBGridItemIPA.DataSource.DataSet.FieldByName('NAptekaID').AsInteger;
    NamePharmacy := DBGridItemIPA.DataSource.DataSet.FieldByName('SAptekaName').AsString;
    if    (DBGridItemIPA.DataSource.DataSet.FieldByName('DiffMinute').AsInteger >= 7)
      and (MessageDLG('На аптеке давно не было связи. Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo)
      then exit;
  end
  else if pgGridSlave.ActivePage.Name = 'tabGridSlave_Term' then begin
    Pharmacy := DBGridTerm.DataSource.DataSet.FieldByName('NAptekaID').AsInteger;
    NamePharmacy := DBGridTerm.DataSource.DataSet.FieldByName('SAptekaName').AsString;
    if    (DBGridTerm.DataSource.DataSet.FieldByName('DiffMinute').AsInteger >= 7)
      and (MessageDLG('На аптеке давно не было связи. Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo)
      then exit;
  end;
  { Генерим уникальный номер процесса }
  IErr := GenBigIDAction;
  if IErr = 0 then begin
    try
      stbarPickPharmacy.SimpleText := 'Анализ наличия остатков в аптеке...';
      { Анализ наличия на аптеке }
      spCheckPickPharmacy.Parameters.ParamValues['@NIdentPharmacy'] := BigIdAction;
      spCheckPickPharmacy.Parameters.ParamValues['@IDUser']         := IDUSER;
      spCheckPickPharmacy.Parameters.ParamValues['@ItemCode']       := DBGridZakaz.DataSource.DataSet.FieldByName('NArtCode').AsInteger;
      spCheckPickPharmacy.Parameters.ParamValues['@Pharmacy']       := Pharmacy;
      spCheckPickPharmacy.Parameters.ParamValues['@Order']          := 0;
      spCheckPickPharmacy.ExecProc;
      IErr := spCheckPickPharmacy.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr = 0 then begin
        ShowGets;
        { Определение количества для резервирования }
        try
          frmCCJS_CheckPickPharmacy := TfrmCCJS_CheckPickPharmacy.Create(Self);
          frmCCJS_CheckPickPharmacy.SetMode(cFCCJS_CheckPP_ArtCode_Pharmacy);
          frmCCJS_CheckPickPharmacy.SetPRN(DBGridZakaz.DataSource.DataSet.FieldByName('NRN').AsInteger);
          frmCCJS_CheckPickPharmacy.SetBigIdAction(BigIdAction);
          frmCCJS_CheckPickPharmacy.SetUSER(IDUSER);
          frmCCJS_CheckPickPharmacy.SetItemCode(DBGridZakaz.DataSource.DataSet.FieldByName('NArtCode').AsInteger);
          frmCCJS_CheckPickPharmacy.SetPharmacy(Pharmacy);
          frmCCJS_CheckPickPharmacy.SetNamePharmacy(NamePharmacy);
          frmCCJS_CheckPickPharmacy.SetOrder(DBGridZakaz.DataSource.DataSet.FieldByName('NPRN').AsInteger);
          frmCCJS_CheckPickPharmacy.SetSIDENT(SIDENT);
          try
            frmCCJS_CheckPickPharmacy.ShowModal;
          finally
            frmCCJS_CheckPickPharmacy.Free;
          end;
        except
          on e:Exception do begin
            ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
          end;
        end;
        { Очистка таблиц времени выполнения }
        try
          spClearRunTimeBase.Parameters.ParamValues['@NIdentPharmacy'] := BigIdAction;
          spClearRunTimeBase.Parameters.ParamValues['@IDUser'] := IDUSER;
          spClearRunTimeBase.ExecProc;
          IErr := spClearRunTimeBase.Parameters.ParamValues['@RETURN_VALUE'];
          if IErr <> 0 then begin
            SErr := spClearRunTimeBase.Parameters.ParamValues['@SErr'];
            ShowMessage('Сбой при очистке таблиц времени выполнения.'+chr(10)+SErr);
          end;
        except
          on e:Exception do
            begin
              ShowMessage('Сбой при очистке таблиц времени выполнения.'+chr(10)+e.Message);
            end;
        end;
      end else begin
        SErr := spCheckPickPharmacy.Parameters.ParamValues['@SErr'];
        ShowMessage('Сбой при анализе наличия на аптеке.'+chr(10)+SErr);
      end;
    except
      on e:Exception do
        begin
          ShowMessage('Сбой при анализе наличия на аптеке.'+chr(10)+e.Message);
        end;
    end;
  end;
  GridMainRefresh;
  ShowGets;
end;

{ Распределить по аптекам }
procedure TfrmCCJS_PickPharmacy.aMain_DistributeEnabledExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if DBGridZakaz.DataSource.DataSet.FieldByName('NSignDistribute').AsInteger = 0 then begin
    //if MessageDLG('Подтвердите выполнение операции <'+aMain_DistributeEnabled.Caption+'>.',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
      try
        spPickSetDistribute.Parameters.ParamValues['@IDENT']    := SIDENT;
        spPickSetDistribute.Parameters.ParamValues['@itemCode'] := DBGridZakaz.DataSource.DataSet.FieldByName('NArtCode').AsInteger;
        spPickSetDistribute.Parameters.ParamValues['@itemID']   := DBGridZakaz.DataSource.DataSet.FieldByName('NRN').AsInteger;
        spPickSetDistribute.Parameters.ParamValues['@SignDistributeNew'] := 1;
        spPickSetDistribute.ExecProc;
        IErr := spPickSetDistribute.Parameters.ParamValues['@RETURN_VALUE'];
        SErr := spPickSetDistribute.Parameters.ParamValues['@ErrMsg'];
      if IErr <> 0 then ShowMessage(SErr);
      except
        on e:Exception do
          begin
            ShowMessage('Сбой при выполнении операции <Распределить по аптекам>. Попробуйте еще раз');
          end;
      end;
      GridMainRefresh;
      ShowGets;
    //end;
  end;
end;

{ Очистить выбор аптеки }
procedure TfrmCCJS_PickPharmacy.aMain_ClearPickExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  //if MessageDLG('Подтвердите выполнение операции <'+aMain_ClearPick.Caption+'>.',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
    try
      spClearPickPharmacy.Parameters.ParamValues['@IDENT']   := SIDENT;
      spClearPickPharmacy.Parameters.ParamValues['@orderID'] := DBGridZakaz.DataSource.DataSet.FieldByName('NPRN').AsInteger;
      spClearPickPharmacy.Parameters.ParamValues['@itemID']  := DBGridZakaz.DataSource.DataSet.FieldByName('NRN').AsInteger;
      spClearPickPharmacy.ExecProc;
      IErr := spClearPickPharmacy.Parameters.ParamValues['@RETURN_VALUE'];
      SErr := spClearPickPharmacy.Parameters.ParamValues['@SErrMsg'];
      if IErr <> 0 then ShowMessage(SErr);
    except
      on e:Exception do
        begin
          ShowMessage('Сбой при очистке выбора аптеки. Попробуйте еще раз');
        end;
    end;
    GridMainRefresh;
  //end;
end;

{ Очистить выбор всех аптек }
procedure TfrmCCJS_PickPharmacy.aMain_AllClearPickExecute(Sender: TObject);
begin
  if MessageDLG('Подтвердите выполнение операции <Очистить выбор всех аптек>.',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
  end;
end;

procedure TfrmCCJS_PickPharmacy.DBGridZakazDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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
    { Позицию заказа, которая распределена по аптекам выделяем другим фоном }
    Case db.DataSource.DataSet.FieldByName('NSignDistribute').AsInteger of
      1: begin
           db.Canvas.Brush.Color := TColor($B0B000);
           db.Canvas.Font.Color := TColor($80FFFF); { светло-желтый }
         end;
    end;
    { Замененная товарная позиция }
    if db.DataSource.DataSet.FieldByName('ISignUpd').AsInteger = 1 then begin
      db.Canvas.Brush.Color := TColor($D3EFFE); { светло-коричневый }
    end;
    { Забронированные позиции заказа }
    if Length(db.DataSource.DataSet.FieldByName('SArmourDate').AsString) <> 0 then begin
      db.Canvas.Brush.Color := TColor($CACACA);  { Светло-серый }
      db.Canvas.Font.Color := TColor(clWindowText);
    end;
    { Подкраска новых товарных позиций }
    if db.DataSource.DataSet.FieldByName('ISignAdd').AsInteger = 1 then begin
      if (Column.FieldName = 'SArtName') then begin
        db.Canvas.Brush.Color := TColor($FFCCCC); { светло-фиолетовый }
        db.Canvas.Font.Color  := clWindowText;
      end;
    end;
  end;
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  { Прорисовка img в столбце - признак резервирования}
  if Column.FieldName = 'ISignModeReserve' then begin
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
      end
      else if (Column.Field.AsInteger = 3) then begin
        imgWidth  := FCCenterJournalNetZkz.imgReserve.Width;
        imgHeight := FCCenterJournalNetZkz.imgReserve.Height;
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
      else if (Column.Field.AsInteger = 2) then db.Canvas.CopyRect(dR,FCCenterJournalNetZkz.imgComeBack.Canvas,sR)
      else if (Column.Field.AsInteger = 3) then db.Canvas.CopyRect(dR,FCCenterJournalNetZkz.imgReserve.Canvas,sR)
    except
    end;
  end;
  { Прорисовка img в столбце - признак распределения по аптекам }
  if Column.FieldName = 'NSignDistribute' then begin
    db.Canvas.FillRect(Rect);
    Column.Title.Caption := '';
    try
      if (Column.Field.AsInteger = 1) then begin
        imgWidth  := FCCenterJournalNetZkz.imgDistrToPharm.Width;
        imgHeight := FCCenterJournalNetZkz.imgDistrToPharm.Height;
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
      if (Column.Field.AsInteger = 1) then db.Canvas.CopyRect(dR,FCCenterJournalNetZkz.imgDistrToPharm.Canvas,sR)
    except
    end;
  end;
end;

procedure TfrmCCJS_PickPharmacy.DBGridItemIPADrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TfrmCCJS_PickPharmacy.aSlave_CheckPharmacyExecute(Sender: TObject);
begin
//  try
  stbarPickPharmacy.SimpleText := 'Проверка количества остатков в резерве...';
  { Проверяем наличие }
  dmJSO.ShowGoodsPharmState(DBGridZakaz.DataSource.DataSet.FieldByName('NArtCode').AsInteger,
    DBGridItemIPA.DataSource.DataSet.FieldByName('NAptekaID').AsInteger,
    'Наличие <' + DBGridZakaz.DataSource.DataSet.FieldByName('SArtName').AsString + '> в аптеке <' + DBGridItemIPA.DataSource.DataSet.FieldByName('SAptekaName').AsString + '>'
    );
  ShowGets;
end;

procedure TfrmCCJS_PickPharmacy.DBGridDistribPharmDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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
      db.Canvas.Brush.Color := TColor($CACACA); { Светло-серый }
      db.Canvas.Font.Color := TColor(clWindowText);
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

procedure TfrmCCJS_PickPharmacy.pgGridSlaveChange(Sender: TObject);
begin
  if pgGridSlave.ActivePage.Name = 'tabGridSlave_IPA' then begin
    { Получаем список аптек }
    ExecConditionItemIPA;
    { Отработка поиска по аптекек }
    if pnlLocate.Visible then
      DBGridItemIPA.DataSource.DataSet.Locate('SAptekaName',AnsiLowerCase(LocatePharmacy),[loCaseInsensitive,loPartialKey]);
  end
  else if pgGridSlave.ActivePage.Name = 'tabGridSlave_Sklad' then begin
    { Получаем количество на складе }
    qrspOstSklad.Active := false;
    CreateConditionSklad;
    qrspOstSklad.Active := true;
  end
  else if pgGridSlave.ActivePage.Name = 'tabGridSlave_Term' then begin
    { Получаем количество срокового товара }
    ExecConditionTermIPA;
  end;
  ShowGets;
end;

procedure TfrmCCJS_PickPharmacy.DBGridItemIPAKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key in [27,37,38,39,40,13] then begin
    LocatePharmacy := '';
    pnlLocate.Visible := false;
  end;
end;

procedure TfrmCCJS_PickPharmacy.DBGridItemIPAKeyPress(Sender: TObject; var Key: Char);
var
  S : String;
begin
  S := AnsiUpperCase(LocatePharmacy + Key);
  if DBGridItemIPA.DataSource.DataSet.Locate('SAptekaName',AnsiLowerCase(S),[loCaseInsensitive,loPartialKey]) then begin
    LocatePharmacy := S;
    pnlLocate.Top := DBGridItemIPA.Height - pnlLocate.Height - 3;
    pnlLocate.Visible := true;
    pnlLocate.Caption := LocatePharmacy;
    pnlLocate.Width := TextPixWidth(LocatePharmacy, pnlLocate.Font) + 20;
  end;
end;

procedure TfrmCCJS_PickPharmacy.aMain_DistributeDesabledExecute(Sender: TObject);
const
  MsgHeader = 'Сбой при выполнении операции <Отменить распределение по аптекам>.';
var
  IErr : integer;
  SErr : string;
begin
  if (DBGridZakaz.DataSource.DataSet.FieldByName('NSignDistribute').AsInteger = 1) and (GetDistribCountResSubPos = 0) then begin
    if qrspPickPositionDistribute.RecordCount > 0 then
      if MessageDLG(
                    'Подтвердите выполнение операции <' +
                    aMain_DistributeDesabled.Caption+'>. ' + chr(10) +
                    'Субпозиции будут удалены.',
                    mtConfirmation,[mbYes,mbNo],0
                   ) = mrNo then exit;
    try
      spPickSetDistribute.Parameters.ParamValues['@IDENT']    := SIDENT;
      spPickSetDistribute.Parameters.ParamValues['@itemCode'] := DBGridZakaz.DataSource.DataSet.FieldByName('NArtCode').AsInteger;
      spPickSetDistribute.Parameters.ParamValues['@itemID']   := DBGridZakaz.DataSource.DataSet.FieldByName('NRN').AsInteger;
      spPickSetDistribute.Parameters.ParamValues['@SignDistributeNew'] := 0;
      spPickSetDistribute.ExecProc;
      IErr := spPickSetDistribute.Parameters.ParamValues['@RETURN_VALUE'];
      SErr := spPickSetDistribute.Parameters.ParamValues['@ErrMsg'];
      if IErr <> 0 then begin
        ShowMessage(MsgHeader + chr(10) + SErr);
      end;
    except
      on e:Exception do
        begin
          ShowMessage(MsgHeader + chr(10) + e.Message);
        end;
    end;
    GridMainRefresh;
    ShowGets;
  end;
end;

procedure TfrmCCJS_PickPharmacy.aMain_SetModeArmorExecute(Sender: TObject);
var
  ArtCode : integer;
  Order   : integer;
begin
  ArtCode := DBGridZakaz.DataSource.DataSet.FieldByName('NArtCode').AsInteger;
  Order   := DBGridZakaz.DataSource.DataSet.FieldByName('NPRN').AsInteger;
  FCCenterJournalNetZkz.SetModeReserve(csModeReserve_Armor,csUnitReserve_CCPP,Order,ArtCode);
  GridMainRefresh;
  ShowGets;
end;

procedure TfrmCCJS_PickPharmacy.aMain_SetModeComeBackExecute(Sender: TObject);
var
  ArtCode : integer;
  Order   : integer;
begin
  ArtCode := DBGridZakaz.DataSource.DataSet.FieldByName('NArtCode').AsInteger;
  Order   := DBGridZakaz.DataSource.DataSet.FieldByName('NPRN').AsInteger;
  FCCenterJournalNetZkz.SetModeReserve(csModeReserve_ComeBack,csUnitReserve_CCPP,Order,ArtCode);
  GridMainRefresh;
  ShowGets;
end;

procedure TfrmCCJS_PickPharmacy.aMain_ClearModeExecute(Sender: TObject);
var
  ArtCode : integer;
  Order   : integer;
begin
  ArtCode := DBGridZakaz.DataSource.DataSet.FieldByName('NArtCode').AsInteger;
  Order   := DBGridZakaz.DataSource.DataSet.FieldByName('NPRN').AsInteger;
  FCCenterJournalNetZkz.SetModeReserve(csModeReserve_Clear,csUnitReserve_CCPP,Order,ArtCode);
  GridMainRefresh;
  ShowGets;
end;

procedure TfrmCCJS_PickPharmacy.aCondition_IPAExecute(Sender: TObject);
begin
  { Получаем список аптек }
  ExecConditionItemIPA;
  { Отработка поиска по аптеках }
  if pnlLocate.Visible then
    DBGridItemIPA.DataSource.DataSet.Locate('SAptekaName',AnsiLowerCase(LocatePharmacy),[loCaseInsensitive,loPartialKey]);
  ShowGets;
  { Управление видимостью атрибута }
  if aCondition_Sales.Checked then begin
    get_column_by_fieldname('NSumKol',DBGridItemIPA).Visible := true;
    aCondition_Sales.ImageIndex := 36;
  end else begin
    get_column_by_fieldname('NSumKol',DBGridItemIPA).Visible := false;
    aCondition_Sales.ImageIndex := 238;
  end;
end;

procedure TfrmCCJS_PickPharmacy.aSlave_PickWarehouseExecute(Sender: TObject);
begin
  //
end;

procedure TfrmCCJS_PickPharmacy.aSlave_AddPharmacyExecute(Sender: TObject);
var
  Pharmacy     : integer;
  NamePharmacy : string;
  IErr         : integer;
  SErr         : string;
begin
  IErr := 0;
  SErr := '';
  if pgGridSlave.ActivePage.Name = 'tabGridSlave_IPA' then begin
    Pharmacy := DBGridItemIPA.DataSource.DataSet.FieldByName('NAptekaID').AsInteger;
    NamePharmacy := DBGridItemIPA.DataSource.DataSet.FieldByName('SAptekaName').AsString;
    if    (DBGridItemIPA.DataSource.DataSet.FieldByName('DiffMinute').AsInteger >= 7)
      and (MessageDLG('На аптеке давно не было связи. Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo)
      then exit;
  end
  else if pgGridSlave.ActivePage.Name = 'tabGridSlave_Term' then begin
    Pharmacy := DBGridTerm.DataSource.DataSet.FieldByName('NAptekaID').AsInteger;
    NamePharmacy := DBGridTerm.DataSource.DataSet.FieldByName('SAptekaName').AsString;
    if    (DBGridTerm.DataSource.DataSet.FieldByName('DiffMinute').AsInteger >= 7)
      and (MessageDLG('На аптеке давно не было связи. Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo)
      then exit;
  end;
  { Генерим уникальный номер процесса }
  IErr := GenBigIDAction;
  if IErr = 0 then begin
    try
      stbarPickPharmacy.SimpleText := 'Анализ наличия остатков в аптеке...';
      { Анализ наличия на аптеке }
      spCheckPickPharmacy.Parameters.ParamValues['@NIdentPharmacy'] := BigIdAction;
      spCheckPickPharmacy.Parameters.ParamValues['@IDUser']         := IDUSER;
      spCheckPickPharmacy.Parameters.ParamValues['@ItemCode']       := DBGridZakaz.DataSource.DataSet.FieldByName('NArtCode').AsInteger;
      spCheckPickPharmacy.Parameters.ParamValues['@Pharmacy']       := Pharmacy;
      spCheckPickPharmacy.Parameters.ParamValues['@SIDENT']         := '';
      spCheckPickPharmacy.Parameters.ParamValues['@Order']          := 0;
      spCheckPickPharmacy.ExecProc;
      IErr := spCheckPickPharmacy.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr = 0 then begin
        { Определение количества для резервирования }
        try
          frmCCJS_CheckPickPharmacy := TfrmCCJS_CheckPickPharmacy.Create(Self);
          frmCCJS_CheckPickPharmacy.SetMode(cFCCJS_CheckPP_ArtCode_Distribute);
          frmCCJS_CheckPickPharmacy.SetPRN(DBGridZakaz.DataSource.DataSet.FieldByName('NRN').AsInteger);
          frmCCJS_CheckPickPharmacy.SetBigIdAction(BigIdAction);
          frmCCJS_CheckPickPharmacy.SetUSER(IDUSER);
          frmCCJS_CheckPickPharmacy.SetItemCode(DBGridZakaz.DataSource.DataSet.FieldByName('NArtCode').AsInteger);
          frmCCJS_CheckPickPharmacy.SetPharmacy(Pharmacy);
          frmCCJS_CheckPickPharmacy.SetNamePharmacy(NamePharmacy);
          frmCCJS_CheckPickPharmacy.SetOrder(DBGridZakaz.DataSource.DataSet.FieldByName('NPRN').AsInteger);
          frmCCJS_CheckPickPharmacy.SetSIDENT(SIDENT);
          frmCCJS_CheckPickPharmacy.SetModeReserve(DBGridZakaz.DataSource.DataSet.FieldByName('ISignModeReserve').AsInteger);
          try
            frmCCJS_CheckPickPharmacy.ShowModal;
          finally
            frmCCJS_CheckPickPharmacy.Free;
          end;
        except
          on e:Exception do begin
            ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
          end;
        end;
        { Очистка таблиц времени выполнения }
        try
          spClearRunTimeBase.Parameters.ParamValues['@NIdentPharmacy'] := BigIdAction;
          spClearRunTimeBase.Parameters.ParamValues['@IDUser'] := IDUSER;
          spClearRunTimeBase.ExecProc;
          IErr := spClearRunTimeBase.Parameters.ParamValues['@RETURN_VALUE'];
          if IErr <> 0 then begin
            SErr := spClearRunTimeBase.Parameters.ParamValues['@SErr'];
            ShowMessage('Сбой при очистке таблиц времени выполнения.'+chr(10)+SErr);
          end;
        except
          on e:Exception do
            begin
              ShowMessage('Сбой при очистке таблиц времени выполнения.'+chr(10)+e.Message);
            end;
        end;
      end else begin
        SErr := spCheckPickPharmacy.Parameters.ParamValues['@SErr'];
        ShowMessage('Сбой при анализе наличия на аптеке.'+chr(10)+SErr);
      end;
    except
      on e:Exception do
        begin
          ShowMessage('Сбой при анализе наличия на аптеке.'+chr(10)+e.Message);
        end;
    end;
  end;
  GridMainRefresh;
  ShowGets;
end;

procedure TfrmCCJS_PickPharmacy.aSlave_AddWarehouseExecute(Sender: TObject);
begin
  //
end;

procedure TfrmCCJS_PickPharmacy.aDistrib_ClearPickExecute(Sender: TObject);
const
  HeaderMsg = 'Сбой при удалении товарной позиции.';
var
  IErr : integer;
  SErr : string;
begin
  IErr := 0;
  SErr := '';
  if MessageDLG('Подтвердите удаление позиции.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  try
    spPickPosDistribClear.Parameters.ParamValues['@NRN'] := DBGridDistribPharm.DataSource.DataSet.FieldByName('NRN').AsInteger;
    spPickPosDistribClear.Parameters.ParamValues['@SIDENT'] := SIDENT;
    spPickPosDistribClear.Parameters.ParamValues['@IDUser'] := IDUSER;
    spPickPosDistribClear.ExecProc;
    IErr := spPickPosDistribClear.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      SErr := spPickPosDistribClear.Parameters.ParamValues['@SErr'];
      ShowMessage(HeaderMsg+chr(10)+SErr);
    end else begin
      GridMainRefresh;
      ShowGets;
    end;
  except
    on e:Exception do
      begin
        ShowMessage(HeaderMsg+chr(10)+e.Message);
      end;
  end;
end;

procedure TfrmCCJS_PickPharmacy.aDistrib_SetModeArmorExecute(Sender: TObject);
begin
  SetModePosDistribute(csModeReserve_Armor);
  GridMainRefresh;
  ShowGets;
end;

procedure TfrmCCJS_PickPharmacy.aDistrib_SetModeComeBackExecute(Sender: TObject);
begin
  SetModePosDistribute(csModeReserve_ComeBack);
  GridMainRefresh;
  ShowGets;
end;

procedure TfrmCCJS_PickPharmacy.aDistrib_ClearModeExecute(Sender: TObject);
begin
  SetModePosDistribute(csModeReserve_Clear);
  GridMainRefresh;
  ShowGets;
end;

procedure TfrmCCJS_PickPharmacy.dsPickPositionDistributeDataChange(Sender: TObject; Field: TField);
begin
  ShowGets;
end;

procedure TfrmCCJS_PickPharmacy.aSlave_OrderPickPharmacyExecute(Sender: TObject);
var
  Pharmacy     : integer;
  NamePharmacy : string;
  IErr         : integer;
  SErr         : string;
begin
  IErr := 0;
  SErr := '';
  if pgGridSlave.ActivePage.Name = 'tabGridSlave_IPA' then begin
    Pharmacy := DBGridItemIPA.DataSource.DataSet.FieldByName('NAptekaID').AsInteger;
    NamePharmacy := DBGridItemIPA.DataSource.DataSet.FieldByName('SAptekaName').AsString;
    if    (DBGridItemIPA.DataSource.DataSet.FieldByName('DiffMinute').AsInteger >= 7)
      and (MessageDLG('На аптеке давно не было связи. Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo)
      then exit;
  end
  else if pgGridSlave.ActivePage.Name = 'tabGridSlave_Term' then begin
    Pharmacy := DBGridTerm.DataSource.DataSet.FieldByName('NAptekaID').AsInteger;
    NamePharmacy := DBGridTerm.DataSource.DataSet.FieldByName('SAptekaName').AsString;
    if    (DBGridTerm.DataSource.DataSet.FieldByName('DiffMinute').AsInteger >= 7)
      and (MessageDLG('На аптеке давно не было связи. Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo)
      then exit;
  end;
  { Генерим уникальный номер процесса }
  IErr := GenBigIDAction;
  if IErr = 0 then begin
    try
      stbarPickPharmacy.SimpleText := 'Анализ наличия остатков в аптеке...';
      { Анализ наличия на аптеке }
      spCheckPickPharmacy.Parameters.ParamValues['@NIdentPharmacy'] := BigIdAction;
      spCheckPickPharmacy.Parameters.ParamValues['@IDUser']         := IDUSER;
      spCheckPickPharmacy.Parameters.ParamValues['@ItemCode']       := 0;
      spCheckPickPharmacy.Parameters.ParamValues['@Pharmacy']       := Pharmacy;
      spCheckPickPharmacy.Parameters.ParamValues['@SIDENT']         := SIDENT;
      spCheckPickPharmacy.Parameters.ParamValues['@Order']          := DBGridZakaz.DataSource.DataSet.FieldByName('NPRN').AsInteger;
      spCheckPickPharmacy.ExecProc;
      IErr := spCheckPickPharmacy.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr = 0 then begin
        { Определение количества для резервирования }
        try
          frmCCJS_CheckPickPharmacy := TfrmCCJS_CheckPickPharmacy.Create(Self);
          frmCCJS_CheckPickPharmacy.SetMode(cFCCJS_CheckPP_Order_Pharmacy);
          frmCCJS_CheckPickPharmacy.SetPRN(DBGridZakaz.DataSource.DataSet.FieldByName('NRN').AsInteger);
          frmCCJS_CheckPickPharmacy.SetBigIdAction(BigIdAction);
          frmCCJS_CheckPickPharmacy.SetUSER(IDUSER);
          frmCCJS_CheckPickPharmacy.SetItemCode(DBGridZakaz.DataSource.DataSet.FieldByName('NArtCode').AsInteger);
          frmCCJS_CheckPickPharmacy.SetPharmacy(Pharmacy);
          frmCCJS_CheckPickPharmacy.SetNamePharmacy(NamePharmacy);
          frmCCJS_CheckPickPharmacy.SetOrder(DBGridZakaz.DataSource.DataSet.FieldByName('NPRN').AsInteger);
          frmCCJS_CheckPickPharmacy.SetSIDENT(SIDENT);
          try
            frmCCJS_CheckPickPharmacy.ShowModal;
          finally
            frmCCJS_CheckPickPharmacy.Free;
          end;
        except
          on e:Exception do begin
            ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
          end;
        end;
        { Очистка таблиц времени выполнения }
        try
          spClearRunTimeBase.Parameters.ParamValues['@NIdentPharmacy'] := BigIdAction;
          spClearRunTimeBase.Parameters.ParamValues['@IDUser'] := IDUSER;
          spClearRunTimeBase.ExecProc;
          IErr := spClearRunTimeBase.Parameters.ParamValues['@RETURN_VALUE'];
          if IErr <> 0 then begin
            SErr := spClearRunTimeBase.Parameters.ParamValues['@SErr'];
            ShowMessage('Сбой при очистке таблиц времени выполнения.'+chr(10)+SErr);
          end;
        except
          on e:Exception do
            begin
              ShowMessage('Сбой при очистке таблиц времени выполнения.'+chr(10)+e.Message);
            end;
        end;
      end else begin
        SErr := spCheckPickPharmacy.Parameters.ParamValues['@SErr'];
        ShowMessage('Сбой при анализе наличия на аптеке.'+chr(10)+SErr);
      end;
    except
      on e:Exception do
        begin
          ShowMessage('Сбой при анализе наличия на аптеке.'+chr(10)+e.Message);
        end;
    end;
  end;
  GridMainRefresh;
  ShowGets;
end;

procedure TfrmCCJS_PickPharmacy.DBGridTermDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TfrmCCJS_PickPharmacy.aMain_RefreshExecute(Sender: TObject);
var
  RN: Integer;
begin
  if not qrspZakaz.IsEmpty then RN := qrspZakaz.FieldByName('NRN').AsInteger else RN := -1;
  qrspZakaz.Requery;
  qrspZakaz.Locate('NRN', RN, []);
  ShowGets;
end;

procedure TfrmCCJS_PickPharmacy.aDistrib_RefreshExecute(Sender: TObject);
var
  RN: Integer;
begin
  if not qrspPickPositionDistribute.IsEmpty then RN := qrspPickPositionDistribute.FieldByName('NRN').AsInteger else RN := -1;
  qrspPickPositionDistribute.Requery;
  qrspPickPositionDistribute.Locate('NRN', RN, []);
  ShowGets;
end;

procedure TfrmCCJS_PickPharmacy.aMain_AddPosExecute(Sender: TObject);
begin
  //
end;

procedure TfrmCCJS_PickPharmacy.aMain_UpdPosExecute(Sender: TObject);
begin
  //
end;

procedure TfrmCCJS_PickPharmacy.aMain_DelPosExecute(Sender: TObject);
begin
  //
end;

procedure TfrmCCJS_PickPharmacy.aMain_GroupSetModeArmorExecute(Sender: TObject);
var
  Order : integer;
begin
  //if MessageDLG('Подтвердите выполнение операции <' + aControl_SaveExit.Caption + '>.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  Order := DBGridZakaz.DataSource.DataSet.FieldByName('NPRN').AsInteger;
  FCCenterJournalNetZkz.SetGroupModeReserve(csModeReserve_Armor,csUnitReserve_CCPP,Order);
  GridMainRefresh;
  ShowGets;
end;

procedure TfrmCCJS_PickPharmacy.aMain_GroupSetModeComeBackExecute(Sender: TObject);
var
  Order : integer;
begin
  //if MessageDLG('Подтвердите выполнение операции <' + aControl_SaveExit.Caption + '>.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  Order := DBGridZakaz.DataSource.DataSet.FieldByName('NPRN').AsInteger;
  FCCenterJournalNetZkz.SetGroupModeReserve(csModeReserve_ComeBack,csUnitReserve_CCPP,Order);
  GridMainRefresh;
  ShowGets;
end;

procedure TfrmCCJS_PickPharmacy.aMain_GroupClearModeExecute(Sender: TObject);
var
  Order : integer;
begin
  //if MessageDLG('Подтвердите выполнение операции <' + aControl_SaveExit.Caption + '>.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  Order := DBGridZakaz.DataSource.DataSet.FieldByName('NPRN').AsInteger;
  FCCenterJournalNetZkz.SetGroupModeReserve(csModeReserve_Clear,csUnitReserve_CCPP,Order);
  GridMainRefresh;
  ShowGets;
end;

function TfrmCCJS_PickPharmacy.ShowDialog(OnReserve: TReserveEvent): TActionResult;
begin
  FOnReserve := OnReserve;
  ShowModal;
end;

end.
