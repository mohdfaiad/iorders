object frmCCJSO_NPost_StateDate: TfrmCCJSO_NPost_StateDate
  Left = 58
  Top = 373
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1048#1089#1090#1086#1088#1080#1103' '#1076#1072#1090#1099' '#1089#1086#1089#1090#1086#1103#1085#1080#1103' '#1101#1082#1089#1087#1088#1077#1089#1089'-'#1085#1072#1082#1083#1072#1076#1085#1086#1081
  ClientHeight = 467
  ClientWidth = 425
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
  object pnlAttr: TPanel
    Left = 0
    Top = 0
    Width = 425
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlAttr'
    TabOrder = 0
    object pnlAttr_StateName: TPanel
      Left = 0
      Top = 0
      Width = 183
      Height = 21
      Align = alLeft
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
    end
    object pnlAttr_StateDate: TPanel
      Left = 183
      Top = 0
      Width = 242
      Height = 21
      Align = alClient
      Alignment = taLeftJustify
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 1
    end
  end
  object pnlTool: TPanel
    Left = 0
    Top = 21
    Width = 425
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlTool'
    TabOrder = 1
    object pnlTool_Show: TPanel
      Left = 336
      Top = 0
      Width = 89
      Height = 21
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
    end
    object pnlTool_Bar: TPanel
      Left = 0
      Top = 0
      Width = 336
      Height = 21
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlControl: TPanel
    Left = 0
    Top = 445
    Width = 425
    Height = 22
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlControl'
    TabOrder = 2
    object pnlControl_Tool: TPanel
      Left = 345
      Top = 0
      Width = 80
      Height = 22
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlControl_Tool'
      TabOrder = 0
      object toolbrControl: TToolBar
        Left = 0
        Top = 0
        Width = 80
        Height = 22
        Align = alClient
        ButtonWidth = 71
        Caption = 'toolbrControl'
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
          Action = aExit
        end
      end
    end
    object pnlControl_Show: TPanel
      Left = 0
      Top = 0
      Width = 345
      Height = 22
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlGRID: TPanel
    Left = 0
    Top = 42
    Width = 425
    Height = 403
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlGRID'
    TabOrder = 3
    object DBGrid: TDBGrid
      Left = 0
      Top = 0
      Width = 425
      Height = 403
      Align = alClient
      BorderStyle = bsNone
      Ctl3D = False
      DataSource = dsHistStateDate
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = DBGridDrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'SDateLastUpdatedStatus'
          Title.Caption = #1047#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1085#1103' '#1076#1072#1090#1072' '#1080#1089#1087#1088#1072#1074#1083#1077#1085#1080#1103
          Width = 220
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SBackwardDeliveryCargoType'
          Title.Caption = #1058#1080#1087' '#1075#1088#1091#1079#1072' '#1086#1073#1088#1072#1090#1085#1086#1081' '#1076#1086#1089#1090#1072#1074#1082#1080
          Width = 170
          Visible = True
        end>
    end
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 296
    Top = 72
    object aExit: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
  end
  object qrspHistStateDate: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_NPostDocumentList_StateDate;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@RN'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end>
    Left = 256
    Top = 130
  end
  object dsHistStateDate: TDataSource
    DataSet = qrspHistStateDate
    Left = 256
    Top = 186
  end
end
