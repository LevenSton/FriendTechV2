// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import {ICurveModule} from "../../interfaces/ICurveModule.sol";
import {ModuleBase} from "../base/ModuleBase.sol";
import {Errors} from "../../libraries/Errors.sol";

struct ConstCurveData {
    uint256 price;
    uint256 timePeriod;
    uint256 supply;
    uint256 referralRatio;
}

/**
 * @title ConstCurveModule
 * @author tomo Protocol
 *
 * @notice This is a const curve contract, the key price is fixed.
 */
contract ConstCurveModule is ModuleBase, ICurveModule {
    mapping(address => ConstCurveData) internal _dataConstCurveBySubjectAddress;

    uint256 protocolFeePercent;
    uint256 subjectFeePercent;

    constructor(address tomoV2) ModuleBase(tomoV2) {
        protocolFeePercent = 2000; //20%
        subjectFeePercent = 8000; //80%
    }

    function initializeCurveModule(
        address subjectAddress,
        bytes calldata data
    ) external override onlyTomoV2 returns (bytes memory) {
        (uint256 price, uint256 timePeriod, uint256 referralRatio) = abi.decode(
            data,
            (uint256, uint256, uint256)
        );
        if (referralRatio >= 5000) revert Errors.ReferralRatioTooHigh();

        _dataConstCurveBySubjectAddress[subjectAddress] = ConstCurveData(
            price,
            timePeriod,
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
        if (
            msgValue <
            _dataConstCurveBySubjectAddress[subjectAddress].price * amount
        ) revert Errors.MsgValueNotEnough();
        _dataConstCurveBySubjectAddress[subjectAddress].supply += amount;
        return (
            _dataConstCurveBySubjectAddress[subjectAddress].price * amount,
            _dataConstCurveBySubjectAddress[subjectAddress].referralRatio,
            protocolFeePercent,
            subjectFeePercent
        );
    }

    function processSell(
        address subjectAddress,
        uint256 amount
    ) external override onlyTomoV2 returns (uint256, uint256, uint256) {
        revert Errors.ConstCurveCanSell();
    }

    function setSubPrice(
        address subjectAddress,
        uint256 newPrice
    ) external override onlyTomoV2 {
        _dataConstCurveBySubjectAddress[subjectAddress].price = newPrice;
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
        return _dataConstCurveBySubjectAddress[subjectAddress].price * amount;
    }

    function getSellPrice(
        address subjectAddress,
        uint256 amount
    ) external view override returns (uint256) {
        //can't sell
        return 0;
    }
}
