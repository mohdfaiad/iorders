object frmCCJAL_CreateUserMsg: TfrmCCJAL_CreateUserMsg
  Left = 26
  Top = 114
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1053#1086#1074#1086#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#1089#1082#1086#1077' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1077
  ClientHeight = 244
  ClientWidth = 536
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
    Width = 536
    Height = 22
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object pnlControl: TPanel
    Left = 0
    Top = 218
    Width = 536
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlControl'
    TabOrder = 1
    object pnlControl_Tool: TPanel
      Left = 378
      Top = 0
      Width = 158
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlControl_Tool'
      TabOrder = 0
      object tbarControl: TToolBar
        Left = 0
        Top = 0
        Width = 158
        Height = 26
        Align = alClient
        BorderWidth = 1
        ButtonWidth = 71
        Caption = 'tbarControl'
        EdgeBorders = []
        EdgeInner = esNone
        EdgeOuter = esNone
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tbtnControl_Create: TToolButton
          Left = 0
          Top = 0
          Action = aCreate
          AutoSize = True
        end
        object tbtnControl_Exit: TToolButton
          Left = 73
          Top = 0
          Action = aExit
        end
      end
    end
    object pnlControl_Show: TPanel
      Left = 0
      Top = 0
      Width = 378
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlParm: TPanel
    Left = 0
    Top = 22
    Width = 536
    Height = 196
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object lblWhom: TLabel
      Left = 216
      Top = 12
      Width = 73
      Height = 13
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    end
    object lblTopic: TLabel
      Left = 192
      Top = 34
      Width = 97
      Height = 13
      Caption = #1058#1077#1084#1072' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1103
    end
    object lblContent: TLabel
      Left = 5
      Top = 74
      Width = 133
      Height = 13
      Caption = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1103
    end
    object rgrpWhom: TRadioGroup
      Left = 0
      Top = 0
      Width = 184
      Height = 71
      Caption = ' '#1050#1086#1084#1091' '
      ItemIndex = 0
      Items.Strings = (
        #1050#1086#1085#1082#1088#1077#1090#1085#1086#1084#1091' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1102
        #1044#1083#1103' '#1090#1077#1082#1091#1097#1080#1093' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
        #1044#1083#1103' '#1074#1089#1077#1093)
      TabOrder = 0
      OnClick = rgrpWhomClick
    end
    object edWhom: TEdit
      Left = 292
      Top = 5
      Width = 237
      Height = 19
      Ctl3D = False
      MaxLength = 160
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 1
      OnChange = edWhomChange
      OnDblClick = edWhomDblClick
    end
    object edTopic: TEdit
      Left = 292
      Top = 28
      Width = 237
      Height = 19
      Ctl3D = False
      MaxLength = 160
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 3
      OnChange = edTopicChange
      OnDblClick = edTopicDblClick
    end
    object edContent: TMemo
      Left = 6
      Top = 90
      Width = 523
      Height = 101
      Ctl3D = False
      MaxLength = 4000
      ParentCtl3D = False
      TabOrder = 5
      OnChange = edContentChange
    end
    object btnChooseUser: TButton
      Left = 509
      Top = 6
      Width = 19
      Height = 17
      Action = aChooseUser
      TabOrder = 2
    end
    object btnChooseTopic: TButton
      Left = 509
      Top = 29
      Width = 19
      Height = 17
      Action = aChooseTopic
      TabOrder = 4
    end
  end
  object ActionList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 232
    Top = 62
    object aChooseUser: TAction
      Category = 'Choose'
      Caption = #8230
      OnExecute = aChooseUserExecute
    end
    object aChooseTopic: TAction
      Category = 'Choose'
      Caption = #8230
      OnExecute = aChooseTopicExecute
    end
    object aCreate: TAction
      Category = 'Control'
      Caption = #1057#1086#1079#1076#1072#1090#1100
      ImageIndex = 323
      OnExecute = aCreateExecute
    end
    object aExit: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
  end
  object spCreate: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_CreateAlertUserMsg;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@UserFrom'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@UserWhom'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@SignWhom'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = 0
      end
      item
        Name = '@UserTopic'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@Content'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = ''
      end
      item
        Name = '@SErr'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 4000
        Value = ''
      end>
    Left = 296
    Top = 62
  end
end
