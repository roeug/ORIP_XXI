unit ChainCalculator;
interface

uses windows, Classes, SysUtils, comctrls, ChainClasses, LSODA4cc, EuLib, NuclideClasses;

const
 MaxSteps = 5000;
 MaxNEQ = 500;
 MaxArrayLength = 35 + 9 * MaxNEQ + 3 * MaxNEQ * MaxNEQ;
 SqrtPiMult293_6div2 = 1.518528566650924E+01; // sqrt(Pi*296.3)/2 Kalkulator32
// TimeEpsilon=1.0E-13; // For Increase Check (here - in seconds)
type
 integertype = Longint;
 realtype = double;
 realarraytype = array[1..MaxArrayLength] of realtype;
 integerarraytype = array[1..MaxArrayLength] of integertype;
 
 TChainCalculator = class;
{TSSK_Table}
 TSSK_Table = class
 private
  fThZpA_s: integer;
  fConcentration: TFloatList; // Add Used
  fSSK: TFloatList; // Add Used
 protected
  function GetCount: integer;
  function Get_Concentration(Index: integer): Float;
  procedure Set_Concentration(Index: integer; aConcentration: Float);
  function Get_SSK(Index: integer): Float;
  procedure Set_SSK(Index: integer; aSSK: Float);
 public
  function LoadFromStream(Stream: TStream): Boolean;
  function SaveToStream(Stream: TStream): Boolean;
  function IsOK: Boolean;
(*
  function InterpolateSSK(const aConcentration: Float): Float; // interpolation
*)
  procedure Add(const aConcentration, aSSK: Float);
  procedure Clear;
  procedure Assign(Source: TSSK_Table);
  destructor Destroy; override;
  procedure Order; // InCrease
  procedure Normalize;
  constructor Create(aThZpA_s: integer);
  property Concentration[Index: integer]: Float read Get_Concentration write Set_Concentration;
  property SSK[Index: integer]: Float read Get_SSK write Set_SSK;
  property PointsNumber: integer read GetCount;
  property ThZpA_s: integer read fThZpA_s;
 end;
{TSSK_TableList}
 TSSK_TableList = class(TList)
 private
//
 protected
  procedure FreeItems;
 public
  function LoadFromStream(Stream: TStream): Boolean;
  function LoadFromFile(const FileName: string): Boolean;
  function SaveToStream(Stream: TStream): Boolean;
  function SaveToFile(const FileName: string): Boolean;
(*
  function InterpolateSSKforStateName(const aConcentration: Float; const aName: string): Float; // interpolation
  function InterpolateSSKforStateNo(const aConcentration: Float; const StateNo: integer): Float; // interpolation
*)
  function NotNullCount: integer;
  procedure Assign(Source: TSSK_TableList);
  procedure Add(const aTable: TSSK_Table);
  destructor Destroy; override;
  constructor Create;
 end;
 
{TTimePoint}
 TTimePoint = record
  Time: Float; // In Seconds to be compatible with lambda and fluxes
  ThermalFlux: Float;
  ResonanceFlux: Float;
  FastFlux: Float;
  Tng: Float;
 end;
 PTimePoint = ^TTimePoint;
{TTimePointList}
 TTimePointList = class(TList)
 private
  fChainCalculator: TChainCalculator;
 protected
  function GetTimePoint(Index: integer): TTimePoint;
  procedure SetTimePoint(Index: integer; aTimePoint: TTimePoint);
 public
  procedure Add(aTimePoint: TTimePoint);
  destructor Destroy; override;
  procedure Order(const InCrease: Boolean = True);
  constructor Create(aChainCalculator: TChainCalculator);
  property
   TimePoints[Index: integer]: TTimePoint read GetTimePoint write SetTimePoint; default;
 end;
 
{TChainCalculator}
 TChainCalculator = class
 private
  fChain: TChain;
  fNvsTimeST: array of array of Float;
  fLambdaIJ: array of array of Float;
  fThermalIJ: array of array of Float;
  fResonanceIJ0: array of array of Float;
  fG_factorIJ: array of array of Float;
  fResonanceIJ: array of array of Float;
  fFastIJ: array of array of Float;
  fTmpArray: array of Float;
  fTimePoints: TTimePointList;
  frtolerance: array of Float;
  fatolerance: array of Float;
  fCalculatorStdOut: TStringList;
  fTimeScaler: Float;
  fN0Scaler: Float;
  fNeedTolSwitch: Boolean;
  fCalculating: Boolean;
  fUseSSK: Boolean;
  fStopCalculation: Boolean;
  fDepressionConsider: Boolean;
  fDepressionVolume: Float;
  fDepressionL: Float;
// Activity Tables
// TDecayType=(dtNone, dtA, dtBM, dtEC, dtIT, dtN, dtP, dtSF, dtQ);
  fNone_Table, fA_Table, fBM_Table, fEC_Table, fIT_Table, fN_Table, fP_Table, fSF_Table, fQ_Table: array of Float;
  fDecayTablesReady: Boolean;
  fInternalSSK: TSSK_TableList;
  fExternalSSK: TSSK_TableList;
  fRA_VolumeForSSK: Float;
  fStatesCount: Integer;
  fTimesCount: Integer; // Be carefull Use AdjustTimeCount
  fLSODA: TLSODA;
  fDebugStr: string;
  function TngMultiplier(const Tng: Float; const g_factor: float; const TngEpsilon: float = 1.0E-10): float;
 protected
  function GetNumberOfStates: integer;
  procedure DoChainCalc4LSODA(t: double; y_v, dydt_v: TVector);
  procedure ChainCalcDyDt4DLL(const NEQ: integertype; var T, Y_, YDOT_,
   RPAR_: realtype; var IPAR_: integertype);
  procedure ChainCalcDfDy4DLL(const NEQ: integertype; var T: realtype; var Y_: realtype;
   var ML: integertype; var MU: integertype; var PD_: realtype; var NRPD: integertype;
   var RPAR: realtype; var IPAR: integertype);
  function GetTimesCount: integer;
  function GetLambdaIJ(I, J: Integer): float;
  procedure SetLambdaIJ(I, J: Integer; Value: float);
  function GetThermalIJ(I, J: Integer): float;
  procedure SetThermalIJ(I, J: Integer; Value: float);
  function GetG_factor(I, J: Integer): float;
  procedure SetG_factor(I, J: Integer; Value: float);
  function GetResonanceIJ(I, J: Integer): float;
  procedure SetResonanceIJ(I, J: Integer; Value: float);
  function GetFastIJ(I, J: Integer): float;
  procedure SetFastIJ(I, J: Integer; Value: float);
  function GetNIvsTime(StateNo, TimeNo: Integer): float;
  function IsGetNvsTime(StateNo: Integer; aFloatList: TFloatList): Boolean;
  function IsGetNsForTimeNo(TimeNo: Integer; var aFloatList: TFloatList): Boolean;
  function GetN0(StateNo: Integer): float;
  procedure SetN0(StateNo: Integer; Value: float);
  function GetAtolerance(Index: integer): Float;
  procedure SetAtolerance(Index: integer; Tol: Float);
  function GetRtolerance(Index: integer): Float;
  procedure SetRtolerance(Index: integer; Tol: Float);
  procedure PrepareSSK; // N - Ln
  procedure PrepareIJ; // After UseSSK - fResonanceIJ are modified
  procedure PrepareIJ0;
  procedure PrepareTimes;
  procedure ScaleTimes;
  procedure UnScaleTimes;
  procedure ScaleN0;
  procedure UnScaleN0;
  function GetStateName(Index: Integer): string;
  function CalcSSK(const StateNo: integer; const Nuclei: Float): Float; // ==ApproximateSSK
  procedure AdjustTimeCount(Value: integer);
 public
  ProgressBar: TProgressBar; // external
  function GetActivitiNIvsTime(StateNo, TimeNo: Integer; dt: TDecayType): Float;
  procedure GetElements(var ElementZs: TLongIntList);
  function ApproximateSSK(const StateNo: integer; const N: Float): Float;
  procedure AssignSSK_Tables(const aTables: TSSK_TableList);
  function GetDepresssionK(const TimeNo: integer): Float;
  function GetElementMass(const ElementName: string; const TimeNo: integer): Float;
  function GetStateMass(const StateNo, TimeNo: Integer): Float;
  function GetTotalMass(const TimeNo: Integer): Float;
  procedure PrepareActivityTables;
  procedure StopCalculation;
  function SolveChainWithVODE(UseJAC: Boolean = True; UseDLL: Boolean = False): integer;
  function SolveChainWithLSODA(UseJAC: Boolean = True; UseDLL: Boolean = False): integer;
  function SolveChainWithRADAU(UseJAC: Boolean = True): integer;
  function SolveChainWithMEBDF(UseJAC: Boolean = True): integer;
  function CheckTimePointsIncrease: Boolean;
  function GetFissionEnergyDepositionNIvsTime(const StateNo, TimeNo: integer;
   const ConsiderDepression, SSKconsider: Boolean; const Energy4fission: Float = 200): Float;
  procedure ClearTimePoints;
  constructor Create(aChain: TChain);
  destructor Destroy; override;
//
  property RA_VolumeForSSK: Float read fRA_VolumeForSSK write fRA_VolumeForSSK;
  property UseSSK: Boolean read fUseSSK write fUseSSK;
  property Calculating: Boolean read fCalculating;
  property NoOfStates: integer read GetNumberOfStates;
  property CalculatorStdOut: TStringList read fCalculatorStdOut;
  property atolerance[Index: Integer]: Float read GetAtolerance write SetAtolerance;
  property rtolerance[Index: Integer]: Float read GetRtolerance write SetRtolerance;
  property TimePoints: TTimePointList read fTimePoints;
  property TimesCount: integer read GetTimesCount; // Number Of Time Points Set via AdjustTimeCount
  property NIvsTime[StateNo, TimeNo: Integer]: Float read GetNIvsTime; //N(t) N,t-vector
  property N0[Index: Integer]: float read GetN0 write SetN0;
  property StateName[Index: Integer]: string read GetStateName;
  property DepressionConsider: Boolean read fDepressionConsider write fDepressionConsider;
  property DepressionVolume: Float read fDepressionVolume write fDepressionVolume;
  property DepressionL: Float read fDepressionL write fDepressionL;
// Next 5 properties are for DEBUG
(*
  property LambdaIJ[I, J: Integer]: Float read GetLambdaIJ write SetLambdaIJ;
  property ThermalIJ[I, J: Integer]: Float read GetThermalIJ write SetThermalIJ;
  property G_factorIJ[I, J: Integer]: Float read GetG_factor write SetG_factor;
  property ResonanceIJ[I, J: Integer]: Float read GetResonanceIJ write SetResonanceIJ;
  property FastIJ[I, J: Integer]: Float read GetFastIJ write SetFastIJ;
*)
  property NeedTolSwitch: Boolean read fNeedTolSwitch write fNeedTolSwitch;
 end;
function Depression(const N0, SigmaA, l: Float): Float;

implementation
uses
 Forms, Dialogs, Parsing, DVODEu4cc;

const
 BeginSSK_TableChar = #1;
 EndSSK_TableChar = #2;
 BeginSSK_TableListChar = #3;
 EndSSK_TableListChar = #4;
 EndOfLine = #13#10;
 BufferSize = 255;
 RTOL_mul_ABS_Y_plus_ATOL = 1.0E-50;
 
var // for DLLs usage
 Y: realarraytype;
 Ti: realtype;
 DummyReal: realtype;
 DummyInt: integertype;
 TOUT: realtype;
 ITOL: integertype;
 RTOL: realarraytype;
 ATOL: realarraytype;
 ITASK: integertype;
 ISTATE: integertype;
 IOPT: integertype;
 RWORK: array[1..MaxArrayLength] of realtype;
 LRW: integertype;
 IWORK: array[1..MaxArrayLength] of integertype;
 LIW: integertype;
 MF: integertype;
 RPAR: realarraytype;
 IPAR: integerarraytype;
// for meb
 IDID, LOUT, LWORK, LIWORK, MAXDER, IERR: integertype;
 H0, TEND: realtype;
 MBND: array[1..4] of integertype;
 MASBND: array[1..4] of integertype;
// for RADAU LWORK, IDID, LIWORK - above
 X, H: realtype;
 IJAC, MLJAC, MUJAC, IMAS, MLMAS, MUMAS, IOUT_RADAUS, NSMAX: integertype;
//
 aThermalFlux, aResonanceFlux, aFastFlux, aTng: Double; // global vars now
 ActiveCalculator: TChainCalculator; // sets at initit of integration step
// for pipes
 Buffer: array[0..BufferSize] of Char;
 StrRead: string;
 BytesRead: Cardinal;
 
function Depression(const N0, SigmaA, l: Float): Float;
var
 l_mul_MacroSigma: Float;
begin
 try
  l_mul_MacroSigma:= (N0 * SigmaA) * l;
  Result:= (1 - exp(-l_mul_MacroSigma)) / l_mul_MacroSigma;
 except
  Result:= 1;
 end;
end;

procedure dydt4dll(var NEQ: integertype; var T, Y_, YDOT_,
 RPAR_: realtype; var IPAR_: integertype); stdcall;
begin
 if ActiveCalculator <> nil then
  ActiveCalculator.ChainCalcDyDt4DLL(NEQ, T, Y_, YDOT_, RPAR_, IPAR_)
 else
  MessageDlg('ActiveCalculator=nil', mtInformation, [mbOK], 0);
end;

procedure dydt4LSODA_dll(var NEQ: integertype; var T, Y_, YDOT_: realtype); stdcall;
begin
 if ActiveCalculator <> nil then
  ActiveCalculator.ChainCalcDyDt4DLL(NEQ, T, Y_, YDOT_, DummyReal, DummyInt)
 else
  MessageDlg('ActiveCalculator=nil', mtInformation, [mbOK], 0);
end;

procedure JAC4dll(var NEQ: integertype; var T: realtype; var Y_: realtype;
 var ML: integertype; var MU: integertype; var PD_: realtype; var NROWPD: integertype;
 var RPAR: realtype; var IPAR: integertype); stdcall;
begin
 if ActiveCalculator <> nil then
  ActiveCalculator.ChainCalcDfDy4DLL(NEQ, T, Y_, ML, MU, PD_, NROWPD, RPAR, IPAR)
 else
  MessageDlg('ActiveCalculator=nil', mtInformation, [mbOK], 0);
end;

procedure dfdyMEB(var T, Y_, PD_: realtype; var NEQ: integertype; const MEBAND: Pointer;
 var IPAR: integertype; var RPAR: realtype); stdcall;
var
 ML, MU, NROWPD: integertype;
begin
 ML:= 0;
 MU:= 0;
 NROWPD:= 0;
 JAC4dll(NEQ, T, Y_, ML, MU, PD_, NROWPD, RPAR, IPAR);
end;

//  SUBROUTINE JAC(N,X,Y,DFY,LDFY,RPAR,IPAR)

procedure dfdyRADAU(var N_: integertype; var T_, Y_, DFY_, LDFY_,
 RPAR_: realtype; var IPAR_: integertype); stdcall;
var
 ML_, MU_, NROWPD_: integertype;
begin
 ML_:= 0;
 MU_:= 0;
 NROWPD_:= 0;
 JAC4dll(N_, T_, Y_, ML_, MU_, DFY_, NROWPD_, RPAR_, IPAR_);
end;
{TChainCalculator}

constructor TChainCalculator.Create(aChain: TChain);
const
 rToleranceEpsilon = 1.0E-5; //1.E-7;
 aToleranceEpsilon = 1.0E-5; //1.E-10;
var
 I, J: integer;
begin
 ProgressBar:= nil;
 fTimeScaler:= -1;
 fN0Scaler:= -1;
 fDecayTablesReady:= False;
 if aChain is TChain then
 begin
  inherited Create;
  fStatesCount:= aChain.States.Count;
  fCalculatorStdOut:= TStringList.Create;
  fTimePoints:= TTimePointList.Create(Self);
  fChain:= aChain;
  SetLength(fNvsTimeST, fStatesCount, 1);
  SetLength(fLambdaIJ, fStatesCount, fStatesCount);
  SetLength(fThermalIJ, fStatesCount, fStatesCount);
  SetLength(fResonanceIJ, fStatesCount, fStatesCount);
  SetLength(fFastIJ, fStatesCount, fStatesCount);
  SetLength(fG_factorIJ, fStatesCount, fStatesCount);
  SetLength(fatolerance, fStatesCount);
  SetLength(frtolerance, fStatesCount);
  for I:= 0 to fStatesCount - 1 do
  begin
   fNvsTimeST[I, 0]:= 0.0;
   fatolerance[I]:= aToleranceEpsilon;
   frtolerance[I]:= rToleranceEpsilon;
   for J:= 0 to fStatesCount - 1 do
   begin
    fLambdaIJ[J, I]:= 0.0;
    fThermalIJ[J, I]:= 0.0;
    fResonanceIJ[J, I]:= 0.0;
    fFastIJ[J, I]:= 0.0;
    fg_factorIJ[J, I]:= 1.0;
   end;
  end;
 end;
 fInternalSSK:= TSSK_TableList.Create;
 fExternalSSK:= TSSK_TableList.Create;
 PrepareIJ;
 fNeedTolSwitch:= False;
end;

destructor TChainCalculator.Destroy;
begin
 fInternalSSK.Free;
 fExternalSSK.Free;
 fCalculatorStdOut.Free;
 fTimePoints.Free;
 SetLength(fLambdaIJ, 0, 0);
 SetLength(fThermalIJ, 0, 0);
 SetLength(fResonanceIJ, 0, 0);
 SetLength(fFastIJ, 0, 0);
 SetLength(fG_factorIJ, 0, 0);
 SetLength(fResonanceIJ0, 0, 0);
 SetLength(fNvsTimeST, 0, 0);
 SetLength(fatolerance, 0);
 SetLength(frtolerance, 0);
// ActivityTable
 SetLength(fNone_Table, 0);
 SetLength(fA_Table, 0);
 SetLength(fBM_Table, 0);
 SetLength(fEC_Table, 0);
 SetLength(fIT_Table, 0);
 SetLength(fN_Table, 0);
 SetLength(fP_Table, 0);
 SetLength(fSF_Table, 0);
 SetLength(fQ_Table, 0);
 ActiveCalculator:= nil;
 inherited;
end;

function TChainCalculator.GetNumberOfStates: integer;
begin
 try
  Result:= fStatesCount;
 except
  Result:= -1;
 end;
end;

function TChainCalculator.GetLambdaIJ(I, J: Integer): float;
begin
 Result:= fLambdaIJ[I, J];
end;

function TChainCalculator.GetThermalIJ(I, J: Integer): float;
begin
 Result:= fThermalIJ[I, J];
end;

function TChainCalculator.GetG_factor(I, J: Integer): float;
begin
 Result:= fG_factorIJ[I, J];
end;

function TChainCalculator.GetResonanceIJ(I, J: Integer): float;
begin
 Result:= fResonanceIJ[I, J];
end;

function TChainCalculator.GetFastIJ(I, J: Integer): float;
begin
 Result:= fFastIJ[I, J];
end;

function TChainCalculator.GetNIvsTime(StateNo, TimeNo: Integer): float;
begin
 Result:= fNvsTimeST[StateNo, TimeNo];
end;

function TChainCalculator.IsGetNsForTimeNo(TimeNo: Integer; var aFloatList: TFloatList): Boolean;
var
 S: integer;
begin
 Result:= False;
 if aFloatList = nil then
  Exit;
 aFloatList.Clear;
 try
  for S:= 0 to fStatesCount - 1 do
   aFloatList.Add(fNvsTimeST[S, TimeNo]);
  Result:= True;
 except
  Result:= False;
 end;
end;

function TChainCalculator.IsGetNvsTime(StateNo: Integer; aFloatList: TFloatList): Boolean;
var
 TimeNoI: integer;
begin
 Result:= False;
 if aFloatList = nil then
  Exit;
 aFloatList.Clear;
 try
  for TimeNoI:= 0 to fTimesCount - 1 do
   aFloatList.Add(fNvsTimeST[StateNo, TimeNoI]);
  Result:= True;
 except
  Result:= False;
 end;
end;

procedure TChainCalculator.SetLambdaIJ(I, J: Integer; Value: float);
begin
 fLambdaIJ[I, J]:= Value;
end;

procedure TChainCalculator.SetThermalIJ(I, J: Integer; Value: float);
begin
 fThermalIJ[I, J]:= Value;
end;

procedure TChainCalculator.SetG_factor(I, J: Integer; Value: float);
begin
 fG_factorIJ[I, J]:= Value;
end;

procedure TChainCalculator.SetResonanceIJ(I, J: Integer; Value: float);
begin
 fResonanceIJ[I, J]:= Value;
end;

procedure TChainCalculator.SetFastIJ(I, J: Integer; Value: float);
begin
 fFastIJ[I, J]:= Value;
end;

procedure TChainCalculator.PrepareIJ0;
var
 I, J: integer;
begin
 if fStatesCount <> fChain.States.Count then
  MessageDlg('ERROR !!!' + #13 + #10 +
   'In PrepareIJ0' + #13 + #10 +
   'fStatesCount<> fChain.States.Count', mtError, [mbOK], 0);
 SetLength(fResonanceIJ0, fStatesCount, fStatesCount);
 for I:= 0 to fStatesCount - 1 do
  for J:= 0 to fStatesCount - 1 do
   fResonanceIJ0[I, J]:= fResonanceIJ[I, J];
end;

procedure TChainCalculator.PrepareIJ;
var
 I, StartNo, FinishNo: integer;
 aState: TChainState;
 aLink: TChainLink;
 aStr: string;
begin
 for I:= 0 to fStatesCount - 1 do
 begin
  aState:= fChain.States[I];
  with aState do
  begin
   fLambdaIJ[I, I]:= aState.DecayDecrease;
   fThermalIJ[I, I]:= aState.ThermalDecrease;
   fResonanceIJ[I, I]:= aState.ResonanceDecrease;
   fFastIJ[I, I]:= aState.FastDecrease;
   fG_factorIJ[I, I]:= aState.G_Factor;
  end;
 end;
// now fG_factorIJ
 for I:= 0 to fChain.Links.Count - 1 do
 begin
  aLink:= fChain.Links[I];
  with aLink do
  begin
   StartNo:= aLink.FindStartStateChainNo;
   FinishNo:= aLink.FindFinishStateChainNo;
   if ValuesStr.Count > 0 then
    if PrepareToParse(ValuesStr[0], aStr) then
     fLambdaIJ[StartNo, FinishNo]:= GetFormulaValue(aStr);
   if ValuesStr.Count > 1 then
    if PrepareToParse(ValuesStr[1], aStr) then
     fThermalIJ[StartNo, FinishNo]:= GetFormulaValue(aStr);
   if ValuesStr.Count > 2 then
    if PrepareToParse(ValuesStr[2], aStr) then
     fResonanceIJ[StartNo, FinishNo]:= GetFormulaValue(aStr);
   if ValuesStr.Count > 3 then
    if PrepareToParse(ValuesStr[3], aStr) then
     fFastIJ[StartNo, FinishNo]:= GetFormulaValue(aStr);
   if ValuesStr.Count > 4 then
    if PrepareToParse(ValuesStr[4], aStr) then
     fG_factorIJ[StartNo, FinishNo]:= GetFormulaValue(aStr);
  end;
 end;
end;

procedure TChainCalculator.ScaleN0;
var
 I: integer;
 N0max, N0min: Float;
begin
 N0max:= 0;
 N0Min:= 1E100;
 for I:= 0 to fStatesCount - 1 do
 begin
  if (fNvsTimeST[I, 0] > N0max) then
   N0max:= fNvsTimeST[I, 0];
  if (fNvsTimeST[I, 0] < N0min) then
   N0min:= fNvsTimeST[I, 0];
 end;
 if (N0max + N0min > 0) then
  fN0Scaler:= (N0max + N0min) * 2;
 if fN0Scaler <= 0 then
  Exit;
 for I:= 0 to fStatesCount - 1 do
  fNvsTimeST[I, 0]:= fNvsTimeST[I, 0] / fN0Scaler;
end;

procedure TChainCalculator.UnScaleN0;
var
 S, T: integer;
begin
 if fN0Scaler <= 0 then
  Exit;
 for T:= 0 to fTimesCount - 1 do
  for S:= 0 to fStatesCount - 1 do
   fNvsTimeST[S, T]:= fNvsTimeST[S, T] * fN0Scaler;
 fN0Scaler:= -1;
end;

procedure TChainCalculator.ScaleTimes;
var
 I, J: integer;
 aTimePoint: TTimePoint;
begin
 fTimeScaler:= (fTimePoints[0].Time + fTimePoints[fTimePoints.Count - 1].Time) / 2.0;
 if fTimeScaler <= 0 then
  Exit;
 for I:= 0 to fTimePoints.Count - 1 do
 begin
  aTimePoint:= fTimePoints[I];
  aTimePoint.Time:= aTimePoint.Time / fTimeScaler;
  fTimePoints[I]:= aTimePoint;
 end;
 for I:= 0 to fStatesCount - 1 do
 begin
  for J:= 0 to fStatesCount - 1 do
  begin
   fThermalIJ[I, J]:= fThermalIJ[I, J] * fTimeScaler;
   fResonanceIJ[I, J]:= fResonanceIJ[I, J] * fTimeScaler;
   fFastIJ[I, J]:= fFastIJ[I, J] * fTimeScaler;
   fLambdaIJ[I, J]:= fLambdaIJ[I, J] * fTimeScaler;
  end;
 end;
end;

procedure TChainCalculator.UnScaleTimes;
var
 I, J: integer;
 aTimePoint: TTimePoint;
begin
 if fTimeScaler <= 0 then
  Exit;
 for I:= 0 to fTimePoints.Count - 1 do
 begin
  aTimePoint:= fTimePoints[I];
  aTimePoint.Time:= aTimePoint.Time * fTimeScaler;
  fTimePoints[I]:= aTimePoint;
 end;
 for I:= 0 to fStatesCount - 1 do
 begin
  for J:= 0 to fStatesCount - 1 do
  begin
   fThermalIJ[I, J]:= fThermalIJ[I, J] / fTimeScaler;
   fResonanceIJ[I, J]:= fResonanceIJ[I, J] / fTimeScaler;
   fFastIJ[I, J]:= fFastIJ[I, J] / fTimeScaler;
   fLambdaIJ[I, J]:= fLambdaIJ[I, J] / fTimeScaler;
  end;
 end;
 fTimeScaler:= -1;
end;

procedure TChainCalculator.PrepareTimes;
begin
 AdjustTimeCount(fTimePoints.Count);
 fTimePoints.Order;
end;

function TChainCalculator.TngMultiplier(const Tng: Float; const g_factor: float; const TngEpsilon: float = 1.0E-10): float;
begin
 if Tng < TngEpsilon then
  Result:= 1
 else
  Result:= SqrtPiMult293_6div2 / sqrt(Tng);
 if g_factor > 0 then
  Result:= Result * g_factor;
end;

procedure TChainCalculator.DoChainCalc4LSODA(t: double; y_v, dydt_v: TVector);
var
 NoOfY: integer;
 I, J: integer;
 SumIncreaseI: Double;
begin
 NoOfY:= fStatesCount;
 for I:= 1 to NoOfY do
 begin
  if fStopCalculation then
   Exit;
  SumIncreaseI:= 0;
  for J:= 1 to NoOfY do
   if (J <> I) then
    SumIncreaseI:= SumIncreaseI + (fLambdaIJ[J - 1, I - 1] + fThermalIJ[J - 1, I - 1] * aThermalFlux * TngMultiplier(aTng, fG_factorIJ[J - 1, I - 1])
     + fResonanceIJ[J - 1, I - 1] * aResonanceFlux + fFastIJ[J - 1, I - 1] * aFastFlux) * y_v[J];
  dydt_v[I]:= SumIncreaseI - (fLambdaIJ[I - 1, I - 1] + fThermalIJ[I - 1, I - 1] * aThermalFlux * TngMultiplier(aTng, fG_factorIJ[I - 1, I - 1])
   + fResonanceIJ[I - 1, I - 1] * aResonanceFlux + fFastIJ[I - 1, I - 1] * aFastFlux) * y_v[I];
 end;
end;

function TChainCalculator.SolveChainWithLSODA
 (UseJAC: Boolean = True; UseDLL: Boolean = False): integer;
const
 MaxRecallCount = 5; //Max lsoda recall (high acuracy requested)
 LSODA_TimeEpsilon = 1.0E-5;
var
 NoOfY, NoOfX: integer;
 t: Float;
 t_double, tout_double: double;
 y_Vector: TVector;
 I, J, iout: integer;
 TmpLines: TStringList;
 MacroSigma, l_mul_MacroSigma: Double;
 aNEQ, aJT: integertype;
 HDLL: Longword;
 LSODAD_: procedure(
  const F, NEQ, Y, T, TOUT, ITOL, RTOL, ATOL, ITASK, ISTATE,
  IOPT, RWORK, LRW, IWORK, LIW, JAC, JT: Pointer); stdcall;
 aF: Pointer;
 aJAC: Pointer;
// For UsePipe
 DllVer_: procedure(const Ver: Pointer); stdcall;
 DllVer: integer;
begin
 if ProgressBar <> nil then
  with ProgressBar do
  begin
   Min:= 0;
   Max:= fTimePoints.Count - 1;
   Position:= 0;
  end;
 fDebugStr:= '';
 fStopCalculation:= False;
 fCalculating:= True;
 fCalculatorStdOut.Clear;
 if UseDLL then
 begin
  ActiveCalculator:= Self;
  try
   NoOfY:= fStatesCount;
   NoOfX:= fTimePoints.Count;
   PrepareIJ;
   PrepareTimes;
   ScaleTimes;
   ScaleN0;
   if fUseSSK then
    PrepareSSK;
   for I:= 1 to NoOfY do
   begin
    rtol[I]:= frtolerance[I - 1];
    atol[I]:= fatolerance[I - 1];
   end;
   aNEQ:= NoOfY;
   ITOL:= 4;
   ITASK:= 4;
   ISTATE:= 1;
   IOPT:= 0;
   LRW:= MaxArrayLength;
   LIW:= MaxArrayLength;
   if UseJAC then
    aJT:= 1 // jacobian JAC
   else
    aJT:= 2; // No jacobian
   IWORK[5]:= 1;
   aF:= @dydt4LSODA_dll;
   aJAC:= @JAC4dll;
   HDLL:= LoadLibrary('lsoda');
   fCalculating:= True;
   if HDLL >= 32 then { успешно }
   begin
    Result:= -1;
    try
     LSODAD_:= GetProcAddress(HDLL, 'lsodad_');
     for I:= 1 to NoOfY do
      Y[I]:= N0[I - 1];
//     Ti:= fTimePoints[0].Time;
     for iout:= 1 to NoOfX - 1 do
     begin
      Ti:= fTimePoints[iout - 1].Time;
      ITASK:= 4;
      TOUT:= fTimePoints[iout].Time;
// Fluxes now are global vars
      aThermalFlux:= fTimePoints[iout - 1].ThermalFlux;
      aResonanceFlux:= fTimePoints[iout - 1].ResonanceFlux;
      aFastFlux:= fTimePoints[iout - 1].FastFlux;
      aTng:= fTimePoints[iout - 1].Tng;
      if fDepressionConsider then
      try
       if aThermalFlux > 0 then
        if fTimeScaler > 0 then
         if fN0Scaler > 0 then
         begin
          MacroSigma:= 0;
          for I:= 1 to NoOfY do
           MacroSigma:= MacroSigma + fThermalIJ[I - 1, I - 1] / fTimeScaler * TngMultiplier(aTng, fG_factorIJ[I - 1, I - 1]) * Y[I] * fN0Scaler / fDepressionVolume;
          l_mul_MacroSigma:= fDepressionL * MacroSigma;
          aThermalFlux:= aThermalFlux * (1 - exp(-l_mul_MacroSigma)) / l_mul_MacroSigma;
         end;
      except
       aThermalFlux:= fTimePoints[iout - 1].ThermalFlux;
      end;
// Fluxes now are global vars
      RWORK[1]:= TOUT;
      Application.ProcessMessages;
      if fStopCalculation then
      begin
       Result:= -1;
       Exit;
      end;
// SSK ResonanceIJ Correction
      if fUseSSK then
       if aResonanceFlux > 0 then
        if fN0Scaler > 0 then
        begin
         for I:= 0 to NoOfY - 1 do
          for J:= 0 to NoOfY - 1 do
           if fResonanceIJ0[J, I] > 0 then
            fResonanceIJ[J, I]:= fResonanceIJ0[J, I] * CalcSSK(J, Y[J + 1] * fN0Scaler)
           else
            fResonanceIJ[J, I]:= 0;
        end;
// SSK ResonanceIJ Correction
      LSODAD_(aF, @aNEQ, @(Y[1]), @Ti, @TOUT, @ITOL, @(RTOL[1]), @(ATOL[1]), @ITASK, @ISTATE,
       @IOPT, @(RWORK[1]), @LRW, @(IWORK[1]), @LIW, aJAC, @aJT);
      if ISTATE < 0 then //((ISTATE=-1)or(ISTATE=-2)) then begin
       if ISTATE >= -2 then
       begin // -2 means excess accuracy requested (tolerances too small).
        for i:= 1 to MaxRecallCount do
        begin
         ISTATE:= 1; // 2, 3 - do not work
         TOUT:= fTimePoints[iout].Time;
         IWORK[6]:= 1000;
         fCalculatorStdOut.Add('LSODA made additional steps');
         fCalculatorStdOut.Add(' for TOUT#' + IntToStr(iout) + ' ,check tolenaces');
         for J:= 1 to I do
          IWORK[6]:= IWORK[6] * 2; //IWORK[6]*2^I;
         LSODAD_(aF, @aNEQ, @(Y[1]), @Ti, @TOUT, @ITOL, @(RTOL[1]), @(ATOL[1]), @ITASK, @ISTATE,
          @IOPT, @(RWORK[1]), @LRW, @(IWORK[1]), @LIW, aJAC, @aJT);
         for j:= 1 to NoOfY do
          if Y[j] < 0 then
           Y[j]:= 0.0;
         if (ISTATE = -2) then
         begin
          for j:= 1 to NoOfY do
           if ((RTOL[j] * Y[j] + ATOL[j]) > RTOL_mul_ABS_Y_plus_ATOL) then
            ATOL[j]:= 0
           else
            ATOL[j]:= Self.fatolerance[j - 1];
          ISTATE:= 1; // Tolerance changed
          continue;
         end;
         if (ISTATE > 0) then
          break;
        end;
        if ((TOUT > fTimePoints[iout].Time * (1 + LSODA_TimeEpsilon)) or (TOUT < fTimePoints[iout].Time * (1 - LSODA_TimeEpsilon))) then
         fCalculatorStdOut.Add('TimePoints[iout].Time<>TOUT ' + 'iout=' + IntToStr(iout) +
          'TimePoints[iout].Time=' + FloatTostr(fTimePoints[iout].Time) +
          ' TOUT=' + FloatToStr(TOUT));
       end
       else
       begin //( ISTATE=<-3)- Unrecoverable error - Get Messages from DLL
        Result:= -1;
        TmpLines:= TStringList.Create;
        try
         if FileExists('lsoda.log') then
         begin
          TmpLines.LoadFromFile('lsoda.log');
          for I:= 0 to TmpLines.Count - 1 do
           if ((Trim(TmpLines[I]) <> '') and (Pos('STARTED', UpperCase(TmpLines[I])) = 0) and (Pos('FINISHED', UpperCase(TmpLines[I])) = 0)) then
            fCalculatorStdOut.Add(TmpLines[I]);
         end;
        finally
         TmpLines.Free;
        end;
        Exit;
       end;
      for j:= 1 to NoOfY do
       if Y[j] < 0 then
        Y[j]:= 0.0;
      for j:= 1 to NoOfY do
       fNvsTimeST[j - 1, iout]:= Y[j];
// TolSwitch
      if fNeedTolSwitch then
      begin
       for j:= 1 to NoOfY do
        if Y[j] > Self.fatolerance[j - 1] then
         atol[j]:= 0.0
        else
         atol[j]:= Self.fatolerance[j - 1];
      end;
// TolSwitch
      if ProgressBar <> nil then
       with ProgressBar do
        Position:= iout;
      Application.ProcessMessages;
     end;
    finally
     ActiveCalculator:= nil;
     fCalculating:= False;
     UnScaleN0;
     UnScaleTimes;
     FreeLibrary(HDLL);
    end; // finally
   end
   else
   begin
    MessageDlg('LSODA.DLL not found', mtError, [mbOk], 0);
    Result:= -1;
   end;
  except
   fCalculatorStdOut.Add('WARNING!!! LSODA (DLL) ABORTED on Exception');
   fCalculatorStdOut.Add('');
   Result:= -1;
  end;
 end
 else
 begin // Not DLL  fLSODA:= TLSODA.Create(NoOfY);
  fCalculatorStdOut.Clear;
  NoOfY:= fStatesCount;
  NoOfX:= fTimePoints.Count;
  y_Vector:= TVector.Create(NoOfY);
  fLSODA:= TLSODA.Create(NoOfY);
  fLSODA.prfl:= 0; // print flag 1-print
  try
   PrepareIJ;
   PrepareTimes;
   ScaleTimes;
   ScaleN0;
   if fUseSSK then
    PrepareSSK;
   try
    with fLSODA do
    begin
     for I:= 1 to NoOfY do
      y_Vector[I]:= N0[I - 1];
     Lsoda4cc.StdOut.Clear;
     for I:= 1 to NoOfY do
     begin
      fLSODA.rtol[I]:= frtolerance[I - 1];
      fLSODA.atol[I]:= fatolerance[I - 1];
     end;
     t:= Self.fTimePoints[0].Time;
     fLSODA.itol:= 4;
     fLSODA.istate:= 1;
     fLSODA.iopt:= 0;
     fLSODA.jt:= 2;
     fLSODA.Setfcn(DoChainCalc4LSODA);
     fLSODA.istart:= 0;
     fLSODA.itask:= 1; //qqqq 4-don't work;1-works
     t_double:= t;
     for iout:= 1 to NoOfX - 1 do
     begin // iout - cycle Number
// Fluxes now are global vars
      aThermalFlux:= fTimePoints[iout - 1].ThermalFlux;
      aResonanceFlux:= fTimePoints[iout - 1].ResonanceFlux;
      aFastFlux:= fTimePoints[iout - 1].FastFlux;
      aTng:= fTimePoints[iout - 1].Tng;
      if fDepressionConsider then
      try
       if aThermalFlux > 0 then
        if fTimeScaler > 0 then
         if fN0Scaler > 0 then
         begin
          MacroSigma:= 0;
          for I:= 1 to NoOfY do
           MacroSigma:= MacroSigma + fThermalIJ[I - 1, I - 1] / fTimeScaler * TngMultiplier(aTng, fG_factorIJ[I - 1, I - 1]) * y_Vector[I] * fN0Scaler / fDepressionVolume;
          l_mul_MacroSigma:= fDepressionL * MacroSigma;
          aThermalFlux:= aThermalFlux * (1 - exp(-l_mul_MacroSigma)) / l_mul_MacroSigma;
         end;
      except
       aThermalFlux:= fTimePoints[iout - 1].ThermalFlux;
      end;
// Fluxes now are global vars
// SSK ResonanceIJ Correction
      if fUseSSK then
       if aResonanceFlux > 0 then
        if fN0Scaler > 0 then
        begin
         for I:= 0 to NoOfY - 1 do
          for J:= 0 to NoOfY - 1 do
           if fResonanceIJ0[J, I] > 0 then
            fResonanceIJ[J, I]:= fResonanceIJ0[J, I] * CalcSSK(J, y_Vector[J + 1] * fN0Scaler)
           else
            fResonanceIJ[J, I]:= 0;
        end;
// SSK ResonanceIJ Correction
      Application.ProcessMessages;
      if fStopCalculation then
      begin
       fLSODA.Aborted:= True;
       Result:= Lsoda4cc.StdOut.Count;
       Exit;
      end;
      t_double:= tout_double;
      tout_double:= Self.fTimePoints[iout].Time;
      fLSODA.execute(y_Vector, t_double, tout_double);
      Application.ProcessMessages;
      if fStopCalculation then
      begin
       fLSODA.Aborted:= True;
       Result:= Lsoda4cc.StdOut.Count;
       Exit;
      end;
      if fLSODA.istate < 0 then
      begin
       fCalculatorStdOut.Add('WARNING!!! fLSODA.istate = ' + IntToStr(fLSODA.istate));
       fCalculatorStdOut.Add(' Attempt to Recall on step #' + IntToStr(iout));
       fCalculatorStdOut.Add(' ThermalFlux = ' + Format('%-7.5g', [aThermalFlux]));
       fCalculatorStdOut.Add('  Use DLL !!!');
       fCalculatorStdOut.Add('');
       for i:= 1 to MaxRecallCount do
       begin
        fLSODA.istate:= 2;
        tout_double:= Self.fTimePoints[iout].Time;
        Application.ProcessMessages;
        if fStopCalculation then
        begin
         fLSODA.Aborted:= True;
         Result:= Lsoda4cc.StdOut.Count;
         Exit;
        end;
        fLSODA.execute(y_Vector, t_double, tout_double);
        for j:= 1 to NoOfY do
         if y_Vector[j] < 0 then
          y_Vector[j]:= 0.0;
        if (istate > 0) then
         break;
       end;
      end;
      for j:= 1 to NoOfY do
       if y_Vector[j] < 0 then
        y_Vector[j]:= 0.0;
      t_double:= tout_double;
      if ProgressBar <> nil then
       with ProgressBar do
        Position:= iout;
      Application.ProcessMessages;
      for j:= 1 to NoOfY do
       fNvsTimeST[j - 1, iout]:= y_Vector[j];
     end;
     Result:= Lsoda4cc.StdOut.Count;
    end; // with fLSODA do begin
   finally
    fLSODA.Free;
    y_Vector.free;
    UnScaleTimes;
    UnScaleN0;
    fCalculating:= False;
    fCalculatorStdOut.Text:= fCalculatorStdOut.Text + #10#13 + Lsoda4cc.StdOut.Text;
   end;
  except
   fCalculatorStdOut.Add('WARNING!!! LSODA ABORTED on Exception');
   fCalculatorStdOut.Add('  Use DLL !!!');
   fCalculatorStdOut.Add('');
   Result:= -1;
  end;
 end;
end;

function TChainCalculator.CheckTimePointsIncrease: Boolean;
var
 I: integer;
begin
 Result:= True;
 for I:= 0 to fTimePoints.Count - 2 do
//  if (fTimePoints[I].Time>fTimePoints[I+1].Time-TimeEpsilon) then begin
  if (fTimePoints[I].Time >= fTimePoints[I + 1].Time) then
  begin
   Result:= False;
   break;
  end;
end;

function TChainCalculator.GetN0(StateNo: Integer): float;
begin
 Result:= fNvsTimeST[StateNo, 0];
end;

procedure TChainCalculator.SetN0(StateNo: Integer; Value: float);
begin
 fNvsTimeST[StateNo, 0]:= Value;
end;

function TChainCalculator.SolveChainWithMEBDF(UseJAC: Boolean): integer;
const
 MaxRecallCount = 50; //Max MEBDF recall (high acuracy requested)
 MEBDF_TimeEpsilon = 1.0E-5;
var
 NoOfY, NoOfX: integer;
 I, J, iout: integer;
 NEQ: integertype;
 HDLL: Longword; //Thandle;
 TmpLines: TStringList;
 WarnUser: Boolean;
 MacroSigma, l_mul_MacroSigma: Double;
 MEBDFD_: procedure(
  const N, T0, HO, Y0, TOUT, TEND, MF, IDID, LOUT, LWORK,
  WORK, LIWORK, IWORK, MBND, MASBND, MAXDER, ITOL, RTOL, ATOL, RPAR, IPAR,
  F, PDERV, IERR: pointer); stdcall;
begin
 fDebugStr:= '';
 fStopCalculation:= False;
 TmpLines:= TStringList.Create;
 WarnUser:= False;
 if ProgressBar <> nil then
  with ProgressBar do
  begin
   Min:= 0;
   Max:= fTimePoints.Count - 1;
   Position:= 0;
  end;
 NoOfY:= fStatesCount;
 NoOfX:= fTimePoints.Count;
 PrepareIJ;
 PrepareTimes;
 ScaleTimes;
 ScaleN0;
 fCalculatorStdOut.Clear;
 if fUseSSK then
  PrepareSSK;
 NEQ:= NoOfY;
 ActiveCalculator:= Self;
// HDLL:= LoadLibrary('mebdf.dll');
 HDLL:= LoadLibrary('mebdf');
 if HDLL >= 32 then
 begin { успешно }
  DeleteFile('MEBDF.log');
  MEBDFD_:= GetProcAddress(HDLL, 'mebd_');
  fCalculating:= True;
  try
   try
// Tolerances
    for I:= 1 to NEQ do
    begin
     rtol[I]:= frtolerance[I - 1];
     atol[I]:= fatolerance[I - 1];
     if ((atol[I] < 0.999999E-9) or (rtol[I] < 0.999999E-9)) then
      WarnUser:= True;
    end;
    if WarnUser then
    begin
     fCalculatorStdOut.Add('Recommendation:');
     fCalculatorStdOut.Add('For MEBDF set all tolerances');
     fCalculatorStdOut.Add(' to be larger than 1.0e-9');
     fCalculatorStdOut.Add('');
    end;
    ITOL:= 5;
    for I:= 1 to NoOfY do
     y[I]:= N0[I - 1];
    Ti:= fTimePoints[0].Time;
    IDID:= 1; // First call
    LOUT:= 6;
    LWORK:= (32 + 6 * NEQ + 2 + 2 * NEQ + 1) * NEQ + 2;
    LIWORK:= 14 + NEQ;
    MAXDER:= 7;
    MASBND[1]:= 0;
    H0:= (fTimePoints[1].Time - fTimePoints[0].Time) / 10.0;
    IWORK[14]:= MaxInt - 1; //MaxSteps 1000000
    RWORK[1]:= 0.0;
    if UseJAC then
     MF:= 21
    else
     MF:= 22;
//1st step
    TOUT:= Ti + 2.0 * H0;
    TEND:= TOUT;
    IERR:= 0;
// Fluxes now are global vars
    iout:= 1;
    aThermalFlux:= fTimePoints[iout - 1].ThermalFlux;
    aResonanceFlux:= fTimePoints[iout - 1].ResonanceFlux;
    aFastFlux:= fTimePoints[iout - 1].FastFlux;
    aTng:= fTimePoints[iout - 1].Tng;
    if fDepressionConsider then
    try
     if aThermalFlux > 0 then
      if fTimeScaler > 0 then
       if fN0Scaler > 0 then
       begin
        MacroSigma:= 0;
        for I:= 1 to NoOfY do
         MacroSigma:= MacroSigma + fThermalIJ[I - 1, I - 1] / fTimeScaler * TngMultiplier(aTng, fG_factorIJ[I - 1, I - 1]) * Y[I] * fN0Scaler / fDepressionVolume;
        l_mul_MacroSigma:= fDepressionL * MacroSigma;
        aThermalFlux:= aThermalFlux * (1 - exp(-l_mul_MacroSigma)) / l_mul_MacroSigma;
       end;
    except
     aThermalFlux:= fTimePoints[iout - 1].ThermalFlux;
    end;
// Fluxes now are global vars
// SSK ResonanceIJ Correction
    if fUseSSK then
     if aResonanceFlux > 0 then
      if fN0Scaler > 0 then
      begin
       for I:= 0 to NoOfY - 1 do
        for J:= 0 to NoOfY - 1 do
         if fResonanceIJ0[J, I] > 0 then
          fResonanceIJ[J, I]:= fResonanceIJ0[J, I] * CalcSSK(J, Y[J + 1] * fN0Scaler)
         else
          fResonanceIJ[J, I]:= 0;
      end;
// SSK ResonanceIJ Correction
    H0:= (TOUT - Ti) / 10.0;
    MEBDFD_(@NEQ, @Ti, @H0, @(Y[1]), @TOUT, @TEND, @MF, @IDID, @LOUT, @LWORK,
     @RWORK, @LIWORK, @IWORK, @(MBND[1]), @(MASBND[1]), @MAXDER, @ITOL, @(RTOL[1]), @(ATOL[1]),
     @(RPAR[1]), @(IPAR[1]), @dydt4dll, @dfdyMEB, @IERR);
    if IDID < 0 then
    begin
     fCalculatorStdOut.Add('WARNING!!! MEBDF IDID<0 ');
     fCalculatorStdOut.Add('IDID = ' + IntToStr(IDID) + ' on MEBDF step #' + IntToStr(iout));
     fCalculatorStdOut.Add(' ThermalFlux = ' + Format('%-7.5g', [aThermalFlux]));
     if (Ti < TOUT) then
     begin
      TOUT:= fTimePoints[iout].Time;
      fCalculatorStdOut.Add(' Attempt to Recall on step #' + IntToStr(iout));
      for i:= 1 to MaxRecallCount do
      begin
// qqqq was      IDID:= -1;
// qqqq was      IERR:= 0;
// qqqq was      IDID:= -1; // THE USER HAS RESET N, RTOL, ATOL,H  AND/OR MF.
       IDID:= 2; // 2-no extrapolation out
       H0:= H0 / 2;
       IWORK[14]:= 0;
       Application.ProcessMessages;
       if fStopCalculation then
       begin
        Result:= -1;
        Exit;
       end;
       MEBDFD_(@NEQ, @Ti, @H0, @(Y[1]), @TOUT, @TEND, @MF, @IDID, @LOUT, @LWORK,
        @RWORK, @LIWORK, @IWORK, @(MBND[1]), @(MASBND[1]), @MAXDER, @ITOL, @(RTOL[1]), @(ATOL[1]),
        @(RPAR[1]), @(IPAR[1]), @dydt4dll, @dfdyMEB, @IERR);
// qqqqq was      if IERR=0 then
       if IDID >= 0 then
        break;
       Application.ProcessMessages;
       if fStopCalculation then
       begin
        Result:= -1;
        Exit;
       end;
      end;
     end;
     fCalculatorStdOut.Add('');
    end;
    for j:= 1 to NoOfY do
     if Y[j] < 0 then
      Y[j]:= 0;
// TolSwitch
    if fNeedTolSwitch then
    begin
     for j:= 1 to NoOfY do
      if Y[j] > Self.fatolerance[j - 1] then
       atol[j]:= 0.0
      else
       atol[j]:= Self.fatolerance[j - 1];
    end;
// TolSwitch
//1st step end;
    IDID:= 2; // 2-no extrapolation out
    for iout:= 1 to NoOfX - 1 do
    begin
// Fluxes now are global vars
     aThermalFlux:= fTimePoints[iout - 1].ThermalFlux;
     aResonanceFlux:= fTimePoints[iout - 1].ResonanceFlux;
     aFastFlux:= fTimePoints[iout - 1].FastFlux;
     aTng:= fTimePoints[iout - 1].Tng;
     if fDepressionConsider then
     try
      if aThermalFlux > 0 then
       if fTimeScaler > 0 then
        if fN0Scaler > 0 then
        begin
         MacroSigma:= 0;
         for I:= 1 to NoOfY do
          MacroSigma:= MacroSigma + fThermalIJ[I - 1, I - 1] / fTimeScaler * TngMultiplier(aTng, fG_factorIJ[I - 1, I - 1]) * Y[I] * fN0Scaler / fDepressionVolume;
         l_mul_MacroSigma:= fDepressionL * MacroSigma;
         aThermalFlux:= aThermalFlux * (1 - exp(-l_mul_MacroSigma)) / l_mul_MacroSigma;
        end;
     except
      aThermalFlux:= fTimePoints[iout - 1].ThermalFlux;
     end;
// Fluxes now are global vars
     TOUT:= fTimePoints[iout].Time;
     TEND:= TOUT;
     IERR:= 0;
// SSK ResonanceIJ Correction
     if fUseSSK then
      if aResonanceFlux > 0 then
       if fN0Scaler > 0 then
       begin
        for I:= 0 to NoOfY - 1 do
         for J:= 0 to NoOfY - 1 do
          if fResonanceIJ0[J, I] > 0 then
           fResonanceIJ[J, I]:= fResonanceIJ0[J, I] * CalcSSK(J, Y[J + 1] * fN0Scaler)
          else
           fResonanceIJ[J, I]:= 0;
       end;
// SSK ResonanceIJ Correction
     H0:= (TOUT - Ti) / 10.0;
     MEBDFD_(@NEQ, @Ti, @H0, @(Y[1]), @TOUT, @TEND, @MF, @IDID, @LOUT, @LWORK,
      @RWORK, @LIWORK, @IWORK, @(MBND[1]), @(MASBND[1]), @MAXDER, @ITOL, @(RTOL[1]), @(ATOL[1]),
      @(RPAR[1]), @(IPAR[1]), @dydt4dll, @dfdyMEB, @IERR);
     Application.ProcessMessages;
     if fStopCalculation then
     begin
      Result:= -1;
      Exit;
     end;
// qqqq was     if IERR<0 then begin
     if IDID < 0 then
     begin
      fCalculatorStdOut.Add('WARNING!!! MEBDF IDID<0 (IDID=-5 maybe OK)');
      fCalculatorStdOut.Add('IDID = ' + IntToStr(IDID) + ' on MEBDF step #' + IntToStr(iout));
//      fCalculatorStdOut.Add('Tin='+FloatToStr(Ti)+', Tout='+FloatToStr(TOUT));
      fCalculatorStdOut.Add(' ThermalFlux = ' + Format('%-7.5g', [aThermalFlux]));
      if (Ti < TOUT) then
      begin
       TOUT:= fTimePoints[iout].Time;
       fCalculatorStdOut.Add(' Attempt to Recall on step #' + IntToStr(iout));
       for i:= 1 to MaxRecallCount do
       begin
// qqqq was       IDID:= -1;
// qqqq was      IERR:= 0;
//        IDID:= -1; // THE USER HAS RESET N, RTOL, ATOL,H  AND/OR MF.
        IDID:= 2; // 2-no extrapolation out
        H0:= H0 / 2;
        IWORK[14]:= 0;
        Application.ProcessMessages;
        if fStopCalculation then
        begin
         Result:= -1;
         Exit;
        end;
        MEBDFD_(@NEQ, @Ti, @H0, @(Y[1]), @TOUT, @TEND, @MF, @IDID, @LOUT, @LWORK,
         @RWORK, @LIWORK, @IWORK, @(MBND[1]), @(MASBND[1]), @MAXDER, @ITOL, @(RTOL[1]), @(ATOL[1]),
         @(RPAR[1]), @(IPAR[1]), @dydt4dll, @dfdyMEB, @IERR);
// qqqq was       if IERR=0 then
        if IDID >= 0 then
         break;
       end;
      end;
      fCalculatorStdOut.Add('');
     end;
     if iout < NoOfX - 1 then
     begin
      if (H0 < MEBDF_TimeEpsilon * 1.0E-33) then
       H0:= (fTimePoints[iout + 1].Time - fTimePoints[iout].Time) / 16.0
      else
       H0:= H0 / 2;
     end;
//     IDID:= -1; // -1-tolerance changed 2-no extrapolation out
     IDID:= 2; // 2-no extrapolation out
     if ((TOUT > fTimePoints[iout].Time * (1 + MEBDF_TimeEpsilon)) or (TOUT < fTimePoints[iout].Time * (1 - MEBDF_TimeEpsilon))) then
      fCalculatorStdOut.Add('TimePoints[iout]<>TOUT ' + 'iout=' + IntToStr(iout) +
       'TimePoints[iout].Time=' + FloatTostr(fTimePoints[iout].Time) +
       ', TOUT=' + FloatToStr(TOUT));
     for j:= 1 to NoOfY do
      if Y[j] < 0 then
       Y[j]:= 0;
     for j:= 1 to NoOfY do
      fNvsTimeST[j - 1, iout]:= Y[j];
// TolSwitch
     if fNeedTolSwitch then
     begin
      begin
       for j:= 1 to NoOfY do
        if Y[j] > Self.fatolerance[j - 1] then
         atol[j]:= 0.0
        else
         atol[j]:= Self.fatolerance[j - 1];
      end;
      IDID:= -1;
     end;
// TolSwitch
     if ProgressBar <> nil then
      with ProgressBar do
       Position:= iout;
     Application.ProcessMessages;
    end;
    FreeLibrary(HDLL); //  for TmpLines.LoadFromFile('mebdf.log');
    if FileExists('mebdf.log') then
    begin
     TmpLines.LoadFromFile('mebdf.log');
     for i:= 0 to TmpLines.Count - 1 do
      if ((Trim(TmpLines[I]) <> '') and (Pos('STARTED', UpperCase(TmpLines[I])) = 0) and (Pos('FINISHED', UpperCase(TmpLines[I])) = 0)) then
       fCalculatorStdOut.Add(TmpLines[I]);
    end;
    Result:= fCalculatorStdOut.Count;
   except
    fDebugStr:= GetCurrentDir;
    fCalculatorStdOut.Add('');
    fCalculatorStdOut.Add('WARNING!!! MEBDF ABORTED on Exception');
    fCalculatorStdOut.Add(' See file ' + fDebugStr + '\mebdf.log');
    fCalculatorStdOut.Add('');
    Result:= -1;
   end;
  finally
   FreeLibrary(HDLL);
   fCalculating:= False;
   UnScaleTimes;
   UnScaleN0;
   ActiveCalculator:= nil;
   TmpLines.Free;
  end;
 end
 else
 begin
  MessageDlg('MEBDF.DLL not found', mtError, [mbOk], 0);
  Result:= -1;
 end;
end;

function TChainCalculator.SolveChainWithRADAU(UseJAC: Boolean): integer;
const
 MaxRecallCount = 500;
 MaxSteps = MaxInt; //Max RADAU recall (high acuracy requested)
 RADAU_TimeEpsilon = 1.0E-5;
var
 NoOfY, NoOfX: integer;
 I, J, iout: integer;
 NEQ: integertype;
 WarnUser: Boolean;
 HDLL: Longword; //Thandle;
 TmpLines: TStringList;
 MacroSigma, l_mul_MacroSigma: Double;
 RADAUD_: procedure(const N, FCN, X, Y, XEND, H,
  RTOL, ATOL, ITOL,
  JAC, IJAC, MLJAC, MUJAC,
  MAS, IMAS, MLMAS, MUMAS,
  SOLOUT, IOUT_RADAUS,
  WORK, LWORK, IWORK, LIWORK, RPAR, IPAR, IDID: pointer); stdcall;
begin
 fDebugStr:= '';
 fStopCalculation:= False;
 TmpLines:= TStringList.Create;
 WarnUser:= False;
 if ProgressBar <> nil then
  with ProgressBar do
  begin
   Min:= 0;
   Max:= fTimePoints.Count - 1;
   Position:= 0;
  end;
 NoOfY:= fStatesCount;
 NoOfX:= fTimePoints.Count;
 PrepareIJ;
 PrepareTimes;
 if fUseSSK then
  PrepareSSK;
 NEQ:= NoOfY;
 ActiveCalculator:= Self;
 fCalculatorStdOut.Clear;
// HDLL:= LoadLibrary('RADAU.dll');
 HDLL:= LoadLibrary('RADAU');
 if HDLL >= 32 then
 begin { успешно }
  fCalculating:= True;
  DeleteFile('RADAU.log');
  RADAUD_:= GetProcAddress(HDLL, 'radaud_');
  ScaleTimes;
  ScaleN0;
  try
   try
    for i:= 1 to NEQ do
    begin
     ATOL[i]:= fatolerance[i - 1];
     RTOL[i]:= frtolerance[i - 1];
     if ((ATOL[i] < 0.999999E-13) or (RTOL[i] < 0.999999E-13)) then
      WarnUser:= True;
    end;
    if WarnUser then
    begin
     fCalculatorStdOut.Add('Recommendation:');
     fCalculatorStdOut.Add('For RADAU set all tolerances');
     fCalculatorStdOut.Add(' to be larger than 1.0e-13');
     fCalculatorStdOut.Add('');
    end;
    ITOL:= 1;
    for I:= 1 to NoOfY do
     y[I]:= N0[I - 1];
    X:= fTimePoints[0].Time;
    H:= 0.0;
    if UseJAC then
     IJAC:= 1
    else
     IJAC:= 0;
    MLJAC:= NEQ; //full
    MUJAC:= 1; // any
    IMAS:= 0; //no mass
    MLMAS:= NEQ;
    MUMAS:= 1; //any
    IOUT_RADAUS:= 0; //SOLOUT==nil
    IWORK[12]:= 7; //default value 1,3,5,7
    NSMAX:= IWORK[12];
    LWORK:= NEQ * (NEQ + 7 * NEQ + 3 * NSMAX + 3) + 20;
    LIWORK:= (2 + NSMAX div 2) * NEQ + 20 + 1;
    for I:= 1 to 20 do
    begin
     RWORK[I]:= 0.0;
     IWORK[I]:= 0;
    end;
    IWORK[12]:= 7; //default value 1,3,5,7
    for iout:= 1 to NoOfX - 1 do
    begin
     X:= fTimePoints[iout - 1].Time;
     TOUT:= fTimePoints[iout].Time;
// Fluxes now are global vars
     aThermalFlux:= fTimePoints[iout - 1].ThermalFlux;
     aResonanceFlux:= fTimePoints[iout - 1].ResonanceFlux;
     aFastFlux:= fTimePoints[iout - 1].FastFlux;
     aTng:= fTimePoints[iout - 1].Tng;
     if fDepressionConsider then
     try
      if aThermalFlux > 0 then
       if fTimeScaler > 0 then
        if fN0Scaler > 0 then
        begin
         MacroSigma:= 0;
         for I:= 1 to NoOfY do
          MacroSigma:= MacroSigma + fThermalIJ[I - 1, I - 1] / fTimeScaler * TngMultiplier(aTng, fG_factorIJ[I - 1, I - 1]) * Y[I] * fN0Scaler / fDepressionVolume;
         l_mul_MacroSigma:= fDepressionL * MacroSigma;
         aThermalFlux:= aThermalFlux * (1 - exp(-l_mul_MacroSigma)) / l_mul_MacroSigma;
        end;
     except
      aThermalFlux:= fTimePoints[iout - 1].ThermalFlux;
     end;
// Fluxes now are global vars
     H:= 0.0; //(TOUT-X)*1.0e-6;
     Application.ProcessMessages;
     if fStopCalculation then
     begin
      Result:= -1;
      Exit;
     end;
// SSK ResonanceIJ Correction
     if fUseSSK then
      if aResonanceFlux > 0 then
       if fN0Scaler > 0 then
       begin
        for I:= 0 to NoOfY - 1 do
         for J:= 0 to NoOfY - 1 do
          if fResonanceIJ0[J, I] > 0 then
           fResonanceIJ[J, I]:= fResonanceIJ0[J, I] * CalcSSK(J, Y[J + 1] * fN0Scaler)
          else
           fResonanceIJ[J, I]:= 0;
       end;
// SSK ResonanceIJ Correction
     RADAUD_(@NEQ, @dydt4dll, @X, @(Y[1]), @TOUT, @H,
      @(RTOL[1]), @(ATOL[1]), @ITOL,
      @dfdyRADAU, @IJAC, @MLJAC, @MUJAC,
      nil, @IMAS, @MLMAS, @MUMAS,
      nil, @IOUT_RADAUS,
      @RWORK, @LWORK, @IWORK, @LIWORK, @RPAR, @IPAR, @IDID);
     H:= 0.0;
     if IDID < 0 then
     begin
      fCalculatorStdOut.Add('WARNING!!! RADAU IDID<0 ');
      fCalculatorStdOut.Add('IDID = ' + IntToStr(IDID) + ' on RADAU step #' + IntToStr(iout));
      fCalculatorStdOut.Add('T0=' + FloatToStr(X) + ', TOUT=' + FloatToStr(TOUT));
      X:= fTimePoints[iout - 1].Time;
      TOUT:= fTimePoints[iout].Time;
      fCalculatorStdOut.Add(' Attempt to Recall on step #' + IntToStr(iout));
      fCalculatorStdOut.Add(' ThermalFlux = ' + Format('%-7.5g', [aThermalFlux]));
      fCalculatorStdOut.Add('');
      for j:= 1 to MaxRecallCount do
       case IDID of
{    IDID= 1  COMPUTATION SUCCESSFUL,
     IDID= 2  COMPUT. SUCCESSFUL (INTERRUPTED BY SOLOUT)
     IDID=-1  INPUT IS NOT CONSISTENT,
     IDID=-2  LARGER NMAX IS NEEDED,
     IDID=-3  STEP SIZE BECOMES TOO SMALL,
     IDID=-4  MATRIX IS REPEATEDLY SINGULAR.
}
        -1:
         begin
          for i:= 1 to NEQ do
          begin
           if fatolerance[i - 1] > 1.0E-13 then
            ATOL[i]:= fatolerance[i - 1]
           else
            ATOL[i]:= 1.0E-13;
           if frtolerance[i - 1] > 1.0E-13 then
            RTOL[i]:= frtolerance[i - 1]
           else
            RTOL[i]:= 1.0E-13;
          end;
          ITOL:= 1;
          H:= 0.0;
          if UseJAC then
           IJAC:= 1
          else
           IJAC:= 0;
          MLJAC:= NEQ; //full
          MUJAC:= 1; // any
          IMAS:= 0; //no mass
          MLMAS:= NEQ;
          MUMAS:= 1; //any
          IOUT_RADAUS:= 0; //SOLOUT==nil
          IWORK[12]:= 7; //default value 1,3,5,7
          NSMAX:= IWORK[12];
          LWORK:= (NSMAX + 1) * NEQ * NEQ + (3 * NSMAX + 3) * NEQ + 20;
          LIWORK:= (2 + (NSMAX - 1) div 2) * NEQ + 20 + 1;
          for I:= 1 to 20 do
          begin
           RWORK[I]:= 0.0;
           IWORK[I]:= 0;
          end;
         end;
        -2:
         begin
{     IDID=-2  LARGER NMAX IS NEEDED,}
          if IWORK[2] = 0 then
           IWORK[2]:= 200000
          else if 2 * IWORK[2] < MaxSteps then
           IWORK[2]:= 2 * IWORK[2]
          else
           break;
         end;
        -3:
         begin
{     IDID=-3  STEP SIZE BECOMES TOO SMALL}
          if H > 1.0E-300 then
          begin
           H:= 0.0;
           continue;
          end
          else
           break;
         end;
        -4:
         begin
{     IDID=-4  MATRIX IS REPEATEDLY SINGULAR.}
          break;
         end;
       else
        begin
        end;
       end; //case
     end;
     for j:= 1 to NoOfY do
      if Y[j] < 0 then
       Y[j]:= 0;
(*
     if iout<NoOfX-1 then
      for j:= 1 to NoOfY do
       if ((RTOL[j]*ABS(Y[j])+ATOL[j])>1.0E-3)
        then ATOL[j]:= 0
       else begin
        if fatolerance[j-1]>1.0E-13 then
         ATOL[j]:= fatolerance[j-1]
        else
         ATOL[j]:= 1.0E-13;
       end;
*)
     if ((TOUT > fTimePoints[iout].Time * (1 + RADAU_TimeEpsilon)) or (TOUT < fTimePoints[iout].Time * (1 - RADAU_TimeEpsilon))) then
      fCalculatorStdOut.Add('TimePoints[iout].Time<>TOUT ' + 'iout=' + IntToStr(iout) +
       'TimePoints[iout].Time=' + FloatTostr(fTimePoints[iout].Time) +
       ' TOUT=' + FloatToStr(TOUT));
     for j:= 1 to NoOfY do
      fNvsTimeST[j - 1, iout]:= Y[j];
// TolSwitch
     if fNeedTolSwitch then
     begin
      for j:= 1 to NoOfY do
       if Y[j] > Self.fatolerance[j - 1] then
        atol[j]:= 0.0
       else
        atol[j]:= Self.fatolerance[j - 1];
     end;
// TolSwitch
     if ProgressBar <> nil then
      with ProgressBar do
       Position:= iout;
     Application.ProcessMessages;
    end;
    FreeLibrary(HDLL);
    if FileExists('RADAU.log') then
    begin
     TmpLines.LoadFromFile('RADAU.log');
     for i:= 0 to TmpLines.Count - 1 do
      if ((Trim(TmpLines[I]) <> '') and (Pos('STARTED', UpperCase(TmpLines[I])) = 0) and (Pos('FINISHED', UpperCase(TmpLines[I])) = 0)) then
       fCalculatorStdOut.Add(TmpLines[I]);
    end;
    Result:= fCalculatorStdOut.Count;
   except
    fCalculatorStdOut.Add('');
    fCalculatorStdOut.Add('WARNING!!! RADAU (DLL) ABORTED on Exception');
    fCalculatorStdOut.Add('');
    Result:= -1;
   end;
  finally
   FreeLibrary(HDLL);
   UnScaleTimes;
   UnScaleN0;
   fCalculating:= False;
   TmpLines.Free;
   ActiveCalculator:= nil;
  end;
 end
 else
 begin
  MessageDlg('RADAU.DLL not found', mtError, [mbOk], 0);
  Result:= -1;
 end;
end;

function TChainCalculator.SolveChainWithVODE(UseJAC: Boolean = True; UseDLL: Boolean = False): integer;
const
 MaxRecallCount = 50; //Max dvode recall (high acuracy requested)
 VODE_TimeEpsilon = 1.0E-5;
var
 NoOfY, NoOfX: integer;
 I, J, iout: integer;
 TmpLines: TStringList;
 WarnUser: Boolean;
 MacroSigma, l_mul_MacroSigma: Double;
 NEQ: integertype;
 HDLL: Longword; //Thandle;
 VODED_: procedure(
  const F, NEQ, Y, T, TOUT, ITOL, RTOL, ATOL, ITASK, ISTATE, IOPT, RWORK, LRW, IWORK,
  LIW, JAC, MF, RPAR, IPAR: pointer); stdcall;
begin
 fDebugStr:= '';
 fStopCalculation:= False;
 fCalculatorStdOut.Clear;
 TmpLines:= TStringList.Create;
 WarnUser:= False;
 if ProgressBar <> nil then
  with ProgressBar do
  begin
   Min:= 0;
   Max:= fTimePoints.Count - 1;
   Position:= 0;
  end;
 try
  NoOfY:= fStatesCount;
  NoOfX:= fTimePoints.Count;
  PrepareIJ;
  PrepareTimes;
  ScaleTimes;
  ScaleN0;
  if fUseSSK then
   PrepareSSK;
  NEQ:= NoOfY;
  if UseJAC then
   MF:= 21
  else
   MF:= 22;
  LRW:= 22 + 9 * NEQ + 2 * NEQ * NEQ;
  LIW:= 30 + NEQ;
  ITASK:= 4;
  ISTATE:= 1;
  ITOL:= 2;
  IOPT:= 0;
  for i:= 1 to NEQ do
  begin
   ATOL[i]:= fatolerance[i - 1];
   RTOL[i]:= frtolerance[i - 1];
   if ((ATOL[i] < 0.999999E-15) or (RTOL[i] < 0.9999990E-15)) then
    WarnUser:= True;
  end;
  if WarnUser then
  begin
   fCalculatorStdOut.Add('Recommendation:');
   fCalculatorStdOut.Add('For VODE set all tolerances');
   fCalculatorStdOut.Add(' to be larger than 1.0e-15');
   fCalculatorStdOut.Add('');
  end;
  for I:= 1 to NoOfY do
   y[I]:= N0[I - 1];
  Ti:= fTimePoints[0].Time;
  ActiveCalculator:= Self;
  fCalculating:= True;
  if UseDLL then
  begin
   Result:= -1;
   HDLL:= LoadLibrary('vode');
   if HDLL >= 32 then { OK }
   begin
    DeleteFile('vode.log');
    try
     try
      VODED_:= GetProcAddress(HDLL, 'voded_');
      for iout:= 1 to NoOfX - 1 do
      begin
       TOUT:= fTimePoints[iout].Time;
// Fluxes now are global vars
       aThermalFlux:= fTimePoints[iout - 1].ThermalFlux;
       aResonanceFlux:= fTimePoints[iout - 1].ResonanceFlux;
       aFastFlux:= fTimePoints[iout - 1].FastFlux;
       aTng:= fTimePoints[iout - 1].Tng;
       if fDepressionConsider then
       try
        if aThermalFlux > 0 then
         if fTimeScaler > 0 then
          if fN0Scaler > 0 then
          begin
           MacroSigma:= 0;
           for I:= 1 to NoOfY do
            MacroSigma:= MacroSigma + fThermalIJ[I - 1, I - 1] / fTimeScaler * TngMultiplier(aTng, fG_factorIJ[I - 1, I - 1]) * Y[I] * fN0Scaler / fDepressionVolume;
           l_mul_MacroSigma:= fDepressionL * MacroSigma;
           aThermalFlux:= aThermalFlux * (1 - exp(-l_mul_MacroSigma)) / l_mul_MacroSigma;
          end;
       except
        aThermalFlux:= fTimePoints[iout - 1].ThermalFlux;
       end;
// Fluxes now are global vars
       RWORK[1]:= TOUT;
       Application.ProcessMessages;
       if fStopCalculation then
       begin
        Result:= -1;
        Exit;
       end;
// SSK ResonanceIJ Correction
       if fUseSSK then
        if aResonanceFlux > 0 then
         if fN0Scaler > 0 then
         begin
          for I:= 0 to NoOfY - 1 do
           for J:= 0 to NoOfY - 1 do
            if (fResonanceIJ0[J, I] > 0) then
             fResonanceIJ[J, I]:= fResonanceIJ0[J, I] * CalcSSK(J, y[J + 1] * fN0Scaler)
            else
             fResonanceIJ[J, I]:= 0;
         end;
// SSK ResonanceIJ Correction
       VODED_(@dydt4dll, @NEQ, @Y, @Ti, @TOUT, @ITOL, @RTOL, @ATOL, @ITASK, @ISTATE, @IOPT,
        @(RWORK[1]), @LRW, @(IWORK[1]), @LIW, @JAC4dll, @MF, @(RPAR[1]), @(IPAR[1]));
       if ISTATE < 0 then //((ISTATE=-1)or(ISTATE=-2)) then begin
        if (ISTATE > -3) then
        begin //((ISTATE=-1)or(ISTATE=-2)) then begin
         fCalculatorStdOut.Add('WARNING!!! VODE ISTATE = ' + IntToStr(ISTATE));
         fCalculatorStdOut.Add(' Attempt to Recall on step #' + IntToStr(iout));
         fCalculatorStdOut.Add(' ThermalFlux = ' + Format('%-7.5g', [aThermalFlux]));
         fCalculatorStdOut.Add('');
         for i:= 1 to MaxRecallCount do
         begin
          ISTATE:= 2;
          TOUT:= fTimePoints[iout].Time;
          VODED_(@dydt4dll, @NEQ, @Y, @Ti, @TOUT, @ITOL, @RTOL, @ATOL, @ITASK, @ISTATE, @IOPT,
           @(RWORK[1]), @LRW, @(IWORK[1]), @LIW, @JAC4dll, @MF, @(RPAR[1]), @(IPAR[1]));
          if ((ISTATE = -6)) then
          begin
           for j:= 1 to NoOfY do
            if ((RTOL[j] * ABS(Y[j]) + ATOL[j]) > RTOL_mul_ABS_Y_plus_ATOL) then
             ATOL[j]:= 0
            else
             ATOL[j]:= Self.fatolerance[j - 1];
           continue;
          end;
          if (ISTATE > 0) then
           break;
         end;
         if ((TOUT > fTimePoints[iout].Time * (1 + VODE_TimeEpsilon)) or (TOUT < fTimePoints[iout].Time * (1 - VODE_TimeEpsilon))) then
          fCalculatorStdOut.Add('TimePoints[iout].Time<>TOUT ' + 'iout=' + IntToStr(iout) +
           'TimePoints[iout].Time=' + FloatTostr(fTimePoints[iout].Time) +
           ' TOUT=' + FloatToStr(TOUT));
        end
        else
        begin //( ISTATE=-3)- Illegal Input
         fCalculatorStdOut.Add('WARNING!!! VODE ISTATE = ' + IntToStr(ISTATE));
         fCalculatorStdOut.Add(' Unrecoverable on step #' + IntToStr(iout));
         fCalculatorStdOut.Add(' ThermalFlux = ' + Format('%-7.5g', [aThermalFlux]));
         fCalculatorStdOut.Add('');
         Result:= -1;
         Exit;
        end;
       for j:= 1 to NoOfY do
        if Y[j] < 0 then
         Y[j]:= 0.0;
       for j:= 1 to NoOfY do
        fNvsTimeST[j - 1, iout]:= Y[j];
// TolSwitch
       if fNeedTolSwitch then
       begin
        for j:= 1 to NoOfY do
         if Y[j] > Self.fatolerance[j - 1] then
          atol[j]:= 0.0
         else
          atol[j]:= Self.fatolerance[j - 1];
       end;
// TolSwitch
       if ProgressBar <> nil then
        with ProgressBar do
         Position:= iout;
       Application.ProcessMessages;
      end;
     finally
      if FileExists('vode.log') then
      begin
       TmpLines.LoadFromFile('vode.log');
       if TmpLines.Count > 0 then
        TmpLines.Delete(0);
       if TmpLines.Count > 0 then
        TmpLines.Delete(TmpLines.Count - 1);
       fCalculatorStdOut.Text:= fCalculatorStdOut.Text + TmpLines.Text;
      end;
     end
    except
     fCalculatorStdOut.Add('');
     fCalculatorStdOut.Add('WARNING!!! VODE (DLL) ABORTED on Exception');
     fCalculatorStdOut.Add('');
     Result:= -1;
    end;
   end
   else
    MessageDlg('VODE.DLL not found', mtError, [mbOk], 0);
  end
  else
  begin //not DLL
   try
    DVODEu4cc.StdOut.Clear;
    DVODEu4cc.AbortVODE:= False;
    for i:= 1 to NEQ do
    begin
     ATOL[i]:= fatolerance[i - 1];
     RTOL[i]:= frtolerance[i - 1];
     if ((ATOL[i] < 0.99999E-7) or (RTOL[i] < 0.99999E-7)) then // 1.0e-5
      WarnUser:= True;
    end;
    if WarnUser then
    begin
     fCalculatorStdOut.Add('Recommendation:');
     fCalculatorStdOut.Add('For VODE(no-dll) set all tolerances');
     fCalculatorStdOut.Add(' to be larger than 1.0e-7'); // qqqq WAS 1.0e-5
     fCalculatorStdOut.Add('');
    end;
    for iout:= 1 to NoOfX - 1 do
    begin
     Application.ProcessMessages;
     if fStopCalculation then
      DVODEu4cc.AbortVODE:= True;
// Fluxes now are global vars
     aThermalFlux:= fTimePoints[iout - 1].ThermalFlux;
     aResonanceFlux:= fTimePoints[iout - 1].ResonanceFlux;
     aFastFlux:= fTimePoints[iout - 1].FastFlux;
     aTng:= fTimePoints[iout - 1].Tng;
     if fDepressionConsider then
     try
      if aThermalFlux > 0 then
       if fTimeScaler > 0 then
        if fN0Scaler > 0 then
        begin
         MacroSigma:= 0;
         for I:= 1 to NoOfY do
          MacroSigma:= MacroSigma + fThermalIJ[I - 1, I - 1] / fTimeScaler * TngMultiplier(aTng, fG_factorIJ[I - 1, I - 1]) * Y[I] * fN0Scaler / fDepressionVolume;
         l_mul_MacroSigma:= fDepressionL * MacroSigma;
         aThermalFlux:= aThermalFlux * (1 - exp(-l_mul_MacroSigma)) / l_mul_MacroSigma;
        end;
     except
      aThermalFlux:= fTimePoints[iout - 1].ThermalFlux;
     end;
// Fluxes now are global vars
     if fStopCalculation then
     begin
      Result:= -1;
      Exit;
     end;
     TOUT:= fTimePoints[iout].Time;
     RWORK[1]:= TOUT;
// SSK ResonanceIJ Correction
     if fUseSSK then
      if aResonanceFlux > 0 then
       if fN0Scaler > 0 then
       begin
        for I:= 0 to NoOfY - 1 do
         for J:= 0 to NoOfY - 1 do
          if fResonanceIJ0[J, I] > 0 then
           fResonanceIJ[J, I]:= fResonanceIJ0[J, I] * CalcSSK(J, Y[J + 1] * fN0Scaler)
          else
           fResonanceIJ[J, I]:= 0;
       end;
// SSK ResonanceIJ Correction
     DVODE(ChainCalcDyDt4DLL, NEQ, Y, Ti, TOUT, ITOL, RTOL, ATOL, ITASK, ISTATE, IOPT, RWORK[1], LRW,
      IWORK[1], LIW, ChainCalcDfDy4DLL, MF, RPAR[1], IPAR[1]);
     if ISTATE < 0 then
      if (ISTATE > -3) then
      begin //(ISTATE=-1)or(ISTATE=-2)-bad
       fCalculatorStdOut.Add('WARNING!!! VODE ISTATE = ' + IntToStr(ISTATE));
       fCalculatorStdOut.Add(' Attempt to Recall on step #' + IntToStr(iout));
       fCalculatorStdOut.Add(' ThermalFlux = ' + Format('%-7.5g', [aThermalFlux]));
       fCalculatorStdOut.Add('  Use DLL !!!');
       fCalculatorStdOut.Add('');
       ISTATE:= 2;
       for i:= 1 to MaxRecallCount do
       begin
        Application.ProcessMessages;
        if fStopCalculation then
         DVODEu4cc.AbortVODE:= True;
        TOUT:= fTimePoints[iout].Time;
        RWORK[1]:= TOUT;
        DVODE(ChainCalcDyDt4DLL, NEQ, Y, Ti, TOUT, ITOL, RTOL, ATOL, ITASK, ISTATE, IOPT, RWORK[1], LRW,
         IWORK[1], LIW, ChainCalcDfDy4DLL, MF, RPAR[1], IPAR[1]);
        if (ISTATE > 0) then
         break;
       end;
       if ((TOUT > fTimePoints[iout].Time * (1 + VODE_TimeEpsilon)) or (TOUT < fTimePoints[iout].Time * (1 - VODE_TimeEpsilon))) then
        fCalculatorStdOut.Add('TimePoints[iout].Time<>TOUT ' + 'iout=' + IntToStr(iout) +
         'TimePoints[iout].Time=' + FloatTostr(fTimePoints[iout].Time) +
         ' TOUT=' + FloatToStr(TOUT));
      end
      else
      begin //( ISTATE=-3)- Illegal Input
       fCalculatorStdOut.Add('WARNING!!! VODE ISTATE = ' + IntToStr(ISTATE));
       fCalculatorStdOut.Add(' Unrecoverable on step #' + IntToStr(iout));
       fCalculatorStdOut.Add(' ThermalFlux = ' + Format('%-7.5g', [aThermalFlux]));
       fCalculatorStdOut.Add('  Use DLL !!!');
       fCalculatorStdOut.Add('');
       Result:= -1;
       Exit;
      end;
     for j:= 1 to NoOfY do
      fNvsTimeST[j - 1, iout]:= Y[j];
     if ProgressBar <> nil then
      with ProgressBar do
       Position:= iout;
     Application.ProcessMessages;
    end;
    for I:= 1 to NoOfY do
     for J:= 2 to NoOfX do
      if fNvsTimeST[I - 1, J - 1] < 0 then
       fNvsTimeST[I - 1, J - 1]:= 0;
    for I:= 0 to DVODEu4cc.StdOut.Count - 1 do
     fCalculatorStdOut.Add(DVODEu4cc.StdOut[I]);
    Result:= fCalculatorStdOut.Count;
   except
    fCalculatorStdOut.Add('');
    fCalculatorStdOut.Add('WARNING!!! VODE ABORTED on Exception');
    fCalculatorStdOut.Add('  Use DLL !!!');
    fCalculatorStdOut.Add('');
    Result:= -1;
   end;
  end;
 finally
  fCalculating:= False;
  ActiveCalculator:= nil;
  fCalculating:= False;
  UnScaleN0;
  UnScaleTimes;
  TmpLines.Free;
 end;
end;

procedure TChainCalculator.ChainCalcDyDt4DLL(const NEQ: integertype; var T, Y_, YDOT_,
 RPAR_: realtype; var IPAR_: integertype);
var
 Y: realarraytype absolute Y_;
 YDOT: realarraytype absolute YDOT_;
 RFAR: realarraytype absolute RPAR_;
 IPAR: integerarraytype absolute IPAR_;
 SumIncreaseI: Double;
 NoOfY: integer;
 I, J: integer;
begin
 NoOfY:= fStatesCount;
 for I:= 1 to NoOfY do
 begin
  if fStopCalculation then
   Exit;
  SumIncreaseI:= 0;
  for J:= 1 to NoOfY do
   if (J <> I) then
    SumIncreaseI:= SumIncreaseI + (fLambdaIJ[J - 1, I - 1] + fThermalIJ[J - 1, I - 1] * aThermalFlux * TngMultiplier(aTng, fG_factorIJ[J - 1, I - 1])
     + fResonanceIJ[J - 1, I - 1] * aResonanceFlux + fFastIJ[J - 1, I - 1] * aFastFlux) * y[J];
  YDOT[I]:= SumIncreaseI - (fLambdaIJ[I - 1, I - 1] + fThermalIJ[I - 1, I - 1] * aThermalFlux * TngMultiplier(aTng, fG_factorIJ[I - 1, I - 1])
   + fResonanceIJ[I - 1, I - 1] * aResonanceFlux + fFastIJ[I - 1, I - 1] * aFastFlux) * y[I];
 end;
end;

procedure TChainCalculator.ChainCalcDfDy4DLL(const NEQ: integertype;
 var T, Y_: realtype; var ML, MU: integertype; var PD_: realtype;
 var NRPD: integertype; var RPAR: realtype; var IPAR: integertype);
var
 PD: realarraytype absolute PD_;
 Y: realarraytype absolute Y_;
 NoOfY: integer;
 I, J: integer;
begin
 NoOfY:= fStatesCount;
 I:= 1;
 while (I <= NoOfY) do
 begin
  if fStopCalculation then
   Exit;
  J:= 1;
  while (J <= NoOfY) do
  begin
   if (I = J) then
   begin
    PD[(I - 1) * NEQ + I]:= -(fLambdaIJ[I - 1, I - 1] + fThermalIJ[I - 1, I - 1] * aThermalFlux * TngMultiplier(aTng, fG_factorIJ[I - 1, I - 1])
     + fResonanceIJ[I - 1, I - 1] * aResonanceFlux + fFastIJ[I - 1, I - 1] * aFastFlux);
   end
   else
   begin
    PD[(J - 1) * NEQ + I]:= (fLambdaIJ[J - 1, I - 1] + fThermalIJ[J - 1, I - 1] * aThermalFlux * TngMultiplier(aTng, fG_factorIJ[J - 1, I - 1])
     + fResonanceIJ[J - 1, I - 1] * aResonanceFlux + fFastIJ[J - 1, I - 1] * aFastFlux);
   end;
   Inc(J);
  end;
  Inc(I);
 end;
end;

function TChainCalculator.GetTimesCount: integer;
begin
 Result:= fTimePoints.Count;
end;

procedure TChainCalculator.ClearTimePoints;
begin
 fTimePoints.Clear;
end;

function TChainCalculator.GetStateName(Index: Integer): string;
begin
 if Index < fChain.States.Count then
 try
  Result:= fChain.States[Index].Name;
 except
  Result:= 'NaNu';
 end
 else
  Result:= 'NaNc';
end;

procedure TChainCalculator.StopCalculation;
begin
 fStopCalculation:= True;
 fCalculatorStdOut.Add('Calculation ABORTED');
end;

procedure TChainCalculator.PrepareActivityTables;
var
 I: integer;
 dt: TDecayType;
begin
// ActivityTable - Set
 SetLength(fNone_Table, fStatesCount);
 SetLength(fA_Table, fStatesCount);
 SetLength(fBM_Table, fStatesCount);
 SetLength(fEC_Table, fStatesCount);
 SetLength(fIT_Table, fStatesCount);
 SetLength(fN_Table, fStatesCount);
 SetLength(fP_Table, fStatesCount);
 SetLength(fSF_Table, fStatesCount);
 SetLength(fQ_Table, fStatesCount);
 for dt:= dtNone to dtSF do
 begin
  if (fStatesCount <> Self.fChain.States.Count) then
  begin
   MessageDlg('Serious error !!!' + #10#13 +
    'fStatesCount<>Self.fChain.States.Count' + #10#13 +
    'The results may be a mess !!!', mtError, [mbOK], 0);
  end;
// dtNone, dtA, dtBM, dtEC, dtIT, dtN,  dtP, dtSF, dtQ
//   0       1     2    3     4     5    6    7     8
  case dt of
   dtNone: for I:= 0 to fStatesCount - 1 do
     fNone_Table[I]:= Self.fChain.States[I].GetDecayTypeValue(dtNone);
   dtA: for I:= 0 to fStatesCount - 1 do
     fA_Table[I]:= Self.fChain.States[I].GetDecayTypeValue(dtA);
   dtBM: for I:= 0 to fStatesCount - 1 do
     fBM_Table[I]:= Self.fChain.States[I].GetDecayTypeValue(dtBM);
   dtEC: for I:= 0 to fStatesCount - 1 do
     fEC_Table[I]:= Self.fChain.States[I].GetDecayTypeValue(dtEC);
   dtIT: for I:= 0 to fStatesCount - 1 do
     fIT_Table[I]:= Self.fChain.States[I].GetDecayTypeValue(dtIT);
   dtN: for I:= 0 to fStatesCount - 1 do
     fN_Table[I]:= Self.fChain.States[I].GetDecayTypeValue(dtN);
   dtP: for I:= 0 to fStatesCount - 1 do
     fP_Table[I]:= Self.fChain.States[I].GetDecayTypeValue(dtP);
   dtSF: for I:= 0 to fStatesCount - 1 do
     fSF_Table[I]:= Self.fChain.States[I].GetDecayTypeValue(dtSF);
   dtQ: for I:= 0 to fStatesCount - 1 do
     fQ_Table[I]:= Self.fChain.States[I].GetDecayTypeValue(dtQ);
  else
// qqqq
  end;
  fDecayTablesReady:= True;
 end;
end;

function TChainCalculator.GetFissionEnergyDepositionNIvsTime(const StateNo, TimeNo: integer; const ConsiderDepression, SSKconsider: Boolean; const Energy4fission: Float): Float;
var
 I: integer;
 N_nuclei, l_mul_MacroSigma, MacroSigma: Float;
 SigmaF, RIf, SigmaF_fast, aThermalFlux, aResonanceFlux, aFastFlux, aTng: Float;
begin
 N_nuclei:= GetNIvsTime(StateNo, TimeNo);
 with fTimePoints[TimeNo] do
 begin
  aThermalFlux:= fTimePoints[TimeNo].ThermalFlux;
  aResonanceFlux:= fTimePoints[TimeNo].ResonanceFlux;
  aFastFlux:= fTimePoints[TimeNo].FastFlux;
  aTng:= fTimePoints[TimeNo].Tng;
 end;
 if aThermalFlux < 0 then
  aThermalFlux:= 0;
 if aTng < 0 then
  aTng:= 0;
 if fDepressionConsider then
 begin
  try
   if aThermalFlux > 0 then
   begin
    MacroSigma:= 0;
    for I:= 1 to fStatesCount do
     MacroSigma:= MacroSigma + fThermalIJ[I - 1, I - 1] * TngMultiplier(aTng, fG_factorIJ[I - 1, I - 1]) * GetNIvsTime(I - 1, TimeNo) / fDepressionVolume;
    l_mul_MacroSigma:= fDepressionL * MacroSigma;
    aThermalFlux:= aThermalFlux * (1 - exp(-l_mul_MacroSigma)) / l_mul_MacroSigma;
   end;
  except
   aThermalFlux:= fTimePoints[TimeNo].ThermalFlux;
  end;
 end;
 if aResonanceFlux < 0 then
  aResonanceFlux:= 0;
 if (SSKconsider and (aResonanceFlux > 0)) then
  aResonanceFlux:= aResonanceFlux * CalcSSK(StateNo, N_nuclei);
 if aFastFlux < 0 then
  aFastFlux:= 0;
 SigmaF:= fChain.States[StateNo].GetSigmaF(0) * TngMultiplier(aTng, fG_factorIJ[StateNo, StateNo]);
 RIf:= fChain.States[StateNo].GetSigmaF(1);
 SigmaF_fast:= fChain.States[StateNo].GetSigmaF(2);
 Result:= (SigmaF * aThermalFlux + RIf * aResonanceFlux + SigmaF_fast * aFastFlux) *
  N_nuclei * Energy4fission;
end;

function TChainCalculator.GetActivitiNIvsTime(StateNo, TimeNo: Integer;
 dt: TDecayType): Float;
var
 N_nuclei: Float;
begin
 Result:= 0.0;
 N_nuclei:= GetNIvsTime(StateNo, TimeNo);
 if not (fDecayTablesReady) then
  PrepareActivityTables;
// dtNone, dtA, dtBM, dtEC, dtIT, dtN,  dtP, dtSF, dtQ
 case dt of
  dtNone: Result:= fNone_Table[StateNo] * N_nuclei;
  dtA: Result:= fA_Table[StateNo] * N_nuclei;
  dtBM: Result:= fBM_Table[StateNo] * N_nuclei;
  dtEC: Result:= fEC_Table[StateNo] * N_nuclei;
  dtIT: Result:= fIT_Table[StateNo] * N_nuclei;
  dtN: Result:= fN_Table[StateNo] * N_nuclei;
  dtP: Result:= fP_Table[StateNo] * N_nuclei;
  dtSF: Result:= fSF_Table[StateNo] * N_nuclei;
  dtQ: Result:= fQ_Table[StateNo] * N_nuclei;
 else
  Exit;
 end;
end;

function TChainCalculator.GetElementMass(const ElementName: string; const TimeNo: integer): Float;
var
 I: integer;
 ElementStates: TLongIntList;
begin
 Result:= 0;
 ElementStates:= TLongIntList.Create;
 try
  if Self.fChain.FindElements(ElementName, ElementStates) then
   for I:= 0 to ElementStates.Count - 1 do
    Result:= Result + GetStateMass(ElementStates[I], TimeNo);
 finally
  ElementStates.Free;
 end;
end;

procedure TChainCalculator.GetElements(var ElementZs: TLongIntList);
var
 I: integer;
begin
 ElementZs.Clear;
 for I:= 0 to fStatesCount - 1 do
  ElementZs.AddUniq(fChain.States[I].ThZpA_s div 10000);
end;

function TChainCalculator.GetStateMass(const StateNo, TimeNo: Integer): Float;
begin
 Result:= fNvsTimeST[StateNo, TimeNo] / N_Av * (((Self.fChain.States[StateNo].ThZpA_s) div 10) mod 1000);
end;

function TChainCalculator.GetTotalMass(const TimeNo: Integer): Float;
var
 I: integer;
begin
 Result:= 0;
 for I:= 0 to Self.fStatesCount - 1 do
  Result:= Result + GetStateMass(I, TimeNo);
end;

function TChainCalculator.GetDepresssionK(const TimeNo: integer): Float;
var
 NoOfY: integer;
 I, TimePointNo: integer;
 aTng, MacroSigma, l_mul_MacroSigma: double;
begin
 try
  NoOfY:= fStatesCount;
  TimePointNo:= TimeNo;
  if TimePointNo < 0 then
  begin
   aTng:= 0;
  end
  else
   with fTimePoints[TimePointNo] do
   begin
    aTng:= fTimePoints[TimePointNo].Tng;
   end;
  if ((fTimeScaler > 0) and (fN0Scaler > 0)) then
  begin
   MacroSigma:= 0;
   for I:= 1 to NoOfY do
    MacroSigma:= MacroSigma + fThermalIJ[I - 1, I - 1] / fTimeScaler * TngMultiplier(aTng, fG_factorIJ[I - 1, I - 1]) * Y[I] * fN0Scaler / fDepressionVolume;
//   l_div_MacroSigma:= fDepressionL/MacroSigma;
//   Result:= (1-exp(-l_div_MacroSigma))/l_div_MacroSigma;
   l_mul_MacroSigma:= fDepressionL * MacroSigma;
   if l_mul_MacroSigma > 0 then
    Result:= (1 - exp(-l_mul_MacroSigma)) / l_mul_MacroSigma
   else
    Result:= 1.0;
  end
  else
  begin
   MacroSigma:= 0;
   for I:= 1 to NoOfY do
    MacroSigma:= MacroSigma + fThermalIJ[I - 1, I - 1] * TngMultiplier(aTng, fG_factorIJ[I - 1, I - 1]) * fNvsTimeST[I - 1, TimeNo] / fDepressionVolume;
//   l_div_MacroSigma:= fDepressionL/MacroSigma;
//   Result:= (1-exp(-l_div_MacroSigma))/l_div_MacroSigma;
   l_mul_MacroSigma:= fDepressionL * MacroSigma;
   if l_mul_MacroSigma > 0 then
    Result:= (1 - exp(-l_mul_MacroSigma)) / l_mul_MacroSigma
   else
    Result:= 1.0;
  end;
 except
  Result:= -1;
 end;
end;

procedure TChainCalculator.AssignSSK_Tables(const aTables: TSSK_TableList);
begin
 fExternalSSK.Assign(aTables);
end;

procedure TChainCalculator.PrepareSSK;
var
 I, J, N: integer;
 aSSKTable: TSSK_Table;
begin
 fInternalSSK.Clear;
 for I:= 0 to Self.fStatesCount - 1 do
  fInternalSSK.Add(nil);
 for I:= 0 to Self.fStatesCount - 1 do
 begin
  for J:= 0 to fExternalSSK.Count - 1 do
   if Self.fChain.States[I].ThZpA_s = TSSK_Table(fExternalSSK[J]).ThZpA_s then
    if (TSSK_Table(fExternalSSK[J]).IsOK) then
    begin
     aSSKTable:= TSSK_Table.Create(TSSK_Table(fExternalSSK[J]).ThZpA_s);
     aSSKTable.Assign(TSSK_Table(fExternalSSK[J]));
     for N:= 0 to aSSKTable.PointsNumber - 1 do
     begin
      if (aSSKTable.Get_SSK(N) < 0) then
       aSSKTable.Set_SSK(N, 0)
      else if (aSSKTable.Get_SSK(N) > 1) then
       aSSKTable.Set_SSK(N, 1.0);
      aSSKTable.Set_Concentration(N, Ln(aSSKTable.Get_Concentration(N))); // qqqq Ln !!!
     end;
     aSSKTable.Order;
     fInternalSSK[I]:= aSSKTable;
     break;
    end;
 end;
 if fInternalSSK.NotNullCount < 1 then
 begin
  fUseSSK:= False;
 end;
 PrepareIJ0;
end;

function TChainCalculator.CalcSSK(const StateNo: integer; const Nuclei: Float): Float; //==ApproximateSSK
var
 fN, fSSK: TFloatList;
 i, k: integer;
 N, aN, dYdX: Float;
begin
 Result:= 1;
 if fUseSSK then
 begin
  try
   N:= Nuclei / fRA_VolumeForSSK;
   if fInternalSSK[StateNo]=nil then begin
    Result:= 1;
    exit;
   end;
   fN:= TSSK_Table(fInternalSSK[StateNo]).fConcentration;
   fSSK:= TSSK_Table(fInternalSSK[StateNo]).fSSK;
   if N<=0 then begin
    Result:=1;
    exit;
   end;
   aN:= Ln(N);
   k:= -1;
   for i:= 0 to fN.Count - 2 do
    if ((aN > fN[i] - 1.0E-13) and (aN < fN[i + 1])) then
    begin
     k:= i;
     break;
    end;
   if k < 0 then
   begin
//extrapolation
    if aN <= fN[0] then
    begin
     dYdX:= (fSSK[1] - fSSK[0]) / (fN[1] - fN[0]);
     Result:= fSSK[0] + (aN - fN[0]) * dYdX;
     if Result < 0 then
      Result:= fSSK[0] / 2;
    end
    else if aN >= fN.Last then
    begin
     dYdX:= (fSSK[fSSK.Count - 1] - y[fSSK.Count - 1 - 1]) / (fN[fSSK.Count - 1] - fN[fSSK.Count - 1 - 1]);
     Result:= fSSK[fSSK.Count - 1] + (aN - fN[fSSK.Count - 1]) * dYdX;
     if Result > 1 then
      Result:= 1.0;
    end;
   end
   else
   begin
// interpolation
    dYdX:= (fSSK[k + 1] - fSSK[k]) / (fN[k + 1] - fN[k]);
    Result:= fSSK[k] + (aN - fN[k]) * dYdX;
(* // NEver HERE !
    if Result>1 then
     Result:= 1.0;
*)
   end;
  except
   Result:= 1;
  end;
 end;
end;

function TChainCalculator.ApproximateSSK(const StateNo: integer;
 const N: Float): Float;
begin
 Result:= CalcSSK(StateNo, N);
end;

procedure TChainCalculator.AdjustTimeCount(Value: integer);
var
 S, T: integer;
begin
 if (Value <> fTimesCount) then
 begin
  fTimesCount:= Value;
  SetLength(fTmpArray, fStatesCount);
  for S:= 0 to fStatesCount - 1 do
  try
   fTmpArray[S]:= fNvsTimeST[S, 0];
  except
   fTmpArray[S]:= 0.0;
  end;
  SetLength(fNvsTimeST, fStatesCount, fTimesCount);
  for S:= 0 to fStatesCount - 1 do
  begin
   fNvsTimeST[S, 0]:= fTmpArray[S];
   for T:= 1 to fTimesCount - 1 do
    fNvsTimeST[S, T]:= 0.0;
  end;
 end;
end;

function TChainCalculator.GetAtolerance(Index: integer): Float;
begin
 Result:= fatolerance[Index];
end;

function TChainCalculator.GetRtolerance(Index: integer): Float;
begin
 Result:= frtolerance[Index];
end;

procedure TChainCalculator.SetAtolerance(Index: integer; Tol: Float);
begin
 fatolerance[Index]:= Tol;
end;

procedure TChainCalculator.SetRtolerance(Index: integer; Tol: Float);
begin
 frtolerance[Index]:= Tol;
end;

{TTimePointList}

constructor TTimePointList.Create(aChainCalculator: TChainCalculator);
begin
 inherited Create;
 fChainCalculator:= aChainCalculator;
end;

function TTimePointList.GetTimePoint(Index: integer): TTimePoint;
begin
 Result:= TTimePoint(Items[Index]^);
end;

procedure TTimePointList.SetTimePoint(Index: integer; aTimePoint: TTimePoint);
begin
 with TTimePoint(Items[Index]^), aTimePoint do
 begin
  TTimePoint(Items[Index]^).Time:= aTimePoint.Time;
  TTimePoint(Items[Index]^).ThermalFlux:= aTimePoint.ThermalFlux;
  TTimePoint(Items[Index]^).ResonanceFlux:= aTimePoint.ResonanceFlux;
  TTimePoint(Items[Index]^).FastFlux:= aTimePoint.FastFlux;
  TTimePoint(Items[Index]^).Tng:= aTimePoint.Tng;
 end;
end;

procedure TTimePointList.Add(aTimePoint: TTimePoint);
var
 NewTimePoint: PTimePoint;
begin
 New(NewTimePoint);
 with NewTimePoint^ do
 begin
  Time:= aTimePoint.Time;
  ThermalFlux:= aTimePoint.ThermalFlux;
  ResonanceFlux:= aTimePoint.ResonanceFlux;
  FastFlux:= aTimePoint.FastFlux;
  Tng:= aTimePoint.Tng;
 end;
 inherited Add(NewTimePoint);
end;

destructor TTimePointList.Destroy;
var
 I: integer;
begin
 for I:= 0 to Count - 1 do
  if (Items[I] <> nil) then
   Dispose(PTimePoint(Items[I]));
 inherited Destroy;
end;

procedure TTimePointList.Order(const InCrease: Boolean);
var
 I, J: integer;
begin
 if Count < 2 then
  Exit;
 if InCrease then
  for J:= 1 to (Count - 1) do
  begin
   I:= J;
   while (Self[I].Time < Self[I - 1].Time) do
   begin
    Exchange(I, I - 1);
    if I = 1 then
     break;
    Dec(I);
   end;
  end
 else //Decrease
  for J:= 1 to (Count - 1) do
  begin
   I:= J;
   while (Self[I].Time > Self[I - 1].Time) do
   begin
    Exchange(I, I - 1);
    if I = 1 then
     break;
    Dec(I);
   end;
  end;
end;

{TSSK_Table}

procedure TSSK_Table.Add(const aConcentration, aSSK: Float);
begin
 fConcentration.Add(aConcentration);
 fSSK.Add(aSSK);
end;

constructor TSSK_Table.Create(aThZpA_s: integer);
begin
 inherited Create;
 fThZpA_s:= aThZpA_s;
 fConcentration:= TFloatList.Create;
 fSSK:= TFloatList.Create;
end;

destructor TSSK_Table.Destroy;
begin
 fConcentration.Free;
 fSSK.Free;
 inherited;
end;

function TSSK_Table.Get_Concentration(Index: integer): Float;
begin
 Result:= fConcentration[Index];
end;

function TSSK_Table.Get_SSK(Index: integer): Float;
begin
 Result:= fSSK[Index];
end;

(*
function TSSK_Table.InterpolateSSK(const aConcentration: Float): Float;
var
 i, k: integer;
 dYdX: Float;
begin
// interpolation in Orded(increase) TLists
 k:= -1;
 Result:= 1;
 try
  for i:= 0 to fConcentration.Count-2 do
   if ((aConcentration>=fConcentration[i])and(aConcentration<fConcentration[i+1])) then begin
    k:= i;
    break;
   end;
  if k<0 then begin
//extrapolation
   if aConcentration<=fConcentration[0] then begin
    dYdX:= (fSSK[1]-fSSK[0])/(fConcentration[1]-fConcentration[0]);
    Result:= fSSK[0]+(aConcentration-fConcentration[0])*dYdX;
    if Result<0 then
     Result:= fSSK[0]/2;
   end
   else if aConcentration>=fConcentration.Last then begin
    dYdX:= (fSSK[fSSK.Count-1]-y[fSSK.Count-1-1])/(fConcentration[fSSK.Count-1]-fConcentration[fSSK.Count-1-1]);
    Result:= fSSK[fSSK.Count-1]+(aConcentration-fConcentration[fSSK.Count-1])*dYdX;
    if Result>1 then
     Result:= 1.0;
   end;
  end
  else begin
// interpolation
   dYdX:= (fSSK[k+1]-fSSK[k])/(fConcentration[k+1]-fConcentration[k]);
   Result:= fSSK[k]+(aConcentration-fConcentration[k])*dYdX;
  end;
 except
  Result:= 1;
 end;
end;

function TSSK_TableList.InterpolateSSKforStateName(const aConcentration: Float;
 const aName: string): Float;
var
 I: integer;
begin
 Result:= -1;
 for I:= 0 to Count-1 do
  if (Self[I]<>nil) then
   if (TSSK_Table(Self[I]).ThZpA_s=StrToThZpA_s(aName)) then begin
    Result:= Self.InterpolateSSKforStateNo(aConcentration, I);
    break;
   end;
end;

function TSSK_TableList.InterpolateSSKforStateNo(const aConcentration: Float;
 const StateNo: integer): Float;
begin
// No Checks - for speed
 if Self[StateNo]=nil then begin
  Result:= 1;
 end
 else begin
  Result:= TSSK_Table(Self[StateNo]).InterpolateSSK(aConcentration);
 end;
end;
*)

procedure TSSK_Table.Order; //InCrease
var
 I, J: integer;
begin
// Remove Duples
 for I:= fConcentration.Count - 1 downto 0 do
  for J:= I - 1 downto 0 do
   if not (fConcentration[I] <> fConcentration[J]) then
   begin
    fConcentration.Delete(J);
    fSSK.Delete(J);
   end;
// Order InCrease
 if fConcentration.Count < 2 then
  Exit;
 for J:= 1 to (fConcentration.Count - 1) do
 begin
  I:= J;
  while (fConcentration[I] < fConcentration[I - 1]) do
  begin
   fConcentration.Exchange(I, I - 1);
   fSSK.Exchange(I, I - 1);
   if I = 1 then
    break;
   Dec(I);
  end;
 end
end;

procedure TSSK_Table.Set_Concentration(Index: integer; aConcentration: Float);
begin
 fConcentration[Index]:= aConcentration;
end;

procedure TSSK_Table.Set_SSK(Index: integer; aSSK: Float);
begin
 fSSK[Index]:= aSSK;
end;

function TSSK_Table.GetCount: integer;
begin
 Result:= fConcentration.Count;
end;

function TSSK_Table.IsOK: Boolean;
begin
 if (fConcentration.Count = fSSK.Count) then
  Result:= True
 else
 begin
  raise ERangeError.CreateFmt('TSSK_Table.IsOK: fConcentration.Count(%d) is NOT equal to fSSK.Count(%d)', [fConcentration.Count, fSSK.Count]);
  Result:= False
 end;
end;

procedure TSSK_Table.Assign(Source: TSSK_Table);
var
 I: integer;
begin
 Self.Clear;
 if Source.IsOK then
  for I:= 0 to Source.PointsNumber - 1 do
  begin
   fConcentration.Add(Source.fConcentration[I]);
   fSSK.Add(Source.fSSK[I]);
  end;
end;

procedure TSSK_Table.Clear;
begin
 fConcentration.Clear;
 fSSK.Clear;
end;

function TSSK_Table.LoadFromStream(Stream: TStream): Boolean;
var
 Buffer: PChar;
 List: TStringList;
 Txt: string;
 I, P: integer;
 aN, aSSK: Float;
begin
 Result:= False;
 fConcentration.Clear;
 fSSK.Clear;
 fThZpA_s:= 0;
 New(Buffer);
 List:= TStringList.Create;
 Txt:= '';
 try
  try
   with Stream do
    repeat
     Read(Buffer^, 1);
     Txt:= Txt + Buffer^;
    until ((Buffer^ in [EndSSK_TableChar]) or (Stream.Position + 1 >= Stream.Size));
   with List, Self do
   begin
    List.Text:= Txt;
    if List.Count < 4 then
    begin
     Exit;
    end;
    fThZpA_s:= StrToInt(Trim(List[0]));
    Txt:= '';
    for I:= 2 to List.Count - 2 do
    begin
     Txt:= List[I];
     P:= Pos(' ', Txt);
     if P > 0 then
     begin
      if ((ValEuSilent(Copy(Txt, 1, P - 1), aN)) and (ValEuSilent(Copy(Txt, P + 1, Length(Txt)), aSSK))) then
      begin
       fConcentration.Add(aN);
       fSSK.Add(aSSK);
      end
      else
       continue;
     end
     else
      continue;
    end;
   end;
  finally
   List.Free;
   Dispose(Buffer);
  end;
  Result:= True;
 except
  Result:= False;
 end;
end;

function TSSK_Table.SaveToStream(Stream: TStream): Boolean;
var
 I: integer;
 aStr: string;
begin
 try
  aStr:= BeginSSK_TableChar + ' ' + IntToStr(fThZpA_s) + EndOfLine;
  Stream.Write(Pointer(aStr)^, Length(aStr));
  aStr:= IntToStr(GetCount) + EndOfLine;
  Stream.Write(Pointer(aStr)^, Length(aStr));
  for I:= 0 to GetCount - 1 do
  begin
   aStr:= FloatToStr(fConcentration[I]) + ' ' + FloatToStr(fSSK[I]) + EndOfLine;
   Stream.Write(Pointer(aStr)^, Length(aStr));
  end;
  aStr:= EndSSK_TableChar + IntToStr(fThZpA_s) + ' end' + EndOfLine;
  Stream.Write(Pointer(aStr)^, Length(aStr));
  Result:= True
 except
  Result:= False;
 end;
end;

procedure TSSK_Table.Normalize;
var
 I: integer;
begin
 Self.Order; // N - increase ==> SSK - must decrease
 for I:= GetCount - 2 downto 0 do
  if fSSK[I] < fSSK[I + 1] then
  begin
   if (I - 1 > 0) then
   begin
    if (fSSK[I - 1] > fSSK[I + 1]) then
     fSSK[I]:= (fSSK[I + 1] + fSSK[I - 1]) / 2
    else
     fSSK[I]:= fSSK[I + 1];
   end
   else
    fSSK[I]:= fSSK[I + 1];
  end;
end;

{TSSK_TableList}

procedure TSSK_TableList.Add(const aTable: TSSK_Table);
begin
 inherited Add(aTable);
end;

procedure TSSK_TableList.Assign(Source: TSSK_TableList);
var
 I: integer;
 aSSK: TSSK_Table;
begin
 for I:= Self.Count - 1 downto 0 do
 begin
  if (Self[I] <> nil) then
   TSSK_Table(Self[I]).Free;
 end;
 Self.Clear;
 if (Source <> nil) then
 begin
  for I:= 0 to Source.Count - 1 do
  begin
   if (Source[I] <> nil) then
   begin
    aSSK:= TSSK_Table.Create(TSSK_Table(Source[I]).ThZpA_s);
    aSSK.Assign(TSSK_Table(Source[I]));
    Self.Add(aSSK);
   end
   else
    Add(nil);
  end;
 end;
end;

constructor TSSK_TableList.Create;
begin
 inherited Create;
end;

destructor TSSK_TableList.Destroy;
var
 I: integer;
begin
 for I:= Self.Count - 1 downto 0 do
  if (Self[I] <> nil) then
   TSSK_Table(Self[I]).Free;
 inherited;
end;

procedure TSSK_TableList.FreeItems;
var
 I: integer;
begin
 for I:= Count - 1 downto 0 do
  if (Self[I] <> nil) then
   TSSK_Table(Self[I]).Free;
end;

function TSSK_TableList.LoadFromFile(const FileName: string): Boolean;
var
 Stream: TStream;
begin
 Stream:= TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
 try
  Result:= LoadFromStream(Stream);
 finally
  Stream.Free;
 end;
end;

function TSSK_TableList.LoadFromStream(Stream: TStream): Boolean;
var
 aSSK_Table: TSSK_Table;
 Buffer: PChar;
begin
 New(Buffer);
 Self.FreeItems;
 Self.Clear;
 try
  with Stream do
   repeat
    Read(Buffer^, 1);
    if Buffer^ = BeginSSK_TableChar then
    begin
     Position:= Position - 1;
     aSSK_Table:= TSSK_Table.Create(0);
     if aSSK_Table.LoadFromStream(Stream) then
      Self.Add(aSSK_Table)
     else
     begin
      Result:= False;
      Exit;
     end;
    end;
   until ((Buffer^ in [EndSSK_TableListChar]) or (Stream.Position + 1 >= Stream.Size));
  Result:= True;
 except
  Result:= False;
 end;
 Dispose(Buffer);
end;

function TSSK_TableList.NotNullCount: integer;
var
 I: integer;
begin
 Result:= 0;
 for I:= 0 to Self.Count - 1 do
  if Self[I] <> nil then
   Inc(Result);
end;

function TSSK_TableList.SaveToFile(const FileName: string): Boolean;
var
 Stream: TStream;
begin
 Stream:= TFileStream.Create(FileName, fmCreate);
 try
  Result:= SaveToStream(Stream);
 finally
  Stream.Free;
 end;
end;

function TSSK_TableList.SaveToStream(Stream: TStream): Boolean;
var
 I: integer;
 aStr: string;
begin
 try
  aStr:= BeginSSK_TableListChar + ' ' + IntToStr(Self.Count) + EndOfLine;
  Stream.Write(Pointer(aStr)^, Length(aStr));
  for I:= 0 to Self.Count - 1 do
   if not (TSSK_Table(Self[I]).SaveToStream(Stream)) then
   begin
    Result:= False;
    Exit;
   end;
  aStr:= 'SSK_Table List end ' + EndSSK_TableListChar + EndOfLine;
  Stream.Write(Pointer(aStr)^, Length(aStr));
  Result:= True;
 except
  Result:= False;
 end;
end;

initialization
 ActiveCalculator:= nil;
end.

