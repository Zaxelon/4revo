unit Doc_unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, StdCtrls;

{****t* TDoc_form/TDoc_form
* NAME
* TDoc_form
* USAGE
* Форма TDoc_form
* SYNOPSIS
*  TDoc_form = class(TForm)
* EXAMPLE
*  Doc_form: TDoc_form
****}
type
  TDoc_form = class(TForm)
    Button2: TButton;
    Button1: TButton;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Button4: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Doc_form: TDoc_form;

implementation

{$R *.dfm}
uses ForMeMComp,add_abiture;

{****p* TDoc_form/Button2Click
* NAME
* TDoc_form.Button2Click
* USAGE
* Перемещение из листбокс1 в листбокс2
* SYNOPSIS
*  TDoc_form.Button2Click(Sender: TObject);
* EXAMPLE
*  Button2Click(self);
 ****}
procedure TDoc_form.Button2Click(Sender: TObject);
begin
  if ListBox2.ItemIndex <> -1 then
  Begin
    ListBox1.Items.Add(ListBox2.Items[ListBox2.ItemIndex]);
    ListBox2.DeleteSelected;
    if listbox2.Count>0 then ListBox2.Selected[0]:=true;
  end;
end;

{****p* TDoc_form/Button1Click
* NAME
* TDoc_form.Button1Click
* USAGE
* Перемещение из листбокс2 в листбокс1
* SYNOPSIS
*  TDoc_form.Button1Click(Sender: TObject);
* EXAMPLE
*  Button1Click(self);
 ****}
procedure TDoc_form.Button1Click(Sender: TObject);
begin
  if ListBox1.ItemIndex <> -1 then
  Begin
    ListBox2.Items.Add(ListBox1.Items[ListBox1.ItemIndex]);
    ListBox1.DeleteSelected;
    if listbox1.Count>0 then ListBox1.Selected[0]:=true;
  end;
end;

{****p* TDoc_form/Button4Click
* NAME
* TDoc_form.Button4Click
* USAGE
* Закрытие Doc_form с сохранением
* SYNOPSIS
*  TDoc_form.Button4Click(Sender: TObject);
* EXAMPLE
*  Button4Click(self);
 ****}
procedure TDoc_form.Button4Click(Sender: TObject);
begin
  if (ListBox1.Count>0) then
  Begin
    close;
    addstudform.Label3.Caption:='+';
    addstudform.Label3.Font.Color:=clgreen;
  end else
  Begin
    showmessage('Нет данных');
  end;
end;

{****p* TDoc_form/FormCloseQuery
* NAME
* TDoc_form.FormCloseQuery
* USAGE
* Закрытие Doc_form с проверкой
* SYNOPSIS
*  TDoc_form.FormCloseQuery(Sender: TObject);
* EXAMPLE
*  FormCloseQuery(self);
 ****}
procedure TDoc_form.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not(ListBox1.Count>0) then
  Begin
    addstudform.Label3.Caption:='X';
    addstudform.Label3.Font.Color:=clred;
  end;
  CoNSQL.ADOQuery2.SQL.Clear;
end;

end.
