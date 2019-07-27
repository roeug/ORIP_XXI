unit UnitDecay;

interface

uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
 Dialogs, NuclideClasses, EuLib, StdCtrls, Mask, ToolEdit,
 CurrEdit, RXDBCtrl, Buttons;

type
 T_FormDecay = class(TForm)
  LabelT1_2: TLabel;
  Label1: TLabel;
  EditAnswer: TEdit;
  EditT1_2RO: TLabel;
  TimeUnitComboBox: TComboBox;
  ComboBoxTimeUnitRO: TComboBox;
  EditInterval: TEdit;
  EditMass_g: TEdit;
  EditActivity_Ci: TEdit;
  Label2: TLabel;
  Label3: TLabel;
  SpeedButtonMassToActivity: TSpeedButton;
  SpeedButtonActivityToMass: TSpeedButton;
  procedure FormShow(Sender: TObject);
  procedure ComboBoxTimeUnitROChange(Sender: TObject);
  procedure TimeUnitComboBoxChange(Sender: TObject);
  procedure EditAnswerClick(Sender: TObject);
  procedure FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
  procedure EditIntervalExit(Sender: TObject);
  procedure EditIntervalKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
  procedure SpeedButtonMassToActivityClick(Sender: TObject);
  procedure SpeedButtonActivityToMassClick(Sender: TObject);
  procedure EditMass_gKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
  procedure EditActivity_CiKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
  procedure EditMass_gKeyPress(Sender: TObject; var Key: Char);
  procedure EditActivity_CiKeyPress(Sender: TObject; var Key: Char);
  procedure EditIntervalKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
 private
    { Private declarations }
  fFirstShow: Boolean;
 public
    { Public declarations }
  StateT1_2: Float;
  StateName: string[8];
  StateMass_g: Float;
  StateLambda: Float;
  property FirstShow: Boolean read fFirstShow;
  procedure InvalidateForm;
 end;
 
var
 _FormDecay: T_FormDecay;
 
implementation

{$R *.DFM}

function TextFormat(const aFloat: Float): string;
begin
 Result:= Trim(Format('%-7.5g', [aFloat]));
end;

procedure T_FormDecay.InvalidateForm;
begin
 Caption:= 'Decay of ' + StateName;
 EditT1_2RO.Caption:= TextFormat(StateT1_2);
 ComboBoxTimeUnitRO.ItemIndex:= 0;
 EditInterval.Text:= '0';
 EditAnswer.Text:= '100%';
 TimeUnitComboBox.ItemIndex:= 0;
 EditMass_g.Text:= '1.0';
 EditActivity_Ci.Text:= TextFormat(1.0 / StateMass_g * N_Av * StateLambda / BqPerCi);
end;

procedure T_FormDecay.FormShow(Sender: TObject);
begin
 if fFirstShow then
 try
  fFirstShow:= False;
 except
 end;
 InvalidateForm;
end;

procedure T_FormDecay.ComboBoxTimeUnitROChange(Sender: TObject);
begin
{$IFDEF RELEASE}
 if (StateT1_2 > 0) then
{$ENDIF}
  if (LowerCase(Copy(Trim(ComboBoxTimeUnitRO.Items[ComboBoxTimeUnitRO.ItemIndex]), 1, 2)) = 'se') then
   EditT1_2RO.Caption:= TextFormat(StateT1_2 / ti_sec)
  else if (LowerCase(Copy(Trim(ComboBoxTimeUnitRO.Items[ComboBoxTimeUnitRO.ItemIndex]), 1, 2)) = 'ps') then
   EditT1_2RO.Caption:= TextFormat(StateT1_2 / ti_ps)
  else if (LowerCase(Copy(Trim(ComboBoxTimeUnitRO.Items[ComboBoxTimeUnitRO.ItemIndex]), 1, 2)) = 'ns') then
   EditT1_2RO.Caption:= TextFormat(StateT1_2 / ti_ns)
  else if (LowerCase(Copy(Trim(ComboBoxTimeUnitRO.Items[ComboBoxTimeUnitRO.ItemIndex]), 1, 2)) = 'mk') then
   EditT1_2RO.Caption:= TextFormat(StateT1_2 / ti_mks)
  else if (LowerCase(Copy(Trim(ComboBoxTimeUnitRO.Items[ComboBoxTimeUnitRO.ItemIndex]), 1, 2)) = 'ms') then
   EditT1_2RO.Caption:= TextFormat(StateT1_2 / ti_ms)
  else if (LowerCase(Copy(Trim(ComboBoxTimeUnitRO.Items[ComboBoxTimeUnitRO.ItemIndex]), 1, 2)) = 'mi') then
   EditT1_2RO.Caption:= TextFormat(StateT1_2 / ti_min)
  else if (LowerCase(Copy(Trim(ComboBoxTimeUnitRO.Items[ComboBoxTimeUnitRO.ItemIndex]), 1, 2)) = 'ho') then
   EditT1_2RO.Caption:= TextFormat(StateT1_2 / ti_hou)
  else if (LowerCase(Copy(Trim(ComboBoxTimeUnitRO.Items[ComboBoxTimeUnitRO.ItemIndex]), 1, 2)) = 'da') then
   EditT1_2RO.Caption:= TextFormat(StateT1_2 / ti_day)
  else if (LowerCase(Copy(Trim(ComboBoxTimeUnitRO.Items[ComboBoxTimeUnitRO.ItemIndex]), 1, 2)) = 'ye') then
   EditT1_2RO.Caption:= TextFormat(StateT1_2 / ti_yea)
  else if (LowerCase(Copy(Trim(ComboBoxTimeUnitRO.Items[ComboBoxTimeUnitRO.ItemIndex]), 1, 2)) = 'la') then
   if StateT1_2 > 0 then
    EditT1_2RO.Caption:= TextFormat(Ln(2) / StateT1_2)
   else
    EditT1_2RO.Caption:= ' ';
end;

procedure T_FormDecay.TimeUnitComboBoxChange(Sender: TObject);
var
 aFloat: Float;
begin
 if ValEuSilent(EditInterval.Text, aFloat) then
 begin
  if ValT1_2(EditInterval.Text, Copy(Trim(TimeUnitComboBox.Items[TimeUnitComboBox.ItemIndex]), 1, 2), aFloat) then
  begin
   aFloat:= exp(-aFloat / StateT1_2 * Ln(2)) * 100;
   EditAnswer.Text:= TextFormat(aFloat) + '%';
  end
  else
  begin
   MessageDlg('Cannot parse time interval.' + #13 + #10 + ' Re-input !', mtWarning, [mbOK], 0);
   EditInterval.SetFocus;
//   MessageBeep(0);
  end;
 end
 else
 begin
  MessageDlg('Cannot convert to float "' + EditInterval.Text + '"' + #13 + #10 + ' Re-input !', mtWarning, [mbOK], 0);
  EditInterval.SetFocus;
//   MessageBeep(0);
 end;
end;

procedure T_FormDecay.EditAnswerClick(Sender: TObject);
begin
 TimeUnitComboBoxChange(Self);
end;

procedure T_FormDecay.FormKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
 if Key = vk_escape then
  Close;
end;

procedure T_FormDecay.EditIntervalExit(Sender: TObject);
begin
 TimeUnitComboBoxChange(Self);
end;

procedure T_FormDecay.EditIntervalKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
 if key = vk_return then
  TimeUnitComboBoxChange(Self);
end;

procedure T_FormDecay.SpeedButtonMassToActivityClick(Sender: TObject);
var
 aFloat: Float;
begin
 if ValEuSilent(EditMass_g.Text, aFloat) then
 begin
  aFloat:= aFloat / StateMass_g * N_Av * StateLambda / BqPerCi;
  EditActivity_Ci.Text:= TextFormat(aFloat);
 end
 else
 begin
  MessageDlg('Cannot convert Mass.' + #13 + #10 + ' Re-input !', mtWarning, [mbOK], 0);
  EditMass_g.SetFocus;
 end;
end;

procedure T_FormDecay.SpeedButtonActivityToMassClick(Sender: TObject);
var
 aFloat: Float;
begin
 if ValEuSilent(EditActivity_Ci.Text, aFloat) then
 begin
  aFloat:= aFloat * StateMass_g * BqPerCi / N_Av / StateLambda;
  EditMass_g.Text:= TextFormat(aFloat);
 end
 else
 begin
  MessageDlg('Cannot convert Activity.' + #13 + #10 + ' Re-input !', mtWarning, [mbOK], 0);
  EditMass_g.SetFocus;
 end;
end;

procedure T_FormDecay.EditMass_gKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
 if key = vk_return then
  SpeedButtonMassToActivityClick(Self);
end;

procedure T_FormDecay.EditActivity_CiKeyDown(Sender: TObject;
 var Key: Word; Shift: TShiftState);
begin
 if key = vk_return then
  SpeedButtonActivityToMassClick(Self)
end;

procedure T_FormDecay.EditMass_gKeyPress(Sender: TObject; var Key: Char);
begin
 if not (Key in [#8, '0'..'9','-','+', '.', ',', 'e', 'E', 'å', 'Å']) then
  Key:= #0;
end;

procedure T_FormDecay.EditActivity_CiKeyPress(Sender: TObject;
 var Key: Char);
begin
 if not (Key in [#8, '0'..'9','-','+', '.', ',', 'e', 'E', 'å', 'Å']) then
  Key:= #0;
end;

procedure T_FormDecay.EditIntervalKeyPress(Sender: TObject; var Key: Char);
begin
 if not (Key in [#8, '0'..'9', '.', ',', 'e', 'E', 'å', 'Å']) then
  Key:= #0;
end;

procedure T_FormDecay.FormCreate(Sender: TObject);
begin
 fFirstShow:= True;
end;

end.

