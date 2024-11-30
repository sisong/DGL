unit TestMap;

interface
uses
  Classes, SysUtils,
  TestFramework,
  TestExtensions,
  _DGLMap_String_Integer;

type

  TTest_Map = class(TTestCase)
  public
    procedure Setup; override;
    procedure TearDown; override;
    procedure private_testMap(const st:IStrIntMap);
    procedure private_testMapIterator(const st:IStrIntMap);
    procedure private_testMultiMap(const st:IStrIntMultiMap);
  published
    procedure testMap();
    procedure testMapIterator();
    procedure testMultiMap();
    procedure testHashMap();
    procedure testHashMapIterator();
    procedure testHashMultiMap();
  end;

implementation

{ TTest_Map }

procedure TTest_Map.Setup;
begin
  inherited;

end;

procedure TTest_Map.TearDown;
begin
  inherited;

end;

procedure TTest_Map.testHashMultiMap;
var
  st  : IStrIntMultiMap;
begin
  st:=TStrIntHashMultiMap.Create();
  self.private_testMultiMap(st);
end;

procedure TTest_Map.testHashMap;
var
  st  : IStrIntMap;
begin
  st:=TStrIntHashMap.Create();
  self.private_testMap(st);
end;

procedure TTest_Map.testHashMapIterator;
var
    st  : IStrIntMultiMap;
begin
  st :=TStrIntHashMultiMap.Create();
  self.private_testMapIterator(st);
end;

procedure TTest_Map.testMultiMap;
var
  st  : IStrIntMultiMap;
begin
  st:=TStrIntMultiMap.Create();
  self.private_testMultiMap(st);
end;

procedure TTest_Map.testMap;
var
  st  : IStrIntMap;
begin
  st:=TStrIntMap.Create();
  self.private_testMap(st);
end;

procedure TTest_Map.testMapIterator;
var
    st  : IStrIntMultiMap;
begin
  st :=TStrIntMultiMap.Create();
  self.private_testMapIterator(st);
end;

procedure TTest_Map.private_testMap(const st: IStrIntMap);
var
  it : IStrIntMapIterator;
  i: _TNativeInt;
begin
  CheckEquals(st.Size,0);

  for i:=0 to 10000-1 do
    st.Insert(inttostr(i div 10),((i div 10)*3+1));
  CheckEquals(st.Size,10000 div 10);

  it:=st.ItBegin() ;
  for i:=0 to st.Size-1 do
  begin
    CheckEquals(StrToInt(it.Key)*3+1,(it.Value));
    it.Next();
  end;

  st.Clear();
  for i:=0 to 1000-1 do
    st.Insert(inttostr(i div 3),((i div 7)*3+1));

  i:=st.Size();
  CheckEquals(((1000-1) div 3)+1,i);

  CheckEquals(st.Count(inttostr(8)),1);

  it:=st.Find(inttostr(8));
  st.Erase(it);
  CheckEquals(st.Count(inttostr(8)),0);
  CheckEquals(st.Size,i-1);

  st.EraseValue((12*3+1));
  CheckEquals(st.EraseValue((12*3+1)),0);

  st.Clear;
  for i:=0 to 1000-1 do
    st.Insert(inttostr(i),((i div 11)*7+1));
  CheckEquals(st.EraseValue((25*7+1)),11);
end;

procedure TTest_Map.private_testMapIterator(const st: IStrIntMap);
var
    i   : _TNativeInt;
    It0,It1   : IStrIntMapIterator;

begin
  CheckEquals(st.size,0);

  st.Insert(inttostr(7),(7*7));
  st.Insert(inttostr(13),(13*13));

  it0:=st.ItBegin();
  it1:=st.ItEnd();
  CheckEquals(It0.Distance(It1),2);
  it1.Previous();
  CheckEquals((It0.Value)+(It1.Value),7*7+13*13);

  it0:=st.ItBegin();
  it1:=st.ItEnd();
  it0.Next(2);
  it1.Next(-2);
  CheckEquals(It1.Distance(It0),2);
  it0.Previous();
  CheckEquals(Abs((It0.Value)-(It1.Value)),Abs(7*7-13*13));
  CheckEquals(StrToInt(It0.Key)*StrToInt(It1.Key),7*13);

  st.Clear();
  for i:=0 to 10000 do
    st.Insert(inttostr(i div 37),(i*i));
  st.EqualRange(inttostr(25),It0,It1);
  CheckEquals(It0.Distance(It1),37);
  it0.Next(20);
  it1.Next(-7-8);
  CheckEquals(It0.Distance(It1),2);
  st.Erase(it0,it1);
end;

procedure TTest_Map.private_testMultiMap(const st: IStrIntMultiMap);
  function GetStr(const c:_IContainer):string;
  var
    it,itEnd: _IIterator;
  begin
    it:=c.ItBegin;
    itEnd:=c.ItEnd;
    result:='';
    while not it.IsEqual(itEnd) do begin
      result := result+inttostr((it.Value))+' ';
      it.Next();
    end;
  end;
var
  it : IStrIntMapIterator;
  i : _TNativeInt;
begin
  CheckEquals(st.Size,0);

  for i:=0 to 10000-1 do
    st.Insert(inttostr(i div 10),((i div 10)*3+1));
  CheckEquals(st.Size,10000);

  it:=st.ItBegin() ;
  for i:=0 to st.Size-1 do
  begin
    CheckEquals(StrToInt(it.Key)*3+1,(it.Value));
    it.Next();
  end;

  st.Clear();
  for i:=0 to 1000-1 do
    st.Insert(inttostr(i div 3),((i div 7)*3+1));

  i:=st.Size();
  CheckEquals(1000,i);

  CheckEquals(st.Count(inttostr(8)),3);

  it:=st.Find(inttostr(8));
  st.Erase(it);
  CheckEquals(st.Count(inttostr(8)),2);
  CheckEquals(st.Size,i-1);

  CheckEquals(st.EraseValue((12*3+1)),7);
  CheckEquals(st.EraseValue((12*3+1)),0);

  st.Clear;
  for i:=0 to 1000-1 do
    st.Insert(inttostr(i),((i div 11)*7+1));
  CheckEquals(st.EraseValue((25*7+1)),11);

end;

initialization
  RegisterTest(TTest_Map.Suite);
end.
