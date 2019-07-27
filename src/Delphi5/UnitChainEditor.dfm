object _FormChainEditor: T_FormChainEditor
  Left = 377
  Top = 122
  HelpContext = 20
  AutoScroll = False
  Caption = 'Chain Solver'
  ClientHeight = 564
  ClientWidth = 787
  Color = clBtnFace
  Constraints.MinWidth = 375
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000CCCCC000000000099999000000000000C0000C0000000090000900000000
    0000C00000C0000009000009000000000000C000000C00009000000900000000
    00000C000000C009000000900000000000000C0000111C900000009000000000
    000000C0001119C00000090000000000000000C0AAAA9AAAAAAAA90000000000
    000AAAAA01191F10C000AAAAA00000000AA00000C19FF1000C0090000AA06666
    A00000000900110000C00000000A600A0000000090000F00000C0000000A6644
    A444440090000100FF0C0444440A6E660AA00009000F01100000C0000AA06F66
    000AAAA90FF001111888C2AAA4006E66F800F8900000111F1AAAFC8004006F66
    FF00FF90FF011FF11FFFFC8004006E660000090000001111000000C004006F66
    00000900000009C0000000C004006E66F8009800F800980CF800F80C04006F66
    FF009F00FF09FF00CF00FF0C04006E6600009000009000000C00000C04006F66
    000090009900000000CC000C04006E66F800F999F800F800F800CCC004006F66
    FF00FF00FF00FF00FF00FF0004006E6666666666666666666666666664006F66
    08888888888888866666666664006E660FFFFFFFFFFFFF866666666664006F66
    08888888888888866666666664006E6600000000000000066666666664006FEF
    EFEFEFEFEFEFEFEFEFEFEFEFE40066666666666666666666666666666660FF07
    FE0FFF7BFDEFFF7DFBEFFF7EF7EFFFBF6FDFFFBC1FDFFFDC1FBFFFD0003FFE08
    0107F9F0007907F000FE002000800020008009E0017900000001011000190112
    00190FBF0FD90111111901110109011011090F7DFBE901111009010111190111
    111900000001000000010000000100000001000000010000000100000001}
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 787
    Height = 564
    ActivePage = TabSheetConditions
    Align = alClient
    TabOrder = 0
    OnChange = PageControlChange
    OnChanging = PageControlChanging
    OnResize = PageControlResize
    object TabSheetChainEditor: TTabSheet
      HelpContext = 30
      Caption = 'C&hain'
      object LabelChainFileName: TLabel
        Left = 0
        Top = 0
        Width = 779
        Height = 13
        Align = alTop
        Caption = 'Chain file:'
      end
      object SplitterHorzChainEdit: TSplitter
        Left = 0
        Top = 405
        Width = 779
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        Beveled = True
      end
      object PanelChainBottom: TPanel
        Left = 0
        Top = 408
        Width = 779
        Height = 128
        Align = alBottom
        BevelInner = bvLowered
        TabOrder = 0
        OnCanResize = PanelChainBottomCanResize
        object StringGridStateLink: TBKStringGrid
          Left = 2
          Top = 2
          Width = 631
          Height = 124
          Align = alClient
          ColCount = 2
          DefaultColWidth = 24
          DefaultRowHeight = 19
          RowCount = 15
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
          ParentFont = False
          TabOrder = 0
          OnKeyDown = StringGridStateLinkKeyDown
          OnSelectCell = StringGridStateLinkSelectCell
          CaseSensitive = False
          SortByFixedCol = False
          Filename = 'TBKStringGrid.txt'
          BlanksDown = True
          Encryption = True
          OnUserChangedCell = StringGridStateLinkUserChangedCell
        end
        object PanelChainRightBottom: TPanel
          Left = 633
          Top = 2
          Width = 144
          Height = 124
          Align = alRight
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 1
          object SpeedButtonInfo: TSpeedButton
            Left = 105
            Top = 77
            Width = 32
            Height = 32
            Hint = 'Info'
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
            ParentShowHint = False
            ShowHint = True
            OnClick = SpeedButtonInfoClick
          end
          object ButtonLookInOOB: TButton
            Left = 54
            Top = 4
            Width = 75
            Height = 25
            Hint = 'Look in data file'
            Caption = 'I&n file'
            Enabled = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = ButtonLookInOOBClick
          end
          object ButtonToChain: TButton
            Left = 54
            Top = 48
            Width = 75
            Height = 25
            Caption = '&To data'
            Enabled = False
            TabOrder = 1
            OnClick = ButtonToChainClick
          end
          object FilenameEdit1: TFilenameEdit
            Left = 8
            Top = 52
            Width = 41
            Height = 21
            DialogKind = dkSavePicture
            DefaultExt = 'emf'
            Filter = 
              'Enhanced Windows meta files (*.emf)|*.emf|Windows meta files (*.' +
              'wmf)|*.wmf|All meta files (*.wmf *.emf)|*.emf;*.wmf|All files (*' +
              '.*)|*.*'
            DialogOptions = [ofOverwritePrompt, ofHideReadOnly]
            DialogTitle = 'Save chain image'
            ClickKey = 0
            DirectInput = False
            GlyphKind = gkCustom
            NumGlyphs = 1
            TabOrder = 2
            Visible = False
          end
          object ButtonTestChain: TButton
            Left = 22
            Top = 84
            Width = 75
            Height = 25
            Caption = 'Test'
            TabOrder = 3
            Visible = False
            OnClick = ButtonTestChainClick
          end
        end
      end
      object PanelChainEditBig: TPanel
        Left = 0
        Top = 13
        Width = 779
        Height = 392
        Align = alClient
        TabOrder = 1
        object ScrollBoxCAD: TScrollBox
          Left = 1
          Top = 1
          Width = 615
          Height = 390
          Align = alClient
          TabOrder = 1
          object Image: TImage
            Left = 1
            Top = 1
            Width = 10
            Height = 10
            PopupMenu = PopupMenuCAD
            OnMouseDown = ImageMouseDown
            OnMouseUp = ImageMouseUp
          end
        end
        object PanelChainRight: TScrollBox
          Left = 616
          Top = 1
          Width = 162
          Height = 390
          Align = alRight
          BorderStyle = bsNone
          Color = clBtnFace
          ParentColor = False
          TabOrder = 0
          object ButtonRepaint: TButton
            Left = 44
            Top = 364
            Width = 75
            Height = 25
            Caption = 'Repaint'
            TabOrder = 2
            OnClick = ButtonRepaintClick
          end
          object ButtonClearChainEditor: TButton
            Left = 8
            Top = 68
            Width = 72
            Height = 25
            Caption = 'Clear'
            TabOrder = 3
            OnClick = ButtonClearChainEditorClick
          end
          object ProgressBarLoad: TProgressBar
            Left = 112
            Top = 32
            Width = 13
            Height = 64
            Min = 0
            Max = 64
            Orientation = pbVertical
            TabOrder = 5
          end
          object GroupBoxStates: TGroupBox
            Left = 4
            Top = 96
            Width = 140
            Height = 133
            Caption = '&States'
            TabOrder = 6
            object EditState: TEdit
              Left = 4
              Top = 20
              Width = 105
              Height = 21
              TabOrder = 0
              OnKeyUp = EditStateKeyUp
            end
            object CheckBoxBuildLinks: TCheckBox
              Left = 56
              Top = 48
              Width = 81
              Height = 17
              Caption = 'Build Links'
              Checked = True
              State = cbChecked
              TabOrder = 2
              OnClick = CheckBoxBuildLinksClick
            end
            object ButtonAddState: TButton
              Left = 4
              Top = 42
              Width = 47
              Height = 25
              Caption = 'Add'
              Enabled = False
              TabOrder = 6
              OnClick = ButtonAddStateClick
            end
            object ButtonDeleteState: TButton
              Left = 88
              Top = 102
              Width = 49
              Height = 25
              Caption = 'Delete'
              Enabled = False
              TabOrder = 8
              OnClick = ButtonDeleteStateClick
            end
            object ComboBoxStates: TComboBox
              Left = 4
              Top = 104
              Width = 77
              Height = 21
              Style = csDropDownList
              DropDownCount = 13
              ItemHeight = 13
              MaxLength = 13
              TabOrder = 9
              OnChange = ComboBoxStatesChange
            end
            object CheckBoxCapture: TCheckBox
              Left = 4
              Top = 68
              Width = 61
              Height = 17
              Caption = 'Capture'
              Checked = True
              State = cbChecked
              TabOrder = 3
            end
            object CheckBoxFission: TCheckBox
              Left = 4
              Top = 84
              Width = 57
              Height = 17
              Caption = 'Fission'
              Checked = True
              State = cbChecked
              TabOrder = 4
            end
            object CheckBoxDecay: TCheckBox
              Left = 68
              Top = 68
              Width = 68
              Height = 17
              Caption = 'Decay'
              Checked = True
              State = cbChecked
              TabOrder = 7
            end
            object CheckBoxThreshold: TCheckBox
              Left = 68
              Top = 84
              Width = 68
              Height = 17
              Caption = 'Threshold'
              Checked = True
              State = cbChecked
              TabOrder = 5
            end
            object BitBtnEditAddStatesList: TBitBtn
              Left = 112
              Top = 20
              Width = 24
              Height = 21
              Hint = 'Edit...'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              OnClick = BitBtnEditAddStatesListClick
              Glyph.Data = {
                F6000000424DF600000000000000760000002800000010000000100000000100
                0400000000008000000000000000000000001000000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
                7777777777777777777777777777777777777770077007700777777007700770
                0777777777777777777777777777777777777777777777777777777777777777
                7777777777777777777777777777777777777777777777777777777777777777
                7777777777777777777777777777777777777777777777777777}
            end
          end
          object GroupBoxLinks: TGroupBox
            Left = 4
            Top = 228
            Width = 141
            Height = 133
            Caption = '&Links'
            TabOrder = 7
            OnMouseUp = GroupBoxLinksMouseUp
            object LabelStart4Link: TLabel
              Left = 18
              Top = 20
              Width = 22
              Height = 13
              Caption = 'Start'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              Transparent = True
            end
            object LabelEnd4Link: TLabel
              Left = 24
              Top = 64
              Width = 19
              Height = 13
              Caption = 'End'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              Transparent = True
            end
            object ButtonAddLink: TButton
              Left = 52
              Top = 36
              Width = 73
              Height = 21
              Caption = 'Add'
              Enabled = False
              TabOrder = 2
              OnClick = ButtonAddLinkClick
            end
            object ComboBoxLinks: TComboBox
              Left = 4
              Top = 84
              Width = 129
              Height = 21
              Style = csDropDownList
              DropDownCount = 13
              ItemHeight = 13
              MaxLength = 13
              PopupMenu = PopupMenuLink
              Sorted = True
              TabOrder = 3
              OnChange = ComboBoxLinksChange
            end
            object ButtonDeleteLink: TButton
              Left = 48
              Top = 104
              Width = 43
              Height = 25
              Caption = 'Delete'
              Enabled = False
              TabOrder = 4
              OnClick = ButtonDeleteLinkClick
            end
            object EditLinkStart: TComboBox
              Left = 48
              Top = 12
              Width = 88
              Height = 21
              DropDownCount = 13
              ItemHeight = 13
              MaxLength = 13
              TabOrder = 0
              OnChange = EditLinkStartEndChange
            end
            object EditLinkFinish: TComboBox
              Left = 48
              Top = 60
              Width = 88
              Height = 21
              DropDownCount = 13
              ItemHeight = 13
              MaxLength = 13
              TabOrder = 1
              OnChange = EditLinkStartEndChange
            end
          end
          object ButtonSaveChain: TButton
            Left = 8
            Top = 34
            Width = 72
            Height = 25
            Caption = 'Save Chain'
            TabOrder = 4
            OnClick = ButtonSaveChainClick
          end
          object ButtonLoadChain: TButton
            Left = 8
            Top = 4
            Width = 72
            Height = 25
            Caption = 'Loa&d Chain'
            TabOrder = 0
            OnClick = ButtonLoadChainClick
          end
          object ButtonLoadDB: TButton
            Left = 88
            Top = 3
            Width = 53
            Height = 25
            Caption = 'Load D&B'
            TabOrder = 1
            OnClick = ButtonLoadDBClick
          end
        end
      end
    end
    object TabSheetConditions: TTabSheet
      HelpContext = 40
      Caption = 'C&onditions'
      ImageIndex = 1
      OnShow = TabSheetConditionsShow
      object ScrollBoxConditions: TScrollBox
        Left = 0
        Top = 0
        Width = 779
        Height = 536
        Align = alClient
        TabOrder = 0
        object PanelDepressionSSK: TPanel
          Left = 409
          Top = 0
          Width = 366
          Height = 532
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object GroupBoxDepression: TGroupBox
            Left = 0
            Top = 0
            Width = 366
            Height = 53
            Align = alTop
            Caption = '&Depression'
            TabOrder = 0
            object LabelDepressionVolume: TLabel
              Left = 80
              Top = 8
              Width = 76
              Height = 13
              Caption = 'Volume, cub.cm'
              Transparent = True
            end
            object LabelDeplessionL: TLabel
              Left = 248
              Top = 8
              Width = 34
              Height = 13
              Caption = '<l>, cm'
              Transparent = True
            end
            object CheckBoxDepression: TCheckBox
              Left = 4
              Top = 16
              Width = 65
              Height = 17
              Caption = 'Consider'
              TabOrder = 0
              OnClick = CheckBoxConsiderClick
            end
            object EditDepressionVolume: TEdit
              Left = 68
              Top = 20
              Width = 125
              Height = 24
              TabOrder = 1
              Text = '1.0'
              OnChange = EditDepressionVolumeChange
            end
            object EditDepressionL: TEdit
              Left = 212
              Top = 20
              Width = 121
              Height = 24
              TabOrder = 2
              Text = '1.0'
              OnChange = EditDepressionLChange
            end
          end
          object GroupBoxSSKinitial: TGroupBox
            Left = 0
            Top = 53
            Width = 366
            Height = 479
            Align = alClient
            Caption = '&Self-Shielding'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            object GroupBoxRAs: TGroupBox
              Left = 2
              Top = 128
              Width = 362
              Height = 173
              Align = alClient
              Caption = '&Res.absorbers'
              TabOrder = 5
              object StringGridRA_Rs: TSortGrid
                Left = 2
                Top = 73
                Width = 358
                Height = 98
                Hint = 
                  'Check the states to take into consideration/account their resona' +
                  'nces !'
                Align = alClient
                DefaultColWidth = 72
                DefaultRowHeight = 19
                FixedCols = 0
                RowCount = 20
                Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goEditing, goTabs]
                ParentShowHint = False
                ScrollBars = ssVertical
                ShowHint = True
                TabOrder = 0
                OnDblClick = StringGridRA_RsDblClick
                OnKeyDown = StringGridRA_RsKeyDown
                OnKeyPress = StringGridRA_RsKeyPress
                OnMouseDown = StringGridRA_RsMouseDown
                OnSelectCell = StringGridRA_RsSelectCell
                SortOptions.CanSort = False
                SortOptions.SortStyle = ssNormal
                SortOptions.SortCaseSensitive = False
                SortOptions.SortCol = 0
                SortOptions.SortDirection = sdDescending
                SortOptions.UpdateOnSizeChange = False
                PrintOptions.Copies = 0
                PrintOptions.PrintRange = prAll
                PrintOptions.FromRow = 0
                PrintOptions.ToRow = 0
                PrintOptions.PreviewPage = 0
                HideRows = False
                Filtered = False
                MultiSelect = False
                AlignmentHorz = taCenter
                AlignmentVert = taMiddle
                BevelStyle = cbNone
                ProportionalScrollBars = False
                ExtendedKeys = False
                OnGetCellFormat = StringGridRA_RsGetCellFormat
                OnCellValidate = StringGridRA_RsCellValidate
                ColWidths = (
                  72
                  72
                  72
                  72
                  471)
              end
              object PanelRAs: TPanel
                Left = 2
                Top = 15
                Width = 358
                Height = 58
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 1
                object LabelRA_V: TLabel
                  Left = 4
                  Top = 20
                  Width = 7
                  Height = 13
                  Caption = 'V'
                end
                object LabelRA_M: TLabel
                  Left = 68
                  Top = 20
                  Width = 9
                  Height = 13
                  Caption = 'M'
                  Visible = False
                end
                object LabelNperCM3: TLabel
                  Left = 120
                  Top = 36
                  Width = 119
                  Height = 15
                  Caption = 'N - nuclei per cub.cm'
                  Font.Charset = RUSSIAN_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                  Transparent = True
                end
                object EditRA_V: TEdit
                  Left = 12
                  Top = 16
                  Width = 52
                  Height = 24
                  TabOrder = 0
                  Text = '20.0'
                  OnChange = EditRA_VChange
                end
                object EditRA_M: TEdit
                  Left = 80
                  Top = 16
                  Width = 52
                  Height = 24
                  Color = 12639424
                  TabOrder = 1
                  Text = '0.24e-3'
                  Visible = False
                end
                object ButtonLoadResPar: TButton
                  Left = 136
                  Top = 12
                  Width = 68
                  Height = 24
                  Caption = 'Load Res'
                  TabOrder = 2
                  OnClick = ButtonLoadResParClick
                end
                object ButtonRA_FillDefaults: TButton
                  Left = 277
                  Top = 12
                  Width = 68
                  Height = 24
                  Caption = 'Defaults'
                  TabOrder = 3
                  OnClick = ButtonRA_FillDefaultsClick
                end
              end
            end
            object GroupBoxMM: TGroupBox
              Left = 2
              Top = 301
              Width = 362
              Height = 92
              Align = alBottom
              Caption = 'Mi&xed moderators'
              TabOrder = 6
              object LabelMM_V: TLabel
                Left = 272
                Top = 20
                Width = 7
                Height = 13
                Caption = 'V'
                Visible = False
              end
              object LabelMM_M: TLabel
                Left = 272
                Top = 48
                Width = 9
                Height = 13
                Caption = 'M'
                Visible = False
              end
              object EditMM_V: TEdit
                Left = 282
                Top = 16
                Width = 80
                Height = 24
                Color = 12639424
                TabOrder = 1
                Text = '0'
                Visible = False
              end
              object EditMM_M: TEdit
                Left = 282
                Top = 44
                Width = 80
                Height = 24
                Color = 12639424
                TabOrder = 2
                Text = '0'
                Visible = False
              end
              object ButtonSaveMM: TButton
                Left = 280
                Top = 60
                Width = 80
                Height = 24
                Caption = 'Save'
                TabOrder = 4
                OnClick = ButtonSaveMMClick
              end
              object ButtonLoadMM: TButton
                Left = 280
                Top = 32
                Width = 80
                Height = 24
                Caption = 'Load'
                TabOrder = 3
                OnClick = ButtonLoadMMClick
              end
              object StringGridMM: TBKStringGrid
                Left = 2
                Top = 15
                Width = 251
                Height = 75
                Align = alLeft
                ColCount = 3
                DefaultColWidth = 80
                DefaultRowHeight = 19
                FixedCols = 0
                RowCount = 2
                Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs, goAlwaysShowEditor]
                TabOrder = 0
                OnKeyUp = StringGridMMKeyUp
                CaseSensitive = False
                SortByFixedCol = False
                Filename = 'TBKStringGrid.txt'
                BlanksDown = True
                Encryption = True
              end
            end
            object GroupBoxOM: TGroupBox
              Left = 2
              Top = 393
              Width = 362
              Height = 84
              Align = alBottom
              Caption = 'Ou&ter Moderator'
              TabOrder = 7
              object LabelOM_V: TLabel
                Left = 84
                Top = 64
                Width = 7
                Height = 13
                Caption = 'V'
              end
              object LabelOM_M: TLabel
                Left = 256
                Top = 52
                Width = 9
                Height = 13
                Caption = 'M'
                Visible = False
              end
              object StringGridOM: TBKStringGrid
                Left = 2
                Top = 15
                Width = 251
                Height = 42
                ColCount = 3
                DefaultColWidth = 80
                DefaultRowHeight = 19
                FixedCols = 0
                RowCount = 2
                Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs, goAlwaysShowEditor]
                TabOrder = 0
                CaseSensitive = False
                SortByFixedCol = False
                Filename = 'TBKStringGrid.txt'
                BlanksDown = True
                Encryption = True
              end
              object EditOM_V: TEdit
                Left = 98
                Top = 59
                Width = 80
                Height = 24
                TabOrder = 1
                Text = '30000'
                OnChange = EditOM_VChange
              end
              object EditOM_M: TEdit
                Left = 266
                Top = 35
                Width = 80
                Height = 24
                Color = 12639424
                TabOrder = 2
                Text = '0'
                Visible = False
              end
              object ButtonLoadOM: TButton
                Left = 280
                Top = 20
                Width = 80
                Height = 24
                Caption = 'Load'
                TabOrder = 3
                OnClick = ButtonLoadOMClick
              end
              object ButtonSaveOM: TButton
                Left = 280
                Top = 56
                Width = 80
                Height = 24
                Caption = 'Save'
                TabOrder = 4
                OnClick = ButtonSaveOMClick
              end
            end
            object PaneRA_Top: TPanel
              Left = 2
              Top = 15
              Width = 362
              Height = 30
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 8
            end
            object PanelBlock: TGroupBox
              Left = 2
              Top = 45
              Width = 362
              Height = 83
              Align = alTop
              Caption = '&Block properties'
              Color = clBtnFace
              ParentColor = False
              TabOrder = 4
              object LabelVblock: TLabel
                Left = 260
                Top = 40
                Width = 36
                Height = 13
                Alignment = taRightJustify
                Caption = 'V block'
                Visible = False
              end
              object LabelSkin_V: TLabel
                Left = 260
                Top = 12
                Width = 29
                Height = 13
                Alignment = taRightJustify
                Caption = 'V skin'
              end
              object LabelBlock_M: TLabel
                Left = 174
                Top = 64
                Width = 38
                Height = 13
                Alignment = taRightJustify
                Caption = 'M block'
                Visible = False
              end
              object LabelSkin_M: TLabel
                Left = 266
                Top = 64
                Width = 31
                Height = 13
                Alignment = taRightJustify
                Caption = 'M skin'
                Visible = False
              end
              object LabelLmean4SSK: TLabel
                Left = 8
                Top = 60
                Width = 34
                Height = 13
                Caption = '<l>, cm'
              end
              object LabelTemperature4SSK: TLabel
                Left = 108
                Top = 60
                Width = 20
                Height = 13
                Alignment = taRightJustify
                Caption = 'T, K'
              end
              object LabelUnits_MV: TLabel
                Left = 116
                Top = 8
                Width = 66
                Height = 15
                Caption = 'V in cub.cm'
                Font.Charset = RUSSIAN_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object RadioGroupCellType: TRadioGroup
                Left = 0
                Top = 20
                Width = 257
                Height = 33
                Caption = 'Ce&ll'
                Columns = 3
                ItemIndex = 0
                Items.Strings = (
                  'No'
                  'Sq'
                  'Hex')
                TabOrder = 0
                OnClick = RadioGroupCellTypeClick
              end
              object EditTemperature: TEdit
                Left = 132
                Top = 56
                Width = 37
                Height = 24
                TabOrder = 2
                Text = '320'
                OnChange = EditTemperatureChange
              end
              object EditBlock_V: TEdit
                Left = 296
                Top = 36
                Width = 48
                Height = 24
                Color = 12639424
                TabOrder = 5
                Text = '250'
                Visible = False
              end
              object EditSkin_V: TEdit
                Left = 292
                Top = 8
                Width = 48
                Height = 24
                Color = clWhite
                TabOrder = 3
                Text = '0'
              end
              object EditBlock_M: TEdit
                Left = 212
                Top = 60
                Width = 48
                Height = 24
                Color = 12639424
                TabOrder = 4
                Text = '270'
                Visible = False
              end
              object EditSkin_M: TEdit
                Left = 300
                Top = 60
                Width = 48
                Height = 24
                Color = 12639424
                TabOrder = 6
                Text = '0,0012345'
                Visible = False
              end
              object Editl_mean: TEdit
                Left = 48
                Top = 56
                Width = 57
                Height = 24
                TabOrder = 1
                Text = '1'
                OnChange = Editl_meanChange
              end
              object ButtonSaveSSKconditions: TButton
                Left = 180
                Top = 56
                Width = 75
                Height = 24
                Caption = 'Save'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 7
                OnClick = ButtonSaveSSKconditionsClick
              end
              object ButtonLoadSSKconditions: TButton
                Left = 268
                Top = 55
                Width = 75
                Height = 24
                Caption = 'Load'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 8
                OnClick = ButtonLoadSSKconditionsClick
              end
            end
            object CheckBoxSSKconsider: TCheckBox
              Left = 8
              Top = 18
              Width = 65
              Height = 17
              Caption = 'Consider'
              TabOrder = 0
              OnClick = CheckBoxConsiderClick
            end
            object ButtonBuildResTable: TButton
              Left = 92
              Top = 18
              Width = 75
              Height = 24
              Caption = 'Build Table'
              TabOrder = 1
              OnClick = ButtonBuildResTableClick
            end
            object ButtonLoadResTable: TButton
              Left = 188
              Top = 18
              Width = 75
              Height = 24
              Caption = 'Load Table'
              TabOrder = 2
              OnClick = ButtonLoadResTableClick
            end
            object ButtonSaveResTable: TButton
              Left = 284
              Top = 18
              Width = 75
              Height = 24
              Caption = 'Save Table'
              TabOrder = 3
              OnClick = ButtonSaveResTableClick
            end
          end
        end
        object GroupBoxInitialValues: TGroupBox
          Left = 0
          Top = 0
          Width = 409
          Height = 532
          Align = alLeft
          Caption = 'Initial &Values                     |   Tolerances  '
          TabOrder = 1
          object GroupBoxInitialWhat: TGroupBox
            Left = 269
            Top = 15
            Width = 139
            Height = 515
            Align = alLeft
            Caption = '&Mass, g '
            TabOrder = 1
            object RadioButtonNuclei: TRadioButton
              Left = 52
              Top = 0
              Width = 113
              Height = 17
              Caption = 'Nuclei'
              Color = 12639424
              Enabled = False
              ParentColor = False
              TabOrder = 1
              Visible = False
              OnClick = RadioButtonMassesNucleiClick
            end
            object RadioButtonMasses: TRadioButton
              Left = 8
              Top = 16
              Width = 113
              Height = 17
              Caption = 'Masses, g'
              Checked = True
              Color = 12639424
              ParentColor = False
              TabOrder = 0
              TabStop = True
              Visible = False
              OnClick = RadioButtonMassesNucleiClick
            end
            object StringGridMasses: TStringGrid
              Left = 2
              Top = 15
              Width = 135
              Height = 381
              Align = alClient
              ColCount = 2
              DefaultRowHeight = 19
              RowCount = 2
              FixedRows = 0
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
              TabOrder = 2
              OnKeyDown = StringGridMassesKeyDown
              OnSetEditText = StringGridMassesSetEditText
            end
            object PanelMassButtons: TPanel
              Left = 2
              Top = 396
              Width = 135
              Height = 117
              Align = alBottom
              BevelOuter = bvNone
              TabOrder = 3
              object LabelTotalMass: TLabel
                Left = 4
                Top = 9
                Width = 64
                Height = 13
                Caption = 'Total Mass, g'
              end
              object EditTotalMass: TEdit
                Left = 8
                Top = 25
                Width = 105
                Height = 24
                TabOrder = 0
                OnChange = EditTotalMassChange
              end
              object ButtonLoadInitials: TButton
                Left = 24
                Top = 53
                Width = 75
                Height = 25
                Caption = 'Load'
                TabOrder = 1
                OnClick = ButtonLoadInitialsClick
              end
              object ButtonSaveInitials: TButton
                Left = 24
                Top = 85
                Width = 75
                Height = 25
                Caption = 'Save'
                TabOrder = 2
                OnClick = ButtonSaveInitialsClick
              end
            end
          end
          object StringGridInitialValues: TBKStringGrid
            Left = 2
            Top = 15
            Width = 267
            Height = 515
            Align = alLeft
            ColCount = 4
            DefaultColWidth = 60
            DefaultRowHeight = 19
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
            TabOrder = 0
            OnKeyDown = StringGridInitialValuesKeyDown
            OnSetEditText = StringGridInitialValuesSetEditText
            CaseSensitive = False
            SortByFixedCol = False
            Filename = 'TBKStringGrid.txt'
            BlanksDown = True
            Encryption = True
            OnUserChangedCell = StringGridInitialValuesUserChangedCell
          end
          object CheckBoxPercent: TCheckBox
            Left = 88
            Top = 0
            Width = 30
            Height = 14
            Caption = '&%'
            TabOrder = 2
          end
        end
      end
    end
    object TabSheetTimes: TTabSheet
      HelpContext = 50
      Caption = 'T&imes'
      ImageIndex = 2
      object LabelTimesFileName: TLabel
        Left = 0
        Top = 0
        Width = 779
        Height = 13
        Align = alTop
        Caption = 'File: '
      end
      object ScrollBoxTimes: TScrollBox
        Left = 0
        Top = 13
        Width = 779
        Height = 486
        HorzScrollBar.Smooth = True
        HorzScrollBar.Style = ssFlat
        Align = alClient
        TabOrder = 0
        object GroupBox1: TGroupBox
          Tag = 1
          Left = 0
          Top = 0
          Width = 188
          Height = 482
          Align = alLeft
          Caption = 'Time Intervals 1'
          TabOrder = 0
          object Label6: TLabel
            Tag = 8
            Left = 2
            Top = 468
            Width = 3
            Height = 13
            Hint = 'Days     Power*Days'
            Align = alBottom
            Alignment = taCenter
          end
          object Memo1: TMemo
            Tag = 1
            Left = 2
            Top = 15
            Width = 184
            Height = 304
            Align = alClient
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssVertical
            TabOrder = 0
            OnChange = TimesChange
          end
          object Panel1: TPanel
            Left = 2
            Top = 319
            Width = 184
            Height = 149
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 1
            object Label1: TLabel
              Left = 72
              Top = 28
              Width = 30
              Height = 13
              Caption = 'Fluxes'
            end
            object Label2: TLabel
              Tag = 1
              Left = 6
              Top = 52
              Width = 13
              Height = 13
              Caption = 'Th'
            end
            object Label3: TLabel
              Tag = 2
              Left = 6
              Top = 76
              Width = 19
              Height = 13
              Caption = 'Res'
            end
            object Label4: TLabel
              Tag = 3
              Left = 6
              Top = 100
              Width = 20
              Height = 13
              Caption = 'Fast'
            end
            object Label5: TLabel
              Tag = 4
              Left = 12
              Top = 128
              Width = 38
              Height = 13
              Caption = 'Nominal'
            end
            object CheckBox1: TCheckBox
              Tag = 1
              Left = 24
              Top = 8
              Width = 45
              Height = 17
              Caption = 'Tn.g'
              Checked = True
              State = cbChecked
              TabOrder = 0
            end
            object Edit4: TEdit
              Tag = 4
              Left = 68
              Top = 4
              Width = 57
              Height = 21
              TabOrder = 1
              Text = '300.0'
              OnChange = TimesChange
            end
            object Edit1: TEdit
              Tag = 1
              Left = 28
              Top = 44
              Width = 140
              Height = 21
              TabOrder = 2
              Text = '0'
              OnChange = TimesChange
            end
            object Edit2: TEdit
              Tag = 2
              Left = 28
              Top = 68
              Width = 140
              Height = 21
              TabOrder = 3
              Text = '0'
              OnChange = TimesChange
            end
            object Edit3: TEdit
              Tag = 3
              Left = 28
              Top = 92
              Width = 140
              Height = 21
              TabOrder = 4
              Text = '0'
              OnChange = TimesChange
            end
            object Edit5: TEdit
              Tag = 5
              Left = 56
              Top = 120
              Width = 73
              Height = 21
              TabOrder = 5
              Text = '100'
              OnChange = TimesChange
            end
          end
        end
      end
      object PanelTimesCommon: TPanel
        Left = 0
        Top = 499
        Width = 779
        Height = 37
        Align = alBottom
        BevelInner = bvLowered
        BevelOuter = bvLowered
        TabOrder = 1
        OnResize = PanelTimesCommonResize
        object BitBtnApplyAllTimes: TBitBtn
          Tag = 1
          Left = 4
          Top = 6
          Width = 57
          Height = 25
          Caption = 'Apply'
          TabOrder = 0
          OnClick = BitBtnApplyAllTimesClick
          Kind = bkYes
        end
        object BitBtnDelLastTimeInterval: TBitBtn
          Tag = 2
          Left = 182
          Top = 6
          Width = 57
          Height = 25
          Caption = 'Del'
          Enabled = False
          TabOrder = 1
          OnClick = BitBtnDelLastTimeIntervalClick
          Kind = bkAbort
        end
        object BitBtnNewTimeInterval: TBitBtn
          Tag = 3
          Left = 248
          Top = 6
          Width = 59
          Height = 25
          Caption = 'New'
          TabOrder = 2
          OnClick = BitBtnNewTimeIntervalClick
          Kind = bkRetry
          Layout = blGlyphRight
        end
        object ButtonTimesFileSave: TButton
          Left = 660
          Top = 6
          Width = 75
          Height = 25
          Caption = 'Save'
          TabOrder = 4
          OnClick = ButtonTimesFileSaveClick
        end
        object ButtonTimesFileOpen: TButton
          Left = 572
          Top = 6
          Width = 75
          Height = 25
          Caption = 'Load'
          TabOrder = 3
          OnClick = ButtonTimesFileOpenClick
        end
        object CheckBoxTimesAutoApply: TCheckBox
          Left = 72
          Top = 10
          Width = 97
          Height = 17
          Caption = 'AutoApply'
          Checked = True
          State = cbChecked
          TabOrder = 5
        end
      end
    end
    object TabSheetCalc: TTabSheet
      HelpContext = 60
      Caption = '&Calc'
      ImageIndex = 3
      OnShow = TabSheetCalcShow
      object SplitterCalcPage: TSplitter
        Left = 525
        Top = 61
        Width = 3
        Height = 475
        Cursor = crHSplit
        Align = alRight
      end
      object PanelCalcRight: TPanel
        Left = 528
        Top = 61
        Width = 251
        Height = 475
        Align = alRight
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
        object LabelSolverStdOut: TLabel
          Left = 2
          Top = 2
          Width = 86
          Height = 13
          Align = alTop
          Caption = '  Solver messages'
        end
        object MemoCalculatorStdOut: TMemo
          Left = 2
          Top = 15
          Width = 247
          Height = 451
          Align = alClient
          ScrollBars = ssBoth
          TabOrder = 0
          WordWrap = False
        end
        object ButtonTestCalc: TButton
          Left = 36
          Top = 320
          Width = 75
          Height = 25
          Caption = 'Test'
          TabOrder = 1
          Visible = False
          OnClick = ButtonTestCalcClick
        end
      end
      object StringGridResults: TStringGrid
        Left = 0
        Top = 61
        Width = 525
        Height = 475
        Align = alClient
        Color = clSilver
        ColCount = 3
        DefaultRowHeight = 21
        FixedCols = 2
        RowCount = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goTabs]
        ParentFont = False
        TabOrder = 1
      end
      object PanelCalcTop: TScrollBox
        Left = 0
        Top = 0
        Width = 779
        Height = 61
        Align = alTop
        BorderStyle = bsNone
        Color = clBtnFace
        ParentColor = False
        TabOrder = 0
        object ProgressBarCalc: TProgressBar
          Left = 532
          Top = 5
          Width = 201
          Height = 15
          Min = 0
          Max = 128
          TabOrder = 0
        end
        object CheckBoxDLL: TCheckBox
          Left = 376
          Top = 11
          Width = 54
          Height = 18
          Caption = '&DLL'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object CheckBoxJAC: TCheckBox
          Left = 376
          Top = 28
          Width = 54
          Height = 17
          Caption = '&JAC'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object ButtonCalc: TButton
          Left = 424
          Top = 12
          Width = 101
          Height = 25
          Caption = 'C&alc'
          Default = True
          TabOrder = 4
          OnClick = ButtonCalcClick
        end
        object ButtonAbortCalc: TButton
          Left = 553
          Top = 24
          Width = 167
          Height = 21
          Hint = 'Abort Calc'
          Caption = 'A&bort Calc'
          Enabled = False
          TabOrder = 5
          OnClick = ButtonAbortCalcClick
        end
        object RadioGroupSolver: TGroupBox
          Left = 4
          Top = 4
          Width = 369
          Height = 41
          Caption = 'Solver'
          TabOrder = 3
          OnClick = RadioGroupSolverClick
          object RadioButtonVODE: TRadioButton
            Left = 100
            Top = 16
            Width = 80
            Height = 17
            Caption = '&VODE'
            TabOrder = 0
            OnClick = RadioGroupSolverClick
          end
          object RadioButtonLSODA: TRadioButton
            Left = 8
            Top = 16
            Width = 80
            Height = 21
            Caption = '&LSODA'
            Checked = True
            TabOrder = 1
            TabStop = True
            OnClick = RadioGroupSolverClick
          end
          object RadioButtonRADAU: TRadioButton
            Left = 193
            Top = 16
            Width = 80
            Height = 17
            Caption = '&RADAU'
            TabOrder = 2
            OnClick = RadioGroupSolverClick
          end
          object RadioButtonMEBDF: TRadioButton
            Left = 288
            Top = 16
            Width = 77
            Height = 17
            Caption = '&MEBDF'
            TabOrder = 3
            OnClick = RadioGroupSolverClick
          end
        end
      end
    end
    object TabSheetAnswers: TTabSheet
      HelpContext = 70
      Caption = 'Ans&wers'
      ImageIndex = 4
      OnShow = TabSheetAnswersShow
      object StringGridAnswers: TStringGrid
        Left = 0
        Top = 0
        Width = 592
        Height = 536
        Align = alClient
        ColCount = 3
        DefaultRowHeight = 21
        FixedCols = 2
        RowCount = 2
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goEditing, goTabs]
        ParentFont = False
        TabOrder = 0
        OnColumnMoved = StringGridAnswersColumnMoved
        OnKeyDown = StringGridAnswersKeyDown
      end
      object ScrollBox1: TScrollBox
        Left = 592
        Top = 0
        Width = 187
        Height = 536
        Align = alRight
        TabOrder = 1
        object PanelAnswers: TPanel
          Left = 0
          Top = 0
          Width = 163
          Height = 441
          BevelOuter = bvNone
          TabOrder = 0
          object RadioGroupAnswers: TRadioGroup
            Left = 4
            Top = 26
            Width = 149
            Height = 303
            Caption = 'Wh&at'
            Enabled = False
            ItemIndex = 1
            Items.Strings = (
              'Nuclei'
              'Isotope mass, g'
              'Element mass, g'
              'Activity A'
              'Activity B-'
              'Activity EC'
              'Activity IT'
              'Activity Total'
              'Activity per element g'
              'Isotopes parts (mass)'
              'Mass yield'
              'Depression'
              'SSK (slow !!!)'
              'SSK approx.'
              'Fiss.engr.(MeV,on 200)')
            TabOrder = 1
            OnClick = RadioGroupAnswersClick
          end
          object ButtonTestAnswers: TButton
            Left = 60
            Top = 384
            Width = 75
            Height = 25
            Caption = 'Test'
            TabOrder = 5
            Visible = False
            OnClick = ButtonTestCalcClick
          end
          object RadioGroupActivityUnits: TRadioGroup
            Left = 4
            Top = 336
            Width = 149
            Height = 45
            Caption = 'Activity &Units'
            Columns = 2
            ItemIndex = 1
            Items.Strings = (
              'Bq'
              'Ci')
            TabOrder = 2
            OnClick = RadioGroupActivityUnitsClick
          end
          object ButtonExcelExport: TButton
            Left = 16
            Top = 388
            Width = 75
            Height = 25
            Caption = 'E&xcel'
            Enabled = False
            TabOrder = 3
            OnClick = ButtonExcelExportClick
          end
          object CheckBoxAnswersA_Z: TCheckBox
            Left = 8
            Top = 4
            Width = 73
            Height = 17
            Caption = 'A...&Z'
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            State = cbChecked
            TabOrder = 0
            OnClick = CheckBoxAnswersA_ZClick
          end
          object CheckBoxSaveSlow: TCheckBox
            Left = 24
            Top = 416
            Width = 121
            Height = 21
            Caption = 'Sa&ve slow results'
            TabOrder = 4
          end
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Others'
      ImageIndex = 5
      object LabelOthers: TLabel
        Left = 148
        Top = 168
        Width = 420
        Height = 44
        Caption = 
          '       YOU MAY USE IT FOR EVERYTHING'#13#10' (Caution: It works under ' +
          'Windows 3.11 only !)'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object ButtonDoNotClick: TButton
        Left = 324
        Top = 380
        Width = 87
        Height = 55
        Caption = 'Do NOT press !'
        TabOrder = 0
        OnClick = ButtonDoNotClickClick
      end
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'chn'
    Filter = 
      'Chain Files (*.chn)|*.chn|Power graphic files (*.pow)|*.pow|Mixe' +
      'd Moderators (*.mm)|*.mm|Outer Moderators (*.om)|*.om|Res Table ' +
      '(*.rtb)|*.rtb|Initial Values file (*.ivl)|*.ivl|Excel Files   (*' +
      '.xls)|*.xls|Self-shielding Conditions (*.ssc)|*.ssc|All Files   ' +
      '(*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 427
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'chn'
    Filter = 
      'Chain Files (*.chn)|*.chn|Power graphic files (*.pow)|*.pow|Mixe' +
      'd Moderators (*.mm)|*.mm|Outer Moderators (*.om)|*.om|Res Table ' +
      '(*.rtb)|*.rtb|Initial Values file (*.ivl)|*.ivl|Excel Files  (*.' +
      'xls)|*.xls|Self-shielding Conditions (*.ssc)|*.ssc|All Files  (*' +
      '.*)|*.*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 375
  end
  object mxNativeExcel: TmxNativeExcel
    ActiveFont = 0
    Borders = []
    Shading = False
    Version = '1.22'
    Left = 520
  end
  object PopupMenuCAD: TPopupMenu
    AutoHotkeys = maManual
    AutoPopup = False
    OnPopup = PopupMenuCADPopup
    Left = 102
    Top = 71
    object ItemShowHalfLifes: TMenuItem
      Caption = 'Show &half-life'
      OnClick = ItemShowHalfLifesClick
    end
    object ItemShowCrossSections: TMenuItem
      Caption = 'Show cro&ss-sections'
      OnClick = ItemShowCrossSectionsClick
    end
    object ItemShowRI: TMenuItem
      Caption = 'Show &RI'
      OnClick = ItemShowRIClick
    end
    object CopyStateNames: TMenuItem
      Caption = 'Copy state &names'
      OnClick = CopyStateNamesClick
    end
    object ItemHidefissionlinks: TMenuItem
      Caption = 'Hide &fission links'
      OnClick = ItemHidefissionlinksClick
    end
    object ItemUseIndYieldsForState: TMenuItem
      Caption = 'Use &IndYields'
      OnClick = ItemUseIndYieldsForStateClick
    end
    object ItemUseCumYieldsForState: TMenuItem
      Caption = 'Use &CumYields'
      OnClick = ItemUseCumYieldsForStateClick
    end
    object ItemZoomIn: TMenuItem
      Caption = '&Zoom In'
      OnClick = ItemZoomInClick
    end
    object ItemZoomOut: TMenuItem
      Caption = 'Zoom &Out'
      OnClick = ItemZoomOutClick
    end
    object ItemSaveMetafile: TMenuItem
      Caption = 'Save &metafile'
      OnClick = ItemSaveMetafileClick
    end
    object ItemAddStateChilds: TMenuItem
      Caption = 'Add &descendants'
      OnClick = ItemAddStateChildsClick
    end
  end
  object PopupMenuLink: TPopupMenu
    AutoPopup = False
    Left = 528
    Top = 338
    object LinkPopupItemUseIndYieldForLink: TMenuItem
      Caption = 'Use- &IndYield'
      OnClick = LinkPopupItemUseIndYieldForLinkClick
    end
    object LinkPopupItemUseCumYieldForLink: TMenuItem
      Caption = 'Use- &CumYields'
      OnClick = LinkPopupItemUseCumYieldForLinkClick
    end
  end
end
