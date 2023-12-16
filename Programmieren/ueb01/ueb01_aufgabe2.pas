{################################
# Copyright (c) 2021 Nima Mohammadimohammadi
# <http://github.com/nmm-dev/ptl_pas>
#
# ueb01_aufgabe2 - 
# liest eine euro und cent betrag aus der Konsole,
# rechnet die im Scheine und Münzen um
#
###############################}
program ueb01_aufgabe2;

const
  shine: array[1..8] of byte = (1, 2, 5, 10, 20, 50, 100, 200);
  coin: array[1..6] of byte = (1, 2, 5, 10, 20, 50);
var
  euro, cent: word;
  i: byte;
begin

  Write('Der euro betrag : ');
  readln(euro);
  Write('Der cent betrag : ');
  readln(cent);

  writeln();

  for i := 8 downto 1 do
  begin
    if euro div shine[i] <> 0 then
      writeln(shine[i], ' euro :', euro div shine[i]);
    euro := euro mod shine[i];

    if i < 7 then
    begin
      if cent div coin[i] <> 0 then
        writeln(shine[i], ' cent :', cent div coin[i]);
      cent := cent mod shine[i];
    end;
  end;
end.
