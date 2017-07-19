object frmCCJS_Pay: TfrmCCJS_Pay
  Left = 18
  Top = 761
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1055#1083#1072#1090#1077#1078#1080
  ClientHeight = 176
  ClientWidth = 503
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
  object pnlTool: TPanel
    Left = 0
    Top = 150
    Width = 503
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlTool'
    TabOrder = 0
    object pnlTool_Control: TPanel
      Left = 324
      Top = 0
      Width = 179
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object tlbrControl: TToolBar
        Left = 0
        Top = 0
        Width = 179
        Height = 26
        Align = alClient
        BorderWidth = 1
        ButtonWidth = 82
        Caption = 'tlbrControl'
        DisabledImages = FCCenterJournalNetZkz.imgMainDisable
        EdgeBorders = []
        EdgeInner = esNone
        EdgeOuter = esNone
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tlbtnControl_OK: TToolButton
          Left = 0
          Top = 0
          Action = AMain_Upd
          AutoSize = True
        end
        object tlbtnControl_Exit: TToolButton
          Left = 86
          Top = 0
          Action = aMain_Exit
        end
      end
    end
    object pnlTool_Show: TPanel
      Left = 0
      Top = 0
      Width = 324
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlFields: TPanel
    Left = 0
    Top = 0
    Width = 503
    Height = 150
    Align = alClient
    Alignment = taLeftJustify
    BevelInner = bvLowered
    BevelOuter = bvSpace
    TabOrder = 1
    object lblDocDate: TLabel
      Left = 63
      Top = 17
      Width = 26
      Height = 13
      Caption = #1044#1072#1090#1072
    end
    object lblNumber: TLabel
      Left = 55
      Top = 38
      Width = 34
      Height = 13
      Caption = #1053#1086#1084#1077#1088
    end
    object lblSum: TLabel
      Left = 55
      Top = 60
      Width = 34
      Height = 13
      Caption = #1057#1091#1084#1084#1072
    end
    object lblNote: TLabel
      Left = 28
      Top = 105
      Width = 61
      Height = 13
      Caption = #1053#1072#1079#1085#1072#1095#1077#1085#1080#1077
    end
    object lblBarCode: TLabel
      Left = 37
      Top = 83
      Width = 52
      Height = 13
      Caption = #1064#1090#1088#1080#1093'-'#1082#1086#1076
    end
    object lblRedeliveryDate: TLabel
      Left = 8
      Top = 127
      Width = 81
      Height = 13
      Caption = #1044#1072#1090#1072' '#1087#1086#1083#1091#1095#1077#1085#1080#1103
    end
    object edNumber: TEdit
      Left = 92
      Top = 33
      Width = 150
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = True
      MaxLength = 20
      ParentCtl3D = False
      TabOrder = 2
      OnChange = edNumberChange
    end
    object edSum: TEdit
      Left = 92
      Top = 55
      Width = 150
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      MaxLength = 15
      TabOrder = 3
      OnChange = edSumChange
    end
    object edNote: TEdit
      Left = 92
      Top = 99
      Width = 400
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      MaxLength = 2000
      TabOrder = 5
      OnChange = edNoteChange
    end
    object edDocDate: TEdit
      Left = 92
      Top = 11
      Width = 150
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = True
      MaxLength = 30
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 0
      OnChange = edDocDateChange
    end
    object edBarCode: TEdit
      Left = 92
      Top = 77
      Width = 150
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = True
      MaxLength = 20
      ParentCtl3D = False
      TabOrder = 4
      OnChange = edBarCodeChange
    end
    object btnSetDocDate: TButton
      Left = 224
      Top = 12
      Width = 17
      Height = 17
      Action = aSetDocDate
      TabOrder = 1
    end
    object edRedeliveryDate: TEdit
      Left = 92
      Top = 121
      Width = 150
      Height = 19
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = True
      MaxLength = 30
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 6
      OnChange = edDocDateChange
    end
    object btnSetRedeliveryDate: TButton
      Left = 224
      Top = 122
      Width = 17
      Height = 17
      Action = aSetRedeliveryDate
      TabOrder = 7
    end
  end
  object aMain: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 248
    Top = 12
    object aMain_Add: TAction
      Category = 'Control'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 5
      OnExecute = aMain_AddExecute
    end
    object AMain_Upd: TAction
      Category = 'Control'
      Caption = #1048#1089#1087#1088#1072#1074#1080#1090#1100
      ImageIndex = 7
      OnExecute = AMain_UpdExecute
    end
    object aMain_Exit: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aMain_ExitExecute
    end
    object aSetDocDate: TAction
      Category = 'Control'
      Caption = #8230
      Hint = #1054#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1076#1072#1090#1091' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      OnExecute = aSetDocDateExecute
    end
    object aSetRedeliveryDate: TAction
      Category = 'Control'
      Caption = #8230
      Hint = #1054#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1076#1072#1090#1091' '#1087#1086#1083#1091#1095#1077#1085#1080#1103' '#1087#1083#1072#1090#1077#1078#1072' '#1086#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1084' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1077#1084
      OnExecute = aSetRedeliveryDateExecute
    end
  end
  object spPayInsert: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_OrderPay_Insert;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@ActionCode'
        Attributes = [paNullable]
        DataType = ftString
        Size = 80
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
        Name = '@NHistory'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@Order'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@DocNumb'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@DocSumPay'
        Attributes = [paNullable]
        DataType = ftBCD
        NumericScale = 2
        Precision = 18
        Value = 0c
      end
      item
        Name = '@SDocDate'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end
      item
        Name = '@DocNote'
        Attributes = [paNullable]
        DataType = ftString
        Size = 2000
        Value = ''
      end
      item
        Name = '@SCreateDate'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end
      item
        Name = '@NRN'
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
      end
      item
        Name = '@BarCode'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end
      item
        Name = '@SRedeliveryDate'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end>
    Left = 285
    Top = 24
  end
  object spPayExist: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_OrderPay_Exist;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@RN'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 328
    Top = 12
  end
  object spPayUpdate: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_OrderPay_Update;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@ActionCode'
        Attributes = [paNullable]
        DataType = ftString
        Size = 80
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
        Name = '@NHistory'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@NRN'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@Order'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@DocNumb'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@DocSumPay'
        Attributes = [paNullable]
        DataType = ftBCD
        NumericScale = 2
        Precision = 18
        Value = 0c
      end
      item
        Name = '@SDocDate'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end
      item
        Name = '@DocNote'
        Attributes = [paNullable]
        DataType = ftString
        Size = 2000
        Value = ''
      end
      item
        Name = '@SCreateDate'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end
      item
        Name = '@SErr'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 4000
        Value = ''
      end
      item
        Name = '@BarCode'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end
      item
        Name = '@SRedeliveryDate'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end>
    Left = 377
    Top = 23
  end
  object spGenNumb: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_OrderPay_GenNumb;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@Numb'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 20
        Value = ''
      end>
    Left = 442
    Top = 15
  end
end
