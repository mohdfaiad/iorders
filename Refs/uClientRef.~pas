unit uClientRef;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uSprGridFrm, DBCtrls, ExtCtrls, DB, uSprQuery, DBGrids, ComCtrls;

type
  TfmClientRef = class(TForm)
    ClientGrid: TsprGridFrm;
    dsClientType: TDataSource;
    dsClient: TDataSource;
    pcDetails: TPageControl;
    Splitter1: TSplitter;
    tsAppeal: TTabSheet;
    AppealGrid: TsprGridFrm;
    dsAppeal: TDataSource;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dsClientDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    FDSClient: TsprQuery;
    FDSAppeal: TsprQuery;
  public
    { Public declarations }
    procedure Initialize;
  end;

var
  fmClientRef: TfmClientRef;

implementation

uses uDMJSO;

{$R *.dfm}

procedure TfmClientRef.Initialize;
begin
  dmJSO.GetAppeal(FDSAppeal, '', False);
  dsAppeal.DataSet := FDSAppeal;
  dsAppeal.DataSet.Active := true;
  AppealGrid.DataSet := FDSAppeal;

  dsClientType.DataSet := dmJSO.CreateClientType;
  dsClientType.DataSet.Active := true;
  FDSClient := dmJSO.CreateClient(True, dsClientType.DataSet);
  FDSClient.Active := true;
  dsClient.DataSet := FDSClient;

  ClientGrid.DataSet := FDSClient;
  //ClientGrid.Grid.Options := ClientGrid.Grid.Options + [dgEditing];
end;

procedure TfmClientRef.FormDestroy(Sender: TObject);
var
  I: Integer;
  vDS: TDataSet;
begin
  ClientGrid.DataSet := nil;
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

procedure TfmClientRef.FormCreate(Sender: TObject);
begin
  Initialize;
end;

procedure TfmClientRef.dsClientDataChange(Sender: TObject; Field: TField);
begin
  if not (Assigned(FDSAppeal) and Assigned(FDSAppeal)) then
    Exit;
    
  if FDSClient.FieldByName('MPhone').AsString <> VarToStr(FDSAppeal.Parameters.ParamByName('MPhone').Value) then
  begin
    FDSAppeal.Active := False;
    FDSAppeal.Parameters.ParamByName('MPhone').Value := FDSClient.FieldByName('MPhone').AsString;
    FDSAppeal.Active := True;
  end;

end;

end.
