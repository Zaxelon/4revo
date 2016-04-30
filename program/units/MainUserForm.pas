unit MainUserUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus;

type
  TMainUserForm = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    id1: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainUserForm: TMainUserForm;

implementation

{$R *.dfm}
uses ForMeMComp;

procedure TMainUserForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  halt;
end;

procedure TMainUserForm.FormShow(Sender: TObject);
Begin

end;
{begin
  form1.ADOQuery1.Close;
  form1.ADOQuery1.SQL.Clear;
  form1.ADOQuery1.SQL.Add('SELECT IS_ROLEMEMBER('+#39+'db_owner'+#39+')');
  form1.ADOQuery1.Active:=true;
  form1.ADOquery1.Open;
  form1.ADOQuery1.First; //Count:=adoquery.Fields[0].AsInteger;
  showmessage(Form1.ADOQuery1.Fields[0].AsString);
  if (form1.adoquery1.Fields[0].AsInteger=1) then label2.Caption:= 'Admin' else
  Begin
    form1.ADOquery1.Active:=false;
    form1.ADOQuery1.SQL.Clear;
    form1.ADOQuery1.SQL.Add('SELECT IS_MEMBER('+#39+'db_backupoperator'+#39+')AS BOMJ');
    form1.ADOquery1.Active:=true;
    if (form1.ADOQuery1.FieldByName('BOMJ').AsInteger=1) then label2.Caption:= 'backupper' else
    Begin
      form1.ADOquery1.Active:=false;
      form1.ADOQuery1.SQL.Clear;
      form1.ADOQuery1.SQL.Add('SELECT IS_MEMBER('+#39+'db_datawriter'+#39+')AS BOMJ');
      form1.ADOquery1.Active:=true;
      if (form1.ADOQuery1.FieldByName('BOMJ').AsInteger=1) then label2.Caption:= 'user';
      form1.ADOquery1.Active:=false;
    end;
  end;
end;
end; }

end.
