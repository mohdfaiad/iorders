program Project1;

uses
  Forms,
  Windows,
  Unit1 in 'Unit1.pas' {MainForm},
  Unit2 in 'Unit2.pas' {Form2};

{$R *.res}

var
  MainForm: TMainForm;

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  ShowWindow(Application.Handle, SW_HIDE);
  Application.Run;
end.
