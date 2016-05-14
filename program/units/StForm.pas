unit StForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, acDBGrid;

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

procedure TStatistForm.Button1Click(Sender: TObject);
begin
  CoNSQL.ADOQuery4.SQL.Text:='exec gen_all_prow :1';
  CoNSQL.ADOQuery4.Parameters.ParseSQL(CoNSQL.ADOQuery4.SQL.Text,true);
  if Checkbox1.Checked then
  CoNSQL.ADOQuery4.Parameters.ParamByName('1').Value:=1 else
  CoNSQL.ADOQuery4.Parameters.ParamByName('1').Value:=0;
  CoNSQL.ADOQuery4.ExecSQL;
  CoNSQL.ADOQuery4.SQL.Text:='SELECT name_spec AS [Специальность], places AS [Мест],'+
  ' prowed AS [Прошедшие], ne_prowed AS [Не прошедшие],proh_ball AS [Проходной балл] FROM abit_prow';
  CoNSQL.ADOQuery4.Open;
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
