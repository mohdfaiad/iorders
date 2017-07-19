object frmCCJSO_AutoDialEdit: TfrmCCJSO_AutoDialEdit
  Left = 33
  Top = 185
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1046#1091#1088#1085#1072#1083' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080' '#1072#1074#1090#1086#1076#1086#1079#1074#1086#1085#1086#1074' ('#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1086#1085#1085#1072#1103' '#1082#1072#1088#1090#1086#1095#1082#1072')'
  ClientHeight = 350
  ClientWidth = 462
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
  object pnlFields: TPanel
    Left = 0
    Top = 0
    Width = 462
    Height = 350
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object lblSCreateDate: TLabel
      Left = 57
      Top = 16
      Width = 77
      Height = 13
      Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
    end
    object lblSFullOrder: TLabel
      Left = 103
      Top = 38
      Width = 31
      Height = 13
      Caption = #1047#1072#1082#1072#1079
    end
    object lblSOrderDT: TLabel
      Left = 69
      Top = 60
      Width = 65
      Height = 13
      Caption = #1044#1072#1090#1072' '#1079#1072#1082#1072#1079#1072
    end
    object lblSPhone: TLabel
      Left = 89
      Top = 82
      Width = 45
      Height = 13
      Caption = #1058#1077#1083#1077#1092#1086#1085
    end
    object lblSClient: TLabel
      Left = 98
      Top = 104
      Width = 36
      Height = 13
      Caption = #1050#1083#1080#1077#1085#1090
    end
    object lblSAutoDialType: TLabel
      Left = 47
      Top = 125
      Width = 87
      Height = 13
      Caption = #1058#1080#1087' '#1072#1074#1090#1086#1076#1086#1079#1074#1086#1085#1072
    end
    object lblICounter: TLabel
      Left = 94
      Top = 148
      Width = 40
      Height = 13
      Caption = #1057#1095#1077#1090#1095#1080#1082
    end
    object lblSNameFileRoot: TLabel
      Left = 77
      Top = 170
      Width = 57
      Height = 13
      Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072
    end
    object lblSAutoDialBegin: TLabel
      Left = 70
      Top = 193
      Width = 64
      Height = 13
      Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
    end
    object lblSAutoDialEnd: TLabel
      Left = 52
      Top = 216
      Width = 82
      Height = 13
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
    end
    object lblSAutoDialResult: TLabel
      Left = 82
      Top = 238
      Width = 52
      Height = 13
      Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
    end
    object lblSFileExists: TLabel
      Left = 56
      Top = 260
      Width = 78
      Height = 13
      Caption = #1053#1072#1083#1080#1095#1080#1077' '#1092#1072#1081#1083#1072
    end
    object lblNCheckCounter: TLabel
      Left = 24
      Top = 281
      Width = 110
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1088#1086#1074#1077#1088#1086#1082
    end
    object lblSCheckDate: TLabel
      Left = 56
      Top = 303
      Width = 77
      Height = 13
      Caption = #1044#1072#1090#1072' '#1087#1088#1086#1074#1077#1088#1082#1080
    end
    object lblNRetryCounter: TLabel
      Left = 32
      Top = 325
      Width = 102
      Height = 13
      Caption = #1055#1086#1074#1090#1086#1088#1077#1085#1086' '#1074#1099#1079#1086#1074#1086#1074
    end
    object edCreateDate: TEdit
      Left = 138
      Top = 11
      Width = 135
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = True
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 0
    end
    object edSFullOrder: TEdit
      Left = 138
      Top = 33
      Width = 135
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = True
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 1
    end
    object edSOrderDT: TEdit
      Left = 138
      Top = 55
      Width = 135
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = True
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 2
    end
    object edSPhone: TEdit
      Left = 138
      Top = 77
      Width = 135
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = True
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 3
    end
    object edSClient: TEdit
      Left = 138
      Top = 99
      Width = 300
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = True
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 4
    end
    object edSAutoDialType: TEdit
      Left = 138
      Top = 121
      Width = 300
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = True
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 5
    end
    object edICounter: TEdit
      Left = 138
      Top = 143
      Width = 135
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = True
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 6
    end
    object edSNameFileRoot: TEdit
      Left = 138
      Top = 165
      Width = 300
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = True
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 7
    end
    object edSAutoDialBegin: TEdit
      Left = 138
      Top = 188
      Width = 135
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = True
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 8
    end
    object edSAutoDialEnd: TEdit
      Left = 138
      Top = 210
      Width = 135
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = True
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 9
    end
    object edSAutoDialResult: TEdit
      Left = 138
      Top = 232
      Width = 300
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = True
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 10
    end
    object edSFileExists: TEdit
      Left = 138
      Top = 254
      Width = 135
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = True
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 11
    end
    object edNCheckCounter: TEdit
      Left = 138
      Top = 276
      Width = 135
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = True
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 12
    end
    object edSCheckDate: TEdit
      Left = 138
      Top = 298
      Width = 135
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = True
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 13
    end
    object edNRetryCounter: TEdit
      Left = 138
      Top = 320
      Width = 135
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = True
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 14
    end
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 400
    Top = 16
    object aExit: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
  end
end
