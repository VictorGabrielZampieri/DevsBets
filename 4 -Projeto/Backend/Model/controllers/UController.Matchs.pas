unit UController.Matchs;

interface

uses
  Horse, GBSwagger.Path.Attributes, UController.Base, UEntity.Users;

type

  [SwagPath('matchs', 'Partidas')]
  TControllerMatchs = class(TControllerBase)
  private
  public

    [SwagGET('Listar Partidas', True)]
    [SwagResponse(200, TUser, 'Informações da Partida', True)]
    [SwagResponse(404)]
    class procedure Gets(Req: THorseRequest; Res: THorseResponse;
      Next: TProc); Override;

    [SwagGET('{id}', 'Procurar uma Partida')]
    [SwagParamPath('id', 'id da Partidas')]
    [SwagResponse(200, TUser, 'Informações da Partida', True)]
    [SwagResponse(404)]
    class procedure Get(Req: THorseRequest; Res: THorseResponse;
      Next: TProc); Override;

    [SwagPost('Adicionar nova Partida')]
    [SwagParamBody('Informações da Partida', TUser)]
    [SwagResponse(201)]
    [SwagResponse(400)]
    class procedure Post(Req: THorseRequest; Res: THorseResponse;
      Next: TProc); Override;

    [SwagDELETE('{id}', 'Deletar uma Partida')]
    [SwagParamPath('id', 'id da Partida')]
    [SwagResponse(204)]
    [SwagResponse(200)]
    [SwagResponse(404)]
    class procedure Delete(Req: THorseRequest; Res: THorseResponse;
      Next: TProc); Override;
  end;

implementation

{ TControllerTeams }

Uses
  UDAO.Intf, UDAO.Matchs;

class procedure TControllerMatchs.Delete(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOMatchs.Create;
  Inherited;
end;

class procedure TControllerMatchs.Get(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOMatchs.Create;
  Inherited;
end;

class procedure TControllerMatchs.Gets(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOMatchs.Create;
  Inherited;
end;

class procedure TControllerMatchs.Post(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOMatchs.Create;
  Inherited;
end;

end.
