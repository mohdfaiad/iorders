unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unit1, ExtCtrls, Unit2;

type
  TForm3 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.FormCreate(Sender: TObject);
begin
  width := 1;
  height := 1;
  top := -1;
  left := -1;
  TForm1.Execute;
end;

procedure TForm3.Timer1Timer(Sender: TObject);
var
  vForm: TForm;
begin
  vForm := TForm2.Create(nil);
  vForm.Show;
end;

end.
 