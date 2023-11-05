// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import {VersionedInitializable} from "../upgradeablity/VersionedInitializable.sol";
import {TomoV2Base} from "./base/TomoV2Base.sol";
import {ICurveModule} from "../interfaces/ICurveModule.sol";
import {ITomoV2} from "../interfaces/ITomoV2.sol";
import {TomoV2Storage} from "./storage/TomoV2Storage.sol";
import {DataTypes} from "../libraries/DataTypes.sol";
import {Clones} from "@openzeppelin/contracts/proxy/Clones.sol";
import {Errors} from "../libraries/Errors.sol";
import {Events} from "../libraries/Events.sol";

contract TomoV2 is TomoV2Base, VersionedInitializable, TomoV2Storage, ITomoV2 {
    uint256 internal constant REVISION = 1;

    modifier onlyGov() {
        _validateCallerIsGovernance();
        _;
    }

    modifier whenNotPaused() {
        _validateNotPaused();
        _;
    }

    /// @inheritdoc ITomoV2
    function initialize(
        address governanceContractAddress,
        address protocolFeeAddress,
        address tomoSignAddress
    ) external override initializer {
        _setState(DataTypes.TomoV2EntryPointState.Paused);
        _setGovernance(governanceContractAddress);
        _setProtocolFeeAddress(protocolFeeAddress);
        _setTomoSignAddress(tomoSignAddress);
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

    function setTomoSignAddress(
        address newTomoSignAddress
    ) external override onlyGov {
        _setTomoSignAddress(newTomoSignAddress);
    }

    function setState(
        DataTypes.TomoV2EntryPointState newState
    ) external override onlyGov {
        _setState(newState);
    }

    function whitelistCurveModule(
        address curveModule,
        bool whitelist
    ) external override onlyGov {
        _curveModuleWhitelisted[curveModule] = whitelist;
        emit Events.CurveModuleWhitelisted(
            curveModule,
            whitelist,
            block.timestamp
        );
    }

    /// ****************************
    /// *****EXTERNAL FUNCTIONS***
    /// ****************************

    function initialSubject(
        DataTypes.InitialSubjectData calldata vars
    ) external override whenNotPaused {
        if (!_curveModuleWhitelisted[vars.curveModule])
            revert Errors.CurveModuleNotWhitelisted();
        if (_keySubjectInfo[msg.sender].curveModule != address(0))
            revert Errors.SubjectAlreadyInitial();
        _keySubjectInfo[msg.sender].curveModule = vars.curveModule;
        ICurveModule(vars.curveModule).initializeCurveModule(
            msg.sender,
            vars.curveModuleInitData
        );
    }

    function buyKey(
        DataTypes.BuyKeyData calldata vars
    ) external payable override whenNotPaused {
        if (_keySubjectInfo[msg.sender].curveModule == address(0))
            revert Errors.SubjectNotInitial();
        //check if can buy from corresponding curve module contract
        ICurveModule(_keySubjectInfo[vars.keySubject].curveModule).processBuy(
            vars.keySubject,
            vars.amount,
            msg.value
        );
        _keySubjectInfo[vars.keySubject].supply += vars.amount;
        _keySubjectInfo[vars.keySubject].balanceOf[msg.sender] += vars.amount;
    }

    function sellKey(
        DataTypes.SellKeyData calldata vars
    ) external override whenNotPaused {
        if (_keySubjectInfo[msg.sender].curveModule == address(0))
            revert Errors.SubjectNotInitial();
        if (
            _keySubjectInfo[vars.keySubject].balanceOf[msg.sender] < vars.amount
        ) revert Errors.InsufficientKeyAmount();

        //check if can sell from corresponding curve module contract
        ICurveModule(_keySubjectInfo[vars.keySubject].curveModule).processSell(
            vars.keySubject,
            vars.amount
        );
        _keySubjectInfo[vars.keySubject].supply -= vars.amount;
        _keySubjectInfo[vars.keySubject].balanceOf[msg.sender] -= vars.amount;
        if (_keySubjectInfo[vars.keySubject].balanceOf[msg.sender] == 0)
            delete _keySubjectInfo[vars.keySubject].balanceOf[msg.sender];
    }

    /// ****************************
    /// *****QUERY VIEW FUNCTIONS***
    /// ****************************

    function getDomainSeparator() external view override returns (bytes32) {
        return _calculateDomainSeparator();
    }

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

    function _setTomoSignAddress(address newTomoSignAddress) internal {
        address preTomoSignAddress = _tomoSignAddress;
        _tomoSignAddress = newTomoSignAddress;
        emit Events.TomoSignAddressSet(
            msg.sender,
            preTomoSignAddress,
            newTomoSignAddress,
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
