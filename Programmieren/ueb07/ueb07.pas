{################################
# Copyright (c) 2021 Nima Mohammadimohammadi
# <http://github.com/nmm-dev/ptl_pas>
#
# ueb07 - Bruchrechnung
# Ließt 2 Brüche ein und macht folgende Operation :
# - Addition
# - Subtraktion
# - Multiplizieren
# - Division
###############################
# NOTES: Funktion wurden noch nicht eingeführt
###############################}
program ueb07;

var
  copyZ1, copyZ2, copyN1, copyN2, res, biggestNum, i, j,same: longint;
  inputZ1, inputZ2, inputN1, inputN2,inputGGT: longint;
  Isdived: boolean;
begin

  repeat
  {$I-}
    Write('Zaehler 1 :');
    readln(copyZ1);
  {$I+}
  until ioresult = 0;

  repeat
  {$I-}
    Write('Nenner 1 :');
    readln(copyN1);
  {$I+}
  until ioresult = 0;

  repeat
  {$I-}
    Write('Zaehler 2 :');
    readln(copyZ2);
  {$I+}
  until ioresult = 0;

  repeat
  {$I-}
    Write('Nenner 2:');
    readln(copyN2);
  {$I+}
  until ioresult = 0;

  inputZ1 := copyZ1;
  inputZ2 := copyZ2;
  inputN1 := copyN1;
  inputN2 := copyN2;
  same := 0;

  if copyN1 = copyN2 then
    same := copyN1
  else
    for i := 1 to inputN1 * inputN2 do
      begin
        copyN1 := inputN1 * i;
        for j := 1 to inputN1 * inputN2 do
        begin
          copyN2 := inputN2 * j;
          if copyN1 = copyN2 then
          begin
            copyZ1 := inputZ1 * i;
            copyZ2 := inputZ2 * j;
            same := copyN1;
            copyN2 := copyN1;
          end;
        end;
      end;

  inputGGT := same;

  Write('Addition: ', '(', inputZ1, '/', inputN1, ')', ' + ', '(',
    inputZ2, '/', inputN2, ')', ' = ');
  res := copyZ1 + copyZ2;
  Write('(', copyZ1, '/', same, ')', ' + ', '(', copyZ2, '/', same, ')', ' = ', '(',
    res, '/', same, ')');

  if res < same then
    biggestNum := same
  else
    biggestNum := res;

  if (res <> 0) and (same <> 0) then
    for i := biggestNum - 1 downto 2 do
    begin
      if (res mod i = 0) and (same mod i = 0) then
      begin
        res := res div i;
        same := same div i;
        Isdived := True;
      end;
    end;

  if Isdived then
  begin
    Write(' = ', res, '/', same);
    Isdived := False;
  end;

  writeln();
  same := inputGGT;

  Write('Subtraktion: ', '(', inputZ1, '/', inputN1, ')', ' - ',
    '(', inputZ2, '/', inputN2, ')', ' = ');
  res := copyZ1 - copyZ2;
  Write('(', copyZ1, '/', same, ')', ' - ', '(', copyZ2, '/', same, ')', ' = ', '(',
    res, '/', same, ')');

  if res < same then
    biggestNum := same
  else
    biggestNum := res;

  if (res <> 0) and (same <> 0) then
    for i := biggestNum - 1 downto 2 do
    begin
      if (res mod i = 0) and (same mod i = 0) then
      begin
        res := res div i;
        same := same div i;
        Isdived := True;
      end;
    end;

  if Isdived then
  begin
    Write(' = ', res, '/', same);
    Isdived := False;
  end;

  writeln;
  same := inputGGT;

  Write('Multipikation: ', '(', inputZ1, '/', inputN1, ')', ' * ', '(', inputZ2,
    '/', inputN2, ')');
  res := inputZ1 * inputZ2;
  same := inputN1 * inputN2;
  Write(' = ', '(', res, '/', same, ')');

  if res < same then
    biggestNum := same
  else
    biggestNum := res;

  if (res <> 0) and (same <> 0) then
    for i := biggestNum - 1 downto 2 do
    begin
      if (res mod i = 0) and (same mod i = 0) then
      begin
        res := res div i;
        same := same div i;
        Isdived := True;
      end;
    end;

  if Isdived then
  begin
    Write(' = ', res, '/', same);
    Isdived := False;
  end;

  writeln;
  same := inputGGT;

  Write('Division: ', '(', inputZ1, '/', inputN1, ')', ' : ', '(', inputZ2, '/',
    inputN2, ')', ' = ', '(', inputZ1, '/', inputN1, ')', ' * ',
    '(', inputN2, '/', inputZ2, ')');
  res := inputZ1 * inputN2;
  same := inputN1 * inputZ2;
  Write(' = ', '(', res, '/', same, ')');

  if res < same then
    biggestNum := same
  else
    biggestNum := res;

  if (res <> 0) and (same <> 0) then
    for i := biggestNum - 1 downto 2 do
    begin
      if (res mod i = 0) and (same mod i = 0) then
      begin
        res := res div i;
        same := same div i;
        Isdived := True;
      end;
    end;

  if Isdived then
  begin
    Write(' = ', res, '/', same);
    Isdived := False;
  end;
end.