program POSOH;

uses
  System.StartUpCopy,
  FMX.Forms,
  main in 'main.pas' {MainFrm},
  VarDialog in 'VarDialog.pas' {DialogFrm},
  test in 'test.pas' {TestFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainFrm, MainFrm);
  Application.CreateForm(TDialogFrm, DialogFrm);
  Application.CreateForm(TTestFrm, TestFrm);
  Application.Run;
end.
