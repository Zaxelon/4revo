unit Add_obwee;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask, sMaskEdit, sCustomComboEdit, sToolEdit;

{****t* TAddObweeForm/TAddObweeForm
* NAME
* TAddObweeForm
* USAGE
* Форма TAddObweeForm
* SYNOPSIS
*  TAddObweeForm = class(TForm)
* EXAMPLE
*  AddObweeForm: TAddObweeForm;
****}
type
  TAddObweeForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    CheckBox1: TCheckBox;
    Button2: TButton;
    Edit5: TDateTimePicker;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit6KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddObweeForm: TAddObweeForm;

implementation

{$R *.dfm}
uses ForMeMComp,add_abiture;

{****p* TAddObweeForm/Button1Click
* NAME
* TAddObweeForm.Button1Click
* USAGE
* Закрыть TAddObweeForm
* SYNOPSIS
*  TAddObweeForm.Button1Click(Sender: TObject);
* EXAMPLE
*  Button1Click(self);
 ****}
procedure TAddObweeForm.Button1Click(Sender: TObject);
begin
  close;
end;

{****p* TAddObweeForm/Button2Click
* NAME
* TAddObweeForm.Button2Click
* USAGE
* Закрыть TAddObweeForm с сохранение
* SYNOPSIS
*  TAddObweeForm.Button2Click(Sender: TObject);
* EXAMPLE
*  Button2Click(self);
 ****}
procedure TAddObweeForm.Button2Click(Sender: TObject);
begin
  if (length(Edit6.Text) < 6) then showmessage('Номер телефона введен не верно') else
  if (edit1.Text<>'') and (edit2.Text<>'') and (edit3.Text<>'') and (Edit5.date<Date) and
  (edit6.Text<>'') and (edit7.Text<>'') then
  Begin
    close;
    addstudform.Label1.Caption:='+';
    addstudform.Label1.Font.Color:=clgreen;
  end else
  Begin
    showmessage('Не все поля верно заполнены');
  end;
end;

{****p* TAddObweeForm/FormCloseQuery
* NAME
* TAddObweeForm.FormCloseQuery
* USAGE
* Закрыть TAddObweeForm с проверкой
* SYNOPSIS
*  TAddObweeForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
* EXAMPLE
*  FormCloseQuery(self);
 ****}
procedure TAddObweeForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not((edit1.Text<>'') and (edit2.Text<>'') and (edit3.Text<>'') and (Edit5.date<date) and
  (length(Edit6.Text) > 5) and (edit7.Text<>'')) then
  Begin
    addstudform.Label1.Caption:='X';
    addstudform.Label1.Font.Color:=clred;
  end;
  CoNSQL.ADOQuery2.SQL.Clear;
end;

{****p* TAddObweeForm/Edit1KeyPress
* NAME
* TAddObweeForm.Edit1KeyPress
* USAGE
* Проверка ввода
* SYNOPSIS
*  TAddObweeForm.Edit1KeyPress(Sender: TObject; var Key: Char);
* EXAMPLE
*  Edit1KeyPress(self,#39);
 ****}
procedure TAddObweeForm.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['a'..'z', 'A'..'Z', 'а'..'я', 'А'..'Я',#08]) then Key := #0;
end;

{****p* TAddObweeForm/Edit6KeyPress
* NAME
* TAddObweeForm.Edit6KeyPress
* USAGE
* Проверка ввода
* SYNOPSIS
*  TAddObweeForm.Edit6KeyPress(Sender: TObject; var Key: Char);
* EXAMPLE
*  Edit6KeyPress(self,#39);
 ****}
procedure TAddObweeForm.Edit6KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#08]) then Key := #0;
end;

end.
