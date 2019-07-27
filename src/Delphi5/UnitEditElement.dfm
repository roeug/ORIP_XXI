object _FormEditElement: T_FormEditElement
  Left = 507
  Top = 398
  HelpContext = 20
  BorderStyle = bsToolWindow
  Caption = 'FormElement'
  ClientHeight = 142
  ClientWidth = 142
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF007777
    7777777777777777777777777777777777777777777777777777777777777777
    77777777777777777777777777777777777CC777777777777779977777777777
    77C77CC777777777799779777777777777C7777C777777779777797777777777
    77C77777C7777779777779777777777777C777777C7777977777797777777777
    777C777777C779777777977777777777777C7777111C97777777977777777777
    7777C7711119C77777797777777777777777C722229222222279777777777777
    72222201191F10C00722222777777772277777C19FF1000C0097777227777727
    7777770900110000C07777777277727777777090000F00000C77777777277727
    77777090000100FF0C77777772777772277779000F01100000C7777227777777
    7222290FF001111000C22227777777777777970000111F12227C777777777777
    77779777711FF117777C77777777777777797777771111777777C77777777777
    777977777779C7777777C777777777777797777777977C7777777C7777777777
    77977777797777C777777C7777777777779777779777777C77777C7777777777
    7797779977777777CC777C7777777777777999777777777777CCC77777777777
    7777777777777777777777777777777777777777777777777777777777777777
    7777777777777777777777777777777777777777777777777777777777770000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000002000000000000000000000000000000000
    00000000040000001C0000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  KeyPreview = True
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 20
    Top = 0
    Width = 40
    Height = 13
    Caption = 'Average'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 4
    Top = 20
    Width = 25
    Height = 13
    Hint = 'Atomic mass (Oxygen scale)'
    Caption = 'Mass'
    ParentShowHint = False
    ShowHint = False
  end
  object Label3: TLabel
    Left = 4
    Top = 60
    Width = 6
    Height = 13
    Hint = 'Capture Xsec (cross section)'
    Caption = 's'
    Font.Charset = SYMBOL_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Symbol'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
  end
  object Label4: TLabel
    Left = 10
    Top = 64
    Width = 5
    Height = 14
    Hint = 'Capture Xsec'
    Caption = 'a'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
  end
  object Label5: TLabel
    Left = 116
    Top = 64
    Width = 21
    Height = 13
    Caption = 'barn'
  end
  object Label6: TLabel
    Left = 112
    Top = 20
    Width = 20
    Height = 13
    Caption = 'amu'
    Visible = False
  end
  object Label7: TLabel
    Left = 4
    Top = 84
    Width = 6
    Height = 13
    Hint = 'Scattering Xsec'
    Caption = 's'
    Font.Charset = SYMBOL_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Symbol'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
  end
  object Label8: TLabel
    Left = 10
    Top = 88
    Width = 4
    Height = 14
    Hint = 'Scattering Xsec'
    Caption = 's'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
  end
  object Label9: TLabel
    Left = 116
    Top = 84
    Width = 21
    Height = 13
    Caption = 'barn'
  end
  object Label10: TLabel
    Left = 4
    Top = 104
    Width = 5
    Height = 13
    Hint = 'Average neutron langer decrease '#13#10'for a collisiion'
    Caption = 'x'
    Font.Charset = SYMBOL_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Symbol'
    Font.Style = []
    ParentFont = False
  end
  object Label11: TLabel
    Left = 4
    Top = 124
    Width = 11
    Height = 13
    Hint = 'Resonance integral'
    Caption = 'RI'
    ParentShowHint = False
    ShowHint = True
  end
  object Label12: TLabel
    Left = 12
    Top = 40
    Width = 5
    Height = 13
    Hint = 'Density'
    Caption = 'r'
    Font.Charset = SYMBOL_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Symbol'
    Font.Style = []
    ParentFont = False
  end
  object Label13: TLabel
    Left = 100
    Top = 40
    Width = 25
    Height = 13
    Caption = 'g/cm'
  end
  object Label14: TLabel
    Left = 126
    Top = 40
    Width = 5
    Height = 10
    Caption = '3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'Small Fonts'
    Font.Style = []
    ParentFont = False
  end
  object Label15: TLabel
    Left = 116
    Top = 124
    Width = 21
    Height = 13
    Caption = 'barn'
  end
  object EditAmassMean: TEdit
    Left = 40
    Top = 16
    Width = 69
    Height = 21
    Hint = 'Atomic mass (Oxygen scale)'
    TabOrder = 0
  end
  object EditSigmaA: TEdit
    Left = 16
    Top = 60
    Width = 97
    Height = 21
    Hint = 'Neutron capture Xsec (cross section)'
    TabOrder = 2
  end
  object EditSigmaS: TEdit
    Left = 16
    Top = 80
    Width = 97
    Height = 21
    Hint = 'Neutron scattering Xsec (cross section)'
    TabOrder = 3
  end
  object EditKsi: TEdit
    Left = 16
    Top = 100
    Width = 97
    Height = 21
    Hint = 'Neutron lethargy increase for a scattering'
    TabOrder = 4
  end
  object EditRI: TEdit
    Left = 16
    Top = 120
    Width = 97
    Height = 21
    Hint = 'Resonance integeral'
    TabOrder = 5
  end
  object EditRo: TEdit
    Left = 24
    Top = 36
    Width = 73
    Height = 21
    Hint = 'Density'
    TabOrder = 1
  end
end
