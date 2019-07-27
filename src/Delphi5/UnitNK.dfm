object _FormNK: T_FormNK
  Left = 235
  Top = 103
  Width = 877
  Height = 520
  HelpContext = 10
  Caption = 'NUKLIDKARTE'
  Color = clBtnFace
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Times New Roman'
  Font.Style = []
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
  OldCreateOrder = False
  Position = poDefault
  Scaled = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object SplitterLeft: TSplitter
    Left = 89
    Top = 30
    Width = 3
    Height = 447
    Cursor = crHSplit
    Color = clBtnFace
    ParentColor = False
  end
  object SplitterRight: TSplitter
    Left = 777
    Top = 30
    Width = 3
    Height = 447
    Cursor = crHSplit
    Align = alRight
  end
  object SpeedButtonAddRemoveRegim: TSpeedButton
    Left = 292
    Top = 400
    Width = 23
    Height = 22
    Hint = 'Fill the list'
    AllowAllUp = True
    GroupIndex = -1
    Flat = True
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333777777777777777733333333333333337777777777777777333333333333
      3333777777777777777733333333333333337777777787777777333333330333
      3333777787778777777733330333033333337777877778778887333303333033
      0003777787777877777733330333303333337888888878777777300000003033
      3333777787777787777733330333330333337777877777877777333303333303
      3333777787777787777733330333330333337777777777787777333333333330
      3333777777777777777733333333333333337777777777777777333333333333
      3333777777777777777733333333333333337777777777777777}
    Layout = blGlyphBottom
    Margin = 1
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButtonAddRemoveRegimClick
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 869
    Height = 30
    Align = alTop
    BevelOuter = bvLowered
    Constraints.MinWidth = 450
    TabOrder = 0
    OnResize = PanelTopResize
    object SpeedButtonOpenDB: TSpeedButton
      Left = 2
      Top = 4
      Width = 22
      Height = 22
      Hint = 'Choose the data file'
      Flat = True
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000FFFFFF000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF000000000000FFFF00FF000000FF00FF00FFFF000000666600888888888888
        88888888888888888888AAAAAAAAAAA88888AA333333333A8888ABA333333333
        A888A0BA333333333A88AB0BA333333333A8A0B0BAAAAAAAAAAAAB0B0B0B0BA8
        8888A0B0B0B0B0A88888AB0BAAAAAAA888888AAA88888888AAA8888888888888
        8AA888888888A888A8A8888888888AAA88888888888888888888}
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButtonOpenDBClick
    end
    object SpeedButtonIncrease: TSpeedButton
      Left = 104
      Top = 4
      Width = 23
      Height = 22
      Hint = 'Magnify'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33033333333333333F7F3333333333333000333333333333F777333333333333
        000333333333333F777333333333333000333333333333F77733333333333300
        033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
        33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
        3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
        33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
        333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
        333333773FF77333333333370007333333333333777333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButtonIncreaseClick
    end
    object SpeedButtonDecrease: TSpeedButton
      Left = 128
      Top = 4
      Width = 23
      Height = 22
      Hint = 'Shrink'
      Enabled = False
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33033333333333333F7F3333333333333000333333333333F777333333333333
        000333333333333F777333333333333000333333333333F77733333333333300
        033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
        333333773337777333333078F8F87033333337F3333337F33333778F8F8F8773
        333337333333373F333307F8F8F8F70333337F33FFFFF37F3333078999998703
        33337F377777337F333307F8F8F8F703333373F3333333733333778F8F8F8773
        333337F3333337F333333078F8F870333333373FF333F7333333330777770333
        333333773FF77333333333370007333333333333777333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButtonDecreaseClick
    end
    object RxSpeedButtonOptions: TRxSpeedButton
      Left = 632
      Top = 4
      Width = 129
      Height = 22
      DropDownMenu = PopupMenuOptions
      Caption = '&Options'
      InitPause = 0
      Margin = 0
      ShowHint = False
      OnClick = RxSpeedButtonOptionsClick
    end
    object ButtonUserList: TSpeedButton
      Left = 560
      Top = 4
      Width = 75
      Height = 22
      Caption = '&List'
      OnClick = ButtonUserListClick
    end
    object SpeedButtonInfo: TSpeedButton
      Left = 780
      Top = 4
      Width = 22
      Height = 22
      Hint = 'Info'
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        7777777777777777777777777777777777777777777777777777777774487777
        777777777FF777777777777784747777777777777F7F77777777777744877777
        77777777FF7777777777777784877777777777777F7777777777777784477777
        777777777FF777777777777774447777777777777FFF77777777777744447777
        77777777FFFF7777777777778888777777777777777777777777777774487777
        777777777FF777777777777774487777777777777FF777777777777777777777
        7777777777777777777777777777777777777777777777777777}
      Margin = 4
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButtonInfoClick
    end
    object SpeedButtonChoose: TSpeedButton
      Left = 156
      Top = 4
      Width = 105
      Height = 22
      Caption = '&Filter...'
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
      OnClick = SpeedButtonChooseClick
    end
    object SpeedButtonChooseWithDPR: TSpeedButton
      Left = 272
      Top = 4
      Width = 105
      Height = 22
      Caption = 'Fil&ter +...'
      Glyph.Data = {
        2E060000424D2E06000000000000360400002800000015000000150000000100
        080000000000F801000000000000000000000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A6000020400000206000002080000020A0000020C0000020E000004000000040
        20000040400000406000004080000040A0000040C0000040E000006000000060
        20000060400000606000006080000060A0000060C0000060E000008000000080
        20000080400000806000008080000080A0000080C0000080E00000A0000000A0
        200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
        200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
        200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
        20004000400040006000400080004000A0004000C0004000E000402000004020
        20004020400040206000402080004020A0004020C0004020E000404000004040
        20004040400040406000404080004040A0004040C0004040E000406000004060
        20004060400040606000406080004060A0004060C0004060E000408000004080
        20004080400040806000408080004080A0004080C0004080E00040A0000040A0
        200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
        200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
        200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
        20008000400080006000800080008000A0008000C0008000E000802000008020
        20008020400080206000802080008020A0008020C0008020E000804000008040
        20008040400080406000804080008040A0008040C0008040E000806000008060
        20008060400080606000806080008060A0008060C0008060E000808000008080
        20008080400080806000808080008080A0008080C0008080E00080A0000080A0
        200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
        200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
        200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
        2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
        2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
        2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
        2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
        2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
        2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
        2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00646464646464
        6464646464646464646464646464640000006464646464646464646464646464
        6464646464646400000064646464646464646464646464646464646464646400
        0000646464F9F964646464646464646464646464646464000000646464F9F964
        64646464646464646464646464646400000064F9F9F9F9F9F964646464646464
        6464646464646400000064F9F9F9F9F9F9646464646464646464646464646400
        0000646464F9F964646464000000646464646464646464000000646464F9F964
        64646400FF0064646464646464646400000064646464646464646400FF006464
        6464646464646400000064646464646464640000FF0000646464646464646400
        000064646464646464000010FF10000064646464646464000000646464646464
        000010FF1010000000646464646464000000646464646400000010FF10101000
        000064646464640000006464646400000010FF10101010000000006464646400
        00006464640000001010FF101010101000000000646464000000646400000010
        10FF101010101010000000000064640000006464000000000000000000000000
        0000000000646400000064646464646464646464646464646464646464646400
        0000646464646464646464646464646464646464646464000000646464646464
        646464646464646464646464646464000000}
      OnClick = SpeedButtonChooseWithDPRClick
    end
    object ButtonReloadDB: TButton
      Left = 24
      Top = 4
      Width = 81
      Height = 22
      Hint = 'Load the DB'
      Caption = 'Re&fresh'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = ButtonReloadDBClick
    end
    object ButtonGoTo: TButton
      Left = 464
      Top = 4
      Width = 93
      Height = 22
      Caption = '&Go to...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = ButtonGoToClick
    end
  end
  object ListBoxUserList: TListBox
    Left = 124
    Top = 241
    Width = 520
    Height = 49
    ItemHeight = 15
    PopupMenu = PopupMenuUserList
    TabOrder = 2
    Visible = False
    OnDblClick = ListBoxUserListDblClick
  end
  object StringGridNK: TStringGrid
    Left = 108
    Top = 88
    Width = 533
    Height = 137
    Cursor = crHandPoint
    ColCount = 180
    Ctl3D = True
    DefaultColWidth = 42
    DefaultRowHeight = 42
    DefaultDrawing = False
    RowCount = 120
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Times New Roman'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goRangeSelect, goThumbTracking]
    ParentCtl3D = False
    ParentFont = False
    ParentShowHint = False
    PopupMenu = PopupMenuNK
    ShowHint = False
    TabOrder = 1
    OnClick = StringGridNKClick
    OnDblClick = StringGridNKDblClick
    OnDrawCell = StringGridNKDrawCell
    OnExit = StringGridNKExit
    OnKeyDown = StringGridNKKeyDown
    OnKeyUp = StringGridNKKeyUp
    OnMouseDown = StringGridNKMouseDown
    OnMouseMove = StringGridNKMouseMove
    OnMouseUp = StringGridNKMouseUp
    OnTopLeftChanged = StringGridNKTopLeftChanged
    ColWidths = (
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42)
    RowHeights = (
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42
      42)
  end
  object PanelDockLeft: TPanel
    Left = 0
    Top = 30
    Width = 89
    Height = 447
    Align = alLeft
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    object PageControlDockLeft: TPageControl
      Left = 2
      Top = 2
      Width = 85
      Height = 443
      Align = alClient
      DockSite = True
      MultiLine = True
      TabOrder = 0
      OnDockDrop = PageControlDockLeftDockDrop
      OnUnDock = PageControlDockLeftUnDock
    end
  end
  object PanelDockRight: TPanel
    Left = 780
    Top = 30
    Width = 89
    Height = 447
    Align = alRight
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 4
    object PageControlDockRight: TPageControl
      Left = 2
      Top = 2
      Width = 85
      Height = 443
      Align = alClient
      DockSite = True
      MultiLine = True
      TabOrder = 0
      OnDockDrop = PageControlDockRightDockDrop
      OnDockOver = PageControlDockRightDockOver
      OnUnDock = PageControlDockRightUnDock
    end
  end
  object PanelDatabaseName: TPanelFileName
    Left = 0
    Top = 477
    Width = 869
    Height = 16
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'The data file name'
    TabOrder = 5
    OnResize = PanelDatabaseNameResize
  end
  object RxWindowHook: TRxWindowHook
    BeforeMessage = RxWindowHookBeforeMessage
    Left = 308
    Top = 152
  end
  object PopupMenuNK: TPopupMenu
    OnPopup = PopupMenuNKPopup
    Left = 406
    Top = 152
    object Legenda: TMenuItem
      Caption = '&Legend'
      OnClick = LegendaClick
    end
    object Increase: TMenuItem
      Caption = 'M&agnify'
      OnClick = IncreaseClick
    end
    object Decrease: TMenuItem
      Caption = 'Sh&rink'
      Enabled = False
      OnClick = DecreaseClick
    end
    object Diagonal: TMenuItem
      Break = mbBreak
      Caption = '&Diagonal'
      Hint = 'Diagonal scroll'
      OnClick = DiagonalClick
    end
    object EditNuclide: TMenuItem
      Caption = '&Edit'
      OnClick = EditNuclideClick
    end
    object EditNuclide2nd: TMenuItem
      Caption = 'Edit(&2)'
      OnClick = EditNuclide2ndClick
    end
    object ItemMore: TMenuItem
      Caption = 'Mor&e...'
      OnClick = ItemMoreClick
    end
    object ItemChoose: TMenuItem
      Caption = '&Filter...'
      OnClick = ItemChooseClick
    end
  end
  object PopupMenuList: TPopupMenu
    OnPopup = PopupMenuListPopup
    Left = 256
    Top = 100
    object AddRemoveRegimItem: TMenuItem
      Caption = '&Mode +/-'
      OnClick = AddRemoveRegimItemClick
    end
    object AddItem: TMenuItem
      Caption = '&Add'
      OnClick = AddItemClick
    end
    object DeleteItem: TMenuItem
      Caption = '&Delete'
      OnClick = DeleteItemClick
    end
    object ClearItem: TMenuItem
      Caption = '&Clear'
      OnClick = ClearItemClick
    end
    object SeeItem: TMenuItem
      Caption = '&See'
      Visible = False
    end
    object LoadDetailItem: TMenuItem
      Caption = '&Load from DB'
      object LoadAllDetailItem: TMenuItem
        Break = mbBarBreak
        Caption = '&ALL'
        OnClick = LoadAllDetailItemClick
      end
      object LoadRIitem: TMenuItem
        Caption = '&RI'
        OnClick = LoadRIitemClick
      end
      object LoadAlphaItem: TMenuItem
        Caption = '&Alpha'
        OnClick = LoadAlphaItemClick
      end
      object LoadBetaItem: TMenuItem
        Caption = '&Beta'
        OnClick = LoadBetaItemClick
      end
      object LoadGammaItem: TMenuItem
        Caption = '&Gamma'
        OnClick = LoadGammaItemClick
      end
    end
    object ItemHasProducts: TMenuItem
      Caption = 'Fissionable'
      object ItemOneHasProducts: TMenuItem
        Caption = 'U-235'
        Visible = False
      end
    end
  end
  object PopupMenuUserList: TPopupMenu
    OnPopup = PopupMenuUserListPopup
    Left = 328
    Top = 252
    object DeleteUserItem: TMenuItem
      Caption = 'Delete'
      OnClick = DeleteUserItemClick
    end
    object UserRepaint: TMenuItem
      Caption = 'Refresh'
      OnClick = UserRepaintClick
    end
  end
  object PopupMenuOptions: TPopupMenu
    Left = 684
    Top = 48
    object ItemPeriod: TMenuItem
      Caption = 'H&alf life'
      Checked = True
      GroupIndex = 1
      RadioItem = True
      OnClick = ItemPeriodClick
    end
    object ItemSigma: TMenuItem
      Caption = 'Capture &Xsec (cross section)'
      GroupIndex = 1
      RadioItem = True
      OnClick = ItemSigmaClick
    end
    object ItemRI: TMenuItem
      Caption = 'RI (resonance integeral)'
      GroupIndex = 1
      RadioItem = True
      OnClick = ItemRIClick
    end
    object ItemSigmaF: TMenuItem
      Caption = 'Fission Xsec'
      GroupIndex = 1
      RadioItem = True
      OnClick = ItemSigmaFClick
    end
    object ItemRIf: TMenuItem
      Caption = 'Fission RI'
      GroupIndex = 1
      RadioItem = True
      OnClick = ItemRIfClick
    end
    object N1: TMenuItem
      Caption = '-'
      GroupIndex = 1
    end
    object ItemNP: TMenuItem
      Caption = '(n, &p) Xsec'
      GroupIndex = 1
      Hint = 'Xsec for fission spectra neutrons'
      RadioItem = True
      OnClick = ItemNPClick
    end
    object ItemNA: TMenuItem
      Caption = '(n,&alpha) Xsec'
      GroupIndex = 1
      Hint = 'Xsec for fission spectra neutrons'
      RadioItem = True
      OnClick = ItemNAClick
    end
    object ItemN2N: TMenuItem
      Caption = '(n,&2n) Xsec '
      GroupIndex = 1
      Hint = 'Xsec for fission spectra neutrons'
      RadioItem = True
      OnClick = ItemN2NClick
    end
    object ItemNN: TMenuItem
      Caption = '(&n,n'#39') Xsec'
      GroupIndex = 1
      Hint = 'Xsec for fission spectra neutrons'
      RadioItem = True
      OnClick = ItemNNClick
    end
    object ItemG_factor: TMenuItem
      Caption = '&g-factor'
      GroupIndex = 1
      RadioItem = True
      OnClick = ItemG_factorClick
    end
    object N3: TMenuItem
      Caption = '-'
      GroupIndex = 1
    end
    object ItemShowProducts: TMenuItem
      Caption = 'Mark fission products'
      GroupIndex = 1
      OnClick = ItemShowProductsClick
    end
    object ItemBlackFontColor: TMenuItem
      Caption = 'Black font'
      GroupIndex = 1
      OnClick = ItemBlackFontColorClick
    end
    object ItemSaveSetting: TMenuItem
      Caption = 'Save position'
      GroupIndex = 1
      OnClick = ItemSaveSettingClick
    end
  end
  object FormPlacement: TFormPlacement
    OnRestorePlacement = FormPlacementRestorePlacement
    Left = 252
    Top = 152
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 523
    Top = 162
  end
  object SaveDialog: TSaveDialog
    Filter = 
      'Chain files (*.chn)|*.chn|EMF files (*.emf)|*.emf|WMF files (*.w' +
      'mf)|*.wmf'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 372
    Top = 372
  end
end
