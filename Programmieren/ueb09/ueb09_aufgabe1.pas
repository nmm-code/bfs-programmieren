{################################
# Copyright (c) 2021 Nima Mohammadimohammadi
# <http://github.com/nmm-dev/ptl_pas>
#
# ueb09_aufgabe1 - 
# ueb07 mit Unterprogramme 
# - ggT und kgV verwendet
###############################}
program ueb09_aufgabe1;

{$R+}

type
  TBruch = record
    zaehler, nenner: integer;
  end;

function ggT(a, b: integer):integer;
begin
  a := Abs(a);
  b := Abs(b);

  while b <> 0 do
  begin
    Result := a mod b;
    a := b;
    b := Result;
  end;

  Result := a;
end;

function kgv(a, b: integer): integer;
begin
  kgv := (a * b) div ggt(a, b);
end;

function GeKuerzt(bruch: Tbruch): Tbruch;
begin
  if ggt(bruch.zaehler, bruch.nenner) <> 0 then
  begin
    GeKuerzt.zaehler := bruch.zaehler div ggt(bruch.zaehler, bruch.nenner);
    GeKuerzt.nenner := bruch.nenner div ggt(bruch.zaehler, bruch.nenner);
  end
  else
    GeKuerzt := bruch;
end;

function Kehrwert(bruch: TBruch): TBruch;
begin
  Kehrwert.zaehler := bruch.nenner;
  Kehrwert.nenner := bruch.nenner;
end;

function Eingabe(e: string): integer;
var
  b: integer;
begin
  Write('Eingabe des ', e, ':');
  repeat
  {$I-}
    readln(b);
  {$I+}
  until ioresult = 0;
  Eingabe := b;
end;

function Bruch: TBruch; 
begin
  Bruch.zaehler := eingabe('Zaehlers');
  Bruch.nenner := eingabe('Nenners');
end;

function Addition(b1, b2: TBruch): TBruch;
begin
  Addition.zaehler := (b1.zaehler * (kgv(b1.nenner, b2.nenner) div b1.nenner)) +
    (b2.zaehler * (kgv(b1.nenner, b2.nenner) div b2.nenner));
  Addition.nenner := kgv(b1.nenner, b2.nenner);
  Addition := GeKuerzt(Addition);
end;

function Subtr(b1, b2: TBruch): TBruch;
begin
  Subtr.zaehler := (b1.zaehler * (kgv(b1.nenner, b2.nenner) div b1.nenner)) -
    (b2.zaehler * (kgv(b1.nenner, b2.nenner) div b2.nenner));
  Subtr.nenner := kgv(b1.nenner, b2.nenner);
  Subtr := GeKuerzt(Subtr);
end;

function Multi(b1, b2: TBruch): TBruch;
begin
  Multi.zaehler := b1.zaehler * b2.zaehler;
  Multi.nenner := b1.nenner * b2.nenner;
  Multi := GeKuerzt(Multi);
end;

procedure Ausgabe(b1, b2, erg: TBruch; op: char);
begin
  writeln('(', b1.zaehler, '/', b1.nenner, ')' + op + '(',
    b2.zaehler, '/', b2.nenner, ') = ', '(', erg.zaehler, '/', erg.nenner, ')');
end;

var
  b1, b2: tBruch;
begin
  b1 := Bruch;
  b2 := Bruch;
  writeln('Bruch 1: ', '(', b1.zaehler, '/', b1.nenner, ')');
  writeln('Bruch 2: ', '(', b2.zaehler, '/', b2.nenner, ')');
  Ausgabe(b1, b2, GeKuerzt(Addition(b1, b2)), '+');
  Ausgabe(b1, b2, GeKuerzt(Subtr(b1, b2)), '-');
  Ausgabe(b1, b2, GeKuerzt(Multi(b1, b2)), '*');
  Ausgabe(b1, b2, GeKuerzt(Multi(b1, Kehrwert(b2))), '/');
end.