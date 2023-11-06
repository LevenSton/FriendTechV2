// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;
import {DataTypes} from "../libraries/DataTypes.sol";

/**
 * @title ITomoV2
 * @author Tomo Protocol
 *
 * @notice This is the entrypoint contract for the TomoV2 contract, the main entry point for Create/Buy/Sell Key.
 * You'll find all the events and external functions, as well as the reasoning behind them here.
 */
interface ITomoV2 {
    /**
     * @notice initialize smart contract.
     * @param governanceContractAddress The governance address to set.
     * @param protocolFeeAddress The protocol fee address to set.
     * @param tomoSignAddress The sign address of tomo.
     */
    function initialize(
        address governanceContractAddress,
        address protocolFeeAddress,
        address tomoSignAddress
    ) external;

    /// ***********************
    /// *****GOV FUNCTIONS*****
    /// ***********************

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
     * @notice set new tomo sign fee address
     *
     * @param newTomoSignAddress new tomo-sign address
     */
    function setTomoSignAddress(address newTomoSignAddress) external;

    /**
     * @notice set new state of TomoHubEntryPoint
     *
     * @param newState new state
     */
    function setState(DataTypes.TomoV2EntryPointState newState) external;

    function whitelistCurveModule(address curveModule, bool whitelist) external;

    function setCurveFeePercent(
        address curveModuleAddress,
        uint256 newProtocolFeePercent,
        uint256 newSubjectFeePercent
    ) external;

    function setCustomizeFeePercent(
        address curveModuleAddress,
        address subjectAddress,
        uint256 newProtocolFeePercent,
        uint256 newSubjectFeePercent
    ) external;

    /// ***********************
    /// *****EXTERNAL FUNCTIONS*****
    /// ***********************

    function initialSubject(
        DataTypes.InitialSubjectData calldata vars
    ) external;

    function buyKey(DataTypes.BuyKeyData calldata vars) external payable;

    function sellKey(DataTypes.SellKeyData calldata vars) external;

    function transferKey(DataTypes.TransferKeyData calldata vars) external;

    /// ***********************
    /// *****VIEW FUNCTIONS*****
    /// ***********************
    function getDomainSeparator() external view returns (bytes32);
}
