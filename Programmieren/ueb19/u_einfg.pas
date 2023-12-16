unit u_einfg;

interface

uses
  Classes;

type
  Ceinfg = class
  public
    {Öffentliche Deklarationen}
    function einfuegen(Text: string;i:byte): string;
  end;

const
  TVokal: array[0..4] of string = ('a', 'e', 'i', 'o', 'u');

implementation

function Ceinfg.einfuegen(Text: string;i:byte): string;
var
  j: byte;
  del:string;
begin
  if length(Text) < 51 then
  begin
    del:=TVokal[i];
    for j := 0 to 4 do
    begin
      while (pos(Tvokal[j], Text) <> 0) and (Tvokal[j] <> del) do
      begin
        insert(del, Text, pos(Tvokal[j], Text));
        Delete(Text, pos(Tvokal[j], Text), 1);
      end;

      while (pos(upcase(Tvokal[j]), Text) <> 0) and (upcase(Tvokal[j]) <> upcase(del)) do
      begin
        insert(upcase(del), Text, pos(upcase(Tvokal[j]), Text));
        Delete(Text, pos(upcase(Tvokal[j]), Text), 1);
      end;
    end;
    einfuegen := Text;
  end
  else
    einfuegen := 'max: 50 Zeichen';
end;

end.
