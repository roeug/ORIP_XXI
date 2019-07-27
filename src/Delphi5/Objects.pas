
/////////////////////////////////////////////////
//                                             //
//   Objects 4.17        ( general release )   //
//                                             //
//   Data storing and processing classes       //
//                                             //
//   Copyright (c) 2000, Andrew N. Driazgov    //
//   e-mail: andrey@asp.tstu.ru                //
//                                             //
//   Last updated: November 15, 2000           //
//                                             //
/////////////////////////////////////////////////

unit Objects;

interface

uses Windows, SysUtils, Classes, QStrings;

const

{ Base constant for ID user objects. This objects indicators must be obtained
 by adding some positive constant to stConst
}

  stConst = 1000;
{ Constants for registering of standart types. Theese types are registered
 in initialization section of this unit
}

  rg01_TVCollection        = 50;
  rg01_TVStringCollection  = 51;
  rg01_TVMarks             = stConst-20;
  rg01_TVUniNumberObj      = stConst-21;
  rg01_TVUniNumberColl     = stConst-22;
  rg01_TVUniNameObj        = stConst-23;
  rg01_TVUniNameColl       = stConst-24;
  rg01_TVIntegerSet        = stConst-25;
  rg01_TVWordSet           = stConst-26;
  rg01_TVRandomGenerator   = stConst-27;
  rg01_TVApNumberObj       = stConst-1;
  rg01_TVApNumberColl      = stConst-2;
  rg01_TVApSortNumberColl  = stConst-3;
  rg01_TVApNameObj         = stConst-4;
  rg01_TVApNameColl        = stConst-5;
  rg01_TVApSortNameColl    = stConst-6;

{ Max number of elements in usual (big) collection }

  MaxCollectionSize = 536870896;

{ Max number of labels in TVMarks object}

  MaxTVMarkCount = 536870896;

{ Max number of elements in collection compatible with Turbo Vision }

  MaxTVCompatibleCollSize = 16380;

{ Consnt to be used as second argument of function TVStream.Seek }

  soFromBeginning  = 0;  // Positioning respect to the begin of file
  soFromCurrent    = 1;  // Positioning respect to the current position
  soFromEnd        = 2;  // Positioning respect to the end of file

{ File blocking regims}

  lkShareExclusive = $0010;  // File hot accessible for othe users
  lkShareDenyWrite = $0020;  // File could be open read only
  lkShareDenyRead  = $0030;  // File could beopen write only
  lkShareDenyNone  = $0040;  // File could be read and written

{ File open regims }

  fmOpenReadOnly = fmOpenRead or lkShareDenyNone;         // Open to read only
// QQ  fmOpenExclusive for ReadOnly now
  fmOpenExclusive = fmOpenRead or lkShareExclusive;  // Open in exclusive access
// QQ was
// fmOpenExclusive = fmOpenReadWrite or lkShareExclusive;  // Open in exclusive access

  fmCreate = $FFFF; // Work with just created file (exclusive access)

{ Values, returned by function Load/Save(...)Object, Open(...) }

  lsSuccess =  0;  // No errors
  lsAborted = -1;  // File is blocked, "cancel operation" command was chosen
  lsIgnored = -2;  // File is blocked, "ignore error" command was chosen

  lsNewResourceCreated = 1; // New depository or resource is created

{ Default argument for function TVStream.CopyFrom }

  cfCopyAllData = -1; // Copy all date

{ Constants for margins including in search }

  rtInclude   = 0;  // Margin is included
  rtExclude   = 1;  // Margin is not included
  rtInfinite  = 2;  // Margin is not checked

{ Standart index of TVCollection }

  StdIndex = 'Internal';

{ Index names in collections of types UniColl and ApColl }

  IndexBy_Number = 'Number';
  IndexBy_Name = 'Name';

{ Index types for the key searches }

  itNone        = $00;  // Nonstandart search
  itShortint    = $01;
  itByte        = $02;
  itSmallint    = $03;
  itWord        = $04;
  itInteger     = $05;
  itCardinal    = $06;
  itPointer     = $07;  // Compared as LongWord
  itInt64       = $08;
  itCurrency    = $09;
  itTDateTime   = $0A;
  itSingle      = $0B;
  itDouble      = $0C;
  itExtended    = $0D;
  itComp        = $0E;
  itString      = $0F;  // Case sensitive
  itPChar       = $10;  // Case sensitive
  itString_I    = $20;  // Case Insensitive
  itPChar_I     = $30;  // Case Insensitive
  itUserCmp     = $40;  // Comapison function is user-defined

{ Variable TVProtection.Validation meanings}

  pvNone   = $0000;
  pvCRC32  = $0001;
  pvSHA1   = $0002;

{ Variable  TVProtection.Encryption meanings}

  peNone      = $0000;
  peRC4       = $0001;
  peRC6_RC4   = $0009;  // Key - RC6(CBC), data - RC4
  peCAST6_RC4 = $0011;  // Key - CAST-256(CBC), data - RC4
  peRC6       = $0002;  // CFB
  peCAST6     = $0004;  // CFB

type
  TVUniCollection = class;
  TVStream = class;
{
Base class TVObject. Includes object "version". Every object must can
load (with constructor Load) any of its versions. Method Store saves only one
version, which was registered (RegisterTVObject) as saveable. Method Clone
creates the object instance copy (this metod must be overlaped in any descendants
of TVObject, where new fields were added. See for instance  TVUniNameObj.Clone
}

  TVObject = class(TObject)
  public
    constructor Create; virtual;
    constructor Load(S: TVStream; Version: Word); virtual;
    procedure Store(S: TVStream); virtual;
    function Clone: Pointer; virtual; // Object cloning
  end;

  TVObjectClassType = class of TVObject;

  PTVItemList = ^TVItemList;
  TVItemList = array[0..MaxCollectionSize - 1] of Pointer;
{ Prototype of the function which compares two records.
Return value must be below zero if the first record is smaller than the second one,
above zero if the first record is grater than the second one,
zero if the first record is equal to the second one,
}


  TVCollSortCompare = function (Item1, Item2: Pointer): Integer;

{ TVIndexCollection }

  TV_KeyOf_Shortint  = function(Item: Pointer): Shortint;
  TV_KeyOf_Byte      = function(Item: Pointer): Byte;
  TV_KeyOf_Smallint  = function(Item: Pointer): Smallint;
  TV_KeyOf_Word      = function(Item: Pointer): Word;
  TV_KeyOf_Integer   = function(Item: Pointer): Integer;
  TV_KeyOf_Cardinal  = function(Item: Pointer): Cardinal;
  TV_KeyOf_Pointer   = function(Item: Pointer): Pointer;
  TV_KeyOf_Int64     = function(Item: Pointer): Int64;
  TV_KeyOf_Currency  = function(Item: Pointer): Currency;
  TV_KeyOf_TDateTime = function(Item: Pointer): TDateTime;
  TV_KeyOf_Single    = function(Item: Pointer): Single;
  TV_KeyOf_Double    = function(Item: Pointer): Double;
  TV_KeyOf_Extended  = function(Item: Pointer): Extended;
  TV_KeyOf_Comp      = function(Item: Pointer): Comp;
  TV_KeyOf_String    = function(Item: Pointer): string;
  TV_KeyOf_PChar     = function(Item: Pointer): PChar;
  TV_KeyOf_String_I  = function(Item: Pointer): string;
  TV_KeyOf_PChar_I   = function(Item: Pointer): PChar;

  TV_UserKeyCompare  = function(Item, Key: Pointer): Integer;
  // User function which confront record to the key (sopostavlyaet zapisj kljuchu)
  // Return value is analogues to TVCollSortCompare.

  PTVIndexRec = ^TVIndexRec;
  TVIndexRec = record
    IndName: string;                // Index name
    IndList: PTVItemList;           // Array of pointers to records (DO NOT CHANGE MANNUALY)
    IndCompare: TVCollSortCompare;  // Function to compare two records
    Active: Boolean;                // Active index
    Regular: Boolean;               // Index is regular (uporjadochennyi)
    Descending: Boolean;            // Descending index
    Unique: Boolean;                // Unique index
    case IndType: Integer of        // Key value type (for record search)
      itShortint:  (KeyOf_Shortint:  TV_KeyOf_Shortint); // Function, wich returns
      itByte:      (KeyOf_Byte:      TV_KeyOf_Byte);     // key value for
      itSmallint:  (KeyOf_Smallint:  TV_KeyOf_Smallint); // the record
      itWord:      (KeyOf_Word:      TV_KeyOf_Word);
      itInteger:   (KeyOf_Integer:   TV_KeyOf_Integer);
      itCardinal:  (KeyOf_Cardinal:  TV_KeyOf_Cardinal);
      itPointer:   (KeyOf_Pointer:   TV_KeyOf_Pointer);
      itInt64:     (KeyOf_Int64:     TV_KeyOf_Int64);
      itCurrency:  (KeyOf_Currency:  TV_KeyOf_Currency);
      itTDateTime: (KeyOf_TDateTime: TV_KeyOf_TDateTime);
      itSingle:    (KeyOf_Single:    TV_KeyOf_Single);
      itDouble:    (KeyOf_Double:    TV_KeyOf_Double);
      itExtended:  (KeyOf_Extended:  TV_KeyOf_Extended);
      itComp:      (KeyOf_Comp:      TV_KeyOf_Comp);
      itString:    (KeyOf_String:    TV_KeyOf_String);
      itPChar:     (KeyOf_PChar:     TV_KeyOf_PChar);
      itString_I:  (KeyOf_String_I:  TV_KeyOf_String_I);
      itPChar_I:   (KeyOf_PChar_I:   TV_KeyOf_PChar_I);
      itUserCmp:   (UserKeyCompare:  TV_UserKeyCompare);
  end;

  PTVIndexList = ^TVIndexList;
  TVIndexList = array[0..MaxCollectionSize - 1] of PTVIndexRec;

  TVIndexCollection = class(TObject)
  private
    FList: PTVIndexList;
    FCount: Integer;
    FCapacity: Integer;
  public
    destructor Destroy; override;
    procedure Add(PIR: PTVIndexRec);
    procedure DeleteAndFree(PIR: PTVIndexRec);
    function Find(const S: string): PTVIndexRec;
  end;
{ Base class TVUniCollection (instances of this class is not to be created !!!)
 Any collection descendant from TVUniCollection can have many indexes
 Indexes are not saved on HDD, but rebuilded during collection loading.
 Any index could be active, inactive or current.
 Inactive index is not updated during inserting, deleting or changing of records.
 Thus it does not allocate memory.
 Active index is refreshed during collection loading,inserting, deleting or changing of records.
 When user changes some field of a record (collection member) he calls method
 UpdateIndexes. This method updates all active indexes. One of active indexes
 is the current index (it may be changed with the property CurrIndex. Current index
 defines default collection sorting. In acording to this sorting the records
 could be returned  with properties Items and List. With the current index
 methods Add, Delete, DeleteObj, IndexOf,
  First, Last, Insert, Exchange, Move, Sort work.
}

  TVAskForInsertEvent = procedure(AColl: TVUniCollection; Item: Pointer;
    var CanInsert: Boolean) of object;

  TVInsertItemEvent = procedure(AColl: TVUniCollection;
    Item: Pointer) of object;

  TVAskForDeleteEvent = procedure(AColl: TVUniCollection; Item: Pointer;
    var CanDelete, DeleteToBin: Boolean) of object;

  TVDeleteItemEvent = procedure(AColl: TVUniCollection;
    Item: Pointer) of object;

  TVSetChangedEvent = procedure(AColl: TVUniCollection;
    Value: Boolean) of object;

  TVUniCollection = class(TVObject)
  private
    FList: PTVItemList;
    FCount: Integer;
    FCapacity: Integer;
    FIndexes: TVIndexCollection;
    FCurrentIndex: PTVIndexRec;
    FBin: TVUniCollection;
    FOwner: TVUniCollection;
    FOnAskForInsert: TVAskForInsertEvent;
    FOnInsertItem: TVInsertItemEvent;
    FOnAskForDelete: TVAskForDeleteEvent;
    FOnDeleteItem: TVDeleteItemEvent;
    FOnSetChanged: TVSetChangedEvent;
    FFreeIOD: Boolean;
    FBig: Boolean;
    FChanged: Boolean;

    function AddToIndex(PIR: PTVIndexRec; Item: Pointer): Integer;
    procedure DeleteFromIndex(PIR: PTVIndexRec; Item: Pointer);
    procedure SetCurrIndex(PIR: PTVIndexRec);
    procedure SetChanged(Value: Boolean);

  protected
    function Get(Index: Integer): Pointer;
    procedure SetCapacity(NewCapacity: Integer);
    procedure Grow;

    procedure DoAskForInsert(Item: Pointer; var CanInsert: Boolean);
    procedure DoInsertItem(Item: Pointer); virtual;
    procedure DoAskForDelete(Item: Pointer; var CanDelete, DeleteToBin: Boolean); virtual;
    procedure DoDeleteItem(Item: Pointer); virtual;
    procedure DoSetChanged(Value: Boolean); virtual;
{ Methods whish must be overlapped in descendant collections
  to work with objects who are not descendants of TVObject. }

    function GetItem(S: TVStream): Pointer; virtual;
    procedure PutItem(S: TVStream; Item: Pointer); virtual;
    procedure FreeItem(Item: Pointer); virtual;
    function CloneItem(Item: Pointer): Pointer; virtual;

  public

  { Creat, read, delete, save, clone a collection
   (with all elements)
}
    constructor Create; override;
    destructor Destroy; override;
    constructor Load(S: TVStream; Version: Word); override;
    procedure Store(S: TVStream); override;
    function Clone: Pointer; override;
{ Add and delete elements. Function Add returns the numner (index) of the
 added record in current index (the fist has number 0). While deleting
 to basket, the record rewritten into collection Bin, which is saved with
 main collection
}

    function Add(Item: Pointer): Integer;
    procedure Delete(Index: Integer; ToBin: Boolean = False);
    procedure DeleteAndFree(Index: Integer);
    procedure DeleteObj(Item: Pointer; ToBin: Boolean = False);
    procedure DeleteObjAndFree(Item: Pointer);
    procedure Clear; virtual;
    procedure ClearAndFreeItems; virtual;
    procedure ClearLights;                // property Capacity is not changed
    procedure ClearAndFreeItemsLights;

  { IndexOf returns number of pointed record for current index of collection}

    function IndexOf(Item: Pointer): Integer;

  { First and last records in current index }

    function First: Pointer;
    function Last: Pointer;
{ This methods are designed for a work with unordered collections
  (which has attribute Requal=False for current index). While calling of
  Sort procedure, the first parameter is the function for comparasion
  the second parameter is False for grouth (increase) ordering
  and True - for decrease ordering
}

    procedure Insert(Index: Integer; Item: Pointer);
    procedure Exchange(Index1, Index2: Integer);
    procedure Move(CurIndex, NewIndex: Integer);
    procedure Sort(ACompare: TVCollSortCompare; ADesc: Boolean = False);
    procedure ReverseItems;
{ If some fields of this collection are external,relating to another collection,
  you for speed increase can add fields pointed to the objects of main collection.
  Then with method UpdateLink overlapping you will update these pointers using
  foreign key from current collection and main collection, transmitted in parameter
  AColl. LinkID - link identifier (any foreign key has its own ID). RemoveLink
  is used to remove (assignment of nil) for all pointers.
}

    procedure UpdateLink(const LinkID: string; AColl: TVUniCollection); virtual;
    procedure RemoveLink(const LinkID: string); virtual;
{ Add, delete, actvate, deactivate indexes.
  UpdateIndexes procedure must be called any time when fields which infuence on
  sorting are changed. SwitchToIndex makes active the index with name AIndName.
  Initially, any record to store index information must be created
  with the CreateIndexRec procedure.
}

    procedure AddIndex(PIR: PTVIndexRec; SwitchTo: Boolean = False);
    procedure DeleteIndex(const AIndName: string);
    procedure UpdateIndex(const AIndName: string);
    procedure ActivateIndex(const AIndName: string);
    procedure DeactivateIndex(const AIndName: string);
    procedure ActivateAllIndexes;
    procedure DeactivateAllIndexes;
    procedure UpdateIndexes;
    procedure SwitchToIndex(const AIndName: string);

  { The work with indexes by pointers }

    function GetIndexList(const AIndName: string): PTVItemList;
    function GetIndexRec(const AIndName: string; Activate: Boolean = True): PTVIndexRec;
    procedure ActivateIndexByPIR(PIR: PTVIndexRec);
    procedure DeactivateIndexByPIR(PIR: PTVIndexRec);
    function IndexOfByIndex(PIR: PTVIndexRec; Item: Pointer): Integer;
    procedure UpdateIndexByPIR(PIR: PTVIndexRec);
{
 Record seaching on key field. Function SearchIndex_XXX returns number
 of record in index which was passed as the PIR parameter. The record is
 respective to the Key AKey. If not found returns -1. Record of type
 PTVIndexRec for a index can be obtained with the function GetIndexRec.
 The first record has number 0.
}

    function SearchIndex_Shortint(PIR: PTVIndexRec; AKey: Shortint): Integer;
    function SearchIndex_Byte(PIR: PTVIndexRec; AKey: Byte): Integer;
    function SearchIndex_Smallint(PIR: PTVIndexRec; AKey: Smallint): Integer;
    function SearchIndex_Word(PIR: PTVIndexRec; AKey: Word): Integer;
    function SearchIndex_Integer(PIR: PTVIndexRec; AKey: Integer): Integer;
    function SearchIndex_Cardinal(PIR: PTVIndexRec; AKey: Cardinal): Integer;
    function SearchIndex_Pointer(PIR: PTVIndexRec; AKey: Pointer): Integer;
    function SearchIndex_Int64(PIR: PTVIndexRec; AKey: Int64): Integer;
    function SearchIndex_Currency(PIR: PTVIndexRec; AKey: Currency): Integer;
    function SearchIndex_TDateTime(PIR: PTVIndexRec; AKey: TDateTime): Integer;
    function SearchIndex_Single(PIR: PTVIndexRec; AKey: Single): Integer;
    function SearchIndex_Double(PIR: PTVIndexRec; AKey: Double): Integer;
    function SearchIndex_Extended(PIR: PTVIndexRec; AKey: Extended): Integer;
    function SearchIndex_Comp(PIR: PTVIndexRec; AKey: Comp): Integer;
    function SearchIndex_String(PIR: PTVIndexRec; const AKey: string): Integer;
    function SearchIndex_PChar(PIR: PTVIndexRec; AKey: PChar): Integer;
    function SearchIndex_String_I(PIR: PTVIndexRec; const AKey: string): Integer;
    function SearchIndex_PChar_I(PIR: PTVIndexRec; AKey: PChar): Integer;
    function SearchIndex_UserCmp(PIR: PTVIndexRec; AKey: Pointer): Integer;
{
 The Next record seaching on key field. The privious found record index (or -1)
 is passed as parameter Index. In the same parameter the new found record number
 returns (if the function result is True). If record was not found the function
 returns False.
}

    function SearchNext_Shortint(PIR: PTVIndexRec; AKey: Shortint; var Index: Integer): Boolean;
    function SearchNext_Byte(PIR: PTVIndexRec; AKey: Byte; var Index: Integer): Boolean;
    function SearchNext_Smallint(PIR: PTVIndexRec; AKey: Smallint; var Index: Integer): Boolean;
    function SearchNext_Word(PIR: PTVIndexRec; AKey: Word; var Index: Integer): Boolean;
    function SearchNext_Integer(PIR: PTVIndexRec; AKey: Integer; var Index: Integer): Boolean;
    function SearchNext_Cardinal(PIR: PTVIndexRec; AKey: Cardinal; var Index: Integer): Boolean;
    function SearchNext_Pointer(PIR: PTVIndexRec; AKey: Pointer; var Index: Integer): Boolean;
    function SearchNext_Int64(PIR: PTVIndexRec; AKey: Int64; var Index: Integer): Boolean;
    function SearchNext_Currency(PIR: PTVIndexRec; AKey: Currency; var Index: Integer): Boolean;
    function SearchNext_TDateTime(PIR: PTVIndexRec; AKey: TDateTime; var Index: Integer): Boolean;
    function SearchNext_Single(PIR: PTVIndexRec; AKey: Single; var Index: Integer): Boolean;
    function SearchNext_Double(PIR: PTVIndexRec; AKey: Double; var Index: Integer): Boolean;
    function SearchNext_Extended(PIR: PTVIndexRec; AKey: Extended; var Index: Integer): Boolean;
    function SearchNext_Comp(PIR: PTVIndexRec; AKey: Comp; var Index: Integer): Boolean;
    function SearchNext_String(PIR: PTVIndexRec; const AKey: string; var Index: Integer): Boolean;
    function SearchNext_PChar(PIR: PTVIndexRec; AKey: PChar; var Index: Integer): Boolean;
    function SearchNext_String_I(PIR: PTVIndexRec; const AKey: string; var Index: Integer): Boolean;
    function SearchNext_PChar_I(PIR: PTVIndexRec; AKey: PChar; var Index: Integer): Boolean;
    function SearchNext_UserCmp(PIR: PTVIndexRec; AKey: Pointer; var Index: Integer): Boolean;

  { Searchin of record by key which returns pointer to found record
   (nil - not found) }

    function SearchObj_Shortint(PIR: PTVIndexRec; AKey: Shortint): Pointer;
    function SearchObj_Byte(PIR: PTVIndexRec; AKey: Byte): Pointer;
    function SearchObj_Smallint(PIR: PTVIndexRec; AKey: Smallint): Pointer;
    function SearchObj_Word(PIR: PTVIndexRec; AKey: Word): Pointer;
    function SearchObj_Integer(PIR: PTVIndexRec; AKey: Integer): Pointer;
    function SearchObj_Cardinal(PIR: PTVIndexRec; AKey: Cardinal): Pointer;
    function SearchObj_Pointer(PIR: PTVIndexRec; AKey: Pointer): Pointer;
    function SearchObj_Int64(PIR: PTVIndexRec; AKey: Int64): Pointer;
    function SearchObj_Currency(PIR: PTVIndexRec; AKey: Currency): Pointer;
    function SearchObj_TDateTime(PIR: PTVIndexRec; AKey: TDateTime): Pointer;
    function SearchObj_Single(PIR: PTVIndexRec; AKey: Single): Pointer;
    function SearchObj_Double(PIR: PTVIndexRec; AKey: Double): Pointer;
    function SearchObj_Extended(PIR: PTVIndexRec; AKey: Extended): Pointer;
    function SearchObj_Comp(PIR: PTVIndexRec; AKey: Comp): Pointer;
    function SearchObj_String(PIR: PTVIndexRec; const AKey: string): Pointer;
    function SearchObj_PChar(PIR: PTVIndexRec; AKey: PChar): Pointer;
    function SearchObj_String_I(PIR: PTVIndexRec; const AKey: string): Pointer;
    function SearchObj_PChar_I(PIR: PTVIndexRec; AKey: PChar): Pointer;
    function SearchObj_UserCmp(PIR: PTVIndexRec; AKey: Pointer): Pointer;
{ Searching of records interval where key values are between LeftBound and
  RightBound (wether bounds are included depends upon parameters LeftTerm
  and RightTerm). Interval relates to the index PIR. If interval is found
  parameter Index is the number of first element, and Result is equal to the
  total number of records inside the interval. If nothing was founf the function
  returns 0. Index PIR must be ordered.
}

    function SelectRange_Shortint(PIR: PTVIndexRec; LeftBound, RightBound: Shortint;
      var Index: Integer; LeftTerm: Integer = rtInclude; RightTerm: Integer = rtInclude): Integer;
    function SelectRange_Byte(PIR: PTVIndexRec; LeftBound, RightBound: Byte;
      var Index: Integer; LeftTerm: Integer = rtInclude; RightTerm: Integer = rtInclude): Integer;
    function SelectRange_Smallint(PIR: PTVIndexRec; LeftBound, RightBound: Smallint;
      var Index: Integer; LeftTerm: Integer = rtInclude; RightTerm: Integer = rtInclude): Integer;
    function SelectRange_Word(PIR: PTVIndexRec; LeftBound, RightBound: Word;
      var Index: Integer; LeftTerm: Integer = rtInclude; RightTerm: Integer = rtInclude): Integer;
    function SelectRange_Integer(PIR: PTVIndexRec; LeftBound, RightBound: Integer;
      var Index: Integer; LeftTerm: Integer = rtInclude; RightTerm: Integer = rtInclude): Integer;
    function SelectRange_Cardinal(PIR: PTVIndexRec; LeftBound, RightBound: Cardinal;
      var Index: Integer; LeftTerm: Integer = rtInclude; RightTerm: Integer = rtInclude): Integer;
    function SelectRange_Pointer(PIR: PTVIndexRec; LeftBound, RightBound: Pointer;
      var Index: Integer; LeftTerm: Integer = rtInclude; RightTerm: Integer = rtInclude): Integer;
    function SelectRange_Int64(PIR: PTVIndexRec; LeftBound, RightBound: Int64;
      var Index: Integer; LeftTerm: Integer = rtInclude; RightTerm: Integer = rtInclude): Integer;
    function SelectRange_Currency(PIR: PTVIndexRec; LeftBound, RightBound: Currency;
      var Index: Integer; LeftTerm: Integer = rtInclude; RightTerm: Integer = rtInclude): Integer;
    function SelectRange_TDateTime(PIR: PTVIndexRec; LeftBound, RightBound: TDateTime;
      var Index: Integer; LeftTerm: Integer = rtInclude; RightTerm: Integer = rtInclude): Integer;
    function SelectRange_Single(PIR: PTVIndexRec; LeftBound, RightBound: Single;
      var Index: Integer; LeftTerm: Integer = rtInclude; RightTerm: Integer = rtInclude): Integer;
    function SelectRange_Double(PIR: PTVIndexRec; LeftBound, RightBound: Double;
      var Index: Integer; LeftTerm: Integer = rtInclude; RightTerm: Integer = rtInclude): Integer;
    function SelectRange_Extended(PIR: PTVIndexRec; LeftBound, RightBound: Extended;
      var Index: Integer; LeftTerm: Integer = rtInclude; RightTerm: Integer = rtInclude): Integer;
    function SelectRange_Comp(PIR: PTVIndexRec; LeftBound, RightBound: Comp;
      var Index: Integer; LeftTerm: Integer = rtInclude; RightTerm: Integer = rtInclude): Integer;
    function SelectRange_String(PIR: PTVIndexRec; const LeftBound, RightBound: string;
      var Index: Integer; LeftTerm: Integer = rtInclude; RightTerm: Integer = rtInclude): Integer;
    function SelectRange_PChar(PIR: PTVIndexRec; LeftBound, RightBound: PChar;
      var Index: Integer; LeftTerm: Integer = rtInclude; RightTerm: Integer = rtInclude): Integer;
    function SelectRange_String_I(PIR: PTVIndexRec; const LeftBound, RightBound: string;
      var Index: Integer; LeftTerm: Integer = rtInclude; RightTerm: Integer = rtInclude): Integer;
    function SelectRange_PChar_I(PIR: PTVIndexRec; LeftBound, RightBound: PChar;
      var Index: Integer; LeftTerm: Integer = rtInclude; RightTerm: Integer = rtInclude): Integer;
    function SelectRange_UserCmp(PIR: PTVIndexRec; LeftBound, RightBound: Pointer;
      var Index: Integer; LeftTerm: Integer = rtInclude; RightTerm: Integer = rtInclude): Integer;
{ If index passed as parameter PIR has type "string" then below functions
  can be used to select record interval which have key begining from substring
  passed with parameter S or P. Result is as in function SelectRange_XXX.
  Index PIR must be ordered.
}

    function StartWith_String(PIR: PTVIndexRec; const S: string; var Index: Integer): Integer;
    function StartWith_PChar(PIR: PTVIndexRec; P: PChar; var Index: Integer): Integer;
    function StartWith_String_I(PIR: PTVIndexRec; const S: string; var Index: Integer): Integer;
    function StartWith_PChar_I(PIR: PTVIndexRec; P: PChar; var Index: Integer): Integer;
{ Collection-owner of the current collection. Property Changed of owner is set to
  True if property Changed of the current collection is set. This property
  can be used if the current collection is one of fields of records stored in
  another collection, who will be its owner.
  (Another collection is owner of the current collection.)
}

    property Owner: TVUniCollection read FOwner write FOwner;
{ Basket, where records can be put while deleting. Usually the basket has the
  same indexes as main collection (since it is created with method Create of main
  collection. You must manually privent unique indexes violation in basket.
}

    property Bin: TVUniCollection read FBin;
{ If FreeItemsOnDestroy is set to True (default),then while collection deleting
  all its elements are freed (automatically-? with the call of TVObject.Free).
  If yuo do not want such set FreeItemsOnDestroy to False
}

    property FreeItemsOnDestroy: Boolean read FFreeIOD write FFreeIOD;
{ Current active index of the collection. Any collection must have at least
  one active index. One of active indexes is current.
  TVUniCollection has no indexes, thus to work with this class instans is impossible
  TVUniCollection - abstract class ?
}

    property CurrIndex: PTVIndexRec read FCurrentIndex write SetCurrIndex;

  { This property is usually used to access items. }

    property Items[Index: Integer]: Pointer read Get; default;
{ This property also could be used to access items. It contains
  the pointer to items list for current index. When working with this
  property be carefull, since the boundaries do not checked. Dut you should not suppose
  that the List wil not change when current index is not changed.
}

    property List: PTVItemList read FList;

  { Number of elements for which memory is allocated. }

    property Capacity: Integer read FCapacity write SetCapacity;

  { Number of elements in collection. }

    property Count: Integer read FCount;

  { If Big=False the collection is saved in format compatible with TurboVision.
  Default Big = True. }

    property Big: Boolean read FBig write FBig;
{ Modification Flag. It does not work automatically while adding or deleting
  record. User must set or unset it manually !!!
}

    property Changed: Boolean read FChanged write SetChanged;
{ Next properties can be assigned with procedures to be called
  during the query to add or delete a record,
  and also during the adding or deleting a record and changing the flag Changed
}

    property OnAskForInsert: TVAskForInsertEvent read FOnAskForInsert write FOnAskForInsert;
    property OnInsertItem: TVInsertItemEvent read FOnInsertItem write FOnInsertItem;
    property OnAskForDelete: TVAskForDeleteEvent read FOnAskForDelete write FOnAskForDelete;
    property OnDeleteItem: TVDeleteItemEvent read FOnDeleteItem write FOnDeleteItem;
    property OnSetChanged: TVSetChangedEvent read FOnSetChanged write FOnSetChanged;
  end;
{ TVCollection - the simplest non-abstract collection (descendant of TVUniCollection),
  has one unordered index (unnordered set of items, which can be saved on HDD
}

  TVCollection = class(TVUniCollection)
  public
    constructor Create; override;
    constructor CreateRefsList; virtual;        // Creation of references ciollection, they are not deallocated automatically
    constructor CreateFromList(ListObj: TList); // Creation of collection (analog of CreateRefsList) and copying into it the contents of TList
    procedure CopyToList(ListObj: TList);       // Copying of all pointers to record into TList
    procedure MakeStdIndex; virtual;
  end;

{ TVStringCollection - collection of strings }

  PTVStringItemList = ^TVStringItemList;
  TVStringItemList = array[0..MaxCollectionSize - 1] of string;

  TVStringCollection = class(TVObject)
  private
    FList: PTVStringItemList;
    FCount: Integer;
    FCapacity: Integer;
    FOwner: TVUniCollection;
    FDuplicates: Boolean;
    FBig: Boolean;
    FChanged: Boolean;
    procedure SetChanged(Value: Boolean);
    function GetTextStr: string;
    procedure SetTextStr(const Value: string);
  protected
    function Get(Index: Integer): string;
    procedure SetCapacity(NewCapacity: Integer);
    procedure Grow;
  public
    constructor Create; override;
    constructor CreateFromStringList(StrList: TStringList); // Creation from TStringList
    destructor Destroy; override;
    constructor Load(S: TVStream; Version: Word); override;
    procedure Store(S: TVStream); override;
    function Clone: Pointer; override;
    procedure CopyToStrings(StrList: TStrings); // Copying into TStrings (from Classes unit)
    function Add(const S: string): Integer;     // Adding a string. Result equal to the index of added string
    procedure Clear;                            // Removing all strings from collection
    procedure Delete(Index: Integer);           // Removing the string by the number
    function Find(const S: string; var Index: Integer): Boolean; // Searching for index
    function First: string;   // First string
    function Last: string;    // Last string
    procedure ToUpperCase;    // UpperCase all strings
    procedure ToLowerCase;    // LowerCase all strings
    procedure ToUpLowerCase;  // UpperCase of first letter, lowerCase -other letters all strings
    procedure ConvertToAnsi;  // All strings - into Windows code
    procedure ConvertToOem;   // All strings - into DOS (OEM) code
    property Owner: TVUniCollection read FOwner write FOwner;
    property Duplicates: Boolean read FDuplicates write FDuplicates; // If True, allow duplicates
    property Big: Boolean read FBig write FBig;                      // If False, Turbo Vision format
    property Strings[Index: Integer]: string read Get; default;      // Items
    property Text: string read GetTextStr write SetTextStr;          // All strings as one text
    property Capacity: Integer read FCapacity write SetCapacity;
    property Count: Integer read FCount; // Number of strings in colection
    property List: PTVStringItemList read FList;
    property Changed: Boolean read FChanged write SetChanged;
  end;

{ TVIntegerSet - unnordered set of integers (type Integer). }

  PTVIntegerSetItemList = ^TVIntegerSetItemList;
  TVIntegerSetItemList = array[0..MaxCollectionSize - 1] of Integer;

  TVIntegerSet = class(TVObject)
  private
    FChanged: Boolean;
    procedure SetChanged(Value: Boolean);
  protected
    function Get(Index: Integer): Integer;
    procedure Grow;
  public
    List: PTVIntegerSetItemList; // List of elements
    Count: Integer;              // Number of Elements
    Capacity: Integer;           // Number to which Memory allocated for
    Owner: TVUniCollection;      // Collection-owner of the set
    destructor Destroy; override;
    constructor Load(S: TVStream; Version: Word); override;
    procedure Store(S: TVStream); override;
    function Clone: Pointer; override;
    procedure Clear;                         // Remove all items
    procedure Include(Number: Integer);      // Include one integer
    procedure Exclude(Number: Integer);      // Exclude one integer
    procedure Complement(Number: Integer);   // Include one integer if it is not in the collection, exclude one integer if it is in the collection
    function Test(Number: Integer): Boolean; // Test whether the integer in the set
    procedure Delete(Index: Integer);        // Remove one integer by its index (the first is 0)
    procedure ReverseItems;                  // Reverse internal array
    procedure SetCapacity(NewCapacity: Integer);
    property Items[Index: Integer]: Integer read Get; default; // Items
    property Changed: Boolean read FChanged write SetChanged;
  end;

{ TVWordSet - unordered set of integers (type Word). }

  PTVWordSetItemList = ^TVWordSetItemList;
  TVWordSetItemList = array[0..MaxCollectionSize - 1] of Word;

  TVWordSet = class(TVObject)
  private
    FChanged: Boolean;
    procedure SetChanged(Value: Boolean);
  protected
    function Get(Index: Integer): Word;
    procedure Grow;
  public
    List: PTVWordSetItemList; // List of elements
    Count: Integer;           // Number of Elements
    Capacity: Integer;        // Number to which Memory allocated for
    Owner: TVUniCollection;   // Collection-owner of the set
    destructor Destroy; override;
    constructor Load(S: TVStream; Version: Word); override;
    procedure Store(S: TVStream); override;
    function Clone: Pointer; override;
    procedure Clear;                      // Remove all items
    procedure Include(Number: Word);      // Include one integer
    procedure Exclude(Number: Word);      // Exclude one integer
    procedure Complement(Number: Word);   // Include one integer if it is not in the collection, exclude one integer if it is in the collection
    function Test(Number: Word): Boolean; // Test whether the integer in the set
    procedure Delete(Index: Integer);     // Remove one integer by its index (the first is 0)
    procedure ReverseItems;               // Reverse internal array
    procedure SetCapacity(NewCapacity: Integer);
    property Items[Index: Integer]: Word read Get; default; // Items
    property Changed: Boolean read FChanged write SetChanged;
  end;
{ TVRandomGenerator -  random number generator Mersenne Twister. This class is used
  to incapsulate such generator, save it on disk and load from disk
}

  TVRandomGenerator = class(TVObject)
  private
    FID: TMTID;
  public
    constructor Create; override;                   // Initiate with random constant
    constructor CreateFixed(Seed: LongWord = 4357); // Initiate with defined constant
    destructor Destroy; override;
    constructor Load(S: TVStream; Version: Word); override;
    procedure Store(S: TVStream); override;
    function Clone: Pointer; override;
{  Internal state changing on abitrarial string S and, if UseTSC=True,
   on current CPU timer tic count  }

    procedure Update1(const S: string; UseTSC: Boolean = True); // method CAST-256
    procedure Update2(const S: string; UseTSC: Boolean = True); // method RC6
    property ID: TMTID read FID write FID; // Sensor ID
  end;

{ TVMarks is bit set analoguos to TBit from Classes unit.
  TVMarks can save itself into stream, search setted and cleared bits
  and can fast count them. It can be usefull in designe of list with
  mark for each element }

  PTVMarkList = ^TVMarkList;
  TVMarkList = array[0..(MaxTVMarkCount - 1) shr 5] of LongWord;

  TVMarks = class(TVObject)
  private
    FList: PTVMarkList;
    FCount: Integer;
    FSize: Integer;
    FMarkCount: Integer;
    FOwner: TVUniCollection;
    FChanged: Boolean;
    function GetMark(Index: Integer): Boolean;
    procedure SetCount(ACount: Integer);
    procedure SetMark(Index: Integer; Value: Boolean);
    function GetFreeCount: Integer;
    procedure SetChanged(Value: Boolean);
  public
    destructor Destroy; override;
    constructor Load(S: TVStream; Version: Word); override;
    procedure Store(S: TVStream); override;
    function Clone: Pointer; override;
    procedure GetDataFrom(AMarks: TVMarks); // Load data from another such object
    procedure InvertMark(Index: Integer);   // Invert mark for element
    function SearchMarked: Integer;         // Find marked element
    function SearchNextMarked(var Index: Integer): Boolean; // Find next marked element
    function SearchFree: Integer;           // Find unmarked element
    function SearchNextFree(var Index: Integer): Boolean; // Find next unmarked element
    procedure SetAllMarked;                 // Mark all items
    procedure SetAllFree;                   // Unmark all items
    procedure InvertAllMarks;               // Invert marks for all items
    property Owner: TVUniCollection read FOwner write FOwner;
    property MarkCount: Integer read FMarkCount;   // Number of marked
    property FreeCount: Integer read GetFreeCount; // Number of unmarked
    property List: PTVMarkList read FList;         // Direct access to items
    property Count: Integer read FCount write SetCount; // Number of items
    property Items[Index: Integer]: Boolean read GetMark write SetMark; default; // Access to items
    property Size: Integer read FSize;             // Memory (in DWORD), allocated for set
    property Changed: Boolean read FChanged write SetChanged; // Modification flag
  end;

{ TVUniNumberObj - basic class, a parent for majority of user ojects.
  This class uses the only field - unique ID Number. Functions IsEqual and Reconcile
  is used for data agreemen. Function IsEqual must return True
  if all fields of object Obj are equal to the corresponding fields of the given object.
  Procedure Reconcile must compare all fields of objects OldObj and
  NewObj and for those fields which valueas are not equal change OldObj field
  by the corresponding NewObj field. Any descendant of TVUniNumberObj must compare
  in methods IsEqual and Reconcile only new fields (added in the descendant), for
  other fields the perant methods will work.
  Any new record must have unique number derivable from collection property UniqueNumbe
  where given object is supposed to be added.
}

  TVUniNumberObj = class(TVObject)
  private
    FNumber: Integer;
  public
    function Clone: Pointer; override;
    constructor Load(S: TVStream; Version: Word); override;
    procedure Store(S: TVStream); override;

    function IsEqual(Obj: Pointer): Boolean; virtual;
    procedure Reconcile(OldObj, NewObj: Pointer); virtual;

    property Number: Integer read FNumber write FNumber;
  end;

{ TVUniNumberColl - basic collection , a parent for magority of user collections}

  TVUniNumberColl = class(TVUniCollection)
  private
    FLastUsedNumber: Integer;
    function GetUniqueNumber: Integer;
  public
    constructor Create; override;
    constructor Load(S: TVStream; Version: Word); override;
    procedure Store(S: TVStream); override;
    function Clone: Pointer; override;
    procedure MakeIndexBy_Number; virtual;

  { Search object by number. }

    function SearchNumberObj(N: Integer): Pointer;

  { Search object by number but returns the index for carrrent index or -1. }

    function SearchNumberIndex(N: Integer): Integer;

  { Test existense of element with given number. }

    function NumberExists(N: Integer): Boolean;

  { Rollback (OTKAT) of last number get from property UniqueNumber. In future
    this number will be assigned to another record. }

    procedure RollbackNumber(N: Integer);

  { Last number get while reading property UniqueNumber. }

    property LastUsedNumber: Integer read FLastUsedNumber write FLastUsedNumber;

  { Uniq number for new record. }

    property UniqueNumber: Integer read GetUniqueNumber;
  end;
{ TVUniNameObj - descendant of TVUniNumberObj, has field Name.
  DB records often have string field which can be used as ID.
 TVUniNameObj is used with TVUniNameColl. Field Name is uhique by default.
}


  TVUniNameObj = class(TVUniNumberObj)
  private
    FName: string;
  public
    function Clone: Pointer; override;
    constructor Load(S: TVStream; Version: Word); override;
    procedure Store(S: TVStream); override;

    function IsEqual(Obj: Pointer): Boolean; override;
    procedure Reconcile(OldObj, NewObj: Pointer); override;

    property Name: string read FName write FName;
  end;

{ TVUniNameColl - collection of objects descendant from TVUniNameObj. }

  TVUniNameColl = class(TVUniNumberColl)
  public
    constructor Create; override;
    procedure MakeIndexBy_Name; virtual;

  { Search object by field Name. }

    function SearchNameObj(const Name: string): Pointer;
    function SearchNameIndex(const Name: string): Integer;

  { Search next object by given field Name. Index parameter
    must be equal to index of previous found object or -1}

    function SearchNextNameIndex(const Name: string; var Index: Integer): Boolean;

  { Get field Number from field Name and vise versa. }

    function GetNumberByName(const Name: string): Integer;
    function GetNameByNumber(N: Integer): string;
  end;

  TVSecurityKey = array[0..47] of Byte; // for peCAST6 and peCAST6_RC4 only first 32 bytes are used [0..31]
{ Structures to protect data from corruption (modificatio) and}

  PTVProtection = ^TVProtection;
  TVProtection = record
    Validation: Word;        // Data verificztion
    Encryption: Word;        // Crypt method
    KeyData: TVSecurityKey;  // Crypt key in use
    KeyLen: Cardinal;        // Current Length of key
    RandID: TMTID;           // PSP generator to form session key
    XXX1,XXX2: LongWord;     // Reserved
    Next: PTVProtection;     // Reserved
  end;
{ TVStream - class for read/write operations. When opens for read only
  it is used fast file in memory projection }

  TVStream = class(TObject)
  private
    FHandle: Integer;
    FFileName: string;
    FDataView: Pointer;
    FSecurity: PTVProtection;
    FData: Pointer;
    FFileSize: Integer;
    FMode: Word;
    function GetPosition: Integer;
    procedure SetPosition(Pos: Integer);
    function GetSize: Integer;
    procedure SetSize(NewSize: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    procedure OpenFile(const AFileName: string; AMode: Word); // Open existent file
    procedure CreateFile(const AFileName: string);   // Create new file
    procedure CloseFile;                             // Close File
    procedure Read(var Buffer; Count: Integer);      // Read Count bytes from stream into Buffer
    procedure ReadB(var Buffer; Count: Integer);     // As above for big fragments
    procedure Write(const Buffer; Count: Integer);   // Write Count bytes from Buffer into stream
    procedure Skip(Count: Integer);                  // When next readiding omit Count bytes
    function Seek(Offset, Origin: Integer): Integer; // Stream positioning
    function CopyFrom(Source: TVStream; Count: Integer = cfCopyAllData): Integer; // Copy data from another stream
    function Get(Security: PTVProtection = nil): TVObject;     // Read object from stream
    procedure Put(P: TVObject; Security: PTVProtection = nil); // Write object into stream
    procedure Truncate; // Set stream end in current position
    procedure Flush;    // Write data from cash to disk

    function ReadStr: string;                 // Read string (max 255 chars)
    procedure WriteStr(const S: string);      // Write string (max 255 chars)
    function ReadLongStr: string;             // Read string (any length)
    procedure WriteLongStr(const S: string);  // Write string (any length)
    function ReadStrRLE: string;              // Read string compressed with RLE method
    procedure WriteStrRLE(const S: string);   // Write string compressed with RLE method
    function ReadOemStr: string;              // Read string in DOS encoding (with converting to ANSI)
    procedure WriteOemStr(const S: string);   // Write string in DOS encoding (with converting to OEM)
    function ReadFixedStr(Len: Byte): string; // Read fixed length string in DOS encoding(with converting to ANSI)
    procedure WriteFixedStr(const S: string; Len: Byte); // Write fixed length string in DOS encoding (with converting to Oem)
    function StrRead: PChar;                  // Read Dos-string of type PChar (with converting to ANSI)
    procedure StrWrite(P: PChar);             // Write Dos-string of type PChar(with converting to Oem)

    function ReadRealAsCurrency: Currency;      // Read type Real48 as Currency
    procedure WriteCurrencyAsReal(V: Currency); // Write type Currency as Real48
    function ReadRealAsDouble: Double;          // Read type Real48 as Double
    procedure WriteDoubleAsReal(V: Double);     // Write type Double as Real48

    property Position: Integer read GetPosition write SetPosition; // Current position in stream
    property Size: Integer read GetSize write SetSize; // File size in bytes
    property FileName: string read FFileName; // Stream FileName
    property Handle: Integer read FHandle;    // File handle
    property Mode: Word read FMode;           // File open mode (regim)
  end;
{ TVStorage - class-storage. It is a file, wich
  simultaneously stores a lot number of different (or one-type) objects
  with the access to them by key. The key is of type
  Integer. Any object (besides the key) has the corresponding tag - some abitrarily
  type Integer for user (programmer) perposes. At any time any number of users
  can read data from storage, but to write something into the storage user must
  open it in exclusive access (it is made automatically). While deleting/rewriting
  into a storage it (the storage) will be fragmented. You can set regim
  when it will be automatically compressed (property PackOnFly set True) or
  you can set the maximum fragmentation procent before defragmentation
  (property MaxGarbagePercent).
}

  PTVStorageItem = ^TVStorageItem;
  TVStorageItem = record
    Key: Integer;
    Size: Integer;
    Pos: Integer;
    Tag: Integer;
  end;

  PTVStorageItemList = ^TVStorageItemList;
  TVStorageItemList = array[0..99999999] of TVStorageItem;

  PTVSortStgList = ^TVSortStgList;
  TVSortStgList = array[0..99999999] of PTVStorageItem;

  TVStorage = class(TObject)
  private
    FList: PTVStorageItemList;
    FCount: Integer;
    FCapacity: Integer;
    FStream: TVStream;
    FIndexPos: Integer;
    FInfoStr: string;
    FSizeOfFragments: Integer;
    FMaxGarbagePercent: Single;
    FPackOnFly: Boolean;
    FShrinkOnFlush: Boolean;
    FModified: Boolean;
    function GetReadOnly: Boolean;
    function GetFileName: string;
    procedure SetCapacity(NewCapacity: Integer);
    function InterGet(Key: Integer): TVObject;
    procedure InterPut(Key: Integer; Item: TVObject);
  public
    constructor Create(AStream: TVStream);
    destructor Destroy; override;
    function Get(Key: Integer; Security: PTVProtection = nil): TVObject; // Read object
    function GetTg(Key: Integer; var ATag: Integer; Security: PTVProtection = nil): TVObject; // Read object and its tag
    procedure Put(Key: Integer; Item: TVObject; Security: PTVProtection = nil); // Write object
    procedure PutTg(Key: Integer; Item: TVObject; ATag: Integer; Security: PTVProtection = nil); // Write object with its tag
    procedure Delete(Key: Integer);                            // Delete object by key
    function Find(AKey: Integer; var Index: Integer): Boolean; // Search Akey key ID in key collection
    function KeyExists(Key: Integer): Boolean;                 // Test key existence in storage
    function GetAt(Index: Integer; Security: PTVProtection = nil): TVObject; // Read object by index in keys collection
    procedure DeleteAt(Index: Integer);            // Delete index in keys collection
    function KeyAt(Index: Integer): Integer;       // Key by index in keys collection
    function TagAt(Index: Integer): Integer;       // Tag by index in keys collection
    procedure Sweep;                               // Defragment storage
    procedure Flush(ForcedWrite: Boolean = False); // Save data on disk
    property FileName: string read GetFileName; // FileName of storage
    property SizeOfFragments: Integer read FSizeOfFragments; // The size of fragmented region
    property ShrinkOnFlush: Boolean read FShrinkOnFlush write FShrinkOnFlush; // Decrease storage size
    property Modified: Boolean read FModified write FModified; // True, - was modified
    property ReadOnly: Boolean read GetReadOnly; // True,if open as readonly
    property InfoStr: string read FInfoStr write FInfoStr; // String to be written in begin of storage file
    property MaxGarbagePercent: Single read FMaxGarbagePercent write FMaxGarbagePercent; // Maximum fragmentation procent
    property PackOnFly: Boolean read FPackOnFly write FPackOnFly; // Pack storage on the fly
    property List: PTVStorageItemList read FList; // Direct access to items
    property Items[Key: Integer]: TVObject read InterGet write InterPut; default; // Access to unprotected objects by key
    property Count: Integer read FCount; // Count of elements
    property Capacity: Integer read FCapacity write SetCapacity;
  end;

{ Objects for compatibility with Turbo Vision. Do NOT use ! }

{ Basic class TVSortedCollection }

  TVSortedCollection = class(TVUniCollection)
  public
    constructor Load(S: TVStream; Version: Word); override;
    procedure Store(S: TVStream); override;
  end;

{ TVApNumberObj }

  TVApNumberObj = class(TVObject)
  private
    FNumber: Word;
  public
    constructor Load(S: TVStream; Version: Word); override;
    procedure Store(S: TVStream); override;
    function Clone: Pointer; override;
    property Number: Word read FNumber write FNumber;
  end;

{ TVApNumberColl }

  TVApNumberColl = class(TVUniCollection)
  public
    constructor Create; override;
    procedure MakeIndexBy_Number; virtual;
    function SearchNumberObj(N: Word): Pointer;
    function SearchNumberIndex(N: Word): Integer;
    function NumberExists(N: Word): Boolean;
    function GetFreeNumber: Word;
    function GetMaxNumber: Word;
  end;

{ TVApSortNumberColl }

  TVApSortNumberColl = class(TVApNumberColl)
  public
    constructor Load(S: TVStream; Version: Word); override;
    procedure Store(S: TVStream); override;
  end;

{ TVApNameObj }

  TVApNameObj = class(TVApNumberObj)
  private
    FName: string;
  public
    constructor Load(S: TVStream; Version: Word); override;
    procedure Store(S: TVStream); override;
    function Clone: Pointer; override;
    property Name: string read FName write FName;
  end;

{ TVApNameColl }

  TVApNameColl = class(TVApNumberColl)
  public
    constructor Create; override;
    procedure MakeIndexBy_Name; virtual;
    function SearchNameObj(const Name: string): Pointer;
    function SearchNameIndex(const Name: string): Integer;
    function SearchNextNameIndex(const Name: string; var Index: Integer): Boolean;
    function GetNumberByName(const Name: string): Word;
    function GetNameByNumber(N: Word): string;
  end;

{ TVApSortNameColl }

  TVApSortNameColl = class(TVApNameColl)
  public
    constructor Load(S: TVStream; Version: Word); override;
    procedure Store(S: TVStream); override;
  end;

{ TVRandomCollection }

  PTVRandomItem = ^TVRandomItem;
  TVRandomItem = record
    Pos: Integer;
    Size: Integer;
    Key: string;
  end;

  TVRandomCollection = class(TVSortedCollection)
  public
    constructor Create; override;
    procedure MakeIndexes;
    procedure FreeItem(Item: Pointer); override;
    function CloneItem(Item: Pointer): Pointer; override;
    function GetItem(S: TVStream): Pointer; override;
    procedure PutItem(S: TVStream; Item: Pointer); override;
    function Find(const S: string; var Index: Integer): Boolean;
  end;

{ TVRandomFile }

  TVRandomFile = class(TObject)
  private
    FStream: TVStream;
    FBasePos: Integer;
    FIndexPos: Integer;
    FIndex: TVRandomCollection;
    FModified: Boolean;
    FReadOnly: Boolean;
    function GetCount: Integer;
    function GetFileName: string;
  public
    constructor Create(AStream: TVStream);
    destructor Destroy; override;
    procedure Delete(const Key: string);
    procedure DeleteAt(I: Integer);
    procedure Flush; virtual;
    function KeyAt(I: Integer): string;
    function KeyExists(const Key: string): Boolean;
    function SwitchTo(AStream: TVStream; Pack: Boolean = False): TVStream;
    procedure Sweep(Shrink: Boolean = False);
    function Get(const Key: string): TVObject;
    procedure Put(const Key: string; Item: TVObject);
    property FileName: string read GetFileName;
    property Items[const Key: string]: TVObject read Get write Put; default;
    property Count: Integer read GetCount;
    property Modified: Boolean read FModified write FModified;
    property ReadOnly: Boolean read FReadOnly;
  end;

{ TVResourceFile }

  TVResourceFile = class(TVRandomFile)
  public
    constructor Create(AStream: TVStream);
    procedure Flush; override;
  end;

{ TRandomNumCollection }

  PTVRandomNumItem = ^TVRandomNumItem;
  TVRandomNumItem = record
    Pos: Integer;
    Size: Integer;
    Key: Integer;
  end;

  TVRandomNumCollection = class(TVSortedCollection)
  public
    constructor Create; override;
    procedure MakeIndexes;
    procedure FreeItem(Item: Pointer); override;
    function CloneItem(Item: Pointer): Pointer; override;
    function GetItem(S: TVStream): Pointer; override;
    procedure PutItem(S: TVStream; Item: Pointer); override;
    function Find(N: Integer; var Index: Integer): Boolean;
  end;

{ TRandomNumFile }

  TVRandomNumFile = class(TObject)
  private
    FStream: TVStream;
    FBasePos: Integer;
    FIndexPos: Integer;
    FIndex: TVRandomNumCollection;
    FModified: Boolean;
    FReadOnly: Boolean;
    function GetCount: Integer;
    function GetFileName: string;
  public
    constructor Create(AStream: TVStream);
    destructor Destroy; override;
    procedure Delete(Key: Integer);
    procedure DeleteAt(I: Integer);
    procedure Flush;
    function KeyAt(I: Integer): Integer;
    function KeyExists(Key: Integer): Boolean;
    function SwitchTo(AStream: TVStream; Pack: Boolean = False): TVStream;
    procedure Sweep(Shrink: Boolean = False);
    function Get(Key: Integer): TVObject;
    procedure Put(Key: Integer; Item: TVObject);
    property FileName: string read GetFileName;
    property Items[Key: Integer]: TVObject read Get write Put; default;
    property Count: Integer read GetCount;
    property Modified: Boolean read FModified write FModified;
    property ReadOnly: Boolean read FReadOnly;
  end;

{ TVLocksCollection - class for control of file blocking in multi-
  user access to data base. Remember that the mechanics of
  blocking is not reliable in many uaers work simultaniously.
  When the program is closed (including a crash) all blockings are off automatically }

  PTVLockRec = ^TVLockRec;
  TVLockRec = record
    Handle: Integer;
    FileName: string;
    Mode: Word;
  end;

  PTVLockItemList = ^TVLockItemList;
  TVLockItemList = array[0..MaxCollectionSize - 1] of PTVLockRec;

  TVLocksCollection = class(TObject)
  private
    FList: PTVLockItemList;
    FCount: Integer;
    FCapacity: Integer;
    procedure SetCapacity(NewCapacity: Integer);
    procedure Grow;
    function Find(const S: string; var Index: Integer): Boolean;
    procedure InnerLockContinue(Index: Integer);
    function GetLockFileName(Index: Integer): string;
    function GetLockMode(Index: Integer): Word;
    procedure SetLockFileName(Index: Integer; const AFileName: string);
    procedure SetLockMode(Index: Integer; AMode: Word);
  public
    destructor Destroy; override;

  { Addition of file blocking. Filename is in a AFileName parameter.
    File open (blocking) regime is defined in AMode parameter.
    Function returns index of added record about blocking.
    If the blocking is imposiible return is -1}

    function AddLock(const AFileName: string; AMode: Word): Integer;

  { Clear all blockings. }

    procedure ClearAllLocks;

  { Function SearchIndex finds file index in collection of blockings. If given file is not
    fount returns -1. }

    function SearchIndex(const AFileName: string): Integer;

  { Delete record about blocking (and clear the blocking itself). }

    procedure Delete(Index: Integer);

  { Temporary  interruption of blocking. Between interruption and
    actual input/output operation should not be delay. }

    procedure LockContinue(Index: Integer);

  { Resume blocking. Blocking must be resumed immediatly after input/output operation. }

    procedure LockPause(Index: Integer);

  { Get blocked filename by index. }

    property LockFileName[Index: Integer]: string read GetLockFileName write SetLockFileName;

  { Get file blocking regim by index. }

    property LockMode[Index: Integer]: Word read GetLockMode write SetLockMode;
  end;

{ Global collection of blockings. }

var
  Locks: TVLocksCollection;

{ Procedure of user objects registration. AObjID - unique
  ID, respective to given version of object. AClsType - class
  of object. AVersion - version number which is passed in Load and
  Store procedures; if AStored is Truethe given version is storable for
  given object (for any class can be registered the only stored version. }

procedure RegisterTVObject(AObjID: Word; AClsType: TVObjectClassType;
  AVersion: Word; AStored: Boolean);

{ Comparison and agreement of collections in replications. }

type
  PTVChangesRec = ^TVChangesRec;
  TVChangesRec = record
    Ins_New: TVCollection;   // Add record
    Del_Old: TVCollection;   // Delete record
    Edit_Old: TVCollection;  // Change record (old variant)
    Edit_New: TVCollection;  // Change record (new variant)
    Flag: Boolean;           // True, if even one of collections is not empty
  end;

{ Procedure of collections comparison. In the record of adreesed (adresuemoi) collection
  in parameter ChgsRec information returns (information about differences between collections -
  memory for ChgsRec is allocated inside of procedure. After agrrement of changes you must
  free this memory by call of  FreeChangesRec. }


procedure Compare_Collections(OldColl, NewColl: TVUniNumberColl;
  var ChgsRec: PTVChangesRec);

{ Comparison of collections where only insertion and deleting of records are permitted. }

procedure Compare_InsDelCollections(OldColl, NewColl: TVUniNumberColl;
  var ChgsRec: PTVChangesRec);

{ Comparison of collections where only edition of records is permitted. }

procedure Compare_EditCollections(OldColl, NewColl: TVUniNumberColl;
  var ChgsRec: PTVChangesRec);

{ Comparison of collections where only insertion of records is permitted. }

procedure Compare_InsCollections(OldColl, NewColl: TVUniNumberColl;
  var ChgsRec: PTVChangesRec);

{ Comparison of collections where only deleting of records is permitted. }

procedure Compare_DelCollections(OldColl, NewColl: TVUniNumberColl;
  var ChgsRec: PTVChangesRec);

{ Modification of CurrColl collection in accordance with changes passed
  by ChgsRec parameter}

procedure ReconcileChanges(CurrColl: TVUniNumberColl; ChgsRec: PTVChangesRec);

{ Delete record about changes. }

procedure FreeChangesRec(var ChgsRec: PTVChangesRec);

{ Miscellaneous procedures. }

{ Creation of index record. }

procedure CreateIndexRec(var APIR: PTVIndexRec);

{ Creation and deleting record about security. }

procedure CreateSecurityRec(var Security: PTVProtection);
procedure FreeSecurityRec(var Security: PTVProtection);

{ GetFileSHA1Digest returns value of hash-function SHA-1 (digest) for
  file passed by FileName parameter. With this value it is possible to
  test integrity and unchanges of the file. Hash-function value is retunrned
  in Digest parameter. GetFileSHA1Digest result is equal to 0 if it complitted
  succesively. Otherwise result is equal to error code (see below)}

const
  fgNoError        =  0;  // No errors
  fgCannotOpenFile = -1;  // File open error
  fgWrongFileSize  = -2;  // File size is wrong
  fgCannotMapFile  = -3;  // Memory mapping error

function GetFileSHA1Digest(const FileName: string; var Digest: TSHA1Digest): Integer;

{ Function GetFileMixDigest returns 320-bit hash-function }

function GetFileMixDigest(const FileName: string; var Digest: TMixDigest): Integer;

{ Load and save object into stream. }

function LoadObject(const AFileName: string; var Obj; Security: PTVProtection = nil): Integer;
function SaveObject(const AFileName: string; Obj: TVObject; Security: PTVProtection = nil): Integer;
{ procedure CloseObject = FreeAndNil }

{ Load and save object into the storage, test for whethe the storage
  is emty, deleting of object in storage, open storage with given regim. }

function LoadStorageObject(const AFileName: string; Key: Integer;
  var Obj; TagPtr: PInteger = nil; Security: PTVProtection = nil): Integer;
function SaveStorageObject(const AFileName: string; Key: Integer;
  Obj: TVObject; Tag: Integer = 0; Security: PTVProtection = nil): Integer;
function IsStorageEmpty(const AFileName: string): Boolean;
function DeleteStorageObject(const AFileName: string; Key: Integer): Integer;
function OpenStorage(const AFileName: string; var Stg: TVStorage;
  WriteAllow: Boolean = True): Integer;
{ procedure CloseStorage(Object) = FreeAndNil }

{ Procedures to read and write resources, Turbo Vision compatible. }

function LoadRandomObject(const AFileName, Key: string; var Obj): Integer;
function LoadRandomNumObject(const AFileName: string; Key: Integer; var Obj): Integer;
function SaveRandomObject(const AFileName, Key: string; Obj: TVObject;
  Pack: Boolean = True): Integer;
function SaveRandomNumObject(const AFileName: string; Key: Integer;
  Obj: TVObject; Pack: Boolean = True): Integer;
{ procedure CloseRandom(Num)Object = FreeAndNil }

function OpenResource(const AFileName: string; var Rsrs: TVRandomFile;
  WriteAllow: Boolean = True): Integer; overload;
function OpenResource(const AFileName: string; var Rsrs: TVRandomNumFile;
  WriteAllow: Boolean = True): Integer; overload;
function OpenResource(const AFileName: string; var Rsrs: TVResourceFile;
  WriteAllow: Boolean = True): Integer; overload;
{ procedure CloseResource = FreeAndNil }

{ Rase exception if given object version is not supported (called in metod Load). }

procedure RaiseVersionNotSupported(Obj: TVObject; AVersion: Word);

{ Rase exception if given relation ID is not identified (called in metod UpdateLink, RemoveLink). }

procedure RaiseLinkIDNotIdentified(Obj: TVObject; const ALinkID: string);

{ Standart exception to be catched and worked with
  by main program. }

type
  ETVStrmCreateError = class(Exception);       // Error in creation of stream
  ETVStrmFileNotFound = class(Exception);      // Stream file is not found
  ETVStrmOpenError = class(Exception);         // Error in open of stream
  ETVStrmReadError = class(Exception);         // Error in reading of data from stream
  ETVStrmDataCorrupted = class(Exception);     // Data in stream are corrupted
  ETVStrmWriteError = class(Exception);        // Error in saving informaion in stream
  ETVStrmSeekError = class(Exception);         // Error in positioning in stream
  ETVVersionNotSupported = class(Exception);   // This object version is not supported
  ETVUniqueIndexViolation = class(Exception);  // Index is not unique
  ETVInvalidRangeBounds = class(Exception);    // Error in margins settings in a call of SelectRange_XXX
  ETVLinkIDNotIdentified = class(Exception);   // Relation ID is not identified
  ETVLockFileNotFound = class(Exception);      // File not found and can not be blocked
  ETVCannotLockFile = class(Exception);        // Can not block file

implementation

uses Forms, NetWait;

const
  STVCollIndexError = 'Wrong element collection index (%d)';
  STVCollItemNotFound = 'Element collection not found';
  STVCollCapacityError = 'Wrong collection size(%d)';
  STVCollNumberRunOut = 'In the collection %s has no more free numbers';
  STVCollsHaveDiffCount = 'Collections passed to Compare_EditCollections, have different numbers of items';
  STVStrmCreateError = 'File %s creation error';
  STVStrmOpenError = 'File %s open error';
  STVStrmFileNotFound = 'File %s not found';
  STVStrmReadError = 'Read stream error (file %s)';
  STVStrmDataCorrupted = 'Information in file %s is corrupted';
  STVStrmWriteError = 'Write stream error (file %s)';
  STVStrmSeekError = 'Stream positioning error (file %s)';
  STVLongStrError = 'String length is above 255 chars (%s)';
  STVStrLongError = 'String length of PChar exceeds 65527 chars';
  STVReadUnregObj = 'Unregistered object is read from stream (ID=%d)';
  STVWriteUnregObj = 'Unregistered object is written into stream (%s)';
  STVDoubleVersionReg = 'Two objects versions are registered under the same ID (%s)';
  STVDoubleClassReg = 'Two class are registered under the same ID (%d)';
  STVDoubleRegistration = 'Repeated class registration  %s';
  STVDoubleObjIDReg = 'Registration of the same object versions under different ID (%s)';
  STVDoubleStoredReg = 'Repearted registration of storable object version (%s)';
  STVCloneNotSupported = 'Instance of class %s can not be cloned';
  STVResourceNotFound = 'Resource not fount in the stream';
  STVSwitchToReadOnly = 'Attempt to switch resource to the stream open as read-only';
  STVStrFixedOverflow = 'Fixed length string exceeds %d chars (%s)';
  STVVersionNotSupported = 'Class %s does not support version of data %d';
  STVUniqueIndexViolation = 'Index uniqueness violation %s (item of class %s)';
  STVIndexCorrupted = 'Index %s is corrupted (item of class %s)';
  STVIndexNotFound = 'Index %s not found';
  STVInvalidDueToRegularIndex = 'Forbidden operation for sorted index';
  STVTryToInsertNil = 'Attempt to insert nil-pointer into collection %s';
  STVTryToDeleteNil = 'Attempt to delete nil-pointer from collection %s';
  STVCannotLockFile = 'Can not block file %s';
  STVDoubleIndexName = 'Attempt to add second index with the same name (%s)';
  STVTryToDelCurrIndex = 'Can not delete current index (%s)';
  STVDeactiveCurrIndex = 'Can not delete current index disable(%s)';
  STVWrongSearchType = 'Search types mismatch in collection %s by index %s';
  STVFreeNumIsOver = 'Unique names are came to an end for specimen of class %s';
  STVLinkIDNotIdentified = 'Collection %s can not identify the relation by LinkID (%s)';
  STVNotRegularButUnique = 'Unsorted index %s can not be unique';
  STVNonRegularSelRange = 'Range in collection %s is chosen for unsorted index %s';
  STVInvalidRangeBounds = 'While range choose in collection %s by index %s bounds are illegal';
  STVStreamFileNotOpen = 'Attemp to create resource in stream with out file assigned';
  STVPackNonRWStream = 'Resource %s can not be packed (it is open as read-only or write-only)';
  STVPackFileMapErr = 'Error in resource %s mapping to memory';
  STVStorageNotFound = 'Storage in file %s not found';
  STVStrmInvalidFileSize = 'Error while file size determination for file %s';
  STVStrmFileMapErr = 'Error while file to memory mapping for file %s';
  STVLockFileNotFound = 'File %s not found. Blocking impossible';
  STVRepeatedLock = 'File %s is already present in blockings collection';
  STVInvalidLockIndex = 'Illegal element index in blockings collection (%d)';
  STVLockAlreadyPaused = 'Blocking of file %s is already interrupted';
  STVLockWasNotPaused = 'Blocking of file %s is not interrupted';
  STVLocksInnerError = 'Inrernal blockings collection error';

  NWNotifyMsgStart = 'File open error ';
  NWNotifyResMsgStart = 'Resource open error ';
  NWNotifyMsgRead = ' for reading.';
  NWNotifyMsgWrite = ' for writing.';

const
  ResIndexBy_Pos = 'Position';

type
  PRegObjIDsList = ^TRegObjIDsList;
  TRegObjIDsList = array[0..$FFFF] of Word;

  PRegClsTypesList = ^TRegClsTypesList;
  TRegClsTypesList = array[0..$FFFF] of Pointer;

  TRegLoadRec = record
    ClsType: TVObjectClassType;
    Version: Word;
  end;

  PRegLoadList = ^TRegLoadList;
  TRegLoadList = array[0..$FFFF] of TRegLoadRec;

  PStmByte = ^Byte;
  PStmWord = ^Word;
  PStmDWord = ^LongWord;
  PStmSix = ^TStmSix;
  TStmSix = array[0..2] of Word;
  PStmQWord = ^Int64;

var
  QSL: PTVItemList = nil;
  QSC: TVCollSortCompare;

  RegLdObjIDs: PRegObjIDsList = nil;
  RegLdList: PRegLoadList = nil;
  RegLdCount: Integer = 0;
  RegLdCapacity: Integer = 0;

  RegStClsTypes: PRegClsTypesList = nil;
  RegStObjIDs: PRegObjIDsList = nil;
  RegStCount: Integer = 0;
  RegStCapacity: Integer = 0;

  StB: array[0..255] of Byte;

procedure RaiseTVErr(const Msg: string); forward;
procedure RaiseTVErrS(const Msg, S: string); forward;
procedure RaiseTVErrShS(const Msg: string; const S: ShortString); forward;
procedure RaiseTVErrD(const Msg: string; D: Integer); forward;
procedure RaiseTVErrDS(const Msg: string; D: Integer; const S: string); forward;
procedure RaiseTVErrObj(const Msg: string; Obj: TObject); forward;
procedure RaiseTVErrSObj(const Msg, S: string; Obj: TObject); forward;
procedure RaiseTVErrObjS(const Msg: string; Obj: TObject; const S: string); forward;
procedure RaiseUniqueIndexViolation(const AIndexName: string; Obj: TVObject); forward;
procedure RaiseStrmCreateError(const AFileName: string); forward;
procedure RaiseStrmFileNotFound(const AFileName: string); forward;
procedure RaiseStrmOpenError(const AFileName: string); forward;
procedure RaiseStrmReadError(const AFileName: string); forward;
procedure RaiseStrmDataCorrupted(const AFileName: string); forward;
procedure RaiseStrmWriteError(const AFileName: string); forward;
procedure RaiseStrmSeekError(const AFileName: string); forward;
procedure RaiseLockFileNotFound(const AFileName: string); forward;
procedure RaiseCannotLockFile(const AFileName: string); forward;
procedure RaiseInvalidRangeBounds(Obj: TVObject; const AIndexName: string); forward;

procedure RegisterTVObject(AObjID: Word; AClsType: TVObjectClassType;
  AVersion: Word; AStored: Boolean);
var
  I: Integer;
begin
  I := Q_ScanWord(AObjID,RegLdObjIDs,RegLdCount);
  if I <> -1 then
    with RegLdList^[I] do
    begin
      if ClsType <> AClsType then
        RaiseTVErrD(STVDoubleClassReg,AObjID);
      if Version <> AVersion then
        RaiseTVErrShS(STVDoubleVersionReg,AClsType.ClassName);
      RaiseTVErrShS(STVDoubleRegistration,AClsType.ClassName);
    end;
  for I := 0 to RegLdCount-1 do
    if (RegLdList^[I].ClsType=AClsType) and (RegLdList^[I].Version=AVersion) then
      RaiseTVErrShS(STVDoubleObjIDReg,AClsType.ClassName);
  if RegLdCount = RegLdCapacity then
  begin
    Inc(RegLdCapacity,20);
    ReallocMem(RegLdObjIDs, RegLdCapacity*SizeOf(Word));
    ReallocMem(RegLdList, RegLdCapacity*SizeOf(TRegLoadRec));
  end;
  if RegLdCount > 0 then
  begin
    Q_MoveWords(RegLdObjIDs, @RegLdObjIDs^[1], RegLdCount);
    Q_MoveMem(RegLdList, @RegLdList^[1], RegLdCount*SizeOf(TRegLoadRec));
  end;
  RegLdObjIDs^[0] := AObjID;
  with RegLdList^[0] do
  begin
    ClsType := AClsType;
    Version := AVersion;
  end;
  Inc(RegLdCount);
  if AStored then
  begin
    if Q_ScanPointer(Pointer(AClsType),RegStClsTypes,RegStCount) <> -1 then
      RaiseTVErrShS(STVDoubleStoredReg,AClsType.ClassName);
    if RegStCount = RegStCapacity then
    begin
      Inc(RegStCapacity,20);
      ReallocMem(RegStClsTypes, RegStCapacity*SizeOf(Pointer));
      ReallocMem(RegStObjIDs, RegStCapacity*SizeOf(Word));
    end;
    if RegStCount > 0 then
    begin
      Q_MoveLongs(RegStClsTypes,@RegStClsTypes[1],RegStCount);
      Q_MoveWords(RegStObjIDs,@RegStObjIDs[1],RegStCount);
    end;
    RegStClsTypes^[0] := Pointer(AClsType);
    RegStObjIDs^[0] := AObjID;
    Inc(RegStCount);
  end;
end;

procedure Compare_Collections(OldColl, NewColl: TVUniNumberColl;
  var ChgsRec: PTVChangesRec);
var
  PIR_N1,PIR_N2: PTVIndexRec;
  PIR1,PIR2: PTVIndexRec;
  I,J,I_Last,J_Last: Integer;
  Num1,Num2: Integer;
  Obj1,Obj2: TVUniNumberObj;
  A1,A2: Boolean;
begin
  New(ChgsRec);
  with ChgsRec^ do
  begin
    Ins_New := TVCollection.Create;
    Ins_New.FFreeIOD := False;
    Del_Old := TVCollection.Create;
    Del_Old.FFreeIOD := False;
    Edit_Old := TVCollection.Create;
    Edit_Old.FFreeIOD := False;
    Edit_New := TVCollection.Create;
    Edit_New.FFreeIOD := False;
  end;
  PIR_N1 := OldColl.GetIndexRec(IndexBy_Number,False);
  PIR_N2 := NewColl.GetIndexRec(IndexBy_Number,False);
  A1 := PIR_N1^.Active;
  A2 := PIR_N2^.Active;
  PIR1 := OldColl.CurrIndex;
  PIR2 := NewColl.CurrIndex;
  OldColl.SetCurrIndex(PIR_N1);
  NewColl.SetCurrIndex(PIR_N2);
  I_Last := OldColl.Count-1;
  J_Last := NewColl.Count-1;
  I := 0;
  for J := 0 to J_Last do
  begin
    Obj2 := NewColl.List^[J];
    Num2 := Obj2.Number;
    while (I<=I_Last) and (TVUniNumberObj(OldColl.List^[I]).Number<Num2) do
      Inc(I);
    if I <= I_Last then
    begin
      Obj1 := OldColl.List^[I];
      if Obj1.Number > Num2 then
        ChgsRec^.Ins_New.Add(Obj2)
      else if not Obj2.IsEqual(Obj1) then
      begin
        ChgsRec^.Edit_Old.Add(Obj1);
        ChgsRec^.Edit_New.Add(Obj2);
      end;
    end else
      ChgsRec^.Ins_New.Add(Obj2)
  end;
  J := 0;
  for I := 0 to I_Last do
  begin
    Obj1 := OldColl.List^[I];
    Num1 := Obj1.Number;
    while (J<=J_Last) and (TVUniNumberObj(NewColl.List^[J]).Number<Num1) do
      Inc(J);
    if (J>J_Last) or (TVUniNumberObj(NewColl.List^[J]).Number>Num1) then
      ChgsRec^.Del_Old.Add(Obj1);
  end;
  OldColl.SetCurrIndex(PIR1);
  NewColl.SetCurrIndex(PIR2);
  if not A1 then
    OldColl.DeactivateIndexByPIR(PIR_N1);
  if not A2 then
    NewColl.DeactivateIndexByPIR(PIR_N2);
  with ChgsRec^ do
    Flag := (Ins_New.Count>0) or (Del_Old.Count>0) or (Edit_New.Count>0);
end;

procedure Compare_InsDelCollections(OldColl, NewColl: TVUniNumberColl;
  var ChgsRec: PTVChangesRec);
var
  PIR_N1,PIR_N2: PTVIndexRec;
  PIR1,PIR2: PTVIndexRec;
  I,J,I_Last,J_Last: Integer;
  Num1,Num2: Integer;
  Obj: TVUniNumberObj;
  A1,A2: Boolean;
begin
  New(ChgsRec);
  with ChgsRec^ do
  begin
    Ins_New := TVCollection.Create;
    Ins_New.FFreeIOD := False;
    Del_Old := TVCollection.Create;
    Del_Old.FFreeIOD := False;
    Edit_Old := nil;
    Edit_New := nil;
  end;
  PIR_N1 := OldColl.GetIndexRec(IndexBy_Number,False);
  PIR_N2 := NewColl.GetIndexRec(IndexBy_Number,False);
  A1 := PIR_N1^.Active;
  A2 := PIR_N2^.Active;
  PIR1 := OldColl.CurrIndex;
  PIR2 := NewColl.CurrIndex;
  OldColl.SetCurrIndex(PIR_N1);
  NewColl.SetCurrIndex(PIR_N2);
  I_Last := OldColl.Count-1;
  J_Last := NewColl.Count-1;
  I := 0;
  for J := 0 to J_Last do
  begin
    Obj := NewColl.List^[J];
    Num2 := Obj.Number;
    while (I<=I_Last) and (TVUniNumberObj(OldColl.List^[I]).Number<Num2) do
      Inc(I);
    if (I>I_Last) or (TVUniNumberObj(OldColl.List^[I]).Number>Num2) then
      ChgsRec^.Ins_New.Add(Obj);
  end;
  J := 0;
  for I := 0 to I_Last do
  begin
    Obj := OldColl.List^[I];
    Num1 := Obj.Number;
    while (J<=J_Last) and (TVUniNumberObj(NewColl.List^[J]).Number<Num1) do
      Inc(J);
    if (J>J_Last) or (TVUniNumberObj(NewColl.List^[J]).Number>Num1) then
      ChgsRec^.Del_Old.Add(Obj);
  end;
  OldColl.SetCurrIndex(PIR1);
  NewColl.SetCurrIndex(PIR2);
  if not A1 then
    OldColl.DeactivateIndexByPIR(PIR_N1);
  if not A2 then
    NewColl.DeactivateIndexByPIR(PIR_N2);
  with ChgsRec^ do
    Flag := (Ins_New.Count>0) or (Del_Old.Count>0);
end;

procedure Compare_EditCollections(OldColl, NewColl: TVUniNumberColl;
  var ChgsRec: PTVChangesRec);
var
  PIR_N1,PIR_N2: PTVIndexRec;
  PIR1,PIR2: PTVIndexRec;
  I: Integer;
  Obj1,Obj2: TVUniNumberObj;
  A1,A2: Boolean;
begin
  if OldColl.Count = NewColl.Count then
  begin
    New(ChgsRec);
    with ChgsRec^ do
    begin
      Ins_New := nil;
      Del_Old := nil;
      Edit_Old := TVCollection.Create;
      Edit_Old.FFreeIOD := False;
      Edit_New := TVCollection.Create;
      Edit_New.FFreeIOD := False;
    end;
    PIR_N1 := OldColl.GetIndexRec(IndexBy_Number,False);
    PIR_N2 := NewColl.GetIndexRec(IndexBy_Number,False);
    A1 := PIR_N1^.Active;
    A2 := PIR_N2^.Active;
    PIR1 := OldColl.CurrIndex;
    PIR2 := NewColl.CurrIndex;
    OldColl.SetCurrIndex(PIR_N1);
    NewColl.SetCurrIndex(PIR_N2);
    for I := 0 to OldColl.Count-1 do
    begin
      Obj1 := OldColl.List^[I];
      Obj2 := NewColl.List^[I];
      if not Obj2.IsEqual(Obj1) then
        with ChgsRec^ do
        begin
          Edit_Old.Add(Obj1);
          Edit_New.Add(Obj2);
          Flag := True;
        end;
    end;
    OldColl.SetCurrIndex(PIR1);
    NewColl.SetCurrIndex(PIR2);
    if not A1 then
      OldColl.DeactivateIndexByPIR(PIR_N1);
    if not A2 then
      NewColl.DeactivateIndexByPIR(PIR_N2);
  end else
    RaiseTVErr(STVCollsHaveDiffCount);
end;

procedure Compare_InsCollections(OldColl, NewColl: TVUniNumberColl;
  var ChgsRec: PTVChangesRec);
var
  PIR_N1,PIR_N2: PTVIndexRec;
  PIR1,PIR2: PTVIndexRec;
  I,J,I_Last,J_Last: Integer;
  Num2: Integer;
  Obj: TVUniNumberObj;
  A1,A2: Boolean;
begin
  New(ChgsRec);
  with ChgsRec^ do
  begin
    Ins_New := TVCollection.Create;
    Ins_New.FFreeIOD := False;
    Del_Old := nil;
    Edit_Old := nil;
    Edit_New := nil;
  end;
  PIR_N1 := OldColl.GetIndexRec(IndexBy_Number,False);
  PIR_N2 := NewColl.GetIndexRec(IndexBy_Number,False);
  A1 := PIR_N1^.Active;
  A2 := PIR_N2^.Active;
  PIR1 := OldColl.CurrIndex;
  PIR2 := NewColl.CurrIndex;
  OldColl.SetCurrIndex(PIR_N1);
  NewColl.SetCurrIndex(PIR_N2);
  I_Last := OldColl.Count-1;
  J_Last := NewColl.Count-1;
  I := 0;
  for J := 0 to J_Last do
  begin
    Obj := NewColl.List^[J];
    Num2 := Obj.Number;
    while (I<=I_Last) and (TVUniNumberObj(OldColl.List^[I]).Number<Num2) do
      Inc(I);
    if (I>I_Last) or (TVUniNumberObj(OldColl.List^[I]).Number>Num2) then
      ChgsRec^.Ins_New.Add(Obj);
  end;
  OldColl.SetCurrIndex(PIR1);
  NewColl.SetCurrIndex(PIR2);
  if not A1 then
    OldColl.DeactivateIndexByPIR(PIR_N1);
  if not A2 then
    NewColl.DeactivateIndexByPIR(PIR_N2);
  with ChgsRec^ do
    Flag := Ins_New.Count > 0;
end;

procedure Compare_DelCollections(OldColl, NewColl: TVUniNumberColl;
  var ChgsRec: PTVChangesRec);
var
  PIR_N1,PIR_N2: PTVIndexRec;
  PIR1,PIR2: PTVIndexRec;
  I,J,I_Last,J_Last: Integer;
  Num1: Integer;
  Obj: TVUniNumberObj;
  A1,A2: Boolean;
begin
  New(ChgsRec);
  with ChgsRec^ do
  begin
    Ins_New := nil;
    Del_Old := TVCollection.Create;
    Del_Old.FFreeIOD := False;
    Edit_Old := nil;
    Edit_New := nil;
  end;
  PIR_N1 := OldColl.GetIndexRec(IndexBy_Number,False);
  PIR_N2 := NewColl.GetIndexRec(IndexBy_Number,False);
  A1 := PIR_N1^.Active;
  A2 := PIR_N2^.Active;
  PIR1 := OldColl.CurrIndex;
  PIR2 := NewColl.CurrIndex;
  OldColl.SetCurrIndex(PIR_N1);
  NewColl.SetCurrIndex(PIR_N2);
  I_Last := OldColl.Count-1;
  J_Last := NewColl.Count-1;
  J := 0;
  for I := 0 to I_Last do
  begin
    Obj := OldColl.List^[I];
    Num1 := Obj.Number;
    while (J<=J_Last) and (TVUniNumberObj(NewColl.List^[J]).Number<Num1) do
      Inc(J);
    if (J>J_Last) or (TVUniNumberObj(NewColl.List^[J]).Number>Num1) then
      ChgsRec^.Del_Old.Add(Obj);
  end;
  OldColl.SetCurrIndex(PIR1);
  NewColl.SetCurrIndex(PIR2);
  if not A1 then
    OldColl.DeactivateIndexByPIR(PIR_N1);
  if not A2 then
    NewColl.DeactivateIndexByPIR(PIR_N2);
  with ChgsRec^ do
    Flag := Del_Old.Count > 0;
end;

procedure ReconcileChanges(CurrColl: TVUniNumberColl; ChgsRec: PTVChangesRec);
var
  PIR_N: PTVIndexRec;
  I,Num: Integer;
  Obj: TVUniNumberObj;
  Obj_Old: TVUniNumberObj;
  Obj_New: TVUniNumberObj;
  A: Boolean;
begin
  with ChgsRec^, CurrColl do
  begin
    PIR_N := GetIndexRec(IndexBy_Number,False);
    A := PIR_N^.Active;
    if not A then
      UpdateIndexByPIR(PIR_N);
    Flag := False;
    if Ins_New <> nil then
    begin
      for I := 0 to Ins_New.Count-1 do
      begin
        Obj_New := Ins_New.List^[I];
        Obj := Obj_New.Clone;
        Obj.Number := UniqueNumber;
        Add(Obj);
        Changed := True;
      end;
      Flag := Ins_New.Count > 0;
    end;
    if Del_Old <> nil then
    begin
      for I := Del_Old.Count-1 downto 0 do
      begin
        Num := TVUniNumberObj(Del_Old.List^[I]).Number;
        Obj := SearchObj_Integer(PIR_N,Num);
        if Obj <> nil then
        begin
          DeleteObjAndFree(Obj);
          Changed := True;
        end else
          Del_Old.Delete(I);
      end;
      Flag := Flag or (Del_Old.Count>0);
    end;
    if Edit_New <> nil then
    begin
      for I := Edit_New.Count-1 downto 0 do
      begin
        Obj_Old := Edit_Old.List^[I];
        Obj_New := Edit_New.List^[I];
        Obj := SearchObj_Integer(PIR_N,Obj_Old.Number);
        if Obj <> nil then
        begin
          Obj.Reconcile(Obj_Old, Obj_New);
          Changed := True;
        end else
        begin
          Edit_Old.DeleteObj(Obj_Old);
          Edit_New.DeleteObj(Obj_New);
        end;
      end;
      Flag := Flag or (Edit_New.Count>0);
    end;
    if Changed then
      UpdateIndexes;
    if not A then
      DeactivateIndexByPIR(PIR_N);
  end;
end;

procedure FreeChangesRec(var ChgsRec: PTVChangesRec);
begin
  with ChgsRec^ do
  begin
    Ins_New.Free;
    Del_Old.Free;
    Edit_Old.Free;
    Edit_New.Free;
  end;
  Dispose(ChgsRec);
  ChgsRec := nil;
end;

procedure CreateIndexRec(var APIR: PTVIndexRec);
begin
  New(APIR);
  Q_ZeroMem(APIR,SizeOf(TVIndexRec));
end;

procedure CreateSecurityRec(var Security: PTVProtection);
begin
  GetMem(Security,SizeOf(TVProtection));
  Q_ZeroMem(Security,SizeOf(TVProtection));
end;

procedure FreeSecurityRec(var Security: PTVProtection);
begin
  if Security <> nil then
  begin
    Q_ZeroMem(Security,SizeOf(TVProtection));
    FreeMem(Security,SizeOf(TVProtection));
    Security := nil;
  end;
end;

function GetFileSHA1Digest(const FileName: string; var Digest: TSHA1Digest): Integer;
const
  MapWinSize = 67108864;
type
  TLL = array[0..1] of LongWord;
var
  Handle: THandle;
  FSHigh,FSLow: LongWord;
  OffHigh,OffLow,Cnt: LongWord;
  FSz,Offset: Int64;
  FileFM: THandle;
  DataView: Pointer;
  ID: TSHAID;
begin
  Handle := Windows.CreateFile(PChar(FileName),GENERIC_READ,
    FILE_SHARE_READ,nil,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0);
  if Handle = INVALID_HANDLE_VALUE then
  begin
    Result := fgCannotOpenFile;
    Exit;
  end;
  FSLow := GetFileSize(Handle,@FSHigh);
  if (FSLow=$FFFFFFFF) and (GetLastError<>NO_ERROR) then
  begin
    Result := fgWrongFileSize;
    CloseHandle(Handle);
    Exit;
  end;
  FileFM := CreateFileMapping(Handle,nil,PAGE_READONLY,0,0,nil);
  if FileFM = 0 then
  begin
    Result := fgCannotMapFile;
    CloseHandle(Handle);
    Exit;
  end;
  Q_SHA1Init(ID);
  TLL(FSz)[0] := FSLow;
  TLL(FSz)[1] := FSHigh;
  Offset := 0;
  repeat
    OffLow := TLL(Offset)[0];
    OffHigh := TLL(Offset)[1];
    if FSz > MapWinSize then
    begin
      Cnt := MapWinSize;
      Inc(Offset,Cnt);
    end else
      Cnt := TLL(FSz)[0];
    DataView := MapViewOfFile(FileFM,FILE_MAP_READ,OffHigh,OffLow,Cnt);
    if DataView = nil then
    begin
      Q_SHA1Final(ID,Digest);
      CloseHandle(FileFM);
      CloseHandle(Handle);
      Result := fgCannotMapFile;
      Exit;
    end;
    Q_SHA1Update(ID,DataView,Cnt);
    UnmapViewOfFile(DataView);
    Dec(FSz,Cnt);
  until FSz = 0;
  Q_SHA1Final(ID,Digest);
  CloseHandle(FileFM);
  CloseHandle(Handle);
  Result := fgNoError;
end;

function GetFileMixDigest(const FileName: string; var Digest: TMixDigest): Integer;
const
  MapWinSize = 67108864;
type
  TLL = array[0..1] of LongWord;
var
  Handle: THandle;
  FSHigh,FSLow: LongWord;
  OffHigh,OffLow,Cnt: LongWord;
  FSz,Offset: Int64;
  FileFM: THandle;
  DataView: Pointer;
  ID: TMixID;
begin
  Handle := Windows.CreateFile(PChar(FileName),GENERIC_READ,
    FILE_SHARE_READ,nil,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0);
  if Handle = INVALID_HANDLE_VALUE then
  begin
    Result := fgCannotOpenFile;
    Exit;
  end;
  FSLow := GetFileSize(Handle,@FSHigh);
  if (FSLow=$FFFFFFFF) and (GetLastError<>NO_ERROR) then
  begin
    Result := fgWrongFileSize;
    CloseHandle(Handle);
    Exit;
  end;
  FileFM := CreateFileMapping(Handle,nil,PAGE_READONLY,0,0,nil);
  if FileFM = 0 then
  begin
    Result := fgCannotMapFile;
    CloseHandle(Handle);
    Exit;
  end;
  Q_MixHashInit(ID);
  TLL(FSz)[0] := FSLow;
  TLL(FSz)[1] := FSHigh;
  Offset := 0;
  repeat
    OffLow := TLL(Offset)[0];
    OffHigh := TLL(Offset)[1];
    if FSz > MapWinSize then
    begin
      Cnt := MapWinSize;
      Inc(Offset,Cnt);
    end else
      Cnt := TLL(FSz)[0];
    DataView := MapViewOfFile(FileFM,FILE_MAP_READ,OffHigh,OffLow,Cnt);
    if DataView = nil then
    begin
      Q_MixHashFinal(ID,Digest);
      CloseHandle(FileFM);
      CloseHandle(Handle);
      Result := fgCannotMapFile;
      Exit;
    end;
    Q_MixHashUpdate(ID,DataView,Cnt);
    UnmapViewOfFile(DataView);
    Dec(FSz,Cnt);
  until FSz = 0;
  Q_MixHashFinal(ID,Digest);
  CloseHandle(FileFM);
  CloseHandle(Handle);
  Result := fgNoError;
end;

{ TVObject }

constructor TVObject.Create;
begin
end;

constructor TVObject.Load(S: TVStream; Version: Word);
begin
end;

procedure TVObject.Store(S: TVStream);
begin
end;

function TVObject.Clone: Pointer;
begin
  Result := TVObjectClassType(ClassType).Create;
end;

{ TVIndexCollection }

destructor TVIndexCollection.Destroy;
var
  I: Integer;
  PIR: PTVIndexRec;
begin
  for I := 0 to FCount-1 do
  begin
    PIR := FList^[I];
    if PIR^.Active then
      FreeMem(PIR^.IndList);
    Finalize(PIR^);
    Dispose(PIR);
  end;
  FreeMem(FList);
end;

procedure TVIndexCollection.Add(PIR: PTVIndexRec);
var
  L,H,I,C: Integer;
begin
  L := 0;
  H := FCount - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := Q_CompText(FList^[I]^.IndName, PIR^.IndName);
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
        RaiseTVErrS(STVDoubleIndexName, PIR^.IndName);
    end;
  end;
  if FCount = FCapacity then
  begin
    if FCapacity > 64 then
      Inc(FCapacity, FCapacity shr 2)
    else if FCapacity > 8 then
      Inc(FCapacity, 16)
    else
      Inc(FCapacity, 4);
     ReallocMem(FList, FCapacity * SizeOf(PTVIndexRec));
  end;
  if L < FCount then
    Q_MoveLongs(@FList^[L], @FList^[L + 1], FCount-L);
  FList^[L] := PIR;
  Inc(FCount);
end;

procedure TVIndexCollection.DeleteAndFree(PIR: PTVIndexRec);
var
  I: Integer;
begin
  for I := 0 to FCount-1 do
    if FList^[I] = PIR then
    begin
      if PIR^.Active then
        FreeMem(PIR^.IndList);
      Finalize(PIR^);
      Dispose(PIR);
      Dec(FCount);
      if I < FCount then
        Q_MoveLongs(@FList^[I + 1], @FList^[I], FCount-I);
      Exit;
    end;
  RaiseTVErrS(STVIndexNotFound, PIR^.IndName);
end;

function TVIndexCollection.Find(const S: string): PTVIndexRec;
var
  L,H,I,C: Integer;
begin
  L := 0;
  H := FCount - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := Q_CompText(FList^[I]^.IndName, S);
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := FList^[I];
        Exit;
      end;
    end;
  end;
  RaiseTVErrS(STVIndexNotFound, S);
  Result := nil;
end;

{ TVUniCollection }

var
  CollFields: packed record
    fldCount: SmallInt;
    fldLimit: SmallInt;
    fldDelta: SmallInt;
  end;

  BigCollFields: packed record
    fldBigFlag: SmallInt;
    fldCount: Integer;
    fldCapacity: Integer;
  end;

procedure QuickSortAsc(L, R: Integer);
var
  I, J: Integer;
  P, T: Pointer;
begin
  repeat
    I := L;
    J := R;
    P := QSL^[(L + R) shr 1];
    repeat
      while QSC(QSL^[I], P) < 0 do Inc(I);
      while QSC(QSL^[J], P) > 0 do Dec(J);
      if I <= J then
      begin
        T := QSL^[I];
        QSL^[I] := QSL^[J];
        QSL^[J] := T;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSortAsc(L, J);
    L := I;
  until I >= R;
end;

procedure QuickSortDesc(L, R: Integer);
var
  I, J: Integer;
  P, T: Pointer;
begin
  repeat
    I := L;
    J := R;
    P := QSL^[(L + R) shr 1];
    repeat
      while QSC(QSL^[I], P) > 0 do Inc(I);
      while QSC(QSL^[J], P) < 0 do Dec(J);
      if I <= J then
      begin
        T := QSL^[I];
        QSL^[I] := QSL^[J];
        QSL^[J] := T;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSortDesc(L, J);
    L := I;
  until I >= R;
end;

procedure TVUniCollection.Clear;
begin
  FCount := 0;
  SetCapacity(0);
end;

procedure TVUniCollection.ClearAndFreeItems;
var
  I: Integer;
begin
  for I := 0 to FCount-1 do
    FreeItem(FList^[I]);
  FCount := 0;
  SetCapacity(0);
end;

procedure TVUniCollection.ClearLights;
begin
  FCount := 0;
end;

procedure TVUniCollection.ClearAndFreeItemsLights;
var
  I: Integer;
begin
  for I := 0 to FCount-1 do
    FreeItem(FList^[I]);
  FCount := 0;
end;

function TVUniCollection.Clone: Pointer;
var
  P: TVUniCollection;
  PIR: PTVIndexRec;
  I: Integer;
begin
  P := TVUniCollection(inherited Clone);
  P.FBig := FBig;
  P.FCount := FCount;
  P.SetCapacity(FCapacity);
  P.FFreeIOD := FFreeIOD;
  if FBin <> nil then
    P.FBin := TVUniCollection(FBin.Clone);
  if FCount > 0 then
  begin
    if FFreeIOD then
      for I := 0 to FCount-1 do
        P.FList^[I] := CloneItem(FList^[I])
    else
      Q_CopyLongs(FList, P.FList, FCount);
    with P do
      for I := 0 to FIndexes.FCount-1 do
      begin
        PIR := FIndexes.FList^[I];
        if PIR^.Active then
        begin
          if PIR <> FCurrentIndex then
            Q_CopyLongs(FList,PIR^.IndList,FCount);
          UpdateIndexByPIR(PIR);
        end;
      end;
  end;
  Result := P;
end;

function TVUniCollection.CloneItem(Item: Pointer): Pointer;
begin
  Result := TVObject(Item).Clone;
end;

constructor TVUniCollection.Create;
begin
  FFreeIOD := True;
  FBig := True;
end;

procedure TVUniCollection.Delete(Index: Integer; ToBin: Boolean);
var
  I: Integer;
  PIR: PTVIndexRec;
  P: Pointer;
  CanDel: Boolean;
begin
  if (Index >= 0) and (Index < FCount) then
  begin
    P := FList^[Index];
    CanDel := True;
    DoAskForDelete(P,CanDel,ToBin);
    if CanDel then
    begin
      DoDeleteItem(P);
      for I := 0 to FIndexes.FCount-1 do
      begin
        PIR := FIndexes.FList^[I];
        if (PIR<>FCurrentIndex) and PIR^.Active then
          DeleteFromIndex(PIR,P);
      end;
      Dec(FCount);
      if Index < FCount then
        Q_MoveLongs(@FList^[Index+1], @FList^[Index], FCount-Index);
      if ToBin then
      begin
        if FBin = nil then
        begin
          FBin := TVUniCollection(TVObjectClassType(ClassType).Create);
          FBin.FFreeIOD := FFreeIOD;
          FBin.FBig := True;
        end;
        FBin.Add(P);
      end;
    end;
  end else
    RaiseTVErrD(STVCollIndexError, Index);
end;

procedure TVUniCollection.DeleteAndFree(Index: Integer);
var
  I: Integer;
  PIR: PTVIndexRec;
  P: Pointer;
  CanDel,ToBin: Boolean;
begin
  if (Index >= 0) and (Index < FCount) then
  begin
    P := FList^[Index];
    CanDel := True;
    ToBin := False;
    DoAskForDelete(P,CanDel,ToBin);
    if CanDel then
    begin
      DoDeleteItem(P);
      for I := 0 to FIndexes.FCount-1 do
      begin
        PIR := FIndexes.FList^[I];
        if (PIR<>FCurrentIndex) and PIR^.Active then
          DeleteFromIndex(PIR,P);
      end;
      Dec(FCount);
      if Index < FCount then
        Q_MoveLongs(@FList^[Index+1], @FList^[Index], FCount-Index);
      if ToBin then
      begin
        if FBin = nil then
        begin
          FBin := TVUniCollection(TVObjectClassType(ClassType).Create);
          FBin.FFreeIOD := FFreeIOD;
        end;
        FBin.Add(P);
      end else
        FreeItem(P);
    end;
  end else
    RaiseTVErrD(STVCollIndexError, Index);
end;

procedure TVUniCollection.DeleteObj(Item: Pointer; ToBin: Boolean);
var
  I: Integer;
  PIR: PTVIndexRec;
  CanDel: Boolean;
begin
  if Item = nil then
    RaiseTVErrObj(STVTryToDeleteNil, Self);
  CanDel := True;
  DoAskForDelete(Item,CanDel,ToBin);
  if CanDel then
  begin
    DoDeleteItem(Item);
    for I := 0 to FIndexes.FCount-1 do
    begin
      PIR := FIndexes.FList^[I];
      if PIR^.Active then
        DeleteFromIndex(PIR,Item);
    end;
    Dec(FCount);
    if ToBin then
    begin
      if FBin = nil then
      begin
        FBin := TVUniCollection(TVObjectClassType(ClassType).Create);
        FBin.FFreeIOD := FFreeIOD;
      end;
      FBin.Add(Item);
    end;
  end;
end;

procedure TVUniCollection.DeleteObjAndFree(Item: Pointer);
var
  I: Integer;
  PIR: PTVIndexRec;
  CanDel,ToBin: Boolean;
begin
  if Item = nil then
    RaiseTVErrObj(STVTryToDeleteNil, Self);
  CanDel := True;
  ToBin := False;
  DoAskForDelete(Item,CanDel,ToBin);
  if CanDel then
  begin
    DoDeleteItem(Item);
    for I := 0 to FIndexes.FCount-1 do
    begin
      PIR := FIndexes.FList^[I];
      if PIR^.Active then
        DeleteFromIndex(PIR,Item);
    end;
    Dec(FCount);
    if ToBin then
    begin
      if FBin = nil then
      begin
        FBin := TVUniCollection(TVObjectClassType(ClassType).Create);
        FBin.FFreeIOD := FFreeIOD;
      end;
      FBin.Add(Item);
    end else
      FreeItem(Item);
  end;
end;

destructor TVUniCollection.Destroy;
begin
  FBin.Free;
  if FFreeIOD then
    ClearAndFreeItems
  else
    Clear;
  FIndexes.Free;
end;

function TVUniCollection.First: Pointer;
begin
  if FCount <= 0 then
    RaiseTVErrD(STVCollIndexError, 0);
  Result := FList^[0];
end;

procedure TVUniCollection.FreeItem(Item: Pointer);
begin
  TVObject(Item).Free;
end;

function TVUniCollection.Get(Index: Integer): Pointer;
begin
  if (Index<0) or (Index>=FCount) then
    RaiseTVErrD(STVCollIndexError, Index);
  Result := FList^[Index];
end;

function TVUniCollection.GetItem(S: TVStream): Pointer;
begin
  Result := S.Get;
end;

procedure TVUniCollection.Grow;
begin
  if FCapacity > 64 then
    SetCapacity(FCapacity + FCapacity shr 2)
  else if FCapacity > 8 then
    SetCapacity(FCapacity + 16)
  else
    SetCapacity(FCapacity + 4);
end;

function TVUniCollection.IndexOf(Item: Pointer): Integer;
begin
  Result := IndexOfByIndex(FCurrentIndex,Item);
end;

function TVUniCollection.Last: Pointer;
begin
  if FCount <= 0 then
    RaiseTVErrD(STVCollIndexError, -1);
  Result := FList^[FCount-1];
end;

procedure TVUniCollection.PutItem(S: TVStream; Item: Pointer);
begin
  S.Put(TVObject(Item));
end;

procedure TVUniCollection.UpdateLink(const LinkID: string; AColl: TVUniCollection);
begin
end;

procedure TVUniCollection.RemoveLink(const LinkID: string);
begin
end;

procedure TVUniCollection.AddIndex(PIR: PTVIndexRec; SwitchTo: Boolean);
begin
  with PIR^ do
    if not Regular and Unique then
      RaiseTVErrS(STVNotRegularButUnique, IndName);
  if FIndexes = nil then
    FIndexes := TVIndexCollection.Create;
  FIndexes.Add(PIR);
  if PIR^.Active or SwitchTo then
  begin
    PIR^.Active := False;
    UpdateIndexByPIR(PIR);
    if SwitchTo then
    begin
      FCurrentIndex := PIR;
      FList := PIR^.IndList;
    end;
  end else
    PIR^.IndList := nil;
end;

procedure TVUniCollection.ActivateAllIndexes;
var
  I: Integer;
  PIR: PTVIndexRec;
begin
  for I := 0 to FIndexes.FCount-1 do
  begin
    PIR := FIndexes.FList^[I];
    if not PIR^.Active then
      UpdateIndexByPIR(PIR);
  end;
end;

procedure TVUniCollection.DeactivateAllIndexes;
var
  I: Integer;
  PIR: PTVIndexRec;
begin
  for I := 0 to FIndexes.FCount-1 do
  begin
    PIR := FIndexes.FList^[I];
    if (PIR<>FCurrentIndex) and (PIR^.Active) then
      with PIR^ do
      begin
        FreeMem(IndList);
        IndList := nil;
        Active := False;
      end;
  end;
end;

procedure TVUniCollection.DeleteIndex(const AIndName: string);
var
  PIR: PTVIndexRec;
begin
  PIR := FIndexes.Find(AIndName);
  if PIR <> FCurrentIndex then
    FIndexes.DeleteAndFree(PIR)
  else
    RaiseTVErrS(STVTryToDelCurrIndex, AIndName);
end;

function TVUniCollection.GetIndexList(const AIndName: string): PTVItemList;
var
  PIR: PTVIndexRec;
begin
  PIR := FIndexes.Find(AIndName);
  if not PIR^.Active then
    UpdateIndexByPIR(PIR);
  Result := PIR^.IndList;
end;

procedure TVUniCollection.ActivateIndex(const AIndName: string);
var
  PIR: PTVIndexRec;
begin
  PIR := FIndexes.Find(AIndName);
  if not PIR^.Active then
    UpdateIndexByPIR(PIR);
end;

procedure TVUniCollection.DeactivateIndex(const AIndName: string);
begin
  DeactivateIndexByPIR(FIndexes.Find(AIndName));
end;

procedure TVUniCollection.SwitchToIndex(const AIndName: string);
begin
  SetCurrIndex(FIndexes.Find(AIndName));
end;

procedure TVUniCollection.UpdateIndexes;
var
  I: Integer;
  PIR: PTVIndexRec;
begin
  for I := 0 to FIndexes.FCount-1 do
  begin
    PIR := FIndexes.FList^[I];
    if PIR^.Active then
      UpdateIndexByPIR(PIR);
  end;
end;

procedure TVUniCollection.UpdateIndex(const AIndName: string);
begin
  UpdateIndexByPIR(FIndexes.Find(AIndName))
end;

function TVUniCollection.AddToIndex(PIR: PTVIndexRec; Item: Pointer): Integer;
var
  L,H,I,C: Integer;
begin
  with PIR^ do
    if not Regular then
    begin
      IndList^[FCount] := Item;
      Result := FCount;
    end else
    begin
      L := 0;
      H := FCount - 1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := IndCompare(IndList^[I], Item);
          if C < 0 then
            L := I + 1
          else
          begin
            if (C=0) and Unique then
              RaiseUniqueIndexViolation(IndName, Self);
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := IndCompare(IndList^[I], Item);
          if C > 0 then
            L := I + 1
          else
          begin
            if (C=0) and Unique then
              RaiseUniqueIndexViolation(IndName, Self);
            H := I - 1;
          end;
        end;
      if L < FCount then
        Q_MoveLongs(@IndList^[L], @IndList^[L+1], FCount-L);
      IndList^[L] := Item;
      Result := L;
    end;
end;

procedure TVUniCollection.DeleteFromIndex(PIR: PTVIndexRec; Item: Pointer);
var
  L: Integer;
begin
  L := IndexOfByIndex(PIR,Item);
  if L <> -1 then
  begin
    if L < FCount-1 then
      Q_MoveLongs(@PIR^.IndList^[L+1], @PIR^.IndList^[L], FCount-L-1);
  end
  else if PIR = FCurrentIndex then
    RaiseTVErr(STVCollItemNotFound)
  else
    RaiseTVErrSObj(STVIndexCorrupted, PIR^.IndName, Self);
end;

function TVUniCollection.IndexOfByIndex(PIR: PTVIndexRec;
  Item: Pointer): Integer;
var
  L,H,I,C: Integer;
begin
  if not PIR^.Active then
    UpdateIndexByPIR(PIR);
  if (FCount<=200) or not PIR^.Regular then
    Result := Q_ScanPointer(Item,PIR^.IndList,FCount)
  else
    with PIR^ do
    begin
      L := 0;
      H := FCount - 1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := IndCompare(IndList^[I], Item);
          if C < 0 then
            L := I + 1
          else
          begin
            if (C=0) and Unique then
            begin
              if IndList^[I] = Item then
                Result := I
              else
                Result := -1;
              Exit;
            end;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := IndCompare(IndList^[I], Item);
          if C > 0 then
            L := I + 1
          else
          begin
            if (C=0) and Unique then
            begin
              if IndList^[I] = Item then
                Result := I
              else
                Result := -1;
              Exit;
            end;
            H := I - 1;
          end;
        end;
      while L < FCount do
      begin
        if IndList^[L] = Item then
        begin
          Result := L;
          Exit;
        end;
        if IndCompare(IndList^[L], Item) <> 0 then
          Break;
        Inc(L);
      end;
      Result := -1;
    end;
end;

procedure TVUniCollection.UpdateIndexByPIR(PIR: PTVIndexRec);
begin
  if not PIR^.Active then
  begin
    if FCapacity > 0 then
    begin
      GetMem(PIR^.IndList, FCapacity*SizeOf(Pointer));
      Q_CopyLongs(FList,PIR^.IndList,FCount);
    end;
    PIR^.Active := True;
  end;
  if (FCount>1) and (PIR^.Regular) then
  begin
    QSL := PIR^.IndList;
    QSC := PIR^.IndCompare;
    if not PIR^.Descending then
      QuickSortAsc(0, FCount-1)
    else
      QuickSortDesc(0, FCount-1);
    QSL := nil;
  end;
end;

function TVUniCollection.GetIndexRec(const AIndName: string;
  Activate: Boolean): PTVIndexRec;
begin
  Result := FIndexes.Find(AIndName);
  if Activate and not Result^.Active then
    UpdateIndexByPIR(Result);
end;

procedure TVUniCollection.SetCurrIndex(PIR: PTVIndexRec);
begin
  if not PIR^.Active then
    UpdateIndexByPIR(PIR);
  FCurrentIndex := PIR;
  FList := PIR^.IndList;
end;

constructor TVUniCollection.Load(S: TVStream; Version: Word);
var
  I,Cnt: Integer;
  PIR: PTVIndexRec;
  W: SmallInt;
begin
  if Version = 1 then
  begin
    Create;
    S.Read(W, 2);
    if W = -1 then
    begin
      S.Read(Cnt,SizeOf(Cnt));
      S.Read(I,SizeOf(I));
      SetCapacity(I);
      FBin := TVUniCollection(S.Get);
    end else
    begin
      FBig := False;
      Cnt := W;
      S.Read(I,SizeOf(I));
      SetCapacity(I and $7FFF);
    end;
    FCount := 0;
    for I := 0 to Cnt - 1 do
    begin
      FList^[FCount] := GetItem(S);
      if FList^[FCount] <> nil then
        Inc(FCount);
    end;
    if FCount > 0 then
      for I := 0 to FIndexes.FCount-1 do
      begin
        PIR := FIndexes.FList^[I];
        if PIR^.Active then
        begin
          if PIR <> FCurrentIndex then
            Q_CopyLongs(FList,PIR^.IndList,FCount);
          UpdateIndexByPIR(PIR);
        end;
      end;
  end else
    RaiseVersionNotSupported(Self, Version);
end;

procedure TVUniCollection.SetCapacity(NewCapacity: Integer);
var
  I: Integer;
  PIR: PTVIndexRec;
begin
  if NewCapacity <> FCapacity then
    if (NewCapacity >= FCount) and ((NewCapacity <= MaxTVCompatibleCollSize) or
      (FBig and (NewCapacity <= MaxCollectionSize))) then
    begin
      FCapacity := NewCapacity;
      for I := 0 to FIndexes.FCount-1 do
      begin
        PIR := FIndexes.FList^[I];
        if PIR^.Active then
          ReallocMem(PIR^.IndList, NewCapacity*SizeOf(Pointer));
      end;
      if FCurrentIndex <> nil then
        FList := FCurrentIndex^.IndList;
    end else
      RaiseTVErrD(STVCollCapacityError, NewCapacity);
end;

procedure TVUniCollection.Store(S: TVStream);
var
  I: Integer;
begin
  if FBig then
  begin
    with BigCollFields do
    begin
      fldBigFlag := -1;
      fldCount := FCount;
      fldCapacity := FCapacity;
    end;
    S.Write(BigCollFields,SizeOf(BigCollFields));
    S.Put(FBin);
  end else
  begin
    with CollFields do
    begin
      fldCount := SmallInt(FCount);
      fldLimit := SmallInt(FCapacity);
      if FCapacity > 64 then
        fldDelta := FCapacity shr 2
      else if FCapacity > 8 then
        fldDelta := 16
      else
        fldDelta := 4;
    end;
    S.Write(CollFields, 6);
  end;
  for I := 0 to FCount-1 do
    PutItem(S,FList^[I]);
end;


procedure TVUniCollection.DoInsertItem(Item: Pointer);
begin
  if Assigned(FOnInsertItem) then
    FOnInsertItem(Self,Item);
end;

procedure TVUniCollection.DoDeleteItem(Item: Pointer);
begin
  if Assigned(FOnDeleteItem) then
    FOnDeleteItem(Self,Item);
end;

procedure TVUniCollection.DoAskForDelete(Item: Pointer; var CanDelete,
  DeleteToBin: Boolean);
begin
  if Assigned(FOnAskForDelete) then
    FOnAskForDelete(Self,Item,CanDelete,DeleteToBin);
end;

procedure TVUniCollection.DoAskForInsert(Item: Pointer;
  var CanInsert: Boolean);
begin
  if Assigned(FOnAskForInsert) then
    FOnAskForInsert(Self,Item,CanInsert);
end;

procedure TVUniCollection.DoSetChanged(Value: Boolean);
begin
  if Assigned(FOnSetChanged) then
    FOnSetChanged(Self, Value);
end;

function TVUniCollection.Add(Item: Pointer): Integer;
var
  I: Integer;
  PIR: PTVIndexRec;
  CanIns: Boolean;
begin
  Result := -1;
  if Item = nil then
    RaiseTVErrObj(STVTryToInsertNil, Self);
  CanIns := True;
  DoAskForInsert(Item,CanIns);
  if CanIns then
  begin
    if FCount = FCapacity then
      Grow;
    for I := 0 to FIndexes.FCount-1 do
    begin
      PIR := FIndexes.FList^[I];
      if PIR^.Active then
        if PIR = FCurrentIndex then
          Result := AddToIndex(PIR,Item)
        else
          AddToIndex(PIR,Item);
    end;
    Inc(FCount);
    DoInsertItem(Item);
  end;
end;

procedure TVUniCollection.Exchange(Index1, Index2: Integer);
var
  Temp: Pointer;
begin
  if (Index1 >= 0) and (Index1 < FCount) and
     (Index2 >= 0) and (Index2 < FCount) and
     not FCurrentIndex^.Regular then
  begin
    Temp := FList^[Index1];
    FList^[Index1] := FList^[Index2];
    FList^[Index2] := Temp;
  end
  else if FCurrentIndex^.Regular then
    RaiseTVErr(STVInvalidDueToRegularIndex)
  else if (Index1 < 0) or (Index1 >= FCount) then
    RaiseTVErrD(STVCollIndexError, Index1)
  else
    RaiseTVErrD(STVCollIndexError, Index2);
end;

procedure TVUniCollection.Insert(Index: Integer; Item: Pointer);
var
  I: Integer;
  PIR: PTVIndexRec;
  CanIns: Boolean;
begin
  if Item = nil then
    RaiseTVErrObj(STVTryToInsertNil, Self);
  if FCurrentIndex^.Regular then
    RaiseTVErr(STVInvalidDueToRegularIndex);
  if (Index >= 0) and (Index <= FCount) then
  begin
    CanIns := True;
    DoAskForInsert(Item,CanIns);
    if CanIns then
    begin
      if FCount = FCapacity then
        Grow;
      for I := 0 to FIndexes.FCount-1 do
      begin
        PIR := FIndexes.FList^[I];
        if (PIR<>FCurrentIndex) and PIR^.Active then
          AddToIndex(PIR,Item);
      end;
      if Index < FCount then
        Q_MoveLongs(@FList^[Index], @FList^[Index+1], FCount-Index);
      FList^[Index] := Item;
      Inc(FCount);
      DoInsertItem(Item);
    end;
  end else
    RaiseTVErrD(STVCollIndexError, Index);
end;

procedure TVUniCollection.Move(CurIndex, NewIndex: Integer);
var
  P: Pointer;
begin
  if FCurrentIndex^.Regular then
    RaiseTVErr(STVInvalidDueToRegularIndex);
  if (CurIndex>=0) and (CurIndex<FCount) and
    (NewIndex>=0) and (NewIndex<FCount) then
  begin
    if CurIndex <> NewIndex then
    begin
      P := FList^[CurIndex];
      Dec(FCount);
      if CurIndex < FCount then
        Q_MoveLongs(@FList^[CurIndex+1], @FList^[CurIndex], FCount-CurIndex);
      if NewIndex < FCount then
        Q_MoveLongs(@FList^[NewIndex], @FList^[NewIndex+1], FCount-NewIndex);
      Inc(FCount);
      FList^[NewIndex] := P;
    end;
  end
  else if (CurIndex<0) or (CurIndex>=FCount) then
    RaiseTVErrD(STVCollIndexError, CurIndex)
  else
    RaiseTVErrD(STVCollIndexError, NewIndex);
end;

procedure TVUniCollection.Sort(ACompare: TVCollSortCompare; ADesc: Boolean);
begin
  if not FCurrentIndex^.Regular then
  begin
    if FCount > 1 then
    begin
      QSL := FList;
      QSC := ACompare;
      if not ADesc then
        QuickSortAsc(0, FCount-1)
      else
        QuickSortDesc(0, FCount-1);
      QSL := nil;
    end;
  end else
    RaiseTVErr(STVInvalidDueToRegularIndex);
end;

procedure TVUniCollection.ReverseItems;
begin
  if not FCurrentIndex^.Regular then
    Q_ReverseLongArr(FList, FCount)
  else
    RaiseTVErr(STVInvalidDueToRegularIndex);
end;

procedure TVUniCollection.DeactivateIndexByPIR(PIR: PTVIndexRec);
begin
  if PIR <> FCurrentIndex then
    with PIR^ do
    begin
      if Active then
      begin
        FreeMem(IndList);
        IndList := nil;
        Active := False;
      end;
    end
  else
    RaiseTVErrS(STVDeactiveCurrIndex, PIR^.IndName);
end;

function TVUniCollection.SearchIndex_Cardinal(PIR: PTVIndexRec;
  AKey: Cardinal): Integer;
var
  L,H,I: Integer;
  C: Cardinal;
begin
  with PIR^ do
  begin
    if IndType <> itCardinal then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    if not Regular then
    begin
      for I := 0 to FCount-1 do
        if KeyOf_Cardinal(IndList^[I]) <> AKey then
          Continue
        else
        begin
          Result := I;
          Exit;
        end;
      Result := -1;
    end else
    begin
      L := 0;
      H := FCount - 1;
      Result := -1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Cardinal(IndList^[I]);
          if C < AKey then
            L := I + 1
          else
          begin
            if C = AKey then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Cardinal(IndList^[I]);
          if C > AKey then
            L := I + 1
          else
          begin
            if C = AKey then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end;
    end;
  end;
end;

function TVUniCollection.SearchIndex_Comp(PIR: PTVIndexRec;
  AKey: Comp): Integer;
var
  L,H,I: Integer;
  C: Comp;
begin
  with PIR^ do
  begin
    if IndType <> itComp then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    if not Regular then
    begin
      for I := 0 to FCount-1 do
        if KeyOf_Comp(IndList^[I]) <> AKey then
          Continue
        else
        begin
          Result := I;
          Exit;
        end;
      Result := -1;
    end else
    begin
      L := 0;
      H := FCount - 1;
      Result := -1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Comp(IndList^[I]);
          if C < AKey then
            L := I + 1
          else
          begin
            if C = AKey then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Comp(IndList^[I]);
          if C > AKey then
            L := I + 1
          else
          begin
            if C = AKey then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end;
    end;
  end;
end;

function TVUniCollection.SearchIndex_Currency(PIR: PTVIndexRec;
  AKey: Currency): Integer;
var
  L,H,I: Integer;
  C: Currency;
begin
  with PIR^ do
  begin
    if IndType <> itCurrency then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    if not Regular then
    begin
      for I := 0 to FCount-1 do
        if KeyOf_Currency(IndList^[I]) <> AKey then
          Continue
        else
        begin
          Result := I;
          Exit;
        end;
      Result := -1;
    end else
    begin
      L := 0;
      H := FCount - 1;
      Result := -1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Currency(IndList^[I]);
          if C < AKey then
            L := I + 1
          else
          begin
            if C = AKey then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Currency(IndList^[I]);
          if C > AKey then
            L := I + 1
          else
          begin
            if C = AKey then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end;
    end;
  end;
end;

function TVUniCollection.SearchIndex_Double(PIR: PTVIndexRec;
  AKey: Double): Integer;
var
  L,H,I: Integer;
  C: Double;
begin
  with PIR^ do
  begin
    if IndType <> itDouble then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    if not Regular then
    begin
      for I := 0 to FCount-1 do
        if KeyOf_Double(IndList^[I]) <> AKey then
          Continue
        else
        begin
          Result := I;
          Exit;
        end;
      Result := -1;
    end else
    begin
      L := 0;
      H := FCount - 1;
      Result := -1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Double(IndList^[I]);
          if C < AKey then
            L := I + 1
          else
          begin
            if C = AKey then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Double(IndList^[I]);
          if C > AKey then
            L := I + 1
          else
          begin
            if C = AKey then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end;
    end;
  end;
end;

function TVUniCollection.SearchIndex_Extended(PIR: PTVIndexRec;
  AKey: Extended): Integer;
var
  L,H,I: Integer;
  C: Extended;
begin
  with PIR^ do
  begin
    if IndType <> itExtended then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    if not Regular then
    begin
      for I := 0 to FCount-1 do
        if KeyOf_Extended(IndList^[I]) <> AKey then
          Continue
        else
        begin
          Result := I;
          Exit;
        end;
      Result := -1;
    end else
    begin
      L := 0;
      H := FCount - 1;
      Result := -1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Extended(IndList^[I]);
          if C < AKey then
            L := I + 1
          else
          begin
            if C = AKey then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Extended(IndList^[I]);
          if C > AKey then
            L := I + 1
          else
          begin
            if C = AKey then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end;
    end;
  end;
end;

function TVUniCollection.SearchIndex_Int64(PIR: PTVIndexRec;
  AKey: Int64): Integer;
var
  L,H,I: Integer;
  C: Int64;
begin
  with PIR^ do
  begin
    if IndType <> itInt64 then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    if not Regular then
    begin
      for I := 0 to FCount-1 do
        if KeyOf_Int64(IndList^[I]) <> AKey then
          Continue
        else
        begin
          Result := I;
          Exit;
        end;
      Result := -1;
    end else
    begin
      L := 0;
      H := FCount - 1;
      Result := -1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Int64(IndList^[I])-AKey;
          if C < 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Int64(IndList^[I])-AKey;
          if C > 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end;
    end;
  end;
end;

function TVUniCollection.SearchIndex_Integer(PIR: PTVIndexRec;
  AKey: Integer): Integer;
var
  L,H,I: Integer;
  C: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itInteger then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    if not Regular then
    begin
      for I := 0 to FCount-1 do
        if KeyOf_Integer(IndList^[I]) <> AKey then
          Continue
        else
        begin
          Result := I;
          Exit;
        end;
      Result := -1;
    end else
    begin
      L := 0;
      H := FCount - 1;
      Result := -1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Integer(IndList^[I])-AKey;
          if C < 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Integer(IndList^[I])-AKey;
          if C > 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end;
    end;
  end;
end;

function TVUniCollection.SearchIndex_Pointer(PIR: PTVIndexRec;
  AKey: Pointer): Integer;
var
  L,H,I: Integer;
  C,K: LongWord;
begin
  with PIR^ do
  begin
    if IndType <> itPointer then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    if not Regular then
    begin
      for I := 0 to FCount-1 do
        if KeyOf_Pointer(IndList^[I]) <> AKey then
          Continue
        else
        begin
          Result := I;
          Exit;
        end;
      Result := -1;
    end else
    begin
      L := 0;
      H := FCount - 1;
      Result := -1;
      K := LongWord(AKey);
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := LongWord(KeyOf_Pointer(IndList^[I]));
          if C < K then
            L := I + 1
          else
          begin
            if C = K then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := LongWord(KeyOf_Pointer(IndList^[I]));
          if C > K then
            L := I + 1
          else
          begin
            if C = K then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end;
    end;
  end;
end;

function TVUniCollection.SearchIndex_Single(PIR: PTVIndexRec;
  AKey: Single): Integer;
var
  L,H,I: Integer;
  C: Single;
begin
  with PIR^ do
  begin
    if IndType <> itSingle then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    if not Regular then
    begin
      for I := 0 to FCount-1 do
        if KeyOf_Single(IndList^[I]) <> AKey then
          Continue
        else
        begin
          Result := I;
          Exit;
        end;
      Result := -1;
    end else
    begin
      L := 0;
      H := FCount - 1;
      Result := -1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Single(IndList^[I]);
          if C < AKey then
            L := I + 1
          else
          begin
            if C = AKey then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Single(IndList^[I]);
          if C > AKey then
            L := I + 1
          else
          begin
            if C = AKey then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end;
    end;
  end;
end;

function TVUniCollection.SearchIndex_Smallint(PIR: PTVIndexRec;
  AKey: Smallint): Integer;
var
  L,H,I: Integer;
  C,K: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itSmallint then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    if not Regular then
    begin
      for I := 0 to FCount-1 do
        if KeyOf_Smallint(IndList^[I]) <> AKey then
          Continue
        else
        begin
          Result := I;
          Exit;
        end;
      Result := -1;
    end else
    begin
      K := AKey;
      L := 0;
      H := FCount - 1;
      Result := -1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Smallint(IndList^[I])-K;
          if C < 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Smallint(IndList^[I])-K;
          if C > 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end;
    end;
  end;
end;

function TVUniCollection.SearchIndex_TDateTime(PIR: PTVIndexRec;
  AKey: TDateTime): Integer;
var
  L,H,I: Integer;
  C: TDateTime;
begin
  with PIR^ do
  begin
    if IndType <> itTDateTime then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    if not Regular then
    begin
      for I := 0 to FCount-1 do
        if KeyOf_TDateTime(IndList^[I]) <> AKey then
          Continue
        else
        begin
          Result := I;
          Exit;
        end;
      Result := -1;
    end else
    begin
      L := 0;
      H := FCount - 1;
      Result := -1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_TDateTime(IndList^[I]);
          if C < AKey then
            L := I + 1
          else
          begin
            if C = AKey then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_TDateTime(IndList^[I]);
          if C > AKey then
            L := I + 1
          else
          begin
            if C = AKey then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end;
    end;
  end;
end;

function TVUniCollection.SearchIndex_UserCmp(PIR: PTVIndexRec;
  AKey: Pointer): Integer;
var
  L,H,I: Integer;
  C: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itUserCmp then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    if not Regular then
    begin
      for I := 0 to FCount-1 do
        if UserKeyCompare(IndList^[I],AKey) <> 0 then
          Continue
        else
        begin
          Result := I;
          Exit;
        end;
      Result := -1;
    end else
    begin
      L := 0;
      H := FCount - 1;
      Result := -1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := UserKeyCompare(IndList^[I],AKey);
          if C < 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := UserKeyCompare(IndList^[I],AKey);
          if C > 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end;
    end;
  end;
end;

function TVUniCollection.SearchIndex_Word(PIR: PTVIndexRec;
  AKey: Word): Integer;
var
  L,H,I: Integer;
  C,K: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itWord then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    if not Regular then
    begin
      for I := 0 to FCount-1 do
        if KeyOf_Word(IndList^[I]) <> AKey then
          Continue
        else
        begin
          Result := I;
          Exit;
        end;
      Result := -1;
    end else
    begin
      K := AKey;
      L := 0;
      H := FCount - 1;
      Result := -1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Word(IndList^[I])-K;
          if C < 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Word(IndList^[I])-K;
          if C > 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end;
    end;
  end;
end;

function TVUniCollection.SearchIndex_Byte(PIR: PTVIndexRec;
  AKey: Byte): Integer;
var
  L,H,I: Integer;
  C,K: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itByte then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    if not Regular then
    begin
      for I := 0 to FCount-1 do
        if KeyOf_Byte(IndList^[I]) <> AKey then
          Continue
        else
        begin
          Result := I;
          Exit;
        end;
      Result := -1;
    end else
    begin
      K := AKey;
      L := 0;
      H := FCount - 1;
      Result := -1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Byte(IndList^[I])-K;
          if C < 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Byte(IndList^[I])-K;
          if C > 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end;
    end;
  end;
end;

function TVUniCollection.SearchIndex_PChar(PIR: PTVIndexRec;
  AKey: PChar): Integer;
var
  L,H,I: Integer;
  C: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itPChar then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    if not Regular then
    begin
      for I := 0 to FCount-1 do
        if Q_PCompStr(KeyOf_PChar(IndList^[I]),AKey) <> 0 then
          Continue
        else
        begin
          Result := I;
          Exit;
        end;
      Result := -1;
    end else
    begin
      L := 0;
      H := FCount - 1;
      Result := -1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_PCompStr(KeyOf_PChar(IndList^[I]),AKey);
          if C < 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_PCompStr(KeyOf_PChar(IndList^[I]),AKey);
          if C > 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end;
    end;
  end;
end;

function TVUniCollection.SearchIndex_PChar_I(PIR: PTVIndexRec;
  AKey: PChar): Integer;
var
  L,H,I: Integer;
  C: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itPChar_I then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    if not Regular then
    begin
      for I := 0 to FCount-1 do
        if Q_PCompText(KeyOf_PChar_I(IndList^[I]),AKey) <> 0 then
          Continue
        else
        begin
          Result := I;
          Exit;
        end;
      Result := -1;
    end else
    begin
      L := 0;
      H := FCount - 1;
      Result := -1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_PCompText(KeyOf_PChar_I(IndList^[I]),AKey);
          if C < 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_PCompText(KeyOf_PChar_I(IndList^[I]),AKey);
          if C > 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end;
    end;
  end;
end;

function TVUniCollection.SearchIndex_Shortint(PIR: PTVIndexRec;
  AKey: Shortint): Integer;
var
  L,H,I: Integer;
  C,K: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itShortint then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    if not Regular then
    begin
      for I := 0 to FCount-1 do
        if KeyOf_Shortint(IndList^[I]) <> AKey then
          Continue
        else
        begin
          Result := I;
          Exit;
        end;
      Result := -1;
    end else
    begin
      K := AKey;
      L := 0;
      H := FCount - 1;
      Result := -1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Shortint(IndList^[I])-K;
          if C < 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Shortint(IndList^[I])-K;
          if C > 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end;
    end;
  end;
end;

function TVUniCollection.SearchIndex_String(PIR: PTVIndexRec;
  const AKey: string): Integer;
var
  L,H,I: Integer;
  C: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itString then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    if not Regular then
    begin
      for I := 0 to FCount-1 do
        if not Q_SameStr(KeyOf_String(IndList^[I]),AKey) then
          Continue
        else
        begin
          Result := I;
          Exit;
        end;
      Result := -1;
    end else
    begin
      L := 0;
      H := FCount - 1;
      Result := -1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_CompStr(KeyOf_String(IndList^[I]),AKey);
          if C < 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_CompStr(KeyOf_String(IndList^[I]),AKey);
          if C > 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end;
    end;
  end;
end;

function TVUniCollection.SearchIndex_String_I(PIR: PTVIndexRec;
  const AKey: string): Integer;
var
  L,H,I: Integer;
  C: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itString_I then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    if not Regular then
    begin
      for I := 0 to FCount-1 do
        if not Q_SameText(KeyOf_String_I(IndList^[I]),AKey) then
          Continue
        else
        begin
          Result := I;
          Exit;
        end;
      Result := -1;
    end else
    begin
      L := 0;
      H := FCount - 1;
      Result := -1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_CompText(KeyOf_String_I(IndList^[I]),AKey);
          if C < 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_CompText(KeyOf_String_I(IndList^[I]),AKey);
          if C > 0 then
            L := I + 1
          else
          begin
            if C = 0 then
            begin
              Result := I;
              if Unique then Exit;
            end;
            H := I - 1;
          end;
        end;
    end;
  end;
end;

function TVUniCollection.SearchNext_Byte(PIR: PTVIndexRec; AKey: Byte;
  var Index: Integer): Boolean;
var
  L,H,I: Integer;
  C,K: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itByte then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if Index <> -1 then
    begin
      if Regular then
      begin
        if not Active then
          UpdateIndexByPIR(PIR);
        Inc(Index);
        if (Index < FCount) and (KeyOf_Byte(IndList^[Index]) = AKey) then
        begin
          Result := True;
          Exit;
        end;
      end else
        if Active then
        begin
          for I := Index+1 to FCount-1 do
            if KeyOf_Byte(IndList^[I]) <> AKey then
              Continue
            else
            begin
              Index := I;
              Result := True;
              Exit
            end;
          Index := FCount;
        end;
      Result := False;
    end else
    begin
      if not Active then
        UpdateIndexByPIR(PIR);
      if not Regular then
      begin
        for I := 0 to FCount-1 do
          if KeyOf_Byte(IndList^[I]) <> AKey then
            Continue
          else
          begin
            Index := I;
            Result := True;
            Exit;
          end;
        Index := FCount;
        Result := False;
      end else
      begin
        K := AKey;
        L := 0;
        H := FCount - 1;
        Index := -1;
        if not Descending then
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Byte(IndList^[I])-K;
            if C < 0 then
              L := I + 1
            else
            begin
              if C = 0 then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end
        else
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Byte(IndList^[I])-K;
            if C > 0 then
              L := I + 1
            else
            begin
              if C = 0 then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end;
        Result := Index <> -1;
      end;
    end;
  end;
end;

function TVUniCollection.SearchNext_Cardinal(PIR: PTVIndexRec;
  AKey: Cardinal; var Index: Integer): Boolean;
var
  L,H,I: Integer;
  C: Cardinal;
begin
  with PIR^ do
  begin
    if IndType <> itCardinal then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if Index <> -1 then
    begin
      if Regular then
      begin
        if not Active then
          UpdateIndexByPIR(PIR);
        Inc(Index);
        if (Index < FCount) and (KeyOf_Cardinal(IndList^[Index]) = AKey) then
        begin
          Result := True;
          Exit;
        end;
      end else
        if Active then
        begin
          for I := Index+1 to FCount-1 do
            if KeyOf_Cardinal(IndList^[I]) <> AKey then
              Continue
            else
            begin
              Index := I;
              Result := True;
              Exit
            end;
          Index := FCount;
        end;
      Result := False;
    end else
    begin
      if not Active then
        UpdateIndexByPIR(PIR);
      if not Regular then
      begin
        for I := 0 to FCount-1 do
          if KeyOf_Cardinal(IndList^[I]) <> AKey then
            Continue
          else
          begin
            Index := I;
            Result := True;
            Exit;
          end;
        Index := FCount;
        Result := False;
      end else
      begin
        L := 0;
        H := FCount - 1;
        Index := -1;
        if not Descending then
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Cardinal(IndList^[I]);
            if C < AKey then
              L := I + 1
            else
            begin
              if C = AKey then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end
        else
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Cardinal(IndList^[I]);
            if C > AKey then
              L := I + 1
            else
            begin
              if C = AKey then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end;
        Result := Index <> -1;
      end;
    end;
  end;
end;

function TVUniCollection.SearchNext_Comp(PIR: PTVIndexRec; AKey: Comp;
  var Index: Integer): Boolean;
var
  L,H,I: Integer;
  C: Comp;
begin
  with PIR^ do
  begin
    if IndType <> itComp then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if Index <> -1 then
    begin
      if Regular then
      begin
        if not Active then
          UpdateIndexByPIR(PIR);
        Inc(Index);
        if (Index < FCount) and (KeyOf_Comp(IndList^[Index]) = AKey) then
        begin
          Result := True;
          Exit;
        end;
      end else
        if Active then
        begin
          for I := Index+1 to FCount-1 do
            if KeyOf_Comp(IndList^[I]) <> AKey then
              Continue
            else
            begin
              Index := I;
              Result := True;
              Exit
            end;
          Index := FCount;
        end;
      Result := False;
    end else
    begin
      if not Active then
        UpdateIndexByPIR(PIR);
      if not Regular then
      begin
        for I := 0 to FCount-1 do
          if KeyOf_Comp(IndList^[I]) <> AKey then
            Continue
          else
          begin
            Index := I;
            Result := True;
            Exit;
          end;
        Index := FCount;
        Result := False;
      end else
      begin
        L := 0;
        H := FCount - 1;
        Index := -1;
        if not Descending then
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Comp(IndList^[I]);
            if C < AKey then
              L := I + 1
            else
            begin
              if C = AKey then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end
        else
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Comp(IndList^[I]);
            if C > AKey then
              L := I + 1
            else
            begin
              if C = AKey then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end;
        Result := Index <> -1;
      end;
    end;
  end;
end;

function TVUniCollection.SearchNext_Currency(PIR: PTVIndexRec;
  AKey: Currency; var Index: Integer): Boolean;
var
  L,H,I: Integer;
  C: Currency;
begin
  with PIR^ do
  begin
    if IndType <> itCurrency then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if Index <> -1 then
    begin
      if Regular then
      begin
        if not Active then
          UpdateIndexByPIR(PIR);
        Inc(Index);
        if (Index < FCount) and (KeyOf_Currency(IndList^[Index]) = AKey) then
        begin
          Result := True;
          Exit;
        end;
      end else
        if Active then
        begin
          for I := Index+1 to FCount-1 do
            if KeyOf_Currency(IndList^[I]) <> AKey then
              Continue
            else
            begin
              Index := I;
              Result := True;
              Exit
            end;
          Index := FCount;
        end;
      Result := False;
    end else
    begin
      if not Active then
        UpdateIndexByPIR(PIR);
      if not Regular then
      begin
        for I := 0 to FCount-1 do
          if KeyOf_Currency(IndList^[I]) <> AKey then
            Continue
          else
          begin
            Index := I;
            Result := True;
            Exit;
          end;
        Index := FCount;
        Result := False;
      end else
      begin
        L := 0;
        H := FCount - 1;
        Index := -1;
        if not Descending then
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Currency(IndList^[I]);
            if C < AKey then
              L := I + 1
            else
            begin
              if C = AKey then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end
        else
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Currency(IndList^[I]);
            if C > AKey then
              L := I + 1
            else
            begin
              if C = AKey then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end;
        Result := Index <> -1;
      end;
    end;
  end;
end;

function TVUniCollection.SearchNext_Double(PIR: PTVIndexRec; AKey: Double;
  var Index: Integer): Boolean;
var
  L,H,I: Integer;
  C: Double;
begin
  with PIR^ do
  begin
    if IndType <> itDouble then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if Index <> -1 then
    begin
      if Regular then
      begin
        if not Active then
          UpdateIndexByPIR(PIR);
        Inc(Index);
        if (Index < FCount) and (KeyOf_Double(IndList^[Index]) = AKey) then
        begin
          Result := True;
          Exit;
        end;
      end else
        if Active then
        begin
          for I := Index+1 to FCount-1 do
            if KeyOf_Double(IndList^[I]) <> AKey then
              Continue
            else
            begin
              Index := I;
              Result := True;
              Exit
            end;
          Index := FCount;
        end;
      Result := False;
    end else
    begin
      if not Active then
        UpdateIndexByPIR(PIR);
      if not Regular then
      begin
        for I := 0 to FCount-1 do
          if KeyOf_Double(IndList^[I]) <> AKey then
            Continue
          else
          begin
            Index := I;
            Result := True;
            Exit;
          end;
        Index := FCount;
        Result := False;
      end else
      begin
        L := 0;
        H := FCount - 1;
        Index := -1;
        if not Descending then
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Double(IndList^[I]);
            if C < AKey then
              L := I + 1
            else
            begin
              if C = AKey then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end
        else
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Double(IndList^[I]);
            if C > AKey then
              L := I + 1
            else
            begin
              if C = AKey then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end;
        Result := Index <> -1;
      end;
    end;
  end;
end;

function TVUniCollection.SearchNext_Extended(PIR: PTVIndexRec;
  AKey: Extended; var Index: Integer): Boolean;
var
  L,H,I: Integer;
  C: Extended;
begin
  with PIR^ do
  begin
    if IndType <> itExtended then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if Index <> -1 then
    begin
      if Regular then
      begin
        if not Active then
          UpdateIndexByPIR(PIR);
        Inc(Index);
        if (Index < FCount) and (KeyOf_Extended(IndList^[Index]) = AKey) then
        begin
          Result := True;
          Exit;
        end;
      end else
        if Active then
        begin
          for I := Index+1 to FCount-1 do
            if KeyOf_Extended(IndList^[I]) <> AKey then
              Continue
            else
            begin
              Index := I;
              Result := True;
              Exit
            end;
          Index := FCount;
        end;
      Result := False;
    end else
    begin
      if not Active then
        UpdateIndexByPIR(PIR);
      if not Regular then
      begin
        for I := 0 to FCount-1 do
          if KeyOf_Extended(IndList^[I]) <> AKey then
            Continue
          else
          begin
            Index := I;
            Result := True;
            Exit;
          end;
        Index := FCount;
        Result := False;
      end else
      begin
        L := 0;
        H := FCount - 1;
        Index := -1;
        if not Descending then
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Extended(IndList^[I]);
            if C < AKey then
              L := I + 1
            else
            begin
              if C = AKey then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end
        else
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Extended(IndList^[I]);
            if C > AKey then
              L := I + 1
            else
            begin
              if C = AKey then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end;
        Result := Index <> -1;
      end;
    end;
  end;
end;

function TVUniCollection.SearchNext_Int64(PIR: PTVIndexRec; AKey: Int64;
  var Index: Integer): Boolean;
var
  L,H,I: Integer;
  C: Int64;
begin
  with PIR^ do
  begin
    if IndType <> itInt64 then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if Index <> -1 then
    begin
      if Regular then
      begin
        if not Active then
          UpdateIndexByPIR(PIR);
        Inc(Index);
        if (Index < FCount) and (KeyOf_Int64(IndList^[Index]) = AKey) then
        begin
          Result := True;
          Exit;
        end;
      end else
        if Active then
        begin
          for I := Index+1 to FCount-1 do
            if KeyOf_Int64(IndList^[I]) <> AKey then
              Continue
            else
            begin
              Index := I;
              Result := True;
              Exit
            end;
          Index := FCount;
        end;
      Result := False;
    end else
    begin
      if not Active then
        UpdateIndexByPIR(PIR);
      if not Regular then
      begin
        for I := 0 to FCount-1 do
          if KeyOf_Int64(IndList^[I]) <> AKey then
            Continue
          else
          begin
            Index := I;
            Result := True;
            Exit;
          end;
        Index := FCount;
        Result := False;
      end else
      begin
        L := 0;
        H := FCount - 1;
        Index := -1;
        if not Descending then
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Int64(IndList^[I]);
            if C < AKey then
              L := I + 1
            else
            begin
              if C = AKey then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end
        else
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Int64(IndList^[I]);
            if C > AKey then
              L := I + 1
            else
            begin
              if C = AKey then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end;
        Result := Index <> -1;
      end;
    end;
  end;
end;

function TVUniCollection.SearchNext_Integer(PIR: PTVIndexRec; AKey: Integer;
  var Index: Integer): Boolean;
var
  L,H,I: Integer;
  C: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itInteger then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if Index <> -1 then
    begin
      if Regular then
      begin
        if not Active then
          UpdateIndexByPIR(PIR);
        Inc(Index);
        if (Index < FCount) and (KeyOf_Integer(IndList^[Index]) = AKey) then
        begin
          Result := True;
          Exit;
        end;
      end else
        if Active then
        begin
          for I := Index+1 to FCount-1 do
            if KeyOf_Integer(IndList^[I]) <> AKey then
              Continue
            else
            begin
              Index := I;
              Result := True;
              Exit
            end;
          Index := FCount;
        end;
      Result := False;
    end else
    begin
      if not Active then
        UpdateIndexByPIR(PIR);
      if not Regular then
      begin
        for I := 0 to FCount-1 do
          if KeyOf_Integer(IndList^[I]) <> AKey then
            Continue
          else
          begin
            Index := I;
            Result := True;
            Exit;
          end;
        Index := FCount;
        Result := False;
      end else
      begin
        L := 0;
        H := FCount - 1;
        Index := -1;
        if not Descending then
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Integer(IndList^[I])-AKey;
            if C < 0 then
              L := I + 1
            else
            begin
              if C = 0 then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end
        else
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Integer(IndList^[I])-AKey;
            if C > 0 then
              L := I + 1
            else
            begin
              if C = 0 then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end;
        Result := Index <> -1;
      end;
    end;
  end;
end;

function TVUniCollection.SearchNext_PChar(PIR: PTVIndexRec; AKey: PChar;
  var Index: Integer): Boolean;
var
  L,H,I: Integer;
  C: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itPChar then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if Index <> -1 then
    begin
      if Regular then
      begin
        if not Active then
          UpdateIndexByPIR(PIR);
        Inc(Index);
        if (Index<FCount) and (Q_PCompStr(KeyOf_PChar(IndList^[Index]),AKey)=0) then
        begin
          Result := True;
          Exit;
        end;
      end else
        if Active then
        begin
          for I := Index+1 to FCount-1 do
            if Q_PCompStr(KeyOf_PChar(IndList^[I]),AKey) <> 0 then
              Continue
            else
            begin
              Index := I;
              Result := True;
              Exit
            end;
          Index := FCount;
        end;
      Result := False;
    end else
    begin
      if not Active then
        UpdateIndexByPIR(PIR);
      if not Regular then
      begin
        for I := 0 to FCount-1 do
          if Q_PCompStr(KeyOf_PChar(IndList^[I]),AKey) <> 0 then
            Continue
          else
          begin
            Index := I;
            Result := True;
            Exit;
          end;
        Index := FCount;
        Result := False;
      end else
      begin
        L := 0;
        H := FCount - 1;
        Index := -1;
        if not Descending then
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := Q_PCompStr(KeyOf_PChar(IndList^[I]),AKey);
            if C < 0 then
              L := I + 1
            else
            begin
              if C = 0 then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end
        else
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := Q_PCompStr(KeyOf_PChar(IndList^[I]),AKey);
            if C > 0 then
              L := I + 1
            else
            begin
              if C = 0 then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end;
        Result := Index <> -1;
      end;
    end;
  end;
end;

function TVUniCollection.SearchNext_PChar_I(PIR: PTVIndexRec; AKey: PChar;
  var Index: Integer): Boolean;
var
  L,H,I: Integer;
  C: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itPChar_I then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if Index <> -1 then
    begin
      if Regular then
      begin
        if not Active then
          UpdateIndexByPIR(PIR);
        Inc(Index);
        if (Index<FCount) and (Q_PCompText(KeyOf_PChar_I(IndList^[Index]),AKey)=0) then
        begin
          Result := True;
          Exit;
        end;
      end else
        if Active then
        begin
          for I := Index+1 to FCount-1 do
            if Q_PCompText(KeyOf_PChar_I(IndList^[I]),AKey) <> 0 then
              Continue
            else
            begin
              Index := I;
              Result := True;
              Exit
            end;
          Index := FCount;
        end;
      Result := False;
    end else
    begin
      if not Active then
        UpdateIndexByPIR(PIR);
      if not Regular then
      begin
        for I := 0 to FCount-1 do
          if Q_PCompText(KeyOf_PChar_I(IndList^[I]),AKey) <> 0 then
            Continue
          else
          begin
            Index := I;
            Result := True;
            Exit;
          end;
        Index := FCount;
        Result := False;
      end else
      begin
        L := 0;
        H := FCount - 1;
        Index := -1;
        if not Descending then
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := Q_PCompText(KeyOf_PChar_I(IndList^[I]),AKey);
            if C < 0 then
              L := I + 1
            else
            begin
              if C = 0 then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end
        else
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := Q_PCompText(KeyOf_PChar_I(IndList^[I]),AKey);
            if C > 0 then
              L := I + 1
            else
            begin
              if C = 0 then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end;
        Result := Index <> -1;
      end;
    end;
  end;
end;

function TVUniCollection.SearchNext_Pointer(PIR: PTVIndexRec; AKey: Pointer;
  var Index: Integer): Boolean;
var
  L,H,I: Integer;
  C,K: LongWord;
begin
  with PIR^ do
  begin
    if IndType <> itPointer then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if Index <> -1 then
    begin
      if Regular then
      begin
        if not Active then
          UpdateIndexByPIR(PIR);
        Inc(Index);
        if (Index < FCount) and (KeyOf_Pointer(IndList^[Index]) = AKey) then
        begin
          Result := True;
          Exit;
        end;
      end else
        if Active then
        begin
          for I := Index+1 to FCount-1 do
            if KeyOf_Pointer(IndList^[I]) <> AKey then
              Continue
            else
            begin
              Index := I;
              Result := True;
              Exit
            end;
          Index := FCount;
        end;
      Result := False;
    end else
    begin
      if not Active then
        UpdateIndexByPIR(PIR);
      if not Regular then
      begin
        for I := 0 to FCount-1 do
          if KeyOf_Pointer(IndList^[I]) <> AKey then
            Continue
          else
          begin
            Index := I;
            Result := True;
            Exit;
          end;
        Index := FCount;
        Result := False;
      end else
      begin
        L := 0;
        H := FCount - 1;
        Index := -1;
        K := LongWord(AKey);
        if not Descending then
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := LongWord(KeyOf_Pointer(IndList^[I]));
            if C < K then
              L := I + 1
            else
            begin
              if C = K then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end
        else
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := LongWord(KeyOf_Pointer(IndList^[I]));
            if C > K then
              L := I + 1
            else
            begin
              if C = K then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end;
        Result := Index <> -1;
      end;
    end;
  end;
end;

function TVUniCollection.SearchNext_Shortint(PIR: PTVIndexRec;
  AKey: Shortint; var Index: Integer): Boolean;
var
  L,H,I: Integer;
  C,K: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itShortint then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if Index <> -1 then
    begin
      if Regular then
      begin
        if not Active then
          UpdateIndexByPIR(PIR);
        Inc(Index);
        if (Index < FCount) and (KeyOf_Shortint(IndList^[Index]) = AKey) then
        begin
          Result := True;
          Exit;
        end;
      end else
        if Active then
        begin
          for I := Index+1 to FCount-1 do
            if KeyOf_Shortint(IndList^[I]) <> AKey then
              Continue
            else
            begin
              Index := I;
              Result := True;
              Exit
            end;
          Index := FCount;
        end;
      Result := False;
    end else
    begin
      if not Active then
        UpdateIndexByPIR(PIR);
      if not Regular then
      begin
        for I := 0 to FCount-1 do
          if KeyOf_Shortint(IndList^[I]) <> AKey then
            Continue
          else
          begin
            Index := I;
            Result := True;
            Exit;
          end;
        Index := FCount;
        Result := False;
      end else
      begin
        K := AKey;
        L := 0;
        H := FCount - 1;
        Index := -1;
        if not Descending then
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Shortint(IndList^[I])-K;
            if C < 0 then
              L := I + 1
            else
            begin
              if C = 0 then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end
        else
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Shortint(IndList^[I])-K;
            if C > 0 then
              L := I + 1
            else
            begin
              if C = 0 then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end;
        Result := Index <> -1;
      end;
    end;
  end;
end;

function TVUniCollection.SearchNext_Single(PIR: PTVIndexRec; AKey: Single;
  var Index: Integer): Boolean;
var
  L,H,I: Integer;
  C: Single;
begin
  with PIR^ do
  begin
    if IndType <> itSingle then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if Index <> -1 then
    begin
      if Regular then
      begin
        if not Active then
          UpdateIndexByPIR(PIR);
        Inc(Index);
        if (Index < FCount) and (KeyOf_Single(IndList^[Index]) = AKey) then
        begin
          Result := True;
          Exit;
        end;
      end else
        if Active then
        begin
          for I := Index+1 to FCount-1 do
            if KeyOf_Single(IndList^[I]) <> AKey then
              Continue
            else
            begin
              Index := I;
              Result := True;
              Exit
            end;
          Index := FCount;
        end;
      Result := False;
    end else
    begin
      if not Active then
        UpdateIndexByPIR(PIR);
      if not Regular then
      begin
        for I := 0 to FCount-1 do
          if KeyOf_Single(IndList^[I]) <> AKey then
            Continue
          else
          begin
            Index := I;
            Result := True;
            Exit;
          end;
        Index := FCount;
        Result := False;
      end else
      begin
        L := 0;
        H := FCount - 1;
        Index := -1;
        if not Descending then
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Single(IndList^[I]);
            if C < AKey then
              L := I + 1
            else
            begin
              if C = AKey then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end
        else
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Single(IndList^[I]);
            if C > AKey then
              L := I + 1
            else
            begin
              if C = AKey then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end;
        Result := Index <> -1;
      end;
    end;
  end;
end;

function TVUniCollection.SearchNext_Smallint(PIR: PTVIndexRec;
  AKey: Smallint; var Index: Integer): Boolean;
var
  L,H,I: Integer;
  C,K: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itSmallint then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if Index <> -1 then
    begin
      if Regular then
      begin
        if not Active then
          UpdateIndexByPIR(PIR);
        Inc(Index);
        if (Index < FCount) and (KeyOf_Smallint(IndList^[Index]) = AKey) then
        begin
          Result := True;
          Exit;
        end;
      end else
        if Active then
        begin
          for I := Index+1 to FCount-1 do
            if KeyOf_Smallint(IndList^[I]) <> AKey then
              Continue
            else
            begin
              Index := I;
              Result := True;
              Exit
            end;
          Index := FCount;
        end;
      Result := False;
    end else
    begin
      if not Active then
        UpdateIndexByPIR(PIR);
      if not Regular then
      begin
        for I := 0 to FCount-1 do
          if KeyOf_Smallint(IndList^[I]) <> AKey then
            Continue
          else
          begin
            Index := I;
            Result := True;
            Exit;
          end;
        Index := FCount;
        Result := False;
      end else
      begin
        K := AKey;
        L := 0;
        H := FCount - 1;
        Index := -1;
        if not Descending then
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Smallint(IndList^[I])-K;
            if C < 0 then
              L := I + 1
            else
            begin
              if C = 0 then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end
        else
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Smallint(IndList^[I])-K;
            if C > 0 then
              L := I + 1
            else
            begin
              if C = 0 then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end;
        Result := Index <> -1;
      end;
    end;
  end;
end;

function TVUniCollection.SearchNext_String(PIR: PTVIndexRec;
  const AKey: string; var Index: Integer): Boolean;
var
  L,H,I: Integer;
  C: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itString then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if Index <> -1 then
    begin
      if Regular then
      begin
        if not Active then
          UpdateIndexByPIR(PIR);
        Inc(Index);
        if (Index<FCount) and Q_SameStr(KeyOf_String(IndList^[Index]),AKey) then
        begin
          Result := True;
          Exit;
        end;
      end else
        if Active then
        begin
          for I := Index+1 to FCount-1 do
            if not Q_SameStr(KeyOf_String(IndList^[I]),AKey) then
              Continue
            else
            begin
              Index := I;
              Result := True;
              Exit
            end;
          Index := FCount;
        end;
      Result := False;
    end else
    begin
      if not Active then
        UpdateIndexByPIR(PIR);
      if not Regular then
      begin
        for I := 0 to FCount-1 do
          if not Q_SameStr(KeyOf_String(IndList^[I]),AKey) then
            Continue
          else
          begin
            Index := I;
            Result := True;
            Exit;
          end;
        Index := FCount;
        Result := False;
      end else
      begin
        L := 0;
        H := FCount - 1;
        Index := -1;
        if not Descending then
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := Q_CompStr(KeyOf_String(IndList^[I]),AKey);
            if C < 0 then
              L := I + 1
            else
            begin
              if C = 0 then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end
        else
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := Q_CompStr(KeyOf_String(IndList^[I]),AKey);
            if C > 0 then
              L := I + 1
            else
            begin
              if C = 0 then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end;
        Result := Index <> -1;
      end;
    end;
  end;
end;

function TVUniCollection.SearchNext_String_I(PIR: PTVIndexRec;
  const AKey: string; var Index: Integer): Boolean;
var
  L,H,I: Integer;
  C: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itString_I then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if Index <> -1 then
    begin
      if Regular then
      begin
        if not Active then
          UpdateIndexByPIR(PIR);
        Inc(Index);
        if (Index<FCount) and Q_SameText(KeyOf_String_I(IndList^[Index]),AKey) then
        begin
          Result := True;
          Exit;
        end;
      end else
        if Active then
        begin
          for I := Index+1 to FCount-1 do
            if not Q_SameText(KeyOf_String_I(IndList^[I]),AKey) then
              Continue
            else
            begin
              Index := I;
              Result := True;
              Exit
            end;
          Index := FCount;
        end;
      Result := False;
    end else
    begin
      if not Active then
        UpdateIndexByPIR(PIR);
      if not Regular then
      begin
        for I := 0 to FCount-1 do
          if not Q_SameText(KeyOf_String_I(IndList^[I]),AKey) then
            Continue
          else
          begin
            Index := I;
            Result := True;
            Exit;
          end;
        Index := FCount;
        Result := False;
      end else
      begin
        L := 0;
        H := FCount - 1;
        Index := -1;
        if not Descending then
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := Q_CompText(KeyOf_String_I(IndList^[I]),AKey);
            if C < 0 then
              L := I + 1
            else
            begin
              if C = 0 then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end
        else
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := Q_CompText(KeyOf_String_I(IndList^[I]),AKey);
            if C > 0 then
              L := I + 1
            else
            begin
              if C = 0 then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end;
        Result := Index <> -1;
      end;
    end;
  end;
end;

function TVUniCollection.SearchNext_TDateTime(PIR: PTVIndexRec;
  AKey: TDateTime; var Index: Integer): Boolean;
var
  L,H,I: Integer;
  C: TDateTime;
begin
  with PIR^ do
  begin
    if IndType <> itTDateTime then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if Index <> -1 then
    begin
      if Regular then
      begin
        if not Active then
          UpdateIndexByPIR(PIR);
        Inc(Index);
        if (Index < FCount) and (KeyOf_TDateTime(IndList^[Index]) = AKey) then
        begin
          Result := True;
          Exit;
        end;
      end else
        if Active then
        begin
          for I := Index+1 to FCount-1 do
            if KeyOf_TDateTime(IndList^[I]) <> AKey then
              Continue
            else
            begin
              Index := I;
              Result := True;
              Exit
            end;
          Index := FCount;
        end;
      Result := False;
    end else
    begin
      if not Active then
        UpdateIndexByPIR(PIR);
      if not Regular then
      begin
        for I := 0 to FCount-1 do
          if KeyOf_TDateTime(IndList^[I]) <> AKey then
            Continue
          else
          begin
            Index := I;
            Result := True;
            Exit;
          end;
        Index := FCount;
        Result := False;
      end else
      begin
        L := 0;
        H := FCount - 1;
        Index := -1;
        if not Descending then
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_TDateTime(IndList^[I]);
            if C < AKey then
              L := I + 1
            else
            begin
              if C = AKey then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end
        else
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_TDateTime(IndList^[I]);
            if C > AKey then
              L := I + 1
            else
            begin
              if C = AKey then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end;
        Result := Index <> -1;
      end;
    end;
  end;
end;

function TVUniCollection.SearchNext_UserCmp(PIR: PTVIndexRec; AKey: Pointer;
  var Index: Integer): Boolean;
var
  L,H,I: Integer;
  C: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itUserCmp then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if Index <> -1 then
    begin
      if Regular then
      begin
        if not Active then
          UpdateIndexByPIR(PIR);
        Inc(Index);
        if (Index<FCount) and (UserKeyCompare(IndList^[Index],AKey)=0) then
        begin
          Result := True;
          Exit;
        end;
      end else
        if Active then
        begin
          for I := Index+1 to FCount-1 do
            if UserKeyCompare(IndList^[I],AKey) <> 0 then
              Continue
            else
            begin
              Index := I;
              Result := True;
              Exit
            end;
          Index := FCount;
        end;
      Result := False;
    end else
    begin
      if not Active then
        UpdateIndexByPIR(PIR);
      if not Regular then
      begin
        for I := 0 to FCount-1 do
          if UserKeyCompare(IndList^[I],AKey) <> 0 then
            Continue
          else
          begin
            Index := I;
            Result := True;
            Exit;
          end;
        Index := FCount;
        Result := False;
      end else
      begin
        L := 0;
        H := FCount - 1;
        Index := -1;
        if not Descending then
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := UserKeyCompare(IndList^[I],AKey);
            if C < 0 then
              L := I + 1
            else
            begin
              if C = 0 then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end
        else
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := UserKeyCompare(IndList^[I],AKey);
            if C > 0 then
              L := I + 1
            else
            begin
              if C = 0 then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end;
        Result := Index <> -1;
      end;
    end;
  end;
end;

function TVUniCollection.SearchNext_Word(PIR: PTVIndexRec; AKey: Word;
  var Index: Integer): Boolean;
var
  L,H,I: Integer;
  C,K: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itWord then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if Index <> -1 then
    begin
      if Regular then
      begin
        if not Active then
          UpdateIndexByPIR(PIR);
        Inc(Index);
        if (Index < FCount) and (KeyOf_Word(IndList^[Index]) = AKey) then
        begin
          Result := True;
          Exit;
        end;
      end else
        if Active then
        begin
          for I := Index+1 to FCount-1 do
            if KeyOf_Word(IndList^[I]) <> AKey then
              Continue
            else
            begin
              Index := I;
              Result := True;
              Exit
            end;
          Index := FCount;
        end;
      Result := False;
    end else
    begin
      if not Active then
        UpdateIndexByPIR(PIR);
      if not Regular then
      begin
        for I := 0 to FCount-1 do
          if KeyOf_Word(IndList^[I]) <> AKey then
            Continue
          else
          begin
            Index := I;
            Result := True;
            Exit;
          end;
        Index := FCount;
        Result := False;
      end else
      begin
        K := AKey;
        L := 0;
        H := FCount - 1;
        Index := -1;
        if not Descending then
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Word(IndList^[I])-K;
            if C < 0 then
              L := I + 1
            else
            begin
              if C = 0 then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end
        else
          while L <= H do
          begin
            I := (L + H) shr 1;
            C := KeyOf_Word(IndList^[I])-K;
            if C > 0 then
              L := I + 1
            else
            begin
              if C = 0 then
              begin
                Index := I;
                if Unique then
                begin
                  Result := True;
                  Exit;
                end;
              end;
              H := I - 1;
            end;
          end;
        Result := Index <> -1;
      end;
    end;
  end;
end;

function TVUniCollection.SearchObj_Byte(PIR: PTVIndexRec; AKey: Byte): Pointer;
var
  I: Integer;
begin
  I := SearchIndex_Byte(PIR,AKey);
  if I <> -1 then
    Result := PIR^.IndList^[I]
  else
    Result := nil;
end;

function TVUniCollection.SearchObj_Cardinal(PIR: PTVIndexRec; AKey: Cardinal): Pointer;
var
  I: Integer;
begin
  I := SearchIndex_Cardinal(PIR,AKey);
  if I <> -1 then
    Result := PIR^.IndList^[I]
  else
    Result := nil;
end;

function TVUniCollection.SearchObj_Comp(PIR: PTVIndexRec; AKey: Comp): Pointer;
var
  I: Integer;
begin
  I := SearchIndex_Comp(PIR,AKey);
  if I <> -1 then
    Result := PIR^.IndList^[I]
  else
    Result := nil;
end;

function TVUniCollection.SearchObj_Currency(PIR: PTVIndexRec; AKey: Currency): Pointer;
var
  I: Integer;
begin
  I := SearchIndex_Currency(PIR,AKey);
  if I <> -1 then
    Result := PIR^.IndList^[I]
  else
    Result := nil;
end;

function TVUniCollection.SearchObj_Double(PIR: PTVIndexRec; AKey: Double): Pointer;
var
  I: Integer;
begin
  I := SearchIndex_Double(PIR,AKey);
  if I <> -1 then
    Result := PIR^.IndList^[I]
  else
    Result := nil;
end;

function TVUniCollection.SearchObj_Extended(PIR: PTVIndexRec; AKey: Extended): Pointer;
var
  I: Integer;
begin
  I := SearchIndex_Extended(PIR,AKey);
  if I <> -1 then
    Result := PIR^.IndList^[I]
  else
    Result := nil;
end;

function TVUniCollection.SearchObj_Int64(PIR: PTVIndexRec; AKey: Int64): Pointer;
var
  I: Integer;
begin
  I := SearchIndex_Int64(PIR,AKey);
  if I <> -1 then
    Result := PIR^.IndList^[I]
  else
    Result := nil;
end;

function TVUniCollection.SearchObj_Integer(PIR: PTVIndexRec; AKey: Integer): Pointer;
var
  I: Integer;
begin
  I := SearchIndex_Integer(PIR,AKey);
  if I <> -1 then
    Result := PIR^.IndList^[I]
  else
    Result := nil;
end;

function TVUniCollection.SearchObj_PChar(PIR: PTVIndexRec; AKey: PChar): Pointer;
var
  I: Integer;
begin
  I := SearchIndex_PChar(PIR,AKey);
  if I <> -1 then
    Result := PIR^.IndList^[I]
  else
    Result := nil;
end;

function TVUniCollection.SearchObj_PChar_I(PIR: PTVIndexRec; AKey: PChar): Pointer;
var
  I: Integer;
begin
  I := SearchIndex_PChar_I(PIR,AKey);
  if I <> -1 then
    Result := PIR^.IndList^[I]
  else
    Result := nil;
end;

function TVUniCollection.SearchObj_Pointer(PIR: PTVIndexRec; AKey: Pointer): Pointer;
var
  I: Integer;
begin
  I := SearchIndex_Pointer(PIR,AKey);
  if I <> -1 then
    Result := PIR^.IndList^[I]
  else
    Result := nil;
end;

function TVUniCollection.SearchObj_Shortint(PIR: PTVIndexRec; AKey: Shortint): Pointer;
var
  I: Integer;
begin
  I := SearchIndex_Shortint(PIR,AKey);
  if I <> -1 then
    Result := PIR^.IndList^[I]
  else
    Result := nil;
end;

function TVUniCollection.SearchObj_Single(PIR: PTVIndexRec; AKey: Single): Pointer;
var
  I: Integer;
begin
  I := SearchIndex_Single(PIR,AKey);
  if I <> -1 then
    Result := PIR^.IndList^[I]
  else
    Result := nil;
end;

function TVUniCollection.SearchObj_Smallint(PIR: PTVIndexRec; AKey: Smallint): Pointer;
var
  I: Integer;
begin
  I := SearchIndex_Smallint(PIR,AKey);
  if I <> -1 then
    Result := PIR^.IndList^[I]
  else
    Result := nil;
end;

function TVUniCollection.SearchObj_String(PIR: PTVIndexRec;
  const AKey: string): Pointer;
var
  I: Integer;
begin
  I := SearchIndex_String(PIR,AKey);
  if I <> -1 then
    Result := PIR^.IndList^[I]
  else
    Result := nil;
end;

function TVUniCollection.SearchObj_String_I(PIR: PTVIndexRec;
  const AKey: string): Pointer;
var
  I: Integer;
begin
  I := SearchIndex_String_I(PIR,AKey);
  if I <> -1 then
    Result := PIR^.IndList^[I]
  else
    Result := nil;
end;

function TVUniCollection.SearchObj_TDateTime(PIR: PTVIndexRec; AKey: TDateTime): Pointer;
var
  I: Integer;
begin
  I := SearchIndex_TDateTime(PIR,AKey);
  if I <> -1 then
    Result := PIR^.IndList^[I]
  else
    Result := nil;
end;

function TVUniCollection.SearchObj_UserCmp(PIR: PTVIndexRec; AKey: Pointer): Pointer;
var
  I: Integer;
begin
  I := SearchIndex_UserCmp(PIR,AKey);
  if I <> -1 then
    Result := PIR^.IndList^[I]
  else
    Result := nil;
end;

function TVUniCollection.SearchObj_Word(PIR: PTVIndexRec; AKey: Word): Pointer;
var
  I: Integer;
begin
  I := SearchIndex_Word(PIR,AKey);
  if I <> -1 then
    Result := PIR^.IndList^[I]
  else
    Result := nil;
end;

procedure TVUniCollection.SetChanged(Value: Boolean);
begin
  DoSetChanged(Value);
  FChanged := Value;
  if Value and (FOwner<>nil) then
    FOwner.SetChanged(True);
end;

procedure TVUniCollection.ActivateIndexByPIR(PIR: PTVIndexRec);
begin
  if not PIR^.Active then
    UpdateIndexByPIR(PIR);
end;

function TVUniCollection.SelectRange_Byte(PIR: PTVIndexRec; LeftBound,
  RightBound: Byte; var Index: Integer; LeftTerm, RightTerm: Integer): Integer;
var
  L,H,I: Integer;
  C,LB,RB: Integer;
begin
  LB := LeftBound;
  RB := RightBound;
  with PIR^ do
  begin
    if IndType <> itByte then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LB<RB) or ((LB=RB) and (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Byte(IndList^[I]) - LB;
          if C < 0 then
            L := I + 1
          else
          begin
            if Unique and (C=0) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Byte(IndList^[I]) <= LB then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Byte(IndList^[I]) - RB;
          if C > 0 then
            H := I - 1
          else
          begin
            if Unique and (C=0) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Byte(IndList^[I]) >= RB then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LB>RB) or ((LB=RB) and (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Byte(IndList^[I]) - LB;
          if C > 0 then
            L := I + 1
          else
          begin
            if Unique and (C=0) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Byte(IndList^[I]) >= LB then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Byte(IndList^[I]) - RB;
          if C < 0 then
            H := I - 1
          else
          begin
            if Unique and (C=0) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Byte(IndList^[I]) <= RB then
            H := I - 1
          else
            L := I + 1;
        end;
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.SelectRange_Cardinal(PIR: PTVIndexRec; LeftBound,
  RightBound: Cardinal; var Index: Integer; LeftTerm, RightTerm: Integer): Integer;
var
  L,H,I: Integer;
  C: Cardinal;
begin
  with PIR^ do
  begin
    if IndType <> itCardinal then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LeftBound<RightBound) or ((LeftBound=RightBound) and
          (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Cardinal(IndList^[I]);
          if C < LeftBound then
            L := I + 1
          else
          begin
            if Unique and (C=LeftBound) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Cardinal(IndList^[I]) <= LeftBound then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Cardinal(IndList^[I]);
          if C > RightBound then
            H := I - 1
          else
          begin
            if Unique and (C=RightBound) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Cardinal(IndList^[I]) >= RightBound then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LeftBound>RightBound) or ((LeftBound=RightBound) and
          (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Cardinal(IndList^[I]);
          if C > LeftBound then
            L := I + 1
          else
          begin
            if Unique and (C=LeftBound) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Cardinal(IndList^[I]) >= LeftBound then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Cardinal(IndList^[I]);
          if C < RightBound then
            H := I - 1
          else
          begin
            if Unique and (C=RightBound) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Cardinal(IndList^[I]) <= RightBound then
            H := I - 1
          else
            L := I + 1;
        end;
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.SelectRange_Comp(PIR: PTVIndexRec; LeftBound,
  RightBound: Comp; var Index: Integer; LeftTerm, RightTerm: Integer): Integer;
var
  L,H,I: Integer;
  C: Comp;
begin
  with PIR^ do
  begin
    if IndType <> itComp then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LeftBound<RightBound) or ((LeftBound=RightBound) and
          (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Comp(IndList^[I]);
          if C < LeftBound then
            L := I + 1
          else
          begin
            if Unique and (C=LeftBound) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Comp(IndList^[I]) <= LeftBound then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Comp(IndList^[I]);
          if C > RightBound then
            H := I - 1
          else
          begin
            if Unique and (C=RightBound) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Comp(IndList^[I]) >= RightBound then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LeftBound>RightBound) or ((LeftBound=RightBound) and
          (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Comp(IndList^[I]);
          if C > LeftBound then
            L := I + 1
          else
          begin
            if Unique and (C=LeftBound) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Comp(IndList^[I]) >= LeftBound then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Comp(IndList^[I]);
          if C < RightBound then
            H := I - 1
          else
          begin
            if Unique and (C=RightBound) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Comp(IndList^[I]) <= RightBound then
            H := I - 1
          else
            L := I + 1;
        end;
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.SelectRange_Currency(PIR: PTVIndexRec; LeftBound,
  RightBound: Currency; var Index: Integer; LeftTerm, RightTerm: Integer): Integer;
var
  L,H,I: Integer;
  C: Currency;
begin
  with PIR^ do
  begin
    if IndType <> itCurrency then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LeftBound<RightBound) or ((LeftBound=RightBound) and
          (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Currency(IndList^[I]);
          if C < LeftBound then
            L := I + 1
          else
          begin
            if Unique and (C=LeftBound) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Currency(IndList^[I]) <= LeftBound then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Currency(IndList^[I]);
          if C > RightBound then
            H := I - 1
          else
          begin
            if Unique and (C=RightBound) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Currency(IndList^[I]) >= RightBound then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LeftBound>RightBound) or ((LeftBound=RightBound) and
          (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Currency(IndList^[I]);
          if C > LeftBound then
            L := I + 1
          else
          begin
            if Unique and (C=LeftBound) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Currency(IndList^[I]) >= LeftBound then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Currency(IndList^[I]);
          if C < RightBound then
            H := I - 1
          else
          begin
            if Unique and (C=RightBound) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Currency(IndList^[I]) <= RightBound then
            H := I - 1
          else
            L := I + 1;
        end;
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.SelectRange_Double(PIR: PTVIndexRec; LeftBound,
  RightBound: Double; var Index: Integer; LeftTerm, RightTerm: Integer): Integer;
var
  L,H,I: Integer;
  C: Double;
begin
  with PIR^ do
  begin
    if IndType <> itDouble then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LeftBound<RightBound) or ((LeftBound=RightBound) and
          (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Double(IndList^[I]);
          if C < LeftBound then
            L := I + 1
          else
          begin
            if Unique and (C=LeftBound) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Double(IndList^[I]) <= LeftBound then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Double(IndList^[I]);
          if C > RightBound then
            H := I - 1
          else
          begin
            if Unique and (C=RightBound) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Double(IndList^[I]) >= RightBound then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LeftBound>RightBound) or ((LeftBound=RightBound) and
          (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Double(IndList^[I]);
          if C > LeftBound then
            L := I + 1
          else
          begin
            if Unique and (C=LeftBound) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Double(IndList^[I]) >= LeftBound then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Double(IndList^[I]);
          if C < RightBound then
            H := I - 1
          else
          begin
            if Unique and (C=RightBound) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Double(IndList^[I]) <= RightBound then
            H := I - 1
          else
            L := I + 1;
        end;
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.SelectRange_Extended(PIR: PTVIndexRec; LeftBound,
  RightBound: Extended; var Index: Integer; LeftTerm, RightTerm: Integer): Integer;
var
  L,H,I: Integer;
  C: Extended;
begin
  with PIR^ do
  begin
    if IndType <> itExtended then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LeftBound<RightBound) or ((LeftBound=RightBound) and
          (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Extended(IndList^[I]);
          if C < LeftBound then
            L := I + 1
          else
          begin
            if Unique and (C=LeftBound) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Extended(IndList^[I]) <= LeftBound then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Extended(IndList^[I]);
          if C > RightBound then
            H := I - 1
          else
          begin
            if Unique and (C=RightBound) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Extended(IndList^[I]) >= RightBound then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LeftBound>RightBound) or ((LeftBound=RightBound) and
          (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Extended(IndList^[I]);
          if C > LeftBound then
            L := I + 1
          else
          begin
            if Unique and (C=LeftBound) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Extended(IndList^[I]) >= LeftBound then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Extended(IndList^[I]);
          if C < RightBound then
            H := I - 1
          else
          begin
            if Unique and (C=RightBound) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Extended(IndList^[I]) <= RightBound then
            H := I - 1
          else
            L := I + 1;
        end;
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.SelectRange_Int64(PIR: PTVIndexRec; LeftBound,
  RightBound: Int64; var Index: Integer; LeftTerm, RightTerm: Integer): Integer;
var
  L,H,I: Integer;
  C: Int64;
begin
  with PIR^ do
  begin
    if IndType <> itInt64 then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LeftBound<RightBound) or ((LeftBound=RightBound) and
          (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Int64(IndList^[I]);
          if C < LeftBound then
            L := I + 1
          else
          begin
            if Unique and (C=LeftBound) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Int64(IndList^[I]) <= LeftBound then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Int64(IndList^[I]);
          if C > RightBound then
            H := I - 1
          else
          begin
            if Unique and (C=RightBound) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Int64(IndList^[I]) >= RightBound then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LeftBound>RightBound) or ((LeftBound=RightBound) and
          (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Int64(IndList^[I]);
          if C > LeftBound then
            L := I + 1
          else
          begin
            if Unique and (C=LeftBound) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Int64(IndList^[I]) >= LeftBound then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Int64(IndList^[I]);
          if C < RightBound then
            H := I - 1
          else
          begin
            if Unique and (C=RightBound) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Int64(IndList^[I]) <= RightBound then
            H := I - 1
          else
            L := I + 1;
        end;
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.SelectRange_Integer(PIR: PTVIndexRec; LeftBound,
  RightBound: Integer; var Index: Integer; LeftTerm, RightTerm: Integer): Integer;
var
  L,H,I: Integer;
  C: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itInteger then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LeftBound<RightBound) or ((LeftBound=RightBound) and
          (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Integer(IndList^[I]) - LeftBound;
          if C < 0 then
            L := I + 1
          else
          begin
            if Unique and (C=0) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Integer(IndList^[I]) <= LeftBound then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Integer(IndList^[I]) - RightBound;
          if C > 0 then
            H := I - 1
          else
          begin
            if Unique and (C=0) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Integer(IndList^[I]) >= RightBound then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LeftBound>RightBound) or ((LeftBound=RightBound) and
          (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Integer(IndList^[I]) - LeftBound;
          if C > 0 then
            L := I + 1
          else
          begin
            if Unique and (C=0) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Integer(IndList^[I]) >= LeftBound then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Integer(IndList^[I]) - RightBound;
          if C < 0 then
            H := I - 1
          else
          begin
            if Unique and (C=0) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Integer(IndList^[I]) <= RightBound then
            H := I - 1
          else
            L := I + 1;
        end;
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.SelectRange_PChar(PIR: PTVIndexRec; LeftBound,
  RightBound: PChar; var Index: Integer; LeftTerm, RightTerm: Integer): Integer;
var
  L,H,I: Integer;
  C: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itPChar then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      if (LeftTerm<>rtInfinite) and (RightTerm<>rtInfinite) then
      begin
        C := Q_PCompStr(LeftBound,RightBound);
        if not ((C<0) or ((C=0) and (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
          RaiseInvalidRangeBounds(Self, IndName);
      end;
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_PCompStr(KeyOf_PChar(IndList^[I]),LeftBound);
          if C < 0 then
            L := I + 1
          else
          begin
            if Unique and (C=0) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_PCompStr(KeyOf_PChar(IndList^[I]),LeftBound) <= 0 then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_PCompStr(KeyOf_PChar(IndList^[I]),RightBound);
          if C > 0 then
            H := I - 1
          else
          begin
            if Unique and (C=0) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_PCompStr(KeyOf_PChar(IndList^[I]),RightBound) >= 0 then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if (LeftTerm<>rtInfinite) and (RightTerm<>rtInfinite) then
      begin
        C := Q_PCompStr(LeftBound,RightBound);
        if not ((C>0) or ((C=0) and (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
          RaiseInvalidRangeBounds(Self, IndName);
      end;
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_PCompStr(KeyOf_PChar(IndList^[I]),LeftBound);
          if C > 0 then
            L := I + 1
          else
          begin
            if Unique and (C=0) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_PCompStr(KeyOf_PChar(IndList^[I]),LeftBound) >= 0 then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_PCompStr(KeyOf_PChar(IndList^[I]),RightBound);
          if C < 0 then
            H := I - 1
          else
          begin
            if Unique and (C=0) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_PCompStr(KeyOf_PChar(IndList^[I]),RightBound) <= 0 then
            H := I - 1
          else
            L := I + 1;
        end;
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.SelectRange_PChar_I(PIR: PTVIndexRec; LeftBound,
  RightBound: PChar; var Index: Integer; LeftTerm, RightTerm: Integer): Integer;
var
  L,H,I: Integer;
  C: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itPChar_I then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      if (LeftTerm<>rtInfinite) and (RightTerm<>rtInfinite) then
      begin
        C := Q_PCompText(LeftBound,RightBound);
        if not ((C<0) or ((C=0) and (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
          RaiseInvalidRangeBounds(Self, IndName);
      end;
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_PCompText(KeyOf_PChar_I(IndList^[I]),LeftBound);
          if C < 0 then
            L := I + 1
          else
          begin
            if Unique and (C=0) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_PCompText(KeyOf_PChar_I(IndList^[I]),LeftBound) <= 0 then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_PCompText(KeyOf_PChar_I(IndList^[I]),RightBound);
          if C > 0 then
            H := I - 1
          else
          begin
            if Unique and (C=0) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_PCompText(KeyOf_PChar_I(IndList^[I]),RightBound) >= 0 then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if (LeftTerm<>rtInfinite) and (RightTerm<>rtInfinite) then
      begin
        C := Q_PCompText(LeftBound,RightBound);
        if not ((C>0) or ((C=0) and (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
          RaiseInvalidRangeBounds(Self, IndName);
      end;
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_PCompText(KeyOf_PChar_I(IndList^[I]),LeftBound);
          if C > 0 then
            L := I + 1
          else
          begin
            if Unique and (C=0) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_PCompText(KeyOf_PChar_I(IndList^[I]),LeftBound) >= 0 then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_PCompText(KeyOf_PChar_I(IndList^[I]),RightBound);
          if C < 0 then
            H := I - 1
          else
          begin
            if Unique and (C=0) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_PCompText(KeyOf_PChar_I(IndList^[I]),RightBound) <= 0 then
            H := I - 1
          else
            L := I + 1;
        end;
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.SelectRange_Pointer(PIR: PTVIndexRec; LeftBound,
  RightBound: Pointer; var Index: Integer; LeftTerm, RightTerm: Integer): Integer;
var
  L,H,I: Integer;
  C,LB,RB: LongWord;
begin
  LB := LongWord(LeftBound);
  RB := LongWord(RightBound);
  with PIR^ do
  begin
    if IndType <> itPointer then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LB<RB) or ((LB=RB) and (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := LongWord(KeyOf_Pointer(IndList^[I]));
          if C < LB then
            L := I + 1
          else
          begin
            if Unique and (C=LB) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if LongWord(KeyOf_Pointer(IndList^[I])) <= LB then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := LongWord(KeyOf_Pointer(IndList^[I]));
          if C > RB then
            H := I - 1
          else
          begin
            if Unique and (C=RB) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if LongWord(KeyOf_Pointer(IndList^[I])) >= RB then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LB>RB) or ((LB=RB) and (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := LongWord(KeyOf_Pointer(IndList^[I]));
          if C > LB then
            L := I + 1
          else
          begin
            if Unique and (C=LB) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if LongWord(KeyOf_Pointer(IndList^[I])) >= LB then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := LongWord(KeyOf_Pointer(IndList^[I]));
          if C < RB then
            H := I - 1
          else
          begin
            if Unique and (C=RB) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if LongWord(KeyOf_Pointer(IndList^[I])) <= RB then
            H := I - 1
          else
            L := I + 1;
        end;
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.SelectRange_Shortint(PIR: PTVIndexRec; LeftBound,
  RightBound: Shortint; var Index: Integer; LeftTerm, RightTerm: Integer): Integer;
var
  L,H,I: Integer;
  C,LB,RB: Integer;
begin
  LB := LeftBound;
  RB := RightBound;
  with PIR^ do
  begin
    if IndType <> itShortint then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LB<RB) or ((LB=RB) and (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Shortint(IndList^[I]) - LB;
          if C < 0 then
            L := I + 1
          else
          begin
            if Unique and (C=0) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Shortint(IndList^[I]) <= LB then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Shortint(IndList^[I]) - RB;
          if C > 0 then
            H := I - 1
          else
          begin
            if Unique and (C=0) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Shortint(IndList^[I]) >= RB then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LB>RB) or ((LB=RB) and (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Shortint(IndList^[I]) - LB;
          if C > 0 then
            L := I + 1
          else
          begin
            if Unique and (C=0) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Shortint(IndList^[I]) >= LB then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Shortint(IndList^[I]) - RB;
          if C < 0 then
            H := I - 1
          else
          begin
            if Unique and (C=0) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Shortint(IndList^[I]) <= RB then
            H := I - 1
          else
            L := I + 1;
        end;
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.SelectRange_Single(PIR: PTVIndexRec; LeftBound,
  RightBound: Single; var Index: Integer; LeftTerm, RightTerm: Integer): Integer;
var
  L,H,I: Integer;
  C: Single;
begin
  with PIR^ do
  begin
    if IndType <> itSingle then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LeftBound<RightBound) or ((LeftBound=RightBound) and
          (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Single(IndList^[I]);
          if C < LeftBound then
            L := I + 1
          else
          begin
            if Unique and (C=LeftBound) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Single(IndList^[I]) <= LeftBound then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Single(IndList^[I]);
          if C > RightBound then
            H := I - 1
          else
          begin
            if Unique and (C=RightBound) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Single(IndList^[I]) >= RightBound then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LeftBound>RightBound) or ((LeftBound=RightBound) and
          (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Single(IndList^[I]);
          if C > LeftBound then
            L := I + 1
          else
          begin
            if Unique and (C=LeftBound) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Single(IndList^[I]) >= LeftBound then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Single(IndList^[I]);
          if C < RightBound then
            H := I - 1
          else
          begin
            if Unique and (C=RightBound) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Single(IndList^[I]) <= RightBound then
            H := I - 1
          else
            L := I + 1;
        end;
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.SelectRange_Smallint(PIR: PTVIndexRec; LeftBound,
  RightBound: Smallint; var Index: Integer; LeftTerm, RightTerm: Integer): Integer;
var
  L,H,I: Integer;
  C,LB,RB: Integer;
begin
  LB := LeftBound;
  RB := RightBound;
  with PIR^ do
  begin
    if IndType <> itSmallint then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LB<RB) or ((LB=RB) and (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Smallint(IndList^[I]) - LB;
          if C < 0 then
            L := I + 1
          else
          begin
            if Unique and (C=0) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Smallint(IndList^[I]) <= LB then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Smallint(IndList^[I]) - RB;
          if C > 0 then
            H := I - 1
          else
          begin
            if Unique and (C=0) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Smallint(IndList^[I]) >= RB then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LB>RB) or ((LB=RB) and (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Smallint(IndList^[I]) - LB;
          if C > 0 then
            L := I + 1
          else
          begin
            if Unique and (C=0) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Smallint(IndList^[I]) >= LB then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Smallint(IndList^[I]) - RB;
          if C < 0 then
            H := I - 1
          else
          begin
            if Unique and (C=0) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Smallint(IndList^[I]) <= RB then
            H := I - 1
          else
            L := I + 1;
        end;
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.SelectRange_String(PIR: PTVIndexRec; const LeftBound,
  RightBound: string; var Index: Integer; LeftTerm, RightTerm: Integer): Integer;
var
  L,H,I: Integer;
  C: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itString then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      if (LeftTerm<>rtInfinite) and (RightTerm<>rtInfinite) then
      begin
        C := Q_CompStr(LeftBound,RightBound);
        if not ((C<0) or ((C=0) and (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
          RaiseInvalidRangeBounds(Self, IndName);
      end;
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_CompStr(KeyOf_String(IndList^[I]),LeftBound);
          if C < 0 then
            L := I + 1
          else
          begin
            if Unique and (C=0) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_CompStr(KeyOf_String(IndList^[I]),LeftBound) <= 0 then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_CompStr(KeyOf_String(IndList^[I]),RightBound);
          if C > 0 then
            H := I - 1
          else
          begin
            if Unique and (C=0) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_CompStr(KeyOf_String(IndList^[I]),RightBound) >= 0 then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if (LeftTerm<>rtInfinite) and (RightTerm<>rtInfinite) then
      begin
        C := Q_CompStr(LeftBound,RightBound);
        if not ((C>0) or ((C=0) and (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
          RaiseInvalidRangeBounds(Self, IndName);
      end;
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_CompStr(KeyOf_String(IndList^[I]),LeftBound);
          if C > 0 then
            L := I + 1
          else
          begin
            if Unique and (C=0) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_CompStr(KeyOf_String(IndList^[I]),LeftBound) >= 0 then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_CompStr(KeyOf_String(IndList^[I]),RightBound);
          if C < 0 then
            H := I - 1
          else
          begin
            if Unique and (C=0) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_CompStr(KeyOf_String(IndList^[I]),RightBound) <= 0 then
            H := I - 1
          else
            L := I + 1;
        end;
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.SelectRange_String_I(PIR: PTVIndexRec; const LeftBound,
  RightBound: string; var Index: Integer; LeftTerm, RightTerm: Integer): Integer;
var
  L,H,I: Integer;
  C: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itString_I then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      if (LeftTerm<>rtInfinite) and (RightTerm<>rtInfinite) then
      begin
        C := Q_CompText(LeftBound,RightBound);
        if not ((C<0) or ((C=0) and (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
          RaiseInvalidRangeBounds(Self, IndName);
      end;
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_CompText(KeyOf_String_I(IndList^[I]),LeftBound);
          if C < 0 then
            L := I + 1
          else
          begin
            if Unique and (C=0) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_CompText(KeyOf_String_I(IndList^[I]),LeftBound) <= 0 then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_CompText(KeyOf_String_I(IndList^[I]),RightBound);
          if C > 0 then
            H := I - 1
          else
          begin
            if Unique and (C=0) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_CompText(KeyOf_String_I(IndList^[I]),RightBound) >= 0 then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if (LeftTerm<>rtInfinite) and (RightTerm<>rtInfinite) then
      begin
        C := Q_CompText(LeftBound,RightBound);
        if not ((C>0) or ((C=0) and (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
          RaiseInvalidRangeBounds(Self, IndName);
      end;
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_CompText(KeyOf_String_I(IndList^[I]),LeftBound);
          if C > 0 then
            L := I + 1
          else
          begin
            if Unique and (C=0) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_CompText(KeyOf_String_I(IndList^[I]),LeftBound) >= 0 then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := Q_CompText(KeyOf_String_I(IndList^[I]),RightBound);
          if C < 0 then
            H := I - 1
          else
          begin
            if Unique and (C=0) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_CompText(KeyOf_String_I(IndList^[I]),RightBound) <= 0 then
            H := I - 1
          else
            L := I + 1;
        end;
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.SelectRange_TDateTime(PIR: PTVIndexRec; LeftBound,
  RightBound: TDateTime; var Index: Integer; LeftTerm, RightTerm: Integer): Integer;
var
  L,H,I: Integer;
  C: TDateTime;
begin
  with PIR^ do
  begin
    if IndType <> itTDateTime then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LeftBound<RightBound) or ((LeftBound=RightBound) and
          (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_TDateTime(IndList^[I]);
          if C < LeftBound then
            L := I + 1
          else
          begin
            if Unique and (C=LeftBound) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_TDateTime(IndList^[I]) <= LeftBound then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_TDateTime(IndList^[I]);
          if C > RightBound then
            H := I - 1
          else
          begin
            if Unique and (C=RightBound) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_TDateTime(IndList^[I]) >= RightBound then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LeftBound>RightBound) or ((LeftBound=RightBound) and
          (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_TDateTime(IndList^[I]);
          if C > LeftBound then
            L := I + 1
          else
          begin
            if Unique and (C=LeftBound) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_TDateTime(IndList^[I]) >= LeftBound then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_TDateTime(IndList^[I]);
          if C < RightBound then
            H := I - 1
          else
          begin
            if Unique and (C=RightBound) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_TDateTime(IndList^[I]) <= RightBound then
            H := I - 1
          else
            L := I + 1;
        end;
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.SelectRange_UserCmp(PIR: PTVIndexRec; LeftBound,
  RightBound: Pointer; var Index: Integer; LeftTerm, RightTerm: Integer): Integer;
var
  L,H,I: Integer;
  C: Integer;
begin
  with PIR^ do
  begin
    if IndType <> itUserCmp then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := UserKeyCompare(IndList^[I],LeftBound);
          if C < 0 then
            L := I + 1
          else
          begin
            if Unique and (C=0) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if UserKeyCompare(IndList^[I],LeftBound) <= 0 then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := UserKeyCompare(IndList^[I],RightBound);
          if C > 0 then
            H := I - 1
          else
          begin
            if Unique and (C=0) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if UserKeyCompare(IndList^[I],RightBound) >= 0 then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := UserKeyCompare(IndList^[I],LeftBound);
          if C > 0 then
            L := I + 1
          else
          begin
            if Unique and (C=0) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if UserKeyCompare(IndList^[I],LeftBound) >= 0 then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := UserKeyCompare(IndList^[I],RightBound);
          if C < 0 then
            H := I - 1
          else
          begin
            if Unique and (C=0) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if UserKeyCompare(IndList^[I],RightBound) <= 0 then
            H := I - 1
          else
            L := I + 1;
        end;
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.SelectRange_Word(PIR: PTVIndexRec; LeftBound,
  RightBound: Word; var Index: Integer; LeftTerm, RightTerm: Integer): Integer;
var
  L,H,I: Integer;
  C,LB,RB: Integer;
begin
  LB := LeftBound;
  RB := RightBound;
  with PIR^ do
  begin
    if IndType <> itWord then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LB<RB) or ((LB=RB) and (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Word(IndList^[I]) - LB;
          if C < 0 then
            L := I + 1
          else
          begin
            if Unique and (C=0) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Word(IndList^[I]) <= LB then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Word(IndList^[I]) - RB;
          if C > 0 then
            H := I - 1
          else
          begin
            if Unique and (C=0) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Word(IndList^[I]) >= RB then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if not ((LeftTerm=rtInfinite) or (RightTerm=rtInfinite) or
          (LB>RB) or ((LB=RB) and (LeftTerm=rtInclude) and (RightTerm=rtInclude))) then
        RaiseInvalidRangeBounds(Self, IndName);
      if LeftTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Word(IndList^[I]) - LB;
          if C > 0 then
            L := I + 1
          else
          begin
            if Unique and (C=0) then
            begin
              L := I;
              Break;
            end;
            H := I - 1;
          end;
        end
      else if LeftTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Word(IndList^[I]) >= LB then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      if RightTerm = rtInclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := KeyOf_Word(IndList^[I]) - RB;
          if C < 0 then
            H := I - 1
          else
          begin
            if Unique and (C=0) then
            begin
              H := I;
              Break;
            end;
            L := I + 1;
          end;
        end
      else if RightTerm = rtExclude then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if KeyOf_Word(IndList^[I]) <= RB then
            H := I - 1
          else
            L := I + 1;
        end;
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.StartWith_PChar(PIR: PTVIndexRec; P: PChar;
  var Index: Integer): Integer;
var
  L,H,I: Integer;
  C: Integer;
  DStr: string;
  PD: PChar;
  Flag: Boolean;
begin
  with PIR^ do
  begin
    if IndType <> itPChar then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    Flag := True;
    DStr := P;
    PD := Pointer(DStr);
    for I := Length(DStr)-1 downto 0 do
      if PD[I] <> #255 then
      begin
        Inc(PD[I]);
        Flag := False;
        Break;
      end else
        PD[I] := #0;
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      while L <= H do
      begin
        I := (L + H) shr 1;
        C := Q_PCompStr(KeyOf_PChar(IndList^[I]),P);
        if C < 0 then
          L := I + 1
        else
        begin
          if Unique and (C=0) then
          begin
            L := I;
            Break;
          end;
          H := I - 1;
        end;
      end;
      Index := L;
      H := FCount-1;
      if not Flag then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_PCompStr(KeyOf_PChar(IndList^[I]),PD) >= 0 then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if not Flag then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_PCompStr(KeyOf_PChar(IndList^[I]),PD) >= 0 then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      while L <= H do
      begin
        I := (L + H) shr 1;
        C := Q_PCompStr(KeyOf_PChar(IndList^[I]),P);
        if C < 0 then
          H := I - 1
        else
        begin
          if Unique and (C=0) then
          begin
            H := I;
            Break;
          end;
          L := I + 1;
        end;
      end
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.StartWith_PChar_I(PIR: PTVIndexRec; P: PChar;
  var Index: Integer): Integer;
var
  L,H,I: Integer;
  C: Integer;
  DStr: string;
  PD: PChar;
  Flag: Boolean;
begin
  with PIR^ do
  begin
    if IndType <> itPChar_I then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    Flag := True;
    DStr := P;
    Q_StrLower(DStr);
    PD := Pointer(DStr);
    for I := Length(DStr)-1 downto 0 do
      if PD[I] <> #255 then
      begin
        Inc(PD[I]);
        Flag := False;
        Break;
      end else
        PD[I] := #0;
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      while L <= H do
      begin
        I := (L + H) shr 1;
        C := Q_PCompText(KeyOf_PChar_I(IndList^[I]),P);
        if C < 0 then
          L := I + 1
        else
        begin
          if Unique and (C=0) then
          begin
            L := I;
            Break;
          end;
          H := I - 1;
        end;
      end;
      Index := L;
      H := FCount-1;
      if not Flag then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_PCompText(KeyOf_PChar_I(IndList^[I]),PD) >= 0 then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if not Flag then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_PCompText(KeyOf_PChar_I(IndList^[I]),PD) >= 0 then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      while L <= H do
      begin
        I := (L + H) shr 1;
        C := Q_PCompText(KeyOf_PChar_I(IndList^[I]),P);
        if C < 0 then
          H := I - 1
        else
        begin
          if Unique and (C=0) then
          begin
            H := I;
            Break;
          end;
          L := I + 1;
        end;
      end
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.StartWith_String(PIR: PTVIndexRec;
  const S: string; var Index: Integer): Integer;
var
  L,H,I: Integer;
  C: Integer;
  DStr: string;
  PD: PChar;
  Flag: Boolean;
begin
  with PIR^ do
  begin
    if IndType <> itString then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    Flag := True;
    L := Length(S);
    SetString(DStr,PChar(S),L);
    PD := Pointer(DStr);
    for I := L-1 downto 0 do
      if PD[I] <> #255 then
      begin
        Inc(PD[I]);
        Flag := False;
        Break;
      end else
        PD[I] := #0;
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      while L <= H do
      begin
        I := (L + H) shr 1;
        C := Q_CompStr(KeyOf_String(IndList^[I]),S);
        if C < 0 then
          L := I + 1
        else
        begin
          if Unique and (C=0) then
          begin
            L := I;
            Break;
          end;
          H := I - 1;
        end;
      end;
      Index := L;
      H := FCount-1;
      if not Flag then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_CompStr(KeyOf_String(IndList^[I]),DStr) >= 0 then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if not Flag then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_CompStr(KeyOf_String(IndList^[I]),DStr) >= 0 then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      while L <= H do
      begin
        I := (L + H) shr 1;
        C := Q_CompStr(KeyOf_String(IndList^[I]),S);
        if C < 0 then
          H := I - 1
        else
        begin
          if Unique and (C=0) then
          begin
            H := I;
            Break;
          end;
          L := I + 1;
        end;
      end
    end;
  end;
  Result := H+1-Index;
end;

function TVUniCollection.StartWith_String_I(PIR: PTVIndexRec;
  const S: string; var Index: Integer): Integer;
var
  L,H,I: Integer;
  C: Integer;
  DStr: string;
  PD: PChar;
  Flag: Boolean;
begin
  with PIR^ do
  begin
    if IndType <> itString_I then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    if not Regular then
      RaiseTVErrObjS(STVNonRegularSelRange, Self, IndName);
    if not Active then
      UpdateIndexByPIR(PIR);
    Flag := True;
    L := Length(S);
    SetString(DStr,nil,L);
    Q_StrLowerMoveL(S,DStr,L);
    PD := Pointer(DStr);
    for I := L-1 downto 0 do
      if PD[I] <> #255 then
      begin
        Inc(PD[I]);
        Flag := False;
        Break;
      end else
        PD[I] := #0;
    L := 0;
    H := FCount - 1;
    if not Descending then
    begin
      while L <= H do
      begin
        I := (L + H) shr 1;
        C := Q_CompText(KeyOf_String_I(IndList^[I]),S);
        if C < 0 then
          L := I + 1
        else
        begin
          if Unique and (C=0) then
          begin
            L := I;
            Break;
          end;
          H := I - 1;
        end;
      end;
      Index := L;
      H := FCount-1;
      if not Flag then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_CompText(KeyOf_String_I(IndList^[I]),DStr) >= 0 then
            H := I - 1
          else
            L := I + 1;
        end;
    end else
    begin
      if not Flag then
        while L <= H do
        begin
          I := (L + H) shr 1;
          if Q_CompText(KeyOf_String_I(IndList^[I]),DStr) >= 0 then
            L := I + 1
          else
            H := I - 1;
        end;
      Index := L;
      H := FCount-1;
      while L <= H do
      begin
        I := (L + H) shr 1;
        C := Q_CompText(KeyOf_String_I(IndList^[I]),S);
        if C < 0 then
          H := I - 1
        else
        begin
          if Unique and (C=0) then
          begin
            H := I;
            Break;
          end;
          L := I + 1;
        end;
      end
    end;
  end;
  Result := H+1-Index;
end;

{ TVCollection }

constructor TVCollection.CreateFromList(ListObj: TList);
var
  I,Cnt: Integer;
  PIR: PTVIndexRec;
begin
  Create;
  SwitchToIndex(StdIndex);
  FCount := ListObj.Count;
  SetCapacity(FCount);
  Cnt := 0;
  for I := 0 to FCount - 1 do
  begin
    FList^[Cnt] := ListObj.List^[I];
    if FList^[Cnt] <> nil then
      Inc(Cnt);
  end;
  FCount := Cnt;
  FFreeIOD := False;
  if Cnt > 0 then
    for I := 0 to FIndexes.FCount-1 do
    begin
      PIR := FIndexes.FList^[I];
      if PIR^.Active then
      begin
        if PIR <> FCurrentIndex then
          Q_CopyLongs(FList,PIR^.IndList,FCount);
        UpdateIndexByPIR(PIR);
      end;
    end;
end;

procedure TVCollection.CopyToList(ListObj: TList);
var
  I: Integer;
begin
  with ListObj do
    if Capacity-Count < Self.FCount then
      Capacity := Count+Self.FCount;
  for I := 0 to FCount-1 do
    ListObj.Add(FList^[I]);
end;

constructor TVCollection.Create;
begin
  inherited;
  MakeStdIndex;
end;

constructor TVCollection.CreateRefsList;
begin
  Create;
  FFreeIOD := False;
end;

procedure TVCollection.MakeStdIndex;
var
  PIR: PTVIndexRec;
begin
  CreateIndexRec(PIR);
  PIR^.IndName := StdIndex;
  AddIndex(PIR,True);
end;

{ TVStringCollection }

var
  StringCollFields: packed record
    fldCount: SmallInt;
    fldLimit: SmallInt;
    fldDelta: SmallInt;
  end;

  StringBigCollFields: packed record
    fldBigFlag: SmallInt;
    fldCount: Integer;
    fldCapacity: Integer;
  end;

function TVStringCollection.Add(const S: string): Integer;
begin
  if not Find(S, Result) or FDuplicates then
  begin
    if FCount = FCapacity then
      Grow;
    if Result < FCount then
      Q_MoveLongs(@FList^[Result], @FList^[Result + 1], FCount - Result);
    Pointer(FList^[Result]) := nil;
    FList^[Result] := S;
    Inc(FCount);
  end else
    Result := -1;
end;

procedure TVStringCollection.Clear;
begin
  if FCount > 0 then
  begin
    Finalize(FList^[0], FCount);
    FCount := 0;
  end;
end;

constructor TVStringCollection.Create;
begin
  FDuplicates := False;
  FBig := True;
end;

constructor TVStringCollection.CreateFromStringList(StrList: TStringList);
var
  I, Cnt: Integer;
begin
  FBig := True;
  Cnt := StrList.Count;
  SetCapacity(Cnt);
  FDuplicates := StrList.Duplicates = dupAccept;
  for I := 0 to Cnt-1 do
    Add(StrList[I]);
end;

procedure TVStringCollection.Delete(Index: Integer);
begin
  if (Index >= 0) and (Index < FCount) then
  begin
    Finalize(FList^[Index]);
    Dec(FCount);
    if Index < FCount then
      Q_MoveLongs(@FList^[Index + 1], @FList^[Index], FCount - Index);
  end else
    RaiseTVErrD(STVCollIndexError, Index);
end;

destructor TVStringCollection.Destroy;
begin
  Clear;
  SetCapacity(0);
end;

function TVStringCollection.First: string;
begin
  if FCount <= 0 then
    RaiseTVErrD(STVCollIndexError, 0);
  Result := FList^[0];
end;

function TVStringCollection.Get(Index: Integer): string;
begin
  if (Index<0) or (Index>=FCount) then
    RaiseTVErrD(STVCollIndexError, Index);
  Result := FList^[Index];
end;

procedure TVStringCollection.Grow;
begin
  if FCapacity > 64 then
    SetCapacity(FCapacity + FCapacity shr 2)
  else if FCapacity > 8 then
    SetCapacity(FCapacity + 16)
  else
    SetCapacity(FCapacity + 4);
end;

function TVStringCollection.Find(const S: string; var Index: Integer): Boolean;
var
  L,H,I,C: Integer;
begin
  Result := False;
  L := 0;
  H := FCount - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := Q_CompStr(FList^[I], S);
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        if not FDuplicates then
        begin
          Index := I;
          Exit;
        end;
      end;
    end;
  end;
  Index := L;
end;

function TVStringCollection.Last: string;
begin
  if FCount <= 0 then
    RaiseTVErrD(STVCollIndexError, -1);
  Result := FList^[FCount-1];
end;

constructor TVStringCollection.Load(S: TVStream; Version: Word);
var
  I: Integer;
  W: SmallInt;
begin
  if Version = 1 then
  begin
    S.Read(W, 2);
    if W = -1 then
    begin
      FBig := True;
      S.Read(FCount,SizeOf(FCount));
      S.Read(I,SizeOf(I));
      SetCapacity(I);
    end else
    begin
      FCount := W;
      S.Read(I,SizeOf(I));
      SetCapacity(I and $7FFF);
    end;
    Q_FillLong(0,FList,FCount);
    for I := 0 to FCount - 1 do
      FList^[I] := S.ReadStr;
    S.Read(FDuplicates,1);
  end else
    RaiseVersionNotSupported(Self, Version);
end;

procedure TVStringCollection.SetCapacity(NewCapacity: Integer);
begin
  if NewCapacity <> FCapacity then
    if (NewCapacity >= FCount) and ((NewCapacity <= MaxTVCompatibleCollSize) or
      (FBig and (NewCapacity <= MaxCollectionSize))) then
    begin
      ReallocMem(FList, NewCapacity * SizeOf(string));
      FCapacity := NewCapacity;
    end else
      RaiseTVErrD(STVCollCapacityError, NewCapacity);
end;

procedure TVStringCollection.Store(S: TVStream);
var
  I: Integer;
begin
  if FBig then
  begin
    with StringBigCollFields do
    begin
      fldBigFlag := -1;
      fldCount := FCount;
      fldCapacity := FCapacity;
    end;
    S.Write(StringBigCollFields,SizeOf(StringBigCollFields));
  end else
  begin
    with StringCollFields do
    begin
      fldCount := SmallInt(FCount);
      fldLimit := SmallInt(FCapacity);
      if FCapacity > 64 then
        fldDelta := FCapacity shr 2
      else if FCapacity > 8 then
        fldDelta := 16
      else
        fldDelta := 4;
    end;
    S.Write(StringCollFields, 6);
  end;
  for I := 0 to FCount-1 do
    S.WriteStr(FList^[I]);
  S.Write(FDuplicates,1);
end;

procedure TVStringCollection.CopyToStrings(StrList: TStrings);
var
  I: Integer;
begin
  with StrList do
    if Capacity-Count < Self.FCount then
      Capacity := Count+Self.FCount;
  for I := 0 to FCount-1 do
    StrList.Add(FList^[I]);
end;

function TVStringCollection.Clone: Pointer;
var
  P: TVStringCollection;
  I: Integer;
begin
  P := TVStringCollection(inherited Clone);
  P.FCount := FCount;
  P.FBig := FBig;
  P.SetCapacity(FCapacity);
  P.FDuplicates := FDuplicates;
  Q_FillLong(0,P.FList,FCount);
  for I := 0 to FCount - 1 do
    P.FList^[I] := FList^[I];
  Result := P;
end;

procedure TVStringCollection.SetChanged(Value: Boolean);
begin
  FChanged := Value;
  if Value and (FOwner<>nil) then
    FOwner.SetChanged(True);
end;

function TVStringCollection.GetTextStr: string;
var
  I, L, Sz: Integer;
  P: PChar;
begin
  Sz := 0;
  for I := 0 to FCount - 1 do
    Inc(Sz, Length(FList^[I]) + 2);
  SetString(Result, nil, Sz);
  P := Pointer(Result);
  for I := 0 to FCount - 1 do
  begin
    L := Length(FList^[I]);
    if L <> 0 then
    begin
      Q_CopyMem(Pointer(FList^[I]), P, L);
      Inc(P, L);
    end;
    P^ := #13;
    Inc(P);
    P^ := #10;
    Inc(P);
  end;
end;

procedure TVStringCollection.SetTextStr(const Value: string);
var
  S: string;
begin
  Clear;
  SetString(S,PChar(Value),Length(Value));
  while Length(S) > 0 do
    Add(Q_StrTok(S,[#10,#13]));
end;

procedure TVStringCollection.ToUpperCase;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    Q_StrUpper(FList^[I]);
end;

procedure TVStringCollection.ToLowerCase;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    Q_StrLower(FList^[I]);
end;

procedure TVStringCollection.ToUpLowerCase;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    Q_UpLowerInPlace(FList^[I]);
end;

procedure TVStringCollection.ConvertToAnsi;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    Q_StrToAnsi(FList^[I]);
end;

procedure TVStringCollection.ConvertToOem;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    Q_StrToOem(FList^[I]);
end;

{ TVIntegerSet }

procedure TVIntegerSet.Clear;
begin
  Count := 0;
end;

function TVIntegerSet.Clone: Pointer;
begin
  Result := inherited Clone;
  with TVIntegerSet(Result) do
  begin
    Count := Self.Count;
    SetCapacity(Count);
    Q_CopyLongs(Self.List,List,Count);
  end;
end;

procedure TVIntegerSet.Complement(Number: Integer);
var
  Index: Integer;
begin
  Index := Q_ScanInteger(Number,List,Count);
  if Index <> -1 then
  begin
    Dec(Count);
    if Index < Count then
      Q_MoveLongs(@List^[Index+1],@List^[Index],Count-Index);
  end else
  begin
    if Count = Capacity then
      Grow;
    List^[Count] := Number;
    Inc(Count);
  end;
end;

procedure TVIntegerSet.Delete(Index: Integer);
begin
  if (Index >= 0) and (Index < Count) then
  begin
    Dec(Count);
    if Index < Count then
      Q_MoveLongs(@List^[Index + 1], @List^[Index], Count-Index);
  end else
    RaiseTVErrD(STVCollIndexError, Index);
end;

destructor TVIntegerSet.Destroy;
begin
  Clear;
  SetCapacity(0);
end;

procedure TVIntegerSet.Exclude(Number: Integer);
var
  Index: Integer;
begin
  Index := Q_ScanInteger(Number,List,Count);
  if Index <> -1 then
  begin
    Dec(Count);
    if Index < Count then
      Q_MoveLongs(@List^[Index + 1],@List^[Index],Count-Index);
  end;
end;

function TVIntegerSet.Get(Index: Integer): Integer;
begin
  if (Index<0) or (Index>=Count) then
    RaiseTVErrD(STVCollIndexError, Index);
  Result := List^[Index];
end;

procedure TVIntegerSet.Grow;
begin
  if Capacity > 64 then
    SetCapacity(Capacity + Capacity shr 2)
  else if Capacity > 8 then
    SetCapacity(Capacity + 16)
  else
    SetCapacity(Capacity + 4);
end;

procedure TVIntegerSet.Include(Number: Integer);
begin
  if Q_ScanInteger(Number,List,Count) = -1 then
  begin
    if Count = Capacity then
      Grow;
    List^[Count] := Number;
    Inc(Count);
  end;
end;

constructor TVIntegerSet.Load(S: TVStream; Version: Word);
begin
  if Version = 1 then
  begin
    S.Read(Count, SizeOf(Count));
    if Count > 0 then
    begin
      SetCapacity(Count);
      S.ReadB(List^,Count*SizeOf(Integer));
    end;
  end else
    RaiseVersionNotSupported(Self,Version);
end;

procedure TVIntegerSet.ReverseItems;
begin
  Q_ReverseLongArr(List,Count);
end;

procedure TVIntegerSet.SetCapacity(NewCapacity: Integer);
begin
  if NewCapacity <> Capacity then
    if (NewCapacity >= Count) and (NewCapacity <= MaxCollectionSize) then
    begin
      ReallocMem(List, NewCapacity * SizeOf(Integer));
      Capacity := NewCapacity;
    end else
      RaiseTVErrD(STVCollCapacityError, NewCapacity);
end;

procedure TVIntegerSet.SetChanged(Value: Boolean);
begin
  FChanged := Value;
  if Value and (Owner<>nil) then
    Owner.SetChanged(True);
end;

procedure TVIntegerSet.Store(S: TVStream);
begin
  S.Write(Count,SizeOf(Count));
  if Count > 0 then
    S.Write(List^,Count*SizeOf(Integer));
end;

function TVIntegerSet.Test(Number: Integer): Boolean;
begin
  Result := Q_ScanInteger(Number, List, Count) <> -1;
end;

{ TVWordSet }

procedure TVWordSet.Clear;
begin
  Count := 0;
end;

function TVWordSet.Clone: Pointer;
begin
  Result := inherited Clone;
  with TVWordSet(Result) do
  begin
    Count := Self.Count;
    SetCapacity(Count);
    Q_CopyMem(Self.List,List,Count*SizeOf(Word));
  end;
end;

procedure TVWordSet.Complement(Number: Word);
var
  Index: Integer;
begin
  Index := Q_ScanWord(Number,List,Count);
  if Index <> -1 then
  begin
    Dec(Count);
    if Index < Count then
      Q_MoveWords(@List^[Index+1],@List^[Index],Count-Index);
  end else
  begin
    if Count = Capacity then
      Grow;
    List^[Count] := Number;
    Inc(Count);
  end;
end;

procedure TVWordSet.Delete(Index: Integer);
begin
  if (Index >= 0) and (Index < Count) then
  begin
    Dec(Count);
    if Index < Count then
      Q_MoveWords(@List^[Index + 1], @List^[Index], Count-Index);
  end else
    RaiseTVErrD(STVCollIndexError, Index);
end;

destructor TVWordSet.Destroy;
begin
  Clear;
  SetCapacity(0);
end;

procedure TVWordSet.Exclude(Number: Word);
var
  Index: Integer;
begin
  Index := Q_ScanWord(Number,List,Count);
  if Index <> -1 then
  begin
    Dec(Count);
    if Index < Count then
      Q_MoveWords(@List^[Index + 1], @List^[Index], Count - Index);
  end;
end;

function TVWordSet.Get(Index: Integer): Word;
begin
  if (Index<0) or (Index>=Count) then
    RaiseTVErrD(STVCollIndexError, Index);
  Result := List^[Index];
end;

procedure TVWordSet.Grow;
begin
  if Capacity > 64 then
    SetCapacity(Capacity + Capacity shr 2)
  else if Capacity > 8 then
    SetCapacity(Capacity + 16)
  else
    SetCapacity(Capacity + 4);
end;

procedure TVWordSet.Include(Number: Word);
begin
  if Q_ScanWord(Number,List,Count) = -1 then
  begin
    if Count = Capacity then
      Grow;
    List^[Count] := Number;
    Inc(Count);
  end;
end;

constructor TVWordSet.Load(S: TVStream; Version: Word);
begin
  if Version = 1 then
  begin
    S.Read(Count,SizeOf(Count));
    if Count > 0 then
    begin
      SetCapacity(Count);
      S.ReadB(List^,Count*SizeOf(Word));
    end;
  end else
    RaiseVersionNotSupported(Self, Version);
end;

procedure TVWordSet.ReverseItems;
begin
  Q_ReverseWordArr(List,Count);
end;

procedure TVWordSet.SetCapacity(NewCapacity: Integer);
begin
  if NewCapacity <> Capacity then
    if (NewCapacity >= Count) and (NewCapacity <= MaxCollectionSize) then
    begin
      ReallocMem(List, NewCapacity * SizeOf(Word));
      Capacity := NewCapacity;
    end else
      RaiseTVErrD(STVCollCapacityError, NewCapacity);
end;

procedure TVWordSet.SetChanged(Value: Boolean);
begin
  FChanged := Value;
  if Value and (Owner<>nil) then
    Owner.SetChanged(True);
end;

procedure TVWordSet.Store(S: TVStream);
begin
  S.Write(Count,SizeOf(Count));
  if Count > 0 then
    S.Write(List^,Count*SizeOf(Word));
end;

function TVWordSet.Test(Number: Word): Boolean;
begin
  Result := Q_ScanWord(Number, List, Count) <> -1;
end;

{ TVRandomGenerator }

function TVRandomGenerator.Clone: Pointer;
var
  Vector: TRandVector;
begin
  Q_RandGetVector(FID,Vector);
  Result := inherited Clone;
  Q_RandSetVector(TVRandomGenerator(Result).FID,Vector);
end;

constructor TVRandomGenerator.Create;
begin
  Q_RandInit(FID,LongWord(Q_TimeStamp));
end;

constructor TVRandomGenerator.CreateFixed(Seed: LongWord);
begin
  Q_RandInit(FID,Seed);
end;

destructor TVRandomGenerator.Destroy;
begin
  Q_RandDone(FID);
end;

constructor TVRandomGenerator.Load(S: TVStream; Version: Word);
var
  Vector: TRandVector;
begin
  if Version = 1 then
  begin
    S.Read(Vector,SizeOf(TRandVector));
    Q_RandInit(FID,Vector);
  end else
    RaiseVersionNotSupported(Self, Version);
end;

procedure TVRandomGenerator.Store(S: TVStream);
var
  Vector: TRandVector;
begin
  Q_RandGetVector(FID,Vector);
  S.Write(Vector,SizeOf(TRandVector));
end;

procedure TVRandomGenerator.Update1(const S: string; UseTSC: Boolean);
begin
  if UseTSC then
    Q_RandCAST6Update(FID,S+Q_UIntToStr(LongWord(Q_TimeStamp)))
  else
    Q_RandCAST6Update(FID,S);
end;

procedure TVRandomGenerator.Update2(const S: string; UseTSC: Boolean);
begin
  if UseTSC then
    Q_RandRC6Update(FID,S+Q_UIntToStr(LongWord(Q_TimeStamp)))
  else
    Q_RandRC6Update(FID,S);
end;

{ TVMarks }

var
  MarksFields: packed record
    fldCount: Integer;
    fldMarkCount: Integer;
  end;

function TVMarks.Clone: Pointer;
var
  P: TVMarks;
begin
  P := TVMarks(inherited Clone);
  if FCount > 0 then
  begin
    P.FSize := FSize;
    GetMem(P.FList, FSize * SizeOf(LongWord));
    P.FCount := FCount;
    P.FMarkCount := FMarkCount;
    Q_CopyLongs(FList, P.FList, FSize);
  end;
  Result := P;
end;

destructor TVMarks.Destroy;
begin
  if FSize > 0 then
    FreeMem(FList);
end;

procedure MarksIntEx(WrongIndex: Integer);
begin
  RaiseTVErrD(STVCollIndexError, WrongIndex);
end;

function TVMarks.GetMark(Index: Integer): Boolean;
asm
        TEST    EDX,EDX
        JL      @@err
        CMP     EDX,[EAX].FCount
        JGE     @@err
        MOV     EAX,[EAX].FList
        BT      [EAX],EDX
        SBB     EAX,EAX
        AND     EAX,1
        RET
@@err:
        MOV     EAX,EDX
        CALL    MarksIntEx
end;

function TVMarks.SearchMarked: Integer;
begin
  Result := Q_SetBitScanForward(FList,0,MarkCount-1);
end;

function TVMarks.SearchNextMarked(var Index: Integer): Boolean;
begin
  if (Index>=-1) and (Index<MarkCount) then
  begin
    Index := Q_SetBitScanForward(FList,Index+1,MarkCount-1);
    Result := Index <> -1;
  end else
  begin
    RaiseTVErrD(STVCollIndexError, Index);
    Result := False;
  end;
end;

function TVMarks.SearchFree: Integer;
begin
  Result := Q_FreeBitScanForward(FList,0,MarkCount-1);
end;

function TVMarks.SearchNextFree(var Index: Integer): Boolean;
begin
  if (Index>=-1) and (Index<MarkCount) then
  begin
    Index := Q_FreeBitScanForward(FList,Index+1,MarkCount-1);
    Result := Index <> -1;
  end else
  begin
    RaiseTVErrD(STVCollIndexError, Index);
    Result := False;
  end;
end;

function TVMarks.GetFreeCount: Integer;
begin
  Result := FCount-FMarkCount;
end;

procedure TVMarks.InvertAllMarks;
begin
  Q_NOTLongArr(FList,FSize);
  FMarkCount := FCount-FMarkCount;
end;

procedure TVMarks.InvertMark(Index: Integer);
asm
        TEST    EDX,EDX
        JL      @@err
        CMP     EDX,[EAX].FCount
        JGE     @@err
        MOV     ECX,EAX
        MOV     EAX,[EAX].FList
        BTC     [EAX],EDX
        JC      @@removemark
        INC     [ECX].FMarkCount
        RET
@@removemark:
        DEC     [ECX].FMarkCount
        RET
@@err:
        MOV     EAX,EDX
        CALL    MarksIntEx
end;

constructor TVMarks.Load(S: TVStream; Version: Word);
begin
  if Version = 1 then
  begin
    S.Read(MarksFields,SizeOf(MarksFields));
    with MarksFields do
    begin
      FCount := fldCount;
      FMarkCount := fldMarkCount;
    end;
    if FCount > 0 then
    begin
      FSize := (FCount-1) shr 5 + 1;
      GetMem(FList, FSize * SizeOf(LongWord));
      S.ReadB(FList^, FSize * SizeOf(LongWord));
    end;
  end else
    RaiseVersionNotSupported(Self, Version);
end;

procedure TVMarks.SetAllMarked;
begin
  Q_FillLong($FFFFFFFF,FList,FSize);
  FMarkCount := FCount;
end;

procedure TVMarks.SetAllFree;
begin
  Q_FillLong(0,FList,FSize);
  FMarkCount := 0;
end;

procedure TVMarks.SetChanged(Value: Boolean);
begin
  FChanged := Value;
  if Value and (FOwner<>nil) then
    FOwner.SetChanged(True);
end;

procedure TVMarks.SetCount(ACount: Integer);
begin
  if ACount <= MaxTVMarkCount then
  begin
    if ACount > 0 then
    begin
      if ACount <> FCount then
      begin
        if FSize > 0 then
          FreeMem(FList);
        FSize := (ACount-1) shr 5 + 1;
        GetMem(FList, FSize * SizeOf(LongWord));
        FCount := ACount;
      end;
      Q_FillLong(0,FList,FSize);
    end else
    begin
      if FSize > 0 then
        FreeMem(FList);
      FSize := 0;
      FCount := 0;
      FList := nil;
    end;
    FMarkCount := 0;
  end else
    RaiseTVErrD(STVCollCapacityError, ACount);
end;

procedure TVMarks.SetMark(Index: Integer; Value: Boolean);
asm
        TEST    EDX,EDX
        JL      @@err
        CMP     EDX,[EAX].FCount
        JGE     @@err
        OR      CL,CL
        JZ      @@removemark
        MOV     ECX,EAX
        MOV     EAX,[EAX].FList
        BTS     [EAX],EDX
        JC      @@quit
        INC     [ECX].FMarkCount
        RET
@@removemark:
        MOV     ECX,EAX
        MOV     EAX,[EAX].FList
        BTR     [EAX],EDX
        JNC     @@quit
        DEC     [ECX].FMarkCount
@@quit:
        RET
@@err:
        MOV     EAX,EDX
        CALL    MarksIntEx
end;

procedure TVMarks.Store(S: TVStream);
begin
  with MarksFields do
  begin
    fldCount := FCount;
    fldMarkCount := FMarkCount;
  end;
  S.Write(MarksFields,SizeOf(MarksFields));
  if FCount > 0 then
    S.Write(FList^, FSize*SizeOf(LongWord));
end;

procedure TVMarks.GetDataFrom(AMarks: TVMarks);
begin
  if FCount <> AMarks.FCount then
    SetCount(AMarks.FCount);
  FMarkCount := AMarks.FMarkCount;
  if FCount > 0 then
    Q_CopyLongs(AMarks.FList, FList, FSize);
end;

{ TVUniNumberObj }

function TVUniNumberObj.Clone: Pointer;
begin
  Result := inherited Clone;
  TVUniNumberObj(Result).FNumber := FNumber;
end;

constructor TVUniNumberObj.Load(S: TVStream; Version: Word);
begin
  if Version = 1 then
  begin
    S.Read(FNumber, SizeOf(FNumber));
  end else
    RaiseVersionNotSupported(Self, Version);
end;

procedure TVUniNumberObj.Store(S: TVStream);
begin
  S.Write(FNumber, SizeOf(FNumber));
end;

function TVUniNumberObj.IsEqual(Obj: Pointer): Boolean;
begin
  Result := TVUniNumberObj(Obj).FNumber = FNumber;
end;

procedure TVUniNumberObj.Reconcile(OldObj, NewObj: Pointer);
begin
  if TVUniNumberObj(OldObj).FNumber <> TVUniNumberObj(NewObj).FNumber then
    FNumber := TVUniNumberObj(NewObj).FNumber;
end;

{ TVUniNumberColl }

function TVUniNumberColl.Clone: Pointer;
begin
  Result := inherited Clone;
  TVUniNumberColl(Result).FLastUsedNumber := FLastUsedNumber;
end;

constructor TVUniNumberColl.Create;
begin
  inherited;
  MakeIndexBy_Number;
end;

function TVUniNumberColl.GetUniqueNumber: Integer;
begin
  if ((FLastUsedNumber>=0) and (FLastUsedNumber<>MaxInt)) then
    Inc(FLastUsedNumber)
  else if FLastUsedNumber = MaxInt then
    FLastUsedNumber := -2147483647
  else if FLastUsedNumber <> -1 then
    Inc(FLastUsedNumber)
  else
    RaiseTVErrObj(STVCollNumberRunOut,Self);
  Result := FLastUsedNumber;
end;

constructor TVUniNumberColl.Load(S: TVStream; Version: Word);
begin
  if Version = 1 then
  begin
    inherited;
    S.Read(FLastUsedNumber, SizeOf(FLastUsedNumber));
  end else
    RaiseVersionNotSupported(Self, Version);
end;

function CompTVUniNumberObj(Item1, Item2: Pointer): Integer;
begin
  Result := TVUniNumberObj(Item1).FNumber - TVUniNumberObj(Item2).FNumber;
end;

function TVUniNumberKeyOf(Item: Pointer): Integer;
begin
  Result := TVUniNumberObj(Item).FNumber;
end;

procedure TVUniNumberColl.MakeIndexBy_Number;
var
  PIR: PTVIndexRec;
begin
  CreateIndexRec(PIR);
  with PIR^ do
  begin
    IndName := IndexBy_Number;
    IndCompare := CompTVUniNumberObj;
    Regular := True;
    Unique := True;
    IndType := itInteger;
    KeyOf_Integer := TVUniNumberKeyOf;
  end;
  AddIndex(PIR,True);
end;

function TVUniNumberColl.SearchNumberObj(N: Integer): Pointer;
begin
  if Q_SameStr(FCurrentIndex^.IndName,IndexBy_Number) then
    Result := SearchObj_Integer(FCurrentIndex,N)
  else
    Result := SearchObj_Integer(GetIndexRec(IndexBy_Number),N);
end;

function TVUniNumberColl.SearchNumberIndex(N: Integer): Integer;
var
  PIR: PTVIndexRec;
begin
  if Q_SameStr(FCurrentIndex^.IndName,IndexBy_Number) then
    Result := SearchIndex_Integer(FCurrentIndex,N)
  else
  begin
    PIR := GetIndexRec(IndexBy_Number);
    Result := SearchIndex_Integer(PIR,N);
    if Result <> -1 then
      Result := IndexOfByIndex(FCurrentIndex,PIR^.IndList^[Result]);
  end;
end;

procedure TVUniNumberColl.Store(S: TVStream);
begin
  inherited;
  S.Write(FLastUsedNumber, SizeOf(FLastUsedNumber));
end;

function TVUniNumberColl.NumberExists(N: Integer): Boolean;
var
  L,H,I: Integer;
  PIR: PTVIndexRec;
  C: Integer;
begin
  if Q_SameStr(FCurrentIndex^.IndName,IndexBy_Number) then
    PIR := FCurrentIndex
  else
    PIR := GetIndexRec(IndexBy_Number);
  with PIR^ do
  begin
    if IndType <> itInteger then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    Result := True;
    if Regular then
    begin
      L := 0;
      H := FCount - 1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := TVUniNumberObj(IndList^[I]).FNumber-N;
          if C < 0 then
            L := I + 1
          else
          begin
            if C = 0 then
              Exit;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := TVUniNumberObj(IndList^[I]).FNumber-N;
          if C > 0 then
            L := I + 1
          else
          begin
            if C = 0 then
              Exit;
            H := I - 1;
          end;
        end;
    end else
    begin
      for I := 0 to FCount-1 do
        if TVUniNumberObj(IndList^[I]).FNumber = N then
          Exit;
    end;
  end;
  Result := False;
end;

procedure TVUniNumberColl.RollbackNumber(N: Integer);
begin
  if N = FLastUsedNumber then
  begin
    if (N>0) or ((N<0) and (N<>-2147483647)) then
      Dec(FLastUsedNumber)
    else if N = -2147483647 then
      FLastUsedNumber := MaxInt;
  end;
end;

{ TVUniNameObj }

function TVUniNameObj.Clone: Pointer;
begin
  Result := inherited Clone;
  TVUniNameObj(Result).FName := FName;
end;

constructor TVUniNameObj.Load(S: TVStream; Version: Word);
begin
  if Version = 1 then
  begin
    inherited;
    FName := S.ReadStr;
  end else
    RaiseVersionNotSupported(Self, Version);
end;

procedure TVUniNameObj.Store(S: TVStream);
begin
  inherited;
  S.WriteStr(FName);
end;

function TVUniNameObj.IsEqual(Obj: Pointer): Boolean;
begin
  Result := inherited IsEqual(Obj) and Q_SameStr(TVUniNameObj(Obj).FName, FName);
end;

procedure TVUniNameObj.Reconcile(OldObj, NewObj: Pointer);
begin
  inherited;
  if not Q_SameStr(TVUniNameObj(OldObj).FName,TVUniNameObj(NewObj).FName) then
    FName := TVUniNameObj(NewObj).FName;
end;

{ TVUniNameColl }

constructor TVUniNameColl.Create;
begin
  inherited;
  MakeIndexBy_Name;
end;

function TVUniNameColl.GetNameByNumber(N: Integer): string;
var
  P: TVUniNameObj;
begin
  P := SearchNumberObj(N);
  if P <> nil then
    Result := P.FName
  else
    Result := '*****';
end;

function TVUniNameColl.GetNumberByName(const Name: string): Integer;
var
  P: TVUniNameObj;
begin
  P := SearchNameObj(Name);
  if P <> nil then
    Result := P.FNumber
  else
    Result := 0;
end;

function CompTVUniNameObj(Item1, Item2: Pointer): Integer;
begin
  Result := Q_CompText(TVUniNameObj(Item1).FName,TVUniNameObj(Item2).FName);
end;

function TVUniNameKeyOf(Item: Pointer): string;
begin
  Result := TVUniNameObj(Item).FName;
end;

procedure TVUniNameColl.MakeIndexBy_Name;
var
  PIR: PTVIndexRec;
begin
  CreateIndexRec(PIR);
  with PIR^ do
  begin
    IndName := IndexBy_Name;
    IndCompare := CompTVUniNameObj;
    Regular := True;
    Unique := False;
    IndType := itString_I;
    KeyOf_String_I := TVUniNameKeyOf;
  end;
  AddIndex(PIR,True);
end;

function TVUniNameColl.SearchNameIndex(const Name: string): Integer;
var
  PIR: PTVIndexRec;
begin
  if Q_SameStr(FCurrentIndex^.IndName,IndexBy_Name) then
    Result := SearchIndex_String_I(FCurrentIndex,Name)
  else
  begin
    PIR := GetIndexRec(IndexBy_Name);
    Result := SearchIndex_String_I(PIR,Name);
    if Result <> -1 then
      Result := IndexOfByIndex(FCurrentIndex,PIR^.IndList^[Result]);
  end;
end;

function TVUniNameColl.SearchNameObj(const Name: string): Pointer;
begin
  if Q_SameStr(FCurrentIndex^.IndName,IndexBy_Name) then
    Result := SearchObj_String_I(FCurrentIndex,Name)
  else
    Result := SearchObj_String_I(GetIndexRec(IndexBy_Name),Name);
end;

function TVUniNameColl.SearchNextNameIndex(const Name: string;
  var Index: Integer): Boolean;
var
  I: Integer;
  PIR: PTVIndexRec;
begin
  if Q_SameStr(FCurrentIndex^.IndName,IndexBy_Name) then
    Result := SearchNext_String_I(FCurrentIndex,Name,Index)
  else if Index = -1 then
  begin
    Index := SearchNameIndex(Name);
    Result := Index<>-1;
  end else
  begin
    PIR := GetIndexRec(IndexBy_Name);
    I := IndexOfByIndex(PIR,Get(Index));
    Result := SearchNext_String_I(PIR,Name,I);
    if Result then
      Index := IndexOfByIndex(FCurrentIndex,PIR^.IndList^[I]);
  end;
end;

{ TVStream }

constructor TVStream.Create;
begin
  FHandle := -1;
end;

destructor TVStream.Destroy;
begin
  CloseFile;
end;

procedure TVStream.CloseFile;
begin
  if FHandle <> -1 then
  begin
    if FDataView <> nil then
      UnmapViewOfFile(FDataView);
    CloseHandle(FHandle);
    FHandle := -1;
    FDataView := nil;
    FData := nil;
  end;
end;

procedure TVStream.CreateFile(const AFileName: string);
begin
  CloseFile;
  FHandle := Integer(Windows.CreateFile(PChar(AFileName), GENERIC_READ or GENERIC_WRITE,
    0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0));
  if FHandle < 0 then
    RaiseStrmCreateError(AFileName);
  FFileName := AFileName;
  FMode := fmCreate;
end;

procedure TVStream.OpenFile(const AFileName: string; AMode: Word);
const
  ShareMode: array[0..4] of LongWord = (
    0,
    0,
    FILE_SHARE_READ,
    FILE_SHARE_WRITE,
    FILE_SHARE_READ or FILE_SHARE_WRITE);
  AccessMode: array[0..2] of LongWord = (
    GENERIC_READ,
    GENERIC_WRITE,
    GENERIC_READ or GENERIC_WRITE);
var
  FileFM: THandle;
begin
  CloseFile;
  if FileExists(AFileName) then
  begin
    if AMode and 3 = 0 then
    begin
      FHandle := Windows.CreateFile(PChar(AFileName),GENERIC_READ,
        ShareMode[(AMode and $F0) shr 4],nil,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0);
      if FHandle = Integer(INVALID_HANDLE_VALUE) then
        RaiseStrmOpenError(AFileName);
      FFileSize := Integer(GetFileSize(FHandle,nil));
      if FFileSize < 0 then
        RaiseTVErrS(STVStrmInvalidFileSize, AFileName);
      FileFM := CreateFileMapping(FHandle,nil,PAGE_READONLY,0,0,nil);
      if FileFM = 0 then
        RaiseTVErrS(STVStrmFileMapErr, AFileName);
      FDataView := MapViewOfFile(FileFM,FILE_MAP_READ,0,0,0);
      CloseHandle(FileFM);
      if FDataView = nil then
        RaiseTVErrS(STVStrmFileMapErr, AFileName);
      FData := FDataView;
    end else
    begin
      FHandle := Integer(Windows.CreateFile(PChar(AFileName),
        AccessMode[AMode and 3], ShareMode[(Mode and $F0) shr 4], nil,
        OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0));
      if FHandle < 0 then
        RaiseStrmOpenError(AFileName);
    end;
  end else
    RaiseStrmFileNotFound(AFileName);
  FFileName := AFileName;
  FMode := AMode;
end;

procedure TVStream.Read(var Buffer; Count: Integer);
var
  P: PTVProtection;
begin
  if Count > 0 then
  begin
    if FData <> nil then
    begin
      case Count of
        1: Byte(Buffer) := PStmByte(FData)^;
        2: Word(Buffer) := PStmWord(FData)^;
        4: LongWord(Buffer) := PStmDWord(FData)^;
        6: TStmSix(Buffer) := PStmSix(FData)^;
        8: Int64(Buffer) := PStmQWord(FData)^;
      else
        Q_CopyMem(FData,@Buffer,Count);
      end;
      Inc(Integer(FData),Count);
    end else
      if FileRead(FHandle, Buffer, Count) <> Count then
        RaiseStrmReadError(FFileName);
    P := FSecurity;
    if P <> nil then
      repeat
        with P^ do
        begin
          if Encryption <> peNone then
            if Encryption and peRC4 <> 0 then
              Q_RC4Apply(TRC4ID(XXX2),@Buffer,Count)
            else if Encryption = peRC6 then
              Q_RC6DecryptCFB(TRC6ID(XXX2),@Buffer,Count)
            else if Encryption = peCAST6 then
              Q_CAST6DecryptCFB(TCASTID(XXX2),@Buffer,Count);
          if Validation <> pvNone then
          begin
            if Validation = pvCRC32 then
              Q_NextCRC32(XXX1,@Buffer,Count)
            else
              Q_SHA1Update(TSHAID(XXX1),@Buffer,Count);
          end;
        end;
        P := P^.Next;
      until P = nil;
  end;
end;

procedure TVStream.ReadB(var Buffer; Count: Integer);
var
  P: PTVProtection;
begin
  if Count > 0 then
  begin
    if FData <> nil then
    begin
      Q_CopyMem(FData,@Buffer,Count);
      Inc(Integer(FData),Count);
    end else
      if FileRead(FHandle, Buffer, Count) <> Count then
        RaiseStrmReadError(FFileName);
    P := FSecurity;
    if P <> nil then
      repeat
        with P^ do
        begin
          if Encryption <> peNone then
            if Encryption and peRC4 <> 0 then
              Q_RC4Apply(TRC4ID(XXX2),@Buffer,Count)
            else if Encryption = peRC6 then
              Q_RC6DecryptCFB(TRC6ID(XXX2),@Buffer,Count)
            else if Encryption = peCAST6 then
              Q_CAST6DecryptCFB(TCASTID(XXX2),@Buffer,Count);
          if Validation <> pvNone then
          begin
            if Validation = pvCRC32 then
              Q_NextCRC32(XXX1,@Buffer,Count)
            else
              Q_SHA1Update(TSHAID(XXX1),@Buffer,Count);
          end;
        end;
        P := P^.Next;
      until P = nil;
  end;
end;

procedure TVStream.Write(const Buffer; Count: Integer);
var
  P: PTVProtection;
  Buf: Pointer;
begin
  if Count > 0 then
  begin
    P := FSecurity;
    if P <> nil then
    begin
      if Count <= 256 then
      begin
        Buf := @StB;
        if @Buffer <> @StB then
          Q_CopyMem(@Buffer,Buf,Count);
      end else
      begin
        GetMem(Buf,Count);
        Q_CopyMem(@Buffer,Buf,Count);
      end;
      repeat
        with P^ do
        begin
          if Validation <> pvNone then
          begin
            if Validation = pvCRC32 then
              Q_NextCRC32(XXX1,Buf,Count)
            else
              Q_SHA1Update(TSHAID(XXX1),Buf,Count);
          end;
          if Encryption <> peNone then
            if Encryption and peRC4 <> 0 then
              Q_RC4Apply(TRC4ID(XXX2),Buf,Count)
            else if Encryption = peRC6 then
              Q_RC6EncryptCFB(TRC6ID(XXX2),Buf,Count)
            else if Encryption = peCAST6 then
              Q_CAST6EncryptCFB(TCASTID(XXX2),Buf,Count);
        end;
        P := P^.Next;
      until P = nil;
      if FileWrite(FHandle, Buf^, Count) <> Count then
        RaiseStrmWriteError(FFileName);
      if Count > 256 then
        FreeMem(Buf);
    end
    else if FileWrite(FHandle, Buffer, Count) <> Count then
      RaiseStrmWriteError(FFileName);
  end;
end;

procedure TVStream.Skip(Count: Integer);
begin
  if FData <> nil then
    Inc(Integer(FData),Count)
  else
    if FileSeek(FHandle, Count, 1) = -1 then
      RaiseStrmSeekError(FFileName);
end;

function TVStream.Seek(Offset, Origin: Integer): Integer;
begin
  if FData <> nil then
  begin
    case Origin of
      0: Integer(FData) := Integer(FDataView)+Offset;
      1: Inc(Integer(FData),Offset);
      2: Integer(FData) := Integer(FDataView)+FFileSize-Offset;
    end;
    Result := Integer(FData)-Integer(FDataView);
    if (Result<0) or (Result>FFileSize) then
      RaiseStrmSeekError(FFileName);
  end else
  begin
    Result := SetFilePointer(THandle(Handle), Offset, nil, Origin);
    if Result = -1 then
      RaiseStrmSeekError(FFileName);
  end;
end;

procedure TVStream.SetSize(NewSize: Integer);
begin
  if FData = nil then
  begin
    Seek(NewSize, 0);
    Win32Check(SetEndOfFile(FHandle));
  end else
    RaiseStrmWriteError(FFileName);
end;

function TVStream.GetPosition: Integer;
begin
  if FData <> nil then
    Result := Integer(FData)-Integer(FDataView)
  else
    Result := Seek(0,1);
end;

procedure TVStream.SetPosition(Pos: Integer);
begin
  Seek(Pos, 0);
end;

function TVStream.GetSize: Integer;
var
  Pos: Integer;
begin
  if FData <> nil then
    Result := FFileSize
  else
  begin
    Pos := Seek(0,1);
    Result := Seek(0,2);
    Seek(Pos,0);
  end;
end;

function TVStream.CopyFrom(Source: TVStream; Count: Integer): Integer;
const
  MaxBufSize = 3145728;
var
  BufSize, N: Integer;
  Buffer: PChar;
begin
  if FData <> nil then
    RaiseStrmWriteError(FFileName);
  if Count = cfCopyAllData then
  begin
    Source.Position := 0;
    Count := Source.Size;
  end;
  Result := Count;
  if (Count>0) and (Source<>Self) then
  begin
    if Count > MaxBufSize then
      BufSize := MaxBufSize
    else
      BufSize := Count;
    GetMem(Buffer, BufSize);
    try
      while Count > 0 do
      begin
        if Count > BufSize then
          N := BufSize
        else
          N := Count;
        Source.ReadB(Buffer^, N);
        Write(Buffer^, N);
        Dec(Count, N);
      end;
    finally
      FreeMem(Buffer, BufSize);
    end;
  end;
end;

procedure TVStream.Flush;
begin
  if FData = nil then
    Win32Check(FlushFileBuffers(FHandle))
  else
    RaiseStrmWriteError(FFileName);
end;

procedure TVStream.Truncate;
begin
  if FData = nil then
    Win32Check(SetEndOfFile(FHandle))
  else
    RaiseStrmWriteError(FFileName);
end;

function TVStream.Get(Security: PTVProtection): TVObject;
var
  SH,SH1: TSHA1Digest;
  P: PTVProtection;
  I: Integer;
  IDCash: array[0..16] of Word;
  RegID: Word;
begin
  if Security = nil then
  begin
    Read(RegID, 2);
    if RegID <> 0 then
    begin
      I := Q_ScanWord(RegID, RegLdObjIDs, RegLdCount);
      if I <> -1 then
        with RegLdList^[I] do
          Result := ClsType.Load(Self,Version)
      else
      begin
        Result := nil;
        RaiseTVErrD(STVReadUnregObj, RegID);
      end;
    end else
      Result := nil;
  end else
  begin
    with Security^ do
      if Encryption and (peRC6_RC4 xor peCAST6_RC4) <> 0 then
      begin
        Read(IDCash, 34);
        RegID := IDCash[0];
      end else
        Read(RegID, 2);
    if RegID <> 0 then
    begin
      I := Q_ScanWord(RegID, RegLdObjIDs, RegLdCount);
      if I <> -1 then
      begin
        if FSecurity = nil then
          FSecurity := Security
        else
        begin
          P := FSecurity;
          while P^.Next <> nil do
            P := P^.Next;
          P^.Next := Security;
        end;
        with Security^ do
        begin
          case Encryption of
            peRC4:
                Q_RC4Init(TRC4ID(XXX2),@KeyData,KeyLen);
            peRC6:
              begin
                Q_RC6Init(TRC6ID(XXX2),@KeyData,KeyLen);
                Q_RC6SetOrdinaryVector(TRC6ID(XXX2));
              end;
            peCAST6:
              begin
                Q_CAST6Init(TCASTID(XXX2),@KeyData,KeyLen);
                Q_CAST6SetOrdinaryVector(TCASTID(XXX2));
              end;
            peRC6_RC4:
              begin
                Q_RC6Init(TRC6ID(XXX2),@KeyData,KeyLen);
                Q_RC6DecryptCBC(TRC6ID(XXX2),@IDCash[1],32);
                Q_RC6Done(TRC6ID(XXX2));
                Q_RC4Init(TRC4ID(XXX2),@IDCash[1],32);
                Q_ZeroMem(@IDCash,34);
              end;
            peCAST6_RC4:
              begin
                Q_CAST6Init(TCASTID(XXX2),@KeyData,KeyLen);
                Q_CAST6DecryptCBC(TCASTID(XXX2),@IDCash[1],32);
                Q_CAST6Done(TCASTID(XXX2));
                Q_RC4Init(TRC4ID(XXX2),@IDCash[1],32);
                Q_ZeroMem(@IDCash,34);
              end;
          end;
          if Validation <> pvNone then
            if Validation = pvCRC32 then
              XXX1 := 0
            else
              Q_SHA1Init(TSHAID(XXX1));
          with RegLdList^[I] do
            Result := ClsType.Load(Self,Version);
          if Validation <> pvNone then
            if Validation = pvCRC32 then
            begin
              Validation := pvNone;
              Read(SH,4);
              Validation := pvCRC32;
              if SH[0] <> XXX1 then
                RaiseStrmDataCorrupted(FFileName);
              SH[0] := 0;
              XXX1 := 0;
            end else
            begin
              Validation := pvNone;
              Q_SHA1Final(TSHAID(XXX1),SH);
              Read(SH1,SizeOf(TSHA1Digest));
              Validation := pvSHA1;
              if not ((SH[0]=SH1[0]) and (SH[1]=SH1[1]) and (SH[2]=SH1[2]) and
                  (SH[3]=SH1[3]) and (SH[4]=SH1[4])) then
                RaiseStrmDataCorrupted(FFileName);
              Q_TinyFill(@SH,SizeOf(TSHA1Digest),0);
              Q_TinyFill(@SH1,SizeOf(TSHA1Digest),0);
            end;
          if Encryption <> peNone then
            if Encryption and peRC4 <> 0 then
              Q_RC4Done(TRC4ID(XXX2))
            else if Encryption = peRC6 then
              Q_RC6Done(TRC6ID(XXX2))
            else if Encryption = peCAST6 then
              Q_CAST6Done(TCASTID(XXX2));
        end;
        if FSecurity = Security then
          FSecurity := nil
        else
        begin
          P := FSecurity;
          while P^.Next <> Security do
            P := P^.Next;
          P^.Next := nil;
        end;
      end else
      begin
        Result := nil;
        RaiseTVErrD(STVReadUnregObj, RegID);
      end;
    end else
      Result := nil;
  end;
end;

procedure TVStream.Put(P: TVObject; Security: PTVProtection);
var
  IDCash: array[0..16] of Word;
  DID: LongWord;
  SH: TSHA1Digest;
  I: Integer;
begin
  if Security = nil then
  begin
    if P <> nil then
    begin
      I := Q_ScanPointer(Pointer(P.ClassType),RegStClsTypes,RegStCount);
      if I <> -1 then
      begin
        Write(RegStObjIDs^[I], 2);
        P.Store(Self);
      end else
        RaiseTVErrShS(STVWriteUnregObj, P.ClassName);
    end else
      Write(P, 2);
  end else
  begin
    if P <> nil then
    begin
      I := Q_ScanPointer(Pointer(P.ClassType),RegStClsTypes,RegStCount);
      if I <> -1 then
      begin
        with Security^ do
        begin
          if Validation <> pvNone then
            if Validation = pvCRC32 then
              XXX1 := 0
            else
              Q_SHA1Init(TSHAID(XXX1));
          if Encryption <> peNone then
          begin
            case Encryption of
              peRC4:
                begin
                  Q_RC4Init(TRC4ID(XXX2),@KeyData,KeyLen);
                  Write(RegStObjIDs^[I], 2);
                end;
              peRC6:
                begin
                  Q_RC6Init(TRC6ID(XXX2),@KeyData,KeyLen);
                  Q_RC6SetOrdinaryVector(TRC6ID(XXX2));
                  Write(RegStObjIDs^[I], 2);
                end;
              peCAST6:
                begin
                  Q_CAST6Init(TCASTID(XXX2),@KeyData,KeyLen);
                  Q_CAST6SetOrdinaryVector(TCASTID(XXX2));
                  Write(RegStObjIDs^[I], 2);
                end;
              peRC6_RC4:
                begin
                  IDCash[0] := RegStObjIDs^[I];
                  Q_SecureRandFill(RandID,@IDCash[1],32);
                  Q_RC4Init(TRC4ID(XXX2),@IDCash[1],32);
                  Q_RC6Init(TRC6ID(DID),@KeyData,KeyLen);
                  Q_RC6EncryptCBC(TRC6ID(DID),@IDCash[1],32);
                  Q_RC6Done(TRC6ID(DID));
                  Write(IDCash,34);
                  Q_ZeroMem(@IDCash,34);
                end;
              peCAST6_RC4:
                begin
                  IDCash[0] := RegStObjIDs^[I];
                  Q_SecureRandFill(RandID,@IDCash[1],32);
                  Q_RC4Init(TRC4ID(XXX2),@IDCash[1],32);
                  Q_CAST6Init(TCASTID(DID),@KeyData,KeyLen);
                  Q_CAST6EncryptCBC(TCASTID(DID),@IDCash[1],32);
                  Q_CAST6Done(TCASTID(DID));
                  Write(IDCash,34);
                  Q_ZeroMem(@IDCash,34);
                end;
            end;
          end else
            Write(RegStObjIDs^[I], 2);
          Security.Next := FSecurity;
          FSecurity := Security;
          P.Store(Self);
          if Validation <> pvNone then
            if Validation = pvCRC32 then
            begin
              Validation := pvNone;
              Write(XXX1,4);
              Validation := pvCRC32;
              XXX1 := 0;
            end else
            begin
              Validation := pvNone;
              Q_SHA1Final(TSHAID(XXX1),SH);
              Write(SH,SizeOf(TSHA1Digest));
              Validation := pvSHA1;
              Q_TinyFill(@SH,SizeOf(TSHA1Digest),0);
            end;
          if Encryption <> peNone then
            if Encryption and peRC4 <> 0 then
              Q_RC4Done(TRC4ID(XXX2))
            else if Encryption = peRC6 then
              Q_RC6Done(TRC6ID(XXX2))
            else if Encryption = peCAST6 then
              Q_CAST6Done(TCASTID(XXX2));
        end;
        FSecurity := Security.Next;
      end else
        RaiseTVErrShS(STVWriteUnregObj, P.ClassName);
    end
    else if Security^.Encryption and (peRC6_RC4 xor peCAST6_RC4) <> 0 then
    begin
      Q_ZeroMem(@IDCash,34);
      Write(IDCash,34);
    end else
      Write(P,2);
  end;
end;

function TVStream.ReadStr: string;
var
  L: Byte;
begin
  Read(L, 1);
  if L > 0 then
  begin
    SetString(Result, nil, L);
    ReadB(Pointer(Result)^, L);
  end else
    Result := '';
end;

procedure TVStream.WriteStr(const S: string);
var
  L: Integer;
begin
  L := Length(S);
  if L > 255 then
    RaiseTVErrS(STVLongStrError, S);
  if L <> 0 then
  begin
    StB[0] := Byte(L);
    Q_CopyMem(Pointer(S),@StB[1],L);
    Write(StB, L+1);
  end else
    Write(L, 1);
end;

function TVStream.ReadLongStr: string;
var
  L: Integer;
begin
  Read(L, SizeOf(L));
  if L > 0 then
  begin
    SetString(Result, nil, L);
    ReadB(Pointer(Result)^, L);
  end
  else
    Result := '';
end;

procedure TVStream.WriteLongStr(const S: string);
var
  L: Integer;
begin
  L := Length(S);
  Write(L, SizeOf(L));
  if L > 0 then
    Write(Pointer(S)^, L);
end;

function TVStream.ReadStrRLE: string;
var
  L: Integer;
  S: string;
begin
  Read(L, SizeOf(L));
  if L > 0 then
  begin
    SetString(S, nil, L);
    ReadB(Pointer(S)^, L);
    Result := Q_UnpackRLE(S);
  end
  else
    Result := '';
end;

procedure TVStream.WriteStrRLE(const S: string);
var
  L: Integer;
  X: string;
begin
  L := Length(S);
  if L > 0 then
  begin
    X := Q_PackRLE(S);
    L := Length(X);
    Write(L, SizeOf(L));
    Write(Pointer(X)^, L);
  end else
    Write(L, SizeOf(L));
end;

function TVStream.ReadOemStr: string;
var
  L: Byte;
begin
  Read(L, 1);
  if L > 0 then
  begin
    SetString(Result, nil, L);
    ReadB(Pointer(Result)^, L);
    Q_StrToAnsi(Result);
  end else
    Result := '';
end;

procedure TVStream.WriteOemStr(const S: string);
var
  L: Integer;
begin
  L := Length(S);
  if L > 255 then
    RaiseTVErrS(STVLongStrError, S);
  if L <> 0 then
  begin
    StB[0] := Byte(L);
    Q_PStr2ToOemL(Pointer(S),@StB[1],L);
    Write(StB, L+1);
  end else
    Write(L, 1);
end;

function TVStream.ReadFixedStr(Len: Byte): string;
var
  L: Integer;
begin
  if Len > 0 then
  begin
    ReadB(StB, Len+1);
    L := StB[0];
    if L > 0 then
    begin
      SetString(Result, nil, L);
      Q_PStr2ToAnsiL(@StB[1],Pointer(Result),L);
    end else
      Result := '';
  end else
    Result := '';
end;

procedure TVStream.WriteFixedStr(const S: string; Len: Byte);
var
  L: Integer;
begin
  L := Length(S);
  if L > Len then
    RaiseTVErrDS(STVStrFixedOverflow,Len,S);
  StB[0] := Byte(L);
  Q_PStr2ToOemL(Pointer(S),@StB[1],L);
  Write(StB,Len+1);
end;

function TVStream.StrRead: PChar;
var
  L: Word;
begin
  Read(L, 2);
  if L <> 0 then
  begin
    Result := StrAlloc(L+1);
    ReadB(Result[0], L);
    Result[L] := #0;
    Q_PStrToAnsiL(Result, L);
  end else
    Result := nil;
end;

procedure TVStream.StrWrite(P: PChar);
type
  PStrBuffer = ^TStrBuffer;
  TStrBuffer = array[0..$FFFF] of Byte;
var
  L: Cardinal;
  Buf: PStrBuffer;
begin
  if P <> nil then
  begin
    L := StrLen(P);
    if L > 65527 then
      RaiseTVErr(STVStrLongError);
  end else
    L := 0;
  if L <> 0 then
  begin
    if L < 255 then
    begin
      PStmWord(@StB)^ := Word(L);
      Q_PStr2ToOemL(P,@StB[2],L);
      Write(StB,L+2);
    end else
    begin
      GetMem(Buf,L+2);
      PStmWord(Buf)^ := Word(L);
      Q_PStr2ToOemL(P,@Buf[2],L);
      Write(Pointer(Buf)^,L+2);
      FreeMem(Buf);
    end;
  end else
    Write(L, 2);
end;

function TVStream.ReadRealAsCurrency: Currency;
var
  R: Real48;
begin
  Read(R, 6);
  Result := R;
end;

procedure TVStream.WriteCurrencyAsReal(V: Currency);
var
  Dbl: Double;
  R: Real48;
begin
  Dbl := V;
  R := Dbl;
  Write(R, 6);
end;

function TVStream.ReadRealAsDouble: Double;
var
  R: Real48;
begin
  Read(R, 6);
  Result := R;
end;

procedure TVStream.WriteDoubleAsReal(V: Double);
var
  R: Real48;
begin
  R := V;
  Write(R, 6);
end;

{ TVStorage }

var
  StgHeader: packed record
    Info: array[0..63] of Byte;
    IndPs: Integer;
    Fragm: Integer;
    Cnt: Integer;
  end;

const
  StHeaderSize = SizeOf(Integer)+SizeOf(StgHeader);
  StgMagicNumber = $FF405453;

constructor TVStorage.Create(AStream: TVStream);
var
  Num: Integer;
begin
  if (AStream=nil) or (AStream.FHandle=-1) then
    RaiseTVErr(STVStreamFileNotOpen);
  FStream := AStream;
  if FStream.GetSize >= StHeaderSize then
  begin
    AStream.Seek(0, 0);
    AStream.Read(Num, SizeOf(Num));
    if Num = Integer(StgMagicNumber) then
    begin
      AStream.ReadB(StgHeader, SizeOf(StgHeader));
      with StgHeader do
      begin
        SetString(FInfoStr, nil, Info[0]);
        Q_PStr2ToAnsiL(@Info[1],Pointer(FInfoStr),Info[0]);
        FIndexPos := IndPs;
        FSizeOfFragments := Fragm;
        Num := Cnt;
      end;
      SetCapacity(Num+10);
      AStream.Seek(FIndexPos, 0);
      if Num > 0 then
        AStream.ReadB(FList^,Num*SizeOf(TVStorageItem));
      FCount := Num;
      FModified := False;
    end else
      RaiseTVErrS(STVStorageNotFound,AStream.FFileName);
  end else
  begin
    if AStream.FMode and 3 = 0 then
      RaiseTVErr(STVResourceNotFound);
    FIndexPos := StHeaderSize;
    FModified := True;
  end;
  FShrinkOnFlush := True;
  FMaxGarbagePercent := 25.0;
  FPackOnFly := False;
end;

procedure TVStorage.Delete(Key: Integer);
var
  I: Integer;
begin
  if Find(Key,I) then
    DeleteAt(I);
end;

procedure TVStorage.DeleteAt(Index: Integer);
var
  J: Integer;
  LPs,LSz: Integer;
  FileFM: THandle;
  FDataView: Pointer;
  FData: Integer;
begin
  if (Index<0) or (Index>=FCount) then
    RaiseTVErrD(STVCollIndexError, Index);
  with FList^[Index] do
  begin
    LSz := Size;
    LPs := Pos;
  end;
  Dec(FCount);
  if Index < FCount then
    Q_MoveMem(@FList^[Index + 1], @FList^[Index],
      (FCount - Index) * SizeOf(TVStorageItem));
  if FPackOnFly then
  begin
    if FSizeOfFragments = 0 then
    begin
      Dec(FIndexPos,LSz);
      if FIndexPos > LPs then
      begin
        FileFM := CreateFileMapping(FStream.FHandle,nil,PAGE_READWRITE,0,0,nil);
        if FileFM = 0 then
          RaiseTVErrS(STVPackFileMapErr, FStream.FFileName);
        FDataView := MapViewOfFile(FileFM,FILE_MAP_ALL_ACCESS,0,0,0);
        CloseHandle(FileFM);
        if FDataView = nil then
          RaiseTVErrS(STVPackFileMapErr, FStream.FFileName);
        FData := Integer(FDataView)+LPs;
        Q_MoveMem(Pointer(FData+LSz),Pointer(FData),FIndexPos-LPs);
        UnmapViewOfFile(FDataView);
        for J := 0 to FCount-1 do
          with FList^[J] do
            if Pos > LPs then
              Dec(Pos, LSz);
      end;
    end else
      Sweep;
  end
  else if FIndexPos-LSz <> LPs then
  begin
    Inc(FSizeOfFragments,LSz);
    if FSizeOfFragments/FIndexPos*100 > FMaxGarbagePercent then
      Sweep;
  end else
    Dec(FIndexPos,LSz);
  FModified := True;
end;

destructor TVStorage.Destroy;
begin
  Flush;
  FreeMem(FList);
  FStream.Free;
end;

function TVStorage.Find(AKey: Integer; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  L := 0;
  H := FCount - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := FList^[I].Key - AKey;
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        Index := I;
        Exit;
      end;
    end;
  end;
  Result := False;
  Index := L;
end;

function TVStorage.GetAt(Index: Integer; Security: PTVProtection): TVObject;
begin
  if (Index<0) or (Index>=FCount) then
    RaiseTVErrD(STVCollIndexError, Index);
  FStream.Seek(FList^[Index].Pos, 0);
  Result := FStream.Get(Security);
end;

function TVStorage.Get(Key: Integer; Security: PTVProtection): TVObject;
var
  I: Integer;
begin
  if Find(Key,I) then
  begin
    FStream.Seek(FList^[I].Pos, 0);
    Result := FStream.Get(Security);
  end else
    Result := nil;
end;

function TVStorage.GetTg(Key: Integer; var ATag: Integer; Security: PTVProtection): TVObject;
var
  I: Integer;
begin
  if Find(Key,I) then
  begin
    with FList^[I] do
    begin
      FStream.Seek(Pos, 0);
      ATag := Tag;
    end;
    Result := FStream.Get(Security);
  end else
  begin
    Result := nil;
    ATag := 0;
  end;
end;

function TVStorage.GetFileName: string;
begin
  Result := FStream.FFileName;
end;

function TVStorage.GetReadOnly: Boolean;
begin
  Result := FStream.FMode and 3 = 0;
end;

function TVStorage.KeyExists(Key: Integer): Boolean;
var
  I: Integer;
begin
  Result := Find(Key,I);
end;

procedure TVStorage.Put(Key: Integer; Item: TVObject; Security: PTVProtection);
begin
  PutTg(Key,Item,0,Security);
end;

procedure TVStorage.PutTg(Key: Integer; Item: TVObject; ATag: Integer; Security: PTVProtection);
var
  I,J: Integer;
  LPs,LSz: Integer;
  FileFM: THandle;
  FDataView: Pointer;
  FData: Integer;
begin
  if Find(Key,I) then
  begin
    with FList^[I] do
    begin
      LSz := Size;
      LPs := Pos;
    end;
    if FPackOnFly and (FSizeOfFragments=0) then
    begin
      Dec(FIndexPos,LSz);
      if FIndexPos > LPs then
      begin
        FileFM := CreateFileMapping(FStream.FHandle,nil,PAGE_READWRITE,0,0,nil);
        if FileFM = 0 then
          RaiseTVErrS(STVPackFileMapErr, FStream.FFileName);
        FDataView := MapViewOfFile(FileFM,FILE_MAP_ALL_ACCESS,0,0,0);
        CloseHandle(FileFM);
        if FDataView = nil then
          RaiseTVErrS(STVPackFileMapErr, FStream.FFileName);
        FData := Integer(FDataView)+LPs;
        Q_MoveMem(Pointer(FData+LSz),Pointer(FData),FIndexPos-LPs);
        UnmapViewOfFile(FDataView);
        for J := 0 to FCount-1 do
          with FList^[J] do
            if Pos > LPs then
              Dec(Pos,LSz);
      end;
    end
    else if FIndexPos-LSz <> LPs then
      Inc(FSizeOfFragments,LSz)
    else
      Dec(FIndexPos,LSz);
  end else
  begin
    if FCount = FCapacity then
      SetCapacity(FCapacity+30);
    if I < FCount then
      Q_MoveMem(@FList^[I], @FList^[I + 1],
        (FCount - I) * SizeOf(TVStorageItem));
    FList^[I].Key := Key;
    Inc(FCount);
  end;
  with FList^[I] do
  begin
    Pos := FIndexPos;
    Tag := ATag;
  end;
  with FStream do
  begin
    Seek(FIndexPos, 0);
    Put(Item,Security);
  end;
  FIndexPos := FStream.GetPosition;
  with FList^[I] do
    Size := FIndexPos - Pos;
  if not FPackOnFly then
  begin
    if FSizeOfFragments/FIndexPos*100 > FMaxGarbagePercent then
      Sweep;
  end
  else if FSizeOfFragments <> 0 then
    Sweep;
  FModified := True;
end;

procedure TVStorage.SetCapacity(NewCapacity: Integer);
begin
  if NewCapacity <> FCapacity then
    if (NewCapacity >= FCount) and (NewCapacity <= 99999999) then
    begin
      ReallocMem(FList, NewCapacity * SizeOf(TVStorageItem));
      FCapacity := NewCapacity;
    end else
      RaiseTVErrD(STVCollCapacityError, NewCapacity);
end;

function TVStorage.InterGet(Key: Integer): TVObject;
begin
  Result := Get(Key);
end;

procedure TVStorage.InterPut(Key: Integer; Item: TVObject);
begin
  Put(Key,Item);
end;

function StgCompPos(Item1, Item2: Pointer): Integer;
begin
  Result := PTVStorageItem(Item1)^.Pos-PTVStorageItem(Item2)^.Pos
end;

procedure TVStorage.Sweep;
var
  FData: Integer;
  CurrPs: Integer;
  I: Integer;
  FileFM: THandle;
  FDataView: Pointer;
  Ls: PTVSortStgList;
begin
  if FStream.FMode and 2 = 0 then
    RaiseTVErrS(STVPackNonRWStream, FStream.FFileName);
  if FSizeOfFragments = 0 then
    Exit;
  CurrPs := StHeaderSize;
  if FCount > 0 then
  begin
    FileFM := CreateFileMapping(FStream.FHandle,nil,PAGE_READWRITE,0,0,nil);
    if FileFM = 0 then
      RaiseTVErrS(STVPackFileMapErr, FStream.FFileName);
    FDataView := MapViewOfFile(FileFM,FILE_MAP_ALL_ACCESS,0,0,0);
    CloseHandle(FileFM);
    if FDataView = nil then
      RaiseTVErrS(STVPackFileMapErr, FStream.FFileName);
    FData := Integer(FDataView);
    GetMem(Ls,FCount*SizeOf(PTVStorageItem));
    for I := 0 to FCount-1 do
      Ls^[I] := @FList^[I];
    if FCount > 1 then
    begin
      QSL := PTVItemList(Ls);
      QSC := StgCompPos;
      QuickSortAsc(0, FCount-1);
      QSL := nil;
    end;
    for I := 0 to FCount-1 do
      with Ls^[I]^ do
      begin
        if Pos <> CurrPs then
        begin
          Q_MoveMem(Pointer(FData+Pos),Pointer(FData+CurrPs),Size);
          Pos := CurrPs;
        end;
        Inc(CurrPs,Size);
      end;
    FreeMem(Ls);
    UnmapViewOfFile(FDataView);
  end;
  FIndexPos := CurrPs;
  FSizeOfFragments := 0;
  FModified := True;
end;

procedure TVStorage.Flush(ForcedWrite: Boolean);
var
  Num: Integer;
begin
  if FModified then
  begin
    Num := Integer(StgMagicNumber);
    with FStream do
    begin
      Seek(FIndexPos,0);
      if FCount > 0 then
        Write(FList^,FCount*SizeOf(TVStorageItem));
      if FShrinkOnFlush and (FSizeOfFragments = 0) then
        Win32Check(SetEndOfFile(FHandle));
      Seek(0, 0);
      Write(Num, SizeOf(Num));
      with StgHeader do
      begin
        Num := Length(FInfoStr);
        if Num > 63 then
          Num := 63;
        Info[0] := Byte(Num);
        Q_PStr2ToOemL(Pointer(FInfoStr),@Info[1],Num);
        if Num <> 63 then
          Q_ZeroMem(@Info[Num+1],63-Num);
        IndPs := FIndexPos;
        Fragm := FSizeOfFragments;
        Cnt := FCount;
      end;
      Write(StgHeader, SizeOf(StgHeader));
      if ForcedWrite then
        Flush;
    end;
    FModified := False;
  end;
end;

function TVStorage.KeyAt(Index: Integer): Integer;
begin
  Result := FList^[Index].Key;
end;

function TVStorage.TagAt(Index: Integer): Integer;
begin
  Result := FList^[Index].Tag;
end;

{ TVSortedCollection }

constructor TVSortedCollection.Load(S: TVStream; Version: Word);
var
  Dup: Boolean;
begin
  if Version = 1 then
  begin
    inherited;
    S.Read(Dup,1);
    FCurrentIndex^.Unique := not Dup;
  end else
    RaiseVersionNotSupported(Self, Version);
end;

procedure TVSortedCollection.Store(S: TVStream);
var
  Dup: Boolean;
begin
  inherited;
  Dup := not FCurrentIndex^.Unique;
  S.Write(Dup,1);
end;

{ TVApNumberObj }

function TVApNumberObj.Clone: Pointer;
begin
  Result := inherited Clone;
  TVApNumberObj(Result).FNumber := FNumber;
end;

constructor TVApNumberObj.Load(S: TVStream; Version: Word);
begin
  if Version = 1 then
  begin
    S.Read(FNumber, 2);
  end else
    RaiseVersionNotSupported(Self, Version);
end;

procedure TVApNumberObj.Store(S: TVStream);
begin
  S.Write(FNumber, 2);
end;

{ TVApNumberColl }

constructor TVApNumberColl.Create;
begin
  inherited;
  FBig := False;
  MakeIndexBy_Number;
end;

function TVApNumberColl.GetFreeNumber: Word;
var
  PIR,PIR_B: PTVIndexRec;
  Start: Word;
begin
  Start := Random($FFFF);
  Result := Start+1;
  if Start = 0 then
    Start := $FFFF;
  PIR := GetIndexRec(IndexBy_Number);
  if FBin <> nil then
  begin
    PIR_B := FBin.GetIndexRec(IndexBy_Number);
    repeat
      if Result = Start then
        RaiseTVErrObj(STVFreeNumIsOver, Self);
      if Result <> $FFFF then
        Inc(Result)
      else
        Result := 1;
    until (SearchIndex_Word(PIR,Result)=-1) and
      (FBin.SearchIndex_Word(PIR_B,Result)=-1);
  end else
    repeat
      if Result = Start then
        RaiseTVErrObj(STVFreeNumIsOver, Self);
      if Result <> $FFFF then
        Inc(Result)
      else
        Result := 1;
    until SearchIndex_Word(PIR,Result) = -1;
end;

function TVApNumberColl.GetMaxNumber: Word;
var
  I: Integer;
  PIR: PTVIndexRec;
  Lst: PTVItemList;
begin
  Result := 0;
  if (FBin<>nil) and (FBin.FCount>0) then
  begin
    PIR := FBin.GetIndexRec(IndexBy_Number);
    if not PIR^.Regular then
      with FBin do
      begin
        Lst := PIR^.IndList;
        for I := FCount-1 downto 0 do
          if TVApNumberObj(Lst^[I]).FNumber > Result then
            Result := TVApNumberObj(Lst^[I]).FNumber;
      end
    else
    begin
      if not PIR^.Descending then
        Result := TVApNumberObj(PIR^.IndList^[FBin.FCount-1]).FNumber
      else
        Result := TVApNumberObj(PIR^.IndList^[0]).FNumber;
    end;
  end;
  if FCount > 0 then
  begin
    PIR := GetIndexRec(IndexBy_Number);
    if not PIR^.Regular then
    begin
      Lst := PIR^.IndList;
      for I := FCount-1 downto 0 do
        if TVApNumberObj(Lst^[I]).FNumber > Result then
          Result := TVApNumberObj(Lst^[I]).FNumber;
    end else
    begin
      if not PIR^.Descending then
        I := TVApNumberObj(PIR^.IndList^[FCount-1]).FNumber
      else
        I := TVApNumberObj(PIR^.IndList^[0]).FNumber;
      if I > Result then
        Result := I;
    end;
  end;
end;

function CompTVApNumberObj(Item1, Item2: Pointer): Integer;
begin
  Result := TVApNumberObj(Item1).FNumber-TVApNumberObj(Item2).FNumber;
end;

function TVApNumberKeyOf(Item: Pointer): Word;
begin
  Result := TVApNumberObj(Item).FNumber;
end;

procedure TVApNumberColl.MakeIndexBy_Number;
var
  PIR: PTVIndexRec;
begin
  CreateIndexRec(PIR);
  with PIR^ do
  begin
    IndName := IndexBy_Number;
    IndCompare := CompTVApNumberObj;
    Regular := True;
    Unique := True;
    IndType := itWord;
    KeyOf_Word := TVApNumberKeyOf;
  end;
  AddIndex(PIR,True);
end;

function TVApNumberColl.NumberExists(N: Word): Boolean;
var
  L,H,I: Integer;
  C: Integer;
begin
  with GetIndexRec(IndexBy_Number)^ do
  begin
    if IndType <> itWord then
      RaiseTVErrObjS(STVWrongSearchType, Self, IndName);
    Result := True;
    if not Regular then
    begin
      for I := 0 to FCount-1 do
        if TVApNumberObj(IndList^[I]).FNumber = N then
          Exit;
    end else
    begin
      L := 0;
      H := FCount - 1;
      if not Descending then
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := TVApNumberObj(IndList^[I]).FNumber-N;
          if C < 0 then
            L := I + 1
          else
          begin
            if C = 0 then
              Exit;
            H := I - 1;
          end;
        end
      else
        while L <= H do
        begin
          I := (L + H) shr 1;
          C := TVApNumberObj(IndList^[I]).FNumber-N;
          if C > 0 then
            L := I + 1
          else
          begin
            if C = 0 then
              Exit;
            H := I - 1;
          end;
        end;
    end;
  end;
  Result := False;
end;

function TVApNumberColl.SearchNumberIndex(N: Word): Integer;
var
  PIR: PTVIndexRec;
begin
  if Q_SameText(FCurrentIndex^.IndName,IndexBy_Number) then
    Result := SearchIndex_Word(FCurrentIndex,N)
  else
  begin
    PIR := GetIndexRec(IndexBy_Number);
    Result := SearchIndex_Word(PIR,N);
    if Result <> -1 then
      Result := IndexOfByIndex(FCurrentIndex,PIR^.IndList^[Result]);
  end;
end;

function TVApNumberColl.SearchNumberObj(N: Word): Pointer;
begin
  if Q_SameText(FCurrentIndex^.IndName,IndexBy_Number) then
    Result := SearchObj_Word(FCurrentIndex,N)
  else
    Result := SearchObj_Word(GetIndexRec(IndexBy_Number),N);
end;

{ TVApSortNumberColl }

constructor TVApSortNumberColl.Load(S: TVStream; Version: Word);
var
  Dup: Boolean;
  PIR: PTVIndexRec;
begin
  if Version = 1 then
  begin
    inherited;
    S.Read(Dup,1);
    PIR := GetIndexRec(IndexBy_Number,False);
    PIR^.Unique := not Dup;
  end else
    RaiseVersionNotSupported(Self, Version);
end;

procedure TVApSortNumberColl.Store(S: TVStream);
var
  Dup: Boolean;
begin
  SwitchToIndex(IndexBy_Number);
  inherited;
  Dup := not FCurrentIndex^.Unique;
  S.Write(Dup,1);
end;

{ TVApNameObj }

function TVApNameObj.Clone: Pointer;
begin
  Result := inherited Clone;
  TVApNameObj(Result).FName := FName;
end;

constructor TVApNameObj.Load(S: TVStream; Version: Word);
begin
  if Version = 1 then
  begin
    inherited;
    FName := S.ReadOemStr;
  end else
    RaiseVersionNotSupported(Self, Version);
end;

procedure TVApNameObj.Store(S: TVStream);
begin
  inherited;
  S.WriteOemStr(FName);
end;

{ TVApNameColl }

constructor TVApNameColl.Create;
begin
  inherited;
  MakeIndexBy_Name;
end;

function TVApNameColl.GetNameByNumber(N: Word): string;
var
  P: TVApNameObj;
begin
  P := SearchNumberObj(N);
  if P <> nil then
    Result := P.FName
  else
    Result := '*****';
end;

function TVApNameColl.GetNumberByName(const Name: string): Word;
var
  P: TVApNameObj;
begin
  P := SearchNameObj(Name);
  if P <> nil then
    Result := P.FNumber
  else
    Result := 0;
end;

function CompTVApNameObj(Item1, Item2: Pointer): Integer;
begin
  Result := Q_CompText(TVApNameObj(Item1).FName,TVApNameObj(Item2).FName);
end;

function TVApNameKeyOf(Item: Pointer): string;
begin
  Result := TVApNameObj(Item).FName;
end;

procedure TVApNameColl.MakeIndexBy_Name;
var
  PIR: PTVIndexRec;
begin
  CreateIndexRec(PIR);
  with PIR^ do
  begin
    IndName := IndexBy_Name;
    IndCompare := CompTVApNameObj;
    Regular := True;
    Unique := False;
    IndType := itString_I;
    KeyOf_String_I := TVApNameKeyOf;
  end;
  AddIndex(PIR,True);
end;

function TVApNameColl.SearchNameIndex(const Name: string): Integer;
var
  PIR: PTVIndexRec;
begin
  if Q_SameText(FCurrentIndex^.IndName,IndexBy_Name) then
    Result := SearchIndex_String_I(FCurrentIndex,Name)
  else
  begin
    PIR := GetIndexRec(IndexBy_Name);
    Result := SearchIndex_String_I(PIR,Name);
    if Result <> -1 then
      Result := IndexOfByIndex(FCurrentIndex,PIR^.IndList^[Result]);
  end;
end;

function TVApNameColl.SearchNameObj(const Name: string): Pointer;
begin
  if Q_SameText(FCurrentIndex^.IndName,IndexBy_Name) then
    Result := SearchObj_String_I(FCurrentIndex,Name)
  else
    Result := SearchObj_String_I(GetIndexRec(IndexBy_Name),Name);
end;

function TVApNameColl.SearchNextNameIndex(const Name: string;
  var Index: Integer): Boolean;
var
  I: Integer;
  PIR: PTVIndexRec;
begin
  if Q_SameText(FCurrentIndex^.IndName,IndexBy_Name) then
    Result := SearchNext_String_I(FCurrentIndex,Name,Index)
  else if Index = -1 then
  begin
    Index := SearchNameIndex(Name);
    Result := Index<>-1;
  end else
  begin
    PIR := GetIndexRec(IndexBy_Name);
    I := IndexOfByIndex(PIR,Get(Index));
    Result := SearchNext_String_I(PIR,Name,I);
    if Result then
      Index := IndexOfByIndex(FCurrentIndex,PIR^.IndList^[I]);
  end;
end;

{ TVApSortNameColl }

constructor TVApSortNameColl.Load(S: TVStream; Version: Word);
var
  Dup: Boolean;
  PIR: PTVIndexRec;
begin
  if Version = 1 then
  begin
    inherited;
    S.Read(Dup,1);
    PIR := GetIndexRec(IndexBy_Name,False);
    PIR^.Unique := not Dup;
  end else
    RaiseVersionNotSupported(Self, Version);
end;

procedure TVApSortNameColl.Store(S: TVStream);
var
  Dup: Boolean;
begin
  SwitchToIndex(IndexBy_Name);
  inherited;
  Dup := not FCurrentIndex^.Unique;
  S.Write(Dup,1);
end;

{ TVRandomCollection }

procedure TVRandomCollection.FreeItem(Item: Pointer);
begin
  Finalize(PTVRandomItem(Item)^);
  Dispose(PTVRandomItem(Item));
end;

function TVRandomCollection.GetItem(S: TVStream): Pointer;
var
  P: PTVRandomItem;
begin
  New(P);
  with P^ do
  begin
    S.Read(Pos, SizeOf(Pos));
    S.Read(Size, SizeOf(Size));
    Pointer(Key) := nil;
    Key := S.ReadOemStr;
  end;
  Result := P;
end;

procedure TVRandomCollection.PutItem(S: TVStream; Item: Pointer);
begin
  with PTVRandomItem(Item)^ do
  begin
    S.Write(Pos, SizeOf(Pos));
    S.Write(Size, SizeOf(Size));
    S.WriteOemStr(Key);
  end;
end;

function TVRandomCollection.Find(const S: string; var Index: Integer): Boolean;
begin
  Index :=  SearchIndex_String_I(FCurrentIndex,S);
  Result := Index <> -1;
end;

function TVRandomCollection.CloneItem(Item: Pointer): Pointer;
var
  P: PTVRandomItem;
begin
  New(P);
  Pointer(P^.Key) := nil;
  with PTVRandomItem(Item)^ do
  begin
    P^.Pos := Pos;
    P^.Size := Size;
    P^.Key := Key;
  end;
  Result := P;
end;

constructor TVRandomCollection.Create;
begin
  inherited;
  MakeIndexes;
end;

function TVResItemCompare(Item1, Item2: Pointer): Integer;
begin
  Result := Q_CompText(PTVRandomItem(Item1)^.Key,PTVRandomItem(Item2)^.Key);
end;

function TVResItemKeyOf(Item: Pointer): string;
begin
  Result := PTVRandomItem(Item)^.Key;
end;

function TVRandomCompPos(Item1, Item2: Pointer): Integer;
begin
  Result := PTVRandomItem(Item1)^.Pos - PTVRandomItem(Item2)^.Pos;
end;

procedure TVRandomCollection.MakeIndexes;
var
  PIR: PTVIndexRec;
begin
  CreateIndexRec(PIR);
  with PIR^ do
  begin
    IndName := StdIndex;
    IndCompare := TVResItemCompare;
    Regular := True;
    Unique := True;
    IndType := itString_I;
    KeyOf_String_I := TVResItemKeyOf;
  end;
  AddIndex(PIR,True);
  CreateIndexRec(PIR);
  with PIR^ do
  begin
    IndName := ResIndexBy_Pos;
    IndCompare := TVRandomCompPos;
    Regular := True;
    Unique := True;
  end;
  AddIndex(PIR,False);
end;

{ TVRandomFile }

const
  RStreamMagic: Integer = $52504246;
  RStreamBackLink: Integer = $4C424246;
  RStreamNumMagic: Integer = $4E504246;

var
  Rec12: packed record
    N1,N2,N3: Integer;
  end;

constructor TVRandomFile.Create(AStream: TVStream);
type
  THeader = packed record
    Signature: Word;
    case SmallInt of
      0: (
        LastCount: Word;
        PageCount: Word);
      1: (
        InfoType: Word;
        InfoSize: Integer);
  end;
var
  Found, Stop: Boolean;
  Header: THeader;
begin
  if (AStream=nil) or (AStream.FHandle=-1) then
    RaiseTVErr(STVStreamFileNotOpen);
  FStream := AStream;
  FBasePos := FStream.GetPosition;
  FReadOnly := AStream.FMode and 3 = 0;
  Found := False;
  repeat
    Stop := True;
    if FBasePos <= FStream.GetSize-SizeOf(THeader) then
    begin
      FStream.Seek(FBasePos, 0);
      FStream.Read(Header, SizeOf(THeader));
      case Header.Signature of
        $5A4D:
          begin
            Inc(FBasePos, Integer(Header.PageCount)*512 -
              (-Header.LastCount and 511));
            Stop := False;
          end;
        $4246:
          if Header.InfoType = $5250 then
            Found := True
          else
          begin
            Inc(FBasePos, Header.InfoSize + 8);
            Stop := False;
          end;
      end;
    end;
  until Stop;
  if Found then
  begin
    with FStream do
    begin
      Seek(FBasePos+8, 0);
      Read(FIndexPos, 4);
      Seek(FBasePos+FIndexPos, 0);
    end;
    FIndex := TVRandomCollection.Load(FStream,1);
    FModified := False;
  end else
  begin
    if FReadOnly then
      RaiseTVErr(STVResourceNotFound);
    FIndexPos := 12;
    FIndex := TVRandomCollection.Create;
    FModified := True;
  end;
end;

procedure TVRandomFile.Delete(const Key: string);
var
  I: Integer;
begin
  if FIndex.Find(Key,I) then
  begin
    FIndex.DeleteAndFree(I);
    FModified := True;
  end;
end;

procedure TVRandomFile.DeleteAt(I: Integer);
begin
  FIndex.DeleteAndFree(I);
  FModified := True;
end;

destructor TVRandomFile.Destroy;
begin
  Flush;
  FIndex.Free;
  FStream.Free;
end;

procedure TVRandomFile.Flush;
begin
  if FModified then
  begin
    FStream.Seek(FBasePos+FIndexPos,0);
    FIndex.Store(FStream);
    with FStream do
    begin
      with Rec12 do
      begin
        N1 := RStreamMagic;
        N2 := GetPosition-FBasePos-8;
        N3 := FIndexPos;
      end;
      Seek(FBasePos,0);
      Write(Rec12, 12);
      Flush;
    end;
    FModified := False;
  end;
end;

function TVRandomFile.Get(const Key: string): TVObject;
var
  I: Integer;
begin
  if FIndex.Find(Key,I) then
  begin
    FStream.Seek(FBasePos+PTVRandomItem(FIndex[I])^.Pos, 0);
    Result := FStream.Get;
  end else
    Result := nil;
end;

function TVRandomFile.GetCount: Integer;
begin
  Result := FIndex.FCount;
end;

function TVRandomFile.GetFileName: string;
begin
  Result := FStream.FFileName;
end;

function TVRandomFile.KeyAt(I: Integer): string;
begin
  Result := PTVRandomItem(FIndex[I])^.Key;
end;

function TVRandomFile.KeyExists(const Key: string): Boolean;
begin
  with FIndex do
    Result := SearchIndex_String_I(FCurrentIndex, Key) <> -1;
end;

procedure TVRandomFile.Put(const Key: string; Item: TVObject);
var
  I: Integer;
  P: PTVRandomItem;
begin
  if FIndex.Find(Key,I) then
    P := PTVRandomItem(FIndex[I])
  else
  begin
    New(P);
    Pointer(P^.Key) := nil;
    P^.Key := Key;
    FIndex.Add(P);
  end;
  P^.Pos := FIndexPos;
  FStream.Seek(FBasePos+FIndexPos, 0);
  FStream.Put(Item);
  FIndexPos := FStream.GetPosition-FBasePos;
  P^.Size := FIndexPos - P^.Pos;
  FModified := True;
end;

function TVRandomFile.SwitchTo(AStream: TVStream;
  Pack: Boolean): TVStream;
var
  I, NewBasePos: Integer;
  Item: PTVRandomItem;
begin
  if AStream.FHandle = -1 then
    RaiseTVErr(STVStreamFileNotOpen);
  if AStream.FMode and 3 = 0 then
    RaiseTVErr(STVSwitchToReadOnly);
  Result := FStream;
  NewBasePos := AStream.GetPosition;
  if Pack then
  begin
    AStream.Seek(12, 1);
    for I := 0 to FIndex.FCount-1 do
    begin
      Item := PTVRandomItem(FIndex.FList^[I]);
      FStream.Seek(FBasePos+Item^.Pos, 0);
      Item^.Pos := AStream.GetPosition-NewBasePos;
      AStream.CopyFrom(FStream, Item^.Size);
    end;
    FIndexPos := AStream.GetPosition-NewBasePos;
  end else
  begin
    FStream.Seek(FBasePos, 0);
    AStream.CopyFrom(FStream, FIndexPos);
  end;
  FReadOnly := False;
  FStream := AStream;
  FModified := True;
  FBasePos := NewBasePos;
end;

procedure TVRandomFile.Sweep(Shrink: Boolean);
var
  FData: Integer;
  CurrPs: Integer;
  I: Integer;
  Item: PTVRandomItem;
  FileFM: THandle;
  FDataView: Pointer;
  Ls: PTVItemList;
begin
  if FStream.FMode and 2 = 0 then
    RaiseTVErrS(STVPackNonRWStream, FStream.FFileName);
  Ls := FIndex.GetIndexList(ResIndexBy_Pos);
  FData := 0;
  CurrPs := 12;
  FDataView := nil;
  for I := 0 to FIndex.FCount-1 do
  begin
    Item := PTVRandomItem(Ls^[I]);
    if Item^.Pos <> CurrPs then
    begin
      if FDataView = nil then
      begin
        FileFM := CreateFileMapping(FStream.FHandle,nil,PAGE_READWRITE,0,0,nil);
        if FileFM = 0 then
          RaiseTVErrS(STVPackFileMapErr, FStream.FFileName);
        FDataView := MapViewOfFile(FileFM,FILE_MAP_ALL_ACCESS,0,0,0);
        CloseHandle(FileFM);
        if FDataView = nil then
          RaiseTVErrS(STVPackFileMapErr, FStream.FFileName);
        FData := Integer(FDataView)+FBasePos;
      end;
      Q_MoveMem(Pointer(FData+Item^.Pos),Pointer(FData+CurrPs),Item^.Size);
      Item^.Pos := CurrPs;
    end;
    Inc(CurrPs,Item^.Size);
  end;
  FIndexPos := CurrPs;
  if FDataView <> nil then
  begin
    UnmapViewOfFile(FDataView);
    if Shrink then
    begin
      FStream.Seek(FBasePos+FIndexPos,0);
      Win32Check(SetEndOfFile(FStream.FHandle));
    end;
    FModified := True;
  end;
  FIndex.DeactivateAllIndexes;
end;

{ TVResourceFile }

constructor TVResourceFile.Create(AStream: TVStream);
type
  TExeHeader = packed record
    eHdrSize:   Word;
    eMinAbove:  Word;
    eMaxAbove:  Word;
    eInitSS:    Word;
    eInitSP:    Word;
    eCheckSum:  Word;
    eInitPC:    Word;
    eInitCS:    Word;
    eRelocOfs:  Word;
    eOvlyNum:   Word;
    eRelocTab:  Word;
    eSpace:     Array[1..30] of Byte;
    eNewHeader: Word;
  end;

  THeader = packed record
    Signature: Word;
    case SmallInt of
      0: (
        LastCount: Word;
        PageCount: Word;
        ReloCount: Word);
      1: (
        InfoType: Word;
        InfoSize: Integer);
  end;
var
  Header: THeader;
  ExeHeader: TExeHeader;
  Found,Stop: Boolean;
begin
  if (AStream=nil) or (AStream.FHandle=-1) then
    RaiseTVErr(STVStreamFileNotOpen);
  FStream := AStream;
  FBasePos := AStream.GetPosition;
  FReadOnly := AStream.FMode and 3 = 0;
  Found := False;
  repeat
    Stop := True;
    if FBasePos <= FStream.GetSize-SizeOf(THeader) then
    begin
      FStream.Seek(FBasePos,0);
      FStream.Read(Header, SizeOf(THeader));
      case Header.Signature of
        $5A4D:
          begin
            FStream.Read(ExeHeader, SizeOf(TExeHeader));
            FBasePos := ExeHeader.eNewHeader;
            Stop := False;
          end;
        $454E:
          begin
            FBasePos := FStream.GetSize-8;
            Stop := False;
          end;
        $4246:
          begin
            Stop := False;
            case Header.Infotype of
              $5250:
                begin
                  Found := True;
                  Stop := True;
                end;
              $4C42: Dec(FBasePos, Header.InfoSize - 8);
              $4648: Dec(FBasePos, SizeOf(THeader) * 2);
            else
              Stop := True;
            end;
          end;
        $424E:
          if Header.InfoType = $3230 then
          begin
            Dec(FBasePos, Header.InfoSize);
            Stop := False;
          end;
      end;
    end;
  until Stop;
  if Found then
  begin
    with FStream do
    begin
      Seek(FBasePos+8,0);
      Read(FIndexPos,4);
      Seek(FBasePos+FIndexPos,0);
    end;
    FIndex := TVRandomCollection.Load(FStream,1);
    FModified := False;
  end else
  begin
    if FReadOnly then
      RaiseTVErr(STVResourceNotFound);
    FIndexPos := 12;
    FIndex := TVRandomCollection.Create;
    FModified := True;
  end;
end;

procedure TVResourceFile.Flush;
begin
  if FModified then
  begin
    FStream.Seek(FBasePos+FIndexPos,0);
    FIndex.Store(FStream);
    with FStream do
    begin
      with Rec12 do
      begin
        N1 := RStreamBackLink;
        N2 := GetPosition - FBasePos + 8;
      end;
      Write(Rec12, 8);
      Seek(FBasePos,0);
      with Rec12 do
      begin
        N1 := RStreamMagic;
        Dec(N2,8);
        N3 := FIndexPos;
      end;
      Write(Rec12, 12);
      Flush;
    end;
    FModified := False;
  end;
end;

{ TVRandomNumCollection }

var
  RandomNumFields: packed record
    fldPos: Integer;
    fldSize: Integer;
    fldKey: Integer;
    fldSLen: Byte;
  end;

function TVRandomNumCollection.CloneItem(Item: Pointer): Pointer;
var
  P: PTVRandomNumItem;
begin
  New(P);
  P^ := PTVRandomNumItem(Item)^;
  Result := P;
end;

constructor TVRandomNumCollection.Create;
begin
  inherited;
  MakeIndexes;
end;

procedure TVRandomNumCollection.FreeItem(Item: Pointer);
begin
  Dispose(PTVRandomNumItem(Item));
end;

function TVRandomNumCollection.GetItem(S: TVStream): Pointer;
var
  P: PTVRandomNumItem;
begin
  New(P);
  S.ReadB(RandomNumFields,SizeOf(RandomNumFields));
  if RandomNumFields.fldSLen <> 0 then
    S.Skip(RandomNumFields.fldSLen);
  with P^, RandomNumFields do
  begin
    Pos := fldPos;
    Size := fldSize;
    Key := fldKey;
  end;
  Result := P;
end;

function TVRandomNumItemCompare(Item1, Item2: Pointer): Integer;
begin
  Result := PTVRandomNumItem(Item1)^.Key - PTVRandomNumItem(Item2)^.Key;
end;

function TVRandomNumItemKeyOf(Item: Pointer): Integer;
begin
  Result := PTVRandomNumItem(Item)^.Key;
end;

function TVRandomNumCompPos(Item1, Item2: Pointer): Integer;
begin
  Result := PTVRandomNumItem(Item1)^.Pos - PTVRandomNumItem(Item2)^.Pos;
end;

procedure TVRandomNumCollection.MakeIndexes;
var
  PIR: PTVIndexRec;
begin
  CreateIndexRec(PIR);
  with PIR^ do
  begin
    IndName := StdIndex;
    IndCompare := TVRandomNumItemCompare;
    Regular := True;
    Unique := True;
    IndType := itInteger;
    KeyOf_Integer := TVRandomNumItemKeyOf;
  end;
  AddIndex(PIR,True);
  CreateIndexRec(PIR);
  with PIR^ do
  begin
    IndName := ResIndexBy_Pos;
    IndCompare := TVRandomNumCompPos;
    Regular := True;
    Unique := True;
  end;
  AddIndex(PIR,False);
end;

procedure TVRandomNumCollection.PutItem(S: TVStream; Item: Pointer);
begin
  with RandomNumFields, PTVRandomNumItem(Item)^ do
  begin
    fldPos := Pos;
    fldSize := Size;
    fldKey := Key;
    fldSLen := 0;
  end;
  S.Write(RandomNumFields,SizeOf(RandomNumFields));
end;

function TVRandomNumCollection.Find(N: Integer;
  var Index: Integer): Boolean;
begin
  Index := SearchIndex_Integer(FCurrentIndex,N);
  Result := Index <> -1;
end;

{ TVRandomNumFile }

constructor TVRandomNumFile.Create(AStream: TVStream);
type
  THeader = packed record
    Signature: Word;
    case SmallInt of
      0: (
        LastCount: Word;
        PageCount: Word);
      1: (
        InfoType: Word;
        InfoSize: Integer);
  end;
var
  Found, Stop: Boolean;
  Header: THeader;
begin
  if (AStream=nil) or (AStream.FHandle=-1) then
    RaiseTVErr(STVStreamFileNotOpen);
  FStream := AStream;
  FBasePos := FStream.GetPosition;
  FReadOnly := AStream.FMode and 3 = 0;
  Found := False;
  repeat
    Stop := True;
    if FBasePos <= FStream.GetSize-SizeOf(THeader) then
    begin
      FStream.Seek(FBasePos, 0);
      FStream.Read(Header, SizeOf(THeader));
      case Header.Signature of
        $5A4D:
          begin
            Inc(FBasePos, Integer(Header.PageCount)*512 -
              (-Header.LastCount and 511));
            Stop := False;
          end;
        $4246:
          if Header.InfoType = $4E50 then
            Found := True
          else
          begin
            Inc(FBasePos, Header.InfoSize + 8);
            Stop := False;
          end;
      end;
    end;
  until Stop;
  if Found then
  begin
    with FStream do
    begin
      Seek(FBasePos + 8, 0);
      Read(FIndexPos, 4);
      Seek(FBasePos + FIndexPos, 0);
    end;
    FIndex := TVRandomNumCollection.Load(FStream,1);
    FModified := False;
  end else
  begin
    if FReadOnly then
      RaiseTVErr(STVResourceNotFound);
    FIndexPos := 12;
    FIndex := TVRandomNumCollection.Create;
    FModified := True;
  end;
end;

procedure TVRandomNumFile.Delete(Key: Integer);
var
  I: Integer;
begin
  if FIndex.Find(Key, I) then
  begin
    FIndex.DeleteAndFree(I);
    FModified := True;
  end;
end;

procedure TVRandomNumFile.Flush;
begin
  if FModified then
  begin
    FStream.Seek(FBasePos+FIndexPos,0);
    FIndex.Store(FStream);
    with FStream do
    begin
      with Rec12 do
      begin
        N1 := RStreamNumMagic;
        N2 := GetPosition - FBasePos - 8;
        N3 := FIndexPos;
      end;
      Seek(FBasePos, 0);
      Write(Rec12, 12);
      Flush;
    end;
    FModified := False;
  end;
end;

destructor TVRandomNumFile.Destroy;
begin
  Flush;
  FIndex.Free;
  FStream.Free;
end;

function TVRandomNumFile.Get(Key: Integer): TVObject;
var
  I: Integer;
begin
  if FIndex.Find(Key,I) then
  begin
    FStream.Seek(FBasePos+PTVRandomNumItem(FIndex[I])^.Pos, 0);
    Result := FStream.Get;
  end else
    Result := nil;
end;

function TVRandomNumFile.GetCount: Integer;
begin
  Result := FIndex.FCount;
end;

function TVRandomNumFile.GetFileName: string;
begin
  Result := FStream.FFileName;
end;

function TVRandomNumFile.KeyAt(I: Integer): Integer;
begin
  Result := PTVRandomNumItem(FIndex[I])^.Key;
end;

procedure TVRandomNumFile.Put(Key: Integer; Item: TVObject);
var
  I: Integer;
  P: PTVRandomNumItem;
begin
  if FIndex.Find(Key,I) then
    P := PTVRandomNumItem(FIndex[I])
  else
  begin
    New(P);
    P^.Key := Key;
    FIndex.Add(P);
  end;
  P^.Pos := FIndexPos;
  FStream.Seek(FBasePos+FIndexPos, 0);
  FStream.Put(Item);
  FIndexPos := FStream.GetPosition-FBasePos;
  P^.Size := FIndexPos - P^.Pos;
  FModified := True;
end;

function TVRandomNumFile.SwitchTo(AStream: TVStream;
  Pack: Boolean): TVStream;
var
  I, NewBasePos: Integer;
  Item: PTVRandomNumItem;
begin
  if AStream.FHandle = -1 then
    RaiseTVErr(STVStreamFileNotOpen);
  if AStream.FMode and 3 = 0 then
    RaiseTVErr(STVSwitchToReadOnly);
  Result := FStream;
  NewBasePos := AStream.GetPosition;
  if Pack then
  begin
    AStream.Seek(12, 1);
    for I := 0 to FIndex.FCount-1 do
    begin
      Item := PTVRandomNumItem(FIndex.FList^[I]);
      FStream.Seek(FBasePos+Item^.Pos, 0);
      Item^.Pos := AStream.GetPosition-NewBasePos;
      AStream.CopyFrom(FStream, Item^.Size);
    end;
    FIndexPos := AStream.GetPosition-NewBasePos;
  end else
  begin
    FStream.Seek(FBasePos, 0);
    AStream.CopyFrom(FStream, FIndexPos);
  end;
  FReadOnly := False;
  FStream := AStream;
  FModified := True;
  FBasePos := NewBasePos;
end;

function TVRandomNumFile.KeyExists(Key: Integer): Boolean;
begin
  with FIndex do
    Result := SearchIndex_Integer(FCurrentIndex, Key) <> -1;
end;

procedure TVRandomNumFile.DeleteAt(I: Integer);
begin
  FIndex.DeleteAndFree(I);
  FModified := True;
end;

procedure TVRandomNumFile.Sweep(Shrink: Boolean);
var
  FData: Integer;
  CurrPs: Integer;
  I: Integer;
  Item: PTVRandomNumItem;
  FileFM: THandle;
  FDataView: Pointer;
  Ls: PTVItemList;
begin
  if FStream.FMode and 2 = 0 then
    RaiseTVErrS(STVPackNonRWStream, FStream.FFileName);
  Ls := FIndex.GetIndexList(ResIndexBy_Pos);
  FData := 0;
  CurrPs := 12;
  FDataView := nil;
  for I := 0 to FIndex.FCount-1 do
  begin
    Item := PTVRandomNumItem(Ls^[I]);
    if Item^.Pos <> CurrPs then
    begin
      if FDataView = nil then
      begin
        FileFM := CreateFileMapping(FStream.FHandle,nil,PAGE_READWRITE,0,0,nil);
        if FileFM = 0 then
          RaiseTVErrS(STVPackFileMapErr, FStream.FFileName);
        FDataView := MapViewOfFile(FileFM,FILE_MAP_ALL_ACCESS,0,0,0);
        CloseHandle(FileFM);
        if FDataView = nil then
          RaiseTVErrS(STVPackFileMapErr, FStream.FFileName);
        FData := Integer(FDataView)+FBasePos;
      end;
      Q_MoveMem(Pointer(FData+Item^.Pos),Pointer(FData+CurrPs),Item^.Size);
      Item^.Pos := CurrPs;
    end;
    Inc(CurrPs,Item^.Size);
  end;
  FIndexPos := CurrPs;
  if FDataView <> nil then
  begin
    UnmapViewOfFile(FDataView);
    if Shrink then
    begin
      FStream.Seek(FBasePos+FIndexPos,0);
      Win32Check(SetEndOfFile(FStream.FHandle));
    end;
    FModified := True;
  end;
  FIndex.DeactivateAllIndexes;
end;

{ TVLocksCollection }

function TVLocksCollection.AddLock(const AFileName: string; AMode: Word): Integer;
var
  P: PTVLockRec;
  L,H: Integer;
begin
  if not FileExists(AFileName) then
    RaiseLockFileNotFound(AFileName);
  if Find(AFileName,L) then
    RaiseTVErrS(STVRepeatedLock, AFileName);
  H := FileOpen(AFileName,fmOpenReadWrite or AMode);
  if H <> -1 then
  begin
    New(P);
    with P^ do
    begin
      Handle := H;
      Pointer(FileName) := nil;
      FileName := AFileName;
      Mode := AMode;
    end;
    if FCount = FCapacity then
      Grow;
    if L < FCount then
      Q_MoveLongs(@FList^[L],@FList^[L+1],FCount-L);
    FList^[L] := P;
    Inc(FCount);
    Result := L;
  end else
    Result := -1;
end;

procedure TVLocksCollection.ClearAllLocks;
var
  I: Integer;
  P: PTVLockRec;
begin
  for I := 0 to FCount-1 do
  begin
    P := FList^[I];
    if P^.Handle <> -1 then
      FileClose(P^.Handle);
    Finalize(P^);
    Dispose(P);
  end;
  FCount := 0;
end;

procedure TVLocksCollection.Delete(Index: Integer);
var
  P: PTVLockRec;
begin
  if (Index>=0) and (Index<FCount) then
  begin
    P := FList^[Index];
    if P^.Handle <> -1 then
      FileClose(P^.Handle);
    Finalize(P^);
    Dispose(P);
    Dec(FCount);
    if Index < FCount then
      Q_MoveLongs(@FList^[Index+1],@FList^[Index],FCount-Index);
  end else
    RaiseTVErrD(STVInvalidLockIndex, Index);
end;

destructor TVLocksCollection.Destroy;
begin
  ClearAllLocks;
  SetCapacity(0);
end;

function TVLocksCollection.Find(const S: string; var Index: Integer): Boolean;
var
  L,H,I,C: Integer;
begin
  L := 0;
  H := FCount-1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := Q_CompText(FList^[I]^.FileName,S);
    if C < 0 then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Index := I;
        Result := True;
        Exit;
      end;
    end;
  end;
  Index := L;
  Result := False;
end;

function TVLocksCollection.SearchIndex(const AFileName: string): Integer;
var
  I: Integer;
begin
  if Find(AFileName,I) then
    Result := I
  else
    Result := -1;
end;

procedure TVLocksCollection.Grow;
begin
  if FCapacity > 64 then
    SetCapacity(FCapacity + FCapacity shr 2)
  else if FCapacity > 8 then
    SetCapacity(FCapacity + 16)
  else
    SetCapacity(FCapacity + 4);
end;

procedure TVLocksCollection.SetCapacity(NewCapacity: Integer);
begin
  if (NewCapacity>=FCount) and (NewCapacity<=MaxCollectionSize) then
  begin
    ReallocMem(FList, NewCapacity * SizeOf(PTVLockRec));
    FCapacity := NewCapacity;
  end else
    RaiseTVErr(STVLocksInnerError);
end;

procedure TVLocksCollection.InnerLockContinue(Index: Integer);
begin
  with FList^[Index]^ do
  begin
    if not FileExists(FileName) then
      RaiseLockFileNotFound(FileName);
    Handle := FileOpen(FileName,fmOpenReadWrite or Mode);
    if Handle = -1 then
      RaiseCannotLockFile(FileName);
  end;
end;

procedure TVLocksCollection.LockContinue(Index: Integer);
begin
  if (Index>=0) and (Index<FCount) then
  begin
    if FList^[Index]^.Handle = -1 then
      InnerLockContinue(Index)
    else
      RaiseTVErrS(STVLockWasNotPaused, FList^[Index]^.FileName);
  end else
    RaiseTVErrD(STVInvalidLockIndex, Index);
end;

procedure TVLocksCollection.LockPause(Index: Integer);
begin
  if (Index>=0) and (Index<FCount) then
  begin
    with FList^[Index]^ do
      if Handle <> -1 then
      begin
        FileClose(Handle);
        Handle := -1;
      end else
        RaiseTVErrS(STVLockAlreadyPaused, FileName);
  end else
    RaiseTVErrD(STVInvalidLockIndex, Index);
end;

function TVLocksCollection.GetLockFileName(Index: Integer): string;
begin
  if (Index<0) or (Index>=FCount) then
    RaiseTVErrD(STVInvalidLockIndex, Index);
  Result := FList^[Index]^.FileName;
end;

function TVLocksCollection.GetLockMode(Index: Integer): Word;
begin
  if (Index<0) or (Index>=FCount) then
    RaiseTVErrD(STVInvalidLockIndex, Index);
  Result := FList^[Index]^.Mode;
end;

procedure TVLocksCollection.SetLockFileName(Index: Integer; const AFileName: string);
begin
  if (Index>=0) and (Index<FCount) then
    with FList^[Index]^ do
    begin
      if Handle = -1 then
        FileName := AFileName
      else
      begin
        FileClose(Handle);
        FileName := AFileName;
        InnerLockContinue(Index);
      end;
    end
  else
    RaiseTVErrD(STVInvalidLockIndex, Index);
end;

procedure TVLocksCollection.SetLockMode(Index: Integer; AMode: Word);
begin
  if (Index>=0) and (Index<FCount) then
    with FList^[Index]^ do
    begin
      if Handle = -1 then
        Mode := AMode
      else
      begin
        FileClose(Handle);
        Mode := AMode;
        InnerLockContinue(Index);
      end;
    end
  else
    RaiseTVErrD(STVInvalidLockIndex, Index);
end;

{ Misc. subroutines }

function LoadObject(const AFileName: string; var Obj; Security: PTVProtection): Integer;
var
  Strm: TVStream;
  Ticks: LongWord;
begin
  TVObject(Obj) := nil;
  Strm := TVStream.Create;
  try
    repeat
      NetWaitState := nwNone;
      try
        with Strm do
        begin
          OpenFile(AFileName, fmOpenReadOnly);
          TVObject(Obj) := Get(Security);
          CloseFile;
        end;
      except
        on E: ETVStrmOpenError do
          begin
            if csDestroying in Application.ComponentState then
            begin
              NetWaitState := nwIgnore;
              Break;
            end;
            NWNotifyForm := TNetWaitNotifyForm.Create(Application);
            with NWNotifyForm do
            begin
              LabInfo.Caption := NWNotifyMsgStart+AFileName+NWNotifyMsgRead;
              Show;
            end;
            Ticks := GetTickCount;
            if Ticks < $FFFF159F then
            begin
              Inc(Ticks,10000);
              repeat
                Application.ProcessMessages;
              until (NetWaitState<>nwNone) or (GetTickCount>Ticks);
            end;
            NWNotifyForm.Free;
            if NetWaitState = nwNone then
              NetWaitState := nwRetry;
          end;
      end;
    until NetWaitState <> nwRetry;
  finally
    Strm.Free;
  end;
  Result := NetWaitState;
end;

function SaveObject(const AFileName: string; Obj: TVObject; Security: PTVProtection): Integer;
var
  Strm: TVStream;
  Ticks: LongWord;
begin
  Strm := TVStream.Create;
  try
    repeat
      NetWaitState := nwNone;
      try
        with Strm do
        begin
          CreateFile(AFileName);
          Put(Obj,Security);
          CloseFile;
        end;
      except
        on E: ETVStrmCreateError do
          begin
            if csDestroying in Application.ComponentState then
            begin
              NetWaitState := nwIgnore;
              Break;
            end;
            NWNotifyForm := TNetWaitNotifyForm.Create(Application);
            with NWNotifyForm do
            begin
              LabInfo.Caption := NWNotifyMsgStart+AFileName+NWNotifyMsgWrite;
              Show;
            end;
            Ticks := GetTickCount;
            if Ticks < $FFFF159F then
            begin
              Inc(Ticks,10000);
              repeat
                Application.ProcessMessages;
              until (NetWaitState<>nwNone) or (GetTickCount>Ticks);
            end;
            NWNotifyForm.Free;
            if NetWaitState = nwNone then
              NetWaitState := nwRetry;
          end;
      end;
    until NetWaitState <> nwRetry;
  finally
    Strm.Free;
  end;
  Result := NetWaitState;
end;

function OpenStreamForResource(const AFileName: string; var Strm: TVStream;
  WriteAllow: Boolean): Integer;
var
  Ticks: LongWord;
begin
  repeat
    NetWaitState := nwNone;
    try
      if not WriteAllow then
        Strm.OpenFile(AFileName, fmOpenReadOnly)
      else if FileExists(AFileName) then
        Strm.OpenFile(AFileName, fmOpenExclusive)
      else
      begin
        Strm.CreateFile(AFileName);
        NetWaitState := lsNewResourceCreated;
      end;
    except
      on E: ETVStrmOpenError do
        begin
          if csDestroying in Application.ComponentState then
          begin
            Result := nwIgnore;
            Exit;
          end;
          NWNotifyForm := TNetWaitNotifyForm.Create(Application);
          with NWNotifyForm do
          begin
            if WriteAllow then
              LabInfo.Caption := NWNotifyResMsgStart+AFileName+NWNotifyMsgWrite
            else
              LabInfo.Caption := NWNotifyResMsgStart+AFileName+NWNotifyMsgRead;
            Show;
          end;
          Ticks := GetTickCount;
          if Ticks < $FFFF159F then
          begin
            Inc(Ticks,10000);
            repeat
              Application.ProcessMessages;
            until (NetWaitState<>nwNone) or (GetTickCount>Ticks);
          end;
          NWNotifyForm.Free;
          if NetWaitState = nwNone then
            NetWaitState := nwRetry;
        end;
    end;
  until NetWaitState <> nwRetry;
  Result := NetWaitState;
end;

function LoadStorageObject(const AFileName: string; Key: Integer;
  var Obj; TagPtr: PInteger; Security: PTVProtection): Integer;
var
  Strm: TVStream;
  Stg: TVStorage;
begin
  TVObject(Obj) := nil;
  Strm := TVStream.Create;
  try
    Result := OpenStreamForResource(AFileName, Strm, False);
  except
    Strm.Free;
    raise;
  end;
  if Result = 0 then
  begin
    Stg := TVStorage.Create(Strm);
    with Stg do
    begin
      if TagPtr = nil then
        TVObject(Obj) := Get(Key,Security)
      else
        TVObject(Obj) := GetTg(Key,TagPtr^,Security);
      Free;
    end;
  end else
    Strm.Free;
end;

function SaveStorageObject(const AFileName: string; Key: Integer;
  Obj: TVObject; Tag: Integer; Security: PTVProtection): Integer;
var
  Strm: TVStream;
  Stg: TVStorage;
begin
  Strm := TVStream.Create;
  try
    Result := OpenStreamForResource(AFileName, Strm, True);
  except
    Strm.Free;
    raise;
  end;
  if Result >= 0 then
  begin
    Stg := TVStorage.Create(Strm);
    if (Result=0) and Stg.FModified then
      Result := lsNewResourceCreated;
    with Stg do
    begin
      PutTg(Key,Obj,Tag,Security);
      Free;
    end;
  end else
    Strm.Free;
end;

function IsStorageEmpty(const AFileName: string): Boolean;
var
  Strm: TVStream;
  C,Num: Integer;
begin
  if not FileExists(AFileName) then
    Result := True
  else
  begin
    Result := False;
    Strm := TVStream.Create;
    try
      C := OpenStreamForResource(AFileName, Strm, False);
    except
      Strm.Free;
      raise;
    end;
    if C = 0 then
    begin
      if Strm.GetSize >= StHeaderSize then
      begin
        Strm.Seek(0, 0);
        Strm.Read(Num, SizeOf(Num));
        if Num = Integer(StgMagicNumber) then
        begin
          Strm.ReadB(StgHeader, SizeOf(StgHeader));
          Result := not (StgHeader.Cnt > 0);
        end else
          RaiseTVErrS(STVStorageNotFound, AFileName);
      end else
        Result := True;
    end;
    Strm.Free;
  end;
end;

function DeleteStorageObject(const AFileName: string; Key: Integer): Integer;
var
  Strm: TVStream;
  Stg: TVStorage;
begin
  Strm := TVStream.Create;
  try
    Result := OpenStreamForResource(AFileName, Strm, True);
  except
    Strm.Free;
    raise;
  end;
  if Result >= 0 then
  begin
    Stg := TVStorage.Create(Strm);
    if (Result=0) and Stg.FModified then
      Result := lsNewResourceCreated;
    with Stg do
    begin
      Delete(Key);
      Free;
    end;
  end else
    Strm.Free;
end;

function OpenStorage(const AFileName: string; var Stg: TVStorage;
  WriteAllow: Boolean): Integer;
var
  Strm: TVStream;
begin
  Strm := TVStream.Create;
  try
    Result := OpenStreamForResource(AFileName, Strm, WriteAllow);
  except
    Strm.Free;
    raise;
  end;
  if Result >= 0 then
  begin
    Stg := TVStorage.Create(Strm);
    if (Result=0) and Stg.FModified then
      Result := lsNewResourceCreated;
  end else
  begin
    Strm.Free;
    Stg := nil;
  end;
end;

function LoadRandomObject(const AFileName, Key: string; var Obj): Integer;
var
  Strm: TVStream;
  Rsrs: TVRandomFile;
begin
  TVObject(Obj) := nil;
  Strm := TVStream.Create;
  try
    Result := OpenStreamForResource(AFileName, Strm, False);
  except
    Strm.Free;
    raise;
  end;
  if Result = 0 then
  begin
    Rsrs := TVRandomFile.Create(Strm);
    TVObject(Obj) := Rsrs.Get(Key);
    Rsrs.Free;
  end else
    Strm.Free;
end;

function LoadRandomNumObject(const AFileName: string; Key: Integer; var Obj): Integer;
var
  Strm: TVStream;
  Rsrs: TVRandomNumFile;
begin
  TVObject(Obj) := nil;
  Strm := TVStream.Create;
  try
    Result := OpenStreamForResource(AFileName, Strm, False);
  except
    Strm.Free;
    raise;
  end;
  if Result = 0 then
  begin
    Rsrs := TVRandomNumFile.Create(Strm);
    TVObject(Obj) := Rsrs.Get(Key);
    Rsrs.Free;
  end else
    Strm.Free;
end;

function SaveRandomObject(const AFileName, Key: string; Obj: TVObject;
  Pack: Boolean): Integer;
var
  Strm: TVStream;
  Rsrs: TVRandomFile;
begin
  Strm := TVStream.Create;
  try
    Result := OpenStreamForResource(AFileName, Strm, True);
  except
    Strm.Free;
    raise;
  end;
  if Result >= 0 then
  begin
    Rsrs := TVRandomFile.Create(Strm);
    if (Result=0) and Rsrs.FModified then
      Result := lsNewResourceCreated;
    Rsrs.Put(Key, Obj);
    if Pack then
      Rsrs.Sweep;
    Rsrs.Free;
  end else
    Strm.Free;
end;

function SaveRandomNumObject(const AFileName: string; Key: Integer;
  Obj: TVObject; Pack: Boolean): Integer;
var
  Strm: TVStream;
  Rsrs: TVRandomNumFile;
begin
  Strm := TVStream.Create;
  try
    Result := OpenStreamForResource(AFileName, Strm, True);
  except
    Strm.Free;
    raise;
  end;
  if Result >= 0 then
  begin
    Rsrs := TVRandomNumFile.Create(Strm);
    if (Result=0) and Rsrs.FModified then
      Result := lsNewResourceCreated;
    Rsrs.Put(Key, Obj);
    if Pack then
      Rsrs.Sweep;
    Rsrs.Free;
  end else
    Strm.Free;
end;

function OpenResource(const AFileName: string; var Rsrs: TVRandomFile;
  WriteAllow: Boolean): Integer;
var
  Strm: TVStream;
begin
  Strm := TVStream.Create;
  try
    Result := OpenStreamForResource(AFileName, Strm, WriteAllow);
  except
    Strm.Free;
    raise;
  end;
  if Result >= 0 then
  begin
    Rsrs := TVRandomFile.Create(Strm);
    if (Result=0) and Rsrs.FModified then
      Result := lsNewResourceCreated;
  end else
  begin
    Strm.Free;
    Rsrs := nil;
  end;
end;

function OpenResource(const AFileName: string; var Rsrs: TVRandomNumFile;
  WriteAllow: Boolean): Integer;
var
  Strm: TVStream;
begin
  Strm := TVStream.Create;
  try
    Result := OpenStreamForResource(AFileName, Strm, WriteAllow);
  except
    Strm.Free;
    raise;
  end;
  if Result >= 0 then
  begin
    Rsrs := TVRandomNumFile.Create(Strm);
    if (Result=0) and Rsrs.FModified then
      Result := lsNewResourceCreated;
  end else
  begin
    Strm.Free;
    Rsrs := nil;
  end;
end;

function OpenResource(const AFileName: string; var Rsrs: TVResourceFile;
  WriteAllow: Boolean): Integer;
var
  Strm: TVStream;
begin
  Strm := TVStream.Create;
  try
    Result := OpenStreamForResource(AFileName, Strm, WriteAllow);
  except
    Strm.Free;
    raise;
  end;
  if Result >= 0 then
  begin
    Rsrs := TVResourceFile.Create(Strm);
    if (Result=0) and Rsrs.FModified then
      Result := lsNewResourceCreated;
  end else
  begin
    Strm.Free;
    Rsrs := nil;
  end;
end;

procedure RaiseTVErr(const Msg: string);
begin
  raise Exception.Create(Msg);
end;

procedure RaiseTVErrS(const Msg, S: string);
begin
  raise Exception.CreateFmt(Msg,[S]);
end;

procedure RaiseTVErrShS(const Msg: string; const S: ShortString);
begin
  raise Exception.
  CreateFmt(Msg,[S]);
end;

procedure RaiseTVErrD(const Msg: string; D: Integer);
begin
  raise Exception.CreateFmt(Msg,[D]);
end;

procedure RaiseTVErrDS(const Msg: string; D: Integer; const S: string);
begin
  raise Exception.CreateFmt(Msg,[D, S]);
end;

procedure RaiseTVErrObj(const Msg: string; Obj: TObject);
begin
  raise Exception.CreateFmt(Msg,[Obj.ClassName]);
end;

procedure RaiseTVErrSObj(const Msg, S: string; Obj: TObject);
begin
  raise Exception.CreateFmt(Msg,[S, Obj.ClassName]);
end;

procedure RaiseTVErrObjS(const Msg: string; Obj: TObject; const S: string);
begin
  raise Exception.CreateFmt(Msg,[Obj.ClassName, S]);
end;

procedure RaiseUniqueIndexViolation(const AIndexName: string; Obj: TVObject);
var
  I,J: Integer;
  PIR,PIR1: PTVIndexRec;
begin
  with Obj as TVUniCollection do
    for I := FIndexes.FCount-1 downto 0 do
    begin
      PIR := FIndexes.FList^[I];
      if PIR^.Active then
      begin
        for J := I-1 downto 0 do
        begin
          PIR1 := FIndexes.FList^[J];
          if PIR1^.Active then
          begin
            Q_CopyLongs(PIR^.IndList,PIR1^.IndList,FCount);
            UpdateIndexByPIR(PIR1);
          end;
        end;
        Break;
      end;
    end;
  raise ETVUniqueIndexViolation.CreateFmt(STVUniqueIndexViolation,[AIndexName, Obj.ClassName]);
end;

procedure RaiseLinkIDNotIdentified(Obj: TVObject; const ALinkID: string);
begin
  raise ETVLinkIDNotIdentified.CreateFmt(STVLinkIDNotIdentified, [Obj.ClassName, ALinkID]);
end;

procedure RaiseStrmCreateError(const AFileName: string);
begin
  raise ETVStrmCreateError.CreateFmt(STVStrmCreateError,[AFileName]);
end;

procedure RaiseStrmFileNotFound(const AFileName: string);
begin
  raise ETVStrmFileNotFound.CreateFmt(STVStrmFileNotFound,[AFileName]);
end;

procedure RaiseStrmOpenError(const AFileName: string);
begin
  raise ETVStrmOpenError.CreateFmt(STVStrmOpenError,[AFileName]);
end;

procedure RaiseStrmReadError(const AFileName: string);
begin
  raise ETVStrmReadError.CreateFmt(STVStrmReadError,[AFileName]);
end;

procedure RaiseStrmDataCorrupted(const AFileName: string);
begin
  raise ETVStrmDataCorrupted.CreateFmt(STVStrmDataCorrupted,[AFileName]);
end;

procedure RaiseStrmWriteError(const AFileName: string);
begin
  raise ETVStrmWriteError.CreateFmt(STVStrmWriteError,[AFileName]);
end;

procedure RaiseStrmSeekError(const AFileName: string);
begin
  raise ETVStrmSeekError.CreateFmt(STVStrmSeekError,[AFileName]);
end;

procedure RaiseVersionNotSupported(Obj: TVObject; AVersion: Word);
begin
  raise ETVVersionNotSupported.CreateFmt(STVVersionNotSupported, [Obj.ClassName, AVersion]);
end;

procedure RaiseLockFileNotFound(const AFileName: string);
begin
  raise ETVLockFileNotFound.CreateFmt(STVLockFileNotFound,[AFileName]);
end;

procedure RaiseCannotLockFile(const AFileName: string);
begin
  raise ETVCannotLockFile.CreateFmt(STVCannotLockFile,[AFileName]);
end;

procedure RaiseInvalidRangeBounds(Obj: TVObject; const AIndexName: string);
begin
  raise ETVInvalidRangeBounds.CreateFmt(STVInvalidRangeBounds,[Obj.ClassName, AIndexName]);
end;

initialization
  RegisterTVObject(rg01_TVApSortNameColl,TVApSortNameColl,1,True);
  RegisterTVObject(rg01_TVApSortNumberColl,TVApSortNumberColl,1,True);
  RegisterTVObject(rg01_TVApNumberColl,TVApNumberColl,1,True);
  RegisterTVObject(rg01_TVUniNumberColl,TVUniNumberColl,1,True);
  RegisterTVObject(rg01_TVRandomGenerator,TVRandomGenerator,1,True);
  RegisterTVObject(rg01_TVCollection,TVCollection,1,True);
  RegisterTVObject(rg01_TVStringCollection,TVStringCollection,1,True);
  RegisterTVObject(rg01_TVApNameColl,TVApNameColl,1,True);
  RegisterTVObject(rg01_TVUniNameColl,TVUniNameColl,1,True);
  RegisterTVObject(rg01_TVApNumberObj,TVApNumberObj,1,True);
  RegisterTVObject(rg01_TVMarks,TVMarks,1,True);
  RegisterTVObject(rg01_TVApNameObj,TVApNameObj,1,True);
  RegisterTVObject(rg01_TVUniNumberObj,TVUniNumberObj,1,True);
  RegisterTVObject(rg01_TVWordSet,TVWordSet,1,True);
  RegisterTVObject(rg01_TVIntegerSet,TVIntegerSet,1,True);
  RegisterTVObject(rg01_TVUniNameObj,TVUniNameObj,1,True);

  Locks := TVLocksCollection.Create;
  Randomize;

finalization
  Locks.Free;
  if RegLdCapacity > 0 then
  begin
    FreeMemory(RegLdObjIDs);
    FreeMemory(RegLdList);
  end;
  if RegStCapacity > 0 then
  begin
    FreeMemory(RegStClsTypes);
    FreeMemory(RegStObjIDs);
  end;

end.

