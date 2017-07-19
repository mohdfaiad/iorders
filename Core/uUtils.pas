unit uUtils;

interface

uses
  Windows, Messages, SysUtils, Variants;

  function GetComputerName: string;

implementation

const
  NERR_Success = 0;

function NetWkstaGetInfo(ServerName: LPWSTR; Level: DWORD;
  BufPtr: Pointer): Longint; stdcall;
  external 'netapi32.dll' Name 'NetWkstaGetInfo';

//function ProcessIdToSessionId(dwProcessId: DWORD;var pSessionId: DWORD): BOOL; stdcall; external kernel32 name 'ProcessIdToSessionId';

type
  WKSTA_INFO_100 = record
    wki100_platform_id: DWORD;
    wki100_computername: LPWSTR;
    wki100_langroup: LPWSTR;
    wki100_ver_major: DWORD;
    wki100_ver_minor: DWORD;
  end;
  LPWKSTA_INFO_100 = ^WKSTA_INFO_100;

  _USER_INFO_0 = record
    usri0_name: LPWSTR;
  end;

function GetNetParam(AParam: Integer): string;
var
  PBuf: LPWKSTA_INFO_100;
  Res: LongInt;
begin
  Result := '';
  Res := NetWkstaGetInfo(nil, 100, @PBuf);
  if Res = NERR_Success then
  begin
    case AParam of
      0: Result := string(PBuf^.wki100_computername);
      1: Result := string(PBuf^.wki100_langroup);
    end;
 end;
end;

function GetComputerName: string;
begin
  Result := GetNetParam(0);
end;

function GetDomainName: string;
begin
  Result := GetNetParam(1);
end;

{
function GetPCSystemName : WideString;
var
  lpBuf : PWideChar;
  nSi : DWORD;
begin
  Result := '';
  nSi := (1024 + 2) * SizeOf(WideChar);
  GetMem(lpBuf, nSi);
  try
    if GetComputerNameW(lpBuf, nSi) then Result := lpBuf;
  finally
    FreeMem(lpBuf);
  end;
end;

function GetPCClientName : WideString;
var
  nProcessID, nSessionID : DWORD;
  nByteCount : DWORD;
  acNameBuff : Pointer;
  tmpName   : WideString;
begin
  // Lokaler HostName
  Result := GetPCSystemName;
  nProcessID := GetCurrentProcessId;
  nSessionID := 0;
  //PROCESS_QUERY_INFORMATION wird benotigt fur ProcessIdToSessionID         "SeDebugPrivilege"
  // SessionID von aktueller ProcessID
  if ProcessIdToSessionID( nProcessID, nSessionID) then begin
    // Wenn in einer Session..
    if nSessionID > 0 then begin
      // Session ClientName
      if WTSQuerySessionInformationW(WTS_CURRENT_SERVER_HANDLE, nSessionId, WTSClientName, acNameBuff, nByteCount) then begin
        try
          tmpName := PWideChar(acNameBuff);
          // Da bei Vista kein Name vorhanden ist, auf Leerstring prufen!
          if tmpName <> '' then
            result := tmpName;
        finally
          WTSFreeMemory(acNameBuff);
        end;
      end;
    end;
  end;
end;      }

{function GetLocalPCName: String;
var
    Buffer: array [0..63] of AnsiChar;
    i: Integer;
    GInitData: TWSADATA;
begin
    Result := '';
    WSAStartup($101, GInitData);
    GetHostName(Buffer, SizeOf(Buffer));
    Result:=Buffer;
    WSACleanup;
end;   }


end.
