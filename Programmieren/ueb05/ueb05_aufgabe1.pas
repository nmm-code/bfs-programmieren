{################################
# Copyright (c) 2021 Nima Mohammadimohammadi
# <http://github.com/nmm-dev/ptl_pas>
#
# ueb05_aufgabe1 - 
# trimmt den String um eine Länge,
# der überschuss wird dem nächsten index übergeben
#
###############################}
program ueb05_aufgabe1;

{$R+}
type
  Ta = array[1..100] of string;
var
  Feld: ta;
  currentIdx, countLength, i, j: byte;
  c: char;
begin
  currentIdx := 1;
  repeat
    write('Zeichenkette: ');
    readln(Feld[currentIdx]);
    write('Noch eine Zeichenkette (j/n) ? ');
    readln(c);
    if c = 'j' then
      currentIdx := currentIdx + 1;
  until c = 'n';

  write('leange: ');
  readln(countLength);

  i := 1;

  while i <= currentIdx do
  begin
    if length(Feld[i]) > countLength then
    begin
      j := currentIdx;
      while j >= i + 1 do
      begin
        feld[j + 1] := Feld[j];
        Dec(j);
      end;
      Feld[i + 1] := copy(Feld[i], countLength + 1, length(Feld[i]) - countLength);
      Delete(Feld[i], countLength + 1, length(Feld[i]) - countLength);
      Inc(currentIdx);
    end;
    Inc(i);
  end;

  for i := 1 to currentIdx do
    writeln(Feld[i]);
  readln;
end.
