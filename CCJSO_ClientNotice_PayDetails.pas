unit CCJSO_ClientNotice_PayDetails;

{
  © PgkSoft 25.08.2016
  Механизм формирования и отправки клиенту реквизитов платежа
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UCCenterJournalNetZkz, ActnList, ExtCtrls, StdCtrls, ComCtrls,
  ToolWin, DB, ADODB, uActionCore;

type
  TfrmCCJSO_ClientNotice_PayDetails = class(TForm)
    pnlControl: TPanel;
    pnlControl_Tool: TPanel;
    pnlControl_Show: TPanel;
    pnlParm: TPanel;
    aList: TActionList;
    aExit: TAction;
    aRegNotice: TAction;
    lblOrder: TLabel;
    lblPrefix: TLabel;
    lblPharm: TLabel;
    lblClient: TLabel;
    lblPhone: TLabel;
    lblEMail: TLabel;
    lblSum: TLabel;
    lblShipping: TLabel;
    lblPayment: TLabel;
    lblDetails: TLabel;
    edOrder: TEdit;
    edPrefix: TEdit;
    edClient: TEdit;
    edPhone: TEdit;
    edEMail: TEdit;
    edSum: TEdit;
    edShipping: TEdit;
    edPayment: TEdit;
    edPharm: TEdit;
    edDetails: TMemo;
    tbarTool: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    edCheck: TMemo;
    spGetPaymentDetails: TADOStoredProc;
    aChange: TAction;
    lblOrderAmount: TLabel;
    edOrderAmount: TEdit;
    spPayDetails: TADOStoredProc;
    lblOrderAmountShipping: TLabel;
    edOrderAmountShipping: TEdit;
    lblCoolantSum: TLabel;
    edCoolantSum: TEdit;
    Label1: TLabel;
    edOrderName: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aRegNoticeExecute(Sender: TObject);
    procedure aChangeExecute(Sender: TObject);
  private
    { Private declarations }
    bSignActive   : boolean;
    Section       : integer;
    OrderPrefix   : string;
    RecSession    : TUserSession;
    RecHeaderItem : TJSO_OrderHeaderItem;
    PhoneNorm     : string;
    PayDetails    : string;
    NoticeCheck   : string;
    FActionResult: TActionResult;
    FSendDone: Boolean;
    procedure ShowGets;
    procedure GetPaymentDetails(
                                USER         : integer;
                                CODE         : string;
                                Prefix       : string;
                                Order        : integer;
                                Pharm        : integer;
                                FullName     : string;
                                Sum          : string;
                                SignCheck    : boolean;
                                OrderName    : string;
                                var Details  : string;
                                var Check    : string
                               );
  public
    { Public declarations }
    procedure SetRecHeaderItem(Parm : TJSO_OrderHeaderItem);
    procedure SetRecSession(Parm : TUserSession);
    procedure SetSection(Parm : integer);
    function ShowDialog: TActionResult;
  end;

var
  frmCCJSO_ClientNotice_PayDetails: TfrmCCJSO_ClientNotice_PayDetails;

implementation

uses UMAIN, CCJSO_DM, ExDBGRID;

{$R *.dfm}

procedure TfrmCCJSO_ClientNotice_PayDetails.FormCreate(Sender: TObject);
begin
  { Инициализация }
  bSignActive := false;
  Section     := 0;
end;

procedure TfrmCCJSO_ClientNotice_PayDetails.FormActivate(Sender: TObject);
begin
  { Инициализация полей }
  case Section of
    cFSection_SiteApteka911: begin
      OrderPrefix                := RecHeaderItem.ExtSysPrefix;//DM_CCJSO.GetPrefNumbOrderApteka911;
      lblPharm.Visible           := false;
      edPharm.Visible            := false;
      edOrder.Text               := RecHeaderItem.SorderID;
      edPrefix.Text              := RecHeaderItem.ExtSysPrefix; //DM_CCJSO.GetPrefNumbOrderApteka911;
      edClient.Text              := RecHeaderItem.orderShipName;
      edOrderAmount.Text         := CurrToStrF(RecHeaderItem.orderAmount, ffFixed, 2);
      edOrderAmountShipping.Text := CurrToStrF(RecHeaderItem.NOrderAmountShipping, ffFixed, 2);
      edCoolantSum.Text          := CurrToStrF(RecHeaderItem.NCoolantSum, ffFixed, 2);
      edPhone.Text               := RecHeaderItem.orderPhone;
      edEMail.Text               := RecHeaderItem.orderEmail;
      edSUM.Text                 := CurrToStrF(RecHeaderItem.orderAmount + RecHeaderItem.NOrderAmountShipping + RecHeaderItem.NCoolantSum, ffFixed, 2);
      edShipping.Text            := RecHeaderItem.orderShipping;
      edPayment.Text             := RecHeaderItem.orderPayment;
      edOrderName.Text           := RecHeaderItem.orderName;
      GetPaymentDetails(
                        RecSession.CurrentUser,
                        DM_CCJSO.GetCodeDetailsPrePaymentCourier,
                        DM_CCJSO.GetPrefNumbOrderApteka911,
                        RecHeaderItem.orderID,
                        0,
                        RecHeaderItem.orderShipName,
                        edSUM.Text,
                        true,
                        RecHeaderItem.orderName,
                        PayDetails,
                        NoticeCheck
                       );
      edDetails.Text := PayDetails;
      if length(NoticeCheck) <> 0 then begin
        edCheck.Text := NoticeCheck;
      end else begin
        edCheck.Visible := false;
      end;
    end;
    cFSection_OrderClients: begin
    end;
  end;
  { Форма активна }
  bSignActive := true;
  ShowGets;
  edSUM.SetFocus;
end;

procedure TfrmCCJSO_ClientNotice_PayDetails.ShowGets;
begin
  if bSignActive then begin
    { Контроль на пустые строки }
    if length(trim(edSum.Text)) = 0 then edSum.Color := clYellow
                                    else edSum.Color := clWindow;
    if (length(trim(edPhone.Text)) = 0) and (length(trim(edEMAil.Text)) = 0) then begin
      edPhone.Color := clYellow;
      edEMAil.Color := clYellow;
    end else begin
      edPhone.Color := clWindow;
      edEMAil.Color := clWindow;
    end;
    { Управление доступом к выполнению }
    if    (
           (length(trim(edSum.Text)) = 0)
           or
           (
            (length(trim(edSum.Text)) > 0)
            and
            (not ufoTryStrToCurr(edSum.Text))
           )
          )
       or (
               (length(trim(edPhone.Text)) = 0)
           and (length(trim(edEMAil.Text)) = 0)
          )
    then aRegNotice.Enabled := false
    else aRegNotice.Enabled := true;
  end;
end;

procedure TfrmCCJSO_ClientNotice_PayDetails.SetRecHeaderItem(Parm : TJSO_OrderHeaderItem); begin RecHeaderItem := Parm; end;
procedure TfrmCCJSO_ClientNotice_PayDetails.SetRecSession(Parm : TUserSession); begin RecSession := Parm; end;
procedure TfrmCCJSO_ClientNotice_PayDetails.SetSection(Parm : integer); begin Section := Parm; end;

procedure TfrmCCJSO_ClientNotice_PayDetails.aExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmCCJSO_ClientNotice_PayDetails.aRegNoticeExecute(Sender: TObject);
var
  MsgDetails : string;
begin
  FSendDone := true;
  FActionResult.IErr := 0;
  FActionResult.ExecMsg := '';
  MsgDetails := '';
  if length(edPhone.Text) > 0 then MsgDetails := MsgDetails + 'СМС на телефон' + chr(10);
  if length(edEMail.Text) > 0 then MsgDetails := MsgDetails + 'на EMail' + chr(10);
  if MessageDLG('Подтвердите отправку реквизитов платежа'+chr(10)+MsgDetails,mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  try
    spPayDetails.Parameters.ParamValues['@USER']    := RecSession.CurrentUser;
    spPayDetails.Parameters.ParamValues['@Prefix']  := OrderPrefix;
    spPayDetails.Parameters.ParamValues['@Order']   := RecHeaderItem.orderID;
    spPayDetails.Parameters.ParamValues['@Pharm']   := 0;
    spPayDetails.Parameters.ParamValues['@Cash']    := StrToCurr(edSum.Text);
    spPayDetails.Parameters.ParamValues['@Phone']   := trim(edPhone.Text);
    spPayDetails.Parameters.ParamValues['@EMail']   := trim(edEMail.Text);
    spPayDetails.Parameters.ParamValues['@Details'] := PayDetails;
    spPayDetails.ExecProc;
    FActionResult.IErr := spPayDetails.Parameters.ParamValues['@RETURN_VALUE'];
    if FActionResult.IErr <> 0 then begin
      FActionResult.ExecMsg := spPayDetails.Parameters.ParamValues['@SErr'];
      ShowMessage(FActionResult.ExecMsg);
    end else self.Close;
  except
    on e:Exception do begin
      FActionResult.ExecMsg := e.Message;
      ShowMessage(FActionResult.ExecMsg);
    end;
  end;
end;

procedure TfrmCCJSO_ClientNotice_PayDetails.GetPaymentDetails(
                                                              USER         : integer;
                                                              CODE         : string;
                                                              Prefix       : string;
                                                              Order        : integer;
                                                              Pharm        : integer;
                                                              FullName     : string;
                                                              Sum          : string;
                                                              SignCheck    : boolean;
                                                              OrderName    : string;
                                                              var Details  : string;
                                                              var Check    : string
                                                             );
var
  IErr : integer;
  SErr : string;
begin
  IErr := 0;
  SErr := '';
  Details := '';
  Check   := '';
  try
    spGetPaymentDetails.Parameters.ParamValues['@USER']      := USER;
    spGetPaymentDetails.Parameters.ParamValues['@CODE']      := CODE;
    spGetPaymentDetails.Parameters.ParamValues['@Prefix']    := Prefix;
    spGetPaymentDetails.Parameters.ParamValues['@Order']     := Order;
    spGetPaymentDetails.Parameters.ParamValues['@Pharm']     := Pharm;
    spGetPaymentDetails.Parameters.ParamValues['@FullName']  := FullName;
    spGetPaymentDetails.Parameters.ParamValues['@Sum']       := Sum;
    spGetPaymentDetails.Parameters.ParamValues['@SignCheck'] := SignCheck;
    spGetPaymentDetails.Parameters.ParamValues['@OrderName'] := OrderName;
    spGetPaymentDetails.ExecProc;
    IErr := spGetPaymentDetails.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      Details := spGetPaymentDetails.Parameters.ParamValues['@Details'];
      Check   := spGetPaymentDetails.Parameters.ParamValues['@Check'];
    end else begin
      SErr := spGetPaymentDetails.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
      ShowMessage('Сбой при получении шаблона реквизитов платежа.' + chr(10)+SErr);
    end;
  end;
end;

procedure TfrmCCJSO_ClientNotice_PayDetails.aChangeExecute(Sender: TObject);
var
  NameComponent : string;
  TextOld       : string;
  TextNew       : string;
  SignTry       : boolean;
begin
  NameComponent := (Sender as TEdit).Name;
  TextOld       := (Sender as TEdit).Text;
  TextNew       := TextOld;
  SignTry       := false;
  if NameComponent = 'edSum' then begin
    (Sender as TEdit).Font.Color := clWindowText;
    if not ufoTryStrToCurr(TextOld) then begin
      { Выполняем детальный анализ и пытаемся откорректировать точку или запятую }
      upoTryStrToCurr(TextNew);
      if TextOld <> TextNew then begin
        (Sender as TEdit).Text := TextNew;
        (Sender as TEdit).SelLength:=0;
        (Sender as TEdit).SelLength := length((Sender as TEdit).Text);
      end else begin
        SignTry := true;
        (Sender as TEdit).Font.Color := clRed;
      end;
    end;
    if not SignTry then begin
      GetPaymentDetails(
                        RecSession.CurrentUser,
                        DM_CCJSO.GetCodeDetailsPrePaymentCourier,
                        DM_CCJSO.GetPrefNumbOrderApteka911,
                        RecHeaderItem.orderID,
                        0,
                        RecHeaderItem.orderShipName,
                        edSUM.Text,
                        false,
                        RecHeaderItem.orderName,
                        PayDetails,
                        NoticeCheck
                       );
      edDetails.Text := PayDetails;
    end;

  end else if NameComponent = 'edPhone' then begin
    {--}
  end else if NameComponent = 'edEMail' then begin
    {--}
  end;
  ShowGets;
end;

function TfrmCCJSO_ClientNotice_PayDetails.ShowDialog: TActionResult;
begin
  FSendDone := false;
  ShowModal;
  if not FSendDone then
  begin
    Result.IErr := -100;
    Result.ExecMsg := 'Операция отменена пользователем';
  end
  else
  begin
    Result.IErr := FActionResult.IErr;
    Result.ExecMsg := FActionResult.ExecMsg;
  end;
end;

end.
