unit pasport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

{****t* TPasportForm/TPasportForm
* NAME
* TPasportForm
* USAGE
* Форма TPasportForm
* SYNOPSIS
*  TPasportForm = class(TForm)
* EXAMPLE
*  PasportForm: TPasportForm;
****}
type
  TPasportForm = class(TForm)
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TDateTimePicker;
    procedure Button2Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PasportForm: TPasportForm;

implementation

{$R *.dfm}
uses ForMeMComp,add_abiture;

{****p* TPasportForm/Button2Click
* NAME
* TPasportForm.Button2Click
* USAGE
* Закрыть TPasportForm с сохранением
* SYNOPSIS
*  TPasportForm.Button2Click(Sender: TObject);
* EXAMPLE
*  Button2Click(self);
 ****}
procedure TPasportForm.Button2Click(Sender: TObject);
begin
  if (length(Edit1.Text) = 4) and (length(Edit2.Text) = 6) and (edit3.Text<>'') and (Edit5.date<date) and
  (edit4.Text<>'') then
  Begin
    close;
    addstudform.Label2.Caption:='+';
    addstudform.Label2.Font.Color:=clgreen;
  end else
  Begin
    showmessage('Не все поля верно заполнены');
  end;
end;

{****p* TPasportForm/Edit1KeyPress
* NAME
* TPasportForm.Edit1KeyPress
* USAGE
* проверка ввода
* SYNOPSIS
*  TPasportForm.Edit1KeyPress(Sender: TObject; var Key: Char);
* EXAMPLE
*  Edit1KeyPress(self,#39);
 ****}
procedure TPasportForm.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#08]) then Key := #0;
end;

{****p* TPasportForm/FormCloseQuery
* NAME
* TPasportForm.FormCloseQuery
* USAGE
* Закрыть TPasportForm с проверкой
* SYNOPSIS
*  TPasportForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
* EXAMPLE
*  FormCloseQuery(self,true);
 ****}
procedure TPasportForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not((length(Edit1.Text) = 4) and (length(Edit2.Text) = 6) and (edit3.Text<>'')
  and (Edit5.date<date) and (edit4.Text<>'')) then
  Begin
    addstudform.Label2.Caption:='X';
    addstudform.Label2.Font.Color:=clred;
  end;
  CoNSQL.ADOQuery2.SQL.Clear;
end;

end.
