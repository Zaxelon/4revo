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
  Priem, Lgot;

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
  insert_obw;
  insert_pasp;
  insert_doc;
  insert_pasp_rod;
  insert_atest;
  insert_oge;
  insert_priem;
  if is_benfit then insert_benfit;
  showmessage('Абитуриент успешно добавлен');
  close;
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
var temp_str:string;
begin
  with AddObweeForm do
  Begin
    temp_str:='EXEC add_abiture @surname='+'N'+#39+Edit1.text+#39+',@first_name='+'N'+#39+Edit2.text+#39+',@middle_name='+
    'N'+#39+Edit3.text+#39+',@is_male='+booltostr(RadioButton1.Checked)+',@birthday='+#39+datetostr(Edit5.date)+#39+',@phone='+
    'N'+#39+Edit6.text+#39+',@address='+'N'+#39+Edit7.text+#39+',@training_courses='+booltostr(CheckBox1.checked);
  end;
  with CoNSQL do
  Begin
    ADOQuery2.SQL.Clear;
    ADOQuery2.SQL.Text:=temp_str;
    ADOQuery2.ExecSQL;
    ADOQuery2.SQL.Clear;
    ADOQuery2.SQL.Add('SELECT IDENT_CURRENT('+#39+'abiture'+#39+')');
    ADOQuery2.Open;
    abit_id:=ADOQuery2.Fields[0].AsInteger;
    ADOQuery2.SQL.Clear;
  end;
end;

procedure Taddstudform.insert_pasp;
begin
  with PasportForm do
  Begin
    CoNSQL.ADOQuery2.SQL.Text:='EXEC add_pasport @id_statement='+inttostr(abit_id)+', @series='+Edit1.Text+', @numb='+Edit2.Text+
    ', @place_of_birth=N'+#39+Edit3.Text+#39+', @issued_by=N'+#39+Edit4.Text+#39+
    ', @date_of_issue='+#39+datetostr(Edit5.date)+#39;
  end;
  with CoNSQL do
  Begin
    ADOQuery2.ExecSQL;
    ADOQuery2.SQL.Clear;
  end;
end;

procedure Taddstudform.insert_doc;
begin
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
end;

procedure Taddstudform.Button6Click(Sender: TObject);
begin
  Pasp_rod_Form.ShowModal;
end;

procedure Taddstudform.insert_pasp_rod;
begin
  with Pasp_rod_Form do
  Begin
    CoNSQL.ADOQuery2.SQL.Text:='EXEC add_pasp_rod @id_statement=' + inttostr(abit_id)+
    ',@series='+Edit1.Text+',@numb='+Edit2.Text+',@surnmae=N'+#39+Edit6.Text+#39+
    ',@frist_name=N'+#39+Edit7.Text+#39+',@middle_name=N'+#39+Edit8.Text+#39+
    ',@birthday='+#39+datetostr(Edit5.date)+#39+',@place_of_birth=N'+#39+Edit3.Text+#39;
  end;
  with CoNSQL do
  Begin
    ADOQuery2.ExecSQL;
    ADOQuery2.SQL.Clear;
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
  with Atest_form do
  Begin
    temp_s:=Edit3.Text;
    for zar:=0 to 4 do
    Begin if (temp_s[zar] = ',') then temp_s[zar]:='.'; end;
    CoNSQL.ADOQuery2.SQL.Text:='EXEC add_atest @id_statement=' + inttostr(abit_id)+
    ',@numb_at='+ Edit1.Text+',@institution=N'+#39+Edit2.Text+#39+',@s_otl='+
    booltostr(checkbox1.Checked)+',@avgn='+temp_s+',@date_of_issue=N'+#39+datetostr(Edit5.Date)+#39;
  end;
  with CoNSQL do
  Begin
    ADOQuery2.ExecSQL;
    ADOQuery2.SQL.Clear;
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
  with OGEG do
  Begin
    temp_s:=Edit3.Text;
    for zar:=0 to 4 do
    Begin if(temp_s[zar] = ',') then temp_s[zar]:='.'; end;
    CoNSQL.ADOQuery2.SQL.Text:='EXEC add_oge @id_statement=' + inttostr(abit_id)+
    ',@numb_sv='+ Edit1.Text+',@avg_oge='+temp_s+',@date_of_issue=N'+#39+datetostr(Edit5.Date)+#39;
  end;
  with CoNSQL do
  Begin
    ADOQuery2.ExecSQL;
    ADOQuery2.SQL.Clear;
  end;
end;

procedure Taddstudform.Button7Click(Sender: TObject);
begin
  Priem_form.showmodal;
end;

procedure Taddstudform.insert_priem;
begin
  CoNSQL.ADOQuery2.SQL.Clear;
  with Priem_form do
  Begin
    CoNSQL.ADOQuery2.SQL.Add('EXEC add_priem @id_statement='+inttostr(abit_id)+
    ',@name_spec=N'+#39+ComboBox1.Items[ComboBox1.itemindex]+#39+',@priority=1');
    CoNSQL.ADOQuery2.SQL.Add('EXEC add_priem @id_statement='+inttostr(abit_id)+
    ',@name_spec=N'+#39+ComboBox2.Items[ComboBox2.itemindex]+#39+',@priority=2');
    CoNSQL.ADOQuery2.SQL.Add('EXEC add_priem @id_statement='+inttostr(abit_id)+
    ',@name_spec=N'+#39+ComboBox3.Items[ComboBox3.itemindex]+#39+',@priority=3');
  end;
  with CoNSQL do
  Begin
    ADOQuery2.ExecSQL;
    ADOQuery2.SQL.Clear;
  end;
end;

procedure Taddstudform.insert_benfit;
begin
  CoNSQL.ADOQuery2.SQL.Clear;
  with LgotForm do
  Begin
    CoNSQL.ADOQuery2.SQL.Text:='EXEC add_benfit @id_statement='+inttostr(abit_id)+
    ',@name=N'+#39+Edit1.Text+#39+',@document_number=N'+#39+Edit2.Text+#39;
  end;
  with CoNSQL do
  Begin
    ADOQuery2.ExecSQL;
    ADOQuery2.SQL.Clear;
  end;
end;

procedure Taddstudform.Button10Click(Sender: TObject);
begin
  LgotForm.ShowModal;
end;

end.

