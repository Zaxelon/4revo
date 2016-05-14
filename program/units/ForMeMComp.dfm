object CoNSQL: TCoNSQL
  OldCreateOrder = False
  Left = 433
  Top = 791
  Height = 220
  Width = 462
  object ADOConnection1: TADOConnection
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
    LoadDesigner = True
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
  object SkinIsRough: TsSkinManager
    InternalSkins = <>
    MenuSupport.IcoLineSkin = 'ICOLINE'
    MenuSupport.ExtraLineFont.Charset = DEFAULT_CHARSET
    MenuSupport.ExtraLineFont.Color = clWindowText
    MenuSupport.ExtraLineFont.Height = -11
    MenuSupport.ExtraLineFont.Name = 'MS Sans Serif'
    MenuSupport.ExtraLineFont.Style = []
    SkinDirectory = 'D:\#wind\Desktop\prakt\lar\Course\git_hub\program\style'
    SkinName = 'Ubuntu'
    SkinInfo = '10'
    ThirdParty.ThirdEdits = 
      'TEdit'#13#10'TMemo'#13#10'TMaskEdit'#13#10'TLabeledEdit'#13#10'THotKey'#13#10'TListBox'#13#10'TCheck' +
      'ListBox'#13#10'TRichEdit'#13#10'TDateTimePicker'#13#10
    ThirdParty.ThirdButtons = 'TButton'#13#10
    ThirdParty.ThirdBitBtns = 'TBitBtn'#13#10
    ThirdParty.ThirdCheckBoxes = 'TCheckBox'#13#10'TRadioButton'#13#10'TGroupButton'#13#10
    ThirdParty.ThirdGroupBoxes = 'TGroupBox'#13#10'TRadioGroup'#13#10
    ThirdParty.ThirdListViews = 'TListView'#13#10
    ThirdParty.ThirdPanels = 'TPanel'#13#10
    ThirdParty.ThirdGrids = 'TStringGrid'#13#10'TDrawGrid'#13#10
    ThirdParty.ThirdTreeViews = 'TTreeView'#13#10
    ThirdParty.ThirdComboBoxes = 'TComboBox'#13#10'TColorBox'#13#10
    ThirdParty.ThirdWWEdits = ' '#13#10
    ThirdParty.ThirdVirtualTrees = ' '#13#10
    ThirdParty.ThirdGridEh = ' '#13#10
    ThirdParty.ThirdPageControl = 'TPageControl'#13#10
    ThirdParty.ThirdTabControl = 'TTabControl'#13#10
    ThirdParty.ThirdToolBar = 'TToolBar'#13#10
    ThirdParty.ThirdStatusBar = 'TStatusBar'#13#10
    ThirdParty.ThirdSpeedButton = 'TSpeedButton'#13#10
    ThirdParty.ThirdScrollControl = 'TScrollBox'#13#10
    ThirdParty.ThirdUpDown = 'TUpDown'#13#10
    ThirdParty.ThirdScrollBar = 'TScrollBar'#13#10
    ThirdParty.ThirdStaticText = 'TStaticText'#13#10
    ThirdParty.ThirdNativePaint = ' '#13#10
    Left = 392
    Top = 16
  end
end
