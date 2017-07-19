object frmCCJS_ArtCodeTerm: TfrmCCJS_ArtCodeTerm
  Left = 0
  Top = 294
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1088#1086#1082#1086#1074#1099#1081' '#1090#1086#1074#1072#1088
  ClientHeight = 244
  ClientWidth = 1264
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 1264
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
      Width = 234
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
      TabOrder = 4
    end
    object pnlTop_RemnTerm: TPanel
      Left = 934
      Top = 0
      Width = 330
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
      TabOrder = 5
    end
  end
  object pnlControl: TPanel
    Left = 0
    Top = 21
    Width = 1264
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlControl'
    TabOrder = 1
    object pnlControl_Show: TPanel
      Left = 1079
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
      Width = 1079
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 47
    Width = 1264
    Height = 197
    Align = alClient
    BorderStyle = bsNone
    DataSource = dsTerm
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NArtCode'
        Title.Caption = #1040#1088#1090#1050#1086#1076
        Width = 53
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SArtName'
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Width = 280
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'SArtCount'
        Title.Caption = #1050#1054#1051'-'#1042#1054
        Width = 77
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NitemCountInPresence'
        Title.Caption = #1053#1072#1083#1080#1095#1080#1077' '#1096#1090'. '#1058#1058
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NitemPrice'
        Title.Caption = #1062#1077#1085#1072' '#1057#1040#1049#1058
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NCalcPriceWithKoef'
        Title.Caption = #1062#1077#1085#1072' '#1091#1087#1072#1082'. '#1058#1058
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NPricePharmacy'
        Title.Caption = #1062#1077#1085#1072' '#1096#1090'. '#1058#1058
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NKoef_Opt'
        Title.Caption = #1050'.'#1059#1087#1072#1082'.'
        Width = 42
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SArmourDate'
        Title.Caption = #1044#1072#1090#1072' '#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1103
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SArmourDateClose'
        Title.Caption = #1044#1072#1090#1072' '#1079#1072#1082#1088#1099#1090#1080#1103
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SCheckDate'
        Title.Caption = #1044#1072#1090#1072' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SCheckNote'
        Title.Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
        Width = 400
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SUser'
        Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NID_IPA_DhRes'
        Title.Caption = '# '#1058#1058' '#1073#1088#1086#1085#1100' '#1079#1072#1082'.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NID_IPA_DtRes'
        Title.Caption = '# '#1058#1058' '#1073#1088#1086#1085#1100' '#1089#1087#1077#1094'.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NRN'
        Title.Caption = '# '#1057#1087#1077#1094'. '#1089#1088#1086#1082'. '#1090#1086#1074'.'
        Visible = True
      end>
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
  object dsTerm: TDataSource
    DataSet = qrspJSOTerm
    Left = 843
    Top = 136
  end
  object qrspJSOTerm: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 60
    ProcedureName = 'pDS_jso_ArtCode_Term;1'
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
    Left = 901
    Top = 136
  end
end
