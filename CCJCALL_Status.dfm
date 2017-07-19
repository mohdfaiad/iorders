object frmCCJCALL_Status: TfrmCCJCALL_Status
  Left = 12
  Top = 469
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1054#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1089#1090#1072#1090#1091#1089' '#1074#1099#1079#1086#1074#1072
  ClientHeight = 305
  ClientWidth = 478
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
    Width = 478
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlTop'
    TabOrder = 0
    object pnlTop_RN: TPanel
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
    object pnlTop_Phone: TPanel
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
    object pnlTop_CallDate: TPanel
      Left = 262
      Top = 0
      Width = 216
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
  object pnlOrderStatus: TPanel
    Left = 0
    Top = 21
    Width = 478
    Height = 47
    Align = alTop
    BevelInner = bvLowered
    BevelOuter = bvSpace
    TabOrder = 1
    object Label1: TLabel
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
      Left = 66
      Top = 13
      Width = 402
      Height = 21
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
  object pnlCheckNote: TPanel
    Left = 0
    Top = 68
    Width = 478
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlCheckNote'
    TabOrder = 2
    object pnlCheckNote_Count: TPanel
      Left = 391
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
      Width = 391
      Height = 21
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '  '#1055#1088#1080#1084#1077#1095#1072#1085#1080#1077':'
      TabOrder = 1
    end
  end
  object pnlTool: TPanel
    Left = 0
    Top = 279
    Width = 478
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlTool'
    TabOrder = 3
    object pnlTool_Bar: TPanel
      Left = 318
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
      Width = 318
      Height = 26
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlNote: TPanel
    Left = 0
    Top = 89
    Width = 478
    Height = 190
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvSpace
    BorderWidth = 1
    TabOrder = 4
    object mNote: TMemo
      Left = 3
      Top = 3
      Width = 472
      Height = 184
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 2000
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object aMain: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 26
    Top = 105
    object aMain_Ok: TAction
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      ImageIndex = 36
      OnExecute = aMain_OkExecute
    end
    object aMain_Exit: TAction
      Caption = #1042#1099#1081#1090#1080
      ImageIndex = 204
      OnExecute = aMain_ExitExecute
    end
    object aMain_SlOrderStatus: TAction
      Caption = #8230
      OnExecute = aMain_SlOrderStatusExecute
    end
  end
  object spSetStatus: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_JCall_SetStatus;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@PRN'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@RN_HIST'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
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
        Value = ''
      end
      item
        Name = '@SNOTE'
        Attributes = [paNullable]
        DataType = ftString
        Size = 2000
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
        Name = '@SErr'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 4000
        Value = ''
      end>
    Left = 97
    Top = 106
  end
end
