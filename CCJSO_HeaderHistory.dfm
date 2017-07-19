object frmCCJSO_HeaderHistory: TfrmCCJSO_HeaderHistory
  Left = 18
  Top = 326
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1048#1089#1090#1086#1088#1080#1103' '#1086#1087#1077#1088#1072#1094#1080#1081' ('#1095#1090#1077#1085#1080#1077')'
  ClientHeight = 372
  ClientWidth = 803
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
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 803
    Height = 21
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    TabOrder = 0
  end
  object pnlControl: TPanel
    Left = 0
    Top = 346
    Width = 803
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlControl'
    TabOrder = 1
    object pnlControl_Tool: TPanel
      Left = 719
      Top = 0
      Width = 84
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlControl_Tool'
      TabOrder = 0
      object rbarControl: TToolBar
        Left = 0
        Top = 0
        Width = 84
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 71
        Caption = 'rbarControl'
        DisabledImages = FCCenterJournalNetZkz.imgMainDisable
        EdgeBorders = []
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tbtnControl_Exit: TToolButton
          Left = 0
          Top = 0
          Action = aExit
          AutoSize = True
        end
      end
    end
    object pnlControl_Show: TPanel
      Left = 0
      Top = 0
      Width = 719
      Height = 26
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlRecord: TPanel
    Left = 0
    Top = 21
    Width = 803
    Height = 325
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 2
    object lblSActionName: TLabel
      Left = 77
      Top = 14
      Width = 126
      Height = 13
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1076#1077#1081#1089#1090#1074#1080#1103
    end
    object lblSActionCode: TLabel
      Left = 134
      Top = 38
      Width = 69
      Height = 13
      Caption = #1050#1086#1076' '#1076#1077#1081#1089#1090#1074#1080#1103
    end
    object lblSUser: TLabel
      Left = 130
      Top = 62
      Width = 73
      Height = 13
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    end
    object lblSBeginDate: TLabel
      Left = 126
      Top = 86
      Width = 77
      Height = 13
      Caption = #1044#1072#1090#1072' '#1086#1090#1082#1088#1099#1090#1080#1103
    end
    object lblSEndDate: TLabel
      Left = 125
      Top = 110
      Width = 78
      Height = 13
      Caption = #1044#1072#1090#1072' '#1079#1072#1082#1088#1099#1090#1080#1103
    end
    object lblSActionFoundation: TLabel
      Left = 147
      Top = 134
      Width = 56
      Height = 13
      Caption = #1054#1089#1085#1086#1074#1072#1085#1080#1077
    end
    object lblSDriver: TLabel
      Left = 155
      Top = 158
      Width = 48
      Height = 13
      Caption = #1042#1086#1076#1080#1090#1077#1083#1100
    end
    object lblIAllowBeOpen: TLabel
      Left = 9
      Top = 182
      Width = 194
      Height = 13
      Caption = #1052#1080#1085#1091#1090' '#1076#1083#1103' '#1087#1088#1080#1085#1091#1076#1080#1090#1077#1083#1100#1085#1086#1075#1086' '#1079#1072#1082#1088#1099#1090#1080#1103
    end
    object lblWaitingTimeMinute: TLabel
      Left = 48
      Top = 206
      Width = 155
      Height = 13
      Caption = #1052#1080#1085#1091#1090' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' ('#1086#1078#1080#1076#1072#1085#1080#1103')'
    end
    object lblSNOTE: TLabel
      Left = 12
      Top = 229
      Width = 63
      Height = 13
      Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
    end
    object edSActionName: TEdit
      Left = 206
      Top = 8
      Width = 585
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 0
    end
    object edSActionCode: TEdit
      Left = 206
      Top = 32
      Width = 585
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 1
    end
    object edSUser: TEdit
      Left = 206
      Top = 56
      Width = 585
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 2
    end
    object edSBeginDate: TEdit
      Left = 206
      Top = 80
      Width = 140
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 3
    end
    object edSEndDate: TEdit
      Left = 206
      Top = 104
      Width = 140
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 4
    end
    object edSActionFoundation: TEdit
      Left = 206
      Top = 128
      Width = 585
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 5
    end
    object edSDriver: TEdit
      Left = 206
      Top = 152
      Width = 585
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 6
    end
    object edIAllowBeOpen: TEdit
      Left = 206
      Top = 176
      Width = 100
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 7
    end
    object edWaitingTimeMinute: TEdit
      Left = 206
      Top = 200
      Width = 100
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 8
    end
    object edSNOTE: TMemo
      Left = 9
      Top = 244
      Width = 782
      Height = 73
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 9
    end
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 760
    Top = 37
    object aExit: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
  end
end
