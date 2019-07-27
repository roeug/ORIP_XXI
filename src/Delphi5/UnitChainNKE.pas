unit UnitChainNKE;

interface

uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
 ExtCtrls, NuclideClasses, StdCtrls, Menus;

type
 T_FormChainNKE = class(TForm)
  PanelBottom: TPanel;
  ScrollBoxImage: TScrollBox;
  Image: TImage;
  ButtonClose: TButton;
  ButtonSaveChain: TButton;
  ButtonSaveEMF: TButton;
  ButtonSaveWMF: TButton;
  CheckBoxAsDecayChain: TCheckBox;
  PopupMenuImage: TPopupMenu;
  ItemCopyStateNamesToClipbrd: TMenuItem;
  procedure FormCreate(Sender: TObject);
  procedure ButtonCloseClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
  procedure FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
  procedure ButtonSaveChainClick(Sender: TObject);
  procedure ButtonSaveEMFClick(Sender: TObject);
  procedure ButtonSaveWMFClick(Sender: TObject);
  procedure ItemCopyStateNamesToClipbrdClick(Sender: TObject);
  procedure PopupMenuImagePopup(Sender: TObject);
  procedure ImageDblClick(Sender: TObject);
  procedure ImageMouseUp(Sender: TObject; Button: TMouseButton;
   Shift: TShiftState; X, Y: Integer);
 private
  fMouseX, fMouseY: integer;
  fMamaThZpA_s: integer;
  fMamaState: TNuclideState;
  fNuclideList: TNuclideList;
  fSubBranchingRecordList: TSubBranchingRecordList;
  fSaveDialog: TSaveDialog;
  procedure SetMamaThZpA_s(aMamaThZpA_s: integer);
  procedure SetImageSize(const aWidth, aHeight: integer);
 public
  { Public declarations }
  property SaveDialog: TSaveDialog read fSaveDialog write fSaveDialog;
  procedure PaintTheChain;
  procedure PaintDecayChain;
  property SubBranchingRecordList: TSubBranchingRecordList read fSubBranchingRecordList write fSubBranchingRecordList;
  property MamaThZpA_s: integer read fMamaThZpA_s write SetMamaThZpA_s;
  property NuclideList: TNuclideList read fNuclideList write fNuclideList;
 end;
 
var
 _FormChainNKE: T_FormChainNKE;
 
implementation

{$R *.DFM}

uses
 ChainClasses, CadClasses, EuLib, UnitNK, Clipbrd, UnitEditNuclide;

var
 fChain: TChain;
 fChainImage: TChainCAD;

{ T_FormChainNKE }
 
procedure T_FormChainNKE.SetImageSize(const aWidth, aHeight: integer);

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
 if ((Image.Picture.Graphic) <> nil) then
  try
   if ((Image.Picture.Graphic.Height <> aHeight) or (Image.Picture.Graphic.Width <> aWidth)) then
   begin
    Image.Height:= aHeight;
    Image.Picture.Graphic.Height:= aHeight;
    Image.Width:= aWidth;
    Image.Picture.Graphic.Width:= aWidth;
   end;
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

procedure T_FormChainNKE.SetMamaThZpA_s(aMamaThZpA_s: integer);
var
 I, SavefMamaThZpA_s: integer;
 MamaAndChilds: TLongIntList;
 aState: TNuclideState;
 StateName: string;
begin
 SavefMamaThZpA_s:= fMamaThZpA_s;
 try
  aState:= NuclideList.FindThZpA_sState(aMamaThZpA_s);
  if (aState <> nil) then
  begin
   if not ((aState.IsStable) or (aState.T1_2 <= 0)) then
   begin
    fChain.Links.Clear;
    fChain.States.Clear;
    fMamaThZpA_s:= aMamaThZpA_s;
    fMamaState:= fNuclideList.FindThZpA_sState(fMamaThZpA_s);
    if fMamaState <> nil then
    begin
     Self.Caption:= 'Network chain ' + fMamaState.Name + ' and decay products';
     PanelBottom.Enabled:= True;
// Build Chain
     MamaAndChilds:= TLongIntList.Create;
     try
      MamaAndChilds.AddUniq(fMamaThZpA_s);
      if GetAllDPR(fMamaThZpA_s, fNuclideList, fSubBranchingRecordList, MamaAndChilds) > 0 then
      begin
       fChainImage.Links.Clear;
       fChainImage.States.Clear;
       for I:= 0 to MamaAndChilds.Count - 1 do
       begin
        aState:= fNuclideList.FindThZpA_sState(MamaAndChilds[I]);
        StateName:= aState.Name;
        fChainImage.AddStateByName(StateName, True, [ntDecay], fNuclideList, nil);
        repeat
         Application.ProcessMessages;
        until not (fChainImage.Working);
       end;
       if CheckBoxAsDecayChain.Checked then
        PaintDecayChain
       else
        PaintTheChain;
      end;
     finally
      MamaAndChilds.Free;
     end;
    end
    else
    begin
     Self.Caption:= 'NIL in Mama.State !!! ';
     PanelBottom.Enabled:= False;
     MessageDlg(
      'The nuclide state not found' + #13 + #10 + 'The decay chain is empty !', mtWarning, [mbOK], 0);
     fMamaThZpA_s:= SavefMamaThZpA_s;
    end;
   end
   else
   begin
    MessageDlg('The decay chain is empty ' + #13 + #10 + 'May be parent is stable ' + #13 + #10 + '       or ' + #13 + #10 + 'the half-life unknown', mtWarning, [mbOK], 0);
    fMamaThZpA_s:= SavefMamaThZpA_s;
    exit;
   end;
  end
  else
  begin
   MessageDlg('The decay chain is empty (Nuclide was not found in NuclideList)', mtWarning, [mbOK], 0);
   fMamaThZpA_s:= SavefMamaThZpA_s;
   exit;
  end;
 except
  fMamaThZpA_s:= SavefMamaThZpA_s;
 end;
end;

procedure T_FormChainNKE.FormCreate(Sender: TObject);
begin
 fNuclideList:= _FormNK.NuclideList;
 fSaveDialog:= _FormNK.SaveDialog;
 fChain:= TChain.Create;
 fChainImage:= TChainCAD.Create(fChain);
 fChainImage.OnChange:= nil;
 fChainImage.Canvas:= nil;
 fChainImage.ShowHalfLife:= True;
end;

procedure T_FormChainNKE.ButtonCloseClick(Sender: TObject);
begin
 Self.Close;
end;

procedure T_FormChainNKE.FormShow(Sender: TObject);
begin
 Application.ProcessMessages;
 Application.ProcessMessages;
 Image.Visible:= True;
 SetImageSize(fChainImage.Width, fChainImage.Height);
 Application.ProcessMessages;
end;

procedure T_FormChainNKE.FormKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
 if Key = vk_escape then
  Close;
end;

procedure T_FormChainNKE.ButtonSaveChainClick(Sender: TObject);
var
 OldFilterIndex: integer;
 OldFilter, OldExt: string;
begin
 with SaveDialog do
 begin
  OldFilterIndex:= FilterIndex;
  OldExt:= DefaultExt;
  OldFilter:= Filter;
  Filter:= 'Chain files (*.chn)|*.CHN';
  DefaultExt:= 'chn';
  FilterIndex:= 1;
  FileName:= '';
  if Execute then
  begin
   if not (fChainImage.SaveChainToFile(SaveDialog.FileName)) then
    MessageDlg('Some problems with save !!!', mtWarning, [mbOK], 0);
  end;
  DefaultExt:= OldExt;
  FilterIndex:= OldFilterIndex;
  Filter:= OldFilter;
 end;
end;

procedure T_FormChainNKE.ButtonSaveEMFClick(Sender: TObject);
var
 OldFilterIndex: integer;
 OldFilter, OldExt: string;
 SaveCanvas, MetaFileCanvas: TCanvas;
 MetaFile: TMetafile;
begin
 with SaveDialog do
 begin
  OldFilterIndex:= FilterIndex;
  OldExt:= DefaultExt;
  DefaultExt:= 'emf';
  OldFilter:= Filter;
  Filter:= 'Enchanced Windows meta files (*.emf)|*.EMF';
  FilterIndex:= 1;
  FileName:= '';
  if Execute then
  begin
   SaveCanvas:= fChainImage.Canvas;
   MetaFile:= TMetafile.Create;
   MetaFile.Enhanced:= True; // EMF
   MetaFile.Height:= fChainImage.Height;
   MetaFile.Width:= fChainImage.Width;
   MetaFileCanvas:= TMetafileCanvas.Create(MetaFile, 0);
   MetaFileCanvas.Font.Name:= 'Times';
   try
    fChainImage.Canvas:= MetaFileCanvas;
    if CheckBoxAsDecayChain.Checked then
     fChainImage.PaintAsDecayChain
    else
    begin
     fChainImage.PaintStates;
     fChainImage.PaintLinks;
    end;
   finally
    MetaFileCanvas.Free;
    MetaFile.SaveToFile(SaveDialog.FileName);
    fChainImage.Canvas:= SaveCanvas;
    MetaFile.Free;
   end;
  end;
  DefaultExt:= OldExt;
  Filter:= OldFilter;
  FilterIndex:= OldFilterIndex;
 end;
end;

procedure T_FormChainNKE.ButtonSaveWMFClick(Sender: TObject);
var
 OldFilterIndex: integer;
 OldFilter, OldExt: string;
 SaveCanvas, MetaFileCanvas: TCanvas;
 MetaFile: TMetafile;
begin
 with SaveDialog do
 begin
  OldFilterIndex:= FilterIndex;
  OldExt:= DefaultExt;
  OldFilter:= Filter;
  DefaultExt:= 'wmf';
  Filter:= 'Windows meta files (*.wmf)|*.WMF';
  FilterIndex:= 1;
  FileName:= '';
  if Execute then
  begin
   SaveCanvas:= fChainImage.Canvas;
   MetaFile:= TMetafile.Create;
   MetaFile.Enhanced:= False; // WMF
   MetaFile.Height:= fChainImage.Height;
   MetaFile.Width:= fChainImage.Width;
   MetaFileCanvas:= TMetafileCanvas.Create(MetaFile, 0);
   MetaFileCanvas.Font.Name:= 'Times';
   try
    fChainImage.Canvas:= MetaFileCanvas;
    if CheckBoxAsDecayChain.Checked then
     fChainImage.PaintAsDecayChain
    else
    begin
     fChainImage.PaintStates;
     fChainImage.PaintLinks;
    end;
   finally
    MetaFileCanvas.Free;
    MetaFile.SaveToFile(SaveDialog.FileName);
    fChainImage.Canvas:= SaveCanvas;
    MetaFile.Free;
   end;
  end;
  DefaultExt:= OldExt;
  Filter:= OldFilter;
  FilterIndex:= OldFilterIndex;
 end;
end;

procedure T_FormChainNKE.PaintTheChain;
var
 SaveCursor: TCursor;
begin
 if fChain <> nil then
 begin
  Image.Canvas.Brush.Color:= clWhite;
  Image.Canvas.FillRect(Image.Canvas.ClipRect);
  fChainImage.Canvas:= Image.Canvas;
  SaveCursor:= Screen.Cursor;
  Screen.Cursor:= crHourGlass;
  ScrollBoxImage.Enabled:= False;
  Image.Visible:= False;
  SetImageSize(4000, 2000);
  Application.ProcessMessages;
  if not (fChainImage.PaintStates) then
   MessageDlg('Some problems for paint states !!!', mtWarning, [mbOK], 0);
  if not (fChainImage.PaintLinks) then
   MessageDlg('Some problems for paint links !!!', mtWarning, [mbOK], 0);
  SetImageSize(fChainImage.Width, fChainImage.Height);
  ScrollBoxImage.Enabled:= True;
  Image.Visible:= True;
  Screen.Cursor:= SaveCursor;
 end;
end;

procedure T_FormChainNKE.PaintDecayChain;
var
 OnImageChangeSave: TNotifyEvent;
 SaveCursor: TCursor;
begin
 if fChain <> nil then
 begin
  fChainImage.ClearCADwoChainClean;
  Image.Canvas.Brush.Color:= clWhite;
  Image.Canvas.FillRect(Image.Canvas.ClipRect);
  fChainImage.Canvas:= Image.Canvas;
  SaveCursor:= Screen.Cursor;
  Screen.Cursor:= crHourGlass;
  ScrollBoxImage.Enabled:= False;
  Image.Visible:= False;
  SetImageSize(4000, 2000);
  if Assigned(fChainImage.OnChange) then
  begin
   OnImageChangeSave:= fChainImage.OnChange;
   fChainImage.OnChange:= nil;
  end
  else
   OnImageChangeSave:= nil;
  Application.ProcessMessages;
  if not (fChainImage.PaintAsDecayChain) then
   MessageDlg('Some problems for PaintAsDecayChain; !!!', mtWarning, [mbOK], 0);
  SetImageSize(fChainImage.Width, fChainImage.Height);
  if Assigned(OnImageChangeSave) then
  begin
   fChainImage.OnChange:= OnImageChangeSave;
   fChainImage.OnChange(Self);
  end;
  ScrollBoxImage.Enabled:= True;
  Image.Visible:= True;
  Screen.Cursor:= SaveCursor;
 end;
end;

procedure T_FormChainNKE.ItemCopyStateNamesToClipbrdClick(Sender: TObject);
var
 I: integer;
 NameList: TStringList;
 Txt: string;
begin
 if fChain <> nil then
 begin
  Txt:= '';
  NameList:= TStringList.Create;
  NameList.Duplicates:= dupIgnore;
  NameList.Sorted:= True;
  try
   try
    fChain.ListStates(NameList);
    for I:= 0 to NameList.Count - 1 do
     Txt:= Txt + NameList[I] + ',';
    Clipboard.AsText:= Copy(Txt, 1, Length(Txt) - 1);
   except
    MessageDlg('Error in CopyStateNames to clipboard', mtWarning, [mbOK], 0);
   end;
  finally
   NameList.Free;
  end;
 end;
end;

procedure T_FormChainNKE.PopupMenuImagePopup(Sender: TObject);
begin
 ItemCopyStateNamesToClipbrd.Enabled:= False;
 if fChain <> nil then
  if fChain.States.Count > 0 then
  begin
   ItemCopyStateNamesToClipbrd.Enabled:= True;
  end;
end;

procedure T_FormChainNKE.ImageDblClick(Sender: TObject);
var
 I: integer;
 aThZpA, aStateNo, InNKlistNo: integer;
 aNuclide: TNuclide;
begin
 if fChain <> nil then
  try
   I:= fChainImage.FindStateAtXY(fMouseX, fMouseY);
   if ((I >= 0) and (I < fChainImage.States.Count)) then
   begin
//    MessageDlg('StateName = ' + fChainImage.States[I].State.Name, mtInformation, [mbOK], 0);
    aThZpA:= fChainImage.States[I].State.ThZpA_s div 10;
    aStateNo:= fChainImage.States[I].State.ThZpA_s mod 10;
    InNKlistNo:= _FormNK.NuclideList.FindInList(aThZpA div 1000, aThZpA mod 1000);
    aNuclide:= _FormNK.NuclideList[InNKlistNo];
    with _FormNK do
     if ((Visible) and (InNKlistNo >= 0)) then
     begin
      if aStateNo < NuclideList[InNKlistNo].StateList.Count then
      begin
//       GoToThZpACenter(aThZpA);
//       StringGridNKDblClick(Self);
       with _FormEditNuclide do
       begin
        NuclideAttached:= True;
        LinkedNuclideList:= NuclideList;
        Nuclide:= aNuclide;
        InitZnum:= aThZpA div 1000;
        InitAMass:= aThZpA mod 1000;
        InitThZpA:= 1000 * InitZnum + InitAmass;
        Show;
       end;
       with _FormEditNuclide do
        if Visible then
         case aStateNo of
          0: if SpeedButtonGstate.Visible then
           begin
            SpeedButtonGstate.Down:= True;
            SpeedButtonGstateClick(Self);
           end;
          1: if SpeedButtonM1state.Visible then
           begin
            SpeedButtonM1state.Down:= True;
            SpeedButtonM1stateClick(Self);
           end;
          2: if SpeedButtonM2state.Visible then
           begin
            SpeedButtonM2state.Down:= True;
            SpeedButtonM2stateClick(Self);
           end;
         end;
      end
      else
       MessageDlg('The state not found in NUKLIDKARTE !', mtWarning, [mbOK], 0);
     end;

   end;
  except

  end;
end;

procedure T_FormChainNKE.ImageMouseUp(Sender: TObject;
 Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 fMouseX:= X;
 fMouseY:= Y;
end;

end.

