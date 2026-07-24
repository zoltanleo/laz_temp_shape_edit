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
    Edit1: TEdit;
    Label1: TLabel;
    Shape1: TShape;
    procedure Edit1Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Shape1Click(Sender: TObject);
  private
    FDefaultCursor: TCursor;
    procedure CtrlMouseEnter(Sender: TObject);
    procedure CtrlMouseLeave(Sender: TObject);
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
    Height:= Edit1.Height;
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


  Button1.Width:= Edit1.Height;
end;

procedure TForm1.Label1Click(Sender: TObject);
begin
  Shape1Click(Sender);
end;

procedure TForm1.Shape1Click(Sender: TObject);
begin
  if Button2.CanSetFocus then Button2.SetFocus
end;

procedure TForm1.Edit1Click(Sender: TObject);
begin
  if Button1.CanSetFocus then Button1.SetFocus;
end;

procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Button1.CanSetFocus then Button1.SetFocus;
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

end.

