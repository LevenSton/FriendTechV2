// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import {ICurveModule} from "../../interfaces/ICurveModule.sol";
import {ModuleBase} from "../base/ModuleBase.sol";
import {Errors} from "../../libraries/Errors.sol";

struct LinearCurveData {
    uint256 startPrice;
    uint256 multiplier;
    uint256 supply;
    uint256 referralRatio;
}

struct CustomizeFeePercent {
    uint256 customizeProtocolFeePercent;
    uint256 customizeSubjectFeePercent;
}

/**
 * @title LinearCurveModule
 * @author tomo Protocol
 *
 * @notice This is a linear curve contract, the key price increase model according lineae curve.
 */

contract LinearCurveModule is ModuleBase, ICurveModule {
    mapping(address => LinearCurveData)
        internal _dataLinearCurveBySubjectAddress;
    mapping(address => CustomizeFeePercent) internal _customizeFeePercent;

    uint256 protocolFeePercent;
    uint256 subjectFeePercent;

    constructor(address tomoV2) ModuleBase(tomoV2) {
        protocolFeePercent = 500; //5%
        subjectFeePercent = 500; //5%
    }

    function initializeCurveModule(
        address subjectAddress,
        bytes calldata data
    ) external override onlyTomoV2 returns (bytes memory) {
        (uint256 startPrice, uint256 multiplier, uint256 referralRatio) = abi
            .decode(data, (uint256, uint256, uint256));

        if (referralRatio >= 5000) revert Errors.ReferralRatioTooHigh();

        _dataLinearCurveBySubjectAddress[subjectAddress] = LinearCurveData(
            startPrice,
            multiplier,
            0,
            referralRatio
        );
        return data;
    }

    function processBuy(
        address subjectAddress,
        uint256 amount,
        uint256 msgValue
    )
        external
        override
        onlyTomoV2
        returns (uint256, uint256, uint256, uint256)
    {
        uint256 price = _getPrice(
            _dataLinearCurveBySubjectAddress[subjectAddress].startPrice,
            _dataLinearCurveBySubjectAddress[subjectAddress].multiplier,
            _dataLinearCurveBySubjectAddress[subjectAddress].supply,
            amount
        );
        if (msgValue < price) revert Errors.MsgValueNotEnough();
        _dataLinearCurveBySubjectAddress[subjectAddress].supply += amount;

        uint256 retProtoFeePercent = protocolFeePercent;
        uint256 retSubjectFeePercent = subjectFeePercent;
        uint256 customSubjectFeePercent = _customizeFeePercent[subjectAddress]
            .customizeSubjectFeePercent;
        uint256 customProtocolFeePercent = _customizeFeePercent[subjectAddress]
            .customizeProtocolFeePercent;

        if (customSubjectFeePercent != 0 || customProtocolFeePercent != 0) {
            retProtoFeePercent = customProtocolFeePercent;
            retSubjectFeePercent = customSubjectFeePercent;
        }
        return (
            price,
            _dataLinearCurveBySubjectAddress[subjectAddress].referralRatio,
            retProtoFeePercent,
            retSubjectFeePercent
        );
    }

    function processSell(
        address subjectAddress,
        uint256 amount
    ) external override onlyTomoV2 returns (uint256, uint256, uint256) {
        uint256 price = _getPrice(
            _dataLinearCurveBySubjectAddress[subjectAddress].startPrice,
            _dataLinearCurveBySubjectAddress[subjectAddress].multiplier,
            _dataLinearCurveBySubjectAddress[subjectAddress].supply - amount,
            amount
        );
        _dataLinearCurveBySubjectAddress[subjectAddress].supply -= amount;

        uint256 retProtoFeePercent = protocolFeePercent;
        uint256 retSubjectFeePercent = subjectFeePercent;
        uint256 customSubjectFeePercent = _customizeFeePercent[subjectAddress]
            .customizeSubjectFeePercent;
        uint256 customProtocolFeePercent = _customizeFeePercent[subjectAddress]
            .customizeProtocolFeePercent;
        if (customSubjectFeePercent != 0 || customProtocolFeePercent != 0) {
            retProtoFeePercent = customProtocolFeePercent;
            retSubjectFeePercent = customSubjectFeePercent;
        }

        return (price, retProtoFeePercent, retSubjectFeePercent);
    }

    function processTransfer() external pure override returns (bool) {
        return true;
    }

    function setSubPrice(
        address subjectAddress,
        uint256 newPrice
    ) external override onlyTomoV2 {
        revert Errors.NotSupportFunction();
    }

    function setFeePercent(
        uint256 newProtocolFeePercent,
        uint256 newSubjectFeePercent
    ) external override onlyTomoV2 {
        protocolFeePercent = newProtocolFeePercent;
        subjectFeePercent = newSubjectFeePercent;
    }

    function setCustomizeFeePercent(
        address subjectAddress,
        uint256 newProtocolFeePercent,
        uint256 newSubjectFeePercent
    ) external override onlyTomoV2 {
        _customizeFeePercent[subjectAddress] = CustomizeFeePercent(
            newProtocolFeePercent,
            newSubjectFeePercent
        );
    }

    function getBuyPrice(
        address subjectAddress,
        uint256 amount
    ) external view override returns (uint256) {
        return
            _getPrice(
                _dataLinearCurveBySubjectAddress[subjectAddress].startPrice,
                _dataLinearCurveBySubjectAddress[subjectAddress].multiplier,
                _dataLinearCurveBySubjectAddress[subjectAddress].supply,
                amount
            );
    }

    function getSellPrice(
        address subjectAddress,
        uint256 amount
    ) external view override returns (uint256) {
        return
            _getPrice(
                _dataLinearCurveBySubjectAddress[subjectAddress].startPrice,
                _dataLinearCurveBySubjectAddress[subjectAddress].multiplier,
                _dataLinearCurveBySubjectAddress[subjectAddress].supply -
                    amount,
                amount
            );
    }

    function _getPrice(
        uint256 startPrice,
        uint256 multiplier,
        uint256 supply,
        uint256 amount
    ) private pure returns (uint256) {
        return
            (startPrice * amount) +
            (amount * multiplier * supply) +
            ((amount + 1) * amount * multiplier) /
            2;
    }
}
