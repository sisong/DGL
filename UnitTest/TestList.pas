unit TestList;

interface
uses
  Classes, SysUtils,
  TestFramework,
  TestExtensions,
  DGL_Pointer,DGL_String,DGL_Interface,
  _DGL_Object,_DGL_Point;

type
  TTest_List = class(TTestCase)
  public
    procedure Setup; override;
    procedure TearDown; override;
  published
    procedure testList();
    procedure testList2(); //listÃÿ”–
    procedure testListIterator();
    procedure testIntfList();
    procedure testIntfListIterator();
    procedure testObjList();
  end;

implementation

{ TTest_List }

procedure TTest_List.Setup;
begin
  inherited;

end;

procedure TTest_List.TearDown;
begin
  inherited;

end;

procedure TTest_List.testIntfList;
var
    FList        : IIntfList;
    tmpList        : IIntfList;
    i : _TNativeInt;
    tmpIntf : IInterface;
    tmpIntf2 : IInterface;
    It0,It1 :IIntfIterator;
begin
  FList :=TIntfList.Create();
  Check(FList.IsEmpty());

  tmpIntf:=TInterfacedObject.Create();
  FList.Insert(FList.ItBegin,tmpIntf);
  CheckEquals(FList.Size,1);
  Check(FList.Back=tmpIntf);

  Check(FList.ItBegin.Value=tmpIntf);

  FList.Clear();
  Check(FList.IsEmpty);

  tmpList:=IIntfList(FList.Clone());
  tmpIntf:=TInterfacedObject.Create();
  tmpList.PushBack(tmpIntf);
  Check(FList.IsEmpty);
  Check(tmpList.ItBegin.Value=tmpIntf);

  tmpIntf:=TInterfacedObject.Create();
  FList.PushBack(tmpIntf);
  tmpList:=TIntfList.Create(FList.ItBegin,FList.ItEnd);
  Check(tmpList.Back=tmpIntf);

  FList.Clear();
  for i:=2 to 50 do
    FList.PushBack(TInterfacedObject.Create());
  tmpList.Clear();
  tmpList.PushBack(TInterfacedObject.Create());
  tmpList.Insert(tmpList.ItBegin,FList.ItBegin,FList.ItEnd);

  CheckEquals(FList.Size,49);
  It0:=FList.ItBegin; it0.Next(5);
  It0.Value:= tmpIntf;
  Check(It0.Value=tmpIntf);

  Check(not FList.IsEquals(tmpList));
  FList.Clear();
  FList.PushBack(tmpList.ItBegin,tmpList.ItEnd);
  Check(FList.IsEquals(tmpList));

  FList.Clear();
  for i:=0 to 50-1 do
    FList.PushBack(TInterfacedObject.Create());
  It0:=FList.ItBegin; it0.Next(4);
  It0.Value:=tmpIntf;
  It0:=FList.ItBegin; it0.Next(12);
  It0.Value:=tmpIntf;
  It0:=FList.ItBegin; it0.Next(17);
  It0.Value:=tmpIntf;
  CheckEquals(FList.EraseValue(tmpIntf),3);
  CheckEquals(FList.Size,47);

  //
  tmpIntf:=TInterfacedObject.Create();
  FList.PushFront(tmpIntf);
  Check(FList.Front=tmpIntf);
  tmpIntf2:=TInterfacedObject.Create();
  FList.PushFront(tmpIntf2);
  Check(FList.Front=tmpIntf2);
  FList.PopFront();
  Check(FList.Front=tmpIntf);

  FList.Assign(10,tmpIntf);
  CheckEquals(FList.size,10);
  It0:=FList.ItBegin; it0.Next(3);
  Check(it0.Value=tmpIntf);
  tmpList.Assign(FList.ItBegin,FList.ItEnd);
  CheckEquals(tmpList.size,10);
  It0:=FList.ItBegin; it0.Next(3);
  Check(it0.Value=tmpIntf);
  CheckEquals(FList.size,10);
  //FList.Reserve(1000);
  CheckEquals(FList.size,10);
  //FList.Resize(7);
  //CheckEquals(FList.size,7);
  
  FList.Erase(FList.ItBegin,FList.ItEnd);
  CheckEquals(FList.size,0);
  for i:=0 to 15-1 do
    FList.Insert(FList.ItEnd,TInterfacedObject.Create());
  It0:=FList.ItBegin;
  It0.Next(5);
  it1:=FList.ItEnd;
  It1.Next(-5);
  FList.Erase(It0,it1);
  CheckEquals(FList.size,10);
  It0:=FList.ItBegin;It0.Next(5);
  FList.Erase(It0);
  CheckEquals(FList.size,9);

  tmpIntf:=TInterfacedObject.Create();
  It0:=FList.ItBegin;It0.Next(5);
  FList.Insert(It0,tmpIntf);
  CheckEquals(FList.size,10);
  It0:=FList.ItBegin; it0.Next(5);
  Check(it0.Value=tmpIntf);

  tmpIntf:=TInterfacedObject.Create();
  FList.Insert(It0,tmpIntf);
  CheckEquals(FList.size,11);
  It0:=FList.ItBegin; it0.Next(5);
  Check(it0.Value=tmpIntf);

  //
  tmpIntf:=TInterfacedObject.Create();
  tmpIntf2:=TInterfacedObject.Create();
  FList.Clear();
  FList.PushFront(3,tmpIntf);
  CheckEquals(FList.size,3);
  It0:=FList.ItBegin; it0.Next(2);
  Check(it0.Value=tmpIntf);

  FList.PushFront(5,tmpIntf2);
  CheckEquals(FList.size,8);
  It0:=FList.ItBegin; it0.Next(0);
  Check(it0.Value=tmpIntf2);
  It0:=FList.ItBegin; it0.Next(4);
  Check(it0.Value=tmpIntf2);
  It0:=FList.ItBegin; it0.Next(5);
  Check(it0.Value=tmpIntf);
  It0:=FList.ItBegin; it0.Next(7);
  Check(it0.Value=tmpIntf);
  //}
end;

procedure TTest_List.testIntfListIterator;
var
    FList        : IIntfList;
    tmpList        : IIntfList;
    i : _TNativeInt;
    It : IIntfIterator;
    tmpIt : IIntfIterator;
    It0 : IIntfIterator;

    tmpIntf : IInterface;
begin
  tmpIntf:=TInterfacedObject.Create();

  FList :=TIntfList.Create(10,tmpIntf);
  CheckEquals(FList.size,10);

  it0:=FList.ItBegin; it0.Next(5);
  Check(it0.Value=tmpIntf);
  
  FList.Clear();
  for i:=0 to 50-1 do
    FList.PushBack(TInterfacedObject.Create());
  tmpList:=IIntfList(FList.Clone());

  It:=FList.ItBegin;
  It.Next();
  It.Next(4);
  it0:=tmpList.ItBegin; it0.Next(5);
  Check(It.Value=it0.Value);
  CheckEquals(FList.ItBegin.Distance(It),(5));
  It:=FList.ItEnd;
  It.Previous();
  it0:=tmpList.ItBegin; it0.Next(49);
  Check(It.Value=it0.Value);
  It.Next(-2);
  it0:=tmpList.ItBegin; it0.Next(47);
  Check(It.Value=it0.Value);
 
  tmpIt:=It.Clone();
  Check(tmpIt.Value=It.Value);
  Check(tmpIt.IsEqual(It));
 
  tmpIt.Previous;
  Check(tmpIt.Value<>It.Value);

  it.Assign(tmpIt);
  Check(tmpIt.Value=It.Value);
  tmpIt.Previous;
  Check(tmpIt.Value<>It.Value);
end;

procedure TTest_List.testList;
var
    FVector        : IPointerList;
    tmpVector        : IPointerList;
    i : _TNativeInt;
    It0,It1:IPointerIterator;
    //str : string;
begin
  FVector :=TPointerList.Create();
  Check(FVector.IsEmpty());

  FVector.Insert(FVector.ItBegin,pointer(5));
  CheckEquals(FVector.Size,1);
  Check(FVector.Back=pointer(5));
  
  Check(FVector.ItBegin.Value=pointer(5));

  FVector.Clear();
  Check(FVector.IsEmpty);
 
  tmpVector:=IPointerList(FVector.Clone());
  tmpVector.PushBack(Pointer(13));
  Check(FVector.IsEmpty);
  Check(tmpVector.ItBegin.Value=Pointer(13));

  FVector.PushBack(Pointer(31));
  tmpVector:=TPointerList.Create(FVector.ItBegin,FVector.ItEnd);
  Check(tmpVector.Back=Pointer(31));

  FVector.Clear();
  for i:=2 to 50 do
    FVector.PushBack(Pointer(i));
  CheckEquals(FVector.Size,49);
  it0:=FVector.ItBegin; it0.Next(1);
  CheckEquals(_TNativeInt(it0.Value),3);

  tmpVector.Clear();
  tmpVector.PushBack(Pointer(1));
  tmpVector.Insert(tmpVector.ItBegin,FVector.ItBegin,FVector.ItEnd);
  //it0:=tmpVector.ItBegin; Str:='';
  //while not it0.IsEqual(tmpVector.ItEnd) do begin
  //  Str := str+inttostr(_TNativeInt(it0.Value))+' '; it0.Next();
  //end; CheckEquals('',Str); 
  it0:=tmpVector.ItBegin; it0.Next(49);
  CheckEquals(1,_TNativeInt(it0.Value));
  it0:=tmpVector.ItBegin; it0.Next(2);
  Check(it0.Value=Pointer(4));

  it0:=tmpVector.ItBegin; it0.Next(3);
  it0.Value:=Pointer(17);
  Check(it0.Value=Pointer(17));

  Check(not FVector.IsEquals(tmpVector));
  FVector.Clear();
  FVector.PushBack(tmpVector.ItBegin,tmpVector.ItEnd);
  Check(FVector.IsEquals(tmpVector));

  FVector.Clear();
  for i:=0 to 50-1 do
    FVector.PushBack(Pointer(i));
  it0:=FVector.ItBegin; it0.Next(4);
  it0.Value:=Pointer(17);
  CheckEquals(FVector.EraseValue(Pointer(17)),2);
  CheckEquals(FVector.Size,48);

  Check(FVector.Back=Pointer(49));
  FVector.PopBack();
  Check(FVector.Back=Pointer(48));
  
  //
  FVector.PushFront(Pointer(21));
  Check(FVector.Front=Pointer(21));
  FVector.PushFront(Pointer(13));
  Check(FVector.Front=Pointer(13));
  it0:=FVector.ItBegin; it0.Next(1);
  Check(it0.Value=Pointer(21));
  FVector.PopFront();
  Check(FVector.Front=Pointer(21));

  FVector.Assign(10,Pointer(5));
  CheckEquals(FVector.size,10);
  it0:=FVector.ItBegin; it0.Next(3);
  Check(it0.Value=Pointer(5));
  tmpVector.Assign(FVector.ItBegin,FVector.ItEnd);
  CheckEquals(tmpVector.size,10);
  it0:=tmpVector.ItBegin; it0.Next(3);
  Check(it0.value=Pointer(5));
  CheckEquals(FVector.size,10);
  //FVector.Reserve(1000);
  CheckEquals(FVector.size,10);
  //FVector.Resize(7);
  //CheckEquals(FVector.size,7);

  FVector.Erase(FVector.ItBegin,FVector.ItEnd);
 CheckEquals(FVector.size,0);
  for i:=0 to 15-1 do
    FVector.Insert(FVector.ItEnd,Pointer(i));
  It0:=FVector.ItBegin;
  It0.Next(5);
  it1:=FVector.ItEnd;
  It1.Next(-5);
  FVector.Erase(It0,it1);
  CheckEquals(FVector.size,10);
  it0:=FVector.ItBegin; it0.Next(6);
  Check(it0.Value=Pointer(11));
  It0:=FVector.ItBegin; It0.Next(5);
  FVector.Erase(It0);
  CheckEquals(FVector.size,9);
  it1:=FVector.ItBegin; it1.Next(6);
  Check(it1.Value=Pointer(12));

  It0:=FVector.ItBegin; it0.Next(5);
  FVector.Insert(It0,Pointer(31));
  CheckEquals(FVector.size,10);
  it1:=FVector.ItBegin; it1.Next(5);
  Check(it1.Value=Pointer(31));
  it1:=FVector.ItBegin; it1.Next(6);
  Check(it1.Value=Pointer(11));

  It0:=FVector.ItBegin; it0.Next(5);
  FVector.Insert(It0,Pointer(32));
  CheckEquals(FVector.size,11);
  it1:=FVector.ItBegin; it1.Next(5);
  CheckEquals(_TNativeInt(it1.Value),(32));
  it1:=FVector.ItBegin; it1.Next(6);
  CheckEquals(_TNativeInt(it1.Value),(31));

  //
  FVector.Clear();
  FVector.PushFront(3,Pointer(12));
  CheckEquals(FVector.size,3);
  it1:=FVector.ItBegin; it1.Next(2);
  Check(it1.Value=Pointer(12));

  FVector.PushFront(5,Pointer(11));
  CheckEquals(FVector.size,8);
  it1:=FVector.ItBegin; it1.Next(0);
  Check(it1.Value=Pointer(11));
  it1:=FVector.ItBegin; it1.Next(4);
  Check(it1.Value=Pointer(11));
  it1:=FVector.ItBegin; it1.Next(5);
  Check(it1.Value=Pointer(12));
  it1:=FVector.ItBegin; it1.Next(7);
  Check(it1.Value=Pointer(12));
  //}
end;


function test_List_EraseValueIf3(const Value:Pointer):boolean;
begin
  result:=_TNativeInt(Value)=3;
end;

procedure TTest_List.testList2;
var
    FList      : IPointerList;
    tmpList    : IPointerList;
    //i : _TNativeInt;
    //It0,It1:IIterator;
begin
  FList:=TPointerList.Create();
  FList.PushBack(Pointer(5));
  tmpList:=IPointerList(Flist.Clone);
  tmpList.PushFront(Pointer(7));
  CheckEquals(FList.size,1);
  CheckEquals(tmpList.size,2);

  FList.Splice(FList.ItBegin,tmpList);
  CheckEquals(FList.size,3);
  CheckEquals(tmpList.size,0);
  FList.Unique();
  CheckEquals(FList.size,2);
  CheckEquals(_TNativeInt(FList.ItBegin.Value),7);
  FList.Reverse();
  CheckEquals(_TNativeInt(FList.ItBegin.Value),5);
  FList.Reverse();
  CheckEquals(_TNativeInt(FList.ItBegin.Value),7);
  FList.Erase(FList.ItBegin,FList.ItEnd);
  CheckEquals(FList.size,0);

  //EraseValueIf
  FList.Clear();
  FList.PushBack(Pointer(5));
  FList.PushBack(Pointer(3));
  FList.PushBack(Pointer(4));
  FList.PushBack(Pointer(3));
  FList.EraseValueIf(test_List_EraseValueIf3);
  CheckEquals(FList.size,2);
  CheckEquals(_TNativeInt(FList.ItBegin.Value),5);
  CheckEquals(_TNativeInt(FList.Back),4);

  //sort
  FList.Clear();
  FList.PushBack(Pointer(5));
  FList.PushBack(Pointer(3));
  FList.PushBack(Pointer(4));
  FList.PushBack(Pointer(3));
  FList.Sort();
  CheckEquals(_TNativeInt(FList.ItBegin.Value),3);
  CheckEquals(_TNativeInt(FList.Back),5);
  Check(TPointerAlgorithms.IsSorted(FList.ItBegin,FList.ItEnd));

  //
  FList.Clear();
  FList.PushBack(Pointer(1));
  FList.PushBack(Pointer(3));
  FList.PushBack(Pointer(5));
  tmpList:=IPointerList(FList.Clone());
  tmpList.Clear();
  tmpList.PushBack(Pointer(2));
  tmpList.PushBack(Pointer(4));
  tmpList.PushBack(Pointer(6));
  tmpList.PushBack(Pointer(8));
  FList.Merge(tmpList);
  CheckEquals(_TNativeInt(FList.ItBegin.Value),1);
  CheckEquals(_TNativeInt(FList.Back),8);
  Check(TPointerAlgorithms.IsSorted(FList.ItBegin,FList.ItEnd));
  Check(tmpList.IsEmpty);

end;

procedure TTest_List.testListIterator;
var
    FVector        : IPointerList;
    i : _TNativeInt;
    It : IPointerIterator;
    tmpIt : IPointerIterator;
begin
  FVector :=TPointerList.Create(10,Pointer(3));
  CheckEquals(FVector.size,10);

  It:=FVector.ItBegin; It.Next(5);
  CheckEquals(_TNativeInt(it.Value),(3));

  FVector.Clear();
  for i:=0 to 50-1 do
    FVector.PushBack(Pointer(i));

  It:=FVector.ItBegin;
  It.Next();
  CheckEquals(_TNativeInt(It.Value),(1));
  It.Next(4);
  CheckEquals(_TNativeInt(It.Value),(5));
  CheckEquals(FVector.ItBegin.Distance(It),(5));
  It:=FVector.ItEnd;
  It.Previous();
  CheckEquals(_TNativeInt(It.Value),(49));
  It.Next(-2);
  CheckEquals(_TNativeInt(It.Value),(47));

  tmpIt:=It.Clone();
  CheckEquals(_TNativeInt(tmpIt.Value),_TNativeInt(It.Value));
  Check(tmpIt.IsEqual(It));
  tmpIt.Value:=pointer(_TNativeInt(It.Value)+1);
  CheckEquals(_TNativeInt(tmpIt.Value),_TNativeInt(It.Value));

  tmpIt.Previous;
  CheckNotEquals(_TNativeInt(tmpIt.Value),_TNativeInt(It.Value));

  it.Assign(tmpIt);
  CheckEquals(_TNativeInt(tmpIt.Value),_TNativeInt(It.Value));
  tmpIt.Previous;
  CheckNotEquals(_TNativeInt(tmpIt.Value),_TNativeInt(It.Value));
end;



procedure TTest_List.testObjList;
var
  ov : IObjList;
  ovtmp : IObjList;
  it : IObjIterator;
  it0,it1 : IObjIterator;
  ob : TTestObj;
  ob0 : TTestObj;
  i : _TNativeInt;
  tmov : IObjContainer;
begin
  //_refCount:=0; //for test

  ov:=TObjList.Create(5);
  CheckEquals(_refCount,5);
  ov:=nil;
  CheckEquals(_refCount,0);

  ob :=TTestObj.Create();
  ov:=TObjList.Create();
  for i:=0 to 3000-1 do
    ov.PushBack(ob);
  tmov:=ov.Clone;
  ovtmp:=IObjList(tmov);
  tmov:=nil;
  it0:=ovtmp.ItBegin; it1:=ovtmp.ItEnd;
  ov.PushBack(it0,it1);
  ovtmp:=nil;
  FreeAndNil(ob);
  CheckEquals(_refCount,6000);

  it:=ov.ItBegin;
  it.Next(6);
  it0:=ov.ItEnd;
  ov.Erase(it,it0);
  CheckEquals(_refCount,6);
  ov.Clear();
  CheckEquals(_refCount,0);

  ob :=TTestObj.Create();
  ov.PushBack(Ob);
  ov.PushBack(Ob);
  ov.PushBack(Ob);
  CheckEquals(_refCount,4);
  FreeAndNil(ob);
  ov.PopBack();
  ov.PopFront();
  CheckEquals(_refCount,1);

  ob :=TTestObj.Create();
  it.SetIteratorNil;
  it0.SetIteratorNil;
  it1.SetIteratorNil;
  ov:=TObjList.Create(4,ob);
  CheckEquals(ov.Size,4);
  CheckEquals(_refCount,5);
  ob0 :=TTestObj.Create();
  ov.PushBack(ob0);
  ov.PushFront(ob0);
  ov.EraseValue(ob);
  CheckEquals(ov.Size,2);
  CheckEquals(_refCount,4);
  ov.EraseValue(ob0);
  CheckEquals(_refCount,2);

  ov.PushBack(ob);
  ov.PushFront(ob);
  CheckEquals(ov.ItBegin.Value.FValue,ob.FValue);
  it:=ov.ItBegin;
  it.Value:=ob0;
  CheckEquals(ov.ItBegin.Value.FValue,ob0.FValue);

  FreeAndNil(ob);
  FreeAndNil(ob0);
  //}
end;

initialization
  RegisterTest(TTest_List.Suite);
end.
