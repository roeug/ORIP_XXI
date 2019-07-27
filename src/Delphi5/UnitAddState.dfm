object _FormAddState: T_FormAddState
  Left = 234
  Top = 49
  BorderStyle = bsToolWindow
  Caption = 'Add/Remove State'
  ClientHeight = 348
  ClientWidth = 244
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBoxRemoveState: TGroupBox
    Left = 0
    Top = 0
    Width = 129
    Height = 348
    Align = alLeft
    Caption = 'Remove State'
    TabOrder = 0
    object ListBoxStates: TListBox
      Left = 2
      Top = 15
      Width = 125
      Height = 286
      Align = alTop
      ItemHeight = 13
      TabOrder = 0
      OnEnter = ListBoxStatesEnter
    end
    object ButtonRemove: TButton
      Left = 27
      Top = 312
      Width = 75
      Height = 25
      Caption = 'Remove'
      TabOrder = 1
      OnClick = ButtonRemoveClick
    end
  end
  object GroupBoxAddState: TGroupBox
    Left = 129
    Top = 0
    Width = 115
    Height = 348
    Align = alClient
    Caption = 'Add State'
    TabOrder = 1
    object EditStateName: TComboBox
      Left = 3
      Top = 76
      Width = 102
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      OnDropDown = EditStateNameDropDown
      OnExit = EditStateNameExit
    end
    object ButtonAdd: TButton
      Left = 19
      Top = 128
      Width = 75
      Height = 25
      Caption = 'Add'
      TabOrder = 1
      OnClick = ButtonAddClick
    end
  end
end
