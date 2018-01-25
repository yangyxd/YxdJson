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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1022
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label2: TLabel
      Left = 446
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
      Left = 94
      Top = 13
      Width = 97
      Height = 17
      Caption = 'JSON Time'
      TabOrder = 1
      OnClick = CheckBox2Click
    end
    object Button1: TButton
      Left = 595
      Top = 10
      Width = 129
      Height = 25
      Caption = #35299#26512' Json'
      TabOrder = 2
      OnClick = Button1Click
    end
    object CheckBox3: TCheckBox
      Left = 175
      Top = 13
      Width = 74
      Height = 17
      Caption = #21387#32553
      TabOrder = 3
    end
    object Edit1: TEdit
      Left = 512
      Top = 12
      Width = 63
      Height = 21
      TabOrder = 4
      Text = '1'
    end
    object CheckBox4: TCheckBox
      Left = 231
      Top = 13
      Width = 85
      Height = 17
      Caption = 'Unicode'#36716#30721
      TabOrder = 5
    end
    object CheckBox5: TCheckBox
      Left = 319
      Top = 13
      Width = 106
      Height = 17
      Caption = 'Name'#21518#21152#31354#26684
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = CheckBox5Click
    end
    object chkR: TCheckBox
      Left = 752
      Top = 13
      Width = 81
      Height = 17
      Caption = #35299#26512#27979#35797
      Checked = True
      State = cbChecked
      TabOrder = 7
    end
    object chkW: TCheckBox
      Left = 832
      Top = 13
      Width = 81
      Height = 17
      Caption = #32534#30721#27979#35797
      Checked = True
      State = cbChecked
      TabOrder = 8
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
      end
      item
        Width = 300
      end>
  end
  object Memo1: TSynMemo
    Left = 0
    Top = 41
    Width = 553
    Height = 522
    Align = alLeft
    Ctl3D = True
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 2
    Gutter.AutoSize = True
    Gutter.Color = 15400872
    Gutter.BorderColor = 14548848
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Gutter.LeftOffset = 4
    Gutter.ShowLineNumbers = True
    Gutter.Width = 4
    Options = [eoAutoIndent, eoDragDropEditing, eoEnhanceEndKey, eoGroupUndo, eoScrollPastEol, eoSmartTabDelete, eoSmartTabs, eoTabsToSpaces]
    RightEdgeColor = 14548848
    FontSmoothing = fsmNone
  end
  object Memo2: TSynMemo
    Left = 557
    Top = 41
    Width = 465
    Height = 522
    Align = alClient
    Ctl3D = True
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 3
    Gutter.AutoSize = True
    Gutter.Color = 15400872
    Gutter.BorderColor = 14548848
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Gutter.LeftOffset = 4
    Gutter.ShowLineNumbers = True
    Gutter.Width = 4
    Options = [eoAutoIndent, eoDragDropEditing, eoEnhanceEndKey, eoGroupUndo, eoScrollPastEol, eoSmartTabDelete, eoSmartTabs, eoTabsToSpaces]
    RightEdgeColor = 14548848
    FontSmoothing = fsmNone
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 640
    Top = 320
  end
end
