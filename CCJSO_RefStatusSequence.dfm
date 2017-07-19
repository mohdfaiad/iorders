object frmCCJSO_RefStatusSequence: TfrmCCJSO_RefStatusSequence
  Left = 2515
  Top = 39
  Width = 1093
  Height = 651
  Caption = #1055#1086#1089#1083#1077#1076#1086#1074#1072#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1089#1090#1072#1090#1091#1089#1086#1074' '#1079#1072#1082#1072#1079#1072
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
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object splitHier: TSplitter
    Left = 488
    Top = 0
    Height = 568
    Beveled = True
    OnMoved = splitHierMoved
  end
  object pnlHier: TPanel
    Left = 0
    Top = 0
    Width = 488
    Height = 568
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'pnlHier'
    Constraints.MinHeight = 70
    Constraints.MinWidth = 70
    TabOrder = 0
    object pnlHierControl: TPanel
      Left = 0
      Top = 0
      Width = 488
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlHierControl'
      TabOrder = 0
      object pnlHierControl_Show: TPanel
        Left = 439
        Top = 0
        Width = 49
        Height = 26
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
      end
      object pnlHierControl_Tool: TPanel
        Left = 0
        Top = 0
        Width = 439
        Height = 26
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlHierControl_Tool'
        TabOrder = 1
        object tbarHier: TToolBar
          Left = 0
          Top = 0
          Width = 439
          Height = 26
          Align = alClient
          AutoSize = True
          BorderWidth = 1
          Caption = 'tbarMain'
          DisabledImages = FCCenterJournalNetZkz.imgMainDisable
          EdgeBorders = []
          EdgeInner = esNone
          EdgeOuter = esNone
          Flat = True
          Images = FCCenterJournalNetZkz.imgMain
          List = True
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object tbtnHier_Add: TToolButton
            Left = 0
            Top = 0
            Action = aHierAdd
            AutoSize = True
          end
          object tbtnHier_Multi: TToolButton
            Left = 27
            Top = 0
            Action = aHierMulti
            AutoSize = True
          end
          object tbtnHier_Edit: TToolButton
            Left = 54
            Top = 0
            Action = aHierEdit
            AutoSize = True
          end
          object tbtnHier_Del: TToolButton
            Left = 81
            Top = 0
            Action = aHierDel
            AutoSize = True
          end
        end
      end
    end
    object pnlHierTree: TPanel
      Left = 0
      Top = 26
      Width = 488
      Height = 542
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnlHierTree'
      TabOrder = 1
      object trvStatusSeq: TTreeView
        Left = 0
        Top = 0
        Width = 488
        Height = 542
        Align = alClient
        BorderStyle = bsNone
        Indent = 19
        PopupMenu = pmHier
        ReadOnly = True
        RowSelect = True
        SortType = stText
        TabOrder = 0
        OnAdvancedCustomDrawItem = trvStatusSeqAdvancedCustomDrawItem
        OnChange = trvStatusSeqChange
        OnClick = trvStatusSeqClick
        OnCustomDrawItem = trvStatusSeqCustomDrawItem
      end
    end
  end
  object pnlStatus: TPanel
    Left = 0
    Top = 568
    Width = 1077
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlState'
    TabOrder = 1
    object stBarMain: TStatusBar
      Left = 0
      Top = 26
      Width = 1077
      Height = 19
      Panels = <>
      SimplePanel = True
    end
    object pnlStatusControl: TPanel
      Left = 0
      Top = 0
      Width = 1077
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlStatusControl'
      TabOrder = 1
      object pnlStatusControl_Tool: TPanel
        Left = 916
        Top = 0
        Width = 161
        Height = 26
        Align = alRight
        BevelOuter = bvNone
        Caption = 'pnlStatusControl_Tool'
        TabOrder = 0
        object tbarControl: TToolBar
          Left = 0
          Top = 0
          Width = 161
          Height = 26
          Align = alClient
          AutoSize = True
          BorderWidth = 1
          ButtonWidth = 71
          Caption = 'tbarControl'
          DisabledImages = FCCenterJournalNetZkz.imgMainDisable
          EdgeBorders = []
          EdgeInner = esNone
          EdgeOuter = esNone
          Flat = True
          Images = FCCenterJournalNetZkz.imgMain
          List = True
          ShowCaptions = True
          TabOrder = 0
          object ToolButton1: TToolButton
            Left = 0
            Top = 0
            Action = aSelect
            AutoSize = True
          end
          object ToolButton2: TToolButton
            Left = 75
            Top = 0
            Action = aExit
            AutoSize = True
          end
        end
      end
      object pnlStatusControl_Show: TPanel
        Left = 0
        Top = 0
        Width = 916
        Height = 26
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
      end
    end
  end
  object pnlRef: TPanel
    Left = 491
    Top = 0
    Width = 586
    Height = 568
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlRef'
    Constraints.MinHeight = 70
    Constraints.MinWidth = 70
    TabOrder = 2
    object splitRefMain: TSplitter
      Left = 0
      Top = 209
      Width = 586
      Height = 3
      Cursor = crVSplit
      Align = alTop
      Beveled = True
      OnMoved = splitRefMainMoved
    end
    object pnlRefMain: TPanel
      Left = 0
      Top = 0
      Width = 586
      Height = 209
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlRefMain'
      Constraints.MinHeight = 70
      Constraints.MinWidth = 70
      TabOrder = 0
      object pnlRefMainControl: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 26
        Align = alTop
        BevelOuter = bvNone
        Caption = 'pnlRefMainControl'
        TabOrder = 0
        object pnlRefMainControl_Show: TPanel
          Left = 526
          Top = 0
          Width = 60
          Height = 26
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
        end
        object pnlRefMainControl_Tool: TPanel
          Left = 0
          Top = 0
          Width = 526
          Height = 26
          Align = alClient
          BevelOuter = bvNone
          Caption = 'pnlRefMainControl_Tool'
          TabOrder = 1
          object tbarMain: TToolBar
            Left = 0
            Top = 0
            Width = 526
            Height = 26
            Align = alClient
            AutoSize = True
            BorderWidth = 1
            Caption = 'tbarMain'
            DisabledImages = FCCenterJournalNetZkz.imgMainDisable
            EdgeBorders = []
            EdgeInner = esNone
            EdgeOuter = esNone
            Flat = True
            Images = FCCenterJournalNetZkz.imgMain
            List = True
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnMouseMove = tbarMainMouseMove
            object tbtnMain_Add: TToolButton
              Left = 0
              Top = 0
              Action = aMainAdd
              AutoSize = True
            end
            object tbtnMain_Multi: TToolButton
              Left = 27
              Top = 0
              Action = aMainMulti
              AutoSize = True
            end
            object tbtnMain_Edit: TToolButton
              Left = 54
              Top = 0
              Action = aMainEdit
              AutoSize = True
            end
            object tbtnMain_Del: TToolButton
              Left = 81
              Top = 0
              Action = aMainDel
              AutoSize = True
            end
          end
        end
      end
      object pnlRefMainGrid: TPanel
        Left = 0
        Top = 26
        Width = 586
        Height = 183
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlRefMainGrid'
        TabOrder = 1
        object MainGrid: TDBGrid
          Left = 0
          Top = 0
          Width = 586
          Height = 183
          Align = alClient
          BorderStyle = bsNone
          Ctl3D = False
          DataSource = dsMain
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
          ParentCtl3D = False
          PopupMenu = pmMain
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDrawColumnCell = MainGridDrawColumnCell
          OnDblClick = MainGridDblClick
          OnMouseMove = MainGridMouseMove
          Columns = <
            item
              Expanded = False
              FieldName = 'SSeqStatusName'
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1086#1089#1083#1077#1076#1086#1074#1072#1090#1077#1083#1100#1085#1086#1089#1090#1080
              Width = 569
              Visible = True
            end>
        end
      end
    end
    object pnlRefSlave: TPanel
      Left = 0
      Top = 212
      Width = 586
      Height = 356
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnlRefSlave'
      TabOrder = 1
      object pnlRefSlaveControl: TPanel
        Left = 0
        Top = 0
        Width = 586
        Height = 26
        Align = alTop
        BevelOuter = bvNone
        Caption = 'pnlRefSlaveControl'
        TabOrder = 0
        object pnlRefSlaveControl_Show: TPanel
          Left = 526
          Top = 0
          Width = 60
          Height = 26
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
        end
        object pnlRefSlaveControl_Tool: TPanel
          Left = 0
          Top = 0
          Width = 526
          Height = 26
          Align = alClient
          BevelOuter = bvNone
          Caption = 'pnlRefSlaveControl_Tool'
          TabOrder = 1
          object tbarSlave: TToolBar
            Left = 0
            Top = 0
            Width = 526
            Height = 26
            Align = alClient
            AutoSize = True
            BorderWidth = 1
            Caption = 'tbarMain'
            DisabledImages = FCCenterJournalNetZkz.imgMainDisable
            EdgeBorders = []
            EdgeInner = esNone
            EdgeOuter = esNone
            Flat = True
            Images = FCCenterJournalNetZkz.imgMain
            List = True
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnMouseMove = tbarSlaveMouseMove
            object tbtnSlave_Add: TToolButton
              Left = 0
              Top = 0
              Action = aSlaveAdd
              AutoSize = True
            end
            object tbtnSlave_Multi: TToolButton
              Left = 27
              Top = 0
              Action = aSlaveMulti
              AutoSize = True
            end
            object tbtnSlave_Edit: TToolButton
              Left = 54
              Top = 0
              Action = aSlaveEdit
              AutoSize = True
            end
            object tbtnSlave_Del: TToolButton
              Left = 81
              Top = 0
              Action = aSlaveDel
              AutoSize = True
            end
          end
        end
      end
      object pnlpnlRefSlaveGrid: TPanel
        Left = 0
        Top = 26
        Width = 586
        Height = 330
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlpnlRefSlaveGrid'
        TabOrder = 1
        object SlaveGrid: TDBGrid
          Left = 0
          Top = 0
          Width = 586
          Height = 330
          Align = alClient
          BorderStyle = bsNone
          Ctl3D = False
          DataSource = dsSlave
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ParentCtl3D = False
          PopupMenu = pmSlave
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDrawColumnCell = SlaveGridDrawColumnCell
          OnMouseMove = SlaveGridMouseMove
          Columns = <
            item
              Expanded = False
              FieldName = 'SStatus'
              Title.Caption = #1057#1090#1072#1090#1091#1089
              Width = 500
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SSignUse'
              Title.Caption = #1044#1086#1089#1090#1091#1087#1085#1086
              Width = 55
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SChangeDate'
              Title.Caption = #1044#1072#1090#1072' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1103
              Width = 125
              Visible = True
            end>
        end
      end
    end
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 996
    Top = 32
    object aMainAdd: TAction
      Category = 'RefMain'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 27
      OnExecute = aMainAddExecute
    end
    object aMainEdit: TAction
      Category = 'RefMain'
      Caption = #1048#1089#1087#1088#1072#1074#1080#1090#1100
      Hint = #1048#1089#1087#1088#1072#1074#1080#1090#1100
      ImageIndex = 229
      OnExecute = aMainEditExecute
    end
    object aMainDel: TAction
      Category = 'RefMain'
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 144
      OnExecute = aMainDelExecute
    end
    object aMainMulti: TAction
      Category = 'RefMain'
      Caption = #1056#1072#1079#1084#1085#1086#1078#1080#1090#1100
      Hint = #1056#1072#1079#1084#1085#1086#1078#1080#1090#1100
      ImageIndex = 373
      OnExecute = aMainMultiExecute
    end
    object aSlaveAdd: TAction
      Category = 'RefSlave'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 27
      OnExecute = aSlaveAddExecute
    end
    object aSlaveEdit: TAction
      Category = 'RefSlave'
      Caption = #1048#1089#1087#1088#1072#1074#1080#1090#1100
      Hint = #1048#1089#1087#1088#1072#1074#1080#1090#1100
      ImageIndex = 229
      OnExecute = aSlaveEditExecute
    end
    object aSlaveDel: TAction
      Category = 'RefSlave'
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 144
      OnExecute = aSlaveDelExecute
    end
    object aSlaveMulti: TAction
      Category = 'RefSlave'
      Caption = #1056#1072#1079#1084#1085#1086#1078#1080#1090#1100
      Hint = #1056#1072#1079#1084#1085#1086#1078#1080#1090#1100
      ImageIndex = 373
      OnExecute = aSlaveMultiExecute
    end
    object aHierAdd: TAction
      Category = 'Hier'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 27
      OnExecute = aHierAddExecute
    end
    object aHierEdit: TAction
      Category = 'Hier'
      Caption = #1048#1089#1087#1088#1072#1074#1080#1090#1100
      Hint = #1048#1089#1087#1088#1072#1074#1080#1090#1100
      ImageIndex = 229
      OnExecute = aHierEditExecute
    end
    object aHierDel: TAction
      Category = 'Hier'
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 144
      OnExecute = aHierDelExecute
    end
    object aHierMulti: TAction
      Category = 'Hier'
      Caption = #1056#1072#1079#1084#1085#1086#1078#1080#1090#1100
      Hint = #1056#1072#1079#1084#1085#1086#1078#1080#1090#1100
      ImageIndex = 373
      OnExecute = aHierMultiExecute
    end
    object aExit: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
    object aSelect: TAction
      Category = 'Control'
      Caption = #1042#1099#1073#1088#1072#1090#1100
      ImageIndex = 7
      OnExecute = aSelectExecute
    end
  end
  object qrspMain: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 60
    ProcedureName = 'pDS_jso_RefStatusSequence;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end>
    Left = 556
    Top = 74
  end
  object dsMain: TDataSource
    DataSet = qrspMain
    OnDataChange = dsMainDataChange
    Left = 508
    Top = 74
  end
  object qrspSlave: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 60
    ProcedureName = 'pDS_jso_RefStatusSequenceSp;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@PRN'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@ParentRN'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@Status'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = ''
      end>
    Left = 564
    Top = 286
  end
  object dsSlave: TDataSource
    DataSet = qrspSlave
    Left = 508
    Top = 286
  end
  object spMainDel: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 200
    ProcedureName = 'p_jso_RefStatusSequence_Delete;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@USER'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@NRN'
        Attributes = [paNullable]
        DataType = ftInteger
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
    Left = 612
    Top = 74
  end
  object pmMain: TPopupMenu
    Images = FCCenterJournalNetZkz.imgMain
    Left = 675
    Top = 74
    object pmiMain_Add: TMenuItem
      Action = aMainAdd
    end
    object pmiMain_Multi: TMenuItem
      Action = aMainMulti
    end
    object pmiMain_Edit: TMenuItem
      Action = aMainEdit
    end
    object pmiMain_Del: TMenuItem
      Action = aMainDel
    end
  end
  object qrspHier: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_RefStatusSequence_Hier;1'
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
        Name = '@RN'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@SignShowRN'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = False
      end
      item
        Name = '@Level'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end>
    Left = 27
    Top = 54
  end
  object spHier_Insert: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_RefStatusSequenceSp_Insert;1'
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
        Name = '@PRN'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@OrderStatus'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = ''
      end
      item
        Name = '@ParentRN'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@RN'
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
    Left = 32
    Top = 114
  end
  object pmHier: TPopupMenu
    Images = FCCenterJournalNetZkz.imgMain
    Left = 96
    Top = 54
    object pmiHier_Add: TMenuItem
      Action = aHierAdd
    end
    object pmiHier_Multi: TMenuItem
      Action = aHierMulti
    end
    object pmiHier_Edit: TMenuItem
      Action = aHierEdit
    end
    object pmiHier_Del: TMenuItem
      Action = aHierDel
    end
  end
  object pmSlave: TPopupMenu
    Images = FCCenterJournalNetZkz.imgMain
    Left = 635
    Top = 286
    object pmiSlave_Add: TMenuItem
      Action = aSlaveAdd
    end
    object pmiSlave_Multi: TMenuItem
      Action = aSlaveMulti
    end
    object pmiSlave_Edit: TMenuItem
      Action = aSlaveEdit
    end
    object pmiSlave_Del: TMenuItem
      Action = aSlaveDel
    end
  end
  object spHier_Del: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_RefStatusSequenceSp_Delete;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@USER'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@RN'
        Attributes = [paNullable]
        DataType = ftInteger
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
    Left = 96
    Top = 113
  end
end
