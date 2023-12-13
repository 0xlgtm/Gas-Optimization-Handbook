// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract ZeroToNonZero {
    uint256 public x;

    // Costs 20k + 2.1k gas
    // 2.1k is for the cold access
    function setX() public {
        x = 1;
    }
}

contract NonZeroToSameNonZero {
    uint256 public x = 1;

    // Costs 100 + 2.1k gas
    // 2.1k is for the cold access
    function setX() public {
        x = 1;
    }
}

contract NonZeroToDiffNonZero {
    uint256 public x = 1;

    // Costs 2.9k + 2.1k gas
    // 2.1k is for the cold access
    function setX() public {
        x = 2;
    }
}

contract MultipleSstores {
    uint256 public x = 1;

    // Since the compiler's optimization is turned on,
    // it knows to skip the first 2 assignments.
    // If you want to see the unoptimized cost
    // i.e. 2.9k + 2.1k + 100 + 100
    // turn off optimizations and run the command
    // `forge debug src/SstoreCost.sol --tc "MultipleSstores" --sig "setX()"`
    function setX() public {
        x = 4;
        x = 3;
        x = 2;
    }
}
