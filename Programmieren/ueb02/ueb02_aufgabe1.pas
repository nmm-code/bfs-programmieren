{################################
# Copyright (c) 2021 Nima Mohammadimohammadi
# <http://github.com/nmm-dev/ptl_pas>
#
# ueb02_aufgabe1 - 
# emittelt von ein Zahlenbereich perfekte Zahlen,
# gibt sie noch aus
#
# Definition:
# <https://de.wikipedia.org/wiki/Vollkommene_Zahl>
#
###############################}
program ueb02_aufgabe1;

var
  i, j, min, max, sum: integer;
  perfectNum: boolean;

begin
  repeat
    Write('Was ist ihr Unterer Bereich     ');
    readln(min);
    Write('Was ist ihr Oberer Bereich      ');
    readln(max);
  until min < max;

  for i := min to max do
  begin
    sum := 0;

    for j := 1 to i - 1 do
      if i mod j = 0 then
        sum := sum + j;

    perfectNum := sum = i;

    if perfectNum then
      Writeln('Die perfekte Zahl=', i);
  end;
end.
