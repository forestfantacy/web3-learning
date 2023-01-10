
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract TransferMoney{


    function send(address payable _to)public payable{
        bool isSucc = _to.send(msg.value);
        require(isSucc,"send fail");
    }

    function transfer(address payable _to) public payable{
        _to.transfer(msg.value);
    }

    function call(address payable _to) public payable{
        (bool isSend,) = _to.call{value:msg.value}("");
        require(isSend,"send fail");
    }
}

//0x617F2E2fD72FD9D5503197092aC168c91465E7f2