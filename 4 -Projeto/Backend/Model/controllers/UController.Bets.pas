unit UController.Bets;

interface

uses
  Horse, GBSwagger.Path.Attributes, UController.Base, UEntity.Users;

type

  [SwagPath('bets', 'Palpites')]
  TControllerBets = class(TControllerBase)
  private
  public

    [SwagGET('Listar Palpites', True)]
    [SwagResponse(200, TUser, 'Informa��es do Palpite', True)]
    [SwagResponse(404)]
    class procedure Gets(Req: THorseRequest; Res: THorseResponse;
      Next: TProc); Override;

    [SwagGET('{id}', 'Procurar um Palpite')]
    [SwagParamPath('id', 'id do Time')]
    [SwagResponse(200, TUser, 'Informa��es do Palpite', True)]
    [SwagResponse(404)]
    class procedure Get(Req: THorseRequest; Res: THorseResponse;
      Next: TProc); Override;

    [SwagPost('Adicionar novo Palpite')]
    [SwagParamBody('Informa��es do Palpite', TUser)]
    [SwagResponse(201)]
    [SwagResponse(400)]
    class procedure Post(Req: THorseRequest; Res: THorseResponse;
      Next: TProc); Override;

    [SwagDELETE('{id}', 'Deletar um Palpite')]
    [SwagParamPath('id', 'id do Palpite')]
    [SwagResponse(204)]
    [SwagResponse(200)]
    [SwagResponse(404)]
    class procedure Delete(Req: THorseRequest; Res: THorseResponse;
      Next: TProc); Override;
  end;

implementation

{ TControllerBets }

Uses
  UDAO.Intf, UDAO.Bets;

class procedure TControllerBets.Delete(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOBets.Create;
  Inherited;
end;

class procedure TControllerBets.Get(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOBets.Create;
  Inherited;
end;

class procedure TControllerBets.Gets(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOBets.Create;
  Inherited;
end;

class procedure TControllerBets.Post(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOBets.Create;
  Inherited;
end;

end.
