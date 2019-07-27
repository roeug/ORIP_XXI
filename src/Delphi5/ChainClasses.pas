unit ChainClasses;

interface
uses
 windows, classes, Controls, messages, forms, Dialogs, graphics, extctrls, menus, comctrls,
 EuLib, NuclideClasses;
type
 TChainStateList = class;
 TChainLinkList = class;
 TChainState = class;
 TChainLink = class;
 {TChain}
 TChain = class
 private
  fStates: TChainStateList;
  fLinks: TChainLinkList;
  fModified: Boolean;
  fNuclideList: TNuclideList;
  fDataModule: TDataModule;
  fFileName: string;
  FOnChange: TNotifyEvent;
  fElememtNamesList: TStringList;
  fWorking: Boolean;
 protected
  procedure SetModified(aValue: Boolean);
  //  function GetNumberOfStates: integer;
 public
  procedure ListStates(var Lines: TStringList);
  procedure ListLinks(var Lines: TStringList);
  procedure ListElements(var ToList: TStringList); //=nil);
  function FindElements(const ElementName: string; var FoundStates: TLongIntList): Boolean;
  function LoadFromFile(const FileName: string): Boolean;
  function AddLinkByName(const Start: string; const Finish: string;
   const LoadFromDB: Boolean;
   const aTransitions: TNuclideTransitions = [ntCapture, ntFission, ntDecay, ntThreshold];
   const aNuclideList: TNuclideList = nil;
   const aDataModule: Pointer = nil): TChainLink;
  function AddStateByName(// tipa Ru-106, U-235g, U-235m, Bi-212m1, Bi-212m2
   const aName: string;
   const BuildLinks: Boolean = True;
   const Transitions: TNuclideTransitions = [ntCapture, ntFission, ntDecay, ntThreshold];
   const aNuclideList: TNuclideList = nil;
   const aDataModule: Pointer = nil;
   const RebuildExistentLinks: Boolean = True): TChainState;
  function LoadFromStream(Stream: TStream): Boolean;
  function SaveToStream(Stream: TStream): Boolean;
  function SaveToFile(const FileName: string): Boolean;
  procedure AddState(
   const aState: TChainState;
   const BuildLinks: Boolean = True;
   const Transitions: TNuclideTransitions = [ntCapture, ntFission, ntDecay, ntThreshold];
   const aNuclideList: TNuclideList = nil;
   const aDataModule: Pointer = nil;
   const RebuildExistentLinks: Boolean = True);
  procedure DeleteState(aState: TChainState);
  procedure AddLink(aLink: TChainLink);
  procedure DeleteLink(aLink: TChainLink);
  procedure Assign(Source: TChain);
  function BuildDefaultLinks(
   const Transitions: TNuclideTransitions = [ntCapture, ntFission, ntDecay, ntThreshold];
   const aNuclideList: TNuclideList = nil;
   const aDataModule: Pointer = nil;
   const RebuildExistent: Boolean = True): Boolean;
  function BuildDefaultLinksForState(
   const aState: TChainState;
   const Transitions: TNuclideTransitions = [ntCapture, ntFission, ntDecay, ntThreshold];
   const aNuclideList: TNuclideList = nil;
   const aDataModule: Pointer = nil;
   const RebuildExistent: Boolean = True): Boolean;
  function FindLink(Start, Finish: TChainState): integer; //-1 not found
  function FindState(const aThZpA_s: integer): integer; //-1 not found
  constructor Create(const aNuclideList: TNuclideList = nil);
  //  function CreateNuclideList(const aFileName: string; ProgressBar: TProgressBar=nil): TNuclideList;
  destructor Destroy; override;
  procedure FindDecayParents_(const aThZpA_s: integer;
   var Parents: TLongIntList; aNuclideList: TNuclideList);
  procedure FindDecayParentsWithNonZeroFissionYields(const aThZpA_s: integer;
   var Parents: TLongIntList; aNuclideList: TNuclideList);
  //  property NoOfStates: integer read GetNumberOfStates;
  property States: TChainStateList read fStates;
  property Links: TChainLinkList read fLinks;
  property Modified: Boolean read fModified write SetModified;
  property NuclideList: TNuclideList read fNuclideList write fNuclideList;
  property OnChange: TNotifyEvent read FOnChange write FOnChange;
  property Working: Boolean read fWorking;
 end;
 
 { TChainState }
 TChainState = class
 protected
  fChain: TChain;
  fThZpA_s: integer;
  fName: string;
  fValuesStr: TStringList;
  function GetFluxDecrease(ValuesStrNo: integer): float;
  function GetDecayDecrease: float;
  function GetThermalDecrease: float;
  function GetResonanceDecrease: float;
  function GetFastDecrease: float;
  function GetG_Factor: float;
  function GetStateName: string;
 public
  function GetDecayTypeValue(const aDT: TDecayType = dtNone): Float; // dtNone - total == Lambda
  function GetSigmaF(const SpectrumPart: integer): Float;
  (*
    procedure GetChilds(const List: TChainStateList;const  aNuclideList: TNuclideList=nil;
     const Transitions: TNuclideTransitions= [ntCapture, ntFission, ntDecay, ntThreshold]);
  *)
  procedure Assign(Source: TChainState);
  function LoadFromStream(aChain: TChain; Stream: TStream): Boolean;
  function SaveToStream(Stream: TStream): Boolean;
  function SaveToFile(const FileName: string): Boolean;
  property Name: string read GetStateName;
  property Chain: TChain read fChain;
  property ThZpA_s: integer read fThZpA_s;
  property ValuesStr: TStringList read fValuesStr write fValuesStr;
  property DecayDecrease: Float read GetDecayDecrease;
  property ThermalDecrease: Float read GetThermalDecrease;
  property ResonanceDecrease: Float read GetResonanceDecrease;
  property FastDecrease: Float read GetFastDecrease;
  property G_Factor: Float read GetG_Factor;
  constructor Create(aChain: TChain; aThZpA_s: integer = -1; aName: string = '');
  constructor CreateFromNuclideState(aChain: TChain; NuclideState: TNuclideState; aDataModule: Pointer = nil);
  destructor Destroy; override;
 end;
 
 {TChainLink}
 TChainLink = class
 private
  fChain: TChain;
  fStartThZpA_s: integer;
  fFinishThZpA_s: integer;
  fValuesStr: TStringList;
  function GetFinishThZpA_s: integer;
  function GetStartThZpA_s: integer;
 protected
  function GetStartName: string;
  function GetFinishName: string;
  function GetStartState: TChainState;
  function GetFinishState: TChainState;
  function GetName: string;
 public
  function FindStartStateChainNo: integer;
  function FindFinishStateChainNo: integer;
  function SaveToStream(Stream: TStream): Boolean;
  function LoadFromStream(aChain: TChain; Stream: TStream): Boolean;
  constructor Create(aChain: TChain; const aStartState, aFinishState: integer);
  property Chain: TChain read fChain;
  property ValuesStr: TStringList read fValuesStr write fValuesStr;
  property StartThZpA_s: integer read GetStartThZpA_s;
  property FinishThZpA_s: integer read GetFinishThZpA_s;
  property StartState: TChainState read GetStartState;
  property FinishState: TChainState read GetFinishState;
  property Name: string read GetName; // tipa Ag-117m->Ag-118
  destructor Destroy; override;
 end;
 
 {TChainLinkList}
 TChainLinkList = class(TList)
 protected
  fChain: TChain;
  function GetChainLink(Index: integer): TChainLink;
  procedure SetChainLink(Index: integer; aChainLink: TChainLink);
 public
  function Add(Item: Pointer): Integer; overload;
  procedure Delete(Index: Integer); overload;
  procedure Assign(Source: TChainLinkList);
  destructor Destroy; override;
  constructor Create(aChain: TChain);
  property
   ChainLinks[Index: integer]: TChainLink read GetChainLink write SetChainLink; default;
 end;
 
 {TChainStateList}
 TChainStateList = class(TList)
 private
  fChain: TChain;
 protected
  function GetChainState(Index: integer): TChainState;
  procedure SetChainState(Index: integer; aChainState: TChainState);
 public
  procedure Delete(Index: Integer); overload;
  function Add(Item: Pointer): integer; overload;
  property Chain: TChain read fChain;
  procedure Assign(Source: TChainStateList);
  function FindInList(const aThZpA_s: integer): integer;
  destructor Destroy; override;
  constructor Create(aChain: TChain);
  property
   ChainStates[Index: integer]: TChainState read GetChainState write SetChainState; default;
 end;
 
const
 // Chain Load Options
 cloBasic: DWORD = $0001;
 cloFission: DWORD = $0002;
 cloSubBranching: DWORD = $0004;
 
implementation
uses
 Sysutils,Parsing, UnitDM_OOB;
const
 BeginStateChar = #1;
 EndStateChar = #2;
 BeginLinkChar = #3;
 EndLinkChar = #4;
 EndOfLine = #13#10;
 
function InternalTextFormat(const aFloat: Float): string;
begin
 Result:= Trim(Format('%-7.5g', [aFloat]));
 // Result:= Trim(Format('%-5.3g', [aFloat]));
end;

{TChainStateList}

procedure TChainStateList.Assign(Source: TChainStateList);
var
 I: integer;
 TmpState: TChainState;
begin
 if Self <> Source then
 begin
  Self.Clear;
  for I:= 0 to Source.Count - 1 do
  begin
   TmpState:= TChainState.Create(Self.fChain);
   TmpState.Assign(Source[I]);
   TList(Self).Add(TmpState);
  end;
 end;
end;

function TChainStateList.FindInList(const aThZpA_s: integer): integer;
var
 I: integer;
begin
 Result:= -1;
 for I:= 0 to (Count - 1) do
  if (Self[I].ThZpA_s = aThZpA_s) then
  begin
   Result:= I;
   break;
  end;
end;

constructor TChainStateList.Create(aChain: TChain);
begin
 inherited Create;
 fChain:= aChain;
end;

function TChainStateList.GetChainState(Index: integer): TChainState;
begin
 Result:= TChainState(Items[Index]);
end;

procedure TChainStateList.SetChainState(Index: integer; aChainState: TChainState);
begin
 TChainState(Items[Index]).Free;
 Items[Index]:= Pointer(aChainState);
end;

function TChainStateList.Add(Item: Pointer): integer;
begin
 MessageDlg('Use Chain AddState !', mtWarning, [mbOK], 0);
 Result:= -1;
end;

destructor TChainStateList.Destroy;
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

{TTChainLinkList}

constructor TChainLinkList.Create(aChain: TChain);
begin
 inherited Create;
 fChain:= aChain;
end;

procedure TChainLinkList.Assign(Source: TChainLinkList);
var
 I: integer;
 TmpLink: TChainLink;
begin
 if Self <> Source then
 begin
  Self.Clear;
  for I:= 0 to Source.Count - 1 do
  begin
   TmpLink:= TChainLink.Create(Self.fChain, Source[I].fStartThZpA_s, Source[I].fFinishThZpA_s);
   TList(Self).Add(TmpLink);
  end;
 end;
end;

function TChainLinkList.GetChainLink(Index: integer): TChainLink;
begin
 Result:= TChainLink(Items[Index]);
end;

function TChainLinkList.Add(Item: Pointer): integer;
begin
 MessageDlg('Use Chain.AddLink !', mtWarning, [mbOK], 0);
 Result:= -1;
end;

destructor TChainLinkList.Destroy;
var
 I: integer;
begin
 for I:= Self.Count - 1 downto 0 do
  Self[I].Free;
 inherited Destroy;
end;

procedure TChainStateList.Delete(Index: Integer);
begin
 MessageDlg('Use Chain.DeleteState method !', mtWarning, [mbOK], 0);
end;

{ TChain }

procedure TChain.AddLink(aLink: TChainLink);
var
 I, FoundNo: integer;
begin
 FoundNo:= -1;
 for I:= 0 to fLinks.Count - 1 do
  if ((fLinks[I].fStartThZpA_s = aLink.fStartThZpA_s) and
   (fLinks[I].fFinishThZpA_s = aLink.fFinishThZpA_s)) then
  begin
   FoundNo:= I;
   break;
  end;
 if FoundNo >= 0 then
 begin
  if (fLinks[FoundNo] <> aLink) then
  begin
   fLinks[FoundNo].fValuesStr.Assign(aLink.fValuesStr);
   SetModified(True);
  end
 end
 else
 begin
  TList(fLinks).Add(aLink);
  SetModified(True);
 end;
end;

function TChain.AddLinkByName(
 const Start: string;
 const Finish: string;
 const LoadFromDB: Boolean;
 const aTransitions: TNuclideTransitions = [ntCapture, ntFission, ntDecay, ntThreshold];
 const aNuclideList: TNuclideList = nil;
 const aDataModule: Pointer = nil): TChainLink;
var
 I, StartThZpA_s, FinishThZpA_s: integer;
 TheNuclideList: TNuclideList;
 StartState, FinishState: TChainState;
 TheLink: TChainLink;
 Answers: TStringList;
begin
 Result:= nil;
 StartState:= nil;
 FinishState:= nil;
 try
  if aNuclideList <> nil then
   TheNuclideList:= aNuclideList
  else if fNuclideList <> nil then
   TheNuclideList:= fNuclideList
  else
   TheNuclideList:= nil;
  StartThZpA_s:= StrToThZpA_s(Start);
  for I:= 0 to fStates.Count - 1 do
   if (fStates[I].ThZpA_s = StartThZpA_s) then
   begin
    StartState:= fStates[I];
    break;
   end;
  FinishThZpA_s:= StrToThZpA_s(Finish);
  if StartThZpA_s = FinishThZpA_s then
   Exit;
  for I:= 0 to fStates.Count - 1 do
   if (fStates[I].ThZpA_s = FinishThZpA_s) then
   begin
    FinishState:= fStates[I];
    break;
   end;
  if ((StartState <> nil) and (FinishState <> nil) and (StartState <> FinishState)) then
  begin
   TheLink:= TChainLink.Create(Self, StartThZpA_s, FinishThZpA_s);
   if LoadFromDB then
    if TheNuclideList <> nil then
    begin
     Answers:= TStringList.Create;
     TheNuclideList.GetLink(StartThZpA_s, FinishThZpA_s, Answers, aTransitions, T_DataModuleOOB(aDataModule));
    end;
   Self.AddLink(TheLink);
   Result:= TheLink;
  end;
 except
  Result:= nil;
 end;
end;

procedure TChain.AddState(const aState: TChainState;
 const BuildLinks: Boolean = True;
 const Transitions: TNuclideTransitions = [ntCapture, ntFission, ntDecay, ntThreshold];
 const aNuclideList: TNuclideList = nil;
 const aDataModule: Pointer = nil;
 const RebuildExistentLinks: Boolean = True);
var
 I, FoundNo: integer;
 TheNuclideList: TNuclideList;
begin
 if aNuclideList <> nil then
  TheNuclideList:= aNuclideList
 else if fNuclideList <> nil then
  TheNuclideList:= fNuclideList
 else
  TheNuclideList:= nil;
 FoundNo:= -1;
 for I:= 0 to fStates.Count - 1 do
  if (fStates[I].fThZpA_s = aState.fThZpA_s) then
  begin
   FoundNo:= I;
   break;
  end;
 if FoundNo >= 0 then
 begin
  fStates[FoundNo].Free;
  fStates.Delete(FoundNo);
  SetModified(True);
 end;
 TList(fStates).Add(aState);
 if BuildLinks then
  BuildDefaultLinksForState(aState, Transitions, TheNuclideList, aDataModule, RebuildExistentLinks);
 SetModified(True);
end;

function TChain.AddStateByName(// tipa Ru-106, U-235g, U-235m, Bi-212m1, Bi-212m2
 const aName: string;
 const BuildLinks: Boolean = True;
 const Transitions: TNuclideTransitions = [ntCapture, ntFission, ntDecay, ntThreshold];
 const aNuclideList: TNuclideList = nil;
 const aDataModule: Pointer = nil;
 const RebuildExistentLinks: Boolean = True): TChainState;
var
 I, J, ThZpA_s: integer;
 TheNuclideList: TNuclideList;
 TheState: TChainState;
 AlreadyInChain: Boolean;
begin
 fWorking:= True;
 Result:= nil;
 try
  try
   if aNuclideList <> nil then
    TheNuclideList:= aNuclideList
   else if fNuclideList <> nil then
    TheNuclideList:= fNuclideList
   else
    TheNuclideList:= nil;
   ThZpA_s:= StrToThZpA_s(aName);
   AlreadyInChain:= False;
   for I:= 0 to fStates.Count - 1 do
    if fStates[I].fThZpA_s = ThZpA_s then
    begin // ALREADY EXISTS
     AlreadyInChain:= True;
     Result:= fStates[I];
     break;
    end;
   if BuildLinks then
    for I:= fStates.Count - 1 downto 0 do
     if (fStates[I].ThZpA_s = ThZpA_s) then
     begin
      BuildDefaultLinksForState(fStates[I], Transitions, TheNuclideList, aDataModule, RebuildExistentLinks);
      Exit;
     end;
   if AlreadyInChain then
    Exit;
   if TheNuclideList <> nil then
   begin
    if TheNuclideList.FindThZpA_s(ThZpA_s, I, J) then
    begin
     TheState:= TChainState.CreateFromNuclideState(Self, TheNuclideList[I].StateList[J], aDataModule);
     AddState(TheState, BuildLinks, Transitions);
     if BuildLinks then
      BuildDefaultLinksForState(fStates[fStates.Count - 1], Transitions, TheNuclideList, aDataModule, RebuildExistentLinks);
     Result:= TheState;
    end;
   end
   else
   begin
    TheState:= TChainState.Create(Self, ThZpA_s, aName);
    AddState(TheState, BuildLinks, Transitions);
    if BuildLinks then
     BuildDefaultLinksForState(fStates[fStates.Count - 1], Transitions, TheNuclideList, aDataModule, RebuildExistentLinks);
    Result:= TheState;
   end;
  except
   Result:= nil;
  end;
 finally
  fWorking:= False;
 end;
end;

procedure TChain.Assign(Source: TChain);
begin
 if Source <> Self then
  with Source, Self do
  begin
   Self.fStates.Assign(Source.fStates);
   Self.fLinks.Assign(Source.fLinks);
  end;
end;

function TChain.BuildDefaultLinks(
 const Transitions: TNuclideTransitions = [ntCapture, ntFission, ntDecay, ntThreshold];
 const aNuclideList: TNuclideList = nil;
 const aDataModule: Pointer = nil;
 const RebuildExistent: Boolean = True): Boolean;
var
 I: integer;
begin
 try
  if aNuclideList <> nil then
  begin
   for I:= 0 to fStates.Count - 1 do
    BuildDefaultLinksForState(fStates[I], Transitions, aNuclideList, aDataModule, RebuildExistent);
   Result:= True;
  end
  else if aNuclideList <> nil then
  begin
   for I:= 0 to fStates.Count - 1 do
    BuildDefaultLinksForState(fStates[I], Transitions, fNuclideList, aDataModule, RebuildExistent);
   Result:= True;
  end
  else
   Result:= False;
 except
  Result:= False;
 end;
end;

function TChain.BuildDefaultLinksForState(
 const aState: TChainState;
 const Transitions: TNuclideTransitions = [ntCapture, ntFission, ntDecay, ntThreshold];
 const aNuclideList: TNuclideList = nil;
 const aDataModule: Pointer = nil;
 const RebuildExistent: Boolean = True): Boolean;
var
 J, K: integer;
 StrList: TStringList;
 GetLinkResult: DWORD;
 aLink: TChainLink;
 aStr: string;
 TheNuclideList: TNuclideList;
begin
 if aNuclideList <> nil then
  TheNuclideList:= aNuclideList
 else if fNuclideList <> nil then
  TheNuclideList:= fNuclideList
 else
 begin
  Result:= False;
  exit;
 end;
 StrList:= TStringList.Create;
 try
  try
   // aState-Parent
   for J:= 0 to fStates.Count - 1 do
    if fStates[J] <> aState then
    begin
     GetLinkResult:= TheNuclideList.GetLink(aState.ThZpA_s, fStates[J].ThZpA_s, StrList, Transitions, T_DataModuleOOB(aDataModule), True);
     if ((FindLink(aState, fStates[J]) >= 0) and RebuildExistent) or (FindLink(aState, fStates[J]) < 0) then
      if GetLinkResult <> sltNone then
      begin
       aLink:= TChainLink.Create(Self, aState.ThZpA_s, fStates[J].ThZpA_s);
       while aLink.ValuesStr.Count < 6 do
        aLink.ValuesStr.Add('');
       if (GetLinkResult and sltDecay) > 0 then
       begin
        aStr:= '';
        for K:= 0 to StrList.Count - 1 do
         if Pos('DECAY', UpperCase(StrList[K])) > 0 then
          aStr:= AddTwoStrings(aStr, StrList[K]);
        aLink.ValuesStr[0]:= aStr;
       end;
       if (GetLinkResult and sltThermal) > 0 then
       begin
        aStr:= '';
        for K:= 0 to StrList.Count - 1 do
         if Pos('THERMAL', UpperCase(StrList[K])) > 0 then
          aStr:= AddTwoStrings(aStr, StrList[K]);
        aLink.ValuesStr[1]:= aStr;
       end;
       if (GetLinkResult and sltResonance) > 0 then
       begin
        aStr:= '';
        for K:= 0 to StrList.Count - 1 do
         if Pos('RESONANCE', UpperCase(StrList[K])) > 0 then
          aStr:= AddTwoStrings(aStr, StrList[K]);
        aLink.ValuesStr[2]:= aStr;
       end;
       if (GetLinkResult and sltFast) > 0 then
       begin
        aStr:= '';
        for K:= 0 to StrList.Count - 1 do
         if Pos('FAST', UpperCase(StrList[K])) > 0 then
          aStr:= AddTwoStrings(aStr, StrList[K]);
        aLink.ValuesStr[3]:= aStr;
       end;
       aStr:= '';
       for K:= 0 to StrList.Count - 1 do
        if Pos('G_FACTOR', UpperCase(StrList[K])) > 0 then
         aStr:= AddTwoStrings(aStr, StrList[K]);
       aLink.ValuesStr[4]:= aStr;
       aLink.ValuesStr[5]:= '// auto created by BuildDefaultLinks';
       Self.AddLink(aLink);
      end;
    end;
   // aState-Child
   for J:= 0 to fStates.Count - 1 do
    if fStates[J] <> aState then
    begin
     GetLinkResult:= TheNuclideList.GetLink(fStates[J].ThZpA_s, aState.ThZpA_s, StrList, Transitions, T_DataModuleOOB(aDataModule), True);
     if ((FindLink(fStates[J], aState) >= 0) and RebuildExistent) or (FindLink(fStates[J], aState) < 0) then
      if GetLinkResult <> sltNone then
      begin
       aLink:= TChainLink.Create(Self, fStates[J].ThZpA_s, aState.ThZpA_s);
       while aLink.ValuesStr.Count < 6 do
        aLink.ValuesStr.Add('');
       if (GetLinkResult and sltDecay) > 0 then
       begin
        aStr:= '';
        for K:= 0 to StrList.Count - 1 do
         if Pos('DECAY', UpperCase(StrList[K])) > 0 then
          aStr:= AddTwoStrings(aStr, StrList[K]);
        aLink.ValuesStr[0]:= aStr;
       end;
       if (GetLinkResult and sltThermal) > 0 then
       begin
        aStr:= '';
        for K:= 0 to StrList.Count - 1 do
         if Pos('THERMAL', UpperCase(StrList[K])) > 0 then
          aStr:= AddTwoStrings(aStr, StrList[K]);
        aLink.ValuesStr[1]:= aStr;
       end;
       if (GetLinkResult and sltResonance) > 0 then
       begin
        aStr:= '';
        for K:= 0 to StrList.Count - 1 do
         if Pos('RESONANCE', UpperCase(StrList[K])) > 0 then
          aStr:= AddTwoStrings(aStr, StrList[K]);
        aLink.ValuesStr[2]:= aStr;
       end;
       if (GetLinkResult and sltFast) > 0 then
       begin
        aStr:= '';
        for K:= 0 to StrList.Count - 1 do
         if Pos('FAST', UpperCase(StrList[K])) > 0 then
          aStr:= AddTwoStrings(aStr, StrList[K]);
        aLink.ValuesStr[3]:= aStr;
       end;
       aStr:= '';
       for K:= 0 to StrList.Count - 1 do
        if Pos('G_FACTOR', UpperCase(StrList[K])) > 0 then
         aStr:= AddTwoStrings(aStr, StrList[K]);
       aLink.ValuesStr[4]:= aStr;
       aLink.ValuesStr[5]:= '// auto created by BuildDefaultLinks';
       Self.AddLink(aLink);
      end;
    end;
   Result:= True;
  finally
   StrList.Free;
  end;
 except
  Result:= False;
 end;
end;

constructor TChain.Create(const aNuclideList: TNuclideList = nil);
begin
 inherited Create;
 fNuclideList:= aNuclideList;
 fStates:= TChainStateList.Create(Self);
 fLinks:= TChainLinkList.Create(Self);
 fDataModule:= nil;
 fFileName:= '';
 FOnChange:= nil;
 fElememtNamesList:= TStringList.Create;
end;

(*
function TChain.CreateNuclideList(const aFileName: string; ProgressBar: TProgressBar=nil): TNuclideList;
begin
 fDataModule:= UnitDM_OOB._DataModuleOOB;
 fFileName:= aFileName;
 T_DataModuleOOB(fDataModule).DatabaseName:= aFileName;
 fNuclideList:= TNuclideList.Create;
 fNuclideList.LoadFromDB(fDataModule, ProgressBar);
 Result:= fNuclideList;
end;
*)

procedure TChain.DeleteLink(aLink: TChainLink);
var
 I: integer;
 aModified: Boolean;
begin
 aModified:= fModified;
 for I:= fLinks.Count - 1 downto 0 do
  if fLinks[I] = aLink then
  begin
   fLinks[I].Free;
   TList(fLinks).Delete(I);
   aModified:= True;
   break;
  end;
 SetModified(aModified);
end;

procedure TChain.DeleteState(aState: TChainState);
var
 I: integer;
 aModified: Boolean;
begin
 aModified:= fModified;
 for I:= fLinks.Count - 1 downto 0 do
  if ((fLinks[I].fStartThZpA_s = aState.fThZpA_s) or (fLinks[I].fFinishThZpA_s = aState.fThZpA_s)) then
  begin
   DeleteLink(fLinks[I]);
   aModified:= True;
  end;
 for I:= fStates.Count - 1 downto 0 do
  if fStates[I] = aState then
  begin
   fStates[I].Free;
   TList(fStates).Delete(I);
   aModified:= True;
   break;
  end;
 SetModified(aModified);
end;

destructor TChain.Destroy;
begin
 fStates.Free;
 fLinks.Free;
 FOnChange:= nil;
 fElememtNamesList.Free;
 inherited;
end;

procedure TChain.FindDecayParents_(const aThZpA_s: integer;
 var Parents: TLongIntList; aNuclideList: TNuclideList);
var
 TheChaildNo, TheParentNo: integer;
 StrList: TStringList;
 GetLinkResult: DWORD;
 TheNuclideList: TNuclideList;
begin
 Parents.Clear;
 TheChaildNo:= FindState(aThZpA_s);
 if TheChaildNo < 0 then
  Exit;
 StrList:= TStringList.Create;
 if aNuclideList <> nil then
  TheNuclideList:= aNuclideList
 else if fNuclideList <> nil then
  TheNuclideList:= fNuclideList
 else
  TheNuclideList:= nil;
 try
  try
   for TheParentNo:= 0 to Self.fStates.Count - 1 do
    if (FindLink(Self.fStates[TheParentNo], Self.fStates[TheChaildNo]) >= 0) then
    begin
     GetLinkResult:= TheNuclideList.GetLink(Self.fStates[TheParentNo].fThZpA_s, aThZpA_s, StrList, [ntDecay], nil);
     if (GetLinkResult <> sltNone) then
      Parents.Add(Self.fStates[TheParentNo].fThZpA_s);
    end;
  except
   Parents.Clear;
  end;
 finally
  StrList.Free;
 end;
end;

procedure TChain.FindDecayParentsWithNonZeroFissionYields(const aThZpA_s: integer;
 var Parents: TLongIntList; aNuclideList: TNuclideList);
var
 TheChaildNo, TheParentNo, I, K: integer;
 StrList: TStringList;
 GetLinkResult: DWORD;
 TheNuclideList: TNuclideList;
 ParentHasYield: Boolean;
begin
 Parents.Clear;
 TheChaildNo:= FindState(aThZpA_s);
 if TheChaildNo < 0 then
  Exit;
 StrList:= TStringList.Create;
 if aNuclideList <> nil then
  TheNuclideList:= aNuclideList
 else if fNuclideList <> nil then
  TheNuclideList:= fNuclideList
 else
  TheNuclideList:= nil;
 try
  try
   for TheParentNo:= 0 to Self.fStates.Count - 1 do
    if (FindLink(Self.fStates[TheParentNo], Self.fStates[TheChaildNo]) >= 0) then
    begin
     GetLinkResult:= TheNuclideList.GetLink(Self.fStates[TheParentNo].fThZpA_s, aThZpA_s, StrList, [ntDecay], nil);
     if (GetLinkResult <> sltNone) then
     begin
      ParentHasYield:= False;
      for I:= 0 to Self.fLinks.Count - 1 do
      begin
       if (Self.fLinks[I].fFinishThZpA_s = Self.fStates[TheParentNo].fThZpA_s) then
        for K:= 0 to Self.fLinks[I].fValuesStr.Count - 1 do
         if (Pos('YIELD', UpperCase(Self.fLinks[I].fValuesStr[K])) > 0) then
         begin
          ParentHasYield:= True;
          break;
         end;
       if ParentHasYield then
        break;
      end;
      if ParentHasYield then
       Parents.Add(Self.fStates[TheParentNo].fThZpA_s);
     end;
    end;
  except
   Parents.Clear;
  end;
 finally
  StrList.Free;
 end;
end;

function TChain.FindElements(const ElementName: string; var FoundStates: TLongIntList): Boolean;
var
 I: integer;
begin
 FoundStates.Clear;
 try
  for I:= 0 to fStates.Count - 1 do
   if Pos(UpperCase(' '+ElementName) + '-', UpperCase(' '+fStates[I].Name)) > 0 then
    FoundStates.Add(I);
  Result:= True;
 except
  Result:= False;
 end;
end;

function TChain.FindLink(Start, Finish: TChainState): integer;
var
 I: integer;
begin
 Result:= -1;
 for I:= 0 to fLinks.Count - 1 do
  if ((fLinks[I].StartThZpA_s = Start.ThZpA_s) and
   (fLinks[I].FinishThZpA_s = Finish.ThZpA_s)) then
  begin
   Result:= I;
   break;
  end;
end;

function TChain.FindState(const aThZpA_s: integer): integer;
var
 I: integer;
begin
 Result:= -1;
 for I:= 0 to fStates.Count - 1 do
  if (fStates[I].ThZpA_s = aThZpA_s) then
  begin
   Result:= I;
   break;
  end;
end;

(*
function TChain.GetNumberOfStates: integer;
begin
 try
  Result:= Self.fStates.Count;
 except
  Result:= -1;
 end;
end;
*)

procedure TChain.ListElements(var ToList: TStringList);
var
 I: integer;
begin
 fElememtNamesList.Clear;
 for I:= 0 to fStates.Count - 1 do
  AddUniqToStrList(fElememtNamesList, ElementNameFromStateName(fStates[I].Name));
 if (ToList <> nil) then
  ToList.Assign(fElememtNamesList);
end;

procedure TChain.ListLinks(var Lines: TStringList);
var
 I: integer;
begin
 Lines.Clear;
 for I:= 0 to fLinks.Count - 1 do
  Lines.Add(fLinks[I].Name);
end;

procedure TChain.ListStates(var Lines: TStringList);
var
 I: integer;
begin
 Lines.Clear;
 for I:= 0 to fStates.Count - 1 do
  Lines.Add(fStates[I].Name);
end;

function TChain.LoadFromFile(const FileName: string): Boolean;
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

function TChain.LoadFromStream(Stream: TStream): Boolean;
var
 aState: TChainState;
 aLink: TChainLink;
 Buffer: PChar;
begin
 New(Buffer);
 try
  with Stream do
   repeat
    Read(Buffer^, 1);
    if Buffer^ = BeginStateChar then
    begin
     Position:= Position - 1;
     aState:= TChainState.Create(Self);
     aState.LoadFromStream(Self, Stream);
     AddState(aState, False);
    end
    else if Buffer^ = BeginLinkChar then
    begin
     Position:= Position - 1;
     aLink:= TChainLink.Create(Self, -1, -1);
     aLink.LoadFromStream(Self, Stream);
     AddLink(aLink);
    end
   until (Stream.Position + 1 > Stream.Size);
  Result:= True;
 except
  Result:= False;
 end;
 Dispose(Buffer);
end;

function TChain.SaveToFile(const FileName: string): Boolean;
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

function TChain.SaveToStream(Stream: TStream): Boolean;
var
 i: integer;
begin
 try
  for i:= 0 to fStates.Count - 1 do
   fStates[i].SaveToStream(Stream);
  for i:= 0 to fLinks.Count - 1 do
   fLinks[i].SaveToStream(Stream);
  Result:= True;
 except
  Result:= False;
 end;
end;

procedure TChain.SetModified(aValue: Boolean);
begin
 if aValue then
 begin
  fModified:= True;
  if Assigned(FOnChange) then
   FOnChange(Self);
 end;
end;

{ TChainState }

procedure TChainState.Assign(Source: TChainState);
begin
 if Self <> Source then
  with Self, Source do
  begin
   Self.fThZpA_s:= Source.fThZpA_s;
   Self.fName:= Source.fName;
   Self.fValuesStr.Assign(Source.fValuesStr);
  end;
end;

constructor TChainState.Create(aChain: TChain; aThZpA_s: integer = -1; aName: string = '');
begin
 inherited Create;
 fValuesStr:= TStringList.Create;
 fName:= aName;
 fThZpA_s:= aThZpA_s;
 fChain:= aChain;
 with fValuesStr do
 begin
  fValuesStr.Add('0 //Lambda');
  fValuesStr.Add('0 //Thermal Xsec');
  fValuesStr.Add('0 //Resonance Xsec');
  fValuesStr.Add('0 //Fast Xsec');
  fValuesStr.Add('1 //g_factor');
  fValuesStr.Add('//Comment Decay chanels will be below ');
 end;
end;

constructor TChainState.CreateFromNuclideState(aChain: TChain;
 NuclideState: TNuclideState; aDataModule: Pointer = nil);
var
 i: integer;
 TmpFloat, SigmaAdd, RIadd: Float;
begin
 Self.create(aChain);
 with Self, NuclideState do
 begin
  fThZpA_s:= (1000 * NuclideState.Nuclide.Znum + NuclideState.Nuclide.Amass) * 10 + NuclideState.State;
  fName:= NuclideState.GetStateName;
  with fValuesStr do
  begin
   TmpFloat:= NuclideState.Lambda; // fValuesStr[0]
   if TmpFloat >= 0 then
   begin
    if not (NuclideState.IsStable) then
     fValuesStr[0]:= InternalTextFormat(TmpFloat) + ' // Lambda from NuclideState T=' + T1_2ToStr(NuclideState.T1_2)
    else
     fValuesStr[0]:= InternalTextFormat(TmpFloat) + ' // Lambda from NuclideState Stable'
   end
   else
    fValuesStr[0]:= '0 // Lambda default';
   // fValuesStr[1]
   TmpFloat:= NuclideState.TotalSigmaC;
   // fValuesStr[1]+ SigmaF
   SigmaAdd:= NuclideState.SigmaF;
   if (SigmaAdd < 1.E-30) then
   begin
    if TmpFloat > 0 then
     fValuesStr[1]:= InternalTextFormat(TmpFloat) + 'b // TotalSigmaC from NuclideState '
    else
     fValuesStr[1]:= '0 // SigmaC default=0';
   end
   else
   begin
    if TmpFloat > 0 then
     fValuesStr[1]:= InternalTextFormat(TmpFloat) + 'b +'
      + InternalTextFormat(SigmaAdd) + 'b // TotalSigmaC + SigmaF from NuclideState '
    else
     fValuesStr[1]:= '0 + ' + InternalTextFormat(SigmaAdd) + 'b //SigmaC default=0 + SigmaF from NuclideState ';
   end;
   // fValuesStr[2]
   TmpFloat:= NuclideState.TotalRI;
   // fValuesStr[2]+RIf
   RIadd:= NuclideState.RIf;
   if (RIadd < 1.E-30) then
   begin
    if TmpFloat > 0 then
     fValuesStr[2]:= InternalTextFormat(TmpFloat) + 'b // TotalRI from NuclideState '
    else
     fValuesStr[2]:= '0 // RI default=0';
   end
   else
   begin // RI_F
    if TmpFloat > 0 then
     fValuesStr[2]:= InternalTextFormat(TmpFloat) + 'b +' +
      InternalTextFormat(RIadd) + 'b // TotalRI from NuclideState + RIf'
    else
     fValuesStr[2]:= '0' + InternalTextFormat(RIadd) + 'b // RI default=0 + RIf';
   end;
   // SigmaFast
   TmpFloat:= NuclideState.TotalSigmaFast; // fValuesStr[3]
   SigmaAdd:= 0;
   if ((fThZpA_s > 800000) and (fThZpA_s < 1010000)) then
   begin
    if (aDataModule <> nil) then // fValuesStr[3]+
    try
     SigmaAdd:= T_DataModuleOOB(aDataModule).GetSigmaFastFissionForThZpA_s(fThZpA_s);
    except
     SigmaAdd:= -2;
    end;
   end;
   if not (SigmaAdd > 0) then // GetSigmaFastFissionForThZpA_s returns -1 if failue
    SigmaAdd:= 0;
   if (SigmaAdd < 1.E-30) then
   begin
    if TmpFloat > 0 then
     fValuesStr[3]:= InternalTextFormat(TmpFloat) + 'b // TotalSigmaFast from NuclideState '
    else
     fValuesStr[3]:= '0 // SigmaFast default=0';
   end
   else
   begin // SigmaFast_F
    if TmpFloat > 0 then
     fValuesStr[3]:= InternalTextFormat(TmpFloat) + 'b +' +
      InternalTextFormat(SigmaAdd) + 'b // TotalSigmaFast from NuclideState + SigmaFastf'
    else
     fValuesStr[3]:= '0' + InternalTextFormat(SigmaAdd) + 'b // TotalSigmaFast default=0 + SigmaFastf';
   end;
   TmpFloat:= NuclideState.Captures.g_factor; // fValuesStr[4]
   if TmpFloat > 0 then
    fValuesStr[4]:= InternalTextFormat(TmpFloat) + ' // g_factor from NuclideState '
   else
    fValuesStr[4]:= '1 // g_factor default';
   fValuesStr[5]:= '// comment '; // fValuesStr[5]
   for I:= 0 to NuclideState.Decays.Count - 1 do
    if not (NuclideState.Decays[I].DecayType in [dtNone, dtQ]) then
    begin
     TmpFloat:= NuclideState.Decays[I].Branching; // fValuesStr[6...]
     if TmpFloat > 0 then
      fValuesStr.Add(InternalTextFormat(TmpFloat) + '%' +
       '  -' + DecayStr(NuclideState.Decays[I].DecayType) + ' // decay from NuclideState ');
    end;
   // SigmaF
   SigmaAdd:= NuclideState.SigmaF;
   if (SigmaAdd > 1.0E-30) then
   begin
    fValuesStr.Add('');
    fValuesStr[fValuesStr.Count - 1]:= InternalTextFormat(SigmaAdd) + 'b // SigmaF from NuclideState ';
   end;
   // RI_F
   RIadd:= NuclideState.RIf;
   if (RIadd > 1.0E-30) then
   begin
    fValuesStr.Add('');
    fValuesStr[fValuesStr.Count - 1]:= InternalTextFormat(RIadd) + 'b // RIf from NuclideState ';
   end;
   // FastFission Added
   if ((fThZpA_s > 800000) and (fThZpA_s < 1010000)) then
    if (aDataModule <> nil) then
    begin //aDataModule is T_DataModuleOOB
     try
      SigmaAdd:= T_DataModuleOOB(aDataModule).GetSigmaFastFissionForThZpA_s(fThZpA_s);
     except
      SigmaAdd:= -2;
     end;
     if (SigmaAdd > 1.0E-30) then
     begin
      fValuesStr.Add('');
      fValuesStr[fValuesStr.Count - 1]:= InternalTextFormat(SigmaAdd) + 'b // FastFissionSigma from DataModule ';
     end;
    end;
   // SpecialCases Added
   if (aDataModule <> nil) then //aDataModule is T_DataModuleOOB
   try
    if T_DataModuleOOB(aDataModule).ReadSpecialCaptureTotal(fThZpA_s, SigmaAdd, RIadd) then
    begin
     if SigmaAdd > 1E-33 then //(min 1e-32)
      fValuesStr[1]:= AddTwoStrings(fValuesStr[1], InternalTextFormat(SigmaAdd) + 'b // ThermalSpecialCasesSigma ');
     if RIadd > 1E-33 then
      fValuesStr[2]:= AddTwoStrings(fValuesStr[2], InternalTextFormat(RIadd) + 'b // ResonanceSpecialCasesRI ');
    end;
   except
    //  not T_DataModuleOOB
   end;
   // SpecialCases Added  End
  end;
 end;
end;

destructor TChainState.Destroy;
begin
 fValuesStr.Free;
 inherited;
end;

(*
procedure TChainState.GetChilds(const List: TChainStateList; const aNuclideList: TNuclideList=nil;
 const Transitions: TNuclideTransitions= [ntCapture, ntFission, ntDecay, ntThreshold]);
var
 I, K, L: integer;
 ChildList: TLongIntList;
 aChainState: TChainState;
 TheNuclideList: TNuclideList;
 TheDataModule: TDataModule;
begin
 TheDataModule:= fChain.fDataModule;
 List.Clear;
 if aNuclideList<>nil then
  TheNuclideList:= aNuclideList
 else if fChain<>nil then begin
  if fChain.fNuclideList<>nil then
   TheNuclideList:= fChain.fNuclideList
  else
   TheNuclideList:= nil;
 end
 else begin
  exit;
 end;
 if TheNuclideList<>nil then begin
  ChildList:= TLongIntList.Create;
  if TheNuclideList.FindChilds(TheDataModule, Self.fThZpA_s, Transitions, ChildList) then
   for I:= 0 to ChildList.Count-1 do begin
    TheNuclideList.FindThZpA_s(ChildList[I], K, L);
    aChainState:= TChainState.CreateFromNuclideState(Self.fChain, TheNuclideList[K].StateList[L]);
    TList(List).Add(aChainState);
   end;
 end;
end;
*)

function TChainState.GetDecayDecrease: float;
var
 IsLambda: Boolean;
 aStr, OutStr: string;
 aFloat: Float;
 I, CommentBegin: integer;
begin
 aStr:= fValuesStr[0];
 Result:= 0;
 try
  CommentBegin:= Pos('//', aStr); // To Test is a lambda or a time
  if CommentBegin > 0 then
   aStr:= Trim(Copy(aStr, 1, CommentBegin - 1));
  IsLambda:= True;
  for I:= 1 to Length(aStr) do
   if not (aStr[I] in ['0'..'9', '-', '+', 'e', 'E', '.', ',', #197, #229]) then
   begin // russian e E
    IsLambda:= False;
    break;
   end;
  if IsLambda then
  begin
   if PrepareToParse(aStr, OutStr) then
    Result:= GetFormulaValue(OutStr);
  end
  else
   (*
      if PrepareToParse(aStr, OutStr) then
       if TextT1_2ToNum(OutStr, aFloat) then
   *) if TextT1_2ToNum(aStr, aFloat) then
    if aFloat > 0 then
     Result:= Ln2 / aFloat
    else
     Result:= 0;
 except
  Result:= 0;
 end;
end;

function TChainState.GetFluxDecrease(ValuesStrNo: integer): float; // qq PrepareToParse tuned
var
 aStr, OutStr: string;
begin
 if not (ValuesStrNo in [1..3]) then
 begin
  MessageDlg('TChainState.GetFluxDecrease( UNKNOWN ValuesStrNo -- exit with ' + #13 + #10 + 'Result = 0', mtInformation, [mbOK], 0);
  Result:= 0;
  Exit;
 end;
 if (ValuesStrNo < fValuesStr.Count) then
  aStr:= fValuesStr[ValuesStrNo]
 else
 begin
  Result:= 0;
  Exit;
 end;
 try
  if PrepareToParse(aStr, OutStr) then
   Result:= GetFormulaValue(OutStr)
  else
   Result:= 0;
 except
  Result:= 0;
 end;
end;

function TChainState.GetFastDecrease: float;
begin
 Result:= GetFluxDecrease(3);
end;

function TChainState.GetResonanceDecrease: float;
begin
 Result:= GetFluxDecrease(2);
end;

function TChainState.GetStateName: string;
begin
 if fName <> '' then
  Result:= fName
 else
 begin
  Result:= ThZpAtoNuclideName(fThZpA_s div 10);
  if ((fThZpA_s mod 10) = 0) then
   Result:= Result + 'g'
  else if ((fThZpA_s mod 10) = 1) then
   Result:= Result + 'm1'
  else if ((fThZpA_s mod 10) = 2) then
   Result:= Result + 'm2'
  else
   Result:= Result + 'u'
 end;
end;

function TChainState.GetThermalDecrease: float;
begin
 Result:= GetFluxDecrease(1);
end;

function TChainState.SaveToFile(const FileName: string): Boolean;
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

function TChainState.LoadFromStream(aChain: TChain; Stream: TStream): Boolean;
var
 Buffer: PChar;
 List: TStringList;
 Txt: string;
 I: integer;
begin
 New(Buffer);
 List:= TStringList.Create;
 Txt:= '';
 try
  try
   with Stream do
    repeat
     Read(Buffer^, 1);
     Txt:= Txt + Buffer^;
    until ((Buffer^ in [EndStateChar]) or (Stream.Position + 1 > Stream.Size));
   with List, Self do
   begin
    List.Text:= Trim(Txt);
    fChain:= aChain;
    Txt:= '';
    fThZpA_s:= StrToInt(List[0]);
    fName:= List[1];
    for I:= 2 to List.Count - 1 do
     if (I - 2 <= fValuesStr.Count - 1) then
      fValuesStr[I - 2]:= List[I]
     else
      fValuesStr.Add(List[I]);
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

function TChainState.SaveToStream(Stream: TStream): Boolean;
var
 I: integer;
 aStr: string;
begin
 try
  aStr:= BeginStateChar + IntToStr(fThZpA_s) + EndOfLine;
  Stream.Write(Pointer(aStr)^, Length(aStr));
  aStr:= fName + EndOfLine;
  Stream.Write(Pointer(aStr)^, Length(aStr));
  for I:= 0 to fValuesStr.Count - 1 do
  begin
   aStr:= fValuesStr[I] + EndOfLine;
   Stream.Write(Pointer(aStr)^, Length(aStr));
  end;
  aStr:= EndStateChar + IntToStr(fThZpA_s) + ' end' + EndOfLine;
  Stream.Write(Pointer(aStr)^, Length(aStr));
  Result:= True
 except
  Result:= False;
 end;
end;

// qq PrepareToParse tuned

function TChainState.GetSigmaF(const SpectrumPart: integer): Float; // 0-thermal, 1-RI, 3-Fast
var
 J: integer;
 aStr, OutStr: string;
begin
 Result:= 0;
 for J:= 6 to fValuesStr.Count - 1 do
 begin
  aStr:= UpperCase(fValuesStr[J]);
  if (SpectrumPart = 0) then
  begin
   if ((Pos('SIGMAF', aStr) > 0) and (Pos('FAST', aStr) = 0)) then
   begin
    try
     if PrepareToParse(aStr, OutStr) then
      Result:= GetFormulaValue(OutStr)
     else
      Result:= 0;
    except
     Result:= 0;
    end;
    Exit;
   end;
  end
  else if (SpectrumPart = 1) then
  begin
   if ((Pos('RIF', aStr) > 0) and (Pos('FAST', aStr) = 0)) then
   begin
    try
     if PrepareToParse(aStr, OutStr) then
      Result:= GetFormulaValue(OutStr)
     else
      Result:= 0;
    except
     Result:= 0;
    end;
    Exit;
   end;
  end
  else if (SpectrumPart = 2) then
  begin
   if (Pos('FASTFISSIONSIGMA', aStr) > 0) then
   begin
    try
     if PrepareToParse(aStr, OutStr) then
      Result:= GetFormulaValue(OutStr)
     else
      Result:= 0;
    except
     Result:= 0;
    end;
    Exit;
   end;
  end
 end;
end;

function TChainState.GetDecayTypeValue(const aDT: TDecayType = dtNone): Float;
var
 J, CommentBegin, DecayStrPos: integer;
 aStr, OutStr, aDTstr: string;
 aLambda: Float;
 procedure HandleDecayStr; // to move try...except from FOR loop
 begin
  try
   DecayStrPos:= Pos(aDTstr, aStr); // 100%  -B- // decay from NuclideState
   aStr:= Copy(aStr, 1, DecayStrPos - 1);
   CommentBegin:= Pos('//', aStr);
   if CommentBegin > 0 then
    aStr:= Trim(Copy(aStr, 1, CommentBegin - 1));
   if PrepareToParse(aStr, OutStr) then
    Result:= aLambda * GetFormulaValue(OutStr) // Must be Lambda %
   else
    Result:= 0;
  except
   Result:= 0;
  end;
 end;

begin
 Result:= 0;
 aStr:= fValuesStr[0];
 try
  // Get Lambda
  aLambda:= GetDecayDecrease;
 except
  aLambda:= 0;
 end;
 if aDT = dtNone then
 begin
  Result:= aLambda;
  Exit;
 end;
 aDTstr:= '-' + UpperCase(DecayStr(aDT));
 for J:= 6 to fValuesStr.Count - 1 do
 begin
  aStr:= UpperCase(fValuesStr[J]);
  if ((Pos('DECAY', aStr) > 0) and (Pos(aDTstr, aStr) > 0)) then
  begin
   HandleDecayStr;
   break;
  end;
 end;
 (*
 constructor TChainState.CreateFromNuclideState(aChain: TChain;
 ...
    for i:= 0 to NuclideState.Decays.Count-1 do
     if not(NuclideState.Decays[I].DecayType in [dtNone, dtQ]) then begin
      TmpFloat:= NuclideState.Decays[I].Branching;// fValuesStr[6...]
      if TmpFloat>0 then
       fValuesStr.Add(InternalTextFormat(TmpFloat)+'%'+
        '  -'+DecayStr(NuclideState.Decays[I].DecayType)+' // decay from NuclideState ');
 *)
end;

function TChainState.GetG_Factor: float; // qq PrepareToParse tuned
var
 aStr, OutStr: string;
 I: integer;
begin
 aStr:= fValuesStr[4];
 for I:= 4 to fValuesStr.Count - 1 do
  if (Pos('G_FACTOR', UpperCase(fValuesStr[I])) > 0) then
  begin
   aStr:= fValuesStr[I];
   break;
  end;
 try
  if PrepareToParse(aStr, OutStr) then
   Result:= GetFormulaValue(OutStr)
  else
   Result:= 1;
 except
  Result:= 1;
 end;
end;

{ TChainLink }

constructor TChainLink.Create(aChain: TChain; const aStartState, aFinishState: integer);
begin
 inherited create;
 fChain:= aChain;
 fStartThZpA_s:= aStartState;
 fFinishThZpA_s:= aFinishState;
 fValuesStr:= TStringList.Create;
 fValuesStr.Add('//decay');
 fValuesStr.Add('//Thermal');
 fValuesStr.Add('//Resonance');
 fValuesStr.Add('//Fast');
 fValuesStr.Add('//g_factor');
 fValuesStr.Add('//Comment');
end;

function TChainLink.GetName: string;
begin
 Result:= GetStartName + '->' + GetFinishName;
end;

procedure TChainLinkList.SetChainLink(Index: integer;
 aChainLink: TChainLink);
begin
 Items[Index]:= aChainLink;
end;

destructor TChainLink.Destroy;
begin
 fValuesStr.Free;
 inherited;
end;

function TChainLink.GetFinishName: string;
var
 I: integer;
begin
 for I:= 0 to fChain.fStates.Count - 1 do
  if fChain.fStates[I].fThZpA_s = fFinishThZpA_s then
  begin
   Result:= fChain.fStates[I].Name;
   exit;
  end;
 Result:= ThZpA_sToStr(fFinishThZpA_s);
end;

function TChainLink.GetFinishState: TChainState;
var
 I: integer;
begin
 Result:= nil;
 if fChain <> nil then
  for I:= 0 to fChain.fStates.Count - 1 do
   if fChain.fStates[I].ThZpA_s = fFinishThZpA_s then
   begin
    Result:= fChain.fStates[I];
    break;
   end;
end;

function TChainLink.FindFinishStateChainNo: integer;
begin
 Result:= -1;
 if fChain <> nil then
  Result:= fChain.FindState(Self.fFinishThZpA_s);
end;

function TChainLink.GetFinishThZpA_s: integer;
begin
 Result:= fFinishThZpA_s
end;

function TChainLink.GetStartName: string;
var
 I: integer;
begin
 for I:= 0 to fChain.fStates.Count - 1 do
  if fChain.fStates[I].fThZpA_s = fStartThZpA_s then
  begin
   Result:= fChain.fStates[I].Name;
   exit;
  end;
 Result:= ThZpA_sToStr(fStartThZpA_s);
end;

function TChainLink.GetStartState: TChainState;
var
 I: integer;
begin
 Result:= nil;
 if fChain <> nil then
  for I:= 0 to fChain.fStates.Count - 1 do
   if fChain.fStates[I].ThZpA_s = fStartThZpA_s then
   begin
    Result:= fChain.fStates[I];
    break;
   end;
end;

function TChainLink.FindStartStateChainNo: integer;
begin
 Result:= -1;
 if fChain <> nil then
  Result:= fChain.FindState(Self.fStartThZpA_s);
end;

function TChainLink.GetStartThZpA_s: integer;
begin
 Result:= fStartThZpA_s
end;

function TChainLink.LoadFromStream(aChain: TChain; Stream: TStream): Boolean;
var
 Buffer: PChar;
 List: TStringList;
 Txt: string;
 I: integer;
begin
 New(Buffer);
 List:= TStringList.Create;
 Txt:= '';
 try
  try
   with Stream do
    repeat
     Read(Buffer^, 1);
     Txt:= Txt + Buffer^;
    until ((Buffer^ in [EndLinkChar]) or (Stream.Position + 1 > Stream.Size));
   with List, Self do
   begin
    fValuesStr.Clear;
    Text:= Txt;
    fChain:= aChain;
    Txt:= '';
    for I:= 2 to Length(List[0]) do
     Txt:= Txt + List[0][I];
    fStartThZpA_s:= StrToInt(Txt);
    fFinishThZpA_s:= StrToInt(List[1]);
    for I:= 2 to List.Count - 2 do
     fValuesStr.Add(List[I]);
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

function TChainLink.SaveToStream(Stream: TStream): Boolean;
var
 I: integer;
 aStr: string;
begin
 try
  aStr:= BeginLinkChar + IntToStr(fStartThZpA_s) + EndOfLine;
  Stream.Write(Pointer(aStr)^, Length(aStr));
  aStr:= IntToStr(fFinishThZpA_s) + EndOfLine;
  Stream.Write(Pointer(aStr)^, Length(aStr));
  for I:= 0 to fValuesStr.Count - 1 do
  begin
   aStr:= fValuesStr[I] + EndOfLine;
   Stream.Write(Pointer(aStr)^, Length(aStr));
  end;
  aStr:= EndLinkChar + IntToStr(fStartThZpA_s) + '->' + IntToStr(fFinishThZpA_s) + ' end' + EndOfLine;
  Stream.Write(Pointer(aStr)^, Length(aStr));
  Result:= True;
 except
  Result:= False;
 end;
end;

procedure TChainLinkList.Delete(Index: Integer);
begin
 MessageDlg('Use Chain.DeleteLink method !', mtWarning, [mbOK], 0);
end;

end.

