/// @use-src 0:"src/ConstantsAndImmutables.sol"
object "ConstantsAndImmutables_46" {
    code {
        {
            let _1 := memoryguard(0xa0)
            mstore(64, _1)
            if callvalue() { revert(0, 0) }
            sstore(0x00, 0x03)
            mstore(128, 0x02)
            let _2 := datasize("ConstantsAndImmutables_46_deployed")
            codecopy(_1, dataoffset("ConstantsAndImmutables_46_deployed"), _2)
            setimmutable(_1, "6", mload(128))
            return(_1, _2)
        }
    }
    object "ConstantsAndImmutables_46_deployed" {
        code {
            {
                let _1 := memoryguard(0x80)
                mstore(64, _1)
                if iszero(lt(calldatasize(), 4))
                {
                    let _2 := 0
                    switch shr(224, calldataload(_2))
                    // sumAll()
                    case 0x1f6c63eb {
                        if callvalue() { revert(_2, _2) }
                        if slt(add(calldatasize(), 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc), 32) { revert(_2, _2) }
                        mstore(_1, add(add(calldataload(4), loadimmutable("6")), 1))
                        return(_1, 32)
                    }
                    // sumAllWithStorage()
                    case 0xde90193e {
                        if callvalue() { revert(_2, _2) }
                        if slt(add(calldatasize(), 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc), 32) { revert(_2, _2) }
                        let sum := add(calldataload(4), sload(_2))
                        let memPos := mload(64)
                        mstore(memPos, sum)
                        return(memPos, 32)
                    }
                }
                revert(0, 0)
            }
        }
        data ".metadata" hex"a264697066735822122028da08ffcfaf2bf9e1a104bc4cf9484d548ff2c27252ad8cbcc83d74eae5be2e64736f6c63430008160033"
    }
}