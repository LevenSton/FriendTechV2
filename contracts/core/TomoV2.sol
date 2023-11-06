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
    uint256 internal constant BPS_MAX = 10000;
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

    /// @inheritdoc ITomoV2
    function setGovernance(address newGovernance) external override onlyGov {
        _setGovernance(newGovernance);
    }

    /// @inheritdoc ITomoV2
    function setProtocolFeeAddress(
        address newProtocolFeeAddress
    ) external override onlyGov {
        _setProtocolFeeAddress(newProtocolFeeAddress);
    }

    /// @inheritdoc ITomoV2
    function setTomoSignAddress(
        address newTomoSignAddress
    ) external override onlyGov {
        _setTomoSignAddress(newTomoSignAddress);
    }

    /// @inheritdoc ITomoV2
    function setState(
        DataTypes.TomoV2EntryPointState newState
    ) external override onlyGov {
        _setState(newState);
    }

    /// @inheritdoc ITomoV2
    function whitelistCurveModule(
        address curveModule,
        bool whitelist
    ) external override onlyGov {
        _whitelistCurveModule(curveModule, whitelist);
    }

    /// @inheritdoc ITomoV2
    function setCurveFeePercent(
        address curveModuleAddress,
        uint256 newProtocolFeePercent,
        uint256 newSubjectFeePercent
    ) external override onlyGov {
        if (!_curveModuleWhitelisted[curveModuleAddress])
            revert Errors.CurveModuleNotWhitelisted();
        if (newProtocolFeePercent > 1000 || newSubjectFeePercent > 1000)
            revert Errors.FeePercentTooHigh();
        ICurveModule(curveModuleAddress).setFeePercent(
            newProtocolFeePercent,
            newSubjectFeePercent
        );
    }

    /// @inheritdoc ITomoV2
    function setCustomizeFeePercent(
        address curveModuleAddress,
        address subjectAddress,
        uint256 newProtocolFeePercent,
        uint256 newSubjectFeePercent
    ) external override onlyGov {
        if (!_curveModuleWhitelisted[curveModuleAddress])
            revert Errors.CurveModuleNotWhitelisted();
        if (newProtocolFeePercent > 1000 || newSubjectFeePercent > 1000)
            revert Errors.FeePercentTooHigh();
        ICurveModule(curveModuleAddress).setCustomizeFeePercent(
            subjectAddress,
            newProtocolFeePercent,
            newSubjectFeePercent
        );
    }

    /// ****************************
    /// *****EXTERNAL FUNCTIONS***
    /// ****************************

    /// @inheritdoc ITomoV2
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

    /// @inheritdoc ITomoV2
    function buyKey(
        DataTypes.BuyKeyData calldata vars
    ) external payable override whenNotPaused {
        if (_keySubjectInfo[msg.sender].curveModule == address(0))
            revert Errors.SubjectNotInitial();

        unchecked {
            _validateRecoveredAddress(
                _calculateDigest(
                    keccak256(
                        abi.encode(
                            BUY_TYPEHASH,
                            vars.keySubject,
                            msg.sender,
                            vars.amount
                        )
                    )
                ),
                _tomoSignAddress,
                vars.sig
            );
        }
        //check if can buy from corresponding curve module contract
        (
            uint256 price,
            uint256 referralRatio,
            uint256 protocolFeePercent,
            uint256 subjectFeePercent
        ) = ICurveModule(_keySubjectInfo[vars.keySubject].curveModule)
                .processBuy(vars.keySubject, vars.amount, msg.value);

        if (msg.value < price) revert Errors.EthValueNotEnough();
        if (price > vars.maxAcceptPrice) revert Errors.ExceedMaxAcceptPrice();
        if (msg.value > price) {
            payable(msg.sender).transfer(msg.value - price);
        }
        _updateFeeAndAmount(
            vars,
            price,
            referralRatio,
            protocolFeePercent,
            subjectFeePercent
        );
        emit Events.TradeKeySuccess(
            msg.sender,
            vars.keySubject,
            vars.referralAddress,
            vars.amount,
            price,
            block.timestamp,
            true
        );
    }

    /// @inheritdoc ITomoV2
    function sellKey(
        DataTypes.SellKeyData calldata vars
    ) external override whenNotPaused {
        if (_keySubjectInfo[vars.keySubject].curveModule == address(0))
            revert Errors.SubjectNotInitial();
        if (
            _keySubjectInfo[vars.keySubject].balanceOf[msg.sender] < vars.amount
        ) revert Errors.InsufficientKeyAmount();

        //check if can sell from corresponding curve module contract
        (
            uint256 price,
            uint256 protocolFeePercent,
            uint256 subjectFeePercent
        ) = ICurveModule(_keySubjectInfo[vars.keySubject].curveModule)
                .processSell(vars.keySubject, vars.amount);

        if (price < vars.minAcceptPrice) revert Errors.LessThanMinAcceptPrice();

        _keySubjectInfo[vars.keySubject].supply -= vars.amount;
        _keySubjectInfo[vars.keySubject].balanceOf[msg.sender] -= vars.amount;
        if (_keySubjectInfo[vars.keySubject].balanceOf[msg.sender] == 0)
            delete _keySubjectInfo[vars.keySubject].balanceOf[msg.sender];

        uint256 protocolFee = (price * protocolFeePercent) / BPS_MAX;
        payable(_protocolFeeAddress).transfer(protocolFee);
        uint256 subjectFee = (price * subjectFeePercent) / BPS_MAX;
        payable(vars.keySubject).transfer(subjectFee);
        uint256 sellValue = price - protocolFee - subjectFee;
        payable(msg.sender).transfer(sellValue);
        emit Events.TradeKeySuccess(
            msg.sender,
            vars.keySubject,
            address(0),
            vars.amount,
            price,
            block.timestamp,
            false
        );
    }

    /// @inheritdoc ITomoV2
    function transferKey(
        DataTypes.TransferKeyData calldata vars
    ) external override whenNotPaused {
        if (_keySubjectInfo[vars.keySubject].curveModule == address(0))
            revert Errors.SubjectNotInitial();
        if (
            _keySubjectInfo[vars.keySubject].balanceOf[msg.sender] < vars.amount
        ) revert Errors.InsufficientKeyAmount();

        bool canTransfer = ICurveModule(
            _keySubjectInfo[vars.keySubject].curveModule
        ).processTransfer();
        if (!canTransfer) revert Errors.TransferNotSupport();

        _keySubjectInfo[vars.keySubject].balanceOf[msg.sender] -= vars.amount;
        _keySubjectInfo[vars.keySubject].balanceOf[vars.to] += vars.amount;
        emit Events.TransferKeySuccess(
            msg.sender,
            vars.to,
            vars.keySubject,
            vars.amount,
            block.timestamp
        );
    }

    /// ****************************
    /// *****QUERY VIEW FUNCTIONS***
    /// ****************************

    /// @inheritdoc ITomoV2
    function getDomainSeparator() external view override returns (bytes32) {
        return _calculateDomainSeparator();
    }

    /// @inheritdoc ITomoV2
    function getSupply(
        address subject
    ) external view override returns (uint256) {
        return _keySubjectInfo[subject].supply;
    }

    /// @inheritdoc ITomoV2
    function balanceOf(
        address subject,
        address holder
    ) external view override returns (uint256) {
        return _keySubjectInfo[subject].balanceOf[holder];
    }

    /// @inheritdoc ITomoV2
    function getCurveModuleAddress(
        address subject
    ) external view override returns (address) {
        return _keySubjectInfo[subject].curveModule;
    }

    /// ****************************
    /// *****INTERNAL FUNCTIONS*****
    /// ****************************

    function _updateFeeAndAmount(
        DataTypes.BuyKeyData calldata vars,
        uint256 price,
        uint256 referralRatio,
        uint256 protocolFeePercent,
        uint256 subjectFeePercent
    ) internal {
        _keySubjectInfo[vars.keySubject].supply += vars.amount;
        _keySubjectInfo[vars.keySubject].balanceOf[msg.sender] += vars.amount;

        uint256 protocolFee = (price * protocolFeePercent) / BPS_MAX;
        payable(_protocolFeeAddress).transfer(protocolFee);
        uint256 subjectFee = (price * subjectFeePercent) / BPS_MAX;
        uint256 referralFee = 0;
        if (vars.referralAddress != address(0)) {
            referralFee = (subjectFee * referralRatio) / BPS_MAX;
            payable(vars.referralAddress).transfer(referralFee);
        }
        payable(vars.keySubject).transfer(subjectFee - referralFee);
    }

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

    function _whitelistCurveModule(
        address curveModule,
        bool whitelist
    ) internal {
        _curveModuleWhitelisted[curveModule] = whitelist;
        emit Events.CurveModuleWhitelisted(
            curveModule,
            whitelist,
            block.timestamp
        );
    }

    function getRevision() internal pure virtual override returns (uint256) {
        return REVISION;
    }

    function _validateNotPaused() internal view {
        if (_state == DataTypes.TomoV2EntryPointState.Paused)
            revert Errors.Paused();
    }
}
