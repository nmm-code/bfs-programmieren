{################################
# Copyright (c) 2021 Nima Mohammadimohammadi
# <http://github.com/nmm-dev/ptl_pas>
#
# ueb02_aufgabe2 - 
# ein Programm was eine Zahl errät von einen Zahlenbereich,
# mit einer Formel:
#
# Formel: 
#    Fragewert : (Obere Grenze - Untere Grenze) div 2 + Untere Grenze;
#
###############################}
program ueb02_aufgabe2;

var
  og, ug, k: byte;
  g: char;
begin
  repeat
    Write('Die Untere Grenze:  ');
    readln(ug);
    Write('Die Obere Grenze:  ');
    readln(og);
  until ug < og;

  k := (og - ug) div 2 + ug;
  repeat
    Write('Ist die Zahl groesser ', k, '(j/n/r)?');
    readln(g);
    if (g = 'j') then
      k := k + 3;
    if (g = 'n') then
      k := k - 1;
  until (g = 'r');

  if g = 'r' then
    Write('Deine Zahl lautet ', k);
end.

