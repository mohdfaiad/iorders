object frmCCJS_CheckPickPharmacy: TfrmCCJS_CheckPickPharmacy
  Left = 15
  Top = 448
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'frmCCJS_CheckPickPharmacy'
  ClientHeight = 466
  ClientWidth = 984
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
  object statusBar: TStatusBar
    Left = 0
    Top = 447
    Width = 984
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 984
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object pnlHeader_Pharmacy: TPanel
      Left = 0
      Top = 0
      Width = 984
      Height = 21
      Align = alClient
      BevelInner = bvSpace
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
  end
  object pnlTool: TPanel
    Left = 0
    Top = 21
    Width = 984
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object pnlTool_Show: TPanel
      Left = 862
      Top = 0
      Width = 122
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
    end
    object pnlTool_Bar: TPanel
      Left = 0
      Top = 0
      Width = 240
      Height = 26
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object tlbarTool: TToolBar
        Left = 0
        Top = 0
        Width = 240
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 226
        Caption = 'tlbarTool'
        EdgeBorders = []
        EdgeInner = esNone
        EdgeOuter = esNone
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tlbtnTool_SelectItemReserve: TToolButton
          Left = 0
          Top = 0
          Action = aTool_SelectItem
          AutoSize = True
        end
      end
    end
    object pnlTool_Fields: TPanel
      Left = 240
      Top = 0
      Width = 622
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object pnlTool_Fields_01: TPanel
        Left = 0
        Top = 0
        Width = 257
        Height = 26
        Align = alLeft
        Alignment = taLeftJustify
        BevelOuter = bvNone
        TabOrder = 0
        object lblNumberToReserve: TLabel
          Left = 6
          Top = 6
          Width = 167
          Height = 13
          Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1076#1083#1103' '#1088#1077#1079#1077#1088#1074#1080#1088#1086#1074#1072#1085#1080#1103
        end
        object cmbxNumberToReserve: TComboBox
          Left = 179
          Top = 2
          Width = 58
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          Text = 'cmbxNumberToReserve'
        end
      end
      object pnlTool_Fields_02: TPanel
        Left = 257
        Top = 0
        Width = 365
        Height = 26
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object tlbarTool_Fields: TToolBar
          Left = 0
          Top = 0
          Width = 365
          Height = 26
          Align = alClient
          AutoSize = True
          BorderWidth = 1
          ButtonWidth = 87
          Caption = 'tlbarTool_Fields'
          EdgeBorders = []
          EdgeInner = esNone
          EdgeOuter = esNone
          Flat = True
          Images = FCCenterJournalNetZkz.imgMain
          List = True
          ShowCaptions = True
          TabOrder = 0
          object tlbtnTool_Fields_OK: TToolButton
            Left = 0
            Top = 0
            Action = aTool_Fileds_OK
            AutoSize = True
          end
        end
      end
    end
  end
  object pnlControl: TPanel
    Left = 0
    Top = 421
    Width = 984
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object pnlControl_Bar: TPanel
      Left = 786
      Top = 0
      Width = 198
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlControl_Bar'
      TabOrder = 0
      object tlbarControl: TToolBar
        Left = 0
        Top = 0
        Width = 198
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 108
        EdgeBorders = []
        EdgeInner = esNone
        EdgeOuter = esNone
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tlbtnControl_Select: TToolButton
          Left = 0
          Top = 0
          Action = aControl_Select
          AutoSize = True
        end
        object tlbtnControl_Close: TToolButton
          Left = 112
          Top = 0
          Action = aControl_Close
          AutoSize = True
        end
      end
    end
    object pnlControl_Show: TPanel
      Left = 0
      Top = 0
      Width = 786
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 47
    Width = 984
    Height = 374
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlGrid'
    TabOrder = 4
    object gMain: TDBGrid
      Left = 0
      Top = 0
      Width = 984
      Height = 374
      Align = alClient
      BorderStyle = bsNone
      DataSource = dsCheck
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = gMainDrawColumnCell
      OnDblClick = aTool_Fileds_OKExecute
      Columns = <
        item
          Expanded = False
          FieldName = 'NArtCodeTerm'
          Title.Caption = #1040#1088#1090#1050#1086#1076
          Width = 53
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SArtNameTerm'
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 299
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NRemn'
          Title.Caption = #1054#1089#1090#1072#1090#1086#1082' '#1096#1090'.'
          Width = 76
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NArmour'
          Title.Caption = #1047#1072#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1086' '#1096#1090'.'
          Width = 107
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NCountItemOrder'
          Title.Caption = #1042' '#1079#1072#1082#1072#1079#1077' '#1096#1090'.'
          Width = 76
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NumberToReserve'
          Title.Caption = #1044#1083#1103' '#1088#1077#1079#1077#1088#1074#1080#1088#1086#1074#1072#1085#1080#1103' '#1096#1090'.'
          Width = 138
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NPrice'
          Title.Caption = #1062#1077#1085#1072' '#1096#1090'. '#1074' '#1072#1087#1090#1077#1082#1077
          Width = 104
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SNameSignTerm'
          Title.Caption = #1057#1088#1086#1082#1086#1074#1099#1081
          Width = 72
          Visible = True
        end>
    end
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 542
    Top = 132
    object aControl_Close: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      OnExecute = aControl_CloseExecute
    end
    object aControl_Select: TAction
      Category = 'Control'
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1072#1087#1090#1077#1082#1091
      ImageIndex = 102
      OnExecute = aControl_SelectExecute
    end
    object aTool_SelectItem: TAction
      Category = 'Tool'
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1087#1086#1079#1080#1094#1080#1102' '#1076#1083#1103' '#1088#1077#1079#1077#1088#1074#1080#1088#1086#1074#1072#1085#1080#1103
      ImageIndex = 193
      OnExecute = aTool_SelectItemExecute
    end
    object aTool_ClearSelectItem: TAction
      Category = 'Tool'
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1074#1099#1073#1086#1088' '#1087#1086#1079#1080#1094#1080#1080' '#1076#1083#1103' '#1088#1077#1079#1077#1088#1074#1080#1088#1086#1074#1072#1085#1080#1103
      ImageIndex = 192
      OnExecute = aTool_ClearSelectItemExecute
    end
    object aControl_AddPharmacy: TAction
      Category = 'Control'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1072#1087#1090#1077#1082#1091
      ImageIndex = 101
      OnExecute = aControl_AddPharmacyExecute
    end
    object aTool_Fileds_OK: TAction
      Category = 'Tool'
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100
      ImageIndex = 7
      ShortCut = 13
      OnExecute = aTool_Fileds_OKExecute
    end
  end
  object dsCheck: TDataSource
    DataSet = qrspCheck
    OnDataChange = dsCheckDataChange
    Left = 598
    Top = 132
  end
  object qrspCheck: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_CheckPickPharmacy'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@NIdentPharmacy'
        Attributes = [paNullable]
        DataType = ftLargeint
        Precision = 19
        Value = '0'
      end
      item
        Name = '@SIDENT'
        Attributes = [paNullable]
        DataType = ftString
        Size = 40
        Value = ''
      end
      item
        Name = '@Order'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end>
    Left = 662
    Top = 132
  end
  object spAutoNumberReserve: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_CheckPickPharmacy_AutoNumberReserve;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@NIdentPharmacy'
        Attributes = [paNullable]
        DataType = ftLargeint
        Precision = 19
        Value = '0'
      end
      item
        Name = '@SIDENT'
        Attributes = [paNullable]
        DataType = ftString
        Size = 40
        Value = ''
      end
      item
        Name = '@Order'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@IDUser'
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
    Left = 621
    Top = 185
  end
  object spSetNumberToReserve: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_CheckPickPharmacy_SetNumberToReserve;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@RN'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@NumberToReserve'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@SErr'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = ''
      end>
    Left = 696
    Top = 203
  end
  object spSetPharmacy: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_CheckPickPharmacy_SetPharmacy;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@NIdentPharmacy'
        Attributes = [paNullable]
        DataType = ftLargeint
        Precision = 19
        Value = '0'
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@Pharmacy'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@SIDENT'
        Attributes = [paNullable]
        DataType = ftString
        Size = 40
        Value = ''
      end
      item
        Name = '@Order'
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
    Left = 620
    Top = 231
  end
  object spCountOtherDistrib: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_CheckPickPharmacy_CountOtherDistrib;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@NIdentPharmacy'
        Attributes = [paNullable]
        DataType = ftLargeint
        Precision = 19
        Value = '0'
      end
      item
        Name = '@NRN'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@CountOtherDistrib'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = 0
      end>
    Left = 762
    Top = 184
  end
  object spAddPharmacy: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_CheckPickPharmacy_AddPharmacy;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@NIdentPharmacy'
        Attributes = [paNullable]
        DataType = ftLargeint
        Precision = 19
        Value = '0'
      end
      item
        Name = '@PRN'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@ISignModeReserve'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = 0
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@Pharmacy'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@SIDENT'
        Attributes = [paNullable]
        DataType = ftString
        Size = 40
        Value = ''
      end
      item
        Name = '@Order'
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
    Left = 774
    Top = 231
  end
  object spGetPickItemDistributePosCount: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_GetPickItemDistributePosCount;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@RN'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@IDENT'
        Attributes = [paNullable]
        DataType = ftString
        Size = 40
        Value = ''
      end
      item
        Name = '@Pharmacy'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@TermArtCode'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@Count'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = 0
      end>
    Left = 696
    Top = 252
  end
  object spSumReserve: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_CheckPickPharmacy_SumReserve;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@NIdentPharmacy'
        Attributes = [paNullable]
        DataType = ftLargeint
        Precision = 19
        Value = '0'
      end
      item
        Name = '@SumReserve'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = 0
      end>
    Left = 648
    Top = 319
  end
end
