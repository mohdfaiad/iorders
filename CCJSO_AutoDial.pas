unit CCJSO_AutoDial;

{
  © PgkSoft 17.06.2016
  Журнал регистрации автодозвонов
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  UCCenterJournalNetZkz, ExtCtrls, ActnList, Grids, DBGrids, ComCtrls,
  ToolWin, StdCtrls, DB, ADODB;

  { Условия отбора  }
  type TJSOAutoDial_Condition = record
    BeginDate : string;
    EndDate   : string;
  end;
  { Строка }
  type TJSOAutoDial_Item = record
    NRN             : integer;
    SCreateDate     : string;
    SPrefix         : string;
    NOrder          : integer;
    SFullOrder      : string;
    SOrder          : string;
    SOrderDT        : string;
    SPhone          : string;
    SClient         : string;
    IAutoDialType   : integer;
    SAutoDialType   : string;
    ICounter        : integer;
    SNameFileRoot   : string;
    SAutoDialBegin  : string;
    SAutoDialEnd    : string;
    IAutoDialResult : integer;
    SAutoDialResult : string;
    BFileExists     : boolean;
    SFileExists     : string;
    NCheckCounter   : integer;
    SCheckDate      : string;
    NRetryCounter   : integer;
  end;

type
  TfrmCCJSO_AutoDial = class(TForm)
    pnlHeader: TPanel;
    pnlHeader_Show: TPanel;
    pnlHeader_Cond: TPanel;
    pnlGrid: TPanel;
    pnlHeader_Cond_Tool: TPanel;
    tbarCondition: TToolBar;
    tbtnCondition_Clear: TToolButton;
    aList: TActionList;
    aCondExt: TAction;
    aCondClear: TAction;
    aExit: TAction;
    pnlHeader_Cond_Field: TPanel;
    lblCndDatePeriod_with: TLabel;
    edCndDateBegin: TEdit;
    btnCndDateBegin: TButton;
    lblCndDatePeriod_toOn: TLabel;
    edCndDateEnd: TEdit;
    btnCndDateEnd: TButton;
    GridMain: TDBGrid;
    aSlDate: TAction;
    aSlCurrentOrder: TAction;
    aCondChange: TAction;
    tbarCurrentOrder: TToolBar;
    tbtn_CurrentOrder: TToolButton;
    dsMain: TDataSource;
    qrMain: TADOStoredProc;
    aRefresh: TAction;
    tbtnCondition_Refresh: TToolButton;
    aRecItem: TAction;
    ToolButton1: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aCondClearExecute(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aSlDateExecute(Sender: TObject);
    procedure aCondChangeExecute(Sender: TObject);
    procedure aSlCurrentOrderUpdate(Sender: TObject);
    procedure GridMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aRefreshExecute(Sender: TObject);
    procedure GridMainDblClick(Sender: TObject);
    procedure aRecItemExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActive : boolean;
    Order       : integer;
    Prefix      : string;
    RecSession  : TUserSession;
    RecCondMain : TJSOAutoDial_Condition;
    RecItem     : TJSOAutoDial_Item;
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
    procedure SetOrder(Parm : integer);
    procedure SetPrefix(Parm : string);
    procedure SetCndDateBegin(Parm : string);
  end;

var
  frmCCJSO_AutoDial: TfrmCCJSO_AutoDial;

implementation

uses
  CCJSO_DM, CCJSO_SetFieldDate, Util, UMain, CCJSO_AutoDialEdit;

{$R *.dfm}

procedure TfrmCCJSO_AutoDial.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := false;
  Prefix      := '';
  Order       := 0;
end;

procedure TfrmCCJSO_AutoDial.FormActivate(Sender: TObject);
begin
  if not ISignActive then begin
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(370,self.Icon);
    { Текущий заказ }
    if Order > 0 then begin
      aSlCurrentOrder.Caption := 'Заказ № ' + VarToStr(Order);
      pnlHeader_Cond_Tool.Width := tbarCondition.Width + tbarCurrentOrder.Width + 1;
    end else begin
      aSlCurrentOrder.Visible := false;
      pnlHeader_Cond_Tool.Width := tbarCondition.Width + 1;
    end;
    SaveConditionQRMain;
    { Форма активна }
    ISignActive := true;
    aSlCurrentOrder.Checked := true;
    aCondChange.Execute;
    ShowGets;
    GridMain.SetFocus;
  end;
end;

procedure TfrmCCJSO_AutoDial.ShowGets;
var
  SCaption : string;
begin
  if ISignActive then begin
    { Доступ к очистке условий отбора }
    if GetStateClearMainCondition
      then aCondClear.Enabled := false
      else aCondClear.Enabled := true;
    { Доступ к элементам управления }
    if not qrMain.IsEmpty then begin
      aRecItem.Enabled := true;
    end else begin
      aRecItem.Enabled := false;
    end;
    { Количество отобранных заказов }
    SCaption := VarToStr(qrMain.RecordCount);
    pnlHeader_Show.Caption := SCaption; pnlHeader_Show.Width := TextPixWidth(SCaption, pnlHeader_Show.Font) + 20;
  end;
end;

procedure TfrmCCJSO_AutoDial.SetRecSession(Parm : TUserSession); begin RecSession := Parm; end;
procedure TfrmCCJSO_AutoDial.SetOrder(Parm : integer); begin Order := Parm;  end;
procedure TfrmCCJSO_AutoDial.SetPrefix(Parm : string); begin Prefix := Parm; end;
procedure TfrmCCJSO_AutoDial.SetCndDateBegin(Parm : string); begin edCndDateBegin.Text := Parm; end;

procedure TfrmCCJSO_AutoDial.SetRecItem;
begin
  RecItem.NRN             := GridMain.DataSource.DataSet.FieldByName('NRN').AsInteger;
  RecItem.SCreateDate     := GridMain.DataSource.DataSet.FieldByName('SCreateDate').AsString;
  RecItem.SPrefix         := GridMain.DataSource.DataSet.FieldByName('SPrefix').AsString;
  RecItem.NOrder          := GridMain.DataSource.DataSet.FieldByName('NOrder').AsInteger;
  RecItem.SFullOrder      := GridMain.DataSource.DataSet.FieldByName('SFullOrder').AsString;
  RecItem.SOrder          := GridMain.DataSource.DataSet.FieldByName('SOrder').AsString;
  RecItem.SOrderDT        := GridMain.DataSource.DataSet.FieldByName('SOrderDT').AsString;
  RecItem.SPhone          := GridMain.DataSource.DataSet.FieldByName('SPhone').AsString;
  RecItem.SClient         := GridMain.DataSource.DataSet.FieldByName('SClient').AsString;
  RecItem.IAutoDialType   := GridMain.DataSource.DataSet.FieldByName('IAutoDialType').AsInteger;
  RecItem.SAutoDialType   := GridMain.DataSource.DataSet.FieldByName('SAutoDialType').AsString;
  RecItem.ICounter        := GridMain.DataSource.DataSet.FieldByName('ICounter').AsInteger;
  RecItem.SNameFileRoot   := GridMain.DataSource.DataSet.FieldByName('SNameFileRoot').AsString;
  RecItem.SAutoDialBegin  := GridMain.DataSource.DataSet.FieldByName('SAutoDialBegin').AsString;
  RecItem.SAutoDialEnd    := GridMain.DataSource.DataSet.FieldByName('SAutoDialEnd').AsString;
  RecItem.IAutoDialResult := GridMain.DataSource.DataSet.FieldByName('IAutoDialResult').AsInteger;
  RecItem.SAutoDialResult := GridMain.DataSource.DataSet.FieldByName('SAutoDialResult').AsString;
  RecItem.BFileExists     := GridMain.DataSource.DataSet.FieldByName('BFileExists').AsBoolean;
  RecItem.SFileExists     := GridMain.DataSource.DataSet.FieldByName('SFileExists').AsString;
  RecItem.NCheckCounter   := GridMain.DataSource.DataSet.FieldByName('NCheckCounter').AsInteger;
  RecItem.SCheckDate      := GridMain.DataSource.DataSet.FieldByName('SCheckDate').AsString;
  RecItem.NRetryCounter   := GridMain.DataSource.DataSet.FieldByName('NRetryCounter').AsInteger;
end;

procedure TfrmCCJSO_AutoDial.aCondClearExecute(Sender: TObject);
begin
  SetClearCondition;
  ExecConditionQRMain;
  ShowGets;
end;

procedure TfrmCCJSO_AutoDial.aExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmCCJSO_AutoDial.aSlDateExecute(Sender: TObject);
var
  EdText         : string;
  WHeaderCaption : string;
  DVal           : TDateTime;
begin
  if Sender is TAction then begin
    Tag := (Sender as TAction).ActionComponent.Tag;
    WHeaderCaption := TButton((Sender as TAction).ActionComponent).Hint;
  end else if Sender is TEdit then begin
    Tag := (Sender as TEdit).Tag;
    WHeaderCaption := (Sender as TEdit).Hint;
  end;
  case Tag of
    10: EdText := edCndDateBegin.Text;
    11: EdText := edCndDateEnd.Text;
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
    try
      frmCCJSO_SetFieldDate.ShowModal;
      if frmCCJSO_SetFieldDate.GetOk then begin
        case Tag of
          10: edCndDateBegin.Text  := frmCCJSO_SetFieldDate.GetSDate;
          11: edCndDateEnd.Text    := frmCCJSO_SetFieldDate.GetSDate;
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

procedure TfrmCCJSO_AutoDial.aCondChangeExecute(Sender: TObject);
begin
  if ISignActive then begin
    { Отображение изображения по состоянию нажатия/отжатия кнопки отбора текущего заказа }
    if aSlCurrentOrder.Visible then
      if aSlCurrentOrder.Checked
        then aSlCurrentOrder.ImageIndex := 356
        else aSlCurrentOrder.ImageIndex := 358;
    { Сохраняем значения полей условия отбора }
    SaveConditionQRMain;
    { Формируем условие отбора }
    ExecConditionQRMain;
    ShowGets;
  end;
end;

(* Состояние условия отбора для main-раздела *)
function TfrmCCJSO_AutoDial.GetStateClearMainCondition : boolean;
var
  bResReturn : boolean;
begin
  if
     { Реквизиты заказа }
         (
          (not aSlCurrentOrder.Visible)
          or
          (
               (aSlCurrentOrder.Visible)
           and (not aSlCurrentOrder.Checked)
          )
         )
     and (length(trim(RecCondMain.BeginDate)) = 0)
     and (length(trim(RecCondMain.EndDate))   = 0)
  then bResReturn := true
  else bResReturn := false;
  result := bResReturn;
end;

procedure TfrmCCJSO_AutoDial.SaveConditionQRMain;
begin
  RecCondMain.BeginDate := edCndDateBegin.Text;
  RecCondMain.EndDate   := edCndDateEnd.Text;
end;

procedure TfrmCCJSO_AutoDial.SetClearCondition;
begin
  { Реквизиты заказа }
  if aSlCurrentOrder.Visible then aSlCurrentOrder.Checked := false;
  edCndDateBegin.Text := '';
  edCndDateEnd.Text := '';
  SaveConditionQRMain;
end;

procedure TfrmCCJSO_AutoDial.ExecConditionQRMain;
var
  RN: Integer;
begin
  if not qrMain.IsEmpty then RN := qrMain.FieldByName('NRN').AsInteger else RN := -1;
  qrMain.Active := false;
  CreateConditionQRMain;
  qrMain.Active := true;
  qrMain.Locate('NRN', RN, []);
end;

procedure TfrmCCJSO_AutoDial.CreateConditionQRMain;
begin
  qrMain.Parameters.ParamValues['@USER']         := RecSession.CurrentUser;
  if length(trim(RecCondMain.BeginDate)) = 0
    then qrMain.Parameters.ParamValues['@Begin'] := ''
    else qrMain.Parameters.ParamValues['@Begin'] := FormatDateTime('yyyy-mm-dd', StrToDateTime(RecCondMain.BeginDate,DM_CCJSO.GetDFormatSet));
  if length(trim(RecCondMain.EndDate)) = 0
    then qrMain.Parameters.ParamValues['@End'] := ''
    else qrMain.Parameters.ParamValues['@End'] := FormatDateTime('yyyy-mm-dd', StrToDateTime(RecCondMain.EndDate,DM_CCJSO.GetDFormatSet));
  if aSlCurrentOrder.Visible then begin
    if aSlCurrentOrder.Checked
      then qrMain.Parameters.ParamValues['@Order'] := Order
      else qrMain.Parameters.ParamValues['@Order'] := 0;
  end else begin
    qrMain.Parameters.ParamValues['@Order'] := 0;
  end;
  qrMain.Parameters.ParamValues['@Prefix'] := Prefix;
  qrMain.Parameters.ParamValues['@AutoDialType'] := 1;
end;

procedure TfrmCCJSO_AutoDial.aSlCurrentOrderUpdate(Sender: TObject);
begin
  if ISignActive then begin
    { Отображение изображения по состоянию нажатия/отжатия кнопки отбора текущего заказа }
    if aSlCurrentOrder.Visible then
      if aSlCurrentOrder.Checked
        then aSlCurrentOrder.ImageIndex := 356
        else aSlCurrentOrder.ImageIndex := 358;
  end;
end;

procedure TfrmCCJSO_AutoDial.GridMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
  IAutoDialResult : integer;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  if not (gdSelected in State) then begin
  end;
  if not qrMain.IsEmpty then begin
    { Вне зависимости от признака gdSelected }
    if (Column.FieldName = 'SAutoDialResult') then begin
      IAutoDialResult := db.DataSource.DataSet.FieldByName('IAutoDialResult').AsInteger;
      db.Canvas.Font.Color  := TColor(clWindowText);
      case IAutoDialResult of
        000: db.Canvas.Brush.Color := TColor($D8B0FF); { светло-красный отказ от заказа }
        001: db.Canvas.Brush.Color := TColor($CEFFCE); { светло-зеленый Подтверждение заказа }
        003: db.Canvas.Brush.Color := TColor($D3D3D3); { светло-серый Клиент не снимает трубку или отбил вызов }
        110: begin { Конфигурационный файл не обработан }
               db.Canvas.Brush.Color := TColor(clRed);
               db.Canvas.Font.Color := TColor(clWhite);
             end;
        120: begin { Сбой при проверке наличия файла }
               db.Canvas.Brush.Color := TColor(clRed);
               db.Canvas.Font.Color := TColor(clWhite);
             end;
      end;
    end;
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCCJSO_AutoDial.GridMainRefresh;
var
  RN: Integer;
begin
  if not qrMain.IsEmpty then RN := qrMain.FieldByName('NRN').AsInteger else RN := -1;
  qrMain.Requery;
  qrMain.Locate('NRN', RN, []);
end;

procedure TfrmCCJSO_AutoDial.aRefreshExecute(Sender: TObject);
begin
  GridMainRefresh;
  ShowGets;
end;

procedure TfrmCCJSO_AutoDial.GridMainDblClick(Sender: TObject);
begin
  if not qrMain.IsEmpty then begin
    aRecItem.Execute;
  end;
end;

procedure TfrmCCJSO_AutoDial.aRecItemExecute(Sender: TObject);
begin
  try
    SetRecItem;
    frmCCJSO_AutoDialEdit := TfrmCCJSO_AutoDialEdit.Create(Self);
    frmCCJSO_AutoDialEdit.SetRecItem(RecItem);
    try
      frmCCJSO_AutoDialEdit.ShowModal;
    finally
      FreeAndNil(frmCCJSO_AutoDialEdit);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

end.
