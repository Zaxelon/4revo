unit SeeUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Menus, Spin, printers, acDBGrid,
  sEdit, sSpinEdit;

{****t* TSeeForm/TSeeForm
* NAME
* TSeeForm
* USAGE
* Форма TSeeForm
* SYNOPSIS
*  TSeeForm = class(TForm)
* EXAMPLE
*  SeeForm: TSeeForm;
****}
type
  TSeeForm = class(TForm)
    ComboBox1: TComboBox;
    Label2: TLabel;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Button1: TButton;
    DBGrid1: TsDBGrid;
    SpinEdit1: TsSpinEdit;
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

{****p* TSeeForm/FormShow
* NAME
* TSeeForm.FormShow
* USAGE
* Обработка отображения TSeeForm
* SYNOPSIS
*  TSeeForm.FormShow(Sender: TObject);
* EXAMPLE
*  FormShow(self);
 ****}
procedure TSeeForm.FormShow(Sender: TObject);
begin
  checkbox1.Checked:=false;
  CoNSQL.adoquery2.SQL.Clear;
  CoNSQL.adoquery2.SQL.text:='SELECT name_spec AS VGA FROM specialty';
  try
    CoNSQL.adoquery2.open;
    ComboBox1.Clear;
    while not(CoNSQL.adoquery2.Eof) and (CoNSQL.adoquery2.RecordCount>0) do
    Begin
      ComboBox1.Items.Add(CoNSQL.adoquery2.fieldbyname('VGA').asstring);
      CoNSQL.adoquery2.Next;
    end;
  except
    showmessage('Ошибка при получении данных с сервера');
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

{****p* TSeeForm/change_exec
* NAME
* TSeeForm.change_exec
* USAGE
* Обновление бдгрид
* SYNOPSIS
*  TSeeForm.change_exec;
* EXAMPLE
*  change_exec;
 ****}
procedure TSeeForm.change_exec;
var prior:integer;
begin
  DBGrid1.Visible:=true;
  if Checkbox1.Checked then prior:=1 else prior:=0;
  if (Combobox1.Text = '') and (SpinEdit1.Visible) then
  Begin
    CoNSQL.ADOQuery4.SQL.Text:='exec prowedwie NULL,NULL,0';
    try
      CoNSQL.ADOQuery4.Open;
    except
      showmessage('Ошибка при получении данных с сервера');
    end;
    SpinEdit1.Value:=0;
  end else
  if MainUserForm.show_your_atest = 3 then
  Begin
    Begin
      CoNSQL.TempQuery.SQL.Text:='select TOP 1 places from specialty WHERE name_spec = :1';
      CoNSQL.TempQuery.Parameters.ParseSQL(CoNSQL.TempQuery.SQL.Text,true);
      CoNSQL.TempQuery.Parameters.ParamByName('1').Value:= ComboBox1.text;
      try
        CoNSQL.TempQuery.Open;
      except
        showmessage('Ошибка при получении данных с сервера');
      end;
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
      try
        CoNSQL.TempQuery.Open;
      except
        showmessage('Ошибка при получении данных с сервера');
      end;
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
      try
        CoNSQL.TempQuery.Open;
      except
        showmessage('Ошибка при получении данных с сервера');
      end;
      SpinEdit1.Value:=CoNSQL.TempQuery.Fields.Fields[0].AsInteger;
      CoNSQL.ADOQuery4.SQL.Text:='exec prowedwie :1,:2,:3';
      CoNSQL.ADOQuery4.Parameters.ParseSQL(CoNSQL.ADOQuery4.SQL.Text,true);
      CoNSQL.ADOQuery4.Parameters.ParamByName('1').Value:= ComboBox1.text;
      CoNSQL.ADOQuery4.Parameters.ParamByName('2').Value:= prior;
      CoNSQL.ADOQuery4.Parameters.ParamByName('3').Value:= SpinEdit1.Value;
    end;
  end;
  try
    CoNSQL.ADOQuery4.Open;
  except
    showmessage('Ошибка при получении данных с сервера');
  end;
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

{****p* TSeeForm/FormCloseQuery
* NAME
* TSeeForm.FormCloseQuery
* USAGE
* Закрыть TSeeForm с откатом изменений
* SYNOPSIS
*  TSeeForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
* EXAMPLE
*  FormCloseQuery(self,true);
 ****}
procedure TSeeForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  SeeForm.Label3.Visible:=false;
  SeeForm.SpinEdit1.Visible:=false;
  SeeForm.N1.Visible:=false;
end;

{****p* TSeeForm/Button1Click
* NAME
* TSeeForm.Button1Click
* USAGE
* Генерация отчета из бдгрид
* SYNOPSIS
*  TSeeForm.Button1Click(Sender: TObject);
* EXAMPLE
*  Button1Click(self);
 ****}
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
