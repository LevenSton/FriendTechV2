// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;
import {DataTypes} from "../libraries/DataTypes.sol";

/**
 * @title ITomoV2EntryPoint
 * @author Tomo Protocol
 *
 * @notice This is the entrypoint contract for the TomoV2 contract, the main entry point for Create/Buy/Sell Key.
 * You'll find all the events and external functions, as well as the reasoning behind them here.
 */
interface ITomoV2EntryPoint {
    /**
     * @notice initialize smart contract.
     * @param governanceContractAddress The governance address to set.
     * @param protocolFeeAddress The protocol fee address to set.
     */
    function initialize(
        address governanceContractAddress,
        address protocolFeeAddress
    ) external;

    /**
     * @notice set new governance address
     *
     * @param newGovernance new address
     */
    function setGovernance(address newGovernance) external;

    /**
     * @notice set new protocol fee address
     *
     * @param newProtocolFeeAddress new fee address
     */
    function setProtocolFeeAddress(address newProtocolFeeAddress) external;

    /**
     * @notice set new state of TomoHubEntryPoint
     *
     * @param newState new state
     */
    function setState(DataTypes.TomoV2EntryPointState newState) external;
}
