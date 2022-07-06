// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "SafeMath.sol";

contract Recovery {
    // Generate tokens.
    function generateToken(string memory _name, uint256 _initialSupply) public {
        new SimpleToken(_name, msg.sender, _initialSupply);

    }
}

contract SimpleToken {
    using SafeMath for uint256;
    // Public variables.
    string public name;
    mapping (address => uint) public balances;

    // Constructor
    constructor(string memory _name, address _creator, uint256 _initialSupply) public {
        name = _name;
        balances[_creator] = _initialSupply;
    }

    // Collect ether in return for tokens.
    receive() external payable {
        balances[msg.sender] = msg.value.mul(10);
    }

    // Allow transfers of tokens.
    function transfer(address _to, uint _amount) public {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] = balances[msg.sender].sub(_amount);
        balances[_to] = _amount;
    }

    // Clean up after ourselves.
    function destroy(address payable _to) public {
        selfdestruct(_to);
    }
}
