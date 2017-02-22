program MobileHAB;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {frmMain},
  DLFlDigiSource in 'HABRx\DLFlDigiSource.pas',
  DummySource in 'HABRx\DummySource.pas',
  HABDB in 'HABRx\HABDB.pas',
  HabitatSource in 'HABRx\HabitatSource.pas',
  Source in 'HABRx\Source.pas',
  Miscellaneous in 'HABRx\Miscellaneous.pas',
  BaseForm in 'BaseForm.pas' {frmBase},
  SplashForm in 'SplashForm.pas' {frmSplash},
  SourceForm in 'SourceForm.pas' {frmSources},
  SerialSource in 'HABRx\SerialSource.pas',
  GatewaySource in 'HABRx\GatewaySource.pas',
  SocketSource in 'HABRx\SocketSource.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.CreateForm(TfrmSources, frmSources);
  Application.Run;
end.
