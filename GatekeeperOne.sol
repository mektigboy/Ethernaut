// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "SafeMath.sol";

contract GatekeeperOne {
    using SafeMath for uint256;
    address public entrant;
    // Include the line below, in recent Solidity versions casting an address into uints is unabled.
    uint256 i = uint256(uint160(address(tx.origin)));

    modifier gateOne() {
        require(msg.sender != tx.origin);
        _;
    }

    // The modulo of 8191 (gas left) has to be 0.
    modifier gateTwo() {
        require(gasleft().mod(8191) == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
        require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
        // require(uint32(uint64(_gateKey)) == uint16(tx.origin), "GatekeeperOne: invalid gateThree part three");
        require(uint32(uint64(_gateKey)) == uint16(i), "GatekeeperOne: invalid gateThree part three");
        _;
    }

    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}
