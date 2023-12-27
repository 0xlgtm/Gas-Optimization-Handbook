// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import {Test} from "forge-std/Test.sol";
import {ColdAccess, ColdAndWarmAccess} from "../src/core/sload/ColdVsWarm.sol";

// forge test --match-contract ColdVsWarmTest --gas-report
contract ColdVsWarmTest is Test {
    ColdAccess public coldAccess;
    ColdAndWarmAccess public coldAndWarmAccess;

    function setUp() public {
        coldAccess = new ColdAccess();
        coldAndWarmAccess = new ColdAndWarmAccess();
    }

    function test_coldAccess() public {
        coldAccess.getX();
    }

    function test_coldAndWarmAccess() public {
        coldAndWarmAccess.getX();
    }
}
