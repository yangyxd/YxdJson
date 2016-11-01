unit Unit1;

interface

uses
  StrUtils, YxdAdoStream,
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, DB, ADODB, ActiveX, Grids,
  DBGrids, DBClient, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    ClientDataSet1: TClientDataSet;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    Button3: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Splitter1: TSplitter;
    CheckBox1: TCheckBox;
    Button6: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Memo1: TMemo;
    TabSheet2: TTabSheet;
    Memo2: TMemo;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    OpenDialog1: TOpenDialog;
    FindDialog1: TFindDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FindDialog1Show(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
var
  // 软件所在位置
  SoftPath: string;

implementation

{$R *.dfm}


uses YxdJson{$IFDEF UNICODE}, uQDBJson{$ENDIF};

type
  TJsonArrayHelper = class helper for JSONArray
  public
    procedure ToDataSet2(DataSet: TClientDataSet);
  end;

  { TJsonArrayHelper }

procedure TJsonArrayHelper.ToDataSet2(DataSet: TClientDataSet);
var
  ii, j: Integer;
  lItem: JSONObject;
  lValue: PJSONValue;
  lList: TStringList;
  lName: string;
begin

  with DataSet do
  begin
    FieldDefs.Clear;
    Close;

    if self.count - 1 < 0 then
      Exit;

    lList := TStringList.Create;
    lItem := self.getJsonObject(0);

    for ii := 0 to lItem.count - 1 do
      lList.Add(lItem.Items[ii].FName); // 把所有已知字段填充到List里

    // 循环队例直到队列结束
    while lList.count - 1 >= 0 do
    begin

      for ii := 0 to self.count - 1 do
      begin
        lItem := self.getJsonObject(ii);
        for j := 0 to lItem.count - 1 do
        begin
          lValue := lItem.Items[j];

          // 如果字段存在就跳过
          if FieldDefs.IndexOf(lValue.FName) >= 0 then
            Continue;

          case lValue.FType of
            jdtString:
              FieldDefs.Add(lValue.FName, ftString, 200);
            jdtInteger:
              FieldDefs.Add(lValue.FName, ftInteger);
            jdtFloat:
              FieldDefs.Add(lValue.FName, ftFloat);
            jdtBoolean:
              FieldDefs.Add(lValue.FName, ftBoolean);
            jdtDateTime:
              FieldDefs.Add(lValue.FName, ftDateTime);
          end;

          // 如果已知类型从队列中移除
          if lValue.FType in [jdtString, jdtInteger, jdtFloat, jdtBoolean, jdtDateTime] then
          begin
            lList.Delete(lList.IndexOf(lValue.FName));
          end;

        end;
      end;
    end;

    // 如果队例中还有字段
    for lName in lList do
    begin
      if Length(lName) > 0 then
        FieldDefs.Add(lName, ftVariant);
    end;


    CreateDataSet;
    for ii := 0 to self.count - 1 do
    begin
      lItem := self.getJsonObject(ii);

      Append;

      for j := 0 to lItem.count - 1 do
      begin
        lValue := lItem.Items[j];
        case lValue.FType of
          jdtString:
            FieldByName(lValue.FName).AsString := lValue.AsString;
          jdtInteger:
            FieldByName(lValue.FName).AsInteger := lValue.AsInteger;
          jdtFloat:
            FieldByName(lValue.FName).AsFloat := lValue.AsFloat;
          jdtBoolean:
            FieldByName(lValue.FName).AsBoolean := lValue.AsBoolean;
          jdtDateTime:
            FieldByName(lValue.FName).AsDateTime := lValue.AsDateTime;
          jdtNull:
            FieldByName(lValue.FName).AsVariant := Null;
        end;
      end;

      post;
    end;

    lList.Free;
  end;
end;

procedure TForm1.Button10Click(Sender: TObject);
var
  json: JSONObject;
  I: Integer;
  t: Cardinal;
begin
  if OpenDialog1.Execute(Self.Handle) then begin
    t := GetTickCount;
    json := JSONObject.Create;
    try
      json.LoadFromFile(OpenDialog1.FileName);
      Memo1.Text := json.ToString(4);
      I := json.ToDataSet(ClientDataSet1);
    finally
      json.Free;
    end;
    t := GetTickCount - t;
    ShowMessage(Format('%s'#13'文件加载成功, 共有%d行数据, 用时 %dms.',
      [OpenDialog1.FileName, i, t]));
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  lObject: JSONObject;
  lArray: JSONArray;
begin
  lObject := JSONObject.parseObject(Memo1.Text);
  lArray := lObject.getJsonArray('rows');
  lArray.ToDataSet(ClientDataSet1);
  lObject.Free;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  lObject: JSONObject;
  t: Cardinal;
begin
  lObject := JSONObject.ParseObject(Memo1.Text);
  t := GetTickCount;
  lObject.ToDataSet(ClientDataSet1);
  t := GetTickCount - t;
  lObject.Free;
  ShowMessage('ToDataSet ' + IntToStr(t) + 'ms.');
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  lObject: JSONObject;
begin
  lObject := JSONObject.Create;
  //lObject.PutDataSet('', ClientDataSet1);
  lObject.PutDataSet('', ClientDataSet1, 0, 0, CheckBox1.Checked);
  Memo1.Text := lObject.ToString(4);
  lObject.Free;
end;

var
  Conn: TADOConnection = nil;  //数据库对象
function GetLinkStr(const dbFile: string): string;
begin
  Result := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+dbFile+';Persist Security Info=False';
end;

procedure UnitADO(var Rs: TADOQuery);
begin
  try
    if Rs <> nil then begin
      Rs.Close;  FreeAndNil(Rs);
    end;
  except
  end;
  FreeAndNil(Conn);
end;

procedure InitADO(var Rs: TADOQuery);
begin
  UnitADO(Rs);
  CoInitialize(Form1);
  Conn := TADOConnection.Create(Form1);
  Conn.ConnectionString := GetLinkStr(Form1.Edit1.Text);
  Conn.Open;
  Rs := TADOQuery.Create(Form1);
  Rs.Connection := Conn;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  Rs: TADOQuery;
  JSON: JSONObject;
  t: Cardinal;
begin
  try
    InitADO(Rs);
    t := GetTickCount;
    JSON := JSONObject.Create;
    Rs.SQL.Text := 'Select * from TBApp';
    Rs.Open;
    Json.PutDataSet('', Rs, 0, 0, CheckBox1.Checked);
    t := GetTickCount - t;
    Memo1.Text := Json.ToString(4);
    ShowMessage('PutDataSet ' + IntToStr(t) + 'ms.');
  finally
    Rs.SaveToFile(SoftPath + 'tbapp_ado.xml', pfXML);
    UnitADO(Rs);
    FreeAndNil(JSON);
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if not ClientDataSet1.Active then begin
    ShowMessage('请先加载数据, 并点击 ToDataSet 反序列化.');
    Exit;
  end;
  if ClientDataSet1.RecordCount > 0 then begin
    TBlobField(ClientDataSet1.FieldByName('Data')).SavetoFile(SoftPath +
      ClientDataSet1.FieldByName('Name').AsString);
    ShowMessage('已经输出文件：' + SoftPath +
      ClientDataSet1.FieldByName('Name').AsString);
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  Rs: TADOQuery;
  JSON: JSONObject;
  {$IFDEF UNICODE}QDBJson: TQDBJson; {$ENDIF}
  t, t1: Cardinal;
  s{$IFDEF UNICODE},s1{$ENDIF}: string;
begin
  try
    InitADO(Rs);
    Rs.SQL.Text := 'Select * from TBApp';
    Rs.Open;
    Rs.First;

    try
      t := GetTickCount;
      JSON := JSONObject.Create;
      Json.PutDataSet('', Rs, 0, 0, CheckBox1.Checked);
      s := Json.ToString(4);
      t := GetTickCount - t;
    finally
      FreeAndNil(JSON);
    end;

    {$IFDEF UNICODE}
    Rs.First;
    try
      t1 := GetTickCount;
      QDBJson := TQDBJson.Create;
      QDBJson.DataSet2Json(Rs, True, True, False, CheckBox1.Checked, 0, 0, [], True);
      s1 := QDBJson.ToString;
      t1 := GetTickCount - t1;
    finally
      FreeAndNil(QDBJson);
    end;
    {$ENDIF}

    Memo1.Text := s;
    {$IFDEF UNICODE}
    Memo2.Text := s1;
    {$ELSE}
    t1 := 0;
    {$ENDIF}
    ShowMessage(Format('序列化对比：'#13'YxdJson %dms.'#13'QDBJson %dms.', [t, t1]));
  finally
    UnitADO(Rs);
  end;
end;

procedure TForm1.Button7Click(Sender: TObject);
{$IFDEF UNICODE}
var
  lObject: TQDBJson;
  t: Cardinal;
begin
  t := GetTickCount;
  TQDBJson.Json2DataSet(ClientDataSet1, Memo1.Text, nil);
  t := GetTickCount - t;
  lObject.Free;
  ShowMessage('TQDBJson.Json2DataSet ' + IntToStr(t) + 'ms.');
{$ELSE}
begin
{$ENDIF}
end;

procedure TForm1.Button8Click(Sender: TObject);
var
  Rs: TADOQuery;
  JSON: JSONObject;
  M: TMemoryStream;
  t, t1, t2: Cardinal;
  s, s1: string;
  i: Integer;
begin
  try
    InitADO(Rs);
    Rs.SQL.Text := 'Select * from TBApp';
    Rs.Open;
    Rs.First;

    try
      t := GetTickCount;
      JSON := JSONObject.Create;
      for i := 0 to 100 do begin
        json.Clear;
        Json.PutDataSet('', Rs, 0, 0, CheckBox1.Checked);
      end;
      json.SaveToFile(SoftPath + 'tbapp.json');
      t := GetTickCount - t;
      s := Json.ToString(4);
      JSON.Parse(S);
      JSON.ToDataSet(ClientDataSet1);
    finally
      FreeAndNil(JSON);
    end;

    Rs.First;
    try
      t1 := GetTickCount;
      M := TMemoryStream.Create;
      for i := 0 to 100 do begin
        M.Clear;
        YxdAdoStream.DataSetToStream(Rs, M);
      end;
      m.SaveToFile(SoftPath + 'tbapp.data');
      t1 := GetTickCount - t1;
    finally
      FreeAndNil(M);
    end;

    ClientDataSet1.First;
    t2 := GetTickCount;
    for i := 0 to 100 do begin
      s1 := '';
      s1 := ClientDataSet1.XMLData;
    end;
    ClientDataSet1.SaveToFile(SoftPath + 'tbapp.xml', dfXML);
    t2 := GetTickCount - t2;


    Memo1.Text := s;
    Memo2.Text := s1;
    ShowMessage(Format('序列化对比：'#13'YxdJson %dms.'#13'AdoStream %dms.'#13+
      'ClientDataSet1.XMLData %dms.', [t, t1, t2]));
  finally
    UnitADO(Rs);
  end;
end;

procedure TForm1.Button9Click(Sender: TObject);
var
  Rs: TADOQuery;
  JSON: JSONObject;
  M: TMemoryStream;
  t, t1, t2: Cardinal;
  s, s1: string;
  i: Integer;
begin
  DBGrid1.Visible := False;
  try
  try
    InitADO(Rs);
    Rs.SQL.Text := 'Select * from TBApp';
    Rs.Open;
    Rs.First;

    try
      JSON := JSONObject.Create;
      Json.PutDataSet('', Rs, 0, 0, CheckBox1.Checked);
      s := Json.ToString;
      t := GetTickCount;
      for i := 1 to 100 do begin
        json.ToDataSet(ClientDataSet1);
      end;
      t := GetTickCount - t;
    finally
      FreeAndNil(JSON);
    end;

    M := TMemoryStream.Create;
    YxdAdoStream.DataSetToStream(Rs, M);

  finally
    UnitADO(Rs);
  end;

  Rs := TADOQuery.Create(Self);
  try
    t1 := GetTickCount;
    for i := 1 to 100 do begin
      M.Position := 0;
      YxdAdoStream.StreamToDataSet(M, Rs);
    end;
    t1 := GetTickCount - t1;
  finally
    FreeAndNil(M);
    Rs.Free;
  end;

  ClientDataSet1.First;
  s1 := ClientDataSet1.XMLData;
  t2 := GetTickCount;
  ClientDataSet1.DisableControls;
  for i := 1 to 100 do begin
    ClientDataSet1.XMLData := s1;
  end;
  ClientDataSet1.EnableControls;
  t2 := GetTickCount - t2;
  ClientDataSet1.SaveToFile(SoftPath + 'tbapp.xml', dfXML);

  ShowMessage(Format('反序列化对比：'#13'YxdJson %dms.'#13'AdoStream %dms.'#13+
    'ClientDataSet1.XMLData %dms.', [t, t1, t2]));
  finally
    DBGrid1.Visible := True;
  end;
end;

procedure TForm1.FindDialog1Find(Sender: TObject);
var
  I: Integer;
begin
  I := PosEx(FindDialog1.FindText, Memo1.Text, Memo1.SelStart + 2);
  if I > 0 then begin
    Memo1.SelStart := I - 1;
    Memo1.SelLength := Length(FindDialog1.FindText);
  end;
end;

procedure TForm1.FindDialog1Show(Sender: TObject);
begin
  FindDialog1.FindText := Memo1.SelText;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.Text := SoftPath + 'db2.mdb';
  OpenDialog1.InitialDir := SoftPath;
end;

procedure TForm1.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = Ord('F')) then begin
    FindDialog1.Execute(Self.Handle);
  end;
end;

initialization
  SoftPath := ExtractFilePath(ParamStr(0));

end.
