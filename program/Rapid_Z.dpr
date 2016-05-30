program Rapid_Z;
//Автор Орищенко Андрей П-304.
uses
  Forms,
  AuthUnit in 'Units\AuthUnit.pas' {AuthForm},
  MainUserUnit in 'Units\MainUserUnit.pas' {MainUserForm},
  Add_obwee in 'Units\Add_obwee.pas' {AddObweeForm},
  NetAPI in 'Units\netapi.pas',
  ForMeMComp in 'Units\ForMeMComp.pas' {CoNSQL: TDataModule},
  add_abiture in 'Units\add_abiture.pas' {AddStudForm},
  pasport in 'Units\pasport.pas' {PasportForm},
  Doc_unit in 'Units\Doc_unit.pas' {DocForm},
  pasp_rod in 'Units\pasp_rod.pas' {PaspRodForm},
  atestat in 'Units\atestat.pas' {Atestat},
  OGE in 'Units\OGE.pas' {OGEG},
  Priem in 'Units\Priem.pas' {Priemform},
  Lgot in 'Units\Lgot.pas' {LgotForm},
  SeeUnit in 'units\SeeUnit.pas' {SeeForm},
  Prohball in 'units\Prohball.pas' {ProhForm},
  StForm in 'units\StForm.pas' {StatistForm},
  ATableForm in 'units\ATableForm.pas' {AllTableForm},
  ChangePassUnit in 'units\ChangePassUnit.pas' {ChangePassForm},
  UserUnit in 'units\UserUnit.pas' {UserForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'База приемной комиссии колледжа';
  Application.CreateForm(TAuthForm, AuthForm);
  Application.CreateForm(TMainUserForm, MainUserForm);
  Application.CreateForm(TAddObweeForm, AddObweeForm);
  Application.CreateForm(TCoNSQL, CoNSQL);
  Application.CreateForm(Taddstudform, addstudform);
  Application.CreateForm(TPasportForm, PasportForm);
  Application.CreateForm(TDoc_form, Doc_form);
  Application.CreateForm(TPasp_rod_Form, Pasp_rod_Form);
  Application.CreateForm(TAtest_form, Atest_form);
  Application.CreateForm(TOGEG, OGEG);
  Application.CreateForm(TPriem_form, Priem_form);
  Application.CreateForm(TLgotForm, LgotForm);
  Application.CreateForm(TSeeForm, SeeForm);
  Application.CreateForm(TProhForm, ProhForm);
  Application.CreateForm(TStatistForm, StatistForm);
  Application.CreateForm(TAllTableForm, AllTableForm);
  Application.CreateForm(TChangePassForm, ChangePassForm);
  Application.CreateForm(TForm4, Form4);
  Application.ShowMainForm:=false;
  AuthForm.Show;
  Application.Run;
end.
