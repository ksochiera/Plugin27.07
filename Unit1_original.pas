unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  mshtml, Dialogs, StdCtrls, Buttons, ComCtrls, OleCtrls, SHDocVw;

type  arr_geo_t = array[0..5000] of packed record nr:string[15]; x,y,z:double; k : string[10]; end;
      parr_geo_t = ^arr_geo_t;


type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Edit5: TEdit;
    Label6: TLabel;
    Edit6: TEdit;
    Label7: TLabel;
    Edit7: TEdit;
    Label8: TLabel;
    Edit8: TEdit;
    Label9: TLabel;
    Edit9: TEdit;
    Label10: TLabel;
    Edit10: TEdit;
    Label11: TLabel;
    Edit11: TEdit;
    Label12: TLabel;
    Edit12: TEdit;
    SpeedButton1: TSpeedButton;
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Memo2: TMemo;
    Button3: TButton;
    Memo3: TMemo;
    GroupBox1: TGroupBox;
    ed_par: TEdit;
    Label13: TLabel;
    ed_find: TEdit;
    SpeedButton2: TSpeedButton;
    BitBtn1: TBitBtn;
    RichEdit1: TRichEdit;
    BitBtn2: TBitBtn;
    WebBrowser1: TWebBrowser;
    GroupBox2: TGroupBox;
    CheckBox1: TCheckBox;
    Edit13: TEdit;
    CheckBox2: TCheckBox;
    procedure WMCopyData(var Msg: TWMCopyData); message WM_COPYDATA;
    procedure Edit1Exit(Sender: TObject);
    procedure oblicz;
    procedure Edit5Exit(Sender: TObject);
    procedure odczytaj_pkt(nr:string);
    procedure Edit2Exit(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
    pkt : parr_geo_t;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function tostr(d:Double; dok:Integer) : string;
begin
  if d < 1e20 then Result := FloatToStrF(d, fffixed, 15, dok) else result := '';
end;

procedure TForm1.WMCopyData(var Msg: TWMCopyData);
//odczyt komunikatu zwrotnego z c-geo z danymi punktu - format:
// nr#9kod#9x#9y#9z
//Msg.CopyDataStruct.dwData - oznaczenia:
//0-odbior punktu
//1-odbior zaznaczonych w tabeli roboczej punktow

var
  sText: array[0..199] of Char;
  s, nr, kod, x, y, z : string;
  xx, yy : Double;
  err, n : Integer;


procedure wyslij_na_mape_kolko_krzyzyk(s:string);
var aCopyData: TCopyDataStruct;
    ss : string;
    nr, kod, x, y, z : string;
begin
    nr := Copy(s, 1, Pos(#9, s)-1);  Delete(s, 1, Pos(#9, s));
    kod := Copy(s, 1, Pos(#9, s)-1);  Delete(s, 1, Pos(#9, s));
    x := Copy(s, 1, Pos(#9, s)-1);  Delete(s, 1, Pos(#9, s));
    y := Copy(s, 1, Pos(#9, s)-1);  Delete(s, 1, Pos(#9, s));
    z := Copy(s, 1, Pos(#9, s)-1);  Delete(s, 1, Pos(#9, s));

    with aCopyData do //narysuj kolko w miejscu klikniecia
    begin
      ss := 'e('+x+';'+y+')(5;0)';
      dwData := 3;
      cbData := StrLen(PChar(ss)) + 1;
      lpData := PChar(ss);
    end;

    SendMessage(StrToInt(paramstr(4)), WM_COPYDATA, Longint(Handle), Longint(@aCopyData));
    Val(x,xx, err);
    Val(y,yy, err);
    with aCopyData do //narysuj krzyzyk w miejscu klikniecia linia 1
    begin
      ss := 'o('+tostr(xx+5,2)+';'+tostr(yy-5,2)+')('+tostr(xx-5,2)+';'+tostr(yy+5,2)+')';
      dwData := 3;
      cbData := StrLen(PChar(ss)) + 1;
      lpData := PChar(ss);
    end;

    SendMessage(StrToInt(paramstr(4)), WM_COPYDATA, Longint(Handle), Longint(@aCopyData));
    with aCopyData do //narysuj krzyzyk w miejscu klikniecia linia 2
    begin
      ss := 'o('+tostr(xx+5,2)+';'+tostr(yy+5,2)+')('+tostr(xx-5,2)+';'+tostr(yy-5,2)+')';
      dwData := 3;
      cbData := StrLen(PChar(ss)) + 1;
      lpData := PChar(ss);
    end;

    SendMessage(StrToInt(paramstr(4)), WM_COPYDATA, Longint(Handle), Longint(@aCopyData));


end;

begin
  if integer(Msg.CopyDataStruct.dwData) = 8 then //przyszla informacja ze user wybral narzedzie z mapy i tryb wysylania wspolrzednych klikniecia zostal wylaczony
    begin
      CheckBox1.checked := false;
    end else


  if integer(Msg.CopyDataStruct.dwData) = 7 then //przyszly wspó³rzêdne klikniêcia na mapie
    begin
      s := PChar(Msg.copyDataStruct.lpData);
      Edit13.Text := s;
      if CheckBox2.checked then wyslij_na_mape_kolko_krzyzyk(s);
    end else

  if integer(Msg.CopyDataStruct.dwData) = 2 then //przyszedl obiekt z mapy
    begin
      s := PChar(Msg.copyDataStruct.lpData);
      memo2.Text := s;
    end else

  if integer(Msg.CopyDataStruct.dwData) = 1 then //przyszly punkty zaznaczone w tabeli roboczej
    begin
      Memo1.Lines.clear;
      pkt := Msg.CopyDataStruct.lpData;
      for n := 0 to 5000 do
       begin
        if pkt^[n].nr = '' then Break;
        Memo1.Lines.Add(pkt^[n].nr+' '+pkt^[n].k+' '+tostr(pkt^[n].x,2)+' '+tostr(pkt^[n].y,2)+' '+tostr(pkt^[n].z,3));
       end;
    end else //przyszly wspolrzedne punktu

    begin
        StrLCopy(sText, Msg.CopyDataStruct.lpData, Msg.CopyDataStruct.cbData);
        s := stext;
        nr := Copy(s, 1, Pos(#9, s)-1);  Delete(s, 1, Pos(#9, s));
        kod := Copy(s, 1, Pos(#9, s)-1);  Delete(s, 1, Pos(#9, s));
        x := Copy(s, 1, Pos(#9, s)-1);  Delete(s, 1, Pos(#9, s));
        y := Copy(s, 1, Pos(#9, s)-1);  Delete(s, 1, Pos(#9, s));
        z := Copy(s, 1, Pos(#9, s)-1);  Delete(s, 1, Pos(#9, s));

        if edit1.text = nr then // sprawdzenie czy to co przyszlo dotyczy pkt1 czy pkt2
         begin
           edit2.text := x;
           edit3.text := y;
           edit4.text := z;
           Edit5.SetFocus;
         end else
         begin
           edit6.text := x;
           edit7.text := y;
           edit8.text := z;
           Edit9.SetFocus;
         end;
        oblicz;
    end;
end;

procedure TForm1.oblicz;

function policz_srednia(s1, s2:string):string;
var w1, w2, wsr : double;
    err1, err2 : integer;

begin
   //zamiana , na .
  if Pos(',', s1) > 0 then s1[Pos(',', s1)] := '.';
  if Pos(',', s2) > 0 then s2[Pos(',', s2)] := '.';
  Val(s1, w1, err1);
  Val(s2, w2, err2);
  if (err1=0) and (err2=0) then
   begin
     wsr := (w1+w2) / 2;
     Str(wsr:0:3, result);
   end else Result := '';

end;

begin
  Edit10.Text := policz_srednia(Edit2.Text, Edit6.Text);
  Edit11.Text := policz_srednia(Edit3.Text, Edit7.Text);
  Edit12.Text := policz_srednia(Edit4.Text, Edit8.Text);
end;

procedure TForm1.odczytaj_pkt(nr:string);
var aCopyData: TCopyDataStruct;
begin
//do zmiennej przekazywanej w komunikacie wstawiamy numer punktu do odczytania z bazy
  with aCopyData do
  begin
    dwData := 0;
    cbData := StrLen(PChar(nr)) + 1;
    lpData := PChar(nr);
  end;
  SendMessage(StrToInt(paramstr(4)), WM_COPYDATA, Longint(Handle), Longint(@aCopyData));
//w paramstr(4) wtyczka dostaje uchwyt do okna c-geo
end;

procedure TForm1.Edit1Exit(Sender: TObject);

begin
  if Edit1.Text <> '' then odczytaj_pkt(edit1.Text);
end;

procedure TForm1.Edit5Exit(Sender: TObject);
begin
  if Edit5.Text <> '' then odczytaj_pkt(edit5.Text);
end;

procedure TForm1.Edit2Exit(Sender: TObject);
begin
 oblicz;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var aCopyData: TCopyDataStruct;
    s:string;
begin
 if Edit9.Text <> '' then
  begin
    with aCopyData do
    begin
      s := '!'+Edit9.text; //funkcja zapisu wymaga aby na poczatku numeru byl znak! - nie jest on zapisywany do bazy
      s := s+#9+#9+edit10.Text+#9+edit11.text+#9+edit12.Text;
      dwData := 0;
      cbData := StrLen(PChar(s)) + 1;
      lpData := PChar(s);
    end;
    SendMessage(StrToInt(paramstr(4)), WM_COPYDATA, Longint(Handle), Longint(@aCopyData));

  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var aCopyData: TCopyDataStruct;
    s : string;
begin
    with aCopyData do
    begin
      s := '';
      dwData := 1;
      cbData := StrLen(PChar(s)) + 1;
      lpData := PChar(s);
    end;
    SendMessage(StrToInt(paramstr(4)), WM_COPYDATA, Longint(Handle), Longint(@aCopyData));
end;

procedure TForm1.Button2Click(Sender: TObject);
var aCopyData: TCopyDataStruct;
    s : string;
begin
    with aCopyData do
    begin
      s := '';
      dwData := 2;
      cbData := StrLen(PChar(s)) + 1;
      lpData := PChar(s);
    end;
    SendMessage(StrToInt(paramstr(4)), WM_COPYDATA, Longint(Handle), Longint(@aCopyData));
end;

procedure TForm1.Button3Click(Sender: TObject);
var aCopyData: TCopyDataStruct;
    s : string;
begin
    with aCopyData do
    begin
      s := Memo3.Text;
      dwData := 3;
      cbData := StrLen(PChar(s)) + 1;
      lpData := PChar(s);
    end;
    SendMessage(StrToInt(paramstr(4)), WM_COPYDATA, Longint(Handle), Longint(@aCopyData));
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



procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  ed_find.Text := IntToStr(FindCGEO);
end;

procedure TForm1.FormCreate(Sender: TObject);
var Flags: OleVariant;
begin
 ed_par.Text := ParamStr(4);
 if FileExists(ExtractFilePath(Application.ExeName)+'\raport.rtf') then
  RichEdit1.Lines.LoadFromFile(ExtractFilePath(Application.ExeName)+'\raport.rtf');
 if FileExists(ExtractFilePath(Application.ExeName)+'\raport.html') then
  begin
    Flags := Flags or navNoReadFromCache or navNoWriteToCache;
    WebBrowser1.Navigate('file://' + ExtractFilePath(Application.ExeName)+'raport.html', Flags);
  end;

end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var aCopyData: TCopyDataStruct;
    s : string;

function GetRTF(RE: TRichedit): string;
var
   strStream: TStringStream;
begin
   strStream := TStringStream.Create('') ;
   try
     RE.PlainText := False;
     RE.Lines.SaveToStream(strStream) ;
     Result := strStream.DataString;
   finally
     strStream.Free
   end;
end;

begin
    with aCopyData do
    begin
      s := 'Przyk³ad raportu z pliku RTF'+#9+GetRTF(RichEdit1); //nazwa raportu umieszczany jest opcjonalnie przed raportem (oddzielony znakiem #9)
      dwData := 4;
      cbData := StrLen(PChar(s)) + 1;
      lpData := PChar(s);
    end;
    SendMessage(StrToInt(paramstr(4)), WM_COPYDATA, Longint(Handle), Longint(@aCopyData));
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var aCopyData: TCopyDataStruct;
    s : string;

function GetHTML(WebBrowser: TWebBrowser): string;
var
    iall : IHTMLElement; //uses mshtml;
begin
   if Assigned(WebBrowser.Document) then
   begin
     iall := (WebBrowser.Document AS IHTMLDocument2).body;
     while iall.parentElement <> nil do
     begin
       iall := iall.parentElement;
     end;
     result := iall.outerHTML;
   end;
end;

begin
    with aCopyData do
    begin
      s := 'Przyk³ad raportu z pliku HTML'+#9+GetHTML(WebBrowser1); //nazwa raportu umieszczany jest opcjonalnie przed raportem (oddzielony znakiem #9)
      dwData := 5;
      cbData := StrLen(PChar(s)) + 1;
      lpData := PChar(s);
    end;
    SendMessage(StrToInt(paramstr(4)), WM_COPYDATA, Longint(Handle), Longint(@aCopyData));
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
var aCopyData: TCopyDataStruct;
    s : string;
begin
  if CheckBox1.Checked then
   begin
    with aCopyData do
    begin
      s := '';
      dwData := 6;
      cbData := StrLen(PChar(s)) + 1;
      lpData := PChar(s);
    end;
    SendMessage(StrToInt(paramstr(4)), WM_COPYDATA, Longint(Handle), Longint(@aCopyData));

   end;
end;

end.
