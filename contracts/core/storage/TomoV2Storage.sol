// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

import {DataTypes} from "../../libraries/DataTypes.sol";
import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

/**
 * @title TomoV2Storage
 * @author Tomo Protocol
 *
 * @notice This is an abstract contract that *only* contains storage for the TomoV2 contract. This
 * *must* be inherited last (bar interfaces) in order to preserve the TomoV2 storage layout. Adding
 * storage variables should be done solely at the bottom of this contract.
 */
abstract contract TomoV2Storage {
    // KeySubject => SubjectInfo
    mapping(address => DataTypes.SubjectInfo) public _keySubjectInfo;

    //whitelist curve address
    mapping(address => bool) internal _curveModuleWhitelisted;

    DataTypes.TomoV2EntryPointState public _state;

    //tomo sign address
    address public _tomoSignAddress;
    //protocol fee address
    address public _protocolFeeAddress;
    //governance address
    address public _governance;
}
