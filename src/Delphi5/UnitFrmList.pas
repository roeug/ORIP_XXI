unit UnitFrmList;

interface

uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
 Grids, NuclideClasses, Menus, EuLib;

type
 T_FrmList=class(TForm)
  StringGridChosenList: TStringGrid;
  procedure FormShow(Sender: TObject);
  procedure FormCreate(Sender: TObject);
  procedure FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
  procedure ItemDelClick(Sender: TObject);
  procedure FormDestroy(Sender: TObject);
  procedure StringGridChosenListDblClick(Sender: TObject);
  procedure FormResize(Sender: TObject);
 private
    { Private declarations }
 public
    { Public declarations }
  ActiveThZpA: integer;
  ThZpA_sList: TLongIntList;
  procedure InvalidateGrid(Sender: TObject);
 end;
 
var
 _FrmList: T_FrmList;
 
implementation

uses UnitNK, UnitEditNuclide;

{$R *.DFM}

procedure T_FrmList.FormShow(Sender: TObject);
begin
 if ThZpA_Slist.Count=0 then begin
  MessageDlg('The state list is empty !', mtWarning, [mbOK], 0);
  Exit;
 end;
end;

procedure T_FrmList.InvalidateGrid(Sender: TObject);
var
 I, J, ThZpA, State, InNKlistNo: integer;
 WasShown: Boolean;
 Col0, Col1: TStringList;
begin
 Col0:= TStringList.Create;
 Col1:= TStringList.Create;
 try
  if Visible then begin
   WasShown:= True;
   Hide;
  end
  else
   WasShown:= False;
  Cursor:= crHourGlass;
  with StringGridChosenList, ThZpA_Slist do begin
   RowCount:= 1;
   Col0.Clear;
   Col0.Add('State');
   Col1.Clear;
   Col1.Add('Half life');
  //out Dupljs
   for I:= ThZpA_sList.Count-1 downto 1 do
    for J:= I-1 downto 0 do
     if (ThZpA_sList[I]=ThZpA_sList[J]) then begin
      ThZpA_sList.Delete(J);
      break;
     end;
   ThZpA_sList.Order(False);
   for I:= ThZpA_sList.Count-1 downto 0 do begin
    ThZpA:= ThZpA_sList[I]div 10;
    State:= ThZpA_sList[I]mod 10;
    with _FormNK do begin
     InNKlistNo:= _FormNK.NuclideList.FindInList(ThZpA div 1000, ThZpA mod 1000);
     if (InNKlistNo>=0) then
      if State<_FormNK.NuclideList[InNKlistNo].StateList.Count then
       with _FormNK.NuclideList[InNKlistNo].StateList[State] do begin
        RowCount:= RowCount+1;
        Col0.Add(Name);
{$IFDEF RELEASE}
        if T1_2>0 then
         Col1.Add(T1_2ToStr(T1_2))
        else
         Col1.Add('');
{$ELSE}
        Col1.Add(T1_2ToStr(T1_2));
{$ENDIF}
       end
      else begin
{$IFDEF RELEASE}
       ThZpA_Slist.Delete(I);
{$ELSE}
       RowCount:= RowCount+1;
       Col0.Add(IntToStr(ThZpA_Slist[I]));
       Col1.Add('not in NK');
{$ENDIF}
      end
     else begin
{$IFDEF RELEASE}
      ThZpA_Slist.Delete(I);
{$ELSE}
      RowCount:= RowCount+1;
      Col0.Add(IntToStr(ThZpA_Slist[I]));
      Col1.Add('not in NK');
{$ENDIF}
     end
    end;
   end;
   ThZpA_sList.Order(True);
   Cols[0].Assign(Col0);
   Cols[1].Assign(Col1);
   if RowCount>1 then
    FixedRows:= 1;
  end;
  Caption:= 'The filter list ('+IntToStr(ThZpA_Slist.Count)+')';
 finally
  Cursor:= crDefault;
  Col0.Free;
  Col1.Free;
 end;
 if WasShown then begin
  Show;
 end;
end;

procedure T_FrmList.FormCreate(Sender: TObject);
begin
 ThZpA_sList:= TLongIntList.Create;
end;

procedure T_FrmList.FormKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
 if Key=vk_escape then
  Close;
end;

procedure T_FrmList.ItemDelClick(Sender: TObject);
var
 I: integer;
begin
 Hide;
 with StringGridChosenList do begin
  if ((Row-1)<ThZpA_Slist.Count) then begin
   ThZpA_Slist.Delete(Row-1);
   for I:= Row to RowCount-1 do
    Rows[I].Assign(Rows[I+1]);
   RowCount:= RowCount-1;
  end;
 end;
 InvalidateGrid(Self);
 if ThZpA_Slist.Count>0 then
  Show;
end;

procedure T_FrmList.FormDestroy(Sender: TObject);
begin
 ThZpA_sList.Free;
end;

procedure T_FrmList.StringGridChosenListDblClick(Sender: TObject);
var
 ThZpA, State, InNKlistNo: integer;
begin
 with StringGridChosenList do begin
  ThZpA:= ThZpA_sList[Row-1]div 10;
  State:= ThZpA_sList[Row-1]mod 10;
  InNKlistNo:= _FormNK.NuclideList.FindInList(ThZpA div 1000, ThZpA mod 1000);
 end;
 with _FormNK do
  if ((Visible)and(InNKlistNo>=0)) then begin
   if State<NuclideList[InNKlistNo].StateList.Count then begin
    ActiveThZpA:= ThZpA;
    GoToThZpACenter(ActiveThZpA);
    StringGridNKDblClick(Self);
    with _FormEditNuclide do
     if Visible then
      case State of
       0: if SpeedButtonGstate.Visible then begin
           SpeedButtonGstate.Down:= True;
           SpeedButtonGstateClick( Self);
          end;
       1: if SpeedButtonM1state.Visible then begin
           SpeedButtonM1state.Down:= True;
           SpeedButtonM1stateClick( Self);
          end;
       2: if SpeedButtonM2state.Visible then begin
           SpeedButtonM2state.Down:= True;
           SpeedButtonM2stateClick( Self);
          end;
      end;
   end
   else
    MessageDlg('The state not found in NUKLIDKARTE !', mtWarning, [mbOK], 0);
  end;
end;

procedure T_FrmList.FormResize(Sender: TObject);
begin
 with StringGridChosenList do begin
  ColWidths[0]:= ((ClientWidth)div 7)*3-ColCount;
  ColWidths[1]:= ClientWidth-ColWidths[0]-ColCount;
 end;
end;


end.

