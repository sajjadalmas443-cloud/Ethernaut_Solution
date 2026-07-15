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

---

## 5. Gatekeeper One Solution
**Vulnerability Type:** Cryptographic Bit Masking & Precise Gas Estimation

### Analysis
Bypassed three distinct modifiers:
* **Gate 1:** Used an intermediary exploit contract so that `msg.sender != tx.origin`.
* **Gate 2:** Calibrated the exact transaction gas limit to be a precise multiple of `8191`.
* **Gate 3:** Created a specific bitwise mask using `bytes8 gateKey = bytes8(uint64(uint160(tx.origin))) & 0xFFFFFFFF0000FFFF;` to satisfy the casting requirements.

---

## 6. Gatekeeper Two Solution
**Vulnerability Type:** Extcodesize Bypass & Bitwise XOR Operations

### Analysis
* **Gate 1 & 2:** Bypassed the assembly `extcodesize` check by executing the attack logic entirely within our contract's `constructor`, where code size is still `0`.
* **Gate 3:** Solved the mathematical equation using bitwise XOR (`^`) properties to calculate the correct `gateKey` value.

---

## 7. Naught Coin Solution
**Vulnerability Type:** ERC20 Interface Standard Bypass

### Analysis
The contract locks the custom `transfer` function for 10 years, but inherits the full OpenZeppelin ERC20 standard. We bypass this lock by calling the standard `approve` function to allow our attack contract to move the tokens, and then calling `transferFrom` from our attack contract to drain the wallet balance.

---

## 8. Preservation Solution
**Vulnerability Type:** Delegatecall Storage Collision

### Analysis
The target contract executes `delegatecall` to dynamic library addresses stored in slot `0` and slot `1`. By deploying a malicious contract with a matching state storage layout, we manipulate the library address variables to point to our exploit contract, allowing us to hijack control flow and overwrite the `owner` state variable.

---

## 9. Magic Number Solution
**Vulnerability Type:** EVM Bytecode & Huffman Coding Optimization

### Analysis
Created and deployed a raw EVM runtime bytecode payload (`602a60005260206000f3`) that returns the 32-byte value of `42` under 10 bytes size limit, bypassing high-level Solidity contract overhead.
