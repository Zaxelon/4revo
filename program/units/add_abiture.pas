unit add_abiture;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  Taddstudform = class(TForm)
    Button2: TButton;
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
  private
    is_benfit:boolean;
    procedure insert_obw;
    procedure insert_pasp;
    procedure insert_doc;
    procedure insert_pasp_rod;
    procedure insert_atest;
    procedure insert_oge;
    procedure insert_priem;
    procedure insert_benfit;
  public
    is_insert:boolean;
    abit_id:integer;
    procedure t_is_lgt;
    procedure f_is_lgt;
    function g_is_lgt:boolean;
  end;

var
  addstudform: Taddstudform;

implementation

{$R *.dfm}
uses Add_obwee, pasport, ForMeMComp, doc_unit, pasp_rod, atestat, OGE,
  Priem, Lgot, MainUserUnit;

procedure Taddstudform.f_is_lgt;
begin
  is_benfit:=false;
end;

procedure Taddstudform.t_is_lgt;
begin
  is_benfit:=true;
end;

function Taddstudform.g_is_lgt: boolean;
begin
  g_is_lgt:=is_benfit;
end;

procedure Taddstudform.Button2Click(Sender: TObject);
begin
  AddObweeForm.Showmodal;
end;

procedure Taddstudform.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Taddstudform.Button3Click(Sender: TObject);
begin
  if (label1.Caption='+') and (label2.Caption='+') and (label3.Caption='+')
  and (label4.Caption='+') and (label5.Caption='+') and (label6.Caption='+')
  and (label7.Caption='+') then
  Begin
    if MainUserForm.uwpdate then
    Begin
      CoNSQL.ADOQuery2.SQL.Text:='DELETE FROM abiture WHERE id_statement = :1';
      CoNSQL.ADOQuery2.Parameters.ParseSQL(CoNSQL.ADOQuery2.SQL.Text,true);
      CoNSQL.ADOQuery2.Parameters.ParamByName('1').Value:= abit_id;
      try
        CoNSQL.ADOQuery2.ExecSQL;
      except
        on E: Exception do
        Showmessage('ERRoR: ' + E.Message);
      end;
    end;
    insert_obw;
    insert_pasp;
    insert_doc;
    insert_pasp_rod;
    insert_atest;
    insert_oge;
    insert_priem;
    if is_benfit then insert_benfit;
    showmessage('Абитуриент успешно добавлен');
    CoNSQL.ADOQuery3.SQL.Text:='exec sel_title :1';
    CoNSQL.ADOQuery3.Parameters.ParseSQL(CoNSQL.ADOQuery3.SQL.Text,true);
    CoNSQL.ADOQuery3.Parameters.ParamByName('1').Value:= '';
    try
      CoNSQL.ADOQuery3.Open;
    except
      on E: Exception do
      Showmessage('ERRoR: ' + E.Message);
    end;
    if not(CoNSQL.ADOQuery3.IsEmpty) then
    Begin
      MainUserForm.DBGrid1.Columns[0].Width:=30;
      MainUserForm.DBGrid1.Columns[1].Width:=100;
      MainUserForm.DBGrid1.Columns[2].Width:=75;
      MainUserForm.DBGrid1.Columns[3].Width:=100;
      MainUserForm.DBGrid1.Columns[6].Width:=275;
    end;
    close;
  end else
  Begin
    showmessage('Вы заполнили не все требуемые данные');
  end;
end;

procedure Taddstudform.Button4Click(Sender: TObject);
begin
  PasportForm.ShowModal;
end;

procedure Taddstudform.Button5Click(Sender: TObject);
begin
  doc_form.ShowModal;
end;

procedure Taddstudform.insert_obw;
begin
try
  with CoNSQL do
  Begin
    ADOQuery2.SQL.text:=
    'INSERT INTO abiture(surname,first_name,middle_name,is_male,birthday,phone,address,training_courses,date_of_application)'+
    ' VALUES (:1,:2,:3,:4,:5,:6,:7,:8,CONVERT(date,GETDATE()))';
    ADOQuery2.Parameters.ParseSQL(CoNSQL.ADOQuery2.SQL.Text,true);
    with AddObweeForm do
    Begin
      ADOQuery2.Parameters.ParamByName('1').Value:=Edit1.text;
      ADOQuery2.Parameters.ParamByName('2').Value:=Edit2.text;
      ADOQuery2.Parameters.ParamByName('3').Value:=Edit3.text;
      ADOQuery2.Parameters.ParamByName('4').Value:=RadioButton1.Checked;
      ADOQuery2.Parameters.ParamByName('5').Value:=datetostr(Edit5.date);
      ADOQuery2.Parameters.ParamByName('6').Value:=Edit6.text;
      ADOQuery2.Parameters.ParamByName('7').Value:=Edit7.text;
      ADOQuery2.Parameters.ParamByName('8').Value:=CheckBox1.checked;
    end;
    ADOQuery2.ExecSQL;
    ADOQuery2.SQL.Clear;
    ADOQuery2.SQL.Add('SELECT IDENT_CURRENT('+#39+'abiture'+#39+')');
    ADOQuery2.Open;
    abit_id:=ADOQuery2.Fields[0].AsInteger;
    ADOQuery2.SQL.Clear;
  end;
except
  on E: Exception do
  Showmessage('ERRoR: ' + E.Message);
end;
end;

procedure Taddstudform.insert_pasp;
begin
try
  with CoNSQL do
  Begin
    ADOQuery2.SQL.text:=
    'INSERT INTO pasport(id_statement,series,numb,place_of_birth,issued_by,date_of_issue)'+
    ' VALUES (:1,:2,:3,:4,:5,:6)';
    ADOQuery2.Parameters.ParseSQL(ADOQuery2.SQL.Text,true);
    with PasportForm do
    Begin
      ADOQuery2.Parameters.ParamByName('1').Value:=abit_id;
      ADOQuery2.Parameters.ParamByName('2').Value:=Edit1.text;
      ADOQuery2.Parameters.ParamByName('3').Value:=Edit2.text;
      ADOQuery2.Parameters.ParamByName('4').Value:=Edit3.Text;
      ADOQuery2.Parameters.ParamByName('5').Value:=Edit4.Text;
      ADOQuery2.Parameters.ParamByName('6').Value:=datetostr(Edit5.date);
    end;
    ADOQuery2.ExecSQL;
    ADOQuery2.SQL.Clear;
  end;
except
  on E: Exception do
  Showmessage('ERRoR: ' + E.Message);
end;
end;

procedure Taddstudform.insert_doc;
begin
try
  with Doc_form do
  Begin
    while (listbox1.Count>0) do
    Begin
      ListBox1.Selected[0]:=true;
      CoNSQL.ADOQuery2.SQL.text:='EXEC add_doc @id_statement='+inttostr(abit_id)+',@name=N'+#39+
      ListBox1.Items[ListBox1.ItemIndex]+#39;
      CoNSQL.ADOQuery2.ExecSQL;
      CoNSQL.ADOQuery2.SQL.Clear;
      ListBox1.DeleteSelected;
    end;
  end;
except
  on E: Exception do
  Showmessage('ERRoR: ' + E.Message);
end;
end;

procedure Taddstudform.Button6Click(Sender: TObject);
begin
  Pasp_rod_Form.ShowModal;
end;

procedure Taddstudform.insert_pasp_rod;
begin
try
  with CoNSQL do
  Begin
    ADOQuery2.SQL.text:=
    'INSERT INTO pasp_rod(id_statement,series,numb,surname,first_name,middle_name,birthday,place_of_birth)'+
    ' VALUES (:1,:2,:3,:4,:5,:6,:7,:8)';
    ADOQuery2.Parameters.ParseSQL(ADOQuery2.SQL.Text,true);
    with Pasp_rod_Form do
    Begin
      ADOQuery2.Parameters.ParamByName('1').Value:=abit_id;
      ADOQuery2.Parameters.ParamByName('2').Value:=Edit1.text;
      ADOQuery2.Parameters.ParamByName('3').Value:=Edit2.text;
      ADOQuery2.Parameters.ParamByName('4').Value:=Edit6.Text;
      ADOQuery2.Parameters.ParamByName('5').Value:=Edit7.Text;
      ADOQuery2.Parameters.ParamByName('6').Value:=Edit8.Text;
      ADOQuery2.Parameters.ParamByName('7').Value:=datetostr(Edit5.date);
      ADOQuery2.Parameters.ParamByName('8').Value:=Edit3.text;
    end;
    ADOQuery2.ExecSQL;
    ADOQuery2.SQL.Clear;
  end;
except
  on E: Exception do
  Showmessage('ERRoR: ' + E.Message);
end;
end;

procedure Taddstudform.Button8Click(Sender: TObject);
begin
  Atest_form.ShowModal;
end;

procedure Taddstudform.insert_atest;
var temp_s:string;
    zar:integer;
begin
try
  temp_s:=Atest_form.Edit3.Text;
  for zar:=0 to 4 do
  Begin if (temp_s[zar] = ',') then temp_s[zar]:='.'; end;
  with CoNSQL do
  Begin
    ADOQuery2.SQL.text:=
    'INSERT INTO atestat(id_statement,numb_at,institution,s_otl,avgn,date_of_issue)'+
    ' VALUES (:1,:2,:3,:4,:5,:6)';
    ADOQuery2.Parameters.ParseSQL(ADOQuery2.SQL.Text,true);
    with Atest_form do
    Begin
      ADOQuery2.Parameters.ParamByName('1').Value:=abit_id;
      ADOQuery2.Parameters.ParamByName('2').Value:=Edit1.text;
      ADOQuery2.Parameters.ParamByName('3').Value:=Edit2.text;
      ADOQuery2.Parameters.ParamByName('4').Value:=Checkbox1.Checked;
      ADOQuery2.Parameters.ParamByName('5').Value:=temp_s;
      ADOQuery2.Parameters.ParamByName('6').Value:=datetostr(Edit5.Date);
    end;
    ADOQuery2.ExecSQL;
    ADOQuery2.SQL.Clear;
  end;
except
  on E: Exception do
  Showmessage('ERRoR: ' + E.Message);
end;
end;

procedure Taddstudform.Button9Click(Sender: TObject);
begin
  OGEG.ShowModal;
end;

procedure Taddstudform.insert_oge;
var temp_s:string;
    zar:integer;
begin
try
  temp_s:=OGEG.Edit3.Text;
  for zar:=0 to 4 do
  Begin if(temp_s[zar] = ',') then temp_s[zar]:='.'; end;
  with CoNSQL do
  Begin
    ADOQuery2.SQL.text:=
    'INSERT INTO oge(id_statement,numb_sv,avg_oge,date_of_issue) VALUES (:1,:2,:3,:4)';
    ADOQuery2.Parameters.ParseSQL(ADOQuery2.SQL.Text,true);
    with OGEG do
    Begin
      ADOQuery2.Parameters.ParamByName('1').Value:=abit_id;
      ADOQuery2.Parameters.ParamByName('2').Value:=Edit1.text;
      ADOQuery2.Parameters.ParamByName('3').Value:=temp_s;
      ADOQuery2.Parameters.ParamByName('4').Value:=datetostr(Edit5.Date);
    end;
    ADOQuery2.ExecSQL;
    ADOQuery2.SQL.Clear;
  end;
except
  on E: Exception do
  Showmessage('ERRoR: ' + E.Message);
end;
end;

procedure Taddstudform.Button7Click(Sender: TObject);
begin
  Priem_form.showmodal;
end;

procedure Taddstudform.insert_priem;
begin
try
  with Priem_form do
  Begin
    with CoNSQL do
    Begin
      ADOQuery2.SQL.Clear;
      if ComboBox1.Items[ComboBox1.itemindex]<>'' then
      Begin
      ADOQuery2.SQL.Text:='EXEC add_priem :1,:2,:7';
      ADOQuery2.Parameters.ParseSQL(ADOQuery2.SQL.Text,true);
      ADOQuery2.Parameters.ParamByName('1').Value:=abit_id;
      ADOQuery2.Parameters.ParamByName('2').Value:=ComboBox1.Items[ComboBox1.itemindex];
      ADOQuery2.Parameters.ParamByName('7').Value:=1;
      ADOQuery2.ExecSQL;
      end else Begin showmessage('Ошибка приема на специальности'); abort; end;
      if ComboBox2.Items[ComboBox2.itemindex]<>'' then
      Begin
        ADOQuery2.SQL.Text:='EXEC add_priem :3,:4,:8';
        ADOQuery2.Parameters.ParseSQL(ADOQuery2.SQL.Text,true);
        ADOQuery2.Parameters.ParamByName('3').Value:=abit_id;
        ADOQuery2.Parameters.ParamByName('4').Value:=ComboBox2.Items[ComboBox2.itemindex];
        ADOQuery2.Parameters.ParamByName('8').Value:=2;
        ADOQuery2.ExecSQL;
        if ComboBox3.Items[ComboBox3.itemindex]<>'' then
        Begin
          ADOQuery2.SQL.Text:='EXEC add_priem :5,:6,:9';
          ADOQuery2.Parameters.ParseSQL(ADOQuery2.SQL.Text,true);
          ADOQuery2.Parameters.ParamByName('5').Value:=abit_id;
          ADOQuery2.Parameters.ParamByName('6').Value:=ComboBox3.Items[ComboBox3.itemindex];
          ADOQuery2.Parameters.ParamByName('9').Value:=3;
          ADOQuery2.ExecSQL;
        end;
      end;
      ADOQuery2.SQL.Clear;
    end;
  end;
except
  on E: Exception do
  Showmessage('ERRoR: ' + E.Message);
end;
end;

procedure Taddstudform.insert_benfit;
begin
try
  with CoNSQL do
  Begin
    ADOQuery2.SQL.text:=
    'INSERT INTO benefits(id_statement,name,document_number) VALUES (:1,:2,:3)';
    ADOQuery2.Parameters.ParseSQL(ADOQuery2.SQL.Text,true);
    with LgotForm do
    Begin
      ADOQuery2.Parameters.ParamByName('1').Value:=abit_id;
      ADOQuery2.Parameters.ParamByName('2').Value:=Edit1.text;
      ADOQuery2.Parameters.ParamByName('3').Value:=Edit2.text;
    end;
    ADOQuery2.ExecSQL;
    ADOQuery2.SQL.Clear;
  end;
except
  on E: Exception do
  Showmessage('ERRoR: ' + E.Message);
end;
end;

procedure Taddstudform.Button10Click(Sender: TObject);
begin
  LgotForm.ShowModal;
end;

end.

