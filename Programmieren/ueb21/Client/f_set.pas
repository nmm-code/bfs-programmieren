unit f_set;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Menus;

type

  { TFSet }

  TFSet = class(TForm)
    TE1: TEdit;
    TE2: TEdit;
    TE3: TEdit;
    TE4: TEdit;
    TEPort: TEdit;
    LIP: TLabel;
    LPort: TLabel;
    MainMenu: TMainMenu;
    MenuOk: TMenuItem;
    MenuX: TMenuItem;
    procedure MenuOkClick(Sender: TObject);
    procedure MenuXClick(Sender: TObject);

  public
    procedure SetFeld(a1, a2, a3, a4: byte; port: word);
    function GetFeld1: byte;
    function GetFeld2: byte;
    function GetFeld3: byte;
    function GetFeld4: byte;
    function GetPort: word;
  end;

var
  FSet: TFSet;

implementation

{$R *.lfm}

function TFSet.GetFeld1: byte;
  // Getter Methode
begin
  Result := StrToInt(TE1.Text);
end;

function TFSet.GetFeld2: byte;
  // Getter Methode
begin
  Result := StrToInt(TE2.Text);
end;

function TFSet.GetFeld3: byte;
  // Getter Methode
begin
  Result := StrToInt(TE3.Text);
end;

function TFSet.GetFeld4: byte;
  // Getter Methode
begin
  Result := StrToInt(TE4.Text);
end;

function TFSet.GetPort: word;
  // Getter Methode
begin
  Result := StrToInt(TEPort.Text);
end;

procedure TFSet.SetFeld(a1, a2, a3, a4: byte; port: word);
// Setter Methode um die TEdit Felder zu füllen für den Aufrufer
begin
  TE1.Text := IntToStr(a1);
  TE2.Text := IntToStr(a2);
  TE3.Text := IntToStr(a3);
  TE4.Text := IntToStr(a4);
  TEPort.Text := IntToStr(Port);
end;

procedure TFSet.MenuOkClick(Sender: TObject);
// Wenn der ok Button gedrückt wird
// wird das Formular geschlossen
begin
  ModalResult := mrOk;
end;

procedure TFSet.MenuXClick(Sender: TObject);
// Wenn der X Button gedrückt wird
// wird das Formular geschlossen
begin
  ModalResult := mrCancel;
end;

end.
