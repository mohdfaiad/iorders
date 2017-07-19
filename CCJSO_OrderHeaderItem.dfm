object frmCCJSO_OrderHeaderItem: TfrmCCJSO_OrderHeaderItem
  Left = 428
  Top = 131
  BorderStyle = bsSingle
  Caption = #1048#1085#1090#1077#1088#1085#1077#1090'-'#1079#1072#1082#1072#1079
  ClientHeight = 642
  ClientWidth = 776
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
    Top = 612
    Width = 776
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object pnlControl_Tool: TPanel
      Left = 464
      Top = 0
      Width = 318
      Height = 35
      Align = alCustom
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 0
      object tBarControl: TToolBar
        Left = 56
        Top = 0
        Width = 257
        Height = 35
        Align = alCustom
        Anchors = []
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 80
        Caption = 'tBarControl'
        DisabledImages = FCCenterJournalNetZkz.imgMainDisable
        EdgeBorders = []
        EdgeInner = esNone
        EdgeOuter = esNone
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object btnControl_Save: TToolButton
          Left = 0
          Top = 0
          Action = aSave
        end
        object ToolButton1: TToolButton
          Left = 80
          Top = 0
          Action = aUndo
          Caption = #1054#1090#1084#1077#1085#1080#1090#1100
        end
        object btnControl_Exit: TToolButton
          Left = 160
          Top = 0
          Action = aExit
        end
      end
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 60
    Width = 776
    Height = 552
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #1056#1045#1050#1042#1048#1047#1048#1058#1067
      DesignSize = (
        768
        524)
      object lblOrderShipping: TLabel
        Left = 7
        Top = 5
        Width = 100
        Height = 13
        Caption = #1042#1048#1044' '#1044#1054#1057#1058#1040#1042#1050#1048
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblOrderPayment: TLabel
        Left = 268
        Top = 5
        Width = 86
        Height = 13
        Caption = #1042#1048#1044' '#1054#1055#1051#1040#1058#1067
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblApteka: TLabel
        Left = 3
        Top = 98
        Width = 94
        Height = 13
        Caption = #1058#1086#1088#1075#1086#1074#1072#1103' '#1090#1086#1095#1082#1072
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object lblNOrderAmountCOD: TLabel
        Left = 362
        Top = 61
        Width = 101
        Height = 13
        Caption = #1057#1091#1084#1084#1072' '#1085#1072#1083#1086#1078'. '#1087#1083#1072#1090'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblNCoolantSum: TLabel
        Left = 570
        Top = 61
        Width = 85
        Height = 13
        Caption = #1057#1091#1084#1084#1072' '#1061#1083#1072#1076#1086#1075#1077#1085
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblSOrderComment: TLabel
        Left = 11
        Top = 320
        Width = 116
        Height = 13
        Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077' '#1087#1086' '#1079#1072#1082#1072#1079#1091
      end
      object lblSOrderShipCity: TLabel
        Left = 450
        Top = 98
        Width = 36
        Height = 13
        Caption = #1043#1086#1088#1086#1076
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblOrderShipStreet: TLabel
        Left = 3
        Top = 126
        Width = 37
        Height = 13
        Caption = #1040#1076#1088#1077#1089
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblShipName: TLabel
        Left = 4
        Top = 155
        Width = 43
        Height = 13
        Caption = #1060'.'#1048'.'#1054'.'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object lblOrderPhone: TLabel
        Left = 228
        Top = 155
        Width = 27
        Height = 13
        Caption = #1058#1077#1083'.'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object lblOrderEmail: TLabel
        Left = 549
        Top = 155
        Width = 32
        Height = 13
        Caption = 'EMail'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object lblSStatusName: TLabel
        Left = 529
        Top = 5
        Width = 116
        Height = 13
        Caption = #1058#1045#1050#1059#1065#1048#1049' '#1057#1058#1040#1058#1059#1057
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNOrderAmountShipping: TLabel
        Left = 154
        Top = 60
        Width = 84
        Height = 13
        Caption = #1057#1091#1084#1084#1072' '#1076#1086#1089#1090#1072#1074#1082#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblOrderAmount: TLabel
        Left = 6
        Top = 60
        Width = 34
        Height = 13
        Caption = #1057#1091#1084#1084#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lbHistoryComments: TLabel
        Left = 11
        Top = 385
        Width = 119
        Height = 13
        Caption = #1048#1089#1090#1086#1088#1080#1103'. '#1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
      end
      object lbHistoryExecMsg: TLabel
        Left = 11
        Top = 449
        Width = 176
        Height = 13
        Caption = #1048#1089#1090#1086#1088#1080#1103'. '#1055#1088#1080#1084#1077#1095#1072#1085#1080#1077' ['#1089#1080#1089#1090#1077#1084#1085#1086#1077']'
      end
      object lbMPhone: TLabel
        Left = 392
        Top = 153
        Width = 62
        Height = 13
        Caption = #1058#1077#1083'. '#1089#1080#1089#1090'.'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object edOrderShipping: TEdit
        Left = 8
        Top = 23
        Width = 245
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        Ctl3D = True
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 0
        OnChange = aValueChangeExecute
        OnDblClick = edOrderShippingDblClick
      end
      object btnSlOrderShipping: TButton
        Left = 235
        Top = 24
        Width = 17
        Height = 19
        Action = aSlOrderShipping
        TabOrder = 1
      end
      object edOrderPayment: TEdit
        Left = 263
        Top = 23
        Width = 250
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        Ctl3D = True
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 2
        OnChange = aValueChangeExecute
        OnDblClick = edOrderPaymentDblClick
      end
      object btnSlOrderPayment: TButton
        Left = 495
        Top = 24
        Width = 17
        Height = 19
        Action = aSlOrderPayment
        TabOrder = 3
      end
      object edApteka: TEdit
        Left = 104
        Top = 95
        Width = 313
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = clSkyBlue
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
      end
      object edNOrderAmountCOD: TEdit
        Left = 485
        Top = 57
        Width = 80
        Height = 21
        BevelKind = bkFlat
        BiDiMode = bdRightToLeft
        BorderStyle = bsNone
        Ctl3D = True
        ParentBiDiMode = False
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 5
        OnChange = aValueChangeExecute
        OnDblClick = aCalcCODExecute
      end
      object btnCalcCOD: TButton
        Left = 547
        Top = 58
        Width = 17
        Height = 19
        Action = aCalcCOD
        TabOrder = 6
      end
      object edNCoolantSum: TEdit
        Left = 672
        Top = 57
        Width = 72
        Height = 21
        BevelKind = bkFlat
        BiDiMode = bdRightToLeft
        BorderStyle = bsNone
        Ctl3D = True
        ParentBiDiMode = False
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 7
        OnChange = aValueChangeExecute
      end
      object edSOrderComment: TMemo
        Left = 9
        Top = 337
        Width = 728
        Height = 43
        BevelKind = bkFlat
        BorderStyle = bsNone
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 8
      end
      object edSOrderShipCity: TEdit
        Left = 496
        Top = 95
        Width = 248
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = clSkyBlue
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 9
      end
      object edOrderShipStreet: TEdit
        Left = 48
        Top = 121
        Width = 697
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = clSkyBlue
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 10
      end
      object edShipName: TEdit
        Left = 48
        Top = 149
        Width = 177
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = clSkyBlue
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 11
      end
      object edOrderPhone: TEdit
        Left = 258
        Top = 149
        Width = 131
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = clSkyBlue
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 12
      end
      object edOrderEmail: TEdit
        Left = 584
        Top = 149
        Width = 160
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = clSkyBlue
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 13
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 178
        Width = 737
        Height = 135
        Caption = #1055#1040#1056#1040#1052#1045#1058#1056#1067' '#1044#1054#1057#1058#1040#1042#1050#1048
        Color = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 14
        object lblSNPOST_StateName: TLabel
          Left = 358
          Top = 18
          Width = 162
          Height = 13
          Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1101#1082#1089#1087#1088#1077#1089#1089'-'#1085#1072#1082#1083#1072#1076#1085#1086#1081
        end
        object lblSDispatchDeclaration: TLabel
          Left = 13
          Top = 18
          Width = 124
          Height = 13
          Caption = #1044#1077#1082#1083#1072#1088#1072#1094#1080#1103' '#1054#1058#1055#1056#1040#1042#1050#1040
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblSDeclarationReturn: TLabel
          Left = 188
          Top = 18
          Width = 116
          Height = 13
          Caption = #1044#1077#1082#1083#1072#1088#1072#1094#1080#1103' '#1042#1054#1047#1042#1056#1040#1058
        end
        object lblSAssemblingDate: TLabel
          Left = 8
          Top = 72
          Width = 124
          Height = 13
          Caption = #1057#1086#1075#1083#1072#1089'. '#1074#1088#1077#1084#1103' '#1076#1086#1089#1090#1072#1074#1082#1080
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblSNameDriver: TLabel
          Left = 83
          Top = 97
          Width = 48
          Height = 13
          Caption = #1042#1086#1076#1080#1090#1077#1083#1100
        end
        object lblSNote: TLabel
          Left = 358
          Top = 57
          Width = 122
          Height = 13
          Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077' '#1082' '#1076#1086#1089#1090#1072#1074#1082#1077
        end
        object edSNPOST_StateName: TEdit
          Left = 357
          Top = 36
          Width = 373
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 0
        end
        object edSDispatchDeclaration: TEdit
          Left = 12
          Top = 36
          Width = 156
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 30
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          OnChange = edSDispatchDeclarationChange
        end
        object edSDeclarationReturn: TEdit
          Left = 187
          Top = 36
          Width = 156
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          MaxLength = 30
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 2
          OnChange = edSDispatchDeclarationChange
        end
        object edSAssemblingDate: TEdit
          Left = 143
          Top = 71
          Width = 202
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
          OnChange = aValueChangeExecute
          OnDblClick = edSAssemblingDateDblClick
        end
        object btnSetAssemblingDate: TButton
          Left = 327
          Top = 72
          Width = 17
          Height = 16
          Action = aSetAssemblingDate
          TabOrder = 4
        end
        object edSNameDriver: TEdit
          Left = 143
          Top = 96
          Width = 202
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
          OnChange = aValueChangeExecute
          OnDblClick = edSNameDriverDblClick
        end
        object btnSlNameDriver: TButton
          Left = 327
          Top = 97
          Width = 17
          Height = 16
          Action = aSlNameDriver
          TabOrder = 6
        end
        object edSNote: TMemo
          Left = 357
          Top = 73
          Width = 373
          Height = 53
          BevelKind = bkFlat
          BorderStyle = bsNone
          MaxLength = 500
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 7
          OnChange = edSNoteChange
        end
      end
      object edSStatusName: TEdit
        Left = 527
        Top = 23
        Width = 218
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        Ctl3D = True
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 15
        OnChange = aValueChangeExecute
        OnDblClick = edSStatusNameDblClick
      end
      object btnSlOrderStatus: TButton
        Left = 727
        Top = 24
        Width = 17
        Height = 19
        Action = aSlOrderStatus
        TabOrder = 16
      end
      object edNOrderAmountShipping: TEdit
        Left = 248
        Top = 57
        Width = 89
        Height = 21
        Anchors = [akRight]
        AutoSize = False
        BevelKind = bkFlat
        BiDiMode = bdRightToLeft
        BorderStyle = bsNone
        Ctl3D = True
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 17
        OnChange = aValueChangeExecute
      end
      object edOrderAmount: TEdit
        Left = 48
        Top = 57
        Width = 89
        Height = 21
        BevelKind = bkFlat
        BiDiMode = bdRightToLeft
        BorderStyle = bsNone
        Ctl3D = True
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 18
      end
      object edHistoryComments: TMemo
        Left = 9
        Top = 402
        Width = 728
        Height = 43
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = clBtnFace
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 19
      end
      object edHistoryExecMsg: TMemo
        Left = 9
        Top = 466
        Width = 728
        Height = 43
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = clBtnFace
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 20
      end
      object edMPhone: TEdit
        Left = 455
        Top = 149
        Width = 90
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = clSkyBlue
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 21
      end
    end
    object TabSheet4: TTabSheet
      Caption = #1044#1054#1055#1054#1051#1053#1048#1058'.'
      ImageIndex = 3
      object lblSCreateDate: TLabel
        Left = 526
        Top = 345
        Width = 77
        Height = 13
        Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
      end
      object lblSCloseDate: TLabel
        Left = 525
        Top = 366
        Width = 78
        Height = 13
        Caption = #1044#1072#1090#1072' '#1079#1072#1082#1088#1099#1090#1080#1103
      end
      object lblUser: TLabel
        Left = 15
        Top = 364
        Width = 73
        Height = 13
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
      end
      object grpExecCourier: TGroupBox
        Left = 8
        Top = 8
        Width = 729
        Height = 289
        Align = alCustom
        Caption = #1061#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080' '#1079#1072#1082#1072#1079#1072
        TabOrder = 0
        object lblSSignBell: TLabel
          Left = 47
          Top = 22
          Width = 83
          Height = 13
          Caption = #1055#1088#1080#1079#1085#1072#1082' '#1079#1074#1086#1085#1082#1072
        end
        object lblSSMSDate: TLabel
          Left = 65
          Top = 169
          Width = 65
          Height = 13
          Caption = #1052#1072#1088#1082#1077#1088' '#1057#1052#1057
        end
        object lblSPayDate: TLabel
          Left = 45
          Top = 190
          Width = 85
          Height = 13
          Caption = #1052#1072#1088#1082#1077#1088' '#1087#1083#1072#1090#1077#1078#1072
        end
        object lblSExport1CDate: TLabel
          Left = 63
          Top = 85
          Width = 67
          Height = 13
          Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' 1'#1057
        end
        object lblSGroupPharmName: TLabel
          Left = 335
          Top = 102
          Width = 52
          Height = 13
          Caption = #1043#1088#1091#1087#1087#1072' '#1058#1058
        end
        object lblSMarkUser: TLabel
          Left = 317
          Top = 127
          Width = 70
          Height = 13
          Caption = #1047#1072#1082#1088#1077#1087#1083#1077#1085' '#1079#1072
        end
        object lblParentsList: TLabel
          Left = 17
          Top = 231
          Width = 113
          Height = 13
          Caption = #1056#1086#1076#1080#1090#1077#1083#1100#1089#1082#1080#1077' '#1079#1072#1082#1072#1079#1099
        end
        object lblSlavesList: TLabel
          Left = 36
          Top = 252
          Width = 94
          Height = 13
          Caption = #1044#1086#1087#1086#1083#1085#1080#1090'. '#1079#1072#1082#1072#1079#1099
        end
        object lblSBlackListDate: TLabel
          Left = 308
          Top = 168
          Width = 79
          Height = 13
          Caption = #1063#1077#1088#1085#1099#1081' '#1089#1087#1080#1089#1086#1082
        end
        object lblSStockDateBegin: TLabel
          Left = 27
          Top = 211
          Width = 103
          Height = 13
          Caption = #1047#1072#1082#1072#1079#1072#1085#1086' '#1085#1072' '#1089#1082#1083#1072#1076#1077
        end
        object lblSPharmAssemblyDate: TLabel
          Left = 312
          Top = 190
          Width = 75
          Height = 13
          Caption = #1057#1086#1073#1088#1072#1085#1086' '#1085#1072' '#1058#1058
        end
        object lblSNPOST_StateDate: TLabel
          Left = 446
          Top = 41
          Width = 148
          Height = 13
          Caption = #1044#1072#1090#1072' '#1091#1089#1090#1072#1085#1086#1074#1082#1080' '#1089#1090#1072#1090#1091#1089#1072' '#1058#1058#1053
        end
        object Label1: TLabel
          Left = 445
          Top = 20
          Width = 162
          Height = 13
          Caption = #1044#1072#1090#1072' '#1091#1089#1090#1072#1085#1086#1074#1082#1080' '#1089#1090#1072#1090#1091#1089#1072' '#1079#1072#1082#1072#1079#1072
        end
        object Label2: TLabel
          Left = 445
          Top = 63
          Width = 131
          Height = 13
          Caption = #1044#1072#1090#1072' '#1091#1089#1090#1072#1085#1086#1074#1082#1080' '#1074#1086#1076#1080#1090#1077#1083#1103
        end
        object lblSBallDAte: TLabel
          Left = 52
          Top = 46
          Width = 78
          Height = 13
          Caption = #1052#1072#1088#1082#1077#1088' '#1079#1074#1086#1085#1082#1072
        end
        object edSSignBell: TEdit
          Left = 133
          Top = 16
          Width = 39
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 0
        end
        object edSSMSDate: TEdit
          Left = 133
          Top = 163
          Width = 135
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 2
        end
        object edSPayDate: TEdit
          Left = 133
          Top = 184
          Width = 135
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object edSExport1CDate: TEdit
          Left = 133
          Top = 79
          Width = 135
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object edSGroupPharmName: TEdit
          Left = 391
          Top = 96
          Width = 320
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
          OnChange = aValueChangeExecute
          OnDblClick = edSGroupPharmNameDblClick
        end
        object edSDriverDate: TEdit
          Left = 614
          Top = 60
          Width = 96
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
          OnChange = aValueChangeExecute
        end
        object edSMarkUser: TEdit
          Left = 392
          Top = 121
          Width = 219
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 8
        end
        object edSMarkDate: TEdit
          Left = 616
          Top = 121
          Width = 94
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 9
        end
        object btnSlGroupPharm: TButton
          Left = 693
          Top = 98
          Width = 17
          Height = 16
          Action = aSlGroupPharm
          TabOrder = 6
        end
        object edParentsList: TEdit
          Left = 133
          Top = 226
          Width = 568
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 12
        end
        object edSlavesList: TEdit
          Left = 133
          Top = 247
          Width = 568
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 13
        end
        object edSBlackListDate: TEdit
          Left = 391
          Top = 163
          Width = 135
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 10
        end
        object edSStockDateBegin: TEdit
          Left = 133
          Top = 205
          Width = 135
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 4
        end
        object edSPharmAssemblyDate: TEdit
          Left = 391
          Top = 184
          Width = 135
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 11
        end
        object edSOrderStatusDate: TEdit
          Left = 614
          Top = 15
          Width = 96
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 14
          OnChange = aValueChangeExecute
        end
        object edSNPOST_StateDate: TEdit
          Left = 614
          Top = 38
          Width = 96
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 15
        end
        object edSBallDAte: TEdit
          Left = 133
          Top = 40
          Width = 135
          Height = 19
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 16
        end
      end
      object edSCreateDate: TEdit
        Left = 606
        Top = 341
        Width = 130
        Height = 19
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = clInactiveBorder
        Ctl3D = True
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 1
      end
      object edSCloseDate: TEdit
        Left = 606
        Top = 362
        Width = 130
        Height = 19
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = clInactiveBorder
        Ctl3D = True
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 2
      end
      object edUser: TEdit
        Left = 93
        Top = 362
        Width = 284
        Height = 19
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = clInactiveBorder
        Ctl3D = True
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 3
      end
    end
  end
  object PanelHeader: TPanel
    Left = 0
    Top = 0
    Width = 776
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      776
      35)
    object lblSOrderID: TLabel
      Left = 10
      Top = 8
      Width = 38
      Height = 16
      Caption = #1047#1072#1082#1072#1079
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 168
      Top = 8
      Width = 31
      Height = 16
      Caption = #1057#1072#1081#1090
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSOrderDt: TLabel
      Left = 345
      Top = 8
      Width = 76
      Height = 16
      Caption = #1044#1072#1090#1072'/'#1074#1088#1077#1084#1103
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 570
      Top = 8
      Width = 76
      Height = 16
      Caption = #1054#1073#1097'. '#1089#1091#1084#1084#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edSOrderID: TEdit
      Left = 53
      Top = 6
      Width = 102
      Height = 21
      Anchors = []
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      Color = clInactiveBorder
      Ctl3D = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 204
      Top = 6
      Width = 131
      Height = 21
      Anchors = []
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      Color = clInactiveBorder
      Ctl3D = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object edSOrderDt: TEdit
      Left = 429
      Top = 6
      Width = 130
      Height = 21
      Anchors = [akRight]
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      Color = clInactiveBorder
      Ctl3D = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object edTotalSum: TEdit
      Left = 656
      Top = 8
      Width = 105
      Height = 21
      BevelKind = bkFlat
      BiDiMode = bdRightToLeft
      BorderStyle = bsNone
      Color = clInactiveBorder
      Ctl3D = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
  end
  object PanelState: TPanel
    Left = 0
    Top = 35
    Width = 776
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object lbState: TLabel
      Left = 0
      Top = 0
      Width = 776
      Height = 25
      Align = alClient
      Alignment = taCenter
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Action: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 816
    Top = 5
    object aExit: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
    object aSave: TAction
      Category = 'Control'
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ImageIndex = 7
      ShortCut = 13
      OnExecute = aSaveExecute
    end
    object aSlOrderPayment: TAction
      Category = 'SetFileds'
      Caption = #8230
      OnExecute = aSlOrderPaymentExecute
    end
    object aSetAssemblingDate: TAction
      Category = 'SetFileds'
      Caption = #8230
      OnExecute = aSetAssemblingDateExecute
    end
    object aSlOrderStatus: TAction
      Category = 'SetFileds'
      Caption = #8230
      OnExecute = aSlOrderStatusExecute
    end
    object aSlGroupPharm: TAction
      Category = 'SetFileds'
      Caption = #8230
      OnExecute = aSlGroupPharmExecute
    end
    object aSlNameDriver: TAction
      Category = 'SetFileds'
      Caption = #8230
      OnExecute = aSlNameDriverExecute
    end
    object aValueChange: TAction
      Category = 'SetFileds'
      Caption = 'aValueChange'
      OnExecute = aValueChangeExecute
    end
    object aUndo: TAction
      Category = 'Control'
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      ImageIndex = 13
      OnExecute = aUndoExecute
    end
    object aSlOrderShipping: TAction
      Category = 'SetFileds'
      Caption = #8230
      OnExecute = aSlOrderShippingExecute
    end
    object aCalcCOD: TAction
      Category = 'SetFileds'
      Caption = #8230
      Hint = #1056#1072#1089#1095#1080#1090#1072#1090#1100' '#1085#1072#1083#1086#1078#1077#1085#1085#1099#1081' '#1087#1083#1072#1090#1077#1078
      OnExecute = aCalcCODExecute
    end
  end
  object spHeaderUpdate: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jso_HeaderUpdate;1'
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
        Name = '@Order'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@Payment'
        Attributes = [paNullable]
        DataType = ftString
        Size = 160
        Value = ''
      end
      item
        Name = '@SAssemblingDate'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end
      item
        Name = '@ExpressInvoice'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end
      item
        Name = '@OrderStatus'
        Attributes = [paNullable]
        DataType = ftString
        Size = 160
        Value = ''
      end
      item
        Name = '@GroupPharm'
        Attributes = [paNullable]
        DataType = ftString
        Size = 160
        Value = ''
      end
      item
        Name = '@NameDriver'
        Attributes = [paNullable]
        DataType = ftString
        Size = 160
        Value = ''
      end
      item
        Name = '@Note'
        Attributes = [paNullable]
        DataType = ftString
        Size = 500
        Value = ''
      end
      item
        Name = '@SErr'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 400
        Value = ''
      end
      item
        Name = '@Shipping'
        Attributes = [paNullable]
        DataType = ftString
        Size = 160
        Value = ''
      end
      item
        Name = '@COD'
        Attributes = [paNullable]
        DataType = ftBCD
        NumericScale = 2
        Precision = 17
        Value = 0c
      end
      item
        Name = '@Amount'
        Attributes = [paNullable]
        DataType = ftBCD
        NumericScale = 2
        Precision = 17
        Value = 0c
      end
      item
        Name = '@AmountShipping'
        Attributes = [paNullable]
        DataType = ftBCD
        NumericScale = 2
        Precision = 17
        Value = 0c
      end
      item
        Name = '@CoolantSum'
        Attributes = [paNullable]
        DataType = ftBCD
        NumericScale = 2
        Precision = 17
        Value = 0c
      end
      item
        Name = '@DeclarationReturn'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end>
    Left = 768
    Top = 5
  end
end
