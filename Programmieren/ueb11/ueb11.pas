program ueb11;

uses
  SysUtils,
  dateutils;

  function quadrat_r(n: word): word;
  begin
    if n <= 0 then
      quadrat_r := 0
    else
      quadrat_r := quadrat_r(n - 1) + n * n;
  end;

  function quadrat_i(n: word): word;
  begin
    quadrat_i := 0;
    while n > 0 do
    begin
      quadrat_i := quadrat_i + n * n;
      Dec(n);
    end;
  end;

var
  i, n, rep: integer;
  z1, z2: tdatetime;
begin
  Write('Bitte Wert eingeben: ');
  readln(n);

  Write('Anzahl der Wiederholung:');
  readln(rep);

  writeln('=', quadrat_r(n));
  z1 := now;
  for i := 1 to rep do
    quadrat_r(n);
  z2 := now;
  writeln(' rekursiv Berechnung dauerte:', millisecondsbetween(z1, z2), 'ms ');

  writeln('=',quadrat_i(n));
  z1 := now;
  for i := 1 to rep do
    quadrat_i(n);
  z2 := now;
  writeln(' iterativ Berechnung dauerte:', millisecondsbetween(z1, z2), 'ms ');
  readln;
end.
