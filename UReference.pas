unit UReference;
{
  � PgkSoft 12.11.2014
  ������ �������. �����������.
  �������, �����, �����, �����.
  ��������� �������� (��������).
  27.08.2015 ������������
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, StdCtrls, ToolWin, ComCtrls, ActnList,
  Menus, DB, ADODB;

type
  TfrmReference = class(TForm)
    pnlMain: TPanel;
    pnlControl: TPanel;
    pnlGrid: TPanel;
    DBGrid: TDBGrid;
    pnlMain_Show: TPanel;
    pnlMain_Tool: TPanel;
    pnlControl_Tool: TPanel;
    pnlControl_Show: TPanel;
    pnlTop: TPanel;
    grbxCondition: TGroupBox;
    lblCondName: TLabel;
    edCndName: TEdit;
    tlbarMain: TToolBar;
    aMain: TActionList;
    aMain_Add: TAction;
    aMain_Edit: TAction;
    aMain_Del: TAction;
    aControl_Select: TAction;
    aControl_Exit: TAction;
    tlbarControl: TToolBar;
    tlbtnMain_Insert: TToolButton;
    tlbtnMain_Update: TToolButton;
    tlbtnMain_Delete: TToolButton;
    tlbtnControl_OK: TToolButton;
    tlbtnControl_Exit: TToolButton;
    pmMain: TPopupMenu;
    pmiMain_Add: TMenuItem;
    pmiMain_Edit: TMenuItem;
    pmiMain_Del: TMenuItem;
    pmiMain_delemiter: TMenuItem;
    pmiControl_Select: TMenuItem;
    pmiControl_Exit: TMenuItem;
    dsReference: TDataSource;
    qrspOblast: TADOStoredProc;
    qrspRayon: TADOStoredProc;
    qrspTown: TADOStoredProc;
    qrspStreet: TADOStoredProc;
    qrspActionFoundation: TADOStoredProc;
    spReferenceDelete: TADOStoredProc;
    qrspDrivers: TADOStoredProc;
    qrspOrderStatus: TADOStoredProc;
    qrspUserActions: TADOStoredProc;
    pnlCondition: TPanel;
    toolbarCondition: TToolBar;
    btnCondition: TToolButton;
    aCondition: TAction;
    aClearCondition: TAction;
    btnClearCondition: TToolButton;
    qrspRefShipping: TADOStoredProc;
    qrspRefShipName: TADOStoredProc;
    qrspRefPhoneClient: TADOStoredProc;
    qrspRefAdresClient: TADOStoredProc;
    qrspRefPharmacy: TADOStoredProc;
    pnlLocate: TPanel;
    qrspDicGroupParm: TADOStoredProc;
    qrspJRMOUserActions: TADOStoredProc;
    qrspRefBirdUser: TADOStoredProc;
    spRefAlertType: TADOStoredProc;
    spRefAlertUserType: TADOStoredProc;
    qrspJSOAutoRefCity: TADOStoredProc;
    qrspNPostfDocumentStatuses: TADOStoredProc;
    qrspRefPayment: TADOStoredProc;
    qrspUserGamma: TADOStoredProc;
    qrspJOPHUserActions: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aMain_AddExecute(Sender: TObject);
    procedure aMain_EditExecute(Sender: TObject);
    procedure aMain_DelExecute(Sender: TObject);
    procedure aControl_SelectExecute(Sender: TObject);
    procedure aControl_ExitExecute(Sender: TObject);
    procedure edCndNameChange(Sender: TObject);
    procedure aConditionExecute(Sender: TObject);
    procedure aClearConditionExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    ISign_Activate               : integer;
    ScreenPos                    : TPoint;
    SignPos                      : string;
    USER                         : integer;
    ModeOperation                : integer;  { ����� ������ }
    ModeReadOnly                 : integer;  { ������ ������: 0 - ��������� (�� ���������), 1 - �������� }
    ReferenceIndex               : integer;  { ����� ���������� ������������ }
    SignLargeDataSet             : smallint; { ������� ������ � ������� ������� ������ }
    SignSlaveSection             : smallint; { ������� ������������ �������. ����� �������������� PRN }
    SignUserBirdAvaExcludCurrent : smallint; { ������� ��� ������ ������ - ����������� �����: �������� �������� ������������ }
    PRN                          : integer;  { ������ �� ������������ ������� }
    OrderShipping                : string;   { ��� �������� }
    OrderPayment                 : string;   { ��� �������� }
    Order                        : integer;
    qrspADO                      : TADOStoredProc;
    DescrSelect                  : string;
    RowIDSelect                  : integer;
    LocateName                   : string;
    procedure ShowGets;
    procedure ExecCondition(QRSP : TADOStoredProc);
    procedure CreateCondition(QRSP : TADOStoredProc);
  public
    { Public declarations }
    procedure SetMode(Mode : integer);
    procedure SetReferenceIndex(Index : integer);
    procedure SetReadOnly( Mode : integer );
    procedure SetSignLargeDataSet(SignLargeDS : smallint);
    procedure SetSignSlaveSection(SignSlave : smallint);
    procedure SetPRN(NPRN : integer);
    procedure SetOrderShipping(Parm : string);
    procedure SetOrderPayment(Parm : string);
    procedure SetOrder(Parm : integer);
    procedure SetSignUserBirdAvaExcludCurrent(Parm : smallint);
    procedure SetUser(Parm : integer);
    procedure SetScreenPos(Parm : TPoint);
    procedure SetSignPos(Parm : string);
    function  GetMode : integer;
    function  GetReadOnly : integer;
    function  GetReferenceIndex : integer;
    function  GetDescrSelect : string;
    function  GetRowIDSelect : integer;
  end;

const
  cFReferenceModeShow    = 0; { ����� ������: �������� }
  cFReferenceModeSelect  = 1; { ����� ������: ����� }
  cFReferenceYesReadOnly = 1; { ����� ������ ������ ������ }
  cFReferenceNoReadOnly  = 0; { ����� ������ �������������� }
  cFReferenceSignSmallDS = 0; { ��������� ����� ������ }
  cFReferenceSignLargeDS = 1; { ������� ����� ������ }
  cFRefSignPos_Left      = 'Left';
  cFRefSignPos_Right     = 'Right';
  { ������� ������������ }
  cFReferenceOblast           = 1;
  cFReferenceRayon            = 2;
  cFReferenceTown             = 3;
  cFReferenceStreet           = 4;
  cFReferenceActionFoundation = 5;
  cFReferenceDrivers          = 6;
  cFReferenceOrderStatus      = 7;
  cFReferenceJSOUserActions   = 8;
  cFRefGenAutoShipping        = 9;  { ��� �������� ��������-������ }
  cFReferencePharmacy         = 10;
  cFRefGenAutoShipName        = 11; { ������ ��������-������ }
  cFRefGenAutoPhoneClient     = 12; { ������� ������� ��������-������ }
  cFRefGenAutoAdresClient     = 14; { ����� ������� ��������-������ }
  cFDicGroupPharm             = 15; { ������ ����� (�������� �����) }
  cFReferenceJRMOUserActions  = 16;
  cFReferenceUserBirdAva      = 17;
  cFReferenceUserAva          = 10017;
  cFRefAlertType              = 18; { ���� ����������� }
  cFRefAlertUserType          = 19; { ���� ���������������� ����������� (����) }
  cFJSOAutoRefCity            = 20; { ������ � �������� ������� }
  cFNPostRefDocumentStatuses  = 21; { ����� ����� - ������� �� }
  cFRefPayment                = 22; { ���� ������ }
  cFReferenceUserGamma        = 23; { ��������� ����������� }
  cFRefJOPHUserActions        = 24;

var
  frmReference: TfrmReference;

implementation

uses
  Types, Util,
  UMain, UCCenterJournalNetZkz, UReferenceCreate;
{$R *.dfm}

Const
  cOrderShipping_ArmorPharmacy = '����� � ������';
  cOrderShipping_PickupPharmacy = '���������';

procedure TfrmReference.ShowGets;
begin
  if ISign_Activate = 1 then begin
    { ���������� ���������� ��������� ����� }
    pnlMain_Show.Caption := VarToStr(qrspADO.RecordCount);
    { ������ � ��������� ���������� }
    if DBGrid.DataSource.DataSet.IsEmpty then begin
      if GetReadOnly = cFReferenceNoReadOnly then begin
        aMain_Edit.Enabled := false;
      end;
      aControl_Select.Enabled := false;
    end else begin
      if GetReadOnly = cFReferenceNoReadOnly then begin
        aMain_Edit.Enabled := true;
      end;
      aControl_Select.Enabled := true;
    end;
    { ������� ������ ������ }
    if SignLargeDataSet = 1 then begin
      if length(trim(edCndName.Text)) > 0 then begin
        aCondition.Enabled := true;
        aClearCondition.Enabled := true;
      end else begin
        aCondition.Enabled := false;
        aClearCondition.Enabled := false;
      end;
    end;
  end;
end;

procedure TfrmReference.FormCreate(Sender: TObject);
begin
  ISign_Activate               := 0;
  ModeReadOnly                 := cFReferenceNoReadOnly;
  RowIDSelect                  := 0;
  DescrSelect                  := '';
  SignLargeDataSet             := 0;
  SignSlaveSection             := 0;
  PRN                          := 0;
  pnlLocate.Visible            := false;
  LocateName                   := '';
  OrderShipping                := '';
  OrderPayment                 := '';
  Order                        := 0;
  SignUserBirdAvaExcludCurrent := 0;
  USER                         := 0;
  ScreenPos                    := Point(0,0);
  SignPos                      := cFRefSignPos_Right;
end;

procedure TfrmReference.FormActivate(Sender: TObject);
begin
  if ISign_Activate = 0 then begin
    if SignLargeDataSet = 0 then begin
      pnlCondition.Visible := false;
    end;
    { ����������� ���������������� ���� }
    if (ScreenPos.X <> 0) or (ScreenPos.Y <> 0) then begin
      if SignPos = cFRefSignPos_Right then begin
        self.Left := ScreenPos.X - self.Width + 20;
        self.Top  := ScreenPos.Y + 10;
      end else if SignPos = cFRefSignPos_Left then begin
        self.Left := ScreenPos.X;
        self.Top  := ScreenPos.Y;
      end;
    end;
    { �������� �� ���������������� ��� �������� }
    if     (ReferenceIndex = cFReferenceOrderStatus)
       and (length(OrderShipping) > 0)
       and (
            (OrderShipping = cOrderShipping_ArmorPharmacy)
            or
            (OrderShipping = cOrderShipping_PickupPharmacy)
           ) then begin
      ModeReadOnly := cFReferenceYesReadOnly;
    end;
    ISign_Activate := 1;
    { ���������� �������� � �������� ������ }
    if GetMode = cFReferenceModeShow then begin
      aControl_Select.Visible := false;
      pnlControl.Visible := false;
    end;
    { ���������� �������� ��� ������ ������ ������ }
    if GetReadOnly = cFReferenceYesReadOnly then begin
      aMain_Add.Enabled  := false;
      aMain_Edit.Enabled := false;
      aMain_Del.Enabled  := false;
    end;
    { ����������� ����� ������ }
    case GetReferenceIndex of
      cFReferenceOblast: begin
        self.Caption := '�������';
        dsReference.DataSet := qrspOblast;
        qrspADO := qrspOblast;
        ExecCondition(qrspADO);
      end;
      cFReferenceRayon : begin
        self.Caption := '������';
        dsReference.DataSet := qrspRayon;
        qrspADO := qrspRayon;
        ExecCondition(qrspADO);
      end;
      cFReferenceTown  : begin
        self.Caption := '������';
        dsReference.DataSet := qrspTown;
        qrspADO := qrspTown;
        ExecCondition(qrspADO);
      end;
      cFReferenceStreet: begin
        self.Caption := '�����';
        dsReference.DataSet := qrspStreet;
        qrspADO := qrspStreet;
        ExecCondition(qrspADO);
      end;
      cFReferenceActionFoundation: begin
        self.Caption := '��������� �������� (��������)';
        dsReference.DataSet := qrspActionFoundation;
        qrspADO := qrspActionFoundation;
        ExecCondition(qrspADO);
      end;
      cFReferenceDrivers: begin
        self.Caption := '��������';
        dsReference.DataSet := qrspDrivers;
        qrspADO := qrspDrivers;
        ExecCondition(qrspADO);
      end;
      cFReferenceOrderStatus: begin
        self.Caption := '������ ������';
        dsReference.DataSet := qrspOrderStatus;
        qrspADO := qrspOrderStatus;
        ExecCondition(qrspADO);
      end;
      cFReferenceJSOUserActions: begin
        self.Caption := '���������������� ��������';
        dsReference.DataSet := qrspUserActions;
        qrspADO := qrspUserActions;
        ExecCondition(qrspADO);
      end;
      cFRefGenAutoShipping: begin
        self.Caption := '���� ��������';
        dsReference.DataSet := qrspRefShipping;
        qrspADO := qrspRefShipping;
        ExecCondition(qrspADO);
      end;
      cFRefGenAutoShipName: begin
        self.Caption := '�������';
        dsReference.DataSet := qrspRefShipName;
        qrspADO := qrspRefShipName;
        ExecCondition(qrspADO);
      end;
      cFRefGenAutoPhoneClient: begin
        self.Caption := '��������';
        dsReference.DataSet := qrspRefPhoneClient;
        qrspADO := qrspRefPhoneClient;
        ExecCondition(qrspADO);
      end;
      cFRefGenAutoAdresClient: begin
        self.Caption := '�����';
        dsReference.DataSet := qrspRefAdresClient;
        qrspADO := qrspRefAdresClient;
        ExecCondition(qrspADO);
      end;
      cFReferencePharmacy: begin
        self.Caption := '������';
        dsReference.DataSet := qrspRefPharmacy;
        qrspADO := qrspRefPharmacy;
        ExecCondition(qrspADO);
      end;
      cFDicGroupPharm: begin
        self.Caption := '������ �����';
        dsReference.DataSet := qrspDicGroupParm;
        qrspADO := qrspDicGroupParm;
        ExecCondition(qrspADO);
      end;
      cFReferenceJRMOUserActions: begin
        self.Caption := '���������������� ��������';
        dsReference.DataSet := qrspJRMOUserActions;
        qrspADO := qrspJRMOUserActions;
        ExecCondition(qrspADO);
      end;
      cFReferenceUserBirdAva: begin
        self.Caption := '������������';
        dsReference.DataSet := qrspRefBirdUser;
        qrspADO := qrspRefBirdUser;
        ExecCondition(qrspADO);
      end;
      cFReferenceUserAva: begin
        self.Caption := '������������';
        dsReference.DataSet := qrspRefBirdUser;
        qrspADO := qrspRefBirdUser;
        ExecCondition(qrspADO);
      end;
      cFRefAlertType: begin
        self.Caption := '���� �����������';
        dsReference.DataSet := spRefAlertType;
        qrspADO := spRefAlertType;
        ExecCondition(qrspADO);
      end;
      cFRefAlertUserType: begin
        self.Caption := '���� ���������������� �����������';
        dsReference.DataSet := spRefAlertUserType;
        qrspADO := spRefAlertUserType;
        ExecCondition(qrspADO);
      end;
      cFJSOAutoRefCity: begin
        self.Caption := '������ (�������� ������)';
        dsReference.DataSet := qrspJSOAutoRefCity;
        qrspADO := qrspJSOAutoRefCity;
        ExecCondition(qrspADO);
      end;
      cFNPostRefDocumentStatuses: begin
        self.Caption := '������� ��������-���������';
        dsReference.DataSet := qrspNPostfDocumentStatuses;
        qrspADO := qrspNPostfDocumentStatuses;
        ExecCondition(qrspADO);
      end;
      cFRefPayment: begin
        self.Caption := '���� ������';
        dsReference.DataSet := qrspRefPayment;
        qrspADO := qrspRefPayment;
        ExecCondition(qrspADO);
      end;
      cFReferenceUserGamma: begin
        self.Caption := '��������� ������������';
        dsReference.DataSet := qrspUserGamma;
        qrspADO := qrspUserGamma;
        ExecCondition(qrspADO);
      end;
      cFRefJOPHUserActions: begin
        self.Caption := '���������������� ��������';
        dsReference.DataSet := qrspJOPHUserActions;
        qrspADO := qrspJOPHUserActions;
        ExecCondition(qrspADO);
      end;
    end;
  end;
end;

procedure TfrmReference.ExecCondition(QRSP : TADOStoredProc);
var
  RNOrderID: Integer;
begin
  if not QRSP.IsEmpty then RNOrderID := QRSP.FieldByName('row_id').AsInteger else RNOrderID := -1;
  if QRSP.Active then QRSP.Active := false;
  CreateCondition(QRSP);
  QRSP.Active := true;
  QRSP.Locate('row_id', RNOrderID, []);
  ShowGets;
end;

procedure TfrmReference.CreateCondition(QRSP : TADOStoredProc);
var
  Descr : string;
begin
  if length(trim(edCndName.Text)) = 0 then Descr  := '' else Descr  := edCndName.Text;
  QRSP.Parameters.ParamValues['@Descr'] := Descr;
  if    (ReferenceIndex = cFReferenceOrderStatus) then begin
    QRSP.Parameters.ParamValues['@OrderShipping'] := OrderShipping;
    QRSP.Parameters.ParamValues['@OrderPayment']  := OrderPayment;
    QRSP.Parameters.ParamValues['@Order']         := Order;
    QRSP.Parameters.ParamValues['@User']          := USER;
  end;
  if SignSlaveSection = 1 then QRSP.Parameters.ParamValues['@PRN'] := PRN;
  if (ReferenceIndex = cFReferenceUserBirdAva) then begin
    QRSP.Parameters.ParamValues['@SignExcludCurrent'] := SignUserBirdAvaExcludCurrent;
    QRSP.Parameters.ParamValues['@CurrentUser']       := User;
  end;
end;

procedure TfrmReference.SetReadOnly( Mode : integer ); begin ModeReadOnly := Mode; end;
procedure TfrmReference.SetMode(Mode : integer); begin ModeOperation := Mode; end;
procedure TfrmReference.SetReferenceIndex(Index : integer); begin ReferenceIndex := Index; end;
procedure TfrmReference.SetSignLargeDataSet(SignLargeDS : smallint); begin SignLargeDataSet := SignLargeDS; end;
procedure TfrmReference.SetPRN(NPRN : integer); begin PRN := NPRN; end;
procedure TfrmReference.SetSignSlaveSection(SignSlave : smallint); begin SignSlaveSection := SignSlave; end;
procedure TfrmReference.SetOrderShipping(Parm : string); begin OrderShipping := Parm; end;
procedure TfrmReference.SetOrderPayment(Parm : string);  begin OrderPayment := Parm; end;
procedure TfrmReference.SetOrder(Parm : integer); begin Order := Parm; end;
procedure TfrmReference.SetSignUserBirdAvaExcludCurrent(Parm : smallint); begin SignUserBirdAvaExcludCurrent := Parm; end;
procedure TfrmReference.SetUser(Parm : integer); begin USER := Parm; end;
procedure TfrmReference.SetScreenPos(Parm : TPoint); begin ScreenPos := Parm; end;
procedure TfrmReference.SetSignPos(Parm : string); begin SignPos := Parm; end;

function TfrmReference.GetMode : integer; begin result := ModeOperation; end;
function TfrmReference.GetReadOnly : integer; begin result := ModeReadOnly; end;
function TfrmReference.GetReferenceIndex : integer; begin result := ReferenceIndex; end;
function TfrmReference.GetDescrSelect : string; begin result := DescrSelect; end;
function TfrmReference.GetRowIDSelect : integer; begin result := RowIDSelect; end;

procedure TfrmReference.aMain_AddExecute(Sender: TObject);
begin
  try
   frmReferenceCreate := TfrmReferenceCreate.Create(Self);
   frmReferenceCreate.SetReferenceIndex(ReferenceIndex);
   frmReferenceCreate.SetMode(cReferenceInsert);
   frmReferenceCreate.SetFormCaption(self.Caption);
   try
    frmReferenceCreate.ShowModal;
   finally
    frmReferenceCreate.Free;
   end;
  except
  end;
  ExecCondition(qrspADO);
end;

procedure TfrmReference.aMain_EditExecute(Sender: TObject);
begin
  try
   frmReferenceCreate := TfrmReferenceCreate.Create(Self);
   frmReferenceCreate.SetReferenceIndex(ReferenceIndex);
   frmReferenceCreate.SetMode(cReferenceUpdate);
   frmReferenceCreate.SetRN(DBGrid.DataSource.DataSet.FieldByName('row_id').AsInteger);
   frmReferenceCreate.SetDescUpdate(DBGrid.DataSource.DataSet.FieldByName('Descr').AsString);
   frmReferenceCreate.SetFormCaption(self.Caption);
   try
    frmReferenceCreate.ShowModal;
   finally
    frmReferenceCreate.Free;
   end;
  except
  end;
  ExecCondition(qrspADO);
end;

procedure TfrmReference.aMain_DelExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if MessageDLG('����������� ���������� ��������',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  try
    spReferenceDelete.Parameters.ParamValues['@RefIndex'] := ReferenceIndex;
    spReferenceDelete.Parameters.ParamValues['@NRN'] := DBGrid.DataSource.DataSet.FieldByName('row_id').AsInteger;
    spReferenceDelete.ExecProc;
    IErr := spReferenceDelete.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
      ExecCondition(qrspADO);
    end else begin
      if IErr = 547
        then SErr := '�������� ����������. ������ ��� ������������'
        else SErr := spReferenceDelete.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  except
    on e:Exception do
      begin
        ShowMessage(e.Message);
      end;
  end;
end;

procedure TfrmReference.aControl_SelectExecute(Sender: TObject);
begin
  DescrSelect := DBGrid.DataSource.DataSet.FieldByName('Descr').AsString;
  RowIDSelect := DBGrid.DataSource.DataSet.FieldByName('row_id').AsInteger;
  self.Close;
end;

procedure TfrmReference.aControl_ExitExecute(Sender: TObject);
begin
  DescrSelect := '';
  self.Close;
end;

procedure TfrmReference.edCndNameChange(Sender: TObject);
begin
  if SignLargeDataSet = 0
    then ExecCondition(qrspADO)
    else ShowGets;
end;

procedure TfrmReference.aConditionExecute(Sender: TObject);
begin
  ExecCondition(qrspADO);
end;

procedure TfrmReference.aClearConditionExecute(Sender: TObject);
begin
  edCndName.Text := '';
  ExecCondition(qrspADO);
end;

procedure TfrmReference.FormResize(Sender: TObject);
begin
  { ���������� ����� ������� }
  self.DBGrid.Columns[0].Width := self.DBGrid.Width - 20;
end;

procedure TfrmReference.DBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key in [27,37,38,39,40,13] then begin
    LocateName := '';
    pnlLocate.Visible := false;
  end;
end;

procedure TfrmReference.DBGridKeyPress(Sender: TObject; var Key: Char);
var
  S : String;
begin
  S := AnsiUpperCase(LocateName + Key);
  if DBGrid.DataSource.DataSet.Locate('descr',AnsiLowerCase(S),[loCaseInsensitive,loPartialKey]) then begin
    LocateName := S;
    pnlLocate.Width := TextPixWidth(LocateName, pnlLocate.Font) + 40;
    pnlLocate.Caption := LocateName;
    pnlLocate.Left := DBGrid.Width - pnlLocate.Width - 30;
    pnlLocate.Visible := true;
  end;
end;

end.
