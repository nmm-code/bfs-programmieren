program project1;

{$R+}

uses
  Sysutils,Math;

const
  UncompressedOriginal = 'Original.txt';
  Uncompressedcopy = 'ErzeugteZiel.txt';
  Compressed = 'Ziel.dat';

type
  TInfo = packed record
    c: char;
    weight: uint64;
  end;

  TTreePtr = ^TTreeNode;

  TTreeNode = record
    info: TInfo;
    left, right: TTreePtr;
  end;

  TArray = array of TTreePtr;

  procedure printTree(z: TTreePtr; deep: byte);
  begin
    if z <> nil then
    begin
      printTree(z^.left, deep + 1);
      Write(z^.info.weight: 5 * deep);
      if Ord(z^.info.c) > 32 then
        writeln(',', z^.info.c)
      else
        writeln(',#', Ord(z^.info.c));
      printTree(z^.right, deep + 1);
    end;
  end;

  procedure initArray(var a: TArray);
  // Erzeugt und initialisiert die Knoten für jedes mögliche Zeichen
  // Parameter:
  // out: a - Initialisiertes Array
  var
    i: byte;
  begin
    setlength(a, 256);
    for i := 0 to 255 do
    begin
      new(a[i]);
      with a[i]^ do
      begin
        info.c := chr(i);
        info.weight := 0;
        left := nil;
        right := nil;
      end;
    end;
  end; {initArray}

  procedure sortArray(var a: TArray);
  // Sortierung der Arraylemente nach Gewicht
  // Parameter:
  // out: a - Sortiertes Array
  var
    j, i: word;
    check: boolean;
    safe: TTreePtr;
  begin
    if length(a) > 1 then
    begin
      i := 0;
      for j := 0 to length(a) - 1 do
      begin
        if (a[j]^.info.weight > 0) then
        begin
          safe := a[i];
          a[i] := a[j];
          a[j] := safe;
          Inc(i);
        end;
      end;

      repeat
        check := True;
        for j := 0 to i - 2 do
        begin
          if (a[j]^.info.weight > a[j + 1]^.info.weight) then
          begin
            check := False;
            safe := a[j + 1];
            a[j + 1] := a[j];
            a[j] := safe;
          end;
        end;
      until check;
    end;
  end;

  procedure deleteZeroElements(var a: TArray);
  // löscht alle Elemente des übergebenen Arrays mit Gewicht=0 und gibt reservierten Speicher wieder frei
  // out: a - Geändertes Array
  var
    z, i, j: word;
  begin
    z := 0;
    for j := 0 to length(a) - 1 do
    begin
      I := z;
      if (a[i] = nil) or (a[i]^.info.weight = 0) then
        while i <> length(a) - 1 do
        begin
          a[i] := a[i + 1];
          Inc(i);
        end
      else
        Inc(z);
    end;
    setlength(a, z);
  end;

  procedure buildArray(var a: TArray);
  // erstellt aus der zu komprimierenden Datei ein nach Gewicht der in
  // der Datei vorkommenden Zeichen aufsteigend sortiertes Array ohne die
  // nicht in der Datei vorkommenden Zeichen mit Gewicht=0
  // benötigt:
  // UPs: initArray,sortArray,deleteZeroElements
  // const: UncompressedOriginal - Dateiname der zu komprimierenden Datei
  // Parameter:
  // out: a - sortiertes Array
  var
    f: file of byte;
    b: byte;
  begin
    initArray(a);
    Assign(f, UncompressedOriginal);

    reset(f);


    while not EOF(f) do
    begin
      Read(f, b);
      Inc(a[b]^.info.weight);
    end;
    Close(f);
    sortArray(a);
    deleteZeroElements(a);
  end; {buildArray}

  procedure buildtree(var a: TArray; var z: TTreePtr);
  // Erstellt den binären Baum:
  // solange noch Elemente übrig sind, werden die jeweils ersten beiden Elemente
  // des Arrays zusammengefasst;
  // in a[0] steht am Ende der Wurzelzeiger des aufgebauten Baumes
  // benötigt:
  // UPs: sortArray,deleteZeroElements,buildArray
  // in (logisch): a - sortiertes Array (Arrayinhalt wird am Ende wieder
  //    hergestellt und muss daher byref zurückgegeben werden)
  // out: z - Zeiger auf den binären Baum
  var
    p: TTreePtr;
  begin
    while length(a) >= 2 do
    begin
      new(p);
      p^.info.weight := a[1]^.info.weight + a[0]^.info.weight;
      p^.left := a[0];
      p^.right := a[1];
      a[0] := p;
      a[1] := nil;
      deleteZeroElements(a);  // 2. Eintrag aus Array löschen
      sortArray(a);           // und neu sortieren
    end;
    z := a[0];
    buildArray(a);
  end;

  procedure findChar(c: char; p: TTreePtr; var bits: ansistring; var found: boolean);
  // sucht im Baum den Knoten mit dem Zeichen c und berechnet dabei die durch
  // den Suchweg entstehende Kodierung
  // Parameter:
  // in: c - zu suchendes Zeichen
  // out: bits - Codierung für das gefundene Zeichen
  // out: found - true, wenn Zeichen gefunden, sonst false
  begin
    if p^.info.c = c then
      found := True;
    if (c = '-') and ((p^.left <> nil) or (p^.right <> nil)) then
      found := False;
    if not found and (p^.left <> nil) then
    begin
      bits := bits + '1';
      findChar(c, p^.left, bits, found);
      if not found then
        Delete(bits, length(bits), 1);
    end;
    if not found and (p^.right <> nil) then
    begin
      bits := bits + '0';
      findChar(c, p^.right, bits, found);
      if not found then
        Delete(bits, length(bits), 1);
    end;
  end; {findChar}

  function file2sbit(p: TTreePtr): ansistring;
    // macht aus der unkomprimierten Datei unter Zuhilfenahme des erstellten
    // Baumes einen Ansistring zur Visualisierung der entstehenden Bitfolge
    // benötigt:
    // UPs: findChar
    // const: UncompressedOriginal - Dateiname der unkomprimierten Datei
    // Funkionsrückgabe: Ansistring +
  var
    f: file of byte;
    b: byte;
    bits: string;
    found: boolean;
  begin
    found := False;
    bits := '';
    Assign(f, UncompressedOriginal);
    reset(f);
    while not EOF(f) do
    begin
      Read(f, b);
      found := False;
      findChar(chr(b), p, bits, found);
    end;
    file2sbit := bits;
  end; {file2sbit}

  procedure writeCompressedFile(a: TArray; sb: ansistring);
  // Schreibt die komprimierte Datei
  // Dateiformat:
  // Anzahl der Zeichen: uint64
  // Anzahl der Bits: uint64
  // Zeichen und Gewichte: Anzahl der Zeichen * sizeof(TInfo)
  // Bits als Bytefolge (Anzahl: ...)
  // Verwendet:
  // const: compressed - Dateiname der komprimierten Datei
  // procedure writeBits
  // Parameter:
  // in: a - Sortiertes Array
  // in: sb - Ansistring mit den visualisierten, zu schreibenden "Bits"

    procedure writeBits(sb: ansistring; var f: file);
    // Schreibt die "Bits" aus dem Ansistring nach f (s. Übung 3 Aufgabe 1 bzw. Übung 5 Aufgabe 1)
    // Parameter:file und string
    var
      i, j, z: byte;
      s1: string;
    begin
      try
        repeat
          s1 := copy(sb, 1, 8);
          Delete(sb, 1, 8);
          z := 0;
          while (length(s1) div 8 = 0) do
          begin
            Inc(z);
            s1 := '0' + s1;
          end;

          j := 0;
          for i := length(s1) downto 1 do
            if s1[i] = '1' then
              j := j + 2 ** (length(s1) - i);

          Blockwrite(f, j, 1);
        until sb = '';
      except
        Write('Fehler beim Bits schreiben');
      end;
    end;

  var
    f: file;
    i: byte;
    lenElements, lenBits: uint64;
  begin
    try
      Assign(f, compressed);
      rewrite(f, 1);

      lenElements := length(a);
      lenBits := length(sb);
      blockwrite(f, lenElements, sizeof(uint64));
      blockwrite(f, lenBits, sizeof(uint64));

      for i := 0 to length(a) - 1 do
        blockwrite(f, a[i]^.info, sizeof(TInfo));

      writeBits(sb, f);

      Close(f);
    except
      writeln('Komprimierte Datei konnte nicht erzeugt werden.')
    end;
  end; {writeCompressedFile}

  function readCompressedFile(var a: TArray):string;
  // Lese die komprimierte Datei
  // Erzeugt ein String mit der Bit Reihenfolge
  // Erzeugt ein Array mit den Inthalt der Datei
  // Verwendet:
  // const: compressed
  // function readbits
  // function Dez2bin
  // Parameter:
  // in: Ziel.dat
  // out: sb - Bit Reihenfolge
  // out: a - Sortiertes Array
    function readbits(var f: file;len:word): string;
    var
      i, j: byte;
      s, erg,tab: ansistring;
    begin
      try
      tab := '01';
      erg := '';
      i := 0;

      while not EOF(f) do
      begin
        Blockread(f, i, 1);

        s:='';
        repeat
          s := tab[(i and 1) + 1] + s;
          i := i shr 1;
        until i = 0;

        while (length(s) div 8 = 0) do
          s := '0' + s;

        if len>8 then
        len:=len-8
        else
        begin
        for j := 1 to 8-len do
          Delete(s, 1, 1);
        end;

        erg := erg + s;
      readbits := erg;
      end;
      except
        write('Fehler beim bits lesen');
      end;
    end;

  var
    f: file;
    i: byte;
    lenElements, lenBits: uint64;
  begin
    try
      Assign(f, compressed);
      reset(f, 1);

      lenElements := 0;
      lenBits := 0;

      blockread(f, lenElements, sizeof(uint64));
      blockread(f, lenBits, sizeof(uint64));

      setlength(a, lenElements);

      for i := 0 to length(a) - 1 do
        blockread(f, a[i]^.info, sizeof(TInfo));

     readCompressedFile:= readBits(f,lenBits);

      Close(f);
    except
      writeln('Komprimierte Datei konnte gelesen werden.')
    end;
  end;

  procedure writeUncompressedFile(sb: ansistring; root: TTreePtr);
  // Erzeugt die Original.txt wieder her
  // Parameter
  // in - sb: Bit Reinfolge
  // in - root: Die Wurzel vom Binäre Baum
  // out: file mit den Orinal inhalt
  // Verwendet:
  // const: Uncompressedcopy
  var
    i, j, n: uint64;
    p: TTreePtr;
    f: file of byte;
  begin
    Assign(f, Uncompressedcopy);
    rewrite(f);
    n := root^.info.weight;
    p := root;
    i := 1;  // Zähler Zeichen
    j := 1;  // Zähler Bits

    while i <= n do
    begin
      if sb[j] = '0' then
        p := p^.left
      else
        p := p^.right;

      if (p^.right = nil) and (p^.left = nil) then
      begin
        Write(f, Ord(p^.info.c));
        p := root;
        Inc(i);
      end;
      Inc(j);
    end;
    Close(f);
  end;

var
  a: TArray;
  tree: TTreePtr;
  sb: ansistring;

begin
  a := nil;
  buildArray(a);
  tree := nil;
  buildTree(a, tree);
  printTree(tree,0);
  sb := file2sbit(tree);
  writeCompressedFile(a, sb);
  sb:=readCompressedFile(a);
  buildTree(a, tree);
  writeUncompressedFile(sb, tree);
end.
