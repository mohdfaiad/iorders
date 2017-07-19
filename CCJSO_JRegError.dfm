object frmCCJSO_JRegError: TfrmCCJSO_JRegError
  Left = 78
  Top = 316
  Width = 1019
  Height = 365
  BorderIcons = [biSystemMenu]
  Caption = #1054#1096#1080#1073#1082#1080' '#1074#1088#1077#1084#1077#1085#1080' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
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
  object SplitterGrid: TSplitter
    Left = 0
    Top = 222
    Width = 1003
    Height = 3
    Cursor = crVSplit
    Align = alTop
    Beveled = True
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 1003
    Height = 26
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    TabOrder = 0
    object pnlTop_Control: TPanel
      Left = 755
      Top = 0
      Width = 248
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlTop_Control'
      TabOrder = 0
      object tbrMain: TToolBar
        Left = 0
        Top = 0
        Width = 248
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 235
        Caption = 'tbrMain'
        EdgeBorders = []
        EdgeInner = esNone
        EdgeOuter = esNone
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tlbtnRegFailure: TToolButton
          Left = 0
          Top = 0
          Action = aMain_ShowAllRegErr
          AutoSize = True
        end
      end
    end
    object pnlTop_Show: TPanel
      Left = 0
      Top = 0
      Width = 755
      Height = 26
      Align = alClient
      Alignment = taLeftJustify
      BevelInner = bvLowered
      TabOrder = 1
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 26
    Width = 1003
    Height = 196
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlGrid'
    TabOrder = 1
    object DBGRID: TDBGrid
      Left = 0
      Top = 0
      Width = 1003
      Height = 196
      Align = alClient
      BorderStyle = bsNone
      DataSource = dsJRegError
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = DBGRIDDrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'SCreateDate'
          Title.Caption = #1044#1072#1090#1072' '#1089#1086#1079#1076#1072#1085#1080#1103
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SUser'
          Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          Width = 168
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NErrorNumber'
          Title.Caption = #1053#1086#1084'.'#1054#1096#1080#1073'.'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SStepNote'
          Title.Caption = #1064#1072#1075
          Width = 381
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SNameProcedure'
          Title.Caption = #1055#1088#1086#1094#1077#1076#1091#1088#1072
          Width = 300
          Visible = True
        end>
    end
  end
  object pnlErrMessage: TPanel
    Left = 0
    Top = 225
    Width = 1003
    Height = 102
    Align = alClient
    BevelInner = bvLowered
    Caption = 'pnlErrMessage'
    TabOrder = 2
    object mErrMessage: TMemo
      Left = 2
      Top = 2
      Width = 999
      Height = 98
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Lines.Strings = (
        '')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object aMain: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 648
    Top = 34
    object aMain_Close: TAction
      Category = 'Main'
      Caption = 'aMain_Close'
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aMain_CloseExecute
    end
    object aMain_ShowAllRegErr: TAction
      Category = 'Main'
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077' '#1079#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1085#1099#1077' '#1089#1073#1086#1080
      ImageIndex = 206
      OnExecute = aMain_ShowAllRegErrExecute
    end
    object aMain_ShowCurrentOrderRegErr: TAction
      Category = 'Main'
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1079#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1085#1099#1077' '#1089#1073#1086#1080' '#1074#1099#1073#1088#1072#1085#1085#1086#1075#1086' '#1079#1072#1082#1072#1079#1072
      ImageIndex = 207
      OnExecute = aMain_ShowCurrentOrderRegErrExecute
    end
  end
  object qrspJRegError: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_JRegError;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@SOrder'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end>
    Left = 752
    Top = 98
  end
  object dsJRegError: TDataSource
    DataSet = qrspJRegError
    OnDataChange = dsJRegErrorDataChange
    Left = 680
    Top = 98
  end
end
