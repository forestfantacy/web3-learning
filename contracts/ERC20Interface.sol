// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/Strings.sol";

/**
a b c 下游 二级供应商 一级供应商

b 要给c付钱，但自己没钱，于是b要a给c付钱，事先跟a商量好，并且a有b的债务

0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 deploy
0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 deposit
0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db invest1
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
    function transfer(address to, uint tokens) public virtual override returns(bool success){
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
    function transferFrom(address from, address to, uint tokens)public virtual override returns(bool success){
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


contract CrytisICO is Crytos{

    address public admin;
    address payable public deposit;
    uint tokenPrice = 0.001 ether;
    uint public hardCap = 300 ether;
    uint public raisedAmount;
    uint public saleStart = block.timestamp;
    uint public saleEnd = block.timestamp + 604800;
    uint public tokenTradeStart = saleEnd + 604800;
    uint public maxInvestment = 5 ether;
    uint public minInvestment = 0.1 ether;

    enum State{beforeStart, running, afterEnd, halted}
    State public icoState;

    constructor(address payable _deposit){
        deposit = _deposit;
        admin = msg.sender;
        icoState = State.beforeStart;
    }
    
    modifier onlyAdmin(){
        require(msg.sender == admin);
        _;
    }

    function halt() public onlyAdmin{
        icoState = State.halted;
    }

    function resume() public onlyAdmin{
        icoState = State.running;
    }

    function changeDeposiAddress(address payable newDeposit) public onlyAdmin{
        deposit = newDeposit;
    }

    function getCurrentState() public view returns(State){
        if(icoState == State.halted){
            return State.halted;
        }else if(block.timestamp < saleStart){
            return State.beforeStart;
        }else if(block.timestamp >= saleStart && block.timestamp <= saleEnd){
            return State.running;
        }else{
            return State.afterEnd;
        }
    }

    event Invest(address investor, uint value, uint tokens);

    event logDetail(address _owner,string detail);

    /**
        投资方调用
        更新已收款金额，按照代币价格计算代币数量，更新投资方和发起人的代币余额，将收款转到存款专用账户
    */
    function invest() payable public returns(bool){
        emit logDetail(msg.sender, "test log...");

        icoState = getCurrentState();
        require(icoState == State.running ,"must running");

        require(msg.value >= minInvestment && msg.value <= maxInvestment , "invest value is not ok");
        raisedAmount += msg.value;
        require(raisedAmount <= hardCap, "raisedAmount is not ok");

        uint tokens = msg.value / tokenPrice;

        string memory str = string(abi.encodePacked("tokens...", Strings.toString(tokens)));
        emit logDetail(msg.sender, str);

        balances[msg.sender] += tokens;
        balances[founder] -= tokens;
        deposit.transfer(msg.value);
        emit Invest(msg.sender, msg.value, tokens);

        return true;
    }

    receive() payable external{
        invest();
    }

    //转账
    function transfer(address to, uint tokens) public override returns(bool success){
        require(block.timestamp > tokenTradeStart);
        Crytos.transfer(to, tokens);// super.transfer(to, tokens);
        return true;
    }

    function transferFrom(address from, address to, uint tokens) public override returns(bool success){
        require(block.timestamp > tokenTradeStart);
        Crytos.transferFrom(from, to, tokens);
        return true;
    }

    function burn() public returns(bool){
        icoState = State.afterEnd;
        balances[founder] = 0;
        return true;
    }
}