object _FormChainNKE: T_FormChainNKE
  Left = 412
  Top = 146
  Width = 542
  Height = 528
  Caption = 'FormChainNKE'
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
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000FFFFFFFFFF000FFFFFFFFFF0000000
    00FFFFFFFFFF000FFFFFFFFFF000000000FF000000FF000FF000000FF0000000
    00FF000000FF000FF000000FF000000000FF000000FF000FF000000FF0000000
    00FFFFFFFFFF000FFFFFFFFFF000000000FFFFFFFFFF000FFFFFFFFFF0000000
    000000FF00000000000FF00000000000000000FF00000000000FF00000000000
    000000FF00000000000FF0000000000000FFFFFFFFFF000FFFFFFFFFF0000000
    00FFFFFFFFFF000FFFFFFFFFF000000000FF000000FF000FF000000FF0000000
    00FF000000FF000FF000000FF000000000FF000000FF000FF000000FF0000000
    00FFFFFFFFFF000FFFFFFFFFF000000000FFFFFFFFFF000FFFFFFFFFF0000000
    00000FF0000000FF00000000000000000000FF0000000FF00000000000000000
    000FF0000000FF0000000000000000FFFFFFFFFF000FF00000000000000000FF
    FFFFFFFF00FF000000000000000000FF000000FF0FF0000000000000000000FF
    000000FFFF00000000000000000000FF000000FFF000000000000000000000FF
    FFFFFFFF0000000000000000000000FFFFFFFFFF000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelBottom: TPanel
    Left = 0
    Top = 459
    Width = 534
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object ButtonClose: TButton
      Left = 456
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Close (ESC)'
      TabOrder = 0
      OnClick = ButtonCloseClick
    end
    object ButtonSaveChain: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Sa&ve'
      TabOrder = 1
      OnClick = ButtonSaveChainClick
    end
    object ButtonSaveEMF: TButton
      Left = 100
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Save &EMF'
      TabOrder = 2
      OnClick = ButtonSaveEMFClick
    end
    object ButtonSaveWMF: TButton
      Left = 196
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Save &WMF'
      TabOrder = 3
      OnClick = ButtonSaveWMFClick
    end
  end
  object ScrollBoxImage: TScrollBox
    Left = 0
    Top = 0
    Width = 534
    Height = 459
    Align = alClient
    TabOrder = 1
    object Image: TImage
      Left = 1
      Top = 1
      Width = 10
      Height = 10
      PopupMenu = PopupMenuImage
      OnDblClick = ImageDblClick
      OnMouseUp = ImageMouseUp
    end
    object CheckBoxAsDecayChain: TCheckBox
      Left = 296
      Top = 12
      Width = 97
      Height = 17
      Caption = 'AsDecayChain'
      Checked = True
      State = cbChecked
      TabOrder = 0
      Visible = False
    end
  end
  object PopupMenuImage: TPopupMenu
    OnPopup = PopupMenuImagePopup
    Left = 182
    Top = 118
    object ItemCopyStateNamesToClipbrd: TMenuItem
      Caption = 'Copy State Names'
      OnClick = ItemCopyStateNamesToClipbrdClick
    end
  end
end
