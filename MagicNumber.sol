Ethernaut - Magic Number Solution
==================================

The target contract requires us to deploy a solver contract that returns the 32-byte value of 42 (0x2a) and is at most 10 bytes long.

We solve this by writing raw EVM Bytecode.

Initialization Bytecode (12 bytes):
600a80600c6000396000f3

Runtime Bytecode (10 bytes):
602a60005260206000f3

Combined Bytecode to Deploy:
0x600a80600c6000396000f3602a60005260206000f3
