object Atest_form: TAtest_form
  Left = 328
  Top = 288
  Width = 343
  Height = 207
  Caption = #1040#1090#1077#1089#1090#1072#1090
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 140
    Height = 21
    Caption = #1053#1086#1084#1077#1088' '#1072#1090#1090#1077#1089#1090#1072#1090#1072' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 162
    Height = 21
    Caption = #1059#1095#1077#1073#1085#1086#1077' '#1079#1072#1074#1077#1076#1077#1085#1080#1077' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 8
    Top = 56
    Width = 104
    Height = 21
    Caption = #1057' '#1086#1090#1083#1080#1095#1080#1077#1084' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 80
    Width = 121
    Height = 21
    Caption = #1057#1088#1077#1076#1085#1080#1081' '#1073#1072#1083#1083' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 104
    Width = 110
    Height = 21
    Caption = #1044#1072#1090#1072' '#1074#1099#1076#1072#1095#1080' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 120
    Top = 168
    Width = 91
    Height = 21
    Caption = #1055#1088#1077#1076#1084#1077#1090#1099' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Button2: TButton
    Left = 128
    Top = 136
    Width = 75
    Height = 25
    Caption = #1043#1086#1090#1086#1074#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = Button2Click
  end
  object StringGrid1: TStringGrid
    Left = 32
    Top = 200
    Width = 256
    Height = 257
    ColCount = 2
    DefaultRowHeight = 20
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 1
    Visible = False
    OnKeyPress = StringGrid1KeyPress
  end
  object Edit1: TEdit
    Left = 184
    Top = 8
    Width = 121
    Height = 23
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    MaxLength = 6
    ParentFont = False
    TabOrder = 2
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 184
    Top = 32
    Width = 121
    Height = 23
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    MaxLength = 30
    ParentFont = False
    TabOrder = 3
  end
  object CheckBox1: TCheckBox
    Left = 184
    Top = 56
    Width = 17
    Height = 17
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object Edit5: TDateTimePicker
    Left = 184
    Top = 104
    Width = 121
    Height = 23
    Date = 0.663664791667542900
    Time = 0.663664791667542900
    TabOrder = 5
  end
  object Edit3: TEdit
    Left = 184
    Top = 80
    Width = 121
    Height = 23
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    MaxLength = 4
    ParentFont = False
    TabOrder = 6
    OnKeyPress = Edit3KeyPress
  end
end
