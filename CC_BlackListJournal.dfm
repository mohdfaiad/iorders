object frmCC_BlackListJournal: TfrmCC_BlackListJournal
  Left = 28
  Top = 205
  Width = 919
  Height = 623
  Caption = #1063#1077#1088#1085#1099#1081' '#1089#1087#1080#1089#1086#1082
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
  object splitGridMain: TSplitter
    Left = 0
    Top = 361
    Width = 903
    Height = 3
    Cursor = crVSplit
    Align = alTop
    Beveled = True
  end
  object pnlSearch: TPanel
    Left = 0
    Top = 0
    Width = 903
    Height = 26
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    TabOrder = 0
    object pnlSearch_Fields: TPanel
      Left = 33
      Top = 0
      Width = 870
      Height = 26
      Align = alRight
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 0
      object lblSearch_Phone: TLabel
        Left = 7
        Top = 7
        Width = 45
        Height = 13
        Caption = #1058#1077#1083#1077#1092#1086#1085
      end
      object lblSearch_Client: TLabel
        Left = 230
        Top = 10
        Width = 36
        Height = 13
        Caption = #1050#1083#1080#1077#1085#1090
      end
      object lblSearch_City: TLabel
        Left = 464
        Top = 10
        Width = 30
        Height = 13
        Caption = #1043#1086#1088#1086#1076
      end
      object edSearch_Phone: TEdit
        Left = 55
        Top = 2
        Width = 160
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        MaxLength = 100
        TabOrder = 0
        OnChange = aSearchChangeFieldsExecute
      end
      object edSearch_Client: TEdit
        Left = 269
        Top = 2
        Width = 180
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        MaxLength = 160
        TabOrder = 1
        OnChange = aSearchChangeFieldsExecute
      end
      object edSearch_City: TEdit
        Left = 498
        Top = 2
        Width = 180
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        MaxLength = 100
        TabOrder = 2
        OnChange = aSearchChangeFieldsExecute
      end
    end
    object pnlSearch_Tool: TPanel
      Left = 0
      Top = 0
      Width = 33
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object tBarSearch: TToolBar
        Left = 0
        Top = 0
        Width = 33
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        Caption = 'tBarSearch'
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
        object tbtnSearch_Clear: TToolButton
          Left = 0
          Top = 0
          Action = aSearchClear
          AutoSize = True
        end
      end
    end
  end
  object pnlTool: TPanel
    Left = 0
    Top = 26
    Width = 903
    Height = 26
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    TabOrder = 1
    object pnlTool_Show: TPanel
      Left = 718
      Top = 0
      Width = 185
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
    end
    object pnlTool_Control: TPanel
      Left = 0
      Top = 0
      Width = 718
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlGridMain: TPanel
    Left = 0
    Top = 52
    Width = 903
    Height = 309
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Constraints.MinHeight = 80
    Constraints.MinWidth = 80
    TabOrder = 2
    object GridMain: TDBGrid
      Left = 0
      Top = 0
      Width = 903
      Height = 309
      Align = alClient
      BorderStyle = bsNone
      Ctl3D = False
      DataSource = dsMain
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
      Columns = <
        item
          Expanded = False
          FieldName = 'SPhone'
          Title.Caption = #1058#1077#1076#1077#1092#1086#1085
          Width = 160
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SClient'
          Title.Caption = #1050#1083#1080#1077#1085#1090
          Width = 370
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SCity'
          Title.Caption = #1043#1086#1088#1086#1076
          Width = 310
          Visible = True
        end>
    end
  end
  object pnlGridSlave: TPanel
    Left = 0
    Top = 364
    Width = 903
    Height = 221
    Align = alClient
    BevelOuter = bvNone
    Constraints.MinHeight = 80
    Constraints.MinWidth = 80
    TabOrder = 3
    object pnlGridSlave_Tool: TPanel
      Left = 0
      Top = 0
      Width = 903
      Height = 26
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 0
      object pnlGridSlave_Tool_Show: TPanel
        Left = 718
        Top = 0
        Width = 185
        Height = 26
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
      end
      object pnlGridSlave_Tool_Control: TPanel
        Left = 0
        Top = 0
        Width = 718
        Height = 26
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
      end
    end
    object GridSlave: TDBGrid
      Left = 0
      Top = 26
      Width = 903
      Height = 195
      Align = alClient
      BorderStyle = bsNone
      Ctl3D = False
      DataSource = dsSlave
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = GridSlaveDrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'SOpenDate'
          Title.Caption = #1054#1090#1082#1088#1099#1090#1086
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SCloseDate'
          Title.Caption = #1047#1072#1082#1088#1099#1090#1086
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SNote'
          Title.Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
          Width = 580
          Visible = True
        end>
    end
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 728
    Top = 101
    object aClose: TAction
      Category = 'Control'
      Caption = 'aClose'
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aCloseExecute
    end
    object aSearchClear: TAction
      Category = 'Tool'
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1091#1089#1083#1086#1074#1080#1077' '#1086#1090#1073#1086#1088#1072
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1091#1089#1083#1086#1074#1080#1077' '#1086#1090#1073#1086#1088#1072
      ImageIndex = 40
      OnExecute = aSearchClearExecute
    end
    object aSearchChangeFields: TAction
      Category = 'Tool'
      Caption = 'aSearchChangeFields'
      OnExecute = aSearchChangeFieldsExecute
    end
  end
  object dsMain: TDataSource
    DataSet = spdsMain
    OnDataChange = dsMainDataChange
    Left = 624
    Top = 100
  end
  object spdsMain: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 200
    ProcedureName = 'pDS_jso_BlackList;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@Phone'
        Attributes = [paNullable]
        DataType = ftString
        Size = 160
        Value = ''
      end
      item
        Name = '@Client'
        Attributes = [paNullable]
        DataType = ftString
        Size = 160
        Value = ''
      end
      item
        Name = '@City'
        Attributes = [paNullable]
        DataType = ftString
        Size = 160
        Value = ''
      end>
    Left = 672
    Top = 100
  end
  object spdsSlave: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_BalckListSp;1'
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
      end>
    Left = 680
    Top = 404
  end
  object dsSlave: TDataSource
    DataSet = spdsSlave
    Left = 617
    Top = 405
  end
end
