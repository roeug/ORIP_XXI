program NKE;

uses
  Forms,
  UnitSplash in 'UnitSplash.pas' {_FormSplash},
  ChainClasses in 'ChainClasses.pas',
  Encryp in 'Encryp.pas',
  NuclideClasses in 'NuclideClasses.pas',
  PanelFileName in 'PanelFileName.pas',
  UnitDPrChooseCriteriaNKE in 'UnitDPrChooseCriteriaNKE.pas' {_FormDPRChooseCriteria},
  UnitEditElement in 'UnitEditElement.pas' {_FormEditElement},
  UnitEditNuclide in 'UnitEditNuclide.pas' {_FormEditNuclide},
  UnitFrmList in 'UnitFrmList.pas' {_FrmList},
  UnitGoToDialog in 'UnitGoToDialog.pas' {_FormGoToDialog},
  UnitLegend in 'UnitLegend.pas' {_FormLegend},
  UnitNK in 'UnitNK.pas' {_FormNK},
  BKStringGrid in 'BKStringGrid.pas',
  UnitDM_DAO in 'UnitDM_DAO.pas' {_DataModuleDAO: TDataModule},
  UnitDM_OOB in 'UnitDM_OOB.pas' {_DataModuleOOB: TDataModule},
  DM_OOD in 'DM_OOD.pas',
  UnitDecay in 'UnitDecay.pas' {_FormDecay},
  EuLib in 'EuLib.pas',
  UnitChooseCriteria in 'UnitChooseCriteria.pas' {_FormChooseCriteria},
  UnitChainNKE in 'UnitChainNKE.pas' {_FormChainNKE};

{$R *.RES}
const
 hc_Introduction = 1;
 hc_Overview = 2;
 hc_Main_Program_Window = 3;
 hc_Filter_Utility = 4;
 hc_Contents = 5;
 hc_Nuclide_Properties = 6;
 hc_Ground_state = 7;
 hc_Metastable_M1_State = 8;
 hc_Alpha_Lines = 9;
 hc_Beta_Spectrum = 10;
 hc_Gamma_Lines = 11;
 hc_Positron_Spectrum = 12;
 hc_Electron_Lines = 13;
 hc_Neutron_Reactions_Cross_Sections = 14;
 hc_Fission_Yields = 15;
 hc_Decay_Calculator = 16;
 hc_Element_Properties = 17;
 hc_Data_Sources = 18;
 hc_Loading_another_data_file = 19;
 hc_Coding_Team = 20;
 hc_Filter_Results = 21;
 hc_FilterPlus_Utility = 22;
 hc_ChainNKE = 23;

begin
 Application.Initialize;
 Application.Title:= 'NUKLIDKARTE';
 Application.HelpFile:= 'NKE.HLP';
 _FormSplash:= T_FormSplash.Create(Application);
 with _FormSplash do
 begin
  Show;
  Update; {Process any pending Windows paint messages}
 end;
 Application.CreateForm(T_FormNK, _FormNK);
  Application.CreateForm(T_FormDecay, _FormDecay);
  Application.CreateForm(T_FormChooseCriteria, _FormChooseCriteria);
  Application.CreateForm(T_FormDPRChooseCriteria, _FormDPRChooseCriteria);
  Application.CreateForm(T_FormChainNKE, _FormChainNKE);
  _DataModuleOOB:= T_DataModuleOOB.Create(Application);
 _FormNK.TheDataModule:= _DataModuleOOB;
 if (_FormNK.TheDataModule is T_DataModuleDAO) then
  T_DataModuleDAO(_FormNK.TheDataModule).AfterCreate // To avoid decompiling using Delphi Object Inspector Names
 else if (_FormNK.TheDataModule is T_DataModuleOOB) then
  T_DataModuleOOB(_FormNK.TheDataModule).AfterCreate;
//************
 Application.CreateForm(T_FrmList, _FrmList);
 Application.CreateForm(T_FormGoToDialog, _FormGoToDialog);
 try
  with _FormSplash do
  begin
   Update; {Process any pending Windows paint messages}
   if (_FormNK.TheDataModule is T_DataModuleDAO) then
    T_DataModuleDAO(_FormNK.TheDataModule).PanelDatabaseName:= _FormNK.PanelDatabaseName
   else if (_FormNK.TheDataModule is T_DataModuleOOB) then
    T_DataModuleOOB(_FormNK.TheDataModule).PanelDatabaseName:= _FormNK.PanelDatabaseName;
   _FormNK.ButtonReloadDBClick(_FormNK); //Load NuclideList
  end;
  Application.ProcessMessages;
 finally {Make sure the splash screen gets released}
  _FormSplash.Close;
  _FormNK.ShowSplashScreen:= True;
 end;
 Application.CreateForm(T_FormLegend, _FormLegend);
 Application.CreateForm(T_FormEditNuclide, _FormEditNuclide);
 Application.CreateForm(T_FormEditElement, _FormEditElement);
 Application.CreateForm(T_FormDecay, _FormDecay);
{$IFDEF RELEASE}
{$ELSE}
 Application.CreateForm(T_FormDialog1, _FormDialog1);
{$ENDIF}
// HelpContext
 _FormNK.HelpContext:= hc_Main_Program_Window;
 _FormChooseCriteria.HelpContext:= hc_Filter_Utility;
 _FormDPRChooseCriteria.HelpContext:= hc_FilterPlus_Utility;
 _FormChainNKE.HelpContext:=  hc_ChainNKE;
 _FormEditNuclide.HelpContext:= hc_Nuclide_Properties;
 _FormDecay.HelpContext:= hc_Decay_Calculator;
 _FormEditElement.HelpContext:= hc_Element_Properties;
 _FrmList.HelpContext:= hc_Filter_Results;
//  HelpContext end
 Application.Run;
end.

