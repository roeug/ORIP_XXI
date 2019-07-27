unit EuLib;

interface

uses
 windows, classes, graphics, forms, comctrls, stdctrls, inifiles, grids;

type
 Float=Extended; //Double;
 TEuMemIniFile=class(TMemIniFile)
  function ReadFloat(const Section, Name: string; Default: Double): Double; override;
 end;
 
{TLongIntList class from mwPCharList.pas edited}
 
 PLongIntArray=^TLongIntArray;
 TLongIntArray=array[0..MaxInt div sizeof(LongInt)-1] of LongInt;
 
 
 TFloatList=class;
 TLongIntList=class(TObject)
 private
  FCapacity: Integer;
  FCount: Integer;
  FLongIntList: PLongIntArray;
 protected
  function GetItems(Index: Integer): LongInt;
  procedure SetCapacity(NewCapacity: Integer);
  procedure SetCount(NewCount: Integer);
  procedure SetItems(Index: Integer; Item: LongInt);
 public
  constructor Create;
  destructor Destroy; override;
  procedure Order(const InCrease: Boolean=True);
  function Add(Item: LongInt): Integer;
  function AddUniq(Item: LongInt): Integer;
  procedure Assign(const Src: TLongIntList);
  procedure Clear;
  procedure Delete(Index: Integer);
  procedure Exchange(Index1, Index2: Integer);
  function First: LongInt;
  function IndicesOf(anItem: LongInt; FoundPositions: TLongIntList): Boolean;
  function IndexOf(Item: LongInt): Integer;
  procedure Insert(Index: Integer; Item: LongInt);
  function Last: LongInt;
  procedure Move(CurIndex, NewIndex: Integer);
  function Remove(Item: LongInt): Integer;
  procedure OrderByFloatList(const Floats: TFloatList);
  procedure OrderSimilar(const anItem: LongInt);
  property Capacity: Integer read FCapacity write SetCapacity;
  property Count: Integer read FCount write SetCount;
  property Items[Index: Integer]: LongInt read GetItems write SetItems; default;
  property LongIntList: PLongIntArray read FLongIntList;
 end;

 PFloatArray=^TFloatArray;
 TFloatArray=array[0..MaxInt div sizeof(Float)-1] of Float;
 
 TFloatList=class(TObject)
 private
  FCapacity: Integer;
  FCount: Integer;
  FFloatList: PFloatArray;
 protected
  function GetItems(Index: Integer): Float;
  procedure SetCapacity(NewCapacity: Integer);
  procedure SetCount(NewCount: Integer);
  procedure SetItems(Index: Integer; Item: Float);
 public
  constructor Create;
  destructor Destroy; override;
  procedure Order(const InCrease: Boolean=True);
  function Add(Item: Float): Integer;
  procedure Assign(const Src: TFloatList);
  procedure Clear;
  procedure Delete(Index: Integer);
  procedure Exchange(Index1, Index2: Integer);
  function First: Float;
  function IndexOf(Item: Float): Integer;
  procedure Insert(Index: Integer; Item: Float);
  function Last: Float;
  procedure Move(CurIndex, NewIndex: Integer);
  function Remove(Item: Float): Integer;
  property Capacity: Integer read FCapacity write SetCapacity;
  property Count: Integer read FCount write SetCount;
  property Items[Index: Integer]: Float read GetItems write SetItems; default;
  property FloatList: PFloatArray read FFloatList;
 end;

{TEditList}
 TEditList=class(TList)
  function GetEdit(Index: integer): TEdit;
  procedure SetEdit(Index: integer; aEdit: TEdit);
  procedure Add(aEdit: TEdit);
  destructor Destroy; override;
  constructor Create;
  function FindInList(const Edit: TEdit): integer;
  property
   Edits[Index: integer]: TEdit read GetEdit write SetEdit; default;
 end;
 
{TButtonList}
 TButtonList=class(TList)
  function GetButton(Index: integer): TButton;
  procedure SetButton(Index: integer; aButton: TButton);
  procedure Add(aButton: TButton);
  destructor Destroy; override;
  constructor Create;
  function FindInList(const Button: TButton): integer;
  property
   Buttons[Index: integer]: TButton read GetButton write SetButton; default;
 end;

{TComboBoxList}
 TComboBoxList=class(TList)
  function GetComboBox(Index: integer): TComboBox;
  procedure SetComboBox(Index: integer; aComboBox: TComboBox);
  procedure Add(aComboBox: TComboBox);
  destructor Destroy; override;
  constructor Create;
  function FindInList(const ComboBox: TComboBox): integer;
  property
   ComboBoxs[Index: integer]: TComboBox read GetComboBox write SetComboBox; default;
 end;
//LIB
type
 TListManFunction=function(const List1, List2: TLongIntList; var VarList: TLongIntList): boolean;
function ListIntersect(const List1, List2: TLongIntList; var VarList: TLongIntList): boolean;
function ListUnion(const List1, List2: TLongIntList; var VarList: TLongIntList): boolean;
function ListEqual(const List1, List2: TLongIntList): boolean;
function ValEu(const InStr: string; var aFloat: float; const MsgStr: string=''): Boolean;
function ValEuSilent(const InStr: string; var aFloat: float): Boolean;
function IsSmallFonts: boolean; {Returns TRUE if small font}
function IsDelphiLoaded: Boolean;
function DuplicateComponents(
 AComponent: TComponent// original component
 ): TComponent; // returns created new component
function AreFloatsEqualAbs(const Float1, Float2: Float; const Eps: Float=1.E-5): boolean;
function AreFloatsEqualRel(const Float1, Float2: Float; const Eps: Float=1.E-5): boolean;
function PrepareToParse(const InStr: string; var OutStr: string): Boolean;
function AddTwoStrings(const Str1, Str2: string): string;
function ShellSortI(var v: array of integer): Boolean; // From Kernigan & Richi
// NOT tested
function ShellSortF(var v: array of float): Boolean; // 3.5 p.66 - InCrease
// NOT tested
function AddUniqToStrList(var aList: TStringList; const Str2Add: string): integer;
function SaveStringGridToStream(const aGrid: TStringGrid; Stream: TStream): boolean;
function LoadStringGridFromStream(var TheGrid: TStringGrid; Stream: TStream; OverwriteFixed: Boolean=True): boolean;
function IsWritableDir(const aDirIn: string): Boolean;
procedure EmptyMouseQueue;
function CopyToClipboardFromStringGrid(StringGrid: TStringGrid): Boolean;
function PasteFromClipboardToStringGrid(StringGrid: TStringGrid): Boolean;
function DeleteInStringGrid(StringGrid: TStringGrid): Boolean;
function CompareFloatStr(const Str1, Str2: string): Boolean;
function DecayPercentFormat(const aDecayPercent: Float): AnsiString; // 0-100
function EuMin(const aFloat1, aFloat2: Float): Float; overload;
function EuMin(const anInt1, anInt2: LongInt): LongInt; overload;

const
 Ln2: Float=0.6931471805599453;
 UndefinedVal: Float = 1.0e-32; // Float defined in Here

var
 InLongOperation: Boolean;
 StopLongOperation: Boolean;
 
implementation

uses
 Dialogs, SysUtils, Messages, Controls,
 Parsing,
 Clipbrd;

type
 TUniqueReader=class(TReader)
  LastRead: TComponent;
  procedure ComponentRead(Component: TComponent);
  procedure SetNameUnique(
   Reader: TReader;
   Component: TComponent;
   var Name: string
   );
 end;
 
procedure TUniqueReader.ComponentRead(
 Component: TComponent
 );
begin
 LastRead:= Component;
end;

procedure TUniqueReader.SetNameUnique(// sets the name of the read
//component to something like "Panel2" if "Panel1" already exists
 Reader: TReader;
 Component: TComponent; // component being read
 var Name: string// Name to use and modify
 );
var
 i: Integer;
 tempname: string;
begin
 i:= 0;
 tempname:= Name;
 while Component.Owner.FindComponent(Name)<>nil do begin
  Inc(i);
  Name:= Format('%s%d', [tempname, i]);
 end;
end;

function DuplicateComponents(
 AComponent: TComponent// original component
 ): TComponent; // returns created new component
 procedure RegisterComponentClasses(
  AComponent: TComponent);
 var
  i: integer;
 begin
  RegisterClass(TPersistentClass(AComponent.ClassType));
  if AComponent is TWinControl then
   if TWinControl(AComponent).ControlCount>0 then
    for i:= 0 to(TWinControl(AComponent).ControlCount-1) do
     RegisterComponentClasses(TWinControl(AComponent).Controls[i]);
 end;
 
var
 Stream: TMemoryStream;
 UniqueReader: TUniqueReader;
 Writer: TWriter;
begin
// result:=nil;
 UniqueReader:= nil;
 Writer:= nil;
 Stream:= TMemoryStream.Create;
 try
  RegisterComponentClasses(AComponent);
  try
   Writer:= TWriter.Create(Stream, 4096);
   Writer.Root:= AComponent.Owner;
   Writer.WriteSignature;
   Writer.WriteComponent(AComponent);
   Writer.WriteListEnd;
  finally
   Writer.Free;
  end;
  Stream.Position:= 0;
  try
   UniqueReader:= TUniqueReader.Create(Stream, 4096); // create reader
                        // should probably move these routines into theconstructor
   UniqueReader.OnSetName:= UniqueReader.SetNameUnique;
   UniqueReader.LastRead:= nil;
   if AComponent is TWinControl then
    UniqueReader.ReadComponents(
// read in components and sub-components
     TWinControl(AComponent).Owner,
     TWinControl(AComponent).Parent,
     UniqueReader.ComponentRead
     )
   else
    UniqueReader.ReadComponents(
// read in components
     AComponent.Owner,
     nil,
     UniqueReader.ComponentRead
     );
   result:= UniqueReader.LastRead;
  finally
   UniqueReader.Free;
  end;
 finally
  Stream.Free;
 end;
end;

{TEditList}

function TEditList.GetEdit(Index: integer): TEdit;
begin
 Result:= TEdit(Items[Index]);
end;

function TEditList.FindInList(const Edit: TEdit): integer;
var
 I: integer;
 Found: Boolean;
begin
 Result:= -1;
 Found:= False;
 for I:= 0 to(Count-1) do
  if (Self[I]=Edit) then begin
   Found:= True;
   break;
  end;
 if Found then Result:= I;
end;

procedure TEditList.SetEdit(Index: integer; aEdit: TEdit);
begin
 TEdit(Items[Index]).Free;
 Items[Index]:= Pointer(aEdit);
end;

procedure TEditList.Add(aEdit: TEdit);
begin
 inherited Add(aEdit);
end;

destructor TEditList.Destroy;
var
 I: integer;
begin
 for I:= 0 to(Count-1) do begin
  Self[I].Free;
  Self[I]:= nil;
 end;
 inherited Destroy;
end;

constructor TEditList.Create;
begin
 inherited Create;
end;

{TButtonList}

function TButtonList.GetButton(Index: integer): TButton;
begin
 Result:= TButton(Items[Index]);
end;

function TButtonList.FindInList(const Button: TButton): integer;
var
 I: integer;
 Found: Boolean;
begin
 Result:= -1;
 Found:= False;
 for I:= 0 to(Count-1) do
  if (Self[I]=Button) then begin
   Found:= True;
   break;
  end;
 if Found then Result:= I;
end;

procedure TButtonList.SetButton(Index: integer; aButton: TButton);
begin
 TButton(Items[Index]).Free;
 Items[Index]:= Pointer(aButton);
end;

procedure TButtonList.Add(aButton: TButton);
begin
 inherited Add(aButton);
end;

destructor TButtonList.Destroy;
var
 I: integer;
begin
 for I:= 0 to(Count-1) do begin
  Self[I].Free;
  Self[I]:= nil;
 end;
 inherited Destroy;
end;

constructor TButtonList.Create;
begin
 inherited Create;
end;

{TComboBoxList}

function TComboBoxList.GetComboBox(Index: integer): TComboBox;
begin
 Result:= TComboBox(Items[Index]);
end;

function TComboBoxList.FindInList(const ComboBox: TComboBox): integer;
var
 I: integer;
 Found: Boolean;
begin
 Result:= -1;
 Found:= False;
 for I:= 0 to(Count-1) do
  if (Self[I]=ComboBox) then begin
   Found:= True;
   break;
  end;
 if Found then
  Result:= I;
end;

procedure TComboBoxList.SetComboBox(Index: integer; aComboBox: TComboBox);
begin
 TComboBox(Items[Index]).Free;
 Items[Index]:= Pointer(aComboBox);
end;

procedure TComboBoxList.Add(aComboBox: TComboBox);
begin
 inherited Add(aComboBox);
end;

destructor TComboBoxList.Destroy;
var
 I: integer;
begin
 for I:= 0 to(Count-1) do begin
  Self[I].Free;
  Self[I]:= nil;
 end;
 inherited Destroy;
end;

constructor TComboBoxList.Create;
begin
 inherited Create;
end;

//LIB

function IsSmallFonts: boolean;
{ TRUE if small font}
var
 DC: HDC;
begin
 DC:= GetDC(0);
 Result:= (GetDeviceCaps(DC, LOGPIXELSX)=96);
  { In the case of big font 120}
 ReleaseDC(0, DC);
end;

function ValEu(const InStr: string; var aFloat: float; const MsgStr: string=''): Boolean;
var
 I: integer;
 NumStr, aStr: string;
begin
 NumStr:= Trim(Copy(InStr, 1, Length(InStr)));
 if Length(NumStr)>0 then
 try
  for I:= 1 to Length(NumStr) do
   if NumStr[I]=',' then
    NumStr[I]:= '.'
   else if (NumStr[I]='Å')or(NumStr[I]='å') then
    NumStr[I]:= 'E';
  Val(NumStr, aFloat, I);
  if I<>0 then begin
   if MsgStr='' then
    aStr:= 'ValEu error in position'
   else
    aStr:= MsgStr+' in position ';
   MessageDlg(aStr+IntToStr(I), mtWarning, [mbOk], 0);
   Result:= False;
  end
  else
   Result:= True;
 except
  Result:= False;
 end
 else
  Result:= False;
end; {ValEu}

function ValEuSilent(const InStr: string; var aFloat: float): Boolean;
var
 I: integer;
 NumStr: string;
begin
 NumStr:= Trim(Copy(InStr, 1, Length(InStr)));
 if Length(NumStr)>0 then
 try
  for I:= 1 to Length(NumStr) do
   if NumStr[I]=',' then
    NumStr[I]:= '.'
   else if (NumStr[I]='Å')or(NumStr[I]='å') then
    NumStr[I]:= 'E';
  Val(NumStr, aFloat, I);
  if I<>0 then begin
   Result:= False;
  end
  else
   Result:= True;
 except
  Result:= False;
 end
 else
  Result:= False;
end; {ValEuSilent}

function IsDelphiLoaded: Boolean;
begin
// Result:= FileExists('DEBUG.DEL');
 Result:= FindWindow('TAppBuilder', nil)>0;
end;

{TLongIntList }

procedure TLongIntList.OrderSimilar(const anItem: LongInt);
var
 I, J: integer;
begin
 if Self.Count<2 then
  Exit;
 for J:= 1 to(Self.Count-1) do begin
  I:= J;
  while (Abs(Self[I]-anItem)<Abs(Self[I-1]-anItem)) do begin
   Self.Exchange(I, I-1);
   if I=1 then break;
   Dec(I);
  end;
 end;
end;

procedure TLongIntList.OrderByFloatList(const Floats: TFloatList);
var
 I, J: integer;
begin
 if Self.Count<2 then
  Exit;
 if Self.Count=Floats.Count then
  for J:= 1 to(Self.Count-1) do begin
   I:= J;
   while (Floats[I]>Floats[I-1]) do begin
    Self.Exchange(I, I-1);
    Floats.Exchange(I, I-1);
    if I=1 then break;
    Dec(I);
   end;
  end;
end;

{TLongIntList constructor and destructor +++++++++++++++++++++++++++++++++++++}

constructor TLongIntList.Create;
begin
 inherited Create;
end; { Create }

destructor TLongIntList.Destroy;
begin
 Clear;
 inherited Destroy;
end; { Destroy }

{ TLongIntList protected ++++++++++++++++++++++++++++++++++++++++++++++++++++++}

function TLongIntList.GetItems(Index: Integer): LongInt;
begin
 Result:= FLongIntList[Index];
end; { GetItems }

procedure TLongIntList.SetCapacity(NewCapacity: Integer);
begin
 if NewCapacity<FCount then FCount:= NewCapacity;
 if NewCapacity<>FCapacity then
 begin
  ReallocMem(FLongIntList, NewCapacity*SizeOf(LongInt));
  FCapacity:= NewCapacity;
 end;
end; { SetCapacity }

procedure TLongIntList.SetCount(NewCount: Integer);
begin
 if NewCount>FCapacity then SetCapacity(NewCount);
 FCount:= NewCount;
end; { SetCount }

procedure TLongIntList.SetItems(Index: Integer; Item: LongInt);
begin
 FLongIntList[Index]:= Item;
end; { SetItems }

{ TLongIntList public +++++++++++++++++++++++++++++++++++++++++++++++++++++++++}

function TLongIntList.Add(Item: LongInt): Integer;
begin
 Result:= FCount;
 if Result+1>=FCapacity then SetCapacity(FCapacity+1024);
 FLongIntList[Result]:= Item;
 Inc(FCount);
end; { Add }

procedure TLongIntList.Assign(const Src: TLongIntList);
var
 I: integer;
begin
 if ((Self<>Src)and(Src<>nil)) then begin
  Self.Clear;
  for I:= 0 to Src.Count-1 do
   Self.Add(Src[I]);
 end;
end;

function TLongIntList.AddUniq(Item: Integer): Integer;
var
 I: integer;
 InList: Boolean;
begin
 Result:= -1;
 InList:= False;
 for I:= FCount-1 downto 0 do
  if Self[I]=Item then begin
   InList:= True;
   break;
  end;
 if not(InList) then
  Result:= Add(Item);
end;

procedure TLongIntList.Clear;
begin
 SetCount(0);
 SetCapacity(0);
end; { Clear }

procedure TLongIntList.Delete(Index: Integer);
begin
 Dec(FCount);
 if Index<FCount then
  System.Move(FLongIntList[Index+1], FLongIntList[Index],
   (FCount-Index)*SizeOf(LongInt));
end; { Delete }

procedure TLongIntList.Exchange(Index1, Index2: Integer);
var
 Item: LongInt;
begin
 Item:= FLongIntList[Index1];
 FLongIntList[Index1]:= FLongIntList[Index2];
 FLongIntList[Index2]:= Item;
end; { Exchange }

function TLongIntList.First: LongInt;
begin
 Result:= GetItems(0);
end; { First }

function TLongIntList.IndicesOf(anItem: LongInt; FoundPositions: TLongIntList): Boolean;
var
 I: integer;
begin
 try
  for I:= 0 to FCount do
   if FLongIntList[I]=anItem then
    FoundPositions.Add(I);
  Result:= True;
 except
  Result:= False;
 end;
end; { IndicesOf }

function TLongIntList.IndexOf(Item: LongInt): Integer;
begin
 Result:= 0;
 while (Result<FCount)and(FLongIntList[Result]<>Item) do Inc(Result);
 if Result=FCount then Result:= -1;
end; { IndexOf }

procedure TLongIntList.Insert(Index: Integer; Item: LongInt);
begin
 if FCount=FCapacity then SetCapacity(FCapacity+1024);
 if Index<FCount then
  System.Move(FLongIntList[Index], FLongIntList[Index+1],
   (FCount-Index)*SizeOf(LongInt));
 FLongIntList[Index]:= Item;
 Inc(FCount);
end; { Insert }

function TLongIntList.Last: LongInt;
begin
 Result:= GetItems(FCount-1);
end; { Last }

procedure TLongIntList.Move(CurIndex, NewIndex: Integer);
var
 Item: LongInt;
begin
 if CurIndex<>NewIndex then
 begin
  Item:= GetItems(CurIndex);
  Delete(CurIndex);
  Insert(NewIndex, Item);
 end;
end; { Move }

function TLongIntList.Remove(Item: LongInt): Integer;
begin
 Result:= IndexOf(Item);
 if Result<>-1 then Delete(Result);
end; { Remove }

procedure TLongIntList.Order(const InCrease: Boolean=True);
var
 I, J: integer;
begin
 if Count<2 then
  Exit;
 if InCrease then
  for J:= 1 to(Count-1) do begin
   I:= J;
   while (Items[I]<Items[I-1]) do begin
    Exchange(I, I-1);
    if I=1 then break;
    Dec(I);
   end;
  end
 else //Decrease
  for J:= 1 to(Count-1) do begin
   I:= J;
   while (Items[I]>Items[I-1]) do begin
    Exchange(I, I-1);
    if I=1 then break;
    Dec(I);
   end;
  end;
end;

{TFloatList }

{TFloatList constructor and destructor +++++++++++++++++++++++++++++++++++++}

constructor TFloatList.Create;
begin
 inherited Create;
end; { Create }

destructor TFloatList.Destroy;
begin
 Clear;
 inherited Destroy;
end; { Destroy }

{ TFloatList protected ++++++++++++++++++++++++++++++++++++++++++++++++++++++}

function TFloatList.GetItems(Index: Integer): Float;
begin
 Result:= FFloatList[Index];
end; { GetItems }

procedure TFloatList.SetCapacity(NewCapacity: Integer);
begin
 if NewCapacity<FCount then FCount:= NewCapacity;
 if NewCapacity<>FCapacity then
 begin
  ReallocMem(FFloatList, NewCapacity*SizeOf(Float));
  FCapacity:= NewCapacity;
 end;
end; { SetCapacity }

procedure TFloatList.SetCount(NewCount: Integer);
begin
 if NewCount>FCapacity then SetCapacity(NewCount);
 FCount:= NewCount;
end; { SetCount }

procedure TFloatList.SetItems(Index: Integer; Item: Float);
begin
 FFloatList[Index]:= Item;
end; { SetItems }

{ TFloatList public +++++++++++++++++++++++++++++++++++++++++++++++++++++++++}

function TFloatList.Add(Item: Float): Integer;
begin
 Result:= FCount;
 if Result+1>=FCapacity then SetCapacity(FCapacity+1024);
 FFloatList[Result]:= Item;
 Inc(FCount);
end; { Add }

procedure TFloatList.Assign(const Src: TFloatList);
var
 I: integer;
begin
 if ((Self<>Src)and(Src<>nil)) then begin
  Self.Clear;
  for I:= 0 to Src.Count-1 do
   Self.Add(Src[I]);
 end;
end;

procedure TFloatList.Clear;
begin
 SetCount(0);
 SetCapacity(0);
end; { Clear }

procedure TFloatList.Delete(Index: Integer);
begin
 Dec(FCount);
 if Index<FCount then
  System.Move(FFloatList[Index+1], FFloatList[Index],
   (FCount-Index)*SizeOf(Float));
end; { Delete }

procedure TFloatList.Exchange(Index1, Index2: Integer);
var
 Item: Float;
begin
 Item:= FFloatList[Index1];
 FFloatList[Index1]:= FFloatList[Index2];
 FFloatList[Index2]:= Item;
end; { Exchange }

function TFloatList.First: Float;
begin
 Result:= GetItems(0);
end; { First }

function TFloatList.IndexOf(Item: Float): Integer;
begin
 Result:= 0;
 while (Result<FCount)and(FFloatList[Result]<>Item) do Inc(Result);
 if Result=FCount then Result:= -1;
end; { IndexOf }

procedure TFloatList.Insert(Index: Integer; Item: Float);
begin
 if FCount=FCapacity then SetCapacity(FCapacity+1024);
 if Index<FCount then
  System.Move(FFloatList[Index], FFloatList[Index+1],
   (FCount-Index)*SizeOf(Float));
 FFloatList[Index]:= Item;
 Inc(FCount);
end; { Insert }

function TFloatList.Last: Float;
begin
 Result:= GetItems(FCount-1);
end; { Last }

procedure TFloatList.Move(CurIndex, NewIndex: Integer);
var
 Item: Float;
begin
 if CurIndex<>NewIndex then
 begin
  Item:= GetItems(CurIndex);
  Delete(CurIndex);
  Insert(NewIndex, Item);
 end;
end; { Move }

function TFloatList.Remove(Item: Float): Integer;
begin
 Result:= IndexOf(Item);
 if Result<>-1 then Delete(Result);
end; { Remove }

procedure TFloatList.Order(const InCrease: Boolean=True);
var
 I, J: integer;
begin
 if Count<2 then
  Exit;
 if InCrease then
  for J:= 1 to(Count-1) do begin
   I:= J;
   while (Items[I]<Items[I-1]) do begin
    Exchange(I, I-1);
    if I=1 then break;
    Dec(I);
   end;
  end
 else //Decrease
  for J:= 1 to(Count-1) do begin
   I:= J;
   while (Items[I]>Items[I-1]) do begin
    Exchange(I, I-1);
    if I=1 then break;
    Dec(I);
   end;
  end;
end;

function TEuMemIniFile.ReadFloat(const Section, Name: string; Default: Double): Double;
var
 FloatStr: string;
 I: integer;
begin
 FloatStr:= ReadString(Section, Name, '');
 Result:= Default;
 if FloatStr<>'' then
 try
  for I:= 1 to Length(FloatStr) do
   if (FloatStr[I]=',') then
    FloatStr[I]:= '.';
  Val(FloatStr, Result, I);
  if (I>0) then begin
   MessageDlg('Error TEuMemIniFile.ReadFloat converting to float: '+FloatStr, mtWarning, [mbOK], 0);
   Result:= -1;
  end;
 except
  on EConvertError do
 else raise;
 end;
end;

function ListIntersect(const List1, List2: TLongIntList; var VarList: TLongIntList): boolean;
var
 I: integer;
begin
 if (List1<>nil)and(List2<>nil)and(VarList<>nil) then begin
  try
   VarList.Clear;
   for I:= 0 to List1.Count-1 do
    if List2.IndexOf(List1[I])>=0 then begin
     VarList.AddUniq(List1[I]);
     continue;
    end;
   Result:= true;
  except
   Result:= False;
  end;
 end
 else
  Result:= False;
end;

function ListUnion(const List1, List2: TLongIntList; var VarList: TLongIntList): boolean;
var
 I: integer;
begin
 if (List1<>nil)and(List2<>nil)and(VarList<>nil) then begin
  try
   VarList.Clear;
   for I:= 0 to List1.Count-1 do
    VarList.AddUniq(List1[I]);
   for I:= 0 to List2.Count-1 do
    VarList.AddUniq(List2[I]);
   Result:= true;
  except
   Result:= False;
  end;
 end
 else
  Result:= False;
end;

function ListEqual(const List1, List2: TLongIntList): boolean;
var
 I: integer;
begin
 if List1.Count<>List2.Count then begin
  Result:= False;
  exit
 end
 else begin
  Result:= True;
  for I:= 0 to List1.Count-1 do
   if List1[I]<>List2[I] then begin
    Result:= False;
    exit
   end;
 end;
end;

function AreFloatsEqualAbs(const Float1, Float2: Float; const Eps: Float=1.E-5): boolean;
begin
 if Abs(Float1-Float2)<Eps then
  Result:= True
 else
  Result:= False;
end;

function AreFloatsEqualRel(const Float1, Float2: Float; const Eps: Float=1.E-5): boolean;
begin
 if (Abs(Float1)<Eps)or(Abs(Float2)<Eps) then begin
  if Abs(Float1-Float2)<Eps then
   Result:= True
  else
   Result:= False;
 end
 else begin
  if (Abs((Float1-Float2)/Float1)<Eps) then
   Result:= True
  else
   Result:= False
 end;
end;

function PrepareToParse(const InStr: string; var OutStr: string): Boolean;
var
 I: integer;
 aStr: string;
 DefaultValue: float;
begin
 OutStr:= Trim(InStr);
 DefaultValue:= 0.0;
 if Pos('G-FACTOR', UpperCase(InStr))>0 then
  DefaultValue:= 1.0;
 try
  I:= Pos('//', OutStr);
  if I>=1 then
   OutStr:= Trim(Copy(InStr, 1, I-1));
  for I:= 1 to Length(OutStr) do
   if ((OutStr[I]=',')or(OutStr[I]=',')) then
    OutStr[I]:= '.'
   else if ((OutStr[I]='å')or(OutStr[I]='Å')) then
    OutStr[I]:= 'e';
// Internal Trim
  OutStr:= UpperCase(OutStr);
  while Pos(' ', OutStr)>0 do begin
   I:= Pos(' ', OutStr);
   aStr:= Copy(OutStr, 1, I-1)+Copy(OutStr, I+1, Length(OutStr));
   OutStr:= aStr;
  end;
// %,b
  while Pos('%', OutStr)>0 do begin
   I:= Pos('%', OutStr);
   aStr:= Copy(OutStr, 1, I-1)+'/100'+Copy(OutStr, I+1, Length(OutStr));
   OutStr:= aStr;
  end;
  while Pos('BARNS', OutStr)>0 do begin
   I:= Pos('BARNS', OutStr);
   aStr:= Copy(OutStr, 1, I-1)+'*1e-24'+Copy(OutStr, I+5, Length(OutStr));
   OutStr:= aStr;
  end;
  while Pos('BARN', OutStr)>0 do begin
   I:= Pos('BARN', OutStr);
   aStr:= Copy(OutStr, 1, I-1)+'*1e-24'+Copy(OutStr, I+4, Length(OutStr));
   OutStr:= aStr;
  end;
  while Pos('B', OutStr)>0 do begin
   I:= Pos('B', OutStr);
   aStr:= Copy(OutStr, 1, I-1)+'*1e-24'+Copy(OutStr, I+1, Length(OutStr));
   OutStr:= aStr;
  end;
  if (Trim(OutStr)='') then
   OutStr:= FloatToStr(DefaultValue);
  GetFormulaValue(OutStr);
  Result:= True;
 except
  Result:= False;
 end;
end;

function AddTwoStrings(const Str1, Str2: string): string;
// formulas-plus, comments-Add
var
 I: integer;
 Formula1, Formula2, Comment1, Comment2: string;
begin
 I:= Pos('//', Str1);
 if I>2 then begin
  Formula1:= Copy(Str1, 1, I-1);
  Comment1:= Copy(Str1, I, Length(Str1)-I);
 end
 else if I=1 then begin
  Formula1:= '';
  Comment1:= Copy(Str1, 1, Length(Str1));
 end
 else begin
  Formula1:= '';
  Comment1:= '';
 end;
 Formula1:= Trim(Formula1);
 Comment1:= Trim(Comment1);
 I:= Pos('//', Str2);
 if I>2 then begin
  Formula2:= Copy(Str2, 1, I-1);
  Comment2:= Copy(Str2, I, Length(Str2)-I);
 end
 else if I=1 then begin
  Formula2:= '';
  Comment2:= Copy(Str2, 1, Length(Str2));
 end
 else begin
  Formula2:= '';
  Comment2:= '';
 end;
 Formula2:= Trim(Formula2);
 Comment2:= Trim(Comment2);
 if ((Trim(Formula1)='')and(Trim(Comment1)='')) then
  Result:= Str2
 else if ((Trim(Formula2)='')and(Trim(Comment2)='')) then
  Result:= Str1
 else if ((Trim(Formula1)='')and(Trim(Comment1)<>'')) then
  Result:= Formula2+' '+Comment2+'!!'+Comment1+'- no formula'
 else if ((Trim(Formula2)='')and(Trim(Comment2)<>'')) then
  Result:= Formula1+' '+Comment1+'!!'+Comment2+'- no formula'
 else
  Result:= Formula1+'+'+Formula2+' '+Comment1+'+'+Comment2;
end;

function ShellSortI(var v: array of integer): Boolean;
// NOT tested
var
 gap, i, j, temp, n: integer;
begin
 try
  n:= High(v)-Low(v)+1;
  gap:= n div 2;
  while (gap>0) do begin
   i:= Low(v)+gap;
   while (i<Low(v)+n) do begin
    j:= i-gap;
    while ((j>=Low(v))and(v[j]>v[j+gap])) do begin
     temp:= v[j];
     v[j]:= v[j+gap];
     v[j+gap]:= temp;
     j:= j-gap;
    end;
    Inc(i);
   end;
   gap:= gap div 2;
  end;
  Result:= True;
 except
  Result:= False;
 end;
end;

function ShellSortF(var v: array of float): Boolean;
// NOT tested
var
 gap, i, j, n: integer;
 temp: Float;
begin
 try
  n:= High(v)-Low(v)+1;
  gap:= n div 2;
  while (gap>0) do begin
   i:= Low(v)+gap;
   while (i<Low(v)+n) do begin
    j:= i-gap;
    while ((j>=Low(v))and(v[j]>v[j+gap])) do begin
     temp:= v[j];
     v[j]:= v[j+gap];
     v[j+gap]:= temp;
     j:= j-gap;
    end;
    Inc(i);
   end;
   gap:= gap div 2;
  end;
  Result:= True;
 except
  Result:= False;
 end;
end;

function AddUniqToStrList(var aList: TStringList; const Str2Add: string): integer;
var
 I: integer;
begin
 for I:= 0 to aList.Count-1 do
  if (Trim(aList[I])=Trim(Str2Add)) then begin
   Result:= -1;
   Exit;
  end;
 Result:= aList.Add(Trim(Str2Add));
end;

function SaveStringGridToStream(const aGrid: TStringGrid; Stream: TStream): boolean;
var
 I, J: integer;
 Txt: string;
begin
 try
  Stream.WriteBuffer(Longint(aGrid.ColCount), SizeOf(Longint));
  Stream.WriteBuffer(Longint(aGrid.RowCount), SizeOf(Longint));
  for I:= 0 to aGrid.ColCount-1 do
   for J:= 0 to aGrid.RowCount-1 do begin
    Txt:= aGrid.Cells[I, J];
    Stream.Write(Pointer(Txt)^, Length(Txt));
    Txt:= #0;
    Stream.Write(Pointer(Txt)^, 1);
   end;
  Result:= True;
 finally
 end;
end;

function LoadStringGridFromStream(var TheGrid: TStringGrid; Stream: TStream; OverwriteFixed: Boolean=True): boolean;
var
 aGrid: TStringGrid;
 I, J, aI, aJ, Int: integer;
 Txt: string;
 Buffer: PChar;
begin
 InLongOperation:= True;
 StopLongOperation:= False;
 Result:= False;
 aGrid:= TStringGrid.Create(nil);
 New(Buffer);
 try
  Stream.ReadBuffer(Int, SizeOf(Longint));
  aGrid.ColCount:= Int;
  Stream.ReadBuffer(Int, SizeOf(Longint));
  aGrid.RowCount:= Int;
  try
   for I:= 0 to aGrid.ColCount-1 do begin
    for J:= 0 to aGrid.RowCount-1 do begin
     Txt:= '';
     repeat
      Application.ProcessMessages;
      if StopLongOperation then
       Exit;
      Stream.ReadBuffer(Buffer^, 1);
      Txt:= Txt+Buffer^;
     until ((Buffer^in [#0])or(Stream.Position+1>Stream.Size));
     aGrid.Cells[I, J]:= Trim(Txt);
     if (Stream.Position+1>Stream.Size) then
      break;
    end;
    if (Stream.Position+1>Stream.Size) then
     break;
   end;
   Result:= True;
  except
   Result:= False;
   Exit;
  end;
  if not(OverwriteFixed) then
  begin
   if ((TheGrid.FixedCols=1)and(TheGrid.FixedRows=1)) then begin
    for I:= 1 to TheGrid.RowCount-1 do
     for J:= 1 to TheGrid.ColCount-1 do
      for aI:= 1 to aGrid.RowCount-1 do
       for aJ:= 1 to aGrid.ColCount-1 do begin
        Application.ProcessMessages;
        if StopLongOperation then
         Exit;
        if ((TheGrid.Cells[0, I]=aGrid.Cells[0, aI])and
         (TheGrid.Cells[J, 0]=aGrid.Cells[aJ, 0])) then
         TheGrid.Cells[J, I]:= aGrid.Cells[aJ, aI];
        Application.ProcessMessages;
       end;
   end
   else if ((TheGrid.FixedCols=1)and(TheGrid.FixedRows=0)) then begin
    for I:= 0 to TheGrid.RowCount-1 do
     for J:= 1 to TheGrid.ColCount-1 do
      for aI:= 0 to aGrid.RowCount-1 do
       for aJ:= 1 to aGrid.ColCount-1 do begin
        Application.ProcessMessages;
        if StopLongOperation then
         Exit;
        if ((TheGrid.Cells[0, I]=aGrid.Cells[0, aI])) then
         TheGrid.Cells[J, I]:= aGrid.Cells[aJ, aI];
        Application.ProcessMessages;
       end;
   end;
  end
  else
   TheGrid.Assign(aGrid);
 finally
  aGrid.Free;
  InLongOperation:= False;
  Dispose(Buffer);
 end;
end;

function IsWritableDir(const aDirIn: string): Boolean;
const
 FileName='TMP_del.tmp';
var
 FileCreateResult: integer;
 FullFileName: string;
 aDir: string;
begin
 try
  aDir:= Trim(aDirIn);
  if (aDirIn[Length(aDirIn)]<>'\') then
   aDir:= aDir+'\';
  FullFileName:= aDir+FileName;
  FileCreateResult:= FileCreate(FullFileName);
  if FileCreateResult>0 then begin
   FileClose(FileCreateResult);
   DeleteFile(FullFileName);
   Result:= True;
  end
  else
   Result:= False;
 except
  Result:= False;
 end;
end;

procedure EmptyMouseQueue;
var
 Msg: TMsg;
begin
 while PeekMessage(Msg, 0, WM_MOUSEFIRST, WM_MOUSELAST,
  PM_REMOVE or PM_NOYIELD) do
  ;
end;

// Simple Del
// else if ((Shift= [])and(Key=VK_DELETE)) then begin

function DeleteInStringGrid(StringGrid: TStringGrid): Boolean;
var
 aCol, aRow, Col1, Col2, Row1, Row2: integer;
 aSelection: TGridRect;
begin
 Result:= True;
 if goEditing in StringGrid.Options then
  if not(StringGrid.EditorMode) then
  try
   aSelection:= StringGrid.Selection;
   Col1:= aSelection.Left;
   Col2:= aSelection.Right;
   Row1:= aSelection.Top;
   Row2:= aSelection.Bottom;
   for aRow:= Row1 to Row2 do begin
    for aCol:= Col1 to Col2 do
     StringGrid.Cells[aCol, aRow]:= '';
   end;
  except
   Result:= False;
  end;
end;

// Shift+Ins or Ctrl+V
(*
 else if (not(ssAlt in Shift)and
  (((ssShift in Shift)and(Key = VK_INSERT))or
  ((ssCtrl in Shift)and(Key =Ord('V'))))) then begin
  PasteFromClipboardToStringGrid( StringGridStateLink);
 end
*)

function PasteFromClipboardToStringGrid(StringGrid: TStringGrid): Boolean;
const
 Delim=#9;
var
 Lines: TStringList;
 aStr, aStr1: string;
 I, DelPos, aCol, aRow, Col1, Col2, Row1, Row2: integer;
 aSelection: TGridRect;
begin
 Result:= True;
 aStr:= Clipboard.AsText;
 if goEditing in StringGrid.Options then
  if not(StringGrid.EditorMode) then
   if (aStr<>'') then
   try
    Lines:= TStringList.Create;
    aSelection:= StringGrid.Selection;
    Col1:= aSelection.Left;
    if aSelection.Left=aSelection.Right then
     Col2:= StringGrid.ColCount-1
    else
     Col2:= aSelection.Right;
    Row1:= aSelection.Top;
    if aSelection.Top=aSelection.Bottom then
     Row2:= StringGrid.RowCount-1
    else
     Row2:= aSelection.Bottom;
    try
     Lines.Text:= aStr;
     aRow:= Row1;
     for I:= 0 to Lines.Count-1 do begin
      aCol:= Col1;
      aStr:= Lines[I];
      DelPos:= Pos(Delim, aStr);
      if DelPos>0 then begin
       while ((DelPos>0)and(aCol<=Col2)) do begin
        aStr1:= Copy(aStr, 1, DelPos-1);
        StringGrid.Cells[aCol, aRow]:= aStr1;
        aStr:= Copy(aStr, DelPos+1, Length(aStr));
        DelPos:= Pos(Delim, aStr);
        Inc(aCol);
       end;
       if ((DelPos=0)and(aCol<=Col2)) then
        StringGrid.Cells[aCol, aRow]:= aStr;
      end
      else begin
       StringGrid.Cells[aCol, aRow]:= aStr;
      end;
      Inc(aRow);
      if aRow>Row2 then
       break;
     end;
    finally
     Lines.Free;
    end;
   except
    Result:= False;
   end;
end;

// Ctrl+Ins or Ctrl+C
(*
 else if (not(ssAlt in Shift)and
  (ssCtrl in Shift)and(Key = VK_INSERT)or(Key =Ord('C'))) then begin
  CopyToClipboardFromStringGrid( StringGridStateLink);
 end
*)

function CopyToClipboardFromStringGrid(StringGrid: TStringGrid): Boolean;
const
 Delim=#9;
var
 Lines: TStringList;
 aStr: string;
 aCol, aRow, Col1, Col2, Row1, Row2: integer;
 aSelection: TGridRect;
begin
 Result:= True;
 if not(StringGrid.EditorMode) then
 try
  Lines:= TStringList.Create;
  aSelection:= StringGrid.Selection;
  Col1:= aSelection.Left;
  if aSelection.Left=aSelection.Right then
   Col2:= Col1
  else
   Col2:= aSelection.Right;
  Row1:= aSelection.Top;
  if aSelection.Top=aSelection.Bottom then
   Row2:= Row1
  else
   Row2:= aSelection.Bottom;
  try
   for aRow:= Row1 to Row2 do begin
    aCol:= Col1;
    aStr:= StringGrid.Cells[aCol, aRow];
    for aCol:= Col1+1 to Col2 do
     aStr:= aStr+#9+StringGrid.Cells[aCol, aRow];
    Lines.Add(aStr);
   end;
   Clipboard.AsText:= Lines.Text;
  finally
   Lines.Free;
  end;
 except
  Result:= False;
 end;
end;

function CompareFloatStr(const Str1, Str2: string): Boolean;
var
 aF1, aF2: Float;
begin
 if not(ValEuSilent(Str1, aF1)) then
  aF1:= 0;
 if not(ValEuSilent(Str2, aF2)) then
  aF2:= 0;
 Result:= aF1>aF2;
end;

function DecayPercentFormat(const aDecayPercent: Float): AnsiString; // 0-100
begin
 result := Trim(Format('%-5.3g', [aDecayPercent]));
end;

function EuMin(const aFloat1, aFloat2: Float): Float;
begin
 if aFloat1<aFloat2 then
  Result:= aFloat1
 else
  Result:= aFloat2;
end;

function EuMin(const anInt1, anInt2: LongInt): LongInt;
begin
 if anInt1<anInt2 then
  Result:= anInt1
 else
  Result:= anInt2;
end;


end.

