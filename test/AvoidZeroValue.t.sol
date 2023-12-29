// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import {Test} from "forge-std/Test.sol";
import {AvoidZeroValue} from "../src/avoid-zero-value/AvoidZeroValue.sol";

// forge test --match-contract AvoidZeroValueTest --gas-report
contract AvoidZeroValueTest is Test {
    AvoidZeroValue public avoidZeroValue;

    function setUp() public {
        avoidZeroValue = new AvoidZeroValue();
    }

    function test_unoptimizedModifier() public {
        avoidZeroValue.subtractUnoptimized();
    }

    function test_optimizedModifier() public {
        avoidZeroValue.subtractOptimized();
    }
}
