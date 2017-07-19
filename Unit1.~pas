unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TForm1 = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure Execute;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

class procedure TForm1.Execute;
var
  vForm: TForm;
begin
  vForm := TForm1.Create(nil);
  vForm.Show;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Screen.FormCount = 1 then
    Application.Terminate;
  Action := caFree;
end;

end.
