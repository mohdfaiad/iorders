object SprItemDlg: TSprItemDlg
  Left = 325
  Top = 123
  BorderStyle = bsDialog
  Caption = 'Dialog'
  ClientHeight = 214
  ClientWidth = 313
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnDestroy = FormDestroy
  DesignSize = (
    313
    214)
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TButton
    Left = 79
    Top = 180
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 159
    Top = 180
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
  end
end
