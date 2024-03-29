unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  ActiveX, ComObj, EventSystemLib_TLB, SensEvents_TLB, RecoService_TLB,
  RecoLogon;

type
  TRecoSrvc = class(TService)
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServiceCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

type
  TRecoThread = class(TThread)
    private
      FRecoLogon: ISensLogon;
      FEventSystem: IEventSystem;
      FEventSubscription: IEventSubscription;
      procedure FLockWorkStation;
      function FGetCurrentDay: WORD;
    protected
      procedure Execute; override;
  end;

function WTSGetActiveConsoleSessionId: DWORD; stdcall;
external 'kernel32.dll';

function WTSQueryUserToken(SessionId: ULONG; var phToken: THandle): BOOL; stdcall;
external 'wtsapi32.dll';

var
  RecoSrvc: TRecoSrvc;
  RecoThread: TRecoThread;

const
  SUBSCRIPTION_ID = '{2534833C-FF7F-418E-A4CE-A3F68FE3761C}';
  SENSGUID_EVENTCLASS_LOGON = '{d5978630-5b9f-11d1-8dd2-00aa004abd5e}';

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  RecoSrvc.Controller(CtrlCode);
end;

function TRecoSrvc.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TRecoSrvc.ServiceContinue(Sender: TService; var Continued: Boolean);
begin
  RecoThread.Resume;
  Continued := True;
  ReportStatus;
end;

procedure TRecoSrvc.ServicePause(Sender: TService; var Paused: Boolean);
begin
  RecoThread.Suspend;
  Paused := True;
  ReportStatus;
end;

procedure TRecoSrvc.ServiceStart(Sender: TService; var Started: Boolean);
begin
  RecoThread.Resume;
  Started := True;
  ReportStatus;
end;

procedure TRecoSrvc.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  RecoThread.Terminate;
  Stopped := True;
  ReportStatus;
end;

procedure TRecoSrvc.ServiceCreate(Sender: TObject);
begin
  RecoThread := TRecoThread.Create(True);
  RecoThread.FreeOnTerminate := True;
end;

{ TRecoThread }

procedure TRecoThread.Execute;
var
  FMessage: TMSG;
  FErrorIndex: integer;
  FToday: WORD;
begin
  inherited;
  try
    CoInitializeEx(nil, COINIT_MULTITHREADED);
    FRecoLogon := CoRecoLogon.Create;
    CoCreateInstance(ProgIdToClassId('EventSystem.EventSubscription'), nil,
    CLSCTX_SERVER, IID_IEventSubscription, FEventSubscription);
    FEventSubscription.SubscriptionID := SUBSCRIPTION_ID;
    FEventSubscription.SubscriptionName := 'RecoLogon';
    FEventSubscription.EventClassID := SENSGUID_EVENTCLASS_LOGON;
    FEventSubscription.SubscriberInterface := FRecoLogon;
    CoCreateInstance(ProgIdToClassId('EventSystem.EventSystem'), nil,
    CLSCTX_SERVER, IID_IEventSystem, FEventSystem);
    FEventSystem.Store('EventSystem.EventSubscription', FEventSubscription);
    FToday := FGetCurrentDay;
    while (not Self.Terminated) do
    begin
      PeekMessage(FMessage, 0, 0, 0, PM_REMOVE);
      DispatchMessage(FMessage);
      if (FToday <> FGetCurrentDay) then
      begin
        FToday := FGetCurrentDay;
        FLockWorkStation;
      end;
      Sleep(1000);
    end;
    CoCreateInstance(ProgIdToClassId('EventSystem.EventSystem'), nil,
    CLSCTX_SERVER, IID_IEventSystem, FEventSystem);
    FEventSystem.Remove('EventSystem.EventSubscription',
    'SubscriptionID == ' + SUBSCRIPTION_ID, FErrorIndex);
    FEventSubscription := nil;
    FEventSystem := nil;
    CoUninitialize;
  except
  end;
end;

procedure TRecoThread.FLockWorkStation;
var
  FStartupInfo: TStartupInfo;
  FProcessInfo: TProcessInformation;
  FToken: THandle;
const
  RUN_FILE = 'rundll32.exe user32.dll,LockWorkStation';
begin
  try
    if WTSQueryUserToken(WTSGetActiveConsoleSessionId, FToken) then
    begin
      ZeroMemory(@FStartupInfo, SizeOf(TStartupInfo));
      FStartupInfo.cb := SizeOf(TStartupInfo);
      CreateProcessAsUser(FToken, nil, PChar(RUN_FILE), nil,
      nil, False, 0, nil, nil, FStartupInfo, FProcessInfo);
      CloseHandle(FToken);
    end
    else LockWorkStation;
  except
  end;
end;

function TRecoThread.FGetCurrentDay: WORD;
var
  FSystemTime: TSystemTime;
begin
  GetLocalTime(FSystemTime);
  Result := FSystemTime.wDay;
end;

end.
