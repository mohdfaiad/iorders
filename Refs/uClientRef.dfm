object fmClientRef: TfmClientRef
  Left = 170
  Top = 179
  Width = 936
  Height = 703
  Caption = #1050#1083#1080#1077#1085#1090#1099
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
  object Splitter1: TSplitter
    Left = 0
    Top = 413
    Width = 920
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  inline ClientGrid: TsprGridFrm
    Left = 0
    Top = 0
    Width = 920
    Height = 413
    Align = alClient
    TabOrder = 0
    inherited PanelTop: TPanel
      Width = 920
    end
    inherited Grid: TDBGrid
      Width = 920
      Height = 372
    end
  end
  object pcDetails: TPageControl
    Left = 0
    Top = 416
    Width = 920
    Height = 249
    ActivePage = tsAppeal
    Align = alBottom
    TabOrder = 1
    object tsAppeal: TTabSheet
      Caption = #1054#1073#1088#1072#1097#1077#1085#1080#1103
      inline AppealGrid: TsprGridFrm
        Left = 0
        Top = 0
        Width = 912
        Height = 221
        Align = alClient
        TabOrder = 0
        inherited PanelTop: TPanel
          Width = 912
        end
        inherited Grid: TDBGrid
          Width = 912
          Height = 180
        end
      end
    end
  end
  object dsClientType: TDataSource
    Left = 520
    Top = 80
  end
  object dsClient: TDataSource
    OnDataChange = dsClientDataChange
    Left = 520
    Top = 144
  end
  object dsAppeal: TDataSource
    Left = 560
    Top = 208
  end
end
