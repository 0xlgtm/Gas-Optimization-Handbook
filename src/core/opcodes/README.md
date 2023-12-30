# Opcodes

## Source

- [Storage.sol](./Storage.sol)

## Example

Assume that you are given a `Storage` contract and you want to deploy it.

```solidity
pragma solidity 0.8.22;

contract Storage {
    uint256 number;

    function store(uint256 num) public {
        number = num;
    }

    function retrieve() public view returns (uint256){
        return number;
    }
}
```

## Explanation

In order to deploy this contract, we must first compile it to bytecode. This can be done with the `forge inspect` command and the `bytecode` field i.e. `forge inspect ./Storage.sol:Storage bytecode`. Executing this command generates the following:

`6080604052348015600f57600080fd5b5060ac8061001e6000396000f3fe6080604052348015600f57600080fd5b506004361060325760003560e01c80632e64cec11460375780636057361d14604c575b600080fd5b60005460405190815260200160405180910390f35b605c6057366004605e565b600055565b005b600060208284031215606f57600080fd5b503591905056fea264697066735822122031d75a1e1de750e001d30146e54445f98d0b7774f3e340d1ee6fe4a68bdb518764736f6c63430008160033`

To the untrained eye, this string might appear nonsensical. However, it contains the creation* and runtime* code for the `Storage` contract. Each pair of [hexadecimal](https://en.wikipedia.org/wiki/Hexadecimal) characters constitutes one byte, and each byte corresponds to either:

- an operation code (opcode for short)
- arguments to be used for the most recent opcode executed

Opcodes are the basic instructions executed by the Ethereum Virtual Machine and each opcode has a gas cost associated with it. For example, the first two pairs of hexadecimal characters are `6080`. The first byte corresponds to the `PUSH1` opcode and costs 3 gas, while the second byte is a 1-byte argument to be "pushed" onto the stack.

---

\* <sub>You do not need to understand this distinction yet.</sub>