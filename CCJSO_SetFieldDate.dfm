object frmCCJSO_SetFieldDate: TfrmCCJSO_SetFieldDate
  Left = 17
  Top = 360
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'frmCCJSO_SetFieldDate'
  ClientHeight = 65
  ClientWidth = 360
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
    Top = 39
    Width = 360
    Height = 26
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = 'pnlControl'
    TabOrder = 0
    object pnlControl_Tool: TPanel
      Left = 109
      Top = 0
      Width = 251
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlControl_Tool'
      TabOrder = 0
      object tbarControl: TToolBar
        Left = 0
        Top = 0
        Width = 251
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 87
        Caption = 'tbarControl'
        EdgeBorders = []
        EdgeInner = esNone
        EdgeOuter = esNone
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tbtnSet: TToolButton
          Left = 0
          Top = 0
          Action = aSet
          AutoSize = True
        end
        object tbtnClear: TToolButton
          Left = 91
          Top = 0
          Action = aClear
          AutoSize = True
        end
        object tbtnExit: TToolButton
          Left = 169
          Top = 0
          Action = aExit
          AutoSize = True
        end
      end
    end
    object pnlControl_Show: TPanel
      Left = 0
      Top = 0
      Width = 109
      Height = 26
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlFieldDate: TPanel
    Left = 0
    Top = 0
    Width = 360
    Height = 39
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvSpace
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 1
    object dtDate: TDateTimePicker
      Left = 74
      Top = 9
      Width = 89
      Height = 21
      Date = 42403.749103668980000000
      Time = 42403.749103668980000000
      TabOrder = 0
      OnChange = aValueFieldChangeExecute
    end
    object dtTime: TDateTimePicker
      Left = 167
      Top = 9
      Width = 75
      Height = 21
      Date = 42403.749213159720000000
      Time = 42403.749213159720000000
      Kind = dtkTime
      TabOrder = 1
      OnChange = aValueFieldChangeExecute
    end
    object pnlPage_Period_Tool: TPanel
      Left = 2
      Top = 2
      Width = 66
      Height = 35
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 2
      object tbarCheckPeriod: TToolBar
        Left = 0
        Top = 0
        Width = 66
        Height = 35
        Align = alClient
        AutoSize = True
        BorderWidth = 3
        EdgeBorders = []
        EdgeInner = esNone
        EdgeOuter = esNone
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object tbtnCheckPeriod_OnlyDate: TToolButton
          Left = 0
          Top = 0
          Action = aCheckPeriod_OnlyDate
          AutoSize = True
          Grouped = True
        end
        object tbtnCheckPeriod_DateTime: TToolButton
          Left = 27
          Top = 0
          Action = aCheckPeriod_DateTime
          AutoSize = True
          Grouped = True
        end
      end
    end
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 320
    Top = 8
    object aSet: TAction
      Category = 'Control'
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100
      ImageIndex = 36
      ShortCut = 13
      OnExecute = aSetExecute
    end
    object aClear: TAction
      Category = 'Control'
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      ImageIndex = 334
      OnExecute = aClearExecute
    end
    object aExit: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
    object aValueFieldChange: TAction
      Category = 'Main'
      Caption = 'aValueFieldChange'
      OnExecute = aValueFieldChangeExecute
    end
    object aCheckPeriod_OnlyDate: TAction
      Category = 'CheckPeriod'
      AutoCheck = True
      Caption = #1058#1086#1083#1100#1082#1086' '#1076#1072#1090#1072
      Checked = True
      GroupIndex = 1
      Hint = #1058#1086#1083#1100#1082#1086' '#1076#1072#1090#1072
      ImageIndex = 296
      OnExecute = aCheckPeriod_OnlyDateExecute
    end
    object aCheckPeriod_DateTime: TAction
      Category = 'CheckPeriod'
      AutoCheck = True
      Caption = #1044#1072#1090#1072' + '#1074#1088#1077#1084#1103
      GroupIndex = 1
      Hint = #1044#1072#1090#1072' + '#1074#1088#1077#1084#1103
      ImageIndex = 295
      OnExecute = aCheckPeriod_DateTimeExecute
    end
  end
  object spSetPlanDateSend: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_SetPlanDateSend;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@Order'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@CodeAction'
        Attributes = [paNullable]
        DataType = ftString
        Size = 80
        Value = ''
      end
      item
        Name = '@SDate'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end
      item
        Name = '@USER'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@SErr'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 4000
        Value = ''
      end>
    Left = 272
    Top = 8
  end
end
