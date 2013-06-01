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
// 具现化的String类型的声明
// Create by HouSisong, 2004.09.04
//------------------------------------------------------------------------------

unit DGL_String;

interface
uses
  SysUtils;

{$I DGLCfg.inc_h}
const
  _NULL_Value:string='';
type
  _ValueType   = string;

  function _HashValue(const Key: _ValueType):Cardinal;{$ifdef _DGL_Inline} inline; {$endif}//Hash函数

{$I DGL.inc_h}

type
  TStrAlgorithms       = _TAlgorithms;

  IStrIterator         = _IIterator;
  IStrContainer        = _IContainer;
  IStrSerialContainer  = _ISerialContainer;
  IStrVector           = _IVector;
  IStrList             = _IList;
  IStrDeque            = _IDeque;
  IStrStack            = _IStack;
  IStrQueue            = _IQueue;
  IStrPriorityQueue    = _IPriorityQueue;
  IStrSet              = _ISet;
  IStrMultiSet         = _IMultiSet;

  TStrVector           = _TVector;
  TStrDeque            = _TDeque;
  TStrList             = _TList;
  IStrVectorIterator   = _IVectorIterator; //速度比_IIterator稍快一点:)
  IStrDequeIterator    = _IDequeIterator;  //速度比_IIterator稍快一点:)
  IStrListIterator     = _IListIterator;   //速度比_IIterator稍快一点:)
  TStrStack            = _TStack;
  TStrQueue            = _TQueue;
  TStrPriorityQueue    = _TPriorityQueue;

  //

  IStrMapIterator  = _IMapIterator;
  IStrMap          = _IMap;
  IStrMultiMap     = _IMultiMap;

  TStrSet           = _TSet;
  TStrMultiSet      = _TMultiSet;
  TStrMap           = _TMap;
  TStrMultiMap      = _TMultiMap;
  TStrHashSet       = _THashSet;
  TStrHashMultiSet  = _THashMultiSet;
  TStrHashMap       = _THashMap;
  TStrHashMultiMap  = _THashMultiMap;

implementation
uses
  HashFunctions;

function _HashValue(const Key :_ValueType):Cardinal; overload;
begin
  result:=HashValue_Str(Key);
end;

{$I DGL.inc_pas}

end.

