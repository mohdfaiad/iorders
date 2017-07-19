unit uBPCtxFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uSprGridFrm, ImgList, Grids, DBGrids, StdCtrls, Buttons,
  ComCtrls, ExtCtrls, DB, DBCtrls, uDMJSO, UtilsBase, Menus, ToolWin;

type
  TBPCtxFrame = class(TsprGridFrm)
    dsCtxBP: TDataSource;
    Label1: TLabel;
    lcBP: TDBLookupComboBox;
    procedure lcBPKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Initialize; override;
  protected
    procedure SetContext; override;
  end;

var
  BPCtxFrame: TBPCtxFrame;

implementation

{$R *.dfm}

procedure TBPCtxFrame.Initialize;
begin
  inherited;
  dsCtxBP.DataSet := dmJSO.CreateBP;
  dsCtxBP.DataSet.Active := true;
end;

procedure TBPCtxFrame.SetContext;
begin
  if VarIsAssigned(lcBP.KeyValue) then
    DataSet.AddFilter('BPFilter', 's.BPId = ''' + VarToStr(lcBP.KeyValue) + '''', 'OwnFilters')
  else
    DataSet.DisableFilter('BPFilter');

  inherited;
end;

procedure TBPCtxFrame.lcBPKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_DELETE then
    lcBP.KeyValue := Null;
end;

end.
