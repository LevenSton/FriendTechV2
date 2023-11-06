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
     * @notice Initial curve when initial subject.
     *
     * @param subjectAddress Address of subject
     * @param data the initial data for curve
     */
    function initializeCurveModule(
        address subjectAddress,
        bytes calldata data
    ) external returns (bytes memory);

    /**
     * @notice Check if can buy success from the rule of curve.
     *
     * @param subjectAddress Address of subject
     * @param amount the buy amount
     * @param msgValue the eth amount user used to buy
     */
    function processBuy(
        address subjectAddress,
        uint256 amount,
        uint256 msgValue
    ) external returns (uint256, uint256, uint256, uint256);

    /**
     * @notice Check if can sell success from the rule of curve.
     *
     * @param subjectAddress Address of subject
     * @param amount the buy amount
     */
    function processSell(
        address subjectAddress,
        uint256 amount
    ) external returns (uint256, uint256, uint256);

    /**
     * @notice return if key can transfer or not.
     */
    function processTransfer() external returns (bool);

    /**
     * @notice get the price of buy amount key
     *
     * @param subjectAddress Address of subject
     * @param amount buy amount
     */
    function getBuyPrice(
        address subjectAddress,
        uint256 amount
    ) external returns (uint256);

    /**
     * @notice get the price of sell amount key
     *
     * @param subjectAddress Address of subject
     * @param amount sell amount
     */
    function getSellPrice(
        address subjectAddress,
        uint256 amount
    ) external returns (uint256);

    /**
     * @notice set a new subscribe price by subject owner. only support const curve module
     *
     * @param subjectAddress Address of subject
     * @param price the new price
     */
    function setSubPrice(address subjectAddress, uint256 price) external;

    /**
     * @notice set customize fee percent for KOL, only can be called from TomoV2 contract
     *
     * @param subjectAddress Address of subject
     * @param newProtocolFeePercent the new protocol fee percent
     * @param newSubjectFeePercent the new subject fee percent
     */
    function setCustomizeFeePercent(
        address subjectAddress,
        uint256 newProtocolFeePercent,
        uint256 newSubjectFeePercent
    ) external;

    /**
     * @notice set normal fee percent for users
     *
     * @param newProtocolFeePercent the new protocol fee percent
     * @param newSubjectFeePercent the new subject fee percent
     */
    function setFeePercent(
        uint256 newProtocolFeePercent,
        uint256 newSubjectFeePercent
    ) external;
}
