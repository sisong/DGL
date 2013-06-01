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
// 例子 ：值语义的TTestObj的容器
// 具现化的TTestObj类型的声明
// 需要保持值语义的类的容器的声明模版
// 值语义:容器对于传进来的对象进行拷贝来保存，容器删除对象时会自动进行释放；
// Create by HouSisong, 2004.09.04
//------------------------------------------------------------------------------
unit _DGL_Object;

//如果只是需要保持引用语义，则注释掉_DGL_ObjValue的定义

interface
uses
  SysUtils;

var
  _refCount : integer=0;
  _ValueCount : integer=1;
type
  TTestObj = class(TObject)
    FValue : integer;
    constructor Create();overload;
    constructor Create(v:TTestObj);overload;
    destructor Destroy();override;
  end;


type
  _ValueType  = TTestObj;
const
  _NULL_Value:TTestObj =nil ;
  function _HashValue(const Key:_ValueType) : Cardinal;//Hash函数

  {$define _DGL_Compare}  //需要比较函数，可选
  function  _IsEqual(const a,b :_ValueType):boolean; //result:=(a=b);
  function  _IsLess(const a,b :_ValueType):boolean;  //result:=(a<b); 默认排序准则
  {$define _DGL_ObjValue}  //需要保持对象的值语义
  function  _CreateNew():_ValueType;overload;//构造
  function  _CopyCreateNew(const Value: _ValueType):_ValueType;overload;//拷贝构造
  procedure _Assign(DestValue:_ValueType;const SrcValue: _ValueType);//赋值
  procedure _Free(Value: _ValueType);//析构


{$I DGL.inc_h}


//<out>
type
  TObjAlgorithms       = _TAlgorithms;

  IObjIterator         = _IIterator;
  IObjContainer        = _IContainer;
  IObjSerialContainer  = _ISerialContainer;
  IObjVector           = _IVector;
  IObjList             = _IList;
  IObjDeque            = _IDeque;
  IObjStack            = _IStack;
  IObjQueue            = _IQueue;
  IObjPriorityQueue    = _IPriorityQueue;
  IObjSet              = _ISet;
  IObjMultiSet         = _IMultiSet;

  TObjPointerItBox     = _TPointerItBox_Obj;

  TObjVector           = _TVector;
  IObjVectorIterator   = _IVectorIterator; //速度比_IIterator稍快一点:)
  TObjDeque            = _TDeque;
  TObjList             = _TList;
  TObjStack            = _TStack;
  TObjQueue            = _TQueue;
  TObjPriorityQueue    = _TPriorityQueue;
  TObjHashSet          = _THashSet;
  TObjHashMuitiSet     = _THashMultiSet;

  //

  IObjMapIterator  = _IMapIterator;
  IObjMap          = _IMap;
  IObjMultiMap     = _IMultiMap;

  TObjHashMap          = _THashMap;
  TObjHashMultiMap     = _THashMultiMap;

implementation

{$I DGL.inc_pas}

function _HashValue(const Key :_ValueType):Cardinal;
begin
  Assert(Key<>nil);
  result:=Cardinal(Key.FValue)*37;
end;


function  _IsEqual(const a,b :_ValueType):boolean;
begin
  Assert(a<>nil);
  Assert(b<>nil);
  result:=(a.FValue=b.FValue);
  //Assert(false);//自己按实际情况实现
end;

function  _IsLess(const a,b :_ValueType):boolean;
begin
  Assert(a<>nil);
  Assert(b<>nil);
  result:=(a.FValue<b.FValue);
  //Assert(false);//自己按实际情况实现
end;

function  _CreateNew():_ValueType;
begin
  result:=TTestObj.Create();
  //Assert(false);//自己按实际情况实现
end;

function  _CopyCreateNew(const Value: _ValueType):_ValueType;
begin
  Assert(Value<>nil);
  result:=TTestObj.Create(Value);
  //Assert(false);//自己按实际情况实现
end;

procedure  _Assign(DestValue:_ValueType;const SrcValue: _ValueType);
begin
  Assert(DestValue<>nil);
  Assert(SrcValue<>nil);
  DestValue.FValue:=SrcValue.FValue;
  //Assert(false);//自己按实际情况实现
end;

procedure _Free(Value: _ValueType);
begin
  Assert(Value<>nil);
  Value.Free();
  //Assert(false);//自己按实际情况实现 如:Value.Free;
end;

{ TTestObj }

constructor TTestObj.Create;
begin
  inherited Create();
  FValue:=_ValueCount;
  inc(_ValueCount);
  inc(_refCount);
end;

constructor TTestObj.Create(v: TTestObj);
begin
  inherited Create();
  FValue:=v.FValue;
  inc(_refCount);
end;

destructor TTestObj.Destroy;
begin
  dec(_refCount);
  inherited;
end;


end.
