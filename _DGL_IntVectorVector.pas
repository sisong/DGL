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
// 例子 ：vector's vector
// Create by HouSisong, 2006.09.30
//------------------------------------------------------------------------------

unit _DGL_IntVectorVector;

interface
uses
  SysUtils,DGL_Integer;
{$I DGLCfg.inc_h} 
type
  _ValueType   = IIntVector;

const
  _NULL_Value:IIntVector=nil;
  function _HashValue(const Key: _ValueType):Cardinal;//Hash函数

  {$define  _DGL_Compare}
  function _IsEqual(const a,b :_ValueType):boolean;{$ifdef _DGL_Inline} inline; {$endif} //result:=(a=b);
  function _IsLess(const a,b :_ValueType):boolean;{$ifdef _DGL_Inline} inline; {$endif}  //result:=(a<b); 默认排序准则
  {$define _DGL_ObjValue}  //需要保持对象的值语义
  function  _CreateNew():_ValueType;overload;{$ifdef _DGL_Inline} inline; {$endif}//构造
  function  _CopyCreateNew(const Value: _ValueType):_ValueType;overload;{$ifdef _DGL_Inline} inline; {$endif}//拷贝构造
  procedure _Assign(DestValue:_ValueType;const SrcValue: _ValueType);{$ifdef _DGL_Inline} inline; {$endif}//赋值
  procedure _Free(Value: _ValueType);{$ifdef _DGL_Inline} inline; {$endif}//析构

{$I DGL.inc_h}

type
  TIntVAlgorithms       = _TAlgorithms;

  IIntVIterator         = _IIterator;
  IIntVContainer        = _IContainer;
  IIntVSerialContainer  = _ISerialContainer;
  IIntVVector           = _IVector;
  IIntVList             = _IList;
  IIntVDeque            = _IDeque;
  IIntVStack            = _IStack;
  IIntVQueue            = _IQueue;
  IIntVPriorityQueue    = _IPriorityQueue;
  IIntVSet              = _ISet;
  IIntVMultiSet         = _IMultiSet;

  TIntVVector           = _TVector;
  TIntVDeque            = _TDeque;
  TIntVList             = _TList;
  IIntVVectorIterator   = _IVectorIterator; //速度比_IIterator稍快一点:)
  IIntVDequeIterator    = _IDequeIterator;  //速度比_IIterator稍快一点:)
  IIntVListIterator     = _IListIterator;   //速度比_IIterator稍快一点:)
  TIntVStack            = _TStack;
  TIntVQueue            = _TQueue;
  TIntVPriorityQueue    = _TPriorityQueue;

  //

  IIntVMapIterator  = _IMapIterator;
  IIntVMap          = _IMap;
  IIntVMultiMap     = _IMultiMap;

  TIntVSet           = _TSet;
  TIntVMultiSet      = _TMultiSet;
  TIntVMap           = _TMap;
  TIntVMultiMap      = _TMultiMap;
  TIntVHashSet       = _THashSet;
  TIntVHashMultiSet  = _THashMultiSet;
  TIntVHashMap       = _THashMap;
  TIntVHashMultiMap  = _THashMultiMap;

implementation


function _HashValue(const Key :_ValueType):Cardinal; overload;
begin
  result:=Cardinal(Key)*37;
end;

function _IsEqual(const a,b :_ValueType):boolean;
begin
  result:=(a=b);
end;

function _IsLess(const a,b :_ValueType):boolean;
begin
  result:=(Cardinal(a)<Cardinal(b));
end;

function  _CreateNew():_ValueType;overload;//构造
begin
  result:=TIntVector.Create();
end;

function  _CopyCreateNew(const Value: _ValueType):_ValueType;overload;//拷贝构造
begin
  if Value=nil then
    result:=TIntVector.Create()
  else
    result:=TIntVector.Create(Value.ItBegin,Value.ItEnd);
end;
procedure _Assign(DestValue:_ValueType;const SrcValue: _ValueType);//赋值
begin
  DestValue.Assign(SrcValue.ItBegin,SrcValue.ItEnd);
end;

procedure _Free(Value: _ValueType);//析构
begin
  Value:=nil;
end;



{$I DGL.inc_pas}

end.







