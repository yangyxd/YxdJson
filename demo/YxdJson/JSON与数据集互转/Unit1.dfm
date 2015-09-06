object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 747
  ClientWidth = 1120
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
    Left = 0
    Top = 343
    Width = 1120
    Height = 9
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 456
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 105
    Width = 1120
    Height = 238
    Align = alClient
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1120
    Height = 105
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      1120
      105)
    object Label1: TLabel
      Left = 6
      Top = 10
      Width = 72
      Height = 13
      Caption = #27979#35797#25968#25454#24211#65306
    end
    object Button1: TButton
      Left = 8
      Top = 34
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'ToDataSet'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 87
      Top = 34
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'ToDataSet'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button4: TButton
      Left = 281
      Top = 34
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #21152#36733#25968#25454
      TabOrder = 2
      OnClick = Button4Click
    end
    object Button3: TButton
      Left = 168
      Top = 34
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'PutDataSet'
      TabOrder = 3
      OnClick = Button3Click
    end
    object Edit1: TEdit
      Left = 84
      Top = 7
      Width = 565
      Height = 21
      TabOrder = 4
      Text = 'E:\Users Folder\Desktop\db2.mdb'
    end
    object Button5: TButton
      Left = 362
      Top = 34
      Width = 75
      Height = 25
      Caption = #20445#23384'Data'
      TabOrder = 5
      OnClick = Button5Click
    end
    object CheckBox1: TCheckBox
      Left = 680
      Top = 9
      Width = 145
      Height = 17
      Caption = 'Base64 '#32534#30721' Blob'
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object Button7: TButton
      Left = 191
      Top = 65
      Width = 177
      Height = 25
      Caption = #19982#28784#32418'QDBJson'#21453#24207#21015#21270#23545#27604
      TabOrder = 7
      OnClick = Button7Click
    end
    object Button8: TButton
      Left = 384
      Top = 65
      Width = 153
      Height = 25
      Caption = #19982'AdoStream'#24207#21015#21270#23545#27604
      TabOrder = 8
      OnClick = Button8Click
    end
    object Button9: TButton
      Left = 543
      Top = 65
      Width = 162
      Height = 25
      Caption = #19982'AdoStream'#21453#24207#21015#21270#23545#27604
      TabOrder = 9
      OnClick = Button9Click
    end
  end
  object Button6: TButton
    Left = 8
    Top = 65
    Width = 177
    Height = 25
    Caption = #19982#28784#32418'QDBJson'#24207#21015#21270#23545#27604
    TabOrder = 2
    OnClick = Button6Click
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 352
    Width = 1120
    Height = 395
    ActivePage = TabSheet1
    Align = alBottom
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = 'YxdJson'
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 1112
        Height = 367
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        HideSelection = False
        Lines.Strings = (
          '{'
          '    "rows": ['
          '        {'
          '            "FInterID": 22087,'
          '            "FBillNo": "XSD20140722000441",'
          '            "FDate": "2014-07-11T00:00:00",'
          '            "FSupplyID": 36,'
          '            "FMerchandizerID": 5,'
          '            "FQCID": 5,'
          '            "FDelDate": "2013-12-31T00:00:00",'
          '            "FShipmentID": 10,'
          '            "FDocumentoryID": 5,'
          '            "FNote": "gh",'
          '            "FFilePath": "",'
          '            "FModifyTime": "1900-01-01T00:00:00",'
          '            "FProgramID": 0,'
          '            "FCreateUser": 1,'
          '            "techDate": null,'
          '            "loadingDate": null,'
          '            "factoryDelDate": null,'
          '            "FQty": null,'
          '            "Price": null,'
          '            "FQCID2": 1,'
          '            "FContact": "42",'
          '            "FTranType": 0,'
          '            "FPhone": "12",'
          '            "FAddress": "",'
          '            "FSupplierName": "321",'
          '            "MerchandizerName": "13",'
          '            "FQCName": "13",'
          '            "FDocumentoryName": "13",'
          '            "FShipmentName": "[blobs]<123456>"'
          '        },'
          '        {'
          '            "FInterID": 22124,'
          '            "FBillNo": "XSD20140722000447",'
          '            "FDate": "2014-07-22T00:00:00",'
          '            "FSupplyID": 36,'
          '            "FMerchandizerID": 5,'
          '            "FQCID": 5,'
          '            "FDelDate": "2014-07-24T00:00:00",'
          '            "FShipmentID": 0,'
          '            "FDocumentoryID": 5,'
          '            "FNote": "",'
          '            "FFilePath": "",'
          '            "FModifyTime": "1900-01-01T00:00:00",'
          '            "FProgramID": 0,'
          '            "FCreateUser": 1,'
          '            "techDate": "2014-07-10T00:00:00",'
          '            "loadingDate": "2014-07-24T00:00:00",'
          '            "factoryDelDate": "2014-07-31T00:00:00",'
          '            "FQty": 321,'
          '            "Price": 17859,'
          '            "FQCID2": 1,'
          '            "FContact": "37",'
          '            "FTranType": 0,'
          '            "FPhone": "2",'
          '            "FAddress": "12312",'
          '            "FSupplierName": "321",'
          '            "MerchandizerName": "13",'
          '            "FQCName": "13",'
          '            "FDocumentoryName": "13",'
          '            "FShipmentName": null'
          '        }'
          '    ],'
          '    "total": 2'
          '}'
          '')
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
        OnKeyDown = Memo1KeyDown
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'QDBJson'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Memo2: TMemo
        Left = 0
        Top = 0
        Width = 1112
        Height = 367
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        HideSelection = False
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
  end
  object Button10: TButton
    Left = 462
    Top = 34
    Width = 107
    Height = 25
    Caption = #35835#21462'Json'#25991#20214
    TabOrder = 4
    OnClick = Button10Click
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 280
    Top = 104
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 312
    Top = 104
  end
  object OpenDialog1: TOpenDialog
    Filter = '*.json|*.json;*.txt|*.*|*.*'
    Left = 280
    Top = 160
  end
  object FindDialog1: TFindDialog
    OnShow = FindDialog1Show
    Options = [frDown, frHideMatchCase, frHideWholeWord, frHideUpDown]
    OnFind = FindDialog1Find
    Left = 312
    Top = 160
  end
end
