// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

/**
a b c 下游 二级供应商 一级供应商

b 要给c付钱，但自己没钱，于是b要a给c付钱，事先跟a商量好，并且a有b的债务

0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
*/

interface ERC20Interface{

    function totalSupply() external view returns (uint);
    function balanceOf(address tokenOwner) external view returns(uint balance);
    function transfer(address to, uint tokens) external returns(bool success);

    function allowance(address tokenOwner, address spender) external view returns(uint remaining);
    function approve(address spender, uint tokens) external returns(bool success);
    function transferFrom(address from, address to, uint tokens) external returns(bool success);

    event Transfer(address indexed from,address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);

}

contract Crytos is ERC20Interface{

    string public name = "khan";
    string public symbol = "CRPT";
    uint public decimals = 0;
    uint public override totalSupply;

    address public founder;
    mapping(address => uint) public balances;
    //balances[0x1111..] = 100;

    //代币持有者 =》 
    mapping(address => mapping(address => uint)) allowed;
    // aaa持有150个代币，
    // aaa allows bbb...100
    // aaa allows ccc...50

    constructor(){
        totalSupply = 1000000;
        founder = msg.sender;
        balances[founder] = totalSupply;
    }

    function balanceOf(address tokenOwner) public view override returns(uint balance){
        return balances[tokenOwner];
    }

    /**
    代币转账  把自己的代币直接转给收款方
    */
    function transfer(address to, uint tokens) public override returns(bool success){
        require(balances[msg.sender] >= tokens);

        balances[to] += tokens;
        balances[msg.sender] -= tokens;
        emit Transfer(msg.sender,to,tokens);

        return true;
    }

    /**
    查询债权配额（谁调都一样） tokenOwner债务方  spender 债权方
    */
    function allowance(address tokenOwner, address spender) view public override returns(uint){
            return allowed[tokenOwner][spender];
    }

    /**
    债权人调用，授权债务人转债额度
    */
    function approve(address spender, uint tokens) public override returns (bool success){
        require(balances[msg.sender] >= tokens);
        require(tokens > 0);

        allowed[msg.sender][spender] = tokens;

        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    /**
    债权方调用：把债务方的钱转到指定收款方
    */
    function transferFrom(address from, address to, uint tokens) override external returns(bool success){
        //
        require(allowed[from][msg.sender] >= tokens);
        //
        require(balances[from] >= tokens);

        //代币转账  
        balances[from] -= tokens;
        balances[to] += tokens;

        //配额？？
        allowed[from][msg.sender] -= tokens;


        emit Transfer(from, to, tokens);
        return true;
    }
}