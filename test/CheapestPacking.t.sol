pragma solidity 0.8.22;

import {Test} from "forge-std/Test.sol";
import {CheapestPacking} from "../src/CheapestPacking.sol";

contract CheapestPackingTest is Test {

    CheapestPacking cp;

    function setUp() public {
        cp = new CheapestPacking();
    }

    function test_store(uint256 _a, uint256 _b, uint256 _c, uint256 _d) public {
        cp.storeUnpacked(_a, _b, _c, _d);
        cp.storePackByType(_a, _b, _c, _d);
        cp.storePackByStruct(_a, _b, _c, _d);
        cp.storeManualPackWithBitOps(_a, _b, _c, _d);
        cp.storeManualPackWithAssembly(_a, _b, _c, _d);
    }
}