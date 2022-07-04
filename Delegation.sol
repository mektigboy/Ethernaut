// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Delegate {
    address public owner;

    constructor(address _owner) public {
        owner = _owner;
    }

    function pwn() public {
        owner = msg.sender;
    }
}

contract Delegation {
    address public owner;
    Delegate delegate;

    constructor(address _delegateAddress) public {
        delegate = Delegate(_delegateAddress);
        owner = msg.sender;
    }

    // Take advantage of this fallback via <sendTransaction>.
    fallback() external {
        (bool result, ) = address(delegate).delegatecall(msg.data);
        if (result) {
            this; // <this> instance of the contract.
        }
    }
}
