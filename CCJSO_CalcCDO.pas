unit CCJSO_CalcCDO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UCCenterJournalNetZkz, ActnList, ExtCtrls, ToolWin, ComCtrls,
  StdCtrls;

type
  TfrmCCJSO_CalcCDO = class(TForm)
    pnlControl: TPanel;
    pnlVal: TPanel;
    pnlVal_RuleShow: TPanel;
    pnlVal_Fields: TPanel;
    pnlControl_Tool: TPanel;
    pnlControl_Show: TPanel;
    aList: TActionList;
    aExit: TAction;
    aExec: TAction;
    tBarControl: TToolBar;
    tbtbExec: TToolButton;
    tbtnExit: TToolButton;
    lblPlanOrderAmount: TLabel;
    lblCalcOrderAmount: TLabel;
    lblOrderAmountCOD: TLabel;
    edPlanOrderAmount: TEdit;
    edCalcOrderAmount: TEdit;
    edOrderAmountCOD: TEdit;
    aChangeEdit: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aExecExecute(Sender: TObject);
    procedure aChangeEditExecute(Sender: TObject);
  private
    { Private declarations }
    bSignActive    : boolean;
    bSignExec      : boolean;
    RecSession     : TUserSession;
    RecHeaderItem  : TJSO_OrderHeaderItem;
    COD            : currency;
    RuleCOD        : string;
    procedure ShowGets;
  public
    { Public declarations }
    procedure SetRecHeaderItem(Parm : TJSO_OrderHeaderItem);
    procedure SetRecSession(Parm : TUserSession);
    function  GetSignExec : boolean;
    function  GetCOD : currency;
  end;

var
  frmCCJSO_CalcCDO: TfrmCCJSO_CalcCDO;

implementation

uses UMAIN, ExDBGRID, CCJSO_DM;

{$R *.dfm}

procedure TfrmCCJSO_CalcCDO.FormCreate(Sender: TObject);
begin
  { Инициализация }
  bSignActive := false;
  bSignExec   := false;
end;

procedure TfrmCCJSO_CalcCDO.FormActivate(Sender: TObject);
begin
  if not bSignActive then begin
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(332,self.Icon);
    { Инициализация полей }
    edPlanOrderAmount.Text := CurrToStr(RecHeaderItem.orderAmount);
    edCalcOrderAmount.Text := CurrToStr(RecHeaderItem.orderAmount);
    { Форма активна }
    bSignActive := true;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_CalcCDO.ShowGets;
begin
  if bSignActive then begin
    { Управление доступом }
    if length(trim(edCalcOrderAmount.Text)) = 0 then edCalcOrderAmount.Color := clYellow
                                                else edCalcOrderAmount.Color := clWindow;
    if length(trim(edOrderAmountCOD.Text)) = 0 then edOrderAmountCOD.Color := clYellow
                                               else edOrderAmountCOD.Color := clWindow;
    if    (not ufoTryStrToCurr(edCalcOrderAmount.Text))
       or (not ufoTryStrToCurr(edOrderAmountCOD.Text))
       or (length(trim(edCalcOrderAmount.Text)) = 0)
       or (length(trim(edOrderAmountCOD.Text)) = 0)
    then aExec.Enabled := false
    else aExec.Enabled := true;
  end;
end;

procedure TfrmCCJSO_CalcCDO.SetRecHeaderItem(Parm : TJSO_OrderHeaderItem); begin RecHeaderItem := Parm; end;
procedure TfrmCCJSO_CalcCDO.SetRecSession(Parm : TUserSession); begin RecSession := Parm; end;
function  TfrmCCJSO_CalcCDO.GetSignExec : boolean; begin result := bSignExec; end;
function  TfrmCCJSO_CalcCDO.GetCOD : currency; begin result := COD; end;

procedure TfrmCCJSO_CalcCDO.aExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmCCJSO_CalcCDO.aExecExecute(Sender: TObject);
begin
  bSignExec := true;
  COD       := StrToCurr(edOrderAmountCOD.Text);
  Self.Close;
end;

procedure TfrmCCJSO_CalcCDO.aChangeEditExecute(Sender: TObject);
var
  NameComponent : string;
  TextOld       : string;
  TextNew       : string;
  SignTry       : boolean;
  IErr          : integer;
  SErr          : string;
begin
  if Sender is TEdit then begin
    NameComponent := (Sender as TEdit).Name;
    TextOld       := (Sender as TEdit).Text;
    TextNew       := TextOld;
    SignTry       := false;
    if NameComponent = 'edCalcOrderAmount' then begin
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
    end;
    if ufoTryStrToCurr(edCalcOrderAmount.Text) and (length(trim(edCalcOrderAmount.Text)) <> 0) then begin
       DM_CCJSO.CalcCDO(RecSession.CurrentUser,StrToCurr(edCalcOrderAmount.Text),COD,RuleCOD,IErr,SErr);
       if IErr = 0 then begin
         edOrderAmountCOD.Text := CurrToStr(COD);
         pnlVal_RuleShow.Caption := RuleCOD;
       end else begin
         edOrderAmountCOD.Text := '';
       end;
    end else begin
      edOrderAmountCOD.Text := '';
    end;
  end; { if Sender is TEdit then begin }
  ShowGets;
end;

end.
