unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, BaseForm;

type
  TfrmMain = class(TForm)
    StyleBook1: TStyleBook;
    Button1: TButton;
    Button2: TButton;
    Circle1: TCircle;
    Rectangle1: TRectangle;
    Circle2: TCircle;
    Rectangle4: TRectangle;
    Rectangle3: TRectangle;
    Circle4: TCircle;
    Rectangle2: TRectangle;
    Circle3: TCircle;
    pnlCentre: TRectangle;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    CurrentForm: TfrmBase;
    procedure LoadForm(NewForm: TfrmBase);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses SplashForm, SourceForm;

procedure TfrmMain.LoadForm(NewForm: TfrmBase);
begin
    if CurrentForm <> nil then begin
        CurrentForm.pnlMain.Parent := CurrentForm;
    end;

    NewForm.pnlMain.Parent := pnlCentre;
    CurrentForm := NewForm;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
    CurrentForm := nil;
    if Screen.Height < 1000 then begin
        BorderStyle := TFmxFormBorderStyle.bsNone;
        WindowState := TWindowState.wsMaximized;
    end;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
    LoadForm(frmSources);
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
    if CurrentForm = nil then begin
        LoadForm(frmSplash);
    end;
end;

// LCARS font Swiss911 UCm BT

end.
