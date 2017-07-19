object frmCCJS_ComeBack: TfrmCCJS_ComeBack
  Left = 39
  Top = 163
  Width = 1238
  Height = 500
  BorderIcons = [biSystemMenu]
  Caption = #1042#1086#1079#1074#1088#1072#1090#1085#1099#1077' '#1085#1072#1082#1083#1072#1076#1085#1099#1077
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
  object SplitterGrid: TSplitter
    Left = 0
    Top = 230
    Width = 1222
    Height = 3
    Cursor = crVSplit
    Align = alTop
    Beveled = True
  end
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 1222
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlHeader'
    TabOrder = 0
    object pnlHeader_Order: TPanel
      Left = 0
      Top = 0
      Width = 131
      Height = 21
      Align = alLeft
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
    object pnlHeader_Pharmacy: TPanel
      Left = 131
      Top = 0
      Width = 131
      Height = 21
      Align = alLeft
      BevelInner = bvSpace
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object pnlHeader_Client: TPanel
      Left = 262
      Top = 0
      Width = 960
      Height = 21
      Align = alClient
      Alignment = taLeftJustify
      BevelInner = bvSpace
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 21
    Width = 1222
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlTop'
    TabOrder = 1
    object pnlTop_Show: TPanel
      Left = 1037
      Top = 0
      Width = 185
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
    end
    object pnlTop_Tool: TPanel
      Left = 0
      Top = 0
      Width = 1037
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlMainGrid: TPanel
    Left = 0
    Top = 47
    Width = 1222
    Height = 183
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlMainGrid'
    TabOrder = 2
    object MainGrid: TDBGrid
      Left = 0
      Top = 0
      Width = 1222
      Height = 183
      Align = alClient
      BorderStyle = bsNone
      DataSource = dsJMoves
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = MainGridDrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'SDocNumb'
          Title.Caption = #1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SDocDateTime'
          Title.Caption = #1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SDocCloseDate'
          Title.Caption = #1044#1072#1090#1072' '#1079#1072#1082#1088#1099#1090#1080#1103
          Width = 130
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'NSumma'
          Title.Caption = #1057#1091#1084#1084#1072
          Width = 90
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'SNameNDS'
          Title.Caption = #1053#1044#1057
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SNote'
          Title.Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
          Width = 360
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'SEANDriver'
          Title.Caption = #1041#1077#1081#1076#1078#1080#1082' '#1074#1086#1076#1080#1090#1077#1083#1103
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NNumBox'
          Title.Caption = #1050#1086#1083'-'#1074#1086' '#1103#1097#1080#1082#1086#1074
          Width = 83
          Visible = True
        end>
    end
  end
  object pnlControl: TPanel
    Left = 0
    Top = 436
    Width = 1222
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlControl'
    TabOrder = 3
    object pnlControl_Tool: TPanel
      Left = 1136
      Top = 0
      Width = 86
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlControl_Tool'
      TabOrder = 0
      object tlbrControl: TToolBar
        Left = 0
        Top = 0
        Width = 86
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 71
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
          Action = aControl_Exit
          AutoSize = True
        end
      end
    end
    object pnlControl_Show: TPanel
      Left = 0
      Top = 0
      Width = 1136
      Height = 26
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlSlaveGrid: TPanel
    Left = 0
    Top = 233
    Width = 1222
    Height = 203
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlSlaveGrid'
    TabOrder = 4
    object SlaveGrid: TDBGrid
      Left = 0
      Top = 0
      Width = 1222
      Height = 203
      Align = alClient
      BorderStyle = bsNone
      DataSource = dsRTovar
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = SlaveGridDrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'NArtCode'
          Title.Caption = #1040#1088#1090#1050#1086#1076
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SArtName'
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 400
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'NKol'
          Title.Caption = #1050#1086#1083'-'#1074#1086
          Width = 60
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'NCena'
          Title.Caption = #1062#1077#1085#1072
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'IIsScan'
          Title.Caption = #1054#1090#1089#1082#1072#1085#1080#1088#1086#1074#1072#1085#1086
          Width = 92
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SDateScan'
          Title.Caption = #1044#1072#1090#1072' '#1089#1082#1072#1085#1080#1088#1086#1074#1072#1085#1080#1103
          Width = 130
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'NShtrih'
          Title.Caption = #1064#1090#1088#1080#1093#1082#1086#1076' '#1103#1097#1080#1082#1072
          Width = 160
          Visible = True
        end>
    end
  end
  object Action: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 512
    Top = 87
    object aControl_Exit: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aControl_ExitExecute
    end
  end
  object qrspJMoves: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_JMoves;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@Pharmacy'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end>
    Left = 806
    Top = 79
  end
  object dsJMoves: TDataSource
    DataSet = qrspJMoves
    OnDataChange = dsJMovesDataChange
    Left = 744
    Top = 79
  end
  object qrspRTovar: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_rTovar;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
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
        Name = '@SDocNumb'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end
      item
        Name = '@SDocDate'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end>
    Left = 824
    Top = 281
  end
  object dsRTovar: TDataSource
    DataSet = qrspRTovar
    Left = 752
    Top = 282
  end
end
