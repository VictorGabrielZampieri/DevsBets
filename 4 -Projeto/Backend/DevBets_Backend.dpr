program DevBets_Backend;

{$APPTYPE CONSOLE}

uses
  Horse,
  Horse.Jhonson,
  Horse.CORS,
  Horse.BasicAuthentication,
  Horse.JWT,
  Horse.GBSwagger,
  System.SysUtils,
  UEntity.Users in 'Model\entities\UEntity.Users.pas',
  UEntity.Logins in 'Model\entities\UEntity.Logins.pas',
  UEntity.Matchs in 'Model\entities\UEntity.Matchs.pas',
  UEntity.Teams in 'Model\entities\UEntity.Teams.pas',
  UEntity.Bets in 'Model\entities\UEntity.Bets.pas',
  UDAO.Intf in 'Model\dao\UDAO.Intf.pas',
  UDAO.Bets in 'Model\dao\UDAO.Bets.pas',
  UDAO.Matchs in 'Model\dao\UDAO.Matchs.pas',
  UDAO.Users in 'Model\dao\UDAO.Users.pas',
  UUtil.Banco in 'Model\utils\UUtil.Banco.pas',
  UDAO.Teams in 'Model\dao\UDAO.Teams.pas',
  UDAO.Base in 'Model\dao\UDAO.Base.pas',
  UController.Base in 'Model\controllers\UController.Base.pas',
  UController.Bets in 'Model\controllers\UController.Bets.pas',
  UController.Login in 'Model\controllers\UController.Login.pas',
  UController.Users in 'Model\controllers\UController.Users.pas',
  UController.Teams in 'Model\controllers\UController.Teams.pas',
  UController.Matchs in 'Model\controllers\UController.Matchs.pas';

procedure Registry;
begin
  //Login
    THorse.Group.Prefix('v1')
      .Post('/login', TControllerLogin.PostLogin);

    //Users
    THorse.Group.Prefix('v1')
      .Get('/users', TControllerUser.Gets)
      .Get('/users/:id', TControllerUser.Get)
      .Post('/users', TControllerUser.Post)
      .Delete('/users/:id', TControllerUser.Delete);

    //Teams
    THorse.Group.Prefix('v1')
    .Get('/teams', TControllerTeams.Gets)
    .Get('/teams/:id', TControllerTeams.Get)
    .Post('/teams', TControllerTeams.Post)
    .Delete('/teams/:id', TControllerTeams.Delete);

    //Matchs
    THorse.Group.Prefix('v1')
    .Get('/matchs', TControllerMatchs.Gets)
    .Get('/matchs/:id', TControllerMatchs.Get)
    .Post('/matchs', TControllerMatchs.Post)
    .Delete('/matchs/:id', TControllerMatchs.Delete);

    //Bets
    THorse.Group.Prefix('v1')
    .Get('/bets', TControllerBets.Gets)
    .Get('/bets/:id', TControllerBets.Get)
    .Post('/bets', TControllerBets.Post)
    .Delete('/bets/:id', TControllerBets.Delete);
end;

procedure SwaggerConfig;
begin
  THorseGBSwaggerRegister.RegisterPath(TControllerUser);
  THorseGBSwaggerRegister.RegisterPath(TControllerTeams);
  THorseGBSwaggerRegister.RegisterPath(TControllerMatchs);
  THorseGBSwaggerRegister.RegisterPath(TControllerBets);
  THorseGBSwaggerRegister.RegisterPath(TControllerLogin);

  //http://localhost:9090/swagger/doc/html
  Swagger
    .Info
      .Title('Documentação API DevsBets')
      .Description('DevsBets - Lance seu Palpite')
      .Contact
        .Name('Victor Gabriel Zampieri')
        .Email('victorgzampieri@gmail.com')
        .URL('https://github.com/VictorGabrielZampieri')
      .&End
    .&End
    .BasePath('v1');
end;

procedure ConfigMiddleware;
begin
  THorse
    .Use(Cors)
    .Use(HorseSwagger)
    .Use(Jhonson());

    //Basic Authentication usuado para o login
    THorse
      .Use(HorseBasicAuthentication(TControllerUser.ValidarUser, THorseBasicAuthenticationConfig
         .New
            .SkipRoutes(['/v1/users',
                        '/v1/users/:id',
                        '/v1/teams',
                        '/v1/teams/:id',
                        '/v1/matchs',
                        '/v1/matchs/:id',
                        '/v1/bets',
                        '/v1/bets/:id',
                        '/swagger/doc/html',
                        '/swagger/doc/json'])));

  //JWT usado para as demais rotas
   //Basic Authentication usuado para o login
    THorse
      .Use(HorseJWT('KeyDevsBets',
        THorseJWTConfig
          .New
            .SkipRoutes(['/v1/login',
                         '/v1/users',
                         '/v1/users/:id',
                         '/swagger/doc/html',
                         '/swagger/doc/json'
                          ])));
end;

begin
  ConfigMiddleware;
  SwaggerConfig;
  Registry;

  THorse.Listen(9090,
    procedure(Horse: THorse)
    begin
      Writeln('Server is runing on port ' + IntToStr(Horse.Port));
    end);
end.