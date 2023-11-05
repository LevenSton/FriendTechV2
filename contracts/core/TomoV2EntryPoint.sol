// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import {VersionedInitializable} from "../upgradeablity/VersionedInitializable.sol";
import {ITomoV2EntryPoint} from "../interfaces/ITomoV2EntryPoint.sol";
import {TomoV2Storage} from "./storage/TomoV2Storage.sol";
import {DataTypes} from "../libraries/DataTypes.sol";
import {Clones} from "@openzeppelin/contracts/proxy/Clones.sol";
import {Errors} from "../libraries/Errors.sol";
import {Events} from "../libraries/Events.sol";
import {ITomo} from "../interfaces/ITomo.sol";

contract TomoV2EntryPoint is
    VersionedInitializable,
    TomoV2Storage,
    ITomoV2EntryPoint
{
    uint256 internal constant REVISION = 1;
    address internal immutable TOMO_IMPL;
    address internal immutable TOMO_V2_KEY_POOL_IMPL;

    modifier onlyGov() {
        _validateCallerIsGovernance();
        _;
    }

    modifier whenNotPaused() {
        _validateNotPaused();
        _;
    }

    /**
     * @dev The constructor sets the immutable Tomo implementations.
     *
     * @param tomoImpl The Tomo Protocol implementation address.
     * @param tomoV2KeyPoolImpl The Tomo V2 key pool implementation address.
     */
    constructor(address tomoImpl, address tomoV2KeyPoolImpl) {
        if (tomoImpl == address(0) || tomoV2KeyPoolImpl == address(0))
            revert Errors.InitParamsInvalid();
        TOMO_IMPL = tomoImpl;
        TOMO_V2_KEY_POOL_IMPL = tomoV2KeyPoolImpl;
    }

    /// @inheritdoc ITomoV2EntryPoint
    function initialize(
        address governanceContractAddress,
        address protocolFeeAddress
    ) external override initializer {
        _setState(DataTypes.TomoV2EntryPointState.Paused);
        _setGovernance(governanceContractAddress);
        _setProtocolFeeAddress(protocolFeeAddress);
    }

    /// ***********************
    /// *****GOV FUNCTIONS*****
    /// ***********************

    function setGovernance(address newGovernance) external override onlyGov {
        _setGovernance(newGovernance);
    }

    function setProtocolFeeAddress(
        address newProtocolFeeAddress
    ) external override onlyGov {
        _setProtocolFeeAddress(newProtocolFeeAddress);
    }

    function setState(
        DataTypes.TomoV2EntryPointState newState
    ) external override onlyGov {
        _setState(newState);
    }

    /// ****************************
    /// *****EXTERNAL FUNCTIONS***
    /// ****************************

    /// ****************************
    /// *****QUERY VIEW FUNCTIONS***
    /// ****************************

    /// ****************************
    /// *****INTERNAL FUNCTIONS*****
    /// ****************************

    function _setGovernance(address newGovernance) internal {
        address prevGovernance = _governance;
        _governance = newGovernance;
        emit Events.GovernanceSet(
            msg.sender,
            prevGovernance,
            newGovernance,
            block.timestamp
        );
    }

    function _setProtocolFeeAddress(address newProtocolFeeAddress) internal {
        address preProtocolFeeAddress = _protocolFeeAddress;
        _protocolFeeAddress = newProtocolFeeAddress;
        emit Events.ProcotolFeeAddressSet(
            msg.sender,
            preProtocolFeeAddress,
            newProtocolFeeAddress,
            block.timestamp
        );
    }

    function _validateCallerIsGovernance() internal view {
        if (msg.sender != _governance) revert Errors.NotGovernance();
    }

    function _setState(DataTypes.TomoV2EntryPointState newState) internal {
        DataTypes.TomoV2EntryPointState prevState = _state;
        _state = newState;
        emit Events.StateSet(msg.sender, prevState, newState, block.timestamp);
    }

    function getRevision() internal pure virtual override returns (uint256) {
        return REVISION;
    }

    function _validateNotPaused() internal view {
        if (_state == DataTypes.TomoV2EntryPointState.Paused)
            revert Errors.Paused();
    }
}
