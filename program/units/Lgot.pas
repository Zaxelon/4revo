unit Lgot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

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

procedure TLgotForm.Button2Click(Sender: TObject);
begin
  addstudform.t_is_lgt;
  close;
end;

procedure TLgotForm.Button1Click(Sender: TObject);
begin
  addstudform.f_is_lgt;
  close;
end;

procedure TLgotForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if addstudform.g_is_lgt then
  Begin
    if not((Edit1.Text<>'') and (Edit2.Text<>'')) then
    Begin
      showmessage('Не все поля верно заполнены');
    end;
  end;
end;

end.
