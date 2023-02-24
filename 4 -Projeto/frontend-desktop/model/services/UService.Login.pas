unit UService.Login;

interface

uses
  UEntity.Logins, UService.Base;

type
  TServiceLogin = class(TServiceBase)
  private
    FLogin: TLogin;

    procedure SalvarToken;
    procedure UsuarioAutenticado;
  public
    constructor Create(aLogin: TLogin);
    destructor Destroy; override;

    procedure Registrar; override;
    procedure Listar; override;
    procedure Excluir; override;

    function ObterRegistro(const aId: Integer): TObject; override;
    procedure Autenticar;
  end;

implementation

{ TServiceLogin }

uses
  REST.Authenticator.Basic, REST.Types, System.JSON, UUtils.Constants, System.SysUtils,
  System.Classes, UService.intf, UService.User, UEntity.Users, UService.User.Authenticated, JOSE.Core.JWT, JOSE.Core.Builder;

procedure TServiceLogin.Autenticar;
var
  xJSONBody: TJSONObject;
  xHTTPBasicAut : THTTPBasicAuthenticator;
begin
  xJSONBody     := TJSONObject.Create;
  xHTTPBasicAut := THTTPBasicAuthenticator.Create(FLogin.Login, FLogin.Password);

  try
    try
      FRESTClient.Authenticator := xHTTPBasicAut;
      FRESTClient.BaseURL       := URL_BASE_LOGIN;

      xJSONBody.AddPair('login', FLogin.Login);
      xJSONBody.AddPair('password', FLogin.Password);

      FRESTRequest.Method := rmPOST;
      FRESTRequest.Params.AddBody(xJSONBody);
      FRESTRequest.Execute;

       case FRESTResponse.StatusCode of
          API_SUCESSO:
          begin  
              FLogin.Token  := FRESTResponse.Content;
              Self.SalvarToken;
              Self.UsuarioAutenticado;
          end;
          API_NAO_AUTORIZADO:
            raise Exception.Create('Usuario n�o autorizado.');
          else
            raise Exception.Create('Erro n�o catalogado.');
       end;
    except on E: Exception do
      raise Exception.Create(e.Message);
    end;
  finally
    FreeAndNil(xJSONBody);
    FreeAndNil(xHTTPBasicAut);
  end;

end;

constructor TServiceLogin.Create(aLogin: TLogin);
begin
  inherited Create;

  FLogin := aLogin;
end;

destructor TServiceLogin.Destroy;
begin
  FreeAndNil(FLogin);
  inherited;
end;

procedure TServiceLogin.Excluir;
begin
  inherited;
  //Sem Implementacao no momento
end;

procedure TServiceLogin.Listar;
begin
  inherited;
  //Sem Implementacao no momento
end;

function TServiceLogin.ObterRegistro(const aId: Integer): TObject;
begin
  //Sem Implementacao no momento
end;

procedure TServiceLogin.Registrar;
begin
  inherited;
  //Sem Implementacao no momento
end;

procedure TServiceLogin.SalvarToken;
var
  xStringList : TStringList;
begin
  xStringList := TStringList.Create;
  try
    xStringList.Add(FLogin.Token);
    xStringList.SaveToFile('Token.jwt');
  finally
    xStringList.Free;
  end;

end;

procedure TServiceLogin.UsuarioAutenticado;
var
  xServiceUser : IService;
  xJWT: TJWT;
  xIdUser: Integer;
  xUserAuthenticated: TUserAuthenticated;
begin
  xJWT := TJOSE.DeserializeCompact('KeyDevsBets', FLogin.Token);

  try
    if not(xJWT.Claims.JSON.TryGetValue<Integer>('id', xIdUser)) then
      raise Exception.Create('N�o foi possivel registrar autentica��o');

    xServiceUser := TServiceUser.Create;

    xUserAuthenticated      := TUserAuthenticated.GetInstance;
    xUserAuthenticated.User := TUser(xServiceUser.ObterRegistro(xIdUser));
    
  finally
    FreeAndNil(xJWT)
  end;
end;

end.
