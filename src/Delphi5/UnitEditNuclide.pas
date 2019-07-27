unit UnitEditNuclide;

interface

uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
 ExtCtrls, ComCtrls, NuclideClasses, Grids, RXGrids, RXCtrls, StdCtrls,
 Mask, ToolEdit, CurrEdit, ToolWin, Buttons, EuLib;

type
 T_FormEditNuclide = class(TForm)
  PanelTool: TPanel;
  SpeedButtonCommonPanel: TSpeedButton;
  SpeedButtonGstate: TSpeedButton;
  SpeedButtonM1State: TSpeedButton;
  SpeedButtonM2State: TSpeedButton;
  SpeedButtonPlusState: TSpeedButton;
  SpeedButtonSaveToDB: TSpeedButton;
  ProgressBar: TProgressBar;
  SpeedButtonToNuclideList: TSpeedButton;
  CheckBoxDebug: TCheckBox;
  ScrollBoxCommon: TPanel;
  LabelAmass: TLabel;
  LabelSymbol: TLabel;
  Image1: TImage;
  LabelAbundance: TLabel;
  EditAbundance: TEdit;
  ScrollBoxState: TPanel;
  SpeedButtonDeleteState: TSpeedButton;
  SpeedButtonPasteState: TSpeedButton;
  SpeedButtonCopyState: TSpeedButton;
  PanelGridChoice: TPanel;
  SpeedButtonAlpha: TSpeedButton;
  SpeedButtonBeta: TSpeedButton;
  SpeedButtonGamma: TSpeedButton;
  PanelT1_2: TPanel;
  EditT1_2: TEdit;
  EditT1_2RO: TEdit;
  PanelCapture: TPanel;
  PanelCaptureCommon: TPanel;
  LabelCaptions: TLabel;
  LabelCaptureToG: TLabel;
  EditCaptureToG: TEdit;
  LabelCaptureToM1: TLabel;
  EditCaptureToM1: TEdit;
  EditCaptureToM2: TEdit;
  LabelCaptureToM2: TLabel;
  EditRItoG: TEdit;
  LabelRItoG: TLabel;
  Label4: TLabel;
  LabelRItoM1: TLabel;
  EditRItoM1: TEdit;
  LabelRItoM2: TLabel;
  EditRItoM2: TEdit;
  PanelDecay: TPanel;
  RxDrawGridDecays: TRxDrawGrid;
  Splitter1: TSplitter;
  SpeedButtonCapture: TSpeedButton;
  SpeedButtonFission: TSpeedButton;
  PanelFission: TPanel;
  EditSigmaF: TEdit;
  EditRIf: TEdit;
  Label1: TLabel;
  Label2: TLabel;
  SpeedButtonDecayCount: TSpeedButton;
  LabelDecays: TLabel;
  LabelLines: TLabel;
  StringGridSigmaThreshold: TStringGrid;
  StringGridYields: TStringGrid;
  RadioGroupSpectr: TRadioGroup;
  RadioButtonThermalSpectr: TRadioButton;
  RadioButtonFissionSpectr: TRadioButton;
  Label3: TLabel;
  LabelKG: TLabel;
  Label5: TLabel;
  EditG_factor: TEdit;
  SpeedButtonElectron: TSpeedButton;
  SpeedButtonPositron: TSpeedButton;
  ComboBoxTimeUnit: TComboBox;
  ComboBoxTimeUnitRO: TComboBox;
  LabelThreshold: TLabel;
  StringGridGammas: TStringGrid;
  SpeedButtonChain: TSpeedButton;
  procedure FormCreate(Sender: TObject);
  procedure SpeedButtonCommonPanelClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
  procedure SpeedButtonGstateClick(Sender: TObject);
  procedure EditAbundanceExit(Sender: TObject);
  procedure EditT1_2Exit(Sender: TObject);
  procedure EditCaptureToGExit(Sender: TObject);
  procedure EditCaptureToM1Exit(Sender: TObject);
  procedure EditCaptureToM2Exit(Sender: TObject);
  procedure EditRItoGExit(Sender: TObject);
  procedure EditRItoM1Exit(Sender: TObject);
  procedure EditRItoM2Exit(Sender: TObject);
  procedure SpeedButtonDeleteStateClick(Sender: TObject);
  procedure SpeedButtonM1StateClick(Sender: TObject);
  procedure SpeedButtonM2StateClick(Sender: TObject);
  procedure SpeedButtonPlusStateClick(Sender: TObject);
  procedure ScrollBoxCommonEnter(Sender: TObject);
  procedure RxDrawGridDecaysDrawCell(Sender: TObject; ACol,
   ARow: Integer; Rect: TRect; State: TGridDrawState);
  procedure RxDrawGridDecaysGetEditStyle(Sender: TObject; ACol,
   ARow: Integer; var Style: TInplaceEditStyle);
  procedure RxDrawGridDecaysGetPicklist(Sender: TObject; ACol,
   ARow: Integer; PickList: TStrings);
  procedure RxDrawGridDecaysSetEditText(Sender: TObject; ACol,
   ARow: Integer; const Value: string);
  procedure RxDrawGridDecaysKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
  procedure SpeedButtonSaveToDBClick(Sender: TObject);
  procedure SpeedButtonToNuclideListClick(Sender: TObject);
  procedure FormClose(Sender: TObject; var Action: TCloseAction);
  procedure ComboBoxTimeUnitChange(Sender: TObject);
  procedure StringGridGammasKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
  procedure StringGridGammasSetEditText(Sender: TObject; ACol,
   ARow: Integer; const Value: string);
  procedure SpeedButtonGammaClick(Sender: TObject);
  procedure FormResize(Sender: TObject);
  procedure SpeedButtonAlphaClick(Sender: TObject);
  procedure SpeedButtonBetaClick(Sender: TObject);
  procedure ComboBoxTimeUnitROChange(Sender: TObject);
  procedure SpeedButtonCopyStateClick(Sender: TObject);
  procedure SpeedButtonPasteStateClick(Sender: TObject);
  procedure SpeedButtonCaptureClick(Sender: TObject);
  procedure SpeedButtonFissionClick(Sender: TObject);
  procedure EditSigmaFExit(Sender: TObject);
  procedure EditRIfExit(Sender: TObject);
  procedure PanelCaptureResize(Sender: TObject);
  procedure SpeedButtonDecayCountClick(Sender: TObject);
  procedure LabelLinesDblClick(Sender: TObject);
  procedure StringGridSigmaThresholdSetEditText(Sender: TObject; ACol,
   ARow: Integer; const Value: string);
  procedure PanelFissionResize(Sender: TObject);
  procedure ScrollBoxStateResize(Sender: TObject);
  procedure RadioButtonThermalSpectrClick(Sender: TObject);
  procedure RadioButtonFissionSpectrClick(Sender: TObject);
  procedure FormDestroy(Sender: TObject);
  procedure PanelToolResize(Sender: TObject);
  procedure Splitter1Moved(Sender: TObject);
  procedure EditG_factorExit(Sender: TObject);
  procedure SpeedButtonElectronClick(Sender: TObject);
  procedure SpeedButtonPositronClick(Sender: TObject);
  procedure FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
  procedure StringGridGammasDblClick(Sender: TObject);
  procedure SpeedButtonChainClick(Sender: TObject);
 private
    { Private declarations }
  fLinkedNuclideList: TNuclideList;
  fNuclide: TNuclide;
  fAttachedState: TNuclideState;
  fStaticEmptyNuclide: TNuclide;
//  fT1_2UnitList: TStringList;
  fNuclideEdited: Boolean;
  fCol0, fCol1, fCol2: TStringList;
  fDecayModeList: TStringList;
  fNuclideImage: TMetafile;
  fOrderGammaDesc: Boolean;
  procedure StringGridOrder(aStringGrid: TStringGrid; aCol: integer = 0; const Desc: Boolean = True; const CompareFloat: Boolean = True);
  procedure PrepareGammasGrid;
  procedure CreateDecayComponents;
  procedure CreateGammaComponents;
  procedure CreateYieldComponents;
  function GetNuclide: TNuclide;
  procedure SetNuclide(aNuclide: TNuclide);
  function GetNuclideEdited: Boolean;
  procedure SetNuclideEdited(aNuclideEdited: Boolean);
  function GetAttachedState: TNuclideState;
  procedure SetAttachedState(aNuclideState: TNuclideState);
  procedure AnyEditKeyDown(Sender: TObject;
   var Key: Word; Shift: TShiftState);
 public
    { Public declarations }
  KarteInfo: TKarteInfo;
  InitAMass: integer;
  InitZnum: integer;
  InitThZpA: integer;
//  NuclideImage: TMetafile;
  NuclideAttached: Boolean;
  procedure RepaintImage;
  procedure InvalidateForm;
  procedure InvalidateStatePanel;
  property
   LinkedNuclideList: TNuclideList read fLinkedNuclideList write fLinkedNuclideList;
  property
   StaticEmptyNuclide: TNuclide read fStaticEmptyNuclide;
  property
   Nuclide: TNuclide read GetNuclide write SetNuclide;
  property
   NuclideEdited: Boolean read GetNuclideEdited write SetNuclideEdited;
  property
   AttachedState: TNuclideState read GetAttachedState write SetAttachedState;
 end;
 
var
 _FormEditNuclide: T_FormEditNuclide;
 
implementation

uses UnitLegend, UnitDM_DAO, UnitDM_OOB, UnitNK, UnitDecay, Math, ChainClasses,
 UnitChainNKE;

{$R *.DFM}

var
 BufState: TNuclideState;
 
function TextFormat(const aFloat: Float): string;
begin
 Result:= Trim(Format('%-7.5g', [aFloat]));
end;

function T_FormEditNuclide.GetNuclideEdited: Boolean;
begin
 Result:= fNuclideEdited;
(*
 if NuclideAttached then
  Result:=Result or fNuclide.Modified;
*)
end;

procedure T_FormEditNuclide.SetNuclideEdited(aNuclideEdited: Boolean);
begin
 fNuclideEdited:= aNuclideEdited;
 if NuclideAttached then
  with fNuclide do
   if aNuclideEdited then
   begin
    Modified:= True;
    SpeedButtonSaveToDB.Enabled:= True;
    SpeedButtonToNuclideList.Enabled:= True;
   end
   else
   begin
    if Modified then
     SpeedButtonSaveToDB.Enabled:= True;
    SpeedButtonToNuclideList.Enabled:= False;
   end;
end;

function T_FormEditNuclide.GetNuclide: TNuclide;
begin
 if NuclideAttached then
  Result:= fNuclide
 else
 begin
//  MessageDlg('Attached nuclide does NOT exist.', mtWarning, [mbOK], 0);
  Result:= StaticEmptyNuclide;
 end;
end;

procedure T_FormEditNuclide.SetNuclide(aNuclide: TNuclide);
var
 I: integer;
 aStr: string;
 NewNuclide: TNuclide;
 ZnumAmass: TPoint;
 ModalResult: TModalResult;
begin
 if (_FormNK.TheDataModule is T_DataModuleDAO) then
 begin
  if NuclideAttached then
   if NuclideEdited then
   begin
{$IFDEF RELEASE}
    ModalResult:= mrNo;
{$ELSE}
    ModalResult:= MessageDlg('Nuclide ' + fNuclide.Symbol + '-' + IntToStr(fNuclide.Amass) + ' was edited. Do you want to save the cnanges?', mtWarning, [mbYes, mbNo], 0);
{$ENDIF}
    with fNuclide do
    begin //save
     if (ModalResult = mrYes) then
     begin
      I:= LinkedNuclideList.FindInList(Znum, Amass);
      if I >= 0 then
      begin
       with ZnumAmass do
       begin
        X:= Znum;
        Y:= Amass;
       end;
       ZnumAmass:= _FormNK.ZnumAmassToColRow(ZnumAmass);
       _FormNK.StringGridNK.Objects[ZnumAmass.X, ZnumAmass.Y].Free;
       _FormNK.StringGridNK.Objects[ZnumAmass.X, ZnumAmass.Y]:= nil;
       LinkedNuclideList[I].Assign(fNuclide);
      end
      else
      begin
       NewNuclide:= TNuclide.Create(0);
       NewNuclide.Assign(fNuclide);
       LinkedNuclideList.Add(NewNuclide);
      end;
     end;
    end;
   end
   else
   begin //not edited but details readed
    with fNuclide do //save with details
     I:= LinkedNuclideList.FindInList(Znum, Amass);
    if I >= 0 then
     LinkedNuclideList[I].Assign(fNuclide);
   end;
  with fNuclide do
  begin //load
   Assign(aNuclide);
   NuclideAttached:= True;
   if ((NuclideTag and nloRI) = 0) then
   begin
    LoadFromDB(T_DataModuleDAO(_FormNK.TheDataModule), nloRI);
    if not (Modified) then
     for I:= 0 to (StateList.Count - 1) do
      if StateList[I].RIs.Count > 0 then
       Modified:= True;
   end;
   if ((NuclideTag and nloFission) = 0) then
   begin
    LoadFromDB(T_DataModuleDAO(_FormNK.TheDataModule), nloFission);
   end;
   if ((NuclideTag and nloAlpha) = 0) then
   begin
    LoadFromDB(T_DataModuleDAO(_FormNK.TheDataModule), nloAlpha);
   end;
   if ((NuclideTag and nloBeta) = 0) then
   begin
    LoadFromDB(T_DataModuleDAO(_FormNK.TheDataModule), nloBeta);
   end;
   if ((NuclideTag and nloGamma) = 0) then
   begin
    LoadFromDB(T_DataModuleDAO(_FormNK.TheDataModule), nloGamma);
   end;
   if (InitZnum <> InitThZpA div 1000) then
    if (T_DataModuleDAO(_FormNK.TheDataModule).GetSymbol(aStr, InitZnum)) then
    begin
     Znum:= InitZnum;
     Symbol:= aStr;
     Modified:= True;
//    NuclideEdited:=False;
    end;
   if (InitAmass <> InitThZpA mod 1000) then
   begin
    Amass:= InitAmass;
    Modified:= True;
    NuclideEdited:= False;
   end;
   if StateList.Count < 1 then
    StateList.Add(TNuclideState.Create(fNuclide));
   fAttachedState:= StateList[0];
   NuclideAttached:= True;
   InvalidateForm;
   SpeedButtonToNuclideList.Enabled:= False;
  end;
  NuclideEdited:= False;
 end
 else if (_FormNK.TheDataModule is T_DataModuleOOB) then
 begin
// TODO
  if NuclideAttached then
   if NuclideEdited then
   begin
{$IFDEF RELEASE}
    ModalResult:= mrNo;
{$ELSE}
    ModalResult:= MessageDlg('Nuclide ' + fNuclide.Symbol + '-' + IntToStr(fNuclide.Amass) + ' was edited. Do you want to save the cnanges?', mtWarning, [mbYes, mbNo], 0);
{$ENDIF}
    with fNuclide do
    begin //save
     if (ModalResult = mrYes) then
     begin
      I:= LinkedNuclideList.FindInList(Znum, Amass);
      if I >= 0 then
      begin
       with ZnumAmass do
       begin
        X:= Znum;
        Y:= Amass;
       end;
       ZnumAmass:= _FormNK.ZnumAmassToColRow(ZnumAmass);
       _FormNK.StringGridNK.Objects[ZnumAmass.X, ZnumAmass.Y].Free;
       _FormNK.StringGridNK.Objects[ZnumAmass.X, ZnumAmass.Y]:= nil;
       LinkedNuclideList[I].Assign(fNuclide);
      end
      else
      begin
       NewNuclide:= TNuclide.Create(0);
       NewNuclide.Assign(fNuclide);
       LinkedNuclideList.Add(NewNuclide);
      end;
     end;
    end;
   end
   else
   begin //not edited but details readed
    with fNuclide do //save with details
     I:= LinkedNuclideList.FindInList(Znum, Amass);
    if I >= 0 then
     LinkedNuclideList[I].Assign(fNuclide);
   end;
  with fNuclide do
  begin //load
   Assign(aNuclide);
   NuclideAttached:= True;
   Modified:= False;
//   Modified:= True; // was ???
(*
   if ((NuclideTag and nloRI)=0) then begin
    LoadFromDB(T_DataModuleDAO(_FormNK.TheDataModule), nloRI);
    if not(Modified) then
     for I:= 0 to(StateList.Count-1) do
      if StateList[I].RIs.Count>0 then
       Modified:= True;
   end;
   if ((NuclideTag and nloFission)=0) then begin
    LoadFromDB(T_DataModuleDAO(_FormNK.TheDataModule), nloFission);
   end;
   if ((NuclideTag and nloAlpha)=0) then begin
    LoadFromDB(T_DataModuleDAO(_FormNK.TheDataModule), nloAlpha);
   end;
   if ((NuclideTag and nloBeta)=0) then begin
    LoadFromDB(T_DataModuleDAO(_FormNK.TheDataModule), nloBeta);
   end;
   if ((NuclideTag and nloGamma)=0) then begin
    LoadFromDB(T_DataModuleDAO(_FormNK.TheDataModule), nloGamma);
   end;
*)
   if (InitZnum <> InitThZpA div 1000) then
    if (T_DataModuleDAO(_FormNK.TheDataModule).GetSymbol(aStr, InitZnum)) then
    begin
     Znum:= InitZnum;
     Symbol:= aStr;
     Modified:= True;
//    NuclideEdited:=False;
    end;
   if (InitAmass <> InitThZpA mod 1000) then
   begin
    Amass:= InitAmass;
    Modified:= True;
    NuclideEdited:= False;
   end;
   if StateList.Count < 1 then
    StateList.Add(TNuclideState.Create(fNuclide));
   fAttachedState:= StateList[0];
   NuclideAttached:= True;
   InvalidateForm;
   SpeedButtonToNuclideList.Enabled:= False;
  end;
  NuclideEdited:= False;
 end;
end;

function T_FormEditNuclide.GetAttachedState: TNuclideState;
begin
 Result:= fAttachedState;
end;

procedure T_FormEditNuclide.SetAttachedState(aNuclideState: TNuclideState);
begin
 fAttachedState:= aNuclideState;
 SpeedButtonGammaClick(Self);
 ScrollBoxState.Visible:= True;
 InvalidateForm;
end;

procedure T_FormEditNuclide.CreateDecayComponents;
begin
 if fAttachedState = nil then
  Exit
 else
  with fAttachedState, RxDrawGridDecays do
  begin
   RowCount:= Decays.Count + 1;
   Repaint;
  end;
end;

procedure T_FormEditNuclide.CreateYieldComponents;
var
 aNuclide: TNuclide;
 I, TheStateNo: integer;
 J: integer;
begin
// if (_FormNK.TheDataModule is T_DataModuleDAO) then begin
 fCol0.Clear;
 fCol1.Clear;
 fCol2.Clear;
 try
  if fAttachedState = nil then
   exit;
(* //qq
   if not(NuclideAttached) then begin
    if (AttachedState is TChainState) then
     aNuclide:= TNuclide.Create(TChainState(fAttachedState).ThZpA)
    else
     aNuclide:= TNuclide.Create(0);
    if (_FormNK.TheDataModule is T_DataModuleDAO) then
     aNuclide.LoadFromDB(T_DataModuleDAO(_FormNK.TheDataModule), nloBasic or nloYield);
   end
   else
*)
  begin
   aNuclide:= TNuclide.Create(fAttachedState.Nuclide.Znum * 1000 + fAttachedState.Nuclide.Amass);
   if ((fNuclide.NuclideTag and nloYield) <> nloYield) then
    if (_FormNK.TheDataModule is T_DataModuleDAO) then
     fNuclide.LoadFromDB(T_DataModuleDAO(_FormNK.TheDataModule), nloYield)
    else
     fNuclide.Assign(fAttachedState.Nuclide);
   aNuclide.Assign(fNuclide);
  end;
  TheStateNo:= fAttachedState.State;
  if (TheStateNo < aNuclide.StateList.Count) then
  begin
   fAttachedState.Yields.Clear;
   for I:= 0 to aNuclide.StateList[TheStateNo].Yields.Count - 1 do
    fAttachedState.Yields.Add(aNuclide.StateList[TheStateNo].Yields[I]);
   aNuclide.Free;
  end;
  fCol0.Add('Parent');
  fCol1.Add(' Cum.');
  fCol2.Add(' Ind.');
  if fAttachedState.Yields.Count > 0 then
  begin
   for I:= 0 to fAttachedState.Yields.Count - 1 do
    with fAttachedState.Yields[I] do
     if (RadioButtonThermalSpectr.Checked) then
     begin
      fCol0.Add(ThZpAtoNuclideName(ParentThZpA));
      fCol1.Add(TextFormat(CumYieldT));
      fCol2.Add(TextFormat(IndYieldT));
     end
     else
     begin
      fCol0.Add(ThZpAtoNuclideName(ParentThZpA));
      fCol1.Add(TextFormat(CumYieldF));
      fCol2.Add(TextFormat(IndYieldF));
     end;
  end;
// Sort on Col1 and Col2 on the basic of Col0 values Order
  for J:= 2 to fCol0.Count - 1 do
  begin
   I:= J;
   while (fCol0[I] < fCol0[I - 1]) do
   begin
    fCol0.Exchange(I, I - 1);
    fCol1.Exchange(I, I - 1);
    fCol2.Exchange(I, I - 1);
    if I = 2 then break;
    Dec(I);
   end;
  end;
  with StringGridYields do
  begin
   RowCount:= fCol0.Count;
   Cols[0].Assign(fCol0);
   Cols[1].Assign(fCol1);
   Cols[2].Assign(fCol2);
   if (RowCount = 1) then
   begin
    RowCount:= 2;
    Cells[0, 1]:= '--';
    Cells[1, 1]:= '--';
    Cells[2, 1]:= '--';
   end;
   FixedRows:= 1
  end;
 finally
//
 end;
// end;
end;

procedure T_FormEditNuclide.CreateGammaComponents;
begin
 if fAttachedState = nil then
  Exit
 else
  with StringGridGammas do
  begin
   if SpeedButtonGamma.Down then
   begin
    if (fAttachedState.Gammas.Count > 0) then
     if fAttachedState.Gammas[0].Probability >= 0 then
      with LabelKG do
      begin
       Caption:= 'Kg=' + TextFormat(fAttachedState.Gammas.Kgamma);
       Hint:= 'Rh°cm^2/(hour°mCi)';
       ShowHint:= True;
      end
     else
      with LabelKG do
      begin
       Caption:= '';
       Hint:= '';
       ShowHint:= False;
      end
    else
     LabelKG.Caption:= '';
    ColCount:= 2;
    RowCount:= fAttachedState.Gammas.Count + 2;
    ColWidths[0]:= (ClientWidth div ColCount) - ColCount;
    ColWidths[1]:= (ClientWidth div ColCount) - ColCount;
   end
   else if SpeedButtonAlpha.Down then
   begin
    LabelKG.Caption:= '';
    ColCount:= 2;
    RowCount:= fAttachedState.Alphas.Count + 2;
    ColWidths[0]:= (ClientWidth div ColCount) - ColCount;
    ColWidths[1]:= (ClientWidth div ColCount) - ColCount;
   end
   else if SpeedButtonBeta.Down then
   begin
    LabelKG.Caption:= '';
    ColCount:= 3;
    RowCount:= fAttachedState.Betas.Count + 2;
    ColWidths[0]:= (ClientWidth div ColCount) - ColCount;
    ColWidths[1]:= (ClientWidth div ColCount) - ColCount;
    if ColCount > 2 then
     ColWidths[2]:= (ClientWidth div ColCount) - ColCount;
   end
   else if SpeedButtonElectron.Down then
   begin
    LabelKG.Caption:= '';
    ColCount:= 2;
    RowCount:= fAttachedState.Electrons.Count + 2;
    ColWidths[0]:= (ClientWidth div ColCount) - ColCount;
    ColWidths[1]:= (ClientWidth div ColCount) - ColCount;
   end
   else if SpeedButtonPositron.Down then
   begin
    LabelKG.Caption:= '';
    ColCount:= 3;
    RowCount:= fAttachedState.Positrons.Count + 2;
    ColWidths[0]:= (ClientWidth div ColCount) - ColCount;
    ColWidths[1]:= (ClientWidth div ColCount) - ColCount;
    if ColCount > 2 then
     ColWidths[2]:= (ClientWidth div ColCount) - ColCount;
   end;
   PrepareGammasGrid;
   Repaint;
  end;
end;

procedure T_FormEditNuclide.InvalidateStatePanel;
var
 I: integer;
 aFloat: Float;
begin
 if fAttachedState = nil then
  Exit
 else
  with fAttachedState do
   if (T1_2 > 0) then
   begin
    if IsStable then
    begin
     StringGridGammas.Visible:= False;
     LabelKG.Visible:= False;
     LabelLines.Visible:= False;
     RxDrawGridDecays.Visible:= False;
     LabelDecays.Visible:= False;
     EditT1_2.Text:= 'STABLE';
     EditT1_2RO.Text:= 'STABLE';
     SpeedButtonDecayCount.Enabled:= False;
     SpeedButtonChain.Enabled:= False;
    end
    else
    begin
     LabelDecays.Visible:= True;
     LabelKG.Visible:= True;
     RxDrawGridDecays.Visible:= True;
     LabelLines.Caption:= 'Lines';
     LabelLines.Visible:= True;
     StringGridGammas.Visible:= True;
     SpeedButtonDecayCount.Enabled:= True;
     SpeedButtonChain.Enabled:= True;
     EditT1_2.Text:= TextFormat(T1_2);
     EditT1_2RO.Text:= TextFormat(T1_2);
    end;
    if SpeedButtonGamma.Down then
     for I:= 0 to Gammas.Count - 1 do
      if Gammas[I].Probability < 0 then
      begin
       LabelKG.Caption:= ' ';
       LabelLines.Caption:= 'NO GAMMA';
{$IFDEF RELEASE}
       StringGridGammas.Visible:= False;
{$ENDIF}
      end;
    if NuclideAttached then
    begin
     Caption:= Name;
{$IFDEF RELEASE}
     SpeedButtonDeleteState.Visible:= False;
{$ELSE}
     if ((State > 0) and (State = fNuclide.StateList.Count - 1)) then
      SpeedButtonDeleteState.Visible:= True
     else
      SpeedButtonDeleteState.Visible:= False;
{$ENDIF}
    end
    else
     Caption:= TChainState(fAttachedState).Name;
    ComboBoxTimeUnit.ItemIndex:= 0;
    ComboBoxTimeUnitROChange(Self);
    EditCaptureToG.Text:= '';
    EditCaptureToM1.Text:= '';
    EditCaptureToM2.Text:= '';
    EditG_factor.Text:= '';
    if SigmaF > 0 then
     EditSigmaF.Text:= TextFormat(SigmaF)
    else
     EditSigmaF.Text:= '';
    if RIf > 0 then
     EditRIf.Text:= TextFormat(RIf)
    else
     EditRIf.Text:= '';
{$IFDEF RELEASE}
    if Captures.G_factor > 0 then //qqqq
{$ELSE}
{$ENDIF}
    EditG_factor.Text:= TextFormat(Captures.G_factor);
    for I:= 0 to (Captures.Count - 1) do
     with Captures[I] do
      if Sigma > 0 then
      begin
       case ToState of
        0: EditCaptureToG.Text:= TextFormat(Sigma);
        1: EditCaptureToM1.Text:= TextFormat(Sigma);
        2: EditCaptureToM2.Text:= TextFormat(Sigma);
        else
         MessageDlg('Neutron capture to unknown state was found!!!', mtWarning, [mbOK], 0);
       end;
      end;
    EditRIToG.Text:= '';
    EditRIToM1.Text:= '';
    EditRIToM2.Text:= '';
    for I:= 0 to (RIs.Count - 1) do
     with RIs[I] do
      if Value > 0 then
      begin
       case ToState of
        0: EditRIToG.Text:= TextFormat(Value);
        1: EditRIToM1.Text:= TextFormat(Value);
        2: EditRIToM2.Text:= TextFormat(Value);
        else
         MessageDlg('Resonance capture to unknown state was found!!!', mtWarning, [mbOK], 0);
       end;
      end;
{$IFDEF RELEASE}
    with StringGridSigmaThreshold do
    begin
     if SigmaNP > 0 then
      Cells[1, 1]:= TextFormat(SigmaNP)
     else
      Cells[1, 1]:= '';
     if SigmaNA > 0 then
      Cells[1, 2]:= TextFormat(SigmaNA)
     else
      Cells[1, 2]:= '';
     if SigmaN2N > 0 then
      Cells[1, 3]:= TextFormat(SigmaN2N)
     else
      Cells[1, 3]:= '';
     if SigmaNN > 0 then
      Cells[1, 4]:= TextFormat(SigmaNN)
     else
      Cells[1, 4]:= '';
     if SigmaNG > 0 then
      Cells[1, 5]:= TextFormat(SigmaNG)
     else
      Cells[1, 5]:= '';
(* //g-factor -was, now near SigmaC
    if g_factor>0 then
     Cells[1, 6]:= TextFormat(g_factor)
    else
     Cells[1, 6]:= '';
*)
     Cells[1, 6]:= '';
     try
      I:= 10 * (1000 * fAttachedState.Nuclide.Znum + fAttachedState.Nuclide.Amass) + fAttachedState.State;
      if (I > 880000) then
       if (_FormNK.TheDataModule is T_DataModuleOOB) then
       begin
        if (T_DataModuleOOB(_FormNK.TheDataModule).VFastFissions.Count <= 1) then
         T_DataModuleOOB(_FormNK.TheDataModule).LoadFastFissions;
        aFloat:= T_DataModuleOOB(_FormNK.TheDataModule).GetSigmaFastFissionForThZpA_s(I);
        if (aFloat > 0) then
        begin
//       StringGridSigmaThreshold.RowCount:= 7;
         Cells[1, 6]:= TextFormat(aFloat);
        end;
       end;
     except
    // qq
     end;
    end;
{$ELSE}
    with StringGridSigmaThreshold do
    begin
     Cells[1, 1]:= TextFormat(SigmaNP);
     Cells[1, 2]:= TextFormat(SigmaNA);
     Cells[1, 3]:= TextFormat(SigmaN2N);
     Cells[1, 4]:= TextFormat(SigmaNN);
     Cells[1, 5]:= TextFormat(SigmaNG);
     try // QQQQ not tested
      I:= 10 * (1000 * fAttachedState.Nuclide.Znum + fAttachedState.Nuclide.Amass) + fAttachedState.State;
      if (I > 880000) then
       if (_FormNK.TheDataModule is T_DataModuleOOB) then
       begin
        if (T_DataModuleOOB(_FormNK.TheDataModule).VFastFissions.Count <= 1) then
         T_DataModuleOOB(_FormNK.TheDataModule).LoadFastFissions;
        aFloat:= T_DataModuleOOB(_FormNK.TheDataModule).GetSigmaFastFissionForThZpA_s(I);
//       StringGridSigmaThreshold.RowCount:= 7;
        Cells[1, 6]:= TextFormat(aFloat);
       end;
     except
    // qq
     end;
// g-factor -was here, now is near SigmaC
//    Cells[1, 6]:= TextFormat(g_factor);
    end;
{$ENDIF}
    CreateDecayComponents;
    CreateGammaComponents;
    CreateYieldComponents;
    if SpeedButtonAlpha.Down or SpeedButtonBeta.Down or SpeedButtonGamma.Down or SpeedButtonElectron.Down or SpeedButtonPositron.Down then
    begin
     PanelFission.Visible:= False;
     PanelCapture.Visible:= False;
     PanelDecay.Visible:= True;
    end
    else if SpeedButtonCapture.Down then
    begin
     PanelFission.Visible:= False;
     PanelDecay.Visible:= False;
     PanelCapture.Visible:= True;
    end
    else if SpeedButtonFission.Down then
    begin
     PanelDecay.Visible:= False;
     PanelCapture.Visible:= False;
     PanelFission.Visible:= True;
    end;
    if SpeedButtonCommonPanel.Down then
     if NuclideAttached then
      with fNuclide do
       Caption:= Symbol + '-' + IntToStr(Amass);
   end; //State<>nil
 if SpeedButtonCommonPanel.Down then
 begin
  SpeedButtonDecayCount.Enabled:= False;
  SpeedButtonChain.Enabled:= False;
 end;
end;

procedure T_FormEditNuclide.InvalidateForm;
var
 ProductStateCount, ProductStateMax, ProductStateMin: integer;
begin
 if NuclideAttached then
 begin
  PanelTool.Visible:= True;
  with fNuclide do
  begin
   Caption:= Symbol + IntToStr(Amass);
   LabelAmass.Caption:= IntToStr(Amass);
   LabelSymbol.Caption:= Symbol;
   SpeedButtonPlusState.Visible:= False;
   case StateList.Count of
    1:
     begin
      SpeedButtonM1State.Visible:= False;
      SpeedButtonM2State.Visible:= False;
      SpeedButtonPlusState.Left:= SpeedButtonM1State.Left;
{$IFDEF RELEASE}
{$ELSE}
      SpeedButtonPlusState.Visible:= True;
{$ENDIF}
     end;
    2:
     begin
      SpeedButtonM1State.Visible:= True;
      SpeedButtonM2State.Visible:= False;
      SpeedButtonPlusState.Left:= SpeedButtonM2State.Left;
{$IFDEF RELEASE}
{$ELSE}
      SpeedButtonPlusState.Visible:= True;
{$ENDIF}
     end;
    3:
     begin
      SpeedButtonM1State.Visible:= True;
      SpeedButtonM2State.Visible:= True;
      SpeedButtonPlusState.Visible:= False;
     end;
   end;
   if ScrollBoxCommon.Visible then
    SpeedButtonCommonPanel.Down:= True
   else if ((fAttachedState <> nil) and (ScrollBoxState.Visible)) then
    case fAttachedState.State of
     0: SpeedButtonGstate.Down:= True;
     1: SpeedButtonM1state.Down:= True;
     2: SpeedButtonM2state.Down:= True;
    end;
   if Abundance > 0 then
    EditAbundance.Text:= TextFormat(Abundance)
   else
    EditAbundance.Text:= '';
   EditCaptureToG.Color:= clBtnFace;
   EditRIToG.Color:= clBtnFace;
   EditCaptureToM1.Color:= clBtnFace;
   EditRIToM1.Color:= clBtnFace;
   EditCaptureToM2.Color:= clBtnFace;
   EditRIToM2.Color:= clBtnFace;
   if (_FormNK.TheDataModule is T_DataModuleDAO) then
    GetCaptureProductStateInfo(T_DataModuleDAO(_FormNK.TheDataModule), ProductStateCount, ProductStateMax, ProductStateMin)
   else if (_FormNK.TheDataModule is T_DataModuleOOB) then
    GetCaptureProductStateInfo(T_DataModuleOOB(_FormNK.TheDataModule), ProductStateCount, ProductStateMax, ProductStateMin);
   case ProductStateCount of
    1, 2:
     begin
      case ProductStateMin of
       0:
        begin
         EditCaptureToG.Color:= clWindow;
         EditRIToG.Color:= clWindow;
        end;
       1:
        begin
         EditCaptureToM1.Color:= clWindow;
         EditRIToM1.Color:= clWindow;
        end;
      end;
      case ProductStateMax of
       1:
        begin
         EditCaptureToM1.Color:= clWindow;
         EditRIToM1.Color:= clWindow;
        end;
       2:
        begin
         EditCaptureToM2.Color:= clWindow;
         EditRIToM2.Color:= clWindow;
        end;
      end;
     end;
    3:
     begin
      EditCaptureToG.Color:= clWindow;
      EditRIToG.Color:= clWindow;
      EditCaptureToM1.Color:= clWindow;
      EditRIToM1.Color:= clWindow;
      EditCaptureToM2.Color:= clWindow;
      EditRIToM2.Color:= clWindow;
     end;
    else
     begin
      EditCaptureToG.Color:= clBtnFace;
      EditRIToG.Color:= clBtnFace;
      EditCaptureToM1.Color:= clBtnFace;
      EditRIToM1.Color:= clBtnFace;
      EditCaptureToM2.Color:= clBtnFace;
      EditRIToM2.Color:= clBtnFace;
     end;
   end;
   SpeedButtonSaveToDB.Enabled:= Modified;
   SpeedButtonToNuclideList.Enabled:= Modified;
  end;
  RepaintImage;
  if SpeedButtonCommonPanel.Down then
   if NuclideAttached then
    with fNuclide do
     Caption:= Symbol + '-' + IntToStr(Amass);
 end // if fNuclideAssigned
 else
 begin
(*
  PanelTool.Visible:= False;
  ScrollBoxCommon.Visible:= False;
  if (fAttachedState is TChainState) then begin
   EditCaptureToG.Color:= clBtnFace;
   EditRIToG.Color:= clBtnFace;
   EditCaptureToM1.Color:= clBtnFace;
   EditRIToM1.Color:= clBtnFace;
   EditCaptureToM2.Color:= clBtnFace;
   EditRIToM2.Color:= clBtnFace;
   if (TChainState(fAttachedState).Chain.StateList.FindInList(TChainState(fAttachedState).ThZpA+1, 0)>0) then begin
    EditCaptureToG.Color:= clWhite;
    EditRIToG.Color:= clWhite;
   end;
   if (TChainState(fAttachedState).Chain.StateList.FindInList(TChainState(fAttachedState).ThZpA+1, 1)>0) then begin
    EditCaptureToM1.Color:= clWhite;
    EditRIToM1.Color:= clWhite;
   end;
   if (TChainState(fAttachedState).Chain.StateList.FindInList(TChainState(fAttachedState).ThZpA+1, 2)>0) then begin
    EditCaptureToM2.Color:= clWhite;
    EditRIToM2.Color:= clWhite;
   end;
  end
*)
 end;
 InvalidateStatePanel;
end;

procedure T_FormEditNuclide.FormCreate(Sender: TObject);
var
 I: integer;
begin
{$IFDEF RELEASE}
 with StringGridGammas do
  Options:= Options - [goEditing];
 with StringGridSigmaThreshold do
  Options:= Options - [goEditing];
 with EditSigmaF do
  ReadOnly:= True;
 with EditRIf do
  ReadOnly:= True;
{$ELSE}
{$ENDIF}
 Height:= 450;
 fCol0:= TStringList.Create;
 fCol1:= TStringList.Create;
 fCol2:= TStringList.Create;
 with StringGridSigmaThreshold do
 begin
//g-factor -near SigmaC
  RowCount:= 7;
//  RowCount:= 6;
  Cells[0, 0]:= 'Reaction';
  Cells[1, 0]:= 'Xsec(barn)';
  Cells[0, 1]:= ' (n, p)';
  Cells[0, 2]:= ' (n, alpha)';
  Cells[0, 3]:= ' (n, 2n)';
  Cells[0, 4]:= ' (n, n'')';
  Cells[0, 5]:= ' (n, g*)';
  Cells[0, 6]:= ' (n, f)';
//g-factor -near SigmaC
//  Cells[0, 6]:= ' g-factor';
 end;
 fLinkedNuclideList:= nil;
 Left:= 24;
 Top:= 1;
 fStaticEmptyNuclide:= TNuclide.Create(0);
 fStaticEmptyNuclide.NuclideTag:= $00FF;
 fStaticEmptyNuclide.Modified:= False;
 fDecayModeList:= TStringList.Create;
 if (_FormNK.TheDataModule is T_DataModuleDAO) then
 begin
  if not (T_DataModuleDAO(_FormNK.TheDataModule).ReadDecayModeList(fDecayModeList)) then
   MessageDlg('Decays were not read !', mtWarning, [mbYes], 0);
 end
 else if (_FormNK.TheDataModule is T_DataModuleOOB) then
 begin
  if not (T_DataModuleOOB(_FormNK.TheDataModule).ReadDecayModeList(fDecayModeList)) then
   MessageDlg('Decays were not read !', mtWarning, [mbYes], 0);
 end;
 fNuclide:= TNuclide.Create(0);
 BufState:= TNuclideState.Create(fNuclide);
// fT1_2UnitList:= TStringList.Create;
 fNuclideImage:= TMetafile.Create;
 ScrollBoxCommon.Align:= alClient;
 ScrollBoxState.Align:= alClient;
 PanelDecay.Align:= alClient;
 PanelCapture.Align:= alClient;
 PanelFission.Align:= alClient;
 ComboBoxTimeUnitRO.ItemIndex:= 0;
 StringGridGammas.Top:= RxDrawGridDecays.Top + RxDrawGridDecays.Height + 3;
 for I:= 0 to ComponentCount - 1 do
  if (Components[I] is TEdit) then
   (Components[I] as TEdit).OnKeyDown:= AnyEditKeyDown;
end;

procedure T_FormEditNuclide.SpeedButtonCommonPanelClick(Sender: TObject);
begin
 if NuclideAttached then
  with fNuclide do
   Caption:= Symbol + '-' + IntToStr(Amass);
 ScrollBoxState.Visible:= False;
 RepaintImage;
 ScrollBoxCommon.Visible:= True;
 SpeedButtonDecayCount.Enabled:= False;
 SpeedButtonChain.Enabled:= False;
end;

procedure T_FormEditNuclide.FormShow(Sender: TObject);
begin
 if _FormLegend.Visible then
  with _FormLegend do
  begin
   Close;
   Free;
   _FormLegend:= T_FormLegend.Create(Self);
   _FormLegend.KarteInfo:= Self.KarteInfo;
   Show;
  end;
 InvalidateForm;
end;

procedure T_FormEditNuclide.RepaintImage;
begin
 fNuclideImage:= Nuclide.GetMetafile(KarteInfo);
 if (fNuclideImage <> nil) then
  Image1.Picture.Assign(fNuclideImage);
end;

procedure T_FormEditNuclide.SpeedButtonGstateClick(Sender: TObject);
begin
 fAttachedState:= fNuclide.StateList[0];
 InvalidateStatePanel;
 ScrollBoxCommon.Visible:= False;
 ScrollBoxState.Visible:= True;
end;

procedure T_FormEditNuclide.EditAbundanceExit(Sender: TObject);
var
 aFloat: Float;
begin
 if (Trim(EditAbundance.Text) <> '') then
  if not (ValEuSilent(EditAbundance.Text, aFloat)) then
  begin
   MessageDlg('Abudance conversion error !', mtWarning, [mbOK], 0);
//   ScrollBoxCommon.Show;
//   EditAbundance.SetFocus;
//   MessageBeep(0);
  end
  else if ((aFloat >= 0) and (aFloat <= 100)) then
  begin
   fNuclide.Abundance:= aFloat;
   NuclideEdited:= True;
   RepaintImage;
  end
  else
  begin
//    ScrollBoxCommon.Show;
//    EditAbundance.SetFocus;
   MessageDlg('Abudance is to be in 0...100 interval. ', mtWarning, [mbOK], 0);
//    MessageBeep(0);
  end;
end;

procedure T_FormEditNuclide.EditT1_2Exit(Sender: TObject);
var
 aFloat: Float;
 T1_2EditText: string;
 ComboEditTimeUnitItemNo: integer;
begin
 if (Trim(EditT1_2.Text) <> '') then
  with fAttachedState do
  begin
   if (Copy(Trim(ComboBoxTimeUnit.Items[ComboBoxTimeUnit.ItemIndex]), 1, 2) = 'ST') //then
    or (Copy(Trim(EditT1_2.Text), 1, 2) = 'ST') then
   begin
    T1_2:= 2E17;
    T1_2EditText:= EditT1_2.Text;
    ComboEditTimeUnitItemNo:= ComboBoxTimeUnit.ItemIndex;
    InvalidateStatePanel;
    EditT1_2.Text:= T1_2EditText;
    ComboBoxTimeUnit.ItemIndex:= ComboEditTimeUnitItemNo;
    EditT1_2RO.Text:= 'STABLE';
    SpeedButtonDecayCount.Enabled:= False;
    ComboBoxTimeUnitROChange(Self);
    if NuclideAttached then
     NuclideEdited:= True;
    Exit;
   end;
   if ValT1_2(EditT1_2.Text, Copy(Trim(ComboBoxTimeUnit.Items[ComboBoxTimeUnit.ItemIndex]), 1, 2), aFloat) then
   begin
    if (T1_2 <> aFloat) then
    begin
     T1_2:= aFloat;
     T1_2EditText:= EditT1_2.Text;
     ComboEditTimeUnitItemNo:= ComboBoxTimeUnit.ItemIndex;
     InvalidateStatePanel;
     EditT1_2.Text:= T1_2EditText;
     ComboBoxTimeUnit.ItemIndex:= ComboEditTimeUnitItemNo;
     if T1_2 > 0 then
      SpeedButtonDecayCount.Enabled:= True;
     EditT1_2RO.Text:= T1_2ToStr(aFloat, 5);
     ComboBoxTimeUnitROChange(Self);
     if NuclideAttached then
      NuclideEdited:= True;
    end;
   end
   else
   begin
    MessageDlg(' Cannot parse time.' + #13 + #10 + ' Correct the input data !', mtWarning, [mbOK], 0);
    ScrollBoxState.Show;
    EditT1_2.SetFocus;
//    MessageBeep(0);
   end;
  end;
end;

procedure T_FormEditNuclide.EditCaptureToGExit(Sender: TObject);
var
 aFloat: Float;
 aCapture: TCapture;
begin
 aCapture:= ZiroCaptureToG;
 with fAttachedState do
 begin
  if (Captures.Count = 0) then
   Captures.Add(ZiroCaptureToG);
  if Trim(EditCaptureToG.Text) <> '' then
   if ValEuSilent(EditCaptureToG.Text, aFloat) then
   begin
    if (Captures[0].Sigma <> aFloat) then
    begin
     aCapture.Sigma:= aFloat;
     Captures[0]:= aCapture;
     if NuclideAttached then
      NuclideEdited:= True;
    end;
   end
   else
   begin
    MessageDlg('Capture to G-state conversion error', mtWarning, [mbOK], 0);
    ScrollBoxState.Show;
    EditCaptureToG.SetFocus;
//    MessageBeep(0);
   end;
 end;
end;

procedure T_FormEditNuclide.EditCaptureToM1Exit(Sender: TObject);
var
 aFloat: Float;
 aCapture: TCapture;
begin
 aCapture:= ZiroCaptureToM1;
 with fAttachedState do
 begin
  if (Captures.Count = 0) then
   Captures.Add(ZiroCaptureToG);
  if (Captures.Count = 1) then
   Captures.Add(ZiroCaptureToM1);
  if Trim(EditCaptureToM1.Text) <> '' then
   if ValEuSilent(EditCaptureToM1.Text, aFloat) then
   begin
    if (Captures[1].Sigma <> aFloat) then
    begin
     aCapture.Sigma:= aFloat;
     Captures[1]:= aCapture;
     if NuclideAttached then
      NuclideEdited:= True;
    end;
   end
   else
   begin
    MessageDlg('Capture to M1-state conversion error', mtWarning, [mbOK], 0);
    ScrollBoxState.Show;
    EditCaptureToG.SetFocus;
//    MessageBeep(0);
   end;
 end;
end;

procedure T_FormEditNuclide.EditCaptureToM2Exit(Sender: TObject);
var
 aFloat: Float;
 aCapture: TCapture;
begin
 with fAttachedState do
 begin
  if (Captures.Count = 0) then
   Captures.Add(ZiroCaptureToG);
  if (Captures.Count = 1) then
   Captures.Add(ZiroCaptureToM1);
  if (Captures.Count = 2) then
   Captures.Add(ZiroCaptureToM2);
  aCapture:= ZiroCaptureToM2;
  if Trim(EditCaptureToM2.Text) <> '' then
   if ValEuSilent(EditCaptureToM2.Text, aFloat) then
   begin
    if (Captures[2].Sigma <> aFloat) then
    begin
     aCapture.Sigma:= aFloat;
     fAttachedState.Captures[2]:= aCapture;
     if NuclideAttached then
      NuclideEdited:= True;
    end;
   end
   else
   begin
    MessageDlg('Capture to M2-state conversion error', mtWarning, [mbOK], 0);
    ScrollBoxState.Show;
    EditCaptureToG.SetFocus;
//    MessageBeep(0);
   end;
 end;
end;

procedure T_FormEditNuclide.EditRItoGExit(Sender: TObject);
var
 aFloat: Float;
 aRI: TRI;
begin
 aRI:= ZiroRIToG;
 with fAttachedState do
 begin
  if (RIs.Count = 0) then
   RIs.Add(ZiroRIToG);
  if Trim(EditRIToG.Text) <> '' then
   if ValEuSilent(EditRIToG.Text, aFloat) then
   begin
    if (RIs[0].Value <> aFloat) then
    begin
     aRI.Value:= aFloat;
     RIs[0]:= aRI;
     if NuclideAttached then
      NuclideEdited:= True;
    end;
   end
   else
   begin
    MessageDlg('RI capture to G-state conversion error', mtWarning, [mbOK], 0);
    ScrollBoxState.Show;
    EditRIToG.SetFocus;
//    MessageBeep(0);
   end;
 end;
end;

procedure T_FormEditNuclide.EditRItoM1Exit(Sender: TObject);
var
 aFloat: Float;
 aRI: TRI;
begin
 aRI:= ZiroRIToM1;
 with fAttachedState do
 begin
  if (RIs.Count = 0) then
   RIs.Add(ZiroRIToG);
  if (RIs.Count = 1) then
   RIs.Add(ZiroRIToM1);
  if Trim(EditRIToM1.Text) <> '' then
   if ValEuSilent(EditRIToM1.Text, aFloat) then
   begin
    if (RIs[1].Value <> aFloat) then
    begin
     aRI.Value:= aFloat;
     RIs[1]:= aRI;
     if NuclideAttached then
      NuclideEdited:= True;
    end;
   end
   else
   begin
    MessageDlg('RI capture to M1-state conversion error', mtWarning, [mbOK], 0);
    ScrollBoxState.Show;
    EditRIToG.SetFocus;
//    MessageBeep(0);
   end;
 end;
end;

procedure T_FormEditNuclide.EditRItoM2Exit(Sender: TObject);
var
 aFloat: Float;
 aRI: TRI;
begin
 with fAttachedState do
 begin
  if (RIs.Count = 0) then
   RIs.Add(ZiroRIToG);
  if (RIs.Count = 1) then
   RIs.Add(ZiroRIToM1);
  if (RIs.Count = 2) then
   RIs.Add(ZiroRIToM2);
  aRI:= ZiroRIToM2;
  if Trim(EditRIToM2.Text) <> '' then
   if ValEuSilent(EditRIToM2.Text, aFloat) then
   begin
    if (RIs[2].Value <> aFloat) then
    begin
     aRI.Value:= aFloat;
     fAttachedState.RIs[2]:= aRI;
     if NuclideAttached then
      NuclideEdited:= True;
    end;
   end
   else
   begin
    MessageDlg('RI capture to M2-state conversion error', mtWarning, [mbOK], 0);
    ScrollBoxState.Show;
    EditRIToG.SetFocus;
//    MessageBeep(0);
   end;
 end;
end;

procedure T_FormEditNuclide.AnyEditKeyDown(Sender: TObject;
 var Key: Word; Shift: TShiftState);
begin
 case Key of
  VK_RETURN: if (Sender is TEdit) then
    (Sender as TEdit).OnExit(Self);

 end;
end;

procedure T_FormEditNuclide.SpeedButtonDeleteStateClick(Sender: TObject);
begin
 fNuclide.StateList.Remove(fAttachedState);
 if NuclideAttached then
  NuclideEdited:= True;
 fAttachedState.Free;
 fAttachedState:= fNuclide.StateList[0];
 InvalidateForm;
 SpeedButtonGstate.Down:= True;
end;

procedure T_FormEditNuclide.SpeedButtonM1StateClick(Sender: TObject);
begin
 fAttachedState:= fNuclide.StateList[1];
 InvalidateStatePanel;
 ScrollBoxCommon.Visible:= False;
 ScrollBoxState.Visible:= True;
end;

procedure T_FormEditNuclide.SpeedButtonM2StateClick(Sender: TObject);
begin
 fAttachedState:= fNuclide.StateList[2];
 InvalidateStatePanel;
 ScrollBoxCommon.Visible:= False;
 ScrollBoxState.Visible:= True;
end;

procedure T_FormEditNuclide.SpeedButtonPlusStateClick(Sender: TObject);
begin
 fAttachedState:= TNuclideState.Create(fNuclide);
 fNuclide.StateList.Add(fAttachedState);
 fAttachedState.State:= fNuclide.StateList.Count - 1;
 InvalidateForm;
{$IFDEF RELEASE}
{$ELSE}
 SpeedButtonDeleteState.Visible:= True
{$ENDIF}
end;

procedure T_FormEditNuclide.ScrollBoxCommonEnter(Sender: TObject);
begin
// SpeedButtonCommonPanel.Down:=True;
end;

procedure T_FormEditNuclide.RxDrawGridDecaysDrawCell(Sender: TObject; ACol,
 ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
 with fAttachedState, RxDrawGridDecays do
 begin
  if (ARow < Decays.Count) then
   with Decays[ARow] do
    case ACol of
     0: DrawStr(Rect, DecayStr(DecayType), taLeftJustify);
     1:
{$IFDEF RELEASE}
      if ((Branching <= 100) and (Branching > 0)) then
       DrawStr(Rect, Format('%-7.3g%', [Branching]), taCenter)
      else
       DrawStr(Rect, '', taCenter);
{$ELSE}
      DrawStr(Rect, Format('%-7.7g%', [Branching]), taCenter);
{$ENDIF}
    end;
 end;
end;

procedure T_FormEditNuclide.RxDrawGridDecaysGetEditStyle(Sender: TObject;
 ACol, ARow: Integer; var Style: TInplaceEditStyle);
begin
 with RxDrawGridDecays do
 begin
  if ACol = 0 then
   Style:= iePicklist;
 end;
end;

procedure T_FormEditNuclide.RxDrawGridDecaysGetPicklist(Sender: TObject;
 ACol, ARow: Integer; PickList: TStrings);
var
 I, J: integer;
begin
 PickList.Assign(fDecayModeList);
 with fAttachedState, RxDrawGridDecays, PickList do
  for I:= (RowCount - 2) downto 0 do // I:-> Decays[I]
   if (I <> ARow) then
    for J:= (PickList.Count - 1) downto 0 do
     if PickList[J] = DecayStr(Decays[I].DecayType) then
      Delete(J);
end;

procedure T_FormEditNuclide.RxDrawGridDecaysSetEditText(Sender: TObject;
 ACol, ARow: Integer; const Value: string);
var
 aFloat: Float;
 aDecay: TDecay;
begin
 with fAttachedState, RxDrawGridDecays do
  if (ARow < RowCount - 1) then
  begin // All but Last
   aDecay:= Decays[ARow];
   case ACol of
    0:
     begin
      aDecay.DecayType:= StrToDecayType(Value);
      if ((aDecay.DecayType <> dtNone) and (aDecay.DecayType <> Decays[ARow].DecayType)) then
      begin
       Decays[ARow]:= aDecay;
       if NuclideAttached then
        NuclideEdited:= True;
      end;
     end;
    1:
     begin
      if ValEuSilent(Value, aFloat) then
      begin
       if (Decays[ARow].Branching <> aFloat) then
       begin
        aDecay.Branching:= aFloat;
        if ((aFloat >= 0) and (aFloat <= 100)) then
         Decays[ARow]:= aDecay;
        if NuclideAttached then
         NuclideEdited:= True;
       end
       else
       begin
        if Trim(Value) = '' then
        begin
         aDecay.Branching:= -1;
         Decays[ARow]:= aDecay;
        end;
       end;
      end
      else
      begin
       MessageDlg('Decay branching conversion error', mtWarning, [mbOK], 0);
      end;
     end;
   end;
  end
  else
  begin // NewDecay
   case ACol of
    0:
     begin
      aDecay.DecayType:= StrToDecayType(Value);
      if (aDecay.DecayType <> dtNone) then
      begin
       aDecay.Branching:= 0;
       Decays.Add(aDecay);
      end;
     end;
    1:
     begin
      if (ARow > Decays.Count - 1) then
       MessageDlg('At first enter the decay type!!', mtWarning, [mbYes], 0)
      else if ValEuSilent(Value, aFloat) then
      begin
       if (Decays[Row].Branching <> aFloat) then
       begin
        aDecay:= Decays[ARow];
        aDecay.Branching:= aFloat;
        Decays[ARow]:= aDecay;
        RowCount:= Decays.Count + 1;
        if NuclideAttached then
         NuclideEdited:= True;
       end;
      end
      else
      begin
       MessageDlg('Decay branching conversion error !', mtWarning, [mbOK], 0);
      end;
     end;
   end;
  end;
end;

procedure T_FormEditNuclide.RxDrawGridDecaysKeyDown(Sender: TObject;
 var Key: Word; Shift: TShiftState);
var
 aDecay: TDecay;
begin
 with RxDrawGridDecays, fAttachedState do
 begin
  if ((Key = vk_delete) and (ssCtrl in Shift) and (Row < Decays.Count)) then
  begin
   aDecay:= Decays[Row];
   if (MessageDlg('Are you sure to delete ' + DecayStr(aDecay.DecayType) + ' ' +
    Trim(Format('%-5.5g', [aDecay.Branching])) + '% ?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
   begin
    Decays.Delete(Row);
    if NuclideAttached then
     NuclideEdited:= True;
    RowCount:= Decays.Count + 1;
   end;
  end
  else if ((Key = vk_down) and (Row < RowCount - 1)) then
   Row:= Row
  else if ((Key = vk_up) and (Row > 1)) then
   Row:= Row;
 end;
end;

procedure T_FormEditNuclide.SpeedButtonSaveToDBClick(Sender: TObject);
begin
{$IFDEF RELEASE}
 MessageDlg('At present the user edit possibilities are not supported.' + #13 + #10 +
  ' The main two reasons for above are below.' + #13 + #10 +
  ' 1) The authors want to have indeed good data in' + #13 + #10 +
  'the program DB, thus if you find out mistaken data' + #13 + #10 +
  'contact us. We promise to correct and distribute' + #13 + #10 +
  'accepted revised data in next releases, if any.' + #13 + #10 +
  ' 2) The lack of the programmers interested motives' + #13 + #10 +
  'leads to unwillingness for coding the potential. If' + #13 + #10 +
  'you can rouse our interest we shall complete' + #13 + #10 +
  'the work.     Contact addresses. ' + #13 + #10 +
  ' E-mail: roeug20@gmail.com' + #13 + #10 +
  ' Regular post: Evgeny G. Romanov' + #13 + #10 +
  '       Koroleva street 7-45,' + #13 + #10 +
  '       Dimitrovgrad, Ulyanovsk region, 433506 Russia'
  , mtInformation, [mbOK], 0);
// qqqq
{$ELSE}
 ProgressBar.Visible:= True;
 with fNuclide do
  if (_FormNK.TheDataModule is T_DataModuleDAO) then
   if SaveToDB(T_DataModuleDAO(_FormNK.TheDataModule), NuclideTag, Self.ProgressBar, CheckBoxDebug.Checked) then // ProgressBar
    Modified:= False;
 SpeedButtonToNuclideListClick(Self);
 ProgressBar.Visible:= False;
{$ENDIF}
end;

procedure T_FormEditNuclide.SpeedButtonToNuclideListClick(Sender: TObject);
var
 I: integer;
 ZnumAmass: TPoint;
 NewNuclide: TNuclide;
begin
 if LinkedNuclideList <> nil then
  with fNuclide do
  begin
   I:= LinkedNuclideList.FindInList(Znum, Amass);
   if I >= 0 then
   begin
    LinkedNuclideList.Delete(I);
    with ZnumAmass do
    begin
     X:= Znum;
     Y:= Amass;
    end;
    ZnumAmass:= _FormNK.ZnumAmassToColRow(ZnumAmass);
    _FormNK.StringGridNK.Objects[ZnumAmass.X, ZnumAmass.Y].Free;
    _FormNK.StringGridNK.Objects[ZnumAmass.X, ZnumAmass.Y]:= nil;
   end;
   NewNuclide:= TNuclide.Create(0);
   NewNuclide.Assign(fNuclide);
   LinkedNuclideList.Add(NewNuclide);
  end;
 if NuclideAttached then
  NuclideEdited:= False;
end;

procedure T_FormEditNuclide.FormClose(Sender: TObject;
 var Action: TCloseAction);
begin
 if NuclideAttached then
 begin
  Nuclide:= StaticEmptyNuclide;
  NuclideAttached:= False;
 end
 else
  PanelGridChoice.SetFocus; // Make All Edit Exit
end;

procedure T_FormEditNuclide.ComboBoxTimeUnitChange(Sender: TObject);
begin
 EditT1_2Exit(Sender);
end;

procedure T_FormEditNuclide.PrepareGammasGrid;
var
 I: integer;
begin
 fCol0.Clear;
 fCol1.Clear;
 fCol2.Clear;
// gamma
 if SpeedButtonGamma.Down then
  with fAttachedState, StringGridGammas do
  begin
   fCol0.Add('MeV');
   fCol1.Add('Prob.');
   for I:= 0 to Gammas.Count - 1 do
    with Gammas[I] do
    begin
     if Mev <> UndefinedVal then
      fCol0.Add(TextFormat(MeV))
     else
      fCol0.Add('');
     if Probability <> UndefinedVal then
      fCol1.Add(TextFormat(Probability))
     else
      fCol1.Add('');
    end;
   fCol0.Add('');
   fCol1.Add('');
   StringGridGammas.Cols[0].Assign(fCol0);
   StringGridGammas.Cols[1].Assign(fCol1);
  end
// alpha
 else if SpeedButtonAlpha.Down then
  with fAttachedState, StringGridGammas do
  begin
   fCol0.Add('MeV');
   fCol1.Add('Prob.');
   for I:= 0 to Alphas.Count - 1 do
    with Alphas[I] do
    begin
     if Mev <> UndefinedVal then
      fCol0.Add(TextFormat(MeV))
     else
      fCol0.Add('');
     if Probability <> UndefinedVal then
      fCol1.Add(TextFormat(Probability))
     else
      fCol1.Add('');
    end;
   fCol0.Add('');
   fCol1.Add('');
   StringGridGammas.Cols[0].Assign(fCol0);
   StringGridGammas.Cols[1].Assign(fCol1);
  end
// beta
 else if SpeedButtonBeta.Down then
  with fAttachedState, StringGridGammas do
  begin
   fCol0.Add('Max');
   fCol1.Add('MeV');
   fCol2.Add('Prob.');
   for I:= 0 to Betas.Count - 1 do
    with Betas[I] do
    begin
     if MaxMev <> UndefinedVal then
      fCol0.Add(TextFormat(MaxMeV))
     else
      fCol0.Add('');
     if Mev <> UndefinedVal then
      fCol1.Add(TextFormat(MeV))
     else
      fCol1.Add('');
     if Probability <> UndefinedVal then
      fCol2.Add(TextFormat(Probability))
     else
      fCol2.Add('');
    end;
   fCol0.Add('');
   fCol1.Add('');
   fCol2.Add('');
   StringGridGammas.Cols[0].Assign(fCol0);
   StringGridGammas.Cols[1].Assign(fCol1);
   StringGridGammas.Cols[2].Assign(fCol2);
  end
// electron
 else if SpeedButtonElectron.Down then
  with fAttachedState, StringGridGammas do
  begin
   fCol0.Add('MeV');
   fCol1.Add('Prob.');
   for I:= 0 to Electrons.Count - 1 do
    with Electrons[I] do
    begin
     if Mev <> UndefinedVal then
      fCol0.Add(TextFormat(MeV))
     else
      fCol0.Add('');
     if Probability <> UndefinedVal then
      fCol1.Add(TextFormat(Probability))
     else
      fCol1.Add('');
    end;
   fCol0.Add('');
   fCol1.Add('');
   StringGridGammas.Cols[0].Assign(fCol0);
   StringGridGammas.Cols[1].Assign(fCol1);
  end
// positron
 else if SpeedButtonPositron.Down then
  with fAttachedState, StringGridGammas do
  begin
   fCol0.Add('Max');
   fCol1.Add('MeV');
   fCol2.Add('Prob.');
   for I:= 0 to Positrons.Count - 1 do
    with Positrons[I] do
    begin
     if MaxMev <> UndefinedVal then
      fCol0.Add(TextFormat(MaxMeV))
     else
      fCol0.Add('');
     if Mev <> UndefinedVal then
      fCol1.Add(TextFormat(MeV))
     else
      fCol1.Add('');
     if Probability <> UndefinedVal then
      fCol2.Add(TextFormat(Probability))
     else
      fCol2.Add('');
    end;
   fCol0.Add('');
   fCol1.Add('');
   fCol2.Add('');
   StringGridGammas.Cols[0].Assign(fCol0);
   StringGridGammas.Cols[1].Assign(fCol1);
   StringGridGammas.Cols[2].Assign(fCol2);
  end
end;

procedure T_FormEditNuclide.StringGridGammasKeyDown(Sender: TObject;
 var Key: Word; Shift: TShiftState);
var
 aGamma: TGamma;
 aAlpha: TAlpha;
 aBeta: TBeta;
 aElectron: TElectron;
 aPositron: TPositron;
begin
// Copy to clipboard
 if ((Key in [VK_INSERT, Ord('C')]) and (ssCtrl in Shift)) then
  CopyToClipboardFromStringGrid(StringGridGammas);
// Editing
 if SpeedButtonGamma.Down then
 begin
  with StringGridGammas, fAttachedState do
  begin
   if ((Key = vk_delete) and (ssCtrl in Shift) and (Row - 1 < Decays.Count)) then
   begin
    aGamma:= Gammas[Row - 1];
    if (MessageDlg('Are you sure to delete the gamma line ' +
     Trim(Format('%-5.5g MeV, value: %-5.5g', [aGamma.MEV, aGamma.Probability])) + '% ?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
    begin
     Gammas.Delete(Row - 1);
     if NuclideAttached then
      NuclideEdited:= True;
     RowCount:= Gammas.Count + 2;
    end;
   end;
  end;
 end //if SpeedButtonGamma.Down then begin
 else if SpeedButtonAlpha.Down then
 begin
  with StringGridGammas, fAttachedState do
  begin
   if ((Key = vk_delete) and (ssCtrl in Shift) and (Row - 1 < Decays.Count)) then
   begin
    aAlpha:= Alphas[Row - 1];
    if (MessageDlg('Are you sure to delete the alpha line ' +
     Trim(Format('%-5.5g MeV, value: %-5.5g', [aAlpha.MEV, aAlpha.Probability])) + '% ?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
    begin
     Alphas.Delete(Row - 1);
     if NuclideAttached then
      NuclideEdited:= True;
     RowCount:= Alphas.Count + 2;
    end;
   end;
  end;
 end //if SpeedButtonAlpha.Down then begin
 else if SpeedButtonBeta.Down then
 begin
  with StringGridGammas, fAttachedState do
  begin
   if ((Key = vk_delete) and (ssCtrl in Shift) and (Row - 1 < Decays.Count)) then
   begin
    aBeta:= Betas[Row - 1];
    if (MessageDlg('Are you sure to delete the beta line ' +
     Trim(Format('%-5.5g MeV, value: %-5.5g', [aBeta.MEV, aBeta.Probability])) + '% ?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
    begin
     Betas.Delete(Row - 1);
     if NuclideAttached then
      NuclideEdited:= True;
     RowCount:= Betas.Count + 2;
    end;
   end;
  end;
 end //if SpeedButtonBeta.Down then begin
 else if SpeedButtonElectron.Down then
 begin
  with StringGridGammas, fAttachedState do
  begin
   if ((Key = vk_delete) and (ssCtrl in Shift) and (Row - 1 < Decays.Count)) then
   begin
    aElectron:= Electrons[Row - 1];
    if (MessageDlg('Are you sure to delete the electron line ' +
     Trim(Format('%-5.5g MeV, value: %-5.5g', [aElectron.MEV, aElectron.Probability])) + '% ?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
    begin
     Electrons.Delete(Row - 1);
     if NuclideAttached then
      NuclideEdited:= True;
     RowCount:= Electrons.Count + 2;
    end;
   end;
  end;
 end //if SpeedButtonElectron.Down then begin
 else if SpeedButtonPositron.Down then
 begin
  with StringGridGammas, fAttachedState do
  begin
   if ((Key = vk_delete) and (ssCtrl in Shift) and (Row - 1 < Decays.Count)) then
   begin
    aPositron:= Positrons[Row - 1];
    if (MessageDlg('Are you sure to delete the positron line ' +
     Trim(Format('%-5.5g MeV, value: %-5.5g', [aPositron.MEV, aPositron.Probability])) + '% ?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
    begin
     Positrons.Delete(Row - 1);
     if NuclideAttached then
      NuclideEdited:= True;
     RowCount:= Positrons.Count + 2;
    end;
   end;
  end;
 end; //if SpeedButtonPositron.Down then begin
end;

procedure T_FormEditNuclide.StringGridGammasSetEditText(Sender: TObject;
 ACol, ARow: Integer; const Value: string);
var
 aFloat: Float;
 aGamma: TGamma;
 aAlpha: TAlpha;
 aBeta: TBeta;
 aElectron: TElectron;
 aPositron: TPositron;
begin
 if SpeedButtonGamma.Down then
 begin
  with fAttachedState, StringGridGammas do
   if (ARow < RowCount - 1) then
   begin //All but last
    aGamma:= Gammas[ARow - 1];
    case ACol of
     0:
      begin
       if ValEu(Value, aFloat, 'Gamma MeV conversion failed ') then
       begin
        if (aGamma.MeV <> aFloat) then
        begin
         aGamma.MeV:= aFloat;
         Gammas[ARow - 1]:= aGamma;
         if NuclideAttached then
          NuclideEdited:= True;
        end;
       end;
      end;
     1: if ValEu(Value, aFloat, 'Gamma Probability conversion failed ') then
      begin
       if (Gammas[ARow - 1].Probability <> aFloat) then
       begin
        aGamma.Probability:= aFloat;
        Gammas[ARow - 1]:= aGamma;
        if NuclideAttached then
         NuclideEdited:= True;
       end;
      end;
    end;
   end
   else
   begin // Last Row - NewGamma
    case ACol of
     0:
      begin
       if ValEu(Value, aFloat, 'Gamma MeV conversion failed ') then
       begin
        aGamma.MeV:= aFloat;
        aGamma.Probability:= 0;
        Gammas.Add(aGamma);
       end;
      end;
     1:
      begin
       if (ARow > Gammas.Count) then
        MessageDlg('Enter the gamma line energy (MeV)!!', mtWarning, [mbYes], 0)
       else if ValEu(Value, aFloat, 'Gamma Probability conversion failed ') then
       begin
        if (Gammas[Row - 1].Probability <> aFloat) then
        begin
         aGamma:= Gammas[ARow - 1];
         aGamma.Probability:= aFloat;
         Gammas[ARow - 1]:= aGamma;
         RowCount:= Gammas.Count + 2;
         if NuclideAttached then
          NuclideEdited:= True;
        end;
       end;
      end;
    end;
   end;
 end //if SpeedButtonGamma.Down
 else if SpeedButtonAlpha.Down then
 begin
  with fAttachedState, StringGridGammas do
   if (ARow < RowCount - 1) then
   begin //All but last
    aAlpha:= Alphas[ARow - 1];
    case ACol of
     0:
      begin
       if ValEu(Value, aFloat, 'Alpha MeV conversion failed ') then
       begin
        if (aAlpha.MeV <> aFloat) then
        begin
         aAlpha.MeV:= aFloat;
         Alphas[ARow - 1]:= aAlpha;
         if NuclideAttached then
          NuclideEdited:= True;
        end;
       end;
      end;
     1: if ValEu(Value, aFloat, 'Alpha Probability conversion failed ') then
      begin
       if (Alphas[ARow - 1].Probability <> aFloat) then
       begin
        aAlpha.Probability:= aFloat;
        Alphas[ARow - 1]:= aAlpha;
        if NuclideAttached then
         NuclideEdited:= True;
       end;
      end;
    end;
   end
   else
   begin // Last Row - NewAlpha
    case ACol of
     0:
      begin
       if ValEu(Value, aFloat, 'Alpha MeV conversion failed ') then
       begin
        aAlpha.MeV:= aFloat;
        aAlpha.Probability:= 0;
        Alphas.Add(aAlpha);
       end;
      end;
     1:
      begin
       if (ARow > Alphas.Count) then
        MessageDlg('Enter the alpha line energy (MeV)!!', mtWarning, [mbYes], 0)
       else if ValEu(Value, aFloat, 'Alpha Probability conversion failed ') then
       begin
        if (Alphas[Row - 1].Probability <> aFloat) then
        begin
         aAlpha:= Alphas[ARow - 1];
         aAlpha.Probability:= aFloat;
         Alphas[ARow - 1]:= aAlpha;
         RowCount:= Alphas.Count + 2;
         if NuclideAttached then
          NuclideEdited:= True;
        end;
       end;
      end;
    end;
   end;
 end //if SpeedButtonAlpha.Down
 else if SpeedButtonBeta.Down then
 begin
  with fAttachedState, StringGridGammas do
   if (ARow < RowCount - 1) then
   begin //All but last
    aBeta:= Betas[ARow - 1];
    case ACol of
     0:
      begin
       if ValEu(Value, aFloat, 'Beta MaxMeV conversion failed ') then
       begin
        if (aBeta.MaxMeV <> aFloat) then
        begin
         aBeta.MaxMeV:= aFloat;
         Betas[ARow - 1]:= aBeta;
         if NuclideAttached then
          NuclideEdited:= True;
        end;
       end;
      end;
     1: if ValEu(Value, aFloat, 'Beta Probability conversion failed ') then
      begin
       if (Betas[ARow - 1].Probability <> aFloat) then
       begin
        aBeta.Probability:= aFloat;
        Betas[ARow - 1]:= aBeta;
        if NuclideAttached then
         NuclideEdited:= True;
       end;
      end;
    end;
   end
   else
   begin // Last Row - NewBeta
    case ACol of
     0:
      begin
       if (ARow > Betas.Count) then
        MessageDlg('Enter the beta line energy (MeV)!!', mtWarning, [mbYes], 0)
       else if ValEu(Value, aFloat, 'Beta MaxMeV conversion failed ') then
       begin
        if (Betas[Row - 1].MaxMev <> aFloat) then
        begin
         aBeta:= Betas[ARow - 1];
         aBeta.MaxMev:= aFloat;
         Betas[ARow - 1]:= aBeta;
         RowCount:= Betas.Count + 2;
         if NuclideAttached then
          NuclideEdited:= True;
        end;
       end;
      end;
     1:
      begin
       if (ARow > Betas.Count) then
        MessageDlg('Enter the gamma line energy (MeV)!!', mtWarning, [mbYes], 0)
       else if ValEu(Value, aFloat, 'Beta Probability conversion failed ') then
       begin
        if (Betas[Row - 1].Probability <> aFloat) then
        begin
         aBeta:= Betas[ARow - 1];
         aBeta.Probability:= aFloat;
         Betas[ARow - 1]:= aBeta;
         RowCount:= Betas.Count + 2;
         if NuclideAttached then
          NuclideEdited:= True;
        end;
       end;
      end;
    end;
   end;
 end //if SpeedButtonBeta.Down
 else if SpeedButtonElectron.Down then
 begin
  with fAttachedState, StringGridGammas do
   if (ARow < RowCount - 1) then
   begin //All but last
    aElectron:= Electrons[ARow - 1];
    case ACol of
     0:
      begin
       if ValEu(Value, aFloat, 'Electron MeV conversion failed ') then
       begin
        if (aElectron.MeV <> aFloat) then
        begin
         aElectron.MeV:= aFloat;
         Electrons[ARow - 1]:= aElectron;
         if NuclideAttached then
          NuclideEdited:= True;
        end;
       end;
      end;
     1: if ValEu(Value, aFloat, 'Electron Probability conversion failed ') then
      begin
       if (Electrons[ARow - 1].Probability <> aFloat) then
       begin
        aElectron.Probability:= aFloat;
        Electrons[ARow - 1]:= aElectron;
        if NuclideAttached then
         NuclideEdited:= True;
       end;
      end;
    end;
   end
   else
   begin // Last Row - NewElectron
    case ACol of
     0:
      begin
       if ValEu(Value, aFloat, 'Electron MeV conversion failed ') then
       begin
        aElectron.MeV:= aFloat;
        aElectron.Probability:= 0;
        Electrons.Add(aElectron);
       end;
      end;
     1:
      begin
       if (ARow > Electrons.Count) then
        MessageDlg('Enter the electron line energy (MeV)!!', mtWarning, [mbYes], 0)
       else if ValEu(Value, aFloat, 'Electron Probability conversion failed ') then
       begin
        if (Electrons[Row - 1].Probability <> aFloat) then
        begin
         aElectron:= Electrons[ARow - 1];
         aElectron.Probability:= aFloat;
         Electrons[ARow - 1]:= aElectron;
         RowCount:= Electrons.Count + 2;
         if NuclideAttached then
          NuclideEdited:= True;
        end;
       end;
      end;
    end;
   end;
 end //if SpeedButtonElectron.Down
 else if SpeedButtonPositron.Down then
 begin
  with fAttachedState, StringGridGammas do
   if (ARow < RowCount - 1) then
   begin //All but last
    aPositron:= Positrons[ARow - 1];
    case ACol of
     0:
      begin
       if ValEu(Value, aFloat, 'Positron MaxMeV conversion failed ') then
       begin
        if (aPositron.MaxMeV <> aFloat) then
        begin
         aPositron.MaxMeV:= aFloat;
         Positrons[ARow - 1]:= aPositron;
         if NuclideAttached then
          NuclideEdited:= True;
        end;
       end;
      end;
     1: if ValEu(Value, aFloat, 'Positron Probability conversion failed ') then
      begin
       if (Positrons[ARow - 1].Probability <> aFloat) then
       begin
        aPositron.Probability:= aFloat;
        Positrons[ARow - 1]:= aPositron;
        if NuclideAttached then
         NuclideEdited:= True;
       end;
      end;
    end;
   end
   else
   begin // Last Row - NewPositron
    case ACol of
     0:
      begin
       if (ARow > Positrons.Count) then
        MessageDlg('Enter the positron line energy (MeV)!!', mtWarning, [mbYes], 0)
       else if ValEu(Value, aFloat, 'Positron MaxMeV conversion failed ') then
       begin
        if (Positrons[Row - 1].MaxMev <> aFloat) then
        begin
         aPositron:= Positrons[ARow - 1];
         aPositron.MaxMev:= aFloat;
         Positrons[ARow - 1]:= aPositron;
         RowCount:= Positrons.Count + 2;
         if NuclideAttached then
          NuclideEdited:= True;
        end;
       end;
      end;
     1:
      begin
       if (ARow > Positrons.Count) then
        MessageDlg('Enter the positron line energy (MeV)!!', mtWarning, [mbYes], 0)
       else if ValEu(Value, aFloat, 'Positron Probability conversion failed ') then
       begin
        if (Positrons[Row - 1].Probability <> aFloat) then
        begin
         aPositron:= Positrons[ARow - 1];
         aPositron.Probability:= aFloat;
         Positrons[ARow - 1]:= aPositron;
         RowCount:= Positrons.Count + 2;
         if NuclideAttached then
          NuclideEdited:= True;
        end;
       end;
      end;
    end;
   end;
 end //if SpeedButtonPositron.Down
end;

procedure T_FormEditNuclide.SpeedButtonGammaClick(Sender: TObject);
begin
 with StringGridGammas do
 begin
  ColCount:= 2;
  RowCount:= fAttachedState.Gammas.Count + 2;
  Height:= ScrollBoxState.Height - StringGridGammas.Top;
  Width:= Self.ClientWidth - 2;
  ColWidths[0]:= (ClientWidth div ColCount) - ColCount;
  ColWidths[1]:= (ClientWidth div ColCount) - ColCount;
  if ColCount > 2 then
   ColWidths[3]:= (ClientWidth div ColCount) - ColCount;
 end;
 InvalidateStatePanel;
end;

procedure T_FormEditNuclide.FormResize(Sender: TObject);
begin
 with StringGridGammas do
 begin
  Height:= ScrollBoxState.Height - StringGridGammas.Top;
  Width:= Self.ClientWidth - 2;
  ColWidths[0]:= (ClientWidth div ColCount) - ColCount;
  ColWidths[1]:= (ClientWidth div ColCount) - ColCount;
  if ColCount > 2 then
   ColWidths[2]:= (ClientWidth div ColCount) - ColCount;
 end;
 with RxDrawGridDecays do
 begin
  ColWidths[0]:= (ClientWidth div ColCount) - ColCount;
  ColWidths[1]:= (ClientWidth div ColCount) - ColCount;
 end;
 EditT1_2.Width:= ClientWidth div 2 - 1;
 ComboBoxTimeUnit.Left:= EditT1_2.Left + EditT1_2.Width + 1;
 EditT1_2RO.Width:= ClientWidth div 2 - 1;
 ComboBoxTimeUnitRO.Left:= EditT1_2ro.Left + EditT1_2ro.Width + 1;
end;

procedure T_FormEditNuclide.SpeedButtonAlphaClick(Sender: TObject);
begin
 with StringGridGammas do
 begin
  ColCount:= 2;
  RowCount:= fAttachedState.Alphas.Count + 2;
  Height:= ScrollBoxState.Height - StringGridGammas.Top;
  Width:= Self.ClientWidth - 2;
  ColWidths[0]:= (ClientWidth div ColCount) - ColCount;
  ColWidths[1]:= (ClientWidth div ColCount) - ColCount;
  if ColCount > 2 then
   ColWidths[3]:= (ClientWidth div ColCount) - ColCount;
 end;
 InvalidateStatePanel;
end;

procedure T_FormEditNuclide.SpeedButtonBetaClick(Sender: TObject);
begin
 with StringGridGammas do
 begin
  ColCount:= 3;
  RowCount:= fAttachedState.Betas.Count + 2;
  Height:= ScrollBoxState.Height - StringGridGammas.Top;
  Width:= Self.ClientWidth - 2;
  ColWidths[0]:= (ClientWidth div ColCount) - ColCount;
  ColWidths[1]:= (ClientWidth div ColCount) - ColCount;
  if ColCount > 2 then
   ColWidths[2]:= (ClientWidth div ColCount) - ColCount;
 end;
 InvalidateStatePanel;
end;

procedure T_FormEditNuclide.ComboBoxTimeUnitROChange(Sender: TObject);
begin
 with fAttachedState do
 begin
  if IsStable then
  begin
   EditT1_2RO.Text:= 'STABLE';
   Exit;
  end;
{$IFDEF RELEASE}
  if (T1_2 > 0) then
{$ENDIF}
   if (LowerCase(Copy(Trim(ComboBoxTimeUnitRO.Items[ComboBoxTimeUnitRO.ItemIndex]), 1, 2)) = 'se') then
    EditT1_2RO.Text:= TextFormat(T1_2 / ti_sec)
   else if (LowerCase(Copy(Trim(ComboBoxTimeUnitRO.Items[ComboBoxTimeUnitRO.ItemIndex]), 1, 2)) = 'ps') then
    EditT1_2RO.Text:= TextFormat(T1_2 / ti_ps)
   else if (LowerCase(Copy(Trim(ComboBoxTimeUnitRO.Items[ComboBoxTimeUnitRO.ItemIndex]), 1, 2)) = 'ns') then
    EditT1_2RO.Text:= TextFormat(T1_2 / ti_ns)
   else if (LowerCase(Copy(Trim(ComboBoxTimeUnitRO.Items[ComboBoxTimeUnitRO.ItemIndex]), 1, 2)) = 'mk') then
    EditT1_2RO.Text:= TextFormat(T1_2 / ti_mks)
   else if (LowerCase(Copy(Trim(ComboBoxTimeUnitRO.Items[ComboBoxTimeUnitRO.ItemIndex]), 1, 2)) = 'ms') then
    EditT1_2RO.Text:= TextFormat(T1_2 / ti_ms)
   else if (LowerCase(Copy(Trim(ComboBoxTimeUnitRO.Items[ComboBoxTimeUnitRO.ItemIndex]), 1, 2)) = 'mi') then
    EditT1_2RO.Text:= TextFormat(T1_2 / ti_min)
   else if (LowerCase(Copy(Trim(ComboBoxTimeUnitRO.Items[ComboBoxTimeUnitRO.ItemIndex]), 1, 2)) = 'ho') then
    EditT1_2RO.Text:= TextFormat(T1_2 / ti_hou)
   else if (LowerCase(Copy(Trim(ComboBoxTimeUnitRO.Items[ComboBoxTimeUnitRO.ItemIndex]), 1, 2)) = 'da') then
    EditT1_2RO.Text:= TextFormat(T1_2 / ti_day)
   else if (LowerCase(Copy(Trim(ComboBoxTimeUnitRO.Items[ComboBoxTimeUnitRO.ItemIndex]), 1, 2)) = 'ye') then
    EditT1_2RO.Text:= TextFormat(T1_2 / ti_yea)
   else if (LowerCase(Copy(Trim(ComboBoxTimeUnitRO.Items[ComboBoxTimeUnitRO.ItemIndex]), 1, 2)) = 'la') then
    if T1_2 > 0 then
     EditT1_2RO.Text:= TextFormat(Ln(2) / T1_2)
    else
     EditT1_2RO.Text:= ' ';
 end;
end;

procedure T_FormEditNuclide.SpeedButtonCopyStateClick(Sender: TObject);
begin
 BufState.Assign(fAttachedState);
 SpeedButtonPasteState.Enabled:= True;
end;

procedure T_FormEditNuclide.SpeedButtonPasteStateClick(Sender: TObject);
var
 I: integer;
begin
 I:= fAttachedState.State;
 fAttachedState.Assign(BufState);
 fAttachedState.State:= I;
 if NuclideAttached then
  NuclideEdited:= True;
 InvalidateStatePanel;
end;

procedure T_FormEditNuclide.SpeedButtonCaptureClick(Sender: TObject);
begin
 InvalidateStatePanel;
end;

procedure T_FormEditNuclide.SpeedButtonFissionClick(Sender: TObject);
begin
 InvalidateStatePanel;
end;

procedure T_FormEditNuclide.EditSigmaFExit(Sender: TObject);
var
 aFloat: Float;
begin
 if (Trim(EditSigmaF.Text) <> '') then
  if ValEuSilent(EditSigmaF.Text, aFloat) then
  begin
   fAttachedState.SigmaF:= aFloat;
   NuclideEdited:= True;
  end
  else
  begin
   MessageDlg('SigmaF (fission cross-section) conversion failed ', mtWarning, [mbOK], 0);
   PanelFission.Show;
   EditSigmaF.SetFocus;
//   MessageBeep(0);
  end;
end;

procedure T_FormEditNuclide.EditRIfExit(Sender: TObject);
var
 aFloat: Float;
begin
 if (Trim(EditRIf.Text) <> '') then
  if ValEuSilent(EditRIf.Text, aFloat) then
  begin
   fAttachedState.RIf:= aFloat;
   NuclideEdited:= True;
  end
  else
  begin
   MessageDlg('RI_F (fission resonance integral) conversion failed ', mtWarning, [mbOK], 0);
   PanelFission.Show;
   EditRIf.SetFocus;
//   MessageBeep(0);
  end;
end;

procedure T_FormEditNuclide.PanelCaptureResize(Sender: TObject);
begin
 with EditCaptureToG do
  Width:= PanelCapture.ClientWidth - Left - 1;
 with EditCaptureToM1 do
  Width:= PanelCapture.ClientWidth - Left - 1;
 with EditCaptureToM2 do
  Width:= PanelCapture.ClientWidth - Left - 1;
 with EditG_factor do
  Width:= PanelCapture.ClientWidth - Left - 1;
 with EditRIToG do
  Width:= PanelCapture.ClientWidth - Left - 1;
 with EditRIToM1 do
  Width:= PanelCapture.ClientWidth - Left - 1;
 with EditRIToM2 do
  Width:= PanelCapture.ClientWidth - Left - 1;
 with StringGridSigmaThreshold do
  ColWidths[1]:= Max(Width - ColWidths[0] - 7, DefaultColWidth);
end;

procedure T_FormEditNuclide.SpeedButtonDecayCountClick(Sender: TObject);
var
 _FormDecayPos: TPoint;
begin
 with _FormDecay do
 begin
//  if _FormDecay.FirstShow then   // óáðàë - åñëè âñåãäà, âðîäå, êðàñèâåå
  begin
   _FormDecayPos.Y:= 2;
   _FormDecayPos.X:= Self.Width;
   _FormDecayPos:= Self.ClientToScreen(_FormDecayPos);
   if (_FormDecayPos.X < (Screen.Width div 2)) then // if Docked Self.Left=0
    _FormDecayPos.X:= _FormDecayPos.X + 2
   else
    _FormDecayPos.X:= _FormDecayPos.X - _FormDecay.Width - Self.Width - 2;
   _FormDecay.Left:= _FormDecayPos.X;
   _FormDecay.Top:= _FormDecayPos.Y;
  end;
  _FormDecay.StateT1_2:= fAttachedState.T1_2;
  _FormDecay.StateMass_g:= fAttachedState.Nuclide.Amass;
  _FormDecay.StateLambda:= fAttachedState.Lambda;
  _FormDecay.StateName:= fAttachedState.Name;
//  _FormDecay.ShowModal;
  _FormDecay.InvalidateForm;
  _FormDecay.Show;
 end;
end;

procedure T_FormEditNuclide.LabelLinesDblClick(Sender: TObject);
(*
var
 aNuclide: TNuclide;
 I, TheStateNo: integer;
*)
begin
(* //qq
 if not(NuclideAttached) then
  if (AttachedState is TChainState) then begin
   aNuclide:= TNuclide.Create(TChainState(AttachedState).ThZpA);
   if (_FormNK.TheDataModule is T_DataModuleDAO) then
    aNuclide.LoadFromDB(T_DataModuleDAO(_FormNK.TheDataModule), nloAlpha or nloBeta or nloGamma);
   TheStateNo:= AttachedState.State;
   if (TheStateNo<aNuclide.StateList.Count) then begin
    AttachedState.Alphas.Clear;
    for I:= 0 to aNuclide.StateList[TheStateNo].Alphas.Count-1 do
     AttachedState.Alphas.Add(aNuclide.StateList[TheStateNo].Alphas[I]);
    AttachedState.Betas.Clear;
    for I:= 0 to aNuclide.StateList[TheStateNo].Betas.Count-1 do
     AttachedState.Betas.Add(aNuclide.StateList[TheStateNo].Betas[I]);
    AttachedState.Gammas.Clear;
    for I:= 0 to aNuclide.StateList[TheStateNo].Gammas.Count-1 do
     AttachedState.Gammas.Add(aNuclide.StateList[TheStateNo].Gammas[I]);
    aNuclide.Free;
   end;
  end;
 *)
 InvalidateStatePanel;
end;

procedure T_FormEditNuclide.StringGridSigmaThresholdSetEditText(
 Sender: TObject; ACol, ARow: Integer; const Value: string);
var
 aFloat: Float;
begin
 case ARow of
  1: if ValEu(Value, aFloat, 'SigmaNP (n-p cross-section) conversion failed ') then
    if (aFloat <> fAttachedState.SigmaNP) then
    begin
     fAttachedState.SigmaNP:= aFloat;
     if NuclideAttached then
      NuclideEdited:= True;
    end;
  2: if ValEu(Value, aFloat, 'SigmaNA (n-Alpha cross-section) conversion failed ') then
    if (aFloat <> fAttachedState.SigmaNA) then
    begin
     fAttachedState.SigmaNA:= aFloat;
     if NuclideAttached then
      NuclideEdited:= True;
    end;
  3: if ValEu(Value, aFloat, 'SigmaN2N (n-2n cross-section) conversion failed ') then
    if (aFloat <> fAttachedState.SigmaN2N) then
    begin
     fAttachedState.SigmaN2N:= aFloat;
     if NuclideAttached then
      NuclideEdited:= True;
    end;
  4: if ValEu(Value, aFloat, 'SigmaNN (n-n'' cross-section) conversion failed ') then
    if (aFloat <> fAttachedState.SigmaNN) then
    begin
     fAttachedState.SigmaNN:= aFloat;
     if NuclideAttached then
      NuclideEdited:= True;
    end;
  5: if ValEu(Value, aFloat, 'SigmaNG (n-gamma cross-section) conversion failed ') then
    if (aFloat <> fAttachedState.SigmaNG) then
    begin
     fAttachedState.SigmaNG:= aFloat;
     if NuclideAttached then
      NuclideEdited:= True;
    end;
//g-factor -near SigmaC
(*
  6: if ValEu(Value, aFloat) then
    if (aFloat<>fAttachedState.g_factor) then begin
     fAttachedState.g_factor:= aFloat;
     if NuclideAttached then
      NuclideEdited:= True;
    end;
*)
 end;
end;

procedure T_FormEditNuclide.PanelFissionResize(Sender: TObject);
begin
 with EditSigmaF do
  Width:= PanelFission.ClientWidth - Left;
 with EditRIf do
  Width:= PanelFission.ClientWidth - Left;
 with RadioGroupSpectr do
  Width:= PanelFission.ClientWidth - Left;
 with StringGridYields do
 begin
  Height:= PanelFission.ClientHeight - Top;
  Width:= Max(PanelFission.ClientWidth, 50);
  DefaultColWidth:= (Width - 24) div 3;
 end;
end;

procedure T_FormEditNuclide.ScrollBoxStateResize(Sender: TObject);
begin
 StringGridGammas.Height:= ScrollBoxState.Height - StringGridGammas.Top;
 with ComboBoxTimeUnit do
  Left:= ScrollBoxState.ClientWidth - Width - 3;
 with ComboBoxTimeUnitRO do
  Left:= ScrollBoxState.ClientWidth - Width - 3;
 with EditT1_2 do
  Width:= ComboBoxTimeUnit.Left - Left - 2;
 with EditT1_2RO do
  Width:= ComboBoxTimeUnitRO.Left - Left - 2;
end;

procedure T_FormEditNuclide.RadioButtonThermalSpectrClick(Sender: TObject);
begin
 CreateYieldComponents;
end;

procedure T_FormEditNuclide.RadioButtonFissionSpectrClick(Sender: TObject);
begin
 CreateYieldComponents;
end;

procedure T_FormEditNuclide.FormDestroy(Sender: TObject);
begin
 fNuclideImage.Free;
 fStaticEmptyNuclide.Free;
 fDecayModeList.Free;
 fCol0.Free;
 fCol1.Free;
 fCol2.Free;
end;

procedure T_FormEditNuclide.PanelToolResize(Sender: TObject);
begin
 with SpeedButtonDecayCount do
  Left:= PanelTool.ClientWidth - Width - 3;
end;

procedure T_FormEditNuclide.Splitter1Moved(Sender: TObject);
begin
 LabelKG.Top:= LabelLines.Top;
end;

procedure T_FormEditNuclide.EditG_factorExit(Sender: TObject);
var
 aFloat: Float;
begin
 with fAttachedState do
 begin
  if (Captures.Count = 0) then
   Captures.Add(ZiroCaptureToG);
  if Trim(EditG_factor.Text) <> '' then
   if ValEuSilent(EditG_factor.Text, aFloat) then
   begin
    if (Captures.G_factor <> aFloat) then
    begin
     Captures.G_factor:= aFloat;
     if NuclideAttached then
      NuclideEdited:= True;
    end;
   end
   else
   begin
    MessageDlg('G-factor conversion error', mtWarning, [mbOK], 0);
    ScrollBoxState.Show;
    EditG_factor.SetFocus;
//    MessageBeep(0);
   end;
 end;
end;

procedure T_FormEditNuclide.SpeedButtonElectronClick(Sender: TObject);
begin
 with StringGridGammas do
 begin
  ColCount:= 2;
  RowCount:= fAttachedState.Electrons.Count + 2;
  Height:= ScrollBoxState.Height - StringGridGammas.Top;
  Width:= Self.ClientWidth - 2;
  ColWidths[0]:= (ClientWidth div ColCount) - ColCount;
  ColWidths[1]:= (ClientWidth div ColCount) - ColCount;
  if ColCount > 2 then
   ColWidths[3]:= (ClientWidth div ColCount) - ColCount;
 end;
 InvalidateStatePanel;
end;

procedure T_FormEditNuclide.SpeedButtonPositronClick(Sender: TObject);
begin
 with StringGridGammas do
 begin
  ColCount:= 3;
  RowCount:= fAttachedState.Positrons.Count + 2;
  Height:= ScrollBoxState.Height - StringGridGammas.Top;
  Width:= Self.ClientWidth - 2;
  ColWidths[0]:= (ClientWidth div ColCount) - ColCount;
  ColWidths[1]:= (ClientWidth div ColCount) - ColCount;
  if ColCount > 2 then
   ColWidths[2]:= (ClientWidth div ColCount) - ColCount;
 end;
 InvalidateStatePanel;
end;

procedure T_FormEditNuclide.FormKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
 if Key = VK_ESCAPE then
  Close
 else if (ssAlt in Shift) then
  case Key of
   Ord('I'):
    begin
     SpeedButtonCommonPanelClick(Self);
     SpeedButtonCommonPanel.Down:= True;
    end;
   Ord('G'), Ord('0'):
    begin
     SpeedButtonGstateClick(Self);
     SpeedButtonGstate.Down:= True;
    end;
   Ord('M'), Ord('1'): if SpeedButtonM1state.Visible then
    begin
     SpeedButtonM1stateClick(Self);
     SpeedButtonM1state.Down:= True;
    end;
   Ord('N'), Ord('2'): if SpeedButtonM2state.Visible then
    begin
     SpeedButtonM2stateClick(Self);
     SpeedButtonM2state.Down:= True;
    end;
   Ord('A'):
    begin
     SpeedButtonAlphaClick(Self);
     SpeedButtonAlpha.Down:= True;
    end;
   Ord('B'):
    begin
     SpeedButtonBetaClick(Self);
     SpeedButtonBeta.Down:= True;
    end;
   Ord('C'), Ord('Y'):
    begin
     SpeedButtonGammaClick(Self);
     SpeedButtonGamma.Down:= True;
    end;
   Ord('D'), Ord('P'):
    begin
     SpeedButtonPositronClick(Self);
     SpeedButtonPositron.Down:= True;
    end;
   Ord('E'):
    begin
     SpeedButtonElectronClick(Self);
     SpeedButtonElectron.Down:= True;
    end;
   Ord('S'):
    begin
     SpeedButtonCaptureClick(Self);
     SpeedButtonCapture.Down:= True;
    end;
   Ord('F'):
    begin
     SpeedButtonFissionClick(Self);
     SpeedButtonFission.Down:= True;
    end;
  end;
end;

procedure T_FormEditNuclide.StringGridGammasDblClick(Sender: TObject);
begin
 fOrderGammaDesc:= not (fOrderGammaDesc);
 StringGridOrder(StringGridGammas, StringGridGammas.Col, fOrderGammaDesc, True);
end;

procedure T_FormEditNuclide.StringGridOrder(aStringGrid: TStringGrid; aCol: integer = 0; const Desc: Boolean = True; const CompareFloat: Boolean = True);
var
 I, J: integer;
 ThreeCols, CompareResult: Boolean;
begin
 fCol0.Clear;
 fCol1.Clear;
 fCol2.Clear;
 ThreeCols:= (aStringGrid.ColCount > 2);
 try
  fCol0.Assign(aStringGrid.Cols[aCol]);
  case aCol of
   0:
    begin
     fCol1.Assign(aStringGrid.Cols[1]);
     if ThreeCols then
      fCol2.Assign(aStringGrid.Cols[2]);
    end;
   1:
    begin
     fCol1.Assign(aStringGrid.Cols[0]);
     if ThreeCols then
      fCol2.Assign(aStringGrid.Cols[2]);
    end;
   2:
    begin
     fCol1.Assign(aStringGrid.Cols[0]);
     if ThreeCols then
      fCol2.Assign(aStringGrid.Cols[1]);
    end;
  end;
  with aStringGrid, fCol0, fCol1, fCol2 do
  begin
   if Desc then
   begin
// Sort on Col1 and Col2 on the basic of Col0 values Order
//    for J:= 2 to fCol0.Count-1 do begin
    for J:= 2 to fCol0.Count - 2 do
    begin
     I:= J;
     if CompareFloat then
      CompareResult:= CompareFloatStr(fCol0[I], fCol0[I - 1])
     else
      CompareResult:= fCol0[I] > fCol0[I - 1];
     while (CompareResult) do
     begin // OK
      fCol0.Exchange(I, I - 1);
      fCol1.Exchange(I, I - 1);
      if ThreeCols then
       fCol2.Exchange(I, I - 1);
      if I = 2 then break;
      Dec(I);
      if CompareFloat then
       CompareResult:= CompareFloatStr(fCol0[I], fCol0[I - 1])
      else
       CompareResult:= fCol0[I] > fCol0[I - 1];
     end;
    end;
   end
   else
   begin
//    for J:= 2 to fCol0.Count-1 do begin
    for J:= 2 to fCol0.Count - 2 do
    begin
     I:= J;
     if CompareFloat then
      CompareResult:= CompareFloatStr(fCol0[I - 1], fCol0[I])
     else
      CompareResult:= fCol0[I - 1] > fCol0[I];
     while (CompareResult) do
     begin // OK
      fCol0.Exchange(I, I - 1);
      fCol1.Exchange(I, I - 1);
      if ThreeCols then
       fCol2.Exchange(I, I - 1);
      if I = 2 then break;
      Dec(I);
      if CompareFloat then
       CompareResult:= CompareFloatStr(fCol0[I - 1], fCol0[I])
      else
       CompareResult:= fCol0[I - 1] > fCol0[I];
     end;
    end;
   end;
   aStringGrid.Cols[aCol].Assign(fCol0);
   case aCol of
    0:
     begin
      aStringGrid.Cols[1].Assign(fCol1);
      if ThreeCols then
       aStringGrid.Cols[2].Assign(fCol2);
     end;
    1:
     begin
      aStringGrid.Cols[0].Assign(fCol1);
      if ThreeCols then
       aStringGrid.Cols[2].Assign(fCol2);
     end;
    2:
     begin
      aStringGrid.Cols[0].Assign(fCol1);
      if ThreeCols then
       aStringGrid.Cols[1].Assign(fCol2);
     end;
   end;
  end;
 except
//
 end;
end;

procedure T_FormEditNuclide.SpeedButtonChainClick(Sender: TObject);
var
 FormChainNKEPos: TPoint;
begin
 if fAttachedState <> nil then
  if not IsStableState(fAttachedState) then
  begin
   FormChainNKEPos.Y:= 2;
   FormChainNKEPos.X:= Self.Width;
   FormChainNKEPos:= Self.ClientToScreen(FormChainNKEPos);
   if (FormChainNKEPos.X < (Screen.Width div 2)) then // if Docked Self.Left=0
    FormChainNKEPos.X:= FormChainNKEPos.X + 2
   else
    FormChainNKEPos.X:= FormChainNKEPos.X - _FormChainNKE.Width - Self.Width - 2;
   _FormChainNKE.Left:= FormChainNKEPos.X;
   _FormChainNKE.Top:= FormChainNKEPos.Y;
   _FormChainNKE.MamaThZpA_s:= fAttachedState.ThZpA_s;
   _FormChainNKE.Show;
  end
  else
   MessageDlg('No decay chain', mtWarning, [mbOK], 0);
end;

end.

