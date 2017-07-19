unit uSprEditDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uSprQuery, StdCtrls, DB, DBClient, Mask, DBCtrls, Grids,
  DBGrids, ExtCtrls;

type
  TedMode = (edBrowse, edEdit, edInsert);

  TControlDef = class(TObject)
  private
    FFieldName: string;
    //FCtrlClass: string;
    FIsLookup: Boolean;
    FKeyField: string;
    FListField: string;
    FListDSCreate: TsprDSCreateMethod;
    FField: TField;
  public
    property FieldName: string read FFieldName write FFieldName;
    //property CtrlClass: string read FCtrlClass write FCtrlClass;
    property IsLookup: Boolean read FIsLookup write FIsLookup;
    property KeyField: string read FKeyField write FKeyField;
    property ListField: string read FListField write FListField;
    property ListDSCreate: TsprDSCreateMethod read FListDSCreate write FListDSCreate;
    property Field: TField read FField write FField;
  end;

  TsprEditDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FDataSet: TDataSet;//TsprQuery;
    FControlDefs: TStringList;
    //procedure CreateControl(
  public
    { Public declarations }
    property DataSet: TDataSet {read   TsprQuery } read FDataSet write FDataSet;
    procedure Initialize(Mode: TedMode);
    //procedure AddDef(AFieldName: string; AIsLookup: Boolean; AKeyField: string; AListField: string; AListDSCreate: TsprDSCreateMethod);
  end;

var
  sprEditDlg: TsprEditDlg;

implementation

{$R *.dfm}

procedure TsprEditDlg.FormCreate(Sender: TObject);
begin
  FControlDefs := TStringList.Create;
end;

procedure TsprEditDlg.FormDestroy(Sender: TObject);
var
  I: Integer;
begin
  if Assigned(FControlDefs) then
  begin
    for I := 0 to FControlDefs.Count - 1 do
      FControlDefs.Objects[I].Free;

    FControlDefs.Clear;
    FreeAndNil(FControlDefs);
  end;
end;

procedure TsprEditDlg.Initialize(Mode: TedMode);
var
  I: Integer;
begin
DataSource1.DataSet := FDataSet;
{  ClientDataSet1.FieldDefs.Assign(DataSet.FieldDefs);
  ClientDataSet1.CreateDataSet;
  ClientDataSet1.Active;
  if Mode = edInsert then
    ClientDataSet1.Insert
  else
  if Mode = edEdit then
  begin
    if DataSet.RecordCount > 0 then
    begin
    end
    else
      ClientDataSet1.Insert;
  end
 }
end;

{
procedure TsprEditDlg.AddDef(AFieldName: string; AIsLookup: Boolean;
  AKeyField: string; AListField: string; AListDSCreate: TsprDSCreateMethod);
var
  F: TField;
  vDef: TControlDef;
  vCtrl: TControl;
begin
  if not Assigned(DataSet) then
    raise Exception.Create('DataSet не определен');

  F := DataSet.FindField(AFieldName);
  if not Assigned(F) then
    raise Exception.Create('Не найдено поле ' + AFieldName);

  ClientDataSet1.FieldDefs.
  vDef := TControlDef.Create;
  vDef.FieldName := AFieldName;
  vDef.Field := F;
  if not AIsLookup then
  begin

  end
  else
  begin
  end;
end;}


procedure TsprEditDlg.Button1Click(Sender: TObject);
begin
  FDataSet.Insert;
end;

end.
