object frmCCSJO_AlertContents_Clear: TfrmCCSJO_AlertContents_Clear
  Left = 15
  Top = 136
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1059#1076#1072#1083#1077#1085#1080#1077' '#1079#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1085#1099#1093' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1081
  ClientHeight = 77
  ClientWidth = 417
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
  object pnlControl: TPanel
    Left = 0
    Top = 51
    Width = 417
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlControl'
    TabOrder = 0
    object pnlControl_Tool: TPanel
      Left = 250
      Top = 0
      Width = 167
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlControl_Tool'
      TabOrder = 0
      object tbarControl: TToolBar
        Left = 0
        Top = 0
        Width = 167
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 83
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
        object tbtnControl_Exec: TToolButton
          Left = 0
          Top = 0
          Action = aExec
        end
        object tbtnControl_Exit: TToolButton
          Left = 83
          Top = 0
          Action = aExit
          AutoSize = True
        end
      end
    end
    object pnlControl_Show: TPanel
      Left = 0
      Top = 0
      Width = 250
      Height = 26
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlParm: TPanel
    Left = 0
    Top = 0
    Width = 417
    Height = 51
    Align = alClient
    BevelInner = bvSpace
    BevelOuter = bvLowered
    TabOrder = 1
    object lblPeriodBegin: TLabel
      Left = 10
      Top = 18
      Width = 64
      Height = 13
      Caption = #1047#1072' '#1087#1077#1088#1080#1086#1076' '#1089' '
    end
    object lblPeriodEnd: TLabel
      Left = 225
      Top = 18
      Width = 12
      Height = 13
      Caption = #1087#1086
    end
    object edPeriodBegin: TEdit
      Tag = 10
      Left = 74
      Top = 11
      Width = 140
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 0
      OnDblClick = aSlDateExecute
    end
    object edPeriodEnd: TEdit
      Tag = 11
      Left = 241
      Top = 11
      Width = 140
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 1
      OnDblClick = aSlDateExecute
    end
    object btnPeriodBegin: TButton
      Tag = 10
      Left = 193
      Top = 13
      Width = 19
      Height = 17
      Action = aSlDate
      TabOrder = 2
    end
    object btnPeriodEnd: TButton
      Tag = 11
      Left = 360
      Top = 13
      Width = 19
      Height = 17
      Action = aSlDate
      TabOrder = 3
    end
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 16
    Top = 34
    object aExec: TAction
      Category = 'Control'
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      ImageIndex = 7
      OnExecute = aExecExecute
    end
    object aExit: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
    object aSlDate: TAction
      Category = 'Control'
      Caption = #8230
      OnExecute = aSlDateExecute
    end
  end
  object spAlertContentsClear: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 200
    ProcedureName = 'p_jso_AlertContents_Clear;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
      end
      item
        Name = '@USER'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
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
        Name = '@SErr'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 4000
        Value = ''
      end>
    Left = 85
    Top = 34
  end
end
