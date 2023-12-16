program ueb13_aufgabe1;

uses
  Math;

{$R+}

type
  TbyteArray = array of byte;

  function dual2dez(dez: string): word;
  var
    i, j: byte;
  begin
    j := 0;
    for i := length(dez) downto 1 do
      if dez[i] = '1' then
          j := j + 2 ** (length(dez) - i);
    Result := j;
  end;

  function str2ByteArray(s: string): TbyteArray;
  var
    i, j: byte;
    s2: string;
  begin
    setlength(str2ByteArray, length(str2ByteArray));
    while length(s) mod 8 <> 0 do      //mit Nullen fuellen
      s := s + '0';

    j := 0;
    repeat
      s2 := '';
      for i := 1 to 8 do
        s2 := s2 + s[i + j * 8];

      Inc(j);

      setlength(str2ByteArray, length(str2ByteArray) + 1);
      str2ByteArray[length(str2ByteArray) - 1] := dual2dez(s2);

    until (length(s) div 8) = j;
  end;

  function Dez2bin(dez: word): string;
  var
    s, tab: string;
  begin
    s := '';
    tab := '01';
    repeat
      s := tab[(dez and 1) + 1] + s;
      dez := dez shr 1;
    until dez = 0;
    DeZ2Bin := s;
  end;

  function ByteArray2str(ByteArray: TByteArray): string;
  var
    s: string;
    i: byte;
  begin
    ByteArray2str := '';
    s := '';
    for i := 0 to length(ByteArray) - 1 do
    begin
      s := dez2bin(ByteArray[i]);

      while length(s) mod 8 <> 0 do
        s := '0' + s;

      ByteArray2str := ByteArray2str + s;
    end;
  end;

var
  s: string;
  i: byte;
begin
  s := '000000010000001111111111101';

  writeln(s);
  for i := 0 to length(str2ByteArray(s)) - 1 do
    Write(str2ByteArray(s)[i], ' ');

  writeln;

  Write(ByteArray2str(str2ByteArray(s)));
  readln;
end.
