object _FrmList: T_FrmList
  Left = 192
  Top = 51
  Width = 149
  Height = 375
  HelpContext = 140
  BorderStyle = bsSizeToolWin
  Caption = '_FrmList'
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 130
  UseDockManager = True
  DragKind = dkDock
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StringGridChosenList: TStringGrid
    Left = 0
    Top = 0
    Width = 141
    Height = 348
    Align = alClient
    ColCount = 2
    DefaultColWidth = 42
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing]
    TabOrder = 0
    OnDblClick = StringGridChosenListDblClick
  end
end
