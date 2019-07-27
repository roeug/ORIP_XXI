unit UnitChainEditor;

interface

uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
 ExtCtrls, StdCtrls, ComCtrls, Grids, Buttons, BKStringGrid, CheckLst,
 mxNativeExcel, Menus, MyGrids, SortGrid, Mask, ToolEdit;

type
 T_FormChainEditor = class(TForm)
  SaveDialog: TSaveDialog;
  OpenDialog: TOpenDialog;
  PageControl: TPageControl;
  TabSheetChainEditor: TTabSheet;
  TabSheetConditions: TTabSheet;
  LabelChainFileName: TLabel;
  TabSheetTimes: TTabSheet;
  TabSheetCalc: TTabSheet;
  TabSheetAnswers: TTabSheet;
  LabelTimesFileName: TLabel;
  ScrollBoxTimes: TScrollBox;
  PanelTimesCommon: TPanel;
  BitBtnApplyAllTimes: TBitBtn;
  BitBtnDelLastTimeInterval: TBitBtn;
  BitBtnNewTimeInterval: TBitBtn;
  ButtonTimesFileSave: TButton;
  ButtonTimesFileOpen: TButton;
  PanelCalcRight: TPanel;
  MemoCalculatorStdOut: TMemo;
  TabSheet1: TTabSheet;
  GroupBox1: TGroupBox;
  Memo1: TMemo;
  mxNativeExcel: TmxNativeExcel;
  LabelOthers: TLabel;
  ButtonDoNotClick: TButton;
  PopupMenuCAD: TPopupMenu;
  CopyStateNames: TMenuItem;
  ItemShowHalfLifes: TMenuItem;
  ItemHidefissionlinks: TMenuItem;
  ItemUseIndYieldsForState: TMenuItem;
  Label6: TLabel;
  ItemZoomIn: TMenuItem;
  ItemZoomOut: TMenuItem;
  ItemSaveMetafile: TMenuItem;
  ItemShowCrossSections: TMenuItem;
  ItemShowRI: TMenuItem;
  ButtonTestCalc: TButton;
  ItemUseCumYieldsForState: TMenuItem;
  PanelChainBottom: TPanel;
  StringGridStateLink: TBKStringGrid;
  SplitterHorzChainEdit: TSplitter;
  PanelChainEditBig: TPanel;
  ScrollBoxCAD: TScrollBox;
  Image: TImage;
  ItemAddStateChilds: TMenuItem;
  LabelSolverStdOut: TLabel;
  SplitterCalcPage: TSplitter;
  PanelChainRightBottom: TPanel;
  ButtonLookInOOB: TButton;
  ButtonToChain: TButton;
  SpeedButtonInfo: TSpeedButton;
  FilenameEdit1: TFilenameEdit;
  Panel1: TPanel;
  CheckBox1: TCheckBox;
  Edit4: TEdit;
  Label1: TLabel;
  Label2: TLabel;
  Edit1: TEdit;
  Label3: TLabel;
  Edit2: TEdit;
  Label4: TLabel;
  Edit3: TEdit;
  Label5: TLabel;
  Edit5: TEdit;
  ButtonTestChain: TButton;
  StringGridAnswers: TStringGrid;
  StringGridResults: TStringGrid;
  ScrollBoxConditions: TScrollBox;
  PanelDepressionSSK: TPanel;
  GroupBoxDepression: TGroupBox;
  LabelDepressionVolume: TLabel;
  LabelDeplessionL: TLabel;
  CheckBoxDepression: TCheckBox;
  EditDepressionVolume: TEdit;
  EditDepressionL: TEdit;
  GroupBoxSSKinitial: TGroupBox;
  GroupBoxRAs: TGroupBox;
  StringGridRA_Rs: TSortGrid;
  PanelRAs: TPanel;
  LabelRA_V: TLabel;
  LabelRA_M: TLabel;
  LabelNperCM3: TLabel;
  EditRA_V: TEdit;
  EditRA_M: TEdit;
  ButtonLoadResPar: TButton;
  ButtonRA_FillDefaults: TButton;
  GroupBoxMM: TGroupBox;
  LabelMM_V: TLabel;
  LabelMM_M: TLabel;
  EditMM_V: TEdit;
  EditMM_M: TEdit;
  ButtonSaveMM: TButton;
  ButtonLoadMM: TButton;
  StringGridMM: TBKStringGrid;
  GroupBoxOM: TGroupBox;
  LabelOM_V: TLabel;
  LabelOM_M: TLabel;
  StringGridOM: TBKStringGrid;
  EditOM_V: TEdit;
  EditOM_M: TEdit;
  ButtonLoadOM: TButton;
  ButtonSaveOM: TButton;
  PaneRA_Top: TPanel;
  PanelBlock: TGroupBox;
  LabelVblock: TLabel;
  LabelSkin_V: TLabel;
  LabelBlock_M: TLabel;
  LabelSkin_M: TLabel;
  LabelLmean4SSK: TLabel;
  LabelTemperature4SSK: TLabel;
  LabelUnits_MV: TLabel;
  RadioGroupCellType: TRadioGroup;
  EditTemperature: TEdit;
  EditBlock_V: TEdit;
  EditSkin_V: TEdit;
  EditBlock_M: TEdit;
  EditSkin_M: TEdit;
  Editl_mean: TEdit;
  CheckBoxSSKconsider: TCheckBox;
  ButtonBuildResTable: TButton;
  ButtonLoadResTable: TButton;
  ButtonSaveResTable: TButton;
  GroupBoxInitialValues: TGroupBox;
  GroupBoxInitialWhat: TGroupBox;
  RadioButtonNuclei: TRadioButton;
  RadioButtonMasses: TRadioButton;
  StringGridMasses: TStringGrid;
  StringGridInitialValues: TBKStringGrid;
  CheckBoxPercent: TCheckBox;
  ScrollBox1: TScrollBox;
  PanelAnswers: TPanel;
  RadioGroupAnswers: TRadioGroup;
  ButtonTestAnswers: TButton;
  RadioGroupActivityUnits: TRadioGroup;
  ButtonExcelExport: TButton;
  CheckBoxAnswersA_Z: TCheckBox;
  CheckBoxSaveSlow: TCheckBox;
  PanelCalcTop: TScrollBox;
  ProgressBarCalc: TProgressBar;
  CheckBoxDLL: TCheckBox;
  CheckBoxJAC: TCheckBox;
  ButtonCalc: TButton;
  ButtonAbortCalc: TButton;
  RadioGroupSolver: TGroupBox;
  RadioButtonVODE: TRadioButton;
  RadioButtonLSODA: TRadioButton;
  RadioButtonRADAU: TRadioButton;
  RadioButtonMEBDF: TRadioButton;
  PanelChainRight: TScrollBox;
  ButtonRepaint: TButton;
  ButtonClearChainEditor: TButton;
  ProgressBarLoad: TProgressBar;
  GroupBoxStates: TGroupBox;
  EditState: TEdit;
  CheckBoxBuildLinks: TCheckBox;
  ButtonAddState: TButton;
  ButtonDeleteState: TButton;
  ComboBoxStates: TComboBox;
  CheckBoxCapture: TCheckBox;
  CheckBoxFission: TCheckBox;
  CheckBoxDecay: TCheckBox;
  CheckBoxThreshold: TCheckBox;
  BitBtnEditAddStatesList: TBitBtn;
  GroupBoxLinks: TGroupBox;
  LabelStart4Link: TLabel;
  LabelEnd4Link: TLabel;
  ButtonAddLink: TButton;
  ComboBoxLinks: TComboBox;
  ButtonDeleteLink: TButton;
  EditLinkStart: TComboBox;
  EditLinkFinish: TComboBox;
  ButtonSaveChain: TButton;
  ButtonLoadChain: TButton;
  ButtonLoadDB: TButton;
  CheckBoxTimesAutoApply: TCheckBox;
  ButtonSaveSSKconditions: TButton;
  ButtonLoadSSKconditions: TButton;
  PanelMassButtons: TPanel;
  LabelTotalMass: TLabel;
  EditTotalMass: TEdit;
  ButtonLoadInitials: TButton;
  ButtonSaveInitials: TButton;
  PopupMenuLink: TPopupMenu;
  LinkPopupItemUseIndYieldForLink: TMenuItem;
  LinkPopupItemUseCumYieldForLink: TMenuItem;
  procedure FormCreate(Sender: TObject);
  procedure ButtonRepaintClick(Sender: TObject);
  procedure ButtonAddStateClick(Sender: TObject);
  procedure ButtonClearChainEditorClick(Sender: TObject);
  procedure ButtonLoadDBClick(Sender: TObject);
  procedure ImageMouseUp(Sender: TObject; Button: TMouseButton;
   Shift: TShiftState; X, Y: Integer);
  procedure ButtonAddLinkClick(Sender: TObject);
  procedure ComboBoxStatesChange(Sender: TObject);
  procedure ButtonDeleteStateClick(Sender: TObject);
  procedure ButtonDeleteLinkClick(Sender: TObject);
  procedure ComboBoxLinksChange(Sender: TObject);
  procedure ButtonLookInOOBClick(Sender: TObject);
  procedure ButtonToChainClick(Sender: TObject);
  procedure ButtonSaveChainClick(Sender: TObject);
  procedure ButtonLoadChainClick(Sender: TObject);
  procedure EditStateKeyUp(Sender: TObject; var Key: Word;
   Shift: TShiftState);
  procedure BitBtnApplyAllTimesClick(Sender: TObject);
  procedure TimesChange(Sender: TObject);
  procedure BitBtnNewTimeIntervalClick(Sender: TObject);
  procedure BitBtnDelLastTimeIntervalClick(Sender: TObject);
  procedure ButtonTimesFileSaveClick(Sender: TObject);
  procedure ButtonTimesFileOpenClick(Sender: TObject);
  procedure TabSheetConditionsShow(Sender: TObject);
  procedure RadioButtonMassesNucleiClick(Sender: TObject);
  procedure ButtonTestCalcClick(Sender: TObject);
  procedure RadioGroupAnswersClick(Sender: TObject);
  procedure RadioGroupActivityUnitsClick(Sender: TObject);
  procedure TabSheetAnswersShow(Sender: TObject);
  procedure ButtonLoadResParClick(Sender: TObject);
  procedure TabSheetCalcShow(Sender: TObject);
  procedure ButtonSaveMMClick(Sender: TObject);
  procedure ButtonSaveOMClick(Sender: TObject);
  procedure ButtonLoadMMClick(Sender: TObject);
  procedure ButtonLoadOMClick(Sender: TObject);
  procedure ButtonRA_FillDefaultsClick(Sender: TObject);
  procedure ButtonLoadResTableClick(Sender: TObject);
  procedure ButtonSaveResTableClick(Sender: TObject);
  procedure StringGridMMKeyUp(Sender: TObject; var Key: Word;
   Shift: TShiftState);
  procedure ButtonBuildResTableClick(Sender: TObject);
  procedure FormDestroy(Sender: TObject);
  procedure FormKeyUp(Sender: TObject; var Key: Word;
   Shift: TShiftState);
  procedure StringGridInitialValuesUserChangedCell(Sender: TObject; ACol,
   ARow: Integer; const Value: string);
  procedure ButtonLoadInitialsClick(Sender: TObject);
  procedure ButtonSaveInitialsClick(Sender: TObject);
  procedure ButtonExcelExportClick(Sender: TObject);
  procedure EditLinkStartEndChange(Sender: TObject);
  procedure CheckBoxAnswersA_ZClick(Sender: TObject);
  procedure StringGridAnswersColumnMoved(Sender: TObject; FromIndex,
   ToIndex: Integer);
  procedure EditTotalMassChange(Sender: TObject);
  procedure ButtonDoNotClickClick(Sender: TObject);
  procedure CopyStateNamesClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
  procedure StringGridRA_RsGetCellFormat(Sender: TObject; Col,
   Row: Integer; State: TGridDrawState;
   var FormatOptions: TFormatOptions; var CheckBox, Combobox,
   Ellipsis: Boolean);
  procedure StringGridRA_RsDblClick(Sender: TObject);
  procedure StringGridRA_RsSelectCell(Sender: TObject; ACol,
   ARow: Integer; var CanSelect: Boolean);
  procedure StringGridRA_RsCellValidate(Sender: TObject; ACol,
   ARow: Integer; const OldValue: string; var NewValue: string;
   var Valid: Boolean);
  procedure RadioGroupSolverClick(Sender: TObject);
  procedure ButtonCalcClick(Sender: TObject);
  procedure RadioGroupCellTypeClick(Sender: TObject);
  procedure StringGridStateLinkUserChangedCell(Sender: TObject; ACol,
   ARow: Integer; const Value: string);
  procedure BitBtnEditAddStatesListClick(Sender: TObject);
  procedure ItemShowHalfLifesClick(Sender: TObject);
  procedure CheckBoxBuildLinksClick(Sender: TObject);
  procedure ItemHidefissionlinksClick(Sender: TObject);
  procedure ItemUseIndYieldsForStateClick(Sender: TObject);
  procedure PopupMenuCADPopup(Sender: TObject);
  procedure ItemZoomInClick(Sender: TObject);
  procedure ItemZoomOutClick(Sender: TObject);
  procedure ItemSaveMetafileClick(Sender: TObject);
  procedure ItemShowCrossSectionsClick(Sender: TObject);
  procedure ItemShowRIClick(Sender: TObject);
  procedure SpeedButtonInfoClick(Sender: TObject);
  procedure ItemUseCumYieldsForStateClick(Sender: TObject);
  procedure ItemAddStateChildsClick(Sender: TObject);
  procedure ButtonAbortCalcClick(Sender: TObject);
  procedure StringGridMassesSetEditText(Sender: TObject; ACol,
   ARow: Integer; const Value: string);
  procedure StringGridInitialValuesSetEditText(Sender: TObject; ACol,
   ARow: Integer; const Value: string);
  procedure CheckBoxConsiderClick(Sender: TObject);
  procedure PageControlChange(Sender: TObject);
  procedure StringGridRA_RsKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
  procedure StringGridRA_RsKeyPress(Sender: TObject; var Key: Char);
  procedure PanelChainBottomCanResize(Sender: TObject; var NewWidth,
   NewHeight: Integer; var Resize: Boolean);
  procedure ButtonTestChainClick(Sender: TObject);
  procedure PageControlChanging(Sender: TObject;
   var AllowChange: Boolean);
  procedure StringGridStateLinkSelectCell(Sender: TObject; ACol,
   ARow: Integer; var CanSelect: Boolean);
  procedure StringGridStateLinkKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
  procedure StringGridInitialValuesKeyDown(Sender: TObject;
   var Key: Word; Shift: TShiftState);
  procedure StringGridMassesKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
  procedure StringGridAnswersKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
  procedure PageControlResize(Sender: TObject);
  procedure PanelTimesCommonResize(Sender: TObject);
  procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
   Shift: TShiftState; X, Y: Integer);
  procedure ButtonSaveSSKconditionsClick(Sender: TObject);
  procedure ButtonLoadSSKconditionsClick(Sender: TObject);
  procedure StringGridRA_RsMouseDown(Sender: TObject;
   Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  procedure FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
  procedure GroupBoxLinksMouseUp(Sender: TObject; Button: TMouseButton;
   Shift: TShiftState; X, Y: Integer);
  procedure LinkPopupItemUseIndYieldForLinkClick(
   Sender: TObject);
  procedure LinkPopupItemUseCumYieldForLinkClick(
   Sender: TObject);
  procedure EditDepressionVolumeChange(Sender: TObject);
  procedure EditDepressionLChange(Sender: TObject);
  procedure Editl_meanChange(Sender: TObject);
  procedure EditTemperatureChange(Sender: TObject);
  procedure EditRA_VChange(Sender: TObject);
  procedure EditOM_VChange(Sender: TObject);
 private
    { Private declarations }
  fMmFileName: string;
  fOmFileName: string;
  fRtbFileName: string;
  fSaveStr: string;
  fInitialValuesFileName: string;
  fChainCalculated: Boolean;
  fAnswersCol, fAnswersCol0, fC: array of integer;
  fTheDataModule: TDataModule;
  fStringGridRA_RsStateName: string;
  fTmpLines: TStringList;
  fTmpLines0, fTmpLines1, fTmpLines2, fTmpLines3: TStringList;
  fTmpSortedLines: TStringList;
  fNeedToBuildSSK_TableList, fNeedNewCalculator, fNeedPrepareConditions: Boolean;
  fTabSheetAnswersEnabled, fIsReadOnlyDir: Boolean;
  fAllowPrepareConditions: Boolean;
  fShiftPressed: Boolean;
(*
// pipes
  fNewDllLSODA, fNewDllVODE, fNewDllRADAU, fNewDllMEBDF: Boolean;
  fSA: TSecurityAttributes;
  f_FormChainEditorStdOutPipeWrite: THandle;
  f_FormChainEditorStdOutPipeRead: THandle;
*)
  fDirForCalculator: string;
  fApplicationExePath: string;
  fSSKCalculating: Boolean;
  fSSK_CalcAborted: Boolean;
  procedure RefreshRAdata;
  procedure CreateNewCalculator;
  function InitCalculator: Boolean;
  procedure FillRA_RsInfoForm;
  procedure LookInOOB_InfoForm;
  procedure LoadResTableFromFile(const FileName: string);
  procedure RepaintAnswersTable(const AskSlow: Boolean; const ItemNo: integer);
  procedure DoSolve(const Solver: string);
  procedure SetActiveState(aStatePointer: pointer);
  procedure SetActiveLink(aLinkPointer: pointer);
  procedure LoadInitials(const FileName: string);
  function LoadTimes(const FileName: string): Boolean;
  procedure LoadMM(const FileName: string);
  procedure LoadOM(const FileName: string);
  procedure PrepareAnswersCols;
  function IsGetN0fromMassDolja(const MassDolja: single; const aStateName: string; var N0: single): Boolean;
  function PrepareConditions: Boolean; // prepares grids and Previous values restore
  function ApplyConditions: Boolean;
  function ApplyTimes: Boolean;
  procedure RepaintCAD;
  procedure OnCadChange(Sender: TObject);
  function PrepareCalculator: Boolean;
//  procedure InitDebug;
  procedure ChaingAllCumYieldsForDecayChildsWithParentsOnIndYields;
  procedure ChaingAllIndYieldsForDecayChildsWithOutParentsOnCumYields;
//  procedure InitChainPage;
  procedure SetImageSize(const aWidth, aHeight: integer);
  procedure AddStatesByNamesStr(const NamesStr: string; Sender: TObject);
 public
    { Public declarations }
//  IDebug: integer;
//  BDebug: LongBool;
  procedure FormInit(Sender: TObject);
 end;
 
var
 _FormChainEditor: T_FormChainEditor;
 
implementation

{$R *.DFM}

uses
 inifiles, Parsing, FileUtil, Clipbrd, ChainClasses, CadClasses, NuclideClasses, UnitDM_OOB, ChainCalculator, EuLib,
 SelfShieldingCalculatorClasses, UnitLookInOOB,
 UnitFormMemoOkCancel, UnitSplashSolver;

const
 BufferSize = 255;
 BegiEndSectionChar = #255;
 ExcelColLimit = 255; //250
 
var
 Chain: TChain;
 ChainCAD: TChainCAD;
 NuclideList: TNuclideList;
 ActiveLink: TCadLink;
 ActiveState: TCadState;
 ChainCalc: TChainCalculator;
 AllTimePoint: TList;
 SSK_Calc: TSelfShieldingCalculator;
 SSK_TableList: TSSK_TableList;
 OldCalculators: TList;
(*
procedure T_FormChainEditor.InitDebug;
begin
//
 ButtonLoadDBClick(nil);
 StringGridInitialValues.Cells[1, 1]:= '1.0'; // 1.0e22 1
 StringGridInitialValues.Cells[2, 1]:= '1.0e-10'; // 1.0e22 1
 StringGridInitialValues.Cells[3, 1]:= '1.0e-10'; // 1.0e22 1
 StringGridMasses.Cells[1, 0]:= '2.6';
 ButtonLoadResParClick(Self);
 StringGridOM.RowCount:= 2;
 StringGridMM.RowCount:= 2;
 fTmpLines.Clear;
 fTmpLines.Add('1');
 fTmpLines.Add('38');
 fTmpLines.Add('0.065e24');
 StringGridOM.Rows[1].Assign(fTmpLines);
 fTmpLines.Clear;
 fTmpLines.Add('27');
 fTmpLines.Add('1.4');
 fTmpLines.Add('0.6e24');
 StringGridMM.Rows[1].Assign(fTmpLines);
 ButtonRA_defaultsClick(Self);
 InitCalculator;
 ButtonBuildResTableClick(Self);
 LoadTimes('debug.pow');
end;
*)
 
procedure T_FormChainEditor.FormCreate(Sender: TObject);
var
 TempPathPChar: array[0..BufferSize] of Char;
 I: integer;
 aStr: string;
begin
 fApplicationExePath:= ExtractFilePath(Application.ExeName);
 fDirForCalculator:= '';
 fIsReadOnlyDir:= True;
 fAllowPrepareConditions:= True;
 try
  I:= GetTempPath(BufferSize, TempPathPChar); // TempDir
  if ((I > 0) and (I < BufferSize)) then
  begin //OK
   aStr:= string(TempPathPChar);
   if DirExists(aStr) then
    if (IsWritableDir(aStr)) then
    begin
     fDirForCalculator:= aStr;
     fIsReadOnlyDir:= False;
    end
  end;
  if (fDirForCalculator = '') then
  begin // CurrentDir
   aStr:= GetCurrentDir;
   if DirExists(aStr) then
    if (IsWritableDir(aStr)) then
    begin
     fDirForCalculator:= aStr;
     fIsReadOnlyDir:= False;
    end
  end;
  if (fDirForCalculator = '') then
  begin // ExeDir
   aStr:= fApplicationExePath;
   fDirForCalculator:= aStr; // No Choice
   if (IsWritableDir(aStr)) then
   begin
    fIsReadOnlyDir:= False;
   end
  end;
 except
  fDirForCalculator:= fApplicationExePath;
  fIsReadOnlyDir:= not (IsWritableDir(fDirForCalculator));
 end;
 Image.Visible:= False;
 fTmpLines:= TStringList.Create;
 fTmpLines0:= TStringList.Create;
 fTmpLines1:= TStringList.Create;
 fTmpLines2:= TStringList.Create;
 fTmpLines3:= TStringList.Create;
 fTmpSortedLines:= TStringList.Create;
 fTmpSortedLines.Sorted:= True;
 Chain:= TChain.Create;
 fTheDataModule:= T_DataModuleOOB.Create(nil);
 NuclideList:= TNuclideList.Create;
 OldCalculators:= TList.Create;
 ChainCAD:= TChainCAD.Create(Chain);
 ActiveLink:= nil;
 ActiveState:= nil;
 AllTimePoint:= TList.Create;
 AllTimePoint.Add(nil);
 ChainCalc:= nil;
 SSK_Calc:= nil;
 SSK_TableList:= nil;
 ChainCAD.OnChange:= nil;
 ChainCAD.Canvas:= nil;
 OnKeyUp:= nil;
 if fIsReadOnlyDir then
 begin
  CheckBoxDLL.Checked:= False;
  CheckBoxDLL.Enabled:= False;
  RadioButtonRADAU.Enabled:= False;
  RadioButtonMEBDF.Enabled:= False;
 end;
 aStr:= fApplicationExePath + 'ChainSolver.hlp';
 if not (FileExists(aStr)) then
  aStr:= 'ChainSolver.hlp';
 Application.HelpFile:= aStr;
 Self.HelpFile:= aStr;
 fNeedPrepareConditions:= True;
end;

procedure T_FormChainEditor.FormInit(Sender: TObject);
var
 I: integer;
begin
// PageControl.Pages[PageControl.PageCount-1].Free;
 SetActiveState(nil);
 SetActiveLink(nil);
 PageControl.Pages[PageControl.PageCount - 1].PageControl:= nil;
 Application.ProcessMessages;
// OpenDialog.InitialDir:= fApplicationExePath;
// SaveDialog.InitialDir:= fApplicationExePath;
 fTmpLines.Clear;
 with StringGridStateLink do
 begin
  StringGridStateLink.ColWidths[0]:= 64;
  StringGridStateLink.ColWidths[1]:= StringGridStateLink.Width - 65;
  fTmpLines.Add(' # ');
  fTmpLines.Add('Decay');
  fTmpLines.Add('Thermal');
  fTmpLines.Add('Resonance');
  fTmpLines.Add('Fast');
  fTmpLines.Add('g-factor');
  Cells[1, 0]:= 'str';
  for I:= 5 to RowCount - 1 do
   fTmpLines.Add('Line ' + IntToStr(I + 1));
  StringGridStateLink.Cols[0].Assign(fTmpLines);
 end;
(*
// QQQ
 EditState.Text:='Lu-177m,Hf-177g,Hf-177m1,Hf-177m2';
// EditState.Text:='Hf-178...179';
// EditState.Text:='Hf-178m2 Hf-178m1';
// EditState.Text:='Ho-160g Ho-160m1 Ho-160m2';
 CheckBoxCapture.Checked:= False;
 CheckBoxCapture.Enabled:= False;
 CheckBoxThreshold.Checked:= False;
 CheckBoxThreshold.Enabled:= False;
 CheckBoxFission.Checked:= False;
 CheckBoxFission.Enabled:= False;
 ButtonLoadDBClick(nil);
 ButtonAddState.Enabled:= True;
// EditState.Text:= '';
*)
// QQQ
 EditState.Text:= '';
 StringGridRA_Rs.RowCount:= 2;
 PrepareConditions;
// Param present
 with _FormChainEditor do
 begin
  fTmpLines.Clear;
  with Self do
  begin
   fTmpLines.Add('State');
   fTmpLines.Add('Consider');
   fTmpLines.Add(' N min ');
   fTmpLines.Add(' N max ');
   fTmpLines.Add(' Points');
   StringGridRA_Rs.FixedCols:= 0;
   StringGridRA_Rs.Rows[0].Assign(fTmpLines);
   StringGridRA_Rs.FixedCols:= 1;
   if ParamCount > 0 then
    if ((Pos('.', ParamStr(1)) > 0) and (Pos('\', ParamStr(1)) = 0)) then
    begin // The chain
     if FileExists(ParamStr(1)) then
     begin
      Application.ProcessMessages;
      ChainCAD.Free;
      Chain.LoadFromFile(ParamStr(1)); //'_1.chn');
      ChainCAD:= TChainCAD.Create(Chain);
      ChainCAD.CreateStates;
      ChainCAD.CreateLinks;
      LabelChainFileName.Caption:= 'Chain file:' + ParamStr(1);
      OnCadChange(Self);
     end
    end
    else
    begin // all
     if FileExists(ParamStr(1) + '.chn') then
     begin
      Application.ProcessMessages;
      ChainCAD.Free;
      Chain.LoadFromFile(ParamStr(1) + '.chn');
      ChainCAD:= TChainCAD.Create(Chain);
      ChainCAD.CreateStates;
      ChainCAD.CreateLinks;
      LabelChainFileName.Caption:= 'Chain file:' + ParamStr(1) + '.chn';
      OnCadChange(Self);
     end;
     if FileExists(ParamStr(1) + '.pow') then
     begin
      LoadTimes(ParamStr(1) + '.pow');
     end;
     if FileExists(ParamStr(1) + '.mm') then
     begin
      LoadMM(ParamStr(1) + '.mm');
     end;
     if FileExists(ParamStr(1) + '.om') then
     begin
      LoadOM(ParamStr(1) + '.om');
     end;
     if FileExists(ParamStr(1) + '.ivl') then
     begin
      if (Chain <> nil) then
       if (Chain.States.Count > 0) then
       begin
        PrepareConditions;
        LoadInitials(ParamStr(1) + '.ivl');
       end;
     end;
     if FileExists(ParamStr(1) + '.rtb') then
     begin
      LoadResTableFromFile(ParamStr(1) + '.rtb');
     end;
    end;
   Application.ProcessMessages;
  end;
 end;
end;

procedure T_FormChainEditor.FormShow(Sender: TObject);
begin
 Application.ProcessMessages;
 if _FormSplashSolver.Visible then
  _FormSplashSolver.Update;
 Application.ProcessMessages;
 ChainCAD.Canvas:= Image.Canvas;
 if _FormSplashSolver.Visible then
  _FormSplashSolver.Update;
 ChainCAD.OnChange:= OnCadChange;
 if _FormSplashSolver.Visible then
  _FormSplashSolver.Update;
 Image.Visible:= True;
 SetImageSize(ChainCAD.Width, ChainCAD.Height);
 RepaintCAD;
 Application.ProcessMessages;
 if _FormSplashSolver.Visible then
  _FormSplashSolver.Hide;
 _FormSplashSolver.Close;
// StringGridRA_Rs.ColWidths[4]:= StringGridRA_Rs.Width-4*StringGridRA_Rs.DefaultColWidth-32; // 48; //50;
// StringGridRA_Rs.MoveTo(1, 1);
// mxNativeExcel.AddFont( StringGridAnswers.Font);
// mxNativeExcel.ActiveFont:= mxNativeExcel.ActiveFont+1;
end;

procedure T_FormChainEditor.FormDestroy(Sender: TObject);
var
 I: integer;
begin
 ChainCalc.Free;
 ChainCalc:= nil;
 for I:= OldCalculators.Count - 1 downto 0 do
 begin
  TChainCalculator(OldCalculators[I]).Free;
  OldCalculators[I]:= nil;
 end;
 OldCalculators.Free;
 OldCalculators:= nil;
 fTmpLines.Free;
 fTmpLines0.Free;
 fTmpLines1.Free;
 fTmpLines2.Free;
 fTmpLines3.Free;
 fTmpSortedLines.Free;
end;

procedure T_FormChainEditor.FormKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
 if (ssShift in Shift) then
  fShiftPressed:= True
 else
  fShiftPressed:= False;
end;

procedure T_FormChainEditor.FormKeyUp(Sender: TObject; var Key: Word;
 Shift: TShiftState);
var
 I: integer;
begin
 try
  if (ssShift in Shift) then
   fShiftPressed:= True
  else
   fShiftPressed:= False;
 // TabSheetChainEditor
  if TabSheetChainEditor.Visible then
  begin
   if ((Key in [Ord('I'), Ord('i')]) and (ssCtrl in Shift) and (ssAlt in Shift)) then
   begin
    if (ChainCAD.States.Count > 0) then
     if NuclideList.Count < 1 then
      MessageDlg('Nuclides were NOT loaded ! Yields can not be initialized !' + #13 + #10 + 'Use button "LOAD DB"!', mtWarning,
       [mbOK], 0)
     else
      ChaingAllCumYieldsForDecayChildsWithParentsOnIndYields;
   end
   else if ((Key in [Ord('C'), Ord('c')]) and (ssCtrl in Shift) and (ssAlt in Shift)) then
   begin
    if NuclideList.Count < 1 then
     MessageDlg('Nuclides were NOT loaded ! Yields can not be initialized !' + #13 + #10 + 'Use button "LOAD DB"!', mtWarning,
      [mbOK], 0)
    else
    begin
     ChaingAllIndYieldsForDecayChildsWithOutParentsOnCumYields;
    end;
    Exit;
   end
   else if ((Key in [Ord('Y'), Ord('y')]) and (ssCtrl in Shift) and (ssAlt in Shift)) then
   begin
    if NuclideList.Count < 1 then
     MessageDlg('Nuclides were NOT loaded ! Yields can not be initialized !' + #13 + #10 + 'Use button "LOAD DB"!', mtWarning,
      [mbOK], 0)
    else
    begin
     ChaingAllCumYieldsForDecayChildsWithParentsOnIndYields;
     ChaingAllIndYieldsForDecayChildsWithOutParentsOnCumYields;
    end;
   end;
  end;
// Any Tab
  if ((Key in [VK_CANCEL, Ord('C'), Ord('c')]) and (ssCtrl in Shift)) then
  begin
   if (ChainCalc <> nil) then
    if ChainCalc.Calculating then
    begin
     ChainCalc.StopCalculation;
     MemoCalculatorStdOut.Lines.Add('ABORTING...');
     for I:= 0 to ChainCalc.CalculatorStdOut.Count - 1 do
      MemoCalculatorStdOut.Lines.Add(ChainCalc.CalculatorStdOut[I]);
     if not (TabSheetCalc.Visible) then
      TabSheetCalc.Show;
     Exit;
    end;
   if EuLib.InLongOperation then
   begin
    EuLib.StopLongOperation:= True;
    MessageDlg('Ctrl+C or Control+Break pressed.' + #13 + #10 +
     'Aborting somewhere !', mtWarning, [mbOK], 0);
    Exit;
   end;
   if fSSKCalculating then
    if SSK_Calc <> nil then
    begin
     SSK_Calc.AbortCalcSSK:= True;
     fSSK_CalcAborted:= True;
     Application.ProcessMessages;
    end;
  end;

 except
// Say nothing
 end;
end;

procedure T_FormChainEditor.PageControlChanging(Sender: TObject;
 var AllowChange: Boolean);
var
 Answer: Word;
begin
 try
  AllowChange:= True;
  if PageControl.ActivePage = TabSheetChainEditor then
  begin
   PageControl.SetFocus; // To Enable ButtomToChain if need
   if ((ActiveState <> nil) or (ActiveLink <> nil)) then
    if (ButtonToChain.Enabled) then
    begin
     Answer:= MessageDlg('Edited data were not saved to chain ! Save ?', mtWarning, [mbYes, mbNo, mbCancel], 0);
     if (Answer = mrCancel) then
     begin
      AllowChange:= False;
      if (ActiveState <> nil) then
       ComboBoxStates.Text:= ActiveState.State.Name
      else if (ActiveLink <> nil) then
       ComboBoxLinks.Text:= ActiveLink.Link.Name;
      if StringGridStateLink.Visible then
       StringGridStateLink.SetFocus;
      Exit;
     end
     else if (Answer = mrYes) then
      ButtonToChainClick(Self);
    end;
  end
  else if PageControl.ActivePage = TabSheetTimes then
  begin
   if CheckBoxTimesAutoApply.Checked then
   begin
    if not (ApplyTimes) then
    begin
     AllowChange:= False;
    end;
   end;
  end;
 except
// Say nothing
 end;
end;

// Chain page start

procedure T_FormChainEditor.PanelChainBottomCanResize(Sender: TObject;
 var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
 StringGridStateLink.ColWidths[1]:= StringGridStateLink.Width - 65;
end;

procedure T_FormChainEditor.ItemZoomInClick(Sender: TObject);
begin
 if ChainCAD <> nil then
 begin
  Image.Visible:= False;
  with ChainCAD do
  begin
   if ScrollBoxCAD.Visible then
    ScrollBoxCAD.SetFocus;
   Image.Canvas.Brush.Color:= clWhite;
   Image.Canvas.FillRect(Image.Canvas.ClipRect);
   ChainCAD.Zoom(2);
   SetImageSize(ChainCAD.Width, ChainCAD.Height);
   ChainCad.PaintStates;
   ChainCad.PaintLinks;
   if ChainCAD.StateHeight > 8 then
    ItemZoomOut.Enabled:= True
   else
    ItemZoomOut.Enabled:= False;
   if ChainCAD.StateHeight < 80 then
    ItemZoomIn.Enabled:= True
   else
    ItemZoomIn.Enabled:= False;
  end;
  Image.Visible:= True;
 end;
end;

procedure T_FormChainEditor.ItemZoomOutClick(Sender: TObject);
begin
 if ChainCAD <> nil then
  with ChainCAD do
  begin
   if ScrollBoxCAD.Visible then
    ScrollBoxCAD.SetFocus;
   Image.Canvas.Brush.Color:= clWhite;
   Image.Canvas.FillRect(Image.Canvas.ClipRect);
   ChainCAD.Zoom(0.5);
   SetImageSize(ChainCAD.Width, ChainCAD.Height);
   ChainCad.PaintStates;
   ChainCad.PaintLinks;
   if ChainCAD.StateHeight > 8 then
    ItemZoomOut.Enabled:= True
   else
    ItemZoomOut.Enabled:= False;
   if ChainCAD.StateHeight < 80 then
    ItemZoomIn.Enabled:= True
   else
    ItemZoomIn.Enabled:= False;
  end;
end;

procedure T_FormChainEditor.SetImageSize(const aWidth, aHeight: integer);
 procedure AdjustImagePictureGraphicSize(InWidth, InHeight: integer);
 const
  Divider = 100;
  Factor = 99;
 begin
  if ((InHeight > 0) and (InWidth > 0)) then
   try
    Image.Picture.Graphic.Height:= InHeight;
    Image.Picture.Graphic.Width:= InWidth;
   except
    AdjustImagePictureGraphicSize(InWidth * Factor div Divider, InHeight * Factor div Divider);
   end;
 end;
 
begin
 if ((Image.Picture.Graphic.Height <> aHeight) or (Image.Picture.Graphic.Width <> aWidth)) then
  try
   Image.Height:= aHeight;
   Image.Picture.Graphic.Height:= aHeight;
   Image.Width:= aWidth;
   Image.Picture.Graphic.Width:= aWidth;
  except
   on EOutOfResources do
   begin
    MessageDlg('Can not set new image size !' + #10#13 +
     'Out of resources: not enough storage is available. Sorry.', mtWarning, [mbOK], 0);
    AdjustImagePictureGraphicSize(aWidth, aHeight);
   end
   else
    MessageDlg('Can not set new image height !', mtWarning, [mbOK], 0);
  end;
end;

procedure T_FormChainEditor.ItemSaveMetafileClick(Sender: TObject);
var
 SaveCanvas, MetaFileCanvas: TCanvas;
 MetaFile: TMetafile;
 FileExtenstion: string;
begin
 if FilenameEdit1.Dialog.Execute then
  if ChainCAD <> nil then
   try
    SaveCanvas:= ChainCAD.Canvas;
    MetaFile:= TMetafile.Create;
    with MetaFile do
    begin
     FileExtenstion:= UpperCase(Trim(ExtractFileExt(FilenameEdit1.Dialog.FileName)));
     if (FileExtenstion = '.WMF') then
      MetaFile.Enhanced:= False
     else if (FileExtenstion = '.EMF') then
      MetaFile.Enhanced:= True
     else
     begin
      MessageDlg('Unsupported format (' + FileExtenstion + ')' + #10#13 +
       ' Use EMF or WMF !' + #10#13 +
       ' Will not export', mtWarning, [mbOK], 0);
      Exit;
     end;
     MetaFile.Height:= ChainCAD.Height;
     MetaFile.Width:= ChainCAD.Width;
     MetaFileCanvas:= TMetafileCanvas.Create(MetaFile, 0);
     MetaFileCanvas.Font.Name:= 'Times';
     try
      ChainCAD.Canvas:= MetaFileCanvas;
      ChainCad.PaintStates;
      ChainCad.PaintLinks;
     finally
      MetaFileCanvas.Free;
      MetaFile.SaveToFile(FilenameEdit1.Dialog.FileName);
      ChainCAD.Canvas:= SaveCanvas;
      MetaFile.Free;
     end;
    end;
   except
    MessageDlg('Exception in ItemSaveMetafileClick', mtWarning, [mbOK], 0);
   end;
end;

procedure T_FormChainEditor.ItemAddStateChildsClick(Sender: TObject);
var
 NoInChain, I: integer;
 aTransitions: TNuclideTransitions;
 ChildList: TLongIntList;
 aStr: string;
begin
 if NuclideList.Count < 1 then
 begin
  if (MessageDlg('Nuclides were NOT loaded ! States will not be initialized !' + #13 + #10 + 'Use button "LOAD DB" ! Load ?', mtWarning,
   [mbYes, mbNo], 0) = mrYes) then
   ButtonLoadDBClick(Self);
 end;
 if NuclideList.Count > 1 then
  if (ActiveState <> nil) then
  begin
   NoInChain:= Chain.FindState(ActiveState.State.ThZpA_s);
   if (NoInChain >= 0) then
   begin
    ChildList:= TLongIntList.Create;
    try
     aTransitions:= [];
     if CheckBoxDecay.Checked then
      aTransitions:= aTransitions + [ntDecay];
     if CheckBoxCapture.Checked then
      aTransitions:= aTransitions + [ntCapture];
     if CheckBoxThreshold.Checked then
      aTransitions:= aTransitions + [ntThreshold];
     NuclideList.FindChilds(fTheDataModule, ActiveState.State.ThZpA_s, aTransitions, ChildList);
     aStr:= '';
     for I:= 0 to ChildList.Count - 1 do
      aStr:= aStr + ' ' + ThZpA_sToStr(ChildList[I]);
     AddStatesByNamesStr(aStr, Self);
    finally
     ChildList.Free;
    end;
   end;
  end;
end;

procedure T_FormChainEditor.ItemShowCrossSectionsClick(Sender: TObject);
begin
 ItemShowCrossSections.Checked:= not (ItemShowCrossSections.Checked);
 ChainCAD.ShowSigmaC:= ItemShowCrossSections.Checked;
 RepaintCAD;
end;

procedure T_FormChainEditor.ItemShowRIClick(Sender: TObject);
begin
 ItemShowRI.Checked:= not (ItemShowRI.Checked);
 ChainCAD.ShowRI:= ItemShowRI.Checked;
 RepaintCAD;
end;

procedure T_FormChainEditor.BitBtnEditAddStatesListClick(Sender: TObject);
var
 I: integer;
 aStr: string;
begin
 with _FormMemoOKCancel, Self do
 begin
  _FormMemoOKCancel.Caption:= 'Add state(s)';
  if Chain <> nil then
   for I:= 0 to Chain.States.Count - 1 do
    aStr:= aStr + Chain.States[I].Name + ' ';
  _FormMemoOKCancel.MemoInChain.Lines.Text:= aStr;
  _FormMemoOKCancel.Memo.Lines.Clear;
  if (Trim(EditState.Text) <> '') then
   _FormMemoOKCancel.Memo.Lines.Add(EditState.Text);
  aStr:= '';
  if (_FormMemoOKCancel.ShowModal = mrOK) then
  begin
// qqqq was 2 below
//   for I:= 0 to _FormMemoOKCancel.Memo.Lines.Count-1 do
//    aStr:= aStr+_FormMemoOKCancel.Memo.Lines[I]+',';
// qqqq was 2 up
   aStr:= Trim(_FormMemoOKCancel.Memo.Lines.Text);
   for I:= 1 to Length(aStr) do
    if ((aStr[I] = #10) or (aStr[I] = #13)) then // Remember TRANSFER (PERE-NOS) for >1024 linelength
     aStr[I]:= ' ';
   try
    try
     Self.AddStatesByNamesStr(aStr, _FormMemoOKCancel);
    except
     MessageDlg('Exception in AddStatesByNamesStr(BitBtnEditAddStatesListClick)', mtWarning, [mbOK], 0);
    end;
   finally
//
   end;
  end;
 end;
end;

procedure T_FormChainEditor.CopyStateNamesClick(Sender: TObject);
var
 I: integer;
 aStr: string;
begin
 fTmpSortedLines.Clear;
 try
  aStr:= '';
  for I:= 0 to Chain.States.Count - 1 do
   fTmpSortedLines.Add(Chain.States[I].Name);
  aStr:= '';
  for I:= 0 to fTmpSortedLines.Count - 1 do
   aStr:= aStr + fTmpSortedLines[I] + ',';
  Clipboard.AsText:= Copy(aStr, 1, Length(aStr) - 1);
 except
  MessageDlg('Exception in CopyStateNamesClick', mtWarning, [mbOK], 0);
 end;
end;

procedure T_FormChainEditor.CheckBoxBuildLinksClick(Sender: TObject);
begin
 if CheckBoxBuildLinks.Checked then
 begin
  CheckBoxCapture.Enabled:= True;
  CheckBoxDecay.Enabled:= True;
  CheckBoxFission.Enabled:= True;
  CheckBoxThreshold.Enabled:= True;
 end
 else
 begin
  CheckBoxCapture.Enabled:= False;
  CheckBoxDecay.Enabled:= False;
  CheckBoxFission.Enabled:= False;
  CheckBoxThreshold.Enabled:= False;
 end;
end;

procedure T_FormChainEditor.SetActiveState(aStatePointer: pointer);
var
 I: integer;
 aState: TCadState;
 Answer: Word;
begin
 fSaveStr:= '';
 if (aStatePointer = nil) then
 begin
  StringGridStateLink.Enabled:= False;
  ButtonDeleteState.Enabled:= False;
 end
 else
 begin
  StringGridStateLink.Enabled:= True;
  ButtonDeleteState.Enabled:= True;
 end;
 aState:= TCadState(aStatePointer);
 if ((ActiveState <> nil) or (ActiveLink <> nil)) then
  if (ButtonToChain.Enabled) then
  begin
   Answer:= MessageDlg('Edited data were not saved to chain ! Save ?', mtWarning, [mbYes, mbNo, mbCancel], 0);
   if (Answer = mrCancel) then
   begin
    if (ActiveState <> nil) then
     ComboBoxStates.Text:= ActiveState.State.Name
    else if (ActiveLink <> nil) then
     ComboBoxLinks.Text:= ActiveLink.Link.Name;
    Exit;
   end
   else if (Answer = mrYes) then
    ButtonToChainClick(Self);
  end;
 ActiveState:= aState;
 ActiveLink:= nil; //qq 3 line
 ComboBoxLinks.ItemIndex:= -1;
 ButtonDeleteLink.Enabled:= False;
 ButtonToChain.Enabled:= False;
 with Self, StringGridStateLink do
 begin
  StringGridStateLink.TopRow:= 1;
  StringGridStateLink.Row:= 1;
  StringGridStateLink.Cols[1].Clear;
  if ActiveState <> nil then
  begin
   ButtonLookInOOB.Enabled:= True;
   StringGridStateLink.Cells[1, 0]:= 'State ' + ActiveState.State.Name;
   for I:= 0 to ComboBoxStates.Items.Count - 1 do
    if ComboBoxStates.Items[I] = ActiveState.State.Name then
    begin
     ComboBoxStates.ItemIndex:= I;
     if (ComboBoxStates.Text = '') then
      ButtonDeleteState.Enabled:= False
     else
      ButtonDeleteState.Enabled:= True;
     break;
    end;
   for I:= 0 to ActiveState.State.ValuesStr.Count - 1 do
    StringGridStateLink.Cells[1, I + 1]:= ActiveState.State.ValuesStr[I];
  end
  else
   ButtonLookInOOB.Enabled:= False;
 end;
end;

procedure T_FormChainEditor.SetActiveLink(aLinkPointer: pointer);
var
 I: integer;
 aLink: TCadLink;
 Answer: Word;
begin
 fSaveStr:= '';
 if (aLinkPointer = nil) then
 begin
  StringGridStateLink.Enabled:= False;
  ButtonDeleteLink.Enabled:= False;
 end
 else
 begin
  StringGridStateLink.Enabled:= True;
  ButtonDeleteLink.Enabled:= True;
 end;
 aLink:= TCadLink(aLinkPointer);
 if ((ActiveState <> nil) or (ActiveLink <> nil)) then
  if (ButtonToChain.Enabled) then
  begin
   Answer:= MessageDlg('Edited data were not saved to chain ! Save ?', mtWarning, [mbYes, mbNo, mbCancel], 0);
   if (Answer = mrCancel) then
    Exit
   else if (Answer = mrYes) then
    ButtonToChainClick(Self);
  end;
 ActiveLink:= aLink;
 ActiveState:= nil; //qq 3 line
 ComboBoxStates.ItemIndex:= -1;
 ButtonDeleteState.Enabled:= False;
 ButtonToChain.Enabled:= False;
 with Self, StringGridStateLink do
 begin
  StringGridStateLink.TopRow:= 1;
  StringGridStateLink.Row:= 1;
  StringGridStateLink.Cols[1].Clear;
  if ActiveLink <> nil then
  begin
   for I:= 0 to ComboBoxLinks.Items.Count - 1 do
    if ComboBoxLinks.Items[I] = ActiveLink.Link.Name then
    begin
     ComboBoxLinks.ItemIndex:= I;
     if (ComboBoxLinks.Text = '') then
      ButtonDeleteLink.Enabled:= False
     else
      ButtonDeleteLink.Enabled:= True;
     break;
    end;
   ButtonLookInOOB.Enabled:= True;
   StringGridStateLink.Cells[1, 0]:= 'Link ' + ActiveLink.Link.Name;
   for I:= 0 to ActiveLink.Link.ValuesStr.Count - 1 do
    StringGridStateLink.Cells[1, I + 1]:= ActiveLink.Link.ValuesStr[I];
  end
  else
   ButtonLookInOOB.Enabled:= False;
 end;
end;

procedure T_FormChainEditor.ButtonRepaintClick(Sender: TObject);
begin
 RepaintCAD;
end;

procedure T_FormChainEditor.AddStatesByNamesStr(const NamesStr: string; Sender: TObject);
const
 Delimiters = [',', ' ', ';', '.', '\', '/', #10, #13];
var
 aNuclideList: TNuclideList;
 aTransitions: TNuclideTransitions;
 I: integer;
// StateNames: TStringList;
 OnCadChangeSave: TNotifyEvent;
 HorScrollBarPosition, VerScrollBarPosition: integer;
 SaveCursor: TCursor;
 SaveCaption: string;
begin
 HorScrollBarPosition:= ScrollBoxCAD.HorzScrollBar.Position;
 VerScrollBarPosition:= ScrollBoxCAD.VertScrollBar.Position;
 if (Sender <> ButtonLoadDB) then
  ButtonLoadDB.SetFocus; // if Sender is edit it will NOT get ReturnKey from MessageDlg
 Application.ProcessMessages;
 if NuclideList.Count < 1 then
  if (MessageDlg('Nuclides were NOT loaded ! States will not be initialized !' + #13 + #10 + 'Use button "LOAD DB" ! Load ?', mtWarning,
   [mbYes, mbNo], 0) = mrYes) then
   ButtonLoadDBClick(Self);
 SaveCursor:= Screen.Cursor;
 Screen.Cursor:= crHourGlass;
 ScrollBoxCAD.Enabled:= False;
 if Assigned(ChainCAD.OnChange) then
 begin
  OnCadChangeSave:= ChainCAD.OnChange;
  ChainCAD.OnChange:= nil;
 end
 else
  OnCadChangeSave:= nil;
 Application.ProcessMessages;
 fAllowPrepareConditions:= False;
 BitBtnEditAddStatesList.Enabled:= False;
 ButtonAddState.Enabled:= False;
 PanelChainRight.Enabled:= False;
 PanelChainBottom.Enabled:= False;
 TabSheetConditions.Enabled:= False;
 TabSheetAnswers.Enabled:= False;
 fTabSheetAnswersEnabled:= False;
 SaveCaption:= Self.Caption;
 Self.Caption:= 'Wait.Chain building ...';
 try
  if NuclideList.Count < 1 then
  begin
   aNuclideList:= nil;
  end
  else
   aNuclideList:= NuclideList;
  aTransitions:= [];
  if CheckBoxBuildLinks.Checked then
  begin
   if CheckBoxCapture.Checked then
    aTransitions:= aTransitions + [ntCapture];
   if CheckBoxDecay.Checked then
    aTransitions:= aTransitions + [ntDecay];
   if CheckBoxFission.Checked then
    aTransitions:= aTransitions + [ntFission];
   if CheckBoxThreshold.Checked then
    aTransitions:= aTransitions + [ntThreshold];
  end;
  StrToStateNamesList(NamesStr, fTmpLines);
  fTmpLines.Sort;
  if fTmpLines.Count > 5 then
   Image.Visible:= False;
  for I:= 0 to fTmpLines.Count - 1 do
   if (Trim(fTmpLines[I]) <> '') then
   begin
    ChainCad.AddStateByName(fTmpLines[I], CheckBoxBuildLinks.Checked, aTransitions, aNuclideList, fTheDataModule);
    repeat
     Application.ProcessMessages;
    until not (ChainCAD.Working);
   end;
 finally
  PanelChainRight.Enabled:= True;
  BitBtnEditAddStatesList.Enabled:= True;
  if Trim(EditState.Text) <> '' then
   ButtonAddState.Enabled:= True;
  PanelChainBottom.Enabled:= True;
  TabSheetConditions.Enabled:= True;
  TabSheetAnswers.Enabled:= True;
  fTabSheetAnswersEnabled:= True;
  fNeedPrepareConditions:= True;
  fAllowPrepareConditions:= True;
  SetImageSize(ChainCAD.Width, ChainCAD.Height);
  Image.Visible:= True;
  if Assigned(OnCadChangeSave) then
  begin
   ChainCAD.OnChange:= OnCadChangeSave;
   ChainCAD.OnChange(Self);
  end;
  Self.Caption:= SaveCaption;
  ScrollBoxCAD.Enabled:= True;
  if (HorScrollBarPosition < Image.Width) then
   ScrollBoxCAD.HorzScrollBar.Position:= HorScrollBarPosition;
  if (VerScrollBarPosition < Image.Height) then
   ScrollBoxCAD.VertScrollBar.Position:= VerScrollBarPosition;
  Screen.Cursor:= SaveCursor;
 end;
end;

procedure T_FormChainEditor.ButtonAddStateClick(Sender: TObject);
begin
 try
  AddStatesByNamesStr(EditState.Text, Sender);
 finally
//
 end;
end;

procedure T_FormChainEditor.ButtonClearChainEditorClick(Sender: TObject);
var
 I: integer;
 OnCadChangeSave: TNotifyEvent;
begin
 if Assigned(ChainCAD.OnChange) then
 begin
  OnCadChangeSave:= ChainCAD.OnChange;
  ChainCAD.OnChange:= nil;
 end
 else
  OnCadChangeSave:= nil;
 for I:= ChainCAD.States.Count - 1 downto 0 do
  ChainCAD.DeleteState(ChainCAD.States[I]);
 for I:= Chain.Links.Count - 1 downto 0 do
  Chain.DeleteLink(Chain.Links[I]);
 EditState.Text:= '';
 ButtonAddState.Enabled:= False;
 ComboBoxStates.Text:= '';
 ButtonDeleteState.Enabled:= False;
 EditLinkStart.Text:= '';
 EditLinkFinish.Text:= '';
 ComboBoxLinks.Text:= '';
 ButtonAddLink.Enabled:= False;
 ButtonDeleteLink.Enabled:= False;
 SetActiveState(nil);
 SetActiveLink(nil);
 if Assigned(OnCadChangeSave) then
 begin
  ChainCAD.OnChange:= OnCadChangeSave;
  ChainCAD.OnChange(Self);
 end;
 SetImageSize(1, 1);
 LabelChainFileName.Caption:= '';
end;

procedure T_FormChainEditor.ButtonLoadDBClick(Sender: TObject);
var
 SaveCursor: TCursor;
 SaveCaption: string;
begin
 SaveCaption:= Self.Caption;
 Self.Caption:= ' Data loading...';
 SaveCursor:= Screen.Cursor;
 Screen.Cursor:= crHourGlass;
 Self.Enabled:= False;
 try
  if FileExists('ORIP_XXI.oob') then
   T_DataModuleOOB(fTheDataModule).DatabaseName:= 'ORIP_XXI.oob'
  else if FileExists(fApplicationExePath + 'ORIP_XXI.oob') then
   T_DataModuleOOB(fTheDataModule).DatabaseName:= fApplicationExePath + 'ORIP_XXI.oob'
  else
  begin
   T_DataModuleOOB(fTheDataModule).DatabaseName:= '  '
  end;
  NuclideList.LoadFromDB(T_DataModuleOOB(fTheDataModule), ProgressBarLoad);
 finally
  repeat
   Application.ProcessMessages;
  until not (T_DataModuleOOB(fTheDataModule).LoadInProgress);
  Screen.Cursor:= SaveCursor;
  Self.Caption:= SaveCaption;
  Self.Enabled:= True;
  Application.ProcessMessages;
 end;
end;

procedure T_FormChainEditor.ImageMouseUp(Sender: TObject;
 Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 N: integer;
 ScreenPoint: TPoint;
begin
 ScreenPoint.X:= X;
 ScreenPoint.Y:= Y;
 ScreenPoint:= Image.ClientToScreen(ScreenPoint);
 begin
  N:= ChainCad.FindStateAtXY(X, Y);
  if N >= 0 then
  begin
   SetActiveState(ChainCad.States[N]);
   if (mbRight = Button) then
    PopupMenuCAD.Popup(ScreenPoint.X, ScreenPoint.Y);
   Exit;
  end;
  N:= ChainCad.FindLinkAtXY(X, Y);
  if N >= 0 then
   SetActiveLink(ChainCad.Links[N]);
 end;
 if (mbRight = Button) then
  PopupMenuCAD.Popup(ScreenPoint.X, ScreenPoint.Y);
end;

procedure T_FormChainEditor.ButtonAddLinkClick(Sender: TObject);
var
 aTransitions: TNuclideTransitions;
 HorScrollBarPosition, VerScrollBarPosition: integer;
begin
 HorScrollBarPosition:= ScrollBoxCAD.HorzScrollBar.Position;
 VerScrollBarPosition:= ScrollBoxCAD.VertScrollBar.Position;
 aTransitions:= [];
 if CheckBoxCapture.Checked then
  aTransitions:= aTransitions + [ntCapture];
 if CheckBoxDecay.Checked then
  aTransitions:= aTransitions + [ntDecay];
 if CheckBoxFission.Checked then
  aTransitions:= aTransitions + [ntFission];
 if CheckBoxThreshold.Checked then
  aTransitions:= aTransitions + [ntThreshold];
 ChainCad.AddLinkByName(EditLinkStart.Text, EditLinkFinish.Text, True, aTransitions, NuclideList, T_DataModuleOOB(fTheDataModule));
 EditLinkStartEndChange(Self);
 if (HorScrollBarPosition < Image.Width) then
  ScrollBoxCAD.HorzScrollBar.Position:= HorScrollBarPosition;
 if (VerScrollBarPosition < Image.Height) then
  ScrollBoxCAD.VertScrollBar.Position:= VerScrollBarPosition;
end;

procedure T_FormChainEditor.RepaintCAD;
var
 VscrollPos, HscrollPos: integer;
begin
 VscrollPos:= ScrollBoxCAD.VertScrollBar.ScrollPos;
 HscrollPos:= ScrollBoxCAD.HorzScrollBar.ScrollPos;
 Image.Visible:= False;
 Image.Canvas.Brush.Color:= clWhite;
 Image.Canvas.FillRect(Image.Canvas.ClipRect);
 ChainCad.PaintStates;
 ChainCad.PaintLinks;
 Image.Visible:= True;
 ScrollBoxCAD.VertScrollBar.Position:= VscrollPos;
 ScrollBoxCAD.HorzScrollBar.Position:= HscrollPos;
end;

procedure T_FormChainEditor.OnCadChange(Sender: TObject);
var
 ImagePosition: TPoint;
begin
 ImagePosition.x:= ScrollBoxCad.HorzScrollBar.Position;
 ImagePosition.y:= ScrollBoxCad.VertScrollBar.Position;
 Image.Visible:= False;
 Application.ProcessMessages;
 RepaintCAD;
 GroupBoxStates.Caption:= '&States (' + IntToStr(ChainCAD.States.Count) + ')';
 GroupBoxLinks.Caption:= '&Links (' + IntToStr(ChainCAD.Links.Count) + ')';
 ChainCad.ListStates(fTmpLines);
 fTmpLines.Sort;
 ComboBoxStates.Items.Assign(fTmpLines);
 EditLinkStart.Items.Assign(fTmpLines);
 EditLinkFinish.Items.Assign(fTmpLines);
 ChainCad.ListLinks(fTmpLines);
 fTmpLines.Sort;
 ComboBoxLinks.Items.Assign(fTmpLines);
 ComboBoxLinks.DropDownCount:= 20;
 SetImageSize(ChainCAD.Width, ChainCAD.Height);
 fNeedNewCalculator:= True;
 fNeedToBuildSSK_TableList:= True;
 fChainCalculated:= False;
 Application.ProcessMessages;
 Image.Visible:= True;
 try
  ScrollBoxCad.HorzScrollBar.Position:= ImagePosition.x;
  ScrollBoxCad.VertScrollBar.Position:= ImagePosition.y;
 except
  ScrollBoxCad.HorzScrollBar.Position:= 0;
  ScrollBoxCad.VertScrollBar.Position:= 0;
 end;
end;

procedure T_FormChainEditor.ComboBoxStatesChange(Sender: TObject);
begin
 if (ComboBoxStates.Text = '') then
  ButtonDeleteState.Enabled:= False
 else
  ButtonDeleteState.Enabled:= True;
 SetActiveState(ChainCad.FindStateByName(ComboBoxStates.Text));
end;

procedure T_FormChainEditor.ButtonDeleteStateClick(Sender: TObject);
var
 HorScrollBarPosition, VerScrollBarPosition: integer;
 SaveCursor: TCursor;
begin
 SaveCursor:= Screen.Cursor;
 Screen.Cursor:= crHourGlass;
 try
  HorScrollBarPosition:= ScrollBoxCAD.HorzScrollBar.Position;
  VerScrollBarPosition:= ScrollBoxCAD.VertScrollBar.Position;
  ActiveState:= ChainCad.FindStateByName(ComboBoxStates.Text);
  if ActiveState <> nil then
  begin
   if fShiftPressed then
   begin
    if (MessageDlg('The ' + ComboBoxStates.Text + ' state will be deleted(+). Are you sure ?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
    begin
     ChainCAD.DeleteStateEx(ActiveState);
     SetActiveState(nil);
     ButtonDeleteState.Enabled:= False;
     fShiftPressed:= False;
    end;
   end
   else
   begin
    if (MessageDlg('The ' + ComboBoxStates.Text + ' state will be deleted. Are you sure ?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
    begin
     ChainCAD.DeleteState(ActiveState);
     SetActiveState(nil);
     ButtonDeleteState.Enabled:= False;
    end;
   end;
  end;
  if (HorScrollBarPosition < Image.Width) then
   ScrollBoxCAD.HorzScrollBar.Position:= HorScrollBarPosition;
  if (VerScrollBarPosition < Image.Height) then
   ScrollBoxCAD.VertScrollBar.Position:= VerScrollBarPosition;
 finally
  fNeedNewCalculator:= True;
  fNeedPrepareConditions:= True;
  Screen.Cursor:= SaveCursor;
 end;
end;

procedure T_FormChainEditor.ButtonDeleteLinkClick(Sender: TObject);
var
 HorScrollBarPosition, VerScrollBarPosition: integer;
 SaveCursor: TCursor;
begin
 if (MessageDlg('The ' + ComboBoxLinks.Text + ' link will be deleted. Are you sure ?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
 begin
  SaveCursor:= Screen.Cursor;
  Screen.Cursor:= crHourGlass;
  try
   HorScrollBarPosition:= ScrollBoxCAD.HorzScrollBar.Position;
   VerScrollBarPosition:= ScrollBoxCAD.VertScrollBar.Position;
   ActiveLink:= ChainCad.FindLinkByName(ComboBoxLinks.Text);
   if ActiveLink <> nil then
   begin
    ChainCAD.DeleteLink(ActiveLink);
    SetActiveLink(nil);
    ButtonDeleteLink.Enabled:= False;
   end;
   if (HorScrollBarPosition < Image.Width) then
    ScrollBoxCAD.HorzScrollBar.Position:= HorScrollBarPosition;
   if (VerScrollBarPosition < Image.Height) then
    ScrollBoxCAD.VertScrollBar.Position:= VerScrollBarPosition;
  finally
   Screen.Cursor:= SaveCursor;
  end;
 end;
end;

procedure T_FormChainEditor.EditLinkStartEndChange(Sender: TObject);
begin
 if ((Trim(EditLinkStart.Text) <> '') and (Trim(EditLinkFinish.Text) <> '') and
  (Trim(EditLinkStart.Text) <> Trim(EditLinkFinish.Text))) then
 begin
  if (ChainCad.FindLinkByName(EditLinkStart.Text + '->' + EditLinkFinish.Text) = nil) then
   ButtonAddLink.Enabled:= True
  else
   ButtonAddLink.Enabled:= False;
 end
 else
  ButtonAddLink.Enabled:= False;
(*
 if ((Trim(EditLinkStart.Text) <> '') and (Trim(EditLinkFinish.Text) <> '') and
  (Trim(EditLinkStart.Text) <> Trim(EditLinkFinish.Text))) then
  ButtonAddLink.Enabled:= True
 else
  ButtonAddLink.Enabled:= False;
*)
end;

procedure T_FormChainEditor.ComboBoxLinksChange(Sender: TObject);
begin
 if (Trim(ComboBoxLinks.Text) <> '') then
 begin
  ButtonDeleteLink.Enabled:= True;
  SetActiveLink(ChainCad.FindLinkByName(ComboBoxLinks.Text));
 end
 else
 begin
  ButtonDeleteLink.Enabled:= False;
  SetActiveLink(nil);
 end;
end;

procedure T_FormChainEditor.ButtonLookInOOBClick(Sender: TObject);
begin
 LookInOOB_InfoForm;
end;

procedure T_FormChainEditor.LookInOOB_InfoForm;
var
 I, J, ThZpA_s, ThZpA_sStart, ThZpA_sFinish: integer;
 Name: string;
 ChainState: TChainState;
 aTransitions: TNuclideTransitions;
 IsLink, IsCumYield: Boolean;
begin
 if NuclideList.Count < 1 then
  ButtonLoadDBClick(Self);
 IsLink:= False;
 if (Pos('State', Self.StringGridStateLink.Cells[1, 0]) > 0) then
 begin
  IsLink:= False;
  if ActiveState <> nil then
  begin
   ThZpA_s:= StrToThZpA_s(ActiveState.State.Name);
   fTmpLines.Clear;
   if NuclideList <> nil then
    if NuclideList.FindThZpA_s(ThZpA_s, I, J) then
    begin
//     ChainState:= TChainState.CreateFromNuclideState(nil, NuclideList[I].StateList[J]);
     ChainState:= TChainState.CreateFromNuclideState(nil, NuclideList[I].StateList[J], fTheDataModule);
     fTmpLines.Assign(ChainState.ValuesStr);
    end;
  end;
 end
 else if (Pos('Link', Self.StringGridStateLink.Cells[1, 0]) > 0) then
 begin
  IsLink:= True;
  IsCumYield:= True;
  for I:= 0 to StringGridStateLink.Cols[1].Count - 1 do
   if (Pos('INDYIELD', UpperCase(StringGridStateLink.Cells[1, I])) > 0) then
   begin
    IsCumYield:= False;
    break;
   end;
  fTmpLines.Clear;
  Name:= ActiveLink.Link.Name;
  I:= Pos('->', Name);
  ThZpA_sStart:= StrToThZpA_s(Copy(Name, 1, I - 1));
  ThZpA_sFinish:= StrToThZpA_s(Copy(Name, I + 2, Length(Name)));
  aTransitions:= AllNuclideTransitions; //  aTransitions:= [ntCapture, ntDecay, ntFission, ntThreshold];
(*
  aTransitions:= [];
  if CheckBoxBuildLinks.Checked then begin
   if CheckBoxCapture.Checked then
    aTransitions:= aTransitions+ [ntCapture];
   if CheckBoxDecay.Checked then
    aTransitions:= aTransitions+ [ntDecay];
   if CheckBoxFission.Checked then
    aTransitions:= aTransitions+ [ntFission];
   if CheckBoxThreshold.Checked then
    aTransitions:= aTransitions+ [ntThreshold];
  end;
*)
  if NuclideList <> nil then
   if NuclideList.FindThZpA_s(ThZpA_sStart, I, J) then
    if NuclideList.FindThZpA_s(ThZpA_sFinish, I, J) then
    begin
     NuclideList.GetLink(ThZpA_sStart, ThZpA_sFinish, fTmpLines, aTransitions, fTheDataModule, IsCumYield);
    end;
 end;
 with _FormLookInOOB do
 begin
  _FormLookInOOB.StringGridLook.RowCount:= fTmpLines.Count;
  _FormLookInOOB.StringGridLook.FixedRows:= 0;
  _FormLookInOOB.StringGridLook.ColCount:= 2;
  _FormLookInOOB.StringGridLook.ColWidths[0]:= 15;
  _FormLookInOOB.StringGridLook.ColWidths[1]:= StringGridLook.Width - 25;
  _FormLookInOOB.StringGridLook.FixedCols:= 1;
  if IsLink then
  begin
   for I:= 0 to _FormLookInOOB.StringGridLook.RowCount - 1 do
    if I < 2 then
     _FormLookInOOB.StringGridLook.Cells[0, I]:= ''
    else
     _FormLookInOOB.StringGridLook.Cells[0, I]:= IntToStr(I - 1);
  end
  else
  begin // State ?
   for I:= 0 to StringGridLook.RowCount - 1 do
    _FormLookInOOB.StringGridLook.Cells[0, I]:= IntToStr(I + 1);
  end;
  _FormLookInOOB.StringGridLook.ColCount:= 2;
  _FormLookInOOB.StringGridLook.FixedCols:= 1;
  _FormLookInOOB.StringGridLook.FixedRows:= 0;
  _FormLookInOOB.Caption:= Self.StringGridStateLink.Cells[1, 0] +
   '          To close press Esc';
  _FormLookInOOB.StringGridLook.Cols[1].Assign(fTmpLines);
  Show;
 end;
end;

procedure T_FormChainEditor.ButtonToChainClick(Sender: TObject);
var
 I, RowsWithValuesCount: integer;
begin
 fTmpLines.Clear;
 with StringGridStateLink do
 begin
  if (Pos('DECAY', UpperCase(StringGridStateLink.Cells[1, 1])) <= 0) then
   StringGridStateLink.Cells[1, 1]:= StringGridStateLink.Cells[1, 1] + ' // Decay'; // Lamda 0r T1_2
  if (Pos('THERMAL', UpperCase(StringGridStateLink.Cells[1, 2])) <= 0) then
   StringGridStateLink.Cells[1, 2]:= StringGridStateLink.Cells[1, 2] + ' // THERMAL';
  if (Pos('RESONANCE', UpperCase(StringGridStateLink.Cells[1, 3])) <= 0) then
   StringGridStateLink.Cells[1, 3]:= StringGridStateLink.Cells[1, 3] + ' // RESONANCE';
  if (Pos('FAST', UpperCase(StringGridStateLink.Cells[1, 4])) <= 0) then
   StringGridStateLink.Cells[1, 4]:= StringGridStateLink.Cells[1, 4] + ' // FAST';
  if (Pos('G_FACTOR', UpperCase(StringGridStateLink.Cells[1, 5])) <= 0) then
   StringGridStateLink.Cells[1, 5]:= StringGridStateLink.Cells[1, 5] + ' // G_FACTOR';
  RowsWithValuesCount:= StringGridStateLink.RowCount - 1;
  for I:= StringGridStateLink.RowCount - 1 downto 1 do
   if Trim(StringGridStateLink.Cells[1, I]) = '' then
    Dec(RowsWithValuesCount)
   else
    break;
  if (Pos('State', Self.StringGridStateLink.Cells[1, 0]) > 0) then
  begin
   if ActiveState <> nil then
   begin
    for I:= 1 to RowsWithValuesCount do
     fTmpLines.Add(StringGridStateLink.Cells[1, I]);
    ActiveState.State.ValuesStr.Assign(fTmpLines);
    ButtonToChain.Enabled:= False;
   end;
  end
  else if (Pos('Link', Self.StringGridStateLink.Cells[1, 0]) > 0) then
   if ActiveLink <> nil then
   begin
    for I:= 1 to RowsWithValuesCount do
     fTmpLines.Add(StringGridStateLink.Cells[1, I]);
    ActiveLink.Link.ValuesStr.Assign(fTmpLines);
    ButtonToChain.Enabled:= False;
   end;
 end;
 if Assigned(ChainCAD.OnChange) then
  ChainCAD.OnChange(Self);
end;

procedure T_FormChainEditor.ButtonSaveChainClick(Sender: TObject);
var
 OldFilterIndex: integer;
 OldExt: string;
begin
 with SaveDialog do
 begin
  OldFilterIndex:= FilterIndex;
  OldExt:= DefaultExt;
  DefaultExt:= 'chn';
  FilterIndex:= 1;
  FileName:= '';
  if Execute then
  begin
   if not (ChainCAD.SaveChainToFile(FileName)) then
    MessageDlg('Some problems with save !!!', mtWarning, [mbOK], 0)
   else
    LabelChainFileName.Caption:= 'Chain file:' + FileName;
  end;
  DefaultExt:= OldExt;
  FilterIndex:= OldFilterIndex;
  LabelChainFileName.Caption:= 'Chain file:' + FileName;
 end;
end;

procedure T_FormChainEditor.ButtonLoadChainClick(Sender: TObject);
var
 I, OldFilterIndex: integer;
 OldExt, SaveCaption: string;
 OnCadChangeSave: TNotifyEvent;
 SaveCursor: TCursor;
begin
 with OpenDialog do
 begin
  OldFilterIndex:= FilterIndex;
  OldExt:= DefaultExt;
  DefaultExt:= 'chn';
  FilterIndex:= 1;
  FileName:= '';
  try
   if Execute then
   begin
    SaveCaption:= Self.Caption;
    Self.Caption:= 'Wait.Chain loading ' + FileName + '  ...';
    SaveCursor:= Screen.Cursor;
    Screen.Cursor:= crHourGlass;
    ScrollBoxCAD.Enabled:= False;
    Image.Visible:= False;
    if Assigned(ChainCAD.OnChange) then
    begin
     OnCadChangeSave:= ChainCAD.OnChange;
     ChainCAD.OnChange:= nil;
    end
    else
     OnCadChangeSave:= nil;
    Application.ProcessMessages;
    try
     ButtonToChain.Enabled:= False; // To prevent 'Save edited?' question
     for I:= ChainCAD.States.Count - 1 downto 0 do
      ChainCAD.DeleteState(ChainCAD.States[I]);
     for I:= Chain.Links.Count - 1 downto 0 do
      Chain.DeleteLink(Chain.Links[I]);
     if not (ChainCAD.LoadChainFromFile(FileName)) then
      MessageDlg('Some problems for load !!!' + #10#13 +
       ' FileName = ' + FileName, mtWarning, [mbOK], 0)
     else
      LabelChainFileName.Caption:= 'Chain file:' + FileName;
     SetActiveState(nil);
     SetActiveLink(nil);
    finally
     fNeedPrepareConditions:= True;
     SetImageSize(ChainCAD.Width, ChainCAD.Height);
     Image.Visible:= True;
     if Assigned(OnCadChangeSave) then
     begin
      ChainCAD.OnChange:= OnCadChangeSave;
      ChainCAD.OnChange(Self);
     end;
     ScrollBoxCAD.Enabled:= True;
     Screen.Cursor:= SaveCursor;
     Self.Caption:= SaveCaption;
    end;
   end;
  finally
   DefaultExt:= OldExt;
   FilterIndex:= OldFilterIndex;
   Self.FocusControl(ButtonLoadChain);
  end;
 end;
end;

procedure T_FormChainEditor.EditStateKeyUp(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
 if Trim(EditState.Text) = '' then
  ButtonAddState.Enabled:= False
 else
  ButtonAddState.Enabled:= True;
 if Key = VK_RETURN then
  ButtonAddStateClick(Self);
end;

procedure T_FormChainEditor.StringGridStateLinkKeyDown(Sender: TObject;
 var Key: Word; Shift: TShiftState);
begin
 if Key = VK_ESCAPE then
 begin
  with StringGridStateLink do
   StringGridStateLink.Cells[StringGridStateLink.Col, StringGridStateLink.Row]:= fSaveStr;
 end
// Ctrl+Ins or Ctrl+C
 else if (not (ssAlt in Shift) and
  (ssCtrl in Shift) and (Key = VK_INSERT) or (Key = Ord('C'))) then
 begin
  CopyToClipboardFromStringGrid(StringGridStateLink);
 end;
end;

procedure T_FormChainEditor.StringGridStateLinkSelectCell(Sender: TObject;
 ACol, ARow: Integer; var CanSelect: Boolean);
begin
 fSaveStr:= StringGridStateLink.Cells[ACol, ARow];
end;

procedure T_FormChainEditor.StringGridStateLinkUserChangedCell(
 Sender: TObject; ACol, ARow: Integer; const Value: string);
var
 aStr, aUpperValue: string;
 aFloat: Float;
 PrepareToParseResult: Boolean;
begin
 aUpperValue:= UpperCase(Value);
 if ((ARow > 1) and (ARow < 5)) or ((Pos('SIGMA', aUpperValue) > 0) or (Pos('RI', aUpperValue) > 0) or
  (Pos('THERM', aUpperValue) > 0) or (Pos('RESON', aUpperValue) > 0) or
  (Pos('FISS', aUpperValue) > 0) or (Pos('FAST', aUpperValue) > 0)) then
 begin // must be barns
  PrepareToParseResult:= PrepareToParse(aUpperValue, aStr);
  if not (PrepareToParseResult) then
  begin
   StringGridStateLink.SetFocus;
   raise Exception.Create('Cannot parse string "' + Trim(Value) + '" ' + #10#13 +
    '  Row = ' + IntToStr(aRow) + ' (Name = ' + Trim(StringGridStateLink.Cells[0, aRow]) + ')');
   Exit;
  end;
  try
   aFloat:= GetFormulaValue(aStr);
   if (aFloat > 1E-10) then // 1e14 barn
    MessageDlg('Line ' + IntToStr(ARow) + ' (Name = ' + Trim(StringGridStateLink.Cells[0, aRow]) + ')' +
     ' is "' + Value + '"' + #10#13 + ' equal to ' + Format('%-7.5g', [aFloat]) + #10#13 + 'May be barn symbol (b) was missing!', mtWarning, [mbOK], 0);
  except
   MessageDlg('Line ' + IntToStr(ARow) + ' (Name = ' + Trim(StringGridStateLink.Cells[0, aRow]) + ')' +
    ' is "' + Value + '"' + #10#13 + #10#13 + 'Cannot parse it !!!', mtError, [mbOK], 0);
  end;
 end
 else if (ARow = 5) then
 begin // must be g_factor
  PrepareToParseResult:= PrepareToParse(aUpperValue, aStr);
  if not (PrepareToParseResult) then
  begin
   StringGridStateLink.SetFocus;
   raise Exception.Create('Cannot parse string "' + Trim(Value) + '" ' + #10#13 +
    '  Row = ' + IntToStr(aRow) + ' (Name = ' + Trim(StringGridStateLink.Cells[0, aRow]) + ')');
   Exit;
  end;
  try
   aFloat:= GetFormulaValue(aStr);
   if ((aFloat < 0.5) or (aFloat > 1.5)) then // 1e14 barn
    MessageDlg('Line ' + IntToStr(ARow) + ' (Name = ' + Trim(StringGridStateLink.Cells[0, aRow]) + ')' +
     ' is "' + Value + '"' + #10#13 + ' equal to ' + Format('%-7.5g', [aFloat]) + #10#13 + 'Too doubtful!', mtWarning, [mbOK], 0);
  except
   MessageDlg('Line ' + IntToStr(ARow) + ' (Name = ' + Trim(StringGridStateLink.Cells[0, aRow]) + ')' +
    ' is "' + Value + '"' + #10#13 + #10#13 + 'Cannot parse it !!!', mtError, [mbOK], 0);
  end;
 end;
 ButtonToChain.Enabled:= True;
end;

procedure T_FormChainEditor.ChaingAllCumYieldsForDecayChildsWithParentsOnIndYields;
var
 I, J, K: integer;
 IsProduct: Boolean;
 ParentList: TLongIntList;
 SaveCursor: TCursor;
 OnCadChangeSave: TNotifyEvent;
begin
 ParentList:= TLongIntList.Create;
 SaveCursor:= Screen.Cursor;
 Screen.Cursor:= crHourGlass;
 OnCadChangeSave:= ChainCAD.OnChange;
 try
  for I:= 0 to ChainCAD.States.Count - 1 do
  begin
   IsProduct:= False;
   for K:= 0 to ChainCAD.Links.Count - 1 do
   begin
    if (ChainCAD.Links[K].Finish = ChainCAD.States[I]) then
//     qq
     for J:= 0 to ChainCAD.Links[K].Link.ValuesStr.Count - 1 do
      if (Pos('YIELD', UpperCase(ChainCAD.Links[K].Link.ValuesStr[J])) > 0) then
      begin
       IsProduct:= True;
       break;
       if IsProduct then
        break;
      end;
   end;
   if IsProduct then
   begin
    Chain.FindDecayParentsWithNonZeroFissionYields(ChainCAD.States[I].State.ThZpA_s, ParentList, NuclideList);
    if ParentList.Count > 0 then
    begin
     ActiveState:= ChainCAD.States[I];
     ItemUseIndYieldsForStateClick(Self);
    end;
   end;
  end;
 finally
  ParentList.Free;
  if ActiveLink <> nil then
   SetActiveLink(ActiveLink);
  ChainCAD.OnChange:= OnCadChangeSave;
  Screen.Cursor:= SaveCursor;
 end;
end;

procedure T_FormChainEditor.ChaingAllIndYieldsForDecayChildsWithOutParentsOnCumYields;
var
 I, J, K: integer;
 IsProduct: Boolean;
 ParentList: TLongIntList;
 SaveCursor: TCursor;
 OnCadChangeSave: TNotifyEvent;
begin
 ParentList:= TLongIntList.Create;
 SaveCursor:= Screen.Cursor;
 Screen.Cursor:= crHourGlass;
 OnCadChangeSave:= ChainCAD.OnChange;
 try
  for I:= 0 to ChainCAD.States.Count - 1 do
  begin
   IsProduct:= False;
   for K:= 0 to ChainCAD.Links.Count - 1 do
   begin
    if (ChainCAD.Links[K].Finish = ChainCAD.States[I]) then
//     qq
     for J:= 0 to ChainCAD.Links[K].Link.ValuesStr.Count - 1 do
      if (Pos('YIELD', UpperCase(ChainCAD.Links[K].Link.ValuesStr[J])) > 0) then
      begin
       IsProduct:= True;
       break;
       if IsProduct then
        break;
      end;
   end;
   if IsProduct then
   begin
    Chain.FindDecayParentsWithNonZeroFissionYields(ChainCAD.States[I].State.ThZpA_s, ParentList, NuclideList);
    if ParentList.Count = 0 then
    begin
     ActiveState:= ChainCAD.States[I];
     ItemUseCumYieldsForStateClick(Self);
    end;
   end;
  end;
 finally
  ParentList.Free;
  ChainCAD.OnChange:= OnCadChangeSave;
  Screen.Cursor:= SaveCursor;
 end;
end;

// Popup Menu

procedure T_FormChainEditor.PopupMenuCADPopup(Sender: TObject);
begin
 if (ActiveState <> nil) then
 begin
  ItemUseIndYieldsForState.Caption:= 'Use &IndYields for ' + ActiveState.State.Name;
  ItemUseCumYieldsForState.Caption:= 'Use &CumYields for ' + ActiveState.State.Name;
  if ActiveState.State.ThZpA_s < 870000 then
  begin // fission product
   ItemUseIndYieldsForState.Enabled:= True;
   ItemUseCumYieldsForState.Enabled:= True;
  end
  else
  begin
   ItemUseIndYieldsForState.Enabled:= False;
   ItemUseCumYieldsForState.Enabled:= False;
  end;
  ItemAddStateChilds.Caption:= 'Add ' + ActiveState.State.Name + ' &descendants';
  ItemAddStateChilds.Enabled:= True;
 end
 else
 begin
  ItemUseIndYieldsForState.Caption:= 'Use &IndYields';
  ItemUseIndYieldsForState.Enabled:= False;
  ItemUseCumYieldsForState.Caption:= 'Use &CumYields';
  ItemUseCumYieldsForState.Enabled:= False;
  ItemAddStateChilds.Caption:= 'Add descendants';
  ItemAddStateChilds.Enabled:= False;
 end;
 ItemSaveMetafile.Enabled:= False;
 if (ChainCAD <> nil) then
  if ChainCAD.States.Count > 0 then
   ItemSaveMetafile.Enabled:= True;
end;

procedure T_FormChainEditor.ItemShowHalfLifesClick(Sender: TObject);
begin
 ItemShowHalfLifes.Checked:= not (ItemShowHalfLifes.Checked);
 ChainCAD.ShowHalfLife:= ItemShowHalfLifes.Checked;
 RepaintCAD;
end;

procedure T_FormChainEditor.ItemHidefissionlinksClick(Sender: TObject);
begin
 ItemHidefissionlinks.Checked:= not (ItemHidefissionlinks.Checked);
 ChainCAD.DrawFissionLinks:= not (ItemHidefissionlinks.Checked);
 RepaintCAD;
end;

procedure T_FormChainEditor.ItemUseIndYieldsForStateClick(Sender: TObject);
var
 NoInChain, ValueStrNo, TmpLinesStrNo, I: integer;
 GetLinkResult: DWORD;
 aTransitions: TNuclideTransitions;
begin
 if NuclideList.Count < 1 then
 begin
  MessageDlg('Nuclides were NOT loaded ! Yields will not be initialized !' + #13 + #10 + 'Use button "LOAD DB"!', mtWarning,
   [mbOK], 0);
  Exit;
 end;
 if (ActiveState <> nil) then
 begin
  NoInChain:= Chain.FindState(ActiveState.State.ThZpA_s);
  if (NoInChain >= 0) then
  begin
   aTransitions:= [ntFission];
   if (NoInChain >= 0) then
    for I:= 0 to Chain.Links.Count - 1 do
     if (Chain.Links[I].FinishThZpA_s = ActiveState.State.ThZpA_s) then
     begin
      fTmpLines.Clear;
      GetLinkResult:= NuclideList.GetLink(Chain.Links[I].StartThZpA_s, Chain.Links[I].FinishThZpA_s, fTmpLines, aTransitions, fTheDataModule, False);
      if (((sltThermal and GetLinkResult) > 0) or ((sltResonance and GetLinkResult) > 0) or ((sltFast and GetLinkResult) > 0)) then
      begin
// THERMAL
       for TmpLinesStrNo:= 0 to fTmpLines.Count - 1 do
        if (Pos('THERMAL', UpperCase(fTmpLines[TmpLinesStrNo])) > 0) then
         for ValueStrNo:= 0 to Chain.Links[I].ValuesStr.Count - 1 do
          if (Pos('THERMAL', UpperCase(Chain.Links[I].ValuesStr[ValueStrNo])) > 0) then
           Chain.Links[I].ValuesStr[ValueStrNo]:= fTmpLines[TmpLinesStrNo];
// RESONANCE
       for TmpLinesStrNo:= 0 to fTmpLines.Count - 1 do
        if (Pos('RESONANCE', UpperCase(fTmpLines[TmpLinesStrNo])) > 0) then
         for ValueStrNo:= 0 to Chain.Links[I].ValuesStr.Count - 1 do
          if (Pos('RESONANCE', UpperCase(Chain.Links[I].ValuesStr[ValueStrNo])) > 0) then
           Chain.Links[I].ValuesStr[ValueStrNo]:= fTmpLines[TmpLinesStrNo];
// FAST
       for TmpLinesStrNo:= 0 to fTmpLines.Count - 1 do
        if (Pos('FAST', UpperCase(fTmpLines[TmpLinesStrNo])) > 0) then
         for ValueStrNo:= 0 to Chain.Links[I].ValuesStr.Count - 1 do
          if (Pos('FAST', UpperCase(Chain.Links[I].ValuesStr[ValueStrNo])) > 0) then
           Chain.Links[I].ValuesStr[ValueStrNo]:= fTmpLines[TmpLinesStrNo];
      end;
     end;
  end;
  ActiveState:= nil;
  ActiveState:= ChainCAD.States[NoInChain];
 end;
end;

//                      Chain Page END

// Conditions Page start
// Conditions - Uslovija obluchenija i rascheta

procedure T_FormChainEditor.RadioGroupCellTypeClick(Sender: TObject);
begin
 if (Pos('Simple', RadioGroupCellType.Items[RadioGroupCellType.ItemIndex]) > 0) then
 begin
  LabelSkin_V.Visible:= False;
  EditSkin_V.Visible:= False;
  LabelOM_V.Visible:= False;
  EditOM_V.Visible:= False;
 end
 else
 begin
  LabelSkin_V.Visible:= True;
  EditSkin_V.Visible:= True;
  LabelOM_V.Visible:= True;
  EditOM_V.Visible:= True;
 end;
end;

procedure T_FormChainEditor.StringGridRA_RsGetCellFormat(Sender: TObject;
 Col, Row: Integer; State: TGridDrawState;
 var FormatOptions: TFormatOptions; var CheckBox, Combobox,
 Ellipsis: Boolean);
begin
 if Row > 0 then
  if Col = 1 then
   checkbox:= True;
end;

procedure T_FormChainEditor.StringGridRA_RsDblClick(Sender: TObject);
begin
 FillRA_RsInfoForm;
end;

(*
procedure EmptyMouseQueue;
var
 Msg: TMsg;
begin
 while PeekMessage(Msg, 0, WM_MOUSEFIRST, WM_MOUSELAST,
  PM_REMOVE or PM_NOYIELD)
  do ;
end;
*)

procedure T_FormChainEditor.FillRA_RsInfoForm;
var
 I, aThZpA_s: integer;
 aResonanceInfoList: TResonanceInfoList;
 aResonanceInfo: TResonanceInfo;
 SaveCursor: TCursor;
begin
 SaveCursor:= Screen.Cursor;
 Screen.Cursor:= crHourGlass;
 try
  if (fStringGridRA_RsStateName <> '') then
  begin
   aThZpA_s:= StrToThZpA_s(fStringGridRA_RsStateName);
   if (Resonances4ThZpA_sLoaded(aThZpA_s) > 0) then
   begin
    aResonanceInfoList:= TResonanceInfoList.Create;
    with _FormLookInOOB do
     try
      FillResonancesInfoList(aThZpA_s, aResonanceInfoList);
      _FormLookInOOB.Caption:= fStringGridRA_RsStateName + ' resonances info.' +
       '          To close press Esc';
      _FormLookInOOB.StringGridLook.RowCount:= aResonanceInfoList.Count + 1;
      _FormLookInOOB.StringGridLook.ColCount:= 14;
      _FormLookInOOB.StringGridLook.FixedRows:= 1;
      _FormLookInOOB.StringGridLook.FixedCols:= 0;
      for I:= 0 to _FormLookInOOB.StringGridLook.ColCount - 1 do
       _FormLookInOOB.StringGridLook.ColWidths[I]:= _FormLookInOOB.StringGridLook.Width div (_FormLookInOOB.StringGridLook.ColCount + 1);
      fTmpLines.Clear;
      fTmpLines.Add('Res.type');
      fTmpLines.Add('E0, eV');
      fTmpLines.Add('A avg.');
      fTmpLines.Add('2*I');
      fTmpLines.Add('2*J');
      fTmpLines.Add('Xs,b');
      fTmpLines.Add('l');
      fTmpLines.Add('Edown');
      fTmpLines.Add('Eup');
      fTmpLines.Add('GT');
      fTmpLines.Add('GN');
      fTmpLines.Add('GG');
      fTmpLines.Add('GF');
      fTmpLines.Add('GFB');
      _FormLookInOOB.StringGridLook.Rows[0].Assign(fTmpLines);
      for I:= 0 to aResonanceInfoList.Count - 1 do
      begin
       fTmpLines.Clear;
       aResonanceInfo:= aResonanceInfoList[I];
       fTmpLines.Add(ResonanceTypeToStr(aResonanceInfo.ResonanceType));
       fTmpLines.Add(Format('%-7.5g', [aResonanceInfo.E0]));
       fTmpLines.Add(Format('%-7.5g', [aResonanceInfo.A]));
       fTmpLines.Add(IntToStr(aResonanceInfo.TwoI));
       fTmpLines.Add(IntToStr(aResonanceInfo.TwoJ));
       fTmpLines.Add(Format('%-7.5g', [aResonanceInfo.SigmaS]));
       fTmpLines.Add(IntToStr(aResonanceInfo.L));
       fTmpLines.Add(Format('%-7.5g', [aResonanceInfo.Edown]));
       fTmpLines.Add(Format('%-7.5g', [aResonanceInfo.Eup]));
       fTmpLines.Add(Format('%-7.5g', [aResonanceInfo.GammaT]));
       fTmpLines.Add(Format('%-7.5g', [aResonanceInfo.GammaN]));
       fTmpLines.Add(Format('%-7.5g', [aResonanceInfo.GammaG]));
       fTmpLines.Add(Format('%-7.5g', [aResonanceInfo.GammaF]));
       if aResonanceInfo.GammaFB > 0 then
        fTmpLines.Add(Format('%-7.5g', [aResonanceInfo.GammaFB]));
       _FormLookInOOB.StringGridLook.Rows[I + 1].Assign(fTmpLines);
      end;
      _FormLookInOOB.Show;
      Sleep(GetDoubleClickTime);
      EmptyMouseQueue;
      _FormLookInOOB.BringToFront;
      SendMessage(_FormLookInOOB.Handle, WM_LBUTTONDOWN, 0, 0);
      SendMessage(_FormLookInOOB.Handle, WM_LBUTTONUP, 0, 0);
      Application.ProcessMessages;
     finally
      aResonanceInfoList.Free;
      Screen.Cursor:= SaveCursor;
      Application.ProcessMessages;
     end;
   end;
  end;
 finally
  Screen.Cursor:= SaveCursor;
  Application.ProcessMessages;
 end;
end;

procedure T_FormChainEditor.StringGridRA_RsSelectCell(Sender: TObject;
 ACol, ARow: Integer; var CanSelect: Boolean);
begin
 if ARow > 0 then
  fStringGridRA_RsStateName:= StringGridRA_Rs.Cells[0, ARow]
 else
  fStringGridRA_RsStateName:= '';
end;

procedure T_FormChainEditor.StringGridRA_RsCellValidate(Sender: TObject;
 ACol, ARow: Integer; const OldValue: string; var NewValue: string;
 var Valid: Boolean);
begin
 fNeedToBuildSSK_TableList:= True;
end;

procedure T_FormChainEditor.ButtonLoadInitialsClick(Sender: TObject);
var
 OldFilterIndex: integer;
 OldExt: string;
begin
 with OpenDialog do
 begin
  OldFilterIndex:= FilterIndex;
  OldExt:= DefaultExt;
  DefaultExt:= 'ivl';
  FilterIndex:= 6;
  FileName:= '';
  if Execute then
   LoadInitials(FileName);
  DefaultExt:= OldExt;
  FilterIndex:= OldFilterIndex;
 end;
end;

procedure T_FormChainEditor.LoadInitials(const FileName: string);
var
 FileStream: TFileStream;
 GridStream: TMemoryStream;
 Buffer: PChar;
 SavePosition, Count4Grid, Int: Longint;
 Txt: string;
begin
 New(Buffer);
 GridStream:= TMemoryStream.Create;
 FileStream:= TFileStream.Create(FileName, fmOpenRead);
 try
  try
   FileStream.ReadBuffer(Longint(Int), SizeOf(Longint));
   if Int = 1 then
   begin
    RadioButtonNuclei.Checked:= True;
    RadioButtonMasses.Checked:= False;
   end
   else
   begin
    RadioButtonMasses.Checked:= True;
    RadioButtonNuclei.Checked:= False;
   end;
   RadioButtonMassesNucleiClick(Self);
   Txt:= '';
   repeat
    FileStream.ReadBuffer(Buffer^, 1);
    Txt:= Txt + Buffer^;
   until ((Buffer^ in [#0]) or (FileStream.Position + 1 >= FileStream.Size));
   EditTotalMass.Text:= Trim(Txt);
   repeat
    FileStream.ReadBuffer(Buffer^, 1);
   until ((Buffer^ in [BegiEndSectionChar]) or (FileStream.Position + 1 >= FileStream.Size));
   if (Buffer^ in [BegiEndSectionChar]) then
   begin
    SavePosition:= FileStream.Position;
    Count4Grid:= 0;
    repeat
     Inc(Count4Grid);
     FileStream.ReadBuffer(Buffer^, 1);
    until ((Buffer^ in [BegiEndSectionChar]) or (FileStream.Position + 1 >= FileStream.Size));
    FileStream.Position:= SavePosition;
    GridStream.Clear;
    GridStream.CopyFrom(FileStream, Count4Grid - 1);
    GridStream.Position:= 0;
    if not (LoadStringGridFromStream(StringGridMasses, GridStream, False)) then
    begin
     MessageDlg('Load initials stream error 1 !', mtWarning, [mbOK], 0);
     Exit;
    end;
   end
   else
    Exit;
   repeat
    FileStream.ReadBuffer(Buffer^, 1);
   until ((Buffer^ in [BegiEndSectionChar]) or (FileStream.Position + 1 >= FileStream.Size));
   if (Buffer^ in [BegiEndSectionChar]) then
   begin
    SavePosition:= FileStream.Position;
    Count4Grid:= 0;
    repeat
     Inc(Count4Grid);
     FileStream.ReadBuffer(Buffer^, 1);
    until ((Buffer^ in [BegiEndSectionChar]) or (FileStream.Position + 1 >= FileStream.Size));
    FileStream.Position:= SavePosition;
    GridStream.Clear;
    GridStream.CopyFrom(FileStream, Count4Grid - 1);
    GridStream.Position:= 0;
    if not (LoadStringGridFromStream(TStringGrid(StringGridInitialValues), GridStream, False)) then
    begin
     MessageDlg('Load initials stream error 2 !', mtWarning, [mbOK], 0);
     Exit;
    end;
//   DebugI:= 0;
//  CheckBoxPercent added
    CheckBoxPercent.Checked:= False;
    if (FileStream.Position + SizeOf(Longint) <= FileStream.Size) then
    begin
     if (Buffer^ in [BegiEndSectionChar]) then
      FileStream.Position:= FileStream.Position + 1;
     FileStream.ReadBuffer(Longint(Int), SizeOf(Longint));
     if Int > 0 then
      CheckBoxPercent.Checked:= True
     else
      CheckBoxPercent.Checked:= False;
    end;
   end
   else
    Exit;
  finally
   FileStream.Free;
   GridStream.Free;
   Dispose(Buffer);
  end;
  GroupBoxInitialValues.Caption:= 'Initial &Values                     |   Tolerances   :  ' +
   ExtractFileName(FileName) + '   ';
  fInitialValuesFileName:= FileName;
 except
  MessageDlg('Load initials exception !', mtWarning, [mbOK], 0);
  Exit;
 end;
end;

procedure T_FormChainEditor.ButtonSaveInitialsClick(Sender: TObject);
var
 FileStream: TFileStream;
 OldFilterIndex: integer;
 OldExt, Txt: string;
 Int: Longint;
begin
 with SaveDialog do
 begin
  OldFilterIndex:= FilterIndex;
  OldExt:= DefaultExt;
  DefaultExt:= 'ivl';
  FilterIndex:= 6;
  if (fInitialValuesFileName <> '') then
   FileName:= ExtractFileName(fInitialValuesFileName)
  else
   FileName:= '';
  if Execute then
  begin
   FileStream:= TFileStream.Create(FileName, fmCreate);
   try
    if RadioButtonNuclei.Checked then
     Int:= 1
    else
     Int:= 0;
    FileStream.WriteBuffer(Longint(Int), SizeOf(Longint));
    Txt:= EditTotalMass.Text;
    FileStream.Write(Pointer(Txt)^, Length(Txt));
    Txt:= #0;
    FileStream.Write(Pointer(Txt)^, 1);
    Txt:= BegiEndSectionChar;
    FileStream.Write(Pointer(Txt)^, 1);
    SaveStringGridToStream(StringGridMasses, FileStream);
    Txt:= BegiEndSectionChar;
    FileStream.Write(Pointer(Txt)^, 1);
    SaveStringGridToStream(TStringGrid(StringGridInitialValues), FileStream);
    Txt:= BegiEndSectionChar;
    FileStream.Write(Pointer(Txt)^, 1);
//  CheckBoxPercent added
    if CheckBoxPercent.Checked then
     Int:= 1
    else
     Int:= 0;
    FileStream.WriteBuffer(Longint(Int), SizeOf(Longint));
   finally
    FileStream.Free;
   end;
   fInitialValuesFileName:= FileName;
   GroupBoxInitialValues.Caption:= 'Initial &Values                     |   Tolerances   :  ' +
    ExtractFileName(FileName) + '   ';
  end;
  DefaultExt:= OldExt;
  FilterIndex:= OldFilterIndex;
 end;
end;

procedure T_FormChainEditor.ButtonSaveMMClick(Sender: TObject);
var
 OldIndex: integer;
 OldExt: string;
begin
 with SaveDialog do
 begin
  OldIndex:= FilterIndex;
  OldExt:= DefaultExt;
  FilterIndex:= 3;
  DefaultExt:= 'mm';
  FileName:= '';
  if Execute then
  begin
   StringGridMM.FileName:= FileName;
   try
    StringGridMM.FileStrings;
   except
    MessageDlg('Error in save (FileName= ' + FileName + ')', mtWarning, [mbOK], 0);
   end;
  end;
  fMmFileName:= FileName;
  GroupBoxMM.Caption:= 'Mi&xed moderators ' + ExtractFileName(fMmFileName);
  FilterIndex:= OldIndex;
  DefaultExt:= OldExt;
 end;
end;

procedure T_FormChainEditor.ButtonSaveOMClick(Sender: TObject);
var
 OldIndex: integer;
 OldExt: string;
begin
 with SaveDialog do
 begin
  OldIndex:= FilterIndex;
  OldExt:= DefaultExt;
  FilterIndex:= 4;
  DefaultExt:= 'om';
  FileName:= '';
  if Execute then
  begin
   StringGridOM.FileName:= FileName;
   try
    StringGridOM.FileStrings;
   except
    MessageDlg('Error in save (Filename = ' + FileName + ')', mtWarning, [mbOK], 0);
   end;
  end;
  FilterIndex:= OldIndex;
  DefaultExt:= OldExt;
  fOmFileName:= FileName;
  GroupBoxOM.Caption:= 'Ou&ter Moderator ' + ExtractFileName(fOmFileName);
 end;
end;

procedure T_FormChainEditor.LoadMM(const FileName: string);
 procedure AdjustRowCount;
 begin
  try
    StringGridMM.RowCount:= StringGridMM.RowCount + 1;
    StringGridMM.FileName:= FileName;
    StringGridMM.RetrieveStrings;
  except
  on ETooSmallGrid do
   AdjustRowCount();
  end;
 end;

begin
 if FileExists(FileName) then
 begin
  StringGridMM.RowCount:= 2;
  StringGridMM.FileName:= FileName;
  try
   StringGridMM.RetrieveStrings;
  except
   on EConvertError do
    MessageDlg('EConvertError' + #13 + #10 + 'Conversion failed.' + #13 + #10 + 'Mixed moderators not loaded.', mtWarning, [mbOK], 0);
(*
   on ETooSmallGrid do
   begin
    StringGridMM.RowCount:= StringGridMM.RowCount + 1;
    StringGridMM.FileName:= FileName;
    StringGridMM.RetrieveStrings;
   end;
*)
   on ETooSmallGrid do
    AdjustRowCount
  end;
 end;
end;

procedure T_FormChainEditor.ButtonLoadMMClick(Sender: TObject);
var
 OldIndex: integer;
 OldExt: string;
begin
 with OpenDialog do
 begin
  OldIndex:= FilterIndex;
  OldExt:= DefaultExt;
  FilterIndex:= 3;
  DefaultExt:= 'mm';
  FileName:= '';
  if Execute then
  begin
   if FileExists(FileName) then
   begin
    LoadMM(FileName);
   end
   else
    MessageDlg('File ' + #39 + FileName + #39 + ' not found.', mtWarning, [mbOK], 0);
  end;
  fMmFileName:= FileName;
  GroupBoxMM.Caption:= 'Mi&xed moderators ' + ExtractFileName(fMmFileName);
  FilterIndex:= OldIndex;
  DefaultExt:= OldExt;
 end;
end;

procedure T_FormChainEditor.LoadOM(const FileName: string);
begin
 if FileExists(FileName) then
 begin
  StringGridOM.FileName:= FileName;
  try
   StringGridOM.RetrieveStrings;
   GroupBoxOM.Caption:= 'Ou&ter Moderator ' + ExtractFileName(fOmFileName);
  except
   on EConvertError do
    MessageDlg('EConvertError' + #13 + #10 + 'Conversion failed.' + #13 + #10 + 'Outer moderator not loaded.', mtWarning, [mbOK], 0);
  end;
 end;
end;

procedure T_FormChainEditor.ButtonLoadOMClick(Sender: TObject);
var
 OldIndex: integer;
 OldExt: string;
begin
 with OpenDialog do
 begin
  OldIndex:= FilterIndex;
  OldExt:= DefaultExt;
  FilterIndex:= 4;
  DefaultExt:= 'om';
  FileName:= '';
  if Execute then
  begin
   if FileExists(FileName) then
   begin
    LoadOM(FileName);
   end
   else
    MessageDlg('File ' + #39 + FileName + #39 + ' not found.', mtWarning, [mbOK], 0);
  end;
  fOmFileName:= FileName;
  GroupBoxOM.Caption:= 'Ou&ter Moderator ' + ExtractFileName(fOmFileName);
  FilterIndex:= OldIndex;
  DefaultExt:= OldExt;
 end;
end;

procedure T_FormChainEditor.ButtonRA_FillDefaultsClick(Sender: TObject);
var
 I: integer;
begin
 if (StringGridRA_Rs.Cells[0, 1] <> '') then
 begin
  fTmpLines.Clear;
  fTmpLines.Add('Consider');
  for I:= 1 to StringGridRA_Rs.RowCount - 1 do
   StringGridRA_Rs.CellChecked[1, I]:= True;
  fTmpLines.Clear;
  fTmpLines.Add('N min');
  for I:= 1 to StringGridRA_Rs.RowCount - 1 do
   fTmpLines.Add('1.0e7'); //('1.0e13')
  StringGridRA_Rs.Cols[2].Assign(fTmpLines);
  fTmpLines.Clear;
  fTmpLines.Add('N max');
  for I:= 1 to StringGridRA_Rs.RowCount - 1 do
   fTmpLines.Add('1.0e24');
  StringGridRA_Rs.Cols[3].Assign(fTmpLines);
  fTmpLines.Clear;
  fTmpLines.Add('Points');
  for I:= 1 to StringGridRA_Rs.RowCount - 1 do
   fTmpLines.Add('300'); //('13')
  StringGridRA_Rs.Cols[4].Assign(fTmpLines);
  StringGridRA_Rs.MoveTo(2, 1);
  fNeedToBuildSSK_TableList:= True;
 end;
end;

procedure T_FormChainEditor.ButtonLoadResTableClick(Sender: TObject);
var
 OldIndex: integer;
 OldExt: string;
begin
 with OpenDialog do
 begin
  OldIndex:= FilterIndex;
  OldExt:= DefaultExt;
  FilterIndex:= 5;
  DefaultExt:= 'rtb';
  FileName:= '';
  if Execute then
  begin
   LoadResTableFromFile(FileName);
   fRtbFileName:= FileName;
  end;
  FilterIndex:= OldIndex;
  DefaultExt:= OldExt;
 end;
end;

procedure T_FormChainEditor.LoadResTableFromFile(const FileName: string);
begin
 try
  if SSK_TableList <> nil then
   SSK_TableList.Free;
  SSK_TableList:= TSSK_TableList.Create;
  if FileExists(FileName) then
  begin
   SSK_TableList.Clear;
   if SSK_TableList.LoadFromFile(FileName) then
   begin
    fNeedToBuildSSK_TableList:= False;
    GroupBoxSSKinitial.Caption:= '&Self-Shielding (data loaded from file ' +
     ExtractFileName(FileName) + ')';
    CheckBoxSSKconsider.Checked:= True;
   end
   else
   begin
    MessageDlg('Some problems while SSK_TableList.LoadFromFile' + #13 + #10 +
     'SSK_TableList.LoadFromFile failed' + #13 + #10 +
     'File ' + #39 + FileName + #39, mtWarning, [mbOK], 0);
   end;
   fChainCalculated:= False;
  end
  else
   MessageDlg('File ' + #39 + FileName + #39 + ' not found.', mtWarning, [mbOK], 0);
 except
  MessageDlg('Some problems (exception) while LoadResTableFromFile' + #13 + #10 +
   'File ' + #39 + FileName + #39, mtWarning, [mbOK], 0);
 end;
end;

procedure T_FormChainEditor.ButtonSaveResTableClick(Sender: TObject);
var
 OldIndex: integer;
 OldExt: string;
begin
 if (fNeedToBuildSSK_TableList) then
  if (MessageDlg('Do you want to build new  SSK tables ?', mtWarning, [mbOK, mbNo], 0) = mrYes) then
   ButtonBuildResTableClick(Self);
 if (SSK_TableList <> nil) then
  if (SSK_TableList.Count > 0) then
   with SaveDialog do
   begin
    OldIndex:= FilterIndex;
    OldExt:= DefaultExt;
    FilterIndex:= 5;
    DefaultExt:= 'rtb';
    FileName:= '';
    if Execute then
    begin
     SSK_TableList.SaveToFile(FileName);
    end;
    FilterIndex:= OldIndex;
    DefaultExt:= OldExt;
   end
  else
   MessageDlg('SSK_Table=nil orSSK_Table.Count=0 !', mtWarning, [mbOK], 0);
end;

procedure T_FormChainEditor.StringGridMMKeyUp(Sender: TObject;
 var Key: Word; Shift: TShiftState);
begin
 if ((Key = VK_INSERT) and (ssCtrl in Shift) and (ssShift in Shift)) then
  StringGridMM.RowCount:= StringGridMM.RowCount + 1
 else if ((Key = VK_DELETE) and (ssCtrl in Shift) and (ssShift in Shift)) then
  if (StringGridMM.RowCount > 2) then
   StringGridMM.RowCount:= StringGridMM.RowCount - 1;
end;

procedure T_FormChainEditor.ButtonBuildResTableClick(Sender: TObject);
var
 aThZpA_s, I, J, Nstep, NuOfMM: integer;
// Nstep: Int64;
 aFloat, Nmin, Nmax, Nra: Float;
 Vf, Vskin, Vblock, VomLocal: Float; // Vmm was but Vmm==Vra
 aMixedModerator: TMixedModeratorInfo;
 aOuterModerator: TOuterModeratorInfo;
 aResonanceInfoList: TResonanceInfoList;
 SSK_Table: TSSK_Table;
 SaveCursor: TCursor;
 SimpleCalc: Boolean;
 SaveCaption: string;
begin
 fSSK_CalcAborted:= False;
 if (Pos('Simple', RadioGroupCellType.Items[RadioGroupCellType.ItemIndex]) > 0) then
  SimpleCalc:= True
 else
  SimpleCalc:= False;
 SaveCursor:= Screen.Cursor;
 Screen.Cursor:= crHourGlass;
 SaveCaption:= Self.Caption;
 Self.Caption:= 'Self-Shielding factors calculating ... Use Ctrl+C to abort';
 fSSKCalculating:= True;
 Application.ProcessMessages;
 try
  if SSK_Calc <> nil then
   SSK_Calc.Free;
  SSK_Calc:= TSelfShieldingCalculator.Create;
  with SSK_Calc, StringGridRA_Rs do
  begin // test with !!! ( comment it )
   if ValEuSilent(EditTemperature.Text, aFloat) then
    SSK_Calc.T:= aFloat // Temperature
   else
   begin
    MessageDlg('Temperature convertion failed!', mtWarning, [mbOK], 0);
    Exit;
   end;
   if ValEuSilent(Editl_mean.Text, aFloat) then
    SSK_Calc.l_mean:= aFloat // <l>
   else
   begin
    MessageDlg('l_mean (<l>) convertion failed!', mtWarning, [mbOK], 0);
    Exit;
   end;
// Cell Type
   if (Pos('Sq', RadioGroupCellType.Items[RadioGroupCellType.ItemIndex]) > 0) then
    SSK_Calc.CellType:= ctSquare
   else if (Pos('Hex', RadioGroupCellType.Items[RadioGroupCellType.ItemIndex]) > 0) then
    SSK_Calc.CellType:= ctHex
   else
    SSK_Calc.CellType:= ctNoCell;
// Volumes
   if not (SimpleCalc) then
   begin
    if (Trim(EditSkin_V.Text) = '') then
     EditSkin_V.Text:= '0';
    if ValEuSilent(EditSkin_V.Text, aFloat) then
     Vskin:= aFloat
    else
    begin
     MessageDlg('Vskin convertion failed !', mtWarning, [mbOK], 0);
     Exit;
    end;
    if ((ValEuSilent(EditSkin_V.Text, Vskin)) and (ValEuSilent(EditRA_V.Text, aFloat))
     and (ValEuSilent(EditOM_V.Text, VomLocal))) then
     Vblock:= Vskin + aFloat + VomLocal
    else
    begin
     MessageDlg('Vblock convertion failed ! Check volumes !', mtWarning, [mbOK], 0);
     Exit;
    end;
    SSK_Calc.Vc:= Vskin / Vblock; // Vc
    SSK_Calc.Vom:= VomLocal / Vblock; // Vm
   end;
// Init Mixed Moderators pars
   NuOfMM:= 0;
   for I:= 1 to StringGridMM.RowCount - 1 do
    if Trim(StringGridMM.Cells[0, I]) <> '' then
     Inc(NuOfMM)
    else
     break;
   SSK_Calc.MixedModerators.Clear;
   for I:= 1 to NuOfMM do
   begin
    if ValEuSilent(StringGridMM.Cells[0, I], aFloat) then
     aMixedModerator.A:= aFloat
    else
    begin
     MessageDlg('Conversion failed in Mixed Moderators table ' + #10#13 +
      ' Col=0 ! Row= ' + IntToStr(I), mtWarning, [mbOK], 0);
     Exit; //     break; // qqqq
    end;
    if ValEuSilent(StringGridMM.Cells[1, I], aFloat) then
     aMixedModerator.SigmaS:= aFloat
    else
    begin
     MessageDlg('Conversion failed in Mixed Moderators table ' + #10#13 +
      ' Col=1 ! Row= ' + IntToStr(I), mtWarning, [mbOK], 0);
     Exit; //     break; // qqqq
    end;
    if ValEuSilent(StringGridMM.Cells[2, I], aFloat) then
     aMixedModerator.Ro:= aFloat / 1.0E24
    else
    begin
     MessageDlg('Conversion failed in Mixed Moderators table ' + #10#13 +
      ' Col=2! Row= ' + IntToStr(I), mtWarning, [mbOK], 0);
     Exit; //     break; // qqqq
    end;
    SSK_Calc.MixedModerators.Add(aMixedModerator);
   end;
// Init Outer Moderators pars
   ValEuSilent(EditRA_V.Text, Vf);
   if not (SimpleCalc) then
   begin
    if ValEuSilent(EditOM_V.Text, aFloat) then
     if Vf > 0 then
     begin
      SSK_Calc.Vom:= aFloat / Vf
     end
     else
      SSK_Calc.Vom:= 1.0E4 //qqqq // big volume
    else
    begin
     MessageDlg('Conversion failed in Outer Moderator volume ! ', mtWarning, [mbOK], 0);
     Exit;
    end;
   end;
   for I:= 1 to 1 do
   begin // The only Outer Moderator
    if ValEuSilent(StringGridOM.Cells[0, I], aFloat) then
     aOuterModerator.A:= aFloat
    else
    begin
     MessageDlg('Conversion failed in Outer Moderator table ' + #10#13 +
      ' Col=0 ! Row= ' + IntToStr(I), mtWarning, [mbOK], 0);
     Exit;
    end;
    if ValEuSilent(StringGridOM.Cells[1, I], aFloat) then
     aOuterModerator.SigmaS:= aFloat
    else
    begin
     MessageDlg('Conversion failed in Outer Moderator table ' + #10#13 +
      ' Col=1 ! Row= ' + IntToStr(I), mtWarning, [mbOK], 0);
     Exit;
    end;
    if ValEuSilent(StringGridOM.Cells[2, I], aFloat) then
     aOuterModerator.Ro:= aFloat / 1.0E24
    else
    begin
     MessageDlg('Conversion failed in Outer Moderator table ' + #10#13 +
      ' Col=2 ! Row= ' + IntToStr(I), mtWarning, [mbOK], 0);
     Exit;
    end;
    SSK_Calc.OuterModerator:= aOuterModerator;
   end;
// Build Table RAbsorber
   if SSK_TableList <> nil then
    SSK_TableList.Free;
   SSK_TableList:= TSSK_TableList.Create;
   for I:= 1 to StringGridRA_Rs.RowCount - 1 do
   begin
    if StringGridRA_Rs.CellChecked[1, I] then
    begin
     Application.ProcessMessages;
     if not (ValEuSilent(StringGridRA_Rs.Cells[2, I], Nmin)) then
     begin
      MessageDlg('Can not convert Nmin for ' + StringGridRA_Rs.Cells[0, I], mtWarning, [mbOK], 0);
      Exit;
     end;
     if not (ValEuSilent(StringGridRA_Rs.Cells[3, I], Nmax)) then
     begin
      MessageDlg('Can not convert Nmax for ' + StringGridRA_Rs.Cells[0, I], mtWarning, [mbOK], 0);
      Exit;
     end;
     aFloat:= 0;
     if not (ValEuSilent(StringGridRA_Rs.Cells[4, I], aFloat)) then
     begin
      MessageDlg('Can not convert Points number for ' + StringGridRA_Rs.Cells[0, I], mtWarning, [mbOK], 0);
      Exit;
     end;
     Nstep:= Round(aFloat);
     if (Nstep < 2) then
     begin
      MessageDlg('Points Number < 2', mtWarning, [mbOK], 0);
      Exit;
     end;
     if ((Nmax <= 0) or (Nmin <= 0) or (Nstep <= 0)) then
      continue;
     aThZpA_s:= StrToThZpA_s(StringGridRA_Rs.Cells[0, I]);
     SSK_Calc.A:= (aThZpA_s div 10) mod 1000;
     SSK_Table:= TSSK_Table.Create(aThZpA_s);
     aResonanceInfoList:= TResonanceInfoList.Create;
     FillResonancesInfoList(aThZpA_s, aResonanceInfoList);
     SSK_Calc.ResonanceList.Assign(aResonanceInfoList);
     try
      try
       for J:= 0 to Nstep do
       begin
        Application.ProcessMessages;
        Nra:= Exp(Ln(Nmin) + (Ln(Nmax) - Ln(Nmin)) * J / Nstep);
        SSK_Calc.Ro:= Nra * 1.0E-24;
        aFloat:= SSK_Calc.CalcSSK(-1, SimpleCalc);
        SSK_Table.Add(Nra, aFloat);
//     TmpLines.Add( FloatToStr( aFloat));
       end;
       SSK_TableList.Add(SSK_Table);
       if ChainCalc <> nil then
        ChainCalc.AssignSSK_Tables(SSK_TableList);
      except
       continue;
      end;
     finally
      aResonanceInfoList.Free;
      aResonanceInfoList:= nil;
     end;
    end
   end;
  end;
  fNeedToBuildSSK_TableList:= False;
  Application.ProcessMessages;
  if not (fSSK_CalcAborted) then
   GroupBoxSSKinitial.Caption:= '&Self-Shielding (table built)'
  else
   GroupBoxSSKinitial.Caption:= '&Self-Shielding (build aborted)';
 finally
  fRtbFileName := '';
  SSK_Calc.Free;
  SSK_Calc:= nil;
  Screen.Cursor:= SaveCursor;
  Self.Caption:= SaveCaption;
  fSSKCalculating:= False;
  Application.ProcessMessages;
 end;
end;

procedure T_FormChainEditor.CreateNewCalculator;
var
 I: integer;
begin
 if ChainCalc <> nil then
  if not (ChainCalc.Calculating) then
  begin
   OldCalculators.Add(ChainCalc);
// Delete all old calculators created but one - may be (hardly) usefull, say, for answers export
   for I:= OldCalculators.Count - 2 downto 0 do
   begin
    TChainCalculator(OldCalculators[I]).Free;
    OldCalculators[I]:= nil;
    OldCalculators.Delete(I);
   end;
  end;
 ChainCalc:= TChainCalculator.Create(Chain);
 fNeedNewCalculator:= False;
 fChainCalculated:= False;
end;

procedure T_FormChainEditor.TabSheetConditionsShow(Sender: TObject);
begin
 StringGridRA_Rs.ColWidths[4]:= StringGridRA_Rs.Width - 4 * StringGridRA_Rs.DefaultColWidth - 20; // 48; //50;
 StringGridRA_Rs.MoveTo(1, 1);
 PrepareConditions;
end;

procedure T_FormChainEditor.CheckBoxConsiderClick(Sender: TObject);
begin
 fChainCalculated:= False;
end;

procedure T_FormChainEditor.StringGridInitialValuesSetEditText(
 Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
 fChainCalculated:= False;
end;

procedure T_FormChainEditor.StringGridMassesSetEditText(Sender: TObject;
 ACol, ARow: Integer; const Value: string);
begin
 fChainCalculated:= False;
end;

procedure T_FormChainEditor.EditTotalMassChange(Sender: TObject);
begin
// fChainCalculated:= False; // Now used only in Yields( Answer) - AutoRecalc
end;

function T_FormChainEditor.PrepareConditions: Boolean; // Captions and Previous values restore
var
 I, S: integer;
begin
 Result:= False;
 if not (fAllowPrepareConditions) then
  Exit;
 try
// Sorted Initial Value States and
// Save Initial Values
  fTmpLines0.Clear;
  fTmpLines1.Clear;
  fTmpLines2.Clear;
  fTmpLines3.Clear;
  for I:= 1 to StringGridInitialValues.RowCount - 1 do
   if ((Trim(StringGridInitialValues.Cells[1, I]) <> '') or (Trim(StringGridInitialValues.Cells[2, I]) <> '') or (Trim(StringGridInitialValues.Cells[3, I]) <> '')) then
   begin
    fTmpLines0.Add(Trim(StringGridInitialValues.Cells[0, I])); // StateName
    fTmpLines1.Add(Trim(StringGridInitialValues.Cells[1, I])); // MassPart
    fTmpLines2.Add(Trim(StringGridInitialValues.Cells[2, I])); // atol
    fTmpLines3.Add(Trim(StringGridInitialValues.Cells[3, I])); // rtol
   end;
// get State Names ->  StringGridInitialValues
  if (Chain <> nil) then
   if (Chain.States.Count > 0) then
   begin
    fTmpLines.Clear;
    fTmpLines.Add('State');
    if RadioButtonNuclei.Checked then
     fTmpLines.Add('Nuclei')
    else
     fTmpLines.Add('MassPart');
    fTmpLines.Add('atol');
    fTmpLines.Add('rtol');
    StringGridInitialValues.Rows[0].Assign(fTmpLines);
    fTmpLines.Clear;
    fTmpLines.Add('State');
    fTmpSortedLines.Clear;
    for I:= 0 to Chain.States.Count - 1 do
     fTmpSortedLines.Add(Chain.States[I].Name);
    for I:= 0 to fTmpSortedLines.Count - 1 do
     fTmpLines.Add(fTmpSortedLines[I]);
    StringGridInitialValues.RowCount:= fTmpLines.Count;
    StringGridInitialValues.Cols[0].Assign(fTmpLines);
// Restore Initial Values
    for I:= 1 to StringGridInitialValues.RowCount - 1 do
    begin
     S:= fTmpLines0.IndexOf(Trim(StringGridInitialValues.Cells[0, I]));
     if (S >= 0) then
     begin
      StringGridInitialValues.Cells[1, I]:= fTmpLines1[S];
      StringGridInitialValues.Cells[2, I]:= fTmpLines2[S];
      StringGridInitialValues.Cells[3, I]:= fTmpLines3[S];
     end
     else
     begin
      StringGridInitialValues.Cells[1, I]:= '';
      StringGridInitialValues.Cells[2, I]:= '';
      StringGridInitialValues.Cells[3, I]:= '';
     end;
    end;
// get Element Names ->  StringGridMasses
// Save Element Values
    fTmpLines0.Clear;
    fTmpLines1.Clear;
    for I:= 0 to StringGridMasses.RowCount - 1 do
     if (Trim(StringGridMasses.Cells[1, I]) <> '') then
     begin
      fTmpLines0.Add(Trim(StringGridMasses.Cells[0, I])); // ElementName
      fTmpLines1.Add(Trim(StringGridMasses.Cells[1, I])); // Mass
     end;
    Chain.ListElements(fTmpSortedLines);
    StringGridMasses.RowCount:= fTmpSortedLines.Count;
    StringGridMasses.Cols[0].Assign(fTmpSortedLines);
// Restore Masses Table
    for I:= 0 to StringGridMasses.RowCount - 1 do
    begin
     S:= fTmpLines0.IndexOf(Trim(StringGridMasses.Cells[0, I]));
     if (S >= 0) then
     begin
      StringGridMasses.Cells[1, I]:= fTmpLines1[S];
     end
     else
      StringGridMasses.Cells[1, I]:= '';
    end;
// prepare Resonance Absorbers
    fTmpLines.Clear;
    fTmpLines.Add('State');
    fTmpLines.Add('Consider');
    fTmpLines.Add(' N min ');
    fTmpLines.Add(' N max ');
    fTmpLines.Add(' Points');
    StringGridRA_Rs.Rows[0].Assign(fTmpLines);
    if fNeedPrepareConditions then
     RefreshRAdata;
    fTmpLines.Clear;
    fTmpLines.Add('A');
    fTmpLines.Add('Sigma, barn');
    fTmpLines.Add('N per cub.cm');
    StringGridMM.Rows[0].Assign(fTmpLines);
    StringGridOM.Rows[0].Assign(fTmpLines);
   end;
  Result:= True;
 except
  Result:= False;
 end;
 fNeedPrepareConditions:= False;
end;

procedure T_FormChainEditor.StringGridInitialValuesUserChangedCell(
 Sender: TObject; ACol, ARow: Integer; const Value: string);
var
 I: integer;
 aFloat: Float;
 aStateName, aElementName: string;
begin
 if (ACol >= 1) then
  if (Trim(Value) <> '') then
  begin
   if not ValEuSilent(StringGridInitialValues.Cells[ACol, ARow], aFloat) then
   begin
    MessageDlg('Can not convert to float !' + #10#13 +
     'Value = ' + Value, mtWarning, [mbOK], 0);
    if not (TabSheetConditions.Visible) then
     TabSheetConditions.Show;
    StringGridInitialValues.SetFocus;
    Exit;
   end;
   if (ACol = 1) then
   begin
    aStateName:= StringGridInitialValues.Cells[0, ARow];
    aElementName:= ElementNameFromStateName(aStateName);
    if RadioButtonMasses.Checked then
    begin
     for I:= 0 to StringGridMasses.RowCount - 1 do
      if (Trim(StringGridMasses.Cells[0, I]) = Trim(aElementName)) then
       if not (ValEuSilent(StringGridMasses.Cells[1, I], aFloat)) then
        MessageDlg('Mass was NOT calculated for ' + aElementName, mtWarning, [mbOK], 0);
    end;
   end;
  end;
 fChainCalculated:= False;
end;

function T_FormChainEditor.ApplyConditions: Boolean;
var
 TmpFloat: Float;
 TmpN0: Single;
 I, J, NoInGrid: integer;
begin
 try
  PrepareConditions;
  if fNeedNewCalculator then
   CreateNewCalculator;
//  fNeedNewCalculator:= False;
  if (ChainCalc <> nil) then
  begin
   fChainCalculated:= False;
   for I:= 0 to ChainCalc.NoOfStates - 1 do
   begin
    NoInGrid:= -1;
    for J:= 1 to StringGridInitialValues.RowCount - 1 do
     if (Trim(ChainCalc.StateName[I]) = Trim(StringGridInitialValues.Cells[0, J])) then
     begin
      NoInGrid:= J;
      break;
     end;
    if NoInGrid < 0 then
    begin
     MessageDlg('Name was not found in initial values ! ' + #10#13 + ChainCalc.StateName[I], mtWarning, [mbOK], 0);
     Result:= False;
     Exit;
    end;
    if (Trim(StringGridInitialValues.Cells[1, NoInGrid]) = '') then
     ChainCalc.N0[I]:= 0
    else
    begin
     if ValEuSilent(StringGridInitialValues.Cells[1, NoInGrid], TmpFloat) then
     begin
      if RadioButtonNuclei.Checked then
      begin
       ChainCalc.N0[I]:= TmpFloat;
      end
      else
      begin // RadioButtonMasses.Checked ALWAYS now
//       ChainCalc.N0[I]:= IsGetN0fromMassDolja(TmpFloat, Trim(StringGridInitialValues.Cells[0, NoInGrid]));
       if IsGetN0fromMassDolja(TmpFloat, Trim(StringGridInitialValues.Cells[0, NoInGrid]), TmpN0) then
        ChainCalc.N0[I]:= TmpN0
       else
       begin
        if not (TabSheetConditions.Visible) then
         TabSheetConditions.Show;
        Result:= False;
        Exit;
       end;
       if CheckBoxPercent.Checked then
        ChainCalc.N0[I]:= ChainCalc.N0[I] / 100.0;
      end;
     end
     else
     begin
      MessageDlg('Can not convert N0 for State = ' + StringGridInitialValues.Cells[0, NoInGrid], mtWarning, [mbOK], 0);
      Result:= False;
      Exit;
     end;
    end;
    ChainCalc.NeedTolSwitch:= False;
    if (Trim(StringGridInitialValues.Cells[2, NoInGrid]) <> '') then
    begin
     if ValEuSilent(StringGridInitialValues.Cells[2, NoInGrid], TmpFloat) then
     begin //atol
      if not (TmpFloat < 0) then
       ChainCalc.atolerance[I]:= TmpFloat
      else
      begin
       ChainCalc.NeedTolSwitch:= True;
       ChainCalc.atolerance[I]:= -TmpFloat
      end;
     end
     else
     begin
      MessageDlg('Can not convert aTolerance for State = ' + StringGridInitialValues.Cells[0, NoInGrid], mtWarning, [mbOK], 0);
      Result:= False;
      Exit;
     end;
    end
    else
     ChainCalc.atolerance[I]:= 1.0E-5;
    if (Trim(StringGridInitialValues.Cells[3, NoInGrid]) <> '') then
    begin
     if ValEuSilent(StringGridInitialValues.Cells[3, NoInGrid], TmpFloat) then
     begin //rtol
//      if TmpFloat>0 then
      if not (TmpFloat < 0) then
       ChainCalc.rtolerance[I]:= TmpFloat;
     end
     else
     begin
      MessageDlg('Can not convert rTolerance for State = ' + StringGridInitialValues.Cells[0, NoInGrid], mtWarning, [mbOK], 0);
      Result:= False;
      Exit;
     end;
    end
    else
     ChainCalc.rtolerance[I]:= 1.0E-5;
   end;
   ChainCalc.DepressionConsider:= CheckBoxDepression.Checked;
   if CheckBoxDepression.Checked then
   begin
    if ValEuSilent(EditDepressionVolume.Text, TmpFloat) then
     ChainCalc.DepressionVolume:= TmpFloat
    else
    begin
     MessageDlg('Can not convert depression volume !', mtWarning, [mbOK], 0);
     Result:= False;
     Exit;
    end;
    if ValEuSilent(EditDepressionL.Text, TmpFloat) then
     ChainCalc.DepressionL:= TmpFloat
    else
    begin
     MessageDlg('Can not convert depression <l> !', mtWarning, [mbOK], 0);
     Result:= False;
     Exit;
    end;
   end;
   Result:= True;
  end
  else
   Result:= False; //(ChainCalc==nil)
 except
  Result:= False;
 end;
end;

procedure T_FormChainEditor.ButtonLoadResParClick(Sender: TObject);
var
 ResFileName: string;
begin
 ResFileName:= GetCurrentDir + 'ResPar.oob';
 if not (FileExists(ResFileName)) then
 begin
  if FileExists('ResPar.oob') then
   ResFileName:= 'ResPar.oob'
  else
   ResFileName:= fApplicationExePath + 'ResPar.oob';
 end;
 if not (LoadAllResonancesFromOOB(ResFileName) > 0) then //SLBWRPs, MLBWRPs, RMRPs - in SelfShieldingCalculatorClasses.pas Unit
  MessageDlg('Can NOT load resonance parameters from ' + ResFileName, mtWarning, [mbOK], 0)
 else
  RefreshRAdata;
 ButtonRA_FillDefaultsClick(Self);
end;

procedure T_FormChainEditor.RefreshRAdata;
var
 I: integer;
begin
 for I:= 1 to StringGridRA_Rs.RowCount - 1 do
  StringGridRA_Rs.Rows[I].Text:= '';
 fTmpLines.Clear;
 fTmpLines.Add('State');
// sorted
 fTmpSortedLines.Clear;
 for I:= 0 to ChainCAD.States.Count - 1 do
  if (Resonances4ThZpA_sLoaded(Chain.States[I].ThZpA_s) > 0) then
   fTmpSortedLines.Add(Chain.States[I].Name);
 for I:= 0 to fTmpSortedLines.Count - 1 do
  fTmpLines.Add(fTmpSortedLines[I]);
// StringGridRA_Rs.Clear;
 if fTmpLines.Count > 1 then
 begin
  StringGridRA_Rs.Enabled:= True;
  StringGridRA_Rs.RowCount:= fTmpLines.Count;
 end
 else
 begin // No nuclides with ResPar - Clear StringGridRA_Rs
  StringGridRA_Rs.RowCount:= 2;
  for I:= 0 to StringGridRA_Rs.ColCount - 1 do
   StringGridRA_Rs.Cells[I, 1]:= '';
  StringGridRA_Rs.Enabled:= False;
 end;
 StringGridRA_Rs.FixedCols:= 0;
 StringGridRA_Rs.Cols[0].Assign(fTmpLines);
// qqqq
// StringGridRA_Rs.ColWidths[4]:= StringGridRA_Rs.Width-4*StringGridRA_Rs.DefaultColWidth-13; // 48; //50;
 StringGridRA_Rs.FixedCols:= 1;
 StringGridRA_Rs.MoveTo(2, 1);
// StringGridRA_Rs.ColWidths[4]:= StringGridRA_Rs.Width-4*StringGridRA_Rs.DefaultColWidth-32; // 48; //50;
end;

function T_FormChainEditor.IsGetN0fromMassDolja(const MassDolja: single;
 const aStateName: string; var N0: single): Boolean;
var
 I: integer;
 TotMass: Float;
begin
 Result:= False;
 try
  for I:= 0 to StringGridMasses.RowCount - 1 do
   if (Pos(Trim(StringGridMasses.Cells[0, I]) + '-', Trim(aStateName)) = 1) then
   begin
    if (Trim(StringGridMasses.Cells[1, I]) = '') then
    begin
     N0:= 0;
     Result:= True;
     Exit;
    end
    else
    begin
     if ValEuSilent(StringGridMasses.Cells[1, I], TotMass) then
     begin
      N0:= MassDolja * TotMass / (AmassFromStateName(aStateName)) * N_Av;
      Result:= True;
      Exit;
     end
     else
     begin
      MessageDlg('Error in Mass Part calculation for ' + aStateName + #10#13 +
       'Error in Total Mass calculation.', mtWarning, [mbOK], 0);
      Result:= False;
      Exit;
     end;
    end;
    break;
   end;
 except
//  Say nothing
  Result:= False;
 end;
end;

procedure T_FormChainEditor.RadioButtonMassesNucleiClick(Sender: TObject);
begin
 fTmpLines.Clear;
 fTmpLines.Add('State');
 if RadioButtonNuclei.Checked then
  fTmpLines.Add('Nuclei')
 else
  fTmpLines.Add('MassPart');
 fTmpLines.Add('atol');
 fTmpLines.Add('rtol');
 StringGridInitialValues.Rows[0].Assign(fTmpLines);
 fChainCalculated:= False;
end;

// Conditions Page end

//                      Times Page - Time Points
// Ideja was to multiply GroupBoxes when needed  - controls uniqued by Tag

function FindControlByBaseNameAndTag(const Parent: TControl; const FullControlBaseName: string;
 const Tag: integer): TControl;
var
 I: integer;
 InputName: string;
begin
 Result:= nil;
 try
  if (Pos('Memo', FullControlBaseName) > 0) then
  begin
   InputName:= 'Memo';
  end
  else if (Pos('Edit', FullControlBaseName) > 0) then
  begin
   InputName:= 'Edit';
  end
  else if (Pos('CheckBox', FullControlBaseName) > 0) then
  begin
   InputName:= 'CheckBox';
  end
  else if (Pos('BitBtn', FullControlBaseName) > 0) then
  begin
   InputName:= 'BitBtn';
  end
  else if (Pos('Label', FullControlBaseName) > 0) then
  begin
   InputName:= 'Label';
  end;
  for I:= 0 to TWinControl(Parent).ControlCount - 1 do
  begin
// qqqq 3 lines
   if (TWinControl(Parent).Controls[I] is TPanel) then
    Result:= FindControlByBaseNameAndTag(TWinControl(Parent).Controls[I], FullControlBaseName, Tag)
   else if ((Pos(InputName, TWinControl(Parent).Controls[I].Name) > 0) and (TWinControl(Parent).Controls[I].Tag = Tag)) then
   begin
    Result:= TWinControl(Parent).Controls[I];
    break;
   end;
  end;
 except
//  Say nothing
  Result:= nil;
 end;
end;

const
 SecInDay = 24 * 3600;
 
procedure T_FormChainEditor.BitBtnApplyAllTimesClick(Sender: TObject);
begin
 ApplyTimes;
end;

function T_FormChainEditor.ApplyTimes: Boolean;
const
 Delimiters = [' ', #9, '/', '\']; // . & , - for digits
 function Part12(const InPutStr: string; var Part1, Part2: string): Boolean;
 var
  S: string;
  I: integer;
 begin
  S:= Trim(InPutStr);
  Part1:= '';
  Part2:= '';
  try
   for I:= 2 to Length(S) do
    if S[I] in Delimiters then
    begin
     Part1:= Trim(Copy(S, 1, I - 1));
     Part2:= Trim(Copy(S, I + 1, Length(S)));
     break;
    end;
   S:= Part2; // may be comments
   for I:= 2 to Length(S) do
    if S[I] in Delimiters then
    begin
     Part2:= Trim(Copy(S, 1, I - 1));
     break;
    end;
   Result:= True;
  except
//  Say nothing
   Result:= False;
  end;
 end;
var
 aGroupBox: TGroupBox;
 TimePoints: TTimePointList;
 P, I, ParentNo: integer;
 Memo: TMemo;
 CheckBoxTng: TCheckBox;
 EditTng, EditThermalFlux, EditResFlux, EditFastFlux, EditNorminalPower: TEdit;
 LabelInfo: TLabel;
 PowerStr, PowerPart1, PowerPart2: string;
 Time, dTime, Power, ThermalFlux, ResFlux, FastFlux, FluxTng, NorminalPower: Float;
 TotalTime, TotalPowerMultTime: Float;
 aTimePoint: TTimePoint;
begin
 try
  Time:= 0; // 1st Point
  for I:= AllTimePoint.Count - 1 to 0 do
   if AllTimePoint[I] <> nil then
   begin
    TTimePointList(AllTimePoint[I]).Free;
    AllTimePoint[I]:= nil;
   end;
  for P:= 0 to ScrollBoxTimes.ControlCount - 1 do
   if (ScrollBoxTimes.Controls[P] is TGroupBox) then
   begin
    aGroupBox:= TGroupBox(ScrollBoxTimes.Controls[P]);
    Memo:= TMemo(FindControlByBaseNameAndTag(aGroupBox, 'Memo1', 1));
    CheckBoxTng:= TCheckBox(FindControlByBaseNameAndTag(aGroupBox, 'CheckBox1', 1));
    EditTng:= TEdit(FindControlByBaseNameAndTag(aGroupBox, 'Edit4', 4));
    EditThermalFlux:= TEdit(FindControlByBaseNameAndTag(aGroupBox, 'Edit1', 1));
    EditResFlux:= TEdit(FindControlByBaseNameAndTag(aGroupBox, 'Edit2', 2));
    EditFastFlux:= TEdit(FindControlByBaseNameAndTag(aGroupBox, 'Edit3', 3));
    EditNorminalPower:= TEdit(FindControlByBaseNameAndTag(aGroupBox, 'Edit5', 5));
    LabelInfo:= TLabel(FindControlByBaseNameAndTag(aGroupBox, 'Label6', 8));
    TotalTime:= 0;
    TotalPowerMultTime:= 0;
    if CheckBoxTng.Checked then
    begin
     if not (ValEuSilent(EditTng.Text, FluxTng)) then
     begin
      MessageDlg('Something wrong in Tn.g for ' + aGroupBox.Caption, mtWarning, [mbOK], 0);
      Result:= False;
      Exit;
     end;
    end
    else
     FluxTng:= 0;
    if Trim(EditThermalFlux.Text) = '' then
     EditThermalFlux.Text:= '0';
    if not (ValEuSilent(EditThermalFlux.Text, ThermalFlux)) then
    begin
     MessageDlg('Something wrong in ThermalFlux for ' + aGroupBox.Caption, mtWarning, [mbOK], 0);
     Result:= False;
     Exit;
    end;
    if Trim(EditResFlux.Text) = '' then
     EditResFlux.Text:= '0';
    if not (ValEuSilent(EditResFlux.Text, ResFlux)) then
    begin
     MessageDlg('Something wrong in ResFlux for ' + aGroupBox.Caption, mtWarning, [mbOK], 0);
     Result:= False;
     Exit;
    end;
    if Trim(EditFastFlux.Text) = '' then
     EditFastFlux.Text:= '0';
    if not (ValEuSilent(EditFastFlux.Text, FastFlux)) then
    begin
     MessageDlg('Something wrong in FastFlux for ' + aGroupBox.Caption, mtWarning, [mbOK], 0);
     Result:= False;
     Exit;
    end;
    if not (ValEuSilent(EditNorminalPower.Text, NorminalPower)) then
    begin
     MessageDlg('Something wrong in NorminalPower for ' + aGroupBox.Caption, mtWarning, [mbOK], 0);
     Result:= False;
     Exit;
    end;
    if NorminalPower <= 0 then
    begin
     MessageDlg('NorminalPower <=0 !', mtWarning, [mbOK], 0);
     Result:= False;
     Exit;
    end;
    if Memo.Lines.Count > 0 then
     if (Trim(Memo.Lines[0]) <> '') then
     begin
      ParentNo:= aGroupBox.Tag;
      TimePoints:= TTimePointList.Create(nil);
      I:= 0; //counter for repeat..until
      repeat
       PowerStr:= Memo.Lines[I];
       if Part12(PowerStr, PowerPart1, PowerPart2) then
       begin
        if ValEuSilent(PowerPart1, dTime) then
        begin
         aTimePoint.Time:= Time;
         Time:= Time + dTime;
        end
        else
        begin
         MessageDlg('Something wrong in Time for ' + aGroupBox.Caption + ' Line #' + IntToStr(I + 1), mtWarning, [mbOK], 0);
         Result:= False;
         Exit;
        end;
        if not (ValEuSilent(PowerPart2, Power)) then
        begin
         MessageDlg('Something wrong in Power for ' + aGroupBox.Caption + ' Line #' + IntToStr(I + 1), mtWarning, [mbOK], 0);
         Result:= False;
         Exit;
        end;
        TotalTime:= TotalTime + dTime;
        TotalPowerMultTime:= TotalPowerMultTime + dTime * Power;
        aTimePoint.ThermalFlux:= Power * ThermalFlux / NorminalPower; //*SecInDay4flux;
        aTimePoint.ResonanceFlux:= Power * ResFlux / NorminalPower; //*SecInDay4flux;
        aTimePoint.FastFlux:= Power * FastFlux / NorminalPower; //*SecInDay4flux;
        aTimePoint.Tng:= FluxTng;
        aTimePoint.Time:= aTimePoint.Time * SecInDay;
        TimePoints.Add(aTimePoint);
       end
       else
       begin
        MessageDlg('Something wrong in Times for ' + aGroupBox.Caption + ' Line #' + IntToStr(I + 1), mtWarning, [mbOK], 0);
        Result:= False;
        Exit;
       end;
       Inc(I);
       if I > Memo.Lines.Count - 1 then
        break;
      until (Trim(Memo.Lines[I]) = '');
// Last interval
      if TimePoints.Count >= 1 then
      begin
       aTimePoint:= TimePoints[TimePoints.Count - 1];
       aTimePoint.Time:= aTimePoint.Time + dTime * SecInDay;
       TimePoints.Add(aTimePoint);
      end;
// Calculate AllTimePoint node     ParentNo=aGroupBox.Tag -> AllTimePoint[ParentNo-1]
      while ParentNo > AllTimePoint.Count do
       AllTimePoint.Add(nil);
      TTimePointList(AllTimePoint[ParentNo - 1]).Free;
      AllTimePoint[ParentNo - 1]:= nil;
      AllTimePoint[ParentNo - 1]:= TimePoints;
     end;
    LabelInfo.Caption:= Format('%8.3f', [TotalTime]) + '  ' + Format('%18.3f', [TotalPowerMultTime]);
    LabelInfo.ShowHint:= True;
   end;
  if ChainCalc <> nil then
   with ChainCalc.TimePoints do
   begin
    ChainCalc.TimePoints.Clear;
    for I:= 0 to AllTimePoint.Count - 1 do
     if (AllTimePoint[I] <> nil) then //AllTimePoint[I] is TTimePointList
      for P:= 0 to TTimePointList(AllTimePoint[I]).Count - 2 do
       ChainCalc.TimePoints.Add(TTimePointList(AllTimePoint[I])[P])
     else
      break;
// The Last Interval
    if (ChainCalc.TimePoints.Count > 0) then
    begin
     aTimePoint:= ChainCalc.TimePoints[ChainCalc.TimePoints.Count - 1]; // Last Point
     aTimePoint.Time:= ChainCalc.TimePoints[ChainCalc.TimePoints.Count - 1].Time + dTime * SecInDay;
     ChainCalc.TimePoints.Add(aTimePoint);
    end;
    if not (ChainCalc.CheckTimePointsIncrease) then
    begin
     if MessageDlg('Error in Time Points !' + #13 + #10 +
      'Maybe times do not increase ' + #13 + #10 +
      'or too dissimilar time intervals are present !' + #13 + #10 +
      ' Continue ? ', mtWarning, [mbYes, mbNo], 0) = mrNo then
     begin
      Result:= False;
      Exit;
     end;
    end;
   end;
  BitBtnApplyAllTimes.Enabled:= False;
  Result:= True;
 except
//  Say nothing
  Result:= False;
 end;
end;

procedure T_FormChainEditor.TimesChange(Sender: TObject);
begin
 BitBtnApplyAllTimes.Enabled:= True;
 fChainCalculated:= False;
end;

procedure T_FormChainEditor.BitBtnNewTimeIntervalClick(Sender: TObject);
var
 NewGroupBox: TGroupBox;
 Memo: TMemo;
 NewGroupBoxNo: integer;
begin
// DuplicateComponents
 NewGroupBox:= TGroupBox(DuplicateComponents(GroupBox1));
 AllTimePoint.Add(nil);
 NewGroupBoxNo:= AllTimePoint.Count;
 with NewGroupBox do
 begin
  NewGroupBox.Name:= 'CroupBox' + IntToStr(NewGroupBoxNo);
  NewGroupBox.Tag:= NewGroupBoxNo;
  NewGroupBox.Visible:= False;
  Memo:= TMemo(FindControlByBaseNameAndTag(NewGroupBox, 'Memo1', 1));
  Memo.Clear;
  NewGroupBox.Align:= alNone;
  NewGroupBox.Left:= Self.Width - 10;
  NewGroupBox.Align:= alLeft;
  NewGroupBox.Caption:= 'Time Intervals ' + IntToStr(NewGroupBoxNo);
  NewGroupBox.Visible:= True;
 end;
 if NewGroupBoxNo > 1 then
  BitBtnDelLastTimeInterval.Enabled:= True;
 BitBtnApplyAllTimes.Enabled:= True;
 ScrollBoxTimes.HorzScrollBar.Position:= ScrollBoxTimes.HorzScrollBar.Range;
end;

procedure T_FormChainEditor.BitBtnDelLastTimeIntervalClick(Sender: TObject);
var
 TheGroupBox: TGroupBox;
 DelGroupBoxNo: integer;
 P: integer;
begin
 TheGroupBox:= nil;
 DelGroupBoxNo:= AllTimePoint.Count;
 for P:= 0 to ScrollBoxTimes.ControlCount - 1 do
  if (ScrollBoxTimes.Controls[P] is TGroupBox) then
   if (ScrollBoxTimes.Controls[P].Tag = DelGroupBoxNo) then
   begin
    TheGroupBox:= TGroupBox(ScrollBoxTimes.Controls[P]);
    break;
   end;
 if TheGroupBox <> nil then
 begin
  with TheGroupBox do
  begin
   Align:= alNone;
   Hide;
   Free;
  end;
  if AllTimePoint[DelGroupBoxNo - 1] <> nil then
  begin
   TFloatList(AllTimePoint[DelGroupBoxNo - 1]).Free;
   AllTimePoint[DelGroupBoxNo - 1]:= nil;
  end;
  AllTimePoint.Delete(DelGroupBoxNo - 1);
  if AllTimePoint.Count > 1 then
   BitBtnDelLastTimeInterval.Enabled:= True
  else
   BitBtnDelLastTimeInterval.Enabled:= False;
 end;
 BitBtnApplyAllTimes.Enabled:= True;
end;

const
 BeginMemoChar = #1;
 EndMemoChar = #2;
 EndEditChar = #4;
 BeginGroupChar = #5;
 EndGroupChar = #4;
 EndOfLine = #13#10;
 
procedure T_FormChainEditor.ButtonTimesFileSaveClick(Sender: TObject);
var
 I, J, GroupBoxCount, OldFilterIndex: integer;
 Memo: TMemo;
 CheckBoxTng: TCheckBox;
 aGroupBox: TGroupBox;
 EditTng, EditThermalFlux, EditResFlux, EditFastFlux, EditNorminalPower: TEdit;
 OldExt, aStr: string;
 aStream: TStream;
begin
 ApplyTimes;
 with SaveDialog do
 begin
  FileName:= '';
  OldFilterIndex:= FilterIndex;
  OldExt:= DefaultExt;
  DefaultExt:= 'pow';
  FilterIndex:= 2;
  GroupBoxCount:= 0;
  if Execute then
  begin
   aStream:= TFileStream.Create(FileName, fmCreate);
   try
    for I:= 0 to ScrollBoxTimes.ControlCount - 1 do
     if (ScrollBoxTimes.Controls[I] is TGroupBox) then
      Inc(GroupBoxCount);
    aStr:= IntToStr(GroupBoxCount) + EndOfLine;
    aStream.Write(Pointer(aStr)^, Length(aStr));
    for I:= 0 to ScrollBoxTimes.ControlCount - 1 do
     if (ScrollBoxTimes.Controls[I] is TGroupBox) then
     begin
      aGroupBox:= TGroupBox(ScrollBoxTimes.Controls[I]);
      Memo:= TMemo(FindControlByBaseNameAndTag(aGroupBox, 'Memo1', 1));
      CheckBoxTng:= TCheckBox(FindControlByBaseNameAndTag(aGroupBox, 'CheckBox1', 1));
      EditTng:= TEdit(FindControlByBaseNameAndTag(aGroupBox, 'Edit4', 4));
      EditThermalFlux:= TEdit(FindControlByBaseNameAndTag(aGroupBox, 'Edit1', 1));
      EditResFlux:= TEdit(FindControlByBaseNameAndTag(aGroupBox, 'Edit2', 2));
      EditFastFlux:= TEdit(FindControlByBaseNameAndTag(aGroupBox, 'Edit3', 3));
      EditNorminalPower:= TEdit(FindControlByBaseNameAndTag(aGroupBox, 'Edit5', 5));
      aStr:= BeginGroupChar;
      aStream.Write(Pointer(aStr)^, Length(aStr));
      aStr:= IntToStr(I) + EndOfLine;
      aStream.Write(Pointer(aStr)^, Length(aStr));
      aStr:= BeginMemoChar + EndOfLine;
      aStream.Write(Pointer(aStr)^, Length(aStr));
      for J:= 0 to Memo.Lines.Count - 1 do
      begin
       aStr:= Memo.Lines[J] + EndOfLine;
       aStream.Write(Pointer(aStr)^, Length(aStr));
      end;
      aStr:= EndMemoChar + EndOfLine;
      aStream.Write(Pointer(aStr)^, Length(aStr));
      if CheckBoxTng.Checked then
       aStr:= ' 1 ' + EndEditChar
      else
       aStr:= ' 0 ' + EndEditChar;
      aStream.Write(Pointer(aStr)^, Length(aStr));
      aStr:= EditTng.Text + EndEditChar;
      aStream.Write(Pointer(aStr)^, Length(aStr));
      aStr:= EditThermalFlux.Text + EndEditChar;
      aStream.Write(Pointer(aStr)^, Length(aStr));
      aStr:= EditResFlux.Text + EndEditChar;
      aStream.Write(Pointer(aStr)^, Length(aStr));
      aStr:= EditFastFlux.Text + EndEditChar;
      aStream.Write(Pointer(aStr)^, Length(aStr));
      aStr:= EditNorminalPower.Text + EndEditChar;
      aStream.Write(Pointer(aStr)^, Length(aStr));
      aStr:= EndGroupChar + EndOfLine;
      aStream.Write(Pointer(aStr)^, Length(aStr));
     end;
   finally
    aStream.Free;
   end;
   LabelTimesFileName.Caption:= 'Times file:' + FileName;
  end;
  DefaultExt:= OldExt;
  FilterIndex:= OldFilterIndex;
 end;
end;

procedure T_FormChainEditor.ButtonTimesFileOpenClick(Sender: TObject);
var
 OldFilterIndex: integer;
 OldExt: string;
begin
 with OpenDialog do
 begin
  OldFilterIndex:= FilterIndex;
  OldExt:= DefaultExt;
  DefaultExt:= 'pow';
  FilterIndex:= 2;
  FileName:= '';
  if Execute then
   if not (LoadTimes(FileName)) then
    MessageDlg('EConvertError' + #13 + #10 +
     'Conversion failed.' + #13 + #10 +
     'Time intervals not loaded.' + #13 + #10 +
     'File ' + FileName, mtWarning, [mbOK], 0);
  DefaultExt:= OldExt;
  FilterIndex:= OldFilterIndex;
 end;
 ApplyTimes;
end;

function T_FormChainEditor.LoadTimes(const FileName: string): Boolean;
var
 I, P, GroupBoxCount: integer;
 Memo: TMemo;
 CheckBoxTng: TCheckBox;
 aGroupBox: TGroupBox;
 EditTng, EditThermalFlux, EditResFlux, EditFastFlux, EditNorminalPower: TEdit;
 LabelInfo: TLabel;
 Txt: string;
 aStream: TStream;
 Buffer: PChar;
begin
 aStream:= TFileStream.Create(FileName, fmOpenRead);
 New(Buffer);
 try
  try
   with aStream do
    repeat
     Read(Buffer^, 1);
     Txt:= Txt + Buffer^;
    until ((Buffer^ in [BeginGroupChar]) or (aStream.Position + 1 >= aStream.Size));
   GroupBoxCount:= StrToInt(Trim(Txt));
   while BitBtnDelLastTimeInterval.Enabled do
    BitBtnDelLastTimeIntervalClick(Self);
   for I:= 1 to GroupBoxCount do
   begin
    if I > 1 then
     BitBtnNewTimeIntervalClick(Self);
    Txt:= '';
    with aStream do
     repeat
      Read(Buffer^, 1);
     until ((Buffer^ in [BeginMemoChar]) or (aStream.Position + 1 >= aStream.Size));
    for P:= 0 to ScrollBoxTimes.ControlCount - 1 do
     if (ScrollBoxTimes.Controls[P] is TGroupBox) then
      if (TGroupBox(ScrollBoxTimes.Controls[P]).Tag = I) then
      begin
       aGroupBox:= TGroupBox(ScrollBoxTimes.Controls[P]);
       Memo:= TMemo(FindControlByBaseNameAndTag(aGroupBox, 'Memo1', 1));
       CheckBoxTng:= TCheckBox(FindControlByBaseNameAndTag(aGroupBox, 'CheckBox1', 1));
       EditTng:= TEdit(FindControlByBaseNameAndTag(aGroupBox, 'Edit4', 4));
       EditThermalFlux:= TEdit(FindControlByBaseNameAndTag(aGroupBox, 'Edit1', 1));
       EditResFlux:= TEdit(FindControlByBaseNameAndTag(aGroupBox, 'Edit2', 2));
       EditFastFlux:= TEdit(FindControlByBaseNameAndTag(aGroupBox, 'Edit3', 3));
       EditNorminalPower:= TEdit(FindControlByBaseNameAndTag(aGroupBox, 'Edit5', 5));
       LabelInfo:= TLabel(FindControlByBaseNameAndTag(aGroupBox, 'Label8', 8));
       LabelInfo.Caption:= '';
       LabelInfo.ShowHint:= False;
       Txt:= ''; //read Memo
       with aStream do
        repeat
         Read(Buffer^, 1);
         Txt:= Txt + Buffer^;
        until ((Buffer^ in [EndMemoChar]) or (aStream.Position + 1 >= aStream.Size));
       Memo.Lines.Text:= Trim(Txt);
       Txt:= ''; //read CheckBoxTng.Checked=1
       with aStream do
        repeat
         Read(Buffer^, 1);
         Txt:= Txt + Buffer^;
        until ((Buffer^ in [EndEditChar]) or (aStream.Position + 1 >= aStream.Size));
       CheckBoxTng.Checked:= True;
       if (Trim(Txt) = '0') then
        CheckBoxTng.Checked:= False;
       Txt:= ''; //read EditTng
       with aStream do
        repeat
         Read(Buffer^, 1);
         Txt:= Txt + Buffer^;
        until ((Buffer^ in [EndEditChar]) or (aStream.Position + 1 >= aStream.Size));
       EditTng.Text:= Trim(Txt);
       Txt:= ''; //read EditThermalFlux
       with aStream do
        repeat
         Read(Buffer^, 1);
         Txt:= Txt + Buffer^;
        until ((Buffer^ in [EndEditChar]) or (aStream.Position + 1 >= aStream.Size));
       EditThermalFlux.Text:= Trim(Txt);
       Txt:= ''; //read EditResFlux
       with aStream do
        repeat
         Read(Buffer^, 1);
         Txt:= Txt + Buffer^;
        until ((Buffer^ in [EndEditChar]) or (aStream.Position + 1 >= aStream.Size));
       EditResFlux.Text:= Trim(Txt);
       Txt:= ''; //read EditFastFlux
       with aStream do
        repeat
         Read(Buffer^, 1);
         Txt:= Txt + Buffer^;
        until ((Buffer^ in [EndEditChar]) or (aStream.Position + 1 >= aStream.Size));
       EditFastFlux.Text:= Trim(Txt);
       Txt:= ''; //read EditEditNorminalPower
       with aStream do
        repeat
         Read(Buffer^, 1);
         Txt:= Txt + Buffer^;
        until ((Buffer^ in [EndEditChar]) or (aStream.Position + 1 >= aStream.Size));
       EditNorminalPower.Text:= Trim(Txt);
      end;
   end;
   Result:= True;
   BitBtnApplyAllTimes.Enabled:= True;
   LabelTimesFileName.Caption:= 'Times file:' + FileName;
  finally
   aStream.Free;
  end;
 except
// Say nothing
  Result:= False;
 end;
end;

//                      Times Page - Time Points end

//                      Calc Solver Page start

procedure T_FormChainEditor.RadioGroupSolverClick(Sender: TObject);
begin
 if ((RadioButtonMEBDF.Checked) or (RadioButtonRADAU.Checked)) then
 begin
  CheckBoxDLL.Checked:= True;
  CheckBoxDLL.Enabled:= False;
 end
 else
 begin
  CheckBoxDLL.Enabled:= True;
 end;
(*
 if RadioButtonMEBDF.Checked then begin
  CheckBoxJAC.Checked:= False;
 end
 else begin
  CheckBoxJAC.Checked:= True;
 end;
*)
 if fIsReadOnlyDir then
 begin
  if RadioButtonVODE.Checked then
  begin
   CheckBoxDLL.Checked:= False;
   CheckBoxDLL.Enabled:= False;
  end
  else if RadioButtonLSODA.Checked then
  begin
   CheckBoxDLL.Checked:= False;
   CheckBoxDLL.Enabled:= False;
  end
 end;
end;

procedure T_FormChainEditor.TabSheetCalcShow(Sender: TObject);
begin
 ButtonCalc.Enabled:= False;
 if not (ButtonAbortCalc.Enabled) then // not Calculating
  if Chain <> nil then
   if Chain.States.Count > 0 then
    ButtonCalc.Enabled:= True;
end;

procedure T_FormChainEditor.ButtonCalcClick(Sender: TObject);
var
 SaveCurrentDir: string;
begin
 if fNeedNewCalculator then
 begin
//  CreateNewCalculator; - in PrepareCalculator
  if not (PrepareCalculator) then
  begin
   MessageDlg('Can not prepare Calculator in ButtonCalcClick !' + #13 + #10 +
    ' Will not calculate ', mtWarning, [mbOK], 0);
   Exit;
  end;
 end;
 SaveCurrentDir:= GetCurrentDir;
 SetCurrentDir(fDirForCalculator);
 RadioGroupSolver.Caption:= '  Calculation...';
 ButtonCalc.Enabled:= False;
 ButtonAbortCalc.Enabled:= True;
 RadioGroupSolver.Enabled:= False;
 CheckBoxDLL.Enabled:= False;
 CheckBoxJAC.Enabled:= False;
// TabSheetChainEditor.Enabled:= False;
 PanelChainRight.Enabled:= False;
 PanelChainBottom.Enabled:= False;
 TabSheetConditions.Enabled:= False;
 TabSheetTimes.Enabled:= False;
 TabSheetAnswers.Enabled:= False;
 fTabSheetAnswersEnabled:= False;
 Self.Caption:= 'CALCULATING... Use Ctrl+C to abort';
 try
  if RadioButtonVODE.Checked then
   DoSolve('VODE')
  else if RadioButtonLSODA.Checked then
   DoSolve('LSODA')
  else if RadioButtonRADAU.Checked then
   DoSolve('RADAU')
  else if RadioButtonMEBDF.Checked then
   DoSolve('MEBDF');
 finally
  if DirExists(SaveCurrentDir) then
   SetCurrentDir(SaveCurrentDir)
  else
   SetCurrentDir(fApplicationExePath);
  RadioGroupSolver.Caption:= 'Solver';
  ButtonCalc.Enabled:= True;
  ButtonAbortCalc.Enabled:= False;
  RadioGroupSolver.Enabled:= True;
//  RadioGroupSolverClick(Self);
  if not (fIsReadOnlyDir) then
   if ((RadioButtonLSODA.Checked) or (RadioButtonVODE.Checked)) then
    CheckBoxDLL.Enabled:= True;
  CheckBoxJAC.Enabled:= True;
//  TabSheetChainEditor.Enabled:= True;
  PanelChainRight.Enabled:= True;
  PanelChainBottom.Enabled:= True;
  RadioGroupAnswers.Enabled:= True;
  ButtonExcelExport.Enabled:= True;
  TabSheetConditions.Enabled:= True;
  TabSheetTimes.Enabled:= True;
  TabSheetAnswers.Enabled:= True;
  fTabSheetAnswersEnabled:= True;
  Self.Caption:= 'Chain Solver';
 end;
end;

function T_FormChainEditor.InitCalculator: Boolean;
begin
 try
  if fNeedNewCalculator then
   CreateNewCalculator;
  Result:= True;
 except
//  Say nothing
  Result:= False;
 end;
end;

function T_FormChainEditor.PrepareCalculator: Boolean;
var
 I, ChainCalcNoOfStates: integer;
begin
 try
  if (Chain <> nil) then
   if (Chain.States.Count > 0) then
    if ChainCalc <> nil then
     with Self, ChainCalc, Chain do
     begin
      if not (ApplyConditions) then
      begin
       if not (TabSheetConditions.Visible) then
        TabSheetConditions.Show;
       Result:= False;
       Exit;
      end;
      if not (ApplyTimes) then
      begin
       if not (TabSheetTimes.Visible) then
        TabSheetTimes.Show;
       Result:= False;
       Exit;
      end;
      Application.ProcessMessages;
      ChainCalcNoOfStates:= ChainCalc.NoOfStates;
      with StringGridResults, ChainCalc do
      begin
       if ChainCalc.TimePoints.Count > 0 then
        StringGridResults.RowCount:= ChainCalc.TimePoints.Count + 1;
       StringGridResults.ColCount:= ChainCalcNoOfStates + 2;
       StringGridResults.Cells[0, 0]:= 'Time';
       StringGridResults.Cells[1, 0]:= 'Flux therm.';
       for I:= 0 to ChainCalcNoOfStates - 1 do
        StringGridResults.Cells[I + 2, 0]:= ChainCalc.StateName[I];
       for I:= 0 to ChainCalc.TimePoints.Count - 1 do
        StringGridResults.Cells[0, I + 1]:= FloatToStr(ChainCalc.TimePoints[I].Time / SecInDay);
       ChainCalc.ProgressBar:= ProgressBarCalc;
      end;
      PrepareConditions;
     end;
  fChainCalculated:= False;
  Result:= True;
 except
//  Say nothing
  Result:= False;
 end
end;

procedure T_FormChainEditor.DoSolve(const Solver: string);
var
 I, T, ChainCalcNoOfStates: integer;
 SaveCursor: TCursor;
 aStateMass, vRA, maxLambda: Float;
begin
 if (Chain <> nil) then
  if (Chain.States.Count > 0) then
  begin
   if not (InitCalculator) then
   begin
    MessageDlg('Can not init Calculator !' + #13 + #10 +
     ' Will not calculate', mtWarning, [mbOK], 0);
    Exit;
   end;
   if ChainCalc <> nil then
   begin
    if not (PrepareCalculator) then
    begin
     MessageDlg('Can not prepare Calculator in DoSolve !' + #13 + #10 +
      ' Will not calculate', mtWarning, [mbOK], 0);
     Exit;
    end
   end
   else
   begin
    MessageDlg('Calculator is nil !' + #13 + #10 +
     ' Will not calculate', mtWarning, [mbOK], 0);
    Exit;
   end;
   if (ChainCalc.TimePoints.Count < 2) then
   begin
    MessageDlg('Cannot yet calculate for less than two time points ! Sorry.' + #13 + #10 +
     ' Will not calculate', mtWarning, [mbOK], 0);
    if not (TabSheetTimes.Visible) then
     TabSheetTimes.Show;
    Exit;
   end;
   if (ChainCalc.TimePoints[ChainCalc.TimePoints.Count - 1].ThermalFlux > 1E10) then
   begin
    maxLambda:= 0;
    for I:= 0 to Chain.States.Count - 1 do
     if Chain.States[I].DecayDecrease > maxLambda then
      maxLambda:= Chain.States[I].DecayDecrease;
    if (maxLambda > 8.0225E-6) then
    begin // 1 hour=0.00019254  ,  1 day=8.0225E-6
     if (MessageDlg('Last time point has non-zero thermal flux.' + #13 + #10 +
      'And short-lived state(s) present.' + #13 + #10 +
      'Please, don''t forget decay during storage.' + #13 + #10 +
      ' Continue ?', mtWarning, [mbYes, mbNo], 0) = mrNo) then
      Exit;
    end;
   end;
   if CheckBoxSSKconsider.Checked then
    if fNeedToBuildSSK_TableList then
     if MessageDlg(' Self-shielding factors (SSK) table was NOT built ! Continue ?', mtWarning, [mbYes, mbNo], 0) = mrNo then
      Exit;
   if CheckBoxSSKconsider.Checked then
   begin
    if ValEuSilent(EditRA_V.Text, vRA) then
    begin
     ChainCalc.RA_VolumeForSSK:= vRA
    end
    else
    begin
     MessageDlg('Resonance self-shielding is on. ' + #13 + #10 +
      'But resonance absorber volume not calculated !' + #13 + #10 +
      ' Will not calculate', mtWarning, [mbOK], 0);
     Exit;
    end;
    ChainCalc.AssignSSK_Tables(SSK_TableList);
   end;
   SaveCursor:= Screen.Cursor;
   Screen.Cursor:= crHourGlass;
   MemoCalculatorStdOut.Lines.Clear;
   ChainCalc.UseSSK:= CheckBoxSSKconsider.Checked;
   Application.ProcessMessages;
   try
    if (Solver = 'VODE') then
     ChainCalc.SolveChainWithVODE(CheckBoxJAC.Checked, CheckBoxDLL.Checked)
    else if (Solver = 'RADAU') then
     ChainCalc.SolveChainWithRADAU(CheckBoxJAC.Checked)
    else if (Solver = 'MEBDF') then
     ChainCalc.SolveChainWithMEBDF(CheckBoxJAC.Checked)
    else //if(Sender=ButtonLSODA) then
     ChainCalc.SolveChainWithLSODA(CheckBoxJAC.Checked, CheckBoxDLL.Checked);
   finally
    fChainCalculated:= True;
    ChainCalcNoOfStates:= ChainCalc.NoOfStates;
    for I:= 0 to ChainCalc.TimePoints.Count - 1 do
     StringGridResults.Cells[1, I + 1]:= Trim(Format('%-7.5g', [ChainCalc.TimePoints[I].ThermalFlux]));
    if RadioButtonNuclei.Checked then
     for I:= 0 to ChainCalcNoOfStates - 1 do
      for T:= 0 to ChainCalc.TimePoints.Count - 1 do
       StringGridResults.Cells[I + 2, 1 + T]:= Trim(Format('%-7.5g', [ChainCalc.NIvsTime[I, T]]))
    else
    begin //RadioButtonMasses.Checked
// N0=MassDolja*TotMass/(AmassFromStateName(aStateName))*N_Av
     for I:= 0 to ChainCalcNoOfStates - 1 do
     begin
      aStateMass:= AmassFromStateName(ChainCalc.StateName[I]);
      for T:= 0 to ChainCalc.TimePoints.Count - 1 do
       StringGridResults.Cells[I + 2, 1 + T]:= Trim(Format('%-7.5g', [ChainCalc.NIvsTime[I, T]
        * (aStateMass) / N_Av]))
     end;
    end;
    for I:= 0 to ChainCalc.CalculatorStdOut.Count - 1 do
     MemoCalculatorStdOut.Lines.Add(ChainCalc.CalculatorStdOut[I]);
    Screen.Cursor:= SaveCursor;
    TabSheetAnswers.Enabled:= True;
    Application.ProcessMessages;
    PrepareAnswersCols;
   end;
  end;
end;

procedure T_FormChainEditor.ButtonTestCalcClick(Sender: TObject);
begin
//
end;

procedure T_FormChainEditor.ButtonAbortCalcClick(Sender: TObject);
begin
 if (ChainCalc <> nil) then
 begin
  MemoCalculatorStdOut.Lines.Add('ABORTING...');
  Application.ProcessMessages;
  ChainCalc.StopCalculation;
  Application.ProcessMessages;
 end;
end;

//                      Calc Solver Page END

//    Answers Page start

procedure T_FormChainEditor.ButtonExcelExportClick(Sender: TObject);
var
 I, GridCol, GridRow, ExcelCol, ExcelRow, FirstItemExcelRow, SaveRadioIndex, OldFilterIndex, ColInc: integer;
 OldExt: string;
 SaveDialogExecuted: Boolean;
 ItemName: string;
 aFloat: Float;
 aStr: string;
 SaveCursor: TCursor;
 ODEsolverStr: string;
begin
 if not (fChainCalculated) then
  MessageDlg('Caution: the chain (for Excel) was not (re)calculated !', mtWarning, [mbOK], 0);
 with SaveDialog do
 begin
  OldFilterIndex:= FilterIndex;
  OldExt:= DefaultExt;
  DefaultExt:= 'xls';
  FilterIndex:= 7;
  FileName:= '';
  SaveDialogExecuted:= Execute;
  if SaveDialogExecuted then
  begin
   if (RadioGroupAnswers.ItemIndex = -1) then
    RadioGroupAnswers.ItemIndex:= 1;
   SaveCursor:= Screen.Cursor;
   Screen.Cursor:= crHourGlass;
   StringGridAnswers.Enabled:= False;
   Self.Caption:= 'SAVING EXCEL FILE...';
   Application.ProcessMessages;
   try
    try
     mxNativeExcel.FileName:= FileName;
     SaveRadioIndex:= RadioGroupAnswers.ItemIndex;
     with mxNativeExcel do
     begin
      NewFile;
// header
      WriteLabel(3, 1, LabelChainFileName.Caption);
      WriteLabel(4, 1, LabelTimesFileName.Caption);
// added ODEsolverStr

      ODEsolverStr:= '';
      if RadioButtonLSODA.Checked then
       ODEsolverStr:= 'LSODA '
      else if RadioButtonVODE.Checked then
       ODEsolverStr:= 'VODE '
      else if RadioButtonRADAU.Checked then
       ODEsolverStr:= 'RADAU '
      else if RadioButtonMEBDF.Checked then
       ODEsolverStr:= 'MEBDF ';
      if CheckBoxDLL.Checked then
       ODEsolverStr:= ODEsolverStr + 'DLL '
      else
       ODEsolverStr:= ODEsolverStr + 'no DLL ';
      if CheckBoxJAC.Checked then
       ODEsolverStr:= ODEsolverStr + 'JAC'
      else
       ODEsolverStr:= ODEsolverStr + 'no JAC';
      WriteLabel(5, 1, ODESolverStr);
// added ODEsolverStr
      WriteLabel(7, 3, 'Lambda');
      WriteLabel(8, 3, 'T1_2');
      ExcelRow:= 6;
      ColInc:= 0;
      for I:= 0 to Chain.States.Count - 1 do
      begin
       GridCol:= fC[I] + 2;
       ExcelCol:= ((GridCol + ColInc) mod ExcelColLimit);
       if (ExcelCol = 0) then
       begin
        ExcelCol:= 1;
        ColInc:= ColInc + 1;
       end;
       WriteLabel(ExcelRow, ExcelCol, Chain.States[I].Name);
//       if ((ExcelRow <>6)and(ExcelRow <>10)) then
//        WriteLabel(ExcelRow + 1, ExcelCol, ''); // qqqq delets          WriteNumber(ExcelRow + 1, ExcelCol, aFloat); - Lambda values
       if PrepareToParse(ChainCad.States[I].State.ValuesStr[0], aStr) then
        if ValEuSilent(aStr, aFloat) then
        begin
         WriteNumber(ExcelRow + 1, ExcelCol, aFloat);
         WriteLabel(ExcelRow + 2, ExcelCol, LambdaToStr(aFloat));
        end;
       if ((ExcelCol mod ExcelColLimit) = ExcelColLimit - 1) then
       begin
        ExcelRow:= ExcelRow + 4;
       end;
      end;
// Results
      FirstItemExcelRow:= ExcelRow + 5;
      for I:= 0 to RadioGroupAnswers.Items.Count - 1 do
      begin
       ItemName:= RadioGroupAnswers.Items[I];
       if (Pos('slow', ItemName) > 0) then
        if not (CheckBoxSaveSlow.Checked) then
         continue;
       if Pos('ACTIVITY', UpperCase(ItemName)) > 0 then
        if RadioGroupActivityUnits.ItemIndex = 0 then
         ItemName:= ItemName + ',Bq'
        else
         ItemName:= ItemName + ',Ci';
       RepaintAnswersTable(False, I);
       WriteLabel(FirstItemExcelRow - 1, 1, ItemName);
       WriteLabel(1, I * 2 + 1, ItemName);
       WriteLabel(1, I * 2 + 2, IntToStr(FirstItemExcelRow));
       ColInc:= 0;
       for GridCol:= 0 to StringGridAnswers.ColCount - 1 do
       begin
        ExcelCol:= ((GridCol + ColInc + 2) mod ExcelColLimit);
        if (ExcelCol = 0) then
        begin
         ExcelCol:= 1;
         ColInc:= ColInc + 1;
        end;
        for GridRow:= 0 to StringGridAnswers.RowCount - 1 do
        begin
         ExcelRow:= FirstItemExcelRow + GridRow;
         if ValEuSilent(StringGridAnswers.Cells[GridCol, GridRow], aFloat) then
          WriteNumber(ExcelRow, ExcelCol, aFloat)
         else
          WriteLabel(ExcelRow, ExcelCol, StringGridAnswers.Cells[GridCol, GridRow]);
        end;
        if ((ExcelCol mod ExcelColLimit) = ExcelColLimit - 1) then
        begin
         FirstItemExcelRow:= FirstItemExcelRow + StringGridAnswers.RowCount + 1;
        end;
       end;
       FirstItemExcelRow:= ExcelRow + 3;
      end;
      CloseFile;
      SaveToFile;
     end;
     RadioGroupAnswers.ItemIndex:= SaveRadioIndex;
     RepaintAnswersTable(False, SaveRadioIndex); // it was asked before 'Excel' click
    except
     MessageDlg('Error (exception) during Excel export !', mtWarning, [mbOK], 0);
    end;
   finally
    Self.Caption:= 'Chain Solver';
    Screen.Cursor:= SaveCursor;
    StringGridAnswers.Enabled:= True;
    Application.ProcessMessages;
   end;
  end;
  DefaultExt:= OldExt;
  FilterIndex:= OldFilterIndex;
 end;
end;

procedure T_FormChainEditor.CheckBoxAnswersA_ZClick(Sender: TObject);
begin
 RadioGroupAnswersClick(nil);
end;

procedure T_FormChainEditor.PrepareAnswersCols;
var
 I, J, ChainCalcNoOfStates: integer;
 aChainCalc: TChainCalculator;
begin
 aChainCalc:= ChainCalc;
 if (ChainCalc = nil) or (fNeedNewCalculator) then
  if OldCalculators.Count > 0 then
   aChainCalc:= TChainCalculator(OldCalculators.Last);
 ChainCalcNoOfStates:= aChainCalc.NoOfStates;
 SetLength(fAnswersCol, ChainCalcNoOfStates);
 SetLength(fAnswersCol0, ChainCalcNoOfStates);
 fTmpLines.Clear;
 for I:= 0 to ChainCalcNoOfStates - 1 do
 begin
  fAnswersCol0[I]:= I + 2;
  fAnswersCol[I]:= I + 2;
  fTmpLines.Add(aChainCalc.StateName[I]);
 end;
 fTmpLines.Sort;
 for I:= 0 to ChainCalcNoOfStates - 1 do
  for J:= 0 to ChainCalcNoOfStates - 1 do
   if (Trim(fTmpLines[I]) = Trim(aChainCalc.StateName[J])) then
   begin
    fAnswersCol[J]:= I + 2;
    break;
   end;
end;

procedure T_FormChainEditor.StringGridAnswersColumnMoved(Sender: TObject;
 FromIndex, ToIndex: Integer);
var
 I, S, S1, S2, SaveC, FixedColCount, FromState, ToState: integer;
 
 function StateInCol(const ColNo: integer): integer;
 var
  K: integer;
 begin
  Result:= -1;
  for K:= 0 to StringGridAnswers.ColCount - FixedColCount - 1 do
   if fC[K] = ColNo then
   begin
    Result:= K;
    break;
   end;
 end;
 
begin
 if CheckBoxAnswersA_Z.Checked then
  fC:= fAnswersCol
 else
  fC:= fAnswersCol0;
 FixedColCount:= StringGridAnswers.FixedCols;
 FromState:= StateInCol(FromIndex);
 ToState:= StateInCol(ToIndex);
 if ((Length(fC) > FromState) and (Length(fC) > ToState) and
  (ToState >= 0) and (FromState >= 0)) then
 begin
  if ToIndex < FromIndex then
  begin
   SaveC:= StateInCol(FromIndex);
   for I:= FromIndex downto ToIndex + 1 do
   begin
    S1:= StateInCol(I);
    S2:= StateInCol(I - 1);
    S:= fC[S1];
    fC[S1]:= fC[S2];
    fC[S2]:= S;
//    fC[StateInCol(I)] <- fC[StateInCol(I-1)];
   end;
   fC[SaveC]:= ToIndex;
   RadioGroupAnswersClick(nil);
//   DebugI:= 1;
  end
  else if FromIndex < ToIndex then
  begin
   SaveC:= StateInCol(FromIndex);
   for I:= FromIndex to ToIndex - 1 do
   begin
    S1:= StateInCol(I);
    S2:= StateInCol(I + 1);
    S:= fC[S1];
    fC[S1]:= fC[S2];
    fC[S2]:= S;
//    fC[StateInCol( I)] <- fC[StateInCol( I+1)];
   end;
   fC[SaveC]:= ToIndex;
   RadioGroupAnswersClick(nil);
//   DebugI:= 1;
  end
 end;
end;

procedure T_FormChainEditor.RadioGroupAnswersClick(Sender: TObject);
begin
 RepaintAnswersTable(True, RadioGroupAnswers.ItemIndex);
end;

procedure T_FormChainEditor.RepaintAnswersTable(const AskSlow: Boolean; const ItemNo: integer);
const
 Zero: Float = 0.0;
var
 I, TimeNo, ChainCalcNoOfStates, ChainCalcTimePointsCount, ChainCalcNoOfElements: integer;
 ItemName: string;
 aMass, TmpFloat: Float;
 aDT: TDecayType;
 Nrm: Float;
 vRA: Float;
//var
 aThZpA_s, J, NuOfMM: integer;
 aFloat: Float;
 Vf, Vskin, Vblock, VomLocal: Float; // was Vmm but Vmm==Vra
 aMixedModerator: TMixedModeratorInfo;
 aOuterModerator: TOuterModeratorInfo;
 aResonanceInfoList: TResonanceInfoList;
 SSK_Table: TSSK_Table;
 SaveCursor: TCursor;
 SimpleCalc: Boolean;
 ElementZs: TLongIntList;
 ElementName: string;
 SaveCaption: string;
 aChainCalc: TChainCalculator;
begin
 if not (fTabSheetAnswersEnabled) then
  Exit;
 aChainCalc:= ChainCalc;
 if (ChainCalc = nil) or (fNeedNewCalculator) then
  if OldCalculators.Count > 0 then
   aChainCalc:= TChainCalculator(OldCalculators.Last);
 if (Pos('Simple', RadioGroupCellType.Items[RadioGroupCellType.ItemIndex]) > 0) then
  SimpleCalc:= True
 else
  SimpleCalc:= False;
 if AskSlow then
 begin
  if ((ItemNo < 0) or (ItemNo > RadioGroupAnswers.Items.Count - 1)) then
   Exit;
  if (Pos('slow', RadioGroupAnswers.Items[ItemNo]) > 0) then
  begin
   if (MessageDlg('It may be too long time for answers preparation !' + #13 + #10 + 'Prepare ?', mtWarning, [mbYes, mbNo], 0) = mrNo) then
   begin
    Exit;
   end;
  end;

 end;
//  RadioGroupAnswers.ItemIndex:= ItemNo;
 if aChainCalc <> nil then
  with StringGridAnswers, aChainCalc do
  begin
(*
    if not(fChainCalculated) then begin
     Exit;
    end;
*)
   if (RadioGroupActivityUnits.ItemIndex = 1) then // Ci
    Nrm:= BqPerCi
   else
    Nrm:= 1;
   if CheckBoxAnswersA_Z.Checked then
    fC:= fAnswersCol
   else
    fC:= fAnswersCol0;
   ChainCalcNoOfStates:= aChainCalc.NoOfStates;
   ChainCalcTimePointsCount:= aChainCalc.TimePoints.Count;
   if (ChainCalcTimePointsCount > 0) then
    StringGridAnswers.RowCount:= ChainCalcTimePointsCount + 1;
   if (ChainCalcNoOfStates > 0) then
    StringGridAnswers.ColCount:= ChainCalcNoOfStates + 2;
   StringGridAnswers.Cells[0, 0]:= 'Time';
   StringGridAnswers.Cells[1, 0]:= 'Flux (therm)';
   for I:= 0 to ChainCalcNoOfStates - 1 do
    StringGridAnswers.Cells[fC[I], 0]:= aChainCalc.StateName[I];
   for TimeNo:= 0 to ChainCalcTimePointsCount - 1 do
    StringGridAnswers.Cells[0, TimeNo + 1]:= FloatToStr(aChainCalc.TimePoints[TimeNo].Time / SecInDay);
   for TimeNo:= 0 to ChainCalcTimePointsCount - 1 do
    StringGridAnswers.Cells[1, TimeNo + 1]:= Trim(Format('%-7.5g', [aChainCalc.TimePoints[TimeNo].ThermalFlux]));
//    I:= RadioGroupAnswers.ItemIndex;
   I:= ItemNo;
   if ((I < 0) or (I > RadioGroupAnswers.Items.Count - 1)) then
    Exit;
   ItemName:= RadioGroupAnswers.Items[I];
// Clear Table
   for I:= StringGridAnswers.FixedCols to StringGridAnswers.ColCount - 1 do
    for J:= StringGridAnswers.FixedRows to StringGridAnswers.RowCount - 1 do
     StringGridAnswers.Cells[I, J]:= '';
   SaveCaption:= Self.Caption;
   SaveCursor:= Screen.Cursor;
   Screen.Cursor:= crHourGlass;
   Self.Caption:= 'Preparing answers table ...';
   Application.ProcessMessages;
   try
    if Trim(ItemName) = Trim('Nuclei') then
     for I:= 0 to ChainCalcNoOfStates - 1 do
      for TimeNo:= 0 to ChainCalcTimePointsCount - 1 do
       StringGridAnswers.Cells[fC[I], 1 + TimeNo]:= Trim(Format('%-7.5g', [aChainCalc.NIvsTime[I, TimeNo]]))
    else if Trim(ItemName) = Trim('Isotope mass, g') then
     for I:= 0 to ChainCalcNoOfStates - 1 do
     begin
      aMass:= AmassFromStateName(aChainCalc.StateName[I]);
      for TimeNo:= 0 to ChainCalcTimePointsCount - 1 do
       StringGridAnswers.Cells[fC[I], 1 + TimeNo]:= Trim(Format('%-7.5g', [aChainCalc.NIvsTime[I, TimeNo]
        * (aMass) / N_Av]));
     end
    else if Trim(ItemName) = Trim('Element mass, g') then
    begin
     ElementZs:= TLongIntList.Create;
     try
      aChainCalc.GetElements(ElementZs);
      ChainCalcNoOfElements:= ElementZs.Count;
      if (ChainCalcNoOfElements > 0) then
       StringGridAnswers.ColCount:= ChainCalcNoOfElements + 2;
      fTmpLines.Clear;
      for I:= 0 to ElementZs.Count - 1 do
       if ZnumToSymbol(ElementZs[I], ElementName) then
        fTmpLines.Add(ElementName);
      if CheckBoxAnswersA_Z.Checked then
       fTmpLines.Sort;
      fTmpLines0.Clear;
      for I:= 0 to StringGridAnswers.FixedCols - 1 do
       fTmpLines0.Add(StringGridAnswers.Cells[I, 0]);
      for I:= 0 to fTmpLines.Count - 1 do
       fTmpLines0.Add(fTmpLines[I]);
      StringGridAnswers.Rows[0].Assign(fTmpLines0);
      for I:= StringGridAnswers.FixedCols to StringGridAnswers.ColCount - 1 do
      begin
       ElementName:= StringGridAnswers.Cells[I, 0];
       for TimeNo:= 0 to ChainCalcTimePointsCount - 1 do
       begin
        aMass:= aChainCalc.GetElementMass(ElementName, TimeNo);
        if (aMass >= Zero) then
         StringGridAnswers.Cells[I, 1 + TimeNo]:= Trim(Format('%-7.5g', [aMass]))
        else
         StringGridAnswers.Cells[I, 1 + TimeNo]:= '0.000'; //Trim(Format('%-7.5g', [-1.0]))
       end;
      end;
     finally
      ElementZs.Free;
     end;
    end
    else if Trim(ItemName) = Trim('Activity A') then
    begin
     aDT:= dtA;
     for I:= 0 to ChainCalcNoOfStates - 1 do
      for TimeNo:= 0 to ChainCalcTimePointsCount - 1 do
       StringGridAnswers.Cells[fC[I], 1 + TimeNo]:= Trim(Format('%-7.5g', [aChainCalc.GetActivitiNIvsTime(I, TimeNo, aDT) / Nrm]))
    end
    else if Trim(ItemName) = Trim('Activity B-') then
    begin
     aDT:= dtBM;
     for I:= 0 to ChainCalcNoOfStates - 1 do
      for TimeNo:= 0 to ChainCalcTimePointsCount - 1 do
       StringGridAnswers.Cells[fC[I], 1 + TimeNo]:= Trim(Format('%-7.5g', [aChainCalc.GetActivitiNIvsTime(I, TimeNo, aDT) / Nrm]));
    end
    else if Trim(ItemName) = Trim('Activity EC') then
    begin
     aDT:= dtEC;
     for I:= 0 to ChainCalcNoOfStates - 1 do
      for TimeNo:= 0 to ChainCalcTimePointsCount - 1 do
       StringGridAnswers.Cells[fC[I], 1 + TimeNo]:= Trim(Format('%-7.5g', [aChainCalc.GetActivitiNIvsTime(I, TimeNo, aDT) / Nrm]));
    end
    else if Trim(ItemName) = Trim('Activity IT') then
    begin
     aDT:= dtIT;
     for I:= 0 to ChainCalcNoOfStates - 1 do
      for TimeNo:= 0 to ChainCalcTimePointsCount - 1 do
       StringGridAnswers.Cells[fC[I], 1 + TimeNo]:= Trim(Format('%-7.5g', [aChainCalc.GetActivitiNIvsTime(I, TimeNo, aDT) / Nrm]));
    end
    else if Trim(ItemName) = Trim('Activity Total') then
    begin
     aDT:= dtNone;
     for I:= 0 to ChainCalcNoOfStates - 1 do
      for TimeNo:= 0 to ChainCalcTimePointsCount - 1 do
       StringGridAnswers.Cells[fC[I], 1 + TimeNo]:= Trim(Format('%-7.5g', [aChainCalc.GetActivitiNIvsTime(I, TimeNo, aDT) / Nrm]));
    end
    else if Trim(ItemName) = Trim('Activity per element g') then
    begin
     aDT:= dtNone;
     for I:= 0 to ChainCalcNoOfStates - 1 do
      for TimeNo:= 0 to ChainCalcTimePointsCount - 1 do
      begin
       aMass:= aChainCalc.GetElementMass(ElementNameFromStateName(aChainCalc.StateName[I]), TimeNo);
       if (aMass > 0) then
        StringGridAnswers.Cells[fC[I], 1 + TimeNo]:= Trim(Format('%-7.5g', [aChainCalc.GetActivitiNIvsTime(I, TimeNo, aDT) / Nrm / aMass]))
       else
        StringGridAnswers.Cells[fC[I], 1 + TimeNo]:= '0.00'; //Trim(Format('%-7.5g', [-1.0]))
      end
    end
    else if Trim(ItemName) = Trim('Isotopes parts (mass)') then
    begin
     for I:= 0 to ChainCalcNoOfStates - 1 do
      for TimeNo:= 0 to ChainCalcTimePointsCount - 1 do
      begin
       aMass:= aChainCalc.GetElementMass(ElementNameFromStateName(aChainCalc.StateName[I]), TimeNo);
       if (aMass > 0) then
        StringGridAnswers.Cells[fC[I], 1 + TimeNo]:= Trim(Format('%-7.5g', [aChainCalc.GetStateMass(I, TimeNo) / aMass]))
       else
        StringGridAnswers.Cells[fC[I], 1 + TimeNo]:= '0.00'; //Trim(Format('%-7.5g', [-1.0]))
      end
    end
    else if Trim(ItemName) = Trim('Mass yield') then
    begin
     aMass:= -1;
     if (Trim(EditTotalMass.Text) = '') then
      aMass:= aChainCalc.GetTotalMass(0)
     else if not (ValEuSilent(EditTotalMass.Text, aMass)) then
     begin
      MessageDlg('Cannot convert Total Mass (Conditions page) to float !', mtWarning, [mbOK], 0);
      Exit;
     end;
     if (aMass > 0) then
      for I:= 0 to ChainCalcNoOfStates - 1 do
       for TimeNo:= 0 to ChainCalcTimePointsCount - 1 do
        StringGridAnswers.Cells[fC[I], 1 + TimeNo]:= Trim(Format('%-7.5g', [aChainCalc.GetStateMass(I, TimeNo) / aMass]))
     else
      for I:= 0 to ChainCalcNoOfStates - 1 do
       for TimeNo:= 0 to ChainCalcTimePointsCount - 1 do
        StringGridAnswers.Cells[fC[I], 1 + TimeNo]:= '-1'; //Trim(Format('%-7.5g', [-1.0]))
    end
    else if Trim(ItemName) = Trim('Depression') then
    begin
     StringGridAnswers.ColCount:= 3;
     StringGridAnswers.Cells[2, 0]:= 'Depression Factor';
     if ValEuSilent(EditDepressionVolume.Text, TmpFloat) then
      aChainCalc.DepressionVolume:= TmpFloat
     else
     begin
      MessageDlg('Can NOT convert Depression Volume (Conditions page) to float !', mtWarning, [mbOK], 0);
(*
      TabSheetConditions.Show;
      EditDepressionVolume.SetFocus;
*)
      Exit;
     end;
     if ValEuSilent(EditDepressionL.Text, TmpFloat) then
      aChainCalc.DepressionL:= TmpFloat
     else
     begin
      MessageDlg('Can NOT convert Depression <l> (Conditions page) to float !', mtWarning, [mbOK], 0);
      Exit;
     end;
     for TimeNo:= 0 to ChainCalcTimePointsCount - 1 do
      StringGridAnswers.Cells[2, 1 + TimeNo]:= Trim(Format('%-7.5g', [aChainCalc.GetDepresssionK(TimeNo)]))
    end
    else if Trim(ItemName) = Trim('SSK (slow !!!)') then
    begin
// SSK calculator create ... calc...Free
// from procedure T_FormChainEditor.ButtonBuildResTableClick(Sender: TObject);
     begin
//      SaveCursor:= Screen.Cursor;
//      Screen.Cursor:= crHourGlass;
      Application.ProcessMessages;
      try
       if SSK_Calc <> nil then
        SSK_Calc.Free;
       SSK_Calc:= TSelfShieldingCalculator.Create;
       with SSK_Calc, StringGridRA_Rs do
       begin // test with !!! ( comment it )
        if ValEuSilent(EditTemperature.Text, aFloat) then
         SSK_Calc.T:= aFloat // Temperature
        else
        begin
         MessageDlg('Temperature (Conditions page) to float convertion failed!', mtWarning, [mbOK], 0);
         Exit;
        end;
        if ValEuSilent(Editl_mean.Text, aFloat) then
         SSK_Calc.l_mean:= aFloat // <l>
        else
        begin
         MessageDlg('l_mean (<l>) (Conditions page) to float convertion failed!', mtWarning, [mbOK], 0);
         Exit;
        end;
// Cell Type
        if (Pos('Sq', RadioGroupCellType.Items[RadioGroupCellType.ItemIndex]) > 0) then
         SSK_Calc.CellType:= ctSquare
        else if (Pos('Hex', RadioGroupCellType.Items[RadioGroupCellType.ItemIndex]) > 0) then
         SSK_Calc.CellType:= ctHex
        else
         SSK_Calc.CellType:= ctNoCell;
// Volumes
        if not (SimpleCalc) then
        begin
         if (Trim(EditSkin_V.Text) = '') then
          EditSkin_V.Text:= '0';
         if ValEuSilent(EditSkin_V.Text, aFloat) then
          Vskin:= aFloat
         else
         begin
          MessageDlg('Vskin (Conditions page) to float convertion failed !', mtWarning, [mbOK], 0);
          Exit;
         end;
         if ((ValEuSilent(EditSkin_V.Text, Vskin)) and (ValEuSilent(EditRA_V.Text, aFloat))
          and (ValEuSilent(EditOM_V.Text, VomLocal))) then
          Vblock:= Vskin + aFloat + VomLocal
         else
         begin
          MessageDlg('Vblock (Conditions page) to float convertion failed !', mtWarning, [mbOK], 0);
          Exit;
         end;
         if ValEuSilent(EditSkin_V.Text, aFloat) then
          Vskin:= aFloat
         else
         begin
          MessageDlg('Vskin (Conditions page) to float convertion failed !', mtWarning, [mbOK], 0);
          Exit;
         end;
         SSK_Calc.Vc:= Vskin / Vblock; // Vc
         SSK_Calc.Vom:= VomLocal / Vblock; // Vm
        end;
// Init Mixed Moderators pars
        NuOfMM:= 0;
        for I:= 1 to StringGridMM.RowCount - 1 do
         if Trim(StringGridMM.Cells[0, I]) <> '' then
          Inc(NuOfMM)
         else
          break;
        SSK_Calc.MixedModerators.Clear;
        for I:= 1 to NuOfMM do
        begin
         if ValEuSilent(StringGridMM.Cells[0, I], aFloat) then
          aMixedModerator.A:= aFloat
         else
         begin
          MessageDlg('Conversion failed in Mixed Moderators table (Conditions page)' + #10#13 +
           ' Col=0 ! Row= ' + IntToStr(I), mtWarning, [mbOK], 0);
          Exit; //     break; // qqqq
         end;
         if ValEuSilent(StringGridMM.Cells[1, I], aFloat) then
          aMixedModerator.SigmaS:= aFloat
         else
         begin
          MessageDlg('Conversion failed in Mixed Moderators table (Conditions page)' + #10#13 +
           ' Col=1 ! Row= ' + IntToStr(I), mtWarning, [mbOK], 0);
          Exit; //     break; // qqqq
         end;
         if ValEuSilent(StringGridMM.Cells[2, I], aFloat) then
          aMixedModerator.Ro:= aFloat / 1.0E24
         else
         begin
          MessageDlg('Conversion failed in Mixed Moderators table (Conditions page)' + #10#13 +
           ' Col=2! Row= ' + IntToStr(I), mtWarning, [mbOK], 0);
          Exit; //     break; // qqqq
         end;
         SSK_Calc.MixedModerators.Add(aMixedModerator);
        end;
// Init Outer Moderators pars
        ValEuSilent(EditRA_V.Text, Vf);
        if not (SimpleCalc) then
        begin
         if ValEuSilent(EditOM_V.Text, aFloat) then
          if Vf > 0 then
          begin
           SSK_Calc.Vom:= aFloat / Vf
          end
          else
           SSK_Calc.Vom:= 1.0E4 // qqqqq // big volume
         else
         begin
          MessageDlg('Conversion failed in Outer Moderator volume (Conditions page)! ', mtWarning, [mbOK], 0);
          Exit;
         end;
        end;
        for I:= 1 to 1 do
        begin // The only Outer Moderator
         if ValEuSilent(StringGridOM.Cells[0, I], aFloat) then
          aOuterModerator.A:= aFloat
         else
         begin
          MessageDlg('Conversion failed in Outer Moderator table (Conditions page)' + #10#13 +
           ' Col=0 ! Row= ' + IntToStr(I), mtWarning, [mbOK], 0);
          Exit;
         end;
         if ValEuSilent(StringGridOM.Cells[1, I], aFloat) then
          aOuterModerator.SigmaS:= aFloat
         else
         begin
          MessageDlg('Conversion failed in Outer Moderator table (Conditions page)' + #10#13 +
           ' Col=1 ! Row= ' + IntToStr(I), mtWarning, [mbOK], 0);
          Exit;
         end;
         if ValEuSilent(StringGridOM.Cells[2, I], aFloat) then
          aOuterModerator.Ro:= aFloat / 1.0E24
         else
         begin
          MessageDlg('Conversion failed in Outer Moderator table (Conditions page)' + #10#13 +
           ' Col=2 ! Row= ' + IntToStr(I), mtWarning, [mbOK], 0);
          Exit;
         end;
         SSK_Calc.OuterModerator:= aOuterModerator;
        end;
// Build Table RAbsorber
        J:= 0;
        for I:= 0 to ChainCAD.States.Count - 1 do
         if (Resonances4ThZpA_sLoaded(Chain.States[I].ThZpA_s) > 0) then
          Inc(J);
        if (J < 1) then
        begin
         Screen.Cursor:= SaveCursor;
         if (MessageDlg('All data on Self-Shielding (Conditions page) will be taken.' + #10#13 +
          'Resonance absorbers were not loaded !' + #10#13 +
          ' Load and calculate ?', mtWarning, [mbYes, mbNo], 0) = mrYes) then
         begin
          ButtonLoadResParClick(Self);
          RefreshRAdata;
         end
         else
          Exit;
        end;
        Screen.Cursor:= crHourGlass;
        for I:= 0 to ChainCalcNoOfStates - 1 do
         for TimeNo:= 0 to ChainCalcTimePointsCount - 1 do
          StringGridAnswers.Cells[fC[I], 1 + TimeNo]:= '';
        for J:= 1 to StringGridRA_Rs.RowCount - 1 do
        begin
         for I:= 2 to StringGridAnswers.ColCount - 1 do // I-2 - Number In Chain ???
          if StringGridRA_Rs.Cells[0, J] = StringGridAnswers.Cells[fC[I - 2], 0] then
//            if StringGridRA_Rs.CellChecked[1, J] then begin
          begin // for ALL RAs now
           Application.ProcessMessages;
// RA -> SSK_Calculator
           if not (ValEuSilent(EditRA_V.Text, vRA)) then
           begin
            MessageDlg('Resonance absorber volume (Conditions page) not calculated !', mtWarning, [mbOK], 0);
            exit;
           end;
           aThZpA_s:= StrToThZpA_s(StringGridRA_Rs.Cells[0, J]);
           SSK_Calc.A:= (aThZpA_s div 10) mod 1000;
           SSK_Table:= TSSK_Table.Create(aThZpA_s);
           aResonanceInfoList:= TResonanceInfoList.Create;
           FillResonancesInfoList(aThZpA_s, aResonanceInfoList);
           SSK_Calc.ResonanceList.Assign(aResonanceInfoList);
           try
            for TimeNo:= 0 to ChainCalcTimePointsCount - 1 do
            begin
             SSK_Calc.Ro:= aChainCalc.NIvsTime[I - 2, TimeNo] / vRA * 1.0E-24;
             StringGridAnswers.Cells[fC[I - 2], 1 + TimeNo]:= Trim(Format('%-7.5g', [SSK_Calc.CalcSSK(-1, SimpleCalc)]));
            end;
           finally
            aResonanceInfoList.Free;
            aResonanceInfoList:= nil;
            SSK_Table.Free;
//            SSK_Table:=nil;
           end;
           break;
          end;
        end;
       end;
      finally
       SSK_Calc.Free;
       SSK_Calc:= nil;
//        Screen.Cursor:= SaveCursor;
      end;
     end;
    end

    else if Trim(ItemName) = Trim('SSK approx.') then
    begin
//     aChainCalc.AssignSSK_Tables(SSK_TableList);
     for I:= 0 to ChainCalcNoOfStates - 1 do
     begin
      ItemName:= Trim(StringGridAnswers.Cells[fC[I], 0]);
      for TimeNo:= 0 to ChainCalcTimePointsCount - 1 do
      begin
       Nrm:= aChainCalc.NIvsTime[I, TimeNo];
       TmpFloat:= aChainCalc.ApproximateSSK(I, Nrm);
       StringGridAnswers.Cells[fC[I], 1 + TimeNo]:= Trim(Format('%-7.5g', [TmpFloat]));
      end;
     end;
    end
    else if Trim(ItemName) = Trim('Fiss.engr.(MeV,on 200)') then
    begin
     if CheckBoxSSKconsider.Checked then
      aChainCalc.AssignSSK_Tables(SSK_TableList);
     for I:= 0 to ChainCalcNoOfStates - 1 do
      for TimeNo:= 0 to ChainCalcTimePointsCount - 1 do
       StringGridAnswers.Cells[fC[I], 1 + TimeNo]:= Trim(Format('%-7.5g', [aChainCalc.GetFissionEnergyDepositionNIvsTime(I, TimeNo, CheckBoxDepression.Checked, CheckBoxSSKconsider.Checked)]));
    end
    else
     for I:= 0 to ChainCalcNoOfStates - 1 do
      for TimeNo:= 0 to ChainCalcTimePointsCount - 1 do
       StringGridAnswers.Cells[fC[I], 1 + TimeNo]:= '';
   finally
    Self.Caption:= SaveCaption;
    Screen.Cursor:= SaveCursor;
//     Application.ProcessMessages;
   end;
  end;
end;

procedure T_FormChainEditor.RadioGroupActivityUnitsClick(Sender: TObject);
begin
 if ((RadioGroupAnswers.ItemIndex > 2) and (RadioGroupAnswers.ItemIndex < 9)) then
  RepaintAnswersTable(True, RadioGroupAnswers.ItemIndex);
end;

procedure T_FormChainEditor.TabSheetAnswersShow(Sender: TObject);
begin
 if not (fChainCalculated) then
 begin
  MessageDlg('Caution: the chain was not (re)calculated !', mtWarning, [mbOK], 0);
 end;
 RepaintAnswersTable(True, RadioGroupAnswers.ItemIndex);
end;

//    Answers Page end

// Other page start

procedure T_FormChainEditor.ButtonDoNotClickClick(Sender: TObject);
const
 Clicked: integer = 0;
begin
 if Clicked = 0 then
 begin
  ButtonDoNotClick.Font.Style:= ButtonDoNotClick.Font.Style + [fsBold, fsUnderline];
  ButtonDoNotClick.Width:= ButtonDoNotClick.Width + 16;
  MessageDlg('Please do not press this button again', mtError, [mbOK], 0);
  Clicked:= Clicked + 1;
 end
 else
  Close;
end;
// Other page end

procedure T_FormChainEditor.SpeedButtonInfoClick(Sender: TObject);
begin
 with _FormSplashSolver do
 begin
  _FormSplashSolver.ButtonOK.Visible:= True;
  _FormSplashSolver.ProgressBar.Visible:= False;
  _FormSplashSolver.LabelDataLoading.Visible:= False;
  _FormSplashSolver.ShowModal;
 end;
end;

procedure T_FormChainEditor.ItemUseCumYieldsForStateClick(Sender: TObject);
var
 NoInChain, ValueStrNo, TmpLinesStrNo, I: integer;
 GetLinkResult: DWORD;
 aTransitions: TNuclideTransitions;
begin
 if NuclideList.Count < 1 then
 begin
  MessageDlg('Nuclides were NOT loaded ! Yields will not be initialized !' + #13 + #10 +
   'Use button "LOAD DB"!', mtWarning, [mbOK], 0);
  Exit;
 end;
 if (ActiveState <> nil) then
 begin
  NoInChain:= Chain.FindState(ActiveState.State.ThZpA_s);
  if (NoInChain >= 0) then
  begin
   aTransitions:= [ntFission];
   if (NoInChain >= 0) then
    for I:= 0 to Chain.Links.Count - 1 do
     if (Chain.Links[I].FinishThZpA_s = ActiveState.State.ThZpA_s) then
     begin
      fTmpLines.Clear;
      GetLinkResult:= NuclideList.GetLink(Chain.Links[I].StartThZpA_s, Chain.Links[I].FinishThZpA_s, fTmpLines, aTransitions, fTheDataModule, True);
      if (((sltThermal and GetLinkResult) > 0) or ((sltResonance and GetLinkResult) > 0) or ((sltFast and GetLinkResult) > 0)) then
      begin
// THERMAL
       for TmpLinesStrNo:= 0 to fTmpLines.Count - 1 do
        if (Pos('THERMAL', UpperCase(fTmpLines[TmpLinesStrNo])) > 0) then
         for ValueStrNo:= 0 to Chain.Links[I].ValuesStr.Count - 1 do
          if (Pos('THERMAL', UpperCase(Chain.Links[I].ValuesStr[ValueStrNo])) > 0) then
           Chain.Links[I].ValuesStr[ValueStrNo]:= fTmpLines[TmpLinesStrNo];
// RESONANCE
       for TmpLinesStrNo:= 0 to fTmpLines.Count - 1 do
        if (Pos('RESONANCE', UpperCase(fTmpLines[TmpLinesStrNo])) > 0) then
         for ValueStrNo:= 0 to Chain.Links[I].ValuesStr.Count - 1 do
          if (Pos('RESONANCE', UpperCase(Chain.Links[I].ValuesStr[ValueStrNo])) > 0) then
           Chain.Links[I].ValuesStr[ValueStrNo]:= fTmpLines[TmpLinesStrNo];
// FAST
       for TmpLinesStrNo:= 0 to fTmpLines.Count - 1 do
        if (Pos('FAST', UpperCase(fTmpLines[TmpLinesStrNo])) > 0) then
         for ValueStrNo:= 0 to Chain.Links[I].ValuesStr.Count - 1 do
          if (Pos('FAST', UpperCase(Chain.Links[I].ValuesStr[ValueStrNo])) > 0) then
           Chain.Links[I].ValuesStr[ValueStrNo]:= fTmpLines[TmpLinesStrNo];
      end;
     end;
  end;
  ActiveState:= nil;
  ActiveState:= ChainCAD.States[NoInChain];
 end;
end;

procedure T_FormChainEditor.PageControlChange(Sender: TObject);
var
 I: integer;
begin
 for I:= 0 to PageControl.PageCount - 1 do
  if (PageControl.Pages[I].Visible) then
  begin
   HelpContext:= PageControl.Pages[I].HelpContext;
   break;
  end;
end;

procedure T_FormChainEditor.StringGridRA_RsKeyDown(Sender: TObject;
 var Key: Word; Shift: TShiftState);
var
 TheRow, TheTopRow: integer;
begin
 with StringGridRA_Rs do
 begin
  if (Key = VK_RETURN) then
  begin
   StringGridRA_Rs.MoveTo(StringGridRA_Rs.Col + 1, StringGridRA_Rs.Row);
  end;
  if (StringGridRA_Rs.Col = 1) then
  begin
   TheRow:= StringGridRA_Rs.Row;
   if (Key = VK_DELETE) then
   begin
    StringGridRA_Rs.CellChecked[1, TheRow]:= False;
    TheTopRow:= StringGridRA_Rs.TopRow;
    StringGridRA_Rs.MoveTo(2, TheRow);
    StringGridRA_Rs.TopRow:= TheTopRow;
   end
   else if (Key = VK_INSERT) then
   begin
    StringGridRA_Rs.CellChecked[1, TheRow]:= not (StringGridRA_Rs.CellChecked[1, TheRow]);
    TheTopRow:= StringGridRA_Rs.TopRow;
    StringGridRA_Rs.MoveTo(2, TheRow);
    StringGridRA_Rs.TopRow:= TheTopRow;
   end;
  end;
 end;
end;

procedure T_FormChainEditor.StringGridRA_RsKeyPress(Sender: TObject;
 var Key: Char);
var
 TheRow, TheTopRow: integer;
begin
 with StringGridRA_Rs do
  if (StringGridRA_Rs.Col = 1) then
  begin
   TheRow:= StringGridRA_Rs.Row;
   if (Key = ' ') then
   begin
    StringGridRA_Rs.CellChecked[1, TheRow]:= not (StringGridRA_Rs.CellChecked[1, TheRow]);
    TheTopRow:= StringGridRA_Rs.TopRow;
    StringGridRA_Rs.MoveTo(2, TheRow);
    StringGridRA_Rs.TopRow:= TheTopRow;
   end
//   else if ((Key='t')or(Key='T') then begin
   else if (Key in ['t', 'T', 'y', 'Y', '1'..'9']) then
   begin
    StringGridRA_Rs.CellChecked[1, TheRow]:= True;
    StringGridRA_Rs.MoveTo(2, TheRow);
   end
   else
   begin
    StringGridRA_Rs.CellChecked[1, TheRow]:= False;
    StringGridRA_Rs.MoveTo(2, TheRow);
   end;
  end
end;

procedure T_FormChainEditor.ButtonTestChainClick(Sender: TObject);
begin
// raise Exception.Create('QQ!!!');
end;

procedure T_FormChainEditor.StringGridInitialValuesKeyDown(Sender: TObject;
 var Key: Word; Shift: TShiftState);
begin
// Ctrl+Ins or Ctrl+C
 if (not (ssAlt in Shift) and
  (ssCtrl in Shift) and (Key = VK_INSERT) or (Key = Ord('C'))) then
 begin
  CopyToClipboardFromStringGrid(TStringGrid(StringGridInitialValues));
 end
// Shift+Ins or Ctrl+V
 else if (not (ssAlt in Shift) and
  (((ssShift in Shift) and (Key = VK_INSERT)) or
  ((ssCtrl in Shift) and (Key = Ord('V'))))) then
 begin
  PasteFromClipboardToStringGrid(TStringGrid(StringGridInitialValues));
 end
// Simple Del
 else if ((Shift = []) and (Key = VK_DELETE)) then
 begin
  DeleteInStringGrid(TStringGrid(StringGridInitialValues));
 end;
end;

procedure T_FormChainEditor.StringGridMassesKeyDown(Sender: TObject;
 var Key: Word; Shift: TShiftState);
begin
// Ctrl+Ins or Ctrl+C
 if (not (ssAlt in Shift) and
  (ssCtrl in Shift) and (Key = VK_INSERT) or (Key = Ord('C'))) then
 begin
  CopyToClipboardFromStringGrid(TStringGrid(StringGridMasses));
 end
// Shift+Ins or Ctrl+V
 else if (not (ssAlt in Shift) and
  (((ssShift in Shift) and (Key = VK_INSERT)) or
  ((ssCtrl in Shift) and (Key = Ord('V'))))) then
 begin
  PasteFromClipboardToStringGrid(TStringGrid(StringGridMasses));
 end
// Simple Del
 else if ((Shift = []) and (Key = VK_DELETE)) then
 begin
  DeleteInStringGrid(TStringGrid(StringGridMasses));
 end;
end;

procedure T_FormChainEditor.StringGridAnswersKeyDown(Sender: TObject;
 var Key: Word; Shift: TShiftState);
begin
// Ctrl+Ins or Ctrl+C
 if (not (ssAlt in Shift) and
  (ssCtrl in Shift) and (Key = VK_INSERT) or (Key = Ord('C'))) then
 begin
  CopyToClipboardFromStringGrid(TStringGrid(StringGridAnswers));
 end;
end;

procedure T_FormChainEditor.PageControlResize(Sender: TObject);
begin
 StringGridRA_Rs.ColWidths[4]:= StringGridRA_Rs.Width - 4 * StringGridRA_Rs.DefaultColWidth - 20; // 48; //50;
end;

procedure T_FormChainEditor.PanelTimesCommonResize(Sender: TObject);
begin
 ButtonTimesFileSave.Left:= PanelTimesCommon.Width - ButtonTimesFileSave.Width - 3;
 ButtonTimesFileOpen.Left:= ButtonTimesFileSave.Left - ButtonTimesFileOpen.Width - 3;
end;

procedure T_FormChainEditor.ImageMouseDown(Sender: TObject;
 Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 try
  if (Self.ActiveControl = StringGridStateLink) then
  begin
   keybd_Event(VK_RETURN, 0, 0, 0);
   keybd_Event(VK_RETURN, 0, KEYEVENTF_KEYUP, 0);
   Application.ProcessMessages;
  end;
 except
// It happens !!!
 end;
end;

procedure T_FormChainEditor.ButtonSaveSSKconditionsClick(Sender: TObject);
var
 TheFile: TiniFile;
 OldIndex: integer;
 OldExt: string;
begin
 with SaveDialog do
 begin
  OldIndex:= FilterIndex;
  OldExt:= DefaultExt;
  FilterIndex:= 8;
  DefaultExt:= 'ssc';
  FileName:= '';
 end;
 if SaveDialog.Execute then
 begin
  TheFile:= TIniFile.Create(SaveDialog.FileName);
//    with TheFile do
  try
   try
    TheFile.WriteString('Depression', 'Volume', EditDepressionVolume.Text);
    TheFile.WriteString('Depression', 'l_avg', EditDepressionL.Text);
    TheFile.WriteBool('Depression', 'Consider', CheckBoxDepression.Checked);
    TheFile.WriteInteger('SSK', 'Cell', RadioGroupCellType.ItemIndex);
    TheFile.WriteString('SSK', 'Skin_V', EditSkin_V.Text);
    TheFile.WriteString('SSK', 'l_avg', Editl_mean.Text);
    TheFile.WriteString('SSK', 'T_K', EditTemperature.Text);
    TheFile.WriteString('SSK', 'RA_V', EditRA_V.Text);
    TheFile.WriteBool('SSK', 'Consider', CheckBoxSSKconsider.Checked);
    TheFile.WriteString('SSK', 'MMfile', ExtractFileName(fMmFileName));
    TheFile.WriteString('SSK', 'OMfile', ExtractFileName(fOmFileName));
//    if (Trim(fRtbFileName)<>'') then
    TheFile.WriteString('SSK', 'RTBfile', ExtractFileName(fRtbFileName));
   except
    MessageDlg('Error in save (FileName= ' + SaveDialog.FileName + ')', mtWarning, [mbOK], 0);
   end;
  finally
   TheFile.Free;
  end;
 end;
 with SaveDialog do
 begin
  FilterIndex:= OldIndex;
  DefaultExt:= OldExt;
 end;
end;

procedure T_FormChainEditor.ButtonLoadSSKconditionsClick(Sender: TObject);
var
 TheFile: TiniFile;
 OldIndex: integer;
 OldExt: string;
 TmpStr, aFileToLoad: string;
 TmpBool: bool;
 TmpInt: integer;
begin
 with OpenDialog do
 begin
  OldIndex:= FilterIndex;
  OldExt:= DefaultExt;
  FilterIndex:= 8;
  DefaultExt:= 'ssc';
  FileName:= '';
 end;
 if OpenDialog.Execute then
 begin
  if FileExists(OpenDialog.FileName) then
  begin
   TheFile:= TIniFile.Create(OpenDialog.FileName);
//    with TheFile do
   try
    TmpStr:= TheFile.ReadString('Depression', 'Volume', EditDepressionVolume.Text);
    if EditDepressionVolume.Text <> TmpStr then
     EditDepressionVolume.Text:= TmpStr;
    TmpStr:= TheFile.ReadString('Depression', 'l_avg', EditDepressionL.Text);
    if EditDepressionL.Text <> TmpStr then
     EditDepressionL.Text:= TmpStr;
    TmpBool:= TheFile.ReadBool('Depression', 'Consider', CheckBoxDepression.Checked);
    if CheckBoxDepression.Checked <> TmpBool then
     CheckBoxDepression.Checked:= TmpBool;
    TmpInt:= TheFile.ReadInteger('SSK', 'Cell', RadioGroupCellType.ItemIndex);
    if RadioGroupCellType.ItemIndex <> TmpInt then
     RadioGroupCellType.ItemIndex:= TmpInt;
    TmpStr:= TheFile.ReadString('SSK', 'Skin_V', EditSkin_V.Text);
    if EditSkin_V.Text <> TmpStr then
     EditSkin_V.Text:= TmpStr;
    TmpStr:= TheFile.ReadString('SSK', 'l_avg', Editl_mean.Text);
    if Editl_mean.Text <> TmpStr then
     Editl_mean.Text:= TmpStr;
    TmpStr:= TheFile.ReadString('SSK', 'T_K', EditTemperature.Text);
    if EditTemperature.Text <> TmpStr then
     EditTemperature.Text:= TmpStr;
    TmpStr:= TheFile.ReadString('SSK', 'RA_V', EditRA_V.Text);
    if EditRA_V.Text <> TmpStr then
     EditRA_V.Text:= TmpStr;
    TmpBool:= TheFile.ReadBool('SSK', 'Consider', CheckBoxSSKconsider.Checked);
    if CheckBoxSSKconsider.Checked <> tmpBool then
     CheckBoxSSKconsider.Checked:= TmpBool;
// MM
    TmpStr:= TheFile.ReadString('SSK', 'MMfile', fMmFileName);
    if fMmFileName <> TmpStr then
    begin
     aFileToLoad:= ExtractFilePath(OpenDialog.FileName) + TmpStr;
     if FileExists(aFileToLoad) then
     begin
      LoadMM(aFileToLoad);
      fMmFileName:= aFileToLoad;
      GroupBoxMM.Caption:= 'Mi&xed moderators ' + ExtractFileName(fMmFileName);
     end
     else
      MessageDlg('Mixed Moderator file not found "' + aFileToLoad + '" !', mtWarning, [mbOK], 0);
    end;
// OM
    TmpStr:= TheFile.ReadString('SSK', 'OMfile', fOmFileName);
    if fOmFileName <> TmpStr then
    begin
     aFileToLoad:= ExtractFilePath(OpenDialog.FileName) + TmpStr;
     if FileExists(aFileToLoad) then
     begin
      LoadOM(aFileToLoad);
      fOmFileName:= aFileToLoad;
      GroupBoxOM.Caption:= 'Ou&ter Moderator ' + ExtractFileName(fOmFileName);
     end
     else
      MessageDlg('Outer Moderator file not found "' + aFileToLoad + '" !', mtWarning, [mbOK], 0);
    end;
// RTB
    TmpStr:= TheFile.ReadString('SSK', 'RTBfile', ExtractFileName(fRtbFileName));
    if (Trim(TmpStr) <> '') then
     if fRtbFileName <> TmpStr then
     begin
      aFileToLoad:= ExtractFilePath(OpenDialog.FileName) + TmpStr;
      if FileExists(aFileToLoad) then
      begin
       LoadResTableFromFile(aFileToLoad);
       fRtbFileName:= aFileToLoad;
      end
      else
       MessageDlg('Resonance Table file not found "' + aFileToLoad + '" !', mtWarning, [mbOK], 0);
     end;
   finally
    TheFile.Free;
   end;
  end
  else
   MessageDlg('File ' + #39 + OpenDialog.FileName + #39 + ' not found.', mtWarning, [mbOK], 0);
 end;
 with OpenDialog do
 begin
  FilterIndex:= OldIndex;
  DefaultExt:= OldExt;
 end;
end;

procedure T_FormChainEditor.StringGridRA_RsMouseDown(Sender: TObject;
 Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 aRow: integer;
begin
 aRow:= Y div StringGridRA_Rs.DefaultRowHeight + StringGridRA_Rs.TopRow - 1;
 if aRow > 0 then
  fStringGridRA_RsStateName:= StringGridRA_Rs.Cells[0, aRow]
 else
  fStringGridRA_RsStateName:= '';
end;

procedure T_FormChainEditor.GroupBoxLinksMouseUp(Sender: TObject;
 Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 ScreenPoint: TPoint;
begin
 if (Trim(ComboBoxLinks.Text) <> '') then
 begin
  if (ActiveLink <> nil) then
   if ActiveLink.Finish.State.ThZpA_s < 870000 then
    if ActiveLink.Start.State.ThZpA_s > 870000 then
    begin
     ScreenPoint.X:= X;
     ScreenPoint.Y:= Y;
     ScreenPoint:= GroupBoxLinks.ClientToScreen(ScreenPoint);
     LinkPopupItemUseIndYieldForLink.Caption:= 'Use &IndYield for link ' + Trim(ComboBoxLinks.Text);
     LinkPopupItemUseCumYieldForLink.Caption:= 'Use &CumYield for link ' + Trim(ComboBoxLinks.Text);
     LinkPopupItemUseIndYieldForLink.Enabled:= True;
     LinkPopupItemUseCumYieldForLink.Enabled:= True;
     PopupMenuLink.Popup(ScreenPoint.X, ScreenPoint.Y);
    end;
 end
 else
 begin
  LinkPopupItemUseIndYieldForLink.Caption:= '&IndYield';
  LinkPopupItemUseCumYieldForLink.Caption:= '&CumYield';
  LinkPopupItemUseIndYieldForLink.Enabled:= False;
  LinkPopupItemUseCumYieldForLink.Enabled:= False;
 end;
end;

procedure T_FormChainEditor.LinkPopupItemUseIndYieldForLinkClick(
 Sender: TObject);
var
 ValueStrNo, TmpLinesStrNo, I: integer;
 GetLinkResult: DWORD;
 aTransitions: TNuclideTransitions;
begin
 if NuclideList.Count < 1 then
 begin
  MessageDlg('Nuclides were NOT loaded ! Yields are not initialized !' + #13 + #10 + 'Use button "LOAD DB"!', mtWarning,
   [mbOK], 0);
  Exit;
 end;
 if (ActiveLink <> nil) then
  if ((ActiveLink.Start <> nil) and (ActiveLink.Finish <> nil)) then
   try
    I:= Chain.FindLink(ActiveLink.Start.State, ActiveLink.Finish.State);
    if I >= 0 then
    begin
     fTmpLines.Clear;
     aTransitions:= [ntFission];
     GetLinkResult:= NuclideList.GetLink(ActiveLink.Start.State.ThZpA_s, ActiveLink.Finish.State.ThZpA_s, fTmpLines, aTransitions, fTheDataModule, False);
     if (((sltThermal and GetLinkResult) > 0) or ((sltResonance and GetLinkResult) > 0) or ((sltFast and GetLinkResult) > 0)) then
     begin
// THERMAL
      for TmpLinesStrNo:= 0 to fTmpLines.Count - 1 do
       if (Pos('THERMAL', UpperCase(fTmpLines[TmpLinesStrNo])) > 0) then
        for ValueStrNo:= 0 to Chain.Links[I].ValuesStr.Count - 1 do
         if (Pos('THERMAL', UpperCase(Chain.Links[I].ValuesStr[ValueStrNo])) > 0) then
          Chain.Links[I].ValuesStr[ValueStrNo]:= fTmpLines[TmpLinesStrNo];
// RESONANCE
      for TmpLinesStrNo:= 0 to fTmpLines.Count - 1 do
       if (Pos('RESONANCE', UpperCase(fTmpLines[TmpLinesStrNo])) > 0) then
        for ValueStrNo:= 0 to Chain.Links[I].ValuesStr.Count - 1 do
         if (Pos('RESONANCE', UpperCase(Chain.Links[I].ValuesStr[ValueStrNo])) > 0) then
          Chain.Links[I].ValuesStr[ValueStrNo]:= fTmpLines[TmpLinesStrNo];
// FAST
      for TmpLinesStrNo:= 0 to fTmpLines.Count - 1 do
       if (Pos('FAST', UpperCase(fTmpLines[TmpLinesStrNo])) > 0) then
        for ValueStrNo:= 0 to Chain.Links[I].ValuesStr.Count - 1 do
         if (Pos('FAST', UpperCase(Chain.Links[I].ValuesStr[ValueStrNo])) > 0) then
          Chain.Links[I].ValuesStr[ValueStrNo]:= fTmpLines[TmpLinesStrNo];
      ComboBoxLinksChange(Self);
     end;
    end;
   except

   end;
end;

procedure T_FormChainEditor.LinkPopupItemUseCumYieldForLinkClick(
 Sender: TObject);
var
 ValueStrNo, TmpLinesStrNo, I: integer;
 GetLinkResult: DWORD;
 aTransitions: TNuclideTransitions;
begin
 if NuclideList.Count < 1 then
 begin
  MessageDlg('Nuclides were NOT loaded ! Yields are not initialized !' + #13 + #10 + 'Use button "LOAD DB"!', mtWarning,
   [mbOK], 0);
  Exit;
 end;
 if (ActiveLink <> nil) then
  if ((ActiveLink.Start <> nil) and (ActiveLink.Finish <> nil)) then
   try
    I:= Chain.FindLink(ActiveLink.Start.State, ActiveLink.Finish.State);
    if I >= 0 then
    begin
     fTmpLines.Clear;
     aTransitions:= [ntFission];
     GetLinkResult:= NuclideList.GetLink(ActiveLink.Start.State.ThZpA_s, ActiveLink.Finish.State.ThZpA_s, fTmpLines, aTransitions, fTheDataModule, True);
     if (((sltThermal and GetLinkResult) > 0) or ((sltResonance and GetLinkResult) > 0) or ((sltFast and GetLinkResult) > 0)) then
     begin
// THERMAL
      for TmpLinesStrNo:= 0 to fTmpLines.Count - 1 do
       if (Pos('THERMAL', UpperCase(fTmpLines[TmpLinesStrNo])) > 0) then
        for ValueStrNo:= 0 to Chain.Links[I].ValuesStr.Count - 1 do
         if (Pos('THERMAL', UpperCase(Chain.Links[I].ValuesStr[ValueStrNo])) > 0) then
          Chain.Links[I].ValuesStr[ValueStrNo]:= fTmpLines[TmpLinesStrNo];
// RESONANCE
      for TmpLinesStrNo:= 0 to fTmpLines.Count - 1 do
       if (Pos('RESONANCE', UpperCase(fTmpLines[TmpLinesStrNo])) > 0) then
        for ValueStrNo:= 0 to Chain.Links[I].ValuesStr.Count - 1 do
         if (Pos('RESONANCE', UpperCase(Chain.Links[I].ValuesStr[ValueStrNo])) > 0) then
          Chain.Links[I].ValuesStr[ValueStrNo]:= fTmpLines[TmpLinesStrNo];
// FAST
      for TmpLinesStrNo:= 0 to fTmpLines.Count - 1 do
       if (Pos('FAST', UpperCase(fTmpLines[TmpLinesStrNo])) > 0) then
        for ValueStrNo:= 0 to Chain.Links[I].ValuesStr.Count - 1 do
         if (Pos('FAST', UpperCase(Chain.Links[I].ValuesStr[ValueStrNo])) > 0) then
          Chain.Links[I].ValuesStr[ValueStrNo]:= fTmpLines[TmpLinesStrNo];
      ComboBoxLinksChange(Self);
     end;
    end;
   except

   end;
end;

procedure T_FormChainEditor.EditDepressionVolumeChange(Sender: TObject);
begin
 fNeedToBuildSSK_TableList:= True;
end;

procedure T_FormChainEditor.EditDepressionLChange(Sender: TObject);
begin
 fNeedToBuildSSK_TableList:= True;
end;

procedure T_FormChainEditor.Editl_meanChange(Sender: TObject);
begin
 fNeedToBuildSSK_TableList:= True;
end;

procedure T_FormChainEditor.EditTemperatureChange(Sender: TObject);
begin
 fNeedToBuildSSK_TableList:= True;
end;

procedure T_FormChainEditor.EditRA_VChange(Sender: TObject);
begin
 fNeedToBuildSSK_TableList:= True;
end;

procedure T_FormChainEditor.EditOM_VChange(Sender: TObject);
begin
 fNeedToBuildSSK_TableList:= True;
end;

end.

