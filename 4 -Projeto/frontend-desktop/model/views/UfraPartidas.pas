unit UfraPartidas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Controls.Presentation, FMX.ListView, FMX.Objects, FMX.Layouts, UEntity.Matchs;

type
  TfraMatch = class(TFrame)
    rectPrincipal: TRectangle;
    lytPrincipal: TLayout;
    imgLogo: TImage;
    lstPartidas: TListView;
    rectToolbar: TRectangle;
    rectExcluir: TRectangle;
    Label1: TLabel;
    rectNovo: TRectangle;
    Label2: TLabel;
    lytPartidas: TLayout;
    procedure rectNovoClick(Sender: TObject);
    procedure rectExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarRegistros;
    procedure AbrirMatchRegistry;
    procedure PrepararListView(aMatch: TMatch);
    procedure ExcluirRegistros;
  public
    { Public declarations }
    constructor Create(aOwner: TComponent); override;
  end;

var
  fraMatch : TfraMatch;

implementation

{$R *.fmx}

{ TfraMatch }

uses
  UfraMatch.Registry, UService.intf, UService.Match;

procedure TfraMatch.AbrirMatchRegistry;
begin
  if not Assigned(fraMatchRegistry) then
    fraMatchRegistry := TfraMatchRegistry.Create(Application);

  fraMatchRegistry.Align := TAlignLayout.Center;

  Self.Parent.AddObject(fraMatchRegistry);
  FreeAndNil(fraMatch);
end;

procedure TfraMatch.CarregarRegistros;
var
  xServiceMatch: IService;
  xMatch: TMatch;
begin
  lstPartidas.Items.Clear;

  xServiceMatch := TServiceMatch.Create;
  xServiceMatch.Listar;
  for xMatch in TServiceMatch(xServiceMatch).Matchs do
    Self.PrepararlistView(xMatch);
end;

constructor TfraMatch.Create(aOwner: TComponent);
begin
   Inherited Create(aOwner);
    Self.CarregarRegistros;
end;

procedure TfraMatch.ExcluirRegistros;
var
  xServiceMatch : IService;
  xMatch : TMatch;
  xItem: TListViewItem;
begin
  if lstPartidas.ItemIndex = -1 then
    Exit;

  xItem := lstPartidas.Items[lstPartidas.ItemIndex];
  xMatch := TMatch.Create(xItem.Tag);

  xServiceMatch := TServiceMatch.Create(xMatch);
  try
    xServiceMatch.Excluir;
    ShowMessage('Registro Excluido.');
  finally
    Self.CarregarRegistros;
  end;
end;

procedure TfraMatch.PrepararListView(aMatch: TMatch);
var
  xItem : TListViewItem;
begin
  xItem           := lstPartidas.Items.Add;
  xItem.Tag       := aMatch.Id;

   TListItemText(xItem.Objects.FindDrawable('txtHora')).Text := TimeToStr(aMatch.Hour);
   TListItemText(xItem.Objects.FindDrawable('txtData')).Text := DateToStr(aMatch.Date);
   TListItemText(xItem.Objects.FindDrawable('txtTimeA')).Text := aMatch.TeamA.Name;
   TListItemText(xItem.Objects.FindDrawable('txtTimeB')).Text := aMatch.TeamB.Name;
   TListItemText(xItem.Objects.FindDrawable('txtResultadoTimeA')).Text := aMatch.ResultTeamA.ToString;
   TListItemText(xItem.Objects.FindDrawable('txtResultadoTimeB')).Text := aMatch.ResultTeamB.ToString;

end;

procedure TfraMatch.rectExcluirClick(Sender: TObject);
begin
  Self.ExcluirRegistros;
end;

procedure TfraMatch.rectNovoClick(Sender: TObject);
begin
  Self.AbrirMatchRegistry;
end;

end.
