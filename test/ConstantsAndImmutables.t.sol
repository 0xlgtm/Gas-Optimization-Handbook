pragma solidity 0.8.22;

import {Test} from "forge-std/Test.sol";
import {ConstantsAndImmutables} from "../src/ConstantsAndImmutables.sol";

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
