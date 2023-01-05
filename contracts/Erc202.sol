// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**

0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 aaa deploy(200个) founder aaa 
0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 bbb 
0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB ccc

*/
contract MyToken is ERC20, Ownable {
    constructor(uint tokenAmount) ERC20("MyToken20", "MTK") {
        _mint(msg.sender, tokenAmount * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
// 发行方执行,确认bbb债务金额
// 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,80000000000000000000
// 查看确认结果 
//0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2    //80

// b执行 把a的债务中转移5个ether到c
//0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB,5000000000000000000

// 查询c的余额 5
// a的余额 195
// 查询a对b的债务
//0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2    //75
