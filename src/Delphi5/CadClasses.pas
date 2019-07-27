unit CadClasses;
interface
uses classes, Windows, Graphics,
 EuLib, ChainClasses, NuclideClasses;
{*********************** ChainCAD *************************}
type
 TChainCAD = class;
{ TBaseShape }
 TBaseShape = class
 private
  FBrushColor: TColor;
  FPenColor: TColor;
  FPenSize: Integer;
  procedure SetBrushColor(const Value: TColor);
  procedure SetPenColor(const Value: TColor);
  procedure SetPenSize(const Value: Integer);
  procedure SetBottom(const Value: Integer);
  procedure SetLeft(const Value: Integer);
  procedure SetRight(const Value: Integer);
  procedure SetTop(const Value: Integer);

  function GetBottom: Integer;
  function GetLeft: Integer;
  function GetRight: Integer;
  function GetTop: Integer;
 protected
  FRect: TRect;
  fChainCAD: TChainCAD;
 public
  procedure Paint; virtual;
 published
  constructor Create(aChainCAD: TChainCAD);
  property PenSize: Integer read FPenSize write SetPenSize;
  property PenColor: TColor read FPenColor write SetPenColor;
  property BrushColor: TColor read FBrushColor write SetBrushColor;
  property Left: Integer read GetLeft write SetLeft;
  property Right: Integer read GetRight write SetRight;
  property Top: Integer read GetTop write SetTop;
  property Bottom: Integer read GetBottom write SetBottom;
  property Rect: TRect read FRect;
 end;
 
 TCadState = class(TBaseShape)
 private
  fState: TChainState;
 public
  constructor Create4DecayChainImage(aChainImage: TChainCAD; aState: TChainState; aRect: TRect);
  property State: TChainState read fState;
  constructor Create(aCAD: TChainCad; aState: TChainState);
  procedure Paint; override;
 end;

 TCadLink = class(TBaseShape)
 private
  fLink: TChainLink;
  fStart: TCadState;
  fFinish: TCadState;
 public
  procedure Paint4DecayChainImage;
  constructor Create(aCAD: TChainCad; aChainLink: TChainLink);
  procedure Paint; override;
  procedure Update;
  property Link: TChainLink read fLink;
  property Start: TCadState read fStart;
  property Finish: TCadState read fFinish;
 end;

{ TCadStateList }
 TCadStateList = class(TList)
 private
  fCad: TChainCad;
 protected
  function GetState(Index: integer): TCadState;
  procedure SetState(Index: integer; aCadState: TCadState);
 public
  procedure Delete(Index: Integer); overload;
  function Add(Item: Pointer): integer; overload;
  property Cad: TChainCad read fCad;
  function FindInList(const aThZpA_s: integer): integer;
  destructor Destroy; override;
  constructor Create(aCad: TChainCad);
  property
   CadStates[Index: integer]: TCadState read GetState write SetState; default;
 end;
 
{ TCadLinkList }
 TCadLinkList = class(TList)
 private
  fCad: TChainCad;
 protected
  function GetCadLink(Index: integer): TCadLink;
  procedure SetCadLink(Index: integer; aCadLink: TCadLink);
 public
  procedure Delete(Index: Integer); overload;
  function Add(Item: Pointer): integer; overload;
  property Cad: TChainCad read fCad;
  function FindInList(const aThZpA_sStart, aThZpA_sFinish: integer): integer;
  destructor Destroy; override;
  constructor Create(aCad: TChainCad);
  property
   CadLinks[Index: integer]: TCadLink read GetCadLink write SetCadLink; default;
 end;

{TChainCad}
 TChainCAD = class
 private
  fCanvas: TCanvas;
  fChain: TChain;
  fVisibleRect: TRect;
  fDX, fDY: integer;
  fDA, fDAA: integer;
  fStateWidth, fStateHeight: integer;
  fDrawFissionLinks: Boolean;
  fShowHalfLife: Boolean;
  fShowSigmaC: Boolean;
  fShowRI: Boolean;
  fWidth, fHeight: integer;
  FOnChange: TNotifyEvent;
  fWorking: Boolean;
 protected
  fXYGrid: array of array of LongInt; // row (Y = 10*M+s = const
  fStates: TCadStateList;
  fLinks: TCadLinkList;
  procedure AddState(aState: TChainState);
  procedure AddLink(aChainLink: TChainLink);
  procedure SetCanvas(aCanvas: TCanvas);
  procedure AdjustLinks;
  procedure NormalizePicture;
 public
  function ClearCADwoChainClean: Boolean;
  function PaintAsDecayChain: Boolean;
  procedure ListStates(var Lines: TStringList);
  procedure ListLinks(var Lines: TStringList);
  function FindLinkAtXY(const X, Y: Integer): integer;
  function FindStateAtXY(const X, Y: Integer): integer;
  procedure AddStateByName(// tipa Ru-106, U-235g, U-235m, Bi-212m1, Bi-212m2
   const aName: string;
   const BuildLinks: Boolean = True;
   const Transitions: TNuclideTransitions = [ntCapture, ntFission, ntDecay, ntThreshold];
   const aNuclideList: TNuclideList = nil;
   const aDataModule: Pointer = nil);
  procedure AddLinkByName(const Start: string; const Finish: string;
   const LoadFromDB: Boolean;
   aTransitions: TNuclideTransitions = [ntCapture, ntFission, ntDecay, ntThreshold];
   const aNuclideList: TNuclideList = nil;
   aDataModule: Pointer = nil);
  function GetWidth: integer;
  function GetHeight: integer;
  constructor Create(aChain: TChain);
  procedure CreateStates;
  procedure CreateLinks;
  procedure CreateLinksForAddedState(aState: TChainState);
  procedure ClearPaint;
  function PaintStates: Boolean;
  function PaintLinks: Boolean;
  function SaveChainToFile(const FileName: string): Boolean;
  function LoadChainFromFile(const FileName: string): Boolean;
  function FindStateByName(aName: string): TCadState;
  function FindLinkByName(const NamePart1: string; const NamePart2: string = ''): TCadLink;
  function FindStateByThZpA_s(aThZpA_s: integer): TCadState;
  function LinkAlreadyExists(aChainLink: TChainLink): Boolean;
  procedure DeleteState(aState: TCadState);
  procedure DeleteStateEx(aState: TCadState);
  procedure DeleteLink(aLink: TCadLink);
  procedure ZoomOut(const Mult: integer = 2);
  procedure ZoomIn(const Mult: integer = 2);
  procedure Zoom(const Factor: Float = 1);
  property Canvas: TCanvas read fCanvas write SetCanvas;
  property VisibleRect: TRect read fVisibleRect write fVisibleRect;
  property States: TCadStateList read fStates write fStates;
  property Links: TCadLinkList read fLinks write fLinks;
  property dX: integer read fDX write fDX;
  property dY: integer read fDY write fDY;
  property dA: integer read fDA write fDA;
  property dAA: integer read fDAA write fDAA;
  property StateWidth: integer read fStateWidth write fStateWidth;
  property StateHeight: integer read fStateHeight write fStateHeight;
  property Width: integer read GetWidth;
  property Height: integer read GetHeight;
  property OnChange: TNotifyEvent read FOnChange write FOnChange;
  property DrawFissionLinks: Boolean read fDrawFissionLinks write fDrawFissionLinks;
  property ShowHalfLife: Boolean read fShowHalfLife write fShowHalfLife;
  property ShowSigmaC: Boolean read fShowSigmaC write fShowSigmaC;
  property ShowRI: Boolean read fShowRI write fShowRI;
  property Working: Boolean read fWorking;
 end;
 
implementation
uses
 SysUtils, Dialogs, Forms;

function NormalizeRect(const aRect: TRect): TRect;
var
 TT: integer;
begin
 Result:= aRect;
 with Result do
 begin
  if Top > Bottom then
  begin
   TT:= Top;
   Top:= Bottom;
   Bottom:= TT;
  end;
  if Left > Right then
  begin
   TT:= Left;
   Left:= Right;
   Right:= TT;
  end;
 end;
end;

function IsPointInRect(const X, Y: integer; const aRect: TRect; const Delta: integer = 0): Boolean;
begin
 Result:= False;
// NormalizeRect(aRect);
 with aRect do
  if ((((X >= Left - Delta) and (X <= Right + Delta)) or ((X <= Left + Delta) and (X >= Right - Delta)))
   and
   (((Y >= Top - Delta) and (Y <= Bottom + Delta)) or ((Y <= Top + Delta) and (Y >= Bottom - Delta)))) then
   Result:= True;
end;

{ TBaseShape }

constructor TBaseShape.Create(aChainCAD: TChainCAD);
begin
 inherited Create;
 fChainCAD:= aChainCAD;
end;

function TBaseShape.GetBottom: Integer;
begin
 Result:= fRect.Bottom;
end;

function TBaseShape.GetLeft: Integer;
begin
 Result:= fRect.Left;
end;

function TBaseShape.GetRight: Integer;
begin
 Result:= fRect.Right;
end;

function TBaseShape.GetTop: Integer;
begin
 Result:= fRect.Top;
end;

procedure TBaseShape.Paint;
begin
//set the attributes
 if (fChainCAD.Canvas <> nil) then
 begin
  fChainCAD.Canvas.Pen.Color:= fPenColor;
  fChainCAD.Canvas.Pen.Width:= fPenSize;
  fChainCAD.Canvas.Brush.Color:= fBrushColor;
 end;
end;

procedure TBaseShape.SetBottom(const Value: Integer);
begin
 fRect.Bottom:= Value;
end;

procedure TBaseShape.SetBrushColor(const Value: TColor);
begin
 FBrushColor:= Value;
end;

procedure TBaseShape.SetLeft(const Value: Integer);
begin
 fRect.Left:= Value;
end;

procedure TBaseShape.SetPenColor(const Value: TColor);
begin
 FPenColor:= Value;
end;

procedure TBaseShape.SetPenSize(const Value: Integer);
begin
 FPenSize:= Value;
end;

procedure TBaseShape.SetRight(const Value: Integer);
begin
 fRect.Right:= Value;
end;

procedure TBaseShape.SetTop(const Value: Integer);
begin
 fRect.Top:= Value;
end;

{ TCadState }

constructor TCadState.Create(aCAD: TChainCad; aState: TChainState);
 function GetXau(State: TChainState): integer;
 begin
  Result:= (State.ThZpA_s div 10) mod 1000 - (State.ThZpA_s div 10) div 1000; // Amass-Znum
 end;
 function GetYau(State: TChainState): integer;
 begin
  Result:= (-((State.ThZpA_s div 10) div 1000) * 10 - State.ThZpA_s mod 10); //10Znum+State
 end;
var
 I, Difference, XauMin, YauMin, XauMax, YauMax, Xmax, Ymax, X0au, Y0au, X0, Y0, dX, dY, StateW, StateH: integer;
 X0Found, Y0Found: Boolean;
begin
 inherited Create(aCAD);
 fState:= aState;
 dX:= fChainCAD.dX;
 dY:= fChainCAD.dY;
 StateW:= fChainCAD.StateWidth;
 StateH:= fChainCAD.StateHeight;
 if fChainCAD.States.Count < 1 then
  with FRect do
  begin
   FRect.Left:= dX;
   FRect.Top:= dY;
   FRect.Right:= dX + StateW;
   FRect.Bottom:= dY + StateH;
   Exit;
  end
 else
 begin
  X0Found:= False;
  Y0Found:= False;
  X0:= fChainCAD.dX;
  Y0:= fChainCAD.dY;
  X0au:= GetXau(aState);
  Y0au:= GetYau(aState);
// Find X
  XauMin:= MaxInt;
  Xmax:= -MaxInt;
  XauMax:= -MaxInt;
  for I:= 0 to fChainCAD.States.Count - 1 do
  begin
   if (fChainCAD.States[I].Left > Xmax) then
    Xmax:= fChainCAD.States[I].Left;
   if (GetXau(fChainCAD.States[I].fState) > XauMax) then
    XauMax:= GetXau(fChainCAD.States[I].fState);
   if (GetXau(fChainCAD.States[I].fState) < XauMin) then
    XauMin:= GetXau(fChainCAD.States[I].fState);
   if (X0au = GetXau(fChainCAD.States[I].fState)) then
   begin
    X0:= fChainCad.States[I].Left;
    X0Found:= True;
    break;
   end;
  end;
  if not (X0Found) then
  begin
   if X0au < XauMin then
    X0:= -StateW
   else if X0au > XauMax then
    X0:= Xmax + StateW + dX
   else
   begin //Find NearestNextX
    Difference:= MaxInt;
    for I:= 0 to fChainCAD.States.Count - 1 do
     if (GetXau(fChainCAD.States[I].fState) > X0au) then
      if (GetXau(fChainCAD.States[I].fState) - X0au < Difference) then
      begin
       Difference:= GetXau(fChainCAD.States[I].fState) - X0au;
       X0:= fChainCAD.States[I].Left;
      end;
    for I:= 0 to fChainCAD.States.Count - 1 do
     if fChainCAD.States[I].Left >= X0 then
     begin
      fChainCAD.States[I].Left:= fChainCAD.States[I].Left + StateW + dX;
      fChainCAD.States[I].Right:= fChainCAD.States[I].Right + StateW + dX;
     end;
   end;
  end;
// Find Y
  YauMin:= MaxInt;
  Ymax:= -MaxInt;
  YauMax:= -MaxInt;
  for I:= 0 to fChainCAD.States.Count - 1 do
  begin
   if (fChainCAD.States[I].Top > Ymax) then
    Ymax:= fChainCAD.States[I].Top;
   if (GetYau(fChainCAD.States[I].fState) > YauMax) then
    YauMax:= GetYau(fChainCAD.States[I].fState);
   if (GetYau(fChainCAD.States[I].fState) < YauMin) then
    YauMin:= GetYau(fChainCAD.States[I].fState);
   if (Y0au = GetYau(fChainCAD.States[I].fState)) then
   begin
    Y0:= fChainCad.States[I].Top;
    Y0Found:= True;
    break;
   end;
  end;
  if not (Y0Found) then
  begin
   if Y0au < YauMin then
    Y0:= -StateH
   else if Y0au > YauMax then
    Y0:= Ymax + StateH + dY
   else
   begin //Find NearestNextY
    Difference:= MaxInt;
    for I:= 0 to fChainCAD.States.Count - 1 do
     if (GetYau(fChainCAD.States[I].fState) > Y0au) then
      if (GetYau(fChainCAD.States[I].fState) - Y0au < Difference) then
      begin
       Difference:= GetYau(fChainCAD.States[I].fState) - Y0au;
       Y0:= fChainCAD.States[I].Top;
      end;
    for I:= 0 to fChainCAD.States.Count - 1 do
     if fChainCAD.States[I].Top >= Y0 then
     begin
      fChainCAD.States[I].Top:= fChainCAD.States[I].Top + StateH + dY;
      fChainCAD.States[I].Bottom:= fChainCAD.States[I].Bottom + StateH + dY;
     end;
   end;
  end;
  with FRect do
  begin
   Left:= X0;
   Right:= X0 + StateW;
   Top:= Y0;
   Bottom:= Y0 + StateH;
  end;
 end; //States >1
end;

constructor TCadState.Create4DecayChainImage(aChainImage: TChainCAD;
  aState: TChainState; aRect: TRect);
begin
 inherited Create(aChainImage);
 fState := aState;
 with FRect, aRect do
 begin
  FRect.Left := aRect.Left;
  FRect.Top := aRect.Top;
  FRect.Right := aRect.Right;
  FRect.Bottom := aRect.Bottom;
  Exit;
 end
end;

procedure TCadState.Paint;
var
 aStr: string;
 aFloat: Float;
begin
 inherited;
 if (fChainCAD.fCanvas <> nil) then
  with fChainCAD.fCanvas do
  begin
   Brush.Style:= bsClear;
   Font.Height:= (fRect.Bottom - fRect.Top) div 3;
   Rectangle(fRect.Left, fRect.Top, fRect.Right, fRect.Bottom);
   TextOut((fRect.Left + fRect.Right - TextWidth(fState.Name)) div 2, fRect.Top + fChainCAD.Canvas.Pen.Width + 1, fState.Name);
   if (fChainCAD <> nil) then
    if fChainCAD.fShowHalfLife then
     if PrepareToParse(fState.ValuesStr[0], aStr) then
     begin // Lambda
      if ValEuSilent(aStr, aFloat) then
       if (aFloat > 0) then
       begin
        aStr:= T1_2ToStr(Ln2 / aFloat);
        TextOut((fRect.Left + fRect.Right - TextWidth(aStr)) div 2, (fRect.Top + fRect.Bottom) div 2 + fChainCAD.Canvas.Pen.Width + 1, aStr);
       end;
     end
     else if TextT1_2ToNum(aStr, aFloat) then
     begin // may be T1_2
      if (aFloat > 0) then
      begin
       aStr:= T1_2ToStr(aFloat);
       TextOut((fRect.Left + fRect.Right - TextWidth(aStr)) div 2, (fRect.Top + fRect.Bottom) div 2 + fChainCAD.Canvas.Pen.Width + 1, aStr);
      end;
     end
     else
     begin
      aStr:= '???';
      TextOut((fRect.Left + fRect.Right - TextWidth(aStr)) div 2, (fRect.Top + fRect.Bottom) div 2 + fChainCAD.Canvas.Pen.Width + 1, aStr);
     end;
  end;
end;

{ TChainCAD }

function LineIntersect(const X10, Y10, X11, Y11, X20, Y20, X21, Y21: integer;
 var X, Y: integer): Boolean;
var
 A1, B1, C1, A2, B2, C2, D: integer;
begin
 Result:= False;
 A1:= Y11 - Y10;
 B1:= X10 - X11;
 C1:= -X10 * Y11 + X11 * Y10;
 A2:= Y21 - Y20;
 B2:= X20 - X21;
 C2:= -X20 * Y21 + X21 * Y20;
 D:= A1 * B2 - A2 * B1;
 if D <> 0 then
 begin
  X:= round(1.0 * (B1 * C2 - C1 * B2) / D);
  Y:= round(1.0 * (C1 * A2 - A1 * C2) / D);
  Result:= True;
 end;
end;

function IntervalIntersect(const X10, Y10, X11, Y11, X20, Y20, X21, Y21: integer;
 var X, Y: integer): Boolean;
begin
 Result:= False;
 if LineIntersect(X10, Y10, X11, Y11, X20, Y20, X21, Y21, X, Y) then
  if ((X - X10) * (X11 - X) >= 0) and ((X - X20) * (X21 - X) >= 0) and
   ((Y - Y10) * (Y11 - Y) >= 0) and ((Y - Y20) * (Y21 - Y) >= 0) then
   Result:= True;
end;

procedure TChainCAD.AddStateByName(// tipa Ru-106, U-235g, U-235m, Bi-212m1, Bi-212m2
 const aName: string;
 const BuildLinks: Boolean = True;
 const Transitions: TNuclideTransitions = [ntCapture, ntFission, ntDecay, ntThreshold];
 const aNuclideList: TNuclideList = nil;
 const aDataModule: Pointer = nil);
var
 TmpState: TChainState;
 I: integer;
 AlreadyInCad: Boolean;
begin
 fWorking:= True;
 try
  TmpState:= fChain.AddStateByName(aName, BuildLinks, Transitions, aNuclideList, aDataModule, False);
  repeat
   Application.ProcessMessages
  until not (fChain.Working);
  if TmpState <> nil then
  begin
   AlreadyInCad:= False;
   for I:= 0 to fStates.Count - 1 do
    if fStates[I].fState = TmpState then
    begin
     AlreadyInCad:= True;
     break;
    end;
   if not (AlreadyInCad) then
    Self.AddState(TmpState);
  end;
  if BuildLinks then
  begin
   for I:= 0 to fChain.Links.Count - 1 do
    AddLink(fChain.Links[I]); // AddLink - checks for duplicates See LinkAlreadyExists(aChainLink)
   if Assigned(FOnChange) then
    OnChange(Self);
  end;
 finally
  fWorking:= False;
 end;
end;

function TChainCAD.FindStateByName(aName: string): TCadState;
var
 aThZpA_s: integer;
begin
 aThZpA_s:= StrToThZpA_s(aName);
 Result:= FindStateByThZpA_s(aThZpA_s);
end;

function TChainCAD.FindStateByThZpA_s(aThZpA_s: integer): TCadState;
var
 I: integer;
begin
 Result:= nil;
 for I:= 0 to fStates.Count - 1 do
  if aThZpA_s = fStates[I].fState.ThZpA_s then
  begin
   Result:= fStates[I];
   break;
  end;
end;

function TChainCAD.LinkAlreadyExists(aChainLink: TChainLink): Boolean;
var
 I: integer;
begin
 Result:= False;
 for I:= 0 to fLinks.Count - 1 do
  if ((fLinks[I].fStart.State.ThZpA_s = aChainLink.StartThZpA_s) and (fLinks[I].fFinish.State.ThZpA_s = aChainLink.FinishThZpA_s)) then
  begin
   Result:= True;
   break;
  end;
end;

procedure TChainCAD.AdjustLinks;
var
 I: integer;
 aCadLink: TCadLink;
 aStart, aFinish: TCadState;
 X, Y, X0, Y0, X1, Y1: integer;
 aStartRect, aFinishRect: TRect;
begin
 for I:= 0 to fLinks.Count - 1 do
 begin
  aCadLink:= fLinks[I];
  aStart:= aCadLink.fStart;
  aFinish:= aCadLink.fFinish;
  if ((aStart <> nil) and (aFinish <> nil)) then
  begin
   aStartRect:= NormalizeRect(aStart.Rect);
   aFinishRect:= NormalizeRect(aFinish.Rect);
   X0:= (aStartRect.Left + aStartRect.Right) div 2;
   Y0:= (aStartRect.Top + aStartRect.Bottom) div 2;
   X1:= (aFinishRect.Left + aFinishRect.Right) div 2;
   Y1:= (aFinishRect.Top + aFinishRect.Bottom) div 2;
   with aStart do
    if IntervalIntersect(X0, Y0, X1, Y1, Left, Top, Left, Bottom, X, Y) then
    begin
     aCadLink.Left:= X;
     aCadLink.Top:= Y;
    end
    else if IntervalIntersect(X0, Y0, X1, Y1, Left, Top, Right, Top, X, Y) then
    begin
     aCadLink.Left:= X;
     aCadLink.Top:= Y;
    end
    else if IntervalIntersect(X0, Y0, X1, Y1, Right, Top, Right, Bottom, X, Y) then
    begin
     aCadLink.Left:= X;
     aCadLink.Top:= Y;
    end
    else if IntervalIntersect(X0, Y0, X1, Y1, Left, Bottom, Right, Bottom, X, Y) then
    begin
     aCadLink.Left:= X;
     aCadLink.Top:= Y;
    end
    else
    begin
     Exit;
    end;
// Intersect With Finish Sides
   with aFinish do
    if IntervalIntersect(X0, Y0, X1, Y1, Left, Top, Left, Bottom, X, Y) then
    begin
     aCadLink.Right:= X;
     aCadLink.Bottom:= Y;
    end
    else if IntervalIntersect(X0, Y0, X1, Y1, Left, Top, Right, Top, X, Y) then
    begin
     aCadLink.Right:= X;
     aCadLink.Bottom:= Y;
    end
    else if IntervalIntersect(X0, Y0, X1, Y1, Right, Top, Right, Bottom, X, Y) then
    begin
     aCadLink.Right:= X;
     aCadLink.Bottom:= Y;
    end
    else if IntervalIntersect(X0, Y0, X1, Y1, Left, Bottom, Right, Bottom, X, Y) then
    begin
     aCadLink.Right:= X;
     aCadLink.Bottom:= Y;
    end
    else
    begin
     Exit;
    end;
  end;
 end;
end;

procedure TChainCAD.AddLink(aChainLink: TChainLink);
var
 aCadLink: TCadLink;
 aStart, aFinish: TCadState;
 X, Y, X0, Y0, X1, Y1: integer;
 aStartRect, aFinishRect: TRect;
begin
 if not (LinkAlreadyExists(aChainLink)) then
 begin
  aCadLink:= TCadLink.Create(Self, aChainLink);
  aStart:= Self.FindStateByThZpA_s(aChainLink.StartThZpA_s);
  aFinish:= Self.FindStateByThZpA_s(aChainLink.FinishThZpA_s);
  aCadLink.fStart:= aStart;
  aCadLink.fFinish:= aFinish;
  if ((aStart <> nil) and (aFinish <> nil)) then
  begin
   aStartRect:= NormalizeRect(aStart.Rect);
   aFinishRect:= NormalizeRect(aFinish.Rect);
   X0:= (aStartRect.Left + aStartRect.Right) div 2;
   Y0:= (aStartRect.Top + aStartRect.Bottom) div 2;
   X1:= (aFinishRect.Left + aFinishRect.Right) div 2;
   Y1:= (aFinishRect.Top + aFinishRect.Bottom) div 2;
   with aStart do
    if IntervalIntersect(X0, Y0, X1, Y1, Left, Top, Left, Bottom, X, Y) then
    begin
     aCadLink.Left:= X;
     aCadLink.Top:= Y;
    end
    else if IntervalIntersect(X0, Y0, X1, Y1, Left, Top, Right, Top, X, Y) then
    begin
     aCadLink.Left:= X;
     aCadLink.Top:= Y;
    end
    else if IntervalIntersect(X0, Y0, X1, Y1, Right, Top, Right, Bottom, X, Y) then
    begin
     aCadLink.Left:= X;
     aCadLink.Top:= Y;
    end
    else if IntervalIntersect(X0, Y0, X1, Y1, Left, Bottom, Right, Bottom, X, Y) then
    begin
     aCadLink.Left:= X;
     aCadLink.Top:= Y;
    end
    else
    begin
     aCadLink.Free;
     Exit;
    end;
// Intersect With Finish Sides
   with aFinish do
    if IntervalIntersect(X0, Y0, X1, Y1, Left, Top, Left, Bottom, X, Y) then
    begin
     aCadLink.Right:= X;
     aCadLink.Bottom:= Y;
    end
    else if IntervalIntersect(X0, Y0, X1, Y1, Left, Top, Right, Top, X, Y) then
    begin
     aCadLink.Right:= X;
     aCadLink.Bottom:= Y;
    end
    else if IntervalIntersect(X0, Y0, X1, Y1, Right, Top, Right, Bottom, X, Y) then
    begin
     aCadLink.Right:= X;
     aCadLink.Bottom:= Y;
    end
    else if IntervalIntersect(X0, Y0, X1, Y1, Left, Bottom, Right, Bottom, X, Y) then
    begin
     aCadLink.Right:= X;
     aCadLink.Bottom:= Y;
    end
    else
    begin
     aCadLink.Free;
     Exit;
    end;
   TList(fLinks).Add(aCadLink);
  end;
  AdjustLinks;
  if Assigned(FOnChange) then
   OnChange(Self);
 end;
end;

procedure TChainCAD.AddState(aState: TChainState);
var
 aCadState: TCadState;
begin
 aCadState:= TCadState.Create(Self, aState);
 TList(fStates).Add(aCadState);
 NormalizePicture;
 if Assigned(FOnChange) then
  OnChange(Self);
end;

constructor TChainCAD.Create(aChain: TChain);
begin
 inherited Create;
 fDrawFissionLinks:= True;
 fShowHalfLife:= False;
 fShowSigmaC:= False;
 fShowRI:= False;
 fCanvas:= nil;
// fDX:= 30;        // NewSize QQQQ
// fDY:= 20;
 fDX:= 16;
 fDY:= 12;
 fStateWidth:= 60;
 fStateHeight:= 40;
 fDA:= 1;
 fDAA:= 5;
 fChain:= aChain;
 fStates:= TCadStateList.Create(Self);
 fLinks:= TCadLinkList.Create(Self);
 FOnChange:= nil;
end;

procedure TChainCAD.CreateStates;
var
 I: integer;
begin
 for I:= fStates.Count - 1 downto 0 do
  fStates[I].Free;
 fStates.Clear;
 for I:= 0 to fChain.States.Count - 1 do
 begin
  AddState(fChain.States[I]);
 end;
end;

function CombineStr4DeleteStateEx(const StrStart, StrFinish: string; var DeleteExOutStr: string): Boolean;
var
 I: integer;
 PercenStr, CommentStr, StartValStr, StartCommentStr, FinishValStr, FinishCommentStr: string;
begin
 DeleteExOutStr:= '';
 try
  CommentStr:= '// DeleteStateEx:';
  I:= Pos('//', StrFinish);
  if I > 0 then
  begin
   FinishValStr:= Copy(StrFinish, 1, I - 1);
   FinishCommentStr:= Copy(StrFinish, I + 1, Length(StrFinish));
  end;
  I:= Pos('%', FinishValStr);
  if I > 0 then
   PercenStr:= Copy(FinishValStr, 1, I) + '*';
  I:= Pos('*', FinishValStr);
  if I > 0 then
   PercenStr:= Copy(StrFinish, 1, I);
  I:= Pos('//', StrStart);
  if I > 0 then
  begin
   StartValStr:= Copy(StrStart, 1, I - 1);
   StartCommentStr:= Copy(StrStart, I + 1, Length(StrStart));
  end;
  DeleteExOutStr:= PercenStr + StartValStr + ' ' + CommentStr + StrStart + '->' + StrFinish;
  Result:= True;
 except
  Result:= False;
 end;
end;

function IsEmptyToParse(const InStr: string): Boolean;
var
 I: integer;
 aStr: string;
begin
 aStr:= Trim(InStr);
 if aStr = '' then
 begin
  Result:= True;
  Exit;
 end
 else
  try
   I:= Pos('//', InStr);
   if I >= 1 then
    aStr:= Trim(Copy(InStr, 1, I - 1));
   if aStr = '' then
   begin
    Result:= True;
    Exit;
   end;
   if PrepareToParse(InStr, aStr) then
    if ((Trim(aStr) = '0') or (Trim(aStr) = '0.0')) then
    begin
     Result:= True;
     Exit;
    end;
   Result:= False;
  except
   Result:= False;
  end;
end;

procedure TChainCAD.DeleteStateEx(aState: TCadState);
var
 I, L, K, InLinkNo, OutLinkNo, aStartStateNo, aFinishStateNo: integer;
 TmpChainLink: TChainLink;
 InLinksList, OutLinksList: TLongIntList;
 TmpStr: string;
 aStartState, aFinishState: TChainState;
begin
 for I:= fStates.Count - 1 downto 0 do
  if fStates[I] = aState then
  begin
   InLinksList:= TLongIntList.Create;
   OutLinksList:= TLongIntList.Create;
   try
    for L:= 0 to fLinks.Count - 1 do
    begin
     if (fLinks[L].fFinish.fState = aState.fState) then
      InLinksList.Add(L);
     if (fLinks[L].fStart.fState = aState.fState) then
      OutLinksList.Add(L);
    end;
    for InLinkNo:= 0 to InLinksList.Count - 1 do
    begin
//Check Decays Only - If not then exit
     for K:= 1 to Self.fChain.Links[InLinksList[InLinkNo]].ValuesStr.Count - 1 do
     begin
      TmpStr:= Self.fChain.Links[InLinksList[InLinkNo]].ValuesStr[K];
      if not (IsEmptyToParse(TmpStr)) then
       exit;
     end;
    end;
    for OutLinkNo:= 0 to OutLinksList.Count - 1 do
    begin
//Check Decays Only - If not then exit
     for K:= 1 to Self.fChain.Links[OutLinksList[OutLinkNo]].ValuesStr.Count - 1 do
     begin
      TmpStr:= Self.fChain.Links[OutLinksList[OutLinkNo]].ValuesStr[K];
      if not (IsEmptyToParse(TmpStr)) then
       exit;
     end;
    end;
    for InLinkNo:= 0 to InLinksList.Count - 1 do
     for OutLinkNo:= 0 to OutLinksList.Count - 1 do
     begin
      aStartState:= fChain.Links[InLinksList[InLinkNo]].StartState;
      aFinishState:= fChain.Links[OutLinksList[OutLinkNo]].FinishState;
      aStartStateNo:= fChain.Links[InLinksList[InLinkNo]].FindStartStateChainNo;
      aFinishStateNo:= fChain.Links[OutLinksList[OutLinkNo]].FindFinishStateChainNo;
      if ((aStartStateNo > -1) and (aFinishStateNo > -1)) then
      begin
       TmpChainLink:= TChainLink.Create(fChain, aStartState.ThZpA_s, aFinishState.ThZpA_s);
       fChain.AddLink(TmpChainLink);
       if CombineStr4DeleteStateEx(fChain.Links[InLinksList[InLinkNo]].ValuesStr[0], fChain.Links[OutLinksList[OutLinkNo]].ValuesStr[0], TmpStr) then
        TmpChainLink.ValuesStr[0]:= TmpStr
       else
        TmpChainLink.ValuesStr[0]:= '//CombineStr4DeleteStateEx failure';
       if (TmpChainLink <> nil) then
       begin
        Self.AddLink(TmpChainLink);
       end;
      end;
     end;
    Self.DeleteState(aState);
   finally
    InLinksList.Free;
    OutLinksList.Free;
   end;
   break;
  end;
 if Assigned(FOnChange) then
  OnChange(Self);
end;

procedure TChainCAD.DeleteState(aState: TCadState);
var
 I, L: integer;
begin
 for I:= fStates.Count - 1 downto 0 do
  if fStates[I] = aState then
  begin
// Clear Links
   for L:= fLinks.Count - 1 downto 0 do
    if ((fLinks[L].fStart.fState = aState.fState) or (fLinks[L].fFinish.fState = aState.fState)) then
     DeleteLink(fLinks[L]);
// Clear State
   fChain.DeleteState(fStates[I].fState);
   TList(fStates).Delete(I);
   break;
  end;
 NormalizePicture;
 if Assigned(FOnChange) then
  OnChange(Self);
end;

function TChainCAD.GetHeight: integer;
begin
 Result:= fHeight;
end;

function TChainCAD.GetWidth: integer;
begin
 Result:= fWidth;
end;

function TChainCAD.PaintLinks: Boolean;
var
 I: integer;
begin
 try
  if (fCanvas <> nil) then
   for I:= 0 to fLinks.Count - 1 do
   begin
    Application.ProcessMessages;
    fLinks[I].Paint;
   end;
  Result:= True;
 except
  Result:= False;
 end;
end;

function TChainCAD.PaintStates: Boolean;
var
 I: integer;
begin
 try
  if (fCanvas <> nil) then
  begin
   for I:= 0 to fStates.Count - 1 do
   begin
    Application.ProcessMessages;
    fStates[I].Paint;
   end;
  end;
  Result:= True;
 except
  Result:= False;
 end;
end;

procedure TChainCAD.SetCanvas(aCanvas: TCanvas);
begin
 Application.ProcessMessages;
 if (aCanvas <> fCanvas) then
 begin
  fCanvas:= aCanvas;
  Application.ProcessMessages;
 end;
end;

procedure TChainCAD.CreateLinks;
var
 I: integer;
begin
 for I:= fLinks.Count - 1 downto 0 do
  fLinks[I].Free;
 fLinks.Clear;
 fChain.BuildDefaultLinks;
 for I:= 0 to fChain.Links.Count - 1 do
 begin
  AddLink(fChain.Links[I]);
 end;
end;

procedure TChainCAD.CreateLinksForAddedState(aState: TChainState);
var
 I: integer;
begin
 for I:= fLinks.Count - 1 downto 0 do
  if ((fLinks[I].fStart.fState.ThZpA_s = aState.ThZpA_s) or (fLinks[I].fFinish.fState.ThZpA_s = aState.ThZpA_s)) then
   fLinks[I].Free;
 fChain.BuildDefaultLinksForState(aState);
 for I:= 0 to fChain.Links.Count - 1 do
 begin
  AddLink(fChain.Links[I]);
 end;
end;

function TChainCAD.FindLinkAtXY(const X, Y: Integer): integer;
var
 I, Zdiff: integer;
 D, Dmin, sq, A, B, x1, x2, y1, y2: float; //C
begin
 if DrawFissionLinks then
 begin
  Result:= -1;
  Dmin:= Self.Width + Self.Height;
  for I:= 0 to fLinks.Count - 1 do
   if IsPointInRect(X, Y, fLinks[I].fRect, 3) then
   begin
    x1:= fLinks[I].fRect.Left;
    x2:= fLinks[I].fRect.Right;
    y1:= fLinks[I].fRect.Top;
    y2:= fLinks[I].fRect.Bottom;
    A:= y1 - y2;
    B:= x2 - x1;
//   C:= x1*y2-x2*y1;
    sq:= sqrt(A * A + B * B);
    D:= (A * X + B * Y + x1 * y2 - x2 * y1) / sq; // from Point to Line   (AX+BY+C)/sqrt(A^2+B^2)
    if D < 0 then
     D:= -D;
    if D < Dmin then
    begin
     Result:= I;
     Dmin:= D;
    end;
   end;
 end
 else
 begin
  Result:= -1;
  Dmin:= Self.Width + Self.Height;
  for I:= 0 to fLinks.Count - 1 do
  begin
   Zdiff:= (fLinks[I].fLink.StartThZpA_s - fLinks[I].fLink.FinishThZpA_s) div 10000;
   if ((Zdiff >= 3) or (Zdiff <= -3)) then
    continue;
   if IsPointInRect(X, Y, fLinks[I].fRect, 3) then
   begin
    x1:= fLinks[I].fRect.Left;
    x2:= fLinks[I].fRect.Right;
    y1:= fLinks[I].fRect.Top;
    y2:= fLinks[I].fRect.Bottom;
    A:= y1 - y2;
    B:= x2 - x1;
//   C:= x1*y2-x2*y1;
    sq:= sqrt(A * A + B * B);
    D:= (A * X + B * Y + x1 * y2 - x2 * y1) / sq; // from Point to Line   (AX+BY+C)/sqrt(A^2+B^2)
    if D < 0 then
     D:= -D;
    if D < Dmin then
    begin
     Result:= I;
     Dmin:= D;
    end;
   end;
  end;
 end;
end;

function TChainCAD.FindStateAtXY(const X, Y: Integer): integer;
var
 I: integer;
begin
 Result:= -1;
 for I:= 0 to fStates.Count - 1 do
  if IsPointInRect(X, Y, fStates[I].fRect) then
  begin
   Result:= I;
   break;
  end;
end;

procedure TChainCAD.AddLinkByName(const Start: string; const Finish: string;
 const LoadFromDB: Boolean; aTransitions: TNuclideTransitions = [ntCapture, ntFission, ntDecay, ntThreshold]; const aNuclideList: TNuclideList = nil; aDataModule: Pointer = nil);
var
 TmpLink: TChainLink;
begin
 TmpLink:= fChain.AddLinkByName(Start, Finish, LoadFromDB, aTransitions aNuclideList);
 if TmpLink <> nil then
  Self.AddLink(TmpLink); // AddLink - checks for duplicates See LinkAlreadyExists(aChainLink)
end;

procedure TChainCAD.DeleteLink(aLink: TCadLink);
var
 I: integer;
begin
 for I:= fLinks.Count - 1 downto 0 do
  if fLinks[I] = aLink then
  begin
   fChain.DeleteLink(aLink.fLink);
   TList(fLinks).Delete(I);
  end;
 if Assigned(FOnChange) then
  OnChange(Self);
end;

function TChainCAD.FindLinkByName(const NamePart1: string;
 const NamePart2: string = ''): TCadLink;
var
 FullName: string;
 I: integer;
begin
 Result:= nil;
 try
  if Trim(NamePart2) = '' then
   FullName:= Trim(NamePart1)
  else
   FullName:= Trim(NamePart1) + '->' + Trim(NamePart2);
  for I:= 0 to fLinks.Count - 1 do
   if fLinks[I].fLink.Name = FullName then
   begin
    Result:= fLinks[I];
    break;
   end;
 except
  Result:= nil;
 end;
end;

function TChainCAD.SaveChainToFile(const FileName: string): Boolean;
begin
 try
  Result:= fChain.SaveToFile(FileName);
 except
  Result:= False;
 end;
end;

function TChainCAD.LoadChainFromFile(const FileName: string): Boolean;
begin
 Result:= fChain.LoadFromFile(FileName);
 CreateStates;
 CreateLinks;
 if Assigned(FOnChange) then
  OnChange(Self);
end;

procedure TChainCAD.ListLinks(var Lines: TStringList);
begin
 fChain.ListLinks(Lines);
end;

procedure TChainCAD.ListStates(var Lines: TStringList);
begin
 fChain.ListStates(Lines);
end;

procedure TChainCAD.ZoomOut(const Mult: integer = 2);
var
 I: integer;
begin
 fStateWidth:= fStateWidth div Mult;
 fStateHeight:= fStateHeight div Mult;
 fDX:= fDX div Mult;
 fDY:= fDY div Mult;
 for I:= 0 to fStates.Count - 1 do
 begin
  fStates[I].Left:= fStates[I].Left div Mult;
  fStates[I].Right:= fStates[I].Right div Mult;
  fStates[I].Top:= fStates[I].Top div Mult;
  fStates[I].Bottom:= fStates[I].Bottom div Mult;
 end;
 for I:= 0 to fLinks.Count - 1 do
 begin
  fLinks[I].Left:= fLinks[I].Left div Mult;
  fLinks[I].Right:= fLinks[I].Right div Mult;
  fLinks[I].Top:= fLinks[I].Top div Mult;
  fLinks[I].Bottom:= fLinks[I].Bottom div Mult;
 end;
 fWidth:= fWidth div Mult;
 fHeight:= fHeight div Mult;
end;

procedure TChainCAD.ZoomIn(const Mult: integer);
var
 I: integer;
begin
 fStateWidth:= fStateWidth * Mult;
 fStateHeight:= fStateHeight * Mult;
 fDX:= fDX * Mult;
 fDY:= fDY * Mult;
 for I:= 0 to fStates.Count - 1 do
 begin
  fStates[I].Left:= fStates[I].Left * Mult;
  fStates[I].Right:= fStates[I].Right * Mult;
  fStates[I].Top:= fStates[I].Top * Mult;
  fStates[I].Bottom:= fStates[I].Bottom * Mult;
 end;
 for I:= 0 to fLinks.Count - 1 do
 begin
  fLinks[I].Left:= fLinks[I].Left * Mult;
  fLinks[I].Right:= fLinks[I].Right * Mult;
  fLinks[I].Top:= fLinks[I].Top * Mult;
  fLinks[I].Bottom:= fLinks[I].Bottom * Mult;
 end;
 fWidth:= fWidth * Mult;
 fHeight:= fHeight * Mult;
end;

procedure TChainCAD.Zoom(const Factor: Float);
var
 I: integer;
begin
 fStateWidth:= Round(fStateWidth * Factor);
 fStateHeight:= Round(fStateHeight * Factor);
 fDX:= Round(fDX * Factor);
 fDY:= Round(fDY * Factor);
 for I:= 0 to fStates.Count - 1 do
 begin
  fStates[I].Left:= Round(fStates[I].Left * Factor);
  fStates[I].Right:= Round(fStates[I].Right * Factor);
  fStates[I].Top:= Round(fStates[I].Top * Factor);
  fStates[I].Bottom:= Round(fStates[I].Bottom * Factor);
 end;
 for I:= 0 to fLinks.Count - 1 do
 begin
  fLinks[I].Left:= Round(fLinks[I].Left * Factor);
  fLinks[I].Right:= Round(fLinks[I].Right * Factor);
  fLinks[I].Top:= Round(fLinks[I].Top * Factor);
  fLinks[I].Bottom:= Round(fLinks[I].Bottom * Factor);
 end;
 fWidth:= Round(fWidth * Factor);
 fHeight:= Round(fHeight * Factor);
end;

procedure TChainCAD.ClearPaint;
begin
 if (fCanvas <> nil) then
  with fCanvas do
  begin
   Brush.Color:= clWhite;
   FillRect(ClipRect);
  end;
end;

procedure TChainCAD.NormalizePicture;
var
 Xmin, Xmax, Ymin, Ymax, I: integer;
begin
 Xmin:= 5 * fdX;
 Xmax:= 0;
 Ymin:= 5 * fdY;
 Ymax:= 0;
 for I:= 0 to fStates.Count - 1 do
 begin
  if Xmin > fStates[I].Left then
   Xmin:= fStates[I].Left;
  if Xmax < fStates[I].Right then
   Xmax:= fStates[I].Right;
  if Ymin > fStates[I].Top then
   Ymin:= fStates[I].Top;
  if Ymax < fStates[I].Bottom then
   Ymax:= fStates[I].Bottom;
 end;
 for I:= 0 to fStates.Count - 1 do
  with fStates[I] do
  begin
   fStates[I].Left:= fStates[I].Left - Xmin + dX;
   fStates[I].Right:= fStates[I].Right - Xmin + dX;
   fStates[I].Top:= fStates[I].Top - Ymin + dY;
   fStates[I].Bottom:= fStates[I].Bottom - Ymin + dY;
  end;
 fWidth:= Xmax - Xmin + 2 * dX;
 if fWidth <= 0 then
  fWidth:= 1;
 fHeight:= Ymax - Ymin + 2 * dY;
 if fHeight <= 0 then
  fHeight:= 1;
 if Self.Links.Count > 0 then
  AdjustLinks;
end;

function OrderTenMplusSlist(var aChainTenMplusSlist: TLongIntList): Boolean;
var
 // TmpIntArray: array of LongInt;
 I, J: Integer;
begin
 try
  // SetLength( TmpIntArray, aChainTenMplusSlist.Count);
  aChainTenMplusSlist.Order;
  for I := 0 to aChainTenMplusSlist.Count - 1 do
   for J := I + 1 to aChainTenMplusSlist.Count - 1 do
    if (aChainTenMplusSlist[I] div 10 = aChainTenMplusSlist[J] div 10) then
     while (aChainTenMplusSlist[I] mod 10 < aChainTenMplusSlist[J] mod 10) do
      aChainTenMplusSlist.Exchange(I, J);
  Result := True;
 except
  Result := False;
 end;
end;

function TChainCAD.PaintAsDecayChain: Boolean;
var
 I, R, C: Integer;
 aFloat: Float;
 ThZpAsList, ChainMList, ChainZList, ZList, sList, ChainTenMplusSlist
  : TLongIntList;
 aStateCount, ColCountXlength, RowCountYlength: Integer;
 // XYGrid: array of array of LongInt; // row (Y = 10*M+s = const
 aRect: TRect;
 aStr: AnsiString;
 aState: TChainState;
 aImageState: TCadState;
begin
 Self.ClearCADwoChainClean;
 SetLength(fXYGrid, 0, 0);
 Result := False;
 if (fChain <> nil) then
  try
   ThZpAsList := TLongIntList.Create;
   ChainMList := TLongIntList.Create;
   ChainZList := TLongIntList.Create;
   ZList := TLongIntList.Create;
   sList := TLongIntList.Create;
   ChainTenMplusSlist := TLongIntList.Create;
   try
    for I := Self.fStates.Count - 1 downto 0 do
     Self.fStates[I].Free;
    Self.fStates.Clear;
    aStateCount := fChain.States.Count;
    for I := 0 to aStateCount - 1 do
    begin
    // s = (ThZpAsList[I] mod 10
    // M = ((ThZpAsList[I] div 10) mod 1000
    // Z = (ThZpAsList[I] div 10000)
     ThZpAsList.Add(fChain.States[I].ThZpA_s);
     ChainZList.AddUniq(ThZpAsList[I] div 10000);
     ChainMList.AddUniq((ThZpAsList[I] div 10) mod 1000);
     ChainTenMplusSlist.AddUniq(10 * ((ThZpAsList[I] div 10) mod 1000) +
      (ThZpAsList[I] mod 10));
    end;
    ChainZList.Order;
   // ChainTenMplusSlist.Order;
    OrderTenMplusSlist(ChainTenMplusSlist);
    ColCountXlength := ChainZList.Count;
    RowCountYlength := ChainTenMplusSlist.Count;
    SetLength(fXYGrid, ColCountXlength, RowCountYlength);
    for C := 0 to ColCountXlength - 1 do
     for R := 0 to RowCountYlength - 1 do
      fXYGrid[C, R] := -1;
    for I := 0 to aStateCount - 1 do
     for C := 0 to ColCountXlength - 1 do
      for R := 0 to RowCountYlength - 1 do
       if ((10 * ((ThZpAsList[I] div 10) mod 1000) + (ThZpAsList[I] mod 10)
        = ChainTenMplusSlist[R]) and (ThZpAsList[I] div 10000 = ChainZList
        [C])) then
        fXYGrid[C, R] := ThZpAsList[I];
   // test fill in XYgrid and Chain.States.Count
    I := 0;
    for C := 0 to ColCountXlength - 1 do
     for R := 0 to RowCountYlength - 1 do
      if fXYGrid[C, R] > 0 then
       Inc(I);
    if (I <> aStateCount) then
    begin
     MessageDlg
      ('Mismatch in Counts in TChainImage.LoadDecayChainFromFileAndPaint.', mtWarning, [mbOK], 0);
    end;
    if (fCanvas <> nil) then
     with fCanvas do
     begin
      fWidth := (ColCountXlength + 0) * (2 * fDX + fStateWidth);
      fHeight := (RowCountYlength + 0) * (2 * fDY + fStateHeight);
      fCanvas.Brush.Color := clWhite;
// fCanvas.CopyMode:= cmNotSrcErase;
      fCanvas.Brush.Style := bsSolid; // bsClear;
      fCanvas.FillRect(fCanvas.ClipRect);
      fCanvas.Brush.Style := bsClear;
// Paint States from XYGrid
      for R := 0 to ChainTenMplusSlist.Count - 1 do
       for C := 0 to ChainZList.Count - 1 do
        if fXYGrid[C, R] > 0 then
        begin
         I := fChain.FindState(fXYGrid[C, R]);
         if I >= 0 then
         begin
          aState := fChain.States[I];
        // aRec
          aRect.TopLeft.X := (2 * fDX + fStateWidth) * C + fDX;
          aRect.TopLeft.Y := (2 * fDY + fStateHeight) * R + fDY;
          aRect.BottomRight.X := aRect.TopLeft.X + fStateWidth;
          aRect.BottomRight.Y := aRect.TopLeft.Y + fStateHeight;
          aRect := NormalizeRect(aRect);
          aImageState := TCADState.Create4DecayChainImage(Self, aState, aRect);
          TList(fStates).Add(aImageState);
          fCanvas.Font.Height := (aRect.Bottom - aRect.Top) div 3;
          fCanvas.Rectangle(aRect.Left, aRect.Top, aRect.Right, aRect.Bottom);
          fCanvas.TextOut((aRect.Left + aRect.Right -
           fCanvas.TextWidth(aState.Name)) div 2, aRect.Top + fCanvas.Pen.Width
           + 1, aState.Name);
          if PrepareToParse(AnsiString(aState.ValuesStr[0]), aStr) then
          begin // Lambda
           if ValEuSilent(aStr, aFloat) then
            if (aFloat > 0) then
            begin
             aStr := AnsiString(T1_2ToStr(Ln2 / aFloat, 4));
             fCanvas.TextOut((aRect.Left + aRect.Right - fCanvas.TextWidth(aStr))
              div 2, (aRect.Top + aRect.Bottom) div 2 + fCanvas.Pen.Width
              + 1, aStr);
            end
            else
            begin // stable
             fCanvas.Rectangle(aRect.Left + 3, aRect.Top + 3, aRect.Right - 3, aRect.Bottom - 3);
            end;
          end
          else if TextT1_2ToNum(aStr, aFloat) then
          begin // may be T1_2
           if (aFloat > 0) then
           begin
            aStr := AnsiString(T1_2ToStr(aFloat));
            fCanvas.TextOut((aRect.Left + aRect.Right - fCanvas.TextWidth(string(aStr)))
             div 2, (aRect.Top + aRect.Bottom) div 2 + fCanvas.Pen.Width
             + 1, string(aStr));
           end;
          end
          else
          begin
           aStr := '???';
           fCanvas.TextOut((aRect.Left + aRect.Right - fCanvas.TextWidth(string(aStr)))
            div 2, (aRect.Top + aRect.Bottom) div 2 + fCanvas.Pen.Width
            + 1, string(aStr));
          end;
         end;
        end;
    // Links
      for I := fLinks.Count - 1 downto 0 do
       fLinks[I].Free;
      fLinks.Clear;
    // fChain.BuildDefaultLinks;
      for I := 0 to fChain.Links.Count - 1 do
      begin
       AddLink(fChain.Links[I]);
      end;
      for I := 0 to fLinks.Count - 1 do
       fLinks[I].Paint4DecayChainImage;
      Result := True;
     end;
   finally
    ThZpAsList.Free;
    ChainMList.Free;
    ChainZList.Free;
    ZList.Free;
    sList.Free;
    ChainTenMplusSlist.Free;
   end;
  except
   Result := False;
  end;
end;

function TChainCAD.ClearCADwoChainClean: Boolean;
var
 I: integer;
 SaveOnChange: TNotifyEvent;
begin
 SaveOnChange:= Self.OnChange;
 for I:= Self.fStates.Count - 1 downto 0 do
  Self.fStates[I].Free;
 Self.fStates.Clear;
 for I:= Self.fLinks.Count - 1 downto 0 do
  Self.fLinks[I].Free;
 Self.fLinks.Clear;
 Self.OnChange:= SaveOnChange;
 Result:= True;
end;

{ TCadStateList }

function TCadStateList.Add(Item: Pointer): integer;
begin
 MessageDlg('Use TChainCad.AddState !', mtWarning, [mbOK], 0);
 Result:= -1;
end;

constructor TCadStateList.Create(aCad: TChainCad);
begin
 inherited Create;
 fCad:= aCad;
end;

procedure TCadStateList.Delete(Index: Integer);
begin
 MessageDlg('Use TChainCad.DeleteState !', mtWarning, [mbOK], 0);
end;

destructor TCadStateList.Destroy;
var
 I: integer;
begin
 for I:= Count - 1 to 0 do
  Self[I].Free;
 inherited;
end;

function TCadStateList.FindInList(const aThZpA_s: integer): integer;
var
 I: integer;
begin
 Result:= -1;
 for I:= Count - 1 to 0 do
  if Self[I].fState.ThZpA_s = aThZpA_s then
  begin
   Result:= I;
   break;
  end;
end;

function TCadStateList.GetState(Index: integer): TCadState;
begin
 Result:= TCadState(Items[Index]);
end;

procedure TCadStateList.SetState(Index: integer; aCadState: TCadState);
begin
 if Items[Index] <> aCadState then
 begin
  TCadState(Items[Index]).Free;
  Items[Index]:= Pointer(aCadState);
 end;
end;

{ TCadLink }

constructor TCadLink.Create(aCAD: TChainCad; aChainLink: TChainLink);
begin
 inherited Create(aCAD);
 fLink:= aChainLink;
end;

procedure TCadLink.Paint;
var
 I, X0, X1, Y0, Y1: integer;
 L, CosFi, SinFi: Float;
 Arrow: array[0..6] of TPoint;
 Xs, Ys: array[0..6] of Float;
 aStr: string;
begin
 if not (fChainCAD.fDrawFissionLinks) then
  if (((Self.fLink.StartThZpA_s div 10000) - (Self.fLink.FinishThZpA_s div 10000) > 2)
   or ((Self.fLink.StartThZpA_s div 10000) - (Self.fLink.FinishThZpA_s div 10000) < -2)) then
   Exit;
 inherited;
 X0:= FRect.Left;
 Y0:= FRect.Top;
 X1:= FRect.Right;
 Y1:= FRect.Bottom;
 L:= sqrt((X1 - X0) * (X1 - X0) + (Y1 - Y0) * (Y1 - Y0));
 if L <> 0 then
 begin
  CosFi:= (X1 - X0) / L;
  SinFi:= (Y1 - Y0) / L;
  Xs[0]:= 0;
  Ys[0]:= fChainCAD.dA / 2;
  Xs[1]:= L - fChainCAD.dAA;
  Ys[1]:= fChainCAD.dA / 2;
  Xs[2]:= L - fChainCAD.dAA - fChainCAD.dAA / 3;
  Ys[2]:= fChainCAD.dA / 2 + fChainCAD.dAA / 3;
  Xs[3]:= L;
  Ys[3]:= 0;
  Xs[4]:= Xs[2];
  Ys[4]:= -Ys[2];
  Xs[5]:= Xs[1];
  Ys[5]:= -Ys[1];
  Xs[6]:= Xs[0];
  Ys[6]:= -Ys[0];
  for I:= 0 to 6 do
  begin
   Arrow[I].x:= X0 + Round(Xs[I] * CosFi - Ys[I] * SinFi);
   Arrow[I].y:= Y0 + Round(Xs[I] * SinFi + Ys[I] * CosFi);
  end;
  if (fChainCAD <> nil) then
   if (fChainCAD.Canvas <> nil) then
    with fChainCAD.Canvas do
    begin
     Polygon(Arrow);
     if fChainCAD.fShowSigmaC then
     begin
      fChainCAD.Canvas.Brush.Style:= bsClear;
      fChainCAD.Canvas.CopyMode:= cmNotSrcErase;
      if PrepareToParse(fLink.ValuesStr[1], aStr) then
       aStr:= Copy(fLink.ValuesStr[1], 1, Pos('B', UpperCase(fLink.ValuesStr[1])) - 1);
      TextOut((fRect.Left + fRect.Right - TextWidth(aStr)) div 2, (fRect.Top + fRect.Bottom) div 2 - fChainCAD.Canvas.TextHeight(aStr) - 1, aStr);
     end;
     if fChainCAD.fShowRI then
     begin
      fChainCAD.Canvas.Brush.Style:= bsClear;
      fChainCAD.Canvas.CopyMode:= cmNotSrcErase;
      if PrepareToParse(fLink.ValuesStr[2], aStr) then
       aStr:= Copy(fLink.ValuesStr[2], 1, Pos('B', UpperCase(fLink.ValuesStr[2])) - 1);
      TextOut((fRect.Left + fRect.Right - TextWidth(aStr)) div 2, (fRect.Top + fRect.Bottom) div 2 + 1, aStr);
     end;
    end;
 end;
end;

procedure TCadLink.Paint4DecayChainImage;
var
 I, X0, X1, Y0, Y1: Integer;
 aFloat, L, CosFi, SinFi: Float;
 Arrow: array [0 .. 6] of TPoint;
 Xs, Ys: array [0 .. 6] of Float;
 aStr: AnsiString;
 IsAlphaLink: Boolean;
 TextX, TextY: LongInt;
begin
 if ((Self.fLink.StartThZpA_s div 10) -
  (Self.fLink.FinishThZpA_s div 10) = 2004) then
  IsAlphaLink := True
 else
  IsAlphaLink := False;
 if not(fChainCAD.fDrawFissionLinks) then
  if (((Self.fLink.StartThZpA_s div 10000) -
   (Self.fLink.FinishThZpA_s div 10000) > 2) or
   ((Self.fLink.StartThZpA_s div 10000) - (Self.fLink.FinishThZpA_s div 10000) < -2)) then
   Exit;
 inherited;
 X0 := FRect.Left;
 Y0 := FRect.Top;
 X1 := FRect.Right;
 Y1 := FRect.Bottom;
 L := sqrt((X1 - X0) * (X1 - X0) + (Y1 - Y0) * (Y1 - Y0));
 if L <> 0 then
 begin
  CosFi := (X1 - X0) / L;
  SinFi := (Y1 - Y0) / L;
  Xs[0] := 0;
  Ys[0] := fChainCAD.dA / 2;
  Xs[1] := L - fChainCAD.dAA;
  Ys[1] := fChainCAD.dA / 2;
  Xs[2] := L - fChainCAD.dAA - fChainCAD.dAA / 3;
  Ys[2] := fChainCAD.dA / 2 + fChainCAD.dAA / 3;
  Xs[3] := L;
  Ys[3] := 0;
  Xs[4] := Xs[2];
  Ys[4] := -Ys[2];
  Xs[5] := Xs[1];
  Ys[5] := -Ys[1];
  Xs[6] := Xs[0];
  Ys[6] := -Ys[0];
  if IsAlphaLink then
  begin
   Ys[0] := Ys[0] + 1.5;
   Ys[6] := -Ys[0];
   Ys[1] := Ys[1] + 1.5;
   Ys[5] := -Ys[1];
   Ys[2] := Ys[2] + 1.5;
   Ys[4] := -Ys[2];
  end;
  for I := 0 to 6 do
  begin
   Arrow[I].X := X0 + Round(Xs[I] * CosFi - Ys[I] * SinFi);
   Arrow[I].Y := Y0 + Round(Xs[I] * SinFi + Ys[I] * CosFi);
  end;
  if (fChainCAD <> nil) then
   if (fChainCAD.Canvas <> nil) then
    with fChainCAD.Canvas do
    begin
     if PrepareToParse(AnsiString(fLink.ValuesStr[0]), aStr) then
     begin
      aStr := AnsiString(Copy(fLink.ValuesStr[0], 1, Pos('*', fLink.ValuesStr[0]) - 1));
      if ValEuSilent(aStr, aFloat) then
       if (aFloat > 0) and (aFloat <= 1) then
       begin
        aStr := DecayPercentFormat(aFloat * 100) + '%';
       end
       else
        aStr := '?'; // was     aStr := '';
      if aStr <> '' then
      begin
       Self.fChainCAD.fCanvas.Font.Style := Self.fChainCAD.fCanvas.Font.Style - [fsBold];
       Polygon(Arrow); // there are links with '0' in ValStr
       if (Arrow[0].X = Arrow[1].X) then // vertical may be m2
       begin
        if Self.fLink.StartThZpA_s mod 10 = 2 then
         TextX := (Arrow[0].X + Arrow[1].X) div 2 - Self.fChainCAD.fCanvas.TextWidth(aStr) - 1
        else
         TextX := (Arrow[0].X + Arrow[1].X) div 2 + 1;
        TextY := EuLib.EuMin(Arrow[0].Y, Arrow[1].Y) + 1;
       end
       else if (IsAlphaLink) then
       begin
        Self.fChainCAD.fCanvas.Font.Style := Self.fChainCAD.fCanvas.Font.Style + [fsBold];
        TextX := EuLib.EuMin(Arrow[0].X, Arrow[1].X) - Round(Self.fChainCAD.fDX * CosFi) - 1;
        TextY := EuLib.EuMin(Arrow[0].Y, Arrow[1].Y) - Round(Self.fChainCAD.fDY * SinFi);
       end
       else
       begin // ?? ??????
        TextX := (Arrow[0].X + Arrow[1].X - Self.fChainCAD.fCanvas.TextHeight(aStr)) div 2 + 1;
        TextY := (Arrow[0].Y + Arrow[1].Y) div 2 - Self.fChainCAD.fCanvas.TextHeight(aStr) - 1;
       end;
       TextOut(TextX, TextY, aStr);
       Self.fChainCAD.fCanvas.Font.Style := Self.fChainCAD.fCanvas.Font.Style - [fsBold];
      end;
     end;
    end;
 end;
end;

procedure TCadLink.Update;
var
 I: integer;
begin
 fStart:= nil;
 fFinish:= nil;
 for I:= 0 to fChainCAD.States.Count - 1 do
  if fChainCAD.States[I].fState.ThZpA_s = fLink.StartThZpA_s then
   Self.fStart:= fChainCAD.States[I]
  else if fChainCAD.States[I].fState.ThZpA_s = fLink.FinishThZpA_s then
   Self.fFinish:= fChainCAD.States[I];
end;

{ TCadLinkList }

function TCadLinkList.Add(Item: Pointer): integer;
begin
 MessageDlg('Use TChainCad.AddLink !', mtWarning, [mbOK], 0);
 Result:= -1;
end;

constructor TCadLinkList.Create(aCad: TChainCad);
begin
 inherited Create;
 fCad:= aCad;
end;

procedure TCadLinkList.Delete(Index: Integer);
begin
 MessageDlg('Use TChainCad.DeleteLink !', mtWarning, [mbOK], 0);
end;

destructor TCadLinkList.Destroy;
var
 I: integer;
begin
 for I:= Count - 1 to 0 do
  Self[I].Free;
 inherited;
end;

function TCadLinkList.FindInList(const aThZpA_sStart,
 aThZpA_sFinish: integer): integer;
var
 I: integer;
begin
 Result:= -1;
 for I:= Count - 1 to 0 do
  if ((Self[I].fLink.StartThZpA_s = aThZpA_sStart) and (Self[I].fLink.FinishThZpA_s = aThZpA_sFinish)) then
  begin
   Result:= I;
   break;
  end;
end;

function TCadLinkList.GetCadLink(Index: integer): TCadLink;
begin
 Result:= TCadLink(Items[Index]);
end;

procedure TCadLinkList.SetCadLink(Index: integer; aCadLink: TCadLink);
begin
 if Items[Index] <> aCadLink then
 begin
  TCadLink(Items[Index]).Free;
  Items[Index]:= Pointer(aCadLink);
 end;
end;

end.

