unit f_eingabe;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  Tstring30 = string[30];

  { TFEingabe }

  TFEingabe = class(TForm)
    BtnOk: TButton;
    BtnX: TButton;
    EdArtNummer: TEdit;
    EdLagerort: TEdit;
    EdBezeichnung: TEdit;
    LBezeichnung: TLabel;
    LLagerort: TLabel;
    LArtikelnummer: TLabel;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnXClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    btnclose: boolean;
  public
    function GetArt: Tstring30;
    function GetLagerort: Tstring30;
    function GetBezeichnung: Tstring30;
    property schliessen: boolean read btnclose;
  end;

var
  FEingabe: TFEingabe;

implementation

{$R *.lfm}

function TFEingabe.GetArt: Tstring30;
begin
  GetArt := EdArtNummer.Text;
  EdArtNummer.Text := '';
end;

function TFEingabe.GetLagerort: Tstring30;
begin
  GetLagerort := EdLagerort.Text;
  EdLagerort.Text := '';
end;

function TFEingabe.GetBezeichnung: Tstring30;
begin
  GetBezeichnung := EdBezeichnung.Text;
  EdBezeichnung.Text := '';
end;

procedure TFEingabe.FormCreate(Sender: TObject);
begin
  btnclose := False;
end;

procedure TFEingabe.BtnOkClick(Sender: TObject);
begin
  if EdArtNummer.Text <> '' then
    Close
  else
    ShowMessage('Keine Artikelnummer!');
end;

procedure TFEingabe.BtnXClick(Sender: TObject);
begin
  btnclose := True;
  Close;
end;

end.
