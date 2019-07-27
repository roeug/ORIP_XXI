unit UnitAddState;

interface

uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
 ChainClasses, StdCtrls;

type
 T_FormAddState=class(TForm)
  GroupBoxRemoveState: TGroupBox;
  ListBoxStates: TListBox;
  GroupBoxAddState: TGroupBox;
  EditStateName: TComboBox;
  ButtonAdd: TButton;
  ButtonRemove: TButton;
  procedure EditStateNameDropDown(Sender: TObject);
  procedure FormCreate(Sender: TObject);
  procedure ListBoxStatesEnter(Sender: TObject);
  procedure EditStateNameExit(Sender: TObject);
  procedure ButtonRemoveClick(Sender: TObject);
  procedure FormKeyDown(Sender: TObject;var Key: Word;
   Shift: TShiftState);
  procedure ButtonAddClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
 private
    { Private declarations }
  fChain: TChain;
  procedure SetChain(aChain: TChain);
 public
    { Public declarations }
  StateDeleted, StateAdded: string;
  DropDownAllItems: TStringList;
  property Chain: TChain write SetChain;
 end;

var
 _FormAddState: T_FormAddState;

implementation

{$R *.DFM}

procedure T_FormAddState.SetChain(aChain: TChain);
var
 LocalList: TStringList;
 I, J: integer;
 InChain: Boolean;
begin
 if (aChain<>nil) then begin
  fChain:= aChain;
  LocalList:= TStringList.Create;
  for I:= 0 to DropDownAllItems.Count-1 do begin
   InChain:= False;
   for J:= 0 to aChain.States.Count-1 do
    if (UpperCase(Trim(DropDownAllItems[I]))=UpperCase(Trim(aChain.States[J].Name))) then begin
     InChain:= True;
     break;
    end;
   if not(InChain) then
    LocalList.Add(DropDownAllItems[I]);
  end;
  EditStateName.Items.Assign(LocalList);
  ListBoxStates.Items.Clear;
  for J:= 0 to aChain.States.Count-1 do
   ListBoxStates.Items.Add(aChain.States[J].Name);
  LocalList.Free;
 end;
end;

procedure T_FormAddState.EditStateNameDropDown(Sender: TObject);
begin
//
end;

procedure T_FormAddState.FormCreate(Sender: TObject);
begin
 fChain:= nil;
 DropDownAllItems:= TStringList.Create;
end;

procedure T_FormAddState.ListBoxStatesEnter(Sender: TObject);
begin
 if ListBoxStates.Items.Count>0 then
  ButtonRemove.Enabled:= True
 else
  ButtonRemove.Enabled:= False;
end;

procedure T_FormAddState.EditStateNameExit(Sender: TObject);
begin
 if Pos('-', (EditStateName.Text))>0 then
  ButtonAdd.Enabled:= True
 else
  ButtonAdd.Enabled:= False;
end;

procedure T_FormAddState.ButtonRemoveClick(Sender: TObject);
begin
 StateDeleted:= Trim(ListBoxStates.Items[ListBoxStates.ItemIndex]);
 ModalResult:= mrAbort;
end;

procedure T_FormAddState.FormKeyDown(Sender: TObject;var Key: Word;
 Shift: TShiftState);
begin
 if Key=27 then
  ModalResult:= mrCancel;
end;

procedure T_FormAddState.ButtonAddClick(Sender: TObject);
begin
 StateAdded:= Trim(EditStateName.Text);
 ModalResult:= mrOK;
end;

procedure T_FormAddState.FormShow(Sender: TObject);
begin
 StateDeleted:= '';
 StateAdded:= '';
end;

end.

