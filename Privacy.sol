// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Privacy {
    // Slot 0 - 1 byte
    bool public locked = true;
    // Slot 1 - 32 bytes
    uint256 public ID = block.timestamp;
    // Slot 2 - 8 bits
    uint8 private flattening = 10;
    // Slot 2 - 8 bits
    uint8 private denomination = 255;
    // Slot 2 - 16 bits
    uint16 private awkwardness = uint16(now); // <now> should be <block.timestamp>, since <now> has been deprecated.
    // Slot 3, 4, 5 - 32 bytes each
    bytes32[3] private data;

    constructor(bytes32[3] memory _data) public {
        data = _data;
    }

    function unlock(bytes16 _key) public {
        // The answer is slot 5, reason being is...
        // [3] starts from 0, making the below [2] actually three.
        require(_key == bytes16(data[2]));
        locked = false;
    }
}
