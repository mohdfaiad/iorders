object fmIPTelMapRef: TfmIPTelMapRef
  Left = 413
  Top = 263
  Width = 857
  Height = 512
  Caption = 'IP '#1090#1077#1083#1077#1092#1086#1085#1080#1103' '#1050#1040#1056#1058#1040
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 841
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object dbNav: TDBNavigator
      Left = 0
      Top = 0
      Width = 240
      Height = 25
      DataSource = dsMain
      Align = alLeft
      TabOrder = 0
    end
  end
  inline MainGrid: TIPTelMapFrame
    Left = 0
    Top = 25
    Width = 841
    Height = 449
    Align = alClient
    TabOrder = 1
    inherited PanelTop: TPanel
      Width = 841
    end
    inherited Grid: TDBGrid
      Width = 841
      Height = 408
    end
  end
  object dsMain: TDataSource
    Left = 616
    Top = 128
  end
end
