unit Unit1;

interface

uses
  YxdJSON,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

type
  TDataValue = record
    Name: string;
    Age: Integer;
    Datas: array of string;
    Time: TDateTime;
  end;

procedure TForm1.Button1Click(Sender: TObject);

  function GetIndent: Integer;
  begin
    if CheckBox1.Checked then
      Result := 4
    else
      Result := 0;
  end;

var
  Json: JSONBase;
begin
  Json := JSONBase.Parser(Memo1.Text, False);
  if Assigned(Json) then
    Memo2.Text := Json.ToString(GetIndent, CheckBox2.Checked)
  else
    Memo2.Text := '';
  FreeAndNil(Json);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Memo2.Text := JSONObject.Serialize(Sender);
end;

procedure TForm1.Button3Click(Sender: TObject);
{$IFDEF UNICODE}
var
  Data: TDataValue;
  S: string;
  I: Integer;
  T, T1: Cardinal;
  Json: JSONObject;
{$ENDIF}
begin
  {$IFDEF UNICODE}
  Data.Name := '试试看';
  Data.Age := 25;
  SetLength(Data.Datas, 3);
  Data.Datas[0] := '123';
  Data.Datas[1] := '中文';
  Data.Datas[2] := 'abcdefd';
  Data.Time := Now;

  T1 := GetTickCount;
  for I := 0 to 100000 do begin
    Json := JSONObject.Create;
    Json.PutRecord<TDataValue>('', Data);
    S := Json.ToString;
    FreeAndNil(Json);
  end;
  T1 := GetTickCount - T1;

  T := GetTickCount;
  for I := 0 to 100000 do
    S := JSONObject.Serialize<TDataValue>(Data);
  T := GetTickCount - T;


  Memo2.Text := S;

  Memo2.Lines.Add(Format('Serialize: %dms, PutRecord: %dms.', [T, T1]))
  {$ELSE}
  Memo2.Text := '当前版本 IDE 不支持。';
  {$ENDIF}
end;

end.
