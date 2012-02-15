unit RecoLogon;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ComObj, ActiveX, RecoService_TLB, SensEvents_TLB, StdVcl, SysUtils, Windows;

type
  TRecoLogon = class(TAutoObject, ISensLogon)
  protected
    procedure DisplayLock(const bstrUserName: WideString); safecall;
    procedure DisplayUnlock(const bstrUserName: WideString); safecall;
    procedure Logoff(const bstrUserName: WideString); safecall;
    procedure Logon(const bstrUserName: WideString); safecall;
    procedure StartScreenSaver(const bstrUserName: WideString); safecall;
    procedure StartShell(const bstrUserName: WideString); safecall;
    procedure StopScreenSaver(const bstrUserName: WideString); safecall;
  private
    procedure FDoEvent;
    procedure FWriteLog(AMessage: string);
  end;

function WTSGetActiveConsoleSessionId: DWORD; stdcall;
external 'kernel32.dll';

function WTSQueryUserToken(SessionId: ULONG; var phToken: THandle): BOOL; stdcall;
external 'wtsapi32.dll';

implementation

uses ComServ;

const
  RUN_FILE = 'recoalrt.exe';
  LOG_FILE = 'recosrvc.log';

procedure TRecoLogon.FDoEvent;
var
  FStartupInfo: TStartupInfo;
  FProcessInfo: TProcessInformation;
  FToken: THandle;
  FCmdLine: string;
begin
  try
    FCmdLine := ExtractFilePath(ParamStr(0)) + RUN_FILE;
    if WTSQueryUserToken(WTSGetActiveConsoleSessionId, FToken) then
    begin
      ZeroMemory(@FStartupInfo, SizeOf(TStartupInfo));
      FStartupInfo.cb := SizeOf(TStartupInfo);
      CreateProcessAsUser(FToken, nil, PChar(FCmdLine), nil,
      nil, False, 0, nil, nil, FStartupInfo, FProcessInfo);
      CloseHandle(FToken);
    end;
  except
    on E: Exception do
    FWriteLog(E.Message);
  end;
end;

procedure TRecoLogon.FWriteLog(AMessage: string);
var
  FFileHandle: TextFile;
  FFileName: string;
begin
  try
    FFileName := GetEnvironmentVariable('TEMP') + '\' + LOG_FILE;
    AssignFile(FFileHandle, FFileName);
    if not FileExists(FFileName) then
    ReWrite(FFileHandle) else Append(FFileHandle);
    WriteLn(FFileHandle, FormatDateTime('[dd.mm.yyyy HH:nn:ss] ', Now) + AMessage);
    CloseFile(FFileHandle);
  except
  end;
end;

procedure TRecoLogon.DisplayLock(const bstrUserName: WideString);
begin

end;

procedure TRecoLogon.DisplayUnlock(const bstrUserName: WideString);
begin
  FDoEvent;
end;

procedure TRecoLogon.Logoff(const bstrUserName: WideString);
begin

end;

procedure TRecoLogon.Logon(const bstrUserName: WideString);
begin
  FDoEvent;
end;

procedure TRecoLogon.StartScreenSaver(const bstrUserName: WideString);
begin

end;

procedure TRecoLogon.StartShell(const bstrUserName: WideString);
begin

end;

procedure TRecoLogon.StopScreenSaver(const bstrUserName: WideString);
begin

end;

initialization
  TAutoObjectFactory.Create(ComServer, TRecoLogon, Class_RecoLogon,
    ciSingleInstance, tmApartment);
end.
