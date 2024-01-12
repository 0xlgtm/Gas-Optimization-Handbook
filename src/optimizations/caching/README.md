# Calldata Vs Memory

## Source
- [Cache.sol](./Cache.sol)
- [Cache.t.sol](../../../test/Cache.t.sol)

## Prerequisite Knowledge
- [SLOAD](../../core/sload/README.md)

## How It Works

When you access a storage slot for the first time, an `SLOAD` is executed and you will be charged 2,100 gas. Subsequent warm accesses will only cost 100 gas however, it is possible to make this even cheaper by relying on memory.

## Example
```solidity
pragma solidity 0.8.22;

contract Cache {
    uint256[] arr = [1, 2, 3, 4, 5, 6, 7, 8, 9];

    function iterateNoCache() public view returns(uint256 sum) {
        for(uint i = 0; i < arr.length; i ++) {
            sum += arr[i];
        }
    }

    function iterateWithCache() public view returns(uint256 sum) {
        uint256 len = arr.length;
        for(uint i = 0; i < len; i ++) {
            sum += arr[i];
        }
    }
}
```

The code snippet above contains two functions for iterating the array `arr` to calculate the sum. The first function `iterateNoCache()` iterates the array without caching the storage variable `arr.length` while the second function `iterateWithCache()` caches `arr.length` into a memory variable called `len`.

## Explanation

At every iteration of the loop, an `SLOAD` opcode will be executed for `arr.length` because it is a value that is stored on storage. Since this is a warm access (aside from the first call), every iteration will cost 100 gas.

Instead of making multiple `SLOAD` calls, we can opt to cache the value. This is often done by storing the value in a memory variable and referencing it later when we need it. The cost of an `MLOAD` is much lower at 3 gas! 


## Gas Savings

The gas report can be generated using the command `forge test --match-contract CacheTest --gas-report`. From the gas report, we able to observe a gas savings of about 900 gas. In fact, the more elements there are in the array, the greater the savings since we are saving at least 97 gas per iteration.