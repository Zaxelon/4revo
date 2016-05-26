unit ForMeMComp;

interface

uses
  SysUtils, Classes, ADODB, DB, RpCon, RpDefine, RpRave, RpConDS, RpRender,
  RpRenderCanvas, RpRenderPreview, sSkinManager, RpBase, RpSystem, inifiles;

{****t* TCoNSQL/TCoNSQL
* NAME
* TCoNSQL
* USAGE
* ����� ������ TCoNSQL
* SYNOPSIS
*  TCoNSQL = class(TForm)
* EXAMPLE
*  CoNSQL: TCoNSQL
****}
type
  TCoNSQL = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADOTable1: TADOTable;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    DataSource2: TDataSource;
    ADOTable2: TADOTable;
    ADOQuery3: TADOQuery;
    DataSource3: TDataSource;
    ADOQuery4: TADOQuery;
    RvDataSetConnection1: TRvDataSetConnection;
    MyRave: TRvProject;
    CheckRole: TADOQuery;
    TempQuery: TADOQuery;
    RvDtStCoN2: TRvDataSetConnection;
    SkinIsRough: TsSkinManager;
    procedure ADOQuery3BeforeInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    UserName,UserRole:string;
  end;

var
  CoNSQL: TCoNSQL;
  IniFile : TIniFile;
implementation

{$R *.dfm}

{****p* TCoNSQL/ADOQuery3BeforeInsert
* NAME
* TCoNSQL.ADOQuery3BeforeInsert
* USAGE
* ��������� ������� � ��
* SYNOPSIS
*  TCoNSQL.ADOQuery3BeforeInsert(DataSet: TDataSet);
* EXAMPLE
*  ADOQuery3BeforeInsert(DataSet1);
 ****}
procedure TCoNSQL.ADOQuery3BeforeInsert(DataSet: TDataSet);
begin
  if CoNSQL.UserRole = 'Star_Secretar' then
  Begin

  end else
  abort;
end;

end.
