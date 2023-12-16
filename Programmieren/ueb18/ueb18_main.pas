program ueb18_main;

uses
  ueb18_article;

const
  dateiname = 'artikel.dat';

  function einfuegen: TArtikelRecord;
  begin
    Write('ArtNr      : ');
    readln(einfuegen.ArtNr);
    Write('Bezeichnung: ');
    readln(einfuegen.Bezeichnung);
    Write('Lagerort   : ');
    readln(einfuegen.Lagerort);
  end;

var
  ArtikelInstanz: CArtikel;
  ende: boolean;
  c: char;

begin
  ende := False;
  ArtikelInstanz := CArtikel.Create;

  if ArtikelInstanz.LoadFromFIle(dateiname) then
    ende := True;

  while ende do
  begin
    writeln('Auswahl:');
    writeln('<A>nfuegen eines Datensatzes');
    writeln('<L>oeschen eines Datensatzes');
    writeln('<S>witchArtikel');
    writeln('<B>ildschirmausgabe der Datei');
    writeln('<E>nde des Programms');
    readln(c);

    case upcase(c) of
      'A': ArtikelInstanz.AddArtikel(einfuegen);
      'L': ArtikelInstanz.DelArtikel(einfuegen);
      'S': ArtikelInstanz.SwitchArtikel(einfuegen);
      'B': ArtikelInstanz.ShowAll;
      'E': ende := False;
    end;
  end;

  if ArtikelInstanz.SavetoFile(dateiname) then
  begin
    ArtikelInstanz.DisposeAll;
    ArtikelInstanz.Free;
  end;
end.
