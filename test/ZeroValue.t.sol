// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import {Test} from "forge-std/Test.sol";
import {ZeroValue} from "../src/ZeroValue.sol";

// forge test --match-contract ZeroValueTest --gas-report
contract ZeroValueTest is Test {
    ZeroValue public zeroValue;

    function setUp() public {
        zeroValue = new ZeroValue();
    }

    function test_setUint() public {
        zeroValue.setUint();
    }

    function test_setBool() public {
        zeroValue.setBool();
    }

    function test_setAddress() public {
        zeroValue.setAddress();
    }
}
