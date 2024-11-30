unit UnitCWord;

interface

uses
  SysUtils, Types, Classes, Variants,Graphics, Controls, Forms, 
  Dialogs, StdCtrls,Clipbrd,
  _DGL_IntVectorVector,DGL_integer,DGL_String,
  ComCtrls,_DGLMap_String_Integer,_DGL_String_IntegerRecord;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Memo1: TMemo;
    ListView1: TListView;
    btStatWord: TButton;
    Edit1: TEdit;
    TabSheet2: TTabSheet;
    lvPerfo: TListView;
    Button3: TButton;
    Button4: TButton;
    btnTestVector: TButton;
    Button1: TButton;
    Button2: TButton;
    Button5: TButton;
    procedure btStatWordClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnTestVectorClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    function ComparePairStrInt(const a,b:TPairStrInt):Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

  
var
  Form1: TForm1;
  a:TList;
implementation
uses
  MMSystem;

  var _RandSeed:longword=12902357;
  function _rand():longword;
  begin
    result:=_RandSeed*1103515245+12345;
    _RandSeed:=result;
  end;

{$R *.dfm}

  function GetNowTime():extended; //us
  begin
    //result:=(Now*24 * 3600 * 1000*1000.0);
    result:=TimeGetTime()*1000;
  end;

  function FormatTime(RunTime: extended;const pxStr:string=''):string;
  const
    ResultFormat = '%.3f us';
  begin
    result:=pxStr+Format(ResultFormat,[RunTime])
  end;

  function GetNextWord(const text:string;var PosIndex: _TNativeInt):string;
  var
    WordBegin: _TNativeInt;
  begin
    while (PosIndex<=length(text)) do
    begin
      if text[PosIndex] in ['a'..'z','A'..'Z','_'] then
      begin
        //{get WordEnd
        WordBegin:=PosIndex;
        inc(PosIndex);
        while (PosIndex<=length(text)) do
        begin
          if not (text[PosIndex] in ['a'..'z','A'..'Z','_']) then
            break;
          inc(PosIndex);
        end;
        //{
        result:=copy(text,WordBegin,PosIndex-WordBegin);
        exit;
      end;
      inc(PosIndex);
    end;
    result:='';
  end;

  function TForm1.ComparePairStrInt(const a,
    b: TPairStrInt): Boolean;
  begin
    if (a.Value=b.Value) then
      result:=a.Key<b.Key
    else
      result:=a.Value>b.Value;
  end;

procedure TForm1.btStatWordClick(Sender: TObject);
var
  StrIntMap : IStrIntMap;
  strValue  : string;
  strWord   : string;
  Iterator  : IStrIntMapIterator;
  ListItem  : TListItem;
  BeginIndex: _TNativeInt;
  SumWord   : _TNativeInt;
  SumWordCout : _TNativeInt;
  i,RunTimes : _TNativeInt;
  StrIntVector : IStrIntVector;
  ItVector     : IStrIntIterator;
  tgetWordTime : extended;
  tSortWordTime : extended;
  Start: extended;
begin
  StrIntMap:=TStrIntHashMap.Create();
  strValue:=self.Memo1.Text;
  RunTimes:=1000;

  Start:=GetNowTime();
  for i:=0 to RunTimes-1 do
  begin
    StrIntMap.Clear();
    BeginIndex:=1;
    strWord:=GetNextWord(strValue,BeginIndex);
    while strWord<>'' do
    begin
      Iterator:=StrIntMap.Find(strWord);
      if Iterator.IsEqual(StrIntMap.ItEnd) then
        StrIntMap.Items[strWord]:=1
      else
        Iterator.Value:=Iterator.Value+1;
      strWord:=GetNextWord(strValue,BeginIndex);
    end;
  end;
  tgetWordTime:=(GetNowTime-Start)/RunTimes;

  Start:=GetNowTime();
  StrIntVector :=TStrIntVector.Create();
  Iterator:=StrIntMap.ItBegin;
  while not Iterator.IsEqual(StrIntMap.ItEnd) do
  begin
    StrIntVector.PushBack(Pair_StrInt(Iterator.Key,Iterator.Value));
    Iterator.Next();
  end;
  for i:=0 to RunTimes-1 do
  begin
   TStrIntAlgorithms.RandomShuffle(StrIntVector.ItBegin,StrIntVector.ItEnd);
   TStrIntAlgorithms.Sort(StrIntVector.ItBegin,StrIntVector.ItEnd,self.ComparePairStrInt);
   //Assert(TStrIntAlgorithms.IsSorted(StrIntVector.ItBegin,StrIntVector.ItEnd,self.ComparePairStrInt));
   //TStrIntAlgorithms.Sort(StrIntVector.ItBegin,StrIntVector.ItEnd);
   //TStrIntAlgorithms.SortHeap(StrIntVector.ItBegin,StrIntVector.ItEnd,self.ComparePairStrInt);
  end;
  tSortWordTime:=(GetNowTime-Start)/RunTimes;

  self.ListView1.Items.Clear();
  SumWordCout:=0;
  SumWord:=0;
  ItVector:=StrIntVector.ItBegin;
  while not ItVector.IsEqual(StrIntVector.ItEnd) do
  begin
    ListItem:=self.ListView1.Items.Add;
    ListItem.Caption:=ItVector.Value.Key;
    ListItem.SubItems.Add(inttostr(ItVector.Value.Value));
    inc(SumWordCout,ItVector.Value.Value);
    inc(SumWord);
    ItVector.Next();
  end;

  ListItem:=self.ListView1.Items.Add;
  ListItem.Caption:='<Word Count>'+inttostr(SumWord);
  ListItem.SubItems.Add('<Sum>'+inttostr(SumWordCout));

  self.Edit1.Text:=Formattime(tGetWordTime,'   GetWord: ')+Formattime(tSortWordTime,'   Sort: ');
end;


  procedure AddtestResult(li:TListItem;Start: extended;Times:_TNativeInt;const pxStr:string='');
  begin
    li.SubItems.Add(pxStr+FormatTime((GetNowTime-Start)/Times));
    application.ProcessMessages();
  end;
  procedure AddtestResultNoTest(li:TListItem);
  begin
    li.SubItems.Add('not test');
    application.ProcessMessages();
  end;

var
  g_tmp : _TNativeInt;

procedure TForm1.Button4Click(Sender: TObject);
begin
    self.lvPerfo.Items.Clear();
end;

procedure TForm1.Button5Click(Sender: TObject);
type
  TContainerMapType = IIntMap;
  TContainerSetType = IIntSet;
  procedure TestPerformances(const ContainerName:string;const Container:TContainerMapType;
    InsertTimes,FindTimes:longword);  overload;
  var
    li:TListItem;
    Start: extended;
    i,j : _TNativeInt;
    it : IIntMapIterator;
    ClearSum : extended;
    NextVisiteTimes:_TNativeInt;
  begin
    NextVisiteTimes:=5;

    li:=self.lvPerfo.Items.Add();
    li.Caption:=ContainerName;
    application.ProcessMessages();

    //test insert
    Container.Clear();
    Start := GetNowTime();
    for I := 0 to InsertTimes-1 do
      Container.Insert(I,I);
    AddtestResult(li,Start,InsertTimes);

    //test Find
    Start := GetNowTime;
    for I := 0 to FindTimes - 1 do
    begin
      g_tmp:=Container.Items[_rand() mod (InsertTimes)];  //
      Container.Items[_rand() mod (InsertTimes)]:=g_tmp;  //
    end;
    AddtestResult(li,Start,FindTimes);

    //test Next Visite
    Start := GetNowTime;
    for I := 0 to NextVisiteTimes - 1 do
    begin
      it:=Container.ItBegin;
      for j := 0 to InsertTimes- 1 do
      begin
        g_tmp:=it.Value;
        it.Value:=g_tmp;
        it.Next();
      end;
    end;
    AddtestResult(li,Start,NextVisiteTimes*InsertTimes);

  end;

  procedure TestPerformances(const ContainerName:string;const Container:TContainerSetType;
    InsertTimes,FindTimes:longword);  overload;
  var
    li:TListItem;
    Start: extended;
    i,j : _TNativeInt;
    it : IIntIterator;
    ClearSum : extended;
    NextVisiteTimes:_TNativeInt;
  begin
    NextVisiteTimes:=5;

    li:=self.lvPerfo.Items.Add();
    li.Caption:=ContainerName;
    application.ProcessMessages();

    //test insert
    Container.Clear();
    Start := GetNowTime();
    for I := 0 to InsertTimes-1 do
      Container.Insert(i);
    AddtestResult(li,Start,InsertTimes);

    //test Find
    Start := GetNowTime;
    for I := 0 to FindTimes - 1 do
    begin
      g_tmp:=Container.Find(_rand() mod (InsertTimes)).Value; //
      g_tmp:=Container.Find(_rand() mod (InsertTimes)).Value; //
    end;
    AddtestResult(li,Start,FindTimes);

    //test Next Visite
    Start := GetNowTime;
    for I := 0 to NextVisiteTimes - 1 do
    begin
      it:=Container.ItBegin;
      for j := 0 to InsertTimes- 1 do
      begin
        g_tmp:=it.Value;
        g_tmp:=it.Value;
        it.Next();
      end;
    end;
    AddtestResult(li,Start,NextVisiteTimes*InsertTimes);

  end;

var
  ContainerMap :TContainerMapType;
  ContainerSet :TContainerSetType;
  li:TListItem;
begin
  randomize();
  li:=self.lvPerfo.Items.Add();
  li.Caption:='Container:';
  li.SubItems.Add('Insert');
  li.SubItems.Add('Find');
  li.SubItems.Add('Next Visite');


  Screen.Cursor := crHourGlass;
  try
    ContainerMap:=TIntMap.Create();
    TestPerformances('Map',ContainerMap,10000000,2000000);
    ContainerMap:=nil;

    ContainerMap:=TIntMultiMap.Create();
    TestPerformances('MultiMap',ContainerMap,10000000,2000000);
    ContainerMap:=nil;

    ContainerSet:=TIntSet.Create();
    TestPerformances('Set',ContainerSet,10000000,2000000);
    ContainerSet:=nil;

    ContainerSet:=TIntMultiSet.Create();
    TestPerformances('MultiSet',ContainerSet,10000000,2000000);
    ContainerSet:=nil;
    //}

    //======

    ContainerMap:=TIntHashMap.Create();
    //TIntHashMap(ContainerMap.GetSelfObj).Reserve(10000000); 
    TestPerformances('HashMap',ContainerMap,10000000,2000000);
    ContainerMap:=nil;

    ContainerMap:=TIntHashMultiMap.Create();
    TestPerformances('HashMultiMap',ContainerMap,10000000,2000000);
    ContainerMap:=nil;

    ContainerSet:=TIntHashSet.Create();
    TestPerformances('HashSet',ContainerSet,10000000,2000000);
    ContainerSet:=nil;

    ContainerSet:=TIntHashMultiSet.Create();
    TestPerformances('HashMultiSet',ContainerSet,10000000,2000000);
    ContainerSet:=nil;

  finally
    Screen.Cursor := crDefault;
  end;
  li:=self.lvPerfo.Items.Add();
end;

procedure TForm1.Button3Click(Sender: TObject);
const
  csRandomVisiteSize=1024*1024;
type
  TContainerType = IIntSerialContainer;
  procedure TestPerformances(const ContainerName:string;const Container:TContainerType;
    PushBackTimes,NextVisiteTimes,RandomVisiteTimes,InsertAtMiddleTimes,PushFrontTimes:_TNativeInt;IsList:boolean=false);
  var
    li:TListItem;
    Start: extended;
    i : _TNativeInt;
    it : IIntIterator;
    ClearSum : extended;
  begin
    li:=self.lvPerfo.Items.Add();
    li.Caption:=ContainerName;
    application.ProcessMessages();

    //test PushBack
    Container.Clear();
    Start := GetNowTime();
    for I := 0 to PushBackTimes-1 do
      Container.PushBack(I);
    AddtestResult(li,Start,PushBackTimes);

    //test Next Visite
    Container.Resize(NextVisiteTimes);
    Start := GetNowTime;
    it:=Container.ItBegin;
    for I := 0 to NextVisiteTimes - 1 do
    begin
      g_tmp:=it.Value;
      it.Value:=g_tmp;
      it.Next();
    end;
    AddtestResult(li,Start,NextVisiteTimes);

    //test Random Visite
    Container.Resize(csRandomVisiteSize);
    Start := GetNowTime;
    it:=Container.ItBegin;
    for I := 0 to RandomVisiteTimes - 1 do
    begin
      g_tmp:=it.NextValue[_rand() mod (csRandomVisiteSize)];  //
      it.NextValue[_rand() mod (csRandomVisiteSize)]:=g_tmp;  //
    end;
    AddtestResult(li,Start,RandomVisiteTimes);

    //test Insert at  Middle
    Container.Resize(PushBackTimes);
    Start := GetNowTime;
    it:=Container.ItBegin;
    it.Next(PushBackTimes shr 1);
    for I := 0 to InsertAtMiddleTimes - 1 do
    begin
      if not IsList then
      begin  //if Container is vector then Iterator is invalid  after Insert !!!
       it:=Container.ItBegin;
       it.Next(PushBackTimes shr 1);
      end;
      Container.Insert(it,i);
    end;
    AddtestResult(li,Start,InsertAtMiddleTimes);

    //test PushFront
    (Container).Resize(PushBackTimes);
    Start := GetNowTime;
    for I := 0 to PushFrontTimes do
      (Container).PushFront(I);
    AddtestResult(li,Start,PushFrontTimes);

  end;

  procedure TestPerformances_Vector(const ContainerName:string;const Container:TIntVector;
    PushBackTimes,NextVisiteTimes,RandomVisiteTimes,InsertAtMiddleTimes,PushFrontTimes:_TNativeInt);
  var
    li:TListItem;
    Start: extended;
    i : _TNativeInt;
    it : IIntVectorIterator;
    ClearSum : extended;
  begin
    li:=self.lvPerfo.Items.Add();
    li.Caption:=ContainerName;
    application.ProcessMessages();

    //test PushBack
    Container.Clear();
    Start := GetNowTime();
    for I := 0 to PushBackTimes-1 do
      Container.PushBack(I);
    AddtestResult(li,Start,PushBackTimes);

    //test Next Visite
    Container.Resize(NextVisiteTimes);
    Start := GetNowTime;
    IIntIterator(it):=Container.ItBegin;
    for I := 0 to NextVisiteTimes - 1 do
    begin
      //g_tmp:=it.Value;
      //it.Value:=g_tmp;
      //it.Next();
      g_tmp:=Container.Items[i];  //
      Container.Items[i]:=g_tmp;  //
    end;
    AddtestResult(li,Start,NextVisiteTimes);

    //test Random Visite
    Container.Resize(csRandomVisiteSize);
    Start := GetNowTime;
    //it:=Container.ItBegin;
    for I := 0 to RandomVisiteTimes - 1 do
    begin
      g_tmp:=Container.Items[_rand() mod (csRandomVisiteSize)];  //
      Container.Items[_rand() mod (csRandomVisiteSize)]:=g_tmp;  //
    end;
    AddtestResult(li,Start,RandomVisiteTimes);

    //test Insert at  Middle
    Container.Resize(PushBackTimes);
    Start := GetNowTime;
    //it:=Container.ItBegin;
    //it.Next(PushBackTimes div 2);
    for I := 0 to InsertAtMiddleTimes - 1 do
    begin
      Container.InsertByIndex(PushBackTimes shr 1,i);
    end;
    AddtestResult(li,Start,InsertAtMiddleTimes);

    //test PushFront
    (Container).Resize(PushBackTimes);
    Start := GetNowTime;
    for I := 0 to PushFrontTimes do
      (Container).PushFront(I);
    AddtestResult(li,Start,PushFrontTimes);

  end;
  procedure TestPerformances_Deque(const ContainerName:string;const Container:TIntDeque;
    PushBackTimes,NextVisiteTimes,RandomVisiteTimes,InsertAtMiddleTimes,PushFrontTimes:_TNativeInt);
  var
    li:TListItem;
    Start: extended;
    i : _TNativeInt;
    it : IIntDequeIterator;
    ClearSum : extended;
  begin
    li:=self.lvPerfo.Items.Add();
    li.Caption:=ContainerName;
    application.ProcessMessages();

    //test PushBack
    Container.Clear();
    Start := GetNowTime();
    for I := 0 to PushBackTimes-1 do
      Container.PushBack(I);
    AddtestResult(li,Start,PushBackTimes);

    //test Next Visite
    Container.Resize(NextVisiteTimes);
    Start := GetNowTime;
    IIntIterator(it):=Container.ItBegin;
    for I := 0 to NextVisiteTimes - 1 do
    begin
      g_tmp:=it.Value;
      it.Value:=g_tmp;
      it.Next();
    end;
    AddtestResult(li,Start,NextVisiteTimes);

    //test Random Visite
    Container.Resize(csRandomVisiteSize);
    Start := GetNowTime;
    IIntIterator(it):=Container.ItBegin;
    for I := 0 to RandomVisiteTimes - 1 do
    begin
      g_tmp:=it.NextValue[_rand() mod (csRandomVisiteSize)];  //
      it.NextValue[_rand() mod (csRandomVisiteSize)]:=g_tmp;  //
    end;
    AddtestResult(li,Start,RandomVisiteTimes);

    //test Insert at  Middle
    Container.Resize(PushBackTimes);
    Start := GetNowTime;
    //it:=Container.ItBegin;
    //it.Next(PushBackTimes div 2);
    for I := 0 to InsertAtMiddleTimes - 1 do
    begin
      Container.InsertByIndex(PushBackTimes shr 1,i);
    end;
    AddtestResult(li,Start,InsertAtMiddleTimes);

    //test PushFront
    (Container).Resize(PushBackTimes);
    Start := GetNowTime;
    for I := 0 to PushFrontTimes do
      (Container).PushFront(I);
    AddtestResult(li,Start,PushFrontTimes);

  end;

  procedure TestPerformances_List(const ContainerName:string;const Container:TIntList;
    PushBackTimes,NextVisiteTimes,RandomVisiteTimes,InsertAtMiddleTimes,PushFrontTimes:_TNativeInt);
  var
    li:TListItem;
    Start: extended;
    i : _TNativeInt;
    it : IIntListIterator;
    ClearSum : extended;
  begin
    li:=self.lvPerfo.Items.Add();
    li.Caption:=ContainerName;
    application.ProcessMessages();

    //test PushBack
    Container.Clear();
    Start := GetNowTime();
    for I := 0 to PushBackTimes-1 do
      Container.PushBack(I);
    AddtestResult(li,Start,PushBackTimes);

    //test Next Visite
    Container.Resize(NextVisiteTimes);
    Start := GetNowTime;
    IIntIterator(it):=Container.ItBegin;
    for I := 0 to NextVisiteTimes - 1 do
    begin
      g_tmp:=it.Value;
      it.Value:=g_tmp;
      it.Next();
    end;
    AddtestResult(li,Start,NextVisiteTimes);

    //test Random Visite
    Container.Resize(csRandomVisiteSize);
    Start := GetNowTime;
    IIntIterator(it):=Container.ItBegin;
    for I := 0 to RandomVisiteTimes - 1 do
    begin
      g_tmp:=it.NextValue[_rand() mod (csRandomVisiteSize)];  //
      it.NextValue[_rand() mod (csRandomVisiteSize)]:=g_tmp;  //
    end;
    AddtestResult(li,Start,RandomVisiteTimes);

    //test Insert at  Middle
    Container.Resize(PushBackTimes);
    Start := GetNowTime;
    IIntIterator(it):=Container.ItBegin;
    it.Next(PushBackTimes shr 1);
    for I := 0 to InsertAtMiddleTimes - 1 do
    begin
      Container.Insert(it,i);
    end;
    AddtestResult(li,Start,InsertAtMiddleTimes);

    //test PushFront
    (Container).Resize(PushBackTimes);
    Start := GetNowTime;
    for I := 0 to PushFrontTimes do
      (Container).PushFront(I);
    AddtestResult(li,Start,PushFrontTimes);

  end;

  procedure TestPerformances_Array(const ContainerName:string;
    PushBackTimes,NextVisiteTimes,RandomVisiteTimes,InsertAtMiddleTimes,PushFrontTimes:_TNativeInt);
  var
    li:TListItem;
    Start: extended;
    Container:array of _TNativeInt;
    L,i,j,k : _TNativeInt;
    ClearSum : extended;
  begin
    li:=self.lvPerfo.Items.Add();
    li.Caption:=ContainerName;
    application.ProcessMessages();
    Container:=nil;

    //test PushBack
    Start := GetNowTime();
    for I := 0 to PushBackTimes-1 do
    begin
      L:=length(Container);
      setlength(Container,L+1);
      Container[L]:=i;
    end;
    AddtestResult(li,Start,PushBackTimes);

    //test Next Visite
    setlength(Container,NextVisiteTimes);
    Start := GetNowTime;
    for I := 0 to NextVisiteTimes - 1 do
    begin
      //g_tmp:=g_tmp div 132423457;
      g_tmp:=Container[i];  //
      Container[i]:=g_tmp;  //
    end;
    AddtestResult(li,Start,NextVisiteTimes);

    //test Random Visite
    setlength(Container,csRandomVisiteSize);
    Start := GetNowTime;
    //it:=Container.ItBegin;
    for I := 0 to RandomVisiteTimes - 1 do
    begin
      g_tmp:=Container[_rand() mod (csRandomVisiteSize)];  //
      Container[_rand() mod (csRandomVisiteSize)]:=g_tmp;  //
      //g_tmp:=_DGL_Random(csRandomVisiteSize);  //
      //g_tmp:=_DGL_Random(csRandomVisiteSize);  //
    end;
    AddtestResult(li,Start,RandomVisiteTimes);

    //test Insert at  Middle
    setlength(Container,PushBackTimes);
    Start := GetNowTime;
    for I := 0 to InsertAtMiddleTimes - 1 do
    begin
      L:=length(Container);
      setlength(Container,L+1);
      for j :=L-1 downto (PushBackTimes shr 1) do
        Container[j+1]:=Container[j];
      Container[PushBackTimes shr 1]:=i;
    end;
    AddtestResult(li,Start,InsertAtMiddleTimes);

    //test PushFront
    setlength(Container,PushBackTimes);
    Start := GetNowTime;
    for I := 0 to PushFrontTimes do
    begin
      L:=length(Container);
      setlength(Container,L+1);
      for j :=L-1 downto 0 do
        Container[j+1]:=Container[j];
      Container[0]:=i;
    end;
    AddtestResult(li,Start,PushFrontTimes);

  end;

  procedure TestPerformances_TList(const ContainerName:string;
    PushBackTimes,NextVisiteTimes,RandomVisiteTimes,InsertAtMiddleTimes,PushFrontTimes:_TNativeInt);
  var
    li:TListItem;
    Start: extended;
    Container:TList;
    L,i,j,k : _TNativeInt;
    ClearSum : extended;
  begin
    li:=self.lvPerfo.Items.Add();
    li.Caption:=ContainerName;
    application.ProcessMessages();
    Container:=TList.Create;

    //test PushBack
    Start := GetNowTime();
    for I := 0 to PushBackTimes-1 do
    begin
      Container.Add(Pointer(i));
    end;
    AddtestResult(li,Start,PushBackTimes);

    //test Next Visite
    Assert(Container.Count=NextVisiteTimes);
    Start := GetNowTime;
    for I := 0 to NextVisiteTimes - 1 do
    begin
      g_tmp:=_TNativeInt(Container.Items[i]);  //
      Container.Items[i]:=Pointer(g_tmp);  //
    end;
    AddtestResult(li,Start,NextVisiteTimes);

    //test Random Visite
    Container.Clear();
    for i:=0 to csRandomVisiteSize-1 do
      Container.Add(Pointer(i));
    Start := GetNowTime;
    //it:=Container.ItBegin;
    for I := 0 to RandomVisiteTimes - 1 do
    begin
      Pointer(g_tmp):=Container.Items[_rand() mod (csRandomVisiteSize)];  //
      Container.Items[_rand() mod (csRandomVisiteSize)]:=Pointer(g_tmp);  //
      //g_tmp:=_DGL_Random(csRandomVisiteSize);  //
      //g_tmp:=_DGL_Random(csRandomVisiteSize);  //
    end;
    AddtestResult(li,Start,RandomVisiteTimes);

    //test Insert at  Middle
    Container.Clear();
    for i:=0 to PushBackTimes-1 do
      Container.Add(Pointer(i));
    Start := GetNowTime;
    for I := 0 to InsertAtMiddleTimes - 1 do
    begin
      Container.Insert(PushBackTimes shr 1,Pointer(i));
    end;
    AddtestResult(li,Start,InsertAtMiddleTimes);

    //test PushFront
    Container.Clear();
    for i:=0 to PushBackTimes-1 do
      Container.Add(Pointer(i));
    Start := GetNowTime;
    for I := 0 to PushFrontTimes do
    begin
      Container.Insert(0,Pointer(i));
    end;
    AddtestResult(li,Start,PushFrontTimes);

    Container.Free;
  end;
var
  Container :TContainerType;
  Container_Vector :TIntVector;
  Container_Deque :TIntDeque;
  Container_List :TIntList;
  li:TListItem;
begin
  li:=self.lvPerfo.Items.Add();
  li.Caption:='Container:';
  li.SubItems.Add('PushBack');
  li.SubItems.Add('Next Visite');
  li.SubItems.Add('Random Visite');
  li.SubItems.Add('Insert At Middle');
  li.SubItems.Add('PushFront');

  Screen.Cursor := crHourGlass;
  try
    TestPerformances_Array('array of type',20000000,20000000,2000000,5,5);
    TestPerformances_TList('TList',20000000,20000000,2000000,5,5);
                            
    Container_Vector:=TIntVector.Create();
    TestPerformances_Vector('TVector',Container_Vector,20000000,20000000,2000000,5,5);
    Container_Vector.Free;  
    
    Container_Deque:=TIntDeque.Create();
    TestPerformances_Deque('TDeque',Container_Deque,20000000,20000000,2000000,5,20000000);
    Container_Deque.Free;  // }
    
    Container_List:=TIntList.Create();
    TestPerformances_List('TList',Container_List,10000000,10000000,100,10000000,10000000);
    Container_List.Free;

    Container:=TIntVector.Create();
    TestPerformances('IVector',Container,20000000,20000000,2000000,5,5);
    Container:=nil;

    Container:=TIntDeque.Create();
    TestPerformances('IDeque',Container,20000000,20000000,2000000,5,20000000);
    Container:=nil;

    Container:=TIntList.Create();
    TestPerformances('IList',Container,10000000,10000000,100,10000000,10000000,true);
    Container:=nil;  
                       // }
  finally
    Screen.Cursor := crDefault;
  end;
  li:=self.lvPerfo.Items.Add();
end;


procedure TForm1.btnTestVectorClick(Sender: TObject);
var
  V : TIntVector;
  //V : IIntVector;
  //it,it1 : IIntVectorIterator;
  it,it1 : IIntIterator;
  ClearSum,Start : extended;
  rTimes,i : _TNativeInt;
    li:TListItem;

  ar : array of _TNativeInt;
  par : Pinteger;
begin
  li:=self.lvPerfo.Items.Add();
  li.Caption:='way:';
  li.SubItems.Add('Next Visite');
  li.SubItems.Add('way:');
  li.SubItems.Add('Next Visite');

  Screen.Cursor := crHourGlass;
  try

    rTimes:=20000000;
    V:=TIntVector.Create(rTimes);

    li:=self.lvPerfo.Items.Add();
    li.Caption:='Array of Type';

    setlength(ar,rTimes);
    Start := GetNowTime();
    ClearSum:=0;
    for i:=0 to rTimes -1 do
    begin
      g_tmp:=ar[i];
      ar[i]:=g_tmp;
    end;
    ClearSum:=(GetNowTime-Start);
    AddtestResult(li,GetNowTime-ClearSum,rTimes);

    li.SubItems.Add('PValue^');

    par:=@ar[0];
    Start := GetNowTime();
    ClearSum:=0;
    for i:=0 to rTimes -1 do
    begin
      g_tmp:=par^;
      par^:=g_tmp;
      inc(par);
    end;
    ClearSum:=(GetNowTime-Start);
    AddtestResult(li,GetNowTime-ClearSum,rTimes);

    li:=self.lvPerfo.Items.Add();
    li.Caption:='TVector.Items';

    Start := GetNowTime();
    ClearSum:=0;
    for i:=0 to rTimes -1 do
    begin
      g_tmp:=v.Items[i];
      v.Items[i]:=g_tmp;
    end;
    ClearSum:=(GetNowTime-Start);
    AddtestResult(li,GetNowTime-ClearSum,rTimes);

    li.SubItems.Add('Iterator.Value');

    Start := GetNowTime();
    ClearSum:=0;
    it.Assign(v.ItBegin);
    it1.Assign(v.ItEnd);
    //while not it.IsEqual(It1) do
    for i:=0 to rTimes -1 do
    begin
      g_tmp:=it.Value;
      it.Value:=g_tmp;
      it.Next;
    end;
    ClearSum:=(GetNowTime-Start);
    AddtestResult(li,GetNowTime-ClearSum,rTimes);
    v.clear();

    v.Free();

    
  finally
    Screen.Cursor := crDefault;
  end;
  li:=self.lvPerfo.Items.Add();
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  vv : IIntVVector;
begin
  vv:=TIntVVector.Create();
  vv.Resize(2);
  vv.Items[0].PushBack(10,1);

  vv.Items[1].PushBack(10,2);

   assert(vv.Items[0].Items[0]+vv.Items[1].Items[0]=3);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i,si : _TNativeInt;
  strs: string;
begin
  strs:='';

  for i:=0 to self.lvPerfo.Items.Count - 1 do
  begin
    strs:=strs+self.lvPerfo.Items.Item[i].Caption + #9;
    for si := 0 to self.lvPerfo.Items.Item[i].SubItems.Count - 1 do
      strs:=strs+self.lvPerfo.Items.Item[i].SubItems.Strings[si] + #9;

    strs:=strs+#13#10;
  end;
  strs:=strs+#13#10;

  clipboard.SetTextBuf(PChar(strs));

end;

end.
