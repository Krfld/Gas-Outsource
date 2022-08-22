// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";
import "./GasOutsource.sol";

contract AnyContract {
    GasOutsource gasOutsourceContract;

    // address consumeGasFrom;

    constructor(address _gasOutsourceAddress, address _consumeGasFrom) {
        gasOutsourceContract = GasOutsource(_gasOutsourceAddress);
        // consumeGasFrom = _consumeGasFromAddress;

        console.log(gasleft());

        gasOutsourceContract.consume(_consumeGasFrom, gasleft());

        console.log(gasleft());
    }
}
