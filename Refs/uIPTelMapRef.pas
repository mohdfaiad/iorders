unit uIPTelMapRef;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, uSprGridFrm, DBCtrls, ExtCtrls, uSprQuery, DBGrids,
  uIPTelMapFrame, StdCtrls, ADOdb;

type
  TfmIPTelMapRef = class(TForm)
    Panel2: TPanel;
    dbNav: TDBNavigator;
    dsMain: TDataSource;
    MainGrid: TIPTelMapFrame;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FDS: TsprQuery;
  public
    { Public declarations }
    procedure Initialize;
  end;

var
  fmIPTelMapRef: TfmIPTelMapRef;

implementation

uses uDMJSO;

{$R *.dfm}

procedure TfmIPTelMapRef.Initialize;
begin
  FDS := dmJSO.CreateIPTelMap;
  dsMain.DataSet := FDS;

  MainGrid.DataSet := FDS;
  FDS.Active := true;
  MainGrid.Grid.Options := MainGrid.Grid.Options + [dgEditing];
end;

procedure TfmIPTelMapRef.FormDestroy(Sender: TObject);
var
  I: Integer;
  vDS: TDataSet;
begin
  MainGrid.DataSet := nil;
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

procedure TfmIPTelMapRef.FormCreate(Sender: TObject);
begin
  Initialize;
end;

end.
