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
// 具现化的Integer类型的声明
// Create by HouSisong, 2004.09.14
//------------------------------------------------------------------------------

unit DGL_Integer;

interface
uses
  SysUtils;
{$I DGLCfg.inc_h} 
type
  _ValueType   = integer;
  {$define _DGL_NotHashFunction}

const
  _NULL_Value:integer=0;

{$I DGL.inc_h}

type
  TIntAlgorithms       = _TAlgorithms;

  IIntIterator         = _IIterator;
  IIntContainer        = _IContainer;
  IIntSerialContainer  = _ISerialContainer;
  IIntVector           = _IVector;
  IIntList             = _IList;
  IIntDeque            = _IDeque;
  IIntStack            = _IStack;
  IIntQueue            = _IQueue;
  IIntPriorityQueue    = _IPriorityQueue;
  IIntSet              = _ISet;
  IIntMultiSet         = _IMultiSet;

  TIntVector           = _TVector;
  TIntDeque            = _TDeque;
  TIntList             = _TList;
  IIntVectorIterator   = _IVectorIterator; //速度比_IIterator稍快一点:)
  IIntDequeIterator    = _IDequeIterator;  //速度比_IIterator稍快一点:)
  IIntListIterator     = _IListIterator;   //速度比_IIterator稍快一点:)
  TIntStack            = _TStack;
  TIntQueue            = _TQueue;
  TIntPriorityQueue    = _TPriorityQueue;

  //

  IIntMapIterator  = _IMapIterator;
  IIntMap          = _IMap;
  IIntMultiMap     = _IMultiMap;

  TIntSet           = _TSet;
  TIntMultiSet      = _TMultiSet;
  TIntMap           = _TMap;
  TIntMultiMap      = _TMultiMap;
  TIntHashSet       = _THashSet;
  TIntHashMultiSet  = _THashMultiSet;
  TIntHashMap       = _THashMap;
  TIntHashMultiMap  = _THashMultiMap;

implementation

{$I DGL.inc_pas}

end.







