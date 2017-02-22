unit DLFlDigiSource;

interface

uses SocketSource, Source;

type
  TDLFlDigiSource = class(TSocketSource)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    constructor Create(ID: Integer; Callback: TSourcePositionCallback; Settings: TSettings);
  end;

implementation

constructor TDLFlDigiSource.Create(ID: Integer; Callback: TSourcePositionCallback; Settings: TSettings);
begin
    inherited Create(ID, Callback, Settings);
end;

end.

