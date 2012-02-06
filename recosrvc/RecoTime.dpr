program RecoTime;

uses
  SvcMgr,
  Main in 'Main.pas'; {RecoSrvc: TService}

{$R *.TLB}

begin
  if not Application.DelayInitialize or Application.Installing then
  Application.Initialize;
  Application.CreateForm(TRecoSrvc, RecoSrvc);
  Application.Run;
end.
