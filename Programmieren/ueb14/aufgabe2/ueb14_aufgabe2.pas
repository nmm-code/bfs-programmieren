program ueb14_aufgabe2;
{$I-}
  procedure Allinclude(var Quelle, Ziel: Text);
  var
    s: string;
    newQ: Text;
  begin

    reset(quelle);
    if ioresult <> 0 then
      writeln('Fehler beim Oeffnen');

    while not EOF(quelle) do
    begin
      readln(quelle, s);
      if pos('$I ', s) <> 0 then
      begin
        Delete(s, 1, pos('$I ', s) + 2);
        Delete(s, pos('.pas', s) + 4, length(s));
        Assign(newQ, s);
        Allinclude(newQ, ziel);

        if ioresult <> 0 then
          writeln('Fehler beim Schliessem');
        Close(newQ);
      end
      else
        writeln(ziel, s);
    end;
  end;

var
  quelle, ziel: Text;
begin
  Assign(ziel, 'ziel.txt');
  Assign(quelle, 'a.pas');

  rewrite(ziel);
  if ioresult <> 0 then
    writeln('Fehler beim Oeffnen');
  Allinclude(quelle, ziel);

  Close(ziel);
  if ioresult <> 0 then
    writeln('Fehler beim Schliessen');

end.
