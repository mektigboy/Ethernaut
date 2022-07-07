// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "SafeMath.sol";

contract Denial {
    using SafeMath for uint256;
    address public partner; // Withdrawal partner - pay the gas, split the withdraw.
    address payable public constant owner = address(0xA9E);
    uint timeLastWithdrawn;
    mapping(address => uint) withdrawPartnerBalances; // Keep track of balances (partners).

    function setWithdrawPartner(address _partner) public {
        partner = _partner;
    }

    // Withdraw 1% to recipient and 1% to owner.
    function withdraw() public {
        uint amountToSend = address(this).balance.div(100);
        // Perform a call without checking return.
        // The recipient can revert, the owner will still get their share.
        partner.call{value:amountToSend}("");
        owner.transfer(amountToSend);
        // Keep track of last withdrawal time.
        timeLastWithdrawn = now;
        withdrawPartnerBalances[partner] = withdrawPartnerBalances[partner].add(amountToSend);
    }

    // Allow deposit of funds.
    receive() external payable {}

    // Convenience function.
    function contractBalance() public view returns (uint) {
        return address(this).balance;
    }
}
