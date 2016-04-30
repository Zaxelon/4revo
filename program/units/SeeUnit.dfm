object SeeForm: TSeeForm
  Left = 309
  Top = 275
  Width = 560
  Height = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 7
    Top = 0
    Width = 146
    Height = 24
    Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1100':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 319
    Top = 0
    Width = 179
    Height = 24
    Caption = #1055#1077#1088#1074#1099#1084' '#1087#1088#1080#1086#1088#1080#1090#1077#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 9
    Top = 24
    Width = 107
    Height = 24
    Caption = #1063#1080#1089#1083#1086' '#1084#1077#1089#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 48
    Width = 529
    Height = 505
    DataSource = CoNSQL.DataSource3
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object ComboBox1: TComboBox
    Left = 160
    Top = 0
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    OnChange = ComboBox1Change
  end
  object CheckBox1: TCheckBox
    Left = 504
    Top = 4
    Width = 17
    Height = 17
    TabOrder = 2
    OnClick = CheckBox1Click
  end
  object SpinEdit1: TSpinEdit
    Left = 160
    Top = 24
    Width = 57
    Height = 22
    MaxValue = 100
    MinValue = 0
    ReadOnly = True
    TabOrder = 3
    Value = 0
    Visible = False
    OnChange = SpinEdit1Change
  end
  object Button1: TButton
    Left = 320
    Top = 26
    Width = 75
    Height = 20
    Caption = 'PRINT'
    TabOrder = 4
    OnClick = Button1Click
  end
  object MainMenu1: TMainMenu
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      Visible = False
      object N2: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      end
      object N3: TMenuItem
        Caption = #1055#1077#1095#1072#1090#1100
      end
    end
  end
end
