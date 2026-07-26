unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    btn3: TButton;
    Edit1: TEdit;
    edt3: TEdit;
    Label1: TLabel;
    Shape1: TShape;
    StaticText1: TStaticText;
    procedure Edit1Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Shape1Click(Sender: TObject);
    procedure StaticText1ChangeBounds(Sender: TObject);
    procedure StaticText1Click(Sender: TObject);
  private
    FDefaultCursor: TCursor;
    procedure CtrlMouseEnter(Sender: TObject);
    procedure CtrlMouseLeave(Sender: TObject);
    procedure FocusedCtrl(Sender: TWinControl);
    procedure PressedCtrl(Sender: TControl);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
const
  tmpStr = 'Lorem ipsum dolor sit amet';
begin
  with Shape1 do
  begin
    Pen.Style:= psSolid;
    Pen.Color:= clWindowFrame;
    OnMouseEnter:= @CtrlMouseEnter;
    OnMouseLeave:= @CtrlMouseLeave;
  end;

  with Label1 do
  begin
    Caption:= tmpStr;
    OnMouseEnter:= @CtrlMouseEnter;
    OnMouseLeave:= @CtrlMouseLeave;
  end;

  with Edit1 do
  begin
    Text:= tmpStr;
    ReadOnly:= True;
    OnMouseEnter:= @CtrlMouseEnter;
    OnMouseLeave:= @CtrlMouseLeave;
  end;

  with edt3 do
  begin
    ReadOnly:= True;
    OnMouseEnter:= @CtrlMouseEnter;
    OnMouseLeave:= @CtrlMouseLeave;
    HandleNeeded;      // we ensure that the handle is created and that ClientWidth/Height are correct
  end;

  with StaticText1 do
  begin
    Transparent:= False;
    Color:= clWindow;
    Anchors:= [akLeft, akTop,akRight, akBottom];
    OnMouseEnter:= @CtrlMouseEnter;
    OnMouseLeave:= @CtrlMouseLeave;
    Text:= ' ' + tmpStr;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Button1.Width:= Edit1.Height;
  Shape1.Height:= Edit1.Height;
end;

procedure TForm1.Label1Click(Sender: TObject);
begin
  Shape1Click(Sender);
end;

procedure TForm1.Shape1Click(Sender: TObject);
begin
  if Button2.CanSetFocus then Button2.SetFocus;
  PressedCtrl(Sender as TControl);
end;

procedure TForm1.StaticText1ChangeBounds(Sender: TObject);
var
  dx, dy: Integer;
begin
  if not edt3.HandleAllocated then Exit; // client area dimensions are known only after the handle has been created

  dx := (edt3.Width  - edt3.ClientWidth)  div 2;
  dy := (edt3.Height - edt3.ClientHeight) div 2;

  StaticText1.BorderSpacing.Left   := dx + Scale96ToForm(1);
  StaticText1.BorderSpacing.Top    := dy + Scale96ToForm(2);
  StaticText1.BorderSpacing.Right  := dx + Scale96ToForm(1);
  StaticText1.BorderSpacing.Bottom := dy + Scale96ToForm(2);
end;

procedure TForm1.StaticText1Click(Sender: TObject);
begin
  {$IFDEF LCLGTK3}
  ShowMessage('StaticText1 is pressed');
  {$ENDIF}

  if btn3.CanSetFocus then btn3.SetFocus;
  PressedCtrl(Sender as TControl);
end;

procedure TForm1.Edit1Click(Sender: TObject);
begin
  if Button1.CanSetFocus then Button1.SetFocus;
  PressedCtrl(Sender as TControl);
end;

procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  Edit1Click(Sender);
end;

procedure TForm1.CtrlMouseEnter(Sender: TObject);
begin
  FDefaultCursor:= Screen.Cursor;
  Screen.Cursor:= crHandPoint;
end;

procedure TForm1.CtrlMouseLeave(Sender: TObject);
begin
  Screen.Cursor:= FDefaultCursor;
end;

procedure TForm1.FocusedCtrl(Sender: TWinControl);
begin
  Self.Caption:= Format('Focused control is %s',[TWinControl(Sender).Name]);
end;

procedure TForm1.PressedCtrl(Sender: TControl);
begin
  Self.Caption:= Format('Pressed control is %s',[TControl(Sender).Name]);
end;

end.

