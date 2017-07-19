object frmCCJSO_BlackListControl: TfrmCCJSO_BlackListControl
  Left = 44
  Top = 181
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'frmCCJSO_BlackListControl'
  ClientHeight = 170
  ClientWidth = 514
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
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 514
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlTop'
    TabOrder = 0
    object pnlTop_Order: TPanel
      Left = 0
      Top = 0
      Width = 131
      Height = 21
      Align = alLeft
      BevelInner = bvSpace
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object pnlTop_Client: TPanel
      Left = 131
      Top = 0
      Width = 383
      Height = 21
      Align = alClient
      Alignment = taLeftJustify
      BevelInner = bvSpace
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
  object pnlControl: TPanel
    Left = 0
    Top = 148
    Width = 514
    Height = 22
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlControl'
    TabOrder = 1
    object pnlControl_Tool: TPanel
      Left = 253
      Top = 0
      Width = 261
      Height = 22
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object tollBar: TToolBar
        Left = 0
        Top = 0
        Width = 261
        Height = 22
        Align = alClient
        AutoSize = True
        ButtonWidth = 165
        DisabledImages = FCCenterJournalNetZkz.imgMainDisable
        EdgeBorders = []
        EdgeInner = esNone
        EdgeOuter = esNone
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tlbtnExec: TToolButton
          Left = 0
          Top = 0
          Action = aBlackList_Open
          AutoSize = True
        end
        object tlbtnClose: TToolButton
          Left = 169
          Top = 0
          Action = aFrmClose
          AutoSize = True
        end
      end
    end
    object pnlControl_Show: TPanel
      Left = 0
      Top = 0
      Width = 253
      Height = 22
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object TPanel
    Left = 0
    Top = 21
    Width = 514
    Height = 127
    Align = alClient
    Alignment = taLeftJustify
    TabOrder = 2
    object lblNote: TLabel
      Left = 15
      Top = 4
      Width = 63
      Height = 13
      Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
    end
    object edNote: TMemo
      Left = 11
      Top = 19
      Width = 492
      Height = 98
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = True
      Lines.Strings = (
        '')
      MaxLength = 500
      ParentCtl3D = False
      TabOrder = 0
      OnChange = edNoteChange
    end
  end
  object actionList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 462
    Top = 35
    object aBlackList_Open: TAction
      Category = 'Control'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1095#1077#1088#1085#1099#1081' '#1089#1087#1080#1089#1086#1082
      ImageIndex = 346
      OnExecute = aBlackList_OpenExecute
    end
    object aFrmClose: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aFrmCloseExecute
    end
    object aBlackList_Close: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1089#1088#1086#1082' '#1076#1077#1081#1089#1090#1074#1080#1103' '#1074' '#1095#1077#1088#1085#1086#1084' '#1089#1087#1080#1089#1082#1077
      ImageIndex = 347
      OnExecute = aBlackList_CloseExecute
    end
    object aBlackList_NnknownMode: TAction
      Category = 'Control'
      Caption = #1053#1077#1080#1079#1074#1077#1089#1090#1085#1099#1081' '#1088#1077#1078#1080#1084' '#1088#1072#1073#1086#1090#1099
      ImageIndex = 345
    end
  end
end
