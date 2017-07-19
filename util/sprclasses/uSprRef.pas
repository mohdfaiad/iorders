unit uSprRef;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uSprGridFrm, DB, ExtCtrls, uSprQuery, DBGrids;

type
  TfmSprRef = class(TForm)
    PanelMain: TPanel;
    dsMain: TDataSource;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  protected

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; FrameClass: TsprGridFrmClass; DS: TsprQuery;
      ACaption: string; Editable: Boolean); overload;
  end;

var
  fmSprRef: TfmSprRef;

implementation

{$R *.dfm}


procedure TfmSprRef.FormDestroy(Sender: TObject);
var
  I: Integer;
  vDS: TDataSet;
begin
  for I := 0 to Self.ComponentCount - 1 do
    if Self.Components[I] is TsprGridFrm then
      TsprGridFrm(Self.Components[I]).DataSet := nil;

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

constructor TfmSprRef.Create(AOwner: TComponent; FrameClass: TsprGridFrmClass; DS: TsprQuery;
  ACaption: string; Editable: Boolean);
var
  vFrame: TsprGridFrm;
begin
  inherited Create(AOwner);
  Self.Caption := ACaption;
  dsMain.DataSet := DS;
  vFrame := FrameClass.Create(Self);
  vFrame.Name := 'MainFrame';
  vFrame.Parent := PanelMain;
  vFrame.Align := alClient;
  vFrame.DataSet := DS;
  DS.Active := true;
  if Editable then
    vFrame.Grid.Options := vFrame.Grid.Options + [dgEditing];
end;

end.
