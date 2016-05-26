unit Lgot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

{****t* TLgotForm/TLgotForm
* NAME
* TLgotForm
* USAGE
* ����� TLgotForm
* SYNOPSIS
*  TLgotForm = class(TForm)
* EXAMPLE
*  LgotForm: TLgotForm
****}
type
  TLgotForm = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button2: TButton;
    Button1: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LgotForm: TLgotForm;

implementation

{$R *.dfm}
uses add_abiture;

{****p* TLgotForm/Button2Click
* NAME
* TLgotForm.Button2Click
* USAGE
* ����������� ������
* SYNOPSIS
*  TLgotForm.Button2Click(Sender: TObject);
* EXAMPLE
*  Button2Click(self);
 ****}
procedure TLgotForm.Button2Click(Sender: TObject);
begin
  addstudform.t_is_lgt;
  close;
end;

{****p* TLgotForm/Button1Click
* NAME
* TLgotForm.Button1Click
* USAGE
* ���������� ������
* SYNOPSIS
*  TLgotForm.Button1�lick(Sender: TObject);
* EXAMPLE
*  Button1Click(self);
 ****}
procedure TLgotForm.Button1Click(Sender: TObject);
begin
  addstudform.f_is_lgt;
  close;
end;

{****p* TLgotForm/FormCloseQuery
* NAME
* TLgotForm.FormCloseQuery
* USAGE
* �������� � ���������
* SYNOPSIS
*  TLgotForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
* EXAMPLE
*  FormCloseQuery(self,true);
 ****}
procedure TLgotForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if addstudform.g_is_lgt then
  Begin
    if not((Edit1.Text<>'') and (Edit2.Text<>'')) then
    Begin
      showmessage('�� ��� ���� ����� ���������');
    end;
  end;
end;

end.
