# SSTORE

## Source

- [SstoreCost.sol](./SstoreCost.sol)
- [SstoreCost.t.sol](../../../test/SstoreCost.t.sol)

## Prerequisite Knowledge

- [opcodes](../opcodes/README.md)
- [SLOAD](../sload/README.md)

## How It Works

The `SSTORE` is the opcode used for modifying a blockchain state. Whenever a function wants to update the storage of a contract, an `SSTORE` opcode is executed. For example, the `transfer()` function in ERC20 executes two `SSTORE` operations to update the balances of both the sender and the recipient.

The gas cost of `SSTORE` can be derived from this [algorithm](https://github.com/wolflo/evm-opcodes/blob/main/gas.md#a7-sstore). To summarize briefly, the key points are:

- A storage update from zero to a non-zero value costs 22,100 gas*.
- A storage update from a non-zero value to the same value costs 2,200 gas*.
- A storage update from a non-zero value to a different non-zero value costs 5,000 gas*.
- All subsequent writes to a slot which has been modified previously in the same transaction costs 100 gas.

It is evident that the first `SSTORE` operation to a specific slot, also known as a clean write, is prohibitively expensive. For example, updating the value for two different storage slots from zero to non-zero costs 44,200 gas!

## Example

```solidity
pragma solidity 0.8.22;

contract ZeroToNonZero {
    uint256 public x;

    // Costs 20k + 2.1k gas
    // 2.1k is for the cold access
    function setX() public {
        x = 1;
    }
}

contract NonZeroToSameNonZero {
    uint256 public x = 1;

    // Costs 100 + 2.1k gas
    // 2.1k is for the cold access
    function setX() public {
        x = 1;
    }
}

contract NonZeroToDiffNonZero {
    uint256 public x = 1;

    // Costs 2.9k + 2.1k gas
    // 2.1k is for the cold access
    function setX() public {
        x = 2;
    }
}

contract MultipleSstores {
    uint256 public x = 1;

    // Since the compiler's optimization is turned on,
    // it knows to skip the first 2 assignments.
    // If you want to see the unoptimized cost
    // i.e. 2.9k + 2.1k + 100 + 100
    // turn off optimizations and run the command
    // `forge debug src/SstoreCost.sol --tc "MultipleSstores" --sig "setX()"`
    function setX() public {
        x = 4;
        x = 3;
        x = 2;
    }
}
```

The code snippet above contains four contracts, each corresponding to one of the four summarized points. Each contract contains a slightly different `setX()` function, which is responsible for updating the storage variable `x`. Executing the `forge test --match-contract SstoreCostTest --gas-report` command reveals gas costs of 22,238, 2,338, 5,138, and 5,138 for the respective functions.

The cost of executing the first two `setX()` functions aligns with the summary. However, the gas costs for the last two scenarios are unexpectedly identical, and this might not be immediately apparent from inspecting the contracts. This outcome is actually a result of the compiler's optimizations being enabled. The compiler is able to recognize that only the final assignment holds significance, thereby disregarding the earlier assignments. In essence, it is effectively assigning a value to `x` only once.

---

\* <sub>These are only applicable to the first write to a specific storage slot.</sub>