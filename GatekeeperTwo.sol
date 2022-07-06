// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract GatekeeperTwo {
    address public entrant;

    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        uint x;
        // <extcodesize> = get the size of a contract's code at a given address.
        // Pass this check by calling <enter> function inside the constructor, faking our real size.
        assembly { x := extcodesize(caller()) }
        require(x == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        // XOR = ^
        // XOR -> When comparing to binary digits, if either one differs, then it will be 1.
        require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == uint64(0) - 1);
        // uint64 0 - 1 = -1 (binary 1111 or HEX FF -> across the board)
        _;
    }

    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}
