object _FormDecay: T_FormDecay
  Left = 1524
  Top = 105
  HelpContext = 110
  BorderStyle = bsDialog
  Caption = 'Decay'
  ClientHeight = 210
  ClientWidth = 203
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    00000000000000000000000000000000000CC000000000000009900000000000
    00C00CC000000000099009000000000000C0000C000000009000090000000000
    00C00000C0000009000009000000000000C000000C0000900000090000000000
    000C000000C009000000900000000000000C0000111C90000000900000000000
    0000C0011119C00000090000000000000000C022229222222209000000000000
    02222201191F10C00022222000000002200000C19FF1000C0090000220000020
    0000000900110000C00000000200020000000090000F00000C00000000200020
    00000090000100FF0C00000002000002200009000F01100000C0000220000000
    0222290FF001111000C22220000000000000900000111F12220C000000000000
    00009000011FF110000C00000000000000090000001111000000C00000000000
    000900000009C0000000C000000000000090000000900C0000000C0000000000
    00900000090000C000000C0000000000009000009000000C00000C0000000000
    0090009900000000CC000C0000000000000999000000000000CCC00000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFFFFFFFFFFE7FFE7FFD9FF9BFFDEFF7BFFDF7EFBFFDFBDFBFFEFD
    BF7FFEF07F7FFF607EFFFF4002FFF820041FE7C001E7DFC003FBBF8003FDDF80
    03FBE78005E7F8001C1FFF4002FFFF781EFFFEFC3F7FFEFE7F7FFDFDBFBFFDFB
    DFBFFDF7EFBFFDCFF3BFFE3FFC7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelT1_2: TLabel
    Left = 0
    Top = 0
    Width = 203
    Height = 13
    Align = alTop
    Alignment = taCenter
    Caption = 'Half life'
  end
  object Label1: TLabel
    Left = 2
    Top = 28
    Width = 34
    Height = 65
    Caption = 'After'#13#10#13#10#13#10#13#10'residue'
  end
  object EditT1_2RO: TLabel
    Left = 37
    Top = 13
    Width = 80
    Height = 20
    Hint = 'Half life'
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'EditT1_2RO'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
  end
  object Label2: TLabel
    Left = 16
    Top = 124
    Width = 37
    Height = 13
    Caption = 'Mass, g'
  end
  object Label3: TLabel
    Left = 8
    Top = 180
    Width = 49
    Height = 13
    Caption = 'Activity, Ci'
  end
  object SpeedButtonMassToActivity: TSpeedButton
    Left = 88
    Top = 148
    Width = 23
    Height = 22
    Hint = 'Mass to Activity'
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888088
      8880888888888088888088888880880000088888880008088808888880000080
      8088888888808880808888888880888080888888888088880888888888808888
      8888888888808888888880808080888888888080808088888888808080808888
      8888800080888888888888000088888888888888888888888888}
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButtonMassToActivityClick
  end
  object SpeedButtonActivityToMass: TSpeedButton
    Left = 152
    Top = 148
    Width = 23
    Height = 22
    Hint = 'Activity to Mass'
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      8888088888088888888808888800888888888000008088888888808880808888
      8888880808808888888888080880888888888808088088888888888088808888
      8888888888808888888888888000080808088888880008080808888888808808
      0808888888888800080888888888888000088888888888888888}
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButtonActivityToMassClick
  end
  object EditAnswer: TEdit
    Left = 45
    Top = 92
    Width = 124
    Height = 21
    TabStop = False
    AutoSize = False
    BorderStyle = bsNone
    CharCase = ecUpperCase
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 3
    Text = 'EDITANSWER'
    OnClick = EditAnswerClick
  end
  object TimeUnitComboBox: TComboBox
    Left = 84
    Top = 49
    Width = 69
    Height = 21
    Style = csDropDownList
    Color = clWhite
    DropDownCount = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 2
    OnChange = TimeUnitComboBoxChange
    Items.Strings = (
      'sec'
      'psec'
      'nsec'
      'mksec'
      'msec'
      'min'
      'hour'
      'day'
      'year')
  end
  object ComboBoxTimeUnitRO: TComboBox
    Left = 120
    Top = 13
    Width = 61
    Height = 21
    Style = csDropDownList
    Color = clBtnFace
    DropDownCount = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 0
    OnChange = ComboBoxTimeUnitROChange
    Items.Strings = (
      'sec'
      'psec'
      'nsec'
      'mksec'
      'msec'
      'min'
      'hour'
      'day'
      'year'
      'lambda')
  end
  object EditInterval: TEdit
    Left = 16
    Top = 49
    Width = 69
    Height = 21
    Hint = 'Half life'
    AutoSize = False
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnExit = EditIntervalExit
    OnKeyDown = EditIntervalKeyDown
    OnKeyPress = EditIntervalKeyPress
  end
  object EditMass_g: TEdit
    Left = 64
    Top = 120
    Width = 128
    Height = 21
    TabOrder = 4
    Text = '1'
    OnKeyDown = EditMass_gKeyDown
    OnKeyPress = EditMass_gKeyPress
  end
  object EditActivity_Ci: TEdit
    Left = 64
    Top = 176
    Width = 128
    Height = 21
    TabOrder = 5
    Text = '1'
    OnKeyDown = EditActivity_CiKeyDown
    OnKeyPress = EditActivity_CiKeyPress
  end
end
