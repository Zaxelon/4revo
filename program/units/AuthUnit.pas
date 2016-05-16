unit AuthUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, inifiles;

type
  TAuthForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Label3: TLabel;
    ComboBox1: TComboBox;
    SpeedButton1: TSpeedButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ComboBox1Exit(Sender: TObject);

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

procedure TAuthForm.Button1Click(Sender: TObject);
var tmp:integer;
begin
MainUserForm.Npravka.Visible:=false;
MainUserForm.Nsee.Visible:=false;
MainUserForm.Nstar_sekt.Visible:=false;
MainUserForm.Nstar_admin.Visible:=false;
MainUserForm.Label2.Visible:=false;
MainUserForm.Edit1.Visible:=false;
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
      IniFile.WriteString('Auth','UserLogin',Edit1.Text);
      tmp:=IniFile.ReadInteger('StyleID',CoNSQL.UserName,0);
      if (tmp < 0) or (tmp >= MainUserForm.ComBobox1.Items.Count) then tmp:=0;
      MainUserForm.ComBobox1.ItemIndex:=tmp;
      CoNSQL.SkinIsRough.SkinName:=MainUserForm.ComBobox1.Items[MainUserForm.ComBobox1.ItemIndex];
      MainUserForm.ComboBox1Change(self);
      Edit2.Text:='';
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
  IniFile:=TIniFile.Create('./Config.ini');
  combobox1.Items.Add(IniFile.ReadString('DataBase','IPDef','127.0.0.1'));
  GetSQLServerNames(combobox1.Items,'',deathwing);
  combobox1.ItemIndex:=0;
end;

procedure TAuthForm.FormShow(Sender: TObject);
var tmp:integer;
begin
  Consql.ADOConnection1.Connected:=false;
  Edit1.Text:=IniFile.ReadString('Auth','UserLogin','');
  tmp:=IniFile.ReadInteger('Design','SkinID',0);
  if (tmp < 0) or (tmp >= MainUserForm.ComBobox1.Items.Count) then tmp:=0;
  MainUserForm.ComBobox1.ItemIndex:=tmp;
  CoNSQL.SkinIsRough.SkinName:=MainUserForm.ComBobox1.Items[MainUserForm.ComBobox1.ItemIndex];
end;

procedure TAuthForm.SpeedButton1Click(Sender: TObject);
begin
  IniFile.WriteString('DataBase','IPDef',Combobox1.Text);
end;

procedure TAuthForm.ComboBox1Exit(Sender: TObject);
begin
  Combobox1.TabStop:=false;
end;

end.
