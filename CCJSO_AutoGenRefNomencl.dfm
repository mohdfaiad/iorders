object frmAutoGenRefNomencl: TfrmAutoGenRefNomencl
  Left = 2008
  Top = 344
  Width = 859
  Height = 675
  Caption = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072' '#1079#1072#1082#1072#1079#1086#1074
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
  object pnlSelect: TPanel
    Left = 0
    Top = 611
    Width = 843
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlSelect'
    TabOrder = 0
    object pnlSelect_Tool: TPanel
      Left = 679
      Top = 0
      Width = 164
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlSelect_Tool'
      TabOrder = 0
      object tbarSelect: TToolBar
        Left = 0
        Top = 0
        Width = 164
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 71
        Caption = 'tbarSelect'
        DisabledImages = FCCenterJournalNetZkz.imgMainDisable
        EdgeBorders = []
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tbtnSelect_Ok: TToolButton
          Left = 0
          Top = 0
          Action = aSelect
          AutoSize = True
        end
        object tbtnSelect_Exit: TToolButton
          Left = 75
          Top = 0
          Action = aExit
          AutoSize = True
        end
      end
    end
    object pnlSelect_Show: TPanel
      Left = 0
      Top = 0
      Width = 679
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlCond: TPanel
    Left = 0
    Top = 0
    Width = 843
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlCond'
    TabOrder = 1
    object pnlCond_Tool: TPanel
      Left = 0
      Top = 0
      Width = 62
      Height = 26
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object tbarCond: TToolBar
        Left = 0
        Top = 0
        Width = 62
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        Caption = 'tbarCond'
        DisabledImages = FCCenterJournalNetZkz.imgMainDisable
        EdgeBorders = [ebRight]
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object tbtnCond_Exec: TToolButton
          Left = 0
          Top = 0
          Action = aCondExec
          AutoSize = True
        end
        object tbtnCond_Clear: TToolButton
          Left = 27
          Top = 0
          Action = aClearCond
          AutoSize = True
        end
      end
    end
    object pnlCond_Fields: TPanel
      Left = 62
      Top = 0
      Width = 781
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object lblCond_ArtCode: TLabel
        Left = 7
        Top = 8
        Width = 37
        Height = 13
        Caption = #1040#1088#1090#1050#1086#1076
      end
      object lblCond_Name: TLabel
        Left = 178
        Top = 9
        Width = 76
        Height = 13
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      end
      object edCond_ArtCode: TEdit
        Left = 47
        Top = 3
        Width = 120
        Height = 19
        BevelKind = bkFlat
        BorderStyle = bsNone
        MaxLength = 20
        TabOrder = 0
        OnChange = aChangeCondExecute
        OnClick = aCondFieldsClickExecute
      end
      object edCond_Name: TEdit
        Left = 258
        Top = 3
        Width = 200
        Height = 19
        BevelKind = bkFlat
        BorderStyle = bsNone
        MaxLength = 100
        TabOrder = 1
        OnChange = aChangeCondExecute
        OnClick = aCondFieldsClickExecute
      end
    end
  end
  object pnlControl: TPanel
    Left = 0
    Top = 26
    Width = 843
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlControl'
    TabOrder = 2
    object pnlControl_Show: TPanel
      Left = 749
      Top = 0
      Width = 94
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
    end
    object pnlControl_Tool: TPanel
      Left = 0
      Top = 0
      Width = 749
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object tbarControl: TToolBar
        Left = 0
        Top = 0
        Width = 749
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 76
        Caption = 'tbarControl'
        DisabledImages = FCCenterJournalNetZkz.imgMainDisable
        EdgeBorders = []
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Action = aRefresh
          AutoSize = True
        end
      end
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 52
    Width = 843
    Height = 559
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlGrid'
    TabOrder = 3
    object GridMain: TDBGrid
      Left = 0
      Top = 0
      Width = 843
      Height = 559
      Align = alClient
      BorderStyle = bsNone
      DataSource = dsMain
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = GridMainDrawColumnCell
      OnDblClick = GridMainDblClick
      OnTitleClick = GridMainTitleClick
      Columns = <
        item
          Expanded = False
          FieldName = 'SRN'
          Title.Caption = #1040#1088#1090#1050#1086#1076
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SNomenclature'
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 700
          Visible = True
        end>
    end
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 648
    Top = 116
    object aExit: TAction
      Category = 'Select'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
    object aSelect: TAction
      Category = 'Select'
      Caption = #1042#1099#1073#1088#1072#1090#1100
      ImageIndex = 36
      OnExecute = aSelectExecute
    end
    object aClearCond: TAction
      Category = 'Condition'
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1091#1083#1086#1074#1080#1103' '#1086#1090#1073#1086#1088#1072
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1091#1083#1086#1074#1080#1103' '#1086#1090#1073#1086#1088#1072
      ImageIndex = 40
      OnExecute = aClearCondExecute
    end
    object aRefresh: TAction
      Category = 'Control'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 4
      OnExecute = aRefreshExecute
    end
    object aChangeCond: TAction
      Category = 'Condition'
      Caption = 'aChangeCond'
      OnExecute = aChangeCondExecute
    end
    object aCondExec: TAction
      Category = 'Condition'
      Caption = 'aCondExec'
      ImageIndex = 180
      OnExecute = aCondExecExecute
    end
    object aCondFieldsClick: TAction
      Category = 'Condition'
      Caption = 'aCondFieldsClick'
      OnExecute = aCondFieldsClickExecute
    end
  end
  object qrspMain: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_AutoGenRefNomenclature;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@ArtCode'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@Name'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = ''
      end
      item
        Name = '@OrderBy'
        Attributes = [paNullable]
        DataType = ftString
        Size = 40
        Value = ''
      end
      item
        Name = '@Direction'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = False
      end>
    Left = 704
    Top = 117
  end
  object dsMain: TDataSource
    DataSet = qrspMain
    Left = 760
    Top = 116
  end
end
