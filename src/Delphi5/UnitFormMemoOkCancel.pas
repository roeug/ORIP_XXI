unit UnitFormMemoOkCancel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  T_FormMemoOKCancel = class(TForm)
    GroupBox1: TGroupBox;
    MemoInChain: TMemo;
    GroupBox2: TGroupBox;
    Memo: TMemo;
    PanelControls: TPanel;
    BitBtnOK: TBitBtn;
    BitBtnCancel: TBitBtn;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  _FormMemoOKCancel: T_FormMemoOKCancel;

implementation

{$R *.DFM}

procedure T_FormMemoOKCancel.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (Key=VK_ESCAPE) then
  ModalResult:= mrCancel;
end;

end.
