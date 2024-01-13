pragma solidity 0.8.22;

import {Test} from "forge-std/Test.sol";
import {Cache} from "../src/optimizations/caching/Cache.sol";

// forge test --match-contract CacheTest --gas-report
contract CacheTest is Test {
    Cache c;

    function setUp() public {
        c = new Cache();
    }

    function test_iterate() public {
        c.iterateNoCache();
    }

    function test_iterateCache() public {
        c.iterateWithCache();
    }
}
