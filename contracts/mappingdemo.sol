
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract mappingdemo{


    mapping(address => uint) allBalances;

    function getBal(address addr)public view returns(uint){
        return allBalances[addr];
    }

    function setBal(address addr)public payable{
        allBalances[addr] = msg.value;
    }

    function rem(address addr)public {
        delete allBalances[addr];
    }
}