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
// 例子 ：值语义的TPoint结构(Record)的容器
// 具现化的TPoint类型的声明
// Create by HouSisong, 2004.09.04
//------------------------------------------------------------------------------

unit _DGL_Point;

interface
uses
  SysUtils;

//结构的容器的声明模版

{$I DGLCfg.inc_h}  

type
  TPoint  = record     // object
    x : integer;
    y : integer;
  end;
  _ValueType  = TPoint;

const
   _NULL_Value:_ValueType=(x:(0);y:(0));
  function _HashValue(const Value:_ValueType) : Cardinal;{$ifdef _DGL_Inline} inline; {$endif}//Hash函数

  {$define _DGL_Compare}  //是否需要比较函数，可选
  function _IsEqual(const a,b :_ValueType):boolean;{$ifdef _DGL_Inline} inline; {$endif} //result:=(a=b);
  function _IsLess(const a,b :_ValueType):boolean;{$ifdef _DGL_Inline} inline; {$endif}  //result:=(a<b); 默认排序准则

{$I DGL.inc_h}

type
  IPointIterator         = _IIterator;
  IPointContainer        = _IContainer;
  IPointSerialContainer  = _ISerialContainer;
  IPointVector           = _IVector;
  IPointList             = _IList;
  IPointDeque            = _IDeque;
  IPointStack            = _IStack;
  IPointQueue            = _IQueue;
  IPointPriorityQueue    = _IPriorityQueue;
  IPointSet              = _ISet;
  IPointMultiSet         = _IMultiSet;

  TPointPointerItBox     = _TPointerItBox_Obj;

  TPointVector           = _TVector;
  IPointVectorIterator   = _IVectorIterator; //速度比_IIterator稍快一点:)
  TPointDeque            = _TDeque;
  TPointList             = _TList;
  TPointStack            = _TStack;
  TPointQueue            = _TQueue;
  TPointPriorityQueue    = _TPriorityQueue;
  TPointHashSet          = _THashSet;
  TPointHashMuitiSet     = _THashMultiSet;

  //

  IPointMapIterator  = _IMapIterator;
  IPointMap          = _IMap;
  IPointMultiMap     = _IMultiMap;

  TPointHashMap          = _THashMap;
  TPointHashMultiMap     = _THashMultiMap;

  function Point(a,b:integer):TPoint;

implementation


{$I DGL.inc_pas}

function _HashValue(const Value :_ValueType):Cardinal;
begin
  result:=Cardinal(Value.x)*37+Cardinal(Value.y)*9;
end;

function Point(a,b:integer):TPoint;
begin
  result.x:=a;
  result.y:=b;
end;

function _IsEqual(const a,b :_ValueType):boolean;
begin
  result:=(a.x=b.x) and (a.y=b.y);
end;

function _IsLess(const a,b :_ValueType):boolean;
begin
  if (a.x=b.x) then
    result:=a.y<b.y
  else
    result:=a.x<b.x;
end;
end.
