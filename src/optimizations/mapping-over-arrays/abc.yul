/// @use-src 0:"src/optimizations/mapping-over-arrays/MappingOverArrays.sol"
object "MappingOverArrays_59" {
    code {
        {
            /// @src 0:57:505  "contract MappingOverArrays {..."
            let _1 := memoryguard(0x80)
            mstore(64, _1)
            if callvalue() { revert(0, 0) }
            let _2 := datasize("MappingOverArrays_59_deployed")
            codecopy(_1, dataoffset("MappingOverArrays_59_deployed"), _2)
            return(_1, _2)
        }
    }
    /// @use-src 0:"src/optimizations/mapping-over-arrays/MappingOverArrays.sol"
    object "MappingOverArrays_59_deployed" {
        code {
            {
                /// @src 0:57:505  "contract MappingOverArrays {..."
                let _1 := 64z
                mstore(_1, memoryguard(0x80))
                let _2 := 4
                if iszero(lt(calldatasize(), _2))
                {
                    let _3 := 0
                    switch shr(224, calldataload(_3))
                    case 0x35c991ac { // getFromArray()
                        if callvalue() { revert(_3, _3) }
                        if slt(add(calldatasize(), 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc), 32) { revert(_3, _3) }
                        // first SLOAD
                        let _4, _5 := storage_array_index_access_uint256_dyn(calldataload(_2))
                        // second SLOAD
                        let _6 := sload(_4)
                        let memPos := mload(_1)
                        mstore(memPos, shr(shl(3, _5), _6))
                        return(memPos, 32)
                    }
                    case 0xd15ec851 { // addToArray()
                        if callvalue() { revert(_3, _3) }
                        if slt(add(calldatasize(), 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc), 32) { revert(_3, _3) }
                        let oldLen := sload(_3)
                        if iszero(lt(oldLen, 18446744073709551616))
                        {
                            mstore(_3, 35408467139433450592217433187231851964531694900788300625387963629091585785856)
                            mstore(_2, 0x41)
                            revert(_3, 0x24)
                        }
                        // first SSTORE
                        sstore(_3, add(oldLen, 1))
                        // first SLOAD
                        let slot, offset := storage_array_index_access_uint256_dyn(oldLen)
                        // second SLOAD
                        let _8 := sload(slot)
                        let shiftBits := shl(3, offset)
                        // second SSTORE
                        sstore(slot, or(and(_8, not(shl(shiftBits, 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff))), shl(shiftBits, calldataload(_2))))
                        return(_3, _3)
                    }
                    case 0x7e3e1ed0 { // getFromMapping()
                        if callvalue() { revert(_3, _3) }
                        if slt(add(calldatasize(), 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc), 32) { revert(_3, _3) }
                        mstore(_3, calldataload(_2))
                        mstore(32, 1)
                        let _7 := sload(keccak256(_3, _1))
                        let memPos_1 := mload(_1)
                        mstore(memPos_1, _7)
                        return(memPos_1, 32)
                    }
                    case 0xa29f6977 { // addToMapping()
                        if callvalue() { revert(_3, _3) }
                        if slt(add(calldatasize(), 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc), _1) { revert(_3, _3) }
                        mstore(_3, calldataload(_2))
                        mstore(32, 1)
                        sstore(keccak256(_3, _1), calldataload(36))
                        return(_3, _3)
                    }

                }
                revert(0, 0)
            }
            function storage_array_index_access_uint256_dyn(index) -> slot, offset
            {
                let _1 := 0
                if iszero(lt(index, sload(_1)))
                {
                    mstore(_1, 35408467139433450592217433187231851964531694900788300625387963629091585785856)
                    mstore(4, 0x32)
                    revert(_1, 0x24)
                }
                mstore(_1, _1)
                slot := add(18569430475105882587588266137607568536673111973893317399460219858819262702947, index)
                offset := _1
            }
        }
        data ".metadata" hex"a2646970667358221220a280b9d533655c929ca18c3f3415b85a6f188ea6c20d224fc332bc070b0f4ae664736f6c63430008160033"
    }
}