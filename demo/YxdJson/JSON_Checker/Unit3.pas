unit Unit3;

interface

uses
  YxdJson, YxdStr,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    Memo2: TMemo;
    Button1: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label1: TLabel;
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

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
  T := TThread.GetTickCount;
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
      T := TThread.GetTickCount - T;
      Label1.Text := Format('”√ ±: %dms', [T]);
      Memo2.Lines.Text := S;
    end;
  except
    ShowMessage(Exception(ExceptObject).Message);
  end;
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  JsonNameAfterSpace := CheckBox1.IsChecked;
end;

procedure TForm1.CheckBox2Change(Sender: TObject);
begin
  StrictJson := CheckBox2.IsChecked;
end;

end.
