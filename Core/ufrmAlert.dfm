object frmAlert: TfrmAlert
  Left = 0
  Top = 0
  Width = 368
  Height = 240
  TabOrder = 0
  object PanelCaption: TPanel
    Left = 0
    Top = 0
    Width = 368
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = True
    ParentColor = True
    TabOrder = 0
    object lbType: TLabel
      Left = 0
      Top = 0
      Width = 368
      Height = 13
      Align = alTop
      Alignment = taRightJustify
      Caption = 'Alert Type '
    end
    object imgEventType: TImage
      Left = 5
      Top = 13
      Width = 26
      Height = 26
      Proportional = True
      Stretch = True
      Transparent = True
    end
    object edCaption: TEdit
      Left = 38
      Top = 16
      Width = 321
      Height = 24
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = 'Caption'
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 199
    Width = 368
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = True
    ParentColor = True
    TabOrder = 1
    DesignSize = (
      368
      41)
    object btnAccept: TBitBtn
      Left = 207
      Top = 8
      Width = 153
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1055#1088#1080#1085#1103#1090#1086' '#1082' '#1080#1089#1087#1086#1083#1085#1077#1085#1080#1102
      TabOrder = 0
      OnClick = btnAcceptClick
    end
  end
  object spIncUserEnumerator: TADOStoredProc
    CommandTimeout = 100
    ProcedureName = 'p_jso_JournalAlert_IncUserEnumerator;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@NRN'
        Attributes = [paNullable]
        DataType = ftLargeint
        Precision = 19
        Value = '0'
      end>
    Left = 43
    Top = 64
  end
  object spSetUserRead: TADOStoredProc
    CommandTimeout = 100
    ProcedureName = 'p_jso_JournalAlert_SetUserRead;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@NRN'
        Attributes = [paNullable]
        DataType = ftLargeint
        Precision = 19
        Value = '0'
      end>
    Left = 43
    Top = 112
  end
end
