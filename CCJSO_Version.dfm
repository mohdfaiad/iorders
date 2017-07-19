object frmCCJSO_Version: TfrmCCJSO_Version
  Left = 19
  Top = 122
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
  ClientHeight = 96
  ClientWidth = 252
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
  object pnlName: TPanel
    Left = 0
    Top = 0
    Width = 252
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    Caption = #169' '#1054#1073#1088#1072#1073#1086#1090#1082#1072' '#1080#1085#1090#1077#1088#1085#1077#1090' '#1079#1072#1082#1072#1079#1086#1074
    TabOrder = 0
  end
  object pnlVersion: TPanel
    Left = 0
    Top = 44
    Width = 252
    Height = 52
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnlVersionTool: TPanel
      Left = 0
      Top = 26
      Width = 252
      Height = 26
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object tbarVersion: TToolBar
        Left = 0
        Top = 0
        Width = 252
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 149
        Caption = 'tbarVersion'
        EdgeBorders = []
        EdgeInner = esNone
        EdgeOuter = esNone
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        Indent = 48
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tbtnVersion_Contents: TToolButton
          Left = 48
          Top = 0
          Action = aContents
          AutoSize = True
        end
      end
    end
    object pnlVersionShow: TPanel
      Left = 0
      Top = 0
      Width = 252
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlAlarm: TPanel
    Left = 0
    Top = 21
    Width = 252
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = #1042#1099' '#1080#1089#1087#1086#1083#1100#1079#1091#1077#1090#1077' '#1091#1089#1090#1072#1088#1077#1074#1096#1091#1102' '#1074#1077#1088#1089#1080#1102'!'
    Color = clRed
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 208
    Top = 16
    object aExit: TAction
      Category = 'Control'
      Caption = 'aExit'
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
    object aContents: TAction
      Category = 'Control'
      Caption = #1061#1088#1086#1085#1086#1083#1086#1075#1080#1103' '#1088#1072#1079#1088#1072#1073#1086#1090#1082#1080
      ImageIndex = 355
      OnExecute = aContentsExecute
    end
  end
end
