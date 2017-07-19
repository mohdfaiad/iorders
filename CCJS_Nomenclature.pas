unit CCJS_Nomenclature;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Grids, DBGrids, ExtCtrls, StdCtrls, ComCtrls, ToolWin,
  DB, ADODB;

type
  TfrmCCJS_Nomenclature = class(TForm)
    pnlControl: TPanel;
    pnlCondition: TPanel;
    pnlCondition_Tool: TPanel;
    pnlCondition_Fields: TPanel;
    pnlCondition_Show: TPanel;
    pnlGridNomn: TPanel;
    GridNomn: TDBGrid;
    pnlControl_Tool: TPanel;
    pnlControl_Show: TPanel;
    ActionList: TActionList;
    aControl_Select: TAction;
    aControl_Exit: TAction;
    aCondition: TAction;
    aClearCondition: TAction;
    tlbarControl: TToolBar;
    tlbtnControl_Select: TToolButton;
    tlbtnControl_Exit: TToolButton;
    tlbarCondition: TToolBar;
    tlbtnCondition_Select: TToolButton;
    tlbtnCondition_Clear: TToolButton;
    lblCondArtCode: TLabel;
    edCondArtCode: TEdit;
    lblCondArtName: TLabel;
    edCondArtName: TEdit;
    qrspNomenclature: TADOStoredProc;
    dsNomenclature: TDataSource;
    aCondAllNomn: TAction;
    tlbtnCondition_AllNomn: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aConditionExecute(Sender: TObject);
    procedure aClearConditionExecute(Sender: TObject);
    procedure aControl_SelectExecute(Sender: TObject);
    procedure aControl_ExitExecute(Sender: TObject);
    procedure aCondAllNomnExecute(Sender: TObject);
    procedure dsNomenclatureDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    ISignActive : integer;
    slArtCode   : string;
    slArtName   : string;
    slPrice     : string;
    procedure ShowGets;
    procedure ExecCondition;
  public
    { Public declarations }
    function GetArtCode : string;
    function GetArtName : string;
    function GetPrice : string;
  end;

var
  frmCCJS_Nomenclature: TfrmCCJS_Nomenclature;

implementation

uses
  Util,
  UMAIN, ExDBGRID, DateUtils, UCCenterJournalNetZkz;

{$R *.dfm}

procedure TfrmCCJS_Nomenclature.FormCreate(Sender: TObject);
begin
  { Инициализация }
  ISignActive := 0;
  slArtCode   := '';
  slArtName   := '';
  slPrice     := '';
end;

procedure TfrmCCJS_Nomenclature.FormActivate(Sender: TObject);
begin
  if ISignActive = 0 then begin
    ExecCondition;
    { Форма активна }
    ISignActive := 1;
    ShowGets;
  end;
end;

procedure TfrmCCJS_Nomenclature.ExecCondition;
var
  ArtCode     : Integer;
  SignShowAll : smallint;
  CondArtCode : integer;
begin
  if (length(trim(edCondArtCode.Text)) = 0) or (not ufoTryStrToInt(edCondArtCode.Text))
    then CondArtCode := 0
    else CondArtCode := StrToInt(edCondArtCode.Text);
  if aCondAllNomn.Checked then SignShowAll := 1 else SignShowAll := 0;
  if not qrspNomenclature.IsEmpty then ArtCode := qrspNomenclature.FieldByName('ArtCode').AsInteger else ArtCode := -1;
  qrspNomenclature.Active := false;
  qrspNomenclature.Parameters.ParamValues['@Descr']       := edCondArtName.Text;
  qrspNomenclature.Parameters.ParamValues['@Code']        := CondArtCode;
  qrspNomenclature.Parameters.ParamValues['@SignShowAll'] := SignShowAll;
  qrspNomenclature.Active := true;
  qrspNomenclature.Locate('ArtCode', ArtCode, []);
end;

procedure TfrmCCJS_Nomenclature.ShowGets;
var
  SCaption : string;
begin
  if ISignActive = 1 then begin
    { Доступ к выбору товарной позиции }
    if   (qrspNomenclature.IsEmpty)
      or (length(GridNomn.DataSource.DataSet.FieldByName('Descr').AsString) = 0)
      or (length(GridNomn.DataSource.DataSet.FieldByName('Cena').AsString) = 0)
    then aControl_Select.Enabled := false
    else aControl_Select.Enabled := true;
    { Количество строк }
    SCaption := VarToStr(qrspNomenclature.RecordCount);
    pnlCondition_Show.Caption := SCaption; pnlCondition_Show.Width := TextPixWidth(SCaption, pnlCondition_Show.Font) + 30;
  end;
end;

function TfrmCCJS_Nomenclature.GetArtCode : string; begin result := slArtCode; end;
function TfrmCCJS_Nomenclature.GetArtName : string; begin result := slArtName; end;
function TfrmCCJS_Nomenclature.GetPrice : string; begin result := slPrice; end;

procedure TfrmCCJS_Nomenclature.aConditionExecute(Sender: TObject);
begin
  ExecCondition;
  ShowGets;
end;

procedure TfrmCCJS_Nomenclature.aClearConditionExecute(Sender: TObject);
begin
  edCondArtCode.Text := '';
  edCondArtName.Text := '';
  ExecCondition;
  ShowGets;
end;

procedure TfrmCCJS_Nomenclature.aControl_SelectExecute(Sender: TObject);
begin
  slArtCode := GridNomn.DataSource.DataSet.FieldByName('SArtCode').AsString;
  slArtName := GridNomn.DataSource.DataSet.FieldByName('Descr').AsString;
  slPrice   := GridNomn.DataSource.DataSet.FieldByName('Cena').AsString;
  self.Close;
end;

procedure TfrmCCJS_Nomenclature.aControl_ExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmCCJS_Nomenclature.aCondAllNomnExecute(Sender: TObject);
begin
  if aCondAllNomn.Checked then begin
    aCondAllNomn.ImageIndex := 36;
    tlbtnCondition_AllNomn.Refresh;
    tlbtnCondition_AllNomn.Repaint;
  end else begin
    aCondAllNomn.ImageIndex := -1;
    tlbtnCondition_AllNomn.Refresh;
    tlbtnCondition_AllNomn.Repaint;
  end;
  ExecCondition;
  ShowGets;
end;

procedure TfrmCCJS_Nomenclature.dsNomenclatureDataChange(Sender: TObject; Field: TField);
begin
  ShowGets;
end;

end.
