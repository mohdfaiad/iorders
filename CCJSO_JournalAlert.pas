unit CCJSO_JournalAlert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ComCtrls, ExtCtrls, Grids, DBGrids, DB, ADODB, ActnList,
  StdCtrls;

{ Структура регистрационной записи уведомления }
type TJournalAlertItem = record
  NRN_Contents   : integer;
  SAlertDate     : string;
  NAlertType     : integer;
  SCodeAlertType : string;
  SNameAlertType : string;
  SContents      : string;
  IShowNumber    : integer;
  SJList         : string;
  NAlertUserType : integer;
  SAlertUserType : string;
  SExecDate      : string;
  BForShure      : boolean;
  SFromWhom      : string;
  {--}
  NRN_AlertUser  : int64;
  NUSER          : integer;
  SUSER          : string;
  SReadDate      : string;
  IEnumerator    : integer;
  SEnumerator    : string;
end;

type
  TfrmCCJSO_JournalAlert = class(TForm)
    pnlCondition: TPanel;
    pnlTool: TPanel;
    pnlTool_Show: TPanel;
    pnlTool_Bar: TPanel;
    pnlGrid: TPanel;
    toolBar: TToolBar;
    GridJA: TDBGrid;
    qrspJA: TADOStoredProc;
    dsJA: TDataSource;
    aList: TActionList;
    aRefresh: TAction;
    aCondition: TAction;
    lblCndDatePeriod_with: TLabel;
    dtCndBegin: TDateTimePicker;
    lblCndDatePeriod_toOn: TLabel;
    dtCndEnd: TDateTimePicker;
    lblCnd_TypeAlert: TLabel;
    aSelectTypeAlert: TAction;
    edCnd_TypeAlert: TEdit;
    btnCnd_TypeAlert: TButton;
    tbtnRefresh: TToolButton;
    aItemInfo: TAction;
    tbtnItemInfo: TToolButton;
    aClearCondition: TAction;
    tbtnClearCondition: TToolButton;
    pnlImage: TPanel;
    imgFeedBack: TImage;
    imgFeedBackOld: TImage;
    imgRareMedication: TImage;
    imgMissedCall: TImage;
    imgNewPay: TImage;
    imgNewCheckoutCheck: TImage;
    imgUser: TImage;
    imgError: TImage;
    aExit: TAction;
    aClearHistory: TAction;
    tbtnClearHistory: TToolButton;
    aAlertAll: TAction;
    tbtnAlertAll: TToolButton;
    imgPharmacy: TImage;
    imgNewPost: TImage;
    aShowOptions: TAction;
    tbtnAlertShowOptions: TToolButton;
    imgCall: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aConditionExecute(Sender: TObject);
    procedure aSelectTypeAlertExecute(Sender: TObject);
    procedure edCnd_TypeAlertDblClick(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure GridJADrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aItemInfoExecute(Sender: TObject);
    procedure aClearConditionExecute(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure GridJADblClick(Sender: TObject);
    procedure aClearHistoryExecute(Sender: TObject);
    procedure aAlertAllExecute(Sender: TObject);
    procedure aShowOptionsExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActivate  : integer;
    NUSER          : integer;
    FIP            : string;
    SUSER          : string;
    NCnd_TypeAlert : integer;
    RecItem        : TJournalAlertItem;
    procedure ShowGets;

    procedure ExecCondition;
    procedure CreateCondition;
    procedure GridJARefresh;
    function  GetStateClearCondition : boolean;
  public
    { Public declarations }
    procedure SetUser(Parm : integer);
    procedure SetSUser(Parm : string);
    property IP: string read FIP write FIP;
  end;

var
  frmCCJSO_JournalAlert: TfrmCCJSO_JournalAlert;

implementation

uses
  DateUtils, Util,
  UMain, UCCenterJournalNetZkz, UReference, CCJSO_JournalAlert_Item, CCSJO_AlertContents,
  CCJSO_AccessUserAlert;

{$R *.dfm}

procedure TfrmCCJSO_JournalAlert.FormCreate(Sender: TObject);
begin
  ISignActivate    := 0;
  dtCndBegin.Date  := date;
  dtCndEnd.Date    := date;
  NCnd_TypeAlert   := 0;
  pnlImage.Visible := false;
  { Картинки-признаки для гридов }
  FCCenterJournalNetZkz.imgMain.GetBitmap(cImgMain_FeedBack, imgFeedBack.Picture.Bitmap);                  imgFeedBack.Repaint;
  FCCenterJournalNetZkz.imgMain.GetBitmap(cImgMain_FeedBackOld, imgFeedBackOld.Picture.Bitmap);            imgFeedBackOld.Repaint;
  FCCenterJournalNetZkz.imgMain.GetBitmap(cImgMain_RareMedication, imgRareMedication.Picture.Bitmap);      imgRareMedication.Repaint;
  FCCenterJournalNetZkz.imgMain.GetBitmap(cImgMain_MissedCall, imgMissedCall.Picture.Bitmap);              imgMissedCall.Repaint;
  FCCenterJournalNetZkz.imgMain.GetBitmap(cImgMain_NewPay, imgNewPay.Picture.Bitmap);                      imgNewPay.Repaint;
  FCCenterJournalNetZkz.imgMain.GetBitmap(cImgMain_NewCheckoutCheck, imgNewCheckoutCheck.Picture.Bitmap);  imgNewCheckoutCheck.Repaint;
  FCCenterJournalNetZkz.imgMain.GetBitmap(cImgMain_User, imgUser.Picture.Bitmap);                          imgUser.Repaint;
  FCCenterJournalNetZkz.imgMain.GetBitmap(cImgMain_Error, imgError.Picture.Bitmap);                        imgError.Repaint;
  FCCenterJournalNetZkz.imgMain.GetBitmap(cImgMain_Pharmacy, imgPharmacy.Picture.Bitmap);                  imgPharmacy.Repaint;
  FCCenterJournalNetZkz.imgMain.GetBitmap(cImgMain_NewPost, imgNewPost.Picture.Bitmap);                    imgNewPost.Repaint;
  FCCenterJournalNetZkz.imgMain.GetBitmap(cImgMain_Call, imgCall.Picture.Bitmap);                          imgCall.Repaint;
end;

procedure TfrmCCJSO_JournalAlert.FormActivate(Sender: TObject);
begin
  if ISignActivate = 0 then begin
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(319,self.Icon);
    { Заголовок формы }
    self.Caption := 'История уведомлений (' + SUSER + ')'; 
    { Форма активна }
    ISignActivate := 1;
    ExecCondition;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_JournalAlert.SetUser(Parm : integer); begin NUSER := Parm; end;
procedure TfrmCCJSO_JournalAlert.SetSUser(Parm : string); begin SUSER := Parm;  end;

function  TfrmCCJSO_JournalAlert.GetStateClearCondition : boolean;
var bResReturn : boolean;
begin
  if     (length(trim(edCnd_TypeAlert.Text)) = 0)
     and (NCnd_TypeAlert                     = 0)
  then bResReturn := true
  else bResReturn := false;
  result := bResReturn;
end;

procedure TfrmCCJSO_JournalAlert.ShowGets;
var
  SCaption : string;
begin
  if ISignActivate = 1 then begin
    { Количество записей }
    SCaption := VarToStr(qrspJA.RecordCount);
    pnlTool_Show.Caption := SCaption; pnlTool_Show.Width := TextPixWidth(SCaption, pnlTool_Show.Font) + 20;
    { Управление доступом к элементам управления}
    if qrspJA.IsEmpty then begin
      aItemInfo.Enabled := false;
    end else begin
      aItemInfo.Enabled := true;
    end;
    { Доступ к очистке условий отбора }
    if GetStateClearCondition
      then aClearCondition.Enabled := false
      else aClearCondition.Enabled := true;
  end;
end;

procedure TfrmCCJSO_JournalAlert.ExecCondition;
var
  RN: int64;
begin
  if not qrspJA.IsEmpty then RN := qrspJA.FieldByName('NRN_AlertUser').AsInteger else RN := -1;
  if qrspJA.Active then qrspJA.Active := false;
  CreateCondition;
  qrspJA.Active := true;
  qrspJA.Locate('NRN_AlertUser', RN, []);
  ShowGets;
end;

procedure TfrmCCJSO_JournalAlert.CreateCondition;
begin
  qrspJA.Parameters.ParamValues['@USER']                := NUSER;
  qrspJA.Parameters.ParamValues['@IP']                  := FIP;  
  qrspJA.Parameters.ParamValues['@AlertBegin']          := FormatDateTime('yyyy-mm-dd', dtCndBegin.Date);
  qrspJA.Parameters.ParamValues['@AlertEnd']            := FormatDateTime('yyyy-mm-dd', IncDay(dtCndEnd.Date,1));
  qrspJA.Parameters.ParamValues['@SignNotRead']         := 0;
  qrspJA.Parameters.ParamValues['@SignCheckEnumerator'] := 0;
  qrspJA.Parameters.ParamValues['@SignCheckExec']       := 0;
  qrspJA.Parameters.ParamValues['@AlertType']           := NCnd_TypeAlert;
end;

procedure TfrmCCJSO_JournalAlert.aConditionExecute(Sender: TObject);
begin
  if ISignActivate = 1 then begin
    ExecCondition;
  end;
end;

procedure TfrmCCJSO_JournalAlert.aSelectTypeAlertExecute(Sender: TObject);
var
  DescrSelect : string;
  RNSelect    : integer;
begin
  DescrSelect := '';
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFRefAlertType);
   frmReference.SetReadOnly(cFReferenceYesReadOnly);
   try
    frmReference.ShowModal;
    DescrSelect := frmReference.GetDescrSelect;
    RNSelect    := frmReference.GetRowIDSelect;
    if length(DescrSelect) > 0 then begin
      NCnd_TypeAlert       := RNSelect;
      edCnd_TypeAlert.Text := DescrSelect;
    end;
   finally
    frmReference.Free;
   end;
  except
  end;
  ShowGets;
end;

procedure TfrmCCJSO_JournalAlert.edCnd_TypeAlertDblClick(Sender: TObject);
begin
  aSelectTypeAlert.Execute;
end;

procedure TfrmCCJSO_JournalAlert.GridJARefresh;
var
  RN: int64;
begin
  if not qrspJA.IsEmpty then RN := qrspJA.FieldByName('NRN_AlertUser').AsInteger else RN := -1;
  qrspJA.Requery;
  qrspJA.Locate('NRN_AlertUser', RN, []);
end;

procedure TfrmCCJSO_JournalAlert.aRefreshExecute(Sender: TObject);
begin
  GridJARefresh;
  ShowGets;
end;

procedure TfrmCCJSO_JournalAlert.GridJADrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
  dr               : TRect;
  sr               : TRect;
  imgWidth         : integer;
  imgHeight        : integer;
  procedure SetRect(imgType : TImage); begin
    imgWidth  := imgType.Width;
    imgHeight := imgType.Height;
    dr        := Rect;
    dr.Left   := dr.Left + 2;
   {dr.Top    := dr.Top  + 2;}
    dr.Right  := dR.Left + imgWidth;
    dr.Bottom := dR.Top  + imgHeight;
    sR.Left   := 0;
    sR.Top    := 0;
    sR.Right  := imgWidth;
    sR.Bottom := imgHeight;
    db.Canvas.CopyRect(dR,imgType.Canvas,sR);
  end;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  { Прорисовка графического признака типа уведомления }
  if Column.FieldName = 'SCodeAlertType' then begin
    db.Canvas.FillRect(Rect);
    Column.Title.Caption := '';
    try
      if      (Column.Field.AsString = 'FeedBack')         then SetRect(imgFeedBack)
      else if (Column.Field.AsString = 'FeedBackOld')      then SetRect(imgFeedBackOld)
      else if (Column.Field.AsString = 'RareMedication')   then SetRect(imgRareMedication)
      else if (Column.Field.AsString = 'MissedCall')       then SetRect(imgMissedCall)
      else if (Column.Field.AsString = 'NewPay')           then SetRect(imgNewPay)
      else if (Column.Field.AsString = 'NewCheckoutCheck') then SetRect(imgNewCheckoutCheck)
      else if (Column.Field.AsString = 'User')             then SetRect(imgUser)
      else if (Column.Field.AsString = 'Error')            then SetRect(imgError)
      else if (Column.Field.AsString = 'Pharmacy')         then SetRect(imgPharmacy)
      else if (Column.Field.AsString = 'NewPost')          then SetRect(imgNewPost)
      else if (Column.Field.AsString = 'Call')             then SetRect(imgCall);
    except
    end;
  end;
end;

procedure TfrmCCJSO_JournalAlert.aItemInfoExecute(Sender: TObject);
begin
  with RecItem do begin
    NRN_Contents   := GridJA.DataSource.DataSet.FieldByName('NRN_Contents').AsInteger;
    SAlertDate     := GridJA.DataSource.DataSet.FieldByName('SAlertDate').AsString;
    NAlertType     := GridJA.DataSource.DataSet.FieldByName('NAlertType').AsInteger;
    SCodeAlertType := GridJA.DataSource.DataSet.FieldByName('SCodeAlertType').AsString;
    SNameAlertType := GridJA.DataSource.DataSet.FieldByName('SNameAlertType').AsString;
    SContents      := GridJA.DataSource.DataSet.FieldByName('SContents').AsString;
    IShowNumber    := GridJA.DataSource.DataSet.FieldByName('IShowNumber').AsInteger;
    SJList         := GridJA.DataSource.DataSet.FieldByName('SJList').AsString;
    NAlertUserType := GridJA.DataSource.DataSet.FieldByName('NAlertUserType').AsInteger;
    SAlertUserType := GridJA.DataSource.DataSet.FieldByName('SAlertUserType').AsString;
    SExecDate      := GridJA.DataSource.DataSet.FieldByName('SExecDate').AsString;
    BForShure      := GridJA.DataSource.DataSet.FieldByName('BForShure').AsBoolean;
    SFromWhom      := GridJA.DataSource.DataSet.FieldByName('SFromWhom').AsString;
    {--}
    NRN_AlertUser  := GridJA.DataSource.DataSet.FieldByName('NRN_AlertUser').AsInteger;
    NUSER          := GridJA.DataSource.DataSet.FieldByName('NUSER').AsInteger;
    SUSER          := GridJA.DataSource.DataSet.FieldByName('SUSER').AsString;
    SReadDate      := GridJA.DataSource.DataSet.FieldByName('SReadDate').AsString;
    IEnumerator    := GridJA.DataSource.DataSet.FieldByName('IEnumerator').AsInteger;
    SEnumerator    := GridJA.DataSource.DataSet.FieldByName('SEnumerator').AsString;
  end;
  try
    frmCCJSO_JournalAlert_Item := TfrmCCJSO_JournalAlert_Item.Create(Self);
    frmCCJSO_JournalAlert_Item.SetRecItem(RecItem);
    try
      frmCCJSO_JournalAlert_Item.ShowModal;
    finally
      FreeAndNil(frmCCJSO_JournalAlert_Item);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TfrmCCJSO_JournalAlert.aClearConditionExecute(Sender: TObject);
begin
  edCnd_TypeAlert.Text := '';
  NCnd_TypeAlert := 0;
  ExecCondition;
  ShowGets;
end;

procedure TfrmCCJSO_JournalAlert.aExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJSO_JournalAlert.GridJADblClick(Sender: TObject);
begin
  if aItemInfo.Enabled then begin
    aItemInfo.Execute;
  end;
end;

procedure TfrmCCJSO_JournalAlert.aClearHistoryExecute(Sender: TObject);
begin
  //
end;

procedure TfrmCCJSO_JournalAlert.aAlertAllExecute(Sender: TObject);
begin
  FCCenterJournalNetZkz.UserActive;
  try
    frmCCSJO_AlertContents := TfrmCCSJO_AlertContents.Create(Self);
    try
      frmCCSJO_AlertContents.ShowModal;
    finally
      FreeAndNil(frmCCSJO_AlertContents);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TfrmCCJSO_JournalAlert.aShowOptionsExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  FCCenterJournalNetZkz.UserActive;
  try
    frmCCJSO_AccessUserAlert := TfrmCCJSO_AccessUserAlert.Create(Self);
    frmCCJSO_AccessUserAlert.SetUser(NUSER);
    try
      frmCCJSO_AccessUserAlert.ShowModal;
    finally
      FreeAndNil(frmCCJSO_AccessUserAlert);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
 end;
end;

end.
