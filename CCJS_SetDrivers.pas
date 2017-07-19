unit CCJS_SetDrivers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, ExtCtrls, ActnList, DB, ADODB;

type
  TfrmCCJS_SetDrivers = class(TForm)
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
    pnlDrivers: TPanel;
    Label1: TLabel;
    edDrivers: TEdit;
    btnSlDrivers: TButton;
    aMain: TActionList;
    aMain_Ok: TAction;
    aMain_Exit: TAction;
    aMain_SlDrivers: TAction;
    spSetOrderDriver: TADOStoredProc;
    spJBOSetDriver: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aMain_OkExecute(Sender: TObject);
    procedure aMain_ExitExecute(Sender: TObject);
    procedure aMain_SlDriversExecute(Sender: TObject);
    procedure edDriversChange(Sender: TObject);
  private
    { Private declarations }
    ISignActive : integer;
    CodeAction  : string;
    NRN         : integer; { Номер интернет-заказа или звонка}
    NUSER       : integer;
    OrderPrice  : real;
    OrderClient : string;
    procedure ShowGets;
  public
    { Public declarations }
    procedure SetCodeAction(Action : string);
    procedure SetRN(RN : integer);
    procedure SetPrice(Price : real);
    procedure SetClient(Client : string);
    procedure SetUser(IDUSER : integer);
  end;

var
  frmCCJS_SetDrivers: TfrmCCJS_SetDrivers;

implementation

uses
  Util,
  UMain, UCCenterJournalNetZkz, UReference;

{$R *.dfm}

procedure TfrmCCJS_SetDrivers.ShowGets;
begin
  if ISignActive = 1 then begin
    { Контроль на пустую строку }
    if length(edDrivers.Text) = 0 then begin
      aMain_Ok.Enabled := false;
      edDrivers.Color := TColor(clYellow);
    end else begin
      aMain_Ok.Enabled := true;
      edDrivers.Color := TColor(clWindow);
    end;
  end;
end;

procedure TfrmCCJS_SetDrivers.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
  NRN := 0;
end;

procedure TfrmCCJS_SetDrivers.FormActivate(Sender: TObject);
var
  SCaption : string;
begin
  if ISignActive = 0 then begin
    { Иконка окна }
    FCCenterJournalNetZkz.imgMain.GetIcon(178,self.Icon);
    { Отображаем реквизиты заказа }
    SCaption := 'Заказ № ' + VarToStr(NRN);
    pnlTop_Order.Caption := SCaption; pnlTop_Order.Width := TextPixWidth(SCaption, pnlTop_Order.Font) + 20;
    SCaption := 'Сумма ' + VarToStr(OrderPrice);
    pnlTop_Price.Caption := SCaption; pnlTop_Price.Width := TextPixWidth(SCaption, pnlTop_Price.Font) + 20;
    SCaption := OrderClient;
    pnlTop_Client.Caption := SCaption; pnlTop_Client.Width := TextPixWidth(SCaption, pnlTop_Client.Font) + 10;
    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJS_SetDrivers.SetCodeAction(Action : string);
begin
  CodeAction := Action;
end;

procedure TfrmCCJS_SetDrivers.SetRN(RN : integer);
begin
  NRN := RN;
end;

procedure TfrmCCJS_SetDrivers.SetPrice(Price : real);
begin
  OrderPrice := Price;
end;

procedure TfrmCCJS_SetDrivers.SetClient(Client : string);
begin
  OrderClient := Client;
end;

procedure TfrmCCJS_SetDrivers.SetUser(IDUSER : integer);
begin
  NUSER := IDUSER;
end;

procedure TfrmCCJS_SetDrivers.aMain_OkExecute(Sender: TObject);
var
  IErr            : integer;
  SErr            : string;
  SignExistAction : integer;
begin
  if (CodeAction = 'SetOrderDrivers') or (CodeAction = 'SetBellDrivers') then begin
    if MessageDLG('Подтвердите выполнение действия',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
    { Повторная проверка на наличие операции в истории }
    IErr := 0;
    SErr := '';
    FCCenterJournalNetZkz.ExistAction(IErr, SErr);
    SignExistAction := 1;
    if IErr = 0 then begin
      SignExistAction := 0;
    end else begin
      if IErr = -7 then begin
        SignExistAction := 1;
        if MessageDLG(SErr,mtConfirmation,[mbYes,mbNo],0) = mrYes then SignExistAction := 0;
      end else begin
        SignExistAction := 1;
        ShowMessage(SErr);
      end;
    end;
    if SignExistAction = 0 then begin
      if CodeAction = 'SetOrderDrivers' then begin
        try
          spSetOrderDriver.Parameters.ParamValues['@Order'] := NRN;
          spSetOrderDriver.Parameters.ParamValues['@CodeAction'] := CodeAction;
          spSetOrderDriver.Parameters.ParamValues['@USER'] := NUSER;
          spSetOrderDriver.Parameters.ParamValues['@Driver'] := edDrivers.Text;
          spSetOrderDriver.ExecProc;
          IErr := spSetOrderDriver.Parameters.ParamValues['@RETURN_VALUE'];
          if IErr <> 0 then begin
            SErr := spSetOrderDriver.Parameters.ParamValues['@SErr'];
            ShowMessage(SErr);
          end else self.Close;
        except
          on e:Exception do begin
            ShowMessage(e.Message);
          end;
        end;
      end
      else if CodeAction = 'SetBellDrivers' then begin
      end;
    end;
  end
  else if CodeAction = 'SetOldBellDrivers' then begin
    try
      spJBOSetDriver.Parameters.ParamValues['@Bell'] := NRN;
      spJBOSetDriver.Parameters.ParamValues['@CodeAction'] := CodeAction;
      spJBOSetDriver.Parameters.ParamValues['@USER'] := NUSER;
      spJBOSetDriver.Parameters.ParamValues['@Driver'] := edDrivers.Text;
      spJBOSetDriver.ExecProc;
      IErr := spJBOSetDriver.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr <> 0 then begin
        SErr := spJBOSetDriver.Parameters.ParamValues['@SErr'];
        ShowMessage(SErr);
      end else self.Close;
    except
      on e:Exception do begin
        ShowMessage(e.Message);
      end;
    end;
  end else begin
    ShowMessage('Попытка обработки незарегистрированного кода операции.' + chr(10) +
                'CodeAction = ' + CodeAction
               );
  end;
end;

procedure TfrmCCJS_SetDrivers.aMain_ExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmCCJS_SetDrivers.aMain_SlDriversExecute(Sender: TObject);
var
  DescrSelect : string;
begin
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFReferenceDrivers);
   frmReference.SetReadOnly(cFReferenceYesReadOnly);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    if length(DescrSelect) > 0 then edDrivers.Text := DescrSelect;
   finally
    frmReference.Free;
   end;
  except
  end;
end;

procedure TfrmCCJS_SetDrivers.edDriversChange(Sender: TObject);
begin
  ShowGets;
end;

end.
