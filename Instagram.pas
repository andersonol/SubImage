unit Instagram;

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

type TInstagramRobot = class
  private
    FScreenshot: TBitmap;
    function SearchElement(AssetFileName: string; NewScreenShot: Boolean): TPoint;
    procedure Refresco;
    function GetScreenshot: TBitmap;
    procedure WriteScreenshot (const Value: TBitmap);
  public
    procedure InserirLogin(text: string; NewScreenShot: Boolean = True);
    procedure InserirSenha(text: string; NewScreenShot: Boolean = False);
    procedure Logar(NewScreenShot: Boolean = true);
    procedure SalvarInformacoes(NewScreenShot: Boolean = true);
    function IniciarConversar: boolean;
    procedure EscreverMensagem(text: string; NewScreenShot: Boolean = True);
    procedure EnviarMensagem;
    constructor Create;
    property Screenshot: TBitmap read GetScreenshot write WriteScreenshot ;
end;

implementation

uses
  ScreenShot,
  BitmapHelper,
  MouseEvents,
  KeyboardEvents;

{ TInstagramRobot }

constructor TInstagramRobot.Create;
begin
  FScreenshot := TBitmap.Create;
end;

procedure TInstagramRobot.EnviarMensagem;
var
  P : TPoint;
begin

  P := SearchElement('assets\button_send_message.bmp',true);

  TMouseEvents.Move(P);
  Refresco;
  TMouseEvents.Click(P);
  Refresco;

end;

procedure TInstagramRobot.EscreverMensagem(text: string; NewScreenShot: Boolean);
var
  P : TPoint;
begin

  P := SearchElement('assets\input_message.bmp',NewScreenShot);

  TMouseEvents.Move(P);
  TMouseEvents.Click(P);

  Refresco;

  TKeyboardEvents.Write(text);

  Refresco;

end;

function TInstagramRobot.GetScreenshot: TBitmap;
begin
  if not Assigned(FScreenshot) then
    FScreenshot := TBitmap.Create;

  Result := FScreenshot;
end;

function TInstagramRobot.IniciarConversar: boolean;
var
  P : TPoint;
  tentativas: integer;
begin

  tentativas := 0;

  repeat

    Inc(tentativas);

    P := SearchElement('assets\button_message.bmp',true);
    Refresco;
    Result := (P.X > 0) and (P.Y > 0);
    if Result then
    begin

      TMouseEvents.Move(P);
      TMouseEvents.Click(P);

    end;

  until Result OR (tentativas > 3)


end;

procedure TInstagramRobot.InserirLogin(text: string; NewScreenShot: Boolean = True);
var
  P : TPoint;
begin

  P := SearchElement('assets\input_login.bmp',NewScreenShot);

  TMouseEvents.Move(P);
  TMouseEvents.Click(P);

  Refresco;

  TKeyboardEvents.Write(text);

  Refresco;

end;

procedure TInstagramRobot.InserirSenha(text: string; NewScreenShot: Boolean = false);
var
  P : TPoint;
begin

  P := SearchElement('assets\input_password.bmp',NewScreenShot);

  TMouseEvents.Move(P);
  TMouseEvents.Click(P);

  Refresco;

  TKeyboardEvents.Write('m@rgh!vendan@2019');

  Refresco;
end;

procedure TInstagramRobot.Logar(NewScreenShot: Boolean = True);
var
  P : TPoint;
begin

  P := SearchElement('assets\button_login.bmp',NewScreenShot);

  TMouseEvents.Move(P);
  Refresco;
  TMouseEvents.Click(P);
  Refresco;

end;

procedure TInstagramRobot.Refresco;
var
  I: Integer;
begin

  for I := 0 to 4 do
  begin
    Application.ProcessMessages;
    Sleep(100);
    Application.ProcessMessages;
  end;

end;

procedure TInstagramRobot.SalvarInformacoes(NewScreenShot: Boolean);

var
  P : TPoint;
begin

  P := SearchElement('assets\button_save_info.bmp',NewScreenShot);

  TMouseEvents.Move(P);
  Refresco;
  TMouseEvents.Click(P);
  Refresco;

end;

function TInstagramRobot.SearchElement(AssetFileName: string; NewScreenShot: Boolean): TPoint;
var
  Element: TBitmap;
begin

  Element:= TBitmap.Create;
  Element.LoadFromFile(AssetFileName);

  Refresco;

  if NewScreenShot then begin
    ScreenShot.Assign( TScreenshot.GetAppPrintScreen);
    Screenshot.SaveToFile('screenshots\' + FormatDateTime('YYYY-DD-DD HH-NN-SS', Now) + '.bmp');
  end;

  Refresco;

  Result := ScreenShot.IndexOf(Element);

  if (Result.X > 0) and (Result.Y > 0) then begin

    Result := Application.MainForm.ClientToScreen(Result);

  end;

  Refresco;

end;

procedure TInstagramRobot.WriteScreenshot(const Value: TBitmap);
begin
  FScreenshot.Assign(Value);
end;

end.
