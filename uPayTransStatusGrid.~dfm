inherited PayTransStatusGrid: TPayTransStatusGrid
  Width = 981
  inherited PanelTop: TPanel
    Width = 981
    inherited PanelActions: TPanel
      Left = 745
      Width = 192
      inherited ToolBar1: TToolBar
        Width = 192
      end
    end
    object PanelOwnFilter: TPanel
      Left = 608
      Top = 0
      Width = 137
      Height = 41
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 3
      object Label1: TLabel
        Left = 3
        Top = 9
        Width = 34
        Height = 13
        Caption = #1057#1090#1072#1090#1091#1089
      end
      object lcPayTransStatus: TDBLookupComboBox
        Left = 43
        Top = 6
        Width = 87
        Height = 21
        KeyField = 'Code'
        ListField = 'FullName'
        ListSource = dmJSO.dsPayTransStatus
        TabOrder = 0
        OnKeyDown = lcPayTransStatusKeyDown
      end
    end
  end
  inherited Grid: TDBGrid
    Width = 981
  end
end
