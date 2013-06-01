unit TestPriorityQueue;

interface
uses
  Classes, SysUtils,
  TestFramework,
  TestExtensions,
  DGL_Pointer,DGL_String,DGL_Interface,
  _DGL_Object,_DGL_Point;

type

  TTest_PriorityQueue = class(TTestCase)
  private
  function SelfCompareFunction(const Value0,Value1:string):Boolean;
  public
    procedure Setup; override;
    procedure TearDown; override;
  published
    procedure testPriorityQueue();
    procedure testPriorityQueue2();
  end;
  
implementation

{ TTest_PriorityQueue }

function TTest_PriorityQueue.SelfCompareFunction(const Value0,
  Value1: string): Boolean;
begin
  result:=AnsiUpperCase(Value0)>AnsiUpperCase(Value1);
end;

procedure TTest_PriorityQueue.Setup;
begin
  inherited;

end;

procedure TTest_PriorityQueue.TearDown;
begin
  inherited;

end;

procedure TTest_PriorityQueue.testPriorityQueue;
var
  PriorityQueue : IStrPriorityQueue;
  sk : IStrPriorityQueue;
  i : integer;
begin
  PriorityQueue:=TStrPriorityQueue.Create();
  Check( PriorityQueue.IsEmpty);
  PriorityQueue:=TStrPriorityQueue.Create();
  PriorityQueue.Push('2');
  PriorityQueue.Push('6');
  PriorityQueue.Push('4');
  PriorityQueue.Push('0');
  PriorityQueue.Push('2');
  CheckEquals( PriorityQueue.Size,5);
  PriorityQueue.Pop();
  CheckEquals( PriorityQueue.Top,'4');
  PriorityQueue.Pop();
  CheckEquals( PriorityQueue.Top,'2');
  PriorityQueue.Pop();
  CheckEquals( PriorityQueue.Top,'2');
  PriorityQueue.Pop();
  CheckEquals( PriorityQueue.Top,'0');
  CheckEquals( PriorityQueue.Size,1);
  PriorityQueue.Clear();
  CheckEquals( PriorityQueue.Size,0);

  PriorityQueue.Push('1');
  CheckEquals(PriorityQueue.Top,'1');
  PriorityQueue.Push('4');
  PriorityQueue.Push('3');
  CheckEquals(PriorityQueue.Top,'4');
  CheckEquals(PriorityQueue.Size,3);

  PriorityQueue.Pop();
  CheckEquals(PriorityQueue.Top,'3');
  PriorityQueue.Pop();
  CheckEquals(PriorityQueue.Top,'1');
  PriorityQueue.Pop();
  CheckEquals(PriorityQueue.size,0);

  PriorityQueue.Push('3');
  PriorityQueue.Clear();
  CheckEquals(PriorityQueue.size,0);

  PriorityQueue.Clear() ;
  for i:=0 to 100-1 do
    PriorityQueue.Push(inttostr(i));
  Check(not PriorityQueue.IsEmpty);
  Sk:=PriorityQueue.Clone;
  CheckEquals(Sk.Size,100);
  Check(PriorityQueue.IsEquals(sk));

end;

procedure TTest_PriorityQueue.testPriorityQueue2;
var
  PriorityQueue : IStrPriorityQueue;
begin
  PriorityQueue:=TStrPriorityQueue.Create(self.SelfCompareFunction);
  Check( PriorityQueue.IsEmpty);
  PriorityQueue:=TStrPriorityQueue.Create(self.SelfCompareFunction);
  PriorityQueue.Push('c');
  PriorityQueue.Push('g');
  PriorityQueue.Push('E');
  PriorityQueue.Push('a');
  PriorityQueue.Push('B');
  CheckEquals( PriorityQueue.Size,5);
  PriorityQueue.Pop();
  CheckEquals( PriorityQueue.Top,'B');
  PriorityQueue.Pop();
  CheckEquals( PriorityQueue.Top,'c');
  PriorityQueue.Pop();
  CheckEquals( PriorityQueue.Top,'E');
  PriorityQueue.Pop();
  CheckEquals( PriorityQueue.Top,'g');
  CheckEquals( PriorityQueue.Size,1);
  PriorityQueue.Clear();
  CheckEquals( PriorityQueue.Size,0);

  PriorityQueue.Push('1');
  CheckEquals(PriorityQueue.Top,'1');
  PriorityQueue.Push('4');
  PriorityQueue.Push('3');
  CheckEquals(PriorityQueue.Top,'1');
  CheckEquals(PriorityQueue.Size,3);

  PriorityQueue.Pop();
  CheckEquals(PriorityQueue.Top,'3');
  PriorityQueue.Pop();
  CheckEquals(PriorityQueue.Top,'4');
  PriorityQueue.Pop();
  CheckEquals(PriorityQueue.size,0);

  PriorityQueue.Push('3');
  PriorityQueue.Clear();
  CheckEquals(PriorityQueue.size,0);
end;

initialization
  RegisterTest(TTest_PriorityQueue.Suite);
end.
