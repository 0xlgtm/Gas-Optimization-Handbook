// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract ZeroValue {
    uint256 public x;
    bool public y = false;
    address public z;

    function setUint() public {
        x = 1;
    }

    function setBool() public {
        y = true;
    }

    function setAddress() public {
        z = address(1);
    }
}