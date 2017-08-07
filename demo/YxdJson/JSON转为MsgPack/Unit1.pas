unit Unit1;

interface

uses
  YxdJson, YxdStr, YxdRtti,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Button2: TButton;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
  Writer: TSerializeWriter;
begin
  Json := JSONBase.Parser(Memo1.Text);
  try
    Writer := JSONBase.GetSerializeWriter as TSerializeWriter;
    TYxdSerialize.Serialize(Writer, Json);
    Memo2.Text := Writer.ToString;
  finally
    Json.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Json: JSONBase;
  Writer: TSerializeWriter;
begin
  Json := JSONBase.Parser(Memo1.Text);
  try
    Writer := JSONBase.GetSerializeWriter as TSerializeWriter;
    TYxdSerialize.Serialize(Writer, Json);
    if SaveDialog1.Execute(Handle) then
      Writer.SaveToFile(SaveDialog1.FileName);
  finally
    Json.Free;
  end;
end;

end.
