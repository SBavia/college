object Form1: TForm1
  Left = 226
  Top = 186
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1055#1072#1088#1085#1099#1077' '#1082#1072#1088#1090#1080#1085#1082#1080
  ClientHeight = 209
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnMouseDown = FormMouseDown
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 8
    Top = 40
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 8
    object N1: TMenuItem
      Caption = #1052#1077#1085#1102
      object N4: TMenuItem
        Caption = #1053#1086#1074#1072#1103' '#1080#1075#1088#1072
        OnClick = N4Click
      end
      object N5: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = N5Click
      end
    end
    object N2: TMenuItem
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
      object N3: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1077#1083#1100
        OnClick = N3Click
      end
    end
  end
end
