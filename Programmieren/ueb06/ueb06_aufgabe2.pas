{################################
# Copyright (c) 2021 Nima Mohammadimohammadi
# <http://github.com/nmm-dev/ptl_pas>
#
# ueb06_aufgabe2 -
# Simuliert ein Würfel der g oft gewürfelt wird,
# berechnet anschließend die prozent chance auf 6 zu kommen
#
###############################}
program ueb06_aufgabe2;

const
  g = 100000;
var
  r, j, k: word;
  i: longword;
  w: single;
  check: boolean;
begin
  randomize;
  k := 0;
  for i := 1 to g do
  begin
    check := False;
    for j := 1 to 3 do
    begin
      r := (random(6));
      Inc(r);
      if r = 6 then
      check:=true;
    end;
    if check then
     k := k + 1;
  end;
  w := (k / g) * 100;

  writeln(w: 8: 2, ' %');
  readln;
end.

