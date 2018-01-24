object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'JSON Checker  - '#21487#25302#20837#27979#35797'Json'#25991#20214
  ClientHeight = 582
  ClientWidth = 1022
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 553
    Top = 41
    Width = 4
    Height = 522
    ExplicitTop = 0
    ExplicitHeight = 690
  end
  object Memo1: TMemo
    Left = 0
    Top = 41
    Width = 553
    Height = 522
    Align = alLeft
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    HideSelection = False
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    ExplicitHeight = 649
  end
  object Memo2: TMemo
    Left = 557
    Top = 41
    Width = 465
    Height = 522
    Align = alClient
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    HideSelection = False
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
    ExplicitWidth = 559
    ExplicitHeight = 649
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1022
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitLeft = 424
    ExplicitTop = 256
    ExplicitWidth = 185
    object Label1: TLabel
      Left = 694
      Top = 14
      Width = 49
      Height = 13
    end
    object Label2: TLabel
      Left = 366
      Top = 15
      Width = 60
      Height = 13
      Caption = #35299#26512#27425#25968#65306
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 13
      Width = 97
      Height = 17
      Caption = #20005#26684#27169#24335
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 99
      Top = 13
      Width = 97
      Height = 17
      Caption = 'JSON Time'
      TabOrder = 1
      OnClick = CheckBox2Click
    end
    object Button1: TButton
      Left = 515
      Top = 10
      Width = 129
      Height = 25
      Caption = #35299#26512' Json'
      TabOrder = 2
      OnClick = Button1Click
    end
    object CheckBox3: TCheckBox
      Left = 188
      Top = 13
      Width = 74
      Height = 17
      Caption = #21387#32553
      TabOrder = 3
    end
    object Edit1: TEdit
      Left = 432
      Top = 12
      Width = 63
      Height = 21
      TabOrder = 4
      Text = '1'
    end
    object CheckBox4: TCheckBox
      Left = 252
      Top = 13
      Width = 85
      Height = 17
      Caption = 'Unicode'#36716#30721
      TabOrder = 5
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 563
    Width = 1022
    Height = 19
    Panels = <
      item
        Width = 500
      end>
    ExplicitLeft = 568
    ExplicitTop = 304
    ExplicitWidth = 0
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 640
    Top = 320
  end
end
