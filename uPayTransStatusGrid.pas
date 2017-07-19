unit uPayTransStatusGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uSprGridFrm, ImgList, Grids, DBGrids, StdCtrls, Buttons,
  ComCtrls, ExtCtrls, DBCtrls, uDMJSO, UtilsBase, Menus, ToolWin;

type
  TPayTransStatusGrid = class(TsprGridFrm)
    PanelOwnFilter: TPanel;
    lcPayTransStatus: TDBLookupComboBox;
    Label1: TLabel;
    procedure lcPayTransStatusKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  protected
    procedure SetContext; override;
  public
    { Public declarations }
    procedure Initialize; override;
  end;

var
  PayTransStatusGrid: TPayTransStatusGrid;

implementation

{$R *.dfm}

procedure TPayTransStatusGrid.Initialize;
begin
  inherited;
  if Assigned(lcPayTransStatus.ListSource) and Assigned(lcPayTransStatus.ListSource.DataSet) then
  begin
    lcPayTransStatus.ListSource.DataSet.Active := false;
    lcPayTransStatus.ListSource.DataSet.Active := true;
  end;
  lcPayTransStatus.KeyValue := 'C';
end;

procedure TPayTransStatusGrid.SetContext;
begin
  if VarIsAssigned(lcPayTransStatus.KeyValue) then
    DataSet.AddFilter('StatusFilter', 't.SignProcessed = ''' + VarToStr(lcPayTransStatus.KeyValue) + '''', 'OwnFilters')
  else
    DataSet.DisableFilter('StatusFilter');

  inherited;
end;

procedure TPayTransStatusGrid.lcPayTransStatusKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_DELETE then
    lcPayTransStatus.KeyValue := Null;
end;

end.
