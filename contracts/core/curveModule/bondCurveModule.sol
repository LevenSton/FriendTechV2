// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import {ICurveModule} from "../../interfaces/ICurveModule.sol";
import {ModuleBase} from "../base/ModuleBase.sol";
import {Errors} from "../../libraries/Errors.sol";

struct BondCurveData {
    uint256 supply;
    uint256 referralRatio;
}

/**
 * @title BondCurveModule
 * @author tomo Protocol
 *
 * @notice This is a bonding curve contract, the key price increase model according bond curve.
 */

contract BondCurveModule is ModuleBase, ICurveModule {
    mapping(address => BondCurveData) internal _dataBondCurveBySubjectAddress;

    uint256 protocolFeePercent;
    uint256 subjectFeePercent;

    constructor(address tomoV2) ModuleBase(tomoV2) {
        protocolFeePercent = 500; // 5%
        subjectFeePercent = 500; // 5%
    }

    function initializeCurveModule(
        address subjectAddress,
        bytes calldata data
    ) external override onlyTomoV2 returns (bytes memory) {
        uint256 referralRatio = abi.decode(data, (uint256));
        if (referralRatio >= 5000) revert Errors.ReferralRatioTooHigh();

        _dataBondCurveBySubjectAddress[subjectAddress] = BondCurveData(
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
            _dataBondCurveBySubjectAddress[subjectAddress].supply,
            amount
        );
        if (msgValue < price) revert Errors.MsgValueNotEnough();
        _dataBondCurveBySubjectAddress[subjectAddress].supply += amount;
        return (
            price,
            _dataBondCurveBySubjectAddress[subjectAddress].referralRatio,
            protocolFeePercent,
            subjectFeePercent
        );
    }

    function processSell(
        address subjectAddress,
        uint256 amount
    ) external override onlyTomoV2 returns (uint256, uint256, uint256) {
        uint256 price = _getPrice(
            _dataBondCurveBySubjectAddress[subjectAddress].supply - amount,
            amount
        );
        _dataBondCurveBySubjectAddress[subjectAddress].supply -= amount;
        return (price, protocolFeePercent, subjectFeePercent);
    }

    function setSubPrice(
        address subjectAddress,
        uint256 price
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

    function getBuyPrice(
        address subjectAddress,
        uint256 amount
    ) external view override returns (uint256) {
        return
            _getPrice(
                _dataBondCurveBySubjectAddress[subjectAddress].supply,
                amount
            );
    }

    function getSellPrice(
        address subjectAddress,
        uint256 amount
    ) external view override returns (uint256) {
        return
            _getPrice(
                _dataBondCurveBySubjectAddress[subjectAddress].supply - amount,
                amount
            );
    }

    function _getPrice(
        uint256 supply,
        uint256 amount
    ) private pure returns (uint256) {
        uint256 sum1 = (supply * (supply + 1) * (2 * supply + 1)) / 6;
        uint256 sum2 = ((supply + amount) *
            (supply + 1 + amount) *
            (2 * (supply + amount) + 1)) / 6;
        uint256 summation = sum2 - sum1;
        return (summation * 1 ether) / 43370;
    }
}
