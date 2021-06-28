unit FormMainUnit;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Imaging.pngimage,
  Vcl.Buttons;

type
  TFormMain = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Panel1: TPanel;
    rbAppScreenshot: TRadioButton;
    rbFullScreenshot: TRadioButton;
    procedure Button1Click(Sender: TObject);
  protected
  public


  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses
  Screenshot,
  MouseEvents,
  BitmapHelper;

procedure TFormMain.Button1Click(Sender: TObject);
var
  ScreenShot: TBitmap;
  DelphiIcon: TBitmap;
  Position: TPoint;
begin

  ScreenShot := TBitmap.Create;

  if rbAppScreenshot.Checked  then ScreenShot.Assign(TScreenShot.GetAppPrintScreen) else
  if rbFullScreenshot.Checked then ScreenShot.Assign(TScreenShot.GetPrintScreen);

  DelphiIcon := TBitmap.Create;
  DelphiIcon.LoadFromFile('..\..\assets\delphi_logo_blue.bmp');

  Position := ScreenShot.IndexOf(DelphiIcon);

  Position.X := Position.X + DelphiIcon.Width div 2;
  Position.Y := Position.Y + DelphiIcon.Height div 2;

  if rbAppScreenshot.Checked then begin
    Position := Application.MainForm.ClientToScreen(Position);
  end;

  TMouseEvents.Move(Position);

end;

end.
