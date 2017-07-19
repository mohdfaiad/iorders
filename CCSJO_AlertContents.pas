unit CCSJO_AlertContents;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin, StdCtrls, ActnList,
  DB, ADODB,
  UCCenterJournalNetZkz;

{ Структура регистрационной записи уведомления }
type TItemAContents = record
  NRN            : integer;
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
  NFromWhom      : integer;
  SFromWhom      : string;
end;

type
  TfrmCCSJO_AlertContents = class(TForm)
    pnlCondition: TPanel;
    lblCndDatePeriod_with: TLabel;
    lblCndDatePeriod_toOn: TLabel;
    lblCnd_TypeAlert: TLabel;
    dtCndBegin: TDateTimePicker;
    dtCndEnd: TDateTimePicker;
    edCnd_TypeAlert: TEdit;
    btnCnd_TypeAlert: TButton;
    pnlTool: TPanel;
    pnlTool_Show: TPanel;
    pnlTool_Bar: TPanel;
    toolBar: TToolBar;
    tbtnRefresh: TToolButton;
    tbtnItemInfo: TToolButton;
    tbtnClearCondition: TToolButton;
    tbtnClearHistory: TToolButton;
    pnlGrid: TPanel;
    GridJA: TDBGrid;
    pnlImage: TPanel;
    imgFeedBack: TImage;
    imgFeedBackOld: TImage;
    imgRareMedication: TImage;
    imgMissedCall: TImage;
    imgNewPay: TImage;
    imgNewCheckoutCheck: TImage;
    imgUser: TImage;
    imgError: TImage;
    ActionList: TActionList;
    aCondition: TAction;
    aSelectTypeAlert: TAction;
    aRefresh: TAction;
    aItemInfo: TAction;
    aClearCondition: TAction;
    aExit: TAction;
    aClearHistory: TAction;
    dsJA: TDataSource;
    qrspJA: TADOStoredProc;
    aDistributedToUsers: TAction;
    tbtnDistributedToUsers: TToolButton;
    imgPharmacy: TImage;
    imgNewPost: TImage;
    imgCall: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aConditionExecute(Sender: TObject);
    procedure aSelectTypeAlertExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aItemInfoExecute(Sender: TObject);
    procedure aClearConditionExecute(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aClearHistoryExecute(Sender: TObject);
    procedure GridJADrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aDistributedToUsersExecute(Sender: TObject);
  private
    { Private declarations }
    ISignActivate    : integer;
    NCnd_TypeAlert   : integer;
    RecItemAContents : TItemAContents;
    RecSession       : TUserSession;
    procedure ShowGets;
    procedure ExecCondition;
    procedure CreateCondition;
    procedure GridJARefresh;
    function  GetStateClearCondition : boolean;
  public
    { Public declarations }
    procedure SetRecSession(Parm : TUserSession);
  end;

var
  frmCCSJO_AlertContents: TfrmCCSJO_AlertContents;

implementation

uses
  DateUtils, Util,
  UMain, UReference, CCSJO_AlertContents_Clear;

{$R *.dfm}

procedure TfrmCCSJO_AlertContents.FormCreate(Sender: TObject);
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

procedure TfrmCCSJO_AlertContents.FormActivate(Sender: TObject);
begin
  if ISignActivate = 0 then begin
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(326,self.Icon);
    { Форма активна }
    ISignActivate := 1;
    ExecCondition;
    ShowGets;
  end;
end;

procedure TfrmCCSJO_AlertContents.SetRecSession(Parm : TUserSession); begin RecSession := Parm; end;

procedure TfrmCCSJO_AlertContents.ShowGets;
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

procedure TfrmCCSJO_AlertContents.ExecCondition;
var
  RN: integer;
begin
  if not qrspJA.IsEmpty then RN := qrspJA.FieldByName('NRN').AsInteger else RN := -1;
  if qrspJA.Active then qrspJA.Active := false;
  CreateCondition;
  qrspJA.Active := true;
  qrspJA.Locate('NRN', RN, []);
  ShowGets;
end;

procedure TfrmCCSJO_AlertContents.CreateCondition;
begin
  qrspJA.Parameters.ParamValues['@AlertBegin']    := FormatDateTime('yyyy-mm-dd', dtCndBegin.Date);
  qrspJA.Parameters.ParamValues['@AlertEnd']      := FormatDateTime('yyyy-mm-dd', IncDay(dtCndEnd.Date,1));
  qrspJA.Parameters.ParamValues['@SignCheckExec'] := 0;
  qrspJA.Parameters.ParamValues['@AlertType']     := NCnd_TypeAlert;
end;

procedure TfrmCCSJO_AlertContents.GridJARefresh;
var
  RN: integer;
begin
  if not qrspJA.IsEmpty then RN := qrspJA.FieldByName('NRN').AsInteger else RN := -1;
  qrspJA.Requery;
  qrspJA.Locate('NRN', RN, []);
end;

function  TfrmCCSJO_AlertContents.GetStateClearCondition : boolean;
var bResReturn : boolean;
begin
  if     (length(trim(edCnd_TypeAlert.Text)) = 0)
     and (NCnd_TypeAlert                     = 0)
  then bResReturn := true
  else bResReturn := false;
  result := bResReturn;
end;

procedure TfrmCCSJO_AlertContents.aConditionExecute(Sender: TObject);
begin
  if ISignActivate = 1 then begin
    ExecCondition;
  end;
end;

procedure TfrmCCSJO_AlertContents.aSelectTypeAlertExecute(Sender: TObject);
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

procedure TfrmCCSJO_AlertContents.aRefreshExecute(Sender: TObject);
begin
  GridJARefresh;
  ShowGets;
end;

procedure TfrmCCSJO_AlertContents.aItemInfoExecute(Sender: TObject);
begin
  //
end;

procedure TfrmCCSJO_AlertContents.aClearConditionExecute(Sender: TObject);
begin
  edCnd_TypeAlert.Text := '';
  NCnd_TypeAlert := 0;
  ExecCondition;
  ShowGets;
end;

procedure TfrmCCSJO_AlertContents.aExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCSJO_AlertContents.aClearHistoryExecute(Sender: TObject);
begin
  try
    frmCCSJO_AlertContents_Clear := TfrmCCSJO_AlertContents_Clear.Create(Self);
    try
      frmCCSJO_AlertContents_Clear.ShowModal;
      frmCCSJO_AlertContents_Clear.SetRecSession(RecSession);
    finally
      FreeAndNil(frmCCSJO_AlertContents_Clear);
    end;
    aRefresh.Execute;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TfrmCCSJO_AlertContents.GridJADrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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
      else if (Column.Field.AsString = 'Call')             then SetRect(imgCall)
      ;
    except
    end;
  end;
end;

procedure TfrmCCSJO_AlertContents.aDistributedToUsersExecute(Sender: TObject);
begin
  //
end;

end.
