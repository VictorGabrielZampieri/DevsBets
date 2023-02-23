unit UfrmLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfrmLogin = class(TForm)
    rectPrincipal: TRectangle;
    lytBotoes: TLayout;
    lytPrincipal: TLayout;
    imgLogo: TImage;
    rectLogin: TRectangle;
    Label1: TLabel;
    restRegistrar: TRectangle;
    rectSair: TRectangle;
    Label2: TLabel;
    Label3: TLabel;
    procedure rectSairClick(Sender: TObject);
    procedure restRegistrarClick(Sender: TObject);
    procedure rectLoginClick(Sender: TObject);
  private
    { Private declarations }
    procedure AbrirLoginAuthentication;
    procedure AbrirLoginRegistry;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  UfrmLogin.Registry, UfrmLogin.Authetication;

{$R *.fmx}

procedure TfrmLogin.AbrirLoginAuthentication;
begin
  if not(Assigned(frmLoginAuthentication)) then
    frmLoginAuthentication := TfrmLoginAuthentication.Create(Application);

  frmLoginAuthentication.Show;
  Application.MainForm := frmLoginAuthentication;
end;

procedure TfrmLogin.AbrirLoginRegistry;
begin
  if not(Assigned(frmLoginRegistry)) then
    frmLoginRegistry := TfrmLoginRegistry.Create(Application);

  frmLoginRegistry.Show;
  Application.MainForm := frmLoginRegistry;
end;

procedure TfrmLogin.rectLoginClick(Sender: TObject);
begin
   Self.AbrirLoginAuthentication;
end;

procedure TfrmLogin.rectSairClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmLogin.restRegistrarClick(Sender: TObject);
begin
  Self.AbrirLoginRegistry;
end;

end.
