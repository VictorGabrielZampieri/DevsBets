unit UService.Match;

interface

uses
  UEntity.Matchs,
  UService.Base,
  Generics.Collections;

type
  TServiceMatch = class(TServiceBase)
  private
    FMatch: TMatch;
    FMatchs: TObjectList<TMatch>;     //Diferenca do listo: o tObjectList não precisa passar pelo freeAndNil
    function GetMatchs: TObjectList<TMatch>;
  public
    constructor Create; overload;
    constructor Create(aMatch: TMatch); overload;
    destructor Destroy; override;

    procedure Registrar; override;
    procedure Listar; override;
    procedure Excluir; override;

    function ObterRegistro(const aId: Integer): TObject; override;

    property Match: TObjectList<TMatch> read GetMatchs;
  end;

implementation

uses
  System.SysUtils,
  System.JSON, UUtils.Constants, DataSet.Serialize,
  FireDAC.Comp.Client, REST.Types;

{ TServiceTeam }

constructor TServiceMatch.Create;
begin
  Inherited Create;

  FMatchs := TObjectList<TMatch>.Create;
end;

constructor TServiceMatch.Create(aMatch: TMatch);
begin
  FMatch := aMatch;
  Self.Create;
end;

destructor TServiceMatch.Destroy;
begin
  FreeAndNil(FMatch);
  FreeAndNil(FMatchs);
  inherited;
end;

procedure TServiceMatch.Excluir;
begin

  if (not Assigned(FMatch)) or (FMatch.Id = 0) then
    raise Exception.Create('Nenhum time foi encontrado para exclusão.');

    try
      FRESTClient.BaseURL := Format(URL_BASE_MATCH + '/d', [FMatch.Id]);
      FRESTRequest.Method := rmDELETE;
      FRESTRequest.Execute;

      case FRESTResponse.StatusCode of
        API_SUCESSO_SEM_RETORNO:
          Exit;
        API_NAO_AUTORIZADO:
          raise Exception.Create('Usuário não encontrado.');
        else
          raise Exception.Create('Erro não catalogado.');
      end;
    except on E: Exception do
      raise Exception.Create(e.Message);
    end;
end;

function TServiceMatch.GetMatchs: TObjectList<TMatch>;
begin
  Result := FMatchs;
end;

procedure TServiceMatch.Listar;
var
  xMemTable : TFDMemTable;
begin
  FMatchs.Clear;

  xMemTable := TFDMemTable.Create(nil);
  try
    try
      FRESTClient.BaseURL := URL_BASE_MATCH;
      FRESTRequest.Method := rmGet;
      FRESTRequest.Execute;

      case FRESTResponse.StatusCode of
        API_SUCESSO:
        begin
          xMemTable.LoadFromJSON(FRESTResponse.Content);

          while not xMemTable.Eof do
          begin
            FMatchs.Add(TMatch.Create(xMemTable.FieldByName('id').AsInteger,
            xMemTable.FieldByName('name').AsString));
            xMemTable.Next;
          end;
        end;
        API_NAO_AUTORIZADO:
          raise Exception.Create('Usuário não autorizado.');
        else
          raise Exception.Create('Erro ao carregar a lista de times. Código do Erro: ' + FRESTResponse.StatusCode.ToString);
      end;
    except on E: Exception do
      raise Exception.Create(e.Message);
    end;
  finally
    FreeAndNil(xMemTable);
  end;
  inherited;

end;

function TServiceMatch.ObterRegistro(const aId: Integer): TObject;
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

procedure TServiceMatch.Registrar;
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
        raise Exception.Create('Usuario não autorizado.');
    else
      raise Exception.Create('Erro não catalogado.');
    end;

  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;

end;

end.
