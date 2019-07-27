unit DVODEu4cc;
// VODE: A Variable Coefficient ODE Solver
// Lawrence Livermore National Laboratory

interface
uses classes;
const
 MaxSteps=5000;
// MaxSteps=1073741823;//MaxInt div 2
 MaxNEQ=500;
// MaxArrayLength=22+9*MaxNEQ+2*MaxNEQ*MaxNEQ;
 MaxArrayLength=35+9*MaxNEQ+3*MaxNEQ*MaxNEQ;
type
 integertype=Longint;
 realtype=double;
 realarraytype=array[1..MaxArrayLength] of realtype;
 integerarraytype=array[1..MaxArrayLength] of integertype;
 TsubNoParms=procedure;
 Tdydt4vode=procedure(const NEQ: integertype;var T: realtype;
  var Y, YDOT: realtype;
  var RPAR: realtype;var IPAR: integertype) of object;
 Tdfdy4vode=procedure(const NEQ: integertype;var T: realtype;var Y: realtype;
  var ML: integertype;var MU: integertype;var PD: realtype;var NRPD: integertype;
  var RPAR: realtype;var IPAR: integertype) of object;
 TDVSTEP_VNLS_TYPE =procedure(var x1;var x2;const x3: integertype;var x4;var x5;var
  x6;var x7;var x8;var x9;x10: Tdydt4vode;x11: Tdfdy4vode;x12: pointer;
  var x13: integertype;var x14;var x15);

 TVodeSolver=class
 private
 protected
  procedure dydt(const NEQ: integertype;var T: realtype;var Y_, YDOT_: realtype;
   var RPAR_: realtype;var IPAR_: integertype);
  procedure dfdy(const NEQ: integertype;var T: realtype;var Y_: realtype;
   var ML: integertype;var MU: integertype;var PD_: realtype;var NRPD: integertype;
   var RPAR: realtype;var IPAR: integertype);
 public
  constructor Create;
 end;

 TTestVodeSolver=class(TVodeSolver)
 private
 public
  procedure dydt(const NEQ: integertype;var T: realtype;var Y_, YDOT_: realtype;
   var RPAR_: realtype;var IPAR_: integertype);
  procedure dfdy(const NEQ: integertype;var T: realtype;var Y_: realtype;
   var ML: integertype;var MU: integertype;var PD_: realtype;var NRPD: integertype;
   var RPAR: realtype;var IPAR: integertype);
 end;
// procedure TestDVODE;
procedure DVODE(
 F_: Tdydt4vode;
 const NEQ: integertype{constant};
 var Y_;
 var T: realtype;
 var TOUT: realtype{constant};
 var ITOL: integertype{constant};
 var RTOL_;
 var ATOL_;
 var ITASK: integertype{constant};
 var ISTATE: integertype;
 var IOPT: integertype{constant};
 var RWORK_:realtype;
 var LRW: integertype{constant};
 var IWORK_:integertype;
 var LIW: integertype{constant};
 JAC_: Tdfdy4vode;
 var MF: integertype{constant};
 var RPAR_:realtype;
 var IPAR_:integertype);
//qqqq test
var
 StdOut: TStringList;
 I_TEST: integer;
 Y_TEST: realtype;
 AbortVODE: Boolean;

implementation
uses math, Sysutils, Windows, Dialogs, Forms;
type{records for common blocks}
 COMMON_DVOD01_=record
  ACNRM: realtype;{1}
  CCMXJ: realtype;{9}
  CONP: realtype;{17}
  CRATE: realtype;{25}
  DRC: realtype;{33}
  EL: array[1..13] of realtype;{41}
  ETA: realtype;{145}
  ETAMAX: realtype;{153}
  H: realtype;{161}
  HMIN: realtype;{169}
  HMXI: realtype;{177}
  HNEW: realtype;{185}
  HSCAL: realtype;{193}
  PRL1: realtype;{201}
  RC: realtype;{209}
  RL1: realtype;{217}
  TAU: array[1..13] of realtype;{225}
  TQ: array[1..5] of realtype;{329}
  TN: realtype;{369}
  UROUND: realtype;{377}
  ICF: integertype;{385}
  INIT: integertype;{389}
  IPUP: integertype;{393}
  JCUR: integertype;{397}
  JSTART: integertype;{401}
  JSV: integertype;{405}
  KFLAG: integertype;{409}
  KUTH: integertype;{413}
  L: integertype;{417}
  LMAX: integertype;{421}
  LYH: integertype;{425}
  LEWT: integertype;{429}
  LACOR: integertype;{433}
  LSAVF: integertype;{437}
  LWM: integertype;{441}
  LIWM: integertype;{445}
// qq not translated
  LOCJS: integertype;{449}
  MAXORD: integertype;{453}
  METH: integertype;{457}
  MITER: integertype;{461}
  MSBJ: integertype;{465}
  MXHNIL: integertype;{469}
  MXSTEP: integertype;{473}
  N: integertype;{477}
  NEWH: integertype;{481}
  NEWQ: integertype;{485}
  NHNIL: integertype;{489}
  NQ: integertype;{493}
  NQNYH: integertype;{497}
  NQWAIT: integertype;{501}
  NSLJ: integertype;{505}
  NSLP: integertype;{509}
  NYH: integertype;{513}
 end;
 COMMON_DVOD02_=record
  HU: realtype;{1}
  NCFN: integertype;{9}
  NETF: integertype;{13}
  NFE: integertype;{17}
  NJE: integertype;{21}
  NLU: integertype;{25}
  NNI: integertype;{29}
  NQU: integertype;{33}
  NST: integertype;{37}
 end;
 
var
{Warning: size of integer: 4, real:  8!}
 COMMON_DVOD01: array[1..517] of byte;
 COMMON_DVOD02: array[1..40] of byte;
procedure TTestVodeSolver.dfdy(const NEQ: integertype;var T: realtype;var Y_: realtype;
 var ML: integertype;var MU: integertype;var PD_: realtype;var NRPD: integertype;
 var RPAR: realtype;var IPAR: integertype);
var
 PD: realarraytype absolute PD_;
 Y: realarraytype absolute Y_;
 function PDind(const I1, I2: integertype): integertype;
 begin
  Result:= (I2-1)*NEQ+I1;
 end;
begin
 PD[PDind(1, 1)]:= -0.04;
 PD[PDind(1, 2)]:= 1.E4*Y[3];
 PD[PDind(1, 3)]:= 1.E4*Y[2];
 PD[PDind(2, 1)]:= 0.04;
 PD[PDind(2, 3)]:= -PD[PDind(1, 3)];
 PD[PDind(3, 2)]:= 6.E7*Y[2];
 PD[PDind(2, 2)]:= -PD[PDind(1, 2)]-PD[PDind(3, 2)];
//C     PD(1,1) = -.04D0
//C     PD(1,2) = 1.D4*Y(3)
//C     PD(1,3) = 1.D4*Y(2)
//C     PD(2,1) = .04D0
//C     PD(2,3) = -PD(1,3)
//C     PD(3,2) = 6.D7*Y(2)
//C     PD(2,2) = -PD(1,2) - PD(3,2)
end;

procedure TTestVodeSolver.dydt(const NEQ: integertype;var T, Y_, YDOT_,
 RPAR_: realtype;var IPAR_: integertype);
var
 Y: realarraytype absolute Y_;
 YDOT: realarraytype absolute YDOT_;
 RFAR: realarraytype absolute RPAR_;
 IPAR: integerarraytype absolute IPAR_;
begin
 I_TEST:= Floor(YDOT[1]);
 YDOT[1]:= -0.04*Y[1]+1.E4*Y[2]*Y[3];
 YDOT[3]:= 3.E7*Y[2]*Y[2];
 YDOT[2]:= -1.0*YDOT[1]-1.0*YDOT[3];
//C     YDOT(1) = -.04D0*Y(1) + 1.D4*Y(2)*Y(3)
//C     YDOT(3) = 3.D7*Y(2)*Y(2)
//C     YDOT(2) = -YDOT(1) - YDOT(3)
end;

function RE_(const RR: integertype): realtype;
begin
 Result:= 1.0*RR;
end;
function max0(x1, x2: integertype): integertype;
begin
 if x1>=x2 then
  max0:= x1
 else
  max0:= x2;
end;
function min0(x1, x2: integertype): integertype;
begin
 if x1>=x2 then
  min0:= x2
 else
  min0:= x1;
end;

function rrpowr(x1, x2: realtype): realtype;
begin
 if x2=0 then begin rrpowr:= 1;
  exit;
 end;
 if (X1=0)and(X2>0) then rrpowr:= 0 else rrpowr:= exp(ln(x1)*x2);
end;
function ripowr(x1: realtype;x2: integertype): realtype;
var
 x: realtype;
 i, j: integertype;
begin
 if x2=0 then begin ripowr:= 1;
  exit;
 end;
 i:= abs(x2);
 x:= x1;
 for j:= 1 to i-1 do x:= x*x1;
 if x2>=0 then ripowr:= x else ripowr:= 1/x;
end;
function SIGN(const A, B: integertype): integertype; overload;
begin
 if B>=0 then
  Result:= A
 else
  Result:= -A;
end;

function SIGN(const A: integertype;B: realtype): integertype; overload;
begin
 if B>=0 then
  Result:= A
 else
  Result:= -A;
end;

function SIGN(const A, B: realtype): realtype; overload;
begin
 if B>=0 then
  Result:= A
 else
  Result:= -A;
end;
{========== Conversion of DVODE.FOR ==========}
// {$B-}{$F+ Far Calls }{$I-}{$N+ 8087 }{$R-}{$V-}{compiler options}
{$BOOLEVAL OFF}
{$IOCHECKS OFF}
{$RANGECHECKS OFF}
{$VARSTRINGCHECKS OFF}
{$ALIGN OFF}// Eu
//Convertion
{*DECK D1MACH}
function D1MACH(
 const IDUM: integertype{constant}): realtype;
{---------- Local variables ----------}
var
 COMP, U: realtype;
label
 10;
{========== Body of converted D1MACH.FOR ==========}
begin
{C-----------------------------------------------------------------------}
{C This routine computes the unit roundoff of the machine.}
 U:= 1.0E0;
 10: U:= U*0.5E0;
 COMP:= 1.0E0+U;
 if (COMP<>1.0E0) then goto 10;
 Result:= U*2.0E0;
 EXIT;
end;
{========== Conversion of DCOPY.FOR ==========}
procedure DCOPY(
{Warning: Check up parameters: VAR or not}
 const N: integertype{constant};
 var DX_;
 const INCX: integertype{constant};
 var DY_;
 const INCY: integertype{constant});
{---------- Local variables ----------}
var
 DX: realarraytype absolute DX_{ [1*(*-1+1);] elements };
 DY: realarraytype absolute DY_{ [1*(*-1+1);] elements };
 I, IX, IY, M, MP1: integertype;
label
 20, 40;
{========== Body of converted DCOPY.FOR ==========}
begin
{c}
{c    copies a vector, x, to a vector, y.}
 if (N<=0) then EXIT;
 if (INCX=1)and(INCY=1) then goto 20;
{c}
{c       code for unequal increments or equal increments}
{c         not equal to 1}
{c}
 IX:= 1;
 IY:= 1;
 if (INCX<0) then IX:= (-N+1)*INCX+1;
 if (INCY<0) then IY:= (-N+1)*INCY+1;
 for I:= 1 to N do {10}
 begin
  DY[IY]:= DX[IX];
  IX:= IX+INCX;
  IY:= IY+INCY;
 end;{10}
 EXIT;
 20: M:= ((N)mod(7));
 if (M=0) then goto 40;
 for I:= 1 to M do DY[I]:= DX[I];
 if (N<7) then EXIT;
 40: MP1:= M+1;
 I:= MP1;
 while ((I>=MP1)and(I<=N))or((I>=N)and(I<=MP1)) do {50}
 begin
  DY[I]:= DX[I];
  DY[I+1]:= DX[I+1];
  DY[I+2]:= DX[I+2];
  DY[I+3]:= DX[I+3];
  DY[I+4]:= DX[I+4];
  DY[I+5]:= DX[I+5];
  DY[I+6]:= DX[I+6];
  I:= I+7;
 end;{50}
 EXIT;
end;
{========== Conversion of DEWSET.FOR ==========}
{*DECK DEWSET}
procedure DEWSET(
 const N: integertype{constant};
 const ITOL: integertype{constant};
 var RTOL_;
 var ATOL_;
 var YCUR_;
 var EWT_);
var
 RTOL: realarraytype absolute RTOL_{ [1*(*-1+1);] elements };
 ATOL: realarraytype absolute ATOL_{ [1*(*-1+1);] elements };
 YCUR: realarraytype absolute YCUR_{ [N] elements };
 EWT: realarraytype absolute EWT_{ [N] elements };
 I: integertype;
label
 10, 20, 30, 40;
begin
{C This subroutine sets the error weight vector EWT according to ITOL}
{C    EWT(i) = RTOL(i)*abs(YCUR(i)) + ATOL(i),  i = 1,...,N,}
 if ITOL=1 then goto 10;// Same For all
 if ITOL=2 then goto 20;
 if ITOL=3 then goto 30;
 if ITOL=4 then goto 40;
 10: {CONTINUE};
 for I:= 1 to N do EWT[I]:= RTOL[1]*ABS(YCUR[I])+ATOL[1];
 EXIT;
 20: {CONTINUE};
 for I:= 1 to N do EWT[I]:= RTOL[1]*ABS(YCUR[I])+ATOL[I];
 EXIT;
 30: {CONTINUE};
 for I:= 1 to N do EWT[I]:= RTOL[I]*ABS(YCUR[I])+ATOL[1];
 EXIT;
 40: {CONTINUE};
 for I:= 1 to N do EWT[I]:= RTOL[I]*ABS(YCUR[I])+ATOL[I];
 EXIT;
{C----------------------- End of Subroutine DEWSET ----------------------}
end;

procedure DSCAL(
 const N: integertype{constant};
 const DA: realtype{constant};
 var DX_;
 const INCX: integertype{constant});
var
 DX: realarraytype absolute DX_{ [1] elements };
 I, M, MP1, NINCX: integertype;
label
 20, 40;
begin
{c    scales a vector by a constant.}
 if (N<=0) then EXIT;
 if (INCX=1) then goto 20;
 NINCX:= N*INCX;
 I:= 1;
 while ((I>=1)and(I<=NINCX))or((I>=NINCX)and(I<=1)) do {10}
 begin
  DX[I]:= DA*DX[I];
  I:= I+INCX;
 end;{10}
 EXIT;
{c       clean-up loop}
 20: M:= ((N)mod(5));
 if (M=0) then goto 40;
 for I:= 1 to M do DX[I]:= DA*DX[I];
 if (N<5) then EXIT;
 40: MP1:= M+1;
 I:= MP1;
 while ((I>=MP1)and(I<=N))or((I>=N)and(I<=MP1)) do {50}
 begin
  DX[I]:= DA*DX[I];
  DX[I+1]:= DA*DX[I+1];
  DX[I+2]:= DA*DX[I+2];
  DX[I+3]:= DA*DX[I+3];
  DX[I+4]:= DA*DX[I+4];
  I:= I+5;
 end;{50}
 EXIT;
end;

function DVNORM(
 const N: integertype{constant};
 var V_;
 var W_): realtype;
var
 V: realarraytype absolute V_{ [N] elements };
 W: realarraytype absolute W_{ [N] elements };
 I: integertype;
 SUM: realtype;
begin
{C This function routine computes the weighted root-mean-square norm}
{C of the vector of length N contained in the array V, with weights}
{C contained in the array W of length N..}
{C  DVNORM = sqrt( (1/N) * sum( V(i)*W(i) )**2 )}
 SUM:= 0.0E0;
 for I:= 1 to N do SUM:= SUM+sqr((V[I]*W[I]));
 DVNORM:= SQRT(SUM/RE_(N));
 EXIT;
end;

procedure DVHIN(
 const N: integertype{constant};
 const T0: realtype{constant};
 var Y0_;
 var YDOT_;
 F_: Tdydt4vode;
 var RPAR_;
 var IPAR_;
 const TOUT: realtype{constant};
 const UROUND: realtype{constant};
 var EWT_;
 const ITOL: integertype{constant};
 var ATOL_;
 var Y_;
 var TEMP_;
 var H0: realtype;
 var NITER: integertype;
 var IER: integertype);
const
 HALF: realtype=0.5;
 HUN: realtype=100.;
 PT1: realtype=0.1;
 TWO: realtype=2.0;
type
 DVHIN_F_TYPE=procedure(var x1: integertype;var x2: realtype;var x3;var x4;
  var x5;var x6);
{---------- Local variables ----------}
var
 Y0: realarraytype absolute Y0_{ [1*(*-1+1);] elements };
 YDOT: realarraytype absolute YDOT_{ [1*(*-1+1);] elements };
 RPAR: realarraytype absolute RPAR_{ [1*(*-1+1);] elements };
 IPAR: integerarraytype absolute IPAR_{ [1*(*-1+1);] elements };
 EWT: realarraytype absolute EWT_{ [1*(*-1+1);] elements };
 ATOL: realarraytype absolute ATOL_{ [1*(*-1+1);] elements };
 Y: realarraytype absolute Y_{ [1*(*-1+1);] elements };
 TEMP: realarraytype absolute TEMP_{ [1*(*-1+1);] elements };
 AFI, ATOLI, DELYI, H, HG, HLB, HNEW, HRAT, HUB, T1, TDIST, TROUND,
  YDDNRM: realtype;
 I, ITER: integertype;
 F: Tdydt4vode;
label
 50, 80, 90, 100;
{========== Body of converted DVHIN.FOR ==========}
begin
 F:= F_;
{C This routine computes the step size, H0, to be attempted on the}
{C first step, when the user has not supplied a value for this.}
 NITER:= 0;
 TDIST:= ABS(TOUT-T0);
 TROUND:= UROUND*MAX(ABS(T0), ABS(TOUT));
 if (TDIST<TWO*TROUND) then goto 100;
 HLB:= HUN*TROUND;
 HUB:= PT1*TDIST;
 ATOLI:= ATOL[1];
 for I:= 1 to N do {10}
 begin
  if (ITOL=2)or(ITOL=4) then
  begin
   ATOLI:= ATOL[I];
  end;
  DELYI:= PT1*ABS(Y0[I])+ATOLI;
  AFI:= ABS(YDOT[I]);
  if (AFI*HUB>DELYI) then HUB:= DELYI/AFI;
 end;{10}
 ITER:= 0;
 HG:= SQRT(HLB*HUB);
 if (HUB<HLB) then
 begin
  H0:= HG;
  goto 90;
 end;
 50: {CONTINUE};
 H:= SIGN(HG, TOUT-T0);
 T1:= T0+H;
 for I:= 1 to N do Y[I]:= Y0[I]+H*YDOT[I];
 F(N, T1, Y[1], TEMP[1], RPAR[1], IPAR[1]);
 for I:= 1 to N do TEMP[I]:= (TEMP[I]-YDOT[I])/H;
 YDDNRM:= DVNORM(N, TEMP, EWT);
 if (YDDNRM*HUB*HUB>TWO) then HNEW:= SQRT(TWO/YDDNRM)
 else
 begin
  HNEW:= SQRT(HG*HUB);
 end;
 ITER:= ITER+1;
 if (ITER>=4) then goto 80;
 HRAT:= HNEW/HG;
 if ((HRAT>HALF))and((HRAT<TWO)) then goto 80;
 if ((ITER>=2))and((HNEW>TWO*HG)) then
 begin
  HNEW:= HG;
  goto 80;
 end;
 HG:= HNEW;
 goto 50;
 80: H0:= HNEW*HALF;
 if (H0<HLB) then H0:= HLB;
 if (H0>HUB) then H0:= HUB;
 90: H0:= SIGN(H0, TOUT-T0);
 NITER:= ITER;
 IER:= 0;
 EXIT;
{C Error return for TOUT - T0 too small. --------------------------------}
 100: IER:= -1;
 EXIT;
end;
procedure DAXPY(
 const N: integertype{constant};
 const DA: realtype{constant};
 var DX_;
 const INCX: integertype{constant};
 var DY_;
 const INCY: integertype{constant});
var
 DX: realarraytype absolute DX_{ [1] elements };
 DY: realarraytype absolute DY_{ [1] elements };
 I, IX, IY, M, MP1: integertype;
label
 20, 40;
begin
{c    constant times a vector plus a vector.}
 if (N<=0) then EXIT;
 if (DA=0.0E0) then EXIT;
 if (INCX=1)and(INCY=1) then goto 20;
 IX:= 1;
 IY:= 1;
 if (INCX<0) then IX:= (-N+1)*INCX+1;
 if (INCY<0) then IY:= (-N+1)*INCY+1;
 for I:= 1 to N do {10}
 begin
  DY[IY]:= DY[IY]+DA*DX[IX];
  IX:= IX+INCX;
  IY:= IY+INCY;
 end;{10}
 EXIT;
{c       clean-up loop}
 20: M:= ((N)mod(4));
 if (M=0) then goto 40;
 for I:= 1 to M do DY[I]:= DY[I]+DA*DX[I];
 if (N<4) then EXIT;
 40: MP1:= M+1;
 I:= MP1;
 while ((I>=MP1)and(I<=N))or((I>=N)and(I<=MP1)) do {50}
 begin
  DY[I]:= DY[I]+DA*DX[I];
  DY[I+1]:= DY[I+1]+DA*DX[I+1];
  DY[I+2]:= DY[I+2]+DA*DX[I+2];
  DY[I+3]:= DY[I+3]+DA*DX[I+3];
  I:= I+4;
 end;{50}
 EXIT;
end;
procedure DVJUST(
 var YH_;
 const LDYH: integertype{constant};
 const IORD: integertype{constant});
const
 ONE: realtype=1.0;
 ZERO: realtype=0.0;
var
 DVOD01: COMMON_DVOD01_ absolute COMMON_DVOD01;
 YH: realarraytype absolute YH_{ [1*(LDYH-1+1)*(*-1+1);] elements };
 ALPH0, ALPH1, HSUM, PROD, T1, XI, XIOLD: realtype;
 I, IBACK, J, JP1, LP1,
  NQM1, NQM2, NQP1: integertype;
label
 100, 180, 200, 300, 340;
{Index of element of YH(LDYH,*)}
 function YHind(I1, I2: integertype): integertype;
 begin
  YHind:= (I2-1)*LDYH+I1;
 end;
begin
 with DVOD01 do {with common blocks}
 begin
{C This subroutine adjusts the YH array on reduction of order,}
{C and also when the order is increased for the stiff option (METH = 2).}
  if ((NQ=2))and((IORD<>1)) then EXIT;
  NQM1:= NQ-1;
  NQM2:= NQ-2;
  if METH=1 then goto 100;
  if METH=2 then goto 200;
{C Nonstiff option...}
  100: {CONTINUE};
  if (IORD=1) then goto 180;
  for J:= 1 to LMAX do EL[J]:= ZERO;
  EL[2]:= ONE;
  HSUM:= ZERO;
  for J:= 1 to NQM2 do {130}
  begin
   HSUM:= HSUM+TAU[J];
   XI:= HSUM/HSCAL;
   JP1:= J+1;
   for IBACK:= 1 to JP1 do {120}
   begin
    I:= (J+3)-IBACK;
    EL[I]:= EL[I]*XI+EL[I-1];
   end;{120}
  end;{130}
  for J:= 2 to NQM1 do EL[J+1]:= RE_(NQ)*EL[J]/RE_(J);
  for J:= 3 to NQ do {170}
  begin
   for I:= 1 to N do {160}
   begin
    YH[YHind(I, J)]:= YH[YHind(I, J)]-YH[YHind(I, L)]*EL[J];
   end;{160}
  end;{170}
  EXIT;
  180: {CONTINUE};
  LP1:= L+1;
  for I:= 1 to N do YH[YHind(I, LP1)]:= ZERO;
  EXIT;
{C Stiff option...}
  200: {CONTINUE};
  if (IORD=1) then goto 300;
  for J:= 1 to LMAX do EL[J]:= ZERO;
  EL[3]:= ONE;
  HSUM:= ZERO;
  for J:= 1 to NQM2 do {230}
  begin
   HSUM:= HSUM+TAU[J];
   XI:= HSUM/HSCAL;
   JP1:= J+1;
   for IBACK:= 1 to JP1 do {220}
   begin
    I:= (J+4)-IBACK;
    EL[I]:= EL[I]*XI+EL[I-1];
   end;{220}
  end;{230}
  for J:= 3 to NQ do {250}
  begin
   for I:= 1 to N do {240}
   begin
    YH[YHind(I, J)]:= YH[YHind(I, J)]-YH[YHind(I, L)]*EL[J];
   end;{240}
  end;{250}
  EXIT;
  300: for J:= 1 to LMAX do EL[J]:= ZERO;
  EL[3]:= ONE;
  ALPH0:= -ONE;
  ALPH1:= ONE;
  PROD:= ONE;
  XIOLD:= ONE;
  HSUM:= HSCAL;
  if (NQ=1) then goto 340;
  for J:= 1 to NQM1 do {330}
  begin
   JP1:= J+1;
   HSUM:= HSUM+TAU[JP1];
   XI:= HSUM/HSCAL;
   PROD:= PROD*XI;
   ALPH0:= ALPH0-ONE/RE_(JP1);
   ALPH1:= ALPH1+ONE/XI;
   for IBACK:= 1 to JP1 do {320}
   begin
    I:= (J+4)-IBACK;
    EL[I]:= EL[I]*XIOLD+EL[I-1];
   end;{320}
   XIOLD:= XI;
  end;{330}
  340: {CONTINUE};
  T1:= (-ALPH0-ALPH1)/PROD;
  LP1:= L+1;
  for I:= 1 to N do YH[YHind(I, LP1)]:= T1*YH[YHind(I, LMAX)];
  NQP1:= NQ+1;
  FOR J:=3 TO NQP1 DO DAXPY(N,EL[J],YH[YHind(1,LP1)],1   ,YH[YHind(1,J)],    1);
  EXIT;
 end;{with common blocks do}
end;
procedure DVSET;
const
 CORTES: realtype=0.1E0;
 ONE: realtype=1.0;
 SIX: realtype=6.0;
 TWO: realtype=2.0;
 ZERO: realtype=0.0;
var
 DVOD01: COMMON_DVOD01_ absolute COMMON_DVOD01;
 AHATN0, ALPH0, CNQM1, CSUM, ELP, EM0, FLOTI, FLOTL, FLOTNQ, HSUM, RXI, RXIS,
  S, T1, T2, T3, T4, T5, T6, XI: realtype;
 EM: array[1..13] of realtype;
 I, IBACK, J, JP1,
  NQM1, NQM2: integertype;
label
 100, 110, 130, 200, 240, 300;
begin
 with DVOD01 do {with common blocks}
 begin
{C DVSET is called by DVSTEP and sets coefficients for use there.}
  FLOTL:= RE_(L);
  NQM1:= NQ-1;
  NQM2:= NQ-2;
  if METH=1 then goto 100;
  if METH=2 then goto 200;
  100: if (NQ<>1) then goto 110;
  EL[1]:= ONE;
  EL[2]:= ONE;
  TQ[1]:= ONE;
  TQ[2]:= TWO;
  TQ[3]:= SIX*TQ[2];
  TQ[5]:= ONE;
  goto 300;
  110: HSUM:= H;
  EM[1]:= ONE;
  FLOTNQ:= FLOTL-ONE;
  for I:= 2 to L do EM[I]:= ZERO;
  for J:= 1 to NQM1 do {150}
  begin
   if ((J<>NQM1))or((NQWAIT<>1)) then
   begin
    goto 130;
   end;
   S:= ONE;
   CSUM:= ZERO;
   for I:= 1 to NQM1 do {120}
   begin
    CSUM:= CSUM+S*EM[I]/RE_(I+1);
    S:= -S;
   end;{120}
   TQ[1]:= EM[NQM1]/(FLOTNQ*CSUM);
   130: RXI:= H/HSUM;
   for IBACK:= 1 to J do {140}
   begin
    I:= (J+2)-IBACK;
    EM[I]:= EM[I]+EM[I-1]*RXI;
   end;{140}
   HSUM:= HSUM+TAU[J];
  end;{150}
  S:= ONE;
  EM0:= ZERO;
  CSUM:= ZERO;
  for I:= 1 to NQ do {160}
  begin
   FLOTI:= RE_(I);
   EM0:= EM0+S*EM[I]/FLOTI;
   CSUM:= CSUM+S*EM[I]/(FLOTI+ONE);
   S:= -S;
  end;{160}
  S:= ONE/EM0;
  EL[1]:= ONE;
  for I:= 1 to NQ do EL[I+1]:= S*EM[I]/RE_(I);
  XI:= HSUM/H;
  TQ[2]:= XI*EM0/CSUM;
  TQ[5]:= XI/EL[L];
  if (NQWAIT<>1) then goto 300;
  RXI:= ONE/XI;
  for IBACK:= 1 to NQ do {180}
  begin
   I:= (L+1)-IBACK;
   EM[I]:= EM[I]+EM[I-1]*RXI;
  end;{180}
  S:= ONE;
  CSUM:= ZERO;
  for I:= 1 to L do {190}
  begin
   CSUM:= CSUM+S*EM[I]/RE_(I+1);
   S:= -S;
  end;{190}
  TQ[3]:= FLOTL*EM0/CSUM;
  goto 300;
  200: for I:= 3 to L do EL[I]:= ZERO;
  EL[1]:= ONE;
  EL[2]:= ONE;
  ALPH0:= -ONE;
  AHATN0:= -ONE;
  HSUM:= H;
  RXI:= ONE;
  RXIS:= ONE;
  if (NQ=1) then goto 240;
  for J:= 1 to NQM2 do {230}
  begin
   HSUM:= HSUM+TAU[J];
   RXI:= H/HSUM;
   JP1:= J+1;
   ALPH0:= ALPH0-ONE/RE_(JP1);
   for IBACK:= 1 to JP1 do {220}
   begin
    I:= (J+3)-IBACK;
    EL[I]:= EL[I]+EL[I-1]*RXI;
   end;{220}
  end;{230}
  ALPH0:= ALPH0-ONE/RE_(NQ);
  RXIS:= -EL[2]-ALPH0;
  HSUM:= HSUM+TAU[NQM1];
  RXI:= H/HSUM;
  AHATN0:= -EL[2]-RXI;
  for IBACK:= 1 to NQ do {235}
  begin
   I:= (NQ+2)-IBACK;
   EL[I]:= EL[I]+EL[I-1]*RXIS;
  end;{235}
  240: T1:= ONE-AHATN0+ALPH0;
  T2:= ONE+RE_(NQ)*T1;
  TQ[2]:= ABS(ALPH0*T2/T1);
  TQ[5]:= ABS(T2/(EL[L]*RXI/RXIS));
  if (NQWAIT<>1) then goto 300;
  CNQM1:= RXIS/EL[L];
  T3:= ALPH0+ONE/RE_(NQ);
  T4:= AHATN0+RXI;
  ELP:= T3/(ONE-T4+T3);
  TQ[1]:= ABS(ELP/CNQM1);
  HSUM:= HSUM+TAU[NQ];
  RXI:= H/HSUM;
  T5:= ALPH0-ONE/RE_(NQ+1);
  T6:= AHATN0-RXI;
  ELP:= T2/(ONE-T6+T5);
  TQ[3]:= ABS(ELP*RXI*(FLOTL+ONE)*T5);
  300: TQ[4]:= CORTES*TQ[2];
  EXIT;
 end;{with common blocks do}
end;
procedure DVSTEP(
 var Y_:realtype;
 var YH_:realtype;
 const LDYH: integertype{constant};
 var YH1_:realtype;
 var EWT_:realtype;
 var SAVF_:realtype;
 var VSAV_:realtype;
 var ACOR_:realtype;
 var WM_:realtype;
 var IWM_:integertype;
 F_: Tdydt4vode;
 JAC_: Tdfdy4vode;
 PSOL: Tdydt4vode;
 VNLS_: TDVSTEP_VNLS_TYPE;
 var RPAR_:realtype;
 var IPAR_:integertype);
const
 ADDON: realtype=1.0E-6;
 BIAS1: realtype=6.0;
 BIAS2: realtype=6.0;
 BIAS3: realtype=10.0;
 ETACF: realtype=0.25;
 ETAMIN: realtype=0.1;
 ETAMX1: realtype=1.0E4;
 ETAMX2: realtype=10.0;
 ETAMX3: realtype=10.0;
 ETAMXF: realtype=0.2;
 ETAQ: realtype=0.0;
 ETAQM1: realtype=0.0;
 KFC: integertype=-3;
 KFH: integertype=-7;
 MXNCF: integertype=10;
 ONEPSM: realtype=1.00001;
 THRESH: realtype=1.5;
 ONE: realtype=1.0;
 ZERO: realtype=0.0;
var
 DVOD01: COMMON_DVOD01_ absolute COMMON_DVOD01;
 DVOD02: COMMON_DVOD02_ absolute COMMON_DVOD02;
 Y: realarraytype absolute Y_{ [1*(*-1+1);] elements };
 YH: realarraytype absolute YH_{ [1*(LDYH-1+1)*(*-1+1);] elements };
 YH1: realarraytype absolute YH1_{ [1*(*-1+1);] elements };
 EWT: realarraytype absolute EWT_{ [1*(*-1+1);] elements };
 SAVF: realarraytype absolute SAVF_{ [1*(*-1+1);] elements };
 VSAV: realarraytype absolute VSAV_{ [1*(*-1+1);] elements };
 ACOR: realarraytype absolute ACOR_{ [1*(*-1+1);] elements };
 WM: realarraytype absolute WM_{ [1*(*-1+1);] elements };
 IWM: integerarraytype absolute IWM_{ [1*(*-1+1);] elements };
 RPAR: realarraytype absolute RPAR_{ [1*(*-1+1);] elements };
 IPAR: integerarraytype absolute IPAR_{ [1*(*-1+1);] elements };
 CNQUOT, DDN, DSM, DUP,
  ETAQP1, FLOTL, R, TOLD: realtype;
 I, I1, I2, IBACK, J, JB,
  NCF, NFLAG: integertype;
 F: Tdydt4vode;
 JAC: Tdfdy4vode;
 VNLS: TDVSTEP_VNLS_TYPE;
//qq
 TmpI1, TmpI2: integertype;
label
 20, 50, 100, 120, 140, 150, 200, 450, 490, 500, 530, 540, 560, 570, 580, 590, 600, 610, 620,
  630, 640, 660, 670, 680, 690, 720;
{Index of element of YH(LDYH,*)}
 function YHind(I1, I2: integertype): integertype;
 begin
  YHind:= (I2-1)*LDYH+I1;
 end;
begin
 with DVOD01 do with DVOD02 do {with common blocks}
  begin
// AddEu2
   Application.ProcessMessages;
   if AbortVODE then exit;
//qqqqq
   F:= F_;
   JAC:= JAC_;
   VNLS:= VNLS_;
   PSOL:= nil;// Dummy name...
{C DVSTEP performs one step of the integration of an initial value}
{C problem for a system of ordinary differential equations.}
{C DVSTEP calls subroutine VNLS for the solution of the nonlinear system}
{C arising in the time step.  Thus it is independent of the problem}
{C Jacobian structure and the type of nonlinear system solution method.}
{C DVSTEP returns a completion flag KFLAG (in COMMON).}
{C A return with KFLAG = -1 or -2 means either ABS(H) = HMIN or 10}
{C consecutive failures occurred.  On a return with KFLAG negative,}
{C the values of TN and the YH array are as of the beginning of the last}
{C step, and H is the last step size attempted.}
{C PSOL   = Dummy name for the subroutine passed to VNLS, for}
{C         possible use there.}
   KFLAG:= 0;
   TOLD:= TN;
   NCF:= 0;
   JCUR:= 0;
   NFLAG:= 0;
   if (JSTART>0) then goto 20;
   if (JSTART=-1) then goto 100;
   LMAX:= MAXORD+1;
   NQ:= 1;
   L:= 2;
   NQNYH:= NQ*LDYH;
   TAU[1]:= H;
   PRL1:= ONE;
   RC:= ZERO;
   ETAMAX:= ETAMX1;
   NQWAIT:= 2;
   HSCAL:= H;
   goto 200;
   20: {CONTINUE};
   if (KUTH=1) then
   begin
    ETA:= MIN(ETA, H/HSCAL);
    NEWH:= 1;
   end;
   50: if (NEWH=0) then goto 200;
   if (NEWQ=NQ) then goto 150;
   if (NEWQ<NQ) then
   begin
    DVJUST(YH,LDYH,  -1);
    NQ:= NEWQ;
    L:= NQ+1;
    NQWAIT:= L;
    goto 150;
   end;
   if (NEWQ>NQ) then
   begin
    DVJUST(YH,LDYH,    1);
    NQ:= NEWQ;
    L:= NQ+1;
    NQWAIT:= L;
    goto 150;
   end;
   100: {CONTINUE};
   LMAX:= MAXORD+1;
   if (N=LDYH) then goto 120;
   I1:= 1+(NEWQ+1)*LDYH;
   I2:= (MAXORD+1)*LDYH;
   if (I1>I2) then goto 120;
   for I:= I1 to I2 do YH1[I]:= ZERO;
   120: if (NEWQ<=MAXORD) then goto 140;
   FLOTL:= RE_(LMAX);
   if (MAXORD<NQ-1) then
   begin
    DDN:= DVNORM(N, SAVF, EWT)/TQ[1];
    ETA:= ONE/(rrpowr((BIAS1*DDN), (ONE/FLOTL))+ADDON);
   end;
   if (MAXORD=NQ)and(NEWQ=NQ+1) then ETA:= ETAQ;
   if (MAXORD=NQ-1)and(NEWQ=NQ+1) then
   begin
    ETA:= ETAQM1;
    DVJUST(YH,LDYH,  -1);
   end;
   if (MAXORD=NQ-1)and(NEWQ=NQ) then
   begin
    DDN:= DVNORM(N, SAVF, EWT)/TQ[1];
    ETA:= ONE/(rrpowr((BIAS1*DDN), (ONE/FLOTL))+ADDON);
    DVJUST(YH,LDYH,  -1);
   end;
   ETA:= MIN(ETA, ONE);
   NQ:= MAXORD;
   L:= LMAX;
   140: if (KUTH=1) then ETA:= MIN(ETA, ABS(H/HSCAL));
   if (KUTH=0) then ETA:= MAX(ETA, HMIN/ABS(HSCAL));
   ETA:= ETA/MAX(ONE, ABS(HSCAL)*HMXI*ETA);
   NEWH:= 1;
   NQWAIT:= L;
   if (NEWQ<=MAXORD) then goto 50;
   150: R:= ONE;
   for J:= 2 to L do {180}
   begin
    R:= R*ETA;
    DSCAL(N,R,YH[YHind(1,J)],   1);
   end;{180}
   H:= HSCAL*ETA;
   HSCAL:= H;
   RC:= RC*ETA;
   NQNYH:= NQ*LDYH;
   200: TN:= TN+H;
   I1:= NQNYH+1;
   for JB:= 1 to NQ do {220}
   begin
    I1:= I1-LDYH;
    for I:= I1 to NQNYH do {210}
    begin
     YH1[I]:= YH1[I]+YH1[I+LDYH];
    end;{210}
   end;{220}
   DVSET;
   RL1:= ONE/EL[2];
   RC:= RC*(RL1/PRL1);
   PRL1:= RL1;

   VNLS(Y, YH, LDYH, VSAV, SAVF, EWT, ACOR, IWM, WM, F, JAC, @PSOL, NFLAG, RPAR, IPAR);
//qqqq
//    VNLS(Y, YH, LDYH, VSAV, SAVF, EWT, ACOR, IWM, WM, @F, JAC, PSOL, NFLAG, RPAR, IPAR);
   if (NFLAG=0) then goto 450;
{C The VNLS routine failed to achieve convergence (NFLAG .NE. 0).}
{C The YH array is retracted to its values before prediction.}
{C The step size H is reduced and the step is retried, if possible.}
{C Otherwise, an error exit is taken.}
   NCF:= NCF+1;
   NCFN:= NCFN+1;
   ETAMAX:= ONE;
   TN:= TOLD;
   I1:= NQNYH+1;
   for JB:= 1 to NQ do {430}
   begin
    I1:= I1-LDYH;
    for I:= I1 to NQNYH do {420}
    begin
     YH1[I]:= YH1[I]-YH1[I+LDYH];
    end;{420}
   end;{430}
   if (NFLAG<-1) then goto 680;
   if (ABS(H)<=HMIN*ONEPSM) then goto 670;
   if (NCF=MXNCF) then goto 670;
   ETA:= ETACF;
   ETA:= MAX(ETA, HMIN/ABS(H));
   NFLAG:= -1;
   goto 150;
{C The corrector has converged (NFLAG = 0).  The local error test is}
{C made and control passes to statement 500 if it fails.}
   450: {CONTINUE};
   DSM:= ACNRM/TQ[2];
   if (DSM>ONE) then goto 500;
{C After a successful step, update the YH and TAU arrays and decrement}
   KFLAG:= 0;
   NST:= NST+1;
   HU:= H;
   NQU:= NQ;
   for IBACK:= 1 to NQ do {470}
   begin
    I:= L-IBACK;
    TAU[I+1]:= TAU[I];
   end;{470}
   TAU[1]:= H;
   FOR J:=1 TO L DO DAXPY(N,EL[J],ACOR,  1,    YH[YHind(1,J)],   1);
   NQWAIT:= NQWAIT-1;
   if ((L=LMAX))or((NQWAIT<>1)) then goto 490;
   DCOPY(N,ACOR,  1    ,YH[YHind(1,LMAX)],  1);
   CONP:= TQ[5];
   490: if (ETAMAX<>ONE) then goto 560;
   if (NQWAIT<2) then NQWAIT:= 2;
   NEWQ:= NQ;
   NEWH:= 0;
   ETA:= ONE;
   HNEW:= H;
   goto 690;
{C The error test failed.  KFLAG keeps track of multiple failures.}
   500: KFLAG:= KFLAG-1;
   NETF:= NETF+1;
   NFLAG:= -2;
   TN:= TOLD;
   I1:= NQNYH+1;
   for JB:= 1 to NQ do {520}
   begin
    I1:= I1-LDYH;
    for I:= I1 to NQNYH do {510}
    begin
     YH1[I]:= YH1[I]-YH1[I+LDYH];
    end;{510}
   end;{520}
   if (ABS(H)<=HMIN*ONEPSM) then goto 660;
   ETAMAX:= ONE;
   if (KFLAG<=KFC) then goto 530;
   FLOTL:= RE_(L);
   ETA:= ONE/(rrpowr((BIAS2*DSM), (ONE/FLOTL))+ADDON);
   ETA:= Max(Max(ETA, HMIN/ABS(H)), ETAMIN);
//qq  ETA:=MAX(ETA,HMIN/ABS(H),ETAMIN);
   if ((KFLAG<=-2))and((ETA>ETAMXF)) then ETA:= ETAMXF;
   goto 150;
{C Control reaches this section if 3 or more consecutive failures}
   530: if (KFLAG=KFH) then goto 660;
   if (NQ=1) then goto 540;
   ETA:= MAX(ETAMIN, HMIN/ABS(H));
   DVJUST(YH,LDYH, -1);
   L:= NQ;
   NQ:= NQ-1;
   NQWAIT:= L;
   goto 150;
   540: ETA:= MAX(ETAMIN, HMIN/ABS(H));
   H:= H*ETA;
   HSCAL:= H;
   TAU[1]:= H;
   F(N, TN, Y[1], SAVF[1], RPAR[1], IPAR[1]);
   NFE:= NFE+1;
   for I:= 1 to N do YH[YHind(I, 2)]:= H*SAVF[I];
   NQWAIT:= 10;
   goto 200;
{C If NQWAIT = 0, an increase or decrease in order by one is considered.}
   560: FLOTL:= RE_(L);
   ETAQ:= ONE/(rrpowr((BIAS2*DSM), (ONE/FLOTL))+ADDON);
   if (NQWAIT<>0) then goto 600;
   NQWAIT:= 2;
   ETAQM1:= ZERO;
   if (NQ=1) then goto 570;
   DDN:= DVNORM(N, YH[YHind(1, L)], EWT)/TQ[1];
   ETAQM1:= ONE/(rrpowr((BIAS1*DDN), (ONE/(FLOTL-ONE)))+ADDON);
   570: ETAQP1:= ZERO;
   if (L=LMAX) then goto 580;
   CNQUOT:= (TQ[5]/CONP)*ripowr((H/TAU[2]), L);
   for I:= 1 to N do SAVF[I]:= ACOR[I]-CNQUOT*YH[YHind(I, LMAX)];
   DUP:= DVNORM(N, SAVF, EWT)/TQ[3];
   ETAQP1:= ONE/(rrpowr((BIAS3*DUP), (ONE/(FLOTL+ONE)))+ADDON);
   580: if (ETAQ>=ETAQP1) then goto 590;
   if (ETAQP1>ETAQM1) then goto 620;
   goto 610;
   590: if (ETAQ<ETAQM1) then goto 610;
   600: ETA:= ETAQ;
   NEWQ:= NQ;
   goto 630;
   610: ETA:= ETAQM1;
   NEWQ:= NQ-1;
   goto 630;
   620: ETA:= ETAQP1;
   NEWQ:= NQ+1;
   DCOPY(N,ACOR,  1,YH[YHind(1,LMAX)],      1);
   630: if (ETA<THRESH)or(ETAMAX=ONE) then goto 640;
   ETA:= MIN(ETA, ETAMAX);
   ETA:= ETA/MAX(ONE, ABS(H)*HMXI*ETA);
   NEWH:= 1;
   HNEW:= H*ETA;
   goto 690;
   640: NEWQ:= NQ;
   NEWH:= 0;
   ETA:= ONE;
   HNEW:= H;
   goto 690;
{C All returns are made through this section.}
{C On a successful return, ETAMAX is reset and ACOR is scaled.}
   660: KFLAG:= -1;
   goto 720;
   670: KFLAG:= -2;
   goto 720;
   680: if (NFLAG=-2) then KFLAG:= -3;
   if (NFLAG=-3) then KFLAG:= -4;
   goto 720;
   690: ETAMAX:= ETAMX3;
   if (NST<=10) then ETAMAX:= ETAMX2;
   R:= ONE/TQ[2];
   DSCAL(N,R,ACOR,  1);
   720: JSTART:= 1;
   EXIT;
  end;{with common blocks do}
end;
function IXSAV(
 const IPAR: integertype{constant};
 const IVALUE: integertype{constant};
 const ISET: boolean{constant}): integertype;
{---------- Local variables ----------}
const
 LUNIT: integertype=6;
 MESFLG: integertype=1;
begin
 IXSAV:= -1;
 if (IPAR=1) then
 begin
  IXSAV:= LUNIT;
  if (ISET) then
  begin
   LUNIT:= IVALUE;
  end;
 end;
 if (IPAR=2) then
 begin
  IXSAV:= MESFLG;
  if (ISET) then
  begin
   MESFLG:= IVALUE;
  end;
 end;
 EXIT;
end;
procedure XERRWD(
 var MSG_;
 const NMES: integertype{constant};
 const NERR: integertype{constant};
 const LEVEL: integertype{constant};
 const NI: integertype{constant};
 const I1: integertype{constant};
 const I2: integertype{constant};
 const NR: integertype{constant};
 const R1: realtype{constant};
 const R2: realtype{constant});
var
 MSG: array[1..254] of char absolute MSG_{ [NMES] elements };
 MESFLG: integertype;
 TmpI1, TmpI2: integertype;
 TmpB: Boolean;
 aStr: string;
label
 100;
begin
 aStr:= '';
 for TmpI1:= 1 to NMES do
  aStr:= aStr+Msg[TmpI1];
 TmpI1:= 1;
 TmpI2:= 0;
 TmpB:= False;
 IXSAV(TmpI1, TmpI2, TmpB);
 TmpI1:= 2;
 TmpI2:= 0;
 TmpB:= False;
 MESFLG:= IXSAV(TmpI1, TmpI2, TmpB);
 if (MESFLG=0) then goto 100;
 if (NI=1) then
 begin
  aStr:= aStr+' I1='+IntToStr(I1);
 end;
 if (NI=2) then
 begin
  aStr:= aStr+' I1='+IntToStr(I1)+' ,I2='+IntToStr(I2);
 end;
 if (NR=1) then
 begin
  aStr:= aStr+' R1='+FloatToStr(R1);
 end;
 if (NR=2) then
 begin
  aStr:= aStr+' R1='+FloatToStr(R1)+',R2='+FloatToStr(R2);
 end;
 StdOut.Add(aStr);
 100: if (LEVEL<>2) then EXIT;
end;
procedure DVINDY(
 const T: realtype{constant};
 const K: integertype{constant};
 var YH_;
 const LDYH: integertype{constant};
 var DKY_;
 var IFLAG: integertype);
const
 HUN: realtype=100.0;
 ZERO: realtype=0.0;
var
 DVOD01: COMMON_DVOD01_ absolute COMMON_DVOD01;
 DVOD02: COMMON_DVOD02_ absolute COMMON_DVOD02;
 YH: realarraytype absolute YH_{ [1*(LDYH-1+1)*(*-1+1);] elements };
 DKY: realarraytype absolute DKY_{ [1*(*-1+1);] elements };
 C, R, S, TFUZZ, TN1, TP: realtype;
 I, IC, J, JB, JB2, JJ, JJ1, JP1: integertype;
 MSG: string[80];
// qq
label
 15, 35, 55, 80, 90;
{Index of element of YH(LDYH,*)}
 function YHind(I1, I2: integertype): integertype;
 begin
  YHind:= (I2-1)*LDYH+I1;
 end;
begin
 with DVOD01 do with DVOD02 do {with common blocks}
  begin
{C DVINDY computes interpolated values of the K-th derivative of the}
{C dependent variable vector y, and stores it in DKY.  This routine}
{C is called within the package with K = 0 and T = TOUT, but may}
{C also be called by the user for any K up to the current order.}
   IFLAG:= 0;
   if (K<0)or(K>NQ) then goto 80;
   TFUZZ:= HUN*UROUND*(TN+HU);
   TP:= TN-HU-TFUZZ;
   TN1:= TN+TFUZZ;
   if ((T-TP)*(T-TN1)>ZERO) then goto 90;
   S:= (T-TN)/H;
   IC:= 1;
   if (K=0) then goto 15;
   JJ1:= L-K;
   for JJ:= JJ1 to NQ do IC:= IC*JJ;
   15: C:= RE_(IC);
   for I:= 1 to N do DKY[I]:= C*YH[YHind(I, L)];
   if (K=NQ) then goto 55;
   JB2:= NQ-K;
   for JB:= 1 to JB2 do {50}
   begin
    J:= NQ-JB;
    JP1:= J+1;
    IC:= 1;
    if (K=0) then goto 35;
    JJ1:= JP1-K;
    for JJ:= JJ1 to J do IC:= IC*JJ;
    35: C:= RE_(IC);
    for I:= 1 to N do DKY[I]:= C*YH[YHind(I, JP1)]+S*DKY[I];
   end;{50}
   if (K=0) then EXIT;
   55: R:= ripowr(H, (-K));
   DSCAL(N,R,DKY, 1);
   EXIT;
   80: MSG:= 'DVINDY-- K (=I1) illegal      ';
   XERRWD(MSG, 30, 51, 1, 1, K, 0, 0, ZERO, ZERO);
   IFLAG:= -1;
   EXIT;
   90: MSG:= 'DVINDY-- T (=R1) illegal      ';
   XERRWD(MSG, 30, 52, 1, 0, 0, 0, 1, T, ZERO);
   XERRWD(MSG, 60, 52, 1, 0, 0, 0, 2, TP, TN);
   IFLAG:= -2;
   EXIT;
  end;{with common blocks do}
end;
procedure DACOPY(
 const NROW: integertype{constant};
 const NCOL: integertype{constant};
 var A_;
 const NROWA: integertype{constant};
 var B_;
 const NROWB: integertype{constant});
var
 A: realarraytype absolute A_{ [NROWA*NCOL] elements };
 B: realarraytype absolute B_{ [NROWB*NCOL] elements };
 IC: integertype;
{Index of element of A(NROWA,NCOL)}
 function Aind(I1, I2: integertype): integertype;
 begin
  Aind:= (I2-1)*NROWA+I1;
 end;
{Index of element of B(NROWB,NCOL)}
 function Bind(I1, I2: integertype): integertype;
 begin
  Bind:= (I2-1)*NROWB+I1;
 end;
begin
{C This routine copies one rectangular array, A, to another, B,}
{C where A and B may have different row dimensions, NROWA and NROWB.}
{C The data copied consists of NROW rows and NCOL columns.}
  FOR IC:=1 TO NCOL DO DCOPY(NROW,A[Aind(1,IC)],1,     B[Bind(1,IC)],  1);
{C}
 EXIT;
end;
function IDAMAX(
 const N: integertype{constant};
 var DX_;
 var INCX: integertype{constant}): integertype;
{---------- Local variables ----------}
var
 DX: realarraytype absolute DX_{ [1] elements };
 DMAX: realtype;
 I, IX: integertype;
label
 5, 20, 30;
begin
{c    finds the index of element having max. absolute value.}
{c    jack dongarra, linpack, 3/11/78.}
 IDAMAX:= 0;
 if (N<1) then EXIT;
 IDAMAX:= 1;
 if (N=1) then EXIT;
 if (INCX=1) then goto 20;
 IX:= 1;
 DMAX:= ABS(DX[1]);
 IX:= IX+INCX;
 for I:= 2 to N do {10}
 begin
  if (ABS(DX[IX])<=DMAX) then
  begin
   goto 5;
  end;
  IDAMAX:= I;
  DMAX:= ABS(DX[IX]);
  5: IX:= IX+INCX;
 end;{10}
 EXIT;
 20: DMAX:= ABS(DX[1]);
 for I:= 2 to N do {30}
 begin
  if (ABS(DX[I])<=DMAX) then
  begin
   goto 30;
  end;
  IDAMAX:= I;
  DMAX:= ABS(DX[I]);
  30: {CONTINUE};
 end;{30}
 EXIT;
end;
procedure DGEFA(
 var A_;
 const LDA: integertype{constant};
 const N: integertype{constant};
 var IPVT_;
 var INFO: integertype);
var
 A: realarraytype absolute A_{ [LDA] elements };
 IPVT: integerarraytype absolute IPVT_{ [1] elements };
 J, K, KP1, L, NM1: integertype;
 T: realtype;
//qq
 TmpI1, TmpI2: integertype;
label
 10, 20, 40, 50, 70;
{Index of element of A(LDA,1)}
 function Aind(I1, I2: integertype): integertype;
 begin
  Aind:= (I2-1)*LDA+I1;
 end;
begin
{c    dgefa factors a double precision matrix by gaussian elimination.}
 INFO:= 0;
 NM1:= N-1;
 if (NM1<1) then goto 70;
 for K:= 1 to NM1 do {60}
 begin
  KP1:= K+1;
  TmpI1:= N-K+1;
  TmpI2:= 1;
  L:= IDAMAX(TmpI1, A[Aind(K, K)], TmpI2)+K-1;
//qq L:=IDAMAX(N-K+1,A[Aind(K,K)],  1)   +K-1;
  IPVT[K]:= L;
  if (A[Aind(L, K)]=0.0E0) then goto 40;
  if (L=K) then goto 10;
  T:= A[Aind(L, K)];
  A[Aind(L, K)]:= A[Aind(K, K)];
  A[Aind(K, K)]:= T;
  10: {CONTINUE};
  T:= -1.0E0/A[Aind(K, K)];
  DSCAL(N-K, T,A[Aind(K+1,K)], 1);
  for J:= KP1 to N do {30}
  begin
   T:= A[Aind(L, J)];
   if (L=K) then
   begin
    goto 20;
   end;
   A[Aind(L, J)]:= A[Aind(K, J)];
   A[Aind(K, J)]:= T;
   20: {CONTINUE};
   DAXPY(N-K,T,A[Aind(K+1,K)],   1,A[Aind(K+1,J)],         1);
  end;{30}
  goto 50;
  40: {CONTINUE};
  INFO:= K;
  50: {CONTINUE};
 end;{60}
 70: {CONTINUE};
 IPVT[N]:= N;
 if (A[Aind(N, N)]=0.0E0) then INFO:= N;
 EXIT;
end;
procedure DGBFA(
 var ABD_;
 const LDA: integertype{constant};
 const N: integertype{constant};
 const ML: integertype{constant};
 const MU: integertype{constant};
 var IPVT_;
 var INFO: integertype);
{---------- Local variables ----------}
var
 ABD: realarraytype absolute ABD_{ [LDA] elements };
 IPVT: integerarraytype absolute IPVT_{ [1] elements };
 I, I0, J, J0, J1, JU, JZ, K, KP1, L, LM, M, MM, NM1: integertype;
 T: realtype;
// qq
 TmpI1, TmpI2: integertype;
label
 30, 50, 60, 70, 90, 100, 110, 130;
{Index of element of ABD(LDA,1)}
 function ABDind(I1, I2: integertype): integertype;
 begin
  ABDind:= (I2-1)*LDA+I1;
 end;
begin
{c    dgbfa factors a double precision band matrix by elimination.}
 M:= ML+MU+1;
 INFO:= 0;
 J0:= MU+2;
 J1:= MIN0(N, M)-1;
 if (J1<J0) then goto 30;
 for JZ:= J0 to J1 do {20}
 begin
  I0:= M+1-JZ;
  for I:= I0 to ML do {10}
  begin
   ABD[ABDind(I, JZ)]:= 0.0E0;
  end;{10}
 end;{20}
 30: {CONTINUE};
 JZ:= J1;
 JU:= 0;
 NM1:= N-1;
 if (NM1<1) then goto 130;
 for K:= 1 to NM1 do {120}
 begin
  KP1:= K+1;
  JZ:= JZ+1;
  if (JZ>N) then goto 50;
  if (ML<1) then goto 50;
  for I:= 1 to ML do ABD[ABDind(I, JZ)]:= 0.0E0;
  50: {CONTINUE};
  LM:= MIN0(ML, N-K);
  TmpI1:= LM+1;
  TmpI2:= 1;
  L:= IDAMAX(TmpI1, ABD[ABDind(M, K)], TmpI2)+M-1;
//qq  L:=IDAMAX(LM+1,ABD[ABDind(M,K)],     1)+M-1;
  IPVT[K]:= L+K-M;
  if (ABD[ABDind(L, K)]=0.0E0) then goto 100;
  if (L=M) then goto 60;
  T:= ABD[ABDind(L, K)];
  ABD[ABDind(L, K)]:= ABD[ABDind(M, K)];
  ABD[ABDind(M, K)]:= T;
  60: {CONTINUE};
  T:= -1.0E0/ABD[ABDind(M, K)];
  DSCAL(LM,T,ABD[ABDind(M+1,K)],  1);
  JU:= MIN0(MAX0(JU, MU+IPVT[K]), N);
  MM:= M;
  if (JU<KP1) then goto 90;
  for J:= KP1 to JU do {80}
  begin
   L:= L-1;
   MM:= MM-1;
   T:= ABD[ABDind(L, J)];
   if (L=MM) then goto 70;
   ABD[ABDind(L, J)]:= ABD[ABDind(MM, J)];
   ABD[ABDind(MM, J)]:= T;
   70: {CONTINUE};
   DAXPY(LM,T,ABD[ABDind(M+1,K)],   1,ABD[ABDind(MM+1,J)],        1);
  end;{80}
  90: {CONTINUE};
  goto 110;
  100: {CONTINUE};
  INFO:= K;
  110: {CONTINUE};
 end;{120}
 130: {CONTINUE};
 IPVT[N]:= N;
 if (ABD[ABDind(M, N)]=0.0E0) then INFO:= N;
 EXIT;
end;
procedure DVJAC(
 var Y_:realtype;
 var YH_:realtype;
 const LDYH: integertype{constant};
 var EWT_:realtype;
 var FTEM_:realtype;
 var SAVF_:realtype;
 var WM_:realtype;
 var IWM_:integertype;
 F_: Tdydt4vode;
 JAC_: Tdfdy4vode;
 var IERPJ: integertype;
 var RPAR_:realtype;
 var IPAR_:integertype
 );
const
 ONE: realtype=1.0;
 PT1: realtype=0.1;
 THOU: realtype=1000.0;
 ZERO: realtype=0.0;
var
 DVOD01: COMMON_DVOD01_ absolute COMMON_DVOD01;
 DVOD02: COMMON_DVOD02_ absolute COMMON_DVOD02;
 Y: realarraytype absolute Y_{ [1*(*-1+1);] elements };
 YH: realarraytype absolute YH_{ [1*(LDYH-1+1)*(*-1+1);] elements };
 EWT: realarraytype absolute EWT_{ [1*(*-1+1);] elements };
 FTEM: realarraytype absolute FTEM_{ [1*(*-1+1);] elements };
 SAVF: realarraytype absolute SAVF_{ [1*(*-1+1);] elements };
 WM: realarraytype absolute WM_{ [1*(*-1+1);] elements };
 IWM: integerarraytype absolute IWM_{ [1*(*-1+1);] elements };
 RPAR: realarraytype absolute RPAR_{ [1*(*-1+1);] elements };
 IPAR: integerarraytype absolute IPAR_{ [1*(*-1+1);] elements };
 I, I1, I2, IER, II, J, J1, JJ, JOK, LENP, MBA, MBAND, MEB1, MEBAND,
  ML, ML3, MU, NP1: integertype;
 CON, DI, FAC, HRL1, R, R0, SRUR, YI, YJ, YJJ: realtype;
 F: Tdydt4vode;
 JAC: Tdfdy4vode;
//qqqq
// JAC: DVJAC_JAC_TYPE;
// F: DVJAC_F_TYPE;
 TmpI1, TmpI2: integertype;
label
 320, 330;
{Index of element of YH(LDYH,*)}
 function YHind(I1, I2: integertype): integertype;
 begin
  YHind:= (I2-1)*LDYH+I1;
 end;
begin
 with DVOD01 do with DVOD02 do {with common blocks}
  begin
   F:= F_;
   JAC:= JAC_;
{C DVJAC is called by DVNLSD to compute and process the matrix}
{C P = I - h*rl1*J , where J is an approximation to the Jacobian.}
   IERPJ:= 0;
   HRL1:= H*RL1;
{C See whether J should be evaluated (JOK = -1) or not (JOK = 1). -------}
   JOK:= JSV;
   if (JSV=1) then
   begin
    if (NST=0)or(NST>NSLJ+MSBJ) then
    begin
     JOK:= -1;
    end;
    if (ICF=1)and(DRC<CCMXJ) then JOK:= -1;
    if (ICF=2) then JOK:= -1;
   end;
   if (JOK=-1)and(MITER=1) then
   begin
    NJE:= NJE+1;
    NSLJ:= NST;
    JCUR:= 1;
    LENP:= N*N;
    for I:= 1 to LENP do WM[I+2]:= ZERO;
    TmpI1:= 0;
    TmpI2:= 0;
    JAC(N, TN, Y[1], TmpI1, TmpI2, WM[3], N, RPAR[1], IPAR[1]);
//qq JAC(N,TN,Y,  0,      0,    WM[3],N,RPAR,IPAR);
    IF (JSV = 1) THEN DCOPY(LENP,WM[3],1,WM[LOCJS],1);
   end;
{C}
   if (JOK=-1)and(MITER=2) then
   begin                                    
    NJE:= NJE+1;
    NSLJ:= NST;
    JCUR:= 1;
    FAC:= DVNORM(N, SAVF, EWT);
    R0:= THOU*ABS(H)*UROUND*RE_(N)*FAC;
    if (R0=ZERO) then R0:= ONE;
    SRUR:= WM[1];
    J1:= 2;
    for J:= 1 to N do {230}
    begin
     YJ:= Y[J];
     R:= MAX(SRUR*ABS(YJ), R0/EWT[J]);
     Y[J]:= Y[J]+R;
//qq     FAC:= ONE/R;
     if R>1.0e-308 then
      FAC:= ONE/R
     else
      FAC:= 1.0e308;
     F(N, TN, Y[1], FTEM[1], RPAR[1], IPAR[1]);
     for I:= 1 to N do WM[I+J1]:= (FTEM[I]-SAVF[I])*FAC;
     Y[J]:= YJ;
     J1:= J1+N;
    end;{230}
    NFE:= NFE+N;
    LENP:= N*N;
    IF (JSV = 1) THEN DCOPY(LENP,WM[3],1,WM[LOCJS],1);
   end;
   if (JOK=1)and((MITER=1)or(MITER=2)) then
   begin
    JCUR:= 0;
    LENP:= N*N;
    DCOPY(LENP,WM[LOCJS],  1,WM[3],      1);
   end;
   if (MITER=1)or(MITER=2) then
   begin
    CON:= -HRL1;
//qq      LENP:= N*N; Added for Warning Kill
    LENP:= N*N;
    DSCAL(LENP,CON,WM[3],  1);
    J:= 3;
    NP1:= N+1;
    for I:= 1 to N do {250}
    begin
     WM[J]:= WM[J]+ONE;
     J:= J+NP1;
    end;{250}
    NLU:= NLU+1;
    DGEFA(WM[3], N, N, IWM[31], IER);
    if (IER<>0) then IERPJ:= 1;
    EXIT;
   end;
   if (MITER=3) then
   begin
    NJE:= NJE+1;
    JCUR:= 1;
    WM[2]:= HRL1;
    R:= RL1*PT1;
    for I:= 1 to N do Y[I]:= Y[I]+R*(H*SAVF[I]-YH[YHind(I, 2)]);
    F(N, TN, Y[1], WM[3], RPAR[1], IPAR[1]);
    NFE:= NFE+1;
    for I:= 1 to N do {320}
    begin
     R0:= H*SAVF[I]-YH[YHind(I, 2)];
     DI:= PT1*R0-H*(WM[I+2]-SAVF[I]);
     WM[I+2]:= ONE;
     if (ABS(R0)<UROUND/EWT[I]) then goto 320;
     if (ABS(DI)=ZERO) then goto 330;
     WM[I+2]:= PT1*R0/DI;
     320: {CONTINUE};
    end;{320}
    EXIT;
    330: IERPJ:= 1;
    EXIT;
   end;
{C End of code block for MITER = 3. -------------------------------------}
{C Set constants for MITER = 4 or 5. ------------------------------------}
   ML:= IWM[1];
   MU:= IWM[2];
   ML3:= ML+3;
   MBAND:= ML+MU+1;
   MEBAND:= MBAND+ML;
   LENP:= MEBAND*N;
   if (JOK=-1)and(MITER=4) then
   begin
{C If JOK = -1 and MITER = 4, call JAC to evaluate Jacobian. ------------}
    NJE:= NJE+1;
    NSLJ:= NST;
    JCUR:= 1;
    for I:= 1 to LENP do WM[I+2]:= ZERO;
    JAC(N, TN, Y[1], ML, MU, WM[ML3], MEBAND, RPAR[1], IPAR[1]);
    if (JSV=1) then DACOPY(MBAND, N, WM[ML3], MEBAND, WM[LOCJS], MBAND);
   end;
{C}
   if (JOK=-1)and(MITER=5) then
   begin
{C If MITER = 5, make ML+MU+1 calls to F to approximate the Jacobian. ---}
    NJE:= NJE+1;
    NSLJ:= NST;
    JCUR:= 1;
    MBA:= MIN(MBAND, N);
    MEB1:= MEBAND-1;
    SRUR:= WM[1];
    FAC:= DVNORM(N, SAVF, EWT);
    R0:= THOU*ABS(H)*UROUND*RE_(N)*FAC;
    if (R0=ZERO) then R0:= ONE;
    for J:= 1 to MBA do {560}
    begin
     I:= J;
     while ((I>=J)and(I<=N))or((I>=N)and(I<=J)) do {530}
     begin
      YI:= Y[I];
      R:= MAX(SRUR*ABS(YI), R0/EWT[I]);
      Y[I]:= Y[I]+R;
      I:= I+MBAND;
     end;{530}
     F(N, TN, Y[1], FTEM[1], RPAR[1], IPAR[1]);
     JJ:= J;
     while ((JJ>=J)and(JJ<=N))or((JJ>=N)and(JJ<=J)) do {550}
     begin
      Y[JJ]:= YH[YHind(JJ, 1)];
      YJJ:= Y[JJ];
      R:= MAX(SRUR*ABS(YJJ), R0/EWT[JJ]);
      FAC:= ONE/R;
      I1:= MAX(JJ-MU, 1);
      I2:= MIN(JJ+ML, N);
      II:= JJ*MEB1-ML+2;
      for I:= I1 to I2 do WM[II+I]:= (FTEM[I]-SAVF[I])*FAC;
      JJ:= JJ+MBAND;
     end;{550}
    end;{560}
    NFE:= NFE+MBA;
    if (JSV=1) then DACOPY(MBAND, N, WM[ML3], MEBAND, WM[LOCJS], MBAND);
   end;
   if (JOK=1) then
   begin
    JCUR:= 0;
    DACOPY(MBAND, N, WM[LOCJS], MBAND, WM[ML3], MEBAND);
   end;
{C Multiply Jacobian by scalar, add identity, and do LU decomposition.}
   CON:= -HRL1;
   DSCAL(LENP,CON,WM[3],  1);
   II:= MBAND+2;
   for I:= 1 to N do {580}
   begin
    WM[II]:= WM[II]+ONE;
    II:= II+MEBAND;
   end;{580}
   NLU:= NLU+1;
   DGBFA(WM[3], MEBAND, N, ML, MU, IWM[31], IER);
   if (IER<>0) then IERPJ:= 1;
   EXIT;
{C End of code block for MITER = 4 or 5. --------------------------------}
  end;{with common blocks do}
end;

function DDOT(
 const N: integertype{constant};
 var DX_;
 const INCX: integertype{constant};
 var DY_;
 const INCY: integertype{constant}): realtype;
var
 DX: realarraytype absolute DX_{ [1] elements };
 DY: realarraytype absolute DY_{ [1] elements };
 DTEMP: realtype;
 I, IX, IY, M, MP1: integertype;
label
 20, 40, 60;
begin
{c    forms the dot product of two vectors.}
 DDOT:= 0.0E0;
 DTEMP:= 0.0E0;
 if (N<=0) then EXIT;
 if (INCX=1)and(INCY=1) then goto 20;
 IX:= 1;
 IY:= 1;
 if (INCX<0) then IX:= (-N+1)*INCX+1;
 if (INCY<0) then IY:= (-N+1)*INCY+1;
 for I:= 1 to N do {10}
 begin
  DTEMP:= DTEMP+DX[IX]*DY[IY];
  IX:= IX+INCX;
  IY:= IY+INCY;
 end;{10}
 DDOT:= DTEMP;
 EXIT;
 20: M:= ((N)mod(5));
 if (M=0) then goto 40;
 for I:= 1 to M do DTEMP:= DTEMP+DX[I]*DY[I];
 if (N<5) then goto 60;
 40: MP1:= M+1;
 I:= MP1;
 while ((I>=MP1)and(I<=N))or((I>=N)and(I<=MP1)) do {50}
 begin
  DTEMP:= DTEMP+DX[I]*DY[I]+DX[I+1]*DY[I+1]+DX[I+2]*DY[I+2]+DX[I+3]*DY[
   I+3]+DX[I+4]*DY[I+4];
  I:= I+5;
 end;{50}
 60: DDOT:= DTEMP;
 EXIT;
end;

procedure DGESL(
 var A_:realtype;
 const LDA: integertype{constant};
 const N: integertype{constant};
 var IPVT_:integertype;
 var B_:realtype;
 const JOB: integertype{constant});
var
 A: realarraytype absolute A_{ [LDA] elements };
 IPVT: integerarraytype absolute IPVT_{ [1] elements };
 B: realarraytype absolute B_{ [1] elements };
 K, KB, L, NM1: integertype;
 T: realtype;
label
 10, 30, 50, 70, 90, 100;
{Index of element of A(LDA,1)}
 function Aind(I1, I2: integertype): integertype;
 begin
  Aind:= (I2-1)*LDA+I1;
 end;
begin
{c    dgesl solves the double precision system  a * x = b  or  trans(a) * x = b}
{c    using the factors computed by dgeco or dgefa.}
 NM1:= N-1;
 if (JOB<>0) then goto 50;
{c       job = 0 , solve  a * x = b}
{c       first solve  l*y = b}
 if (NM1<1) then goto 30;
 for K:= 1 to NM1 do {20}
 begin
  L:= IPVT[K];
  T:= B[L];
  if (L=K) then goto 10;
  B[L]:= B[K];
  B[K]:= T;
  10: {CONTINUE};
  DAXPY(N-K,T,A[Aind(K+1,K)],1,B[K+1],1);
 end;{20}
 30: {CONTINUE};
 for KB:= 1 to N do {40}
 begin
  K:= N+1-KB;
  B[K]:= B[K]/A[Aind(K, K)];
  T:= -B[K];
  DAXPY(K-1,T,A[Aind(1,K)],    1,B[1],        1);
 end;{40}
 goto 100;
 50: {CONTINUE};
 for K:= 1 to N do {60}
 begin
  T:=DDOT(K-1,A[Aind(1,K)],    1,B[1],        1);
  B[K]:= (B[K]-T)/A[Aind(K, K)];
 end;{60}
 if (NM1<1) then goto 90;
 for KB:= 1 to NM1 do {80}
 begin
  K:= N-KB;
  B[K]:=B[K]+DDOT(N-K, A[Aind(K+1,K)],   1,B[K+1],      1);
  L:= IPVT[K];
  if (L=K) then goto 70;
  T:= B[L];
  B[L]:= B[K];
  B[K]:= T;
  70: {CONTINUE};
 end;{80}
 90: {CONTINUE};
 100: {CONTINUE};
 EXIT;
end;

procedure DGBSL(
 var ABD_:realtype;
 const LDA: integertype{constant};
 const N: integertype{constant};
 const ML: integertype{constant};
 const MU: integertype{constant};
 var IPVT_:integertype;
 var B_:realtype;
 const JOB: integertype{constant});
var
 ABD: realarraytype absolute ABD_{ [LDA] elements };
 IPVT: integerarraytype absolute IPVT_{ [1] elements };
 B: realarraytype absolute B_{ [1] elements };
 K, KB, L, LA, LB, LM, M, NM1: integertype;
 T: realtype;
label
 10, 30, 50, 70, 90, 100;
{Index of element of ABD(LDA,1)}
 function ABDind(I1, I2: integertype): integertype;
 begin
  ABDind:= (I2-1)*LDA+I1;
 end;
begin
{c    dgbsl solves the double precision band system a * x = b  or  trans(a) * x = b}
 M:= MU+ML+1;
 NM1:= N-1;
 if (JOB<>0) then goto 50;
 if (ML=0) then goto 30;
 if (NM1<1) then goto 30;
 for K:= 1 to NM1 do {20}
 begin
  LM:= MIN0(ML, N-K);
  L:= IPVT[K];
  T:= B[L];
  if (L=K) then goto 10;
  B[L]:= B[K];
  B[K]:= T;
  10: {CONTINUE};
  DAXPY(LM,T,ABD[ABDind(M+1,K)],     1,B[K+1],       1);
 end;{20}
 30: {CONTINUE};
 for KB:= 1 to N do {40}
 begin
  K:= N+1-KB;
  B[K]:= B[K]/ABD[ABDind(M, K)];
  LM:= MIN0(K, M)-1;
  LA:= M-LM;
  LB:= K-LM;
  T:= -B[K];
  DAXPY(LM,T,ABD[ABDind(LA,K)], 1,B[LB],     1);
 end;{40}
 goto 100;
 50: {CONTINUE};
 for K:= 1 to N do {60}
 begin
  LM:= MIN0(K, M)-1;
  LA:= M-LM;
  LB:= K-LM;
  T:=DDOT(LM,ABD[ABDind(LA,K)],  1,   B[LB],   1);
  B[K]:= (B[K]-T)/ABD[ABDind(M, K)];
 end;{60}
 if (ML=0) then goto 90;
 if (NM1<1) then goto 90;
 for KB:= 1 to NM1 do {80}
 begin
  K:= N-KB;
  LM:= MIN0(ML, N-K);
  B[K]:=B[K]+DDOT(LM,ABD[ABDind(M+1,K)],1,B[K+1],1);
  L:= IPVT[K];
  if (L=K) then goto 70;
  T:= B[L];
  B[L]:= B[K];
  B[K]:= T;
  70: {CONTINUE};
 end;{80}
 90: {CONTINUE};
 100: {CONTINUE};
 EXIT;
end;
procedure DVSOL(
 var WM_:realtype;
 var IWM_:integertype;
 var X_:realtype;
 var IERSL: integertype);
{----------}
const
 ONE: realtype=1.0;
 ZERO: realtype=0.0;
{---------- Local variables ----------}
var
 DVOD01: COMMON_DVOD01_ absolute COMMON_DVOD01;
 WM: realarraytype absolute WM_{ [1*(*-1+1);] elements };
 IWM: integerarraytype absolute IWM_{ [1*(*-1+1);] elements };
 X: realarraytype absolute X_{ [1*(*-1+1);] elements };
 DI, HRL1, PHRL1, R: realtype;
 I, MEBAND, ML, MU: integertype;
label
 100, 300, 330, 390, 400;
begin
 with DVOD01 do {with common blocks}
 begin
{C This routine manages the solution of the linear system arising from}
{C a chord iteration.  It is called if MITER .ne. 0.}
  IERSL:= 0;
  if MITER=1 then goto 100;
  if MITER=2 then goto 100;
  if MITER=3 then goto 300;
  if MITER=4 then goto 400;
  if MITER=5 then goto 400;
100:  DGESL(WM[3],N,N,IWM[31],X[1],0);
  EXIT;
  300: PHRL1:= WM[2];
  HRL1:= H*RL1;
  WM[2]:= HRL1;
  if (HRL1=PHRL1) then goto 330;
  R:= HRL1/PHRL1;
  for I:= 1 to N do {320}
  begin
   DI:= ONE-R*(ONE-ONE/WM[I+2]);
   if (ABS(DI)=ZERO) then
   begin
    goto 390;
   end;
   WM[I+2]:= ONE/DI;
  end;{320}
  330: for I:= 1 to N do X[I]:= WM[I+2]*X[I];
  EXIT;
  390: IERSL:= 1;
  EXIT;
  400: ML:= IWM[1];
  MU:= IWM[2];
  MEBAND:= 2*ML+MU+1;
  DGBSL(WM[3],MEBAND,N,ML,MU,IWM[31],X[1],0);
  EXIT;
 end;{with common blocks do}
end;
procedure DVNLSD(
 var Y_:realtype;
 var YH_:realtype;
 const LDYH: integertype{constant};
 var VSAV_:realtype;
 var SAVF_:realtype;
 var EWT_:realtype;
 var ACOR_:realtype;
 var IWM_:realtype;
 var WM_:realtype;
 F_: Tdydt4vode;
 JAC_: Tdfdy4vode;
 PDUM: pointer;
 var NFLAG: integertype;
 var RPAR_:realtype;
 var IPAR_: integertype);
const
 CCMAX: realtype=0.3E0;
 CRDOWN: realtype=0.3E0;
 MAXCOR: integertype=3;
 MSBP: integertype=20;
 RDIV: realtype=2.0E0;
 ONE: realtype=1.0E0;
 TWO: realtype=2.0E0;
 ZERO: realtype=0.0E0;
var
 DVOD01: COMMON_DVOD01_ absolute COMMON_DVOD01;
 DVOD02: COMMON_DVOD02_ absolute COMMON_DVOD02;
 Y: realarraytype absolute Y_{ [1*(*-1+1);] elements };
 YH: realarraytype absolute YH_{ [1*(LDYH-1+1)*(*-1+1);] elements };
 VSAV: realarraytype absolute VSAV_{ [1*(*-1+1);] elements };
 SAVF: realarraytype absolute SAVF_{ [1*(*-1+1);] elements };
 EWT: realarraytype absolute EWT_{ [1*(*-1+1);] elements };
 ACOR: realarraytype absolute ACOR_{ [1*(*-1+1);] elements };
 IWM: integerarraytype absolute IWM_{ [1*(*-1+1);] elements };
 WM: realarraytype absolute WM_{ [1*(*-1+1);] elements };
 RPAR: realarraytype absolute RPAR_{ [1*(*-1+1);] elements };
 IPAR: integerarraytype absolute IPAR_{ [1*(*-1+1);] elements };
 CSCALE, DCON, DEL, DELP: realtype;
 I, IERPJ, IERSL, M: integertype;
 F: Tdydt4vode;
 JAC: Tdfdy4vode;
label
 220, 250, 270, 350, 400, 410, 430, 450;
{Index of element of YH(LDYH,*)}
 function YHind(I1, I2: integertype): integertype;
 begin
  YHind:= (I2-1)*LDYH+I1;
 end;
begin
{C Subroutine DVNLSD is a nonlinear system solver,}
 with DVOD01 do with DVOD02 do {with common blocks}
  begin
   F:= F_;
   JAC:= JAC_;
{C PDUM       = Unused dummy subroutine name.Included for uniformity over collection of integrators.}
   if (JSTART=0) then NSLP:= 0;
   if (NFLAG=0) then ICF:= 0;
   if (NFLAG=-2) then IPUP:= MITER;
   if ((JSTART=0))or((JSTART=-1)) then IPUP:= MITER;
   if (MITER=0) then
   begin
    CRATE:= ONE;
    goto 220;
   end;
   DRC:= ABS(RC-ONE);
   if (DRC>CCMAX)or(NST>=NSLP+MSBP) then IPUP:= MITER;
   220: M:= 0;
   DELP:= ZERO;
   DCOPY(N,YH[YHind(1,1)],1,Y,1);
   F(N, TN, Y[1], SAVF[1], RPAR[1], IPAR[1]);
   NFE:= NFE+1;
   if (IPUP<=0) then goto 250;
   DVJAC(Y[1], YH[1], LDYH, EWT[1], ACOR[1], SAVF[1], WM[1], IWM[1], F, JAC, IERPJ, RPAR[1], IPAR[1]);
   IPUP:= 0;
   RC:= ONE;
   DRC:= ZERO;
   CRATE:= ONE;
   NSLP:= NST;
   if (IERPJ<>0) then goto 430;
   250: for I:= 1 to N do ACOR[I]:= ZERO;
   270: if (MITER<>0) then goto 350;
   for I:= 1 to N do SAVF[I]:= RL1*(H*SAVF[I]-YH[YHind(I, 2)]);
   for I:= 1 to N do Y[I]:= SAVF[I]-ACOR[I];
   DEL:= DVNORM(N, Y, EWT);
   for I:= 1 to N do Y[I]:= YH[YHind(I, 1)]+SAVF[I];
   DCOPY(N,SAVF, 1,ACOR,      1);
   goto 400;
   350: for I:= 1 to N do Y[I]:= (RL1*H)*SAVF[I]-(RL1*YH[YHind(I, 2)]+ACOR[I]);
   DVSOL(WM[1], IWM[1], Y[1], IERSL);
   NNI:= NNI+1;
   if (IERSL>0) then goto 410;
   if (METH=2)and(RC<>ONE) then
   begin
    CSCALE:= TWO/(ONE+RC);
   DSCAL(N,CSCALE,Y,   1);
   end;
   DEL:= DVNORM(N, Y, EWT);
   DAXPY(N,ONE,Y,  1,ACOR,      1);
   for I:= 1 to N do Y[I]:= YH[YHind(I, 1)]+ACOR[I];
   400: if (M<>0) then CRATE:= MAX(CRDOWN*CRATE, DEL/DELP);
   DCON:= DEL*MIN(ONE, CRATE)/TQ[4];
   if (DCON<=ONE) then goto 450;
   M:= M+1;
   if (M=MAXCOR) then goto 410;
   if (M>=2)and(DEL>RDIV*DELP) then goto 410;
   DELP:= DEL;
   F(N, TN, Y[1], SAVF[1], RPAR[1], IPAR[1]);
   NFE:= NFE+1;
   goto 270;
   410: if (MITER=0)or(JCUR=1) then goto 430;
   ICF:= 1;
   IPUP:= MITER;
   goto 220;
   430: {CONTINUE};
   NFLAG:= -1;
   ICF:= 2;
   IPUP:= MITER;
   EXIT;
   450: NFLAG:= 0;
   JCUR:= 0;
   ICF:= 0;
   if (M=0) then ACNRM:= DEL;
   if (M>0) then ACNRM:= DVNORM(N, ACOR, EWT);
   EXIT;
  end;{with common blocks do}
end;
procedure DVODE(
 F_: Tdydt4vode;
 const NEQ: integertype{constant};
 var Y_;
 var T: realtype;
 var TOUT: realtype{constant};
 var ITOL: integertype{constant};
 var RTOL_;
 var ATOL_;
 var ITASK: integertype{constant};
 var ISTATE: integertype;
 var IOPT: integertype{constant};
 var RWORK_:realtype;
 var LRW: integertype{constant};
 var IWORK_:integertype;
 var LIW: integertype{constant};
 JAC_: Tdfdy4vode;
 var MF: integertype{constant};
 var RPAR_:realtype;
 var IPAR_:integertype);
const
 MORD: array[1..2] of integertype=(12, 5);
 MXSTP0: integertype=MaxSteps;
 MXHNL0: integertype=10;
 ZERO: realtype=0.0E0;
 ONE: realtype=1.0E0;
 TWO: realtype=2.0E0;
 FOUR: realtype=4.0E0;
 PT2: realtype=0.2E0;
 HUN: realtype=100.0E0;
var
 DVOD01: COMMON_DVOD01_ absolute COMMON_DVOD01;
 DVOD02: COMMON_DVOD02_ absolute COMMON_DVOD02;
 Y: realarraytype absolute Y_{ [1*(*-1+1);] elements };
 RTOL: realarraytype absolute RTOL_{ [1*(*-1+1);] elements };
 ATOL: realarraytype absolute ATOL_{ [1*(*-1+1);] elements };
 RWORK: realarraytype absolute RWORK_{ [LRW] elements };
 IWORK: integerarraytype absolute IWORK_{ [LIW] elements };
 RPAR: realarraytype absolute RPAR_{ [1*(*-1+1);] elements };
 IPAR: integerarraytype absolute IPAR_{ [1*(*-1+1);] elements };
 ATOLI, BIG, EWTI, H0, HMAX, HMX, RH, RTOLI, SIZE, TCRIT, TNEXT, TOLSF,
  TP: realtype;
 I, IER, IFLAG, IMXER, JCO, KGO, LENIW, LENJ, LENP, LENRW, LENWM, LF0, MBAND,
  MFA, ML, MU, NITER,
  NSLAST: integertype;
 IHIT: boolean;
 MSG: string[80];
 F: Tdydt4vode;
 JAC: Tdfdy4vode;
label
 10, 20, 25, 30, 40, 50, 60, 90, 100, 110, 180, 200, 210, 220, 230, 240, 245, 250, 270, 280, 290,
  300, 310, 330, 340, 345, 350, 400, 420, 500, 510, 520, 530, 540, 560, 570, 580, 601, 602, 603,
  604, 605, 606, 607, 608, 609, 610, 611, 612, 613, 614, 615, 616, 617, 618, 619, 620, 621, 622,
  623, 624, 625, 626, 627, 700,
  800;
begin
 with DVOD01 do with DVOD02 do {with common blocks}
  begin
   F:= F_;
   JAC:= JAC_;
{C DVODE.. Variable-coefficient Ordinary Differential Equation solver,}
{C with fixed-leading-coefficient implementation.}
{C Block A.}
   if (ITASK=4) then RWORK[1]:= TOUT;
   if (ISTATE<1)or(ISTATE>3) then goto 601;
   if (ITASK<1)or(ITASK>5) then goto 602;
   if (ISTATE=1) then goto 10;
   if (INIT<>1) then goto 603;
   if (ISTATE=2) then goto 200;
   goto 20;
   10: INIT:= 0;
   if (TOUT=T) then EXIT;
{C Block B.}
   20: if (NEQ<=0) then goto 604;
   if (ISTATE=1) then goto 25;
   if (NEQ>N) then goto 605;
   25: N:= NEQ;
   if (ITOL<1)or(ITOL>4) then goto 606;
   if (IOPT<0)or(IOPT>1) then goto 607;
   JSV:= TRUNC(SIGN(1, MF));
   MFA:= TRUNC(ABS(MF));
   METH:= MFA div 10;
   MITER:= MFA-10*METH;
   if (METH<1)or(METH>2) then goto 608;
   if (MITER<0)or(MITER>5) then goto 608;
   if (MITER<=3) then goto 30;
   ML:= IWORK[1];
   MU:= IWORK[2];
   if (ML<0)or(ML>=N) then goto 609;
   if (MU<0)or(MU>=N) then goto 610;
   30: {CONTINUE};
   if (IOPT=1) then goto 40;
   MAXORD:= MORD[METH];
   MXSTEP:= MXSTP0;
   MXHNIL:= MXHNL0;
   if (ISTATE=1) then H0:= ZERO;
   HMXI:= ZERO;
   HMIN:= ZERO;
   goto 60;
   40: MAXORD:= IWORK[5];
   if (MAXORD<0) then goto 611;
   if (MAXORD=0) then MAXORD:= 100;
   MAXORD:= MIN(MAXORD, MORD[METH]);
   MXSTEP:= IWORK[6];
   if (MXSTEP<0) then goto 612;
   if (MXSTEP=0) then MXSTEP:= MXSTP0;
   MXHNIL:= IWORK[7];
   if (MXHNIL<0) then goto 613;
   if (MXHNIL=0) then MXHNIL:= MXHNL0;
   if (ISTATE<>1) then goto 50;
   H0:= RWORK[5];
   if ((TOUT-T)*H0<ZERO) then goto 614;
   50: HMAX:= RWORK[6];
   if (HMAX<ZERO) then goto 615;
   HMXI:= ZERO;
   if (HMAX>ZERO) then HMXI:= ONE/HMAX;
   HMIN:= RWORK[7];
   if (HMIN<ZERO) then goto 616;
   60: LYH:= 21;
   if (ISTATE=1) then NYH:= N;
   LWM:= LYH+(MAXORD+1)*NYH;
   JCO:= MAX(0, JSV);
   if (MITER=0) then LENWM:= 0;
   if (MITER=1)or(MITER=2) then
   begin
    LENWM:= 2+(1+JCO)*N*N;
    LOCJS:= N*N+3;
   end;
   if (MITER=3) then LENWM:= 2+N;
   if (MITER=4)or(MITER=5) then
   begin
    MBAND:= ML+MU+1;
    LENP:= (MBAND+ML)*N;
    LENJ:= MBAND*N;
    LENWM:= 2+LENP+JCO*LENJ;
    LOCJS:= LENP+3;
   end;
   LEWT:= LWM+LENWM;
   LSAVF:= LEWT+N;
   LACOR:= LSAVF+N;
   LENRW:= LACOR+N-1;
   IWORK[17]:= LENRW;
   LIWM:= 1;
   LENIW:= 30+N;
   if (MITER=0)or(MITER=3) then LENIW:= 30;
   IWORK[18]:= LENIW;
   if (LENRW>LRW) then goto 617;
   if (LENIW>LIW) then goto 618;
   RTOLI:= RTOL[1];
   ATOLI:= ATOL[1];
   for I:= 1 to N do {70}
   begin
    if (ITOL>=3) then
    begin
     RTOLI:= RTOL[I];
    end;
    if (ITOL=2)or(ITOL=4) then ATOLI:= ATOL[I];
    if (RTOLI<ZERO) then goto 619;
    if (ATOLI<ZERO) then goto 620;
   end;{70}
   if (ISTATE=1) then goto 100;
   JSTART:= -1;
   if (NQ<=MAXORD) then goto 90;
   DCOPY(N,RWORK[LWM], 1,    RWORK[LSAVF],  1);
   90: if (MITER>0) then RWORK[LWM]:= SQRT(UROUND);
   goto 200;
{C Block C.}
100:  UROUND:=D1MACH(4);
   TN:= T;
   if (ITASK<>4)and(ITASK<>5) then goto 110;
   TCRIT:= RWORK[1];
   if ((TCRIT-TOUT)*(TOUT-T)<ZERO) then goto 625;
   if (H0<>ZERO)and((T+H0-TCRIT)*H0>ZERO) then H0:= TCRIT-T;
   110: JSTART:= 0;
   if (MITER>0) then RWORK[LWM]:= SQRT(UROUND);
   CCMXJ:= PT2;
   MSBJ:= 50;
   NHNIL:= 0;
   NST:= 0;
   NJE:= 0;
   NNI:= 0;
   NCFN:= 0;
   NETF:= 0;
   NLU:= 0;
   NSLJ:= 0;
   NSLAST:= 0;
   HU:= ZERO;
   NQU:= 0;
   LF0:= LYH+NYH;
   F(N, T, Y[1], RWORK[LF0], RPAR[1], IPAR[1]);
   NFE:= 1;
   DCOPY(N,Y, 1,    RWORK[LYH],  1);
   NQ:= 1;
   H:= ONE;
   DEWSET(N, ITOL, RTOL, ATOL, RWORK[LYH], RWORK[LEWT]);
   for I:= 1 to N do {120}
   begin
    if (RWORK[I+LEWT-1]<=ZERO) then
    begin
     goto 621;
    end;
    RWORK[I+LEWT-1]:= ONE/RWORK[I+LEWT-1];
   end;{120}
   if (H0<>ZERO) then goto 180;
   DVHIN(N, T, RWORK[LYH], RWORK[LF0], F, RPAR, IPAR, TOUT, UROUND, RWORK[LEWT],
    ITOL, ATOL, Y, RWORK[LACOR], H0, NITER, IER);
   NFE:= NFE+NITER;
   if (IER<>0) then goto 622;
   180: RH:= ABS(H0)*HMXI;
   if (RH>ONE) then H0:= H0/RH;
   H:= H0;
   DSCAL(N,H0,RWORK[LF0], 1);
   goto 270;
{C Block D.}
   200: NSLAST:= NST;
   KUTH:= 0;
   if ITASK=1 then goto 210;
   if ITASK=2 then goto 250;
   if ITASK=3 then goto 220;
   if ITASK=4 then goto 230;
   if ITASK=5 then goto 240;
   210: if ((TN-TOUT)*H<ZERO) then
   begin
    goto 250;
   end;
   DVINDY(TOUT,0,RWORK[LYH],NYH,Y,IFLAG);
   if (IFLAG<>0) then goto 627;
   T:= TOUT;
   goto 420;
   220: TP:= TN-HU*(ONE+HUN*UROUND);
   if ((TP-TOUT)*H>ZERO) then goto 623;
   if ((TN-TOUT)*H<ZERO) then goto 250;
   goto 400;
   230: TCRIT:= RWORK[1];
   if ((TN-TCRIT)*H>ZERO) then goto 624;
   if ((TCRIT-TOUT)*H<ZERO) then goto 625;
   if ((TN-TOUT)*H<ZERO) then goto 245;
   DVINDY(TOUT,0,RWORK[LYH],NYH,Y,IFLAG);
   if (IFLAG<>0) then goto 627;
   T:= TOUT;
   goto 420;
   240: TCRIT:= RWORK[1];
   if ((TN-TCRIT)*H>ZERO) then goto 624;
   245: HMX:= ABS(TN)+ABS(H);
   IHIT:= ABS(TN-TCRIT)<=HUN*UROUND*HMX;
   if (IHIT) then goto 400;
   TNEXT:= TN+HNEW*(ONE+FOUR*UROUND);
   if ((TNEXT-TCRIT)*H<=ZERO) then goto 250;
   H:= (TCRIT-TN)*(ONE-FOUR*UROUND);
   KUTH:= 1;
{C Block E.}
   250: {CONTINUE};
   if ((NST-NSLAST)>=MXSTEP) then goto 500;
   DEWSET(N, ITOL, RTOL, ATOL, RWORK[LYH], RWORK[LEWT]);
   for I:= 1 to N do {260}
   begin
    if (RWORK[I+LEWT-1]<=ZERO) then
    begin
     goto 510;
    end;
//qq    RWORK[I+LEWT-1]:= ONE/RWORK[I+LEWT-1];
    if RWORK[I+LEWT-1]>1.0e-308 then
     RWORK[I+LEWT-1]:= ONE/RWORK[I+LEWT-1]
    else
     RWORK[I+LEWT-1]:= 1.0e308;
   end;{260}
   270: TOLSF:= UROUND*DVNORM(N, RWORK[LYH], RWORK[LEWT]);
   if (TOLSF<=ONE) then goto 280;
   TOLSF:= TOLSF*TWO;
   if (NST=0) then goto 626;
   goto 520;
   280: if ((TN+H)<>TN) then goto 290;
   NHNIL:= NHNIL+1;
   if (NHNIL>MXHNIL) then goto 290;
   MSG:= 'DVODE--  Warning..internal T (=R1) and H (=R2) are';
   XERRWD(MSG, 50, 101, 1, 0, 0, 0, 0, ZERO, ZERO);
   MSG:= '      such that in the machine, T + H = T on the next step  ';
   XERRWD(MSG, 60, 101, 1, 0, 0, 0, 0, ZERO, ZERO);
   MSG:= '      (H = step size). solver will continue anyway';
   XERRWD(MSG, 50, 101, 1, 0, 0, 0, 2, TN, H);
   if (NHNIL<MXHNIL) then goto 290;
   MSG:= 'DVODE--  Above warning has been issued I1 times.  ';
   XERRWD(MSG, 50, 102, 1, 0, 0, 0, 0, ZERO, ZERO);
   MSG:= '      it will not be issued again for this problem';
   XERRWD(MSG, 50, 102, 1, 1, MXHNIL, 0, 0, ZERO, ZERO);
   290: {CONTINUE};
// AddEu2
   Application.ProcessMessages;
   if AbortVODE then exit;
   DVSTEP(Y[1], RWORK[LYH], NYH, RWORK[LYH], RWORK[LEWT], RWORK[LSAVF], Y[1], RWORK[
    LACOR], RWORK[LWM], IWORK[LIWM], F, JAC, F, @DVNLSD, RPAR[1], IPAR[1]);
//qqqq   DVSTEP(Y, RWORK[LYH], NYH, RWORK[LYH], RWORK[LEWT], RWORK[LSAVF], Y, RWORK[
//    LACOR], RWORK[LWM], IWORK[LIWM], @F, JAC, @F, @DVNLSD, RPAR, IPAR);
   KGO:= 1-KFLAG;
   if KGO=1 then goto 300;
   if KGO=2 then goto 530;
   if KGO=3 then goto 540;
{C Block F.}
   300: INIT:= 1;
   KUTH:= 0;
   if ITASK=1 then goto 310;
   if ITASK=2 then goto 400;
   if ITASK=3 then goto 330;
   if ITASK=4 then goto 340;
   if ITASK=5 then goto 350;
   310: if ((TN-TOUT)*H<ZERO) then
   begin
    goto 250;
   end;
 DVINDY(TOUT,0,RWORK[LYH],NYH,Y,IFLAG);
   T:= TOUT;
   goto 420;
   330: if ((TN-TOUT)*H>=ZERO) then goto 400;
   goto 250;
   340: if ((TN-TOUT)*H<ZERO) then goto 345;
   DVINDY(TOUT,0,RWORK[LYH],NYH,Y,IFLAG);
   T:= TOUT;
   goto 420;
   345: HMX:= ABS(TN)+ABS(H);
   IHIT:= ABS(TN-TCRIT)<=HUN*UROUND*HMX;
   if (IHIT) then goto 400;
   TNEXT:= TN+HNEW*(ONE+FOUR*UROUND);
   if ((TNEXT-TCRIT)*H<=ZERO) then goto 250;
   H:= (TCRIT-TN)*(ONE-FOUR*UROUND);
   KUTH:= 1;
   goto 250;
   350: HMX:= ABS(TN)+ABS(H);
   IHIT:= ABS(TN-TCRIT)<=HUN*UROUND*HMX;
{C Block G.}
   400: {CONTINUE};
   DCOPY(N,RWORK[LYH], 1,  Y,   1 );
   T:= TN;
   if (ITASK<>4)and(ITASK<>5) then goto 420;
   if (IHIT) then T:= TCRIT;
   420: ISTATE:= 2;
   RWORK[11]:= HU;
   RWORK[12]:= HNEW;
   RWORK[13]:= TN;
   IWORK[11]:= NST;
   IWORK[12]:= NFE;
   IWORK[13]:= NJE;
   IWORK[14]:= NQU;
   IWORK[15]:= NEWQ;
   IWORK[19]:= NLU;
   IWORK[20]:= NNI;
   IWORK[21]:= NCFN;
   IWORK[22]:= NETF;
   EXIT;
{C Block H.}
{C The maximum number of steps was taken before reaching TOUT. ----------}
   500: MSG:= 'DVODE--  At current T (=R1), MXSTEP (=I1) steps   ';
   XERRWD(MSG, 50, 201, 1, 0, 0, 0, 0, ZERO, ZERO);
   MSG:= '      taken on this call before reaching TOUT     ';
   XERRWD(MSG, 50, 201, 1, 1, MXSTEP, 0, 1, TN, ZERO);
   ISTATE:= -1;
   goto 580;
{C EWT(i) .le. 0.0 for some i (not at start of problem). ----------------}
   510: EWTI:= RWORK[LEWT+I-1];
   MSG:= 'DVODE--  At T (=R1), EWT(I1) has become R2 .le. 0.';
   XERRWD(MSG, 50, 202, 1, 1, I, 0, 2, TN, EWTI);
   ISTATE:= -6;
   goto 580;
{C Too much accuracy requested for machine precision. -------------------}
   520: MSG:= 'DVODE--  At T (=R1), too much accuracy requested  ';
   XERRWD(MSG, 50, 203, 1, 0, 0, 0, 0, ZERO, ZERO);
   MSG:= '      for precision of machine..  see TOLSF (=R2) ';
   XERRWD(MSG, 50, 203, 1, 0, 0, 0, 2, TN, TOLSF);
   RWORK[14]:= TOLSF;
   ISTATE:= -2;
   goto 580;
{C KFLAG = -1.  Error test failed repeatedly or with ABS(H) = HMIN. -----}
   530: MSG:= 'DVODE--  At T(=R1) and step size H(=R2), the error';
   XERRWD(MSG, 50, 204, 1, 0, 0, 0, 0, ZERO, ZERO);
   MSG:= '      test failed repeatedly or with abs(H) = HMIN';
   XERRWD(MSG, 50, 204, 1, 0, 0, 0, 2, TN, H);
   ISTATE:= -4;
   goto 560;
{C KFLAG = -2.  Convergence failed repeatedly or with ABS(H) = HMIN. ----}
   540: MSG:= 'DVODE--  At T (=R1) and step size H (=R2), the    ';
   XERRWD(MSG, 50, 205, 1, 0, 0, 0, 0, ZERO, ZERO);
   MSG:= '      corrector convergence failed repeatedly     ';
   XERRWD(MSG, 50, 205, 1, 0, 0, 0, 0, ZERO, ZERO);
   MSG:= '      or with abs(H) = HMIN   ';
   XERRWD(MSG, 30, 205, 1, 0, 0, 0, 2, TN, H);
   ISTATE:= -5;
   560: BIG:= ZERO;
   IMXER:= 1;
   for I:= 1 to N do {570}
   begin
    SIZE:= ABS(RWORK[I+LACOR-1]*RWORK[I+LEWT-1]);
    if (BIG>=SIZE) then
    begin
     goto 570;
    end;
    BIG:= SIZE;
    IMXER:= I;
    570: {CONTINUE};
   end;{570}
   IWORK[16]:= IMXER;
{C Set Y vector, T, and optional output. --------------------------------}
   580: {CONTINUE};
   DCOPY(N,RWORK[LYH], 1,    Y,   1);
   T:= TN;
   RWORK[11]:= HU;
   RWORK[12]:= H;
   RWORK[13]:= TN;
   IWORK[11]:= NST;
   IWORK[12]:= NFE;
   IWORK[13]:= NJE;
   IWORK[14]:= NQU;
   IWORK[15]:= NQ;
   IWORK[19]:= NLU;
   IWORK[20]:= NNI;
   IWORK[21]:= NCFN;
   IWORK[22]:= NETF;
   EXIT;
{C Block I.}
{C The following block handles all error returns due to illegal input}
   601: MSG:= 'DVODE--  ISTATE (=I1) illegal ';
   XERRWD(MSG, 30, 1, 1, 1, ISTATE, 0, 0, ZERO, ZERO);
   if (ISTATE<0) then goto 800;
   goto 700;
   602: MSG:= 'DVODE--  ITASK (=I1) illegal  ';
   XERRWD(MSG, 30, 2, 1, 1, ITASK, 0, 0, ZERO, ZERO);
   goto 700;
   603: MSG:= 'DVODE--  ISTATE (=I1) .gt. 1 but DVODE not initialized      ';
   XERRWD(MSG, 60, 3, 1, 1, ISTATE, 0, 0, ZERO, ZERO);
   goto 700;
   604: MSG:= 'DVODE--  NEQ (=I1) .lt. 1     ';
   XERRWD(MSG, 30, 4, 1, 1, NEQ, 0, 0, ZERO, ZERO);
   goto 700;
   605: MSG:= 'DVODE--  ISTATE = 3 and NEQ increased (I1 to I2)  ';
   XERRWD(MSG, 50, 5, 1, 2, N, NEQ, 0, ZERO, ZERO);
   goto 700;
   606: MSG:= 'DVODE--  ITOL (=I1) illegal   ';
   XERRWD(MSG, 30, 6, 1, 1, ITOL, 0, 0, ZERO, ZERO);
   goto 700;
   607: MSG:= 'DVODE--  IOPT (=I1) illegal   ';
   XERRWD(MSG, 30, 7, 1, 1, IOPT, 0, 0, ZERO, ZERO);
   goto 700;
   608: MSG:= 'DVODE--  MF (=I1) illegal     ';
   XERRWD(MSG, 30, 8, 1, 1, MF, 0, 0, ZERO, ZERO);
   goto 700;
   609: MSG:= 'DVODE--  ML (=I1) illegal.. .lt.0 or .ge.NEQ (=I2)';
   XERRWD(MSG, 50, 9, 1, 2, ML, NEQ, 0, ZERO, ZERO);
   goto 700;
   610: MSG:= 'DVODE--  MU (=I1) illegal.. .lt.0 or .ge.NEQ (=I2)';
   XERRWD(MSG, 50, 10, 1, 2, MU, NEQ, 0, ZERO, ZERO);
   goto 700;
   611: MSG:= 'DVODE--  MAXORD (=I1) .lt. 0  ';
   XERRWD(MSG, 30, 11, 1, 1, MAXORD, 0, 0, ZERO, ZERO);
   goto 700;
   612: MSG:= 'DVODE--  MXSTEP (=I1) .lt. 0  ';
   XERRWD(MSG, 30, 12, 1, 1, MXSTEP, 0, 0, ZERO, ZERO);
   goto 700;
   613: MSG:= 'DVODE--  MXHNIL (=I1) .lt. 0  ';
   XERRWD(MSG, 30, 13, 1, 1, MXHNIL, 0, 0, ZERO, ZERO);
   goto 700;
   614: MSG:= 'DVODE--  TOUT (=R1) behind T (=R2)      ';
   XERRWD(MSG, 40, 14, 1, 0, 0, 0, 2, TOUT, T);
   MSG:= '      integration direction is given by H0 (=R1)  ';
   XERRWD(MSG, 50, 14, 1, 0, 0, 0, 1, H0, ZERO);
   goto 700;
   615: MSG:= 'DVODE--  HMAX (=R1) .lt. 0.0  ';
   XERRWD(MSG, 30, 15, 1, 0, 0, 0, 1, HMAX, ZERO);
   goto 700;
   616: MSG:= 'DVODE--  HMIN (=R1) .lt. 0.0  ';
   XERRWD(MSG, 30, 16, 1, 0, 0, 0, 1, HMIN, ZERO);
   goto 700;
   617: {CONTINUE};
   MSG:= 'DVODE--  RWORK length needed, LENRW (=I1), exceeds LRW (=I2)';
   XERRWD(MSG, 60, 17, 1, 2, LENRW, LRW, 0, ZERO, ZERO);
   goto 700;
   618: {CONTINUE};
   MSG:= 'DVODE--  IWORK length needed, LENIW (=I1), exceeds LIW (=I2)';
   XERRWD(MSG, 60, 18, 1, 2, LENIW, LIW, 0, ZERO, ZERO);
   goto 700;
   619: MSG:= 'DVODE--  RTOL(I1) is R1 .lt. 0.0        ';
   XERRWD(MSG, 40, 19, 1, 1, I, 0, 1, RTOLI, ZERO);
   goto 700;
   620: MSG:= 'DVODE--  ATOL(I1) is R1 .lt. 0.0        ';
   XERRWD(MSG, 40, 20, 1, 1, I, 0, 1, ATOLI, ZERO);
   goto 700;
   621: EWTI:= RWORK[LEWT+I-1];
   MSG:= 'DVODE--  EWT(I1) is R1 .le. 0.0         ';
   XERRWD(MSG, 40, 21, 1, 1, I, 0, 1, EWTI, ZERO);
   goto 700;
   622: {CONTINUE};
   MSG:= 'DVODE--  TOUT (=R1) too close to T(=R2) to start integration';
   XERRWD(MSG, 60, 22, 1, 0, 0, 0, 2, TOUT, T);
   goto 700;
   623: {CONTINUE};
   MSG:= 'DVODE--  ITASK = I1 and TOUT (=R1) behind TCUR - HU (= R2)  ';
   XERRWD(MSG, 60, 23, 1, 1, ITASK, 0, 2, TOUT, TP);
   goto 700;
   624: {CONTINUE};
   MSG:= 'DVODE--  ITASK = 4 or 5 and TCRIT (=R1) behind TCUR (=R2)   ';
   XERRWD(MSG, 60, 24, 1, 0, 0, 0, 2, TCRIT, TN);
   goto 700;
   625: {CONTINUE};
   MSG:= 'DVODE--  ITASK = 4 or 5 and TCRIT (=R1) behind TOUT (=R2)   ';
   XERRWD(MSG, 60, 25, 1, 0, 0, 0, 2, TCRIT, TOUT);
   goto 700;
   626: MSG:= 'DVODE--  At start of problem, too much accuracy   ';
   XERRWD(MSG, 50, 26, 1, 0, 0, 0, 0, ZERO, ZERO);
   MSG:= '      requested for precision of machine..  see TOLSF (=R1) ';
   XERRWD(MSG, 60, 26, 1, 0, 0, 0, 1, TOLSF, ZERO);                                
   RWORK[14]:= TOLSF;
   goto 700;
   627: MSG:= 'DVODE--  Trouble from DVINDY.  ITASK = I1, TOUT = R1.       ';
   XERRWD(MSG, 60, 27, 1, 1, ITASK, 0, 1, TOUT, ZERO);
   700: {CONTINUE};
   ISTATE:= -3;
   EXIT;
   800: MSG:= 'DVODE--  Run aborted.. apparent infinite loop     ';
   XERRWD(MSG, 50, 303, 2, 0, 0, 0, 0, ZERO, ZERO);
   EXIT;
  end;{with common blocks do}
end;

{========== End of converted DVODE.FOR ==========}

{ TVodeSolver }

constructor TVodeSolver.Create;
begin
 // Set arrays
end;

procedure TVodeSolver.dfdy(const NEQ: integertype; var T, Y_: realtype;
  var ML, MU: integertype; var PD_: realtype; var NRPD: integertype;
  var RPAR: realtype; var IPAR: integertype);
begin
 MessageDlg('TVodeSolver.dfdy-call overriden !', mtError, [mbOK], 0);
end;

procedure TVodeSolver.dydt(const NEQ: integertype; var T, Y_, YDOT_,
  RPAR_: realtype; var IPAR_: integertype);
begin
 MessageDlg('TVodeSolver.dydt-call overriden !', mtError, [mbOK], 0);
end;

initialization
 StdOut:= TStringList.Create;
end.

