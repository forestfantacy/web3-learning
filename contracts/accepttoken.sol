
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AcceptToken{


    IERC20 myToken;
    address owner;

    constructor(address _token){
        myToken = IERC20(_token);
        owner = msg.sender;
    }

    // 把客户端调用者的代币转到指定地址，
    function transferOutFormToken2(address _to, uint _amount) public payable{
        myToken.transferFrom(msg.sender, _to, _amount);
    }

    function getBalanceOfMyToken(address addr)public view returns(uint){
        return myToken.balanceOf(addr);
    }

    // 摧毁创建者地址
    function destr()public {
        myToken.transfer(owner,myToken.balanceOf(address(this)));
        selfdestruct(payable(owner));
    }
}

contract TestToekn is ERC20{

    // 为部署代币合约的地址铸币：注入n个代币
     constructor() ERC20("MyTestToken","$$@"){
         _mint(msg.sender, 1000 * 10 ** decimals());
     }
}