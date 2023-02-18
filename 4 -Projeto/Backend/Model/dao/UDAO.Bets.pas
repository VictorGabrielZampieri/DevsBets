unit UDAO.Bets;

interface

uses
  UDAO.Base;

type
  TDAOBets = class(TDaoBase)
    public
      constructor Create;
  end;

implementation

{ TDAOUsers }

constructor TDAOBets.Create;
begin
  FTabela := 'Bets';
end;

end.
