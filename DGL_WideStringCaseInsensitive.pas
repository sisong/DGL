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
// 具现化的大小写不敏感的WideString类型的声明
// Create by HouSisong, 2006.10.21
//------------------------------------------------------------------------------

unit DGL_WideStringCaseInsensitive;

interface
uses
  SysUtils;
{$I DGLCfg.inc_h} 
const
  _NULL_Value:WideString='';
type
  _ValueType   = WideString; //大小写不敏感的String

  function _HashValue(const Key: _ValueType):Cardinal;{$ifdef _DGL_Inline} inline; {$endif}//Hash函数
  {$define _DGL_Compare}  //比较函数
  function _IsEqual(const a,b :_ValueType):boolean;{$ifdef _DGL_Inline} inline; {$endif} //result:=(a=b);
  function _IsLess(const a,b :_ValueType):boolean; {$ifdef _DGL_Inline} inline; {$endif} //result:=(a<b); 默认排序准则

{$I DGL.inc_h}

type
  TCIWStrAlgorithms       = _TAlgorithms;

  ICIWStrIterator         = _IIterator;
  ICIWStrContainer        = _IContainer;
  ICIWStrSerialContainer  = _ISerialContainer;
  ICIWStrVector           = _IVector;
  ICIWStrList             = _IList;
  ICIWStrDeque            = _IDeque;
  ICIWStrStack            = _IStack;
  ICIWStrQueue            = _IQueue;
  ICIWStrPriorityQueue    = _IPriorityQueue;

  TCIWStrVector           = _TVector;
  TCIWStrDeque            = _TDeque;
  TCIWStrList             = _TList;
  ICIWStrVectorIterator   = _IVectorIterator; //速度比_IIterator稍快一点:)
  ICIWStrDequeIterator    = _IDequeIterator;  //速度比_IIterator稍快一点:)
  ICIWStrListIterator     = _IListIterator;   //速度比_IIterator稍快一点:)
  TCIWStrStack            = _TStack;
  TCIWStrQueue            = _TQueue;
  TCIWStrPriorityQueue    = _TPriorityQueue;

  //

  ICIWStrMapIterator  = _IMapIterator;
  ICIWStrMap          = _IMap;
  ICIWStrMultiMap     = _IMultiMap;

  TCIWStrSet           = _TSet;
  TCIWStrMultiSet      = _TMultiSet;
  TCIWStrMap           = _TMap;
  TCIWStrMultiMap      = _TMultiMap;
  TCIWStrHashSet       = _THashSet;
  TCIWStrHashMultiSet  = _THashMultiSet;
  TCIWStrHashMap       = _THashMap;
  TCIWStrHashMultiMap  = _THashMultiMap;

implementation
uses
  HashFunctions;

function _HashValue(const Key :_ValueType):Cardinal; overload;
begin
  result:=HashValue_WideStrCaseInsensitive(Key);
end;

function _IsEqual(const a,b :_ValueType):boolean; //result:=(a=b);
begin
  result:=IsEqual_WideStrCaseInsensitive(a,b);
end;

function _IsLess(const a,b :_ValueType):boolean;  //result:=(a<b); 默认排序准则
begin
  result:=IsLess_WideStrCaseInsensitive(a,b);
end;

{$I DGL.inc_pas}

end.

