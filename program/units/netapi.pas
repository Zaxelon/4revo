unit NetAPI;

interface

uses Windows, Classes;

procedure GetSQLServerNames(Names: TStrings; const DomainName: string; const ServerType: DWORD);
function ScanDomainForSQLNames(List: TStrings; NetRes: PNetResource): Word;

implementation

const
 NERR_SUCCESS = 0;

 MAX_PREFERRED_LENGTH = DWORD(-1);

 SV_TYPE_WORKSTATION     = $00000001;
 SV_TYPE_SERVER          = $00000002;
 SV_TYPE_SQLSERVER       = $00000004;
 SV_TYPE_DOMAIN_CTRL     = $00000008;
 SV_TYPE_DOMAIN_BAKCTRL  = $00000010;
 SV_TYPE_TIME_SOURCE     = $00000020;
 SV_TYPE_AFP             = $00000040;
 SV_TYPE_NOVELL          = $00000080;
 SV_TYPE_DOMAIN_MEMBER   = $00000100;
 SV_TYPE_PRINTQ_SERVER   = $00000200;
 SV_TYPE_DIALIN_SERVER   = $00000400;
 SV_TYPE_XENIX_SERVER    = $00000800;
 SV_TYPE_SERVER_UNIX     = SV_TYPE_XENIX_SERVER;
 SV_TYPE_NT              = $00001000;
 SV_TYPE_WFW             = $00002000;
 SV_TYPE_SERVER_MFPN     = $00004000;
 SV_TYPE_SERVER_NT       = $00008000;
 SV_TYPE_POTENTIAL_BROWSER = $00010000;
 SV_TYPE_BACKUP_BROWSER  = $00020000;
 SV_TYPE_MASTER_BROWSER  = $00040000;
 SV_TYPE_DOMAIN_MASTER   = $00080000;
 SV_TYPE_SERVER_OSF      = $00100000;
 SV_TYPE_SERVER_VMS      = $00200000;
 SV_TYPE_WINDOWS         = $00400000; // Windows95 and above
 SV_TYPE_DFS             = $00800000; // Root of a DFS tree
 SV_TYPE_CLUSTER_NT      = $01000000; // NT Cluster
 SV_TYPE_DCE             = $10000000; // IBM DSS (Directory and Security Services) or equivalent
 SV_TYPE_ALTERNATE_XPORT = $20000000; // return list for alternate transport
 SV_TYPE_LOCAL_LIST_ONLY = $40000000; // Return local list only
 SV_TYPE_DOMAIN_ENUM     = $80000000;
 SV_TYPE_ALL             = $FFFFFFFF; //handy for NetServerEnum2

type
 TServerInfo101 = record
   platform_id: DWORD;
   name: PWideChar;
   version_major: DWORD;
   version_minor: DWORD;
   server_type: DWORD;
   comment: PWideChar;
 end;
 PServerInfo101 = ^TServerInfo101;

 TServerInfo100 = record
   platform_id: DWORD;
   name: PWideChar;
 end;
 PServerInfo100 = ^TServerInfo100;

function NetServerEnum(const ServerName: PWideString; level: DWORD; var Buffer: pointer;
PrefMaxLen: DWORD; var EntriesRead: DWORD; var TotalEntries: DWORD; ServerType: DWORD;
const Domain: PWideChar; var ResumeHandle: DWORD): DWORD; stdcall;
external 'netapi32.dll';

function NetApiBufferFree(Buffer: pointer): DWORD; stdcall;
external 'netapi32.dll';

procedure GetSQLServerNames(Names: TStrings; const DomainName: string; const ServerType: DWORD);
var
 Buffer: pointer;
 EntriesRead, i, ErrCode, ResumeHandle, TotalEntries: DWORD;
 DomainUnicode: array[0..100] of WideChar;
 PDomainUnicode: PWideChar;
 ServerInfo: PServerInfo101;
begin
 ResumeHandle:= 0;

 if (DomainName = '') then PDomainUnicode:= nil
 else begin
   StringToWideChar(DomainName, DomainUnicode, SizeOf(DomainUnicode));
   PDomainUnicode:= DomainUnicode;
 end;

 errCode:= NetServerEnum(nil, 101, Buffer, MAX_PREFERRED_LENGTH, EntriesRead, TotalEntries, ServerType, PDomainUnicode, ResumeHandle);
 if (errCode <> NERR_SUCCESS) then Exit;

 try
   ServerInfo:= Buffer;
   for i := 1 to EntriesRead do begin
     Names.Add(ServerInfo^.name);
     Inc(ServerInfo);
   end;
 finally
   NetApiBufferFree(Buffer);
 end;
end;

function ScanDomainForSQLNames(List: TStrings; NetRes: PNetResource): Word;
var
  ArNetRes: array[0..59] of TNetResource;
  i: integer;
  EntrReq, SizeReq: DWORD;
  hEnum: THandle;
  DomenName: string;
begin
 Result:= WNetOpenEnum(RESOURCE_GLOBALNET, RESOURCETYPE_ANY, RESOURCEUSAGE_CONTAINER, NetRes, hEnum);
 if Result = ERROR_NO_NETWORK then exit;
 if Result = NO_ERROR then begin
   EntrReq:= 1;
   SizeReq:= SizeOf(TNetResource) * 59;
   while (hEnum <> 0) and (WNetEnumResource(hEnum, EntrReq, @ArNetRes, SizeReq) <> ERROR_NO_MORE_ITEMS) do begin
     for i:= 0 To EntrReq - 1 do
       with ArNetRes[i] do begin
         case dwDisplayType of
           RESOURCEDISPLAYTYPE_DOMAIN: begin
             if lpRemoteName <> '' then DomenName:= lpRemoteName
                                   else DomenName:= lpComment;
             GetSQLServerNames(List, DomenName, SV_TYPE_SQLSERVER);
           end;
           else ScanDomainForSQLNames(List, @ArNetRes[i]);
         end;
       end;
   end;
   WNetCloseEnum(hEnum);
 end;
end;

end.

