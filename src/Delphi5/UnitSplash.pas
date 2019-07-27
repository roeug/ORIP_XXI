unit UnitSplash;

interface

uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
 ExtCtrls, StdCtrls, ComCtrls, MemoScroll;

type
 T_FormSplash=class(TForm)
  Image1: TImage;
  Label1: TLabel;
  ProgressBar1: TProgressBar;
  Image2: TImage;
  Label2: TLabel;
  Label3: TLabel;
  Button1: TButton;
  PanelInfo: TPanel;
    PanelVFZ: TPanel;
    PanelREG: TPanel;
    Image3: TImage;
    Label6: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    ImageVFZ: TImage;
    Edit: TMemoScroll;
  procedure FormClose(Sender: TObject;var Action: TCloseAction);
  procedure Button1KeyDown(Sender: TObject;var Key: Word;
   Shift: TShiftState);
  procedure FormShow(Sender: TObject);
    procedure EditVScroll(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
 private
  procedure ShowREG;
  procedure ShowVFZ;
 public
    { Public declarations }
 end;
 
var
 _FormSplash: T_FormSplash;
 
implementation

{$R *.DFM}

procedure T_FormSplash.FormClose(Sender: TObject;
 var Action: TCloseAction);
begin
 Self.Visible:= False;
 Button1.Visible:= False;
 ProgressBar1.Visible:= True;
 Label1.Visible:= True;
(*
 if not(Button1.Visible) then
  Edit.Lines.SaveToFile(ExtractFilePath(Application.ExeName)+'NK_team.txt');
*)  
end;

procedure T_FormSplash.Button1KeyDown(Sender: TObject;var Key: Word;
 Shift: TShiftState);
begin
 if key=VK_ESCAPE then Close;
end;
                                                              
procedure T_FormSplash.FormShow(Sender: TObject);
begin
 if Button1.Visible then begin
  if Self.Height<201 then begin  // was 200
   PanelInfo.Height:= 201;       // was 200
   Self.Height:= PanelInfo.Height+Image2.Height+10;//was  Self.Height:= PanelInfo.Height+100;
   PanelInfo.Visible:= True;
   Self.Top:= (Screen.Height-Self.Height)div 2;
  end;
 end
 else begin
  PanelInfo.Visible:= False;
  PanelInfo.Height:= 0;
  Self.Height:= Image2.Height;
 end;
end;

procedure T_FormSplash.ShowREG;
begin
 PanelVFZ.Hide;
 PanelREG.Show;
end;

procedure T_FormSplash.ShowVFZ;
begin
 PanelREG.Hide;
 PanelVFZ.Show;
end;

procedure T_FormSplash.EditVScroll(Sender: TObject);
var
  FirstLine: integer;
begin
 if Edit.Visible then begin
  FirstLine := Edit.perform( EM_GETFIRSTVISIBLELINE, 0 , 0 );
  if FirstLine>=9 then
   ShowVFZ
  else
   ShowREG;
 end;
end;

procedure T_FormSplash.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  FirstLine: integer;
begin
 if Edit.Visible then begin
  FirstLine := Edit.perform( EM_GETFIRSTVISIBLELINE, 0 , 0 );
  if FirstLine>=11 then
   ShowVFZ
  else
   ShowREG;
 end;
end;

procedure T_FormSplash.FormCreate(Sender: TObject);
begin
 PanelVFZ.Visible:= False;
 PanelREG.Visible:= True;
end;

procedure T_FormSplash.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Button1.Visible then  
  if key=VK_ESCAPE then Close;      
end;

end.

