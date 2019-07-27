unit UnitSplashFinder;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls;

type
  T_FormSplashFinder = class(TForm)
    Image1: TImage;
    LabelDataLoading: TLabel;
    ProgressBar: TProgressBar;
    Image2: TImage;
    Label2: TLabel;
    Label3: TLabel;
    ButtonOK: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonOKKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  _FormSplashFinder: T_FormSplashFinder;

implementation

{$R *.DFM}

procedure T_FormSplashFinder.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 ButtonOK.Visible:= False;
 ProgressBar.Visible:= True;
 LabelDataLoading.Visible:= True;
end;

procedure T_FormSplashFinder.ButtonOKKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=VK_ESCAPE then Close;
end;

end.
