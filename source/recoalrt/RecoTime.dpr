program RecoTime;

uses
  Windows,
  SysUtils,
  Classes,
  ComObj,
  ActiveX,
  ActiveDs_TLB,
  IniFiles,
  IdSMTP,
  IdMessage,
  IdText,
  IdCoderHeader,
  UIB;

type
  TSrvParam = record
    Server: string;
    Database: string;
    Username: string;
    Password: string;
  end;

type
  TUserInfo = record
    UserID: integer;
    UserName: string;
    FullName: string;
    CityName: string;
    Email: string;
    WorkTime: TDateTime;
    Enabled: Boolean;
  end;

type
  TSrvData = packed record
    Host: string[255];
    Port: integer;
    Username: string[255];
    Password: string[255];
  end;

type
  TMsgData = packed record
    From: string[255];
    Subject: string[255];
    Body: array[1..1024] of Char;
  end;

type
  TRecoTime = class(TObject)
    private
      procedure FAlert;
      procedure FWriteLog(AMessage: string);
      procedure FSendMail(AHost: string; APort: integer;
        AUsername, APassword, AFrom, ATo, ASubject, ABody: string);
      procedure FRunExec;
      procedure FOnInitializeISO(var ATransferHeader: TTransfer;
        var AHeaderEncoding: Char; var ACharSet: string);
      function FReplace(ATemplate: string; AUserInfo: TUserInfo): string;
      function FGetUserName: string;
      function FGetSrvParam: TSrvParam;
      function FConvertTime(AStrTime: string): TDateTime;
  end;

function ADsGetObject(lpszPathName: WideString; const riid: TGUID;
  out ppObject: Pointer): HRESULT; stdcall; external 'activeds.dll';

var
  FRecoTime: TRecoTime;

const
  PARAM_FILE = 'recotime.ini';
  RUN_FILE = 'recoclnt.exe';
  LIB_FILE = 'fbclient.dll';
  LOG_FILE = 'recoalrt.log';

{ TRecoTime }

procedure TRecoTime.FAlert;
var
  FUIBDatabase: TUIBDatabase;
  FUIBTransaction: TUIBTransaction;
  FUIBQuery: TUIBQuery;
  FSrvParam: TSrvParam;
  FADSystemInfo: IADsADSystemInfo;
  FADUserInfo: IADsUser;
  FStream: TMemoryStream;  
  FSrvData: TSrvData;
  FMsgData: TMsgData;
  FUserInfo: TUserInfo;
  FIsExistEntry: Boolean;
begin
  try
    FUserInfo.UserName := FGetUserName;
    { GET_LDAPINFO }
    FADSystemInfo := CreateOleObject('ADSystemInfo') as IADsADSystemInfo;
    ADsGetObject('LDAP://' + FADSystemInfo.UserName, IADsUser, Pointer(FADUserInfo));
    FUserInfo.UserName := FADUserInfo.Get('sAMAccountName');
    FUserInfo.FullName := FADUserInfo.Get('displayName');
    FUserInfo.CityName := FADUserInfo.Get('l');
  except
    on E: Exception do
    FWriteLog(E.Message);
  end;
  try
    FSrvParam := FGetSrvParam;
    if (FSrvParam.Database = '') then
    begin
      FWriteLog('Database name is not specified');
      Exit;
    end;
    { DATABASE }
    FUIBDatabase := TUIBDatabase.Create(nil);
    FUIBTransaction := TUIBTransaction.Create(nil);
    FUIBQuery := TUIBQuery.Create(nil);
    FUIBTransaction.DataBase := FUIBDatabase;
    FUIBQuery.Transaction := FUIBTransaction;
    FUIBDatabase.LibraryName := LIB_FILE;
    FUIBDatabase.DatabaseName := FSrvParam.Server + ':' + FSrvParam.Database;
    FUIBDatabase.UserName := FSrvParam.Username;
    FUIBDatabase.PassWord := FSrvParam.Password;
    FUIBQuery.FetchBlobs := True;
    { GET_USERINFO }
    FUIBQuery.BuildStoredProc('GET_USERINFO', False);
    FUIBQuery.Params.ByNameAsString['username'] := FUserInfo.UserName;
    FUIBQuery.Params.ByNameAsString['fullname'] := FUserInfo.FullName;
    FUIBQuery.Params.ByNameAsString['cityname'] := FUserInfo.CityName;
    FUIBQuery.Execute;
    FUserInfo.UserID := FUIBQuery.Fields.ByNameAsInteger['userid'];
    FUserInfo.Email := FUIBQuery.Fields.ByNameAsString['email'];
    FUserInfo.WorkTime := FConvertTime(FUIBQuery.Fields.ByNameAsString['worktime']);
    FUserInfo.Enabled := FUIBQuery.Fields.ByNameAsBoolean['enabled'];
    FUIBQuery.Close(etmCommit);
    if (not FUserInfo.Enabled) then Exit;
    { CHECK_ENTRY }
    FUIBQuery.BuildStoredProc('CHECK_ENTRY', False);
    FUIBQuery.Params.ByNameAsInteger['userid'] := FUserInfo.UserID;
    FUIBQuery.Params.ByNameAsDateTime['eventtime'] := Now;
    FUIBQuery.Execute;
    FIsExistEntry := FUIBQuery.Fields.ByNameAsBoolean['exist'];
    FUIBQuery.Close(etmCommit);
    { AFTER TIME }    
    if ((Time > FUserInfo.WorkTime) and (not FIsExistEntry)) then
    begin
      { RUNEXEC }    
      FRunExec;
      { PARAMID 0 }
      FStream := TMemoryStream.Create;
      FUIBQuery.SQL.Clear;
      FUIBQuery.SQL.Add('SELECT PARAMDATA FROM PARAMS WHERE PARAMID = :PARAMID');
      FUIBQuery.Params.ByNameAsInteger['paramid'] := 0;
      FUIBQuery.Open;
      FUIBQuery.Fields.ReadBlob('paramdata', FStream);
      FUIBQuery.Close(etmCommit);
      FStream.Read(FSrvData, SizeOf(FSrvData));
      FStream.Free;
      { PARAMID 1 }
      FStream := TMemoryStream.Create;
      FUIBQuery.SQL.Clear;
      FUIBQuery.SQL.Add('SELECT PARAMDATA FROM PARAMS WHERE PARAMID = :PARAMID');
      FUIBQuery.Params.ByNameAsInteger['paramid'] := 1;
      FUIBQuery.Open;
      FUIBQuery.Fields.ReadBlob('paramdata', FStream);
      FUIBQuery.Close(etmCommit);
      FStream.Read(FMsgData, SizeOf(FMsgData));
      FStream.Free;
      { SENDMAIL }
      FSendMail(FSrvData.Host, FSrvData.Port, FSrvData.Username,
      FSrvData.Password, FMsgData.From, FUserInfo.Email, FMsgData.Subject,
      FReplace(FMsgData.Body, FUserInfo));
    end;
    FUIBQuery.Free;
    FUIBTransaction.Free;
    FUIBDatabase.Free;
  except
    on E: Exception do
    FWriteLog(E.Message);
  end;
  FADUserInfo := nil;
  FADSystemInfo := nil;
end;

function TRecoTime.FGetSrvParam: TSrvParam;
var
  FIniFile: TIniFile;
begin
  try
    FIniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + PARAM_FILE);
    Result.Server := FIniFile.ReadString('general', 'server', 'localhost');
    Result.Database := FIniFile.ReadString('general', 'database', '');
    Result.Username := FIniFile.ReadString('general', 'username', '');
    Result.Password := FIniFile.ReadString('general', 'password', '');
    FIniFile.Free;
  except
    on E: Exception do
    FWriteLog(E.Message);
  end;
end;

function TRecoTime.FGetUserName: string;
var
  FUserName: array[0..255] of Char;
  FUserSize: Cardinal;
begin
  FUserSize := SizeOf(FUserName);
  Windows.GetUserName(@FUserName, FUserSize);
  Result := Trim(FUserName);
end;

function TRecoTime.FConvertTime(AStrTime: string): TDateTime;
begin
  if not TryStrToTime(AStrTime, Result) then
  Result := StrToTime('9:30');
end;

function TRecoTime.FReplace(ATemplate: string; AUserInfo: TUserInfo): string;
begin
  Result := ATemplate;
  Result := StringReplace(Result, '%USERNAME%', AUserInfo.UserName,
  [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '%FULLNAME%', AUserInfo.FullName,
  [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '%CITYNAME%', AUserInfo.CityName,
  [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '%WORKTIME%', TimeToStr(AUserInfo.WorkTime),
  [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '%EVENTTIME%',
  FormatDateTime('dd.mm.yyyy HH:nn', Now), [rfReplaceAll, rfIgnoreCase]);
end;

procedure TRecoTime.FRunExec;
var
  FStartupInfo: TStartupInfo;
  FProcessInfo: TProcessInformation;
  FCmdLine: string;
begin
  try
    FCmdLine := ExtractFilePath(ParamStr(0)) + RUN_FILE;
    ZeroMemory(@FStartupInfo, SizeOf(TStartupInfo));
    FStartupInfo.cb := SizeOf(TStartupInfo);
    CreateProcess(nil, PChar(FCmdLine), nil, nil, False, 0, nil, nil,
    FStartupInfo, FProcessInfo);
  except
    on E: Exception do
    FWriteLog(E.Message);
  end;
end;

procedure TRecoTime.FOnInitializeISO(var ATransferHeader: TTransfer;
  var AHeaderEncoding: Char; var ACharSet: string);
begin
  ACharSet := 'windows-1251';
end;

procedure TRecoTime.FSendMail(AHost: string; APort: integer; AUsername,
  APassword, AFrom, ATo, ASubject, ABody: string);
var
  FSMTP: TIdSMTP;
  FMessage: TIdMessage;
  FText: TIdText;
begin
  try
    if (ATo = '') then
    begin
      FWriteLog('Recipient address is not specified');
      Exit;
    end;
    FMessage := TIdMessage.Create(nil);
    FMessage.OnInitializeISO := FOnInitializeISO;
    FMessage.From.Address := AFrom;
    FMessage.Recipients.EMailAddresses := ATo;
    FMessage.Subject := ASubject;
    FText := TIdText.Create(FMessage.MessageParts);    
    FText.Body.Text := ABody;
    FText.ContentType := 'text/html';
    FText.CharSet := 'windows-1251';
    FText.ContentTransfer := '8bit';
    FSMTP := TIdSMTP.Create(nil);
    FSMTP.Host := AHost;
    FSMTP.Port := APort;
    FSMTP.Username := AUsername;
    FSMTP.Password := APassword;
    FSMTP.Connect;
    if (FSMTP.Connected) then
    begin
      FSMTP.Send(FMessage);
      FSMTP.Disconnect;
    end;
    FSMTP.Free;
    FText.Free;    
    FMessage.Free;
  except
    on E: Exception do
    FWriteLog(E.Message);
  end;
end;

procedure TRecoTime.FWriteLog(AMessage: string);
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

begin
  CoInitialize(nil);
  FRecoTime := TRecoTime.Create;
  FRecoTime.FAlert;
  FRecoTime.Free;
  CoUninitialize;
end.
