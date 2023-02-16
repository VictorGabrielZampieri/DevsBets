unit UEntity.Matchs;

interface

uses
  UEntity.Teams, GBSwagger.Model.Attributes;

type
  TMatch = class
  private
    FId: Integer;
    FDate: TDate;
    FHour: TTime;
    FTeamA: TTeam;
    FTeamB: TTeam;
    FResultTeamA: Byte;
    FResultTeamB: Byte;
    FStatus: Byte;
    function GetData: TDate;
    function GetHora: TTime;
    function GetId: Integer;
    function GetResultadoTimeA: Byte;
    function GetResultadoTimeB: Byte;
    function GetStatus: Byte;
    function GetTimeA: TTeam;
    function GetTimeB: TTeam;

    procedure SetData(const Value: TDate);
    procedure SetHora(const Value: TTime);
    procedure SetId(const Value: Integer);
    procedure SetResultadoTimeA(const Value: Byte);
    procedure SetResultadoTimeB(const Value: Byte);
    procedure SetStatus(const Value: Byte);
    procedure SetTimeA(const Value: TTeam);
    procedure SetTimeB(const Value: TTeam);
  public

    [SwagProp('Partida Id', True)]
    property Id: Integer read GetId write SetId;

    [SwagProp('Partida Data', True)]
    property Data: TDate read GetData write SetData;

    [SwagProp('Partida Hora', True)]
    property Hora: TTime read GetHora write SetHora;

    [SwagProp('Partida Time A', True)]
    property TimeA: TTeam read GetTimeA write SetTimeA;

    [SwagProp('Partida Time b', True)]
    property TimeB: TTeam read GetTimeB write SetTimeB;

    [SwagProp('Partida Resultado Time A', True)]
    property ResultadoTimeA: Byte read GetResultadoTimeA
      write SetResultadoTimeA;

    [SwagProp('Partida Resultado Time B', True)]
    property ResultadoTimeB: Byte read GetResultadoTimeB
      write SetResultadoTimeB;

    [SwagProp('Partida Status', True)]
    property Status: Byte read GetStatus write SetStatus;
  end;

implementation

{ TMatch }

function TMatch.GetData: TDate;
begin
  Result := FDate;
end;

function TMatch.GetHora: TTime;
begin
  Result := FHour;
end;

function TMatch.GetId: Integer;
begin
  Result := FId;
end;

function TMatch.GetResultadoTimeA: Byte;
begin
  Result := FResultTeamA;
end;

function TMatch.GetResultadoTimeB: Byte;
begin
  Result := FResultTeamB;
end;

function TMatch.GetStatus: Byte;
begin
  Result := FStatus;
end;

function TMatch.GetTimeA: TTeam;
begin
  Result := FTeamA;
end;

function TMatch.GetTimeB: TTeam;
begin
  Result := FTeamB;
end;

procedure TMatch.SetData(const Value: TDate);
begin
  FDate := Value;
end;

procedure TMatch.SetHora(const Value: TTime);
begin
  FHour := Value;
end;

procedure TMatch.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TMatch.SetResultadoTimeA(const Value: Byte);
begin
  FResultTeamA := Value;
end;

procedure TMatch.SetResultadoTimeB(const Value: Byte);
begin
  FResultTeamB := Value;
end;

procedure TMatch.SetStatus(const Value: Byte);
begin
  FStatus := Value;
end;

procedure TMatch.SetTimeA(const Value: TTeam);
begin
  FTeamA := Value;
end;

procedure TMatch.SetTimeB(const Value: TTeam);
begin
  FTeamB := Value;
end;

end.
