unit MainUserUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, Grids, DBGrids;

type
  TMainUserForm = class(TForm)
    MainMenu1: TMainMenu;
    Npravka: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Nsee: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    Nstar_sekt: TMenuItem;
    N40: TMenuItem;
    N41: TMenuItem;
    Nstar_admin: TMenuItem;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Label2: TLabel;
    N4: TMenuItem;
    N6: TMenuItem;
    RapidZ1: TMenuItem;
    N1: TMenuItem;
    N5: TMenuItem;
    N10: TMenuItem;
    Ndoc: TMenuItem;
    Nspec: TMenuItem;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1Change(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure N9Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure N28Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure N25Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure NdocClick(Sender: TObject);
    procedure NspecClick(Sender: TObject);
    procedure N40Click(Sender: TObject);
    procedure N41Click(Sender: TObject);
  private
    see_abit_atest:byte;
  public
    procedure aborted;
    function show_your_atest:byte;
  end;

var
  MainUserForm: TMainUserForm;
  rd:boolean;

implementation

{$R *.dfm}
uses ForMeMComp, Add_obwee, AuthUnit, add_abiture, pasport, Doc_unit,
  pasp_rod, Priem, SeeUnit, Prohball, StForm, ATableForm, ChangePassUnit, UserUnit;

procedure TMainUserForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  application.Terminate;
end;

procedure TMainUserForm.FormShow(Sender: TObject);
Begin
  DBGrid1.ReadOnly:=true;
  if (CoNSQL.UserRole='Secretar') then
  Begin
    CoNSQL.ADOQuery3.SQL.Text:='exec sel_title :1';
    CoNSQL.ADOQuery3.Parameters.ParseSQL(CoNSQL.ADOQuery3.SQL.Text,true);
    CoNSQL.ADOQuery3.Parameters.ParamByName('1').Value:= '';
    CoNSQL.ADOQuery3.Open;
    if not(CoNSQL.ADOQuery3.IsEmpty) then
    Begin
      DBGrid1.Columns[0].Width:=30;
      DBGrid1.Columns[1].Width:=100;
      DBGrid1.Columns[2].Width:=75;
      DBGrid1.Columns[3].Width:=100;
      DBGrid1.Columns[6].Width:=275;
    end;
  end;
  if (CoNSQL.UserRole='Star_Secretar') then
  Begin
    CoNSQL.ADOQuery3.SQL.Text:='SELECT name_spec AS [Название], code_spec AS [Код],'+
    'places AS [Мест] FROM specialty';
    CoNSQL.ADOQuery3.Open;
  end;
  if (CoNSQL.UserRole='Admun') then
  Begin
    CoNSQL.ADOQuery3.SQL.Text:='SELECT * FROM sel_user_deathwing';
    CoNSQL.ADOQuery3.Open;
    DBGrid1.ReadOnly:=false;
  end;
end;

procedure TMainUserForm.N2Click(Sender: TObject);
begin
  with addstudform do
  Begin
    is_insert:=true;
    Label1.Caption:='X';
    Label1.Font.Color:=clred;
    Label2.Caption:='X';
    Label2.Font.Color:=clred;
    Label3.Caption:='X';
    Label3.Font.Color:=clred;
    Label4.Caption:='X';
    Label4.Font.Color:=clred;
    Label5.Caption:='X';
    Label5.Font.Color:=clred;
    Label6.Caption:='X';
    Label6.Font.Color:=clred;
    Label7.Caption:='X';
    Label7.Font.Color:=clred;
    f_is_lgt;
  end;

  with AddObweeForm do
  Begin
    edit1.Text:='';
    edit2.Text:='';
    edit3.Text:='';
    Edit5.date:=Date;
    edit6.Text:='';
    edit7.Text:='';
    Checkbox1.Checked:=false;
  end;

  with PasportForm do
  Begin
    edit1.Text:='';
    edit2.Text:='';
    edit3.Text:='';
    edit4.Text:='';
    Edit5.date:=Date;
  end;

  with Doc_form do
  Begin
    ListBox1.Clear;
    ListBox2.Clear;
    CoNSQL.ADOQuery1.SQL.Text:='SELECT name FROM document';
    CoNSQL.ADOQuery1.Open;
    While not consql.ADOQuery1.Eof do
    begin
      ListBox2.Items.Add(consql.ADOQuery1.FieldByName('name').AsString);
      consql.ADOQuery1.Next;
    end;
  end;

  with Pasp_rod_Form do
  Begin
    edit1.Text:='';
    edit2.Text:='';
    edit3.Text:='';
    Edit5.date:=Date;
    edit6.Text:='';
    edit7.Text:='';
    edit8.Text:='';
  end;

  with Priem_form do
  Begin
    CoNSQL.adoquery2.SQL.Clear;
    ComboBox1.Clear;
    ComboBox2.Clear;
    ComboBox3.Clear;
    CoNSQL.adoquery2.SQL.add('SELECT name_spec AS VGA FROM specialty');
    CoNSQL.adoquery2.open;
    while not(CoNSQL.adoquery2.Eof) and (CoNSQL.adoquery2.RecordCount>0) do
    Begin
      ComboBox1.Items.Add(CoNSQL.adoquery2.fieldbyname('VGA').asstring);
      ComboBox2.Items.Add(CoNSQL.adoquery2.fieldbyname('VGA').asstring);
      ComboBox3.Items.Add(CoNSQL.adoquery2.fieldbyname('VGA').asstring);
      CoNSQL.adoquery2.Next;
    end;
    CoNSQL.ADOQuery2.SQL.Clear;
  end;

  addstudform.ShowModal;
end;

procedure TMainUserForm.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = 13) then
  Begin
    CoNSQL.ADOQuery3.Edit;
    CoNSQL.ADOQuery3.Post;
  end;
  if (key = 46) and (ssShift in shift) then
  Begin
    if not(CoNSQL.ADOQuery3.IsEmpty) then
    Begin
      if  CoNSQL.UserRole = 'Admun' then
      Begin
        with CoNSQL do
        Begin
          if CoNSQL.UserName <> trim(adoquery3.Fields.Fields[0].asstring) then
          Begin
            ADOQuery4.SQL.Clear;
            ADOQuery4.SQL.Text:='exec drop_users :1';
            ADOQuery4.Parameters.ParseSQL(ADOQuery4.SQL.Text,true);
            ADOQuery4.Parameters.ParamByName('1').Value:=trim(adoquery3.Fields.Fields[0].asstring);
            ADOQuery4.ExecSQL;
            ADOQuery3.Active:=false;
            ADOQuery3.Active:=true;
          end else showmessage('Access denied');
        end;
      end else
      CoNSQL.ADOQuery3.Delete;
    End;
  end;
end;

procedure TMainUserForm.Edit1Change(Sender: TObject);
begin
  if Edit1.Text<>'' then
  Begin
    CoNSQL.ADOQuery3.SQL.Text:='exec sel_title :1';
    CoNSQL.ADOQuery3.Parameters.ParseSQL(CoNSQL.ADOQuery3.SQL.Text,true);
    CoNSQL.ADOQuery3.Parameters.ParamByName('1').Value:= Edit1.Text;
    CoNSQL.ADOQuery3.Open;
    DBGrid1.Columns[0].Width:=30;
    DBGrid1.Columns[1].Width:=100;
    DBGrid1.Columns[2].Width:=75;
    DBGrid1.Columns[3].Width:=100;
    DBGrid1.Columns[6].Width:=275;
  end else
  Begin
    CoNSQL.ADOQuery3.SQL.Text:='exec sel_title :1';
    CoNSQL.ADOQuery3.Parameters.ParseSQL(CoNSQL.ADOQuery3.SQL.Text,true);
    CoNSQL.ADOQuery3.Parameters.ParamByName('1').Value:= '';
    CoNSQL.ADOQuery3.Open;
    DBGrid1.Columns[0].Width:=30;
    DBGrid1.Columns[1].Width:=100;
    DBGrid1.Columns[2].Width:=75;
    DBGrid1.Columns[3].Width:=100;
    DBGrid1.Columns[6].Width:=275;
  End;
end;

procedure TMainUserForm.N3Click(Sender: TObject);
var temp_s:string;
    temp_i:integer;
begin
  aborted;//в разработке
  with addstudform do
  Begin
    abit_id:=Consql.ADOQuery3.FieldByName('ID').AsInteger;
    is_insert:=false;
    Label1.Caption:='+';
    Label1.Font.Color:=clred;
    Label2.Caption:='+';
    Label2.Font.Color:=clred;
    Label3.Caption:='+';
    Label3.Font.Color:=clred;
    Label4.Caption:='+';
    Label4.Font.Color:=clred;
    Label5.Caption:='+';
    Label5.Font.Color:=clred;
    Label6.Caption:='+';
    Label6.Font.Color:=clred;
    Label7.Caption:='+';
    Label7.Font.Color:=clred;
    f_is_lgt;
  end;

  CoNSQL.ADOQuery1.SQL.Text:='SELECT * FROM abiture WHERE id_statement='+inttostr(addstudform.abit_id);
  CoNSQL.ADOQuery1.Open;
  with AddObweeForm do
  Begin
    edit1.Text:=Consql.ADOQuery1.FieldByName('surname').AsString;
    edit2.Text:=Consql.ADOQuery1.FieldByName('first_name').AsString;
    edit3.Text:=Consql.ADOQuery1.FieldByName('middle_name').AsString;
    if (Consql.ADOQuery1.FieldByName('is_male').AsBoolean) then
    Begin RadioButton1.Checked:=true; end else
    Begin RadioButton1.Checked:=false; RadioButton2.Checked:=true; end;
    temp_s:=Consql.ADOQuery1.FieldByName('birthday').AsString;
    for temp_i:=1 to length(temp_s) do
    if temp_s[temp_i]='-' then temp_s[temp_i]:='.';
    edit6.Text:=Consql.ADOQuery1.FieldByName('phone').AsString;
    edit7.Text:=Consql.ADOQuery1.FieldByName('address').AsString;;
    Checkbox1.Checked:=Consql.ADOQuery1.FieldByName('training_courses').AsBoolean;
  end;

  CoNSQL.ADOQuery1.SQL.Text:='SELECT * FROM pasport WHERE id_statement='+inttostr(addstudform.abit_id);
  CoNSQL.ADOQuery1.Open;
  with PasportForm do
  Begin
    edit1.Text:=CoNSQL.ADOQuery1.FieldByName('series').AsString;
    edit2.Text:=CoNSQL.ADOQuery1.FieldByName('numb').AsString;;
    edit3.Text:=CoNSQL.ADOQuery1.FieldByName('place_of_birth').AsString;
    edit4.Text:=CoNSQL.ADOQuery1.FieldByName('issued_by').AsString;;
  end;

  with Doc_form do
  Begin
    ListBox1.Clear;
    ListBox2.Clear;
    CoNSQL.ADOQuery1.SQL.Text:='SELECT name FROM document';
    CoNSQL.ADOQuery1.Open;
    While not consql.ADOQuery1.Eof do
    begin
      ListBox2.Items.Add(consql.ADOQuery1.FieldByName('name').AsString);
      consql.ADOQuery1.Next;
    end;
  end;

  CoNSQL.ADOQuery1.SQL.Text:='SELECT * FROM pasp_rod WHERE id_statement='+inttostr(addstudform.abit_id);
  CoNSQL.ADOQuery1.Open;
  with Pasp_rod_Form do
  Begin
    edit1.Text:=CoNSQL.ADOQuery1.FieldByName('series').AsString;
    edit2.Text:=CoNSQL.ADOQuery1.FieldByName('numb').AsString;;
    edit3.Text:=CoNSQL.ADOQuery1.FieldByName('place_of_birth').AsString;
    //Edit5.date:=
    edit6.Text:=Consql.ADOQuery1.FieldByName('surname').AsString;
    edit7.Text:=Consql.ADOQuery1.FieldByName('first_name').AsString;
    edit8.Text:=Consql.ADOQuery1.FieldByName('middle_name').AsString;
  end;

  CoNSQL.ADOQuery1.SQL.Text:='SELECT * FROM priem WHERE id_statement='+inttostr(addstudform.abit_id);
  CoNSQL.ADOQuery1.Open;
  with Priem_form do
  Begin
    CoNSQL.adoquery2.SQL.Clear;
    CoNSQL.adoquery2.SQL.add('SELECT name_spec AS VGA FROM specialty');
    CoNSQL.adoquery2.open;
    while not(CoNSQL.adoquery2.Eof) and (CoNSQL.adoquery2.RecordCount>0) do
    Begin
      ComboBox1.Items.Add(CoNSQL.adoquery2.fieldbyname('VGA').asstring);
      ComboBox2.Items.Add(CoNSQL.adoquery2.fieldbyname('VGA').asstring);
      ComboBox3.Items.Add(CoNSQL.adoquery2.fieldbyname('VGA').asstring);
      CoNSQL.adoquery2.Next;
    end;
    CoNSQL.ADOQuery2.SQL.Clear;
  end;

  addstudform.ShowModal;
end;

procedure TMainUserForm.DBGrid1TitleClick(Column: TColumn);
begin
  if CoNSQL.ADOQuery3.Sort <> ('['+ Column.FieldName + '] ASC') then
  CoNSQL.ADOQuery3.Sort:= '['+ Column.FieldName + '] ASC' else
  CoNSQL.ADOQuery3.Sort:= '['+ Column.FieldName + '] DESC'
end;

procedure TMainUserForm.N9Click(Sender: TObject);
begin
  see_abit_atest:=1;
  CoNSQL.ADOQuery4.SQL.Text:='exec sel_avg_atest NULL,:2';
  SeeForm.DBGrid1.Visible:=true;
  CoNSQL.ADOQuery4.Parameters.ParseSQL(CoNSQL.ADOQuery4.SQL.Text,true);
  CoNSQL.ADOQuery4.Parameters.ParamByName('2').Value:= 0;
  CoNSQL.ADOQuery4.Open;
  if not(CoNSQL.ADOQuery4.IsEmpty) then
  Begin
    SeeForm.DBGrid1.Columns[0].Width:=30;
    SeeForm.DBGrid1.Columns[1].Width:=100;
    SeeForm.DBGrid1.Columns[2].Width:=75;
    SeeForm.DBGrid1.Columns[3].Width:=100;
    SeeForm.DBGrid1.Columns[4].Width:=30;
    SeeForm.DBGrid1.Columns[0].Title.caption:='ID';
    SeeForm.DBGrid1.Columns[1].Title.caption:='Фамилия';
    SeeForm.DBGrid1.Columns[2].Title.caption:='Имя';
    SeeForm.DBGrid1.Columns[3].Title.caption:='Отчество';
    SeeForm.DBGrid1.Columns[4].Title.caption:='Балл';
  end else DBGrid1.Visible:=false;
  SeeForm.showmodal;
end;

procedure TMainUserForm.N4Click(Sender: TObject);
begin
  ProhForm.showmodal;
end;

procedure TMainUserForm.aborted;
var msgb:word;
begin
  showmessage('В разработке');
  msgb:=MessageBox(Handle,'Вы уверены что хотите продолжить?','Продолжить?',35);
  if not(msgb=idyes) then
  abort;
end;

procedure TMainUserForm.N27Click(Sender: TObject);
begin
  aborted;
end;

procedure TMainUserForm.N28Click(Sender: TObject);
begin
  aborted;
end;

procedure TMainUserForm.N16Click(Sender: TObject);
begin
  aborted;
end;

procedure TMainUserForm.N17Click(Sender: TObject);
begin
  aborted;
end;

procedure TMainUserForm.N23Click(Sender: TObject);
begin
  CoNSQL.ADOQuery4.SQL.Text:='exec sel_count_kurs';
  CoNSQL.ADOQuery4.Open;
  showmessage('Количество студентов проходивших курсы : ' + CoNSQL.ADOQuery4.Fields.Fields[0].AsString);
end;

procedure TMainUserForm.N24Click(Sender: TObject);
begin
  CoNSQL.ADOQuery4.SQL.Text:='exec sel_count_prow';
  CoNSQL.ADOQuery4.Open;
  StatistForm.showmodal;
end;

procedure TMainUserForm.N25Click(Sender: TObject);
begin
  CoNSQL.ADOQuery4.SQL.Text:='exec sel_count_benf';
  CoNSQL.ADOQuery4.Open;
  showmessage('Количество студентов имеющих льготы : ' + CoNSQL.ADOQuery4.Fields.Fields[0].AsString);
end;

procedure TMainUserForm.N12Click(Sender: TObject);
begin
  see_abit_atest:=1;
  CoNSQL.ADOQuery4.SQL.Text:='exec prowedwie NULL,NULL,0';
  CoNSQL.ADOQuery4.Open;
  SeeForm.Label3.Visible:=true;
  SeeForm.DBGrid1.Visible:=false;
  SeeForm.SpinEdit1.Visible:=true;
  SeeForm.N1.Visible:=true;
  SeeForm.ShowModal;
  SeeForm.SpinEdit1.Value:=0;
end;

procedure TMainUserForm.N13Click(Sender: TObject);
begin
  see_abit_atest:=2;
  CoNSQL.ADOQuery4.SQL.Text:='exec polu_proh NULL,NULL,0';
  CoNSQL.ADOQuery4.Open;
  SeeForm.Label3.Visible:=true;
  SeeForm.DBGrid1.Visible:=false;
  SeeForm.SpinEdit1.Visible:=true;
  SeeForm.N1.Visible:=true;
  SeeForm.ShowModal;
  SeeForm.SpinEdit1.Value:=0;
end;

procedure TMainUserForm.N14Click(Sender: TObject);
begin
  see_abit_atest:=3;
  CoNSQL.ADOQuery4.SQL.Text:='exec ne_prowedwie NULL,NULL,0';
  CoNSQL.ADOQuery4.Open;
  SeeForm.Label3.Visible:=true;
  SeeForm.DBGrid1.Visible:=false;
  SeeForm.SpinEdit1.Visible:=true;
  SeeForm.N1.Visible:=true;
  SeeForm.ShowModal;
  SeeForm.SpinEdit1.Value:=0;
end;

function TMainUserForm.show_your_atest: byte;
begin
  show_your_atest:=see_abit_atest;
end;

procedure TMainUserForm.N6Click(Sender: TObject);
begin
  CoNSQL.ADOQuery4.SQL.Text:='exec see_all_table';
  CoNSQL.ADOQuery4.Open;
  alltableform.showmodal;
end;

procedure TMainUserForm.N1Click(Sender: TObject);
begin
  halt;
end;

procedure TMainUserForm.N5Click(Sender: TObject);
begin
  CoNSQL.ADOConnection1.Connected:=false;
  MainUserForm.Hide;
  AuthForm.Show;
end;

procedure TMainUserForm.N10Click(Sender: TObject);
begin
  if CoNSQL.UserName = '' then
  Begin
    showmessage('Access denied');
  end else
  ChangePassForm.ShowModal;
end;

procedure TMainUserForm.NdocClick(Sender: TObject);
begin
  Nspec.Checked:=false;
  Ndoc.Checked:=true;
  CoNSQL.ADOQuery3.SQL.Text:='SELECT numb_doc AS [Номер], name AS [Название] '+
  'FROM document';
  CoNSQL.ADOQuery3.Open;
end;

procedure TMainUserForm.NspecClick(Sender: TObject);
begin
  Nspec.Checked:=true;
  Ndoc.Checked:=false;
  CoNSQL.ADOQuery3.SQL.Text:='SELECT name_spec AS [Название], code_spec AS [Код],'+
  'places AS [Мест] FROM specialty';
  CoNSQL.ADOQuery3.Open;
end;

procedure TMainUserForm.N40Click(Sender: TObject);
begin
  rd:=false;
  form4.ShowModal;
end;

procedure TMainUserForm.N41Click(Sender: TObject);
begin
  if trim(CoNSQL.adoquery3.Fields.Fields[0].asstring) <> CoNSQL.UserName then
  Begin
	  try
		form4.Edit1.Text:=trim(ConSQL.adoquery3.Fields.Fields[0].asstring);
	  except
		on E: Exception do
		Showmessage('ERRoR: ' + E.Message);
	  end;
	  rd:=true;
	  form4.Edit3.Text:='thisishesh';
	  form4.ShowModal;
  end else showmessage('Access denied!');
end;

end.
