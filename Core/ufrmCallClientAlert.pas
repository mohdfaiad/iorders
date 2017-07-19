unit ufrmCallClientAlert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmAlert, ExtCtrls, StdCtrls, DBCtrls, DB, uDMJSO, uAlertCore,
  uSprQuery, ADODB, Buttons, UCCenterJournalNetZkz;

type
  TfrmCallClientAlert = class(TfrmAlert)
    PanelClient: TPanel;
    Label1: TLabel;
    edName: TEdit;
    dsAppealType: TDataSource;
    Label2: TLabel;
    lcAppealType: TDBLookupComboBox;
    Label3: TLabel;
    MemoContent: TMemo;
    Label4: TLabel;
    lcClientType: TDBLookupComboBox;
    dsClientType: TDataSource;
    btnSave: TButton;
    btnOrders: TButton;
    btnClient: TButton;
    lbAppealCnt: TLabel;
    Edit1: TEdit;
    Label6: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    Label5: TLabel;
    procedure DataChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnOrdersClick(Sender: TObject);
  private
    { Private declarations }
    FPhone: string;
    FInit: Boolean;
    FAppealId: Integer;
    FOnDataChange: TNotifyEvent;
    procedure ParseAlertMsg(Msg: string);
    procedure SetClient(ADS: TsprQuery);
    procedure ClearCtrls;
    procedure OwnAcceptMsg; override;
  public
    { Public declarations }
    procedure Initialize(AOptions : TAlertPopupWindowOptions; ImgList: TImageList;
      UserId: Integer; AConnection: TADOConnection); override;
    procedure SaveData;
    procedure DoClose; override;
    property OnDataChange: TNotifyEvent read FOnDataChange write FOnDataChange;
    property Phone: string read FPhone;
  end;

var
  frmCallClientAlert: TfrmCallClientAlert;

implementation

{$R *.dfm}

procedure TfrmCallClientAlert.ParseAlertMsg(Msg: string);
var
  vList: TStringList;
  sCnt: string;
  vPos: Integer;
begin
  vList := TStringList.Create;
  try
    vList.Delimiter := '&';
    vList.DelimitedText := Msg;
    edCaption.Text := vList.Strings[0];
    FPhone := Trim(vList.Strings[0]);
    btnOrders.Enabled := FPhone <> '';
    if vList.Count > 1 then
    begin
      sCnt := vList.Strings[2];
      vPos := Pos(':', sCnt);
      if  vPos > 0 then
      begin
        sCnt := Copy(sCnt, vPos + 1, Length(sCnt) - vPos);
        lbAppealCnt.Caption := sCnt;
      end
      else
        lbAppealCnt.Caption := '-';
    end
  finally
    vList.Free;
  end;
end;

procedure TfrmCallClientAlert.ClearCtrls;
begin
  edName.Text := '';
  lcClientType.KeyValue := null;
  lcAppealType.KeyValue := null;
  MemoContent.Clear;
end;

procedure TfrmCallClientAlert.Initialize(AOptions : TAlertPopupWindowOptions; ImgList: TImageList;
      UserId: Integer; AConnection: TADOConnection);
var
  vClient: Integer;
  DS: TsprQuery;
begin
  FInit := True;
  try
    inherited;
    btnSave.Enabled := False;
    FAppealId := 0;
    FPhone := '';
    ClearCtrls;
    ParseAlertMsg(AOptions.AlertMessage);
    dsAppealType.DataSet := dmJSO.GetAppealType(True);
    dsClientType.DataSet := dmJSO.GetClientType(True);

    if Length(FPhone) > 0 then
    begin
      DS := dmJSO.GetClient(FPhone);
      if DS.RecordCount <> 1 then
        DS := nil;
    end
    else
      DS := nil;
    SetClient(DS);  
  finally
    FInit := False;
  end
end;

procedure TfrmCallClientAlert.SetClient(ADS: TsprQuery);
begin
  if Assigned(ADS) then
  begin
    edName.Text := ADS.FieldByName('Name').AsString;
    lcClientType.KeyValue := ADS.FieldByName('TypeId').Value;
  end;
  lcAppealType.KeyValue := 1;
end;

procedure TfrmCallClientAlert.SaveData;
begin
  dmJSO.UpdClient(FPhone, edName.Text, lcAppealType.KeyValue,
    MemoContent.Text, FUserId, FAppealId);
end;

procedure TfrmCallClientAlert.DataChange(Sender: TObject);
begin
  inherited;
  btnSave.Enabled := True;
  if not FInit and Assigned(FOnDataChange) then
    FOnDataChange(Self);
end;

procedure TfrmCallClientAlert.DoClose;
begin
  inherited;
  btnSave.Enabled := False;
end;

procedure TfrmCallClientAlert.btnSaveClick(Sender: TObject);
begin
  inherited;
  btnSave.Enabled := False;
  SaveData;
end;

procedure TfrmCallClientAlert.OwnAcceptMsg;
begin
  SaveData;
end;

procedure TfrmCallClientAlert.btnOrdersClick(Sender: TObject);
var
  vCond: TJSO_Condition;
  vPCond: PJSO_Condition;
begin
  inherited;
  new(vPCond);
  vPCond.SOrderId := FPhone;
{  vCond.MPhone := FPhone;
  vCond.SignAccountPeriod := False; }
  SendMessage(FCCenterJournalNetZkz.Handle, WM_FilterOrdersEvent, 0, Integer(vPCond));
  Application.ProcessMessages;
end;


end.
