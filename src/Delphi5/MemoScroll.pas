unit MemoScroll;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TMemoScroll = class(TMemo)
  private
    { Private declarations }
    FOnVScroll: TNotifyEvent;
   procedure WMVScroll( Var msg: TMessage ); message WM_VSCROLL;
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
   property OnVScroll: TNotifyEvent read FOnVScroll write FOnVScroll;
  end;

procedure Register;

implementation

procedure Register;
begin                       
  RegisterComponents('AddEu', [TMemoScroll]);
end;

{ TMemoScroll }

procedure TMemoScroll.WMVScroll(var msg: TMessage);
begin
 if Assigned(FOnVScroll) then FOnVScroll(Self);
 inherited;
end;
(*
var
 Key: Word;
 Shift: TShiftState;
begin
 inherited;
 Key:=0;
 OnKeyDown( Self, Key, Shift);
end;
*)
end.
