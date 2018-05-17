object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'JSON Checker  - '#21487#25302#20837#27979#35797'Json'#25991#20214
  ClientHeight = 654
  ClientWidth = 1128
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
    Height = 594
    ExplicitTop = 0
    ExplicitHeight = 690
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1128
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 1022
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
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
    Top = 635
    Width = 1128
    Height = 19
    Panels = <
      item
        Width = 500
      end
      item
        Width = 300
      end>
    ExplicitTop = 563
    ExplicitWidth = 1022
  end
  object Memo1: TSynMemo
    Left = 0
    Top = 41
    Width = 553
    Height = 594
    Align = alLeft
    Ctl3D = True
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    PopupMenu = PopupMenu1
    TabOrder = 2
    OnMouseDown = Memo1MouseDown
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
    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
    Options = [eoAutoIndent, eoAutoSizeMaxScrollWidth, eoDragDropEditing, eoEnhanceEndKey, eoGroupUndo, eoSmartTabDelete, eoSmartTabs, eoTabsToSpaces, eoTrimTrailingSpaces]
    RightEdgeColor = 14548848
    WordWrap = True
    FontSmoothing = fsmNone
    ExplicitLeft = -2
    ExplicitTop = 39
    ExplicitHeight = 522
  end
  object Memo2: TSynMemo
    Left = 557
    Top = 41
    Width = 571
    Height = 594
    Align = alClient
    Ctl3D = True
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    PopupMenu = PopupMenu1
    TabOrder = 3
    OnMouseDown = Memo1MouseDown
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
    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
    Options = [eoAutoIndent, eoAutoSizeMaxScrollWidth, eoDragDropEditing, eoEnhanceEndKey, eoGroupUndo, eoSmartTabDelete, eoSmartTabs, eoTabsToSpaces]
    RightEdgeColor = 14548848
    FontSmoothing = fsmNone
    ExplicitWidth = 465
    ExplicitHeight = 522
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 640
    Top = 320
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 480
    Top = 264
    object N1: TMenuItem
      Caption = #25764#28040'(&U)'
      OnClick = N1Click
    end
    object R1: TMenuItem
      Caption = #37325#20570'(&R)'
      OnClick = R1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Caption = #26032#24314'(&N)'
      OnClick = N5Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object X1: TMenuItem
      Caption = #21098#20999'(&X)'
      OnClick = X1Click
    end
    object C1: TMenuItem
      Caption = #22797#21046'(&C)'
      OnClick = C1Click
    end
    object P1: TMenuItem
      Caption = #31896#36148'(&P)'
      OnClick = P1Click
    end
    object C2: TMenuItem
      Caption = #28165#31354'(&C)'
      OnClick = C2Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object A1: TMenuItem
      Caption = #20840#36873'(&A)'
      OnClick = A1Click
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object W1: TMenuItem
      Caption = #33258#21160#25442#34892'(&W)'
      OnClick = W1Click
    end
  end
end
