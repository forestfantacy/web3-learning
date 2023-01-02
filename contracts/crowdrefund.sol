// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract CrowdRefund {
    mapping(address => uint256) public contributors;
    uint256 public noOfContributors;
    uint256 public minContribution;

    uint256 public startTime;
    uint256 public endTime;

    uint256 public goal;
    uint256 public raisedAmount;

    address public admin;

    constructor(uint256 _goal, uint256 _deadline) {
        goal = _goal;
        startTime = block.timestamp;
        endTime = startTime + _deadline;

        admin = msg.sender;
        minContribution = 100 wei;
    }

    receive() external payable {
        doRefund();
    }

    // 捐款者发起转账，当前合约收到钱，更新全局变量
    function doRefund() public payable {
        require(block.timestamp >= startTime && block.timestamp < endTime);
        require(msg.value >= minContribution);

        if (contributors[msg.sender] == 0) {
            noOfContributors++;
        }

        raisedAmount += msg.value;
        contributors[msg.sender] += msg.value;
    }

    // 查询已筹款金额
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
