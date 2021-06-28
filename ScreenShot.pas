unit ScreenShot;

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
  Vcl.ExtCtrls;

type TScreenShot = class
  public
    class function GetPrintScreen: TBitmap;
    class function GetAppPrintScreen: TBitmap;
end;

implementation

{ TScreenShot }

class function TScreenShot.GetPrintScreen: TBitmap;
var
  vHDC : HDC;
  vCanvas : TCanvas;
begin
  Result := TBitmap.Create;

  Result.Width := Screen.Width;
  Result.Height := Screen.Height;

  vHDC := GetDC(0);
  vCanvas := TCanvas.Create;
  vCanvas.Handle := vHDC;

  Result.Canvas.CopyRect(
    Rect(0, 0, Result.Width, Result.Height), vCanvas,
    Rect(0, 0, Result.Width, Result.Height)
  );

  vCanvas.Free;
  ReleaseDC(0, vHDC);
end;

class function TScreenShot.GetAppPrintScreen: TBitmap;
var
  Wnd: HWND;
  vHDC: HDC;
  Rect: TRect;
  vCanvas : TCanvas;
begin
  Result := TBitmap.Create;

  Result.Width  := Application.MainForm.Width;
  Result.Height := Application.MainForm.Height;

  Wnd := Application.MainForm.Handle;

  vHDC := GetDC(Wnd);

  vCanvas := TCanvas.Create;
  vCanvas.Handle := vHDC;

  GetClientRect(Application.MainForm.Handle,Rect);

  Result.Canvas.CopyRect(
    Rect,
    vCanvas,
    Rect
  );

  vCanvas.Free;
  ReleaseDC(Wnd, vHDC);
end;


end.
