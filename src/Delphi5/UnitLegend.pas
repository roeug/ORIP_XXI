unit UnitLegend;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, NuclideClasses, Menus;

type
  T_FormLegend = class(TForm)
    ColorDialog1: TColorDialog;
    PopupMenu1: TPopupMenu;
    Default: TMenuItem;
    Grid: TStringGrid;
    procedure GridDblClick(Sender: TObject);
    procedure DefaultClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    KarteInfo: TKarteInfo;
    DecayModeList: TStringList;
    procedure RepaintVisibleForms;
  end;

var
  _FormLegend: T_FormLegend;

implementation

uses
{$IFDEF RELEASE}
{$ELSE}
  UnitDialog1,
{$ENDIF}
  UnitEditNuclide, UnitNK, math; //UnitDM_DAO, UnitDM_OOB;

{$R *.DFM}

procedure T_FormLegend.GridDblClick(Sender: TObject);
begin
 if  ColorDialog1.Execute then begin
   case StrToDecayType(  Grid.Cells[ 0, Grid.Row])of
    dtIT: KarteInfo.ITcolor:= ColorDialog1.Color;
    dtEC: KarteInfo.ECcolor:= ColorDialog1.Color;
    dtBM: KarteInfo.BMcolor:= ColorDialog1.Color;
    dtA:  KarteInfo.Acolor := ColorDialog1.Color;
    dtSF: KarteInfo.SFcolor:= ColorDialog1.Color;
    dtN:  KarteInfo.NColor := ColorDialog1.Color;
    dtP:  KarteInfo.Pcolor := ColorDialog1.Color;
   else
    KarteInfo.Qcolor := ColorDialog1.Color;
   end;
  RepaintVisibleForms;
 end;
end;

procedure T_FormLegend.DefaultClick(Sender: TObject);
begin
 KarteInfo.SetDefaultColor;
 RepaintVisibleForms;
end;


procedure T_FormLegend.RepaintVisibleForms;
var
 I, J: integer;
begin
  if _FormEditNuclide.Visible then
   _FormEditNuclide.RepaintImage;
{$IFDEF RELEASE}
{$ELSE}
  if _FormDialog1.Visible then
   _FormDialog1.RepaintImage;
{$ENDIF}
  if _FormNK.StringGridNK.Visible then begin
   _FormNK.Caption:='Working...';
   with _FormNK.StringGridNK do begin
    Hide;
    for I:=1 to (ColCount-1) do
     for J:=1 to (RowCount-1) do begin
      (Objects[ I, J]as TMetafile).Free;
       Objects[ I, J]:= nil;
      end;
    Show;
   end;
   _FormNK.LoadPaintElements;
   _FormNK.Caption:='NUKLIDKARTE';
  end;
  Grid.Repaint;
end;

procedure T_FormLegend.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key=vk_escape then
  Close;
end;

procedure T_FormLegend.FormCreate(Sender: TObject);
begin
 Left:=-1;
 Width:=180;
 DecayModeList:= TStringList.Create;
end;

procedure T_FormLegend.GridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
 TheRect: TRect;
begin
 TheRect:= Rect;
 with KarteInfo,Grid do
  if ACol=0 then
   with Canvas do begin
     TextOut( TheRect.Left+1,TheRect.Top+1, DecayModeList[ ARow]);
   end
  else if ACol=1 then
   with Canvas do begin
     Brush.Color:= Color4DecayType(StrToDecayType(DecayModeList[ ARow]), KarteInfo);
     FillRect( TheRect);
     Font:= KarteInfo.FontLast;
     Font.Size:= 4*Font.Size;
     Font.Color:= clWhite xor Brush.Color;
     if KarteInfo.SpecialFont then
      TextOut( TheRect.Left+1,TheRect.Top, DecaySpecialSymbol(StrToDecayType(DecayModeList[ ARow])))
     else
      TextOut( TheRect.Left+1,TheRect.Top+1, DecaySymbol(StrToDecayType(DecayModeList[ ARow])));
    end
  else if ACol=2 then
   with Canvas do begin
     if gdSelected in State	then
      Font.Color:=  clWhite //  clWhite xor Brush.Color;
     else
      Font.Color:= clBlack; //clWhite xor Brush.Color;
     TextFlags:= ETO_OPAQUE;
     TextOut( TheRect.Left+1,TheRect.Top+1, RussionDecaySymbol(StrToDecayType(DecayModeList[ ARow])));
    end;
end;

procedure T_FormLegend.FormShow(Sender: TObject);
var
 I: integer;
begin
 with DecayModeList do begin
  Clear;
  Add('A');
  Add('B-');
  Add('EC');
  Add('IT');
  Add('N');
  Add('P');
  Add('SF');
  Add('-');
 end;
 Grid.RowCount:= DecayModeList.Count;
 for I:=0 to (DecayModeList.Count-1)do
  with Grid do
   Cells[0,I]:= DecayModeList[I];
end;

procedure T_FormLegend.FormResize(Sender: TObject);
begin
 with Grid do
  ColWidths[2]:= Max(30,Width-ColWidths[0]-ColWidths[1]); 
end;

end.
