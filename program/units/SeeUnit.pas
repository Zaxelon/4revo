unit SeeUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Menus, Spin, printers;

type
  TSeeForm = class(TForm)
    DBGrid1: TDBGrid;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    Label3: TLabel;
    SpinEdit1: TSpinEdit;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure change_exec;
  end;

var
  SeeForm: TSeeForm;

implementation

uses ForMeMComp, MainUserUnit;

{$R *.dfm}

procedure TSeeForm.FormShow(Sender: TObject);
begin
  checkbox1.Checked:=false;
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
  CoNSQL.ADOQuery2.SQL.Clear;
end;

procedure TSeeForm.ComboBox1Change(Sender: TObject);
begin
  change_exec;
end;

procedure TSeeForm.CheckBox1Click(Sender: TObject);
begin
  change_exec;
end;

procedure TSeeForm.SpinEdit1Change(Sender: TObject);
begin
  change_exec;
end;

procedure TSeeForm.change_exec;
var prior:integer;
begin
  DBGrid1.Visible:=true;
  if Checkbox1.Checked then prior:=1 else prior:=0;
  if (Combobox1.Text = '') and (SpinEdit1.Visible) then
  Begin
    CoNSQL.ADOQuery4.SQL.Text:='exec prowedwie NULL,NULL,0';
    CoNSQL.ADOQuery4.Open;
    SpinEdit1.Value:=0;
  end else
  if MainUserForm.show_your_atest = 3 then
  Begin
    Begin
      CoNSQL.TempQuery.SQL.Text:='select TOP 1 places from specialty WHERE name_spec = :1';
      CoNSQL.TempQuery.Parameters.ParseSQL(CoNSQL.TempQuery.SQL.Text,true);
      CoNSQL.TempQuery.Parameters.ParamByName('1').Value:= ComboBox1.text;
      CoNSQL.TempQuery.Open;
      SpinEdit1.Value:=CoNSQL.TempQuery.Fields.Fields[0].AsInteger;
      CoNSQL.ADOQuery4.SQL.Text:='exec ne_prowedwie :1,:2,:3';
      CoNSQL.ADOQuery4.Parameters.ParamByName('1').Value:= ComboBox1.text;
      CoNSQL.ADOQuery4.Parameters.ParamByName('2').Value:= prior;
      CoNSQL.ADOQuery4.Parameters.ParamByName('3').Value:= SpinEdit1.Value;
    end;
  end else
  if MainUserForm.show_your_atest = 2 then
  Begin
    Begin
      CoNSQL.TempQuery.SQL.Text:='select TOP 1 places from specialty WHERE name_spec = :1';
      CoNSQL.TempQuery.Parameters.ParseSQL(CoNSQL.TempQuery.SQL.Text,true);
      CoNSQL.TempQuery.Parameters.ParamByName('1').Value:= ComboBox1.text;
      CoNSQL.TempQuery.Open;
      SpinEdit1.Value:=CoNSQL.TempQuery.Fields.Fields[0].AsInteger;
      CoNSQL.ADOQuery4.SQL.Text:='exec polu_proh :1,:2,:3';
      CoNSQL.ADOQuery4.Parameters.ParseSQL(CoNSQL.ADOQuery4.SQL.Text,true);
      CoNSQL.ADOQuery4.Parameters.ParamByName('1').Value:= ComboBox1.text;
      CoNSQL.ADOQuery4.Parameters.ParamByName('2').Value:= prior;
      CoNSQL.ADOQuery4.Parameters.ParamByName('3').Value:= SpinEdit1.Value;
    end;
  end else
  if not(SpinEdit1.Visible) then
  Begin
  if ComboBox1.text='' then CoNSQL.ADOQuery4.SQL.Text:='exec sel_avg_atest NULL,NULL' else
    Begin
      CoNSQL.ADOQuery4.SQL.Text:='exec sel_avg_atest :1,:2';
      CoNSQL.ADOQuery4.Parameters.ParseSQL(CoNSQL.ADOQuery4.SQL.Text,true);
      CoNSQL.ADOQuery4.Parameters.ParamByName('1').Value:= ComboBox1.text;
      CoNSQL.ADOQuery4.Parameters.ParamByName('2').Value:= prior;
    end;
  end else
  Begin
    Begin
      CoNSQL.TempQuery.SQL.Text:='select TOP 1 places from specialty WHERE name_spec = :1';
      CoNSQL.TempQuery.Parameters.ParseSQL(CoNSQL.TempQuery.SQL.Text,true);
      CoNSQL.TempQuery.Parameters.ParamByName('1').Value:= ComboBox1.text;
      CoNSQL.TempQuery.Open;
      SpinEdit1.Value:=CoNSQL.TempQuery.Fields.Fields[0].AsInteger;
      CoNSQL.ADOQuery4.SQL.Text:='exec prowedwie :1,:2,:3';
      CoNSQL.ADOQuery4.Parameters.ParseSQL(CoNSQL.ADOQuery4.SQL.Text,true);
      CoNSQL.ADOQuery4.Parameters.ParamByName('1').Value:= ComboBox1.text;
      CoNSQL.ADOQuery4.Parameters.ParamByName('2').Value:= prior;
      CoNSQL.ADOQuery4.Parameters.ParamByName('3').Value:= SpinEdit1.Value;
    end;
  end;
  CoNSQL.ADOQuery4.Open;
  if not(CoNSQL.ADOQuery4.IsEmpty) then
  Begin
    DBGrid1.Columns[0].Width:=30;
    DBGrid1.Columns[1].Width:=100;
    DBGrid1.Columns[2].Width:=75;
    DBGrid1.Columns[3].Width:=100;
    DBGrid1.Columns[4].Width:=30;
    DBGrid1.Columns[0].Title.caption:='ID';
    DBGrid1.Columns[1].Title.caption:='Фамилия';
    DBGrid1.Columns[2].Title.caption:='Имя';
    DBGrid1.Columns[3].Title.caption:='Отчество';
    DBGrid1.Columns[4].Title.caption:='Балл';
  end else DBGrid1.Visible:=false;
  if Combobox1.Text = '' then
  Begin
    CoNSQL.MyRave.SetParam('po_spec','');
    CoNSQL.MyRave.SetParam('spec','');
  end else
  Begin
    CoNSQL.MyRave.SetParam('po_spec','по специальности:');
    CoNSQL.MyRave.SetParam('spec',Combobox1.Text);
  end;
end;

procedure TSeeForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  SeeForm.Label3.Visible:=false;
  SeeForm.SpinEdit1.Visible:=false;
  SeeForm.N1.Visible:=false;
end;

procedure TSeeForm.Button1Click(Sender: TObject);
Begin
  if MainUserForm.show_your_atest = 3 then
  Begin
    CoNSQL.MyRave.Close;
    CoNSQL.MyRave.ProjectFile:='.\ravki\Ne_postup.rav';
    CoNSQL.MyRave.Execute;
  end else
  if MainUserForm.show_your_atest = 2 then
  Begin
    CoNSQL.MyRave.Close;
    CoNSQL.MyRave.ProjectFile:='.\ravki\pol_proh.rav';
    CoNSQL.MyRave.Execute;
  end;
  if MainUserForm.show_your_atest = 1 then
  Begin
    if SpinEdit1.Visible then
    Begin
      CoNSQL.MyRave.Close;
      CoNSQL.MyRave.ProjectFile:='.\ravki\postup.rav';
      CoNSQL.MyRave.Execute;
    end else
    Begin
      CoNSQL.MyRave.Close;
      CoNSQL.MyRave.ProjectFile:='.\ravki\AllAbb.rav';
      CoNSQL.MyRave.Execute;
    end;
  end;
end;

end.
