unit CCJSO_BlackListControl;

{*****************************************************
 * © PgkSoft 10.03.2016
 * Журнал интернет заказов
 * Реализация действий по управлению черным списком
 *****************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  UCCenterJournalNetZkz, ExtCtrls, Util, ComCtrls, ToolWin, ActnList,
  StdCtrls, uActionCore, UtilsBase;

type
  TfrmCCJSO_BlackListControl = class(TForm)
    pnlTop: TPanel;
    pnlTop_Order: TPanel;
    pnlTop_Client: TPanel;
    actionList: TActionList;
    aBlackList_Open: TAction;
    aFrmClose: TAction;
    aBlackList_Close: TAction;
    aBlackList_NnknownMode: TAction;
    pnlControl: TPanel;
    pnlControl_Tool: TPanel;
    tollBar: TToolBar;
    tlbtnExec: TToolButton;
    tlbtnClose: TToolButton;
    pnlControl_Show: TPanel;
    lblNote: TLabel;
    edNote: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aBlackList_OpenExecute(Sender: TObject);
    procedure aBlackList_CloseExecute(Sender: TObject);
    procedure aFrmCloseExecute(Sender: TObject);
    procedure edNoteChange(Sender: TObject);
  private
    { Private declarations }
    ISignActive     : integer;
    Mode            : smallint;
    RecSession      : TUserSession;
    RecHeaderItem   : TJSO_OrderHeaderItem;
    FOnAction: TBlackListEvent;
    FActionResult: TActionResult;
    procedure ShowGets;
  public
    { Public declarations }
    procedure SetRecHeaderItem(Parm : TJSO_OrderHeaderItem);
    procedure SetRecSession(Parm : TUserSession);
    procedure SetMode(Parm : smallint);
    function ShowDialog(OnAction: TBlackListEvent): TActionResult;
  end;

const
  cBlackListMode_Open  = 0;
  cBlackListMode_close = 1;
var
  frmCCJSO_BlackListControl: TfrmCCJSO_BlackListControl;

implementation

uses
  CCJSO_DM;

{$R *.dfm}

procedure TfrmCCJSO_BlackListControl.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
  Mode := -1;
end;

procedure TfrmCCJSO_BlackListControl.FormActivate(Sender: TObject);
var
  SCaption : string;
begin
  if ISignActive = 0 then begin
    edNote.Text := '';
    { Иконка формы и заголовок }
    if Mode = cBlackListMode_Open then begin
      FCCenterJournalNetZkz.imgMain.GetIcon(346,self.Icon);
      self.Caption := 'Добавить в черный список';
      tlbtnExec.Action := aBlackList_Open;
    end else if Mode = cBlackListMode_Close then begin
      FCCenterJournalNetZkz.imgMain.GetIcon(347,self.Icon);
      self.Caption := 'Убрать из черного списка';
      tlbtnExec.Action := aBlackList_Close;
    end else begin
      FCCenterJournalNetZkz.imgMain.GetIcon(345,self.Icon);
      self.Caption := '!!! Не определен режим работы';
      tlbtnExec.Action := aBlackList_NnknownMode;
    end;
    { Подгоняем под размер панель управления }
    pnlControl_Tool.Width := tlbtnExec.Width + tlbtnClose.Width + 3;
    { Отображаем реквизиты заказа }
    SCaption := '№ ' + RecHeaderItem.SorderID;
    pnlTop_Order.Caption := SCaption; pnlTop_Order.Width := TextPixWidth(SCaption, pnlTop_Order.Font) + 20;
    SCaption := RecHeaderItem.orderShipName + '; ' + RecHeaderItem.orderPhone;
    pnlTop_Client.Caption := SCaption;
    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_BlackListControl.SetRecHeaderItem(Parm : TJSO_OrderHeaderItem); begin RecHeaderItem := Parm; end;
procedure TfrmCCJSO_BlackListControl.SetRecSession(Parm : TUserSession); begin RecSession := Parm; end;
procedure TfrmCCJSO_BlackListControl.SetMode(Parm : smallint); begin Mode := Parm; end;

procedure TfrmCCJSO_BlackListControl.ShowGets;
begin
  if ISignActive = 1 then begin
    { Доступ к управлению }
    if length(edNote.Text) = 0 then begin
      aBlackList_Open.Enabled := false;
      aBlackList_Close.Enabled := false;
      edNote.Color := clYellow;
    end else begin
      aBlackList_Open.Enabled := true;
      aBlackList_Close.Enabled := true;
      edNote.Color := clWindow;
    end;
  end;
end;

procedure TfrmCCJSO_BlackListControl.aBlackList_OpenExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if MessageDLG('Подтвердите выполнение действия.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;

  if Assigned(FOnAction) then
  begin
    TActionCore.Clear_ActionResult(FActionResult);
    try
      FOnAction(RecHeaderItem.orderID, RecSession.CurrentUser, edNote.Text, blIns, FActionResult);
      if FActionResult.IErr <> 0 then
        ShowError(FActionResult.ExecMsg)
      else
        ModalResult := mrOk;
    except
      on E: Exception do
      begin
        FActionResult.IErr := cDefError;
        FActionResult.ExecMsg := TrimRight(E.Message + ' ' + FActionResult.ExecMsg);
        ShowError(FActionResult.ExecMsg);
      end;
    end;
  end else
  begin
    DM_CCJSO.BlackListInsert(RecSession.CurrentUser,RecHeaderItem.orderID,edNote.Text,IErr,SErr);
    if IErr = 0 then self.Close;
  end;
end;

procedure TfrmCCJSO_BlackListControl.aBlackList_CloseExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if MessageDLG('Подтвердите выполнение действия.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;

  if Assigned(FOnAction) then
  begin
    TActionCore.Clear_ActionResult(FActionResult);
    try
      FOnAction(RecHeaderItem.orderID, RecSession.CurrentUser, edNote.Text, blClose, FActionResult);
      if FActionResult.IErr <> 0 then
        ShowError(FActionResult.ExecMsg)
      else
        ModalResult := mrOk;
    except
      on E: Exception do
      begin
        FActionResult.IErr := cDefError;
        FActionResult.ExecMsg := TrimRight(E.Message + ' ' + FActionResult.ExecMsg);
        ShowError(FActionResult.ExecMsg);
      end;
    end;
  end else
  begin
    DM_CCJSO.BlackListClose(RecSession.CurrentUser,RecHeaderItem.orderID,edNote.Text,IErr,SErr);
    if IErr = 0 then self.Close;
  end;  
end;

procedure TfrmCCJSO_BlackListControl.aFrmCloseExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJSO_BlackListControl.edNoteChange(Sender: TObject);
begin
  ShowGets;
end;

function TfrmCCJSO_BlackListControl.ShowDialog(OnAction: TBlackListEvent): TActionResult;
begin
  FOnAction := OnAction;
  ShowModal;
  Result.IErr := FActionResult.IErr;
  Result.ExecMsg := FActionResult.ExecMsg;
end;


end.
