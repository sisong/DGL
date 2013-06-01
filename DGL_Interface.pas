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
// 具现化的IInterface类型的声明
// Create by HouSisong, 2004.09.04
//------------------------------------------------------------------------------

unit DGL_Interface;

interface
uses
  SysUtils;

{$I DGLCfg.inc_h}

type
  _ValueType   = IInterface;
const
  _NULL_Value:_ValueType=nil;
  {$define _DGL_NotHashFunction}
  
  {$define  _DGL_Compare}
  function _IsEqual(const a,b :_ValueType):boolean;//{$ifdef _DGL_Inline} inline; {$endif} //result:=(a=b);
  function _IsLess(const a,b :_ValueType):boolean;{$ifdef _DGL_Inline} inline; {$endif}  //result:=(a<b); 默认排序准则

  {$I DGL.inc_h}

type
  TIntfAlgorithms       = _TAlgorithms;

  IIntfIterator         = _IIterator;
  IIntfContainer        = _IContainer;
  IIntfSerialContainer  = _ISerialContainer;
  IIntfVector           = _IVector;
  IIntfList             = _IList;
  IIntfDeque            = _IDeque;
  IIntfStack            = _IStack;
  IIntfQueue            = _IQueue;
  IIntfPriorityQueue    = _IPriorityQueue;
  IIntfSet              = _ISet;
  IIntfMultiSet         = _IMultiSet;

  TIntfVector           = _TVector;
  TIntfDeque            = _TDeque;
  TIntfList             = _TList;
  IIntfVectorIterator   = _IVectorIterator; //速度比_IIterator稍快一点:)
  IIntfDequeIterator    = _IDequeIterator;  //速度比_IIterator稍快一点:)
  IIntfListIterator     = _IListIterator;   //速度比_IIterator稍快一点:)
  TIntfStack            = _TStack;
  TIntfQueue            = _TQueue;
  TIntfPriorityQueue    = _TPriorityQueue;

  IIntfMapIterator  = _IMapIterator;
  IIntfMap          = _IMap;
  IIntfMultiMap     = _IMultiMap;

  TIntfSet           = _TSet;
  TIntfMultiSet      = _TMultiSet;
  TIntfMap           = _TMap;
  TIntfMultiMap      = _TMultiMap;
  TIntfHashSet       = _THashSet;
  TIntfHashMultiSet  = _THashMultiSet;
  TIntfHashMap       = _THashMap;
  TIntfHashMultiMap  = _THashMultiMap;

implementation
uses
  HashFunctions;

function _IsEqual(const a,b :_ValueType):boolean;
begin
  result:=(a=b);
end;

function _IsLess(const a,b :_ValueType):boolean;
begin
  result:=(Cardinal(a)<Cardinal(b));
end;


{$I DGL.inc_pas}

end.



