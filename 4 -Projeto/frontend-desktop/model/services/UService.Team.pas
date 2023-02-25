unit UService.Team;

interface

uses
  UEntity.Teams,
  UService.Base,
  Generics.Collections;

type
  TServiceTeam = class(TServiceBase)
  private
    FTeam: TTeam;
    FTeams: TObjectList<TTeam>;     //Diferenca do listo: o tObjectList n�o precisa passar pelo freeAndNil
    function GetTeams: TObjectList<TTeam>;
  public
    constructor Create; overload;
    constructor Create(aTeam: TTeam); overload;
    destructor Destroy; override;

    procedure Registrar; override;
    procedure Listar; override;
    procedure Excluir; override;

    function ObterRegistro(const aId: Integer): TObject; override;

    property Teams: TObjectList<TTeam> read GetTeams;
  end;

implementation

uses
  System.SysUtils,
  System.JSON, UUtils.Constants, DataSet.Serialize,
  FireDAC.Comp.Client, REST.Types;

{ TServiceTeam }

constructor TServiceTeam.Create;
begin
  Inherited Create;

  FTeams := TObjectList<TTeam>.Create;
end;

constructor TServiceTeam.Create(aTeam: TTeam);
begin
  FTeam := aTeam;
  Self.Create;
end;

destructor TServiceTeam.Destroy;
begin
  FreeAndNil(FTeam);
  FreeAndNil(FTeams);
  inherited;
end;

procedure TServiceTeam.Excluir;
begin

  if (not Assigned(FTeam)) or (FTeam.Id = 0) then
    raise Exception.Create('Nenhum time foi encontrado para exclus�o.');

    try
      FRESTClient.BaseURL := Format(URL_BASE_TEAM + '/d', [FTeam.Id]);
      FRESTRequest.Method := rmDELETE;
      FRESTRequest.Execute;

      case FRESTResponse.StatusCode of
        API_SUCESSO_SEM_RETORNO:
          Exit;
        API_NAO_AUTORIZADO:
          raise Exception.Create('Usu�rio n�o encontrado.');
        else
          raise Exception.Create('Erro n�o catalogado.');
      end;
    except on E: Exception do
      raise Exception.Create(e.Message);
    end;
end;

function TServiceTeam.GetTeams: TObjectList<TTeam>;
begin
  Result := FTeams;
end;

procedure TServiceTeam.Listar;
var
  xMemTable : TFDMemTable;
begin
  FTeams.Clear;

  xMemTable := TFDMemTable.Create(nil);
  try
    try
      FRESTClient.BaseURL := URL_BASE_TEAM;
      FRESTRequest.Method := rmGet;
      FRESTRequest.Execute;

      case FRESTResponse.StatusCode of
        API_SUCESSO:
        begin
          xMemTable.LoadFromJSON(FRESTResponse.Content);

          while not xMemTable.Eof do
          begin
            FTeams.Add(TTeam.Create(xMemTable.FieldByName('id').AsInteger,
            xMemTable.FieldByName('name').AsString));
            xMemTable.Next;
          end;
        end;
        API_NAO_AUTORIZADO:
          raise Exception.Create('Usu�rio n�o autorizado.');
        else
          raise Exception.Create('Erro ao carregar a lista de times. C�digo do Erro: ' + FRESTResponse.StatusCode.ToString);
      end;
    except on E: Exception do
      raise Exception.Create(e.Message);
    end;
  finally
    FreeAndNil(xMemTable);
  end;
  inherited;

end;

function TServiceTeam.ObterRegistro(const aId: Integer): TObject;
var
  xMemTable: TFDMemTable;
begin
  Result := nil;

  xMemTable := TFDMemTable.Create(nil);

  try
    FRESTClient.BaseURL := URL_BASE_TEAM + '/' + aId.ToString;
    FRESTRequest.Method := rmGET;
    FRESTRequest.Execute;

    if (FRESTResponse.StatusCode = API_SUCESSO) then
    begin
      xMemTable.LoadFromJSON(FRESTResponse.Content);

      if (xMemTable.FindFirst) then
        Result := TTeam.Create(xMemTable.FieldByName('id').AsInteger);
    end;
  finally
    FreeAndNil(xMemTable);
  end;
end;

procedure TServiceTeam.Registrar;
begin
   try
    FRESTClient.BaseURL := URL_BASE_TEAM;
    FRESTRequest.Method := rmPOST;
    FRESTRequest.Params.AddBody(FTeam.JSON);
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_CRIADO:
        Exit;
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usuario n�o autorizado.');
    else
      raise Exception.Create('Erro n�o catalogado.');
    end;

  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;

end;

end.
