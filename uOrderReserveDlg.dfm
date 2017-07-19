object fmOrderReserveDlg: TfmOrderReserveDlg
  Left = 245
  Top = 108
  BorderStyle = bsDialog
  Caption = #1056#1077#1079#1077#1088#1074#1080#1088#1086#1074#1072#1085#1080#1077' '#1079#1072#1082#1072#1079#1072
  ClientHeight = 187
  ClientWidth = 425
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  DesignSize = (
    425
    187)
  PixelsPerInch = 96
  TextHeight = 13
  object lbItem: TLabel
    Left = 40
    Top = 80
    Width = 28
    Height = 13
    Caption = 'lbItem'
  end
  object lbSubItem: TLabel
    Left = 40
    Top = 128
    Width = 47
    Height = 13
    Caption = 'lbSubItem'
  end
  object OKBtn: TButton
    Left = 144
    Top = 157
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 224
    Top = 157
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
  end
  object rbAll: TRadioButton
    Left = 20
    Top = 24
    Width = 113
    Height = 17
    Caption = #1042#1077#1089#1100' '#1079#1072#1082#1072#1079
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    TabStop = True
  end
  object rbItem: TRadioButton
    Left = 20
    Top = 56
    Width = 113
    Height = 17
    Caption = #1055#1086#1079#1080#1094#1080#1102
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object rbSubItem: TRadioButton
    Left = 20
    Top = 104
    Width = 113
    Height = 17
    Caption = #1057#1091#1073'. '#1087#1086#1079#1080#1094#1080#1102
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
end
