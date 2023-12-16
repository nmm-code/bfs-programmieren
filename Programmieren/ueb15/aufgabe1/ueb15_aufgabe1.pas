program ueb15_aufgabe1;

uses
  Math;

{$R+}

type
  Tbytefile = file of byte;

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

  procedure str2file(var f: tbytefile; s: string);
  var
    i, j: byte;
    s2: string;
  begin
    while length(s) mod 8 <> 0 do      //mit Nullen fuellen
      s := s + '0';

    try
      rewrite(f);

      j := 0;
      repeat
        s2 := '';
        for i := 1 to 8 do
          s2 := s2 + s[i + j * 8];


        Inc(j);


        Write(f, dual2dez(s2));

      until (length(s) div 8) = j;
      Close(f);
    except
      writeln('Fehler beim str2file! ');
    end;
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

  function file2str(var f: TBytefile): string;
  var
    s: string;
    i: byte;
  begin
    try
      reset(f);
      s := '';
      file2str := '';
      while not EOF(f) do
      begin
        Read(f, i);
        s := dez2bin(i);

        while length(s) mod 8 <> 0 do
          s := '0' + s;

        file2str := file2str + s;
      end;
      Close(f);
    except
      writeln('Fehler bei der String übergabe');
    end;

  end;

var
  s: string;
  i: byte;
  f: tbytefile;
begin
  s := '000000010000001111111111101';
  Assign(f, 'ziel.dat');

  writeln(s);
  str2file(f, s);

  try
    reset(f);
    while not EOF(f) do
    begin
      Read(f, i);
      Write(i, ' ');
    end;
    Close(f);
  except
    writeln('Fehler bei der Ausgabe');
  end;
  Writeln(file2str(f));


end.
