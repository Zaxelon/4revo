object MainUserForm: TMainUserForm
  Left = 215
  Top = 278
  BorderStyle = bsSingle
  Caption = 'RapidZ'
  ClientHeight = 542
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 7
    Top = 0
    Width = 91
    Height = 24
    Caption = #1060#1072#1084#1080#1083#1080#1103' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 24
    Width = 785
    Height = 521
    DataSource = CoNSQL.DataSource2
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnKeyDown = DBGrid1KeyDown
    OnTitleClick = DBGrid1TitleClick
  end
  object Edit1: TEdit
    Left = 112
    Top = 0
    Width = 121
    Height = 21
    TabOrder = 1
    Visible = False
    OnChange = Edit1Change
  end
  object MainMenu1: TMainMenu
    object RapidZ1: TMenuItem
      Caption = 'RapidZ'
      object N10: TMenuItem
        Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100'...'
        OnClick = N10Click
      end
      object N5: TMenuItem
        Caption = #1042#1099#1093#1086#1076' '#1080#1079' '#1091#1095'. '#1079#1072#1087#1080#1089#1080
        OnClick = N5Click
      end
      object N1: TMenuItem
        Caption = #1047#1072#1082#1088#1099#1090#1100
        OnClick = N1Click
      end
    end
    object Npravka: TMenuItem
      Caption = #1055#1088#1072#1074#1082#1072
      Visible = False
      object N2: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        OnClick = N2Click
      end
      object N3: TMenuItem
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
        OnClick = N3Click
      end
      object N26: TMenuItem
        Caption = #1043#1077#1085#1077#1088#1072#1094#1080#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
        object N27: TMenuItem
          Caption = #1047#1072#1103#1074#1083#1077#1085#1080#1077
          OnClick = N27Click
        end
        object N28: TMenuItem
          Caption = #1056#1072#1089#1087#1080#1089#1082#1072
          OnClick = N28Click
        end
      end
    end
    object Nsee: TMenuItem
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088
      Visible = False
      object N8: TMenuItem
        Caption = #1057#1087#1080#1089#1086#1082' '#1072#1073#1080#1090#1091#1088#1080#1077#1085#1090#1086#1074
        object N9: TMenuItem
          Caption = #1087#1086' '#1073#1072#1083#1083#1091' '#1072#1090#1090#1077#1089#1090#1072#1090#1072
          OnClick = N9Click
        end
        object N12: TMenuItem
          Caption = #1087#1086#1089#1090#1091#1087#1080#1074#1096#1080#1093' '#1087#1086' '#1089#1087#1077#1094'. ('#1089' '#1086#1090#1095#1077#1090#1086#1084')'
          OnClick = N12Click
        end
        object N13: TMenuItem
          Caption = #1089' '#1087#1086#1083#1091#1087#1088#1086#1093#1086#1076#1085#1099#1084' '#1073#1072#1083#1083#1086#1084' '#1087#1086' '#1089#1087#1077#1094' ('#1089' '#1086#1090#1095#1077#1090#1086#1084')'
          OnClick = N13Click
        end
        object N14: TMenuItem
          Caption = #1085#1077' '#1087#1086#1089#1090#1091#1087#1080#1074#1096#1080#1093' ('#1089' '#1086#1090#1095#1077#1090#1086#1084')'
          OnClick = N14Click
        end
      end
      object N4: TMenuItem
        Caption = #1055#1088#1086#1093#1086#1076#1085#1086#1081' '#1073#1072#1083#1083
        OnClick = N4Click
      end
      object N22: TMenuItem
        Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
        OnClick = N22Click
      end
      object N6: TMenuItem
        Caption = #1041#1086#1083#1100#1096#1077' '#1076#1072#1085#1085#1099#1093'...'
        OnClick = N6Click
      end
    end
    object Nstar_sekt: TMenuItem
      Caption = #1057#1090#1072#1088#1096#1080#1081' '#1089#1077#1082#1088#1077#1090#1072#1088#1100
      Visible = False
      object Nspec: TMenuItem
        Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1080
        Checked = True
        GroupIndex = 1
        RadioItem = True
        OnClick = NspecClick
      end
      object Ndoc: TMenuItem
        Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099' '#1076#1083#1103' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103
        GroupIndex = 1
        RadioItem = True
        OnClick = NdocClick
      end
    end
    object Nstar_admin: TMenuItem
      Caption = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088
      Visible = False
      object N40: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
        OnClick = N40Click
      end
      object N41: TMenuItem
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1090#1077#1083#1103
        OnClick = N41Click
      end
    end
  end
end
