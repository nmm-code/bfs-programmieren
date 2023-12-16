{################################
# Copyright (c) 2021 Nima Mohammadimohammadi
# <http://github.com/nmm-dev/ptl_pas>
#
# ueb03 - Wurfspiel
# Spiel:
# 1. Bei Spielbeginn wird eine zufällige Position ausgewählt von 50-150m und
#    als Ziel makiert.
#
# 2. Dann wird der Spieler gefragt mit welcher Geschwindigkeit und
#    mit welchen Winkel er werfen möchte
#
# 3. Anhang der Information wird die Wurfposition des Balles ermittelt
#
# 4. Dann wird die Information dem Spieler ermittelt,
#    wie weit der Ball vom Ziel entfernt war
#
# 5. Denn wird es so oft wiederholt bis der Spieler das Ziel getroffen hat
#
# 6. Getroffen bedeutet wenn der Ball <5m Entfernung liegt
###############################}
program ueb03;

uses
  Math;

const
  PI_COUNT = 100000;
  G_COUNT = 9.81;

  
function calcPi(): double;
  var
    z, n, i: longint;
    pi: double;
  begin
    n := 1;
    z := 2;
    pi := 1;
    for i := 1 to PI_COUNT do
    begin
      pi := pi * z / n;
      n := n + 2;
      pi := pi * z / n;
      z := z + 2;
    end;
    calcPi := pi * 2;
  end;



var
  speed, angle: longint;
  ballPos: double;
  retry: char;
  tryCount, goalPos: byte;
  treffer: boolean;
begin
  randomize;

  repeat
    tryCount := 0;
    goalPos := (random(101) + 50);
    repeat
      repeat
        tryCount := tryCount + 1;
          {$I-}
        Write(#10, 'Mit welcher Geschwindigkeit werfen sie :');
          {$I+}
        readln(speed);
      until ioresult = 0;

      repeat
          {$I-}
        Write('Wie ist ihr abwurfwinkel :');
          {$I+}
        readln(angle);
      until ioresult = 0;

      ballPos := (speed * speed) * (sin(2 * ((calcPi() * angle) / 180))) / G_COUNT;

      writeln('Sie haben', ballPos: 8: 2, 'm weit geworfen');

      case (round(ballPos) - goalPos) of
        0..5, -5.. -1:
        begin
        treffer := True;
          writeln('Treffer !');
          writeln('Gratulation die haben nach ', tryCount,' Versuchen getroffen es war ', goalPos, 'm entfernt.');
          repeat
            {$I-}
            writeln('Noch ein Spiel (j/n)');
            {$I+}
            readln(retry);
          until (ioresult = 0) and (retry = 'j') or (retry = 'n');
        end;
        20..200:   writeln('Viel zu weit');
        10..19:    writeln('Zu weit');
        6..9:      writeln('Nur Noch etwas zu weit');
        -200.. -20:writeln('Viel zu kurz');
        -19.. -10: writeln('Zu kurz');
        -9.. -6:   writeln('Nur Noch etwas zu kurz');
      end;
    until treffer;
  until retry = 'n';
end.