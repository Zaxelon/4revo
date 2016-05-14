object ProhForm: TProhForm
  Left = 446
  Top = 196
  Width = 375
  Height = 205
  Caption = #1055#1088#1086#1093#1086#1076#1085#1086#1081' '#1073#1072#1083#1083
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 7
    Top = 8
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
    Left = 7
    Top = 32
    Width = 177
    Height = 24
    Caption = #1055#1077#1088#1074#1099#1081' '#1087#1088#1080#1086#1088#1080#1090#1077#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 9
    Top = 58
    Width = 107
    Height = 24
    Caption = #1063#1080#1089#1083#1086' '#1084#1077#1089#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 9
    Top = 90
    Width = 152
    Height = 24
    Caption = #1055#1088#1086#1093#1086#1076#1085#1086#1081' '#1073#1072#1083#1083':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 209
    Top = 90
    Width = 5
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object ComboBox1: TComboBox
    Left = 208
    Top = 8
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = ComboBox1Change
  end
  object CheckBox1: TCheckBox
    Left = 208
    Top = 36
    Width = 17
    Height = 17
    TabOrder = 1
  end
  object Button1: TButton
    Left = 80
    Top = 128
    Width = 201
    Height = 33
    Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object SpinEdit1: TsSpinEdit
    Left = 208
    Top = 58
    Width = 57
    Height = 21
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
    Text = '0'
    MaxValue = 0
    MinValue = 0
    Value = 0
  end
end
