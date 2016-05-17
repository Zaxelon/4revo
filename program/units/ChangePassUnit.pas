unit ChangePassUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TChangePassForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label4: TLabel;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChangePassForm: TChangePassForm;

implementation

uses ForMeMComp;

{$R *.dfm}

procedure TChangePassForm.FormShow(Sender: TObject);
begin
  Label4.Caption:=CoNSQL.UserName;
  Edit2.Text:='';
  Edit3.Text:='';
end;

procedure TChangePassForm.Button1Click(Sender: TObject);
begin
  CoNSQL.CheckRole.SQL.Text:='ALTER LOGIN '+Label4.Caption+' WITH PASSWORD = N'+#39+
  Edit3.Text+#39+' OLD_PASSWORD = N'+#39+Edit2.Text+#39;
  try
  CoNSQL.CheckRole.ExecSQL;
  except
    showmessage('Не удалось сменить пароль.');
  end;
  close;
end;

end.
