unit SourceForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  BaseForm, FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation, Source, GatewaySource;

type
  TfrmSources = class(TfrmBase)
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    Layout1: TLayout;
    Button2: TButton;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    GatewaySource: TGatewaySource;
    procedure GatewayCallback(ID: Integer; Connected: Boolean; Line: String; Position: THABPosition);
  public
    { Public declarations }
  end;

var
  frmSources: TfrmSources;

implementation

{$R *.fmx}

procedure TfrmSources.FormCreate(Sender: TObject);
var
    Settings: TSettings;
begin
    inherited;

    Settings := TSettings.Create;
    Settings.Add('SourceName', 'LoRa Gateway');
    Settings.Add('Host', '192.168.1.13');
    // Settings.Add('Host', 'loragw5.local');
    Settings.Add('Port', 6004);
    GatewaySource := TGatewaySource.Create(0, GatewayCallback, Settings);
end;

procedure TfrmSources.GatewayCallback(ID: Integer; Connected: Boolean; Line: String; Position: THABPosition);
var
    i, RecordCount: Integer;
begin
//    if HABDB = nil then begin
//        RecordCount := 0;
//    end else begin
//        RecordCount := HABDB.AddPosition(Position);
//    end;
    if Position.InUse then begin
        ListBox1.ItemIndex := ListBox1.Items.Add('LoRa' + IntToStr(Position.Channel) + ': ' +
                                                 Position.PayloadID + ' - ' +
                                                 FormatDateTime('hh:mm:ss', Position.TimeStamp) + ' = ' +
                                                 FormatFloat('0.00000', Position.Latitude) + ', ' +
                                                 FormatFloat('0.00000', Position.Longitude) + ', ' +
                                                 FormatFloat('0', Position.Altitude) + 'm');

        ListBox1.ListItems[ListBox1.ItemIndex].TextSettings.FontColor := TAlphaColorRec.Yellow;
        ListBox1.Items[0] := IntToStr(ListBox1.Items.Count);
        ListBox1.ListItems[ListBox1.ItemIndex].StyledSettings := [TStyledSetting.Family, TStyledSetting.Size, TStyledSetting.Style, TStyledSetting.Other];
        // ListBox1.ListItems[ListBox1.ItemIndex].StyledSettings - [TStyledSetting.ssFontColor];
    //    ListBox1.ListItems[ListBox1.ItemIndex].TextSettings.Font.Size := 24;
        ListBox1.ListItems[ListBox1.ItemIndex].Height := 32;
    end;
end;

end.
