unit U_ArtikelListe;

{$mode objfpc}{$H+}
interface
uses
  SysUtils;

type
  Tstring30 = string[30];

  TArtikelRecord = record
    ArtNr: Tstring30;
    Bezeichnung: Tstring30;
    Lagerort: Tstring30
  end;

  TArtDatei = file of TArtikelRecord;

  TListe = ^TArtikelliste;

  TArtikelliste = record
    Artikel: TArtikelRecord;
    Next: TListe;
  end;

  CArtikel = class
  private
    First: TListe;
    check: boolean;
    function AddElement(InElement: TListe): TListe;
    function DelElement(Artikel: TArtikelRecord): TListe;
    function NeueArtikelnummer(ArtNr: tstring30): boolean;
  public
    function LoadFromFile(Dateiname: string): boolean;
    function SaveToFile(Dateiname: string): boolean;
    procedure AddArtikel(Artikel: TArtikelRecord);
    procedure DelArtikel(Artikel: TArtikelRecord);
    procedure DisposeAll;
    function ListtoStr: string;
  end;

implementation

function CArtikel.ListtoStr: string;
var
  Runpointer: TListe;
  s: string;
begin
  runpointer := First;
  ListtoStr := '';
  while Runpointer <> nil do
  begin
    s := runpointer^.Artikel.ArtNr + ' ' + runpointer^.Artikel.Lagerort +
      ' ' + runpointer^.Artikel.Bezeichnung;
    ListtoStr := ListtoStr + s + ' ';
    runpointer := Runpointer^.Next;
  end;
end;

function CArtikel.LoadFromFile(Dateiname: string): boolean;
var
  f: TArtDatei;
  InElement: TListe;
begin
  LoadFromFile := True;
  try
    Assign(f, Dateiname);
    if not fileexists(Dateiname) then
    begin
      rewrite(f);
      closefile(f);
    end;
    reset(f);
    First := nil;
    while not EOF(f) do
    begin
      new(InElement);
      Read(f, InElement^.Artikel);
      InElement^.Next := nil;
      First := AddElement(InElement);
    end;
    closefile(f);
  except
    LoadFromFile := False;
  end;
end;

function CArtikel.SaveToFile(Dateiname: string): boolean;
var
  f: file of TArtikelRecord;
  Runpointer: TListe;
begin
  SaveToFile := True;
  Runpointer := First;

  try
    Assign(f, Dateiname);
    rewrite(f);

    while Runpointer <> nil do
    begin
      Write(f, Runpointer^.Artikel);
      Runpointer := Runpointer^.Next;
    end;
    closefile(f);

  except
    SaveToFile := False;
  end;
end;

function CArtikel.AddElement(InElement: TListe): TListe;
var
  Runpointer: TListe;
begin
  if (First <> nil) and (First^.Artikel.ArtNr < InElement^.Artikel.ArtNr) then
  begin
    Runpointer := First;

    while (Runpointer^.Next <> nil) and (Runpointer^.Next^.Artikel.ArtNr <
        InElement^.Artikel.ArtNr) do
      Runpointer := Runpointer^.Next;

    InElement^.Next := Runpointer^.Next;
    Runpointer^.Next := InElement;
  end
  else
  begin
    InElement^.Next := First;
    First := InElement;
  end;
  AddElement := First;
end;

procedure CArtikel.AddArtikel(Artikel: TArtikelRecord);
var
  InElement: TListe;
begin
  if NeueArtikelnummer(Artikel.ArtNr) then
  begin
    check := False;
    new(InElement);
    InElement^.Artikel := Artikel;
    InElement^.Next := nil;
    First := AddElement(InElement);
  end
  else
    check := True;
end;

function CArtikel.DelElement(Artikel: TArtikelRecord): TListe;
var
  Runpointer, vor, nach: TListe;
begin
  runpointer := First;
  if (First^.Next <> nil) and (Artikel.ArtNr = First^.Artikel.ArtNr) then
  begin
    runpointer := First^.Next;
    First := Runpointer;
  end
  else
  begin
    while (runpointer^.Next <> nil) and (runpointer^.Next^.Artikel.ArtNr <>
        Artikel.ArtNr) do
      runpointer := runpointer^.Next;

    vor := runpointer;
    runpointer := runpointer^.Next;
    runpointer := runpointer^.Next;
    nach := runpointer;

    vor^.Next := nach;
  end;

  DelElement := First;
end;

procedure CArtikel.DelArtikel(Artikel: TArtikelRecord);
begin
  if NeueArtikelnummer(Artikel.ArtNr) then
    check := False
  else
  begin
    check := True;
    First := DelElement(Artikel);
  end;
end;

function CArtikel.NeueArtikelnummer(ArtNr: tstring30): boolean;
var
  neu: boolean;
  runpointer: Tliste;
begin
  neu := True;
  Runpointer := First;
  try
    while (runpointer <> nil) and neu do
    begin
      if runpointer^.Artikel.ArtNr = ArtNr then
        neu := False;
      runpointer := runpointer^.Next;
    end;

    NeueArtikelnummer := neu;
  except
    writeln('Fehler beim check');
  end;
end;

procedure CArtikel.DisposeAll;
var
  RunPointer: TListe;
begin
  while First <> nil do
  begin
    Runpointer := First;
    First := Runpointer^.Next;
    Dispose(Runpointer);
  end;
end;

end.
