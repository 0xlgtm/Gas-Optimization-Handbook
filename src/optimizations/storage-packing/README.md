# Storage Packing

## Source
- [StoragePacking.sol](./StoragePacking.sol)
- [StoragePacking.t.sol](../../../test/StoragePacking.t.sol)

## Prerequisite Knowledge
- [Bit shifting](https://medium.com/@mweiss.eth/solidity-and-evm-bit-shifting-and-masking-in-assembly-yul-942f4b4ebb6a)
- [SLOAD](../../core/sload/README.md)
- [SSTORE](../../core/sstore/README.md)

## How It Works

Depending on your specific use case, you might not exhaust the entire range of values offered by a `uint256`. As such, you may want to consider packing multiple variables into a single storage slot. This technique allows you to reduce the number of `SSTORE` and `SLOAD` calls required to save / read multiple values. Assume we that have the following problem:

> The students recently completed four different exams and the school wants to store their grades on a smart contract. The maximum grade for each test is 100.

## Example
```solidity
pragma solidity 0.8.22;

contract StoragePacking {
    // Naive implementation
    // mapping from student id => grade
    mapping(uint256 => uint256) gradeForA;
    mapping(uint256 => uint256) public gradeForB;  // Note: public variable so we can compare gas usage for single retrieval 
    mapping(uint256 => uint256) gradeForC;
    mapping(uint256 => uint256) gradeForD;

    function recordGradesUnoptimized(uint256 id, uint256 a, uint256 b, uint256 c, uint256 d) public {
        gradeForA[id] = a;
        gradeForB[id] = b;
        gradeForC[id] = c;
        gradeForD[id] = d;
    }

    function getGradesUnoptimized(uint256 id) public view returns(uint256, uint256, uint256, uint256) {
        return (gradeForA[id], gradeForB[id], gradeForC[id], gradeForD[id]);
    }

    // Optimized implementation
    // mapping from student id => packed grades
    mapping(uint256 => uint256) grades;

    function recordGradesOptimized(uint256 id, uint256 a, uint256 b, uint256 c, uint256 d) public {
        uint256 packedGrades = (((((a << 64) | b) << 64) | c) << 64) | d;
        grades[id] = packedGrades;
    }

    function gradeForBOptimized(uint256 id) public view returns(uint256) {
        return grades[id] >> 128 & type(uint64).max;
    }

    function getGradesOptimized(uint256 id) public view returns(uint256 a, uint256 b, uint256 c, uint256 d) {
        uint256 packedGrades = grades[id];
        a = packedGrades >> 192;
        b = packedGrades >> 128 & type(uint64).max;
        c = packedGrades >> 64 & type(uint64).max;
        d = uint256(uint64(packedGrades));
    }
}
```

The provided code example offers two solutions to address this issue. The naive implementation uses a distinct mapping for each subject. However, recognizing that the maximum value for each grade is 100, it becomes possible to optimize storage usage by consolidating the grades into a single `uint256` value and storing this value in a single mapping.

To achieve this, each grade is stored in adjacent 8-byte "buckets." Bitwise operators such as `|`, `>>`, and `<<` are employed to manipulate and ensure that the four grades are packed correctly. This involves ensuring that buckets have the correct size and are positioned correctly.

Although it is possible to use a smaller type like `uint32` to pack four grades, it is actually less gas efficient. As per the [solidity documentation](https://docs.soliditylang.org/en/latest/internals/layout_in_storage.html), “the EVM operates on 32 bytes at a time. Therefore, if the element is smaller than that, the EVM must use more operations in order to reduce the size of the element from 32 bytes to the desired size.”

The gas report can be generated using the command `forge test --match-contract StoragePackingTest --gas-report`. From the gas report, we able to notice a substantial gas savings when comparing `getGradesUnoptimized()` against `getGradesOptimized()` and `recordGradesUnoptimized()` against `recordGradesOptimized()`. The gas difference of 6,430 and 66,473 aligns with our predicted savings because the optimized functions only use a single `SSTORE` and `SLOAD` compared to four in the unoptimized functions.