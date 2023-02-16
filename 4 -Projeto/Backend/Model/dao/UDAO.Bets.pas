unit UDAO.Bets;

interface

uses
  UDAO.Base;

type
  TDAOUsers = class(TDaoBase)
    public
      constructor Create;
  end;

implementation

{ TDAOUsers }

constructor TDAOUsers.Create;
begin
  FTabela := 'Bets';
end;

end.
