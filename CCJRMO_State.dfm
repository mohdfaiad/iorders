object frmCCJRMO_State: TfrmCCJRMO_State
  Left = 19
  Top = 284
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'frmCCJRMO_State'
  ClientHeight = 122
  ClientWidth = 562
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
    Width = 562
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
      Width = 300
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
    Top = 96
    Width = 562
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlTool'
    TabOrder = 1
    object pnlTool_Bar: TPanel
      Left = 404
      Top = 0
      Width = 158
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object tlbarControl: TToolBar
        Left = 0
        Top = 0
        Width = 158
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
      Width = 404
      Height = 26
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlState: TPanel
    Left = 0
    Top = 21
    Width = 562
    Height = 75
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvSpace
    TabOrder = 2
    object Label1: TLabel
      Left = 12
      Top = 20
      Width = 172
      Height = 13
      Caption = #1054#1089#1085#1086#1074#1072#1085#1080#1077' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1086#1087#1077#1088#1072#1094#1080#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 14
      Top = 45
      Width = 73
      Height = 13
      Caption = #1057#1090#1072#1090#1091#1089' '#1079#1072#1082#1072#1079#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edFoundation: TEdit
      Left = 188
      Top = 13
      Width = 365
      Height = 21
      TabOrder = 0
      OnChange = edFoundationChange
      OnDblClick = aMain_SlFoundationExecute
    end
    object btnSlFoundation: TButton
      Left = 532
      Top = 15
      Width = 19
      Height = 17
      Action = aMain_SlFoundation
      TabOrder = 1
    end
    object edOrderStatus: TEdit
      Left = 96
      Top = 41
      Width = 456
      Height = 21
      TabOrder = 2
      OnChange = edOrderStatusChange
      OnDblClick = aMain_SlOrderStatusExecute
    end
    object btnSlDrivers: TButton
      Left = 531
      Top = 43
      Width = 19
      Height = 17
      Action = aMain_SlOrderStatus
      TabOrder = 3
    end
  end
  object aMain: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 107
    Top = 71
    object aMain_Ok: TAction
      Category = 'Main'
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      ImageIndex = 36
      ShortCut = 13
      OnExecute = aMain_OkExecute
    end
    object aMain_Exit: TAction
      Category = 'Main'
      Caption = #1042#1099#1081#1090#1080
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aMain_ExitExecute
    end
    object aMain_SlFoundation: TAction
      Category = 'Main'
      Caption = #8230
      OnExecute = aMain_SlFoundationExecute
    end
    object aMain_SlOrderStatus: TAction
      Category = 'Main'
      Caption = #8230
      OnExecute = aMain_SlOrderStatusExecute
    end
  end
  object spFindStatus: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_FindOrderStatus;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@Descr'
        Attributes = [paNullable]
        DataType = ftString
        Size = 240
        Value = ''
      end
      item
        Name = '@NRN_OUT'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
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
    Left = 158
    Top = 71
  end
  object spGetStateJRMO: TADOStoredProc
    Connection = Form1.ADOC_STAT
    ProcedureName = 'p_jrmo_GetSate;1'
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
        Name = '@SCloseDate'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 30
        Value = ''
      end
      item
        Name = '@SErr'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 4000
        Value = ''
      end>
    Left = 233
    Top = 71
  end
  object spJRMOSetState: TADOStoredProc
    Connection = Form1.ADOC_STAT
    ProcedureName = 'p_jrmo_SetState;1'
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
        Name = '@Foundation'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = ''
      end
      item
        Name = '@StatusName'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = ''
      end
      item
        Name = '@SErr'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 4000
        Value = ''
      end>
    Left = 322
    Top = 70
  end
end
