unit TestDeque;

interface
uses
  Classes, SysUtils,
  TestFramework,
  TestExtensions,

  DGL_Pointer,DGL_String,DGL_Interface,
  _DGL_Object,_DGL_Point;

type
  TTest_Deque = class(TTestCase)
  private
  public
    procedure Setup; override;
    procedure TearDown; override;
  published
    procedure testDeque();
    procedure testIterator();
    procedure testIntfDeque();
    procedure testStrDeque();
    procedure testObjDeque();
    procedure testRecordDeque();
  end;

implementation

{ TTest_Deque }

procedure TTest_Deque.Setup;
begin
  inherited;
end;

procedure TTest_Deque.TearDown;
begin
  inherited;
end;



procedure TTest_Deque.testIntfDeque;
var
    FDeque        : IIntfDeque;
    tmpDeque        : IIntfDeque;
    i : _TNativeInt;
    tmpIntf : IInterface;
    tmpIntf2 : IInterface;
    It0,It1 :IIntfIterator;
begin
  FDeque :=TIntfDeque.Create();
  Check(FDeque.IsEmpty());

  tmpIntf:=TInterfacedObject.Create();
  FDeque.Insert(FDeque.ItBegin,tmpIntf);
  CheckEquals(FDeque.Size,1);
  Check(FDeque.Back=tmpIntf);

  Check(FDeque.ItBegin.Value=tmpIntf);

  FDeque.Clear();
  Check(FDeque.IsEmpty);

  tmpDeque:=IIntfDeque(FDeque.Clone());
  tmpIntf:=TInterfacedObject.Create();
  tmpDeque.PushBack(tmpIntf);
  Check(FDeque.IsEmpty);
  Check(tmpDeque.ItBegin.Value=tmpIntf);

  tmpIntf:=TInterfacedObject.Create();
  FDeque.PushBack(tmpIntf);
  tmpDeque:=TIntfDeque.Create(FDeque.ItBegin,FDeque.ItEnd);
  Check(tmpDeque.Back=tmpIntf);

  FDeque.Clear();
  for i:=2 to 50 do
    FDeque.PushBack(TInterfacedObject.Create());
  tmpDeque.Clear();
  tmpDeque.PushBack(TInterfacedObject.Create());
  tmpDeque.Insert(tmpDeque.ItBegin,FDeque.ItBegin,FDeque.ItEnd);

  CheckEquals(FDeque.Size,49);
  FDeque.Items[5]:= tmpIntf;
  CheckEquals(FDeque.IndexOf(tmpIntf),5);
  tmpDeque.Items[31]:= tmpIntf;
  CheckEquals(tmpDeque.IndexOf(tmpIntf),31);

  Check(not FDeque.IsEquals(tmpDeque));
  FDeque.Clear();
  FDeque.PushBack(tmpDeque.ItBegin,tmpDeque.ItEnd);
  Check(FDeque.IsEquals(tmpDeque));

  FDeque.Clear();
  for i:=0 to 50-1 do
    FDeque.PushBack(TInterfacedObject.Create());
  FDeque.Items[4]:=tmpIntf;
  FDeque.Items[12]:=tmpIntf;
  FDeque.Items[17]:=tmpIntf;
  CheckEquals(FDeque.EraseValue(tmpIntf),3);
  CheckEquals(FDeque.Size,47);

  //
  tmpIntf:=TInterfacedObject.Create();
  FDeque.PushFront(tmpIntf);
  Check(FDeque.Front=tmpIntf);
  tmpIntf2:=TInterfacedObject.Create();
  FDeque.PushFront(tmpIntf2);
  Check(FDeque.Front=tmpIntf2);
  FDeque.PopFront();
  Check(FDeque.Front=tmpIntf);

  FDeque.Assign(10,tmpIntf);
  CheckEquals(FDeque.size,10);
  Check(FDeque.Items[3]=tmpIntf);
  tmpDeque.Assign(FDeque.ItBegin,FDeque.ItEnd);
  CheckEquals(tmpDeque.size,10);
  Check(tmpDeque.Items[3]=tmpIntf);
  CheckEquals(FDeque.size,10);
  FDeque.Reserve(1000);
  CheckEquals(FDeque.size,10);
  FDeque.Resize(7);
  CheckEquals(FDeque.size,7);

  FDeque.Erase(FDeque.ItBegin,FDeque.ItEnd);
  CheckEquals(FDeque.size,0);
  for i:=0 to 15-1 do
    FDeque.Insert(FDeque.ItEnd,TInterfacedObject.Create());
  It0:=FDeque.ItBegin.Clone(5);
  it1:=FDeque.ItEnd.Clone(-5);
  FDeque.Erase(It0,it1);
  CheckEquals(FDeque.size,10);
  It0:=FDeque.ItBegin.Clone(5);
  FDeque.Erase(It0);
  CheckEquals(FDeque.size,9);

  tmpIntf:=TInterfacedObject.Create();
  It0:=FDeque.ItBegin.Clone(5);
  FDeque.Insert(It0,tmpIntf);
  CheckEquals(FDeque.size,10);
  Check(FDeque.Items[5]=tmpIntf);

  tmpIntf:=TInterfacedObject.Create();
  It0:=FDeque.ItBegin.Clone(5);
  FDeque.Insert(It0,tmpIntf);
  CheckEquals(FDeque.size,11);
  Check(FDeque.Items[5]=tmpIntf);

  //
  tmpIntf:=TInterfacedObject.Create();
  tmpIntf2:=TInterfacedObject.Create();
  FDeque.Clear();
  FDeque.PushFront(3,tmpIntf);
  CheckEquals(FDeque.size,3);
  Check(FDeque.Items[2]=tmpIntf);

  FDeque.PushFront(5,tmpIntf2);
  CheckEquals(FDeque.size,8);
  Check(FDeque.Items[0]=tmpIntf2);
  Check(FDeque.Items[4]=tmpIntf2);
  Check(FDeque.Items[5]=tmpIntf);
  Check(FDeque.Items[7]=tmpIntf);
  //}
end;

procedure TTest_Deque.testIterator;
var
    FDeque        : IPointerDeque;
    i : _TNativeInt;
    It : IPointerIterator;
    tmpIt : IPointerIterator;
begin
  FDeque :=TPointerDeque.Create(10,Pointer(3));
  CheckEquals(FDeque.size,10);

  CheckEquals(_TNativeInt(FDeque.items[5]),(3));

  FDeque.Clear();
  for i:=0 to 50-1 do
    FDeque.PushBack(Pointer(i));

  It:=FDeque.ItBegin.Clone(1);
  CheckEquals(_TNativeInt(It.Value),(1));
  It.Next(4);
  CheckEquals(_TNativeInt(It.Value),(5));
  CheckEquals(FDeque.ItBegin.Distance(It),(5));
  It:=FDeque.ItEnd;
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
procedure TTest_Deque.testObjDeque;
var
  ov : IObjDeque;
  ovtmp : IObjDeque;
  it : IObjIterator;
  it0,it1 : IObjIterator;
  ob : TTestObj;
  ob0 : TTestObj;
  i : _TNativeInt;
begin
  //_refCount:=0; //for test
  
  ov:=TObjDeque.Create(5);
  CheckEquals(_refCount,5);
  ov:=nil;
  CheckEquals(_refCount,0);
  
  ov:=TObjDeque.Create();
  ov.Resize(3000);
  CheckEquals(_refCount,3000);
  ov.CloneToInterface(ovtmp);
  CheckEquals(_refCount,6000);
  it0:=ovtmp.ItBegin; it1:=ovtmp.ItEnd;
  ov.PushBack(it0,it1);
  CheckEquals(_refCount,9000);
  ovtmp:=nil;
  CheckEquals(_refCount,6000);


  it:=ov.ItBegin.Clone(6);
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
  ov:=TObjDeque.Create(4,ob);
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
  CheckEquals(ov.Items[0].FValue,ob.FValue);
  it:=ov.ItBegin;
  it.Value:=ob0;
  CheckEquals(ov.Items[0].FValue,ob0.FValue);
  FreeAndNil(ob);
  FreeAndNil(ob0);

  ov.resize(10000);
  CheckEquals(_refCount,10000);
  for i:=0 to 10000-1 do
    ov.PopBack();
  CheckEquals(_refCount,0);

  ov.resize(10000);
  for i:=0 to 10000-1 do
    ov.PopFront();
  CheckEquals(_refCount,0);


  ov:=nil;


  //}
end;

procedure TTest_Deque.testDeque;
var
    FDeque        : IPointerDeque;
    tmpDeque        : IPointerDeque;
    i : _TNativeInt;
    It0,It1:IPointerIterator;
begin
  FDeque :=TPointerDeque.Create();
  Check(FDeque.IsEmpty());

  //FDeque.Clear();
  for i:=2 to 5 do
  begin
    FDeque.PushBack(Pointer(i));
    CheckEquals(_TNativeInt(FDeque.Front),2);
    CheckEquals(_TNativeInt(FDeque.Back),i);
  end;
  FDeque.Clear;

  FDeque.Insert(FDeque.ItBegin,pointer(5));
  CheckEquals(FDeque.Size,1);
  Check(FDeque.Back=pointer(5));

  Check(FDeque.ItBegin.Value=pointer(5));
 
  FDeque.Clear();
  Check(FDeque.IsEmpty);

  tmpDeque:=IPointerDeque(FDeque.Clone());
  tmpDeque.PushBack(Pointer(13));
  Check(FDeque.IsEmpty());
  Check(tmpDeque.ItBegin.Value=Pointer(13));


  FDeque.PushBack(Pointer(31));
  tmpDeque:=TPointerDeque.Create(FDeque.ItBegin,FDeque.ItEnd);
  Check(tmpDeque.Back=Pointer(31));
  
  FDeque.Clear();
  for i:=2 to 50 do
    FDeque.PushBack(Pointer(i));

  CheckEquals(_TNativeInt(FDeque.Front),2);
  CheckEquals(_TNativeInt(FDeque.Back),50);
  CheckEquals(FDeque.ItBegin.Distance(FDeque.ItEnd),49);

  tmpDeque.Clear();
  tmpDeque.PushBack(Pointer(1));
  tmpDeque.Insert(tmpDeque.ItBegin,FDeque.ItBegin,FDeque.ItEnd);

  CheckEquals(tmpDeque.Size,50);
  CheckEquals(FDeque.Size,49);
  CheckEquals(FDeque.IndexOf(Pointer(3)),1);
  CheckEquals(tmpDeque.IndexOf(Pointer(1)),50-1);
  Check(FDeque.Items[2]=Pointer(4));

  FDeque.Items[3]:=Pointer(17);
  Check(FDeque.Items[3]=Pointer(17));
  
  CheckEquals(FDeque.size(),tmpDeque.Size()-1);
  Check(not FDeque.IsEquals(tmpDeque));
  FDeque.Clear();
  FDeque.PushBack(tmpDeque.ItBegin,tmpDeque.ItEnd);
  Check(FDeque.IsEquals(tmpDeque));

  
  FDeque.Clear();
  for i:=0 to 50-1 do
    FDeque.PushBack(Pointer(i));
  FDeque.Items[4]:=Pointer(17);
  CheckEquals(FDeque.EraseValue(Pointer(17)),2);
  CheckEquals(FDeque.Size,48);

  Check(FDeque.Back=Pointer(49));
  FDeque.PopBack();
  Check(FDeque.Back=Pointer(48));
    

  //
  FDeque.PushFront(Pointer(21));
  Check(FDeque.Front=Pointer(21));
  FDeque.PushFront(Pointer(13));
  Check(FDeque.Front=Pointer(13));
  Check(FDeque.Items[1]=Pointer(21));
  FDeque.PopFront();
  Check(FDeque.Front=Pointer(21));

  FDeque.Assign(10,Pointer(5));
  CheckEquals(FDeque.size,10);
  Check(FDeque.Items[3]=Pointer(5));

  it0:=FDeque.ItBegin;
  for i:=0 to 10-1 do
  begin
    Check(it0.Value=Pointer(5));
    it0.Next;
  end;

  tmpDeque.Assign(FDeque.ItBegin,FDeque.ItEnd);
  CheckEquals(tmpDeque.size,10);
  Check(tmpDeque.Items[3]=Pointer(5));
  CheckEquals(FDeque.size,10);
  FDeque.Reserve(1000);
  CheckEquals(FDeque.size,10);
  FDeque.Resize(7);
  CheckEquals(FDeque.size,7);


  FDeque.Erase(FDeque.ItBegin,FDeque.ItEnd);
  CheckEquals(FDeque.size,0);
  for i:=0 to 15-1 do
    FDeque.Insert(FDeque.ItEnd,Pointer(i));
  CheckEquals(FDeque.size,15);
  CheckEquals(FDeque.ItBegin.Distance(FDeque.ItEnd),15);
  CheckEquals(FDeque.ItEnd.Clone().Distance(FDeque.ItEnd),0);
  CheckEquals(FDeque.ItEnd.Clone(-1).Distance(FDeque.ItEnd),1);
  It0:=FDeque.ItBegin.Clone(5);
  CheckEquals(it0.Distance(FDeque.ItEnd),10);
  it1:=FDeque.ItEnd.Clone(-5);
  CheckEquals(it1.Distance(FDeque.ItEnd),5);
  CheckEquals(it0.Distance(it1),5);
  FDeque.Erase(It0,it1);
  CheckEquals(FDeque.size,10);
  Check(FDeque.Items[6]=Pointer(11));
  It0:=FDeque.ItBegin.Clone(5);
  FDeque.Erase(It0);
  CheckEquals(FDeque.size,9);
  Check(FDeque.Items[6]=Pointer(12));

  It0:=FDeque.ItBegin.Clone(5);
  FDeque.Insert(It0,Pointer(31));
  CheckEquals(FDeque.size,10);
  Check(FDeque.Items[5]=Pointer(31));
  Check(FDeque.Items[6]=Pointer(11));

  It0:=FDeque.ItBegin.Clone(5);
  FDeque.Insert(It0,Pointer(32));
  CheckEquals(FDeque.size,11);
  Check(FDeque.Items[5]=Pointer(32));
  Check(FDeque.Items[6]=Pointer(31));
  //}
end;


procedure TTest_Deque.testRecordDeque;
var
    FDeque        : IPointVector;
    tmpDeque        : IPointVector;
    i : _TNativeInt;
    It0,It1:IPointIterator;
begin
  FDeque :=TPointDeque.Create();
  Check(FDeque.IsEmpty());

  FDeque.Insert(FDeque.ItBegin,Point(5,5));
  CheckEquals(FDeque.Size,1);
  Check(FDeque.Back.x=5);

  Check(FDeque.ItBegin.Value.x=(5));

  FDeque.Clear();
  Check(FDeque.IsEmpty);

  tmpDeque:=IPointVector(FDeque.Clone());
  tmpDeque.PushBack(Point(13,11));
  Check(FDeque.IsEmpty);
  Check(tmpDeque.ItBegin.Value.x=(13));
  Check(tmpDeque.ItBegin.Value.y=(11));

  FDeque.PushBack(Point(31,31));
  tmpDeque:=TPointDeque.Create(FDeque.ItBegin,FDeque.ItEnd);
  Check(tmpDeque.Back.x=(31));

  FDeque.Clear();
  for i:=2 to 50 do
    FDeque.PushBack(Point(i,i));
  CheckEquals(FDeque.Size,49);
  CheckEquals(FDeque.IndexOf(Point(3,3)),1);
  tmpDeque.Clear();
  tmpDeque.PushBack(Point(1,1));
  tmpDeque.Insert(tmpDeque.ItBegin,FDeque.ItBegin,FDeque.ItEnd);

  CheckEquals(tmpDeque.IndexOf(Point(1,1)),50-1);
  Check(FDeque.Items[2].x=(4));

  FDeque.Items[3]:=Point(17,17);
  Check(FDeque.Items[3].y=(17));

  Check(not FDeque.IsEquals(tmpDeque));
  FDeque.Clear();
  FDeque.PushBack(tmpDeque.ItBegin,tmpDeque.ItEnd);
  Check(FDeque.IsEquals(tmpDeque));

  FDeque.Clear();
  for i:=0 to 50-1 do
    FDeque.PushBack(Point(i,i));
  FDeque.Items[4]:=Point(17,17);
  CheckEquals(FDeque.EraseValue(Point(17,17)),2);
  CheckEquals(FDeque.Size,48);

  Check(FDeque.Back.x=Point(49,49).x);
  FDeque.PopBack();
  Check(FDeque.Back.y=Point(48,48).y);


  //
  FDeque.PushFront(Point(21,21));
  Check(FDeque.Front.y=(21));
  FDeque.PushFront(Point(13,13));
  Check(FDeque.Front.y=(13));
  Check(FDeque.Items[1].x=(21));
  FDeque.PopFront();
  Check(FDeque.Front.y=(21));

  FDeque.Assign(10,Point(5,5));
  CheckEquals(FDeque.size,10);
  Check(FDeque.Items[3].y=(5));
  tmpDeque.Assign(FDeque.ItBegin,FDeque.ItEnd);
  CheckEquals(tmpDeque.size,10);
  Check(tmpDeque.Items[3].x=(5));
  CheckEquals(FDeque.size,10);
  FDeque.Reserve(1000);
  CheckEquals(FDeque.size,10);
  FDeque.Resize(7);
  CheckEquals(FDeque.size,7);

  FDeque.Erase(FDeque.ItBegin,FDeque.ItEnd);
  CheckEquals(FDeque.size,0);
  for i:=0 to 15-1 do
    FDeque.Insert(FDeque.ItEnd,Point(i,i));
  It0:=FDeque.ItBegin.Clone(5);
  it1:=FDeque.ItEnd.Clone(-5);
  FDeque.Erase(It0,it1);
  CheckEquals(FDeque.size,10);
  Check(FDeque.Items[6].y=(11));
  It0:=FDeque.ItBegin.Clone(5);
  FDeque.Erase(It0);
  CheckEquals(FDeque.size,9);
  Check(FDeque.Items[6].x=(12));
  
  It0:=FDeque.ItBegin.Clone(5);
  FDeque.Insert(It0,Point(31,31));
  CheckEquals(FDeque.size,10);
  Check(FDeque.Items[5].y=(31));
  Check(FDeque.Items[6].x=(11));

  It0:=FDeque.ItBegin.Clone(5);
  FDeque.Insert(It0,Point(32,32));
  CheckEquals(FDeque.size,11);
  Check(FDeque.Items[5].x=(32));
  Check(FDeque.Items[6].y=(31));

  //
  FDeque.Clear();
  FDeque.PushFront(3,Point(12,12));
  CheckEquals(FDeque.size,3);
  Check(FDeque.Items[2].y=(12));

  FDeque.PushFront(5,Point(11,11));
  CheckEquals(FDeque.size,8);
  Check(FDeque.Items[0].x=(11));
  Check(FDeque.Items[4].x=(11));
  Check(FDeque.Items[5].y=(12));
  Check(FDeque.Items[7].x=(12));

  //}
end;     

procedure TTest_Deque.testStrDeque;
var
    FDeque        : IStrDeque;
    tmpDeque        : IStrDeque;
    i : _TNativeInt;
    It0,It1 : IStrIterator;
begin
  FDeque :=TStrDeque.Create();
  Check(FDeque.IsEmpty());

  FDeque.Insert(FDeque.ItBegin,'5');
  CheckEquals(FDeque.Size,1);
  Check(FDeque.Back='5');

  Check(FDeque.ItBegin.Value='5');

  FDeque.Clear();
  Check(FDeque.IsEmpty);

  tmpDeque:=IStrDeque(FDeque.Clone());
  tmpDeque.PushBack('13');
  Check(FDeque.IsEmpty);
  Check(tmpDeque.ItBegin.Value='13');

  FDeque.PushBack('31');
  tmpDeque:=TStrDeque.Create(FDeque.ItBegin,FDeque.ItEnd);
  Check(tmpDeque.Back='31');

  FDeque.Clear();
  for i:=2 to 50 do
    FDeque.PushBack(inttostr(i));
  tmpDeque.Clear();
  tmpDeque.PushBack('1');
  tmpDeque.Insert(tmpDeque.ItBegin,FDeque.ItBegin,FDeque.ItEnd);

  CheckEquals(FDeque.Size,49);
  CheckEquals(FDeque.IndexOf('3'),1);
  CheckEquals(tmpDeque.IndexOf('1'),50-1);
  Check(FDeque.Items[2]='4');

  FDeque.Items[3]:='17';
  Check(FDeque.Items[3]='17');

  Check(not FDeque.IsEquals(tmpDeque));
  FDeque.Clear();
  FDeque.PushBack(tmpDeque.ItBegin,tmpDeque.ItEnd);
  Check(FDeque.IsEquals(tmpDeque));

  FDeque.Clear();
  for i:=0 to 50-1 do
    FDeque.PushBack(inttostr(i));
  FDeque.Items[4]:='17';
  CheckEquals(FDeque.EraseValue('17'),2);
  CheckEquals(FDeque.Size,48);

  Check(FDeque.Back='49');
  FDeque.PopBack();
  Check(FDeque.Back='48');

  //
  FDeque.PushFront('21');
  Check(FDeque.Front='21');
  FDeque.PushFront('13');
  Check(FDeque.Front='13');
  Check(FDeque.Items[1]='21');
  FDeque.PopFront();
  Check(FDeque.Front='21');

  FDeque.Assign(10,'5');
  CheckEquals(FDeque.size,10);
  Check(FDeque.Items[3]='5');
  tmpDeque.Assign(FDeque.ItBegin,FDeque.ItEnd);
  CheckEquals(tmpDeque.size,10);
  Check(tmpDeque.Items[3]='5');
  CheckEquals(FDeque.size,10);
  FDeque.Reserve(1000);
  CheckEquals(FDeque.size,10);
  FDeque.Resize(7);
  CheckEquals(FDeque.size,7);

  FDeque.Erase(FDeque.ItBegin,FDeque.ItEnd);
  CheckEquals(FDeque.size,0);
  for i:=0 to 15-1 do
    FDeque.Insert(FDeque.ItEnd,inttostr(i));
  It0:=FDeque.ItBegin.Clone(5);
  it1:=FDeque.ItEnd.Clone(-5);
  FDeque.Erase(It0,it1);
  CheckEquals(FDeque.size,10);
  Check(FDeque.Items[6]='11');
  It0:=FDeque.ItBegin.Clone(5);
  FDeque.Erase(It0);
  CheckEquals(FDeque.size,9);
  Check(FDeque.Items[6]='12');

  It0:=FDeque.ItBegin.Clone(5);
  FDeque.Insert(It0,'31');
  CheckEquals(FDeque.size,10);
  Check(FDeque.Items[5]='31');
  Check(FDeque.Items[6]='11');

  It0:=FDeque.ItBegin.Clone(5);
  FDeque.Insert(It0,'32');
  CheckEquals(FDeque.size,11);
  Check(FDeque.Items[5]='32');
  Check(FDeque.Items[6]='31');

  //
  FDeque.Clear();
  FDeque.PushFront(3,'12');
  CheckEquals(FDeque.size,3);
  Check(FDeque.Items[2]='12');

  FDeque.PushFront(5,'11');
  CheckEquals(FDeque.size,8);
  Check(FDeque.Items[0]='11');
  Check(FDeque.Items[4]='11');
  Check(FDeque.Items[5]='12');
  Check(FDeque.Items[7]='12');
end;

initialization
  RegisterTest(TTest_Deque.Suite);
end.
