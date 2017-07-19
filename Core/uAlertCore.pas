unit uAlertCore;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UtilsBase;

type
  { Механизм оповещений }
  TAlertWindowEventType  = (awetFeedBack, awetRMedication, awetMissedCall, awetPay, awetPayCheck, awetError, awetUser, awetPharmacy, awetNewPost, awetCall);

  TAlertWindowShowMethod = (fmAAWShowLeftToRight,fmAAWShowCenter,fmAAWShowTopDown);

  TAlertWindowFadeMethod = (fmAAWFadeTimer, fmAAWFadeRightToLeft, fmAAWFadeCenter, fmAAWFadeDowmUp);
  PAlertPopupWindowOptions = ^TAlertPopupWindowOptions;

  TAlertPopupWindowOptions = record
    NRN_AlertUser : int64;
    Enumereator   : byte;
    EventTime     : TDateTime;
    EventType     : TAlertWindowEventType;
    WShowMetod    : TAlertWindowShowMethod;
    WFadeMetod    : TAlertWindowFadeMethod;
    WColor        : TColor;
    TextColor     : TColor;
    AlertMessage  : string;
    AlertType     : string;
    AlertUser     : string;
    AlertTypeUser : string;
    IconIndex     : integer;
    Content       : string;
  end;

  TAlertPopupWindowControl = class
  private
    procedure UpdateWindowPos(PWH : HWND);
  public
    AWList : TList;
    procedure RegisterAlertPopupWindow(PWH: HWND);
    procedure UnRegisterAlertPopupWindow(PWH: HWND);
    constructor Create;
    destructor  Destroy;
  end;

  TWndRec = record
    Handle: HWND;
    Id: Integer;
  end;

  PWndRec = ^TWndRec;

  TAlertManager = class
  private
    FList: TList;
    FWList: TList;
    FLeft: Integer;
    FTop: Integer;
    FDeltaX: Integer;
    FDeltaY: Integer;
    FMaxCnt: Integer;
    FCurrId: Integer;
    procedure UpdateWindowPos(Handle: HWND);
  public
    procedure RegisterWindow(Handle: HWND);
    procedure UnRegisterWindow(Handle: HWND);
    constructor Create;
    destructor  Destroy; override;
  end;

var
   g_AlertManager: TAlertManager;


implementation


procedure TAlertPopupWindowControl.UpdateWindowPos(PWH : HWND);
const
  IndentY = 100;
var
  rAW     : TRect;
  TopAW   : integer;
  LeftAW  : integer;
  i       : integer;
  BErr    : boolean;
  ScreenY : integer;
  ScreenX : integer;
begin
  ScreenY := screen.WorkAreaHeight-100;
  ScreenX := screen.WorkAreaWidth;
  TopAW  := ScreenY - IndentY - 2;
  for i := 0 to AWList.Count - 1 do begin
    GetWindowRect(HWND(AWList[i]),rAW);
    LeftAW := ScreenX - (rAW.Right-rAW.Left) - 2;
    BErr := SetWindowPos(HWND(AWList[i]), HWND_TOPMOST, LeftAW, TopAW, rAW.Right-rAW.Left, rAW.Bottom-rAW.Top, SWP_SHOWWINDOW or SWP_NOACTIVATE);
    (*
    case TfrmDepED_WAlert(popupList[i]).AlertWOptions.WShowMetod of
      fmAAWShowLeftToRight : AnimateWindow(HWND(popupList[i]), 300, AW_SLIDE or AW_HOR_POSITIVE ); { слева на право }
      fmAAWShowCenter      : AnimateWindow(HWND(popupList[i]), 300, AW_SLIDE or AW_CENTER );
      fmAAWShowTopDown     : AnimateWindow(HWND(popupList[i]), 300, AW_SLIDE or AW_VER_POSITIVE ); { сверху вниз }
    else
      AnimateWindow(HWND(popupList[i]), 300, AW_SLIDE or AW_HOR_POSITIVE );  { слева на право }
    end;
    *)
    TopAW := TopAW - (rAW.Bottom  - rAW.Top) - 2;
  end;
end;


constructor TAlertPopupWindowControl.Create;
begin
  AWList := TList.Create;
end;

procedure TAlertPopupWindowControl.RegisterAlertPopupWindow(PWH: HWND);
var
  IndexAW : integer;
begin
  IndexAW := AWList.IndexOf(Pointer(PWH));
  if IndexAW < 0 then
    AWList.Add(Pointer(PWH));
  UpdateWindowPos(PWH);
end;

procedure TAlertPopupWindowControl.UnRegisterAlertPopupWindow(PWH: HWND);
var
  IndexAW : integer;
begin
  IndexAW := AWList.IndexOf(Pointer(PWH));
  if IndexAW >= 0 then begin
    AWList.Remove(Pointer(PWH));
    UpdateWindowPos(PWH);
  end;
end;

destructor TAlertPopupWindowControl.Destroy;
begin
  AWList.Free;
end;

{  TAlertManager }
constructor TAlertManager.Create;
begin
  inherited;
  FList := TList.Create;
  FWList := TList.Create;
  FLeft := 30;
  FTop := screen.WorkAreaHeight - 380;
  FDeltaX := 0;
  FDeltaY := 100;
  FMaxCnt := 5;
  FCurrId := 1;
end;

destructor TAlertManager.Destroy;
begin
  FList.Free;
  FWList.Free;
  inherited;
end;

procedure TAlertManager.RegisterWindow(Handle: HWND);
var
  Idx : integer;
  vWnd: TWndRec;
begin
  Idx := FList.IndexOf(Pointer(Handle));
  if Idx < 0 then
  begin
    FList.Add(Pointer(Handle));
    vWnd.Handle := Handle;
    vWnd.Id := FCurrId;
    FWList.Add(@vWnd);
    Inc(FCurrId);
    if FCurrId > FMaxCnt then
      FCurrId := 1;
  end;
  UpdateWindowPos(Handle);
end;

procedure TAlertManager.UnRegisterWindow(Handle: HWND);
var
  Idx : integer;
begin
  Idx := FList.IndexOf(Pointer(Handle));
  if Idx >= 0 then
  begin
    FList.Delete(Idx);
    FWList.Delete(Idx);
    if FList.Count = 0 then
       FCurrId := 1;
    //UpdateWindowPos(PWH);
  end;
end;

procedure TAlertManager.UpdateWindowPos(Handle: HWND);
var
  vRect: TRect;
  vTop: integer;
  vLeft: integer;
  I: Integer;
  vPWnd: PWndRec;
begin
  if FWList.Count > 0 then
  begin
    vPWnd := PWndRec(FWList.Items[FWList.Count - 1]);
    I := vPWnd^.Id;
  end
  else
    I := 1;  
  vTop := FTop - (I - 1)* FDeltaY;
  vLeft := FLeft + (I - 1) * FDeltaX;
  GetWindowRect(Handle ,vRect);
  SetWindowPos(Handle, HWND_TOPMOST, vLeft, vTop, vRect.Right - vRect.Left, vRect.Bottom - vRect.Top, SWP_SHOWWINDOW or SWP_NOACTIVATE);
end;

initialization
  g_AlertManager := TAlertManager.Create;

finalization
  FreeAndNil(g_AlertManager);


end.
