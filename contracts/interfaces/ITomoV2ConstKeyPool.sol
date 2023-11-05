// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

/**
 * @title ITomoV2CurveKeyPool
 * @author Tomo Protocol
 *
 * @notice
 */
interface ITomoV2ConstKeyPool {
    /**
     * @notice initialize smart contract.
     * @param governanceContractAddress The governance address to set.
     * @param protocolFeeAddress The protocol fee address to set.
     */
    function initialize(
        address governanceContractAddress,
        address protocolFeeAddress
    ) external;
}
