unit Unit1;

interface

uses
  Windows, Messages, Classes, Controls, Forms, StdCtrls, Unit2;

type
  TMainForm = class(TForm)
    ShowForm2Button: TButton;
    ShowForm2ButtonModal: TButton;
    procedure ShowForm2ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ShowForm2ModalButtonClick(Sender: TObject);
  private
    FForm2: TForm2;
    procedure ApplicationActivate(Sender: TObject);
    procedure Form2Close(Sender: TObject; var Action: TCloseAction);
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Visible := True; //Required only for MainForm, can be set designtime
  Application.OnActivate := ApplicationActivate;
end;

procedure TMainForm.ApplicationActivate(Sender: TObject);
{ Necessary in case of any modal windows dialog or modal Form active }
var
  TopWindow: HWND;
  I: Integer;
begin
  TopWindow := 0;
  for I := 0 to Screen.FormCount - 1 do
  begin
    Screen.Forms[I].BringToFront;
    if fsModal in Screen.Forms[I].FormState then
      TopWindow := Screen.Forms[I].Handle;
  end;
  Application.RestoreTopMosts;
  if TopWindow = 0 then
    Application.BringToFront
  else
    SetForegroundWindow(TopWindow);
end;

procedure TMainForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    ExStyle := ExStyle or WS_EX_APPWINDOW;
    WndParent := GetDesktopWindow;
  end;
end;

procedure TMainForm.WMSysCommand(var Msg: TWMSysCommand);
begin
  if Msg.CmdType = SC_MINIMIZE then
    ShowWindow(Handle, SW_MINIMIZE)
  else
    inherited;
end;

{ Testing code from here }

procedure TMainForm.ShowForm2ButtonClick(Sender: TObject);
begin
  if FForm2 = nil then
  begin
    FForm2 := TForm2.Create(Application); //Or: AOwner = nil, or Self
    FForm2.OnClose := Form2Close;
  end;
  ShowWindow(FForm2.Handle, SW_RESTORE);
  FForm2.BringToFront;
end;

procedure TMainForm.Form2Close(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FForm2 := nil;
end;

procedure TMainForm.ShowForm2ModalButtonClick(Sender: TObject);
begin
  with TForm2.Create(nil) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

end.
