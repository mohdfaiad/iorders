object frmCCJSO_JournalAlert_Item: TfrmCCJSO_JournalAlert_Item
  Left = 13
  Top = 97
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1103
  ClientHeight = 304
  ClientWidth = 482
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
    Width = 482
    Height = 304
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object lblAlertDate: TLabel
      Left = 112
      Top = 12
      Width = 26
      Height = 13
      Caption = #1044#1072#1090#1072
    end
    object lblAlertType: TLabel
      Left = 119
      Top = 34
      Width = 19
      Height = 13
      Caption = #1058#1080#1087
    end
    object lblReadDate: TLabel
      Left = 21
      Top = 56
      Width = 117
      Height = 13
      Caption = #1055#1088#1080#1085#1103#1090#1086' '#1082' '#1080#1089#1087#1086#1083#1085#1077#1085#1080#1102
    end
    object lblExecDate: TLabel
      Left = 78
      Top = 78
      Width = 60
      Height = 13
      Caption = #1054#1090#1088#1072#1073#1086#1090#1072#1085#1086
    end
    object lblEnumerator: TLabel
      Left = 9
      Top = 100
      Width = 129
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1081
    end
    object lblJList: TLabel
      Left = 6
      Top = 122
      Width = 132
      Height = 13
      Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1086#1085#1085#1099#1077' '#1085#1086#1084#1077#1088#1072
    end
    object lblAlertUserType: TLabel
      Left = 13
      Top = 145
      Width = 125
      Height = 13
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#1089#1082#1072#1103' '#1090#1077#1084#1072
    end
    object lblForShure: TLabel
      Left = 91
      Top = 166
      Width = 47
      Height = 13
      Caption = #1044#1083#1103' '#1074#1089#1077#1093
    end
    object lblContents: TLabel
      Left = 75
      Top = 209
      Width = 63
      Height = 13
      Caption = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077
    end
    object lblFromWhom: TLabel
      Left = 99
      Top = 188
      Width = 39
      Height = 13
      Caption = #1054#1090' '#1082#1086#1075#1086
    end
    object edAlertDate: TEdit
      Left = 143
      Top = 7
      Width = 121
      Height = 19
      BevelInner = bvNone
      BevelOuter = bvNone
      Ctl3D = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 0
    end
    object edAlertType: TEdit
      Left = 143
      Top = 29
      Width = 330
      Height = 19
      BevelInner = bvNone
      BevelOuter = bvNone
      Ctl3D = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 1
    end
    object edReadDate: TEdit
      Left = 143
      Top = 51
      Width = 121
      Height = 19
      BevelInner = bvNone
      BevelOuter = bvNone
      Ctl3D = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 2
    end
    object edExecDate: TEdit
      Left = 143
      Top = 73
      Width = 121
      Height = 19
      BevelInner = bvNone
      BevelOuter = bvNone
      Ctl3D = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 3
    end
    object edEnumerator: TEdit
      Left = 143
      Top = 95
      Width = 121
      Height = 19
      BevelInner = bvNone
      BevelOuter = bvNone
      Ctl3D = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 4
    end
    object edJList: TEdit
      Left = 143
      Top = 117
      Width = 121
      Height = 19
      BevelInner = bvNone
      BevelOuter = bvNone
      Ctl3D = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 5
    end
    object edAlertUserType: TEdit
      Left = 143
      Top = 139
      Width = 330
      Height = 19
      BevelInner = bvNone
      BevelOuter = bvNone
      Ctl3D = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 6
    end
    object edForShure: TEdit
      Left = 143
      Top = 161
      Width = 121
      Height = 19
      BevelInner = bvNone
      BevelOuter = bvNone
      Ctl3D = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 7
    end
    object edContents: TMemo
      Left = 143
      Top = 206
      Width = 330
      Height = 89
      BevelInner = bvNone
      BevelOuter = bvNone
      Ctl3D = False
      Lines.Strings = (
        '')
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 8
    end
    object edFromWhom: TEdit
      Left = 143
      Top = 183
      Width = 330
      Height = 19
      BevelInner = bvNone
      BevelOuter = bvNone
      Ctl3D = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 9
    end
  end
  object ActionList: TActionList
    Left = 408
    Top = 64
    object aExit: TAction
      Category = 'Tool'
      Caption = 'aExit'
      ShortCut = 27
      OnExecute = aExitExecute
    end
  end
end
