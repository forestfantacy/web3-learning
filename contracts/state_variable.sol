// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract StateVariable{

    //状态变量
    int public price;

    //修改状态变量有3中方法：申明时指定、构造函数、setter
    // int public price1 = 100;

    //常量必须初始化
    string constant public location = "BeiJing";

    // price = 111;

    function f1() public pure returns(int){
        int x = 5;
        x = x + 2;

        //string 需要显示声明 memory，否则编译器报错,一共4种引用类型 string array struct mapping
        // string s1 = "abc";  error
        string memory s1 = "abc";


        return x;
    }
}