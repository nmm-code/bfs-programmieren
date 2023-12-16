{################################
# Copyright (c) 2021 Nima Mohammadimohammadi
# <http://github.com/nmm-dev/ptl_pas>
#
# ueb06_aufgabe3 -
# Macht aus beliebigen Worter eine Abkürzung 
# anhabg des ersten buchstabens.
#
# "Mit freundlichen Grüße" -> "MfG"
#
###############################}
program ueb06_aufgabe3;
var
  s, s2: string[255];

begin
  writeln('Zeichenkette :');
  readln(s);

  s2 := '';

  repeat
    s2 := s2 + copy(s, 1, 1);
    if pos(' ', s) <> 0 then
      Delete(s, 1, pos(' ', s))
    else
      Delete(s, 1, length(s));
  until s = '';

  writeln(s2);
  readln;

end.

