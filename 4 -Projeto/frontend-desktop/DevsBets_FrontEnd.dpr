program DevsBets_FrontEnd;

uses
  System.StartUpCopy,
  FMX.Forms,
  UfrmLogin in 'model\views\UfrmLogin.pas' {frmLogin},
  UfrmLogin.Registry in 'model\views\UfrmLogin.Registry.pas' {frmLoginRegistry},
  UfrmLogin.Authetication in 'model\views\UfrmLogin.Authetication.pas' {frmLoginAuthentication},
  UEntity.Bets in '..\Backend\Model\entities\UEntity.Bets.pas',
  UEntity.Logins in '..\Backend\Model\entities\UEntity.Logins.pas',
  UEntity.Matchs in '..\Backend\Model\entities\UEntity.Matchs.pas',
  UEntity.Teams in '..\Backend\Model\entities\UEntity.Teams.pas',
  UEntity.Users in '..\Backend\Model\entities\UEntity.Users.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
