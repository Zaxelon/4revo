unit Add_obwee;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask, sMaskEdit, sCustomComboEdit, sToolEdit;

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

procedure TAddObweeForm.Button1Click(Sender: TObject);
begin
  close;
end;

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

procedure TAddObweeForm.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['a'..'z', 'A'..'Z', 'а'..'я', 'А'..'Я',#08]) then Key := #0;
end;

procedure TAddObweeForm.Edit6KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#08]) then Key := #0;
end;

end.
