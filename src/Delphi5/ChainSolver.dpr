program ChainSolver;

uses
 Forms,
 UnitChainEditor in 'UnitChainEditor.pas' {_FormChainEditor},
 ChainClasses in 'ChainClasses.pas',
 CadClasses in 'CadClasses.pas',
 UnitLookInOOB in 'UnitLookInOOB.pas' {_FormLookInOOB},
 UnitFormMemoOkCancel in 'UnitFormMemoOkCancel.pas' {_FormMemoOKCancel},
 UnitSplashSolver in 'UnitSplashSolver.pas' {_FormSplashSolver},
 NuclideClasses in 'NuclideClasses.pas';

{$R *.RES}

begin
 Application.Initialize;
 _FormSplashSolver:= T_FormSplashSolver.Create(Application);
 with _FormSplashSolver do
 begin
  Show;
  Update; {Process any pending Windows paint messages}
 end;
 Application.HelpFile:= 'ChainSolver.hlp';
 Application.Title:= 'ChainSolver';
 Application.CreateForm(T_FormChainEditor, _FormChainEditor);
 with _FormSplashSolver do
 begin
  ProgressBar.Position:= (ProgressBar.Position + 1) mod ProgressBar.Max;
  Update; {Process any pending Windows paint messages}
 end;
 Application.CreateForm(T_FormLookInOOB, _FormLookInOOB);
 with _FormSplashSolver do
 begin
  ProgressBar.Position:= (ProgressBar.Position + 1) mod ProgressBar.Max;
  Update; {Process any pending Windows paint messages}
 end;
 Application.CreateForm(T_FormMemoOKCancel, _FormMemoOKCancel);
 with _FormSplashSolver do
 begin
  ProgressBar.Position:= (ProgressBar.Position + 1) mod ProgressBar.Max;
  Update; {Process any pending Windows paint messages}
 end;
 _FormChainEditor.FormInit(nil);
 with _FormSplashSolver do
 begin
  ProgressBar.Position:= (ProgressBar.Position + 1) mod ProgressBar.Max;
  Update; {Process any pending Windows paint messages}
 end;
 _FormChainEditor.Show;
 Application.ProcessMessages;
 _FormChainEditor.KeyPreview:= True;
 with _FormSplashSolver do
 begin
  ProgressBar.Position:= (ProgressBar.Position + 1) mod ProgressBar.Max;
  Update; {Process any pending Windows paint messages}
 end;
 _FormChainEditor.OnKeyUp:= _FormChainEditor.FormKeyUp;
 Application.Run;
end.

