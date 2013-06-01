unit TestAlgorithms;

interface
uses
  Classes, SysUtils,
  TestFramework,
  TestExtensions,
  DGL_Pointer,DGL_Integer,DGL_String,DGL_Interface,
  _DGL_Object,_DGL_Point;

type

  TTest_Algorithms = class(TTestCase)
  private
    FSumCount : integer;
    FFindIfValue : integer;
    procedure SumCount(const x:integer);
    function  FindIf1b(const x:integer):boolean;
    function  FindIf2b(const x0,x1:integer):boolean;
    function  Search2b(const x0,x1:integer):boolean;
    function  Less(const x0,x1:integer):boolean;
    function  great(const x0,x1:integer):boolean;
    function  TansfromAdd1(const x:integer):integer;
    function TansfromAdd(const x0, x1: integer): integer;
    function Get10(): integer;
    function RandomGenerate(const Range: Integer): integer;
  public
    procedure Setup; override;
    procedure TearDown; override;
  published
    procedure testAlgorithms0();
    procedure testAlgorithms1();
    procedure testAlgorithms2();
    procedure testAlgorithms3();
    procedure testAlgorithms4();
    procedure testAlgorithms5();
  end;
implementation


{ TTest_Algorithms }

function TTest_Algorithms.FindIf1b(const x: integer): boolean;
begin
  result:=(x=FFindIfValue);
end;

function TTest_Algorithms.FindIf2b(const x0, x1: integer): boolean;
begin
  result:=(FFindIfValue=x0*x1);
end;

function TTest_Algorithms.Less(const x0, x1: integer): boolean;
begin
  result:=(x0<x1);
end;

function TTest_Algorithms.Search2b(const x0, x1: integer): boolean;
begin
  result:=(x0=x1);
end;

procedure TTest_Algorithms.Setup;
begin
  inherited;

end;

procedure TTest_Algorithms.SumCount(const x: integer);
begin
  inc(FSumCount,x);
end;

function TTest_Algorithms.TansfromAdd1(const x: integer): integer;
begin
  result:=x+1;
end;

function gpTansfromAdd1(const x: integer): integer;
begin
  result:=x+1;
end;

function TTest_Algorithms.TansfromAdd(const x0,x1: integer): integer;
begin
  result:=x0+x1;
end;

function gpTansfromAdd(const x0,x1: integer): integer;
begin
  result:=x0+x1;
end;

function gpRandomGenerate(const Range: Integer):integer;
 //0<=result<Range
begin
  result:=abs(Random(Range*1242341)*123567 mod Range);
end;

function TTest_Algorithms.RandomGenerate(const Range: Integer):integer;
 //0<=result<Range
begin
  result:=abs(Random(Range*1242341)*123567 mod Range);
end;


procedure TTest_Algorithms.TearDown;
begin
  inherited;

end;

var
  gSumCount : integer;
  procedure gpSumCount(const x:integer);
  begin
    inc(gSumCount,x);
  end;

var
  gFindIfValue:integer;
  function gpFindIf1b(const x:integer):boolean;
  begin
    result:=(gFindIfValue=x);
  end;
  function gpFindIf2b(const x0,x1:integer):boolean;
  begin
    result:=(gFindIfValue=x0*x1);
  end;


procedure TTest_Algorithms.testAlgorithms0;
const
  num = 50;
var
  IntVector : IIntVector;
  IntVector1 : IIntVector;
  it,it1 :IIntIterator;
  i: integer;
begin
  //test Distance\IsEquals\ForEach\Find

  IntVector :=TIntVector.Create();
  for i:=0 to num-1 do
    IntVector.PushBack(i);


  //Distance
  CheckEquals(IntVector.Size(),
    TIntAlgorithms.Distance(IntVector.ItBegin,IntVector.ItEnd));

  //IsEquals
  IntVector1:=IIntVector(IntVector.Clone());
  CheckEquals(true,TIntAlgorithms.IsEquals(IntVector.ItBegin,IntVector.ItEnd,IntVector1.ItBegin,IntVector1.ItEnd));
  IntVector1.Items[2]:=7;
  CheckEquals(false,TIntAlgorithms.IsEquals(IntVector.ItBegin,IntVector.ItEnd,IntVector1.ItBegin,IntVector1.ItEnd));
  IntVector1:=nil;

  //ForEach
  FSumCount:=0;
  TIntAlgorithms.ForEach(IntVector.ItBegin,IntVector.ItEnd,self.SumCount);
  CheckEquals(FSumCount,(0+(num-1))*num div 2);
  gSumCount:=0;
  TIntAlgorithms.ForEach(IntVector.ItBegin,IntVector.ItEnd,gpSumCount);
  CheckEquals(gSumCount,(0+(num-1))*num div 2);

  //Find
  it:=TIntAlgorithms.Find(IntVector.ItBegin,IntVector.ItEnd,3);
  CheckEquals(it.Value,3);
  it:=TIntAlgorithms.Find(IntVector.ItBegin,IntVector.ItEnd,-1);
  CheckEquals(true,it.IsEqual(IntVector.ItEnd));

  //FindIf 1b
  self.FFindIfValue:=7;
  it:=TIntAlgorithms.FindIf(IntVector.ItBegin,IntVector.ItEnd,self.FindIf1b);
  CheckEquals(it.Value,FFindIfValue);
  gFindIfValue:=7;
  it:=TIntAlgorithms.FindIf(IntVector.ItBegin,IntVector.ItEnd,gpFindIf1b);
  CheckEquals(it.Value,gFindIfValue);

  //FindIf 2b
  self.FFindIfValue:=30;
  it:=TIntAlgorithms.FindIf(IntVector.ItBegin,IntVector.ItEnd,6,self.FindIf2b);
  CheckEquals(it.Value*6,FFindIfValue);
  gFindIfValue:=28;
  it:=TIntAlgorithms.FindIf(IntVector.ItBegin,IntVector.ItEnd,7,gpFindIf2b);
  CheckEquals(it.Value*7,gFindIfValue);
end;

    function  gpSearch2b(const x0,x1:integer):boolean;
    begin
      result:=(x0=x1);
    end;

    function gpLess(const x0, x1: integer): boolean;
    begin
      result:=(x0<x1);
    end;


procedure TTest_Algorithms.testAlgorithms1;
const
  num = 100;
var
  IntVector : IIntVector;
  IntVector1 : IIntVector;
  it,it1 :IIntIterator;
  i,j: integer;
begin
  //test Count\Search\MinElement\MaxElement

  IntVector :=TIntVector.Create();
  for i:=0 to num-1 do
    for j:=0 to i-1 do
      IntVector.PushBack(i);
  TIntAlgorithms.RandomShuffle(IntVector.ItBegin,IntVector.ItEnd);

  //Count
  CheckEquals(7,TIntAlgorithms.Count(IntVector.ItBegin,IntVector.ItEnd,7));
  CheckEquals(2,TIntAlgorithms.Count(IntVector.ItBegin,IntVector.ItEnd,2));

  //CountIf
  FFindIfValue:=5;
  CheckEquals(5,TIntAlgorithms.CountIf(IntVector.ItBegin,IntVector.ItEnd,self.FindIf1b));
  gFindIfValue:=9;
  CheckEquals(9,TIntAlgorithms.CountIf(IntVector.ItBegin,IntVector.ItEnd,gpFindIf1b));

  //Search
  IntVector.Clear();
  for i:=0 to num-1 do
      IntVector.PushBack(i);
  IntVector1 :=TIntVector.Create(IntVector.ItBegin.Clone(5),IntVector.ItBegin.Clone(10));
  it:=TIntAlgorithms.Search(IntVector.ItBegin,IntVector.ItEnd,IntVector1.ItBegin,IntVector1.ItEnd);
  CheckEquals(5,it.Value);
  CheckEquals(true,TIntAlgorithms.IsEquals(IntVector1.ItBegin,IntVector1.ItEnd,it,it.Clone(IntVector1.Size)));
  IntVector1.Items[2]:=-1;
  it:=TIntAlgorithms.Search(IntVector.ItBegin,IntVector.ItEnd,IntVector1.ItBegin,IntVector1.ItEnd);
  CheckEquals(true,it.IsEqual(IntVector.ItEnd));

  //Search if
  IntVector.Clear();
  for i:=0 to num-1 do
      IntVector.PushBack(i);
  IntVector1 :=TIntVector.Create(IntVector.ItBegin.Clone(7),IntVector.ItBegin.Clone(9));
  it:=TIntAlgorithms.Search(IntVector.ItBegin,IntVector.ItEnd,IntVector1.ItBegin,IntVector1.ItEnd,self.Search2b);
  CheckEquals(7,it.Value);
  IntVector1 :=TIntVector.Create(IntVector.ItBegin.Clone(2),IntVector.ItBegin.Clone(6));
  it:=TIntAlgorithms.Search(IntVector.ItBegin,IntVector.ItEnd,IntVector1.ItBegin,IntVector1.ItEnd,gpSearch2b);
  CheckEquals(2,it.Value);

  //MinElement
  TIntAlgorithms.RandomShuffle(IntVector.ItBegin,IntVector.ItEnd);
  it:=TIntAlgorithms.MinElement(IntVector.ItBegin,IntVector.ItEnd);
  CheckEquals(0,it.Value);
  it:=TIntAlgorithms.MaxElement(IntVector.ItBegin,IntVector.ItEnd);
  CheckEquals(num-1,it.Value);
  it:=TIntAlgorithms.MinElement(IntVector.ItBegin,IntVector.ItEnd,self.Less);
  CheckEquals(0,it.Value);
  it:=TIntAlgorithms.MaxElement(IntVector.ItBegin,IntVector.ItEnd,self.Less);
  CheckEquals(num-1,it.Value);
  it:=TIntAlgorithms.MinElement(IntVector.ItBegin,IntVector.ItEnd,gpLess);
  CheckEquals(0,it.Value);
  it:=TIntAlgorithms.MaxElement(IntVector.ItBegin,IntVector.ItEnd,gpLess);
  CheckEquals(num-1,it.Value);


end;

procedure TTest_Algorithms.testAlgorithms2;
const
  num = 100;
var
  IntVector : IIntVector;
  IntVector1,IntVector2 : IIntVector;
  it,it1 :IIntIterator;
  i,j: integer;
begin
  //test SwapValue\Copy\Tansfrom\SwapRanges

  IntVector :=TIntVector.Create();
  for i:=0 to num-1 do
      IntVector.PushBack(i);

  //SwapValue
  TIntAlgorithms.SwapValue(IntVector.ItBegin.Clone(3),IntVector.ItBegin.Clone(7));
  CheckEquals(7,IntVector.Items[3]);
  CheckEquals(3,IntVector.Items[7]);
  TIntAlgorithms.SwapValue(IntVector.ItBegin,3,IntVector.ItBegin,7);
  CheckEquals(3,IntVector.Items[3]);
  CheckEquals(7,IntVector.Items[7]);
  
  //Copy
  TIntAlgorithms.RandomShuffle(IntVector.ItBegin,IntVector.ItEnd);
  IntVector1 :=TIntVector.Create(IntVector.Size);
  TIntAlgorithms.Copy(IntVector.ItBegin,IntVector.ItEnd,IntVector1.ItBegin);
  CheckEquals(True,TIntAlgorithms.IsEquals(IntVector.ItBegin,IntVector.ItEnd,IntVector1.ItBegin,IntVector1.ItEnd));

  //Tansfrom
  IntVector :=TIntVector.Create();
  for i:=0 to num-1 do
      IntVector.PushBack(i);
  TIntAlgorithms.Tansfrom(IntVector.ItBegin,IntVector.ItEnd,self.TansfromAdd1);
  FSumCount:=0;
  TIntAlgorithms.ForEach(IntVector.ItBegin,IntVector.ItEnd,self.SumCount);
  CheckEquals(FSumCount-num,(0+(num-1))*num div 2);
  TIntAlgorithms.Tansfrom(IntVector.ItBegin,IntVector.ItEnd,gpTansfromAdd1);
  FSumCount:=0;
  TIntAlgorithms.ForEach(IntVector.ItBegin,IntVector.ItEnd,self.SumCount);
  CheckEquals(FSumCount-num*2,(0+(num-1))*num div 2);
 
  //Tansfrom to
  IntVector :=TIntVector.Create();
  for i:=0 to num-1 do
      IntVector.PushBack(i);
  IntVector1 :=TIntVector.Create(IntVector.Size);
  TIntAlgorithms.Tansfrom(IntVector.ItBegin,IntVector.ItEnd,IntVector1.ItBegin,self.TansfromAdd1);
  FSumCount:=0;
  TIntAlgorithms.ForEach(IntVector1.ItBegin,IntVector1.ItEnd,self.SumCount);
  CheckEquals(FSumCount-num,(0+(num-1))*num div 2);
  TIntAlgorithms.Tansfrom(IntVector.ItBegin,IntVector.ItEnd,IntVector1.ItBegin,gpTansfromAdd1);
  FSumCount:=0;
  TIntAlgorithms.ForEach(IntVector1.ItBegin,IntVector1.ItEnd,self.SumCount);
  CheckEquals(FSumCount-num,(0+(num-1))*num div 2);

  //Tansfrom 2 to 1
  IntVector :=TIntVector.Create();
  for i:=0 to num-1 do
      IntVector.PushBack(i);
  IntVector1 :=TIntVector.Create(IntVector.ItBegin,IntVector.ItEnd);
  TIntAlgorithms.Tansfrom(IntVector1.ItBegin,IntVector1.ItEnd,self.TansfromAdd1);
  IntVector2:=TIntVector.Create(IntVector.Size);

  TIntAlgorithms.Tansfrom(IntVector.ItBegin,IntVector.ItEnd,IntVector1.ItBegin,IntVector2.ItBegin,self.TansfromAdd);
  FSumCount:=0;
  TIntAlgorithms.ForEach(IntVector2.ItBegin,IntVector2.ItEnd,self.SumCount);
  CheckEquals((FSumCount-num) div 2,(0+(num-1))*num div 2);
  TIntAlgorithms.Tansfrom(IntVector1.ItBegin,IntVector1.ItEnd,IntVector1.ItBegin,IntVector2.ItBegin,gpTansfromAdd);
  FSumCount:=0;
  TIntAlgorithms.ForEach(IntVector2.ItBegin,IntVector2.ItEnd,self.SumCount);
  CheckEquals((FSumCount-num*2) div 2,(0+(num-1))*num div 2);


  //SwapRanges
  IntVector :=TIntVector.Create();
  for i:=0 to num-1 do
      IntVector.PushBack(i);
  IntVector1 :=TIntVector.Create(IntVector.ItBegin,IntVector.ItEnd);
  TIntAlgorithms.Tansfrom(IntVector1.ItBegin,IntVector1.ItEnd,self.TansfromAdd1);
  TIntAlgorithms.SwapRanges(IntVector.ItBegin,IntVector.ItEnd,IntVector1.ItBegin);
  FSumCount:=0;
  TIntAlgorithms.ForEach(IntVector.ItBegin,IntVector.ItEnd,self.SumCount);
  CheckEquals((FSumCount-num),(0+(num-1))*num div 2);
   //}
end;

function TTest_Algorithms.Get10():integer;
begin
  result:=10;
end;

function gpGet11():integer;
begin
  result:=11;
end;

procedure TTest_Algorithms.testAlgorithms3;
const
  num = 100;
var
  IntVector : IIntVector;
  IntVector1,IntVector2 : IIntVector;
  it,it1 :IIntIterator;
  i,j: integer;
begin
  //test Replace\Fill\Generate\Remove

  //Replace
  IntVector :=TIntVector.Create();
  for i:=0 to num-1 do
      IntVector.PushBack(i mod 10);
  CheckEquals(num div 10,TIntAlgorithms.Count(IntVector.ItBegin,IntVector.ItEnd,3));
  TIntAlgorithms.Replace(IntVector.ItBegin,IntVector.ItEnd,3,5);
  CheckEquals(0,TIntAlgorithms.Count(IntVector.ItBegin,IntVector.ItEnd,3));
  CheckEquals((num div 10)*2,TIntAlgorithms.Count(IntVector.ItBegin,IntVector.ItEnd,5));

  //Replace if
  IntVector :=TIntVector.Create();
  for i:=0 to num-1 do
      IntVector.PushBack(i mod 10);
  FFindIfValue:=5;
  TIntAlgorithms.ReplaceIf(IntVector.ItBegin,IntVector.ItEnd,self.FindIf1b,7);
  CheckEquals(0,TIntAlgorithms.Count(IntVector.ItBegin,IntVector.ItEnd,5));
  CheckEquals((num div 10)*2,TIntAlgorithms.Count(IntVector.ItBegin,IntVector.ItEnd,7));
  IntVector :=TIntVector.Create();
  for i:=0 to num-1 do
      IntVector.PushBack(i mod 10);
  gFindIfValue:=9;
  TIntAlgorithms.ReplaceIf(IntVector.ItBegin,IntVector.ItEnd,gpFindIf1b,7);
  CheckEquals(0,TIntAlgorithms.Count(IntVector.ItBegin,IntVector.ItEnd,9));
  CheckEquals((num div 10)*2,TIntAlgorithms.Count(IntVector.ItBegin,IntVector.ItEnd,7));

  //Fill
  IntVector :=TIntVector.Create(num);
  TIntAlgorithms.Fill(IntVector.ItBegin,IntVector.ItEnd,5);
  FSumCount:=0;
  TIntAlgorithms.ForEach(IntVector.ItBegin,IntVector.ItEnd,self.SumCount);
  CheckEquals(FSumCount,(num*5));
  TIntAlgorithms.Fill(IntVector.ItBegin,num,7);
  FSumCount:=0;
  TIntAlgorithms.ForEach(IntVector.ItBegin,IntVector.ItEnd,self.SumCount);
  CheckEquals(FSumCount,(num*7));

  //Generate
  IntVector :=TIntVector.Create(num);
  TIntAlgorithms.Generate(IntVector.ItBegin,IntVector.ItEnd,self.Get10);
  FSumCount:=0;
  TIntAlgorithms.ForEach(IntVector.ItBegin,IntVector.ItEnd,self.SumCount);
  CheckEquals(FSumCount,(num*10));
  TIntAlgorithms.Generate(IntVector.ItBegin,IntVector.ItEnd,gpGet11);
  FSumCount:=0;
  TIntAlgorithms.ForEach(IntVector.ItBegin,IntVector.ItEnd,self.SumCount);
  CheckEquals(FSumCount,(num*11));
  TIntAlgorithms.Generate(IntVector.ItBegin,num,self.Get10);
  FSumCount:=0;
  TIntAlgorithms.ForEach(IntVector.ItBegin,IntVector.ItEnd,self.SumCount);
  CheckEquals(FSumCount,(num*10));
  TIntAlgorithms.Generate(IntVector.ItBegin,num,gpGet11);
  FSumCount:=0;
  TIntAlgorithms.ForEach(IntVector.ItBegin,IntVector.ItEnd,self.SumCount);
  CheckEquals(FSumCount,(num*11));

  //Remove
  IntVector :=TIntVector.Create();
  for i:=0 to num-1 do
      IntVector.PushBack(i mod 4);
  TIntAlgorithms.RandomShuffle(IntVector.ItBegin,IntVector.ItEnd);
  it:=TIntAlgorithms.Remove(IntVector.ItBegin,IntVector.ItEnd,2);
  FSumCount:=0;
  TIntAlgorithms.ForEach(IntVector.ItBegin,It,self.SumCount);
  CheckEquals(FSumCount,(num div 4)*(1+3));
  CheckEquals(num,IntVector.Size);

  //Remove if
  IntVector :=TIntVector.Create();
  for i:=0 to num-1 do
      IntVector.PushBack(i mod 10);
  TIntAlgorithms.RandomShuffle(IntVector.ItBegin,IntVector.ItEnd);
  FFindIfValue:=3;
  it:=TIntAlgorithms.RemoveIf(IntVector.ItBegin,IntVector.ItEnd,self.FindIf1b);
  gFindIfValue:=8;
  it:=TIntAlgorithms.RemoveIf(IntVector.ItBegin,it,gpFindIf1b);
  FSumCount:=0;
  TIntAlgorithms.ForEach(IntVector.ItBegin,It,self.SumCount);
  CheckEquals(FSumCount,(num div 10)*(1+2+4+5+6+7+9));
  CheckEquals(num,IntVector.Size);

end;


var
  datas : array [0..9] of integer=(9,8,7,6,5,4,3,2,1,0);

procedure TTest_Algorithms.testAlgorithms4;
const
  num = 100;
var
  IntVector : IIntVector;
  IntVector1,IntVector2 : IIntVector;
  it,it1 :IIntIterator;
  i,j: integer;
begin
  //test: Reverse\RandomShuffle\Sort\IsSorted

  //Reverse
  IntVector :=TIntVector.Create();
  for i:=0 to num-1 do
      IntVector.PushBack(i);
  TIntAlgorithms.Reverse(IntVector.ItBegin,IntVector.ItEnd);
  for i:=0 to num-1 do
    CheckEquals(num-1-i,IntVector.Items[i]);

  //RandomShuffle
  TIntAlgorithms.RandomShuffle(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)));
  TIntAlgorithms.Sort(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)));
  TIntAlgorithms.RandomShuffle(DGL_integer.PointerBox(@datas[0]),
    DGL_integer.PointerBox(@datas[0],length(datas)),self.RandomGenerate);
  TIntAlgorithms.Sort(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)));
  TIntAlgorithms.RandomShuffle(DGL_integer.PointerBox(@datas[0]),
    DGL_integer.PointerBox(@datas[0],length(datas)),gpRandomGenerate);

  
  //Sort , IsSorted
  TIntAlgorithms.RandomShuffle(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)));
  TIntAlgorithms.Sort(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)));
  //TIntAlgorithms.Sort(@datas[0],@DGL_integer._PValueType_Iterator(@datas[0])[length(datas)]);
  CheckEquals(true,TIntAlgorithms.IsSorted(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas))));
   TIntAlgorithms.RandomShuffle(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)));
  TIntAlgorithms.Sort(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)),self.great);
  CheckEquals(true,TIntAlgorithms.IsSorted(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)),self.great));
  CheckEquals(false,TIntAlgorithms.IsSorted(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)),gpLess));
  TIntAlgorithms.RandomShuffle(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)));
  TIntAlgorithms.Sort(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)),gpLess);
  CheckEquals(true,TIntAlgorithms.IsSorted(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)),gpLess));
  
  //SortHeap ...
  TIntAlgorithms.RandomShuffle(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)));
  TIntAlgorithms.SortHeap(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)));
  CheckEquals(true,TIntAlgorithms.IsSorted(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas))));
  TIntAlgorithms.RandomShuffle(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)));
  TIntAlgorithms.SortHeap(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)),self.great);
  CheckEquals(true,TIntAlgorithms.IsSorted(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)),self.great));
  CheckEquals(false,TIntAlgorithms.IsSorted(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)),gpLess));
  TIntAlgorithms.RandomShuffle(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)));
  TIntAlgorithms.SortHeap(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)),gpLess);
  CheckEquals(true,TIntAlgorithms.IsSorted(DGL_integer.PointerBox(@datas[0]),DGL_integer.PointerBox(@datas[0],length(datas)),gpLess));

    //}
end;

function TTest_Algorithms.great(const x0, x1: integer): boolean;
begin
  result:=x0>x1;
end;

procedure TTest_Algorithms.testAlgorithms5;
const
  num = 100;
var
  IntVector : IIntVector;
  IntVector1,IntVector2 : IIntVector;
  it,it1 :IIntIterator;
  i,j: integer;
begin
  //test: BinarySearch\LowerBound

  //BinarySearch
  IntVector :=TIntVector.Create();
  for i:=0 to num-1 do
    for j:=0 to 10-1 do
      IntVector.PushBack(i);
  CheckEquals(true,TIntAlgorithms.IsSorted(IntVector.ItBegin,IntVector.ItEnd));
  it:=TIntAlgorithms.BinarySearch(IntVector.ItBegin,IntVector.ItEnd,17,gpLess);
  CheckEquals(17,it.Value);
  it:=TIntAlgorithms.BinarySearch(IntVector.ItBegin,IntVector.ItEnd,num+1);
  CheckEquals(true,it.IsEqual(IntVector.ItEnd));

  //BinarySearch .
  TIntAlgorithms.Sort(IntVector.ItBegin,IntVector.ItEnd,self.great);
  it:=TIntAlgorithms.BinarySearch(IntVector.ItBegin,IntVector.ItEnd,21,self.great);
  CheckEquals(21,it.Value);
  IntVector.EraseValue(21);
  it:=TIntAlgorithms.BinarySearch(IntVector.ItBegin,IntVector.ItEnd,21,self.great);
  CheckEquals(true,it.IsEqual(IntVector.ItEnd));
  it:=TIntAlgorithms.BinarySearch(IntVector.ItBegin,IntVector.ItEnd,num+1,self.great);
  CheckEquals(true,it.IsEqual(IntVector.ItEnd));

  //LowerBound
  IntVector :=TIntVector.Create();
  for i:=0 to num-1 do
    for j:=0 to 10-1 do
      IntVector.PushBack(i);
  TIntAlgorithms.Sort(IntVector.ItBegin,IntVector.ItEnd);
  it:=TIntAlgorithms.LowerBound(IntVector.ItBegin,IntVector.ItEnd,35);
  CheckEquals(35,it.Value);
  CheckEquals(35,it.Clone(10-1).Value);
  CheckEquals(34,it.Clone(-1).Value);
  CheckEquals(36,it.Clone(10).Value);
  IntVector.EraseValue(35);
  it:=TIntAlgorithms.LowerBound(IntVector.ItBegin,IntVector.ItEnd,35,self.Less);
  CheckEquals(36,it.Value);
  CheckEquals(36,it.Clone(10-1).Value);
  CheckEquals(34,it.Clone(-1).Value);
  CheckEquals(37,it.Clone(10).Value);
  it:=TIntAlgorithms.LowerBound(IntVector.ItBegin,IntVector.ItEnd,num+1);
  CheckEquals(true,it.IsEqual(IntVector.ItEnd));
  it:=TIntAlgorithms.LowerBound(IntVector.ItBegin,IntVector.ItEnd,-1,gpLess);
  CheckEquals(true,it.IsEqual(IntVector.ItBegin));

end;

initialization
  RegisterTest(TTest_Algorithms.Suite);
end.
