(*
 * DGL(The Delphi Generic Library)
 *
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
//DGLMap_Integer_TNotifyEvent
//例子
//具现化Integer<->TNotifyEvent的map容器和其迭代器
// Create by HouSisong, 2005.02.21
//------------------------------------------------------------------------------
unit DGLMap_Integer_TNotifyEvent;     

interface
uses
  SysUtils, Classes;
{$I DGLCfg.inc_h} 
const
  _NULL_Value = nil;
type
  _KeyType     = Integer;
  _ValueType   = TNotifyEvent;

  {$define _DGL_NotHashFunction}

  {$define _DGL_Compare}  //比较函数
  function _IsEqual(const a,b :_ValueType):boolean;{$ifdef _DGL_Inline} inline; {$endif} //result:=(a=b);
  function _IsLess(const a,b :_ValueType):boolean;{$ifdef _DGL_Inline} inline; {$endif}  //result:=(a<b); 默认排序准则

{$I Map.inc_h} //"类"模版的声明文件
{$I HashMap.inc_h} //"类"模版的声明文件

//out
type
  IIntEventMapIterator  = _IMapIterator;
  IIntEventMap          = _IMap;
  IIntEventMultiMap     = _IMultiMap;

  TIntEventMap           = _TMap;
  TIntEventMultiMap      = _TMultiMap;
  TIntEventHashMap       = _THashMap;
  TIntEventHashMultiMap  = _THashMultiMap;


implementation
uses
  HashFunctions;

{$I Map.inc_pas} //"类"模版的实现文件
{$I HashMap.inc_pas} //"类"模版的实现文件

function _IsEqual(const a,b :_ValueType):boolean; //result:=(a=b);
begin
  result:=(PInt64(@@a)^)=PInt64(@@b)^;
end;

function _IsLess(const a,b :_ValueType):boolean;  //result:=(a<b); 默认排序准则
begin
  result:=(PInt64(@@a)^)<PInt64(@@b)^;
end;

initialization
  Assert(sizeof(int64)=sizeof(_ValueType));
end.

