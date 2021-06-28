unit BitmapHelper;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  Vcl.Graphics;

type TArrayColors = array of array of TColor;


type TBitmapHelper = class helper for TBitmap
  private
    function Compare(A1, A2: TArrayColors): boolean;
    function CopyPiece(Source, Target: TArrayColors; Pos: TPoint): TArrayColors;
  public
    function ToArray: TArrayColors;
    function IndexOf(Bitmap: TBitmap): TPoint;
end;

implementation

{ TScreenShot }

function TBitmapHelper.Compare(A1, A2: TArrayColors): boolean;
var
  X, Y: Integer;
begin

  Result := false;

  if Length(A1) or Length(A1[0]) <= 0 then Abort;
  if Length(A2) or Length(A2[0]) <= 0 then Abort;
  if Length(A1)    <>  Length(A2)     then Abort;
  if Length(A1[0]) <>  Length(A2[0])  then Abort;

  Result := true;

  for X := 0 to Pred(Length(A1)) do begin
    for Y := 0 to Pred(Length(A1[x])) do
      if (A1[x,y] <> A2[x,y]) then begin
        Result := false;
        break;
      end;

    if not Result then Break;
  end;

end;

function TBitmapHelper.CopyPiece(Source, Target: TArrayColors;
  Pos: TPoint): TArrayColors;
var
  x, y: integer;
begin

  SetLength(Result, Length(Target), Length(Target[0]));

  for x := 0 to Pred(Length(Target)) do
    for y := 0 to Pred(Length(Target[0])) do
      Result[x,y] := Source[ Pos.x + x, Pos.y + y ];

end;

function TBitmapHelper.IndexOf(Bitmap: TBitmap): TPoint;
var
  Source, Target, SourcePiece: TArrayColors;
  TargetWidth, TargetHeight: Integer;
  SourceWidth, SourceHeight: Integer;
  PointOfPiece: TPoint;
  X, Y: Integer;
begin

  Result.X := -1;
  Result.Y := -1;

  Target := Bitmap.ToArray();
  Source := Self.ToArray();

  SourceWidth  := Length(Source);
  SourceHeight := Length(Source[0]);

  TargetWidth  := Length(Target);
  TargetHeight := Length(Target[0]);

  if TargetWidth  <= 0 then Abort;
  if TargetHeight <= 0 then Abort;

  if SourceWidth  < TargetWidth  then Abort;
  if SourceHeight < TargetHeight then Abort;

  for X := 0 to SourceWidth - TargetWidth do
    for Y := 0 to Length(Source[x]) - TargetHeight do begin

      if Source[x,y] = Target[0,0] then begin

        PointOfPiece.x := x;
        PointOfPiece.Y := y;

        SourcePiece := CopyPiece(Source, Target, PointOfPiece );

        if Compare(SourcePiece, Target) then begin
          Result := PointOfPiece;
          Break;
        end;

      end;

    end;
end;

function TBitmapHelper.ToArray: TArrayColors;
var
  X, Y: Integer;
begin
  SetLength(Result,Self.width,Self.height);

  for X := 0 to Pred(Self.Width) do
    for Y := 0 to Pred(Self.Height) do
      Result[X,Y] := Self.Canvas.Pixels[X,Y];
end;

end.
