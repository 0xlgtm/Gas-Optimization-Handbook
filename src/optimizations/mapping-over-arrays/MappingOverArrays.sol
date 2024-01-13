// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract MappingOverArrays {
    uint256[] arr;
    mapping(uint256 => uint256) map;
  
    function addToArray(uint256 v) public {
        arr.push(v);
    }
  
    function addToMapping(uint256 k, uint256 v) public {
        map[k] = v;
    }
  
    function getFromArray(uint256 i) public view returns(uint256) {
        return arr[i];
    }
  
    function getFromMapping(uint256 k) public view returns(uint256) {
        return map[k];
    }
}