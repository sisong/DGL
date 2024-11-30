unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormDGLDemo = class(TForm)
    GroupBox1: TGroupBox;
    btn_IIntVector: TButton;
    btn_TIntVector: TButton;
    btn_IIntDeque: TButton;
    btn_IPointerList: TButton;
    GroupBox2: TGroupBox;
    btn_IIntSerialContainer: TButton;
    GroupBox3: TGroupBox;
    btn_IByteIterator: TButton;
    btn_IPointerSet: TButton;
    btn_IPointerMultiSet: TButton;
    btn_IStrIntMap: TButton;
    btn_IStrMultiMap: TButton;
    btn_IIntStack: TButton;
    btn_IByteQueue: TButton;
    btn_IIntPriorityQueue: TButton;
    procedure btn_IIntVectorClick(Sender: TObject);
    procedure btn_TIntVectorClick(Sender: TObject);
    procedure btn_IIntDequeClick(Sender: TObject);
    procedure btn_IPointerListClick(Sender: TObject);
    procedure btn_IPointerSetClick(Sender: TObject);
    procedure btn_IIntSerialContainerClick(Sender: TObject);
    procedure btn_IPointerMultiSetClick(Sender: TObject);
    procedure btn_IStrIntMapClick(Sender: TObject);
    procedure btn_IStrMultiMapClick(Sender: TObject);
    procedure btn_IByteIteratorClick(Sender: TObject);
    procedure btn_IIntStackClick(Sender: TObject);
    procedure btn_IByteQueueClick(Sender: TObject);
    procedure btn_IIntPriorityQueueClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDGLDemo: TFormDGLDemo;

implementation
uses
  DGL_Pointer,DGL_Byte,DGL_Integer,_DGLMap_String_Integer,DGL_String;

{$R *.dfm}


//Demo uses IIntVector ---------------------------------------------------------
procedure TFormDGLDemo.btn_IIntVectorClick(Sender: TObject);
var
  intVector : IIntVector; //interface type ; Vector use as delphi's array;
  i,Sum : _TNativeInt;
begin
  intVector :=TIntVector.Create;

  for i:=0 to 100-1 do
    intVector.PushBack(i);
  Assert(intVector.Size()=100);

  Sum:=0;
  for i:=0 to intVector.Size()-1 do
    Sum:=Sum+intVector.Items[i];
  Assert(Sum=(0+99)*100 div 2);

  // intVector is interface type not need free;
end;


//Demo uses TIntVector ---------------------------------------------------------
procedure TFormDGLDemo.btn_TIntVectorClick(Sender: TObject);
var
  intVector : TIntVector; //class type
  i,Sum : _TNativeInt;
begin
  intVector :=TIntVector.Create;
  try
    for i:=0 to 100-1 do
      intVector.PushBack(i);
    Assert(intVector.Size()=100);

    Sum:=0;
    for i:=0 to intVector.Size()-1 do
      Sum:=Sum+intVector.Items[i];
    Assert(Sum=(0+99)*100 div 2);

  finally
    intVector.Free;  //intVector is class type;
    //use class type is maybe faster than interface type;
    //recommend priority use DGL container as interface by most time;
  end;

end;


//Demo uses IIntDeque ----------------------------------------------------------
procedure TFormDGLDemo.btn_IIntDequeClick(Sender: TObject);
var
  intDeque : IIntDeque;
  i,Sum : _TNativeInt;
begin
  intDeque :=TIntDeque.Create;

  for i:=0 to 100-1 do
    intDeque.PushBack(i);
  Assert(intDeque.Back=99);Assert(intDeque.Front=0);
  Assert(intDeque.Size()=100);

  for i:=0 to 100-1 do
    intDeque.PushFront(i); //Deque's PushFront and PushBack is the same fast;
  Assert(intDeque.Back=99);Assert(intDeque.Front=99);
  Assert(intDeque.Size()=200);

  Sum:=0;
  for i:=0 to intDeque.Size()-1 do
    Sum:=Sum+intDeque.Items[i];
  Assert(Sum=((0+99)*100 div 2)*2);
end;


//Demo uses IPointerList -------------------------------------------------------
procedure TFormDGLDemo.btn_IPointerListClick(Sender: TObject);
var
  piList : IPointerList;
  it : IPointerIterator;
  i,Sum : _TNativeInt;
begin
  piList :=TPointerList.Create;

  for i:=0 to 100-1 do
    piList.PushBack(Pointer(i));
  for i:=0 to 100-1 do
    piList.PushFront(Pointer(i));

  it:=piList.ItBegin.Clone(100); //it is pointer to piList's middle;
  for i:=0 to 100-1 do
    piList.Insert(it,Pointer(i));
  //List's PushFront and PushBack and insert at any pos is the same fast;
  Assert(piList.Size()=300);

  Sum:=0;
  it:=piList.ItBegin; //it is pointer to piList's first;
  for i:=0 to piList.Size()-1 do
  begin
    Sum:=Sum+_TNativeInt(it.Value);
    it.Next;
  end;
  Assert(it.IsEqual(piList.ItEnd));
  Assert(Sum=((0+99)*100 div 2)*3);
end;


//Demo uses IIntSerialContainer ------------------------------------------------
procedure TFormDGLDemo.btn_IIntSerialContainerClick(Sender: TObject);
  procedure SetVaues(const Container:IByteSerialContainer);
  var
    i : _TNativeInt;
  begin
    for i:=0 to 100-1 do
      Container.PushBack(i);
  end;

  procedure CheckSum(const Container:IByteSerialContainer);
  var
    it : IByteIterator;
    Sum : _TNativeInt;
  begin
    it:=Container.ItBegin;
    Sum :=0;
    while (not it.IsEqual(Container.ItEnd)) do
    begin
      sum:=sum+it.Value;
      it.Next;
    end;
    Assert(Sum=(0+99)*100 div 2);
  end;

var
  BVector : IByteVector;
  BDeque  : IByteDeque;
  BList   : IByteList;
  it: IByteIterator;
begin
  BVector :=TByteVector.Create;
  BDeque  :=TByteDeque.Create;
  BList   :=TByteList.Create;

  SetVaues(BVector);
  CheckSum(BVector);
  SetVaues(BDeque);
  CheckSum(BDeque);
  SetVaues(BList);
  CheckSum(BList);
end;


//Demo uses IPointerSet --------------------------------------------------------
procedure TFormDGLDemo.btn_IPointerSetClick(Sender: TObject);
var
  piSet : IPointerSet;
  it : IPointerIterator;
  i,Sum : _TNativeInt;
begin
  piSet :=TPointerHashSet.Create;

  for i:=0 to 200-1 do
    piSet.Insert(Pointer(i div 2)); //values is [0,1,..99]
  Assert(piSet.size()=100);

  Sum:=0;
  it:=piSet.ItBegin;
  for i:=0 to piSet.Size-1 do
  begin
    inc(Sum,_TNativeInt(it.Value));
    it.Next;
  end;
  Assert(Sum=((0+99)*100 div 2));

  for i:=0 to 100-1 do
  begin
    it:=piSet.Find(Pointer(i));
    Assert(not it.IsEqual(piSet.ItEnd));
    Assert(it.Value=Pointer(i));
  end;

  for i:=0 to 100-1 do
    piSet.EraseValue(Pointer(i)); //== piSet.Erase(piSet.Find(Pointer(i)));
  Assert(piSet.IsEmpty());
  Assert(piSet.Size()=0);

end;


//Demo uses IPointerMultiSet ---------------------------------------------------
procedure TFormDGLDemo.btn_IPointerMultiSetClick(Sender: TObject);
var
  piMSet : IPointerMultiSet;
  it,itt : IPointerIterator;
  i,Sum : _TNativeInt;
begin
  piMSet :=TPointerHashMultiSet.Create;

  for i:=0 to 200-1 do
    piMSet.Insert(Pointer(i div 2)); //values is [0,0,1,1..99,99]
  Assert(piMSet.size()=200);

  Sum:=0;
  it:=piMSet.ItBegin;
  for i:=0 to piMSet.Size-1 do
  begin
    inc(Sum,_TNativeInt(it.Value));
    it.Next;
  end;
  Assert(Sum=((0+99)*100 div 2)*2);

  for i:=0 to 100-1 do
  begin
    it:=piMSet.Find(Pointer(i));
    Assert(not it.IsEqual(piMSet.ItEnd));
    Assert(it.Value=Pointer(i));

    Assert(piMSet.Count(Pointer(i))=2);

    it:=piMSet.LowerBound(Pointer(i));
    Assert(it.Value=Pointer(i));
    itt:=piMSet.UpperBound(Pointer(i));
    Assert(it.Distance(itt)=2);
  end;

  Assert(piMSet.Size()=200);
  for i:=0 to 100-1 do
    piMSet.Erase(piMSet.Find(Pointer(i)));
  Assert(piMSet.Size()=100);
  for i:=0 to 100-1 do
    piMSet.Erase(piMSet.Find(Pointer(i)));
  Assert(piMSet.Size()=0);

end;

//Demo uses IStrIntMap ---------------------------------------------------------
procedure TFormDGLDemo.btn_IStrIntMapClick(Sender: TObject);
var
  StrIntMap : IStrIntMap;
  i,Sum : _TNativeInt;
  it: IStrIntMapIterator;
begin
  StrIntMap :=TStrIntHashMap.Create;
  StrIntMap.Insert('a1',1);
  StrIntMap.Insert('a2',2);
  StrIntMap.Insert('a3',3);
  Assert(StrIntMap.Items['a1']=1);
  Assert(StrIntMap.Items['a2']=2);
  Assert(StrIntMap.Items['a3']=3);


  StrIntMap.Clear();

  for i:=0 to 100 -1 do
    StrIntMap.Items[inttostr(i)]:=i*3; //== StrIntMap.Insert(inttostr(i),i*3);
  Assert(StrIntMap.size()=100);

  Sum:=0;
  for i:=0 to StrIntMap.Size-1 do
    inc(Sum,StrIntMap.Items[inttostr(i)]);
  Assert(Sum=((0+99)*100 div 2)*3);

  for i:=0 to 100-1 do
  begin
    it:=StrIntMap.Find(inttostr(i));
    Assert(not it.IsEqual(StrIntMap.ItEnd));
    Assert(it.Value=i*3);
    Assert(strToint(it.Key)=i);
  end;

  for i:=0 to 100-1 do
    StrIntMap.Erase(StrIntMap.Find(inttostr(i)));
  Assert(StrIntMap.Size()=0);
end;


//Demo uses IStrMultiMap -------------------------------------------------------
procedure TFormDGLDemo.btn_IStrMultiMapClick(Sender: TObject);
var
  StrMMap : IStrMultiMap;
  i,Sum : _TNativeInt;
  it,itt: IStrMapIterator;
begin
  StrMMap :=TStrHashMultiMap.Create;
  StrMMap.Insert('a1','1');
  StrMMap.Insert('a2','2');
  StrMMap.Insert('a3','3');
  Assert(StrMMap.Items['a1']='1');
  Assert(StrMMap.Items['a2']='2');
  Assert(StrMMap.Items['a3']='3');

  StrMMap.Insert('a1','4');
  Assert((StrMMap.Items['a1']='1') or (StrMMap.Items['a1']='4'));
  Assert(StrMMap.Count('a1')=2);
  it:=StrMMap.LowerBound('a1');
  Assert((strtoint(it.Value)+strtoint(it.NextValue[1]))=(1+4));

  /////////////////////////

  StrMMap.Clear();

  for i:=0 to 200 -1 do
    StrMMap.Items[inttostr(i div 2)]:=inttostr(i div 2); //== StrMMap.Insert(inttostr(i),inttostr(i*3));
  Assert(StrMMap.size()=200);

  Sum:=0;
  for i:=0 to StrMMap.Size-1 do
    inc(Sum,strtoint(StrMMap.Items[inttostr(i div 2)]));
  Assert(Sum=((0+99)*100 div 2)*2);

  for i:=0 to 100-1 do
  begin
    it:=StrMMap.Find(inttostr(i));
    Assert(not it.IsEqual(StrMMap.ItEnd));
    Assert(strtoint(it.Value)=i);
    Assert(strToint(it.Key)=i);

    Assert(StrMMap.Count(inttostr(i))=2);

    it:=StrMMap.LowerBound(inttostr(i));
    Assert(it.Value=inttostr(i));
    Assert(it.Key=inttostr(i));
    itt:=StrMMap.UpperBound(inttostr(i));
    Assert(it.Distance(itt)=2);
  end;

  for i:=0 to 100-1 do
    StrMMap.Erase(StrMMap.Find(inttostr(i)));
  Assert(StrMMap.Size()=100);
  for i:=0 to 100-1 do
    StrMMap.Erase(StrMMap.Find(inttostr(i)));
  Assert(StrMMap.Size()=0);

end;

//Demo uses IIntStack ----------------------------------------------------------
procedure TFormDGLDemo.btn_IIntStackClick(Sender: TObject);
var
  ist : IIntStack;
begin
  ist :=TIntStack.Create;

  ist.Push(5);   //[5]
  ist.Push(6);   //[5,6]
  ist.Push(7);   //[5,6,7]
  Assert(ist.Size()=3);
  Assert(ist.Top=7);

  ist.Pop;    //[5,6]
  Assert(ist.Top=6);
  ist.Pop;    //[5]
  Assert(ist.Top=5);
  ist.Pop;    //[]
  Assert(ist.IsEmpty());

end;

//Demo uses IByteQueue ---------------------------------------------------------
procedure TFormDGLDemo.btn_IByteQueueClick(Sender: TObject);
var
  ibq : IByteQueue;
begin
  ibq :=TByteQueue.Create;

  ibq.Push(5);  //[5]
  ibq.Push(6);  //[5,6]
  ibq.Push(7);  //[5,6,7]
  ibq.Push(8);  //[5,6,7,8]
  Assert(ibq.Size()=4);
  Assert(ibq.Front=5);
  Assert(ibq.Back=8);

  ibq.Pop;      //[6,7,8]
  Assert(ibq.Front=6);
  ibq.Pop;      //[7,8]
  Assert(ibq.Front=7);
  ibq.Pop;      //[8]
  Assert(ibq.Front=8);
  ibq.Pop;      //[]
  Assert(ibq.IsEmpty());

end;

//Demo uses IIntPriorityQueue --------------------------------------------------
procedure TFormDGLDemo.btn_IIntPriorityQueueClick(Sender: TObject);
var
  ipq : IIntPriorityQueue;
begin
  ipq :=TIntPriorityQueue.Create; //can uses as: TIntPriorityQueue.Create(aTestBinaryFunction);
                                  //  'aTestBinaryFunction' is then Priority function;

  ipq.Push(10);
  Assert(ipq.Top=10);
  ipq.Push(7);
  Assert(ipq.Top=10);
  ipq.Push(50);
  Assert(ipq.Top=50);
  ipq.Push(13);
  Assert(ipq.Top=50);
  Assert(ipq.Size()=4);

  ipq.Pop;
  Assert(ipq.Top=13);
  ipq.Pop;
  Assert(ipq.Top=10);
  ipq.Pop;
  Assert(ipq.Top=7);
  ipq.Pop;
  Assert(ipq.IsEmpty());

end;


//Demo uses IByteIterator ------------------------------------------------------
  function ValuesAsStr(const it0,it1:IByteIterator):string;
  var
    it : IByteIterator;
  begin
    result:='';
    it:=it0;
    while not it.IsEqual(it1) do
    begin
      result:=result+inttostr(it.Value)+' ';
      it.Next;
    end;
  end;
var
  AgSum : _TNativeInt;
  procedure SumAValue(const Value: Byte);
  begin
    inc(AgSum,Value);
  end;
var
  AgStr: string;
procedure TFormDGLDemo.btn_IByteIteratorClick(Sender: TObject);
var
  BContainer : IByteContainer;
  it0,it1: IByteIterator;
  i,sum : _TNativeInt;
begin
  BContainer :=TByteVector.Create(100);
  //BContainer :=TByteDeque.Create(100);
  //BContainer :=TByteList.Create(100);
  Assert(BContainer.Size()=100);

  it0:=BContainer.ItBegin();
  it1:=BContainer.ItEnd();
  while not it0.IsEqual(it1) do
  begin
    it0.Value:=_DGL_Random(256);
    it0.Next;
  end;

  it0:=BContainer.ItBegin();
  it1:=BContainer.ItEnd();
  Sum:=0;
  while not it0.IsEqual(it1) do
  begin
    inc(sum,it0.Value);
    it0.Next;
  end;

  AgSum:=0;
  TByteAlgorithms.ForEach(BContainer.ItBegin(),BContainer.ItEnd(),@SumAValue);
  Assert(AgSum=Sum);

  AgStr:=ValuesAsStr(BContainer.ItBegin(),BContainer.ItEnd());
  TByteAlgorithms.Sort(BContainer.ItBegin(),BContainer.ItEnd());
  AgStr:=ValuesAsStr(BContainer.ItBegin(),BContainer.ItEnd());
  Assert(TByteAlgorithms.IsSorted(BContainer.ItBegin(),BContainer.ItEnd()));

end;



end.
