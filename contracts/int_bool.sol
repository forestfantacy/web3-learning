// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.5.0;


// pragma solidity >=0.5.0 <0.9.0;

contract int_bool{

    bool public done;

    uint8 public num = 255;

    function f1() public view returns(int){
        //报错并回滚到255，The transaction has been reverted to the initial state.
        return num+1;
    }
}