object frmCCJSO_VersionContent: TfrmCCJSO_VersionContent
  Left = 18
  Top = 270
  Width = 1028
  Height = 680
  Caption = #1061#1088#1086#1085#1086#1083#1086#1075#1080#1103' '#1088#1072#1079#1088#1072#1073#1086#1090#1082#1080
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
  object pnlControl: TPanel
    Left = 0
    Top = 0
    Width = 1012
    Height = 26
    Align = alTop
    Caption = 'pnlControl'
    TabOrder = 0
    object pnlControl_Show: TPanel
      Left = 880
      Top = 1
      Width = 131
      Height = 24
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
    end
    object pnlControl_Find: TPanel
      Left = 1
      Top = 1
      Width = 879
      Height = 24
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 1
      object lblCndContents: TLabel
        Left = 7
        Top = 7
        Width = 31
        Height = 13
        Caption = #1053#1072#1081#1090#1080
      end
      object edCndContents: TEdit
        Left = 42
        Top = 2
        Width = 300
        Height = 19
        BevelKind = bkFlat
        BorderStyle = bsNone
        TabOrder = 0
        OnChange = edCndContentsChange
      end
    end
  end
  object pnlVers: TPanel
    Left = 0
    Top = 26
    Width = 1012
    Height = 616
    Align = alClient
    BevelOuter = bvNone
    Constraints.MinHeight = 100
    Constraints.MinWidth = 100
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 1
    object splitVers_Catalog: TSplitter
      Left = 250
      Top = 0
      Height = 616
      Beveled = True
      OnMoved = splitVers_CatalogMoved
    end
    object pnlVersCatalog: TPanel
      Left = 0
      Top = 0
      Width = 250
      Height = 616
      Align = alLeft
      BevelOuter = bvNone
      Constraints.MinHeight = 100
      Constraints.MinWidth = 100
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
      object pnlVersCatalogControl: TPanel
        Left = 0
        Top = 0
        Width = 250
        Height = 26
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '  '#1042#1077#1088#1089#1080#1080
        TabOrder = 0
      end
      object pnlVersCatalogGrid: TPanel
        Left = 0
        Top = 26
        Width = 250
        Height = 590
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlVersCatalogGrid'
        TabOrder = 1
        object GridCatalog: TDBGrid
          Left = 0
          Top = 0
          Width = 250
          Height = 590
          Align = alClient
          BorderStyle = bsNone
          Ctl3D = False
          DataSource = dsCatalog
          Options = [dgIndicator, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDrawColumnCell = GridCatalogDrawColumnCell
          Columns = <
            item
              Expanded = False
              FieldName = 'SVersion'
              Width = 110
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SKindDevelop'
              Width = 120
              Visible = True
            end>
        end
      end
    end
    object pnlVersContent: TPanel
      Left = 253
      Top = 0
      Width = 759
      Height = 616
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object splitVersContent_List: TSplitter
        Left = 0
        Top = 333
        Width = 759
        Height = 3
        Cursor = crVSplit
        Align = alTop
        Beveled = True
      end
      object pnlVersContent_List: TPanel
        Left = 0
        Top = 0
        Width = 759
        Height = 333
        Align = alTop
        BevelOuter = bvNone
        Constraints.MinHeight = 100
        Constraints.MinWidth = 100
        TabOrder = 0
        object GridContentList: TDBGrid
          Left = 0
          Top = 0
          Width = 759
          Height = 333
          Align = alClient
          BorderStyle = bsNone
          Ctl3D = False
          DataSource = dsVersionContentList
          Options = [dgIndicator, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDrawColumnCell = GridContentListDrawColumnCell
          Columns = <
            item
              Expanded = False
              FieldName = 'SShortContent'
              Title.Caption = #1050#1088#1072#1090#1082#1086#1077' '#1089#1086#1076#1077#1088#1078#1072#1085#1080#1077
              Width = 730
              Visible = True
            end>
        end
      end
      object pnlVersContent_Note: TPanel
        Left = 0
        Top = 336
        Width = 759
        Height = 280
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        TabOrder = 1
        object edContent: TMemo
          Left = 5
          Top = 5
          Width = 749
          Height = 270
          Hint = '\'
          Align = alClient
          BevelKind = bkFlat
          BorderStyle = bsNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier'
          Font.Style = []
          Lines.Strings = (
            'edContent')
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
  end
  object spdsCatalog: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 200
    ProcedureName = 'pDS_jso_VersionContent;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@Contents'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = ''
      end>
    Left = 176
    Top = 52
  end
  object dsCatalog: TDataSource
    DataSet = spdsCatalog
    OnDataChange = dsCatalogDataChange
    Left = 119
    Top = 52
  end
  object spdsVersionContentList: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 200
    ProcedureName = 'pDS_jso_VersionContentList;1'
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
        Name = '@Contents'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = ''
      end>
    Left = 829
    Top = 58
  end
  object dsVersionContentList: TDataSource
    DataSet = spdsVersionContentList
    OnDataChange = dsVersionContentListDataChange
    Left = 712
    Top = 58
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 922
    Top = 59
    object aExit: TAction
      Caption = 'aExit'
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
    object aRefreshCatalog: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ImageIndex = 4
      ShortCut = 116
      OnExecute = aRefreshCatalogExecute
    end
  end
end
