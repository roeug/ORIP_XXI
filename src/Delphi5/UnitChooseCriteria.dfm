object _FormChooseCriteria: T_FormChooseCriteria
  Left = 197
  Top = 108
  Width = 504
  Height = 499
  HelpContext = 120
  ActiveControl = GroupBoxAndOr
  BorderStyle = bsSizeToolWin
  Caption = 'Filter criteria'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFF777777FFFFFFFFFFFFFFFFFFFFFFFFFF700007FFFFFFFFFFFFFFFFF
    FFFFFFFFF702207FFFFFFFFFFFFFFFFFFFFFFFFFF702207FFFFFFFFFFFFFFFFF
    FFFFFFFFF702207FFFFFFFFFFFFFFFFFFFFFFFFFF702F07FFFFFFFFFFFFFFFFF
    FFFFFFFFF70FF07FFFFFFFFFFFFFFFFFFFFFFFFFF70FF07FFFFFFFFFFFFFFFFF
    FFFFFFF7770FF077FFFFFFFFFFFFFFFFFFFFFFF7000FF0007FFFFFFFFFFFFFFF
    FFFFFF77000FF0007FFFFFFFFFFFFFFFFFFF7770002FF200077FFFFFFFFFFFFF
    FFFF700022F222000007FFFFFFFFFFFFFF77700022F222000007FFFFFFFFFFFF
    F777000022F222220000777FFFFFFFFFF7000002FF2222220000007FFFFFFFFF
    77000002FF2222220000007FFFFFFF7770000222FF2222222000000777FFFF70
    0000222F222222222000000007FFFF700000222F222222222000000007FFFF70
    00000000000000000000000007FFFF7777777777777777777777777777FFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF81FFFFFF81FFFFFF8
    1FFFFFF81FFFFFF81FFFFFF81FFFFFF81FFFFFF81FFFFFE00FFFFFE007FFFFC0
    07FFFF0001FFFF0000FFFC0000FFF800001FF800001FF000001FC0000003C000
    0003C0000003C0000003C0000003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBoxZnum: TGroupBox
    Left = 0
    Top = 57
    Width = 496
    Height = 32
    Align = alTop
    Caption = '&Elements  (Z)  '
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 144
      Top = 12
      Width = 20
      Height = 13
      Caption = 'from'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 340
      Top = 12
      Width = 9
      Height = 13
      Caption = 'to'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object CheckBoxZnum: TCheckBox
      Left = 4
      Top = 14
      Width = 73
      Height = 16
      Caption = 'Recall'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clActiveCaption
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = CheckBoxClick
    end
    object EditZnum1: TComboBox
      Left = 200
      Top = 7
      Width = 80
      Height = 22
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      TabOrder = 1
      OnChange = EditZnum1Change
    end
    object EditZnum2: TComboBox
      Left = 368
      Top = 7
      Width = 81
      Height = 22
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      TabOrder = 2
      OnChange = EditZnum1Change
    end
  end
  object GroupBoxAndOr: TGroupBox
    Left = 0
    Top = 0
    Width = 496
    Height = 57
    Align = alTop
    Caption = '&Choice creteria interplay rule'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TabStop = True
    object SpeedButtonChoose: TSpeedButton
      Left = 392
      Top = 32
      Width = 97
      Height = 21
      Caption = '&Filter'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        2E060000424D2E06000000000000360400002800000015000000150000000100
        080000000000F801000000000000000000000001000000000000000000004000
        000080000000FF000000002000004020000080200000FF200000004000004040
        000080400000FF400000006000004060000080600000FF600000008000004080
        000080800000FF80000000A0000040A0000080A00000FFA0000000C0000040C0
        000080C00000FFC0000000FF000040FF000080FF0000FFFF0000000020004000
        200080002000FF002000002020004020200080202000FF202000004020004040
        200080402000FF402000006020004060200080602000FF602000008020004080
        200080802000FF80200000A0200040A0200080A02000FFA0200000C0200040C0
        200080C02000FFC0200000FF200040FF200080FF2000FFFF2000000040004000
        400080004000FF004000002040004020400080204000FF204000004040004040
        400080404000FF404000006040004060400080604000FF604000008040004080
        400080804000FF80400000A0400040A0400080A04000FFA0400000C0400040C0
        400080C04000FFC0400000FF400040FF400080FF4000FFFF4000000060004000
        600080006000FF006000002060004020600080206000FF206000004060004040
        600080406000FF406000006060004060600080606000FF606000008060004080
        600080806000FF80600000A0600040A0600080A06000FFA0600000C0600040C0
        600080C06000FFC0600000FF600040FF600080FF6000FFFF6000000080004000
        800080008000FF008000002080004020800080208000FF208000004080004040
        800080408000FF408000006080004060800080608000FF608000008080004080
        800080808000FF80800000A0800040A0800080A08000FFA0800000C0800040C0
        800080C08000FFC0800000FF800040FF800080FF8000FFFF80000000A0004000
        A0008000A000FF00A0000020A0004020A0008020A000FF20A0000040A0004040
        A0008040A000FF40A0000060A0004060A0008060A000FF60A0000080A0004080
        A0008080A000FF80A00000A0A00040A0A00080A0A000FFA0A00000C0A00040C0
        A00080C0A000FFC0A00000FFA00040FFA00080FFA000FFFFA0000000C0004000
        C0008000C000FF00C0000020C0004020C0008020C000FF20C0000040C0004040
        C0008040C000FF40C0000060C0004060C0008060C000FF60C0000080C0004080
        C0008080C000FF80C00000A0C00040A0C00080A0C000FFA0C00000C0C00040C0
        C00080C0C000FFC0C00000FFC00040FFC00080FFC000FFFFC0000000FF004000
        FF008000FF00FF00FF000020FF004020FF008020FF00FF20FF000040FF004040
        FF008040FF00FF40FF000060FF004060FF008060FF00FF60FF000080FF004080
        FF008080FF00FF80FF0000A0FF0040A0FF0080A0FF00FFA0FF0000C0FF0040C0
        FF0080C0FF00FFC0FF0000FFFF0040FFFF0080FFFF00FFFFFF00919191919191
        9191919191919191919191919191910000009191919191919191919191919191
        9191919191919100000091919191919191919191919191919191919191919100
        0000919191919191919191919191919191919191919191000000919191919191
        9191919191919191919191919191910000009191919191919191919191919191
        9191919191919100000091919191919191919191919191919191919191919100
        0000919191919191919191000000919191919191919191000000919191919191
        91919100FF0091919191919191919100000091919191919191919100FF009191
        9191919191919100000091919191919191910000FF0000919191919191919100
        000091919191919191000008FF08000091919191919191000000919191919191
        000008FF0808000000919191919191000000919191919100000008FF08080800
        000091919191910000009191919100000008FF08080808000000009191919100
        00009191910000000808FF080808080800000000919191000000919100000008
        08FF080808080808000000000091910000009191000000000000000000000000
        0000000000919100000091919191919191919191919191919191919191919100
        0000919191919191919191919191919191919191919191000000919191919191
        919191919191919191919191919191000000}
      ParentFont = False
      OnClick = SpeedButtonChooseClick
      OnMouseDown = SpeedButtonChooseMouseDown
    end
    object Label25: TLabel
      Left = 212
      Top = 4
      Width = 60
      Height = 13
      Caption = 'nuclide state'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object SpeedButton1: TSpeedButton
      Left = 392
      Top = 8
      Width = 97
      Height = 21
      Hint = 'Show the list without new filter settings'
      Caption = '&List'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButton1Click
    end
    object CheckBoxG: TCheckBox
      Left = 200
      Top = 18
      Width = 33
      Height = 16
      Caption = 'G'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 2
    end
    object CheckBoxM1: TCheckBox
      Left = 250
      Top = 18
      Width = 37
      Height = 16
      Caption = 'M1'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 3
    end
    object CheckBoxM2: TCheckBox
      Left = 300
      Top = 18
      Width = 37
      Height = 16
      Caption = 'M2'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 4
    end
    object CheckBoxClearList: TCheckBox
      Left = 272
      Top = 36
      Width = 109
      Height = 17
      Hint = 'Clear the list'
      Caption = 'Clear the list'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 5
    end
    object RadioButtonAND: TRadioButton
      Left = 16
      Top = 20
      Width = 41
      Height = 17
      Caption = 'AND'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
    end
    object RadioButtonOR: TRadioButton
      Left = 88
      Top = 20
      Width = 53
      Height = 17
      Caption = 'OR'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TabStop = True
    end
  end
  object GroupBoxAmass: TGroupBox
    Left = 0
    Top = 89
    Width = 496
    Height = 32
    Align = alTop
    Caption = '&Mass (amu)  '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label3: TLabel
      Left = 144
      Top = 12
      Width = 20
      Height = 13
      Caption = 'from'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 340
      Top = 12
      Width = 9
      Height = 13
      Caption = 'to'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object CheckBoxAmass: TCheckBox
      Left = 4
      Top = 14
      Width = 73
      Height = 16
      Caption = 'Recall'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clActiveCaption
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = CheckBoxClick
    end
    object EditAmass1: TSpinEdit
      Left = 200
      Top = 7
      Width = 80
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
      TabOrder = 1
      Value = 1
      OnChange = EditAmass1Change
    end
    object EditAmass2: TSpinEdit
      Left = 368
      Top = 7
      Width = 81
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
      TabOrder = 2
      Value = 1
      OnChange = EditAmass1Change
    end
  end
  object GroupBoxHalfLife: TGroupBox
    Left = 0
    Top = 121
    Width = 496
    Height = 32
    Align = alTop
    Caption = '&Half life '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object Label5: TLabel
      Left = 104
      Top = 12
      Width = 20
      Height = 13
      Caption = 'from'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 340
      Top = 12
      Width = 9
      Height = 13
      Caption = 'to'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object CheckBoxT1_2: TCheckBox
      Left = 4
      Top = 14
      Width = 57
      Height = 16
      Caption = 'Recall'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clActiveCaption
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = CheckBoxClick
    end
    object EditT1_2_1: TEdit
      Left = 160
      Top = 8
      Width = 57
      Height = 20
      AutoSize = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = '1'
      OnChange = EditT1_2_1Change
    end
    object EditT1_2_2: TEdit
      Left = 368
      Top = 8
      Width = 57
      Height = 20
      AutoSize = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Text = '10'
      OnChange = EditT1_2_1Change
    end
    object ComboBoxTimeUnit1: TComboBox
      Left = 216
      Top = 8
      Width = 65
      Height = 21
      Style = csDropDownList
      DropDownCount = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 2
      OnChange = EditT1_2_1Change
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
    object ComboBoxTimeUnit2: TComboBox
      Left = 424
      Top = 8
      Width = 69
      Height = 21
      Style = csDropDownList
      DropDownCount = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 4
      OnChange = EditT1_2_1Change
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
  end
  object GroupBoxDecayType: TGroupBox
    Left = 0
    Top = 153
    Width = 496
    Height = 32
    Align = alTop
    Caption = ' &Decay type '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object CheckBoxDecayType: TCheckBox
      Left = 8
      Top = 14
      Width = 73
      Height = 16
      Caption = 'Recall'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clActiveCaption
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = CheckBoxClick
    end
    object CheckBoxStable: TCheckBox
      Left = 76
      Top = 15
      Width = 101
      Height = 12
      Caption = 'STABLE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = CheckBoxStableClick
    end
    object CheckBoxAlpha: TCheckBox
      Left = 173
      Top = 15
      Width = 32
      Height = 12
      Caption = 'a'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Symbol'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = CheckBoxStableClick
    end
    object CheckBoxBeta: TCheckBox
      Left = 210
      Top = 15
      Width = 32
      Height = 12
      Caption = 'b'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Symbol'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = CheckBoxStableClick
    end
    object CheckBoxEC: TCheckBox
      Left = 247
      Top = 15
      Width = 28
      Height = 12
      Caption = 'e'
      Font.Charset = SYMBOL_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Symbol'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = CheckBoxStableClick
    end
    object CheckBoxSF: TCheckBox
      Left = 320
      Top = 15
      Width = 153
      Height = 12
      Caption = 'spontaneous fission'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = CheckBoxStableClick
    end
    object CheckBoxIT: TCheckBox
      Left = 283
      Top = 15
      Width = 33
      Height = 12
      Caption = 'IT'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = CheckBoxStableClick
    end
  end
  object GroupBoxGammaLine: TGroupBox
    Left = 0
    Top = 273
    Width = 496
    Height = 48
    Align = alTop
    Caption = ' &Gamma lines, MeV '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    object Label19: TLabel
      Left = 130
      Top = 12
      Width = 93
      Height = 13
      Alignment = taRightJustify
      Caption = 'There are lines from'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel
      Left = 344
      Top = 12
      Width = 56
      Height = 13
      Caption = 'probability >'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      Left = 238
      Top = 29
      Width = 5
      Height = 13
      Caption = 'g'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Symbol'
      Font.Style = []
      ParentFont = False
    end
    object Label29: TLabel
      Left = 276
      Top = 12
      Width = 9
      Height = 13
      Caption = 'to'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object CheckBoxGammaLineNull: TCheckBox
      Left = 92
      Top = 29
      Width = 85
      Height = 17
      Caption = 'Unknown'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object CheckBoxGammaLine: TCheckBox
      Left = 4
      Top = 16
      Width = 57
      Height = 17
      Caption = 'Recall'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clActiveCaption
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = CheckBoxClick
    end
    object EditGammaLine1: TEdit
      Left = 224
      Top = 8
      Width = 49
      Height = 20
      AutoSize = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = '0'
      OnChange = EditGammaLine1Change
    end
    object EditGammaLine2: TEdit
      Left = 291
      Top = 8
      Width = 49
      Height = 20
      AutoSize = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Text = '10'
      OnChange = EditGammaLine1Change
    end
    object CheckBoxNoGamma: TCheckBox
      Left = 205
      Top = 29
      Width = 33
      Height = 17
      Caption = 'No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object EditGammaProb: TEdit
      Left = 408
      Top = 8
      Width = 64
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = '1.0e-30'
      OnChange = EditGammaLine1Change
    end
  end
  object GroupBoxAlphaLine: TGroupBox
    Left = 0
    Top = 185
    Width = 496
    Height = 44
    Align = alTop
    Caption = ' &Alpha lines, MeV '
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 5
    object Label21: TLabel
      Left = 130
      Top = 12
      Width = 93
      Height = 13
      Alignment = taRightJustify
      Caption = 'There are lines from'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label22: TLabel
      Left = 276
      Top = 12
      Width = 9
      Height = 13
      Caption = 'to'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label27: TLabel
      Left = 344
      Top = 12
      Width = 56
      Height = 13
      Caption = 'probability >'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object CheckBoxAlphaLine: TCheckBox
      Left = 4
      Top = 16
      Width = 57
      Height = 17
      Caption = 'Recall'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clActiveCaption
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = CheckBoxClick
    end
    object EditAlphaLine1: TEdit
      Left = 224
      Top = 8
      Width = 49
      Height = 20
      AutoSize = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = '0'
      OnChange = EditAlphaLine1Change
    end
    object EditAlphaLine2: TEdit
      Left = 290
      Top = 8
      Width = 49
      Height = 20
      AutoSize = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Text = '10'
      OnChange = EditAlphaLine1Change
    end
    object CheckBoxAlphaLineNull: TCheckBox
      Left = 100
      Top = 24
      Width = 89
      Height = 17
      Caption = 'Unknown'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object EditAlphaProb: TEdit
      Left = 408
      Top = 8
      Width = 64
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = '1.0e-30'
    end
  end
  object GroupBoxNoGamma: TGroupBox
    Left = 0
    Top = 229
    Width = 496
    Height = 44
    Align = alTop
    Caption = ' &Beta lines, MeV '
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 6
    object Label23: TLabel
      Left = 130
      Top = 12
      Width = 93
      Height = 13
      Alignment = taRightJustify
      Caption = 'There are lines from'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label24: TLabel
      Left = 276
      Top = 12
      Width = 9
      Height = 13
      Caption = 'to'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label28: TLabel
      Left = 344
      Top = 12
      Width = 56
      Height = 13
      Caption = 'probability >'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object CheckBoxBetaLine: TCheckBox
      Left = 4
      Top = 16
      Width = 57
      Height = 17
      Caption = 'Recall'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clActiveCaption
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = CheckBoxClick
    end
    object EditBetaLine1: TEdit
      Left = 224
      Top = 8
      Width = 49
      Height = 20
      AutoSize = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = '0'
      OnChange = EditBetaLine1Change
    end
    object EditBetaLine2: TEdit
      Left = 291
      Top = 8
      Width = 49
      Height = 20
      AutoSize = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Text = '10'
      OnChange = EditBetaLine1Change
    end
    object CheckBoxBetaLineNull: TCheckBox
      Left = 100
      Top = 24
      Width = 85
      Height = 17
      Caption = 'Unknown'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object EditBetaProb: TEdit
      Left = 408
      Top = 8
      Width = 64
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = '1.0e-30'
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 469
    Width = 496
    Height = 12
    Lines.Strings = (
      'M'
      'e'
      'm'
      'o'
      '1')
    ScrollBars = ssVertical
    TabOrder = 9
    Visible = False
    WantTabs = True
  end
  object GroupBoxSigma: TGroupBox
    Left = 0
    Top = 321
    Width = 496
    Height = 148
    Caption = '&Xsecs (neutron reaction cross sections), barns '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    object GroupBoxSigmaCapture: TGroupBox
      Left = 4
      Top = 12
      Width = 158
      Height = 66
      Caption = ' cap&ture '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label7: TLabel
        Left = 4
        Top = 10
        Width = 20
        Height = 13
        Caption = 'from'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label8: TLabel
        Left = 128
        Top = 10
        Width = 9
        Height = 13
        Caption = 'to'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object CheckBoxSigmaC: TCheckBox
        Left = 60
        Top = 7
        Width = 57
        Height = 17
        Caption = 'Recall'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clActiveCaption
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = CheckBoxClick
      end
      object EditSigmaC1: TEdit
        Left = 8
        Top = 23
        Width = 65
        Height = 22
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = '0'
        OnChange = EditSigmaC1Change
      end
      object EditSigmaC2: TEdit
        Left = 90
        Top = 23
        Width = 60
        Height = 22
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = '1000'
        OnChange = EditSigmaC1Change
      end
      object CheckBoxSigmaCnull: TCheckBox
        Left = 32
        Top = 47
        Width = 89
        Height = 17
        Caption = 'Unknown'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
    end
    object GroupBoxSigmaFission: TGroupBox
      Left = 168
      Top = 12
      Width = 158
      Height = 66
      Caption = ' f&ission   '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object Label9: TLabel
        Left = 4
        Top = 10
        Width = 20
        Height = 13
        Caption = 'from'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label10: TLabel
        Left = 128
        Top = 10
        Width = 9
        Height = 13
        Caption = 'to'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object CheckBoxSigmaF: TCheckBox
        Left = 60
        Top = 7
        Width = 57
        Height = 17
        Caption = 'Recall'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clActiveCaption
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = CheckBoxClick
      end
      object EditSigmaF1: TEdit
        Left = 8
        Top = 23
        Width = 65
        Height = 22
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = '0'
        OnChange = EditSigmaF1Change
      end
      object EditSigmaF2: TEdit
        Left = 90
        Top = 23
        Width = 60
        Height = 22
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = '1000'
        OnChange = EditSigmaF1Change
      end
      object CheckBoxSigmaFnull: TCheckBox
        Left = 32
        Top = 47
        Width = 89
        Height = 17
        Caption = 'Unknown'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
    end
    object GroupBoxSigmaNP: TGroupBox
      Left = 332
      Top = 12
      Width = 158
      Height = 66
      Caption = ' (n, &p)   '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object Label11: TLabel
        Left = 4
        Top = 10
        Width = 20
        Height = 13
        Caption = 'from'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label12: TLabel
        Left = 128
        Top = 10
        Width = 9
        Height = 13
        Caption = 'to'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object CheckBoxSigmaNP: TCheckBox
        Left = 60
        Top = 7
        Width = 57
        Height = 17
        Caption = 'Recall'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clActiveCaption
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = CheckBoxClick
      end
      object EditSigmaNP1: TEdit
        Left = 8
        Top = 23
        Width = 65
        Height = 22
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = '0'
        OnChange = EditSigmaNP1Change
      end
      object EditSigmaNP2: TEdit
        Left = 90
        Top = 23
        Width = 60
        Height = 22
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = '1000'
        OnChange = EditSigmaNP1Change
      end
      object CheckBoxSigmaNPnull: TCheckBox
        Left = 32
        Top = 47
        Width = 89
        Height = 17
        Caption = 'Unknown'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
    end
    object GroupBox6: TGroupBox
      Left = 4
      Top = 78
      Width = 158
      Height = 66
      Caption = ' &(n, alpha)'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 3
      object Label13: TLabel
        Left = 4
        Top = 10
        Width = 20
        Height = 13
        Caption = 'from'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label14: TLabel
        Left = 128
        Top = 10
        Width = 9
        Height = 13
        Caption = 'to'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object CheckBoxSigmaNA: TCheckBox
        Left = 60
        Top = 7
        Width = 57
        Height = 17
        Caption = 'Recall'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clActiveCaption
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = CheckBoxClick
      end
      object EditSigmaNA1: TEdit
        Left = 8
        Top = 23
        Width = 65
        Height = 22
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = '0'
        OnChange = EditSigmaNA1Change
      end
      object EditSigmaNA2: TEdit
        Left = 90
        Top = 23
        Width = 60
        Height = 22
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = '1000'
        OnChange = EditSigmaNA1Change
      end
      object CheckBoxSigmaNAnull: TCheckBox
        Left = 32
        Top = 47
        Width = 89
        Height = 17
        Caption = 'Unknown'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
    end
    object GroupBoxSigmaN2N: TGroupBox
      Left = 168
      Top = 78
      Width = 158
      Height = 66
      Caption = ' (n, &2n)   '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      object Label15: TLabel
        Left = 4
        Top = 10
        Width = 20
        Height = 13
        Caption = 'from'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label16: TLabel
        Left = 128
        Top = 10
        Width = 9
        Height = 13
        Caption = 'to'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object CheckBoxSigmaN2N: TCheckBox
        Left = 60
        Top = 7
        Width = 57
        Height = 17
        Caption = 'Recall'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clActiveCaption
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = CheckBoxClick
      end
      object EditSigmaN2N1: TEdit
        Left = 8
        Top = 23
        Width = 65
        Height = 22
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = '0'
        OnChange = EditSigmaN2N1Change
      end
      object EditSigmaN2N2: TEdit
        Left = 90
        Top = 23
        Width = 60
        Height = 22
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = '1000'
        OnChange = EditSigmaN2N1Change
      end
      object CheckBoxSigmaN2Nnull: TCheckBox
        Left = 32
        Top = 47
        Width = 89
        Height = 17
        Caption = 'Unknown'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
    end
    object GroupBoxSigmaNN: TGroupBox
      Left = 332
      Top = 78
      Width = 158
      Height = 66
      Caption = ' (n, &n'#39')   '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      object Label17: TLabel
        Left = 4
        Top = 10
        Width = 20
        Height = 13
        Caption = 'from'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label18: TLabel
        Left = 128
        Top = 10
        Width = 9
        Height = 13
        Caption = 'to'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object CheckBoxSigmaNN: TCheckBox
        Left = 60
        Top = 7
        Width = 57
        Height = 17
        Caption = 'Recall'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clActiveCaption
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = CheckBoxClick
      end
      object EditSigmaNN1: TEdit
        Left = 8
        Top = 23
        Width = 65
        Height = 22
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = '0'
        OnChange = EditSigmaNN1Change
      end
      object EditSigmaNN2: TEdit
        Left = 90
        Top = 23
        Width = 60
        Height = 22
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = '1000'
        OnChange = EditSigmaNN1Change
      end
      object CheckBoxSigmaNNnull: TCheckBox
        Left = 32
        Top = 47
        Width = 89
        Height = 17
        Caption = 'Unknown'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
    end
  end
end
