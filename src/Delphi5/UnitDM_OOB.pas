unit UnitDM_OOB;

interface

uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
 extctrls, comctrls,
 NuclideClasses, ChainClasses, EuLib, DM_OOD, Objects;

type
 T_DataModuleOOB = class(TDataModule)
  procedure DataModuleCreate(Sender: TObject);
  procedure DataModuleDestroy(Sender: TObject);
 private
    { Private declarations }
  fVStorage: TVStorage;
  fVStream: TVStream;
  fLoadInProgress: Boolean;
  fDataBaseFileName: string;
  fVStates: TVStateColl;
  fVElements: TVElementColl;
  fVDecays: TVDecayColl;
  fVAbundances: TVAbundanceColl;
  fVSigmaFs: TVSigmaFColl;
  fVSigmaThresholds: TVSigmaThresholdColl;
  fVRIFs: TVRIFColl;
  fVSigmaCs: TVSigmaCColl;
  fVRIs: TVRIColl;
  fVYieldTs: TVYieldTColl;
  fVYieldFs: TVYieldFColl;
  fVAlphas: TVAlphaColl;
  fVGammas: TVGammaColl;
  fVElectrons: TVElectronColl;
  fVBetas: TVBetaColl;
  fVPositrons: TVPositronColl;
  fVSubBranchings: TVSubBranchingColl;
  fVFastFissions: TVFastFissionColl;
  fVSpecialCaptureCases: TVSpecialCaptureCaseColl;
  function GetDataBaseName: string;
  procedure SetDatabaseName(aDatabaseName: string);
 public
  OpenDialog: TOpenDialog;
  PanelDatabaseName: TPanel;
  procedure SetDatabaseNameNotLoadDetails(aDatabaseName: string);
  property VFastFissions: TVFastFissionColl read fVFastFissions;
  property VSubBranchings: TVSubBranchingColl read fVSubBranchings;
  property VSpecialCaptureCases: TVSpecialCaptureCaseColl read fVSpecialCaptureCases;
  function LoadAll: Boolean;
  function LoadStates: integer;
  function LoadAbundances: integer;
  function LoadSigmaCs: integer;
  function LoadRIs: integer;
  function LoadSigmaFs: integer;
  function LoadSigmaThreshold: integer;
  function LoadRIfs: integer;
  function LoadElements: integer;
  function LoadDecays: integer;
  function LoadYieldTs: integer;
  function LoadYieldFs: integer;
  function LoadAlphas: integer;
  function LoadBetas: integer;
  function LoadGammas: integer;
  function LoadElectrons: integer;
  function LoadPositrons: integer;
  function LoadSubBranchings: integer;
  function LoadFastFissions: integer;
  function LoadSpecialCaptureCases: integer;
  constructor Create(AOwner: TComponent); override;
  function ReadSubBranchingList(const ThZpA_s: integer; var aSubBranchingList: TSubBranchingList): Boolean;
  function ReadSpecialCaptureDetail(const aParentThZpA_s, aChildThZpA_s: integer; var aVarSigma, aVarG_factor, aVarRI: float): Boolean;
  function ReadSpecialCaptureTotal(const aThZpA_s: integer; var aVarSigma, aVarRI: float): Boolean;
  procedure AfterCreate;
  function ReadChain(var Chain: TChain; const Options: DWORD = 1): Boolean; //1-Basic
  function DeleteNuclide(const ThZpAdel: integer): Boolean;
  function ReadNuclide(var Nuclide: TNuclide; const Options: DWORD = $0041): Boolean; //1-nloBasic  $0040- nloSigmaThreshold
  function WriteNuclide(const Nuclide: TNuclide; const Options: DWORD = 3; //3=(nloBasic or nloRI);
   const ProgressBar: TProgressBar = nil; const IsDebug: Boolean = False): Boolean;
  function ReadNuclideList(var NuclideList: TNuclideList;
   ProgressBar: TProgressBar = nil; const WhereStr: AnsiString = ''): Boolean;
  function ReadElementList(var ElementList: TElementList; ProgressBar: TProgressBar = nil): Boolean;
  function ReadCaptureProductStateInfo(const Nuclide: TNuclide; var CountFounded, Max, Min: integer): Boolean;
  function ReadDecayModeList(var DecayModes: TStringList): Boolean;
  function ReadHasFissionProductList(var HasFissionProductList: TStringList): Boolean;
  function ReadFissionProductAmassMin(var FissionProductZnumList, FissionProductAmassMinList: TLongIntList): Boolean;
  function GetSymbol(var aStr: string; InitZnum: integer): Boolean;
  function LoadFissionProducts(const aThZpA_s: integer; TheFissionProducts: TLongIntList): Boolean;
  function LoadSpecialCaptureProducts(const aThZpA_s: integer; TheCaptureProducts: TLongIntList): Boolean;
  function GetSigmaFastFissionForThZpA_s(const aThZpA_s: integer): Float;
  property DatabaseName: string read GetDataBaseName write SetDataBaseName;
  property LoadInProgress: Boolean read fLoadInProgress;
// add for SubBranching from Magnolia
  function ReadSubBranchingRecordList(var aSubBranchingRecordList: TSubBranchingRecordList): Boolean;
 end;
 
var
 _DataModuleOOB: T_DataModuleOOB;
 
implementation
{$R *.DFM}
//uses
// DM_OOD, Objects;
(*
var
 VStorage: TVStorage;
 VStream: TVStream;
*)
{ T_DataModuleOOB }

procedure T_DataModuleOOB.AfterCreate;
var
 BaseFileName: string;
begin
{$IFDEF RELEASE}
 if FileExists(GetCurrentDir + 'ORIP_XXI.oob') then // more flexible, can use SetCurrentDir
  BaseFileName:= GetCurrentDir + 'ORIP_XXI.oob'
 else if FileExists('ORIP_XXI.oob') then
  BaseFileName:= 'ORIP_XXI.oob'
 else if FileExists(ExtractFilePath(Application.ExeName) + 'ORIP_XXI.oob') then
  BaseFileName:= ExtractFilePath(Application.ExeName) + 'ORIP_XXI.oob';
// MessageDlg('BaseFileName (UnitDM_OOB 109 )= '+BaseFileName, mtWarning, [mbOK], 0);
 DatabaseName:= BaseFileName;
{$ELSE}
 if FileExists('Debug.del') then
  BaseFileName:= 'test01.oob'
 else
  BaseFileName:= 'ORIP_XXI.oob';
 DatabaseName:= BaseFileName;
{$ENDIF}
 PanelDatabaseName:= nil;
end;

function T_DataModuleOOB.GetDataBaseName: string;
begin
 Result:= fDataBaseFileName;
end;

function T_DataModuleOOB.LoadAll: Boolean;
begin
 fLoadInProgress:= True;
 try
  try
   LoadStates;
   LoadAbundances;
   LoadSigmaCs;
   LoadRIs;
   LoadSigmaFs;
   LoadRIfs;
   LoadElements;
   LoadDecays;
   LoadSigmaThreshold;
   LoadYieldTs;
   LoadYieldFs;
   LoadAlphas;
   LoadBetas;
   LoadGammas;
   LoadElectrons;
   LoadPositrons;
   LoadSubBranchings;
   LoadFastFissions;
   LoadSpecialCaptureCases;
   Result:= True;
  except
   Result:= False;
  end;
 finally
  fLoadInProgress:= False;
 end;
end;

procedure T_DataModuleOOB.SetDatabaseNameNotLoadDetails(aDatabaseName: string);
begin
 if (fDataBaseFileName <> aDatabaseName) then
  if FileExists(aDatabaseName) then
  begin
   if fVStorage <> nil then
    if fVStorage.Count > 0 then // or problems in Free
     fVStorage.Free; // Frees Stream itself
   fVStream:= TVStream.Create;
   fVStream.OpenFile(aDatabaseName, fmOpenExclusive);
   fVStorage:= TVStorage.Create(fVStream);
   fDataBaseFileName:= aDatabaseName;
   fVStream.CloseFile;
   if fVStates = nil then
    fVStates:= TVStateColl.Create;
   if fVElements = nil then
    fVElements:= TVElementColl.Create;
   LoadStates;
   LoadElements;
   Application.ProcessMessages;
  end
  else if OpenDialog.Execute then
  begin
   SetDataBaseName(OpenDialog.FileName);
   LoadStates;
  end;
 if (PanelDatabaseName <> nil) then
  with PanelDatabaseName do
  begin
   Caption:= fDataBaseFileName;
  end;
end;

procedure T_DataModuleOOB.SetDatabaseName(aDatabaseName: string);
begin
 if (fDataBaseFileName <> aDatabaseName) then
  if FileExists(aDatabaseName) then
  begin
   if fVStorage <> nil then
    if fVStorage.Count > 0 then // or problems in Free
     fVStorage.Free; // Frees Stream itself
   fVStream:= TVStream.Create;
   fVStream.OpenFile(aDatabaseName, fmOpenExclusive);
   fVStorage:= TVStorage.Create(fVStream);
   fDataBaseFileName:= aDatabaseName;
   fVStream.CloseFile;
// qqqq
// Problem: Bad file loading nills Collections
   if fVStates = nil then
    fVStates:= TVStateColl.Create;
   if fVAbundances = nil then
    fVAbundances:= TVAbundanceColl.Create;
   if fVElements = nil then
    fVElements:= TVElementColl.Create;
   if fVDecays = nil then
   begin
    fVDecays:= TVDecayColl.Create;
    fVDecays.Owner:= fVStates;
   end;
   if fVSigmaFs = nil then
    fVSigmaFs:= TVSigmaFColl.Create;
   if fVRIFs = nil then
    fVRIFs:= TVRIfColl.Create;
   if fVSigmaCs = nil then
    fVSigmaCs:= TVSigmaCColl.Create;
   if fVSigmaThresholds = nil then
    fVSigmaThresholds:= TVSigmaThresholdColl.Create;
   if fVRIs = nil then
    fVRIs:= TVRIColl.Create;
   if fVYieldTs = nil then
    fVYieldTs:= TVYieldTColl.Create;
   if fVYieldFs = nil then
    fVYieldFs:= TVYieldFColl.Create;
   if fVAlphas = nil then
    fVAlphas:= TVAlphaColl.Create;
   if fVGammas = nil then
    fVGammas:= TVGammaColl.Create;
   if fVElectrons = nil then
    fVElectrons:= TVElectronColl.Create;
   if fVBetas = nil then
    fVBetas:= TVBetaColl.Create;
   if fVPositrons = nil then
    fVPositrons:= TVPositronColl.Create;
   if fVSubBranchings = nil then
    fVSubBranchings:= TVSubBranchingColl.Create;
   if fVFastFissions = nil then
    fVFastFissions:= TVFastFissionColl.Create;
   if fVSpecialCaptureCases = nil then
    fVSpecialCaptureCases:= TVSpecialCaptureCaseColl.Create;
// qqqq end
   LoadAll;
   Application.ProcessMessages;
  end
  else if OpenDialog.Execute then
  begin
   SetDataBaseName(OpenDialog.FileName);
   LoadAll;
  end;
 if (PanelDatabaseName <> nil) then
  with PanelDatabaseName do
  begin
   Caption:= fDataBaseFileName;
  end;
end;
(*
procedure T_DataModuleOOB.SetDatabaseName(aDatabaseName: string);
begin
 if (fDataBaseFileName<>aDatabaseName) then
  if FileExists(aDatabaseName) then begin
   if VStorage<>nil then
    VStorage.Free;
   if VStream<>nil then
    VStream.Free;
   VStream:= TVStream.Create;
   VStream.OpenFile(aDatabaseName, fmOpenExclusive);
   VStorage:= TVStorage.Create(VStream);
   fDataBaseFileName:= aDatabaseName;
   VStream.CloseFile;
   LoadAll;
   Application.ProcessMessages;
  end
  else
   if OpenDialog.Execute then begin
    SetDataBaseName(OpenDialog.FileName);
    LoadAll;
   end;
 if (PanelDatabaseName<>nil) then
  with PanelDatabaseName do begin
   Caption:= fDataBaseFileName;
  end;
end;
*)

procedure T_DataModuleOOB.DataModuleCreate(Sender: TObject);
begin
 fDataBaseFileName:= '';
 OpenDialog:= TOpenDialog.Create(Self);
 OpenDialog.Filter:= 'Object Oriented Base (*.oob)|*.oob';
 OpenDialog.FilterIndex:= 1;
 OpenDialog.InitialDir:= ExtractFilePath(Application.ExeName);
 OpenDialog.Options:= OpenDialog.Options + [ofFileMustExist];
 fVStates:= TVStateColl.Create;
 fVAbundances:= TVAbundanceColl.Create;
 fVElements:= TVElementColl.Create;
 fVDecays:= TVDecayColl.Create;
 fVDecays.Owner:= fVStates;
 fVSigmaFs:= TVSigmaFColl.Create;
 fVRIFs:= TVRIfColl.Create;
 fVSigmaCs:= TVSigmaCColl.Create;
 fVSigmaThresholds:= TVSigmaThresholdColl.Create;
 fVRIs:= TVRIColl.Create;
 fVYieldTs:= TVYieldTColl.Create;
 fVYieldFs:= TVYieldFColl.Create;
 fVAlphas:= TVAlphaColl.Create;
 fVGammas:= TVGammaColl.Create;
 fVElectrons:= TVElectronColl.Create;
 fVBetas:= TVBetaColl.Create;
 fVPositrons:= TVPositronColl.Create;
 fVSubBranchings:= TVSubBranchingColl.Create;
 fVFastFissions:= TVFastFissionColl.Create;
 fVSpecialCaptureCases:= TVSpecialCaptureCaseColl.Create;
 fVStream:= nil;
 fVStorage:= nil;
(*
 VStream:= nil;
 VStorage:= nil;
*)
end;

function T_DataModuleOOB.LoadStates: integer;
begin
 Result:= -1;
 try
  if fVStates <> nil then
   with fVStates do
   begin
    DeactivateAllIndexes;
    ClearAndFreeItems;
    LoadStorageObject(fDataBaseFileName, rg_TVStateColl, fVStates);
    Result:= Count;
    UpdateIndexes;
    ActivateAllIndexes;
    CurrIndex:= GetIndexRec('Number'); //==IndexBy_ThZpA_s
   end;
 except
  Result:= -1;
 end;
end;

function T_DataModuleOOB.LoadAbundances: integer;
begin
 Result:= -1;
 try
  if fVAbundances <> nil then
   with fVAbundances do
   begin
    DeactivateAllIndexes;
    ClearAndFreeItems;
    LoadStorageObject(fDataBaseFileName, rg_TVAbundanceColl, fVAbundances);
    Result:= Count;
    UpdateIndexes;
    ActivateAllIndexes;
    CurrIndex:= GetIndexRec('Number'); //==IndexBy_ThZpA
   end;
 except
  Result:= -1;
 end;
end;

function T_DataModuleOOB.LoadAlphas: integer;
begin
 Result:= -1;
 try
  if fVAlphas <> nil then
   with fVAlphas do
   begin
    DeactivateAllIndexes;
    ClearAndFreeItems;
    LoadStorageObject(fDataBaseFileName, rg_TVAlphaColl, fVAlphas);
    Result:= Count;
    UpdateIndexes;
    ActivateAllIndexes;
    CurrIndex:= GetIndexRec('IndexBy_ThZpA_s'); //==IndexBy_ThZpA_s
   end;
 except
  Result:= -1;
 end;
end;

function T_DataModuleOOB.LoadBetas: integer;
begin
 Result:= -1;
 try
  if fVBetas <> nil then
   with fVBetas do
   begin
    DeactivateAllIndexes;
    ClearAndFreeItems;
    LoadStorageObject(fDataBaseFileName, rg_TVBetaColl, fVBetas);
    Result:= Count;
    UpdateIndexes;
    ActivateAllIndexes;
    CurrIndex:= GetIndexRec('IndexBy_ThZpA_s'); //==IndexBy_ThZpA_s
   end;
 except
  Result:= -1;
 end;
end;

function T_DataModuleOOB.LoadDecays: integer;
begin
 Result:= -1;
 try
  if fVDecays <> nil then
   with fVDecays do
   begin
    DeactivateAllIndexes;
    ClearAndFreeItems;
    LoadStorageObject(fDataBaseFileName, rg_TVDecayColl, fVDecays);
    Result:= Count;
    UpdateIndexes;
    ActivateAllIndexes;
    CurrIndex:= GetIndexRec('IndexBy_ThZpA_s'); //==IndexBy_ThZpA_s
   end;
 except
  Result:= -1;
 end;
end;

function T_DataModuleOOB.LoadElectrons: integer;
begin
 Result:= -1;
 try
  if fVElectrons <> nil then
   with fVElectrons do
   begin
    DeactivateAllIndexes;
    ClearAndFreeItems;
    LoadStorageObject(fDataBaseFileName, rg_TVElectronColl, fVElectrons);
    Result:= Count;
    UpdateIndexes;
    ActivateAllIndexes;
    CurrIndex:= GetIndexRec('IndexBy_ThZpA_s'); //==IndexBy_ThZpA_s
   end;
 except
  Result:= -1;
 end;
end;

function T_DataModuleOOB.LoadElements: integer;
begin
 Result:= -1;
 try
  if fVElements <> nil then
   with fVElements do
   begin
    DeactivateAllIndexes;
    ClearAndFreeItems;
    LoadStorageObject(fDataBaseFileName, rg_TVElementColl, fVElements);
    Result:= Count;
    UpdateIndexes;
    ActivateAllIndexes;
    CurrIndex:= GetIndexRec('Number'); //==Znum
   end;
 except
  Result:= -1;
 end;
end;

function T_DataModuleOOB.LoadGammas: integer;
begin
 Result:= -1;
 try
  if fVGammas <> nil then
   with fVGammas do
   begin
    DeactivateAllIndexes;
    ClearAndFreeItems;
    LoadStorageObject(fDataBaseFileName, rg_TVGammaColl, fVGammas);
    Result:= Count;
    UpdateIndexes;
    ActivateAllIndexes;
    CurrIndex:= GetIndexRec('IndexBy_ThZpA_s'); //==IndexBy_ThZpA_s
   end;
 except
  Result:= -1;
 end;
end;

function T_DataModuleOOB.LoadPositrons: integer;
begin
 Result:= -1;
 try
  if fVPositrons <> nil then
   with fVPositrons do
   begin
    DeactivateAllIndexes;
    ClearAndFreeItems;
    LoadStorageObject(fDataBaseFileName, rg_TVPositronColl, fVPositrons);
    Result:= Count;
    UpdateIndexes;
    ActivateAllIndexes;
    CurrIndex:= GetIndexRec('IndexBy_ThZpA_s'); //==IndexBy_ThZpA_s
   end;
 except
  Result:= -1;
 end;
end;

function T_DataModuleOOB.LoadRIfs: integer;
begin
 Result:= -1;
 try
  if fVRIFs <> nil then
   with fVRIFs do
   begin
    DeactivateAllIndexes;
    ClearAndFreeItems;
    LoadStorageObject(fDataBaseFileName, rg_TVRIfColl, fVRIFs);
    Result:= Count;
    UpdateIndexes;
    ActivateAllIndexes;
    CurrIndex:= GetIndexRec('Number'); //==IndexBy_ThZpA
   end;
 except
  Result:= -1;
 end;
end;

function T_DataModuleOOB.LoadRIs: integer;
begin
 Result:= -1;
 try
  if fVRIs <> nil then
   with fVRIs do
   begin
    DeactivateAllIndexes;
    ClearAndFreeItems;
    LoadStorageObject(fDataBaseFileName, rg_TVRIColl, fVRIs);
    Result:= Count;
    UpdateIndexes;
    ActivateAllIndexes;
    CurrIndex:= GetIndexRec('IndexBy_ThZpA_s'); //==IndexBy_ThZpA_s
   end;
 except
  Result:= -1;
 end;
end;

function T_DataModuleOOB.LoadSigmaCs: integer;
begin
 Result:= -1;
 try
  if fVSigmaCs <> nil then
   with fVSigmaCs do
   begin
    DeactivateAllIndexes;
    ClearAndFreeItems;
    LoadStorageObject(fDataBaseFileName, rg_TVSigmaCColl, fVSigmaCs);
    Result:= Count;
    UpdateIndexes;
    ActivateAllIndexes;
    CurrIndex:= GetIndexRec('IndexBy_ThZpA_s'); //==IndexBy_ThZpA_s
   end;
 except
  Result:= -1;
 end;
end;

function T_DataModuleOOB.LoadSigmaFs: integer;
begin
 Result:= -1;
 try
  if fVSigmaFs <> nil then
   with fVSigmaFs do
   begin
    DeactivateAllIndexes;
    ClearAndFreeItems;
    LoadStorageObject(fDataBaseFileName, rg_TVSigmaFColl, fVSigmaFs);
    Result:= Count;
    UpdateIndexes;
    ActivateAllIndexes;
    CurrIndex:= GetIndexRec('Number'); //==IndexBy_ThZpA
   end;
 except
  Result:= -1;
 end;
end;

function T_DataModuleOOB.LoadSigmaThreshold: integer;
begin
 Result:= -1;
 try
  if fVSigmaThresholds <> nil then
   with fVSigmaThresholds do
   begin
    DeactivateAllIndexes;
    ClearAndFreeItems;
    LoadStorageObject(fDataBaseFileName, rg_TVSigmaThresholdColl, fVSigmaThresholds);
    Result:= Count;
    UpdateIndexes;
    ActivateAllIndexes;
    CurrIndex:= GetIndexRec('Number'); //==IndexBy_ThZpA_s
   end;
 except
  Result:= -1;
 end;
end;

function T_DataModuleOOB.LoadSubBranchings: integer;
begin
 fLoadInProgress:= True;
 Result:= -1;
 try
  if fVSubBranchings <> nil then
   with fVSubBranchings do
   begin
    DeactivateAllIndexes;
    ClearAndFreeItems;
    LoadStorageObject(fDataBaseFileName, rg_TVSubBranchingColl, fVSubBranchings);
    Result:= Count;
    UpdateIndexes;
    ActivateAllIndexes;
    CurrIndex:= GetIndexRec('IndexBy_ThZpA_s'); //==IndexBy_ThZpA_s
   end;
 except
  Result:= -1;
 end;
 fLoadInProgress:= False;
end;

function T_DataModuleOOB.LoadFastFissions: integer;
begin
 Result:= -1;
 try
  if fVFastFissions <> nil then
   with fVFastFissions do
   begin
    DeactivateAllIndexes;
    ClearAndFreeItems;
    LoadStorageObject(fDataBaseFileName, rg_TVFastFissionColl, fVFastFissions);
    Result:= Count;
    UpdateIndexes;
    ActivateAllIndexes;
    CurrIndex:= GetIndexRec('Number'); //==IndexBy_ThZpA
   end;
 except
  Result:= -1;
 end;
end;

function T_DataModuleOOB.LoadSpecialCaptureCases: integer;
begin
 Result:= -1;
 try
  if fVSpecialCaptureCases <> nil then
   with fVSpecialCaptureCases do
   begin
    DeactivateAllIndexes;
    ClearAndFreeItems;
    LoadStorageObject(fDataBaseFileName, rg_TVSpecialCaptureCaseColl, fVSpecialCaptureCases);
    Result:= Count;
    UpdateIndexes;
    ActivateAllIndexes;
    CurrIndex:= GetIndexRec('IndexBy_ParentThZpA_s'); //==IndexBy_ParentThZpA_s
   end;
 except
  Result:= -1;
 end;
end;

function T_DataModuleOOB.LoadYieldFs: integer;
begin
 Result:= -1;
 try
  if fVYieldFs <> nil then
   with fVYieldFs do
   begin
    DeactivateAllIndexes;
    ClearAndFreeItems;
    LoadStorageObject(fDataBaseFileName, rg_TVYieldFColl, fVYieldFs);
    Result:= Count;
    UpdateIndexes;
    ActivateAllIndexes;
    CurrIndex:= GetIndexRec('IndexBy_ProductThZpA_s'); //==IndexBy_ProductThZpA_s
   end;
 except
  Result:= -1;
 end;
end;

function T_DataModuleOOB.LoadYieldTs: integer;
begin
 Result:= -1;
 try
  if fVYieldTs <> nil then
   with fVYieldTs do
   begin
    DeactivateAllIndexes;
    ClearAndFreeItems;
    LoadStorageObject(fDataBaseFileName, rg_TVYieldTColl, fVYieldTs);
    Result:= Count;
    UpdateIndexes;
    ActivateAllIndexes;
    CurrIndex:= GetIndexRec('IndexBy_ProductThZpA_s'); //==Index_ByProductThZpA_s
   end;
 except
  Result:= -1;
 end;
end;

(*
function T_DataModuleOOB.ReadSubBranching(var aNucData: TNucData): Boolean;
var
 aThZpA_s, CountDetail, FirstDetail, K: integer;
 aSubBranching: TSubBranching;
begin
// MessageDlg('ReadSubBranching TODO_IT', mtInformation, [mbOK], 0);
// NEVER TRYED
 try
  with aNucData, fVSubBranchings do begin
   aThZpA_s:= 10*(1000*aNucData.Znum+aNucData.Amass)+aNucData.State;
   CurrIndex:= GetIndexRec('IndexBy_ThZpA_s');
   CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
   for K:= FirstDetail to FirstDetail+CountDetail-1 do begin
    if (StrToDecayType(TVSubBranching(fVSubBranchings[K]).SubBranchingName)<>dtNone) then begin
     aSubBranching.DecayType:= StrToDecayType(TVSubBranching(fVSubBranchings[K]).SubBranchingName);
     if (TVSubBranching(fVSubBranchings[K]).BranchingToG>0) then
      aSubBranching.BranchingToG:= TVSubBranching(fVSubBranchings[K]).BranchingToG
     else
      aSubBranching.BranchingToG:= 0;
     if (TVSubBranching(fVSubBranchings[K]).BranchingToG>0) then
      aSubBranching.BranchingToG:= TVSubBranching(fVSubBranchings[K]).BranchingToG
     else
      aSubBranching.BranchingToG:= 0;
     if (TVSubBranching(fVSubBranchings[K]).BranchingToM1>0) then
      aSubBranching.BranchingToM1:= TVSubBranching(fVSubBranchings[K]).BranchingToM1
     else
      aSubBranching.BranchingToM1:= 0;
     if (TVSubBranching(fVSubBranchings[K]).BranchingToM2>0) then
      aSubBranching.BranchingToM2:= TVSubBranching(fVSubBranchings[K]).BranchingToM2
     else
      aSubBranching.BranchingToM2:= 0;

    end;
    aNucData.SubBranchings.Add(aSubBranching);
   end;
  end;
  Result:= True;
 except
  Result:= False;
 end;
end;
*)

function T_DataModuleOOB.ReadChain(var Chain: TChain;
 const Options: DWORD): Boolean;
begin
 MessageDlg('ReadChain TODO_IT', mtInformation, [mbOK], 0);
 Result:= True;
end;

function T_DataModuleOOB.DeleteNuclide(const ThZpAdel: integer): Boolean;
begin
 MessageDlg('DeleteNuclide wil NOT be implemented in OOB', mtInformation, [mbOK], 0);
 Result:= True;
end;

function T_DataModuleOOB.ReadNuclide(var Nuclide: TNuclide;
 const Options: DWORD): Boolean;
// NEVER TRYED
var
 aThZpA, aThZpA_s, aYieldParentThZpA, InListNo, I, J, K, L: integer;
 aNuclide: TNuclide;
 aNuclideState: TNuclideState;
 aCapture: TCapture;
 aRI: TRI;
 aDecay: TDecay;
 aAlpha: TAlpha;
 aBeta: TBeta;
 aGamma: TGamma;
 aElectron: TElectron;
 aPositron: TPositron;
 aYield: TYield;
 CaptureFound, DiffrentCaptureValuesFound,
  DecayFound, DiffrentDecayValuesFound, InSateList: Boolean;
 CountFounded, FirstFounded, CountDetail, FirstDetail: integer;
begin
// NEVER TRYED
// MessageDlg('ReadNuclide TODO_IT #3', mtInformation, [mbOK], 0);
 if Nuclide <> nil then
 begin
  try
   aThZpA:= 1000 * Nuclide.Znum + Nuclide.Amass;
   with fVElements do
    CurrIndex:= GetIndexRec('Number');
   with fVStates do
    CurrIndex:= GetIndexRec('Number');
   with fVAbundances do
    CurrIndex:= GetIndexRec('Number'); // ThZpA
   with fVDecays do
    CurrIndex:= GetIndexRec('IndexBy_ThZpA_s'); //IndexBy_ThZpA_s
   with fVSigmaFs do
    CurrIndex:= GetIndexRec('Number'); //IndexBy_ThZpA_s
   with fVRIFs do
    CurrIndex:= GetIndexRec('Number'); //IndexBy_ThZpA_s
   with fVSigmaThresholds do
    CurrIndex:= GetIndexRec('Number'); //IndexBy_ThZpA_s
   with fVSigmaCs do
    CurrIndex:= GetIndexRec('IndexBy_ThZpA_s');
   with fVRIs do
    CurrIndex:= GetIndexRec('IndexBy_ThZpA_s');
   with fVAlphas do
    CurrIndex:= GetIndexRec('IndexBy_ThZpA_s');
   with fVBetas do
    CurrIndex:= GetIndexRec('IndexBy_ThZpA_s');
   with fVGammas do
    CurrIndex:= GetIndexRec('IndexBy_ThZpA_s');
   with fVElectrons do
    CurrIndex:= GetIndexRec('IndexBy_ThZpA_s');
   with fVPositrons do
    CurrIndex:= GetIndexRec('IndexBy_ThZpA_s');
   with fVYieldTs do
    CurrIndex:= GetIndexRec('IndexBy_ProductThZpA_s');
   with fVYieldFs do
    CurrIndex:= GetIndexRec('IndexBy_ProductThZpA_s');

   for I:= 0 to fVStates.Count - 1 do
    if (TVState(fVStates[I]).ThZpA_s div 10) = (aThZpA) then
    begin // Read Nuclide

     aNuclide:= TNuclide.Create(aThZpA);
     with aNuclide do
     begin
      if fVElements.SearchNumberObj(aThZpA div 1000) <> nil then
       Symbol:= TVElement(fVElements.SearchNumberObj(aThZpA div 1000)).Symbol
      else
       Symbol:= NuclideClasses.Symbols[aThZpA div 1000];
      if fVAbundances.SearchNumberObj(aThZpA) <> nil then
       Abundance:= TVAbundance(fVAbundances.SearchNumberObj(aThZpA)).Abundance
      else
       Abundance:= 0;
      NuclideTag:= 0; // No details
      Application.ProcessMessages;
      with fVStates do
      begin
       CountFounded:= SelectRange_Integer(CurrIndex, aThZpA * 10, aThZpA * 10 + 2, FirstFounded);
       for J:= FirstFounded to FirstFounded + CountFounded - 1 do
       begin
        aNuclideState:= TNuclideState.Create(aNuclide);
        with aNuclideState, TVState(fVStates[J]) do
        begin
         aThZpA_s:= TVState(fVStates[J]).ThZpA_s;
         aNuclideState.State:= aThZpA_s mod 10;
         aNuclideState.T1_2:= TVState(fVStates[J]).T1_2;
         aNuclideState.SigmaF:= 0;
         aNuclideState.RIF:= 0;
//         aNuclideState.g_factor:= 1; // CapturesAdded
         aNuclideState.SigmaNP:= 0;
         aNuclideState.SigmaNA:= 0;
         aNuclideState.SigmaN2N:= 0;
         aNuclideState.SigmaNN:= 0;
         aNuclideState.SigmaNG:= 0;
         with fVSigmaFs do
          CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
         if CountDetail > 0 then
          aNuclideState.SigmaF:= TVSigmaF(fVSigmaFs[FirstDetail]).Sigma;
         with fVRIFs do
          CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
         if CountDetail > 0 then
          aNuclideState.RIF:= TVRIF(fVRIFs[FirstDetail]).RI;
         with fVSigmaThresholds do
         begin
          CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
          if CountDetail > 0 then
          begin
           if TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).SigmaNP > 0 then
            aNuclideState.SigmaNP:= TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).SigmaNP;
           if TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).SigmaNA > 0 then
            aNuclideState.SigmaNA:= TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).SigmaNA;
           if TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).SigmaN2N > 0 then
            aNuclideState.SigmaN2N:= TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).SigmaN2N;
           if TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).SigmaNG > 0 then
            aNuclideState.SigmaNG:= TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).SigmaNG;
           if TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).SigmaNN > 0 then
            aNuclideState.SigmaNN:= TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).SigmaNN;
           if TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).g_factor > 0 then // CapturesAdded
            aNuclideState.Captures.g_factor:= TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).g_factor;
          end
         end;
//    Captures
         with fVSigmaCs do
         begin
          CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
          if CountDetail > 0 then // CapturesAdded
           aNuclideState.Captures.G_factor:= TVSigmaC(fVSigmaCs[FirstDetail]).g_factor
          else
           aNuclideState.Captures.G_factor:= -1;
          for K:= FirstDetail to FirstDetail + CountDetail - 1 do
          begin
           if ((TVSigmaC(fVSigmaCs[K]).ProductState >= 0) and
            (TVSigmaC(fVSigmaCs[K]).ProductState <= 2)) then
           begin
            aCapture.ToState:= TVSigmaC(fVSigmaCs[K]).ProductState;
            if ((TVSigmaC(fVSigmaCs[K]).Sigma > 0)) then
             aCapture.Sigma:= TVSigmaC(fVSigmaCs[K]).Sigma
            else
             aCapture.Sigma:= 0;
            aNuclideState.Captures.Add(aCapture);
           end;
          end;
//    RIs
          with fVRIs do
          begin
           CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
           for K:= FirstDetail to FirstDetail + CountDetail - 1 do
           begin
            if ((TVRI(fVRIs[K]).ProductState >= 0) and
             (TVRI(fVRIs[K]).ProductState <= 2)) then
            begin
             aRI.ToState:= TVRI(fVRIs[K]).ProductState;
             if ((TVRI(fVRIs[K]).RI > 0)) then
              aRI.Value:= TVRI(fVRIs[K]).RI
             else
              aRI.Value:= 0;
             aNuclideState.RIs.Add(aRI);
            end;
           end;
          end;
// Decays
          with fVDecays do
          begin
           CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
           for K:= FirstDetail to FirstDetail + CountDetail - 1 do
           begin
            if (TVDecay(fVDecays[K]).DecayType <> dtNone) then
            begin
             aDecay.DecayType:= TVDecay(fVDecays[K]).DecayType;
             if (TVDecay(fVDecays[K]).Branching > 0) then
              aDecay.Branching:= TVDecay(fVDecays[K]).Branching
             else
              aDecay.Branching:= 0;
             aNuclideState.Decays.Add(aDecay);
            end;
           end;
          end;
// Alpas
          with fVAlphas do
          begin
           CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
           for K:= FirstDetail to FirstDetail + CountDetail - 1 do
           begin
            aAlpha.MeV:= TVAlpha(fVAlphas[K]).MeV;
            aAlpha.Probability:= TVAlpha(fVAlphas[K]).Probability;
            aNuclideState.Alphas.Add(aAlpha);
           end;
          end;
// Betas
          with fVBetas do
          begin
           CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
           for K:= FirstDetail to FirstDetail + CountDetail - 1 do
           begin
            aBeta.MeV:= TVBeta(fVBetas[K]).MeV;
            aBeta.MaxMeV:= TVBeta(fVBetas[K]).MaxMeV;
            aBeta.Probability:= TVBeta(fVBetas[K]).Probability;
            aNuclideState.Betas.Add(aBeta);
           end;
          end;
// Gammas
          with fVGammas do
          begin
           CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
           for K:= FirstDetail to FirstDetail + CountDetail - 1 do
           begin
            aGamma.MeV:= TVGamma(fVGammas[K]).MeV;
            aGamma.Probability:= TVGamma(fVGammas[K]).Probability;
            aNuclideState.Gammas.Add(aGamma);
           end;
          end;
// Electrons
          with fVElectrons do
          begin
           CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
           for K:= FirstDetail to FirstDetail + CountDetail - 1 do
           begin
            aElectron.MeV:= TVElectron(fVElectrons[K]).MeV;
            aElectron.Probability:= TVElectron(fVElectrons[K]).Probability;
            aNuclideState.Electrons.Add(aElectron);
           end;
          end;
// Positrons
          with fVPositrons do
          begin
           CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
           for K:= FirstDetail to FirstDetail + CountDetail - 1 do
           begin
            aPositron.MeV:= TVPositron(fVPositrons[K]).MeV;
            aPositron.MaxMeV:= TVPositron(fVPositrons[K]).MaxMeV;
            aPositron.Probability:= TVPositron(fVPositrons[K]).Probability;
            aNuclideState.Positrons.Add(aPositron);
           end;
          end;
// YieldT
          with fVYieldTs do
          begin
           CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
           for K:= FirstDetail to FirstDetail + CountDetail - 1 do
           begin
            aYield.ParentThZpA:= TVYield(fVYieldTs[K]).ThZpA_s div 10;
            aYield.CumYieldT:= TVYield(fVYieldTs[K]).CumYield;
            aYield.IndYieldT:= TVYield(fVYieldTs[K]).IndYield;
            aYield.CumYieldF:= 0;
            aYield.IndYieldF:= 0;
            aNuclideState.Yields.Add(aYield);
           end;
          end;
// YieldF
          with fVYieldFs do
          begin
           CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
           for K:= FirstDetail to FirstDetail + CountDetail - 1 do
           begin
            aYieldParentThZpA:= TVYield(fVYieldFs[K]).ThZpA_s div 10;
            InListNo:= -1;
            for L:= 0 to aNuclideState.Yields.Count - 1 do
             if aNuclideState.Yields[L].ParentThZpA = aYieldParentThZpA then
             begin
              InListNo:= L;
              break;
             end;
            if InListNo >= 0 then
             with Yields[InListNo] do
             begin
              aYield:= aNuclideState.Yields[InListNo];
              aYield.CumYieldF:= TVYield(fVYieldFs[K]).CumYield;
              aYield.IndYieldF:= TVYield(fVYieldFs[K]).IndYield;
              aNuclideState.Yields[InListNo]:= aYield;
             end
            else
            begin
             aYield.ParentThZpA:= aYieldParentThZpA;
             aYield.CumYieldT:= 0;
             aYield.IndYieldT:= 0;
             aYield.CumYieldF:= TVYield(fVYieldFs[K]).CumYield;
             aYield.IndYieldF:= TVYield(fVYieldFs[K]).IndYield;
             aNuclideState.Yields.Add(aYield);
            end;
           end;
          end;

         end;
         aNuclide.NuclideTag:= nloBasic or nloRI or
          nloGamma or nloBeta or nloAlpha or nloElectron or nloPositron or nloYield;
         aNuclide.StateList.Add(aNuclideState);
        end;
       end;
      end;
     end;
     Nuclide.Assign(aNuclide);
    end;
   Result:= True;
  except
   Result:= False;
  end;
 end;
end;

function T_DataModuleOOB.WriteNuclide(const Nuclide: TNuclide;
 const Options: DWORD; const ProgressBar: TProgressBar;
 const IsDebug: Boolean): Boolean;
begin
 MessageDlg('WriteNuclide wil NOT be implemented in OOB', mtInformation, [mbOK], 0);
 Result:= True;
end;

function T_DataModuleOOB.ReadNuclideList(var NuclideList: TNuclideList;
 ProgressBar: TProgressBar; const WhereStr: AnsiString): Boolean;
var
 aThZpA, aThZpA_s, aYieldParentThZpA, InListNo, I, J, K, L: integer;
 aNuclide: TNuclide;
 aNuclideState: TNuclideState;
 aCapture: TCapture;
 aRI: TRI;
 aDecay: TDecay;
 aAlpha: TAlpha;
 aBeta: TBeta;
 aGamma: TGamma;
 aElectron: TElectron;
 aPositron: TPositron;
 aYield: TYield;
 CaptureFound, DiffrentCaptureValuesFound,
  DecayFound, DiffrentDecayValuesFound, InSateList: Boolean;
 CountFounded, FirstFounded, CountDetail, FirstDetail: integer;
begin
 if (PanelDatabaseName <> nil) then
  PanelDatabaseName.Caption:= DatabaseName;
 if ProgressBar <> nil then
  ProgressBar.Position:= ProgressBar.Min;
 for I:= 0 to NuclideList.Count - 1 do
  NuclideList[I].Free;
 NuclideList.Clear;
 try
  with fVElements do
  begin
   CurrIndex:= GetIndexRec('Number');
   if ProgressBar <> nil then
    with ProgressBar do
    begin
     ProgressBar.Max:= TVElement(fVElements[fVElements.Count - 1]).Number + 1;
     ProgressBar.Min:= TVElement(fVElements[0]).Number;
    end;
  end;
  with fVStates do
  begin
   CurrIndex:= GetIndexRec('Number');
  end;
  with fVAbundances do
   CurrIndex:= GetIndexRec('Number'); // ThZpA
  with fVDecays do
   CurrIndex:= GetIndexRec('IndexBy_ThZpA_s'); //IndexBy_ThZpA_s
  with fVSigmaFs do
   CurrIndex:= GetIndexRec('Number'); //IndexBy_ThZpA_s
  with fVRIFs do
   CurrIndex:= GetIndexRec('Number'); //IndexBy_ThZpA_s
  with fVSigmaThresholds do
   CurrIndex:= GetIndexRec('Number'); //IndexBy_ThZpA_s
  with fVSigmaCs do
   CurrIndex:= GetIndexRec('IndexBy_ThZpA_s');
  with fVRIs do
   CurrIndex:= GetIndexRec('IndexBy_ThZpA_s');
  with fVAlphas do
   CurrIndex:= GetIndexRec('IndexBy_ThZpA_s');
  with fVBetas do
   CurrIndex:= GetIndexRec('IndexBy_ThZpA_s');
  with fVGammas do
   CurrIndex:= GetIndexRec('IndexBy_ThZpA_s');
  with fVElectrons do
   CurrIndex:= GetIndexRec('IndexBy_ThZpA_s');
  with fVPositrons do
   CurrIndex:= GetIndexRec('IndexBy_ThZpA_s');
  with fVYieldTs do
   CurrIndex:= GetIndexRec('IndexBy_ProductThZpA_s');
  with fVYieldFs do
   CurrIndex:= GetIndexRec('IndexBy_ProductThZpA_s');
  for I:= 0 to fVStates.Count - 1 do
  begin
   aThZpA:= TVState(fVStates[I]).ThZpA_s div 10; // Read Nuclide
   if NuclideList.FindInList(aThZpA div 1000, aThZpA mod 1000) < 0 then
   begin // qq
    aNuclide:= TNuclide.Create(aThZpA);
    with aNuclide do
    begin
     if fVElements.SearchNumberObj(aThZpA div 1000) <> nil then
      Symbol:= TVElement(fVElements.SearchNumberObj(aThZpA div 1000)).Symbol
     else
      Symbol:= NuclideClasses.Symbols[aThZpA div 1000];
     if fVAbundances.SearchNumberObj(aThZpA) <> nil then
      Abundance:= TVAbundance(fVAbundances.SearchNumberObj(aThZpA)).Abundance
     else
      Abundance:= 0;
     NuclideTag:= 0; // No details
     Application.ProcessMessages;
     with fVStates do
     begin
      CountFounded:= SelectRange_Integer(CurrIndex, aThZpA * 10, aThZpA * 10 + 2, FirstFounded);
      for J:= FirstFounded to FirstFounded + CountFounded - 1 do
      begin
       aNuclideState:= TNuclideState.Create(aNuclide);
       with aNuclideState, TVState(fVStates[J]) do
       begin
        aThZpA_s:= TVState(fVStates[J]).ThZpA_s;
        if ProgressBar <> nil then
         ProgressBar.Position:= aThZpA div 1000;
        aNuclideState.State:= aThZpA_s mod 10;
        aNuclideState.T1_2:= TVState(fVStates[J]).T1_2;
        aNuclideState.SigmaF:= 0;
        aNuclideState.RIF:= 0;
//        aNuclideState.g_factor:= 1;       // CapturesAdded
        aNuclideState.SigmaNP:= 0;
        aNuclideState.SigmaNA:= 0;
        aNuclideState.SigmaN2N:= 0;
        aNuclideState.SigmaNN:= 0;
        aNuclideState.SigmaNG:= 0;
        with fVSigmaFs do
         CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
        if CountDetail > 0 then
         aNuclideState.SigmaF:= TVSigmaF(fVSigmaFs[FirstDetail]).Sigma;
        with fVRIFs do
         CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
        if CountDetail > 0 then
         aNuclideState.RIF:= TVRIF(fVRIFs[FirstDetail]).RI;
        with fVSigmaThresholds do
        begin
         CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
         if CountDetail > 0 then
         begin
          if TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).SigmaNP > 0 then
           aNuclideState.SigmaNP:= TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).SigmaNP;
          if TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).SigmaNA > 0 then
           aNuclideState.SigmaNA:= TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).SigmaNA;
          if TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).SigmaN2N > 0 then
           aNuclideState.SigmaN2N:= TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).SigmaN2N;
          if TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).SigmaNG > 0 then
           aNuclideState.SigmaNG:= TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).SigmaNG;
          if TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).SigmaNN > 0 then
           aNuclideState.SigmaNN:= TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).SigmaNN;
          if TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).g_factor > 0 then // CapturesAdded
           aNuclideState.Captures.g_factor:= TVSigmaThreshold(fVSigmaThresholds[FirstDetail]).g_factor;
         end
        end;
//    Captures
        with fVSigmaCs do
        begin
         CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
         if CountDetail > 0 then // CapturesAdded
          aNuclideState.Captures.G_factor:= TVSigmaC(fVSigmaCs[FirstDetail]).g_factor
         else
          aNuclideState.Captures.G_factor:= -1;
         for K:= FirstDetail to FirstDetail + CountDetail - 1 do
         begin
          if ((TVSigmaC(fVSigmaCs[K]).ProductState >= 0) and
           (TVSigmaC(fVSigmaCs[K]).ProductState <= 2)) then
          begin
           aCapture.ToState:= TVSigmaC(fVSigmaCs[K]).ProductState;
           if ((TVSigmaC(fVSigmaCs[K]).Sigma > 0)) then
            aCapture.Sigma:= TVSigmaC(fVSigmaCs[K]).Sigma
           else
            aCapture.Sigma:= 0;
           aNuclideState.Captures.Add(aCapture);
          end;
         end;
//    RIs
         with fVRIs do
         begin
          CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
          for K:= FirstDetail to FirstDetail + CountDetail - 1 do
          begin
           if ((TVRI(fVRIs[K]).ProductState >= 0) and
            (TVRI(fVRIs[K]).ProductState <= 2)) then
           begin
            aRI.ToState:= TVRI(fVRIs[K]).ProductState;
            if ((TVRI(fVRIs[K]).RI > 0)) then
             aRI.Value:= TVRI(fVRIs[K]).RI
            else
             aRI.Value:= 0;
            aNuclideState.RIs.Add(aRI);
           end;
          end;
         end;
// Decays
         with fVDecays do
         begin
          CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
          for K:= FirstDetail to FirstDetail + CountDetail - 1 do
          begin
           if (TVDecay(fVDecays[K]).DecayType <> dtNone) then
           begin
            aDecay.DecayType:= TVDecay(fVDecays[K]).DecayType;
            if (TVDecay(fVDecays[K]).Branching > 0) then
             aDecay.Branching:= TVDecay(fVDecays[K]).Branching
            else
             aDecay.Branching:= 0;
            aNuclideState.Decays.Add(aDecay);
           end;
          end;
         end;
// Alpas
         with fVAlphas do
         begin
          CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
          for K:= FirstDetail to FirstDetail + CountDetail - 1 do
          begin
           aAlpha.MeV:= TVAlpha(fVAlphas[K]).MeV;
           aAlpha.Probability:= TVAlpha(fVAlphas[K]).Probability;
           aNuclideState.Alphas.Add(aAlpha);
          end;
         end;
// Betas
         with fVBetas do
         begin
          CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
          for K:= FirstDetail to FirstDetail + CountDetail - 1 do
          begin
           aBeta.MeV:= TVBeta(fVBetas[K]).MeV;
           aBeta.MaxMeV:= TVBeta(fVBetas[K]).MaxMeV;
           aBeta.Probability:= TVBeta(fVBetas[K]).Probability;
           aNuclideState.Betas.Add(aBeta);
          end;
         end;
// Gammas
         with fVGammas do
         begin
          CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
          for K:= FirstDetail to FirstDetail + CountDetail - 1 do
          begin
           aGamma.MeV:= TVGamma(fVGammas[K]).MeV;
           aGamma.Probability:= TVGamma(fVGammas[K]).Probability;
           aNuclideState.Gammas.Add(aGamma);
          end;
         end;
// Electrons
         with fVElectrons do
         begin
          CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
          for K:= FirstDetail to FirstDetail + CountDetail - 1 do
          begin
           aElectron.MeV:= TVElectron(fVElectrons[K]).MeV;
           aElectron.Probability:= TVElectron(fVElectrons[K]).Probability;
           aNuclideState.Electrons.Add(aElectron);
          end;
         end;
// Positrons
         with fVPositrons do
         begin
          CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
          for K:= FirstDetail to FirstDetail + CountDetail - 1 do
          begin
           aPositron.MeV:= TVPositron(fVPositrons[K]).MeV;
           aPositron.MaxMeV:= TVPositron(fVPositrons[K]).MaxMeV;
           aPositron.Probability:= TVPositron(fVPositrons[K]).Probability;
           aNuclideState.Positrons.Add(aPositron);
          end;
         end;
// YieldT
         with fVYieldTs do
         begin
          CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
          for K:= FirstDetail to FirstDetail + CountDetail - 1 do
          begin
           aYield.ParentThZpA:= TVYield(fVYieldTs[K]).ThZpA_s div 10;
           aYield.CumYieldT:= TVYield(fVYieldTs[K]).CumYield;
           aYield.IndYieldT:= TVYield(fVYieldTs[K]).IndYield;
           aYield.CumYieldF:= 0;
           aYield.IndYieldF:= 0;
           aNuclideState.Yields.Add(aYield);
          end;
         end;
// YieldF
         with fVYieldFs do
         begin
          CountDetail:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstDetail);
          for K:= FirstDetail to FirstDetail + CountDetail - 1 do
          begin
           aYieldParentThZpA:= TVYield(fVYieldFs[K]).ThZpA_s div 10;
           InListNo:= -1;
           for L:= 0 to aNuclideState.Yields.Count - 1 do
            if aNuclideState.Yields[L].ParentThZpA = aYieldParentThZpA then
            begin
             InListNo:= L;
             break;
            end;
           if InListNo >= 0 then
            with Yields[InListNo] do
            begin
             aYield:= aNuclideState.Yields[InListNo];
             aYield.CumYieldF:= TVYield(fVYieldFs[K]).CumYield;
             aYield.IndYieldF:= TVYield(fVYieldFs[K]).IndYield;
             aNuclideState.Yields[InListNo]:= aYield;
            end
           else
           begin
            aYield.ParentThZpA:= aYieldParentThZpA;
            aYield.CumYieldT:= 0;
            aYield.IndYieldT:= 0;
            aYield.CumYieldF:= TVYield(fVYieldFs[K]).CumYield;
            aYield.IndYieldF:= TVYield(fVYieldFs[K]).IndYield;
            aNuclideState.Yields.Add(aYield);
           end;
          end;
         end;

        end;
        aNuclide.NuclideTag:= nloBasic or nloRI or
         nloGamma or nloBeta or nloAlpha or nloElectron or nloPositron or nloYield;
        aNuclide.StateList.Add(aNuclideState);
       end;
      end;
     end;
    end;
    NuclideList.Add(aNuclide);
   end;
  end;
  Result:= True;
 except
  Result:= False;
 end;
end;

function T_DataModuleOOB.ReadElementList(var ElementList: TElementList;
 ProgressBar: TProgressBar): Boolean;
var
 anElement: TElement;
 aZ, FirstFounded, I: integer;
begin
 try
  with fVElements do
   CurrIndex:= GetIndexRec('Number'); // Znum
  with ElementList do
   for I:= 0 to Count - 1 do
    ElementList[I].Free;
  ElementList.Clear;
  for I:= 0 to fVElements.Count - 1 do
  begin
   anElement:= TElement.Create;
   with anElement, TVElement(fVElements[I]) do
   begin
    anElement.Symbol:= TVElement(fVElements[I]).Symbol;
    anElement.AmassMean:= TVElement(fVElements[I]).AmassMean;
    anElement.SigmaA:= TVElement(fVElements[I]).SigmaA;
    anElement.Ro:= TVElement(fVElements[I]).Ro;
    anElement.ksi:= TVElement(fVElements[I]).ksi;
    anElement.SigmaS:= TVElement(fVElements[I]).SigmaS;
    anElement.RI:= TVElement(fVElements[I]).RI;
    anElement.Znum:= TVElement(fVElements[I]).Znum;
   end;
   ElementList.Add(anElement);
  end;
// Get AmassMin
  with fVStates do
  begin
   CurrIndex:= GetIndexRec('Number');
   for I:= 0 to ElementList.Count - 1 do
   begin
    aZ:= ElementList[I].Znum;
    if SelectRange_Integer(CurrIndex, aZ * 1000 * 10, (aZ + 1) * 1000 * 10, FirstFounded, rtExclude, rtExclude) > 0 then
    begin
     ElementList[I].AmassMin:= (TVState(fVStates[FirstFounded]).ThZpA_s mod 10000) div 10;
     continue;
    end
    else
     ElementList[I].AmassMin:= 666; // 666- test
   end;
  end;
  Result:= True;
 except
  Result:= False;
 end;
end;

function T_DataModuleOOB.ReadCaptureProductStateInfo(
 const Nuclide: TNuclide; var CountFounded, Max, Min: integer): Boolean;
var
 ProductThZpA, FirstFounded: integer;
begin
 ProductThZpA:= 1000 * Nuclide.Znum + Nuclide.Amass + 1;
 with fVStates do
 begin
  CurrIndex:= GetIndexRec('Number'); // ThZpA_s
  CountFounded:= SelectRange_Integer(CurrIndex, ProductThZpA * 10, ProductThZpA * 10 + 2, FirstFounded);
  if CountFounded > 0 then
  begin
   Min:= (TVState(fVStates[FirstFounded]).ThZpA_s mod 10000) mod 10;
   Max:= (TVState(fVStates[FirstFounded + CountFounded - 1]).ThZpA_s mod 10000) mod 10;
  end
  else
  begin
   Min:= -1;
   Max:= -1;
  end;
 end;
 Result:= True;
end;

function T_DataModuleOOB.ReadDecayModeList(
 var DecayModes: TStringList): Boolean;
var
 I: integer;
begin
 try
  with DecayModes do
  begin
   Clear;
   Sorted:= True;
   Duplicates:= dupIgnore;
   with fVDecays do
   begin
    for I:= 0 to fVDecays.Count - 1 do
     DecayModes.Add(DecayStr(TVDecay(fVDecays[I]).DecayType));
   end;
  end;
  Result:= True;
 except
  Result:= False;
 end;
end;

function T_DataModuleOOB.ReadHasFissionProductList(
 var HasFissionProductList: TStringList): Boolean;
var
 I: integer;
 ThZpAList: TLongIntList;
begin
 ThZpAList:= TLongIntList.Create;
 try
  HasFissionProductList.Clear;
  if fVYieldTs <> nil then
   with fVYieldTs do
   begin
    CurrIndex:= GetIndexRec('IndexBy_ThZpA_s'); //ThZpA
    for I:= 0 to Count - 1 do
     ThZpAList.AddUniq(TVYieldT(fVYieldTs[I]).ThZpA_s);
   end;
  if fVYieldFs <> nil then
   with fVYieldFs do
   begin
    CurrIndex:= GetIndexRec('IndexBy_ThZpA_s'); //ThZpA
    for I:= 0 to Count - 1 do
     ThZpAList.AddUniq(TVYieldF(fVYieldFs[I]).ThZpA_s);
   end;
  for I:= 0 to ThZpAList.Count - 1 do
   HasFissionProductList.Add(IntToStr(ThZpAList[I]));
  Result:= True;
 finally
  ThZpAList.Free;
 end;
end;

function T_DataModuleOOB.ReadFissionProductAmassMin(
 var FissionProductZnumList,
 FissionProductAmassMinList: TLongIntList): Boolean;
var
 I, FirstFounded: integer;
begin
 try
  FissionProductZnumList.Clear;
  FissionProductAmassMinList.Clear;
  with fVYieldTs, fVYieldFs do
  begin
   fVYieldTs.CurrIndex:= fVYieldTs.GetIndexRec('IndexBy_ProductThZpA_s');
   fVYieldFs.CurrIndex:= fVYieldFs.GetIndexRec('IndexBy_ProductThZpA_s');
   for I:= 0 to fVYieldTs.Count - 1 do
   begin
    FissionProductZnumList.AddUniq(TVYieldT(fVYieldTs[I]).ProductThZpA_s div 10000);
   end;
   for I:= 0 to fVYieldFs.Count - 1 do
   begin
    FissionProductZnumList.AddUniq(TVYieldF(fVYieldFs[I]).ProductThZpA_s div 10000);
   end;
   for I:= 0 to FissionProductZnumList.Count - 1 do
    FissionProductAmassMinList.Add(1000);
   for I:= 0 to FissionProductZnumList.Count - 1 do
   begin
//   aZ:= FissionProductZnumList[I];
    if fVYieldTs.SelectRange_Integer(fVYieldTs.CurrIndex, FissionProductZnumList[I] * 1000 * 10, (FissionProductZnumList[I] + 1) * 1000 * 10, FirstFounded, rtExclude, rtExclude) > 0 then
    begin
     FissionProductAmassMinList[I]:= (TVYieldT(fVYieldTs[FirstFounded]).ProductThZpA_s mod 10000) div 10;
     continue;
    end;
    if fVYieldFs.SelectRange_Integer(fVYieldFs.CurrIndex, FissionProductZnumList[I] * 1000 * 10, (FissionProductZnumList[I] + 1) * 1000 * 10, FirstFounded, rtExclude, rtExclude) > 0 then
     if FissionProductAmassMinList[I] > (TVYieldF(fVYieldFs[FirstFounded]).ProductThZpA_s mod 10000) div 10 then
     begin
      FissionProductAmassMinList[I]:= (TVYieldT(fVYieldTs[FirstFounded]).ProductThZpA_s mod 10000) div 10;
      continue;
     end;
   end;
  end;
  Result:= True;
 except
  Result:= False;
 end;
end;

function T_DataModuleOOB.LoadFissionProducts(const aThZpA_s: integer; TheFissionProducts: TLongIntList): Boolean;
var
 I, CountFounded, FirstFounded: integer;
begin
 try
  TheFissionProducts.Clear;
  with fVYieldTs do
  begin
   CurrIndex:= GetIndexRec('IndexBy_ThZpA_s');
   CountFounded:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstFounded);
   for I:= FirstFounded to FirstFounded + CountFounded - 1 do
    TheFissionProducts.AddUniq(TVYieldT(fVYieldTs[I]).ProductThZpA_s);
  end;
  with fVYieldFs do
  begin
   CurrIndex:= GetIndexRec('IndexBy_ThZpA_s');
   CountFounded:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstFounded);
   for I:= FirstFounded to FirstFounded + CountFounded - 1 do
    TheFissionProducts.AddUniq(TVYieldF(fVYieldFs[I]).ProductThZpA_s);
  end;
  Result:= True;
 except
  Result:= False;
 end;
end;

function T_DataModuleOOB.LoadSpecialCaptureProducts(const aThZpA_s: integer; TheCaptureProducts: TLongIntList): Boolean;
var
 I, CountFounded, FirstFounded: integer;
begin
 try
  TheCaptureProducts.Clear;
  with fVSpecialCaptureCases do
  begin
//   CurrIndex:= GetIndexRec('IndexBy_Parent_ThZpA_s');
   CountFounded:= SelectRange_Integer(CurrIndex, aThZpA_s, aThZpA_s, FirstFounded);
   for I:= FirstFounded to FirstFounded + CountFounded - 1 do
    TheCaptureProducts.AddUniq(TVSpecialCaptureCase(fVSpecialCaptureCases[I]).ChildThZpA_s);
  end;
  Result:= True;
 except
  Result:= False;
 end;
end;

function T_DataModuleOOB.ReadSpecialCaptureTotal(const aThZpA_s: integer; var aVarSigma, aVarRI: float): Boolean;
var
 FoundCount, FirstNo, I: integer;
begin
 Result:= False;
 aVarSigma:= 0;
 aVarRI:= 0;
 try
  with VSpecialCaptureCases do
  begin
   FoundCount:= VSpecialCaptureCases.SelectRange_Integer(VSpecialCaptureCases.CurrIndex, aThZpA_s, aThZpA_s, FirstNo);
   if FoundCount > 0 then
   begin
    for I:= FirstNo to FirstNo + FoundCount - 1 do
    begin
     aVarSigma:= aVarSigma + TVSpecialCaptureCase(VSpecialCaptureCases[I]).Sigma;
     aVarRI:= aVarRI + TVSpecialCaptureCase(VSpecialCaptureCases[I]).RI;
     Result:= True;
    end;
   end;
  end;
 except
  Result:= False; // Maybe OLD oob data file
 end;
end;

function T_DataModuleOOB.ReadSpecialCaptureDetail(const aParentThZpA_s, aChildThZpA_s: integer;
 var aVarSigma, aVarG_factor, aVarRI: float): Boolean;
var
 FoundCount, FirstNo, I: integer;
begin
 Result:= False;
 try
  with VSpecialCaptureCases do
  begin
   FoundCount:= VSpecialCaptureCases.SelectRange_Integer(VSpecialCaptureCases.CurrIndex, aParentThZpA_s, aParentThZpA_s, FirstNo);
   if FoundCount > 0 then
   begin
    for I:= FirstNo to FirstNo + FoundCount - 1 do
     if TVSpecialCaptureCase(VSpecialCaptureCases[I]).ChildThZpA_s = aChildThZpA_s then
     begin
      aVarSigma:= TVSpecialCaptureCase(VSpecialCaptureCases[I]).Sigma;
      aVarG_factor:= TVSpecialCaptureCase(VSpecialCaptureCases[I]).g_factor;
      aVarRI:= TVSpecialCaptureCase(VSpecialCaptureCases[I]).RI;
      Result:= True;
      Exit;
     end;
   end;
  end;
 except
  Result:= False; // Maybe OLD oob data file
 end;
end;

function T_DataModuleOOB.ReadSubBranchingList(const ThZpA_s: integer;
 var aSubBranchingList: TSubBranchingList): Boolean;
var
 CountDetail, FirstDetail, K: integer;
 aSubBranching: TSubBranching;
begin
 try
  aSubBranchingList.Clear;
  with fVSubBranchings do
  begin
   CurrIndex:= GetIndexRec('IndexBy_ThZpA_s');
   CountDetail:= SelectRange_Integer(CurrIndex, ThZpA_s, ThZpA_s, FirstDetail);
   for K:= FirstDetail to FirstDetail + CountDetail - 1 do
   begin
    if (StrToDecayType(TVSubBranching(fVSubBranchings[K]).SubBranchingName) <> dtNone) then
    begin
     aSubBranching.DecayType:= StrToDecayType(TVSubBranching(fVSubBranchings[K]).SubBranchingName);
     if (TVSubBranching(fVSubBranchings[K]).BranchingToG > 0) then
      aSubBranching.BranchingToG:= TVSubBranching(fVSubBranchings[K]).BranchingToG
     else
      aSubBranching.BranchingToG:= 0;
     if (TVSubBranching(fVSubBranchings[K]).BranchingToG > 0) then
      aSubBranching.BranchingToG:= TVSubBranching(fVSubBranchings[K]).BranchingToG
     else
      aSubBranching.BranchingToG:= 0;
     if (TVSubBranching(fVSubBranchings[K]).BranchingToM1 > 0) then
      aSubBranching.BranchingToM1:= TVSubBranching(fVSubBranchings[K]).BranchingToM1
     else
      aSubBranching.BranchingToM1:= 0;
     if (TVSubBranching(fVSubBranchings[K]).BranchingToM2 > 0) then
      aSubBranching.BranchingToM2:= TVSubBranching(fVSubBranchings[K]).BranchingToM2
     else
      aSubBranching.BranchingToM2:= 0;
    end;
    aSubBranchingList.Add(aSubBranching);
   end;
  end;
  Result:= True;
 except
  Result:= False;
 end;
end;

function T_DataModuleOOB.GetSymbol(var aStr: string;
 InitZnum: integer): Boolean;
var
 P: Pointer;
begin
 try
  aStr:= '';
  with fVElements do
  begin
   P:= SearchObj_Integer(GetIndexRec('Number'), InitZnum);
   if P <> nil then
   begin
    aStr:= TVElement(P).Symbol;
    Result:= True;
   end
   else
    Result:= False;
  end;
 except
  Result:= False;
 end;
end;

procedure T_DataModuleOOB.DataModuleDestroy(Sender: TObject);
begin
 OpenDialog.Free;
 fVStates.Free;
 fVAbundances.Free;
 fVElements.Free;
 fVDecays.Free;
 fVSigmaFs.Free;
 fVRIFs.Free;
 fVSigmaCs.Free;
 fVSigmaThresholds.Free;
 fVRIs.Free;
 fVYieldTs.Free;
 fVYieldFs.Free;
 fVAlphas.Free;
 fVGammas.Free;
 fVElectrons.Free;
 fVBetas.Free;
 fVPositrons.Free;
 fVSubBranchings.Free;
 fVFastFissions.Free;
end;

constructor T_DataModuleOOB.Create(AOwner: TComponent);
begin
 inherited;
 fLoadInProgress:= False;
 PanelDatabaseName:= nil;
end;

function T_DataModuleOOB.GetSigmaFastFissionForThZpA_s(
 const aThZpA_s: integer): Float;
var
 Founded: integer;
begin
 if (fVFastFissions = nil) then
 begin // Old OOB - no Fast Fissions
  Result:= -1;
  Exit;
 end;
//  LoadFastFissions;
 with fVFastFissions do
 begin
  Founded:= SearchNumberIndex(aThZpA_s);
  if Founded < 0 then
   Result:= -1
  else
   Result:= TVFastFission(fVFastFissions[Founded]).Sigma;
 end;
end;

function T_DataModuleOOB.ReadSubBranchingRecordList(
 var aSubBranchingRecordList: TSubBranchingRecordList): Boolean;
var
 aSubBranchingRecord: TSubBranchingRecord;
 I: integer;
begin
 try
  aSubBranchingRecordList.Clear;
  with fVSubBranchings do
  begin
   CurrIndex:= GetIndexRec('IndexBy_ThZpA_s');
   for I:= 0 to fVSubBranchings.Count - 1 do
    if (StrToDecayType(TVSubBranching(fVSubBranchings[I]).SubBranchingName) <> dtNone) then
    begin
     aSubBranchingRecord.ThZpA_s:= TVSubBranching(fVSubBranchings[I]).ThZpA_s;
     aSubBranchingRecord.DecayType:= StrToDecayType(TVSubBranching(fVSubBranchings[I]).SubBranchingName);
     if (TVSubBranching(fVSubBranchings[I]).BranchingToG > 0) then
      aSubBranchingRecord.BranchingToG:= TVSubBranching(fVSubBranchings[I]).BranchingToG
     else
      aSubBranchingRecord.BranchingToG:= 0;
     if (TVSubBranching(fVSubBranchings[I]).BranchingToG > 0) then
      aSubBranchingRecord.BranchingToG:= TVSubBranching(fVSubBranchings[I]).BranchingToG
     else
      aSubBranchingRecord.BranchingToG:= 0;
     if (TVSubBranching(fVSubBranchings[I]).BranchingToM1 > 0) then
      aSubBranchingRecord.BranchingToM1:= TVSubBranching(fVSubBranchings[I]).BranchingToM1
     else
      aSubBranchingRecord.BranchingToM1:= 0;
     if (TVSubBranching(fVSubBranchings[I]).BranchingToM2 > 0) then
      aSubBranchingRecord.BranchingToM2:= TVSubBranching(fVSubBranchings[I]).BranchingToM2
     else
      aSubBranchingRecord.BranchingToM2:= 0;
    end;
   aSubBranchingRecordList.Add(aSubBranchingRecord);
  end;
  Result:= True;
 except
  Result:= False;
 end;
end;

end.

