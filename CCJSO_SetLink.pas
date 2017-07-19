unit CCJSO_SetLink;

{
  © PgkSoft 25.02.2016
  Журнал интернет заказов
  Механизм связывания заказов
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  {--}
  UCCenterJournalNetZkz, UMAIN, ActnList, ExtCtrls, ComCtrls, ToolWin,
  StdCtrls, DB, ADODB;

type
  TfrmCCJSO_SetLink = class(TForm)
    pnlControl: TPanel;
    pnlHeader: TPanel;
    pnlParam: TPanel;
    aList: TActionList;
    aOk: TAction;
    aExit: TAction;
    pnlControl_Tool: TPanel;
    tbarControl: TToolBar;
    tbtnControl_Ok: TToolButton;
    tbtnControl_Exit: TToolButton;
    pnlControl_Show: TPanel;
    pnlHeader_Order: TPanel;
    pnlHeader_ParentsList: TPanel;
    pnlHeader_SlavesList: TPanel;
    pnlHeader_ParentsList_Value: TPanel;
    pnlHeader_SlavesList_Value: TPanel;
    lblOrder: TLabel;
    edOrder: TEdit;
    spSetLink: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aOkExecute(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure edOrderChange(Sender: TObject);
  private
    { Private declarations }
    ISignActivate   : integer;
    Mode            : integer;
    ParentsList     : string;
    SlavesList      : string;
    UserSession     : TUserSession;
    OrderHeaderItem : TJSO_OrderHeaderItem;
    procedure ShowGets;
  public
    { Public declarations }
    procedure SetMode(Parm : integer);
    procedure SetRecHeaderItem(Parm : TJSO_OrderHeaderItem);
    procedure SetUserSession(Parm : TUserSession);
    procedure SetLinkList(ParmParents : string; ParmSlaves : string);
  end;

const
  cJSOLinkMode_AddToOrder       = 0;
  cJSOLinkMode_AddToMainRequest = 1;
var
  frmCCJSO_SetLink: TfrmCCJSO_SetLink;

implementation

uses
  UTIL, ExDBGRID;

const
  sMsgOrderTypeInt = 'Номер заказа имеет целочисленный формат';

{$R *.dfm}

procedure TfrmCCJSO_SetLink.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActivate := 0;
  Mode := -1;
end;

procedure TfrmCCJSO_SetLink.FormActivate(Sender: TObject);
var
  sCaption : string;
begin
  if ISignActivate = 0 then begin
    { Иконка и заголовок формы }
    case Mode of
      cJSOLinkMode_AddToOrder: begin
        FCCenterJournalNetZkz.imgMain.GetIcon(339,self.Icon);
        self.Caption := 'Прикрепить дополнительный заказ';
        sCaption := 'Выберите заказ, который нужно добавить к текущему заказу:';
        edOrder.Left := lblOrder.Left + TextPixWidth(SCaption, pnlParam.Font) + 3;
        lblOrder.Caption := sCaption;
      end;
      cJSOLinkMode_AddToMainRequest: begin
        FCCenterJournalNetZkz.imgMain.GetIcon(340,self.Icon);
        self.Caption := 'Добавить к основному заказу';
        sCaption := 'Выберите заказ, к которому нужно добавить текущий заказ:';
        edOrder.Left := lblOrder.Left + TextPixWidth(SCaption, pnlParam.Font) + 3;
        lblOrder.Caption := sCaption;
      end;
    end;
    self.Width := lblOrder.Left + lblOrder.Width + 3 + edOrder.Width + 12;
    pnlHeader_Order.Caption := ' Заказ № ' + OrderHeaderItem.SorderID;
    pnlHeader_ParentsList_Value.Caption := ParentsList;
    pnlHeader_SlavesList_Value.Caption := SlavesList;
    { Форма активна }
    ISignActivate := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_SetLink.SetMode(Parm : integer); begin Mode := Parm; end;
procedure TfrmCCJSO_SetLink.SetRecHeaderItem(Parm : TJSO_OrderHeaderItem); begin OrderHeaderItem := Parm; end;
procedure TfrmCCJSO_SetLink.SetUserSession(Parm : TUserSession); begin UserSession := Parm; end;
procedure TfrmCCJSO_SetLink.SetLinkList(ParmParents : string; ParmSlaves : string); begin ParentsList := ParmParents; SlavesList := ParmSlaves; end;

procedure TfrmCCJSO_SetLink.ShowGets;
begin
  if ISignActivate = 1 then begin
    { Доступ к элементам управления }
    if (
        (length(trim(edOrder.Text)) = 0)
        or
        (
         (length(trim(edOrder.Text)) <> 0)
         and
         (
          (not ufoTryStrToInt(edOrder.Text))
          or
          (StrToInt(edOrder.Text) <= 0)
          or
          (StrToInt(edOrder.Text) = OrderHeaderItem.orderID)
         )
        )
       )
    then aOk.Enabled := false
    else aOk.Enabled := true;
  end;
end;

procedure TfrmCCJSO_SetLink.aOkExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if MessageDLG('Подтвердите выполнение операции.',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  IErr := 0;
  SErr := '';
  try
    spSetLink.Parameters.ParamValues['@USER']      := UserSession.CurrentUser;
    spSetLink.Parameters.ParamValues['@OrderBase'] := OrderHeaderItem.orderID;
    spSetLink.Parameters.ParamValues['@OrderLink'] := StrToInt(edOrder.Text);
    spSetLink.Parameters.ParamValues['@ModeLink']  := Mode;
    spSetLink.ExecProc;
    IErr := spSetLink.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      self.Close;
    end else begin
      SErr := spSetLink.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TfrmCCJSO_SetLink.aExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJSO_SetLink.edOrderChange(Sender: TObject);
begin
  if not ufoTryStrToCurr(edOrder.Text) then ShowMessage(sMsgOrderTypeInt);
  ShowGets;
end;

end.
