unit UfraBets;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Controls.Presentation, FMX.ListView, FMX.Objects, FMX.Layouts, UEntity.Bets;

type
  TfraBet = class(TFrame)
    rectPrincipal: TRectangle;
    lytPrincipal: TLayout;
    imgLogo: TImage;
    lytPartidas: TLayout;
    lstPartidas: TListView;
    rectToolbar: TRectangle;
    rectExcluir: TRectangle;
    Label1: TLabel;
    rectNovo: TRectangle;
    Label2: TLabel;
    procedure rectNovoClick(Sender: TObject);
    procedure rectExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarRegistros;
    procedure AbrirBetRegistry;
    procedure PrepararlistView(aBet: TBet);
    procedure ExcluirRegistro;
  public
    { Public declarations }
    constructor Create(aOwner: TComponent); override;
  end;

var
  fraBet: TfraBet;

implementation

{$R *.fmx}

uses
  UService.intf, UService.Bet, UEntity.Matchs, UfraBet.Registry, UService.User.Authenticated;


{ TfraBet }

procedure TfraBet.AbrirBetRegistry;
begin
  if not Assigned(fraBetRegistry) then
    fraBetRegistry := TfraBetRegistry.Create(Application);

  fraBetRegistry.Align := TAlignLayout.Center;

  Self.Parent.AddObject(fraBetRegistry);
  FreeAndNil(fraBet);
end;

procedure TfraBet.CarregarRegistros;
var
  xServiceBet: IService;
  xBet: TBet;
begin
  lstPartidas.Items.Clear;

  xServiceBet := TServiceBet.Create;
  xServiceBet.Listar;
  for xBet in TServiceBet(xServiceBet).Bets do
    Self.PrepararlistView(xBet);

end;

constructor TfraBet.Create(aOwner: TComponent);
begin
  Inherited Create(aOwner);
    Self.CarregarRegistros;
end;

procedure TfraBet.ExcluirRegistro;
var
  xServiceBet : IService;
  xBet : TBet;
  xItem: TListViewItem;
  xUserAuthenticated: TUserAuthenticated;
begin
  if lstPartidas.ItemIndex = -1 then
    Exit;

  xItem := lstPartidas.Items[lstPartidas.ItemIndex];

  xUserAuthenticated := TUserAuthenticated.GetInstance;
  if xItem.TagString <> xUserAuthenticated.User.Id.ToString then
    raise Exception.Create('Não é possivel excluir o palpite de outro usuario');

  xBet := TBet.Create(xItem.Tag);

  xServiceBet := TServiceBet.Create(xBet);
  try
    xServiceBet.Excluir;
    ShowMessage('Registro Excluido.');
  finally
    Self.CarregarRegistros;
  end;
end;

procedure TfraBet.PrepararlistView(aBet: TBet);
var
  xItem : TListViewItem;
  xMatch: TMatch;
begin
  xItem           := lstPartidas.Items.Add;
  xItem.Tag       := aBet.Id;
  xItem.TagString := aBet.User.Id.ToString;
  xMatch          := aBet.Match;

   TListItemText(xItem.Objects.FindDrawable('txtUsuario')).Text := aBet.User.Login;
   TListItemText(xItem.Objects.FindDrawable('txtHora')).Text := TimeToStr(xMatch.Hour);
   TListItemText(xItem.Objects.FindDrawable('txtData')).Text := DateToStr(xMatch.Date);
   TListItemText(xItem.Objects.FindDrawable('txtTimeA')).Text := xMatch.TeamA.Name;
   TListItemText(xItem.Objects.FindDrawable('txtTimeB')).Text := xMatch.TeamB.Name;
   TListItemText(xItem.Objects.FindDrawable('txtResultadoTimeA')).Text := aBet.ResultTeamA.ToString;
   TListItemText(xItem.Objects.FindDrawable('txtResultadoTimeB')).Text := aBet.ResultTeamB.ToString;
end;

procedure TfraBet.rectExcluirClick(Sender: TObject);
begin
  Self.ExcluirRegistro;
end;

procedure TfraBet.rectNovoClick(Sender: TObject);
begin
  Self.AbrirBetRegistry;
end;

end.
