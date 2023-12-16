unit f_eingabe;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus;

type

  { TFEingabe }

  TFEingabe = class(TForm)
    LEArtnummer: TLabeledEdit;
    LELagerort: TLabeledEdit;
    LEBezeichner: TLabeledEdit;
    MenuOk: TMenuItem;
    MenuX: TMenuItem;
    MenuMain: TMainMenu;
    procedure MenuXClick(Sender: TObject);
    procedure MenuOkClick(Sender: TObject);

  public
    function getArtNummer: string;
    function getLagerort: string;
    function getBezeichner: string;
  end;

var
  FEingabe: TFEingabe;

implementation

{$R *.lfm}

procedure TFEingabe.MenuOkClick(Sender: TObject);
// Wird OK gedrückt dann schliesst sich das Formular
// falls eine Artikelnummer eingegeben wird dann wird mrOk ges
  function LeerLoeschen(s: string): string;
  begin
    while pos(' ', s) <> 0 do
    begin
      insert('_', s, pos(' ', s));
      Delete(s, pos(' ', s), 1);
    end;
    Result := s;
  end;

begin
  if FEingabe.Caption = 'Neuer Artikel' then
  begin
    if (LEArtnummer.Text <> '') and (LELagerort.Text <> '') and
      (LEBezeichner.Text <> '') then    // alle Felder müssen gefüllt sein
    begin
      LEArtnummer.Text := LeerLoeschen(LEArtnummer.Text);
      LELagerort.Text := LeerLoeschen(LELagerort.Text);
      LEBezeichner.Text := LeerLoeschen(LEBezeichner.Text);
      ModalResult := mrOk;
    end
    else
      ShowMessage('Bitte alle Felder ausfüllen');
  end
  else
  if (LEArtnummer.Text <> '') then
    ModalResult := mrOk
  else
    ShowMessage('Bitte Artikelnummer eingeben');
end;

procedure TFEingabe.MenuXClick(Sender: TObject);
// Wird X gedrückt dann schliesst sich das Formular
begin
  ModalResult := mrCancel;
  LEArtnummer.Text := '';
  LELagerort.Text := '';
  LEBezeichner.Text := '';
end;

function TFEingabe.getArtNummer: string;
  // Getter Methode
begin
  Result := LEArtnummer.Text;
  LEArtnummer.Text := ''; //Um das Feld leeren für den Nächsten Aufruf
end;

function TFEingabe.getLagerort: string;
  // Getter Methode
begin
  Result := LELagerort.Text;
  LELagerort.Text := '';  //Um das Feld leeren für den Nächsten Aufruf
end;

function TFEingabe.getBezeichner: string;
  // Getter Methode
begin
  Result := LEBezeichner.Text;
  LEBezeichner.Text := ''; //Um das Feld leeren für den Nächsten Aufruf
end;

end.
