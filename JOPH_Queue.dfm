object frmJOPH_Queue: TfrmJOPH_Queue
  Left = 2076
  Top = 207
  Width = 1305
  Height = 675
  Caption = #1054#1095#1077#1088#1077#1076#1100' '#1086#1073#1088#1072#1073#1086#1090#1082#1080' '#1079#1072#1082#1072#1079#1086#1074
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
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object splitGrid: TSplitter
    Left = 0
    Top = 457
    Width = 1289
    Height = 3
    Cursor = crVSplit
    Align = alTop
    Beveled = True
    OnMoved = splitGridMoved
  end
  object pnlCond: TPanel
    Left = 0
    Top = 0
    Width = 1289
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlCond'
    TabOrder = 0
    object pnlCond_Tool: TPanel
      Left = 0
      Top = 0
      Width = 70
      Height = 26
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'pnlCond_Tool'
      TabOrder = 0
      object tbatCondTool: TToolBar
        Left = 0
        Top = 0
        Width = 70
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        Caption = 'tbatCondTool'
        DisabledImages = FCCenterJournalNetZkz.imgMainDisable
        EdgeBorders = [ebRight]
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
    end
    object pnlCond_Fields: TPanel
      Left = 70
      Top = 0
      Width = 1219
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlControl: TPanel
    Left = 0
    Top = 26
    Width = 1289
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlControl'
    TabOrder = 1
    object bvlMainControl: TBevel
      Left = 0
      Top = 0
      Width = 1289
      Height = 1
      Align = alTop
      Shape = bsTopLine
    end
    object pnlControl_Show: TPanel
      Left = 1209
      Top = 1
      Width = 80
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
    end
    object pnlControlTool: TPanel
      Left = 0
      Top = 1
      Width = 1209
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnlControlTool'
      TabOrder = 1
      object tbarMainTool: TToolBar
        Left = 0
        Top = 0
        Width = 1209
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 154
        Caption = 'tbarMainTool'
        DisabledImages = FCCenterJournalNetZkz.imgMainDisable
        EdgeBorders = []
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tbtbMainTool_ForcedClose: TToolButton
          Left = 0
          Top = 0
          Action = aForcedClose
          AutoSize = True
        end
      end
    end
  end
  object pnlGridMain: TPanel
    Left = 0
    Top = 53
    Width = 1289
    Height = 404
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlGridMain'
    Constraints.MinHeight = 100
    Constraints.MinWidth = 100
    TabOrder = 2
    object GridMain: TDBGrid
      Left = 0
      Top = 0
      Width = 1289
      Height = 404
      Align = alClient
      BorderStyle = bsNone
      Ctl3D = False
      DataSource = DMJOPH.dsQueMain
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = GridMainDrawColumnCell
      OnTitleClick = GridMainTitleClick
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
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOrderID'
          Title.Caption = #1047#1072#1082#1072#1079
          Width = 53
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SPharmAuthor'
          Title.Caption = #1058#1058' '#1072#1074#1090#1086#1088
          Width = 170
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SJobNumber'
          Title.Caption = #1047#1072#1076#1072#1085#1080#1077
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SNameJobGroup'
          Title.Caption = #1043#1088#1091#1087#1087#1072' '#1086#1073#1088#1072#1073#1086#1090#1082#1080
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SSignAutoProces'
          Title.Caption = #1058#1080#1087' '#1086#1073#1088#1072#1073#1086#1090#1082#1080
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SNameStateProcessing'
          Title.Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1086#1073#1088#1072#1073#1086#1090#1082#1080
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SBeginProcesing'
          Title.Caption = #1053#1072#1095#1072#1083#1086' '#1086#1073#1088#1072#1073#1086#1090#1082#1080
          Width = 125
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SCloseDate'
          Title.Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1086#1073#1088#1072#1073#1086#1090#1082#1080
          Width = 125
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SUser'
          Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SSignManualAutoProces'
          Title.Caption = #1042#1080#1076' '#1088#1091#1095#1085#1086#1081' '#1086#1073#1088#1072#1073#1086#1090#1082#1080
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NIDENT'
          Title.Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1087#1088#1086#1094#1077#1089#1089#1072
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NErrCode'
          Title.Caption = #1050#1086#1076' '#1086#1096#1080#1073#1082#1080
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SErrMsg'
          Title.Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077' '#1086#1073' '#1086#1096#1080#1073#1082#1077
          Width = 500
          Visible = True
        end>
    end
  end
  object pnlGridSlave: TPanel
    Left = 0
    Top = 460
    Width = 1289
    Height = 177
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlGridSlave'
    Constraints.MinHeight = 50
    Constraints.MinWidth = 50
    TabOrder = 3
    object GridSlave: TDBGrid
      Left = 0
      Top = 27
      Width = 1289
      Height = 150
      Align = alClient
      BorderStyle = bsNone
      Ctl3D = False
      DataSource = DMJOPH.dsQueSlave
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = GridSlaveDrawColumnCell
      OnTitleClick = GridSlaveTitleClick
      Columns = <
        item
          Expanded = False
          FieldName = 'SPharmacy'
          Title.Caption = #1058#1086#1088#1075#1086#1074#1072#1103' '#1090#1086#1095#1082#1072
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NArtCode'
          Title.Caption = #1040#1088#1090#1050#1086#1076
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SNomenclature'
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1090#1086#1074#1072#1088#1085#1086#1081' '#1087#1086#1079#1080#1094#1080#1080
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NErrNumb'
          Title.Caption = #1050#1086#1076' '#1086#1096#1080#1073#1082#1080
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SErrMsg'
          Title.Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077' '#1086#1073' '#1086#1096#1080#1073#1082#1077
          Width = 600
          Visible = True
        end>
    end
    object pnlSlaveControl: TPanel
      Left = 0
      Top = 0
      Width = 1289
      Height = 27
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Bevel1: TBevel
        Left = 0
        Top = 26
        Width = 1289
        Height = 1
        Align = alBottom
        Shape = bsTopLine
      end
      object pnlSlaveControl_Show: TPanel
        Left = 1209
        Top = 0
        Width = 80
        Height = 26
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
      end
    end
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 1176
    Top = 117
    object aExit: TAction
      Category = 'Tool'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
    object aForcedClose: TAction
      Category = 'Tool'
      Caption = #1055#1088#1080#1085#1091#1076#1080#1090#1077#1083#1100#1085#1086' '#1079#1072#1082#1088#1099#1090#1100' '
      ImageIndex = 204
      OnExecute = aForcedCloseExecute
    end
  end
end
