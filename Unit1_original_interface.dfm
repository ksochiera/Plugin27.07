object Form1: TForm1
  Left = 430
  Top = 175
  BorderStyle = bsSingle
  Caption = 'U'#347'redniacz'
  ClientHeight = 473
  ClientWidth = 990
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 8
    Width = 22
    Height = 13
    Caption = 'Pkt1'
  end
  object Label2: TLabel
    Left = 180
    Top = 8
    Width = 10
    Height = 13
    Caption = 'X:'
  end
  object Label3: TLabel
    Left = 328
    Top = 8
    Width = 10
    Height = 13
    Caption = 'Y:'
  end
  object Label4: TLabel
    Left = 476
    Top = 8
    Width = 11
    Height = 13
    Caption = 'H:'
  end
  object Label5: TLabel
    Left = 12
    Top = 32
    Width = 22
    Height = 13
    Caption = 'Pkt2'
  end
  object Label6: TLabel
    Left = 180
    Top = 32
    Width = 10
    Height = 13
    Caption = 'X:'
  end
  object Label7: TLabel
    Left = 328
    Top = 32
    Width = 10
    Height = 13
    Caption = 'Y:'
  end
  object Label8: TLabel
    Left = 476
    Top = 32
    Width = 11
    Height = 13
    Caption = 'H:'
  end
  object Label9: TLabel
    Left = 8
    Top = 68
    Width = 39
    Height = 13
    Caption = #346'rednia:'
  end
  object Label10: TLabel
    Left = 180
    Top = 68
    Width = 10
    Height = 13
    Caption = 'X:'
  end
  object Label11: TLabel
    Left = 328
    Top = 68
    Width = 10
    Height = 13
    Caption = 'Y:'
  end
  object Label12: TLabel
    Left = 476
    Top = 68
    Width = 11
    Height = 13
    Caption = 'H:'
  end
  object SpeedButton1: TSpeedButton
    Left = 576
    Top = 60
    Width = 73
    Height = 29
    Caption = 'DO BAZY'
    OnClick = SpeedButton1Click
  end
  object Edit1: TEdit
    Left = 52
    Top = 4
    Width = 121
    Height = 21
    TabOrder = 0
    OnExit = Edit1Exit
  end
  object Edit2: TEdit
    Left = 196
    Top = 4
    Width = 121
    Height = 21
    TabOrder = 1
    OnExit = Edit2Exit
  end
  object Edit3: TEdit
    Left = 344
    Top = 4
    Width = 121
    Height = 21
    TabOrder = 2
    OnExit = Edit2Exit
  end
  object Edit4: TEdit
    Left = 492
    Top = 4
    Width = 77
    Height = 21
    TabOrder = 3
    OnExit = Edit2Exit
  end
  object Edit5: TEdit
    Left = 52
    Top = 28
    Width = 121
    Height = 21
    TabOrder = 4
    OnExit = Edit5Exit
  end
  object Edit6: TEdit
    Left = 196
    Top = 28
    Width = 121
    Height = 21
    TabOrder = 5
    OnExit = Edit2Exit
  end
  object Edit7: TEdit
    Left = 344
    Top = 28
    Width = 121
    Height = 21
    TabOrder = 6
    OnExit = Edit2Exit
  end
  object Edit8: TEdit
    Left = 492
    Top = 28
    Width = 77
    Height = 21
    TabOrder = 7
    OnExit = Edit2Exit
  end
  object Edit9: TEdit
    Left = 52
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 8
  end
  object Edit10: TEdit
    Left = 196
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 9
  end
  object Edit11: TEdit
    Left = 344
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 10
  end
  object Edit12: TEdit
    Left = 492
    Top = 64
    Width = 77
    Height = 21
    TabOrder = 11
  end
  object Button1: TButton
    Left = 8
    Top = 96
    Width = 301
    Height = 25
    Caption = 'Wczytaj punkty zaznaczone w tabeli roboczej'
    TabOrder = 12
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 124
    Width = 321
    Height = 85
    TabOrder = 13
  end
  object Button2: TButton
    Left = 8
    Top = 220
    Width = 301
    Height = 25
    Caption = 'Wczytaj zaznaczony obiekt na mapie C-Geo'
    TabOrder = 14
    OnClick = Button2Click
  end
  object Memo2: TMemo
    Left = 16
    Top = 248
    Width = 321
    Height = 85
    TabOrder = 15
  end
  object Button3: TButton
    Left = 8
    Top = 348
    Width = 301
    Height = 25
    Caption = 'Wy'#347'lij obiekt na map'#281' w C-Geo'
    TabOrder = 16
    OnClick = Button3Click
  end
  object Memo3: TMemo
    Left = 16
    Top = 376
    Width = 321
    Height = 85
    Lines.Strings = (
      'o(100;100)(100;200)(200;200)(200;100)')
    TabOrder = 17
  end
  object GroupBox1: TGroupBox
    Left = 348
    Top = 380
    Width = 245
    Height = 81
    Caption = 'Uchwyt okna c-geo:'
    TabOrder = 18
    object Label13: TLabel
      Left = 8
      Top = 20
      Width = 125
      Height = 13
      Caption = 'Przekazany jako parametr:'
    end
    object SpeedButton2: TSpeedButton
      Left = 8
      Top = 40
      Width = 125
      Height = 22
      Caption = 'Wyszukaj samodzielnie'
      OnClick = SpeedButton2Click
    end
    object ed_par: TEdit
      Left = 144
      Top = 16
      Width = 85
      Height = 21
      TabOrder = 0
    end
    object ed_find: TEdit
      Left = 144
      Top = 40
      Width = 85
      Height = 21
      TabOrder = 1
    end
  end
  object BitBtn1: TBitBtn
    Left = 356
    Top = 108
    Width = 169
    Height = 25
    Caption = 'Zapisz raport w formacie rtf'
    TabOrder = 19
    OnClick = BitBtn1Click
  end
  object RichEdit1: TRichEdit
    Left = 356
    Top = 136
    Width = 277
    Height = 153
    Lines.Strings = (
      'RichEdit1')
    ParentShowHint = False
    ScrollBars = ssBoth
    ShowHint = False
    TabOrder = 20
  end
  object BitBtn2: TBitBtn
    Left = 664
    Top = 108
    Width = 169
    Height = 25
    Caption = 'Zapisz raport w formacie html'
    TabOrder = 21
    OnClick = BitBtn2Click
  end
  object WebBrowser1: TWebBrowser
    Left = 664
    Top = 136
    Width = 300
    Height = 150
    TabOrder = 22
    ControlData = {
      4C000000021F0000810F00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object GroupBox2: TGroupBox
    Left = 604
    Top = 380
    Width = 341
    Height = 81
    Caption = 'Obs'#322'uga klikania na mapie:'
    TabOrder = 23
    object CheckBox1: TCheckBox
      Left = 8
      Top = 16
      Width = 317
      Height = 17
      Caption = 'w'#322#261'cz wysylanie wsp'#243#322'rz'#281'dnych z aktywnego okna mapy'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object Edit13: TEdit
      Left = 8
      Top = 36
      Width = 321
      Height = 21
      TabOrder = 1
    end
    object CheckBox2: TCheckBox
      Left = 8
      Top = 60
      Width = 249
      Height = 17
      Caption = 'wstaw znacznik w meiscu klini'#281'ciecia'
      TabOrder = 2
    end
  end
end
