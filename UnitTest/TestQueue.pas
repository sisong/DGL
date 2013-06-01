unit TestQueue;

interface
uses
  Classes, SysUtils,
  TestFramework,
  TestExtensions,
  DGL_Pointer,DGL_String,DGL_Interface,
  _DGL_Object,_DGL_Point;

type

  TTest_Queue = class(TTestCase)
  public
    procedure Setup; override;
    procedure TearDown; override;
  published
    procedure testQueue();
  end;
  
implementation

{ TTest_Queue }

procedure TTest_Queue.Setup;
begin
  inherited;

end;

procedure TTest_Queue.TearDown;
begin
  inherited;

end;

procedure TTest_Queue.testQueue;
var
  Queue : IStrQueue;
  sk : IStrQueue;
  i : integer;
begin
  Queue:=TStrQueue.Create();
  Check( Queue.IsEmpty);
  Queue:=TStrQueue.Create(5,'123');
  CheckEquals( Queue.Size,5);

  Queue.Clear();
  Queue.Push('1');
  CheckEquals(Queue.Back,'1');
  Queue.Push('2');
  Queue.Push('3');
  CheckEquals(Queue.Front,'1');
  CheckEquals(Queue.Back,'3');
  CheckEquals(Queue.Size,3);
  Queue.Pop();
  CheckEquals(Queue.Front,'2');
  CheckEquals(Queue.Back,'3');
  Queue.Pop();
  CheckEquals(Queue.Front,'3');
  Queue.Pop();
  CheckEquals(Queue.size,0);

  Queue.Push('3');
  Queue.Clear();
  CheckEquals(Queue.size,0);

  Queue.Clear() ;
  for i:=0 to 100-1 do
    Queue.Push(inttostr(i));
  Check(not Queue.IsEmpty);
  Sk:=Queue.Clone;
  CheckEquals(Sk.Size,100);
  Check(Queue.IsEquals(sk));

end;

initialization
  RegisterTest(TTest_Queue.Suite);
end.
