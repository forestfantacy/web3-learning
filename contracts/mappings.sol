// SPDX-License-Identifier: GPL-3.0


pragma solidity >=0.5.0 <0.9.0;

contract Auction{

    mapping(address => uint) public bids;

    function bid() payable public{ //接受转账需要payable关键字
        bids[msg.sender] = msg.value;
    }

    // function getBalance() public view returns(int){
    //     // return bids[msg.sender];
    // }
}