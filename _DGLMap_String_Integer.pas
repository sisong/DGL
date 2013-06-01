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
//TStrIntMap
//例子
//具现化String<->integer的map容器和其迭代器
// Create by HouSisong, 2004.09.13
//------------------------------------------------------------------------------
unit _DGLMap_String_Integer;

interface
uses
  SysUtils;

{$I DGLCfg.inc_h}

type
  _KeyType     = string;
  _ValueType   = integer;

const
  _NULL_Value:integer=0;
  function _HashValue(const Key: _KeyType):Cardinal;{$ifdef _DGL_Inline} inline; {$endif}//Hash函数

{$I HashMap.inc_h} //"类"模版的声明文件
{$I Map.inc_h} //"类"模版的声明文件
{$I Algorithms.inc_h}

//out
type
  IStrIntMapIterator  = _IMapIterator;
  IStrIntMap          = _IMap;
  IStrIntMultiMap     = _IMultiMap;

  TStrIntHashMap          = _THashMap;
  TStrIntHashMultiMap     = _THashMultiMap;

  TStrIntMap          = _TMap;
  TStrIntMultiMap     = _TMultiMap;

implementation
uses
  HashFunctions;

{$I HashMap.inc_pas} //"类"模版的实现文件
{$I Map.inc_pas} //"类"模版的实现文件
{$I Algorithms.inc_pas}

function _HashValue(const Key :_KeyType):Cardinal; overload;
begin
  result:=HashValue_Str(Key);
end;

end.






