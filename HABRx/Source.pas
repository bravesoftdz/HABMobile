unit Source;

interface

uses Classes, SysUtils, Generics.Collections;

type
  TSettings = TDictionary<String, Variant>;

type
  THABPosition = record
    InUse:      Boolean;
    Channel:    Integer;
    PayloadID:  String;
    Counter:    Integer;
    TimeStamp:  TDateTime;
    Latitude:   Double;
    Longitude:  Double;
    Altitude:   Double;
  end;

type
  TSourcePositionCallback = procedure(ID: Integer; Connected: Boolean; Line: String; Position: THABPosition) of object;

type
  TSource = class(TThread)
  private
    { Private declarations }
  protected
    { Protected declarations }
    SourceID: Integer;
    SentenceCount: Integer;
    Enabled: Boolean;
    SourceSettings: TSettings;
    procedure Execute; override;
    procedure SyncCallback(ID: Integer; Connected: Boolean; Line: String; Position: THABPosition);
    function ExtractPositionFrom(Line: String): THABPosition; virtual;
  public
    { Public declarations }
    PositionCallback: TSourcePositionCallback;
    procedure Enable; virtual;
    procedure Disable; virtual;
  published
    constructor Create(ID: Integer; Callback: TSourcePositionCallback; Settings: TSettings);
  end;

implementation

procedure TSource.Execute;
begin
    // Nothing to do here
end;

constructor TSource.Create(ID: Integer; Callback: TSourcePositionCallback; Settings: TSettings);
begin
    SentenceCount := 0;
    SourceID := ID;
    PositionCallback := Callback;
    Enabled := True;
    SourceSettings := Settings;
    inherited Create(False);
end;

function TSource.ExtractPositionFrom(Line: String): THABPosition;
var
    Position: THABPosition;
begin
    FillChar(Position, SizeOf(Position), 0);

    if Line <> '' then begin
        if Line[1] = '$' then begin
            // UKHAS sentence
        end;
    end;

    Result := Position;
end;

procedure TSource.SyncCallback(ID: Integer; Connected: Boolean; Line: String; Position: THABPosition);
begin
    Synchronize(
        procedure begin
            PositionCallback(SourceID, Connected, Line, Position);
        end
    );
end;

procedure TSource.Enable;
begin
    Enabled := True;
end;

procedure TSource.Disable;
begin
    Enabled := False;
end;

end.
