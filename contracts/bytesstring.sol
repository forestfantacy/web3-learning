// SPDX-License-Identifier: GPL-3.0


pragma solidity >=0.5.0 <0.9.0;


contract bytestring{


    bytes public b1 = 'abc';//0x616263

    string public s1 = 'abc';//abc

    function addEle() public{
        b1.push('x');
        // s1.push('y'); error 
    }

    function getEle(uint i) public view returns(bytes1){
        return b1[i]; //0x62
    }

    function getLength() public view returns(uint){
        return b1.length;
    }
}