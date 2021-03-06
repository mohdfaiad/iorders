unit ufmCommonAlert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uAlertCore, ActnList, ExtCtrls, DB, ADODB, StdCtrls, Buttons,
  ufrmAlert, ufrmCallClientAlert;

const
  WM_CloseWAlert = WM_USER + 102;

type
  TfmCommonAlert = class(TForm)
    tmrCloseAW: TTimer;
    PanelFrame: TPanel;
    trmMinimize: TTimer;
    procedure tmrCloseAWTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure trmMinimizeTimer(Sender: TObject);
    //procedure FormCreate(Sender: TObject);
  private
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;  
  protected
    { Private declarations }
    FAlertManager: TAlertManager;
    FOptions : TAlertPopupWindowOptions;
    FAutoAccept: Boolean;
    FImgList: TImageList;
    FFrame: TfrmAlert;
    FUserId: Integer;
    FConnection: TADOConnection;
    FFrameClass: TfrmAlertClass;
    procedure Initialize;
    procedure CloseForm;
    procedure OnAccept(Sender: TObject);
    procedure SetAutoClose(Value: Boolean);
    procedure ControlDataChange(Sender: TObject);
    procedure InnerInitialize; virtual;
    procedure UpdateWindowPos;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    procedure wmCloseWAlert(var msg:TMessage); message WM_CloseWAlert;
    {constructor Create(POptions : PAlertPopupWindowOptions;
      AlertManager: TAlertPopupWindowControl; AConnection: TADOConnection;
      AImgList: TImageList; frmAlertClass: TfrmAlertClass; UserId: Integer);}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    class procedure Execute(POptions : PAlertPopupWindowOptions;
      AConnection: TADOConnection;
      AImgList: TImageList; frmAlertClass: TfrmAlertClass; UserId: Integer; AlertManager: TAlertManager);
  end;

var
  fmCommonAlert: TfmCommonAlert;

implementation

{$R *.dfm}

procedure TfmCommonAlert.InnerInitialize;
begin
  //Empty
end;

procedure TfmCommonAlert.wmCloseWAlert(var msg:TMessage);
begin
  destroy;
end;

class procedure TfmCommonAlert.Execute(POptions : PAlertPopupWindowOptions;
  AConnection: TADOConnection;
  AImgList: TImageList; frmAlertClass: TfrmAlertClass; UserId: Integer; AlertManager: TAlertManager);
var
  vForm: TfmCommonAlert;
begin
  vForm := TfmCommonAlert.Create(Application);
  vForm.FUserId := UserId;
  vForm.FOptions := POptions^;
  vForm.FImgList := AImgList;
  vForm.FAutoAccept := vForm.FOptions.EventType = awetCall;
  vForm.FFrameClass := frmAlertClass;
  vForm.FConnection := AConnection;
  vForm.FAlertManager := AlertManager;
  vForm.Initialize;
  //g_AlertManager.RegisterWindow(vForm.Handle);
  //vForm.FFrame.Show;
  vForm.Show;
  vForm.trmMinimize.Enabled := True;
  dispose(POptions);
end;

procedure TfmCommonAlert.Initialize;
var
  W, H: Integer;
begin
  FAutoAccept := FOptions.EventType = awetCall;
  if FOptions.EventType = awetCall then
    tmrCloseAW.Interval := 2 * 60000
  else
    tmrCloseAW.Interval := 2000;

  Self.Color := FOptions.WColor;
  PanelFrame.Color := FOptions.WColor;
  PanelFrame.Font.Color := FOptions.TextColor;

  FFrame := FFrameClass.Create(Self);
  W := FFrame.Width;
  H := FFrame.Height;
  Self.ClientWidth := W;
  Self.ClientHeight := H + 5;
  FFrame.Initialize(FOptions, FImgList, FUserId, FConnection);
  FFrame.Align := alClient;
  FFrame.Parent := PanelFrame;
  FFrame.OnAccept := Self.OnAccept;
  if FFrame is TfrmCallClientAlert then
  begin
    Self.Caption := Self.Caption + ' ' + TfrmCallClientAlert(FFrame).Phone;
    TfrmCallClientAlert(FFrame).OnDataChange := ControlDataChange;
  end;
  FFrame.FreeNotification(Self);

  FFrame.IncUserEnumerator;
  SetAutoClose(True);
  FFrame.Visible := True;
  InnerInitialize;
end;

procedure TfmCommonAlert.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FFrame) then
    FFrame := nil;
end;

procedure TfmCommonAlert.OnAccept(Sender: TObject);
begin
  FOptions.WFadeMetod := fmAAWFadeRightToLeft;
  CloseForm;
end;

procedure TfmCommonAlert.CloseForm;
begin
  SetAutoClose(False);

  if FAutoAccept and Assigned(FFrame) and not FFrame.Accepted then
    FFrame.AcceptMsg(False);
  if Assigned(FFrame) then
    FFrame.DoClose;

  Self.Close;
  {case FOptions.WFadeMetod of
    fmAAWFadeTimer       : tmrFade.Enabled := True;
    fmAAWFadeRightToLeft : AnimateWindow(handle, 500, AW_HIDE or  AW_SLIDE or AW_VER_NEGATIVE);
    fmAAWFadeCenter      : AnimateWindow(handle, 500, AW_HIDE or  AW_SLIDE or AW_CENTER);
    fmAAWFadeDowmUp      : AnimateWindow(handle, 500, AW_HIDE or  AW_SLIDE or AW_HOR_POSITIVE);
  end;

  if not (FOptions.WFadeMetod in [fmAAWFadeTimer]) then
  begin
    self.Visible := False;
    destroy;
  end;}
end;

procedure TfmCommonAlert.tmrCloseAWTimer(Sender: TObject);
begin
  CloseForm;
end;

procedure TfmCommonAlert.SetAutoClose(Value: Boolean);
begin
  tmrCloseAW.Enabled := Value;
end;

procedure TfmCommonAlert.ControlDataChange(Sender: TObject);
begin
  SetAutoClose(False);
end;

procedure TfmCommonAlert.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FAutoAccept and Assigned(FFrame) and not FFrame.Accepted then
    FFrame.AcceptMsg(False);
  FAlertManager.UnRegisterWindow(Self.Handle);
  Action := caFree;
  //Self.Release;
end;

procedure TfmCommonAlert.UpdateWindowPos;
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
  SetWindowPos(PWH, HWND_TOPMOST, LeftAW, TopAW, rAW.Right-rAW.Left, rAW.Bottom-rAW.Top, SWP_SHOWWINDOW or SWP_NOACTIVATE);
end;


procedure TfmCommonAlert.FormShow(Sender: TObject);
begin
  FAlertManager.RegisterWindow(Self.Handle);
  //UpdateWindowPos;
end;

procedure TfmCommonAlert.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    ExStyle := ExStyle or WS_EX_APPWINDOW;
    WndParent := GetDesktopWindow;
  end;
end;

procedure TfmCommonAlert.WMSysCommand(var Msg: TWMSysCommand);
begin
  if Msg.CmdType = SC_MINIMIZE then
    ShowWindow(Handle, SW_MINIMIZE)
  else
    inherited;
end;
{procedure TfmCommonAlert.FormCreate(Sender: TObject);
begin
  //SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  //SetWindowLong(Handle, GWL_HWNDPARENT, 0);
end;}

procedure TfmCommonAlert.trmMinimizeTimer(Sender: TObject);
begin
  ShowWindow(Handle, SW_MINIMIZE);
  trmMinimize.Enabled := False;
end;

end.
