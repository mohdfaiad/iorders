unit CCJS_Pay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ExtCtrls, ComCtrls, ToolWin, StdCtrls, DB, ADODB,
  UCCenterJournalNetZkz, Buttons;

type
  TfrmCCJS_Pay = class(TForm)
    pnlTool: TPanel;
    pnlFields: TPanel;
    pnlTool_Control: TPanel;
    pnlTool_Show: TPanel;
    aMain: TActionList;
    aMain_Add: TAction;
    AMain_Upd: TAction;
    aMain_Exit: TAction;
    tlbrControl: TToolBar;
    tlbtnControl_OK: TToolButton;
    tlbtnControl_Exit: TToolButton;
    spPayInsert: TADOStoredProc;
    lblDocDate: TLabel;
    lblNumber: TLabel;
    lblSum: TLabel;
    lblNote: TLabel;
    edNumber: TEdit;
    edSum: TEdit;
    edNote: TEdit;
    spPayExist: TADOStoredProc;
    spPayUpdate: TADOStoredProc;
    spGenNumb: TADOStoredProc;
    aSetDocDate: TAction;
    edDocDate: TEdit;
    lblBarCode: TLabel;
    edBarCode: TEdit;
    btnSetDocDate: TButton;
    aSetRedeliveryDate: TAction;
    lblRedeliveryDate: TLabel;
    edRedeliveryDate: TEdit;
    btnSetRedeliveryDate: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aMain_AddExecute(Sender: TObject);
    procedure AMain_UpdExecute(Sender: TObject);
    procedure aMain_ExitExecute(Sender: TObject);
    procedure edNumberChange(Sender: TObject);
    procedure edSumChange(Sender: TObject);
    procedure edDateChange(Sender: TObject);
    procedure edNoteChange(Sender: TObject);
    procedure aSetDocDateExecute(Sender: TObject);
    procedure edBarCodeChange(Sender: TObject);
    procedure edDocDateChange(Sender: TObject);
    procedure aSetRedeliveryDateExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActive   : integer;
    Mode          : integer;
    CodeAction    : string;
    Order         : integer;
    NUSER         : integer;
    NHistory      : integer;
    RecPayOld     : TJSO_Pay;
    RecPayNew     : TJSO_Pay;
    RecSession    : TUserSession;
    SignFindPay   : smallint;
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
    procedure SetRecPay(Parm : TJSO_Pay);
    procedure SetRecSession(Parm : TUserSession);
  end;


const
  cFJSOPayModeAdd  = 0; { Режим работы: Добавление }
  cFJSOPayModeUpd  = 1; { Режим работы: Исправление }

var
  frmCCJS_Pay: TfrmCCJS_Pay;

implementation

uses
  Util,
  UMAIN, ExDBGRID, DateUtils, UReference, CCJSO_SetFieldDate;

const
  sMsgSumTypeCurr = 'Сумма платежа имеет числовой формат';
  sMsgNotFindPay  = 'Платеж не найден';

{$R *.dfm}

procedure TfrmCCJS_Pay.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
  Mode  := cFJSOPayModeAdd;
  edNumber.Text := '';
  edSum.Text := '';
  edNote.Text := '';
  SignFindPay := -1;
end;

procedure TfrmCCJS_Pay.FormActivate(Sender: TObject);
begin
  if ISignActive = 0 then begin
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(270,self.Icon);
    { Наименование формы и управление}
    if Mode = cFJSOPayModeAdd then begin

      RecPayOld.SDocDate := ''; { инициализация }
      RecPayNew := RecPayOld;
      self.Caption := 'Платежи (добавить)';
      tlbtnControl_OK.Action := aMain_Add;
      { Текущая дата }
      RecPayNew.DocDate  := date;
      RecPayNew.SDocDate := FormatDateTime('dd-mm-yyyy hh:nn:ss', RecPayNew.DocDate);
      edDocDate.Text := RecPayNew.SDocDate;
      { Генерим номер }
      spGenNumb.ExecProc;
      edNumber.Text := spGenNumb.Parameters.ParamValues['@Numb'];

    end else if Mode = cFJSOPayModeUpd then begin

      self.Caption := 'Платежи (исправить)';
      tlbtnControl_OK.Action := AMain_Upd;
      { Проверка наличия платежа }
      spPayExist.Parameters.ParamValues['@RN'] := RecPayOld.RN;
      spPayExist.ExecProc;
      if spPayExist.Parameters.ParamValues['@RETURN_VALUE'] = 0 then begin
        SetFields(false);
        SignFindPay := 0;
        ShowMessage(sMsgNotFindPay);
        pnlTool_Show.Caption := sMsgNotFindPay;
        aMain_Add.Enabled := false;
        AMain_Upd.Enabled := false;
      end else begin
        SignFindPay := 1;
        { Заполняем поля }
        edDocDate.Text        := RecPayOld.SDocDate;
        edNumber.Text         := RecPayOld.DocNumb;
        edSum.Text            := CurrencyToStr(RecPayOld.DocSumPay);
        edNote.Text           := RecPayOld.DocNote;
        edBarCode.Text        := RecPayOld.BarCode;
        edRedeliveryDate.Text := RecPayOld.SRedeliveryDate;
      end;
      RecPayNew := RecPayOld;

    end;

    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJS_Pay.SetControlOK(SignEnabled : boolean);
begin
  if Mode = cFJSOPayModeAdd then begin
    aMain_Add.Enabled := SignEnabled;
    AMain_Upd.Enabled := false;
  end else if Mode = cFJSOPayModeUpd then begin
    aMain_Add.Enabled := false;
    AMain_Upd.Enabled := SignEnabled;
  end;
end;

procedure TfrmCCJS_Pay.SetFields(SignEnabled : boolean);
begin
  btnSetDocDate.Enabled := SignEnabled;
  edNumber.Enabled      := SignEnabled;
  edSum.Enabled         := SignEnabled;
  edBarCode.Enabled     := SignEnabled;
  edNote.Enabled        := SignEnabled;
end;

procedure TfrmCCJS_Pay.ShowGets;
begin
  if ISignActive = 1 then begin
    { Контроль на пустые строки }
    if length(trim(edNumber.Text)) = 0 then begin
      edNumber.Color := TColor(clYellow);
    end else begin
      edNumber.Color := TColor(clWindow);
    end;
    if length(trim(edDocDate.Text)) = 0 then begin
      edDocDate.Color := TColor(clYellow);
    end else begin
      edDocDate.Color := TColor(clWindow);
    end;
    if length(trim(edSum.Text)) = 0 then begin
      edSum.Color := TColor(clYellow);
    end else begin
      edSum.Color := TColor(clWindow);
    end;
    if length(trim(edBarCode.Text)) = 0 then begin
      edBarCode.Color := TColor(clYellow);
    end else begin
      edBarCode.Color := TColor(clWindow);
    end;
    { Доступ к элементам управления }
    if   (length(trim(edDocDate.Text)) = 0)
      or (length(trim(edNumber.Text)) = 0)
      or (
          (length(trim(edSum.Text)) = 0)
          or
          (
           (length(trim(edSum.Text)) <> 0)
           and
           (not ufoTryStrToCurr(edSum.Text))
          )
         )
      or (length(trim(edBarCode.Text)) = 0)
      or (
          (Mode = cFJSOPayModeUpd)
          and
          (
           (SignFindPay = 0)
           or
           (
            (edDocDate.Text = RecPayOld.SDocDate)
            and
            (edRedeliveryDate.Text = RecPayOld.SRedeliveryDate)
            and
            (edNumber.Text = RecPayOld.DocNumb)
            and
            (edSum.Text = CurrencyToStr(RecPayOld.DocSumPay))
            and
            (edBarCode.Text = RecPayOld.BarCode)
            and
            (edNote.Text = RecPayOld.DocNote)
           )
          )
         )
    then SetControlOK(false)
    else SetControlOK(true);
  end;
end;

procedure TfrmCCJS_Pay.SetMode(Parm : integer); begin Mode := Parm; end;
procedure TfrmCCJS_Pay.SetAction(Parm : string); begin CodeAction := Parm; end;
procedure TfrmCCJS_Pay.SetOrder(Parm : integer); begin Order := Parm; end;
procedure TfrmCCJS_Pay.SetUSER(Parm : integer); begin NUSER := Parm; end;
procedure TfrmCCJS_Pay.SetNHistory(Parm : integer); begin NHistory := Parm; end;
procedure TfrmCCJS_Pay.SetRecPay(Parm : TJSO_Pay); begin RecPayOld := Parm; end;
procedure TfrmCCJS_Pay.SetRecSession(Parm : TUserSession); begin RecSession := Parm; end;

procedure TfrmCCJS_Pay.aMain_AddExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  if Mode = cFJSOPayModeAdd then begin
    try
      spPayInsert.Parameters.ParamValues['@ActionCode']      := CodeAction;
      spPayInsert.Parameters.ParamValues['@USER']            := NUSER;
      spPayInsert.Parameters.ParamValues['@NHistory']        := NHistory;
      spPayInsert.Parameters.ParamValues['@Order']           := Order;
      spPayInsert.Parameters.ParamValues['@DocNumb']         := edNumber.Text;
      spPayInsert.Parameters.ParamValues['@DocSumPay']       := StrToCurr(edSum.Text);
      spPayInsert.Parameters.ParamValues['@SDocDate']        := FormatDateTime('yyyy-mm-dd hh:nn:ss',RecPayNew.DocDate);
      spPayInsert.Parameters.ParamValues['@DocNote']         := edNote.Text;
      spPayInsert.Parameters.ParamValues['@SCreateDate']     := FormatDateTime('yyyy-mm-dd hh:nn:ss', now);
      spPayInsert.Parameters.ParamValues['@BarCode']         := edBarCode.Text;
      if length(RecPayNew.SRedeliveryDate) = 0
        then spPayInsert.Parameters.ParamValues['@SRedeliveryDate'] := ''
        else spPayInsert.Parameters.ParamValues['@SRedeliveryDate'] := FormatDateTime('yyyy-mm-dd hh:nn:ss',RecPayNew.DRedeliveryDate);
      spPayInsert.ExecProc;
      IErr := spPayInsert.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr <> 0 then begin
        SErr := spPayInsert.Parameters.ParamValues['@SErr'];
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

procedure TfrmCCJS_Pay.AMain_UpdExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  if Mode = cFJSOPayModeUpd then begin
    try
      spPayUpdate.Parameters.ParamValues['@ActionCode']  := CodeAction;
      spPayUpdate.Parameters.ParamValues['@USER']        := NUSER;
      spPayUpdate.Parameters.ParamValues['@NHistory']    := NHistory;
      spPayUpdate.Parameters.ParamValues['@NRN']         := RecPayOld.RN;
      spPayUpdate.Parameters.ParamValues['@Order']       := Order;
      spPayUpdate.Parameters.ParamValues['@DocNumb']     := edNumber.Text;
      spPayUpdate.Parameters.ParamValues['@DocSumPay']   := StrToCurr(edSum.Text);
      spPayUpdate.Parameters.ParamValues['@SDocDate']    := FormatDateTime('yyyy-mm-dd',RecPayNew.DocDate);
      spPayUpdate.Parameters.ParamValues['@DocNote']     := edNote.Text;
      spPayUpdate.Parameters.ParamValues['@SCreateDate'] := FormatDateTime('yyyy-mm-dd hh:nn:ss', now);
      spPayUpdate.Parameters.ParamValues['@BarCode']     := edBarCode.Text;
      if length(edRedeliveryDate.Text) = 0
        then spPayUpdate.Parameters.ParamValues['@SRedeliveryDate'] := ''
        else spPayUpdate.Parameters.ParamValues['@SRedeliveryDate'] := FormatDateTime('yyyy-mm-dd hh:nn:ss',RecPayNew.DRedeliveryDate);
      spPayUpdate.ExecProc;
      IErr := spPayUpdate.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr <> 0 then begin
        SErr := spPayUpdate.Parameters.ParamValues['@SErr'];
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

procedure TfrmCCJS_Pay.aMain_ExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJS_Pay.edNumberChange(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJS_Pay.edSumChange(Sender: TObject);
begin
  if not ufoTryStrToCurr(edSum.Text) then ShowMessage(sMsgSumTypeCurr);
  ShowGets;
end;

procedure TfrmCCJS_Pay.edDateChange(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJS_Pay.edNoteChange(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJS_Pay.aSetDocDateExecute(Sender: TObject);
begin
  try
    frmCCJSO_SetFieldDate := TfrmCCJSO_SetFieldDate.Create(Self);
    frmCCJSO_SetFieldDate.SetMode(cFieldDate_Shared);
    frmCCJSO_SetFieldDate.SetUserSession(RecSession);
    frmCCJSO_SetFieldDate.SetTypeExec(cSFDTypeExec_Return);
    frmCCJSO_SetFieldDate.SetDateShared(RecPayNew.DocDate,RecPayNew.SDocDate,'Дата платежа');
    try
      frmCCJSO_SetFieldDate.ShowModal;
      if frmCCJSO_SetFieldDate.GetOk then begin
        RecPayNew.SDocDate := frmCCJSO_SetFieldDate.GetSDate;
        RecPayNew.DocDate  := frmCCJSO_SetFieldDate.GetDDate;
        edDocDate.Text := RecPayNew.SDocDate;
        ShowGets;
      end;
    finally
      FreeAndNil(frmCCJSO_SetFieldDate);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TfrmCCJS_Pay.edBarCodeChange(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJS_Pay.edDocDateChange(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJS_Pay.aSetRedeliveryDateExecute(Sender: TObject);
begin
  try
    frmCCJSO_SetFieldDate := TfrmCCJSO_SetFieldDate.Create(Self);
    frmCCJSO_SetFieldDate.SetMode(cFieldDate_Shared);
    frmCCJSO_SetFieldDate.SetUserSession(RecSession);
    frmCCJSO_SetFieldDate.SetTypeExec(cSFDTypeExec_Return);
    frmCCJSO_SetFieldDate.SetDateShared(RecPayNew.DRedeliveryDate,RecPayNew.SRedeliveryDate,'Дата получения');
    try
      frmCCJSO_SetFieldDate.ShowModal;
      if frmCCJSO_SetFieldDate.GetOk then begin
        RecPayNew.SRedeliveryDate := frmCCJSO_SetFieldDate.GetSDate;
        RecPayNew.DRedeliveryDate  := frmCCJSO_SetFieldDate.GetDDate;
        edRedeliveryDate.Text := RecPayNew.SRedeliveryDate;
        ShowGets;
      end;
    finally
      FreeAndNil(frmCCJSO_SetFieldDate);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

end.
