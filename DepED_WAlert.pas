unit DepED_WAlert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UCCenterJournalNetZkz, ExtCtrls, StdCtrls, ActnList, ComCtrls,
  ToolWin, Buttons, DB, ADODB, UMain, uAlertCore;

const
  WM_CloseWAlert = WM_USER + 102;
type
  TfrmDepED_WAlert = class(TForm)
    pnlControl: TPanel;
    pnlMain: TPanel;
    tmrCloseAW: TTimer;
    tmrFade: TTimer;
    pnlMain_Img: TPanel;
    imgEventType: TImage;
    pnlMain_Msg: TPanel;
    edNameTypeAlert: TEdit;
    mMsgAlert: TMemo;
    pnlControl_Tool: TPanel;
    pnlControl_Show: TPanel;
    aMain: TActionList;
    aMain_Read: TAction;
    tlbarControl: TToolBar;
    tlbtnControl_Read: TToolButton;
    edAlertDate: TEdit;
    spIncUserEnumerator: TADOStoredProc;
    spSetUserRead: TADOStoredProc;
    procedure FormDestroy(Sender: TObject);
    procedure tmrCloseAWTimer(Sender: TObject);
    procedure tmrFadeTimer(Sender: TObject);
    procedure aMain_ReadExecute(Sender: TObject);
  private
    { Private declarations }
    FAutoRead: Boolean;
    FRead: Boolean;
    procedure wmCloseWAlert(var msg:TMessage); message WM_CloseWAlert;
    procedure ReadMsg;
  public
    { Public declarations }
    AlertWOptions : TAlertPopupWindowOptions;
    constructor Create(PAWOptions : PAlertPopupWindowOptions);
  end;

var
  frmDepED_WAlert: TfrmDepED_WAlert;

implementation

{$R *.dfm}

procedure TfrmDepED_WAlert.FormDestroy(Sender: TObject);
begin
  AlertPopupWindowControl.UnRegisterAlertPopupWindow(handle);
end;

constructor TfrmDepED_WAlert.Create(PAWOptions : PAlertPopupWindowOptions);
var
  rAW  : TRect;
  hrAW : HRgn;
  vList: TStringList;
begin
  inherited Create(nil);
  AlertWOptions := PAWOptions^;
  AlphaBlend := true;
  AlphaBlendValue := 215;
  FCCenterJournalNetZkz.imgMain.GetBitmap(AlertWOptions.IconIndex,imgEventType.Picture.Bitmap);  imgEventType.Repaint;
  pnlMain.Color := AlertWOptions.WColor;
  pnlControl.Color := AlertWOptions.WColor;
  pnlControl.Font.Color := AlertWOptions.TextColor;
  edAlertDate.Font.Color     := AlertWOptions.TextColor;
  edNameTypeAlert.Font.Color := AlertWOptions.TextColor;
  mMsgAlert.Font.Color := AlertWOptions.TextColor;
  tmrFade.Enabled := false;
  edAlertDate.BorderStyle := bsNone;
  edNameTypeAlert.BorderStyle := bsNone;

  edAlertDate.Font.Size := 8;
  edNameTypeAlert.Font.Size := 8;
  edNameTypeAlert.Font.Style := [];
  tmrCloseAW.Interval := 8000;
  FAutoRead := False;
  if AlertWOptions.EventType = awetUser then
  begin
    edAlertDate.Text := FormatDateTime('dd-mm-yyyy hh:nn:ss', AlertWOptions.EventTime) + '  ' + AlertWOptions.AlertUser;
    edNameTypeAlert.Text := AlertWOptions.AlertType + ' (' + AlertWOptions.AlertTypeUser + ')';
    mMsgAlert.Text := AlertWOptions.AlertMessage;
  end else
  if AlertWOptions.EventType = awetCall then
  begin
    edAlertDate.Text := AlertWOptions.AlertType + ' ' + FormatDateTime('dd-mm-yyyy hh:nn:ss', AlertWOptions.EventTime);
    vList := TStringList.Create;
    try
      vList.Delimiter := '&';
      vList.DelimitedText := AlertWOptions.AlertMessage;
      edNameTypeAlert.Font.Style := [fsBold];
      edNameTypeAlert.Text := vList.Strings[0];
      vList.Delete(0);
      mMsgAlert.Clear;
      mMsgAlert.Lines.AddStrings(vList);
    finally
      vList.Free;
    end;
    edAlertDate.Font.Size := 8;
    edNameTypeAlert.Font.Size := 6;
    tmrCloseAW.Interval := 20000;
    FAutoRead := True;
  end
  else
  begin
    edAlertDate.Text := FormatDateTime('dd-mm-yyyy hh:nn:ss', AlertWOptions.EventTime);
    edNameTypeAlert.Text := AlertWOptions.AlertType;
    mMsgAlert.Text := AlertWOptions.AlertMessage
  end;

  rAW := GetClientRect;
  hrAW := CreateRoundRectRgn(rAW.Left, rAW.top, rAW.Right, rAW.Bottom, 10, 10);
  SetWindowRgn(handle,hrAW,true);
  try
    spIncUserEnumerator.Parameters.ParamValues['@NRN'] := AlertWOptions.NRN_AlertUser;
    spIncUserEnumerator.ExecProc;
  except
    on e:Exception do
      begin
      end;
  end;
  AlertPopupWindowControl.RegisterAlertPopupWindow(handle);
  tmrCloseAW.Enabled := true;
  dispose(PAWOptions);
end;

procedure TfrmDepED_WAlert.wmCloseWAlert(var msg:TMessage);
begin
  destroy;
end;

procedure TfrmDepED_WAlert.tmrCloseAWTimer(Sender: TObject);
begin
  if FAutoRead and not FRead then
    ReadMsg;
  aMain_Read.Enabled := false;
  tmrCloseAW.Enabled := false;
  case AlertWOptions.WFadeMetod of
    fmAAWFadeTimer       : tmrFade.Enabled := true;
    fmAAWFadeRightToLeft : AnimateWindow(handle, 500, AW_HIDE or  AW_SLIDE or AW_VER_NEGATIVE);
    fmAAWFadeCenter      : AnimateWindow(handle, 500, AW_HIDE or  AW_SLIDE or AW_CENTER);
    fmAAWFadeDowmUp      : AnimateWindow(handle, 500, AW_HIDE or  AW_SLIDE or AW_HOR_POSITIVE);
  end;
  if not (AlertWOptions.WFadeMetod in [fmAAWFadeTimer]) then begin
    self.Visible := false;
    destroy;
  end;
end;

procedure TfrmDepED_WAlert.tmrFadeTimer(Sender: TObject);
begin
  aMain_Read.Enabled := false;
  if AlphaBlendValue > 0 then AlphaBlendValue := AlphaBlendValue - 1
  else begin
    tmrFade.Enabled := false;
    self.Visible := false;
    destroy;
  end;
end;

procedure TfrmDepED_WAlert.aMain_ReadExecute(Sender: TObject);
begin
  ReadMsg;
end;

procedure TfrmDepED_WAlert.ReadMsg;
begin
  if not FRead then
  begin
    FRead := True;
    try
      spSetUserRead.Parameters.ParamValues['@NRN'] := AlertWOptions.NRN_AlertUser;
      spSetUserRead.ExecProc;
      aMain_Read.Enabled := false;
    except
      on e:Exception do
        begin
        end;
    end;
  end;
end;

end.
