// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

import {Errors} from "../../libraries/Errors.sol";
import {Events} from "../../libraries/Events.sol";

abstract contract ModuleBase {
    address public immutable TOMOV2;

    modifier onlyTomoV2() {
        if (msg.sender != TOMOV2) revert Errors.NotTomoV2();
        _;
    }

    constructor(address tomoV2) {
        if (tomoV2 == address(0)) revert Errors.InitParamsInvalid();
        TOMOV2 = tomoV2;
        emit Events.ModuleBaseConstructed(tomoV2, block.timestamp);
    }
}
