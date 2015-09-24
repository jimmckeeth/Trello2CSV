unit T2C_Settings;

interface

type
  TSettings = class
  private
    FTrelloURL: string;
    FSQL: string;
  public
    property TrelloURL: string read FTrelloURL write FTrelloURL;
    property SQL: string read FSQL write FSQL;
  end;

implementation

{ TSettings }

end.
