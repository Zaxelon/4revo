unit ATableForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, acDBGrid;

type
  TAllTableForm = class(TForm)
    sDBGrid1: TsDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AllTableForm: TAllTableForm;

implementation

{$R *.dfm}

end.
