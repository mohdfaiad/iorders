object dmJSO: TdmJSO
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Left = 195
  Top = 398
  Height = 546
  Width = 786
  object dsJSOPayTransaction: TDataSource
    DataSet = qrspPayTransaction
    Left = 48
    Top = 18
  end
  object qrspPayTransaction: TADOStoredProc
    Connection = Form1.ADOC_STAT
    CursorType = ctStatic
    CommandTimeout = 100
    ProcedureName = 'pDS_jso_PayTransaction;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@orderId'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = 0
      end>
    Left = 168
    Top = 16
    object qrspPayTransactionExtPaySystem: TIntegerField
      FieldName = 'ExtPaySystem'
      Visible = False
    end
    object qrspPayTransactionSExtPaySystem: TStringField
      DisplayLabel = #1055#1083#1072#1090'. '#1089#1080#1089#1090'.'
      DisplayWidth = 10
      FieldName = 'SExtPaySystem'
      ReadOnly = True
      Size = 50
    end
    object qrspPayTransactionExtSystem: TIntegerField
      FieldName = 'ExtSystem'
      Visible = False
    end
    object qrspPayTransactionSExtSystem: TStringField
      DisplayLabel = #1042#1085#1077#1096'. '#1089#1080#1089#1090'.'
      DisplayWidth = 10
      FieldName = 'SExtSystem'
      ReadOnly = True
      Size = 50
    end
    object qrspPayTransactionExtPaySysId: TIntegerField
      FieldName = 'ExtPaySysId'
      Visible = False
    end
    object qrspPayTransactionExtTypeName: TStringField
      DisplayLabel = #1058#1080#1087' '#1090#1088#1072#1085#1079'.'
      DisplayWidth = 20
      FieldName = 'ExtTypeName'
      ReadOnly = True
      Size = 50
    end
    object qrspPayTransactionExtStatusName: TStringField
      DisplayLabel = #1057#1090#1072#1090#1091#1089' '#1090#1088#1072#1085#1079'.'
      DisplayWidth = 20
      FieldName = 'ExtStatusName'
      ReadOnly = True
      Size = 50
    end
    object qrspPayTransactionExtAmountBase: TBCDField
      DisplayLabel = #1057#1091#1084#1084#1072
      DisplayWidth = 10
      FieldName = 'ExtAmountBase'
      DisplayFormat = '0.00'
      Precision = 18
      Size = 2
    end
    object qrspPayTransactionExtCurr: TStringField
      DisplayLabel = #1042#1072#1083#1102#1090#1072
      FieldName = 'ExtCurr'
      Size = 10
    end
    object qrspPayTransactionExtDateIns: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1042#1085#1077#1096'.'
      FieldName = 'ExtDateIns'
    end
    object qrspPayTransactionDateIns: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072
      FieldName = 'DateIns'
    end
    object qrspPayTransactionExtDateUpd: TDateTimeField
      FieldName = 'ExtDateUpd'
      Visible = False
    end
    object qrspPayTransactionSignProcessed: TStringField
      FieldName = 'SignProcessed'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qrspPayTransactionSignProcessedName: TStringField
      DisplayLabel = #1057#1090#1072#1090#1091#1089
      DisplayWidth = 8
      FieldName = 'SignProcessedName'
      ReadOnly = True
      Size = 50
    end
    object qrspPayTransactionDateExec: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1086#1073#1088#1072#1073'.'
      FieldName = 'DateExec'
    end
    object qrspPayTransactionIErr: TIntegerField
      DisplayLabel = 'ID '#1086#1096#1080#1073'.'
      FieldName = 'IErr'
    end
    object qrspPayTransactionMsgExec: TStringField
      DisplayLabel = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077' '#1086#1073#1088#1072#1073#1086#1090#1082#1080
      DisplayWidth = 50
      FieldName = 'MsgExec'
      Size = 100
    end
    object qrspPayTransactionid: TLargeintField
      FieldName = 'id'
    end
    object qrspPayTransactionExtId: TIntegerField
      DisplayLabel = 'ID '#1042#1085#1077#1096'.'
      FieldName = 'ExtId'
    end
    object qrspPayTransactionExtOrderId: TIntegerField
      DisplayLabel = #1042#1085#1077#1096'. '#1079#1072#1082#1072#1079
      FieldName = 'ExtOrderId'
    end
    object qrspPayTransactionPhase: TIntegerField
      DisplayLabel = #1044#1086#1089#1090'.'
      DisplayWidth = 8
      FieldName = 'Phase'
      ReadOnly = True
      Visible = False
    end
    object qrspPayTransactionExtType: TStringField
      DisplayLabel = #1058#1080#1087' '#1090#1088#1072#1085#1079'. '#1074#1085#1077#1096'.'
      DisplayWidth = 15
      FieldName = 'ExtType'
    end
    object qrspPayTransactionExtStatus: TStringField
      DisplayLabel = #1057#1090#1072#1090#1091#1089' '#1090#1088#1072#1085#1079'. '#1074#1085#1077#1096'.'
      DisplayWidth = 15
      FieldName = 'ExtStatus'
    end
  end
  object qrExtSystem: TADOQuery
    Connection = Form1.ADOC_STAT
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * '
      '  from dbo.v_Ext_System with(nolock) '
      'order by ExtSystem')
    Left = 168
    Top = 64
    object qrExtSystemExtSystem: TBCDField
      DisplayLabel = 'ID'
      DisplayWidth = 8
      FieldName = 'ExtSystem'
      Precision = 18
      Size = 0
    end
    object qrExtSystemName: TStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      DisplayWidth = 25
      FieldName = 'Name'
      Size = 255
    end
    object qrExtSystemPrefix: TStringField
      DisplayLabel = #1055#1088#1077#1092#1080#1082#1089
      FieldName = 'Prefix'
      ReadOnly = True
      Size = 10
    end
  end
  object dsExtSystem: TDataSource
    DataSet = qrExtSystem
    Left = 72
    Top = 64
  end
  object qrPayTransStatus: TADOQuery
    Connection = Form1.ADOC_STAT
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select *'
      '  from dbo.v_PayTransStatus s with(nolock)'
      'order by s.id ')
    Left = 168
    Top = 120
    object qrPayTransStatusid: TBCDField
      DisplayLabel = 'ID'
      DisplayWidth = 8
      FieldName = 'id'
      Precision = 18
      Size = 0
    end
    object qrPayTransStatusName: TStringField
      DisplayLabel = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      DisplayWidth = 10
      FieldName = 'Name'
      Size = 255
    end
    object qrPayTransStatusCode: TStringField
      DisplayLabel = #1050#1086#1076
      DisplayWidth = 5
      FieldName = 'Code'
      Size = 255
    end
    object qrPayTransStatusFullName: TStringField
      DisplayLabel = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      DisplayWidth = 15
      FieldName = 'FullName'
      Size = 255
    end
  end
  object dsPayTransStatus: TDataSource
    DataSet = qrPayTransStatus
    Left = 72
    Top = 120
  end
  object spAddIntoQueue: TADOStoredProc
    Connection = Form1.ADOC_STAT
    ProcedureName = 'p_jso_AddIntoQueue;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@ObjId'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@TypeObj'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Action'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = Null
      end
      item
        Name = '@ObjStatusId'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@QueueId'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@ErrMsg'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 1000
        Value = Null
      end
      item
        Name = '@Param1'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end
      item
        Name = '@Param2'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end
      item
        Name = '@Param3'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end
      item
        Name = '@Param4'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end
      item
        Name = '@Param5'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end
      item
        Name = '@Param6'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end
      item
        Name = '@Param7'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end
      item
        Name = '@Param8'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end
      item
        Name = '@Param9'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end
      item
        Name = '@Param10'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end
      item
        Name = '@DoCheckAlreadyInQueue'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@UserIns'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 72
    Top = 184
  end
  object spCloseQueue: TADOStoredProc
    Connection = Form1.ADOC_STAT
    ProcedureName = 'p_jso_CloseQueue;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@ObjId'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@TypeObj'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Action'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = Null
      end
      item
        Name = '@UserId'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@ErrMsg'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 1000
        Value = Null
      end
      item
        Name = '@DoCheckExecuting'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 176
    Top = 184
  end
  object spLastOrderOpenAction: TADOStoredProc
    Connection = Form1.ADOC_STAT
    ProcedureName = 'p_jso_LastOpenOrderAction;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@orderID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@HistoryId'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@ErrMsg'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 1000
        Value = Null
      end>
    Left = 72
    Top = 248
  end
  object qrOrderAddFields: TADOQuery
    Connection = Form1.ADOC_STAT
    Parameters = <
      item
        Name = 'OrderId'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 0
      end>
    SQL.Strings = (
      'select SNote, SOrderComment'
      '  from dbo.v_Orders_Site with(nolock)'
      'where orderId = :orderId')
    Left = 184
    Top = 248
  end
  object qrOrderHAddFields: TADOQuery
    Connection = Form1.ADOC_STAT
    Parameters = <
      item
        Name = 'OrderId'
        DataType = ftInteger
        Value = 0
      end>
    SQL.Strings = (
      'select dbo.f_jso_GetHistoryComments(o.orderId, 1) HExecMsg, '
      '          dbo.f_jso_GetHistoryComments(o.orderId, 0) HComments'
      '  from dbo.v_Orders_Site o with(nolock)'
      'where o.orderId = :orderId')
    Left = 184
    Top = 304
  end
  object spCanDoOrderAction: TADOStoredProc
    Connection = Form1.ADOC_STAT
    ProcedureName = 'p_jso_CanDoOrderAction;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@orderID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@ActionCode'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = Null
      end
      item
        Name = '@HistoryId'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@ErrMsg'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 1000
        Value = Null
      end>
    Left = 280
    Top = 16
  end
end
