unit atestat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ComCtrls, Mask;

{****t* TAddObweeForm/TAtest_form
* NAME
* TAtest_form
* USAGE
* Форма TAtest_form
* SYNOPSIS
*  TAtest_form = class(TForm)
* EXAMPLE
*  Atest_form: TAtest_form;
****}
type
  TAtest_form = class(TForm)
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label8: TLabel;
    CheckBox1: TCheckBox;
    Label5: TLabel;
    Label4: TLabel;
    Edit5: TDateTimePicker;
    Edit3: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Atest_form: TAtest_form;

implementation

{$R *.dfm}
uses ForMeMComp, add_abiture;

{****p* TAtest_form/Button2Click
* NAME
* TAtest_form.Button2Click
* USAGE
* Закрыть TAddObweeForm с сохранением
* SYNOPSIS
*  TAtest_form.Button2Click(Sender: TObject);
* EXAMPLE
*  Button2Click(self);
 ****}
procedure TAtest_form.Button2Click(Sender: TObject);
begin
  if ((length(Edit1.Text)=6) and (edit2.Text<>'') and (Edit5.date<Date) and
  (strtofloat(edit3.Text) >= 3) and (strtofloat(edit3.Text) <= 5) ) then
  Begin
    close;
    addstudform.Label5.Caption:='+';
    addstudform.Label5.Font.Color:=clgreen;
  end else
  Begin
    showmessage('Не все поля верно заполнены');
  end;
end;

{****p* TAtest_form/Edit1KeyPress
* NAME
* TAtest_form.Edit1KeyPress
* USAGE
* Проверка ввода
* SYNOPSIS
*  TAtest_form.Edit1KeyPress(Sender: TObject; var Key: Char);
* EXAMPLE
*  Edit1KeyPress(self,#39);
 ****}
procedure TAtest_form.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#08]) then Key := #0;
end;

{****p* TAtest_form/Edit3KeyPress
* NAME
* TAtest_form.Edit3KeyPress
* USAGE
* Проверка ввода
* SYNOPSIS
*  TAtest_form.Edit3KeyPress(Sender: TObject; var Key: Char);
* EXAMPLE
*  Edit3KeyPress(self,#39);
 ****}
procedure TAtest_form.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',',',#08]) then Key := #0;
end;

{****p* TAtest_form/FormCloseQuery
* NAME
* TAtest_form.FormCloseQuery
* USAGE
* Закрыть TAtest_form с проверкой
* SYNOPSIS
*  TAtest_form.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
* EXAMPLE
*  FormCloseQuery(self,true);
 ****}
procedure TAtest_form.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not((length(Edit1.Text)=6) and (edit2.Text<>'') and (Edit5.date<Date) and
  (strtofloat(edit3.Text) >= 3) and (strtofloat(edit3.Text) <= 5) ) then
  Begin
    addstudform.Label5.Caption:='X';
    addstudform.Label5.Font.Color:=clred;
  end;
  CoNSQL.ADOQuery2.SQL.Clear;
end;

end.
