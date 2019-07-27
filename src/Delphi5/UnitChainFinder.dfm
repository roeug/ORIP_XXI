object _FormChainFinder: T_FormChainFinder
  Left = 210
  Top = 95
  Width = 549
  Height = 454
  Caption = 'Chain Finder'
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
    000000000000CCC00000000999000000000000000000C0CC0000009909000000
    000000000000C000CC00090009000000000000000000CC000CC0900099000000
    000000000000CC0071C90000990000000000000000000CC7111C222990000000
    00000000000222771170C02222200000000000000222002518100C0900220000
    0000000022000071007000CC000000000000000002220011001077CC00220000
    00000000002222977019170C22220077777880000000098771977220CC000000
    000000000000099007777000CC0000777778800000079900009C0000CC000077
    77788000000790000990C0000C000077777880000007900990000C00CC000077
    7778800000079999900000CCCC00007777788000000709900000000CC0000077
    7778800000077778800000000000007777788077880777788000000000000077
    7778000000077778800000000000007777780777880777788000000000000077
    7778000000077778800000000000007777788000007777788000000000000000
    0000000000000000000000000000000077888800077788800000000000000000
    0000000000000000000000000000000000777000007770000000000000000000
    0000000000000000000000000000000007777700077777000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    1FE3FFFF4FCBFFFF73BBFFFF3973FFFF30F3FFFF8007FFFE0001FFF8C00CFFF3
    C00FFFF8C00C803C0020803F8013803D9873803C3CF3803C797B803C67B3803C
    07C3803C9BE7800003FF800003FF800003FF800003FF800003FF800003FF8010
    03FFE0100FFFE0100FFFF8383FFFF8383FFFF0101FFFF0101FFFFFFFFFFF}
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2FocusChains: TLabel
    Left = 0
    Top = 157
    Width = 541
    Height = 13
    Align = alTop
    Caption = '     C&hain(s) found'
    FocusControl = TreeView
  end
  object PanelDatabaseName: TPanel
    Left = 0
    Top = 367
    Width = 536
    Height = 41
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    Visible = False
    object LabelTest: TLabel
      Left = 364
      Top = 8
      Width = 169
      Height = 29
      Alignment = taCenter
      AutoSize = False
      Caption = 'Test'
    end
    object ButtonTest: TButton
      Left = 284
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Test'
      TabOrder = 0
      OnClick = ButtonTestClick
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 541
    Height = 157
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Constraints.MinWidth = 330
    TabOrder = 1
    OnResize = PanelTopResize
    object LabelInfo: TLabel
      Left = 2
      Top = 142
      Width = 537
      Height = 13
      Align = alBottom
      Alignment = taCenter
      Caption = 'Info'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object LabelMaxDepth: TLabel
      Left = 200
      Top = 80
      Width = 50
      Height = 13
      Caption = 'Max.&depth'
      FocusControl = EditMaxStepNo
    end
    object LabelMaxTime: TLabel
      Left = 328
      Top = 80
      Width = 64
      Height = 13
      Caption = 'Max time, &min'
      FocusControl = EditMaxTime
    end
    object LabelStartState: TLabel
      Left = 68
      Top = 8
      Width = 48
      Height = 13
      Caption = '&Start state'
      FocusControl = EditStart
    end
    object LabelFinishState: TLabel
      Left = 380
      Top = 8
      Width = 53
      Height = 13
      Caption = '&Finish state'
      FocusControl = EditFinish
    end
    object SpeedButtonInfo: TSpeedButton
      Left = 500
      Top = 4
      Width = 32
      Height = 32
      Flat = True
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        8888888800008888888444444888888800008888844444444448888800008888
        4446FF644444888800008884444FFFF64444488800008844444FF64844444488
        000088444446FF4444444488010184444444FF64444444480833844444446FF4
        444444480000844444444FF64444444800008444444846FF4444444800008444
        4446FFFF444444480000844444446FF644444448000088444444444444444488
        00008844444444664444448800008884444446FF6444488800008888444446FF
        6444888800008888844444664448888800008888888444444888888800008888
        88888888888888880000}
      OnClick = SpeedButtonInfoClick
    end
    object CheckBoxCapture: TCheckBox
      Left = 4
      Top = 52
      Width = 65
      Height = 17
      Caption = '&Capture'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object CheckBoxDecay: TCheckBox
      Left = 144
      Top = 52
      Width = 65
      Height = 17
      Caption = 'D&ecay'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object CheckBoxFission: TCheckBox
      Left = 284
      Top = 52
      Width = 65
      Height = 17
      Caption = 'F&ission'
      TabOrder = 4
    end
    object CheckBoxThreshold: TCheckBox
      Left = 424
      Top = 52
      Width = 65
      Height = 17
      Caption = '&Threshold'
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
    object ButtonFind: TButton
      Left = 8
      Top = 96
      Width = 75
      Height = 25
      Caption = 'Fi&nd'
      TabOrder = 9
      OnClick = ButtonFindClick
    end
    object ButtonAbortFind: TButton
      Left = 444
      Top = 96
      Width = 75
      Height = 25
      Caption = '&Abort Find'
      Enabled = False
      TabOrder = 10
      OnClick = ButtonAbortFindClick
    end
    object EditStart: TComboBox
      Left = 52
      Top = 24
      Width = 121
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      OnKeyDown = EditKeyDown
    end
    object EditFinish: TComboBox
      Left = 360
      Top = 24
      Width = 121
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      OnKeyDown = EditKeyDown
    end
    object CheckBoxClearFound: TCheckBox
      Left = 8
      Top = 124
      Width = 101
      Height = 17
      Caption = 'Clea&r found'
      TabOrder = 8
    end
    object EditMaxTime: TSpinEdit
      Left = 328
      Top = 96
      Width = 64
      Height = 22
      MaxValue = 100000
      MinValue = 1
      TabOrder = 7
      Value = 3
    end
    object EditMaxStepNo: TSpinEdit
      Left = 200
      Top = 96
      Width = 64
      Height = 22
      MaxValue = 10000000
      MinValue = 2
      TabOrder = 6
      Value = 100
    end
  end
  object TreeView: TTreeView
    Left = 0
    Top = 170
    Width = 541
    Height = 257
    Align = alClient
    Indent = 19
    PopupMenu = PopupMenu
    TabOrder = 2
  end
  object PopupMenu: TPopupMenu
    AutoHotkeys = maManual
    OnPopup = PopupMenuPopup
    Left = 72
    Top = 204
    object ItemCopyChainNames: TMenuItem
      Caption = 'Copy c&hain state names'
      OnClick = ItemCopyChainNamesClick
    end
    object ItemLoadFromFile: TMenuItem
      Caption = '&Load chain from file'
      OnClick = ItemLoadFromFileClick
    end
    object ItemSaveToFile: TMenuItem
      Caption = '&Save chain to file'
      Hint = 'Saves Chain To File'
      OnClick = ItemSaveToFileClick
    end
    object ItemAddState: TMenuItem
      Caption = 'Add/Remove state'
      Visible = False
      OnClick = ItemAddStateClick
    end
    object ItemStateNamesToClipboard: TMenuItem
      Caption = '&Copy state names'
      Visible = False
      OnClick = ItemStateNamesToClipboardClick
    end
    object ItemStateAllNamesToClipboard: TMenuItem
      Caption = 'Copy &All state names'
      OnClick = ItemStateAllNamesToClipboardClick
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'Chain Files (*.chn)|*.chn|All Files|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 140
    Top = 240
  end
  object SaveDialog: TSaveDialog
    Filter = 'Chain Files|*.chn|All Files|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofCreatePrompt, ofEnableSizing]
    Left = 232
    Top = 320
  end
end
