# Calldata Vs Memory

## Source
- [MappingOverArrays.sol](./MappingOverArrays.sol)
- [MappingOverArrays.t.sol](../../../test/MappingOverArrays.t.sol)

## Prerequisite Knowledge
- [SLOAD](../../core/sload/README.md)
- [SSTORE](../../core/sstore/README.md)

## How It Works

If you are given the option to choose between a mapping or an array to store your users' data, you should almost always use a mapping over an array because it is cheaper to store and retrieve a value in a mapping as compared to an array. Arrays have a length associated with them and this value is stored in the contract's storage. What this also means is that whenever you want to read or update an array, this length value is also checked against or updated thus requiring an additional `SLOAD` or `SSTORE` operation.

## Example
```solidity
pragma solidity 0.8.22;

contract MappingOverArrays {
    uint256[] arr;
    mapping(uint256 => uint256) map;
  
    function addToArray(uint256 v) public {
        arr.push(v);
    }
  
    function addToMapping(uint256 k, uint256 v) public {
        map[k] = v;
    }
  
    function getFromArray(uint256 i) public view returns(uint256) {
        return arr[i];
    }
  
    function getFromMapping(uint256 k) public view returns(uint256) {
        return map[k];
    }
}
```

The provided code snippet includes two sets of getter and setter functions. The initial set, comprising `addToArray()` and `getFromArray()`, is utilized for interactions with the array. Meanwhile, the second set, consisting of `addToMapping()` and `getFromMapping()`, serves as the corresponding functions for interacting with the mapping.

## Explanation

At every iteration of the loop, an `SLOAD` opcode will be executed for `arr.length` because it is a value that is stored on storage. Since this is a warm access (aside from the first call), every iteration will cost 100 gas.

Instead of making multiple `SLOAD` calls, we can opt to cache the value. This is often done by storing the value in a memory variable and referencing it later when we need it. The cost of an `MLOAD` is much lower at 3 gas! 


## Gas Savings

The gas report can be generated using the command `forge test --match-contract CacheTest --gas-report`. From the gas report, we able to observe a gas savings of about 900 gas. In fact, the more elements there are in the array, the greater the savings since we are saving at least 97 gas per iteration.