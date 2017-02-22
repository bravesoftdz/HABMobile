unit SplashForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  BaseForm, FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.Edit;

type
  TfrmSplash = class(TfrmBase)
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.fmx}

end.
