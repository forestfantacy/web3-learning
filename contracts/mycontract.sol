// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;

contract HelloWorld{

    uint public value;

    function setValue(uint _value) public{
        value = _value;
    }
}