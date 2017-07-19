unit CCJSO_RefStatusSequence;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  UCCenterJournalNetZkz, ExtCtrls, ComCtrls, ActnList, Grids, DBGrids,
  ToolWin, DB, ADODB, Menus;

type
  PItemRec = ^ItemRec;
  ItemRec = record
    NRN         : integer;
    NPRN        : integer;
    NStatus     : integer;
    SStatus     : string;
    NParentRN   : integer;
    BSignUse    : boolean;
    SSignUse    : string;
    SChangeDate : string;
    Level       : integer;
  end;

type
  TfrmCCJSO_RefStatusSequence = class(TForm)
    pnlHier: TPanel;
    pnlStatus: TPanel;
    stBarMain: TStatusBar;
    splitHier: TSplitter;
    pnlRef: TPanel;
    pnlRefMain: TPanel;
    splitRefMain: TSplitter;
    pnlRefSlave: TPanel;
    pnlHierControl: TPanel;
    pnlHierTree: TPanel;
    pnlRefMainControl: TPanel;
    pnlRefMainGrid: TPanel;
    pnlRefSlaveControl: TPanel;
    pnlpnlRefSlaveGrid: TPanel;
    aList: TActionList;
    aMainAdd: TAction;
    aMainEdit: TAction;
    aMainDel: TAction;
    aMainMulti: TAction;
    aSlaveAdd: TAction;
    aSlaveEdit: TAction;
    aSlaveDel: TAction;
    aSlaveMulti: TAction;
    aHierAdd: TAction;
    aHierEdit: TAction;
    aHierDel: TAction;
    aHierMulti: TAction;
    pnlHierControl_Show: TPanel;
    pnlHierControl_Tool: TPanel;
    pnlRefMainControl_Show: TPanel;
    pnlRefMainControl_Tool: TPanel;
    pnlRefSlaveControl_Show: TPanel;
    pnlRefSlaveControl_Tool: TPanel;
    MainGrid: TDBGrid;
    SlaveGrid: TDBGrid;
    tbarMain: TToolBar;
    tbtnMain_Add: TToolButton;
    tbtnMain_Multi: TToolButton;
    tbtnMain_Edit: TToolButton;
    tbtnMain_Del: TToolButton;
    tbarSlave: TToolBar;
    tbtnSlave_Add: TToolButton;
    tbtnSlave_Multi: TToolButton;
    tbtnSlave_Edit: TToolButton;
    tbtnSlave_Del: TToolButton;
    tbarHier: TToolBar;
    tbtnHier_Add: TToolButton;
    tbtnHier_Multi: TToolButton;
    tbtnHier_Edit: TToolButton;
    tbtnHier_Del: TToolButton;
    aExit: TAction;
    trvStatusSeq: TTreeView;
    qrspMain: TADOStoredProc;
    dsMain: TDataSource;
    qrspSlave: TADOStoredProc;
    dsSlave: TDataSource;
    spMainDel: TADOStoredProc;
    pmMain: TPopupMenu;
    pmiMain_Add: TMenuItem;
    pmiMain_Multi: TMenuItem;
    pmiMain_Edit: TMenuItem;
    pmiMain_Del: TMenuItem;
    pnlStatusControl: TPanel;
    pnlStatusControl_Tool: TPanel;
    pnlStatusControl_Show: TPanel;
    aSelect: TAction;
    tbarControl: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    qrspHier: TADOStoredProc;
    spHier_Insert: TADOStoredProc;
    pmHier: TPopupMenu;
    pmiHier_Add: TMenuItem;
    pmiHier_Multi: TMenuItem;
    pmiHier_Edit: TMenuItem;
    pmiHier_Del: TMenuItem;
    pmSlave: TPopupMenu;
    pmiSlave_Add: TMenuItem;
    pmiSlave_Multi: TMenuItem;
    pmiSlave_Edit: TMenuItem;
    pmiSlave_Del: TMenuItem;
    spHier_Del: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure splitHierMoved(Sender: TObject);
    procedure splitRefMainMoved(Sender: TObject);
    procedure aMainAddExecute(Sender: TObject);
    procedure aMainEditExecute(Sender: TObject);
    procedure aMainMultiExecute(Sender: TObject);
    procedure aSlaveAddExecute(Sender: TObject);
    procedure aSlaveEditExecute(Sender: TObject);
    procedure aSlaveDelExecute(Sender: TObject);
    procedure aSlaveMultiExecute(Sender: TObject);
    procedure aHierAddExecute(Sender: TObject);
    procedure aHierEditExecute(Sender: TObject);
    procedure aHierDelExecute(Sender: TObject);
    procedure aHierMultiExecute(Sender: TObject);
    procedure MainGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aMainDelExecute(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure trvStatusSeqChange(Sender: TObject; Node: TTreeNode);
    procedure SlaveGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dsMainDataChange(Sender: TObject; Field: TField);
    procedure trvStatusSeqClick(Sender: TObject);
    procedure MainGridMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure SlaveGridMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure tbarMainMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure tbarSlaveMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure MainGridDblClick(Sender: TObject);
    procedure trvStatusSeqCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure aSelectExecute(Sender: TObject);
    procedure trvStatusSeqAdvancedCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
  private
    { Private declarations }
    bSignActive     : boolean;
    Mode            : integer;
    RecSession      : TUserSession;
    KoefPnlHierLeft : real;
    KoefPnlRefMain  : real;
    procedure ShowGets;
    procedure ShowResize;
    procedure RecalcResize;
    procedure SetKoefPnlHierLeft;
    procedure SetKoefPnlRefMain;
    procedure ExecConditionQRMain;
    procedure CreateConditionQRMain;
    procedure RefreshQRMain;
    procedure ExecConditionQRSlave;
    procedure CreateConditionQRSlave;
    procedure MainCreate(Mode : integer);
    procedure SaveMainRec;
    procedure CreateAllHier;
    procedure RefSeqStatusSp_Insert(USER : integer; PRN : integer; OrderStatus : string; ParentRN : integer; var IErr : integer; var SErr : string);
    procedure HierInsert;
    procedure RefSeqStatusSp_Delete(USER : integer; RN : integer; var IErr : integer; var SErr : string);
    procedure HierDelete(RN : integer);
    function GetKoefPnlHierLeft : real;
    function GetKoefPnlRefMain : real;
    function GetParentNodeFromData(ParentRN : integer; PRN : integer) : TTreeNode;
    function GetStatus : string;
  public
    { Public declarations }
    procedure SetRecSession(Parm : TUserSession);
    procedure SetMode(Parm : integer);
    function  GetSelectedMainRN : integer;
    function  GetSelectedMainName : string;
  end;

const
  cRefStatusSeqMode_Show = 0;
  cRefStatusSeqMode_Select = 1;

var
  frmCCJSO_RefStatusSequence: TfrmCCJSO_RefStatusSequence;

implementation

uses
  UMAIN, Util, CCJSO_RefStatusSequence_Create, CCJSO_DM, UReference;

{$R *.dfm}

var
  MainRecItem : TRecRefStatusSequence;
  SelectedRecMainItem : TRecRefStatusSequence;

procedure TfrmCCJSO_RefStatusSequence.FormCreate(Sender: TObject);
begin
  { Инициализация }
  bSignActive := false;
  Mode := cRefStatusSeqMode_Show;
  SelectedRecMainItem.RN := 0;
  SelectedRecMainItem.SeqStatusName := '';
end;

procedure TfrmCCJSO_RefStatusSequence.FormActivate(Sender: TObject);
begin
  if not bSignActive then begin
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(372,self.Icon);
    case Mode of
      cRefStatusSeqMode_Show: begin
        pnlStatusControl.Visible := false;
        pnlStatus.Height := stBarMain.Height;
      end;
      cRefStatusSeqMode_Select: begin
        pnlStatusControl.Visible := true;
        pnlStatus.Height := pnlStatusControl.Height + stBarMain.Height;
      end;
    end;
    { Инициализация }
    SetKoefPnlHierLeft;
    SetKoefPnlRefMain;
    { Наименования последовательностей }
    ExecConditionQRMain;
    { Форма активна }
    bSignActive := true;
    ExecConditionQRSlave;
    ShowGets;
  end;
end;

procedure TfrmCCJSO_RefStatusSequence.ShowGets;
var
  SCaption : string;
begin
  if bSignActive then begin
    { Доступ к элементам управления Main-раздела }
    if qrspMain.IsEmpty then begin
      aMainEdit.Enabled := false;
      aMainDel.Enabled := false;
      aMainMulti.Enabled := false;
      aSelect.Enabled := false;
    end else begin
      aMainEdit.Enabled := true;
      aMainDel.Enabled := true;
      aMainMulti.Enabled := true;
      aSelect.Enabled := true;
    end;
    { Доступ к элементам управления Slave-раздела и Hier-раздела}
    if trvStatusSeq.Selected <> nil then begin
      aHierAdd.Enabled := true;
      if PItemRec(trvStatusSeq.Selected.Data).NRN = 0 then begin
        aHierEdit.Enabled := false;
        aHierMulti.Enabled := false;
        aHierDel.Enabled := false;
      end else begin
        aHierEdit.Enabled := true;
        aHierMulti.Enabled := true;
      end;
      aSlaveAdd.Enabled := true;
      if trvStatusSeq.Selected.HasChildren then begin
        aHierDel.Enabled := false;
      end else begin
        if PItemRec(trvStatusSeq.Selected.Data).NRN = 0 then begin
          aHierDel.Enabled := false;
        end else begin
          aHierDel.Enabled := true;
        end;
      end;
      if qrspSlave.IsEmpty then begin
        aSlaveEdit.Enabled := false;
        aSlaveDel.Enabled := false;
        aSlaveMulti.Enabled := false;
      end else begin
        aSlaveEdit.Enabled := true;
        aSlaveDel.Enabled := true;
        aSlaveMulti.Enabled := true;
      end;
    end else begin
      aHierAdd.Enabled := false;
      aHierEdit.Enabled := false;
      aHierDel.Enabled := false;
      aHierMulti.Enabled := false;
      aSlaveAdd.Enabled := false;
      aSlaveEdit.Enabled := false;
      aSlaveDel.Enabled := false;
      aSlaveMulti.Enabled := false;
    end;
    { Количество записей Main-раздела }
    SCaption := VarToStr(qrspMain.RecordCount);
    pnlRefMainControl_Show.Caption := SCaption;
    pnlRefMainControl_Show.Width := TextPixWidth(SCaption, pnlRefMainControl_Show.Font) + 20;
    { Количество записей Hier-раздела }
    if trvStatusSeq.Items.Count > 0 then begin
      SCaption := VarToStr(trvStatusSeq.Items[0].Count);
      pnlHierControl_Show.Caption := SCaption;
      pnlHierControl_Show.Width := TextPixWidth(SCaption, pnlHierControl_Show.Font) + 20;
    end else pnlHierControl_Show.Caption := '';
  end;
end;

procedure TfrmCCJSO_RefStatusSequence.SetRecSession(Parm : TUserSession); begin RecSession := Parm; end;
procedure TfrmCCJSO_RefStatusSequence.SetMode(Parm : integer); begin Mode := Parm; end;
function  TfrmCCJSO_RefStatusSequence.GetSelectedMainRN : integer; begin result := SelectedRecMainItem.RN; end;
function  TfrmCCJSO_RefStatusSequence.GetSelectedMainName : string; begin result := SelectedRecMainItem.SeqStatusName; end;

procedure TfrmCCJSO_RefStatusSequence.SetKoefPnlHierLeft; begin KoefPnlHierLeft := pnlHier.Width/self.Width; end;
procedure TfrmCCJSO_RefStatusSequence.SetKoefPnlRefMain; begin KoefPnlRefMain  := pnlRefMain.Height/pnlRef.Height; end;
function TfrmCCJSO_RefStatusSequence.GetKoefPnlHierLeft : real; begin result := KoefPnlHierLeft; end;
function TfrmCCJSO_RefStatusSequence.GetKoefPnlRefMain : real; begin result := KoefPnlRefMain; end;

procedure TfrmCCJSO_RefStatusSequence.FormResize(Sender: TObject);
begin
  RecalcResize;
  ShowResize;
end;

procedure TfrmCCJSO_RefStatusSequence.RecalcResize;
begin
  MainGrid.Columns[0].Width := MainGrid.Width - 20;
end;

procedure TfrmCCJSO_RefStatusSequence.ShowResize;
begin
  if bSignActive then begin
    pnlHier.Width := round(GetKoefPnlHierLeft * self.Width);
    pnlRefMain.Height := round(GetKoefPnlRefMain * pnlRef.Height);
  end;
end;

procedure TfrmCCJSO_RefStatusSequence.splitHierMoved(Sender: TObject);
begin
  RecalcResize;
  SetKoefPnlHierLeft;
end;

procedure TfrmCCJSO_RefStatusSequence.ExecConditionQRMain;
var
  RN: Integer;
begin
  if not qrspMain.IsEmpty then RN := qrspMain.FieldByName('NRN').AsInteger else RN := -1;
  qrspMain.Active := false;
  CreateConditionQRMain;
  qrspMain.Active := true;
  qrspMain.Locate('NRN', RN, []);
end;

procedure TfrmCCJSO_RefStatusSequence.CreateConditionQRMain;
begin
//
end;

procedure TfrmCCJSO_RefStatusSequence.ExecConditionQRSlave;
var
  RN: Integer;
begin
  if not qrspSlave.IsEmpty then RN := qrspSlave.FieldByName('NRN').AsInteger else RN := -1;
  qrspSlave.Active := false;
  CreateConditionQRSlave;
  qrspSlave.Active := true;
  qrspSlave.Locate('NRN', RN, []);
end;

procedure TfrmCCJSO_RefStatusSequence.CreateConditionQRSlave;
begin
  if trvStatusSeq.Selected <> nil then begin
    qrspSlave.Parameters.ParamValues['@PRN']      := PItemRec(trvStatusSeq.Selected.Data).NPRN;
    qrspSlave.Parameters.ParamValues['@ParentRN'] := PItemRec(trvStatusSeq.Selected.Data).NRN;
    qrspSlave.Parameters.ParamValues['@Status']   := '';
  end else begin
    qrspSlave.Parameters.ParamValues['@PRN']      := 0;
    qrspSlave.Parameters.ParamValues['@ParentRN'] := 0;
    qrspSlave.Parameters.ParamValues['@Status']   := '';
  end;
end;

procedure TfrmCCJSO_RefStatusSequence.RefreshQRMain;
var
  RN: Integer;
begin
  if not qrspMain.IsEmpty then RN := qrspMain.FieldByName('NRN').AsInteger else RN := -1;
  qrspMain.Requery;
  qrspMain.Locate('NRN', RN, []);
end;

procedure TfrmCCJSO_RefStatusSequence.splitRefMainMoved(Sender: TObject);
begin
  SetKoefPnlRefMain;
end;

procedure TfrmCCJSO_RefStatusSequence.MainCreate(Mode : integer);
begin
  try
    SaveMainRec;
    frmCCJSO_RefStatusSequence_Create := TfrmCCJSO_RefStatusSequence_Create.Create(Self);
    frmCCJSO_RefStatusSequence_Create.SetMode(Mode);
    frmCCJSO_RefStatusSequence_Create.SetRecItem(MainRecItem);
    frmCCJSO_RefStatusSequence_Create.SetRecSession(RecSession);
    try
      frmCCJSO_RefStatusSequence_Create.ShowModal;
    finally
      frmCCJSO_RefStatusSequence_Create.Free;
    end;
    RefreshQRMain;
    ShowGets;
  except
    on e:Exception do begin
      ShowMessage('Сбой при выполнении операции.' + chr(10) + e.Message);
    end;
  end;
end;

procedure TfrmCCJSO_RefStatusSequence.SaveMainRec;
begin
  if qrspMain.IsEmpty then begin
    MainRecItem.RN := 0;
    MainRecItem.SeqStatusName := '';
  end else begin
    MainRecItem.RN := MainGrid.DataSource.DataSet.FieldByName('NRN').AsInteger;
    MainRecItem.SeqStatusName := MainGrid.DataSource.DataSet.FieldByName('SSeqStatusName').AsString;
  end;
end;

procedure TfrmCCJSO_RefStatusSequence.aMainAddExecute(Sender: TObject);
begin
  MainCreate(cRefStatusSequenceCreate_Insert);
end;

procedure TfrmCCJSO_RefStatusSequence.aMainEditExecute(Sender: TObject);
begin
  MainCreate(cRefStatusSequenceCreate_Update);
end;

procedure TfrmCCJSO_RefStatusSequence.aMainMultiExecute(Sender: TObject);
begin
  MainCreate(cRefStatusSequenceCreate_MultiPly);
end;

procedure TfrmCCJSO_RefStatusSequence.aSlaveAddExecute(Sender: TObject);
begin
  HierInsert;
end;

procedure TfrmCCJSO_RefStatusSequence.aSlaveEditExecute(Sender: TObject);
begin
//
end;

procedure TfrmCCJSO_RefStatusSequence.aSlaveDelExecute(Sender: TObject);
begin
  HierDelete(SlaveGrid.DataSource.DataSet.FieldByName('NRN').AsInteger);
end;

procedure TfrmCCJSO_RefStatusSequence.aSlaveMultiExecute(Sender: TObject);
begin
//
end;

procedure TfrmCCJSO_RefStatusSequence.aHierAddExecute(Sender: TObject);
begin
  HierInsert;
end;

procedure TfrmCCJSO_RefStatusSequence.aHierEditExecute(Sender: TObject);
begin
//
end;

procedure TfrmCCJSO_RefStatusSequence.aHierDelExecute(Sender: TObject);
var
  CurrentNode  : TTreeNode;
  PCurrentItem : PItemRec;
begin
  CurrentNode := trvStatusSeq.Selected;
  PCurrentItem := PItemRec(CurrentNode.Data);
  HierDelete(PCurrentItem.NRN);
end;

procedure TfrmCCJSO_RefStatusSequence.aHierMultiExecute(Sender: TObject);
begin
//
end;

procedure TfrmCCJSO_RefStatusSequence.MainGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCCJSO_RefStatusSequence.aMainDelExecute(Sender: TObject);
var
  IErr : integer;
  SErr : string;
begin
  if MessageDLG('Подтвердите выполнение действия',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  try
    SaveMainRec;
    spMainDel.Parameters.ParamValues['@USER'] := RecSession.CurrentUser;
    spMainDel.Parameters.ParamValues['@NRN'] := MainRecItem.RN;
    spMainDel.ExecProc;
    IErr := spMainDel.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr <> 0 then begin
      SErr := spMainDel.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
    RefreshQRMain;
    ShowGets;
  except
    on e:Exception do
      begin
        ShowMessage(e.Message);
      end;
  end;
end;

procedure TfrmCCJSO_RefStatusSequence.aExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmCCJSO_RefStatusSequence.trvStatusSeqChange(Sender: TObject; Node: TTreeNode);
begin
  //ShowMessage('trvStatusSeq - Change');
  if bSignActive then begin
    ExecConditionQRSlave;
  end;
  if trvStatusSeq.Selected <> nil
    then stBarMain.SimpleText := trvStatusSeq.Selected.Text
    else stBarMain.SimpleText := '';
  ShowGets;
end;

procedure TfrmCCJSO_RefStatusSequence.SlaveGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  db: TDBGrid;
begin
  if Sender = nil then Exit;
  db := TDBGrid(Sender);
  if (gdSelected in State) then begin
    db.Canvas.Font.Style := [fsBold];
  end;
  db.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

function TfrmCCJSO_RefStatusSequence.GetParentNodeFromData(ParentRN : integer; PRN : integer) : TTreeNode;
var
  OldNode   : TTreeNode;
  Searching : boolean;
begin
  Searching := false;
  OldNode := trvStatusSeq.Items[0];
  while (not Searching) and (OldNode <> nil) do begin
    if (PItemRec(OldNode.Data).NRN = ParentRN) and (PItemRec(OldNode.Data).NPRN = PRN)
      then Searching := true
      else OldNode := OldNode.GetNext;
  end;
  if Searching then Result := OldNode
  else begin
    DM_CCJSO.RegException(
                          1,
                          'CCJSO_RefStatusSequence',
                          -1,
                          'Не найден родительский узел иерархии',
                          RecSession.CurrentUser,
                          'PRN = ' + VarToStr(PRN) + ', ParentRN = ' + VarToStr(ParentRN),
                          ''
                         );
    Result := nil;
  end;
end;

procedure TfrmCCJSO_RefStatusSequence.CreateAllHier;
var
  OldNode    : TTreeNode;
  NewNode    : TTreeNode;
  StartNode  : TTreeNode;
  ParentNode : TTreeNode;
  PNodeData  : PItemRec;
  PRN        : integer;
  ParentRN   : integer;
begin
  { Перед очисткой дерева, освобождаем память от динамически распределенных записей каждого узла дерева }
  if trvStatusSeq.Items.Count > 0 then begin
    OldNode := trvStatusSeq.Items[0];
    while (OldNode <> nil) do begin
      Dispose(PItemRec(OldNode.Data));
      OldNode.Data := nil;
      OldNode := OldNode.GetNext;
    end;
  end;
  trvStatusSeq.Items.Clear;
  if not qrspMain.IsEmpty then begin
    PRN := MainGrid.DataSource.DataSet.FieldByName('NRN').AsInteger;
    NewNode := trvStatusSeq.Items.AddObject(nil,'Все (' + MainGrid.DataSource.DataSet.FieldByName('SSeqStatusName').AsString + ')',nil);
    StartNode := NewNode;
    New(PNodeData); NewNode.Data := PNodeData;
    PNodeData.NRN  := 0;
    PNodeData.NPRN := PRN;
    PNodeData.NStatus := 0;
    PNodeData.SStatus := '';
    PNodeData.NParentRN := 0;
    PNodeData.BSignUse := false;
    PNodeData.SSignUse := '';
    PNodeData.SChangeDate := '';
    PNodeData.Level := -1;
    { Формируем узлы иерархии }
    if qrspHier.Active then qrspHier.Active := false;
    qrspHier.Parameters.ParamValues['@PRN']        := PRN;
    qrspHier.Parameters.ParamValues['@RN']         := 0;   { с самого начала }
    qrspHier.Parameters.ParamValues['@SignShowRN'] := 1;   { показываем родительский уровень }
    qrspHier.Parameters.ParamValues['@Level']      := -1;  { все уровни }
    qrspHier.Open;
    qrspHier.First;
    while not qrspHier.Eof do begin
      ParentRN := qrspHier.FieldByName('NParentRN').AsInteger;
      if ParentRN = 0 then begin
        { Стартовый уровень иерархии }
        NewNode := trvStatusSeq.Items.AddChildObject(StartNode,qrspHier.FieldByName('SStatus').AsString,nil);
      end else begin
        { Находим ссылку на родительский уровень }
        ParentNode := GetParentNodeFromData(ParentRN,PRN);
        if ParentNode <> nil
          then NewNode := trvStatusSeq.Items.AddChildObject(ParentNode,qrspHier.FieldByName('SStatus').AsString,nil)
          else NewNode := nil;
      end;
      if NewNode <> nil then begin
        New(PNodeData); NewNode.Data := PNodeData;
        PNodeData.NRN         := qrspHier.FieldByName('NRN').AsInteger;
        PNodeData.NPRN        := PRN;
        PNodeData.NStatus     := qrspHier.FieldByName('NStatus').AsInteger;
        PNodeData.SStatus     := qrspHier.FieldByName('SStatus').AsString;
        PNodeData.NParentRN   := ParentRN;
        PNodeData.BSignUse    := qrspHier.FieldByName('BSignUse').AsBoolean;
        PNodeData.SSignUse    := qrspHier.FieldByName('SSignUse').AsString;
        PNodeData.SChangeDate := qrspHier.FieldByName('SChangeDate').AsString;
        PNodeData.Level       := qrspHier.FieldByName('StatusLevel').AsInteger;
      end;
      qrspHier.Next;
    end;
    { Стартовый узел делаем выделенным }
    trvStatusSeq.Items[0].Selected := true;
    trvStatusSeq.FullExpand;
  end;
end;

procedure TfrmCCJSO_RefStatusSequence.dsMainDataChange(Sender: TObject; Field: TField);
begin
  CreateAllHier;
  ShowGets;
end;

procedure TfrmCCJSO_RefStatusSequence.trvStatusSeqClick(Sender: TObject);
begin
  //ShowMessage('trvStatusSeq - Click');
  if trvStatusSeq.Selected <> nil
    then stBarMain.SimpleText := trvStatusSeq.Selected.Text
    else stBarMain.SimpleText := '';
  ShowGets;
end;

procedure TfrmCCJSO_RefStatusSequence.MainGridMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if trvStatusSeq.Selected <> nil
    then stBarMain.SimpleText := trvStatusSeq.Selected.Text
    else stBarMain.SimpleText := '';
end;

procedure TfrmCCJSO_RefStatusSequence.SlaveGridMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if trvStatusSeq.Selected <> nil
    then stBarMain.SimpleText := trvStatusSeq.Selected.Text
    else stBarMain.SimpleText := '';
end;

procedure TfrmCCJSO_RefStatusSequence.tbarMainMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  stBarMain.SimpleText := '';
end;

procedure TfrmCCJSO_RefStatusSequence.tbarSlaveMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  stBarMain.SimpleText := '';
end;

procedure TfrmCCJSO_RefStatusSequence.MainGridDblClick(Sender: TObject);
begin
  if not qrspMain.IsEmpty then aMainEdit.Execute;
end;

procedure TfrmCCJSO_RefStatusSequence.trvStatusSeqCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  DefaultDraw := true;
end;

procedure TfrmCCJSO_RefStatusSequence.aSelectExecute(Sender: TObject);
begin
  SaveMainRec;
  if MessageDLG('Подтвердите выполнение действия',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  SelectedRecMainItem.RN := MainRecItem.RN;
  SelectedRecMainItem.SeqStatusName := MainRecItem.SeqStatusName;
  Self.Close;
end;

procedure TfrmCCJSO_RefStatusSequence.trvStatusSeqAdvancedCustomDrawItem
(
 Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean
);
begin
  if Sender.Selected = Node then begin
    Sender.Canvas.Brush.Color := TColor($FFFF9D);
    Sender.Canvas.Font.Color := clWindowText;
  end;
  if (not PItemRec(Node.Data).BSignUse) and (PItemRec(Node.Data).NRN <> 0) then Sender.Canvas.Font.Color := clRed;
  DefaultDraw := true;
end;

procedure TfrmCCJSO_RefStatusSequence.RefSeqStatusSp_Insert(USER : integer; PRN : integer; OrderStatus : string; ParentRN : integer; var IErr : integer; var SErr : string);
begin
  IErr := 0;
  SErr := '';
  try
    spHier_Insert.Parameters.ParamValues['@USER']        := USER;
    spHier_Insert.Parameters.ParamValues['@PRN']         := PRN;
    spHier_Insert.Parameters.ParamValues['@OrderStatus'] := OrderStatus;
    spHier_Insert.Parameters.ParamValues['@ParentRN']    := ParentRN;
    spHier_Insert.ExecProc;
    IErr := spHier_Insert.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
    end else begin
      SErr := spHier_Insert.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
      ShowMessage(SErr);
    end;
  end;
end;

function TfrmCCJSO_RefStatusSequence.GetStatus : string;
var
  OrderStatus : string;
begin
  OrderStatus := '';
  try
   frmReference := TfrmReference.Create(Self);
   frmReference.SetMode(cFReferenceModeSelect);
   frmReference.SetReferenceIndex(cFReferenceOrderStatus);
   frmReference.SetReadOnly(cFReferenceNoReadOnly);
   try
    frmReference.ShowModal;
    OrderStatus := frmReference.GetDescrSelect;
   finally
    FreeAndNil(frmReference);
   end;
  except
  end;
  Result := OrderStatus;
end;

procedure TfrmCCJSO_RefStatusSequence.HierInsert;
var
  CurrentNode  : TTreeNode;
  PCurrentItem : PItemRec;
  OrderStatus  : string;
  IErr         : integer;
  SErr         : string;
begin
  OrderStatus := GetStatus;
  if length(OrderStatus) > 0 then begin
    CurrentNode := trvStatusSeq.Selected;
    PCurrentItem := PItemRec(CurrentNode.Data);
    RefSeqStatusSp_Insert(RecSession.CurrentUser, PCurrentItem.NPRN, OrderStatus, PCurrentItem.NRN, IErr, SErr);
    if IErr = 0 then begin
      { Перегружаем всю иерархию }
      CreateAllHier;
      {trvStatusSeq.Selected := CurrentNode;}
      ShowGets;
    end;
  end;
end;

procedure TfrmCCJSO_RefStatusSequence.RefSeqStatusSp_Delete(USER : integer; RN : integer; var IErr : integer; var SErr : string);
begin
  IErr := 0;
  SErr := '';
  try
    spHier_Del.Parameters.ParamValues['@USER'] := USER;
    spHier_Del.Parameters.ParamValues['@RN']   := RN;
    spHier_Del.ExecProc;
    IErr := spHier_Del.Parameters.ParamValues['@RETURN_VALUE'];
    if IErr = 0 then begin
    end else begin
      SErr := spHier_Del.Parameters.ParamValues['@SErr'];
      ShowMessage(SErr);
    end;
  except
    on e:Exception do begin
      SErr := e.Message;
      IErr := -1;
      ShowMessage(SErr);
    end;
  end;
end;

procedure TfrmCCJSO_RefStatusSequence.HierDelete(RN : integer);
var
  IErr : integer;
  SErr : string;
begin
  if MessageDLG('Подтвердите удаление',mtConfirmation,[mbYes,mbNo],0) = mrNo then exit;
  RefSeqStatusSp_Delete(RecSession.CurrentUser,RN,IErr,SErr);
  if IErr = 0 then begin
    { Перегружаем всю иерархию }
    CreateAllHier;
    ShowGets;
  end;
end;

end.
