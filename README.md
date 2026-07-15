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
---

## 3. Elevator Solution
**Vulnerability Type:** Interface Trust & State Manipulation

### Analysis
The contract trusts an external interface implementation without verifying the calling contract's behavior. By implementing a malicious `isLastFloor()` function that returns `false` on the first internal call (to bypass the `if` check) and `true` on the second call, we manipulate the state to reach the top floor successfully.
---

## 4. Privacy Solution
**Vulnerability Type:** Information Disclosure & Storage Layout Reading

### Analysis
State variables marked as `private` in Solidity are only restricted from being accessed by other smart contracts, but their data is fully visible on the public blockchain. By analyzing the contract's storage layout (taking variable packaging into account) and reading the storage slot `5` off-chain, we extract the 32-byte key, cast it to `bytes16`, and call `unlock()` to solve the level.
