program ueb12;

{$R+}

const
  n = 10;
  start = 'a';
  ende = 'j';
type
  Tindex = start..ende;
  Ttab = array[Tindex, Tindex] of word;
  TBuchstaben = set of start..ende;
const
  ort: array[tindex] of
    string = ('Haus', 'Baecker', 'Cafe', 'Drogerie', 'Eisdiele', 'Fahrradladen',
    'Gemuesehaendler', 'Hutmacher', 'Indoorspielplatz', 'Jugendtreff');

  tab: Ttab = (
    (0, 10, 65, 47, 33, 17, 20, 22, 55, 34),
    (12, 0, 71, 52, 22, 56, 36, 22, 43, 22),
    (65, 75, 0, 44, 50, 66, 77, 09, 35, 16),
    (14, 72, 44, 0, 62, 65, 11, 68, 82, 43),
    (32, 17, 11, 60, 0, 65, 11, 02, 82, 43),
    (72, 32, 24, 40, 62, 0, 19, 12, 81, 09),
    (22, 37, 25, 70, 77, 20, 0, 43, 23, 62),
    (32, 37, 25, 73, 75, 42, 91, 0, 23, 12),
    (29, 39, 05, 24, 57, 13, 30, 43, 0, 91),
    (12, 38, 34, 25, 23, 15, 36, 98, 22, 0));

  function route: string;
  const
    gr = 100;
  var
    ort: word;
    posi, x, y: char;
    s: string;
  begin
    s := start;
    x := start;
    ort := gr;
    while length(s) < n do
    begin
      for y := start to ende do
        if (tab[x, y] < ort) and (tab[x, y] <> 0) then
          if pos(y, s) = 0 then
          begin
            ort := tab[x, y];
            posi := y;
          end;
      x := posi;
      s := s + x;
      ort := gr;
    end;
    route := s;
  end;

  function zeit(s: string): word;
  var
    i, z1, z2: word;
  begin
    z1 := 0;
    i := 1;
    s := s + 'a';
    while i < length(s) do
    begin
      z2 := tab[s[i], s[i + 1]];
      z1 := z1 + z2;
      Inc(i);
    end;
    zeit := z1;
  end;

  procedure besteloesung(s: string; var bestzeit: word; var beststring: string);
  begin
    if zeit(s) < bestzeit then
    begin
      bestzeit := zeit(s);
      beststring := s;
    end;
  end;

  function check(s: string): boolean;
  var
    i: word;
    Buchstaben: Tbuchstaben;
  begin
    check := True;

    Buchstaben := [];
    if s[1] = 'a' then
    begin
      for i := 1 to length(s) do
        if s[i] in buchstaben then
          check := False
        else
          Buchstaben := buchstaben + [s[i]];

    end
    else
      check:= False;
  end;

  procedure rekur(test: string; ebene: byte; var bestzeit: word; var beststring: string);
  var
    i: char;
  begin
    if ebene = n then
      besteloesung(test, bestzeit, beststring)
    else
      for i := start to ende do
        if check(test + i) then
          rekur(test + i, ebene + 1, bestzeit, beststring);
  end;

var
  s: string;
  i: byte;
  z1: word;
begin
  s := '';
  z1 := 500;

  for i := 1 to length(route) do
    Write(ort[route[i]], '-');       //Schnellste Route
  Writeln(zeit(route), ' min');

  rekur('', 0, z1, s);
  for i := 1 to length(s) do         //Rekursive Route
    Write(ort[s[i]], '-');
  Writeln(z1, ' min ');

end.
