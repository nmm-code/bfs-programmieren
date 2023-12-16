{################################
# Copyright (c) 2021 Nima Mohammadimohammadi
# <http://github.com/nmm-dev/ptl_pas>
#
# ueb05_aufgabe2 - Magischen Würfel
#################################
# beispiel:
# 0 0 0    2 0 0    2 0 0
# 0 0 0 -> 0 0 0 -> 0 3 0 ->
# 0 1 0    0 1 0    0 1 0
#----------------------------
# 2 0 0    2 0 0    2 6 0
# 0 3 0 -> 5 3 0 -> 5 3 0 ->
# 0 1 4    0 1 0    0 1 4
#----------------------------
# 2 6 0    2 6 0    2 6 9 
# 5 3 7 -> 5 3 7 -> 5 3 7
# 0 1 4    8 1 4    8 1 4
###############################}
program ueb05_aufgabe2;

{$R+}
const
  max = 2;
type
  Tindex = 0..max;
  Cube = array[Tindex, Tindex] of word;
var
  Feld: Cube;
  y, x: shortint;
  i, kl: word;
begin
  kl := max + 1;

  x := max div 2;
  y := (max div 2) + (kl mod 2);

  Feld[x, y] := 1;
  for i := 2 to kl * kl do
  begin
    Inc(x);
    Inc(y);
    if x = kl then
      x := 0;
    if y = kl then
      y := 0;
    if Feld[x, y] <> 0 then
    begin
      Dec(x);
      Inc(y);
    end;
    if y = kl then
      y := 0;
    if x < 0 then
      x := max;
    Feld[x, y] := i;
  end;
  
  //Ausgabe Feld
  for x := 0 to max do
  begin
    for y := 0 to max do
      Write(feld[y, x],' ');

    Writeln();
  end;
end.
