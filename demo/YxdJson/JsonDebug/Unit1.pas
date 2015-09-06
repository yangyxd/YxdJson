unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    mmo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    procedure ToRecordClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses yxdjson, YxdRtti; //, YxdPersistent;

{$R *.dfm}
type
  // 推送消息
  // 0:无; 1:登记发送,2:注销登记，3:登录，4:登出;5:定时;6:间隔，7:服务触发
  TSend_Type = (stNone, stRegister, stUnRegister, stLogin, stLogout, stTimer,
    stInterval, stService);
  // 消息类型
  TMsg_Type = (mtInnerSys, mtInnerUser, mtSvcSys, mtSvcUser);
TAppMsg = record
    Sess_Id: string; // 记录sessID，在需要时候才赋值
    Sess_Ids:string;// 多个sessionID，用在投递线程，避免循环过多的线程
    ID: string; // 消息唯一ID
    Sender_ID: string; // 发送人ID
    Sender_Name: string; // 发送人名称
    Groups: string; // 消息分组名称
    Title: string; // 消息标题
    Msg_Info: string; // 消息信息
    Msg_Type: TMsg_Type; // 消息类型
    Send_Type: TSend_Type; // 发送类型
    SEND_START_TIME: TTime; // 发送起始和截止时间
    SEND_End_TIME: TTime; // 发送起始和截止时间
    Weeks: Integer; // 周1，周2，，，，周7，全选 为 127，不选择为0
    Timers: string; // JSON字符串
    Timers_Delay: Integer; // 定时延迟
    Create_Time: TDateTime;
    Start_Time: TDateTime; // 有效起始时间
    End_Time: TDateTime; // 有效截止时间
    Using: Boolean; // 使用
end;


procedure TForm1.Button2Click(Sender: TObject);
var
  Msg: TAppMsg;
  Json: JSONObject;
begin
  FillChar(Msg, SizeOf(Msg), 0);
  Msg.Msg_Info := '消息信息';
  Msg.ID := '0001';
  Msg.Sender_Name := 'RecordToJson Test';
  Json := JSONObject.Create;
  try
    Json.PutRecord<TAppMsg>('Msg', Msg);
    ShowMessage(Json.ToString);
  finally
    Json.Free;
  end;
end;

procedure TForm1.ToRecordClick(Sender: TObject);
var
  json:JSONObject;
  AppMsg:TAppMsg;
  t: Cardinal;
  i: Integer;
begin
  json:=JSONObject.Create;
  json.Parse(mmo1.Text);
  //json.ToRecord<TAppMsg>(AppMsg);
  t := GetTickCount;
  for I := 0 to 100000 do
    json.ToRecord<TAppMsg>(AppMsg);
  t := GetTickCount - t;
  ShowMessage(AppMsg.Msg_Info);
  ShowMessage(Format('%d 次, 用时 %dms', [i, t]));
  json.Free;
end;

end.
