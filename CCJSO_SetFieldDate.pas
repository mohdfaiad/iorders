unit CCJSO_SetFieldDate;

{
  © PgkSoft 03.02.2016
  Журнал интернет заказов
  Установка поля даты с регистрацией
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ComCtrls, ToolWin, ExtCtrls,
  UCCenterJournalNetZkz, DB, ADODB;

type
  TfrmCCJSO_SetFieldDate = class(TForm)
    pnlControl: TPanel;
    pnlFieldDate: TPanel;
    pnlControl_Tool: TPanel;
    pnlControl_Show: TPanel;
    tbarControl: TToolBar;
    aList: TActionList;
    aSet: TAction;
    aClear: TAction;
    aExit: TAction;
    tbtnSet: TToolButton;
    tbtnClear: TToolButton;
    tbtnExit: TToolButton;
    dtDate: TDateTimePicker;
    dtTime: TDateTimePicker;
    aValueFieldChange: TAction;
    spSetPlanDateSend: TADOStoredProc;
    aCheckPeriod_OnlyDate: TAction;
    aCheckPeriod_DateTime: TAction;
    pnlPage_Period_Tool: TPanel;
    tbarCheckPeriod: TToolBar;
    tbtnCheckPeriod_OnlyDate: TToolButton;
    tbtnCheckPeriod_DateTime: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aSetExecute(Sender: TObject);
    procedure aClearExecute(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aValueFieldChangeExecute(Sender: TObject);
    procedure aCheckPeriod_OnlyDateExecute(Sender: TObject);
    procedure aCheckPeriod_DateTimeExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActivate   : integer;
    ScreenPos       : TPoint;
    UserSession     : TUserSession;
    Mode            : integer;
    TypeExec        : integer;
    SignClear       : boolean;  {  }
    bSignOK         : boolean;  { признак выполнения действия по установке даты }
    OrderHeaderItem : TJSO_OrderHeaderItem;
    SValDate        : string;
    DValDate        : TDateTime;
    FormCaption     : string;
    procedure ShowGets;
    procedure SetPlanDateSend(SDate : string; SCodeAction : string);
    function  GetSignValueFieldChange : boolean;
  public
    { Public declarations }
    procedure SetMode(Parm : integer);
    procedure SetRecHeaderItem(Parm : TJSO_OrderHeaderItem);
    procedure SetUserSession(Parm : TUserSession);
    procedure SetTypeExec(Parm : integer);
    procedure SetDateShared(DParmDate : TDateTime; SParmDate : string; SCaption : string);
    procedure SetClear(Parm : boolean);
    procedure SetScreenPos(Parm : TPoint);
    function  GetSDate : string;
    function  GetDDate : TDateTime;
    function  GetOk : boolean;
  end;

const
  { Индексы полей }
  cFieldDate_Assembling = 1;  { Дата сборки (плановая дата отправки, согласованная дата доставки) }
  cFieldDate_Shared     = 2;  { Определяем внешнее поле даты, для него всегда TypeExec = cSFDTypeExec_Return }
  { Тип исполнения }
  cSFDTypeExec_Update = 0;   { Пишем значение в источник данных }
  cSFDTypeExec_Return = 1;   { Возвращаем значения для последующего использования }

var
  frmCCJSO_SetFieldDate: TfrmCCJSO_SetFieldDate;

implementation

uses
  DateUtils, Types,
  UMain;

{$R *.dfm}

procedure TfrmCCJSO_SetFieldDate.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActivate := 0;
  Mode := 0;
  Mode := cFieldDate_Shared;
  TypeExec := cSFDTypeExec_Return;
  bSignOK := false;
  SignClear := true;
  FormCaption := '';
  ScreenPos := Point(0,0);
end;

procedure TfrmCCJSO_SetFieldDate.SetMode(Parm : integer); begin Mode := Parm; end;
procedure TfrmCCJSO_SetFieldDate.SetRecHeaderItem(Parm : TJSO_OrderHeaderItem); begin OrderHeaderItem := Parm; end;
procedure TfrmCCJSO_SetFieldDate.SetUserSession(Parm : TUserSession); begin UserSession := Parm; end;
procedure TfrmCCJSO_SetFieldDate.SetTypeExec(Parm : integer); begin TypeExec := Parm; end;
procedure TfrmCCJSO_SetFieldDate.SetDateShared(DParmDate : TDateTime; SParmDate : string; SCaption : string);
begin
  DValDate := DParmDate;
  SValDate := SParmDate;
  FormCaption := SCaption;
end;
procedure TfrmCCJSO_SetFieldDate.SetClear(Parm : boolean); begin SignClear := parm; end;
procedure TfrmCCJSO_SetFieldDate.SetScreenPos(Parm : TPoint); begin ScreenPos := Parm; end;
function  TfrmCCJSO_SetFieldDate.GetSDate : string; begin result := SValDate; end;
function  TfrmCCJSO_SetFieldDate.GetDDate : TDateTime; begin result := DValDate; end;
function  TfrmCCJSO_SetFieldDate.GetOk : boolean; begin result := bSignOk; end;

procedure TfrmCCJSO_SetFieldDate.FormActivate(Sender: TObject);
begin
  if ISignActivate = 0 then begin
    { Позиционирование формы }
    if (ScreenPos.X <> 0) or (ScreenPos.Y <> 0) then begin
      Self.Left := ScreenPos.X;
      Self.Top  := ScreenPos.Y;
    end;
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(333,self.Icon);
    { Заголовок }
    if Mode = cFieldDate_Assembling then self.Caption := 'Согласованная дата поставки с клиентом'
    else
    if Mode = cFieldDate_Shared then self.Caption := FormCaption;
    { Инициализация значения }
    if Mode = cFieldDate_Assembling then begin
      if length(trim(OrderHeaderItem.SAssemblingDate)) = 0 then begin
        dtDate.Date := Date;
        dtTime.Time := Time;
        aCheckPeriod_OnlyDate.Checked := true;
        aCheckPeriod_OnlyDate.Execute;
      end else begin
        aCheckPeriod_DateTime.Checked := true;
        dtDate.Date := OrderHeaderItem.DAssemblingDate;
        dtTime.Time := OrderHeaderItem.DAssemblingDate;
      end;
    end else if Mode = cFieldDate_Shared then begin
      if length(trim(SValDate)) = 0 then begin
        dtDate.Date := Date;
        dtTime.Time := Time;
        aCheckPeriod_OnlyDate.Checked := true;
        aCheckPeriod_OnlyDate.Execute;
      end else begin
        aCheckPeriod_DateTime.Checked := true;
        dtDate.Date := DValDate;;
        dtTime.Time := DValDate;
      end;
    end;
    { Форма активна }
    ISignActivate := 1;
    ShowGets;
    //ShowMessage(OrderHeaderItem.SAssemblingDate + chr(10) + VarToStr(OrderHeaderItem.DAssemblingDate));
  end;
end;

{ Контроль измененных значений относительно входящих }
function TfrmCCJSO_SetFieldDate.GetSignValueFieldChange : boolean;
var bResReturn : boolean;
begin
  bResReturn := false;
  if Mode = cFieldDate_Assembling then begin
    if   ( not (CompareDate(dtDate.Date,OrderHeaderItem.DAssemblingDate) = EqualsValue))
      or ( not (CompareTime(dtTime.Time,OrderHeaderItem.DAssemblingDate) = EqualsValue))
    then bResReturn := true;
  end else if Mode = cFieldDate_Shared then begin
    if   ( not (CompareDate(dtDate.Date,DValDate) = EqualsValue))
      or ( not (CompareTime(dtTime.Time,DValDate) = EqualsValue))
    then bResReturn := true;
  end;;
  result := bResReturn;
end;

procedure TfrmCCJSO_SetFieldDate.ShowGets;
begin
  if ISignActivate = 1 then begin
    { Доступ к времени }
    if aCheckPeriod_OnlyDate.Checked then begin
      dtTime.Enabled := false;
    end else
      dtTime.Enabled := true;
    begin
    end;
    { Доступ к элементам управления }
    if GetSignValueFieldChange then aSet.Enabled := true else aSet.Enabled := false;
    if SignClear then begin
      if Mode = cFieldDate_Assembling then begin
        if length(trim(OrderHeaderItem.SAssemblingDate)) = 0 then aClear.Enabled := false else aClear.Enabled := true;
      end else if Mode = cFieldDate_Shared then begin
        if length(trim(SValDate)) = 0 then aClear.Enabled := false else aClear.Enabled := true;
      end;
    end else begin
      aClear.Enabled := false;
    end;
  end;
end;

procedure TfrmCCJSO_SetFieldDate.SetPlanDateSend(SDate : string; SCodeAction : string);
var
  IErr : integer;
  SErr : string;
begin
  try
    spSetPlanDateSend.Parameters.ParamValues['@Order']       := OrderHeaderItem.orderID;
    spSetPlanDateSend.Parameters.ParamValues['@CodeAction']  := SCodeAction;
    spSetPlanDateSend.Parameters.ParamValues['@SDate']       := SDate;
    spSetPlanDateSend.Parameters.ParamValues['@USER']        := UserSession.CurrentUser;
    spSetPlanDateSend.ExecProc;
    IErr := spSetPlanDateSend.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      SErr := spSetPlanDateSend.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  except
    on e:Exception do begin
      ShowMessage(e.Message);
    end;
  end;
end;

procedure TfrmCCJSO_SetFieldDate.aSetExecute(Sender: TObject);
var
  SDate      : string;
  DFormatSet : TFormatSettings;
begin
  if TypeExec in [cSFDTypeExec_Update] then
    if  MessageDLG('Подтвердите выполнение действия',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  bSignOk := true;
  if TypeExec = cSFDTypeExec_Update then begin
    if Mode = cFieldDate_Assembling then begin
      SDate := FormatDateTime('yyyy-mm-dd', dtDate.Date) + ' ' + FormatDateTime('hh:nn:ss', dtTime.Time);
      SetPlanDateSend(SDate,'JSO_SetPlanDateSend');
    end;
  end else if TypeExec = cSFDTypeExec_Return then begin
    SValDate := FormatDateTime('dd-mm-yyyy', dtDate.Date) + ' ' + FormatDateTime('hh:nn:ss', dtTime.Time);
    DFormatSet.DateSeparator := '.';
    DFormatSet.TimeSeparator := ':';
    DFormatSet.ShortDateFormat := 'yyyy.mm.dd';
    DFormatSet.ShortTimeFormat := 'hh24:mi:ss';
    DValDate := StrToDateTime(FormatDateTime('yyyy.mm.dd', dtDate.Date) + ' ' + FormatDateTime('hh:nn:ss', dtTime.Time),DFormatSet);
  end;
  Self.Close;
end;

procedure TfrmCCJSO_SetFieldDate.aClearExecute(Sender: TObject);
begin
  if TypeExec in [cSFDTypeExec_Update] then
    if  MessageDLG('Подтвердите выполнение действия',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  bSignOk := true;
  if TypeExec = cSFDTypeExec_Update then begin
    if Mode = cFieldDate_Assembling then begin
      SetPlanDateSend('','JSO_ClearPlanDateSend');
    end;
  end else if TypeExec = cSFDTypeExec_Return then begin
    SValDate := '';
  end;
  Self.Close;
end;

procedure TfrmCCJSO_SetFieldDate.aExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmCCJSO_SetFieldDate.aValueFieldChangeExecute(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJSO_SetFieldDate.aCheckPeriod_OnlyDateExecute(Sender: TObject);
begin
  { Обнуляем время }
  dtTime.Time := EncodeTime(0, 0, 0, 0);
  ShowGets;
end;

procedure TfrmCCJSO_SetFieldDate.aCheckPeriod_DateTimeExecute(Sender: TObject);
begin
  { Инициализация }
  dtTime.Time   := Time;
  ShowGets;
end;

end.
