program ueb19;

{$mode objfpc}{$H+}

uses
 Interfaces,Forms, f_main, fSet, u_einfg;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TSettings, FSettings);
  Application.Run;
end.

