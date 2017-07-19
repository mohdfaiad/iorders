object frmCCJSO_SetLink: TfrmCCJSO_SetLink
  Left = 151
  Top = 137
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 127
  ClientWidth = 459
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
    Top = 101
    Width = 459
    Height = 26
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvNone
    TabOrder = 0
    object pnlControl_Tool: TPanel
      Left = 278
      Top = 0
      Width = 181
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlControl_Tool'
      TabOrder = 0
      object tbarControl: TToolBar
        Left = 0
        Top = 0
        Width = 181
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 83
        Caption = 'tbarControl'
        DisabledImages = FCCenterJournalNetZkz.imgMainDisable
        EdgeBorders = []
        EdgeInner = esNone
        EdgeOuter = esNone
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tbtnControl_Ok: TToolButton
          Left = 0
          Top = 0
          Action = aOk
          AutoSize = True
        end
        object tbtnControl_Exit: TToolButton
          Left = 87
          Top = 0
          Action = aExit
        end
      end
    end
    object pnlControl_Show: TPanel
      Left = 0
      Top = 0
      Width = 278
      Height = 26
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 459
    Height = 57
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    TabOrder = 1
    object pnlHeader_Order: TPanel
      Left = 0
      Top = 0
      Width = 459
      Height = 19
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 0
    end
    object pnlHeader_ParentsList: TPanel
      Left = 0
      Top = 19
      Width = 459
      Height = 19
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = ' '#1056#1086#1076#1080#1090#1077#1083#1100#1089#1082#1080#1077' '#1079#1072#1082#1072#1079#1099': '
      TabOrder = 1
      object pnlHeader_ParentsList_Value: TPanel
        Left = 158
        Top = 0
        Width = 301
        Height = 19
        Align = alRight
        Alignment = taLeftJustify
        BevelOuter = bvNone
        TabOrder = 0
      end
    end
    object pnlHeader_SlavesList: TPanel
      Left = 0
      Top = 38
      Width = 459
      Height = 19
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = ' '#1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1079#1072#1082#1072#1079#1099': '
      TabOrder = 2
      object pnlHeader_SlavesList_Value: TPanel
        Left = 174
        Top = 0
        Width = 285
        Height = 19
        Align = alRight
        Alignment = taLeftJustify
        BevelOuter = bvNone
        TabOrder = 0
      end
    end
  end
  object pnlParam: TPanel
    Left = 0
    Top = 57
    Width = 459
    Height = 44
    Align = alClient
    Alignment = taLeftJustify
    BevelInner = bvSpace
    BevelOuter = bvLowered
    TabOrder = 2
    object lblOrder: TLabel
      Left = 5
      Top = 16
      Width = 36
      Height = 13
      Caption = 'lblOrder'
    end
    object edOrder: TEdit
      Left = 111
      Top = 12
      Width = 121
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      MaxLength = 20
      TabOrder = 0
      OnChange = edOrderChange
    end
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 312
    Top = 8
    object aOk: TAction
      Category = 'Control'
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      ImageIndex = 36
      ShortCut = 13
      OnExecute = aOkExecute
    end
    object aExit: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
  end
  object spSetLink: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_SetLink;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@USER'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@OrderBase'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@OrderLink'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@ModeLink'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end
      item
        Name = '@SErr'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 4000
        Value = Null
      end>
    Left = 376
    Top = 8
  end
end
