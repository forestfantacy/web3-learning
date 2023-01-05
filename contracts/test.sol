// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Test is ERC20 {
    uint256 public money = 1;

    constructor(uint256 tokenAmount) ERC20("MyToken20", "MTK") {
        //_mint(msg.sender, tokenAmount ** decimals());
    }

    function go(uint256 param) public view returns (uint256) {
        uint256 money2 = param * 10**decimals();
        return money2;
    }

    function go2(uint256 param) public pure returns (uint256) {
        return param;
    }
}
