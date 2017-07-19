object frmCCJSO_SumArmor: TfrmCCJSO_SumArmor
  Left = 50
  Top = 739
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1091#1084#1084#1072#1088#1085#1099#1077' '#1087#1086#1082#1072#1079#1072#1090#1077#1083#1080' '#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1103
  ClientHeight = 121
  ClientWidth = 462
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
  object pgcMain: TPageControl
    Left = 0
    Top = 0
    Width = 462
    Height = 95
    ActivePage = tabParm_JSO
    Align = alClient
    Images = FCCenterJournalNetZkz.imgMain
    TabOrder = 0
    object tabParm_JSO: TTabSheet
      Caption = #1048#1085#1090#1077#1088#1085#1077#1090' '#1079#1072#1082#1072#1079#1099
      ImageIndex = 18
      object stbarParm_JSO: TStatusBar
        Left = 0
        Top = 47
        Width = 454
        Height = 19
        Panels = <>
        SimplePanel = True
      end
      object pnlParm: TPanel
        Left = 0
        Top = 0
        Width = 454
        Height = 47
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object grbxParm_Period: TGroupBox
          Left = 0
          Top = 0
          Width = 454
          Height = 45
          Align = alTop
          Caption = ' '#1047#1072' '#1087#1077#1088#1080#1086#1076' '
          TabOrder = 0
          object lblCndDatePeriod_with: TLabel
            Left = 7
            Top = 23
            Width = 7
            Height = 13
            Caption = #1057
          end
          object lblCndDatePeriod_toOn: TLabel
            Left = 112
            Top = 24
            Width = 12
            Height = 13
            Caption = #1087#1086
          end
          object dtCndBegin: TDateTimePicker
            Left = 19
            Top = 18
            Width = 90
            Height = 21
            Date = 41856.717597962960000000
            Time = 41856.717597962960000000
            TabOrder = 0
          end
          object dtCndEnd: TDateTimePicker
            Left = 130
            Top = 18
            Width = 90
            Height = 21
            Date = 41856.717597962960000000
            Time = 41856.717597962960000000
            TabOrder = 1
          end
        end
      end
    end
  end
  object pnlTool: TPanel
    Left = 0
    Top = 95
    Width = 462
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlTool'
    TabOrder = 1
    object pnlTool_Bar: TPanel
      Left = 171
      Top = 0
      Width = 291
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object tlbarMain: TToolBar
        Left = 0
        Top = 0
        Width = 291
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 96
        EdgeBorders = []
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tlbtnMain_Exec: TToolButton
          Left = 0
          Top = 0
          Action = aMain_Exec
          AutoSize = True
        end
        object tlbtnMain_GrupsPharmacy: TToolButton
          Left = 87
          Top = 0
          Action = aMainGrupsPharmacy
          AutoSize = True
        end
        object tlbtnMain_Close: TToolButton
          Left = 187
          Top = 0
          Action = aMain_Close
        end
      end
    end
    object pnlTool_Show: TPanel
      Left = 0
      Top = 0
      Width = 171
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object aMain: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 230
    Top = 1
    object aMain_Exec: TAction
      Category = 'Main'
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      ImageIndex = 36
      OnExecute = aMain_ExecExecute
    end
    object aMain_Close: TAction
      Category = 'Main'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aMain_CloseExecute
    end
    object aMainGrupsPharmacy: TAction
      Category = 'Main'
      Caption = #1043#1088#1091#1087#1087#1099' '#1072#1087#1090#1077#1082
      ImageIndex = 205
      OnExecute = aMainGrupsPharmacyExecute
    end
  end
  object spdsSumArmor: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 300
    ProcedureName = 'pDS_jso_RP_SumArmour;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@SBegin'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@SEnd'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@SignGruopPharmacy'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = 0
      end>
    Left = 266
    Top = 14
  end
  object spdsPlan: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_RP_PlanSumArmour;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@SBegin'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@SEnd'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@SignGruopPharmacy'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = 0
      end
      item
        Name = '@SignPharmacy'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = 0
      end>
    Left = 307
    Top = 4
  end
  object spdsFactHand: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_RP_FactByHand;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@SBegin'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@SEnd'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@SignGruopPharmacy'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = 0
      end>
    Left = 347
    Top = 20
  end
  object spdsPlanExt: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_RP_ExtPlanSumArmour;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@SBegin'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@SEnd'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@SignGruopPharmacy'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = 0
      end>
    Left = 397
    Top = 7
  end
end
