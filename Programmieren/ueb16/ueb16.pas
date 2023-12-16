program ueb16;

uses
  Math,
  SysUtils;

type
  Tfile = file of word;
  TValueList = ^TElement;

  TElement = record
    Value: integer;
    Next: TValueList;
  end;
  TArrayIndex = (alle, end7, fibo, mersenne);
  TListArray = array[TArrayIndex] of TValueList;
const
  Anzahl = 100;
  maxZahl = 100;

  function NewElement(i: word): TValueList;
  var
    TempElement: TValueList;
  begin
    new(TempElement);
    Tempelement^.Value := i;
    Tempelement^.Next := nil;
    NewElement := Tempelement;
  end;

  function SortiertINList(var First: TValueList; NewElement: TValueList): TValueList;
  var
    Runpointer: TValueList;
    check: boolean;
  begin
    if (First <> nil) and (First^.Value < NewElement^.Value) then
    begin
      check := False;
      Runpointer := First;

      while (Runpointer^.Next <> nil) and (not check) do
        if Runpointer^.Next^.Value >= NewElement^.Value then
          check := True
        else
          Runpointer := Runpointer^.Next;


      NewElement^.Next := Runpointer^.Next;
      Runpointer^.Next := NewElement;
    end
    else
    begin
     NewElement^.Next := First;
     First := NewElement;
    end;

    sortiertInList := First;
  end;

  function Ende7(list: TValueList): TValueList;
  var
    RunPointer, neu, inElement: TValueList;
    s: string;
  begin
    neu := nil;

    RunPointer := list;
    while RunPointer <> nil do
    begin
      str(RunPointer^.Value, s);
      if s[length(s)] = '7' then
      begin
        inElement := NewElement(RunPointer^.Value);
        SortiertINList(neu, InElement);
      end;
      RunPointer := RunPointer^.Next;
    end;

    Ende7 := neu;
  end;

  function fibon(list: TValueList): TValueList;

    function fibonacci(n: byte): qword;
    begin
      if n <= 2 then
        fibonacci := 1
      else
        fibonacci := fibonacci(n - 2) + fibonacci(n - 1);
    end;

  var
    RunPointer, neu, inElement: TValueList;
    i: word;
  begin
    neu := nil;
    RunPointer := list;

    while RunPointer <> nil do
    begin
      i := 1;
      repeat
        Inc(i);
        if fibonacci(i) = RunPointer^.Value then
        begin
          inElement := NewElement(RunPointer^.Value);
          SortiertINList(neu, InElement);
        end;
      until (fibonacci(i) > RunPointer^.Value);
      RunPointer := RunPointer^.Next;
    end;
    fibon := neu;
  end;

  function mers(list: TValueList): tValueList;
  var
    RunPointer, neu, inElement: TValueList;
    i: word;
  begin
    neu := nil;
    RunPointer := list;
    while RunPointer <> nil do
    begin
      i := 0;
      repeat
        Inc(i);
        if 2 ** i - 1 = RunPointer^.Value then
        begin
          inElement := NewElement(RunPointer^.Value);
          SortiertINList(neu, InElement);
        end;
      until 2 ** i - 1 > RunPointer^.Value;
      RunPointer := RunPointer^.Next;
    end;
    mers := neu;
  end;

  function Median(First: TValueList): single;
  var
    RunPointer: TValueList;
    i, j: word;
    med: boolean;
  begin
    RunPointer := First;
    i := 0;

    while RunPointer <> nil do
    begin
      Inc(i);
      RunPointer := RunPointer^.Next;
    end;
    med := True;

    if i mod 2 <> 0 then
      i := (i div 2)
    else
    begin
      i := (i div 2) - 1;
      med := False;
    end;

    RunPointer := First;
    for j := 1 to i do
      RunPointer := RunPointer^.Next;

    if med then
      Median := RunPointer^.Value
    else
      Median := (RunPointer^.Value + RunPointer^.Next^.Value) / 2;
  end;

  function Minimum(First: TValueList): word;
  var
    RunPointer: TValueList;
    i: word;
  begin
    RunPointer := First;
    i := maxZahl + 1;
    while RunPointer <> nil do
    begin
      if i > RunPointer^.Value then
        i := RunPointer^.Value;
      RunPointer := RunPointer^.Next;
    end;
    if i <> maxZahl + 1 then
      Minimum := i;
  end;

  function Maximum(First: TValueList): word;
  var
    RunPointer: TValueList;
    i: word;
  begin
    RunPointer := First;
    i := 0;
    while RunPointer <> nil do
    begin
      if i < RunPointer^.Value then
        i := RunPointer^.Value;
      RunPointer := RunPointer^.Next;
    end;
    Maximum := i;
  end;

  procedure creatfile(var f: tfile);
  var
    i: word;
  begin
    try
      rewrite(f);
      for i := 1 to Anzahl do
        // write(f,i)
        Write(f, random(maxZahl + 1));

      Close(f);
    except
      writeln('Fehler bei Random Zahlen Generator');
    end;
  end;

  procedure Writelist(First: TValueList);
  var
    RunPointer: TValueList;
  begin

    RunPointer := First;
    while RunPointer <> nil do
    begin
      Write(RunPointer^.Value, ' ');
      RunPointer := RunPointer^.Next;
    end;
    writeln;
  end;

  procedure DisposeList(var First: TValueList);
  var
    RunPointer: TValueList;
  begin
    while First <> nil do
    begin
      Runpointer := First;
      First := Runpointer^.Next;
      Dispose(Runpointer);
    end;
  end;

var
  A: TlistArray;
  f: Tfile;
  i: Tarrayindex;
  j: word;
  all, Element: TValueList;
begin
  randomize;
  try
    Assign(f, 'Quelle.dat');
    creatfile(f);
    new(all);
    all := nil;
    reset(f);
    while not EOF(f) do
    begin
      Read(f, j);
      Element := NewElement(j);
      SortiertINList(all, Element);
    end;
    Close(f);

  except
    writeln('Fehler beim Sortieren');
  end;

  A[alle] := all;
  A[end7] := Ende7(all);
  A[fibo] := Fibon(all);
  A[mersenne] := mers(all);

  for i := low(Tarrayindex) to high(Tarrayindex) do
  begin
    writeln('Liste ', i, ': ');
    Writelist(A[i]);
    writeln;
    if i = alle then
    begin
      writeln('Minimum :', Minimum(A[i]));
      writeln('Median  :', Median(A[i]): 4: 1);
      writeln('Maximum :', Maximum(A[i]));
    end;
    DisposeList(A[i]);
  end;
end.
