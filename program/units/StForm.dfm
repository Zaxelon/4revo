object StatistForm: TStatistForm
  Left = 1011
  Top = 593
  Width = 416
  Height = 312
  Caption = #1047#1072#1095#1080#1089#1083#1077#1085#1086
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 400
    Height = 250
    DataSource = CoNSQL.DataSource3
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 160
    Top = 248
    Width = 75
    Height = 25
    Caption = #1057#1073#1088#1086#1089
    TabOrder = 1
    OnClick = Button1Click
  end
end
