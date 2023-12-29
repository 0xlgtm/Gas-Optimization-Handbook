# Avoid Zero Values

## Source
- [AvoidZeroValue.sol](./AvoidZeroValue.sol)
- [AvoidZeroValue.t.sol](../../test/AvoidZeroValue.t.sol)

## Prerequisite Knowledge
- [SSTORE](../core/sstore/README.md)

## How It Works

If your smart contract's logic depends on a base case or you anticipate reusing a specific storage slot multiple times, it is more cost-effective to set the storage slot to a non-zero value. This approach helps avoid the additional 17,100 gas cost when executing `SSTORE` since you are writing from a non-zero value to another non-zero value. A typical scenario where the same storage slot is frequently used is in the [re-entrancy check](https://owasp.org/www-project-smart-contract-top-10/2023/en/src/SC01-reentrancy-attacks.html) modifier, making it a suitable candidate for applying this optimization.

## Example

```solidity
pragma solidity 0.8.22;

contract AvoidZeroValue {
    uint256 public x = 10;
    uint256 public statusZero;
    uint256 public statusOne = 1;

    error Reentrancy();

    modifier reentrancyCheckUnoptimized() {
        if (statusZero == 1) {
            revert Reentrancy();
        }
        statusZero = 1;
        _;
        statusZero = 0;
    }

    modifier reentrancyCheckOptimized() {
        if (statusOne == 2) {
            revert Reentrancy();
        }
        statusOne = 2;
        _;
        statusOne = 1;
    }

    function subtractUnoptimized() public reentrancyCheckUnoptimized {
        x -= 1;
    }

    function subtractOptimized() public reentrancyCheckOptimized {
        x -= 1;
    }
}
```
In the provided code snippet, there are two variations of the re-entrancy check modifier. The unoptimized `reentrancyCheckUnoptimized()` modifier uses a value of zero, which is the default value for uint256, to indicate the unentered case. On the other hand, the optimized `reentrancyCheckOptimized()` modifier uses a value of one.

Generating the gas report with the `forge test --match-contract AvoidZeroValueTest --gas-report` command reveals gas costs to be 22,021 and 8,328 respectively. As expected, the optimized re-entrancy check modifier is more cost efficient than the unoptimized variant!