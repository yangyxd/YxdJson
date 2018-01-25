program JSONChecker.D10;

uses
  Vcl.Forms,
  Unit2 in 'Unit2.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
