unit U_ArtikelListe;

{$mode objfpc}{$H+}

interface

uses
  SysUtils;

type
  Tstring30 = string

    [30];

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
    function AddElement(InElement: TListe): TListe;
    function DelElement(Artikel: TArtikelRecord): TListe;
    function NeueArtikelnummer(ArtNr: tstring30): boolean;
  public
    function LoadFromFile(Dateiname: string): boolean;
    function SaveToFile(Dateiname: string): boolean;
    function AddArtikel(Artikel: TArtikelRecord): boolean;
    function DelArtikel(Artikel: TArtikelRecord): boolean;
    procedure DisposeAll;
    function ListtoStr: string;
  end;

implementation

function CArtikel.ListtoStr: string;
  // Verwandelt den (First:Pointer) in einen String
  //------------------------------------------------------------------------------
  // Parameter =
  //  out : string mit allen Artikeln
  //------------------------------------------------------------------------------
  // Verwendet =
  // private atribut:
  //  First : TListe
  //------------------------------------------------------------------------------
  // Lokale Variablen =
var
  Runpointer: TListe;
  s: string;
  //------------------------------------------------------------------------------
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
  // Lädt den Dateiinhalt in ein (First:Pointer)
  //------------------------------------------------------------------------------
  // Parameter =
  // in : Dateiname:string
  // out : boolean  //ob die Funktion richtig ausgeführ wurde
  //------------------------------------------------------------------------------
  // Verwendet =
  // private atribut:
  //  First : TListe
  //------------------------------------------------------------------------------
  // Lokale Variablen =
var
  f: TArtDatei;
  InElement: TListe;
  //------------------------------------------------------------------------------
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
  // Verwandelt den (First:Pointer) Inhalt in eine Datei um
  //------------------------------------------------------------------------------
  // Parameter =
  // in : Dateiname:string
  // out : boolean  //ob die Funktion richtig ausgeführ wurde
  //------------------------------------------------------------------------------
  // Verwendet =
  // private atribut:
  //  First : TListe
  //------------------------------------------------------------------------------
  // Lokale Variablen =
var
  f: file of TArtikelRecord;
  Runpointer: TListe;
  //------------------------------------------------------------------------------
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
  // Fügt sortiert in ein Pointer ein
  //------------------------------------------------------------------------------
  // Parameter =
  // in :  InElement: TListe  //der nue Artikel
  // out : First:TListe       //der pointer mit den neuen Artikel
  //------------------------------------------------------------------------------
  // Verwendet =
  // private atribut:
  //  First : TListe
  //------------------------------------------------------------------------------
  // Lokale Variablen =
var
  Runpointer: TListe;
  //------------------------------------------------------------------------------
begin
  if (First <> nil) and (First^.Artikel.ArtNr < InElement^.Artikel.ArtNr) then
  begin
    Runpointer := First;

    while (Runpointer^.Next <> nil) and (Runpointer^.Next^.Artikel.ArtNr <
        InElement^.Artikel.ArtNr) do
      Runpointer := Runpointer^.Next;
    // mittig Einfügen o. ende Einfügen
    InElement^.Next := Runpointer^.Next;
    Runpointer^.Next := InElement;
  end
  else
  begin
    InElement^.Next := First;      //davor Einfügen
    First := InElement;
  end;
  AddElement := First;
end;

function CArtikel.AddArtikel(Artikel: TArtikelRecord): boolean;
  // Erstellt ein Pointer mit den Neuen Artikel und fügt ein
  //------------------------------------------------------------------------------
  // Parameter =
  // in :  Artikel:TArtikelRecord  //der neue Artikel
  // out : boolean   //ob es ein neuer Artikel ist
  //------------------------------------------------------------------------------
  // Verwendet =
  //------------------------
  // private atribut:
  //  First : TListe
  //------------------------
  // private methode:
  //  NeueArtikelnummer,
  //  AddElement;
  //------------------------------------------------------------------------------
  // Lokale Variablen =
var
  InElement: TListe;
  //------------------------------------------------------------------------------
begin
  if NeueArtikelnummer(Artikel.ArtNr) then
  begin
    AddArtikel := True;
    new(InElement);
    InElement^.Artikel := Artikel;
    InElement^.Next := nil;
    First := AddElement(InElement);
  end
  else
    AddArtikel := False;
end;

function CArtikel.DelElement(Artikel: TArtikelRecord): TListe;
  // Löscht ein Artikel aus ein Pointer
  //------------------------------------------------------------------------------
  // Parameter =
  // in :  Artikel:TArtikelRecord  //der neue Artikel
  // out : First:TListe       //der pointer mit den neuen Artikel
  //------------------------------------------------------------------------------
  // Verwendet =
  // private atribut:
  //  First : TListe
  //------------------------------------------------------------------------------
  // Lokale Variablen =
var
  Runpointer, vor, nach: TListe;
  //------------------------------------------------------------------------------
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

function CArtikel.DelArtikel(Artikel: TArtikelRecord): boolean;
  // Erstellt ein Pointer mit den Neuen Artikel und fügt ein
  //------------------------------------------------------------------------------
  // Parameter =
  // in :  Artikel:TArtikelRecord  //der neue Artikel
  // out : boolean   //ob der Artikel existiert
  //------------------------------------------------------------------------------
  // Verwendet =
  //------------------------
  // private atribut:
  //  First : TListe
  //------------------------
  // private methode:
  //  NeueArtikelnummer,
  //  AddElement;
  //------------------------------------------------------------------------------
begin
  if NeueArtikelnummer(Artikel.ArtNr) then
    DelArtikel := False
  else
  begin
    DelArtikel := True;
    First := DelElement(Artikel);
  end;
end;

function CArtikel.NeueArtikelnummer(ArtNr: tstring30): boolean;
  // Erstellt ein Pointer mit den Neuen Artikel und fügt ein
  //------------------------------------------------------------------------------
  // Parameter =
  // in :  Dateiname:string
  // out : boolean   //ob der Artikel existiert im Pointer
  //------------------------------------------------------------------------------
  // Verwendet =
  // private atribut:
  //  First : TListe
  //------------------------------------------------------------------------------
  // Lokale Variablen =
var
  neu: boolean;
  runpointer: Tliste;
  //------------------------------------------------------------------------------
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
// Gibt den Speicher vom Pointer wieder frei
//------------------------------------------------------------------------------
// Verwendet =
// private atribut:
//  First : TListe
//------------------------------------------------------------------------------
// Lokale Variablen =
var
  RunPointer: TListe;
  //------------------------------------------------------------------------------
begin
  while First <> nil do
  begin
    Runpointer := First;
    First := Runpointer^.Next;
    Dispose(Runpointer);
  end;
end;

end.
