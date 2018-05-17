unit Unit1;

interface

uses
  YxdJson, YxdStr, ShellAPI,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, SynEdit, SynMemo, Menus;

type
  TForm1 = class(TForm)
    Splitter1: TSplitter;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Button1: TButton;
    CheckBox3: TCheckBox;
    Label2: TLabel;
    Edit1: TEdit;
    CheckBox4: TCheckBox;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    CheckBox5: TCheckBox;
    Memo1: TSynMemo;
    Memo2: TSynMemo;
    chkR: TCheckBox;
    chkW: TCheckBox;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    R1: TMenuItem;
    X1: TMenuItem;
    C1: TMenuItem;
    P1: TMenuItem;
    C2: TMenuItem;
    N3: TMenuItem;
    A1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    W1: TMenuItem;
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure R1Click(Sender: TObject);
    procedure X1Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure P1Click(Sender: TObject);
    procedure C2Click(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure W1Click(Sender: TObject);
    procedure Memo1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
  public
    { Public declarations }
    function FocusEdit(): TSynMemo;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.A1Click(Sender: TObject);
begin
  FocusEdit.SelectAll;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Json: JSONBase;
  T: Cardinal;
  I, J, M: Integer;
  B: Boolean;
  S, V: string;
begin
  J := StrToIntDef(Edit1.Text, 1);
  M := 0;
  if not CheckBox3.Checked then
    M := 4;
  B := CheckBox4.Checked;
  V := Memo1.Text;
  S := '';    
  try
    Json := nil;
    T := 0;
    try
      if chkR.Checked and chkW.Checked then begin
      
        T := GetTickCount;
        for I := 0 to J - 1 do begin
          Json := JSONBase.Parser(V);
          S := Json.ToString(M, B);
          FreeAndNil(Json);
        end;
        T := GetTickCount - T;

      end else if chkR.Checked then begin

        T := GetTickCount;
        for I := 0 to J - 1 do begin
          FreeAndNil(Json);
          Json := JSONBase.Parser(V);
        end;
        T := GetTickCount - T;
        S := Json.ToString(M, B);

      end else begin

        Json := JSONBase.Parser(V);
        T := GetTickCount;
        for I := 0 to J - 1 do
          S := Json.ToString(M, B);
        T := GetTickCount - T;

      end;
    finally
      FreeAndNil(Json);
      StatusBar1.Panels.Items[1].Text := Format('用时: %dms', [T]);
      Memo2.Lines.Text := S;
    end;
  except
    MessageBox(Handle, PChar(Exception(ExceptObject).Message), '错误', 48);
  end;
end;

procedure TForm1.C1Click(Sender: TObject);
begin
  FocusEdit.CopyToClipboard;
end;

procedure TForm1.C2Click(Sender: TObject);
begin
  FocusEdit.Clear;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  YxdJson.StrictJson := TCheckBox(Sender).Checked;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  if TCheckBox(Sender).Checked then
    YxdJson.JsonDateFormatStyle := jdsJsonTime
  else
    YxdJson.JsonDateFormatStyle := jdsNormal;
end;

procedure TForm1.CheckBox5Click(Sender: TObject);
begin
  JsonNameAfterSpace := CheckBox5.Checked;
end;

function TForm1.FocusEdit: TSynMemo;
begin
  if Memo1.Focused then
    Result := Memo1
  else
    Result := Memo2;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DragAcceptFiles(Handle, True);
  JsonNameAfterSpace := True;
end;

procedure TForm1.Memo1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (not TSynMemo(Sender).Focused) and (TSynMemo(Sender).CanFocus) then
    TSynMemo(Sender).SetFocus;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
  FocusEdit.Undo;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
  FocusEdit.ClearAll;
end;

procedure TForm1.P1Click(Sender: TObject);
begin
  FocusEdit.PasteFromClipboard;
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
var
  Edit: TSynMemo;
begin
  Edit := FocusEdit;
  try
    N1.Enabled := Edit.CanUndo;
    R1.Enabled := Edit.CanRedo;
    X1.Enabled := Edit.SelLength > 0;
    C1.Enabled := X1.Enabled;
    P1.Enabled := Edit.CanPaste;
    W1.Checked := Edit.WordWrap;
  except
  end;
end;

procedure TForm1.R1Click(Sender: TObject);
begin
  FocusEdit.Redo;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  O: TSynMemo;
begin
  if Memo1.Focused then
    O := Memo1
  else if Memo2.Focused then
    O := Memo2
  else
    Exit;
  StatusBar1.Panels.Items[0].Text := Format('列: %d 当前选择：%d', [O.CaretX, O.SelLength]);
end;

procedure TForm1.W1Click(Sender: TObject);
begin
  FocusEdit.WordWrap := not FocusEdit.WordWrap;
end;

procedure TForm1.WMDropFiles(var Msg: TWMDropFiles);
var
  i, iNumberDropped: Integer;
  FileNameA: array[0..MAX_PATH - 1] of AnsiChar;
  Point: TPoint;
  S: string;
  V: TFileStream;
begin
  iNumberDropped := DragQueryFile(THandle(Msg.Drop), Cardinal(-1), nil, 0);
  DragQueryPoint(THandle(Msg.Drop), Point);
  for i := 0 to iNumberDropped - 1 do begin
    DragQueryFileA(THandle(Msg.Drop), i, FileNameA, sizeof(FileNameA));
    S := string(FileNameA);
    V := TFileStream.Create(S, 0);
    try
      S := YxdStr.LoadTextA(V);
      Memo1.Lines.Text := S;
    finally
      V.Free;
    end;
    Break;
  end;
end;

procedure TForm1.X1Click(Sender: TObject);
begin
  FocusEdit.CutToClipboard;
end;

end.
