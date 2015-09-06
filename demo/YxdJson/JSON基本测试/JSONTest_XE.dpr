program JSONTest_XE;

uses
  Forms,
  Unit2 in 'Unit2.pas' {Form2},
  uLkJSON in 'uLkJSON.pas',
  QString in 'QString.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
