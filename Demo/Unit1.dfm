object FormDGLDemo: TFormDGLDemo
  Left = 257
  Top = 185
  Width = 559
  Height = 424
  Caption = 'FormDGLDemo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 137
    Height = 193
    Caption = 'Serial Container'
    TabOrder = 0
    object btn_IIntVector: TButton
      Left = 16
      Top = 24
      Width = 105
      Height = 25
      Caption = 'IIntVector'
      TabOrder = 0
      OnClick = btn_IIntVectorClick
    end
    object btn_TIntVector: TButton
      Left = 16
      Top = 56
      Width = 105
      Height = 25
      Caption = 'TIntVector'
      TabOrder = 1
      OnClick = btn_TIntVectorClick
    end
    object btn_IIntDeque: TButton
      Left = 16
      Top = 88
      Width = 105
      Height = 25
      Caption = 'IIntDeque'
      TabOrder = 2
      OnClick = btn_IIntDequeClick
    end
    object btn_IPointerList: TButton
      Left = 16
      Top = 120
      Width = 105
      Height = 25
      Caption = 'IPointerList'
      TabOrder = 3
      OnClick = btn_IPointerListClick
    end
    object btn_IIntSerialContainer: TButton
      Left = 16
      Top = 152
      Width = 105
      Height = 25
      Caption = 'IIntSerialContainer'
      TabOrder = 4
      OnClick = btn_IIntSerialContainerClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 152
    Top = 8
    Width = 145
    Height = 193
    Caption = 'Map/Set'
    TabOrder = 1
    object btn_IPointerSet: TButton
      Left = 16
      Top = 88
      Width = 113
      Height = 25
      Caption = 'IPointerSet'
      TabOrder = 0
      OnClick = btn_IPointerSetClick
    end
    object btn_IPointerMultiSet: TButton
      Left = 16
      Top = 120
      Width = 113
      Height = 25
      Caption = 'IPointerMultiSet'
      TabOrder = 1
      OnClick = btn_IPointerMultiSetClick
    end
    object btn_IStrIntMap: TButton
      Left = 16
      Top = 24
      Width = 113
      Height = 25
      Caption = 'IStrIntMap'
      TabOrder = 2
      OnClick = btn_IStrIntMapClick
    end
    object btn_IStrMultiMap: TButton
      Left = 16
      Top = 56
      Width = 113
      Height = 25
      Caption = 'IStrMultiMap'
      TabOrder = 3
      OnClick = btn_IStrMultiMapClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 312
    Top = 8
    Width = 137
    Height = 193
    Caption = 'other'
    TabOrder = 2
    object btn_IByteIterator: TButton
      Left = 16
      Top = 136
      Width = 105
      Height = 25
      Caption = 'IByteIterator'
      TabOrder = 0
      OnClick = btn_IByteIteratorClick
    end
    object btn_IIntStack: TButton
      Left = 16
      Top = 24
      Width = 105
      Height = 25
      Caption = 'IIntStack'
      TabOrder = 1
      OnClick = btn_IIntStackClick
    end
    object btn_IByteQueue: TButton
      Left = 16
      Top = 56
      Width = 105
      Height = 25
      Caption = 'IByteQueue'
      TabOrder = 2
      OnClick = btn_IByteQueueClick
    end
    object btn_IIntPriorityQueue: TButton
      Left = 16
      Top = 88
      Width = 105
      Height = 25
      Caption = 'IIntPriorityQueue'
      TabOrder = 3
      OnClick = btn_IIntPriorityQueueClick
    end
  end
end
