object frmCCJSO_SessionUser: TfrmCCJSO_SessionUser
  Left = 9
  Top = 185
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1077#1089#1089#1080#1080' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
  ClientHeight = 563
  ClientWidth = 1160
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
    Width = 1160
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
    object lblCnd_User: TLabel
      Left = 224
      Top = 15
      Width = 73
      Height = 13
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
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
    object edCnd_User: TEdit
      Left = 300
      Top = 8
      Width = 317
      Height = 21
      ReadOnly = True
      TabOrder = 2
      OnChange = aConditionExecute
      OnDblClick = edCnd_UserDblClick
    end
    object btnCnd_User: TButton
      Left = 596
      Top = 10
      Width = 19
      Height = 17
      Action = aCnd_ChooseUser
      TabOrder = 3
    end
  end
  object pnlTool: TPanel
    Left = 0
    Top = 38
    Width = 1160
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlTool'
    TabOrder = 1
    object pnlTool_Show: TPanel
      Left = 1013
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
      Width = 1013
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object toolBar: TToolBar
        Left = 0
        Top = 0
        Width = 1013
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
        object tbtnClearCondition: TToolButton
          Left = 80
          Top = 0
          Action = aClearCondition
          AutoSize = True
        end
      end
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 64
    Width = 1160
    Height = 499
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlGrid'
    TabOrder = 2
    object GridJA: TDBGrid
      Left = 0
      Top = 0
      Width = 1160
      Height = 499
      Align = alClient
      BorderStyle = bsNone
      Ctl3D = False
      DataSource = dsRegActiveUser
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
          FieldName = 'SUSER'
          Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SBeginDate'
          Title.Caption = #1054#1090#1082#1088#1099#1090#1086
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SCloseDate'
          Title.Caption = #1047#1072#1082#1088#1099#1090#1086
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SSignForced'
          Title.Caption = #1055#1088#1080#1085#1091#1076#1080#1090#1077#1083#1100#1085#1086
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SActiveDate'
          Title.Caption = #1040#1082#1090#1080#1074#1085#1086
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SComputerNetName'
          Title.Caption = #1050#1086#1084#1087#1100#1090#1077#1088
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SUserFromWindows'
          Title.Caption = #1059#1095#1077#1090#1085#1072#1103' '#1079#1072#1087#1080#1089#1100
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SLocalIP'
          Title.Caption = 'IP'
          Width = 100
          Visible = True
        end>
    end
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 888
    Top = 88
    object aCondition: TAction
      Category = 'Condition'
      Caption = 'aCondition'
      OnExecute = aConditionExecute
    end
    object aCnd_ChooseUser: TAction
      Category = 'Condition'
      Caption = #8230
      OnExecute = aCnd_ChooseUserExecute
    end
    object aRefresh: TAction
      Category = 'Tool'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 4
      OnExecute = aRefreshExecute
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
  end
  object spRegActiveUser: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_clc_RegActiveUser;1'
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
        Name = '@Begin'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end
      item
        Name = '@End'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end>
    Left = 1064
    Top = 88
  end
  object dsRegActiveUser: TDataSource
    DataSet = spRegActiveUser
    Left = 968
    Top = 88
  end
end
