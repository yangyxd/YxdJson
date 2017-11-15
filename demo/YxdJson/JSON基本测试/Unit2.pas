unit Unit2;

interface

{$WARNINGS OFF}

uses
  YxdStr,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus,
  {$IF (RTLVersion>=26)}Vcl.ComCtrls{$ELSE}ComCtrls{$IFEND};

type
  TForm2 = class(TForm)
    YxdPageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Memo1: TMemo;
    TabSheet2: TTabSheet;
    Memo2: TMemo;
    TabSheet3: TTabSheet;
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Button10: TButton;
    Button11: TButton;
    OpenDialog1: TOpenDialog;
    Button12: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Memo3: TMemo;
    Memo4: TMemo;
    Button13: TButton;
    CheckBox3: TCheckBox;
    Button14: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses
  YxdJson, qjson, uLkJSON, QString;

const
  STJSONSTR = '{"carno":"京A12345","city":0,"cjhm":"","ctype":"其他","cubage":0,'+
    '"devno":"916704270865","dphone":"13058126562","driver":"杨东","dw":32,"h":0,'+
    '"id":2,"laddr":"","lat":0,"lbstime":"2014-07-03 19:38:36","length":25,"line"'+
    ':"河北,内蒙古,吉林,上海","link":"","lng":114.045173888889,"lphone":"","ltel":'+
    '"","public":false,"remark":"","sno":"","state":3,"time":"2014-07-22 08:53:45","w":0,"yyzs":""}';
procedure TForm2.Button10Click(Sender: TObject);
var
  json: YxdJson.JSONObject;
begin
  json := YxdJson.JSONObject.parseObject(STJSONSTR);
  try
    json.getDouble('length');
  finally
    json.Free;
  end;
  ListBox1.Items.Add(YxdJson.JSONObject.parseStringByName(STJSONSTR, 'dphone'));
end;

procedure TForm2.Button11Click(Sender: TObject);
var
  json: JSONObject;
  t: Cardinal;
begin
  if OpenDialog1.Execute(Self.Handle) then begin
    t := GetTickCount;
    json := JSONObject.Create;
    try
      json.LoadFromFile(OpenDialog1.FileName);
      Memo2.Text := json.ToString(4);
    finally
      json.Free;
    end;
    t := GetTickCount - t;
    ShowMessage(Format('%s'#13'文件加载成功, 用时 %dms.',
      [OpenDialog1.FileName, t]));
  end;
end;

procedure TForm2.Button12Click(Sender: TObject);
var
  json: JSONArray;
  ja: JSONArray;
  i, allowAccess: Integer;
begin
  json := JSONArray.Create;
  try
    json.Parse(Memo2.Text);
    ShowMessage(json.ItemByPath('[0].[0].name').AsString);
    //ja := json.GetJsonObject('data').GetJsonArray('album');
    ja := json.ItemByPath('[0].[0]').AsJsonArray;
    for I := 0 to ja.Count - 1 do
      allowAccess := ja.GetJsonObject(i).GetInt('allowAccess');
  finally
    json.Free;
  end;
end;

procedure TForm2.Button13Click(Sender: TObject);
var
  json: YxdJson.Jsonbase;
begin
  json := YxdJson.Jsonbase.Parser(Memo1.Text);
  try
    Memo2.Text := json.toString(4);
    Memo2.Lines.Add(FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz', json.Items[0].AsJsonObject.GetDateTime('FEnterDateTime')));
  finally
    json.Free;
  end;
end;

procedure TForm2.Button14Click(Sender: TObject);
var
  json: JSONObject;
begin
  json := JSONObject.Create;
  json.PutDateTime('Time', Now);
  Memo2.Text := json.ToString(4);
  json.Free;
end;

procedure TForm2.Button16Click(Sender: TObject);
var
  json: JSONObject;
begin
  ShowMessage(YxdJson.JSONObject.ParseStringByName(Memo1.Text, 'name'));
  json := YxdJson.JSONObject.ParseObjectByName(Memo1.Text, 'name', 'resKey');
  if Assigned(json) then begin
    ShowMessage(json.ToString());
    FreeAndNil(json);
  end;
  Exit;
  ShowMessage(YxdJson.JSONObject.ParseStringByName(Memo1.Text, 'name'));
  ShowMessage(YxdJson.JSONObject.ParseStringByName(Memo1.Text, 'asa_id'));
  ShowMessage(YxdJson.JSONObject.ParseStringByName(Memo1.Text, 'price'));
  ShowMessage(YxdJson.JSONObject.ParseStringByName(Memo1.Text, 'not_receive'));
end;

procedure TForm2.Button17Click(Sender: TObject);
var
  json: JSONObject;
begin
  json := JSONObject.Create;
  json.AddChildObject('test');
  ShowMessage(json.ToString());
  json.Parse(json.ToString());
  ShowMessage(json.ToString());
  FreeAndNil(json);
end;

procedure TForm2.Button18Click(Sender: TObject);
var
  Json: YxdJson.JSONObject;
begin
  Json := YxdJson.JSONObject.Create;
  try
    json['aaa.error'].AsString := 'yangyxd';
    ShowMessage(json.ToString() + #13#10 + json['aaa'].AsString);
    ShowMessage(json.ToString() + #13#10 + json.S['aaa']);
  finally
    FreeAndNil(Json);
  end;
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  json: YxdJson.JSONBase;
begin
  json := YxdJson.JSONBase.Parser(Memo1.Text);
  try
    Memo2.Text := json.toString();   
    //ShowMessage(json[Edit1.Text].AsString);
  finally
    json.Free;
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  yjson: YxdJson.JSONObject;
  qjson: TQJson;
  t, t1: Cardinal;
  i, j: Integer;
  s, v, v1: string;
begin
  s := Memo1.Text;

  t := GetTickCount;
  for i := 0 to 20000 - 1 do begin
    yjson := YxdJson.JSONObject.parseObject(s);
    v := yjson.toString(4);
    yjson.Free;
  end;
  t := GetTickCount - t;


  t1 := GetTickCount;
  for j := 0 to 20000 - 1 do begin
    qjson := TQJSon.Create();
    qjson.parse(s);
    v1 := qjson.toString();
    qjson.Free;
  end;
  t1 := GetTickCount - t1;

  ListBox1.Items.Add(Format('YxdJson. count: %d, time: %dms.', [i, t]));
  ListBox1.Items.Add(Format('TQJson.  count: %d, time: %dms.', [j, t1]));
  //ListBox1.Items.Add(Format('UJson.   count: %d, time: %dms.', [m, t2]));
  //ListBox1.Items.Add(Format('uLkJSON. count: %d, time: %dms.', [n, t3]));
end;

procedure TForm2.Button3Click(Sender: TObject);
var
  json: YxdJson.Jsonbase;
begin
  json := YxdJson.Jsonbase.Parser(Memo1.Text);
  try
    Memo2.Text := json.toString(4);
  finally
    json.Free;
  end;
end;

procedure TForm2.Button4Click(Sender: TObject);
var
  yjson: YxdJson.JSONObject;
  qjson: TQJson;
  t, t1: Cardinal;
  i, j: Integer;
  s, v, v1: string;
begin
  s := Memo1.Text;

  t := GetTickCount;
  yjson := YxdJson.JSONObject.Create;
  for i := 0 to 20000 - 1 do begin
    yjson.put('test', 'string');
    yjson.putDateTime('time', Now);
    yjson.put('num', 9999);
    yjson.put('float', 8.88);
    yjson.putJSON('value', '{"results":[],"status":5,"msg":"AK Illegal or Not Exist:"}');
    yjson.getFloat('float');
    yjson.getString('test');
    yjson.getString('num');
    yjson.getInt('num');
    v := yjson.toString(4);
    //v := yjson.getJsonObject('value').Path;
    //Memo2.Text := v;
    yjson.Clear;
  end;
  yjson.Free;
  t := GetTickCount - t;

  t1 := GetTickCount;
  qjson := TQJSon.Create();
  for j := 0 to 20000 - 1 do begin
    qjson.add('test', 'string', jdtString);
    qjson.AddDateTime('time', Now);
    qjson.add('num', 9999);
    qjson.add('float', 8.88);
    qjson.add('value', '{"results":[],"status":5,"msg":"AK Illegal or Not Exist:"}');
    qjson.ItemByName('float').AsFloat;
    qjson.ItemByName('test').AsString;
    qjson.ItemByName('num').AsString;
    qjson.ItemByName('num').AsInteger;
    v1 := qjson.toString();
    //v1 := qjson.ItemByName('value').Path;
    qjson.Clear;
  end;
  qjson.Free;
  t1 := GetTickCount - t1;

  Memo2.Text := v;

  ListBox1.Items.Add(Format('YxdJson. count: %d, time: %dms.', [i, t]));
  ListBox1.Items.Add(Format('TQJson.  count: %d, time: %dms.', [j, t1]));
  //ListBox1.Items.Add(Format('UJson.   count: %d, time: %dms.', [m, t2]));
  //ListBox1.Items.Add(Format('uLkJSON. count: %d, time: %dms.', [n, t3]));
end;

procedure TForm2.Button5Click(Sender: TObject);
var
  json: TQJson;
begin
  json := TQJson.Create;
  try
    json.Parse(Memo1.Text);
    Memo2.Text := json.toString();
  finally
    json.Free;
  end;
end;

procedure TForm2.Button6Click(Sender: TObject);
var
  fname: string;
  yjson: YxdJson.JSONObject;
  json: TQJson;
  t, t1: Cardinal;
  I: Integer;
  v, v1: string;
begin
  fname := ExtractFilePath(Application.ExeName) + 'test.json';

  t := GetTickCount;
  for i := 0 to 1000 - 1 do begin
    yjson := YxdJson.JSONObject.Create;
    try
    yjson.LoadFromFile(fname);
    v := yjson.toString(4);
    yjson.SaveToFile(fname + '.yxdjson.json');
    finally
    yjson.Free;
    end;
  end;
  t := GetTickCount - t;

  t1 := GetTickCount;
  for i := 0 to 1000 - 1 do begin
    json := TQJson.Create;
    try
    json.LoadFromFile(fname);
    v1 := json.toString();
    json.SaveToFile(fname + '.qjson.json', {$IFDEF JSON_UNICODE}qstring.teUTF8{$ELSE}qstring.teAnsi{$ENDIF}, true);
    finally
    json.Free;
    end;
  end;
  t1 := GetTickCount - t1;

  Memo2.text := v;

  ListBox1.Items.Add(Format('YxdJson.LoadFromFile count: %d, time: %dms.', [i, t]));
  ListBox1.Items.Add(Format('TQJson. LoadFromFile count: %d, time: %dms.', [i, t1]));
end;

procedure TForm2.Button7Click(Sender: TObject);
var
  fname: string;
  qjson: TQJson;
begin
  fname := ExtractFilePath(Application.ExeName) + 'test.json';

  qjson := TQJson.Create;
  try
  qjson.LoadFromFile(fname);
  Memo2.Text := qjson.toString();
  finally
  qjson.Free;
  end;
end;

procedure TForm2.Button8Click(Sender: TObject);
var
  fname: string;
  yjson: YxdJson.JSONObject;
  t, t1, t2: Cardinal;
  I: Integer;
  v: string;
begin
  fname := ExtractFilePath(Application.ExeName) + 'Preferences.txt';
  t := GetTickCount;
  for i := 0 to 1 - 1 do begin
    yjson := YxdJson.JSONObject.Create;
    try
    yjson.LoadFromFile(fname);
    v := yjson.toString(4);
    t1 := GetTickCount - t;
    yjson.SaveToFile(fname + '.yxdjson.json');
    t2 := GetTickCount - t - t1;
    finally
    yjson.Free;
    end;
  end;
  t := GetTickCount - t;
  ListBox1.Items.add(Format('YJson 加载用时%dms, 保存用时%dms, 共计%dms', [t1, t2, t]));
  if CheckBox2.Checked then Memo2.Text := v;
end;

procedure TForm2.Button9Click(Sender: TObject);
var
  fname: string;
  json: TQJson;
  t, t1, t2: Cardinal;
  I: Integer;
  v: string;
begin
  fname := ExtractFilePath(Application.ExeName) + 'Preferences.txt';

  t := GetTickCount;
  for i := 0 to 1 - 1 do begin
    json := TQJson.Create;
    try
    json.LoadFromFile(fname);
    v := json.toString();
    t1 := GetTickCount - t;
    json.SaveToFile(fname + '.qjson.json', qstring.teAnsi, true);
    t2 := GetTickCount - t - t1;
    finally
    json.Free;
    end;
  end;
  t := GetTickCount - t;
  ListBox1.Items.add(Format('QJson 加载用时%dms, 保存用时%dms, 共计%dms', [t1, t2, t]));
  if CheckBox2.Checked then Memo2.Text := v;     
end;

procedure TForm2.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked then
    JsonDateFormatStyle := jdsJsonTime
  else
    JsonDateFormatStyle := jdsNormal;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  OpenDialog1.InitialDir := ExtractFilePath(ParamStr(0));
end;

procedure TForm2.N1Click(Sender: TObject);
begin
  ListBox1.Clear;
end;

end.
