object sprEditDlg: TsprEditDlg
  Left = 687
  Top = 195
  Width = 654
  Height = 675
  Caption = 'sprEditDlg'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    638
    637)
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TButton
    Left = 321
    Top = 23
    Width = 70
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 397
    Top = 23
    Width = 70
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
  end
  object DBEdit1: TDBEdit
    Left = 136
    Top = 176
    Width = 121
    Height = 21
    DataField = 'ID'
    DataSource = DataSource1
    TabOrder = 2
  end
  object DBNavigator1: TDBNavigator
    Left = 56
    Top = 208
    Width = 240
    Height = 25
    DataSource = DataSource1
    TabOrder = 3
  end
  object DBGrid1: TDBGrid
    Left = 32
    Top = 264
    Width = 585
    Height = 321
    DataSource = DataSource1
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 88
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 336
    Top = 200
  end
end
