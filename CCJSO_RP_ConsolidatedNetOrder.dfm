object frmCCJSO_RP_ConsolidatedNetOrder: TfrmCCJSO_RP_ConsolidatedNetOrder
  Left = 33
  Top = 217
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1074#1086#1076#1085#1099#1081' '#1086#1090#1095#1077#1090': '#1092#1080#1085#1072#1085#1089#1086#1074#1099#1077' '#1087#1086#1082#1072#1079#1072#1090#1077#1083#1080
  ClientHeight = 97
  ClientWidth = 428
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
    Top = 75
    Width = 428
    Height = 22
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlControl'
    TabOrder = 0
    object pnlControl_Tool: TPanel
      Left = 238
      Top = 0
      Width = 190
      Height = 22
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object tollBar: TToolBar
        Left = 0
        Top = 0
        Width = 190
        Height = 22
        Align = alClient
        AutoSize = True
        ButtonWidth = 99
        EdgeBorders = []
        EdgeInner = esNone
        EdgeOuter = esNone
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tlbtnExcel: TToolButton
          Left = 0
          Top = 0
          Action = aExcel
          AutoSize = True
        end
        object tlbtnClose: TToolButton
          Left = 103
          Top = 0
          Action = aClose
          AutoSize = True
        end
      end
    end
    object pnlControl_Show: TPanel
      Left = 0
      Top = 0
      Width = 238
      Height = 22
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlPage: TPanel
    Left = 0
    Top = 0
    Width = 428
    Height = 75
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlPage'
    TabOrder = 1
    object pageControl: TPageControl
      Left = 0
      Top = 0
      Width = 428
      Height = 75
      ActivePage = tabParm
      Align = alClient
      TabOrder = 0
      object tabParm: TTabSheet
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
        object grpbxPeriod: TGroupBox
          Left = 0
          Top = 0
          Width = 420
          Height = 45
          Align = alTop
          Caption = ' '#1055#1083#1072#1090#1077#1078#1080' '#1079#1072' '#1087#1077#1088#1080#1086#1076' '
          TabOrder = 0
          object Label1: TLabel
            Left = 7
            Top = 25
            Width = 6
            Height = 13
            Caption = #1089
          end
          object Label2: TLabel
            Left = 118
            Top = 25
            Width = 12
            Height = 13
            Caption = #1087#1086
          end
          object dtBegin: TDateTimePicker
            Left = 17
            Top = 18
            Width = 90
            Height = 21
            Date = 41856.717597962960000000
            Time = 41856.717597962960000000
            TabOrder = 0
          end
          object dtEnd: TDateTimePicker
            Left = 133
            Top = 18
            Width = 90
            Height = 21
            Date = 41856.717597962960000000
            Time = 41856.717597962960000000
            TabOrder = 1
          end
        end
      end
    end
  end
  object actionList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 315
    Top = 12
    object aExcel: TAction
      Category = 'Control'
      Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 111
      OnExecute = aExcelExecute
    end
    object aClose: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aCloseExecute
    end
  end
end
