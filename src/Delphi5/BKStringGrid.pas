{Programmed by Bjørn Kvisli, 1998
Thanks to Peter Below (TeamB) for the sort algoritm.
Thanks to Tom Lee for the encryption component.}


{This unit contains code for the TBKStringGrid component.}
unit BKStringGrid;


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Encryp;

type
	{An exception which is raised in TBKStringGrid when trying to load data
	from an invalid file.}
	EInvalidFile = class(Exception);
   {This exception is raised in TBKStringGrid when trying to read strings
   from file, and there are more strings in file than fits into the grid.}
   ETooSmallGrid = class(EXception);
   {This exception is raised by TBKStringGrid when sorting the grid and
   the column number to sort by is invalid. I.e. if it is one of the fixed
   columns and the SortByFixedCol property is set to false.}
   EWrongCol = class(EXception);
   {TBKStringGrid is a descendant of TStringGrid.  Here are some of the
   features I added:
   a) It is possible to sort the strings by column in deescending or ascending
   order. b) One can write the strings to a text file. c) One can load strings
   into the grid from a file created by the component. d) One can choose to
   encrypt the strings when writing to the file and decrypting them when
   reading from the file. e) There is an event that makes it convenient to
   validate user input.}
   TBKStringGrid = class(TStringGrid)
  private
     FOnSortedAsc :TNotifyEvent;
     FOnSortedDesc :TNotifyEvent;
     FOnUserChangedCell : TSetEditEvent;
     FCaseSensitive: BOolean;
     FSortByFixedCol:Boolean;
     FBlanksDown:Boolean;
     FbyColumn : LongInt;
     FFilename : String;
     FEncryption: Boolean;
     FEncryptionKey:String;
     Encrypt:TTomEncryption;
     FCallOnAfterEdit:Boolean;
     FGotEditText:String;
     Procedure InvertGrid;
     procedure QuickSort(L, R: Integer);
     Procedure ExchangeGridRows( i, j: Integer );
     Procedure SendBlanksDown;
     Function Encr(str:string) : string;
     Function Decr(str:string) :string;
     Function IsStringBlank(str:string) : Boolean;
    { Private declarations }
  protected
   	procedure SetEditText(ACol,ARow:Longint; const Value: string);override;
	  	function SelectCell(Col,Row:Longint): Boolean;override;
       function GetEditText(Acol:integer;Arow:Integer):string; override;
    { Protected declarations }
  public
  		{Use this function to find out if a particular cell in the grid is
       blank. The function returns true if that is the case. The cell is
       considered blank if it does not contain anything or if it only
       contains character with ASCII value 32 or lower. (Space or control
       characters).  }
   Function IsCellBlank(Col:integer;Row:Integer):Boolean;
   	 		{Thse constructor sets some default values for TBKStringGrid properties.
		   It also create an instance of the enctyption compoment (TTOmEncryption)
		   and gices it a default encryption key if you don't specify one in
		   TBKStringGrid's  EncryptionKey property.}
	  constructor Create(AOwner:TComponent);Override;
	     {Also destroys the encryption comonent.}
     destructor Destroy; override;
	     {This procedure sorts the rows of the grid in ascending or descending
	     order by the column you specify.
   	  The first parameter is the number of the column you want to sort by.
	     The leftmost column is no. 0. Which columnumber are acceptable depends
   	  on the  SortByFixedCol property. The result of this method also depends
	     on the values of the CaseSensitive property and the BlanksDown property. }
     Procedure   SortStringgrid(  byColumn: LongInt;  ascending: Boolean );
     					Virtual;
	     {This procedure writes the strings to a text file. The name of the
   	  file must be given in the FileName property. If the Encryption property
	     is set to True, the strings are encrypted when written to the file.
        Also strings in the fixed rows and fixed columns are written to the file.
        Strings are written from left to right, row by row. }
     Procedure FileStrings;
	     {This procedure loads the strings into the grid from a text file. The name
   	  of the file must be given in the FileName property. If the Encryption
         property is set to True, the strings are decrypted.  }
     Procedure RetrieveStrings;

    { Public declarations }
  published
	  	{This property makes the sort case sensitive if set to true and not case
		  sensitive when set to false. If True capital letters will preceed small
         letters in ascending sequence and you may see sequences like ABCabc.
         With this property set to false you may see squences like AaBbCc.}
  	property CaseSensitive:Boolean read FCaseSensitive write FCaseSensitive;
	   {If set to True, you may sort by one of the grid's fixed columns. If set
   	to False an exception will be raised if you try to sort by a fixed column.
	   Also when True, the data in the fixed columns will shift row during sort.
   	If False the data in fixed columns will not be rearranged during sort.}
   property SortByFixedCol:Boolean read FSortByFixedCol write FSortByFixedCol;
	   {This is the name of the file used by the FileStrings and RetrieveStrings
   	methods.}
   property Filename: string read FFileName write FFileName;
   	{This event occurs when the grid has been sorted in ascending order.}
   Property OnSortedAsc:TNotifyEvent read FOnSortedAsc write FOnSortedAsc;
  		{ This event occors when the grid has been sorted in descending order.}
   Property OnSortedDesc:TNotifyEvent read FOnSortedDesc write FOnSortedDesc;
	   {If set to True, all blank rows will be placed at the lower en of the grid.
   	If set to False empty rows will appear at the top of the grid after an
	   ascending sort. The definition of empty rows depend on the SortByFixedCol
	   property. If SortByFixedCol is False an empty row is a row with no strings
	   in any of its columns. Otherwise on non fixed columns need to be empty
	   for the row to be considered empty.  }
   Property BlanksDown:Boolean read FBlanksDown write FBlanksDown;
   	{If this property is set to True, strings are encrypted when written
       to a file.  The property must also be set to true for the strings
       to be decrypted when loaded from a file. }
   Property Encryption:Boolean read FEncryption write FEncryption ;
   	{This is the key used by the encryption component when the strings are
	   encrypted and decrypted. If you do not spefecify anything for this
	   property, TBKStringGrid will supply the encryption component with
	   a default key. You should be carefull if you choose to set this property at
	   run time: Strings must be decrypted with the same key as was used during
	   encryption. }
   Property EncryptionKey: string read FEncryptionKey write FEncryptionKey;
   	{This event occurs when the user is finished editing a cell, and
       the contents of the cell was changed. If the user leaves
       editormode without changing the cell's contents, this event
       will not occur.  Unlike OnSetEditText
       OnUserChangedCell only occurs when the user quits editormode.
        You can
       use this event to validate user input.  This event does not occur if
       option goEditing is False. Neither will it occur if option
       goAlwaysShowEditor is True.	}
      property OnUserChangedCell:TSetEditEvent read FOnUserChangedCell
      			 write FOnUserChangedCell;
  end;   {TBKStringGrid}

  {Registers TBKStringGrid in the Delphi 3 palette under Samples.}
procedure Register;

implementation


Procedure TBKStringGrid.SendBlanksDown;
  var
		IsBlanks, AllBlanks:Boolean;
	   i,j,k,c,r:integer;
	   FirstNonBlank: integer ;
  begin
		// find out if blanks columns are found. Always on top
		IsBlanks := True;
		if SortByFixedCol then i := 0 else i := FixedCols;
		j:=i;
		while j <  ColCount do
	    begin
   		if (not IsStringBlank(Rows[FixedRows].Strings[j])) then
          { (Rows[FixedRows].Strings[j] <> '') and
           				(Rows[FixedRows].Strings[j] <> ' ') then}
       	begin
       		IsBlanks := False;
	           break;
   	    end;
       	Inc(j);
	    end;
       if not IsBlanks then exit;

   // find first non blank row if any
   	r:=0;
	    AllBlanks := true;
       FirstNonBlank := -1;
		for r := FixedRows to RowCount -1 do
	    begin
   		For c:= i to ColCount -1 do
       	begin
          		if not IsStringBlank(Cells[c,r]) then
                begin
    		       	AllBlanks := False;
           	    Break;
          		end;
           end;
       if not AllBlanks then Break;
	    end;

		if not AllBlanks then FirstNonBlank:=r
	   	else exit; // no need to go on. all blank


   //send the blank rows down.
	   j:= fixedRows;
	   k:=FirstNonBlank;
	   while (k < RowCount) do
	   begin
      	  ExchangeGridRows(j,k);
	      inc(k);
   	  inc(j);
	   end;

end;



Procedure TBKStringGrid.RetrieveStrings;
var
	PwdFile:TextFile;
   r:LongInt;
   c:LongInt;
   Id:string;
   Maj:string;
   Min:String;
   Ver:String;
   Inn:string;
begin
	try
		Assignfile(PwdFile,FFIleName);
		Reset(PwdFile);
       if eof(PwdFile) then raise EInvalidFile.Create
       	('Invalid file. Program cannot read data');
   	Readln(PwdFile,Id);
       if eof(PwdFile) then raise EInvalidFile.Create
       	('Invalid file. Program cannot read data');
   	Readln(PwdFile,Maj);
       if eof(PwdFile) then raise EInvalidFile.Create
       	('Invalid file. Program cannot read data');
   	Readln(PwdFile,Min);
       if eof(PwdFile) then raise EInvalidFile.Create
       	('Invalid file. Program cannot read data');
   	Readln(PwdFile,Ver);
       for r := 0 to rowcount-1 do
       begin
       	for c := 0 to colcount-1 do
           begin
           	if eof(PwdFile) then break;
               Readln(PwdFile,inn);
               if Encryption then cells[c,r] := Decr(Inn)
               else  Cells[c,r] := Inn;
           end;
       end;
       if not eof(PwdFile) then raise ETooSmallGrid.Create
       	('Grid too small. Could not load all data');
	Finally
		Closefile(PwdFile);
	end;
end;


Procedure TBKStringGrid.FileStrings;
var
	PwdFile:TextFile;
   r:LongInt;
   c:LongInt;
const
	id = 'TBKStringGrid';
   maj = '1';
   min = '0';
   ver = '0';

begin
	try

		Assignfile(PwdFile,FFIleName);
	    Rewrite(PwdFile);
   	Writeln(PwdFile,id);
      	Writeln(PwdFile,maj);
     	Writeln(PwdFile,min);
      	Writeln(PwdFile,ver);
       for r := 0 to rowcount-1 do
       begin
       	for c := 0 to colcount-1 do
           	if Encryption then writeln(PwdFile,Encr(Cells[c,r]))
               else writeln(PwdFile,Cells[c,r]);
       end;

	Finally
		Closefile(PwdFile);
	end;
end;



Procedure TBKStringGrid.ExchangeGridRows( i, j: Integer );
  Var
    k: Integer;
  Begin
  		if SortByFixedCol then
       	 For k:= 0 To ColCount-1 Do Cols[k].Exchange(i,j)
       else
       	For k:= FixedCols To ColCount-1 Do Cols[k].Exchange(i,j);

end;


procedure TBKStringGrid.QuickSort(L, R: Integer);
  var
    I, J: Integer;
    P: String;
  begin
    repeat
      I := L;
      J := R;
      P := Cells[FbyColumn, (L + R) shr 1];
      repeat
	      case CaseSensitive of
            False:
            begin
           	while CompareText(Cells[FbyColumn, I], P) < 0 do Inc(I);
	 		    while CompareText(Cells[FbyColumn, J], P) > 0 do Dec(J);
            end;
            true:
            begin
           	while CompareStr(Cells[FbyColumn, I], P) < 0 do Inc(I);
	 		    while CompareStr(Cells[FbyColumn, J], P) > 0 do Dec(J);
            end;
 	     end;    {case}
   	 if I <= J then
	     begin
 	         If I <> J Then ExchangeGridRows( I, J );
       	 Inc(I);
         	 Dec(J);
		 end;
      until I > J;
    if L < J then QuickSort(L, J);
      L := I;
    until I >= R;
end;


Procedure TBKStringGrid.InvertGrid;
   Var
     i, j: Integer;
   Begin
     i:= Fixedrows;
     j:= Rowcount-1;
     While i < j Do Begin
       ExchangeGridRows( I, J );
       Inc( i );
       Dec( j );
     End; { While }
 End;

Procedure TBKStringGrid.SortStringgrid(  byColumn: LongInt;  ascending: Boolean );

Begin

  try
		if (Editormode) and  (goAlwaysShowEditor in  options) and
       	(Assigned(FOnUserChangedCell)) then FOnUserChangedCell(self,col,row,
           		cells[col,row]);
	  if (byColumn < FixedCols) and (SortByFixedCol = false)
     		 then raise EWrongCol.Create
     		('You cannot sort by one of the fixed columns when the ' +
				'SortByFixedCol property is set to false.');
  	  FbyColumn := byColumn;
	  Screen.Cursor := crHourglass;
     Perform( WM_SETREDRAW, 0, 0 );
     QuickSort( FixedRows, Rowcount-1 );
     If not ascending Then InvertGrid
     else if BlanksDown then  SendBlanksDown;


	  case ascending of
	    	 true: if assigned(FOnsortedAsc) then FOnsortedAsc(self) ;
			 false : if assigned(FOnsortedDesc) then FOnSortedDesc(self) ;
	  end;

  finally
    Perform( WM_SETREDRAW, 1, 0 );
    Refresh;
    Screen.Cursor := crDefault;
  end;
End;

constructor TBKStringGrid.Create(AOwner:TComponent);
begin
	inherited create(AOwner);
   CaseSensitive:= False;
   FileName := 'TBKStringGrid.txt' ;
   SortByFixedCol := False;
   BlanksDown:=True;
   Encryption:= True;
	Encrypt:= TTomEncryption.Create(nil);
   if FEncryptionKey <> '' then Encrypt.Key := FEncryptionKey
   else Encrypt.Key:='nTtrdxaf';
   FCallOnAfterEdit := true;
   FGotEditText := ''; //emtpy

end; {create}

destructor TBKStringGrid.Destroy;
begin
	Encrypt.Free;
	inherited destroy;
end;


function TBKStringGrid.Encr(str:string):string;
begin
	Encrypt.Action := atEncryption;
   Encrypt.Input := str;
   Encrypt.Execute;
   Result:=Encrypt.output;
end;

function TBKStringGrid.Decr(str:string) :string;
begin
	Encrypt.Action := atDecryption;
   Encrypt.Input := str;
   Encrypt.Execute;
   Result := Encrypt.Output;
end;

function TBKStringGrid.IsStringBlank(str:string):Boolean;
var
	i:integer;
begin

	if str = '' then
   begin
   	result:=true;
       exit;
   end;
      result:= True;
   for i := 1 to Length(str)  do    if Ord(str[i]) > 32  then
	   begin
      		if Ord(str[i]) <> 127 then
           begin
		   		Result := False;
       		exit;
           end;
	   end;
end;


Function TBKStringGrid.IsCellBlank(Col:Integer;Row:Integer):Boolean;
begin
	if IsStringBlank(Cells[Col,Row]) then result := true
   else result:=false;
end;

procedure TBKStringGrid.SetEditText(ACol,ARow:Longint; const Value:String);
var
	cellstring:string;
begin
	cellstring := value;
	if (not EditorMode) and (FCallOnAfterEdit) then
   begin
       if Assigned(FOnUserChangedCell)  and (FGotEditText <> cellstring) then
       			OnUserChangedCell(Self,Acol,Arow,cellstring);
   end;
   Inherited SetEditText(ACol, ARow, cellstring);
   FCallOnAfterEdit:= True;
end;

function TBKStringGrid.SelectCell(Col,Row:Longint):Boolean;
var
	cellstring: string;
begin
	cellstring := Self.Cells[self.col,self.row];
  	if EditorMode then
   begin
   	FCallOnAfterEdit:= False;

      	if (Assigned(FOnUserChangedCell))  and
       			(FGotEditText <> cellstring )  then
			       	OnUserChangedCell(Self,self.Col,
           		self.Row, cellstring );
   end;
	result := inherited SelectCell(Col,Row);
end;

function TBKStringGrid.GetEditText(Acol:integer;Arow:Integer):string;
begin
	FGotEditText:= inherited GetEditText(Acol, Arow);
	Result := FGotEditText;
end;



procedure Register;
begin
  RegisterComponents('AddEu', [TBKStringGrid]);
end;         {register}

end.
