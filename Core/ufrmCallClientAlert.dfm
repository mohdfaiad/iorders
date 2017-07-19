inherited frmCallClientAlert: TfrmCallClientAlert
  Width = 370
  Height = 280
  object PanelClient: TPanel [0]
    Left = 0
    Top = 41
    Width = 370
    Height = 211
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = True
    ParentColor = True
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 2
      Width = 63
      Height = 20
      Caption = '������'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 251
      Top = 53
      Width = 79
      Height = 13
      Caption = '��� ���������'
    end
    object Label3: TLabel
      Left = 7
      Top = 92
      Width = 168
      Height = 13
      Caption = '���������� ��������� (������)'
    end
    object Label4: TLabel
      Left = 8
      Top = 52
      Width = 63
      Height = 13
      Caption = '��� �������'
    end
    object Label6: TLabel
      Left = 272
      Top = 2
      Width = 84
      Height = 20
      Caption = '�� ������'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 128
      Top = 52
      Width = 71
      Height = 13
      Caption = '�����/������'
    end
    object edName: TEdit
      Left = 8
      Top = 25
      Width = 257
      Height = 26
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnChange = DataChange
    end
    object lcAppealType: TDBLookupComboBox
      Left = 251
      Top = 69
      Width = 110
      Height = 19
      Ctl3D = False
      KeyField = 'ValueNum'
      ListField = 'ValueStr'
      ListSource = dsAppealType
      ParentCtl3D = False
      TabOrder = 1
      OnCloseUp = DataChange
    end
    object MemoContent: TMemo
      Left = 8
      Top = 108
      Width = 353
      Height = 93
      Ctl3D = False
      Lines.Strings = (
        'MemoContent')
      ParentCtl3D = False
      ScrollBars = ssVertical
      TabOrder = 2
      OnChange = DataChange
    end
    object lcClientType: TDBLookupComboBox
      Left = 8
      Top = 69
      Width = 110
      Height = 19
      Color = clBtnFace
      Ctl3D = False
      KeyField = 'ValueNum'
      ListField = 'ValueStr'
      ListSource = dsClientType
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 3
      TabStop = False
      OnCloseUp = DataChange
    end
    object Edit1: TEdit
      Left = 272
      Top = 25
      Width = 89
      Height = 26
      Color = clScrollBar
      Ctl3D = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 4
      OnChange = DataChange
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 128
      Top = 69
      Width = 110
      Height = 19
      Color = clBtnFace
      Ctl3D = False
      KeyField = 'ValueNum'
      ListField = 'ValueStr'
      ListSource = dsClientType
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 5
      TabStop = False
      OnCloseUp = DataChange
    end
  end
  inherited PanelCaption: TPanel
    Width = 370
    TabOrder = 2
    inherited lbType: TLabel
      Width = 370
      Font.Height = -8
      ParentFont = False
    end
    inherited edCaption: TEdit
      Top = 8
      Width = 187
      Height = 33
      Font.Color = clPurple
      Font.Height = -24
    end
  end
  inherited PanelBottom: TPanel
    Top = 252
    Width = 370
    Height = 28
    DesignSize = (
      370
      28)
    object lbAppealCnt: TLabel [0]
      Left = 208
      Top = 3
      Width = 31
      Height = 20
      Alignment = taCenter
      Caption = '888'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnSave: TButton [1]
      Left = 263
      Top = 0
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '���������'
      TabOrder = 1
      Visible = False
      OnClick = btnSaveClick
    end
    object btnOrders: TButton [2]
      Left = 8
      Top = 0
      Width = 85
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = '�����. ������'
      Enabled = False
      TabOrder = 2
      OnClick = btnOrdersClick
    end
    object btnClient: TButton [3]
      Left = 98
      Top = 0
      Width = 85
      Height = 25
      Hint = '�������� �������'
      Anchors = [akLeft, akBottom]
      Caption = '����. �������'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    inherited btnAccept: TBitBtn
      Left = 264
      Top = 0
      Width = 94
      Caption = '�������'
    end
  end
  inherited spIncUserEnumerator: TADOStoredProc
    Left = 259
    Top = 8
  end
  inherited spSetUserRead: TADOStoredProc
    Left = 331
    Top = 8
  end
  object dsAppealType: TDataSource
    Left = 216
    Top = 8
  end
  object dsClientType: TDataSource
    Left = 296
    Top = 8
  end
end
