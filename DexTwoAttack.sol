// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC20.sol";

contract  DexTwoAttack {
    constructor () public ERC20("EvilToken", "EVIL") {
        _mint(msg.sender, 1000000 * (10 ** uint256(decimals())));
    }
}
