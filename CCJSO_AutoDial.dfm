object frmCCJSO_AutoDial: TfrmCCJSO_AutoDial
  Left = 5
  Top = 292
  Width = 1200
  Height = 521
  Caption = #1046#1091#1088#1085#1072#1083' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080' '#1072#1074#1090#1086#1076#1086#1079#1074#1086#1085#1086#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 1184
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlHeader'
    TabOrder = 0
    object pnlHeader_Show: TPanel
      Left = 1131
      Top = 0
      Width = 53
      Height = 30
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
    end
    object pnlHeader_Cond: TPanel
      Left = 0
      Top = 0
      Width = 1131
      Height = 30
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object pnlHeader_Cond_Tool: TPanel
        Left = 0
        Top = 0
        Width = 248
        Height = 30
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'pnlHeader_Cond_Tool'
        TabOrder = 0
        object tbarCondition: TToolBar
          Left = 0
          Top = 0
          Width = 91
          Height = 30
          Align = alLeft
          AutoSize = True
          BorderWidth = 2
          Caption = 'tbarCondition'
          DisabledImages = FCCenterJournalNetZkz.imgMainDisable
          EdgeBorders = [ebRight]
          Flat = True
          Images = FCCenterJournalNetZkz.imgMain
          List = True
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object tbtnCondition_Clear: TToolButton
            Left = 0
            Top = 0
            Action = aCondClear
            AutoSize = True
          end
          object tbtnCondition_Refresh: TToolButton
            Left = 27
            Top = 0
            Action = aRefresh
            AutoSize = True
          end
          object ToolButton1: TToolButton
            Left = 54
            Top = 0
            Action = aRecItem
            AutoSize = True
          end
        end
        object tbarCurrentOrder: TToolBar
          Left = 91
          Top = 0
          Width = 149
          Height = 30
          Align = alLeft
          AutoSize = True
          BorderWidth = 2
          ButtonWidth = 135
          Caption = 'tbarCurrentOrder'
          EdgeBorders = [ebRight]
          Flat = True
          Images = FCCenterJournalNetZkz.imgMain
          List = True
          ParentShowHint = False
          ShowCaptions = True
          ShowHint = True
          TabOrder = 1
          object tbtn_CurrentOrder: TToolButton
            Left = 0
            Top = 0
            Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1082#1083'/'#1074#1099#1082#1083' '#1086#1090#1073#1086#1088#1072' '#1087#1086' '#1090#1077#1082#1091#1097#1077#1080#1091' '#1085#1086#1084#1077#1088#1091' '#1079#1072#1082#1072#1079#1072
            Action = aSlCurrentOrder
            AutoSize = True
          end
        end
      end
      object pnlHeader_Cond_Field: TPanel
        Left = 248
        Top = 0
        Width = 883
        Height = 30
        Hint = #1059#1089#1083#1086#1074#1080#1103' '#1086#1090#1073#1086#1088#1072
        Align = alClient
        BevelOuter = bvNone
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        object lblCndDatePeriod_with: TLabel
          Left = 6
          Top = 11
          Width = 55
          Height = 13
          Caption = #1047#1072' '#1087#1077#1088#1086#1076' '#1089
        end
        object lblCndDatePeriod_toOn: TLabel
          Left = 192
          Top = 11
          Width = 12
          Height = 13
          Caption = #1087#1086
        end
        object edCndDateBegin: TEdit
          Tag = 10
          Left = 63
          Top = 4
          Width = 125
          Height = 21
          Hint = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
          BevelKind = bkFlat
          BorderStyle = bsNone
          ReadOnly = True
          TabOrder = 0
          OnChange = aCondChangeExecute
          OnDblClick = aSlDateExecute
        end
        object btnCndDateBegin: TButton
          Tag = 10
          Left = 168
          Top = 6
          Width = 18
          Height = 17
          Hint = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
          Action = aSlDate
          TabOrder = 1
        end
        object edCndDateEnd: TEdit
          Tag = 11
          Left = 206
          Top = 4
          Width = 125
          Height = 21
          Hint = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
          BevelKind = bkFlat
          BorderStyle = bsNone
          ReadOnly = True
          TabOrder = 2
          OnChange = aCondChangeExecute
          OnDblClick = aSlDateExecute
        end
        object btnCndDateEnd: TButton
          Tag = 11
          Left = 310
          Top = 6
          Width = 19
          Height = 17
          Hint = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
          Action = aSlDate
          TabOrder = 3
        end
      end
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 30
    Width = 1184
    Height = 453
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlGrid'
    TabOrder = 1
    object GridMain: TDBGrid
      Left = 0
      Top = 0
      Width = 1184
      Height = 453
      Align = alClient
      BorderStyle = bsNone
      DataSource = dsMain
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = GridMainDrawColumnCell
      OnDblClick = GridMainDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'SCreateDate'
          Title.Caption = #1057#1086#1079#1076#1072#1085#1086
          Width = 125
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SPrefix'
          Title.Caption = #1055#1088#1077#1092#1080#1082#1089
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOrder'
          Title.Caption = #1047#1072#1082#1072#1079
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SOrderDT'
          Title.Caption = #1044#1072#1090#1072' '#1079#1072#1082#1072#1079#1072
          Width = 125
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SClient'
          Title.Caption = #1050#1083#1080#1077#1085#1090
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SPhone'
          Title.Caption = #1058#1077#1083#1077#1092#1086#1085
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SAutoDialType'
          Title.Caption = #1058#1080#1087' '#1072#1074#1090#1086#1076#1086#1079#1074#1086#1085#1072
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SNameFileRoot'
          Title.Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ICounter'
          Title.Caption = #1057#1095#1077#1090#1095#1080#1082
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SAutoDialBegin'
          Title.Caption = #1053#1072#1095#1072#1083#1086
          Width = 125
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SAutoDialEnd'
          Title.Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077
          Width = 125
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SAutoDialResult'
          Title.Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SFileExists'
          Title.Caption = #1060#1072#1081#1083' '#1085#1072#1081#1076#1077#1085
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NCheckCounter'
          Title.Caption = #1055#1088#1086#1074#1077#1088#1077#1085#1086' '#1088#1072#1079
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SCheckDate'
          Title.Caption = #1044#1072#1090#1072' '#1087#1088#1086#1074#1077#1088#1082#1080
          Width = 125
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NRetryCounter'
          Title.Caption = #1055#1086#1074#1090#1086#1088#1077#1085#1086' '#1074#1099#1079#1086#1074#1086#1074
          Width = 110
          Visible = True
        end>
    end
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 912
    Top = 62
    object aCondExt: TAction
      Category = 'Condition'
      Caption = #1056#1072#1089#1096#1080#1088#1077#1085#1085#1099#1077' '#1091#1089#1083#1086#1074#1080#1103' '#1086#1090#1073#1086#1088#1072
      Hint = #1056#1072#1089#1096#1080#1088#1077#1085#1085#1099#1077' '#1091#1089#1083#1086#1074#1080#1103' '#1086#1090#1073#1086#1088#1072
      ImageIndex = 179
      ShortCut = 117
    end
    object aCondClear: TAction
      Category = 'Condition'
      Caption = 'aCondClear'
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1091#1089#1083#1086#1074#1080#1103' '#1086#1090#1073#1086#1088#1072
      ImageIndex = 40
      OnExecute = aCondClearExecute
    end
    object aExit: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
    object aSlDate: TAction
      Category = 'Condition'
      Caption = #8230
      OnExecute = aSlDateExecute
    end
    object aSlCurrentOrder: TAction
      Category = 'Condition'
      AutoCheck = True
      Caption = #1047#1072#1082#1072#1079' '#8470' 1234567890'
      ImageIndex = 358
      OnExecute = aCondChangeExecute
      OnUpdate = aSlCurrentOrderUpdate
    end
    object aCondChange: TAction
      Category = 'Condition'
      Caption = 'aCondChange'
      OnExecute = aCondChangeExecute
    end
    object aRefresh: TAction
      Category = 'Condition'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 4
      OnExecute = aRefreshExecute
    end
    object aRecItem: TAction
      Category = 'Control'
      Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1086#1085#1085#1072#1103' '#1082#1072#1088#1090#1086#1095#1082#1072
      Hint = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1086#1085#1085#1072#1103' '#1082#1072#1088#1090#1086#1095#1082#1072
      ImageIndex = 16
      OnExecute = aRecItemExecute
    end
  end
  object dsMain: TDataSource
    DataSet = qrMain
    Left = 608
    Top = 70
  end
  object qrMain: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_AutoDial;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@USER'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Begin'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = Null
      end
      item
        Name = '@End'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = Null
      end
      item
        Name = '@Prefix'
        Attributes = [paNullable]
        DataType = ftString
        Size = 10
        Value = Null
      end
      item
        Name = '@Order'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@AutoDialType'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = Null
      end>
    Left = 696
    Top = 70
  end
end
