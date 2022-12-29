// SPDX-License-Identifier: GPL-3.0


pragma solidity >=0.5.0 <0.9.0;

contract globalvar1{

    address public owner;
    uint public sendValue;

    constructor(){
        owner = msg.sender;
    }

    function changeOwner() public{
        owner = msg.sender;
    }

    function snedEther() public payable{
        sendValue = msg.value;
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function howmuchGas() public view returns(uint){
        uint start = gasleft();
        uint j = 1;
        for(uint i=1; i< 20; i++){
            j *= i;
        }
        uint end = gasleft();

        // return end - start;  err
        return start - end;
    }
}