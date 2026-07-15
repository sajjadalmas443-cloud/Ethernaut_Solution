---

## 3. Elevator Solution
**Vulnerability Type:** Interface Trust & State Manipulation

### Analysis
The contract trusts an external interface implementation without verifying the calling contract's behavior. By implementing a malicious `isLastFloor()` function that returns `false` on the first internal call (to bypass the `if` check) and `true` on the second call, we manipulate the state to reach the top floor successfully.