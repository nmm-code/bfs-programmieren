{################################
# Copyright (c) 2021 Nima Mohammadimohammadi
# <http://github.com/nmm-dev/ptl_pas>
#
# ueb04_aufgabe3 - Klammer Filter
# Zusammengehörige Paare werden gelöscht
#
# "Hallo" -> "Hallo"
# "Ha(ll)o" -> "Hao" 
# "(Ha(ll)o" -> "(Hao" 
# "Ha(ll)o)" -> "Hao)" 
#
###############################}
program ueb04_aufgabe3;

var
  s, s2: string[255];

begin
  Write('Zeichenkette: ');
  readln(s);

  if (pos('(', s) <> 0) and (pos(')', s) <> 0) then
  begin
    while (pos('()', s) <> 0) do
      Delete(s, pos('()', s), 2);

    while ((pos('(', s)) < (pos(')', s))) and ((pos('(', s)) <> 0) do
    begin
      s2 := '';
      repeat
        s2 := s2 + copy(s, 1, 1);
        Delete(s, 1, 1);
      until ((pos('(', s)) >(pos(')', s))) or ((pos('(', s)) = 0) or ((pos(')', s)) = 0);
      Delete(s, 1, pos(')', s));
      Delete(s2, length(s2), 1);
      s2 := s2 + s;
    end;
  end;
  writeln(s2);
end.
