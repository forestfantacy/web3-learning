// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**

0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 deploy founder aaa 8
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

//0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB,4000000000000000000

//0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2