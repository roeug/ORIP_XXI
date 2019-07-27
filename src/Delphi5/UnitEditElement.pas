unit UnitEditElement;

interface

uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
 Dialogs, NuclideClasses, StdCtrls;

type
 T_FormEditElement=class(TForm)
  EditAmassMean: TEdit;
  Label1: TLabel;     
  Label2: TLabel;
  Label3: TLabel;
  EditSigmaA: TEdit;
  Label4: TLabel;
  Label5: TLabel;
  Label6: TLabel;
  Label7: TLabel;
  Label8: TLabel;
  EditSigmaS: TEdit;
  Label9: TLabel;
  EditKsi: TEdit;
  Label10: TLabel;
  EditRI: TEdit;
  Label11: TLabel;
  Label12: TLabel;
  EditRo: TEdit;
  Label13: TLabel;
  Label14: TLabel;
  Label15: TLabel;
  procedure FormShow(Sender: TObject);
  procedure FormCreate(Sender: TObject);
  procedure FormKeyDown(Sender: TObject; var Key: Word;
   Shift: TShiftState);
 private
    { Private declarations }
 public
    { Public declarations }
  Element: TElement;
  procedure InvalidateForm;
 end;

var
 _FormEditElement: T_FormEditElement;

implementation
uses
 EuLib;

function TextFormat(const aFloat: Float): string;
begin
 Result:=Trim(Format('%-7.5g', [aFloat]));
end;

{$R *.DFM}

procedure T_FormEditElement.FormShow(Sender: TObject);
begin
 InvalidateForm;
end;

procedure T_FormEditElement.InvalidateForm;
begin
 with Element do begin
  Caption:=Symbol;
  EditAmassMean.Text:='';
  EditSigmaA.Text:='';
  EditSigmaS.Text:='';
  EditKsi.Text:='';
  EditRI.Text:='';
  EditRo.Text:='';
{$IFDEF RELEASE}
  if(AmassMean>0)then EditAmassMean.Text:=TextFormat(AmassMean);
  if(SigmaA>0)then EditSigmaA.Text:=TextFormat(SigmaA);
  if(SigmaS>0)then EditSigmaS.Text:=TextFormat(SigmaS);
  if(ksi>0)then EditKsi.Text:=TextFormat(ksi);
  if(RI>0)then EditRI.Text:=TextFormat(RI);
  if(ro>0)then EditRo.Text:=TextFormat(ro);
{$ELSE}
  EditAmassMean.Text:=TextFormat(AmassMean);
  EditSigmaA.Text:=TextFormat(SigmaA);
  EditSigmaS.Text:=TextFormat(SigmaS);
  EditKsi.Text:=TextFormat(ksi);
  EditRI.Text:=TextFormat(RI);
  EditRo.Text:=TextFormat(ro);
{$ENDIF}
 end;
end;

procedure T_FormEditElement.FormCreate(Sender: TObject);
begin
{$IFDEF RELEASE}

 EditAmassMean.ReadOnly:=True;
 EditSigmaA.ReadOnly:=True;
 EditSigmaS.ReadOnly:=True;
 EditKsi.ReadOnly:=True;
 EditRI.ReadOnly:=True;
 EditRo.ReadOnly:=True;
 EditAmassMean.Color:=clBtnFace;
 EditSigmaA.Color:=clBtnFace;
 EditSigmaS.Color:=clBtnFace;
 EditKsi.Color:=clBtnFace;
 EditRI.Color:=clBtnFace;
 EditRo.Color:=clBtnFace;
{$ELSE}
{$ENDIF}
end;

procedure T_FormEditElement.FormKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
 if Key=vk_escape then
  Close;
end;

end.

