unit AuthUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TAuthForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Label3: TLabel;
    ComboBox1: TComboBox;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormPaint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AuthForm: TAuthForm;

implementation
uses ForMeMComp, MainUserUnit, ADODB, Netapi, atestat;
{$R *.dfm}

procedure TAuthForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  application.Terminate;
end;

procedure TAuthForm.FormPaint(Sender: TObject);
var deathwing:cardinal;
Begin
  
end;

procedure TAuthForm.Button1Click(Sender: TObject);
begin
MainUserForm.Npravka.Visible:=false;
MainUserForm.Nsee.Visible:=false;
MainUserForm.Nstar_sekt.Visible:=false;
MainUserForm.Nstar_admin.Visible:=false;
Label3.Caption:='';
  if Edit1.Text='' then Label3.Caption:='Введите логин.' else
  if Edit2.Text='' then Label3.Caption:='Введите пароль.' else
    Begin
    CoNSQL.ADOConnection1.ConnectionString:='Provider=SQLOLEDB.1;Password='+Edit2.Text+
    ';Persist Security Info=True;User ID='+Edit1.Text+
    ';Initial Catalog=priemka;Data Source='+combobox1.Items[combobox1.ItemIndex];;
    try
      CoNSQL.adoconnection1.Connected:=true;
    except
    begin
      Label3.Caption:='Ошибка авторизации.';
    end;
   end;
  end;
  if CoNSQL.ADOConnection1.Connected then
    Begin
      if (Edit1.Text = 'sa') then
      Begin
        showmessage('Access denied');
        halt;
      end else
      Begin
        CoNSQL.CheckRole.SQL.Text:='declare @i varchar(50); set @i = SYSTEM_USER; exec sp_helpuser @i';
        CoNSQL.CheckRole.Open;
        CoNSQL.CheckRole.First;
        if not(CoNSQL.CheckRole.IsEmpty) then
        Begin
          CoNSQL.UserName:=CoNSQL.CheckRole.FieldByName('UserName').AsString;
          CoNSQL.UserRole:=CoNSQL.CheckRole.FieldByName('RoleName').AsString;
          if (CoNSQL.CheckRole.FieldByName('RoleName').Asstring = 'Admun') then
          Begin
            MainUserForm.Nstar_admin.Visible:=true;
            MainUserForm.Caption:='RapidZ - Администратор';
          end else
          if (CoNSQL.CheckRole.FieldByName('RoleName').Asstring = 'Star_Secretar') then
          Begin
            MainUserForm.Nstar_sekt.Visible:=true;
            MainUserForm.Caption:='RapidZ - Старший секретарь';
          end else
          if (CoNSQL.CheckRole.FieldByName('RoleName').Asstring = 'Secretar') then
          Begin
            MainUserForm.Nsee.Visible:=true;
            MainUserForm.Npravka.Visible:=true;
            MainUserForm.Label2.Visible:=true;
            MainUserForm.Edit1.Visible:=true;
            MainUserForm.Caption:='RapidZ - Cекретарь';
          end;
        end;
      end;
      AuthForm.Hide;
      MainUserForm.Show;
    end;
end;

procedure TAuthForm.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then AuthForm.Button1Click(self);
end;

procedure TAuthForm.FormCreate(Sender: TObject);
var deathwing:cardinal;
Begin
  GetSQLServerNames(combobox1.Items,'',deathwing);
  if (combobox1.Items.Count = 0) then combobox1.Items.Add('YNIKIT\SQLEXPRESS');
  combobox1.ItemIndex:=0;
end;

procedure TAuthForm.FormShow(Sender: TObject);
begin
  Consql.ADOConnection1.Connected:=false;
end;

end.
