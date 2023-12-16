{################################
# Copyright (c) 2021 Nima Mohammadimohammadi
# <http://github.com/nmm-dev/ptl_pas>
#
# 10 mini Aufgaben die Unterprogramme üben lassen 
#
###############################}
program ueb10;

type
  TZahl = '0'..'9';
  TZahlset = set of TZahl;

  Tabc = 'A'..'Z';
  Tabcset = set of Tabc;

  Tabcklein = 'a'..'z';
  Tabckleinset = set of Tabcklein;
const
  Ta: array [0..9] of string =
    ('Null', 'Eins', 'Zwei', 'Drei', 'Vier', 'Fuenf', 'Sechs', 'Sieben', 'Acht', 'Neun');
  TVokal: array[1..5] of string = ('a', 'e', 'i', 'u', 'o');

 
  function Aufgabe1(s: string): integer;
  var
    s2: string;
    i, Anzahl, check: integer;
    kleinabc: Tabckleinset;
    grossabc: Tabcset;
  begin
    kleinabc := [low(Tabcklein)..high(Tabcklein)];
    grossabc := [low(Tabc)..high(Tabc)];

    anzahl := 0;
    repeat
      check := 0;
      if pos(' ', s) <> 0 then
      begin
        s2 := copy(s, 1, pos(' ', s) - 1);
        Delete(s, 1, pos(' ', s));
      end
      else
      begin
        s2 := copy(s, 1, length(s));
        Delete(s, 1, length(s));
      end;

      for i := 1 to length(s2) do
        if ((s2[i] in kleinabc) or (s2[i] in grossabc)) xor (s2[i] = ' ') then
        else
          Inc(check);

      s2 := copy(s2, 1, length(s2));
      Delete(s2, 1, length(s2));
      Anzahl := Anzahl + 1;

      if check <> 0 then
        Anzahl := Anzahl - 1;
    until s = '';

    Aufgabe1 := Anzahl;
  end;


 
  function Aufgabe2(s: string): string;

    function Zahl(szahl, ss, s: string): string;
    begin
      while pos(szahl, s) <> 0 do
      begin
        insert(ss, s, pos(szahl, s));
        Delete(s, pos(szahl, s), 1);
      end;
     Zahl := s;
    end;

  var
    i: word;
    ii: string;
  begin
    for i := 0 to 9 do
    begin
      str(i, ii);
      s := Zahl(ii, ta[i], s);
    end;
    Aufgabe2 := s;
  end;

  
  function Aufgabe3(s: string): string;
  var
    ii: string;
    i: byte;
  begin
    for i := 0 to 9 do
    begin
      repeat
        if pos(upcase(ta[i]), upcase(s)) <> 0 then
        begin
          str(i, ii);
          insert(ii, s, pos(upcase(ta[i]), upcase(s)));
          Delete(s, pos(upcase(ta[i]), upcase(s)), length(ta[i]));
        end;
      until pos(upcase(ta[i]), upcase(s)) = 0;
    end;
    Aufgabe3 := s;
  end;

  function Aufgabe4(s: string): integer;
  var
    s2, s3: string;
    i, k, code, Anzahl: integer;
    Zahlen: Tzahlset;
  begin
    Zahlen := [low(tZahl)..high(Tzahl)];

    anzahl := 0;
    s2 := '';

    for i := 1 to length(s) do
      if (s[i] in Zahlen) then
        s2 := s2 + copy(s, i, 1)
      else
        s2 := s2 + copy(' ', 1, 1);

    repeat
      if pos(' ', s2) <> 0 then
      begin
        s3 := copy(s2, 1, pos(' ', s2) - 1);
        Delete(s2, 1, pos(' ', s2));
      end
      else
      begin
        s3 := copy(s2, 1, length(s2));
        Delete(s2, 1, length(s2));
      end;

      val(s3, k, code);

      if code = 0 then
        Anzahl := anzahl + k;

    until s2 = '';
   Aufgabe4 := anzahl;
  end;

  function Aufgabe5(s: string): string;

    function Vokale(ss, xs: string): string;
    begin
      while pos(upcase(ss), xs) <> 0 do
      begin
        Delete(xs, pos(upcase(ss), xs), 1);
      end;

      while pos(ss, xs) <> 0 do
      begin
        Delete(xs, pos(ss, xs), 1);
      end;
       Vokale := xs;
    end;

  var
    i: byte;
  begin
    for i := 1 to 5 do
      s := Vokale(tvokal[i], s);

    Aufgabe5 := s;
  end;

  function Aufgabe6(s1: string): string;
  var
    s: string;
    Vokale, abc: Tabcset;
  begin
    s := '';

    Vokale := ['A', 'E', 'I', 'O', 'U'];
    abc := [low(Tabc)..high(Tabc)];

    repeat
      if upcase(s1[1]) in (abc - vokale) then
        Delete(s1, 1, 1)
      else
      begin
        s := s + s1[1];
        Delete(s1, 1, 1);
      end;
    until s1 = '';

    Aufgabe6 := s;

  end;

  function Aufgabe7(s: string; ii: word): string;
  var
    i: longint;
    abc: Tabcset;
    ABCc: Tabckleinset;
  begin
    abc := [low(Tabc)..high(Tabc)];
    abcc := [low(Tabcklein)..high(Tabcklein)];

    for i := 1 to length(s) do
    begin

      if (s[i] in abc) or (s[i] in abcc) then
      begin

        if s[i] >= 'a' then
        begin
          Inc(Ord(s[i]), ii);

          if Ord(s[i]) > 122 then
            Dec(Ord(s[i]), 26);

          if Ord(s[i]) < 97 then
            Inc(Ord(s[i]), 26);
        end
        else
        begin
          Inc(Ord(s[i]), ii);

          if Ord(s[i]) > 91 then
            Dec(Ord(s[i]), 26);

          if Ord(s[i]) < 65 then
            Inc(Ord(s[i]), 26);
        end;
      end;


      Aufgabe7 := s;

    end;

  end;

  function Aufgabe8(links: string): boolean;

    function check(a, b: string; i: word): string;
    var
      abc: Tabcset;
    begin
      abc := [low(Tabc)..high(Tabc)];

      if upcase(a[i]) in abc then
        b := b + copy(a, i, 1);

      check := b;
    end;

  var
    rechts: string;
    i: byte;
  begin
    rechts := '';
    for i := 1 to length(links) do
      rechts := check(links, rechts, i);

    Delete(links, 1, length(links));

    for i := length(rechts) downto 1 do
      links := check(rechts, links, i);

    Aufgabe8 := upcase(links) = upcase(rechts);
  end;

  function Aufgabe9(z: integer): single;
  const
    radius = 100000;
  var
    i, kreis: uint64;
    p1, p2: integer;
  begin
    randomize;
    kreis := 0;

    for i := 1 to z do
    begin
      p1 := random(radius + 1);
      p2 := random(radius + 1);

      if (sqr(p1) + sqr(p2)) <= sqr(radius) then
        Inc(kreis);
      Aufgabe9 := (Kreis * 4) / z;
    end;
  end;

  function Aufgabe10(z: integer): boolean;
  var
    check: boolean;
  begin

    check := False;

    if z mod 4 = 0 then
      check := True;

    if z mod 100 = 0 then
      check := False;

    if z mod 400 = 0 then
      check := True;

    Write(z, ' : ');
    Aufgabe10 := check;
  end;

var
  z: word;
  i7, a9, a10: integer;
  a1, a2, a3, a4, a5, a6, a7, a8: string;
begin
  repeat
    Write('Bitte Aufgabe waehlen: ');
  {$I-}
    readln(z);
  {$I+}
  until (ioresult = 0) and ((z >= 1) and (z <= 10));

  case z of
    1:
    begin
      Write('aufgabe1: ');
      readln(a1);
      Write('=', aufgabe1(a1));
    end;

    2:
    begin
      Write('aufgabe2: ');
      readln(a2);
      Write('=', aufgabe2(a2));
    end;

    3:
    begin
      Write('aufgabe3: ');
      readln(a3);
      Write('=', aufgabe3(a3));
    end;

    4:
    begin
      Write('aufgabe4: ');
      readln(a4);
      Write('=', aufgabe4(a4));
    end;

    5:
    begin
      Write('aufgabe5: ');
      readln(a5);
      Write('=', aufgabe5(a5));
    end;

    6:
    begin
      Write('aufgabe6: ');
      readln(a6);
      Write('=', aufgabe6(a6));
    end;

    7:
    begin
      Write('aufgabe7: ');
      readln(a7);
      writeln('Rotation: ');
      readln(i7);
      Write('=', aufgabe7(a7, i7));
    end;

    8:
    begin
      Write('aufgabe8: ');
      readln(a8);
      Write('=', aufgabe8(a8));
    end;

    9:
    begin
      Write('aufgabe9: ');
      readln(a9);
      Write('=', aufgabe9(a9): 4: 2);
    end;

    10:
    begin
      Write('aufgabe10: ');
      readln(a10);
      Write('=', aufgabe10(a10));
    end;
  end;
  readln;
end.
