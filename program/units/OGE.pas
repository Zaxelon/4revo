unit OGE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TOGEG = class(TForm)
    Label1: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit5: TDateTimePicker;
    Edit3: TEdit;
    Button2: TButton;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OGEG: TOGEG;

implementation

uses add_abiture, ForMeMComp;

{$R *.dfm}

procedure TOGEG.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#08]) then Key := #0;
end;

procedure TOGEG.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',',',#08]) then Key := #0;
end;

procedure TOGEG.Button2Click(Sender: TObject);
begin
  if ((length(Edit1.Text)=6) and (strtofloat(edit3.Text) >= 3) and
  (strtofloat(edit3.Text) <= 5) and (Edit5.date<Date)) then
  Begin
    close;
    addstudform.Label6.Caption:='+';
    addstudform.Label6.Font.Color:=clgreen;
  end else
  Begin
    showmessage('Не все поля верно заполнены');
  end;
end;

procedure TOGEG.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not((length(Edit1.Text)=6) and (strtofloat(edit3.Text) >= 3) and
  (strtofloat(edit3.Text) <= 5) and (Edit5.date<Date)) then
  Begin
    addstudform.Label6.Caption:='X';
    addstudform.Label6.Font.Color:=clred;
  end;
  CoNSQL.ADOQuery2.SQL.Clear;
end;

end.
