unit ueb18_article;

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
    function AddElement(InElement: TListe): TListe;
    function DelElement(Artikel:TArtikelRecord): TListe;
    function  SwElement(Artikel:TArtikelRecord): TListe;
    function NeueArtikelnummer(ArtNr: tstring30): boolean;
  public
    function LoadFromFile(Dateiname: string): boolean;
    function SaveToFile(Dateiname: string): boolean;
    procedure AddArtikel(Artikel: TArtikelRecord);
    procedure DelArtikel(Artikel: TArtikelRecord);
    procedure SwitchArtikel(Artikel: TArtikelRecord);
    procedure ShowAll;
    procedure DisposeAll;
  end;

implementation

function CArtikel.LoadFromFile(Dateiname: string): boolean;
var
  f: file of TArtikelRecord;
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
    new(InElement);
    InElement^.Artikel := Artikel;
    InElement^.Next := nil;
    First := AddElement(InElement);
  end
  else
    writeln('ArtNr ist schon Vorhanden!');
end;

function CArtikel.DelElement(Artikel:TArtikelRecord): TListe;
var
  Runpointer,vor,nach: TListe;
begin
  runpointer := First;
  if (First^.Next <> nil) and (Artikel.ArtNr = First^.Artikel.ArtNr) then
  begin
    runpointer := First^.Next;
    First := Runpointer;
  end
  else
  begin
    while (runpointer^.Next  <> nil) and (runpointer^.Next^.Artikel.ArtNr<>Artikel.ArtNr) do
      runpointer := runpointer^.Next;

   vor:= runpointer;
   runpointer := runpointer^.Next;
   runpointer := runpointer^.Next;
   nach:=runpointer;

   vor^.Next:=nach;
  end;

  DelElement := First;
end;

procedure CArtikel.DelArtikel(Artikel: TArtikelRecord);
begin
  if NeueArtikelnummer(Artikel.ArtNr) then
    writeln('ArtNr ist nicht Vorhanden!')
  else
  begin
    First := DelElement(Artikel);
  end;
end;

function CArtikel.SwElement(Artikel:TArtikelRecord): TListe;
var
  Runpointer,temp1,temp2,temp3: TListe;
begin
  runpointer := First;
  if (First^.Next <> nil) and (Artikel.ArtNr = First^.Artikel.ArtNr) then
  begin
    runpointer := First^.Next;
    First := Runpointer;
  end
  else
  begin
    while (runpointer^.Next  <> nil) and (runpointer^.Next^.Artikel.ArtNr<>Artikel.ArtNr) do
      runpointer := runpointer^.Next;

    temp1:=runpointer^.next;
    temp2:=runpointer^.next^.next;
    temp3:=runpointer^.next^.next^.next;

    runpointer^.next:=temp2;
    temp2^.next:=temp1;
    temp1^.next:=temp3;
  end;

  SwElement := First;
end;

procedure CArtikel.SwitchArtikel(Artikel: TArtikelRecord);
begin
  if NeueArtikelnummer(Artikel.ArtNr) then
    writeln('ArtNr ist nicht Vorhanden!')
  else
  begin
    First := SwElement(Artikel);
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

procedure CArtikel.ShowAll;
var
  RunPointer: TListe;
begin
  writeln('Inhalt der Liste:');
  RunPointer := First;
  while RunPointer <> nil do
  begin
    Write(RunPointer^.Artikel.ArtNr, ' ');
    RunPointer := RunPointer^.Next;
  end;
  writeln(#10);
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
