// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";

contract GasOutsource {
    mapping(address => mapping(address => uint256)) public funds;

    modifier onlyOrigin() {
        require(tx.origin == msg.sender, "Not allowed");
        _;
    }

    constructor() payable {}

    function deposit(address _to) external payable onlyOrigin {
        funds[msg.sender][_to] += msg.value;
    }

    function withdraw(address _from) external onlyOrigin {
        uint256 amount = funds[msg.sender][_from];
        require(amount > 0, "Not enough to withdraw");
        funds[msg.sender][_from] = 0;
        payable(msg.sender).transfer(amount);
    }

    function consume(address _from, uint256 _amount) external onlyOrigin {
        uint256 amount = funds[_from][msg.sender];
        require(amount >= _amount, "Not enough to consume");
        funds[_from][msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }
}
