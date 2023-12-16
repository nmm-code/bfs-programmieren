{################################
# Copyright (c) 2021 Nima Mohammadimohammadi
# <http://github.com/nmm-dev/ptl_pas>
#
# ueb06_aufgabe4 -
# Addition Programm um "große" Zahlen zu addieren 
#
# "große": "höchstens 999 ziffer lang" 
#
###############################}
program ueb06_aufgabe4;

var
  s, Nullstring, Zahl1, Zahl2, s3, Teilstring1, Teilstring2, erg: string;
  k, b, Gemerkt, m, i, j, code: byte;
begin
  repeat
    b:=0;
    Write('Erste Zahl:');
    readln(Zahl1);

    for k := 1 to length(Zahl1) do
    begin
     s3 := copy(Zahl1, k, 1);
      val(s3, i, code);

      if code<>0 then
      b:=b+1;
    end;
  until (length(Zahl1) < 999) and (b=0) ;

  repeat
    b:=0;
    Write('Zweite Zahl:');
    readln(Zahl2);

    for k := 1 to length(Zahl2) do
    begin
     s3 := copy(Zahl2, k, 1);
      val(s3, i, code);

      if code<>0 then
      b:=b+1;
    end;
  until (length(Zahl2) < 999) and (b = 0);

  writeln;

  Nullstring := '0';
  erg := '';

  if length(Zahl1) > length(Zahl2) then
  begin
    k := length(Zahl1) - length(Zahl2);
    for m := 1 to k do
      Zahl2 := copy(Nullstring, 1, 1) + Zahl2;
  end
  else
  begin
    k := length(Zahl2) - length(Zahl1);
    for m := 1 to k do
      Zahl1 := copy(Nullstring, 1, 1) + Zahl1;
  end;
  b := length(Zahl1);

  Gemerkt := 0;

  for k := 1 to length(Zahl1) do
  begin
    Teilstring1 := copy(Zahl1, b, 1);
    val(Teilstring1, i);

    Teilstring2 := copy(Zahl2, b, 1);
    val(Teilstring2, j);

    if Gemerkt <> 0 then
      m := i + j + Gemerkt
    else
      m := i + j;

    if m > 9 then
    begin
      str(m, s);
      s3 := copy(s, 1, 1);
      Delete(s, 1, 1);
      val(s3, Gemerkt);
      erg := s + erg;
    end
    else
    begin
      str(m, s);
      erg := s + erg;
    end;

    Dec(b);

  end;

  if Gemerkt <> 0 then
  begin
    str(Gemerkt, Nullstring);
    erg := Nullstring + erg;
  end;

  writeln(Zahl1);
  writeln('+');
  writeln(Zahl2);
  writeln('=');
  writeln(erg);
  readln;
end.

