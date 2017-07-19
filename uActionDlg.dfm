object ActionDlg: TActionDlg
  Left = 351
  Top = 181
  BorderStyle = bsDialog
  Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1076#1077#1081#1089#1090#1074#1080#1077
  ClientHeight = 630
  ClientWidth = 477
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelOrderItem: TPanel
    Left = 0
    Top = 0
    Width = 477
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PanelOrderItem'
    TabOrder = 4
    object pnlTop_Order: TPanel
      Left = 0
      Top = 0
      Width = 131
      Height = 25
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object pnlTop_Price: TPanel
      Left = 131
      Top = 0
      Width = 131
      Height = 25
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object pnlTop_Client: TPanel
      Left = 262
      Top = 0
      Width = 215
      Height = 25
      Align = alClient
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object PanelSMS: TPanel
    Left = 0
    Top = 315
    Width = 477
    Height = 76
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object cbSendMessage: TCheckBox
      Left = 14
      Top = 5
      Width = 123
      Height = 17
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1057#1052#1057
      TabOrder = 0
    end
    object edSMSText: TMemo
      Left = 14
      Top = 24
      Width = 451
      Height = 46
      TabOrder = 2
    end
    object cbSendEmail: TCheckBox
      Left = 126
      Top = 5
      Width = 131
      Height = 17
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' Email'
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 25
    Width = 477
    Height = 290
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 17
      Top = 20
      Width = 103
      Height = 23
      Caption = #1048#1057#1061'. '#1057#1058#1040#1058#1059#1057
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial Narrow'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 64
      Top = 54
      Width = 60
      Height = 13
      Caption = #1044#1045#1049#1057#1058#1042#1048#1045
    end
    object Label3: TLabel
      Left = 67
      Top = 142
      Width = 56
      Height = 13
      Caption = #1054#1089#1085#1086#1074#1072#1085#1080#1077
    end
    object Label5: TLabel
      Left = 71
      Top = 170
      Width = 52
      Height = 13
      Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
    end
    object Label4: TLabel
      Left = 19
      Top = 257
      Width = 101
      Height = 23
      Caption = #1056#1045#1047'. '#1057#1058#1040#1058#1059#1057
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial Narrow'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 46
      Top = 199
      Width = 77
      Height = 52
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081' '#1074' '#1080#1089#1090#1086#1088#1080#1102
      WordWrap = True
    end
    object lcSrcStatus: TDBLookupComboBox
      Left = 128
      Top = 17
      Width = 320
      Height = 28
      BevelInner = bvNone
      BevelOuter = bvNone
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial Narrow'
      Font.Style = [fsBold]
      KeyField = 'row_id'
      ListField = 'name'
      ListSource = dsSrcStatus
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object lcSrcBasis: TDBLookupComboBox
      Left = 128
      Top = 144
      Width = 320
      Height = 21
      KeyField = 'row_id'
      ListField = 'name'
      ListSource = dsSrcBasis
      TabOrder = 2
      OnCloseUp = lcSrcBasisCloseUp
    end
    object lcResBasis: TDBLookupComboBox
      Left = 128
      Top = 173
      Width = 320
      Height = 21
      KeyField = 'row_id'
      ListField = 'name'
      ListSource = dsResBasis
      TabOrder = 3
      OnCloseUp = lcResBasisCloseUp
    end
    object lcResStatus: TDBLookupComboBox
      Left = 128
      Top = 254
      Width = 320
      Height = 28
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial Narrow'
      Font.Style = [fsBold]
      KeyField = 'row_id'
      ListField = 'name'
      ListSource = dsResStatus
      ParentFont = False
      TabOrder = 5
      OnCloseUp = lcResStatusCloseUp
    end
    object edComments: TMemo
      Left = 128
      Top = 200
      Width = 320
      Height = 47
      TabOrder = 4
    end
    object lbAction: TDBLookupListBox
      Left = 128
      Top = 53
      Width = 320
      Height = 82
      KeyField = 'ActionCode'
      ListField = 'Name'
      ListSource = dsAction
      TabOrder = 1
      OnClick = lbActionClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 589
    Width = 477
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      477
      41)
    object LabelAction: TLabel
      Left = 8
      Top = 8
      Width = 289
      Height = 13
      AutoSize = False
      Caption = 'LabelAction'
    end
    object OKBtn: TButton
      Left = 317
      Top = 7
      Width = 70
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = OKBtnClick
    end
    object CancelBtn: TButton
      Left = 393
      Top = 7
      Width = 70
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
    end
  end
  object PanelAddFields: TPanel
    Left = 0
    Top = 391
    Width = 477
    Height = 198
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object lbHistoryComments: TLabel
      Left = 14
      Top = 7
      Width = 119
      Height = 13
      Caption = #1048#1089#1090#1086#1088#1080#1103'. '#1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
    end
    object lblSNote: TLabel
      Left = 14
      Top = 71
      Width = 122
      Height = 13
      Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077' '#1082' '#1076#1086#1089#1090#1072#1074#1082#1077
    end
    object lbHistoryExecMsg: TLabel
      Left = 14
      Top = 134
      Width = 176
      Height = 13
      Caption = #1048#1089#1090#1086#1088#1080#1103'. '#1055#1088#1080#1084#1077#1095#1072#1085#1080#1077' ['#1089#1080#1089#1090#1077#1084#1085#1086#1077']'
    end
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 477
      Height = 3
      Align = alTop
      Shape = bsTopLine
    end
    object edHistoryComments: TMemo
      Left = 14
      Top = 22
      Width = 451
      Height = 43
      BevelKind = bkFlat
      BorderStyle = bsNone
      Color = clBtnFace
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object edSNote: TMemo
      Left = 14
      Top = 87
      Width = 451
      Height = 43
      BevelKind = bkFlat
      BorderStyle = bsNone
      Color = clBtnFace
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object edHistoryExecMsg: TMemo
      Left = 14
      Top = 149
      Width = 451
      Height = 43
      BevelKind = bkFlat
      BorderStyle = bsNone
      Color = clBtnFace
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 2
    end
  end
  object dsResStatus: TDataSource
    Left = 360
    Top = 149
  end
  object dsSrcStatus: TDataSource
    Left = 344
  end
  object dsAction: TDataSource
    Left = 360
    Top = 40
  end
  object dsSrcBasis: TDataSource
    Left = 328
    Top = 56
  end
  object dsResBasis: TDataSource
    Left = 352
    Top = 144
  end
  object ExecTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = ExecTimerTimer
    Left = 96
    Top = 579
  end
end
