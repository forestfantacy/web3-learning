// SPDX-License-Identifier: GPL-3.0


pragma solidity >=0.5.0 <0.9.0;

contract fixsizearr{

    uint[3] public numbers;
    uint[3] public numbers1 = [2,3,4];

    bytes1 public b1;
    bytes2 public b2;
    bytes3 public b3;

    function setData(uint index,uint number) public{
        numbers[index] = number;
    }

    function getLength() public view returns(uint){
        return numbers.length;
    }


    function setBytesArrData() public{
        b1 = 'a';
        b2 = 'ab';
        b3 = 'abc';
        // b3 = 'z';
        // b3[1] = 'z';
    }
}