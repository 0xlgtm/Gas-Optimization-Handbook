// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import {Test} from "forge-std/Test.sol";
import {ZeroToNonZero, NonZeroToDiffNonZero, NonZeroToSameNonZero, MultipleSstores} from "../src/SstoreCost.sol";

// forge test --match-contract SstoreCostTest --gas-report
contract SstoreCostTest is Test {
    ZeroToNonZero public zeroToNonZero;
    NonZeroToDiffNonZero public nonZeroToDiffNonZero;
    NonZeroToSameNonZero public nonZeroToSameNonZero;
    MultipleSstores public multipleSstores;

    function setUp() public {
        zeroToNonZero = new ZeroToNonZero();
        nonZeroToDiffNonZero = new NonZeroToDiffNonZero();
        nonZeroToSameNonZero = new NonZeroToSameNonZero();
        multipleSstores = new MultipleSstores();
    }

    function test_zeroToNonZero() public {
        zeroToNonZero.setX();
    }

    function test_nonZeroToSameNonZero() public {
        nonZeroToSameNonZero.setX();
    }

    function test_nonZeroToDiffNonZero() public {
        nonZeroToDiffNonZero.setX();
    }

    function test_multipleSstores() public {
        multipleSstores.setX();
    }
}
