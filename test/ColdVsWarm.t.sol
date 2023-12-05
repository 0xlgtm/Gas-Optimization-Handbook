// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import {Test, console2} from "forge-std/Test.sol";
import {ColdAccess, ColdAndWarmAccess} from "../src/ColdVsWarm.sol";

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
