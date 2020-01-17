unit dblpic_;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, Menus;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    procedure N5Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
  private
  public
  end;


  col_row = record
    col: integer;
    row: integer;
  end;

const


  MAX_SIZE = 32;
  MAX_H = 8;
  MAX_W = 8;

var
  Form1: TForm1;

  Pole: array [1..MAX_H,1..MAX_W] of integer;
  Pictures: TBitmap;

  n : integer;
  count: integer;
  open1: col_row;
  open2: col_row;

  W: integer;
  H: integer;

  WK: integer;
  HK: integer;


implementation

{$R *.dfm}

procedure Kletka(col,row: integer);
var
  x,y: integer;
  src, dst : Trect;

begin
  x := (col-1)*WK;
  y := (row-1)*HK;

  
  if Pole[col,row] > 200 then
   begin
      Form1.Canvas.Brush.Color := clBtnFace;
      Form1.Canvas.Pen.Color := clBtnFace;
      Form1.Canvas.Font.Color := clBtnFace;
    end;


  if (Pole[col,row] > 100) and (Pole[col,row] < 200)
   then
       begin
      src := Bounds((Pole[col,row]-100 -1 )*WK,0,WK,HK);
      dst := Bounds(x,y,HK-2,WK-2);
      Form1.Canvas.CopyRect(dst,Pictures.Canvas,src);
      Form1.Canvas.Pen.Color := clBlack;
      Form1.Canvas.Font.Color := clBlack;
      Form1.Canvas.Brush.Style := bsClear;
  end;


  if (Pole[col,row] > 0) and (Pole[col,row] < 100) then
    begin
      Form1.Canvas.Brush.Color := clBtnFace;
      Form1.Canvas.Pen.Color := clBlack;
      Form1.Canvas.Font.Color := clBtnFace;
    end;


  Form1.Canvas.Rectangle(x,y,x+WK-2,y+HK-2);
  Form1.Canvas.Brush.Color := clBtnFace;

end;
procedure ShowPole;
var
   row,col: integer;
begin
   for row:=1 to H do
      for col:=1 to W do
           Kletka(row,col);
end;
Procedure NewGame;
var

  k: integer;
  r: integer;
  buf: array[1..MAX_SIZE] of integer;
  i,j: integer;
begin
  Randomize;
  k := Trunc(H*W/2);

  for i:=1 to k do
      buf[i] := 0;

  for i:=1 to H do
    for j:=1 to W do
      begin
        repeat
          r := random (k) + 1;
        until buf[r] < 2;
        Pole[i,j] := r;
        inc(buf[r]);
      end;
   n:=0;
   ShowPole;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  np: integer;
begin
  Pictures := TBitmap.Create;

  Pictures.LoadFromFile('pictures.bmp');

  HK := Pictures.Height-1;
  WK := HK;

  np:= Round(Pictures.Width / WK);
  if np <= 15
    then H := 4
    else H :=5;
  W := Round(np*2/H);

  Form1.ClientHeight := H * HK;
  Form1.ClientWidth := W * WK;


  Form1.Timer1.Enabled := False;
  Form1.Timer1.Interval := 200;

  n := 0;
  NewGame;
end;



procedure TForm1.FormPaint(Sender: TObject);
begin
    ShowPole;
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  col_: integer;
  row_: integer;

begin
  col_ := Trunc(X/WK) + 1;
  row_ := Trunc(Y/HK) + 1;
  if Pole[col_,row_] > 200 then
  exit;
  if count = 0 then
  begin
    count := 1;
    open1.col := col_;
    open1.row := row_;

    Pole[open1.col,open1.row] := Pole[open1.col,open1.row] + 100;
    Kletka(open1.col,open1.row);
    exit;
  end;

  if count = 1 then begin
    open2.col := col_;
    open2.row := row_;

    if (open1.col = open2.col) and (open1.row = open2.row)
       then exit

    else begin
      count := 2;
      Pole[open2.col,open2.row] :=
           Pole[open2.col,open2.row] + 100;
      Kletka(open2.col,open2.row);

      if Pole[open1.col,open1.row] = Pole[open2.col,open2.row] then

        begin
          n := n+1;
          Form1.Timer1.Enabled := True;
        end;
    end;
    exit;
  end;

  if count = 2 then
  begin

    Pole[open1.col,open1.row] := Pole[open1.col,open1.row] - 100;
    Pole[open2.col,open2.row] := Pole[open2.col,open2.row] - 100;
    Kletka(open1.col,open1.row);
    Kletka(open2.col,open2.row);


    open1.col := col_;
    open1.row := row_;
    count := 1;


    Pole[open1.col,open1.row] := Pole[open1.col,open1.row] + 100;
    Kletka(open1.col,open1.row);
  end;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
begin

  Pole[open1.col,open1.row] := Pole[open1.col,open1.row] + 100;
  Pole[open2.col,open2.row] := Pole[open2.col,open2.row] + 100;
  count := 0;


  Kletka(open2.col,open2.row);
  Kletka(open1.col,open1.row);


  Form1.Timer1.Enabled := False;

  if n = Trunc(W*H/2)
  then
  begin
    Form1.Canvas.Font.Name := 'Times New Roman';
    Form1.Canvas.Font.Size := 36;
    Form1.Canvas.Font.Color := clBlack;
    Form1.Canvas.TextOut(70,160,'Вы выиграли!');
  end;
end;


procedure TForm1.N3Click(Sender: TObject);
begin

  MessageBox(Handle,
             PChar('Игра разработана учащимся УО "НГАЭК" ' + #13 + #13 + 'Группа 21ПО, Никанов И.В.'),
             PChar('Информация'),
             MB_OK);
end;

procedure TForm1.N4Click(Sender: TObject);
begin

    Canvas.Rectangle(0,0,ClientWidth,ClientHeight);
    NewGame;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
Close;
end;

end.
