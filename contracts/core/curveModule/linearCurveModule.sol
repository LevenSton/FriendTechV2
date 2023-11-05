// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import {ICurveModule} from "../../interfaces/ICurveModule.sol";
import {ModuleBase} from "../base/ModuleBase.sol";
import {Errors} from "../../libraries/Errors.sol";

struct LinearCurveData {
    uint256 startPrice;
    uint256 multiplier;
    uint256 supply;
}

contract ConstCurveModule is ModuleBase, ICurveModule {
    mapping(address => LinearCurveData)
        internal _dataLinearCurveBySubjectAddress;

    constructor(address tomoV2) ModuleBase(tomoV2) {}

    function initializeCurveModule(
        address subjectAddress,
        bytes calldata data
    ) external override onlyTomoV2 returns (bytes memory) {
        (uint256 startPrice, uint256 multiplier) = abi.decode(
            data,
            (uint256, uint256)
        );
        _dataLinearCurveBySubjectAddress[subjectAddress] = LinearCurveData(
            startPrice,
            multiplier,
            0
        );
        return data;
    }

    function processBuy(
        address subjectAddress,
        uint256 amount,
        uint256 msgValue
    ) external override onlyTomoV2 returns (uint256) {}

    function processSell(
        address subjectAddress,
        uint256 amount
    ) external override onlyTomoV2 {}

    function getBuyPrice(
        address subjectAddress,
        uint256 amount
    ) external view override returns (uint256) {
        return 0;
    }

    function getSellPrice(
        address subjectAddress,
        uint256 amount
    ) external view override returns (uint256) {
        //can't sell
        return 0;
    }
}
