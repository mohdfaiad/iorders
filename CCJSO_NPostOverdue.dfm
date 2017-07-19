object frmCCJSO_NPostOverdue: TfrmCCJSO_NPostOverdue
  Left = 29
  Top = 236
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1047#1072#1082#1072#1079#1099' '#1089' '#1087#1088#1086#1089#1088#1086#1095#1077#1085#1085#1099#1084' '#1089#1088#1086#1082#1086#1084' '#1087#1088#1080#1073#1099#1090#1080#1103' '#1080' '#1087#1086#1083#1091#1095#1077#1085#1080#1103
  ClientHeight = 86
  ClientWidth = 436
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
    Top = 60
    Width = 436
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlControl'
    TabOrder = 0
    object pnlControl_Tool: TPanel
      Left = 265
      Top = 0
      Width = 171
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlControl_Tool'
      TabOrder = 0
      object toolbrControl: TToolBar
        Left = 0
        Top = 0
        Width = 171
        Height = 26
        Align = alClient
        BorderWidth = 1
        ButtonWidth = 83
        Caption = 'toolbrControl'
        EdgeBorders = []
        EdgeInner = esNone
        EdgeOuter = esNone
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Action = aExec
          AutoSize = True
        end
        object ToolButton2: TToolButton
          Left = 87
          Top = 0
          Action = aExit
          AutoSize = True
        end
      end
    end
    object pnlControl_Show: TPanel
      Left = 0
      Top = 0
      Width = 265
      Height = 26
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlParm: TPanel
    Left = 0
    Top = 0
    Width = 436
    Height = 60
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 1
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 384
    Top = 8
    object aExec: TAction
      Category = 'control'
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      ImageIndex = 7
      ShortCut = 13
      OnExecute = aExecExecute
    end
    object aExit: TAction
      Category = 'control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
  end
  object spOverdue: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_RP_NPostOverdue;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@SignOverdue'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = 0
      end>
    Left = 320
    Top = 8
  end
end
