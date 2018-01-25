unit Unit2;

interface

uses
  YxdJson, YxdStr,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    Panel1: TPanel;
    Button1: TButton;
    Label1: TLabel;
    CheckBox5: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Json: JSONBase;
  T: Cardinal;
  I, J, M: Integer;
  B: Boolean;
  S, V: string;
begin
  J := 1;
  M := 4;
  B := True;
  V := Memo1.Text;
  S := '';
  T := GetTickCount;
  try
    Json := nil;
    try
      for I := 0 to J - 1 do begin
        Json := JSONBase.Parser(V);
        S := Json.ToString(M, B);
        FreeAndNil(Json);
      end;
    finally
      FreeAndNil(Json);
      T := GetTickCount - T;
      Label1.Caption := Format('”√ ±: %dms', [T]);
      Memo2.Lines.Text := S;
    end;
  except
    MessageBox(Handle, PChar(Exception(ExceptObject).Message), '¥ÌŒÛ', 48);
  end;
end;

procedure TForm1.CheckBox5Click(Sender: TObject);
begin
  JsonNameAfterSpace := CheckBox5.Checked;
end;

end.
