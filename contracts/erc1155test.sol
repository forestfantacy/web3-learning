// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
测试功能

*/
contract MyToken1155 is ERC1155, Ownable {

    uint256 public constant TOKEN_A = 0;
    uint256 public constant TOKEN_B = 1;
    uint256 public constant TOKEN_C = 2;

    constructor() ERC1155("https://my1155.com/{id}.json") {
        mint(msg.sender,TOKEN_A,10,"");
        mint(msg.sender,TOKEN_B,100,"");
        mint(msg.sender,TOKEN_C,1000,"");
    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data)public onlyOwner
    {
        _mint(account, id, amount, data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)public onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }
}