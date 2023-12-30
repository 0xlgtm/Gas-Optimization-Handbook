# Constants and Immutables

## Source
- [ConstantsAndImmutables.sol](./ConstantsAndImmutables.sol)
- [ConstantsAndImmutables.t.sol](../../../test/ConstantsAndImmutables.t.sol)

## Prerequisite Knowledge
- [Ethereum Smart Contract Creation Code](https://www.rareskills.io/post/ethereum-contract-creation-code)
- [SLOAD](../../core/sload/README.md)

## How It Works

Another technique for reducing the number of `SLOAD` calls is to store read-only variables as constants or immutables*. Unlike storage variables, constants and immutables are stored in a contract’s bytecode. This eliminates the need for an `SLOAD` opcode to be executed thus, saving up to 2,100 gas in the process.

## Example

```solidity
pragma solidity 0.8.22;

contract ConstantsAndImmutables {
    uint256 constant SOME_CONSTANT = 1;
    uint256 immutable SOME_IMMUTABLE;
    uint256 someStorageValue = 3;

    constructor() {
        SOME_IMMUTABLE = 2;
    }

    function sumAll(uint256 _a) public view returns (uint256) {
        unchecked {
            return _a + SOME_CONSTANT + SOME_IMMUTABLE;
        }
    }

    function sumAllWithStorage(uint256 _a) public view returns (uint256) {
        unchecked {
            return _a + someStorageValue;
        }
    }
}
```

The code snippet above contains two variation of a "sum" function. The first function `sumAll()` adds the input argument to two different values, a constant and an immutable. These values will be retrieved directly from the bytecode. On the other hand, the second function `sumAllWithStorage()` also adds the input argument to one value however, it retrieves this value from storage.

## Explanation

Although the `sumAll()` function adds two values to the input argument, it should still be cheaper than the `sumAllWithStorage()` function because it does not execute an `SLOAD` opcode because it retrieves retrieves the two values from the bytecode instead. To understand how this is done, we need to decompile the contract's bytecode. The bytecode can be generated with the `forge inspect` command.


```markdown
# Contract Creation Code
60a0604052600360005534801561001557600080fd5b50600260805260805160dc61003360003960006044015260dc6000f3fe

# Runtime code
6080604052348015600f57600080fd5b506004361060325760003560e01c80631f6c63eb146037578063de90193e14607c575b600080fd5b606a6042366004608e565b7f00000000000000000000000000000000000000000000000000000000000000000160010190565b60405190815260200160405180910390f35b606a6087366004608e565b6000540190565b600060208284031215609f57600080fd5b503591905056fea26469706673582212209f990bca0faa94aa842a9cb71241e74d984e29723d09e4e4e4cc985a48b91b0264736f6c63430008160033
```

Notice that there are many zeros in the runtime code. These zeros serve as placeholders to be replaced with the value that is assigned to `SOME_IMMUTABLE`. The logic of replacing this placeholder is embedded within the creation code so let's trace through the creation code to understand what is happening.


```markdown
# Contract Creation Code
60a0604052600360005534801561001557600080fd5b50600260805260805160dc61003360003960006044015260dc6000f3fe

# Breakdown of Creation Code
60a0604052       | store the free memory pointer (0xa0 instead of 0x80) to 0x40
6003600055       | store the number 3 (used for `someStorageValue`) into storage slot 0
34801561001557   | if callvalue is 0, jump to instruction 15 else revert.
600080fd         | revert branch
5b50             | instruction 15, continue execution
6002608052       | store the number 2 (used for `SOME_IMMUTABLE`) in memory slot 0x80
608051           | load the value in memory slot 0x80 (which is the number 2) in memory onto the stack
60dc610033600039 | copy the runtime bytecode into memory
600060440152     | ❗❗ copy 2 from the stack into the runtime bytecode 
60dc6000f3fe     | return the updated runtime code

# Runtime code before
6080604052348015600f57600080fd5b506004361060325760003560e01c80631f6c63eb146037578063de90193e14607c575b600080fd5b606a6042366004608e565b7f
0000000000000000000000000000000000000000000000000000000000000000
0160010190565b60405190815260200160405180910390f35b606a6087366004608e565b6000540190565b600060208284031215609f57600080fd5b503591905056fea26469706673582212209f990bca0faa94aa842a9cb71241e74d984e29723d09e4e4e4cc985a48b91b0264736f6c63430008160033

# Runtime code after
6080604052348015600f57600080fd5b506004361060325760003560e01c80631f6c63eb146037578063de90193e14607c575b600080fd5b606a6042366004608e565b7f
0000000000000000000000000000000000000000000000000000000000000002 <- ❗❗ this is modified by the contract creation code
0160010190565b60405190815260200160405180910390f35b606a6087366004608e565b6000540190565b600060208284031215609f57600080fd5b503591905056fea26469706673582212209f990bca0faa94aa842a9cb71241e74d984e29723d09e4e4e4cc985a48b91b0264736f6c63430008160033
```

Unlike immutables, which modifies the runtime code at creation time, constants are generated together with the rest of the code at compile time. In order for the compiler to do this, every constant variable needs to be assigned a value when it is declared. Every instance of a constant variable is replaced with a `PUSHX Y` opcodes. For example, the `SOME_CONSTANT` variable is assigned the value of 1 so every usage of `SOME_CONSTANT` is replaced by `6001`. You can verify this by doing a `ctrl + f` search for `6001`.

## Gas Savings

After running the command `forge test --match-contract ConstantsAndImmutablesTest --gas-report`, notice that the `sumAll()` function only costs 247 gas, whereas the `sumAllWithStorage()` function costs 2,363 gas. This difference of 2,116 gas implies that the `SLOAD` opcode was not executed in the `sumAll()` function.

---

\* <sub>Immutables offer greater flexibility compared to constants, as they only need to be assigned a value at creation time i.e. in the constructor. This however, leads to an increase in deployment costs since the runtime bytecode is longer.</sub>