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
// 例子 ：值语义的TPairStrInt结构(Record)的容器
// 具现化的TPairStrInt类型的声明
// Create by HouSisong, 2005.03.27
//------------------------------------------------------------------------------

unit _DGL_String_IntegerRecord;

interface
uses
  SysUtils;

//结构的容器的声明模版
{$I DGLCfg.inc_h}
type
  TPairStrInt  = record
    Key   : string;
    Value : integer;
  end;
  _ValueType  = TPairStrInt;

const
   _NULL_Value:_ValueType=(Key:('');Value:(0));

  function _HashValue(const Value:_ValueType) : Cardinal;{$ifdef _DGL_Inline} inline; {$endif}//Hash函数

  {$define _DGL_Compare}  //是否需要比较函数，可选
  function _IsEqual(const a,b :_ValueType):boolean; {$ifdef _DGL_Inline} inline; {$endif}//result:=(a=b);
  function _IsLess(const a,b :_ValueType):boolean; {$ifdef _DGL_Inline} inline; {$endif} //result:=(a<b); 默认排序准则

{$I DGL.inc_h}

type
  TStrIntAlgorithms       = _TAlgorithms;

  IStrIntIterator         = _IIterator;
  IStrIntContainer        = _IContainer;
  IStrIntSerialContainer  = _ISerialContainer;
  IStrIntVector           = _IVector;
  IStrIntList             = _IList;
  IStrIntDeque            = _IDeque;
  IStrIntStack            = _IStack;
  IStrIntQueue            = _IQueue;
  IStrIntPriorityQueue    = _IPriorityQueue;
  IStrIntSet              = _ISet;
  IStrIntMultiSet         = _IMultiSet;

  TStrIntVector           = _TVector;
  TStrIntDeque            = _TDeque;
  TStrIntList             = _TList;
  TStrIntStack            = _TStack;
  TStrIntQueue            = _TQueue;
  TStrIntPriorityQueue    = _TPriorityQueue;

  TStrIntHashSet          = _THashSet;
  TStrIntHashMuitiSet     = _THashMultiSet;


  function Pair_StrInt(const Key:string;const Value:integer):_ValueType;

implementation
uses
  HashFunctions;


{$I DGL.inc_pas}

function _HashValue(const Value :_ValueType):Cardinal;
begin
  result:=HashValue_Str(Value.Key)*37+Cardinal(Value.Value);
end;

function Pair_StrInt(const Key:string;const Value:integer):_ValueType;
begin
  result.Key:=Key;
  result.Value:=Value;
end;

function _IsEqual(const a,b :_ValueType):boolean;
begin
  result:=(a.Key=b.Key) and (a.Value=b.Value);
end;

function _IsLess(const a,b :_ValueType):boolean;
begin
  if (a.Key=b.Key) then
    result:=a.Value<b.Value
  else
    result:=a.Key<b.Key;
end;
end.
