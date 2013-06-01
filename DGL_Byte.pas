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
// 具现化的Byte类型的声明
// Create by HouSisong, 2004.09.14
//------------------------------------------------------------------------------

unit DGL_Byte;

interface
uses
  SysUtils;
{$I DGLCfg.inc_h} 
type
  _ValueType   = Byte;
  {$define _DGL_NotHashFunction}

const
  _NULL_Value:Byte=0;

{$I DGL.inc_h}

type
  TByteAlgorithms       = _TAlgorithms;

  IByteIterator         = _IIterator;
  IByteContainer        = _IContainer;
  IByteSerialContainer  = _ISerialContainer;
  IByteVector           = _IVector;
  IByteList             = _IList;
  IByteDeque            = _IDeque;
  IByteStack            = _IStack;
  IByteQueue            = _IQueue;
  IBytePriorityQueue    = _IPriorityQueue;
  IByteSet              = _ISet;
  IByteMultiSet         = _IMultiSet;

  TByteVector           = _TVector;
  TByteDeque            = _TDeque;
  TByteList             = _TList;
  IByteVectorIterator   = _IVectorIterator; //速度比_IIterator稍快一点:)
  IByteDequeIterator    = _IDequeIterator;  //速度比_IIterator稍快一点:)
  IByteListIterator     = _IListIterator;   //速度比_IIterator稍快一点:)
  TByteStack            = _TStack;
  TByteQueue            = _TQueue;
  TBytePriorityQueue    = _TPriorityQueue;

  //

  IByteMapIterator  = _IMapIterator;
  IByteMap          = _IMap;
  IByteMultiMap     = _IMultiMap;

  TByteSet           = _TSet;
  TByteMultiSet      = _TMultiSet;
  TByteMap           = _TMap;
  TByteMultiMap      = _TMultiMap;
  TByteHashSet       = _THashSet;
  TByteHashMultiSet  = _THashMultiSet;
  TByteHashMap       = _THashMap;
  TByteHashMultiMap  = _THashMultiMap;

implementation

{$I DGL.inc_pas}

end.







