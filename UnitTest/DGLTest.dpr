program DGLTest;

{%File '..\DGLIntf.inc_h'}
{%File '..\DGLIntf.inc_pas'}
{%File '..\PointerItBox.inc_pas'}
{%File '..\PointerItBox.inc_h'}
{%File '..\Algorithms.inc_h'}
{%File '..\Algorithms.inc_pas'}
{%File '..\Vector.inc_h'}
{%File '..\Vector.inc_pas'}
{%File '..\Deque.inc_h'}
{%File '..\Deque.inc_pas'}
{%File '..\List.inc_h'}
{%File '..\List.inc_pas'}
{%File '..\Stack.inc_h'}
{%File '..\Stack.inc_pas'}
{%File '..\Queue.inc_h'}
{%File '..\Queue.inc_pas'}
{%File '..\PriorityQueue.inc_h'}
{%File '..\PriorityQueue.inc_pas'}
{%File '..\_RB_Tree.inc_h'}
{%File '..\_RB_Tree.inc_pas'}
{%File '..\Map.inc_h'}
{%File '..\Map.inc_pas'}
{%File '..\Set.inc_h'}
{%File '..\Set.inc_pas'}
{%File '..\_HashTable.inc_h'}
{%File '..\_HashTable.inc_pas'}
{%File '..\HashSet.inc_h'}
{%File '..\HashSet.inc_pas'}
{%File '..\HashMap.inc_h'}
{%File '..\HashMap.inc_pas'}
{%File '..\DGL.inc_h'}
{%File '..\DGL.inc_pas'}

uses
  Classes,
  GUITestRunner,
  TestFramework,
  TestMap in 'TestMap.pas',
  TestSet in 'TestSet.pas',
  TestDeque in 'TestDeque.pas',
  TestList in 'TestList.pas',
  TestQueue in 'TestQueue.pas',
  TestStack in 'TestStack.pas',
  TestPriorityQueue in 'TestPriorityQueue.pas',
  TestAlgorithms in 'TestAlgorithms.pas',
  TestVector in 'TestVector.pas',
  HashFunctions in '..\HashFunctions.pas',
  _DGL_Object in '..\_DGL_Object.pas',
  _DGL_Point in '..\_DGL_Point.pas',
  _DGL_IntVectorVector in '..\_DGL_IntVectorVector.pas',
  _DGL_String_IntegerRecord in '..\_DGL_String_IntegerRecord.pas',
  DGL_TNotifyEvent in '..\DGL_TNotifyEvent.pas',
  DGL_Pointer in '..\DGL_Pointer.pas',
  DGL_Interface in '..\DGL_Interface.pas',
  DGL_String in '..\DGL_String.pas',
  DGL_Integer in '..\DGL_Integer.pas',
  DGL_Boolean in '..\DGL_Boolean.pas',
  DGL_Byte in '..\DGL_Byte.pas',
  DGL_Double in '..\DGL_Double.pas',
  DGL_Int64 in '..\DGL_Int64.pas',
  DGL_Single in '..\DGL_Single.pas',
  DGL_WideString in '..\DGL_WideString.pas',
  DGL_WideStringCaseInsensitive in '..\DGL_WideStringCaseInsensitive.pas',
  DGL_StringCaseInsensitive in '..\DGL_StringCaseInsensitive.pas',
  _DGLMap_String_Integer in '..\_DGLMap_String_Integer.pas',
  _DGLMap_StringCaseInsensitive_Integer in '..\_DGLMap_StringCaseInsensitive_Integer.pas',
  DGLMap_Integer_TNotifyEvent in '..\DGLMap_Integer_TNotifyEvent.pas',
  DGL_Word in '..\DGL_Word.pas';//,  DGL_Variant in 'DGL_Variant.pas';

{$R *.res}

begin
  TGUITestRunner.RunTest(RegisteredTests);
end.
