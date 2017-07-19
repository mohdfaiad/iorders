unit ufrmAlert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, StdCtrls, uAlertCore, DB, ADODB, Buttons;

type
  TfrmAlert = class;
  TfrmAlertClass = class of TfrmAlert;


  TfrmAlert = class(TFrame)
    PanelCaption: TPanel;
    lbType: TLabel;
    imgEventType: TImage;
    PanelBottom: TPanel;
    btnAccept: TBitBtn;
    spIncUserEnumerator: TADOStoredProc;
    spSetUserRead: TADOStoredProc;
    edCaption: TEdit;
    procedure btnAcceptClick(Sender: TObject);
  protected
    { Private declarations }
    FOptions : TAlertPopupWindowOptions;
    FUserId: Integer;
    FOnAccept: TNotifyEvent;
    FAccepted: Boolean;
    procedure OwnAcceptMsg; virtual;
  public
    procedure Initialize(AOptions : TAlertPopupWindowOptions; ImgList: TImageList;
      UserId: Integer; AConnection: TADOConnection); virtual;
    procedure IncUserEnumerator;
    procedure AcceptMsg(B: Boolean);
    procedure EnableAccept(Value: Boolean);
    procedure DoClose; virtual;
    property Accepted: Boolean read FAccepted write FAccepted;
    property OnAccept: TNotifyEvent read FOnAccept write FOnAccept;
  end;

implementation

{$R *.dfm}

procedure TfrmAlert.Initialize(AOptions : TAlertPopupWindowOptions; ImgList: TImageList;
  UserId: Integer; AConnection: TADOConnection);
begin
  FUserId := UserId;
  FOptions := AOptions;
  if Assigned(ImgList) then
  begin
    ImgList.GetBitmap(FOptions.IconIndex, imgEventType.Picture.Bitmap);
  end;
  lbType.Caption := FOptions.AlertType + ' ' + FormatDateTime('dd-mm-yyyy hh:nn:ss', FOptions.EventTime);
  edCaption.Text := '';
  edCaption.BorderStyle := bsNone;
  spIncUserEnumerator.Connection := AConnection;
  spSetUserRead.Connection := AConnection;
end;

procedure TfrmAlert.IncUserEnumerator;
begin
  try
    spIncUserEnumerator.Parameters.ParamValues['@NRN'] := FOptions.NRN_AlertUser;
    spIncUserEnumerator.ExecProc;
  except
    on E:Exception do
    begin
    end;
  end;
end;

procedure TfrmAlert.OwnAcceptMsg;
begin
  {Empty}
end;

procedure TfrmAlert.AcceptMsg(B: Boolean);
begin
  if not FAccepted then
  begin
    FAccepted := True;
    try
      spSetUserRead.Parameters.ParamValues['@NRN'] := FOptions.NRN_AlertUser;
      spSetUserRead.ExecProc;
      Self.OwnAcceptMsg;
      
      EnableAccept(False);
      if B and Assigned(FOnAccept) then
        FOnAccept(Self);
    except
      on E:Exception do
      begin
      end;
    end;
  end;
end;

procedure TfrmAlert.EnableAccept(Value: Boolean);
begin
  btnAccept.Enabled := Value;
end;

procedure TfrmAlert.btnAcceptClick(Sender: TObject);
begin
  AcceptMsg(True);
end;

procedure TfrmAlert.DoClose;
begin
  EnableAccept(False);
end;

end.
