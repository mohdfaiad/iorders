unit CCJS_MarkNote;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, DB, ADODB, ActnList, ExtCtrls, StdCtrls;

type
  TfrmCCJS_MarkNote = class(TForm)
    pnlTop: TPanel;
    pnlTop_Client: TPanel;
    pnlTop_Order: TPanel;
    pnlTop_Price: TPanel;
    aMain: TActionList;
    aMain_Correct: TAction;
    aMain_Exit: TAction;
    sppCorrectionNote: TADOStoredProc;
    pnlControl: TPanel;
    pnlControl_Tool: TPanel;
    tlbarControl: TToolBar;
    tlbtnOk: TToolButton;
    tlbtnExit: TToolButton;
    pnlControl_Show: TPanel;
    pnlEdit: TPanel;
    mNote: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aMain_CorrectExecute(Sender: TObject);
    procedure aMain_ExitExecute(Sender: TObject);
    procedure mNoteChange(Sender: TObject);
  private
    { Private declarations }
    ISIgnActivate : integer;
    Order         : integer;
    procedure ShowGets;
  public
    { Public declarations }
  end;

var
  frmCCJS_MarkNote: TfrmCCJS_MarkNote;

implementation

uses UMain, Util, UCCenterJournalNetZkz;

{$R *.dfm}

procedure TfrmCCJS_MarkNote.FormCreate(Sender: TObject);
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

procedure TfrmCCJS_MarkNote.FormActivate(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if ISIgnActivate = 0 then begin
    { Читаем текущее значение }
    try
      sppCorrectionNote.Parameters.ParamValues['@Order'] := Order;
      sppCorrectionNote.Parameters.ParamValues['@Mode']  := 0;
      sppCorrectionNote.Parameters.ParamValues['@Note'] := '';
      sppCorrectionNote.ExecProc;
      IErr := sppCorrectionNote.Parameters.ParamValues['@RETURN_VALUE'];
      if IErr = 0 then begin
        mNote.Text := sppCorrectionNote.Parameters.ParamValues['@Note_OUT'];
      end else begin
        SErr := sppCorrectionNote.Parameters.ParamValues['@SErr'];
        ShowMessage('Error = ' + VarToStr(IErr) + chr(10) + SErr);
      end;
    except
      on e:Exception do
        begin
          ShowMessage('Сбой при чтении примечания. Попробуйте еще раз');
        end;
    end;
    ISIgnActivate := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJS_MarkNote.aMain_CorrectExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if MessageDLG('Подтвердите сохрание примечания.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  { Пишем текущее значение }
  try
    sppCorrectionNote.Parameters.ParamValues['@Order'] := Order;
    sppCorrectionNote.Parameters.ParamValues['@Mode']  := 1;
    sppCorrectionNote.Parameters.ParamValues['@Note']  := mNote.Text;
    sppCorrectionNote.ExecProc;
    IErr := sppCorrectionNote.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      self.Close;
    end else begin
      SErr := sppCorrectionNote.Parameters.ParamValues['@SErr'];
      ShowMessage('Error = ' + VarToStr(IErr) + chr(10) + SErr);
    end;
  except
    on e:Exception do
      begin
        ShowMessage('Сбой при записи примечания. Попробуйте еще раз');
      end;
  end;
end;

procedure TfrmCCJS_MarkNote.aMain_ExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmCCJS_MarkNote.mNoteChange(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmCCJS_MarkNote.ShowGets;
begin
  if ISIgnActivate = 1 then begin
    pnlControl_Show.Caption := VarToStr(length(mNote.Text));
  end;
end;

end.
