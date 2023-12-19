pragma solidity 0.8.22;

contract CheapestPacking {
    // For unpacked
    uint256 a;
    uint256 b;
    uint256 c;
    uint256 d;

    // For pack by type
    uint64 e;
    uint64 f;
    uint64 g;
    uint64 h;

    // For struct pack
    struct StructPack{
        uint64 i;
        uint64 j;
        uint64 k;
        uint64 l;
    }
    StructPack sp;

    // For pack with bitops
    uint256 manualPackWithBitOps;

    // For pack with assembly
    uint256 manualPackWithAssembly;

    // 22 + 44 gas for function selector
    function storeUnpacked(uint256 _a, uint256 _b, uint256 _c, uint256 _d) public {
        a = _a;
        b = _b;
        c = _c;
        d = _d;
    }
    // 22 + 22 gas for function selector
    function storePackByType(uint256 _e, uint256 _f, uint256 _g, uint256 _h) public {
        e = uint64(_e);
        f = uint64(_f);
        g = uint64(_g);
        h = uint64(_h);
    }
    // 22 + 44 gas for function selector
    function storePackByStruct(uint256 _i, uint256 _j, uint256 _k, uint256 _l) public {
        sp = StructPack(uint64(_i), uint64(_j), uint64(_k), uint64(_l));
    }
    // 22 + 66 gas for function selector
    function storeManualPackWithBitOps(uint256 _m, uint256 _n, uint256 _o, uint256 _p) public {
        manualPackWithBitOps = (((((_p << 64) | _o) << 64) | _n) << 64) | _m;
    }
    // 22 + 22 gas for binary search, function selector
    function storeManualPackWithAssembly(uint256 _q, uint256 _r, uint256 _s, uint256 _t) public {
        assembly {
            sstore(manualPackWithAssembly.slot, or(shl(64, or(shl(64, or(shl(64, _t), _s)), _r)), _q))
        }
    }
}

// | Function Name | Sighash    | Function Signature | 
// | ------------- | ---------- | ------------------ | 
// | storeUnpacked | 81c09a33 | storeUnpacked(uint256,uint256,uint256,uint256) |
// | storePackByType | a3d77fd2 | storePackByType(uint256,uint256,uint256,uint256) |
// | storePackByStruct | 61c5ed3c | storePackByStruct(uint256,uint256,uint256,uint256) |
// | storeManualPackWithBitOps | f2a36acb | storeManualPackWithBitOps(uint256,uint256,uint256,uint256) |
// | storeManualPackWithAssembly | 43882a54 | storeManualPackWithAssembly(uint256,uint256,uint256,uint256) |