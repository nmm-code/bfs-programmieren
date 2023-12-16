program ueb15_aufgabe2;

uses
  crt,
  SysUtils;

const
  dateiname = 'artikel.dat';

type
  string30 = string

    [30];

  TArtikel = record
    ArtNr: string30;
    Bezeichnung: string30;
    Lagerort: string30
  end;
  TArtDatei = file of TArtikel;

  function dateiOK: boolean;
  var
    b: file of byte;
    artikel: TArtikel;
  begin
    dateiOK := True;
    if fileexists(dateiname) then
    begin
      Assign(b, dateiname);
      try
        reset(b);
        if filesize(b) mod sizeof(artikel) <> 0 then
          dateiOK := False;
        Close(b);
      except
        writeln('Fehler');
      end;
    end;
  end;

  function NeueArtikelnummer(ArtNr: string30; var f: TArtDatei): boolean;
  var
    artikel: TArtikel;
    neu: boolean;
  begin
    neu := True;
    try
      reset(f);
      while not EOF(f) and neu do
      begin
        Read(f, artikel);
        if artikel.ArtNr = ArtNr then
          neu := False;
      end;
      Close(f);
      NeueArtikelnummer := neu;
    except
      writeln('Fehler beim check');
    end;
  end;

  procedure einfuegen(var f: TArtDatei);
  var
    artikel, k: TArtikel;
    position, i: byte;
    check: boolean;
  begin
    clrscr;
    with artikel do
    begin
      Write('ArtNr      : ');
      readln(ArtNr);
      Write('Bezeichnung: ');
      readln(Bezeichnung);
      Write('Lagerort   : ');
      readln(Lagerort);
    end;
    if NeueArtikelnummer(Artikel.ArtNr, f) then
    begin
      try
        reset(f);

        check := True;

        while not EOF(f) and check do
        begin
          Read(f, k);
          if k.ArtNr > Artikel.ArtNr then
          begin
            position := filepos(f) - 1;
            check := False;
          end;
        end;

        if check then
          Write(f, artikel)
        else
        begin
          for i := filesize(f) - 1 downto position do
          begin
            seek(f, i);
            Read(f, k);
            Write(f, k);
          end;
          seek(f, position);
          Write(f, artikel);
        end;
        Close(f);
      except
        writeln('Fehler beim Einfuegen');
      end;
    end
    else
    begin
      writeln('Artikelnummer ist bereits vergeben!');
      readln;
    end;
  end;

  procedure loeschen(var f: TartDatei);
  var
    artikel, k: TArtikel;
    position, i: byte;
    check: boolean;
  begin
    clrscr;
    with Artikel do
    begin
      Write('ArtNr      : ');
      readln(ArtNr);
    end;
    if not NeueArtikelnummer(Artikel.ArtNr, f) then
    begin
      try
        reset(f);
        check := True;

        while not EOF(f) and check do
        begin
          Read(f, k);
          if k.ArtNr = Artikel.ArtNr then
            check := False;
        end;

        position := filepos(f);

        seek(f, position);
        for i := position to filesize(f) - 1 do
        begin
          Read(f, k);
          seek(f, i - 1);
          Write(f, k);
          seek(f, i + 1);
        end;

        seek(f, filesize(f) - 1);
        truncate(f);
        Close(f);
      except
        writeln('Fehler beim loeschen');
      end;
    end;

  end;

  procedure DateiAusgeben(var f: TArtDatei);
  var
    artikel: TArtikel;
  begin
    clrscr;
    try
      reset(f);
      while not EOF(f) do
      begin
        Read(f, artikel);
        with artikel do
          writeln(ArtNr, ' ', Bezeichnung, ' ', Lagerort);
      end;
      Close(f);
    except
      writeln('Fehler bei der Ausgabe');
    end;

  end;

var
  f: TArtDatei;
  ende: boolean;
  c: char;

begin
  if dateiOK then
  begin
    Assign(f, dateiname);
    if not fileexists(dateiname) then
    begin
      try
        rewrite(f);
        Close(f);
      except
        writeln('Fehler Dateioperationen!');
      end;
    end;
    repeat
      clrscr;
      ende := False;
      writeln('Auswahl:');
      writeln('<A>nfuegen eines Datensatzes');
      writeln('<L>oeschen eines Datensatzes');
      writeln('<B>ildschirmausgabe der Datei');
      writeln('<E>nde des Programms');
      readln(c);

      case upcase(c) of
        'A': einfuegen(f);
        'L': loeschen(f);
        'B': DateiAusgeben(f);
        'E': ende := True;
      end
    until ende;
  end
  else
    writeln('Fehler: Die Datei ', dateiname, ' hat ein falsches Format!');
end.
