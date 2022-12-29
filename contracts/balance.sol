// SPDX-License-Identifier: GPL-3.0


pragma solidity ^0.7.0;

/**
TODO EOA 给这个合约转账，必须定义receivee fallback 参数，背后的设计师什么？转进来的钱怎么转出去？
*/
contract balance{

    address owner;

    constructor(){
        owner = msg.sender;
    }

    receive() external payable{
        log1(bytes32(uint256(msg.sender)),bytes32("receive"));
    }

    fallback() external payable{
        log1(bytes32(uint256(msg.sender)),bytes32("fallback"));
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function send2otherMoney() public payable{
        uint x;
        x++;
    }

    //把当前合约的钱转出去
    function transferout(address payable recipient, uint amount) public returns(bool){

        require(owner == msg.sender,"transfer failed,you are not the contract owner");

        if(amount <= getBalance()){
            recipient.transfer(amount);
            return true;
        }else{
            return false;
        }
    }
}