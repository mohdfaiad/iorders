object frmCCJS_OrderStatus: TfrmCCJS_OrderStatus
  Left = 14
  Top = 419
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1054#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1089#1090#1072#1090#1091#1089' '#1079#1072#1082#1072#1079#1072
  ClientHeight = 297
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 481
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlTop'
    TabOrder = 0
    object pnlTop_Order: TPanel
      Left = 0
      Top = 0
      Width = 131
      Height = 21
      Align = alLeft
      BevelInner = bvSpace
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object pnlTop_Price: TPanel
      Left = 131
      Top = 0
      Width = 131
      Height = 21
      Align = alLeft
      BevelInner = bvSpace
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object pnlTop_Client: TPanel
      Left = 262
      Top = 0
      Width = 219
      Height = 21
      Align = alClient
      Alignment = taLeftJustify
      BevelInner = bvSpace
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
  end
  object pnlTool: TPanel
    Left = 0
    Top = 271
    Width = 481
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlTool'
    TabOrder = 1
    object pnlTool_Bar: TPanel
      Left = 321
      Top = 0
      Width = 160
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object tlbarControl: TToolBar
        Left = 0
        Top = 0
        Width = 160
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 83
        EdgeBorders = []
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tlbtnOk: TToolButton
          Left = 0
          Top = 0
          Action = aMain_Ok
          AutoSize = True
        end
        object tlbtnExit: TToolButton
          Left = 87
          Top = 0
          Action = aMain_Exit
          AutoSize = True
        end
      end
    end
    object pnlTool_Show: TPanel
      Left = 0
      Top = 0
      Width = 321
      Height = 26
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlNote: TPanel
    Left = 0
    Top = 92
    Width = 481
    Height = 179
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    TabOrder = 2
    object mNote: TMemo
      Left = 1
      Top = 22
      Width = 479
      Height = 156
      Align = alClient
      BevelKind = bkFlat
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 500
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnChange = mNoteChange
    end
    object pnlCheckNote: TPanel
      Left = 1
      Top = 1
      Width = 479
      Height = 21
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlCheckNote'
      TabOrder = 1
      object pnlCheckNote_Count: TPanel
        Left = 392
        Top = 0
        Width = 87
        Height = 21
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
      end
      object pnlCheckNote_Status: TPanel
        Left = 0
        Top = 0
        Width = 392
        Height = 21
        Align = alClient
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '  '#1055#1088#1080#1084#1077#1095#1072#1085#1080#1077':'
        TabOrder = 1
      end
    end
  end
  object pnlFields: TPanel
    Left = 0
    Top = 21
    Width = 481
    Height = 71
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object pnlOrderStatus: TPanel
      Left = 0
      Top = 0
      Width = 481
      Height = 39
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lblOrderStatus: TLabel
        Left = 12
        Top = 20
        Width = 34
        Height = 13
        Caption = #1057#1090#1072#1090#1091#1089
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edOrderStatus: TEdit
        Left = 51
        Top = 13
        Width = 417
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        TabOrder = 0
        OnChange = edOrderStatusChange
        OnDblClick = aMain_SlOrderStatusExecute
      end
      object btnSlDrivers: TButton
        Left = 447
        Top = 15
        Width = 19
        Height = 17
        Action = aMain_SlOrderStatus
        TabOrder = 1
      end
    end
    object pnlAssemblingDate: TPanel
      Left = 0
      Top = 39
      Width = 481
      Height = 32
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object lblSAssemblingDate: TLabel
        Left = 11
        Top = 10
        Width = 124
        Height = 13
        Caption = #1057#1086#1075#1083#1072#1089'. '#1074#1088#1077#1084#1103' '#1076#1086#1089#1090#1072#1074#1082#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edSAssemblingDate: TEdit
        Left = 140
        Top = 4
        Width = 135
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        Ctl3D = True
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 0
        OnChange = edSAssemblingDateChange
        OnDblClick = aSetAssemblingDateExecute
      end
      object btnSetAssemblingDate: TButton
        Left = 254
        Top = 6
        Width = 19
        Height = 17
        Action = aSetAssemblingDate
        TabOrder = 1
      end
    end
  end
  object aMain: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 312
    Top = 65
    object aMain_Ok: TAction
      Category = 'Main'
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      ImageIndex = 36
      OnExecute = aMain_OkExecute
    end
    object aMain_Exit: TAction
      Category = 'Main'
      Caption = #1042#1099#1081#1090#1080
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aMain_ExitExecute
    end
    object aMain_SlOrderStatus: TAction
      Category = 'Main'
      Caption = #8230
      OnExecute = aMain_SlOrderStatusExecute
    end
    object aSetAssemblingDate: TAction
      Category = 'Main'
      Caption = #8230
      OnExecute = aSetAssemblingDateExecute
    end
  end
  object spSetOrderStatus: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_SetOrderStatus;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@Order'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@CodeAction'
        Attributes = [paNullable]
        DataType = ftString
        Size = 80
        Value = ''
      end
      item
        Name = '@USER'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@Status'
        Attributes = [paNullable]
        DataType = ftString
        Size = 240
        Value = '0'
      end
      item
        Name = '@SNOTE'
        Attributes = [paNullable]
        DataType = ftString
        Size = 500
        Value = ''
      end
      item
        Name = '@SErr'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 4000
        Value = ''
      end
      item
        Name = '@SignUpdJournal'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = 0
      end
      item
        Name = '@SignCheckClose'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = 0
      end
      item
        Name = '@SAssemblingDate'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end>
    Left = 387
    Top = 66
  end
end
