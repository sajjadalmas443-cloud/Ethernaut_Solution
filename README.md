## Ethernaut - Alien Codex Solution

This repository contains my practical solution and exploit contract for the **Alien Codex** level from OpenZeppelin's Ethernaut.

### Vulnerability Analysis
The contract relies on Solidity `0.5.0` layout, where dynamic arrays can overflow or underflow. By executing a `retract()` function on an empty array, we trigger an **array length underflow** ($0 - 1 = 2^{256} - 1$). This grants total access to the entire contract storage, allowing us to overwrite the slot `0` where the `owner` variable resides.

### How to Use
1. Copy `AlienCodexAttack.sol` into Remix IDE.
2. Deploy the attack contract passing the Ethernaut instance address.
3. Call the `attack()` function to claim ownership.
4.
