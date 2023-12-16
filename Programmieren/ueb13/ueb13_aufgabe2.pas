program ueb13_aufgabe2;

{$R+}
uses
  Math;

type
  Tmenge = byte;
  TElemente = (Rot, Blau, Gruen, Gelb, Braun, Schwarz, Weiss, Orange);

  function ElementetoMenge(Element: TElemente): Tmenge;
  begin
    ElementetoMenge := 1 shl Ord(Element);
  end;

  function LeereMenge(Menge: Tmenge): Tmenge;
  begin
    LeereMenge := Menge shr 8;
  end;

  function ZufallsMenge: Tmenge;
  begin
    ZufallsMenge := random(8) + 1;
  end;

  function AddElemente(Menge: Tmenge; Element: TElemente): Tmenge;
  begin
    AddElemente := Menge or ElementetoMenge(Element);
  end;

  function Entferneelement(Menge: Tmenge; Element: TElemente): Tmenge;
  begin
    if Menge and ElementetoMenge(Element) <> 0 then
      EntferneElement := Menge xor ElementetoMenge(Element);
  end;

  function Schnittmenge(menge1, menge2: Tmenge): Tmenge;
  begin
    if Menge1 xor menge2 <> 0 then
      Schnittmenge := menge1 and menge2;
  end;

  function Vereinigungsmenge(menge1, menge2: Tmenge): Tmenge;
  begin
    Vereinigungsmenge := Menge1 or Menge2;
  end;

  function Differenzmenge(menge1, menge2: Tmenge): Tmenge;
  begin
    Differenzmenge := (menge1 xor menge2) and menge1;
  end;

  function ElementVorhanden(Menge: TMenge; Element: TElemente): boolean;
  begin
    ElementVorhanden := Menge and ElementetoMenge(Element) = ElementetoMenge(Element);
  end;

  function IstTeilmenge(menge1, menge2: Tmenge): boolean;
  begin
    IstTeilmenge := (menge1 xor menge2) <> (menge1 or menge2);
  end;

  procedure Schreibemenge(menge: tMenge);
  var
    i: byte;
  begin
    for i := 0 to 7 do
      if (menge shr i) and 1 <> 0 then
        Write(TElemente(i),' ');
  end;

var
  i: byte;
  menge1, menge2: tmenge;
  Element: Telemente;
begin
  randomize;
  for i := 1 to 5 do
    writeln('Zufallsmenge', ' = ', ZuFallsmenge());

  menge1 := ADDElemente(menge1, Rot);
  Element := Blau;

  writeln('Menge = ', menge1, '  Element = BLau', ' Addmenge', ' = ',
    addElemente(menge1, Element));

  menge1 := addElemente(menge1, Blau);

  Writeln('Menge = ', menge1, '  Element = BLau', ' Entfernemenge', ' = ',
    entferneelement(menge1, Element));

  menge2 := 2;

  writeln('Schnittmenge :', ' Menge1:', menge1, ' Menge2:', menge2, ' = ',
    Schnittmenge(menge1, menge2));

  writeln('Vereinigungsmenge:', ' Menge1:', menge1, ' Menge2:', menge2
    , ' = ', Vereinigungsmenge(menge1, menge2));

  writeln('Differenzmenge :', ' Menge1:', menge1, ' Menge2:', menge2,
    ' = ', Differenzmenge(menge1, menge2));
  writeln('Ist in menge1 Blau enthalten? ', ElementVorhanden(Menge1, Element));

  writeln('Ist die Teilemenge von menge1 in menge2 enhalten? ',
    IstTeilmenge(Menge1, Menge2));

  menge1 := 15;
  menge2 := 2;

  Write('Menge1: ');
  Schreibemenge(Menge1);
  writeln;
  Write('Menge2: ');
  schreibemenge(Menge2);
end.
