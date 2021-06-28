unit KeyboardEvents;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes;


type TKeyboardEvents = class
  public
    class procedure Write(text: string);

end;

implementation

uses
  ClipBrd;

{ TKeyboardEvents }

class procedure TKeyboardEvents.Write(text: string);
const
  VK_V: Integer = 86;
begin
  Clipboard.AsText := text;

  keybd_event(VK_CONTROL, 0, KEYEVENTF_EXTENDEDKEY or 0, 0);
  keybd_event(VK_V, 0, 0, 0);
  keybd_event(VK_CONTROL, $45, KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP, 0);


end;

end.
