unit TestVector;

interface
uses
  Classes, SysUtils,
  TestFramework,
  TestExtensions,DGL_String,DGL_Interface,
  _DGL_Object,_DGL_Point,
  DGL_Pointer,DGL_Integer;

type

  TTest_Vector = class(TTestCase)
  private
    procedure testObj(var ov: IObjVector);
  public
    procedure Setup; override;
    procedure TearDown; override;
  published
    procedure testVector();
    procedure testIterator();
    procedure testIntfVector();
    procedure testIntfIterator();
    procedure testStrVector();
    procedure testStrIterator();
    procedure testObjVector();
    procedure testRecordVector();

  end;

implementation

{ TTest_Vector }

procedure TTest_Vector.Setup;
begin
  inherited;
end;

procedure TTest_Vector.TearDown;
begin
  inherited;
end;

procedure TTest_Vector.testIntfIterator;
var
    FVector        : IIntfVector;
    tmpVector        : IIntfVector;
    i : _TNativeInt;
    It : IIntfIterator;
    tmpIt : IIntfIterator;

    tmpIntf : IInterface;
begin
  tmpIntf:=TInterfacedObject.Create();

  FVector :=TIntfVector.Create(10,tmpIntf);
  CheckEquals(FVector.size,10);

  Check(FVector.items[5]=tmpIntf);
  
  FVector.Clear();
  for i:=0 to 50-1 do
    FVector.PushBack(TInterfacedObject.Create());
  tmpVector:=IIntfVector(FVector.Clone());

  It:=FVector.ItBegin;
  It.Next();
  Check(It.Value=FVector.Items[1]);
  It.Next(4);
  Check(It.Value=tmpVector.Items[5]);
  CheckEquals(FVector.ItBegin.Distance(It),(5));
  It:=FVector.ItEnd;
  It.Previous();
  Check(It.Value=tmpVector.Items[49]);
  It.Next(-2);
  Check(It.Value=tmpVector.Items[47]);
 
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


procedure TTest_Vector.testIntfVector;
var
    FVector        : IIntfVector;
    tmpVector        : IIntfVector;
    i : _TNativeInt;
    tmpIntf : IInterface;
    tmpIntf2 : IInterface;
    It0,It1 :IIntfIterator;
begin
  FVector :=TIntfVector.Create();
  Check(FVector.IsEmpty());

  tmpIntf:=TInterfacedObject.Create();
  FVector.Insert(FVector.ItBegin,tmpIntf);
  CheckEquals(FVector.Size,1);
  Check(FVector.Back=tmpIntf);

  Check(FVector.ItBegin.Value=tmpIntf);

  FVector.Clear();
  Check(FVector.IsEmpty);

  tmpVector:=IIntfVector(FVector.Clone());
  tmpIntf:=TInterfacedObject.Create();
  tmpVector.PushBack(tmpIntf);
  Check(FVector.IsEmpty);
  Check(tmpVector.ItBegin.Value=tmpIntf);

  tmpIntf:=TInterfacedObject.Create();
  FVector.PushBack(tmpIntf);
  tmpVector:=TIntfVector.Create(FVector.ItBegin,FVector.ItEnd);
  Check(tmpVector.Back=tmpIntf);

  FVector.Clear();
  for i:=2 to 50 do
    FVector.PushBack(TInterfacedObject.Create());
  tmpVector.Clear();
  tmpVector.PushBack(TInterfacedObject.Create());
  tmpVector.Insert(tmpVector.ItBegin,FVector.ItBegin,FVector.ItEnd);

  CheckEquals(FVector.Size,49);
  FVector.Items[5]:= tmpIntf;
  CheckEquals(FVector.IndexOf(tmpIntf),5);
  tmpVector.Items[31]:= tmpIntf;
  CheckEquals(tmpVector.IndexOf(tmpIntf),31);

  Check(not FVector.IsEquals(tmpVector));
  FVector.Clear();
  FVector.PushBack(tmpVector.ItBegin,tmpVector.ItEnd);
  Check(FVector.IsEquals(tmpVector));

  FVector.Clear();
  for i:=0 to 50-1 do
    FVector.PushBack(TInterfacedObject.Create());
  FVector.Items[4]:=tmpIntf;
  FVector.Items[12]:=tmpIntf;
  FVector.Items[17]:=tmpIntf;
  CheckEquals(FVector.EraseValue(tmpIntf),3);
  CheckEquals(FVector.Size,47);

  //
  tmpIntf:=TInterfacedObject.Create();
  FVector.PushFront(tmpIntf);
  Check(FVector.Front=tmpIntf);
  tmpIntf2:=TInterfacedObject.Create();
  FVector.PushFront(tmpIntf2);
  Check(FVector.Front=tmpIntf2);
  FVector.PopFront();
  Check(FVector.Front=tmpIntf);


  FVector.Assign(10,tmpIntf);
  CheckEquals(FVector.size,10);
  Check(FVector.Items[3]=tmpIntf);
  tmpVector.Assign(FVector.ItBegin,FVector.ItEnd);
  CheckEquals(tmpVector.size,10);
  Check(tmpVector.Items[3]=tmpIntf);
  CheckEquals(FVector.size,10);
  FVector.Reserve(1000);
  CheckEquals(FVector.size,10);
  FVector.Resize(7);
  CheckEquals(FVector.size,7);

  FVector.Erase(FVector.ItBegin,FVector.ItEnd);
  CheckEquals(FVector.size,0);
  for i:=0 to 15-1 do
    FVector.Insert(FVector.ItEnd,TInterfacedObject.Create());
  It0:=FVector.ItBegin;
  It0.Next(5);
  it1:=FVector.ItEnd;
  It1.Next(-5);
  FVector.Erase(It0,it1);
  CheckEquals(FVector.size,10);
  It0:=FVector.ItBegin.Clone(5);
  FVector.Erase(It0);
  CheckEquals(FVector.size,9);

  tmpIntf:=TInterfacedObject.Create();
  It0:=FVector.ItBegin.Clone(5);
  FVector.Insert(It0,tmpIntf);
  CheckEquals(FVector.size,10);
  Check(FVector.Items[5]=tmpIntf);

  tmpIntf:=TInterfacedObject.Create();
  It0:=FVector.ItBegin.Clone(5);
  FVector.Insert(It0,tmpIntf);
  CheckEquals(FVector.size,11);
  Check(FVector.Items[5]=tmpIntf);

  //
  tmpIntf:=TInterfacedObject.Create();
  tmpIntf2:=TInterfacedObject.Create();
  FVector.Clear();
  FVector.PushFront(3,tmpIntf);
  CheckEquals(FVector.size,3);
  Check(FVector.Items[2]=tmpIntf);

  FVector.PushFront(5,tmpIntf2);
  CheckEquals(FVector.size,8);
  Check(FVector.Items[0]=tmpIntf2);
  Check(FVector.Items[4]=tmpIntf2);
  Check(FVector.Items[5]=tmpIntf);
  Check(FVector.Items[7]=tmpIntf);


end;

procedure TTest_Vector.testIterator;
var
    FVector        : IPointerVector;
    i : _TNativeInt;
    It : IPointerIterator;
    tmpIt : IPointerIterator;
begin
  FVector :=TPointerVector.Create(10,Pointer(3));
  CheckEquals(FVector.size,10);

  CheckEquals(_TNativeInt(FVector.items[5]),(3));

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

procedure TTest_Vector.testObj(var ov:IObjVector);
var
  it : IObjIterator;
  it0,it1 : IObjIterator;
  ob : TTestObj;
  ob0 : TTestObj;
  tmpV :  IObjVector;     
begin
  ov.Resize(5);
  CheckEquals(_refCount,5);
  ov.Clear();
  CheckEquals(_refCount,0);

  ov.Clear();
  ov.Resize(3000);
  //tmpV:=TObjVector.Create();
  //tmpV:=IObjVector(ov.Clone());
  ov.CloneToInterface(tmpV);
  CheckEquals(_refCount,6000);
  ov.PushBack(tmpV.ItBegin,tmpV.ItEnd);
  CheckEquals(_refCount,9000);
  ov.PushFront(tmpV.ItBegin,tmpV.ItEnd);
  CheckEquals(_refCount,12000);
  tmpV:=nil;

  CheckEquals(_refCount,9000);


  It:=ov.ItBegin.Clone(6);
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

  ov.Assign(4,ob);
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
  it.Value.FValue:=ob0.FValue;
  CheckEquals(ov.Items[0].FValue,ob0.FValue);

  FreeAndNil(ob);
  FreeAndNil(ob0);
  ov:=nil;
end;

procedure TTest_Vector.testObjVector;
var
  ov : IObjVector;
begin
  ov:=TObjVector.Create();
  testObj(ov);
  ov:=TObjDeque.Create();
  testObj(ov);
end;

procedure TTest_Vector.testRecordVector;
var
    FVector        : IPointVector;
    tmpVector        : IPointVector;
    i : _TNativeInt;
    It0,It1:IPointIterator;
begin
  FVector :=TPointVector.Create();
  Check(FVector.IsEmpty());

  FVector.Insert(FVector.ItBegin,Point(5,5));
  CheckEquals(FVector.Size,1);
  Check(FVector.Back.x=5);

  Check(FVector.ItBegin.Value.x=(5));

  FVector.Clear();
  Check(FVector.IsEmpty);

  tmpVector:=IPointVector(FVector.Clone());
  tmpVector.PushBack(Point(13,11));
  Check(FVector.IsEmpty);
  Check(tmpVector.ItBegin.Value.x=(13));
  Check(tmpVector.ItBegin.Value.y=(11));

  FVector.PushBack(Point(31,31));
  tmpVector:=TPointVector.Create(FVector.ItBegin,FVector.ItEnd);
  Check(tmpVector.Back.x=(31));

  FVector.Clear();
  for i:=2 to 50 do
    FVector.PushBack(Point(i,i));
  tmpVector.Clear();
  tmpVector.PushBack(Point(1,1));
  tmpVector.Insert(tmpVector.ItBegin,FVector.ItBegin,FVector.ItEnd);

  CheckEquals(FVector.Size,49);
  CheckEquals(FVector.IndexOf(Point(3,3)),1);
  CheckEquals(tmpVector.IndexOf(Point(1,1)),50-1);
  Check(FVector.Items[2].x=(4));

  FVector.Items[3]:=Point(17,17);
  Check(FVector.Items[3].y=(17));

  Check(not FVector.IsEquals(tmpVector));
  FVector.Clear();
  FVector.PushBack(tmpVector.ItBegin,tmpVector.ItEnd);
  Check(FVector.IsEquals(tmpVector));

  FVector.Clear();
  for i:=0 to 50-1 do
    FVector.PushBack(Point(i,i));
  FVector.Items[4]:=Point(17,17);
  CheckEquals(FVector.EraseValue(Point(17,17)),2);
  CheckEquals(FVector.Size,48);

  Check(FVector.Back.x=Point(49,49).x);
  FVector.PopBack();
  Check(FVector.Back.y=Point(48,48).y);


  //
  FVector.PushFront(Point(21,21));
  Check(FVector.Front.y=(21));
  FVector.PushFront(Point(13,13));
  Check(FVector.Front.y=(13));
  Check(FVector.Items[1].x=(21));
  FVector.PopFront();
  Check(FVector.Front.y=(21));

  FVector.Assign(10,Point(5,5));
  CheckEquals(FVector.size,10);
  Check(FVector.Items[3].y=(5));
  tmpVector.Assign(FVector.ItBegin,FVector.ItEnd);
  CheckEquals(tmpVector.size,10);
  Check(tmpVector.Items[3].x=(5));
  CheckEquals(FVector.size,10);
  FVector.Reserve(1000);
  CheckEquals(FVector.size,10);
  FVector.Resize(7);
  CheckEquals(FVector.size,7);

  FVector.Erase(FVector.ItBegin,FVector.ItEnd);
  CheckEquals(FVector.size,0);
  for i:=0 to 15-1 do
    FVector.Insert(FVector.ItEnd,Point(i,i));
  It0:=FVector.ItBegin;
  It0.Next(5);
  it1:=FVector.ItEnd;
  It1.Next(-5);
  FVector.Erase(It0,it1);
  CheckEquals(FVector.size,10);
  Check(FVector.Items[6].y=(11));
  FVector.Erase(It0);
  CheckEquals(FVector.size,9);
  Check(FVector.Items[6].x=(12));
  
  It0:=FVector.ItBegin.Clone(5);
  FVector.Insert(It0,Point(31,31));
  CheckEquals(FVector.size,10);
  Check(FVector.Items[5].y=(31));
  Check(FVector.Items[6].x=(11));

  It0:=FVector.ItBegin.Clone(5);
  FVector.Insert(It0,Point(32,32));
  CheckEquals(FVector.size,11);
  Check(FVector.Items[5].x=(32));
  Check(FVector.Items[6].y=(31));

  //
  FVector.Clear();
  FVector.PushFront(3,Point(12,12));
  CheckEquals(FVector.size,3);
  Check(FVector.Items[2].y=(12));

  FVector.PushFront(5,Point(11,11));
  CheckEquals(FVector.size,8);
  Check(FVector.Items[0].x=(11));
  Check(FVector.Items[4].x=(11));
  Check(FVector.Items[5].y=(12));
  Check(FVector.Items[7].x=(12));

  //}
end;

procedure TTest_Vector.testStrIterator;
var
    FVector        : IStrVector;
    i : _TNativeInt;
    It : IstrIterator;
    tmpIt : IStrIterator;
begin
  FVector :=TStrVector.Create(10,'3');
  CheckEquals(FVector.size,10);

  CheckEquals(FVector.items[5],'3');

  FVector.Clear();
  for i:=0 to 50-1 do
    FVector.PushBack(inttostr(i));

  It:=FVector.ItBegin;
  It.Next();
  CheckEquals(It.Value,'1');
  It.Next(4);
  CheckEquals((It.Value),'5');
  CheckEquals(FVector.ItBegin.Distance(It),(5));
  It:=FVector.ItEnd;
  It.Previous();
  CheckEquals((It.Value),'49');
  It.Next(-2);
  CheckEquals((It.Value),'47');

  tmpIt:=It.Clone();
  CheckEquals((tmpIt.Value),(It.Value));
  Check(tmpIt.IsEqual(It));
  tmpIt.Value:=inttostr(strtoint(It.Value)+1);
  CheckEquals((tmpIt.Value),(It.Value));

  tmpIt.Previous;
  CheckNotEquals((tmpIt.Value),(It.Value));

  it.Assign(tmpIt);
  CheckEquals((tmpIt.Value),(It.Value));
  tmpIt.Previous;
  CheckNotEquals((tmpIt.Value),(It.Value));
end;

procedure TTest_Vector.testStrVector;
var
    FVector        : IStrVector;
    tmpVector        : IStrVector;
    i : _TNativeInt;
    It0,It1 : IStrIterator;
begin
  FVector :=TStrVector.Create();
  Check(FVector.IsEmpty());

  FVector.Insert(Fvector.ItBegin,'5');
  CheckEquals(FVector.Size,1);
  Check(FVector.Back='5');

  Check(FVector.ItBegin.Value='5');

  FVector.Clear();
  Check(FVector.IsEmpty);

  tmpVector:=IStrVector(FVector.Clone());
  tmpVector.PushBack('13');
  Check(FVector.IsEmpty);
  Check(tmpVector.ItBegin.Value='13');

  FVector.PushBack('31');
  tmpVector:=TStrVector.Create(FVector.ItBegin,FVector.ItEnd);
  Check(tmpVector.Back='31');

  FVector.Clear();
  for i:=2 to 50 do
    FVector.PushBack(inttostr(i));
  tmpVector.Clear();
  tmpVector.PushBack('1');
  tmpVector.Insert(tmpVector.ItBegin,FVector.ItBegin,FVector.ItEnd);

  CheckEquals(FVector.Size,49);
  CheckEquals(FVector.IndexOf('3'),1);
  CheckEquals(tmpVector.IndexOf('1'),50-1);
  Check(FVector.Items[2]='4');

  FVector.Items[3]:='17';
  Check(FVector.Items[3]='17');

  Check(not FVector.IsEquals(tmpVector));
  FVector.Clear();
  FVector.PushBack(tmpVector.ItBegin,tmpVector.ItEnd);
  Check(FVector.IsEquals(tmpVector));

  FVector.Clear();
  for i:=0 to 50-1 do
    FVector.PushBack(inttostr(i));
  FVector.Items[4]:='17';
  CheckEquals(FVector.EraseValue('17'),2);
  CheckEquals(FVector.Size,48);

  Check(FVector.Back='49');
  FVector.PopBack();
  Check(FVector.Back='48');

  //
  FVector.PushFront('21');
  Check(FVector.Front='21');
  FVector.PushFront('13');
  Check(FVector.Front='13');
  Check(FVector.Items[1]='21');
  FVector.PopFront();
  Check(FVector.Front='21');

  FVector.Assign(10,'5');
  CheckEquals(FVector.size,10);
  Check(FVector.Items[3]='5');
  tmpVector.Assign(FVector.ItBegin,FVector.ItEnd);
  CheckEquals(tmpVector.size,10);
  Check(tmpVector.Items[3]='5');
  CheckEquals(FVector.size,10);
  FVector.Reserve(1000);
  CheckEquals(FVector.size,10);
  FVector.Resize(7);
  CheckEquals(FVector.size,7);

  FVector.Erase(FVector.ItBegin,FVector.ItEnd);
  CheckEquals(FVector.size,0);
  for i:=0 to 15-1 do
    FVector.Insert(FVector.ItEnd,inttostr(i));
  It0:=FVector.ItBegin;
  It0.Next(5);
  it1:=FVector.ItEnd;
  It1.Next(-5);
  FVector.Erase(It0,it1);
  CheckEquals(FVector.size,10);
  Check(FVector.Items[6]='11');
  It0:=FVector.ItBegin.Clone(5);
  FVector.Erase(It0);
  CheckEquals(FVector.size,9);
  Check(FVector.Items[6]='12');
  
  It0:=FVector.ItBegin.Clone(5);
  FVector.Insert(It0,'31');
  CheckEquals(FVector.size,10);
  Check(FVector.Items[5]='31');
  Check(FVector.Items[6]='11');

  It0:=FVector.ItBegin.Clone(5);
  FVector.Insert(It0,'32');
  CheckEquals(FVector.size,11);
  Check(FVector.Items[5]='32');
  Check(FVector.Items[6]='31');

  //
  FVector.Clear();
  FVector.PushFront(3,'12');
  CheckEquals(FVector.size,3);
  Check(FVector.Items[2]='12');

  FVector.PushFront(5,'11');
  CheckEquals(FVector.size,8);
  Check(FVector.Items[0]='11');
  Check(FVector.Items[4]='11');
  Check(FVector.Items[5]='12');
  Check(FVector.Items[7]='12');

end;

procedure TTest_Vector.testVector;
var
    FVector        : IPointerVector;
    tmpVector        : IPointerVector;
    i : _TNativeInt;
    It0,It1:IPointerIterator;
begin
  FVector :=TPointerVector.Create();
  Check(FVector.IsEmpty());

  FVector.Insert(FVector.ItBegin,pointer(5));
  CheckEquals(FVector.Size,1);
  Check(FVector.Back=pointer(5));

  Check(FVector.ItBegin.Value=pointer(5));

  FVector.Clear();
  Check(FVector.IsEmpty);

  tmpVector:=IPointerVector(FVector.Clone());
  tmpVector.PushBack(Pointer(13));
  Check(FVector.IsEmpty);
  Check(tmpVector.ItBegin.Value=Pointer(13));

  FVector.PushBack(Pointer(31));
  tmpVector:=TPointerVector.Create(FVector.ItBegin,FVector.ItEnd);
  Check(tmpVector.Back=Pointer(31));

  FVector.Clear();
  for i:=2 to 50 do
    FVector.PushBack(Pointer(i));
  tmpVector.Clear();
  tmpVector.PushBack(Pointer(1));
  tmpVector.Insert(tmpVector.ItBegin,FVector.ItBegin,FVector.ItEnd);

  CheckEquals(FVector.Size,49);
  CheckEquals(FVector.IndexOf(Pointer(3)),1);
  CheckEquals(tmpVector.IndexOf(Pointer(1)),50-1);
  Check(FVector.Items[2]=Pointer(4));

  FVector.Items[3]:=Pointer(17);
  Check(FVector.Items[3]=Pointer(17));

  Check(not FVector.IsEquals(tmpVector));
  FVector.Clear();
  FVector.PushBack(tmpVector.ItBegin,tmpVector.ItEnd);
  Check(FVector.IsEquals(tmpVector));

  FVector.Clear();
  for i:=0 to 50-1 do
    FVector.PushBack(Pointer(i));
  FVector.Items[4]:=Pointer(17);
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
  Check(FVector.Items[1]=Pointer(21));
  FVector.PopFront();
  Check(FVector.Front=Pointer(21));

  FVector.Assign(10,Pointer(5));
  CheckEquals(FVector.size,10);
  Check(FVector.Items[3]=Pointer(5));
  tmpVector.Assign(FVector.ItBegin,FVector.ItEnd);
  CheckEquals(tmpVector.size,10);
  Check(tmpVector.Items[3]=Pointer(5));
  CheckEquals(FVector.size,10);
  FVector.Reserve(1000);
  CheckEquals(FVector.size,10);
  FVector.Resize(7);
  CheckEquals(FVector.size,7);

  FVector.Erase(FVector.ItBegin,FVector.ItEnd);
  CheckEquals(FVector.size,0);
  for i:=0 to 15-1 do
    FVector.Insert(FVector.ItEnd,Pointer(i));
  It0:=FVector.ItBegin.Clone(5);
  it1:=FVector.ItEnd;
  It1.Next(-5);
  FVector.Erase(It0,it1);
  CheckEquals(FVector.size,10);
  Check(FVector.Items[6]=Pointer(11));
  FVector.Erase(It0);
  CheckEquals(FVector.size,9);
  Check(FVector.Items[6]=Pointer(12));


  It0:=FVector.ItBegin.Clone(5);
  FVector.Insert(It0,Pointer(31));
  CheckEquals(FVector.size,10);
  Check(FVector.Items[5]=Pointer(31));
  Check(FVector.Items[6]=Pointer(11));

  It0:=FVector.ItBegin.Clone(5);
  FVector.Insert(It0,Pointer(32));
  CheckEquals(FVector.size,11);
  Check(FVector.Items[5]=Pointer(32));
  Check(FVector.Items[6]=Pointer(31));

  //
  FVector.Clear();
  FVector.PushFront(3,Pointer(12));
  CheckEquals(FVector.size,3);
  Check(FVector.Items[2]=Pointer(12));

  FVector.PushFront(5,Pointer(11));
  CheckEquals(FVector.size,8);
  Check(FVector.Items[0]=Pointer(11));
  Check(FVector.Items[4]=Pointer(11));
  Check(FVector.Items[5]=Pointer(12));
  Check(FVector.Items[7]=Pointer(12));

end;

initialization
  RegisterTest(TTest_Vector.Suite);
end.
