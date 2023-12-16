{################################
# Copyright (c) 2021 Nima Mohammadimohammadi
# <http://github.com/nmm-dev/ptl_pas>
#
# ueb04_aufgabe2 - 
# sortiert ein String nach den Ziffern 
# gibt die sortierte Modifizierte nummer aus.
#
# "420" -> "024"
# "918" -> "189"
#
###############################}

program ueb04_aufgabe2;
const
  min = 20;
  max =1000;
var
  s1, s2, res: string[5];
  i, num: word;
begin
  for i := min to max do
  begin
    res := '';
    str(i, s1);
    for num := 0 to 9 do
    begin
      str(num, s2);
      while pos(s2, s1) <> 0 do
      begin
        res := res + copy(s1, pos(s2, s1), 1);
        Delete(s1, pos(s2, s1), 1);
      end;
    end;
    writeln(i, ', Ziffer sortiert: ', res);
  end;
end.