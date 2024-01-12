// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract Cache {
    uint256[] arr = [1, 2, 3, 4, 5, 6, 7, 8, 9];

    function iterateNoCache() public view returns (uint256 sum) {
        for (uint256 i = 0; i < arr.length; i++) {
            sum += arr[i];
        }
    }

    function iterateWithCache() public view returns (uint256 sum) {
        uint256 len = arr.length;
        for (uint256 i = 0; i < len; i++) {
            sum += arr[i];
        }
    }
}
