object RecoSrvc: TRecoSrvc
  OldCreateOrder = False
  OnCreate = ServiceCreate
  DisplayName = 'RecoTime Service'
  OnContinue = ServiceContinue
  OnPause = ServicePause
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 150
  Width = 215
end
