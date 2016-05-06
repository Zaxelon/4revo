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
    procedure N22Click(Sender: TObject);
  private
    see_abit_atest:byte;
  public
    uwpdate:boolean;
    procedure aborted;
    function show_your_atest:byte;
  end;

var
  MainUserForm: TMainUserForm;
  rd:boolean;

implementation

{$R *.dfm}
uses ForMeMComp, Add_obwee, AuthUnit, add_abiture, pasport, Doc_unit,
  pasp_rod, Priem, SeeUnit, Prohball, StForm, ATableForm, ChangePassUnit, UserUnit,
  OGE, Lgot, atestat;

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
    DBGrid1.Columns[0].Width:=30;
    DBGrid1.Columns[1].Width:=100;
    DBGrid1.Columns[2].Width:=75;
    DBGrid1.Columns[3].Width:=100;
    DBGrid1.Columns[6].Width:=275;
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
  uwpdate:=false;
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

  with Atest_form do
  Begin
    edit1.Text:='';
    edit2.Text:='';
    edit3.Text:='';
    CheckBox1.checked:=false;
    edit5.date:=Date;
  end;

  with OGEG do
  Begin
    edit1.Text:='';
    edit3.Text:='';
    edit5.date:=Date;
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

  with LgotForm do
  Begin
    edit1.Text:='';
    edit2.Text:='';
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
begin
  CoNSQL.ADOQuery1.SQL.Text:='SELECT surname,first_name,middle_name,is_male,'+
  'CONVERT(varchar(30), birthday, 104) AS [DDate],phone,address,training_courses FROM abiture WHERE id_statement=:1';
  CoNSQL.ADOQuery1.Parameters.ParseSQL(CoNSQL.ADOQuery1.SQL.Text,true);
  CoNSQL.ADOQuery1.Parameters.ParamByName('1').Value:= addstudform.abit_id;
  CoNSQL.ADOQuery1.Open;
  if CoNSQL.ADOQuery1.IsEmpty then abort;
  uwpdate:=true;
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

  CoNSQL.ADOQuery1.SQL.Text:='SELECT surname,first_name,middle_name,is_male,'+
  'CONVERT(varchar(30), birthday, 104) AS [DDate],phone,address,training_courses FROM abiture WHERE id_statement=:1';
  CoNSQL.ADOQuery1.Parameters.ParseSQL(CoNSQL.ADOQuery1.SQL.Text,true);
  CoNSQL.ADOQuery1.Parameters.ParamByName('1').Value:= addstudform.abit_id;
  CoNSQL.ADOQuery1.Open;
  with AddObweeForm do
  Begin
    edit1.Text:=Consql.ADOQuery1.FieldByName('surname').AsString;
    edit2.Text:=Consql.ADOQuery1.FieldByName('first_name').AsString;
    edit3.Text:=Consql.ADOQuery1.FieldByName('middle_name').AsString;
    if (Consql.ADOQuery1.FieldByName('is_male').AsBoolean) then
    Begin RadioButton1.Checked:=true; end else
    Begin RadioButton1.Checked:=false; RadioButton2.Checked:=true; end;
    edit5.Date:=strtodate(Consql.ADOQuery1.FieldByName('DDate').AsString);
    edit6.Text:=Consql.ADOQuery1.FieldByName('phone').AsString;
    edit7.Text:=Consql.ADOQuery1.FieldByName('address').AsString;;
    Checkbox1.Checked:=Consql.ADOQuery1.FieldByName('training_courses').AsBoolean;
  end;

  CoNSQL.ADOQuery1.SQL.Text:='SELECT series,numb,place_of_birth,issued_by,'+
  'CONVERT(varchar(30),date_of_issue, 104) AS [DDate] FROM pasport WHERE id_statement=:1';
  CoNSQL.ADOQuery1.Parameters.ParseSQL(CoNSQL.ADOQuery1.SQL.Text,true);
  CoNSQL.ADOQuery1.Parameters.ParamByName('1').Value:= addstudform.abit_id;
  CoNSQL.ADOQuery1.Open;
  with PasportForm do
  Begin
    edit1.Text:=CoNSQL.ADOQuery1.FieldByName('series').AsString;
    edit2.Text:=CoNSQL.ADOQuery1.FieldByName('numb').AsString;;
    edit3.Text:=CoNSQL.ADOQuery1.FieldByName('place_of_birth').AsString;
    edit4.Text:=CoNSQL.ADOQuery1.FieldByName('issued_by').AsString;;
    edit5.Date:=strtodate(Consql.ADOQuery1.FieldByName('DDate').AsString);
  end;

  CoNSQL.ADOQuery1.SQL.Text:='SELECT document.name FROM document INNER JOIN documents ON document.numb_doc = documents.numb_doc '+
  'WHERE documents.id_statement = :1';
  CoNSQL.ADOQuery1.Parameters.ParseSQL(CoNSQL.ADOQuery1.SQL.Text,true);
  CoNSQL.ADOQuery1.Parameters.ParamByName('1').Value:= addstudform.abit_id;
  CoNSQL.ADOQuery1.Open;
  with Doc_form do
  Begin
    ListBox1.Clear;
    ListBox2.Clear;
    While not consql.ADOQuery1.Eof do
    begin
      ListBox1.Items.Add(consql.ADOQuery1.FieldByName('name').AsString);
      consql.ADOQuery1.Next;
    end;
    CoNSQL.ADOQuery1.SQL.Text:='SELECT name FROM document WHERE name NOT IN '+
    '(SELECT document.name FROM document INNER JOIN documents ON '+
    'document.numb_doc = documents.numb_doc WHERE documents.id_statement = :1)';
    CoNSQL.ADOQuery1.Parameters.ParseSQL(CoNSQL.ADOQuery1.SQL.Text,true);
    CoNSQL.ADOQuery1.Parameters.ParamByName('1').Value:= addstudform.abit_id;
    CoNSQL.ADOQuery1.Open;
    While not consql.ADOQuery1.Eof do
    begin
      ListBox2.Items.Add(consql.ADOQuery1.FieldByName('name').AsString);
      consql.ADOQuery1.Next;
    end;
  end;

  CoNSQL.ADOQuery1.SQL.Text:='SELECT series,numb,surname,first_name,middle_name,place_of_birth, '+
  'CONVERT(varchar(30), birthday, 104) AS [DDate] FROM pasp_rod WHERE id_statement=:1';
  CoNSQL.ADOQuery1.Parameters.ParseSQL(CoNSQL.ADOQuery1.SQL.Text,true);
  CoNSQL.ADOQuery1.Parameters.ParamByName('1').Value:= addstudform.abit_id;
  CoNSQL.ADOQuery1.Open;
  with Pasp_rod_Form do
  Begin
    edit1.Text:=CoNSQL.ADOQuery1.FieldByName('series').AsString;
    edit2.Text:=CoNSQL.ADOQuery1.FieldByName('numb').AsString;
    edit3.Text:=CoNSQL.ADOQuery1.FieldByName('place_of_birth').AsString;
    edit5.Date:=strtodate(Consql.ADOQuery1.FieldByName('DDate').AsString);
    edit6.Text:=Consql.ADOQuery1.FieldByName('surname').AsString;
    edit7.Text:=Consql.ADOQuery1.FieldByName('first_name').AsString;
    edit8.Text:=Consql.ADOQuery1.FieldByName('middle_name').AsString;
  end;

  CoNSQL.ADOQuery1.SQL.Text:='SELECT numb_at,institution,s_otl,avgn, '+
  'CONVERT(varchar(30), date_of_issue, 104) AS [DDate] FROM atestat WHERE id_statement=:1';
  CoNSQL.ADOQuery1.Parameters.ParseSQL(CoNSQL.ADOQuery1.SQL.Text,true);
  CoNSQL.ADOQuery1.Parameters.ParamByName('1').Value:= addstudform.abit_id;
  CoNSQL.ADOQuery1.Open;
  with Atest_form do
  Begin
    edit1.Text:=CoNSQL.ADOQuery1.FieldByName('numb_at').AsString;
    edit2.Text:=CoNSQL.ADOQuery1.FieldByName('institution').AsString;
    edit3.Text:=CoNSQL.ADOQuery1.FieldByName('avgn').AsString;;
    Checkbox1.Checked:=Consql.ADOQuery1.FieldByName('s_otl').AsBoolean;
    edit5.Date:=strtodate(Consql.ADOQuery1.FieldByName('DDate').AsString);
  end;

  CoNSQL.ADOQuery1.SQL.Text:='SELECT numb_sv,avg_oge, '+
  'CONVERT(varchar(30), date_of_issue, 104) AS [DDate] FROM oge WHERE id_statement=:1';
  CoNSQL.ADOQuery1.Parameters.ParseSQL(CoNSQL.ADOQuery1.SQL.Text,true);
  CoNSQL.ADOQuery1.Parameters.ParamByName('1').Value:= addstudform.abit_id;
  CoNSQL.ADOQuery1.Open;
  with OGEG do
  Begin
    edit1.Text:=CoNSQL.ADOQuery1.FieldByName('numb_sv').AsString;
    edit3.Text:=CoNSQL.ADOQuery1.FieldByName('avg_oge').AsString;
    edit5.date:=strtodate(Consql.ADOQuery1.FieldByName('DDate').AsString);
  end;

  CoNSQL.ADOQuery1.SQL.Text:='EXEC priem_doz :1';
  CoNSQL.ADOQuery1.Parameters.ParseSQL(CoNSQL.ADOQuery1.SQL.Text,true);
  CoNSQL.ADOQuery1.Parameters.ParamByName('1').Value:= addstudform.abit_id;
  CoNSQL.ADOQuery1.Open;
  with Priem_form do
  Begin
    ComboBox1.Clear;
    ComboBox2.Clear;
    ComboBox3.Clear;
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
    if Not(CoNSQL.ADOQuery1.IsEmpty) and not(CoNSQL.ADOQuery1.Eof) then
    Begin
      Combobox1.ItemIndex:=CoNSQL.ADOQuery1.FieldByName('num').AsInteger-1;
      CoNSQL.ADOQuery1.Next;
    end;
    if Not(CoNSQL.ADOQuery1.IsEmpty) and not(CoNSQL.ADOQuery1.Eof) then
    Begin
      Combobox2.ItemIndex:=CoNSQL.ADOQuery1.FieldByName('num').AsInteger-1;
      CoNSQL.ADOQuery1.Next;
    end;
    if Not(CoNSQL.ADOQuery1.IsEmpty) and not(CoNSQL.ADOQuery1.Eof) then
    Begin
      Combobox3.ItemIndex:=CoNSQL.ADOQuery1.FieldByName('num').AsInteger-1;
      CoNSQL.ADOQuery1.Next;
    end;
  end;

  CoNSQL.ADOQuery1.SQL.Text:='SELECT name,document_number FROM benefits WHERE id_statement=:1';
  CoNSQL.ADOQuery1.Parameters.ParseSQL(CoNSQL.ADOQuery1.SQL.Text,true);
  CoNSQL.ADOQuery1.Parameters.ParamByName('1').Value:= addstudform.abit_id;
  CoNSQL.ADOQuery1.Open;
  with LgotForm do
  Begin
    edit1.Text:=CoNSQL.ADOQuery1.FieldByName('name').AsString;
    edit2.Text:=CoNSQL.ADOQuery1.FieldByName('document_number').AsString;
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
var temp_id:integer;
begin
  temp_id:=CoNSQL.ADOQuery3.FieldByName('ID').AsInteger;
  CoNSQL.MyRave.SetParam('DTFAM',CoNSQL.ADOQuery3.FieldByName('Фамилия').AsString);
  CoNSQL.MyRave.SetParam('DTNAM',CoNSQL.ADOQuery3.FieldByName('Имя').AsString);
  CoNSQL.MyRave.SetParam('DTOT4',CoNSQL.ADOQuery3.FieldByName('Отчество').AsString);
  CoNSQL.MyRave.SetParam('DTRJD',CoNSQL.ADOQuery3.FieldByName('День рождения').AsString);
  CoNSQL.MyRave.SetParam('DTADR',CoNSQL.ADOQuery3.FieldByName('Адрес').AsString);
  CoNSQL.TempQuery.SQL.Text:='SELECT series,numb,date_of_issue FROM pasport WHERE id_statement = :1';
  CoNSQL.TempQuery.Parameters.ParseSQL(CoNSQL.TempQuery.SQL.Text,true);
  CoNSQL.TempQuery.Parameters.ParamByName('1').Value:=temp_id;
  CoNSQL.TempQuery.Open;
  CoNSQL.MyRave.SetParam('DTSER',CoNSQL.TempQuery.FieldByName('series').AsString);
  CoNSQL.MyRave.SetParam('DTNUM',CoNSQL.TempQuery.FieldByName('numb').AsString);
  CoNSQL.MyRave.SetParam('DTDVI',CoNSQL.TempQuery.FieldByName('date_of_issue').AsString);
  CoNSQL.TempQuery.SQL.Text:='SELECT phone FROM abiture WHERE id_statement = :1';
  CoNSQL.TempQuery.Parameters.ParseSQL(CoNSQL.TempQuery.SQL.Text,true);
  CoNSQL.TempQuery.Parameters.ParamByName('1').Value:=temp_id;
  CoNSQL.TempQuery.Open;
  CoNSQL.MyRave.SetParam('DTTEL',CoNSQL.TempQuery.FieldByName('phone').AsString);
  CoNSQL.TempQuery.SQL.Text:='SELECT name_spec,code_spec FROM priem INNER JOIN specialty '+
  'ON priem.id_spec = specialty.id_spec WHERE id_statement = :1 ORDER BY priority ASC';
  CoNSQL.TempQuery.Parameters.ParseSQL(CoNSQL.TempQuery.SQL.Text,true);
  CoNSQL.TempQuery.Parameters.ParamByName('1').Value:=temp_id;
  CoNSQL.TempQuery.Open;
  CoNSQL.TempQuery.First;
  CoNSQL.MyRave.SetParam('DTNS1',CoNSQL.TempQuery.FieldByName('name_spec').AsString);
  CoNSQL.MyRave.SetParam('DTKS1',CoNSQL.TempQuery.FieldByName('code_spec').AsString);
  CoNSQL.TempQuery.Next;
  CoNSQL.MyRave.SetParam('DTNS2',CoNSQL.TempQuery.FieldByName('name_spec').AsString);
  CoNSQL.MyRave.SetParam('DTKS2',CoNSQL.TempQuery.FieldByName('code_spec').AsString);
  CoNSQL.TempQuery.Next;
  CoNSQL.MyRave.SetParam('DTNS3',CoNSQL.TempQuery.FieldByName('name_spec').AsString);
  CoNSQL.MyRave.SetParam('DTKS3',CoNSQL.TempQuery.FieldByName('code_spec').AsString);
  CoNSQL.TempQuery.SQL.Text:='SELECT numb_at,avgn,date_of_issue FROM atestat WHERE id_statement = :1';
  CoNSQL.TempQuery.Parameters.ParseSQL(CoNSQL.TempQuery.SQL.Text,true);
  CoNSQL.TempQuery.Parameters.ParamByName('1').Value:=temp_id;
  CoNSQL.TempQuery.Open;
  CoNSQL.MyRave.SetParam('DTANB',CoNSQL.TempQuery.FieldByName('numb_at').AsString);
  CoNSQL.MyRave.SetParam('DTASB',CoNSQL.TempQuery.FieldByName('avgn').AsString);
  CoNSQL.MyRave.SetParam('DTADI',CoNSQL.TempQuery.FieldByName('date_of_issue').AsString);
  CoNSQL.TempQuery.SQL.Text:='SELECT name FROM benefits WHERE id_statement = :1';
  CoNSQL.TempQuery.Parameters.ParseSQL(CoNSQL.TempQuery.SQL.Text,true);
  CoNSQL.TempQuery.Parameters.ParamByName('1').Value:=temp_id;
  CoNSQL.TempQuery.Open;
  if not(CoNSQL.TempQuery.IsEmpty) then
  CoNSQL.MyRave.SetParam('DTNBN',CoNSQL.TempQuery.FieldByName('name').AsString) else
  CoNSQL.MyRave.SetParam('DTNBN','-');
  CoNSQL.MyRave.Close;
  CoNSQL.MyRave.ProjectFile:='.\ravki\Za9vl.rav';
  CoNSQL.MyRave.Execute;
end;

procedure TMainUserForm.N28Click(Sender: TObject);
var temp_id:integer; temp_s:string;
begin
  CoNSQL.MyRave.SetParam('DTDAT',datetostr(Date));
  temp_s:='"'+CoNSQL.ADOQuery3.FieldByName('Фамилия').AsString+' '+
  CoNSQL.ADOQuery3.FieldByName('Имя').AsString+' '+
  CoNSQL.ADOQuery3.FieldByName('Отчество').AsString+'"';
  temp_id:=CoNSQL.ADOQuery3.FieldByName('ID').AsInteger;
  CoNSQL.MyRave.SetParam('DTSTD',temp_s);
  CoNSQL.TempQuery.SQL.Text:='SELECT name FROM document INNER JOIN documents '+
  'ON document.numb_doc = documents.numb_doc WHERE id_statement = :1';
  CoNSQL.TempQuery.Parameters.ParseSQL(CoNSQL.TempQuery.SQL.Text,true);
  CoNSQL.TempQuery.Parameters.ParamByName('1').Value:=temp_id;
  CoNSQL.TempQuery.Open;
  CoNSQL.MyRave.Close;
  CoNSQL.MyRave.ProjectFile:='.\ravki\rasp.rav';
  CoNSQL.MyRave.Execute;
end;

procedure TMainUserForm.N24Click(Sender: TObject);
begin
  CoNSQL.TempQuery.SQL.Text:='SELECT COUNT(*) FROM abiture WHERE training_courses = 1';
  CoNSQL.TempQuery.Open;
  StatistForm.Label3.Caption:=CoNSQL.TempQuery.Fields.Fields[0].AsString;
  CoNSQL.TempQuery.SQL.Text:='SELECT COUNT(*) FROM abiture INNER JOIN benefits '+
  'ON abiture.id_statement = benefits.id_statement';
  CoNSQL.TempQuery.Open;
  StatistForm.Label5.Caption:=CoNSQL.TempQuery.Fields.Fields[0].AsString;
  CoNSQL.ADOQuery4.SQL.Text:='SELECT name_spec AS [Специальность], places AS [Мест],'+
  ' prowed AS [Прошедшие], ne_prowed AS [Не прошедшие] FROM abit_prow';
  CoNSQL.ADOQuery4.Open;
  if not(CoNSQL.ADOQuery4.IsEmpty) then
  Begin
    StatistForm.DBGrid1.Columns[0].Width:=350;
    StatistForm.DBGrid1.Columns[1].Width:=75;
    StatistForm.DBGrid1.Columns[2].Width:=75;
    StatistForm.DBGrid1.Columns[3].Width:=85;
  end;
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

procedure TMainUserForm.N22Click(Sender: TObject);
begin
  CoNSQL.TempQuery.SQL.Text:='SELECT COUNT(*) FROM abiture WHERE training_courses = 1';
  CoNSQL.TempQuery.Open;
  StatistForm.Label3.Caption:=CoNSQL.TempQuery.Fields.Fields[0].AsString;
  CoNSQL.TempQuery.SQL.Text:='SELECT COUNT(*) FROM abiture INNER JOIN benefits '+
  'ON abiture.id_statement = benefits.id_statement';
  CoNSQL.TempQuery.Open;
  StatistForm.Label5.Caption:=CoNSQL.TempQuery.Fields.Fields[0].AsString;
  CoNSQL.ADOQuery4.SQL.Text:='SELECT name_spec AS [Специальность], places AS [Мест],'+
  ' prowed AS [Прошедшие], ne_prowed AS [Не прошедшие] FROM abit_prow';
  CoNSQL.ADOQuery4.Open;
  if not(CoNSQL.ADOQuery4.IsEmpty) then
  Begin
    StatistForm.DBGrid1.Columns[0].Width:=350;
    StatistForm.DBGrid1.Columns[1].Width:=75;
    StatistForm.DBGrid1.Columns[2].Width:=75;
    StatistForm.DBGrid1.Columns[3].Width:=85;
  end;
  StatistForm.showmodal;
end;

end.
