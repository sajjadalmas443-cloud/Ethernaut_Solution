---

## 5. Gatekeeper One Solution
**Vulnerability Type:** Cryptographic Bit Masking & Precise Gas Estimation

### Analysis
This level requires bypassing three distinct modifiers (gates). 
* **Gate 1:** Bypassed by using an intermediary exploit contract so that `msg.sender != tx.origin`.
* **Gate 2:** Requires the remaining gas to be an exact multiple of `8191`. This is solved via off-chain gas estimation or an on-chain brute-force loop.
* **Gate 3:** Bypassed using precise bitwise masks. By masking the `tx.origin` address with `bytes8 gateKey = bytes8(uint64(uint160(tx.origin))) & 0xFFFFFFFF0000FFFF;`, we satisfy all data type casting requirements.
*
