unit u_Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, Sockets, Grids;

type

  { TFMain }

  TFMain = class(TForm)
    MenuX: TMenuItem;
    MenuMain: TMainMenu;
    MenuServer: TMenuItem;
    MenuServerClose: TMenuItem;
    MenuAdressEinstellen: TMenuItem;
    MenuMenue: TMenuItem;
    MenuArtikel: TMenuItem;
    MenuHinzufuegen: TMenuItem;
    MenuLoeschen: TMenuItem;
    MenuZeigen: TMenuItem;
    MenuAdresse: TMenuItem;
    MenuVerbinden: TMenuItem;
    MenuTrennen: TMenuItem;
    SG: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure MenuAdressEinstellenClick(Sender: TObject);
    procedure MenuHinzufuegenClick(Sender: TObject);
    procedure MenuLoeschenClick(Sender: TObject);
    procedure MenuServerCloseClick(Sender: TObject);
    procedure MenuTrennenClick(Sender: TObject);
    procedure MenuVerbindenClick(Sender: TObject);
    procedure MenuXClick(Sender: TObject);
    procedure MenuZeigenClick(Sender: TObject);
  private
    Adr: array[0..3] of byte;
    Port: word;
    Verbunden: boolean;
    procedure SetGridSize;
  public
    SocketHandle: longint;
    SocketAddr: TInetSockAddr;
    inText, outText: Text;
  end;

var
  FMain: TFMain;

implementation

{$R *.lfm}
uses
  f_set, f_eingabe;

const
  cAdr: array[0..3] of longint = (127, 0, 0, 1);
  cPort = 7777;
  Spalten = 3;

procedure TFMain.SetGridSize;
// Ändert die Breite der Tabelle beim Aufruf
//------------------------------------------------------------------------------
// Verwendet =
// SG:TStringGrid;
//------------------------------------------------------------------------------
begin
  SG.DefaultColWidth := clientwidth div Spalten;
end;

procedure TFMain.FormCreate(Sender: TObject);
// Standard Ip Adresse auf localhost setzen
// Port = 7777
//------------------------------------------------------------------------------
// Verwendet =
//-------------------------
//  private atribute:
//   ip[0..3]:array[0..3] of byte;
//   Port:word;
//   Verbunden:boolean:
//-------------------------
//  const:
//   cAdr = (127, 0, 0, 1);
//   cPort = 7777;
//------------------------------------------------------------------------------
//  Lokale Variablen =
var
  i: byte;
begin
  sg := TStringgrid.Create(Fmain);
  for i := 0 to 3 do
    Adr[i] := cAdr[i];

  Port := cPort;
  Verbunden := False;
end;

procedure TFMain.FormResize(Sender: TObject);
// Wenn die Form größe sich ändert wird SetGridSize Verwendet
// die größe wird dann neu skaliert
//------------------------------------------------------------------------------
// Verwendet =
//-------------------------
// private methode:
//    SetGridSize;
//------------------------------------------------------------------------------
begin
  SetGridSize;
end;

procedure TFMain.MenuAdressEinstellenClick(Sender: TObject);
// Öffnet ein Seperates Fenster
// Womit man die Ip Adresse und Port einstellen kann
// Rückgabe = ModalResult
//------------------------------------------------------------------------------
// Verwendet =
//-------------------------
//  Forms =
//   f_set:Form;
//   Öffentliche Methoden:
//   GetFeld1,GetFeld2,GetFeld3,GetFeld4:byte;GetPort:word;
//-------------------------
//  private: atribute:
//   Adr:array[0..3] of byte;
//   Port: word;
//------------------------------------------------------------------------------
begin
  FSet.SetFeld(Adr[0], Adr[1], Adr[2], Adr[3], Port);
  if FSet.ShowModal = mrOk then
  begin
    Adr[0] := FSet.GetFeld1;
    Adr[1] := FSet.GetFeld2;
    Adr[2] := FSet.GetFeld3;
    Adr[3] := FSet.GetFeld4;
    Port := FSet.GetPort;
  end;
end;

procedure TFMain.MenuVerbindenClick(Sender: TObject);
// Versucht die Verbindung aufzubauen
// Wenn die Verbindung steht wird das Verbunden=true
//------------------------------------------------------------------------------
// Verwendet =
//-------------------------
//  private: atribute:
//   Verbunden:boolean;
//-------------------------
//  public: atribute;
//   SocketHandle: longint;
//   SocketAddr: TInetSockAddr;
//   inText, outText: Text;
//------------------------------------------------------------------------------
begin
  SocketHandle := fpSocket(AF_INET, SOCK_STREAM, 0);
  SocketAddr.sin_family := AF_INET;
  SocketAddr.sin_port := htons(Port);
  SocketAddr.sin_addr.s_addr :=
    HosttoNet(Adr[0] shl 24 + Adr[1] shl 16 + Adr[2] shl 8 + Adr[3]);

  if not connect(SocketHandle, SocketAddr, inText, outText) then
    ShowMessage('Verbindung konnte nicht hergestellt werden.')
  else
  begin
    ShowMessage('Verbunden');
    Verbunden := True;
  end;
end;

procedure TFMain.MenuXClick(Sender: TObject);
begin
  if not Verbunden then
  begin
    SG.Free;
    Close;
  end
  else
    ShowMessage('Die Verbindung muss abgebrochen werden');
end;

procedure TFMain.MenuTrennenClick(Sender: TObject);
// Wenn Verbunden = True dann schreibt er dem Server 'quit'
// Der Server trennt sich dann
// schliesst das Formular
//------------------------------------------------------------------------------
// Verwendet =
//-------------------------
//  private: atribute:
//   Verbunden:boolean;
//-------------------------
//  public: atribute;
//   outText: Text;
//------------------------------------------------------------------------------
begin
  if Verbunden then
  begin
    writeln(outText, 'quit');
    flush(outText);
    Verbunden := False;
  end
  else
    ShowMessage('Keine Verbindung');
end;

procedure TFMain.MenuServerCloseClick(Sender: TObject);
// Wenn Verbunden = True dann schreibt er dem Server 'stop'
// Der Server beendet sich und
// schliesst das Formular
//------------------------------------------------------------------------------
// Verwendet =
//-------------------------
//  private: atribute:
//   Verbunden:boolean;
//-------------------------
//  public: atribute;
//   outText: Text;
//------------------------------------------------------------------------------
begin
  if Verbunden then
  begin
    writeln(outText, 'stop');
    flush(outText);
    Verbunden := False;
  end
  else
    ShowMessage('Keine Verbindung zum Server');
end;

procedure TFMain.MenuHinzufuegenClick(Sender: TObject);
// Wenn Verbunden = True dann schreibt er dem Server 'Eingabe'
// Der Server fügt den Artikel hinzu dem man eingegeben hat
//------------------------------------------------------------------------------
// Verwendet =
//-------------------------
//  private: atribute:
//   Verbunden:boolean;
//-------------------------
//  public: atribute;
//   intext,outText: Text;
//-------------------------
//  Forms =
//   FEingabe:Form
//   Öffentliche Methoden =
//    getArtNummer,getLagerort,getBezeichner;
//------------------------------------------------------------------------------
//  Lokale Variablen =
var
  s: string;
begin
  if Verbunden then
  begin
    FEingabe.Caption := 'Neuer Artikel';
    if FEingabe.Showmodal <> mrCancel then
    begin
      writeln(outText, 'Eingabe');
      writeln(outText, FEingabe.getArtNummer);
      writeln(outText, FEingabe.getLagerort);
      writeln(outText, FEingabe.getBezeichner);
      flush(outText);
      readln(inText, s);
      if s = '0' then
        ShowMessage('Artikel existiert');
    end;
  end
  else
    ShowMessage('Keine Verbindung');

end;

procedure TFMain.MenuLoeschenClick(Sender: TObject);
// Wenn Verbunden = True dann schreibt er dem Server 'Loeschen'
// Der Server löscht den Artikel der eingegeben würde
//------------------------------------------------------------------------------
// Verwendet =
//-------------------------
//  private: atribute:
//   Verbunden:boolean;
//-------------------------
//  public: atribute;
//   outText: Text;
//-------------------------
//  Forms =
//   FEingabe:Form
//   Öffentliche Methoden =
//    getArtNummer,getLagerort,getBezeichner;
//------------------------------------------------------------------------------
//  Lokale Variablen =
var
  s: string;
begin
  if Verbunden then
  begin
    FEingabe.Caption := 'Artikel löschen';
    if FEingabe.ShowModal <> mrCancel then
    begin
      rewrite(outText);
      writeln(outText, 'Loeschen');
      writeln(outText, FEingabe.getArtNummer);
      flush(outText);
      readln(inText, s);
      if s = '1' then
        ShowMessage('Artikel existiert nicht');
    end;
  end
  else
    ShowMessage('Keine Verbindung');
end;

procedure TFMain.MenuZeigenClick(Sender: TObject);
// Wenn Verbunden = True dann schreibt er dem Server 'Anzeigen'
// Der Server schickt ein string mit allen Artikeln
//------------------------------------------------------------------------------
// Verwendet =
//-------------------------
//  private: atribute:
//   Verbunden:boolean;
//-------------------------
//  public: atribute;
//   outText,inText: Text;
//-------------------------
//  const:
//   Elementeheight = 24;
//   scrollheight = 12;
//   Spalten = 3;
//--------------------------
//  FMain =
//   SG:TStringGrid;
//------------------------------------------------------------------------------
//  Lokale Variablen =
var
  i, j: byte;
  main, s: string;
begin
  if Verbunden then
  begin
    rewrite(outText);
    writeln(outText, 'Anzeigen');
    flush(outText);
    readln(inText, main);
    sg.Parent := Fmain;
    sg.Align := alClient;
    sg.ColCount := Spalten;
    sg.Visible := True;
    SG.Cells[0, 0] := 'Artikelnummer';
    SG.Cells[1, 0] := 'Lagerort';
    SG.Cells[2, 0] := 'Bezeichnung';
    i := 1;
    while main <> '' do
    begin
      SG.RowCount := i + 1;
      for j := 0 to 2 do
      begin
        s := copy(main, 1, pos(' ', main) - 1);
        Delete(main, 1, pos(' ', main));
        SG.Cells[j, i] := s;
      end;
      Inc(i);
    end;
    SetGridSize;
  end
  else
    ShowMessage('Keine Verbindung');
end;


end.
