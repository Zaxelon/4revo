unit StForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls;

type
  TStatistForm = class(TForm)
    DBGrid1: TDBGrid;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
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

procedure TStatistForm.FormShow(Sender: TObject);
begin
  DBGrid1.Columns[0].Width:=275;
  DBGrid1.Columns[1].Width:=70;
end;

procedure TStatistForm.Button1Click(Sender: TObject);
begin
  CoNSQL.ADOQuery4.SQL.Text:='exec drop_abit_prow';
  CoNSQL.ADOQuery4.ExecSQL;
  CoNSQL.ADOQuery4.SQL.Text:='exec sel_count_prow';
  CoNSQL.ADOQuery4.Open;
  DBGrid1.Columns[0].Width:=275;
  DBGrid1.Columns[1].Width:=70;
end;

end.
