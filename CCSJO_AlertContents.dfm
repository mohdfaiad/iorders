object frmCCSJO_AlertContents: TfrmCCSJO_AlertContents
  Left = 18
  Top = 269
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1046#1091#1088#1085#1072#1083' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1081
  ClientHeight = 647
  ClientWidth = 1001
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
    Width = 1001
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
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 2
      OnChange = aConditionExecute
      OnDblClick = aSelectTypeAlertExecute
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
    Width = 1001
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlTool'
    TabOrder = 1
    object pnlTool_Show: TPanel
      Left = 854
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
      Width = 854
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object toolBar: TToolBar
        Left = 0
        Top = 0
        Width = 854
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
          Left = 155
          Top = 0
          Action = aClearCondition
          AutoSize = True
        end
        object tbtnClearHistory: TToolButton
          Left = 315
          Top = 0
          Action = aClearHistory
          AutoSize = True
        end
        object tbtnDistributedToUsers: TToolButton
          Left = 439
          Top = 0
          Action = aDistributedToUsers
          AutoSize = True
        end
      end
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 64
    Width = 1001
    Height = 583
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlGrid'
    TabOrder = 2
    object GridJA: TDBGrid
      Left = 0
      Top = 0
      Width = 1001
      Height = 583
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
      Columns = <
        item
          Expanded = False
          FieldName = 'SAlertDate'
          Title.Caption = #1044#1072#1090#1072
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SCodeAlertType'
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
          FieldName = 'IShowNumber'
          Title.Caption = #1055#1086#1082#1072#1079#1086#1074
          Width = 50
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
          Alignment = taCenter
          Expanded = False
          FieldName = 'SForShure'
          Title.Caption = #1042#1089#1077#1084
          Width = 35
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SFromWhom'
          Title.Caption = #1054#1090' '#1082#1086#1075#1086
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'S_IP'
          Title.Caption = 'IP '#1040#1076#1088#1077#1089
          Width = 80
          Visible = True
        end>
    end
    object pnlImage: TPanel
      Left = 819
      Top = 166
      Width = 145
      Height = 113
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
        Left = 8
        Top = 77
        Width = 29
        Height = 30
        AutoSize = True
        Center = True
        Transparent = True
      end
      object imgNewPost: TImage
        Left = 42
        Top = 77
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
  object ActionList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 848
    Top = 104
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
    object aRefresh: TAction
      Category = 'Tool'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 4
      OnExecute = aRefreshExecute
    end
    object aItemInfo: TAction
      Category = 'Tool'
      Caption = 'aItemInfo'
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
    object aDistributedToUsers: TAction
      Category = 'Tool'
      Caption = #1056#1086#1079#1076#1072#1085#1086' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103#1084
      ImageIndex = 327
      OnExecute = aDistributedToUsersExecute
    end
  end
  object dsJA: TDataSource
    DataSet = qrspJA
    Left = 894
    Top = 104
  end
  object qrspJA: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_JAlertContents;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
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
      end>
    Left = 934
    Top = 104
  end
end
