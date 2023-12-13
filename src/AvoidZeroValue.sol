// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract AvoidZeroValue {

    uint256 public x = 10;
    uint256 public statusZero;
    uint256 public statusOne = 1;

    error Reentrancy();

    modifier reentrancyCheckUnoptimized() {
        if(statusZero == 1) {
            revert Reentrancy();
        }
        statusZero = 1;
        _;
        statusZero = 0;
    }

    modifier reentrancyCheckOptimized() {
        if(statusOne == 2) {
            revert Reentrancy();
        }
        statusOne = 2;
        _;
        statusOne = 1;
    }

    function subtractUnoptimized() public reentrancyCheckUnoptimized {
        x -= 1;
    }

    function subtractOptimized() public reentrancyCheckOptimized {
        x -= 1;
    }
}