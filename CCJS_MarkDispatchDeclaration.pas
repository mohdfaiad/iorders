unit CCJS_MarkDispatchDeclaration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, ToolWin, StdCtrls, ActnList, DB, ADODB;

type
  TfrmCCJS_MarkDispatchDeclaration = class(TForm)
    pnlTop: TPanel;
    pnlControl: TPanel;
    pnlControl_Tool: TPanel;
    tlbarControl: TToolBar;
    tlbtnOk: TToolButton;
    tlbtnExit: TToolButton;
    pnlControl_Show: TPanel;
    pnlEdit: TPanel;
    pnlTop_Client: TPanel;
    pnlTop_Order: TPanel;
    pnlTop_Price: TPanel;
    Label1: TLabel;
    edDeclaration: TEdit;
    aMain: TActionList;
    aMain_Correct: TAction;
    aMain_Exit: TAction;
    sppCorrectionDispatchDeclaration: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aMain_CorrectExecute(Sender: TObject);
    procedure aMain_ExitExecute(Sender: TObject);
  private
    { Private declarations }
    ISIgnActivate : integer;
    Order         : integer;
  public
    { Public declarations }
  end;

var
  frmCCJS_MarkDispatchDeclaration: TfrmCCJS_MarkDispatchDeclaration;

implementation

uses UMain, Util, UCCenterJournalNetZkz;

{$R *.dfm}

procedure TfrmCCJS_MarkDispatchDeclaration.FormCreate(Sender: TObject);
var
  SCaption : string;
begin
  { Инициализация }
  ISIgnActivate := 0;
  Order := FCCenterJournalNetZkz.DBGridMain.DataSource.DataSet.FieldByName('orderID').AsInteger;
  { Отображаем реквизиты заказа }
  SCaption := 'Заказ № ' + FCCenterJournalNetZkz.DBGridMain.DataSource.DataSet.FieldByName('orderID').AsString;
  pnlTop_Order.Caption := SCaption; pnlTop_Order.Width := TextPixWidth(SCaption, pnlTop_Order.Font) + 15;
  SCaption := 'Сумма ' + FCCenterJournalNetZkz.DBGridMain.DataSource.DataSet.FieldByName('orderAmount').AsString;
  pnlTop_Price.Caption := SCaption; pnlTop_Price.Width := TextPixWidth(SCaption, pnlTop_Price.Font) + 15;
  SCaption := FCCenterJournalNetZkz.DBGridMain.DataSource.DataSet.FieldByName('orderShipName').AsString;
  pnlTop_Client.Caption := SCaption; pnlTop_Client.Width := TextPixWidth(SCaption, pnlTop_Client.Font) + 10;
end;

procedure TfrmCCJS_MarkDispatchDeclaration.FormActivate(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if ISIgnActivate = 0 then begin
    { Читаем текущее значение }
    try
      sppCorrectionDispatchDeclaration.Parameters.ParamValues['@Order'] := Order;
      sppCorrectionDispatchDeclaration.Parameters.ParamValues['@Mode']  := 0;
      sppCorrectionDispatchDeclaration.Parameters.ParamValues['@Declaration'] := '';
      sppCorrectionDispatchDeclaration.ExecProc;
      IErr := sppCorrectionDispatchDeclaration.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr = 0 then begin
        edDeclaration.Text := sppCorrectionDispatchDeclaration.Parameters.ParamValues['@Declaration_OUT'];
      end else begin
        SErr := sppCorrectionDispatchDeclaration.Parameters.ParamValues['@SErr'];
        ShowMessage('Error = ' + VarToStr(IErr) + chr(10) + SErr);
      end;
    except
      on e:Exception do
        begin
          ShowMessage('Сбой при чтении значения номера декларации. Попробуйте еще раз');
        end;
    end;
    ISIgnActivate := 1;
  end;
end;

procedure TfrmCCJS_MarkDispatchDeclaration.aMain_CorrectExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if MessageDLG('Подтвердите сохрание нового значения.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  { Пишем текущее значение }
  try
    sppCorrectionDispatchDeclaration.Parameters.ParamValues['@Order'] := Order;
    sppCorrectionDispatchDeclaration.Parameters.ParamValues['@Mode']  := 1;
    sppCorrectionDispatchDeclaration.Parameters.ParamValues['@Declaration'] := edDeclaration.Text;
    sppCorrectionDispatchDeclaration.ExecProc;
    IErr := sppCorrectionDispatchDeclaration.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      self.Close;
    end else begin
      SErr := sppCorrectionDispatchDeclaration.Parameters.ParamValues['@SErr'];
      ShowMessage('Error = ' + VarToStr(IErr) + chr(10) + SErr);
    end;
  except
    on e:Exception do
      begin
        ShowMessage('Сбой при записи значения номера декларации. Попробуйте еще раз');
      end;
  end;
end;

procedure TfrmCCJS_MarkDispatchDeclaration.aMain_ExitExecute(Sender: TObject);
begin
  Self.Close;
end;

end.
