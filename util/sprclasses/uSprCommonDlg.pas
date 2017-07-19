unit uSprCommonDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TSprCommonDlg = class(TForm)
    PanelResult: TPanel;
    OKBtn: TButton;
    CancelBtn: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SprCommonDlg: TSprCommonDlg;

implementation

{$R *.dfm}

end.
