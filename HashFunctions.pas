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
// 常用类型的Hash值计算函数、不区分大小写的字符串的比较函数等
// Create by HouSisong, 2004.09.14
//------------------------------------------------------------------------------

unit HashFunctions;

interface
                         
function HashValue_Data(const PSrcData:PByte;const ByteCount: integer):Cardinal;//计算hash值

function HashValue_Str(const Key :String):Cardinal; //计算Hash值; 区分大小写
function HashValue_StrCaseInsensitive(const Key :String):Cardinal; //计算Hash值；不区分大小写
function IsEqual_StrCaseInsensitive(const Left,Right:String):boolean;  //不区分大小写的相等比较
function IsLess_StrCaseInsensitive(const Left,Right:String):boolean;  //不区分大小写的小于比较
function Pos_StrCaseInsensitive(const Substr: string; S: string): Integer; {$ifdef _DGL_Inline} inline; {$endif}
function PosEx_StrCaseInsensitive(const Substr: string; S: string;const Index:integer): Integer;

function HashValue_WideStr(const Key :WideString):Cardinal; //计算Hash值; 区分大小写
function HashValue_WideStrCaseInsensitive(const Key :WideString):Cardinal; //计算Hash值；不区分大小写
function IsEqual_WideStrCaseInsensitive(const Left,Right:WideString):boolean;  //不区分大小写的相等比较
function IsLess_WideStrCaseInsensitive(const Left,Right:WideString):boolean;  //不区分大小写的小于比较
function Pos_WideStrCaseInsensitive(const Substr: WideString; S: WideString): Integer;
function PosEx_WideStrCaseInsensitive(const Substr: WideString; S: WideString;const Index:integer): Integer;

function HashValue_Int64(const Key :Int64):Cardinal;{$ifdef _DGL_Inline} inline; {$endif}
function HashValue_Real(const Key :Real):Cardinal; {$ifdef _DGL_Inline} inline; {$endif}
function HashValue_Real48(const Key :Real48):Cardinal; {$ifdef _DGL_Inline} inline; {$endif}
function HashValue_Single(const Key :Single):Cardinal;
function HashValue_Double(const Key :double):Cardinal; {$ifdef _DGL_Inline} inline; {$endif}
function HashValue_Extended(const Key :Extended):Cardinal; {$ifdef _DGL_Inline} inline; {$endif}
function HashValue_Comp(const Key :Comp):Cardinal;{$ifdef _DGL_Inline} inline; {$endif}
function HashValue_Currency(const Key :Currency):Cardinal;{$ifdef _DGL_Inline} inline; {$endif}



implementation

uses
  math,SysUtils;

function HashValue_Data(const PSrcData:PByte;const ByteCount: integer):Cardinal;//计算hash值
var
  i : integer;
  PData:PByteArray;
begin
  result:=ByteCount;
  PData:=PByteArray(PSrcData);
  for i:=0 to ByteCount-1 do
  begin
    result:=(result xor (Result shl 5))+PData[i];
  end;
end;

///
function HashValue_Str(const Key :String):Cardinal; // 区分大小写
var
  i,Len    : integer;
  pStrChar : PByteArray;
begin
  Len:= length(Key);
  result:=Len;
  pStrChar:=PByteArray(Key);
  for i:=0 to Len-1 do
  begin
    result:=(result xor (Result shl 5))+pStrChar[i];
  end;
end;


//不区分大小写 使用的转换表
const
  MaxChar =255;
const CharCaseInsensitive : array [0..MaxChar] of BYTE=
(
	0,	1,	2,	3,	4,	5,	6,	7,	8,	9,	10,	11,	12,	13,	14,	15,
	16,	17,	18,	19,	20,	21,	22,	23,	24,	25,	26,	27,	28,	29,	30,	31,
	32,	33,	34,	35,	36,	37,	38,	39,	40,	41,	42,	43,	44,	45,	46,	47,
	48,	49,	50,	51,	52,	53,	54,	55,	56,	57,	58,	59,	60,	61,	62,	63,
	64,	Ord('A'),	Ord('B'),	Ord('C'),	Ord('D'),	Ord('E'),	Ord('F'),	Ord('G'),	Ord('H'),	Ord('I'),	Ord('J'),	Ord('K'),	Ord('L'),	Ord('M'),	Ord('N'),	Ord('O'),
	Ord('P'),	Ord('Q'),	Ord('R'),	Ord('S'),	Ord('T'),	Ord('U'),	Ord('V'),	Ord('W'),	Ord('X'),	Ord('Y'),	Ord('Z'),	91,	92,	93,	94,	95,
	96,	Ord('A'),	Ord('B'),	Ord('C'),	Ord('D'),	Ord('E'),	Ord('F'),	Ord('G'),	Ord('H'),	Ord('I'),	Ord('J'),	Ord('K'),	Ord('L'),	Ord('M'),	Ord('N'),	Ord('O'),
	Ord('P'),	Ord('Q'),	Ord('R'),	Ord('S'),	Ord('T'),	Ord('U'),	Ord('V'),	Ord('W'),	Ord('X'),	Ord('Y'),	Ord('Z'),	123,	124,	125,	126,	127,
	128,	129,	130,	131,	132,	133,	134,	135,	136,	137,	138,	139,	140,	141,	142,	143,
	144,	145,	146,	147,	148,	149,	150,	151,	152,	153,	154,	155,	156,	157,	158,	159,
	160,	161,	162,	163,	164,	165,	166,	167,	168,	169,	170,	171,	172,	173,	174,	175,
	176,	177,	178,	179,	180,	181,	182,	183,	184,	185,	186,	187,	188,	189,	190,	191,
	192,	193,	194,	195,	196,	197,	198,	199,	200,	201,	202,	203,	204,	205,	206,	207,
	208,	209,	210,	211,	212,	213,	214,	215,	216,	217,	218,	219,	220,	221,	222,	223,
	224,	225,	226,	227,	228,	229,	230,	231,	232,	233,	234,	235,	236,	237,	238,	239,
	240,	241,	242,	243,	244,	245,	246,	247,	248,	249,	250,	251,	252,	253,	254,	255
  );
function HashValue_StrCaseInsensitive(const Key :String):Cardinal; //不区分大小写
var
  i,Len    : integer;
  pStrChar : PByteArray;
begin
  Len:= length(Key);
  result:=Len;
  pStrChar:=PByteArray(Key);
  for i:=0 to Len-1 do
  begin
    result:=(result xor (Result shl 5))+CharCaseInsensitive[pStrChar[i]];
  end;
end;

function IsEqual_StrCaseInsensitive(const Left,Right:String):boolean;  //不区分大小写
var
  i,LLen,RLen    : integer;
  pLStrChar      : PChar;
  pRStrChar      : PChar;
begin
  LLen:= length(Left);
  RLen:= length(Right);
  if (LLen<>RLen) then
  begin
    result:=false;
    exit;
  end;

  pLStrChar:=PChar(Left);
  pRStrChar:=PChar(Right);
  for i:=1 to LLen do
  begin
    if (CharCaseInsensitive[Ord(pLStrChar^)]
      <>CharCaseInsensitive[Ord(pRStrChar^)]) then
    begin
      result:=false;
      exit;
    end;
    inc(pLStrChar);
    inc(pRStrChar);
  end;
  result:=true;
end;

function IsLess_StrCaseInsensitive(const Left,Right:String):boolean;  //不区分大小写的小于比较
var
  i,LLen,RLen    : integer;
  pLStrChar      : PChar;
  pRStrChar      : PChar;
  LChar      : Cardinal;
  RChar      : Cardinal;
begin
  LLen:= length(Left);
  RLen:= length(Right);

  pLStrChar:=PChar(Left);
  pRStrChar:=PChar(Right);
  for i:=1 to min(LLen,RLen) do
  begin
    LChar:=CharCaseInsensitive[Ord(pLStrChar^)];
    RChar:=CharCaseInsensitive[Ord(pRStrChar^)];
    if (LChar=RChar) then
    begin
      inc(pLStrChar);
      inc(pRStrChar);
    end
    else
    begin
      result:=LChar<RChar;
      exit;
    end;
  end;
  result:=LLen<RLen;
end;

function Pos_StrCaseInsensitive(const Substr: string; S: string): Integer;
begin
  result:=PosEx_StrCaseInsensitive(Substr,S,1);
end;

function PosEx_StrCaseInsensitive(const Substr: string; S: string;const Index:integer): Integer;
  function _Case_IsEq(const CaseSub,Spos:PChar;const Length:integer):boolean;
  var
    i : integer;
  begin
    for i:=0 to Length-1 do
    begin
      if PByteArray(CaseSub)[i]<>CharCaseInsensitive[ord(PByteArray(Spos)[i])] then
      begin
        result:=false;
        exit;
      end;
    end;
    result:=true;
  end;
  
var
  i,LS,LSub : integer;
  FdChar : Char;
  CaseSub  : string;
begin
  result:=0;
  LSub:=length(Substr);
  if LSub<=0 then exit;
  LS:=length(S);
  CaseSub:=AnsiUpperCase(Substr);
  FdChar:=CaseSub[1];
  for i:=Index to LS-LSub+1 do
  begin
    if CharCaseInsensitive[ord(S[i])]=ord(FdChar) then
    begin
      if _Case_IsEq(@CaseSub[2],@S[i+1],LSub-1) then
      begin
        result:=i;
        exit;
      end;
    end;
  end;
end;

function Pos_WideStrCaseInsensitive(const Substr: WideString; S: WideString): Integer;
begin
  result:=PosEx_WideStrCaseInsensitive(Substr,S,1);
end;
function PosEx_WideStrCaseInsensitive(const Substr: WideString; S: WideString;const Index:integer): Integer;
  function _Case_IsEq(const CaseSub,Spos:PWideChar;const Length:integer):boolean;
  var
    i : integer;
    tmpWChar : Word;
  begin
    for i:=0 to Length-1 do
    begin
      tmpWChar:=PWordArray(Spos)[i];
      if not ( (PWordArray(CaseSub)[i]=tmpWChar) or ( (tmpWChar<=MaxChar) and
          (PWordArray(CaseSub)[i]=CharCaseInsensitive[tmpWChar]))  ) then
      begin
        result:=false;
        exit;
      end;
    end;
    result:=true;
  end;
  
var
  i,LS,LSub : integer;
  FdChar : WideChar;
  CaseSub  : WideString;
  tmpW : WideChar;
begin
  result:=0;
  LSub:=length(Substr);
  if LSub<=0 then exit;
  LS:=length(S);
  CaseSub:=AnsiUpperCase(Substr);
  FdChar:=CaseSub[1];
  for i:=Index to LS-LSub+1 do
  begin
    tmpW:=S[i];
    if (tmpW=FdChar) or ((ord(tmpW)<=MaxChar) and (CharCaseInsensitive[ord(tmpW)]=ord(FdChar))) then
    begin
      if _Case_IsEq(@CaseSub[2],@S[i+1],LSub-1) then
      begin
        result:=i;
        exit;
      end;
    end;
  end;
end;


function HashValue_WideStr(const Key :WideString):Cardinal; // 区分大小写
var
  i,Len    : integer;
  pStrChar : PWordArray;
begin
  pStrChar:=PWordArray(Key);
  Len:= length(Key);
  result:=Len;
  for i:=0 to Len-1 do
  begin
    result:=(result xor (Result shl 5))+pStrChar[i];
  end;
end;

function HashValue_WideStrCaseInsensitive(const Key :WideString):Cardinal; //不区分大小写
var
  i,Len    : integer;
  pStrChar : PWordArray;
  wChar    : Word;
begin
  pStrChar:=PWordArray(Key);
  Len:= length(Key);
  result:=Len;
  for i:=0 to Len-1 do
  begin
    wChar:=pStrChar[i];
    if Ord(wChar)<=MaxChar then
      wChar:=CharCaseInsensitive[wChar];
    result:=(result xor (Result shl 5))+wChar;
  end;
end;

function IsEqual_WideStrCaseInsensitive(const Left,Right:WideString):boolean;  //不区分大小写
var
  i,LLen,RLen    : integer;
  pLStrChar      : PWideChar;
  pRStrChar      : PWideChar;
  LChar      : Cardinal;
  RChar      : Cardinal;
begin
  LLen:= length(Left);
  RLen:= length(Right);
  if (LLen<>RLen) then
  begin
    result:=false;
    exit;
  end;

  pLStrChar:=PWideChar(Left);
  pRStrChar:=PWideChar(Right);
  for i:=1 to LLen do
  begin
    LChar:=Ord(pLStrChar^);
    RChar:=Ord(pRStrChar^);
    if LChar<>RChar then
    begin
      if (LChar<=MaxChar) and (RChar<=MaxChar)
      and (CharCaseInsensitive[LChar]=CharCaseInsensitive[RChar]) then
        Continue
      else
      begin
        result:=false;
        exit;
      end;
    end;
    inc(pLStrChar);
    inc(pRStrChar);
  end;
  result:=true;
end;

function IsLess_WideStrCaseInsensitive(const Left,Right:WideString):boolean;  //不区分大小写的小于比较
var
  i,LLen,RLen    : integer;
  pLStrChar      : PWideChar;
  pRStrChar      : PWideChar;
  LChar      : Cardinal;
  RChar      : Cardinal;
begin
  LLen:= length(Left);
  RLen:= length(Right);

  pLStrChar:=PWideChar(Left);
  pRStrChar:=PWideChar(Right);
  for i:=1 to min(LLen,RLen) do
  begin
    LChar:=Ord(pLStrChar^);
    RChar:=Ord(pRStrChar^);
    if (LChar=RChar) then
    begin
      inc(pLStrChar);
      inc(pRStrChar);
    end
    else
    begin
      if (LChar<=MaxChar) and (RChar<=MaxChar)
      and (CharCaseInsensitive[LChar]=CharCaseInsensitive[RChar]) then
      begin
        inc(pLStrChar);
        inc(pRStrChar);
      end
      else
      begin
        result:=LChar<RChar;
        exit;
      end;
    end;
  end;
  result:=LLen<RLen;
end;

function HashValue_Int64(const Key :Int64):Cardinal;
var
  lowkey : Cardinal;
begin
  lowkey:=Key;
  result:=Key shr 32;
  result:=(result xor (Result shl 5))+lowkey;
end;

function HashValue_Real(const Key :Real):Cardinal;
begin
  result:=HashValue_Data(@Key,sizeof(Key));
end;

function HashValue_Real48(const Key :Real48):Cardinal;
begin
  result:=HashValue_Data(@Key,sizeof(Key));
end;
function HashValue_Single(const Key :Single):Cardinal;
begin
  result:=HashValue_Data(@Key,sizeof(Key));
end;
function HashValue_Double(const Key :double):Cardinal;
begin
  result:=HashValue_Data(@Key,sizeof(Key));
end;
function HashValue_Extended(const Key :Extended):Cardinal;
begin
  result:=HashValue_Data(@Key,sizeof(Key));
end;
function HashValue_Comp(const Key :Comp):Cardinal;
begin
  result:=HashValue_Data(@Key,sizeof(Key));
end;
function HashValue_Currency(const Key :Currency):Cardinal;
begin
  result:=HashValue_Data(@Key,sizeof(Key));
end;


end.
