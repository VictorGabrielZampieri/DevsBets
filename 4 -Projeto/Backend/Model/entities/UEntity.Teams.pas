unit UEntity.Teams;

interface

uses
  JSON, GBSwagger.Model.Attributes;

type
  TTeam = class
  private
    FId: Integer;
    FName: String;
    FJSON: TJSONObject;
    function GetId: Integer;
    function GetJSON: TJSONObject;
    function GetName: String;

    procedure SetId(const Value: Integer);
    procedure SetName(const Value: String);
  public
    constructor Create(const aName: String; const aId: Integer = 0);
    destructor Destroy; override;

    [SwagProp('Time Id', True)]
    property Id: Integer read GetId write SetId;

    [SwagProp('Time Name', True)]
    property Name: String read GetName write SetName;

    property JSON: TJSONObject read GetJSON;
  end;

implementation

uses
  System.SysUtils;

{ TTeam }

constructor TTeam.Create(const aName: String; const aId: Integer);
begin
  FJSON := TJSONObject.Create;

  FId := aId;
  FName := aName;
end;

destructor TTeam.Destroy;
begin
  if (Assigned(FJSON)) then
    FJSON.Free;

  inherited;
end;

function TTeam.GetId: Integer;
begin
  Result := FId;
end;

function TTeam.GetJSON: TJSONObject;
begin
  FJSON.AddPair('name', FName);

  Result := FJSON;
end;

function TTeam.GetName: String;
begin
  Result := FName;
end;

procedure TTeam.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TTeam.SetName(const Value: String);
begin
  FName := Value;
end;

end.
