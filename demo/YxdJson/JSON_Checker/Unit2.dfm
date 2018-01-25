object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 704
  ClientWidth = 1092
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 41
    Width = 585
    Height = 663
    Align = alLeft
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
    ExplicitTop = 0
    ExplicitHeight = 704
  end
  object Memo2: TMemo
    Left = 585
    Top = 41
    Width = 507
    Height = 663
    Align = alClient
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
    ExplicitLeft = 456
    ExplicitTop = 88
    ExplicitWidth = 577
    ExplicitHeight = 600
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1092
    Height = 41
    Align = alTop
    TabOrder = 2
    ExplicitLeft = 464
    ExplicitTop = 352
    ExplicitWidth = 185
    object Label1: TLabel
      Left = 24
      Top = 14
      Width = 31
      Height = 13
      Caption = 'Label1'
    end
    object Button1: TButton
      Left = 401
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
    object CheckBox5: TCheckBox
      Left = 511
      Top = 13
      Width = 106
      Height = 17
      Caption = 'Name'#21518#21152#31354#26684
      TabOrder = 1
      OnClick = CheckBox5Click
    end
  end
end
