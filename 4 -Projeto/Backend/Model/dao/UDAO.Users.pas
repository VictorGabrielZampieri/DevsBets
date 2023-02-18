unit UDAO.Users;

interface

uses
  System.JSON, DataSet.Serialize,UDAO.Base;

type
  TDAOUsers = class(TDAOBase)
    public
      constructor Create;
    function ValidarLogin(const aUser, aPassword: String): Boolean;
  end;

implementation

Uses
  FireDAC.Comp.Client, System.SysUtils, UUtil.Banco;

{ TDAOUsers }



constructor TDAOUsers.Create;
begin
  FTabela := 'users';
end;

function TDAOUsers.ValidarLogin(const aUser, aPassword: String): Boolean;
var
  xJSONArray : TJSONArray;
begin
  try

    xJSONArray := TUtilBanco.ExecutarConsulta(Format('SELECT * FROM %s WHERE LOGIN = %s AND PASSWORD = %s', [FTabela, QuotedStr(aUser), QuotedStr(aPassword)]));

    Result := Assigned(xJSONArray) and (xJSONArray.Count > 0);
  except on E: Exception do
    raise Exception.Create('Erro ao Validar Usuário: '+e.Message);
  end;
end;

end.
