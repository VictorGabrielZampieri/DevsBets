unit UEntity.Users;

interface

uses
  System.JSON,
  GBSwagger.Model.Attributes;

type
  TUser = class
  private
    FId: Integer;
    FName: String;
    FStatus: Byte;
    FLogin: String;
    FPassword: String;
    FJSON: TJSONObject;

    function GetId: Integer;
    function GetLogin: String;
    function GetName: String;
    function GetSenha: String;
    function GetStatus: Byte;

    procedure SetId(const Value: Integer);
    procedure SetLogin(const Value: String);
    procedure SetName(const Value: String);
    procedure SetSenha(const Value: String);
    procedure SetStatus(const Value: Byte);
    function GetJSON: TJSONObject;
  public
    constructor Create(const aName, aLogin, aPassword: String);
    destructor Destroy; Override;

    [SwagProp('Usu�rio Id', True)]
    property Id: Integer read GetId write SetId;

    [SwagProp('Usu�rio Nome', True)]
    property Name: String read GetName write SetName;

    [SwagProp('Usu�rio Status', True)]
    property Status: Byte read GetStatus write SetStatus;

    [SwagProp('Usu�rio Login', True)]
    property Login: String read GetLogin write SetLogin;

    [SwagProp('Usu�rio Senha', True)]
    property Senha: String read GetSenha write SetSenha;

    property JSON: TJSONObject read GetJSON;
  end;

implementation

{ TUser }

constructor TUser.Create(const aName, aLogin, aPassword: String);
begin
  FJSON := TJSONObject.Create;

  FName := aName;
  FLogin := aLogin;
  FPassword := aPassword;
end;

destructor TUser.Destroy;
begin
  if (Assigned(FJSON)) then
    FJSON.Free;

  inherited;
end;

function TUser.GetId: Integer;
begin
  Result := FId;
end;

function TUser.GetJSON: TJSONObject;
begin
  FJSON.AddPair('name', FName);
  FJSON.AddPair('login', FLogin);
  FJSON.AddPair('password', FPassword);

  Result := FJSON;
end;

function TUser.GetLogin: String;
begin
  Result := FLogin;
end;

function TUser.GetName: String;
begin
  Result := FName;
end;

function TUser.GetSenha: String;
begin
  Result := FPassword;
end;

function TUser.GetStatus: Byte;
begin
  Result := FStatus;
end;

procedure TUser.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TUser.SetLogin(const Value: String);
begin
  FLogin := Value;
end;

procedure TUser.SetName(const Value: String);
begin
  FName := Value;
end;

procedure TUser.SetSenha(const Value: String);
begin
  FPassword := Value;
end;

procedure TUser.SetStatus(const Value: Byte);
begin
  FStatus := Value;
end;

end.
