// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import {DataTypes} from "../libraries/DataTypes.sol";

/**
 * @title ICurveModule
 * @author Tomo Protocol
 *
 * @notice This is base interface contract for all curve module contracts
 */
interface ICurveModule {
    /**
     * @notice initialize smart contract.
     *
     * @param subjectOwner The address of subject
     * @param data The initial data for his curve
     */
    function initializeCurveModule(
        address subjectOwner,
        bytes calldata data
    ) external returns (bytes memory);

    function processBuy(
        address subjectAddress,
        uint256 amount,
        uint256 msgValue
    ) external returns (uint256);

    function processSell(address subjectAddress, uint256 amount) external;

    function getBuyPrice(
        address subjectAddress,
        uint256 amount
    ) external returns (uint256);

    function getSellPrice(
        address subjectAddress,
        uint256 amount
    ) external returns (uint256);
}
