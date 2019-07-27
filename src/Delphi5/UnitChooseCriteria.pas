unit UnitChooseCriteria;

interface

uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
 StdCtrls, Buttons, ExtCtrls, Spin;

type
 T_FormChooseCriteria=class(TForm)
  GroupBoxZnum: TGroupBox;
  CheckBoxZnum: TCheckBox;
  Label1: TLabel;
  Label2: TLabel;
  GroupBoxAndOr: TGroupBox;
  EditZnum1: TComboBox;
  EditZnum2: TComboBox;
    GroupBoxAmass: TGroupBox;
  Label3: TLabel;
  Label4: TLabel;
  CheckBoxAmass: TCheckBox;
  SpeedButtonChoose: TSpeedButton;
    GroupBoxHalfLife: TGroupBox;
  Label5: TLabel;
  Label6: TLabel;
  CheckBoxT1_2: TCheckBox;
  EditT1_2_1: TEdit;
  EditT1_2_2: TEdit;
  ComboBoxTimeUnit1: TComboBox;
  ComboBoxTimeUnit2: TComboBox;
  EditAmass1: TSpinEdit;
  EditAmass2: TSpinEdit;
  GroupBoxDecayType: TGroupBox;
  CheckBoxDecayType: TCheckBox;
  CheckBoxStable: TCheckBox;
  CheckBoxAlpha: TCheckBox;
  CheckBoxBeta: TCheckBox;
  CheckBoxEC: TCheckBox;
  CheckBoxSF: TCheckBox;
    GroupBoxGammaLine: TGroupBox;
  Label19: TLabel;
  Label20: TLabel;
  CheckBoxGammaLine: TCheckBox;
  EditGammaLine1: TEdit;
  EditGammaLine2: TEdit;
    GroupBoxAlphaLine: TGroupBox;
  Label21: TLabel;
  Label22: TLabel;
  CheckBoxAlphaLine: TCheckBox;
  EditAlphaLine1: TEdit;
  EditAlphaLine2: TEdit;
  GroupBoxNoGamma: TGroupBox;
  Label23: TLabel;
  Label24: TLabel;
  CheckBoxBetaLine: TCheckBox;
  EditBetaLine1: TEdit;
  EditBetaLine2: TEdit;
  Label25: TLabel;
  CheckBoxG: TCheckBox;
  CheckBoxM1: TCheckBox;
  CheckBoxM2: TCheckBox;
  Memo1: TMemo;
  CheckBoxNoGamma: TCheckBox;
  CheckBoxIT: TCheckBox;
  CheckBoxClearList: TCheckBox;
  SpeedButton1: TSpeedButton;
  CheckBoxAlphaLineNull: TCheckBox;
  CheckBoxBetaLineNull: TCheckBox;
  CheckBoxGammaLineNull: TCheckBox;
  Label26: TLabel;
  Label27: TLabel;
  EditAlphaProb: TEdit;
  Label28: TLabel;
  EditBetaProb: TEdit;
  Label29: TLabel;
  EditGammaProb: TEdit;
    GroupBoxSigma: TGroupBox;
    GroupBoxSigmaCapture: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    CheckBoxSigmaC: TCheckBox;
    EditSigmaC1: TEdit;
    EditSigmaC2: TEdit;
    CheckBoxSigmaCnull: TCheckBox;
    GroupBoxSigmaFission: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    CheckBoxSigmaF: TCheckBox;
    EditSigmaF1: TEdit;
    EditSigmaF2: TEdit;
    CheckBoxSigmaFnull: TCheckBox;
    GroupBoxSigmaNP: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    CheckBoxSigmaNP: TCheckBox;
    EditSigmaNP1: TEdit;
    EditSigmaNP2: TEdit;
    CheckBoxSigmaNPnull: TCheckBox;
    GroupBox6: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    CheckBoxSigmaNA: TCheckBox;
    EditSigmaNA1: TEdit;
    EditSigmaNA2: TEdit;
    CheckBoxSigmaNAnull: TCheckBox;
    GroupBoxSigmaN2N: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    CheckBoxSigmaN2N: TCheckBox;
    EditSigmaN2N1: TEdit;
    EditSigmaN2N2: TEdit;
    CheckBoxSigmaN2Nnull: TCheckBox;
    GroupBoxSigmaNN: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    CheckBoxSigmaNN: TCheckBox;
    EditSigmaNN1: TEdit;
    EditSigmaNN2: TEdit;
    CheckBoxSigmaNNnull: TCheckBox;
    RadioButtonAND: TRadioButton;
    RadioButtonOR: TRadioButton;
  procedure FormCreate(Sender: TObject);
  procedure FormShow(Sender: TObject);
  procedure FormKeyDown(Sender: TObject;var Key: Word;
   Shift: TShiftState);
  procedure SpeedButtonChooseClick(Sender: TObject);
  procedure SpeedButton1Click(Sender: TObject);
  procedure EditZnum1Change(Sender: TObject);
  procedure EditAmass1Change(Sender: TObject);
  procedure EditT1_2_1Change(Sender: TObject);
  procedure CheckBoxStableClick(Sender: TObject);
  procedure EditSigmaC1Change(Sender: TObject);
  procedure EditSigmaF1Change(Sender: TObject);
  procedure EditSigmaNP1Change(Sender: TObject);
  procedure EditSigmaNA1Change(Sender: TObject);
  procedure EditSigmaN2N1Change(Sender: TObject);
  procedure EditSigmaNN1Change(Sender: TObject);
  procedure EditAlphaLine1Change(Sender: TObject);
  procedure EditBetaLine1Change(Sender: TObject);
  procedure EditGammaLine1Change(Sender: TObject);
  procedure CheckBoxClick(Sender: TObject);
  procedure SpeedButtonChooseMouseDown(Sender: TObject;
   Button: TMouseButton;Shift: TShiftState;X, Y: Integer);
 private
    { Private declarations }
 public
    { Public declarations }
  FirstShow: Boolean;
  aFilterStr: string;
  function StrToZnum(const InStr: string): integer;
 end;
 
var
 _FormChooseCriteria: T_FormChooseCriteria;
 SpecialQuery: Boolean;
 InitHeight: Longint;
 retVal: Longint;
 
implementation

{$R *.DFM}
uses
 Math, NuclideClasses, EuLib, UnitDM_DAO, UnitDM_OOB, UnitSplash, UnitFrmList,
 UnitNK, DM_OOD;

procedure T_FormChooseCriteria.FormCreate(Sender: TObject);
begin
 FirstShow:= True;
 ComboBoxTimeUnit1.ItemIndex:= 0;
 ComboBoxTimeUnit2.ItemIndex:= 0;
 InitHeight:= Height;
 retVal:= 0;
 SpecialQuery:= false;
end;

procedure T_FormChooseCriteria.FormShow(Sender: TObject);
begin
 FirstShow:= False;
end;

function T_FormChooseCriteria.StrToZnum(const InStr: string): integer;
var
 I: integer;
 aStr: string;
begin
 I:= Pos('(', InStr);
 if I>1 then
  aStr:= Copy(InStr, 1, I-1)
 else
  aStr:= InStr;
 Result:= StrToInt(aStr);
end;

procedure T_FormChooseCriteria.FormKeyDown(Sender: TObject;var Key: Word;
 Shift: TShiftState);
begin
 if Key=vk_escape then
  close;
end;

procedure T_FormChooseCriteria.SpeedButtonChooseClick(Sender: TObject);
 function ComboBoxZnumToInt(ComboBoxZnum: TComboBox): integer;
 var
  I: Integer;
  aStr: string;
 begin
  Result:= -1;
  aStr:= ComboBoxZnum.Items[ComboBoxZnum.ItemIndex];
  I:= Pos('(', aStr);
  if I>0 then
   Result:= StrToInt(Copy(aStr, 1, I-1));
 end;
 function FloatToStrE(const aFloat: Float): string;
 var
  I: integer;
 begin
  Result:= FloatToStr(aFloat);
  for I:= 1 to Length(Result) do
   if (Result[I]=',') then
    Result[I]:= '.';
 end;

var
 I, J, K: integer;
 ConcatStr, WhereStr, fSectionStr, BracketStr, HavingStr: string;
 Int1, Int2, IntMin, IntMax: integer;
 Float1, Float2, FloatMin, FloatMax, Float3, FloatProb: Float;
 ListManFunction: TListManFunction;
 List1, ListVar, ListAnswer: TLongIntList;
 TheDecayTypes: TDecayTypes;
begin
 if not((CheckBoxG.Checked)or(CheckBoxM1.Checked)or(CheckBoxM2.Checked)) then begin
  MessageDlg('You are to check at least one filter criteria !', mtWarning, [mbOK], 0);
  Self.Enabled:= True;
  Exit;
 end;
 if not((CheckBoxZnum.Checked)or(CheckBoxAmass.Checked)or(CheckBoxDecayType.Checked)or
  (CheckBoxT1_2.Checked)or
  (CheckBoxSigmaC.Checked)or(CheckBoxSigmaF.Checked)or(CheckBoxSigmaNP.Checked)or
  (CheckBoxSigmaNA.Checked)or(CheckBoxSigmaN2N.Checked)or(CheckBoxSigmaNN.Checked)or
  (CheckBoxAlphaLine.Checked)or(CheckBoxBetaLine.Checked)or(CheckBoxGammaLine.Checked)
  ) then begin
  MessageDlg('You are to check at least one filter criteria !', mtWarning, [mbOK], 0);
  Self.Enabled:= True;
  Exit;
 end;
 if (_FormNK.TheDataModule is T_DataModuleOOB) then begin
  Cursor:= crHourGlass;
  Caption:= 'The list forming....';
  List1:= TLongIntList.Create;
  ListVar:= TLongIntList.Create;
  ListAnswer:= TLongIntList.Create;
  try
   if RadioButtonAND.Checked then begin
    ListManFunction:= ListIntersect;
    ListAnswer.Clear;
    with _FormNK.NuclideList do
     for I:= 0 to _FormNK.NuclideList.Count-1 do
      for J:= 0 to _FormNK.NuclideList[I].StateList.Count-1 do
       ListAnswer.Add(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
        _FormNK.NuclideList[I].StateList[J].State);
   end
   else begin
    ListManFunction:= ListUnion;
   end;
   if CheckBoxZnum.Checked then begin
    List1.Clear;
    Int1:= 0;
    Int2:= 120;
    if EditZnum1.Text<>'' then
     Int1:= ComboBoxZnumToInt(EditZnum1);
    if EditZnum2.Text<>'' then
     Int2:= ComboBoxZnumToInt(EditZnum2);
    IntMin:= Min(Int1, Int2);
    IntMax:= Max(Int1, Int2);
    with _FormNK.NuclideList do
     for I:= 0 to _FormNK.NuclideList.Count-1 do
      for J:= 0 to _FormNK.NuclideList[I].StateList.Count-1 do
       with _FormNK.NuclideList[I].StateList[J] do
        if ((_FormNK.NuclideList[I].Znum<=IntMax)and(_FormNK.NuclideList[I].Znum>=IntMin)) then
         List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
          _FormNK.NuclideList[I].StateList[J].State);
    if not(ListManFunction(List1, ListAnswer, ListVar)) then begin
     MessageDlg('Not ListMan in Znum block !!!', mtInformation, [mbOK], 0);
     exit;
    end
    else
     ListAnswer.Assign(ListVar);
   end;
   if CheckBoxAmass.Checked then begin
    List1.Clear;
    Int1:= 0;
    Int2:= 300;
    if EditAmass1.Text<>'' then
     Int1:= EditAmass1.Value;
    if EditAmass2.Text<>'' then
     Int2:= EditAmass2.Value;
    IntMin:= Min(Int1, Int2);
    IntMax:= Max(Int1, Int2);
    with _FormNK.NuclideList do
     for I:= 0 to _FormNK.NuclideList.Count-1 do
      for J:= 0 to _FormNK.NuclideList[I].StateList.Count-1 do
       with _FormNK.NuclideList[I].StateList[J] do
        if ((_FormNK.NuclideList[I].Amass<=IntMax)and(_FormNK.NuclideList[I].Amass>=IntMin)) then
         List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
          _FormNK.NuclideList[I].StateList[J].State);
    if not(ListManFunction(List1, ListAnswer, ListVar)) then begin
     MessageDlg('Not ListMan in Amass block !!!', mtInformation, [mbOK], 0);
     exit;
    end
    else
     ListAnswer.Assign(ListVar);
   end;
   if CheckBoxT1_2.Checked then begin
    List1.Clear;
    Float1:= 0;
    Float2:= 1E100;
    if ((Trim(EditT1_2_1.Text)='')and(Trim(EditT1_2_2.Text)='')) then begin
     MessageDlg('Can not handle half life filter !', mtWarning, [mbOK], 0);
     Self.Enabled:= True;
     Exit;
    end;
    if (Trim(EditT1_2_1.Text)='') then
     Float1:= 0.0
    else
     if not(ValT1_2(EditT1_2_1.Text, Copy(Trim(ComboBoxTimeUnit1.Items[ComboBoxTimeUnit1.ItemIndex]), 1, 2), Float1)) then begin
      MessageDlg('Can not handle half life filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    if (Trim(EditT1_2_2.Text)='') then
     Float2:= 1E100
    else
     if not(ValT1_2(EditT1_2_2.Text, Copy(Trim(ComboBoxTimeUnit2.Items[ComboBoxTimeUnit2.ItemIndex]), 1, 2), Float2)) then begin
      MessageDlg('Can not handle half life filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    FloatMin:= Min(Float1, Float2);
    FloatMax:= Max(Float1, Float2);
    with _FormNK.NuclideList do
     for I:= 0 to _FormNK.NuclideList.Count-1 do
      for J:= 0 to _FormNK.NuclideList[I].StateList.Count-1 do
       with _FormNK.NuclideList[I].StateList[J] do
        if ((_FormNK.NuclideList[I].StateList[J].T1_2<=FloatMax)and(_FormNK.NuclideList[I].StateList[J].T1_2>=FloatMin)
         and(not(_FormNK.NuclideList[I].StateList[J].IsStable))) then
         List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
          _FormNK.NuclideList[I].StateList[J].State);
    if not(ListManFunction(List1, ListAnswer, ListVar)) then begin
     MessageDlg('Not ListMan in T1_2 block !!!', mtInformation, [mbOK], 0);
     exit;
    end
    else
     ListAnswer.Assign(ListVar);
   end;
   if CheckBoxDecayType.Checked then begin
    List1.Clear;
    BracketStr:= BracketStr+'(';
    if not((CheckBoxStable.Checked)or(CheckBoxAlpha.Checked)or(CheckBoxBeta.Checked)or
     (CheckBoxEC.Checked)or(CheckBoxSF.Checked)or(CheckBoxIT.Checked)) then begin
     MessageDlg('Can not handle half decay type filter !', mtWarning, [mbOK], 0);
     Self.Enabled:= True;
     Exit;
    end;
    TheDecayTypes:= [];
    if (CheckBoxAlpha.Checked) then
     TheDecayTypes:= TheDecayTypes+ [dtA];
    if (CheckBoxBeta.Checked) then
     TheDecayTypes:= TheDecayTypes+ [dtBM];
    if (CheckBoxEC.Checked) then
     TheDecayTypes:= TheDecayTypes+ [dtEC];
    if (CheckBoxIT.Checked) then
     TheDecayTypes:= TheDecayTypes+ [dtIT];
    if (CheckBoxSF.Checked) then
     TheDecayTypes:= TheDecayTypes+ [dtSF];
    if (CheckBoxStable.Checked) then begin
     with _FormNK.NuclideList do
      for I:= 0 to _FormNK.NuclideList.Count-1 do
       for J:= 0 to _FormNK.NuclideList[I].StateList.Count-1 do
        with _FormNK.NuclideList[I].StateList[J] do begin
         if (_FormNK.NuclideList[I].StateList[J].IsStable) then begin
          List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
           _FormNK.NuclideList[I].StateList[J].State);
          continue;
         end;
         for K:= 0 to _FormNK.NuclideList[I].StateList[J].Decays.Count-1 do
          if (_FormNK.NuclideList[I].StateList[J].Decays[K].DecayType in TheDecayTypes) then begin
           List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
            _FormNK.NuclideList[I].StateList[J].State);
           break;
          end;
        end;
    end
    else begin
     with _FormNK.NuclideList do
      for I:= 0 to _FormNK.NuclideList.Count-1 do
       for J:= 0 to _FormNK.NuclideList[I].StateList.Count-1 do
        with _FormNK.NuclideList[I].StateList[J] do
         for K:= 0 to _FormNK.NuclideList[I].StateList[J].Decays.Count-1 do
          if (_FormNK.NuclideList[I].StateList[J].Decays[K].DecayType in TheDecayTypes) then begin
           List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
            _FormNK.NuclideList[I].StateList[J].State);
           break;
          end;
    end;
    if not(ListManFunction(List1, ListAnswer, ListVar)) then begin
     MessageDlg('Not ListMan in Decay block !!!', mtInformation, [mbOK], 0);
     exit;
    end
    else
     ListAnswer.Assign(ListVar);
   end;
   if CheckBoxSigmaC.Checked then begin
    Float1:= 0;
    Float2:= 1E100;
    if ((Trim(EditSigmaC1.Text)='')and(Trim(EditSigmaC2.Text)='')) then begin
     MessageDlg('Can not handle capture cross section filter !', mtWarning, [mbOK], 0);
     Self.Enabled:= True;
     Exit;
    end;
    if (Trim(EditSigmaC1.Text)='') then
     Float1:= 0.0
    else
     if not(ValEuSilent(EditSigmaC1.Text, Float1)) then begin
      MessageDlg('Can not handle capture cross section filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    if (Trim(EditSigmaC2.Text)='') then
     Float2:= 1E100
    else
     if not(ValEuSilent(EditSigmaC2.Text, Float2)) then begin
      MessageDlg('Can not handle capture cross section filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    FloatMin:= Min(Float1, Float2);
    FloatMax:= Max(Float1, Float2);
    List1.Clear;
    with _FormNK.NuclideList do
     for I:= 0 to _FormNK.NuclideList.Count-1 do
      for J:= 0 to _FormNK.NuclideList[I].StateList.Count-1 do
       with _FormNK.NuclideList[I].StateList[J] do
        if ((_FormNK.NuclideList[I].StateList[J].TotalSigmaC<=FloatMax)and(_FormNK.NuclideList[I].StateList[J].TotalSigmaC>=FloatMin)) then
         List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
          _FormNK.NuclideList[I].StateList[J].State);
    if not(ListManFunction(List1, ListAnswer, ListVar)) then begin
     MessageDlg('Not ListMan in SigmaC block !!!', mtInformation, [mbOK], 0);
     exit;
    end
    else
     ListAnswer.Assign(ListVar);
   end;
   if CheckBoxSigmaF.Checked then begin
    Float1:= 0;
    Float2:= 1E100;
    if ((Trim(EditSigmaF1.Text)='')and(Trim(EditSigmaF2.Text)='')) then begin
     MessageDlg('Can not handle fission cross section filter !', mtWarning, [mbOK], 0);
     Self.Enabled:= True;
     Exit;
    end;
    if (Trim(EditSigmaF1.Text)='') then
     Float1:= 0.0
    else
     if not(ValEuSilent(EditSigmaF1.Text, Float1)) then begin
      MessageDlg('Can not handle fission cross section filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    if (Trim(EditSigmaF2.Text)='') then
     Float2:= 1E100
    else
     if not(ValEuSilent(EditSigmaF2.Text, Float2)) then begin
      MessageDlg('Can not handle fission cross section filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    FloatMin:= Min(Float1, Float2);
    FloatMax:= Max(Float1, Float2);
    List1.Clear;
    with _FormNK.NuclideList do
     for I:= 0 to _FormNK.NuclideList.Count-1 do
      for J:= 0 to _FormNK.NuclideList[I].StateList.Count-1 do
       with _FormNK.NuclideList[I].StateList[J] do
        if ((_FormNK.NuclideList[I].StateList[J].SigmaF<=FloatMax)and(_FormNK.NuclideList[I].StateList[J].SigmaF>=FloatMin)) then
         List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
          _FormNK.NuclideList[I].StateList[J].State);
    if not(ListManFunction(List1, ListAnswer, ListVar)) then begin
     MessageDlg('Not ListMan in SigmaF block !!!', mtInformation, [mbOK], 0);
     exit;
    end
    else
     ListAnswer.Assign(ListVar);
   end;
   if CheckBoxSigmaNP.Checked then begin
    Float1:= 0;
    Float2:= 1E100;
    if ((Trim(EditSigmaNP1.Text)='')and(Trim(EditSigmaNP2.Text)='')) then begin
     MessageDlg('Can not handle (n,p) cross section filter !', mtWarning, [mbOK], 0);
     Self.Enabled:= True;
     Exit;
    end;
    if (Trim(EditSigmaNP1.Text)='') then
     Float1:= 0.0
    else
     if not(ValEuSilent(EditSigmaNP1.Text, Float1)) then begin
      MessageDlg('Can not handle (n,p) cross section filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    if (Trim(EditSigmaNP2.Text)='') then
     Float2:= 1E100
    else
     if not(ValEuSilent(EditSigmaNP2.Text, Float2)) then begin
      MessageDlg('Can not handle (n,p) cross section filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    FloatMin:= Min(Float1, Float2);
    FloatMax:= Max(Float1, Float2);
    List1.Clear;
    with _FormNK.NuclideList do
     for I:= 0 to _FormNK.NuclideList.Count-1 do
      for J:= 0 to _FormNK.NuclideList[I].StateList.Count-1 do
       with _FormNK.NuclideList[I].StateList[J] do
        if ((_FormNK.NuclideList[I].StateList[J].SigmaNP<=FloatMax)and(_FormNK.NuclideList[I].StateList[J].SigmaNP>=FloatMin)) then
         List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
          _FormNK.NuclideList[I].StateList[J].State);
    if not(ListManFunction(List1, ListAnswer, ListVar)) then begin
     MessageDlg('No ListMan in SigmaNP block !!!', mtInformation, [mbOK], 0);
     exit;
    end
    else
     ListAnswer.Assign(ListVar);
   end;
   if CheckBoxSigmaNA.Checked then begin
    Float1:= 0;
    Float2:= 1E100;
    if ((Trim(EditSigmaNA1.Text)='')and(Trim(EditSigmaNA2.Text)='')) then begin
     MessageDlg('Can not handle (n,alpha) cross section filter !', mtWarning, [mbOK], 0);
     Self.Enabled:= True;
     Exit;
    end;
    if (Trim(EditSigmaNA1.Text)='') then
     Float1:= 0.0
    else
     if not(ValEuSilent(EditSigmaNA1.Text, Float1)) then begin
      MessageDlg('Can not handle (n,alpha) cross section filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    if (Trim(EditSigmaNA2.Text)='') then
     Float2:= 1E100
    else
     if not(ValEuSilent(EditSigmaNA2.Text, Float2)) then begin
      MessageDlg('Can not handle (n,alpha) cross section filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    FloatMin:= Min(Float1, Float2);
    FloatMax:= Max(Float1, Float2);
    List1.Clear;
    with _FormNK.NuclideList do
     for I:= 0 to _FormNK.NuclideList.Count-1 do
      for J:= 0 to _FormNK.NuclideList[I].StateList.Count-1 do
       with _FormNK.NuclideList[I].StateList[J] do
        if ((_FormNK.NuclideList[I].StateList[J].SigmaNA<=FloatMax)and(_FormNK.NuclideList[I].StateList[J].SigmaNA>=FloatMin)) then
         List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
          _FormNK.NuclideList[I].StateList[J].State);
    if not(ListManFunction(List1, ListAnswer, ListVar)) then begin
     MessageDlg('Not ListMan in SigmaNA block !!!', mtInformation, [mbOK], 0);
     exit;
    end
    else
     ListAnswer.Assign(ListVar);
   end;
   if CheckBoxSigmaN2N.Checked then begin
    Float1:= 0;
    Float2:= 1E100;
    if ((Trim(EditSigmaN2N1.Text)='')and(Trim(EditSigmaN2N2.Text)='')) then begin
     MessageDlg('Can not handle (n,2n) cross section filter !', mtWarning, [mbOK], 0);
     Self.Enabled:= True;
     Exit;
    end;
    if (Trim(EditSigmaN2N1.Text)='') then
     Float1:= 0.0
    else
     if not(ValEuSilent(EditSigmaN2N1.Text, Float1)) then begin
      MessageDlg('Can not handle (n,2n) cross section filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    if (Trim(EditSigmaN2N2.Text)='') then
     Float2:= 1E100
    else
     if not(ValEuSilent(EditSigmaN2N2.Text, Float2)) then begin
      MessageDlg('Can not handle (n,2n) cross section filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    FloatMin:= Min(Float1, Float2);
    FloatMax:= Max(Float1, Float2);
    List1.Clear;
    with _FormNK.NuclideList do
     for I:= 0 to _FormNK.NuclideList.Count-1 do
      for J:= 0 to _FormNK.NuclideList[I].StateList.Count-1 do
       with _FormNK.NuclideList[I].StateList[J] do
        if ((_FormNK.NuclideList[I].StateList[J].SigmaN2N<=FloatMax)and(_FormNK.NuclideList[I].StateList[J].SigmaN2N>=FloatMin)) then
         List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
          _FormNK.NuclideList[I].StateList[J].State);
    if not(ListManFunction(List1, ListAnswer, ListVar)) then begin
     MessageDlg('Not ListMan in SigmaN2N block !!!', mtInformation, [mbOK], 0);
     exit;
    end
    else
     ListAnswer.Assign(ListVar);
   end;
   if CheckBoxSigmaNN.Checked then begin
    Float1:= 0;
    Float2:= 1E100;
    if ((Trim(EditSigmaNN1.Text)='')and(Trim(EditSigmaNN2.Text)='')) then begin
     MessageDlg('Can not handle '+'(n, n'#39')'+' cross section filter !', mtWarning, [mbOK], 0);
     Self.Enabled:= True;
     Exit;
    end;
    if (Trim(EditSigmaNN1.Text)='') then
     Float1:= 0.0
    else
     if not(ValEuSilent(EditSigmaNN1.Text, Float1)) then begin
      MessageDlg('Can not handle '+'(n, n'#39')'+' cross section filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    if (Trim(EditSigmaNN2.Text)='') then
     Float2:= 1E100
    else
     if not(ValEuSilent(EditSigmaNN2.Text, Float2)) then begin
      MessageDlg('Can not handle '+'(n, n'#39')'+' cross section filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    FloatMin:= Min(Float1, Float2);
    FloatMax:= Max(Float1, Float2);
    List1.Clear;
    with _FormNK.NuclideList do
     for I:= 0 to _FormNK.NuclideList.Count-1 do
      for J:= 0 to _FormNK.NuclideList[I].StateList.Count-1 do
       with _FormNK.NuclideList[I].StateList[J] do
        if ((_FormNK.NuclideList[I].StateList[J].SigmaNN<=FloatMax)and(_FormNK.NuclideList[I].StateList[J].SigmaNN>=FloatMin)) then
         List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
          _FormNK.NuclideList[I].StateList[J].State);
    if not(ListManFunction(List1, ListAnswer, ListVar)) then begin
     MessageDlg('Not ListMan in SigmaNN block !!!', mtInformation, [mbOK], 0);
     exit;
    end
    else
     ListAnswer.Assign(ListVar);
   end;
   if CheckBoxAlphaLine.Checked then begin
    Float1:= 0;
    Float2:= 1E100;
    if ((Trim(EditAlphaLine1.Text)='')and(Trim(EditAlphaLine2.Text)='')and(Trim(EditAlphaProb.Text)='')and(not CheckBoxAlphaLineNull.Checked)) then begin
     MessageDlg('Can not handle alpha line filter !', mtWarning, [mbOK], 0);
     Self.Enabled:= True;
     Exit;
    end;
    if (Trim(EditAlphaLine1.Text)='') then
     Float1:= 0.0
    else
     if not(ValEuSilent(EditAlphaLine1.Text, Float1)) then begin
      MessageDlg('Can not handle alpha line filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    if (Trim(EditAlphaLine2.Text)='') then
     Float2:= 1E100
    else
     if not(ValEuSilent(EditAlphaLine2.Text, Float2)) then begin
      MessageDlg('Can not handle alpha line filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    if (Trim(EditAlphaProb.Text)='') then
     Float3:= 0.0
    else
     if not(ValEuSilent(EditAlphaProb.Text, Float3)) then begin
      MessageDlg('Can not handle alpha line filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    FloatMin:= Float1;
    FloatMax:= Float2;
    FloatProb:= Float3;
    List1.Clear;
    if CheckBoxAlphaLineNull.Checked then begin
     with _FormNK.NuclideList do
      for I:= 0 to _FormNK.NuclideList.Count-1 do
       for J:= 0 to _FormNK.NuclideList[I].StateList.Count-1 do
        with _FormNK.NuclideList[I].StateList[J] do begin
         if (_FormNK.NuclideList[I].StateList[J].Alphas.Count=0) then begin
          List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
           _FormNK.NuclideList[I].StateList[J].State);
          continue;
         end;
         for K:= 0 to _FormNK.NuclideList[I].StateList[J].Alphas.Count-1 do
          if ((_FormNK.NuclideList[I].StateList[J].Alphas[K].MeV>=FloatMin)and(_FormNK.NuclideList[I].StateList[J].Alphas[K].MeV<=FloatMax)and
           (_FormNK.NuclideList[I].StateList[J].Alphas[K].Probability>=FloatProb)) then begin
           List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
            _FormNK.NuclideList[I].StateList[J].State);
           break;
          end;
        end;
    end
    else begin
     with _FormNK.NuclideList do
      for I:= 0 to _FormNK.NuclideList.Count-1 do
       for J:= 0 to _FormNK.NuclideList[I].StateList.Count-1 do
        for K:= 0 to _FormNK.NuclideList[I].StateList[J].Alphas.Count-1 do
         with _FormNK.NuclideList[I].StateList[J] do begin
          if ((_FormNK.NuclideList[I].StateList[J].Alphas[K].MeV>=FloatMin)and(_FormNK.NuclideList[I].StateList[J].Alphas[K].MeV<=FloatMax)and
           (_FormNK.NuclideList[I].StateList[J].Alphas[K].Probability>=FloatProb)) then begin
           List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
            _FormNK.NuclideList[I].StateList[J].State);
           break;
          end;
         end;
    end;
    if not(ListManFunction(List1, ListAnswer, ListVar)) then begin
     MessageDlg('Not ListMan in AlphaLines block !!!', mtInformation, [mbOK], 0);
     exit;
    end
    else
     ListAnswer.Assign(ListVar);
   end;
   if CheckBoxBetaLine.Checked then begin
    Float1:= 0;
    Float2:= 1E100;
    if ((Trim(EditBetaLine1.Text)='')and(Trim(EditBetaLine2.Text)='')and(Trim(EditBetaProb.Text)='')and(not CheckBoxBetaLineNull.Checked)) then begin
      MessageDlg('Can not handle beta line filter !', mtWarning, [mbOK], 0);
     Self.Enabled:= True;
     Exit;
    end;
    if (Trim(EditBetaLine1.Text)='') then
     Float1:= 0.0
    else
     if not(ValEuSilent(EditBetaLine1.Text, Float1)) then begin
      MessageDlg('Can not handle beta line filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    if (Trim(EditBetaLine2.Text)='') then
     Float2:= 1E100
    else
     if not(ValEuSilent(EditBetaLine2.Text, Float2)) then begin
      MessageDlg('Can not handle beta line filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    if (Trim(EditBetaProb.Text)='') then
     Float3:= 0.0
    else
     if not(ValEuSilent(EditBetaProb.Text, Float3)) then begin
      MessageDlg('Can not handle beta line filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    FloatMin:= Float1;
    FloatMax:= Float2;
    FloatProb:= Float3;
    List1.Clear;
    if CheckBoxBetaLineNull.Checked then begin
     with _FormNK.NuclideList do
      for I:= 0 to _FormNK.NuclideList.Count-1 do
       for J:= 0 to _FormNK.NuclideList[I].StateList.Count-1 do
        with _FormNK.NuclideList[I].StateList[J] do begin
         if (_FormNK.NuclideList[I].StateList[J].Betas.Count=0) then begin
          List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
           _FormNK.NuclideList[I].StateList[J].State);
          continue;
         end;
         for K:= 0 to _FormNK.NuclideList[I].StateList[J].Betas.Count-1 do
          if ((_FormNK.NuclideList[I].StateList[J].Betas[K].MaxMeV>=FloatMin)and(_FormNK.NuclideList[I].StateList[J].Betas[K].MaxMeV<=FloatMax)and
           (_FormNK.NuclideList[I].StateList[J].Betas[K].Probability>=FloatProb)) then begin
           List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
            _FormNK.NuclideList[I].StateList[J].State);
           break;
          end;
        end;
    end
    else begin
     with _FormNK.NuclideList do
      for I:= 0 to _FormNK.NuclideList.Count-1 do
       for J:= 0 to _FormNK.NuclideList[I].StateList.Count-1 do
        for K:= 0 to _FormNK.NuclideList[I].StateList[J].Betas.Count-1 do
         with _FormNK.NuclideList[I].StateList[J] do begin
          if ((_FormNK.NuclideList[I].StateList[J].Betas[K].MaxMeV>=FloatMin)and(_FormNK.NuclideList[I].StateList[J].Betas[K].MaxMeV<=FloatMax)and
           (_FormNK.NuclideList[I].StateList[J].Betas[K].Probability>=FloatProb)) then begin
           List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
            _FormNK.NuclideList[I].StateList[J].State);
           break;
          end;
         end;
    end;
    if not(ListManFunction(List1, ListAnswer, ListVar)) then begin
     MessageDlg('Not ListMan in BetaLines block !!!', mtInformation, [mbOK], 0);
     exit;
    end
    else
     ListAnswer.Assign(ListVar);
   end;
   if CheckBoxGammaLine.Checked then begin
    Float1:= 0;
    Float2:= 1E100;
    if ((Trim(EditGammaLine1.Text)='')and(Trim(EditGammaLine2.Text)='')and(Trim(EditGammaProb.Text)='')and(not CheckBoxGammaLineNull.Checked)) then begin
     MessageDlg('Can not handle gamma line filter !', mtWarning, [mbOK], 0);
     Self.Enabled:= True;
     Exit;
    end;
    if (Trim(EditGammaLine1.Text)='') then
     Float1:= 0.0
    else
     if not(ValEuSilent(EditGammaLine1.Text, Float1)) then begin
      MessageDlg('Can not handle gamma line filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    if (Trim(EditGammaLine2.Text)='') then
     Float2:= 1E100
    else
     if not(ValEuSilent(EditGammaLine2.Text, Float2)) then begin
      MessageDlg('Can not handle gamma line filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    if (Trim(EditGammaProb.Text)='') then
     Float3:= 0.0
    else
     if not(ValEuSilent(EditGammaProb.Text, Float3)) then begin
      MessageDlg('Can not handle gamma line filter !', mtWarning, [mbOK], 0);
      Self.Enabled:= True;
      Exit;
     end;
    FloatMin:= Float1;
    FloatMax:= Float2;
    FloatProb:= Float3;
    List1.Clear;
    if not(CheckBoxNoGamma.Checked) then begin
     if CheckBoxGammaLineNull.Checked then begin
      with _FormNK.NuclideList do
       for I:= 0 to _FormNK.NuclideList.Count-1 do
        for J:= 0 to _FormNK.NuclideList[I].StateList.Count-1 do
         with _FormNK.NuclideList[I].StateList[J] do begin
          if (_FormNK.NuclideList[I].StateList[J].Gammas.Count=0) then begin
           List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
            _FormNK.NuclideList[I].StateList[J].State);
           continue;
          end;
          for K:= 0 to _FormNK.NuclideList[I].StateList[J].Gammas.Count-1 do
           if ((_FormNK.NuclideList[I].StateList[J].Gammas[K].MeV>=FloatMin)and(_FormNK.NuclideList[I].StateList[J].Gammas[K].MeV<=FloatMax)and
            (_FormNK.NuclideList[I].StateList[J].Gammas[K].Probability>=FloatProb)) then begin
            List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
             _FormNK.NuclideList[I].StateList[J].State);
            break;
           end;
         end;
     end
     else begin
      with _FormNK.NuclideList do
       for I:= 0 to _FormNK.NuclideList.Count-1 do
        for J:= 0 to _FormNK.NuclideList[I].StateList.Count-1 do
         for K:= 0 to _FormNK.NuclideList[I].StateList[J].Gammas.Count-1 do
          with _FormNK.NuclideList[I].StateList[J] do begin
           if ((_FormNK.NuclideList[I].StateList[J].Gammas[K].MeV>=FloatMin)and(_FormNK.NuclideList[I].StateList[J].Gammas[K].MeV<=FloatMax)and
            (_FormNK.NuclideList[I].StateList[J].Gammas[K].Probability>=FloatProb)) then begin
            List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
             _FormNK.NuclideList[I].StateList[J].State);
            break;
           end;
          end;
     end;
    end//not(CheckBoxNoGamma.Checked)
    else begin
     if CheckBoxGammaLineNull.Checked then begin
      with _FormNK.NuclideList do
       for I:= 0 to _FormNK.NuclideList.Count-1 do
        for J:= 0 to _FormNK.NuclideList[I].StateList.Count-1 do
         with _FormNK.NuclideList[I].StateList[J] do begin
          if (_FormNK.NuclideList[I].StateList[J].Gammas.Count=0) then begin
           List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
            _FormNK.NuclideList[I].StateList[J].State);
           continue;
          end;
          for K:= 0 to _FormNK.NuclideList[I].StateList[J].Gammas.Count-1 do
           if ((_FormNK.NuclideList[I].StateList[J].Gammas[K].MeV>=FloatMin)and(_FormNK.NuclideList[I].StateList[J].Gammas[K].MeV<=FloatMax)and
            (_FormNK.NuclideList[I].StateList[J].Gammas[K].Probability>=FloatProb)
            or(_FormNK.NuclideList[I].StateList[J].Gammas[K].Probability=-1)) then begin
            List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
             _FormNK.NuclideList[I].StateList[J].State);
            break;
           end;
         end;
     end
     else begin
      with _FormNK.NuclideList do
       for I:= 0 to _FormNK.NuclideList.Count-1 do
        for J:= 0 to _FormNK.NuclideList[I].StateList.Count-1 do
         for K:= 0 to _FormNK.NuclideList[I].StateList[J].Gammas.Count-1 do
          with _FormNK.NuclideList[I].StateList[J] do begin
           if ((_FormNK.NuclideList[I].StateList[J].Gammas[K].MeV>=FloatMin)and(_FormNK.NuclideList[I].StateList[J].Gammas[K].MeV<=FloatMax)and
            (_FormNK.NuclideList[I].StateList[J].Gammas[K].Probability>=FloatProb)
            or(_FormNK.NuclideList[I].StateList[J].Gammas[K].Probability=-1)) then begin
            List1.AddUniq(10*(1000*_FormNK.NuclideList[I].Znum+_FormNK.NuclideList[I].Amass)+
             _FormNK.NuclideList[I].StateList[J].State);
            break;
           end;
          end;
     end;
    end;
    if not(ListManFunction(List1, ListAnswer, ListVar)) then begin
     MessageDlg('Not ListMan in GammaLines block !!!', mtInformation, [mbOK], 0);
     exit;
    end
    else
     ListAnswer.Assign(ListVar);
   end;
   for I:= ListAnswer.Count-1 downto 0 do begin
    if not(CheckBoxG.Checked) then
     if (ListAnswer[I]mod 10=0) then ListAnswer.Delete(I);
    if not(CheckBoxM1.Checked) then
     if (ListAnswer[I]mod 10=1) then ListAnswer.Delete(I);
    if not(CheckBoxM2.Checked) then
     if (ListAnswer[I]mod 10=2) then ListAnswer.Delete(I);
   end;
   List1.Assign(ListAnswer);
   with _FrmList do begin
    if (CheckBoxClearList.Checked) then begin
     if ((List1.Count=0)and(_FrmList.ThZpA_Slist.Count>0)) then
      MessageDlg('States were not found for the filter!'+#10+#13+
       'The list will not be cleared', mtInformation, [mbOK], 0)
     else
      MessageDlg(IntToStr(List1.Count)+'  found state[s]' , mtInformation, [mbOK], 0);
    end
    else
     MessageDlg(IntToStr(List1.Count)+'  found state[s]', mtInformation, [mbOK], 0);
    if ((CheckBoxClearList.Checked)and(List1.Count>0)) then begin
     ThZpA_Slist.Clear;
    end;
    for I:= 0 to List1.Count-1 do
     ThZpA_Slist.AddUniq(List1[I]);
   end;
   with _FrmList do begin
    Hide;
    InvalidateGrid(Self);
    if ThZpA_Slist.Count>0 then
     Show;
   end;
  finally
   List1.Free;
   ListVar.Free;
   ListAnswer.Free;
   Caption:= 'Filter criteria';
   Cursor:= crDefault;
   Self.Enabled:= True;
  end;
 end;
 with _FrmList do begin
  if ThZpA_Slist.Count>0 then
   Show;
 end;
end;

procedure T_FormChooseCriteria.SpeedButton1Click(Sender: TObject);
begin
 with _FrmList do begin
  if StringGridChosenList.RowCount>1 then begin
   Hide;
   Show;
  end
  else
   MessageDlg('The filter list is empty !', mtWarning, [mbOK], 0);
 end;
end;

procedure T_FormChooseCriteria.EditZnum1Change(Sender: TObject);
begin
 CheckBoxZnum.Checked:= True;
end;

procedure T_FormChooseCriteria.EditAmass1Change(Sender: TObject);
begin
 CheckBoxAmass.Checked:= True;
end;

procedure T_FormChooseCriteria.EditT1_2_1Change(Sender: TObject);
begin
 CheckBoxT1_2.Checked:= True;
end;

procedure T_FormChooseCriteria.CheckBoxStableClick(Sender: TObject);
begin
 if ((CheckBoxStable.Checked)or(CheckBoxAlpha.Checked)or(CheckBoxBeta.Checked)or
  (CheckBoxEC.Checked)or(CheckBoxSF.Checked)or(CheckBoxIT.Checked)) then
  CheckBoxDecayType.Checked:= True
 else
  CheckBoxDecayType.Checked:= False;
end;

procedure T_FormChooseCriteria.EditSigmaC1Change(Sender: TObject);
begin
 CheckBoxSigmaC.Checked:= True;
end;

procedure T_FormChooseCriteria.EditSigmaF1Change(Sender: TObject);
begin
 CheckBoxSigmaF.Checked:= True;
end;

procedure T_FormChooseCriteria.EditSigmaNP1Change(Sender: TObject);
begin
 CheckBoxSigmaNP.Checked:= True;
end;

procedure T_FormChooseCriteria.EditSigmaNA1Change(Sender: TObject);
begin
 CheckBoxSigmaNA.Checked:= True;
end;

procedure T_FormChooseCriteria.EditSigmaN2N1Change(Sender: TObject);
begin
 CheckBoxSigmaN2N.Checked:= True;
end;

procedure T_FormChooseCriteria.EditSigmaNN1Change(Sender: TObject);
begin
 CheckBoxSigmaNN.Checked:= True;
end;

procedure T_FormChooseCriteria.EditAlphaLine1Change(Sender: TObject);
begin
 CheckBoxAlphaLine.Checked:= True;
end;

procedure T_FormChooseCriteria.EditBetaLine1Change(Sender: TObject);
begin
 CheckBoxBetaLine.Checked:= True;
end;

procedure T_FormChooseCriteria.EditGammaLine1Change(Sender: TObject);
begin
 CheckBoxGammaLine.Checked:= True;
end;

procedure T_FormChooseCriteria.CheckBoxClick(Sender: TObject);
begin
 with Sender as TCheckBox do begin
  if Checked then (Parent as TGroupBox).Color:= clLime
  else (Parent as TGroupBox).Color:= clBtnFace;
 end;
end;

procedure T_FormChooseCriteria.SpeedButtonChooseMouseDown(Sender: TObject;
 Button: TMouseButton;Shift: TShiftState;X, Y: Integer);
begin
 if Button=mbLeft then
  if ssShift in Shift then SpecialQuery:= true else SpecialQuery:= false;
end;

end.

