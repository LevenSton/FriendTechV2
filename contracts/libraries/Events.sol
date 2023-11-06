// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

import {DataTypes} from "./DataTypes.sol";

library Events {
    /**
     * @dev Emitted when the governance address is changed. We emit the caller even though it should be the previous
     * governance address, as we cannot guarantee this will always be the case due to upgradeability.
     *
     * @param caller The caller who set the governance address.
     * @param prevGovernance The previous governance address.
     * @param newGovernance The new governance address set.
     * @param timestamp The current block timestamp.
     */
    event GovernanceSet(
        address indexed caller,
        address indexed prevGovernance,
        address indexed newGovernance,
        uint256 timestamp
    );

    event ProcotolFeeAddressSet(
        address indexed caller,
        address indexed prevProcotolFeeAddress,
        address indexed newProcotolFeeAddress,
        uint256 timestamp
    );

    event TomoSignAddressSet(
        address indexed caller,
        address indexed prevTomoSignAddress,
        address indexed newTomoSignAddress,
        uint256 timestamp
    );

    event StateSet(
        address indexed caller,
        DataTypes.TomoV2EntryPointState indexed prevState,
        DataTypes.TomoV2EntryPointState indexed newState,
        uint256 timestamp
    );

    event CurveModuleWhitelisted(
        address indexed curveModule,
        bool whitelist,
        uint256 timestamp
    );

    event ModuleBaseConstructed(address indexed tomoV2, uint256 timestamp);

    event TradeKeySuccess(
        address trader,
        address subjectAddress,
        address referralAddress,
        uint256 amount,
        uint256 price,
        uint256 timestamp,
        bool isBuy
    );
}
