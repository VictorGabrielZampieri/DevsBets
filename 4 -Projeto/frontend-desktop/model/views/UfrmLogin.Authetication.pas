unit UfrmLogin.Authetication;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects, FMX.Layouts;

type
  TfrmLoginAuthentication = class(TForm)
    rectPrincipal: TRectangle;
    lytPrincipal: TLayout;
    imgLogo: TImage;
    lytBotoes: TLayout;
    rectLogin: TRectangle;
    edtLogin: TEdit;
    rectPassword: TRectangle;
    edtPassword: TEdit;
    rectEntrar: TRectangle;
    Label2: TLabel;
    rectVoltar: TRectangle;
    Label3: TLabel;
    procedure rectVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rectEntrarClick(Sender: TObject);
  private
    { Private declarations }
    procedure VoltarTela;
    procedure AbrirHome;
    procedure Logar;
  public
    { Public declarations }
  end;

var
  frmLoginAuthentication: TfrmLoginAuthentication;

implementation

{$R *.fmx}

uses
  UfrmLogin,
  UfrmHome,
  UEntity.logins,
  UService.Intf,
  UService.Login;

procedure TfrmLoginAuthentication.AbrirHome;
begin
   if not(Assigned(frmHome)) then
    frmHome := TfrmHome.Create(Application);

    frmHome.Show;
    Application.MainForm := frmHome;
    Self.Close;
end;

procedure TfrmLoginAuthentication.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmLoginAuthentication := nil;
end;

procedure TfrmLoginAuthentication.Logar;
var
  xServiceLogin: IService;
begin
  if (Trim(edtLogin.Text) = EmptyStr) then
    raise Exception.Create('Informe o Login');

  if (Trim(edtPassword.Text) = EmptyStr) then
    raise Exception.Create('Informe a Senha');

    xServiceLogin := TServiceLogin.Create(TLogin.Create(Trim(edtLogin.Text), Trim(edtPassword.Text)));

    try
      TServiceLogin(xServiceLogin).Autenticar;
      Self.AbrirHome;
    except on E: Exception do
      raise Exception.Create('Login: '+ E.Message);
    end;
end;

procedure TfrmLoginAuthentication.rectEntrarClick(Sender: TObject);
begin
  Self.Logar;
end;

procedure TfrmLoginAuthentication.rectVoltarClick(Sender: TObject);
begin
 Self.VoltarTela;
end;

procedure TfrmLoginAuthentication.VoltarTela;
begin
  if not(Assigned(frmLogin)) then
    frmLogin := TfrmLogin.Create(Application);

    frmLogin.Show;
    Application.MainForm := frmLogin;
    Self.Close;
end;

end.
