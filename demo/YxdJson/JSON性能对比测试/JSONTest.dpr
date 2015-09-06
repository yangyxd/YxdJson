program JSON_Test_D2007;

uses
  Forms,
  uLkJSON in 'uLkJSON.pas',
  main in 'main.pas' {Form1};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
