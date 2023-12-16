{################################
# Copyright (c) 2021 Nima Mohammadimohammadi
# <http://github.com/nmm-dev/ptl_pas>
#
# ueb04_aufgabe1 - 
# ersetzt ein subtring gegen ein neuen
# substring bei einer Zeichenkette
#
###############################}
program ueb04_aufgabe1;

var
  s, s2, alt, neu: string[50];
begin
  Write('Zeichenkette: ');
  readln(s);
  Write('alt: ');
  readln(alt);
  Write('neu: ');
  readln(neu);

  s2 := '';

  if pos(alt, s) = 0 then
    Write(s)
  else
  begin
    repeat
      s2 := s2 + copy(s, 1, pos(alt, s) - 1);
      if pos(alt, s) = 0 then
      begin
        s2 := s2 + s;
        Delete(s, 1, length(s));
      end;
      Delete(s, 1, pos(alt, s) - 1);
      if pos(alt, s) <> 0 then
        s2 := s2 + neu;
      Delete(s, 1, length(alt));
    until s = '';
  end;
  writeln(s2);
end.
