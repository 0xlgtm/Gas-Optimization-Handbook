pragma solidity 0.8.22;

import {Test} from "forge-std/Test.sol";
import {ConstantsAndImmutables} from "../src/optimizations/constants-and-immutables/ConstantsAndImmutables.sol";

// forge test --match-contract ConstantsAndImmutablesTest --gas-report
contract ConstantsAndImmutablesTest is Test {
    ConstantsAndImmutables example;

    function setUp() public {
        example = new ConstantsAndImmutables();
    }

    function test_sum(uint256 _a) public {
        example.sumAll(_a);
        example.sumAllWithStorage(_a);
    }
}
