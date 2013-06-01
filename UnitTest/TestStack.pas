unit TestStack;

interface
uses
  Classes, SysUtils,
  TestFramework,
  TestExtensions,
  DGL_Pointer,DGL_String,DGL_Interface,
  _DGL_Object,_DGL_Point;

type

  TTest_Stack = class(TTestCase)
  public
    procedure Setup; override;
    procedure TearDown; override;
  published
    procedure testStack();
  end;
implementation

{ TTest_Stack }

procedure TTest_Stack.Setup;
begin
  inherited;

end;

procedure TTest_Stack.TearDown;
begin
  inherited;

end;

procedure TTest_Stack.testStack;
var
  Stack : IStrStack;
  sk : IStrStack;
  i : integer;
begin
  Stack:=TStrStack.Create();
  Check( Stack.IsEmpty);
  Stack:=TStrStack.Create(5,'123');
  CheckEquals( Stack.Size,5);

  Stack.Clear();
  Stack.Push('1');
  CheckEquals(Stack.Top,'1');
  Stack.Push('2');
  CheckEquals(Stack.Top,'2');
  CheckEquals(Stack.Size,2);
  Stack.Pop();
  CheckEquals(Stack.Top,'1');
  Stack.Pop();
  CheckEquals(Stack.size,0);

  Stack.Push('3');
  Stack.Clear();
  CheckEquals(Stack.size,0);

  Stack.Clear() ;
  for i:=0 to 100-1 do
    Stack.Push(inttostr(i));
  Check(not Stack.IsEmpty);
  Sk:=Stack.Clone;
  CheckEquals(Sk.Size,100);
  Check(Stack.IsEquals(sk));

end;

initialization
  RegisterTest(TTest_Stack.Suite);
end.
