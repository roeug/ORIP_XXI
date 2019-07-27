unit NuclideClasses;

interface
uses
 windows, classes, graphics, forms, comctrls, EuLib;

type
 TNuclideGraphicType = (ngtMeta, ngtBitmap);
 TDecayType = (dtNone, dtA, dtBM, dtEC, dtIT, dtN, dtP, dtSF, dtQ);
 TNuclideTransition = (ntCapture, ntFission, ntDecay, ntThreshold);
 TNuclideTransitions = set of TNuclideTransition;
const
 AllNuclideTransitions: TNuclideTransitions = [ntCapture, ntDecay, ntFission, ntThreshold];
type
 TDecayTypes = set of TDecayType;
 TDecay = record
  DecayType: TDecayType;
  Branching: float;
 end;
 PDecay = ^TDecay;
 TSubBranching = record
  DecayType: TDecayType;
  BranchingToG: float;
  BranchingToM1: float;
  BranchingToM2: float;
 end;
 PSubBranching = ^TSubBranching;
 
// add
 TSubBranchingList = class;
 TSubBranchingRecordList = class;
 
 TSubBranchingRecord = record
  ThZpA_s: integer;
  DecayType: TDecayType;
  BranchingToG: float;
  BranchingToM1: float;
  BranchingToM2: float;
 end;
 
 PSubBranchingRecord = ^TSubBranchingRecord; // ????? ?? ?????? ? ???? ?? ????????
 
{ TSubBranchingRecordList }
 TSubBranchingRecordList = class(TList)
 protected
  function GetSubBranchingRecord(Index: integer): TSubBranchingRecord;
  procedure SetSubBranchingRecord(Index: integer; aSubBranchingRecord: TSubBranchingRecord);
 public
  function LoadFromDB(DataModule: TDataModule; ProgressBar: TProgressBar = nil): Boolean;
  function ReadSubBranchingList(const ThZpA_s: integer; var aSubBranchingList: TSubBranchingList): Boolean;
  procedure Add(aSubBranchingRecord: TSubBranchingRecord);
  destructor Destroy; override;
  constructor Create;
  property
   SubBranchingRecords[Index: integer]: TSubBranchingRecord read GetSubBranchingRecord write SetSubBranchingRecord; default;
 end;
// add end
 
 TGamma = record
  MeV: Float;
  Probability: Float;
 end;
 PGamma = ^TGamma;
 
 TAlpha = record
  MeV: Float;
  Probability: Float;
 end;
 PAlpha = ^TAlpha;
 
 TBeta = record
  MeV: Float;
  MaxMeV: Float;
  Probability: Float;
 end;
 PBeta = ^TBeta;
 
 TPositron = record
  MeV: Float;
  MaxMeV: Float;
  Probability: Float;
 end;
 PPositron = ^TPositron;
 
 TElectron = record
  MeV: Float;
  Probability: Float;
 end;
 PElectron = ^TElectron;
 
 TCapture = record
  ToState: integer; //9 - to unknown state
  Sigma: float; // barns
 end;
 PCapture = ^TCapture;
 
 TRI = record
  ToState: integer; //9 - to unknown state
  Value: float; // barns
 end;
 PRI = ^TRI;
 
 TYield = record
  ParentThZpA: integer;
  CumYieldT: Float;
  IndYieldT: Float;
  CumYieldF: Float;
  IndYieldF: Float;
 end;
 PYield = ^TYield;
 
 TNuclideState = class;
 TKarteInfo = class;
 {TDecayList}
 TDecayList = class(TList)
 protected
  State: TNuclideState;
  function GetDecay(Index: integer): TDecay;
  procedure SetDecay(Index: integer; aDecay: TDecay);
 public
  procedure Add(aDecay: TDecay);
  destructor Destroy; override;
  procedure Normalize;
  constructor Create(aState: TNuclideState);
  property
   Decays[Index: integer]: TDecay read GetDecay write SetDecay; default;
 end;
 TFindChain = function(const TheDataModule: TDataModule; const ThZpA_sStart, ThZpA_sFinish: integer; var MaxStepNo: Longint; Transitions: TNuclideTransitions;
  Answer: TLongIntList; ChainFinderMaxTime: DWORD = 30000; const ThermalMult: Float = 1E-20; const ResonanceMult: Float = 1E-20; const FastMult: Float = 1E-20; FirstStep: Boolean = True): Boolean of object;
 {TSubBranchingList}
 TSubBranchingList = class(TList)
 protected
  State: TNuclideState;
  function GetSubBranching(Index: integer): TSubBranching;
  procedure SetSubBranching(Index: integer; aSubBranching: TSubBranching);
 public
  procedure Add(aSubBranching: TSubBranching);
  destructor Destroy; override;
  procedure Normalize;
  constructor Create(aState: TNuclideState);
  property
   SubBranchings[Index: integer]: TSubBranching read GetSubBranching write SetSubBranching; default;
 end;
 {TGammaList}
 TGammaList = class(TList)
 protected
  State: TNuclideState;
  function GetGamma(Index: integer): TGamma;
  function GetKgamma: Float;
  procedure SetGamma(Index: integer; aGamma: TGamma);
  procedure Insert(Index: integer; aGamma: TGamma);
 public
  procedure Add(aGamma: TGamma);
  destructor Destroy; override;
  constructor Create(aState: TNuclideState);
  property
   Kgamma: Float read GetKgamma;
  property
   Gammas[Index: integer]: TGamma read GetGamma write SetGamma; default;
 end;
 {TElectronList}
 TElectronList = class(TList)
 protected
  State: TNuclideState;
  function GetElectron(Index: integer): TElectron;
  procedure SetElectron(Index: integer; aElectron: TElectron);
  procedure Insert(Index: integer; aElectron: TElectron);
 public
  procedure Add(aElectron: TElectron);
  destructor Destroy; override;
  constructor Create(aState: TNuclideState);
  property
   Electrons[Index: integer]: TElectron read GetElectron write SetElectron; default;
 end;
 {TAlphaList}
 TAlphaList = class(TList)
 protected
  State: TNuclideState;
  function GetAlpha(Index: integer): TAlpha;
  procedure SetAlpha(Index: integer; aAlpha: TAlpha);
  procedure Insert(Index: integer; aAlpha: TAlpha);
 public
  procedure Add(aAlpha: TAlpha);
  destructor Destroy; override;
  constructor Create(aState: TNuclideState);
  property
   Alphas[Index: integer]: TAlpha read GetAlpha write SetAlpha; default;
 end;
 {TBetaList}
 TBetaList = class(TList)
 protected
  State: TNuclideState;
  function GetBeta(Index: integer): TBeta;
  procedure SetBeta(Index: integer; aBeta: TBeta);
  procedure Insert(Index: integer; aBeta: TBeta);
 public
  procedure Add(aBeta: TBeta);
  destructor Destroy; override;
  constructor Create(aState: TNuclideState);
  property
   Betas[Index: integer]: TBeta read GetBeta write SetBeta; default;
 end;
 {TPositronList}
 TPositronList = class(TList)
 protected
  State: TNuclideState;
  function GetPositron(Index: integer): TPositron;
  procedure SetPositron(Index: integer; aPositron: TPositron);
  procedure Insert(Index: integer; aPositron: TPositron);
 public
  procedure Add(aPositron: TPositron);
  destructor Destroy; override;
  constructor Create(aState: TNuclideState);
  property
   Positrons[Index: integer]: TPositron read GetPositron write SetPositron; default;
 end;
 {TYieldList}
 TYieldList = class(TList)
 protected
  State: TNuclideState;
  function GetYield(Index: integer): TYield;
  procedure SetYield(Index: integer; aYield: TYield);
  procedure Insert(Index: integer; aYield: TYield);
 public
  procedure Add(aYield: TYield);
  destructor Destroy; override;
  constructor Create(aState: TNuclideState);
  property
   Yields[Index: integer]: TYield read GetYield write SetYield; default;
 end;
 {TCaptureList}
 TCaptureList = class(TList)
 protected
  State: TNuclideState;
  function GetCapture(Index: integer): TCapture;
  procedure SetCapture(Index: integer; aCapture: TCapture);
 public
  G_factor: float;
  procedure Insert(Index: integer; aCapture: TCapture);
  procedure SetCaptureToState(ToAstate: integer; aCapture: TCapture);
  function GetCaptureToState(ToAstate: integer): Float;
  procedure Add(aCapture: TCapture);
  destructor Destroy; override;
  constructor Create(aState: TNuclideState);
  property
   Captures[Index: integer]: TCapture read GetCapture write SetCapture; default;
 end;
 {TRIList}
 TRIList = class(TList)
 protected
  State: TNuclideState;
  function GetRI(Index: integer): TRI;
  procedure SetRI(Index: integer; aRI: TRI);
 public
  procedure Add(aRI: TRI);
  procedure Insert(Index: integer; aRI: TRI);
  destructor Destroy; override;
  constructor Create(aState: TNuclideState);
  property
   RIs[Index: integer]: TRI read GetRI write SetRI; default;
 end;
 {TStateList}
 TNuclide = class;
 TStateList = class(TList)
 protected
  Nuclide: TNuclide;
  function GetNuclideState(Index: integer): TNuclideState;
  procedure SetNuclideState(Index: integer; aNuclideState: TNuclideState);
 public
  procedure Add(aNuclideState: TNuclideState);
  destructor Destroy; override;
  constructor Create(aNuclide: TNuclide);
  property
   NuclideStates[Index: integer]: TNuclideState read GetNuclideState write SetNuclideState; default;
 end;
 {TElement}
 TElement = class
  Symbol: string[2];
  AmassMean: float;
  AmassMin: integer;
  SigmaA: float;
  Ro: float; //Ro_g/cm^3
  ksi: float;
  SigmaS: float;
  RI: float;
  Znum: integer;
  constructor Create;
  destructor Destroy; override;
  function GetMetafile(KarteInfo: TKarteInfo): TMetafile;
 end;
 {TElementList}
 TElementList = class(TList)
  function GetElement(Index: integer): TElement;
  procedure SetElement(Index: integer; aElement: TElement);
  procedure Add(aElement: TElement);
  destructor Destroy; override;
  constructor Create;
  function LoadFromDB(const DataModule: TDataModule; ProgressBar: TProgressBar = nil): Boolean;
  function FindInList(const Znum: integer): integer;
  property
   Elements[Index: integer]: TElement read GetElement write SetElement; default;
 end;
 
 {TNuclide}
 TNuclide = class
 protected
  fNuclideTag: DWORD;
  function GetModified: Boolean;
  procedure SetModified(aModified: Boolean);
  function GetNuclideType: integer;
 public
  Amass: integer;
  Znum: integer;
  Symbol: string[2];
  Abundance: float;
  StateList: TStateList;
  constructor Create(ThZpA: integer);
  destructor Destroy; override;
  function GetMetafile(KarteInfo: TKarteInfo; const ShowText: Boolean = True): TMetafile;
  procedure Assign(Source: TNuclide);
  procedure AssignStates(Source: TNuclide);
  procedure OrderStates;
  function LoadFromDB(DataModule: TDataModule; const Options: DWORD = 1): Boolean;
  function SaveToDB(DataModule: TDataModule; Options: DWORD = 3;
   ProgressBar: TProgressBar = nil; IsDebug: Boolean = False): Boolean;
  function GetCaptureProductStateInfo(DataModule: TDataModule; var Count, Max, Min: integer): Boolean;
  property
   Modified: Boolean read GetModified write SetModified;
  property
   NuclideType: integer read GetNuclideType;
  property
   NuclideTag: DWORD read fNuclideTag write fNuclideTag;
 end;
 {TNuclideState}
 TNuclideState = class
 protected
  function GetLambda: Float;
  function GetTotalSigmaC: Float;
  function GetTotalRI: Float;
  function GetTotalSigmaFast: Float;
  function GetThZpA_s: integer;
 public
  Nuclide: TNuclide;
  State: integer;
  T1_2: float;
  SigmaF: Float;
  SigmaNP: Float;
  SigmaNA: Float; //(n,alpha)
  SigmaN2N: Float;
  SigmaNN: Float; //(n,n')
  SigmaNG: Float; //(n,gamma)-fast
//  g_factor: Float;
  RIf: Float;
  Captures: TCaptureList;
  RIs: TRIList;
  Decays: TDecayList;
  Alphas: TAlphaList;
  Betas: TBetaList;
  Gammas: TGammaList;
  Positrons: TPositronList;
  Yields: TYieldList;
  Electrons: TElectronList;
  function GetStateName: string; virtual;
  procedure OrderDecays;
  procedure OrderAlphas;
  procedure OrderBetas;
  procedure OrderGammas;
  procedure OrderElectrons;
  procedure OrderPositrons;
  procedure OrderYields;
  procedure OrderCaptures;
  procedure OrderRIs;
  function IsStable: Boolean;
  procedure Assign(Source: TNuclideState);
  constructor Create(aNuclide: TNuclide);
  destructor Destroy; override;
  property Name: string read GetStateName;
  property TotalSigmaC: Float read GetTotalSigmaC;
  property TotalRI: Float read GetTotalRI;
  property TotalSigmaFast: Float read GetTotalSigmaFast;
  property Lambda: Float read GetLambda;
  property ThZpA_s: integer read GetThZpA_s;
 end;
 
 {TNuclideList}
 TNuclideList = class(TList)
 private
  fAbortChainFinder: Boolean;
  fChainFinderTimeAborted: Boolean;
  FFindChain: array[0..1] of TFindChain;
  function GetFindChain(Index: integer): TFindChain;
  function FindChain1(const TheDataModule: TDataModule; const ThZpA_sStart, ThZpA_sFinish: integer; var MaxStepNo: Longint; Transitions: TNuclideTransitions;
   Answer: TLongIntList; ChainFinderMaxTime: DWORD = 30000; const ThermalMult: Float = 1E-20; const ResonanceMult: Float = 1E-20; const FastMult: Float = 1E-20; FirstStep: Boolean = True): Boolean;
  function FindChain2(const TheDataModule: TDataModule; const ThZpA_sStart, ThZpA_sFinish: integer; var MaxStepNo: Longint; Transitions: TNuclideTransitions;
   Answer: TLongIntList; ChainFinderMaxTime: DWORD = 30000; const ThermalMult: Float = 1E-20; const ResonanceMult: Float = 1E-20; const FastMult: Float = 1E-20; FirstStep: Boolean = True): Boolean;
 protected
  function GetNuclide(Index: integer): TNuclide;
  procedure SetNuclide(Index: integer; aNuclide: TNuclide);
 public
//   I_Debug: integer;
  function FindChainTest(const TheDataModule: TDataModule; const ThZpA_sStart, ThZpA_sFinish: integer; var MaxStepNo: Longint; Transitions: TNuclideTransitions;
   Answer: TLongIntList; ChainFinderMaxTime: DWORD = 30000; const ThermalMult: Float = 1E-20; const ResonanceMult: Float = 1E-20; const FastMult: Float = 1E-20; FirstStep: Boolean = True): Boolean;
  procedure Add(aNuclide: TNuclide);
  destructor Destroy; override;
  constructor Create;
  function LoadFromDB(DataModule: TDataModule; ProgressBar: TProgressBar = nil): Boolean;
  function FindInList(const Znum, aMass: integer): integer;
  function FindThZpA_s(const ThZpA_s: Integer; var NuclideNo, StateNo: integer): Boolean;
  function FindChilds(const TheDataModule: TDataModule; const ThZpA_s: Integer; Transitions: TNuclideTransitions;
   ChildList: TLongIntList; VelocityList: TFloatList = nil;
   const ThermalMult: Float = 1E-20; const ResonanceMult: Float = 1E-20; const FastMult: Float = 1E-20): Boolean;
  function GetLink(const ThZpA_sStart, ThZpA_sFinish: Integer;
   var Answers: TStringList;
   Transitions: TNuclideTransitions = [ntCapture, ntFission, ntDecay, ntThreshold];
   aDataModule: TDataModule = nil; LoadWithCumYield: Boolean = True): DWORD; //   DataModuleOOB - for SubBranchings
  property
   Nuclides[Index: integer]: TNuclide read GetNuclide write SetNuclide; default;
  property FindChain[Index: Integer]: TFindChain read GetFindChain;
  property AbortChainFinder: Boolean read fAbortChainFinder write fAbortChainFinder;
  property ChainFinderTimeAborted: Boolean read fChainFinderTimeAborted;
  function FindThZpA_sState(const ThZpA_s: integer): TNuclideState;
  function FindChildsViaSubBranchingRecordList(SubBranchingRecordList: TSubBranchingRecordList; const ThZpA_s: integer; const Transitions: TNuclideTransitions;
   ChildList: TLongIntList; VelocityList: TFloatList = nil;
   const ThermalMult: float = 1E-20; const ResonanceMult: float = 1E-20; const FastMult: float = 1E-20): Boolean;
(*  function RemoveNullsFromBrunchings: Boolean; *)
 end;
 
// Classes To draw NUKLIDKARTE
 {TKarteinfo}
 TKarteInfo = class
  Rect: TRect;
  SpecialFont: Boolean;
  FontSymbol, FontT1_2, FontLast: TFont;
  StableColor, ITcolor, ECcolor, BMcolor, Acolor, SFcolor, Pcolor, NColor: TColor;
  QColor: TColor; // Question color
  procedure SetDefaultColor;
  constructor Create;
  destructor Destroy; override;
 end;
//LIB
function StrToDecayType(const DecayMode: string): TDecayType;
function CanvasRectToBitMap(SourceCanvasHDC: HDC; SourceRect: TRect; BitMap: TBitmap): boolean;
function IsStableT1_2(T1_2: float): Boolean;
function DecaySymbol(DecayType: TDecayType): string;
function DecaySpecialSymbol(DecayType: TDecayType): string;
function RussionDecaySymbol(DecayType: TDecayType): string;
function DecayStr(DecayType: TDecayType): string;
function LambdaToStr(const Lambda: float; Width: integer = 3): string;
function T1_2ToStr(T1_2: float; Width: integer = 3): string;
function T1_2ToStrSpecialFont(T1_2: float; Width: integer = 3): string;
function TextT1_2ToNum(const Text: string; var aFloat: float): Boolean;
function Color4DecayType(DecayType: TDecayType; KarteInfo: TKarteInfo): TColor;
function FontColor(BrushColor: TColor): TColor;
function IntStateToStr(State: integer): string;
function ValT1_2(FloatText, UnitsText: string; var aFloat: Float): Boolean;
function ZnumToSymbol(const Znum: integer; var Symbol: string): Boolean;
function SymbolToZnum(const Symbol: string; var Znum: integer): Boolean;
function ThZpAtoNuclideName(const aThZpA: integer): string;
function NKstr(const InStr: string; const IsSpecialFont: Boolean = False;
 const Font: TFont = nil; StrWidth: integer = 0): string;
function NKstrSymbol(const SymbolStr, AmassStr: string): string;
function DecayProductThZpA(const ParentThZpA: integer; const DecayType: TDecayType): integer;
function ThresholdProductThZpA(const ParentThZpA: integer; const ReactionName: string): integer;
function Bateman(const N0s, Lambdas, ts: array of float; var Ni_t: array of float): Boolean;
function StrToThZpA_s(const Str: string): integer;
function ThZpA_sToStr(const ThZpA_s: integer): string;
function AmassFromStateName(const Str: string): integer;
function ElementNameFromStateName(const Str: string): string;
procedure StrToStateNamesList(const InputStr: string; var Lines: TStringList); // it undestands phrases like Co-58..62
function IsStableState(aState: TNuclideState): Boolean;
function GetAllDPR(const MamaThZpA_s: integer; // fromMagnolia UnitCalc
 const NuclideList: TNuclideList;
 const SubBranchingRecordList: TSubBranchingRecordList;
 var Childs: TLongIntList): integer;

const
// Symbols
 N_Av = 6.02E23;
 BqPerCi = 3.7E10;
 MaxSymbolNo = 123;
 ConstSymbols: array[1..MaxSymbolNo] of string[2] = ('H', 'He', 'Li', 'Be', 'B', 'C', 'N', 'O', 'F', 'Ne', 'Na', 'Mg', 'Al', 'Si', 'P', 'S', 'Cl', 'Ar', 'K', 'Ca', 'Sc', 'Ti', 'V', 'Cr', 'Mn', 'Fe', 'Co', 'Ni', 'Cu', 'Zn', 'Ga', 'Ge', 'As', 'Se', 'Br', 'Kr', 'Rb', 'Sr', 'Y', 'Zr', 'Nb', 'Mo', 'Tc', 'Ru', 'Rh', 'Pd', 'Ag', 'Cd', 'In', 'Sn', 'Sb', 'Te', 'I', 'Xe', 'Cs', 'Ba', 'La', 'Ce', 'Pr', 'Nd', 'Pm', 'Sm', 'Eu', 'Gd', 'Tb', 'Dy', 'Ho', 'Er', 'Tm', 'Yb', 'Lu', 'Hf', 'Ta', 'W', 'Re', 'Os', 'Ir', 'Pt', 'Au', 'Hg', 'Tl', 'Pb', 'Bi', 'Po', 'At', 'Rn', 'Fr', 'Ra', 'Ac', 'Th', 'Pa', 'U', 'Np', 'Pu', 'Am', 'Cm', 'Bk', 'Cf', 'Es', 'Fm', 'Md', 'No', 'Lr', 'Rf', 'Ha', 'Sg', 'Ns', 'Hs', 'Mt', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23');
 MinFissionableZnum = 90;
// TimeInterval
 ti_ps: float = 1.0E-12;
 ti_ns: float = 1.0E-9;
 ti_mks: float = 1.0E-6;
 ti_ms: float = 1.0E-3;
 ti_sec: float = 1.0;
 ti_min: float = 60.0;
 ti_hou: float = 3600.0;
 ti_day: float = 24 * 3600.0;
// ti_yea: float=365.25*24*3600.0;
 ti_yea: float = 31556925.2; //sidereal year
 ZiroCaptureToG: TCapture = (ToState: 0; Sigma: 0);
 ZiroCaptureToM1: TCapture = (ToState: 1; Sigma: 0);
 ZiroCaptureToM2: TCapture = (ToState: 2; Sigma: 0);
 ZiroRIToG: TRI = (ToState: 0; Value: 0);
 ZiroRIToM1: TRI = (ToState: 1; Value: 0);
 ZiroRIToM2: TRI = (ToState: 2; Value: 0);
// Nuclide Load Options
 nloBasic: DWORD = $0001;
 nloRI: DWORD = $0002;
 nloGamma: DWORD = $0004;
 nloAlpha: DWORD = $0008;
 nloBeta: DWORD = $0010;
 nloFission: DWORD = $0020;
 nloSigmaThreshold: DWORD = $0040;
 nloYield: DWORD = $0080;
 nloElectron: DWORD = $01000;
 nloPositron: DWORD = $0200;
//NuclideTagBits
 ntbModified: DWORD = $0100;
 // State Link Types
 sltNone: DWORD = $0001;
 sltDecay: DWORD = $0002;
 sltThermal: DWORD = $0004;
 sltResonance: DWORD = $0008;
 sltFast: DWORD = $0010;
var
 WasProductThZpA: integer;
 Symbols: array[1..MaxSymbolNo] of string[2];
// Vars for ChainFinder
 ChainFinderInitTime: DWORD;
 ChainFinderConsided: TLongIntList;
 ChainFinderHavePath: TLongIntList;
 
implementation

uses
 Math, SysUtils, Dialogs, UnitDM_DAO, UnitDM_OOB, messages;

const
// Mu - for air Mashkovich p.167
 MuAirNo = 33;
 MuAirE0: array[1..MuAirNo] of float = (0.0, 0.01, 0.015, 0.02, 0.03, 0.04, 0.05, 0.06, 0.08, 0.1, 0.145, 0.15, 0.2, 0.279, 0.3, 0.4, 0.412, 0.5, 0.6, 0.662, 0.8, 1, 1.25, 1.5, 2, 2.75, 3, 4, 5, 6, 8, 10, 1E30);
 MuAirMu: array[1..MuAirNo] of float = (0.0, 4.65, 1.3, 0.527, 0.15, 0.0671, 0.0404, 0.0301, 0.0239, 0.0232, 0.0247, 0.0249, 0.0267, 0.0284, 0.0287, 0.0295, 0.0295, 0.0297, 0.0295, 0.0294, 0.0288, 0.0279, 0.0266, 0.0254, 0.0234, 0.0212, 0.0206, 0.0187, 0.0174, 0.0165, 0.0152, 0.0144, 0.0);
 
var
 IIIIII: integer;
 
function InternalTextFormat(const aFloat: Float): string;
begin
// Result:= Trim(Format('%-17.15g', [aFloat]));
 Result:= Trim(Format('%-7.5g', [aFloat]));
end;

{ TSubBranchingRecordList }

constructor TSubBranchingRecordList.Create;
begin
 inherited Create;
end;

function TSubBranchingRecordList.GetSubBranchingRecord(Index: integer): TSubBranchingRecord;
begin
 Result:= TSubBranchingRecord(Items[Index]^);
end;

procedure TSubBranchingRecordList.SetSubBranchingRecord(Index: integer; aSubBranchingRecord: TSubBranchingRecord);
begin
 TSubBranchingRecord(Items[Index]^).ThZpA_s:= aSubBranchingRecord.ThZpA_s;
 TSubBranchingRecord(Items[Index]^).DecayType:= aSubBranchingRecord.DecayType;
 TSubBranchingRecord(Items[Index]^).BranchingToG:= aSubBranchingRecord.BranchingToG;
 TSubBranchingRecord(Items[Index]^).BranchingToM1:= aSubBranchingRecord.BranchingToM1;
 TSubBranchingRecord(Items[Index]^).BranchingToM2:= aSubBranchingRecord.BranchingToM2;
end;

procedure TSubBranchingRecordList.Add(aSubBranchingRecord: TSubBranchingRecord);
var
 NewSubBranchingRecord: PSubBranchingRecord;
begin
 New(NewSubBranchingRecord);
 with NewSubBranchingRecord^ do
 begin
  ThZpA_s:= aSubBranchingRecord.ThZpA_s;
  DecayType:= aSubBranchingRecord.DecayType;
  BranchingToG:= aSubBranchingRecord.BranchingToG;
  BranchingToM1:= aSubBranchingRecord.BranchingToM1;
  BranchingToM2:= aSubBranchingRecord.BranchingToM2;
 end;
 inherited Add(NewSubBranchingRecord);
end;

destructor TSubBranchingRecordList.Destroy;
var
 I: integer;
begin
 for I:= 0 to Count - 1 do
  if (Items[I] <> nil) then
   Dispose(PSubBranchingRecord(Items[I]));
 inherited Destroy;
end;

function TSubBranchingRecordList.ReadSubBranchingList(const ThZpA_s: integer; var aSubBranchingList: TSubBranchingList): Boolean;
var
 I: integer;
 aSubBranching: TSubBranching;
begin
 try
  aSubBranchingList.Clear;
  for I:= 0 to Self.Count - 1 do
   if (Self[I].ThZpA_s = ThZpA_s) then
   begin
    aSubBranching.DecayType:= Self[I].DecayType;
    aSubBranching.BranchingToG:= Self[I].BranchingToG;
    aSubBranching.BranchingToM1:= Self[I].BranchingToM1;
    aSubBranching.BranchingToM2:= Self[I].BranchingToM2;
    aSubBranchingList.Add(aSubBranching);
   end;
  Result:= True;
 except
  Result:= False;
 end;
end;

function TSubBranchingRecordList.LoadFromDB(DataModule: TDataModule;
 ProgressBar: TProgressBar): Boolean;
begin
// if (DataModule is TDataModuleMagnoliaEu) then
 if (DataModule is T_DataModuleOOB) then
  Result:= T_DataModuleOOB(DataModule).ReadSubBranchingRecordList(Self)
 else
  Result:= False;
end;

{TElement}

constructor TElement.Create;
begin
 inherited Create;
 Symbol:= '';
 Ro:= 0;
 AmassMean:= 0;
 AmassMin:= 0;
 SigmaA:= 0;
 Ro:= 0;
 ksi:= 0;
 SigmaS:= 0;
 RI:= 0;
end;

destructor TElement.Destroy;
begin
 inherited Destroy;
end;

function TElement.GetMetafile(KarteInfo: TKarteInfo): TMetafile;
var
 ElementCanvas: TMetafileCanvas;
 TmpMeta: TMetaFile;
begin
 TmpMeta:= TMetaFile.Create;
 with TmpMeta, KarteInfo.Rect do
 begin
  TmpMeta.Width:= Right - Left;
  TmpMeta.Height:= Bottom - Top;
 end;
 ElementCanvas:= TMetaFileCanvas.Create(TmpMeta, 0);
 try
  try
   with ElementCanvas, KarteInfo do
   begin
    Brush.Color:= clWhite;
    FillRect(Rect);
    Pen.Width:= 2;
    Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
    with Font do
    begin
     Assign(FontSymbol);
     Color:= clBlack;
     Size:= 2 * Size;
    end;
    TextOut(Rect.Left + 13, Rect.Top + 3, Symbol);
    if AmassMean > 0 then
    begin
     with Font do
     begin
      Assign(FontT1_2);
      Size:= 2 * Size;
      Color:= clBlack;
     end;
     TextOut(Rect.Left + 4, Rect.Top + 19, Trim(Format('%-7.5g', [AmassMean])));
    end;
    if (SigmaA > 0) then
    begin
     with Font do
     begin
      Assign(FontLast);
      Color:= clBlack;
      Size:= 2 * Size;
     end;
     if SpecialFont then
      TextOut(Rect.Left + 3, Rect.Bottom - 16, #93 + ' ' + Format('%-7.5g', [SigmaA]))
     else
      TextOut(Rect.Left + 3, Rect.Bottom - 16, 's ' + Format('%-7.5g', [SigmaA]));
    end;
   end;
   Result:= TmpMeta;
  finally
   ElementCanvas.Free;
  end; // try .. finally
 except
  Result:= nil;
 end; // try..except
end; {TElement.GetMetafile}

{TNuclide}

function TNuclide.GetModified: Boolean;
begin
 Result:= ((NuclideTag and ntbModified) > 0);
end;

procedure TNuclide.SetModified(aModified: Boolean);
begin
 if aModified then
  NuclideTag:= NuclideTag or ntbModified
 else
  NuclideTag:= NuclideTag and not (ntbModified);
end;

function TNuclide.GetCaptureProductStateInfo(DataModule: TDataModule; var Count, Max, Min: integer): Boolean;
begin
 if (DataModule is T_DataModuleDAO) then
 begin
  try
   Result:= T_DataModuleDAO(DataModule).ReadCaptureProductStateInfo(Self, Count, Max, Min);
  except
   Result:= False;
  end;
 end
 else if (DataModule is T_DataModuleOOB) then
 begin
  try
   Result:= T_DataModuleOOB(DataModule).ReadCaptureProductStateInfo(Self, Count, Max, Min);
  except
   Result:= False;
  end;
 end
 else
  Result:= False;
end;

function TNuclide.LoadFromDB(DataModule: TDataModule; const Options: DWORD = 1): Boolean;
begin
 if (DataModule is T_DataModuleDAO) then
 begin
  try
   Result:= T_DataModuleDAO(DataModule).ReadNuclide(Self, Options);
  except
   Result:= False;
  end;
 end
 else if (DataModule is T_DataModuleOOB) then
 begin
  try
   Result:= T_DataModuleOOB(DataModule).ReadNuclide(Self, Options);
  except
   Result:= False;
  end;
 end
 else
  Result:= False;
end;

function TNuclide.SaveToDB(DataModule: TDataModule; Options: DWORD = 3;
 ProgressBar: TProgressBar = nil; IsDebug: Boolean = False): Boolean;
begin
 if (DataModule is T_DataModuleDAO) then
 begin
  try
   Result:= T_DataModuleDAO(DataModule).WriteNuclide(Self, Options, ProgressBar, IsDebug);
  except
   Result:= False;
  end;
 end
 else if (DataModule is T_DataModuleOOB) then
 begin
  try
   Result:= T_DataModuleOOB(DataModule).WriteNuclide(Self, Options, ProgressBar, IsDebug);
  except
   Result:= False;
  end;
 end
 else
  Result:= False;
end;

procedure TNuclide.AssignStates(Source: TNuclide);
var
 I: integer;
 State: TNuclideState;
begin
 if (Self = Source) then
  Exit;
 StateList.Clear;
 for I:= 0 to (Source.StateList.Count - 1) do
 begin
  State:= TNuclideState.Create(Self);
  State.Assign(Source.StateList[I]);
  State.Nuclide:= Self;
  StateList.Add(State);
 end;
end;

procedure TNuclide.Assign(Source: TNuclide);
begin
 if (Self = Source) then
  Exit;
 AssignStates(Source);
 Amass:= Source.Amass;
 Znum:= Source.Znum;
 Symbol:= Source.Symbol;
 NuclideTag:= Source.NuclideTag;
 Abundance:= Source.Abundance;
 Modified:= Source.Modified;
 AssignStates(Source);
end;

constructor TNuclide.Create(ThZpA: integer);
begin
 inherited Create;
 Amass:= ThZpA mod 1000;
 Znum:= ThZpA div 1000;
 StateList:= TStateList.Create(Self);
 Modified:= False;
end;

destructor TNuclide.Destroy;
begin
// StateList.Destroy;
 StateList.Free;
 inherited Destroy;
end;

procedure TNuclide.OrderStates;
var
 I, J: integer;
 aState: TNuclideState;
begin
 for I:= 0 to (StateList.Count - 1) do
 begin
  StateList[I].OrderDecays;
  StateList[I].OrderCaptures;
  StateList[I].OrderRIs;
  StateList[I].OrderAlphas;
  StateList[I].OrderBetas;
  StateList[I].OrderGammas;
  StateList[I].OrderElectrons;
  StateList[I].OrderPositrons;
 end;
 if (StateList.Count > 1) then
 begin
//Order
  for J:= 1 to (StateList.Count - 1) do
  begin
   I:= J;
   while (StateList[I].State < StateList[I - 1].State) do
   begin
    StateList.Exchange(I, I - 1);
    if I = 1 then
     break;
    Dec(I);
   end;
  end;
  for J:= 0 to (StateList.Count - 1) do
   if ((StateList[J].State > 2) or (StateList[J].State < 0)) then
   begin
    MessageDlg('Unknown nuclide state was found' + Symbol + '-' + IntToStr(Amass) + ' not (G,M1,M2)' + #13 + #10 + 'Call the author.', mtWarning, [mbOK], 0);
    Exit;
   end;
//InsertMissing
  if Statelist.Count > 0 then
  begin
   while (StateList.Count - 1) < StateList[StateList.Count - 1].State do
   begin
    if (StateList[0].State <> 0) then
    begin
     aState:= TNuclideState.Create(Self);
     aState.State:= 0;
     StateList.Insert(0, aState);
    end;
    if (StateList[1].State <> 1) then
    begin
     aState:= TNuclideState.Create(Self);
     aState.State:= 1;
     StateList.Insert(1, aState);
    end;
   end;
  end;
 end;
end;

function TNuclide.GetNuclideType: integer;
var
 HasStable, HasUnStable: Boolean;
// HasDecays: Boolean;
 I: integer;
begin
// Result := 0; //UnKnown
 if StateList.Count < 1 then
 begin
  Result:= 0;
  Exit;
 end;
 HasStable:= False;
 HasUnStable:= False;
// HasDecays := False;
 for I:= 0 to (StateList.Count - 1) do
 begin
//  if StateList[I].Decays.Count > 0
//   then HasDecays := True;
//  if (IsStable(StateList[I].T1_2)) then HasStable := True
  if StateList[I].IsStable then
   HasStable:= True
  else
   HasUnStable:= True;
 end;
 if ((StateList.Count = 1) and (HasStable)) then
 begin
  Result:= 1; // Stable
 end
 else if ((HasStable) and (HasUnStable)) then
 begin
  Result:= 2; //  StableWithMetastableState
 end
 else if (not (HasStable) and (Abundance > 0)) then
 begin
  Result:= 3; //  Primordial
 end
 else if (not (HasStable)) then
 begin
  Result:= 4; //  UnStable
 end
 else
  Result:= 0;
end;

function TNuclide.GetMetafile(KarteInfo: TKarteInfo; const ShowText: Boolean = True): TMetafile;

 procedure OutSigmas(Canvas: TCanvas; Rect: TRect; NuclideState: TNuclideState);
 var
  I: integer;
  TheSigma2GPresent, TheSigma2M1Present, TheSigma2M2Present: Boolean;
  TheSigma, TheSigma2G, TheSigma2M1, TheSigma2M2: float;
  FirstChar: string[2];
 begin
  if ((NuclideState = nil) or (Canvas = nil) or (Rect.Bottom - Rect.Top = 0) or (Rect.Right - Rect.Left = 0)) then
   Exit;
  if (NuclideState.Captures.Count < 1) then
   Exit;
  with Canvas do
  begin
   if (NuclideState.Captures.Count = 1) then
   begin
    TheSigma:= NuclideState.Captures[0].Sigma;
    if KarteInfo.SpecialFont then
//     TextOut(Rect.Left+1, Rect.Bottom-21, 'russian c '+Format('%-7.5g', [TheSigma]))
     TextOut(Rect.Left + 1, Rect.Bottom - 21, #93 + ' ' + Format('%-7.5g', [TheSigma]))
    else
     TextOut(Rect.Left + 1, Rect.Bottom - 21, 's ' + Format('%-7.5g', [TheSigma]));
   end
   else
   begin
    TheSigma2GPresent:= False;
    TheSigma2M1Present:= False;
    TheSigma2M2Present:= False;
    TheSigma2G:= -1;
    TheSigma2M1:= -1;
    TheSigma2M2:= -1;
    for I:= 0 to (NuclideState.Captures.Count - 1) do
     if (NuclideState.Captures[I].ToState = 0) and (NuclideState.Captures[I].Sigma > 0) then
     begin
      TheSigma2GPresent:= True;
      TheSigma2G:= NuclideState.Captures[I].Sigma;
     end
     else if (NuclideState.Captures[I].ToState = 1) and (NuclideState.Captures[I].Sigma > 0) then
     begin
      TheSigma2M1Present:= True;
      TheSigma2M1:= NuclideState.Captures[I].Sigma;
     end
     else if (NuclideState.Captures[I].ToState = 2) and (NuclideState.Captures[I].Sigma > 0) then
     begin
      TheSigma2M2Present:= True;
      TheSigma2M2:= NuclideState.Captures[I].Sigma;
     end;
    if KarteInfo.SpecialFont then
     FirstChar:= #93 //russian c
    else
     FirstChar:= 's ';
    if (TheSigma2M2Present) then
    begin
     TextOut(Rect.Left + 1, Rect.Bottom - 19, FirstChar + Trim(Format('%5.3G', [TheSigma2M2])));
     FirstChar:= '+ ';
    end;
    if (TheSigma2M1Present) then
    begin
     TextOut(Rect.Left + 1, Rect.Bottom - 13, FirstChar + Trim(Format('%5.3G', [TheSigma2M1])));
     FirstChar:= '+ ';
    end;
    if (TheSigma2GPresent) then
     TextOut(Rect.Left + 1, Rect.Bottom - 7, FirstChar + Trim(Format('%5.3G', [TheSigma2G])));
   end; //else
  end; // with Canvas
 end; { OutSigmas}
 
 function PaintUnstableState(Canvas: TCanvas; Rect: TRect; NuclideState: TNuclideState): TRect;
 var
  I: integer;
  aRect: TRect;
  Triangle: array[1..3] of TPoint;
  DecaysStr, DecaysStr1: string;
  FontColor: TColor;
  BranchSum: float;
 begin
  aRect:= Rect;
  Canvas.Brush.Color:= KarteInfo.QColor;
  if StateList.Count = 0 then
  begin
   Canvas.FillRect(aRect);
  end
  else if StateList.Count > 1 then //  Nuclide.StateList.Count>1 (Where paint?)
   with aRect do
   begin
    Left:= ((Rect.Right - Rect.Left) div StateList.Count) * (StateList.Count - NuclideState.State - 1);
    Right:= ((Rect.Right - Rect.Left) div StateList.Count) * (StateList.Count - NuclideState.State);
   end;
  Result:= aRect;
  with aRect do
  begin
   Triangle[1].X:= Left;
   Triangle[1].Y:= Bottom;
   Triangle[2].X:= Right;
   Triangle[2].Y:= Top;
   Triangle[3].X:= Right;
   Triangle[3].Y:= Bottom;
  end;
  with NuclideState, Canvas do
  begin
   OrderDecays;
   Brush.Style:= bsSolid;
   Pen.Width:= 0;
   BranchSum:= 0;
   for I:= 0 to Decays.Count - 1 do
    BranchSum:= BranchSum + Decays[I].Branching;
   if Decays.Count = 1 then
   begin
    Brush.Color:= Color4DecayType(Decays[0].DecayType, KarteInfo);
    FontColor:= (clWhite xor Brush.Color);
    FillRect(aRect);
   end //   if Decays.Count = 1
   else if (Decays.Count > 1) then
   begin //Decays.Count>1
    Brush.Color:= Color4DecayType(Decays[0].DecayType, KarteInfo);
    FontColor:= (clWhite xor Brush.Color);
    FillRect(aRect);
    if ((Decays[0].Branching >= 95) and (Decays[1].Branching <= 5)) then
    begin
     Triangle[1].X:= aRect.Right - 7;
     Triangle[2].Y:= aRect.Bottom - 7;
     Brush.Color:= Color4DecayType(Decays[1].DecayType, KarteInfo);
     Pen.Color:= Brush.Color;
     Polygon(Triangle);
    end
    else if ((Decays[0].Branching >= 50) and (Decays[1].Branching <= 50)) then
    begin
     Triangle[1].X:= aRect.Left;
     Triangle[2].Y:= aRect.Top;
     Brush.Color:= Color4DecayType(Decays[1].DecayType, KarteInfo);
     Pen.Color:= Brush.Color;
     Polygon(Triangle);
    end
    else
    begin
     Brush.Color:= FontColor;
{$IFDEF RELEASE}
{$ELSE}
     with aRect do
      Ellipse((Left + Right) div 2 - 4, (Top + Bottom) div 2 - 4,
       (Left + Right) div 2 + 4, (Top + Bottom) div 2 + 4);
//   MessageDlg('I Don;t know how to paint !!', mtWarning, [mbOK], 0);
{$ENDIF}
    end;
   end
   else
   begin //Decays.Count =0
    Brush.Color:= KarteInfo.Qcolor;
    FontColor:= (clWhite xor Brush.Color);
    FillRect(aRect);
   end;
{$IFDEF RELEASE}
{$ELSE}
// DebugCircle
   if (BranchSum < 99.9) or (BranchSum > 100.1) then
   begin
    Brush.Color:= FontColor;
    with aRect do
     Ellipse((Left + Right) div 2 - 3, (Top + Bottom) div 2 - 3,
      (Left + Right) div 2 + 3, (Top + Bottom) div 2 + 3);
   end;
{$ENDIF}
   if NuclideState.State > 0 then
   begin
    Pen.Color:= clBlack;
    MoveTo(aRect.Right, aRect.Top); //Draw Right Vertical Line
    LineTo(aRect.Right, aRect.Bottom);
   end;
   if ShowText then
   begin
    Brush.Style:= bsClear;
    DecaysStr:= '';
    for I:= 0 to Min(Decays.Count - 1, (aRect.Right - aRect.Left) div 5 - 1) do
//     DecaysStr:=DecaysStr+DecaySymbol(Decays[I].DecayType)+',';
     if KarteInfo.SpecialFont then
      DecaysStr:= DecaysStr + DecaySpecialSymbol(Decays[I].DecayType) + ','
     else
      DecaysStr:= DecaysStr + DecaySymbol(Decays[I].DecayType) + ',';
    DecaysStr:= Trim(Copy(DecaysStr, 1, Length(DecaysStr) - 1));
    DecaysStr1:= ''; // last decays
    for I:= ((aRect.Right - aRect.Left) div 5) to (Decays.Count - 1) do
//     DecaysStr1:=DecaysStr1+DecaySymbol(Decays[I].DecayType)+',';
     if KarteInfo.SpecialFont then
      DecaysStr1:= DecaysStr + DecaySpecialSymbol(Decays[I].DecayType) + ','
     else
      DecaysStr1:= DecaysStr + DecaySymbol(Decays[I].DecayType) + ',';
    DecaysStr1:= Trim(Copy(DecaysStr1, 1, Length(DecaysStr1) - 1));
    if (StateList.Count > 1) or (Nuclide.NuclideType = 3) then
    begin
// No Header
     Font.Assign(KarteInfo.FontT1_2);
     Font.Color:= FontColor;
     if (T1_2 > 0) then
//      TextOut(aRect.Left+1, aRect.Top+1, T1_2ToStr(T1_2, 3));
      if State <> 1 then
       if KarteInfo.SpecialFont then
        TextOut(aRect.Left + 1, aRect.Top + 1, T1_2ToStrSpecialFont(T1_2, 3))
       else
        TextOut(aRect.Left + 1, aRect.Top + 1, T1_2ToStr(T1_2, 3))
      else if KarteInfo.SpecialFont then
       TextOut(aRect.Left + 1, aRect.Top + Font.Height + 1, T1_2ToStrSpecialFont(T1_2, 3))
      else
       TextOut(aRect.Left + 1, aRect.Top + Font.Height + 1, T1_2ToStr(T1_2, 3));
     Font.Assign(KarteInfo.FontLast);
     Font.Color:= FontColor;
     if State <> 1 then
     begin
      if (DecaysStr <> '') then
       TextOut(aRect.Left + 1, aRect.Top + 7, DecaysStr);
      if (DecaysStr1 <> '') then
       TextOut(aRect.Left + 1, aRect.Top + 13, DecaysStr);
     end
     else
     begin
      if (DecaysStr <> '') then
       TextOut(aRect.Left + 1, aRect.Top + 14, DecaysStr);
      if (DecaysStr1 <> '') then
       TextOut(aRect.Left + 1, aRect.Top + 20, DecaysStr);
     end;
     OutSigmas(Canvas, aRect, NuclideState);
    end
    else
    begin //Header
     Brush.Style:= bsClear;
     Font.Assign(KarteInfo.FontSymbol);
     Font.Color:= FontColor;
//     TextOut(aRect.Left+1, aRect.Top, ' '+Symbol+' '+IntToStr(Amass));
     if not (KarteInfo.SpecialFont) then
      TextOut(Rect.Left + 1, Rect.Top, Symbol + '-' + IntToStr(Amass))
     else
      TextOut(Rect.Left + 2, Rect.Top, NKstrSymbol(Symbol, IntToStr(Amass)));
     Font.Assign(KarteInfo.FontT1_2);
     Font.Color:= FontColor;
     if (T1_2 > 0) then
//      TextOut(aRect.Left+1, aRect.Top+7, T1_2ToStr(T1_2, 3));
      if KarteInfo.SpecialFont then
       TextOut(aRect.Left + 1, aRect.Top + 7, T1_2ToStrSpecialFont(T1_2, 3))
      else
       TextOut(aRect.Left + 1, aRect.Top + 7, T1_2ToStr(T1_2, 3));
     Font.Assign(KarteInfo.FontLast);
     Font.Color:= FontColor;
     if (DecaysStr <> '') then
      TextOut(aRect.Left + 1, aRect.Top + 13, DecaysStr);
     if (DecaysStr1 <> '') then
      TextOut(aRect.Left + 1, aRect.Top + 19, DecaysStr);
     OutSigmas(Canvas, aRect, NuclideState);
    end;
   end; // ShowText
  end; //with NuclideState, Canvas
 end; { PaintUnstableState}
 
 { .GetMetafile itself}
var
 I, J: integer;
 FontColor: TColor;
 NuclideMainBranchingDecayType: TDecayType;
 NuclideMainBranching: float;
 TheNuclideCanvas: TMetafileCanvas;
 TmpMeta: TMetaFile;
 aRect: TRect;
begin
// OrderStates;
 TmpMeta:= TMetaFile.Create;
 with TmpMeta, KarteInfo.Rect do
 begin
  TmpMeta.Width:= Right - Left;
  TmpMeta.Height:= Bottom - Top;
 end;
 TheNuclideCanvas:= TMetaFileCanvas.Create(TmpMeta, 0);
 try
  try
   with TheNuclideCanvas, KarteInfo do
   begin
    case NuclideType of
     1:
      begin // STABLE
       Brush.Color:= StableColor;
       FontColor:= (clWhite xor Brush.Color);
       Brush.Style:= bsSolid;
       FillRect(Rect);
       if ShowText then
       begin
        Brush.Style:= bsClear;
        Font.Assign(FontSymbol);
        Font.Color:= FontColor;
//        TextOut(Rect.Left+1, Rect.Top, '  '+Symbol+' '+IntToStr(Amass));
        if not (KarteInfo.SpecialFont) then
         TextOut(Rect.Left + 1, Rect.Top, Symbol + '-' + IntToStr(Amass))
        else
         TextOut(Rect.Left + 2, Rect.Top, NKstrSymbol(Symbol, IntToStr(Amass)));

        if (Abundance > 0) then
        begin
         Font.Assign(FontT1_2);
         Font.Color:= FontColor;
//     TextOut(Rect.Left+(Rect.Right-Rect.Left)div 2+1, Rect.Top+7, '  '+Trim(Format('%-7.5g', [Abundance]))+'%');
         TextOut(Rect.Left + (Rect.Right - Rect.Left) div 2 + 1, Rect.Top + 5, '  ' + Trim(Format('%-7.5g', [Abundance])) + '%');
        end;
        Font.Assign(FontLast);
        Font.Color:= FontColor;
        OutSigmas(TheNuclideCanvas, Rect, StateList[0]);
       end;
       if (StateList.Count <> 1) then
        MessageDlg('The stable nuclide Z = ' + IntToStr(Znum) + ':' + IntToStr(Amass) + ' states number' + #13 + #10 + 'is not equal to one !!!', mtWarning, [mbOK], 0);
      end; //stable
     2:
      begin // Stable WithMetaStableStates
       aRect:= KarteInfo.Rect;
       aRect.Bottom:= 8;
       if not (ShowText) then
        aRect.Bottom:= 15;
       Brush.Color:= StableColor;
       Brush.Style:= bsSolid;
       FontColor:= (clWhite xor Brush.Color);
       FillRect(aRect);
       if StateList.Count = 2 then
        with aRect do
        begin
         Top:= 8;
         Bottom:= 48;
         Left:= 24;
         Right:= 48;
        end
       else if StateList.Count = 3 then
        with aRect do
        begin
         Top:= 8;
         Bottom:= 48;
         Left:= 32;
         Right:= 48;
        end
       else
        MessageDlg('Number of states for nuclide ' + IntToStr(Znum) + ':' + IntToStr(Amass) + ' is not equal to 2 or 3!!', mtWarning, [mbOK], 0);
       if not (StateList[0].IsStable) then
       begin
        MessageDlg('For nuclide ' + IntToStr(Znum) + ':' + IntToStr(Amass) + ' stable state was not found !!', mtWarning, [mbOK], 0);
       end
       else
       begin //Paint Stable State
        Brush.Color:= StableColor;
        Brush.Style:= bsSolid;
        FillRect(aRect);
        if ShowText then
        begin
         Brush.Style:= bsClear;
         Font.Assign(FontT1_2);
         Font.Color:= FontColor;
         if (Abundance > 0) then
          if KarteInfo.SpecialFont then
           TextOut(Rect.Right - (Rect.Right - Rect.Left) div 2 + 1, Rect.Top + 1, '  ' + Trim(Format('%-5.3g', [Abundance])) + '%')
          else
           TextOut(Rect.Left + (Rect.Right - Rect.Left) div 2 + 1, Rect.Top + 7, '  ' + Trim(Format('%-7.5g', [Abundance])) + '%');
         Font.Assign(FontLast);
         Font.Color:= FontColor;
         OutSigmas(TheNuclideCanvas, aRect, StateList[0]);
        end;
       end;
       aRect:= Rect;
       aRect.Top:= 8;
       if not (ShowText) then
        aRect.Top:= 15;
       for I:= 1 to (StateList.Count - 1) do
        if not (StateList[I].IsStable) then
         PaintUnstableState(TheNuclideCanvas, aRect, StateList[I]);
// Now Write Header
       if ShowText then
       begin
        Brush.Style:= bsClear;
        Font.Assign(FontSymbol);
        Font.Color:= FontColor;
//        TextOut(Rect.Left+1, Rect.Top, '  '+Symbol+' '+IntToStr(Amass));
        if not (KarteInfo.SpecialFont) then
         TextOut(Rect.Left + 1, Rect.Top, Symbol + '-' + IntToStr(Amass))
        else
         TextOut(Rect.Left + 2, Rect.Top, NKstrSymbol(Symbol, IntToStr(Amass)));
       end;
// Now Write Header - END
      end; //case 2: StableWithMetaStableState
     3:
      begin // Primordial
       aRect:= KarteInfo.Rect;
       aRect.Bottom:= 13;
       if not (ShowText) then
        aRect.Bottom:= 15;
       Brush.Color:= StableColor;
       Brush.Style:= bsSolid;
       FontColor:= (clWhite xor Brush.Color);
       FillRect(aRect);
       if ShowText then
       begin
        Brush.Style:= bsClear;
        Font.Assign(FontSymbol);
        Font.Color:= FontColor;
//        TextOut(Rect.Left+1, Rect.Top, '  '+Symbol+' '+IntToStr(Amass));
        if not (KarteInfo.SpecialFont) then
         TextOut(Rect.Left + 1, Rect.Top, Symbol + '-' + IntToStr(Amass))
        else
         TextOut(Rect.Left + 2, Rect.Top, NKstrSymbol(Symbol, IntToStr(Amass)));
        Font.Assign(FontT1_2);
        Font.Color:= FontColor;
        if (Abundance > 0) then
         if KarteInfo.SpecialFont then
//        TextOut(Rect.Left+(Rect.Right-Rect.Left)div 2+1, Rect.Top+7, '  '+Trim(Format('%-7.5g', [Abundance]))+'%')
          TextOut(Rect.Left + (Rect.Right - Rect.Left) div 2 + 1, Rect.Top + 5, '  ' + Trim(Format('%-7.5g', [Abundance])) + '%')
         else
//        TextOut(Rect.Left+(Rect.Right-Rect.Left)div 2+1, Rect.Top+7, '  '+Trim(Format('%-7.5g', [Abundance]))+'%');
          TextOut(Rect.Left + (Rect.Right - Rect.Left) div 2 + 1, Rect.Top + 5, '  ' + Trim(Format('%-7.5g', [Abundance])) + '%');
       end;
       aRect:= KarteInfo.Rect;
       aRect.Top:= 13;
       if not (ShowText) then
        aRect.Top:= 15;
       for I:= 0 to (StateList.Count - 1) do
        PaintUnstableState(TheNuclideCanvas, aRect, StateList[I]);
      end; //case 3: Primordial
     4:
      begin // UnStable
       Brush.Style:= bsSolid;
//       FillRect( Rect);
       NuclideMainBranchingDecayType:= dtNone;
       NuclideMainBranching:= -2; // -1 - Decay Exists but branching unknown 0.0;
// MAIN_Brabching - MAX in Ground state
       with StateList[0] do
        for J:= 0 to (Decays.Count - 1) do
         if (Decays[J].Branching > NuclideMainBranching) then
         begin
          NuclideMainBranchingDecayType:= StateList[0].Decays[J].DecayType;
          NuclideMainBranching:= StateList[0].Decays[J].Branching;
         end;
       Brush.Color:= Color4DecayType(NuclideMainBranchingDecayType, KarteInfo);
       FontColor:= (clWhite xor Brush.Color);
       if (StateList.Count > 1) then
       begin
        aRect:= KarteInfo.Rect;
        aRect.Bottom:= 8;
        if not (ShowText) then
         aRect.Bottom:= 15;
        FillRect(aRect);
        aRect:= KarteInfo.Rect;
        aRect.Top:= 8;
        if not (ShowText) then
         aRect.Top:= 15;
        for I:= 0 to (StateList.Count - 1) do
         PaintUnstableState(TheNuclideCanvas, aRect, StateList[I]);
// Now Write Header
        if (ShowText) then
        begin //Header
         Brush.Style:= bsClear;
         Font.Assign(FontSymbol);
         Font.Color:= FontColor;
//         TextOut(Rect.Left+1, Rect.Top, ' '+Symbol+' '+IntToStr(Amass));
         if not (KarteInfo.SpecialFont) then
          TextOut(Rect.Left + 1, Rect.Top, Symbol + '-' + IntToStr(Amass))
         else
          TextOut(Rect.Left + 2, Rect.Top, NKstrSymbol(Symbol, IntToStr(Amass)));
        end;
// Now Write Header - END
       end
       else if (StateList.Count = 1) then
       begin //(StateList.Count<=1)
        aRect:= KarteInfo.Rect;
        PaintUnstableState(TheNuclideCanvas, aRect, StateList[0]);
       end
       else
       begin
        aRect:= KarteInfo.Rect;
        Brush.Color:= clWhite;
        FillRect(aRect);
        if ShowText then
        begin
         Font.Assign(FontSymbol);
         Font.Color:= (clBlack);
//         TextOut(Rect.Left+1, Rect.Top+1, '  '+Symbol+' '+IntToStr(Amass));
         if not (KarteInfo.SpecialFont) then
          TextOut(Rect.Left + 1, Rect.Top, Symbol + '-' + IntToStr(Amass))
         else
          TextOut(Rect.Left + 2, Rect.Top, NKstrSymbol(Symbol, IntToStr(Amass)));
         Brush.Color:= clBlack;
         with aRect do
          Ellipse((Left + Right) div 2 - 3, (Top + Bottom) div 2 - 3,
           (Left + Right) div 2 + 3, (Top + Bottom) div 2 + 3); //Ellipse(X1, Y1, X2, Y2: Integer);
        end;
//         MessageDlg('Number of states for unstable nuclide is equal to ZERO!!!', mtWarning, [mbOK], 0);
       end; // (StateList.Count<=1)
      end; // UnStable
     else
      begin // Unknown NuclideType
       Brush.Style:= bsSolid;
       Brush.Color:= clWhite;
       FillRect(Rect);
       if ShowText then
       begin
        Font.Assign(FontSymbol);
        Font.Color:= (clWhite xor Brush.Color);
//       TextOut(Rect.Left+1, Rect.Top+1, '  '+Symbol+' '+IntToStr(Amass));
        if not (KarteInfo.SpecialFont) then
         TextOut(Rect.Left + 1, Rect.Top, Symbol + '-' + IntToStr(Amass))
        else
         TextOut(Rect.Left + 2, Rect.Top, NKstrSymbol(Symbol, IntToStr(Amass)));
       end;
      end;
    end; //case NuclideType
    with Pen do
    begin
     Style:= psSolid;
     Color:= clBlack;
     Width:= 1;
    end;
//    FrameRect( Rect); - do not work
    MoveTo(0, 0);
    LineTo(Rect.Right, 0);
    LineTo(Rect.Right, Rect.Bottom);
    LineTo(0, Rect.Bottom);
    LineTo(0, 0);
   end; //  with TheNuclideCanvas, KarteInfo do
   Result:= TmpMeta
  finally
   TheNuclideCanvas.Free;
  end; // try .. finally
 except
  Result:= nil;
 end; // try..except
end; {GetMetafile}

{TNuclideState}

function TNuclideState.GetLambda: Float;
begin
 if ((IsStable) or (T1_2 <= 0)) then
 begin
  Result:= 0;
  exit;
 end;
 Result:= Ln2 / T1_2;
end;

function TNuclideState.GetTotalSigmaC: extended;
var
 I: integer;
begin
 Result:= 0;
 for I:= 0 to Captures.Count - 1 do
  if Captures[I].Sigma > 0 then
   Result:= Result + Captures[I].Sigma;
end;

function TNuclideState.GetTotalRI: extended;
var
 I: integer;
begin
 Result:= 0;
 for I:= 0 to RIs.Count - 1 do
  if RIs[I].Value > 0 then
   Result:= Result + RIs[I].Value;
end;

function TNuclideState.GetTotalSigmaFast: extended;
begin
 Result:= 0;
 if SigmaNP > 0 then
  result:= result + SigmaNP;
 if SigmaNA > 0 then
  result:= result + SigmaNA;
 if SigmaN2N > 0 then
  result:= result + SigmaN2N;
 if SigmaNG > 0 then
  result:= result + SigmaNG;
end;

function TNuclideState.GetStateName: string;
begin
 Result:= '';
 with Nuclide do
  case (StateList.Count) of
   1: Result:= Symbol + '-' + IntToStr(Amass);
   2: case State of
     0: Result:= Symbol + '-' + IntToStr(Amass) + 'g';
     1: Result:= Symbol + '-' + IntToStr(Amass) + 'm';
     else
      ShowMessage('GetStateName: StateCount=2 State > 1');
    end;
   3: case State of
     0: Result:= Symbol + '-' + IntToStr(Amass) + 'g';
     1: Result:= Symbol + '-' + IntToStr(Amass) + 'm1';
     2: Result:= Symbol + '-' + IntToStr(Amass) + 'm2';
     else
      ShowMessage('GetStateName: StateCount=3 State > 2');
    end;
   else
    ShowMessage('GetStateName: StateCount>3 ');
  end;
end;

function TNuclideState.IsStable: Boolean;
begin
// if (Abs(T1_2-2.E17)/2.E17)<1E-5 then Result:= True
 if ((T1_2 / 2.E17 < 1.00001) and (T1_2 / 2.E17 > 0.99999)) then
  Result:= True
 else
  Result:= False;
end;

procedure TNuclideState.Assign(Source: TNuclideState);
var
 I: integer;
 aDecay: TDecay;
 aCapture: TCapture;
 aRI: TRI;
 aAlpha: TAlpha;
 aBeta: TBeta;
 aGamma: TGamma;
 aElectron: TElectron;
 aPositron: TPositron;
 aYield: TYield;
begin
 if (Self = Source) then
  Exit;
 SigmaF:= Source.SigmaF;
 RIf:= Source.RIf;
 SigmaNP:= Source.SigmaNP;
 SigmaNA:= Source.SigmaNA;
 SigmaN2N:= Source.SigmaN2N;
 SigmaNN:= Source.SigmaNN;
 SigmaNG:= Source.SigmaNG;
// g_factor:= Source.g_factor;
 if Decays <> Source.Decays then
  Decays.Clear;
 if Captures <> Source.Captures then
  Captures.Clear;
 if RIs <> Source.RIs then
  RIs.Clear;
 if Alphas <> Source.Alphas then
  Alphas.Clear;
 if Betas <> Source.Betas then
  Betas.Clear;
 if Gammas <> Source.Gammas then
  Gammas.Clear;
 if Electrons <> Source.Electrons then
  Electrons.Clear;
 if Positrons <> Source.Positrons then
  Positrons.Clear;
 if Yields <> Source.Yields then
  Yields.Clear;
 T1_2:= Source.T1_2;
 State:= Source.State;
 for I:= 0 to (Source.Decays.Count - 1) do
 begin
  aDecay:= Source.Decays[I];
  Decays.Add(aDecay);
 end;
 for I:= 0 to (Source.Captures.Count - 1) do
 begin
  aCapture:= Source.Captures[I];
  Captures.Add(aCapture);
 end;
 Captures.G_factor:= Source.Captures.G_factor;
 for I:= 0 to (Source.RIs.Count - 1) do
 begin
  aRI:= Source.RIs[I];
  RIs.Add(aRI);
 end;
 for I:= 0 to (Source.Alphas.Count - 1) do
 begin
  aAlpha:= Source.Alphas[I];
  Alphas.Add(aAlpha);
 end;
 for I:= 0 to (Source.Betas.Count - 1) do
 begin
  aBeta:= Source.Betas[I];
  Betas.Add(aBeta);
 end;
 for I:= 0 to (Source.Gammas.Count - 1) do
 begin
  aGamma:= Source.Gammas[I];
  Gammas.Add(aGamma);
 end;
 for I:= 0 to (Source.Electrons.Count - 1) do
 begin
  aElectron:= Source.Electrons[I];
  Electrons.Add(aElectron);
 end;
 for I:= 0 to (Source.Positrons.Count - 1) do
 begin
  aPositron:= Source.Positrons[I];
  Positrons.Add(aPositron);
 end;
 for I:= 0 to (Source.Yields.Count - 1) do
 begin
  aYield:= Source.Yields[I];
  Yields.Add(aYield);
 end;
end; {TNuclideState.Assign( Source: TNuclideState);}

procedure TNuclideState.OrderDecays;
var
 I, J: integer;
begin
 if Decays.Count < 2 then
  Exit;
 for J:= 1 to (Decays.Count - 1) do
 begin
  I:= J;
  while (Decays[I].Branching > Decays[I - 1].Branching) do
  begin
   Decays.Exchange(I, I - 1);
   if I = 1 then
    break;
   Dec(I);
  end;
 end;
end;

procedure TNuclideState.OrderAlphas;
var
 I, J: integer;
begin
 if Alphas.Count < 2 then
  Exit;
 for J:= 1 to (Alphas.Count - 1) do
 begin
  I:= J;
  while (Alphas[I].Probability > Alphas[I - 1].Probability) do
  begin
   Alphas.Exchange(I, I - 1);
   if I = 1 then
    break;
   Dec(I);
  end;
 end;
end;

procedure TNuclideState.OrderBetas;
var
 I, J: integer;
begin
 if Betas.Count < 2 then
  Exit;
 for J:= 1 to (Betas.Count - 1) do
 begin
  I:= J;
  while (Betas[I].Probability > Betas[I - 1].Probability) do
  begin
   Betas.Exchange(I, I - 1);
   if I = 1 then
    break;
   Dec(I);
  end;
 end;
end;

procedure TNuclideState.OrderGammas;
var
 I, J: integer;
begin
 if Gammas.Count < 2 then
  Exit;
 for J:= 1 to (Gammas.Count - 1) do
 begin
  I:= J;
  while (Gammas[I].Probability > Gammas[I - 1].Probability) do
  begin
   Gammas.Exchange(I, I - 1);
   if I = 1 then
    break;
   Dec(I);
  end;
 end;
end;

procedure TNuclideState.OrderElectrons;
var
 I, J: integer;
begin
 if Electrons.Count < 2 then
  Exit;
 for J:= 1 to (Electrons.Count - 1) do
 begin
  I:= J;
  while (Electrons[I].Probability > Electrons[I - 1].Probability) do
  begin
   Electrons.Exchange(I, I - 1);
   if I = 1 then
    break;
   Dec(I);
  end;
 end;
end;

procedure TNuclideState.OrderPositrons;
var
 I, J: integer;
begin
 if Positrons.Count < 2 then
  Exit;
 for J:= 1 to (Positrons.Count - 1) do
 begin
  I:= J;
  while (Positrons[I].Probability > Positrons[I - 1].Probability) do
  begin
   Positrons.Exchange(I, I - 1);
   if I = 1 then
    break;
   Dec(I);
  end;
 end;
end;

procedure TNuclideState.OrderYields;
var
 I, J: integer;
begin
 if Yields.Count < 2 then
  Exit;
 for J:= 1 to (Yields.Count - 1) do
 begin
  I:= J;
  while (Yields[I].ParentThZpA < Yields[I - 1].ParentThZpA) do
  begin
   Yields.Exchange(I, I - 1);
   if I = 1 then
    break;
   Dec(I);
  end;
 end;
end;

procedure TNuclideState.OrderCaptures;
var
 I, J: integer;
begin
 with Captures do
 begin
// Order
  if (Count > 1) then
   for J:= 1 to (Count - 1) do
   begin
    I:= J;
    while (Captures[I].ToState < Captures[I - 1].ToState) do
    begin
     Exchange(I, I - 1);
     if I = 1 then
      break;
     Dec(I);
    end;
   end;
// InsertMissing
  if Count > 0 then
  begin
   while (Count - 1) < Captures[Count - 1].ToState do
   begin
    if (Captures[0].ToState <> 0) then
    begin
     Insert(0, ZiroCaptureToG);
    end;
    if (Captures[1].ToState <> 1) then
    begin
     Insert(1, ZiroCaptureToM1);
    end;
   end;
  end;
 end;
end;

procedure TNuclideState.OrderRIs;
var
 I, J: integer;
begin
 with RIs do
 begin
// Order
  if (Count > 1) then
   for J:= 1 to (Count - 1) do
   begin
    I:= J;
    while (RIs[I].ToState < RIs[I - 1].ToState) do
    begin
     Exchange(I, I - 1);
     if I = 1 then
      break;
     Dec(I);
    end;
   end;
// InsertMissing
  if Count > 0 then
  begin
   while (Count - 1) < RIs[Count - 1].ToState do
   begin
    if (RIs[0].ToState <> 0) then
    begin
     Insert(0, ZiroRIToG);
    end;
    if (RIs[1].ToState <> 1) then
    begin
     Insert(1, ZiroRIToM1);
    end;
   end;
  end;
 end;
end;

constructor TNuclideState.Create(aNuclide: TNuclide);
begin
 inherited Create;
 Nuclide:= aNuclide;
 State:= 9;
 T1_2:= -1;
 SigmaF:= 0.0;
 RIf:= 0.0;
 SigmaNP:= 0.0;
 SigmaNA:= 0.0; //(n,alpha)
 SigmaN2N:= 0.0;
 SigmaNN:= 0.0; //(n,n')
 SigmaNG:= 0.0;
 Captures:= TCaptureList.Create(Self);
 Alphas:= TAlphaList.Create(Self);
 Betas:= TBetaList.Create(Self);
 Gammas:= TGammaList.Create(Self);
 Electrons:= TElectronList.Create(Self);
 Positrons:= TPositronList.Create(Self);
 Yields:= TYieldList.Create(Self);
 RIs:= TRIList.Create(Self);
 Decays:= TDecayList.Create(Self);
end;

destructor TNuclideState.Destroy;
begin
 Captures.Free;
 RIs.Free;
 Decays.Free;
 inherited Destroy;
end;

function TNuclideState.GetThZpA_s: integer;
begin
 try
  Result:= State + Nuclide.Amass * 10 + Nuclide.Znum * 10000;
 except
  Result:= 0;
 end;
end;

{TNuclideList}

function TNuclideList.GetNuclide(Index: integer): TNuclide;
begin
 Result:= TNuclide(Items[Index]);
end;

function TNuclideList.FindThZpA_s(const ThZpA_s: Integer; var NuclideNo, StateNo: integer): Boolean;
var
 I, J: integer;
begin
 Result:= False;
 I:= Self.FindInList((ThZpA_s div 10) div 1000, (ThZpA_s div 10) mod 1000);
 if I >= 0 then
  for J:= 0 to Self[I].StateList.Count - 1 do
   if Self[I].StateList[J].State = ThZpA_s mod 10 then
   begin
    Result:= True;
    NuclideNo:= I;
    StateNo:= J;
    break;
   end;
end;

function TNuclideList.FindChilds(const TheDataModule: TDataModule; const ThZpA_s: Integer; Transitions: TNuclideTransitions;
 ChildList: TLongIntList; VelocityList: TFloatList = nil;
 const ThermalMult: Float = 1E-20; const ResonanceMult: Float = 1E-20; const FastMult: Float = 1E-20): Boolean;
var
 I, J, K, ProductThZpA, ProductState, C: integer; // C added after Melissa see *.pas20
 TheState: TNuclideState;
 TheSubBranchingList: TSubBranchingList;
 TheIntList: TLongIntList;
 VelocityListCreated: Boolean;
begin
 ChildList.Clear;
 if VelocityList = nil then
 begin
  VelocityList:= TFloatList.Create;
  VelocityListCreated:= True;
 end
 else
 begin
  VelocityList.Clear; // QQQQ added after Melissa
  VelocityListCreated:= False;
 end;
 TheIntList:= TLongIntList.Create;
 try
  try
   Result:= True;
   if FindThZpA_s(ThZpA_s, I, J) then
   begin
    TheState:= Self[I].StateList[J];
    with TheState do
    begin
     if ntDecay in Transitions then
     begin
      for I:= 0 to TheState.Decays.Count - 1 do
       if TheState.Decays[I].Branching >= 0 then // QQQQQQ was >0
//       if TheState.Decays[I].Branching > 0 then
       begin // DecayType = dtSF - dose not work
        ProductThZpA:= DecayProductThZpA(ThZpA_s div 10, TheState.Decays[I].DecayType);
        ProductState:= TheState.State;
        if FindThZpA_s(ProductThZpA * 10 + ProductState, J, K) then
        begin
         if ChildList.AddUniq(ProductThZpA * 10 + ProductState) >= 0 then
          VelocityList.Add(TheState.Decays[I].Branching * TheState.Lambda);
        end
        else {// no Product with the same State}  if FindThZpA_s(ProductThZpA * 10 + 0, J, K) then
        begin
         if ChildList.AddUniq(ProductThZpA * 10 + 0) >= 0 then
          VelocityList.Add(TheState.Decays[I].Branching * TheState.Lambda);
        end;
        TheSubBranchingList:= TSubBranchingList.Create(TheState);
        if (TheDataModule is T_DataModuleOOB) then
        begin
         if T_DataModuleOOB(TheDataModule).ReadSubBranchingList(ThZpA_s, TheSubBranchingList) then
          for J:= 0 to TheSubBranchingList.Count - 1 do
           if TheSubBranchingList[J].DecayType = TheState.Decays[I].DecayType then
           begin
            if TheSubBranchingList[J].BranchingToG > 0 then // QQQQQ
             if FindThZpA_s(ProductThZpA * 10 + 0, K, K) then
             begin
              C:= ChildList.IndexOf(ProductThZpA * 10 + 0);
              if C < 0 then
              begin
               if ChildList.AddUniq(ProductThZpA * 10 + 0) >= 0 then
                VelocityList.Add(TheState.Decays[I].Branching * TheSubBranchingList[J].BranchingToG * TheState.Lambda);
              end
              else
              begin
               VelocityList[C]:= (TheState.Decays[I].Branching * TheSubBranchingList[J].BranchingToG * TheState.Lambda);
              end;
             end;
            if TheSubBranchingList[J].BranchingToM1 > 0 then
             if FindThZpA_s(ProductThZpA * 10 + 0, K, K) then
             begin
              C:= ChildList.IndexOf(ProductThZpA * 10 + 1);
              if C < 0 then
              begin
               if ChildList.AddUniq(ProductThZpA * 10 + 1) >= 0 then
                VelocityList.Add(TheState.Decays[I].Branching * TheSubBranchingList[J].BranchingToM1 * TheState.Lambda);
              end
              else
              begin
               VelocityList[C]:= (TheState.Decays[I].Branching * TheSubBranchingList[J].BranchingToM1 * TheState.Lambda);
              end;
             end;
            if TheSubBranchingList[J].BranchingToM2 > 0 then
             if FindThZpA_s(ProductThZpA * 10 + 0, K, K) then
             begin
              C:= ChildList.IndexOf(ProductThZpA * 10 + 2);
              if C < 0 then
              begin
               if ChildList.AddUniq(ProductThZpA * 10 + 2) >= 0 then
                VelocityList.Add(TheState.Decays[I].Branching * TheSubBranchingList[J].BranchingToM2 * TheState.Lambda);
              end
              else
              begin
               VelocityList[C]:= (TheState.Decays[I].Branching * TheSubBranchingList[J].BranchingToM2 * TheState.Lambda);
              end;
             end;
           end;
(*
          for J:= 0 to TheSubBranchingList.Count - 1 do
           if TheSubBranchingList[J].DecayType = TheState.Decays[I].DecayType then
           begin
            if TheSubBranchingList[J].BranchingToG > 0 then
             if FindThZpA_s(ProductThZpA * 10 + 0, K, K) then
             begin
              if ChildList.AddUniq(ProductThZpA * 10 + 0) >= 0 then
               VelocityList.Add(TheState.Decays[I].Branching * TheSubBranchingList[J].BranchingToG / 100. * TheState.Lambda);
             end;
            if TheSubBranchingList[J].BranchingToM1 > 0 then
             if FindThZpA_s(ProductThZpA * 10 + 1, K, K) then
             begin
              if ChildList.AddUniq(ProductThZpA * 10 + 1) >= 0 then
               VelocityList.Add(TheState.Decays[I].Branching * TheSubBranchingList[J].BranchingToM1 / 100. * TheState.Lambda);
             end;
            if TheSubBranchingList[J].BranchingToM2 > 0 then
             if FindThZpA_s(ProductThZpA * 10 + 2, K, K) then
             begin
              if ChildList.AddUniq(ProductThZpA * 10 + 2) >= 0 then
               VelocityList.Add(TheState.Decays[I].Branching * TheSubBranchingList[J].BranchingToM2 / 100. * TheState.Lambda);
             end;
           end;
*)
        end;
       end;
     end;
     if ntCapture in Transitions then
     begin
      for I:= 0 to TheState.Captures.Count - 1 do
       if TheState.Captures[I].Sigma > 0 then
        if FindThZpA_s(ThZpA_s + 10 + TheState.Captures[I].ToState, J, K) then
        begin
         if ChildList.AddUniq(ThZpA_s + 10 + TheState.Captures[I].ToState) >= 0 then
          VelocityList.Add(TheState.Captures[I].Sigma * ThermalMult);
        end;
      for I:= 0 to TheState.RIs.Count - 1 do
       if TheState.RIs[I].Value > 0 then
        if FindThZpA_s(ThZpA_s + 10 + TheState.RIs[I].ToState, J, K) then
        begin
         if ChildList.AddUniq(ThZpA_s + 10 + TheState.RIs[I].ToState) >= 0 then
          VelocityList.Add(TheState.RIs[I].Value * ResonanceMult);
        end;
// SpecialCapture Cases (n,p) (n,alpha) on Thermal
      try
       if (TheDataModule is T_DataModuleOOB) then
        if T_DataModuleOOB(TheDataModule).LoadSpecialCaptureProducts(ThZpA_s, TheIntList) then
         for J:= 0 to TheIntList.Count - 1 do
          if FindThZpA_s(TheIntList[J], K, K) then
           ChildList.AddUniq(TheIntList[J]);
//         if ChildList.AddUniq(TheIntList[J])>=0 then
//          VelocityList.Add(TheState.Sigma*ThermalMult *1E-3);
       TheIntList.Clear;
      except

      end;
     end;
     if ntThreshold in Transitions then
     begin // Always -> To Ground State 0   (N,N')-> +?
      if TheState.SigmaNP > 0 then
      begin
       WasProductThZpA:= (ThZpA_s div 10) - 1000 - 1 + 1;
       ProductThZpA:= ThresholdProductThZpA(ThZpA_s div 10, 'NP');
       if FindThZpA_s(ProductThZpA * 10 + 0, K, K) then
        if ChildList.AddUniq(ProductThZpA * 10 + 0) >= 0 then
         VelocityList.Add(TheState.SigmaNP * FastMult);
      end;
      if TheState.SigmaNA > 0 then
      begin
       WasProductThZpA:= (ThZpA_s div 10) - 2000 - 4 + 1;
       ProductThZpA:= ThresholdProductThZpA(ThZpA_s div 10, 'NA');
       if FindThZpA_s(ProductThZpA * 10 + 0, K, K) then
        if ChildList.AddUniq(ProductThZpA * 10 + 0) >= 0 then
         VelocityList.Add(TheState.SigmaNA * FastMult);
      end;
      if TheState.SigmaN2N > 0 then
      begin
       WasProductThZpA:= (ThZpA_s div 10) - 2 + 1;
       ProductThZpA:= ThresholdProductThZpA(ThZpA_s div 10, 'N2N');
       if FindThZpA_s(ProductThZpA * 10 + 0, K, K) then
        if ChildList.AddUniq(ProductThZpA * 10 + 0) >= 0 then
         VelocityList.Add(TheState.SigmaN2N * FastMult);
      end;
      if TheState.SigmaNN > 0 then
      begin
       WasProductThZpA:= (ThZpA_s div 10);
       ProductThZpA:= ThresholdProductThZpA(ThZpA_s div 10, 'NN');
       if FindThZpA_s(ProductThZpA * 10 + TheState.State + 1, K, K) then
        if ChildList.AddUniq(ProductThZpA * 10 + TheState.State + 1) >= 0 then
         VelocityList.Add(TheState.SigmaNN * FastMult);
       if FindThZpA_s(ProductThZpA * 10 + TheState.State + 2, K, K) then
        if ChildList.AddUniq(ProductThZpA * 10 + TheState.State + 2) >= 0 then
         VelocityList.Add(TheState.SigmaNN * FastMult);
      end;
      if TheState.SigmaNG > 0 then
      begin
       WasProductThZpA:= (ThZpA_s div 10) + 1;
       ProductThZpA:= ThresholdProductThZpA(ThZpA_s div 10, 'NG');
       if FindThZpA_s(ProductThZpA * 10 + 0, K, K) then
        if ChildList.AddUniq(ProductThZpA * 10 + 0) >= 0 then
         VelocityList.Add(TheState.SigmaNG * FastMult);
      end;
     end;
     if ntFission in Transitions then
     begin
      if ((TheState.SigmaF > 0) or (TheState.RIf > 0)) then
       if (TheDataModule is T_DataModuleOOB) then
        if T_DataModuleOOB(TheDataModule).LoadFissionProducts(ThZpA_s, TheIntList) then
         for J:= 0 to TheIntList.Count - 1 do
          if FindThZpA_s(TheIntList[J], K, K) then
           if ChildList.AddUniq(TheIntList[J]) >= 0 then
            VelocityList.Add(TheState.SigmaF * FastMult * 1E-3);
      TheIntList.Clear;
     end;
    end;
   end;
   Result:= True;
  except
   Result:= False;
  end;
 finally
  if VelocityListCreated then
  begin
   VelocityList.Free;
  end;
  TheIntList.Free;
 end;
end;

function TNuclideList.FindChain2(const TheDataModule: TDataModule; const ThZpA_sStart, ThZpA_sFinish: integer; var MaxStepNo: Longint; Transitions: TNuclideTransitions;
 Answer: TLongIntList; ChainFinderMaxTime: DWORD = 30000; const ThermalMult: Float = 1E-20; const ResonanceMult: Float = 1E-20; const FastMult: Float = 1E-20;
 FirstStep: Boolean = True): Boolean;
var
 I, J, K, L, SelfThZpA_s, TheChild, TheParent, TheLevel, StepNo: integer;
 ChildThZpA_sList, ParentThZpA_sList, TmpIntList, TmpAnswer, FindList, FindList1: TLongIntList;
 LevelChildsList, LevelParentsList: TList;
 PresentsAbove: Boolean;
begin
 if FirstStep then
  Self.AbortChainFinder:= False;
 Result:= False;
 try
  Answer.Clear;
  StepNo:= 0;
  if FindThZpA_s(ThZpA_sStart, I, I) and FindThZpA_s(ThZpA_sFinish, I, I) then
  begin
   LevelChildsList:= TList.Create;
   LevelParentsList:= TList.Create;
   TmpIntList:= TLongIntList.Create;
   ChildThZpA_sList:= TLongIntList.Create;
   ParentThZpA_sList:= TLongIntList.Create;
   TmpAnswer:= TLongIntList.Create;
   ChildThZpA_sList.Add(ThZpA_sStart);
   try
    ParentThZpA_sList.Add(-1);
    LevelChildsList.Add(ChildThZpA_sList); //[ThZpA_sStart]-LevelChild[0]
    LevelParentsList.Add(ParentThZpA_sList);
    for I:= 1 to MaxStepNo do
    begin
     ChildThZpA_sList:= TLongIntList.Create;
     ParentThZpA_sList:= TLongIntList.Create;
     for J:= 0 to TLongIntList(LevelChildsList[I - 1]).Count - 1 do
     begin
      SelfThZpA_s:= TLongIntList(LevelChildsList[I - 1])[J];
      if FindChilds(TheDataModule, SelfThZpA_s, Transitions, TmpIntList) then
       for K:= 0 to TmpIntList.Count - 1 do
       begin
        PresentsAbove:= False;
        for L:= 0 to LevelChildsList.Count - 2 do
         if (TLongIntList(LevelChildsList[L]).IndexOf(TmpIntList[K]) >= 0) then
         begin
          PresentsAbove:= True;
          break;
         end;
        if not (PresentsAbove) then
        begin
         if Self.AbortChainFinder then
          raise Exception.Create('ChainFinder search aborted !');
         Application.ProcessMessages;
         ChildThZpA_sList.Add(TmpIntList[K]);
         ParentThZpA_sList.Add(SelfThZpA_s);
        end;
       end;
     end;
     LevelChildsList.Add(ChildThZpA_sList);
     LevelParentsList.Add(ParentThZpA_sList);
     if TLongIntList(LevelChildsList[I]).Count <= 0 then
      break;
     if (TLongIntList(LevelChildsList[I]).Count <>
      TLongIntList(LevelParentsList[I]).Count) then
      exit;
// Look For Finish
     FindList:= TLongIntList.Create;
     try
      TLongIntList(LevelChildsList[I]).IndicesOf(ThZpA_sFinish, FindList);
      for J:= 0 to FindList.Count - 1 do
      begin
       TheChild:= TLongIntList(LevelChildsList[I])[FindList[J]];
       TheParent:= TLongIntList(LevelParentsList[I])[FindList[J]];
       TheLevel:= I;
       repeat
        TmpAnswer.Add(TheChild);
        FindList1:= TLongIntList.Create;
        try
         TLongIntList(LevelChildsList[TheLevel - 1]).IndicesOf(TheParent, FindList1);
         Dec(TheLevel);
         for K:= 0 to FindList1.Count - 1 do
         begin
          TheChild:= TLongIntList(LevelChildsList[TheLevel])[FindList1[K]];
          TheParent:= TLongIntList(LevelParentsList[TheLevel])[FindList1[K]];
         end;
        finally
         FindList1.Free;
        end;
       until ((TheParent = -1) or (TheLevel < 0));
       TmpAnswer.Add(ThZpA_sStart);
       TmpAnswer.Add(-10);
      end;
      StepNo:= I;
     finally
      FindList.Free;
     end;
    end;
   finally
    MaxStepNo:= StepNo;
    if TmpAnswer.Count > 0 then
    begin
     if TmpAnswer.Last > 0 then
      TmpAnswer.Add(-13);
// Avoid duples
     TmpIntList.Assign(TmpAnswer);
     for I:= LevelChildsList.Count - 1 downto 0 do
      TLongIntList(LevelChildsList[I]).Free;
     LevelChildsList.Clear;
     for I:= LevelParentsList.Count - 1 downto 0 do
      TLongIntList(LevelParentsList[I]).Free;
     LevelParentsList.Clear;
     ChildThZpA_sList:= TLongIntList.Create;
     for I:= TmpIntList.Count - 1 downto 0 do
     begin
      if TmpIntList[I] < 0 then
      begin
       ChildThZpA_sList:= TLongIntList.Create;
       LevelChildsList.Add(ChildThZpA_sList);
      end;
      ChildThZpA_sList.Add(TmpIntList[I]);
     end;
     for I:= LevelChildsList.Count - 1 downto 0 do
      for J:= LevelChildsList.Count - 1 downto I + 1 do
       if ListEqual(TLongIntList(LevelChildsList[J]), TLongIntList(LevelChildsList[I])) then
       begin
        TLongIntList(LevelChildsList[J]).Free;
        LevelChildsList.Delete(J);
       end;
     for I:= 0 to LevelChildsList.Count - 1 do
      for J:= 0 to TLongIntList(LevelChildsList[I]).Count - 1 do
       Answer.Add(TLongIntList(LevelChildsList[I])[J]);
     Result:= True;
    end;
    for I:= LevelChildsList.Count - 1 downto 0 do
     TLongIntList(LevelChildsList[I]).Free;
    LevelChildsList.Free;
    for I:= LevelParentsList.Count - 1 downto 0 do
     TLongIntList(LevelParentsList[I]).Free;
    LevelParentsList.Free;
    TmpIntList.Free;
    TmpAnswer.Free;
   end; //try..finally
  end
  else
   Result:= False;
 except
// Mo Exeptions
 end;
end;

function TNuclideList.FindChain1(const TheDataModule: TDataModule; const ThZpA_sStart, ThZpA_sFinish: integer; var MaxStepNo: Longint; Transitions: TNuclideTransitions;
 Answer: TLongIntList; ChainFinderMaxTime: DWORD = 30000; const ThermalMult: Float = 1E-20; const ResonanceMult: Float = 1E-20; const FastMult: Float = 1E-20;
 FirstStep: Boolean = True): Boolean;
var
 I, J, SelfThZpA_s, TheChild: integer;
 MaxStepNext: Longint;
 ChildList: TLongIntList;
 VelocityList: TFloatList;
 TmpAnswers: TLongIntList; // reversed
 ChainFinderTime: DWORD;
begin
 Application.ProcessMessages;
 if FindThZpA_s(ThZpA_sStart, I, I) and FindThZpA_s(ThZpA_sFinish, I, I) then
 begin
  TmpAnswers:= TLongIntList.Create;
  Result:= False;
  SelfThZpA_s:= ThZpA_sStart;
  if MaxStepNo < 0 then
  begin
   Exit;
  end;
  if FirstStep then
  begin
   fChainFinderTimeAborted:= False;
   fAbortChainFinder:= False;
   Answer.Clear;
   ChainFinderConsided.Clear;
   ChainFinderHavePath.Clear;
   ChainFinderInitTime:= GetTickCount;
  end;
  if SelfThZpA_s = ThZpA_sFinish then
  begin
   Answer.Add(-1);
   Answer.Add(SelfThZpA_s);
   Result:= True;
   Exit;
  end;
  ChainFinderTime:= GetTickCount - ChainFinderInitTime;
// ?????????????????????????????
  if ChainFinderTime > ChainFinderMaxTime then
  begin
   fChainFinderTimeAborted:= True;
   Exit;
  end;
  if Self.AbortChainFinder then
   raise Exception.Create('ChainFinder search aborted !');
  ChildList:= TLongIntList.Create;
  VelocityList:= TFloatList.Create;
  if ChainFinderHavePath.IndexOf(SelfThZpA_s) >= 0 then
  begin
   Answer.Add(-1);
//   Answer.Add(SelfThZpA_s); // qqqq may be comment this line ??
   Result:= True;
   Exit;
  end;
  if ChainFinderConsided.IndexOf(SelfThZpA_s) >= 0 then
   Exit;
  ChainFinderConsided.AddUniq(SelfThZpA_s); // To avoid double work
  if FindThZpA_s(SelfThZpA_s, I, J) then
  begin
   FindChilds(T_DataModuleOOB(TheDataModule), SelfThZpA_s, Transitions,
    ChildList, VelocityList,
    ThermalMult, ResonanceMult, FastMult);
   ChildList.OrderByFloatList(VelocityList);
  end
  else
   Result:= False;
  ChildList.OrderByFloatList(VelocityList);
  for I:= 0 to ChildList.Count - 1 do
  begin
   TheChild:= ChildList[I];
   MaxStepNext:= MaxStepNo - 1;
   if FindChain1(TheDataModule, TheChild, ThZpA_sFinish, MaxStepNext, Transitions,
    Answer, ChainFinderMaxTime, ThermalMult, ResonanceMult, FastMult, False) then
   begin
    Answer.Add(SelfThZpA_s);
    Result:= True;
    ChainFinderHavePath.AddUniq(SelfThZpA_s);
   end;
  end;
  ChildList.Free;
  if FirstStep then
  begin
   TmpAnswers.Assign(Answer);
   Answer.Clear;
   for I:= TmpAnswers.Count - 1 downto 0 do
    Answer.Add(TmpAnswers[I]);
   TmpAnswers.Free;
  end;
 end
 else
  Result:= False;
end;

(*
function TNuclideList.FindChain1(const TheDataModule: TDataModule; const ThZpA_sStart, ThZpA_sFinish: integer; var MaxStepNo: Longint; Transitions: TNuclideTransitions;
 Answer: TLongIntList; ChainFinderMaxTime: DWORD=30000; const ThermalMult: Float=1E-20; const ResonanceMult: Float=1E-20; const FastMult: Float=1E-20;
 FirstStep: Boolean=True): Boolean;
var
 I, J, SelfThZpA_s, TheChild: integer;
 MaxStepNext: Longint;
 ChildList: TLongIntList;
 VelocityList: TFloatList;
 TmpAnswers: TLongIntList; // reversed
 ChainFinderTime: DWORD;
begin
 Application.ProcessMessages;
 if FindThZpA_s(ThZpA_sStart, I, I)and FindThZpA_s(ThZpA_sFinish, I, I) then begin
  TmpAnswers:= TLongIntList.Create;
  Result:= False;
  SelfThZpA_s:= ThZpA_sStart;
  if MaxStepNo<0 then begin
   Exit;
  end;
  if FirstStep then begin
   fChainFinderTimeAborted:= False;
   fAbortChainFinder:= False;
   Answer.Clear;
   ChainFinderConsided.Clear;
   ChainFinderHavePath.Clear;
   ChainFinderInitTime:= GetTickCount;
  end;
  if SelfThZpA_s=ThZpA_sFinish then begin
   Answer.Add(-1);
   Answer.Add(SelfThZpA_s);
   Result:= True;
   exit;
  end;
  ChainFinderTime:= GetTickCount-ChainFinderInitTime;
// ?????????????????????????????
  if ChainFinderTime>ChainFinderMaxTime then begin
   fChainFinderTimeAborted:= True;
   Exit;
  end;
  if Self.AbortChainFinder then
   raise Exception.Create('ChainFinder search aborted !');
  ChildList:= TLongIntList.Create;
  VelocityList:= TFloatList.Create;
  if ChainFinderHavePath.IndexOf(SelfThZpA_s)>=0 then begin
   Answer.Add(-1);
   Answer.Add(SelfThZpA_s);
   Result:= True;
   Exit;
  end;
  if ChainFinderConsided.IndexOf(SelfThZpA_s)>=0 then
   Exit;
  ChainFinderConsided.AddUniq(SelfThZpA_s); // To avoid double work
  if FindThZpA_s(SelfThZpA_s, I, J) then begin
   FindChilds(T_DataModuleOOB(TheDataModule), SelfThZpA_s, Transitions,
    ChildList, VelocityList,
    ThermalMult, ResonanceMult, FastMult);
   ChildList.OrderByFloatList(VelocityList);
  end
  else
   Result:= False;
  ChildList.OrderByFloatList(VelocityList);
  for I:= 0 to ChildList.Count-1 do begin
   TheChild:= ChildList[I];
   MaxStepNext:= MaxStepNo-1;
   if FindChain1(TheDataModule, TheChild, ThZpA_sFinish, MaxStepNext, Transitions,
    Answer, ChainFinderMaxTime, ThermalMult, ResonanceMult, FastMult, False) then begin
    Answer.Add(SelfThZpA_s);
    Result:= True;
    ChainFinderHavePath.AddUniq(SelfThZpA_s);
   end;
  end;
  ChildList.Free;
  if FirstStep then begin
   TmpAnswers.Assign(Answer);
   Answer.Clear;
   for I:= TmpAnswers.Count-1 downto 0 do
    Answer.Add(TmpAnswers[I]);
   TmpAnswers.Free;
  end;
 end
 else
  Result:= False;
end;
*)

function TNuclideList.FindInList(const Znum, aMass: integer): integer;
var
 I: integer;
 Found: Boolean;
begin
 Result:= -1;
 Found:= False;
 for I:= 0 to (Count - 1) do
  if (Self[I].Amass = aMass) and (Self[I].Znum = Znum) then
  begin
   Found:= True;
   break;
  end;
 if Found then
  Result:= I;
end;

procedure TNuclideList.SetNuclide(Index: integer; aNuclide: TNuclide);
begin
 TNuclide(Items[Index]).Free;
 Items[Index]:= Pointer(aNuclide);
end;

procedure TNuclideList.Add(aNuclide: TNuclide);
begin
 inherited Add(aNuclide);
end;

destructor TNuclideList.Destroy;
var
 I: integer;
begin
 for I:= 0 to (Count - 1) do
 begin
  Self[I].Free;
  Items[I]:= nil;
 end;
 inherited Destroy;
end;

function TNuclideList.GetFindChain(Index: integer): TFindChain;
begin
 Result:= FFindChain[Index mod 2];
end;

constructor TNuclideList.Create;
begin
 inherited Create;
 FFindChain[1]:= FindChain1;
 FFindChain[0]:= FindChain2;
end;

function TNuclideList.LoadFromDB(DataModule: TDataModule; ProgressBar: TProgressBar = nil): Boolean;
begin
 if (DataModule is T_DataModuleDAO) then
 begin
  try
   Result:= T_DataModuleDAO(DataModule).ReadNuclideList(Self, ProgressBar);
  except
   Result:= False;
  end;
 end
 else if (DataModule is T_DataModuleOOB) then
 begin
  try
   Result:= T_DataModuleOOB(DataModule).ReadNuclideList(Self, ProgressBar);
  except
   Result:= False;
  end;
 end
 else
  Result:= False;
end;

function TNuclideList.GetLink(const ThZpA_sStart, ThZpA_sFinish: Integer;
 var Answers: TStringList;
 Transitions: TNuclideTransitions = [ntCapture, ntFission, ntDecay, ntThreshold];
 aDataModule: TDataModule = nil; LoadWithCumYield: Boolean = True): DWORD; //   DataModuleOOB - for SubBranchings
var
 I, J, K, L, ThZpA_s: integer;
 TheState, FinishState: TNuclideState;
 TheSubBranchingList: TSubBranchingList;
 aStr, aEndStr: string;
 TheDataModule: TDataModule;
 NeedG_factor, NoDecay: Boolean;
 aFloat, aSigma, aG_factorSpecial, aRI: Float;
begin
 Answers.Clear;
 Result:= sltNone; // NoLinks
 if not (FindThZpA_s(ThZpA_sStart, I, J) and FindThZpA_s(ThZpA_sFinish, K, L)) then
  exit;
 if (aDataModule = nil) then
  TheDataModule:= _DataModuleOOB // There was   TheDataModule:= _DataModuleOOB no if...else
 else
  TheDataModule:= aDataModule;
 TheState:= Self[I].StateList[J]; // TheState==StartState
 FinishState:= Self[K].StateList[L];
 ThZpA_s:= ThZpA_sStart;
 Answers.Add(IntToStr(ThZpA_sStart));
 Answers.Add(IntToStr(ThZpA_sFinish));
 NeedG_factor:= False;
 if (ntDecay in Transitions) then
  for I:= 0 to TheState.Decays.Count - 1 do
   if TheState.Decays[I].Branching >= 0 then // QQQQQQ was >0 DecayType = dtSF - dose not work
    if (ThZpA_sFinish div 10 = DecayProductThZpA(ThZpA_s div 10, TheState.Decays[I].DecayType)) then
    begin
     NoDecay:= False;
     if (TheState.Decays[I].DecayType = dtIT) then
// DecayType = dtIT now:
// 1) m1->m2, g->m1, g->m2 by IT are forbidden
// 2) if NoSubbranching then m2->g
     begin
      if ((ThZpA_sFinish mod 10) > (ThZpA_sStart mod 10)) then // m1->m2, g->m1, g->m2 by IT are forbidden
       continue;
     end;
     aStr:= InternalTextFormat(TheState.Decays[I].Branching / 100) +
      '*' + InternalTextFormat(TheState.Lambda) + '// DECAY ' + DecayStr(TheState.Decays[I].DecayType) + '*lambda from NuclideList';
     TheSubBranchingList:= TSubBranchingList.Create(TheState);
     try
      if (TheDataModule is T_DataModuleOOB) then
       if T_DataModuleOOB(TheDataModule).ReadSubBranchingList(ThZpA_s, TheSubBranchingList) then
        if (TheSubBranchingList.Count > 0) then
         for J:= 0 to TheSubBranchingList.Count - 1 do
         begin
          if TheSubBranchingList[J].DecayType = TheState.Decays[I].DecayType then
          begin
           if ((Round(TheSubBranchingList[J].BranchingToG) >= 0) and (ThZpA_sFinish mod 10 = 0)) then
            aStr:= InternalTextFormat(TheSubBranchingList[J].BranchingToG) + '*' + aStr + ' and SubBranching added'
           else if ((Round(TheSubBranchingList[J].BranchingToM1) >= 0) and (ThZpA_sFinish mod 10 = 1)) then
            aStr:= InternalTextFormat(TheSubBranchingList[J].BranchingToM1) + '*' + aStr + ' and SubBranching added'
           else if ((Round(TheSubBranchingList[J].BranchingToM2) >= 0) and (ThZpA_sFinish mod 10 = 2)) then
            aStr:= InternalTextFormat(TheSubBranchingList[J].BranchingToM2) + '*' + aStr + ' and SubBranching added';
           break;
          end;
         end
        else if ((ThZpA_sStart mod 10 = 0) and (ThZpA_sFinish mod 10 > 0) or
         (ThZpA_sStart mod 10 = 1) and (ThZpA_sFinish mod 10 > 1) or
         (ThZpA_sStart mod 10 = 2) and (ThZpA_sFinish mod 10 = 1)) then
        begin
         NoDecay:= True;
         aStr:= '//Decay no SubBranching g->m m1->m2 is set to 0'; // qq no g->m1 g->m2 m1->m2
        end
        else
// dt<> IT
// if the child state with the same as parent state presents in NuclideList then decay 100% to this, else 100% to g
// to avoid user's mistake aStr:= '//Decay Child with the same state as Parent present in the NuclideList, others set to 0';
        begin
         if (TheState.Decays[I].DecayType <> dtIT) then
          if (FindThZpA_s((10 * ThZpA_sFinish div 10) + ThZpA_sStart mod 10, K, L)) then
           if ((ThZpA_sFinish mod 10) <> (ThZpA_sStart mod 10)) then
           begin
            //            NoDecay:= True; // qqqq comments are for debug qq else (no comments) link will not be visible
            aStr:= '//Decay Child with the same state as Parent present in the NuclideList, others set to 0';
           end;
        end;
     finally
      TheSubBranchingList.Free;
      if not (NoDecay) then
      begin
       Answers.Add(aStr);
       Result:= Result or sltDecay;
      end;
     end;

    end;
// Alpha generation
 if (ThZpA_sFinish = 20040) then
  if (ntDecay in Transitions) then
   for I:= 0 to TheState.Decays.Count - 1 do
    if TheState.Decays[I].Branching >= 0 then
     if TheState.Decays[I].DecayType = dtA then
     begin
      NoDecay:= False;
      aStr:= InternalTextFormat(TheState.Decays[I].Branching / 100) +
       '*' + InternalTextFormat(TheState.Lambda) + '// DECAY ' + DecayStr(TheState.Decays[I].DecayType) + '*lambda from NuclideList';
      TheSubBranchingList:= TSubBranchingList.Create(TheState);
      TheSubBranchingList:= TSubBranchingList.Create(TheState);
      try
       if (TheDataModule is T_DataModuleOOB) then
        if T_DataModuleOOB(TheDataModule).ReadSubBranchingList(ThZpA_s, TheSubBranchingList) then
         if (TheSubBranchingList.Count > 0) then
          for J:= 0 to TheSubBranchingList.Count - 1 do
          begin
           if TheSubBranchingList[J].DecayType = TheState.Decays[I].DecayType then
           begin
            if ((Round(TheSubBranchingList[J].BranchingToG) >= 0) and (ThZpA_sFinish mod 10 = 0)) then
             aStr:= InternalTextFormat(TheSubBranchingList[J].BranchingToG) + '*' + aStr + ' and SubBranching added'
            else if ((Round(TheSubBranchingList[J].BranchingToM1) >= 0) and (ThZpA_sFinish mod 10 = 1)) then
             aStr:= InternalTextFormat(TheSubBranchingList[J].BranchingToM1) + '*' + aStr + ' and SubBranching added'
            else if ((Round(TheSubBranchingList[J].BranchingToM2) >= 0) and (ThZpA_sFinish mod 10 = 2)) then
             aStr:= InternalTextFormat(TheSubBranchingList[J].BranchingToM2) + '*' + aStr + ' and SubBranching added';
            break;
           end;
          end
         else if ((ThZpA_sStart mod 10 = 0) and (ThZpA_sFinish mod 10 > 0) or
          (ThZpA_sStart mod 10 = 1) and (ThZpA_sFinish mod 10 > 1) or
          (ThZpA_sStart mod 10 = 2) and (ThZpA_sFinish mod 10 = 1)) then
         begin
          NoDecay:= True;
          aStr:= '//Decay no SubBranching g->m m1->m2 is set to 0'; // qq no g->m1 g->m2 m1->m2
         end
         else
// dt<> IT
// if the child state with the same as parent state presents in NuclideList then decay 100% to this, else 100% to g
// to avoid user's mistake aStr:= '//Decay Child with the same state as Parent present in the NuclideList, others set to 0';
         begin
          if (TheState.Decays[I].DecayType <> dtIT) then
           if (FindThZpA_s((10 * ThZpA_sFinish div 10) + ThZpA_sStart mod 10, K, L)) then
            if ((ThZpA_sFinish mod 10) <> (ThZpA_sStart mod 10)) then
            begin
            //            NoDecay:= True; // qqqq comments are for debug qq else (no comments) link will not be visible
             aStr:= '//Decay Child with the same state as Parent present in the NuclideList, others set to 0';
            end;
         end;
      finally
       TheSubBranchingList.Free;
       if not (NoDecay) then
       begin
        Answers.Add(aStr);
        Result:= Result or sltDecay;
       end;
      end;
     end;
// Alpha generation added end
 if (ntCapture in Transitions) then
 begin
  for I:= 0 to TheState.Captures.Count - 1 do
   if TheState.Captures[I].Sigma > 0 then
    if ((ThZpA_sFinish div 10 = ThZpA_sStart div 10 + 1) and (ThZpA_sFinish mod 10 = TheState.Captures[I].ToState)) then
    begin
     aStr:= InternalTextFormat(TheState.Captures[I].Sigma) + 'b // THERMAL Capture to ' + IntToStr(TheState.Captures[I].ToState) + ' from NuclideList';
     Answers.Add(aStr);
     Result:= Result or sltThermal;
     NeedG_factor:= True;
     break;
    end;
  for I:= 0 to TheState.RIs.Count - 1 do
   if TheState.RIs[I].Value > 0 then
    if ((ThZpA_sFinish div 10 = ThZpA_sStart div 10 + 1) and (ThZpA_sFinish mod 10 = TheState.RIs[I].ToState)) then
    begin
     aStr:= InternalTextFormat(TheState.RIs[I].Value) + 'b // RESONANCE RI to ' + IntToStr(TheState.RIs[I].ToState) + ' from NuclideList';
     Answers.Add(aStr);
     Result:= Result or sltResonance;
     break;
    end;
// qqqq Special Cases
  if (TheDataModule is T_DataModuleOOB) then
//     with T_DataModuleOOB(TheDataModule).VSpecialCaptureCases do
//(*
  begin
   if T_DataModuleOOB(TheDataModule).ReadSpecialCaptureDetail(ThZpA_sStart, ThZpA_sFinish, aSigma, aG_factorSpecial, aRI) then
   begin
    if aSigma > 0 then
    begin
     aStr:= InternalTextFormat(aSigma) + 'b';
     aEndStr:= ' // THERMAL SpecialCase Sigma';
     if aG_factorSpecial > 0 then
     begin
      aStr:= aStr + '*' + InternalTextFormat(aG_factorSpecial);
      aEndStr:= aEndStr + '*G_Special';
     end;
     aEndStr:= aEndStr + ' autocreated';
     aStr:= aStr + aEndStr;
     Answers.Add(aStr);
     Result:= Result or sltThermal;
     NeedG_factor:= True;
    end;
    if aRI > 0 then
    begin
     aStr:= InternalTextFormat(aRI) + 'b // RESONANCE RI SpecialCase autocreated';
     Answers.Add(aStr);
     Result:= Result or sltResonance;
    end;
   end;
  end;
//*)
 end;
 if (ntThreshold in Transitions) then
 begin
  if TheState.SigmaNP > 0 then
   if (ThZpA_sFinish div 10 = ThresholdProductThZpA(ThZpA_s div 10, 'NP')) then
    if (ThZpA_sFinish mod 10 = 0) then
    begin
     aStr:= InternalTextFormat(TheState.SigmaNP) + 'b // FAST SigmaNP from NuclideList';
     Answers.Add(aStr);
     Result:= Result or sltFast;
     NeedG_factor:= True;
    end;
  if TheState.SigmaNA > 0 then
   if (ThZpA_sFinish div 10 = ThresholdProductThZpA(ThZpA_s div 10, 'NA')) then
    if (ThZpA_sFinish mod 10 = 0) then
    begin
     aStr:= InternalTextFormat(TheState.SigmaNA) + 'b // FAST SigmaNA from NuclideList';
     Answers.Add(aStr);
     Result:= Result or sltFast;
     NeedG_factor:= True;
    end;
  if TheState.SigmaN2N > 0 then
   if (ThZpA_sFinish div 10 = ThresholdProductThZpA(ThZpA_s div 10, 'N2N')) then
    if (ThZpA_sFinish mod 10 = 0) then
    begin
     aStr:= InternalTextFormat(TheState.SigmaN2N) + 'b // FAST SigmaN2N from NuclideList';
     Answers.Add(aStr);
     Result:= Result or sltFast;
     NeedG_factor:= True;
    end;
  if TheState.SigmaNN > 0 then
   if (ThZpA_sFinish div 10 = ThresholdProductThZpA(ThZpA_s div 10, 'NN')) then
    if (ThZpA_sFinish mod 10 = ThZpA_s mod 10 + 1) then
    begin
     // qqqq // NN' - not equal to g->m
     //     aStr:= InternalTextFormat(TheState.SigmaNN)+'b // FAST SigmaNN from NuclideList';
     aStr:= '// ' + InternalTextFormat(TheState.SigmaNN) + 'b // FAST SigmaNN from NuclideList';
     Answers.Add(aStr);
     Result:= Result or sltFast;
     NeedG_factor:= True;
    end;
  if TheState.SigmaNG > 0 then
   if (ThZpA_sFinish div 10 = ThresholdProductThZpA(ThZpA_s div 10, 'NG')) then
    if (ThZpA_sFinish mod 10 = 0) then
    begin
     aStr:= InternalTextFormat(TheState.SigmaNG) + 'b // FAST SigmaNG from NuclideList';
     Answers.Add(aStr);
     Result:= Result or sltFast;
     NeedG_factor:= True;
    end;
 end;
 if NeedG_factor then
  if TheState.Captures.g_factor > 0 then
  begin // CapturesAdded
   aStr:= InternalTextFormat(TheState.Captures.g_factor) + ' // G_FACTOR from NuclideList'; //CapturesAdded
   Answers.Add(aStr);
  end;
// Fission
 if (ntFission in Transitions) then
  if LoadWithCumYield then
  begin
   if ((TheState.SigmaF > 0) or (TheState.RIf > 0)) then
    for I:= 0 to FinishState.Yields.Count - 1 do
    begin
     if FinishState.Yields[I].ParentThZpA = ThZpA_s div 10 then
     begin
//      if ((FinishState.Yields[I].CumYieldT>0)and(TheState.SigmaF>0)) then begin
      begin
       aStr:= InternalTextFormat(TheState.SigmaF) + 'b*' +
        InternalTextFormat(FinishState.Yields[I].CumYieldT) + '%  // THERMAL SigmaF*CumYieldT from NuclideList';
       Answers.Add(aStr);
       Result:= Result or sltThermal;
      end;
//      if ((FinishState.Yields[I].CumYieldT>0)and(TheState.RIf>0)) then begin// Resaonance Yield == Thermal spectra
      begin
       aStr:= InternalTextFormat(TheState.RIf) + 'b*' +
        InternalTextFormat(FinishState.Yields[I].CumYieldT) + '%  // RESONANCE RIf*CumYieldT from NuclideList';
       Answers.Add(aStr);
       Result:= Result or sltResonance;
      end;
      break;
     end;
    end;
// Fast Fission
//   if (ntThreshold in Transitions) then    // ntThreshold - not Always
   if TheDataModule is T_DataModuleOOB then
   begin
    aFloat:= T_DataModuleOOB(TheDataModule).GetSigmaFastFissionForThZpA_s(10 * (TheState.Nuclide.Znum * 1000 + TheState.Nuclide.Amass) + TheState.State);
    if (aFloat > 0) then
     for I:= 0 to FinishState.Yields.Count - 1 do
      if FinishState.Yields[I].ParentThZpA = ThZpA_s div 10 then
//       if (FinishState.Yields[I].CumYieldF>0) then begin
      begin
       aStr:= InternalTextFormat(aFloat) + 'b*' +
        InternalTextFormat(FinishState.Yields[I].CumYieldF) + '%  // Fast SigmaF*CumYieldF from DM';
       Answers.Add(aStr);
       Result:= Result or sltFast;
       break;
      end;
   end;
//*)
  end // end of LoadWithCumYield
  else
  begin
   if ((TheState.SigmaF > 0) or (TheState.RIf > 0)) then
    for I:= 0 to FinishState.Yields.Count - 1 do
    begin
     if FinishState.Yields[I].ParentThZpA = ThZpA_s div 10 then
     begin
//      if ((FinishState.Yields[I].IndYieldT>-1.0E-13)and(TheState.SigmaF>0)) then begin
      begin
       aStr:= InternalTextFormat(TheState.SigmaF) + 'b*' +
        InternalTextFormat(FinishState.Yields[I].IndYieldT) + '%  // THERMAL SigmaF*IndYieldT from NuclideList';
       Answers.Add(aStr);
       Result:= Result or sltThermal;
      end;
//      if ((FinishState.Yields[I].IndYieldT>-1.0E-13)and(TheState.RIf>0)) then begin// Resaonance Yield == Thermal spectra
      begin
       aStr:= InternalTextFormat(TheState.RIf) + 'b*' +
        InternalTextFormat(FinishState.Yields[I].IndYieldT) + '%  // RESONANCE RIf*IndYieldT from NuclideList';
       Answers.Add(aStr);
       Result:= Result or sltResonance;
      end;
      break;
     end;
    end;
// Fast Fission from OOB
//   if (ntThreshold in Transitions) then    // ntThreshold - not Always
   if TheDataModule is T_DataModuleOOB then
   begin
    aFloat:= T_DataModuleOOB(TheDataModule).GetSigmaFastFissionForThZpA_s(10 * (TheState.Nuclide.Znum * 1000 + TheState.Nuclide.Amass) + TheState.State);
    if (aFloat > 0) then
     for I:= 0 to FinishState.Yields.Count - 1 do
      if FinishState.Yields[I].ParentThZpA = ThZpA_s div 10 then
       if (FinishState.Yields[I].IndYieldF > -1.0E-13) then
       begin
        aStr:= InternalTextFormat(aFloat) + 'b*' +
         InternalTextFormat(FinishState.Yields[I].IndYieldF) + '%  // Fast SigmaF*IndYieldF from DM';
        Answers.Add(aStr);
        Result:= Result or sltFast;
        break;
       end;
   end;
  end;
end;

function TNuclideList.FindChainTest(const TheDataModule: TDataModule;
 const ThZpA_sStart, ThZpA_sFinish: integer; var MaxStepNo: Longint;
 Transitions: TNuclideTransitions; Answer: TLongIntList;
 ChainFinderMaxTime: DWORD; const ThermalMult, ResonanceMult,
 FastMult: Float; FirstStep: Boolean): Boolean;
label
 NextUpStep;
var
 Step, PP, P, C, I, J, K: integer;
 ParentThZpA_s: integer;
 ParentList, ChildList: TLongIntList;
 BigList, ParentLists, ChildLists: Tlist;
begin
 Answer.Clear;
 BigList:= Tlist.Create;
 ChildLists:= Tlist.Create;
 ParentLists:= Tlist.Create;
 ParentList:= TLongIntList.Create;
 ParentLists.Add(ParentList);
 ParentList.Add(ThZpA_sStart);
 ChildList:= TLongIntList.Create;
 ChildList.Add(ThZpA_sStart);
 ChildLists.Add(ChildList);
 FindChilds(TheDataModule, ParentList[0], Transitions, ChildList, nil);
 BigList.Add(ParentLists);
 for Step:= 1 to MaxStepNo do
 begin
  ParentLists:= ChildLists;
  BigList.Add(ParentLists);
  for PP:= 0 to ParentLists.Count - 1 do
  begin
   ParentList:= ParentLists[PP];
   for P:= 1 to ParentList.Count - 1 do
   begin
    ChildList:= TLongIntList.Create;
    FindChilds(TheDataModule, ParentList[P], Transitions, ChildList, nil);
    ChildList.Insert(0, ParentList[PP]);
    for C:= 0 to ChildList.Count - 1 do
     if ChildList[C] = ThZpA_sFinish then
     begin
      Answer.Add(-1);
      Answer.Insert(Answer.Count - 2, ThZpA_sFinish);
      ParentThZpA_s:= ChildList[0];
      for I:= Step - 1 downto 0 do
      begin
       NextUpStep:
       for J:= 0 to TList(BigList[I]).Count - 1 do
        for K:= 0 to TLongIntList(TList(BigList[I])[J]).Count - 1 do
         if TLongIntList(TList(BigList[I])[J])[K] = ParentThZpA_s then
         begin
          Answer.Insert(Answer.Count - 2, ParentThZpA_s);
          ParentThZpA_s:= TLongIntList(TList(BigList[I])[J])[0];
          goto NextUpStep
         end;
      end;
      ChildLists.Add(ChildList);
     end;
   end;
  end;
 end;
 {
  FindChilds(const TheDataModule: TDataModule;const ThZpA_s: Integer;Transitions: TNuclideTransitions;
    ChildList: TLongIntList;VelocityList: TFloatList=nil;
 }
end;

(*
function TNuclideList.FindChainDstar(const TheDataModule: TDataModule;
type
 tState=(tsNEW,tsOPEN,tsCLOSED);
var
 ChildList,OPENlist, CLOSEDlist: TLongIntList;
 
 function t(const aThZpA_s: longint): tState;
 begin
  if OPENlist.IndexOf( aThZpA_s)>=0 then
   Result:= tsOPEN
  else if CLOSEDlist.IndexOf( aThZpA_s)>=0 then
   Result:= tsCLOSED
  else
   Result:= tsNEW;
 end;
 function h(const aThZpA_sG, aThZpA_sX: longint): Float; // cost function
 begin
  Result:=1.0;
 end;
 
begin
//
 Childlist:= TLongIntList.Create;
 OPENlist:= TLongIntList.Create;
 CLOSEDlist:= TLongIntList.Create;
 try
 finally
  Childlist.Free;
  OPENlist.Free;
  CLOSEDlist.Free;
 end;
end;
*)

function TNuclideList.FindThZpA_sState(
 const ThZpA_s: integer): TNuclideState;
var
 NuclideNo, StateNo: integer;
begin
 Result:= nil;
 if Self.FindThZpA_s(ThZpA_s, NuclideNo, StateNo) then
  Result:= Self[NuclideNo].StateList[StateNo];
end;

function TNuclideList.FindChildsViaSubBranchingRecordList(
 SubBranchingRecordList: TSubBranchingRecordList; const ThZpA_s: integer;
 const Transitions: TNuclideTransitions; ChildList: TLongIntList;
 VelocityList: TFloatList; const ThermalMult, ResonanceMult,
 FastMult: float): Boolean;
var
 I, J, K, ProductThZpA, ProductState, C: integer;
 TheState: TNuclideState;
 TheSubBranchingList: TSubBranchingList;
 TheIntList: TLongIntList;
 VelocityListCreated: Boolean;
begin
 ChildList.Clear;
 if VelocityList = nil then
 begin
  VelocityList:= TFloatList.Create;
  VelocityListCreated:= True;
 end
 else
 begin
  VelocityList.Clear;
  VelocityListCreated:= False;
 end;
 TheIntList:= TLongIntList.Create;
 try
  try
   Result:= True;
   if FindThZpA_s(ThZpA_s, I, J) then
   begin
    TheState:= Self[I].StateList[J];
    with TheState do
    begin
     if ntDecay in Transitions then
     begin
      for I:= 0 to TheState.Decays.Count - 1 do
       if TheState.Decays[I].Branching >= 0 then // QQQQQ was > 0
//       if TheState.Decays[I].Branching > 0 then
       begin // DecayType = dtSF - dose not work
        ProductThZpA:= DecayProductThZpA(ThZpA_s div 10, TheState.Decays[I].DecayType);
        if (TheState.Decays[I].DecayType = dtIT) then
         ProductState:= 0
        else
         ProductState:= TheState.State;
        if FindThZpA_s(ProductThZpA * 10 + ProductState, J, K) then
        begin
         if ChildList.AddUniq(ProductThZpA * 10 + ProductState) >= 0 then
          VelocityList.Add(TheState.Decays[I].Branching * TheState.Lambda);
        end
        else { // no Product with the same State }  if FindThZpA_s(ProductThZpA * 10 + 0, J, K) then
        begin
         if ChildList.AddUniq(ProductThZpA * 10 + 0) >= 0 then
          VelocityList.Add(TheState.Decays[I].Branching * TheState.Lambda);
        end;
        TheSubBranchingList:= TSubBranchingList.Create(TheState);
        if (SubBranchingRecordList <> nil) then
        begin
         if SubBranchingRecordList.ReadSubBranchingList(ThZpA_s, TheSubBranchingList) then
          for J:= 0 to TheSubBranchingList.Count - 1 do
           if TheSubBranchingList[J].DecayType = TheState.Decays[I].DecayType then
           begin
            if TheSubBranchingList[J].BranchingToG > 0 then // QQQQQ
             if FindThZpA_s(ProductThZpA * 10 + 0, K, K) then
             begin
              C:= ChildList.IndexOf(ProductThZpA * 10 + 0);
              if C < 0 then
              begin
               if ChildList.AddUniq(ProductThZpA * 10 + 0) >= 0 then
                VelocityList.Add(TheState.Decays[I].Branching * TheSubBranchingList[J].BranchingToG * TheState.Lambda);
              end
              else
              begin
               VelocityList[C]:= (TheState.Decays[I].Branching * TheSubBranchingList[J].BranchingToG * TheState.Lambda);
              end;
             end;
            if TheSubBranchingList[J].BranchingToM1 > 0 then
             if FindThZpA_s(ProductThZpA * 10 + 0, K, K) then
             begin
              C:= ChildList.IndexOf(ProductThZpA * 10 + 1);
              if C < 0 then
              begin
               if ChildList.AddUniq(ProductThZpA * 10 + 1) >= 0 then
                VelocityList.Add(TheState.Decays[I].Branching * TheSubBranchingList[J].BranchingToM1 * TheState.Lambda);
              end
              else
              begin
               VelocityList[C]:= (TheState.Decays[I].Branching * TheSubBranchingList[J].BranchingToM1 * TheState.Lambda);
              end;
             end;
            if TheSubBranchingList[J].BranchingToM2 > 0 then
             if FindThZpA_s(ProductThZpA * 10 + 0, K, K) then
             begin
              C:= ChildList.IndexOf(ProductThZpA * 10 + 2);
              if C < 0 then
              begin
               if ChildList.AddUniq(ProductThZpA * 10 + 2) >= 0 then
                VelocityList.Add(TheState.Decays[I].Branching * TheSubBranchingList[J].BranchingToM2 * TheState.Lambda);
              end
              else
              begin
               VelocityList[C]:= (TheState.Decays[I].Branching * TheSubBranchingList[J].BranchingToM2 * TheState.Lambda);
              end;
             end;
           end;

        end;
       end;
     end;
    end;
   end;
// Remove Parent aded
   ChildList.Remove(ThZpA_s);
   Result:= True;
  except
   Result:= False;
  end;
 finally
  if VelocityListCreated then
  begin
   VelocityList.Free;
  end;
  TheIntList.Free;
 end;
end;
(*
function TNuclideList.RemoveNullsFromBrunchings: Boolean;
var
 I, S, D: integer;
 aState: TNuclideState;
 aDecay: TDecay;
begin
 try
  for I:= 0 to Self.Count - 1 do
   for S:= 0 to Self[I].StateList.Count - 1 do
   begin
    aState:= Self[I].StateList[S];
    if aState.Decays.Count >= 1 then //= 1
     for D:= 0 to aState.Decays.Count - 1 do
     begin
      if aState.Decays[D].Branching = 0 then
      begin
       aDecay.DecayType:= aState.Decays[D].DecayType;
       case aState.Decays.Count of
        1: aDecay.Branching:= 99.9; // 54-Xe-124
        2:
         begin
          aDecay.Branching:= 49.9; // 92-Cm-237
          if D = 0 then
           if (aState.Decays[1].Branching > 0) then
            aDecay.Branching:= Floor(100 - aState.Decays[1].Branching-1) + 0.9; // 98-Cf-239
          if D = 1 then
           if (aState.Decays[0].Branching > 0) then
            aDecay.Branching:= Floor(100 - aState.Decays[0].Branching-1) + 0.9; //
         end;
        else
         aDecay.Branching:= 0.678; // 37-Ho-154m
       end;
       aState.Decays[D]:= aDecay;  //101-Md-246
      end;
     end;
   end;
  Result:= True;
 except
  Result:= False;
 end;
end;
*)

{TElementList}

function TElementList.FindInList(const Znum: integer): integer;
var
 I: integer;
 Found: Boolean;
begin
 Result:= -1;
 Found:= False;
 for I:= 0 to (Count - 1) do
  if (Self[I].Znum = Znum) then
  begin
   Found:= True;
   break;
  end;
 if Found then
  Result:= I;
end;

function TElementList.GetElement(Index: integer): TElement;
begin
 Result:= TElement(Items[Index]);
end;

procedure TElementList.SetElement(Index: integer; aElement: TElement);
begin
 TElement(Items[Index]).Free;
 Items[Index]:= Pointer(aElement);
end;

procedure TElementList.Add(aElement: TElement);
begin
 inherited Add(aElement);
end;

destructor TElementList.Destroy;
var
 I: integer;
begin
 for I:= 0 to (Count - 1) do
 begin
  Self[I].Free;
  Items[I]:= nil;
 end;
 inherited Destroy;
end;

constructor TElementList.Create;
begin
 inherited Create;
end;

function TElementList.LoadFromDB(const DataModule: TDataModule; ProgressBar: TProgressBar = nil): Boolean;
begin
 if (DataModule is T_DataModuleDAO) then
 begin
  try
   T_DataModuleDAO(DataModule).ReadElementList(Self, ProgressBar);
   Result:= True;
  except
   Result:= False;
  end;
 end
 else if (DataModule is T_DataModuleOOB) then
 begin
  try
   T_DataModuleOOB(DataModule).ReadElementList(Self, ProgressBar);
   Result:= True;
  except
   Result:= False;
  end;
 end
 else
  Result:= False;
end;

{TStateList}

constructor TStateList.Create(aNuclide: TNuclide);
begin
 inherited Create;
 Nuclide:= aNuclide;
end;

function TStateList.GetNuclideState(Index: integer): TNuclideState;
begin
 Result:= TNuclideState(Items[Index]);
end;

procedure TStateList.SetNuclideState(Index: integer; aNuclideState: TNuclideState);
begin
 TNuclideState(Items[Index]).Free;
 Items[Index]:= Pointer(aNuclideState);
end;

procedure TStateList.Add(aNuclideState: TNuclideState);
begin
 inherited Add(aNuclideState);
end;

destructor TStateList.Destroy;
var
 I: integer;
begin
 for I:= 0 to (Count - 1) do
 begin
  Self[I].Free;
  Items[I]:= nil;
 end;
 inherited Destroy;
end;

{TDecayList}

constructor TDecayList.Create(aState: TNuclideState);
begin
 inherited Create;
 State:= aState;
end;

procedure TDecayList.Normalize;
var
 I: integer;
 fSum: Float;
 aDecay: TDecay;
begin
 if Count < 1 then
  Exit
 else if Count = 1 then
  if Self[0].Branching = 100 then
   Exit;
 fSum:= 0;
 for I:= 0 to Count - 1 do
  if (Self[I].Branching > 0) then
   fSum:= fSum + Self[I].Branching;
 if ((fSum > 0) and (fSum <> 100)) then
  for I:= 0 to Count - 1 do
   if ((Self[I].Branching > 0) and (Self[I].Branching <= 0)) then
   begin
    aDecay:= Self[I];
    aDecay.Branching:= Self[I].Branching / fSum * 100;
    Self[I]:= aDecay;
   end;
end;

function TDecayList.GetDecay(Index: integer): TDecay;
begin
 Result:= TDecay(Items[Index]^);
end;

procedure TDecayList.SetDecay(Index: integer; aDecay: TDecay);
begin
 TDecay(Items[Index]^).DecayType:= aDecay.DecayType;
 TDecay(Items[Index]^).Branching:= aDecay.Branching;
end;

procedure TDecayList.Add(aDecay: TDecay);
var
 NewDecay: PDecay;
begin
 New(NewDecay);
 with NewDecay^ do
 begin
  DecayType:= aDecay.DecayType;
  Branching:= aDecay.Branching;
 end;
 inherited Add(NewDecay);
end;

destructor TDecayList.Destroy;
var
 I: integer;
begin
 for I:= 0 to Count - 1 do
  if (Items[I] <> nil) then
   Dispose(PDecay(Items[I]));
 inherited Destroy;
end;

{TSubBranchingList}

constructor TSubBranchingList.Create(aState: TNuclideState);
begin
 inherited Create;
 State:= aState;
end;

procedure TSubBranchingList.Normalize;
var
 I: integer;
 fSum: Float;
begin
 if Count < 1 then
  Exit
 else if Count = 1 then
  if Self[0].BranchingToG + Self[0].BranchingToM1 + Self[0].BranchingToM2 = 100 then
   Exit;
 for I:= 0 to Count - 1 do
 begin
  fSum:= 0;
  with Self[I] do
  begin
   if BranchingToG > 0 then
    fSum:= fSum + BranchingToG;
   if BranchingToM1 > 0 then
    fSum:= fSum + BranchingToM1;
   if BranchingToM2 > 0 then
    fSum:= fSum + BranchingToM2;
   if ((fSum > 0) and (fSum <> 100)) then
   begin
    if BranchingToG > 0 then
     BranchingToG:= BranchingToG / fSum * 100;
    if BranchingToM1 > 0 then
     BranchingToM1:= BranchingToM1 / fSum * 100;
    if BranchingToM2 > 0 then
     BranchingToM2:= BranchingToM2 / fSum * 100;
   end;
  end;
 end;
end;

function TSubBranchingList.GetSubBranching(Index: integer): TSubBranching;
begin
 Result:= TSubBranching(Items[Index]^);
end;

procedure TSubBranchingList.SetSubBranching(Index: integer; aSubBranching: TSubBranching);
begin
 TSubBranching(Items[Index]^).DecayType:= aSubBranching.DecayType;
 TSubBranching(Items[Index]^).BranchingToG:= aSubBranching.BranchingToG;
 TSubBranching(Items[Index]^).BranchingToM1:= aSubBranching.BranchingToM1;
 TSubBranching(Items[Index]^).BranchingToM2:= aSubBranching.BranchingToM2;
end;

procedure TSubBranchingList.Add(aSubBranching: TSubBranching);
var
 NewSubBranching: PSubBranching;
begin
 New(NewSubBranching);
 with NewSubBranching^ do
 begin
  DecayType:= aSubBranching.DecayType;
  BranchingToG:= aSubBranching.BranchingToG;
  BranchingToM1:= aSubBranching.BranchingToM1;
  BranchingToM2:= aSubBranching.BranchingToM2;
 end;
 inherited Add(NewSubBranching);
end;

destructor TSubBranchingList.Destroy;
var
 I: integer;
begin
 for I:= 0 to Count - 1 do
  if (Items[I] <> nil) then
   Dispose(PSubBranching(Items[I]));
 inherited Destroy;
end;

{TCaptureList}

procedure TCaptureList.SetCaptureToState(ToAstate: integer; aCapture: TCapture);
var
 I: integer;
 WasChanged: Boolean;
begin
 WasChanged:= False;
 for I:= 0 to Count - 1 do
  if Self[I].ToState = ToAstate then
  begin
   Self[I]:= aCapture;
   WasChanged:= True;
   break;
  end;
 if not (WasChanged) then
  Self.Add(aCapture);
end;

function TCaptureList.GetCaptureToState(ToAstate: integer): Float;
var
 I: integer;
begin
 Result:= 0;
 for I:= 0 to Count - 1 do
  if Self[I].ToState = ToAstate then
  begin
   Result:= Self[I].Sigma;
   break;
  end;
end;

constructor TCaptureList.Create(aState: TNuclideState);
begin
 inherited Create;
 State:= aState;
 G_factor:= -1;
end;

destructor TCaptureList.Destroy;
var
 I: integer;
begin
 for I:= 0 to Count - 1 do
  if (Items[I] <> nil) then
   Dispose(PCapture(Items[I]));
 inherited Destroy;
end;

function TCaptureList.GetCapture(Index: integer): TCapture;
begin
 Result:= TCapture(Items[Index]^);
end;

procedure TCaptureList.SetCapture(Index: integer; aCapture: TCapture);
begin
 TCapture(Items[Index]^).ToState:= aCapture.ToState;
 TCapture(Items[Index]^).Sigma:= aCapture.Sigma;
// Dispose(PCapture(Items[Index]));
// Items[Index] := PCapture(@aCapture);
end;

procedure TCaptureList.Add(aCapture: TCapture);
var
 NewCapture: PCapture;
begin
 New(NewCapture);
 with NewCapture^ do
 begin
  ToState:= aCapture.ToState;
  Sigma:= aCapture.Sigma;
 end;
 inherited Add(NewCapture);
end;

procedure TCaptureList.Insert(Index: Integer; aCapture: TCapture);
var
 NewCapture: PCapture;
begin
 New(NewCapture);
 with NewCapture^ do
 begin
  ToState:= aCapture.ToState;
  Sigma:= aCapture.Sigma;
 end;
 inherited Insert(Index, NewCapture);
end;

{TRIList}

constructor TRIList.Create(aState: TNuclideState);
begin
 inherited Create;
 State:= aState;
end;

destructor TRIList.Destroy;
var
 I: integer;
begin
 for I:= 0 to Count - 1 do
  if (Items[I] <> nil) then
   Dispose(PRI(Items[I]));
 inherited Destroy;
end;

function TRIList.GetRI(Index: integer): TRI;
begin
 Result:= TRI(Items[Index]^);
end;

procedure TRIList.SetRI(Index: integer; aRI: TRI);
begin
 TRI(Items[Index]^).ToState:= aRI.ToState;
 TRI(Items[Index]^).Value:= aRI.Value;
// Dispose(PRI(Items[Index]));
// Items[Index] := PRI(@aRI);
end;

procedure TRIList.Add(aRI: TRI);
var
 NewRI: PRI;
begin
 New(NewRI);
 with NewRI^ do
 begin
  ToState:= aRI.ToState;
  Value:= aRI.Value;
 end;
 inherited Add(NewRI);
end;

procedure TRIList.Insert(Index: integer; aRI: TRI);
var
 NewRI: PRI;
begin
 New(NewRI);
 with NewRI^ do
 begin
  ToState:= aRI.ToState;
  Value:= aRI.Value;
 end;
 inherited Insert(Index, NewRI);
end;

{TAlphaList}

constructor TAlphaList.Create(aState: TNuclideState);
begin
 inherited Create;
 State:= aState;
end;

destructor TAlphaList.Destroy;
var
 I: integer;
begin
 for I:= 0 to Count - 1 do
  if (Items[I] <> nil) then
   Dispose(PAlpha(Items[I]));
 inherited Destroy;
end;

function TAlphaList.GetAlpha(Index: integer): TAlpha;
begin
 Result:= TAlpha(Items[Index]^);
end;

procedure TAlphaList.SetAlpha(Index: integer; aAlpha: TAlpha);
begin
 TAlpha(Items[Index]^).MeV:= aAlpha.MeV;
 TAlpha(Items[Index]^).Probability:= aAlpha.Probability;
end;

procedure TAlphaList.Add(aAlpha: TAlpha);
var
 NewAlpha: PAlpha;
begin
 New(NewAlpha);
 with NewAlpha^ do
 begin
  MeV:= aAlpha.MeV;
  Probability:= aAlpha.Probability;
 end;
 inherited Add(NewAlpha);
end;

procedure TAlphaList.Insert(Index: Integer; aAlpha: TAlpha);
var
 NewAlpha: PAlpha;
begin
 New(NewAlpha);
 with NewAlpha^ do
 begin
  MeV:= aAlpha.MeV;
  Probability:= aAlpha.Probability;
 end;
 inherited Insert(Index, NewAlpha);
end;

{TBetaList}

constructor TBetaList.Create(aState: TNuclideState);
begin
 inherited Create;
 State:= aState;
end;

destructor TBetaList.Destroy;
var
 I: integer;
begin
 for I:= 0 to Count - 1 do
  if (Items[I] <> nil) then
   Dispose(PBeta(Items[I]));
 inherited Destroy;
end;

function TBetaList.GetBeta(Index: integer): TBeta;
begin
 Result:= TBeta(Items[Index]^);
end;

procedure TBetaList.SetBeta(Index: integer; aBeta: TBeta);
begin
 TBeta(Items[Index]^).MeV:= aBeta.MeV;
 TBeta(Items[Index]^).MaxMeV:= aBeta.MaxMeV;
 TBeta(Items[Index]^).Probability:= aBeta.Probability;
end;

procedure TBetaList.Add(aBeta: TBeta);
var
 NewBeta: PBeta;
begin
 New(NewBeta);
 with NewBeta^ do
 begin
  MeV:= aBeta.MeV;
  MaxMeV:= aBeta.MaxMeV;
  Probability:= aBeta.Probability;
 end;
 inherited Add(NewBeta);
end;

procedure TBetaList.Insert(Index: Integer; aBeta: TBeta);
var
 NewBeta: PBeta;
begin
 New(NewBeta);
 with NewBeta^ do
 begin
  MeV:= aBeta.MeV;
  MaxMeV:= aBeta.MaxMeV;
  Probability:= aBeta.Probability;
 end;
 inherited Insert(Index, NewBeta);
end;

{TGammaList}

constructor TGammaList.Create(aState: TNuclideState);
begin
 inherited Create;
 State:= aState;
end;

destructor TGammaList.Destroy;
var
 I: integer;
begin
 for I:= 0 to Count - 1 do
  if (Items[I] <> nil) then
   Dispose(PGamma(Items[I]));
 inherited Destroy;
end;

function TGammaList.GetGamma(Index: integer): TGamma;
begin
 Result:= TGamma(Items[Index]^);
end;

procedure TGammaList.SetGamma(Index: integer; aGamma: TGamma);
begin
 TGamma(Items[Index]^).MeV:= aGamma.MeV;
 TGamma(Items[Index]^).Probability:= aGamma.Probability;
end;

procedure TGammaList.Add(aGamma: TGamma);
var
 NewGamma: PGamma;
begin
 New(NewGamma);
 with NewGamma^ do
 begin
  MeV:= aGamma.MeV;
  Probability:= aGamma.Probability;
 end;
 inherited Add(NewGamma);
end;

procedure TGammaList.Insert(Index: Integer; aGamma: TGamma);
var
 NewGamma: PGamma;
begin
 New(NewGamma);
 with NewGamma^ do
 begin
  MeV:= aGamma.MeV;
  Probability:= aGamma.Probability;
 end;
 inherited Insert(Index, NewGamma);
end;

function TGammaList.GetKgamma: Float;
var
 I, J: integer;
 Mu: float;
begin
 Result:= 0;
 if Count < 1 then
 begin
  exit;
 end;
 for I:= 0 to count - 1 do
  if Gammas[I].Probability < 0 then
  begin
   Result:= 0;
   Exit;
  end
  else
  begin
// Mu
   Mu:= 0;
   for J:= 1 to (MuAirNo - 1) do
    if ((Gammas[I].MeV > MuAirE0[J]) and (Gammas[I].MeV <= MuAirE0[J + 1])) then
    begin
     Mu:= MuAirMu[J] + (MuAirMu[J + 1] - MuAirMu[J]) / (MuAirE0[J + 1] - MuAirE0[J]) * (Gammas[I].MeV - MuAirE0[J]);
     break;
    end;
   Result:= Result + 194.5 * Gammas[I].MeV * Gammas[I].Probability * Mu;
  end;
end;

{TElectronList}

constructor TElectronList.Create(aState: TNuclideState);
begin
 inherited Create;
 State:= aState;
end;

destructor TElectronList.Destroy;
var
 I: integer;
begin
 for I:= 0 to Count - 1 do
  if (Items[I] <> nil) then
   Dispose(PElectron(Items[I]));
 inherited Destroy;
end;

function TElectronList.GetElectron(Index: integer): TElectron;
begin
 Result:= TElectron(Items[Index]^);
end;

procedure TElectronList.SetElectron(Index: integer; aElectron: TElectron);
begin
 TElectron(Items[Index]^).MeV:= aElectron.MeV;
 TElectron(Items[Index]^).Probability:= aElectron.Probability;
end;

procedure TElectronList.Add(aElectron: TElectron);
var
 NewElectron: PElectron;
begin
 New(NewElectron);
 with NewElectron^ do
 begin
  MeV:= aElectron.MeV;
  Probability:= aElectron.Probability;
 end;
 inherited Add(NewElectron);
end;

procedure TElectronList.Insert(Index: Integer; aElectron: TElectron);
var
 NewElectron: PElectron;
begin
 New(NewElectron);
 with NewElectron^ do
 begin
  MeV:= aElectron.MeV;
  Probability:= aElectron.Probability;
 end;
 inherited Insert(Index, NewElectron);
end;

{TPositronList}

constructor TPositronList.Create(aState: TNuclideState);
begin
 inherited Create;
 State:= aState;
end;

destructor TPositronList.Destroy;
var
 I: integer;
begin
 for I:= 0 to Count - 1 do
  if (Items[I] <> nil) then
   Dispose(PPositron(Items[I]));
 inherited Destroy;
end;

function TPositronList.GetPositron(Index: integer): TPositron;
begin
 Result:= TPositron(Items[Index]^);
end;

procedure TPositronList.SetPositron(Index: integer; aPositron: TPositron);
begin
 TPositron(Items[Index]^).MeV:= aPositron.MeV;
 TPositron(Items[Index]^).MaxMeV:= aPositron.MaxMeV;
 TPositron(Items[Index]^).Probability:= aPositron.Probability;
end;

procedure TPositronList.Add(aPositron: TPositron);
var
 NewPositron: PPositron;
begin
 New(NewPositron);
 with NewPositron^ do
 begin
  MeV:= aPositron.MeV;
  MaxMeV:= aPositron.MaxMeV;
  Probability:= aPositron.Probability;
 end;
 inherited Add(NewPositron);
end;

procedure TPositronList.Insert(Index: Integer; aPositron: TPositron);
var
 NewPositron: PPositron;
begin
 New(NewPositron);
 with NewPositron^ do
 begin
  MeV:= aPositron.MeV;
  MaxMeV:= aPositron.MaxMeV;
  Probability:= aPositron.Probability;
 end;
 inherited Insert(Index, NewPositron);
end;

{TYieldList}

constructor TYieldList.Create(aState: TNuclideState);
begin
 inherited Create;
 State:= aState;
end;

destructor TYieldList.Destroy;
var
 I: integer;
begin
 for I:= 0 to Count - 1 do
  if (Items[I] <> nil) then
   Dispose(PYield(Items[I]));
 inherited Destroy;
end;

function TYieldList.GetYield(Index: integer): TYield;
begin
 Result:= TYield(Items[Index]^);
end;

procedure TYieldList.SetYield(Index: integer; aYield: TYield);
begin
 TYield(Items[Index]^).ParentThZpA:= aYield.ParentThZpA;
 TYield(Items[Index]^).CumYieldT:= aYield.CumYieldT;
 TYield(Items[Index]^).IndYieldT:= aYield.IndYieldT;
 TYield(Items[Index]^).CumYieldF:= aYield.CumYieldF;
 TYield(Items[Index]^).IndYieldF:= aYield.IndYieldF;
end;

procedure TYieldList.Add(aYield: TYield);
var
 NewYield: PYield;
begin
 New(NewYield);
 with NewYield^ do
 begin
  ParentThZpA:= aYield.ParentThZpA;
  CumYieldT:= aYield.CumYieldT;
  IndYieldT:= aYield.IndYieldT;
  CumYieldF:= aYield.CumYieldF;
  IndYieldF:= aYield.IndYieldF;
 end;
 inherited Add(NewYield);
end;

procedure TYieldList.Insert(Index: Integer; aYield: TYield);
var
 NewYield: PYield;
begin
 New(NewYield);
 with NewYield^ do
 begin
  ParentThZpA:= aYield.ParentThZpA;
  CumYieldT:= aYield.CumYieldT;
  IndYieldT:= aYield.IndYieldT;
  CumYieldF:= aYield.CumYieldF;
  IndYieldF:= aYield.IndYieldF;
 end;
 inherited Insert(Index, NewYield);
end;

{TKarteInfo }

procedure TKarteInfo.SetDefaultColor;
begin
 ITcolor:= clWhite;
 StableColor:= clBlack;
 ECcolor:= clRed;
 BMcolor:= 16777088; //clBlue;
 Acolor:= clYellow;
 SFcolor:= 65408; //clGreen;
 NColor:= 4227072; //clLime;
 Pcolor:= 33023; //clMaroon;
 Qcolor:= 15724527; //clLtGray; //Question
end;

constructor TKarteInfo.Create;
begin
 FontSymbol:= TFont.Create;
 FontT1_2:= TFont.Create;
 FontLast:= TFont.Create;
 with Rect do
 begin //Basic Rect
  Top:= 0;
  Left:= 0;
  Right:= 48;
  Bottom:= 48;
 end;
//try Load Font
 if AddFontResource(PChar('ARIANN__.TTF ')) > 0 then
 begin
  SendMessage(HWND_BROADCAST, WM_FONTCHANGE, 0, 0);
  FontSymbol.Name:= 'Arial Narrow NK';
  FontSymbol.Height:= 9;
  FontT1_2.Assign(FontSymbol);
  FontT1_2.Height:= 7;
  FontLast.Assign(FontT1_2);
  FontLast.Height:= 6;
  SpecialFont:= True;
 end
 else
 begin
  FontSymbol.Assign(Screen.IconFont); // BasicFont
  FontSymbol.Name:= 'Times New Roman';
  FontSymbol.Height:= 9;
  FontT1_2.Assign(FontSymbol);
  FontT1_2.Height:= 6; //7
  FontLast.Assign(FontT1_2);
  FontLast.Name:= 'Symbol';
  FontLast.Height:= 5; //7
  SpecialFont:= False;
 end;
 SetDefaultColor;
end;

destructor TKarteInfo.Destroy;
begin
 if SpecialFont then
  if RemoveFontResource(PChar('ARIANN__.TTF ')) then
   SendMessage(HWND_BROADCAST, WM_FONTCHANGE, 0, 0);
 FontSymbol.Free;
 FontT1_2.Free;
 FontLast.Free;
 inherited;
end;

// LIB

function StrToDecayType(const DecayMode: string): TDecayType;
begin
 if Trim(UpperCase(DecayMode)) = 'A' then
  Result:= dtA
 else if Trim(UpperCase(DecayMode)) = 'B-' then
  Result:= dtBM
 else if Trim(UpperCase(DecayMode)) = 'EC' then
  Result:= dtEC
 else if Trim(UpperCase(DecayMode)) = 'IT' then
  Result:= dtIT
 else if Trim(UpperCase(DecayMode)) = 'N' then
  Result:= dtN
 else if Trim(UpperCase(DecayMode)) = 'P' then
  Result:= dtP
 else if Trim(UpperCase(DecayMode)) = 'SF' then
  Result:= dtSF
 else if Trim(DecayMode) = '' then
  Result:= dtNone
 else
  Result:= dtQ;
end;

function CanvasRectToBitMap(SourceCanvasHDC: HDC; SourceRect: TRect; BitMap: TBitmap): boolean;
begin
 BitMap.FreeImage;
 with SourceRect do
 begin
  Bitmap.Height:= {SourceRect.} Bottom - Top;
  Bitmap.Width:= {SourceRect.} Right - Left;
 end;
 Result:= BitBlt(Bitmap.Canvas.Handle, 0, 0, Bitmap.Width, Bitmap.Height,
  SourceCanvasHDC, 0, 0, SRCCOPY);
 BitMap.Dormant;
end;

function IsStableT1_2(T1_2: float): Boolean;
begin
//if ((T1_2-2.E17)/2.E17>=0)and(T1_2-2.E17)/2.E17<1e-5))or
//((T1_2-2.E17)/2.E17<0)and(T1_2-2.E17)/2.E17>-1e-5))then
// if (Abs(T1_2-2.E17)/2.E17)<1E-5 then Result:= True
 if ((T1_2 < 1.00001 * 2.E17) and (T1_2 > 0.99999 * 2.E17)) then
  Result:= True
 else
  Result:= False;
end;

function DecaySymbol(DecayType: TDecayType): string;
begin
 case DecayType of
  dtNone: Result:= '-';
  dtA: Result:= 'a';
  dtBM: Result:= 'b-';
  dtEC: Result:= 'e';
  dtIT: Result:= 'Ig';
  dtN: Result:= 'N';
  dtP: Result:= 'R';
  dtSF: Result:= 'z';
  else
   Result:= '';
 end;
end;

function DecaySpecialSymbol(DecayType: TDecayType): string;
begin
 case DecayType of
  dtNone: Result:= '-'; //'-';
  dtA: Result:= #47;
  dtBM: Result:= #58;
  dtEC: Result:= #91;
  dtIT: Result:= #123;
  dtN: Result:= 'N';
  dtP: Result:= 'P';
  dtSF: Result:= #94;
  else
   Result:= '';
 end;
end;

function RussionDecaySymbol(DecayType: TDecayType): string;
begin
 case DecayType of
  dtNone: Result:= '-';
  dtA: Result:= 'alpha decay';
  dtBM: Result:= 'beta- decay';
  dtEC: Result:= 'electron capture or beta+ decay';
  dtIT: Result:= 'isomeric transition';
  dtN: Result:= 'neutron decay';
  dtP: Result:= 'proton decay';
  dtSF: Result:= 'spontaneous fission';
  else
   Result:= 'unknown decay';
 end;
end;

function DecayStr(DecayType: TDecayType): string;
begin
 case DecayType of
  dtNone: Result:= '-';
  dtA: Result:= 'A';
  dtBM: Result:= 'B-';
  dtEC: Result:= 'EC';
  dtIT: Result:= 'IT';
  dtN: Result:= 'N';
  dtP: Result:= 'P';
  dtSF: Result:= 'SF';
  else
   Result:= '?';
 end;
end;

function FormatEu(const aFloat: float; const aWidth: integer): string;
var
 I, J: integer;
begin
 if aWidth < 1 then
 begin
  Result:= Format('%-*.*g', [aWidth, aWidth, aFloat]);
  exit;
 end;
 if aFloat < Power(10, -aWidth + 1) then
 begin
  Result:= Format('%-*.*g', [aWidth - 1, aWidth - 1, aFloat]);
  exit;
 end;
 if aFloat < 1 then
 begin
  Result:= Format('%-*.*f', [aWidth, aWidth - 1, aFloat]);
  if (Pos('.', Result) > 0) or (Pos(',', Result) > 0) then
   for J:= Length(Result) downto 2 do
    if (Result[Length(Result)] = '0') then
     Result:= Copy(Result, 1, Length(Result) - 1)
    else
     break;
  if (Result[Length(Result)] = ',') or (Result[Length(Result)] = '.') then
   Result:= Copy(Result, 1, Length(Result) - 1);
  exit;
 end
 else
  for I:= 1 to aWidth + 1 do
   if aFloat < Power(10, I) then
   begin
    if aWidth - I > 0 then
     Result:= Format('%-*.*f', [aWidth, aWidth - I, aFloat])
    else
     Result:= Format('%-*.*f', [aWidth, 0, aFloat]);
    if (Pos('.', Result) > 0) or (Pos(',', Result) > 0) then
     for J:= Length(Result) downto 2 do
      if (Result[Length(Result)] = '0') then
       Result:= Copy(Result, 1, Length(Result) - 1)
      else
       break;
    if (Result[Length(Result)] = ',') or (Result[Length(Result)] = '.') then
     Result:= Copy(Result, 1, Length(Result) - 1);
    exit;
   end;
 Result:= Format('%-*.*g', [aWidth, aWidth, aFloat]);
end;

function T1_2ToStrSpecialFont(T1_2: float; Width: integer = 3): string;
begin
 if (T1_2 <= 0) then
  Result:= '0'
 else if IsStableT1_2(T1_2) then
  Result:= 'STABLE'
 else if (T1_2 < ti_ns) then
  Result:= Trim(FormatEu(T1_2 / ti_ps, Width)) + 'ps'
 else if (T1_2 < ti_mks) then
 begin
  Result:= Trim(FormatEu(T1_2 / ti_ns, Width)) + 'ns';
  if (Result = '1000ns') then
   Result:= '1' + #60;
 end
 else if (T1_2 < ti_ms) then
  Result:= Trim(FormatEu(T1_2 / ti_mks, Width)) + #60
 else if (T1_2 < ti_sec) then
  Result:= Trim(FormatEu(T1_2 / ti_ms, Width)) + #62
 else if (T1_2 < ti_min) then
  Result:= Trim(FormatEu(T1_2 / ti_sec, Width)) + 's'
 else if (T1_2 < ti_hou) then
  Result:= Trim(FormatEu(T1_2 / ti_min, Width)) + 'm'
 else if (T1_2 < ti_day) then
  Result:= Trim(FormatEu(T1_2 / ti_hou, Width)) + 'h'
 else if (T1_2 < ti_yea) then
  Result:= Trim(FormatEu(T1_2 / ti_day, Width)) + 'd'
 else if (T1_2 <= 999 * ti_yea) then
  Result:= Trim(FormatEu(T1_2 / ti_yea, Width)) + 'y'
 else
  Result:= Trim(Format('%-*.*g', [Width, 0, T1_2 / ti_yea])) + 'y';
end;

function T1_2ToStr(T1_2: float; Width: integer = 3): string;
begin
 if (T1_2 <= 0) then
  Result:= '0'
 else if IsStableT1_2(T1_2) then
  Result:= 'STABLE'
 else if (T1_2 < ti_ns) then
  Result:= Trim(FormatEu(T1_2 / ti_ps, Width)) + 'ps'
 else if (T1_2 < ti_mks) then
  Result:= Trim(FormatEu(T1_2 / ti_ns, Width)) + 'ns'
 else if (T1_2 < ti_ms) then
  Result:= Trim(FormatEu(T1_2 / ti_mks, Width)) + 'mk'
 else if (T1_2 < ti_sec) then
  Result:= Trim(FormatEu(T1_2 / ti_ms, Width)) + 'ms'
 else if (T1_2 < ti_min) then
  Result:= Trim(FormatEu(T1_2 / ti_sec, Width)) + 's'
 else if (T1_2 < ti_hou) then
  Result:= Trim(FormatEu(T1_2 / ti_min, Width)) + 'm'
 else if (T1_2 < ti_day) then
  Result:= Trim(FormatEu(T1_2 / ti_hou, Width)) + 'h'
 else if (T1_2 < ti_yea) then
  Result:= Trim(FormatEu(T1_2 / ti_day, Width)) + 'd'
 else if (T1_2 <= 999. * ti_yea) then
  Result:= Trim(FormatEu(T1_2 / ti_yea, Width)) + 'y'
 else
  Result:= Trim(Format('%-*.*g', [Width, 0, T1_2 / ti_yea])) + 'y';
end; {T1_2ToStr}

function TextT1_2ToNum(const Text: string; var aFloat: float): Boolean;
var
 I: integer;
 NumStr, TxtStr: string;
begin
 Result:= True;
 if Copy(UpperCase(Trim(Text)), 1, 2) = 'ST' then
 begin
  aFloat:= 2.E17;
  Exit;
 end;
 try
  for I:= Length(Text) downto 1 do
   if Text[I] in ['0'..'9', ',', '.'] then
    break;
  NumStr:= Copy(Text, 1, I);
  TxtStr:= UpperCase(Trim(Copy(Text, I + 1, Length(Text))));
  for I:= 1 to Length(NumStr) do
   if NumStr[I] = ',' then
    NumStr[I]:= '.'
   else if ((NumStr[I] = #197) or (NumStr[I] = #229)) then // russian e E
    NumStr[I]:= 'E';
  Val(NumStr, aFloat, I);
  if I <> 0 then
  begin
   MessageDlg('TextT1_2ToNum Error at position: ' + IntToStr(I) + ' for "' + Text + '"', mtWarning, [mbOk], 0);
   Result:= False;
  end;
  if (Length(TxtStr) > 0) then
   if (Copy(TxtStr, 1, 1) = 'S') then
    Exit
   else if (Copy(TxtStr, 1, 2) = 'PS') then
    aFloat:= aFloat * ti_ps
   else if (Copy(TxtStr, 1, 2) = 'NS') then
    aFloat:= aFloat * ti_ns
   else if (Copy(TxtStr, 1, 2) = 'MK') then
    aFloat:= aFloat * ti_mks //mksec
   else if (Copy(TxtStr, 1, 2) = 'MS') then
    aFloat:= aFloat * ti_ms
   else if (TxtStr = 'M') or (Copy(TxtStr, 1, 2) = 'MI') then
    aFloat:= aFloat * ti_min
   else if (Copy(TxtStr, 1, 1) = 'H') then
    aFloat:= aFloat * ti_hou
   else if (Copy(TxtStr, 1, 1) = 'D') then
    aFloat:= aFloat * ti_day
   else if (Copy(TxtStr, 1, 1) = 'Y') then
    aFloat:= aFloat * ti_yea
   else if (Copy(TxtStr, 1, 2) = 'LA') then
    aFloat:= Ln2 / aFloat
   else
    MessageDlg('Unknown time unit (considered sec).', mtWarning, [mbOK], 0);
 except
  Result:= False;
 end;
end; {TextT1_2ToNum}

function Color4DecayType(DecayType: TDecayType; KarteInfo: TKarteInfo): TColor;
begin
 with KarteInfo do
  case DecayType of
   dtQ: Result:= Qcolor;
   dtA: Result:= Acolor;
   dtBM: Result:= BMcolor;
   dtEC: Result:= ECcolor;
   dtIT: Result:= ITcolor;
   dtN: Result:= Ncolor;
   dtP: Result:= Pcolor;
   dtSF: Result:= SFcolor;
   dtNone: Result:= QColor;
   else
    Result:= Qcolor;
  end;
end; {Color4DecayType}

function FontColor(BrushColor: TColor): TColor;
begin
 Result:= (clWhite xor BrushColor);
end; { FontColor}

function IntStateToStr(State: integer): string;
begin
 case State of
  0: Result:= 'G';
  1: Result:= 'M1';
  2: Result:= 'M2';
  else
   Result:= 'U';
 end;
end;

function ValT1_2(FloatText, UnitsText: string; var aFloat: Float): Boolean;
var
 TmpFloat: Float;
begin
 Result:= False;
 if Copy(UpperCase(Trim(FloatText)), 1, 4) = 'STAB' then
 begin
  aFloat:= 2.E17;
  Result:= True;
 end
 else if ValEuSilent(FloatText, aFloat) then
  if TextT1_2ToNum(FloatText + Trim(UnitsText), TmpFloat) then
  begin
   Result:= True;
   aFloat:= TmpFloat;
  end
end; {ValT1_2}
(*
begin
 Result:= True;
 if Copy(UpperCase(Trim(FloatText)), 1, 4)='STAB' then begin
  aFloat:= 2.E17;
  Exit;
 end;
 if (ValEuSilent(FloatText, aFloat)and TextT1_2ToNum('1'+Trim(UnitsText), TmpFloat)) then
  aFloat:= aFloat*TmpFloat
 else
  Result:= False;
end;
*)

function ZnumToSymbol(const Znum: integer; var Symbol: string): Boolean;
begin
 if ((Znum < 1) or (Znum > MaxSymbolNo)) then
  Result:= False
 else
 begin
  Symbol:= Symbols[Znum];
  Result:= True;
 end;
end;

function SymbolToZnum(const Symbol: string; var Znum: integer): Boolean;
var
 I: integer;
begin
 Znum:= 0;
 Result:= False;
 for I:= 1 to MaxSymbolNo do
  if UpperCase(Trim(Symbols[I])) = UpperCase(Symbol) then
  begin
   Znum:= I;
   Result:= True;
   break;
  end;
end;

function ThZpAtoNuclideName(const aThZpA: integer): string;
begin
 if ((aThZpA div 1000 < MaxSymbolNo) and (aThZpA div 1000 > 0)) then
  Result:= Symbols[aThZpA div 1000] + '-' + IntToStr(aThZpA mod 1000)
 else
  Result:= '';
end;

function NKstr(const InStr: string; const IsSpecialFont: Boolean = False;
 const Font: TFont = nil; StrWidth: integer = 0): string;
begin
 if not (IsSpecialFont) then
  Result:= InStr
 else
 begin
  Result:= '' + InStr;
 end;
end;

function NKstrSymbol(const SymbolStr, AmassStr: string): string;
var
 I: integer;
begin
 Result:= '';
 for I:= 1 to Length(AmassStr) do
  if (Ord(AmassStr[I]) <> 52) then
   Result:= Result + char(Ord(AmassStr[I]) - 15) //char(Ord(AmassStr[I])+144);
  else
   Result:= Result + #125;
 Result:= Result + SymbolStr;
end;

function Bateman(const N0s, Lambdas, ts: array of float; var Ni_t: array of float): Boolean;
var
 I, J, K, L, M, P, NoOfNuclides, NoOfTs: integer;
 Nm0_PlambdaP, PlambdaL_lambdaK, SumMkI: float;
begin
// Ni_t: N1(t1),N1(t2).....N1(t#),N2(t1)....N2(t#)....
 Result:= False;
 NoOfNuclides:= High(N0s) + 1;
 if (NoOfNuclides <> High(Lambdas) + 1) then
 begin
  MessageDlg('NuclideClasses.Bateman:Arrays N(0) and Lambda have different lengths !', mtWarning, [mbOK], 0);
  Exit;
 end;
 NoOfTs:= High(ts) + 1;
 if (NoOfNuclides * NoOfTs <> High(Ni_t) + 1) then
 begin
  MessageDlg('NuclideClasses.Bateman: Input and output arrays lengths do not match !', mtWarning, [mbOK], 0);
  Exit;
 end;
 for J:= 1 to NoOfTs - 1 do // I==0
  Ni_t[J]:= N0s[0] * exp(-Lambdas[0] * Ts[J]);
 Ni_t[0]:= 1.0;
 for I:= 1 to NoOfNuclides - 1 do
  for J:= 0 to 0 do
   Ni_t[I * NoOfTs + J]:= 0.0;
 for I:= 1 to NoOfNuclides - 1 do
  for J:= 1 to NoOfTs - 1 do
  begin
   Ni_t[I * NoOfTs + J]:= 0.0;
   for M:= 0 to (I - 1) do
    if N0s[M] > 0 then
    begin
     Nm0_PlambdaP:= N0s[M];
     for P:= M to I - 1 do
      Nm0_PlambdaP:= Nm0_PlambdaP * Lambdas[P];
     SumMkI:= 0.0;
     for K:= M to I do
     begin
      PlambdaL_lambdaK:= 1.0;
      for L:= 0 to I do
       if (L <> K) then
        PlambdaL_lambdaK:= PlambdaL_lambdaK * (Lambdas[L] - Lambdas[K]);
      SumMkI:= SumMkI + exp(-Lambdas[K] * Ts[J]) / PlambdaL_lambdaK;
     end;
     Ni_t[I * NoOfTs + J]:= Ni_t[I * NoOfTs + J] + Nm0_PlambdaP * SumMkI;
    end;
   Ni_t[I * NoOfTs + J]:= Ni_t[I * NoOfTs + J] + N0s[I] * exp(-Lambdas[I] * Ts[J]);
//   Ni_t[I*NoOfTs+J]:= N0s[I]*Ts[J]; // --test
   Result:= True;
  end;
end;

function DecayProductThZpA(const ParentThZpA: integer; const DecayType: TDecayType): integer;
begin
 case DecayType of
  dtNone: Result:= 0;
  dtA: Result:= ParentThZpA - 2004;
  dtBM: Result:= ParentThZpA + 1000;
  dtEC: Result:= ParentThZpA - 1000;
  dtIT: Result:= ParentThZpA;
  dtN: Result:= ParentThZpA - 7014;
  dtP: Result:= ParentThZpA - 1001;
  dtSF: Result:= 0;
  dtQ: Result:= 0;
  else
   Result:= 0;
 end;
end;

function ThresholdProductThZpA(const ParentThZpA: integer; const ReactionName: string): integer;
var
 aName: string;
begin
 aName:= UpperCase(Trim(ReactionName));
 if aName = 'NP' then
  Result:= ParentThZpA + 1 - 1000 - 1
 else if aName = 'NA' then
  Result:= ParentThZpA + 1 - 2000 - 4
 else if aName = 'N2N' then
  Result:= ParentThZpA + 1 - 2
 else if aName = 'NN' then
  Result:= ParentThZpA + 1 - 1
 else if aName = 'NG' then
  Result:= ParentThZpA + 1
 else
  Result:= -1;
end;

function StrToThZpA_s(const Str: string): integer;
const
 Delimiters = ['-'];
var
 I, DelimiterNo, Amass: integer;
 TmpStr, SymbolStr, AmassStr: string;
begin
 Result:= -1;
 try
  TmpStr:= Trim(Str);
  if TmpStr = '' then
   Exit;
  DelimiterNo:= Length(TmpStr);
  SymbolStr:= TmpStr;
  for I:= 2 to Length(TmpStr) do
   if TmpStr[I] in Delimiters then
   begin
    DelimiterNo:= I;
    SymbolStr:= Copy(TmpStr, 1, DelimiterNo - 1);
    break;
   end;
  for I:= 1 to MaxSymbolNo do
   if UpperCase(SymbolStr) = UpperCase(Symbols[I]) then
   begin
    Result:= 10 * 1000 * I;
    break;
   end;
  TmpStr:= UpperCase(Copy(TmpStr, DelimiterNo + 1, Length(TmpStr)));
  if Pos('M2', TmpStr) > 0 then
   Result:= Result + 2
  else if Pos('M', TmpStr) > 0 then
   Result:= Result + 1;
  AmassStr:= Copy(TmpStr, 1, Length(TmpStr));
  for I:= 1 to Length(TmpStr) do
   if not (TmpStr[I] in ['0'..'9']) then
   begin
    AmassStr:= Copy(TmpStr, 1, I - 1);
    break;
   end;
  Amass:= StrToInt(AmassStr);
  if Amass < 1000 then
   Result:= Result + 10 * Amass;
 except
  Result:= -1;
 end;
end;

function AmassFromStateName(const Str: string): integer;
const
 Delimiters = ['-'];
var
 I, J: integer;
 TmpStr, MassStr: string;
begin
 Result:= -1;
 try
  TmpStr:= Trim(Str);
  for I:= 1 to Length(TmpStr) do
   if TmpStr[I] in Delimiters then
   begin
    TmpStr:= Copy(TmpStr, I + 1, 3);
    MassStr:= '';
    for J:= 1 to Length(TmpStr) do
     if (TmpStr[J] in ['0'..'9']) then
      MassStr:= MassStr + TmpStr[J]
     else
      break;
    Result:= StrToInt(MassStr);
    break;
   end;
 except
  Result:= -1;
 end;
end;

function ElementNameFromStateName(const Str: string): string;
const
 Delimiters = ['-'];
var
 I: integer;
 TmpStr: string;
begin
 Result:= '';
 try
  TmpStr:= Trim(Str);
  for I:= 1 to Length(TmpStr) do
   if TmpStr[I] in Delimiters then
   begin
    Result:= Copy(TmpStr, 1, I - 1);
    break;
   end;
 except
  Result:= '';
 end;
end;

function ThZpA_sToStr(const ThZpA_s: integer): string;
begin
 Result:= ThZpAtoNuclideName(ThZpA_s div 10);
 if ((ThZpA_s mod 10) = 0) then
  Result:= Result + 'g'
 else if ((ThZpA_s mod 10) = 1) then
  Result:= Result + 'm1'
 else if ((ThZpA_s mod 10) = 2) then
  Result:= Result + 'm2'
 else
  Result:= Result + 'u';
end;

procedure StrToStateNamesList(const InputStr: string; var Lines: TStringList);
// it undestands phrases like Co-58...62 (now with all m states)
//                            Co-58...62g - only g states
// Lines - UNSORTED
const
 Delimiters = [',', ' ', ';', '.', '\', '/', #9];
var
 I, DelPos, ConCatPos, MinA, MaxA, NameLastPos: integer;
 aStr, aName, NumStr, InsertStr: string;
 IncludeMstates: Boolean;
begin
// qqqq 1 add
 Lines.Clear;
 aStr:= Trim(InputStr);
 if Length(aStr) < 1 then
  Exit;
 ConCatPos:= Pos('...', aStr);
 while (ConCatPos > 3) do
 begin
  IncludeMstates:= True;
  NumStr:= '';
  NameLastPos:= 0;
  for I:= ConCatPos - 1 downto 1 do
   if aStr[I] in ['0'..'9'] then
    NumStr:= aStr[I] + NumStr
   else
   begin
    NameLastPos:= I - 1;
    break;
   end;
  MinA:= StrToInt(NumStr);
  aName:= '';
  for I:= NameLastPos downto 1 do
   if aStr[I] in ['a'..'z', 'A'..'Z'] then
    aName:= aStr[I] + aName
   else
   begin
    break;
   end;
  NumStr:= '';
  for I:= ConCatPos + 3 to Length(aStr) do
   if aStr[I] in ['0'..'9'] then
    NumStr:= NumStr + aStr[I]
   else
   begin
    if UpperCase(aStr[I]) = 'G' then
     IncludeMstates:= False;
    break;
   end;
  MaxA:= StrToInt(NumStr);
  InsertStr:= '';
  for I:= MinA to MaxA do
  begin
   if ((I > MinA) and (I < MaxA)) then
    InsertStr:= InsertStr + ' ' + aName + '-' + IntToStr(I);
   if IncludeMstates then
   begin
    InsertStr:= InsertStr + ' ' + aName + '-' + IntToStr(I) + 'm1';
    InsertStr:= InsertStr + ' ' + aName + '-' + IntToStr(I) + 'm2';
   end;
  end;
  InsertStr:= InsertStr + ' ';
  aStr:= Copy(aStr, 1, ConCatPos - 1) + InsertStr + aName + '-' + Copy(aStr, ConCatPos + 3, Length(aStr));
  ConCatPos:= Pos('...', aStr);
 end;
 DelPos:= 0;
 Lines.Clear;
 for I:= 1 to Length(aStr) do
  if (aStr[I] in Delimiters) then
  begin
   DelPos:= I;
   break;
  end;
 if (DelPos = 0) then
  Lines.Add(aStr)
 else
 begin
  while DelPos > 0 do
  begin
   aName:= Trim(Copy(aStr, 1, DelPos - 1));
   Lines.Add(aName);
   aStr:= Trim(Copy(aStr, DelPos + 1, Length(aStr)));
   DelPos:= 0;
   for I:= 1 to Length(aStr) do
    if (aStr[I] in Delimiters) then
    begin
     DelPos:= I;
     break;
    end;
  end;
  if (Length(aStr) > 1) then
   while (aStr[1] in Delimiters) do
    aStr:= Trim(Copy(aStr, 2, Length(aStr)));
  if (Length(aStr) > 1) then
  begin
   aName:= Trim(aStr);
   Lines.Add(aName)
  end;
 end;
end;

function LambdaToStr(const Lambda: float; Width: integer = 3): string;
begin
 if Lambda <= 0 then
  Result:= T1_2ToStr(2.0E17)
 else
  Result:= T1_2ToStr(Ln2 / Lambda);
end;

function IsStableState(aState: TNuclideState): Boolean;
begin
 if aState = nil then
  Result:= False
 else
  Result:= aState.IsStable;
end;

function GetAllDPR(const MamaThZpA_s: integer;
 const NuclideList: TNuclideList;
 const SubBranchingRecordList: TSubBranchingRecordList;
 var Childs: TLongIntList): integer;
const
 MaxFindChildsStepNo = 100;
var
 I, J: integer;
 MamaAndChildList, aChildList: TLongIntList;
 MamaAndChildListCount0: integer;
 MamaAndChildListCount1: integer;
 FindChildsStepNo: integer;
begin
 MamaAndChildList:= TLongIntList.Create;
 aChildList:= TLongIntList.Create;
 try
  try
   MamaAndChildList.Add(MamaThZpA_s);
   MamaAndChildListCount1:= 0;
   FindChildsStepNo:= 1;
   repeat
    MamaAndChildListCount0:= MamaAndChildList.Count;
    for I:= 0 to MamaAndChildList.Count - 1 do
    begin
     if NuclideList.FindChildsViaSubBranchingRecordList(SubBranchingRecordList, MamaAndChildList[I], [ntDecay], aChildList, nil) then
     begin
      for J:= 0 to aChildList.Count - 1 do
       MamaAndChildList.AddUniq(aChildList[J]);
      MamaAndChildListCount1:= MamaAndChildList.Count;
      FindChildsStepNo:= FindChildsStepNo + 1;
     end;
    end;
   until (MamaAndChildListCount0 = MamaAndChildListCount1) or (FindChildsStepNo > MaxFindChildsStepNo);
   for I:= 0 to MamaAndChildList.Count - 1 do
    Childs.Add(MamaAndChildList[I]);
// Remove Mama
   Childs.Remove(MamaThZpA_s);
// Remove Stable - ?
   Result:= Childs.Count;
  finally
   MamaAndChildList.Free;
   aChildList.Free;
  end;
 except
  Result:= -1;
 end;
end;

initialization
 for IIIIII:= 1 to MaxSymbolNo do
  Symbols[IIIIII]:= ConstSymbols[IIIIII];
// Vars fo ChainFinder
 ChainFinderInitTime:= 0;
 ChainFinderConsided:= TLongIntList.Create;
 ChainFinderHavePath:= TLongIntList.Create;
finalization
 ChainFinderConsided.Free;
 ChainFinderHavePath.Free;
end.

