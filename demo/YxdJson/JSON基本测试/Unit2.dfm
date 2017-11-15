object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'JSON '#24615#33021#27979#35797
  ClientHeight = 508
  ClientWidth = 939
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    939
    508)
  PixelsPerInch = 96
  TextHeight = 13
  object YxdPageControl1: TPageControl
    Left = 8
    Top = 208
    Width = 923
    Height = 292
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #28304'JSON'#25968#25454
      object Memo1: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 909
        Height = 258
        Align = alClient
        Lines.Strings = (
          '{'
          #9'"error": 0,'
          #9'"status": "success",'
          #9'"currentCity": "'#21271#20140'",'
          #9'"dateTime": "2014/07/12/11/29/38",'
          '"items": [1,2,3,4,5,6,7,8,9,[123,456,789]],'
          #9'"results": ['
          #9#9'{'
          #9#9#9'"startTime": "2014/02/26/00/00/00",'
          #9#9#9'"title": "'#20986#21475#21277#36947#38480#21046'('#38271#26399')",'
          
            #9#9#9'"description": "2014'#24180'2'#26376'26'#26085#36215#65292#27599#22825'7'#26102#33267'15'#26102#65292#21271#20845#29615#22806#29615#65292#20140#34255#39640#36895#20844#36335#20986#21475#21277#36947#65292#31105#27490#36733#36135#27773#36710#36890 +
            #34892#12290'",'
          #9#9#9'"location": {'
          #9#9#9#9'"lng": 116.2499668836,'
          #9#9#9#9'"lat": 40.172181392632'
          #9#9#9'},'
          #9#9#9'"type": "3"'
          #9#9'},'
          #9#9'{'
          #9#9#9'"title": "'#21271#19977#29615#35199#36335#36947#36335#26045#24037'",'
          
            #9#9#9'"description": "'#20174'7'#26376'3'#26085#21040'8'#26376'28'#26085#65292#33487#24030#26725#65292#22806#29615#26041#21521#65292#36827#34892#22823#20462#26045#24037#65292#26045#24037#26102#38388#20026#27599#22825#26202#38388'23'#26102'30'#20998#33267#20940 +
            #26216'5'#26102'30'#20998#65292#30333#22825#27491#24120#25918#34892#31038#20250#20132#36890'",'
          #9#9#9'"location": {'
          #9#9#9#9'"lng": 116.31302490979,'
          #9#9#9#9'"lat": 39.964084503915'
          #9#9#9'},'
          #9#9#9'"type": "2"'
          #9#9'}'
          #9']'
          '}')
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object CheckBox1: TCheckBox
        Left = 712
        Top = -48
        Width = 97
        Height = 17
        Caption = 'CheckBox1'
        TabOrder = 1
      end
    end
    object TabSheet2: TTabSheet
      Caption = #36755#20986#32467#26524
      object Memo2: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 909
        Height = 258
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object Memo4: TMemo
        Left = 584
        Top = -168
        Width = 185
        Height = 89
        Lines.Strings = (
          'Memo4')
        TabOrder = 1
      end
    end
    object TabSheet3: TTabSheet
      Caption = #26085#24535
      object ListBox1: TListBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 909
        Height = 258
        Align = alClient
        ItemHeight = 13
        PopupMenu = PopupMenu1
        TabOrder = 0
      end
      object Memo3: TMemo
        Left = 576
        Top = -144
        Width = 185
        Height = 89
        Lines.Strings = (
          'Memo3')
        TabOrder = 1
      end
    end
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 161
    Height = 25
    Caption = #35835#21462#28304'JSON, toString(0)'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 70
    Width = 161
    Height = 25
    Caption = #35835#21462#28304'JSON'#25968#25454'20000'#27425
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 39
    Width = 161
    Height = 25
    Caption = #35835#21462#28304'JSON, toString(4)'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 101
    Width = 161
    Height = 25
    Caption = #28155#21152#21024#38500#24615#33021#27979#35797
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 175
    Top = 70
    Width = 171
    Height = 25
    Caption = 'QJson'#35835#21462#28304'JSON, toString'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 8
    Top = 132
    Width = 161
    Height = 25
    Caption = #21152#36733'test.json'
    TabOrder = 6
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 8
    Top = 163
    Width = 161
    Height = 25
    Caption = 'QJson'#21152#36733'test.json'
    TabOrder = 7
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 175
    Top = 8
    Width = 171
    Height = 25
    Caption = 'yxdjson'#21152#36733'Preferences.txt'
    TabOrder = 8
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 175
    Top = 39
    Width = 171
    Height = 25
    Caption = 'qjson'#21152#36733'Preferences.txt'
    TabOrder = 9
    OnClick = Button9Click
  end
  object CheckBox2: TCheckBox
    Left = 262
    Top = 209
    Width = 179
    Height = 17
    Caption = #21152#36733#23436#25104#21518#26174#31034#21040#36755#20986#32467#26524
    TabOrder = 10
  end
  object Button10: TButton
    Left = 175
    Top = 101
    Width = 171
    Height = 25
    Caption = 'parseStringByName'
    TabOrder = 11
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 175
    Top = 132
    Width = 171
    Height = 25
    Caption = #21152#36733#25351#23450' json '#25991#20214
    TabOrder = 12
    OnClick = Button11Click
  end
  object Button12: TButton
    Left = 352
    Top = 70
    Width = 177
    Height = 25
    Caption = 'ItemByPath'
    TabOrder = 13
    OnClick = Button12Click
  end
  object Button16: TButton
    Left = 352
    Top = 8
    Width = 177
    Height = 25
    Caption = 'ParseObjectByName'
    TabOrder = 14
    OnClick = Button16Click
  end
  object Button17: TButton
    Left = 352
    Top = 39
    Width = 177
    Height = 25
    Caption = 'AddChildObject'
    TabOrder = 15
    OnClick = Button17Click
  end
  object Button18: TButton
    Left = 175
    Top = 163
    Width = 171
    Height = 25
    Caption = 'SuperJson'#29992#27861#27979#35797
    TabOrder = 16
    OnClick = Button18Click
  end
  object Button13: TButton
    Left = 588
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button13'
    TabOrder = 17
    OnClick = Button13Click
  end
  object CheckBox3: TCheckBox
    Left = 544
    Top = 105
    Width = 97
    Height = 17
    Caption = 'JSON Time'
    TabOrder = 18
    OnClick = CheckBox3Click
  end
  object Button14: TButton
    Left = 352
    Top = 101
    Width = 177
    Height = 25
    Caption = 'Json Time '#26684#24335#21270#36755#20986
    TabOrder = 19
    OnClick = Button14Click
  end
  object PopupMenu1: TPopupMenu
    Left = 520
    Top = 328
    object N1: TMenuItem
      Caption = #28165#31354
      OnClick = N1Click
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = '*.json|*.json;*.txt|*.*|*.*'
    Left = 432
    Top = 128
  end
end
