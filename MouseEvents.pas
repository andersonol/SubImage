unit MouseEvents;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes;

type
  TMouseEvents = class
  public
    class procedure Move(Point: TPoint);
    class procedure Click(Point: TPoint);
    class procedure DoubleClick(Point: TPoint);
  end;

implementation

{ TMouseEvents }

class procedure TMouseEvents.Click(Point: TPoint);
begin
  Mouse_Event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN, Point.x, Point.y, 0, 0);
  Sleep(100);
  Mouse_Event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP  , Point.x, Point.y, 0, 0);
end;

class procedure TMouseEvents.DoubleClick(Point: TPoint);
begin

  Click(Point);
  Sleep(100);
  Click(Point);

end;

class procedure TMouseEvents.Move(Point: TPoint);
begin
  SetCursorPos( Point.x, Point.y);
end;

end.
