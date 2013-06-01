(*
 * Copyright (c) 2004
 * HouSisong@gmail.com
 *
 * This material is provided "as is", with absolutely no warranty expressed
 * or implied. Any use is at your own risk.
 *
 * Permission to use or copy this software for any purpose is hereby granted
 * without fee, provided the above notices are retained on all copies.
 * Permission to modify the code and to distribute modified code is granted,
 * provided the above notices are retained, and a notice that the code was
 * modified is included with the above copyright notice.
 *
 *)

//------------------------------------------------------------------------------
// 具现化的Int64类型的声明
// Create by HouSisong, 2004.11.30
//------------------------------------------------------------------------------

unit DGL_Int64;

interface
uses
  SysUtils;
{$I DGLCfg.inc_h}
type
  _ValueType   = int64;

const
  _NULL_Value:int64=0;
  function _HashValue(const Key: _ValueType):Cardinal;{$ifdef _DGL_Inline} inline; {$endif}//Hash函数

{$I DGL.inc_h}

type
  TInt64Algorithms       = _TAlgorithms;

  IInt64Iterator         = _IIterator;
  IInt64Container        = _IContainer;
  IInt64SerialContainer  = _ISerialContainer;
  IInt64Vector           = _IVector;
  IInt64List             = _IList;
  IInt64Deque            = _IDeque;
  IInt64Stack            = _IStack;
  IInt64Queue            = _IQueue;
  IInt64PriorityQueue    = _IPriorityQueue;
  IInt64Set              = _ISet;
  IInt64MultiSet         = _IMultiSet;

  TInt64Vector           = _TVector;
  TInt64Deque            = _TDeque;
  TInt64List             = _TList;
  IInt64VectorIterator   = _IVectorIterator; //速度比_IIterator稍快一点:)
  IInt64DequeIterator    = _IDequeIterator;  //速度比_IIterator稍快一点:)
  IInt64ListIterator     = _IListIterator;   //速度比_IIterator稍快一点:)
  TInt64Stack            = _TStack;
  TInt64Queue            = _TQueue;
  TInt64PriorityQueue    = _TPriorityQueue;

  //

  IInt64MapIterator  = _IMapIterator;
  IInt64Map          = _IMap;
  IInt64MultiMap     = _IMultiMap;

  TInt64Set           = _TSet;
  TInt64MultiSet      = _TMultiSet;
  TInt64Map           = _TMap;
  TInt64MultiMap      = _TMultiMap;
  TInt64HashSet       = _THashSet;
  TInt64HashMultiSet  = _THashMultiSet;
  TInt64HashMap       = _THashMap;
  TInt64HashMultiMap  = _THashMultiMap;

implementation
uses
  HashFunctions;

function _HashValue(const Key :_ValueType):Cardinal; overload;
begin
  result:=HashValue_Int64(Key);
end;

{$I DGL.inc_pas}

end.

