unit pasp_rod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TPasp_rod_Form = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Label9: TLabel;
    Edit5: TDateTimePicker;
    Button2: TButton;
    procedure Edit6KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Pasp_rod_Form: TPasp_rod_Form;

implementation

uses add_abiture, ForMeMComp;

{$R *.dfm}

procedure TPasp_rod_Form.Edit6KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['a'..'z', 'A'..'Z', 'а'..'я', 'А'..'Я',#08]) then Key := #0;
end;

procedure TPasp_rod_Form.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#08]) then Key := #0;
end;

procedure TPasp_rod_Form.Button2Click(Sender: TObject);
begin
  if (length(Edit1.Text) = 4) and (length(Edit2.Text) = 6) and (edit6.Text<>'') and
  (Edit5.date<date) and (edit7.Text<>'') and (edit8.Text<>'') and (edit3.Text<>'') then
  Begin
    close;
    addstudform.Label4.Caption:='+';
    addstudform.Label4.Font.Color:=clgreen;
  end else
  Begin
    showmessage('Не все поля верно заполнены');
  end;
end;

procedure TPasp_rod_Form.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not((length(Edit1.Text) = 4) and (length(Edit2.Text) = 6) and (edit6.Text<>'') and
  (Edit5.date<date) and (edit7.Text<>'') and (edit8.Text<>'') and (edit3.Text<>'')) then
  Begin
    addstudform.Label4.Caption:='X';
    addstudform.Label4.Font.Color:=clred;
  end;
  CoNSQL.ADOQuery2.SQL.Clear;
end;

end.
