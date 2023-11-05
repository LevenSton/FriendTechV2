// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import {ICurveModule} from "../../interfaces/ICurveModule.sol";
import {ModuleBase} from "../base/ModuleBase.sol";
import {Errors} from "../../libraries/Errors.sol";

struct ConstCurveData {
    uint256 price;
    uint256 timePeriod;
    uint256 supply;
}

contract ConstCurveModule is ModuleBase, ICurveModule {
    mapping(address => ConstCurveData) internal _dataConstCurveBySubjectAddress;

    constructor(address tomoV2) ModuleBase(tomoV2) {}

    function initializeCurveModule(
        address subjectAddress,
        bytes calldata data
    ) external override onlyTomoV2 returns (bytes memory) {
        (uint256 price, uint256 timePeriod) = abi.decode(
            data,
            (uint256, uint256)
        );
        _dataConstCurveBySubjectAddress[subjectAddress] = ConstCurveData(
            price,
            timePeriod,
            0
        );
        return data;
    }

    function processBuy(
        address subjectAddress,
        uint256 amount,
        uint256 msgValue
    ) external override onlyTomoV2 returns (uint256) {
        if (
            msgValue <
            _dataConstCurveBySubjectAddress[subjectAddress].price * amount
        ) revert Errors.MsgValueNotEnough();
        _dataConstCurveBySubjectAddress[subjectAddress].supply += amount;
        return _dataConstCurveBySubjectAddress[subjectAddress].price * amount;
    }

    function processSell(
        address subjectAddress,
        uint256 amount
    ) external override onlyTomoV2 {
        _dataConstCurveBySubjectAddress[subjectAddress].supply -= amount;
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
