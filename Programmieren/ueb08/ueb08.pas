{################################
# Copyright (c) 2021 Nima Mohammadimohammadi
# <http://github.com/nmm-dev/ptl_pas>
#
# ueb08 - Mengen 
# Ein Programm um beliebig viele Personen ein zu lesen um,
# am Ende Mengen Operationen da drauf anzuwenden
#
# - Mehrfach benutze hobby
# - Hobbys die garnicht verwendet wurden
# 
###############################}
program ueb08;

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
var
  s_out, s, s1: string;
  hobby: THobbys;
  i, j: byte;
  Personen: TPersonen;
  weiter: boolean;
  allHobbys: thobbyset;
  hobbys, Differenz: Thobbys;

begin
  weiter := True;
  for i := 0 to MAX_PERS - 1 do
  begin
    if weiter then
    begin
      repeat
        Write('Name: ');
        readln(Personen[i].Name);
      until (length(Personen[i].Name) >= min) or (Personen[i].Name = 'x') or
        (Personen[i].Name = 'X');
      if (Personen[i].Name = 'x') or (Personen[i].Name = 'X') then
      begin
        Personen[i].Name := '';
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
        Personen[i].Erwachsen := True;
      if (s = 'x') or (s = 'X') then
        weiter := False;
    end;

    if weiter then
    begin
      repeat
        Write('Hobbys: ');
        readln(s1);

        if pos('+', s1) <> 0 then
        begin
          Delete(s1, 1, 1);
          for hobby := low(hobby_names) to high(hobby_names) do
            if s1 = hobby_names[hobby] then
              Personen[i].Hobbys := Personen[i].Hobbys + [Hobby];
        end;
        if pos('-', s1) <> 0 then
        begin
          Delete(s1, 1, 1);
          for hobby := low(hobby_names) to high(hobby_names) do
            if s1 = hobby_names[hobby] then
              Personen[i].Hobbys := Personen[i].Hobbys - [Hobby];
        end;

      until (s1 = 'x') or (s1 = 'X');
    end;

  end;

  writeln;
  for i := 0 to MAX_PERS - 1 do
  begin
    writeln('Name: ', Personen[i].Name);
    writeln('Erwachsen: ', Personen[i].Erwachsen);
    s_out := '';
    for hobby := low(THobbys) to high(THobbys) do
      if hobby in Personen[i].Hobbys then
        if s_out = '' then
          s_out := HOBBY_NAMES[hobby]
        else
          s_out := s_out + ', ' + HOBBY_NAMES[hobby];

    writeln('Hobbys: ', s_out);
    writeln;
  end;

  if personen[1].Name <> '' then
  begin
    allHobbys := [];
    for i := 0 to MAX_PERS - 1 do
    begin
      for j := 0 to Max_pers - 1 do
      begin
        if i <> j then
          allHobbys := allHobbys + (personen[i].hobbys * personen[j].hobbys);
      end;
    end;

    Write(' mehrfache hobbys : ');
    for hobbys := low(thobbys) to high(thobbys) do
      if hobbys in allHobbys then
        Write(hobbys,' ');
    Writeln;

    Write(' nicht benutzte  Hobbys : ');
    allHobbys := [Programmieren, Atmen, Kaffee];
    for i := 0 to MAX_PERS - 1 do
      allHobbys := allHobbys - personen[i].hobbys;
    for Differenz := low(thobbys) to high(thobbys) do
      if Differenz in allHobbys then
        Write(Differenz,' ');
  end;
  readln;
end.
