object frmCCJS_PartsPosition: TfrmCCJS_PartsPosition
  Left = 40
  Top = 192
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'frmCCJS_PartsPosition'
  ClientHeight = 324
  ClientWidth = 1145
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
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 1145
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlTop'
    TabOrder = 0
    object pnlTop_Order: TPanel
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
    object pnlTop_Price: TPanel
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
    object pnlTop_Client: TPanel
      Left = 262
      Top = 0
      Width = 219
      Height = 21
      Align = alLeft
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
    object pnlTop_ArtCode: TPanel
      Left = 481
      Top = 0
      Width = 219
      Height = 21
      Align = alLeft
      Alignment = taLeftJustify
      BevelInner = bvSpace
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object pnlTop_ArtName: TPanel
      Left = 700
      Top = 0
      Width = 445
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
      TabOrder = 4
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 21
    Width = 1145
    Height = 303
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlGrid'
    TabOrder = 1
    object DBGrid: TDBGrid
      Left = 0
      Top = 26
      Width = 1145
      Height = 277
      Align = alClient
      BorderStyle = bsNone
      DataSource = dsParts
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'INumberPart'
          Title.Caption = #1053#1086#1084#1077#1088
          Width = 46
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NitemAmaunt'
          Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
          Width = 72
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SArmourDate'
          Title.Caption = #1044#1072#1090#1072' '#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1103
          Width = 133
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SArmourDateClose'
          Title.Caption = #1044#1072#1090#1072' '#1079#1072#1082#1088#1099#1090#1080#1103' '#1073#1088#1086#1085#1080
          Width = 136
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SCheckDate'
          Title.Caption = #1044#1072#1090#1072' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
          Width = 139
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'StypeNote'
          Title.Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
          Width = 593
          Visible = True
        end>
    end
    object pnlControl: TPanel
      Left = 0
      Top = 0
      Width = 1145
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlControl'
      TabOrder = 1
      object pnlControl_Show: TPanel
        Left = 960
        Top = 0
        Width = 185
        Height = 26
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
      end
      object pnlControl_Tool: TPanel
        Left = 0
        Top = 0
        Width = 960
        Height = 26
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
      end
    end
  end
  object dsParts: TDataSource
    DataSet = qrspJSOParts
    OnDataChange = dsPartsDataChange
    Left = 832
    Top = 136
  end
  object qrspJSOParts: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 60
    ProcedureName = 'pDS_jzs_PartsPosition;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@NRN'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end>
    Left = 890
    Top = 136
  end
  object ActionMain: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 792
    Top = 136
    object aMain_Exit: TAction
      Category = 'Main'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aMain_ExitExecute
    end
  end
end
