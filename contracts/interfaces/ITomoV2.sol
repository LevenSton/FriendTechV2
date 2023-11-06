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
    function setState(DataTypes.TomoV2State newState) external;

    /**
     * @notice set whitelist curve module address
     *
     * @param curveModule address of curve contract
     * @param whitelist whitelist or not
     */
    function whitelistCurveModule(address curveModule, bool whitelist) external;

    /**
     * @notice change fee percentage of curve contract
     *
     * @param curveModuleAddress address of curve contract
     * @param newProtocolFeePercent new percentage of protocol
     * @param newSubjectFeePercent new percentage of subject
     */
    function setCurveFeePercent(
        address curveModuleAddress,
        uint256 newProtocolFeePercent,
        uint256 newSubjectFeePercent
    ) external;

    /**
     * @notice set customize fee percent for KOL
     *
     * @param curveModuleAddress address of curve contract
     * @param subjectAddress Address of subject
     * @param newProtocolFeePercent the new protocol fee percent
     * @param newSubjectFeePercent the new subject fee percent
     */
    function setCustomizeFeePercent(
        address curveModuleAddress,
        address subjectAddress,
        uint256 newProtocolFeePercent,
        uint256 newSubjectFeePercent
    ) external;

    /// ***********************
    /// *****EXTERNAL FUNCTIONS*****
    /// ***********************

    /**
     * @notice initial subject when user want to jump into tomo
     *
     * @param vars A InitialSubjectData struct containing the following params:
     *      curveModule: The address of curve module contract.
     *      curveModuleInitData: The curve module initialization data, if any.
     */
    function initialSubject(
        DataTypes.InitialSubjectData calldata vars
    ) external;

    /**
     * @notice buy some key of subject
     *
     * @param vars A BuyKeyData struct containing the following params:
     *      keySubject: The address of subject
     *      referralAddress: The address of referral user, if any
     *      amount: buy amount
     *      maxAcceptPrice: The max price user can accept
     *      sig: The sign of tomo sign
     */
    function buyKey(DataTypes.BuyKeyData calldata vars) external payable;

    /**
     * @notice sell some key of subject
     *
     * @param vars A SellKeyData struct containing the following params:
     *      keySubject: The address of subject
     *      amount: sell amount
     *      minAcceptPrice: The min price user can accept
     */
    function sellKey(DataTypes.SellKeyData calldata vars) external;

    /**
     * @notice transfer some key to other user
     *
     * @param vars A TransferKeyData struct containing the following params:
     *      keySubject: The address of subject
     *      to: The address who receive key
     *      amount: The transfer amount
     */
    function transferKey(DataTypes.TransferKeyData calldata vars) external;

    /// ***********************
    /// *****VIEW FUNCTIONS*****
    /// ***********************

    /**
     * @notice get domain separator
     */
    function getDomainSeparator() external view returns (bytes32);

    /**
     * @notice get subject supply
     */
    function getSupply(address subject) external view returns (uint256);

    /**
     * @notice get balance of subject the holder hold
     *
     * @param subject the subject address
     * @param holder the holder address
     */
    function balanceOf(
        address subject,
        address holder
    ) external view returns (uint256);

    /**
     * @notice get curve module address of the subject
     *
     * @param subject the subject address
     */
    function getCurveModuleAddress(
        address subject
    ) external view returns (address);
}
