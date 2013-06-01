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
// 具现化的Single类型的声明
// Create by HouSisong, 2006.10.19
//------------------------------------------------------------------------------

unit DGL_Single;

interface
uses
  SysUtils;
{$I DGLCfg.inc_h} 
type
  _ValueType   = Single;

const
  _NULL_Value:Single=0;
  function _HashValue(const Key: _ValueType):Cardinal;{$ifdef _DGL_Inline} inline; {$endif}//Hash函数

{$I DGL.inc_h}

type
  TSingleAlgorithms       = _TAlgorithms;

  ISingleIterator         = _IIterator;
  ISingleContainer        = _IContainer;
  ISingleSerialContainer  = _ISerialContainer;
  ISingleVector           = _IVector;
  ISingleList             = _IList;
  ISingleDeque            = _IDeque;
  ISingleStack            = _IStack;
  ISingleQueue            = _IQueue;
  ISinglePriorityQueue    = _IPriorityQueue;
  ISingleSet              = _ISet;
  ISingleMultiSet         = _IMultiSet;

  TSingleVector           = _TVector;
  TSingleDeque            = _TDeque;
  TSingleList             = _TList;
  ISingleVectorIterator   = _IVectorIterator; //速度比_IIterator稍快一点:)
  ISingleDequeIterator    = _IDequeIterator;  //速度比_IIterator稍快一点:)
  ISingleListIterator     = _IListIterator;   //速度比_IIterator稍快一点:)
  TSingleStack            = _TStack;
  TSingleQueue            = _TQueue;
  TSinglePriorityQueue    = _TPriorityQueue;


  ISingleMapIterator  = _IMapIterator;
  ISingleMap          = _IMap;
  ISingleMultiMap     = _IMultiMap;

  TSingleSet           = _TSet;
  TSingleMultiSet      = _TMultiSet;
  TSingleMap           = _TMap;
  TSingleMultiMap      = _TMultiMap;
  TSingleHashSet       = _THashSet;
  TSingleHashMultiSet  = _THashMultiSet;
  TSingleHashMap       = _THashMap;
  TSingleHashMultiMap  = _THashMultiMap;

implementation
uses
  HashFunctions;


function _HashValue(const Key :_ValueType):Cardinal; overload;
begin
  result:=HashValue_Single(Key);
end;

{$I DGL.inc_pas}

end.







