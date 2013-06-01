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
// Create by HouSisong, 2006.10.21
//------------------------------------------------------------------------------

unit DGL_Word;

interface
uses
  SysUtils;
{$I DGLCfg.inc_h} 
type
  _ValueType   = Word;

const
  _NULL_Value:Word=0;
  {$define _DGL_NotHashFunction}

{$I DGL.inc_h}

type
  TWordAlgorithms       = _TAlgorithms;

  IWordIterator         = _IIterator;
  IWordContainer        = _IContainer;
  IWordSerialContainer  = _ISerialContainer;
  IWordVector           = _IVector;
  IWordList             = _IList;
  IWordDeque            = _IDeque;
  IWordStack            = _IStack;
  IWordQueue            = _IQueue;
  IWordPriorityQueue    = _IPriorityQueue;
  IWordSet              = _ISet;
  IWordMultiSet         = _IMultiSet;

  TWordVector           = _TVector;
  TWordDeque            = _TDeque;
  TWordList             = _TList;
  IWordVectorIterator   = _IVectorIterator; //速度比_IIterator稍快一点:)
  IWordDequeIterator    = _IDequeIterator;  //速度比_IIterator稍快一点:)
  IWordListIterator     = _IListIterator;   //速度比_IIterator稍快一点:)
  TWordStack            = _TStack;
  TWordQueue            = _TQueue;
  TWordPriorityQueue    = _TPriorityQueue;


  IWordMapIterator  = _IMapIterator;
  IWordMap          = _IMap;
  IWordMultiMap     = _IMultiMap;

  TWordSet           = _TSet;
  TWordMultiSet      = _TMultiSet;
  TWordMap           = _TMap;
  TWordMultiMap      = _TMultiMap;
  TWordHashSet       = _THashSet;
  TWordHashMultiSet  = _THashMultiSet;
  TWordHashMap       = _THashMap;
  TWordHashMultiMap  = _THashMultiMap;

implementation

{$I DGL.inc_pas}

end.







