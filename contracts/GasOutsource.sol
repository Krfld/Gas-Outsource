// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "hardhat/console.sol";

contract GasOutsource {
    mapping(address => mapping(address => uint256)) public funds;

    constructor() {}

    function deposit(address _to) external payable {
        require(_to != msg.sender, "Can't deposit to the same address");
        require(msg.value > 0, "Not enough to deposit");
        funds[msg.sender][_to] += msg.value;
    }

    function withdraw(address _from) external {
        uint256 amount = funds[msg.sender][_from];
        require(amount > 0, "Not enough to withdraw");
        funds[msg.sender][_from] = 0;
        payable(msg.sender).transfer(amount);
    }

    function consume(address _from, uint256 _amount) external {
        require(_amount <= funds[_from][tx.origin], "Not enough to consume");
        funds[_from][tx.origin] -= _amount;
        payable(tx.origin).transfer(_amount * tx.gasprice);
    }
}
