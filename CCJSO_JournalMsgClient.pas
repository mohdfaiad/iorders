unit CCJSO_JournalMsgClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, ActnList, DB, ADODB, ComCtrls, ToolWin,
  StdCtrls, UCCenterJournalNetZkz;

  { Условия отбора  }
  type TJSOMsgClient_Condition = record
    BeginDate : string;
    EndDate   : string;
    Order     : string;
    Pharm     : string;
    Prefix    : integer;
    Phone     : string;
    SMSType   : integer;
  end;

  { Строка }
  type TJSOMsgClient_Item = record
    NRN         : integer;
    NOrder      : integer;
    SOrder      : string;
    NCash       : double;
    SPrefix     : string;
    NPharm      : integer;
    SPharm      : string;
    ISMSType    : integer;
    SSMSType    : string;
    SPhone      : string;
    SEmail      : string;
    SCreateDate : string;
    NUSER       : integer;
    SUSER       : string;
    SNote       : string;
    IErr        : integer;
    SErr        : string;
  end;

type
  TfrmCCJSO_JournalMsgClient = class(TForm)
    pnlCond: TPanel;
    pnlGrid: TPanel;
    pnlCond_Tool: TPanel;
    pnlCond_Fields: TPanel;
    pnlGridControl: TPanel;
    pnlGridControl_Show: TPanel;
    pnlGridControl_Tool: TPanel;
    GridMain: TDBGrid;
    aList: TActionList;
    aExit: TAction;
    aItemInfo: TAction;
    aRefresh: TAction;
    aCondClear: TAction;
    aCondChange: TAction;
    tbarCond: TToolBar;
    tbtnCondClear: TToolButton;
    tbarTool: TToolBar;
    tbtnItemInfo: TToolButton;
    tbtbRefresh: TToolButton;
    qrspMain: TADOStoredProc;
    dsMain: TDataSource;
    lblCond_Begin: TLabel;
    edCond_Begin: TEdit;
    btnCond_Begin: TButton;
    lblJCond_End: TLabel;
    edCond_End: TEdit;
    btnCond_End: TButton;
    aSlDate: TAction;
    lblJCond_Prefix: TLabel;
    cmbxCond_Prefix: TComboBox;
    lblCond_Order: TLabel;
    edCond_Order: TEdit;
    lblCond_Phone: TLabel;
    edCond_Phone: TEdit;
    lblCond_Pharm: TLabel;
    edCond_Pharm: TEdit;
    lblCond_Type: TLabel;
    cmbxCond_Type: TComboBox;
    qrspSMSType: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aItemInfoExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aCondClearExecute(Sender: TObject);
    procedure aCondChangeExecute(Sender: TObject);
    procedure GridMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aSlDateExecute(Sender: TObject);
    procedure GridMainTitleClick(Column: TColumn);
  private
    { Private declarations }
    bSignActive   : boolean;
    RecSession    : TUserSession;
    RecCondMain   : TJSOMsgClient_Condition;
    SortField     : string;
    SortDirection : boolean;
    procedure ShowGets;
    procedure ExecConditionQRMain;
    procedure CreateConditionQRMain;
    procedure SaveConditionQRMain;        { Сохранение значенией полей панели отбора в RecConditionMain }
    procedure SetClearCondition;          { Очистка условий отбора RecConditionMain }
    procedure GridMainRefresh;
    procedure SetRecItem;
    function  GetStateClearMainCondition : boolean;  { Состояние условия отбора журнала заказов: true - очищено  }
  public
    { Public declarations }
    procedure SetRecSession(Parm : TUserSession);
  end;

var
  frmCCJSO_JournalMsgClient: TfrmCCJSO_JournalMsgClient;

implementation

uses UMAIN, CCJSO_DM, CCJSO_SetFieldDate, UTIL;

{$R *.dfm}

procedure TfrmCCJSO_JournalMsgClient.FormCreate(Sender: TObject);
begin
  { Инициализация }
  bSignActive   := false;
  SortField     := '';
  SortDirection := false;
end;

procedure TfrmCCJSO_JournalMsgClient.FormActivate(Sender: TObject);
begin
  { Иконка формы }
  FCCenterJournalNetZkz.imgMain.GetIcon(385,self.Icon);
  { Формирование списка префиксов }
  cmbxCond_Prefix.Clear;
  cmbxCond_Prefix.Items.Add('Все');
  cmbxCond_Prefix.Items.Add(DM_CCJSO.GetPrefNumbOrderApteka911);
  cmbxCond_Prefix.Items.Add('TabletkiUA');
  cmbxCond_Prefix.Items.Add(DM_CCJSO.GetPrefNumbOrderIApteka);
  cmbxCond_Prefix.Items.Add(DM_CCJSO.GetPrefNumbOrderManual);
  cmbxCond_Prefix.Items.Add(DM_CCJSO.GetPrefNumbOrderTradePoint);
  cmbxCond_Prefix.ItemIndex := 0;
  { Формирование списка наименований типов уведомлений }
  cmbxCond_Type.Clear;
  cmbxCond_Type.Items.Add('Все');
  qrspSMSType.Open;
  qrspSMSType.First;
  while not qrspSMSType.Eof do begin
    cmbxCond_Type.Items.Add(qrspSMSType.FieldByName('NameType').AsString);
    qrspSMSType.Next;
  end;
  cmbxCond_Type.ItemIndex := 0;
  { Инициализация записи условий отбора }
  edCond_Begin.Text  := FormatDateTime('dd-mm-yyyy hh:nn:ss', date);
  SaveConditionQRMain;
  { Форма активна }
  bSignActive := true;
  { Инициализация сортировки }
  GridMain.OnTitleClick(GridMain.Columns[0]);
  GridMain.SetFocus;
end;

procedure TfrmCCJSO_JournalMsgClient.ShowGets;
var
  SCaption : string;
begin
  if bSignActive then begin
    { Доступ к очистке условий отбора }
    if GetStateClearMainCondition
      then aCondClear.Enabled := false
      else aCondClear.Enabled := true;
    { Доступ к элементам управления }
    if not qrspMain.IsEmpty then begin
      aItemInfo.Enabled := true;
    end else begin
      aItemInfo.Enabled := false;
    end;
    { Количество отобранных заказов }
    SCaption := VarToStr(qrspMain.RecordCount);
    pnlGridControl_Show.Caption := SCaption; pnlGridControl_Show.Width := TextPixWidth(SCaption, pnlGridControl_Show.Font) + 20;
  end;
end;

procedure TfrmCCJSO_JournalMsgClient.SetRecSession(Parm : TUserSession); begin RecSession := Parm; end;

procedure TfrmCCJSO_JournalMsgClient.aExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmCCJSO_JournalMsgClient.ExecConditionQRMain;
var
  RN: Integer;
begin
  if not qrspMain.IsEmpty then RN := qrspMain.FieldByName('NRN').AsInteger else RN := -1;
  qrspMain.Active := false;
  CreateConditionQRMain;
  qrspMain.Active := true;
  qrspMain.Locate('NRN', RN, []);
end;

procedure TfrmCCJSO_JournalMsgClient.CreateConditionQRMain;
begin
  if length(trim(RecCondMain.BeginDate)) = 0
    then qrspMain.Parameters.ParamValues['@Begin'] := ''
    else qrspMain.Parameters.ParamValues['@Begin'] := FormatDateTime('yyyy-mm-dd hh:nn:ss', StrToDateTime(RecCondMain.BeginDate,DM_CCJSO.GetDFormatSet));
  if length(trim(RecCondMain.EndDate)) = 0
    then qrspMain.Parameters.ParamValues['@End'] := ''
    else qrspMain.Parameters.ParamValues['@End'] := FormatDateTime('yyyy-mm-dd hh:nn:ss', StrToDateTime(RecCondMain.EndDate,DM_CCJSO.GetDFormatSet));
  if length(trim(RecCondMain.Order)) = 0
    then qrspMain.Parameters.ParamValues['@Order'] := ''
    else qrspMain.Parameters.ParamValues['@Order'] := RecCondMain.Order;
  if length(trim(RecCondMain.Pharm)) = 0
    then qrspMain.Parameters.ParamValues['@Pharm'] := ''
    else qrspMain.Parameters.ParamValues['@Pharm'] := RecCondMain.Pharm;
  if length(trim(RecCondMain.Phone)) = 0
    then qrspMain.Parameters.ParamValues['@Phone'] := ''
    else qrspMain.Parameters.ParamValues['@Phone'] := RecCondMain.Phone;
  if RecCondMain.Prefix = 0
    then qrspMain.Parameters.ParamValues['@Prefix'] := ''
    else qrspMain.Parameters.ParamValues['@Prefix'] := cmbxCond_Prefix.Items[RecCondMain.Prefix];
  qrspMain.Parameters.ParamValues['@Type']      := RecCondMain.SMSType;
  qrspMain.Parameters.ParamValues['@OrderBy']   := SortField;
  qrspMain.Parameters.ParamValues['@Direction'] := SortDirection;
end;

procedure TfrmCCJSO_JournalMsgClient.SaveConditionQRMain;        { Сохранение значенией полей панели отбора в RecConditionMain }
begin
  RecCondMain.BeginDate := edCond_Begin.Text;
  RecCondMain.EndDate   := edCond_End.Text;
  RecCondMain.Order     := edCond_Order.Text;
  RecCondMain.Pharm     := edCond_Pharm.Text;
  RecCondMain.Prefix    := cmbxCond_Prefix.ItemIndex;
  RecCondMain.Phone     := edCond_Phone.Text;
  RecCondMain.SMSType   := cmbxCond_Type.ItemIndex;
end;

procedure TfrmCCJSO_JournalMsgClient.SetClearCondition;          { Очистка условий отбора RecConditionMain }
begin
  edCond_Order.Text         := '';
  edCond_Pharm.Text         := '';
  cmbxCond_Prefix.ItemIndex := 0;
  cmbxCond_Type.ItemIndex   := 0;
  edCond_Phone.Text         := '';
  SaveConditionQRMain;
end;

procedure TfrmCCJSO_JournalMsgClient.GridMainRefresh;
var
  RN: Integer;
begin
  if not qrspMain.IsEmpty then RN := qrspMain.FieldByName('NRN').AsInteger else RN := -1;
  qrspMain.Requery;
  qrspMain.Locate('NRN', RN, []);
end;

procedure TfrmCCJSO_JournalMsgClient.SetRecItem;
begin
end;

function  TfrmCCJSO_JournalMsgClient.GetStateClearMainCondition : boolean;  { Состояние условия отбора журнала заказов: true - очищено  }
var
  bResReturn : boolean;
begin
  if     (RecCondMain.Prefix                  = 0)
     and (RecCondMain.SMSType                 = 0)
     and (length(trim(RecCondMain.Order))     = 0)
     and (length(trim(RecCondMain.Phone))     = 0)
     and (length(trim(RecCondMain.Pharm))     = 0)
  then bResReturn := true
  else bResReturn := false;
  result := bResReturn;
end;

procedure TfrmCCJSO_JournalMsgClient.aItemInfoExecute(Sender: TObject);
begin
//
end;

procedure TfrmCCJSO_JournalMsgClient.aRefreshExecute(Sender: TObject);
begin
  GridMainRefresh;
  ShowGets;
end;

procedure TfrmCCJSO_JournalMsgClient.aCondClearExecute(Sender: TObject);
begin
  SetClearCondition;
  ExecConditionQRMain;
  ShowGets;
end;

procedure TfrmCCJSO_JournalMsgClient.aCondChangeExecute(Sender: TObject);
begin
  if bSignActive then begin
    { Сохраняем значения полей условия отбора }
    SaveConditionQRMain;
    { Формируем условие отбора }
    ExecConditionQRMain;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_JournalMsgClient.GridMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TfrmCCJSO_JournalMsgClient.aSlDateExecute(Sender: TObject);
var
  EdText         : string;
  DVal           : TDateTime;
  WHeaderCaption : string;
  Tag            : integer;
  ScreenPos      : TPoint;  { расчетный левый верхний угол окна ввода даты }
begin
  Tag := 0;
  if      Sender is TAction then Tag := (Sender as TAction).ActionComponent.Tag
  else if Sender is TEdit   then Tag := (Sender as TEdit).Tag;
  case Tag of
    10: begin
          EdText := edCond_Begin.Text;     WHeaderCaption := 'Период даты создания (начало)';
          ScreenPos := Point(edCond_Begin.ClientOrigin.X + 15,edCond_Begin.ClientOrigin.Y + edCond_Begin.Height + 10);
    end;
    11: begin
          EdText := edCond_End.Text;    WHeaderCaption := 'Период даты создания (окончание)';
          ScreenPos := Point(edCond_End.ClientOrigin.X + 15,edCond_End.ClientOrigin.Y + edCond_End.Height + 10);
    end;
  end;
  if length(trim(EdText)) > 0 then begin
    DVal := StrToDateTime(EdText,DM_CCJSO.GetDFormatSet);
  end else DVal := now;
  try
    frmCCJSO_SetFieldDate := TfrmCCJSO_SetFieldDate.Create(Self);
    frmCCJSO_SetFieldDate.SetMode(cFieldDate_Shared);
    frmCCJSO_SetFieldDate.SetUserSession(RecSession);
    frmCCJSO_SetFieldDate.SetTypeExec(cSFDTypeExec_Return);
    frmCCJSO_SetFieldDate.SetClear(true);
    frmCCJSO_SetFieldDate.SetDateShared(DVal,EdText,WHeaderCaption);
    frmCCJSO_SetFieldDate.SetScreenPos(ScreenPos);
    try
      frmCCJSO_SetFieldDate.ShowModal;
      if frmCCJSO_SetFieldDate.GetOk then begin
        case Tag of
          10: edCond_Begin.Text := frmCCJSO_SetFieldDate.GetSDate;
          11: edCond_End.Text   := frmCCJSO_SetFieldDate.GetSDate;
        end;
      end;
    finally
      FreeAndNil(frmCCJSO_SetFieldDate);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
  ShowGets;
end;

procedure TfrmCCJSO_JournalMsgClient.GridMainTitleClick(Column: TColumn);
var
  iCkl : integer;
begin
  { Контроль на разрешенные поля сортировки }
  if    (Column.FieldName = 'SCreateDate')
     or (Column.FieldName = 'SSMSType')
     or (Column.FieldName = 'SPrefix')
     or (Column.FieldName = 'NOrder')
     or (Column.FieldName = 'SPharm')
     or (Column.FieldName = 'SPhone')
     or (Column.FieldName = 'NCash') then begin
    { Собственно управление сортировкой }
    if Column.Title.Font.Color = clWindowText then begin
      { Восстанавливаем прорисовку по умолчанию }
      for iCkl := 0 to GridMain.Columns.count - 1 do begin
        if GridMain.Columns[iCkl].Title.Font.Color <> clWindowText then begin
          GridMain.Columns[iCkl].Title.Font.Color := clWindowText;
          GridMain.Columns[iCkl].Title.Font.Style := [];
          GridMain.Columns[iCkl].Title.Caption := copy(GridMain.Columns[iCkl].Title.Caption,2,length(GridMain.Columns[iCkl].Title.Caption)-1);
        end;
      end;
      { Для выбранного столбца включаем сортировку по возрастанию }
      Column.Title.Font.Color := clBlue;
      Column.Title.Font.Style := [fsBold];
      Column.Title.Caption := chr(24)+Column.Title.Caption;
      SortField := Column.FieldName;
      SortDirection := false;
      ExecConditionQRMain;
    end
    else if Column.Title.Font.Color = clBlue then begin
      { Для выбранного столбца переключаем на сортировку по убыванию }
      Column.Title.Font.Color := clFuchsia;
      Column.Title.Font.Style := [fsBold];
      Column.Title.Caption := '!'+copy(Column.Title.Caption,2,length(Column.Title.Caption)-1);
      SortField := Column.FieldName;
      SortDirection := true;
      ExecConditionQRMain;
    end
    else if Column.Title.Font.Color = clFuchsia then begin
      { Для выбранного столбца переключаем на сортировку по возрастанию }
      Column.Title.Font.Color := clBlue;
      Column.Title.Font.Style := [fsBold];
      Column.Title.Caption := chr(24)+copy(Column.Title.Caption,2,length(Column.Title.Caption)-1);
      SortField := Column.FieldName;
      SortDirection := false;
      ExecConditionQRMain;
    end;
  end;
  ShowGets;
end;

end.
