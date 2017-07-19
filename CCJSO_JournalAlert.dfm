object frmCCJSO_JournalAlert: TfrmCCJSO_JournalAlert
  Left = 0
  Top = 210
  Width = 1096
  Height = 549
  Caption = #1048#1089#1090#1086#1088#1080#1103' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1081' '
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
  object pnlCondition: TPanel
    Left = 0
    Top = 0
    Width = 1080
    Height = 38
    Align = alTop
    BevelInner = bvSpace
    BevelOuter = bvLowered
    TabOrder = 0
    object lblCndDatePeriod_with: TLabel
      Left = 5
      Top = 15
      Width = 6
      Height = 13
      Caption = #1089
    end
    object lblCndDatePeriod_toOn: TLabel
      Left = 107
      Top = 15
      Width = 12
      Height = 13
      Caption = #1087#1086
    end
    object lblCnd_TypeAlert: TLabel
      Left = 224
      Top = 15
      Width = 19
      Height = 13
      Caption = #1058#1080#1087
    end
    object dtCndBegin: TDateTimePicker
      Left = 15
      Top = 8
      Width = 90
      Height = 21
      BevelInner = bvNone
      BevelOuter = bvNone
      Date = 41856.717597962960000000
      Time = 41856.717597962960000000
      TabOrder = 0
      OnChange = aConditionExecute
    end
    object dtCndEnd: TDateTimePicker
      Left = 122
      Top = 8
      Width = 90
      Height = 21
      Date = 41856.717597962960000000
      Time = 41856.717597962960000000
      TabOrder = 1
      OnChange = aConditionExecute
    end
    object edCnd_TypeAlert: TEdit
      Left = 248
      Top = 8
      Width = 317
      Height = 21
      ReadOnly = True
      TabOrder = 2
      OnChange = aConditionExecute
      OnDblClick = edCnd_TypeAlertDblClick
    end
    object btnCnd_TypeAlert: TButton
      Left = 544
      Top = 10
      Width = 19
      Height = 17
      Action = aSelectTypeAlert
      TabOrder = 3
    end
  end
  object pnlTool: TPanel
    Left = 0
    Top = 38
    Width = 1080
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlTool'
    TabOrder = 1
    object pnlTool_Show: TPanel
      Left = 933
      Top = 0
      Width = 147
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
    end
    object pnlTool_Bar: TPanel
      Left = 0
      Top = 0
      Width = 933
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object toolBar: TToolBar
        Left = 0
        Top = 0
        Width = 933
        Height = 26
        Align = alClient
        ButtonWidth = 156
        Caption = 'toolBar'
        EdgeBorders = []
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tbtnRefresh: TToolButton
          Left = 0
          Top = 0
          Action = aRefresh
          AutoSize = True
        end
        object tbtnItemInfo: TToolButton
          Left = 80
          Top = 0
          Action = aItemInfo
          AutoSize = True
        end
        object tbtnClearCondition: TToolButton
          Left = 173
          Top = 0
          Action = aClearCondition
          AutoSize = True
        end
        object tbtnClearHistory: TToolButton
          Left = 333
          Top = 0
          Action = aClearHistory
          AutoSize = True
        end
        object tbtnAlertAll: TToolButton
          Left = 457
          Top = 0
          Action = aAlertAll
          AutoSize = True
        end
        object tbtnAlertShowOptions: TToolButton
          Left = 577
          Top = 0
          Action = aShowOptions
          AutoSize = True
        end
      end
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 64
    Width = 1080
    Height = 447
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlGrid'
    TabOrder = 2
    object GridJA: TDBGrid
      Left = 0
      Top = 0
      Width = 1080
      Height = 447
      Align = alClient
      BorderStyle = bsNone
      Ctl3D = False
      DataSource = dsJA
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = GridJADrawColumnCell
      OnDblClick = GridJADblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'SCreateDate'
          Title.Caption = #1056#1086#1079#1076#1072#1085#1086
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SAlertDate'
          Title.Caption = #1044#1072#1090#1072' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1103
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SCodeAlertType'
          Title.Caption = #1058#1080#1087
          Width = 25
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SContents'
          Title.Caption = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077
          Width = 400
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SExecDate'
          Title.Caption = #1054#1090#1088#1072#1073#1086#1090#1072#1085#1086
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SReadDate'
          Title.Caption = #1055#1088#1080#1085#1103#1090#1086' '#1082' '#1080#1089#1087#1086#1083#1085#1077#1085#1080#1102
          Width = 130
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'SEnumerator'
          Title.Caption = #1059#1074#1077#1076#1086#1084#1083#1077#1085#1080#1081
          Width = 78
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SJList'
          Title.Caption = #1057#1087#1080#1089#1086#1082' '#1085#1086#1084#1077#1088#1086#1074' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
          Width = 161
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SAlertUserType'
          Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#1089#1082#1072#1103' '#1090#1077#1084#1072
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SFromWhom'
          Title.Caption = #1054#1090' '#1082#1086#1075#1086
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IP'
          Title.Caption = 'IP '#1040#1076#1088#1077#1089
          Width = 80
          Visible = True
        end>
    end
    object pnlImage: TPanel
      Left = 891
      Top = 174
      Width = 145
      Height = 115
      BevelInner = bvLowered
      Caption = 'pnlImage'
      TabOrder = 1
      Visible = False
      object imgFeedBack: TImage
        Left = 8
        Top = 8
        Width = 32
        Height = 32
        AutoSize = True
        Center = True
        Transparent = True
      end
      object imgFeedBackOld: TImage
        Left = 44
        Top = 8
        Width = 29
        Height = 30
        AutoSize = True
        Center = True
        Transparent = True
      end
      object imgRareMedication: TImage
        Left = 77
        Top = 8
        Width = 29
        Height = 30
        AutoSize = True
        Center = True
        Transparent = True
      end
      object imgMissedCall: TImage
        Left = 110
        Top = 8
        Width = 29
        Height = 30
        AutoSize = True
        Center = True
        Transparent = True
      end
      object imgNewPay: TImage
        Left = 9
        Top = 44
        Width = 29
        Height = 30
        AutoSize = True
        Center = True
        Transparent = True
      end
      object imgNewCheckoutCheck: TImage
        Left = 43
        Top = 44
        Width = 29
        Height = 30
        AutoSize = True
        Center = True
        Transparent = True
      end
      object imgUser: TImage
        Left = 77
        Top = 45
        Width = 29
        Height = 30
        AutoSize = True
        Center = True
        Transparent = True
      end
      object imgError: TImage
        Left = 110
        Top = 45
        Width = 29
        Height = 30
        AutoSize = True
        Center = True
        Transparent = True
      end
      object imgPharmacy: TImage
        Left = 9
        Top = 78
        Width = 29
        Height = 30
        AutoSize = True
        Center = True
        Transparent = True
      end
      object imgNewPost: TImage
        Left = 43
        Top = 78
        Width = 29
        Height = 30
        AutoSize = True
        Center = True
        Transparent = True
      end
      object imgCall: TImage
        Left = 77
        Top = 78
        Width = 29
        Height = 30
        AutoSize = True
        Center = True
        Transparent = True
      end
    end
  end
  object qrspJA: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_JournalAlert;1'
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
        Value = 0
      end
      item
        Name = '@AlertBegin'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end
      item
        Name = '@AlertEnd'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end
      item
        Name = '@SignNotRead'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = 0
      end
      item
        Name = '@SignCheckEnumerator'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = 0
      end
      item
        Name = '@SignCheckExec'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = 0
      end
      item
        Name = '@AlertType'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@IP'
        DataType = ftString
        Size = 50
        Value = Null
      end>
    Left = 1017
    Top = 119
  end
  object dsJA: TDataSource
    DataSet = qrspJA
    Left = 961
    Top = 119
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 913
    Top = 119
    object aRefresh: TAction
      Category = 'Tool'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 4
      OnExecute = aRefreshExecute
    end
    object aCondition: TAction
      Category = 'Condition'
      Caption = 'aCondition'
      OnExecute = aConditionExecute
    end
    object aSelectTypeAlert: TAction
      Category = 'Condition'
      Caption = #8230
      OnExecute = aSelectTypeAlertExecute
    end
    object aItemInfo: TAction
      Category = 'Tool'
      Caption = #1055#1086#1089#1084#1086#1090#1088#1077#1090#1100
      ImageIndex = 320
      OnExecute = aItemInfoExecute
    end
    object aClearCondition: TAction
      Category = 'Tool'
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1091#1089#1083#1086#1074#1080#1103' '#1086#1090#1073#1086#1088#1072
      ImageIndex = 40
      OnExecute = aClearConditionExecute
    end
    object aExit: TAction
      Category = 'Tool'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
    object aClearHistory: TAction
      Category = 'Tool'
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1080#1089#1090#1086#1088#1080#1102
      ImageIndex = 324
      OnExecute = aClearHistoryExecute
    end
    object aAlertAll: TAction
      Category = 'Tool'
      Caption = #1042#1089#1077' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1103
      ImageIndex = 326
      OnExecute = aAlertAllExecute
    end
    object aShowOptions: TAction
      Category = 'Tool'
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072
      ImageIndex = 330
      OnExecute = aShowOptionsExecute
    end
  end
end
