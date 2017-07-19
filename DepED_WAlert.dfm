object frmDepED_WAlert: TfrmDepED_WAlert
  Left = 38
  Top = 112
  AlphaBlend = True
  AlphaBlendValue = 215
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'frmDepED_WAlert'
  ClientHeight = 99
  ClientWidth = 380
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlControl: TPanel
    Left = 0
    Top = 76
    Width = 380
    Height = 23
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlControl'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object pnlControl_Tool: TPanel
      Left = 205
      Top = 0
      Width = 175
      Height = 23
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object tlbarControl: TToolBar
        Left = 0
        Top = 0
        Width = 175
        Height = 23
        Align = alClient
        ButtonHeight = 19
        ButtonWidth = 149
        Caption = 'tlbarControl'
        EdgeInner = esNone
        EdgeOuter = esNone
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        List = True
        ParentFont = False
        ShowCaptions = True
        TabOrder = 0
        object tlbtnControl_Read: TToolButton
          Left = 0
          Top = 0
          Action = aMain_Read
          AutoSize = True
        end
      end
    end
    object pnlControl_Show: TPanel
      Left = 0
      Top = 0
      Width = 205
      Height = 23
      Align = alClient
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 380
    Height = 76
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnlMain_Img: TPanel
      Left = 0
      Top = 0
      Width = 35
      Height = 76
      Align = alLeft
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object imgEventType: TImage
        Left = 5
        Top = 4
        Width = 26
        Height = 26
        Proportional = True
        Stretch = True
        Transparent = True
      end
    end
    object pnlMain_Msg: TPanel
      Left = 35
      Top = 0
      Width = 345
      Height = 76
      Align = alClient
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object edNameTypeAlert: TEdit
        Left = 1
        Top = 18
        Width = 340
        Height = 17
        TabStop = False
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = True
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        Text = '123'
      end
      object mMsgAlert: TMemo
        Left = 1
        Top = 34
        Width = 340
        Height = 39
        TabStop = False
        BevelInner = bvNone
        BevelOuter = bvNone
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Lines.Strings = (
          '')
        ParentColor = True
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object edAlertDate: TEdit
        Left = 1
        Top = 2
        Width = 340
        Height = 17
        TabStop = False
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = True
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        Text = '123'
      end
    end
  end
  object tmrCloseAW: TTimer
    Enabled = False
    Interval = 8000
    OnTimer = tmrCloseAWTimer
    Left = 292
    Top = 6
  end
  object tmrFade: TTimer
    Enabled = False
    Interval = 5
    OnTimer = tmrFadeTimer
    Left = 344
    Top = 7
  end
  object aMain: TActionList
    Left = 233
    Top = 8
    object aMain_Read: TAction
      Category = 'Control'
      Caption = #1055#1088#1080#1085#1103#1090#1086' '#1082' '#1080#1089#1087#1086#1083#1085#1077#1085#1080#1102
      ImageIndex = 162
      OnExecute = aMain_ReadExecute
    end
  end
  object spIncUserEnumerator: TADOStoredProc
    Connection = Form1.ADOC_STAT
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
    Left = 51
    Top = 48
  end
  object spSetUserRead: TADOStoredProc
    Connection = Form1.ADOC_STAT
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
    Left = 147
    Top = 48
  end
end
