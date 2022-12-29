// SPDX-License-Identifier: GPL-3.0


pragma solidity >=0.5.0 <0.9.0;

contract dynamicarry{

    uint[] public numbers;

    function getLength() public view returns(uint){
        return numbers.length;
    }

    function addEle(uint item) public{
        numbers.push(item);
    }

    function getEle(uint index) public view returns(uint){
        if(index < numbers.length){
            return numbers[index];
        }
        return 0;
    }

    function popEle() public{
        return numbers.pop();
    }

    function f() public pure{
    // unction f() public pure{
        uint[] memory y = new uint[](3);
        y[0] = 11;
        y[1] = 22;
        // numbers = y;   pure 是啥意思？
    }
}