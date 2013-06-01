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
// 具现化的WideString类型的声明
// Create by HouSisong, 2006.10.21
//------------------------------------------------------------------------------

unit DGL_WideString;

interface
uses
  SysUtils;

{$I DGLCfg.inc_h}
const
  _NULL_Value:WideString='';
type
  _ValueType   = WideString;

  function _HashValue(const Key: _ValueType):Cardinal;{$ifdef _DGL_Inline} inline; {$endif}//Hash函数

{$I DGL.inc_h}

type
  TWStrAlgorithms       = _TAlgorithms;

  IWStrIterator         = _IIterator;
  IWStrContainer        = _IContainer;
  IWStrSerialContainer  = _ISerialContainer;
  IWStrVector           = _IVector;
  IWStrList             = _IList;
  IWStrDeque            = _IDeque;
  IWStrStack            = _IStack;
  IWStrQueue            = _IQueue;
  IWStrPriorityQueue    = _IPriorityQueue;
  IWStrSet              = _ISet;
  IWStrMultiSet         = _IMultiSet;

  TWStrVector           = _TVector;
  TWStrDeque            = _TDeque;
  TWStrList             = _TList;
  IWStrVectorIterator   = _IVectorIterator; //速度比_IIterator稍快一点:)
  IWStrDequeIterator    = _IDequeIterator;  //速度比_IIterator稍快一点:)
  IWStrListIterator     = _IListIterator;   //速度比_IIterator稍快一点:)
  TWStrStack            = _TStack;
  TWStrQueue            = _TQueue;
  TWStrPriorityQueue    = _TPriorityQueue;

  //

  IWStrMapIterator  = _IMapIterator;
  IWStrMap          = _IMap;
  IWStrMultiMap     = _IMultiMap;

  TWStrSet           = _TSet;
  TWStrMultiSet      = _TMultiSet;
  TWStrMap           = _TMap;
  TWStrMultiMap      = _TMultiMap;
  TWStrHashSet       = _THashSet;
  TWStrHashMultiSet  = _THashMultiSet;
  TWStrHashMap       = _THashMap;
  TWStrHashMultiMap  = _THashMultiMap;

implementation
uses
  HashFunctions;

function _HashValue(const Key :_ValueType):Cardinal; overload;
begin
  result:=HashValue_WideStr(Key);
end;

{$I DGL.inc_pas}

end.

