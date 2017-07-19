object frmCCJS_RP_StateOpenOrder: TfrmCCJS_RP_StateOpenOrder
  Left = 35
  Top = 495
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1080#1089#1087#1086#1083#1085#1077#1085#1080#1103' '#1080#1085#1090#1077#1088#1085#1077#1090' '#1079#1072#1082#1072#1079#1086#1074
  ClientHeight = 378
  ClientWidth = 419
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
  object pnlPage: TPanel
    Left = 0
    Top = 0
    Width = 419
    Height = 356
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlPage'
    TabOrder = 0
    object pageControl: TPageControl
      Left = 0
      Top = 0
      Width = 419
      Height = 356
      ActivePage = tabParm
      Align = alClient
      TabOrder = 0
      object tabParm: TTabSheet
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
        object grpbxPeriod: TGroupBox
          Left = 0
          Top = 28
          Width = 411
          Height = 45
          Align = alTop
          Caption = ' '#1048#1085#1090#1077#1088#1085#1077#1090' '#1079#1072#1082#1072#1079#1099' '#1079#1072' '#1087#1077#1088#1080#1086#1076' '
          TabOrder = 1
          object Label1: TLabel
            Left = 7
            Top = 25
            Width = 6
            Height = 13
            Caption = #1089
          end
          object Label2: TLabel
            Left = 118
            Top = 25
            Width = 12
            Height = 13
            Caption = #1087#1086
          end
          object dtBegin: TDateTimePicker
            Left = 17
            Top = 18
            Width = 90
            Height = 21
            Date = 41856.717597962960000000
            Time = 41856.717597962960000000
            TabOrder = 0
          end
          object dtEnd: TDateTimePicker
            Left = 133
            Top = 18
            Width = 90
            Height = 21
            Date = 41856.717597962960000000
            Time = 41856.717597962960000000
            TabOrder = 1
          end
        end
        object grpbxLastDateAction: TGroupBox
          Left = 0
          Top = 73
          Width = 411
          Height = 47
          Align = alTop
          Caption = ' '#1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1076#1077#1081#1089#1090#1074#1080#1103' '#1089' '#1079#1072#1082#1072#1079#1086#1084' '
          TabOrder = 2
          object DateLastAction: TDateTimePicker
            Left = 11
            Top = 18
            Width = 90
            Height = 21
            Date = 41856.717597962960000000
            Time = 41856.717597962960000000
            TabOrder = 0
          end
          object TimeLastAction: TDateTimePicker
            Left = 103
            Top = 18
            Width = 75
            Height = 21
            Date = 41856.717597962960000000
            Time = 41856.717597962960000000
            Kind = dtkTime
            TabOrder = 1
          end
        end
        object grpbxStatus: TGroupBox
          Left = 0
          Top = 120
          Width = 411
          Height = 208
          Align = alClient
          Caption = ' '#1057#1090#1072#1090#1091#1089#1099' '
          TabOrder = 3
          object lblStatusDateFormation: TLabel
            Left = 8
            Top = 16
            Width = 144
            Height = 13
            Caption = #1044#1072#1090#1072' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1103' '#1079#1072#1082#1072#1079#1072
          end
          object lblStatusDateBell: TLabel
            Left = 9
            Top = 54
            Width = 72
            Height = 13
            Caption = #1042#1088#1077#1084#1103' '#1079#1074#1086#1085#1082#1072
          end
          object lblStatusBeginPicking: TLabel
            Left = 9
            Top = 91
            Width = 183
            Height = 13
            Caption = #1042#1088#1077#1084#1103' '#1089#1073#1086#1088#1072' '#1074#1089#1077#1075#1086' '#1079#1072#1082#1072#1079#1072' ('#1053#1072#1095#1072#1083#1086')'
          end
          object lblStatusEndPicking: TLabel
            Left = 10
            Top = 128
            Width = 201
            Height = 13
            Caption = #1042#1088#1077#1084#1103' '#1089#1073#1086#1088#1072' '#1074#1089#1077#1075#1086' '#1079#1072#1082#1072#1079#1072' ('#1054#1082#1086#1085#1095#1072#1085#1080#1077')'
          end
          object lblStatusReadySend: TLabel
            Left = 10
            Top = 166
            Width = 185
            Height = 13
            Caption = #1042#1088#1077#1084#1103' '#1086#1090#1087#1088#1072#1074#1082#1080' '#1079#1072#1082#1072#1079#1072' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1102
          end
          object edStatusDateFormation: TEdit
            Left = 5
            Top = 31
            Width = 399
            Height = 21
            ReadOnly = True
            TabOrder = 0
            OnDblClick = aSLStatus_DateFormationExecute
          end
          object btnStatusDateFormation: TButton
            Left = 383
            Top = 33
            Width = 19
            Height = 17
            Action = aSLStatus_DateFormation
            TabOrder = 1
          end
          object edStatusDateBell: TEdit
            Left = 5
            Top = 69
            Width = 399
            Height = 21
            ReadOnly = True
            TabOrder = 2
            OnDblClick = aSLStatus_DateBellExecute
          end
          object btnStatusDateBell: TButton
            Left = 384
            Top = 71
            Width = 19
            Height = 17
            Action = aSLStatus_DateBell
            TabOrder = 3
          end
          object edStatusBeginPicking: TEdit
            Left = 5
            Top = 106
            Width = 399
            Height = 21
            ReadOnly = True
            TabOrder = 4
            OnDblClick = aSLStatus_BeginPickingExecute
          end
          object btnStatusBeginPicking: TButton
            Left = 384
            Top = 108
            Width = 19
            Height = 17
            Action = aSLStatus_BeginPicking
            TabOrder = 5
          end
          object edStatusEndPicking: TEdit
            Left = 5
            Top = 143
            Width = 399
            Height = 21
            ReadOnly = True
            TabOrder = 6
            OnDblClick = aSLStatus_EndPickingExecute
          end
          object btnStatusEndPicking: TButton
            Left = 384
            Top = 145
            Width = 19
            Height = 17
            Action = aSLStatus_EndPicking
            TabOrder = 7
          end
          object edStatusReadySend: TEdit
            Left = 5
            Top = 181
            Width = 399
            Height = 21
            ReadOnly = True
            TabOrder = 8
            OnDblClick = aSLStatus_ReadySendExecute
          end
          object btnStatusReadySend: TButton
            Left = 384
            Top = 183
            Width = 19
            Height = 17
            Action = aSLStatus_ReadySend
            TabOrder = 9
          end
        end
        object pnl: TPanel
          Left = 0
          Top = 0
          Width = 411
          Height = 28
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object lblOrderState: TLabel
            Left = 8
            Top = 10
            Width = 54
            Height = 13
            Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077
          end
          object cmbxOrderState: TComboBox
            Left = 65
            Top = 3
            Width = 145
            Height = 21
            ItemHeight = 13
            ItemIndex = 0
            TabOrder = 0
            Text = #1042#1089#1077
            Items.Strings = (
              #1042#1089#1077
              #1054#1090#1082#1088#1099#1090#1099#1077
              #1047#1072#1082#1088#1099#1090#1099#1077)
          end
        end
      end
    end
  end
  object pnlControl: TPanel
    Left = 0
    Top = 356
    Width = 419
    Height = 22
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlControl'
    TabOrder = 1
    object pnlControl_Tool: TPanel
      Left = 229
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
      Width = 229
      Height = 22
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object actionList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 291
    Top = 12
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
    object aSLStatus_DateFormation: TAction
      Category = 'Status'
      Caption = #8230
      OnExecute = aSLStatus_DateFormationExecute
    end
    object aSLStatus_DateBell: TAction
      Category = 'Status'
      Caption = #8230
      OnExecute = aSLStatus_DateBellExecute
    end
    object aSLStatus_BeginPicking: TAction
      Category = 'Status'
      Caption = #8230
      OnExecute = aSLStatus_BeginPickingExecute
    end
    object aSLStatus_EndPicking: TAction
      Category = 'Status'
      Caption = #8230
      OnExecute = aSLStatus_EndPickingExecute
    end
    object aSLStatus_ReadySend: TAction
      Category = 'Status'
      Caption = #8230
      OnExecute = aSLStatus_ReadySendExecute
    end
  end
  object qrspStateOpenOrder: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_RP_StateOpenOrder;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@SBegin'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@SEnd'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@SActionEnd'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end
      item
        Name = '@StatusDateFormation'
        Attributes = [paNullable]
        DataType = ftString
        Size = 160
        Value = ''
      end
      item
        Name = '@StatusDateBell'
        Attributes = [paNullable]
        DataType = ftString
        Size = 160
        Value = ''
      end
      item
        Name = '@StatusBeginPicking'
        Attributes = [paNullable]
        DataType = ftString
        Size = 160
        Value = ''
      end
      item
        Name = '@StatusEndPicking'
        Attributes = [paNullable]
        DataType = ftString
        Size = 160
        Value = ''
      end
      item
        Name = '@StatusReadySend'
        Attributes = [paNullable]
        DataType = ftString
        Size = 160
        Value = ''
      end
      item
        Name = '@SignOrderState'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = 0
      end>
    Left = 333
    Top = 29
  end
  object spFindStatus: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_FindOrderStatus;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@Descr'
        Attributes = [paNullable]
        DataType = ftString
        Size = 240
        Value = ''
      end
      item
        Name = '@NRN_OUT'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = 0
      end
      item
        Name = '@SErr'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 4000
        Value = ''
      end>
    Left = 244
    Top = 56
  end
end
