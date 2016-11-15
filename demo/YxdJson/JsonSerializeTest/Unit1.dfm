object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 509
  ClientWidth = 766
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    766
    509)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 48
    Width = 72
    Height = 13
    Caption = #25968#25454#24211#36830#25509#65306
  end
  object Label2: TLabel
    Left = 8
    Top = 72
    Width = 60
    Height = 13
    Caption = #26597#35810#35821#21477#65306
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = #26657#39564
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 96
    Width = 750
    Height = 130
    Anchors = [akLeft, akTop, akRight]
    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Memo2: TMemo
    Left = 8
    Top = 256
    Width = 750
    Height = 245
    Anchors = [akLeft, akTop, akRight, akBottom]
    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object CheckBox1: TCheckBox
    Left = 128
    Top = 13
    Width = 73
    Height = 17
    Caption = #32553#36827
    TabOrder = 3
  end
  object CheckBox2: TCheckBox
    Left = 213
    Top = 13
    Width = 73
    Height = 17
    Caption = #36716#30721
    TabOrder = 4
  end
  object Button2: TButton
    Left = 288
    Top = 8
    Width = 90
    Height = 25
    Caption = #23545#35937#24207#21015#21270
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 384
    Top = 8
    Width = 90
    Height = 25
    Caption = 'Record'#24207#21015#21270
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 480
    Top = 8
    Width = 90
    Height = 25
    Caption = 'DataSet '#24207#21015#21270
    TabOrder = 7
    OnClick = Button4Click
  end
  object Edit1: TEdit
    Left = 86
    Top = 45
    Width = 539
    Height = 21
    TabOrder = 8
    Text = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=testdb.mdb;Persist ' +
      'Security Info=False'
  end
  object Edit2: TEdit
    Left = 86
    Top = 69
    Width = 539
    Height = 21
    TabOrder = 9
    Text = 'Select * from Users'
  end
  object Button5: TButton
    Left = 576
    Top = 8
    Width = 113
    Height = 25
    Caption = 'DataSet '#21453#24207#21015#21270
    TabOrder = 10
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 8
    Top = 229
    Width = 60
    Height = 25
    Caption = #20132#25442
    TabOrder = 11
    OnClick = Button6Click
  end
  object ADODataSet1: TADODataSet
    Parameters = <>
    Left = 376
    Top = 264
  end
end
