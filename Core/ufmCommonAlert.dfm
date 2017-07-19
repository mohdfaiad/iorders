object fmCommonAlert: TfmCommonAlert
  Left = 98
  Top = 191
  Width = 419
  Height = 231
  AlphaBlend = True
  AlphaBlendValue = 240
  Caption = #1047#1074#1086#1085#1086#1082
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  ShowHint = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelFrame: TPanel
    Left = 0
    Top = 0
    Width = 403
    Height = 193
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = True
    ParentColor = True
    TabOrder = 0
  end
  object tmrCloseAW: TTimer
    Enabled = False
    Interval = 8000
    OnTimer = tmrCloseAWTimer
    Left = 292
    Top = 6
  end
  object trmMinimize: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = trmMinimizeTimer
    Left = 288
    Top = 72
  end
end
