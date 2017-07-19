unit UReferenceCreate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ToolWin, ComCtrls, StdCtrls, ExtCtrls, DB, ADODB;

type
  TfrmReferenceCreate = class(TForm)
    pnlControl: TPanel;
    pnlControl_Tool: TPanel;
    pnlControl_Show: TPanel;
    pnlField: TPanel;
    edDescr: TEdit;
    tlbarMain: TToolBar;
    aMain: TActionList;
    aInsert: TAction;
    aUpdate: TAction;
    aExit: TAction;
    tlbtnCreate: TToolButton;
    tlbtnExit: TToolButton;
    spReferenceInsert: TADOStoredProc;
    spReferenceUpdate: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aInsertExecute(Sender: TObject);
    procedure aUpdateExecute(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure edDescrChange(Sender: TObject);
  private
    { Private declarations }
    ISignActivate  : integer;
    ModeAction     : integer;
    NRN            : integer;
    ReferenceIndex : integer;
    DescUpdate     : string;
    FormCaption    : string;
    procedure ShowGets;
  public
    { Public declarations }
    procedure SetMode(Mode : integer);
    procedure SetRN(RN : integer);
    procedure SetReferenceIndex(Index : integer);
    procedure SetFormCaption(Caption : string);
    procedure SetDescUpdate(Descr : string);
  end;

var
  frmReferenceCreate: TfrmReferenceCreate;
const
  cReferenceInsert = 0; { Режим работы: Добавить }
  cReferenceUpdate = 1; { Режим работы: исправить }

implementation

uses
  UMain, UCCenterJournalNetZkz, UReference;

{$R *.dfm}

procedure TfrmReferenceCreate.ShowGets;
begin
  if ISignActivate = 1 then begin
    aInsert.Enabled := false;
    aUpdate.Enabled := false;
    if length(edDescr.Text) = 0 then begin
      if ModeAction = cReferenceInsert then aInsert.Enabled := false;
      if ModeAction = cReferenceUpdate then aUpdate.Enabled := false;
      edDescr.Color := TColor(clYellow);
    end else begin
      if ModeAction = cReferenceInsert then aInsert.Enabled := true;
      if ModeAction = cReferenceUpdate then aUpdate.Enabled := true;
      edDescr.Color := TColor(clWindow);
    end;
  end;
end;

procedure TfrmReferenceCreate.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActivate  := 0;
  ModeAction     := cReferenceInsert;
  NRN            := 0;
  ReferenceIndex := 0;
  DescUpdate     := '';
  FormCaption    := '';
end;

procedure TfrmReferenceCreate.FormActivate(Sender: TObject);
begin
  if ISignActivate = 0 then begin
    { Инициализация }
    if ModeAction = cReferenceInsert then begin
      self.Caption := FormCaption + ' (добавить)';
      tlbtnCreate.Action := aInsert;
      tlbtnCreate.Refresh;
    end else begin
      self.Caption := FormCaption + ' (исправить)';
      tlbtnCreate.Action := aUpdate;
      tlbtnCreate.Refresh;
    end;
    pnlControl_Tool.Width := tlbtnCreate.Width + tlbtnExit.Width + 2;
    edDescr.Text := DescUpdate;
    { Форма активна }
    ISignActivate := 1;
    ShowGets;
  end;
end;

procedure TfrmReferenceCreate.SetMode(Mode : integer);
begin
  ModeAction := Mode;
end;

procedure TfrmReferenceCreate.SetRN(RN : integer);
begin
  NRN := RN;
end;

procedure TfrmReferenceCreate.SetReferenceIndex(Index : integer);
begin
  ReferenceIndex := Index;
end;

procedure TfrmReferenceCreate.SetDescUpdate(Descr : string);
begin
  DescUpdate := Descr;
end;

procedure TfrmReferenceCreate.SetFormCaption(Caption : string);
begin
  FormCaption := Caption;
end;

procedure TfrmReferenceCreate.aInsertExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  try
    spReferenceInsert.Parameters.ParamValues['@RefIndex'] := ReferenceIndex;
    spReferenceInsert.Parameters.ParamValues['@Descr'] := edDescr.Text;
    spReferenceInsert.ExecProc;
    IErr := spReferenceInsert.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      self.Close;
    end else begin
      if IErr = 2601
        then SErr := 'Дублирование данных. Наименование <' + edDescr.Text + '> уже существует'
        else SErr := spReferenceUpdate.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  except
    on e:Exception do
      begin
        ShowMessage(e.Message);
      end;
  end;
end;

procedure TfrmReferenceCreate.aUpdateExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  try
    spReferenceUpdate.Parameters.ParamValues['@RefIndex'] := ReferenceIndex;
    spReferenceUpdate.Parameters.ParamValues['@Descr'] := edDescr.Text;
    spReferenceUpdate.Parameters.ParamValues['@NRN'] := NRN;
    spReferenceUpdate.ExecProc;
    IErr := spReferenceUpdate.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      self.Close;
    end else begin
      if IErr = 2601
        then SErr := 'Дублирование данных. Наименование <' + edDescr.Text + '> уже существует'
        else SErr := spReferenceUpdate.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  except
    on e:Exception do
      begin
        ShowMessage(e.Message);
      end;
  end;
end;

procedure TfrmReferenceCreate.aExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmReferenceCreate.edDescrChange(Sender: TObject);
begin
  ShowGets;
end;

end.
