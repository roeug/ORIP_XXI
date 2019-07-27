unit UnitGoToDialog; 

interface

uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
 StdCtrls, Spin;

type
 T_FormGoToDialog=class(TForm)
  ButtonGoToNuclide: TButton;
  ButtonCancel: TButton;
  GroupBoxZnum: TGroupBox;
  EditZnum: TComboBox;
  ButtonGoToZnum: TButton;
  GroupBoxGoToAmass: TGroupBox;
  EditAmass: TSpinEdit;
  ButtonGoToAmass: TButton;
  procedure FormCreate(Sender: TObject);
  procedure FormShow(Sender: TObject);
  procedure FormKeyDown(Sender: TObject;var Key: Word;
   Shift: TShiftState);
  procedure EditZnumKeyUp(Sender: TObject;var Key: Word;
   Shift: TShiftState);
  procedure EditAmassKeyUp(Sender: TObject;var Key: Word;
   Shift: TShiftState);
 private
    { Private declarations }
 public
    { Public declarations }
  FirstShow: Boolean;
 end;
 
var
 _FormGoToDialog: T_FormGoToDialog;
 
implementation

{$R *.DFM}

procedure T_FormGoToDialog.FormCreate(Sender: TObject);
begin
 FirstShow:= True;
end;

procedure T_FormGoToDialog.FormShow(Sender: TObject);
begin
 FirstShow:= False;
end;

procedure T_FormGoToDialog.FormKeyDown(Sender: TObject;var Key: Word;
 Shift: TShiftState);
begin
 if Key=vk_escape then
  ModalResult:= mrCancel;
end;

procedure T_FormGoToDialog.EditZnumKeyUp(Sender: TObject;var Key: Word;
 Shift: TShiftState);
begin
 if Key=vk_return
  then ModalResult:= mrOK;
end;

procedure T_FormGoToDialog.EditAmassKeyUp(Sender: TObject;var Key: Word;
 Shift: TShiftState);
begin
 if Key=vk_return
  then ModalResult:= mrYes;
end;

end.

