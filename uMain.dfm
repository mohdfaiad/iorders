object Form1: TForm1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 332
  Top = 173
  Height = 273
  Width = 276
  object ADOC_STAT: TADOConnection
    CommandTimeout = 80000
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=ckj#ktn#djc;Persist Security Info=T' +
      'rue;User ID=admin;Initial Catalog=WorkWith_Gamma;Data Source=192' +
      '.168.0.9\SQL5;Use Procedure for Prepare=1;Auto Translate=True;Pa' +
      'cket Size=4096;Use Encryption for Data=False;Tag with column col' +
      'lation when possible=False'
    ConnectionTimeout = 80000
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 50
    Top = 30
  end
  object spY_GetServerDate: TADOStoredProc
    Connection = ADOC_STAT
    CommandTimeout = 300
    ProcedureName = 'spY_GetServerDate;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end>
    Left = 138
    Top = 30
  end
end
