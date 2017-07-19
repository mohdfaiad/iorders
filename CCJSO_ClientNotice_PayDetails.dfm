object frmCCJSO_ClientNotice_PayDetails: TfrmCCJSO_ClientNotice_PayDetails
  Left = 50
  Top = 154
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1054#1090#1087#1088#1072#1074#1082#1072' '#1082#1083#1080#1077#1085#1090#1091' '#1088#1077#1082#1074#1080#1079#1080#1090#1086#1074' '#1087#1083#1072#1090#1077#1078#1072
  ClientHeight = 415
  ClientWidth = 508
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    0000010020000000000040040000000000000000000000000000000000000000
    0000029EDA5E00C6E8D903E8F4FD01CCEDFE02A6E3FE038BD7B80171A92F0000
    0000000000000000000063320816A55610700000000000000000000000000086
    CC6F03A5EBF204ADEFFE03B8ECFE03CEF0FE04D0F1FE02B4E8FD02A2E3FA1770
    96BB776643BFC77626A4C97627AFCD7726F8C67325AA87511B29130C0401739B
    AD19039DDFEA0EBCE9FE13DDF2FE07DCF4FE09CFF3FF12C4F0FF0EB6EBFF06A8
    E6FF3DA0B8FFDD9140FFDD9140FFDD9140FFDC903FFBD58C3CCBA16A2E3C006C
    A56918BBE7FD29E7F9FF18E1F8FF07D6F6FF1DEAFCFF33F0F9FF2AD5EFFF71BB
    C3FFC49559FFE6A95EFFE6A95EFFE6A85DFFE5A95FFFE2AC6DE1B98448470A77
    B04F0079B7F5007DBEFE0080C2FF0080C3FFDBC8C8FFECE1E1FFEBE1E1FFE3CF
    B8FFEBC797FFEBC696FFEBC593FFEEBD7DFFEAC597FFD7C5B0A43734310F65A9
    CC1A0F7DB7B7007BBDEE007FC3F90082C6FDDBC8C8FFECE2E1FFEADFDEFFEBE1
    DCFFECE1DDFFECE1DDFFE7DDCEFFE8D4B7FFE9DCD7FFD2CCC7A43636360FEDF5
    F9066CADD1431D87C0911287C4C40E8DD1EBDBC9C7FFE7DADAFFE7D9D9FFE9DC
    DCFFE9DCDCFFE9DCDCFFE9DCDCFFE5D6D6FFE6DAD8FFD1CCC7A43636360F0000
    0000E4F0F60397C7E01B6BB3D9524EACE3AED8C7C4FFDBCCC8FFDCCDC9FFDCCD
    C9FFDCCDC9FFDCCDC9FFDCCDC9FFDCCDC9FFDBCBC7FECFC5C49F3535350C0000
    00000000000000000000CDE5F6169BCEF58497CDFEEF91CAFEEB9CCFF67ED4E9
    F615000000000000000000000000000000000000000000000000000000000000
    000000000000FAFCFF01D8ECFF25AED8FF9BAED8FFF6ADD8FFF3C0E1FF90EBF5
    FF1EFDFEFF010000000000000000000000000000000000000000000000000000
    000000000000E9F4FE09BADEFF52B1D9FECDC3E2FEFDC7E4FEFDBFE0FEBBDCED
    FE3FFAFCFF060000000000000000000000000000000000000000000000000000
    000000000000D1E9FF118CC5FF79A7D1FEF2CDE7FEFFD2E9FEFFB2D7FEE3C8E2
    FF64F7FBFF0C0000000000000000000000000000000000000000000000000000
    000000000000DDECFE1186B9FC7E86B8FBF8C8E3FDFEC5E0FEFF85B1EEEAA4C2
    EE6BF1F5FC0D0000000000000000000000000000000000000000000000000000
    000000000000ECF1FA0D83A5E16E2968D3EC4478D3FF4171C9FF275CBFDB86A3
    D95DEEF2FA0A0000000000000000000000000000000000000000000000000000
    000000000000EEF1F8057E97CC3A0237A1B3043CABF9043EB6F5023DB4A27E9B
    D62EEEF2F9030000000000000000000000000000000000000000000000000000
    00000000000000000000D6DEEE065778B92500329B520035A64D577CC81FD5DF
    F1040000000000000000000000000000000000000000000000000000000080E7
    000000000000000000000000000000000000000000000000000080000000E07F
    0000C03F0000C03F0000C03F0000C03F0000C03F0000C03F0000E07F0000}
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlControl: TPanel
    Left = 0
    Top = 389
    Width = 508
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlControl'
    TabOrder = 0
    object pnlControl_Tool: TPanel
      Left = 333
      Top = 0
      Width = 175
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlControl_Tool'
      TabOrder = 0
      object tbarTool: TToolBar
        Left = 0
        Top = 0
        Width = 175
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 83
        Caption = 'tbarTool'
        DisabledImages = FCCenterJournalNetZkz.imgMainDisable
        EdgeBorders = []
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        Indent = 3
        List = True
        ShowCaptions = True
        TabOrder = 0
        object ToolButton1: TToolButton
          Left = 3
          Top = 0
          Action = aRegNotice
          AutoSize = True
        end
        object ToolButton2: TToolButton
          Left = 90
          Top = 0
          Action = aExit
          AutoSize = True
        end
      end
    end
    object pnlControl_Show: TPanel
      Left = 0
      Top = 0
      Width = 333
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object edCheck: TMemo
        Left = 3
        Top = 3
        Width = 327
        Height = 20
        Align = alClient
        BevelKind = bkFlat
        BorderStyle = bsNone
        Lines.Strings = (
          '')
        TabOrder = 0
      end
    end
  end
  object pnlParm: TPanel
    Left = 0
    Top = 0
    Width = 508
    Height = 389
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object lblOrder: TLabel
      Left = 69
      Top = 14
      Width = 31
      Height = 13
      Caption = #1047#1072#1082#1072#1079
    end
    object lblPrefix: TLabel
      Left = 54
      Top = 39
      Width = 46
      Height = 13
      Caption = #1055#1088#1077#1092#1080#1082#1089
    end
    object lblPharm: TLabel
      Left = 231
      Top = 14
      Width = 79
      Height = 13
      Caption = #1058#1086#1088#1075#1086#1074#1072#1103' '#1090#1086#1095#1082#1072
    end
    object lblClient: TLabel
      Left = 64
      Top = 63
      Width = 36
      Height = 13
      Caption = #1050#1083#1080#1077#1085#1090
    end
    object lblPhone: TLabel
      Left = 47
      Top = 182
      Width = 53
      Height = 13
      Caption = #1058#1077#1083#1077#1092#1086#1085
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblEMail: TLabel
      Left = 68
      Top = 205
      Width = 32
      Height = 13
      Caption = 'EMail'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSum: TLabel
      Left = 4
      Top = 159
      Width = 96
      Height = 13
      Caption = #1057#1091#1084#1084#1072' '#1082' '#1086#1087#1083#1072#1090#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblShipping: TLabel
      Left = 31
      Top = 228
      Width = 69
      Height = 13
      Caption = #1042#1080#1076' '#1076#1086#1089#1090#1072#1074#1082#1080
    end
    object lblPayment: TLabel
      Left = 41
      Top = 252
      Width = 59
      Height = 13
      Caption = #1042#1080#1076' '#1086#1087#1083#1072#1090#1099
    end
    object lblDetails: TLabel
      Left = 7
      Top = 272
      Width = 102
      Height = 13
      Caption = #1056#1077#1082#1074#1080#1079#1080#1090#1099' '#1087#1083#1072#1090#1077#1078#1072
    end
    object lblOrderAmount: TLabel
      Left = 27
      Top = 87
      Width = 73
      Height = 13
      Caption = #1057#1091#1084#1084#1072' '#1079#1072#1082#1072#1079#1072
    end
    object lblOrderAmountShipping: TLabel
      Left = 16
      Top = 110
      Width = 84
      Height = 13
      Caption = #1057#1091#1084#1084#1072' '#1076#1086#1089#1090#1072#1074#1082#1080
    end
    object lblCoolantSum: TLabel
      Left = 52
      Top = 133
      Width = 48
      Height = 13
      Caption = #1061#1083#1072#1076#1086#1075#1077#1085
    end
    object Label1: TLabel
      Left = 239
      Top = 38
      Width = 70
      Height = 13
      Caption = #1054#1073#1097#1080#1081' '#1085#1086#1084#1077#1088
    end
    object edOrder: TEdit
      Left = 103
      Top = 8
      Width = 120
      Height = 20
      TabStop = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 0
    end
    object edPrefix: TEdit
      Left = 103
      Top = 32
      Width = 120
      Height = 20
      TabStop = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 2
    end
    object edClient: TEdit
      Left = 103
      Top = 56
      Width = 395
      Height = 20
      TabStop = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 4
    end
    object edPhone: TEdit
      Tag = 11
      Left = 103
      Top = 175
      Width = 120
      Height = 19
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvNone
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 9
      OnChange = aChangeExecute
    end
    object edEMail: TEdit
      Tag = 12
      Left = 103
      Top = 198
      Width = 395
      Height = 19
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvNone
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 10
      OnChange = aChangeExecute
    end
    object edSum: TEdit
      Tag = 10
      Left = 103
      Top = 152
      Width = 120
      Height = 19
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvNone
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 8
      OnChange = aChangeExecute
    end
    object edShipping: TEdit
      Left = 103
      Top = 221
      Width = 395
      Height = 20
      TabStop = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 11
    end
    object edPayment: TEdit
      Left = 103
      Top = 245
      Width = 395
      Height = 20
      TabStop = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 12
    end
    object edPharm: TEdit
      Left = 313
      Top = 8
      Width = 185
      Height = 20
      TabStop = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 3
    end
    object edDetails: TMemo
      Left = 10
      Top = 289
      Width = 488
      Height = 89
      TabStop = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      Lines.Strings = (
        '')
      ReadOnly = True
      TabOrder = 13
    end
    object edOrderAmount: TEdit
      Left = 103
      Top = 80
      Width = 120
      Height = 20
      TabStop = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 5
    end
    object edOrderAmountShipping: TEdit
      Left = 103
      Top = 104
      Width = 120
      Height = 20
      TabStop = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 6
    end
    object edCoolantSum: TEdit
      Left = 103
      Top = 128
      Width = 120
      Height = 20
      TabStop = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 7
    end
    object edOrderName: TEdit
      Left = 313
      Top = 32
      Width = 185
      Height = 20
      TabStop = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 1
    end
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 440
    Top = 24
    object aExit: TAction
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
    object aRegNotice: TAction
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      ImageIndex = 36
      OnExecute = aRegNoticeExecute
    end
    object aChange: TAction
      Caption = 'aChange'
      OnExecute = aChangeExecute
    end
  end
  object spGetPaymentDetails: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_PaymentDetails_Get;1'
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
        Name = '@CODE'
        Attributes = [paNullable]
        DataType = ftString
        Size = 40
        Value = Null
      end
      item
        Name = '@Prefix'
        Attributes = [paNullable]
        DataType = ftString
        Size = 10
        Value = Null
      end
      item
        Name = '@Order'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Pharm'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@FullName'
        Attributes = [paNullable]
        DataType = ftString
        Size = 160
        Value = Null
      end
      item
        Name = '@Sum'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = '@SignCheck'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end
      item
        Name = '@Details'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 2000
        Value = Null
      end
      item
        Name = '@Check'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 80
        Value = Null
      end
      item
        Name = '@SErr'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 4000
        Value = Null
      end
      item
        Name = '@OrderName'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = Null
      end>
    Left = 405
    Top = 43
  end
  object spPayDetails: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_ClientNotice_PayDetails;1'
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
        Value = 0
      end
      item
        Name = '@Prefix'
        Attributes = [paNullable]
        DataType = ftString
        Size = 10
        Value = ''
      end
      item
        Name = '@Order'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@Pharm'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@Cash'
        Attributes = [paNullable]
        DataType = ftBCD
        NumericScale = 2
        Precision = 17
        Value = 0c
      end
      item
        Name = '@Phone'
        Attributes = [paNullable]
        DataType = ftString
        Size = 160
        Value = ''
      end
      item
        Name = '@EMail'
        Attributes = [paNullable]
        DataType = ftString
        Size = 160
        Value = ''
      end
      item
        Name = '@Details'
        Attributes = [paNullable]
        DataType = ftString
        Size = 2000
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
    Left = 408
    Top = 96
  end
end
