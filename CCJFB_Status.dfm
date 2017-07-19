object frmCCJFB_Status: TfrmCCJFB_Status
  Left = 19
  Top = 477
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1054#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1089#1090#1072#1090#1091#1089' '#1079#1072#1082#1072#1079#1072
  ClientHeight = 424
  ClientWidth = 619
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
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 619
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlTop'
    TabOrder = 0
    object pnlTop_Order: TPanel
      Left = 0
      Top = 0
      Width = 131
      Height = 21
      Align = alLeft
      BevelInner = bvSpace
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object pnlTop_Client: TPanel
      Left = 131
      Top = 0
      Width = 131
      Height = 21
      Align = alLeft
      BevelInner = bvSpace
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object pnlTop_PhoneEMail: TPanel
      Left = 262
      Top = 0
      Width = 357
      Height = 21
      Align = alClient
      Alignment = taLeftJustify
      BevelInner = bvSpace
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
  end
  object stbarMain: TStatusBar
    Left = 0
    Top = 405
    Width = 619
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object pgcMain: TPageControl
    Left = 0
    Top = 21
    Width = 619
    Height = 384
    ActivePage = tabStatus
    Align = alClient
    TabOrder = 2
    object tabStatus: TTabSheet
      Caption = #1057#1090#1072#1090#1091#1089
      object pnlOrderStatus: TPanel
        Left = 0
        Top = 0
        Width = 611
        Height = 47
        Align = alTop
        BevelInner = bvLowered
        BevelOuter = bvSpace
        TabOrder = 0
        object edOrderStatus: TEdit
          Left = 16
          Top = 13
          Width = 585
          Height = 21
          ReadOnly = True
          TabOrder = 0
          OnChange = edOrderStatusChange
          OnDblClick = aStatus_SlOrderStatusExecute
        end
        object btnSlDrivers: TButton
          Left = 580
          Top = 15
          Width = 19
          Height = 17
          Action = aStatus_SlOrderStatus
          TabOrder = 1
        end
      end
      object pnlCheckNote: TPanel
        Left = 0
        Top = 47
        Width = 611
        Height = 21
        Align = alTop
        BevelOuter = bvNone
        Caption = 'pnlCheckNote'
        TabOrder = 1
        object pnlCheckNote_Count: TPanel
          Left = 524
          Top = 0
          Width = 87
          Height = 21
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
        end
        object pnlCheckNote_Status: TPanel
          Left = 0
          Top = 0
          Width = 524
          Height = 21
          Align = alClient
          Alignment = taLeftJustify
          BevelOuter = bvNone
          Caption = '  '#1055#1088#1080#1084#1077#1095#1072#1085#1080#1077':'
          TabOrder = 1
        end
      end
      object pnlNote: TPanel
        Left = 0
        Top = 68
        Width = 611
        Height = 262
        Align = alClient
        BevelInner = bvLowered
        BevelOuter = bvSpace
        BorderWidth = 1
        TabOrder = 2
        object mNote: TMemo
          Left = 3
          Top = 3
          Width = 605
          Height = 256
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 500
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
          OnChange = mNoteChange
        end
      end
      object pnlToolStatus: TPanel
        Left = 0
        Top = 330
        Width = 611
        Height = 26
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'pnlToolStatus'
        TabOrder = 3
        object pnlToolStatus_Bar: TPanel
          Left = 451
          Top = 0
          Width = 160
          Height = 26
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
          object tlbarControl: TToolBar
            Left = 0
            Top = 0
            Width = 160
            Height = 26
            Align = alClient
            AutoSize = True
            BorderWidth = 1
            ButtonWidth = 83
            EdgeBorders = []
            Flat = True
            Images = FCCenterJournalNetZkz.imgMain
            List = True
            ShowCaptions = True
            TabOrder = 0
            object tlbtnStatusOk: TToolButton
              Left = 0
              Top = 0
              Action = aStatus_Ok
              AutoSize = True
            end
            object tlbtnStatusExit: TToolButton
              Left = 87
              Top = 0
              Action = aMain_Exit
              AutoSize = True
            end
          end
        end
        object pnlToolStatus_Show: TPanel
          Left = 0
          Top = 0
          Width = 451
          Height = 26
          Align = alClient
          Alignment = taLeftJustify
          BevelOuter = bvNone
          TabOrder = 1
        end
      end
    end
    object tabSendEmail: TTabSheet
      Caption = #1053#1072#1087#1080#1089#1072#1090#1100' '#1087#1080#1089#1100#1084#1086
      ImageIndex = 1
    end
    object tabMsgInfo: TTabSheet
      Caption = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      ImageIndex = 2
      object pnlToolInfoMsg: TPanel
        Left = 0
        Top = 330
        Width = 611
        Height = 26
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'pnlToolStatus'
        TabOrder = 0
        object pnlToolInfoMsg_Bar: TPanel
          Left = 541
          Top = 0
          Width = 70
          Height = 26
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
          object ToolBar1: TToolBar
            Left = 0
            Top = 0
            Width = 70
            Height = 26
            Align = alClient
            AutoSize = True
            BorderWidth = 1
            ButtonWidth = 59
            EdgeBorders = []
            Flat = True
            Images = FCCenterJournalNetZkz.imgMain
            List = True
            ShowCaptions = True
            TabOrder = 0
            object tlbtnInfoMsgExit: TToolButton
              Left = 0
              Top = 0
              Action = aMain_Exit
              AutoSize = True
            end
          end
        end
        object pnlToolInfoMsg_Show: TPanel
          Left = 0
          Top = 0
          Width = 541
          Height = 26
          Align = alClient
          Alignment = taLeftJustify
          BevelOuter = bvNone
          TabOrder = 1
        end
      end
      object pnlCheckInfoMsf: TPanel
        Left = 0
        Top = 0
        Width = 611
        Height = 21
        Align = alTop
        BevelOuter = bvNone
        Caption = 'pnlCheckNote'
        TabOrder = 1
        object pnlCheckInfoMsf_Count: TPanel
          Left = 524
          Top = 0
          Width = 87
          Height = 21
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
        end
        object pnlCheckInfoMsf_Show: TPanel
          Left = 0
          Top = 0
          Width = 524
          Height = 21
          Align = alClient
          Alignment = taLeftJustify
          BevelOuter = bvNone
          TabOrder = 1
        end
      end
      object pnlContentsMsg: TPanel
        Left = 0
        Top = 21
        Width = 611
        Height = 309
        Align = alClient
        BevelInner = bvLowered
        BevelOuter = bvSpace
        BorderWidth = 1
        TabOrder = 2
        object mContents: TMemo
          Left = 3
          Top = 3
          Width = 605
          Height = 303
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 8000
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
  end
  object aMain: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 80
    Top = 49
    object aStatus_Ok: TAction
      Category = 'Status'
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      ImageIndex = 36
      OnExecute = aStatus_OkExecute
    end
    object aMain_Exit: TAction
      Category = 'Main'
      Caption = #1042#1099#1081#1090#1080
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aMain_ExitExecute
    end
    object aStatus_SlOrderStatus: TAction
      Category = 'Status'
      Caption = #8230
      OnExecute = aStatus_SlOrderStatusExecute
    end
  end
  object spSetStatus: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_jfb_SetStatus;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@PRN'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@RN_HIST'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@USER'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@Status'
        Attributes = [paNullable]
        DataType = ftString
        Size = 240
        Value = ''
      end
      item
        Name = '@SNOTE'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
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
    Left = 145
    Top = 48
  end
end
