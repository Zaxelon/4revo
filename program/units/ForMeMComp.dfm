object CoNSQL: TCoNSQL
  OldCreateOrder = False
  Left = 347
  Top = 326
  Height = 220
  Width = 405
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=zaxelonorda;Persist Security Info=T' +
      'rue;User ID=sa;Initial Catalog=priemka;Data Source=ZAKURAT'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 104
    Top = 16
  end
  object ADOTable1: TADOTable
    Connection = ADOConnection1
    TableName = 'abiture'
    Left = 24
    Top = 16
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Enabled = False
    Left = 192
    Top = 16
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    DataSource = DataSource1
    Parameters = <>
    Left = 264
    Top = 16
  end
  object ADOQuery2: TADOQuery
    Connection = ADOConnection1
    DataSource = DataSource1
    Parameters = <>
    Left = 264
    Top = 72
  end
  object DataSource2: TDataSource
    DataSet = ADOQuery3
    Left = 192
    Top = 72
  end
  object ADOTable2: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = 'abiture'
    Left = 24
    Top = 72
  end
  object ADOQuery3: TADOQuery
    Connection = ADOConnection1
    BeforeInsert = ADOQuery3BeforeInsert
    Parameters = <>
    Left = 104
    Top = 72
  end
  object DataSource3: TDataSource
    DataSet = ADOQuery4
    Left = 24
    Top = 128
  end
  object ADOQuery4: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    Parameters = <>
    SQL.Strings = (
      
        'exec polu_proh  '#39#1048#1085#1092#1086#1088#1084#1072#1094#1080#1086#1085#1085#1072#1103' '#1073#1077#1079#1086#1087#1072#1089#1085#1086#1089#1090#1100' '#1072#1074#1090#1086#1084#1072#1090#1080#1079#1080#1088#1086#1074#1072#1085#1085#1099#1093' ' +
        #1089#1080#1089#1090#1077#1084#39',0,5')
    Left = 104
    Top = 128
  end
  object RvDataSetConnection1: TRvDataSetConnection
    FieldAliasList.Strings = (
      
        'exec polu_proh  '#39#1048#1085#1092#1086#1088#1084#1072#1094#1080#1086#1085#1085#1072#1103' '#1073#1077#1079#1086#1087#1072#1089#1085#1086#1089#1090#1100' '#1072#1074#1090#1086#1084#1072#1090#1080#1079#1080#1088#1086#1074#1072#1085#1085#1099#1093' ' +
        #1089#1080#1089#1090#1077#1084#39',0,4')
    RuntimeVisibility = rtDeveloper
    DataSet = ADOQuery4
    Left = 192
    Top = 128
  end
  object MyRave: TRvProject
    Left = 264
    Top = 128
  end
  object CheckRole: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 328
    Top = 16
  end
  object TempQuery: TADOQuery
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT name FROM document'
      'INNER JOIN documents ON document.numb_doc = documents.numb_doc '
      'WHERE id_statement = 1')
    Left = 328
    Top = 72
  end
  object RvDtStCoN2: TRvDataSetConnection
    FieldAliasList.Strings = (
      
        'exec polu_proh  '#39#1048#1085#1092#1086#1088#1084#1072#1094#1080#1086#1085#1085#1072#1103' '#1073#1077#1079#1086#1087#1072#1089#1085#1086#1089#1090#1100' '#1072#1074#1090#1086#1084#1072#1090#1080#1079#1080#1088#1086#1074#1072#1085#1085#1099#1093' ' +
        #1089#1080#1089#1090#1077#1084#39',0,4')
    RuntimeVisibility = rtDeveloper
    DataSet = TempQuery
    Left = 328
    Top = 128
  end
end
