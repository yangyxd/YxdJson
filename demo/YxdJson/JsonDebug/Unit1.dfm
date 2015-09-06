object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'JSON To Record  (RTTI'#27979#35797')'
  ClientHeight = 382
  ClientWidth = 796
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object mmo1: TMemo
    Left = 104
    Top = 0
    Width = 692
    Height = 382
    Align = alRight
    Lines.Strings = (
      
        '{"Sess_Id":"","Sess_Ids":"","ID":"{326A2635-4AEC-480F-A772-C746E' +
        '801BA60}","Sender_ID":"{8EE3965B-C598-4854-A9CA-483DBE34FE8B}","' +
        'Sender_Name":"'#26031#29595#29305#26234#24935#37202#24215'","Groups":"","Title":"","Msg_Info":"'#27426#36814#30331#24405#26412#37202 +
        #24215#26234#24935#31649#29702#31995#32479#65281#35831#24744#29992#25163#26426#25511#21046#26412#23458#25151#37324#30340#26234#33021#37202#24215#35774#22791#65281'","Msg_Type":"mtInnerUser","Send_Type' +
        '":"stLogin","SEND_START_TIME":"08:30:00.000","SEND_End_TIME":"20' +
        ':00:00.000",'
      
        '"Weeks":127,"Timers":"[\"08:00:00\",\"11:30:00\",\"20:30:00\"]",' +
        '"Timers_Delay":30,"Create_Time":"2014-06-16T14:20:53.000","Start' +
        '_Time":"2014-06-16","End_Time":"2015-06-16","Using":true}')
    ScrollBars = ssBoth
    TabOrder = 0
    ExplicitTop = 48
    ExplicitHeight = 334
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 90
    Height = 25
    Caption = 'JsonToRecord'
    TabOrder = 1
    OnClick = ToRecordClick
  end
  object Button2: TButton
    Left = 8
    Top = 39
    Width = 90
    Height = 25
    Caption = 'RecordToJson'
    TabOrder = 2
    OnClick = Button2Click
  end
end
