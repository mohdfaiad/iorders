object WholeOrderOrTradePointDlg: TWholeOrderOrTradePointDlg
  Left = 309
  Top = 230
  BorderStyle = bsDialog
  Caption = 'Dialog'
  ClientHeight = 136
  ClientWidth = 252
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  DesignSize = (
    252
    136)
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TButton
    Left = 48
    Top = 106
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    Default = True
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 128
    Top = 106
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
  end
  object rbWholeOrder: TRadioButton
    Left = 24
    Top = 16
    Width = 225
    Height = 17
    Caption = #1042#1086' '#1074#1089#1077#1093' '#1072#1087#1090#1077#1082#1072#1093' '#1079#1072#1082#1072#1079#1072
    Checked = True
    TabOrder = 2
    TabStop = True
    OnClick = rbTradePointClick
  end
  object rbTradePoint: TRadioButton
    Left = 24
    Top = 40
    Width = 113
    Height = 17
    Caption = #1042' '#1072#1087#1090#1077#1082#1077
    TabOrder = 3
    OnClick = rbTradePointClick
  end
  object cbTradePoint: TDBLookupComboBox
    Left = 40
    Top = 64
    Width = 201
    Height = 21
    KeyField = 'id'
    ListField = 'name'
    ListSource = dsTradePoint
    TabOrder = 4
  end
  object dsTradePoint: TDataSource
    DataSet = qrTradePoint
    Left = 8
    Top = 104
  end
  object qrTradePoint: TADOQuery
    Connection = Form1.ADOC_STAT
    Parameters = <
      item
        Name = 'OrderId'
        DataType = ftInteger
        Size = 7
        Value = Null
      end>
    SQL.Strings = (
      'select NAptekaId as id, t.names as name'
      
        '  from WorkWith_Gamma.dbo.fDS_jso_OrdersAptekaList(:OrderId, nul' +
        'l, 0) s join'
      
        '       WorkWith_Gamma.dbo.ava_apteks as t with (nolock) on s.NAp' +
        'tekaId = t.ID_GAMMA'
      '')
    Left = 8
    Top = 56
  end
end
