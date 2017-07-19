inherited BPCtxFrame: TBPCtxFrame
  inherited PanelTop: TPanel
    inherited PanelFastFilter: TPanel
      Width = 489
      object Label1: TLabel [1]
        Left = 344
        Top = 10
        Width = 15
        Height = 13
        Caption = #1041#1055
      end
      object lcBP: TDBLookupComboBox
        Left = 365
        Top = 6
        Width = 118
        Height = 21
        KeyField = 'Id'
        ListField = 'Name'
        ListSource = dsCtxBP
        TabOrder = 3
        OnKeyDown = lcBPKeyDown
      end
    end
    inherited PanelActions: TPanel
      Left = 753
    end
  end
  object dsCtxBP: TDataSource
    Left = 704
    Top = 24
  end
end
