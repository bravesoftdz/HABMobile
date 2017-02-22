unit GatewaySource;

interface

uses SocketSource, Source, SysUtils,
{$IFDEF VCL}
  ExtCtrls, Windows
{$ELSE}
  FMX.Types
{$ENDIF}
;

type
  TGatewaySource = class(TSocketSource)
  private
    { Private declarations }
    PreviousLines: Array[0..1] of String;
    function ProcessJSON(Line: String): THABPosition;
  protected
    { Protected declarations }
    function ExtractPositionFrom(Line: String): THABPosition; override;
  public
    { Public declarations }
  end;

implementation

uses Miscellaneous;

function TGatewaySource.ExtractPositionFrom(Line: String): THABPosition;
var
    Position: THABPosition;
begin
    FillChar(Position, SizeOf(Position), 0);

    if Line <> '' then begin
        if Pos('"POSN"', Line) > 0 then begin
            // {"class":"POSN","index":0;"payload":"NOTAFLIGHT","time":"13:01:56","lat":52.01363,"lon":-2.50647,"alt":5507,"rate":7.0}
            Position := ProcessJSON(Line);
            if Line <> PreviousLines[Position.Channel] then begin
                PreviousLines[Position.Channel] := Line;
                Position.InUse := True;
            end;
        end;
    end;

    Result := Position;
end;

function TGatewaySource.ProcessJSON(Line: String): THABPosition;
var
    PayloadIndex: Integer;
    TimeStamp: String;
    lat, lon, alt: Double;
    OK: Boolean;
    NewTime: TDateTime;
    Position: THABPosition;
begin
    FillChar(Position, SizeOf(Position), 0);

    // {"class":"POSN","payload":"NOTAFLIGHT","time":"13:01:56","lat":52.01363,"lon":-2.50647,"alt":5507,"rate":7.0}

    try
        Position.Channel := GetJSONInteger(Line, 'index');
        Position.PayloadID := GetJSONString(Line, 'payload');

        TimeStamp := GetJSONString(Line, 'time');
        if Length(TimeStamp) = 8 then begin
            Position.TimeStamp := EncodeTime(StrToIntDef(Copy(TimeStamp, 1, 2), 0),
                                             StrToIntDef(Copy(TimeStamp, 4, 2), 0),
                                             StrToIntDef(Copy(TimeStamp, 7, 2), 0),
                                             0);
        end;
        Position.Latitude := GetJSONFloat(Line, 'lat');
        Position.Longitude := GetJSONFloat(Line, 'lon');
        Position.Altitude := GetJSONFloat(Line, 'alt');
    except
    end;

//    if PreviousTime > 0 then begin
//        if (Position.Time - PreviousTime) > 0 then begin
//            Position.Rate := (Position.Altitude - PreviousAltitude) / (86400 * (Position.Time - PreviousTime));
//        end;
//    end;

//    PreviousAltitude := Position.Altitude;

    Inc(SentenceCount);

    Result := Position;
end;


end.

