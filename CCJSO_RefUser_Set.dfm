object frmCCJSO_RefUser_Set: TfrmCCJSO_RefUser_Set
  Left = 2041
  Top = 372
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1103
  ClientHeight = 87
  ClientWidth = 479
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
    Top = 61
    Width = 479
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlControl'
    TabOrder = 0
    object pnlControl_Tool: TPanel
      Left = 309
      Top = 0
      Width = 170
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlControl_Tool'
      TabOrder = 0
      object tbarTool: TToolBar
        Left = 0
        Top = 0
        Width = 170
        Height = 26
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 80
        Caption = 'tbarTool'
        DisabledImages = FCCenterJournalNetZkz.imgMainDisable
        EdgeBorders = []
        EdgeInner = esNone
        EdgeOuter = esNone
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tbtnTool_Save: TToolButton
          Left = 0
          Top = 0
          Action = aSave
          AutoSize = True
        end
        object tbtnTool_Exit: TToolButton
          Left = 84
          Top = 0
          Action = aExit
          AutoSize = True
        end
      end
    end
    object pnlControl_Show: TPanel
      Left = 0
      Top = 0
      Width = 309
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlFields: TPanel
    Left = 0
    Top = 0
    Width = 479
    Height = 61
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvSpace
    TabOrder = 1
    object lblUserApp: TLabel
      Left = 8
      Top = 13
      Width = 138
      Height = 13
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1103
    end
    object lblUserGamma: TLabel
      Left = 30
      Top = 37
      Width = 116
      Height = 13
      Caption = #1056#1072#1073#1086#1090#1085#1080#1082' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
    end
    object edUserApp: TEdit
      Left = 150
      Top = 8
      Width = 320
      Height = 20
      BevelKind = bkFlat
      BorderStyle = bsNone
      MaxLength = 60
      TabOrder = 0
      OnChange = aValFieldsChangeExecute
    end
    object edUserGamma: TEdit
      Left = 150
      Top = 32
      Width = 320
      Height = 20
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 1
      OnChange = aValFieldsChangeExecute
      OnDblClick = aSlUserGammaExecute
    end
    object btnSlUserGamma: TButton
      Left = 451
      Top = 33
      Width = 18
      Height = 18
      Action = aSlUserGamma
      TabOrder = 2
    end
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 280
    Top = 40
    object aSave: TAction
      Category = 'Control'
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ImageIndex = 7
      ShortCut = 13
      OnExecute = aSaveExecute
    end
    object aExit: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
    object aSlUserGamma: TAction
      Category = 'Control'
      Caption = #8230
      OnExecute = aSlUserGammaExecute
    end
    object aValFieldsChange: TAction
      Category = 'Control'
      Caption = 'aValFieldsChange'
      OnExecute = aValFieldsChangeExecute
    end
  end
  object spRefUser_Update: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_RefUser_Update;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
      end
      item
        Name = '@USER'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@RN'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@UserApp'
        Attributes = [paNullable]
        DataType = ftString
        Size = 60
        Value = ''
      end
      item
        Name = '@Employee'
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
    Left = 161
    Top = 40
  end
  object spRefUser_Insert: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_RefUser_Insert;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
      end
      item
        Name = '@USER'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@UserApp'
        Attributes = [paNullable]
        DataType = ftString
        Size = 60
        Value = ''
      end
      item
        Name = '@Employee'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@RN'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
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
    Left = 224
    Top = 24
  end
end
