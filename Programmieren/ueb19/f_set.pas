unit fSet;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TSettings }

  TSettings = class(TForm)
    BtnOk: TButton;
    BtnAbbruch: TButton;
    Vokale: TRadioGroup;
    procedure BtnAbbruchClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    {Private Deklarationen}
    safe: byte;
    function GetIndex: byte;
  public
    {Öffentliche Deklarationen}
    property Index: byte read GetIndex;
  end;

var
  FSettings: TSettings;

implementation

{$R *.lfm}
{ TSettings }

function TSettings.GetIndex: byte;
begin
  GetIndex := Vokale.ItemIndex;
end;

procedure TSettings.BtnOkClick(Sender: TObject);
begin
  Close;
  safe := Vokale.ItemIndex;
end;

procedure TSettings.FormCreate(Sender: TObject);
begin
  FSettings.Left := FSettings.Left + 275;
end;

procedure TSettings.BtnAbbruchClick(Sender: TObject);
begin
  Vokale.ItemIndex := safe;
  Close;
end;

end.
