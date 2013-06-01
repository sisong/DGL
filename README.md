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
  DGL库的实现克服了这些问题，库能够支持几乎所有基本类型、指针(包括类的指针)、Interface、结构(record)、Object结构(Delphi中已经不推荐使用)、类成员函数指针、类(class)的值语义(一般Delphi中不习惯使用类的值语义，所以不建议使用)等其它用户自定义类型，并且类型安全! 速度当然也没有问题,与C++的各种STL比也不差! (性能对比测试见: http://blog.csdn.net/housisong/article/details/1331993 )

===
by housisong@gmail.com  

