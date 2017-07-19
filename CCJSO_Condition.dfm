object frmCCJSO_Condition: TfrmCCJSO_Condition
  Left = 418
  Top = 63
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Расширенные условия отбора'
  ClientHeight = 698
  ClientWidth = 581
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
  object pnlControl: TPanel
    Left = 0
    Top = 672
    Width = 581
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlControl'
    TabOrder = 0
    object pnlCondition_Tool: TPanel
      Left = 341
      Top = 0
      Width = 240
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlCondition_Tool'
      TabOrder = 0
      object tlbarControl: TToolBar
        Left = 0
        Top = 0
        Width = 240
        Height = 26
        Align = alClient
        AutoSize = True
        BorderWidth = 1
        ButtonWidth = 75
        EdgeBorders = []
        Flat = True
        Images = FCCenterJournalNetZkz.imgMain
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tlbtnControl_Ok: TToolButton
          Left = 0
          Top = 0
          Action = aControl_Ok
          AutoSize = True
        end
        object tlbtnControlClear: TToolButton
          Left = 79
          Top = 0
          Action = aControl_Clear
          AutoSize = True
        end
        object tlbtnControl_Close: TToolButton
          Left = 157
          Top = 0
          Action = aControl_Close
          AutoSize = True
        end
      end
    end
    object pnlCondition_Show: TPanel
      Left = 0
      Top = 0
      Width = 341
      Height = 26
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlCondition: TPanel
    Left = 0
    Top = 0
    Width = 581
    Height = 672
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlCondition'
    TabOrder = 1
    object pgcCondirion: TPageControl
      Left = 0
      Top = 0
      Width = 581
      Height = 672
      ActivePage = tabJournal
      Align = alClient
      Images = FCCenterJournalNetZkz.imgMain
      PopupMenu = pmTab
      TabOrder = 0
      OnChange = pgcCondirionChange
      object tabJournal: TTabSheet
        Caption = 'Реквизиты заказа'
        ImageIndex = 18
        object grbxPeriod: TGroupBox
          Left = 0
          Top = 0
          Width = 573
          Height = 113
          Align = alTop
          Caption = ' Период '
          TabOrder = 0
          object pnlOrderPeriod: TPanel
            Left = 2
            Top = 15
            Width = 569
            Height = 96
            Align = alClient
            BevelOuter = bvNone
            BorderWidth = 3
            Caption = 'pnlOrderPeriod'
            TabOrder = 0
            object pnlOrderPeriod_Check: TPanel
              Left = 3
              Top = 3
              Width = 563
              Height = 30
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 0
              object lblKindCheckPeriod: TLabel
                Left = 5
                Top = 9
                Width = 137
                Height = 13
                Caption = 'Вид контрольного периода'
              end
              object cmbxCheckPeriod: TComboBox
                Left = 145
                Top = 3
                Width = 153
                Height = 21
                BevelKind = bkFlat
                Style = csDropDownList
                Ctl3D = True
                ItemHeight = 13
                ItemIndex = 0
                ParentCtl3D = False
                TabOrder = 0
                Text = 'Календарный период'
                OnChange = aValueFieldChangeExecute
                Items.Strings = (
                  'Календарный период'
                  'Период (дата + время)')
              end
              object chbxCndAccountPeriod: TCheckBox
                Left = 308
                Top = 6
                Width = 119
                Height = 17
                Caption = 'учитывать период'
                Checked = True
                State = cbChecked
                TabOrder = 1
                OnClick = aValueFieldChangeExecute
              end
            end
            object pnlOrderPeriod_Periods: TPanel
              Left = 3
              Top = 33
              Width = 563
              Height = 60
              Align = alClient
              BevelOuter = bvNone
              Caption = 'pnlOrderPeriod_Periods'
              TabOrder = 1
              object pgcPeriods: TPageControl
                Left = 0
                Top = 0
                Width = 563
                Height = 60
                ActivePage = tabPeriod_Day
                Align = alClient
                Anchors = []
                MultiLine = True
                TabOrder = 0
                object tabPeriod_Day: TTabSheet
                  Caption = 'Календарный период'
                  object lblCndDatePeriod_with: TLabel
                    Left = 3
                    Top = 16
                    Width = 6
                    Height = 13
                    Caption = 'с'
                  end
                  object lblCndDatePeriod_toOn: TLabel
                    Left = 110
                    Top = 16
                    Width = 12
                    Height = 13
                    Caption = 'по'
                  end
                  object dtCndBegin: TDateTimePicker
                    Left = 12
                    Top = 8
                    Width = 90
                    Height = 21
                    Date = 41856.717597962960000000
                    Time = 41856.717597962960000000
                    TabOrder = 0
                    OnChange = aValueFieldChangeExecute
                  end
                  object dtCndEnd: TDateTimePicker
                    Left = 125
                    Top = 8
                    Width = 90
                    Height = 21
                    Date = 41856.717597962960000000
                    Time = 41856.717597962960000000
                    TabOrder = 1
                    OnChange = aValueFieldChangeExecute
                  end
                end
                object tabPeriod_Date: TTabSheet
                  Caption = 'Период (дата + время)'
                  ImageIndex = 1
                  object Label3: TLabel
                    Left = 6
                    Top = 14
                    Width = 6
                    Height = 13
                    Caption = 'с'
                  end
                  object Label4: TLabel
                    Left = 194
                    Top = 15
                    Width = 12
                    Height = 13
                    Caption = 'по'
                  end
                  object dtDateBegin: TDateTimePicker
                    Left = 16
                    Top = 7
                    Width = 90
                    Height = 21
                    Date = 41856.717597962960000000
                    Time = 41856.717597962960000000
                    TabOrder = 0
                    OnChange = aValueFieldChangeExecute
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
                    OnChange = aValueFieldChangeExecute
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
                    OnChange = aValueFieldChangeExecute
                  end
                  object dtDateEnd: TDateTimePicker
                    Left = 208
                    Top = 7
                    Width = 90
                    Height = 21
                    Date = 41856.717597962960000000
                    Time = 41856.717597962960000000
                    TabOrder = 3
                    OnChange = aValueFieldChangeExecute
                  end
                end
              end
            end
          end
        end
        object grbxTitleOrder: TGroupBox
          Left = 0
          Top = 113
          Width = 573
          Height = 169
          Align = alTop
          Caption = 'ЗАКАЗ'
          TabOrder = 1
          object lblOrder: TLabel
            Left = 4
            Top = 20
            Width = 45
            Height = 13
            Caption = 'Заказ №'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblState: TLabel
            Left = 4
            Top = 45
            Width = 54
            Height = 13
            Caption = 'Состояние'
          end
          object lblPharmacy: TLabel
            Left = 364
            Top = 47
            Width = 36
            Height = 13
            Caption = 'Аптека'
          end
          object lblShipping: TLabel
            Left = 163
            Top = 73
            Width = 69
            Height = 13
            Caption = 'Вид доставки'
          end
          object lblSignNewOrder: TLabel
            Left = 8
            Top = 122
            Width = 121
            Height = 13
            Caption = 'Признак нового заказа'
          end
          object lblSignDefinedParm: TLabel
            Left = 284
            Top = 121
            Width = 185
            Height = 13
            Caption = 'Наличие аптеки в заголовке заказа'
          end
          object lblCity: TLabel
            Left = 201
            Top = 46
            Width = 30
            Height = 13
            Caption = 'Город'
          end
          object lblSignLink: TLabel
            Left = 30
            Top = 146
            Width = 98
            Height = 13
            Caption = 'Связанные заказы'
          end
          object lblPayment: TLabel
            Left = 173
            Top = 97
            Width = 59
            Height = 13
            Caption = 'Вид оплаты'
          end
          object Label21: TLabel
            Left = 347
            Top = 20
            Width = 89
            Height = 13
            Caption = 'Сайт / Внеш. сис.'
          end
          object Label22: TLabel
            Left = 179
            Top = 20
            Width = 50
            Height = 13
            Caption = 'Внешн. №'
          end
          object edOrder: TEdit
            Left = 62
            Top = 14
            Width = 107
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = clInfoBk
            MaxLength = 10
            TabOrder = 0
            OnChange = aValueFieldChangeExecute
          end
          object cmbxOrderState: TComboBox
            Left = 62
            Top = 40
            Width = 107
            Height = 21
            BevelKind = bkFlat
            ItemHeight = 13
            TabOrder = 3
            Text = 'Актуальные'
            OnChange = aValueFieldChangeExecute
            Items.Strings = (
              'Все'
              'Открытые'
              'Закрытые'
              'Активные')
          end
          object edPharmacy: TEdit
            Left = 403
            Top = 40
            Width = 162
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            ReadOnly = True
            TabOrder = 5
            OnChange = aValueFieldChangeExecute
            OnDblClick = aSlPharmacyExecute
          end
          object btnSlPharmacy: TButton
            Left = 544
            Top = 42
            Width = 19
            Height = 17
            Action = aSlPharmacy
            TabOrder = 6
          end
          object edShipping: TEdit
            Left = 236
            Top = 66
            Width = 329
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            ReadOnly = True
            TabOrder = 7
            OnChange = aValueFieldChangeExecute
            OnDblClick = aSlShippingExecute
          end
          object btnSlShipping: TButton
            Left = 544
            Top = 68
            Width = 19
            Height = 17
            Action = aSlShipping
            TabOrder = 8
          end
          object cmbxSignNewOrder: TComboBox
            Left = 133
            Top = 116
            Width = 135
            Height = 21
            BevelKind = bkFlat
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 11
            OnChange = aValueFieldChangeExecute
            Items.Strings = (
              'Все'
              'Новый (подлежит обработке)'
              'Обработанный')
          end
          object cmbxSignDefinedPharm: TComboBox
            Left = 473
            Top = 115
            Width = 92
            Height = 21
            BevelKind = bkFlat
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 12
            OnChange = aValueFieldChangeExecute
            Items.Strings = (
              'Все'
              'Есть'
              'Нет')
          end
          object edCity: TEdit
            Left = 236
            Top = 40
            Width = 122
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            ReadOnly = True
            TabOrder = 4
            OnChange = aValueFieldChangeExecute
            OnDblClick = aSlCityExecute
          end
          object btnCity: TButton
            Left = 337
            Top = 42
            Width = 19
            Height = 17
            Action = aSlCity
            TabOrder = 14
          end
          object cmbxSignLink: TComboBox
            Left = 133
            Top = 140
            Width = 432
            Height = 21
            BevelKind = bkFlat
            Style = csDropDownList
            ItemHeight = 13
            ItemIndex = 0
            TabOrder = 13
            Text = 'Все'
            OnChange = cmbxSignLinkChange
            Items.Strings = (
              'Все'
              'Для текущего заказа показать связанные заказы'
              'Показать все главные заказы у которых есть дополнительные заказы')
          end
          object edPayment: TEdit
            Left = 236
            Top = 90
            Width = 329
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            ReadOnly = True
            TabOrder = 9
            OnChange = aValueFieldChangeExecute
            OnDblClick = aSlPaymentExecute
          end
          object btnSlPayment: TButton
            Left = 544
            Top = 92
            Width = 19
            Height = 17
            Action = aSlPayment
            TabOrder = 10
          end
          object lcSrcSystem: TDBLookupComboBox
            Left = 436
            Top = 14
            Width = 127
            Height = 21
            KeyField = 'ExtSystem'
            ListField = 'Name'
            ListSource = dmJSO.dsExtSystem
            TabOrder = 1
            OnCloseUp = aValueFieldChangeExecute
          end
          object edExtId: TEdit
            Left = 235
            Top = 14
            Width = 108
            Height = 21
            TabOrder = 2
            OnChange = aValueFieldChangeExecute
          end
        end
        object grbxClient: TGroupBox
          Left = 0
          Top = 282
          Width = 573
          Height = 67
          Align = alTop
          Caption = ' Клиент '
          TabOrder = 2
          object lblAllNameClient: TLabel
            Left = 8
            Top = 22
            Width = 27
            Height = 13
            Caption = 'ФИО'
          end
          object lblPhoneClient: TLabel
            Left = 256
            Top = 22
            Width = 45
            Height = 13
            Caption = 'Телефон'
          end
          object lblAdresClient: TLabel
            Left = 4
            Top = 45
            Width = 31
            Height = 13
            Caption = 'Адрес'
          end
          object edAllNameClient: TEdit
            Left = 38
            Top = 16
            Width = 214
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            ReadOnly = True
            TabOrder = 0
            OnChange = aValueFieldChangeExecute
            OnDblClick = aSlAllNameClientExecute
          end
          object btnSlAllNameClient: TButton
            Left = 231
            Top = 18
            Width = 19
            Height = 17
            Action = aSlAllNameClient
            TabOrder = 1
          end
          object edPhoneClient: TEdit
            Left = 304
            Top = 16
            Width = 143
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            ReadOnly = True
            TabOrder = 2
            OnChange = aValueFieldChangeExecute
            OnDblClick = aSlPhoneClientExecute
          end
          object btnClPhoneClient: TButton
            Left = 426
            Top = 18
            Width = 19
            Height = 17
            Action = aSlPhoneClient
            TabOrder = 3
          end
          object edAdresClient: TEdit
            Left = 38
            Top = 39
            Width = 408
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            ReadOnly = True
            TabOrder = 4
            OnChange = aValueFieldChangeExecute
            OnDblClick = aSlAdresClientExecute
          end
          object btnSlAdresClient: TButton
            Left = 425
            Top = 41
            Width = 19
            Height = 17
            Action = aSlAdresClient
            TabOrder = 5
          end
        end
        object grbxGeoGroupPharm: TGroupBox
          Left = 0
          Top = 349
          Width = 573
          Height = 47
          Align = alTop
          Caption = 'Группа аптек '
          TabOrder = 3
          object edGeoGroupPharm: TEdit
            Left = 7
            Top = 20
            Width = 394
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            ReadOnly = True
            TabOrder = 0
            OnChange = aValueFieldChangeExecute
            OnDblClick = aSlGeoGroupPharmExecute
          end
          object btnSLGeoGroupPharm: TButton
            Left = 380
            Top = 22
            Width = 19
            Height = 17
            Action = aSlGeoGroupPharm
            TabOrder = 1
          end
          object chbxGeoGroupPharmNotDefined: TCheckBox
            Left = 422
            Top = 24
            Width = 141
            Height = 17
            Caption = 'группа не определена'
            TabOrder = 2
            OnClick = chbxGeoGroupPharmNotDefinedClick
          end
        end
        object grbxMarkOrder: TGroupBox
          Left = 0
          Top = 538
          Width = 573
          Height = 47
          Align = alTop
          Caption = ' Мои заказы '
          TabOrder = 6
          object lblMarkOtherUser: TLabel
            Left = 113
            Top = 24
            Width = 73
            Height = 13
            Caption = 'Пользователь'
          end
          object cmbxMark: TComboBox
            Left = 7
            Top = 19
            Width = 91
            Height = 21
            BevelKind = bkFlat
            ItemHeight = 13
            TabOrder = 0
            Text = 'Все'
            OnChange = aValueFieldChangeExecute
            Items.Strings = (
              'Все'
              'Мои'
              'Другие')
          end
          object edMarkOtherUser: TEdit
            Left = 189
            Top = 19
            Width = 375
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            MaxLength = 160
            ReadOnly = True
            TabOrder = 1
            OnChange = aValueFieldChangeExecute
            OnDblClick = aSlMarkOtherUserExecute
          end
          object btnSlMarkOtherUser: TButton
            Left = 543
            Top = 21
            Width = 19
            Height = 17
            Action = aSlMarkOtherUser
            TabOrder = 2
          end
        end
        object grbxNPOST: TGroupBox
          Left = 0
          Top = 396
          Width = 573
          Height = 72
          Align = alTop
          Caption = ' Новая почта '
          TabOrder = 4
          object lblSDispatchDeclaration: TLabel
            Left = 7
            Top = 22
            Width = 97
            Height = 13
            Caption = 'Номер декларации'
          end
          object lblSNPOST_StateName: TLabel
            Left = 238
            Top = 23
            Width = 54
            Height = 13
            Caption = 'Состояние'
          end
          object Label2: TLabel
            Left = 7
            Top = 49
            Width = 158
            Height = 13
            Caption = 'Период установки состояния с'
          end
          object Label5: TLabel
            Left = 262
            Top = 49
            Width = 12
            Height = 13
            Caption = 'по'
          end
          object dtDNPOST_StateBegin: TDateTimePicker
            Left = 168
            Top = 43
            Width = 90
            Height = 21
            Date = 41856.717597962960000000
            Time = 41856.717597962960000000
            TabOrder = 3
            OnChange = aValueFieldChangeExecute
          end
          object dtDNPOST_StateEnd: TDateTimePicker
            Left = 277
            Top = 43
            Width = 90
            Height = 21
            Date = 41856.717597962960000000
            Time = 41856.717597962960000000
            TabOrder = 4
            OnChange = aValueFieldChangeExecute
          end
          object edSDispatchDeclaration: TEdit
            Left = 107
            Top = 16
            Width = 126
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            TabOrder = 0
            OnChange = aValueFieldChangeExecute
          end
          object edSNPOST_StateName: TEdit
            Left = 294
            Top = 17
            Width = 273
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            ReadOnly = True
            TabOrder = 1
            OnChange = aValueFieldChangeExecute
            OnDblClick = aSlSNPOST_StateNameExecute
          end
          object chbxNPOST_SignStateDate: TCheckBox
            Left = 374
            Top = 47
            Width = 122
            Height = 17
            Caption = 'учитывать период'
            Checked = True
            State = cbChecked
            TabOrder = 5
            OnClick = aValueFieldChangeExecute
          end
          object btnSlSNPOST_StateName: TButton
            Left = 546
            Top = 19
            Width = 19
            Height = 17
            Action = aSlSNPOST_StateName
            TabOrder = 2
          end
        end
        object grbxPlanDateSend: TGroupBox
          Left = 0
          Top = 468
          Width = 573
          Height = 70
          Align = alTop
          Caption = ' Согласованное время доставки с клиентом '
          TabOrder = 5
          object Label1: TLabel
            Left = 5
            Top = 23
            Width = 137
            Height = 13
            Caption = 'Вид контрольного периода'
          end
          object cmbxSignPeriod_PDS: TComboBox
            Left = 145
            Top = 17
            Width = 153
            Height = 21
            BevelKind = bkFlat
            Style = csDropDownList
            Ctl3D = True
            ItemHeight = 13
            ItemIndex = 0
            ParentCtl3D = False
            TabOrder = 0
            Text = 'Все'
            OnChange = aValueFieldChangeExecute
            Items.Strings = (
              'Все'
              'Календарный период'
              'Период (дата + время)'
              'Не определено')
          end
          object pnlPlanDateSend: TPanel
            Left = 2
            Top = 40
            Width = 569
            Height = 28
            Align = alBottom
            BevelOuter = bvNone
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 1
            object pnlPlanDateSend_Calendar: TPanel
              Left = 0
              Top = 0
              Width = 219
              Height = 28
              Align = alLeft
              Alignment = taLeftJustify
              BevelOuter = bvNone
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 0
              object Label6: TLabel
                Left = 3
                Top = 9
                Width = 6
                Height = 13
                Caption = 'с'
              end
              object Label7: TLabel
                Left = 110
                Top = 9
                Width = 12
                Height = 13
                Caption = 'по'
              end
              object dtBeginDate_PDS: TDateTimePicker
                Left = 12
                Top = 2
                Width = 90
                Height = 21
                Date = 41856.717597962960000000
                Time = 41856.717597962960000000
                TabOrder = 0
                OnChange = aValueFieldChangeExecute
              end
              object dtEndDate_PDS: TDateTimePicker
                Left = 125
                Top = 2
                Width = 90
                Height = 21
                Date = 41856.717597962960000000
                Time = 41856.717597962960000000
                TabOrder = 1
                OnChange = aValueFieldChangeExecute
              end
            end
            object pnlPlanDateSend_Time: TPanel
              Left = 224
              Top = 0
              Width = 345
              Height = 28
              Align = alRight
              Alignment = taLeftJustify
              BevelOuter = bvNone
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 1
              object Label8: TLabel
                Left = 1
                Top = 9
                Width = 6
                Height = 13
                Caption = 'с'
              end
              object Label9: TLabel
                Left = 189
                Top = 9
                Width = 12
                Height = 13
                Caption = 'по'
              end
              object dtBeginClockDate_PDS: TDateTimePicker
                Left = 11
                Top = 2
                Width = 90
                Height = 21
                Date = 41856.717597962960000000
                Time = 41856.717597962960000000
                TabOrder = 0
                OnChange = aValueFieldChangeExecute
              end
              object dtBeginClockTime_PDS: TDateTimePicker
                Left = 103
                Top = 2
                Width = 75
                Height = 21
                Date = 41856.717597962960000000
                Time = 41856.717597962960000000
                Kind = dtkTime
                TabOrder = 1
                OnChange = aValueFieldChangeExecute
              end
              object dtEndClockDate_PDS: TDateTimePicker
                Left = 203
                Top = 2
                Width = 90
                Height = 21
                Date = 41856.717597962960000000
                Time = 41856.717597962960000000
                TabOrder = 2
                OnChange = aValueFieldChangeExecute
              end
              object dtEndClockTime_PDS: TDateTimePicker
                Left = 296
                Top = 2
                Width = 75
                Height = 21
                Date = 41856.717597962960000000
                Time = 41856.717597962960000000
                Kind = dtkTime
                TabOrder = 3
                OnChange = aValueFieldChangeExecute
              end
            end
          end
        end
        object grbxStock: TGroupBox
          Left = 0
          Top = 585
          Width = 573
          Height = 58
          Align = alClient
          Caption = ' Заказы на складе '
          TabOrder = 7
          object lblSStockDateBegin: TLabel
            Left = 278
            Top = 25
            Width = 6
            Height = 13
            Caption = 'с'
          end
          object lblSStockDateEnd: TLabel
            Left = 423
            Top = 25
            Width = 12
            Height = 13
            Caption = 'по'
          end
          object cmbxSignStock: TComboBox
            Left = 7
            Top = 17
            Width = 261
            Height = 21
            BevelKind = bkFlat
            Style = csDropDownList
            Ctl3D = True
            ItemHeight = 13
            ParentCtl3D = False
            TabOrder = 0
            OnChange = aValueFieldChangeExecute
            Items.Strings = (
              'Все'
              'Заказ на складе не оформлялся'
              'Оформлен заказ на складе')
          end
          object edSStockDateBegin: TEdit
            Tag = 60
            Left = 289
            Top = 17
            Width = 125
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            ReadOnly = True
            TabOrder = 1
            OnChange = aValueFieldChangeExecute
            OnDblClick = aSlDateExecute
          end
          object edSStockDateEnd: TEdit
            Tag = 61
            Left = 438
            Top = 17
            Width = 125
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            ReadOnly = True
            TabOrder = 2
            OnChange = aValueFieldChangeExecute
            OnDblClick = aSlDateExecute
          end
          object btnSStockDateBegin: TButton
            Tag = 60
            Left = 393
            Top = 19
            Width = 19
            Height = 17
            Action = aSlDate
            TabOrder = 3
          end
          object btnSStockDateEnd: TButton
            Tag = 61
            Left = 542
            Top = 19
            Width = 19
            Height = 17
            Action = aSlDate
            TabOrder = 4
          end
        end
      end
      object tabOrder: TTabSheet
        Caption = 'Состав заказа'
        ImageIndex = 272
      end
      object tabHistory: TTabSheet
        Caption = 'История операций'
        ImageIndex = 174
      end
      object tabPay: TTabSheet
        Caption = 'Платежи'
        ImageIndex = 270
        object pnlPay_Have: TPanel
          Left = 0
          Top = 0
          Width = 573
          Height = 27
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object lblPay_Have: TLabel
            Left = 2
            Top = 9
            Width = 95
            Height = 13
            Caption = 'Наличие платежей'
          end
          object lblPay_BarCode: TLabel
            Left = 239
            Top = 8
            Width = 52
            Height = 13
            Caption = 'Штрих-код'
          end
          object cmbxPay_Have: TComboBox
            Left = 100
            Top = 3
            Width = 121
            Height = 21
            BevelKind = bkFlat
            Style = csDropDownList
            ItemHeight = 13
            ItemIndex = 0
            TabOrder = 0
            Text = 'Все'
            OnChange = aValueFieldChangeExecute
            Items.Strings = (
              'Все'
              'Есть'
              'Нет')
          end
          object edPay_BarCode: TEdit
            Left = 294
            Top = 2
            Width = 121
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            MaxLength = 20
            TabOrder = 1
            OnChange = aValueFieldChangeExecute
          end
        end
        object pnlPayBetween: TPanel
          Left = 0
          Top = 27
          Width = 573
          Height = 71
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object pnlPayBetween_Sum: TPanel
            Left = 0
            Top = 0
            Width = 108
            Height = 71
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 0
            object lblPay_SumFrom: TLabel
              Left = 8
              Top = 25
              Width = 6
              Height = 13
              Caption = 'с'
            end
            object lblPay_SumTo: TLabel
              Left = 4
              Top = 47
              Width = 12
              Height = 13
              Caption = 'по'
            end
            object lblPay_Sum: TLabel
              Left = 6
              Top = 2
              Width = 80
              Height = 13
              Caption = 'Сумма платежа'
            end
            object edPay_SumFrom: TEdit
              Tag = 1
              Left = 19
              Top = 18
              Width = 78
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              TabOrder = 0
              OnChange = aEdSumExecute
              OnExit = aEdSumExecute
            end
            object edPay_SumTo: TEdit
              Tag = 2
              Left = 19
              Top = 40
              Width = 78
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              TabOrder = 1
              OnChange = aEdSumExecute
              OnExit = aEdSumExecute
            end
          end
          object pnlPayBetween_CreateDate: TPanel
            Left = 416
            Top = 0
            Width = 154
            Height = 71
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 1
            object lblPay_CreateDateBegin: TLabel
              Left = 8
              Top = 26
              Width = 6
              Height = 13
              Caption = 'с'
            end
            object lblPay_CreateDateRnd: TLabel
              Left = 4
              Top = 48
              Width = 12
              Height = 13
              Caption = 'по'
            end
            object lblPay_CreateDate: TLabel
              Left = 6
              Top = 2
              Width = 77
              Height = 13
              Caption = 'Дата создания'
            end
            object edPay_CreateDateBegin: TEdit
              Tag = 30
              Left = 19
              Top = 18
              Width = 125
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              ReadOnly = True
              TabOrder = 0
              OnChange = aValueFieldChangeExecute
              OnDblClick = aSlDateExecute
            end
            object edPay_CreateDateRnd: TEdit
              Tag = 31
              Left = 19
              Top = 40
              Width = 125
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              ReadOnly = True
              TabOrder = 1
              OnChange = aValueFieldChangeExecute
              OnDblClick = aSlDateExecute
            end
            object btnPay_CreateDateBegin: TButton
              Tag = 30
              Left = 123
              Top = 20
              Width = 19
              Height = 17
              Action = aSlDate
              TabOrder = 2
            end
            object btnPay_CreateDateRnd: TButton
              Tag = 31
              Left = 123
              Top = 42
              Width = 19
              Height = 17
              Action = aSlDate
              TabOrder = 3
            end
          end
          object pnlPayBetween_RedeliveryDate: TPanel
            Left = 262
            Top = 0
            Width = 154
            Height = 71
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 2
            object lblPay_RedeliveryDateBegin: TLabel
              Left = 8
              Top = 26
              Width = 6
              Height = 13
              Caption = 'с'
            end
            object lblPay_RedeliveryDateEnd: TLabel
              Left = 4
              Top = 48
              Width = 12
              Height = 13
              Caption = 'по'
            end
            object lblPay_RedeliveryDate: TLabel
              Left = 6
              Top = 2
              Width = 81
              Height = 13
              Caption = 'Дата получения'
            end
            object edPay_RedeliveryDateBegin: TEdit
              Tag = 20
              Left = 19
              Top = 18
              Width = 125
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              ReadOnly = True
              TabOrder = 0
              OnChange = aValueFieldChangeExecute
              OnDblClick = aSlDateExecute
            end
            object edPay_RedeliveryDateEnd: TEdit
              Tag = 21
              Left = 19
              Top = 40
              Width = 125
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              ReadOnly = True
              TabOrder = 1
              OnChange = aValueFieldChangeExecute
              OnDblClick = aSlDateExecute
            end
            object dtnPay_RedeliveryDateBegin: TButton
              Tag = 20
              Left = 123
              Top = 20
              Width = 19
              Height = 17
              Action = aSlDate
              TabOrder = 2
            end
            object dtnPay_RedeliveryDateEnd: TButton
              Tag = 21
              Left = 123
              Top = 42
              Width = 19
              Height = 17
              Action = aSlDate
              TabOrder = 3
            end
          end
          object pnlPayBetween_Date: TPanel
            Left = 108
            Top = 0
            Width = 154
            Height = 71
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 3
            object lblPay_DateBegin: TLabel
              Left = 8
              Top = 26
              Width = 6
              Height = 13
              Caption = 'с'
            end
            object lblPay_DateEnd: TLabel
              Left = 4
              Top = 48
              Width = 12
              Height = 13
              Caption = 'по'
            end
            object lblPay_Date: TLabel
              Left = 6
              Top = 2
              Width = 72
              Height = 13
              Caption = 'Дата платежа'
            end
            object edPay_DateBegin: TEdit
              Tag = 10
              Left = 19
              Top = 18
              Width = 125
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              ReadOnly = True
              TabOrder = 0
              OnChange = aValueFieldChangeExecute
              OnDblClick = aSlDateExecute
            end
            object edPay_DateEnd: TEdit
              Tag = 11
              Left = 19
              Top = 40
              Width = 125
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              ReadOnly = True
              TabOrder = 1
              OnChange = aValueFieldChangeExecute
              OnDblClick = aSlDateExecute
            end
            object btnPay_DateBegin: TButton
              Tag = 10
              Left = 123
              Top = 20
              Width = 19
              Height = 17
              Action = aSlDate
              TabOrder = 2
            end
            object btnPay_DateEnd: TButton
              Tag = 11
              Left = 123
              Top = 42
              Width = 19
              Height = 17
              Action = aSlDate
              TabOrder = 3
            end
          end
        end
      end
      object tabNPostPay: TTabSheet
        Caption = 'Наложенные платежи'
        ImageIndex = 368
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 573
          Height = 27
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label12: TLabel
            Left = 2
            Top = 9
            Width = 95
            Height = 13
            Caption = 'Наличие платежей'
          end
          object Label13: TLabel
            Left = 239
            Top = 8
            Width = 52
            Height = 13
            Caption = 'Штрих-код'
          end
          object cmbxNPostPay_Have: TComboBox
            Left = 100
            Top = 3
            Width = 121
            Height = 21
            BevelKind = bkFlat
            Style = csDropDownList
            ItemHeight = 13
            ItemIndex = 0
            TabOrder = 0
            Text = 'Все'
            OnChange = aValueFieldChangeExecute
            Items.Strings = (
              'Все'
              'Есть'
              'Нет')
          end
          object edNPostPay_BarCode: TEdit
            Left = 294
            Top = 2
            Width = 140
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            MaxLength = 20
            TabOrder = 1
            OnChange = aValueFieldChangeExecute
          end
        end
        object Panel1: TPanel
          Left = 0
          Top = 27
          Width = 573
          Height = 71
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object Panel3: TPanel
            Left = 0
            Top = 0
            Width = 120
            Height = 71
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 0
            object Label10: TLabel
              Left = 8
              Top = 25
              Width = 6
              Height = 13
              Caption = 'с'
            end
            object Label11: TLabel
              Left = 4
              Top = 47
              Width = 12
              Height = 13
              Caption = 'по'
            end
            object Label14: TLabel
              Left = 6
              Top = 2
              Width = 80
              Height = 13
              Caption = 'Сумма платежа'
            end
            object edNPostPay_SumFrom: TEdit
              Tag = 10
              Left = 19
              Top = 18
              Width = 90
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              TabOrder = 0
              OnChange = aEdSumExecute
              OnExit = aEdSumExecute
            end
            object edNPostPay_SumTo: TEdit
              Tag = 11
              Left = 19
              Top = 40
              Width = 90
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              TabOrder = 1
              OnChange = aEdSumExecute
              OnExit = aEdSumExecute
            end
          end
          object Panel4: TPanel
            Left = 280
            Top = 0
            Width = 160
            Height = 71
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 1
            object Label15: TLabel
              Left = 8
              Top = 26
              Width = 6
              Height = 13
              Caption = 'с'
            end
            object Label16: TLabel
              Left = 4
              Top = 48
              Width = 12
              Height = 13
              Caption = 'по'
            end
            object Label17: TLabel
              Left = 6
              Top = 2
              Width = 77
              Height = 13
              Caption = 'Дата создания'
            end
            object edNPostPay_CreateDateBegin: TEdit
              Tag = 50
              Left = 19
              Top = 18
              Width = 130
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              ReadOnly = True
              TabOrder = 0
              OnChange = aValueFieldChangeExecute
              OnDblClick = aSlDateExecute
            end
            object edNPostPay_CreateDateEnd: TEdit
              Tag = 51
              Left = 19
              Top = 40
              Width = 130
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              ReadOnly = True
              TabOrder = 1
              OnChange = aValueFieldChangeExecute
              OnDblClick = aSlDateExecute
            end
            object btnNPostPay_CreateDateBegin: TButton
              Tag = 50
              Left = 128
              Top = 20
              Width = 19
              Height = 17
              Action = aSlDate
              TabOrder = 2
            end
            object btnNPostPay_CreateDateEnd: TButton
              Tag = 51
              Left = 128
              Top = 42
              Width = 19
              Height = 17
              Action = aSlDate
              TabOrder = 3
            end
          end
          object Panel5: TPanel
            Left = 120
            Top = 0
            Width = 160
            Height = 71
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 2
            object Label18: TLabel
              Left = 8
              Top = 26
              Width = 6
              Height = 13
              Caption = 'с'
            end
            object Label19: TLabel
              Left = 4
              Top = 48
              Width = 12
              Height = 13
              Caption = 'по'
            end
            object Label20: TLabel
              Left = 6
              Top = 2
              Width = 81
              Height = 13
              Caption = 'Дата получения'
            end
            object edNPostPay_RedeliveryDateBegin: TEdit
              Tag = 40
              Left = 19
              Top = 18
              Width = 130
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              ReadOnly = True
              TabOrder = 0
              OnChange = aValueFieldChangeExecute
              OnDblClick = aSlDateExecute
            end
            object edNPostPay_RedeliveryDateEnd: TEdit
              Tag = 41
              Left = 19
              Top = 40
              Width = 130
              Height = 21
              BevelKind = bkFlat
              BorderStyle = bsNone
              ReadOnly = True
              TabOrder = 1
              OnChange = aValueFieldChangeExecute
              OnDblClick = aSlDateExecute
            end
            object btnNPostPay_RedeliveryDateBegin: TButton
              Tag = 40
              Left = 128
              Top = 20
              Width = 19
              Height = 17
              Action = aSlDate
              TabOrder = 2
            end
            object btnNPostPay_RedeliveryDateEnd: TButton
              Tag = 41
              Left = 128
              Top = 42
              Width = 19
              Height = 17
              Action = aSlDate
              TabOrder = 3
            end
          end
        end
      end
    end
  end
  object Actions: TActionList
    Images = FCCenterJournalNetZkz.imgMain
    Left = 538
    Top = 25
    object aControl_Ok: TAction
      Category = 'Control'
      Caption = 'Отобрать'
      ImageIndex = 180
      ShortCut = 13
      OnExecute = aControl_OkExecute
    end
    object aControl_Clear: TAction
      Category = 'Control'
      Caption = 'Очистить'
      ImageIndex = 181
      OnExecute = aControl_ClearExecute
    end
    object aControl_Close: TAction
      Category = 'Control'
      Caption = 'Закрыть'
      ImageIndex = 11
      ShortCut = 27
      OnExecute = aControl_CloseExecute
    end
    object aValueFieldChange: TAction
      Category = 'Control'
      Caption = 'aValueFieldChange'
      OnExecute = aValueFieldChangeExecute
    end
    object aSlShipping: TAction
      Category = 'Control'
      Caption = '…'
      OnExecute = aSlShippingExecute
    end
    object aSlAllNameClient: TAction
      Category = 'Control'
      Caption = '…'
      OnExecute = aSlAllNameClientExecute
    end
    object aSlPhoneClient: TAction
      Category = 'Control'
      Caption = '…'
      OnExecute = aSlPhoneClientExecute
    end
    object aSlAdresClient: TAction
      Category = 'Control'
      Caption = '…'
      OnExecute = aSlAdresClientExecute
    end
    object aSlPharmacy: TAction
      Category = 'Control'
      Caption = '…'
      OnExecute = aSlPharmacyExecute
    end
    object aSlGeoGroupPharm: TAction
      Category = 'Control'
      Caption = '…'
      OnExecute = aSlGeoGroupPharmExecute
    end
    object aSlMarkOtherUser: TAction
      Category = 'Control'
      Caption = '…'
      OnExecute = aSlMarkOtherUserExecute
    end
    object aSlCity: TAction
      Category = 'Control'
      Caption = '…'
      OnExecute = aSlCityExecute
    end
    object aSlSNPOST_StateName: TAction
      Category = 'Control'
      Caption = '…'
      OnExecute = aSlSNPOST_StateNameExecute
    end
    object aSlPayment: TAction
      Category = 'Control'
      Caption = '…'
      OnExecute = aSlPaymentExecute
    end
    object aSlDate: TAction
      Category = 'Control'
      Caption = '…'
      OnExecute = aSlDateExecute
    end
    object aEdSum: TAction
      Category = 'Control'
      Caption = 'aEdSum'
      OnExecute = aEdSumExecute
    end
    object aTabCheckJournal: TAction
      Category = 'TabCheck'
      AutoCheck = True
      Caption = 'Реквизиты заказа'
      Checked = True
      GroupIndex = 1
      ImageIndex = 18
      OnExecute = aTabCheckExecute
    end
    object aTabCheckOrder: TAction
      Category = 'TabCheck'
      AutoCheck = True
      Caption = 'Состав заказа'
      GroupIndex = 1
      ImageIndex = 272
      OnExecute = aTabCheckExecute
    end
    object aTabCheckHistory: TAction
      Category = 'TabCheck'
      AutoCheck = True
      Caption = 'История операций'
      GroupIndex = 1
      ImageIndex = 174
      OnExecute = aTabCheckExecute
    end
    object aTabCheckPay: TAction
      Category = 'TabCheck'
      AutoCheck = True
      Caption = 'Платежи'
      GroupIndex = 1
      ImageIndex = 270
      OnExecute = aTabCheckExecute
    end
    object aTabCheckNPostPay: TAction
      Category = 'TabCheck'
      AutoCheck = True
      Caption = 'Наложенные платежи'
      GroupIndex = 1
      ImageIndex = 368
      OnExecute = aTabCheckExecute
    end
    object aTabCheck: TAction
      Category = 'TabCheck'
      Caption = 'aTabCheck'
      OnExecute = aTabCheckExecute
    end
  end
  object pmTab: TPopupMenu
    Images = FCCenterJournalNetZkz.imgMain
    Left = 492
    Top = 25
    object pmiTabCheckJournal: TMenuItem
      Action = aTabCheckJournal
      AutoCheck = True
    end
    object pmiTabCheckOrder: TMenuItem
      Action = aTabCheckOrder
      AutoCheck = True
    end
    object pmiTabCheckHistory: TMenuItem
      Action = aTabCheckHistory
      AutoCheck = True
    end
    object pmiTabCheckPay: TMenuItem
      Action = aTabCheckPay
      AutoCheck = True
    end
    object pmiTabCheckNPostPay: TMenuItem
      Action = aTabCheckNPostPay
      AutoCheck = True
    end
  end
end
