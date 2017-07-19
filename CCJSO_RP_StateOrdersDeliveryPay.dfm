object frmCCJSO_RP_StateOrdersDeliveryPay: TfrmCCJSO_RP_StateOrdersDeliveryPay
  Left = 32
  Top = 133
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1079#1072#1082#1072#1079#1086#1074' '#1087#1086' '#1085#1072#1083#1086#1078#1077#1085#1085#1099#1084' '#1087#1083#1072#1090#1077#1078#1072#1084
  ClientHeight = 85
  ClientWidth = 409
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
    Top = 63
    Width = 409
    Height = 22
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlControl'
    TabOrder = 0
    object pnlControl_Tool: TPanel
      Left = 222
      Top = 0
      Width = 187
      Height = 22
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object tollBar: TToolBar
        Left = 0
        Top = 0
        Width = 187
        Height = 22
        Align = alClient
        AutoSize = True
        ButtonWidth = 99
        DisabledImages = FCCenterJournalNetZkz.imgMainDisable
        EdgeBorders = []
        EdgeInner = esNone
        EdgeOuter = esNone
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tlbtnExcel: TToolButton
          Left = 0
          Top = 0
          Action = aExcel
          AutoSize = True
        end
        object tlbtnClose: TToolButton
          Left = 103
          Top = 0
          Action = aClose
          AutoSize = True
        end
      end
    end
    object pnlControl_Show: TPanel
      Left = 0
      Top = 0
      Width = 222
      Height = 22
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlParm: TPanel
    Left = 0
    Top = 0
    Width = 409
    Height = 63
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object gbxParm: TGroupBox
      Left = 0
      Top = 0
      Width = 409
      Height = 63
      Align = alClient
      Caption = ' '#1047#1072' '#1087#1077#1088#1080#1086#1076' '
      TabOrder = 0
      object lblDateBegin: TLabel
        Left = 8
        Top = 30
        Width = 6
        Height = 13
        Caption = #1089
      end
      object lblDateEnd: TLabel
        Left = 158
        Top = 30
        Width = 12
        Height = 13
        Caption = #1087#1086
      end
      object edDateBegin: TEdit
        Tag = 10
        Left = 19
        Top = 22
        Width = 130
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
        OnChange = aFieldChangeExecute
        OnDblClick = aSlDateExecute
      end
      object edDateEnd: TEdit
        Tag = 11
        Left = 173
        Top = 22
        Width = 130
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 1
        OnChange = aFieldChangeExecute
        OnDblClick = aSlDateExecute
      end
      object btnDateBegin: TButton
        Tag = 10
        Left = 128
        Top = 24
        Width = 19
        Height = 17
        Action = aSlDate
        TabOrder = 2
      end
      object btnDateEnd: TButton
        Tag = 11
        Left = 282
        Top = 24
        Width = 19
        Height = 17
        Action = aSlDate
        TabOrder = 3
      end
    end
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 320
    Top = 24
    object aExcel: TAction
      Category = 'Control'
      Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 111
      OnExecute = aExcelExecute
    end
    object aClose: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aCloseExecute
    end
    object aSlDate: TAction
      Category = 'Control'
      Caption = #8230
      OnExecute = aSlDateExecute
    end
    object aFieldChange: TAction
      Category = 'Control'
      Caption = 'aFieldChange'
      OnExecute = aFieldChangeExecute
    end
  end
  object qrspPay: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 200
    ProcedureName = 'pDS_jso_RP_StateOrdersDeliveryPay;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@SBegin'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end
      item
        Name = '@SEnd'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end>
    Left = 368
    Top = 16
  end
end
