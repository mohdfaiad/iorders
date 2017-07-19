object frmCCJSO_CalcCDO: TfrmCCJSO_CalcCDO
  Left = 2391
  Top = 37
  Width = 501
  Height = 171
  Caption = #1056#1072#1089#1095#1077#1090' '#1085#1072#1083#1086#1078#1077#1085#1085#1086#1075#1086' '#1087#1083#1072#1090#1077#1078#1072
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
    Top = 107
    Width = 485
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlControl'
    TabOrder = 0
    object pnlControl_Tool: TPanel
      Left = 307
      Top = 0
      Width = 178
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlControl_Tool'
      TabOrder = 0
      object tBarControl: TToolBar
        Left = 0
        Top = 0
        Width = 178
        Height = 26
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 88
        Caption = 'tBarControl'
        DisabledImages = FCCenterJournalNetZkz.imgMainDisable
        EdgeBorders = []
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tbtbExec: TToolButton
          Left = 0
          Top = 0
          Action = aExec
          AutoSize = True
        end
        object tbtnExit: TToolButton
          Left = 92
          Top = 0
          Action = aExit
          AutoSize = True
        end
      end
    end
    object pnlControl_Show: TPanel
      Left = 0
      Top = 0
      Width = 307
      Height = 26
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlVal: TPanel
    Left = 0
    Top = 0
    Width = 485
    Height = 107
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnlVal_RuleShow: TPanel
      Left = 0
      Top = 0
      Width = 485
      Height = 26
      Align = alTop
      Alignment = taLeftJustify
      BevelInner = bvLowered
      BevelOuter = bvSpace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object pnlVal_Fields: TPanel
      Left = 0
      Top = 26
      Width = 485
      Height = 81
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object lblPlanOrderAmount: TLabel
        Left = 9
        Top = 12
        Width = 125
        Height = 13
        Caption = #1055#1083#1072#1085#1086#1074#1072#1103' '#1089#1091#1084#1084#1072' '#1079#1072#1082#1072#1079#1072
      end
      object lblCalcOrderAmount: TLabel
        Left = 6
        Top = 36
        Width = 128
        Height = 13
        Caption = #1056#1072#1089#1095#1077#1090#1085#1072#1103' '#1089#1091#1084#1084#1072' '#1079#1072#1082#1072#1079#1072
      end
      object lblOrderAmountCOD: TLabel
        Left = 28
        Top = 58
        Width = 106
        Height = 13
        Caption = #1053#1072#1083#1086#1078#1077#1085#1085#1099#1081' '#1087#1083#1072#1090#1077#1078
      end
      object edPlanOrderAmount: TEdit
        Left = 138
        Top = 6
        Width = 121
        Height = 20
        BevelKind = bkFlat
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
      object edCalcOrderAmount: TEdit
        Left = 138
        Top = 29
        Width = 121
        Height = 20
        BevelKind = bkFlat
        BorderStyle = bsNone
        TabOrder = 1
        OnChange = aChangeEditExecute
      end
      object edOrderAmountCOD: TEdit
        Left = 138
        Top = 52
        Width = 121
        Height = 20
        BevelKind = bkFlat
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 2
      end
    end
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 440
    Top = 26
    object aExit: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
    object aExec: TAction
      Category = 'Control'
      Caption = #1054#1087#1088#1077#1076#1077#1083#1080#1090#1100
      ImageIndex = 36
      OnExecute = aExecExecute
    end
    object aChangeEdit: TAction
      Category = 'Control'
      Caption = 'aChangeEdit'
      OnExecute = aChangeEditExecute
    end
  end
end
