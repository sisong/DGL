unit TestSet;

interface
uses
  Classes, SysUtils,
  TestFramework,
  TestExtensions,
  //DGL_Pointer;
  DGL_String,DGL_Interface,
  _DGL_Object,_DGL_Point,DGL_Pointer;

type

  TTest_Set = class(TTestCase)
  private
    procedure private_TestSet2(st: _ISet; const Count: _TNativeInt);
    procedure private_TestMultiSet2(st: _IMultiSet; const Count: _TNativeInt);
  public
    procedure Setup; override;
    procedure TearDown; override;

    procedure private_testSet(st:_ISet);
    procedure private_testSetIterator(st:_ISet);
    procedure private_testMultiSet(st:_ISet);
  published
    procedure testSet();
    procedure testSetIterator();
    procedure testMultiSet();

    procedure testSet2();
    procedure testMultiSet2();

    procedure testHashSet();
    procedure testHashSetIterator();
    procedure testHashMultiSet();

    procedure testHashSet2();
    procedure testHashMultiSet2();
  end;

implementation

{ TTest_Set }

procedure TTest_Set.Setup;
begin
  inherited;

end;

procedure TTest_Set.TearDown;
begin
  inherited;

end;

  procedure TTest_Set.private_TestMultiSet2(st  : _IMultiSet;const Count:_TNativeInt);
  var
    i : _TNativeInt;
    Index: _TNativeInt;
    Values : array of pointer;
    ValueCount: _TNativeInt;
  begin
    setlength(Values,Count);
    ValueCount:=0;
    for i:=0 to Count*2-1 do
    begin
      Index:=_DGL_Random(Count);
      if Values[Index]=nil then
      begin
        Values[Index]:=pointer((Index+5) div 4) ;
        st.Insert(Values[Index]);
        inc(ValueCount);
        CheckEquals(st.Size,ValueCount);
      end
      else
      begin
        st.Erase(st.Find(Values[Index]));
        Values[Index]:=nil;
        dec(ValueCount);
        CheckEquals(st.Size,ValueCount);
      end;
    end;
    //
    for i:=0 to Count-1 do
    begin
      Index:=i;
      if Values[Index]<>nil then
      begin
        st.Erase(st.Find(Values[Index]));
        Values[Index]:=nil;
        dec(ValueCount);
        CheckEquals(st.Size,ValueCount);
      end;
    end;

    CheckEquals(st.Size,0);
  end;
  procedure TTest_Set.private_TestSet2(st  : _ISet;const Count:_TNativeInt);
  var
    i : _TNativeInt;
    Index: _TNativeInt;
    Values : array of pointer;
    ValueCount: _TNativeInt;
  begin
    setlength(Values,Count);
    ValueCount:=0;
    for i:=0 to Count*2-1 do
    begin
      Index:=_DGL_Random(Count);
      if Values[Index]=nil then
      begin
        Values[Index]:=pointer(Index+1) ;
        st.Insert(Values[Index]);
        inc(ValueCount);
        CheckEquals(st.Size,ValueCount);
      end
      else
      begin
        st.Erase(st.Find(Values[Index]));
        Values[Index]:=nil;
        dec(ValueCount);
        CheckEquals(st.Size,ValueCount);
      end;
    end;
    //
    for i:=0 to Count-1 do
    begin
      Index:=i;
      if Values[Index]<>nil then
      begin
        st.Erase(st.Find(Values[Index]));
        Values[Index]:=nil;
        dec(ValueCount);
        CheckEquals(st.Size,ValueCount);
      end;
    end;

    CheckEquals(st.Size,0);
  end;

procedure TTest_Set.testHashSet2;
var
  st  : _ISet;
  i : _TNativeInt;
const
  csCount=13;
begin
  st:=_THashSet.Create();
  for i:=0 to 57-1 do
  begin
    private_TestSet2(st,i*csCount+_DGL_Random(csCount));
  end;

end;
procedure TTest_Set.testHashMultiSet2;
var
  st  : _IMultiSet;
  i : _TNativeInt;
const
  csCount=13;
begin
  st:=_THashMultiSet.Create();

  for i:=0 to 57-1 do
  begin
    private_TestMultiSet2(st,i*csCount+_DGL_Random(csCount));
  end;
end;


procedure TTest_Set.testHashSet;
var
  st  : _ISet;
begin
  st:=_THashSet.Create();
  self.private_testSet(st);
end;

procedure TTest_Set.testHashMultiSet;
var
  st  : _ISet;
begin
  st:=_THashMultiSet.Create();
  self.private_testMultiSet(st);
end;


procedure TTest_Set.testHashSetIterator;
var
    st  : _IMultiSet;
begin
  st :=_THashMultiSet.Create();
  self.private_testSetIterator(st);
end;


procedure TTest_Set.testSet2;
var
  st  : _ISet;
  i : _TNativeInt;
const
  csCount=13;
begin
  st:=_TSet.Create();
  for i:=0 to 57-1 do
  begin
    private_TestSet2(st,i*csCount+_DGL_Random(csCount));
  end;

end;
procedure TTest_Set.testMultiSet2;
var
  st  : _IMultiSet;
  i : _TNativeInt;
const
  csCount=13;
begin
  st:=_TMultiSet.Create();

  for i:=0 to 57-1 do
  begin
    private_TestMultiSet2(st,i*csCount+_DGL_Random(csCount));
  end;
end;


procedure TTest_Set.testSet;
var
  st  : _ISet;
begin
  st:=_TSet.Create();
  self.private_testSet(st);
end;

procedure TTest_Set.testMultiSet;
var
  st  : _ISet;
begin
  st:=_TMultiSet.Create();
  self.private_testMultiSet(st);
end;


procedure TTest_Set.testSetIterator;
var
    st  : _IMultiSet;
begin
  st :=_TMultiSet.Create();
  self.private_testSetIterator(st);
end;

procedure TTest_Set.private_testMultiSet(st: _ISet);
  function GetStr(const c:_IContainer):string;
  var
    it,itEnd: _IIterator;
  begin
    it:=c.ItBegin;
    itEnd:=c.ItEnd;
    result:='';
    while not it.IsEqual(itEnd) do begin
      result := result+inttostr(_TNativeInt(it.Value))+' ';
      it.Next();
    end;
  end;
var
  st0 : _ISet;
  it : _IIterator;
  it0,it1 : _IIterator;
  i : _TNativeInt;
begin
  CheckEquals(st.Size,0);
  st.Insert(Pointer(3));
  CheckEquals(st.Size,1);
  st.Insert(Pointer(3));
  CheckEquals(st.Size,2);
  st.Insert(Pointer(7));
  CheckEquals(st.Size,3);
  st.Insert(Pointer(2));
  CheckEquals(st.EraseValue(Pointer(3)),2);
  CheckEquals(st.EraseValue(Pointer(3)),0);

  //7,2 in
  CheckEquals(st.Count(Pointer(7)),1);
  CheckEquals(st.Count(Pointer(3)),0);
  it:=st.Find(Pointer(13));
  Check(it.IsEqual(st.ItEnd));
  it:=st.ItBegin;
  CheckEquals(st.Size,2);
  CheckEquals(it.Distance(st.ItEnd),2);

  st.Clear();
  CheckEquals(st.Size,0);
  for i:=0 to 1000-1 do
  begin
    st.Insert(pointer(i div 10));
  end;

  it0:=st.LowerBound(pointer(5));
  it1:=st.UpperBound(pointer(5));
  CheckEquals(it0.Distance(it1),10); //
  CheckEquals(_TNativeInt(it0.Value),5);

  st.EqualRange(Pointer(7),it0,it1);
  CheckEquals(it0.Distance(it1),10); //
  CheckEquals(_TNativeInt(it0.Value),7);

  st0:=_ISet(st.Clone);
  CheckEquals(st.Size,st0.Size);

  Check(not st0.IsEmpty);

  st.Clear();
  st.Assign(st0.ItBegin,st0.ItEnd);

  it:=st.Find(Pointer(10));
  CheckEquals(_TNativeInt(it.Value),10);
  st.Erase(it);
  it:=st.Find(Pointer(10));
  Check(not st.ItEnd.IsEqual(it));
  CheckEquals(st.Count(Pointer(10)),9);

  
  CheckEquals(st.Count(Pointer(17)),10);
  st.EqualRange(Pointer(17),it0,it1);
  CheckEquals(it0.Distance(it1),10);
  i:=st.Size();
  st.Erase(it0,it1);
  //CheckEquals('',GetStr(st));
  CheckEquals(st.Count(Pointer(17)),0);
  CheckEquals(st.Size,i-10);


  CheckEquals(st.Count(Pointer(17)),0);
  it:=st.Find(Pointer(17));
  st.Insert(it,Pointer(17));
  CheckEquals(st.Count(Pointer(17)),1);

  CheckEquals(st.Count(Pointer(10)),9);
  it:=st.Find(Pointer(17));
  st.Insert(it,5,Pointer(10));
  CheckEquals(st.Count(Pointer(10)),14);


  st0.Clear();
  st:=nil;
  //CheckEquals(testTHashNodeCount,0);
  //}
end;

procedure TTest_Set.private_testSet(st: _ISet);
var
  st0 : _ISet;
  it : _IIterator;
  it0,it1 : _IIterator;
  i : _TNativeInt;
begin
  CheckEquals(st.Size,0);
  st.Insert(Pointer(3));

  CheckEquals(st.Size,1);
  st.Insert(Pointer(3));
  CheckEquals(st.Size,1);
  st.Insert(Pointer(7));
  CheckEquals(st.Size,2);
  st.Insert(Pointer(2));
  CheckEquals(st.EraseValue(Pointer(3)),1);
  CheckEquals(st.EraseValue(Pointer(3)),0);

  //7,2 in
  CheckEquals(st.Count(Pointer(7)),1);
  CheckEquals(st.Count(Pointer(3)),0);
  it:=st.Find(Pointer(13));
  Check(it.IsEqual(st.ItEnd));
  it:=st.ItBegin;
  CheckEquals(st.Size,2);
  CheckEquals(it.Distance(st.ItEnd),2);

  st.Clear();
  CheckEquals(st.Size,0);
  for i:=0 to 100000-1 do
  begin
    st.Insert(pointer(i div 10));
  end;

  it0:=st.LowerBound(pointer(5));
  it1:=st.UpperBound(pointer(5));
  CheckEquals(it0.Distance(it1),1); //
  CheckEquals(_TNativeInt(it0.Value),5);

  st.EqualRange(Pointer(7),it0,it1);
  CheckEquals(_TNativeInt(it0.Value),7);
  CheckEquals(it0.Distance(it1),1); //

  st0:=_ISet(st.Clone);
  CheckEquals(st.Size,st0.Size);
  Check(not st0.IsEmpty);

  st.Clear();
  st.Assign(st0.ItBegin,st0.ItEnd);

  it:=st.Find(Pointer(10));
  CheckEquals(_TNativeInt(it.Value),10);
  st.Erase(it);
  it:=st.Find(Pointer(10));
  Check(st.ItEnd.IsEqual(it));


  CheckEquals(st.Count(Pointer(13)),1);
  st.EqualRange(Pointer(13),it0,it1);
  st.Erase(it0,it1);
  CheckEquals(st.Count(Pointer(13)),0);

  CheckEquals(st.Count(Pointer(13)),0);
  it:=st.Find(Pointer(13));
  st.Insert(it,Pointer(13));
  CheckEquals(st.Count(Pointer(13)),1);

  CheckEquals(st.Count(Pointer(10)),0);
  it:=st.Find(Pointer(13));
  st.Insert(it,Pointer(10));
  CheckEquals(st.Count(Pointer(10)),1);

  st0.Clear();
  st:=nil;
  //CheckEquals(testTHashNodeCount,0);
  //}
end;

procedure TTest_Set.private_testSetIterator(st: _ISet);
var
    i   : _TNativeInt;
    It0,It1   : IPointerIterator;

begin
  CheckEquals(st.size,0);

  st.Insert(Pointer(7));
  st.Insert(Pointer(13));

  it0:=st.ItBegin();
  it1:=st.ItEnd();
  CheckEquals(It0.Distance(It1),2);
  it1.Previous();
  CheckEquals(_TNativeInt(It0.Value)+_TNativeInt(It1.Value),20);

  it0:=st.ItBegin();
  it1:=st.ItEnd();
  it0.Next(2);
  it1.Next(-2);
  CheckEquals(It1.Distance(It0),2);
  it0.Previous();
  CheckEquals(_TNativeInt(It0.Value)+_TNativeInt(It1.Value),20);

  st.Clear();
  for i:=0 to 10000 do
    st.Insert(Pointer(i div 37));
  st.EqualRange(Pointer(25),It0,It1);
  CheckEquals(It0.Distance(It1),37);
  it0.Next(20);
  it1.Next(-7-8);
  CheckEquals(It0.Distance(It1),2);
  st.Erase(it0,it1);

end;

initialization
  RegisterTest(TTest_Set.Suite);
end.
