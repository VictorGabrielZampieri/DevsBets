unit UfraTeams.Registry;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects, FMX.Layouts;

type
  TfraTeamsRegistry = class(TFrame)
    rectPrincipal: TRectangle;
    lytPrincipal: TLayout;
    imgLogo: TImage;
    lytBotoes: TLayout;
    rectData: TRectangle;
    edtNome: TEdit;
    rectVoltar: TRectangle;
    Label3: TLabel;
    rectSalvar: TRectangle;
    Label1: TLabel;
    procedure rectVoltarClick(Sender: TObject);
    procedure rectSalvarClick(Sender: TObject);
  private
    { Private declarations }
    procedure VoltarTela;
    procedure Registrar;
  public
    { Public declarations }
  end;

var
  fraTeamRegistry : TfraTeamsRegistry;

implementation

{$R *.fmx}

uses
  UfraTeams, UEntity.Teams, UService.intf, UService.Team;

{ TfraTeamsRegistry }

procedure TfraTeamsRegistry.rectSalvarClick(Sender: TObject);
begin
  Self.Registrar;
end;

procedure TfraTeamsRegistry.rectVoltarClick(Sender: TObject);
begin
  Self.VoltarTela;
end;

procedure TfraTeamsRegistry.Registrar;
var
  xServiceTeam : IService;
begin
  if Trim(edtNome.Text) = EmptyStr then
    raise Exception.Create('Informe o nome do time.');

  xServiceTeam := TServiceTeam.Create(TTeam.Create(Trim(edtNome.Text)));

  xServiceTeam.Registrar;
  Self.VoltarTela;
end;

procedure TfraTeamsRegistry.VoltarTela;
begin
   if not Assigned(fraTeam) then
    fraTeam := TfraTeams.Create(Application);

  fraTeam.Align := TAlignLayout.Center;

  Self.Parent.AddObject(fraTeam);
  FreeAndNil(fraTeamRegistry);
end;

end.
