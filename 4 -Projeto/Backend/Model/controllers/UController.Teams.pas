unit UController.Teams;

interface

uses
  Horse, GBSwagger.Path.Attributes, UController.Base, UEntity.Users;

type

  [SwagPath('teams', 'Time')]
  TControllerTeams = class(TControllerBase)
  private
  public

    [SwagGET('Listar Times', True)]
    [SwagResponse(200, TUser, 'Informações do Time', True)]
    [SwagResponse(404)]
    class procedure Gets(Req: THorseRequest; Res: THorseResponse;
      Next: TProc); Override;

    [SwagGET('{id}', 'Procurar um Time')]
    [SwagParamPath('id', 'id do Time')]
    [SwagResponse(200, TUser, 'Informações do Time', True)]
    [SwagResponse(404)]
    class procedure Get(Req: THorseRequest; Res: THorseResponse;
      Next: TProc); Override;

    [SwagPost('Adicionar novo Time')]
    [SwagParamBody('Informações do Time', TUser)]
    [SwagResponse(201)]
    [SwagResponse(400)]
    class procedure Post(Req: THorseRequest; Res: THorseResponse;
      Next: TProc); Override;

    [SwagDELETE('{id}', 'Deletar um Time')]
    [SwagParamPath('id', 'id do Time')]
    [SwagResponse(204)]
    [SwagResponse(200)]
    [SwagResponse(404)]
    class procedure Delete(Req: THorseRequest; Res: THorseResponse;
      Next: TProc); Override;
  end;

implementation

{ TControllerTeams }

Uses
  UDAO.Intf, UDAO.Teams;

class procedure TControllerTeams.Delete(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOTeams.Create;
  Inherited;
end;

class procedure TControllerTeams.Get(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOTeams.Create;
  Inherited;
end;

class procedure TControllerTeams.Gets(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOTeams.Create;
  Inherited;
end;

class procedure TControllerTeams.Post(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOTeams.Create;
  Inherited;
end;

end.
