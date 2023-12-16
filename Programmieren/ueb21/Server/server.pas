program Server;

uses
  SysUtils,
  Sockets,
  U_ArtikelListe;  //Verwendet die Unit mit den Pointer Operationen

const
  port = 7777;
  stop = 'stop';
  quit = 'quit';
  Dateiname = 'Artikel.dat';

  function CreateSocket(port: word): longint;
    // Socket spezifizieren
    //------------------------------------------------------------------------------
    // Parameter =
    //------------------------
    // in: Port
    // out: SocketHandle
    //------------------------------------------------------------------------------
  var
    SocketHandle: longint;
    SocketAddr: TInetSockAddr;
  begin
    try
      SocketHandle := fpSocket(AF_INET, SOCK_STREAM, 0);
      SocketAddr.sin_family := AF_INET;
      SocketAddr.sin_port := htons(port);
      SocketAddr.sin_addr.s_addr := 0;
      fpBind(SocketHandle, @SocketAddr, sizeof(SocketAddr));
      fpListen(SocketHandle, 1);
      CreateSocket := SocketHandle;
    except
      CreateSocket := -1;
    end;
  end;

  function MirrorAddr(s: string): string;
    // Ip Adresse umdrehen für die Ausgabe
    //------------------------------------------------------------------------------
    // Parameter =
    //------------------------
    // in : Adresse:string
    // out : (umgedrehte/richtige) Adresse:string
    //------------------------------------------------------------------------------
    // Lokale Variable =
  var
    sLokal: string;
    //------------------------------------------------------------------------------
  begin
    sLokal := '';

    while s <> '' do
    begin
      if pos('.', s) <> 0 then
      begin
        sLokal := '.' + copy(s, 1, pos('.', s) - 1) + sLokal;
        Delete(s, 1, pos('.', s));
      end
      else
      begin
        sLokal := copy(s, 1, length(s)) + sLokal;
        Delete(s, 1, length(s));
      end;

    end;
    Result := sLokal;
  end;

var
  SocketHandle: longint;
  inBuffer: shortstring;
  inText, outText: Text;
  ClientSocketAddr: TInetSockAddr;
  ArtI: Cartikel;
  Artikel: TArtikelRecord;
begin
  //Hauptprogramm Start
  writeln('Server gestartet ...');
  socketHandle := CreateSocket(port);

  if Sockethandle <> -1 then // -1 ist im Except teil gewesen vom CreatSocket
  begin
    repeat
      accept(SocketHandle, ClientSocketAddr, inText, outText);
      //Wartet auf die Verbindung
      ArtI := CArtikel.Create;
      if ArtI.LoadFromFile(Dateiname) then
      begin
        writeln('Anmeldung von Adresse ',
          MirrorAddr(HostAddrToStr(ClientSocketAddr.sin_addr)));
        try
          reset(inText);
          rewrite(outText);
          repeat
            readln(inText, inBuffer);
            if (inBuffer <> stop) and (inBuffer <> quit) then
              case inBuffer of
                'Eingabe':
                begin
                  readln(inText, Artikel.ArtNr);
                  readln(inText, Artikel.Lagerort);
                  readln(inText, Artikel.Bezeichnung);
                  if not ArtI.AddArtikel(Artikel) then
                    writeln(outText, '0')    //doppelter Artikel
                  else
                    writeln(outText, '1');

                  flush(outText);
                end;
                'Loeschen':
                begin
                  readln(inText, Artikel.ArtNr);
                  if ArtI.DelArtikel(Artikel) then
                    writeln(outText, '0')    //Artikel existiert
                  else
                    writeln(outText, '1');

                  flush(outText);
                end;
                'Anzeigen':
                begin
                  writeln(outText, ArtI.ListtoStr);  // ArtI.ListtoStr = String Rückgabe
                  flush(outText);
                end;
              end;
          until (inBuffer = stop) or (inBuffer = quit);
        except
          writeln('Fehler beim Schrieben / Lesen');
        end;

        writeln('Abmeldung von Adresse ', MirrorAddr(
          HostAddrToStr(ClientSocketAddr.sin_addr)));

        if not ArtI.SaveToFile(Dateiname) then
          writeln('Fehler beim Datei Schreiben');
        ArtI.DisposeAll;
      end
      else
        writeln('Probleme mit dem Laden vom File');
      ArtI.Free;
    until (inBuffer = stop);
    CloseSocket(SocketHandle);
    writeln('Server beendet .');
  end
  else
    writeln('Error', SocketError);
end.
