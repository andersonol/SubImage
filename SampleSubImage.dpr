program SampleSubImage;

{$I cef.inc}

uses
  Vcl.Forms,
  FormMainUnit in 'FormMainUnit.pas' {FormMain},
  ScreenShot in 'ScreenShot.pas',
  BitmapHelper in 'BitmapHelper.pas',
  MouseEvents in 'MouseEvents.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
