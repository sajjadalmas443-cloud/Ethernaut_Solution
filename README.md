# Ethernaut Smart Contract Security Solutions

This repository contains my practical solutions, code implementations, and exploit contracts for various levels of OpenZeppelin's Ethernaut CTF challenge.

---

## 1. Alien Codex Solution
**Vulnerability Type:** Storage Manipulation & Array Underflow

### Analysis
The contract relies on the Solidity `0.5.0` layout, where dynamic arrays can underflow. By executing the `retract()` function on an empty array, we trigger an **array length underflow** ($0 - 1 = 2^{256} - 1$). This grants total access to the entire contract storage slots, allowing us to accurately locate and overwrite slot `0` where the `owner` variable resides.

---

## 2. Re-entrancy Solution
**Vulnerability Type:** External Call Execution Flow (Re-entrancy)

### Analysis
The target contract checks the user's balance but updates its state *after* transferring the funds (`msg.sender.call{value: _amount}("")`). By using a malicious contract with a custom `receive()` fallback function, we intercept the execution flow and call `withdraw()` repeatedly before the original contract can deduct our balance, draining its entire fund pool.
