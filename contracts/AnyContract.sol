// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "hardhat/console.sol";
import "./GasOutsource.sol";

contract AnyContract {
    GasOutsource gasOutsourceContract;

    // address consumeGasFrom;

    uint256 dummy = 0;

    constructor(address _gasOutsourceAddress, address _consumeGasFrom) {
        uint256 gas = gasleft();

        gasOutsourceContract = GasOutsource(_gasOutsourceAddress);
        // consumeGasFrom = _consumeGasFromAddress;

        for (uint256 i = 0; i < 10; i++) dummy++;

        gasOutsourceContract.consume(_consumeGasFrom, gas);
    }
}
