object Form1: TForm1
  Left = 638
  Top = 407
  Caption = 'Form1'
  ClientHeight = 686
  ClientWidth = 1027
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    1027
    686)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 89
    Height = 25
    Caption = #24207#21015#21270#27979#35797
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 39
    Width = 1011
    Height = 274
    Anchors = [akLeft, akTop, akRight]
    ScrollBars = ssBoth
    TabOrder = 1
    ExplicitWidth = 619
  end
  object Memo2: TMemo
    Left = 8
    Top = 319
    Width = 1011
    Height = 359
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 2
    ExplicitWidth = 619
    ExplicitHeight = 248
  end
  object Button2: TButton
    Left = 103
    Top = 8
    Width = 89
    Height = 25
    Caption = #24207#21015#21270#21040#25991#20214
    TabOrder = 3
    OnClick = Button2Click
  end
  object SaveDialog1: TSaveDialog
    Filter = #25152#26377#25991#20214'|*.*|JSON'#25991#20214'|*.txt;*.json'
    Left = 408
    Top = 288
  end
end
