// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "hardhat/console.sol";

contract MyTransfernft is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("MyToken", "MTK") {}

    function safeMint(address to, string memory uri) public onlyOwner {
        console.log("test to ${lock.address}");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}

contract ABC is IERC721Receiver {
    function transfer(
        address token,
        address to,
        uint256 tokenId
    ) public {
        IERC721(token).safeTransferFrom(address(this), to, tokenId);
    }

    function getBal()public view returns(uint){
        return address(this).balance;// 怎么查看转进来的代币，这里并没有tokenId的存储空间？？
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external override returns (bytes4) {
        console.log("test IERC721 Receiver to %s,tokenId [%s],operator [%s],data [%s]", from, tokenId,operator);
        return
            bytes4(
                keccak256("onERC721Received(address,address,uint256,bytes)")
            );
    }
}

//0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,0xEc29164D68c4992cEdd1D386118A47143fdcF142,0

// 0x838F9b8228a5C95a7c431bcDAb58E289f5D2A4DC,0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db,2

