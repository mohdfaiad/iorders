unit uIPTelMapFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uSprGridFrm, Menus, ImgList, Grids, DBGrids, ComCtrls, ToolWin,
  StdCtrls, Buttons, ExtCtrls;

type
  TIPTelMapFrame = class(TsprGridFrm)
    cbActive: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Initialize; override;
  protected
    procedure SetContext; override;
  end;

var
  IPTelMapFrame: TIPTelMapFrame;

implementation

{$R *.dfm}

procedure TIPTelMapFrame.SetContext;
begin
  if cbActive.Checked then
    DataSet.AddFilter('ActiveFilter', 'm.MDate is null', 'OwnFilters')
  else
    DataSet.DisableFilter('ActiveFilter');

  inherited;
end;

procedure TIPTelMapFrame.Initialize;
begin
  if Assigned(DataSet) then
  begin
    cbActive.Checked := True;
    SetContext;
  end;  
end;

end.
