object Form3: TForm3
  Left = 360
  Top = 173
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Form3'
  ClientHeight = 164
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Timer1: TTimer
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 80
    Top = 56
  end
end
