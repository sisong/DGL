DGL
================
Version 1.28  
Delphi泛型库--DGL(The Delphi Generic Library) , writed in 2004.

===
*  安装:  
    将DGL源代码目录设置到编译器的搜索路径中

*  使用方法:  
    直接引用DGL_XXX.pas单元，大部分应用都应该没有问题了；  
    如果为了速度或效率等需要库支持自定义的结构等，可以新开一个单元，借鉴DGL_XXX的实现，很容易就可以完成；
   
===
*  说明:  
  DGL库实现于2004年(Delphi不支持Generic语法的年代);   
  那时候想在Delphi里寻找C++中类似的STL的替代品,但调查了一圈都很失望：其它现有的Delphi容器和算法库实现中，主要的实现途径有利用Delphi中的array of const和variant(相当于弱类型,而且对结构的支持差，如Decal)；或者建立一套单根类体系作为容器中的元素(主要使用虚函数机制,如：左轻侯有篇文章也谈到过; 一般简单类型需要做打包拆包)；还有的实现是针对TObject、IInterface、String等做多套代码实现(如:DCL库)； 但他们相对于C++的STL来说缺陷也很明显，类型不安全,速度慢，代码重复等；  
  DGL库的实现克服了这些问题，库能够支持几乎所有基本类型、指针(包括类的指针)、Interface、结构(record)、Object结构(Delphi中已经不推荐使用)、类成员函数指针、类(class)的值语义(一般Delphi中不习惯使用类的值语义，所以不建议使用)等其它用户自定义类型，并且类型安全! 速度当然也没有问题,与C++的各种STL比也不差!  

===
  **DGL vs  STL(vc6)、STL(SGI)、DCL 、DeCal 、EZDSL :**    
  10,000,000 integer for test,1M integer for Random Visite, CPU: AMD Athlon(tm)64 3000+(1.81G)  
   
```
DGL lib (Delphi7 Compile)========================================================  
Container:  PushBack  Next Visite Random Visite Insert At Middle  PushFront  
TVector     0.011 us  0.008 us    0.086 us      31400.000 us      75000.000 us  
TDeque      0.009 us  0.012 us    0.219 us      100000.000 us     0.009 us  
TList       0.048 us  0.017 us    8590.000 us   0.077 us          0.055 us  
IVector     0.018 us  0.018 us    0.110 us      31200.000 us      75000.000 us  
IDeque      0.014 us  0.019 us    0.235 us      103200.000 us     0.011 us  
IList       0.073 us  0.022 us    8440.000 us   0.077 us          0.056 us  
Container:  Insert      Find        Next Visite  
Map         0.384 us    3.383 us    0.070 us  
MultiMap    0.388 us    3.706 us    0.097 us  
Set         0.461 us    3.253 us    0.064 us  
MultiSet    0.457 us    3.260 us    0.064 us  
HashMap      0.288 us   0.857 us    0.048 us  
HashMultiMap 0.296 us   0.961 us    0.067 us  
HashSet      0.284 us   0.869 us    0.052 us  
HashMultiSet 0.254 us   0.868 us    0.046 us  
DGL lib (Turbo Delphi2006 Compile)========================================================  
Container:  PushBack  Next Visite Random Visite Insert At Middle  PushFront  
TVector     0.029 us  0.007 us    0.079 us      27600.000 us      66800.000 us  
TDeque      0.007 us  0.009 us    0.234 us      113200.000 us     0.006 us  
TList       0.029 us  0.015 us    8520.000 us   0.066 us          0.037 us  
IVector     0.025 us  0.015 us    0.107 us      33000.000 us      79600.000 us  
IDeque      0.010 us  0.015 us    0.245 us      103400.000 us     0.013 us  
IList       0.050 us  0.017 us    8950.000 us   0.054 us          0.034 us  
Container:  Insert      Find        Next Visite  
Map         0.370 us    3.592 us    0.075 us  
MultiMap    0.388 us    3.873 us    0.104 us  
Set         0.366 us    3.254 us    0.062 us  
MultiSet    0.345 us    3.275 us    0.062 us  
HashMap      0.292 us   0.832 us    0.039 us  
HashMultiMap 0.275 us   0.898 us    0.060 us  
HashSet      0.248 us   0.847 us    0.043 us  
HashMultiSet 0.245 us   0.847 us    0.036 us  
;===============================================================================  

Delphi7=========================================================================  
Container:  PushBack  Next Visite Random Visite Insert At Middle  PushFront  
array       0.170 us  0.005 us    0.078 us      43800.000 us      121800.000 us  
TList       0.023 us  0.013 us    0.125 us      25000.000 us      62400.000 us  
;===============================================================================  
   
STL (VC6 Compile)===============================================================  
Container:  PushBack  Next Visite Random Visite Insert At Middle  PushFront  
vector      0.041 us  0.005 us    0.078 us      31200 us          68800 us  
deque       0.013 us  0.006 us    0.227 us      365600 us         0.012 us  
list        0.169 us  0.022 us    21800 us      0.180 us          0.183 us  
Container:  Insert      Find        Next Visite  
map         0.431 us    3.174 us    0.048 us  
set         0.433 us    3.174 us    0.049 us  
multimap    0.430 us    3.174 us    0.047 us  
multiset    0.427 us    3.174 us    0.048 us  
STL (VC2005 Compile)===============================================================  
vector      0.019 us  0.009 us  0.078 us  62600 us  140600 us  
deque       0.067 us  0.013 us  0.227 us  168800 us  0.061 us  
list        0.269 us  0.017 us  15600 us  0.277 us  0.269 us  
Container:  Insert      Find        Next Visite  
map         2.436 us    4.813 us    0.042 us  
set         2.473 us    4.813 us    0.041 us  
multimap    2.420 us    4.813 us    0.041 us  
multiset    2.416 us    4.813 us    0.041 us  
hash_map    0.888 us    1.501 us    0.207 us  
hash_set    1.378 us    1.453 us    0.207 us  
hash_multimap 1.373 us  1.450 us    0.207 us  
hash_multiset 1.380 us  1.450 us    0.207 us  
  
(SGI)STL (DEV-C++4.98 GCC max optimize Compile)=================================  
Container:  PushBack  Next Visite Random Visite Insert At Middle  PushFront  
vector      0.016 us  0.005 us    0.070 us      34400 us          62400 us  
deque       0.011 us  0.009 us    0.258 us      865600 us         0.013 us  
list        0.047 us  0.014 us    9400 us       0.052 us          0.036 us  
Container:  Insert      Find        Next Visite  
map         0.538 us    3.226 us    0.033 us  
set         0.516 us    3.226 us    0.034 us  
multimap    0.492 us    3.174 us    0.038 us  
multiset    0.495 us    3.994 us    0.039 us  
hash_map    0.145 us    0.701 us    0.043 us  
hash_set    0.234 us    0.650 us    0.044 us  
hash_multimap 0.639 us  0.698 us    0.044 us  
hash_multiset 0.138 us  0.650 us    0.043 us  
;===============================================================================  
  
DCL lib (Delphi7 Compile)=======================================================  
Container:  PushBack  Next Visite Random Visite Insert At Middle  PushFront  
TArrayList  0.013 us  0.030 us    0.157 us      25000.000 us      65600.000 us  
TVector     0.013 us  0.027 us    0.172 us      28200.000 us      62600.000 us  
TLinkedList 0.045 us  0.023 us    5780.000 us   0.052 us          0.081 us  
Container:  Insert      Find        Next Visite  
TBinaryTree 0.473 us    1.125 us    0.086 us  
THashMap    0.422 us    0.860 us    0.075 us(copy Values to TArrayList,it is not ture test!)  
THashSet    0.500 us    0.780 us    "Container.First" is O(N*N) is bad,can not test!  
ps: THashXXX.Create()  
    for I := 0 to FCapacity - 1 do  
      SetLength(FBuckets[I].Entries, 64);) //is bad design, slow and waste memory!  
ps: TLinkedList.Clear() ERROR !!!  
procedure TLinkedList.Clear;  
  .....  
  //ERROR , must add line:  FStart:=nil;  
end;  
;===============================================================================  
  
DeCal lab (Delphi7 Compile)=====================================================  
Container:  PushBack  Next Visite Random Visite Insert At Middle  PushFront  
DArray      0.272 us  0.170 us    0.321 us      53000.000 us      125000.000 us  
DList       0.238 us  0.106 us    13062.000 us  0.198 us          0.188 us  
Container:  Insert      Find        Next Visite  
DSet        2.125 us    6.422 us    0.091 us  
DMultiSet   2.055 us    5.688 us    0.086 us  
DMap        1.993 us    4.921 us    0.081 us  
DMultiMap   1.930 us    5.422 us    0.120 us  
DHashSet    0.946 us    2.406 us    0.974 us  
DMultiHashSet 0.836 us  2.407 us    0.977 us  
DHashMap      1.164 us  2.266 us    0.987 us  
DMultiHashMap 1.063 us  2.172 us    0.922 us  
;===============================================================================  
  
EZDSL lab (Delphi7 Compile)=====================================================  
Container:  PushBack  Next Visite Random Visite Insert At Middle  PushFront  
(TEZCollection is maxsize is N=10922*92 for test! it is small for test.)  
TEZCollection 0.078 us 0.077 us   4.667 us      0.388 us          0.588 us  
TDList      0.175 us  0.039 us    6250.000 us   0.167 us          0.147 us  
TLinkList   0.169 us  0.031 us    13300.000 us  0.180 us          0.159 us  
Container:  Push      Pop  
TQueue      0.141 us  0.150 us  
TStack      0.144 us  0.147 us  
Container:  Insert      Find        Next Visite  
THashTable  1.934 us    2.695 us    (not find way to test!)  
;===============================================================================  
```  
===
by housisong@gmail.com  

