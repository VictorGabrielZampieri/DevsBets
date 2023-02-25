unit UfrmHome;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.StdCtrls, FMX.Controls.Presentation, FMX.MultiView,
  FMX.Objects;

type
  TfrmHome = class(TForm)
    rectPrincipal: TRectangle;
    lytContainer: TLayout;
    imgLogo: TImage;
    MultiView1: TMultiView;
    StyleBook1: TStyleBook;
    btnMenu: TSpeedButton;
    Rectangle1: TRectangle;
    lstMenu: TListBox;
    lytLogo: TLayout;
    Image1: TImage;
    procedure lstMenuItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
  private
    { Private declarations }
    procedure AbrirTeam;
    procedure AbrirMatch;
    procedure AbrirBet;

    procedure RemoverTelaAnterior;
  public
    { Public declarations }
  end;

var
  frmHome: TfrmHome;

implementation

uses
  {UfraTeam,
  UfraMatch,
  UfraBet,
  }
  UUtils.Enums;

{$R *.fmx}

procedure TfrmHome.AbrirBet;
begin
  {if not(Assigned(FraBet)) then
    FraBet := TFraBet.Create(Application);

    FraBet.Align := TAlignLayout.Center;
    lytContainer.AddObject(FraBet);}
end;

procedure TfrmHome.AbrirMatch;
begin
 { if not(Assigned(FraMatch)) then
    FraMatch := TFraMatch.Create(Application);

    FraMatch.Align := TAlignLayout.Center;
    lytContainer.AddObject(FraMatch);}
end;

procedure TfrmHome.AbrirTeam;
begin
  {if not(Assigned(FraTeam)) then
    FraTeam := TFraTeam.Create(Application);

    FraTeam.Align := TAlignLayout.Center;
    lytContainer.AddObject(FraTeam);}
end;

procedure TfrmHome.lstMenuItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  Self.RemoverTelaAnterior;

case TEnumMenu(Item.Index) of
  mnuTime:
    Self.AbrirTeam;
  mnuPartidas:
    Self.AbrirMatch;
  mnuPalpites:
    Self.AbrirBet;
  mnuSair:
    Self.Close;
end;
  MultiView1.HideMaster;
end;

procedure TfrmHome.RemoverTelaAnterior;
var
  I: Integer;
begin
  for I := Pred(lytContainer.ControlsCount) downto 0 do
    if lytContainer.Controls[I].Name <> 'imgLogo' then
      lytContainer.RemoveObject(I);
end;

end.
