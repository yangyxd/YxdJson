object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'QJson & YxdJson Cmp Demo'
  ClientHeight = 497
  ClientWidth = 899
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
    Left = 481
    Top = 105
    Height = 392
    ExplicitLeft = 456
    ExplicitTop = 184
    ExplicitHeight = 100
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 899
    Height = 105
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    OnClick = Panel1Click
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 117
      Height = 25
      Caption = #21019#24314' 100000 '#32467#28857
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 140
      Top = 8
      Width = 117
      Height = 25
      Caption = #28155#21152#32467#28857
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 273
      Top = 8
      Width = 117
      Height = 25
      Caption = #21152#36733#25991#20214
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 406
      Top = 8
      Width = 117
      Height = 25
      Caption = #20445#23384#21040#25991#20214
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 539
      Top = 8
      Width = 117
      Height = 25
      Caption = #35299#26512#25991#26412
      TabOrder = 4
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 672
      Top = 8
      Width = 75
      Height = 25
      Caption = 'RTTI'#36816#34892#26102
      TabOrder = 5
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 8
      Top = 39
      Width = 117
      Height = 25
      Caption = #27969#24335#21152#36733
      TabOrder = 6
      OnClick = Button7Click
    end
    object Button8: TButton
      Left = 140
      Top = 39
      Width = 117
      Height = 25
      Caption = #25968#32452
      TabOrder = 7
      OnClick = Button8Click
    end
    object Button10: TButton
      Left = 273
      Top = 39
      Width = 117
      Height = 25
      Caption = 'For..In'
      TabOrder = 8
      OnClick = Button10Click
    end
    object Button11: TButton
      Left = 406
      Top = 39
      Width = 117
      Height = 25
      Caption = #25353#36335#24452#36171#20540
      TabOrder = 9
      OnClick = Button11Click
    end
    object Button12: TButton
      Left = 539
      Top = 39
      Width = 117
      Height = 25
      Caption = #26597#25214
      TabOrder = 10
      OnClick = Button12Click
    end
    object Button9: TButton
      Left = 672
      Top = 39
      Width = 75
      Height = 25
      Caption = 'XXXXIf'
      TabOrder = 11
      OnClick = Button9Click
    end
    object Button13: TButton
      Left = 760
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Invoke'
      TabOrder = 12
      OnClick = Button13Click
    end
    object Button14: TButton
      Left = 760
      Top = 39
      Width = 75
      Height = 25
      Caption = 'd2007 RTTI'
      TabOrder = 13
      OnClick = Button14Click
    end
    object Button15: TButton
      Left = 8
      Top = 70
      Width = 117
      Height = 25
      Caption = #32534#30721#27979#35797
      TabOrder = 14
      OnClick = Button15Click
    end
    object Button16: TButton
      Left = 140
      Top = 70
      Width = 117
      Height = 25
      Caption = 'TryParse'
      TabOrder = 15
      OnClick = Button16Click
    end
    object Button17: TButton
      Left = 273
      Top = 70
      Width = 75
      Height = 25
      Caption = 'Button17'
      TabOrder = 16
      OnClick = Button17Click
    end
  end
  object mmResult: TMemo
    Left = 0
    Top = 105
    Width = 481
    Height = 392
    Hint = 'QJson '#27979#35797#32467#26524
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
    ParentFont = False
    ParentShowHint = False
    ScrollBars = ssBoth
    ShowHint = True
    TabOrder = 1
  end
  object mmResult2: TMemo
    Left = 484
    Top = 105
    Width = 415
    Height = 392
    Hint = 'YxdJson '#27979#35797#32467#26524
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
    ParentFont = False
    ParentShowHint = False
    ScrollBars = ssBoth
    ShowHint = True
    TabOrder = 2
  end
  object OpenDialog1: TOpenDialog
    Left = 104
    Top = 144
  end
  object SaveDialog1: TSaveDialog
    Left = 40
    Top = 144
  end
end
