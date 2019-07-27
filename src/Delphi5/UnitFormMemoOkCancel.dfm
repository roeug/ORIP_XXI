object _FormMemoOKCancel: T_FormMemoOKCancel
  Left = 172
  Top = 167
  BorderStyle = bsDialog
  Caption = '_FormMemoOKCancel'
  ClientHeight = 276
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 688
    Height = 117
    Align = alTop
    Caption = 'States in the chain'
    TabOrder = 1
    object MemoInChain: TMemo
      Left = 2
      Top = 15
      Width = 684
      Height = 100
      Align = alClient
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 117
    Width = 688
    Height = 159
    Align = alClient
    Caption = 'States to Add'
    TabOrder = 0
    object Memo: TMemo
      Left = 2
      Top = 15
      Width = 684
      Height = 109
      Align = alClient
      Lines.Strings = (
        '')
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
    end
    object PanelControls: TPanel
      Left = 2
      Top = 124
      Width = 684
      Height = 33
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 1
      object BitBtnOK: TBitBtn
        Left = 16
        Top = 4
        Width = 75
        Height = 25
        Caption = '&Add'
        TabOrder = 0
        Kind = bkOK
      end
      object BitBtnCancel: TBitBtn
        Left = 152
        Top = 4
        Width = 75
        Height = 25
        TabOrder = 1
        Kind = bkCancel
      end
    end
  end
end
