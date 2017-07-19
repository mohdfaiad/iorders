object frmCCJS_RP_QuantIndicatorsUserExperience: TfrmCCJS_RP_QuantIndicatorsUserExperience
  Left = 36
  Top = 150
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1077#1085#1085#1099#1077' '#1087#1086#1082#1072#1079#1072#1090#1077#1083#1080' '#1088#1072#1073#1086#1090#1099' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
  ClientHeight = 192
  ClientWidth = 453
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
  object pgcMain: TPageControl
    Left = 0
    Top = 0
    Width = 453
    Height = 166
    ActivePage = tabParm_JSO
    Align = alClient
    Images = FCCenterJournalNetZkz.imgMain
    TabOrder = 0
    object tabParm_JSO: TTabSheet
      Caption = #1048#1085#1090#1077#1088#1085#1077#1090' '#1079#1072#1082#1072#1079#1099
      ImageIndex = 18
      object stbarParm_JSO: TStatusBar
        Left = 0
        Top = 118
        Width = 445
        Height = 19
        Panels = <>
        SimplePanel = True
      end
      object pnlParm: TPanel
        Left = 0
        Top = 0
        Width = 445
        Height = 118
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object grbxParm_Period: TGroupBox
          Left = 0
          Top = 0
          Width = 445
          Height = 45
          Align = alTop
          Caption = ' '#1047#1072' '#1087#1077#1088#1080#1086#1076' '
          TabOrder = 0
          object lblCndDatePeriod_with: TLabel
            Left = 7
            Top = 23
            Width = 7
            Height = 13
            Caption = #1057
          end
          object lblCndDatePeriod_toOn: TLabel
            Left = 112
            Top = 24
            Width = 12
            Height = 13
            Caption = #1087#1086
          end
          object dtCndBegin: TDateTimePicker
            Left = 19
            Top = 18
            Width = 90
            Height = 21
            Date = 41856.717597962960000000
            Time = 41856.717597962960000000
            TabOrder = 0
          end
          object dtCndEnd: TDateTimePicker
            Left = 130
            Top = 18
            Width = 90
            Height = 21
            Date = 41856.717597962960000000
            Time = 41856.717597962960000000
            TabOrder = 1
          end
        end
        object grbxParm_Estimates: TGroupBox
          Left = 0
          Top = 45
          Width = 445
          Height = 73
          Align = alTop
          Caption = ' '#1056#1072#1089#1095#1077#1090#1085#1099#1077' '#1087#1086#1082#1072#1079#1072#1090#1077#1083#1080' '
          TabOrder = 1
          object chbxJSO_SignBell: TCheckBox
            Left = 7
            Top = 18
            Width = 400
            Height = 17
            Caption = #1087#1088#1080#1079#1085#1072#1082' '#1079#1074#1086#1085#1082#1072
            Checked = True
            State = cbChecked
            TabOrder = 0
          end
          object chbxJSO_MarkerBell: TCheckBox
            Left = 7
            Top = 34
            Width = 400
            Height = 17
            Caption = #1084#1072#1088#1082#1077#1088' '#1076#1072#1090#1099' '#1079#1074#1086#1085#1082#1072
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object chbxJSO_Status: TCheckBox
            Left = 7
            Top = 50
            Width = 400
            Height = 17
            Caption = #1089#1090#1072#1090#1091#1089' '#1079#1072#1082#1072#1079#1072
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
        end
      end
    end
  end
  object pnlTool: TPanel
    Left = 0
    Top = 166
    Width = 453
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlTool'
    TabOrder = 1
    object pnlTool_Bar: TPanel
      Left = 268
      Top = 0
      Width = 185
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object tlbarMain: TToolBar
        Left = 0
        Top = 0
        Width = 185
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 83
        EdgeBorders = []
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tlbtnMain_Exec: TToolButton
          Left = 0
          Top = 0
          Action = aMain_Exec
          AutoSize = True
        end
        object tlbtnMain_Close: TToolButton
          Left = 87
          Top = 0
          Action = aMain_Close
        end
      end
    end
    object pnlTool_Show: TPanel
      Left = 0
      Top = 0
      Width = 268
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object aMain: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 308
    Top = 13
    object aMain_Exec: TAction
      Category = 'Main'
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      ImageIndex = 36
      OnExecute = aMain_ExecExecute
    end
    object aMain_Close: TAction
      Category = 'Main'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aMain_CloseExecute
    end
  end
  object spDS_RP_CountSignBell: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_RP_CountUserSignBell;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@SBegin'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@SEnd'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end>
    Left = 264
    Top = 78
  end
  object spDS_RP_CountMarkerBellDate: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_RP_CountUserMarkerBellDate;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@SBegin'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@SEnd'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end>
    Left = 351
    Top = 93
  end
  object spDS_RP_CountActionOrderStatus: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_RP_CountUserActionOrderStatus;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@SBegin'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@SEnd'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end>
    Left = 182
    Top = 94
  end
end
