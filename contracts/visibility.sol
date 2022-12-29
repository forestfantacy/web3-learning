// SPDX-License-Identifier: GPL-3.0


pragma solidity ^0.7.0;

contract visibility{

    int public x = 10;

    int y = 20;

    int z = 30;


    function getY() public view returns(int){
        return y;
    }

    function f1() private view returns(int){
        return z;
    }

    function f2() public view returns(int){
        int a;
        a = f1();
        return a;
    }

    function f3() internal view returns(int){
        return x;
    }

    function f4() external view returns(int){
        return x;
    }

    function f5() public pure returns(int){
        int b;
        // b = f4(); 内部无法调用，只能从外部 
        return b;
    }
}

contract SubVisi is visibility{
    int public xx = f3();
    // int pubilc yy = f1(); 无法调用父类的私有函数
    // int pubilc yy = f4(); 无法调用
}

contract c{
    visibility public v = new visibility();
    int public xx = v.f4();
}