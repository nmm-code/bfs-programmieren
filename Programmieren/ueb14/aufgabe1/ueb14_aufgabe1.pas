program ueb14_aufgabe1;

{$I-}
uses
  SysUtils;

  function finden(var mytext: Text): string;
  var
    s, s1: string;
  begin
    s1 := '';
    reset(mytext);
    if ioresult <> 0 then
      writeln('Fehler beim Oeffnen');
    repeat
      s := '';
      readln(mytext, s);
      s1 := s1 + s + ' ';
    until EOF(mytext);
    Close(mytext);
    if ioresult <> 0 then
      writeln('Fehler beim Schließen');
    Result := s1;
  end;

  procedure schreiben(var resulte: Text; i: byte; s: string);
  begin
    Append(resulte);
    if ioresult <> 0 then
      writeln('Fehler beim Oeffnen');
    writeln(resulte, s, ' : ', i, ' Vorgekommen');
  end;

  procedure Auswerten(var programm, Result: Text; s: string);
  var
    s1, s2: string;
    i: byte;
  begin

    i := 0;
    s2 := s;
    repeat
      s := copy(s2, 1, pos(' ', s2) - 1);
      reset(programm);
      if ioresult <> 0 then
        writeln('Fehler beim Oeffnen');
      while not EOF(programm) do
      begin
        readln(programm, s1);
        repeat
          if pos(s, s1) <> 0 then
          begin
            Inc(i);
            Delete(s1, pos(s, s1), length(s));
          end
          else
            Delete(s1, 1, length(s1));
        until s1 = '';
      end;
      schreiben(Result, i, s);
      i := 0;
      Delete(s2, pos(s, s2), length(s) + 1);
    until s2 = '';

    Close(programm);
    if ioresult <> 0 then
      writeln('Fehler beim Schliessen');

    Close(Result);
    if ioresult <> 0 then
      writeln('Fehler beim Schliessen');
  end;


var
  mytext, Result, programm: Text;
begin
  if Fileexists('mytext.txt') then
    Assign(mytext, 'mytext.txt');

  Assign(Result, 'result.txt');
  rewrite(Result);


  Close(Result);
  if ioresult <> 0 then
    writeln('Fehler beim Schliessen');

  if Fileexists('program.txt') then
  begin
    Assign(programm, 'program.txt');
    Auswerten(programm, Result, finden(mytext));
  end;

end.
