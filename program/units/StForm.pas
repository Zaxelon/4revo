unit StForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, acDBGrid;

{****t* TStatistForm/TStatistForm
* NAME
* TStatistForm
* USAGE
* ����� �TSeeForm
* SYNOPSIS
*  TStatistForm = class(TForm)
* EXAMPLE
*  StatistForm: TStatistForm;
****}
type
  TStatistForm = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBGrid1: TsDBGrid;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StatistForm: TStatistForm;

implementation

uses ForMeMComp;

{$R *.dfm}

{****p* TStatistForm/Button1Click
* NAME
* TStatistForm.Button1Click
* USAGE
* ��������� ����������4
* SYNOPSIS
*  TStatistForm.Button1Click(Sender: TObject);
* EXAMPLE
*  Button1Click(self);
 ****}
procedure TStatistForm.Button1Click(Sender: TObject);
begin
  CoNSQL.ADOQuery4.SQL.Text:='exec gen_all_prow :1';
  CoNSQL.ADOQuery4.Parameters.ParseSQL(CoNSQL.ADOQuery4.SQL.Text,true);
  if Checkbox1.Checked then
  CoNSQL.ADOQuery4.Parameters.ParamByName('1').Value:=1 else
  CoNSQL.ADOQuery4.Parameters.ParamByName('1').Value:=0;
  try
    CoNSQL.ADOQuery4.ExecSQL;
  except
    showmessage('������ ��� ��������� ������ � �������');
  end;
  CoNSQL.ADOQuery4.SQL.Text:='SELECT name_spec AS [�������������], places AS [����],'+
  ' prowed AS [���������], ne_prowed AS [�� ���������],proh_ball AS [��������� ����] FROM abit_prow';
  try
    CoNSQL.ADOQuery4.Open;
  except
    showmessage('������ ��� ��������� ������ � �������');
  end;
  if not(CoNSQL.ADOQuery4.IsEmpty) then
  Begin
    StatistForm.DBGrid1.Columns[0].Width:=325;
    StatistForm.DBGrid1.Columns[1].Width:=30;
    StatistForm.DBGrid1.Columns[2].Width:=70;
    StatistForm.DBGrid1.Columns[3].Width:=80;
    StatistForm.DBGrid1.Columns[4].Width:=90;
  end;
end;

end.
