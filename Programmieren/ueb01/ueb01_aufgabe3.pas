{################################
# Copyright (c) 2021 Nima Mohammadimohammadi
# <http://github.com/nmm-dev/ptl_pas>
#
# ueb01_aufgabe3 - 
# liest eine Euro und Cent betrag aus der Konsole ,
# rechnet die im Scheine und Münzen um
#
###############################}
program ueb01_aufgabe3;

var
  i, z: word;
  primeNum: boolean;
begin

  writeln('Zahl,die auf ihre Primenzahleigenschaft ueberprueft werden soll:  ');
  readln(z);

  if z = 2 then
    primeNum := true
  else
  if (z <= 1) or (z mod 2 = 0) then
    primeNum := false
  else
  begin
    i := 2;
    primeNum := true;
    while i < z do
    begin
      if (z mod i = 0) then
        primeNum := false;
      Inc(i);
    end;
  end;
  if primeNum then
    Write('Die Zahl ', z, ' ist eine Primenzahl ')
  else
    Write('Die Zahl ', z, ' ist keine Primenzahl ');
end.

