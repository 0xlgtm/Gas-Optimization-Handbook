// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract ZeroToNonZero {
    uint256 public x;

    // Costs 20k + 2.1k gas
    function setX() public {
        x = 1;
    }
}

contract NonZeroToDiffNonZero {
    uint256 public x = 1;

    // Costs 2.9k + 2.1k gas
    function setX() public {
        x = x + 1;
    }
}

contract NonZeroToSameNonZero {
    uint256 public x = 1;

    // Costs 100 + 2.1k gas
    function setX() public {
        // You need to do this otherwise the compiler
        // will optimize and remove the SSTORE
        x = x + 1 - 1;
    }
}

contract MultipleSstores {
    uint256 public x = 1;

    // Costs 2.9k (first SSTORE) + 2.1k (first SLOAD) +
    // 100 (second SSTORE) + 100 (second SLOAD) +
    // 100 (third SSTORE) + 100 (third SLOAD)
    function setX() public {
        x += 3;
        x -= 1;
        x -= 1;
    }
}