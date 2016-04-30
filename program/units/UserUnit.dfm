object Form4: TForm4
  Left = 799
  Top = 538
  Width = 265
  Height = 158
  Caption = 'Form4'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnHide = FormHide
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 46
    Height = 24
    Caption = #1048#1084#1103' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 32
    Width = 54
    Height = 24
    Caption = #1056#1086#1083#1100' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 56
    Width = 76
    Height = 24
    Caption = #1055#1072#1088#1086#1083#1100' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 0
    Top = 120
    Width = 109
    Height = 24
    Caption = #1057#1090'. '#1055#1072#1088#1086#1083#1100' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Edit1: TEdit
    Left = 96
    Top = 8
    Width = 145
    Height = 21
    MaxLength = 30
    TabOrder = 0
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 128
    Top = 128
    Width = 145
    Height = 21
    MaxLength = 30
    PasswordChar = #1035
    TabOrder = 1
    Visible = False
  end
  object Button1: TButton
    Left = 64
    Top = 86
    Width = 105
    Height = 25
    Caption = #1043#1086#1090#1086#1074#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object Edit3: TEdit
    Left = 96
    Top = 56
    Width = 145
    Height = 21
    MaxLength = 30
    PasswordChar = #1035
    TabOrder = 3
    OnKeyPress = Edit3KeyPress
  end
  object ComboBox1: TComboBox
    Left = 96
    Top = 32
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 4
    OnKeyPress = ComboBox1KeyPress
    Items.Strings = (
      'Secretar'
      'Star_secretar')
  end
end
