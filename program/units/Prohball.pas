unit Prohball;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TProhForm = class(TForm)
    ComboBox1: TComboBox;
    Label2: TLabel;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    Label3: TLabel;
    SpinEdit1: TSpinEdit;
    Label4: TLabel;
    Label5: TLabel;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ProhForm: TProhForm;

implementation

uses ForMeMComp;

{$R *.dfm}

procedure TProhForm.FormShow(Sender: TObject);
begin
  checkbox1.Checked:=false;
  Label5.Caption:='';
  CoNSQL.adoquery2.SQL.Clear;
  CoNSQL.adoquery2.SQL.add('SELECT name_spec AS VGA FROM specialty');
  CoNSQL.adoquery2.open;
  ComboBox1.Clear;
  ComboBox1.Items.Add('');
  while not(CoNSQL.adoquery2.Eof) and (CoNSQL.adoquery2.RecordCount>0) do
  Begin
    ComboBox1.Items.Add(CoNSQL.adoquery2.fieldbyname('VGA').asstring);
    CoNSQL.adoquery2.Next;
  end;
end;

procedure TProhForm.Button1Click(Sender: TObject);
var prior:integer;
begin
  if checkbox1.Checked then prior:=1 else prior:=0;
    CoNSQL.ADOQuery4.SQL.Text:='exec proh_ball :1,:2,:3';
    CoNSQL.ADOQuery4.Parameters.ParseSQL(CoNSQL.ADOQuery4.SQL.Text,true);
    CoNSQL.ADOQuery4.Parameters.ParamByName('1').Value:= ComboBox1.text;
    CoNSQL.ADOQuery4.Parameters.ParamByName('2').Value:= prior;
    CoNSQL.ADOQuery4.Parameters.ParamByName('3').Value:= SpinEdit1.Value;
    CoNSQL.ADOQuery4.Open;
    if (CoNSQL.ADOQuery4.FieldByName('APoL').AsString = 'FALSE') then
    Label5.Caption:='Нет' else
    Label5.Caption:=CoNSQL.ADOQuery4.FieldByName('APoL').AsString
end;

procedure TProhForm.ComboBox1Change(Sender: TObject);
begin
  CoNSQL.TempQuery.SQL.Text:='select TOP 1 places from specialty WHERE name_spec = :1';
  CoNSQL.TempQuery.Parameters.ParseSQL(CoNSQL.TempQuery.SQL.Text,true);
  CoNSQL.TempQuery.Parameters.ParamByName('1').Value:= ComboBox1.text;
  CoNSQL.TempQuery.Open;
  SpinEdit1.Value:=CoNSQL.TempQuery.Fields.Fields[0].AsInteger;
end;

end.
