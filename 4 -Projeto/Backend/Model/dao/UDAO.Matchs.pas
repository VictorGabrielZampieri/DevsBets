unit UDAO.Matchs;

interface

uses
  UDAO.Base;

type
  TDAOMatchs = class(TDAOBase)
    public
      constructor Create;
  end;

implementation

{ TDAOTeams }

constructor TDAOMatchs.Create;
begin
  FTabela := 'matchs';
end;

end.
