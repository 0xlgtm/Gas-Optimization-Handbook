pragma solidity 0.8.22;

contract StoragePacking {
    // Naive implementation
    // mapping from student id => grade
    mapping(uint256 => uint256) gradeForA;
    mapping(uint256 => uint256) public gradeForB;  // public so I can compare gas usage for single retrieval 
    mapping(uint256 => uint256) gradeForC;
    mapping(uint256 => uint256) gradeForD;

    function recordGradesUnoptimized(uint256 id, uint256 a, uint256 b, uint256 c, uint256 d) public {
        gradeForA[id] = a;
        gradeForB[id] = b;
        gradeForC[id] = c;
        gradeForD[id] = d;
    }

    function getGradesUnoptimized(uint256 id) public view returns(uint256, uint256, uint256, uint256) {
        return (gradeForA[id], gradeForB[id], gradeForC[id], gradeForD[id]);
    }

    // Optimized implementation
    // mapping from student id => packed grades
    mapping(uint256 => uint256) grades;

    function recordGradesOptimized(uint256 id, uint256 a, uint256 b, uint256 c, uint256 d) public {
        uint256 packedGrades = (((((a << 64) | b) << 64) | c) << 64) | d;
        grades[id] = packedGrades;
    }

    function gradeForBOptimized(uint256 id) public view returns(uint256) {
        return grades[id] >> 128 & type(uint64).max;
    }

    function getGradesOptimized(uint256 id) public view returns(uint256 a, uint256 b, uint256 c, uint256 d) {
        uint256 packedGrades = grades[id];
        a = packedGrades >> 192;
        b = packedGrades >> 128 & type(uint64).max;
        c = packedGrades >> 64 & type(uint64).max;
        d = uint256(uint64(packedGrades));
    }
}