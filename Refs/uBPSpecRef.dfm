object fmBPSpecRef: TfmBPSpecRef
  Left = 268
  Top = 230
  Width = 869
  Height = 727
  Caption = #1050#1072#1088#1090#1072' '#1089#1090#1072#1090#1091#1089#1086#1074' '#1079#1072#1082#1072#1079#1072
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
    Top = 469
    Width = 853
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 853
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object dbNav: TDBNavigator
      Left = 0
      Top = 0
      Width = 240
      Height = 25
      DataSource = dsRef
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbEdit, nbPost, nbCancel, nbRefresh]
      Align = alLeft
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 472
    Width = 853
    Height = 217
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 1
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 853
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object dbNavSpec: TDBNavigator
        Left = 0
        Top = 0
        Width = 240
        Height = 25
        DataSource = dsSpec
        Align = alLeft
        TabOrder = 0
      end
    end
    inline BPSpecBasisGrid: TsprGridFrm
      Left = 0
      Top = 25
      Width = 853
      Height = 192
      Align = alClient
      TabOrder = 1
      inherited PanelTop: TPanel
        Width = 853
      end
      inherited Grid: TDBGrid
        Width = 853
        Height = 151
      end
    end
  end
  inline BPSpecGrid: TBPCtxFrame
    Left = 0
    Top = 25
    Width = 853
    Height = 444
    Align = alClient
    TabOrder = 2
    inherited PanelTop: TPanel
      Width = 853
      inherited PanelActions: TPanel
        Width = 241
        inherited ToolBar1: TToolBar
          Width = 241
        end
      end
    end
    inherited Grid: TDBGrid
      Width = 853
      Height = 403
    end
  end
  object dsBP: TDataSource
    Left = 712
    Top = 232
  end
  object dsSrcStatus: TDataSource
    Left = 720
    Top = 296
  end
  object dsResStatus: TDataSource
    Left = 720
    Top = 360
  end
  object dsActions: TDataSource
    Left = 712
    Top = 160
  end
  object dsRef: TDataSource
    OnDataChange = dsRefDataChange
    Left = 632
    Top = 448
  end
  object dsSrcBasis: TDataSource
    Left = 616
    Top = 216
  end
  object dsResBasis: TDataSource
    Left = 616
    Top = 288
  end
  object dsSpec: TDataSource
    Left = 704
    Top = 456
  end
end
