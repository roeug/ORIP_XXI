unit UnitNK;

interface

uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
 Grids, StdCtrls, ComCtrls, Menus, NuclideClasses, Spin, ExtCtrls, Buttons,
 RXCtrls, RXGrids, RXSplit, PanelFileName, RxHook, Placemnt, ActnList, EuLib;

type
 T_FormNK=class(TForm)
  PopupMenuNK: TPopupMenu;
  Legenda: TMenuItem;
  Increase: TMenuItem;
  Decrease: TMenuItem;
  Diagonal: TMenuItem;
  PanelTop: TPanel;
  EditNuclide: TMenuItem;
  ItemMore: TMenuItem;
  SpeedButtonOpenDB: TSpeedButton;
  SpeedButtonIncrease: TSpeedButton;
  SpeedButtonDecrease: TSpeedButton;
  PopupMenuList: TPopupMenu;
  AddItem: TMenuItem;
  DeleteItem: TMenuItem;
  ClearItem: TMenuItem;
  SeeItem: TMenuItem;
  LoadDetailItem: TMenuItem;
  LoadRIitem: TMenuItem;
  LoadAlphaItem: TMenuItem;
  LoadBetaItem: TMenuItem;
  LoadGammaItem: TMenuItem;
  LoadAllDetailItem: TMenuItem;
  AddRemoveRegimItem: TMenuItem;
  EditNuclide2nd: TMenuItem;
  ListBoxUserList: TListBox;
  PopupMenuUserList: TPopupMenu;
  DeleteUserItem: TMenuItem;
  UserRepaint: TMenuItem;
  RxSpeedButtonOptions: TRxSpeedButton;
  PopupMenuOptions: TPopupMenu;
  ItemPeriod: TMenuItem;
  ItemSigma: TMenuItem;
  ItemRI: TMenuItem;
  ItemNP: TMenuItem;
  N3: TMenuItem;
  ItemBlackFontColor: TMenuItem;
  ItemSigmaF: TMenuItem;
  ItemRIf: TMenuItem;
  ButtonReloadDB: TButton;
  ButtonUserList: TSpeedButton;
  SpeedButtonInfo: TSpeedButton;
  ItemNA: TMenuItem;
  ItemN2N: TMenuItem;
  ItemNN: TMenuItem;
  N1: TMenuItem;
  ItemG_factor: TMenuItem;
  ItemHasProducts: TMenuItem;
  ItemOneHasProducts: TMenuItem;
  ItemChoose: TMenuItem;
  ItemSaveSetting: TMenuItem;
  ButtonGoTo: TButton;
  RxWindowHook: TRxWindowHook;
  StringGridNK: TStringGrid;
  PanelDockLeft: TPanel;
  SplitterLeft: TSplitter;
  PageControlDockLeft: TPageControl;
  PanelDockRight: TPanel;
  PageControlDockRight: TPageControl;
  SplitterRight: TSplitter;
  SpeedButtonChoose: TSpeedButton;
  FormPlacement: TFormPlacement;
  ItemShowProducts: TMenuItem;
  Timer: TTimer;
  PanelDatabaseName: TPanelFileName;
    SpeedButtonAddRemoveRegim: TSpeedButton;
    SpeedButtonChooseWithDPR: TSpeedButton;
    SaveDialog: TSaveDialog;
  procedure StringGridNKDrawCell(Sender: TObject; ACol, ARow: Integer;
   Rect: TRect; State: TGridDrawState);
  procedure FormShow(Sender: TObject);
  procedure ButtonReloadDBClick(Sender: TObject);
  procedure FormCreate(Sender: TObject);
  procedure StringGridNKKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
  procedure StringGridNKDblClick(Sender: TObject);
  procedure LegendaClick(Sender: TObject);
  procedure IncreaseClick(Sender: TObject);
  procedure DecreaseClick(Sender: TObject);
  procedure DiagonalClick(Sender: TObject);
  procedure EditNuclideClick(Sender: TObject);
  procedure ItemMoreClick(Sender: TObject);
  procedure SpeedButtonOpenDBClick(Sender: TObject);
  procedure SpeedButtonIncreaseClick(Sender: TObject);
  procedure SpeedButtonDecreaseClick(Sender: TObject);
  procedure FormDestroy(Sender: TObject);
  procedure PopupMenuListPopup(Sender: TObject);
  procedure ClearItemClick(Sender: TObject);
  procedure StringGridNKClick(Sender: TObject);
  procedure AddItemClick(Sender: TObject);
  procedure DeleteItemClick(Sender: TObject);
  procedure FormClose(Sender: TObject; var Action: TCloseAction);
  procedure LoadRIitemClick(Sender: TObject);
  procedure LoadAlphaItemClick(Sender: TObject);
  procedure LoadBetaItemClick(Sender: TObject);
  procedure LoadGammaItemClick(Sender: TObject);
  procedure LoadAllDetailItemClick(Sender: TObject);
  procedure AddRemoveRegimItemClick(Sender: TObject);
  procedure StringGridNKMouseUp(Sender: TObject; Button: TMouseButton;
   Shift: TShiftState; X, Y: Integer);
  procedure SpeedButtonAddRemoveRegimClick(Sender: TObject);
  procedure EditNuclide2ndClick(Sender: TObject);
  procedure PopupMenuNKPopup(Sender: TObject);
  procedure ButtonUserListClick(Sender: TObject);
  procedure ListBoxUserListDblClick(Sender: TObject);
  procedure PopupMenuUserListPopup(Sender: TObject);
  procedure DeleteUserItemClick(Sender: TObject);
  procedure UserRepaintClick(Sender: TObject);
  procedure ItemSigmaClick(Sender: TObject);
  procedure ItemPeriodClick(Sender: TObject);
  procedure ItemRIClick(Sender: TObject);
  procedure ItemBlackFontColorClick(Sender: TObject);
  procedure ItemSigmaFClick(Sender: TObject);
  procedure ItemRIfClick(Sender: TObject);
  procedure SpeedButtonInfoClick(Sender: TObject);
  procedure ItemNPClick(Sender: TObject);
  procedure ItemNAClick(Sender: TObject);
  procedure ItemN2NClick(Sender: TObject);
  procedure ItemNNClick(Sender: TObject);
  procedure ItemG_factorClick(Sender: TObject);
  procedure FormPaint(Sender: TObject);
  procedure StringGridNKTopLeftChanged(Sender: TObject);
  procedure ItemChooseClick(Sender: TObject);
  procedure SpeedButtonChooseClick(Sender: TObject);
  procedure ButtonGoToClick(Sender: TObject);
  procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  procedure StringGridNKKeyUp(Sender: TObject; var Key: Word;
   Shift: TShiftState);
  procedure RxWindowHookBeforeMessage(Sender: TObject;
   var Msg: TMessage; var Handled: Boolean);
  procedure PageControlDockLeftUnDock(Sender: TObject; Client: TControl;
   NewTarget: TWinControl; var Allow: Boolean);
  procedure PageControlDockLeftDockDrop(Sender: TObject;
   Source: TDragDockObject; X, Y: Integer);
  procedure PageControlDockRightDockDrop(Sender: TObject;
   Source: TDragDockObject; X, Y: Integer);
  procedure PageControlDockRightUnDock(Sender: TObject; Client: TControl;
   NewTarget: TWinControl; var Allow: Boolean);
  procedure ItemSaveSettingClick(Sender: TObject);
  procedure FormPlacementRestorePlacement(Sender: TObject);
  procedure StringGridNKMouseDown(Sender: TObject; Button: TMouseButton;
   Shift: TShiftState; X, Y: Integer);
  procedure StringGridNKMouseMove(Sender: TObject; Shift: TShiftState; X,
   Y: Integer);
  procedure ItemShowProductsClick(Sender: TObject);
  procedure PageControlDockRightDockOver(Sender: TObject;
   Source: TDragDockObject; X, Y: Integer; State: TDragState;
   var Accept: Boolean);
  procedure TimerTimer(Sender: TObject);
  procedure StringGridNKExit(Sender: TObject);
  procedure PanelTopResize(Sender: TObject);
  procedure RxSpeedButtonOptionsClick(Sender: TObject);
  procedure PanelDatabaseNameResize(Sender: TObject);
    procedure SpeedButtonChooseWithDPRClick(Sender: TObject);
 private
    { Private declarations }
  fAddRemoveRegim: Boolean;
  fTheDataModule: TDataModule;
  fWritableDir: Boolean;
// for Mouse Moving
  fHandMoving: Boolean;
  fSCol: Longint;
  fSRow: Longint;
  fStringGrid1BottomThreshold, fStringGrid1RightThreshold: Integer;
  fXThreshold, fYThreshold: integer;
  fPopupMenuOptionsPopupPoint: TPoint;
  fWantInfo: Boolean;
  procedure SetAddRemoveRegim(Regim: Boolean);
  procedure ItemANYhasProductsClick(Sender: TObject);
 public
    { Public declarations }
//  IDebug: integer;
  FullScreen: Boolean;
  NuclideList, UserList: TNuclideList;
  ElementList: TElementList;
  KarteInfo: TKarteInfo;
  NuclideImage: TMetafile;
  UserSelect: TPoint; // ZnumAmass
  ShowSplashScreen: Boolean;
  FissionProductZnumList, FissionProductAmassMinList: TLongIntList;
  procedure LoadPaintElements;
  function ColRowToZnumAmass(const ColRow: TPoint): TPoint;
  function ZnumAmassToColRow(const ZnumAmass: TPoint): TPoint;
  procedure UpdateUserListBox;
  procedure PrepareGoTo(const ToCol, ToRow: integer);
  procedure GoToThZpACenter(aThZpA: integer);
  procedure PrepareGoToCenter(const ToCol, ToRow: integer);
  property AddRemoveRegim: Boolean read fAddRemoveRegim write SetAddRemoveRegim;
  property TheDataModule: TDataModule read fTheDataModule write fTheDataModule;
 end;
 
var
 _FormNK: T_FormNK;
 
implementation
uses
 ChainClasses,
{$IFDEF RELEASE}
{$ELSE}
 UnitDialog1,
{$ENDIF}
 UnitLegend, UnitDM_DAO, UnitDM_OOB,
 UnitEditNuclide, Math, UnitEditElement, UnitSplash, //UnitChain,
 UnitChooseCriteria, UnitGoToDialog, UnitFrmList, UnitDPrChooseCriteriaNKE,
  UnitChainNKE;
type
 T_FormNK_Thread=class(TThread)
 private
//
 protected
  procedure Execute; override;
  procedure ForeSeeCellDraw;
 end;
 
const
 crHandGrabEu=66;
 XY_Threshold=24;
 hc_Introduction=1;
 
var
 TmpNuclide: TNuclide;
 _FormEditNuclide2: T_FormEditNuclide;
 ThreadDrawStringGridObjects: T_FormNK_Thread;
 Thread_dXdY: integer;
 MinusTimeZoneInformation_Bias: integer;
 
{$R *.DFM}
{$R NKE_Eu.res}
 
function TextFormat(const aFloat: Float): string;
begin
 Result:= Trim(Format('%-5.5g', [aFloat]));
end;

function T_FormNK.ColRowToZnumAmass(const ColRow: TPoint): TPoint;
begin
 with StringGridNK do begin
  Result.X:= RowCount-ColRow.Y;
  Result.Y:= Result.X+ColRow.X-2;
 end;
end;

function T_FormNK.ZnumAmassToColRow(const ZnumAmass: TPoint): TPoint;
begin
 with StringGridNK do begin
  Result.X:= ZnumAmass.Y-ZnumAmass.X+2;
  Result.Y:= StringGridNK.RowCount-ZnumAmass.X;
  if Result.X<0 then
   Result.X:= 0
  else if Result.X>ColCount-1 then
   Result.X:= ColCount-1;
  if Result.Y<0 then
   Result.Y:= 0
  else if Result.Y>RowCount-1 then
   Result.Y:= RowCount-1;
 end;
end;

procedure T_FormNK.StringGridNKDrawCell(Sender: TObject; ACol, ARow: Integer;
 Rect: TRect; State: TGridDrawState);
var
 aZnumAmass: TPoint;
 I, K, L: integer;
 TopFontColor: TColor;
 BottomFontColor: array[0..2] of TColor;
 TmpFloat: Float;
 aRect: TRect;
begin
 with StringGridNK.Canvas do begin
  Brush.Style:= bsSolid;
  Brush.Color:= clWhite;
  FillRect(Rect);
  Brush.Style:= bsClear;
  with Font do begin
   Assign(KarteInfo.FontSymbol);
   Color:= clRed;
   Size:= 10; //StringGridNK.DefaultRowHeight div 4;
//   Style:= [fsBold];
  end;
  Pen.Color:= Font.Color;
  if (aRow=0)and(aCol=0) then begin
   TextOut(Rect.Left+1, Rect.Top+(StringGridNK.RowHeights[0]div 2)-3, 'Z');
   TextOut(Rect.Left+(StringGridNK.ColWidths[0]div 2), Rect.Top+1, 'N');
   with Rect do begin
    MoveTo(Left, Top);
    LineTo(Right, Bottom);
   end;
  end
  else if (ARow=0)and(ACol>2) then
   TextOut(Rect.Left+1, Rect.Top+1, IntToStr(aCol-2))
  else if (aCol=0)and(aRow>0) then
   TextOut(Rect.Left+1, Rect.Top+3, IntToStr(StringGridNK.RowCount-aRow))
  else begin// Nuclides or Element or Empty
   aZnumAmass.X:= aCol;
   aZnumAmass.Y:= aRow;
   aZnumAmass:= ColRowToZnumAmass(aZnumAmass);
   I:= NuclideList.FindInList(aZnumAmass.X, aZnumAmass.Y);
   if (StringGridNK.Objects[ACol, ARow]=nil)and(I>=0) then //Paint Image
    StringGridNK.Objects[ACol, ARow]:= TNuclide(NuclideList[I]).GetMetafile(KarteInfo, False);
   if (StringGridNK.Objects[ACol, ARow]<>nil) then begin//Has Image
    StretchDraw(Rect, StringGridNK.Objects[ACol, ARow]as TMetafile);
    if ((I>=0)and(Rect.Left>24)and(Rect.Top>24)) then
    begin//Nuclide Found
     with NuclideList[I] do begin
      with Font do begin
//       Name:= 'Times New Roman';
       Height:= StringGridNK.DefaultRowHeight div 3+1;
       if ItemBlackFontColor.Checked then begin
        for K:= 0 to StateList.Count-1 do
         if StateList[K].IsStable then
          BottomFontColor[K]:= clWhite
         else
          BottomFontColor[K]:= clBlack;
        case NuclideType of
         1, 2, 3: TopFontColor:= clWhite;
        else TopFontColor:= clBlack;
        end;
       end
       else begin
        case NuclideType of
         1: //Stable
          begin
           TopFontColor:= (clWhite xor KarteInfo.StableColor);
           BottomFontColor[0]:= (clWhite xor KarteInfo.StableColor);
          end;
         2: // Stable with MetaStable
          begin
           TopFontColor:= (clWhite xor KarteInfo.StableColor);
           BottomFontColor[0]:= (clWhite xor KarteInfo.StableColor);
           for K:= 1 to StateList.Count-1 do
            if StateList[K].Decays.Count>0 then
             BottomFontColor[K]:= (clWhite xor Color4DecayType(StateList[K].Decays[0].DecayType, KarteInfo))
            else
             BottomFontColor[K]:= (clWhite xor KarteInfo.QColor)
          end;
         3: // Primordial
          begin
           TopFontColor:= (clWhite xor KarteInfo.StableColor);
           for K:= 0 to StateList.Count-1 do
            if StateList[K].Decays.Count>0 then
             BottomFontColor[K]:= (clWhite xor Color4DecayType(StateList[K].Decays[0].DecayType, KarteInfo))
            else
             BottomFontColor[K]:= (clWhite xor KarteInfo.QColor)
          end;
         4: // Unstable including with omitted states
          begin
           if StateList[0].Decays.Count>0 then
            TopFontColor:= (clWhite xor Color4DecayType(StateList[0].Decays[0].DecayType, KarteInfo))
           else
            TopFontColor:= (clWhite xor KarteInfo.QColor);
           for K:= 0 to StateList.Count-1 do
            if StateList[K].Decays.Count>0 then
             BottomFontColor[K]:= (clWhite xor Color4DecayType(StateList[K].Decays[0].DecayType, KarteInfo))
            else
             BottomFontColor[K]:= (clWhite xor KarteInfo.QColor)
          end;
        else begin
          TopFontColor:= (clWhite xor KarteInfo.Qcolor);
          for K:= 0 to StateList.Count-1 do
           if StateList[K].Decays.Count>0 then
            BottomFontColor[K]:= (clWhite xor Color4DecayType(StateList[K].Decays[0].DecayType, KarteInfo))
           else
            BottomFontColor[K]:= (clWhite xor KarteInfo.QColor)
         end;
        end; //case
       end; // if no Black
       Color:= TopFontColor;
//(*
       if not(KarteInfo.SpecialFont) then
        TextOut(Rect.Left+2, Rect.Top, Symbol+'-'+IntToStr(Amass))
       else
        TextOut(Rect.Left+2, Rect.Top, NKstrSymbol(Symbol, IntToStr(Amass)));
//*)
//       TextOut(Rect.Left+2, Rect.Top, Symbol+'-'+IntToStr(Amass));
       Font.Color:= clBlack;
       Font.Height:= Font.Height-1;
       if ItemPeriod.Checked then
        for K:= 0 to StateList.Count-1 do begin
         Font.Color:= BottomFontColor[K];
         if not(StateList[K].IsStable) then begin
{$IFDEF RELEASE}
          if StateList[K].T1_2>0 then
{$ELSE}
{$ENDIF}
          if not(KarteInfo.SpecialFont) then
           if StateList.Count=1 then
            TextOut(Rect.Left+((Rect.Right-Rect.Left)div StateList.Count)*(StateList.Count-K-1)+1,
             Rect.Bottom-(Font.Height-4)*((K+1)mod 2+1)-4, T1_2ToStr(StateList[K].T1_2, 4))
           else
            TextOut(Rect.Left+((Rect.Right-Rect.Left)div StateList.Count)*(StateList.Count-K-1)+1,
             Rect.Bottom-(Font.Height-4)*((K+1)mod 2+1)-4, T1_2ToStr(StateList[K].T1_2, 2))
          else begin
           Font.Name:= KarteInfo.FontT1_2.Name;
           TextOut(Rect.Left+((Rect.Right-Rect.Left)div StateList.Count)*(StateList.Count-K-1)+1,
            Rect.Bottom-(Font.Height-4)*((K+1)mod 2+1)-4, T1_2ToStrSpecialFont(StateList[K].T1_2, 2))
          end;
         end
         else begin
{$IFDEF RELEASE}
          if (Abundance>0) then
{$ELSE}
{$ENDIF}
          TextOut(Rect.Left+((Rect.Right-Rect.Left)div StateList.Count)*(StateList.Count-K-1)+1,
           Rect.Bottom-(Font.Height-4)*((K+1)mod 2+1)-4, TextFormat(Abundance)+'%');

         end;
        end
       else if ItemSigma.Checked then
        for K:= 0 to StateList.Count-1 do begin
         TmpFloat:= 0;
         Font.Color:= BottomFontColor[K];
         for L:= 0 to StateList[K].Captures.Count-1 do
          if StateList[K].Captures[L].Sigma>0 then
           TmpFloat:= TmpFloat+StateList[K].Captures[L].Sigma;
{$IFDEF RELEASE}
         if TmpFloat>0 then
{$ELSE}
{$ENDIF}
         TextOut(Rect.Left+((Rect.Right-Rect.Left)div StateList.Count)*(StateList.Count-K-1),
          Rect.Bottom-(Font.Height-4)*(K+1)-3, TextFormat(TmpFloat));
        end
       else if ItemRI.Checked then
        for K:= 0 to StateList.Count-1 do begin
         TmpFloat:= 0;
         Font.Color:= BottomFontColor[K];
         for L:= 0 to StateList[K].RIs.Count-1 do
          if StateList[K].RIs[L].Value>0 then
           TmpFloat:= TmpFloat+StateList[K].RIs[L].Value;
{$IFDEF RELEASE}
         if TmpFloat>0 then
{$ELSE}
{$ENDIF}
         TextOut(Rect.Left+((Rect.Right-Rect.Left)div StateList.Count)*(StateList.Count-K-1),
          Rect.Bottom-(Font.Height-4)*(K+1)-3, TextFormat(TmpFloat));
        end
       else if ItemSigmaF.Checked then
        for K:= 0 to StateList.Count-1 do begin
         Font.Color:= BottomFontColor[K];
{$IFDEF RELEASE}
         if StateList[K].SigmaF>0 then
{$ELSE}
{$ENDIF}
         TextOut(Rect.Left+((Rect.Right-Rect.Left)div StateList.Count)*(StateList.Count-K-1),
          Rect.Bottom-(Font.Height-4)*(K+1)-3, TextFormat(StateList[K].SigmaF));
        end
       else if ItemRIf.Checked then
        for K:= 0 to StateList.Count-1 do begin
         Font.Color:= BottomFontColor[K];
{$IFDEF RELEASE}
         if StateList[K].RIf>0 then
{$ELSE}
{$ENDIF}
         TextOut(Rect.Left+((Rect.Right-Rect.Left)div StateList.Count)*(StateList.Count-K-1),
          Rect.Bottom-(Font.Height-4)*(K+1)-3, TextFormat(Statelist[K].RIf));
        end
//NEW
       else if ItemNP.Checked then
        for K:= 0 to StateList.Count-1 do begin
         Font.Color:= BottomFontColor[K];
{$IFDEF RELEASE}
         if StateList[K].SigmaNP>0 then
{$ELSE}
{$ENDIF}
         TextOut(Rect.Left+((Rect.Right-Rect.Left)div StateList.Count)*(StateList.Count-K-1),
          Rect.Bottom-(Font.Height-4)*(K+1)-3, TextFormat(Statelist[K].SigmaNP));
        end
       else if ItemNA.Checked then
        for K:= 0 to StateList.Count-1 do begin
         Font.Color:= BottomFontColor[K];
{$IFDEF RELEASE}
         if StateList[K].SigmaNA>0 then
{$ELSE}
{$ENDIF}
         TextOut(Rect.Left+((Rect.Right-Rect.Left)div StateList.Count)*(StateList.Count-K-1),
          Rect.Bottom-(Font.Height-4)*(K+1)-3, TextFormat(Statelist[K].SigmaNA));
        end
       else if ItemN2N.Checked then
        for K:= 0 to StateList.Count-1 do begin
         Font.Color:= BottomFontColor[K];
{$IFDEF RELEASE}
         if StateList[K].SigmaN2N>0 then
{$ELSE}
{$ENDIF}
         TextOut(Rect.Left+((Rect.Right-Rect.Left)div StateList.Count)*(StateList.Count-K-1),
          Rect.Bottom-(Font.Height-4)*(K+1)-3, TextFormat(Statelist[K].SigmaN2N));
        end
       else if ItemNN.Checked then
        for K:= 0 to StateList.Count-1 do begin
         Font.Color:= BottomFontColor[K];
{$IFDEF RELEASE}
         if StateList[K].SigmaNN>0 then
{$ELSE}
{$ENDIF}
         TextOut(Rect.Left+((Rect.Right-Rect.Left)div StateList.Count)*(StateList.Count-K-1),
          Rect.Bottom-(Font.Height-4)*(K+1)-3, TextFormat(Statelist[K].SigmaNN));
        end
       else if ItemG_factor.Checked then
        for K:= 0 to StateList.Count-1 do begin
         Font.Color:= BottomFontColor[K];
{$IFDEF RELEASE}
         if StateList[K].Captures.G_factor>0 then
{$ELSE}
{$ENDIF}
         TextOut(Rect.Left+((Rect.Right-Rect.Left)div StateList.Count)*(StateList.Count-K-1),
          Rect.Bottom-(Font.Height-4)*(K+1)-3, TextFormat(Statelist[K].Captures.G_factor));
        end;
       if ItemShowProducts.Checked then begin
        I:= FissionProductZnumList.IndexOf(Znum);
        if I>=0 then
         if (FissionProductAmassMinList[I]=Amass) then begin
          aRect:= Rect;
          with aRect do
           Bottom:= Top+(Bottom-Top)div 3;
          with Brush do begin
           Color:= TopFontColor;
           Style:= bsFDiagonal;
          end;
          Pen.Color:= clNone;
          Rectangle(aRect);
         end;
       end
      end;
      Brush.Style:= bsClear;
     end;
(* // Now ANY selected (was only with element or nuclide)
     if (gdSelected in State) then begin
      Pen.Color:= clBlue;
      Pen.Width:= 2;
      Rectangle(Rect.Left+1, Rect.Top+1, Rect.Right, Rect.Bottom);
     end
     else begin
//
     end;
*)
     if (UserList.FindInList(aZnumAmass.X, aZnumAmass.Y)>=0) then begin
      Pen.Color:= TopFontColor;
      Pen.Width:= 2;
      with Rect do
       Rectangle(Right-8, Top+2, Right-2, Top+8);
     end;
    end;
   end;
  end; // Nuclides or Element
  if (gdSelected in State) then begin
   Pen.Color:= clBlue;
   Pen.Width:= 2;
   Rectangle(Rect.Left+1, Rect.Top+1, Rect.Right, Rect.Bottom);
  end;
// qqqq
 end; //with StringGridNK, StringGridNK.Canvas
end;

procedure T_FormNK.FormShow(Sender: TObject);
var
 aCol, aRow, aLeftCol, aTopRow: integer;
begin
 ItemSaveSetting.Enabled:= fWritableDir;
 _FormLegend.KarteInfo:= Self.KarteInfo;
 _FormEditNuclide.KarteInfo:= Self.KarteInfo;
 if (fTheDataModule is T_DataModuleDAO) then
  T_DataModuleDAO(fTheDataModule).PanelDatabaseName:= PanelDatabaseName
 else if (fTheDataModule is T_DataModuleOOB) then
  T_DataModuleOOB(fTheDataModule).PanelDatabaseName:= PanelDatabaseName;
{$IFDEF RELEASE}
 ButtonReloadDB.Visible:= False;
 ButtonUserList.Visible:= False;
// RxSpeedButtonList.Visible:= False;
// SpeedButtonOpenDB.Visible:= False;
 SpeedButtonAddRemoveRegim.Visible:= False;
// SpeedButtonChain.Visible:= False;
 EditNuclide2nd.Visible:= False;
 ItemMore.Visible:= False;
 with _FormEditNuclide do begin
  SpeedButtonCopyState.Visible:= False;
  SpeedButtonPasteState.Visible:= False;
  CheckBoxDebug.Visible:= False;
  SpeedButtonToNuclideList.Visible:= False;
 end;
{$ELSE}
 if (fTheDataModule is T_DataModuleDAO) then
  with T_DataModuleDAO(fTheDataModule) do begin
   if FileExists('Debug.del') then
    DatabaseName:= 'test.mdb'
   else
    DatabaseName:= 'ORIP_XXI.mdb'
  end
 else if (fTheDataModule is T_DataModuleOOB) then
  with T_DataModuleOOB(fTheDataModule) do begin
   if FileExists('Debug.del') then
    DatabaseName:= 'test.oob'
   else
    DatabaseName:= 'ORIP_XXI.oob'
  end;
// ButtonReloadDBClick(Self);
 _FormDialog1.TheKarteInfo:= Self.KarteInfo;
{$ENDIF}
//in rus: A to prygaet
 with StringGridNK do begin
  aTopRow:= StringGridNK.TopRow;
  aRow:= aTopRow+StringGridNK.VisibleRowCount div 2;
  aLeftCol:= StringGridNK.LeftCol;
  aCol:= aLeftCol+StringGridNK.VisibleColCount div 2;
  StringGridNK.Col:= aCol;
  StringGridNK.Row:= aRow;
  StringGridNK.LeftCol:= aLeftCol;
  StringGridNK.TopRow:= aTopRow;
 end;
 with StringGridNK.Canvas do begin
  Font:= StringGridNK.Font;
  Brush.Style:= bsClear;
  Pen.Color:= clBlack;
 end;
 StringGridNK.SetFocus;
end;

procedure T_FormNK.ButtonReloadDBClick(Sender: TObject);
var
 I, J, K, aThZpA, InNuclideListNo: integer;
 aZnumAmass: TPoint;
 HasFissionProductList: TStringList;
 NewMenuItem: TMenuItem;
begin
 try
  Self.Enabled:= False;
  StringGridNK.Hide;
  try
   if not(FileExists('Debug.del')) then
    with ThreadDrawStringGridObjects do
     if not(Suspended) then Suspend;
   with _FormSplash do
    if (ShowSplashScreen) then begin
     Caption:= 'Data file loadind...';
     Label1.Caption:= 'Data file loadind...(wait)';
     Show;
    end;
   Caption:= 'Data file loadind...';
   PanelTop.Enabled:= False;
   ButtonReloadDB.Enabled:= False;
//   StringGridNK.Hide;
   PopupMenuNK.AutoPopup:= False;
   NuclideList.Clear;
   if (fTheDataModule is T_DataModuleDAO) then
    NuclideList.LoadFromDB(T_DataModuleDAO(fTheDataModule), _FormSplash.ProgressBar1)
   else if (fTheDataModule is T_DataModuleOOB) then
    NuclideList.LoadFromDB(T_DataModuleOOB(fTheDataModule), _FormSplash.ProgressBar1);
// Fill HasProductsSubMenu
   with ItemHasProducts do
    for I:= Count-1 downto 0 do
     Items[I].Free;
   HasFissionProductList:= TStringList.Create;
   if (fTheDataModule is T_DataModuleDAO) then
    T_DataModuleDAO(fTheDataModule).ReadHasFissionProductList(HasFissionProductList)
   else if (fTheDataModule is T_DataModuleOOB) then
    T_DataModuleOOB(fTheDataModule).ReadHasFissionProductList(HasFissionProductList);
   for I:= 0 to HasFissionProductList.Count-1 do begin
    aThZpA:= StrToInt(HasFissionProductList[I]);
    InNuclideListNo:= NuclideList.FindInList(aThZpA div 1000, aThZpA mod 1000);
    if (InNuclideListNo>=0) then begin
     NewMenuItem:= TMenuItem.Create(Self);
     NewMenuItem.Caption:= NuclideList[InNuclideListNo].Symbol+'-'+IntToStr(aThZpA mod 1000);
     NewMenuItem.Visible:= True;
     NewMenuItem.Tag:= aThZpA;
     NewMenuItem.OnClick:= ItemANYhasProductsClick;
     ItemHasProducts.Add(NewMenuItem);
    end;
   end;
   HasFissionProductList.Free;
   with StringGridNK do
    for I:= 1 to(ColCount-1) do
     for J:= 1 to(RowCount-1) do begin
      (Objects[I, J]as TMetafile).Free;
      Objects[I, J]:= nil;
     end;
   if not(FileExists('Debug.del')) then
    ThreadDrawStringGridObjects.Resume;
   LoadPaintElements;
   ButtonReloadDB.Enabled:= True;
   with StringGridNK do begin
    for J:= Max(1, LeftCol-1)to LeftCol+VisibleColCount+1 do
     for K:= Max(1, TopRow-1)to TopRow+VisibleRowCount+1 do
     begin// Nuclides or Element or Empty
      aZnumAmass.X:= J;
      aZnumAmass.Y:= K;
      aZnumAmass:= ColRowToZnumAmass(aZnumAmass);
      I:= NuclideList.FindInList(aZnumAmass.X, aZnumAmass.Y);
      if (Objects[J, K]=nil)and(I>=0) then //Paint Image
       Objects[J, K]:= TNuclide(NuclideList[I]).GetMetafile(KarteInfo, False);
     end;
    Show;
   end;
  except
   MessageDlg('Exception while nuclide list loading !', mtWarning, [mbOK], 0);
  end;
 finally
  StringGridNK.Show;
  Caption:= 'NUKLIDKARTE'; // Caption Indeed
  PopupMenuNK.AutoPopup:= not(AddRemoveRegim);
  PanelTop.Enabled:= True;
  _FormSplash.Close;
  ShowSplashScreen:= True;
  Self.Enabled:= True;
 end;
end;

procedure T_FormNK.FormCreate(Sender: TObject);
(*
 function WantItQ: Boolean;
 begin
  Result:= True;
 end;
 function WantInfo: Boolean;
 begin
  Result:= True;
 end;
*)
//(*
 function WantItQ: Boolean;
 begin
  try
   if ((MinusTimeZoneInformation_Bias<119)or(MinusTimeZoneInformation_Bias>661)) then
    Result:= True
   else
    Result:= False;
  except
   Result:= False;
  end;
 end;
 function WantInfo: Boolean;
 begin
  Result:= True;
  if ((MinusTimeZoneInformation_Bias>119)and(MinusTimeZoneInformation_Bias<301)) then
   Result:= False;
 end;
//*)
var
 TmpColor: TColor;
 aTimeZoneInformation: TTimeZoneInformation;
 HlpFile: string;
begin
 try
  fWritableDir:= IsWritableDir(ExtractFileDir(Application.ExeName));
  FullScreen:= False;
  aTimeZoneInformation.Bias:= 36;
  GetTimeZoneInformation(aTimeZoneInformation);
  if (aTimeZoneInformation.Bias<>36) then
   MinusTimeZoneInformation_Bias:= -aTimeZoneInformation.Bias
  else
   MinusTimeZoneInformation_Bias:= 180; //Moscow
  fWantInfo:= WantInfo;
  if WantItQ then
   with _FormSplash do begin
    _FormSplash.Edit.Lines.Add('E.G.Romanov looks for a job in');
    _FormSplash.Edit.Lines.Add('any civilized country.');
    _FormSplash.Edit.Lines.SaveToFile(ExtractFilePath(Application.ExeName)+'NK_team.txt');
   end;
  HlpFile:= ExtractFilePath(Application.ExeName)+'NKE.hlp';
  if not(FileExists(HlpFile)) then
   HlpFile:= 'NKE.hlp';
  Application.HelpFile:= HlpFile;
  Self.HelpFile:= HlpFile;
  with FormPlacement do begin
   Active:= False;
   IniFileName:= ExtractFilePath(Application.ExeName)+ExtractFileName(Application.ExeName);
   IniFileName:= ChangeFileExt(IniFileName, '.INI');
   if fWritableDir then // Writable Storage
    Active:= True;
  end;
  PanelDockLeft.Width:= 1;
  PanelDockRight.Width:= 1;
  SplitterLeft.Enabled:= False;
  SplitterRight.Enabled:= False;
  StringGridNK.Align:= alClient;
  _FormEditNuclide2:= nil;
  ShowSplashScreen:= False;
  WindowState:= wsMaximized;
  NuclideList:= TNuclideList.Create;
  UserList:= TNuclideList.Create;
  ElementList:= TElementList.Create;
  KarteInfo:= TKarteInfo.Create;
  with StringGridNK do begin
   ColWidths[0]:= 24;
   RowHeights[0]:= 24;
   LeftCol:= 50;
   TopRow:= RowCount-50;
  end;
  with FormPlacement, KarteInfo do begin
   TmpColor:= ReadInteger('ITcolor', 0);
   if TmpColor<>0 then
    ITcolor:= TmpColor;
   TmpColor:= ReadInteger('ECcolor', 0);
   if TmpColor<>0 then
    ECcolor:= TmpColor;
   TmpColor:= ReadInteger('BMcolor', 0);
   if TmpColor<>0 then
    BMcolor:= TmpColor;
   TmpColor:= ReadInteger('Acolor', 0);
   if TmpColor<>0 then
    Acolor:= TmpColor;
   TmpColor:= ReadInteger('SFcolor', 0);
   if TmpColor<>0 then
    SFcolor:= TmpColor;
   TmpColor:= ReadInteger('Pcolor', 0);
   if TmpColor<>0 then
    Pcolor:= TmpColor;
   TmpColor:= ReadInteger('Ncolor', 0);
   if TmpColor<>0 then
    Ncolor:= TmpColor;
   TmpColor:= ReadInteger('Qcolor', 0);
   if TmpColor<>0 then
    Qcolor:= TmpColor;
   TmpColor:= ReadInteger('Left', 0);
   if ((TmpColor>0)and(TmpColor<StringGridNK.ColCount)) then
    StringGridNK.LeftCol:= TmpColor;
   TmpColor:= ReadInteger('Top', 0);
   if ((TmpColor>0)and(TmpColor<StringGridNK.RowCount)) then
    StringGridNK.TopRow:= TmpColor;
  end;
  TmpNuclide:= TNuclide.Create(0);
  AddRemoveRegim:= SpeedButtonAddRemoveRegim.Down;
  if not(FileExists('Debug.del')) then begin
   ThreadDrawStringGridObjects:= T_FormNK_Thread.Create(True);
   ThreadDrawStringGridObjects.Priority:= tpLowest;
  end;
  FissionProductZnumList:= TLongIntList.Create;
  FissionProductAmassMinList:= TLongIntList.Create;
//qqqq
  Screen.Cursors[crHandGrabEu]:= LoadCursor(HInstance, 'CRHANDGRABEU');
 except
// CD-ROM ?
 end;
end;

procedure T_FormNK.StringGridNKKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
 if FullScreen then begin
  if Key=vk_add then begin
   Timer.Interval:= 2*Timer.Interval;
   Exit;
  end
  else if Key=VK_SUBTRACT then begin
   if Timer.Interval>200 then
    Timer.Interval:= Timer.Interval div 2+1;
   Exit;
  end;
 end;
 if ((ssShift in Shift)and(ssCtrl in Shift)) then begin
  if Key=vk_return then
   if FullScreen then begin
    FullScreen:= False;
    Timer.Enabled:= False;
    with Self do begin
     Self.BorderStyle:= bsSizeable;
     Self.WindowState:= wsNormal;
     PanelTop.Height:= 30;
    end;
   end
   else begin
    FullScreen:= True;
    Timer.Enabled:= True;
    with Self do begin
     Self.BorderStyle:= bsNone;
     Self.WindowState:= wsMaximized;
     PanelTop.Height:= 0;
    end;
   end;
 end
 else
 begin
  if Key=vk_return then begin
   StringGridNKDblClick(Self);
  end
  else if Key=vk_Up then begin
   if Diagonal.Checked then
    with StringGridNK do
     if Col<ColCount-1 then Col:= Col+1;
  end
  else if Key=vk_Down then begin
   if Diagonal.Checked then
    with StringGridNK do
     if Col>1 then Col:= Col-1;
  end
  else if Key=vk_Left then begin
   if Diagonal.Checked then
    with StringGridNK do
     if Row<RowCount-1 then Row:= Row+1;
  end
  else if Key=vk_Right then begin
   if Diagonal.Checked then
    with StringGridNK do
     if Row>1 then Row:= Row-1;
  end;
 end;
end;

procedure T_FormNK.StringGridNKDblClick(Sender: TObject);
var
 I: integer;
 ZnumAmass: TPoint;
begin
 with StringGridNK do begin
  ZnumAmass.X:= Col;
  ZnumAmass.Y:= Row;
 end;
 ZnumAmass:= ColRowToZnumAmass(ZnumAmass);
 I:= NuclideList.FindInList(ZnumAmass.X, ZnumAmass.Y);
 if I>=0 then begin
  TmpNuclide.Assign(NuclideList[I]);
  with _FormEditNuclide do begin
   NuclideAttached:= True;
   LinkedNuclideList:= NuclideList;
   Nuclide:= TmpNuclide;
   InitZnum:= ZnumAmass.X;
   InitAMass:= ZnumAmass.Y;
   InitThZpA:= 1000*InitZnum+InitAmass;
   Show;
  end;
 end
 else begin// MayBe Element
  I:= ElementList.FindInList(ZnumAmass.X);
  if I>=0 then
   if (ElementList[I].AmassMin-1=ZnumAmass.Y) then
    with _FormEditElement do begin
     Element:= ElementList[I];
     InvalidateForm;
     Show;
    end;
 end;
end;

procedure T_FormNK.LegendaClick(Sender: TObject);
begin
 with _FormLegend do begin
  if (Left=-1) then begin
   Left:= Max(Screen.Width-Width, Self.Width-Width);
   Top:= Max(Screen.Height-Height+1, Self.Height-Height+1);
  end;
  Show;
 end;
end;

procedure T_FormNK.IncreaseClick(Sender: TObject);
const
 Step=24;
begin
 with StringGridNK do begin
  DefaultColWidth:= DefaultColWidth+Step;
  DefaultRowHeight:= DefaultRowHeight+Step;
  ColWidths[0]:= 24;
  RowHeights[0]:= 24;
  if (DefaultColWidth<2*Step-1) then begin
   SpeedButtonDecrease.Enabled:= False;
   Decrease.Enabled:= False;
  end
  else begin
   SpeedButtonDecrease.Enabled:= True;
   Decrease.Enabled:= True;
  end;
  Invalidate;
 end;
end;

procedure T_FormNK.DecreaseClick(Sender: TObject);
const
 Step=24;
begin
 with StringGridNK do
  if (DefaultColWidth>2*Step-1) then begin
   DefaultColWidth:= DefaultColWidth-Step;
   DefaultRowHeight:= DefaultRowHeight-Step;
   ColWidths[0]:= 24;
   RowHeights[0]:= 24;
   if (DefaultColWidth<2*Step-1) then begin
    SpeedButtonDecrease.Enabled:= False;
    Decrease.Enabled:= False;
   end
   else begin
    SpeedButtonDecrease.Enabled:= True;
    Decrease.Enabled:= True;
   end;
  end;
end;

procedure T_FormNK.DiagonalClick(Sender: TObject);
begin
 with Diagonal do
  Checked:= not(Checked);
end;

procedure T_FormNK.LoadPaintElements;
var
 I: integer;
 ColRow: TPoint;
begin
 ElementList.Clear;
 if (fTheDataModule is T_DataModuleDAO) then
  ElementList.LoadFromDB(T_DataModuleDAO(fTheDataModule))
 else if (fTheDataModule is T_DataModuleOOB) then
  ElementList.LoadFromDB(T_DataModuleOOB(fTheDataModule));
 for I:= 0 to(ElementList.Count-1) do
  with ElementList[I] do begin
   ColRow.X:= Znum;
   ColRow.Y:= AmassMin-1;
   ColRow:= ZnumAmassToColRow(ColRow);
   StringGridNK.Objects[ColRow.X, ColRow.Y]:= GetMetafile(KarteInfo);
  end
end;

procedure T_FormNK.EditNuclideClick(Sender: TObject);
begin
 StringGridNKDblClick(Self);
end;

procedure T_FormNK.ItemMoreClick(Sender: TObject);
var
 I: integer;
 ColRow: TPoint;
begin
 with ColRow, StringGridNK do begin
  ColRow.X:= Col;
  ColRow.Y:= Row;
 end;
 ColRow:= ColRowToZnumAmass(ColRow);
 I:= NuclideList.FindInList(ColRow.X, ColRow.Y);
 if I>=0 then
{$IFDEF RELEASE}
{$ELSE}
  with _FormDialog1 do begin
   TheNuclide.Assign(NuclideList[I]);
   ShowModal;
  end;
{$ENDIF}
end;

procedure T_FormNK.SpeedButtonOpenDBClick(Sender: TObject);
var
 UnDockPosition: TRect;
begin
 if (fTheDataModule is T_DataModuleDAO) then
  with T_DataModuleDAO(fTheDataModule) do begin
   if OpenDialog.Execute then
    DatabaseName:= OpenDialog.FileName;
  end
 else if (fTheDataModule is T_DataModuleOOB) then
  with T_DataModuleOOB(fTheDataModule) do begin
   if OpenDialog.Execute then
   try
    Self.Enabled:= False;
    StringGridNK.Hide;
    FissionProductZnumList.Clear;
    FissionProductAmassMinList.Clear;
    with _FormSplash do begin
     _FormSplash.Show;
     _FormSplash.ProgressBar1.Position:= 0;
     _FormSplash.Update;
    end;
    if _FormChooseCriteria.Visible then
     _FormChooseCriteria.Close;
    with _FormEditNuclide do
     if _FormEditNuclide.Visible then begin
      if (_FormEditNuclide.HostDockSite<>nil) then begin
       UnDockPosition.Left:= Self.Left+SpeedButtonOpenDB.Left+SpeedButtonOpenDB.Width+1;
       UnDockPosition.Top:= Self.Top+PanelTop.Height+1;
       UnDockPosition.Right:= UnDockPosition.Left+_FormEditNuclide.Width;
       UnDockPosition.Bottom:= UnDockPosition.Top+StringGridNK.Height;
       _FormEditNuclide.ManualFloat(UnDockPosition);
      end;
      _FormEditNuclide.Close;
     end;
    with _FrmList do
     if _FrmList.Visible then begin
      if (_FrmList.HostDockSite<>nil) then begin
       UnDockPosition.Left:= Self.Left+Self.Width-_FrmList.Width-3;
       UnDockPosition.Top:= Self.Top+PanelTop.Height+1;
       UnDockPosition.Right:= UnDockPosition.Left+_FrmList.Width;
       UnDockPosition.Bottom:= UnDockPosition.Top+StringGridNK.Height;
       _FrmList.ManualFloat(UnDockPosition);
      end;
      _FrmList.Close;
     end;
    DatabaseName:= OpenDialog.FileName;
    ButtonReloadDBClick(Self);
    if ItemShowProducts.Checked then
     if not(T_DataModuleOOB(fTheDataModule).ReadFissionProductAmassMin(FissionProductZnumList, FissionProductAmassMinList)) then
      MessageDlg('Could not load fission product list !', mtWarning, [mbOK], 0);
   finally
    StringGridNK.Repaint;
    Self.Enabled:= True;
   end;
  end;
end;


procedure T_FormNK.SpeedButtonIncreaseClick(Sender: TObject);
begin
 IncreaseClick(Self);
end;

procedure T_FormNK.SpeedButtonDecreaseClick(Sender: TObject);
begin
 DecreaseClick(Self);
end;

procedure T_FormNK.FormDestroy(Sender: TObject);
var
 I, J: Integer;
begin
 FissionProductZnumList.Free;
 FissionProductAmassMinList.Free;
 NuclideList.Free;
 UserList.Free;
 ElementList.Free;
 KarteInfo.Free;
 TmpNuclide.Free;
 with StringGridNK do
  for I:= 0 to ColCount-1 do
   for J:= 0 to RowCount-1 do
    if (Objects[I, J]<>nil) then
     Objects[I, J].Free;
end;

procedure T_FormNK.PopupMenuListPopup(Sender: TObject);
var
 I, T: integer;
begin
 if UserList.Count>0 then begin
  SeeItem.Enabled:= True;
  ClearItem.Enabled:= True;
  LoadDetailItem.Enabled:= True;
 end
 else begin
  ClearItem.Enabled:= False;
  SeeItem.Enabled:= False;
  LoadDetailItem.Enabled:= False;
  ;
 end;
 with UserSelect do begin
  I:= NuclideList.FindInList(UserSelect.X, UserSelect.Y);
  if I<0 then begin
   AddItem.Enabled:= False;
   DeleteItem.Enabled:= False;
  end
  else begin
   with NuclideList[I] do begin
    AddItem.Caption:= '&Add '+Symbol+'-'+IntToStr(Amass);
    T:= UserList.FindInList(Znum, Amass);
   end;
   if T<0 then begin
    AddItem.Enabled:= True;
    DeleteItem.Enabled:= False;
   end
   else begin
    with NuclideList[I] do
     DeleteItem.Caption:= '&Delete '+Symbol+'-'+IntToStr(Amass);
    AddItem.Enabled:= False;
    DeleteItem.Enabled:= True;
   end;
  end;
 end;
(*
 for I:=0 to (UserList.Count-1)do begin
  NewMenuItem:= DuplicateComponents( NuclideItem)as TMenuItem;
  NewMenuItem.Caption:= ' '+UserList[I].Symbol+'-'+IntToStr(UserList[I].Amass);
  NewMenuItem.Visible:= True;
  if (I mod 20 = 0)then
   NewMenuItem.Break:= mbBreak;
  PopupMenuList.Items.Add( NewMenuItem);
 end;
 *)
end;

procedure T_FormNK.ClearItemClick(Sender: TObject);
begin
 UserList.Clear;
 StringGridNK.Repaint;
end;

procedure T_FormNK.StringGridNKClick(Sender: TObject);
begin
 with StringGridNK do begin
  UserSelect.X:= Col;
  UserSelect.Y:= Row;
 end;
 UserSelect:= ColRowToZnumAmass(UserSelect);
end;

procedure T_FormNK.AddItemClick(Sender: TObject);
var
 ListNuclide: TNuclide;
 I: integer;
begin
 I:= UserList.FindInList(UserSelect.X, UserSelect.Y);
 if I>=0 then
  UserList.Delete(I);
 I:= NuclideList.FindInList(UserSelect.X, UserSelect.Y);
 if I>=0 then begin
  ListNuclide:= TNuclide.Create(0);
  ListNuclide.Assign(NuclideList[I]);
  UserList.Add(ListNuclide);
  with StringGridNK do
   StringGridNKDrawCell(Self, Col, Row, CellRect(Col, Row), [gdFocused, gdSelected]);
 end;
end;

procedure T_FormNK.DeleteItemClick(Sender: TObject);
var
 I: integer;
begin
 I:= UserList.FindInList(UserSelect.X, UserSelect.Y);
 if I>=0 then begin
  UserList.Delete(I);
  with StringGridNK do
   StringGridNKDrawCell(Self, Col, Row, CellRect(Col, Row), [gdFocused, gdSelected]);
 end;
end;

procedure T_FormNK.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if (fTheDataModule is T_DataModuleDAO) then
  T_DataModuleDAO(fTheDataModule).PanelDatabaseName:= nil
 else if (fTheDataModule is T_DataModuleOOB) then
  T_DataModuleOOB(fTheDataModule).PanelDatabaseName:= nil;
end;

procedure T_FormNK.LoadRIitemClick(Sender: TObject);
var
 I: integer;
begin
 if (fTheDataModule is T_DataModuleDAO) then
  for I:= 0 to(UserList.Count-1) do
   UserList[I].LoadFromDB(T_DataModuleDAO(fTheDataModule), nloRI)
 else if (fTheDataModule is T_DataModuleOOB) then
  for I:= 0 to(UserList.Count-1) do
   UserList[I].LoadFromDB(T_DataModuleOOB(fTheDataModule), nloRI);
end;

procedure T_FormNK.LoadAlphaItemClick(Sender: TObject);
var
 I: integer;
begin
 if (fTheDataModule is T_DataModuleDAO) then
  for I:= 0 to(UserList.Count-1) do
   UserList[I].LoadFromDB(T_DataModuleDAO(fTheDataModule), nloAlpha)
 else if (fTheDataModule is T_DataModuleOOB) then
  for I:= 0 to(UserList.Count-1) do
   UserList[I].LoadFromDB(T_DataModuleOOB(fTheDataModule), nloAlpha);
end;

procedure T_FormNK.LoadBetaItemClick(Sender: TObject);
var
 I: integer;
begin
 if (fTheDataModule is T_DataModuleDAO) then
  for I:= 0 to(UserList.Count-1) do
   UserList[I].LoadFromDB(T_DataModuleDAO(fTheDataModule), nloBeta)
 else if (fTheDataModule is T_DataModuleOOB) then
  for I:= 0 to(UserList.Count-1) do
   UserList[I].LoadFromDB(T_DataModuleOOB(fTheDataModule), nloBeta);
end;

procedure T_FormNK.LoadGammaItemClick(Sender: TObject);
var
 I: integer;
begin
 if (fTheDataModule is T_DataModuleDAO) then
  for I:= 0 to(UserList.Count-1) do
   UserList[I].LoadFromDB(T_DataModuleDAO(fTheDataModule), nloGamma)
 else if (fTheDataModule is T_DataModuleOOB) then
  for I:= 0 to(UserList.Count-1) do
   UserList[I].LoadFromDB(T_DataModuleOOB(fTheDataModule), nloGamma);
end;

procedure T_FormNK.LoadAllDetailItemClick(Sender: TObject);
var
 I: integer;
 aStr: string;
begin
 aStr:= PanelDatabaseName.Caption;
 PanelDatabaseName.Caption:= 'Working...';
 Self.Enabled:= False;
 if (fTheDataModule is T_DataModuleDAO) then
  for I:= 0 to(UserList.Count-1) do begin
   UserList[I].LoadFromDB(T_DataModuleDAO(fTheDataModule), nloRI);
   UserList[I].LoadFromDB(T_DataModuleDAO(fTheDataModule), nloAlpha);
   UserList[I].LoadFromDB(T_DataModuleDAO(fTheDataModule), nloBeta);
   UserList[I].LoadFromDB(T_DataModuleDAO(fTheDataModule), nloGamma);
  end
 else if (fTheDataModule is T_DataModuleOOB) then
  for I:= 0 to(UserList.Count-1) do begin
   UserList[I].LoadFromDB(T_DataModuleOOB(fTheDataModule), nloRI);
   UserList[I].LoadFromDB(T_DataModuleOOB(fTheDataModule), nloAlpha);
   UserList[I].LoadFromDB(T_DataModuleOOB(fTheDataModule), nloBeta);
   UserList[I].LoadFromDB(T_DataModuleOOB(fTheDataModule), nloGamma);
  end;
 Self.Enabled:= True;
 PanelDatabaseName.Caption:= aStr;
end;

procedure T_FormNK.AddRemoveRegimItemClick(Sender: TObject);
begin
 AddRemoveRegim:= not(AddRemoveRegim);
end;

procedure T_FormNK.SetAddRemoveRegim(Regim: Boolean);
begin
 fAddRemoveRegim:= Regim;
 PopupMenuNK.AutoPopup:= not(Regim);
 AddRemoveRegimItem.Checked:= Regim;
 SpeedButtonAddRemoveRegim.Down:= Regim;
 with StringGridNK do
  if Regim then
   Options:= Options+ [goRangeSelect]
  else
   Options:= Options- [goRangeSelect];
end;

procedure T_FormNK.StringGridNKMouseDown(Sender: TObject;
 Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 StringGridNK.MouseToCell(X, Y, fScol, fSrow);
 if not(ssDouble in Shift) then
  with StringGridNK do begin
   fXThreshold:= StringGridNK.ClientWidth-XY_Threshold;
   fYThreshold:= StringGridNK.ClientHeight-XY_Threshold;
   if ((X>XY_Threshold)and(Y>XY_Threshold)and(X<fXThreshold)and(Y<fYThreshold)) then begin
//   if ((X>XY_Threshold)and(Y>XY_Threshold)and(X<fStringGrid1.ClientWidth-XY_Threshold)
//    and(Y<StringGridNK.ClientHeight-XY_Threshold)) then begin
    fHandMoving:= True;
    Screen.Cursor:= crHandGrabEu;
    fStringGrid1RightThreshold:= StringGridNK.ColCount-StringGridNK.VisibleColCount+1;
    fStringGrid1BottomThreshold:= StringGridNK.RowCount-StringGridNK.VisibleRowCount+1;
   end;
  end;
 Application.ProcessMessages;
end;

procedure T_FormNK.StringGridNKMouseMove(Sender: TObject;
 Shift: TShiftState; X, Y: Integer);
var
 c, r: Longint;
 c1, r1: Longint;
begin
// if ((X>XY_Threshold)and(Y>XY_Threshold)and(X<StringGridNK.ClientWidth-XY_Threshold)
//  and(Y<StringGridNK.ClientHeight-XY_Threshold)) then begin
 if ((X>XY_Threshold)and(Y>XY_Threshold)and(X<fXThreshold)and(Y<fYThreshold)) then begin
  if fHandMoving then
   if (ssLeft in Shift) then
    with StringGridNK do begin
     StringGridNK.MouseToCell(X, Y, c, r);
     if (c-fScol<>0)and(c>0) then begin
      c1:= StringGridNK.LeftCol-(c-fScol);
//      if ((c1>0)and(c1<StringGridNK.ColCount-StringGridNK.VisibleColCount)) then
      if ((c1>0)and(c1<fStringGrid1RightThreshold)) then
       StringGridNK.LeftCol:= c1;
     end;
     if (r-fSrow<>0)and(r>0) then begin
      r1:= StringGridNK.TopRow-(r-fSrow);
//      if ((r1>0)and(r1<StringGridNK.RowCount-StringGridNK.VisibleRowCount+1)) then
      if ((r1>0)and(r1<fStringGrid1BottomThreshold)) then
       StringGridNK.TopRow:= r1;
     end;
     Application.ProcessMessages;
    end;
 end
 else begin
  fHandMoving:= False;
  Screen.Cursor:= crDefault;
  Application.ProcessMessages;
 end;
end;

procedure T_FormNK.StringGridNKMouseUp(Sender: TObject;
 Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 aRow, aCol: integer;
begin
 fHandMoving:= False;
 Screen.Cursor:= crDefault;
 Application.ProcessMessages;
 if AddRemoveRegim then
  with StringGridNK do begin
   for aRow:= Selection.Top to Selection.Bottom do
    for aCol:= Selection.Left to Selection.Right do begin
     UserSelect.X:= aCol;
     UserSelect.Y:= aRow;
     UserSelect:= ColRowToZnumAmass(UserSelect);
     if (Button=mbLeft) then
      AddItemClick(Self)
     else if (Button=mbRight) then
      DeleteItemClick(Self);
     if ((aCol>=LeftCol)and(aRow>=TopRow)) then
      StringGridNKDrawCell(Self, aCol, aRow, CellRect(aCol, aRow), [gdSelected]);
    end; //with Grid for aCol, aRow
  end; // if AddRemoveRegim then
end;

procedure T_FormNK.SpeedButtonAddRemoveRegimClick(Sender: TObject);
begin
 AddRemoveRegim:= not(AddRemoveRegim);
end;

procedure T_FormNK.EditNuclide2ndClick(Sender: TObject);
var
 I: integer;
 ColRow: TPoint;
begin
 with ColRow, StringGridNK do begin
  ColRow.X:= Col;
  ColRow.Y:= Row;
 end;
 ColRow:= ColRowToZnumAmass(ColRow);
 I:= NuclideList.FindInList(ColRow.X, ColRow.Y);
 if I>=0 then begin
  if (_FormEditNuclide2=nil) then begin
   _FormEditNuclide2:= T_FormEditNuclide.Create(Self);
   _FormEditNuclide2.KarteInfo:= KarteInfo;
  end;
  with _FormEditNuclide2 do begin
   Left:= 25+Width;
   LinkedNuclideList:= NuclideList;
   InitZnum:= ColRow.X;
   InitAmass:= ColRow.Y;
   InitThZpA:= 1000*ColRow.X+ColRow.Y;
   Nuclide:= NuclideList[I];
   if not(Visible) then
    Show;
  end;
 end;
end;

procedure T_FormNK.PopupMenuNKPopup(Sender: TObject);
var
 I: integer;
begin
 I:= NuclideList.FindInList(UserSelect.X, UserSelect.Y);
 if I>=0 then begin
  EditNuclide.Enabled:= True;
  EditNuclide2nd.Enabled:= True;
 end
 else begin
  EditNuclide.Enabled:= False;
  EditNuclide2nd.Enabled:= False;
 end;
 if _FormEditNuclide.Visible then
  EditNuclide2nd.Enabled:= True
 else
  EditNuclide2nd.Enabled:= False;
end;

procedure T_FormNK.ButtonUserListClick(Sender: TObject);
var
 I: integer;
begin
 
 with ListBoxUserList do begin
  if not(Visible) then begin
   Items.Clear;
   for I:= 0 to(UserList.Count-1) do
    Items.Add(' '+UserList[I].Symbol+'-'+IntToStr(UserList[I].Amass));
  end;
  Visible:= not(Visible);
  ButtonUserList.Down:= Visible;
 end;
end;

procedure T_FormNK.ListBoxUserListDblClick(Sender: TObject);
var
 I, NoFounded: integer;
 ItemCaption: string;
begin
 ItemCaption:= '';
 with ListBoxUserList do
  for I:= 0 to(Items.Count-1) do
   if Selected[I] then begin
    ItemCaption:= Items[I];
    break;
   end;
 NoFounded:= -1;
 for I:= 0 to(UserList.Count-1) do
  with UserList[I] do
   if (Pos(Symbol, ItemCaption)>0)and(
    Pos(IntToStr(Amass), ItemCaption)>0) then begin
    NoFounded:= I;
    break;
   end;
 if (NoFounded>=0) then begin
// to send copy for edit
  TmpNuclide.Assign(UserList[NoFounded]);
  with _FormEditNuclide do begin
   LinkedNuclideList:= UserList;
   InitZnum:= UserList[NoFounded].Znum;
   InitAMass:= UserList[NoFounded].Amass;
   InitThZpA:= 1000*InitZnum+InitAmass;
   Nuclide:= StaticEmptyNuclide;
   Nuclide.Assign(UserList[NoFounded]);
   NuclideAttached:= True;
//   SpeedButtonGstateClick( Self);
   InvalidateForm;
   Show;
  end;
 end;
end;

procedure T_FormNK.PopupMenuUserListPopup(Sender: TObject);
var
 I, NoFounded: integer;
 ItemCaption: string;
begin
 ItemCaption:= '';
 with ListBoxUserList do
  for I:= 0 to(Items.Count-1) do
   if Selected[I] then begin
    ItemCaption:= Items[I];
    break;
   end;
 NoFounded:= -1;
 for I:= 0 to(UserList.Count-1) do
  with UserList[I] do
   if (Pos(Symbol, ItemCaption)>0)and(
    Pos(IntToStr(Amass), ItemCaption)>0) then begin
    NoFounded:= I;
    break;
   end;
 if (NoFounded>=0) then
  DeleteUserItem.Enabled:= True
 else
  DeleteUserItem.Enabled:= False;
end;

procedure T_FormNK.DeleteUserItemClick(Sender: TObject);
var
 I, NoFounded: integer;
 ItemCaption: string;
begin
 ItemCaption:= '';
 with ListBoxUserList do
  for I:= 0 to(Items.Count-1) do
   if Selected[I] then begin
    ItemCaption:= Items[I];
    break;
   end;
 NoFounded:= -1;
 for I:= 0 to(UserList.Count-1) do
  with UserList[I] do
   if (Pos(Symbol, ItemCaption)>0)and(
    Pos(IntToStr(Amass), ItemCaption)>0) then begin
    NoFounded:= I;
    break;
   end;
 if (NoFounded>=0) then
  UserList.Delete(NoFounded);
 UpdateUserListBox;
end;

procedure T_FormNK.UserRepaintClick(Sender: TObject);
begin
 StringGridNK.Repaint;
 UpdateUserListBox;
end;

procedure T_FormNK.UpdateUserListBox;
var
 I: integer;
begin
 with ListBoxUserList do begin
  Items.Clear;
  for I:= 0 to(UserList.Count-1) do
   Items.Add(' '+UserList[I].Symbol+'-'+IntToStr(UserList[I].Amass));
  Repaint;
 end;
end;

procedure T_FormNK.ItemSigmaClick(Sender: TObject);
begin
 if not(ItemSigma.Checked) then begin
  ItemSigma.Checked:= True;
  StringGridNK.Repaint;
 end;
end;

procedure T_FormNK.ItemPeriodClick(Sender: TObject);
begin
 with ItemPeriod do
  Checked:= not(Checked);
 StringGridNK.Repaint;
end;

procedure T_FormNK.ItemRIClick(Sender: TObject);
begin
 with ItemRI do
  Checked:= not(Checked);
 StringGridNK.Repaint;
end;

procedure T_FormNK.ItemBlackFontColorClick(Sender: TObject);
begin
 with ItemBlackFontColor do
  Checked:= not(Checked);
 StringGridNK.Repaint;
end;

procedure T_FormNK.ItemSigmaFClick(Sender: TObject);
begin
 with ItemSigmaF do
  Checked:= not(Checked);
 StringGridNK.Repaint;
end;

procedure T_FormNK.ItemRIfClick(Sender: TObject);
begin
 with ItemRIf do
  Checked:= not(Checked);
 StringGridNK.Repaint;
end;

procedure T_FormNK.SpeedButtonInfoClick(Sender: TObject);
begin
 if fWantInfo then begin        // QQ
  with _FormSplash do begin
   Button1.Visible:= True;
   ProgressBar1.Visible:= False;
   Label1.Visible:= False;
   ShowModal;
//   Invalidate;
  end;
  Invalidate;
 end
 else begin// Show help
  Application.HelpCommand(HELP_CONTEXT, hc_Introduction);
 end;
end;

procedure T_FormNK.ItemNPClick(Sender: TObject);
begin
 with ItemNP do
  Checked:= not(Checked);
 StringGridNK.Repaint;
end;

procedure T_FormNK.ItemNAClick(Sender: TObject);
begin
 with ItemNA do
  Checked:= not(Checked);
 StringGridNK.Repaint;
end;

procedure T_FormNK.ItemN2NClick(Sender: TObject);
begin
 with ItemN2N do
  Checked:= not(Checked);
 StringGridNK.Repaint;
end;

procedure T_FormNK.ItemNNClick(Sender: TObject);
begin
 with ItemNN do
  Checked:= not(Checked);
 StringGridNK.Repaint;
end;

procedure T_FormNK.ItemG_factorClick(Sender: TObject);
begin
 with ItemG_factor do
  Checked:= not(Checked);
 StringGridNK.Repaint;
end;

procedure T_FormNK.ItemANYhasProductsClick(Sender: TObject);
var
 ListNuclide: TNuclide;
 I, aThZpA: integer;
 ColRow: TPoint;
begin
 if (Sender is TMenuItem) then
  if ((Sender as TMenuItem).Tag>1001) then
   if ((Sender as TMenuItem).Checked) then begin
    aThZpA:= (Sender as TMenuItem).Tag;
    I:= UserList.FindInList(aThZpA div 1000, aThZpA mod 1000);
    if I>=0 then begin
     UserList.Delete(I);
     (Sender as TMenuItem).Checked:= False;
     ColRow.X:= aThZpA div 1000;
     ColRow.Y:= aThZpA mod 1000;
     ColRow:= ZnumAmassToColRow(ColRow);
     with StringGridNK do
      if ((ColRow.X>=LeftCol)and(ColRow.X<=LeftCol+ColCount)and(ColRow.Y>=TopRow)and(ColRow.Y<=TopRow+RowCount)) then
       StringGridNKDrawCell(Self, ColRow.X, ColRow.Y, CellRect(ColRow.X, ColRow.Y), []);
    end;
   end
   else begin
    aThZpA:= (Sender as TMenuItem).Tag;
    I:= NuclideList.FindInList(aThZpA div 1000, aThZpA mod 1000);
    if I>=0 then begin
     ListNuclide:= TNuclide.Create(0);
     ListNuclide.Assign(NuclideList[I]);
     UserList.Add(ListNuclide);
     ColRow.X:= aThZpA div 1000;
     ColRow.Y:= aThZpA mod 1000;
     ColRow:= ZnumAmassToColRow(ColRow);
     with StringGridNK do
      if ((ColRow.X>=LeftCol)and(ColRow.X<=LeftCol+ColCount)and(ColRow.Y>=TopRow)and(ColRow.Y<=TopRow+RowCount)) then
       StringGridNKDrawCell(Self, ColRow.X, ColRow.Y, CellRect(ColRow.X, ColRow.Y), []);
    end;
    (Sender as TMenuItem).Checked:= True;
   end;
end;

procedure T_FormNK.FormPaint(Sender: TObject);
begin
 PanelTop.Update;
end;

procedure T_FormNK_Thread.ForeSeeCellDraw;
var
 aZnumAmass: TPoint;
 I, J, K: integer;
begin
 Application.ProcessMessages;
 if (Suspended) then exit;
 if (not(_FormNK.StringGridNK.Visible)or(Suspended)) then exit;
 with _FormNK do
  with StringGridNK do begin
   if (Thread_dXdY>=ColCount) then
    Suspended:= True;
   J:= Max(0, LeftCol-Thread_dXdY); // Left region
   for K:= Max(1, TopRow-Thread_dXdY)to Min(RowCount-1, TopRow+VisibleRowCount+Thread_dXdY) do
   begin// Nuclides or Element or Empty
    Application.ProcessMessages;
    if (Suspended) then exit;
    aZnumAmass.X:= J;
    aZnumAmass.Y:= K;
    aZnumAmass:= ColRowToZnumAmass(aZnumAmass);
    I:= NuclideList.FindInList(aZnumAmass.X, aZnumAmass.Y);
    if (StringGridNK.Objects[J, K]=nil)and(I>=0) then //Paint Image
     StringGridNK.Objects[J, K]:= TNuclide(NuclideList[I]).GetMetafile(KarteInfo, False);
   end;
   J:= Min(ColCount-1, LeftCol+VisibleColCount+Thread_dXdY); // Right region
   for K:= Max(1, TopRow-Thread_dXdY)to Min(RowCount-1, TopRow+VisibleRowCount+Thread_dXdY) do
   begin// Nuclides or Element or Empty
    Application.ProcessMessages;
    if (Suspended) then exit;
    aZnumAmass.X:= J;
    aZnumAmass.Y:= K;
    aZnumAmass:= ColRowToZnumAmass(aZnumAmass);
    I:= NuclideList.FindInList(aZnumAmass.X, aZnumAmass.Y);
    if (StringGridNK.Objects[J, K]=nil)and(I>=0) then //Paint Image
     StringGridNK.Objects[J, K]:= TNuclide(NuclideList[I]).GetMetafile(KarteInfo, False);
   end;
   K:= Max(1, TopRow-Thread_dXdY); // Top region
   for J:= Max(1, LeftCol-Thread_dXdY)to Min(ColCount-1, LeftCol+VisibleColCount+Thread_dXdY) do
   begin// Nuclides or Element or Empty
    Application.ProcessMessages;
    if (Suspended) then exit;
    aZnumAmass.X:= J;
    aZnumAmass.Y:= K;
    aZnumAmass:= ColRowToZnumAmass(aZnumAmass);
    I:= NuclideList.FindInList(aZnumAmass.X, aZnumAmass.Y);
    if (StringGridNK.Objects[J, K]=nil)and(I>=0) then //Paint Image
     StringGridNK.Objects[J, K]:= TNuclide(NuclideList[I]).GetMetafile(KarteInfo, False);
   end;
   K:= Min(RowCount-1, TopRow+VisibleRowCount+Thread_dXdY); // Bottom region
   for J:= Max(1, LeftCol-Thread_dXdY)to Min(ColCount-1, LeftCol+VisibleColCount+Thread_dXdY) do
   begin// Nuclides or Element or Empty
    Application.ProcessMessages;
    if (Suspended) then exit;
    aZnumAmass.X:= J;
    aZnumAmass.Y:= K;
    aZnumAmass:= ColRowToZnumAmass(aZnumAmass);
    I:= NuclideList.FindInList(aZnumAmass.X, aZnumAmass.Y);
    if (StringGridNK.Objects[J, K]=nil)and(I>=0) then //Paint Image
     StringGridNK.Objects[J, K]:= TNuclide(NuclideList[I]).GetMetafile(KarteInfo, False);
   end;
   Inc(Thread_dXdY);
  end;
end;

procedure T_FormNK_Thread.Execute;
begin
 repeat
  Synchronize(ForeSeeCellDraw)
 until Terminated;
end;

procedure T_FormNK.StringGridNKTopLeftChanged(Sender: TObject);
begin
 Thread_dXdY:= 1;
end;

procedure T_FormNK.ItemChooseClick(Sender: TObject);
begin
 SpeedButtonChooseClick(Self);
end;

procedure T_FormNK.SpeedButtonChooseClick(Sender: TObject);
var
 I: integer;
begin
 with _FormChooseCriteria do begin
  if FirstShow then begin
   with EditZnum1 do begin
    Items.Clear;
    for I:= 0 to ElementList.Count-1 do
     Items.Add(IntToStr(ElementList[I].Znum)+'('+ElementList[I].Symbol+')');
    ItemIndex:= 0;
   end;
   with EditZnum2 do begin
    Items.Clear;
    for I:= 0 to ElementList.Count-1 do
     Items.Add(IntToStr(ElementList[I].Znum)+'('+ElementList[I].Symbol+')');
    ItemIndex:= 0;
   end;
  end;
  Show;
 end;
end;

procedure T_FormNK.GoToThZpACenter(aThZpA: integer);
var
 ZnumAmass: TPoint;
begin
 ZnumAmass.X:= aThZpA div 1000;
 ZnumAmass.Y:= aThZpA mod 1000;
 ZnumAmass:= ZnumAmassToColRow(ZnumAmass);
 with StringGridNK do begin
  RxWindowHook.WinControl:= StringGridNK; //  Enabled:=False;
  PrepareGoTo(Max(1, ZnumAmass.X-VisibleColCount div 2), Min(RowCount-VisibleRowCount, ZnumAmass.Y-VisibleRowCount div 2));
  LeftCol:= Max(1, ZnumAmass.X-VisibleColCount div 2);
  Col:= ZnumAmass.X;
  TopRow:= Min(RowCount-VisibleRowCount, ZnumAmass.Y-VisibleRowCount div 2);
  Row:= ZnumAmass.Y;
  RxWindowHook.WinControl:= nil; //  Enabled:=True;
  Repaint;
 end;
end;

procedure T_FormNK.ButtonGoToClick(Sender: TObject);
 function StrToZnum(const InStr: string): integer;
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
 
var
 I, aThZpA: integer;
 ShowResult: TModalResult;
 aZnumAmass: TPoint;
begin
 with _FormGoToDialog do begin
  if FirstShow then
   with EditZnum do begin
    Items.Clear;
    for I:= 0 to ElementList.Count-1 do
     Items.Add(IntToStr(ElementList[I].Znum)+'('+ElementList[I].Symbol+')');
    ItemIndex:= 0;
   end;
  ShowResult:= ShowModal;
  case ShowResult of
   mrOK: begin// To element
     I:= ElementList.FindInList(StrToZnum(EditZnum.Text));
     if I>=0 then begin
      aThZpA:= 1000*ElementList[I].Znum+ElementList[I].AmassMin;
      PrepareGoToCenter(ElementList[I].Znum, ElementList[I].AmassMin);
      GoToThZpACenter(aThZpA);
      if not(FileExists('Debug.del')) then
       with ThreadDrawStringGridObjects do
        if Suspended then Resume;
      StringGridNK.SetFocus;
     end;
    end;
   mrYes: begin// To Mass
     with aZnumAmass do begin
      X:= -1;
      Y:= EditAmass.Value;
      for I:= (ElementList.Count-1)downto 0 do
       if (ElementList[I].AmassMin<=Y) then begin
        X:= I+1;
        break;
       end;
      if (X<0) then begin
       MessageDlg('Nuclide with a mass  '+IntToStr(X)+' not found ', mtWarning, [mbOK], 0);
       Exit;
      end
      else begin
       PrepareGoToCenter(aZnumAmass.X, aZnumAmass.Y);
       GoToThZpACenter(1000*aZnumAmass.X+aZnumAmass.Y);
       if not(FileExists('Debug.del')) then
        with ThreadDrawStringGridObjects do
         if Suspended then Resume;
      end;
      StringGridNK.SetFocus;
     end;
    end;
   mrYesToAll: begin// To Nuclide
     aThZpA:= 1000*StrToZnum(EditZnum.Text)+EditAmass.Value;
     PrepareGoToCenter(aThZpA div 1000, aThZpA mod 1000);
     GoToThZpACenter(aThZpA);
     if not(FileExists('Debug.del')) then
      with ThreadDrawStringGridObjects do
       if Suspended then Resume;
     StringGridNK.SetFocus;
    end;
  end;
 end;
 StringGridNK.SetFocus;
end;

procedure T_FormNK.PrepareGoTo(const ToCol, ToRow: integer);
var
 I, J, K: integer;
 aZnumAmass: TPoint;
begin
 if not(FileExists('Debug.del')) then
  with ThreadDrawStringGridObjects do
   if not(Suspended) then Suspend;
 with StringGridNK do begin
  for J:= Max(1, ToCol-1)to Min(ColCount, ToCol+VisibleColCount+1) do
   for K:= Max(1, ToRow-1)to Min(RowCount, ToRow+VisibleRowCount+1) do
    with aZnumAmass do begin// Nuclides or Element or Empty
     aZnumAmass.X:= J;
     aZnumAmass.Y:= K;
     aZnumAmass:= ColRowToZnumAmass(aZnumAmass);
     I:= NuclideList.FindInList(aZnumAmass.X, aZnumAmass.Y);
     if (Objects[J, K]=nil)and(I>=0) then //Paint Image
      Objects[J, K]:= TNuclide(NuclideList[I]).GetMetafile(KarteInfo, False);
    end;
 end;
end;

procedure T_FormNK.PrepareGoToCenter(const ToCol, ToRow: integer);
begin
 with StringGridNK do
  PrepareGoTo(ToCol-VisibleColCount div 2, ToRow-VisibleRowCount div 2);
end;

procedure T_FormNK.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if not(FileExists('Debug.del')) then
  with ThreadDrawStringGridObjects do begin
   if not(Suspended) then Suspend;
   Terminate;
   Free;
  end;
end;

procedure T_FormNK.StringGridNKKeyUp(Sender: TObject; var Key: Word;
 Shift: TShiftState);
var
 ZnumAmass: TPoint;
 I: integer;
begin
 if Key=vk_end then begin
  RxWindowHook.WinControl:= StringGridNK;
  with StringGridNK, ZnumAmass do begin
   X:= Col;
   Y:= Row;
   ZnumAmass:= ColRowToZnumAmass(ZnumAmass);
   Y:= -1;
   for I:= 0 to NuclideList.Count-1 do
    if ((NuclideList[I].Znum=X)and(NuclideList[I].Amass>Y)) then
     Y:= NuclideList[I].Amass;
   ZnumAmass:= ZnumAmassToColRow(ZnumAmass);
   if ((X<ColCount-1)and(X>1)) then begin
    PrepareGoTo(X-VisibleColCount+1, TopRow);
    LeftCol:= X-VisibleColCount+1;
    Col:= X;
   end;
  end;
  RxWindowHook.WinControl:= nil;
  StringGridNK.Invalidate;
 end
 else if Key=vk_Home then begin
  RxWindowHook.WinControl:= StringGridNK;
  with StringGridNK, ZnumAmass do begin
   X:= Col;
   Y:= Row;
   ZnumAmass:= ColRowToZnumAmass(ZnumAmass);
   I:= ElementList.FindInList(X);
   if (I>=0) then begin
    Y:= ElementList[I].AmassMin;
    ZnumAmass:= ZnumAmassToColRow(ZnumAmass);
    if ((X<ColCount-1)and(X>1)) then begin
     PrepareGoTo(X-2, TopRow);
     LeftCol:= X-2;
     Col:= X;
    end;
   end;
  end;
  RxWindowHook.WinControl:= nil;
  StringGridNK.Invalidate;
 end;
end;

procedure T_FormNK.RxWindowHookBeforeMessage(Sender: TObject;
 var Msg: TMessage; var Handled: Boolean);
begin
 Handled:= True;
end;

procedure T_FormNK.PageControlDockLeftDockDrop(Sender: TObject;
 Source: TDragDockObject; X, Y: Integer);
begin
 with PanelDockLeft do
  if Width<5 then Width:= 169; //_FrmList.Width;
 SplitterLeft.Enabled:= True;
end;

procedure T_FormNK.PageControlDockLeftUnDock(Sender: TObject; Client: TControl;
 NewTarget: TWinControl; var Allow: Boolean);
begin
 if (PageControlDockLeft.DockClientCount<2) then begin
  PageControlDockLeft.Hide;
  PanelDockLeft.Width:= 1;
  PageControlDockLeft.Show;
  SplitterLeft.Enabled:= False
 end;
end;

procedure T_FormNK.PageControlDockRightDockDrop(Sender: TObject;
 Source: TDragDockObject; X, Y: Integer);
begin
 with PanelDockRight do
  if Width<5 then Width:= 169; //_FrmList.Width;
 SplitterRight.Enabled:= True;
end;

procedure T_FormNK.PageControlDockRightUnDock(Sender: TObject;
 Client: TControl; NewTarget: TWinControl; var Allow: Boolean);
begin
 if (PageControlDockRight.DockClientCount<2) then begin
  PageControlDockRight.Hide;
  PanelDockRight.Width:= 1;
  PageControlDockRight.Show;
  SplitterRight.Enabled:= False;
 end;
end;

procedure T_FormNK.PageControlDockRightDockOver(Sender: TObject;
 Source: TDragDockObject; X, Y: Integer; State: TDragState;
 var Accept: Boolean);
var
 ARect: TRect;
begin
 Accept:= ((Source.Control is T_FormEditNuclide)or(Source.Control is T_FrmList));
 if Accept then begin
  with ARect, PanelDockRight do begin
   if PanelDockRight.Width<10 then
    ARect.Left:= PanelDockRight.Left-169
   else
    ARect.Left:= PanelDockRight.Left+5;
   ARect.Top:= PanelDockRight.Top;
   ARect.Right:= PanelDockRight.Left+PanelDockRight.Width;
   ARect.Bottom:= ARect.Top+PanelDockRight.Height;
   ARect.TopLeft:= PanelTop.ClientToScreen(ARect.TopLeft);
   ARect.BottomRight:= PanelTop.ClientToScreen(ARect.BottomRight);
  end;
  Source.DockRect:= ARect;
 end;
end;

procedure T_FormNK.ItemSaveSettingClick(Sender: TObject);
begin
 try
  with FormPlacement, KarteInfo do begin
   SaveFormPlacement;
   WriteInteger('ITcolor', ITcolor);
   WriteInteger('ECcolor', ECcolor);
   WriteInteger('BMcolor', BMcolor);
   WriteInteger('Acolor', Acolor);
   WriteInteger('Pcolor', Pcolor);
   WriteInteger('Ncolor', Ncolor);
   WriteInteger('Qcolor', Qcolor);
   WriteInteger('Left', StringGridNK.LeftCol);
   WriteInteger('Top', StringGridNK.TopRow);
  end;
 except
// CD-ROM?
 end;
end;

procedure T_FormNK.FormPlacementRestorePlacement(Sender: TObject);
begin
 FormPlacement.Active:= False;
end;

procedure T_FormNK.ItemShowProductsClick(Sender: TObject);
var
 SaveCaption: TCaption;
begin
 with ItemShowProducts do
  Checked:= not(Checked);
 if ((ItemShowProducts.Checked)and(FissionProductZnumList.Count=0)) then begin
  SaveCaption:= Caption;
  Caption:= 'Data loadind ...';
  Enabled:= False;
// Fill ProductsZnumAmassMinLists
  if (fTheDataModule is T_DataModuleDAO) then begin
   if not(T_DataModuleDAO(fTheDataModule).ReadFissionProductAmassMin(FissionProductZnumList, FissionProductAmassMinList)) then
    MessageDlg('Could not load fission product list !', mtWarning, [mbOK], 0);
  end
  else if (fTheDataModule is T_DataModuleOOB) then begin
   if not(T_DataModuleOOB(fTheDataModule).ReadFissionProductAmassMin(FissionProductZnumList, FissionProductAmassMinList)) then
    MessageDlg('Could not load fission product list !', mtWarning, [mbOK], 0);
  end;
  Enabled:= True;
  Caption:= SaveCaption;
 end;
 StringGridNK.Repaint;
end;

procedure T_FormNK.TimerTimer(Sender: TObject);
var
 I, J, NewCol, NewRow, TheCol, TheRow, TheRandom: integer;
begin
 if _FormEditElement.Visible then
  _FormEditElement.Close;
 with StringGridNK do begin
  TheCol:= StringGridNK.Col;
  TheRow:= StringGridNK.Row;
  TheRandom:= Random(8);
  for I:= 1 to StringGridNK.ColCount div 2 do
   for J:= 1 to StringGridNK.RowCount div 2 do
    if TheRandom=0 then begin
     NewCol:= TheCol+2*I;
     NewRow:= TheRow+2*J;
     if (NewCol<StringGridNK.ColCount)and(NewRow<StringGridNK.RowCount) then
      if StringGridNK.Objects[NewCol, NewRow]<>nil then begin
       StringGridNK.Col:= NewCol;
       StringGridNK.Row:= NewRow;
      end;
     if ((StringGridNK.LeftCol+NewCol-TheCol>0)and(StringGridNK.LeftCol+NewCol-TheCol<StringGridNK.ColCount)) then
      StringGridNK.LeftCol:= StringGridNK.LeftCol+NewCol-TheCol;
     if ((StringGridNK.TopRow+NewRow-TheRow>0)and(StringGridNK.TopRow+NewRow-TheRow<RowCount)) then
      StringGridNK.TopRow:= StringGridNK.TopRow+NewRow-TheRow;
     if _FormEditNuclide.Visible then
      StringGridNKDblClick(Self);
     Exit;
    end
    else if TheRandom<=2 then begin
     NewCol:= TheCol+2*I;
     NewRow:= TheRow-2*J;
     if (NewCol<StringGridNK.ColCount)and(NewRow>0) then
      if StringGridNK.Objects[NewCol, NewRow]<>nil then begin
       StringGridNK.Col:= NewCol;
       StringGridNK.Row:= NewRow;
      end;
     if ((StringGridNK.LeftCol+NewCol-TheCol>0)and(StringGridNK.LeftCol+NewCol-TheCol<StringGridNK.ColCount)) then
      StringGridNK.LeftCol:= StringGridNK.LeftCol+NewCol-TheCol;
     if ((StringGridNK.TopRow+NewRow-TheRow>0)and(StringGridNK.TopRow+NewRow-TheRow<RowCount)) then
      StringGridNK.TopRow:= StringGridNK.TopRow+NewRow-TheRow;
     if _FormEditNuclide.Visible then
      StringGridNKDblClick(Self);
     Exit;
    end
    else if TheRandom=3 then begin
     NewCol:= TheCol-2*I;
     NewRow:= TheRow-2*J;
     if (NewCol>0)and(NewRow>0) then
      if StringGridNK.Objects[NewCol, NewRow]<>nil then begin
       StringGridNK.Col:= NewCol;
       StringGridNK.Row:= NewRow;
      end;
     if ((StringGridNK.LeftCol+NewCol-TheCol>0)and(StringGridNK.LeftCol+NewCol-TheCol<StringGridNK.ColCount)) then
      StringGridNK.LeftCol:= StringGridNK.LeftCol+NewCol-TheCol;
     if ((StringGridNK.TopRow+NewRow-TheRow>0)and(StringGridNK.TopRow+NewRow-TheRow<RowCount)) then
      StringGridNK.TopRow:= StringGridNK.TopRow+NewRow-TheRow;
     if _FormEditNuclide.Visible then
      StringGridNKDblClick(Self);
     Exit;
    end
    else begin
     NewCol:= TheCol-2*I;
     NewRow:= TheRow+2*J;
     if (NewCol>0)and(NewRow<StringGridNK.RowCount) then
      if StringGridNK.Objects[NewCol, NewRow]<>nil then begin
       StringGridNK.Col:= NewCol;
       StringGridNK.Row:= NewRow;
      end;
     if ((StringGridNK.LeftCol+NewCol-TheCol>0)and(StringGridNK.LeftCol+NewCol-TheCol<StringGridNK.ColCount)) then
      StringGridNK.LeftCol:= StringGridNK.LeftCol+NewCol-TheCol;
     if ((StringGridNK.TopRow+NewRow-TheRow>0)and(StringGridNK.TopRow+NewRow-TheRow<RowCount)) then
      StringGridNK.TopRow:= StringGridNK.TopRow+NewRow-TheRow;
     if _FormEditNuclide.Visible then
      StringGridNKDblClick(Self);
     Exit;
    end;
 end;
end;

procedure T_FormNK.StringGridNKExit(Sender: TObject);
begin
 fHandMoving:= False;
end;

procedure T_FormNK.PanelTopResize(Sender: TObject);
var
 dx: integer;
 Point0: TPoint;
begin
 dx:= PanelTop.Width-SpeedButtonOpenDB.Width-SpeedButtonIncrease.Width-SpeedButtonDecrease.Width-1-
  SpeedButtonChoose.Width-SpeedButtonChooseWithDPR.Width - ButtonGoTo.Width-RxSpeedButtonOptions.Width-
  SpeedButtonInfo.Width-4;
 dx:= dx div 8;
 if (dx<1) then
  dx:= 1;
 SpeedButtonIncrease.Left:= SpeedButtonOpenDB.Width+1+dx;
 SpeedButtonDecrease.Left:= SpeedButtonIncrease.Left+SpeedButtonIncrease.Width+1;
 SpeedButtonChoose.Left:= SpeedButtonDecrease.Left+SpeedButtonDecrease.Width+dx;
 SpeedButtonChooseWithDPR.Left:= SpeedButtonChoose.Left+SpeedButtonChoose.Width+4;
 ButtonGoTo.Left:= SpeedButtonChooseWithDPR.Left+SpeedButtonChooseWithDPR.Width+dx;
 RxSpeedButtonOptions.Left:= ButtonGoTo.Left+ButtonGoTo.Width+dx;
 SpeedButtonInfo.Left:= PanelTop.Width-SpeedButtonInfo.Width-1;
 with RxSpeedButtonOptions do begin
  Point0.X:= RxSpeedButtonOptions.Left;
  Point0.Y:= RxSpeedButtonOptions.Top+RxSpeedButtonOptions.Height;
 end;
 fPopupMenuOptionsPopupPoint:= ClientToScreen(Point0);
end;

procedure T_FormNK.RxSpeedButtonOptionsClick(Sender: TObject);
begin
 PopupMenuOptions.Popup(fPopupMenuOptionsPopupPoint.X, fPopupMenuOptionsPopupPoint.Y);
end;

procedure T_FormNK.PanelDatabaseNameResize(Sender: TObject);
begin
 if (fTheDataModule is T_DataModuleOOB) then
  PanelDatabaseName.Caption:= T_DataModuleOOB(fTheDataModule).DatabaseName;
end;

procedure T_FormNK.SpeedButtonChooseWithDPRClick(Sender: TObject);
begin
  _FormDPRChooseCriteria.NuclideList:= NuclideList;
  _FormDPRChooseCriteria.Show;
end;

end.

