// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

/**
 * @title DataTypes
 * @author Tomo Protocol
 *
 * @notice A standard library of data types used throughout the TomoFragment.
 */
library DataTypes {
    enum TomoV2EntryPointState {
        Open,
        Paused
    }
    /**
     * @notice A struct containing the necessary information to reconstruct an EIP-712 typed data signature.
     *
     * @param v The signature's recovery parameter.
     * @param r The signature's r parameter.
     * @param s The signature's s parameter
     */
    struct EIP712Signature {
        uint8 v;
        bytes32 r;
        bytes32 s;
    }

    struct InitialSubjectData {
        address curveModule;
        bytes curveModuleInitData;
    }

    struct SubjectInfo {
        uint256 supply; //total supply
        address curveModule; //curveModule address
        mapping(address => uint256) balanceOf; //holder -> balance
    }

    struct BuyKeyData {
        address keySubject;
        address referralAddress;
        uint256 amount;
        uint256 maxAcceptPrice;
        EIP712Signature sig;
    }

    struct SellKeyData {
        address keySubject;
        uint256 amount;
        uint256 minAcceptPrice;
    }
}
