program RecoService;

uses
  SvcMgr,
  Main in 'Main.pas',
  RecoService_TLB in 'RecoService_TLB.pas',
  SensEvents_TLB in 'SensEvents_TLB.pas';

{RecoSrvc: TService}

{$R *.TLB}

begin
  if not Application.DelayInitialize or Application.Installing then
  Application.Initialize;
  Application.CreateForm(TRecoSrvc, RecoSrvc);
  Application.Run;
end.
