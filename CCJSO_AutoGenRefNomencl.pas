unit CCJSO_AutoGenRefNomencl;

(*
  © PgkSoft 08.08.2016
  Справочник автогенерации
  Номенклатура заказов
*)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  UCCenterJournalNetZkz, ExtCtrls, ActnList, StdCtrls, ComCtrls, ToolWin,
  Grids, DBGrids, DB, ADODB;

type
  TfrmAutoGenRefNomencl = class(TForm)
    pnlSelect: TPanel;
    pnlCond: TPanel;
    pnlControl: TPanel;
    pnlGrid: TPanel;
    aList: TActionList;
    aExit: TAction;
    aSelect: TAction;
    aClearCond: TAction;
    pnlSelect_Tool: TPanel;
    tbarSelect: TToolBar;
    tbtnSelect_Ok: TToolButton;
    tbtnSelect_Exit: TToolButton;
    pnlSelect_Show: TPanel;
    pnlControl_Show: TPanel;
    pnlControl_Tool: TPanel;
    pnlCond_Tool: TPanel;
    tbarCond: TToolBar;
    tbtnCond_Clear: TToolButton;
    pnlCond_Fields: TPanel;
    lblCond_ArtCode: TLabel;
    edCond_ArtCode: TEdit;
    lblCond_Name: TLabel;
    edCond_Name: TEdit;
    aRefresh: TAction;
    tbarControl: TToolBar;
    ToolButton1: TToolButton;
    aChangeCond: TAction;
    GridMain: TDBGrid;
    qrspMain: TADOStoredProc;
    dsMain: TDataSource;
    aCondExec: TAction;
    tbtnCond_Exec: TToolButton;
    aCondFieldsClick: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aSelectExecute(Sender: TObject);
    procedure aClearCondExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aChangeCondExecute(Sender: TObject);
    procedure GridMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    function  GetStateClearMainCondition : boolean;
    procedure GridMainTitleClick(Column: TColumn);
    procedure aCondExecExecute(Sender: TObject);
    procedure GridMainDblClick(Sender: TObject);
    procedure aCondFieldsClickExecute(Sender: TObject);
  private
    { Private declarations }
    bSignActive   : boolean;
    ScreenPos     : TPoint;
    Mode          : integer;
    RecSession    : TUserSession;
    SortField     : string;
    SortDirection : boolean;
    SignSelect    : boolean;
    SlArtCode     : integer;
    SLArtName     : string;
    procedure ShowGets;
    procedure ExecConditionQRMain;
    procedure CreateConditionQRMain;
    procedure GridMainRefresh;
    procedure SetClearCondition;
  public
    { Public declarations }
    procedure SetMode(Parm : integer);
    procedure SetRecSession(Parm : TUserSession);
    procedure SetScreenPos(Parm : TPoint);
    function  GetSignSelect : boolean;
    function  GetArtCode    : integer;
    function  GetArtName    : string;
  end;

Const
  cFAutoGenRefNomMode_Show   = 0;
  cFAutoGenRefNomMode_Select = 1;
var
  frmAutoGenRefNomencl: TfrmAutoGenRefNomencl;

implementation

uses UMAIN, UTIL, Types;

{$R *.dfm}

procedure TfrmAutoGenRefNomencl.FormCreate(Sender: TObject);
begin
  { Иницализация }
  bSignActive   := false;
  Mode          := cFAutoGenRefNomMode_Show;
  SignSelect    := false;
  SlArtCode     := 0;
  SLArtName     := '';
  SortField     := '';
  SortDirection := false;
  ScreenPos     := Point(0,0);
end;

procedure TfrmAutoGenRefNomencl.FormActivate(Sender: TObject);
begin
  if not bSignActive then begin
    { Специальное позиционирование окна }
    if (ScreenPos.X <> 0) or (ScreenPos.Y <> 0) then begin
      self.Left := ScreenPos.X;
      self.Top  := ScreenPos.Y;
    end;
    { Иконка формы }
    FCCenterJournalNetZkz.imgMain.GetIcon(383,self.Icon);
    { Инициализация }
    if Mode = cFAutoGenRefNomMode_Show then begin
      pnlSelect.Visible := false;
    end;
    { Форма активна }
    bSignActive := true;
    { Инициализация сортировки }
    GridMain.OnTitleClick(GridMain.Columns[0]);
    GridMain.SetFocus;
  end;
end;

procedure TfrmAutoGenRefNomencl.ShowGets;
var
  SCaption : string;
begin
  if bSignActive then begin
    { Доступ к очистке условий отбора }
    if GetStateClearMainCondition then begin
      aClearCond.Enabled := false;
      aCondExec.Enabled  := false;
    end else begin
      aClearCond.Enabled := true;
      aCondExec.Enabled  := true;
    end;
    { Доступ к элементам управления }
    if not qrspMain.IsEmpty then begin
      aSelect.Enabled := true;
    end else begin
      aSelect.Enabled := false;
    end;
    { Количество номеклатуры заказов }
    SCaption := VarToStr(qrspMain.RecordCount);
    pnlControl_Show.Caption := SCaption; pnlControl_Show.Width := TextPixWidth(SCaption, pnlControl_Show.Font) + 20;
  end;
end;

function TfrmAutoGenRefNomencl.GetStateClearMainCondition : boolean;
var
  bResReturn : boolean;
begin
  if     (length(trim(edCond_ArtCode.Text)) = 0)
     and (length(trim(edCond_Name.Text))    = 0)
  then bResReturn := true
  else bResReturn := false;
  result := bResReturn;
end;

procedure TfrmAutoGenRefNomencl.SetRecSession(Parm : TUserSession); begin RecSession := Parm; end;
procedure TfrmAutoGenRefNomencl.SetMode(Parm : integer); begin Mode := Parm; end;
procedure TfrmAutoGenRefNomencl.SetScreenPos(Parm : TPoint); begin ScreenPos := Parm; end;
function  TfrmAutoGenRefNomencl.GetSignSelect : boolean; begin result := SignSelect; end;
function  TfrmAutoGenRefNomencl.GetArtCode : integer;    begin result := SLArtCode; end;
function  TfrmAutoGenRefNomencl.GetArtName : string;     begin result := SLArtName; end;

procedure TfrmAutoGenRefNomencl.ExecConditionQRMain;
var
  RN: Integer;
begin
  if not qrspMain.IsEmpty then RN := qrspMain.FieldByName('NRN').AsInteger else RN := -1;
  qrspMain.Active := false;
  CreateConditionQRMain;
  qrspMain.Active := true;
  qrspMain.Locate('NRN', RN, []);
end;

procedure TfrmAutoGenRefNomencl.CreateConditionQRMain;
begin
  if length(trim(edCond_ArtCode.Text)) = 0
    then qrspMain.Parameters.ParamValues['@ArtCode'] := ''
    else qrspMain.Parameters.ParamValues['@ArtCode'] := edCond_ArtCode.Text;
  if length(trim(edCond_Name.Text)) = 0
    then qrspMain.Parameters.ParamValues['@Name'] := ''
    else qrspMain.Parameters.ParamValues['@Name'] := edCond_Name.Text;
  qrspMain.Parameters.ParamValues['@OrderBy']   := SortField;
  qrspMain.Parameters.ParamValues['@Direction'] := SortDirection;
end;

procedure TfrmAutoGenRefNomencl.GridMainRefresh;
var
  RN: Integer;
begin
  if not qrspMain.IsEmpty then RN := qrspMain.FieldByName('NRN').AsInteger else RN := -1;
  qrspMain.Requery;
  qrspMain.Locate('NRN', RN, []);
end;

procedure TfrmAutoGenRefNomencl.SetClearCondition;
begin
  edCond_ArtCode.Text := '';
  edCond_Name.Text := '';
end;

procedure TfrmAutoGenRefNomencl.aExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TfrmAutoGenRefNomencl.aSelectExecute(Sender: TObject);
begin
  SignSelect := true;
  SLArtCode := GridMain.DataSource.DataSet.FieldByName('NRN').AsInteger;
  SLArtName := GridMain.DataSource.DataSet.FieldByName('SNomenclature').AsString;
  self.Close;
end;

procedure TfrmAutoGenRefNomencl.aClearCondExecute(Sender: TObject);
begin
  SetClearCondition;
  ExecConditionQRMain;
  ShowGets;
end;

procedure TfrmAutoGenRefNomencl.aRefreshExecute(Sender: TObject);
begin
  GridMainRefresh;
  ShowGets;
end;

procedure TfrmAutoGenRefNomencl.aChangeCondExecute(Sender: TObject);
begin
  ShowGets;
end;

procedure TfrmAutoGenRefNomencl.GridMainDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TfrmAutoGenRefNomencl.GridMainTitleClick(Column: TColumn);
var
  iCkl : integer;
begin
  if Column.Title.Font.Color = clWindowText then begin
    { Восстанавливаем прорисовку по умолчанию }
    for iCkl := 0 to GridMain.Columns.count - 1 do begin
      if GridMain.Columns[iCkl].Title.Font.Color <> clWindowText then begin
        GridMain.Columns[iCkl].Title.Font.Color := clWindowText;
        GridMain.Columns[iCkl].Title.Font.Style := [];
        GridMain.Columns[iCkl].Title.Caption := copy(GridMain.Columns[iCkl].Title.Caption,2,length(GridMain.Columns[iCkl].Title.Caption)-1);
      end;
    end;
    { Для выбранного столбца включаем сортировку по возрастанию }
    Column.Title.Font.Color := clBlue;
    Column.Title.Font.Style := [fsBold];
    Column.Title.Caption := chr(24)+Column.Title.Caption;
    SortField := Column.FieldName;
    SortDirection := false;
    ExecConditionQRMain;
  end
  else if Column.Title.Font.Color = clBlue then begin
    { Для выбранного столбца переключаем на сортировку по убыванию }
    Column.Title.Font.Color := clFuchsia;
    Column.Title.Font.Style := [fsBold];
    Column.Title.Caption := '!'+copy(Column.Title.Caption,2,length(Column.Title.Caption)-1);
    SortField := Column.FieldName;
    SortDirection := true;
    ExecConditionQRMain;
  end
  else if Column.Title.Font.Color = clFuchsia then begin
    { Для выбранного столбца переключаем на сортировку по возрастанию }
    Column.Title.Font.Color := clBlue;
    Column.Title.Font.Style := [fsBold];
    Column.Title.Caption := chr(24)+copy(Column.Title.Caption,2,length(Column.Title.Caption)-1);
    SortField := Column.FieldName;
    SortDirection := false;
    ExecConditionQRMain;
  end;
  ShowGets;
end;

procedure TfrmAutoGenRefNomencl.aCondExecExecute(Sender: TObject);
begin
  ExecConditionQRMain;
  ShowGets;
end;

procedure TfrmAutoGenRefNomencl.GridMainDblClick(Sender: TObject);
begin
  if not qrspMain.IsEmpty then begin
    SignSelect := true;
    SLArtCode := GridMain.DataSource.DataSet.FieldByName('NRN').AsInteger;
    SLArtName := GridMain.DataSource.DataSet.FieldByName('SNomenclature').AsString;
    self.Close;
  end;
end;

procedure TfrmAutoGenRefNomencl.aCondFieldsClickExecute(Sender: TObject);
begin
  if not GetStateClearMainCondition then aCondExec.Execute;
end;

end.
