// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import {Test} from "forge-std/Test.sol";
import {StoragePacking} from "../src/optimizations/storage-packing/StoragePacking.sol";

// forge test --match-contract StoragePackingTest --gas-report
contract StoragePackingTest is Test {
    StoragePacking public storagePacking;

    function setUp() public {
        storagePacking = new StoragePacking();
        storagePacking.recordGradesUnoptimized(1, 66, 77, 88, 99);
        storagePacking.recordGradesOptimized(1, 66, 77, 88, 99);
    }

    function test_recordGradesUnoptimized(uint256 id, uint256 a, uint256 b, uint256 c, uint256 d) public {
        vm.assume(id != 1);
        storagePacking.recordGradesUnoptimized(id, a, b, c, d);
    }

    function test_getGradesUnoptimized() public {
        storagePacking.getGradesUnoptimized(1);
    }

    function test_recordGradesOptimized(uint256 id, uint256 a, uint256 b, uint256 c, uint256 d) public {
        vm.assume(id != 1);
        storagePacking.recordGradesOptimized(id, a, b, c, d);
    }

    function test_getGradesOptimized() public {
        storagePacking.getGradesOptimized(1);
    }

    function test_getGradeB() public {
        assertEq(storagePacking.gradeForB(1), storagePacking.gradeForBOptimized(1));
    }
}
