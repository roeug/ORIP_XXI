unit LSODA4cc;
// LSODA reconstructed for ChainCalculator
// The same as original but has pointer to OBJECT function - TChainCalculator.DoChainCalc
{ Routines painfully converted from 'C' BLAS routines }
{ H M Sauro, December 1996 }

interface

uses Classes, SysUtils, EuLib;
//type
//  Float=double;

{Unit Vector}

{ Implements dynamic vector type, integer and Double, Summer 1996 H M Sauro
  Copyright 1996/97 Future Skill Software }

// September 1997

{ Available functions for Double vector:

        EnlargeBy       Enlarge vector by n elements
        ReduceBy        Reduce vector by n elements
        Enlarge         Enlarge by one element (top element)
        Reduce          Reduce by one element (top element)
        Zero            Set all elemenets to 0.0
        Clear           Same as Zero
        Size            Get size of vector
        Assign          Assigns one vector to another (Copy function)
        Add, Sub        Add or subract two vectors to give Self
        Dot             Form the dot product
        CrossU          Form the cross product (self overwritten)
        Cross           Form the cross product
        Sum             Form sum of elements
        Mean            Form mean of elements
        SumofSquares    Form sum of squares of elements
        StdDev          Form sample standard deviation
        Scale           Scale vector by factor }

{ Example of use:

  v : TVector;

  v := TVector.Create (5);
  for i := 1 to 5 do v[i] := i*2.3;
  m := v.mean;
  v.free; }
const
 MaxIniVectorSize=1000;
type
 EVectorSizeError=class(Exception);
 
     { The MaxIniVectorSize in the array types below does not impose a limit a runtime!
     If you compile with range checking on then the compiled code will impose
     an effective limit of MaxIniVectorSize, but with range checking off the size of
     vector is limited to 64K under 16bit OS or *much* greater under 32bit OS }
 TArrayd=array[1..MaxIniVectorSize] of Double; pTArrayd=^TArrayd;
 TArrayi=array[1..MaxIniVectorSize] of integer; pTArrayi=^TArrayi;
 
     { Define a dynamic array type for holding integers }
 TVectori=class(TObject)
 private
  s: integer; { size of vector }
  vx: pTArrayi; { pointer to the data }
 private
  procedure SetSize(NewSize: integer);
 public
  constructor create(i: integer); virtual;
  constructor CreateFromLongIntList(const Src: TLongIntList);
  destructor destroy; override;
  procedure EnlargeBy(n: integer);
  procedure ReduceBy(n: integer);
  procedure Enlarge;
  procedure Reduce;
  procedure Zero;
  procedure Clear;
  procedure Assign(v: TVectori);
  procedure Setval(i: integer; v: integer);
  function Getval(ii: integer): integer;
  function GetSize: integer;
  property Elem[x: Integer]: integer read GetVal write SetVal; default;
  property Size: integer read s;
 end;
 
     { Define a dynamic array type for holding Doubles }
 TVector=class(TObject)
 private
  s: integer; { size of vector }
  vx: pTArrayd; { pointer to the data }
  Tmp: boolean; { set to true if temporary }
 public
                   { Declare as a class method, saves having a self variable }
  class function Dot(u, v: TVector): Double;

  constructor CreateFromFloatList(const Src: TFloatList);
  constructor create(i: integer); virtual;
  constructor createTmp(i: integer);
  destructor destroy; override;
  procedure FreeSpace;
  procedure SetSize(i: integer);
  procedure EnlargeBy(n: integer);
  procedure ReduceBy(n: integer);
  procedure Enlarge;
  procedure Reduce;
  procedure Zero;
  procedure Clear;
  procedure Setval(i: integer; v: Double);
  function Getval(ii: integer): Double;
  property Elem[x: Integer]: Double read GetVal write SetVal; default;
  property Size: integer read s;
  procedure Assign(v: TVector);
  function Add(v, u: TVector): TVector;
  function Sub(v, u: TVector): TVector;
  class function xAdd(v, u: TVector): TVector;
  class function xSub(v, u: TVector): TVector;
  function DotU(v: TVector): Double;
  function CrossU(v: TVector): TVector;
  function Cross(v1, v2: TVector): TVector;
  function Sum: Double;
  function Mean: Double;
  function SumofSquares: Double;
  function StdDev: Double;
  procedure Scale(factor: Double);
 end;
{Unit Mat}
const
 MaxIniMatrixSize=50000; // Eu was 5000
type
 EMatrixError=class(Exception);
 EMatrixSizeError=class(EMatrixError);
 ESingularMatrix=class(EMatrixError);
 ENonSquareMatrix=class(EMatrixError);
 
 TMatError=(Singular, NonSingular, NonSquare);
 
 TMatElement=Double;
 
     { A Matrix is made up of a set of rows of type TRow, pTRow is
     a pointer to a single row and a matrix is a row of pTRows, this
     allows arrays larger then 65K to be built, the max size of
     a matrix is roughly 4096 MBytes }
 
 TRow=array[0..MaxIniMatrixSize] of TMatElement; pTRow=^TRow;
 
     { The TRows are collected together into a RowList }
 TRowList=array[0..MaxIniMatrixSize] of pTRow;
 
     { Finally, pTRowList points to a RowList }
 pTRowList=^TRowList;
 
     { forward declare the Matrix class }
 TMatrix=class;
 
     { Used by svdfit, supplies basis functions at x }
 BasisProc=procedure(x: TMatElement; var BasisFunc: TVector);
 
     { Define a dynamic matrix type for holding Doubles }
 TMatrix=class(TObject)
 private
  nr, nc: integer;
  mx: pTRowList; { pointer to a list of rows }
  FRowNames, FColumnNames: TStringList;
  procedure SetSize(ri, ci: integer);
  procedure FreeSpace;
 public
  constructor create(r, c: integer); virtual;
  constructor createI(n: integer); virtual;
  constructor createLit(c: integer; d: array of TMatElement); virtual;
  destructor destroy; override;
  procedure CreateNameLists(ri, ci: integer);
  procedure DestroyNameLists;
  procedure Setval(ri, ci: integer; v: TMatElement);
  function Getval(ri, ci: integer): TMatElement;
  property M[x, y: Integer]: TMatElement read GetVal write SetVal; default;

  procedure SetRowName(ri: integer; name: string);
  function GetRowName(ri: integer): string;

  procedure SetColumnName(ci: integer; name: string);
  function GetColumnName(ci: integer): string;

  property rName[ri: integer]: string read GetRowName write SetRowname;
  property cName[ci: integer]: string read GetColumnName write SetColumnname;

  property r: integer read nr;
  property c: integer read nc;
  function IsSquare(m: TMatrix): boolean;
  function SameDimensions(m1, m2: TMatrix): boolean;
  procedure AddRow;
  function Identity: TMatrix;
  function Diagonal(k: TMatElement): TMatrix;
  function DiagonalV(v: TVector): TMatrix;
  function Zero: TMatrix;
  function L(ci: integer; d: array of TMatElement): TMatrix;
  function transposeSelf: TMatrix;
  function transpose(m: TMatrix): TMatrix;
  function add(m1, m2: TMatrix): TMatrix;
  function addU(m: TMatrix): TMatrix;
  function sub(m1, m2: TMatrix): TMatrix;
  function subU(m: TMatrix): TMatrix;
  function multk(m: TMatrix; k: TMatElement): TMatrix;
  function multkU(k: TMatElement): TMatrix;
  function mult(m1, m2: TMatrix): TMatrix;
  function copy(m: TMatrix): TMatrix;
  procedure ExtractColumn(var v: TVector; cc: integer);
  procedure ExtractRow(var v: TVector; rr: integer);
  function ExchangeRows(r1, r2: integer): TMatrix;
  function ExchangeCols(c1, c2: integer): TMatrix;
  function Rank(echelon: TMatrix; eps: Double): integer;
  procedure Invert(inv: TMatrix);
  procedure InvertSelf;
  procedure SolveLinear(v, b: TVector; SelfToInv: boolean);
  procedure LUSolve(index: TVectori; b: TVector);
  procedure LUDecomp(m: TMatrix; index: TVectori);
  function Det: Double;
  procedure NullSpace(NullVectors: TMatrix; var BasisSize: integer;
   Echelon: TMatrix; var TheRank: integer);

  procedure svd(var u: TMatrix; var w: TVector; var v: TMatrix);
  procedure svd2(var u: TMatrix; var w: TVector; var v: TMatrix);
  procedure svdSolve(var u: TMatrix; var w: TVector; var v: TMatrix;
   b: TVector; var x: TVector);
  function svdfit(x, y, yerr: TVector; var fit: TVector;
   var u, v: TMatrix; var w: TVector; funcs: BasisProc): TMatElement;
  procedure svdCovar(v: TMatrix; w: TVector; alpha: TMatrix);
 end;
 
{ ------------------------------------------------------------------------- }
 
{Unit Lsodamat}
procedure LUfactor(a: TMatrix; pivots: TVectori);
procedure LUsolve(a: TMatrix; pivots: TVectori; b: TVector);

{unit adamsbdf.pas}

{ Lsoda differential equation solver Delphied. H M Sauro Dec 1996

  Original Pascal translation by Joao Pedro Monij-Barreto and Ronny Shuster.
  Original FORTRAN (version march30, 1987) to C translation by

  From tam@dragonfly.wri.com Wed Apr 24 01:35:52 1991
  Return-Path: <tam>
  Date: Wed, 24 Apr 91 03:35:24 CDT
  From: tam@dragonfly.wri.com
  To: whitbeck@wheeler.wrc.unr.edu
  Subject: lsoda.c
  Cc: augenbau@sparc0.brc.uconn.edu

  I'm told by Steve Nichols at Georgia Tech that you are interested in
  a stiff integrator.  Here's a translation of the fortran code LSODA.

  Please note that there is no comment.  The interface is the same as the FORTRAN
  code and I believe the documentation in LSODA will suffice.
  As usual, a free software comes with no guarantee.

  Hon Wah Tam
  Wolfram Research, Inc.
  tam@wri.com

  I have done some additions to lsoda.c . These were mainly to fill the
  gap of some features that were available in the fortran code and were
  missing in the C version.

  Changes are: all messages printed by lsoda routines will start with
  a '\n' (instead of ending with one); xsetf() was added so that user
  can control printing of messages by lsoda. xsetf should be called before
  calling lsoda: xsetf(0) switches printing off xsetf(1) swithces printing
  on (default) this implies one new global variable prfl (print flag).
  xsetf(0) will stop *any* printing by lsoda functions.
  Turning printing off means losing valuable information but will not scramble
  your stderr output ;-) This function is part of the original FORTRAN version.
  xsetf() and intdy() are now callable from outside the library as assumed
  in the FORTRAN version; created lsoda.h that should be included in blocks
  calling functions in lsoda's library.  iwork5 can now have an extra value:
  0 - no extra printing (default), 1 - print data on each method switch,
  ->  2 - print useful information at *each* stoda  step (one lsoda call
  has performs many stoda calls) and also data on each method switch
  note that a xsetf(0) call will prevent any printing even if iwork5 > 0;
  hu, tn were made available as extern variables.
  eMail:      INTERNET: prm@aber.ac.uk
  Pedro Mendes, Dept. of Biological Sciences, University College of Wales,
  Aberystwyth, Dyfed, SY23 3DA, United Kingdom.

  Further minor changes: 10 June 1992 by H Sauro and Pedro Mendes  }

  { This version in a Delphi compatible object by H M Sauro Dec 1996   }
  { -------------------------------------------------------------------------- }

  { Quick usage instructions:

  1. Create Lsoda object specifying dimension of problem
  2. Initialise rtol and atol arrays (error tolerances, relative and absolute)
  3. Initialise t and tout (t = initial val, tout = requested solution point)
  4. Set itol to 4
  5. Set itask to 1, indicating normal computation
  6. Set istart to 1, indicating first call to lsoda
  7. Set iopt = 0 for no optional inputs
  8. jt = 2 for internal evaluation of jacobian
  9. Call Setfcn (fcn) to install your dydt routine
  10. Call lsoda (y, t, tout) to perfom one iteration }

  { See lsoda.doc for further details of interface. There may be further changes to
  this source in the future. The object interface is not neat enough yet, but it
  does work, see included example. Also xome works needs to be done to the body }

  { Note on TVector. TVector implements a dynamic array type of Doubles. Use
  v := TVector.Create (10) to create 10 element array. Access data via v[i].
  v.size returns number of elements in vector. See vector.pas for more details }

  { Note on TMat. TMat is a simple matrix object type which serves a similar role
  to TVector except of course TMatrix is a 2D version }

  { LsodaMat includes two routines for doing LU decomposition and backward-
  substitution, painfully translated from FORTRAN code, couldn't use my own coz'
  I think LSODA requires particular structure to LU result. These routines use a
  TVectori type (included with vector.pas) which simply handles dynamics arrays of
  integers }

  { Note to FORTRAN coders: please stop playing 'neat' tricks with arrays, it make
  translating decent algorithms written in FORTRAN a hellish experience! }
type
 ELsodaException=class(Exception);
 
    { This is the type for the dydt function }
 fcnProc=procedure(t: Double; y, dydt: TVector) of object;
 
 TErrorType=(eNone, eDerivative, eBuildAlphaBeta, eChiSqr, eDelta,
  eNormalisation, eMatrixInversion, ePoorConvergence);
 
 vector13=array[1..13] of Double; { Used in declaring pc in cfode }
    {mat1314  = array [1..13,1..14] of Double;
    mat134   = array [1..13,1..4] of Double;
    vec14    = array[1..14] of Float;
    vec6     = array[1..6] of Double;
    mat12ne  = array[1..13] of TVector;}
 
 TLsoda=class(TObject)
 private
// EuAdd 2
  neq: integer; { # of first-order odes }
  fAborted: Boolean;
  tn, h, hu, tsw, tolsf: Double;
//  nje, nfe, prfl, nq, nqu, meth, mused, nst, imxer: integer; // EuConvert prfl->Fprfl
  nje, nfe, Fprfl, nq, nqu, meth, mused, nst, imxer: integer;

                     { static variables for lsoda() }
  ccmax, el0, hmin, hmxi, rc, pdnorm: Double;
  illin, init, mxstep, mxhnil, nhnil, ntrep,
   nslast, nyh, ierpj, iersl, jcur, jstart, kflag, l,
   miter, maxord, maxcor, msbp, mxncf, n,
   ixpr, jtyp, mxordn, mxords: integer;
                     { non-static variable for prja(), solsy() }
                     { static variables for stoda() }
  conit, crate, hold, rmax, pdest, pdlast, ratio: Double;
  elco, tesco: TMatrix;
  ialth, ipup, lmax, meo, nslp, icount, irflag: integer;
  cm1, cm2, el: TVector;
                     { static variables for various vectors and the Jacobian. }
  yh: array[1..13] of TVector;
  wm: TMatrix;
  perm: TVectori; { Permuation vector for LU decomp }
  ewt, savf, acor: TVector;
  sqrteta: Double; { sqrt (ETA) }
  Frtol, Fatol: TVector;
  Fitol, Fitask, Fistate, Fiopt, Fjt, Fiwork5, Fiwork6: integer;
  Fiwork7, Fiwork8, Fiwork9: integer;
  Frwork1, Frwork5, Frwork6, Frwork7: Double;
  FDerivatives: fcnProc;
  procedure DummyFcn(t: Double; y, dydt: TVector);
  procedure terminate(var istate: integer);
  procedure terminate2(var y: TVector; var t: Double);
  procedure successreturn(var y: TVector; var t: Double;
   itask, ihit: integer; tcrit: Double; var istate: integer);
  procedure ewset(itol: integer; rtol, atol, ycur: TVector);
  procedure prja(neq: integer; var y: TVector);
  procedure corfailure(var told, rh: Double; var ncf, corflag: integer);
  procedure solsy(var y: TVector);
  procedure methodswitch(dsm, pnorm: Double; var pdh, rh: Double);
  procedure endstoda;
  procedure orderswitch(var rhup: Double; dsm: Double; var pdh, rh: Double;
   var orderflag: integer);
  procedure resetcoeff;
  procedure correction(neq: integer; var y: TVector; var corflag: integer;
   pnorm: Double; var del, delp, told: Double;
   var ncf: integer; var rh: Double; var m: integer);
  procedure intdy(t: Double; k: integer; var dky: TVector; var iflag: integer);
  procedure cfode(meth: integer);
  procedure scaleh(var rh, pdh: Double);
  procedure stoda(var neq: integer; var y: TVector);
  function Getrtol(i: integer): Double;
  procedure Setrtol(i: integer; d: Double);
  function Getatol(i: integer): Double;
  procedure Setatol(i: integer; d: Double);
 public
// EuAdd 3
  property Aborted: Boolean read fAborted write fAborted;
  property prfl: integer read Fprfl write Fprfl;
  property NumberOfEquation: integer read neq;
  constructor Create(n: integer); virtual;
  destructor destroy; override;
  procedure Setfcn(fcn: fcnProc);
                     { y = array of initial values of variables. t = initial value of
                     independent variable, tout, value of t when output is required.
                     On output, y holds new values of variables and t updated to tout }
  procedure Execute(var y: TVector; var t, tout: Double);

  property rtol[i: Integer]: Double read Getrtol write Setrtol;
  property atol[i: Integer]: Double read Getatol write Setatol;
  property itol: integer read Fitol write Fitol;
  property itask: integer read Fitask write Fitask;
  property istate: integer read Fistate write Fistate;
  property iopt: integer read Fiopt write Fiopt;
  property jt: integer read Fjt write Fjt;
  property iwork5: integer read Fiwork5 write Fiwork5;
  property iwork6: integer read Fiwork6 write Fiwork6;
  property iwork7: integer read Fiwork7 write Fiwork7;
  property iwork8: integer read Fiwork8 write Fiwork8;
  property iwork9: integer read Fiwork9 write Fiwork9;
  property rwork1: Double read Frwork1 write Frwork1;
  property rwork5: Double read Frwork5 write Frwork5;
  property rwork6: Double read Frwork6 write Frwork6;
  property rwork7: Double read Frwork7 write Frwork7;
// AddEu 1
  property istart: integer read jstart write jstart; // 0-first
 end;
{ ------------------------------------------------------------------------- }
// EuAdd 1
var
 StdOut: TStringList;
 
implementation
// EuAdd 1
uses Forms;
{Unit Vector.pas}
{ ------------------------------------------------------------------------- }
{                         START OF VECTOR TYPE IMPLEMETATION                }
{ ------------------------------------------------------------------------- }
{ The data space which holds the data for a vector is typed as [1..x] so that
indexing autmatically starts at one, therefore there is no need in the
following code to add 1 to the size of the vector when creating or destroying it }

{ Create a vector of size i }

constructor TVector.CreateFromFloatList(const Src: TFloatList);
var
 I: integer;
begin
 Create(Src.Count);
 for I:= 1 to Self.Size do
  Self[I]:= Src[I-1];
end;

constructor TVector.create(i: integer);
begin
 inherited Create;
 s:= 0; vx:= nil; { vx set to Nil to indicate empty vector, used by SetSize }
 if i>0 then Self.SetSize(i);
end;

constructor TVector.createTmp(i: integer);
begin
 inherited Create;
 s:= 0; vx:= nil; { vx set to Nil to indicate empty vector, used by SetSize }
 if i>0 then Self.SetSize(i);
 Tmp:= true;
end;

destructor TVector.destroy;
begin
 FreeSpace;
 inherited Destroy;
end;

{ Private internal procedure }

procedure TVector.FreeSpace;
begin
 if vx<>nil then
  if Self.s>0 then
  try
//   Finalize(vx);
   FreeMem(vx, sizeof(Double)*Self.s);
  finally
   Self.s:= 0;
   vx:= nil;
  end;
end;

{ Internal routine to allocate space. If space already exists then it frees it first }

procedure TVector.SetSize(i: integer);
begin
 if vx<>nil then FreeMem(vx, sizeof(Double)*s);
 s:= i; vx:= AllocMem(sizeof(Double)*s);
end;

{ Increase the size of the vector without destroying and existing data }

procedure TVector.EnLargeBy(n: integer);
begin
 if n<0 then raise EVectorSizeError.Create('Argument to EnLargeBy must be positive');
 ReAllocMem(vx, sizeof(Double)*(s+n)); inc(s, n); { Modified for D2 }
end;

{ Reduce the size of the vector }

procedure TVector.ReduceBy(n: integer);
begin
 if n>=s then
  raise EVectorSizeError.Create('Can''t reduce size of vector to below zero elements');
 ReAllocMem(vx, sizeof(Double)*(s-n)); dec(s, n); { modified for D2 }
end;

{ Enlarge the vector by one element without destroying any existing data }

procedure TVector.Enlarge;
begin
 ReAllocMem(vx, sizeof(Double)*(s+1)); inc(s); { Modified for D2 }
end;

{ Reduce the vector by one element, the top most element is destroyed }

procedure TVector.Reduce;
begin
 ReAllocMem(vx, sizeof(Double)*(s-1)); dec(s); { Modified for D2 }
end;

{ Clears the vector, sets all elements to zero }

procedure TVector.Zero;
var
 i: integer;
begin
 for i:= 1 to s do vx^[i]:= 0.0;
end;

{ Clears the vector, sets all elements to zero }

procedure TVector.Clear;
begin
 Zero;
end;

{ used internally but is also accessible from the outside }

procedure TVector.Setval(i: integer; v: Double);
begin
 vx^[i]:= v;
end;

{ used internally but is also accessible from the outside }

function TVector.Getval(ii: integer): Double;
begin
 result:= vx^[ii]
end;

{ Copies vector v to self. If self is not the same size as v then self is resized
  Usage: u.Assign (v) }

procedure TVector.Assign(v: TVector);
begin
 v.Tmp:= false; { just in case its a temporary variable }
 if v.s<>Self.s then Self.SetSize(v.s);
 move(v.vx^, Self.vx^, sizeof(Double)*s)
end;

{ Add the vectors, 'v' and 'u' together to produce Self. Error if v and u are not
the same size. If Self is not sized correctly, then Add will resize Self }

function TVector.Add(v, u: TVector): TVector;
var
 i: integer;
begin
 if v.s<>u.s then raise EVectorSizeError.Create('Vectors must be the same size to sum them');
 if Self.s<>v.s then Self.SetSize(v.s);
 for i:= 1 to v.s do Self[i]:= v[i]+u[i];
 if v.tmp then v.free; if u.tmp then u.free;
 result:= Self;
end;

class function TVector.xAdd(v, u: TVector): TVector;
var
 i: integer; t: TVector;
begin
 if v.s<>u.s then raise EVectorSizeError.Create('Vectors must be the same size to sum them');
 t:= TVector.CreateTmp(v.s);
 for i:= 1 to v.s do t[i]:= v[i]+u[i];
 result:= t;
end;

{ Subtract the vectors, 'v' and 'u' together to produce Self. Error if v and u are not
the same size. If Self is not sized correctly, then Subtract will resize Self }

function TVector.Sub(v, u: TVector): TVector;
var
 i: integer;
begin
 if v.s<>u.s then raise EVectorSizeError.Create('Vectors must be the same size to subtract them');
 if Self.s<>v.s then Self.SetSize(v.s);
 for i:= 1 to v.s do Self[i]:= v[i]-u[i];
 if v.tmp then v.free; if u.tmp then u.free;
 result:= Self;
end;

class function TVector.xSub(v, u: TVector): TVector;
var
 i: integer; t: TVector;
begin
 if v.s<>u.s then raise EVectorSizeError.Create('Vectors must be the same size to subtract them');
 t:= TVector.CreateTmp(v.s);
 for i:= 1 to v.s do t[i]:= v[i]-u[i];
 result:= t;
end;

{ Compute the dot product of vectors 'u' and 'v' Usage: d := dot (u, v); }

class function TVector.Dot(u, v: TVector): Double;
var
 i: integer;
begin
 if u.Size<>v.Size then
  raise EVectorSizeError.Create('Vectors must be of the same size to compute dot product');
 result:= 0.0;
 for i:= 1 to u.Size do result:= result+u[i]*v[i];
end;

{ Apply a dot product to Self and arg, 'v' Usage: d := u.dotU (v); }

function TVector.DotU(v: TVector): Double;
var
 i: integer;
begin
 if Self.Size<>v.Size then
  raise EVectorSizeError.Create('Vectors must be of the same size to compute dot product');
 result:= 0.0;
 for i:= 1 to Self.Size do
  result:= result+Self[i]*v[i];
end;

{ compute the cross product of Self and vector 'v', replacing Self
  Usage: v.CrossU (u) }

function TVector.CrossU(v: TVector): TVector;
begin
 if (v.Size=3)and(Self.Size=3) then
 begin
  Self[1]:= Self[2]*v[3]-Self[3]*v[2];
  Self[2]:= Self[3]*v[1]-Self[1]*v[3];
  Self[3]:= Self[1]*v[2]-Self[2]*v[1];
  result:= Self;
 end
 else
  raise EVectorSizeError.Create('Cross product can only be calculated for vectors in 3D');
end;

{ compute the cross product of 'v1' and vector 'v2' giving Self
  Usage: v.Cross (v1, v2) }

function TVector.Cross(v1, v2: TVector): TVector;
begin
 if (v1.Size=3)and(v2.Size=3)and(Self.Size=3) then
 begin
  Self[1]:= v1[2]*v2[3]-v1[3]*v2[2];
  Self[2]:= v1[3]*v2[1]-v1[1]*v2[3];
  Self[3]:= v1[1]*v2[2]-v1[2]*v2[1];
  result:= Self;
 end
 else
  raise EVectorSizeError.Create('Cross product can only be calculated for vectors in 3D');
end;

{ Returns the sum of values in the vector
  Usage: total := v.sum }

function TVector.Sum: Double;
var
 i: integer;
begin
 result:= 0.0;
 for i:= 1 to s do result:= result+vx^[i];
end;

{ Returns the mean of the elements of the vector
  Usage: average := v.mean;  }

function TVector.Mean: Double;
begin
 if s>0 then result:= sum/s
 else result:= 1E-13; //EuAdd
end;

{ Returns the sum of the squares of values in Data
  Usage: s := v.SumOfSquares; }

function TVector.SumOfSquares: Double;
var
 i: integer;
begin
 result:= 0.0;
 for i:= 1 to s do result:= result+sqr(vx^[i]);
end;

{ Returns the sample standard deviation
  Usage: sd := v.StdDev; }

function TVector.StdDev: Double;
var
 sq, total: Double; i: integer;
begin
 sq:= 0; total:= 0;
 if s>0 then
 begin
  for i:= 1 to s do
  begin sq:= sq+sqr(vx^[i]); total:= total+vx^[i]; end;
  result:= sqrt((sq-sqr(total)/s)/(s-1));
     {Easier to read but slightly slower:
     result := sqrt ((SumOfSquares - sqr (sum)/s)/(s-1));}
 end
 else result:= 1E-13; //EuAdd
end;

{ Scale the vector by factor
  Usage: v.Scale (2)   Mults all elements by 2 }

procedure TVector.Scale(factor: Double);
var
 i: integer;
begin
 for i:= 1 to s do vx^[i]:= vx^[i]*factor;
end;

{ ------------------------------------------------------------------------- }
{                         START OF INTEGER VECTOR IMPLEMETATION             }
{ ------------------------------------------------------------------------- }

{ Create a vector of size i }

constructor TVectori.CreateFromLongIntList(const Src: TLongIntList);
var
 I: integer;
begin
 Create(Src.Count);
 for I:= 1 to Self.Size do
  Self[I]:= Src[I-1];
end;

constructor TVectori.create(i: integer);
begin
 inherited Create; vx:= nil;
 Self.SetSize(i);
end;

destructor TVectori.destroy;
begin
 if vx<>nil then FreeMem(vx, sizeof(integer)*s);
 inherited Destroy;
end;

{ Internal routine used by define }

procedure TVectori.SetSize(NewSize: integer);
begin
 if vx<>nil then FreeMem(vx, sizeof(integer)*s);
 s:= NewSize; vx:= AllocMem(sizeof(integer)*NewSize);
end;

procedure TVectori.EnLargeBy(n: integer);
begin
 ReAllocMem(vx, sizeof(integer)*(s+n)); inc(s, n); { Modified for D2 }
end;

procedure TVectori.ReduceBy(n: integer);
begin
 if n>=s then
  raise EVectorSizeError.Create('Can''t reduce size of vector to below zero elements');
 ReAllocMem(vx, sizeof(integer)*(s-n)); dec(s, n); { Modified for D2 }
end;

{ Enlarge the vector by one element without destroying any existing data }

procedure TVectori.Enlarge;
begin
 ReAllocMem(vx, sizeof(integer)*(s+1)); inc(s); { Modified for D2 }
end;

{ Reduce the vector by one element, the top most element is destroyed }

procedure TVectori.Reduce;
begin
 ReAllocMem(vx, sizeof(integer)*(s-1)); dec(s); { Modified for D2 }
end;

{ Clear the vector, sets all elements to zero }

procedure TVectori.Zero;
var
 i: integer;
begin
 for i:= 1 to s do vx^[i]:= 0;
end;

{ Clear the vector, sets all elements to zero }

procedure TVectori.Clear;
begin
 Zero;
end;

procedure TVectori.Assign(v: TVectori);
begin
 if v.s<>Self.s then Self.SetSize(v.s);
 move(v.vx^, Self.vx^, sizeof(integer)*s)
end;

{ used internally but is also accessible from the outside }

procedure TVectori.Setval(i: integer; v: integer);
begin
 vx^[i]:= v;
end;

{ used internally but is also accessible from the outside }

function TVectori.Getval(ii: integer): integer;
begin
 result:= vx^[ii];
end;

function TVectori.GetSize: integer;
begin
 result:= s;
end;
{Unit Mat.pas}
const
 MATERROR='Matrix Operation Error:';
 
{ ------------------------------------------------------------------------- }
{                         START OF MATRIX IMPLEMETATION                     }
{ ------------------------------------------------------------------------- }
 
{ -------------------------  Constructors first  ---------------------------- }
 
{ ******************************************************************** }
{ Usage:  A := TMatrix.create (3, 2);                                  }
{ ******************************************************************** }

constructor TMatrix.create(r, c: integer);
begin
 inherited Create; nr:= 0; nc:= 0; mx:= nil;
 Self.SetSize(r, c);
end;

{ ******************************************************************** }
{ Create an identity matrix                                            }
{                                                                      }
{ Usage:   A := TMatrix.createI (3);                                   }
{ ******************************************************************** }

constructor TMatrix.createI(n: integer);
var
 i: integer;
begin
 inherited Create; nr:= 0; nc:= 0; mx:= nil;
 Self.SetSize(n, n);
 for i:= 1 to n do Self[i, i]:= 1.0;
end;

{ ******************************************************************** }
{ Create a matrix filled with values from array d given that the       }
{ number of columns equals c.                                          }
{                                                                      }
{ Usage:  A := TMatrix.createLit (2, [1, 2, 3, 4]);                    }
{         Creates a 2 by 2 array                                       }
{ ******************************************************************** }

constructor TMatrix.createLit(c: integer; d: array of TMatElement);
var
 i, j, ri, count: integer;
begin
 inherited Create; nr:= 0; nc:= 0; mx:= nil;
 ri:= (High(d)+1)div c;
 Self.SetSize(ri, c);
 count:= 0;
 for i:= 1 to ri do
  for j:= 1 to c do
  begin
   Self[i, j]:= d[count];
   inc(count);
  end;
end;

{ ******************************************************************** }
{ Usage:    A.destroy, use a.free in a program                         }
{ ******************************************************************** }

destructor TMatrix.destroy;
begin
 FreeSpace;
 inherited Destroy;
end;

{ Free the data space but not the object }

procedure TMatrix.FreeSpace;
var
 i: integer;
begin
 if mx<>nil then
 begin
  for i:= 1 to nr do
   if mx^[i]<>nil then
   begin FreeMem(mx^[i], sizeof(TMatElement)*(nc+1)); mx^[i]:= nil; end;
  FreeMem(mx, sizeof(PTRowList)*(nr+1)); mx:= nil;
 end;
 DestroyNameLists;
end;

{ Internal routine used set size of matrix and allocate space }

procedure TMatrix.SetSize(ri, ci: integer);
var
 i: integer;
begin
 FreeSpace;
 nr:= ri; nc:= ci;
 mx:= AllocMem(sizeof(pTRowList)*(nr+1)); { r+1 so that I can index from 1 }
 for i:= 1 to nr do mx^[i]:= AllocMem(sizeof(TMatElement)*(nc+1));
 CreateNameLists(ri, ci);
end;

{ Add an empty row to the bottom of matrix without destroying data in other rows }

procedure TMatrix.AddRow;
var
 tmp: TMatrix; i: integer;
begin
 tmp:= TMatrix.Create(r+1, c); tmp.zero;
 try
    { Copy a whole row at a time using move }
  for i:= 1 to r do move(Self.mx^[i]^, tmp.mx^[i]^, sizeof(TMatElement)*(c+1));
  tmp.FRowNames.Assign(Self.FRowNames); tmp.FColumnNames.Assign(Self.FColumnNames);
  Self.FreeSpace; Self.SetSize(tmp.nr, tmp.nc);
  Self.Copy(tmp);
 finally
  tmp.free;
 end;
end;

procedure TMatrix.CreateNameLists(ri, ci: integer);
var
 i: integer;
begin
 FRowNames:= TStringList.Create; FColumnNames:= TStringList.Create;
  { Build some dummy names, o entries are dummy entries }
 for i:= 0 to ri do FRowNames.add('R'+inttostr(i));
 for i:= 0 to ci do FColumnNames.add('C'+inttostr(i));
end;

procedure TMatrix.DestroyNameLists;
begin
 FRowNames.free; FRowNames:= nil; FColumnNames.free; FColumnNames:= nil;
end;

{ ---------------------------------------------------------------------------- }
{                               BASIC ROUTINES                                 }
{ ---------------------------------------------------------------------------- }

{ ******************************************************************** }
{ Used internally but is also accessible from the outside              }
{                                                                      }
{ Normal Usage:  A[2, 3] := 1.2;                                       }
{                                                                      }
{ ******************************************************************** }

procedure TMatrix.Setval(ri, ci: integer; v: TMatElement);
begin
 mx^[ri]^[ci]:= v;
end;

{ ******************************************************************** }
{ Used internally but is also accessible from the outside              }
{                                                                      }
{ Normal Usage:  d := A[2, 3];                                         }
{                                                                      }
{ ******************************************************************** }

function TMatrix.Getval(ri, ci: integer): TMatElement;
begin
 result:= mx^[ri]^[ci];
end;

procedure TMatrix.SetRowName(ri: integer; name: string);
begin
 FRowNames[ri]:= name;
end;

function TMatrix.GetRowName(ri: integer): string;
begin
 result:= FRowNames[ri];
end;

procedure TMatrix.SetColumnName(ci: integer; name: string);
begin
 FColumnNames[ci]:= name;
end;

function TMatrix.GetColumnName(ci: integer): string;
begin
 result:= FColumnNames[ci];
end;

{ ******************************************************************** }
{ Fill an existing matrix with the array d of numbers. ci equals       }
{ the number of columns.                                               }
{                                                                      }
{ Usage:   A.L(3, [1, 2, 3, 4, 5, 6, 7, 8, 9]);                        }
{                                                                      }
{ ******************************************************************** }

function TMatrix.L(ci: integer; d: array of TMatElement): TMatrix;
var
 i, j, ri, count: integer;
begin
 ri:= (High(d)+1)div ci;
 FreeMem(mx, sizeof(TMatElement)*nr*nc);
 Self.SetSize(ri, ci);
 count:= 0;
 for i:= 1 to ri do
  for j:= 1 to ci do
  begin
   Self[i, j]:= d[count];
   inc(count);
  end;
 result:= Self;
end;

{ ******************************************************************** }
{ Zero the Self matrix                                                 }
{                                                                      }
{ Usage: A.Zero;                                                       }
{                                                                      }
{ ******************************************************************** }

function TMatrix.Zero: TMatrix;
var
 i, j: integer;
begin
 for i:= 1 to r do
  for j:= 1 to c do
   Self[i, j]:= 0.0;
 result:= Self;
end;

{ ******************************************************************** }
{ Returns true if matrices m1 and m2 have the same dimensions          }
{                                                                      }
{ Usage: if SameDimensions (A, B) then                                 }
{                                                                      }
{ ******************************************************************** }

function TMatrix.SameDimensions(m1, m2: TMatrix): boolean;
begin
 result:= (m1.nr=m2.nr)and(m1.nc=m2.nc); { use nr, nc for direct access }
end;

{ ******************************************************************** }
{ Returns true if matrix m is square                                   }
{                                                                      }
{ Usage: if IsSquare (A) then                                          }
{                                                                      }
{ ******************************************************************** }

function TMatrix.IsSquare(m: TMatrix): boolean;
begin
 result:= m.nr=m.nc;
end;

{ ******************************************************************** }
{ Turn the matrix Self into an identify matrix                         }
{                                                                      }
{ Usage:  A.Identity                                                   }
{                                                                      }
{ ******************************************************************** }

function TMatrix.Identity: TMatrix;
var
 i: integer;
begin
 if IsSquare(Self) then
 begin
  Self.Zero;
  for i:= 1 to r do Self[i, i]:= 1.0;
  result:= Self;
 end
 else
  raise EMatrixSizeError.Create('An identity matrix can only be formed from a square matrix');
end;

{ ******************************************************************** }
{ Make the matrix object a diagonal matrix with the value, k           }
{                                                                      }
{ Usage: A.Diagonal (3.1415);                                          }
{                                                                      }
{ ******************************************************************** }

function TMatrix.Diagonal(k: TMatElement): TMatrix;
var
 i: integer;
begin
 if IsSquare(Self) then
 begin
  Self.Zero;
  for i:= 1 to r do Self[i, i]:= k;
  result:= Self;
 end
 else
  raise EMatrixSizeError.Create('Can only form a diagonal matrix from a square matrix');
end;

{ ******************************************************************** }
{ This forms a diagonal matrix from the elements of vector v.          }
{                                                                      }
{ Usage: A.DiagonalV (v)                                               }
{                                                                      }
{ ******************************************************************** }

function TMatrix.DiagonalV(v: TVector): TMatrix;
var
 i: integer;
begin
 if IsSquare(Self) then
 begin
  if v.size=Self.nr then
  begin
   Self.zero;
   for i:= 1 to r do Self[i, i]:= v[i];
   result:= Self;
  end
  else
   raise EMatrixSizeError.Create('Vector must be same size as matrix in DiagonalV');
 end
 else
  raise EMatrixSizeError.Create('Can only form a diagonal matrix from a square matrix');
end;

{ ******************************************************************** }
{ Transpose matrix 'Self', Self is thus destroyed and replaced         }
{                                                                      }
{ Usage:  A.transposeSelf                                              }
{                                                                      }
{ ******************************************************************** }

function TMatrix.TransposeSelf: TMatrix;
var
 i, j: integer; tmp: TMatrix;
begin
 tmp:= TMatrix.create(c, r);
 try
  for i:= 1 to r do
   for j:= 1 to c do
    tmp[j, i]:= Self[i, j];
  Self.FreeSpace; Self.SetSize(tmp.nr, tmp.nc);
    { move data from transpose to Self }
  Self.Copy(tmp);
 finally
  tmp.Destroy;
 end;
 result:= Self;
end;

{ ******************************************************************** }
{ Transpose the matrix 'm' into Self                                   }
{                                                                      }
{ Usage:  T.transpose (A);   Tranposes A and puts result into T       }
{ Will also accept T.transpose (T)                                    }
{ ******************************************************************** }

function TMatrix.Transpose(m: TMatrix): TMatrix;
var
 i, j: integer; t: TMatrix;
begin
 if (m.r<>Self.c)and(m.c<>Self.r) then
  raise EMatrixSizeError.Create('Destination matrix has incorrect dimensions for transpose');
  { If the user is trying to transpose itself.... }
 if Self=m then
 begin
  t:= TMatrix.Create(r, c);
  try
   t.Copy(m);
   for i:= 1 to m.r do
    for j:= 1 to m.c do
     Self[j, i]:= t[i, j];
  finally
   t.free;
   result:= Self;
  end;
  exit;
 end;
 
 for i:= 1 to m.r do
  for j:= 1 to m.c do
   Self[j, i]:= m[i, j];
 result:= Self;
end;

{ ******************************************************************** }
{ Copy matrix 'm' to Self, Self must exist and is overwritten          }
{ in the process. This procedure does a fast deep copy of the matrix.  }
{                                                                      }
{ Usage:  B.Copy (A);   performs the operation:  B = A  with deep copy }
{                                                                      }
{ ******************************************************************** }

function TMatrix.Copy(m: TMatrix): TMatrix;
var
 i: integer;
begin
 if (r<>m.r)or(c<>m.c) then
 begin
  if r<>m.r then
   raise EMatrixSizeError.Create(MATERROR+#13#10'Cannot copy matrices with different sized rows: dest<'
    +inttostr(r)+'> src<'+inttostr(m.r)+'>')
  else
   raise EMatrixSizeError.Create(MATERROR+#13#10'Cannot copy matrices with different sized columns: dest<'
    +inttostr(c)+'> src<'+inttostr(m.c)+'>');
 end;
  { Copy a whole row at a time using move }
 for i:= 1 to r do move(m.mx^[i]^, Self.mx^[i]^, sizeof(TMatElement)*(c+1));
 m.FRowNames.clear; m.FColumnNames.clear;
 m.FRowNames.Assign(Self.FRowNames); m.FColumnNames.Assign(Self.FColumnNames);
 result:= Self;
end;

{ ******************************************************************** }
{ Extract column cc from the Self matrix and return it as a TVector    }
{                                                                      }
{ Usage: m.ExtractColumn (v, 1)  extract column 1 from m and place in v}
{                                                                      }
{ ******************************************************************** }

procedure TMatrix.ExtractColumn(var v: TVector; cc: integer);
var
 i: integer;
begin
 v.freeSpace; v.SetSize(Self.r); { Create result vector of appropriate size }
 for i:= 1 to Self.r do v[i]:= Self[i, cc];
end;

{ ******************************************************************** }
{ Extract rwo rr from the Self matrix and return it as a TVector       }
{                                                                      }
{ Usage: m.ExtractRow (v, 1)  extract row 1 from m and place in v      }
{                                                                      }
{ ******************************************************************** }

procedure TMatrix.ExtractRow(var v: TVector; rr: integer);
var
 i: integer;
begin
 v.freespace; v.SetSize(Self.c);
 for i:= 1 to Self.c do v[i]:= Self[rr, i];
end;

{ ******************************************************************** }
{ Add matrix 'm' to Self, giving a new Self                            }
{                                                                      }
{ Usage:  A.addU (B);   add B to A, giving A                           }
{                                                                      }
{ ******************************************************************** }

function TMatrix.addU(m: TMatrix): TMatrix;
var
 i, j: integer;
begin
 if not SameDimensions(m, Self) then
  raise EMatrixSizeError.Create('Incorrectly sized result matrix for matrix addition');
 
 for i:= 1 to r do
  for j:= 1 to c do
   Self[i, j]:= Self[i, j]+m[i, j];
 result:= Self;
end;

{ ******************************************************************** }
{ Add matrix 'm1' and 'm2' and assign to Self                          }
{                                                                      }
{ Usage: A.add (A1, A2);  add A1 to A2 giving A                        }
{                                                                      }
{ ******************************************************************** }

function TMatrix.add(m1, m2: TMatrix): TMatrix;
var
 i, j: integer;
begin
 if not SameDimensions(m1, m2) then
  raise EMatrixSizeError.Create('Incompatible matrix operands to add');
 
 if not SameDimensions(m1, Self) then
  raise EMatrixSizeError.Create('Incorrectly sized result matrix for matrix addition');
 
 for i:= 1 to r do
  for j:= 1 to c do
   Self[i, j]:= m1[i, j]+m2[i, j];
 result:= Self;
end;

{ ******************************************************************** }
{ Subtract matrix m from Self giving a new Self                        }
{                                                                      }
{ Usage:  A.subU (B);  subtract B from A giving A                      }
{                                                                      }
{ ******************************************************************** }

function TMatrix.subU(m: TMatrix): TMatrix;
var
 i, j: integer;
begin
 if not SameDimensions(m, Self) then
  raise EMatrixSizeError.Create('Incorrecly sized result matrix for matrix subtraction');
 
 for i:= 1 to r do
  for j:= 1 to c do
   Self[i, j]:= Self[i, j]-m[i, j];
 result:= Self;
end;

{ ******************************************************************** }
{ Subtract m2 from m1 giving Self                                      }
{                                                                      }
{ Usage:  A.sub (A1, A2);  subtract A2 from A1 giving A (A = A2 - A1)  }
{                                                                      }
{ ******************************************************************** }

function TMatrix.sub(m1, m2: TMatrix): TMatrix;
var
 i, j: integer;
begin
 if not SameDimensions(m1, m2) then
  raise EMatrixSizeError.Create('Incompatible matrix operands to subtract');
 
 if not SameDimensions(m1, Self) then
  raise EMatrixSizeError.Create('Incorrectly sized result matrix for matrix subtraction');
 
 for i:= 1 to r do
  for j:= 1 to c do
   Self[i, j]:= m1[i, j]-m2[i, j];
 result:= Self;
end;

{ ******************************************************************** }
{ Multiply a matrix 'm' by scalar constant k and assign result to Self }
{                                                                      }
{ Usage: A.multk (B, 0.5);  multiply scalar, 0.5 by B giving A         }
{                                                                      }
{ ******************************************************************** }

function TMatrix.multK(m: TMatrix; k: TMatElement): TMatrix;
var
 i, j: integer;
begin
 for i:= 1 to m.r do
  for j:= 1 to m.c do
   Self[i, j]:= m[i, j]*k;
 result:= Self;
end;

{ ******************************************************************** }
{ Multiply the Self matrix by the scalar constant k                    }
{                                                                      }
{ Usage:  A.multKU (0.5);  multiply scalar 0.5 by A giving A           }
{                                                                      }
{ ******************************************************************** }

function TMatrix.multKU(k: TMatElement): TMatrix;
var
 i, j: integer;
begin
 for i:= 1 to r do
  for j:= 1 to c do
   Self[i, j]:= Self[i, j]*k;
 result:= Self;
end;

{ ******************************************************************** }
{ Multiply matrix 'm1' by 'm2' to give result in Self                  }
{                                                                      }
{ Usage:  A.mult (A1, A2); multiply A1 by A2 giving A                  }
{                                                                      }
{ ******************************************************************** }

function TMatrix.mult(m1, m2: Tmatrix): TMatrix;
var
 i, j, k, m1_Col: integer; sum: TMatElement;
begin
 if m1.c=m2.r then
 begin
  m1_col:= m1.c;
  for i:= 1 to Self.r do
   for j:= 1 to Self.c do
   begin
    sum:= 0.0;
    for k:= 1 to m1_Col do
     sum:= sum+m1[i, k]*m2[k, j];
    Self[i, j]:= sum;
   end;
  result:= Self;
 end
 else
  raise EMatrixSizeError.Create('Incompatible matrix operands to multiply');
end;

{ ******************************************************************** }
{ LU Solve. Solve the linear system represented by m and right-hand    }
{ side b m is assumed have have been decomposed by LUDecomp            }
{                                                                      }
{ Usage: m.LUSolve (index, b)                                          }
{                                                                      }
{ ******************************************************************** }

procedure TMatrix.LUSolve(index: TVectori; b: TVector);
var
 i, j, ii, ip, nRows: integer; sum: TMatElement;
begin
 ii:= 0;
 nRows:= r;
 for i:= 1 to nRows do
 begin
  ip:= index[i];
  sum:= b[ip];
  b[ip]:= b[i];
  if ii<>0 then
   for j:= ii to i-1 do sum:= sum-Self[i, j]*b[j]
  else if sum<>0.0 then ii:= i;
  b[i]:= sum;
 end;
 for i:= nRows downto 1 do
 begin
  sum:= b[i];
  if i<nRows then
   for j:= i+1 to nRows do sum:= sum-Self[i, j]*b[j];
  b[i]:= sum/Self[i, i];
 end
end;

{ ******************************************************************** }
{ Form LU decomposition of Self matrix. Result goes into m             }
{                                                                      }
{ Usage: m.LUDecomp(result, index);                                    }
{                                                                      }
{ ******************************************************************** }

procedure TMatrix.LUDecomp(m: TMatrix; index: TVectori);
var
 v: TVector; i, k, j, imax, nRows: integer;
 sum, big, tmp: TMatElement;
 tmpName: string;
begin
 if Self.r=m.c then
 begin
  m.Copy(Self);
  v:= TVector.Create(m.r);
  try
     { Find the largest element in every row, and store its reciprocal in v[i] }
   nRows:= m.r;
   for i:= 1 to nRows do
   begin
    big:= 0.0; { needed to test for singularity }
         { Although we're working across columns we can use nRows since m1 is square }
    for j:= 1 to nRows do if (abs(m[i, j])>big) then big:= abs(m[i, j]);
    if big=0.0 then raise ESingularMatrix.Create('LUDecomp: Singular matrix in LUDecomp, found row of zeros');
    v[i]:= 1.0/big
   end;

   for j:= 1 to nRows do
   begin
         { Form beta = aij - sum_k=1^i-1 aik * bkj }
    for i:= 1 to j-1 do
    begin
     sum:= m[i, j];
     for k:= 1 to i-1 do sum:= sum-m[i, k]*m[k, j];
     m[i, j]:= sum
    end;
    big:= 0.0;
    imax:= j; // EuAdd
    for i:= j to nRows do
    begin
     sum:= m[i, j];
     for k:= 1 to j-1 do sum:= sum-m[i, k]*m[k, j];
     m[i, j]:= sum;
     if v[i]*abs(sum)>=big then
     begin
      big:= v[i]*abs(sum);
      imax:= i
     end
    end;
         { Interchange rows if necessary }
    if j<>imax then
    begin
            { Swap row names aswell }
     tmpName:= m.rName[imax]; m.rName[imax]:= m.rName[j];
     m.rName[j]:= tmpName;
     for k:= 1 to nRows do
     begin
      tmp:= m[imax, k];
      m[imax, k]:= m[j, k];
      m[j, k]:= tmp
     end;
     v[imax]:= v[j]
    end;
    index[j]:= imax;
          { Get ready to divide by pivot element }
    if m[j, j]=0.0 then
     raise ESingularMatrix.Create('LUDecomp: Singular Matrix, pivot value is zero');
    if j<>nRows then
    begin
     tmp:= 1.0/m[j, j];
     for i:= j+1 to nRows do m[i, j]:= m[i, j]*tmp
    end
   end;
  finally
   v.destroy;
  end;
 end
 else
  raise ENonSquareMatrix.Create('LUDecomp: Matrix must be square');
end;

{ ******************************************************************** }
{ Find determinant of matrix                                           }
{                                                                      }
{ Usage: d := m.det                                                    }
{                                                                      }
{ ******************************************************************** }

function TMatrix.Det: Double;
var
 m: TMatrix; index: TVectori; i: integer;
begin
 result:= 1;
 if r=c then
 begin
  index:= TVectori.Create(r);
  m:= TMatrix.Create(r, r);
  try
   m.copy(Self);
   Self.LUDecomp(m, index);
   for i:= 1 to r do result:= result*m[i, i];
  finally
   m.free; index.free;
  end;
 end
 else
  raise ENonSquareMatrix.Create('Determinant: Matrix must be square');
end;

{ ******************************************************************** }
{ Solve a linear system of equations: Self.v = b, i.e solve for v      }
{                                                                      }
{ Usage: A.SolveLinear (v, b, t);                                      }
{        Solution in v                                                 }
{ If the boolean t is true then self is replaced by the inverse        }
{ ******************************************************************** }

procedure TMatrix.SolveLinear(v, b: TVector; SelfToInv: boolean);
var
 n, i, j: integer;
 indx: TVectori; col: TVector;
 dest, src: TMatrix;
begin
 if Self.r=Self.c then
 begin
  n:= Self.r;
     { Make a copy and work on the copy }
  dest:= TMatrix.Create(n, n);
  src:= TMatrix.Create(n, n);
  indx:= TVectori.Create(n);
  try
   src.Copy(Self);
   for i:= 1 to n do v[i]:= b[i];
   src.LUDecomp(dest, indx);
   dest.LUSolve(indx, v);
   if SelfToInv then
   begin
    col:= TVector.Create(n);
    try
     for j:= 1 to n do
     begin
      for i:= 1 to n do col[i]:= 0.0;
      col[j]:= 1.0;
      dest.LUSolve(indx, col);
      for i:= 1 to n do Self[i, j]:= col[i];
     end;
    finally
     col.free;
    end;
   end;
  finally
   indx.destroy; dest.destroy; src.destroy;
  end;
 end
 else
  raise ENonSquareMatrix.Create('SolveLinear: Matrix must be square');
end;

{ ******************************************************************** }
{ Fast method for inverting a matrix (Self)                            }
{ Result in inv                                                        }
{                                                                      }
{ Usage:  A.Invert (inv);                                              }
{ ******************************************************************** }

procedure TMatrix.Invert(inv: TMatrix);
var
 col: TVector; n, i, j: integer;
 dest, src: TMatrix; indx: TVectori;
begin
 n:= Self.r;
 col:= TVector.Create(n);
 dest:= TMatrix.Create(n, n);
 src:= TMatrix.Create(n, n);
 indx:= TVectori.Create(n);
 try
  src.Copy(Self);
  try
   src.LUDecomp(dest, indx);
  except
   on ESingularMatrix do
    raise ESingularMatrix.Create('Invert: Singular Matrix');
  end;
  for j:= 1 to n do
  begin
   for i:= 1 to n do col[i]:= 0.0;
   col[j]:= 1.0;
   dest.LUSolve(indx, col);
   for i:= 1 to n do inv[i, j]:= col[i];
  end;
 finally
  col.destroy; dest.destroy; src.destroy; indx.destroy;
 end;
end;

{ ******************************************************************** }
{ Fast method for inverting a matrix (Self)                            }
{ Result in Self                                                       }
{                                                                      }
{ Usage:  A.InvertSelf                                                 }
{ ******************************************************************** }

procedure TMatrix.InvertSelf;
var
 col: TVector; n, i, j: integer;
 dest, src: TMatrix; index: TVectori;
begin
 n:= Self.r;
 col:= TVector.Create(n);
 dest:= TMatrix.Create(n, n);
 src:= TMatrix.Create(n, n);
 index:= TVectori.Create(n);
 try
  src.Copy(Self);
  try
   src.LUDecomp(dest, index);
  except
   on ESingularMatrix do
    raise ESingularMatrix.Create('Invert: Singular Matrix');
  end;
  for j:= 1 to n do
  begin
   for i:= 1 to n do col[i]:= 0.0;
   col[j]:= 1.0;
   dest.LUSolve(index, col);
   for i:= 1 to n do Self[i, j]:= col[i];
  end;
 finally
  col.destroy; dest.destroy; src.destroy; index.destroy;
 end;
end;

{ Internal routine that sets any values less than eps to 0.0 }

procedure CleanUpMatrix(m: TMatrix; eps: Double);
var
 i, j, ri, ci: integer;
begin
  { Removes all numbers close to zero, i.e between -eps and +eps }
 ri:= m.r; ci:= m.c;
 for i:= 1 to ri do
  for j:= 1 to ci do
   if abs(m[i, j])<eps then m[i, j]:= 0.0;
end;

{ Internal routine to work out th rank of a matrix given the reduced row-echelon }

function ComputeRank(m: TMatrix; eps: Double): integer;
var
 i, j, ri, ci, rank: integer;
begin
 ri:= m.r; ci:= m.c;
  { find the rank - brute force algorithm }
 rank:= 0;
  { search row by row  for zero rows }
 for i:= 1 to ri do
 begin
      { search along the row looking for nonzero entry }
  for j:= 1 to ci do
   if abs(m[i, j])>eps then
   begin
    inc(rank);
    break;
   end;

 end;
 result:= rank;
end;

{ ******************************************************************** }
{ Routine to exchange two rows, r1 and r2 in matrix Self               }
{                                                                      }
{ Usage:  A.exchangeRows (1, 2);                                       }
{                                                                      }
{ ******************************************************************** }

function TMatrix.ExchangeRows(r1, r2: integer): TMatrix;
var
 ci, i: integer; t: Double;
begin
 if (r1>0)and(r1<=Self.r)and(r2>0)and(r2<=Self.r) then
 begin
  ci:= Self.c;
  for i:= 1 to ci do
  begin
   t:= Self[r1, i];
   Self[r1, i]:= Self[r2, i];
   Self[r2, i]:= t;
  end;
  result:= Self;
 end
 else
  raise EMatrixSizeError.Create('Rows not in range for exchange');
end;

{ ******************************************************************** }
{ Routine to exchange two columns, c1 and c2 in matrix Self            }
{                                                                      }
{ Usage:  A.exchangeCols (1, 2);                                       }
{                                                                      }
{ ******************************************************************** }

function TMatrix.ExchangeCols(c1, c2: integer): TMatrix;
var
 ri, i: integer; t: Double;
begin
 if (c1>0)and(c1<=Self.c)and(c2>0)and(c2<=Self.c) then
 begin
  ri:= Self.r;
  for i:= 1 to ri do
  begin
   t:= Self[c1, i];
   Self[c1, i]:= Self[c2, i];
   Self[c2, i]:= t;
  end;
  result:= Self;
 end
 else
  raise EMatrixSizeError.Create('Columns not in range for exchange');
end;

{ ******************************************************************** }
{ Find the rank r, of the matrix Self, The reduced Row                 }
{ echelon is returned in mat. eps is the magnitude of                  }
{ the largest number before it is assumed to be zero.                  }
{                                                                      }
{ Usage:  r := A.Rank (echelon, 1e-8)                                  }
{         Find the rank of A, place echelon in echelon                 }
{                                                                      }
{ ******************************************************************** }

function TMatrix.Rank(echelon: TMatrix; eps: Double): integer;
var
 Arow, Acol, i, j, n, m, RowScan: integer;
 factor: Double;
begin
 echelon.copy(Self); { we work on mat, not Self }
 
 if (eps=0.0) then eps:= 1.0E-14;
 
 n:= echelon.r; m:= echelon.c;
 
 Arow:= 1; Acol:= 1;
 repeat
    { locate a nonzero column }
  if abs(echelon[Arow, Acol])<=eps then { i.e equals zero }
  begin
       { First entry was zero, therefore work our way down the matrix
       looking for a nonzero entry, when found, swap it for Arow }
   RowScan:= Arow;
   repeat
         { next row }
    inc(RowScan);
         { have we reached the end of the rows but we've still got columns left to scan }
    if (RowScan>n)and(Acol<m) then
    begin
           { reset row counter back to where it was and try next column }
     RowScan:= Arow; inc(Acol);
    end;

         { If we've scanned the whole matrix, so lets get out... }
    if (RowScan>n) then
    begin
     CleanUpMatrix(echelon, eps);
     result:= ComputeRank(echelon, eps);
     exit;
    end;
   until abs(echelon[RowScan, Acol])>eps; { keep searching until non-zero entry found }

       { We've found a nonzero row entry so swap it with
       'Arow' which did have a zero as its entry }
   echelon.exchangeRows(Arow, RowScan);
  end;
    { Arow now holds the row of interest }
  factor:= 1.0/echelon[Arow, Acol];
    { reduce all the entries along the column by the factor }
  for i:= Acol to m do echelon[Arow, i]:= echelon[Arow, i]*factor;

    { now eliminate all entries above and below Arow, this generates the reduced form }
  for i:= 1 to n do
        { miss out Arow itself }
   if (i<>Arow)and(abs(echelon[i, Acol])>eps) then
   begin
    factor:= echelon[i, Acol];
           { work your way along the column doing the same operation }
    for j:= Acol to m do
     echelon[i, j]:= echelon[i, j]-factor*echelon[Arow, j];
   end;

  inc(Arow); inc(Acol);
 until (Arow>n)or(Acol>m);
 CleanUpMatrix(echelon, eps);
 result:= ComputeRank(echelon, eps); { This is just a patch for the moment }
end;

{ ******************************************************************** }
{               Find the null space of a matrix                        }
{ ******************************************************************** }
{                           Algorithm

    1. Reduce matrix to reduced echelon form
    2. There will be as many null space vectors as there are
       non-leading columns. Select one of these non-leading columns.
    3. Select the ith non-leading column and place a 1 at the ith
       position in the growing null space vector
    4. Consider the remaining non-leading columns, say j,k,l...
       and place zero's at positions j,k,l... in the growing null
       vector.
    5. Consider now the column positions of the leading columns, say
       l,m,n... The equivalent entries in the growing null space
       are what remains to be filled in. Select each of these leading
       columns in turn, say the lth first. Record which row the
       leading one is in, say r. Then place at position l in the
       growing null space vector, the element -1 * element (r, i)
       where i is the original ith non-leading column selected in
       step 3. Continue for leading columns m,n... until the growing
       null space vector is complete.
    6. Go back to step 2 and pick another non-leading column to
       compute the next null space vector.

Does not disturb the matrix Self. Null space to be found in NullVectors, size of
the basis in BasisSize, the reduced row-echelon in Echelon and the rank in TheRank }

{ Usage:   A.NullSpace (N, b, Echelon, r);
{                                                                      }
{ ******************************************************************** }

procedure TMatrix.NullSpace(NullVectors: TMatrix; var BasisSize: integer;
 Echelon: TMatrix; var TheRank: integer);
var
//EuDelete eps, x, t: Double;
 eps, x: Double;
 i, j, k: integer;
 mask: TVectori;
 VectorCounter, maskcount: integer;
 minus999, minus888, EchelonCols: integer;
begin
 EchelonCols:= Echelon.c;
 mask:= TVectori.create(EchelonCols);
 try

  eps:= 0.000000001;
  minus999:= -999; { leading column }
  minus888:= -888; { non-leading column }

  { STEP 1 }
  k:= Self.Rank(Echelon, eps);
  TheRank:= k;

  k:= Self.c-TheRank;
  BasisSize:= k;
  if BasisSize>0 then
  begin
   for i:= 1 to EchelonCols do mask[i]:= minus888;

   for i:= 1 to Echelon.r do
   begin
         { scan along columns looking for a leading one }
    j:= 1;
    repeat
     x:= Echelon[i, j];
     if (x>-eps)and(x<eps) then { check if its practically zero }
      Echelon[i, j]:= 0.0;

     if (x>1.0-eps)and(x<1.0+eps) then { x is then = 1.0 }
     begin
      mask[j]:= minus999; { tag as leading column }
      j:= 0; { exit signal }
     end
     else
      j:= j+1;

    until (j=0)or(j>EchelonCols);

   end; { end row scan }
     { Find non-leading columns }
   VectorCounter:= 1;
   i:= 1; { i = column counter, check all columns }
   repeat
    for j:= 1 to EchelonCols do NullVectors[j, VectorCounter]:= minus888;

       { STEP 5 }
       { remember all minus888's in mask = non-leading columns }
    if mask[i]=minus888 then { found a non-leading column }
    begin
     j:= 1;
          { move down mask }
     for maskcount:= 1 to EchelonCols do
      if (mask[maskcount]=minus999) then
      begin
       NullVectors[maskcount, VectorCounter]:= -Echelon[j, i];
       inc(j);
      end;

          { STEP 4 }
          { zero all -888 (free) entries }
     for j:= 1 to EchelonCols do
      if NullVectors[j, VectorCounter]=minus888 then
       NullVectors[j, VectorCounter]:= 0.0;

          { STEP 2 AND 3 }
          { mark free variable }
     NullVectors[i, VectorCounter]:= 1.0;
     VectorCounter:= VectorCounter+1;
    end;
    inc(i);
   until i>EchelonCols;
  end
  else
   BasisSize:= 0;
 finally
  mask.free;
 end;
end;

function sign(a, b: TMatElement): TMatElement;
begin
 if b>=0.0 then
  result:= abs(a)
 else
  result:= -abs(a);
end;

function max(a, b: TMatElement): TMatElement;
begin
 if a>b then
  result:= a
 else
  result:= b;
end;

{ Compute sqrt (a^2 + b^2) using numerically more stable method. If x = sqrt(a^2 + b^2),
then, x/a^2 = 1/a^2 sqrt (a^2 + b^2), mult both sides by sqrt(..), so
x/a^2 * sqrt (a^2 + b^2) = 1/a^2 (a^2 + b^2) or
x/a^2 * sqrt (a^2 + b^2) = 1 + (b/a)^2 but on left side 1/a^2 sqrt(a^2 + b^2) equals
x/a^2, therefore x * x/a^2 = 1 + (b/a) ^2, take square roots on both side yields:
x/a := sqrt (1+(b/a)^2), or FINALLY: x := a sqrt (1 + (b/a)^2) }

function pythag(a, b: TMatElement): TMatElement;
var
 at, bt, ct: TMatElement;
begin
 result:= sqrt(a*a+b*b);
 exit;
 at:= abs(a); bt:= abs(b);
 if at>bt then
 begin
  ct:= bt/at;
  result:= at*sqrt(1+ct*ct);
 end
 else
 begin
  if bt>0 then
  begin
   ct:= at/bt;
   result:= bt*sqrt(1+ct*ct);
  end
  else
   result:= 0.0;
 end;
end;

function MyAbs(x: TMatElement): TMatElement;
begin
 if x<0.0 then x:= -x;
 result:= x;
end;

{procedure TMatrix.svd2 (var u : TMatrix; var w : TVector; var v : TMatrix);}

procedure TMatrix.svd2(var u: TMatrix; var w: TVector; var v: TMatrix);
label
 1, 2, 3;
//const
// nmax=100;
var
 n, m, nm, l, k, j, jj, its, i: integer;
 z, y, x, scale, s, h, g, f, cc, anorm: real;
 rv1: TVector; Aug: TMatrix;
 AugMatrix: boolean;
 
 function sign(a, b: TMatElement): TMatElement;
 begin
  if (b>=0.0) then sign:= abs(a) else sign:= -abs(a)
 end;
 
 function max(a, b: TMatElement): TMatElement;
 begin
  if (a>b) then max:= a else max:= b
 end;
 
begin
 m:= r; n:= c; AugMatrix:= false;
  {if m < n then
     begin
     { More parameters than data ! Change structure of Self by augmenting
     Self with additional rows (entries set to zero) so that m = n, don't change m or n though }
     {Aug := TMatrix.Create (n, n); Aug.zero;
     try
       for i := 1 to m do
           for j := 1 to n do
               Aug[i,j] := Self[i,j];
       u.FreeSpace; u.SetSize (n, n); u.Copy (Aug);
       AugMatrix := true;
     finally
       Aug.free;
     end;
     end
  else}
 u.Copy(Self); { Work on U, don't destroy Self }
 
 if AugMatrix then
  rv1:= TVector.Create(n){ Make enough room }
 else
  rv1:= TVector.Create(m); { Save some space }
 g:= 0.0;
 scale:= 0.0;
 anorm:= 0.0;
 for i:= 1 to n do begin
  l:= i+1;
  rv1[i]:= scale*g;
  g:= 0.0;
  s:= 0.0;
  scale:= 0.0;
  if (i<=m) then begin
   for k:= i to m do scale:= scale+Myabs(u[k, i]);
   if (Myabs(scale)>1E-12) then begin
         {IF (scale <> 0.0) THEN BEGIN}
    for k:= i to m do
    begin
     u[k, i]:= u[k, i]/scale;
     s:= s+u[k, i]*u[k, i]
    end;
    f:= u[i, i];
    g:= -sign(sqrt(s), f);
    h:= f*g-s;
    u[i, i]:= f-g;
    if (i<>n) then
    begin
     for j:= l to n do
     begin
      s:= 0.0;
      for k:= i to m do s:= s+u[k, i]*u[k, j];
      f:= s/h;
      for k:= i to m do u[k, j]:= u[k, j]+f*u[k, i];
     end
    end;
    for k:= i to m do u[k, i]:= scale*u[k, i]
   end
  end;
  w[i]:= scale*g;
  g:= 0.0;
  s:= 0.0;
  scale:= 0.0;
  if ((i<=m)and(i<>n)) then begin
   for k:= l to n do scale:= scale+Myabs(u[i, k]);
   if (Myabs(scale)>1E-12) then begin
         {if (scale <> 0.0) then begin}
    for k:= l to n do
    begin
     u[i, k]:= u[i, k]/scale;
     s:= s+u[i, k]*u[i, k]
    end;
    f:= u[i, l];
    g:= -sign(sqrt(s), f);
    h:= f*g-s;
    u[i, l]:= f-g;
    for k:= l to n do rv1[k]:= u[i, k]/h;
    if (i<>m) then
    begin
     for j:= l to m do
     begin
      s:= 0.0;
      for k:= l to n do s:= s+u[j, k]*u[i, k];
      for k:= l to n do u[j, k]:= u[j, k]+s*rv1[k];
     end
    end;
    for k:= l to n do u[i, k]:= scale*u[i, k];
   end
  end;
  anorm:= max(anorm, (Myabs(w[i])+Myabs(rv1[i])))
 end;
 
 for i:= n downto 1 do begin
  if (i<n) then begin
   if (Myabs(g)>1E-12) then
         {IF (g <> 0.0) THEN}
   begin
    for j:= l to n do v[j, i]:= (u[i, j]/u[i, l])/g;
    for j:= l to n do
    begin
     s:= 0.0;
     for k:= l to n do s:= s+u[i, k]*v[k, j];
     for k:= l to n do v[k, j]:= v[k, j]+s*v[k, i]
    end
   end;
   for j:= l to n do
   begin
    v[i, j]:= 0.0;
    v[j, i]:= 0.0;
   end
  end;
  v[i, i]:= 1.0;
  g:= rv1[i];
  l:= i
 end;
 for i:= n downto 1 do begin
  l:= i+1;
  g:= w[i];
  if (i<n) then for j:= l to n do u[i, j]:= 0.0;
  if (Myabs(g)>1E-12) then
      {IF (g <> 0.0) THEN}
  begin
   g:= 1.0/g;
   if (i<>n) then
   begin
    for j:= l to n do
    begin
     s:= 0.0;
     for k:= l to m do s:= s+u[k, i]*u[k, j];
     f:= (s/u[i, i])*g;
     for k:= i to m do u[k, j]:= u[k, j]+f*u[k, i];
    end
   end;
   for j:= i to m do u[j, i]:= u[j, i]*g;
  end else
  begin
   for j:= i to m do u[j, i]:= 0.0;
  end;
  u[i, i]:= u[i, i]+1.0
 end;
 for k:= n downto 1 do begin
  for its:= 1 to 30 do begin
   for l:= k downto 1 do
   begin
    nm:= l-1;
    if ((Myabs(rv1[l])+anorm)-anorm<1E-12) then goto 2;
             {if ((Myabs(rv1[l]) + anorm) = anorm) then goto 2;}
    if ((Myabs(w[nm])+anorm)-anorm<1E-12) then goto 1
             {if ((Myabs(w[nm]) + anorm) = anorm) then goto 1}
   end;
   1: cc:= 0.0;
   s:= 1.0;
   for i:= l to k do begin
    f:= s*rv1[i];
    if ((Myabs(f)+anorm)-anorm>1E-12) then
             {if ((Myabs(f)+anorm) <> anorm) then}
    begin
     g:= w[i];
     h:= sqrt(f*f+g*g);
     w[i]:= h;
     h:= 1.0/h;
     cc:= (g*h);
     s:= -(f*h);
     for j:= 1 to m do
     begin
      y:= u[j, nm];
      z:= u[j, i];
      u[j, nm]:= (y*cc)+(z*s);
      u[j, i]:= -(y*s)+(z*cc)
     end
    end
   end;
   2: z:= w[k];
   if (l=k) then
   begin
    if (z<0.0) then
    begin
     w[k]:= -z;
     for j:= 1 to n do v[j, k]:= -v[j, k];
    end;
    goto 3
   end;
   if (its=30) then // EuConvert writeln('no convergence in 30 SVDCMP iterations');
    StdOut.Add('no convergence in 30 SVDCMP iterations');
   x:= w[l];
   nm:= k-1;
   y:= w[nm];
   g:= rv1[nm];
   h:= rv1[k];
   f:= ((y-z)*(y+z)+(g-h)*(g+h))/(2.0*h*y);
   g:= sqrt(f*f+1.0);
   f:= ((x-z)*(x+z)+h*((y/(f+sign(g, f)))-h))/x;
   cc:= 1.0;
   s:= 1.0;
   for j:= l to nm do
   begin
    i:= j+1;
    g:= rv1[i];
    y:= w[i];
    h:= s*g;
    g:= cc*g;
    z:= sqrt(f*f+h*h);
    rv1[j]:= z;
    cc:= f/z;
    s:= h/z;
    f:= (x*cc)+(g*s);
    g:= -(x*s)+(g*cc);
    h:= y*s;
    y:= y*cc;
    for jj:= 1 to n do
    begin
     x:= v[jj, j];
     z:= v[jj, i];
     v[jj, j]:= (x*cc)+(z*s);
     v[jj, i]:= -(x*s)+(z*cc)
    end;
    z:= sqrt(f*f+h*h);
    w[j]:= z;
    if (Myabs(z)>1E-12) then
             {if (z <> 0.0) then}
    begin
     z:= 1.0/z;
     cc:= f*z;
     s:= h*z
    end;
    f:= (cc*g)+(s*y);
    x:= -(s*g)+(cc*y);
    for jj:= 1 to m do
    begin
     y:= u[jj, j];
     z:= u[jj, i];
     u[jj, j]:= (y*cc)+(z*s);
     u[jj, i]:= -(y*s)+(z*cc)
    end
   end;
   rv1[l]:= 0.0;
   rv1[k]:= f;
   w[k]:= x
  end;
  3: end

end;

{ Perform a Singular Value Decompostion on self, returning u, w, and v, modified
from Numerical Recipes and Forsythe et al 1977, Computer methods for Math Calc }

procedure TMatrix.svd(var u: TMatrix; var w: TVector; var v: TMatrix);
label
 3;
var
 i, j, k, l, n, m, its, flag, nm, jj: integer; rv1: TVector;
 scale, g, h, f, anorm, s, cc, x, y, z: TMatElement; Aug: TMatrix;
 AugMatrix: boolean;
begin
 m:= r; n:= c; AugMatrix:= false;
 if m<n then
 begin
     { More parameters than data ! Change structure of Self by augmenting
     Self with additional rows (entries set to zero) so that m = n, don't change m or n though }
  Aug:= TMatrix.Create(n, n); Aug.zero;
  try
   for i:= 1 to m do
    for j:= 1 to n do
     Aug[i, j]:= Self[i, j];
   u.FreeSpace; u.SetSize(n, n); u.Copy(Aug);
   AugMatrix:= true;
  finally
   Aug.free;
  end;
 end
 else
  u.Copy(Self); { Work on U, don't destroy Self }
 
 scale:= 0.0; g:= 0.0; anorm:= 0.0;
 if AugMatrix then
  rv1:= TVector.Create(n){ Make enough room }
 else
  rv1:= TVector.Create(m); { Save some space }
 
 try
  for i:= 1 to n do
  begin
   l:= i+1;
   rv1[i]:= scale*g;
   g:= 0.0; s:= 0.0; scale:= 0.0;
   if i<=m then
   begin
    for k:= i to m do scale:= scale+abs(u[k, i]);
    if scale<>0.0 then
    begin
     for k:= i to m do
     begin
      u[k, i]:= u[k, i]/scale;
      s:= s+u[k, i]*u[k, i];
     end;
     f:= u[i, i];
     g:= -sign(sqrt(s), f);
     h:= f*g-s;
     u[i, i]:= f-g;
     if i<>n then
     begin
      for j:= l to n do
      begin
       s:= 0.0;
       for k:= i to m do s:= s+u[k, i]*u[k, j];
       f:= s/h;
       for k:= i to m do u[k, j]:= u[k, j]+f*u[k, i];
      end;
     end;
     for k:= i to m do u[k, i]:= u[k, i]*scale;
    end;
   end;
   w[i]:= scale*g;
   g:= 0.0; s:= 0.0; scale:= 0.0;
   if (i<=m)and(i<>n) then
   begin
    for k:= l to n do scale:= scale+abs(u[i, k]);
    if scale<>0.0 then
    begin
     for k:= l to n do
     begin
      u[i, k]:= u[i, k]/scale;
      s:= s+u[i, k]*u[i, k];
     end;
     f:= u[i, l];
     g:= -sign(sqrt(s), f);
     h:= f*g-s;
     u[i, l]:= f-g;
     for k:= l to n do rv1[k]:= u[i, k]/h;
     if i<>m then
     begin
      for j:= l to m do
      begin
       s:= 0.0;
       for k:= l to n do s:= s+u[j, k]*u[i, k];
       for k:= l to n do u[j, k]:= u[j, k]+s*rv1[k];
      end;
     end;
     for k:= l to n do u[i, k]:= u[i, k]*scale;
    end;
   end;
   anorm:= max(anorm, abs(w[i])+abs(rv1[i]));
  end;

  { ------------------------------------------ }
  { Accumulation of right-hand transformations }
  for i:= n downto 1 do
  begin
   if i<n then
   begin
    if g<>0.0 then
    begin
     for j:= l to n do v[j, i]:= (u[i, j]/u[i, l])/g;
     for j:= l to n do
     begin
      s:= 0.0;
      for k:= l to n do s:= s+u[i, k]*v[k, j];
      for k:= l to n do v[k, j]:= v[k, j]+s*v[k, i];
     end;
    end;
    for j:= l to n do begin v[i, j]:= 0.0; v[j, i]:= 0.0; end;
   end;
   v[i, i]:= 1.0;
   g:= rv1[i];
   l:= i;
  end;

  { ------------------------------------------ }
  { Accumulation of left-hand transformations  }
  for i:= n downto 1 do
  begin
   l:= i+1;
   g:= w[i];
   if i<n then for j:= l to n do u[i, j]:= 0.0;
   if g<>0.0 then
   begin
    g:= 1.0/g;
    if i<>n then
    begin
     for j:= l to n do
     begin
      s:= 0.0;
      for k:= l to m do s:= s+u[k, i]*u[k, j];
      f:= (s/u[i, i])*g;
      for k:= i to m do u[k, j]:= u[k, j]+f*u[k, i];
     end;
    end;
    for j:= i to m do u[j, i]:= u[j, i]*g;
   end
   else
   begin
    for j:= i to m do u[j, i]:= 0.0;
   end;
   u[i, i]:= u[i, i]+1.0;
  end;

  { --------------------------------------------- }
  { Diagonalization of the bidiagonal form        }
  for k:= n downto 1 do
  begin
   for its:= 1 to 30 do
   begin
    flag:= 1;
    for l:= k downto 1 do
    begin
     nm:= l-1;
     if abs(rv1[l]+anorm)=anorm then
     begin
      flag:= 0;
      break;
     end;
     if abs(w[nm]+anorm)=anorm then break;
    end;
    if flag<>0 then
    begin
     cc:= 0.0; s:= 1.0;
     for i:= l to k do
     begin
      f:= s*rv1[i];
      if (abs(f)+anorm)<>anorm then
      begin
       g:= w[i];
       h:= pythag(f, g);
       w[i]:= h;
       h:= 1.0/h;
       cc:= g*h;
       s:= -f*h;
       for j:= 1 to m do
       begin
        y:= u[j, nm];
        z:= u[j, i];
        u[j, nm]:= y*cc+z*s;
        u[j, i]:= z*cc-y*s;
       end;
      end;
     end;
    end;
    z:= w[k];
    if l=k then
    begin
     if z<0.0 then
     begin
      w[k]:= -z;
      for j:= 1 to n do v[j, k]:= -v[j, k];
     end;
             {break;} goto 3;
    end;
    if (its=30) then raise Exception.Create('Exceeded iterations in SVD routine');
    x:= w[l];
    nm:= k-1;
    y:= w[nm]; g:= rv1[nm];
    h:= rv1[k];
    f:= ((y-z)*(y+z)+(g-h)*(g+h))/(2.0*h*y);
    g:= pythag(f, 1.0);
    f:= ((x-z)*(x+z)+h*((y/(f+sign(g, f)))-h))/x;

    cc:= 1.0; s:= 1.0;
    for j:= l to nm do
    begin
     i:= j+1;
     g:= rv1[i];
     y:= w[i]; h:= s*g;
     g:= cc*g;
     z:= pythag(f, h);
     rv1[j]:= z;
     cc:= f/z; s:= h/z;
     f:= x*cc+g*s; g:= g*cc-x*s;
     h:= y*s;
     y:= y*cc;
     for jj:= 1 to n do
     begin
      x:= v[jj, j]; z:= v[jj, i];
      v[jj, j]:= x*cc+z*s;
      v[jj, i]:= z*cc-x*s;
     end;
     z:= pythag(f, h);
     w[j]:= z;
     if z<>0 then
     begin
      z:= 1.0/z; cc:= f*z; s:= h*z;
     end;
     f:= (cc*g)+(s*y);
     x:= (cc*y)-(s*g);
     for jj:= 1 to m do
     begin
      y:= u[jj, j]; z:= u[jj, i];
      u[jj, j]:= y*cc+z*s;
      u[jj, i]:= z*cc-y*s;
     end;
    end;
    rv1[l]:= 0.0;
    rv1[k]:= f;
    w[k]:= x;
    3: end;
  end;
 finally
  rv1.free;
 end;
 
 if AugMatrix then
 begin
     { This means that originally m < n, therefore u has some junk rows, remove them here }
  Aug:= TMatrix.Create(m, n);
  try
   for i:= 1 to m do
    for j:= 1 to n do
     Aug[i, j]:= u[i, j];
   u.FreeSpace; u.SetSize(m, n); u.Copy(Aug);
  finally
   Aug.free;
  end;
 end;
end;

{ Call this after having called svd, computes x = V [diag (1/wj)]. U^t.b }

procedure TMatrix.svdSolve(var u: TMatrix; var w: TVector; var v: TMatrix;
 b: TVector; var x: TVector);
var
 j, i, n, m: integer; s: TMatElement; tmp: TVector;
begin
 m:= u.r; n:= u.c;
 tmp:= TVector.Create(u.c);
 try
    { Compute diag (1/wj) . U^t . b }
  for j:= 1 to n do
  begin
   s:= 0.0;
   if (w[j]<>0.0) then
   begin
    for i:= 1 to m do s:= s+u[i, j]*b[i];
    s:= s/w[j]
   end;
   tmp[j]:= s
  end;
    { ...mult by V to get solution vector x }
  for i:= 1 to n do
  begin
   s:= 0.0;
   for j:= 1 to w.size do s:= s+v[i, j]*tmp[j];
   x[i]:= s
  end;
 finally
  tmp.free;
 end;
end;

{ Solves the equation: (A.a - b)^2 = 0 for a. Where, A is the 'design matrix',
Aij = Xj(xi)/sigi, where Xj is the value of the jth basis function; b is the set
of weighted observed y values, b = yi/sigi; and a is the set of fitting coefficients
for the basis functions. Thus A.a - b expresses predicted - observed }

{ BasisProc is a procedure which must return in an array the values for the
basis functions at a particular value of xi, i.e it computes, Xj(xi) }

function TMatrix.svdfit(x, y, yerr: TVector; var fit: TVector;
 var u, v: TMatrix; var w: TVector; funcs: BasisProc): TMatElement;
const
 tol=1.0E-5;
var
 i, j: integer; wmax, weight, thresh, sum: TMatElement;
 BasisVal, b: TVector; A: TMatrix;
begin
 BasisVal:= TVector.Create(fit.size); b:= TVector.Create(x.size);
 A:= TMatrix.Create(x.size, fit.size);
 try
    { Form the A matrix }
  for i:= 1 to x.size do
  begin
   funcs(x[i], BasisVal);
   weight:= 1.0/yerr[i];
   for j:= 1 to fit.size do A[i, j]:= BasisVal[j]*weight;
   b[i]:= y[i]*weight
  end;
  A.svd(u, w, v);

  wmax:= 0.0;
  for j:= 1 to fit.size do if (w[j]>wmax) then wmax:= w[j];
  thresh:= tol*wmax;
  for j:= 1 to fit.size do if (w[j]<thresh) then w[j]:= 0.0;

  svdSolve(u, w, v, b, fit);

  result:= 0.0; { chisqr set to zero ready to accumulate }
  for i:= 1 to x.size do
  begin
   funcs(x[i], BasisVal);
   sum:= 0.0;
   for j:= 1 to fit.size do sum:= sum+fit[j]*BasisVal[j];
   result:= result+sqr((y[i]-sum)/yerr[i]); { Accumulate chisqr }
  end;
 finally
  BasisVal.free; A.free; b.free;
 end;
end;

procedure TMatrix.svdCovar(v: TMatrix; w: TVector; alpha: TMatrix);
var
 i, j, k: integer; wti: TVector; sum: TMatElement;
begin
 wti:= TVector.Create(w.size);
 try
  for i:= 1 to w.size do
  begin
   wti[i]:= 0.0;
   if w[i]>0.0 then wti[i]:= 1.0/(w[i]*w[i]);
  end;
  for i:= 1 to w.size do
  begin
   for j:= 1 to i do
   begin
    sum:= 0.0;
    for k:= 1 to w.size do sum:= sum+v[i, k]*v[j, k]*wti[k];
    alpha[j, i]:= sum; alpha[i, j]:= alpha[j, i];
   end;
  end;
 finally
  wti.free;
 end;
end;

{Unit LsodaMat.pas}
{ Factor matrix into L and U by Gaussian elimination such that L*U = a }

procedure LUfactor(a: TMatrix; pivots: TVectori);
var
 n, i, k, p: integer; t, big: Double;
begin
 n:= a.r;
 for k:= 1 to n-1 do
 begin
      { Find the largest element along row k, as we move down rows start
      the search further in to the right each time we come around the k for loop }
  big:= 0;
  for p:= k to n do { Start searching at kth entry in from beginning of row }
  begin
   if abs(a[k, p])>big then begin big:= abs(a[k, p]); pivots[k]:= p; end;
  end;

      { If the pivot is not at the current row then swap }
  if pivots[k]<>k then
  begin
   t:= a[k, pivots[k]];
   a[k, pivots[k]]:= a[k, k];
   a[k, k]:= t;
  end;

      { Compute multiplers }
  t:= -1.0/a[k, k];
  for p:= k+1 to n do a[k, p]:= a[k, p]*t;

      { Eliminate the columns }
  for i:= k+1 to n do
  begin
   t:= a[i, pivots[k]];
   if (pivots[k]<>k) then
   begin
    a[i, pivots[k]]:= a[i, k];
    a[i, k]:= t;
   end;
          { Form t*a[k] + a[i] }
   for p:= k+1 to n do
    a[i, p]:= t*a[k, p]+a[i, p];
  end;
 end;
 pivots[n]:= n;
end;

{ Solve linear system a*x = b, where a has been factored by LUfactor }
{ Solution returned in b. TVectori is just a vector of integer types. }
{ Variable pivots is supplied by LUfactor }

procedure LUsolve(a: TMatrix; pivots: TVectori; b: TVector);
var
 n, j, k, p: integer; t: Double;
begin
 n:= a.r;
  { Compute b[k] = (b[k] - sum_(j=1)^(k-1) a[k,j]*b[j])/a[k,k] and solve Lz = b }
 b[1]:= b[1]/A[1, 1]; { compute z1 }
 for k:= 2 to n do { then z2.... }
 begin
  t:= 0.0;
  for j:= 1 to k-1 do t:= t+A[k, j]*b[j];
  b[k]:= (b[k]-t)/A[k, k];
 end;
  { now solve Ux = z }
 for k:= n-1 downto 1 do
 begin
  t:= 0.0;
  for p:= k+1 to n do t:= t+A[k, p]*b[p];
  b[k]:= b[k]+t;
  j:= pivots[k];
  if j<>k then
  begin
   t:= b[j];
   b[j]:= b[k];
   b[k]:= t;
  end;
 end;
end;

{unit adamsbdf.pas}

const
 ETA=2.2204460492503131E-16;
 mord: array[1..2] of integer=(12, 5);
 sm1: array[0..12] of Double=(0., 0.5, 0.575, 0.55, 0.45, 0.35, 0.25,
  0.2, 0.15, 0.1, 0.075, 0.05, 0.025);
 
{ Excecuted if fitting function not assigned by user }

procedure TLsoda.DummyFcn(t: Double; y, dydt: TVector);
begin
 raise ELsodaException.Create('No function assigned to evaluate dydts (Use Setfcn)!');
end;

{ Create a Lsoda object with n differential equations }

constructor TLsoda.Create(n: integer);
 function iMax(const i1, i2: integer): integer;
 begin
  if i1>=i2 then
   Result:= i1
  else
   Result:= i2;
 end;
 
var
 i: integer;
begin
 neq:= n;
 
 el:= TVector.Create(14); //EuConvert (14);
 elco:= TMatrix.Create(13, 14); //(13, 14);
 tesco:= TMatrix.Create(13, 4); //(13, 4);
 cm1:= TVector.Create(13); //(13);
 cm2:= TVector.Create(6);
// EuEdit for i:= 1 to 13 do yh[i]:= TVector.Create(13);
 for i:= 1 to 13 do
  yh[i]:= TVector.Create(iMax(13, neq+1));
 wm:= TMatrix.Create(neq, neq);
 perm:= TVectori.Create(neq);
 ewt:= TVector.Create(iMax(neq+1, 12)); //(12);
 savf:= TVector.Create(iMax(neq+1, 12)); //(12);
 acor:= TVector.Create(iMax(neq+1, 12)); //(12);
 Frtol:= TVector.Create(neq);
 Fatol:= TVector.Create(neq);
 FDerivatives:= DummyFcn; { Install the default fcn handler, in case user forgets }
end;

destructor TLsoda.destroy;
var
 i: integer;
begin
 el.free;
 elco.free;
 tesco.free;
 cm1.free;
 cm2.free;
 for i:= 1 to 13 do
  yh[i].free;
 wm.free;
 perm.free;
 ewt.free;
 savf.free;
 acor.Free;
 Frtol.free;
 Fatol.free;
end;

procedure TLsoda.Setfcn(fcn: fcnProc);
begin
 FDerivatives:= fcn;
end;
(* // EuComment
{**************************************************************}
function max(a, b: Double): Double;
begin
 if (a>b) then max:= a
 else max:= b;
end;
*)
{**************************************************************}

function min(a, b: Double): Double;
begin
 if (a>b) then min:= b
 else min:= a;
end;

{**************************************************************}

function maxi(a, b: integer): integer;
begin
 if (a>b) then maxi:= a
 else maxi:= b;
end;

{**************************************************************}

function mini(a, b: integer): integer;
begin
 if (a>b) then mini:= b
 else mini:= a;
end;

{**************************************************************}

function pow(a: Double; x: Double): Double;
begin
 if a=0 then pow:= 0 else pow:= exp(x*ln(abs(a)))*abs(a)/a;
end;

function TLsoda.Getrtol(i: integer): Double;
begin
 result:= Frtol[i];
end;

procedure TLsoda.Setrtol(i: integer; d: Double);
begin
 Frtol[i]:= d;
end;

function TLsoda.Getatol(i: integer): Double;
begin
 result:= Fatol[i];
end;

procedure TLsoda.Setatol(i: integer; d: Double);
begin
 Fatol[i]:= d;
end;

{**************************************************************}
{ Terminate lsoda due to illegal input. }

procedure TLsoda.terminate(var istate: integer);
begin
 if (illin=5) then
 begin
// EuConvert 2
//  writeln('lsoda -- repeated occurrence of illegal input');
//  writeln('         run aborted.. apparent infinite loop');
  StdOut.Add('lsoda -- repeated occurrence of illegal input');
  StdOut.Add('         run aborted.. apparent infinite loop');
 end
 else
 begin
  illin:= illin+1;
  istate:= -3;
 end;
end; {   end terminate   }

{**************************************************************}
{  Terminate lsoda due to various error conditions. }

procedure TLsoda.terminate2(var y: TVector; var t: Double);
var
 i: integer;
begin
 for i:= 1 to n do y[i]:= yh[1][i];
 t:= tn;
 illin:= 0;
end; { end terminate2 }

{**************************************************************}
{  The following block handles all successful returns from lsoda.
   If itask != 1, y is loaded from yh and t is set accordingly.
   *Istate is set to 2, the illegal input counter is zeroed, and the
   optional outputs are loaded into the work arrays before returning.}

procedure TLsoda.successreturn(var y: TVector; var t: Double;
 itask, ihit: integer;
 tcrit: Double;
 var istate: integer);
var
 i: integer;
begin
 for i:= 1 to n do y[i]:= yh[1][i];
 t:= tn;
 if (itask=4)or(itask=5) then
  if (ihit=0) then
   t:= tcrit;
 istate:= 2;
 illin:= 0;
end; { end successreturn }

{**************************************************************}

procedure TLsoda.ewset(itol: integer; rtol, atol, ycur: TVector);
var
 i: integer;
begin
 case itol of
  1: for i:= 1 to n do
    ewt[i]:= rtol[1]*abs(ycur[i])+atol[1];
  2: for i:= 1 to n do
    ewt[i]:= rtol[1]*abs(ycur[i])+atol[i];
  3: for i:= 1 to n do
    ewt[i]:= rtol[i]*abs(ycur[i])+atol[1];
  4: for i:= 1 to n do
    ewt[i]:= rtol[i]*abs(ycur[i])+atol[i];
 end;
end; {   end ewset   }

{**************************************************************}

function vmnorm(v, w: TVector): Double;
{  This function routine computes the weighted max-norm
   of the vector of length n contained in the array v, with weights
   contained in the array w of length n.

   vmnorm = max( i = 1, ..., n ) fabs( v[i] ) * w[i]. }
var
 i, n: integer;
begin
 result:= 0.; n:= v.size;
 for i:= 1 to n do result:= max(result, abs(v[i])*w[i]);
// EuAdd 2 Lines
// if Result<1.0e-100 then
//  Result:= 1.0e-100;
end; { end vmnorm }

{**************************************************************}

function fnorm(a: TMatrix; w: TVector): Double;

{  This subroutine computes the norm of a full n by n matrix,
   stored in the array a, that is consistent with the weighted max-norm
   on vectors, with weights stored in the array w.

      fnorm = max(i=1,...,n) ( w[i] * sum(j=1,...,n) fabs( a[i][j] ) / w[j] ) }
var
 i, j, n: integer;
 sum: Double;
begin
 result:= 0.; n:= a.r;
 for i:= 1 to n do
 begin
  sum:= 0.;
  for j:= 1 to n do
   sum:= sum+(abs(a[i, j])/w[j]);
  result:= max(result, sum*w[i]);
 end;
end; { end fnorm }

{**************************************************************}

procedure TLsoda.prja(neq: integer; var y: TVector);
var
 i, j: integer;
 hl0, r, r0, yj: Double; //  fac,
 ier: byte;
// EuAdd 1 Line
 fac: Extended;
{  prja is called by stoda to compute and process the matrix
   P = I - h * el[1] * J, where J is an approximation to the Jacobian.
   Here J is computed by finite differencing.
   J, scaled by -h * el[1], is stored in wm.  Then the norm of J ( the
   matrix norm consistent with the weighted max-norm on vectors given
   by vmnorm ) is computed, and J is overwritten by P.  P is then
   subjected to LU decomposition in preparation for later solution
   of linear systems with p as coefficient matrix.  This is done
   by LUfactor if miter = 2, and by dgbfa if miter = 5.  }
 
begin
 nje:= nje+1;
 ierpj:= 0;
 jcur:= 1;
 hl0:= h*el0;
 
{ If miter = 2, make n calls to f to approximate J. }
 
 if miter<>2 then
 begin
  if prfl=1 then //// EuConvert writeln('prja -- miter != 2');
   StdOut.Add('prja -- miter != 2');
  exit;
 end;
 
 if miter=2 then
 begin
  fac:= vmnorm(savf, ewt);
  r0:= 1000.*abs(h)*ETA*n*fac;
  if r0=0. then
   r0:= 1.;
  for j:= 1 to n do
  begin
   yj:= y[j];
   r:= max(sqrteta*abs(yj), r0/ewt[j]);
   y[j]:= y[j]+r;
   fac:= -hl0/r;
   FDerivatives(tn, y, acor);
   for i:= 1 to n do
    wm[i, j]:= (acor[i]-savf[i])*fac;
   y[j]:= yj;
// EuAdd 2
   Application.ProcessMessages;
   if fAborted then exit;
  end;
  nfe:= nfe+n;

      { Compute norm of Jacobian }
  pdnorm:= fnorm(wm, ewt)/abs(hl0);

      { Add identity matrix. }
  for i:= 1 to n do wm[i, i]:= wm[i, i]+1.;

      { Do LU decomposition on P.}
  LUfactor(wm, perm);
 end;
end; { end prja }

{**************************************************************}

procedure TLsoda.corfailure(var told, rh: Double; var ncf, corflag: integer);
var
 j, i1, i: integer;
begin
 ncf:= ncf+1;
 rmax:= 2.;
 tn:= told;
 for j:= nq downto 1 do
  for i1:= j to nq do
   for i:= 1 to n do
    yh[i1][i]:= yh[i1][i]-yh[i1+1][i];
 if (abs(h)<=hmin*1.00001)or(ncf=mxncf) then
 begin
  corflag:= 2;
  exit;
 end;
 corflag:= 1;
 rh:= 0.25;
 ipup:= miter;
end; { end corfailure }

{**************************************************************}

procedure TLsoda.solsy(var y: TVector);

{  This routine manages the solution of the linear system arising from
   a chord iteration.  It is called if miter != 0.
   If miter is 2, it calls dgesl to accomplish this.
   If miter is 5, it calls dgbsl.

   y = the right-hand side vector on input, and the solution vector
       on output. }
var
 ier: byte;
begin
 iersl:= 0;
 if miter<>2 then
 begin
  if (prfl=1) then //EuConvert writeln('solsy -- miter != 2');
   StdOut.Add('solsy -- miter != 2');
  exit;
 end;
 
 if miter=2 then LUsolve(wm, perm, y);
end; { end solsy }

{**************************************************************}

procedure TLsoda.methodswitch(dsm, pnorm: Double; var pdh, rh: Double);
var
 lm1, lm1p1, lm2, lm2p1, nqm1, nqm2: integer;
 rh1, rh2, rh1it, exm2, dm2, exm1, dm1, alpha, exsm: Double;
 
{  We are current using an Adams method.  Consider switching to bdf.
   If the current order is greater than 5, assume the problem is
   not stiff, and skip this section.
   If the Lipschitz constant and error estimate are not polluted
   by roundoff, perform the usual test.
   Otherwise, switch to the bdf methods if the last step was
   restricted to insure stability ( irflag = 1 ), and stay with Adams
   method if not.  When switching to bdf with polluted error estimates,
   in the absence of other information, Double the step size.
 
   When the estimates are ok, we make the usual test by computing
   the step size we could have (ideally) used on this step,
   with the current (Adams) method, and also that for the bdf.
   If nq > mxords, we consider changing to order mxords on switching.
   Compare the two step sizes to decide whether to switch.
   The step size advantage must be at least ratio = 5 to switch.}
 
begin
 if meth=1 then
 begin
  if nq>5 then exit;
  if (dsm<=(100.*pnorm*ETA))or(pdest=0.0) then
  begin
   if irflag=0 then exit;
   rh2:= 2.;
   nqm2:= mini(nq, mxords);
  end
  else
  begin
   exsm:= 1./l;
   rh1:= 1./(1.2*pow(dsm, exsm)+0.0000012);
   rh1it:= 2.*rh1;
   pdh:= pdlast*abs(h);
   if (pdh*rh1)>0.00001 then rh1it:= sm1[nq]/pdh;
   rh1:= min(rh1, rh1it);
   if nq>mxords then
   begin
    nqm2:= mxords;
    lm2:= mxords+1;
    exm2:= 1./lm2;
    lm2p1:= lm2+1;
    dm2:= vmnorm(yh[lm2p1], ewt)/cm2[mxords];
    rh2:= 1./(1.2*pow(dm2, exm2)+0.0000012);
   end
   else
   begin
    dm2:= dsm*(cm1[nq]/cm2[nq]);
    rh2:= 1./(1.2*pow(dm2, exsm)+0.0000012);
    nqm2:= nq;
   end;
   if rh2<ratio*rh1 then exit;
  end;

     { The method switch test passed.  Reset relevant quantities for bdf. }

  rh:= rh2;
  icount:= 20;
  meth:= 2;
  miter:= jtyp;
  pdlast:= 0.;
  nq:= nqm2;
  l:= nq+1;
  exit;
 end; { end if ( meth == 1 ) }
 
{  We are currently using a bdf method, considering switching to Adams.
   Compute the step size we could have (ideally) used on this step,
   with the current (bdf) method, and also that for the Adams.
   If nq > mxordn, we consider changing to order mxordn on switching.
   Compare the two step sizes to decide whether to switch.
   The step size advantage must be at least 5/ratio = 1 to switch.
   If the step size for Adams would be so small as to cause
   roundoff pollution, we stay with bdf. }
 
 exsm:= 1./l;
 if mxordn<nq then
 begin
  nqm1:= mxordn;
  lm1:= mxordn+1;
  exm1:= 1./lm1;
  lm1p1:= lm1+1;
  dm1:= vmnorm(yh[lm1p1], ewt)/cm1[mxordn];
  rh1:= 1./(1.2*pow(dm1, exm1)+0.0000012);
 end
 else
 begin
  dm1:= dsm*(cm2[nq]/cm1[nq]);
  rh1:= 1./(1.2*pow(dm1, exsm)+0.0000012);
  nqm1:= nq;
  exm1:= exsm;
 end;
 rh1it:= 2.*rh1;
 pdh:= pdnorm*abs(h);
 if (pdh*rh1)>0.00001 then rh1it:= sm1[nqm1]/pdh;
 rh1:= min(rh1, rh1it);
 rh2:= 1./(1.2*pow(dsm, exsm)+0.0000012);
 if ((rh1*ratio)<(5.*rh2)) then exit;
 alpha:= max(0.001, rh1);
 dm1:= dm1*pow(alpha, exm1);
 if (dm1<=1000.*ETA*pnorm) then exit;
 
  { The switch test passed.  Reset relevant quantities for Adams. }
 
 rh:= rh1;
 icount:= 20;
 meth:= 1;
 miter:= 0;
 pdlast:= 0.;
 nq:= nqm1;
 l:= nq+1;
end; { end methodswitch }

{**************************************************************}
{  This routine returns from stoda to lsoda.  Hence freevectors() is
   not executed. }

procedure TLsoda.endstoda;
var
 r: Double;
 i: integer;
begin
 r:= 1./tesco[nqu, 2];
 for i:= 1 to n do
  acor[i]:= acor[i]*r;
 hold:= h;
 jstart:= 1;
end; { end endstoda }

{**************************************************************}

procedure TLsoda.orderswitch(var rhup: Double;
 dsm: Double;
 var pdh, rh: Double;
 var orderflag: integer);

{  Regardless of the success or failure of the step, factors
   rhdn, rhsm, and rhup are computed, by which h could be multiplied
   at order nq - 1, order nq, or order nq + 1, respectively.
   In the case of a failure, rhup = 0. to avoid an order increase.
   The largest of these is determined and the new order chosen
   accordingly.  If the order is to be increased, we compute one
   additional scaled derivative.

   orderflag = 0  : no change in h or nq,
               1  : change in h but not nq,
               2  : change in both h and nq. }

var
 newq, i: integer;
 exsm, rhdn, rhsm, ddn, exdn, r: Double;
 
begin
 orderflag:= 0;
 exsm:= 1./l;
 rhsm:= 1./(1.2*pow(dsm, exsm)+0.0000012);
 
 rhdn:= 0.;
 if nq<>1 then
 begin
  ddn:= vmnorm(yh[l], ewt)/tesco[nq, 1];
  exdn:= 1./nq;
  rhdn:= 1./(1.3*pow(ddn, exdn)+0.0000013);
 end;
 
  { If meth = 1, limit rh accordinfg to the stability region also. }
 
 if meth=1 then
 begin
  pdh:= max(abs(h)*pdlast, 0.000001);
  if l<lmax then
   rhup:= min(rhup, sm1[l]/pdh);
  rhsm:= min(rhsm, sm1[nq]/pdh);
  if nq>1 then
   rhdn:= min(rhdn, sm1[nq-1]/pdh);
  pdest:= 0.;
 end;
 if rhsm>=rhup then
 begin
  if rhsm>=rhdn then
  begin
   newq:= nq;
   rh:= rhsm;
  end
  else
  begin
   newq:= nq-1;
   rh:= rhdn;
   if (kflag<0)and(rh>1.0) then
    rh:= 1.;
  end;
 end
 else
 begin
  if (rhup<=rhdn) then
  begin
   newq:= nq-1;
   rh:= rhdn;
   if (kflag<0)and(rh>1.0) then
    rh:= 1.;
  end
  else
  begin
   rh:= rhup;
   if (rh>=1.1) then
   begin
    r:= el[l]/l;
    nq:= l;
    l:= nq+1;
    for i:= 1 to n do
     yh[l][i]:= acor[i]*r;
    orderflag:= 2;
    exit;
   end
   else
   begin
    ialth:= 3;
    exit;
   end;
  end;
 end;
 
     { If meth = 1 and h is restricted by stability, bypass 10 percent test. }
 
 if meth=1 then
 begin
  if ((rh*pdh*1.00001)<sm1[newq]) then
   if (kflag=0)and(rh<1.1) then
   begin
    ialth:= 3;
    exit;
   end;
 end
 else
 begin
  if (kflag=0)and(rh<1.1) then
  begin
   ialth:= 3;
   exit;
  end;
 end;
 if kflag<=-2 then
  rh:= min(rh, 0.2);
 
{  If there is a change of order, reset nq, l, and the coefficients.
   In any case h is reset according to rh and the yh array is rescaled.
   Then exit or redo the step. }
 
 if (newq=nq) then
 begin
  orderflag:= 1;
  exit;
 end;
 nq:= newq;
 l:= nq+1;
 orderflag:= 2;
end; {   end orderswitch   }

{**************************************************************}

procedure TLsoda.resetcoeff;
{  The el vector and related constants are reset
   whenever the order nq is changed, or at the start of the problem. }
var
 i: integer;
begin
 for i:= 1 to l do el[i]:= elco[nq, i];
 rc:= rc*el[1]/el0;
 el0:= el[1];
 conit:= 0.5/(nq+2);
end; { end resetcoeff }

{**************************************************************}

procedure TLsoda.correction(neq: integer;
 var y: TVector;
 var corflag: integer;
 pnorm: Double;
 var del, delp, told: Double;
 var ncf: integer;
 var rh: Double;
 var m: integer);

{  *corflag = 0 : corrector converged,
              1 : step size to be reduced, redo prediction,
              2 : corrector cannot converge, failure flag. }

var
 i: integer;
 rm, rate, dcon: Double;
 
{  Up to maxcor corrector iterations are taken.  A convergence test is
   made on the r.m.s. norm of each correction, weighted by the error
   weight vector ewt.  The sum of the corrections is accumulated in the
   vector acor[i].  The yh array is not altered in the corrector loop. }
 
begin
 m:= 0;
 corflag:= 0;
 rate:= 0.;
 del:= 0.;
 for i:= 1 to n do
  y[i]:= yh[1][i];
 FDerivatives(tn, y, savf);
 nfe:= nfe+1;
 
{  If indicated, the matrix P = I - h * el[1] * J is reevaluated and
   preprocessed before starting the corrector iteration.  ipup is set
   to 0 as an indicator that this has been done. }
 
 while (1=1) do
 begin
  if (m=0) then
  begin
   if (ipup>0) then
   begin
    prja(neq, y);
    ipup:= 0;
    rc:= 1.;
    nslp:= nst;
    crate:= 0.7;
    if (ierpj<>0) then
    begin
     corfailure(told, rh, ncf, corflag);
     exit;
    end;
   end;
   for i:= 1 to n do
    acor[i]:= 0.;
  end; {   end if ( *m == 0 )   }
  if (miter=0) then
  begin

{  In case of functional iteration, update y directly from
   the result of the last function evaluation. }

   for i:= 1 to n do
   begin
    savf[i]:= h*savf[i]-yh[2][i];
    y[i]:= savf[i]-acor[i];
   end;
   del:= vmnorm(y, ewt);
   for i:= 1 to n do
   begin
    y[i]:= yh[1][i]+el[1]*savf[i];
    acor[i]:= savf[i];
   end;
  end{   end functional iteration   }

{  In the case of the chord method, compute the corrector error,
   and solve the linear system with that as right-hand side and
   P as coefficient matrix. }

  else
  begin
   for i:= 1 to n do
    y[i]:= h*savf[i]-(yh[2][i]+acor[i]);
   solsy(y);
   del:= vmnorm(y, ewt);
   for i:= 1 to n do
   begin
    acor[i]:= acor[i]+y[i];
    y[i]:= yh[1][i]+el[1]*acor[i];
   end;
  end; {   end chord method   }

{  Test for convergence.  If *m > 0, an estimate of the convergence
   rate constant is stored in crate, and this is used in the test.

   We first check for a change of iterates that is the size of
   roundoff error.  If this occurs, the iteration has converged, and a
   new rate estimate is not formed.
   In all other cases, force at least two iterations to estimate a
   local Lipschitz constant estimate for Adams method.
   On convergence, form pdest = local maximum Lipschitz constant
   estimate.  pdlast is the most recent nonzero estimate. }

  if (del<=100.*pnorm*ETA) then exit;
  if (m<>0)or(meth<>1) then
  begin
   if (m<>0) then
   begin
    rm:= 1024.0;
    if (del<=(1024.*delp)) then
     rm:= del/delp;
    rate:= max(rate, rm);
    crate:= max(0.2*crate, rm);
   end;
   dcon:= del*min(1., 1.5*crate)/(tesco[nq, 2]*conit);
   if (dcon<=1.0) then
   begin
    pdest:= max(pdest, rate/abs(h*el[1]));
    if (pdest<>0.0) then
     pdlast:= pdest;
    exit;
   end;
  end;

{  The corrector iteration failed to converge.
   If miter != 0 and the Jacobian is out of date, prja is called for
   the next try.   Otherwise the yh array is retracted to its values
   before prediction, and h is reduced, if possible.  If h cannot be
   reduced or mxncf failures have occured, exit with corflag = 2. }

  m:= m+1;
  if (m=maxcor)or((m>=2)and(del>2.*delp)) then
  begin
   if (miter=0)or(jcur=1) then
   begin
    corfailure(told, rh, ncf, corflag);
    exit;
   end;
   ipup:= miter;

{  Restart corrector if Jacobian is recomputed. }

   m:= 0;
   rate:= 0.;
   del:= 0.;
   for i:= 1 to n do y[i]:= yh[1][i];
   FDerivatives(tn, y, savf);
   nfe:= nfe+1;
  end

{  Iterate corrector. }

  else
  begin
   delp:= del;
   FDerivatives(tn, y, savf);
   nfe:= nfe+1;
  end;
 end; {   end while   }
end; {   end correction   }

{**************************************************************}

procedure TLsoda.intdy(t: Double; k: integer; var dky: TVector; var iflag: integer);

{  intdy computes interpolated values of the k-th derivative of the
   dependent variable vector y, and stores it in dky.  This routine
   is called within the package with k = 0 and *t = tout, but may
   also be called by the user for any k up to the current order.
   ( See detailed instructions in the usage documentation. )

   The computed values in dky are gotten by interpolation using the
   Nordsieck history array yh.  This array corresponds uniquely to a
   vector-valued polynomial of degree nqcur or less, and dky is set
   to the k-th derivative of this polynomial at t.
   The formula for dky is

             q
   dky[i] = sum c[k][j] * ( t - tn )^(j-k) * h^(-j) * yh[j+1][i]
            j=k

   where c[k][j] = j*(j-1)*...*(j-k+1), q = nqcur, tn = tcur, h = hcur.
   The quantities nq = nqcur, l = nq+1, n = neq, tn, and h are declared
   static globally.  The above sum is done in reverse order.
   *iflag is returned negative if either k or t is out of bounds. }

var
 i, ic, j, jj, jp1: integer;
 c, r, s, tp: Double;
 
begin
 iflag:= 0;
 if (k<0)or(k>nq) then
 begin
  if (prfl=1) then
   //EuConvert writeln('intdy -- k = ', k, ' illegal');
   StdOut.Add('intdy -- k = '+IntToStr(k)+' illegal');
  iflag:= -1;
  exit;
 end;
 tp:= tn-hu-100.*ETA*(tn+hu);
 if ((t-tp)*(t-tn)>0.0) then
 begin
  if (prfl=1) then
  begin
//EuConvert 2
//   writeln('intdy -- t = ', t, ' illegal');
//   writeln('         t not in interval tcur - hu to tcur');
   StdOut.Add('intdy -- t = '+FloatToStr(t)+' illegal');
   StdOut.Add('         t not in interval tcur - hu to tcur');
  end;
  iflag:= -2;
  exit;
 end;
 
 s:= (t-tn)/h;
 ic:= 1;
 for jj:= l-k to nq do
  ic:= ic*jj;
 c:= ic;
 for i:= 1 to n do
  dky[i]:= c*yh[l][i];
 for j:= nq-1 downto k do
 begin
  jp1:= j+1;
  ic:= 1;
  for jj:= jp1-k to j do
   ic:= ic*jj;
  c:= ic;
  for i:= 1 to n do
   dky[i]:= c*yh[jp1][i]+s*dky[i];
 end;
 if (k=0) then exit;
 r:= pow(h, -k);
 for i:= 1 to n do
  dky[i]:= dky[i]*r;
 
end; {   end intdy   }

{**************************************************************}

procedure TLsoda.cfode(meth: integer);
var
 i, nq, nqm1, nqp1: integer;
 agamq, fnq, fnqm1, pint, ragq, rqfac, rq1fac, tsign, xpin: Double;
 pc: vector13;
 
{  cfode is called by the integrator routine to set coefficients
   needed there.  The coefficients for the current method, as
   given by the value of meth, are set for all orders and saved.
   The maximum order assumed here is 12 if meth = 1 and 5 if meth = 2.
   ( A smaller value of the maximum order is also allowed. )
   cfode is called once at the beginning of the problem, and
   is not called again unless and until meth is changed.
 
   The elco array contains the basic method coefficients.
   The coefficients el[i], 1 < i < nq+1, for the method of
   order nq are stored in elco[nq][i].  They are given by a generating
   polynomial, i.e.,
 
      l(x) = el[1] + el[2]*x + ... + el[nq+1]*x^nq.
 
   For the implicit Adams method, l(x) is given by
 
      dl/dx = (x+1)*(x+2)*...*(x+nq-1)/factorial(nq-1),   l(-1) = 0.
 
   For the bdf methods, l(x) is given by
 
      l(x) = (x+1)*(x+2)*...*(x+nq)/k,
 
   where   k = factorial(nq)*(1+1/2+...+1/nq).
 
   The tesco array contains test constants used for the
   local error test and the selection of step size and/or order.
   At order nq, tesco[nq][k] is used for the selection of step
   size at order nq-1 if k = 1, at order nq if k = 2, and at order
   nq+1 if k = 3. }
 
begin
 if (meth=1) then
 begin
  elco[1, 1]:= 1.;
  elco[1, 2]:= 1.;
  tesco[1, 1]:= 0.;
  tesco[1, 2]:= 2.;
  tesco[2, 1]:= 1.;
  tesco[12, 3]:= 0.;
  pc[1]:= 1.;
  rqfac:= 1.;
  for nq:= 2 to 12 do
  begin
         { The pc array will contain the coefficients of the polynomial

         p(x) = (x+1)*(x+2)*...*(x+nq-1).

         Initially, p(x) = 1. }

   rq1fac:= rqfac;
   rqfac:= rqfac/nq;
   nqm1:= nq-1;
   fnqm1:= nqm1;
   nqp1:= nq+1;

         { Form coefficients of p(x)*(x+nq-1). }

   pc[nq]:= 0.;
   for i:= nq downto 2 do
    pc[i]:= pc[i-1]+fnqm1*pc[i];
   pc[1]:= fnqm1*pc[1];

         { Compute integral, -1 to 0, of p(x) and x*p(x). }

   pint:= pc[1];
   xpin:= pc[1]/2.;
   tsign:= 1.;
   for i:= 2 to nq do
   begin
    tsign:= -tsign;
    pint:= pint+tsign*pc[i]/i;
    xpin:= xpin+tsign*pc[i]/(i+1);
   end;

         { Store coefficients in elco and tesco. }

   elco[nq, 1]:= pint*rq1fac;
   elco[nq, 2]:= 1.;
   for i:= 2 to nq do
    elco[nq, i+1]:= rq1fac*pc[i]/i;
   agamq:= rqfac*xpin;
   ragq:= 1./agamq;
   tesco[nq, 2]:= ragq;
   if (nq<12) then
    tesco[nqp1, 1]:= ragq*rqfac/nqp1;
   tesco[nqm1, 3]:= ragq;
  end; { end for }
  exit;
 end; { end if meth == 1 }
 
  { meth = 2. }
 
 pc[1]:= 1.;
 rq1fac:= 1.;
 
  { The pc array will contain the coefficients of the polynomial
 
  p(x) = (x+1)*(x+2)*...*(x+nq).
 
  Initially, p(x) = 1. }
 
 for nq:= 1 to 5 do
 begin
  fnq:= nq;
  nqp1:= nq+1;

      { Form coefficients of p(x)*(x+nq). }

  pc[nqp1]:= 0.;
  for i:= nq+1 downto 2 do
   pc[i]:= pc[i-1]+fnq*pc[i];
  pc[1]:= pc[1]*fnq;

      { Store coefficients in elco and tesco. }

  for i:= 1 to nqp1 do
   elco[nq, i]:= pc[i]/pc[2];
  elco[nq, 2]:= 1.;
  tesco[nq, 1]:= rq1fac;
  tesco[nq, 2]:= nqp1/elco[nq, 1];
  tesco[nq, 3]:= (nq+2)/elco[nq, 1];
  rq1fac:= rq1fac/fnq;
 end;
end; {   end cfode   }

{**************************************************************}

procedure TLsoda.scaleh(var rh, pdh: Double);
var
 r: Double;
 j, i: integer;
 
{  If h is being changed, the h ratio rh is checked against
   rmax, hmin, and hmxi, and the yh array is rescaled.  ialth is set to
   l = nq + 1 to prevent a change of h for that many steps, unless
   forced by a convergence or error test failure. }
 
begin
 rh:= min(rh, rmax);
 rh:= rh/max(1., abs(h)*hmxi*rh);
 
{  If meth = 1, also restrict the new step size by the stability region.
   If this reduces h, set irflag to 1 so that if there are roundoff
   problems later, we can assume that is the cause of the trouble.}
 
 if (meth=1) then
 begin
  irflag:= 0;
  pdh:= max(abs(h)*pdlast, 0.000001);
  if ((rh*pdh*1.00001)>=sm1[nq]) then
  begin
   rh:= sm1[nq]/pdh;
   irflag:= 1;
  end;
 end;
 r:= 1.;
 for j:= 2 to l do
 begin
  r:= r*rh;
  for i:= 1 to n do
   yh[j][i]:= yh[j][i]*r;
 end;
 h:= h*rh;
 rc:= rc*rh;
 ialth:= l;
end; {   end scaleh   }

{**************************************************************}

procedure TLsoda.stoda(var neq: integer; var y: TVector);
var
 corflag, orderflag, i, i1, j, jb, m, ncf: integer;
 del, delp, dsm, dup, exup, r, rh, rhup, told, pdh, pnorm: Double;
 
{  stoda performs one step of the integration of an initial value
   problem for a system of ordinary differential equations.
   Note.. stoda is independent of the value of the iteration method
   indicator miter, when this is != 0, and hence is independent
   of the type of chord method used, or the Jacobian structure.
   Communication with stoda is done with the following variables:
 
   jstart = an integer used for input only, with the following
            values and meanings:
 
               0  perform the first step,
             > 0  take a new step continuing from the last,
              -1  take the next step with a new value of h,
                  n, meth, miter, and/or matrix parameters.
              -2  take the next step with a new value of h,
                  but with other inputs unchanged.
 
   kflag = a completion code with the following meanings:
 
             0  the step was successful,
            -1  the requested error could not be achieved,
            -2  corrector convergence could not be achieved,
            -3  fatal error in prja or solsy.
 
   miter = corrector iteration method:
 
             0  functional iteration,
            >0  a chord method corresponding to jacobian type jt. }
 
begin
// EuAdd 2
 Application.ProcessMessages;
 if fAborted then exit;
 kflag:= 0;
 told:= tn;
 ncf:= 0;
 ierpj:= 0;
 iersl:= 0;
 jcur:= 0;
 delp:= 0.;
 
{  On the first call, the order is set to 1, and other variables are
   initialized.  rmax is the maximum ratio by which h can be increased
   in a single step.  It is initially 1.e4 to compensate for the small
   initial h, but then is normally equal to 10.  If a filure occurs
   (in corrector convergence or error test), rmax is set at 2 for
   the next increase.
   cfode is called to get the needed coefficients for both methods. }
 
 if (jstart=0) then
 begin
  lmax:= maxord+1;
  nq:= 1;
  l:= 2;
  ialth:= 2;
  rmax:= 10000.;
  rc:= 0.;
  el0:= 1.;
  crate:= 0.7;
  hold:= h;
  nslp:= 0;
  ipup:= miter;

{ Initialize switching parameters.  meth = 1 is assumed initially. }

  icount:= 20;
  irflag:= 0;
  pdest:= 0.;
  pdlast:= 0.;
  ratio:= 5.;
  cfode(2);
  for i:= 1 to 5 do
   cm2[i]:= tesco[i, 2]*elco[i, i+1];
  cfode(1);
  for i:= 1 to 12 do
   cm1[i]:= tesco[i, 2]*elco[i, i+1];
  resetcoeff;
 end; {   end if ( jstart == 0 )   }
 
{  The following block handles preliminaries needed when jstart = -1.
   ipup is set to miter to force a matrix update.
   If an order increase is about to be considered ( ialth = 1 ),
   ialth is reset to 2 to postpone consideration one more step.
   If the caller has changed meth, cfode is called to reset
   the coefficients of the method.
   If h is to be changed, yh must be rescaled.
   If h or meth is being changed, ialth is reset to l = nq + 1
   to prevent further changes in h for that many steps. }
 
 if (jstart=-1) then
 begin
  ipup:= miter;
  lmax:= maxord+1;
  if (ialth=1) then
   ialth:= 2;
  if (meth<>mused) then
  begin
   cfode(meth);
   ialth:= l;
   resetcoeff;
  end;
  if (h<>hold) then
  begin
   rh:= h/hold;
   h:= hold;
   scaleh(rh, pdh);
  end;
 end; {   if ( jstart == -1 )   }
 
 if (jstart=-2) then
 begin
  if (h<>hold) then
  begin
   rh:= h/hold;
   h:= hold;
   scaleh(rh, pdh);
  end;
 end; {   if ( jstart == -2 )   }
 
{  Prediction.
   This section computes the predicted values by effectively
   multiplying the yh array by the pascal triangle matrix.
   rc is the ratio of new to old values of the coefficient h * el[1].
   When rc differs from 1 by more than ccmax, ipup is set to miter
   to force pjac to be called, if a jacobian is involved.
   In any case, prja is called at least every msbp steps. }
 
 while (1=1) do
 begin
  repeat
   if (abs(rc-1.0)>ccmax) then
    ipup:= miter;
   if (nst>=nslp+msbp) then
    ipup:= miter;
   tn:= tn+h;
   for j:= nq downto 1 do
    for i1:= j to nq do
    begin
     for i:= 1 to n do
      yh[i1][i]:= yh[i1][i]+yh[i1+1][i];
    end;
   pnorm:= vmnorm(yh[1], ewt);
   correction(neq, y, corflag, pnorm, del, delp, told, ncf, rh, m);
   if (corflag=1) then
   begin
    rh:= max(rh, hmin/abs(h));
    scaleh(rh, pdh);
   end;
   if (corflag=2) then
   begin
    kflag:= -2;
    hold:= h;
    jstart:= 1;
    exit;
   end;
  until (corflag=0); {   end inner while ( corrector loop )   }

{  The corrector has converged.  jcur is set to 0
   to signal that the Jacobian involved may need updating later.
   The local error test is done now. }

  jcur:= 0;
  if (m=0) then
   dsm:= del/tesco[nq, 2];
  if (m>0) then
   dsm:= vmnorm(acor, ewt)/tesco[nq, 2];
  if (dsm<=1.0) then
  begin

{  After a successful step, update the yh array.
   Decrease icount by 1, and if it is -1, consider switching methods.
   If a method switch is made, reset various parameters,
   rescale the yh array, and exit.  If there is no switch,
   consider changing h if ialth = 1.  Otherwise decrease ialth by 1.
   If ialth is then 1 and nq < maxord, then acor is saved for
   use in a possible order increase on the next step.
   If a change in h is considered, an increase or decrease in order
   by one is considered also.  A change in h is made only if it is by
   a factor of at least 1.1.  If not, ialth is set to 3 to prevent
   testing for that many steps. }

   kflag:= 0;
   nst:= nst+1;
// EuAdd 2
   Application.ProcessMessages;
   if fAborted then exit;
   hu:= h;
   nqu:= nq;
   mused:= meth;
   for j:= 1 to l do
   begin
    r:= el[j];
    for i:= 1 to n do
     yh[j][i]:= yh[j][i]+r*acor[i];
   end;
   icount:= icount-1;
   if (icount<0) then
   begin
    methodswitch(dsm, pnorm, pdh, rh);
    if (meth<>mused) then
    begin
     rh:= max(rh, hmin/abs(h));
     scaleh(rh, pdh);
     rmax:= 10.;
     endstoda;
     exit;
    end;
   end;

{  No method switch is being made.  Do the usual step/order selection. }

   ialth:= ialth-1;
   if (ialth=0) then
   begin
    rhup:= 0.;
    if (l<>lmax) then
    begin
     for i:= 1 to n do
      savf[i]:= acor[i]-yh[lmax][i];
     dup:= vmnorm(savf, ewt)/tesco[nq, 3];
     exup:= 1./(l+1);
     rhup:= 1./(1.4*pow(dup, exup)+0.0000014);
    end;
    orderswitch(rhup, dsm, pdh, rh, orderflag);

{  No change in h or nq. }

    if (orderflag=0) then
    begin
     endstoda;
     exit;
    end;

{  h is changed, but not nq. }

    if (orderflag=1) then
    begin
     rh:= max(rh, hmin/abs(h));
     scaleh(rh, pdh);
     rmax:= 10.;
     endstoda;
     exit;
    end;

{  both nq and h are changed. }

    if (orderflag=2) then
    begin
     resetcoeff;
     rh:= max(rh, hmin/abs(h));
     scaleh(rh, pdh);
     rmax:= 10.;
     endstoda;
     exit;
    end;
   end; {   end if ( ialth == 0 )   }
   if (ialth>1)or(l=lmax) then
   begin
    endstoda;
    exit;
   end;
   for i:= 1 to n do
    yh[lmax][i]:= acor[i];
   endstoda;
   exit;
  end{   end if ( dsm <= 1. )   }

{  The error test failed.  kflag keeps track of multiple failures.
   Restore tn and the yh array to their previous values, and prepare
   to try the step again.  Compute the optimum step size for this or
   one lower.  After 2 or more failures, h is forced to decrease
   by a factor of 0.2 or less.    }

  else
  begin
   kflag:= kflag-1;
   tn:= told;
   for j:= nq downto 1 do
    for i1:= j to nq do
    begin
     for i:= 1 to n do
      yh[i1][i]:= yh[i1][i]-yh[i1+1][i];
    end;
   rmax:= 2.;
   if (abs(h)<=hmin*1.00001) then
   begin
    kflag:= -1;
    hold:= h;
    jstart:= 1;
    exit;
   end;
   if (kflag>-3) then
   begin
    rhup:= 0.;
    orderswitch(rhup, dsm, pdh, rh, orderflag);
    if (orderflag=1)or(orderflag=0) then
    begin
     if (orderflag=0) then
      rh:= min(rh, 0.2);
     rh:= max(rh, hmin/abs(h));
     scaleh(rh, pdh);
    end;
    if (orderflag=2) then
    begin
     resetcoeff;
     rh:= max(rh, hmin/abs(h));
     scaleh(rh, pdh);
    end;
   end{   if ( kflag > -3 )   }

{  Control reaches this section if 3 or more failures have occurred.
   If 10 failures have occurred, exit with kflag = -1.
   It is assumed that the derivatives that have accumulated in the
   yh array have errors of the wrong order.  Hence the first
   derivative is recomputed, and the order is set to 1.  Then
   h is reduced by a factor of 10, and the step is retried,
   until it succeeds or h reaches hmin. }

   else
   begin
    if (kflag=-10) then
    begin
     kflag:= -1;
     hold:= h;
     jstart:= 1;
     exit;
    end
    else
    begin
     rh:= 0.1;
     rh:= max(hmin/abs(h), rh);
     h:= h*rh;
     for i:= 1 to n do y[i]:= yh[1][i];
     FDerivatives(tn, y, savf);
     nfe:= nfe+1;
     for i:= 1 to n do
      yh[2][i]:= h*savf[i];
     ipup:= miter;
     ialth:= 5;
     if (nq<>1) then
     begin
      nq:= 1;
      l:= 2;
      resetcoeff;
     end;
    end;
   end; {   end else -- kflag <= -3 }
  end; {   end error failure handling   }
 end; {   end outer while   }
end; {   end stoda   }

{**************************************************************}

procedure TLsoda.Execute(var y: TVector; var t, tout: Double);

{  If the user does not supply any of these values, the calling program
   should initialize those untouched working variables to zero.

   ml = iwork1
   mu = iwork2
   ixpr = iwork5
   mxstep = iwork6
   mxhnil = iwork7
   mxordn = iwork8
   mxords = iwork9

   tcrit = rwork1
   h0 = rwork5
   hmax = rwork6
   hmin = rwork7 }

var
 mxstp0, mxhnl0, i, i1, i2, iflag, kgo, lf0, lenyh, ihit: integer;
 atoli, ayi, big, ewti, h0, hmax, hmx, rh, rtoli,
  tcrit, tdist, tnext, tol, tp, size, sum, w0: Double;
 
begin
// EuAdd 1
 fAborted:= False;
 mxstp0:= 5000;
 mxhnl0:= 10;
{  Block a.
   This code block is executed on every call.
   It tests *istate and itask for legality and branches appropriately.
   If *istate > 1 but the flag init shows that initialization has not
   yet been done, an error return occurs.
   If *istate = 1 and tout = t, return immediately. }
 
 if (istate=1) then
 begin
  illin:= 0; init:= 0; ntrep:= 0; ixpr:= 0;
 end;
 if (istate<1)or(istate>3) then
 begin
  if (prfl=1) then
   //EuConvert writeln('lsoda -- illegal istate =', istate);
   StdOut.Add('lsoda -- illegal istate= '+IntToStr(istate));
  terminate(Fistate);
  exit;
 end;
 if (itask<1)or(itask>5) then
 begin
  if (prfl=1) then
   //EuConvert writeln('lsoda -- illegal itask =', itask);
   StdOut.Add('lsoda -- illegal itask= '+IntToStr(itask));
  terminate(Fistate);
  exit;
 end;
 if (init=0)and((istate=2)or(istate=3)) then
 begin
  if (prfl=1) then
   //EuConvert writeln('lsoda -- istate > 1 but lsoda not initialized');
   StdOut.Add('lsoda -- istate > 1 but lsoda not initialized');
  terminate(Fistate);
  exit;
 end;
 if (istate=1) then
 begin
  init:= 0;
  if (tout=t) then
  begin
   ntrep:= ntrep+1;
   if (ntrep<5) then exit;
   if (prfl=1) then
   begin
// EuConvert 2
//    writeln('lsoda -- repeated calls with istate = 1 and tout = t');
//    writeln('         run aborted.. apparent infinite loop');
    StdOut.Add('lsoda -- repeated calls with istate = 1 and tout = t');
    StdOut.Add('         run aborted.. apparent infinite loop');
   end;
   exit;
  end;
 end;
{  Block b.
   The next code block is executed for the initial call ( *istate = 1 ),
   or for a continuation call with parameter changes ( *istate = 3 ).
   It contains checking of all inputs and various initializations.
   First check legality of the non-optional inputs neq, itol, iopt,
   jt, ml, and mu. }
 
 if (istate=1)or(istate=3) then
 begin
  ntrep:= 0;
  if (neq<=0) then
  begin
   if (prfl=1) then // EuConvert writeln('lsoda -- neq =', neq, ' is less than 1');
    StdOut.Add('lsoda -- neq= '+IntToStr(neq)+' is less than 1');
   terminate(Fistate);
   exit;
  end;
  if (istate=3)and(neq>n) then
  begin
   if (prfl=1) then // EuConvert     writeln('lsoda -- istate = 3 and neq increased');
    StdOut.Add('lsoda -- istate = 3 and neq increased');
   terminate(Fistate);
   exit;
  end;
  n:= neq;
  if (itol<1)or(itol>4) then
  begin
   if (prfl=1) then // EuConvert writeln('lsoda -- itol = ', itol, ' illegal');
    StdOut.Add('lsoda -- itol= '+IntToStr(itol)+' illegal');
   terminate(Fistate);
   exit;
  end;
  if (iopt<0)or(iopt>1) then
  begin
   if (prfl=1) then // EuConvert     writeln('lsoda -- iopt = ', iopt, ' illegal');
    StdOut.Add('lsoda -- iopt= '+IntToStr(iopt)+' illegal');
   terminate(Fistate);
   exit;
  end;
  if (jt=3)or(jt<1)or(jt>5) then
  begin
   if (prfl=1) then //EuConvert     writeln('lsoda -- jt = ', jt, ' illegal');
    StdOut.Add('lsoda -- jt= '+IntToStr(jt)+' illegal');
   terminate(Fistate);
   exit;
  end;
  jtyp:= jt;

{ Next process and check the optional inputs.   }
{ Default options.   }

  if (iopt=0) then
  begin
   ixpr:= 0;
   mxstep:= mxstp0;
   mxhnil:= mxhnl0;
   hmxi:= 0.;
   hmin:= 0.;
   if (istate=1) then
   begin
    h0:= 0.;
    mxordn:= mord[1];
    mxords:= mord[2];
   end;
  end{ end if ( iopt == 0 ) }

{ Optional inputs. }

  else { if ( iopt = 1 )  }
  begin
   ixpr:= iwork5;
   if (ixpr<0)or(ixpr>2) then
   begin
    if (prfl=1) then //EuConvert writeln('lsoda -- ixpr = ', ixpr, ' is illegal');
     StdOut.Add('lsoda -- ixpr= '+IntToStr(ixpr)+' is illegal');
    terminate(Fistate);
    exit;
   end;
   mxstep:= iwork6;
   if (mxstep<0) then
   begin
    if (prfl=1) then //EuConvert       writeln('lsoda -- mxstep < 0');
     StdOut.Add('lsoda -- mxstep < 0');
    terminate(Fistate);
    exit;
   end;
   if (mxstep=0) then
    mxstep:= mxstp0;
   mxhnil:= iwork7;
   if (mxhnil<0) then
   begin
    if (prfl=1) then //EuConvert writeln('lsoda -- mxhnil < 0');
     StdOut.Add('lsoda -- mxhnil < 0');
    terminate(Fistate);
    exit;
   end;
   if (istate=1) then
   begin
    h0:= rwork5;
    mxordn:= iwork8;
    if (mxordn<0) then
    begin
     if (prfl=1) then //EuConvert writeln('lsoda -- mxordn = ', mxordn, ' is less than 0');
      StdOut.Add('lsoda -- mxordn= '+IntToStr(mxordn)+' is less than 0');
     terminate(Fistate);
     exit;
    end;
    if (mxordn=0) then
     mxordn:= 100;
    mxordn:= mini(mxordn, mord[1]);
    mxords:= iwork9;
    if (mxords<0) then
    begin
     if (prfl=1) then //EuConvert writeln('lsoda -- mxords = ', mxords, ' is less than 0');
      StdOut.Add('lsoda -- mxords= '+IntToStr(mxords)+' is less than 0');
     terminate(Fistate);
     exit;
    end;
    if (mxords=0) then
     mxords:= 100;
    mxords:= mini(mxords, mord[2]);
    if ((tout-t)*h0<0.0) then
    begin
     if (prfl=1) then
     begin//EuConvert 2
//      writeln('lsoda -- tout = ', tout, ' behind t = ', t);
//      writeln('         integration direction is given by ', h0);
      StdOut.Add('lsoda -- tout= '+FloatToStr(tout)+' behind t= '+FloatToStr(t));
      StdOut.Add('         integration direction is given by '+FloatToStr(h0));
     end;
     terminate(Fistate);
     exit;
    end;
   end; {  end if ( *istate == 1 )  }
   hmax:= rwork6;
   if (hmax<0.0) then
   begin
    if (prfl=1) then //EuConvert   writeln('lsoda -- hmax < 0.');
     StdOut.Add('lsoda -- hmax < 0.');
    terminate(Fistate);
    exit;
   end;
   hmxi:= 0.;
   if (hmax>0) then
    hmxi:= 1./hmax;
   hmin:= rwork7;
   if (hmin<0.0) then
   begin
    if (prfl=1) then //EuConvert   writeln('lsoda -- hmin < 0.');
     StdOut.Add('lsoda -- hmin < 0.');
    terminate(Fistate);
    exit;
   end;
  end; { end else }{ end iopt = 1  }
 end; { end if ( *istate == 1 || *istate == 3 ) }
 
{  If *istate = 1, meth is initialized to 1. }
 
 if (istate=1) then
 begin

{  If memory were not freed, *istate = 3 need not reallocate memory.
   Hence this section is not executed by *istate = 3. }

  sqrteta:= Sqrt(ETA);
  meth:= 1;
  nyh:= n;
  lenyh:= 1+maxi(mxordn, mxords);

 end;
 
{  Check rtol and atol for legality. }
 
 if (istate=1)or(istate=3) then
 begin
  rtoli:= rtol[1];
  atoli:= atol[1];
  for i:= 1 to n do
  begin
   if (itol>=3) then
    rtoli:= rtol[i];
   if (itol=2)or(itol=4) then
    atoli:= atol[i];
   if (rtoli<0.0) then
   begin
    if (prfl=1) then //EuConvert writeln('lsoda -- rtol = ', rtoli, ' is less than 0.');
     StdOut.Add('lsoda -- rtol = '+FloatToStr(rtoli)+' is less than 0.');
    terminate(Fistate);
    exit;
   end;
   if (atoli<0.0) then
   begin
    if (prfl=1) then //EuConvert writeln('lsoda -- atol = ', atoli, ' is less than 0.');
     StdOut.Add('lsoda -- atol = '+FloatToStr(atoli)+' is less than 0.');
    terminate(Fistate);
    exit;
   end;
  end; {   end for   }
 end; {   end if ( *istate == 1 || *istate == 3 )   }
 
{  If *istate = 3, set flag to signal parameter changes to stoda. }
 
 if (istate=3) then
  jstart:= -1;
 
{  Block c.
   The next block is for the initial call only ( *istate = 1 ).
   It contains all remaining initializations, the initial call to f,
   and the calculation of the initial step size.
   The error weights in ewt are inverted after being loaded. }
 
 if (istate=1) then
 begin
  tn:= t;
  tsw:= t;
  maxord:= mxordn;
  if (itask=4)or(itask=5) then
  begin
   tcrit:= rwork1;
   if ((tcrit-tout)*(tout-t)<0.0) then
   begin
    if (prfl=1) then //EuConvert writeln('lsoda -- itask = 4 or 5 and tcrit behind tout');
     StdOut.Add('lsoda -- itask = 4 or 5 and tcrit behind tout');
    terminate(Fistate);
    exit;
   end;
   if (h0<>0)and((t+h0-tcrit)*h0>0.0) then
    h0:= tcrit-t;
  end;
  jstart:= 0;
  nhnil:= 0;
  nst:= 0;
  nje:= 0;
  nslast:= 0;
  hu:= 0.;
  nqu:= 0;
  mused:= 0;
  miter:= 0;
  ccmax:= 0.3;
  maxcor:= 3;
  msbp:= 20;
  mxncf:= 10;

      { Initial call to fuction  }
  FDerivatives(t, y, yh[2]);
  nfe:= 1;

      { Load the initial value vector in yh.}

  for i:= 1 to n do
   yh[1][i]:= y[i];

      { Load and invert the ewt array.  ( h is temporarily set to 1. ) }

  nq:= 1;
  h:= 1.;
  ewset(Fitol, Frtol, Fatol, y);
  for i:= 1 to n do
  begin
   if (ewt[i]<=0.0) then
   begin
    if (prfl=1) then //EuConvert writeln('lsoda -- ewt[', i, '] = ', ewt[i], ' <= 0.');
     StdOut.Add('lsoda -- ewt['+IntToStr(i)+'] = '+FloatToStr(ewt[i])+' <= 0.');
    terminate2(y, t);
    exit;
   end;
   ewt[i]:= 1./ewt[i];
  end;

{  The coding below computes the step size, h0, to be attempted on the
   first step, unless the user has supplied a value for this.
   First check that tout - *t differs significantly from zero.
   A scalar tolerance quantity tol is computed, as max(rtol[i])
   if this is positive, or max(atol[i]/fabs(y[i])) otherwise, adjusted
   so as to be between 100*ETA and 0.001.
   Then the computed value h0 is given by

      h0^(-2) = 1. / ( tol * w0^2 ) + tol * ( norm(f) )^2

   where   w0     = max( fabs(*t), fabs(tout) ),
           f      = the initial value of the vector f(t,y), and
           norm() = the weighted vector norm used throughout, given by
                    the vmnorm function routine, and weighted by the
                    tolerances initially loaded into the ewt array.

   The sign of h0 is inferred from the initial values of tout and *t.
   fabs(h0) is made < fabs(tout-*t) in any case. }

  if (h0=0.0) then
  begin
   tdist:= abs(tout-t);
   w0:= max(abs(t), abs(tout));
   if (tdist<2.*ETA*w0) then
   begin
    if (prfl=1) then //EuConvert writeln('lsoda -- tout too close to t to start integration');
     StdOut.Add('lsoda -- tout too close to t to start integration');
    terminate(Fistate);
    exit;
   end;
   tol:= rtol[1];
   if (itol>2) then
   begin
    for i:= 2 to n do
     tol:= max(tol, rtol[i]);
   end;
   if (tol<=0.0) then
   begin
    atoli:= atol[1];
    for i:= 1 to n do
    begin
     if (itol=2)or(itol=4) then
      atoli:= atol[i];
     ayi:= abs(y[i]);
     if (ayi<>0.0) then
      tol:= max(tol, atoli/ayi);
    end;
   end;
   tol:= max(tol, 100.*ETA);
   tol:= min(tol, 0.001);
   sum:= vmnorm(yh[2], ewt);
   sum:= 1./(tol*w0*w0)+tol*sum*sum;
   h0:= 1./sqrt(sum);
   h0:= min(h0, tdist);
   if (tout-t<0) then h0:= -h0;
  end; {   end if ( h0 == 0. )   }

{  Adjust h0 if necessary to meet hmax bound. }

  rh:= abs(h0)*hmxi;
  if (rh>1.0) then
   h0:= h0/rh;

{  Load h with h0 and scale yh[2] by h0. }

  h:= h0;
  for i:= 1 to n do
   yh[2][i]:= yh[2][i]*h0;
 end; { if ( *istate == 1 )   }
 
{  Block d.
   The next code block is for continuation calls only ( *istate = 2 or 3 )
   and is to check stop conditions before taking a step. }
 
 if (istate=2)or(istate=3) then
 begin
  nslast:= nst;
  case itask of
   1:
    begin
     if ((tn-tout)*h>=0.0) then
     begin
      intdy(tout, 0, y, iflag);
      if (iflag<>0) then
      begin
       if (prfl=1) then //EuConvert writeln('lsoda -- trouble from intdy, itask = ', itask, ', tout = ', tout);
        StdOut.Add('lsoda -- trouble from intdy, itask= '+IntToStr(itask)+', tout= '+FloatToStr(tout));
       terminate(Fistate);
       exit;
      end;
      t:= tout;
      istate:= 2;
      illin:= 0;
      exit;
     end;
    end;
   2:
    begin end;
   3:
    begin
     tp:= tn-hu*(1.+100.*ETA);
     if ((tp-tout)*h>0.0) then
     begin
      if (prfl=1) then //EuConvert writeln('lsoda -- itask = ', itask, ' and tout behind tcur - hu');
       StdOut.Add('lsoda -- itask= '+IntToStr(itask)+' and tout behind tcur - hu');
      terminate(Fistate);
      exit;
     end;
     if ((tn-tout)*h>=0.0) then
     begin
      successreturn(y, t, itask, ihit, tcrit, Fistate);
      exit;
     end;
    end;
   4:
    begin
     tcrit:= rwork1;
     if ((tn-tcrit)*h>0.0) then
     begin
      if (prfl=1) then //EuConvert writeln('lsoda -- itask = 4 or 5 and tcrit behind tcur');
       StdOut.Add('lsoda -- itask = 4 or 5 and tcrit behind tcur');
      terminate(Fistate);
      exit;
     end;
     if ((tcrit-tout)*h<0.0) then
     begin
      if (prfl=1) then //EuConvert writeln('lsoda -- itask = 4 or 5 and tcrit behind tout');
       StdOut.Add('lsoda -- itask = 4 or 5 and tcrit behind tout');
      terminate(Fistate);
      exit;
     end;
     if ((tn-tout)*h>=0.0) then
     begin
      intdy(tout, 0, y, iflag);
      if (iflag<>0) then
      begin
       if (prfl=1) then //EuConvert writeln('lsoda -- trouble from intdy, itask = ', itask, ', tout = ', tout);
        StdOut.Add('lsoda -- trouble from intdy, itask= '+IntToStr(itask)+', tout= '+FloatToStr(tout));
       terminate(Fistate);
       exit;
      end;
      t:= tout;
      istate:= 2;
      illin:= 0;
      exit;
     end;
    end;
   5:
    begin
     if (itask=5) then
     begin
      tcrit:= rwork1;
      if ((tn-tcrit)*h>0.0) then
      begin
       if (prfl=1) then //EuConvert writeln('lsoda -- itask = 4 or 5 and tcrit behind tcur');
        StdOut.Add('lsoda -- itask = 4 or 5 and tcrit behind tcur');
       terminate(Fistate);
       exit;
      end;
     end;
     hmx:= abs(tn)+abs(h);
     if (abs(tn-tcrit)<=(100.*ETA*hmx)) then ihit:= 1
     else ihit:= 0;
     if (ihit=1) then
     begin
      t:= tcrit;
      successreturn(y, t, itask, ihit, tcrit, Fistate);
      exit;
     end;
     tnext:= tn+h*(1.+4.*ETA);
     if ((tnext-tcrit)*h>0.0) then
     begin
      h:= (tcrit-tn)*(1.-4.*ETA);
      if (istate=2) then jstart:= -2;
     end;
    end;
  end; {   end switch   }
 end; {   end if ( *istate == 2 || *istate == 3 )   }
 
{  Block e.
   The next block is normally executed for all calls and contains
   the call to the one-step core integrator stoda.
 
   This is a looping point for the integration steps.
 
   First check for too many steps being taken, update ewt ( if not at
   start of problem).  Check for too much accuracy being requested, and
   check for h below the roundoff level in *t. }
 
 while (1=1) do
 begin
  if (istate<>1)or(nst<>0) then
  begin
   if ((nst-nslast)>=mxstep) then
   begin
    if (prfl=1) then //EuConvert writeln('lsoda -- ', mxstep, ' steps taken before reaching tout');
     StdOut.Add('lsoda -- '+IntToStr(mxstep)+' steps taken before reaching tout');
    istate:= -1;
    terminate2(y, t);
    exit;
   end;
   ewset(Fitol, Frtol, Fatol, yh[1]);
   for i:= 1 to n do
   begin
    if (ewt[i]<=0.0) then
    begin
     if (prfl=1) then //EuConvert writeln('lsoda -- ewt[', i, '] = ', ewt[i], ' <= 0.');
      StdOut.Add('lsoda -- ewt['+IntToStr(i)+']= '+FloatToStr(ewt[i])+' <= 0.');
     istate:= -6;
     terminate2(y, t);
     exit;
    end;
//qq    ewt[i]:= 1./ewt[i];
    if ewt[i]>1.0E-308 then
     ewt[i]:= 1./ewt[i]
    else
     ewt[i]:= 1.0E308;
   end;
  end;
  tolsf:= ETA*vmnorm(yh[1], ewt);
  if (tolsf>0.01) then
  begin
   tolsf:= tolsf*200.;
   if (nst=0) then
   begin
    if (prfl=1) then
    begin//EuConvert 3
//     writeln('lsoda -- at start of problem, too much accuracy');
//     writeln('         requested for precision of machine,');
//     writeln('         suggested scaling factor = ', tolsf);
     StdOut.Add('lsoda -- at start of problem, too much accuracy');
     StdOut.Add('         requested for precision of machine,');
     StdOut.Add('         suggested scaling factor = '+FloatToStr(tolsf));
    end;
    terminate(Fistate);
    exit;
   end;
   if (prfl=1) then
   begin//EuConvert 3
//    writeln('lsoda -- at t = ', t, ', too much accuracy requested');
//    writeln('         for precision of machine, suggested');
//    writeln('         scaling factor = ', tolsf);
    StdOut.Add('lsoda -- at t= '+FloatToStr(t)+', too much accuracy requested');
    StdOut.Add('         for precision of machine, suggested');
    StdOut.Add('         scaling factor= '+FloatToStr(tolsf));
   end;
   istate:= -2;
   terminate2(y, t);
   exit;
  end;
  if ((tn+h)=tn) then
  begin
   nhnil:= nhnil+1;
   if (nhnil<=mxhnil) then
   begin
    if (prfl=1) then
    begin//EuConvert 3
//     writeln('lsoda -- warning..internal t = ', tn, ' and h = ', h, ' are');
//     writeln('         such that in the machine, t + h = t on the next step');
//     writeln('         solver will continue anyway.');
     StdOut.Add('lsoda -- warning..internal t= '+FloatToStr(tn)+' and h= '+FloatToStr(h)+' are');
     StdOut.Add('         such that in the machine, t + h = t on the next step');
     StdOut.Add('         solver will continue anyway.');
    end;
    if (nhnil=mxhnil)and(prfl=1) then
    begin//EuConvert 2
//     writeln('lsoda -- above warning has been issued ', nhnil, ' times,');
//     writeln('         it will not be issued again for this problem');
     StdOut.Add('lsoda -- above warning has been issued '+IntToStr(nhnil)+' times,');
     StdOut.Add('         it will not be issued again for this problem');
    end;
   end;
  end;

// EuAdd 2
  Application.ProcessMessages;
  if fAborted then exit;
{  Call stoda }
  stoda(neq, y);

{ Print extra information  }

  if (ixpr=2)and(prfl=1) then
  begin//EuConver 2
//   writeln('meth= ', meth, ',   order= ', nq, ',   nfe= ', nfe, ',   nje= ', nje);
//   writeln('t= ', tn, ',   h= ', h, ',   nst= ', nst);
   StdOut.Add('meth= '+IntToStr(meth)+',   order= '+IntToStr(nq)+',   nfe= '+IntToStr(nfe)+',   nje= '+IntToStr(nje));
   StdOut.Add('t= '+FloatToStr(tn)+',   h= '+FloatToStr(h)+',   nst= '+IntToStr(nst));
  end;

  if (kflag=0) then
  begin

{  Block f.
   The following block handles the case of a successful return from the
   core integrator ( kflag = 0 ).
   If a method switch was just made, record tsw, reset maxord,
   set jstart to -1 to signal stoda to complete the switch,
   and do extra printing of data if ixpr != 0.
   Then, in any case, check for stop conditions. }

   init:= 1;
   if (meth<>mused) then
   begin
    tsw:= tn;
    maxord:= mxordn;
    if (meth=2) then
     maxord:= mxords;
    jstart:= -1;
    if (ixpr=1)and(prfl=1) then
    begin
     if (meth=2) then //EuConver writeln('lsoda -- a switch to the stiff method has occurred');
      StdOut.Add('lsoda -- a switch to the stiff method has occurred');
     if (meth=1) then //EuConver 2 writeln('lsoda -- a switch to the nonstiff method has occurred');
      StdOut.Add('lsoda -- a switch to the nonstiff method has occurred');
//     writeln('         at t = ', tn, ', tentative step size h = ', h, ', step nst = ', nst);
     StdOut.Add('         at t = '+FloatToStr(tn)+', tentative step size h = '+FloatToStr(h)+', step nst = '+IntToStr(nst));
    end;
   end; {   end if ( meth != mused )   }

{  itask = 1.
   If tout has been reached, interpolate. }

   if (itask=1) then
   begin
    if ((tn-tout)*h>=0.0) then
    begin
     intdy(tout, 0, y, iflag);
     t:= tout;
     istate:= 2;
     illin:= 0;
     exit;
    end;
   end;

{  itask = 2. }

   if (itask=2) then
   begin
    successreturn(y, t, itask, ihit, tcrit, Fistate);
    exit;
   end;

{  itask = 3.
   Jump to exit if tout was reached. }

   if (itask=3) then
   begin
    if ((tn-tout)*h>=0.0) then
    begin
     successreturn(y, t, itask, ihit, tcrit, Fistate);
     exit;
    end;
   end;

{  itask = 4.
   See if tout or tcrit was reached.  Adjust h if necessary. }

   if (itask=4) then
   begin
    if ((tn-tout)*h>=0.0) then
    begin
     intdy(tout, 0, y, iflag);
     t:= tout;
     istate:= 2;
     illin:= 0;
     exit;
    end
    else
    begin
     hmx:= abs(tn)+abs(h);
     if (abs(tn-tcrit)<=(100.*ETA*hmx)) then ihit:= 1
     else ihit:= 0;
     if (ihit=1) then
     begin
      successreturn(y, t, itask, ihit, tcrit, Fistate);
      exit;
     end;
     tnext:= tn+h*(1.+4.*ETA);
     if ((tnext-tcrit)*h<0.0) then
     begin
      h:= (tcrit-tn)*(1.-4.*ETA);
      jstart:= -2;
     end;
    end;
   end; {   end if ( itask == 4 )   }

{  itask = 5.
   See if tcrit was reached and jump to exit. }

   if (itask=5) then
   begin
    hmx:= abs(tn)+abs(h);
    if (abs(tn-tcrit)<=(100.*ETA*hmx)) then ihit:= 1
    else ihit:= 0;
    successreturn(y, t, itask, ihit, tcrit, Fistate);
    exit;
   end;
  end; {   end if ( kflag == 0 )   }

{  kflag = -1, error test failed repeatedly or with fabs(h) = hmin.
   kflag = -2, convergence failed repeatedly or with fabs(h) = hmin. }

  if (kflag=-1)or(kflag=-2) then
  begin
   if (prfl=1) then //EuConver writeln('lsoda -- at t = ', tn, ' and step size h = ', h, ', the');
    StdOut.Add('lsoda -- at t = '+FloatToStr(tn)+' and step size h = '+FloatToStr(h)+', the');
   if (kflag=-1) then
   begin
    if (prfl=1) then
    begin//EuConver 2
//     writeln('         error test failed repeatedly or');
//     writeln('         with abs(h) = hmin');
     StdOut.Add('         error test failed repeatedly or');
     StdOut.Add('         with abs(h) = hmin');
    end;
    istate:= -4;
   end;
   if (kflag=-2) then
   begin
    if (prfl=1) then
    begin//EuConver 2
//     writeln('         corrector convergence failed repeatedly or');
//     writeln('         with abs(h) = hmin');
     StdOut.Add('         corrector convergence failed repeatedly or');
     StdOut.Add('         with abs(h) = hmin');
    end;
    istate:= -5;
   end;
   big:= 0.;
   imxer:= 1;
   for i:= 1 to n do
   begin
    size:= abs(acor[i])*ewt[i];
    if (big<size) then
    begin
     big:= size;
     imxer:= i;
    end;
   end;
   terminate2(y, t);
   exit;
  end; {   end if ( kflag == -1 || kflag == -2 )   }
 end; {   end while   }
end; {   end lsoda   }
{**************************************************************}
initialization
 StdOut:= TStringList.Create;
finalization
 StdOut.Free;
end.

