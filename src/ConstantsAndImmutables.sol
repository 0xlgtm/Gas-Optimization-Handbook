// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract ConstantsAndImmutables {
    uint256 constant SOME_CONSTANT = 1;
    uint256 immutable SOME_IMMUTABLE;
    uint256 someStorageValue = 3;

    constructor() {
        SOME_IMMUTABLE = 2;
    }

    function sumAll(uint256 _a) public view returns (uint256) {
        unchecked {
            return _a + SOME_CONSTANT + SOME_IMMUTABLE;
        }
    }

    function sumAllWithStorage(uint256 _a) public view returns (uint256) {
        unchecked {
            return _a + someStorageValue;
        }
    }
}
