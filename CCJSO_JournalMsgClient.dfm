object frmCCJSO_JournalMsgClient: TfrmCCJSO_JournalMsgClient
  Left = 189
  Top = 189
  Width = 1305
  Height = 675
  Caption = #1046#1091#1088#1085#1072#1083' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080' '#1086#1090#1087#1088#1072#1074#1082#1080' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1081' '#1082#1083#1080#1077#1085#1090#1072#1084' '
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
      Width = 35
      Height = 26
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'pnlCond_Tool'
      TabOrder = 0
      object tbarCond: TToolBar
        Left = 0
        Top = 0
        Width = 35
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
        object tbtnCondClear: TToolButton
          Left = 0
          Top = 0
          Action = aCondClear
          AutoSize = True
        end
      end
    end
    object pnlCond_Fields: TPanel
      Left = 35
      Top = 0
      Width = 1254
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object lblCond_Begin: TLabel
        Left = 5
        Top = 9
        Width = 6
        Height = 13
        Caption = #1089
      end
      object lblJCond_End: TLabel
        Left = 144
        Top = 10
        Width = 12
        Height = 13
        Caption = #1087#1086
      end
      object lblJCond_Prefix: TLabel
        Left = 292
        Top = 10
        Width = 46
        Height = 13
        Caption = #1055#1088#1077#1092#1080#1082#1089
      end
      object lblCond_Order: TLabel
        Left = 432
        Top = 10
        Width = 31
        Height = 13
        Caption = #1047#1072#1082#1072#1079
      end
      object lblCond_Phone: TLabel
        Left = 557
        Top = 10
        Width = 45
        Height = 13
        Caption = #1058#1077#1083#1077#1092#1086#1085
      end
      object lblCond_Pharm: TLabel
        Left = 719
        Top = 10
        Width = 79
        Height = 13
        Caption = #1058#1086#1088#1075#1086#1074#1072#1103' '#1090#1086#1095#1082#1072
      end
      object lblCond_Type: TLabel
        Left = 913
        Top = 11
        Width = 89
        Height = 13
        Caption = #1058#1080#1087' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1103
      end
      object edCond_Begin: TEdit
        Tag = 10
        Left = 14
        Top = 3
        Width = 125
        Height = 20
        BevelKind = bkFlat
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
        OnChange = aCondChangeExecute
        OnDblClick = aSlDateExecute
      end
      object btnCond_Begin: TButton
        Tag = 10
        Left = 119
        Top = 5
        Width = 18
        Height = 16
        Action = aSlDate
        TabOrder = 1
      end
      object edCond_End: TEdit
        Tag = 11
        Left = 159
        Top = 3
        Width = 125
        Height = 20
        BevelKind = bkFlat
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 2
        OnChange = aCondChangeExecute
        OnDblClick = aSlDateExecute
      end
      object btnCond_End: TButton
        Tag = 11
        Left = 264
        Top = 5
        Width = 18
        Height = 16
        Action = aSlDate
        TabOrder = 3
      end
      object cmbxCond_Prefix: TComboBox
        Left = 341
        Top = 3
        Width = 82
        Height = 21
        BevelKind = bkFlat
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 4
        Text = #1042#1089#1077
        OnChange = aCondChangeExecute
        Items.Strings = (
          #1042#1089#1077)
      end
      object edCond_Order: TEdit
        Tag = 15
        Left = 467
        Top = 3
        Width = 80
        Height = 20
        BevelKind = bkFlat
        BorderStyle = bsNone
        MaxLength = 20
        TabOrder = 5
        OnChange = aCondChangeExecute
      end
      object edCond_Phone: TEdit
        Tag = 15
        Left = 606
        Top = 3
        Width = 100
        Height = 20
        BevelKind = bkFlat
        BorderStyle = bsNone
        MaxLength = 20
        TabOrder = 6
        OnChange = aCondChangeExecute
      end
      object edCond_Pharm: TEdit
        Tag = 15
        Left = 804
        Top = 3
        Width = 100
        Height = 20
        BevelKind = bkFlat
        BorderStyle = bsNone
        MaxLength = 20
        TabOrder = 7
        OnChange = aCondChangeExecute
      end
      object cmbxCond_Type: TComboBox
        Left = 1006
        Top = 3
        Width = 237
        Height = 21
        BevelKind = bkFlat
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 8
        Text = #1042#1089#1077
        OnChange = aCondChangeExecute
        Items.Strings = (
          #1042#1089#1077)
      end
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 26
    Width = 1289
    Height = 611
    Align = alClient
    Caption = 'pnlGrid'
    TabOrder = 1
    object pnlGridControl: TPanel
      Left = 1
      Top = 1
      Width = 1287
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlGridControl'
      TabOrder = 0
      object pnlGridControl_Show: TPanel
        Left = 1102
        Top = 0
        Width = 185
        Height = 26
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
      end
      object pnlGridControl_Tool: TPanel
        Left = 0
        Top = 0
        Width = 1102
        Height = 26
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlGridControl_Tool'
        TabOrder = 1
        object tbarTool: TToolBar
          Left = 0
          Top = 0
          Width = 1102
          Height = 26
          Align = alClient
          AutoSize = True
          BorderWidth = 1
          ButtonWidth = 178
          Caption = 'tbarTool'
          DisabledImages = FCCenterJournalNetZkz.imgMain
          EdgeBorders = []
          Flat = True
          Images = FCCenterJournalNetZkz.imgMain
          List = True
          ShowCaptions = True
          TabOrder = 0
          object tbtnItemInfo: TToolButton
            Left = 0
            Top = 0
            Action = aItemInfo
            AutoSize = True
          end
          object tbtbRefresh: TToolButton
            Left = 182
            Top = 0
            Action = aRefresh
            AutoSize = True
          end
        end
      end
    end
    object GridMain: TDBGrid
      Left = 1
      Top = 27
      Width = 1287
      Height = 583
      Align = alClient
      BorderStyle = bsNone
      Ctl3D = False
      DataSource = dsMain
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 1
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
          Title.Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SSMSType'
          Title.Caption = #1058#1080#1087' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1103
          Width = 200
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
          FieldName = 'SPharm'
          Title.Caption = #1058#1086#1088#1075#1086#1074#1072#1103' '#1090#1086#1095#1082#1072
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SPhone'
          Title.Caption = #1058#1077#1083#1077#1092#1086#1085
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NCash'
          Title.Caption = #1057#1091#1084#1084#1072
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SEmail'
          Title.Caption = 'EMail'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SNote'
          Title.Caption = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1103
          Width = 500
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SUSER'
          Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IErr'
          Title.Caption = #1050#1086#1076' '#1086#1096#1080#1073#1082#1080
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SErr'
          Title.Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077' '#1086#1073' '#1086#1096#1080#1073#1082#1077
          Width = 300
          Visible = True
        end>
    end
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 720
    Top = 74
    object aExit: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
    object aItemInfo: TAction
      Category = 'Control'
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1080
      ImageIndex = 16
      OnExecute = aItemInfoExecute
    end
    object aRefresh: TAction
      Category = 'Control'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 4
      OnExecute = aRefreshExecute
    end
    object aCondClear: TAction
      Category = 'Condition'
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1091#1089#1083#1086#1074#1080#1103' '#1086#1090#1073#1086#1088#1072
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1091#1089#1083#1086#1074#1080#1103' '#1086#1090#1073#1086#1088#1072
      ImageIndex = 40
      OnExecute = aCondClearExecute
    end
    object aCondChange: TAction
      Category = 'Condition'
      Caption = 'aCondChange'
      OnExecute = aCondChangeExecute
    end
    object aSlDate: TAction
      Category = 'Condition'
      Caption = #8230
      OnExecute = aSlDateExecute
    end
  end
  object qrspMain: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_RegSMS;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
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
      end
      item
        Name = '@Order'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@Pharm'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@Prefix'
        Attributes = [paNullable]
        DataType = ftString
        Size = 10
        Value = ''
      end
      item
        Name = '@Phone'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@Type'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
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
    Left = 776
    Top = 74
  end
  object dsMain: TDataSource
    DataSet = qrspMain
    Left = 840
    Top = 74
  end
  object qrspSMSType: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_RegSMS_NameType;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@SMSType'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end>
    Left = 912
    Top = 82
  end
end
