{################################
# Copyright (c) 2021 Nima Mohammadimohammadi
# <http://github.com/nmm-dev/ptl_pas>
#
# ueb06_aufgabe1 - 
# Aus beliebig angegebene Zahlen werden 
# folgenden Funktionen angewandt:
# - Minimum 
# - Maximum
# - Summe
# - Mittelwert
#
###############################}
program ueb06_aufgabe1;

var
  i: byte;
  zahl, Summe, mittelwert, min, max: single;
  c: char;

begin
  i := 0;
  Summe := 0;
  repeat
    repeat
      writeln('Zahl eingeben: ');
{$I-}
      readln(zahl);
{$I+}
    until ioresult = 0;

    Summe := Summe + zahl;

    i := i + 1;

    if i = 1 then
    begin
      min := zahl;
      max := zahl;
    end;

    if zahl < min then
      min := zahl;

    if zahl > max then
      max := zahl;

    mittelwert := Summe / i;

    repeat

      writeln('Weitere Zahl? (j oder n)');
      readln(c);

    until (c = 'j') or (c = 'n');

  until c = 'n';

  writeln('Min: ', min: 8: 2);
  writeln('Max: ', max: 8: 2);
  writeln('Summe: ', Summe: 8: 2);
  writeln('Mittelwert: ', mittelwert: 8: 2);
end.
