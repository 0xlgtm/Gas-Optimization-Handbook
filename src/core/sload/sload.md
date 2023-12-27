# SLOAD

## Source

- [ColdVsWarm.sol](./ColdVsWarm.sol)
- [ColdVsWarm.t.sol](../../../test/ColdVsWarm.t.sol)

## How It Works

Given the index to some position in a contract's storage, the `SLOAD` opcode is used to retrieve the 32-bytes word located at that slot. For example, the ERC20 `balanceOf()` function executes one `SLOAD` operation to retrieve a user's balance. Unlike other opcodes with a fixed gas price, the `SLOAD` opcode has a dynamic pricing model as follows:

- 2,100 gas for a cold access
- 100 gas for a warm access

A cold `SLOAD` is 20 times more costly than a warm `SLOAD` so it is important to understand the distinction between a cold and a warm access if we want to take advantage of this.

### Cold Access vs. Warm Access

Before a transaction execution begins, an empty set called the `accessed_storage_keys` is initialized. Whenever a storage slot of a contract is accessed, the `(address, storage_key)` pair is first check against the `accessed_storage_keys` set. If it is present in the set, it is classified as a warm access. Conversely, if it is not present, it is categorized as a cold access.

```solidity
pragma solidity 0.8.22;

contract ColdAccess {
    uint256 x = 1;

    function getX() public view returns (uint256 a) {
        a = x;
    }
}

contract ColdAndWarmAccess {
    uint256 x = 1;

    function getX() public view returns (uint256 a) {
        a = x;
        a = a + x;
    }
}
```

The code snippet above contains two almost identical contracts. The main difference lies in the `getX()` function of the `ColdAndWarmAccess` contract, which executes two `SLOAD` calls to storage slot 0.

The first `SLOAD` for every `(address, storage_key)` pair is always a cold access because the pair has yet to be added to the `accessed_storage_keys` set. Subsequent access to the same pair is considered a warm access. Since the second `getX()` function executes an additional `SLOAD`, we can expect the difference in gas costs between the two functions to be at least 100 gas*.

This can be verified by generating a gas report using the `forge test` command with the `--gas-report` flag i.e. `forge test --match-contract ColdVsWarmTest --gas-report`. Executing this command reveals a gas cost of 2,246 and 2,353 respectively. As expected, the `getX()` function of the ColdAndWarmAccess contract costs 107 gas more!

---
\* <sub>The difference cannot be exactly 100 gas as additional operations are required e.g. reordering the stack.</sub>