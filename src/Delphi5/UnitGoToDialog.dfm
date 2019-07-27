object _FormGoToDialog: T_FormGoToDialog
  Left = 196
  Top = 129
  BorderStyle = bsDialog
  Caption = 'Go to ...'
  ClientHeight = 122
  ClientWidth = 254
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
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonGoToNuclide: TButton
    Left = 24
    Top = 92
    Width = 85
    Height = 25
    Caption = 'Go to Nuclide'
    ModalResult = 10
    TabOrder = 0
  end
  object ButtonCancel: TButton
    Left = 172
    Top = 92
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object GroupBoxZnum: TGroupBox
    Left = 0
    Top = 0
    Width = 254
    Height = 44
    Align = alTop
    Caption = 'Go to Element '
    TabOrder = 2
    object EditZnum: TComboBox
      Left = 16
      Top = 15
      Width = 100
      Height = 22
      Style = csDropDownList
      DropDownCount = 13
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      TabOrder = 0
      OnKeyUp = EditZnumKeyUp
    end
    object ButtonGoToZnum: TButton
      Left = 132
      Top = 14
      Width = 75
      Height = 25
      Caption = 'Go'
      ModalResult = 1
      TabOrder = 1
    end
  end
  object GroupBoxGoToAmass: TGroupBox
    Left = 0
    Top = 44
    Width = 254
    Height = 44
    Align = alTop
    Caption = 'Go to Atom Masses'
    TabOrder = 3
    object EditAmass: TSpinEdit
      Left = 16
      Top = 15
      Width = 100
      Height = 22
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxValue = 275
      MinValue = 1
      ParentFont = False
      TabOrder = 0
      Value = 1
      OnKeyUp = EditAmassKeyUp
    end
    object ButtonGoToAmass: TButton
      Left = 132
      Top = 14
      Width = 75
      Height = 25
      Caption = 'Go'
      ModalResult = 6
      TabOrder = 1
    end
  end
end
