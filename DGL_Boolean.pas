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
// 具现化的Boolean类型的声明
// Create by HouSisong, 2004.09.29
//------------------------------------------------------------------------------

unit DGL_Boolean;

interface
uses
  SysUtils;
{$I DGLCfg.inc_h}
type
  _ValueType   = boolean;
  {$define _DGL_NotHashFunction}

const
  _NULL_Value:boolean=false;

{$I DGL.inc_h}

type
  TBoolAlgorithms       = _TAlgorithms;

  IBoolIterator         = _IIterator;
  IBoolContainer        = _IContainer;
  IBoolSerialContainer  = _ISerialContainer;
  IBoolVector           = _IVector;
  IBoolList             = _IList;
  IBoolDeque            = _IDeque;
  IBoolStack            = _IStack;
  IBoolQueue            = _IQueue;
  IBoolPriorityQueue    = _IPriorityQueue;
  IBoolSet              = _ISet;
  IBoolMultiSet         = _IMultiSet;

  TBoolVector           = _TVector;
  TBoolDeque            = _TDeque;
  TBoolList             = _TList;
  IBoolVectorIterator   = _IVectorIterator; //速度比_IIterator稍快一点:)
  IBoolDequeIterator    = _IDequeIterator;  //速度比_IIterator稍快一点:)
  IBoolListIterator     = _IListIterator;   //速度比_IIterator稍快一点:)
  TBoolStack            = _TStack;
  TBoolQueue            = _TQueue;
  TBoolPriorityQueue    = _TPriorityQueue;


  IBoolMapIterator  = _IMapIterator;
  IBoolMap          = _IMap;
  IBoolMultiMap     = _IMultiMap;

  TBoolSet           = _TSet;
  TBoolMultiSet      = _TMultiSet;
  TBoolMap           = _TMap;
  TBoolMultiMap      = _TMultiMap;
  TBoolHashSet       = _THashSet;
  TBoolHashMultiSet  = _THashMultiSet;
  TBoolHashMap       = _THashMap;
  TBoolHashMultiMap  = _THashMultiMap;

implementation

{$I DGL.inc_pas}

end.

