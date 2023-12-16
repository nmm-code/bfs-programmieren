unit f_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, u_einfg;

type
  { TFMain }

  TFMain = class(TForm)
    BtnOk: TButton;
    BtnEinstellungs: TButton;
    Abbruch: TButton;
    Ergebnis: TEdit;
    Ihintergrund: TImage;
    StringFeld: TEdit;
    procedure AbbruchClick(Sender: TObject);
    procedure BtnEinstellungsClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure StringFeldClick(Sender: TObject);
  private {Private Deklarationen}
  public {Öffentliche Deklarationen}
  end;

var
  FMain: TFMain;
  instanz: Ceinfg;

implementation

{$R *.lfm}
uses
  fset;

procedure TFMain.StringFeldClick(Sender: TObject);
begin
  StringFeld.Text := '';
end;

procedure TFMain.BtnEinstellungsClick(Sender: TObject);
begin
  FSettings.ShowModal;
end;

procedure TFMain.AbbruchClick(Sender: TObject);
begin
  Close;
end;

procedure TFMain.BtnOkClick(Sender: TObject);
begin
  Ergebnis.Text := instanz.einfuegen(StringFeld.Text,FSettings.Index);
end;

end.
