// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Token{

    event Transfer(address _to, uint _value);

    function transfer(address payable _to, uint _value) public{

        emit Transfer(_to, _value);
    }
}