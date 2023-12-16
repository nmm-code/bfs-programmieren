{################################
# Copyright (c) 2021 Nima Mohammadimohammadi
# <http://github.com/nmm-dev/ptl_pas>
#
# ueb01_aufgabe1 - 
# erstellt eine Liste von ein Zahlenbereich,
# gibt jeweil bei jede Zahl, 
# ob sie gerade ist oder ungerade ist,
# am ende werden alle gerade summiert und ausgeben.
#
###############################}
program ueb01_aufgabe1;

var
  start, sum, count: byte;
begin
  start := 0;
  repeat
    Write('Eine Zahl: ');
    readln(start);
  until (start > 0) and (start < 255);
  sum := 0;

  for count := 0 to start do
    if count mod 2 = 0 then
    begin
      writeln(' ', count, ' ist gerade');
      sum := sum + count;
    end
    else
      writeln(' ', count, ' ist ungerade');

  Writeln('Alle geraden Zahlen aufsummiert: ', sum);
end.


