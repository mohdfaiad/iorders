unit CCSJO_AlertContents_Clear;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  UCCenterJournalNetZkz, ComCtrls, ActnList, ToolWin, ExtCtrls, StdCtrls,
  DB, ADODB;

type
  TfrmCCSJO_AlertContents_Clear = class(TForm)
    pnlControl: TPanel;
    pnlControl_Tool: TPanel;
    pnlControl_Show: TPanel;
    pnlParm: TPanel;
    aList: TActionList;
    tbarControl: TToolBar;
    aExec: TAction;
    aExit: TAction;
    tbtnControl_Exec: TToolButton;
    tbtnControl_Exit: TToolButton;
    lblPeriodBegin: TLabel;
    lblPeriodEnd: TLabel;
    edPeriodBegin: TEdit;
    edPeriodEnd: TEdit;
    aSlDate: TAction;
    btnPeriodBegin: TButton;
    btnPeriodEnd: TButton;
    spAlertContentsClear: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExecExecute(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aSlDateExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActivate  : integer;
    RecSession     : TUserSession;
    procedure ShowGets;
  public
    { Public declarations }
    procedure SetRecSession(Parm : TUserSession);
  end;

var
  frmCCSJO_AlertContents_Clear: TfrmCCSJO_AlertContents_Clear;

implementation

uses UMAIN, CCJSO_SetFieldDate;

{$R *.dfm}

procedure TfrmCCSJO_AlertContents_Clear.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActivate := 0;
end;

procedure TfrmCCSJO_AlertContents_Clear.FormActivate(Sender: TObject);
begin
  if  ISignActivate = 0 then begin
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(324,self.Icon);
    { Форма активна }
    ISignActivate := 1;
    ShowGets;
  end;
end;

procedure TfrmCCSJO_AlertContents_Clear.SetRecSession(Parm : TUserSession); begin RecSession := Parm; end;

procedure TfrmCCSJO_AlertContents_Clear.ShowGets;
begin
  if ISignActivate = 1 then begin
    { Доступ к элементам управления }
    if (length(edPeriodBegin.Text) > 0) or (length(edPeriodEnd.Text) > 0)
      then aExec.Enabled := true
      else aExec.Enabled := false;
  end;
end;

procedure TfrmCCSJO_AlertContents_Clear.aExecExecute(Sender: TObject);
var
  IErr       : integer;
  SErr       : string;
  DFormatSet : TFormatSettings;
  SBegin     : string;
  SEnd       : string;
begin
  if MessageDLG('Подтвердите выполнение действия.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  IErr := 0;
  SErr := '';
  DFormatSet.DateSeparator := '-';
  DFormatSet.TimeSeparator := ':';
  DFormatSet.ShortDateFormat := 'dd-mm-yyyy';
  DFormatSet.ShortTimeFormat := 'hh24:mi:ss';

  if length(edPeriodBegin.Text) > 0
    then SBegin := FormatDateTime('yyyy-mm-dd hh:nn:ss',StrToDateTime(edPeriodBegin.Text,DFormatSet))
    else SBegin := '';
  if length(edPeriodEnd.Text) > 0
    then SEnd := FormatDateTime('yyyy-mm-dd hh:nn:ss',StrToDateTime(edPeriodEnd.Text,DFormatSet))
    else SEnd := '';

  try
    spAlertContentsClear.Parameters.ParamValues['@USER']  := RecSession.CurrentUser;
    spAlertContentsClear.Parameters.ParamValues['@Begin'] := SBegin;
    spAlertContentsClear.Parameters.ParamValues['@End']   := SEnd;
    spAlertContentsClear.ExecProc;
    IErr := spAlertContentsClear.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      SErr := spAlertContentsClear.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end else aExit.Execute;
  except
    on e:Exception do begin
      SErr := e.Message;
      ShowMessage(SErr);
    end;
  end;
  
end;

procedure TfrmCCSJO_AlertContents_Clear.aExitExecute(Sender: TObject);
begin
  self.close;
end;

procedure TfrmCCSJO_AlertContents_Clear.aSlDateExecute(Sender: TObject);
var
  EdText         : string;
  DVal           : TDateTime;
  DFormatSet     : TFormatSettings;
  WHeaderCaption : string;
  Tag            : integer;
begin
  Tag := 0;
  if      Sender is TAction then Tag := (Sender as TAction).ActionComponent.Tag
  else if Sender is TEdit   then Tag := (Sender as TEdit).Tag;
  case Tag of
    10: begin EdText := edPeriodBegin.Text;  WHeaderCaption := 'Период (начало)' end;
    11: begin EdText := edPeriodEnd.Text;    WHeaderCaption := 'Период (окончание)' end;
  end;
  if length(trim(EdText)) > 0 then begin
    DFormatSet.DateSeparator := '-';
    DFormatSet.TimeSeparator := ':';
    DFormatSet.ShortDateFormat := 'dd-mm-yyyy';
    DFormatSet.ShortTimeFormat := 'hh24:mi:ss';
    DVal := StrToDateTime(EdText,DFormatSet);
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
          10: edPeriodBegin.Text := frmCCJSO_SetFieldDate.GetSDate;
          11: edPeriodEnd.Text := frmCCJSO_SetFieldDate.GetSDate;
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

end.
