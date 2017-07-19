unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure UpdateWindowPos;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  Self.Close;
end;

procedure TForm2.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    ExStyle := ExStyle or WS_EX_APPWINDOW;
  Params.WndParent:=GetDesktopWindow;
end;


procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Screen.FormCount = 1 then
    Application.Terminate;
  Action := caFree;
end;

procedure TForm2.UpdateWindowPos;
{const
  IndentY = 100;}
var
  PWH : HWND;
  rAW     : TRect;
  TopAW   : integer;
  LeftAW  : integer;
//  ScreenY : integer;
// ScreenX : integer;
begin
  PWH := Self.Handle;
//  ScreenY := screen.WorkAreaHeight-100;
//  ScreenX := screen.WorkAreaWidth;
  TopAW := 20;
  GetWindowRect(PWH ,rAW);
  LeftAW := 30;
  if Application.Active then
    SetWindowPos(PWH, HWND_TOPMOST, LeftAW, TopAW, rAW.Right-rAW.Left, rAW.Bottom-rAW.Top, SWP_SHOWWINDOW or SWP_NOACTIVATE)
  else
    SetWindowPos(PWH, HWND_TOPMOST, LeftAW, TopAW, rAW.Right-rAW.Left, rAW.Bottom-rAW.Top, SW_MINIMIZE or SWP_NOACTIVATE)
end;


procedure TForm2.FormShow(Sender: TObject);
begin
  UpdateWindowPos;
end;

end.
