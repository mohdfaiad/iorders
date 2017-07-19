unit uBPSpecRef;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, uSprGridFrm, uDMJSO, uSprQuery, ExtCtrls, DBCtrls, DBGrids,
  Grids, StdCtrls, ADODB, Umain, UtilsBase, uBPCtxFrame;

type
  TfmBPSpecRef = class(TForm)
    dsBP: TDataSource;
    dsSrcStatus: TDataSource;
    dsResStatus: TDataSource;
    dsActions: TDataSource;
    dsRef: TDataSource;
    Panel2: TPanel;
    dbNav: TDBNavigator;
    dsSrcBasis: TDataSource;
    dsResBasis: TDataSource;
    dsSpec: TDataSource;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Panel3: TPanel;
    dbNavSpec: TDBNavigator;
    BPSpecBasisGrid: TsprGridFrm;
    BPSpecGrid: TBPCtxFrame;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dsRefDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    FDSRef: TsprQuery;
    FDSSpec: TsprQuery;
    procedure Initialize;
  public
    { Public declarations }
  end;

var
  fmBPSpecRef: TfmBPSpecRef;

implementation

{$R *.dfm}

procedure TfmBPSpecRef.Initialize;
begin
  dsSrcBasis.DataSet := dmJSO.CreateActionBasis;
  dsSrcBasis.DataSet.Active := true;
  dsResBasis.DataSet := dmJSO.CreateActionBasis;
  dsResBasis.DataSet.Active := true;
  FDSSpec := dmJSO.CreateBPSpecBasis(dsSrcBasis.DataSet, dsResBasis.DataSet);
  dsSpec.DataSet := FDSSpec;
  dsSpec.DataSet.Active := true;
  BPSpecBasisGrid.DataSet := TsprQuery(dsSpec.DataSet);
  dbNavSpec.DataSource := BPSpecBasisGrid.DataSource;
  BPSpecBasisGrid.Grid.Options := BPSpecBasisGrid.Grid.Options + [dgEditing];

  dsBP.DataSet := dmJSO.CreateBP;
  dsBP.DataSet.Active := true;
  dsSrcStatus.DataSet := dmJSO.CreateOrderStatus;
  dsSrcStatus.DataSet.Active := true;
  dsResStatus.DataSet := dmJSO.CreateOrderStatus;
  dsResStatus.DataSet.Active := true;
  dsActions.DataSet := dmJSO.CreateActions;
  dsActions.DataSet.Active := true;
  FDSRef := dmJSO.CreateBPSpec(dsBP.DataSet, dsSrcStatus.DataSet, dsResStatus.DataSet, dsActions.DataSet);
  dsRef.DataSet := FDSRef;
  dsRef.DataSet.Active := true;
  BPSpecGrid.DataSet := TsprQuery(dsRef.DataSet);
  dbNav.DataSource := BPSpecGrid.DataSource;
  BPSpecGrid.Grid.Options := BPSpecGrid.Grid.Options + [dgEditing];
end;

procedure TfmBPSpecRef.FormDestroy(Sender: TObject);
var
  I: Integer;
  vDS: TDataSet;
begin
  BPSpecBasisGrid.DataSet := nil;
  BPSpecGrid.DataSet := nil;
  for I := 0 to Self.ComponentCount - 1 do
    if (Self.Components[I] is TDataSource) then
    begin
      vDS := TDataSource(Self.Components[I]).DataSet;
      if Assigned(vDS) then
      begin
        TDataSource(Self.Components[I]).DataSet := nil;
        FreeAndNil(vDS);
      end;
    end;
end;

procedure TfmBPSpecRef.FormCreate(Sender: TObject);
begin
  Initialize;
end;

procedure TfmBPSpecRef.dsRefDataChange(Sender: TObject; Field: TField);
begin
  if not (Assigned(FDSRef) and Assigned(FDSSpec)) then
    Exit;
    
  if FDSRef.FieldByName('id').AsInteger <> VarToInt(FDSSpec.Parameters.ParamByName('BPSpecId').Value, 0) then
  begin
    FDSSpec.Active := False;
    FDSSpec.Parameters.ParamByName('BPSpecId').Value :=FDSRef.FieldByName('id').AsInteger;
    FDSSpec.Active := True;
  end;
end;

end.
