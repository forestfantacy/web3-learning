// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/**
转账场景，接受者是个合约，需要显示payable，否则不能接受发起方转账，有1个例外：发起者自毁
*/
contract Receiver {
    event Received(address caller, uint256 amount, string message);

// 调用者没有payload回调
    receive() external payable {
        emit Received(msg.sender, msg.value, "receive was called");
    }

// 调用者带有payload时回调
    fallback() external payable{
        emit Received(msg.sender, msg.value, "fallback was called");
    }

// 定义带有参数的接受转账的方法
    function foo(string memory message, uint256 _y) public payable returns(uint){
      emit Received(msg.sender, msg.value, message);
      return _y;
    }

    function getAddress() public view returns (address) {
        return address(this);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

contract caller {
    Receiver receiver;

    constructor() {
        receiver = new Receiver();//部署Receiver合约
    }

    event Responsed(bool sucess, bytes data);

    function testCall(address payable _to,uint256 _y) public payable {
        // (bool success, bytes memory data) = _to.call{value: msg.value}("abc");
        // 调用带参数的方法，类似于反射调用
        (bool success, bytes memory data) = _to.call{value: msg.value}(abi.encodeWithSignature("foo(string,uint256)","call foo",_y));
        emit Responsed(success, data);
    }

    // 暴露Receiver的地址
    function getAddress() public view returns (address) {
        return receiver.getAddress();
    }

    // 暴露Receiver的余额
    function getBalance() public view returns (uint256) {
        return receiver.getBalance();
    }
}
