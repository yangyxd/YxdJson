program JSONChecker;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'JSON View';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
