unit Unit1;

{$mode objfpc}{$H+}

interface

uses
   Windows, Messages, Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    procedure WMCopyData(var Msg:TWMCopyData); message WM_COPYDATA;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}
 function tostr(d:Double; dok:Integer) : string;
begin
  if d < 1e20 then Result := FloatToStrF(d, fffixed, 15, dok) else result := '';
end;

 procedure TForm1.WMCopyData(var Msg: TWMCopyData);


var
  sText: array[0..199] of Char;
  s, nr, kod, x, y, z : string;
  xx, yy : Double;
  err, n : Integer;

begin
  if integer(Msg.CopyDataStruct.dwData)=0 then
    begin
      Edit5.Text:='OK';
    end //else

end;


function FindCGEO: HWND;
var
  hWndTemp: hWnd;
  iLenText: Integer;
  cTitletemp: array [0..254] of Char;
  sTitleTemp: string;
begin
  result := 0;
  hWndTemp := FindWindow(nil, nil);
  while hWndTemp <> 0 do begin
    iLenText := GetWindowText(hWndTemp, cTitletemp, 255);
    sTitleTemp := cTitletemp;
    sTitleTemp := UpperCase(copy( sTitleTemp, 1, iLenText));
    if pos( ' PROJEKT:', sTitleTemp ) <> 0 then Break;
    hWndTemp := GetWindow(hWndTemp, GW_HWNDNEXT);
  end;
  result := hWndTemp;
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
   Edit4.Clear;
   Edit4.Text:=ParamStr(4);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
x,y,h:string;
xd,yd,hd:single;
begin
      x:=Edit1.Text;
      y:=Edit2.Text;
      h:=Edit3.Text;
      xd:=StrToFloat(x);
      yd:=StrToFloat(y);
      hd:=StrToFloat(h);

end;

procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

 begin
end.

