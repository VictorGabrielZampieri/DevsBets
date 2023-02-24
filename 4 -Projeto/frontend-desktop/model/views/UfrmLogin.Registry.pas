unit UfrmLogin.Registry;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts, FMX.Edit;

type
  TfrmLoginRegistry = class(TForm)
    rectPrincipal: TRectangle;
    lytPrincipal: TLayout;
    imgLogo: TImage;
    lytBotoes: TLayout;
    rectNome: TRectangle;
    rectLogin: TRectangle;
    rectVoltar: TRectangle;
    Label3: TLabel;
    rectPassword: TRectangle;
    rectRegistrar: TRectangle;
    Label2: TLabel;
    edtLogin: TEdit;
    edtNome: TEdit;
    edtPassword: TEdit;
    procedure rectVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rectRegistrarClick(Sender: TObject);
  private
    { Private declarations }
    procedure VoltarTela;
    procedure Registrar;
  public
    { Public declarations }
  end;

var
  frmLoginRegistry: TfrmLoginRegistry;

implementation

{$R *.fmx}

uses
  UfrmLogin,
  UService.User,
  UEntity.Users, UService.intf
  ;


procedure TfrmLoginRegistry.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmLoginRegistry := nil;
end;

procedure TfrmLoginRegistry.rectRegistrarClick(Sender: TObject);
begin
  Self.Registrar;
end;

procedure TfrmLoginRegistry.rectVoltarClick(Sender: TObject);
begin
   Self.VoltarTela;
end;

procedure TfrmLoginRegistry.Registrar;
var
  xServiceUser: IService;
begin
  if (Trim(edtNome.Text) = EmptyStr) then
    raise Exception.Create('Informe o Nome');

  if (Trim(edtLogin.Text) = EmptyStr) then
    raise Exception.Create('Informe o Login');

  if (Trim(edtPassword.Text) = EmptyStr) then
    raise Exception.Create('Informe a Senha');

    xServiceUser := TServiceUser.Create(TUser.Create(Trim(edtNome.Text), Trim(edtLogin.Text), Trim(edtPassword.Text)));

    try
      xServiceUser.Registrar;
      ShowMessage('Usuário registrado com sucesso');
      Self.VoltarTela;
    except on E: Exception do
      raise Exception.Create('Error: '+ E.Message);
    end;
end;

procedure TfrmLoginRegistry.VoltarTela;
begin
  if not(Assigned(frmLogin)) then
    frmLogin := TfrmLogin.Create(Application);

    frmLogin.Show;
    Application.MainForm := frmLogin;
    Self.Close;
end;

end.
