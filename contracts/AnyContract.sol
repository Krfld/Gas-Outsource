// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";
import "./GasOutsource.sol";

contract AnyContract {
    GasOutsource gasOutsourceContract;

    // address consumeGasFrom;

    constructor(address _gasOutsourceAddress, address _consumeGasFrom) {
        uint256 start = gasleft();
        console.log("Start", start);

        gasOutsourceContract = GasOutsource(_gasOutsourceAddress);
        // consumeGasFrom = _consumeGasFromAddress;

        gasOutsourceContract.consume(_consumeGasFrom, start);
    }
}
