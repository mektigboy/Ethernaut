// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Preservation {

    // public library contracts
    address public timeZone1Library; // Slot 0
    address public timeZone2Library; // Slot 1
    address public owner; // Slot 2
    uint storedTime; // Slot 3
    // Sets the function signature for <delegatecall>.
    bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

    constructor(address _timeZone1LibraryAddress, address _timeZone2LibraryAddress) public {
        timeZone1Library = _timeZone1LibraryAddress;
        timeZone2Library = _timeZone2LibraryAddress;
        owner = msg.sender;
    }

    // Set the time for timezone 1.
    function setFirstTime(uint _timeStamp) public {
        timeZone1Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
    }

    // Set the time for timezone 2.
    function setSecondTime(uint _timeStamp) public {
        timeZone2Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
    }
}

// Simple library contract to set the time.
contract LibraryContract {

    // Stores a timestamp.
    uint storedTime;

    function setTime(uint _time) public {
        storedTime = _time;
    }
}
