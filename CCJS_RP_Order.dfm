object frmCCJS_RP_Order: TfrmCCJS_RP_Order
  Left = 10
  Top = 166
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1047#1072#1082#1072#1079' '#1082#1083#1080#1077#1085#1090#1072
  ClientHeight = 237
  ClientWidth = 467
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
    Width = 467
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
      Width = 336
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
      TabOrder = 1
    end
  end
  object pnlControl: TPanel
    Left = 0
    Top = 215
    Width = 467
    Height = 22
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlControl'
    TabOrder = 1
    object pnlControl_Tool: TPanel
      Left = 277
      Top = 0
      Width = 190
      Height = 22
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object tollBar: TToolBar
        Left = 0
        Top = 0
        Width = 190
        Height = 22
        Align = alClient
        AutoSize = True
        ButtonWidth = 99
        DisabledImages = FCCenterJournalNetZkz.imgMainDisable
        EdgeBorders = []
        EdgeInner = esNone
        EdgeOuter = esNone
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tlbtnExcel: TToolButton
          Left = 0
          Top = 0
          Action = aExcel
          AutoSize = True
        end
        object tlbtnClose: TToolButton
          Left = 103
          Top = 0
          Action = aClose
          AutoSize = True
        end
      end
    end
    object pnlControl_Show: TPanel
      Left = 0
      Top = 0
      Width = 277
      Height = 22
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlPage: TPanel
    Left = 0
    Top = 21
    Width = 467
    Height = 194
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlPage'
    TabOrder = 2
    object pageControl: TPageControl
      Left = 0
      Top = 0
      Width = 467
      Height = 194
      ActivePage = tabParm
      Align = alClient
      TabOrder = 0
      object tabParm: TTabSheet
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
        object pnlParm_OrderLink: TPanel
          Left = 0
          Top = 38
          Width = 459
          Height = 128
          Align = alBottom
          BevelOuter = bvNone
          Caption = 'pnlParm_OrderLink'
          TabOrder = 0
          object grbxOrderLink: TGroupBox
            Left = 0
            Top = 0
            Width = 459
            Height = 128
            Align = alClient
            Caption = ' '#1057#1074#1103#1079#1072#1085#1085#1099#1077' '#1079#1072#1082#1072#1079#1099' '
            TabOrder = 0
            object pnlParm_OrderLink_Control: TPanel
              Left = 291
              Top = 15
              Width = 166
              Height = 111
              Align = alRight
              Alignment = taLeftJustify
              BevelOuter = bvNone
              BorderWidth = 3
              TabOrder = 0
              object tlbrOrderLink: TToolBar
                Left = 3
                Top = 3
                Width = 160
                Height = 44
                AutoSize = True
                ButtonWidth = 155
                Caption = 'tlbrOrderLink'
                DisabledImages = FCCenterJournalNetZkz.imgMainDisable
                EdgeBorders = []
                EdgeInner = esNone
                EdgeOuter = esNone
                Flat = True
                Images = FCCenterJournalNetZkz.imgMain
                List = True
                ShowCaptions = True
                TabOrder = 0
                Transparent = True
                object ToolButton1: TToolButton
                  Left = 0
                  Top = 0
                  Action = aOrderLinkList_All
                  AutoSize = True
                  Caption = #1044#1083#1103' '#1074#1089#1077#1093' '#1079#1072#1082#1072#1079#1086#1074'            '
                  Wrap = True
                end
                object ToolButton2: TToolButton
                  Left = 0
                  Top = 22
                  Action = aOrderLinkList_ClearSelect
                  AutoSize = True
                end
              end
              object pnlParm_OrderLink_Control_Show: TPanel
                Left = 3
                Top = 67
                Width = 160
                Height = 41
                Align = alBottom
                BevelOuter = bvNone
                TabOrder = 1
              end
            end
            object pnlPharmGroup_List: TPanel
              Left = 2
              Top = 15
              Width = 289
              Height = 111
              Align = alClient
              BevelOuter = bvNone
              BorderWidth = 3
              Caption = 'pnlPharmGroup_List'
              TabOrder = 1
              object chListBoxOrdersLink: TCheckListBox
                Left = 3
                Top = 3
                Width = 283
                Height = 105
                OnClickCheck = chListBoxOrdersLinkClickCheck
                Align = alClient
                BevelInner = bvNone
                BevelKind = bkFlat
                BorderStyle = bsNone
                ItemHeight = 13
                TabOrder = 0
              end
            end
          end
        end
        object pnlParm_Main: TPanel
          Left = 0
          Top = 0
          Width = 459
          Height = 38
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object chbxOutAddFields: TCheckBox
            Left = 13
            Top = 10
            Width = 209
            Height = 17
            Caption = #1074#1099#1074#1086#1076#1080#1090#1100' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1087#1086#1083#1103
            TabOrder = 0
          end
          object chbxOutAsSinglOrder: TCheckBox
            Left = 215
            Top = 10
            Width = 170
            Height = 17
            Caption = #1087#1077#1095#1072#1090#1072#1090#1100' '#1082#1072#1082' '#1086#1076#1080#1085' '#1079#1072#1082#1072#1079
            TabOrder = 1
            OnClick = chbxOutAsSinglOrderClick
          end
        end
      end
    end
  end
  object actionList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 30
    Top = 115
    object aExcel: TAction
      Category = 'Control'
      Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 111
      OnExecute = aExcelExecute
    end
    object aClose: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aCloseExecute
    end
    object aOrderLinkList_All: TAction
      Category = 'OrderLinkList'
      AutoCheck = True
      Caption = #1044#1083#1103' '#1074#1089#1077#1093' '#1079#1072#1082#1072#1079#1086#1074
      ImageIndex = 352
      OnExecute = aOrderLinkList_AllExecute
    end
    object aOrderLinkList_ClearSelect: TAction
      Category = 'OrderLinkList'
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1074#1099#1073#1086#1088' '#1079#1072#1082#1072#1079#1086#1074
      ImageIndex = 334
      OnExecute = aOrderLinkList_ClearSelectExecute
    end
    object aExcel_LinkList: TAction
      Category = 'Control'
      Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 111
      OnExecute = aExcel_LinkListExecute
    end
    object aExcel_LinkList_OutAsSinglOrder: TAction
      Category = 'Control'
      Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 111
      OnExecute = aExcel_LinkList_OutAsSinglOrderExecute
    end
  end
  object spRP_Zakaz: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_RP_Zakaz;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@OrderID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end>
    Left = 94
    Top = 115
  end
end
