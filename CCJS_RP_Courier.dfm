object frmCCJS_RP_Courier: TfrmCCJS_RP_Courier
  Left = 88
  Top = 105
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1082#1091#1088#1100#1077#1088#1089#1082#1086#1081' '#1076#1086#1089#1090#1072#1074#1082#1080
  ClientHeight = 323
  ClientWidth = 403
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
  object pnlParm: TPanel
    Left = 0
    Top = 0
    Width = 403
    Height = 297
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlParm'
    TabOrder = 0
    object pgParm: TPageControl
      Left = 0
      Top = 0
      Width = 403
      Height = 297
      ActivePage = tabParm
      Align = alClient
      TabOrder = 0
      object tabParm: TTabSheet
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
        object grbxPharmGroup: TGroupBox
          Left = 0
          Top = 90
          Width = 395
          Height = 179
          Align = alClient
          Caption = ' '#1043#1088#1091#1087#1087#1099' '
          TabOrder = 0
          object pnlPharmGroup_Control: TPanel
            Left = 246
            Top = 15
            Width = 147
            Height = 162
            Align = alRight
            BevelOuter = bvNone
            BorderWidth = 3
            TabOrder = 0
            object tlbrPharmGroup: TToolBar
              Left = 3
              Top = 3
              Width = 141
              Height = 44
              AutoSize = True
              ButtonWidth = 140
              Caption = 'tlbrPharmGroup'
              EdgeBorders = []
              EdgeInner = esNone
              EdgeOuter = esNone
              Flat = True
              Images = FCCenterJournalNetZkz.imgMain
              List = True
              ShowCaptions = True
              TabOrder = 0
              Transparent = True
              object ToolButton2: TToolButton
                Left = 0
                Top = 0
                Action = aListToll_AllPharm
                Wrap = True
              end
              object ToolButton3: TToolButton
                Left = 0
                Top = 22
                Action = aListToll_ClearSelectGroup
              end
            end
            object pnlPharmGroup_Control_Show: TPanel
              Left = 3
              Top = 118
              Width = 141
              Height = 41
              Align = alBottom
              BevelOuter = bvNone
              TabOrder = 1
            end
          end
          object pnlPharmGroup_List: TPanel
            Left = 2
            Top = 15
            Width = 244
            Height = 162
            Align = alClient
            BevelOuter = bvNone
            BorderWidth = 3
            Caption = 'pnlPharmGroup_List'
            TabOrder = 1
            object chListBoxGroupPharm: TCheckListBox
              Left = 3
              Top = 3
              Width = 238
              Height = 156
              OnClickCheck = chListBoxGroupPharmClickCheck
              Align = alClient
              BevelInner = bvNone
              BevelKind = bkFlat
              BorderStyle = bsNone
              ItemHeight = 13
              TabOrder = 0
            end
          end
        end
        object pnlPeriod: TPanel
          Left = 0
          Top = 0
          Width = 395
          Height = 90
          Align = alTop
          BevelOuter = bvNone
          Caption = 'pnlPeriod'
          TabOrder = 1
          object pnlPeriod_Check: TPanel
            Left = 0
            Top = 0
            Width = 395
            Height = 29
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object lbl: TLabel
              Left = 5
              Top = 9
              Width = 137
              Height = 13
              Caption = #1042#1080#1076' '#1082#1086#1085#1090#1088#1086#1083#1100#1085#1086#1075#1086' '#1087#1077#1088#1080#1086#1076#1072
            end
            object cmbxCheckPeriod: TComboBox
              Left = 145
              Top = 3
              Width = 153
              Height = 21
              Style = csDropDownList
              Ctl3D = True
              ItemHeight = 13
              ItemIndex = 0
              ParentCtl3D = False
              TabOrder = 0
              Text = #1050#1072#1083#1077#1085#1076#1072#1088#1085#1099#1081' '#1087#1077#1088#1080#1086#1076
              OnChange = cmbxCheckPeriodChange
              Items.Strings = (
                #1050#1072#1083#1077#1085#1076#1072#1088#1085#1099#1081' '#1087#1077#1088#1080#1086#1076
                #1055#1077#1088#1080#1086#1076' ('#1076#1072#1090#1072' + '#1074#1088#1077#1084#1103')'
                #1055#1086' '#1079#1072#1082#1072#1079#1072#1084)
            end
          end
          object pnlPeriod_Periods: TPanel
            Left = 0
            Top = 29
            Width = 395
            Height = 61
            Align = alClient
            BevelOuter = bvNone
            Caption = 'pnlPeriod_Periods'
            TabOrder = 1
            object pgcPeriods: TPageControl
              Left = 0
              Top = 0
              Width = 395
              Height = 61
              ActivePage = tabPeriod_Day
              Align = alClient
              MultiLine = True
              TabOrder = 0
              object tabPeriod_Day: TTabSheet
                Caption = #1050#1072#1083#1077#1085#1076#1072#1088#1085#1099#1081' '#1087#1077#1088#1080#1086#1076
                object Label1: TLabel
                  Left = 4
                  Top = 14
                  Width = 6
                  Height = 13
                  Caption = #1089
                end
                object Label2: TLabel
                  Left = 115
                  Top = 14
                  Width = 12
                  Height = 13
                  Caption = #1087#1086
                end
                object dtDayBegin: TDateTimePicker
                  Left = 14
                  Top = 7
                  Width = 90
                  Height = 21
                  Date = 41856.717597962960000000
                  Time = 41856.717597962960000000
                  TabOrder = 0
                  OnChange = dtDayBeginChange
                end
                object dtDayEnd: TDateTimePicker
                  Left = 130
                  Top = 7
                  Width = 90
                  Height = 21
                  Date = 41856.717597962960000000
                  Time = 41856.717597962960000000
                  TabOrder = 1
                  OnChange = dtDayEndChange
                end
              end
              object tabPeriod_Date: TTabSheet
                Caption = #1055#1077#1088#1080#1086#1076' ('#1076#1072#1090#1072' + '#1074#1088#1077#1084#1103')'
                ImageIndex = 1
                object Label3: TLabel
                  Left = 6
                  Top = 14
                  Width = 6
                  Height = 13
                  Caption = #1089
                end
                object Label4: TLabel
                  Left = 194
                  Top = 15
                  Width = 12
                  Height = 13
                  Caption = #1087#1086
                end
                object dtDateBegin: TDateTimePicker
                  Left = 16
                  Top = 7
                  Width = 90
                  Height = 21
                  Date = 41856.717597962960000000
                  Time = 41856.717597962960000000
                  TabOrder = 0
                  OnChange = dtDateBeginChange
                end
                object dtTimeBegin: TDateTimePicker
                  Left = 108
                  Top = 7
                  Width = 75
                  Height = 21
                  Date = 41856.717597962960000000
                  Time = 41856.717597962960000000
                  Kind = dtkTime
                  TabOrder = 1
                  OnChange = dtTimeBeginChange
                end
                object dtTimeEnd: TDateTimePicker
                  Left = 300
                  Top = 7
                  Width = 75
                  Height = 21
                  Date = 41856.717597962960000000
                  Time = 41856.717597962960000000
                  Kind = dtkTime
                  TabOrder = 2
                  OnChange = dtTimeEndChange
                end
                object dtDateEnd: TDateTimePicker
                  Left = 208
                  Top = 7
                  Width = 90
                  Height = 21
                  Date = 41856.717597962960000000
                  Time = 41856.717597962960000000
                  TabOrder = 3
                  OnChange = dtDateEndChange
                end
              end
              object tabPeriod_Orders: TTabSheet
                Caption = #1055#1086' '#1079#1072#1082#1072#1079#1072#1084
                ImageIndex = 2
                object Label5: TLabel
                  Left = 4
                  Top = 14
                  Width = 6
                  Height = 13
                  Caption = #1089
                end
                object Label6: TLabel
                  Left = 131
                  Top = 14
                  Width = 12
                  Height = 13
                  Caption = #1087#1086
                end
                object edOrderBegin: TEdit
                  Left = 14
                  Top = 7
                  Width = 109
                  Height = 21
                  MaxLength = 15
                  TabOrder = 0
                  OnChange = edOrderBeginChange
                end
                object edOrderEnd: TEdit
                  Left = 148
                  Top = 7
                  Width = 121
                  Height = 21
                  MaxLength = 15
                  TabOrder = 1
                  OnChange = edOrderEndChange
                end
              end
            end
          end
        end
      end
    end
  end
  object pnlControl: TPanel
    Left = 0
    Top = 297
    Width = 403
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlControl'
    TabOrder = 1
    object pnlControl_Tool: TPanel
      Left = 210
      Top = 0
      Width = 193
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlControl_Tool'
      TabOrder = 0
      object tlbrControl: TToolBar
        Left = 0
        Top = 0
        Width = 193
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 99
        EdgeBorders = []
        EdgeInner = esNone
        EdgeOuter = esNone
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tlbtnControl_Excel: TToolButton
          Left = 0
          Top = 0
          Action = aExcel
          AutoSize = True
        end
        object ToolButton1: TToolButton
          Left = 103
          Top = 0
          Action = aExit
          AutoSize = True
        end
      end
    end
    object pnlControl_Show: TPanel
      Left = 0
      Top = 0
      Width = 210
      Height = 26
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 358
    Top = 7
    object aExcel: TAction
      Category = 'Control'
      Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 111
      OnExecute = aExcelExecute
    end
    object aExit: TAction
      Category = 'Control'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
    object aListToll_AllPharm: TAction
      Category = 'ListTool'
      AutoCheck = True
      Caption = #1044#1083#1103' '#1074#1089#1077#1093' '#1075#1088#1091#1087#1087
      OnExecute = aListToll_AllPharmExecute
    end
    object aListToll_ClearSelectGroup: TAction
      Category = 'ListTool'
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1074#1099#1073#1086#1088' '#1075#1088#1091#1087#1087
      ImageIndex = 287
      OnExecute = aListToll_ClearSelectGroupExecute
    end
  end
  object pDSGroupCount: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_RP_Courier_GroupCount;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@KindCheckPeriod'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = 0
      end
      item
        Name = '@SBegin'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end
      item
        Name = '@SEnd'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end
      item
        Name = '@OrderBegin'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@OrderEnd'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end>
    Left = 34
    Top = 138
  end
  object spSelectList_Insert: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_SelectList_insert;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDENT'
        Attributes = [paNullable]
        DataType = ftLargeint
        Precision = 19
        Value = Null
      end
      item
        Name = '@SUnitCode'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = Null
      end
      item
        Name = '@PRN'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@BigPRN'
        Attributes = [paNullable]
        DataType = ftLargeint
        Precision = 19
        Value = Null
      end
      item
        Name = '@USER'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@NRN'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@SErr'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 4000
        Value = Null
      end>
    Left = 97
    Top = 155
  end
  object spSelectList_Clear: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'p_SelectList_Clear;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDENT'
        Attributes = [paNullable]
        DataType = ftLargeint
        Precision = 19
        Value = Null
      end
      item
        Name = '@SErr'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end>
    Left = 182
    Top = 145
  end
  object spDS_RP_Courier: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_RP_Courier;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDENT'
        Attributes = [paNullable]
        DataType = ftLargeint
        Precision = 19
        Value = Null
      end
      item
        Name = '@KindCheckPeriod'
        Attributes = [paNullable]
        DataType = ftSmallint
        Precision = 5
        Value = Null
      end
      item
        Name = '@SBegin'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = Null
      end
      item
        Name = '@SEnd'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = Null
      end
      item
        Name = '@OrderBegin'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@OrderEnd'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 38
    Top = 201
  end
end
