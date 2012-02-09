program RecoTime;

uses
  Forms,
  Main in 'Main.pas' {frmRecoclnt};
  
{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmRecoclnt, frmRecoclnt);
  Application.Run;
end.
