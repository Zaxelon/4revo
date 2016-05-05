object AddObweeForm: TAddObweeForm
  Left = 542
  Top = 338
  BorderStyle = bsSingle
  Caption = #1054#1073#1097#1077#1077
  ClientHeight = 242
  ClientWidth = 302
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
    Width = 81
    Height = 21
    Caption = #1060#1072#1084#1080#1083#1080#1103' :'
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
    Width = 43
    Height = 21
    Caption = #1048#1084#1103' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 56
    Width = 85
    Height = 21
    Caption = #1054#1090#1095#1077#1089#1090#1074#1086' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 80
    Width = 41
    Height = 21
    Caption = #1055#1086#1083' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 104
    Width = 131
    Height = 21
    Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 8
    Top = 128
    Width = 77
    Height = 21
    Caption = #1058#1077#1083#1077#1092#1086#1085' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 8
    Top = 152
    Width = 59
    Height = 21
    Caption = #1040#1076#1088#1077#1089' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 8
    Top = 176
    Width = 62
    Height = 21
    Caption = #1050#1091#1088#1089#1099' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 152
    Top = 8
    Width = 145
    Height = 23
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    MaxLength = 30
    ParentFont = False
    TabOrder = 0
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 152
    Top = 32
    Width = 145
    Height = 23
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    MaxLength = 20
    ParentFont = False
    TabOrder = 1
    OnKeyPress = Edit1KeyPress
  end
  object Edit3: TEdit
    Left = 152
    Top = 56
    Width = 145
    Height = 23
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    MaxLength = 30
    ParentFont = False
    TabOrder = 2
    OnKeyPress = Edit1KeyPress
  end
  object Edit6: TEdit
    Left = 152
    Top = 128
    Width = 145
    Height = 23
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    MaxLength = 11
    ParentFont = False
    TabOrder = 6
    OnKeyPress = Edit6KeyPress
  end
  object Edit7: TEdit
    Left = 152
    Top = 152
    Width = 145
    Height = 23
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    MaxLength = 70
    ParentFont = False
    TabOrder = 7
  end
  object RadioButton1: TRadioButton
    Tag = 1488
    Left = 152
    Top = 80
    Width = 33
    Height = 17
    Alignment = taLeftJustify
    Caption = #1052
    Checked = True
    TabOrder = 3
    TabStop = True
  end
  object RadioButton2: TRadioButton
    Tag = 1488
    Left = 240
    Top = 80
    Width = 33
    Height = 17
    Alignment = taLeftJustify
    Caption = #1046
    TabOrder = 4
  end
  object CheckBox1: TCheckBox
    Left = 152
    Top = 176
    Width = 17
    Height = 17
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object Button2: TButton
    Left = 112
    Top = 208
    Width = 75
    Height = 25
    Caption = #1043#1086#1090#1086#1074#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = Button2Click
  end
  object Edit5: TDateTimePicker
    Left = 152
    Top = 104
    Width = 145
    Height = 23
    Date = 0.663664791667542900
    Time = 0.663664791667542900
    TabOrder = 5
  end
end
