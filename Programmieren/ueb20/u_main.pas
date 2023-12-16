unit u_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus,
  ExtCtrls, StdCtrls, Grids, u_ArtikelListe;

type

  { TFMain }

  TFMain = class(TForm)
    Artikel: TMenuItem;
    MenuItem1: TMenuItem;
    MNotAnzeigen: TMenuItem;
    MErstellen: TMenuItem;
    MBeenden: TMenuItem;
    MLoeschen: TMenuItem;
    MAnzeigen: TMenuItem;
    MStart: TMenuItem;
    tMenue: TMainMenu;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure MErstellenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MAnzeigenClick(Sender: TObject);
    procedure MBeendenClick(Sender: TObject);
    procedure MLoeschenClick(Sender: TObject);
    procedure MNotAnzeigenClick(Sender: TObject);
  private
    Ende: boolean;
    SG: TStringGrid;
    procedure SetGridSize;
  end;

var
  FMain: TFMain;
  ArtikelInstanz: Cartikel;

implementation

{$R *.lfm}
uses
  f_eingabe;

const
  datei = 'Artikel.dat';
  defaultheight = 200;
  Elementeheight = 24;
  scrollheight = 12;
  Spalten = 3;

procedure TFMain.FormCreate(Sender: TObject);
begin
  SG := TStringGrid.Create(Fmain);
  ArtikelInstanz := CArtikel.Create;

  if ArtikelInstanz.LoadFromFile(datei) then
    ende := True
  else
    ende := False;
  FMain.Height := defaultheight;
end;

procedure TFMain.SetGridSize;
begin
  SG.DefaultColWidth := clientwidth div Spalten;
end;

procedure TFMain.MAnzeigenClick(Sender: TObject);
var
  i,j: byte;
  main,s:string;
begin
  SG.Parent := FMain;
  SG.Align := alClient;
  SG.ColCount := Spalten;
  SG.Visible := True;
  i := 0;
  SG.Cells[0, i] := 'Artikelnummer';
  SG.Cells[1, i] := 'Lagerort';
  SG.Cells[2, i] := 'Bezeichnung';
  Inc(i);
  main:=Artikelinstanz.ListtoStr;
  while main<>'' do
  begin
    SG.RowCount := i + 1;
    for j:=0 to 2 do
    begin
    s:=copy(main,1,pos(' ',main)-1);
    delete(main,1,pos(' ',main));
    SG.Cells[j, i] := s;
    end;
    inc(i);
  end;
  SetGridSize;
  FMain.Height := (SG.RowCount * Elementeheight) + Elementeheight + scrollheight;
end;

procedure TFMain.MErstellenClick(Sender: TObject);
var
  Art: TArtikelRecord;
begin
  FEingabe.Caption := 'Artikel erstellen';
  FEingabe.Showmodal;

  Art.ArtNr := FEingabe.GetArt;
  Art.Lagerort := FEingabe.GetLagerort;
  Art.Bezeichnung := FEingabe.GetBezeichnung;

  if not FEingabe.schliessen then
    ArtikelInstanz.AddArtikel(Art);
end;

procedure TFMain.FormResize(Sender: TObject);
begin
  SetGridSize;
end;

procedure TFMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if ArtikelInstanz.SavetoFile(datei) and Ende then
  begin
    ArtikelInstanz.DisposeAll;
    ArtikelInstanz.Free;
  end;
end;

procedure TFMain.MBeendenClick(Sender: TObject);
begin
  Close;
end;

procedure TFMain.MLoeschenClick(Sender: TObject);
var
  Art: TArtikelRecord;
begin
  FEingabe.Caption := 'Artikel löschen';
  FEingabe.Showmodal;

  Art.ArtNr := FEingabe.GetArt;
  Art.Bezeichnung := FEingabe.GetBezeichnung;
  Art.Lagerort := FEingabe.GetLagerort;

  if not FEingabe.schliessen then
    ArtikelInstanz.DelArtikel(Art);
end;

procedure TFMain.MNotAnzeigenClick(Sender: TObject);
begin
  SG.Visible := False;
  FMain.Height := defaultheight;
end;


end.
