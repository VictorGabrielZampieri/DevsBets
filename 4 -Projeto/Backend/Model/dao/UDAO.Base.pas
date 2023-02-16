unit UDAO.Base;

interface

Uses
  UDAO.Intf, System.JSON, DataSet.Serialize;

type
  TDAOBase = class(TInterfacedObject, IDAO)

      FTabela : String;


    function ObterRegistros: TJSONArray;
    function ProcurarPorId(const aIdentificador: Integer): TJSONObject;
    function AdicionarRegistro(aRegistro: TJSONObject): Boolean;
    function DeletarRegistro(const aIdentificador: Integer): Boolean;

  end;

implementation

Uses
  FireDAC.Comp.Client, System.SysUtils, UUtil.Banco;

{ TDAOBase }

function TDAOBase.AdicionarRegistro(aRegistro: TJSONObject): Boolean;
begin
  try
    Result := TUtilBanco.AdicionarRegistro(FTabela, aRegistro.ToJSON);
  except on E: Exception do
    raise Exception.Create('Erro ao Adicionar Registro: '+ e.Message);
  end;
end;

function TDAOBase.DeletarRegistro(const aIdentificador: Integer): Boolean;
begin
  try
    Result := TUtilBanco.RemoverRegistro(FTabela, aIdentificador);
  except on E: Exception do
    raise Exception.Create('Erro ao Remover Registro: '+ e.Message);
  end;
end;

function TDAOBase.ObterRegistros: TJSONArray;
begin
  try
    Result := TUtilBanco.ExecutarConsulta(Format('SELECT * FROM %s',[FTabela]));
  except on E: Exception do
    raise Exception.Create('Erro ao Obter Registros: '+e.Message);
  end;
end;

function TDAOBase.ProcurarPorId(const aIdentificador: Integer): TJSONObject;
var
  xJSONArray : TJSONArray;
begin
  try
    xJSONArray := TUtilBanco.ExecutarConsulta(Format('SELECT * FROM %s WHERE ID = %d', [FTabela,aIdentificador]));

    if (xJSONArray.Count = 0) then
    begin
      Result := TJSONObject.Create;
      xJSONArray.Free;
      Exit;
    end;

    Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(xJSONArray[0].ToJSON),0) as TJSONObject;

  except on E: Exception do
    raise Exception.Create('Erro ao Obter o Registros: '+ e.Message);
  end;
end;

end.
