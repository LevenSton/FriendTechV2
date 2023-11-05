// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

import {DataTypes} from "../../libraries/DataTypes.sol";
import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

/**
 * @title TomoHubStorage
 * @author Tomo Protocol
 *
 * @notice This is an abstract contract that *only* contains storage for the TomoFragment contract. This
 * *must* be inherited last (bar interfaces) in order to preserve the TomoFragment storage layout. Adding
 * storage variables should be done solely at the bottom of this contract.
 */
abstract contract TomoV2Storage {
    //map for subject to pool
    mapping(bytes32 => DataTypes.FragmentConfig) public _subjectToFragmentPool;

    //map for lockindex to LockInfo
    mapping(uint256 => DataTypes.VotePassLockInfo)
        public _indexToVotePassLockInfo;

    //map for user address to lockindex set
    mapping(address => EnumerableSet.UintSet) internal _userVotePassLockIds;

    DataTypes.TomoV2EntryPointState public _state;

    //global lock index, increment
    uint256 public _globalLockIndex;

    // the min price of one key which can be fragmention
    uint256 public _minPriceKeyCanFragment;

    address public _protocolFeeAddress;
    //governance address
    address public _governance;
}
