program DevBets_Backend;

{$APPTYPE CONSOLE}

uses
  Horse,
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
  UDAO.Base in 'Model\dao\UDAO.Base.pas';

begin

  THorse.Get('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send('pong');
    end);

  THorse.Listen(9090,
    procedure(Horse: THorse)
    begin
      Writeln('Server is runing on port ' + IntToStr(Horse.Port));
    end);
end.