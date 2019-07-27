unit UnitLookInOOB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids;

type
  T_FormLookInOOB = class(TForm)
    StringGridLook: TStringGrid;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  _FormLookInOOB: T_FormLookInOOB;

implementation

uses UnitSplashSolver;

{$R *.DFM}

procedure T_FormLookInOOB.FormResize(Sender: TObject);
var
 I: integer;
begin
 if (StringGridLook.ColCount=2) then
  StringGridLook.ColWidths[1]:= StringGridLook.Width-15
 else
  for I:=0 to StringGridLook.ColCount-1 do
   StringGridLook.ColWidths[I]:= StringGridLook.Width div (StringGridLook.ColCount+1);
end;

procedure T_FormLookInOOB.FormCreate(Sender: TObject);
var
 I: integer;
begin
 for I:=0 to StringGridLook.RowCount-1 do
  StringGridLook.Cells[0,I]:=IntToStr(I+1);
end;

procedure T_FormLookInOOB.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (Key=VK_ESCAPE) then
  Close;
end;

procedure T_FormLookInOOB.FormShow(Sender: TObject);
begin
 if _FormSplashSolver.Visible then
  _FormSplashSolver.Hide;
end;

end.
