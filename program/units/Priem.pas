unit Priem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

{****t* TPriem_form/TPriem_form
* NAME
* TPriem_form
* USAGE
* Форма TPriem_form
* SYNOPSIS
*  TPriem_form = class(TForm)
* EXAMPLE
*  Priem_form: TPriem_form;
****}
type
  TPriem_form = class(TForm)
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Priem_form: TPriem_form;

implementation

uses add_abiture, ForMeMComp;

{$R *.dfm}

{****p* TPriem_form/Button2Click
* NAME
* TPriem_form.Button2Click
* USAGE
* Закрыть TPriem_form с сохранением
* SYNOPSIS
*  TPriem_form.Button2Click(Sender: TObject);
* EXAMPLE
*  Button2Click(self);
 ****}
procedure TPriem_form.Button2Click(Sender: TObject);
begin
  if ((ComboBox1.Items[ComboBox1.itemindex]<>'')and (ComboBox2.Items[ComboBox1.itemindex]<>'')and
  (ComboBox1.Items[ComboBox1.itemindex]<>'')) then
  Begin
    close;
    addstudform.Label7.Caption:='+';
    addstudform.Label7.Font.Color:=clgreen;
  end else
  Begin
    showmessage('Не все поля верно заполнены');
  end;
end;

{****p* TPriem_form/FormCloseQuery
* NAME
* TPriem_form.FormCloseQuery
* USAGE
* Закрыть TPriem_form с проверкой
* SYNOPSIS
*  TPriem_form.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
* EXAMPLE
*  FormCloseQuery(self,true);
 ****}
procedure TPriem_form.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not((ComboBox1.Items[ComboBox1.itemindex]<>'')and (ComboBox2.Items[ComboBox1.itemindex]<>'')and
  (ComboBox1.Items[ComboBox1.itemindex]<>'')) then
  Begin
    addstudform.Label7.Caption:='X';
    addstudform.Label7.Font.Color:=clred;
  end;
  CoNSQL.ADOQuery2.SQL.Clear;
end;

end.
