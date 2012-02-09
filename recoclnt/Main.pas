unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg, ComObj, ActiveX, IniFiles, IdSMTP,
  IdMessage, IdText, IdCoderHeader, ActiveDs_TLB, UIB;

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
  TfrmRecoclnt = class(TForm)
    imgHeader: TImage;
    imgWarning: TImage;    
    lblEntry: TStaticText;
    lblComment: TStaticText;
    txtComment: TMemo;
    btnSend: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TRecoThread = class(TThread)
    private
      FComment: string;
    protected
      procedure Execute; override;
      procedure FOnInitializeISO(var ATransferHeader: TTransfer;
        var AHeaderEncoding: Char; var ACharSet: string);
      procedure FSendMail(AHost: string; APort: integer; AUsername,
        APassword, AFrom, ATo, ASubject, ABody: string);
      procedure FWriteLog(AMessage: string);
      procedure FTerminate;
      function FGetSrvParam: TSrvParam;
      function FReplace(ATemplate: string; AUserInfo: TUserInfo): string;
    public
      procedure SetComment(AText: string);
  end;

function ADsGetObject(lpszPathName: WideString; const riid: TGUID;
  out ppObject: Pointer): HRESULT; stdcall; external 'activeds.dll';

var
  frmRecoclnt: TfrmRecoclnt;
  RecoThread: TRecoThread;

const
  PARAM_FILE = 'recotime.ini';
  LIB_FILE = 'fbclient.dll';  
  LOG_FILE = 'recoclnt.log';

implementation

{$R *.dfm}

procedure TfrmRecoclnt.btnSendClick(Sender: TObject);
begin
  if (Trim(txtComment.Lines.Text) = '') then
  begin
    MessageBox(Self.Handle, 'Поле комментария не может быть пустым.',
      'Уведомление', 64);
    Exit;
  end;
  RecoThread := TRecoThread.Create(True);
  RecoThread.FreeOnTerminate := True;
  RecoThread.SetComment(txtComment.Lines.Text);
  RecoThread.Resume;
  Self.Hide;
end;

procedure TfrmRecoclnt.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := False;
end;

procedure TfrmRecoclnt.FormCreate(Sender: TObject);
begin
lblEntry.Caption := 'Вход в систему был произведен после времени начала' +
  ' рабочего дня.' + #10#13 + 'Пожалуйста, укажите поясняющий' +
  ' комментарий для Вашего руководителя.';
end;

{ TRecoThread }

procedure TRecoThread.Execute;
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
begin
  inherited;
  try
    CoInitialize(nil);
    FSrvParam := FGetSrvParam;
    if (FSrvParam.Database = '') then
    begin
      FWriteLog('Database name is not specified');
      Synchronize(FTerminate);
      Exit;
    end;
    { GET_LDAPINFO }
    FADSystemInfo := CreateOleObject('ADSystemInfo') as IADsADSystemInfo;
    ADsGetObject('LDAP://' + FADSystemInfo.UserName, IADsUser, Pointer(FADUserInfo));
    FUserInfo.UserName := FADUserInfo.Get('sAMAccountName');
    FUserInfo.FullName := FADUserInfo.Get('displayName');
    FUserInfo.CityName := FADUserInfo.Get('l');
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
    FUIBQuery.Close(etmCommit);
    { SET_COMMENT }
    FUIBQuery.BuildStoredProc('SET_COMMENT', False);
    FUIBQuery.Params.ByNameAsInteger['userid'] := FUserInfo.UserID;
    FUIBQuery.Params.ByNameAsString['comment'] := FComment;
    FUIBQuery.Execute;
    FUIBQuery.Close(etmCommit);
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
    { PARAMID 2 }
    FStream := TMemoryStream.Create;
    FUIBQuery.SQL.Clear;
    FUIBQuery.SQL.Add('SELECT PARAMDATA FROM PARAMS WHERE PARAMID = :PARAMID');
    FUIBQuery.Params.ByNameAsInteger['paramid'] := 2;
    FUIBQuery.Open;
    FUIBQuery.Fields.ReadBlob('paramdata', FStream);
    FUIBQuery.Close(etmCommit);
    FStream.Read(FMsgData, SizeOf(FMsgData));
    FStream.Free;
    { SENDMAIL }
    FSendMail(FSrvData.Host, FSrvData.Port, FSrvData.Username,
    FSrvData.Password, FMsgData.From, FUserInfo.Email, FMsgData.Subject,
    FReplace(FMsgData.Body, FUserInfo));
    CoUninitialize;
  except
    on E: Exception do
    FWriteLog(E.Message);  
  end;
  Synchronize(FTerminate);
end;

procedure TRecoThread.FOnInitializeISO(var ATransferHeader: TTransfer;
  var AHeaderEncoding: Char; var ACharSet: string);
begin
  ACharSet := 'windows-1251';
end;

procedure TRecoThread.FSendMail(AHost: string; APort: integer; AUsername,
  APassword, AFrom, ATo, ASubject, ABody: string);
var
  FSMTP: TIdSMTP;
  FMessage: TIdMessage;
  FText: TIdText;
begin
  try
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

procedure TRecoThread.FWriteLog(AMessage: string);
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

procedure TRecoThread.FTerminate;
begin
  Application.Terminate;
end;

function TRecoThread.FReplace(ATemplate: string; AUserInfo: TUserInfo): string;
begin
  Result := ATemplate;
  Result := StringReplace(Result, '%USERNAME%', AUserInfo.UserName,
  [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '%FULLNAME%', AUserInfo.FullName,
  [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '%CITYNAME%', AUserInfo.CityName,
  [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '%COMMENT%', FComment,
  [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '%EVENTTIME%',
  FormatDateTime('dd.mm.yyyy HH:nn', Now), [rfReplaceAll, rfIgnoreCase]);
end;

function TRecoThread.FGetSrvParam: TSrvParam;
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

procedure TRecoThread.SetComment(AText: string);
begin
  FComment := AText;
end;

end.
