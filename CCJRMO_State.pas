unit CCJRMO_State;

{**********************************
 * © PgkSoft 24.12.2015
 * Журнал заказов редких лекарста
 * Установка состояния заказа:
 * - закрытие,
 * - открытие
 **********************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, ExtCtrls, ActnList, DB, ADODB;

type
  TfrmCCJRMO_State = class(TForm)
    pnlTop: TPanel;
    pnlTop_Order: TPanel;
    pnlTop_Price: TPanel;
    pnlTop_Client: TPanel;
    pnlTool: TPanel;
    pnlTool_Bar: TPanel;
    tlbarControl: TToolBar;
    tlbtnOk: TToolButton;
    tlbtnExit: TToolButton;
    pnlTool_Show: TPanel;
    pnlState: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edFoundation: TEdit;
    btnSlFoundation: TButton;
    edOrderStatus: TEdit;
    btnSlDrivers: TButton;
    aMain: TActionList;
    aMain_Ok: TAction;
    aMain_Exit: TAction;
    aMain_SlFoundation: TAction;
    aMain_SlOrderStatus: TAction;
    spFindStatus: TADOStoredProc;
    spGetStateJRMO: TADOStoredProc;
    spJRMOSetState: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aMain_OkExecute(Sender: TObject);
    procedure aMain_ExitExecute(Sender: TObject);
    procedure aMain_SlFoundationExecute(Sender: TObject);
    procedure aMain_SlOrderStatusExecute(Sender: TObject);
    procedure edFoundationChange(Sender: TObject);
    procedure edOrderStatusChange(Sender: TObject);
  private
    { Private declarations }
    { Private declarations }
    ISignActive              : integer;
    Mode                     : integer;
    ISignAllowTheActionOrder : smallint;
    NRN                      : integer; { Номер заказа }
    NUSER                    : integer;
    OrderPrice               : real;
    OrderClient              : string;
    CodeAction               : string;
    procedure ShowGets;
    procedure CheckStateOrder;
  public
    { Public declarations }
    procedure SetMode(Parm : integer);
    procedure SetRN(Parm : integer);
    procedure SetPrice(Parm : real);
    procedure SetClient(Parm : string);
    procedure SetUser(Parm : integer);
  end;

var
  frmCCJRMO_State: TfrmCCJRMO_State;
const
  cJRMOStateOpen  = 1; { Открытие заказа }
  cJRMOStateClose = 2; { Закрытие заказа }

implementation

uses
  Util,
  UMain, UCCenterJournalNetZkz, UReference;

{$R *.dfm}

procedure TfrmCCJRMO_State.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
  Mode := 0;
  ISignAllowTheActionOrder := 1;
  NRN := 0;
  NUSER := 0;
  OrderPrice := 0;
  OrderClient := '';
  CodeAction := '';
end;

procedure TfrmCCJRMO_State.FormActivate(Sender: TObject);
var
  SCaption   : string;
begin
  if ISignActive = 0 then begin
    { Инициализация }
    case Mode of
      cJRMOStateOpen: begin
        CodeAction := 'JRMO_Open';
        self.Caption := 'Открытие заказа';
        FCCenterJournalNetZkz.imgMain.GetIcon(133,self.Icon)
      end;
      cJRMOStateClose: begin
        CodeAction := 'JRMO_Close';
        self.Caption := 'Закрытие заказа';
        FCCenterJournalNetZkz.imgMain.GetIcon(134,self.Icon)
      end;
    else begin
           ShowMessage('Незарегистрированный режим работы');
           self.Close;
         end;
    end;
    { Отображаем реквизиты заказа }
    SCaption := 'Заказ № ' + VarToStr(NRN);
    pnlTop_Order.Caption := SCaption; pnlTop_Order.Width := TextPixWidth(SCaption, pnlTop_Order.Font) + 20;
    SCaption := 'Сумма ' + VarToStr(OrderPrice);
    pnlTop_Price.Caption := SCaption; pnlTop_Price.Width := TextPixWidth(SCaption, pnlTop_Price.Font) + 20;
    SCaption := OrderClient;
    pnlTop_Client.Caption := SCaption; pnlTop_Client.Width := TextPixWidth(SCaption, pnlTop_Client.Font) + 10;
    { Форма активна }
    ISignActive := 1;
    { Контроль для многопользовательского режима }
    CheckStateOrder;
    { Актуализация состояния элементов управления }
    ShowGets;
  end;
end;

procedure TfrmCCJRMO_State.ShowGets;
begin
  if ISignActive = 1 then begin
    { Доступ к элементам управления }
    if (length(edFoundation.Text) = 0)
       or
       (
        (Mode = cJRMOStateClose) and
        (length(edOrderStatus.Text) = 0)
       )
    then begin
      aMain_Ok.Enabled := false;
    end else begin
      aMain_Ok.Enabled := true;
    end;
    { Обязательные поля для ввода }
    if (length(edFoundation.Text) = 0) then edFoundation.Color := TColor(clYellow) else edFoundation.Color := TColor(clWindow);
    if (Mode = cJRMOStateClose) and (length(edOrderStatus.Text) = 0)
      then edOrderStatus.Color := TColor(clYellow)
      else edOrderStatus.Color := TColor(clWindow);
  end;
end;

procedure TfrmCCJRMO_State.SetMode(Parm : integer); begin Mode := Parm; end;
procedure TfrmCCJRMO_State.SetRN(Parm : integer); begin NRN := Parm; end;
procedure TfrmCCJRMO_State.SetPrice(Parm : real); begin OrderPrice := Parm; end;
procedure TfrmCCJRMO_State.SetClient(Parm : string); begin OrderClient := Parm; end;
procedure TfrmCCJRMO_State.SetUser(Parm : integer); begin NUSER := Parm; end;

procedure TfrmCCJRMO_State.CheckStateOrder;
var
  IErr       : integer;
  SErr       : string;
  SCloseDate : string;
begin
  if (Mode = cJRMOStateClose) or (Mode = cJRMOStateOpen) then begin
    ISignAllowTheActionOrder := 1;
    spGetStateJRMO.Parameters.ParamValues['@Order'] := NRN;
    spGetStateJRMO.ExecProc;
    IErr := spGetStateJRMO.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      SErr := spGetStateJRMO.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
      ISignAllowTheActionOrder := 0;
      self.Close;
    end else begin
      SCloseDate := spGetStateJRMO.Parameters.ParamValues['@SCloseDate'];
      if (Mode = cJRMOStateClose) and (length(SCloseDate) <> 0) then begin
        ShowMessage('Заказ уже находится в состоянии <Закрыт>');
        ISignAllowTheActionOrder := 0;
        self.Close;
      end else
      if (Mode = cJRMOStateOpen) and (length(SCloseDate) = 0) then begin
        ShowMessage('Заказ уже находится в состоянии <Открыт>');
        ISignAllowTheActionOrder := 0;
        self.Close;
      end;
    end;
  end;
end;

procedure TfrmCCJRMO_State.aMain_OkExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  { Контроль для многопользовательского режима }
  CheckStateOrder;
  if ISignAllowTheActionOrder = 1 then begin
    if MessageDLG('Подтвердите выполнение действия',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
    try
      spJRMOSetState.Parameters.ParamValues['@Order'] := NRN;
      spJRMOSetState.Parameters.ParamValues['@CodeAction'] := CodeAction;
      spJRMOSetState.Parameters.ParamValues['@USER'] := NUSER;
      spJRMOSetState.Parameters.ParamValues['@Foundation'] := edFoundation.Text;
      spJRMOSetState.Parameters.ParamValues['@StatusName'] := edOrderStatus.Text;
      spJRMOSetState.ExecProc;
      IErr := spJRMOSetState.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr <> 0 then begin
        SErr := spJRMOSetState.Parameters.ParamValues['@SErr'];
        ShowMessage(SErr);
      end else begin
        self.Close;
      end;
    except
      on e:Exception do begin
        ShowMessage(e.Message);
     end;
    end;
  end;
end;

procedure TfrmCCJRMO_State.aMain_ExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJRMO_State.aMain_SlFoundationExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFReferenceActionFoundation);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if length(DescrSelect) > 0 then edFoundation.Text := DescrSelect;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJRMO_State.aMain_SlOrderStatusExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFReferenceOrderStatus);
   frmReference.SetReadOnly(cFReferenceNoReadOnly);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if length(DescrSelect) > 0 then edOrderStatus.Text := DescrSelect;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJRMO_State.edFoundationChange(Sender: TObject);
var
  RnStatus : integer;
  IErr     : integer;
  SErr     : string;
begin
  { Поиск аналогичного наименования статуса заказа }
  RnStatus := 0;
  IErr     := 0;
  SErr     := '';
  if length(trim(edFoundation.text)) <> 0 then begin
    try
      spFindStatus.Parameters.ParamValues['@Descr'] := edFoundation.Text;
      spFindStatus.ExecProc;
      IErr := spFindStatus.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr = 0 then begin
        RnStatus := spFindStatus.Parameters.ParamValues['@NRN_OUT'];
      end else begin
        SErr := spFindStatus.Parameters.ParamValues['@SErr'];
        ShowMessage(SErr);
      end;
    except
      on e:Exception do begin
        ShowMessage(e.Message);
      end;
    end;
  end;
  if RnStatus <> 0 then edOrderStatus.Text := edFoundation.Text;
  ShowGets;
end;

procedure TfrmCCJRMO_State.edOrderStatusChange(Sender: TObject);
begin
  ShowGets;
end;

end.
