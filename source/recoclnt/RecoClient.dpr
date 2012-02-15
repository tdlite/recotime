program RecoClient;

uses
  Forms,
  Main in 'Main.pas' {frmRecoClnt};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmRecoClnt, frmRecoClnt);
  Application.Run;
end.
