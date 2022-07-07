// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract MagicNumber {
    address public solver;

    constructor() public {}

    function setSolver(address _solver) public {
        solver = _solver;
    }
}
