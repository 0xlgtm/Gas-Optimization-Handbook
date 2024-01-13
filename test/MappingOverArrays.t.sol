pragma solidity 0.8.22;

import {Test} from "forge-std/Test.sol";
import {MappingOverArrays} from "../src/optimizations/mapping-over-arrays/MappingOverArrays.sol";

// forge test --match-contract MappingOverArraysTest --gas-report
contract MappingOverArraysTest is Test {
    // In order to get the correct gas cost, we cannot use the setUp()
    // function because the constructor warms up the slot containing
    // the array's length
    MappingOverArrays example = new MappingOverArrays();

    function test_addToArray(uint256 v) public {
        example.addToArray(v);
    }

    function test_addToMapping(uint256 k, uint256 v) public {
        example.addToMapping(k, v);
    }

    function test_getFromArray() public {
        example.getFromArray(0);
    }

    function test_getFromMapping() public {
        example.getFromMapping(1);
    }
}
