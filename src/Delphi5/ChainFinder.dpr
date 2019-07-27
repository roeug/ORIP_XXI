program ChainFinder;

uses
  Forms,
  UnitChainFinder in 'UnitChainFinder.pas' {_FormChainFinder},
  DM_OOD in 'DM_OOD.pas',
  EuLib in 'EuLib.pas',
  NuclideClasses in 'NuclideClasses.pas',
  UnitDM_OOB in 'UnitDM_OOB.pas' {_DataModuleOOB: TDataModule},
  UnitSplashFinder in 'UnitSplashFinder.pas' {_FormSplashFinder},
  ChainClasses in 'ChainClasses.pas',
  UnitAddState in 'UnitAddState.pas' {_FormAddState};

{$R *.RES}

begin
 Application.Initialize;
  _FormSplashFinder:= T_FormSplashFinder.Create(Application);
  with _FormSplashFinder do begin
//   Label3.Caption:= 'Chain Finder';
   Show;
   Update;{Process any pending Windows paint messages}
  end;
  Application.CreateForm(T_FormChainFinder, _FormChainFinder);
  Application.CreateForm(T_DataModuleOOB, _DataModuleOOB);
  Application.CreateForm(T_FormAddState, _FormAddState);
//  _DataModuleOOB.DatabaseName:= 'ORIP_XXI.OOB';
  _FormChainFinder.TheDataModule:= _DataModuleOOB;
 try
  with _FormSplashFinder do begin
//   Label3.Caption:= 'Chain Finder';
   Show;
   Update;{Process any pending Windows paint messages}
   if (_FormChainFinder.TheDataModule is T_DataModuleOOB) then begin
    T_DataModuleOOB(_FormChainFinder.TheDataModule).PanelDatabaseName:= _FormChainFinder.PanelDatabaseName;
    _FormChainFinder.CreateNuclideList;//Create NuclideList
    _FormChainFinder.LoadNuclideList;//Load NuclideList
   end;
  end;
  Application.ProcessMessages;
 finally{Make sure the splash screen gets released}
  _FormSplashFinder.Close;
  _FormChainFinder.Show;
  Application.Run;
 end;
end.

