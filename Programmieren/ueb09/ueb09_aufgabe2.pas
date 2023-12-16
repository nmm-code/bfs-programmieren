{################################
# Copyright (c) 2021 Nima Mohammadimohammadi
# <http://github.com/nmm-dev/ptl_pas>
#
# ueb09_aufgabe2 - 
# ueb08 mit Unterprogramme 
###############################}
program ueb09_aufgabe2;

{$R+}

const
  min = 5;
  MAX_PERS = 2;

type
  THobbys = (Programmieren, Atmen, Kaffee);
  THobbySet = set of THobbys;

  TPerson = record
    Name: shortstring;
    Erwachsen: boolean;
    Hobbys: THobbySet;
  end;
  TPersonen = array[0 .. MAX_PERS - 1] of TPerson;
const
  HOBBY_NAMES: array[THobbys] of string = ('Programmieren', 'Atmen', 'Kaffee');

  function Eingabe: Tpersonen;
  var
    h1: thobbys;
    weiter: boolean;
    i: word;
    s, s1: string;
  begin
    weiter := True;
    for i := 0 to MAX_PERS - 1 do
    begin
      if weiter then
      begin
        repeat
          Write('Name: ');
          readln(Eingabe[i].Name);
        until (length(Eingabe[i].Name) >= min) or (Eingabe[i].Name = 'x') or
          (Eingabe[i].Name = 'X');
        if (Eingabe[i].Name = 'x') or (Eingabe[i].Name = 'X') then
        begin
          Eingabe[i].Name := '';
          weiter := False;
        end;
      end;
      if weiter then
      begin
        repeat
          Write('Erwachsen: ');
          readln(s);
        until ((s = 'ja') or (s = 'nein') or (s = 'JA') or (s = 'NEIN')) or
          ((s = 'x') or (s = 'X'));
        if s = 'ja' then
          Eingabe[i].Erwachsen := True;
        if (s = 'x') or (s = 'X') then
          weiter := False;
      end;
      if weiter then
      begin
        repeat
          Write('Hobbys: ');
          readln(s1);
          if pos('+', s1) <>0  then
          begin
            Delete(s1, 1, 1);
            for h1 := low(thobbys) to high(thobbys) do
              if s1 = hobby_names[h1] then
                Eingabe[i].Hobbys := Eingabe[i].Hobbys + [H1];
          end;
          if pos('-', s1) <>0 then
          begin
            Delete(s1, 1, 1);
            for h1 := low(thobbys) to high(thobbys) do
              if s1 = hobby_names[h1] then
                Eingabe[i].Hobbys := Eingabe[i].Hobbys - [H1];
          end;
        until (s1 = 'x') or (s1 = 'X');
      end;
    end;
    writeln;
  end;
  Procedure print(h:thobbys;allhobbyss:Thobbyset);
  begin
     for h in allHobbyss do
      Write(h, ' ');
        Writeln;
  end;

  procedure Ausgabe(h2: thobbys; pers2: Tpersonen);
  var
    i: word;
    s_out: string;
  begin
    for i := 0 to MAX_PERS - 1 do
    begin
      writeln('Name: ', Pers2[i].Name);
      writeln('Erwachsen: ', Pers2[i].Erwachsen);
      s_out := '';
      for h2 in Pers2[i].Hobbys do
        if s_out = '' then
          s_out := HOBBY_NAMES[h2]
        else
          s_out := s_out + ', ' + HOBBY_NAMES[h2];

      writeln('Hobbys: ', s_out);
      writeln;
    end;
  end;

  function  Schnittmenge(pers3: Tpersonen): thobbyset;
  var
    i, j: integer;
  begin
    if pers3[1].Name <> '' then
    begin
      Schnittmenge := [];
      for i := 0 to MAX_PERS - 1 do
      begin
        for j := 0 to Max_pers - 1 do
        begin
          if i <> j then
            Schnittmenge := Schnittmenge + (pers3[i].hobbys * pers3[j].hobbys);
        end;
      end;
    end;
  end;

  procedure Mehrfache(h: thobbys; allhobbys: thobbyset);
  begin
    Write(' mehrfache hobbys : ');
    print(h,allhobbys);
  end;

  procedure UnUsed(Pers: Tpersonen);
  var
    h: thobbys;
    i: word;
    allHobbyss: Thobbyset;
  begin
    allhobbyss:=[];
    Write(' nicht benutzte  Hobbys : ');

    for h := low(thobbys) to high(thobbys) do
      allHobbyss := allHobbyss + [h];

    for i := 0 to MAX_PERS - 1 do
      allHobbyss := allHobbyss - pers[i].hobbys;
      print(h,allhobbyss);
  end;
var
  Personen: TPersonen;
  hobbys,hobby:Thobbys;
begin
  Personen:= Eingabe;
  Ausgabe(hobby, Personen);
  Mehrfache(hobbys,Schnittmenge(Personen));
  UnUsed(Personen);
end.
