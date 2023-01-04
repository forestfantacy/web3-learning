// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

/**
多人筹款
对款项花销投票，票数过半，管理员可以执行下单
*/
contract CrowdRefund {
    mapping(address => uint256) public contributors;
    uint256 public noOfContributors;
    uint256 public minContribution;

    uint256 public startTime;
    uint256 public endTime;

    uint256 public goal;
    uint256 public raisedAmount;

    address public admin;

    struct Request {
        string description;
        address payable recipient;
        uint256 value;
        bool completed;
        uint noOfVotes;
        mapping(address => bool) voters;
    }

    mapping(uint256 => Request) public requests;
    uint256 public numRequests;

    constructor(uint256 _goal, uint256 _deadline) {
        goal = _goal;
        startTime = block.timestamp;
        endTime = startTime + _deadline;

        admin = msg.sender;
        minContribution = 100 wei;
    }

    receive() external payable {
        contribute();
    }

    // 捐款者发起转账，当前合约收到钱，更新全局变量
    function contribute() public payable {
        require(block.timestamp >= startTime && block.timestamp < endTime);
        require(msg.value >= minContribution);

        if (contributors[msg.sender] == 0) {
            noOfContributors++;
        }

        raisedAmount += msg.value;
        contributors[msg.sender] += msg.value;

        //给前端发消息
        emit contributeEvent(msg.sender, msg.value);
    }

    // 查询已筹款金额
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function refund() public payable {
        // require(block.timestamp > endTime);
        require(raisedAmount <= goal);
        require(contributors[msg.sender] > 0, "has money");

        uint256 money = contributors[msg.sender];
        contributors[msg.sender] = 0;
        raisedAmount -= money;

        address payable recipient = payable(msg.sender);
        recipient.transfer(money);
    }

    function createRequest(string memory _description,address payable _recipient,uint _value) public {
        Request storage newRequest = requests[numRequests];
        numRequests++;

        newRequest.description = _description;
        newRequest.recipient = _recipient;
        newRequest.value = _value;

        newRequest.completed = false;
        newRequest.noOfVotes = 0;

        createRequestEvent(_description, _recipient, _value);
    }

    // 捐款者身份,为指定提案投票
    function voteRequest(uint _requestNo) public{
        require(contributors[msg.sender] > 0);
        Request storage thisRequest = requests[_requestNo];

        require(thisRequest.voters[msg.sender] == false);
        thisRequest.voters[msg.sender] = true;
        thisRequest.noOfVotes ++;
    }

    function makePayment(uint _requestNo) public {
        require(admin == msg.sender);
        Request storage thisRequest = requests[_requestNo];
        require(thisRequest.completed == false);
        require(thisRequest.noOfVotes > noOfContributors / 2);

        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.completed = true;

    }

    event contributeEvent(address _sender, uint _value);
    event createRequestEvent(string _description, address _recipient, uint _value);

}
