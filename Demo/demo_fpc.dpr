program demo_fpc;
//This program can uses Free Pascal compile,
//   add DGL Source path in it's directory,and set it's compiler mode is "Delphi compatible";

uses
  DGL_Integer;


procedure btn_IIntVectorClick(Sender: TObject);
var
  intVector : IIntVector; //interface type ; Vector use as delphi's array;
  i,Sum : integer;
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

begin
  btn_IIntVectorClick(nil);
end.




