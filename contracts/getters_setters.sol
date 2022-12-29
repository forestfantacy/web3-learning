// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract gettersetter{

    int public price;
    string location = "London";
    address public owner;

// gas 更低
    int constant area = 100;
    int immutable area1 = 200;
    int immutable area2;

    // constructor(int _price,string memory _location){  int price 报错 creation of gettersetter errored: Error encoding arguments: Error: invalid BigNumber string (argument="value", value="", code=INVALID_ARGUMENT, version=bignumber/5.5.0)
    constructor(string memory _location){
        // price = _price;
        location = _location;
        owner = msg.sender;
        area2 = 300;
    }

    function setPrice(int _price) public {
        price = _price;
    }

// get方法不改变状态，view 一下，如果状态变量本身是public，没有必要单独申明get函数，
    function getPrice() public view returns (int){
        return price;
    }
}

//0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
//0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db