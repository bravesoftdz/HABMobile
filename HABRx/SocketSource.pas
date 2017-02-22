unit SocketSource;

interface

uses Source, Classes, SysUtils,
     IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient;

type
  TSocketSource = class(TSource)
  private
    { Private declarations }
    AClient: TIdTCPClient;
    Line: AnsiString;
    PreviousLines: Array[0..1] of String;
  protected
    { Protected declarations }
    procedure Execute; override;
  public
    { Public declarations }
  published
    constructor Create(ID: Integer; Callback: TSourcePositionCallback; Settings: TSettings);
  end;

implementation

procedure TSocketSource.Execute;
var
    Position: THABPosition;
    Line: String;
begin
    // Create client
    AClient := TIdTCPClient.Create;

    while not Terminated do begin
        // Connect to socket server
        AClient.Host := SourceSettings['Host'];
        AClient.Port := SourceSettings['Port'];
        try
            AClient.Connect;
            FillChar(Position, SizeOf(Position), 0);
            SyncCallback(SourceID, True, '', Position);
            while True do begin
                Line := AClient.IOHandler.ReadLn;
                if Line <> '' then begin
                    Position := ExtractPositionFrom(Line);
                    if Position.InUse then begin
                        SyncCallback(SourceID, True, Line, Position);
                    end;
                end;
            end;
        except
            // Wait before retrying
            SyncCallback(SourceID, False, '', Position);
            Sleep(1000);
        end;
    end;
end;

constructor TSocketSource.Create(ID: Integer; Callback: TSourcePositionCallback; Settings: TSettings);
begin
    inherited Create(ID, Callback, Settings);
end;

end.
