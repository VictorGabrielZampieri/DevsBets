unit UEntity.Bets;

interface

uses
  UEntity.Users, UEntity.Matchs, GBSwagger.Model.Attributes;

type
  TBet = class
  private
    FId: Integer;
    FUser: TUser;
    FMatch: TMatch;
    FResultTeamA: Byte;
    FResultTeamB: Byte;
    FStatus: Byte;
    function GetId: Integer;
    function GetPartida: TMatch;
    function GetResultadoTimeA: Byte;
    function GetResultadoTimeB: Byte;
    function GetStatus: Byte;
    function GetUsuario: TUser;

    procedure SetId(const Value: Integer);
    procedure SetPartida(const Value: TMatch);
    procedure SetResultadoTimeA(const Value: Byte);
    procedure SetResultadoTimeB(const Value: Byte);
    procedure SetStatus(const Value: Byte);
    procedure SetUsuario(const Value: TUser);
  public
    [SwagProp('Palpite Id', True)]
    property Id: Integer read GetId write SetId;

    [SwagProp('Palpite Usu�rio', True)]
    property Usuario: TUser read GetUsuario write SetUsuario;

    [SwagProp('Palpite Partida', True)]
    property Partida: TMatch read GetPartida write SetPartida;

    [SwagProp('Palpite Resultado Time A', True)]
    property ResultadoTimeA: Byte read GetResultadoTimeA
      write SetResultadoTimeA;

    [SwagProp('Palpite Resultado Time B', True)]
    property ResultadoTimeB: Byte read GetResultadoTimeB
      write SetResultadoTimeB;

    [SwagProp('Palpite Status', True)]
    property Status: Byte read GetStatus write SetStatus;

  end;

implementation

{ TBet }

function TBet.GetId: Integer;
begin
  Result := FId;
end;

function TBet.GetPartida: TMatch;
begin
  Result := FMatch;
end;

function TBet.GetResultadoTimeA: Byte;
begin
  Result := FResultTeamA;
end;

function TBet.GetResultadoTimeB: Byte;
begin
  Result := FResultTeamB;
end;

function TBet.GetStatus: Byte;
begin
  Result := FStatus;
end;

function TBet.GetUsuario: TUser;
begin
  Result := FUser;
end;

procedure TBet.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TBet.SetPartida(const Value: TMatch);
begin
  FMatch := Value;
end;

procedure TBet.SetResultadoTimeA(const Value: Byte);
begin
  FResultTeamA := Value;
end;

procedure TBet.SetResultadoTimeB(const Value: Byte);
begin
  FResultTeamB := Value;
end;

procedure TBet.SetStatus(const Value: Byte);
begin
  FStatus := Value;
end;

procedure TBet.SetUsuario(const Value: TUser);
begin
  FUser := Value;
end;

end.
