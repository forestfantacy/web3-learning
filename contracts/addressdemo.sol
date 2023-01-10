
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract AddressDemo{

    address owner;

    constructor(){
        owner = msg.sender;
    }

    //this 表示当前只能合约
    function getThisAddr()public view returns (address){
        return address(this);
    }

    //调用这个函数的客户端地址
    function getSender() public view returns(address){
        return msg.sender;
    }

    //部署这个智能合约的账号地址，在部署时存下来了
    function getContracteOwner() public view returns(address){
        return owner;
    }

    function getBalance()public view returns(uint,uint,uint){
        uint contractBalance = address(this).balance;
        uint clientBalance = msg.sender.balance;
        uint ownerBalance = owner.balance;
        return (contractBalance,clientBalance,ownerBalance);
    }

}