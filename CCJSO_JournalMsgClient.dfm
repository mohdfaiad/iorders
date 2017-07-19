object frmCCJSO_JournalMsgClient: TfrmCCJSO_JournalMsgClient
  Left = 137
  Top = 130
  Width = 1305
  Height = 675
  Caption = 'Журнал регистрации отправки уведомлений клиентам '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCond: TPanel
    Left = 0
    Top = 0
    Width = 1297
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlCond'
    TabOrder = 0
    object pnlCond_Tool: TPanel
      Left = 0
      Top = 0
      Width = 35
      Height = 26
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'pnlCond_Tool'
      TabOrder = 0
      object tbarCond: TToolBar
        Left = 0
        Top = 0
        Width = 35
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        Caption = 'tbarCond'
        DisabledImages = FCCenterJournalNetZkz.imgMainDisable
        EdgeBorders = [ebRight]
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object tbtnCondClear: TToolButton
          Left = 0
          Top = 0
          Action = aCondClear
          AutoSize = True
        end
      end
    end
    object pnlCond_Fields: TPanel
      Left = 35
      Top = 0
      Width = 1262
      Height = 26
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object lblCond_Begin: TLabel
        Left = 5
        Top = 9
        Width = 6
        Height = 13
        Caption = 'с'
      end
      object lblJCond_End: TLabel
        Left = 144
        Top = 10
        Width = 12
        Height = 13
        Caption = 'по'
      end
      object lblJCond_Prefix: TLabel
        Left = 292
        Top = 10
        Width = 46
        Height = 13
        Caption = 'Префикс'
      end
      object lblCond_Order: TLabel
        Left = 432
        Top = 10
        Width = 31
        Height = 13
        Caption = 'Заказ'
      end
      object lblCond_Phone: TLabel
        Left = 557
        Top = 10
        Width = 45
        Height = 13
        Caption = 'Телефон'
      end
      object lblCond_Pharm: TLabel
        Left = 719
        Top = 10
        Width = 79
        Height = 13
        Caption = 'Торговая точка'
      end
      object lblCond_Type: TLabel
        Left = 913
        Top = 11
        Width = 89
        Height = 13
        Caption = 'Тип уведомления'
      end
      object edCond_Begin: TEdit
        Tag = 10
        Left = 14
        Top = 3
        Width = 125
        Height = 20
        BevelKind = bkFlat
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
        OnChange = aCondChangeExecute
        OnDblClick = aSlDateExecute
      end
      object btnCond_Begin: TButton
        Tag = 10
        Left = 119
        Top = 5
        Width = 18
        Height = 16
        Action = aSlDate
        TabOrder = 1
      end
      object edCond_End: TEdit
        Tag = 11
        Left = 159
        Top = 3
        Width = 125
        Height = 20
        BevelKind = bkFlat
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 2
        OnChange = aCondChangeExecute
        OnDblClick = aSlDateExecute
      end
      object btnCond_End: TButton
        Tag = 11
        Left = 264
        Top = 5
        Width = 18
        Height = 16
        Action = aSlDate
        TabOrder = 3
      end
      object cmbxCond_Prefix: TComboBox
        Left = 341
        Top = 3
        Width = 82
        Height = 21
        BevelKind = bkFlat
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 4
        Text = 'Все'
        OnChange = aCondChangeExecute
        Items.Strings = (
          'Все')
      end
      object edCond_Order: TEdit
        Tag = 15
        Left = 467
        Top = 3
        Width = 80
        Height = 20
        BevelKind = bkFlat
        BorderStyle = bsNone
        MaxLength = 20
        TabOrder = 5
        OnChange = aCondChangeExecute
      end
      object edCond_Phone: TEdit
        Tag = 15
        Left = 606
        Top = 3
        Width = 100
        Height = 20
        BevelKind = bkFlat
        BorderStyle = bsNone
        MaxLength = 20
        TabOrder = 6
        OnChange = aCondChangeExecute
      end
      object edCond_Pharm: TEdit
        Tag = 15
        Left = 804
        Top = 3
        Width = 100
        Height = 20
        BevelKind = bkFlat
        BorderStyle = bsNone
        MaxLength = 20
        TabOrder = 7
        OnChange = aCondChangeExecute
      end
      object cmbxCond_Type: TComboBox
        Left = 1006
        Top = 3
        Width = 237
        Height = 21
        BevelKind = bkFlat
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 8
        Text = 'Все'
        OnChange = aCondChangeExecute
        Items.Strings = (
          'Все')
      end
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 26
    Width = 1297
    Height = 622
    Align = alClient
    Caption = 'pnlGrid'
    TabOrder = 1
    object pnlGridControl: TPanel
      Left = 1
      Top = 1
      Width = 1295
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlGridControl'
      TabOrder = 0
      object pnlGridControl_Show: TPanel
        Left = 1110
        Top = 0
        Width = 185
        Height = 26
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
      end
      object pnlGridControl_Tool: TPanel
        Left = 0
        Top = 0
        Width = 1110
        Height = 26
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlGridControl_Tool'
        TabOrder = 1
        object tbarTool: TToolBar
          Left = 0
          Top = 0
          Width = 1110
          Height = 26
          Align = alClient
          AutoSize = True
          BorderWidth = 1
          ButtonWidth = 76
          Caption = 'tbarTool'
          DisabledImages = FCCenterJournalNetZkz.imgMain
          EdgeBorders = []
          Flat = True
          Images = FCCenterJournalNetZkz.imgMain
          List = True
          ShowCaptions = True
          TabOrder = 0
          object tbtbRefresh: TToolButton
            Left = 0
            Top = 0
            Action = aRefresh
            AutoSize = True
          end
        end
      end
    end
    object GridMain: TDBGrid
      Left = 1
      Top = 27
      Width = 1295
      Height = 594
      Align = alClient
      BorderStyle = bsNone
      Ctl3D = False
      DataSource = dsMain
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = GridMainDrawColumnCell
      OnTitleClick = GridMainTitleClick
      Columns = <
        item
          Expanded = False
          FieldName = 'SCreateDate'
          Title.Caption = 'Дата создания'
          Width = 79
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SSMSType'
          Title.Caption = 'Тип уведомления'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SPrefix'
          Title.Caption = 'Префикс'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOrder'
          Title.Caption = 'Заказ'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SPharm'
          Title.Caption = 'Торговая точка'
          Width = 53
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SPhone'
          Title.Caption = 'Телефон'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NCash'
          Title.Caption = 'Сумма'
          Width = 42
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SEmail'
          Title.Caption = 'EMail'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SNote'
          Title.Caption = 'Содержание уведомления'
          Width = 405
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SUSER'
          Title.Caption = 'Пользователь'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IErr'
          Title.Caption = 'Код ошибки'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SErr'
          Title.Caption = 'Сообщение об ошибке'
          Width = 300
          Visible = True
        end>
    end
  end
  object aList: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 720
    Top = 74
    object aExit: TAction
      Category = 'Control'
      Caption = 'Закрыть'
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aExitExecute
    end
    object aItemInfo: TAction
      Category = 'Control'
      Caption = 'Информация об уведомлении'
      ImageIndex = 16
      OnExecute = aItemInfoExecute
    end
    object aRefresh: TAction
      Category = 'Control'
      Caption = 'Обновить'
      ImageIndex = 4
      OnExecute = aRefreshExecute
    end
    object aCondClear: TAction
      Category = 'Condition'
      Caption = 'Очистить условия отбора'
      Hint = 'Очистить условия отбора'
      ImageIndex = 40
      OnExecute = aCondClearExecute
    end
    object aCondChange: TAction
      Category = 'Condition'
      Caption = 'aCondChange'
      OnExecute = aCondChangeExecute
    end
    object aSlDate: TAction
      Category = 'Condition'
      Caption = '…'
      OnExecute = aSlDateExecute
    end
  end
  object qrspMain: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_RegSMS;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@Begin'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end
      item
        Name = '@End'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = ''
      end
      item
        Name = '@Order'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@Pharm'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@Prefix'
        Attributes = [paNullable]
        DataType = ftString
        Size = 10
        Value = ''
      end
      item
        Name = '@Phone'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = ''
      end
      item
        Name = '@Type'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end
      item
        Name = '@OrderBy'
        Attributes = [paNullable]
        DataType = ftString
        Size = 40
        Value = ''
      end
      item
        Name = '@Direction'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = False
      end>
    Left = 776
    Top = 74
  end
  object dsMain: TDataSource
    DataSet = qrspMain
    Left = 840
    Top = 74
  end
  object qrspSMSType: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_RegSMS_NameType;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@SMSType'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end>
    Left = 912
    Top = 82
  end
end
