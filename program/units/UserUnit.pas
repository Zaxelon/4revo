unit UserUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm4 = class(TForm)
    Label2: TLabel;
    Edit1: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Label4: TLabel;
    Edit3: TEdit;
    ComboBox1: TComboBox;
    procedure FormHide(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure clearform;
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses ForMeMComp,MainUserUnit;

{$R *.dfm}

procedure TForm4.FormHide(Sender: TObject);
begin
  form4.Label4.Visible:=false;
  form4.Edit2.Visible:=false;
  CoNSQL.ADOQuery3.SQL.Text:='SELECT * FROM sel_user_deathwing';
  CoNSQL.ADOQuery3.Open;
end;

procedure TForm4.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  form4.Label4.Visible:=false;
  form4.Edit2.Visible:=false;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
try
  if not(rd) then
  Begin
    if (Edit1.Text<>'')and(Edit3.Text<>'')and(Combobox1.Items[Combobox1.ItemIndex]<>'')then
      Begin
        with CoNSQL do
        Begin
          ADOQuery3.Active:=false;
          adoquery4.SQL.Clear;
          adoquery4.SQL.Add('exec add_users :1,:2,:3');
          ADOQuery4.Parameters.ParseSQL(ADOQuery4.SQL.Text,true);
          Adoquery4.Parameters.ParamByName('1').Value:=Edit1.Text;
          Adoquery4.Parameters.ParamByName('2').Value:=Combobox1.Items[Combobox1.ItemIndex];
          Adoquery4.Parameters.ParamByName('3').Value:=Edit3.Text;
          adoquery4.ExecSQL;
          ADOQuery3.Active:=true;
          clearform;
          close;
        end;
      end else showmessage('Не все поля заполнены');
    CoNSQL.adoquery4.SQL.Clear;
  end else
  Begin
    if (Edit1.Text<>'')and(Combobox1.Items[Combobox1.ItemIndex]<>'')then
      Begin
      with CoNSQL do
        Begin
          adoquery4.SQL.Clear;
          adoquery4.SQL.Text:='exec update_users :1,:2,:3,:4';
          ADOQuery4.Parameters.ParseSQL(ADOQuery4.SQL.Text,true);
          Adoquery4.Parameters.ParamByName('1').Value:=ADOQuery3.Fields.Fields[0].asstring;
          Adoquery4.Parameters.ParamByName('2').Value:=Edit1.Text;
          Adoquery4.Parameters.ParamByName('3').Value:=Combobox1.Items[Combobox1.ItemIndex];
          Adoquery4.Parameters.ParamByName('4').Value:=Edit3.Text;
          adoquery4.ExecSQL;
          clearform;
          close;
        end;
      end else showmessage('Не все поля заполнены');
    CoNSQL.adoquery4.SQL.Clear;
  End;
  form4.Label4.Visible:=false;
  form4.Edit2.Visible:=false;
except
  on E: Exception do
  Showmessage('ERRoR: ' + E.Message);
end;
end;

procedure TForm4.clearform;
begin
  edit1.Text:='';
  edit2.Text:='';
  edit3.Text:='';
end;

procedure TForm4.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
  Key:=#0;
end;

procedure TForm4.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['a'..'z', 'A'..'Z', 'а'..'я', 'А'..'Я']) then Key := #0;
end;

procedure TForm4.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
  if (Key =' ')  then Key := #0;
end;

end.
