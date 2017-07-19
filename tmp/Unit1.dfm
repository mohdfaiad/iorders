object MainForm: TMainForm
  Left = 486
  Top = 442
  Width = 737
  Height = 414
  Caption = 'MainForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ShowForm2Button: TButton
    Left = 32
    Top = 88
    Width = 139
    Height = 25
    Caption = 'ShowForm2Button'
    TabOrder = 0
    OnClick = ShowForm2ButtonClick
  end
  object ShowForm2ButtonModal: TButton
    Left = 224
    Top = 88
    Width = 225
    Height = 25
    Caption = 'ShowForm2ButtonModal'
    TabOrder = 1
    OnClick = ShowForm2ModalButtonClick
  end
end
